within Modelica.Thermal.FluidHeatFlow.Sensors;
model TemperatureSensor "Absolute temperature sensor"

  extends FluidHeatFlow.Interfaces.AbsoluteSensor(y(unit="K")
      "Absolute temperature as output signal");
equation
  medium.cp*y = flowPort.h;
annotation (
    Documentation(info="<html>
<p>The TempreatureSensor measures the absolute temperature (Kelvin).</p>
<p>Thermodynamic equations are defined by Interfaces.AbsoluteSensor.</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="K")}));
end TemperatureSensor;
