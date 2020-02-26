within Modelica.Clocked.UsersGuide.ReleaseNotes;
class Version_0_93_0 "Version 0.93.0 (April 10, 2019)"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
Version 0.93.0 is backward compatible to version 0.92.1
</p>

<p>Enhancements:</p>
<ul>
<li>Uses latest version of Modelica Standard Library (v3.2.3) (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/37\">#37</a>).</li>
<li>New blocks for event clocks that generate a clock tick each time an observed input angle changed (subpackage <a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.Rotational\">ClockSignals.Clocks.Rotational</a>) (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/34\">#34</a>, <a href=\"https://github.com/modelica/Modelica_Synchronous/issues/36\">#36</a>).</li>
<li>Improved engine-throttle control example using the new rotational event clocks (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/34\">#32</a>, <a href=\"https://github.com/modelica/Modelica_Synchronous/issues/36\">#33</a>).</li>
<li>Utilizing `SolverMethod` from the (tool-specific) ModelicaServices library (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/20\">#20</a>).</li>
<li>Improved icons.</li>
</ul>
<p>Bug fixes:</p>
<ul>
<li>Added tolerance for numeric comparisons <a href=\"modelica://Modelica.Clocked.BooleanSignals.TimeBasedSources.Pulse\">BooleanSignals.TimeBasedSources.Pulse</a> (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/9\">#9</a>).</li>
<li>Fixed over-constrained initial systems for several examples (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/10\">#10</a>, <a href=\"https://github.com/modelica/Modelica_Synchronous/issues/11\">#11</a>).</li>
<li>Fixed comparison against Real in <a href=\"modelica://Modelica.Clocked.BooleanSignals.TickBasedSources.Pulse\">BooleanSignals.TickBasedSources.Pulse</a> (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/12\">#12</a>).</li>
<li>Fixed too slow sampling in <a href=\"modelica://Modelica.Clocked.Examples.CascadeControlledDrive\">CascadeControlledDrive</a> examples (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/30\">#30</a>).</li>
</ul>

<p>Other (minor) fixes and improvements.</p>
</html>"));
end Version_0_93_0;
