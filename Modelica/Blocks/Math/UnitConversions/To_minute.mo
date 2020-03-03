within Modelica.Blocks.Math.UnitConversions;
block To_minute "Convert from second to minute"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="s"), y(
        unit="min"));
equation
  y = Modelica.Units.Conversions.to_minute(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="s"),Text(
              extent={{100,-20},{20,-100}},
              textString="minute")}), Documentation(info="<html>
<p>
This block converts the input signal from second to minute and returns
the result as output signal.
</p>
</html>"));
end To_minute;
