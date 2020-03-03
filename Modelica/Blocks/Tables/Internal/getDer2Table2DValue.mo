within Modelica.Blocks.Tables.Internal;
pure function getDer2Table2DValue
  "Second derivative of interpolated 2-dim. table defined by matrix"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
  input Real u1 "Value of first independent variable";
  input Real u2 "Value of second independent variable";
  input Real der_u1 "Derivative of first independent variable";
  input Real der_u2 "Derivative of second independent variable";
  input Real der2_u1 "Second derivative of first independent variable";
  input Real der2_u2 "Second derivative of second independent variable";
  output Real der2_y "Second derivative of interpolated value";
  external "C" der2_y = ModelicaStandardTables_CombiTable2D_getDer2Value(tableID, u1, u2, der_u1, der_u2, der2_u1, der2_u2)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
end getDer2Table2DValue;
