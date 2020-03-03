within Modelica.Blocks.Math.UnitConversions;
block To_litre "Convert from cubic metre to litre"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="m3"), y(
        unit="l"));
equation
  y = Modelica.Units.Conversions.to_litre(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="m3"),Text(
              extent={{100,-20},{20,-100}},
              textString="litre")}), Documentation(info="<html>
<p>
This block converts the input signal from metre to litre and returns
the result as output signal.
</p>
</html>"));
end To_litre;
