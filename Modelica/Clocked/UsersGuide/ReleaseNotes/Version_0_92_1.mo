within Modelica.Clocked.UsersGuide.ReleaseNotes;
class Version_0_92_1 "Version 0.92.1 (March 11, 2016)"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
Version 0.92.1 is backward compatible to version 0.92
</p>

<p>
This version uses package Modelica 3.2.2.
</p>

<p>
Changes with respect to version 0.92:
</p>

<ul>
<li> RealSignals.Sampler: Removed wrong double declaration of u and y
    (was present due to extends and due to explicit declaration)</li>
<li> Invalid links in documentation fixed (#1341)</li>
<li> BooleanSignals.TickBasedSources.Pulse wrong unit fixed (#1889)</li>
<li> Missing useClock parameter in RealSignals.Sampler.AssignClock fixed (#1919)</li>
<li> Set Evaluate=true to clock parameters of {Real,Integer,Boolean}Signals.Sampler.{Shift,Back}Sample(OpenModelica Ticket 3717)</li>
</ul>
</html>"));
end Version_0_92_1;
