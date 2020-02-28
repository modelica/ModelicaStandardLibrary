within Modelica.Thermal.HeatTransfer.Sensors;
model RelTemperatureSensor "Relative temperature sensor"
  extends Modelica.Icons.RectangularSensor;
  Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput T_rel(unit="K", displayUnit="K")
    "Relative temperature as output signal"
    annotation (absoluteValue=false, Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-110})));
equation
  T_rel = port_a.T - port_b.T;
  0 = port_a.Q_flow;
  0 = port_b.Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-90,0},{-70,0},{-70,0}}, color={191,0,0}),
        Line(points={{-90,0},{-70,0},{-70,0}}, color={191,0,0}),
        Line(points={{70,0},{90,0},{90,0}}, color={191,0,0}),
        Line(points={{0,-38},{0,-100}},color={0,0,127}),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-24,20},{66,-40}},
          textColor={64,64,64},
          textString="K")}),
    Documentation(info="<html>
<p>
The relative temperature \"port_a.T - port_b.T\" is determined between
the two ports of this component and is provided as output signal in Kelvin.
</p>
</html>"));
end RelTemperatureSensor;
