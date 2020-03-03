within Modelica.Blocks.Math.UnitConversions;
block To_degF "Convert from Kelvin to degFahrenheit"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="K"), y(
        unit="degF"));
equation
  y = Modelica.Units.Conversions.to_degF(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="K"),Text(
              extent={{100,-20},{20,-100}},
              textString="degF")}), Documentation(info="<html>
<p>
This block converts the input signal from Kelvin to degFahrenheit and returns
the result as output signal.
</p>
</html>"));
end To_degF;
