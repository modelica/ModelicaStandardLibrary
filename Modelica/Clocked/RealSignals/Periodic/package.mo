within Modelica.Clocked.RealSignals;
package Periodic "Library of blocks that are designed to operate only on periodically clocked signals (mainly described by z transforms)"
extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This package contains blocks that are designed for periodically clocked
system. Changing the sample rate (without changing at the same time the
parameters of the block), or using the blocks on non-periodically
clocked signals, will usually result in non-expected behavior.
</p>
</html>"));
end Periodic;
