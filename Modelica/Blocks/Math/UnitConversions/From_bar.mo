within Modelica.Blocks.Math.UnitConversions;
block From_bar "Convert from bar to Pascal"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="bar"),
      y(unit="Pa"));
equation
  y = Modelica.Units.Conversions.from_bar(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="bar"),Text(
              extent={{100,-20},{20,-100}},
              textString="Pa")}), Documentation(info="<html>
<p>
This block converts the input signal from bar to Pascal and returns
the result as output signal.
</p>
</html>"));
end From_bar;
