within Modelica.Thermal.FluidHeatFlow.Examples;
model TestOpenTank "Test the OpenTank model"
  extends Modelica.Icons.Example;
  output SI.VolumeFlowRate V_flow=volumeFlow.V_flow "Volume flow rate to tank";
  output SI.Length level=openTank.level "Level in tank";
  output SI.Temperature T(displayUnit="degC")=openTank.TTank "Temperature in tank";
  FluidHeatFlow.Components.OpenTank openTank(
    ATank=1,
    hTank=1,
    useHeatPort=false,
    pAmbient=0,
    g=10,
    level(fixed=true, start=0.5),
    T0=313.15,
    T0fixed=true)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  FluidHeatFlow.Sources.Ambient ambient(constantAmbientPressure=0,
      constantAmbientTemperature=293.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-60})));
  FluidHeatFlow.Sources.VolumeFlow volumeFlow(
    m=0,
    useVolumeFlowInput=true,
    constantVolumeFlow=1,
    T0=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0; 0.5,0; 0.5,-1; 0.75, -1; 0.75,1; 1,1; 1,0; 1.5,0])
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(combiTimeTable.y[1], volumeFlow.volumeFlow)
    annotation (Line(points={{-19,0},{-10,0}}, color={0,0,127}));
  connect(openTank.flowPort, volumeFlow.flowPort_b)
    annotation (Line(points={{0,50},{0,10}}, color={255,0,0}));
  connect(volumeFlow.flowPort_a, ambient.flowPort)
    annotation (Line(points={{0,-10},{0,-50}}, color={255,0,0}));
  annotation (experiment(StopTime=1.5),
    Documentation(info="<html>
<p>
First, the medium is pumped out of the tank (initial level = 0.5 m, T = 40&deg;C) to an (infinite) ambient (T = 20&deg;C):
</p>
<ul>
<li>The level of the medium in the tank decreases.</li>
<li>The temperature of the medium in the tank remains unchanged.</li>
</ul>
<p>
Subsequently the medium is pumped into the tank from an (infinite) ambient:
</p>
<ul>
<li>The level of the medium in the tank increases again.</li>
<li>The temperature of the medium in the tank decreases (mixing temperature).</li>
</ul>
</html>"));
end TestOpenTank;
