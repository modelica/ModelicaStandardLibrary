within Modelica.Mechanics.MultiBody.Visualizers;
model PipeWithScalarField
  "Visualizing a pipe with scalar field quantities along the pipe axis"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

  parameter Boolean animation=true "= true, if animation shall be enabled";

  parameter SI.Radius rOuter "Outer radius of pipe" annotation(Dialog(enable=animation));
  parameter SI.Length length "Length of pipe" annotation(Dialog(enable=animation));

  parameter Real xsi[:](each min=0, each max=1)= Modelica.Math.Vectors.relNodePositions(12)
    "Vector of relative positions along the pipe with x[1] = 0, x[end] = 1"
    annotation(Dialog(enable=animation));
  input Real T[size(xsi,1)]
    "Vector of values at positions xsi*length (will be visualized by color)" annotation(Dialog(enable=animation));
  parameter Real T_min "Minimum value of T that corresponds to colorMap[1,:]" annotation(Dialog(enable=animation));
  parameter Real T_max
    "Maximum value of T that corresponds to colorMap[end,:]" annotation(Dialog(enable=animation));
  replaceable function colorMap =
    Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet constrainedby Modelica.Mechanics.MultiBody.Interfaces.partialColorMap
    "Function defining the color map"
    annotation(choicesAllMatching=true, Dialog(enable=animation,group="Color coding"),
    Documentation(info="<html>
<p>This replaceable function defines a particular color map.</p>
<!--a placeholder to fulfill minimum documentation length-->
</html>"));

  parameter Integer n_colors=64 "Number of colors in the colorMap" annotation(Dialog(enable=animation,group="Color coding"));
  parameter Types.SpecularCoefficient specularCoefficient = 0.7
    "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog(enable=animation,group="Color coding"));
  parameter Real transparency=0
    "Transparency of shape: 0 (= opaque) ... 1 (= fully transparent)"
    annotation(Dialog(enable=animation,group="Color coding"));

  parameter Integer n_rOuter=30 "Number of points along outer radius" annotation(Dialog(enable=animation,tab="Discretization"));
  parameter Integer n_length=20 "Number of points along length" annotation(Dialog(enable=animation,tab="Discretization"));

protected
  Advanced.PipeWithScalarField pipe(redeclare function colorMap = colorMap,
         rOuter=rOuter,
         length=length,
         xsi=xsi,
         T=T,
         T_min=T_min,
         T_max=T_max,
         n_colors=n_colors,
         n_rOuter=n_rOuter,
         n_length=n_length,
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
        Text(textColor = {0,0,255}, extent = {{-150, 50}, {150, 90}}, textString = "%name"),
        Polygon(origin = {-5, 0}, fillColor = {0, 0, 163}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-70, -33.5}, {-70, -33.5}, {-76, -33.333}, {-82.378, -30.796}, {-87.785, -23.57}, {-90.44, -16.645}, {-92.096, -8.651}, {-92.667, 0}, {-92.096, 8.651}, {-90.44, 16.645}, {-87.785, 23.57}, {-82.378, 30.796}, {-76, 33.333}, {-70, 33.5}, {-70, 33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 56, 195}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-65.833, 33.5}, {-65.833, 33.5}, {-71.833, 33.333}, {-78.211, 30.796}, {-83.618, 23.57}, {-86.273, 16.645}, {-87.929, 8.651}, {-88.5, 0}, {-87.929, -8.651}, {-86.273, -16.645}, {-83.618, -23.57}, {-78.211, -30.796}, {-71.833, -33.333}, {-65.833, -33.5}, {-65.833, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 76, 210}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-61.667, 33.5}, {-61.667, 33.5}, {-67.667, 33.333}, {-74.045, 30.796}, {-79.452, 23.57}, {-82.106, 16.645}, {-83.762, 8.651}, {-84.333, 0}, {-83.762, -8.651}, {-82.106, -16.645}, {-79.452, -23.57}, {-74.045, -30.796}, {-67.667, -33.333}, {-61.667, -33.5}, {-61.667, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 95, 223}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-57.5, 33.5}, {-57.5, 33.5}, {-63.5, 33.333}, {-69.878, 30.796}, {-75.285, 23.57}, {-77.94, 16.645}, {-79.596, 8.651}, {-80.167, 0}, {-79.596, -8.651}, {-77.94, -16.645}, {-75.285, -23.57}, {-69.878, -30.796}, {-63.5, -33.333}, {-57.5, -33.5}, {-57.5, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 114, 234}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-53.333, 33.5}, {-53.333, 33.5}, {-59.333, 33.333}, {-65.711, 30.796}, {-71.118, 23.57}, {-73.773, 16.645}, {-75.429, 8.651}, {-76, 0}, {-75.429, -8.651}, {-73.773, -16.645}, {-71.118, -23.57}, {-65.711, -30.796}, {-59.333, -33.333}, {-53.333, -33.5}, {-53.333, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 132, 245}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-49.167, 33.5}, {-49.167, 33.5}, {-55.167, 33.333}, {-61.545, 30.796}, {-66.952, 23.57}, {-69.606, 16.645}, {-71.262, 8.651}, {-71.833, 0}, {-71.262, -8.651}, {-69.606, -16.645}, {-66.952, -23.57}, {-61.545, -30.796}, {-55.167, -33.333}, {-49.167, -33.5}, {-49.167, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {18, 151, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-45, 33.5}, {-45, 33.5}, {-51, 33.333}, {-57.378, 30.796}, {-62.785, 23.57}, {-65.44, 16.645}, {-67.096, 8.651}, {-67.667, 0}, {-67.096, -8.651}, {-65.44, -16.645}, {-62.785, -23.57}, {-57.378, -30.796}, {-51, -33.333}, {-45, -33.5}, {-45, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 188, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-40.833, 33.5}, {-40.833, 33.5}, {-46.833, 33.333}, {-53.211, 30.796}, {-58.618, 23.57}, {-61.273, 16.645}, {-62.929, 8.651}, {-63.5, 0}, {-62.929, -8.651}, {-61.273, -16.645}, {-58.618, -23.57}, {-53.211, -30.796}, {-46.833, -33.333}, {-40.833, -33.5}, {-40.833, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 205, 253}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36.667, 33.5}, {-36.667, 33.5}, {-42.667, 33.333}, {-49.045, 30.796}, {-54.452, 23.57}, {-57.106, 16.645}, {-58.762, 8.651}, {-59.333, 0}, {-58.762, -8.651}, {-57.106, -16.645}, {-54.452, -23.57}, {-49.045, -30.796}, {-42.667, -33.333}, {-36.667, -33.5}, {-36.667, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 220, 235}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-32.5, 33.5}, {-32.5, 33.5}, {-38.5, 33.333}, {-44.878, 30.796}, {-50.285, 23.57}, {-52.94, 16.645}, {-54.596, 8.651}, {-55.167, 0}, {-54.596, -8.651}, {-52.94, -16.645}, {-50.285, -23.57}, {-44.878, -30.796}, {-38.5, -33.333}, {-32.5, -33.5}, {-32.5, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 233, 211}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-28.333, 33.5}, {-28.333, 33.5}, {-34.333, 33.333}, {-40.711, 30.796}, {-46.118, 23.57}, {-48.773, 16.645}, {-50.429, 8.651}, {-51, 0}, {-50.429, -8.651}, {-48.773, -16.645}, {-46.118, -23.57}, {-40.711, -30.796}, {-34.333, -33.333}, {-28.333, -33.5}, {-28.333, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 245, 183}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-24.167, 33.5}, {-24.167, 33.5}, {-30.167, 33.333}, {-36.545, 30.796}, {-41.952, 23.57}, {-44.606, 16.645}, {-46.262, 8.651}, {-46.833, 0}, {-46.262, -8.651}, {-44.606, -16.645}, {-41.952, -23.57}, {-36.545, -30.796}, {-30.167, -33.333}, {-24.167, -33.5}, {-24.167, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {34, 255, 154}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-20, 33.5}, {-20, 33.5}, {-26, 33.333}, {-32.378, 30.796}, {-37.785, 23.57}, {-40.44, 16.645}, {-42.096, 8.651}, {-42.667, 0}, {-42.096, -8.651}, {-40.44, -16.645}, {-37.785, -23.57}, {-32.378, -30.796}, {-26, -33.333}, {-20, -33.5}, {-20, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 255, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 33.5}, {-15.833, 33.5}, {-21.833, 33.333}, {-28.211, 30.796}, {-33.618, 23.57}, {-36.273, 16.645}, {-37.929, 8.651}, {-38.5, 0}, {-37.929, -8.651}, {-36.273, -16.645}, {-33.618, -23.57}, {-28.211, -30.796}, {-21.833, -33.333}, {-15.833, -33.5}, {-15.833, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 255, 113}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-11.667, 33.5}, {-11.667, 33.5}, {-17.667, 33.333}, {-24.045, 30.796}, {-29.452, 23.57}, {-32.106, 16.645}, {-33.762, 8.651}, {-34.333, 0}, {-33.762, -8.651}, {-32.106, -16.645}, {-29.452, -23.57}, {-24.045, -30.796}, {-17.667, -33.333}, {-11.667, -33.5}, {-11.667, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 255, 96}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-7.5, 33.5}, {-7.5, 33.5}, {-13.5, 33.333}, {-19.878, 30.796}, {-25.285, 23.57}, {-27.94, 16.645}, {-29.596, 8.651}, {-30.167, 0}, {-29.596, -8.651}, {-27.94, -16.645}, {-25.285, -23.57}, {-19.878, -30.796}, {-13.5, -33.333}, {-7.5, -33.5}, {-7.5, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {0, 255, 77}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-3.333, 33.5}, {-3.333, 33.5}, {-9.333, 33.333}, {-15.711, 30.796}, {-21.118, 23.57}, {-23.773, 16.645}, {-25.429, 8.651}, {-26, 0}, {-25.429, -8.651}, {-23.773, -16.645}, {-21.118, -23.57}, {-15.711, -30.796}, {-9.333, -33.333}, {-3.333, -33.5}, {-3.333, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {15, 255, 54}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0.833, 33.5}, {0.833, 33.5}, {-5.167, 33.333}, {-11.545, 30.796}, {-16.952, 23.57}, {-19.607, 16.645}, {-21.262, 8.651}, {-21.833, 0}, {-21.262, -8.651}, {-19.607, -16.645}, {-16.952, -23.57}, {-11.545, -30.796}, {-5.167, -33.333}, {0.833, -33.5}, {0.833, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {35, 255, 6}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{5, 33.5}, {5, 33.5}, {-1, 33.333}, {-7.378, 30.796}, {-12.785, 23.57}, {-15.44, 16.645}, {-17.096, 8.651}, {-17.667, 0}, {-17.096, -8.651}, {-15.44, -16.645}, {-12.785, -23.57}, {-7.378, -30.796}, {-1, -33.333}, {5, -33.5}, {5, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {136, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{9.167, 33.5}, {9.167, 33.5}, {3.167, 33.333}, {-3.211, 30.796}, {-8.618, 23.57}, {-11.273, 16.645}, {-12.929, 8.651}, {-13.5, 0}, {-12.929, -8.651}, {-11.273, -16.645}, {-8.618, -23.57}, {-3.211, -30.796}, {3.167, -33.333}, {9.167, -33.5}, {9.167, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {165, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{13.333, 33.5}, {13.333, 33.5}, {7.333, 33.333}, {0.955, 30.796}, {-4.452, 23.57}, {-7.106, 16.645}, {-8.762, 8.651}, {-9.333, 0}, {-8.762, -8.651}, {-7.106, -16.645}, {-4.452, -23.57}, {0.955, -30.796}, {7.333, -33.333}, {13.333, -33.5}, {13.333, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {191, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{17.5, 33.5}, {17.5, 33.5}, {11.5, 33.333}, {5.122, 30.796}, {-0.285, 23.57}, {-2.94, 16.645}, {-4.596, 8.651}, {-5.167, 0}, {-4.596, -8.651}, {-2.94, -16.645}, {-0.285, -23.57}, {5.122, -30.796}, {11.5, -33.333}, {17.5, -33.5}, {17.5, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {214, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{21.667, 33.5}, {21.667, 33.5}, {15.667, 33.333}, {9.289, 30.796}, {3.882, 23.57}, {1.227, 16.645}, {-0.429, 8.651}, {-1, 0}, {-0.429, -8.651}, {1.227, -16.645}, {3.882, -23.57}, {9.289, -30.796}, {15.667, -33.333}, {21.667, -33.5}, {21.667, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {235, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{25.833, 33.5}, {25.833, 33.5}, {19.833, 33.333}, {13.455, 30.796}, {8.048, 23.57}, {5.394, 16.645}, {3.738, 8.651}, {3.167, 0}, {3.738, -8.651}, {5.394, -16.645}, {8.048, -23.57}, {13.455, -30.796}, {19.833, -33.333}, {25.833, -33.5}, {25.833, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {255, 255, 11}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{30, 33.5}, {30, 33.5}, {24, 33.333}, {17.622, 30.796}, {12.215, 23.57}, {9.56, 16.645}, {7.904, 8.651}, {7.333, 0}, {7.904, -8.651}, {9.56, -16.645}, {12.215, -23.57}, {17.622, -30.796}, {24, -33.333}, {30, -33.5}, {30, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {255, 226, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{34.167, 33.5}, {34.167, 33.5}, {28.167, 33.333}, {21.789, 30.796}, {16.382, 23.57}, {13.727, 16.645}, {12.071, 8.651}, {11.5, 0}, {12.071, -8.651}, {13.727, -16.645}, {16.382, -23.57}, {21.789, -30.796}, {28.167, -33.333}, {34.167, -33.5}, {34.167, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {255, 211, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{38.333, 33.5}, {38.333, 33.5}, {32.333, 33.333}, {25.955, 30.796}, {20.548, 23.57}, {17.893, 16.645}, {16.238, 8.651}, {15.667, 0}, {16.238, -8.651}, {17.893, -16.645}, {20.548, -23.57}, {25.955, -30.796}, {32.333, -33.333}, {38.333, -33.5}, {38.333, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {255, 197, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{42.5, 33.5}, {42.5, 33.5}, {36.5, 33.333}, {30.122, 30.796}, {24.715, 23.57}, {22.06, 16.645}, {20.404, 8.651}, {19.833, 0}, {20.404, -8.651}, {22.06, -16.645}, {24.715, -23.57}, {30.122, -30.796}, {36.5, -33.333}, {42.5, -33.5}, {42.5, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {255, 182, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{46.667, 33.5}, {46.667, 33.5}, {40.667, 33.333}, {34.289, 30.796}, {28.882, 23.57}, {26.227, 16.645}, {24.571, 8.651}, {24, 0}, {24.571, -8.651}, {26.227, -16.645}, {28.882, -23.57}, {34.289, -30.796}, {40.667, -33.333}, {46.667, -33.5}, {46.667, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {255, 168, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{50.833, 33.5}, {50.833, 33.5}, {44.833, 33.333}, {38.455, 30.796}, {33.048, 23.57}, {30.393, 16.645}, {28.738, 8.651}, {28.167, 0}, {28.738, -8.651}, {30.393, -16.645}, {33.048, -23.57}, {38.455, -30.796}, {44.833, -33.333}, {50.833, -33.5}, {50.833, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {253, 154, 9}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{55, 33.5}, {55, 33.5}, {49, 33.333}, {42.622, 30.796}, {37.215, 23.57}, {34.56, 16.645}, {32.904, 8.651}, {32.333, 0}, {32.904, -8.651}, {34.56, -16.645}, {37.215, -23.57}, {42.622, -30.796}, {49, -33.333}, {55, -33.5}, {55, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {254, 127, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{59.167, 33.5}, {59.167, 33.5}, {53.167, 33.333}, {46.789, 30.796}, {41.382, 23.57}, {38.727, 16.645}, {37.071, 8.651}, {36.5, 0}, {37.071, -8.651}, {38.727, -16.645}, {41.382, -23.57}, {46.789, -30.796}, {53.167, -33.333}, {59.167, -33.5}, {59.167, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {254, 112, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{63.333, 33.5}, {63.333, 33.5}, {57.333, 33.333}, {50.955, 30.796}, {45.548, 23.57}, {42.894, 16.645}, {41.238, 8.651}, {40.667, 0}, {41.238, -8.651}, {42.894, -16.645}, {45.548, -23.57}, {50.955, -30.796}, {57.333, -33.333}, {63.333, -33.5}, {63.333, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {253, 96, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{67.5, 33.5}, {67.5, 33.5}, {61.5, 33.333}, {55.122, 30.796}, {49.715, 23.57}, {47.06, 16.645}, {45.404, 8.651}, {44.833, 0}, {45.404, -8.651}, {47.06, -16.645}, {49.715, -23.57}, {55.122, -30.796}, {61.5, -33.333}, {67.5, -33.5}, {67.5, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {253, 77, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{71.667, 33.5}, {71.667, 33.5}, {65.667, 33.333}, {59.289, 30.796}, {53.882, 23.57}, {51.227, 16.645}, {49.571, 8.651}, {49, 0}, {49.571, -8.651}, {51.227, -16.645}, {53.882, -23.57}, {59.289, -30.796}, {65.667, -33.333}, {71.667, -33.5}, {71.667, -33.5}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {252, 52, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{74.5, 33.5}, {74.5, 33.5}, {69.833, 33.333}, {63.455, 30.796}, {58.048, 23.57}, {55.394, 16.645}, {53.738, 8.651}, {53.167, 0}, {53.738, -8.651}, {55.394, -16.645}, {58.048, -23.57}, {63.455, -30.796}, {69.833, -33.333}, {74, -33.5}, {74.5, -34}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, fillColor = {251, 0, 7}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{74, 33.333}, {67.622, 30.796}, {62.215, 23.57}, {59.56, 16.645}, {57.904, 8.651}, {57.333, 0}, {57.904, -8.651}, {59.56, -16.645}, {62.215, -23.57}, {67.622, -30.796}, {74, -33.333}}, smooth = Smooth.Bezier),
        Polygon(origin = {-5, 0}, lineColor = {107, 0, 4}, fillColor = {251, 0, 7}, fillPattern = FillPattern.Sphere, points = {{90.667, 0}, {90.096, 8.651}, {88.44, 16.645}, {85.785, 23.57}, {80.378, 30.796}, {74, 33.333}, {67.622, 30.796}, {62.215, 23.57}, {59.56, 16.645}, {57.904, 8.651}, {57.333, 0}, {57.904, -8.651}, {59.56, -16.645}, {62.215, -23.57}, {67.622, -30.796}, {74, -33.333}, {80.378, -30.796}, {85.785, -23.57}, {88.44, -16.645}, {90.096, -8.651}, {90.667, 0}}, smooth=Smooth.Bezier),                                                                                                                                                                                                        Line(origin = {-5, 0}, points = {{-76, 33.333}, {-76, 33.333}, {-82.378, 30.796}, {-87.785, 23.57}, {-90.44, 16.645}, {-92.096, 8.651}, {-92.667, 0}, {-92.096, -8.651}, {-90.44, -16.645}, {-87.785, -23.57}, {-82.378, -30.796}, {-76, -33.333}, {-76, -33.333}, {74, -33.333}, {74, -33.333}, {80.378, -30.796}, {85.785, -23.57}, {88.44, -16.645}, {90.096, -8.651}, {90.667, 0}, {90.096, 8.651}, {88.44, 16.645}, {85.785, 23.57}, {80.378, 30.796}, {74, 33.333}, {74, 33.333}, {-76, 33.333}}, color = {64, 64, 64}, arrowSize = 8, smooth = Smooth.Bezier)},
      coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true)),
  Documentation(info = "<html>
<p>
Model <strong>PipeWithScalarField</strong> visualizes a pipe and a scalar
field along the pipe axis. The latter is shown by mapping the scalar
field to color values with a color map and utilizing this color
at the perimeter associated with the corresponding axis location.
Typically the scalar field value is a temperature, but might
be also another quantity.
Predefined color maps are available from
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">MultiBody.Visualizers.Colors.ColorMaps</a>
and can be selected via parameter \"colorMap\".
A color map with the corresponding scalar field values can be exported
as vector-graphics in svg-format with function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>.
Connector frame_a of this component is located in the center of the
circle at the left side of the pipe and the pipe axis is oriented
along the x-axis of frame_a, see figure below in which frame_a is visualized
with a coordinate system:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField.png\">
</blockquote>

<p>
The color coding is shown in the next figure. It was generated with
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>
using the following call:
</p>

<blockquote><pre>
colorMapToSvg(Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet(),
              height=50, nScalars=6, T_max=100, caption=\"Temperature in C\");
</pre></blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField-ColorMap.png\">
</blockquote>
</html>",
        revisions="<html>
  <ul>
  <li> July 2010 by Martin Otter<br>
       Adapted to the new Surface model.</li>
  <li> July 2005 by Dirk Zimmer (practical training at DLR)<br>
       First version to visualize a multi-level tyre wheel model.</li>
  </ul>
</html>"));
end PipeWithScalarField;
