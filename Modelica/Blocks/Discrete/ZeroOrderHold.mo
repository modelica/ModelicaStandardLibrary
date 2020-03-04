within Modelica.Blocks.Discrete;
block ZeroOrderHold "Zero order hold of a sampled-data system"
  extends Interfaces.DiscreteSISO;
  output Real ySample(start=0, fixed=true);

equation
  when {sampleTrigger, initial()} then
    ySample = u;
  end when;
  /* Define y=ySample with an infinitesimal delay to break potential
       algebraic loops if both the continuous and the discrete part have
       direct feedthrough
    */
  y = pre(ySample);
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Line(points={{-78.0,-42.0},{-52.0,-42.0},{-52.0,0.0},{-26.0,0.0},{-26.0,24.0},{-6.0,24.0},{-6.0,64.0},{18.0,64.0},{18.0,20.0},{38.0,20.0},{38.0,0.0},{44.0,0.0},{44.0,0.0},{62.0,0.0}},
        color={0,0,127})}),
    Documentation(info="<html>
<p>
The output is identical to the sampled input signal at sample
time instants and holds the output at the value of the last
sample instant during the sample points.
</p>
</html>"));
end ZeroOrderHold;
