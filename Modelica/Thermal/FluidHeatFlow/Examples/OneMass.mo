within Modelica.Thermal.FluidHeatFlow.Examples;
model OneMass "Cooling of one hot mass"
  extends Modelica.Icons.Example;
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
    "Cooling medium" annotation (choicesAllMatching=true);
  parameter SI.Temperature TAmb(displayUnit="degC")=293.15
    "Ambient temperature";
  parameter SI.Temperature TMass(displayUnit="degC")=313.15
    "Initial temperature of mass";
  output SI.TemperatureDifference dTMass=
    heatCapacitor.port.T-TAmb "Mass over Ambient";
  output SI.TemperatureDifference dTtoPipe=heatCapacitor.port.T-pipe.T_q
    "Mass over Coolant";
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
    m=0.1,
    T0=TAmb,
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
    C=0.1, T(start=TMass, fixed=true))
    annotation (Placement(transformation(
        origin={10,-60},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=1)
    annotation (Placement(transformation(
        origin={10,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  FluidHeatFlow.Examples.Utilities.DoubleRamp volumeFlow(
    offset=0,
    height_1=1,
    height_2=-2)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
equation
  connect(ambient1.flowPort, pump.flowPort_a)
    annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
  connect(pump.flowPort_b, pipe.flowPort_a)
    annotation (Line(points={{-20,0},{0,0}}, color={255,0,0}));
  connect(pipe.flowPort_b, ambient2.flowPort)
    annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
  connect(thermalConductor.port_a, heatCapacitor.port) annotation (Line(
        points={{10,-40},{10,-45},{10,-50}}, color={191,0,0}));
  connect(pipe.heatPort, thermalConductor.port_b)
    annotation (Line(points={{10,-10},{10,-20}}, color={191,0,0}));
  connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
      points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
annotation (Documentation(info="<html>
<p>
7th test example: OneMass
</p>
A thermal capacity is coupled with a coolant flow.
Different initial temperatures of thermal capacity and pipe's coolant get ambient's temperature,
the time behaviour depending on coolant flow.
</html>"),    experiment(StopTime=1.0, Interval=0.001));
end OneMass;
