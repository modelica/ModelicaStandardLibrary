within Modelica.Blocks.Types;
class ExternalCombiTimeTable
  "External object of 1-dim. table where first column is time"
  extends ExternalObject;

  function constructor "Initialize 1-dim. table where first column is time"
    extends Modelica.Icons.Function;
    input String tableName "Table name";
    input String fileName "File name";
    input Real table[:, :];
    input SI.Time startTime;
    input Integer columns[:];
    input Modelica.Blocks.Types.Smoothness smoothness;
    input Modelica.Blocks.Types.Extrapolation extrapolation;
    input SI.Time shiftTime=0.0;
    input Modelica.Blocks.Types.TimeEvents timeEvents=Modelica.Blocks.Types.TimeEvents.Always;
    input Boolean verboseRead=true "= true: Print info message; = false: No info message";
    output ExternalCombiTimeTable externalCombiTimeTable;
  external "C" externalCombiTimeTable = ModelicaStandardTables_CombiTimeTable_init2(
          fileName,
          tableName,
          table,
          size(table, 1),
          size(table, 2),
          startTime,
          columns,
          size(columns, 1),
          smoothness,
          extrapolation,
          shiftTime,
          timeEvents,
          verboseRead) annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  end constructor;

  function destructor "Terminate 1-dim. table where first column is time"
    extends Modelica.Icons.Function;
    input ExternalCombiTimeTable externalCombiTimeTable;
  external "C" ModelicaStandardTables_CombiTimeTable_close(
      externalCombiTimeTable) annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  end destructor;

end ExternalCombiTimeTable;
