within Modelica.Magnetic.QuasiStatic.FluxTubes.Sources;
model SignalMagneticFlux "Signal-controlled magnetic flux source"

  extends FluxTubes.Interfaces.Source;
  Modelica.Blocks.Interfaces.RealInput f(unit="Hz") annotation (Placement(
        transformation(
        origin={60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  SI.ComplexMagneticPotentialDifference V_m
  "Magnetic potential difference between both ports";
  Modelica.ComplexBlocks.Interfaces.ComplexInput Phi annotation (Placement(
        transformation(
        origin={-60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));

equation
  omega = 2*Modelica.Constants.pi*f;
  V_m = port_p.V_m - port_n.V_m;
  Complex(0) = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;
  annotation (
    defaultComponentName="magFluxSource",
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Polygon(
        points={{80,0},{60,6},{60,-6},{80,0}},
        lineColor={255,170,85},
        fillColor={255,170,85},
        fillPattern=FillPattern.Solid),
      Line(points={{-90,0},{-50,0}},  color={255,170,85}),
      Line(points={{50,0},{90,0}},  color={255,170,85}),
      Ellipse(
        extent={{-50,-50},{50,50}},
        lineColor={255,170,85},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{0,50},{0,-50}}, color={255,170,85})}),
    Documentation(info="<html>
<p>
This source provides a quasi-static magnetic flux with inputs for:
</p>
<ul>
<li>Complex magnetic flux, <code>Phi</code></li>
<li>Frequency <code>f</code></li>
</ul>
</html>"));
end SignalMagneticFlux;
