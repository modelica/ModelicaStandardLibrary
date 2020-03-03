within Modelica.Blocks.Tables.Internal;
pure function getDerTimeTableValue
  "Derivative of interpolated 1-dim. table where first column is time"
  extends Modelica.Icons.Function;
  input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
  input Integer icol "Column number";
  input Real timeIn "(Scaled) time value";
  discrete input Real nextTimeEvent "(Scaled) next time event in table";
  discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
  input Real der_timeIn "Derivative of (scaled) time value";
  output Real der_y "Derivative of interpolated value";
  external "C" der_y = ModelicaStandardTables_CombiTimeTable_getDerValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn)
    annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  annotation (derivative(
      order=2,
      noDerivative=nextTimeEvent,
      noDerivative=pre_nextTimeEvent) = getDer2TimeTableValue);
end getDerTimeTableValue;
