within ModelicaTest;
package Blocks "Test models for Modelica.Blocks"
extends Modelica.Icons.ExamplesPackage;
  model Continuous
    extends Modelica.Icons.Example;
    Modelica.Blocks.Continuous.Integrator integrator
      annotation (Placement(transformation(extent={{-60,60},{-40,80}}, rotation=
             0)));
    Modelica.Blocks.Continuous.LimIntegrator limIntegrator
      annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=
             0)));
    Modelica.Blocks.Continuous.Derivative derivative
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}}, rotation=
             0)));
    Modelica.Blocks.Continuous.FirstOrder firstOrder
      annotation (Placement(transformation(extent={{-60,-60},{-40,-40}},
            rotation=0)));
    Modelica.Blocks.Continuous.SecondOrder secondOrder
      annotation (Placement(transformation(extent={{-60,-100},{-40,-80}},
            rotation=0)));
    Modelica.Blocks.Continuous.PI pI annotation (Placement(transformation(
            extent={{-60,-140},{-40,-120}}, rotation=0)));
    Modelica.Blocks.Continuous.PID pID annotation (Placement(transformation(
            extent={{-60,-180},{-40,-160}}, rotation=0)));
    Modelica.Blocks.Continuous.LimPID limPID annotation (Placement(
          transformation(extent={{40,60},{60,80}}, rotation=0)));
    Modelica.Blocks.Continuous.TransferFunction transferFunction(a={1,1}, b={1})
      annotation (Placement(transformation(extent={{40,-20},{60,0}}, rotation=0)));
    Modelica.Blocks.Continuous.StateSpace stateSpace(
      A=[1,0; 0,1],
      B=[1; 1],
      C=[1,1])
      annotation (Placement(transformation(extent={{40,-60},{60,-40}}, rotation=
             0)));
    Modelica.Blocks.Continuous.LowpassButterworth lowpassButterworth
      annotation (Placement(transformation(extent={{40,-100},{60,-80}},
            rotation=0)));
    Modelica.Blocks.Continuous.CriticalDamping criticalDamping(normalized=false)
      annotation (Placement(transformation(extent={{40,-140},{60,-120}},
            rotation=0)));
    Modelica.Blocks.Sources.Ramp ramp(offset=0.5, startTime=0.5)
      annotation (Placement(transformation(extent={{-100,60},{-80,80}},
            rotation=0)));
    Modelica.Blocks.Sources.Ramp ramp1(offset=0.5, startTime=0.5)
      annotation (Placement(transformation(extent={{0,60},{20,80}}, rotation=0)));
    Modelica.Blocks.Sources.Constant const(k=1.5)
      annotation (Placement(transformation(
          origin={50,30},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Blocks.Continuous.Der der1 annotation (Placement(transformation(
            extent={{40,-180},{60,-160}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine annotation (Placement(transformation(
            extent={{0,-180},{20,-160}}, rotation=0)));
  equation
    connect(ramp.y, integrator.u) annotation (Line(points={{-79,70},{-62,70}},
          color={0,0,127}));
    connect(ramp.y, limIntegrator.u) annotation (Line(points={{-79,70},{-72,70},
            {-72,30},{-62,30}}, color={0,0,127}));
    connect(ramp.y, derivative.u) annotation (Line(points={{-79,70},{-72,70},{
            -72,-10},{-62,-10}}, color={0,0,127}));
    connect(ramp.y, firstOrder.u) annotation (Line(points={{-79,70},{-72,70},{
            -72,-50},{-62,-50}}, color={0,0,127}));
    connect(ramp.y, secondOrder.u) annotation (Line(points={{-79,70},{-72,70},{
            -72,-90},{-62,-90}}, color={0,0,127}));
    connect(ramp.y, pI.u) annotation (Line(points={{-79,70},{-72,70},{-72,-130},
            {-62,-130}}, color={0,0,127}));
    connect(ramp.y, pID.u) annotation (Line(points={{-79,70},{-72,70},{-72,-170},
            {-62,-170}}, color={0,0,127}));
    connect(ramp1.y, limPID.u_s)
      annotation (Line(points={{21,70},{38,70}}, color={0,0,127}));
    connect(ramp1.y, transferFunction.u) annotation (Line(points={{21,70},{28,
            70},{28,-10},{38,-10}}, color={0,0,127}));
    connect(ramp1.y, stateSpace.u[1]) annotation (Line(points={{21,70},{28,70},
            {28,-50},{38,-50}}, color={0,0,127}));
    connect(ramp1.y, lowpassButterworth.u) annotation (Line(points={{21,70},{28,
            70},{28,-90},{38,-90}}, color={0,0,127}));
    connect(ramp1.y, criticalDamping.u) annotation (Line(points={{21,70},{28,70},
            {28,-130},{38,-130}}, color={0,0,127}));
    connect(const.y, limPID.u_m)
      annotation (Line(points={{50,41},{50,58}}, color={0,0,127}));
    connect(sine.y, der1.u) annotation (Line(
        points={{21,-170},{38,-170}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (                                       Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-200},{100,100}}),
          graphics),
      experiment(StopTime=1.1));
  end Continuous;

  model Continuous_SteadyState
    extends ModelicaTest.Blocks.Continuous(
      derivative(initType=Modelica.Blocks.Types.Init.SteadyState),
      firstOrder(initType=Modelica.Blocks.Types.Init.SteadyState),
      secondOrder(initType=Modelica.Blocks.Types.Init.SteadyState),
      transferFunction(initType=Modelica.Blocks.Types.Init.SteadyState,
        a={1,1},
        b={1}),
      stateSpace(initType=Modelica.Blocks.Types.Init.SteadyState,
        A=[1,0; 0,1],
        B=[1; 1],
        C=[1,1]),
      lowpassButterworth(initType=Modelica.Blocks.Types.Init.SteadyState),
      criticalDamping(initType=Modelica.Blocks.Types.Init.SteadyState,
          normalized=false));
    annotation (experiment(StopTime=1.1));
  end Continuous_SteadyState;

  model Continuous_InitialState
    extends ModelicaTest.Blocks.Continuous(
      integrator(initType=Modelica.Blocks.Types.Init.InitialState),
      limIntegrator(initType=Modelica.Blocks.Types.Init.InitialState),
      derivative(initType=Modelica.Blocks.Types.Init.InitialState),
      firstOrder(initType=Modelica.Blocks.Types.Init.InitialState),
      secondOrder(initType=Modelica.Blocks.Types.Init.InitialState),
      pI(initType=Modelica.Blocks.Types.Init.InitialState),
      pID(initType=Modelica.Blocks.Types.Init.InitialState),
      limPID(initType=Modelica.Blocks.Types.Init.InitialState),
      transferFunction(initType=Modelica.Blocks.Types.Init.InitialState,
        a={1,1},
        b={1}),
      stateSpace(initType=Modelica.Blocks.Types.Init.InitialState,
        A=[1,0; 0,1],
        B=[1; 1],
        C=[1,1]),
      lowpassButterworth(initType=Modelica.Blocks.Types.Init.InitialState),
      criticalDamping(initType=Modelica.Blocks.Types.Init.InitialState,
          normalized=false));
    annotation (experiment(StopTime=1.1));
  end Continuous_InitialState;

  model Continuous_InitialOutput
    extends ModelicaTest.Blocks.Continuous(
      integrator(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=2),
      limIntegrator(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=
            0.5),
      derivative(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=2),
      firstOrder(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=2),
      secondOrder(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=2),
      pI(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=2),
      pID(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=2),
      limPID(initType=Modelica.Blocks.Types.Init.InitialOutput,
        yMax=3,
        y_start=2),
      transferFunction(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=
            2,
        a={1,1},
        b={1}),
      stateSpace(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start={2},
        A=[1,0; 0,1],
        B=[1; 1],
        C=[1,1]),
      lowpassButterworth(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=
            2),
      criticalDamping(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=
            2,
        normalized=false));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-200},{100,100}}), graphics),
      experiment(StopTime=1.1));
  end Continuous_InitialOutput;

  model Limiters
    extends Modelica.Icons.Example;
    Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit=false)
      annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=0)));
    Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter(limitsAtInit=
          false) annotation (Placement(transformation(extent={{-20,0},{0,20}},
            rotation=0)));
    Modelica.Blocks.Nonlinear.DeadZone deadZone(deadZoneAtInit=false)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine(amplitude=2)
      annotation (Placement(transformation(extent={{-60,40},{-40,60}}, rotation=
             0)));
    Modelica.Blocks.Sources.Constant const annotation (Placement(transformation(
            extent={{-80,16},{-60,36}}, rotation=0)));
    Modelica.Blocks.Sources.Constant const1(k=-1)
      annotation (Placement(transformation(extent={{-80,-26},{-60,-6}},
            rotation=0)));
  equation
    connect(sine.y, limiter.u) annotation (Line(points={{-39,50},{-22,50}},
          color={0,0,127}));
    connect(const.y, variableLimiter.limit1) annotation (Line(points={{-59,26},
            {-42,26},{-42,18},{-22,18}}, color={0,0,127}));
    connect(const1.y, variableLimiter.limit2) annotation (Line(points={{-59,-16},
            {-40,-16},{-40,2},{-22,2}}, color={0,0,127}));
    connect(sine.y, variableLimiter.u) annotation (Line(points={{-39,50},{-32,
            50},{-32,10},{-22,10}}, color={0,0,127}));
    connect(sine.y, deadZone.u) annotation (Line(points={{-39,50},{-32,50},{-32,
            -30},{-22,-30}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics),
      experiment(StopTime=1.1));
  end Limiters;

  model KinematicPTP
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.KinematicPTP kinematicPTP1a(
      qd_max={3},
      qdd_max={4},
      startTime=0.5,
      deltaq={1}) annotation (Placement(transformation(extent={{-60,60},{-40,80}},
            rotation=0)));
    Modelica.Blocks.Continuous.Integrator integrator
      annotation (Placement(transformation(extent={{-20,60},{2,80}}, rotation=0)));
    Modelica.Blocks.Continuous.Integrator integrator1(y_start=1)
      annotation (Placement(transformation(extent={{20,60},{42,80}}, rotation=0)));
    Modelica.Blocks.Sources.KinematicPTP kinematicPTP2a(
      qd_max={3},
      qdd_max={4},
      startTime=0.5,
      deltaq={4}) annotation (Placement(transformation(extent={{-60,-20},{-40,0}},
            rotation=0)));
    Modelica.Blocks.Continuous.Integrator integrator2
      annotation (Placement(transformation(extent={{-20,-20},{2,0}}, rotation=0)));
    Modelica.Blocks.Continuous.Integrator integrator3(y_start=1)
      annotation (Placement(transformation(extent={{20,-20},{42,0}}, rotation=0)));
  equation
    connect(kinematicPTP1a.y[1], integrator.u) annotation (Line(points={{-39,70},
            {-22.2,70}}, color={0,0,127}));
    connect(integrator.y, integrator1.u) annotation (Line(points={{3.1,70},{
            17.8,70}}, color={0,0,127}));
    connect(kinematicPTP2a.y[1], integrator2.u) annotation (Line(points={{-39,
            -10},{-22.2,-10}}, color={0,0,127}));
    connect(integrator2.y, integrator3.u) annotation (Line(points={{3.1,-10},{
            17.8,-10}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
      experiment(StopTime=3));
  end KinematicPTP;

  model UnitDeduction "Test unit deduction"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Continuous.Integrator integrator
      annotation (Placement(transformation(extent={{0,30},{20,50}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1, w(start=1))
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
      annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
    Modelica.Blocks.Math.Gain gain(k=2)
      annotation (Placement(transformation(extent={{0,80},{20,100}})));
    Modelica.Blocks.Continuous.LimIntegrator limIntegrator(outMax=3)
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Blocks.Continuous.Derivative derivative
      annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=2)
      annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder(w=2, D=3)
      annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
    Modelica.Blocks.Continuous.PI PI(T=2)
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
    Modelica.Blocks.Continuous.PID PID(Ti=2, Td=3)
      annotation (Placement(transformation(extent={{60,30},{80,50}})));
    Modelica.Blocks.Continuous.LimPID PID1(
      Ti=2,
      Td=3,
      yMax=4) annotation (Placement(transformation(extent={{60,0},{80,20}})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=10, freqHz=2)
                                                               annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={120,-20})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=100)
                                                       annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={168,-20})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{110,-70},{130,-50}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={190,-20})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
      annotation (Placement(transformation(extent={{138,10},{158,-10}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{225,15},{235,25}})));
    Modelica.Blocks.Continuous.Integrator Wsec(k(unit="1"))
      annotation (Placement(transformation(extent={{249,15},{259,25}})));
    Modelica.Blocks.Continuous.Integrator Vsec(k(unit="1"))
      annotation (Placement(transformation(extent={{246,-26},{258,-14}})));
    Modelica.Blocks.Continuous.Integrator Asec(k(unit="1"))
      annotation (Placement(transformation(extent={{183.5,43.5},{196.5,56.5}})));
  equation
    connect(inertia.flange_b, speedSensor.flange) annotation (Line(
        points={{-60,70},{-50,70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(speedSensor.w, integrator.u) annotation (Line(
        points={{-29,70},{-16,70},{-16,40},{-2,40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.w, gain.u) annotation (Line(
        points={{-29,70},{-16,70},{-16,90},{-2,90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.w, limIntegrator.u) annotation (Line(
        points={{-29,70},{-16,70},{-16,10},{-2,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(derivative.u, speedSensor.w) annotation (Line(
        points={{-2,-20},{-16,-20},{-16,70},{-29,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(firstOrder.u, speedSensor.w) annotation (Line(
        points={{-2,-50},{-16,-50},{-16,70},{-29,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(secondOrder.u, speedSensor.w) annotation (Line(
        points={{-2,-80},{-16,-80},{-16,70},{-29,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.w, PI.u) annotation (Line(
        points={{-29,70},{58,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.w, PID.u) annotation (Line(
        points={{-29,70},{40,70},{40,40},{58,40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.w, PID1.u_s) annotation (Line(
        points={{-29,70},{40,70},{40,10},{58,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.y, PID1.u_m) annotation (Line(
        points={{21,90},{94,90},{94,-8},{70,-8},{70,-2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sineVoltage.n,ground. p) annotation (Line(
        points={{120,-30},{120,-50}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(sineVoltage.p,currentSensor. p) annotation (Line(
        points={{120,-10},{120,0},{138,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(voltageSensor.p,resistor. p) annotation (Line(
        points={{190,-10},{190,0},{168,0},{168,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(resistor.p,currentSensor. n) annotation (Line(
        points={{168,-10},{168,0},{158,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(voltageSensor.n,resistor. n) annotation (Line(
        points={{190,-30},{190,-40},{168,-40},{168,-30}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(resistor.n,sineVoltage. n) annotation (Line(
        points={{168,-30},{168,-40},{120,-40},{120,-30}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(currentSensor.i,product. u1) annotation (Line(
        points={{148,10},{172,10},{172,23},{224,23}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(voltageSensor.v,product. u2) annotation (Line(
        points={{200,-20},{210.5,-20},{210.5,17},{224,17}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(currentSensor.i,Asec. u) annotation (Line(
        points={{148,10},{172,10},{172,50},{182.2,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(product.y,Wsec. u) annotation (Line(
        points={{235.5,20},{248,20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Vsec.u,voltageSensor. v) annotation (Line(
        points={{244.8,-20},{222.4,-20},{222.4,-20},{200,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{
              -100,-100},{300,100}}),
                        graphics), Icon(coordinateSystem(preserveAspectRatio=true,
                    extent={{-100,-100},{100,100}})));
  end UnitDeduction;

  model IntegerTable
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.IntegerTable integerTable(table=[0,1; 1,4; 1.5,5; 2,
          6]) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Modelica.Blocks.Sources.IntegerTable integerTable2(table=[0,-1])
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.IntegerTable integerTable3(table=[2,-2])
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
    Modelica.Blocks.Sources.IntegerTable integerTable4(table=[0,1; 1,4; 1.5,5;
          2,6; 4,7])
      annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    annotation (experiment(StopTime=3), experimentSetupOutput);
  end IntegerTable;

  package FilterTests "Test of Blocks.Continuous.Filter"
    extends Modelica.Icons.ExamplesPackage;
    model AllOptions
      "Simulates 264 filter blocks and varies all possible options systematically for different orders and different cut-off frequencies"
      extends Modelica.Icons.Example;
      DifferentInitialization normalized(normalized=true)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      DifferentInitialization notNormalized(normalized=false)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Basic basicWithGain(gain=1.4)
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      annotation (experiment(StopTime=1.1), experimentSetupOutput);
    end AllOptions;

  model Basic
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer order1 = 3;
    parameter Integer order2 = 6;
    parameter Modelica.SIunits.Frequency f_cut1 = 3;
    parameter Modelica.SIunits.Frequency f_cut2 = 5;
    parameter Boolean normalized = true;
    parameter Modelica.Blocks.Types.FilterType filterType=Modelica.Blocks.Types.FilterType.LowPass
        "Type of filter (LowPass/HighPass)";
    parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.SteadyState
        "Type of initialization (no init/steady state/initial state/initial output)";

    Modelica.Blocks.Sources.Step step(startTime=0.1, offset=0.1)
      annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Modelica.Blocks.Continuous.Filter CriticalDamping_a(
      analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
      normalized=normalized,
      order=order1,
      f_cut=f_cut1,
      init=init,
      filterType=filterType,
      f_min=0.8*f_cut1,
      gain=gain)
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Modelica.Blocks.Continuous.Filter CriticalDamping_b(
      analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
      normalized=normalized,
      order=order2,
      f_cut=f_cut2,
      init=init,
      filterType=filterType,
      f_min=0.8*f_cut2,
      gain=gain)
        annotation (Placement(transformation(extent={{40,40},{60,60}})));
      Modelica.Blocks.Continuous.Filter Bessel_a(
      normalized=normalized,
      order=order1,
      f_cut=f_cut1,
      analogFilter=Modelica.Blocks.Types.AnalogFilter.Bessel,
      init=init,
      filterType=filterType,
        f_min=0.8*f_cut1,
        gain=gain)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Modelica.Blocks.Continuous.Filter Bessel_b(
      normalized=normalized,
      order=order2,
      f_cut=f_cut2,
      analogFilter=Modelica.Blocks.Types.AnalogFilter.Bessel,
      init=init,
      filterType=filterType,
        f_min=0.8*f_cut2,
        gain=gain)
        annotation (Placement(transformation(extent={{40,0},{60,20}})));
      Modelica.Blocks.Continuous.Filter Butterworth_a(
      normalized=normalized,
      order=order1,
      f_cut=f_cut1,
      analogFilter=Modelica.Blocks.Types.AnalogFilter.Butterworth,
      init=init,
      filterType=filterType,
      f_min=0.8*f_cut1,
      gain=gain)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Modelica.Blocks.Continuous.Filter Butterworth_b(
      normalized=normalized,
      order=order2,
      f_cut=f_cut2,
      analogFilter=Modelica.Blocks.Types.AnalogFilter.Butterworth,
      init=init,
      filterType=filterType,
      f_min=0.8*f_cut2,
      gain=gain)
        annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
      Modelica.Blocks.Continuous.Filter ChebyshevI_a(
      normalized=normalized,
      order=order1,
      f_cut=f_cut1,
      analogFilter=Modelica.Blocks.Types.AnalogFilter.ChebyshevI,
      init=init,
      filterType=filterType,
      f_min=0.8*f_cut1,
      gain=gain)
        annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      Modelica.Blocks.Continuous.Filter ChebyshevI_b(
      normalized=normalized,
      order=order2,
      f_cut=f_cut2,
      analogFilter=Modelica.Blocks.Types.AnalogFilter.ChebyshevI,
      init=init,
      filterType=filterType,
      f_min=0.8*f_cut2,
      gain=gain)
        annotation (Placement(transformation(extent={{40,-80},{60,-60}})));

      parameter Real gain=1.0
        "Gain (= amplitude of frequency response at zero frequency)";
  equation
    connect(step.y, CriticalDamping_a.u)
                                 annotation (Line(
          points={{-39,50},{-22,50}},
          color={0,0,127},
          smooth=Smooth.None));
    connect(step.y, CriticalDamping_b.u)
                                annotation (Line(
        points={{-39,50},{-32,50},{-32,70},{20,70},{20,50},{38,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step.y,Bessel_a. u) annotation (Line(
        points={{-39,50},{-32,50},{-32,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step.y,Bessel_b. u) annotation (Line(
        points={{-39,50},{-32,50},{-32,70},{20,70},{20,10},{38,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Butterworth_a.u, step.y)
                                annotation (Line(
        points={{-22,-30},{-32,-30},{-32,50},{-39,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step.y, Butterworth_b.u)
                                annotation (Line(
        points={{-39,50},{-32,50},{-32,70},{20,70},{20,-30},{38,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ChebyshevI_a.u, step.y)
                                 annotation (Line(
        points={{-22,-70},{-32,-70},{-32,50},{-39,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step.y, ChebyshevI_b.u)
                                 annotation (Line(
        points={{-39,50},{-32,50},{-32,70},{20,70},{20,-70},{38,-70}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(graphics),
        experiment(StopTime=0.9),
        experimentSetupOutput,
      Icon(graphics={Text(
              extent={{-82,54},{86,22}},
              lineColor={0,0,0},
              textString="basic"), Text(
              extent={{-84,2},{84,-30}},
              lineColor={0,0,0},
              textString="filters")}));
  end Basic;

    block DifferentFilterTypes
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Basic lowPass(filterType=Modelica.Blocks.Types.FilterType.LowPass,
        normalized=normalized,
        init=init)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Basic highPass(filterType=Modelica.Blocks.Types.FilterType.HighPass,
        normalized=normalized,
        init=init)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Basic bandPass(
        filterType=Modelica.Blocks.Types.FilterType.BandPass,
        normalized=normalized,
        init=init,
        order1=4,
        order2=10)
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      Basic bandStop(
        filterType=Modelica.Blocks.Types.FilterType.BandStop,
        normalized=normalized,
        init=init,
        order1=4,
        order2=10)
        annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
      parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.SteadyState
        "Type of initialization (no init/steady state/initial state/initial output)";
      parameter Boolean normalized=true;
    end DifferentFilterTypes;

    block DifferentInitialization
      extends Modelica.Blocks.Interfaces.BlockIcon;
      DifferentFilterTypes steadyState(init=Modelica.Blocks.Types.Init.SteadyState,
          normalized=normalized)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      DifferentFilterTypes initialState(init=Modelica.Blocks.Types.Init.InitialState,
          normalized=normalized)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      DifferentFilterTypes initialOutput(init=Modelica.Blocks.Types.Init.InitialOutput,
          normalized=normalized)
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      DifferentFilterTypes noInit(init=Modelica.Blocks.Types.Init.InitialOutput,
          normalized=normalized)
        annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
      parameter Boolean normalized=true;
    equation

    end DifferentInitialization;
  end FilterTests;
end Blocks;
