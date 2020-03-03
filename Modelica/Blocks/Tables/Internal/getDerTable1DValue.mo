within Modelica.Blocks.Tables.Internal;
pure function getDerTable1DValue
  "Derivative of interpolated 1-dim. table defined by matrix"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
  input Integer icol "Column number";
  input Real u "Abscissa value";
  input Real der_u "Derivative of abscissa value";
  output Real der_y "Derivative of interpolated value";
  external "C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  annotation (derivative(order=2) = getDer2Table1DValue);
end getDerTable1DValue;
