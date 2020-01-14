within Modelica.Mechanics.Translational.Sensors;
model ForceSensor "Ideal sensor to measure the force between two flanges"
  extends Translational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput f(unit="N")
    "Force in flange_a and flange_b (f = flange_a.f = -flange_b.f) as output signal"
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  flange_a.s = flange_b.s;
  flange_a.f = f;
  annotation (
    Documentation(info="<html>
<p>
Measures the <em>cut-force between two flanges</em> in an ideal way
and provides the result as output signal (to be further processed
with blocks of the Modelica.Blocks library).
</p>

</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={    Line(points={{-80,-100},
          {-80,0}}, color={0,0,127}),
        Text(
          extent={{-24,20},{66,-40}},
          textColor={64,64,64},
          textString="N")}));
end ForceSensor;
