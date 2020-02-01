within Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.FixedShapes;
model CuboidSections "Magnetic circuit using different cuboid sections"
  extends Modelica.Icons.Example;
  parameter SI.RelativePermeability mu_rConst = 100
  "Relative permeability";
Basic.Ground ground
  annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
Sources.SignalMagneticPotentialDifference source(gamma(fixed=true, start=0))
                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,20})));
  Shapes.FixedShape.Cuboid cuboidBottom(
    mu_rConst=mu_rConst,
    l=0.1,
    a=0.01,
    b=0.01) annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Shapes.FixedShape.Cuboid cuboidTop(
    mu_rConst=mu_rConst,
    a=0.01,
    l=0.1,
    b=0.01) annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Shapes.FixedShape.Cuboid cuboidRight(
    mu_rConst=mu_rConst,
    a=0.01,
    l=0.005,
    b=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,40})));
  Shapes.FixedShape.Cuboid cuboidLeft(
    mu_rConst=mu_rConst,
    a=0.01,
    l=0.005,
    b=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,40})));
  Modelica.Blocks.Sources.Constant constFrequency(k=50)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Basic.Short short
    annotation (Placement(transformation(extent={{12,10},{32,30}})));
  Basic.Idle idle annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,40})));
  Modelica.ComplexBlocks.Sources.ComplexRampPhasor complexRamp(
    magnitude2=0.0008,
    phi=0,
    duration=1,
    magnitude1=0)
    annotation (Placement(transformation(extent={{0,-70},{-20,-50}})));
equation
  connect(source.port_n, ground.port) annotation (Line(
      points={{-50,20},{-60,20},{-60,-10}},
      color={255,170,85}));
  connect(cuboidLeft.port_p, cuboidTop.port_p) annotation (Line(
      points={{-60,50},{-60,60},{-20,60}},
      color={255,170,85}));
  connect(cuboidTop.port_n, cuboidRight.port_n) annotation (Line(
      points={{0,60},{40,60},{40,50}},
      color={255,170,85}));
  connect(cuboidBottom.port_p, source.port_p) annotation (Line(
      points={{-20,20},{-30,20}},
      color={255,170,85}));
  connect(source.port_n, cuboidLeft.port_n) annotation (Line(
      points={{-50,20},{-60,20},{-60,30}},
      color={255,170,85}));
  connect(constFrequency.y, source.f) annotation (Line(
      points={{-59,-60},{-46,-60},{-46,8}},
      color={0,0,127}));
  connect(cuboidBottom.port_n, short.port_p) annotation (Line(
      points={{0,20},{12,20}},
      color={255,170,85}));
  connect(short.port_n, cuboidRight.port_p) annotation (Line(
      points={{32,20},{40,20},{40,30}},
      color={255,170,85}));
  connect(idle.port_p, cuboidTop.port_n) annotation (Line(
      points={{80,50},{80,60},{0,60}},
      color={255,170,85}));
  connect(idle.port_n, short.port_n) annotation (Line(
      points={{80,30},{80,20},{32,20}},
      color={255,170,85}));
  connect(complexRamp.y, source.V_m) annotation (Line(points={{-21,-60},{-34,-60},{-34,8}},  color={85,170,255}));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false),          graphics={Text(
          extent={{-100,100},{100,80}},
          textColor={0,0,255},
          pattern=LinePattern.Dash,
          textString="Added short and idle model for testing purposes only")}),
    Documentation(info="<html>
<p>This model investigates a magnetic circuit consisting of four different cuboid sections. The circuit is operated at 50Hz and variable magnetic potential difference.</p>
</html>"),
    experiment(StopTime=1,Interval=0.001));
end CuboidSections;
