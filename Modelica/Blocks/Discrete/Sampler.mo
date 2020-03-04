within Modelica.Blocks.Discrete;
block Sampler "Ideal sampling of continuous signals"
  extends Interfaces.DiscreteSISO;

equation
  when {sampleTrigger, initial()} then
    y = u;
  end when;
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Ellipse(lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        extent={{25.0,-10.0},{45.0,10.0}}),
      Line(points={{-100.0,0.0},{-45.0,0.0}},
        color={0,0,127}),
      Line(points={{45.0,0.0},{100.0,0.0}},
        color={0,0,127}),
      Line(points={{-35.0,0.0},{30.0,35.0}},
        color={0,0,127}),
      Ellipse(lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        extent={{-45.0,-10.0},{-25.0,10.0}})}),
    Documentation(info="<html>
<p>
Samples the continues input signal with a sampling rate defined
via parameter <strong>samplePeriod</strong>.
</p>
</html>"));
end Sampler;
