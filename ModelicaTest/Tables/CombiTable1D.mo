within ModelicaTest.Tables;
package CombiTable1D
  import Modelica.Utilities.Files.loadResource;
  extends Modelica.Icons.ExamplesPackage;

  partial model Test0

    Modelica.Blocks.Tables.CombiTable1D t_new
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Continuous.Der d_t_new
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Blocks.Sources.Clock clock
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  equation
    //t_new.u[1] = time;
    connect(t_new.y[1], d_t_new.u) annotation (Line(
        points={{-19,10},{-2,10}},
        color={0,0,127},
        thickness=0.0625));
    connect(clock.y, t_new.u[1]) annotation (Line(
        points={{-59,10},{-42,10}},
        color={0,0,127},
        smooth=Smooth.None));
  end Test0;

  model Test1 "Single row, t_min = 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test1;

  model Test2 "Single row, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0.5,1}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test2;

  model Test3 "Two columns, Akima"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0.3, 0; 0.4, 1; 0.5, 0; 0.6, -1; 0.7, 0],
          smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test3;

  model Test4 "Three columns, Akima"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1;
            0.7, 0, 0], smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Continuous.Der d_t_new2
      annotation (Placement(transformation(extent={{-60,25},{-40,45}})));
  equation
    t_new.u[2] = time;
    connect(t_new.y[2], d_t_new2.u) annotation (Line(
        points={{-84,35},{-79,35},{-63,35},{-58,35}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test4;

  model Test5 "Third column, Akima"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1; 0.7, 0, 0],
        columns={3},
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test5;

  model Test6 "Three columns, Akima"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1; 0.7, 0, 0],
        columns={2,3},
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Continuous.Der d_t_new2
      annotation (Placement(transformation(extent={{-60,25},{-40,45}})));
  equation
    t_new.u[2] = time;
    connect(t_new.y[2], d_t_new2.u) annotation (Line(
        points={{-84,35},{-79,35},{-63,35},{-58,35}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test6;

  model Test7 "Two rows, t_min = 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{1,0}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test7;

  model Test8 "Two rows, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0.25,1},{1.25,0}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test8;

  /*
  model Test9 "Two rows, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{1,0}}, extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test9;

  model Test10 "Two rows, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0.25,1},{1.25,0}}, extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test10;
*/

  model Test11 "Three rows, t_min = 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{0.5,2},{1,0}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test11;

  model Test12 "Three rows, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{0.5,2},{1,0}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test12;

  /*
  model Test13 "Three rows, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{0.5,2},{1,0}}, extrapolation=
            Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test13;

  model Test14 "Three rows, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{0.5,2},{1,0}}, extrapolation=
            Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test14;
*/

  model Test15 "Problematic Akima"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 5; 1, 3; 2, 1; 3, 1; 4, 1; 5, 3], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=3));
  end Test15;

  model Test16 "Problematic Akima, flipped"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 3; 1, 1; 2, 1; 3, 1; 4, 3; 5, 5], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=3));
  end Test16;
  /*
  model Test17 "Constant segments, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table=[0, 0; 2.5, 1; 3, 0],
        smoothness=Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=3.5));
  end Test17;
*/

  model Test18 "ASCII Text file (Very long line length)"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="longLine",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test.txt"),
        columns={2,2500}));
    Modelica.Blocks.Continuous.Der d_t_new2
      annotation (Placement(transformation(extent={{-60,25},{-40,45}})));
  equation
    t_new.u[2] = time;
    connect(t_new.y[2], d_t_new2.u) annotation (Line(
        points={{-84,35},{-79,35},{-63,35},{-58,35}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test18;

  model Test19 "MAT-File v4"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v4.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test19;

  model Test20 "MAT-File v6"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v6.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test20;

  model Test21 "MAT-File v7"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test21;

  /*
  model Test22 "MAT-File v7.3"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.3.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test22;
*/

  model Test23 "ASCII Text file"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test.txt")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test23;

  model Test24 "ASCII Text file (TAB separated)"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a_tab",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test.txt")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test24;

  model Test25_usertab "Test utilizing the usertab.c interface"
    extends Modelica.Icons.Example;
    extends Test0(t_new(tableOnFile=true, tableName="TestTable_1D_a"));
  protected
    encapsulated function getUsertab
      import Modelica;
      extends Modelica.Icons.Function;
      input Real dummy_u[:];
      output Real dummy_y;
      external "C" dummy_y = mydummyfunc(dummy_u)
      annotation(IncludeDirectory="modelica://Modelica/Resources/Data/Tables",
             Include = "#include \"usertab.c\"
double mydummyfunc(double* dummy_in) {
    return 0.;
}
");
    end getUsertab;
  public
    Modelica.Blocks.Sources.RealExpression realExpression(y=getUsertab(t_new.y))
      annotation (Placement(transformation(extent={{-18,-42},{12,-22}})));
    annotation (experiment(StartTime=0, StopTime=5));
  end Test25_usertab;
end CombiTable1D;
