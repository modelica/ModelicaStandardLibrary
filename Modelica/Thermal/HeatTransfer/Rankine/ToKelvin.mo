within Modelica.Thermal.HeatTransfer.Rankine;
model ToKelvin "Conversion from degree Rankine to Kelvin"
  extends HeatTransfer.Icons.Conversion;
  Modelica.Blocks.Interfaces.RealInput Rankine(unit="degRk")
   annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Kelvin(unit="K")
   annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Kelvin = Modelica.Units.Conversions.from_degRk(Rankine);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,60},{-40,0}},
          textColor={64,64,64},
          textString="degRk"),
        Text(
          extent={{40,60},{100,0}},
          textColor={64,64,64},
          textString="K")}),
    Documentation(info="<html>
<p>
This component converts all input signals from degree Rankine to Kelvin
and provides them as output signals.
</p>
</html>"));
end ToKelvin;
