within Modelica.Magnetic.FundamentalWave.Sources;
model ConstantMagneticPotentialDifference
  "Source with constant magnetic potential difference"
  extends Interfaces.PartialTwoPortElementary;
  parameter Modelica.SIunits.ComplexMagneticPotentialDifference V_m=
        Complex(re=1, im=0);

  Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";

equation
  // Flux into positive port
  port_p.V_m - port_n.V_m = V_m;

  // Magneto motive force
  port_p.Phi = Phi;

  // Local flux balance
  port_p.Phi + port_n.Phi = Complex(0,0);

  annotation (Diagram(graphics),
                       Icon(graphics={
        Text(
          extent={{-80,-20},{-80,-40}},
          lineColor={255,128,0},
          textString=
               "+"),
        Text(
          extent={{80,-20},{80,-40}},
          lineColor={255,128,0},
          textString=
               "-"),
        Ellipse(
          extent={{-50,-50},{50,50}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{100,0},{50,0}}, color={255,127,0}),
        Line(points={{-50,0},{-100,0}}, color={255,127,0}),
        Line(points={{-50,0},{50,0}}, color={255,127,0})}),
    Documentation(info="<html>
<p>
Source of constant magneto motive force.
</p>
</html>"));
end ConstantMagneticPotentialDifference;
