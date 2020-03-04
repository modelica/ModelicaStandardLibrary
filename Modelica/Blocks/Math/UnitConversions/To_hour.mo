within Modelica.Blocks.Math.UnitConversions;
block To_hour "Convert from second to hour"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="s"), y(
        unit="h"));
equation
  y = Modelica.Units.Conversions.to_hour(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="s"),Text(
              extent={{100,-20},{20,-100}},
              textString="hour")}), Documentation(info="<html>
<p>
This block converts the input signal from second to hour and returns
the result as output signal.
</p>
</html>"));
end To_hour;
