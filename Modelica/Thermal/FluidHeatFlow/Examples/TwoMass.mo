within Modelica.Thermal.FluidHeatFlow.Examples;
model TwoMass "Cooling of two hot masses"
  extends Modelica.Icons.Example;
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
    "Cooling medium" annotation (choicesAllMatching=true);
  parameter SI.Temperature TAmb(displayUnit="degC")=293.15
    "Ambient temperature";
  parameter SI.Temperature TMass1(displayUnit="degC")=313.15
    "Initial temperature of mass1";
  parameter SI.Temperature TMass2(displayUnit="degC")=333.15
    "Initial temperature of mass2";
  output SI.TemperatureDifference dTMass1=
    heatCapacitor1.port.T-TAmb "Mass1 over Ambient";
  output SI.TemperatureDifference dTtoPipe1=heatCapacitor1.port.T-pipe1.T_q
    "Mass1 over Coolant1";
  output SI.TemperatureDifference dTCoolant1=pipe1.dT
    "Coolant1's temperature increase";
  output SI.TemperatureDifference dTMass2=
    heatCapacitor2.port.T-TAmb "Mass2 over Ambient";
  output SI.TemperatureDifference dTtoPipe2=heatCapacitor2.port.T-pipe2.T_q
    "Mass2 over Coolant2";
  output SI.TemperatureDifference dTCoolant2=pipe2.dT
    "Coolant2's temperature increase";
  output SI.TemperatureDifference dTmixedCoolant=ambient2.T_port-ambient1.T_port
    "Mixed Coolant's temperature increase";
  FluidHeatFlow.Sources.Ambient ambient1(
    constantAmbientTemperature=TAmb,
    medium=medium,
    constantAmbientPressure=0)
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
  FluidHeatFlow.Sources.VolumeFlow pump(
    medium=medium,
    m=0,
    T0=TAmb,
    useVolumeFlowInput=true,
    constantVolumeFlow=1)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
   FluidHeatFlow.Components.Pipe pipe1(
    medium=medium,
    m=0.1,
    T0=TAmb,
    V_flowLaminar=0.1,
    dpLaminar(displayUnit="Pa") = 0.1,
    V_flowNominal=1,
    dpNominal(displayUnit="Pa") = 1,
    h_g=0,
    T0fixed=true,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  FluidHeatFlow.Components.Pipe pipe2(
    medium=medium,
    m=0.1,
    T0=TAmb,
    V_flowLaminar=0.1,
    dpLaminar(displayUnit="Pa") = 0.1,
    V_flowNominal=1,
    dpNominal(displayUnit="Pa") = 1,
    h_g=0,
    T0fixed=true,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{0,20},{20,0}})));
  FluidHeatFlow.Components.Pipe pipe3(
    medium=medium,
    m=0.1,
    T0=TAmb,
    V_flowLaminar=0.1,
    dpLaminar(displayUnit="Pa") = 0.1,
    V_flowNominal=1,
    dpNominal(displayUnit="Pa") = 1,
    h_g=0,
    T0fixed=true)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  FluidHeatFlow.Sources.Ambient ambient2(
    constantAmbientTemperature=TAmb,
    medium=medium,
    constantAmbientPressure=0)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(
    C=0.1, T(start=TMass1, fixed=true))
    annotation (Placement(transformation(
        origin={10,-70},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    thermalConductor1(G=1)
    annotation (Placement(transformation(
        origin={10,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(
    C=0.1, T(start=TMass2, fixed=true))
    annotation (Placement(transformation(
        origin={10,70},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    thermalConductor2(G=1)
    annotation (Placement(transformation(
        origin={10,40},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  FluidHeatFlow.Examples.Utilities.DoubleRamp volumeFlow(
    offset=0,
    height_1=1,
    height_2=-2)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
equation
  connect(ambient1.flowPort, pump.flowPort_a)
    annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
  connect(pump.flowPort_b, pipe1.flowPort_a)
    annotation (Line(points={{-20,0},{-10,0},{-10,-10},{0,-10}}, color={255,
          0,0}));
  connect(pump.flowPort_b, pipe2.flowPort_a)
    annotation (Line(points={{-20,0},{-10,0},{-10,10},{0,10}}, color={255,0,
          0}));
  connect(pipe2.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,
          10},{30,10},{30,0},{40,0}}, color={255,0,0}));
  connect(pipe1.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,
          -10},{30,-10},{30,0},{40,0}}, color={255,0,0}));
  connect(pipe3.flowPort_b,ambient2. flowPort)
    annotation (Line(points={{60,0},{80,0}}, color={255,0,0}));
  connect(heatCapacitor2.port,thermalConductor2. port_a) annotation (Line(
        points={{10,60},{10,55},{10,50}}, color={191,0,0}));
  connect(thermalConductor2.port_b,pipe2. heatPort)
    annotation (Line(points={{10,30},{10,20}}, color={191,0,0}));
  connect(pipe1.heatPort,thermalConductor1. port_b) annotation (Line(points=
         {{10,-20},{10,-30}}, color={191,0,0}));
  connect(thermalConductor1.port_a, heatCapacitor1.port) annotation (Line(
        points={{10,-50},{10,-55},{10,-60}}, color={191,0,0}));
  connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
      points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
annotation (Documentation(info="<html>
<p>
8th test example: TwoMass
</p>
Two thermal capacities are coupled with two parallel coolant flow.
Different initial temperatures of thermal capacities and pipe's coolants get ambient's temperature,
the time behaviour depending on coolant flow.
</html>"),    experiment(StopTime=1.0, Interval=0.001));
end TwoMass;
