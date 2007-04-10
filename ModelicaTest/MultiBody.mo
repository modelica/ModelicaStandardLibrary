package MultiBody "Test models for Modelica.Mechanics.MultiBody" 
  function test_all_example_models 
    "Simulate all example models of library Modelica.Mechanics.MultiBody" 
    extends Modelica.Icons.Function;
    
  // Names of example and test models that shall be simulated
  protected 
  String models[:] =  {"Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.ForceAndTorque",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.FreeBody",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.InitSpringConstant",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.LineForceWithTwoMasses",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.PendulumWithSpringDamper",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.PointGravity",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.SpringDamperSystem",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.SpringMassSystem",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.SpringWithMass",
                       "Modelica.Mechanics.MultiBody.Examples.Elementary.ThreeSprings",
                       "Modelica.Mechanics.MultiBody.Examples.Loops.Engine1a",
                       "Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b",
                       "Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b_analytic",
                       "Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6",
                       "Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6_analytic",
                       "Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar1",
                       "Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar2",
                       "Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar_analytic",
                       "Modelica.Mechanics.MultiBody.Examples.Loops.PlanarLoops_analytic",
                       "Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.oneAxis",
                       "Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.fullRobot"};
  algorithm 
    ModelicaTest.UtilitiesForTesting.test_that_models_simulate(models);
  end test_all_example_models;
  
  model TestDistanceSensor "Test MultiBody.Sensors.Distance" 
    
    inner Modelica.Mechanics.MultiBody.World world 
      annotation (extent=[-80,0; -60,20]);
    Modelica.Mechanics.MultiBody.Joints.Revolute Revolute1(initType=Modelica.
          Mechanics.MultiBody.Types.Init.PositionVelocity, phi_start=30) 
      annotation (extent=[-40,0; -20,20]);
    annotation (
      Diagram,
      experiment(
        StopTime=0.5,
        NumberOfIntervals=50000,
        Tolerance=1e-010),
      experimentSetupOutput);
    Modelica.Mechanics.MultiBody.Parts.BodyBox BodyBox1(r={1,0,0}, width=0.08) 
      annotation (extent=[0,0; 20,20]);
    Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r={1,0,0}) 
      annotation (extent=[60,40; 80,60], rotation=-90);
    Modelica.Mechanics.MultiBody.Sensors.Distance distance1 
      annotation (extent=[40,0; 60,20]);
    Modelica.Blocks.Continuous.Der Der1 annotation (extent=[60,-24; 80,-4]);
    Modelica.Blocks.Logical.LessEqualThreshold LessEqualThreshold1 
      annotation (extent=[60,-50; 80,-30]);
    Modelica.Mechanics.MultiBody.Sensors.Distance distance2 
      annotation (extent=[-40,30; -20,50]);
  equation 
    connect(world.frame_b, Revolute1.frame_a) annotation (points=[-60,10; -40,
          10], style(
        color=0,
        rgbcolor={0,0,0},
        thickness=2));
    connect(Revolute1.frame_b, BodyBox1.frame_a) annotation (points=[-20,10; 0,
          10], style(
        color=0,
        rgbcolor={0,0,0},
        thickness=2));
    connect(BodyBox1.frame_b, distance1.frame_a) annotation (points=[20,10; 40,
          10], style(
        color=0,
        rgbcolor={0,0,0},
        thickness=2));
    connect(distance1.frame_b, fixed.frame_b) annotation (points=[60,10; 70,10;
          70,40], style(
        color=0,
        rgbcolor={0,0,0},
        thickness=2));
    connect(distance1.distance, Der1.u) annotation (points=[50,-1; 50,-14; 58,
          -14], style(color=74, rgbcolor={0,0,127}));
    connect(distance1.distance, LessEqualThreshold1.u) annotation (points=[50,
          -1; 50,-40; 58,-40], style(color=74, rgbcolor={0,0,127}));
    connect(Revolute1.frame_a, distance2.frame_a) annotation (points=[-40,10;
          -46,10; -46,40; -40,40], style(
        color=0,
        rgbcolor={0,0,0},
        thickness=2));
    connect(Revolute1.frame_b, distance2.frame_b) annotation (points=[-20,10;
          -10,10; -10,40; -20,40], style(
        color=0,
        rgbcolor={0,0,0},
        thickness=2));
  end TestDistanceSensor;
  
  model TestPointMass "Test MassPoint component" 
    
    inner Modelica.Mechanics.MultiBody.World world 
      annotation (extent=[-60,20; -40,40]);
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={1,0,0}) 
      annotation (extent=[20,20; 40,40]);
    annotation (Diagram);
    Modelica.Mechanics.MultiBody.Parts.PointMass pointMass(m=5) 
      annotation (extent=[60,20; 80,40]);
    Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute rev(initType=Modelica.
          Mechanics.MultiBody.Types.Init.PositionVelocity) 
      annotation (extent=[-20,20; 0,40]);
  equation 
    connect(fixedTranslation.frame_b,pointMass. frame_a) annotation (points=[40,
          30; 70,30], style(
        color=10,
        rgbcolor={95,95,95},
        thickness=2));
    connect(world.frame_b, rev.frame_a) annotation (points=[-40,30; -20,30],
        style(
        color=10,
        rgbcolor={95,95,95},
        thickness=2));
    connect(rev.frame_b, fixedTranslation.frame_a) annotation (points=[0,30; 20,
          30], style(
        color=10,
        rgbcolor={95,95,95},
        thickness=2));
  end TestPointMass;
  
  model TestDifferentiationOfForces 
    
    inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.
          UniformGravity) annotation (extent=[-80,0; -60,20]);
    Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute rev(n={0,0,1}, initType=Modelica.Mechanics.MultiBody.Types.
          Init.PositionVelocity) annotation (extent=[-40,0; -20,20]);
    Modelica.Mechanics.MultiBody.Parts.BodyBox body(r={1,0,0}) 
      annotation (extent=[0,0; 20,20]);
    Modelica.Mechanics.MultiBody.Forces.FrameForceAndTorque frameForceAndTorque
      annotation (extent=[-40,-40; -20,-20]);
    Modelica.Blocks.Sources.Sine sine[6] annotation (extent=[-80,-40; -60,-20]);
    Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce 
      annotation (extent=[0,-40; 20,-20]);
    Modelica.Blocks.Continuous.Der der1[3] annotation (extent=[20,-70; 40,-50]);
    Modelica.Blocks.Continuous.Der der2[3] annotation (extent=[54,-70; 74,-50]);
  equation 
    connect(world.frame_b,rev. frame_a) 
      annotation (points=[-60,10; -40,10], style(
        color=10,
        rgbcolor={95,95,95},
        thickness=2));
    connect(body.frame_a,rev. frame_b) annotation (points=[0,10; -20,10],style(
        color=10,
        rgbcolor={95,95,95},
        thickness=2,
        gradient=2));
    annotation (Diagram);
    connect(sine.y, frameForceAndTorque.load) annotation (points=[-59,-30; -42,
          -30], style(color=74, rgbcolor={0,0,127}));
    connect(frameForceAndTorque.frame_b, cutForce.frame_a) annotation (points=[
          -20,-30; 0,-30], style(
        color=10,
        rgbcolor={95,95,95},
        thickness=2));
    connect(cutForce.frame_b, body.frame_b) annotation (points=[20,-30; 30,-30;
          30,10; 20,10], style(
        color=10,
        rgbcolor={95,95,95},
        thickness=2));
    connect(cutForce.force, der1.u) annotation (points=[2,-41; 2,-60; 18,-60],
        style(color=74, rgbcolor={0,0,127}));
    connect(frameForceAndTorque.frame_resolve, body.frame_a) annotation (points=
         [-30,-20; -30,-14; -12,-14; -12,10; 0,10], style(
        color=10,
        rgbcolor={95,95,95},
        pattern=3));
    connect(der1.y, der2.u) annotation (points=[41,-60; 52,-60], style(color=74,
          rgbcolor={0,0,127}));
  end TestDifferentiationOfForces;
  
  model TestMove 
    
    annotation (uses(Modelica(version="2.2.1")), Diagram);
    Modelica.Mechanics.MultiBody.Parts.Body Body1(I_33=2) 
      annotation (extent=[66,36; 86,56]);
    Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute ActuatedRevolute1 
      annotation (extent=[32,0; 52,20]);
    inner Modelica.Mechanics.MultiBody.World world(g=0) 
      annotation (extent=[0,0; 20,20]);
    Modelica.Mechanics.Rotational.Move move  annotation (extent=[20,40; 40,60]);
    Modelica.Blocks.Routing.Multiplex3 Multiplex3_1 
      annotation (extent=[-56,40; -36,60]);
    Modelica.Blocks.Sources.Constant Constant1 
      annotation (extent=[-100,16; -80,36]);
    Modelica.Blocks.Sources.Constant Constant2(k=0) 
      annotation (extent=[-100,70; -80,90]);
    Modelica.Mechanics.Translational.Move move1 
      annotation (extent=[-20,-40; 0,-20]);
    Modelica.Mechanics.Translational.SlidingMass slidingMass(m=2) 
      annotation (extent=[20,-40; 40,-20]);
  equation 
    connect(ActuatedRevolute1.frame_b, Body1.frame_a) annotation (points=[52,10;
          62,10; 62,46; 66,46], style(
        color=0,
        rgbcolor={0,0,0},
        thickness=2));
    connect(world.frame_b, ActuatedRevolute1.frame_a) annotation (points=[20,10;
          32,10], style(
        color=0,
        rgbcolor={0,0,0},
        thickness=2));
    connect(move.flange_b, ActuatedRevolute1.axis)  annotation (points=[40,50;
          42,50; 42,20],
                      style(color=0, rgbcolor={0,0,0}));
    connect(Multiplex3_1.y, move.u) 
      annotation (points=[-35,50; 18,50],style(color=74, rgbcolor={0,0,127}));
    connect(Constant1.y, Multiplex3_1.u3[1]) annotation (points=[-79,26; -74,26;
          -74,43; -58,43], style(color=74, rgbcolor={0,0,127}));
    connect(Constant2.y, Multiplex3_1.u1[1]) annotation (points=[-79,80; -74,80;
          -74,57; -58,57], style(color=74, rgbcolor={0,0,127}));
    connect(Constant2.y, Multiplex3_1.u2[1]) annotation (points=[-79,80; -74,80;
          -74,50; -58,50], style(color=74, rgbcolor={0,0,127}));
    connect(Multiplex3_1.y, move1.u) annotation (points=[-35,50; -28,50; -28,
          -30; -22,-30], style(color=74, rgbcolor={0,0,127}));
    connect(move1.flange_b, slidingMass.flange_a) 
      annotation (points=[0,-30; 20,-30], style(color=58, rgbcolor={0,127,0}));
  end TestMove;
  
  model TestSpeed 
    
    Modelica.Mechanics.Rotational.Speed speed1(f_crit=5, phi_start=1) 
      annotation (extent=[-20,60; 0,80]);
    Modelica.Mechanics.Rotational.Inertia inertia1 
      annotation (extent=[20,60; 40,80]);
    annotation (Diagram);
    Modelica.Mechanics.Rotational.Speed speed2(
      f_crit=5,
      phi_start=1,
      exact=true) annotation (extent=[-20,20; 0,40]);
    Modelica.Mechanics.Rotational.Inertia inertia2 
      annotation (extent=[20,20; 40,40]);
    Modelica.Blocks.Sources.Sine sine2 annotation (extent=[-60,20; -40,40]);
    Modelica.Blocks.Sources.Step step(startTime=0.5) 
      annotation (extent=[-60,62; -40,82]);
    Modelica.Mechanics.Translational.Speed speed3(s_start=1, f_crit=5) 
      annotation (extent=[-20,-20; 0,0]);
    Modelica.Mechanics.Translational.SlidingMass mass1(m=2) 
      annotation (extent=[20,-20; 40,0]);
    Modelica.Blocks.Sources.Step step1(startTime=0.5) 
      annotation (extent=[-60,-20; -40,0]);
    Modelica.Mechanics.Translational.Speed speed4(s_start=1, exact=true) 
      annotation (extent=[-20,-60; 0,-40]);
    Modelica.Mechanics.Translational.SlidingMass mass2(m=2) 
      annotation (extent=[20,-60; 40,-40]);
    Modelica.Blocks.Sources.Sine sine4 annotation (extent=[-60,-60; -40,-40]);
  equation 
    connect(speed1.flange_b, inertia1.flange_a) 
      annotation (points=[0,70; 20,70], style(color=0, rgbcolor={0,0,0}));
    connect(speed2.flange_b, inertia2.flange_a) 
      annotation (points=[0,30; 20,30], style(color=0, rgbcolor={0,0,0}));
    connect(sine2.y, speed2.w_ref) annotation (points=[-39,30; -22,30], style(
          color=74, rgbcolor={0,0,127}));
    connect(step.y, speed1.w_ref) annotation (points=[-39,72; -30,72; -30,70;
          -22,70], style(color=74, rgbcolor={0,0,127}));
    connect(speed3.flange_b, mass1.flange_a) 
      annotation (points=[0,-10; 20,-10], style(color=58, rgbcolor={0,127,0}));
    connect(step1.y, speed3.v_ref) annotation (points=[-39,-10; -22,-10], style(
          color=74, rgbcolor={0,0,127}));
    connect(speed4.flange_b, mass2.flange_a) 
      annotation (points=[0,-50; 20,-50], style(color=58, rgbcolor={0,127,0}));
    connect(sine4.y, speed4.v_ref) annotation (points=[-39,-50; -22,-50], style(
          color=74, rgbcolor={0,0,127}));
  end TestSpeed;
end MultiBody;
