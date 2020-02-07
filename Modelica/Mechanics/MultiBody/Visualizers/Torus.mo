within Modelica.Mechanics.MultiBody.Visualizers;
model Torus "Visualizing a torus"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

  parameter Boolean animation=true "= true, if animation shall be enabled";

  parameter SI.Radius R=0.5 "Major radius (distance from center of torus to center of tube)" annotation(Dialog(enable=animation));
  parameter SI.Radius r=0.1 "Minor radius (radius of tube)"
    annotation(Dialog(enable=animation));
  parameter SI.Angle opening=0 "Opening angle of torus" annotation(Dialog(enable=animation));
  parameter SI.Angle startAngle=-3.1415926535898
    "Start angle of torus slice" annotation(Dialog(enable=animation));
  parameter SI.Angle stopAngle=3.1415926535898
    "End angle of torus slice" annotation(Dialog(enable=animation));
  parameter Boolean wireframe=false
    "= true: 3D model will be displayed without faces"
    annotation (Dialog(enable=animation, group="Material properties"),choices(checkBox=true));
  input Modelica.Mechanics.MultiBody.Types.RealColor color={0,128,255}
    "Color of surface" annotation(Dialog(enable=animation, colorSelector=true, group="Material properties"));
  input Types.SpecularCoefficient specularCoefficient = 0.7
    "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog(enable=animation,group="Material properties"));
  input Real transparency=0
    "Transparency of shape: 0 (= opaque) ... 1 (= fully transparent)"
                               annotation(Dialog(enable=animation,group="Material properties"));
  parameter Integer n_R=40 "Number of points along major radius R" annotation(Dialog(enable=animation,tab="Discretization"));
  parameter Integer n_r=20 "Number of points along minor radius r" annotation(Dialog(enable=animation,tab="Discretization"));

protected
  Advanced.Surface surface(
    redeclare function surfaceCharacteristic =
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.torus (
        R=R,
        r=r,
        opening=opening,
        startAngle=startAngle,
        stopAngle=stopAngle),
        nu=n_R,
        nv=n_r,
        multiColoredSurface=false,
        wireframe=wireframe,
        color=color,
        specularCoefficient=specularCoefficient,
        transparency=transparency,
        R=frame_a.R,
        r_0=frame_a.r_0) if world.enableAnimation and animation
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
equation
  // No forces and torques
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  annotation (
    Icon(
      graphics={
        Text(textColor = {0,0,255}, extent = {{-150, 100}, {150, 140}}, textString = "%name"),
        Polygon(lineColor = {64, 64, 64}, fillColor = {71, 152, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-72.253, 64.182}, {-77.03, 59.04}, {-81.278, 53.499}, {-84.986, 47.602}, {-88.145, 41.392}, {-90.745, 34.911}, {-92.777, 28.202}, {-94.231, 21.307}, {-95.097, 14.269}, {-95.365, 7.13}, {-95.027, -0.067}, {-94.072, -7.28}, {-92.491, -14.465}, {-90.273, -21.582}, {-87.411, -28.586}, {-83.892, -35.437}, {-79.709, -42.09}, {-74.852, -48.503}, {-69.309, -54.635}, {-63.785, -59.814}, {-57.839, -64.586}, {-51.519, -68.938}, {-44.871, -72.858}, {-37.943, -76.332}, {-30.782, -79.348}, {-23.434, -81.894}, {-15.947, -83.956}, {-8.367, -85.523}, {-0.741, -86.581}, {6.884, -87.118}, {14.46, -87.121}, {21.941, -86.577}, {29.28, -85.475}, {36.431, -83.8}, {43.345, -81.541}, {49.976, -78.686}, {56.278, -75.22}, {62.203, -71.132}, {67.704, -66.409}, {73.446, -60.364}, {78.374, -54.029}, {82.506, -47.441}, {85.863, -40.637}, {88.462, -33.653}, {90.322, -26.526}, {91.461, -19.294}, {91.899, -11.992}, {91.654, -4.659}, {90.746, 2.669}, {89.192, 9.955}, {87.011, 17.163}, {84.222, 24.255}, {80.845, 31.194}, {76.896, 37.944}, {72.396, 44.468}, {67.363, 50.728}, {61.816, 56.688}, {56.232, 61.872}, {50.304, 66.615}, {44.07, 70.907}, {37.568, 74.735}, {30.835, 78.091}, {23.91, 80.962}, {16.828, 83.337}, {9.63, 85.207}, {2.351, 86.559}, {-4.971, 87.383}, {-12.297, 87.669}, {-19.591, 87.404}, {-26.815, 86.579}, {-33.93, 85.182}, {-40.901, 83.202}, {-47.688, 80.629}, {-54.254, 77.451}, {-60.562, 73.658}, {-66.574, 69.239}, {-72.253, 64.182}, {-42.048, 32.604}, {-36.102, 37.608}, {-29.329, 40.96}, {-21.973, 42.833}, {-14.275, 43.397}, {-6.477, 42.824}, {1.179, 41.286}, {8.45, 38.956}, {15.096, 36.005}, {20.873, 32.604}, {25.864, 28.942}, {31.126, 24.443}, {36.304, 19.198}, {41.044, 13.302}, {44.991, 6.847}, {47.79, -0.074}, {49.086, -7.367}, {48.525, -14.94}, {45.751, -22.698}, {40.409, -30.55}, {33.361, -37.212}, {25.834, -41.649}, {18.025, -44.139}, {10.129, -44.963}, {2.342, -44.4}, {-5.14, -42.728}, {-12.121, -40.228}, {-18.405, -37.179}, {-23.796, -33.86}, {-28.099, -30.55}, {-32.136, -26.889}, {-36.606, -22.388}, {-41.128, -17.142}, {-45.318, -11.244}, {-48.793, -4.788}, {-51.17, 2.134}, {-52.067, 9.427}, {-51.101, 16.999}, {-47.889, 24.756}, {-42.048, 32.604}}),
        Polygon(lineColor = {64, 64, 64}, fillColor = {71, 152, 255}, points = {{-72.253, 64.182}, {-66.574, 69.239}, {-60.562, 73.658}, {-54.254, 77.451}, {-47.688, 80.629}, {-40.901, 83.202}, {-33.93, 85.182}, {-26.815, 86.579}, {-19.591, 87.404}, {-12.297, 87.669}, {-4.971, 87.383}, {2.351, 86.559}, {9.63, 85.207}, {16.828, 83.337}, {23.91, 80.962}, {30.835, 78.091}, {37.568, 74.735}, {44.07, 70.907}, {50.304, 66.615}, {56.232, 61.872}, {61.816, 56.688}, {67.363, 50.728}, {72.396, 44.468}, {76.896, 37.944}, {80.845, 31.194}, {84.222, 24.255}, {87.011, 17.163}, {89.192, 9.955}, {90.746, 2.669}, {91.654, -4.659}, {91.899, -11.992}, {91.461, -19.294}, {90.322, -26.526}, {88.462, -33.653}, {85.863, -40.637}, {82.506, -47.441}, {78.374, -54.029}, {73.446, -60.364}, {67.704, -66.409}, {62.203, -71.132}, {56.278, -75.22}, {49.976, -78.686}, {43.345, -81.541}, {36.431, -83.8}, {29.28, -85.475}, {21.941, -86.577}, {14.46, -87.121}, {6.884, -87.118}, {-0.741, -86.581}, {-8.367, -85.523}, {-15.947, -83.956}, {-23.434, -81.894}, {-30.782, -79.348}, {-37.943, -76.332}, {-44.871, -72.858}, {-51.519, -68.938}, {-57.839, -64.586}, {-63.785, -59.814}, {-69.309, -54.635}, {-74.852, -48.503}, {-79.709, -42.09}, {-83.892, -35.437}, {-87.411, -28.586}, {-90.273, -21.582}, {-92.491, -14.465}, {-94.072, -7.28}, {-95.027, -0.067}, {-95.365, 7.13}, {-95.097, 14.269}, {-94.231, 21.307}, {-92.777, 28.202}, {-90.745, 34.911}, {-88.145, 41.392}, {-84.986, 47.602}, {-81.278, 53.499}, {-77.03, 59.04}, {-72.253, 64.182}}, smooth = Smooth.Bezier),
        Polygon(fillColor = {10, 90, 224}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-90.183, 4.774}, {-89.29, -2.507}, {-87.65, -9.672}, {-85.311, -16.688}, {-82.321, -23.518}, {-78.731, -30.128}, {-74.59, -36.482}, {-69.946, -42.545}, {-64.848, -48.282}, {-59.347, -53.657}, {-53.49, -58.634}, {-47.328, -63.18}, {-40.909, -67.257}, {-34.282, -70.832}, {-27.497, -73.868}, {-20.602, -76.331}, {-13.647, -78.185}, {-5.658, -79.626}, {2.34, -80.443}, {10.288, -80.644}, {18.126, -80.24}, {25.794, -79.24}, {33.233, -77.653}, {40.384, -75.488}, {47.186, -72.756}, {53.58, -69.465}, {59.505, -65.625}, {64.904, -61.246}, {69.715, -56.337}, {73.88, -50.907}, {77.338, -44.966}, {72.917, -49.023}, {67.981, -52.591}, {62.575, -55.671}, {56.742, -58.265}, {50.527, -60.374}, {43.974, -62}, {37.126, -63.144}, {30.029, -63.808}, {22.726, -63.992}, {15.26, -63.699}, {7.678, -62.93}, {0.022, -61.686}, {-7.664, -59.969}, {-15.335, -57.779}, {-22.947, -55.12}, {-30.456, -51.991}, {-37.819, -48.395}, {-44.99, -44.333}, {-51.925, -39.806}, {-58.582, -34.816}, {-64.915, -29.364}, {-70.88, -23.451}, {-76.433, -17.08}, {-81.531, -10.251}, {-86.129, -2.966}, {-90.183, 4.774}}, smooth = Smooth.Bezier),
        Polygon(fillColor = {156, 203, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0.803, -51.958}, {11.03, -53.644}, {20.576, -54.192}, {29.425, -53.684}, {37.562, -52.2}, {44.974, -49.821}, {51.644, -46.628}, {57.559, -42.703}, {62.704, -38.126}, {67.064, -32.978}, {70.624, -27.34}, {73.369, -21.294}, {75.285, -14.92}, {76.358, -8.3}, {76.572, -1.513}, {75.912, 5.358}, {74.365, 12.233}, {71.914, 19.03}, {68.546, 25.669}, {64.246, 32.069}, {68.464, 23.809}, {71.022, 16.316}, {71.227, 10.492}, {68.389, 7.237}, {61.817, 7.45}, {63.346, 1.807}, {64.026, -4.042}, {63.843, -9.992}, {62.781, -15.937}, {60.828, -21.772}, {57.969, -27.392}, {54.19, -32.691}, {49.477, -37.563}, {43.817, -41.905}, {37.194, -45.61}, {29.595, -48.574}, {21.006, -50.69}, {11.414, -51.853}, {0.803, -51.958}}, smooth = Smooth.Bezier),
        Polygon(fillColor = {10, 90, 224}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-45.225, -15.029}, {-49.203, -8.642}, {-52.162, -1.742}, {-54.02, 5.476}, {-54.695, 12.821}, {-54.106, 20.097}, {-52.17, 27.112}, {-48.806, 33.671}, {-43.932, 39.581}, {-37.465, 44.648}, {-31.91, 47.581}, {-25.763, 49.807}, {-19.146, 51.3}, {-12.181, 52.031}, {-4.989, 51.974}, {2.308, 51.103}, {9.588, 49.389}, {16.73, 46.807}, {23.612, 43.33}, {30.112, 38.929}, {36.108, 33.579}, {41.479, 27.252}, {35.949, 35.695}, {30.184, 42.766}, {24.221, 48.561}, {18.099, 53.176}, {11.854, 56.706}, {5.525, 59.247}, {-0.853, 60.892}, {-7.24, 61.739}, {-13.601, 61.881}, {-19.897, 61.415}, {-26.091, 60.436}, {-34.854, 57.822}, {-42.105, 53.874}, {-47.925, 48.813}, {-52.395, 42.856}, {-55.596, 36.221}, {-57.609, 29.128}, {-58.514, 21.794}, {-58.393, 14.437}, {-57.327, 7.278}, {-55.396, 0.533}, {-52.681, -5.579}, {-49.264, -10.839}, {-45.225, -15.029}}, smooth = Smooth.Bezier),
        Polygon(fillColor = {156, 203, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-61.245, -15.029}, {-64.25, -7.37}, {-66.703, 0.324}, {-68.557, 7.994}, {-69.768, 15.582}, {-70.289, 23.03}, {-70.075, 30.28}, {-69.08, 37.274}, {-67.259, 43.954}, {-64.565, 50.261}, {-60.954, 56.138}, {-56.379, 61.526}, {-50.794, 66.368}, {-44.155, 70.605}, {-38.685, 73.337}, {-32.863, 75.726}, {-26.675, 77.722}, {-20.107, 79.277}, {-13.142, 80.344}, {-5.768, 80.876}, {2.031, 80.823}, {10.27, 80.138}, {18.963, 78.773}, {28.124, 76.68}, {17.648, 80.219}, {7.69, 82.637}, {-1.726, 84.047}, {-10.579, 84.565}, {-18.845, 84.302}, {-26.501, 83.375}, {-33.526, 81.896}, {-39.897, 79.98}, {-45.592, 77.74}, {-50.587, 75.291}, {-54.86, 72.746}, {-61.395, 67.72}, {-66.745, 62.054}, {-70.958, 55.843}, {-74.083, 49.184}, {-76.168, 42.174}, {-77.262, 34.908}, {-77.413, 27.483}, {-76.671, 19.994}, {-75.082, 12.539}, {-72.697, 5.213}, {-69.564, -1.888}, {-65.73, -8.667}, {-61.245, -15.029}}, smooth = Smooth.Bezier),
        Polygon(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, points = {{-42.048, 32.604}, {-36.102, 37.608}, {-29.329, 40.96}, {-21.973, 42.833}, {-14.275, 43.397}, {-6.477, 42.824}, {1.179, 41.286}, {8.45, 38.956}, {15.096, 36.005}, {20.873, 32.604}, {25.864, 28.942}, {31.126, 24.443}, {36.304, 19.198}, {41.044, 13.302}, {44.991, 6.847}, {47.79, -0.074}, {49.086, -7.367}, {48.525, -14.94}, {45.751, -22.698}, {40.409, -30.55}, {33.361, -37.212}, {25.834, -41.649}, {18.025, -44.139}, {10.129, -44.963}, {2.342, -44.4}, {-5.14, -42.728}, {-12.121, -40.228}, {-18.405, -37.179}, {-23.796, -33.86}, {-28.099, -30.55}, {-32.136, -26.889}, {-36.606, -22.388}, {-41.128, -17.142}, {-45.318, -11.244}, {-48.793, -4.788}, {-51.17, 2.134}, {-52.067, 9.427}, {-51.101, 16.999}, {-47.889, 24.756}, {-42.048, 32.604}})},
      coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true)),
    Documentation(info="<html> <p>
Model <strong>Torus</strong> visualizes a torus. The center of the torus is located at
connector frame_a (visualized by the red coordinate system in the figure below).
The left image below shows a torus with <var>R</var>&nbsp;=&nbsp;0.5&nbsp;m and
<var>r</var>&nbsp;=&nbsp;0.2&nbsp;m.
The right images below shows the torus with the additional parameter
settings:
</p>
<blockquote><pre>
opening    =   45 degree
startAngle = -135 degree
stopAngle  =  135 degree
</pre></blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Torus.png\">
</blockquote>

<p>
In the advanced menu the discretization of the surface visualization can be defined by
the number <var>n<sub>R</sub></var> of points along the major radius of the torus and by
the number <var>n<sub>r</sub></var> of points along the minor radius of the torus.
In case the torus is closed (that is, <code>opening</code>&nbsp;=&nbsp;0&nbsp;degree),
the actual number of points is one less (that is <var>n<sub>R</sub></var>&nbsp;-&nbsp;1, <var>n<sub>r</sub></var>&nbsp;-&nbsp;1), because the first and
the last point of the parametrization coincide in this case.
</p>
</html>",
        revisions="<html>
  <ul>
  <li> July 2010 by Martin Otter<br>
       Adapted to the new Surface model.</li>
  <li> July 2005 by Dirk Zimmer (practical training at DLR)<br>
       First version to visualize a multi-level tyre wheel model.</li>
  </ul>
</html>"));
end Torus;
