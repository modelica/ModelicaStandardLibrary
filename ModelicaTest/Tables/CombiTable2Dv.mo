within ModelicaTest.Tables;
package CombiTable2Dv "Test models for Modelica.Blocks.Tables.CombiTable2Dv"
  import Modelica.Utilities.Files.loadResource;
  extends Modelica.Icons.ExamplesPackage;

  partial model Test
    Modelica.Blocks.Tables.CombiTable2Dv t_new annotation(Placement(transformation(extent={{-40,0},{-20,20}})));
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

  model Test1 "Akima, u1 extrapolation"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.Constant const(k=2)
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-52,30},{-52,16},{-42,16}}, color={0,0,127}));
    connect(const.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-52,-10},{-52,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test1;

  model Test2 "Akima, u2 extrapolation"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
    Modelica.Blocks.Sources.Constant const(k=2)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  equation
    connect(clock.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-52,-10},{-52,4},{-42,4}}, color={0,0,127}));
    connect(const.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test2;

  model Test3 "Akima, u1 and u2 extrapolation"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-52,30},{-52,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-52,-10},{-52,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test3;

  model Test4 "Bilinear, u1 extrapolation"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.Constant const(k=2)
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(const.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test4;

  model Test5 "Bilinear, u2 extrapolation"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
    Modelica.Blocks.Sources.Constant const(k=2)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(const.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-52,30},{-52,16},{-42,16}}, color={0,0,127}));
    connect(clock.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50.5,-10},{-50.5,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test5;

  model Test6 "Bilinear, u1 and u2 extrapolation"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0, 58.2,
            61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40, 27,
            41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5, 4.7,
            7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8, 0.6,
            0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8, 5.3,
            2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0; 35,
            3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0; 45, 0,
            0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-52,-10},{-52,4},{-42,4}}, color={0,0,127}));
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-52,30},{-52,16},{-42,16}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test6;

  model Test7 "Constant segments, u1 extrapolation"
    extends Modelica.Icons.Example;
    extends Test(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0,
            58.2, 61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40,
            27, 41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5,
            4.7, 7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8,
            0.6, 0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8,
            5.3, 2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0;
            35, 3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0;
            45, 0, 0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.Constant const(k=2)
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(const.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test7;

  model Test8 "Constant segments, u2 extrapolation"
    extends Modelica.Icons.Example;
    extends Test(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0,
            58.2, 61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40,
            27, 41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5,
            4.7, 7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8,
            0.6, 0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8,
            5.3, 2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0;
            35, 3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0;
            45, 0, 0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments));
    Modelica.Blocks.Sources.Constant const(k=2)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(const.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-52,30},{-52,16},{-42,16}}, color={0,0,127}));
    connect(clock.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test8;

  model Test9 "Constant segments, u1 and u2 extrapolation"
    extends Modelica.Icons.Example;
    extends Test(t_new(table=[0, 0, 5, 10, 15, 20, 25, 30, 35, 40; 0,
            58.2, 61.5, 47.9, 62.3, 34.6, 45.5, 38.2, 41.2, 41.7; 5, 37.2, 40,
            27, 41.3, 14.1, 24.5, 17.3, 20.2, 20.8; 10, 22.4, 22.5, 14.6, 22.5,
            4.7, 7.2, 1.8, 2.1, 2.1; 15, 21.8, 20.5, 12.8, 17.6, 5.8, 7.6, 0.8,
            0.6, 0.6; 20, 16.8, 14.4, 8.1, 6.9, 6.2, 0.6, 0.1, 0, 0; 25, 12, 8,
            5.3, 2.9, 0.6, 0, 0, 0, 0; 30, 7.4, 4.8, 1.4, 0.1, 0, 0, 0, 0, 0;
            35, 3.2, 0.7, 0, 0, 0, 0, 0, 0, 0; 40, 0, 0, 0, 0, 0, 0, 0, 0, 0;
            45, 0, 0, 0, 0, 0, 0, 0, 0, 0; 50, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test9;

  model Test10 "MAT-File v4"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v4.mat")));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test10;

  model Test11 "MAT-File v6"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v6.mat")));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test11;

  model Test12 "MAT-File v7"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.mat")));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test12;

  /*
  model Test13 "MAT-File v7.3"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.3.mat")));
  equation
    t_new.u1[1] = time;
    t_new.u2[1] = time;
    annotation (experiment(StartTime=0, StopTime=60));
  end Test13;
*/
  model Test14 "ASCII Text file"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test.txt")));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test14;

  model Test18_usertab "Test utilizing the usertab.c interface"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(tableOnFile=true, tableName="TestTable_2D"));
    parameter Real dummy(fixed=false) "Dummy parameter" annotation(HideResult=true);
    Modelica.Blocks.Sources.Ramp ramp(height=2, duration=1)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.Ramp ramp1(duration=1, height=6)
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  protected
    encapsulated impure function getUsertab
      import Modelica;
      extends Modelica.Icons.Function;
      input Real dummy_u;
      output Real dummy_y;
      external "C" dummy_y = mydummyfunc(dummy_u)
      annotation(IncludeDirectory="modelica://Modelica/Resources/Data/Tables",
             Include = "#include \"usertab.c\"
double mydummyfunc(double dummy_in) {
    return 0.;
}
");
    end getUsertab;
  initial equation
    dummy = getUsertab(t_new.y[1]);
  equation
    connect(ramp1.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    connect(ramp.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-52,30},{-52,16},{-42,16}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1.0));
  end Test18_usertab;

  model Test19 "Constant 2D (Ticket #1307)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D1D(
      table=[1,1;2,4;3,9;4,16],
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments) annotation(Placement(transformation(extent={{-95,60},{-75,80}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D1DT(
      table=transpose([1,1;2,4;3,9;4,16]),
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments) annotation(Placement(transformation(extent={{-95,30},{-75,50}})));
    Modelica.Blocks.Sources.ContinuousClock clock1 annotation(Placement(transformation(extent={{-130,65},{-110,85}})));
    Modelica.Blocks.Tables.CombiTable1Ds combiTable1D(
      table=[2,4;3,9;4,16],
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments) annotation(Placement(transformation(extent={{-95,0},{-75,20}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D(
      table=[1,0,6;2,4,4;3,9,9;4,16,16],
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments) annotation(Placement(transformation(extent={{-95,-30},{-75,-10}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2DT(
      table=transpose([1,0,6;2,4,4;3,9,9;4,16,16]),
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments) annotation(Placement(transformation(extent={{-95,-60},{-75,-40}})));
  equation
      connect(combiTable1D.u,clock1.y) annotation(Line(
        points={{-97,10},{-102,10},{-104,10},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1DT.u2[1],clock1.y) annotation(Line(
        points={{-97,34},{-102,34},{-104,34},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1DT.u1[1],clock1.y) annotation(Line(
        points={{-97,46},{-102,46},{-104,46},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1D.u2[1],clock1.y) annotation(Line(
        points={{-97,64},{-102,64},{-104,64},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1D.u1[1],clock1.y) annotation(Line(
        points={{-97,76},{-102,76},{-104,76},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D.u2[1],clock1.y) annotation(Line(
        points={{-97,-26},{-102,-26},{-104,-26},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D.u1[1],clock1.y) annotation(Line(
        points={{-97,-14},{-102,-14},{-104,-14},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2DT.u2[1],clock1.y) annotation(Line(
        points={{-97,-56},{-102,-56},{-104,-56},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2DT.u1[1],clock1.y) annotation(Line(
        points={{-97,-44},{-102,-44},{-104,-44},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      annotation (experiment(StartTime=0, StopTime=6));
  end Test19;

  model Test20 "Bilinear (Ticket #1307)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D1D(
      table=[1,1;2,4;3,9;4,16]) annotation(Placement(transformation(extent={{-95,60},{-75,80}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D1DT(
      table=transpose([1,1;2,4;3,9;4,16])) annotation(Placement(transformation(extent={{-95,30},{-75,50}})));
    Modelica.Blocks.Sources.ContinuousClock clock1 annotation(Placement(transformation(extent={{-130,65},{-110,85}})));
    Modelica.Blocks.Tables.CombiTable1Ds combiTable1D(
      table=[2,4;3,9;4,16]) annotation(Placement(transformation(extent={{-95,0},{-75,20}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D(
      table=[1,0,6;2,4,4;3,9,9;4,16,16]) annotation(Placement(transformation(extent={{-95,-30},{-75,-10}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2DT(
      table=transpose([1,0,6;2,4,4;3,9,9;4,16,16])) annotation(Placement(transformation(extent={{-95,-60},{-75,-40}})));
    Modelica.Blocks.Continuous.Der der1 annotation(Placement(transformation(extent={{-60,60},{-40,80}})));
    Modelica.Blocks.Continuous.Der der2 annotation(Placement(transformation(extent={{-60,30},{-40,50}})));
    Modelica.Blocks.Continuous.Der der3 annotation(Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Blocks.Continuous.Der der4 annotation(Placement(transformation(extent={{-60,-30},{-40,-10}})));
    Modelica.Blocks.Continuous.Der der5 annotation(Placement(transformation(extent={{-60,-60},{-40,-40}})));
  equation
      connect(combiTable1D.u,clock1.y) annotation(Line(
        points={{-97,10},{-102,10},{-104,10},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(der3.u,combiTable1D.y[1]) annotation(Line(
        points={{-62,10},{-67,10},{-69,10},{-74,10}},
        color={0,0,127},
        thickness=0.0625));
      connect(der2.u,combiTable2D1DT.y[1]) annotation(Line(
        points={{-62,40},{-67,40},{-69,40},{-74,40}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1DT.u2[1],clock1.y) annotation(Line(
        points={{-97,34},{-102,34},{-104,34},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1DT.u1[1],clock1.y) annotation(Line(
        points={{-97,46},{-102,46},{-104,46},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(der1.u,combiTable2D1D.y[1]) annotation(Line(
        points={{-62,70},{-67,70},{-69,70},{-74,70}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1D.u2[1],clock1.y) annotation(Line(
        points={{-97,64},{-102,64},{-104,64},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1D.u1[1],clock1.y) annotation(Line(
        points={{-97,76},{-102,76},{-104,76},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(der4.u,combiTable2D.y[1]) annotation(Line(
        points={{-62,-20},{-67,-20},{-69,-20},{-74,-20}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D.u2[1],clock1.y) annotation(Line(
        points={{-97,-26},{-102,-26},{-104,-26},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D.u1[1],clock1.y) annotation(Line(
        points={{-97,-14},{-102,-14},{-104,-14},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(der5.u,combiTable2DT.y[1]) annotation(Line(
        points={{-62,-50},{-67,-50},{-69,-50},{-74,-50}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2DT.u2[1],clock1.y) annotation(Line(
        points={{-97,-56},{-102,-56},{-104,-56},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2DT.u1[1],clock1.y) annotation(Line(
        points={{-97,-44},{-102,-44},{-104,-44},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      annotation (experiment(StartTime=0, StopTime=6));
  end Test20;

  model Test21 "Akima2D (Ticket #1307)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D1D(
      table=[1,1;2,4;3,9;4,16],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-95,60},{-75,80}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D1DT(
      table=transpose([1,1;2,4;3,9;4,16]),
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-95,30},{-75,50}})));
    Modelica.Blocks.Sources.ContinuousClock clock1 annotation(Placement(transformation(extent={{-130,65},{-110,85}})));
    Modelica.Blocks.Tables.CombiTable1Ds combiTable1D(
      table=[2,4;3,9;4,16],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-95,0},{-75,20}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D(
      table=[1,0,6;2,4,4;3,9,9;4,16,16],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-95,-30},{-75,-10}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2DT(
      table=transpose([1,0,6;2,4,4;3,9,9;4,16,16]),
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-95,-60},{-75,-40}})));
    Modelica.Blocks.Continuous.Der der1 annotation(Placement(transformation(extent={{-60,60},{-40,80}})));
    Modelica.Blocks.Continuous.Der der2 annotation(Placement(transformation(extent={{-60,30},{-40,50}})));
    Modelica.Blocks.Continuous.Der der3 annotation(Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Blocks.Continuous.Der der4 annotation(Placement(transformation(extent={{-60,-30},{-40,-10}})));
    Modelica.Blocks.Continuous.Der der5 annotation(Placement(transformation(extent={{-60,-60},{-40,-40}})));
  equation
      connect(combiTable1D.u,clock1.y) annotation(Line(
        points={{-97,10},{-102,10},{-104,10},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(der3.u,combiTable1D.y[1]) annotation(Line(
        points={{-62,10},{-67,10},{-69,10},{-74,10}},
        color={0,0,127},
        thickness=0.0625));
      connect(der2.u,combiTable2D1DT.y[1]) annotation(Line(
        points={{-62,40},{-67,40},{-69,40},{-74,40}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1DT.u2[1],clock1.y) annotation(Line(
        points={{-97,34},{-102,34},{-104,34},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1DT.u1[1],clock1.y) annotation(Line(
        points={{-97,46},{-102,46},{-104,46},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(der1.u,combiTable2D1D.y[1]) annotation(Line(
        points={{-62,70},{-67,70},{-69,70},{-74,70}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1D.u2[1],clock1.y) annotation(Line(
        points={{-97,64},{-102,64},{-104,64},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D1D.u1[1],clock1.y) annotation(Line(
        points={{-97,76},{-102,76},{-104,76},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(der4.u,combiTable2D.y[1]) annotation(Line(
        points={{-62,-20},{-67,-20},{-69,-20},{-74,-20}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D.u2[1],clock1.y) annotation(Line(
        points={{-97,-26},{-102,-26},{-104,-26},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D.u1[1],clock1.y) annotation(Line(
        points={{-97,-14},{-102,-14},{-104,-14},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(der5.u,combiTable2DT.y[1]) annotation(Line(
        points={{-62,-50},{-67,-50},{-69,-50},{-74,-50}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2DT.u2[1],clock1.y) annotation(Line(
        points={{-97,-56},{-102,-56},{-104,-56},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2DT.u1[1],clock1.y) annotation(Line(
        points={{-97,-44},{-102,-44},{-104,-44},{-104,75},{-109,75}},
        color={0,0,127},
        thickness=0.0625));
      annotation (experiment(StartTime=0, StopTime=6));
  end Test21;

  model Test22 "Akima extrapolation of either u1 xor u2 (Ticket #1465)"
    extends Modelica.Icons.Example;
    parameter Real tableR[4,4] = [0,75,83,88;18,778,773,769;28,970,-950,938;33,860,1030,1039] "Table matrix for right extrapolation";
    parameter Real tableL[4,4] = [0,75,80,88;18,1039,1030,860;23,938,-950,970;33,769,773,778] "Table matrix for left extrapolation";
    // Right extrapolate u1
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D_1R(
      table=tableR,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-70,55},{-50,75}})));
    Modelica.Blocks.Continuous.Der der_1R annotation(Placement(transformation(extent={{-30,55},{-10,75}})));
    // Right extrapolate u2
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D_2R(
      table=transpose(tableR),
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-70,20},{-50,40}})));
    Modelica.Blocks.Continuous.Der der_2R annotation(Placement(transformation(extent={{-30,20},{-10,40}})));
    Modelica.Blocks.Sources.Sine sine_R(
      amplitude=3,
      f=0.5,
      phase=Modelica.Constants.pi/2,
      offset=33) annotation(Placement(transformation(extent={{-130,60},{-110,80}})));
    Modelica.Blocks.Sources.Constant const_R(k=81) annotation(Placement(transformation(extent={{-130,25},{-110,45}})));
    // Left extrapolate u1
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D_1L(
      table=tableL,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-70,-15},{-50,5}})));
    Modelica.Blocks.Continuous.Der der_1L annotation(Placement(transformation(extent={{-30,-15},{-10,5}})));
    // Left extrapolate u2
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D_2L(
      table=transpose(tableL),
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-70,-50},{-50,-30}})));
    Modelica.Blocks.Continuous.Der der_2L annotation(Placement(transformation(extent={{-30,-50},{-10,-30}})));
    Modelica.Blocks.Sources.Sine sine_L(
      amplitude=-3,
      f=0.5,
      phase=Modelica.Constants.pi/2,
      offset=18) annotation(Placement(transformation(extent={{-130,-10},{-110,10}})));
    Modelica.Blocks.Sources.Constant const_L(k=82) annotation(Placement(transformation(extent={{-130,-45},{-110,-25}})));
  equation
      connect(der_1R.u,combiTable2D_1R.y[1]) annotation(Line(
        points={{-32,65},{-37,65},{-44,65},{-49,65}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_2R.y[1],der_2R.u) annotation(Line(
        points={{-49,30},{-44,30},{-37,30},{-32,30}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_2R.u2[1],sine_R.y) annotation(Line(
        points={{-72,24},{-77,24},{-104,24},{-104,70},{-109,70}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_1R.u1[1],sine_R.y) annotation(Line(
        points={{-72,71},{-77,71},{-104,71},{-104,70},{-109,70}},
        color={0,0,127},
        thickness=0.0625));
      connect(const_R.y,combiTable2D_2R.u1[1]) annotation(Line(
        points={{-109,35},{-104,35},{-77,35},{-77,36},{-72,36}},
        color={0,0,127},
        thickness=0.0625));
      connect(const_R.y,combiTable2D_1R.u2[1]) annotation(Line(
        points={{-109,35},{-104,35},{-77,35},{-77,59},{-72,59}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_1L.u1[1],sine_L.y) annotation(Line(
        points={{-72,1},{-77,1},{-104,1},{-104,0},{-109,0}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_2L.u2[1],sine_L.y) annotation(Line(
        points={{-72,-46},{-77,-46},{-104,-46},{-104,0},{-109,0}},
        color={0,0,127},
        thickness=0.0625));
      connect(der_1L.u,combiTable2D_1L.y[1]) annotation(Line(
        points={{-32,-5},{-37,-5},{-44,-5},{-49,-5}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_2L.y[1],der_2L.u) annotation(Line(
        points={{-49,-40},{-44,-40},{-37,-40},{-32,-40}},
        color={0,0,127},
        thickness=0.0625));
      connect(const_L.y,combiTable2D_2L.u1[1]) annotation(Line(
        points={{-109,-35},{-104,-35},{-77,-35},{-77,-34},{-72,-34}},
        color={0,0,127},
        thickness=0.015625));
      connect(const_L.y,combiTable2D_1L.u2[1]) annotation(Line(
        points={{-109,-35},{-104,-35},{-77,-35},{-77,-11},{-72,-11}},
        color={0,0,127},
        thickness=0.015625));
    annotation (
      Diagram(
        coordinateSystem(preserveAspectRatio=false),
        graphics={
                Rectangle(
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  extent={{20,30},{45,15}}),
                Text(
                  textString="1L",
                  fillPattern=FillPattern.Solid,
                  extent={{25,35},{40,30}}),
                Text(
                  textString="1R",
                  fillPattern=FillPattern.Solid,
                  extent={{25,15},{40,10}}),
                Text(
                  textString="2L",
                  fillPattern=FillPattern.Solid,
                  extent={{10,25},{25,20}}),
                Text(
                  textString="2R",
                  fillPattern=FillPattern.Solid,
                  extent={{40,25},{55,20}})}),
      experiment(StartTime=0, StopTime=1));
  end Test22;

  model Test23 "Derivative of Akima extrapolation (Ticket #1465)"
    extends Modelica.Icons.Example;
    parameter Real tableR[4,4] = [0,75,83,88;18,778,773,769;28,970,-950,938;33,860,1030,1039] "Table matrix for right extrapolation";
    parameter Real tableL[4,4] = [0,75,80,88;18,1039,1030,860;23,938,-950,970;33,769,773,778] "Table matrix for left extrapolation";
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D_1R(
      table=tableR,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-70,55},{-50,75}})));
    Modelica.Blocks.Continuous.Der der_1R annotation(Placement(transformation(extent={{-30,55},{-10,75}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D_2R(
      table=transpose(tableR),
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-70,20},{-50,40}})));
    Modelica.Blocks.Continuous.Der der_2R annotation(Placement(transformation(extent={{-30,20},{-10,40}})));
    Modelica.Blocks.Sources.Sine cosine_R(
      amplitude=3,
      f=10,
      phase=Modelica.Constants.pi/2,
      offset=33) annotation(Placement(transformation(extent={{-130,60},{-110,80}})));
    Modelica.Blocks.Sources.Sine sine_R(
      amplitude=10,
      f=1/3,
      offset=81,
      startTime=1) annotation(Placement(transformation(extent={{-130,25},{-110,45}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D_1L(
      table=tableL,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-70,-15},{-50,5}})));
    Modelica.Blocks.Continuous.Der der_1L annotation(Placement(transformation(extent={{-30,-15},{-10,5}})));
    Modelica.Blocks.Tables.CombiTable2Dv combiTable2D_2L(
      table=transpose(tableL),
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-70,-50},{-50,-30}})));
    Modelica.Blocks.Continuous.Der der_2L annotation(Placement(transformation(extent={{-30,-50},{-10,-30}})));
    Modelica.Blocks.Sources.Sine cosine_L(
      amplitude=-3,
      f=10,
      phase=Modelica.Constants.pi/2,
      offset=18) annotation(Placement(transformation(extent={{-130,-10},{-110,10}})));
    Modelica.Blocks.Sources.Sine sine_L(
      amplitude=-10,
      f=1/3,
      offset=82,
      startTime=1) annotation(Placement(transformation(extent={{-130,-45},{-110,-25}})));
  equation
      connect(der_1R.u,combiTable2D_1R.y[1]) annotation(Line(
        points={{-32,65},{-37,65},{-44,65},{-49,65}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_2R.y[1],der_2R.u) annotation(Line(
        points={{-49,30},{-44,30},{-37,30},{-32,30}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_2R.u2[1],cosine_R.y) annotation(Line(
        points={{-72,24},{-77,24},{-104,24},{-104,70},{-109,70}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_1R.u1[1],cosine_R.y) annotation(Line(
        points={{-72,71},{-77,71},{-104,71},{-104,70},{-109,70}},
        color={0,0,127},
        thickness=0.0625));
      connect(sine_R.y,combiTable2D_2R.u1[1]) annotation(Line(
        points={{-109,35},{-104,35},{-77,35},{-77,36},{-72,36}},
        color={0,0,127},
        thickness=0.0625));
      connect(sine_R.y,combiTable2D_1R.u2[1]) annotation(Line(
        points={{-109,35},{-104,35},{-77,35},{-77,59},{-72,59}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_1L.u1[1],cosine_L.y) annotation(Line(
        points={{-72,1},{-77,1},{-104,1},{-104,0},{-109,0}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_2L.u2[1],cosine_L.y) annotation(Line(
        points={{-72,-46},{-77,-46},{-104,-46},{-104,0},{-109,0}},
        color={0,0,127},
        thickness=0.0625));
      connect(der_1L.u,combiTable2D_1L.y[1]) annotation(Line(
        points={{-32,-5},{-37,-5},{-44,-5},{-49,-5}},
        color={0,0,127},
        thickness=0.0625));
      connect(combiTable2D_2L.y[1],der_2L.u) annotation(Line(
        points={{-49,-40},{-44,-40},{-37,-40},{-32,-40}},
        color={0,0,127},
        thickness=0.0625));
      connect(sine_L.y,combiTable2D_2L.u1[1]) annotation(Line(
        points={{-109,-35},{-104,-35},{-77,-35},{-77,-34},{-72,-34}},
        color={0,0,127},
        thickness=0.015625));
      connect(sine_L.y,combiTable2D_1L.u2[1]) annotation(Line(
        points={{-109,-35},{-104,-35},{-77,-35},{-77,-11},{-72,-11}},
        color={0,0,127},
        thickness=0.015625));
    annotation (experiment(StartTime=0, StopTime=4));
  end Test23;

  model Test24 "2x3 table, Akima (Ticket #1820)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,0,1;0.5,1,2],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test24;

  model Test25 "3x2 table, Akima (Ticket #1820)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,0.5;0,1;1,2],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test25;

  model Test26 "2x4 table, Akima (Ticket #1820)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,0,0.5,1;0.5,1,2,1],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test26;

  model Test27 "4x2 table, Akima (Ticket #1820)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,0.5;0,1;0.5,2;1,1],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test27;

  model Test28 "3x3 table, Akima (Ticket #1820)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,0,1;0,0,1;1,1,1],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test28;

  model Test29 "3x4 table, Akima (Ticket #1820)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,0,0.5,1;0,1,2,1;1,1,1,1],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test29;

  model Test30 "4x3 table, Akima (Ticket #1820)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,0,1;0,1,1;0.5,2,1;1,1,1],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test30;

  model Test31 "Text file with UTF-8 BOM and comments (Ticket #2404)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="akima2D",
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test_utf8.txt")));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test31;

  model Test32 "CSV file (Ticket #3691)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        delimiter=";",
        nHeaderLines=0,
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test2D.csv")));
    Modelica.Blocks.Sources.ContinuousClock clock1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.ContinuousClock clock2
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(clock1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-50,30},{-50,16},{-42,16}}, color={0,0,127}));
    connect(clock2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-50,-10},{-50,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=60));
  end Test32;

  model Test33 "Extrapolation by constant continuation (Ticket #3894)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table=[0, 1, 2; 1, 1, 7; 2, 2, 4],
            smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
            extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=3,
      rising=3,
      width=3,
      falling=3,
      period=12,
      nperiod=1,
      offset=0) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid2(
      amplitude=3,
      rising=3,
      width=3,
      falling=3,
      period=12,
      nperiod=1,
      offset=0,
      startTime=3) annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(trapezoid1.y, t_new.u1[1]) annotation (Line(
        points={{-59,30},{-52,30},{-52,16},{-42,16}}, color={0,0,127}));
    connect(trapezoid2.y, t_new.u2[1]) annotation (Line(
        points={{-59,-10},{-52,-10},{-52,4},{-42,4}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=14));
  end Test33;
end CombiTable2Dv;
