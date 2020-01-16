within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialAbsoluteSensor
  "Partial model to measure a single absolute flange variable"
  extends Modelica.Icons.RoundSensor;

  Flange_a flange
    "Flange of shaft from which sensor information shall be measured"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

equation
  0 = flange.tau;
  annotation (Documentation(info="<html>
<p>
This is a partial model of a 1-dim. rotational component with one flange of a shaft
in order to measure an absolute kinematic quantity in the flange
and to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Line(points={{-70.0,0.0},{-90.0,0.0}}),
    Line(points={{70.0,0.0},{100.0,0.0}},
      color={0,0,127}),
    Text(textColor={0,0,255},
      extent={{-150.0,80.0},{150.0,120.0}},
      textString="%name")}));
end PartialAbsoluteSensor;
