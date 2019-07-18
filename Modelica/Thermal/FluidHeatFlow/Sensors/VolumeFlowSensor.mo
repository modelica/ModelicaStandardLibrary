within Modelica.Thermal.FluidHeatFlow.Sensors;
model VolumeFlowSensor "Volume flow sensor"

  extends FluidHeatFlow.Interfaces.FlowSensor(y(unit="m3/s")
      "Volume flow as output signal");
equation
  y = V_flow;
  annotation (
    Documentation(info="<html>
<p>The VolumeFlowSensor measures the volume flow rate.</p>
<p>Thermodynamic equations are defined by Interfaces.FlowSensor.</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="m3/s")}));
end VolumeFlowSensor;
