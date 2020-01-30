within Modelica.Thermal.HeatTransfer.Rankine;
model FromKelvin "Conversion from Kelvin to degree Rankine"
  extends HeatTransfer.Icons.Conversion;
  Modelica.Blocks.Interfaces.RealInput Kelvin(unit="K")
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Rankine(unit="degRk")
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Rankine = Modelica.Units.Conversions.to_degRk(Kelvin);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,60},{-40,0}},
          textColor={64,64,64},
          textString="K"),
        Text(
          extent={{40,60},{100,0}},
          textColor={64,64,64},
          textString="degRk")}),
    Documentation(info="<html>
<p>
This component converts all input signals from Kelvin to Rankine
and provides them as output signals.
</p>
</html>"));
end FromKelvin;
