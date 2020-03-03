within Modelica.Blocks.Tables.Internal;
pure function getDer2Table1DValue
  "Second derivative of interpolated 1-dim. table defined by matrix"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
  input Integer icol "Column number";
  input Real u "Abscissa value";
  input Real der_u "Derivative of abscissa value";
  input Real der2_u " Second derivative of abscissa value";
  output Real der2_y "Second derivative of interpolated value";
  external "C" der2_y = ModelicaStandardTables_CombiTable1D_getDer2Value(tableID, icol, u, der_u, der2_u)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
end getDer2Table1DValue;
