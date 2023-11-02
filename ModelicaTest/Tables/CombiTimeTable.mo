within ModelicaTest.Tables;
package CombiTimeTable "Test models for Modelica.Blocks.Sources.CombiTimeTable"
  import Modelica.Utilities.Files.loadResource;
  extends Modelica.Icons.ExamplesPackage;

  partial model Test
    Modelica.Blocks.Sources.CombiTimeTable t_new annotation(Placement(transformation(extent={{-40,0},{-20,20}})));
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

  model Test1 "Periodic, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0.1,0},{0.3,0},{0.5,-1},{0.51,-2},{0.51,-3},{
            0.6,-2},{0.7,-2},{0.7,-2},{1,-4}}, extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test1;

  model Test2 "Single row, startTime = 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test2;

  model Test3 "Single row, startTime = 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0.5,1}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test3;

  model Test4 "Two columns, Akima (Ticket #1028)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0.3, 0; 0.4, 1; 0.5, 0; 0.6, -1; 0.7, 0],
          smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test4;

  model Test5 "Three columns, Akima (Ticket #1028)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1;
            0.7, 0, 0], smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Continuous.Der d_t_new2
      annotation (Placement(transformation(extent={{0,30},{20,50}})));
  equation
    connect(t_new.y[2], d_t_new2.u) annotation (Line(
        points={{-2,40},{-7,40},{-14,40},{-14,10},{-19,10}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test5;

  model Test6 "Periodic, startTime > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.1,0},{0.2,0},{0.3,0},{0.5,-1},{0.51,-2},{0.51,-3},{0.6,-2},{
            0.7,-2},{0.7,-2},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.1));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test6;

  model Test7 "Third column, Akima (Ticket #1028)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
        table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1; 0.7, 0, 0],
        columns={3},
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test7;

  model Test8 "Three columns, Akima (Ticket #1028)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
        table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1; 0.7, 0, 0],
        columns={2,3},
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test8;

  model Test9 "Two time events (Ticket #628)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table=[0, 0; 2.5, 0; 2.5, 1; 3, 1; 3, 0]));
    annotation (experiment(StartTime=0, StopTime=3.5));
  end Test9;

  model Test10 "Single row (step), start time = t_min > 0"
    extends Modelica.Icons.Example;
    parameter Real threshold(min=0) = 0.;
    Modelica.Blocks.Sources.Step step1(startTime=1)
      annotation (Placement(transformation(extent={{-105,-15},{-85,5}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new(table={{1,1}}, startTime=1)
      annotation (Placement(transformation(extent={{-105,25},{-85,45}})));
    Modelica.Blocks.Math.Feedback feedback1
      annotation (Placement(transformation(extent={{-60,25},{-40,45}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-15,25},{5,45}})));
    Modelica.Blocks.Continuous.Integrator err1(initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0)
      annotation (Placement(transformation(extent={{20,25},{40,45}})));
  algorithm
    assert(err1.y <= threshold, "Model" + " is wrong");
  equation
    connect(t_new.y[1], feedback1.u1) annotation (Line(
        points={{-84,35},{-79,35},{-63,35},{-58,35}},
        color={0,0,127},
        thickness=0.0625));
    connect(step1.y, feedback1.u2) annotation (Line(
        points={{-84,-5},{-79,-5},{-50,-5},{-50,22},{-50,27}},
        color={0,0,127},
        thickness=0.0625));
    connect(feedback1.y, product1.u1) annotation (Line(
        points={{-41,35},{-36,35},{-22,35},{-22,41},{-17,41}},
        color={0,0,127},
        thickness=0.0625));
    connect(product1.u2, feedback1.y) annotation (Line(
        points={{-17,29},{-22,29},{-36,29},{-36,35},{-41,35}},
        color={0,0,127},
        thickness=0.0625));
    connect(product1.y, err1.u) annotation (Line(
        points={{6,35},{11,35},{13,35},{18,35}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=2));
  end Test10;

  model Test11 "Single row (step), start time > t_min > 0"
    extends Modelica.Icons.Example;
    parameter Real threshold(min=0) = 0.;
    Modelica.Blocks.Sources.Step step1(startTime=1)
      annotation (Placement(transformation(extent={{-105,-15},{-85,5}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new(table={{0.5,1}}, startTime=1)
      annotation (Placement(transformation(extent={{-105,25},{-85,45}})));
    Modelica.Blocks.Math.Feedback feedback1
      annotation (Placement(transformation(extent={{-60,25},{-40,45}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-15,25},{5,45}})));
    Modelica.Blocks.Continuous.Integrator err1(initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0)
      annotation (Placement(transformation(extent={{20,25},{40,45}})));
  algorithm
    assert(err1.y <= threshold, "Model" + " is wrong");
  equation
    connect(t_new.y[1], feedback1.u1) annotation (Line(
        points={{-84,35},{-79,35},{-63,35},{-58,35}},
        color={0,0,127},
        thickness=0.0625));
    connect(step1.y, feedback1.u2) annotation (Line(
        points={{-84,-5},{-79,-5},{-50,-5},{-50,22},{-50,27}},
        color={0,0,127},
        thickness=0.0625));
    connect(feedback1.y, product1.u1) annotation (Line(
        points={{-41,35},{-36,35},{-22,35},{-22,41},{-17,41}},
        color={0,0,127},
        thickness=0.0625));
    connect(product1.u2, feedback1.y) annotation (Line(
        points={{-17,29},{-22,29},{-36,29},{-36,35},{-41,35}},
        color={0,0,127},
        thickness=0.0625));
    connect(product1.y, err1.u) annotation (Line(
        points={{6,35},{11,35},{13,35},{18,35}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=2));
  end Test11;

  model Test12 "Single row (step), t_min > start time > 0"
    extends Modelica.Icons.Example;
    parameter Real threshold(min=0) = 0.;
    Modelica.Blocks.Sources.Step step1(startTime=0.5)
      annotation (Placement(transformation(extent={{-105,-15},{-85,5}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new(table={{1,1}}, startTime=0.5)
      annotation (Placement(transformation(extent={{-105,25},{-85,45}})));
    Modelica.Blocks.Math.Feedback feedback1
      annotation (Placement(transformation(extent={{-60,25},{-40,45}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-15,25},{5,45}})));
    Modelica.Blocks.Continuous.Integrator err1(initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0)
      annotation (Placement(transformation(extent={{20,25},{40,45}})));
  algorithm
    assert(err1.y <= threshold, "Model" + " is wrong");
  equation
    connect(t_new.y[1], feedback1.u1) annotation (Line(
        points={{-84,35},{-79,35},{-63,35},{-58,35}},
        color={0,0,127},
        thickness=0.0625));
    connect(step1.y, feedback1.u2) annotation (Line(
        points={{-84,-5},{-79,-5},{-50,-5},{-50,22},{-50,27}},
        color={0,0,127},
        thickness=0.0625));
    connect(feedback1.y, product1.u1) annotation (Line(
        points={{-41,35},{-36,35},{-22,35},{-22,41},{-17,41}},
        color={0,0,127},
        thickness=0.0625));
    connect(product1.u2, feedback1.y) annotation (Line(
        points={{-17,29},{-22,29},{-36,29},{-36,35},{-41,35}},
        color={0,0,127},
        thickness=0.0625));
    connect(product1.y, err1.u) annotation (Line(
        points={{6,35},{11,35},{13,35},{18,35}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=2));
  end Test12;

  model Test13 "Single row (step), t_min > start time = 0"
    extends Modelica.Icons.Example;
    parameter Real threshold(min=0) = 0.;
    Modelica.Blocks.Sources.Step step1
      annotation (Placement(transformation(extent={{-105,-15},{-85,5}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new(table={{1,1}})
      annotation (Placement(transformation(extent={{-105,25},{-85,45}})));
    Modelica.Blocks.Math.Feedback feedback1
      annotation (Placement(transformation(extent={{-60,25},{-40,45}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-15,25},{5,45}})));
    Modelica.Blocks.Continuous.Integrator err1(initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0)
      annotation (Placement(transformation(extent={{20,25},{40,45}})));
  algorithm
    assert(err1.y <= threshold, "Model" + " is wrong");
  equation
    connect(t_new.y[1], feedback1.u1) annotation (Line(
        points={{-84,35},{-79,35},{-63,35},{-58,35}},
        color={0,0,127},
        thickness=0.0625));
    connect(step1.y, feedback1.u2) annotation (Line(
        points={{-84,-5},{-79,-5},{-50,-5},{-50,22},{-50,27}},
        color={0,0,127},
        thickness=0.0625));
    connect(feedback1.y, product1.u1) annotation (Line(
        points={{-41,35},{-36,35},{-22,35},{-22,41},{-17,41}},
        color={0,0,127},
        thickness=0.0625));
    connect(product1.u2, feedback1.y) annotation (Line(
        points={{-17,29},{-22,29},{-36,29},{-36,35},{-41,35}},
        color={0,0,127},
        thickness=0.0625));
    connect(product1.y, err1.u) annotation (Line(
        points={{6,35},{11,35},{13,35},{18,35}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=2));
  end Test13;

  model Test14
    "Two rows (trapezoid), start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    parameter Real threshold(min=0) = 1e-12;
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      width=0,
      falling=1,
      nperiod=1,
      startTime=0.5,
      period=1)
      annotation (Placement(transformation(extent={{-105,-15},{-85,5}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new(
      table={{0,1},{1,0}},
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      startTime=0.5)
      annotation (Placement(transformation(extent={{-105,25},{-85,45}})));
    Modelica.Blocks.Math.Feedback feedback1
      annotation (Placement(transformation(extent={{-60,25},{-40,45}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-15,25},{5,45}})));
    Modelica.Blocks.Continuous.Integrator err1(initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0)
      annotation (Placement(transformation(extent={{20,25},{40,45}})));
  algorithm
    assert(err1.y <= threshold, "Model" + " is wrong");
  equation
    connect(t_new.y[1], feedback1.u1) annotation (Line(
        points={{-84,35},{-79,35},{-63,35},{-58,35}},
        color={0,0,127},
        thickness=0.0625));
    connect(trapezoid1.y, feedback1.u2) annotation (Line(
        points={{-84,-5},{-79,-5},{-50,-5},{-50,22},{-50,27}},
        color={0,0,127},
        thickness=0.0625));
    connect(feedback1.y, product1.u1) annotation (Line(
        points={{-41,35},{-36,35},{-22,35},{-22,41},{-17,41}},
        color={0,0,127},
        thickness=0.0625));
    connect(product1.u2, feedback1.y) annotation (Line(
        points={{-17,29},{-22,29},{-36,29},{-36,35},{-41,35}},
        color={0,0,127},
        thickness=0.0625));
    connect(product1.y, err1.u) annotation (Line(
        points={{6,35},{11,35},{13,35},{18,35}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=2));
  end Test14;

  model Test15 "Two rows, start time > 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{1,0}}, startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test15;

  model Test16 "Two rows, start time > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0.25,1},{1.25,0}}, startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test16;

  model Test17 "Two rows, start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0,1},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test17;

  model Test18 "Two rows, start time > 0, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.25,1},{1.25,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test18;

  model Test19 "Three rows, start time > 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{0.5,2},{1,0}}, startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test19;

  model Test20 "Three rows, start time > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{0.5,2},{1,0}}, startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test20;

  model Test21 "Three rows, start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0,1},{0.5,2},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test21;

  model Test22 "Three rows, start time > 0, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0,1},{0.5,2},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test22;

  model Test23 "Four rows, event, start time > 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{0.5,2},{0.5,2},{1,0}}, startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test23;

  model Test24 "Four rows, event, start time > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{0.5,2},{0.5,2},{1,0}}, startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test24;

  model Test25 "Four rows, event, start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0,1},{0.5,2},{0.5,2},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test25;

  model Test26 "Four rows, event, start time > 0, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0,1},{0.5,2},{0.5,2},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test26;

  model Test27 "Three rows, last two same, start time > 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{1,0},{1,0}}, startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test27;

  model Test28 "Three rows, last two same, start time > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{1,0},{1,0}}, startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test28;

  model Test29
    "Three rows, last two same, start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0,1},{1,0},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test29;

  model Test30
    "Three rows, last two same, start time > 0, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0,1},{1,0},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test30;

  model Test31 "Three rows, first two same, start time > 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{0,1},{1,0}}, startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test31;

  model Test32 "Three rows, first two same, start time > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0,1},{0,1},{1,0}}, startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test32;

  model Test33
    "Three rows, first two same, start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0,1},{0,1},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test33;

  model Test34
    "Three rows, first two same, start time > 0, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0,1},{0,1},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test34;

  model Test35 "Problematic Akima (Ticket #1039)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0, 5; 1, 3; 2, 1; 3, 1; 4, 1; 5, 3], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=3));
  end Test35;

  model Test36 "Problematic Akima (Ticket #1039), flipped"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(table=[0, 3; 1, 1; 2, 1; 3, 1; 4, 3; 5, 5], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=3));
  end Test36;

  model Test37
    "Two time events (Ticket #628), constant segments, hold last value"
    extends Modelica.Icons.Example;
    extends Test(t_new(
        table=[0, 0; 2.5, 1; 3, 0],
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=3.5));
  end Test37;

  model Test38 "Two time events (Ticket #628), constant segments, periodic"
    extends Modelica.Icons.Example;
    extends Test(t_new(
        table=[0, 0; 2.5, 1; 3, 0],
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test38;

  model Test39
    "Two time events (Ticket #628), constant segments, periodic, startTime > 0"
    extends Modelica.Icons.Example;
    extends Test(t_new(
        table=[0, 0; 2.5, 1; 3, 0],
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=5));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test39;

  model Test40 "Two time events (Ticket #628), periodic"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table=[0, 0; 2.5, 0; 2.5, 1; 3, 1; 3, 0], extrapolation
          =Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test40;

  model Test41 "Two time events (Ticket #628), periodic, startTime > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table=[0, 0; 2.5, 0; 2.5, 1; 3, 1; 3, 0],
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=5));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test41;

  model Test42 "Periodic, startTime = 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0.6,-2},{0.7,-2},{0.7,-2},{1,-4}},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test42;

  model Test43 "Periodic, startTime > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.6,-2},{0.7,-2},{0.7,-2},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test43;

  model Test44 "Periodic, startTime > t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.6,-2},{0.7,-2},{0.7,-2},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.7));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test44;

  model Test45 "Periodic, startTime > t_max, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.6,-2},{0.7,-2},{0.7,-2},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=1.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test45;

  model Test46 "Periodic, startTime = 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{
            0.7,-2},{1,-5},{1,-6},{1,-4}}, extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test46;

  model Test47 "Periodic, startTime > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test47;

  model Test48 "Periodic, startTime > t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.7));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test48;

  model Test49 "Periodic, startTime > t_max, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=1.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test49;

  model Test50 "ASCII Text file (Very long line length)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="longLine",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test.txt"),
        columns={2,2500}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test50;

  model Test51 "Periodic, startTime = 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(table={{0.6,-2},{0.6,-3},{0.7,-2},{1,-5},{1,-6},{1,-4}},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test51;

  model Test52 "Periodic, startTime > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.6,-2},{0.6,-3},{0.7,-2},{1,-5},{1,-6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test52;

  model Test53 "Periodic, startTime > t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.6,-2},{0.6,-3},{0.7,-2},{1,-5},{1,-6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.7));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test53;

  model Test54 "Periodic, startTime > t_max, t_min > 0"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        table={{0.6,-2},{0.6,-3},{0.7,-2},{1,-5},{1,-6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=1.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test54;

  model Test55 "MAT-File v4"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v4.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test55;

  model Test56 "MAT-File v6"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v6.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test56;

  model Test57 "MAT-File v7"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test57;

  /*
  model Test58 "MAT-File v7.3"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.3.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test58;
*/

  model Test59 "ASCII Text file"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test.txt")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test59;

  model Test60 "ASCII Text file (TAB separated)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a_tab",
        fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test.txt")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test60;

  model Test61 "Periodic, startTime = 0, t_min > 0, constant segments"
    extends Modelica.Icons.Example;
    extends Test(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test61;

  model Test62 "Periodic, startTime > 0, t_min > 0, constant segments"
    extends Modelica.Icons.Example;
    extends Test(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test62;

  model Test63 "Periodic, startTime > t_min > 0, constant segments"
    extends Modelica.Icons.Example;
    extends Test(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.7));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test63;

  model Test64 "Periodic, startTime > t_max, t_min > 0, constant segments"
    extends Modelica.Icons.Example;
    extends Test(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=1.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test64;

  model Test65 "Two columns, constant segments"
    extends Modelica.Icons.Example;
    extends Test(t_new(table=[0.3, 0; 0.4, 1; 0.5, 0; 0.6, -1; 0.7, 0],
          smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test65;

  model Test66_usertab "Test utilizing the usertab.c interface"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(tableOnFile=true, tableName="TestTable_1D_Time"));
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
double mydummyfunc(double* dummy_in) {
    return 0.;
}
");
    end getUsertab;
  initial equation
    dummy = getUsertab(t_new.y);
    annotation (experiment(StartTime=0, StopTime=4));
  end Test66_usertab;

  model Test67 "timeScale (Tickets #1473, #1627)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.CombiTimeTable t_s(
      table=[0,0;1800,1;1800,1;3600,0],
      startTime=400) annotation(Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.CombiTimeTable t_min(
      table=[0,0;30,1;30,1;60,0],
      startTime=400,
      timeScale(displayUnit="min")=60) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    Modelica.Blocks.Sources.CombiTimeTable t_h(
      table=[0,0;0.5,1;0.5,1;1,0],
      startTime=400,
      timeScale(displayUnit="h")=3.6e3) annotation(Placement(transformation(extent={{-40,-60},{-20,-40}})));
    Modelica.Blocks.Sources.CombiTimeTable t_d(
      table=[0,0;1/48,1;1/48,1;1/24,0],
      startTime=400,
      timeScale(displayUnit="d")=86.4e3) annotation(Placement(transformation(extent={{-40,-90},{-20,-70}})));
    Modelica.Blocks.Sources.CombiTimeTable t_ms(
      table=[0,0;1.8e6,1;1.8e6,1;3.6e6,0],
      startTime=400,
      timeScale(displayUnit="ms")=1e-3) annotation(Placement(transformation(extent={{-40,-120},{-20,-100}})));
    Modelica.Blocks.Continuous.Der d_t_s annotation(Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Blocks.Continuous.Der d_t_min annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d_t_h annotation(Placement(transformation(extent={{0,-60},{20,-40}})));
    Modelica.Blocks.Continuous.Der d_t_d annotation(Placement(transformation(extent={{0,-90},{20,-70}})));
    Modelica.Blocks.Continuous.Der d_t_ms annotation(Placement(transformation(extent={{0,-120},{20,-100}})));
  equation
    connect(t_s.y[1], d_t_s.u) annotation (Line(
        points={{-19,10},{-2,10}},
        color={0,0,127},
        thickness=0.0625));
    connect(t_min.y[1], d_t_min.u) annotation (Line(
        points={{-19,-20},{-2,-20}},
        color={0,0,127},
        thickness=0.0625));
    connect(t_h.y[1], d_t_h.u) annotation (Line(
        points={{-19,-50},{-2,-50}},
        color={0,0,127},
        thickness=0.0625));
    connect(t_d.y[1], d_t_d.u) annotation (Line(
        points={{-19,-80},{-2,-80}},
        color={0,0,127},
        thickness=0.0625));
    connect(t_ms.y[1], d_t_ms.u) annotation (Line(
        points={{-19,-110},{-2,-110}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=4000));
  end Test67;

  model Test68 "No internal event, startTime > t_min > 0 (Ticket #1619)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.CombiTimeTable startTime_0(
      table=startTime.table,
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      offset={33.1818}) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.CombiTimeTable startTime(
      table=[9.81594,0; 90.7974,7.2727; 181.5948,23.1818; 279.7548,43.6364;
        382.8222,67.2732; 478.5276,88.1822; 623.31,109.5452; 746.01,125.4542;
        895.704,141.3632; 1013.496,149.0912; 1057.668,169.5452; 1121.472,
        179.5452; 1207.362,191.8182; 1332.516,205.4542; 1442.946,214.0912;
        1604.91,224.0912; 1747.242,231.8182; 1943.556,240.9092; 2157.054,
        248.6362; 2346.012,256.8182; 2544.786,264.5452; 2760.738,274.0912;
        3190.182,292.7272; 3418.404,303.1822; 3663.804,312.7272; 3909.204,
        322.7272; 4053.99,326.8182; 4164.42,331.8182],
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      offset={33.1818},
      startTime=2000) annotation (Placement(transformation(extent={{0,0},{20,20}})));
    annotation (experiment(StartTime=0, StopTime=8000));
  end Test68;

  model Test69 "No internal event, startTime < 0, t_min > 0 (Ticket #1619)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.CombiTimeTable startTime_0(
      table=startTime.table,
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      offset={33.1818}) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.CombiTimeTable startTime(
      table=[9.81594,0; 90.7974,7.2727; 181.5948,23.1818; 279.7548,43.6364;
        382.8222,67.2732; 478.5276,88.1822; 623.31,109.5452; 746.01,125.4542;
        895.704,141.3632; 1013.496,149.0912; 1057.668,169.5452; 1121.472,
        179.5452; 1207.362,191.8182; 1332.516,205.4542; 1442.946,214.0912;
        1604.91,224.0912; 1747.242,231.8182; 1943.556,240.9092; 2157.054,
        248.6362; 2346.012,256.8182; 2544.786,264.5452; 2760.738,274.0912;
        3190.182,292.7272; 3418.404,303.1822; 3663.804,312.7272; 3909.204,
        322.7272; 4053.99,326.8182; 4164.42,331.8182],
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      offset={33.1818},
      startTime=-2000) annotation (Placement(transformation(extent={{0,0},{20,20}})));
    annotation (experiment(StartTime=0, StopTime=8000));
  end Test69;

  model Test70 "One internal event, startTime > t_min > 0 (Ticket #1619)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.CombiTimeTable startTime_0(
      table=startTime.table,
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      offset={33.1818}) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.CombiTimeTable startTime(
      table=[9.81594,0; 90.7974,7.2727; 181.5948,23.1818; 279.7548,43.6364;
        382.8222,67.2732; 478.5276,88.1822; 623.31,109.5452; 746.01,125.4542;
        895.704,141.3632; 1013.496,149.0912; 1057.668,149.0912; 1057.668,169.5452; 1121.472,
        179.5452; 1207.362,191.8182; 1332.516,205.4542; 1442.946,214.0912;
        1604.91,224.0912; 1747.242,231.8182; 1943.556,240.9092; 2157.054,
        248.6362; 2346.012,256.8182; 2544.786,264.5452; 2760.738,274.0912;
        3190.182,292.7272; 3418.404,303.1822; 3663.804,312.7272; 3909.204,
        322.7272; 4053.99,326.8182; 4164.42,331.8182],
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      offset={33.1818},
      startTime=2000) annotation (Placement(transformation(extent={{0,0},{20,20}})));
    annotation (experiment(StartTime=0, StopTime=8000));
  end Test70;

  model Test71 "One internal event @ 1057.668, startTime < 0, t_event < -startTime, t_min > 0 (Ticket #1619)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.CombiTimeTable startTime_0(
      table=startTime.table,
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      offset={33.1818}) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.CombiTimeTable startTime(
      table=[9.81594,0; 90.7974,7.2727; 181.5948,23.1818; 279.7548,43.6364;
        382.8222,67.2732; 478.5276,88.1822; 623.31,109.5452; 746.01,125.4542;
        895.704,141.3632; 1013.496,149.0912; 1057.668,149.0912; 1057.668,169.5452; 1121.472,
        179.5452; 1207.362,191.8182; 1332.516,205.4542; 1442.946,214.0912;
        1604.91,224.0912; 1747.242,231.8182; 1943.556,240.9092; 2157.054,
        248.6362; 2346.012,256.8182; 2544.786,264.5452; 2760.738,274.0912;
        3190.182,292.7272; 3418.404,303.1822; 3663.804,312.7272; 3909.204,
        322.7272; 4053.99,326.8182; 4164.42,331.8182],
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      offset={33.1818},
      startTime=-2000) annotation (Placement(transformation(extent={{0,0},{20,20}})));
    annotation (experiment(StartTime=0, StopTime=8000));
  end Test71;

  model Test72 "One internal event @ 1057.668, startTime < 0, t_event > -startTime, t_min > 0 (Ticket #1619)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.CombiTimeTable startTime_0(
      table=startTime.table,
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      offset={33.1818}) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.CombiTimeTable startTime(
      table=[9.81594,0; 90.7974,7.2727; 181.5948,23.1818; 279.7548,43.6364;
        382.8222,67.2732; 478.5276,88.1822; 623.31,109.5452; 746.01,125.4542;
        895.704,141.3632; 1013.496,149.0912; 1057.668,149.0912; 1057.668,169.5452; 1121.472,
        179.5452; 1207.362,191.8182; 1332.516,205.4542; 1442.946,214.0912;
        1604.91,224.0912; 1747.242,231.8182; 1943.556,240.9092; 2157.054,
        248.6362; 2346.012,256.8182; 2544.786,264.5452; 2760.738,274.0912;
        3190.182,292.7272; 3418.404,303.1822; 3663.804,312.7272; 3909.204,
        322.7272; 4053.99,326.8182; 4164.42,331.8182],
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      offset={33.1818},
      startTime=-1000) annotation (Placement(transformation(extent={{0,0},{20,20}})));
    annotation (experiment(StartTime=0, StopTime=8000));
  end Test72;

  model Test73 "Fritsch-Butland, test data set (Ticket #1039)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,5;1,3;2,1;3,1;4,1;5,3],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      table=[0,5;1,3;2,1;3,1;4,1;5,3],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    Modelica.Blocks.Continuous.Der d_t_new_2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new_2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  equation
      connect(t_new_2.y[1], d_t_new_2.u) annotation(Line(points={{-19,-20},{-2,-20}}, color={0,0,127}));
      connect(d_t_new_2.y, d2_t_new_2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=4));
  end Test73;

  model Test74 "Fritsch-Butland, data set AKIMA 3 (Ticket #1717)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,10;2,10;3,10;5,10;6,10;8,10;9,10.5;11,15;12,50;14,60;15,85],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      table=[0,10;2,10;3,10;5,10;6,10;8,10;9,10.5;11,15;12,50;14,60;15,85],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    Modelica.Blocks.Continuous.Der d_t_new_2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new_2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  equation
      connect(t_new_2.y[1], d_t_new_2.u) annotation(Line(points={{-19,-20},{-2,-20}}, color={0,0,127}));
      connect(d_t_new_2.y, d2_t_new_2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=15));
  end Test74;

  model Test75 "Fritsch-Butland, data set RPN 14 (Ticket #1717)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[7.99,0;8.09,2.76429e-5;8.19,4.37498e-2;8.7,0.169183;9.2,0.469428;10,0.94374;12,0.998636;15,0.999919;20,0.999994],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      table=[7.99,0;8.09,2.76429e-5;8.19,4.37498e-2;8.7,0.169183;9.2,0.469428;10,0.94374;12,0.998636;15,0.999919;20,0.999994],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    Modelica.Blocks.Continuous.Der d_t_new_2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new_2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  equation
      connect(t_new_2.y[1], d_t_new_2.u) annotation(Line(points={{-19,-20},{-2,-20}}, color={0,0,127}));
      connect(d_t_new_2.y, d2_t_new_2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
    annotation (experiment(StartTime=7.99, StopTime=20));
  end Test75;

  model Test76 "Single row, Akima (Ticket #1820)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,1,2,3],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test76;

  model Test77 "Steffen, test data set (Ticket #1814)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,5;1,3;2,1;3,1;4,1;5,3],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      table=[0,5;1,3;2,1;3,1;4,1;5,3],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    Modelica.Blocks.Continuous.Der d_t_new_2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new_2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  equation
      connect(t_new_2.y[1], d_t_new_2.u) annotation(Line(points={{-19,-20},{-2,-20}}, color={0,0,127}));
      connect(d_t_new_2.y, d2_t_new_2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=4));
  end Test77;

  model Test78 "Steffen, data set AKIMA 3 (Ticket #1814)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[0,10;2,10;3,10;5,10;6,10;8,10;9,10.5;11,15;12,50;14,60;15,85],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      table=[0,10;2,10;3,10;5,10;6,10;8,10;9,10.5;11,15;12,50;14,60;15,85],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    Modelica.Blocks.Continuous.Der d_t_new_2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new_2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  equation
      connect(t_new_2.y[1], d_t_new_2.u) annotation(Line(points={{-19,-20},{-2,-20}}, color={0,0,127}));
      connect(d_t_new_2.y, d2_t_new_2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=15));
  end Test78;

  model Test79 "Steffen, data set RPN 14 (Ticket #1814)"
    extends Modelica.Icons.Example;
    extends TestDer2(t_new(
      table=[7.99,0;8.09,2.76429e-5;8.19,4.37498e-2;8.7,0.169183;9.2,0.469428;10,0.94374;12,0.998636;15,0.999919;20,0.999994],
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      table=[7.99,0;8.09,2.76429e-5;8.19,4.37498e-2;8.7,0.169183;9.2,0.469428;10,0.94374;12,0.998636;15,0.999919;20,0.999994],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    Modelica.Blocks.Continuous.Der d_t_new_2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new_2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  equation
      connect(t_new_2.y[1], d_t_new_2.u) annotation(Line(points={{-19,-20},{-2,-20}}, color={0,0,127}));
      connect(d_t_new_2.y, d2_t_new_2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
    annotation (experiment(StartTime=7.99, StopTime=20));
  end Test79;

  model Test80 "MAT-File v6, struct variable (Ticket #1840)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.CombiTimeTable t_new(
      tableOnFile=true,
      tableName="s.tab1",
      fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v6.mat")) annotation(Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      tableOnFile=true,
      tableName="s.s.tab1",
      fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v6.mat")) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    annotation (experiment(StartTime=0, StopTime=4));
  end Test80;

  model Test81 "MAT-File v7, struct variable (Ticket #1840)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.CombiTimeTable t_new(
      tableOnFile=true,
      tableName="s.tab1",
      fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.mat")) annotation(Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      tableOnFile=true,
      tableName="s.s.tab1",
      fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.mat")) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    annotation (experiment(StartTime=0, StopTime=4));
  end Test81;

  /*
  model Test82 "MAT-File v7.3, struct variable (Ticket #1840)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.CombiTimeTable t_new(
      tableOnFile=true,
      tableName="s.tab1",
      fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.3.mat")) annotation(Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      tableOnFile=true,
      tableName="s.s.tab1",
      fileName=loadResource("modelica://Modelica/Resources/Data/Tables/test_v7.3.mat")) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    annotation (experiment(StartTime=0, StopTime=4));
  end Test82;
*/
  model Test83 "Simulation StartTime = t_max (Ticket #2233)"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.CombiTimeTable t_new(
      table=[0,1;0.4,0;1,1],
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      columns={2}) annotation(Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.BooleanTable booleanTable(table={0,0.4,1}) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    annotation (experiment(StartTime=1, StopTime=3));
  end Test83;

  model Test84 "Text file with UTF-8 BOM and comments (Ticket #2404)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test_utf8.txt")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test84;

  model Test85 "Single time event at t_min=t_max > startTime = 0 (Ticket #2724)"
    extends Modelica.Icons.Example;
    extends Test(t_new(
      table=[1,10;1,11],
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments));
    annotation (experiment(StartTime=0, StopTime=3));
  end Test85;

  model Test86 "Two time events (Ticket #2724)"
    extends Modelica.Icons.Example;
    extends Test(t_new(
      table=[1,10;1,11;2,12],
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments));
    annotation (experiment(StartTime=0, StopTime=3));
  end Test86;

  model Test87 "Modified Akima, comparison, first test data set (Ticket #1039)"
    extends Modelica.Icons.Example;
    final constant Real table[:,2] = [1,0;2,0;3,0;4,0.5;5,0.5;5.5,1.2;7,1.2;8,0.1;9,0;9.5,0.3;10,0.6] "Table data";
    extends TestDer2(t_new(
      table=table,
      smoothness=Modelica.Blocks.Types.Smoothness.ModifiedContinuousDerivative));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      table=table,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new_3(
      table=table,
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1) annotation(Placement(transformation(extent={{-40,-60},{-20,-40}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new_4(
      table=table,
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2) annotation(Placement(transformation(extent={{-40,-90},{-20,-70}})));
    Modelica.Blocks.Continuous.Der d_t_new_2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new_2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
    Modelica.Blocks.Continuous.Der d_t_new_3 annotation(Placement(transformation(extent={{0,-60},{20,-40}})));
    Modelica.Blocks.Continuous.Der d2_t_new_3 annotation(Placement(transformation(extent={{40,-60},{60,-40}})));
    Modelica.Blocks.Continuous.Der d_t_new_4 annotation(Placement(transformation(extent={{0,-90},{20,-70}})));
    Modelica.Blocks.Continuous.Der d2_t_new_4 annotation(Placement(transformation(extent={{40,-90},{60,-70}})));
  equation
      connect(t_new_2.y[1], d_t_new_2.u) annotation(Line(points={{-19,-20},{-2,-20}}, color={0,0,127}));
      connect(d_t_new_2.y, d2_t_new_2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
      connect(d_t_new_3.y,d2_t_new_3.u) annotation(Line(points={{21,-50},{26,-50},{33,-50},{38,-50}},   color={0,0,127}));
      connect(t_new_3.y[1],d_t_new_3.u) annotation(Line(points={{-19,-50},{-2,-50}}, color={0,0,127}));
      connect(d_t_new_4.y,d2_t_new_4.u) annotation(Line(points={{21,-80},{26,-80},{33,-80},{38,-80}},   color={0,0,127}));
      connect(t_new_4.y[1],d_t_new_4.u) annotation(Line(points={{-19,-80},{-2,-80}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=11));
  end Test87;

  model Test88 "Modified Akima, comparison, second test data set (Ticket #1039)"
    extends Modelica.Icons.Example;
    final constant Real table[:,2] = [1,-1;2,-1;3,-1;4,0;5,1;6,1+1e-15;7,1;8,1] "Table data";
    extends TestDer2(t_new(
      table=table,
      smoothness=Modelica.Blocks.Types.Smoothness.ModifiedContinuousDerivative));
    Modelica.Blocks.Sources.CombiTimeTable t_new_2(
      table=table,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new_3(
      table=table,
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1) annotation(Placement(transformation(extent={{-40,-60},{-20,-40}})));
    Modelica.Blocks.Sources.CombiTimeTable t_new_4(
      table=table,
      smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2) annotation(Placement(transformation(extent={{-40,-90},{-20,-70}})));
    Modelica.Blocks.Continuous.Der d_t_new_2 annotation(Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.Der d2_t_new_2 annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
    Modelica.Blocks.Continuous.Der d_t_new_3 annotation(Placement(transformation(extent={{0,-60},{20,-40}})));
    Modelica.Blocks.Continuous.Der d2_t_new_3 annotation(Placement(transformation(extent={{40,-60},{60,-40}})));
    Modelica.Blocks.Continuous.Der d_t_new_4 annotation(Placement(transformation(extent={{0,-90},{20,-70}})));
    Modelica.Blocks.Continuous.Der d2_t_new_4 annotation(Placement(transformation(extent={{40,-90},{60,-70}})));
  equation
      connect(t_new_2.y[1], d_t_new_2.u) annotation(Line(points={{-19,-20},{-2,-20}}, color={0,0,127}));
      connect(d_t_new_2.y, d2_t_new_2.u) annotation(Line(points={{21,-20},{26,-20},{33,-20},{38,-20}}, color={0,0,127}));
      connect(d_t_new_3.y,d2_t_new_3.u) annotation(Line(points={{21,-50},{26,-50},{33,-50},{38,-50}},   color={0,0,127}));
      connect(t_new_3.y[1],d_t_new_3.u) annotation(Line(points={{-19,-50},{-2,-50}}, color={0,0,127}));
      connect(d_t_new_4.y,d2_t_new_4.u) annotation(Line(points={{21,-80},{26,-80},{33,-80},{38,-80}},   color={0,0,127}));
      connect(t_new_4.y[1],d_t_new_4.u) annotation(Line(points={{-19,-80},{-2,-80}}, color={0,0,127}));
    annotation (experiment(StartTime=0, StopTime=9));
  end Test88;

  model Test89 "CSV file (Ticket #3691)"
    extends Modelica.Icons.Example;
    extends TestDer(t_new(
        tableOnFile=true,
        delimiter=",",
        nHeaderLines=1,
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test1D.csv")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test89;
end CombiTimeTable;
