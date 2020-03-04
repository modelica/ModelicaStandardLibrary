within Modelica.Blocks.Tables.Internal;
pure function getTable1DAbscissaUmax
  "Return maximum abscissa value of 1-dim. table defined by matrix"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
  output Real uMax "Maximum abscissa value in table";
  external "C" uMax = ModelicaStandardTables_CombiTable1D_maximumAbscissa(tableID)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
end getTable1DAbscissaUmax;
