within Modelica.Mechanics.MultiBody.Examples.Elementary;
model Surfaces
  "Demonstrate the visualization of a sine surface, as well as a torus and a wheel constructed from a surface"
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
        Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities.sineSurface (
           x_min=x_min,
           x_max=x_max,
           y_min=y_min,
           y_max=y_max,
           z_min=z_min,
           z_max=z_max,
           wz=wz),
    multiColoredSurface=false,
    nu=50,
    nv=50)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  inner World world(
    axisLength=1,
    n={0,0,-1},
    animateGround=true,
    groundLength_u=4,
    groundColor={215,215,215})
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Visualizers.Torus torus
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Joints.Prismatic prismatic(useAxisFlange=true, animation=false,
    v(fixed=true))
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Translational.Sources.Position position
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Blocks.Sources.Sine sine(amplitude=2, freqHz=0.5)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Parts.FixedTranslation fixedTranslation1(r={0,-1.3,torus.ro + torus.ri},
      animation=false)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Parts.FixedTranslation fixedTranslation2(
      animation=false, r={0,-1.6,wheel.rTire})
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Visualizers.VoluminousWheel wheel
    annotation (Placement(transformation(extent={{30,50},{50,70}})));
  Visualizers.PipeWithScalarField pipeWithScalarField(
    rOuter=0.3,
    length=1,
    T_min=0,
    T_max=2,
    T=Modelica.Math.sin(Modelica.Constants.pi*pipeWithScalarField.xsi)*
      Modelica.Math.cos(Modelica.Constants.pi*time) .+ 1,
    n_colors=32)
    annotation (Placement(transformation(extent={{14,-30},{34,-10}})));
  Parts.FixedTranslation fixedTranslation3(
      animation=false, r={0,-2.2,0})
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
equation
  connect(world.frame_b, prismatic.frame_a) annotation (Line(
      points={{-80,0},{-60,0},{-60,20},{-40,20}},
      color={95,95,95},
      thickness=0.5));
  connect(position.flange, prismatic.axis) annotation (Line(
      points={{-30,60},{-22,60},{-22,26}},          color={0,127,0}));
  connect(sine.y, position.s_ref) annotation (Line(
      points={{-59,60},{-52,60}}, color={0,0,127}));
  connect(prismatic.frame_b, fixedTranslation1.frame_a)
                                                       annotation (Line(
      points={{-20,20},{0,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_b, torus.frame_a)
                                                   annotation (Line(
      points={{20,20},{30,20}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, fixedTranslation2.frame_a) annotation (Line(
      points={{-20,20},{-10,20},{-10,60},{0,60}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation2.frame_b, wheel.frame_a) annotation (Line(
      points={{20,60},{30,60}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, fixedTranslation3.frame_a) annotation (Line(
      points={{-80,0},{-60,0},{-60,-20},{-20,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation3.frame_b, pipeWithScalarField.frame_a) annotation (
      Line(
      points={{0,-20},{14,-20}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=5),
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
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/Surfaces.png\">
</blockquote>

</html>"));
end Surfaces;
