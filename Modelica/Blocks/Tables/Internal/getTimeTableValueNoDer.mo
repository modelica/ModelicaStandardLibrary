within Modelica.Blocks.Tables.Internal;
pure function getTimeTableValueNoDer
  "Interpolate 1-dim. table where first column is time (but do not provide a derivative function)"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
  input Integer icol "Column number";
  input Real timeIn "(Scaled) time value";
  discrete input Real nextTimeEvent "(Scaled) next time event in table";
  discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
  output Real y "Interpolated value";
  external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
end getTimeTableValueNoDer;
