within Modelica.Clocked;
package IntegerSignals "Library of clocked blocks for Integer signals"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

  annotation (Documentation(info="<html>
<p>
This package contains blocks that operate on clocked Integer signals.
Especially blocks are provided to transform from continuous-time Integer signals to
clocked Integer signals (with Sampler blocks) and vice versa
(with Hold blocks), as well as to transform a clocked Integer signal from
one clock to a different clock in a time-synchronized way.
</p>
</html>"));
end IntegerSignals;
