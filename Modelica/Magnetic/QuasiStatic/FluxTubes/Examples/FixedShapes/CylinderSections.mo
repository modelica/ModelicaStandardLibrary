within Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.FixedShapes;
model CylinderSections
"Magnetic circuit using different cylinder sections"
  extends Modelica.Icons.Example;
  parameter SI.RelativePermeability mu_rConst = 100
  "Relative permeability";
Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialInner(
  l=0.01,
  r_o=0.02,
  r_i=0.01,
    mu_rConst=mu_rConst)
  annotation (Placement(transformation(extent={{-20,10},{0,30}})));
Shapes.FixedShape.HollowCylinderRadialFlux hollowCylinderRadiaLRight(
    mu_rConst=mu_rConst,
    l=0.02,
    r_i=0.015,
    r_o=0.055)
            annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=90,
      origin={40,38})));
Shapes.FixedShape.HollowCylinderRadialFlux hollowCylinderRadialLeft(
    mu_rConst=mu_rConst,
    l=0.02,
    r_i=0.015,
    r_o=0.055)
            annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=270,
      origin={-60,40})));
Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialOuter(
  l=0.01,
  r_i=0.05,
    mu_rConst=mu_rConst,
    r_o=0.06)
             annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=180,
      origin={-10,60})));
Basic.Ground ground
  annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Blocks.Sources.Constant constFrequency(k=50)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
Sources.SignalMagneticFlux source(gamma(fixed=true, start=0))
                                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,-10})));
  Basic.Crossing crossing
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.ComplexBlocks.Sources.ComplexRampPhasor complexRamp(
    magnitude2=0.0008,
    phi=0,
    duration=1,
    magnitude1=0)
    annotation (Placement(transformation(extent={{0,-80},{-20,-60}})));
equation
connect(hollowCylinderAxialInner.port_n, hollowCylinderRadiaLRight.port_p)
  annotation (Line(
    points={{0,20},{40,20},{40,28}}, color={255,170,85}));
connect(hollowCylinderRadiaLRight.port_n, hollowCylinderAxialOuter.port_p)
  annotation (Line(
    points={{40,48},{40,60},{0,60}}, color={255,170,85}));
connect(hollowCylinderAxialOuter.port_n, hollowCylinderRadialLeft.port_p)
  annotation (Line(
    points={{-20,60},{-60,60},{-60,50}},
    color={255,170,85}));
  connect(constFrequency.y, source.f) annotation (Line(
      points={{-59,-70},{-46,-70},{-46,-22}},
      color={0,0,127}));
  connect(hollowCylinderRadialLeft.port_n, ground.port) annotation (Line(
      points={{-60,30},{-60,-10}},
      color={255,170,85}));
  connect(source.port_p, crossing.port_p2) annotation (Line(
      points={{-30,-10},{-30,0}},
      color={255,170,85}));
  connect(source.port_n, crossing.port_n1) annotation (Line(
      points={{-50,-10},{-50,-10},{-50,0}},
      color={255,170,85}));
  connect(crossing.port_n2, hollowCylinderAxialInner.port_p) annotation (Line(
      points={{-30,20},{-20,20}},
      color={255,170,85}));
  connect(crossing.port_p1, ground.port) annotation (Line(
      points={{-50,20},{-60,20},{-60,-10}},
      color={255,170,85}));
  connect(complexRamp.y, source.Phi) annotation (Line(points={{-21,-70},{-34,-70},{-34,-22}}, color={85,170,255}));
annotation (Documentation(info="<html>
<p>This model tests different types of cylinder sections in one example. The circuit is operated at 50Hz and variable magnetic flux.</p>
</html>"),
    experiment(StopTime=1,Interval=0.001));
end CylinderSections;
