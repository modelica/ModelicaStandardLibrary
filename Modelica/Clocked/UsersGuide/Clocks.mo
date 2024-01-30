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
The <strong>Clock</strong> type is a base data type introduced in Modelica 3.3 (additionally to Real, Boolean&hellip;)
which can be understood as a <em>specialized Boolean</em> type:
Clock variables are either true (also called \"active\") or false (\"inactive\").
It is specialized in the sense that each Clock variable generates a <strong>partition</strong>
consisting of a set of equations which gets activated when the clock is active.
In fact, every variable and every equation of a Modelica model (starting with Modelica Language Version 3.3)
is assigned to a partition:
</p>
<ul>
    <li>either the global continuous-time partition (no associated clock)</li>
    <li>or a <strong>clocked partition</strong>, associated to <em>exactly one</em> clock (see more details below).</li>
</ul>
<p>
This feature is visualized in the figure below where c(ti) is a clock that is active
at particular time instants ti and r(ti) is a variable that is associated to this clock.
Notice that a clocked variable has <em>only a value when the corresponding clock is active</em>:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Clocks/clockSignals.png\" alt=\"Clock variables and clocked variables\">
</div>

<h4>Clock blocks and connectors</h4>
<p>
The Clock type introduced above is a base type of the Modelica language
and it is mostly intended for textual model description.
The Clocked library encapsulates this base type and allows for
graphical modeling thanks to the clock blocks and connectors it provides.
</p>
<p>
Similarly to RealInput, RealOutput etc., clock input and output connectors, called ClockInput and ClockOutput, are defined in sublibrary
<a href=\"modelica://Modelica.Clocked.ClockSignals.Interfaces\">ClockSignal.Interfaces</a>
in order to propagate clocks via connections.
</p>
<p>
A clock signal can be generated with one of the blocks of sublibrary
<a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks\">ClockSignals.Clocks</a>:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Clocks/clocks.png\" alt=\"Sublibrary ClockSignals.Clocks\">
</div>

<p>
The output signals of the blocks in the above figure are clock signals,
by default visualized with dotted grey lines.
</p>

<h4>Derived clocks (sub/super/shift-sampling)</h4>
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
The relationship between such derived
clocks is <strong>exact</strong>, so it is guaranteed that at every 3rd tick of clock
\"periodicRealClock.y\", the clock \"subSample.y\" is active.
</p>

<h4>The two types of clocked partitions</h4>
<p>
A clocked partition is a set of equations that depend
on each other and where the boundary variables are marked
with sample and hold operators (boundary with other clocked partitions
or with the global continuous-time partition).

A sub-clock partition is a part of clock partition that use a specific derived clock,
separated from other sub-clock partions by operators like <strong>subSample</strong> and <strong>superSample</strong>.
All equations within a sub-clock partition are active at the same time.
</p>
<p>
There are two types of sub-clock partitions:
</p>
<ul>
    <li>A <strong>clocked discrete-time</strong> partition shall contain
    <em>no operator relating to continuous time</em>:
    <strong>der</strong>, <strong>delay</strong>, <strong>spatialDistribution</strong>,
    no event-related operators (with exception of <strong>noEvent</strong>(&hellip;)),
    and no <strong>when</strong>-clause with a Boolean condition.
    A clocked discrete-time partition is thus a standard sampled data system described by difference equations
    (it can contain calls of the <strong>previous</strong> operator).</li>
    <li>A <strong>clocked discretized continuous-time</strong> partition shall contain
    neither operator <strong>previous</strong> nor operator <strong>interval</strong> (i.e. discrete-time operators).
    It can contain continuous time operators (<strong>der</strong>&hellip;) and it has to be solved with a <strong>solver</strong> (see below).
    </li>
</ul>
<p>
Notice that it is an error if a partition doesn't fall into one of these two categories, e.g., if operators
<strong>previous</strong> and <strong>der</strong> are both used in the same partition.
This means it is <em>not allowed to mix continuous time and discrete-time operators</em> in a clocked partition
(unlike in the global continuous time partition).
</p>
<p>
Also notice that in a clocked discrete-time partition all event-generating mechanisms
do no longer apply. Especially neither relations, nor one of the built-in event
triggering operators will trigger an event.
</p>

<h4>Solver for clocked discretized continuous-time partitions</h4>
<p>
If a clock is associated to a clocked continuous-time partition, then an <strong>integrator</strong>
has to be defined that is used to integrate the partition from the previous
to the current clock tick.
This is performed by setting, for the corresponding clock signal generating block,
parameter <strong>useSolver</strong> = <strong>true</strong>
and defining the integration method as String with parameter <strong>solver</strong>.
Both parameters are to be found in tab <strong>Advanced</strong>
of clock signal generating blocks.
The possible integration methods are tool dependent. It is expected that
at least the solvers \"External\" (= use the integrator selected in the
simulation environment) and \"ExplicitEuler\" (= explicit Euler method)
are supported by every tool. For an example, see
<a href=\"modelica://Modelica.Clocked.Examples.Systems.ControlledMixingUnit\">Examples.Systems.ControlledMixingUnit</a>.
</p>
</html>"));
end Clocks;
