within Modelica.Blocks.Math.UnitConversions;
block From_kmh "Convert from kilometre per hour to metre per second"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="km/h"),
      y(unit="m/s"));
equation
  y = Modelica.Units.Conversions.from_kmh(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{26,80},{-96,48}},
              textString="km/h"),Text(
              extent={{92,-46},{-20,-82}},
              textString="m/s")}), Documentation(info="<html>
<p>
This block converts the input signal from kilometre per hour to metre per second and returns
the result as output signal.
</p>
</html>"));
end From_kmh;
