within Modelica.Clocked.IntegerSignals.Sampler;
block Sample
  "Sample the continuous-time, Integer input signal and provide it as clocked output signal (clock is inferred)"
  extends Clocked.IntegerSignals.Interfaces.PartialSISOSampler;

equation
  y = sample(u);

  annotation (
   defaultComponentName="sample1",
   Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={
        Text(
          extent={{-150,90},{150,50}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
This block for Integer signals works similarly as the corresponding block for Real signals
(see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\">RealSignals.Sampler.Sample</a>).
</p>
<p>
Analog to the corresponding Real signal block examples there exist two elementary examples,
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.Sample1\">Sample1</a> and
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.Sample2\">Sample2</a>, for this Integer block.
</p>
</html>"));
end Sample;
