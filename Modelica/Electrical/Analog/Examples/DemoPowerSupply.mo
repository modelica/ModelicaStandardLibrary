within Modelica.Electrical.Analog.Examples;
model DemoPowerSupply "Demonstrate behaviour of DC Power Supply"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.DCPowerSupply dcPowerSupply
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(transformation(extent={{-10,10},{10,-10}},      rotation = 90, origin={-20,50})));
  Modelica.Electrical.Analog.Basic.VariableConductor conductor annotation (
    Placement(transformation(extent={{10,50},{-10,30}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 6, duration = 1, offset = -3) annotation (
    Placement(transformation(extent = {{-60, 0}, {-40, 20}})));
  Modelica.Blocks.Math.Power power10(base=10)
    annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
equation
  connect(dcPowerSupply.n, ground.p) annotation (
    Line(points={{-10,60},{-10,50}},    color = {0, 0, 255}));
  connect(dcPowerSupply.p, conductor.p) annotation (
    Line(points={{10,60},{10,50},{10,50},{10,40}},
                                          color = {0, 0, 255}));
  connect(ground.p, conductor.n) annotation (
    Line(points={{-10,50},{-10,40}},    color = {0, 0, 255}));
  connect(power10.y, conductor.G)
    annotation (Line(points={{-9,10},{0,10},{0,28}}, color={0,0,127}));
  connect(ramp.y, power10.u)
    annotation (Line(points={{-39,10},{-32,10}}, color={0,0,127}));
  annotation (
    experiment(Interval = 1e-4, Tolerance = 1e-6, StartTime = 0, StopTime = 1),
    Documentation(info = "<html>
<p>
The DC power supply is loaded by a conductor, the conductance is increased by a logarithmic ramp from 1e-3 to 1e+3.
</p>
</html>"));
end DemoPowerSupply;
