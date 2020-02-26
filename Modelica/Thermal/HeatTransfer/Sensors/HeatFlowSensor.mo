within Modelica.Thermal.HeatTransfer.Sensors;
model HeatFlowSensor "Heat flow rate sensor"
  extends Modelica.Icons.RoundSensor;
  Modelica.Blocks.Interfaces.RealOutput Q_flow(unit="W")
    "Heat flow from port_a to port_b as output signal" annotation (Placement(
        transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
equation
  port_a.T = port_b.T;
  port_a.Q_flow + port_b.Q_flow = 0;
  Q_flow = port_a.Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={191,0,0}),
        Line(points={{70,0},{90,0}}, color={191,0,0}),
        Line(points={{0,-70},{0,-100}},color={0,0,127}),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="W")}),
    Documentation(info="<html>
<p>
This model is capable of monitoring the heat flow rate flowing through
this component. The sensed value of heat flow rate is the amount that
passes through this sensor while keeping the temperature drop across the
sensor zero.  This is an ideal model so it does not absorb any energy
and it has no direct effect on the thermal response of a system it is included in.
The output signal is positive, if the heat flows from port_a to port_b.
</p>
</html>"));
end HeatFlowSensor;
