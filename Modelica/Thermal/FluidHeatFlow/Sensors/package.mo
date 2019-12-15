within Modelica.Thermal.FluidHeatFlow;
package Sensors "Ideal sensors to measure port properties"
  extends Modelica.Icons.SensorsPackage;
  annotation (Documentation(info="<html>
<p>This package contains sensors:</p>
<ul>
<li>PressureSensor: absolute pressure</li>
<li>TemperatureSensor: absolute temperature (Kelvin)</li>
<li>RelPressureSensor: pressure drop between flowPort_a and flowPort_b</li>
<li>RelTemperatureSensor: temperature difference between flowPort_a and flowPort_b</li>
<li>MassFlowSensor: measures mass flow rate</li>
<li>VolumeFlowSensor: measures volume flow rate</li>
<li>EnthalpyFlowSensor: measures enthalpy flow rate</li>
</ul>

<p>Some of the sensors do not need access to medium properties for measuring,
but it is necessary to define the medium in the connector (check of connections).
Thermodynamic equations are defined in partial models (package BaseClasses).
All sensors are considered massless, they do not change mass flow or enthalpy flow.</p>

</html>"));
end Sensors;
