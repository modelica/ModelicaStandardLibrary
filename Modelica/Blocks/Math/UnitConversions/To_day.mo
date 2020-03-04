within Modelica.Blocks.Math.UnitConversions;
block To_day "Convert from second to day"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="s"), y(
        unit="d"));
equation
  y = Modelica.Units.Conversions.to_day(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="s"),Text(
              extent={{100,-20},{20,-100}},
              textString="day")}), Documentation(info="<html>
<p>
This block converts the input signal from second to day and returns
the result as output signal.
</p>
</html>"));
end To_day;
