within Modelica.Magnetic.QuasiStatic.FluxTubes.Sources;
model SignalMagneticPotentialDifference
"Signal-controlled magnetomotive force"

  extends FluxTubes.Interfaces.Source;
  Modelica.Blocks.Interfaces.RealInput f(unit="Hz") annotation (Placement(
        transformation(
        origin={60,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120})));
  Modelica.ComplexBlocks.Interfaces.ComplexInput V_m annotation (Placement(
        transformation(
        origin={-60,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120})));
  SI.ComplexMagneticFlux Phi(re(start=0),im(start=0))
  "Magnetic flux from port_p to port_n";
equation
  omega = 2*Modelica.Constants.pi*f;
  V_m = port_p.V_m - port_n.V_m;
  Complex(0) = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;

  annotation (
    defaultComponentName="magVoltageSource",
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{-90,0},{-50,0}},  color={255,170,85}),
      Line(points={{50,0},{90,0}},  color={255,170,85}),
      Ellipse(
        extent={{-50,-50},{50,50}},
        lineColor={255,170,85},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{-50,0},{50,0}}, color={255,170,85}),
        Line(points={{-80,20},{-60,20}}, color={255,170,85}),
        Line(points={{-70,30},{-70,10}}, color={255,170,85}),
        Line(points={{60,20},{80,20}}, color={255,170,85})}),
    Documentation(info="<html>
<p>
This source provides a quasi-static magnetic potential difference <code>V_m</code> (or magnetomotive force, mmf)
with signal inputs for:
</p>
<ul>
<li>Complex magnetic potential difference, <code>V_m</code></li>
<li>Frequency <code>f</code></li>
</ul>
</html>"));
end SignalMagneticPotentialDifference;
