within Modelica.Electrical.Analog.Lines;
package Functions "Functions and records"
  extends Modelica.Icons.FunctionsPackage;
  annotation (Documentation(info="<html>
<p>This package class contains functions lineCmatrix and lineZmatrix that are able to compute C and Z matrices for a multple conductor transmission line (typically a power line), using one of the possible implementations of Carson&apos;s theory; see their documentation for details. </p>
<p>They are used in Modelica.Electrical.Analog.Examples.Lines models CompareCmatrix and PowerLineWIthFence (see their documentation for details). The latter model is an example of usage of Modelica.Electrical.Analog.Lines.M_Oline model.</p>
<p>These functions make usage of the lineGeometry record, which defines the geometry of a multi-conductor transmission line, with possibile ground return.</p>
</html>"));
end Functions;
