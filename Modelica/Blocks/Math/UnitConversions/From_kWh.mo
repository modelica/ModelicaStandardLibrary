within Modelica.Blocks.Math.UnitConversions;
block From_kWh "Convert from kilo Watt hour to Joule"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="kW.h"),
      y(unit="J"));
equation
  y = Modelica.Units.Conversions.from_kWh(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="kW.h"),Text(
              extent={{100,-20},{20,-100}},
              textString="J")}), Documentation(info="<html>
<p>
This block converts the input signal from kilo Watt hour to Joule and returns
the result as output signal.
</p>
</html>"));
end From_kWh;
