within Modelica.Mechanics.Rotational.Sensors;
model AngleSensor "Ideal sensor to measure the absolute flange angle"

  extends Rotational.Interfaces.PartialAbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput phi(unit="rad", displayUnit="deg")
    "Absolute angle of flange as output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  phi = flange.phi;
  annotation (
    Documentation(info="<html>
<p>
Measures the <strong>absolute angle phi</strong> of a flange in an ideal
way and provides the result as output signal <strong>phi</strong>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"),
       Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="rad")}));
end AngleSensor;
