within ModelicaTest.Fluid.TestComponents.Vessels;
model TestTankWithTopPorts
  extends Modelica.Icons.Example;
  import Modelica.Fluid;
  Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank(
    nTopPorts=2,
    height=10,
    V0=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    level_start=1,
    nPorts=4,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
                                                               diameter=0.01,
        height=9),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        0.01, height=6),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.01, height=4),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
                                                        diameter=0.01,
        height=2)},
    crossArea=0.2)
    annotation (Placement(transformation(extent={{-40,40},{0,80}}, rotation=0)));
  Modelica.Fluid.Sources.MassFlowSource_T massFlowRate[2](each nPorts=1,redeclare
      package Medium = Modelica.Media.Water.StandardWater, each m_flow=0.75)
    annotation (Placement(transformation(extent={{-82,70},{-62,90}}, rotation=0)));
  inner Modelica.Fluid.System system  annotation (Placement(transformation(
          extent={{-100,-100},{-80,-80}}, rotation=0)));
  Modelica.Fluid.Sources.FixedBoundary Boundary_fixed(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=system.p_ambient,
    T=system.T_ambient,
    nPorts=4)
    annotation (Placement(transformation(extent={{100,-90},{80,-70}}, rotation=
            0)));
  Modelica.Fluid.Sensors.MassFlowRate mFlow_9m(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    "Mass flow rate out of the port at a lever of 9 m"
    annotation (Placement(transformation(extent={{20,30},{40,50}}, rotation=0)));
  Modelica.Fluid.Sensors.MassFlowRate mFlow_6m(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    "Mass flow rate out of the port at a lever of 6 m"
    annotation (Placement(transformation(extent={{20,-10},{40,10}}, rotation=0)));
  Modelica.Fluid.Sensors.MassFlowRate mFlow_4m(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    "Mass flow rate out of the port at a lever of 4 m"
    annotation (Placement(transformation(extent={{20,-50},{40,-30}}, rotation=0)));
  Modelica.Fluid.Sensors.MassFlowRate mFlow_2m(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    "Mass flow rate out of the port at a lever of 2 m"
    annotation (Placement(transformation(extent={{20,-90},{40,-70}}, rotation=0)));
equation
  connect(massFlowRate.ports[1], tank.topPorts)
                                            annotation (Line(
      points={{-62,80},{-40,80},{-40,81},{-20,81}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tank.ports[1], mFlow_9m.port_a) annotation (Line(
      points={{-23,39},{-0.5,39},{-0.5,40},{20,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mFlow_9m.port_b, Boundary_fixed.ports[1])
                                                annotation (Line(
      points={{40,40},{60,40},{60,-77},{80,-77}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tank.ports[2], mFlow_6m.port_a) annotation (Line(
      points={{-21,39},{0,39},{0,0},{20,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mFlow_6m.port_b, Boundary_fixed.ports[2])
                                                annotation (Line(
      points={{40,0},{60,0},{60,-79},{80,-79}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tank.ports[3], mFlow_4m.port_a) annotation (Line(
      points={{-19,39},{0,39},{0,-40},{20,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mFlow_4m.port_b, Boundary_fixed.ports[3])
                                                annotation (Line(
      points={{40,-40},{60,-40},{60,-81},{80,-81}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tank.ports[4], mFlow_2m.port_a) annotation (Line(
      points={{-17,39},{0,39},{0,-80},{20,-80}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mFlow_2m.port_b, Boundary_fixed.ports[4])
                                                annotation (Line(
      points={{40,-80},{60,-80},{60,-83},{80,-83}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics),
    experiment(StopTime=5000, Tolerance=1e-005),
    experimentSetupOutput(equdistant=false));
end TestTankWithTopPorts;
