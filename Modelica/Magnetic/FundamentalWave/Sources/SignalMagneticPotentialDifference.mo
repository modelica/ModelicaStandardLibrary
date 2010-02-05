within Modelica.Magnetic.FundamentalWave.Sources;
model SignalMagneticPotentialDifference
  "Source of magnetic potential difference with signal input"
  extends Interfaces.PartialTwoPortElementary;

  Modelica.ComplexBlocks.Interfaces.ComplexInput V_m
    "Complex signal input of magnetic potential difference" 
    annotation (Placement(transformation(
        origin={0,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
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

  annotation (Diagram(graphics),
                       Icon(graphics={
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
        Line(points={{-50,0},{50,0}}, color={255,127,0}),
        Line(points={{0,100},{0,50}}, color={255,127,0})}),
  Documentation(info="<html>
<p>
Source of magneto motive force with complex signal input.
</p>
</html>"));
end SignalMagneticPotentialDifference;
