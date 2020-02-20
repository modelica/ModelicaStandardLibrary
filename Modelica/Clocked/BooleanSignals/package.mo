within Modelica.Clocked;
package BooleanSignals "Library of clocked blocks for Boolean signals"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

  annotation (Documentation(info="<html>
<p>
This package contains blocks that operate on clocked Boolean signals.
Especially blocks are provided to transform from continuous-time Boolean signals to
clocked Boolean signals (with Sampler blocks) and vice versa
(with Hold blocks), as well as to transform a clocked Boolean signal from
one clock to a different clock in a time-synchronized way.
</p>
</html>"));
end BooleanSignals;
