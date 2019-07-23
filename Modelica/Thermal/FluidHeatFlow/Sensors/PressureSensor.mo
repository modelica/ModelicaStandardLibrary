within Modelica.Thermal.FluidHeatFlow.Sensors;
model PressureSensor "Absolute pressure sensor"

  extends FluidHeatFlow.Interfaces.AbsoluteSensor(y(unit="Pa", displayUnit=
          "bar") "Absolute pressure as output signal");
equation
  y = flowPort.p;
  annotation (
    Documentation(info="<html>
<p>The PressureSensor measures the absolute pressure.</p>
<p>Thermodynamic equations are defined by Interfaces.AbsoluteSensor.</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="Pa")}));
end PressureSensor;
