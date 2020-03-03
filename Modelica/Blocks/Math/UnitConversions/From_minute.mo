within Modelica.Blocks.Math.UnitConversions;
block From_minute "Convert from minute to second"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="min"),
      y(unit="s"));
equation
  y = Modelica.Units.Conversions.from_minute(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="minute"),Text(
              extent={{100,-20},{20,-100}},
              textString="s")}), Documentation(info="<html>
<p>
This block converts the input signal from minute to second and returns
the result as output signal.
</p>
</html>"));
end From_minute;
