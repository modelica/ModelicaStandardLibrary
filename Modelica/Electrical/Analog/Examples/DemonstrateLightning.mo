within Modelica.Electrical.Analog.Examples;
model DemonstrateLightning
  "Demonstrate trajectory of lightning current"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Time T1=10e-6 "Rise time";
  parameter Modelica.Units.SI.Time T2=350e-6 "Decay time to half value";
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Modelica.Blocks.Continuous.Der der1
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Blocks.Continuous.Der der2
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  Sources.LightningImpulse lightning1(
    approximation=Modelica.Electrical.Analog.Types.ImpulseApproximation.DoubleExp,

    amplitude=100e3,
    T1=T1,
    T2=T2,
    startTime=10e-6)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Sources.LightningImpulse lightning2(
    approximation=Modelica.Electrical.Analog.Types.ImpulseApproximation.Heidler,

    amplitude=100e3,
    T1=T1,
    T2=T2,
    startTime=10e-6)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
equation
  connect(integrator1.u, der1.u)
    annotation (Line(points={{8,80},{0,80},{0,50},{8,50}}, color={0,0,127}));
  connect(integrator2.u, der2.u)
    annotation (Line(points={{8,-20},{0,-20},{0,-50},{8,-50}}, color={0,0,127}));
  connect(lightning2.y, der2.u) annotation (Line(points={{-19,-40},{0,-40},{0,
          -50},{8,-50}}, color={0,0,127}));
  connect(lightning1.y, der1.u)
    annotation (Line(points={{-19,60},{0,60},{0,50},{8,50}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.001,
      Interval=1e-07,
      Tolerance=1e-06), Documentation(info="<html>
<p>
Compare 2 lightning trajectories: No.1 with double exponential function, No.2 with Heidler function.
</p>
</html>"));
end DemonstrateLightning;
