within Modelica.Blocks.Math.UnitConversions;
block From_rpm "Convert from revolutions per minute to radian per second"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="rev/min"),
      y(unit="rad/s"));
equation
  y = Modelica.Units.Conversions.from_rpm(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{50,84},{-94,56}},
              textString="rev/min"),Text(
              extent={{94,-42},{-26,-74}},
              textString="rad/s")}), Documentation(info="<html>
<p>
This block converts the input signal from revolutions per minute to radian per second and returns
the result as output signal.
</p>
</html>"));
end From_rpm;
