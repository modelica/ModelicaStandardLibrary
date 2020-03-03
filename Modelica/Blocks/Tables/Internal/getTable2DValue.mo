within Modelica.Blocks.Tables.Internal;
pure function getTable2DValue "Interpolate 2-dim. table defined by matrix"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
  input Real u1 "Value of first independent variable";
  input Real u2 "Value of second independent variable";
  output Real y "Interpolated value";
  external "C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  annotation (derivative = getDerTable2DValue);
end getTable2DValue;
