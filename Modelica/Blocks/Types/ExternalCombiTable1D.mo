within Modelica.Blocks.Types;
class ExternalCombiTable1D
  "External object of 1-dim. table defined by matrix"
  extends ExternalObject;

  function constructor "Initialize 1-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input String tableName "Table name";
    input String fileName "File name";
    input Real table[:, :];
    input Integer columns[:];
    input Modelica.Blocks.Types.Smoothness smoothness;
    input Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints;
    input Boolean verboseRead=true "= true: Print info message; = false: No info message";
    output ExternalCombiTable1D externalCombiTable1D;
  external "C" externalCombiTable1D = ModelicaStandardTables_CombiTable1D_init2(
          fileName,
          tableName,
          table,
          size(table, 1),
          size(table, 2),
          columns,
          size(columns, 1),
          smoothness,
          extrapolation,
          verboseRead) annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  end constructor;

  function destructor "Terminate 1-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input ExternalCombiTable1D externalCombiTable1D;
  external "C" ModelicaStandardTables_CombiTable1D_close(externalCombiTable1D)
      annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  end destructor;

end ExternalCombiTable1D;
