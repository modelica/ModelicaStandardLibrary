within ModelicaTest.Fluid.TestComponents.Sensors;
model TestTemperatureSensor "Test and compare case for the difference between using one port with
   and without explicit junction model and two port sensor for fluid temperature meassuring"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  Modelica.Fluid.Sensors.Temperature Temperature(redeclare package Medium =
                       Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=0)));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperatureTwoPort(redeclare
      package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=0)));
  inner Modelica.Fluid.System system  annotation (Placement(transformation(
          extent={{-100,-100},{-80,-80}}, rotation=0)));
  Modelica.Fluid.Vessels.OpenTank openTankCold2(nPorts=1,
    level_start=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    height=2,
    crossArea=2,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)}) annotation (Placement(transformation(extent={{20,0},
            {40,20}}, rotation=0)));
  Modelica.Fluid.Vessels.OpenTank openTankCold1(nPorts=1,
    level_start=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    height=2,
    crossArea=2,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)}) annotation (Placement(transformation(extent={{20,60},
            {40,80}}, rotation=0)));
  Modelica.Fluid.Vessels.OpenTank openTankHot1(nPorts=1,
    level_start=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    height=2,
    crossArea=2,
    T_start=SI.Conversions.from_degC(80),
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)}) annotation (Placement(transformation(extent={{60,40},
            {80,60}}, rotation=0)));
  Modelica.Fluid.Vessels.OpenTank openTankHot2(nPorts=1,
    level_start=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    height=2,
    crossArea=2,
    T_start=SI.Conversions.from_degC(80),
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)}) annotation (Placement(transformation(extent={{60,-20},
            {80,0}}, rotation=0)));
  Modelica.Fluid.Sources.MassFlowSource_T massFlowRate1(nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    T=SI.Conversions.from_degC(50)) annotation (Placement(transformation(extent=
           {{-60,30},{-40,50}}, rotation=0)));
  Modelica.Fluid.Sources.MassFlowSource_T massFlowRate2(nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    T=SI.Conversions.from_degC(50)) annotation (Placement(transformation(extent=
           {{-60,-20},{-40,0}}, rotation=0)));
  Modelica.Blocks.Sources.Sine sine annotation (Placement(transformation(extent=
           {{-100,10},{-80,30}}, rotation=0)));
  Modelica.Fluid.Sensors.Temperature TemperatureJunction(
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}}, rotation=0)));
  Modelica.Fluid.Vessels.OpenTank openTankCold3(nPorts=1,
    level_start=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    height=2,
    crossArea=2,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)}) annotation (Placement(transformation(extent={{20,-60},
            {40,-40}}, rotation=0)));
  Modelica.Fluid.Vessels.OpenTank openTankHot3(nPorts=1,
    level_start=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    height=2,
    crossArea=2,
    T_start=SI.Conversions.from_degC(80),
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)}) annotation (Placement(transformation(extent={{60,-80},
            {80,-60}}, rotation=0)));
  Modelica.Fluid.Sources.MassFlowSource_T massFlowRate3(nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    T=SI.Conversions.from_degC(50)) annotation (Placement(transformation(extent=
           {{-60,-90},{-40,-70}}, rotation=0)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal junctionIdeal(
                                                       redeclare package Medium
      = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{20,-90},{40,-70}}, rotation=0)));
equation
  connect(massFlowRate2.ports[1], temperatureTwoPort.port_a)
                                                         annotation (Line(
      points={{-40,-10},{-20,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(massFlowRate1.ports[1], Temperature.port)    annotation (Line(
      points={{-40,40},{-10,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sine.y, massFlowRate1.m_flow_in) annotation (Line(
      points={{-79,20},{-70,20},{-70,48},{-60,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y, massFlowRate2.m_flow_in) annotation (Line(
      points={{-79,20},{-70,20},{-70,-2},{-60,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(massFlowRate3.ports[1], TemperatureJunction.port)    annotation (Line(
      points={{-40,-80},{-10,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sine.y, massFlowRate3.m_flow_in) annotation (Line(
      points={{-79,20},{-70,20},{-70,-72},{-60,-72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TemperatureJunction.port, junctionIdeal.port_1) annotation (Line(
      points={{-10,-80},{20,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperatureTwoPort.port_b, openTankCold2.ports[1]) annotation (Line(
        points={{0,-10},{0,-6},{30,-6},{30,0}},    color={0,127,255}));
  connect(Temperature.port, openTankCold1.ports[1]) annotation (Line(
        points={{-10,40},{6,40},{6,56},{30,56},{30,60}},   color={0,127,255}));
  connect(Temperature.port, openTankHot1.ports[1]) annotation (Line(
        points={{-10,40},{30,40},{30,40},{70,40}},     color={0,127,255}));
  connect(temperatureTwoPort.port_b, openTankHot2.ports[1]) annotation (Line(
        points={{0,-10},{34,-10},{34,-20},{70,-20}},     color={0,127,255}));
  connect(junctionIdeal.port_3, openTankCold3.ports[1]) annotation (Line(points={{30,-70},
          {30,-65},{30,-60},{30,-60}},
                                color={0,127,255}));
  connect(junctionIdeal.port_2, openTankHot3.ports[1]) annotation (Line(points={{40,-80},
          {55.5,-80},{55.5,-80},{70,-80}},               color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics),
                       Documentation(info="<html>
<p align = justify>In that test model the behaviour of one port temperature sensors with and without explicit junction models and two port temperature sensor are compared. Therefor each sensor is connected to two tanks with different temperatures and a flow source with changing flow direction.<p>
<p align = justify>With Modelica.Fluid stream connectors, all three sensors show the same expected result.</p>
</html>"));
end TestTemperatureSensor;
