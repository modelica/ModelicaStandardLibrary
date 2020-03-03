within Modelica.Blocks.Tables.Internal;
pure function getTable1DValue "Interpolate 1-dim. table defined by matrix"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
  input Integer icol "Column number";
  input Real u "Abscissa value";
  output Real y "Interpolated value";
  external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  annotation (derivative = getDerTable1DValue);
end getTable1DValue;
