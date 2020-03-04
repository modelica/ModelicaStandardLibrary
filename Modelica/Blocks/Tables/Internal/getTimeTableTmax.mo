within Modelica.Blocks.Tables.Internal;
pure function getTimeTableTmax
  "Return maximum abscissa value of 1-dim. table where first column is time"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
  output Real timeMax "Maximum abscissa value in table";
  external "C" timeMax = ModelicaStandardTables_CombiTimeTable_maximumTime(tableID)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
end getTimeTableTmax;
