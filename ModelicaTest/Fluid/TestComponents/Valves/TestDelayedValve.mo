within ModelicaTest.Fluid.TestComponents.Valves;
model TestDelayedValve "Test valve with delayed opening"
extends Modelica.Icons.Example;
  Modelica.Fluid.Vessels.OpenTank tank1(
    crossArea=1,
    use_portsData=true,
    height=12,
    level_start=8,
    nPorts=1,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.1)},
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
                   annotation (Placement(transformation(extent={{-72,44},{-32,
            84}}, rotation=0)));

  Modelica.Fluid.Vessels.OpenTank tank2(
    crossArea=1,
    use_portsData=true,
    height=12,
    level_start=3,
    nPorts=1,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.1)},
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
                   annotation (Placement(transformation(extent={{-12,44},{28,84}},
                  rotation=0)));

  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                   annotation (Placement(transformation(
          extent={{78,-66},{98,-46}}, rotation=0)));
  Modelica.Fluid.Vessels.OpenTank tank3(
    crossArea=1,
    use_portsData=true,
    height=12,
    level_start=3,
    nPorts=1,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.1)},
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
                   annotation (Placement(transformation(extent={{48,34},{88,74}},
                  rotation=0)));

  Modelica.Fluid.Pipes.StaticPipe pipe1(
    allowFlowReversal=true,
    height_ab=2,
    length=2,
    diameter=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
                 annotation (Placement(transformation(
        origin={-52,14},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    allowFlowReversal=true,
    height_ab=2,
    length=2,
    diameter=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
                 annotation (Placement(transformation(
        origin={8,14},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Fluid.Pipes.StaticPipe pipe3(
    allowFlowReversal=true,
    height_ab=-1,
    length=2,
    diameter=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
                  annotation (Placement(transformation(
        origin={68,4},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Fluid.Valves.ValveIncompressible valveDelayed(
    Kv=10,
    m_flow_nominal=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    filteredOpening=true,
    dp_nominal=1)
    annotation (Placement(transformation(extent={{-28,-10},{-12,-26}})));

  Modelica.Blocks.Sources.Step step(startTime=1)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
equation
  connect(pipe2.port_a,pipe3. port_a) annotation (Line(points={{8,4},{8,4},{8,
          -18},{68,-18},{68,-6}},                  color={0,127,255}));
  connect(pipe3.port_b,tank3. ports[1])
    annotation (Line(points={{68,14},{68,14},{68,34}},
                                              color={0,127,255}));
  connect(pipe1.port_b,tank1. ports[1]) annotation (Line(points={{-52,24},{-52,
          34},{-52,44}},
                color={0,127,255}));
  connect(pipe2.port_b,tank2. ports[1]) annotation (Line(
      points={{8,24},{8,34},{8,34},{8,44}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valveDelayed.port_b, pipe2.port_a)
                                         annotation (Line(
      points={{-12,-18},{8,-18},{8,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valveDelayed.port_a, pipe1.port_a)
                                         annotation (Line(
      points={{-28,-18},{-52,-18},{-52,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(step.y, valveDelayed.opening) annotation (Line(
      points={{-39,-40},{-20,-40},{-20,-24.4}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (experiment(StopTime=10));
end TestDelayedValve;
