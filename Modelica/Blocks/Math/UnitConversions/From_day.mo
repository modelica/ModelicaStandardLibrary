within Modelica.Blocks.Math.UnitConversions;
block From_day "Convert from day to second"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="d"), y(
        unit="s"));
equation
  y = Modelica.Units.Conversions.from_day(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="day"),Text(
              extent={{100,-20},{20,-100}},
              textString="s")}), Documentation(info="<html>
<p>
This block converts the input signal from day to second and returns
the result as output signal.
</p>
</html>"));
end From_day;
