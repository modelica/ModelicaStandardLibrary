within ModelicaTest.Tables;
package CombiTimeTable
  import Modelica.Utilities.Files.loadResource;
  extends Modelica.Icons.ExamplesPackage;

  partial model Test0
    Modelica.Blocks.Sources.CombiTimeTable t_new
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Continuous.Der d_t_new
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
  equation
    connect(t_new.y[1], d_t_new.u) annotation (Line(
        points={{-19,10},{-2,10}},
        color={0,0,127},
        thickness=0.0625));
  end Test0;

  partial model Test0_noDer
    Modelica.Blocks.Sources.CombiTimeTable t_new
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  end Test0_noDer;

  model Test1 "Periodic, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0.1,0},{0.3,0},{0.5,-1},{0.51,-2},{0.51,-3},{
            0.6,-2},{0.7,-2},{0.7,-2},{1,-4}}, extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test1;

  model Test2 "Single row, startTime = 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test2;

  model Test3 "Single row, startTime = 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0.5,1}}));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test3;

  model Test4 "Two columns, Akima (Ticket #1028)"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0.3, 0; 0.4, 1; 0.5, 0; 0.6, -1; 0.7, 0],
          smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test4;

  model Test5 "Three columns, Akima (Ticket #1028)"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1;
            0.7, 0, 0], smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    Modelica.Blocks.Continuous.Der d_t_new2
      annotation (Placement(transformation(extent={{-60,25},{-40,45}})));
  equation
    connect(t_new.y[2], d_t_new2.u) annotation (Line(
        points={{-84,35},{-79,35},{-63,35},{-58,35}},
        color={0,0,127},
        thickness=0.0625));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test5;

  model Test6 "Periodic, startTime > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.1,0},{0.2,0},{0.3,0},{0.5,-1},{0.51,-2},{0.51,-3},{0.6,-2},{
            0.7,-2},{0.7,-2},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.1));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test6;

  model Test7 "Third column, Akima (Ticket #1028)"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1; 0.7, 0, 0],
        columns={3},
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test7;

  model Test8 "Three columns, Akima (Ticket #1028)"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table=[0.3, 0, 0; 0.4, 1, -1; 0.5, 0, 0; 0.6, -1, 1; 0.7, 0, 0],
        columns={2,3},
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test8;

  model Test9 "Two time events (Ticket #628)"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0; 2.5, 0; 2.5, 1; 3, 1; 3, 0]));
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
    extends Test0(t_new(table={{0,1},{1,0}}, startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test15;

  model Test16 "Two rows, start time > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0.25,1},{1.25,0}}, startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test16;

  model Test17 "Two rows, start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0,1},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test17;

  model Test18 "Two rows, start time > 0, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.25,1},{1.25,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test18;

  model Test19 "Three rows, start time > 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{0.5,2},{1,0}}, startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test19;

  model Test20 "Three rows, start time > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{0.5,2},{1,0}}, startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test20;

  model Test21 "Three rows, start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0,1},{0.5,2},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test21;

  model Test22 "Three rows, start time > 0, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0,1},{0.5,2},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test22;

  model Test23 "Four rows, event, start time > 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{0.5,2},{0.5,2},{1,0}}, startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test23;

  model Test24 "Four rows, event, start time > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{0.5,2},{0.5,2},{1,0}}, startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test24;

  model Test25 "Four rows, event, start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0,1},{0.5,2},{0.5,2},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test25;

  model Test26 "Four rows, event, start time > 0, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0,1},{0.5,2},{0.5,2},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test26;

  model Test27 "Three rows, last two same, start time > 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{1,0},{1,0}}, startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test27;

  model Test28 "Three rows, last two same, start time > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{1,0},{1,0}}, startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test28;

  model Test29
    "Three rows, last two same, start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0,1},{1,0},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test29;

  model Test30
    "Three rows, last two same, start time > 0, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0,1},{1,0},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test30;

  model Test31 "Three rows, first two same, start time > 0, t_min = 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{0,1},{1,0}}, startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test31;

  model Test32 "Three rows, first two same, start time > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0,1},{0,1},{1,0}}, startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test32;

  model Test33
    "Three rows, first two same, start time > 0, t_min = 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0,1},{0,1},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test33;

  model Test34
    "Three rows, first two same, start time > 0, t_min > 0, hold last value"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0,1},{0,1},{1,0}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        startTime=0.25));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test34;

  model Test35 "Problematic Akima (Ticket #1039)"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 5; 1, 3; 2, 1; 3, 1; 4, 1; 5, 3], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=3));
  end Test35;

  model Test36 "Problematic Akima (Ticket #1039), flipped"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 3; 1, 1; 2, 1; 3, 1; 4, 3; 5, 5], smoothness=
            Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
    annotation (experiment(StartTime=0, StopTime=3));
  end Test36;

  model Test37
    "Two time events (Ticket #628), constant segments, hold last value"
    extends Modelica.Icons.Example;
    extends Test0_noDer(t_new(
        table=[0, 0; 2.5, 1; 3, 0],
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    annotation (experiment(StartTime=0, StopTime=3.5));
  end Test37;

  model Test38 "Two time events (Ticket #628), constant segments, periodic"
    extends Modelica.Icons.Example;
    extends Test0_noDer(t_new(
        table=[0, 0; 2.5, 1; 3, 0],
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test38;

  model Test39
    "Two time events (Ticket #628), constant segments, periodic, startTime > 0"
    extends Modelica.Icons.Example;
    extends Test0_noDer(t_new(
        table=[0, 0; 2.5, 1; 3, 0],
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=5));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test39;

  model Test40 "Two time events (Ticket #628), periodic"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table=[0, 0; 2.5, 0; 2.5, 1; 3, 1; 3, 0], extrapolation
          =Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test40;

  model Test41 "Two time events (Ticket #628), periodic, startTime > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table=[0, 0; 2.5, 0; 2.5, 1; 3, 1; 3, 0],
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=5));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test41;

  model Test42 "Periodic, startTime = 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0.6,-2},{0.7,-2},{0.7,-2},{1,-4}},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test42;

  model Test43 "Periodic, startTime > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.6,-2},{0.7,-2},{0.7,-2},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test43;

  model Test44 "Periodic, startTime > t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.6,-2},{0.7,-2},{0.7,-2},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.7));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test44;

  model Test45 "Periodic, startTime > t_max, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.6,-2},{0.7,-2},{0.7,-2},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=1.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test45;

  model Test46 "Periodic, startTime = 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{
            0.7,-2},{1,-5},{1,-6},{1,-4}}, extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test46;

  model Test47 "Periodic, startTime > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test47;

  model Test48 "Periodic, startTime > t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.7));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test48;

  model Test49 "Periodic, startTime > t_max, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=1.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test49;

  model Test50 "ASCII Text file (Very long line length)"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="longLine",
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test.txt"),
        columns={2,2500}));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test50;

  model Test51 "Periodic, startTime = 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(table={{0.6,-2},{0.6,-3},{0.7,-2},{1,-5},{1,-6},{1,-4}},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test51;

  model Test52 "Periodic, startTime > 0, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.6,-2},{0.6,-3},{0.7,-2},{1,-5},{1,-6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test52;

  model Test53 "Periodic, startTime > t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.6,-2},{0.6,-3},{0.7,-2},{1,-5},{1,-6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.7));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test53;

  model Test54 "Periodic, startTime > t_max, t_min > 0"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        table={{0.6,-2},{0.6,-3},{0.7,-2},{1,-5},{1,-6},{1,-4}},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=1.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test54;

  model Test55 "MAT-File v4"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test_v4.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test55;

  model Test56 "MAT-File v6"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test_v6.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test56;

  model Test57 "MAT-File v7"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test_v7.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test57;

  /*
  model Test58 "MAT-File v7.3"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test_v7.3.mat")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test58;
*/

  model Test59 "ASCII Text file"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a",
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test.txt")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test59;

  model Test60 "ASCII Text file (TAB separated)"
    extends Modelica.Icons.Example;
    extends Test0(t_new(
        tableOnFile=true,
        tableName="a_tab",
        fileName=loadResource("modelica://ModelicaTest/Resources/Data/Tables/test.txt")));
    annotation (experiment(StartTime=0, StopTime=100));
  end Test60;

  model Test61 "Periodic, startTime = 0, t_min > 0, constant segments"
    extends Modelica.Icons.Example;
    extends Test0_noDer(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test61;

  model Test62 "Periodic, startTime > 0, t_min > 0, constant segments"
    extends Modelica.Icons.Example;
    extends Test0_noDer(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test62;

  model Test63 "Periodic, startTime > t_min > 0, constant segments"
    extends Modelica.Icons.Example;
    extends Test0_noDer(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=0.7));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test63;

  model Test64 "Periodic, startTime > t_max, t_min > 0, constant segments"
    extends Modelica.Icons.Example;
    extends Test0_noDer(t_new(
        table={{0.6,-2},{0.6,-20},{0.6,-3},{0.7,-2},{0.7,0},{0.7,-2},{1,-5},{1,
            -6},{1,-4}},
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        startTime=1.5));
    annotation (experiment(StartTime=0, StopTime=2.5));
  end Test64;

  model Test65 "Two columns, constant segments"
    extends Modelica.Icons.Example;
    extends Test0_noDer(t_new(table=[0.3, 0; 0.4, 1; 0.5, 0; 0.6, -1; 0.7, 0],
          smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments));
    annotation (experiment(StartTime=0, StopTime=1));
  end Test65;

  model Test66_usertab "Test utilizing the usertab.c interface"
    extends Modelica.Icons.Example;
    extends Test0(t_new(tableOnFile=true, tableName="TestTable_1D_Time"));
  protected
    encapsulated function getUsertab
      import Modelica;
      extends Modelica.Icons.Function;
      input Real dummy_u[:];
      output Real dummy_y;
      external "C" dummy_y = mydummyfunc(dummy_u);
      annotation(IncludeDirectory="modelica://Modelica/Resources/Data/Tables",
             Include = "#include \"usertab.c\"
 double mydummyfunc(const double* dummy_in) {
        return 0;
}
");
    end getUsertab;
  public
    Modelica.Blocks.Sources.RealExpression realExpression(y=getUsertab(t_new.y))
      annotation (Placement(transformation(extent={{-20,-40},{10,-20}})));
    annotation (experiment(StartTime=0, StopTime=4));
  end Test66_usertab;
end CombiTimeTable;
