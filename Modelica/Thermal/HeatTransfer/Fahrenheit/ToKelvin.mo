within Modelica.Thermal.HeatTransfer.Fahrenheit;
model ToKelvin "Conversion from degree Fahrenheit to Kelvin"
  extends HeatTransfer.Icons.Conversion;
  Modelica.Blocks.Interfaces.RealInput Fahrenheit(unit="degF") annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Kelvin(unit="K")
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Kelvin = Modelica.Units.Conversions.from_degF(Fahrenheit);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,60},{-40,0}},
          textColor={64,64,64},
          textString="degF"),
        Text(
          extent={{40,60},{100,0}},
          textColor={64,64,64},
          textString="K")}),
    Documentation(info="<html>
<p>
This component converts a input signal from degree Fahrenheit to Kelvin
and provides is as output signal.
</p>
</html>"));
end ToKelvin;
