within Modelica.Blocks.Math;
encapsulated package UnitConversions "Conversion blocks to convert between SI and non-SI unit signals"
  import Modelica;

  import Modelica.Units.NonSI;

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This package consists of blocks that convert an input signal
with a specific unit to an output signal in another unit
(e.g., conversion of an angle signal from \"deg\" to \"rad\").
</p>

</html>"));
end UnitConversions;
