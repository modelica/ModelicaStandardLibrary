within ModelicaTest.Tables;
package CombiTable2D
  extends Modelica.Icons.ExamplesPackage;
  partial model Test0
    Modelica.Blocks.Tables.CombiTable2D t_new
      annotation (Placement(transformation(extent={{-41,0},{-21,20}})));
    Modelica.Blocks.Continuous.Der d_t_new
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
  equation
    connect(t_new.y, d_t_new.u) annotation (Line(
        points={{-20,10},{-2,10}},
        color={0,0,127},
        thickness=0.0625));
  end Test0;

  model Test1 "Akima, u1 extrapolation"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
  equation
    t_new.u1 = time;
    t_new.u2 = 2;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test1;

  model Test2 "Akima, u2 extrapolation"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
  equation
    t_new.u1 = 2;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test2;

  model Test3 "Akima, u1 and u2 extrapolation"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
  equation
    t_new.u1 = time;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test3;

  model Test4 "Bilinear, u1 extrapolation"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
  equation
    t_new.u1 = time;
    t_new.u2 = 2;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test4;

  model Test5 "Bilinear, u2 extrapolation"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
  equation
    t_new.u1 = 2;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test5;

  model Test6 "Bilinear, u1 and u2 extrapolation"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
  equation
    t_new.u1 = time;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test6;

  model Test7 "Constant segments, u1 extrapolation"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0], smoothness=
            Modelica.Blocks.Types.Smoothness.ConstantSegments));
  equation
    t_new.u1 = time;
    t_new.u2 = 2;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test7;

  model Test8 "Constant segments, u2 extrapolation"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0], smoothness=
            Modelica.Blocks.Types.Smoothness.ConstantSegments));
  equation
    t_new.u1 = 2;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test8;

  model Test9 "Constant segments, u1 and u2 extrapolation"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0], smoothness=
            Modelica.Blocks.Types.Smoothness.ConstantSegments));
  equation
    t_new.u1 = time;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test9;

  model Test10 "MAT-File v4"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName="modelica://Modelica/Resources/Data/Tables/test_v4.mat"));
  equation
    t_new.u1 = time;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test10;

  model Test11 "MAT-File v6"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName="modelica://Modelica/Resources/Data/Tables/test_v6.mat"));
  equation
    t_new.u1 = time;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test11;

  model Test12 "MAT-File v7"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName="modelica://Modelica/Resources/Data/Tables/test_v7.mat"));
  equation
    t_new.u1 = time;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test12;

  /*
  model Test13 "MAT-File v7.3"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName="modelica://Modelica/Resources/Data/Tables/test_v7.3.mat"));
  equation
    t_new.u1 = time;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test13;
*/
  model Test14 "ASCII Text file"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName="modelica://Modelica/Resources/Data/Tables/test.txt"));
  equation
    t_new.u1 = time;
    t_new.u2 = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test14;

  model Test15 "Constant 2D surface"
    extends Modelica.Icons.Example;
  protected
    parameter String fileName=Modelica.Utilities.Files.loadResource(
        "modelica://Modelica/Resources/Data/Tables/test_v4.mat");
    Modelica.Blocks.Types.ExternalCombiTable2D tableID=
        Modelica.Blocks.Types.ExternalCombiTable2D(
          "akima2D",
          fileName,
          fill(
            0.0,
            0,
            2),
          Modelica.Blocks.Types.Smoothness.ConstantSegments)
      "External table object";

    function readTableData "Read table data from ASCII text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Integer forceRead "Force reading of table data";
      output Real readSuccess "Table read success";
    external"C" readSuccess = ModelicaStandardTables_CombiTable2D_read(tableID,
        forceRead) annotation (Library="ModelicaStandardTables");
    end readTableData;

    function getTableValue "Interpolate 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Real u1;
      input Real u2;
      output Real y;
    external"C" y = ModelicaStandardTables_CombiTable2D_getValue(
            tableID,
            u1,
            u2) annotation (Library="ModelicaStandardTables");
    end getTableValue;

    function tableSurface
      "Function defining the surface characteristic of a 2D surface"
      extends
        Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
          final multiColoredSurface=false);
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
    protected
      Real tableOnFileRead;
    algorithm
      tableOnFileRead := readTableData(tableID, 0);
      for i in 1:nu loop
        for j in 1:nv loop
          X[i, j] := (i - 1)/2;
          Y[i, j] := (j - 1)/2;
          Z[i, j] := getTableValue(
                tableID,
                X[i, j],
                Y[i, j]);
        end for;
      end for;
    end tableSurface;

    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface surface(
      redeclare function surfaceCharacteristic = tableSurface (tableID=tableID),

      nu=101,
      nv=81,
      multiColoredSurface=false,
      wireframe=false,
      color={0,200,0},
      specularCoefficient=0.7,
      transparency=0)
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

    annotation (experiment(StartTime=0, StopTime=1));
  end Test15;

  model Test16 "Bilinear surface"
    extends Modelica.Icons.Example;
  protected
    parameter String fileName=Modelica.Utilities.Files.loadResource(
        "modelica://Modelica/Resources/Data/Tables/test_v4.mat");
    Modelica.Blocks.Types.ExternalCombiTable2D tableID=
        Modelica.Blocks.Types.ExternalCombiTable2D(
          "akima2D",
          fileName,
          fill(
            0.0,
            0,
            2),
          Modelica.Blocks.Types.Smoothness.LinearSegments)
      "External table object";

    function readTableData "Read table data from ASCII text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Integer forceRead "Force reading of table data";
      output Real readSuccess "Table read success";
    external"C" readSuccess = ModelicaStandardTables_CombiTable2D_read(tableID,
        forceRead) annotation (Library="ModelicaStandardTables");
    end readTableData;

    function getTableValue "Interpolate 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Real u1;
      input Real u2;
      output Real y;
    external"C" y = ModelicaStandardTables_CombiTable2D_getValue(
            tableID,
            u1,
            u2) annotation (Library="ModelicaStandardTables");
    end getTableValue;

    function tableSurface
      "Function defining the surface characteristic of a 2D surface"
      extends
        Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
          final multiColoredSurface=false);
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
    protected
      Real tableOnFileRead;
    algorithm
      tableOnFileRead := readTableData(tableID, 0);
      for i in 1:nu loop
        for j in 1:nv loop
          X[i, j] := (i - 1)/2;
          Y[i, j] := (j - 1)/2;
          Z[i, j] := getTableValue(
                tableID,
                X[i, j],
                Y[i, j]);
        end for;
      end for;
    end tableSurface;

    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface surface(
      redeclare function surfaceCharacteristic = tableSurface (tableID=tableID),

      nu=101,
      nv=81,
      multiColoredSurface=false,
      wireframe=false,
      color={0,200,0},
      specularCoefficient=0.7,
      transparency=0)
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

    annotation (experiment(StartTime=0, StopTime=1));
  end Test16;

  model Test17 "Akima2D surface"
    extends Modelica.Icons.Example;
  protected
    parameter String fileName=Modelica.Utilities.Files.loadResource(
        "modelica://Modelica/Resources/Data/Tables/test_v4.mat");
    Modelica.Blocks.Types.ExternalCombiTable2D tableID=
        Modelica.Blocks.Types.ExternalCombiTable2D(
          "akima2D",
          fileName,
          fill(
            0.0,
            0,
            2),
          Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
      "External table object";

    function readTableData "Read table data from ASCII text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Integer forceRead "Force reading of table data";
      output Real readSuccess "Table read success";
    external"C" readSuccess = ModelicaStandardTables_CombiTable2D_read(tableID,
        forceRead) annotation (Library="ModelicaStandardTables");
    end readTableData;

    function getTableValue "Interpolate 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Real u1;
      input Real u2;
      output Real y;
    external"C" y = ModelicaStandardTables_CombiTable2D_getValue(
            tableID,
            u1,
            u2) annotation (Library="ModelicaStandardTables");
    end getTableValue;

    function calcColor "Color Calculation"
      input Real G "Input Parameter";
      output Real color[3] "RGB Color";
    protected
      Real x "Auxiliary Variable";
    algorithm
      if noEvent(G < 0) then
        x := -4*G;
      else
        x := 4*G;
      end if;
      x := min(x, 4);
      if noEvent(x < 1) then
        color := {0,x,1};
      elseif noEvent(x < 2) then
        color := {0,1,2 - x};
      elseif noEvent(x < 3) then
        color := {x - 2,1,0};
      else
        color := {1,4 - x,0};
      end if;
      annotation (Inline=true);
    end calcColor;

    function tableSurface
      "Function defining the surface characteristic of a 2D surface"
      extends
        Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
          final multiColoredSurface=true);
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
    protected
      Real tableOnFileRead;
    algorithm
      tableOnFileRead := readTableData(tableID, 0);
      for i in 1:nu loop
        for j in 1:nv loop
          X[i, j] := i - 1;
          Y[i, j] := j - 1;
          Z[i, j] := getTableValue(
                tableID,
                X[i, j],
                Y[i, j]);
          C[i, j, :] := calcColor(Z[i, j]/64)*255;
        end for;
      end for;
    end tableSurface;

    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface surface(
      redeclare function surfaceCharacteristic = tableSurface (tableID=tableID),

      nu=51,
      nv=41,
      multiColoredSurface=true,
      wireframe=false,
      color={0,200,0},
      specularCoefficient=0.7,
      transparency=0)
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

    annotation (experiment(StartTime=0, StopTime=1));
  end Test17;

end CombiTable2D;
