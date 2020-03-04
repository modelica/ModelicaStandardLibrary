within Modelica.Blocks.Math.UnitConversions;
block To_gps "Convert from kilogram per second to gram per second"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="kg/s"),
      y(unit="g/s"));
equation
  y = Modelica.Units.Conversions.to_gps(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="kg/s"),Text(
              extent={{100,-20},{20,-100}},
              textString="g/s")}), Documentation(info="<html>
<p>
This block converts the input signal from kilogram per second to gram per seconds and returns
the result as output signal.
</p>
</html>"));
end To_gps;
