within Modelica.Clocked.ClockSignals.Clocks;
block PeriodicExactClock
  "Generate a periodic clock signal with a period defined by an Integer number with resolution"
  import Modelica.Clocked.Types.Resolution;

  parameter Integer factor(min=0)
    "Sample factor with respect to resolution" annotation(Evaluate=true);
  parameter Clocked.Types.Resolution resolution=Resolution.ms "Clock resolution"
    annotation (Evaluate=true, __Dymola_editText=false);
  extends Clocked.ClockSignals.Interfaces.PartialPeriodicClock;
protected
  constant Integer conversionTable[8]={365*24*60*60, 24*60*60, 60*60, 60, 1, 1000, 1000*1000, 1000*1000*1000}
    "Table to convert from Resolution to Integer clock resolution";
  parameter Integer resolutionFactor = conversionTable[Integer(resolution)] annotation(Evaluate=true);
  Clock c annotation(HideResult=true);
equation
  // The following then-branch using subSample corresponds to the simpler Clock(factor*resolutionFactor, 1),
  // but works better in some odd cases.
  //
  // Specifically the simple variant may fail if the product exceeds 2^31 (seconds), roughly 68 years.
  //
  // Using subSample works reliably up to 2^31 years according to the standard.
  //
  // There is no similar issue with the else-branch.
  if resolution < Resolution.s then
     c = subSample(Clock(factor), resolutionFactor);
  else
     c = Clock(factor, resolutionFactor);
  end if;

  if useSolver then
     y = Clock(c, solverMethod=solverMethod);
  else
     y = c;
  end if;

  annotation (
       defaultComponentName="periodicClock1",
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}, initialScale=0.06),
                    graphics={
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=90,
          origin={52,60},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=45,
          origin={-50,-120},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Text(
          extent={{-150,-110},{150,-150}},
          textColor={0,0,0},
          textString="%factor %resolution"),
        Text(
          visible=useSolver,
          extent={{-150,-160},{150,-200}},
          textColor={0,0,0},
          textString="%solverMethod")}),
    Documentation(info="<html>
<p>
This component generates a periodic clock that starts ticking when
the simulation starts. The <strong>period</strong> is defined as the product
of a resolution, defined with enumeration
<a href=\"modelica://Modelica.Clocked.Types.Resolution\">Resolution</a>,
and Integer parameter <strong>factor</strong>. Internally, the period is
represented as a rational number. All clocks with rational number definitions
are exactly time synchronized to each other.
</p>

<p>
Example:
</p>

<blockquote><pre>
import Modelica.Clocked.ClockSignals.Clocks;
import Modelica.Clocked.Types;
Clocks.PeriodicExactClock periodicClock(factor=10,
                                        resolution=Types.Resolution.ms);
// Clock ticks every 1/100 seconds
</pre></blockquote>

<p>
For an introduction to clocks see
<a href=\"modelica://Modelica.Clocked.UsersGuide.Clocks\">UsersGuide.Clocks</a>.
</p>

<p>
If a clock is associated to a clocked continuous-time partition, then an <strong>integrator</strong>
has to be defined that is used to integrate the partition from the previous
to the current clock tick. This is performed by setting parameter <strong>useSolver</strong>
= <strong>true</strong> and defining the integration method as String with
parameter <strong>solver</strong>. Both parameters are in tab <strong>Advanced</strong>.
For an example, see
<a href=\"modelica://Modelica.Clocked.Examples.Systems.ControlledMixingUnit\">Examples.Systems.ControlledMixingUnit</a>.
</p>
</html>"));
end PeriodicExactClock;
