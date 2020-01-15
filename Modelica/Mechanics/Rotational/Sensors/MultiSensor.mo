within Modelica.Mechanics.Rotational.Sensors;
model MultiSensor
  "Ideal sensor to measure the torque and power between two flanges (= flange_a.tau*der(flange_a.phi)) and the absolute angular velocity"
  extends .Modelica.Mechanics.Rotational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput power(unit="W")
    "Power in flange flange_a as output signal"
    annotation (Placement(transformation(
        origin={-60,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s")
    "Absolute angular velocity of flange_a as output signal" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,-110})));
  Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
    "Torque in flange flange_a and flange_b (tau = flange_a.tau = -flange_b.tau) as output signal"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  flange_a.phi = flange_b.phi;
  w = der(flange_a.phi);
  tau = flange_a.tau;
  power = tau*w;
  annotation (
    Documentation(info="<html>
<p>Measures the <strong>absolute angular velocity</strong> of a flange_a, the <strong>cut-torque</strong> and <strong>power</strong> between two flanges in an ideal way and provides the results as output signals <strong>w</strong>, <strong>tau</strong> and <strong>power</strong>, respectively.
</p>
</html>"),
       Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-60,-100},{-60,-60},{-94,-2}}),
        Line(points={{0,-100},{0,-70}}, color={0,0,127}),
        Line(points={{60,-100},{60,-60},{50,-50}}, color={0,0,127}),
        Text(
          extent={{-100,-60},{-60,-100}},
          textColor={64,64,64},
          textString="W"),
        Text(
          extent={{-20,-60},{20,-100}},
          textColor={64,64,64},
          textString="N.m"),
        Text(
          extent={{60,-60},{100,-100}},
          textColor={64,64,64},
          textString="rad/s")}));
end MultiSensor;
