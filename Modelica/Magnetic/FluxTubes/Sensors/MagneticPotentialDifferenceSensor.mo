within Modelica.Magnetic.FluxTubes.Sensors;
model MagneticPotentialDifferenceSensor
  "Sensor to measure magnetic potential difference"
  extends Modelica.Icons.RoundSensor;
  extends Interfaces.TwoPortElementary;

  Modelica.Blocks.Interfaces.RealOutput V_m(final quantity=
        "MagneticPotential", final unit="A")
    "Magnetic potential difference between ports p and n as output signal"
    annotation (Placement(transformation(
        origin={0,-100},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  SI.MagneticFlux Phi "Magnetic flux from port_p to port_n";

equation
  V_m = port_p.V_m - port_n.V_m;
  Phi = port_p.Phi;
  Phi = 0;
  0 = port_p.Phi + port_n.Phi;

  annotation (defaultComponentName="magVoltageSensor",
Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={255,128,0}),
        Line(points={{70,0},{90,0}}, color={255,128,0}),
        Line(points={{0,-90},{0,-70}}, color={0,0,127}),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="A")}),      Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={Line(points={{-70,0},{-100,0}}, color={255,128,0}),
          Line(points={{70,0},{100,0}}, color={255,128,0}),Line(
          points={{0,-100},{0,-70}})}));
end MagneticPotentialDifferenceSensor;
