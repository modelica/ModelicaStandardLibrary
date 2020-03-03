within Modelica.Blocks.Discrete;
block FirstOrderHold "First order hold of a sampled-data system"
  extends Modelica.Blocks.Interfaces.DiscreteSISO;
protected
  SI.Time tSample;
  Real uSample;
  Real pre_uSample;
  Real c;
initial equation
  pre(tSample) = time;
  pre(uSample) = u;
  pre(pre_uSample) = u;
  pre(c) = 0.0;
equation
  when sampleTrigger then
    tSample = time;
    uSample = u;
    pre_uSample = pre(uSample);
    c = if firstTrigger then 0 else (uSample - pre_uSample)/samplePeriod;
  end when;
  /* Use pre_uSample and pre(c) to break potential algebraic loops by an
       infinitesimal delay if both the continuous and the discrete part
       have direct feedthrough.
    */
  y = pre_uSample + pre(c)*(time - tSample);
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Line(points={{-79.0,-41.0},{-59.0,-33.0},{-40.0,1.0},{-20.0,9.0},{0.0,63.0},{21.0,20.0},{41.0,10.0},{60.0,20.0}},
        color={0,0,127}),
      Line(points={{60.0,20.0},{81.0,10.0}},
        color={0,0,127})}),
    Documentation(info="<html>
<p>
The output signal is the extrapolation through the
values of the last two sampled input signals.
</p>
</html>"));
end FirstOrderHold;
