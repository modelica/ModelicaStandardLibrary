within Modelica.Electrical.Analog.Sensors;
model MultiSensor "Sensor to measure current, voltage and power"
  extends Modelica.Icons.RoundSensor;
  Modelica.Electrical.Analog.Interfaces.PositivePin pc
      "Positive pin, current path"
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin nc
      "Negative pin, current path"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pv
      "Positive pin, voltage path"
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin nv
      "Negative pin, voltage path"
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.Blocks.Interfaces.RealOutput i(final quantity="ElectricCurrent", final unit="A")
    "Current as output signal" annotation (Placement(transformation(
        origin={-60,-110},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput v(final quantity="ElectricPotential", final unit="V")
    "Voltage as output signal" annotation (Placement(transformation(
        origin={60,-110},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput power(final quantity="Power", final unit="W")
    "Instantaneous power as output signal"
    annotation (Placement(transformation(
          origin={-110,-60},
          extent={{-10,10},{10,-10}},
          rotation=180)));
equation
  pc.i + nc.i = 0;
  pc.v - nc.v = 0;
  pv.i = 0;
  nv.i = 0;
  i = pc.i;
  v = pv.v - nv.v;
  power = v*i;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Line(points = {{0,100},{0,70}}, color = {0,0,255}),
      Line(points = {{0,-70},{0,-100}}, color = {0,0,255}),
      Line(points = {{-100,0},{100,0}}, color = {0,0,255}),
      Line(points = {{0,70},{0,40}}),
        Line(points={{-100,-60},{-80,-60},{-56,-42}},
                                                   color={0,0,127}),
        Line(points={{-60,-100},{-60,-80},{-42,-56}},
                                                   color={0,0,127}),
        Line(points={{60,-100},{60,-80},{42,-56}},
                                                color={0,0,127}),
        Text(
          extent={{-100,-40},{-60,-80}},
            textColor={64,64,64},
            textString="W"),
        Text(
          extent={{-80,-60},{-40,-100}},
            textColor={64,64,64},
            textString="A"),
        Text(
          extent={{40,-60},{80,-100}},
            textColor={64,64,64},
            textString="V"),
      Text(textColor = {0,0,255}, extent = {{-150,120},{150,160}}, textString = "%name")}),
    Documentation(info="<html>
<p>This multi sensor measures current, voltage and instantaneous electrical power of a single-phase system and has a separated voltage and current path.
The pins of the voltage path are pv and nv, the pins of the current path are pc and nc.
The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.</p>
</html>", revisions="<html>
<ul>
<li><em>20170306</em> first implementation by Anton Haumer</li>
</ul>
</html>"));
end MultiSensor;
