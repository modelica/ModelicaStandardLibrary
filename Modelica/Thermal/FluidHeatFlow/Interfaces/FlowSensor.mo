within Modelica.Thermal.FluidHeatFlow.Interfaces;
partial model FlowSensor "Partial model of flow sensor"
  extends Modelica.Icons.RoundSensor;
  extends FluidHeatFlow.BaseClasses.TwoPort(
    final m=0,
    final T0=293.15,
    final T0fixed=false,
    final tapT=1);
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  // no pressure drop
  dp = 0;
  // no energy exchange
  Q_flow = 0;
annotation (Documentation(info="<html>
<p>Partial model for a flow sensor (mass flow/heat flow).</p>
<p>Pressure, mass flow, temperature and enthalpy flow of medium are not affected, but mixing rule is applied.</p>
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
end FlowSensor;
