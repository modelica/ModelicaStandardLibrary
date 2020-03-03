within Modelica.Blocks.Math.UnitConversions;
block From_degC "Convert from degCelsius to Kelvin"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="degC"),
      y(unit="K"));
equation
  y = Modelica.Units.Conversions.from_degC(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="degC"),Text(
              extent={{100,-20},{20,-100}},
              textString="K")}), Documentation(info="<html>
<p>
This block converts the input signal from degCelsius to Kelvin and returns
the result as output signal.
</p>
</html>"));
end From_degC;
