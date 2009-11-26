within ModelicaTest.Fluid.TestComponents.Vessels;
model TestSimpleTank
  "Test a tank running empty and being filled through a top inlet with less water than could flow through the bottom outlet"
  import Modelica.SIunits.Conversions.from_bar;
  extends Modelica.Icons.Example;

  Modelica.Fluid.Vessels.OpenTank tank(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=1,
    nPorts=2,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.1,
        height=0),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        0.1, height=1)},
    crossArea=1,
    level_start=0)
    annotation (Placement(transformation(extent={{0,0},{40,40}},   rotation=0)));

  inner Modelica.Fluid.System system
                        annotation (Placement(transformation(extent={{70,70},
            {90,90}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT ambient_fixed(
                                         redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=system.p_ambient,
    T=system.T_ambient,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}},
                                                                     rotation=
           0)));
  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    length=1,
    height_ab=-1,
    diameter=0.1)
                 annotation (Placement(transformation(
        origin={20,-30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Fluid.Sources.MassFlowSource_T flowSource(nPorts=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=20,
    T=system.T_ambient,
    use_m_flow_in=true)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}}, rotation=
           0)));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0,0; 10,0; 10,40; 20,40;
        20,10; 50,10; 50,0; 60,0; 60,20; 70,20; 80,55; 80,0; 100,0])
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation
  connect(pipe.port_a, tank.ports[1]) annotation (Line(
      points={{20,-20},{20,0},{16,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowSource.ports[1], tank.ports[2]) annotation (Line(
      points={{-20,40},{0,40},{0,0},{24,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ambient_fixed.ports[1], pipe.port_b) annotation (Line(
      points={{-20,-60},{20,-60},{20,-40}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(flowSource.m_flow_in, timeTable.y) annotation (Line(
      points={{-40,48},{-50,48},{-50,50},{-59,50}},
      color={0,0,127},
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}),
                      graphics),
    experiment(StopTime=100),
    experimentSetupOutput);
end TestSimpleTank;
