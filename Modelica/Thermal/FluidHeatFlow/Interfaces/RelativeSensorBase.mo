within Modelica.Thermal.FluidHeatFlow.Interfaces;
partial model RelativeSensorBase "Partial model of relative sensor without signal output"
  extends Modelica.Icons.RoundSensor;
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
    "Sensor's medium" annotation (choicesAllMatching=true);
  FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  // no mass exchange
  flowPort_a.m_flow = 0;
  flowPort_b.m_flow = 0;
  // no energy exchange
  flowPort_a.H_flow = 0;
  flowPort_b.H_flow = 0;
annotation (Documentation(info="<html>
<p>Partial model for a relative sensor (pressure drop/temperature difference) without signal output.</p>
<p>Pressure, mass flow, temperature and enthalpy flow of medium are not affected.</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={255,0,0}),
        Line(points={{70,0},{90,0}}, color={255,0,0}),
        Line(points={{0,-100},{0,-70}}, color={0,0,127}),
        Text(
          extent={{-150,90},{150,130}},
          textString="%name",
          textColor={0,0,255})}));
end RelativeSensorBase;
