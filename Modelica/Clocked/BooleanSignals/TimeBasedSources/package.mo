within Modelica.Clocked.BooleanSignals;
package TimeBasedSources "Package of signal source blocks generating clocked simulation time based Boolean signals"
   extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html>
<p>
This package provides <strong>source</strong> components akin to the blocks provided in
<a href=\"modelica://Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a>, but with the difference
that they provide a <strong>clocked</strong> output signal.
</p>
<p>
As an effect it is not necessary to use an intermediate Sample block if the output signal
is connected to a system that requires a clocked input signal. Therefore, it it can be slightly more convenient
to use the blocks provided in this package than to use the blocks offered by <a href=\"modelica://Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a>
(since one does not need to add an additional Sample block for the transition from a continuous time signal to a clocked signal).
</p>
</html>"));
end TimeBasedSources;
