within Modelica.Mechanics.MultiBody.Examples.Elementary;
model Surfaces
  "Demonstrate the visualization of a sine surface, as well as a torus and a wheel constucted from a surface"
  extends Modelica.Icons.Example;
  parameter Real x_min=-1 "Minimum value of x";
  parameter Real x_max=+1 "Maximum value of x";
  parameter Real y_min=-1 "Minimum value of y";
  parameter Real y_max=+1 "Maximum value of y";
  parameter Real z_min=0 "Minimum value of z";
  parameter Real z_max=1 "Maximum value of z";
  Real wz = time;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface surface(
    redeclare function surfaceCharacteristic =
        Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities.sineSurface
        (  x_min=x_min,
           x_max=x_max,
           y_min=y_min,
           y_max=y_max,
           z_min=z_min,
           z_max=z_max,
           wz=wz),
    multiColoredSurface=false,
    nu=50,
    nv=50)
    annotation (Placement(transformation(extent={{-72,-52},{-52,-32}})));
  inner World world(axisLength=1, n={0,0,-1})
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Visualizers.Torus torus
    annotation (Placement(transformation(extent={{32,20},{52,40}})));
  Joints.Prismatic prismatic(useAxisFlange=true, animation=false,
    v(fixed=true))
    annotation (Placement(transformation(extent={{-38,20},{-18,40}})));
  Translational.Sources.Position position
    annotation (Placement(transformation(extent={{-66,70},{-46,90}})));
  Blocks.Sources.Sine sine(amplitude=2, freqHz=0.5)
    annotation (Placement(transformation(extent={{-98,70},{-78,90}})));
  Visualizers.Ground ground(          groundColor={215,215,215}, length=4)
    annotation (Placement(transformation(extent={{-72,-16},{-52,4}})));
  Parts.FixedTranslation fixedTranslation1(r={0,-1.3,torus.ro + torus.ri},
      animation=false)
    annotation (Placement(transformation(extent={{-4,20},{16,40}})));
  Parts.FixedTranslation fixedTranslation2(
      animation=false, r={0,-1.6,wheel.rTire})
    annotation (Placement(transformation(extent={{-4,50},{16,70}})));
  Visualizers.VoluminousWheel wheel
    annotation (Placement(transformation(extent={{32,50},{52,70}})));
  Visualizers.PipeWithScalarField pipeWithScalarField(
    rOuter=0.3,
    length=1,
    T_min=0,
    T_max=2,
    T=sin(Modelica.Constants.pi*pipeWithScalarField.xsi)*cos(Modelica.Constants.pi
        *time) .+ 1,
    n_colors=32)
    annotation (Placement(transformation(extent={{14,-30},{34,-10}})));
  Parts.FixedTranslation fixedTranslation3(
      animation=false, r={0,-2.2,0})
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
equation
  connect(world.frame_b, prismatic.frame_a) annotation (Line(
      points={{-60,30},{-38,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(position.flange, prismatic.axis) annotation (Line(
      points={{-46,80},{-24,80},{-24,36},{-20,36}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(sine.y, position.s_ref) annotation (Line(
      points={{-77,80},{-68,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prismatic.frame_b, fixedTranslation1.frame_a)
                                                       annotation (Line(
      points={{-18,30},{-4,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation1.frame_b, torus.frame_a)
                                                   annotation (Line(
      points={{16,30},{32,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prismatic.frame_b, fixedTranslation2.frame_a) annotation (Line(
      points={{-18,30},{-14,30},{-14,60},{-4,60}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation2.frame_b, wheel.frame_a) annotation (Line(
      points={{16,60},{32,60}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(world.frame_b, fixedTranslation3.frame_a) annotation (Line(
      points={{-60,30},{-46,30},{-46,-20},{-20,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation3.frame_b, pipeWithScalarField.frame_a) annotation (
      Line(
      points={{0,-20},{14,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=5),
    experimentSetupOutput,
    Documentation(info="<html>
<p>
This example demonstrates the use of the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Surface</a>
visualizer that visualizes a moving, parameterized surface.
The \"sine-wave\" surface is a direct application of the surface model.
Furthermore, the \"torus\" surface is an instance of
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a>,
the \"wheel\" surface is an instance of
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel\">VoluminousWheel</a>,
and the \"pipeWithScalarField surface is an instance of
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a>.
All latter visual shapes are constructed with the surface model.
The following image shows a screen-shot of this example model:
</p

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Elementary/Surfaces.png\">
</blockquote>

</html>"));
end Surfaces;
