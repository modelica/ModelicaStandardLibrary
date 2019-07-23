within Modelica.Thermal.FluidHeatFlow.Interfaces;
partial model AbsoluteSensor "Partial model of absolute sensor"
  extends Modelica.Icons.RoundSensor;
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
    "Sensor's medium" annotation (choicesAllMatching=true);
  FluidHeatFlow.Interfaces.FlowPort_a flowPort(final medium=medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  // no mass exchange
  flowPort.m_flow = 0;
  // no energy exchange
  flowPort.H_flow = 0;
annotation (Documentation(info="<html>
<p>Partial model for an absolute sensor (pressure/temperature).</p>
<p>Pressure, mass flow, temperature and enthalpy flow of medium are not affected.</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={255,0,0}),
        Line(points={{70,0},{100,0}}, color={0,0,127}),
        Text(
          extent={{-150,90},{150,130}},
          textString="%name",
          textColor={0,0,255})}));
end AbsoluteSensor;
