within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
block ComputationalDelay
  "Delay a clocked signal for at most one period, in order to model a computational delay"
extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Integer shiftCounter(min=0,max=resolution) = 0
    "(min=0, max=resolution), computational delay = interval()*shiftCounter/resolution"
       annotation(Evaluate=true,Dialog(group="Computational delay in seconds = interval() * shiftCounter/resolution"));
  parameter Integer resolution(min=1) = 1
    "Time quantization resolution of sample interval"
       annotation(Evaluate=true,Dialog(group="Computational delay in seconds = interval() * shiftCounter/resolution"));
protected
  Real ubuf(start=0.0);
equation
  assert(resolution >= shiftCounter, "The maximal computational delay has the length of one sample interval, however a larger value than that was set");
  ubuf = u;
  if shiftCounter < resolution then
     y = shiftSample(u, shiftCounter, resolution);
  else
     y = shiftSample(previous(ubuf), shiftCounter, resolution);
  end if;

  annotation (Documentation(info="<html>
<p>
This block delays a clocked Real input signal by the fraction
shiftCounter/resolution of the last interval.
There is the restriction that shiftCounter/resolution &le; 1.
</p>
</html>"));
end ComputationalDelay;
