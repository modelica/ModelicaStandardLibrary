within Modelica.Blocks.Tables.Internal;
pure function getTimeTableTmin
  "Return minimum abscissa value of 1-dim. table where first column is time"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
  output Real timeMin "Minimum abscissa value in table";
  external "C" timeMin = ModelicaStandardTables_CombiTimeTable_minimumTime(tableID)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
end getTimeTableTmin;
