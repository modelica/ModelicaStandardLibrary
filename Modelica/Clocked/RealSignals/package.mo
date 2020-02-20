within Modelica.Clocked;
package RealSignals "Library of clocked blocks for Real signals"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

  annotation (Documentation(info="<html>
<p>
This package contains blocks that operate on clocked Real signals.
Especially blocks are provided to transform from continuous-time Real signals to
clocked Real signals (with Sampler blocks) and vice versa
(with Hold blocks), as well as to transform a clocked Real signal from
one clock to a different clock in a time-synchronized way.
</p>
</html>"));
end RealSignals;
