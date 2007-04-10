package Blocks "Test models for Modelica.Blocks" 
  model AllBlocks 
    
    Modelica.Blocks.Continuous.Integrator integrator 
      annotation (extent=[-60,60; -40,80]);
    Modelica.Blocks.Continuous.LimIntegrator limIntegrator 
      annotation (extent=[-60,20; -40,40]);
    annotation (Coordsys(extent=[-100,-200; 100,100]), Diagram, 
      experiment(StopTime=1.1), 
      experimentSetupOutput);
    Modelica.Blocks.Continuous.Derivative derivative 
      annotation (extent=[-60,-20; -40,0]);
    Modelica.Blocks.Continuous.FirstOrder firstOrder 
      annotation (extent=[-60,-60; -40,-40]);
    Modelica.Blocks.Continuous.SecondOrder secondOrder 
      annotation (extent=[-60,-100; -40,-80]);
    Modelica.Blocks.Continuous.PI pI annotation (extent=[-60,-140; -40,-120]);
    Modelica.Blocks.Continuous.PID pID annotation (extent=[-60,-180; -40,-160]);
    Modelica.Blocks.Continuous.LimPID limPID annotation (extent=[40,60; 60,80]);
    Modelica.Blocks.Continuous.TransferFunction transferFunction 
      annotation (extent=[40,-20; 60,0]);
    Modelica.Blocks.Continuous.StateSpace stateSpace 
      annotation (extent=[40,-60; 60,-40]);
    Modelica.Blocks.Continuous.LowpassButterworth lowpassButterworth 
      annotation (extent=[40,-100; 60,-80]);
    Modelica.Blocks.Continuous.CriticalDamping criticalDamping 
      annotation (extent=[40,-140; 60,-120]);
    Modelica.Blocks.Sources.Ramp ramp(offset=0.5, startTime=0.5) 
      annotation (extent=[-100,60; -80,80]);
    Modelica.Blocks.Sources.Ramp ramp1(offset=0.5, startTime=0.5) 
      annotation (extent=[0,60; 20,80]);
    Modelica.Blocks.Sources.Constant const(k=1.5) 
      annotation (extent=[40,20; 60,40], rotation=90);
  equation 
    connect(ramp.y, integrator.u) annotation (points=[-79,70; -62,70], style(
          color=74, rgbcolor={0,0,127}));
    connect(ramp.y, limIntegrator.u) annotation (points=[-79,70; -72,70; -72,30;
          -62,30], style(color=74, rgbcolor={0,0,127}));
    connect(ramp.y, derivative.u) annotation (points=[-79,70; -72,70; -72,-10;
          -62,-10], style(color=74, rgbcolor={0,0,127}));
    connect(ramp.y, firstOrder.u) annotation (points=[-79,70; -72,70; -72,-50;
          -62,-50], style(color=74, rgbcolor={0,0,127}));
    connect(ramp.y, secondOrder.u) annotation (points=[-79,70; -72,70; -72,-90;
          -62,-90], style(color=74, rgbcolor={0,0,127}));
    connect(ramp.y, pI.u) annotation (points=[-79,70; -72,70; -72,-130; -62,
          -130], style(color=74, rgbcolor={0,0,127}));
    connect(ramp.y, pID.u) annotation (points=[-79,70; -72,70; -72,-170; -62,
          -170], style(color=74, rgbcolor={0,0,127}));
    connect(ramp1.y, limPID.u_s) 
      annotation (points=[21,70; 38,70], style(color=74, rgbcolor={0,0,127}));
    connect(ramp1.y, transferFunction.u) annotation (points=[21,70; 28,70; 28,
          -10; 38,-10], style(color=74, rgbcolor={0,0,127}));
    connect(ramp1.y, stateSpace.u[1]) annotation (points=[21,70; 28,70; 28,-50;
          38,-50], style(color=74, rgbcolor={0,0,127}));
    connect(ramp1.y, lowpassButterworth.u) annotation (points=[21,70; 28,70; 28,
          -90; 38,-90], style(color=74, rgbcolor={0,0,127}));
    connect(ramp1.y, criticalDamping.u) annotation (points=[21,70; 28,70; 28,
          -130; 38,-130], style(color=74, rgbcolor={0,0,127}));
    connect(const.y, limPID.u_m) 
      annotation (points=[50,41; 50,58], style(color=74, rgbcolor={0,0,127}));
  end AllBlocks;
  
  model AllBlocks_SteadyState 
    extends AllBlocks(
      derivative(initType=Modelica.Blocks.Types.Init.SteadyState),
      firstOrder(initType=Modelica.Blocks.Types.Init.SteadyState),
      secondOrder(initType=Modelica.Blocks.Types.Init.SteadyState),
      transferFunction(initType=Modelica.Blocks.Types.Init.SteadyState),
      stateSpace(initType=Modelica.Blocks.Types.Init.SteadyState),
      lowpassButterworth(initType=Modelica.Blocks.Types.Init.SteadyState),
      criticalDamping(initType=Modelica.Blocks.Types.Init.SteadyState));
    annotation (experiment(StopTime=1.1), experimentSetupOutput);
  end AllBlocks_SteadyState;
  
  model AllBlocks_InitialState 
    extends AllBlocks(
      integrator(initType=Modelica.Blocks.Types.Init.InitialState),
      limIntegrator(initType=Modelica.Blocks.Types.Init.InitialState),
      derivative(initType=Modelica.Blocks.Types.Init.InitialState),
      firstOrder(initType=Modelica.Blocks.Types.Init.InitialState),
      secondOrder(initType=Modelica.Blocks.Types.Init.InitialState),
      pI(initType=Modelica.Blocks.Types.Init.InitialState),
      pID(initType=Modelica.Blocks.Types.Init.InitialState),
      limPID(initType=Modelica.Blocks.Types.Init.InitialState),
      transferFunction(initType=Modelica.Blocks.Types.Init.InitialState),
      stateSpace(initType=Modelica.Blocks.Types.Init.InitialState),
      lowpassButterworth(initType=Modelica.Blocks.Types.Init.InitialState),
      criticalDamping(initType=Modelica.Blocks.Types.Init.InitialState));
    annotation (experiment(StopTime=1.1), experimentSetupOutput);
  end AllBlocks_InitialState;
  
  model AllBlocks_InitialOutput 
    extends AllBlocks(
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
            2),
      stateSpace(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start={2}),
      lowpassButterworth(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=
            2),
      criticalDamping(initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=
            2));
    annotation (Diagram, 
      experiment(StopTime=1.1), 
      experimentSetupOutput);
  end AllBlocks_InitialOutput;
  
  model TestLimiter 
    
    Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit=false) 
      annotation (extent=[-20,40; 0,60]);
    Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter(limitsAtInit=
          false) annotation (extent=[-20,0; 0,20]);
    Modelica.Blocks.Nonlinear.DeadZone deadZone(deadZoneAtInit=false) 
      annotation (extent=[-20,-40; 0,-20]);
    Modelica.Blocks.Sources.Sine sine(amplitude=2) 
      annotation (extent=[-60,40; -40,60]);
    annotation (Diagram, 
      experiment(StopTime=1.1), 
      experimentSetupOutput);
    Modelica.Blocks.Sources.Constant const annotation (extent=[-80,16; -60,36]);
    Modelica.Blocks.Sources.Constant const1(k=-1) 
      annotation (extent=[-80,-26; -60,-6]);
  equation 
    connect(sine.y, limiter.u) annotation (points=[-39,50; -22,50], style(color=
           74, rgbcolor={0,0,127}));
    connect(const.y, variableLimiter.limit1) annotation (points=[-59,26; -42,26;
          -42,18; -22,18], style(color=74, rgbcolor={0,0,127}));
    connect(const1.y, variableLimiter.limit2) annotation (points=[-59,-16; -40,
          -16; -40,2; -22,2], style(color=74, rgbcolor={0,0,127}));
    connect(sine.y, variableLimiter.u) annotation (points=[-39,50; -32,50; -32,
          10; -22,10], style(color=74, rgbcolor={0,0,127}));
    connect(sine.y, deadZone.u) annotation (points=[-39,50; -32,50; -32,-30;
          -22,-30], style(color=74, rgbcolor={0,0,127}));
  end TestLimiter;
  
  model UnitConversions 
    
    Modelica.Blocks.Math.UnitConversions.ConvertAllUnits convert(redeclare 
        block ConversionBlock = Modelica.Blocks.Math.UnitConversions.From_gps) 
      annotation (extent=[-100,120; -80,140]);
    Modelica.Blocks.Math.UnitConversions.To_degC to_degC 
      annotation (extent=[-100,80; -80,100]);
    Modelica.Blocks.Math.UnitConversions.From_degC from_degC 
      annotation (extent=[-60,80; -40,100]);
    Modelica.Blocks.Math.UnitConversions.To_degF to_degF 
      annotation (extent=[-100,40; -80,60]);
    Modelica.Blocks.Math.UnitConversions.From_degF from_degF 
      annotation (extent=[-60,40; -40,60]);
    annotation (Coordsys(
        grid=[2,2],
        scale=0.01,
        extent=[-160,-160; 160,160]), Diagram, 
      experiment(StopTime=1.1), 
      experimentSetupOutput);
    Modelica.Blocks.Math.UnitConversions.To_degRk to_degRk 
      annotation (extent=[-100,0; -80,20]);
    Modelica.Blocks.Math.UnitConversions.From_degRk from_degRk 
      annotation (extent=[-60,0; -40,20]);
    Modelica.Blocks.Math.UnitConversions.To_deg to_deg 
      annotation (extent=[-100,-40; -80,-20]);
    Modelica.Blocks.Math.UnitConversions.From_deg from_deg 
      annotation (extent=[-60,-40; -40,-20]);
    Modelica.Blocks.Math.UnitConversions.To_rpm to_rpm 
      annotation (extent=[-100,-80; -80,-60]);
    Modelica.Blocks.Math.UnitConversions.From_rpm from_rpm 
      annotation (extent=[-60,-80; -40,-60]);
    Modelica.Blocks.Math.UnitConversions.To_kmh to_kmh 
      annotation (extent=[-100,-120; -80,-100]);
    Modelica.Blocks.Math.UnitConversions.From_kmh from_kmh 
      annotation (extent=[-60,-120; -40,-100]);
    Modelica.Blocks.Math.UnitConversions.To_day to_day 
      annotation (extent=[80,120; 100,140]);
    Modelica.Blocks.Math.UnitConversions.From_day from_day 
      annotation (extent=[120,120; 140,140]);
    Modelica.Blocks.Math.UnitConversions.To_hour to_hour 
      annotation (extent=[80,80; 100,100]);
    Modelica.Blocks.Math.UnitConversions.From_hour from_hour 
      annotation (extent=[120,80; 140,100]);
    Modelica.Blocks.Math.UnitConversions.To_minute to_minute 
      annotation (extent=[80,40; 100,60]);
    Modelica.Blocks.Math.UnitConversions.From_minute from_minute 
      annotation (extent=[120,40; 140,60]);
    Modelica.Blocks.Math.UnitConversions.To_litre to_litre 
      annotation (extent=[80,0; 100,20]);
    Modelica.Blocks.Math.UnitConversions.From_litre from_litre 
      annotation (extent=[120,0; 140,20]);
    Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh 
      annotation (extent=[80,-40; 100,-20]);
    Modelica.Blocks.Math.UnitConversions.From_kWh from_kWh 
      annotation (extent=[120,-40; 140,-20]);
    Modelica.Blocks.Math.UnitConversions.To_bar to_bar 
      annotation (extent=[80,-80; 100,-60]);
    Modelica.Blocks.Math.UnitConversions.From_bar from_bar 
      annotation (extent=[120,-80; 140,-60]);
    Modelica.Blocks.Math.UnitConversions.To_gps to_gps 
      annotation (extent=[80,-120; 100,-100]);
    Modelica.Blocks.Math.UnitConversions.From_gps from_gps 
      annotation (extent=[120,-120; 140,-100]);
    Modelica.Blocks.Sources.Sine sine annotation (extent=[-140,120; -120,140]);
    Modelica.Blocks.Sources.Sine sine1 annotation (extent=[-140,80; -120,100]);
    Modelica.Blocks.Sources.Sine sine2 annotation (extent=[-140,40; -120,60]);
    Modelica.Blocks.Sources.Sine sine3 annotation (extent=[-140,0; -120,20]);
    Modelica.Blocks.Sources.Sine sine4 annotation (extent=[-140,-40; -120,-20]);
    Modelica.Blocks.Sources.Sine sine5 annotation (extent=[-140,-80; -120,-60]);
    Modelica.Blocks.Sources.Sine sine6 
      annotation (extent=[-140,-120; -120,-100]);
    Modelica.Blocks.Sources.Sine sine7 annotation (extent=[40,120; 60,140]);
    Modelica.Blocks.Sources.Sine sine8 annotation (extent=[40,80; 60,100]);
    Modelica.Blocks.Sources.Sine sine9 annotation (extent=[40,40; 60,60]);
    Modelica.Blocks.Sources.Sine sine10 annotation (extent=[40,0; 60,20]);
    Modelica.Blocks.Sources.Sine sine11 annotation (extent=[40,-40; 60,-20]);
    Modelica.Blocks.Sources.Sine sine12 annotation (extent=[40,-80; 60,-60]);
    Modelica.Blocks.Sources.Sine sine13 annotation (extent=[40,-120; 60,-100]);
  equation 
    connect(to_degC.y, from_degC.u) 
      annotation (points=[-79,90; -62,90],style(color=74, rgbcolor={0,0,127}));
    connect(to_degF.y, from_degF.u) 
      annotation (points=[-79,50; -62,50],style(color=74, rgbcolor={0,0,127}));
    connect(to_degRk.y, from_degRk.u) 
      annotation (points=[-79,10; -62,10],
                                        style(color=74, rgbcolor={0,0,127}));
    connect(to_deg.y, from_deg.u) 
      annotation (points=[-79,-30; -62,-30],
                                        style(color=74, rgbcolor={0,0,127}));
    connect(to_rpm.y, from_rpm.u) 
      annotation (points=[-79,-70; -62,-70],
                                          style(color=74, rgbcolor={0,0,127}));
    connect(to_kmh.y, from_kmh.u) 
      annotation (points=[-79,-110; -62,-110],
                                          style(color=74, rgbcolor={0,0,127}));
    connect(to_day.y, from_day.u) annotation (points=[101,130; 118,130],style(
          color=74, rgbcolor={0,0,127}));
    connect(to_hour.y, from_hour.u) annotation (points=[101,90; 118,90],  style(
          color=74, rgbcolor={0,0,127}));
    connect(to_minute.y, from_minute.u) annotation (points=[101,50; 118,50],
        style(color=74, rgbcolor={0,0,127}));
    connect(to_litre.y, from_litre.u) annotation (points=[101,10; 118,10],
        style(color=74, rgbcolor={0,0,127}));
    connect(to_kWh.y, from_kWh.u) 
      annotation (points=[101,-30; 118,-30],
                                         style(color=74, rgbcolor={0,0,127}));
    connect(to_bar.y, from_bar.u) 
      annotation (points=[101,-70; 118,-70],
                                         style(color=74, rgbcolor={0,0,127}));
    connect(to_gps.y, from_gps.u) 
      annotation (points=[101,-110; 118,-110],
                                       style(color=74, rgbcolor={0,0,127}));
    connect(sine.y, convert.u) annotation (points=[-119,130; -102,130], style(
          color=74, rgbcolor={0,0,127}));
    connect(sine1.y, to_degC.u) annotation (points=[-119,90; -102,90], style(
          color=74, rgbcolor={0,0,127}));
    connect(sine2.y, to_degF.u) annotation (points=[-119,50; -102,50], style(
          color=74, rgbcolor={0,0,127}));
    connect(sine3.y, to_degRk.u) annotation (points=[-119,10; -102,10], style(
          color=74, rgbcolor={0,0,127}));
    connect(sine4.y, to_deg.u) annotation (points=[-119,-30; -102,-30], style(
          color=74, rgbcolor={0,0,127}));
    connect(sine5.y, to_rpm.u) annotation (points=[-119,-70; -102,-70], style(
          color=74, rgbcolor={0,0,127}));
    connect(sine6.y, to_kmh.u) annotation (points=[-119,-110; -102,-110], style(
          color=74, rgbcolor={0,0,127}));
    connect(sine7.y, to_day.u) annotation (points=[61,130; 78,130], style(color=
           74, rgbcolor={0,0,127}));
    connect(sine8.y, to_hour.u) 
      annotation (points=[61,90; 78,90], style(color=74, rgbcolor={0,0,127}));
    connect(sine9.y, to_minute.u) 
      annotation (points=[61,50; 78,50], style(color=74, rgbcolor={0,0,127}));
    connect(sine10.y, to_litre.u) 
      annotation (points=[61,10; 78,10], style(color=74, rgbcolor={0,0,127}));
    connect(sine11.y, to_kWh.u) annotation (points=[61,-30; 78,-30], style(
          color=74, rgbcolor={0,0,127}));
    connect(sine12.y, to_bar.u) annotation (points=[61,-70; 68,-70; 68,-70; 78,
          -70], style(color=74, rgbcolor={0,0,127}));
    connect(sine13.y, to_gps.u) annotation (points=[61,-110; 78,-110], style(
          color=74, rgbcolor={0,0,127}));
  end UnitConversions;
  
  model TestKinematicPTP2 
    
    Modelica.Blocks.Sources.KinematicPTP2 kinematicPTP1b(
      q_begin={1},
      q_end={2},
      qd_max={3},
      qdd_max={4},
      startTime=0.5) annotation (extent=[-60,20; -40,40]);
    Modelica.Blocks.Sources.KinematicPTP kinematicPTP1a(
      qd_max={3},
      qdd_max={4},
      startTime=0.5,
      deltaq={1}) annotation (extent=[-60,60; -40,80]);
    Modelica.Blocks.Continuous.Integrator integrator 
      annotation (extent=[-20,60; 2,80]);
    annotation (
      Diagram,
      experiment(StopTime=3),
      experimentSetupOutput);
    Modelica.Blocks.Continuous.Integrator integrator1(y_start=1) 
      annotation (extent=[20,60; 42,80]);
    Modelica.Blocks.Sources.KinematicPTP2 kinematicPTP2b(
      q_begin={1},
      qd_max={3},
      qdd_max={4},
      startTime=0.5,
      q_end={5}) annotation (extent=[-60,-60; -40,-40]);
    Modelica.Blocks.Sources.KinematicPTP kinematicPTP2a(
      qd_max={3},
      qdd_max={4},
      startTime=0.5,
      deltaq={4}) annotation (extent=[-60,-20; -40,0]);
    Modelica.Blocks.Continuous.Integrator integrator2 
      annotation (extent=[-20,-20; 2,0]);
    Modelica.Blocks.Continuous.Integrator integrator3(y_start=1) 
      annotation (extent=[20,-20; 42,0]);
  equation 
    connect(kinematicPTP1a.y[1], integrator.u) annotation (points=[-39,70;
          -22.2,70], style(color=74, rgbcolor={0,0,127}));
    connect(integrator.y, integrator1.u) annotation (points=[3.1,70; 17.8,70],
        style(color=74, rgbcolor={0,0,127}));
    connect(kinematicPTP2a.y[1], integrator2.u) annotation (points=[-39,-10;
          -22.2,-10], style(color=74, rgbcolor={0,0,127}));
    connect(integrator2.y, integrator3.u) annotation (points=[3.1,-10; 17.8,-10],
        style(color=74, rgbcolor={0,0,127}));
  end TestKinematicPTP2;
end Blocks;
