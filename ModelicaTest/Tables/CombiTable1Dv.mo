within ModelicaTest.Tables;
package CombiTable1Dv "Test models for Modelica.Blocks.Tables.CombiTable1Dv"
  import Modelica.Utilities.Files.loadResource;
  extends Modelica.Icons.ExamplesPackage;

  partial model Test
    Modelica.Blocks.Tables.CombiTable1Dv t_new annotation(Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.ContinuousClock clock annotation(Placement(transformation(extent={{-80,0},{-60,20}})));
  equation
    connect(clock.y, t_new.u[1]) annotation(Line(points={{-59,10},{-43,10}}, color={0,0,127}));
  end Test;

  partial model TestDer
    extends Test;
    Modelica.Blocks.Continuous.Der d_t_new annotation(Placement(transformation(extent={{0,0},{20,20}})));
  equation
    connect(t_new.y[1], d_t_new.u) annotation(Line(points={{-19,10},{-2,10}}, color={0,0,127}));
  end TestDer;

  partial model TestDer2
    extends TestDer;
    Modelica.Blocks.Continuous.Der d2_t_new annotation(Placement(transformation(extent={{40,0},{60,20}})));
  equation
    connect(d_t_new.y, d2_t_new.u) annotation(Line(points={{21,10},{26,10},{33,10},{38,10}}, color={0,0,127}));
  end TestDer2;

  model Test1 "Single row, t_min = 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test1;

  model Test2 "Single row, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0.5,1}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test2;

  model Test3 "Two columns, Akima"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0.3, 0; 0.4, 1; 0.5, 0; 0.6, -1; 0.7, 0],
          smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test3;

  model Test4 "Three columns, Akima"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1;
            0.7, 0, 0], smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Continuous.Der d_t_new2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  equation
    connect(t_new.y[2], d_t_new2.u) annotation(Line(points={{-19,10},{-14,10},{-7,10},{-7,-20},{-2,-20}}, color={0,0,127}));
    connect(d_t_new2.y, d2_t_new2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
    connect(clock.y, t_new.u[2]) annotation(Line(points={{-59,10},{-43,10}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test4;

  model Test5 "Third column, Akima"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
        table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1; 0.7, 0, 0],
        columns={3},
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test5;

  model Test6 "Three columns, Akima"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
        table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1; 0.7, 0, 0],
        columns={2,3},
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Continuous.Der d_t_new2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  equation
    connect(t_new.y[2], d_t_new2.u) annotation(Line(points={{-19,10},{-14,10},{-7,10},{-7,-20},{-2,-20}}, color={0,0,127}));
    connect(d_t_new2.y, d2_t_new2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
    connect(clock.y, t_new.u[2]) annotation(Line(points={{-59,10},{-43,10}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test6;

  model Test7 "Two rows, t_min = 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{1,0}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test7;

  model Test8 "Two rows, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0.25,1},{1.25,0}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test8;
  /*
  model Test9 "Two rows, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{1,0}}, extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test9;

  model Test10 "Two rows, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0.25,1},{1.25,0}}, extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test10;
*/
  model Test11 "Three rows, t_min = 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{0.5,2},{1,0}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test11;

  model Test12 "Three rows, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{0.5,2},{1,0}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test12;
  /*
  model Test13 "Three rows, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{0.5,2},{1,0}}, extrapolation=
            Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test13;

  model Test14 "Three rows, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{0.5,2},{1,0}}, extrapolation=
            Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test14;
*/
  model Test15 "Problematic Akima"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0, 5; 1, 3; 2, 1; 3, 1; 4, 1; 5, 3], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=3));
  end Test15;

  model Test16 "Problematic Akima, flipped"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0, 3; 1, 1; 2, 1; 3, 1; 4, 3; 5, 5], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=3));
  end Test16;
  /*
  model Test17 "Constant segments, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table=[0, 0; 2.5, 1; 3, 0],
        smoothness=Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=3.5));
  end Test17;
*/
  model Test18 "ASCII Text file (Very long line length)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="longLine",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test.txt"),
        columns={2,2500}));
    Modelica.Blocks.Continuous.Der d_t_new2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
  equation
    connect(t_new.y[2], d_t_new2.u) annotation(Line(points={{-19,10},{-14,10},{-7,10},{-7,-20},{-2,-20}}, color={0,0,127}));
    connect(clock.y, t_new.u[2]) annotation(Line(points={{-59,10},{-43,10}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test18;

  model Test19 "MAT-File v4"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v4.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test19;

  model Test20 "MAT-File v6"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v6.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test20;

  model Test21 "MAT-File v7"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test21;

  /*
  model Test22 "MAT-File v7.3"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.3.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test22;
*/
  model Test23 "ASCII Text file"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test.txt")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test23;

  model Test24 "ASCII Text file (TAB separated)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a_tab",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test.txt")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test24;

  model Test25_usertab "Test utilizing the usertab.c interface"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(tableOnFile=true, tableName="TestTable_1D_a"));
    parameter Real dummy(fixed=false) "Dummy parameter" annotation(HideResult=true);
  protected
    encapsulated impure function getUsertab
      import Modelica;
      extends Modelica.Icons.Function;
      input Real dummy_u[:];
      output Real dummy_y;
      external "C" dummy_y = mydummyfunc(dummy_u)
      annotation(IncludeDirectory="modelica://Modelica/Resources/Data/Tables",
             Include = "#include \"usertab.c\"
double mydummyfunc(const double* dummy_in) {
    return 0.;
}
");
    end getUsertab;
  initial equation
    dummy = getUsertab(t_new.y);
    annotation (experiment(StartTime=0, StopTime=4));
  end Test25_usertab;

  model Test26 "Fritsch-Butland, test data set (Ticket #1039)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,5;1,3;2,1;3,1;4,1;5,3],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1));
    annotation (experiment(StartTime=0, StopTime=4));
  end Test26;

  model Test27 "Fritsch-Butland, data set AKIMA 3 (Ticket #1717)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,10;2,10;3,10;5,10;6,10;8,10;9,10.5;11,15;12,50;14,60;15,85],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1));
    annotation (experiment(StartTime=0, StopTime=15));
  end Test27;

  model Test28 "Fritsch-Butland, data set RPN 14 (Ticket #1717)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[7.99,0;8.09,2.76429e-5;8.19,4.37498e-2;8.7,0.169183;9.2,0.469428;10,0.94374;12,0.998636;15,0.999919;20,0.999994],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1));
    annotation (experiment(StartTime=7.99, StopTime=20));
  end Test28;

  model Test29 "Single row, Akima (Ticket #1820)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,1,2],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Continuous.Der d_t_new2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  equation
    connect(t_new.y[2], d_t_new2.u) annotation(Line(points={{-19,10},{-14,10},{-7,10},{-7,-20},{-2,-20}}, color={0,0,127}));
    connect(d_t_new2.y, d2_t_new2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
    connect(clock.y, t_new.u[2]) annotation(Line(points={{-59,10},{-43,10}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test29;

  model Test30 "Steffen, test data set (Ticket #1814)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,5;1,3;2,1;3,1;4,1;5,3],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2));
    annotation (experiment(StartTime=0, StopTime=4));
  end Test30;

  model Test31 "Steffen, data set AKIMA 3 (Ticket #1814)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,10;2,10;3,10;5,10;6,10;8,10;9,10.5;11,15;12,50;14,60;15,85],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2));
    annotation (experiment(StartTime=0, StopTime=15));
  end Test31;

  model Test32 "Steffen, data set RPN 14 (Ticket #1814)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[7.99,0;8.09,2.76429e-5;8.19,4.37498e-2;8.7,0.169183;9.2,0.469428;10,0.94374;12,0.998636;15,0.999919;20,0.999994],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2));
    annotation (experiment(StartTime=7.99, StopTime=20));
  end Test32;

  model Test33 "Text file with UTF-8 BOM and comments (Ticket #2404)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
      tableOnFile=true,
      tableName="a",
      fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test_utf8.txt")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test33;

  model Test34 "Modified Akima, test data set (Ticket #1039)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,5;1,3;2,1;3,1;4,1;5,3],
      smoothness=Modelica.Blocks.Types.Smoothness.ModifiedContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=4));
  end Test34;

  model Test35 "CSV file (Ticket #3691)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
      tableOnFile=true,
      delimiter=",",
      nHeaderLines=1,
      fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test1D.csv")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test35;
end CombiTable1Dv;
