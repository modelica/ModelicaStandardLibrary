within Modelica.Clocked.IntegerSignals;
package TickBasedSources "Package of signal source blocks generating clocked tick/sample based Integer signals"
   extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html>
<p>This package provides <strong>source</strong> components akin to the blocks provided in <a href=\"modelica://Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a>, but with the difference that they provide </p>
<ol>
<li>a <strong>clocked</strong> output signal and</li>
<li>are parametrized in terms of <strong>clock ticks</strong> rather than simulation time.</li>
</ol>
</html>"));
end TickBasedSources;
