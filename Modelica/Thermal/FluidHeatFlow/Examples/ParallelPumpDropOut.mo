within Modelica.Thermal.FluidHeatFlow.Examples;
model ParallelPumpDropOut
  "Cooling circuit with parallel branches and drop out of pump"
  extends Modelica.Icons.Example;
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
    "Cooling medium" annotation (choicesAllMatching=true);
  parameter SI.Temperature TAmb(displayUnit="degC")=293.15
    "Ambient temperature";
  output SI.TemperatureDifference dTSource1=
    prescribedHeatFlow1.port.T-TAmb "Source1 over Ambient";
  output SI.TemperatureDifference dTtoPipe1=prescribedHeatFlow1.port.T-pipe1.T_q
    "Source1 over Coolant1";
  output SI.TemperatureDifference dTCoolant1=pipe1.dT
    "Coolant1's temperature increase";
  output SI.TemperatureDifference dTSource2=
    prescribedHeatFlow2.port.T-TAmb "Source2 over Ambient";
  output SI.TemperatureDifference dTtoPipe2=prescribedHeatFlow2.port.T-pipe2.T_q
    "Source2 over Coolant2";
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
    T0=TAmb,
    m=0.1,
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
    C=0.1, T(start=TAmb, fixed=true))
    annotation (Placement(transformation(
        origin={40,-60},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow1
    annotation (Placement(transformation(
        origin={-20,-60},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.Convection Convection1
    annotation (Placement(transformation(
        origin={10,-40},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(
    C=0.1, T(start=TAmb, fixed=true))
    annotation (Placement(transformation(
        origin={38,60},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow2
    annotation (Placement(transformation(
        origin={-20,60},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection2
    annotation (Placement(transformation(
        origin={10,40},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  FluidHeatFlow.Examples.Utilities.DoubleRamp volumeFlow
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.Constant heatFlow1(k=5)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Sources.Constant heatFlow2(k=10)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.Constant thermalConductance1(k=1)
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Blocks.Sources.Constant thermalConductance2(k=1)
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
equation
  connect(ambient1.flowPort, pump.flowPort_a)
    annotation (Line(points={{-60,0},{-60,0},{-40,0}}, color={255,0,0}));
  connect(pump.flowPort_b, pipe1.flowPort_a)
    annotation (Line(points={{-20,0},{-10,0},{-10,-10},{0,-10}}, color={255,0,0}));
  connect(pump.flowPort_b, pipe2.flowPort_a)
    annotation (Line(points={{-20,0},{-10,0},{-10,10},{0,10}}, color={255,0,0}));
  connect(heatFlow2.y,prescribedHeatFlow2. Q_flow)
    annotation (Line(points={{-39,60},{-30,60}}, color={0,0,255}));
  connect(heatFlow1.y,prescribedHeatFlow1. Q_flow)
    annotation (Line(points={{-39,-60},{-30,-60}}, color={0,0,255}));
  connect(thermalConductance2.y, convection2.Gc)
    annotation (Line(points={{-9,40},{0,40}}, color={0,0,127}));
  connect(thermalConductance1.y, Convection1.Gc)
    annotation (Line(points={{-9,-40},{0,-40}}, color={0,0,127}));
  connect(pipe1.heatPort, Convection1.fluid) annotation (Line(points={{10,-20},{
          10,-25},{10,-30}}, color={191,0,0}));
  connect(convection2.fluid,pipe2. heatPort) annotation (Line(points={{10,30},{10,
          20}}, color={191,0,0}));
  connect(convection2.solid,prescribedHeatFlow2. port) annotation (Line(
        points={{10,50},{10,60},{-10,60}}, color={191,0,0}));
  connect(convection2.solid,heatCapacitor2. port) annotation (Line(points={{10,50},
          {10,60},{28,60}}, color={191,0,0}));
  connect(Convection1.solid,prescribedHeatFlow1. port) annotation (Line(
        points={{10,-50},{10,-60},{-10,-60}}, color={191,0,0}));
  connect(Convection1.solid,heatCapacitor1. port) annotation (Line(points={{10,-50},
          {10,-60},{30,-60}}, color={191,0,0}));
  connect(pipe2.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,10},{
          30,10},{30,0},{40,0}}, color={255,0,0}));
  connect(pipe1.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,
          -10},{30,-10},{30,0},{40,0}}, color={255,0,0}));
  connect(pipe3.flowPort_b,ambient2. flowPort)
    annotation (Line(points={{60,0},{80,0}}, color={255,0,0}));
  connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
      points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
annotation (Documentation(info="<html>
<p>
6th test example: ParallelPumpDropOut
</p>
Same as 2nd test example, but with a drop out of the pump:<br>
The pump is running for 0.2 s, then shut down (using a ramp of 0.2 s) for 0.2 s,
then started again (using a ramp of 0.2 s).
</html>"),    experiment(StopTime=2.0, Interval=0.001));
end ParallelPumpDropOut;
