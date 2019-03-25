within Modelica.Fluid.Examples;
package Tanks "Library demonstrating the usage of the tank model"
  extends Modelica.Icons.ExamplesPackage;

  model ThreeTanks "Demonstrating the usage of SimpleTank"
    import Modelica.Fluid;
    extends Modelica.Icons.Example;
     // replaceable package Medium = Modelica.Fluid.Media.Water.ConstantPropertyLiquidWater extends
    // replaceable package Medium = Modelica.Media.Water.StandardWaterOnePhase extends
    // replaceable package Medium = Modelica.Media.Incompressible.Examples.Glycol47 extends
     replaceable package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater                           constrainedby
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
        annotation (choicesAllMatching = true);

    Modelica.Fluid.Vessels.OpenTank tank1(
      crossArea=1,
      redeclare package Medium = Medium,
      use_portsData=true,
      height=12,
      level_start=8,
      nPorts=1,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
          0.1)}) annotation (Placement(transformation(extent={{-80,20},{-40,
              60}})));
    Modelica.Fluid.Vessels.OpenTank tank2(
      crossArea=1,
      redeclare package Medium = Medium,
      use_portsData=true,
      height=12,
      level_start=3,
      nPorts=1,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
          0.1)}) annotation (Placement(transformation(extent={{-20,20},{20,
              60}})));

    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                     annotation (Placement(transformation(
            extent={{70,-90},{90,-70}})));
    Modelica.Fluid.Vessels.OpenTank tank3(
      crossArea=1,
      redeclare package Medium = Medium,
      use_portsData=true,
      height=12,
      level_start=3,
      nPorts=1,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
          0.1)}) annotation (Placement(transformation(extent={{40,10},{80,
              50}})));
    Modelica.Fluid.Pipes.StaticPipe pipe1(                    redeclare package
        Medium =                                                                       Medium,
      allowFlowReversal=true,
      height_ab=2,
      length=2,
      diameter=0.1)
                   annotation (Placement(transformation(
          origin={-60,-10},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Fluid.Pipes.StaticPipe pipe2(                    redeclare package
        Medium =                                                                       Medium,
      allowFlowReversal=true,
      height_ab=2,
      length=2,
      diameter=0.1)
                   annotation (Placement(transformation(
          origin={0,-10},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Fluid.Pipes.StaticPipe pipe3(                    redeclare package
        Medium =                                                                       Medium,
      allowFlowReversal=true,
      height_ab=-1,
      length=2,
      diameter=0.1) annotation (Placement(transformation(
          origin={60,-20},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    connect(pipe1.port_a, pipe2.port_a) annotation (Line(points={{-60,-20},{-60,
            -40},{0,-40},{0,-30},{0,-20}}, color={0,127,255}));
    connect(pipe2.port_a, pipe3.port_a) annotation (Line(points={{0,-20},{0,-20},
            {0,-40},{60,-40},{60,-30}}, color={0,127,255}));
    connect(pipe3.port_b, tank3.ports[1])
      annotation (Line(points={{60,-10},{60,-10},{60,10}}, color={0,127,255}));
    connect(pipe1.port_b, tank1.ports[1]) annotation (Line(points={{-60,0},{-60,
            10},{-60,20}}, color={0,127,255}));
    connect(pipe2.port_b, tank2.ports[1]) annotation (Line(
        points={{0,0},{0,20}}, color={0,127,255}));

    annotation (experiment(StopTime=200),
      __Dymola_Commands(file=
            "modelica://Modelica/Resources/Scripts/Dymola/Fluid/ThreeTanks/plot level and port.m_flow.mos"
          "plot level and port.m_flow"),
      Documentation(info="<html>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/ThreeTanks.png\" border=\"1\"
     alt=\"ThreeTanks.png\">
</html>"));
  end ThreeTanks;

  model TanksWithOverflow "Two tanks connected with pipes at different heights"
    extends Modelica.Icons.Example;
    import Modelica.Fluid;
    Modelica.Fluid.Vessels.OpenTank upperTank(
      redeclare package Medium =
          Modelica.Media.CompressibleLiquids.LinearColdWater,
      height=20,
      level_start=2,
      crossArea=0.2,
      nPorts=3,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.1),
          Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.1),
          Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.1, height=
           6)})
      annotation (Placement(transformation(extent={{-40,20},{0,60}})));
    Modelica.Fluid.Sources.MassFlowSource_T massFlowRate(nPorts=1,
      redeclare package Medium =
          Modelica.Media.CompressibleLiquids.LinearColdWater,
      m_flow=0.2,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                        annotation (Placement(transformation(
            extent={{-150,-112},{-130,-92}})));
    Modelica.Fluid.Sensors.Pressure pressure(redeclare package Medium =
          Modelica.Media.CompressibleLiquids.LinearColdWater) annotation (Placement(
          transformation(extent={{40,16},{60,36}})));
    Modelica.Fluid.Pipes.StaticPipe pipe(
      redeclare package Medium =
          Modelica.Media.CompressibleLiquids.LinearColdWater,
      diameter=0.02,
      height_ab=-5,
      length=200) annotation (Placement(transformation(
          origin={0,-30},
          extent={{10,-10},{-10,10}},
          rotation=90)));

    Modelica.Fluid.Vessels.OpenTank lowerTank(
      height=20,
      redeclare package Medium =
          Modelica.Media.CompressibleLiquids.LinearColdWater,
      level_start=2,
      crossArea=1,
      nPorts=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
          0.1),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.1,
          height=6)})
      annotation (Placement(transformation(extent={{40,-60},{80,-20}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(
      uLow=1.1e5,
      uHigh=2.5e5,
      pre_y_start=true) "mass flow rate signal by pressure control"
      annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
    Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
            extent={{-100,-30},{-80,-10}})));
    Modelica.Blocks.Sources.Constant m_flow_off(k=0)
      annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
    Modelica.Blocks.Sources.Constant m_flow_on(k=2)
      annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));
    Modelica.Fluid.Pipes.StaticPipe overflow(
      redeclare package Medium =
          Modelica.Media.CompressibleLiquids.LinearColdWater,
      diameter=0.02,
      length=200,
      height_ab=-5)
                  annotation (Placement(transformation(
          origin={20,-10},
          extent={{10,-10},{-10,10}},
          rotation=90)));
  equation
    connect(massFlowRate.ports[1], upperTank.ports[1])
                                                   annotation (Line(
        points={{-40,-30},{-25.3333,-30},{-25.3333,20}}, color={0,127,255}));
    connect(pressure.p, hysteresis.u) annotation (Line(
        points={{61,26},{70,26},{70,80},{-150,80},{-150,-20},{-142,-20}}, color={0,0,127}));
    connect(hysteresis.y, switch1.u2) annotation (Line(
        points={{-119,-20},{-102,-20}}, color={255,0,255}));
    connect(m_flow_off.y, switch1.u1) annotation (Line(
        points={{-119,20},{-119,5},{-102,5},{-102,-12}}, color={0,0,127}));
    connect(m_flow_on.y, switch1.u3) annotation (Line(
        points={{-119,-50},{-110,-50},{-110,-28},{-102,-28}}, color={0,0,127}));
    connect(switch1.y, massFlowRate.m_flow_in) annotation (Line(
        points={{-79,-20},{-70,-20},{-70,-22},{-60,-22}}, color={0,0,127}));
    connect(upperTank.ports[2], pipe.port_a) annotation (Line(
        points={{-20,20},{-20,10},{0,10},{0,-20}}, color={0,127,255}));
    connect(pipe.port_a, pressure.port) annotation (Line(
        points={{0,-20},{0,10},{50,10},{50,16}}, color={0,127,255}));
    connect(pipe.port_b, lowerTank.ports[1]) annotation (Line(
        points={{0,-40},{0,-70},{56,-70},{56,-60}}, color={0,127,255}));
    connect(upperTank.ports[3], overflow.port_a) annotation (Line(
        points={{-14.6667,20},{0,20},{0,40},{20,40},{20,0}}, color={0,127,255}));
    connect(overflow.port_b, lowerTank.ports[2]) annotation (Line(
        points={{20,-20},{20,-40},{40,-40},{40,-60},{64,-60}}, color={0,127,255}));

    annotation (experiment(StopTime=25000, Interval=5.0),
      __Dymola_Commands(file=
            "modelica://Modelica/Resources/Scripts/Dymola/Fluid/TanksWithOverflow/plot level and port.m_flow.mos"
          "plot level and port.m_flow"),
      Documentation(info="<html>
<p>The mass flow rate to the upper tank is controlled by the static pressure at its bottom.
The fluid flows through a pipe and forced by different heights from the upper tank to the lower tank.
</p>
<p>
Additional fluid flows through an overflow pipe if the level of the upper tank exceeds 6m.
Initially the overflow enters the lower tank above its fluid level; later on the fluid level exceeds the overflow port.
</p>
<p>
Note that the number of solver intervals has been increased, accounting for the long simulation time horizon.
Otherwise the simulation may fail due to too large steps subject to events. Alternatively the
simulation accuracy could be increased in order to avoid errors.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/TanksWithOverflow.png\" border=\"1\"
     alt=\"TanksWithOverflow.png\">
</html>"),
      Diagram(coordinateSystem(extent={{-160,-120},{100,100}})));
  end TanksWithOverflow;

  model EmptyTanks "Show the treatment of empty tanks"
    extends Modelica.Icons.Example;
    Modelica.Fluid.Vessels.OpenTank tank1(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      nPorts=1,
      crossArea=1,
      level_start=1,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
          0.1)},
      height=1.1) annotation (Placement(transformation(extent={{-40,20},
              {0,60}})));

    Modelica.Fluid.Pipes.StaticPipe pipe(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      length=1,
      diameter=0.1,
      height_ab=-1)
                   annotation (Placement(transformation(
          origin={-20,-20},
          extent={{-10,-10},{10,10}},
          rotation=270)));

    Modelica.Fluid.Vessels.OpenTank tank2(
      crossArea=1,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      nPorts=1,
      height=1.1,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
          0.1, height=0.5)},
      level_start=1.0e-10)
      annotation (Placement(transformation(extent={{0,-80},{40,-40}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                     annotation (Placement(transformation(
            extent={{60,60},{80,80}})));
  equation
    connect(tank1.ports[1], pipe.port_a) annotation (Line(
        points={{-20,20},{-20,5},{-20,-10},{-20,-10}}, color={0,127,255}));
    connect(pipe.port_b, tank2.ports[1]) annotation (Line(
        points={{-20,-30},{-20,-60},{0,-60},{0,-80},{20,-80}}, color={0,127,255}));

    annotation (
      experiment(StopTime=50),
      __Dymola_Commands(file="modelica://Modelica/Resources/Scripts/Dymola/Fluid/EmptyTanks/plot level and port.p.mos"
          "plot level and port.p"),
      Documentation(info="<html>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/EmptyTanks.png\" border=\"1\"
     alt=\"EmptyTanks.png\">
</html>"));
  end EmptyTanks;

end Tanks;
