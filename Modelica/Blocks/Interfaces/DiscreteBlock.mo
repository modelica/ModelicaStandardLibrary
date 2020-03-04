within Modelica.Blocks.Interfaces;
partial block DiscreteBlock "Base class of discrete control blocks"
  extends Modelica.Blocks.Icons.DiscreteBlock;

  parameter SI.Time samplePeriod(min=100*Modelica.Constants.eps, start=0.1)
    "Sample period of component";
  parameter SI.Time startTime=0 "First sample time instant";
protected
  output Boolean sampleTrigger "True, if sample time instant";
  output Boolean firstTrigger(start=false, fixed=true)
    "Rising edge signals first sample instant";
equation
  sampleTrigger = sample(startTime, samplePeriod);
  when sampleTrigger then
    firstTrigger = time <= startTime + samplePeriod/2;
  end when;
  annotation (Documentation(info="<html>
<p>
Basic definitions of a discrete block of library
Blocks.Discrete.
The output(s) will only change at events, but are not formally a discrete variable(s) in Modelica.
The input(s) will be sampled, and can thus be continuous variable(s).
</p>

<p>
<strong>Important</strong>: If you connect several discrete blocks you should normally ensure that <strong>samplePeriod (and startTime)
are exactly identical</strong> for all blocks, since otherwise the output from one block will be transformed into a continuous signal
and sampled, which can cause a variable delay of up to one sample period leading to unexpected results.
</p>

<p>
Modelica 3.3 introduced synchronous operators that avoid the need to manually propagate samplePeriod to each block.
</p>
</html>"));
end DiscreteBlock;
