within Modelica.Blocks.Math.UnitConversions;
block To_kmh "Convert from metre per second to kilometre per hour"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="m/s"),
      y(unit="km/h"));
equation
  y = Modelica.Units.Conversions.to_kmh(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{0,82},{-96,42}},
              textString="m/s"),Text(
              extent={{92,-40},{-14,-84}},
              textString="km/h")}), Documentation(info="<html>
<p>
This block converts the input signal from metre per second to kilometre per hour and returns
the result as output signal.
</p>
</html>"));
end To_kmh;
