within Modelica.Blocks.Math.UnitConversions;
block From_gps "Convert from gram per second to kilogram per second"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="g/s"),
      y(unit="kg/s"));
equation
  y = Modelica.Units.Conversions.from_gps(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="g/s"),Text(
              extent={{100,-20},{20,-100}},
              textString="kg/s")}), Documentation(info="<html>
<p>
This block converts the input signal from gram per second to kilogram per second and returns
the result as output signal.
</p>
</html>"));
end From_gps;
