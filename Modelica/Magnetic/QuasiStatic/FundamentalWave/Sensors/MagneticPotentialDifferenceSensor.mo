within Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors;
model MagneticPotentialDifferenceSensor
  "Sensor to measure magnetic potential difference"
  extends Modelica.Icons.RoundSensor;
  extends Interfaces.TwoPortElementary;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput V_m
    "Complex magnetic potential difference between port_p and port_n as output signal"
    annotation (Placement(transformation(
        origin={0,-100},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  SI.MagneticPotentialDifference abs_V_m=
      Modelica.ComplexMath.abs(V_m)
    "Magnitude of complex magnetic potential difference";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference";
  SI.ComplexMagneticFlux Phi "Complex magnetic flux";
equation
  // Flux into positive port
  port_p.V_m - port_n.V_m = V_m;
  // Magnetomotive force
  port_p.Phi = Phi;
  // Local flux balance
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // No magnetic flux through sensor
  Phi = Complex(0, 0);
  annotation (defaultComponentName="magVoltageSensor", Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={ Line(points={{-70,0},{-90,0}}, color={255,170,85}),
          Line(points={{70,0},{90,0}}, color={255,170,85}),
                                       Line(points={{0,-90},
          {0,-70}}, color={85,170,255}),
                    Text(
              extent={{-140,120},{140,80}},
              textString="%name",
              textColor={0,0,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="A")}), Documentation(info="<html>
<p>Sensor for magnetic potential difference.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticFluxSensor\">MagneticFluxSensor</a>
</p></html>"));
end MagneticPotentialDifferenceSensor;
