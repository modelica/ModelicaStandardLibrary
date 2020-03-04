within Modelica.Blocks.Math.UnitConversions;
block To_rpm "Convert from radian per second to revolutions per minute"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="rad/s"),
      y(unit="rev/min"));
equation
  y = Modelica.Units.Conversions.to_rpm(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{26,82},{-98,50}},
              textString="rad/s"),Text(
              extent={{100,-42},{-62,-74}},
              textString="rev/min")}), Documentation(info="<html>
<p>
This block converts the input signal from radian per second to revolutions per minute and returns
the result as output signal.
</p>
</html>"));
end To_rpm;
