within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialRelativeSensor
  "Partial model to measure a single relative variable between two flanges"
  extends Modelica.Icons.RoundSensor;

  Flange_a flange_a "Left flange of shaft" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b "Right flange of shaft" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));

equation
  0 = flange_a.tau + flange_b.tau;
  annotation (Documentation(info="<html>
<p>
This is a partial model for 1-dim. rotational components with two rigidly connected
flanges in order to measure relative kinematic quantities
between the two flanges or the cut-torque in the flange and
to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Line(points={{-70.0,0.0},{-90.0,0.0}}),
    Line(points={{70.0,0.0},{90.0,0.0}}),
    Text(textColor={0,0,255},
      extent={{-150,80},{150,120}},
      textString="%name")}));
end PartialRelativeSensor;
