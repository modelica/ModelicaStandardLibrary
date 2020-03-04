within Modelica.Blocks.Types;
class ExternalCombiTable2D
  "External object of 2-dim. table defined by matrix"
  extends ExternalObject;

  function constructor "Initialize 2-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input String tableName "Table name";
    input String fileName "File name";
    input Real table[:, :];
    input Modelica.Blocks.Types.Smoothness smoothness;
    input Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints;
    input Boolean verboseRead=true "= true: Print info message; = false: No info message";
    output ExternalCombiTable2D externalCombiTable2D;
  external "C" externalCombiTable2D = ModelicaStandardTables_CombiTable2D_init2(
          fileName,
          tableName,
          table,
          size(table, 1),
          size(table, 2),
          smoothness,
          extrapolation,
          verboseRead) annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  end constructor;

  function destructor "Terminate 2-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input ExternalCombiTable2D externalCombiTable2D;
  external "C" ModelicaStandardTables_CombiTable2D_close(externalCombiTable2D)
      annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
  end destructor;

end ExternalCombiTable2D;
