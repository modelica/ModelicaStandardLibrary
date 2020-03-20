within Modelica.Thermal.FluidHeatFlow.Examples;
model TwoTanks "Two connected open tanks"
  extends Modelica.Icons.Example;
  output SI.VolumeFlowRate V_flow=pipe.V_flow "Volume flow rate tank 1 -> tank 2";
  output SI.Length level1=openTank1.level "Level in tank 1";
  output SI.Temperature T1(displayUnit="degC")=openTank1.TTank "Temperature in tank 1";
  output SI.Length level2=openTank2.level "Level in tank 2";
  output SI.Temperature T2(displayUnit="degC")=openTank2.TTank "Temperature in tank 2";
  FluidHeatFlow.Components.OpenTank openTank1(
    ATank=1,
    hTank=1,
    useHeatPort=false,
    g=10,
    level(fixed=true, start=0.9),
    T0=313.15,
    T0fixed=true,
    pAmbient=100000)
    annotation (Placement(transformation(extent={{-60,12},{-40,32}})));
  FluidHeatFlow.Components.OpenTank openTank2(
    ATank=1,
    hTank=1,
    useHeatPort=false,
    g=10,
    level(fixed=true, start=0.1),
    T0=293.15,
    T0fixed=true,
    pAmbient=100000)
    annotation (Placement(transformation(extent={{60,10},{40,30}})));
  FluidHeatFlow.Components.Pipe pipe(
    m=0,
    h_g=0,
    T0=293.15,
    V_flowLaminar=2,
    dpLaminar=10,
    V_flowNominal=4,
    dpNominal=30)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(openTank1.flowPort, pipe.flowPort_a)
    annotation (Line(points={{-50,12},{-50,0},{-10,0}}, color={255,0,0}));
  connect(pipe.flowPort_b, openTank2.flowPort)
    annotation (Line(points={{10,0},{50,0},{50,10}}, color={255,0,0}));
  annotation (experiment(StopTime=1.5),
    Documentation(info="<html>
<p>
Two tanks are connected with a pipe:
</p>
<ul>
<li>Tank 1: initial level = 0.9 m, T = 40&deg;C</li>
<li>Tank 2: initial level = 0.1 m, T = 20&deg;C</li>
</ul>
<p>
Within 1.5 s (dependent on the flow resistance of the pipe) the level = 0.5 m in both tanks is the same, medium flows from tank 1 to tank 2.
The temperature of tank 1 remains unchanged, the temperature of tank 2 is increased.
</p>
</html>"));
end TwoTanks;
