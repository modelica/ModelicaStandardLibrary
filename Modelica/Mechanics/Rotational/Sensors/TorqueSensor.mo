within Modelica.Mechanics.Rotational.Sensors;
model TorqueSensor
  "Ideal sensor to measure the torque between two flanges (= flange_a.tau)"

  extends Rotational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
    "Torque in flange flange_a and flange_b (tau = flange_a.tau = -flange_b.tau) as output signal"
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

equation
  flange_a.phi = flange_b.phi;
  flange_a.tau = tau;
  annotation (
    Documentation(info="<html>
<p>
Measures the <strong>cut-torque between two flanges</strong> in an ideal way
and provides the result as output signal <strong>tau</strong>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Line(points={{-80.0,-100.0},{-80.0,0.0}},
      color={0,0,127}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="N.m")}));
end TorqueSensor;
