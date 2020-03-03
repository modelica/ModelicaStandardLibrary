within Modelica.Blocks.Math.UnitConversions;
block To_deg "Convert from radian to degree"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="rad"),
      y(unit="deg"));
equation
  y = Modelica.Units.Conversions.to_deg(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="rad"),Text(
              extent={{100,-20},{20,-100}},
              textString="deg")}), Documentation(info="<html>
<p>
This block converts the input signal from radian to degree and returns
the result as output signal.
</p>
</html>"));
end To_deg;
