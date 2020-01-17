within Modelica.Thermal.FluidHeatFlow.Sensors;
model RelPressureSensor "Pressure difference sensor"

  extends FluidHeatFlow.Interfaces.RelativeSensorBase;
  Modelica.Blocks.Interfaces.RealOutput y(unit="Pa", displayUnit="bar")
    "Pressure difference as output signal"
 annotation (absoluteValue = false, Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  y = flowPort_a.p - flowPort_b.p;
annotation (
    Documentation(info="<html>
<p>The RelPressureSensor measures the pressure drop between flowPort_a and flowPort_b.</p>
<p>Thermodynamic equations are defined by <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Interfaces.RelativeSensorBase\">Interfaces.RelativeSensorBase</a>.</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="Pa")}));
end RelPressureSensor;
