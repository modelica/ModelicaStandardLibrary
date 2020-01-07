within Modelica.Thermal.FluidHeatFlow.Sensors;
model RelTemperatureSensor "Temperature difference sensor"

  extends FluidHeatFlow.Interfaces.RelativeSensorBase;
  Modelica.Blocks.Interfaces.RealOutput y(unit="K")
    "Temperature difference as output signal"
	annotation (absoluteValue = false, Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  medium.cp*y = flowPort_a.h - flowPort_b.h;
  annotation (
    Documentation(info="<html>
<p>The RelTemperatureSensor measures the temperature difference between flowPort_a and flowPort_b.</p>
<p>Thermodynamic equations are defined by <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Interfaces.RelativeSensorBase\">Interfaces.RelativeSensorBase</a>.</p>
<p>
<strong>Note:</strong> Connected flowPorts have the same temperature (mixing temperature)!
Since mixing my occur, the outlet temperature of a component may be different from the connector's temperature.
Outlet temperature is defined by variable T of the corresponding component.
</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="K")}));
end RelTemperatureSensor;
