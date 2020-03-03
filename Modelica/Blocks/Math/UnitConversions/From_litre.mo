within Modelica.Blocks.Math.UnitConversions;
block From_litre "Convert from litre to cubic metre"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="l"), y(
        unit="m3"));
equation
  y = Modelica.Units.Conversions.from_litre(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="litre"),Text(
              extent={{100,-20},{20,-100}},
              textString="m3")}), Documentation(info="<html>
<p>
This block converts the input signal from litre to cubic metre and returns
the result as output signal.
</p>
</html>"));
end From_litre;
