within Modelica.Blocks.Math.UnitConversions;
block To_degC "Convert from Kelvin to degCelsius"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="K"), y(
        unit="degC"));

equation
  y = Modelica.Units.Conversions.to_degC(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}},
              textString="K"),Text(
              extent={{100,-20},{20,-100}},
              textString="degC")}), Documentation(info="<html>
<p>
This block converts the input signal from Kelvin to degCelsius and returns
the result as output signal.
</p>
</html>"));
end To_degC;
