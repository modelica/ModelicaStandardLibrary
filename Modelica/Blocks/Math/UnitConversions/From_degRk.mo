within Modelica.Blocks.Math.UnitConversions;
block From_degRk "Convert from degRankine to Kelvin"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="degRk"),
      y(unit="K"));
equation
  y = Modelica.Units.Conversions.from_degRk(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="degRk"),Text(
              extent={{100,-20},{20,-100}},
              textString="K")}), Documentation(info="<html>
<p>
This block converts the input signal from degRankine to Kelvin and returns
the result as output signal.
</p>
</html>"));
end From_degRk;
