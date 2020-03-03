within Modelica.Blocks.Math.UnitConversions;
block To_degRk "Convert from Kelvin to degRankine"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="K"), y(
        unit="degRk"));
equation
  y = Modelica.Units.Conversions.to_degRk(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="K"),Text(
              extent={{100,-20},{20,-100}},
              textString="degRk")}), Documentation(info="<html>
<p>
This block converts the input signal from Kelvin to degRankine and returns
the result as output signal.
</p>
</html>"));
end To_degRk;
