within Modelica.Clocked.UsersGuide;
class Clocks "Clocks"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<p>
A central element of the Modelica.Clocked library is a <strong>clock</strong>.
Below, the most important information for clocks is summarized.
For more details, see the Modelica Language Specification,
Chapter 16 (for Modelica Language Version &ge; 3.3).
</p>

<p>
A <strong>Clock</strong> type is a base data type (introduced in Modelica 3.3, additionally to Real, Integer, Boolean, String) that defines when a particular partition consisting of a set of equations is active. Starting with Modelica Language Version 3.3, every variable and every equation is either continuous-time or is associated exactly to one clock. This feature is visualized in the figure below where c(ti) is a clock that is active at particular time instants ti and r(ti) is a variable that is associated to this clock. A clocked variable has only a value when the corresponding clock is active:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Clocks/clockSignals.png\" alt=\"Clock variables and clocked variables\">
</div>

<p>
Similarly to RealInput, RealOutput etc., clock input and output connectors, called ClockInput and ClockOutput, are defined in sublibrary
<a href=\"modelica://Modelica.Clocked.ClockSignals.Interfaces\">ClockSignal.Interfaces</a>
in order to propagate clocks via connections. A clock signal can be generated with
one of the blocks of sublibrary
<a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks\">ClockSignals.Clocks</a>:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Clocks/clocks.png\" alt=\"Sublibrary ClockSignals.Clocks\">
</div>

<p>
The output signals of the blocks in the above figure are clock signals,
by default visualized with dotted grey lines.
</p>

<p>
With the blocks of sublibrary
<a href=\"modelica://Modelica.Clocked.ClockSignals.Sampler\">ClockSignals.Sampler</a>
a clock signal can be sub-sampled, super-sampled, or shift-sampled to generate
a new clock signal. For example, with the following model, a periodic clock signal of 0.1 s
is sub-sampled with a factor 3 and therefore a clock signal with a period of 0.3 s
is generated:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Clocks/subSampledClockExample.png\" alt=\"Sub-sample example model\"><br>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Clocks/subSampledClockResult.png\" alt=\"Sub-sample example plot\">
</div>

<p>
As usual in synchronous languages, a clock is represented by a <strong>true</strong> value
when the clock is active. The relationship between such derived
clocks is <strong>exact</strong>, so it is guaranteed that at every 3rd tick of clock
\"periodicRealClock.y\", the clock \"subSample.y\" is active.
</p>

<p>
If a clock is associated to a clocked continuous-time partition, then an <strong>integrator</strong>
has to be defined that is used to integrate the partition from the previous
to the current clock tick. This is performed by setting parameter <strong>useSolver</strong>
= <strong>true</strong> and defining the integration method as String with
parameter <strong>solver</strong>. Both parameters are in tab <strong>Advanced</strong>
of one of the clock signal generating blocks.
The possible integration methods are tool dependent. It is expected that
at least the solvers \"External\" (= use the integrator selected in the
simulation environment) and \"ExplicitEuler\" (= explicit Euler method)
are supported by every tool. For an example, see
<a href=\"modelica://Modelica.Clocked.Examples.Systems.ControlledMixingUnit\">Examples.Systems.ControlledMixingUnit</a>.
</p>

<p>
A clocked partition is a set of equations that depend
on each other and where the boundary variables are marked
with sample and hold operators.
If a clocked partition contains no operator <strong>der</strong>, <strong>delay</strong>,
<strong>spatialDistribution</strong>, no event related operators (with exception of <strong>noEvent</strong>(&hellip;)),
and no <strong>when</strong>-clause with a Boolean condition, it is a <strong>clocked discrete-time</strong>
partition, that is, it is a standard sampled data system that is described by difference equations.
If a clocked partition is <strong>not</strong> a <strong>clocked discrete-time</strong> partition and
it contains neither operator <strong>previous</strong> nor operator
<strong>interval</strong>, it is a
<strong>clocked discretized continuous-time</strong> partition.
Such a partition has to be solved with a <strong>solver</strong> method.
It is an error, if none of the two properties hold, e.g., if operators
<strong>previous</strong> and <strong>der</strong> are both used in the same partition.
In a clocked discrete-time partition all event generating mechanisms
do no longer apply. Especially neither relations, nor one of the built-in event
triggering operators will trigger an event.
</p>
</html>"));
end Clocks;
