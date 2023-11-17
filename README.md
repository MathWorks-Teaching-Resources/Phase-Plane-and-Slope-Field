# Phase Plane and Slope Field

[![View <File Exchange Title> on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/91705-phase-plane-and-slope-field-apps)  or [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Phase-Plane-and-Slope-Field)

You can use the Phase Plane and Slope Field apps to qualitatively analyze ordinary differential equations (ODEs).
<table>
  <tr><td><img src="https://user-images.githubusercontent.com/81383420/117192086-53199680-adaf-11eb-85b0-8fb3898fd99e.png"></img></td><td><img src="https://user-images.githubusercontent.com/81383420/117192143-60cf1c00-adaf-11eb-97f3-f7ae9320ef54.png"></img></td></tr>
  <tr><td><b>Phase Plane app</b>: Analyze two-dimensional autonomous ODE systems.</td><td><b>Slope Field app</b>: Analyze single variable ODEs. </td></tr>
</table>

These apps capture the functionality of the traditional PPlane and DField apps created by John C. Polking in MATLAB between 1995 and 2003 [[1]](#ref1). While similar in function to the original apps, the Slope Field and Phase Plane apps have been written entirely from scratch in MATLAB App Designer using modern MATLAB coding practices. This makes the new apps easier to maintain, edit, and use.

### Latest update: 1.2.0
* Updated to offer both dark mode and light mode for plotting region.
* Removed unused function in Phase Plane app.
* Improved user message when changing the solver field density slider.
* Fixed case choices on slider labels to be consistent with each other.
* Removed ode15i from offered solvers because it is an implicit solver that requires a different equation structure than these apps are designed to study.

### Previous update: 1.1.0
* Updated field arrows with solid arrowheads. These fix the distortion that was visible when the axes were scaled differently.
* Default field color is darker. Also, an option has been added to set a custom field color (in the Appearance menu).
* The solver now allows complex solutions but only plots the real part.
* Added options for the numerical estimation of separatrices.
* Added options to export the field to a figure.

### Related content
* <a href="https://www.mathworks.com/matlabcentral/fileexchange/95513-qualitative-analysis-of-odes">Qualitative Analysis of ODEs</a>: 
an accompanying set of live scripts that teach the basics of qualitative ODE analysis using these apps.

### Acknowledgements
* Thank you to Roy Goodman at NJIT for his support of this project and many insightful suggestions.

## Setup 
### MATLAB&reg;

1. Ensure that you have MATLAB R2021a or newer installed.
2. Download and unzip the entire repository.
3. Double-click each app installer (SlopeField.mlappinstall and PhasePlane.mlappinstall) and follow the installation instructions.
4. Access the apps from the **APPS** tab in the MATLAB toolstrip. Use the dropdown to expand the menu.

### MATLAB Online&trade;
1. [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Phase-Plane-and-Slope-Field)
2. Double-click each app installer (SlopeField.mlappinstall and PhasePlane.mlappinstall) and follow the installation instructions.
3. Access the apps from the **APPS** tab in the MATLAB toolstrip. Use the dropdown to expand the menu.

## Getting Started 

### Tutorial Videos
Learn the basics of the Phase Plane and Slope Field apps in these 3-minute tutorial videos. 

https://user-images.githubusercontent.com/81383420/134724074-25ac1212-2aa7-429b-b93d-550667641cf7.mp4

https://user-images.githubusercontent.com/81383420/134727298-5e0c2e62-4e4b-452d-9371-c61237e395e0.mp4


### Quick Start Guides
As an alternative to the videos, you can use these PDF quick start guides to get up and running quickly.

[<img src="https://user-images.githubusercontent.com/81383420/117190936-01bcd780-adae-11eb-8a53-29b05e7b175d.png" width="300">](https://github.com/MathWorks-Teaching-Resources/Phase-Plane-and-Slope-Field/files/6429294/PhasePlaneQuickStart.pdf) &nbsp; &nbsp;
[<img src="https://user-images.githubusercontent.com/81383420/117191277-60825100-adae-11eb-88eb-99ebe73f23f6.png" width="300">](https://github.com/MathWorks-Teaching-Resources/Phase-Plane-and-Slope-Field/files/6429351/SlopeFieldQuickStart.pdf)

## MathWorks Products
Requires MATLAB release R2021a or newer

## License
The license for the Phase Plane and Slope Field apps is available in the [LICENSE.md](LICENSE.md) file in this GitHub repository.

## Educator Resources ##
* [Featured Courseware](https://www.mathworks.com/academia/courseware/course-materials.html)
* [Teach with MATLAB and Simulink](https://www.mathworks.com/academia/educators.html)
* [MATLAB Grader](https://www.mathworks.com/products/matlab-grader.html)

Find an issue or need help? Email the MathWorks teaching resources team: 
onlineteaching@mathworks.com

If you want to contribute directly to this project, you can find information about how to do so in the [CONTRIBUTING.md](CONTRIBUTING.md) page on GitHub.

<br>

## Full Capabilities: Phase Plane App
The details of the Phase Plane app are documented here for reference. The Phase Plane app has four main areas you can interact with:

<img src="https://user-images.githubusercontent.com/81383420/117191716-e4d4d400-adae-11eb-819e-68d793fcfd15.png" width="600" >


Each of these areas is described below.


### Differential Equation System Panel

![differentialequationsystempanel](https://user-images.githubusercontent.com/81383420/117188975-a38ef500-adab-11eb-9e55-117c351d601e.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Define an ODE system</td>
    <td>Type the two dependent variable names in the first two fields and the ODE expressions in terms of the dependent variables and any parameters you defined.</td>
</tr>
<tr>
    <td>Define a parameter</td>
    <td>Type the name of the parameter in the first field. Type the value in the second field. You can use a valid MATLAB expression, such as log(2), but you cannot use other parameters or variables.</td>
</tr>
<tr>
    <td>Update the phase plane field with the edited ODE system</td>
    <td>Click <b>Update</b></td>
</tr>
<tr>
    <td>Clear the differential equation system and parameter fields</td>
    <td>Click <b>Clear</b></td>
</tr>
<tr>
    <td>Use the default ODE system</td>
    <td>Click <b>Default</b></td>
</tr>
</table>

### Phase Plane Panel
![phaseplanepanel](https://user-images.githubusercontent.com/81383420/117188869-8823ea00-adab-11eb-8d1e-42fef2ca1f73.png)


<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Generate a solution</td>
    <td>Click the phase plane</td>
</tr>
<tr> 
    <td>Delete a solution</td>
    <td>Right-click a solution curve</td>
</tr>
<tr> 
    <td>Highlight a solution</td>
    <td>Left-click a solution curve</td>
</tr>
<tr>
    <td>Remove highlighting</td>
    <td>Left- or right-click a highlighted curve</td>
<tr>
<tr>
    <td>Solve from a numerically defined initial condition</td>
    <td>Set the initial values in the x0 and y0 edit fields. Then press <b>Solve from (x0,y0)</b>.</td>
</tr>
<tr>
    <td>Clear solution curves</td>
    <td>Click <b>Clear solutions</b></td>
</tr>
<tr>
    <td>Show the analysis for an equilibrium point</td>
    <td>Click an equilibrium point (equilibria are generated from the <b>Analysis</b> menu)</td>
</tr>
</table>

### Appearance Tab
![appearancetabpp](https://user-images.githubusercontent.com/81383420/117189258-fb2d6080-adab-11eb-92b0-58e8ad5b72c5.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Change the phase plane horizontal axis limits</td>
    <td>Type values of <b>xmin</b> and <b>xmax</b></td>
</tr>
<tr> 
    <td>Change the phase plane vertical axis limits</td>
    <td>Type values of <b>ymin</b> and <b>ymax</b></td>
</tr>
<tr>
    <td>Change the time series horizontal axis limits</td>
    <td>Type values of <b>tmin</b> and <b>tmax</b></td>
</tr>
<tr> 
    <td>Speed up or slow down the animation</td>
    <td>Move the <b>Animation speed</b> slider</td>
</tr>
<tr> 
    <td>Toggle the time series plots</td>
    <td>Click the <b>Time series</b> checkbox</td>
</tr>
<tr>
    <td>Increase or decrease the widths of solution curves</td>
    <td>Use the spinner or type a new value for <b>Line width</b></td>
<tr>
<tr>
    <td>Increase or decrease the number of field arrows</td>
    <td>Use the spinner or type a new value for <b>Field density</b></td>
</tr>
<tr>
    <td>Increase or decrease the size of the field arrows</td>
    <td>Use the spinner or type a new value for <b>Field scale</b></td>
</tr>
</table>

### Solution Tab
![solutiontabpp](https://user-images.githubusercontent.com/81383420/117189293-07192280-adac-11eb-8232-1d95d3b91e87.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Change the solver time span. The ODE solver will start at t=0 and solve both forward and backward in time based on the defined values.</td>
    <td>Edit the <b>Forward solution tmax</b> and <b>Backward solution tmin</b> fields.</td>
</tr>
<tr>
    <td>Allow the solver to continue beyond the axis limits</td>
    <td>Uncheck <b>Terminate solutions at axis limits</b></td>
</tr>
<tr> 
    <td>Change how many solutions are generated when the <b>Solve from region<b> functionality is used </td>
    <td>Adjust the <b>Solve from region density</b> slider</td>
</tr>
</table>

### Solver Tab
![solvertabpp](https://user-images.githubusercontent.com/81383420/117189312-0ed8c700-adac-11eb-8221-b7aaf5d3e0cb.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Change the variable step ODE solver</td>
    <td>Select a solver from the <b>Solver</b> dropdown</td>
</tr>
<tr> 
    <td>Change the ODE solver relative tolerance</td>
    <td>Enter a new value in the <b>Relative tolerance</b> field</td>
</tr>
<tr> 
    <td>Change the ODE solver absolute tolerance</td>
    <td>Enter a new value in the <b>Absolute tolerance</b> field</td>
</tr>
<tr> 
    <td>The ODE solver automatically terminates if it runs for too long (in real time). You can adjust how long the solver will run.</td>
    <td>Type a new value for <b>Max solver wall clock (s)</b> </td>
</tr>
<tr> 
    <td>Use a fixed step solver</td>
    <td>Press the <b>Fixed step</b> button</td>
</tr>
<tr> 
    <td>Use a different fixed step solver. Note that implicit methods use a Newton iteration at each step and, as a result, solve slowly.</td>
    <td>Select a solver from <b>Solver<b> dropdown</td>
</tr>
<tr> 
    <td>Use a different step in the numerical integration</td>
    <td>Type a new value for <b>Step size</b></td>
</tr>
</table>

### Analysis Menu
![analysismenupp](https://user-images.githubusercontent.com/81383420/117189337-17c99880-adac-11eb-8545-3f6f01a5ea2d.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Numerically solve for an equilibrium of the system. Equilibria occur where x'(t)=0 and y'(t)=0. This function uses the Newton-Raphson method with a finite-difference Jacobian to solve for zeros of the differential equation system.</td>
    <td>Select <b>Find nearby equilibrium</b>. Then, click the phase plane near the suspected equilibrium point.</td>
</tr>
<tr>
    <td>Find equilibria in the phase plane. This method scans the plane using a grid of initial guesses and records all equilibria found. The Newton-Raphson method is used to solve for zeros of the differential equation system. </td>
    <td>Select <b>Scan for equilibria</b></td>
</tr>
<tr> 
    <td>Clear the equilibria</td>
    <td>Select <b>Clear equilibria</b></td>
</tr>
<tr>
    <td>Solve for saddle separatrices. Saddle separatrices are numerically estimated by generating a solution an increment away from each saddle equilibrium in the directions of the eigenvectors. Before solving for saddle separatrices, you should scan for equilibria. </td>
    <td>Select <b>Solve for saddle separatrices</b></td>
</tr>
<tr> 
    <td>Clear the separatrices</td>
    <td>Select <b>Clear separatrices</b></td>
</tr>
<tr>
    <td>Show nullclines or hide nullclines. Nullclines are curves along which x'(t) = 0 or y'(t) = 0. Nullclines with x'(t) = 0 are blue and those with y'(t) = 0 red. Intersections of the nullclines are equilibria since x'(t) and y'(t) are both zero.</td>
    <td>Select <b>Show nullclines</b></td>
</tr>
<tr> 
    <td>Automatically generate isoclines. Isoclines are curves along which the phase plane field directions are constant: y'(t)/x'(t) = m.</td>
    <td>Select <b>Auto-generate isoclines</b>. Then, enter an integer for how many isoclines you want to generate.</td>
</tr>
<tr> 
    <td>Draw an isocline curve through a point.</td>
    <td>Select <b>Draw isocline through a point</b>. Then, click the phase plane.</td>
</tr>
<tr> 
    <td>Draw isoclines with specified values.</td>
    <td>Select <b>Draw several isoclines</b>. Then, type a list of slope values. For example: -1 3 5</td>
</tr>
<tr> 
    <td>Clear the isoclines</td>
    <td>Select <b>Clear isoclines</b></td>
</tr>
</table>

### Solve and Draw Menus
![solvemenupp](https://user-images.githubusercontent.com/81383420/117189390-2748e180-adac-11eb-91bf-d51f65471378.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Generate several solutions starting within a region</td>
    <td>Select <b>Solve > Solve from region</b>. Then, click once on the phase plane to start drawing, draw your region, and click again to stop drawing.</td>
</tr>
<tr> 
    <td>Draw a solution on the phase plane</td>
    <td>Select <b>Draw > Draw solution</b>. Then, click once on the phase plane to start drawing, draw your solution, and click again to stop drawing.</td>
</tr>
<tr> 
    <td>Draw a solution on the phase plane and compare it to the numerical solution</td>
    <td>Select <b>Draw > Draw and compare solution</b>. Then, click once on the phase plane to start drawing, draw your solution, and click again to stop drawing.</td>
</tr>
</table>

### Appearance Menu
![appearancemenupp](https://user-images.githubusercontent.com/81383420/117189426-2fa11c80-adac-11eb-91bb-1d07a9f0a1ab.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Toggle solution animations</td>
    <td>Select <b>Animate solution</b></td>
</tr>
<tr> 
    <td>Toggle initial value labels</td>
    <td>Select <b>Point labels</b></td>
</tr>
<tr> 
    <td>Toggle the location of the axes</td>
    <td>Select <b>Axis through origin</b></td>
</tr>
<tr> 
    <td>Toggle dark mode</td>
    <td>Select <b>Dark mode</b></td>
</tr>
<tr> 
    <td>Toggle light mode</td>
    <td>Select <b>Light mode</b></td>
</tr>
<tr> 
    <td>Toggle between showing the field arrows with magnitude and orientation and orientation only</td>
    <td>Select <b>Field orientation only</b></td>
</tr>
</table>
<b>Note:</b> At most, one of the Dark and Light modes can be selected simultaneously. Selecting one will clear the other. The original theme colors are used if both Dark mode and Light mode are unselected.

### Library and Custom Library Menus
![librarymenupp](https://user-images.githubusercontent.com/81383420/117189453-3760c100-adac-11eb-8f52-4fbbd0ee3564.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Set the differential equation to a standard system</td><td>Select one of the systems from the <b>Library</b> menu</td>
</tr>
<tr>
    <td>Add the current system to the <b>Custom library</b> tab</td><td>Select <b>Custom library > Add current system</b></td>
</tr>
<tr>
    <td>Save the current custom library to a MAT file</td><td>Select <b>Custom library > Save</b></td>
</tr>
<tr>
    <td>Load a custom library MAT file (note: the custom library should be one created by the Phase Plane app)</td><td>Select <b>Custom library > Load</b></td>
</tr>
<tr>
    <td>Clear the current custom library</td><td>Select <b>Custom library > Clear</b></td>
</tr>
</table>

### Export Graphics Menu
![exportgraphicsmenupp](https://user-images.githubusercontent.com/81383420/117189476-4182bf80-adac-11eb-94eb-cc998e46d022.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Export the phase plane portrait and time series to an image file. This method includes the equations in the exported image. </td>
    <td>Select <b>Export to PNG</b></td>
</tr>
<tr>
    <td>Export the phase plane portrait and time series to a scalable vector graphics file (this format is useful for editing or high resolution website display). This method includes the equations in the exported image. </td>
    <td>Select <b>Export to SVG</b></td>
</tr>
<tr>
    <td>Export the phase plane portrait and time series to a PDF. This method includes the equations in the exported image.</td>
    <td>Select <b>Export to PDF</b></td>
</tr>
<tr>
    <td>Export the phase plane portrait to an image file</td>
    <td>Select <b>Export portrait only to PNG</b></td>
</tr>
<tr>
    <td>Export the phase plane portrait to a scalable vector graphics file</td>
    <td>Select <b>Export portrait only to SVG</b></td>
</tr>
<tr>
    <td>Export the phase plane portrait to a PDF</td>
    <td>Select <b>Export portrait only to PDF</b></td>
</tr>
</table>

## Full Capabilities: Slope Field App
The details of the Slope Field app are documented here for reference. The Slope Field app has four main areas you can interact with:

<img src="https://user-images.githubusercontent.com/81383420/117191860-0d5cce00-adaf-11eb-8636-524d4ad27782.png" width="600">


Each of these areas is described below.

### Differential Equation Panel
![differentialequationpanel](https://user-images.githubusercontent.com/81383420/117189545-552e2600-adac-11eb-9ed0-24d5d20731d2.png)


<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Define an ODE</td>
    <td>Type the dependent variable name and the ODE expression in terms of the dependent variable and the independent variable <i>t</i>.</td>
</tr>
<tr>
    <td>Define a parameter</td>
    <td>Type the name of the parameter in the first field. Type the value in the second field. You can use a valid MATLAB expression, such as log(2), but you cannot use other parameters or variables.</td>
</tr>
<tr>
    <td>Update the slope field with a new equation</td>
    <td>Click <b>Update</b></td>
</tr>
<tr>
    <td>Clear the differential equation and parameters</td>
    <td>Click <b>Clear</b></td>
</tr>
<tr>
    <td>Use the default ODE</td>
    <td>Click <b>Default</b></td>
</tr>
</table>

### Slope Field Panel
![slopefieldpanel](https://user-images.githubusercontent.com/81383420/117189594-61b27e80-adac-11eb-9364-3c7f50701006.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Generate a solution</td>
    <td>Click the slope field</td>
</tr>
<tr> 
    <td>Delete a solution</td>
    <td>Right-click a solution curve</td>
</tr>
<tr> 
    <td>Highlight a solution</td>
    <td>Left-click a solution curve</td>
</tr>
<tr>
    <td>Remove highlighting</td>
    <td>Left- or right-click a highlighted curve</td>
<tr>
<tr>
    <td>Solve from a numerically defined initial condition</td>
    <td>Set the initial values in the t0 and x0 edit fields. Then press <b>Solve from (t0,x0)</b>.</td>
</tr>
<tr>
    <td>Clear solution curves</td>
    <td>Click <b>Clear solutions</b></td>
</tr>
</table>

### Appearance Tab
![appearancemenu](https://user-images.githubusercontent.com/81383420/117189628-69722300-adac-11eb-9e00-4304143de79e.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Change the horizontal axis limits</td>
    <td>Type values of <b>tmin</b> and <b>tmax</b></td>
</tr>
<tr> 
    <td>Change the vertical axis limits</td>
    <td>Type values of <b>xmin</b> and <b>xmax</b></td>
</tr>
<tr> 
    <td>Speed up or slow down the animation</td>
    <td>Move the <b>Animation speed</b> slider</td>
</tr>
<tr>
    <td>Increase or decrease the widths of solution curves</td>
    <td>Use the spinner or type a new value for <b>Line width</b></td>
<tr>
<tr>
    <td>Increase or decrease the number of slope field arrows</td>
    <td>Use the spinner or type a new value for <b>Field density</b></td>
</tr>
<tr>
    <td>Increase or decrease the size of the slope field arrows</td>
    <td>Use the spinner or type a new value for <b>Field scale</b></td>
</tr>
</table>

### Solution Tab
![solutiontab](https://user-images.githubusercontent.com/81383420/117189697-7c84f300-adac-11eb-9e96-890b12634c37.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Allow solver to continue beyond axis limits</td>
    <td>Uncheck <b>Terminate solutions at axis limits</b></td>
</tr>
<tr> 
    <td>Change how many solutions are generated when the <b>Solve from region</b> functionality is used </td>
    <td>Adjust the <b>Solve from region density</b> slider</td>
</tr>
</table>

### Solver Tab
![solvertab](https://user-images.githubusercontent.com/81383420/117189722-81e23d80-adac-11eb-958e-01640aebd1fd.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Change the variable step ode solver</td>
    <td>Select a solver from the <b>Solver</b> dropdown</td>
</tr>
<tr> 
    <td>Change the ODE solver relative tolerance</td>
    <td>Enter a new value in the <b>Relative tolerance</b> field</td>
</tr>
<tr> 
    <td>Change the ODE solver absolute tolerance</td>
    <td>Enter a new value in the <b>Absolute tolerance</b> field</td>
</tr>
<tr> 
    <td>The ODE solver automatically terminates if it runs for too long (in real time). You can adjust how long the solver will run.</td>
    <td>Type a new value for <b>Max solver wall clock (s)</b> </td>
</tr>
<tr> 
    <td>Use a fixed step solver</td>
    <td>Press the <b>Fixed step</b> button</td>
</tr>
<tr> 
    <td>Use a different fixed step solver. Note that implicit methods use a Newton iteration at each step and, as a result, solve slowly.</td>
    <td>Select a solver from the <b>Solver<b> dropdown</td>
</tr>
<tr> 
    <td>Use a different step in the numerical integration</td>
    <td>Type a new value for <b>Step size</b></td>
</tr>
</table>

### Analysis Menu
![analysisdropdown](https://user-images.githubusercontent.com/81383420/117189767-8eff2c80-adac-11eb-8067-716e1adeb893.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Show nullclines or hide nullclines. Nullclines are curves along which x'(t) = 0.</td>
    <td>Select <b>Show nullclines</b></td>
</tr>
<tr> 
    <td>Automatically generate isoclines. Isoclines are curves along which the derivative is constant: x'(t) = m.</td>
    <td>Select <b>Auto-generate isoclines</b>. Then, enter an integer for how many isoclines you wish to generate.</td>
</tr>
<tr> 
    <td>Draw an isocline curve through a point.</td>
    <td>Select <b>Draw isocline through a point</b>. Then, click the slope field.</td>
</tr>
<tr> 
    <td>Draw isoclines with specified slope values.</td>
    <td>Select <b>Draw several isoclines</b>. Then, type a list of slope values. For example: -1 3 5</td>
</tr>
<tr> 
    <td>Clear the isoclines</td>
    <td>Select <b>Clear isoclines</b></td>
</tr>
</table>

### Solve and Draw Menus
![solvemenu](https://user-images.githubusercontent.com/81383420/117189824-a0483900-adac-11eb-9267-2500f933bfb1.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Generate several solutions starting within a region</td>
    <td>Select <b>Solve > Solve from region</b>. Then, click once on the slope field to start drawing, draw your region, and click again to stop drawing.</td>
</tr>
<tr> 
    <td>Draw a solution on the slope field</td>
    <td>Select <b>Draw > Draw solution</b>. Then, click once on the slope field to start drawing, draw your solution, and click again to stop drawing.</td>
</tr>
<tr> 
    <td>Draw a solution on the slope field and compare it to the numerical solution</td>
    <td>Select <b>Draw > Draw and compare solution</b>. Then, click once on the slope field to start drawing, draw your solution, and click again to stop drawing.</td>
</tr>
</table>

### Appearance Menu
![appearancemenu](https://user-images.githubusercontent.com/81383420/117189868-accc9180-adac-11eb-89d9-2c46895a8461.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Toggle solution animations</td>
    <td>Select <b>Animate solution</b></td>
</tr>
<tr> 
    <td>Toggle initial value labels</td>
    <td>Select <b>Point labels</b></td>
</tr>
<tr> 
    <td>Toggle the location of the axes</td>
    <td>Select <b>Axis through origin</b></td>
</tr>
<tr> 
    <td>Toggle dark mode</td>
    <td>Select <b>Dark mode</b></td>
</tr>
<tr> 
    <td>Toggle light mode</td>
    <td>Select <b>Light mode</b></td>
</tr>
<tr> 
    <td>Toggle between showing the field arrows with magnitude and orientation and orientation only</td>
    <td>Select <b>Field orientation only</b></td>
</tr>
</table>
<b>Note:</b> At most, one of the Dark and Light modes can be selected simultaneously. Selecting one will clear the other. The original theme colors are used if both Dark mode and Light mode are unselected.

### Library and Custom Library Menus
![librarymenu](https://user-images.githubusercontent.com/81383420/117189899-b524cc80-adac-11eb-9c57-111b6ec4b6b0.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Set the differential equation to a standard system</td><td>Select one of the systems from the <b>Library</b> menu</td>
</tr>
<tr>
    <td>Add the current system to the <b>Custom library</b> tab</td><td>Select <b>Custom library > Add current system</b></td>
</tr>
<tr>
    <td>Save the current custom library to a MAT file</td><td>Select <b>Custom library > Save</b></td>
</tr>
<tr>
    <td>Load a custom library MAT file (note: the custom library should be one created by the Slope Field app)</td><td>Select <b>Custom library > Load</b></td>
</tr>
<tr>
    <td>Clear the current custom library</td><td>Select <b>Custom library > Clear</b></td>
</tr>
</table>

### Export Graphics Menu
![exportgraphicsmenu](https://user-images.githubusercontent.com/81383420/117189911-bc4bda80-adac-11eb-92f7-9a689de6d810.png)

<table>
<tr>
    <th>Functionality</th><th>Action</th>
</tr>
<tr>
    <td>Export the Slope Field to an image file</td><td>Select <b>Export to PNG</b></td>
</tr>
<tr>
    <td>Export the Slope Field to a scalable vector graphics file (this format is useful for editing or high resolution website display)</td><td>Select <b>Export to SVG</b></td>
</tr>
<tr>
    <td>Export the Slope Field to a PDF</td><td>Select <b>Export to PDF</b></td>
</tr>
</table>

## References
<a name="ref1">[1]</a> 
John C. Polking. DField and PPlane [Computer software]. (1995-2003). Available online: https://math.rice.edu/~polking/odesoft/dfpp.html

<br>
&copy; Copyright 2023 The MathWorks, Inc.
