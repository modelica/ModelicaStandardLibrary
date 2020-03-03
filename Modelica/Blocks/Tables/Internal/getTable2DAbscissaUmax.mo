within Modelica.Blocks.Tables.Internal;
pure function getTable2DAbscissaUmax
  "Return maximum abscissa value of 2-dim. table defined by matrix"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
  output Real uMax[2] "Maximum abscissa value in table";
  external "C" ModelicaStandardTables_CombiTable2D_maximumAbscissa(tableID, uMax)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
end getTable2DAbscissaUmax;
