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
  port_p.V_m.re - port_n.V_m.re = V_m.re;
  port_p.V_m.im - port_n.V_m.im = V_m.im;

  // Magneto motive force
  port_p.Phi.re = Phi.re;
  port_p.Phi.im = Phi.im;

  // Local flux balance
  port_p.Phi.re + port_n.Phi.re = 0;
  port_p.Phi.im + port_n.Phi.im = 0;

  // No magnetic flux through sensor
  Phi.re = 0;
  Phi.im = 0;

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
