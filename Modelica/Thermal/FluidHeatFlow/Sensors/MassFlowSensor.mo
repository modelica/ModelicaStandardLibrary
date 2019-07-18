within Modelica.Thermal.FluidHeatFlow.Sensors;
model MassFlowSensor "Mass flow sensor"

  extends FluidHeatFlow.Interfaces.FlowSensor(y(unit="kg/s")
      "Mass flow as output signal");
equation
  y = V_flow*medium.rho;
  annotation (
    Documentation(info="<html>
<p>The MassFlowSensor measures the mass flow rate.</p>
<p>Thermodynamic equations are defined by Interfaces.FlowSensor.</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="kg/s")}));
end MassFlowSensor;
