within Modelica.Mechanics.Rotational.Sensors;
model RelAngleSensor
  "Ideal sensor to measure the relative angle between two flanges"

  extends Rotational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput phi_rel(unit="rad", displayUnit="deg")
    "Relative angle between two flanges (= flange_b.phi - flange_a.phi) as output signal"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

equation
  phi_rel = flange_b.phi - flange_a.phi;
  0 = flange_a.tau;
  annotation (
    Documentation(info="<html>
<p>
Measures the <strong>relative angle phi_rel</strong> between two flanges
in an ideal way and provides the result as output signal <strong>phi_rel</strong>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
   Line(points={{0.0,-100.0},{0.0,-70.0}},
    color={0,0,127}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="rad")}));
end RelAngleSensor;
