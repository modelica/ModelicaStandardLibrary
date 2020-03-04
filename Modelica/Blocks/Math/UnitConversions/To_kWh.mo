within Modelica.Blocks.Math.UnitConversions;
block To_kWh "Convert from Joule to kilo Watt hour"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="J"), y(
        unit="kW.h"));
equation
  y = Modelica.Units.Conversions.to_kWh(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="J"),Text(
              extent={{100,-20},{20,-100}},
              textString="kW.h")}), Documentation(info="<html>
<p>
This block converts the input signal from Joule to kilo Watt hour and returns
the result as output signal.
</p>
</html>"));
end To_kWh;
