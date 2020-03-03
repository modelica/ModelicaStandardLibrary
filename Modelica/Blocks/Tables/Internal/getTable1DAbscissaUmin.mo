within Modelica.Blocks.Tables.Internal;
pure function getTable1DAbscissaUmin
  "Return minimum abscissa value of 1-dim. table defined by matrix"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
  output Real uMin "Minimum abscissa value in table";
  external "C" uMin = ModelicaStandardTables_CombiTable1D_minimumAbscissa(tableID)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
end getTable1DAbscissaUmin;
