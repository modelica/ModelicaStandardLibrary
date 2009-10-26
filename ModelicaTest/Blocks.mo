within ModelicaTest;
package Blocks "Test models for Modelica.Blocks"
  model Continuous

    Modelica.Blocks.Continuous.Integrator integrator 
      annotation (Placement(transformation(extent={{-60,60},{-40,80}}, rotation=
             0)));
    Modelica.Blocks.Continuous.LimIntegrator limIntegrator 
      annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=
             0)));
    annotation (                                       Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-200},{100,100}}),
          graphics),
      experiment(StopTime=1.1));
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
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics),
      experiment(StopTime=1.1));
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
  end Limiters;

  model KinematicPTP

    Modelica.Blocks.Sources.KinematicPTP kinematicPTP1a(
      qd_max={3},
      qdd_max={4},
      startTime=0.5,
      deltaq={1}) annotation (Placement(transformation(extent={{-60,60},{-40,80}},
            rotation=0)));
    Modelica.Blocks.Continuous.Integrator integrator 
      annotation (Placement(transformation(extent={{-20,60},{2,80}}, rotation=0)));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
      experiment(StopTime=3));
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
  end KinematicPTP;
end Blocks;
