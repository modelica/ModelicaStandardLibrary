within Modelica.Thermal.HeatTransfer.Fahrenheit;
model FromKelvin "Conversion from Kelvin to degree Fahrenheit"
  extends HeatTransfer.Icons.Conversion;
  Modelica.Blocks.Interfaces.RealInput Kelvin(unit="K")
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Fahrenheit(unit="degF")
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Fahrenheit = Modelica.Units.Conversions.to_degF(Kelvin);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{40,60},{100,0}},
          textColor={64,64,64},
          textString="degF"),
        Text(
          extent={{-100,60},{-40,0}},
          textColor={64,64,64},
          textString="K")}),
    Documentation(info="<html>
<p>
This component converts all input signals from Kelvin to Fahrenheit
and provides them as output signals.
</p>
</html>"));
end FromKelvin;
