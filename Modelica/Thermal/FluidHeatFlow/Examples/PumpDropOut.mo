within Modelica.Thermal.FluidHeatFlow.Examples;
model PumpDropOut "Cooling circuit with drop out of pump"
  extends Modelica.Icons.Example;
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
    "Cooling medium" annotation (choicesAllMatching=true);
  parameter SI.Temperature TAmb(displayUnit="degC")=293.15
    "Ambient temperature";
  output SI.TemperatureDifference dTSource=
    prescribedHeatFlow.port.T-TAmb "Source over Ambient";
  output SI.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.T_q
    "Source over Coolant";
  output SI.TemperatureDifference dTCoolant=pipe.dT
    "Coolant's temperature increase";
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
  FluidHeatFlow.Components.Pipe pipe(
    medium=medium,
    T0=TAmb,
    m=0.1,
    V_flowLaminar=0.1,
    dpLaminar(displayUnit="Pa") = 0.1,
    V_flowNominal=1,
    dpNominal(displayUnit="Pa") = 1,
    h_g=0,
    T0fixed=true,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  FluidHeatFlow.Sources.Ambient ambient2(
    constantAmbientTemperature=TAmb,
    medium=medium,
    constantAmbientPressure=0)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
    C=0.1, T(start=TAmb, fixed=true))
    annotation (Placement(transformation(
        origin={40,-50},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
  FluidHeatFlow.Examples.Utilities.DoubleRamp volumeFlow
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.Constant heatFlow(k=10)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(
        origin={10,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Constant thermalConductance(k=1)
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
equation
  connect(ambient1.flowPort, pump.flowPort_a)
    annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
  connect(pump.flowPort_b, pipe.flowPort_a)
    annotation (Line(points={{-20,0},{0,0}}, color={255,0,0}));
  connect(pipe.flowPort_b, ambient2.flowPort)
    annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
  connect(heatFlow.y, prescribedHeatFlow.Q_flow) annotation (Line(points={
          {-39,-50},{-30,-50}}, color={0,0,255}));
  connect(convection.solid, prescribedHeatFlow.port) annotation (Line(
        points={{10,-40},{10,-50},{-10,-50}}, color={191,0,0}));
  connect(convection.solid, heatCapacitor.port) annotation (Line(points={
          {10,-40},{10,-50},{30,-50}}, color={191,0,0}));
  connect(pipe.heatPort, convection.fluid) annotation (Line(points={{10,
          -10},{10,-20}}, color={191,0,0}));
  connect(thermalConductance.y, convection.Gc)
    annotation (Line(points={{-9,-30},{0,-30}}, color={0,0,127}));
  connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
      points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
annotation (Documentation(info="<html>
<p>
5th test example: PumpDropOut
</p>
Same as 1st test example, but with a drop out of the pump:<br>
The pump is running for 0.2 s, then shut down (using a ramp of 0.2 s) for 0.2 s,
then started again (using a ramp of 0.2 s).
</html>"),    experiment(StopTime=2.0, Interval=0.001));
end PumpDropOut;
