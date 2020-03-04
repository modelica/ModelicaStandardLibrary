within Modelica.Blocks.Tables.Internal;
pure function getDerTable2DValue
  "Derivative of interpolated 2-dim. table defined by matrix"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
  input Real u1 "Value of first independent variable";
  input Real u2 "Value of second independent variable";
  input Real der_u1 "Derivative of first independent variable";
  input Real der_u2 "Derivative of second independent variable";
  output Real der_y "Derivative of interpolated value";
  external "C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  annotation (derivative(order=2) = getDer2Table2DValue);
end getDerTable2DValue;
