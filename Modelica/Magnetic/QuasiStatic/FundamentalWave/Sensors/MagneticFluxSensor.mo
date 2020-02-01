within Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors;
model MagneticFluxSensor "Sensor to measure magnetic flux"
  extends Modelica.Icons.RoundSensor;
  extends Interfaces.TwoPortElementary;
  SI.ComplexMagneticPotentialDifference V_m
    "Complex magnetic potential difference";
  Modelica.ComplexBlocks.Interfaces.ComplexOutput Phi
    "Complex magnetic flux from por_ p to port_n as output signal"
    annotation (Placement(transformation(
        origin={0,-100},
        extent={{10,-10},{-10,10}},
        rotation=90)));
 SI.MagneticFlux abs_Phi=Modelica.ComplexMath.abs(Phi)
    "Magnitude of complex magnetic flux";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
    "Argument of complex magnetic flux";

equation
  // Flux into positive port
  port_p.V_m - port_n.V_m = V_m;
  // Magnetomotive force
  port_p.Phi = Phi;
  // Local flux balance
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // No magnetic potential difference at sensor
  V_m = Complex(0, 0);
  annotation (defaultComponentName="magFluxSensor",
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={ Line(points={{-70,0},{-90,0}}, color={255,170,85}),
          Text(
              extent={{-140,120},{140,80}},
              textString="%name",
              textColor={0,0,255}),Line(points={{70,0},{90,0}}, color={255,170,85}),
          Line(points={{0,-90},{0,-70}}, color={85,170,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="Wb"),
        Line(points={{100,0},{-100,0}},color={255,170,85})}),
    Documentation(info="<html>
<p>Sensor for magnetic flux.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticPotentialDifferenceSensor\">MagneticPotentialDifferenceSensor</a>
</p>
</html>"));
end MagneticFluxSensor;
