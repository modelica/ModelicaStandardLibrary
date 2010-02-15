within Modelica.Magnetic.FundamentalWave.Sensors;
model MagneticPotentialDifferenceSensor
  "Sensor to measure magnetic potential difference"
  extends Modelica.Icons.RotationalSensor;
  extends Interfaces.PartialTwoPortElementary;

  Modelica.ComplexBlocks.Interfaces.ComplexOutput V_m
    "Complex magnetic potential difference between port_p and port_n as output signal"
     annotation (Placement(transformation(
        origin={0,-100},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";

equation
  // Flux into positive port
  port_p.V_m - port_n.V_m = V_m;

  // Magneto motive force
  port_p.Phi = Phi;

  // Local flux balance
  port_p.Phi + port_n.Phi = Complex(0,0);

  // No magnetic flux through sensor
  Phi = Complex(0,0);

  annotation (
    Window(
      x=0.28,
      y=0.29,
      width=0.6,
      height=0.6),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{-52,1},{48,-57}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "V_m"),
        Line(points={{-70,0},{-90,0}}, color={0,0,0}),
        Line(points={{70,0},{90,0}}, color={0,0,0}),
        Line(points={{0,-90},{0,-70}}),
        Text(extent={{-140,120},{140,80}}, textString=
                                               "%name")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-70,0},{-100,0}}, color={0,0,0}),
        Line(points={{70,0},{100,0}}, color={0,0,0}),
        Line(points={{0,-90},{0,-70}})}),
    Documentation(info="<html>
<p>Sensor for magnetic potential difference.</p>
</html>"));
end MagneticPotentialDifferenceSensor;
