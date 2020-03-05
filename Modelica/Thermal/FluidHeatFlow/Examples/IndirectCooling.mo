within Modelica.Thermal.FluidHeatFlow.Examples;
model IndirectCooling "Indirect cooling circuit"
  extends Modelica.Icons.Example;
  parameter FluidHeatFlow.Media.Medium outerMedium=FluidHeatFlow.Media.Medium()
    "Outer medium" annotation (choicesAllMatching=true);
  parameter FluidHeatFlow.Media.Medium innerMedium=FluidHeatFlow.Media.Medium()
    "Inner medium" annotation (choicesAllMatching=true);
  parameter SI.Temperature TAmb(displayUnit="degC")=293.15
    "Ambient temperature";
  output SI.TemperatureDifference dTSource=
    prescribedHeatFlow.port.T-TAmb "Source over Ambient";
  output SI.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe1.T_q
    "Source over inner Coolant";
  output SI.TemperatureDifference dTinnerCoolant=pipe1.dT
    "Inner Coolant's temperature increase";
  output SI.TemperatureDifference dTCooler=innerPipe.T_q-outerPipe.T_q
    "Cooler's temperature increase between inner and outer pipes";
  output SI.TemperatureDifference dTouterCoolant=outerPipe.dT
    "Outer coolant's temperature increase";
  FluidHeatFlow.Sources.Ambient ambient1(
    constantAmbientTemperature=TAmb,
    medium=outerMedium,
    constantAmbientPressure=0)
    annotation (Placement(transformation(extent={{-60,60},{-80,80}})));
  FluidHeatFlow.Sources.VolumeFlow outerPump(
    medium=outerMedium,
    m=0,
    T0=TAmb,
    useVolumeFlowInput=true,
    constantVolumeFlow=1)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  FluidHeatFlow.Sources.Ambient ambient2(
    constantAmbientTemperature=TAmb,
    medium=outerMedium,
    constantAmbientPressure=0)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    thermalConductor(G=1)
    annotation (Placement(transformation(
        origin={10,-70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
    C=0.05, T(start=TAmb, fixed=true))
    annotation (Placement(transformation(
        origin={40,-90},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow
    annotation (Placement(transformation(
        origin={-20,-90},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  FluidHeatFlow.Components.Pipe pipe1(
    medium=innerMedium,
    m=0.1,
    T0=TAmb,
    V_flowLaminar=1,
    V_flowNominal=2,
    h_g=0,
    T0fixed=true,
    useHeatPort=true,
    dpLaminar=1000,
    dpNominal=2000)
    annotation (Placement(transformation(extent={{20,-50},{0,-30}})));
  FluidHeatFlow.Sources.AbsolutePressure absolutePressure(p=10000, medium=
        innerMedium)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  FluidHeatFlow.Sources.VolumeFlow innerPump(
    medium=innerMedium,
    m=0,
    T0=TAmb,
    useVolumeFlowInput=true,
    constantVolumeFlow=1) annotation (Placement(transformation(
        origin={-20,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Constant heatFlow(k=10)
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Modelica.Blocks.Sources.Constant outerVolumeFlow(k=1)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Sources.Constant innerVolumeFlow(k=1)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Constant outerGc(k=2)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Sources.Constant innerGc(k=2)
    annotation (Placement(transformation(extent={{-40,20},{-20,0}})));
  FluidHeatFlow.Components.Pipe outerPipe(
    medium=outerMedium,
    m=0.1,
    T0=TAmb,
    V_flowLaminar=0.1,
    dpLaminar(displayUnit="Pa") = 0.1,
    V_flowNominal=1,
    dpNominal(displayUnit="Pa") = 1,
    h_g=0,
    T0fixed=true,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  FluidHeatFlow.Components.Pipe innerPipe(
    medium=innerMedium,
    m=0.1,
    T0=TAmb,
    V_flowLaminar=0.1,
    dpLaminar(displayUnit="Pa") = 0.1,
    V_flowNominal=1,
    dpNominal(displayUnit="Pa") = 1,
    h_g=0,
    T0fixed=true,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{0,-10},{20,-30}})));
  Modelica.Thermal.HeatTransfer.Components.Convection innerConvection
    annotation (Placement(transformation(
        origin={10,10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Components.Convection outerConvection
    annotation (Placement(transformation(
        origin={10,40},
        extent={{10,10},{-10,-10}},
        rotation=270)));
equation
  connect(ambient1.flowPort, outerPump.flowPort_a)
    annotation (Line(points={{-60,70},{-40,70}}, color={255,0,0}));
  connect(prescribedHeatFlow.port, thermalConductor.port_a)
    annotation (Line(points={{-10,-90},{10,-90},{10,-80}}, color={191,0,0}));
  connect(heatCapacitor.port, thermalConductor.port_a)
    annotation (Line(points={{30,-90},{10,-90},{10,-80}}, color={191,0,0}));
  connect(pipe1.heatPort, thermalConductor.port_b)
    annotation (Line(points={{10,-50},{10,-60}}, color={191,0,0}));
  connect(pipe1.flowPort_b, innerPump.flowPort_a)
    annotation (Line(points={{0,-40},{-20,-40}}, color={255,0,0}));
  connect(absolutePressure.flowPort, pipe1.flowPort_a)
    annotation (Line(points={{40,-30},{40,-40},{20,-40}}, color={255,0,0}));
  connect(heatFlow.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-39,-90},{-30,-90}}, color={0,0,255}));
  connect(innerPump.flowPort_b, innerPipe.flowPort_a)
    annotation (Line(points={{-20,-20},{0,-20}}, color={255,0,0}));
  connect(innerPipe.flowPort_b, absolutePressure.flowPort) annotation (Line(
        points={{20,-20},{40,-20},{40,-30}}, color={255,0,0}));
  connect(outerPump.flowPort_b, outerPipe.flowPort_a)
    annotation (Line(points={{-20,70},{0,70}}, color={255,0,0}));
  connect(outerPipe.flowPort_b,ambient2. flowPort)
    annotation (Line(points={{20,70},{40,70}}, color={255,0,0}));
  connect(outerPipe.heatPort, outerConvection.fluid)
    annotation (Line(points={{10,60},{10,55},{10,50}}, color={191,0,0}));
  connect(outerConvection.solid, innerConvection.solid)
    annotation (Line(points={{10,30},{10,20},{10,20}}, color={191,0,0}));
  connect(innerConvection.fluid, innerPipe.heatPort)
    annotation (Line(points={{10,0},{10,-5},{10,-10}}, color={191,0,0}));
  connect(innerGc.y, innerConvection.Gc)
    annotation (Line(points={{-19,10},{-9.5,10},{-9.5,10},{0,10}}, color={0,0,127}));
  connect(outerGc.y, outerConvection.Gc)
    annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
  connect(outerVolumeFlow.y, outerPump.volumeFlow) annotation (Line(
      points={{-39,90},{-30,90},{-30,80}}, color={0,0,127}));
  connect(innerVolumeFlow.y, innerPump.volumeFlow) annotation (Line(
      points={{-39,-30},{-30,-30}}, color={0,0,127}));
annotation (Documentation(info="<html>
<p>
3rd test example: IndirectCooling
</p>
A prescribed heat sources dissipates its heat through a thermal conductor to the inner coolant cycle. It is necessary to define the pressure level of the inner coolant cycle. The inner coolant cycle is coupled to the outer coolant flow through a thermal conductor.<br>
Inner coolant's temperature rise near the source is the same as temperature drop near the cooler.<br>
<strong>Results</strong>:<br>
<table>
<tr>
<td><strong>output</strong></td>
<td><strong>explanation</strong></td>
<td><strong>formula</strong></td>
<td><strong>actual steady-state value</strong></td>
</tr>
<tr>
<td>dTSource</td>
<td>Source over Ambient</td>
<td>dtouterCoolant + dtCooler + dTinnerCoolant + dtToPipe</td>
<td>40 K</td>
</tr>
<tr>
<td>dTtoPipe</td>
<td>Source over inner Coolant</td>
<td>Losses / ThermalConductor.G</td>
<td>10 K</td>
</tr>
<tr>
<td>dTinnerColant</td>
<td>inner Coolant's temperature increase</td>
<td>Losses * cp * innerMassFlow</td>
<td>10 K</td>
</tr>
<tr>
<td>dTCooler</td>
<td>Cooler's temperature rise between inner and outer pipes</td>
<td>Losses * (innerGc + outerGc)</td>
<td>10 K</td>
</tr>
<tr>
<td>dTouterColant</td>
<td>outer Coolant's temperature increase</td>
<td>Losses * cp * outerMassFlow</td>
<td>10 K</td>
</tr>
</table>
</html>"),    experiment(StopTime=1.5, Interval=0.001));
end IndirectCooling;
