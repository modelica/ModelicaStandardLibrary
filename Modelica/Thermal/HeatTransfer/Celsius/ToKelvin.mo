within Modelica.Thermal.HeatTransfer.Celsius;
model ToKelvin "Conversion from degree Celsius to Kelvin"
  extends HeatTransfer.Icons.Conversion;
  Modelica.Blocks.Interfaces.RealInput Celsius(unit="degC")
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Kelvin(unit="K")
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Kelvin = Modelica.Units.Conversions.from_degC(Celsius);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{54,-88},{114,-148}},
          textColor={64,64,64},
          textString="degC"),
        Text(
          extent={{194,-88},{254,-148}},
          textColor={64,64,64},
          textString="K"),
        Text(
          extent={{-100,60},{-40,0}},
          textColor={64,64,64},
          textString="degC"),
        Text(
          extent={{40,60},{100,0}},
          textColor={64,64,64},
          textString="K")}),
    Documentation(info="<html>
<p>
This component converts an input signal from Celsius to Kelvin
and provide is as output signal.
</p>
</html>"));
end ToKelvin;
