within Modelica.Blocks.Tables.Internal;
pure function getNextTimeEvent
  "Return next time event value of 1-dim. table where first column is time"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
  input Real timeIn "(Scaled) time value";
  output Real nextTimeEvent "(Scaled) next time event in table";
  external "C" nextTimeEvent = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(tableID, timeIn)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
end getNextTimeEvent;
