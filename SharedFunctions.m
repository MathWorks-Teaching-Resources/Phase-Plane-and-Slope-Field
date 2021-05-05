classdef SharedFunctions
    %SHAREDFUNCTIONS Functions shared by ODE apps
    %   Some of the functionality, like the discrete ODE solvers or
    %   Newton's method are used by both the Slope Field and Phase
    %   Plane apps. 
    % 
    %   Shared functions are written here as static methods and used by the
    %   apps. Note that the apps will fail if this file is not on the
    %   MATLAB Search Path.
    %
    % Copyright 2021 The MathWorks, Inc. 

    methods(Static)
        
        %------------------- FIELD CALCULATIONS/DISPLAY ------------------%      
        function quiverHandle = orientationQuiver(axisHandle,x,y,vx,vy,scale,...
                dataAspectRatio,plotBoxAspectRatio,quiverColor)
            % Set the axis limits and figure size BEFORE calling this function
            % as it determines the scaling based on the current axes
            % Compute the size
            arx = dataAspectRatio(1)./plotBoxAspectRatio(1);
            ary = dataAspectRatio(2)./plotBoxAspectRatio(2);
            mags = sqrt(vx.^2 + vy.^2);
            vx = vx./mags;
            vy = vy./mags;
            nv = sqrt( (vx.*ary).^2 + (vy.*arx).^2 );
            % Generate quiver on requested axes
            quiverHandle = quiver(axisHandle,x,y,vx./nv,vy./nv,scale*0.5,"color",quiverColor);
        end
        
        function fieldHandle = updateArrows(axisHandle,odeFuncCell,...
                xmin,xmax,ymin,ymax,fieldDensity,scale,quiverColor,Ntick,orientationOnlySwitch)
            % This function generates the phase plane quivers

            % Pull values
            dataAspectRatio = axisHandle.DataAspectRatio;
            plotBoxAspectRatio = axisHandle.PlotBoxAspectRatio;
            
            %compute spacing
            Ny = fieldDensity;
            Nx = Ny/plotBoxAspectRatio(2); 
            dx = abs(xmax - xmin);
            xs = xmin + dx/Nx.^1.5;
            xf = xmax - dx/Nx.^1.5;
            dydt = ymax - ymin;
            ys = ymin + dydt/Ny.^1.5;
            yf = ymax - dydt/Ny.^1.5;
            % Vector of locations of quiver arrows
            x = linspace(xs,xf,Nx);
            y = linspace(ys,yf,Ny);

            % Fixed axis ticks and corresponding labels
            xTick = linspace(xmin,xmax,Ntick+2);
            yTick = linspace(ymin,ymax,Ntick+2);
            axisHandle.XTick = xTick;
            axisHandle.YTick = yTick;  
            xTickLabel = strsplit(num2str(xTick,2));
            yTickLabel = strsplit(num2str(yTick,2));
            axisHandle.XTickLabel = xTickLabel;
            axisHandle.YTickLabel = yTickLabel;

            % Now generate the quivers on a 2D mesh
            [X,Y] = meshgrid(x,y);
            % Evaluate the function
            dYplane = odeFuncCell(X,Y);
            dxdt = dYplane{1};
            dydt = dYplane{2};
            % In case either dxdt or dydt are constants multiply by
            % ones array of correct size
            dxdt = dxdt.*ones(size(X));
            dydt = dydt.*ones(size(X));
            dxyVec = cat(3,dxdt,dydt);

            % Generate the quiver plot
            hold(axisHandle,"on")
            if(orientationOnlySwitch)
                fieldHandle = SharedFunctions.orientationQuiver(axisHandle,X,Y,dxyVec(:,:,1),...
                    dxyVec(:,:,2),scale,dataAspectRatio,plotBoxAspectRatio,quiverColor);
            else
                fieldHandle = quiver(axisHandle,X,Y,dxyVec(:,:,1),dxyVec(:,:,2),...
                    scale,"color",quiverColor);
            end
            hold(axisHandle,"off")

        end    
        
        % Isocline functions
        function [plotHandles,labelHandles] = autoGenerateIsoclines(xmin,xmax,ymin,ymax,...
                Ngrid,odeFuncCell,UIAxes,lineColor,lineWidth,messageArea,...
                minPoints,rmPoints,textColor,fontsize,numSpec)
            % Auto generation
            plotHandles = {};
            labelHandles = {};
            try 
                % Request the number of isoclines to plot
                prompt = "How many isoclines do you want to generate (type an integer)?";
                title = "Isoclines generator";
                Nstring = inputdlg(prompt,title,[1 60],"");
                Nlevels = str2double(Nstring{1});
                if(~(mod(Nlevels,1)==0))
                    error("Invalid input. Enter an integer.")
                end  
                % Generate a grid for the isoclines
                [m1,m2,X,Y] = SharedFunctions.generateIsoclineGrid(xmin,...
                    xmax,ymin,ymax,Ngrid,odeFuncCell);
                % Create the bins
                [m1,levels1] = SharedFunctions.createLevelsBin(m1,Nlevels);
                [m2,levels2] = SharedFunctions.createLevelsBin(m2,Nlevels);

                % Generate the isoclines
                [plotHandles1,labelHandles1] = SharedFunctions.plotIsoclineLevels...
                    (X,Y,m1,levels1,UIAxes,lineColor,lineWidth,false,minPoints,rmPoints,...
                    textColor,fontsize,numSpec);
                [plotHandles2,labelHandles2] = SharedFunctions.plotIsoclineLevels...
                    (X,Y,m2,levels2,UIAxes,lineColor,lineWidth,true,minPoints,rmPoints,...
                    textColor,fontsize,numSpec);
                plotHandles = [plotHandles1,plotHandles2];
                labelHandles = [labelHandles1,labelHandles2];
            catch ME
                message = "Autogeneration of isoclines failed due to:" ...
                    +newline+ME.message;
                SharedFunctions.displayMessage(message,2,messageArea);
            end
        end
        
        function [plotHandles,labelHandles] = generateIsoclineThroughPoint(location,xmin,xmax,...
                ymin,ymax,Ngrid,odeFuncCell,UIAxes,lineColor,lineWidth,messageArea,...
                minPoints,rmPoints,textColor,fontsize,numSpec)
            plotHandles = {};
            labelHandles = {};
             % Create isoclines based on given point
            try 
                % Get location
                x0 = location(1);
                y0 = location(2);
                % Pull ODE func
                dY0 = odeFuncCell(x0,y0);
                dxdt = dY0{1};
                dydt = dY0{2};
                level = dydt/dxdt;
                % Invert the level if necessary
                if( abs(level)<1 )
                    levels1 = level;
                    levels2 = [];
                else
                    levels1 = [];
                    levels2 = 1/level;
                end
                       
                % Create the grid
                [m1,m2,X,Y] = SharedFunctions.generateIsoclineGrid(xmin,...
                    xmax,ymin,ymax,Ngrid,odeFuncCell);
                % Generate the isoclines
                [plotHandles1,labelHandles1] = SharedFunctions.plotIsoclineLevels...
                    (X,Y,m1,levels1,UIAxes,lineColor,lineWidth,false,minPoints,rmPoints,...
                    textColor,fontsize,numSpec);
                [plotHandles2,labelHandles2] = SharedFunctions.plotIsoclineLevels...
                    (X,Y,m2,levels2,UIAxes,lineColor,lineWidth,true,minPoints,rmPoints,...
                    textColor,fontsize,numSpec);
                plotHandles = [plotHandles1,plotHandles2];
                labelHandles = [labelHandles1,labelHandles2];
                message = "Drew isocline with m = " + num2str(level,numSpec);
                SharedFunctions.displayMessage(message,0,messageArea);
            catch ME
                message = "Autogeneration of isoclines failed due to:" ...
                    +newline+ME.message;
                SharedFunctions.displayMessage(message,2,messageArea);
            end
        end

        function [plotHandles,labelHandles] = generateIsoclinesFromVector(xmin,xmax,...
                ymin,ymax,Ngrid,odeFuncCell,UIAxes,lineColor,lineWidth,messageArea,...
                minPoints,rmPoints,textColor,fontsize,numSpec)
            % Create isoclines based on given point
            plotHandles = {};
            labelHandles = {};
            try 
                % Request a vector of energy levels
                prompt = "Type a list of levels (m = dy/dx) that you want to draw isoclines for. For example: -2 -1 0 1 3";
                title = "List isoclines";
                Nstring = inputdlg(prompt,title,[1 80],"");
                levels = str2num(Nstring{1});
                levels1 = levels(abs(levels)<=1);
                levels2 = 1./levels(abs(levels)>1);       

                
                % Create the grid
                [m1,m2,X,Y] = SharedFunctions.generateIsoclineGrid(xmin,...
                    xmax,ymin,ymax,Ngrid,odeFuncCell);
                
                [plotHandles1,labelHandles1] = SharedFunctions.plotIsoclineLevels...
                    (X,Y,m1,levels1,UIAxes,lineColor,lineWidth,false,minPoints,rmPoints,...
                    textColor,fontsize,numSpec);
                [plotHandles2,labelHandles2] = SharedFunctions.plotIsoclineLevels...
                    (X,Y,m2,levels2,UIAxes,lineColor,lineWidth,true,minPoints,rmPoints,...
                    textColor,fontsize,numSpec);
                plotHandles = [plotHandles1,plotHandles2];
                labelHandles = [labelHandles1,labelHandles2];
            catch ME
                message = "Isoclines failed to plot because:" ...
                    +newline+ME.message;
                SharedFunctions.displayMessage(message,2,messageArea);
            end
        end
              
        function [m1,m2,X,Y] = generateIsoclineGrid(xmin,xmax,ymin,ymax,...
                Ngrid,odeFuncCell)
            % set up grid
            x = linspace(xmin,xmax,Ngrid);
            y = linspace(ymin,ymax,Ngrid);
            [X,Y] = meshgrid(x,y);
            % Evaluate ODE func
            dYplane = odeFuncCell(X,Y);
            dxdt = dYplane{1};
            dydt = dYplane{2};
            
            % The isoclines are given by slop m where
            % m = dydt/dxdt. These give the energies.
            % Note: in the slope field case these are dxdt/1 and 1/dxdt
            m1 = dydt./dxdt;
            m2 = dxdt./dydt;
            % Throw out unused values
            m1( abs(m1) > 2) = NaN;
            m2( abs(m2) > 2) = NaN;
            
        end
        
        function [m,levels] = createLevelsBin(m,Nlevels)
            % Automatically generates levels for the isoclines
            % Remove unused points
            unusedIdx = isnan(m) | abs(m) > 1;
            mWeight = sum(~unusedIdx ,"all")/numel(m); 
            mvec = m(:);
            mvec(unusedIdx) = []; 
            
            % Now sort into bins
            msort = sort(mvec);
            levels = [];
            NWeightedLevels = ceil(mWeight*Nlevels);
            binWidth = round(numel(msort)/NWeightedLevels) - 1;
            idx = 1:binWidth:numel(msort);
            for k = 1:(length(idx)-1)
                levels(k) = mean(msort(idx(k):idx(k+1)));
            end
        end
        
        function [plotHandles,labelHandles] = plotIsoclineLevels(X,Y,...
                m,levels,UIAxes,lineColor,lineWidth,invFlag,minPoints,rmPoints,...
                textColor,fontsize,numSpec)
      

            % plot handle containers
            plotHandles = {};
            labelHandles = {};
                
            % Generate contours
            if(~isempty(levels))
                if(numel(levels) == 1)
                    levels = [levels levels]; % required by contour
                end
                
                % Compute the contour matrix
                x = X(1,:)';
                y = Y(:,1);
  
                C = contourc(x,y,m,levels);
                % Parse data in C
                lineData = SharedFunctions.parseContourMatrix(C);
        
                hold(UIAxes,"on")
                for m = 1:numel(lineData)        
                    N = lineData(m).N;

                    % Only add label if there are enough points
                    if(N >= minPoints)

                        idx = round(N/2);
                        x = lineData(m).XData(idx);
                        y = lineData(m).YData(idx);

                        idxRemove = (idx-rmPoints):(idx+rmPoints);
                        lineData(m).XData(idxRemove) = NaN;
                        lineData(m).YData(idxRemove) = NaN;
                    
                        % Plot contour lines
                        plotHandles{m} = plot(UIAxes,lineData(m).XData,...
                            lineData(m).YData,'Color',lineColor,'linewidth',lineWidth);

                        if(invFlag)
                            level = 1/lineData(m).level;
                        else
                            level = lineData(m).level;
                        end
                            
                        levelString = num2str(level,numSpec);
                        labelHandles{m} = text(UIAxes,x,y,levelString,"Color",textColor,...
                            "VerticalAlignment","middle","HorizontalAlignment","center","fontsize",fontsize);
                    else
                    
                        % Plot contour lines
                        labelHandles{m} = [];
                        plotHandles{m} = plot(UIAxes,lineData(m).XData,...
                            lineData(m).YData,'Color',lineColor,'linewidth',lineWidth);
                    end
                end
                hold(UIAxes,"off")
            end
        end
        
        
        %------------------------- MATH FUNCTIONS ------------------------%
        function [x,exitFlag] = newtonIteration(x0,f,dx,Nmax,xNorm,fNorm)
            % newtonIteration: Finds zeros of f 
            % x0: initial guess (vector x = {x_i})
            % f: function handle (vector f(x) = {f_i(x)})
            % Nmax: maximum number of iterations
            k = 1;
            x = x0;
            xdiff = xNorm*2;
            fx = fNorm*2;
            exitFlag = 0;
            while ( (norm(xdiff) > xNorm || ...
                     norm(fx) > fNorm ) && k <= Nmax )
                fx = f(x);
                J = SharedFunctions.approximateJacobian(f,fx,x,dx);
                xdiff = J\fx;
                x = x - xdiff;
                k = k+1;
            end
            
            % Indicate if norms were successfully met
            if( norm(xdiff) < xNorm && norm(fx) < fNorm )
                exitFlag = 1;
            end
        end
            
        function J = approximateJacobian(f,fx,x,dx)  
            % Estimates the Jacobian
            % f: function handle
            % fx: value of f at x
            % dx: finite difference approximation stencil size
            % x: location
            N = length(x);
            J = zeros(N,N);
            for k = 1:N
                xdxk = x;
                xdxk(k) = x(k) + dx;
                fdxk = f(xdxk);
                J(:,k) = ( fdxk - fx )./dx;
            end
        end

        function Yp1 = fixedStep(t,Y,f,dt,solver,dxNewton,NMaxNewton,...
            xNormNewton,FNormNewton)
            % Take a fixed step based on the specified numerical method          
            % Take a step based on the info
            if(solver == "Forward Euler")
                Yp1 = Y + dt*f(t,Y);
            elseif(solver == "RK2")
                K1 = dt*f(t,Y);
                K2 = dt*f(t+dt/2,Y+K1/2);
                Yp1 = Y + K2;
            elseif(solver == "RK4")
                K1 = dt*f(t,Y);
                K2 = dt*f(t+dt/2,Y+K1/2);
                K3 = dt*f(t+dt/2,Y+K2/2);
                K4 = dt*f(t+dt,Y+K3);                
                Yp1 = Y + 1/6*K1 + 1/3*K2 + 1/3*K3 + 1/6*K4;
            elseif(solver=="Backward Euler")
                fn = @(Yp1) -Yp1 + Y + dt*f(t+dt,Yp1);  % Function for the Newton's iteration
                [Yp1,~] = SharedFunctions.newtonIteration(Y,fn,dxNewton,...
                    NMaxNewton,xNormNewton,FNormNewton); % Estimate by Newton's iteration
            elseif(solver=="Trapezoid")
                fn = @(Yp1) -Yp1 + Y + 0.5*dt*(f(t,Y) + f(t+dt,Yp1));  % Function for the Newton's iteration
                [Yp1,~] = SharedFunctions.newtonIteration(Y,fn,dxNewton,...
                    NMaxNewton,xNormNewton,FNormNewton); % Estimate by Newton's iteration
            end
            
        end  
        
        
        %---------------------------- Library ----------------------------%
        function saveLibrary(defaultName,userSystems,messageArea)
            % Saves the user library to a MAT file
            try
                prompt = "Name your library";
                title = "Save library";
                name = inputdlg(prompt,title,[1 40],defaultName);
                if( isempty(name) )
                    name = "";
                end
                if(name == "")
                    message = "Library was not saved (you must give the library a name).";
                     SharedFunctions.displayMessage(message,1,messageArea);
                    return
                end
                matFileName = name{1} + ".mat";
               
                % Save to file
                if(isempty(userSystems))
                    message = "Nothing in the custom library. The save file was not created.";
                     SharedFunctions.displayMessage(message,2,messageArea);
                    return
                end
                
                save(matFileName,"userSystems")
                message = "Saved library to '" + matFileName + "'.";
                SharedFunctions.displayMessage(message,-1,messageArea);
            catch ME
                message = "Saving library failed due to:" + newline + ME.message;
                 SharedFunctions.displayMessage(message,1,messageArea);
            end
        end
        
        function userSystems = loadLibrary(defaultName,messageArea)
            % loads a user library from a MAT file
            userSystems = {};
            try
                title = "Select a library MAT file generated by the app.";
                [file,path] = uigetfile("*.mat",title,defaultName + ".mat");
                matFileLoc = [path,filesep,file];
                if(file==0)
                    return
                end
     
                % Load in the new menu
                load(matFileLoc,"userSystems");

                message = "Library loaded from " + file;
                SharedFunctions.displayMessage(message,1,messageArea);
                
            catch ME
                message = "Library load failed due to: " + ME.message ...
                   +  newline + "Make sure to select a MAT file generated by the app." ;
                SharedFunctions.displayMessage(message,1,messageArea);
            end
        end
        
        
        %-------------------------User interaction------------------------%
        function displayMessage(message,errorFlag,messageArea,startPanel)
            % This automatically closes the start box:
            startPanel.Visible = false;
            % errorFlag = 0, regular message
            % errorFlag = 1, warning
            % errorFlag = 2, error
            % errorFlag = 3, error but no animation
            messageArea.Value = message;
            switch errorFlag
                case -1
                    messageArea.FontColor = [0 0 0];
                    messageBGColor = [0.1 0.1 0.8];
                case 0
                    messageArea.FontColor = [0.08,0.12,0.80];
                    messageBGColor = [1 1 1];
                case 1
                    messageArea.FontColor = [0.95,0.5,0];
                    messageBGColor = [1 0.5 0.1];
                case 2
                    messageArea.FontColor = [0.8,0.1,0.1];
                    messageBGColor = [1 0.1 0.1];
                case 3
                    messageArea.FontColor = [0.8,0.1,0.1];
                    messageBGColor = [1 0.1 0.1];
                case 4
                    messageArea.FontColor = [0.95,0.5,0];
                    messageBGColor = [1 0.1 0.1];
            end
            if(errorFlag ~= 0  && errorFlag ~=3 && errorFlag ~=4)
                temp = messageArea.BackgroundColor;
                for k = linspace(0,1,30)
                    messageArea.BackgroundColor = k*temp + (1-k)*messageBGColor;
                    pause(0.005)
                end
                messageArea.BackgroundColor = temp;
            end
        end
        
        
        function location = checkIfInFieldAxis(event,panelHandle,...
                UIAxesHandle,xmin,xmax,ymin,ymax)
            % Identify if inside the field and return location (this axis
            % is inside a panel)
            cp = event.Source.CurrentPoint;
            panelPos = panelHandle.Position;
            axPos =UIAxesHandle.Position;
            axPos = axPos + [panelPos(1:2) 0 0];
            location = NaN; % Return NaN if outside
            if( cp(1) > axPos(1) && cp(1) < axPos(1) + axPos(3) &&...
                cp(2) > axPos(2) && cp(2) < axPos(2) + axPos(4) )
                % If so, update the current position
                loc = get(UIAxesHandle,'CurrentPoint');
                loc = loc(1,1:2);
                if(loc(1)>xmin && loc(1)<xmax && loc(2)>ymin && loc(2)<ymax)
                    location = loc;
                end               
            end
        end
        
             
        function filename = saveImagePopup(fileExt,defaultFilename)
            % Offer a new file name if the default already exists
            defaultInput = defaultFilename;
            k = 1;
            while isfile(defaultInput + fileExt) && k < 100
                defaultInput =  defaultFilename + num2str(k,"%03d");
                k = k+1;
            end
            
            % Open a dialogue for the save location
            [file,path] = uiputfile("*" + fileExt, "Save image", defaultFilename + fileExt);
            filename = [path,file];

        end      
            
        function resizedCallback(src,event,UIFigure,minWidth,minHeight)
        % This function prevents resizing past a minimum point    
            try
                currPos = UIFigure.Position;
                pos = currPos;
                if(currPos(3) < minWidth)
                    pos(3) = minWidth;
                end
                if(currPos(4) < minHeight)
                      pos(4) = minHeight;                  
                end
                set(UIFigure, "position",pos)
                drawnow      
            catch ME
               message = "Error in resizedCallback: "+ ME.message;
               SharedFunctions.displayMessage(message,2,messageArea);
            end
        end
    
        function startupDisplaySize(UIFigure,minWidth,minHeight,verticalBuffer)
            try
                % Get the screen display size
                set(0,'units','pixels');
                screenSize = get(0,'screensize');

                % Make the app smaller if there aren't enough available
                % pixels on the screen
                appSize = UIFigure.Position;
                
                setSize = appSize;
                if(screenSize(3) < appSize(3))
                    setSize(3) = max([screenSize(3),minWidth]); 
                end
                if(screenSize(4) < appSize(4))
                    setSize(4) = max([screenSize(4)-verticalBuffer,minHeight]);
                end
                
                % Place the app in the center of the screen
                diffx = screenSize(3) - setSize(3);
                diffy = screenSize(4) - setSize(4);
                setSize(1) = floor(diffx/2);
                setSize(2) = floor(diffy/2);

                if(setSize(3) >= minWidth && setSize(4) >= minHeight)
                    set(UIFigure,"Position",setSize)
                    drawnow
                end
                
            catch ME
                % What to do otherwise? 
            end
        end
        
        function out = checkParamValue(value,previousValue,messageArea)
            % Try evaluating the parameter and return issue if it fails
            if(isempty(value)) % Okay to just remove it
                out = value;
                return
            end
            try
                eval("pval = num2str(" + value + ");")
            catch ME
                message = "'" + value + "' is not a valid MATLAB parameter expression. " ...
                    + newline + " Please try again.";
                SharedFunctions.displayMessage(message,2,messageArea);
                out = previousValue;
                return
            end
            out = value;
            message = "Value updated successfully to " + out;
            SharedFunctions.displayMessage(message,0,messageArea);
        end
        

        %---------------------------- Utility ----------------------------%
        function clear1DGraphicsCellArray(arrayHandle,messageArea)
           for k=1:numel(arrayHandle)
               try
                   if(~isempty(arrayHandle{k}))
                       delete(arrayHandle{k})
                   end
               catch ME
                   message = "Unable to delete plot object due to: "...
                      + newline + ME.message;
                   SharedFunctions.displayMessage(message,4,messageArea);
               end 
           end
        end
        
        function setUIColorFromHandles(backgroundColor,foregroundColor,handles,textHandles)
            % Loop through handles in the UI tree and change the appearance
            for k = 1:numel(handles)
                % Don't update these controls
                if(  class(handles(k)) == "matlab.ui.control.StateButton" ...
                     || class(handles(k)) == "matlab.ui.control.Button")
                   continue
                end
                if(isprop(handles(k),"FontColor"))
                    handles(k).FontColor = foregroundColor;
                end
                if(isprop(handles(k),"ForegroundColor"))
                    handles(k).ForegroundColor = foregroundColor;
                end
                if(isprop(handles(k),"BackgroundColor"))
                    handles(k).BackgroundColor = backgroundColor;
                end
                % If its a label, set background color to none
                if( class(handles(k)) == "matlab.ui.control.Label" )
                    handles(k).BackgroundColor = "none";
                end
            end
            
            % Text handles are outside the UI tree so set them here
            for k = 1:numel(textHandles)
                textHandles{k}.Color = foregroundColor;
                textHandles{k}.BackgroundColor = "none";
            end
        end
        
        
        function lineData = parseContourMatrix(C)
            % Parses the contour matrix for subsequent plotting
            lineData = struct();
            m = 1;
            k = 1;
            while k < size(C,2)
                numVertices = C(2,k);
                lineData(m).N = numVertices;
                lineData(m).level = C(1,k);
                lineData(m).XData = C(1,k+1:k+numVertices);
                lineData(m).YData = C(2,k+1:k+numVertices);

                k = k+numVertices+1;
                m = m+1;
            end
        end
        
        function [x,y,pHandle] = freedraw(UIFigure,panelHandle,UIAxesHandle,...
                xmin,xmax,ymin,ymax,closed)
            % Allows the user to draw freely
             % Wait until this is done
            
            % Start by removing the original motion/click callbacks(replace
            % them later)
            set(UIFigure,"Pointer","crosshair")
            origMotionFcn = UIFigure.WindowButtonMotionFcn;
            origButtonFcn = UIFigure.WindowButtonDownFcn;

            x = NaN;
            y = NaN;
            areaPlot = [];
            hold(UIAxesHandle,"on")
                pHandle = plot(UIAxesHandle,x,y,'linewidth',2,"color",[0.8,0.4,0.4]);
            hold(UIAxesHandle,"off")
            
            drawing = false;
            
            UIFigure.WindowButtonMotionFcn = @addPoint;
            UIFigure.WindowButtonDownFcn = @clickCallback;
             
            uiwait(UIFigure)
            function clickCallback(object,event)
                % Stop drawing
                if(drawing)
                    % Replace the functions
                    UIFigure.WindowButtonMotionFcn = origMotionFcn;
                    UIFigure.WindowButtonDownFcn = origButtonFcn;      
                    set(UIFigure,"Pointer","Arrow")
                    uiresume(UIFigure)
                    
                    return
                end
                
                % Start drawing
                location = SharedFunctions.checkIfInFieldAxis(event,panelHandle,...
                     UIAxesHandle,xmin,xmax,ymin,ymax);
                if(numel(location) == 2 && ~any(isnan(location)) )
                    x = location(1);
                    y = location(2);
                    pHandle.XData(1) = x;
                    pHandle.YData(1) = y;
                    drawing = true;
                    set(UIFigure,"Pointer","Cross")
                end
            end
            
            function addPoint(object,event)
                if(drawing)
                    location = SharedFunctions.checkIfInFieldAxis(event,panelHandle,...
                     UIAxesHandle,xmin,xmax,ymin,ymax);
                 
                     if(numel(location) == 2 && ~any(isnan(location)) )
                        x = [x;location(1)];
                        y = [y;location(2)];
                        pHandle.XData = x;
                        pHandle.YData = y;
                        
                        if(closed)
                            pHandle.XData = [x;x(1)];
                            pHandle.YData = [y;y(1)];
                        end


                        pause(0);
                     end
                end
            end
        end
        
        
        
    end
end












