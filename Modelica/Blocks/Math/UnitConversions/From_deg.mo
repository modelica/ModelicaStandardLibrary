within Modelica.Blocks.Math.UnitConversions;
block From_deg "Convert from degree to radian"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="deg"),
      y(unit="rad"));
equation
  y = Modelica.Units.Conversions.from_deg(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="deg"),Text(
              extent={{100,-20},{20,-100}},
              textString="rad")}), Documentation(info="<html>
<p>
This block converts the input signal from degree to radian and returns
the result as output signal.
</p>
</html>"));
end From_deg;
