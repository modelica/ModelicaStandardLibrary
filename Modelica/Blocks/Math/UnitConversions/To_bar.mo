within Modelica.Blocks.Math.UnitConversions;
block To_bar "Convert from Pascal to bar"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="Pa"), y(
        unit="bar"));
equation
  y = Modelica.Units.Conversions.to_bar(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="Pa"),Text(
              extent={{100,-20},{20,-100}},
              textString="bar")}), Documentation(info="<html>
<p>
This block converts the input signal from Pascal to bar and returns
the result as output signal.
</p>
</html>"));
end To_bar;
