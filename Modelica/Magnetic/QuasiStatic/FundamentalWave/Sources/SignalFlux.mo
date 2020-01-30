within Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources;
model SignalFlux "Source of time varying magnetic flux"
  extends Interfaces.TwoPortElementary;
  SI.ComplexMagneticPotentialDifference V_m
    "Complex magnetic potential difference";
  SI.MagneticPotentialDifference abs_V_m=
      Modelica.ComplexMath.abs(V_m)
    "Magnitude of complex magnetic potential difference";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference";

  Modelica.ComplexBlocks.Interfaces.ComplexInput Phi
    "Complex signal input of magnetic flux" annotation (Placement(
        transformation(
        origin={0,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
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
  annotation (defaultComponentName="magFluxSource", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Ellipse(
              extent={{-50,-50},{50,50}},
              lineColor={255,170,85},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}},
          color={255,170,85}),Line(points={{-50,0},{-100,0}}, color={255,170,85}),
          Line(points={{0,50},{0,-50}}, color={255,170,85}),
          Polygon(
              points={{80,0},{60,6},{60,-6},{80,0}},
              lineColor={255,170,85},
              fillColor={255,170,85},
              fillPattern=FillPattern.Solid),Line(points={{0,100},{0,50}},
          color={255,170,85}),
        Text(
          extent={{150,-60},{-150,-100}},
          textColor={0,0,255},
          textString="%name")}),      Documentation(info="<html>
<p>
Source of magnetic flux with complex signal input.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">
ConstantMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalMagneticPotentialDifference\">
SignalMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.ConstantFlux\">
ConstantFlux</a>

</p>

</html>"));
end SignalFlux;
