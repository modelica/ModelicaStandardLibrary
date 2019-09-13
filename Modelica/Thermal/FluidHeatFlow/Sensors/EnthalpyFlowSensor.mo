within Modelica.Thermal.FluidHeatFlow.Sensors;
model EnthalpyFlowSensor "Enthalpy flow sensor"

  extends FluidHeatFlow.Interfaces.FlowSensor(y(unit="W")
      "Enthalpy flow as output signal");
equation
  y = flowPort_a.H_flow;
  annotation (
    Documentation(info="<html>
<p>The EnthalpyFlowSensor measures the enthalpy flow rate.</p>
<p>Thermodynamic equations are defined by Interfaces.FlowSensor.</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="W")}));
end EnthalpyFlowSensor;
