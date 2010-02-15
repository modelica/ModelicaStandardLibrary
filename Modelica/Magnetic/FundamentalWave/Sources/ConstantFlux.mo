within Modelica.Magnetic.FundamentalWave.Sources;
model ConstantFlux "Source of constant magnetic flux"
  extends Interfaces.PartialTwoPortElementary;

  Modelica.SIunits.ComplexMagneticPotentialDifference V_m
    "Complex magnetic potential difference";
  parameter Modelica.SIunits.ComplexMagneticFlux Phi=
    Complex(re=1, im=0);

equation
  // Flux into positive port
  port_p.V_m - port_n.V_m = V_m;

  // Magneto motive force
  port_p.Phi = Phi;

  // Local flux balance
  port_p.Phi + port_n.Phi = Complex(0,0);

  annotation (Diagram(graphics),
                       Icon(graphics={
        Ellipse(
          extent={{-50,-50},{50,50}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{100,0},{50,0}}, color={255,127,0}),
        Line(points={{-50,0},{-100,0}}, color={255,127,0}),
        Line(points={{0,50},{0,-50}}, color={255,127,0}),
        Polygon(
          points={{80,0},{60,6},{60,-6},{80,0}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Source of constant magnetic flux.
</p>
</html>"));
end ConstantFlux;
