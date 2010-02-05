within Modelica.Magnetic.FundamentalWave.Sensors;
model MagneticFluxSensor "Sensor to measure magnetic flux"
  extends Modelica.Icons.RotationalSensor;
  extends Interfaces.PartialTwoPortElementary;

  Modelica.SIunits.ComplexMagneticPotentialDifference V_m
    "Complex magnetic potential difference";
  Modelica.ComplexBlocks.Interfaces.ComplexOutput Phi
    "Complex magnetic flux from por_ p to port_n as output signal" 
     annotation (Placement(transformation(
        origin={0,-100},
        extent={{10,-10},{-10,10}},
        rotation=90)));

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

  // No magnetic potential difference at sensor
  V_m.re = 0;
  V_m.im = 0;

  annotation (
    Window(
      x=0.23,
      y=0.07,
      width=0.6,
      height=0.6),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{-29,-11},{30,-70}},
          lineColor={0,0,0},
          textString=
               "Phi"),
        Line(points={{-70,0},{-90,0}}, color={0,0,0}),
        Text(extent={{-140,120},{140,80}}, textString=
                                               "%name"),
        Line(points={{70,0},{90,0}}, color={0,0,0}),
        Line(points={{0,-90},{0,-70}})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-70,0},{-100,0}}, color={0,0,0}),
        Line(points={{70,0},{100,0}}, color={0,0,0}),
        Line(points={{0,-90},{0,-70}})}),
    Documentation(info="<html>
<p>Sensor for magnetic flux.</p>
</html>"));
end MagneticFluxSensor;
