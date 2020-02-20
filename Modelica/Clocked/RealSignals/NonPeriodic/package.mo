within Modelica.Clocked.RealSignals;
package NonPeriodic "Library of blocks that operate on periodically and non-periodically clocked signals"
extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This package contains blocks that can be utilized for periodic and non-periodic
clocks. These blocks usually utilize the duration of the last interval for the computation of the
output signal. For example, the coefficients of the
<a href=\"modelica://Modelica.Clocked.RealSignals.NonPeriodic.PI\">PI</a>
block are computed from the coefficients of a continuous-time PI block
and from the duration of the last interval.
</p>
</html>"));
end NonPeriodic;
