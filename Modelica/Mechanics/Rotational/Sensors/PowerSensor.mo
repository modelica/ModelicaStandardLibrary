within Modelica.Mechanics.Rotational.Sensors;
model PowerSensor
  "Ideal sensor to measure the power between two flanges (= flange_a.tau*der(flange_a.phi))"

  extends Rotational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput power(unit="W")
    "Power in flange flange_a as output signal"
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

equation
  flange_a.phi = flange_b.phi;
  power = flange_a.tau*der(flange_a.phi);
  annotation (
    Documentation(info="<html>
<p>
Measures the <strong>power between two flanges</strong> in an ideal way
and provides the result as output signal <strong>power</strong>
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
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="W")}));
end PowerSensor;
