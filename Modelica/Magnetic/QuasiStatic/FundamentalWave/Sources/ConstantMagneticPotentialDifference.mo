within Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources;
model ConstantMagneticPotentialDifference
  "Source with constant magnetic potential difference"
  extends Interfaces.TwoPortElementary;
  parameter SI.Frequency f(start=1) "Frequency of the source";
  parameter SI.ComplexMagneticPotentialDifference V_m=Complex(
      re=1, im=0) "Complex magnetic potential difference";
  SI.MagneticPotentialDifference abs_V_m=
      Modelica.ComplexMath.abs(V_m)
    "Magnitude of complex magnetic potential difference";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference";
  SI.ComplexMagneticFlux Phi "Complex magnetic flux";
  SI.MagneticPotentialDifference abs_Phi=
      Modelica.ComplexMath.abs(Phi) "Magnitude of complex magnetic flux";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
    "Argument of complex magnetic flux";
equation
  // Flux into positive port
  port_p.V_m - port_n.V_m = V_m;
  // Magnetomotive force
  port_p.Phi = Phi;
  // Local flux balance
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // Reference angular speed and angle
  omega = 2*Modelica.Constants.pi*f;
  Connections.root(port_p.reference);
  annotation (defaultComponentName="magVoltageSource",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                              Ellipse(
              extent={{-50,-50},{50,50}},
              lineColor={255,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}},
          color={255,127,0}),Line(points={{-50,0},{-100,0}}, color={255,127,0}),
          Line(points={{-50,0},{50,0}}, color={255,127,0}),
        Text(
          extent={{150,108},{-150,68}},
          textColor={0,0,255},
          textString="%name"),
        Line(points={{-80,20},{-60,20}}, color={255,127,0}),
        Line(points={{-70,30},{-70,10}}, color={255,127,0}),
        Line(points={{60,20},{80,20}}, color={255,127,0})}),
                                      Documentation(info="<html>
<p>
Source of constant magnetomotive force.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalMagneticPotentialDifference\">
SignalMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.ConstantFlux\">
ConstantFlux</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalFlux\">
SignalFlux</a>
</p>
</html>"));
end ConstantMagneticPotentialDifference;
