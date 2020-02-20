within Modelica.Clocked.RealSignals.Interfaces;
partial block SamplerIcon
  "Basic graphical layout of block used for sampling of Real signals"

  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
      graphics={
        Line(points={{-100,0},{-45,0}}, color={0,0,127}),
        Line(points={{-35,0},{30,35}}, color={0,0,127}),
        Ellipse(
          extent={{45,-10},{25,10}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{45,0},{100,0}}, color={0,0,127}),
        Ellipse(
          extent={{-25,-10},{-45,10}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end SamplerIcon;
