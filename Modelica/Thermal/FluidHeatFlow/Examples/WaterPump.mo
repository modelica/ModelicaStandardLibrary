within Modelica.Thermal.FluidHeatFlow.Examples;
model WaterPump "Water pumping station"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  output SI.VolumeFlowRate V_flow=volumeFlowSensor.y "Volume flow rate";
  output SI.Pressure p(displayUnit="bar")=pressureSensor.y "Pressure at pump outlet";
  output SI.AngularVelocity w(displayUnit="1/min")=multiSensor.w "Pump speed";
  output SI.Torque tau=multiSensor.tau "Pump torque";
  output SI.Power power=multiSensor.power "Pump power";
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    period=2,
    nperiod=1,
    offset=0,
    rising=0.6,
    width=0.6,
    falling=0.6,
    startTime=0.1,
    amplitude=1.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-70,-50})));
  Modelica.Blocks.Math.Gain gain(k=idealPump.wNominal)
    annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Mechanics.Rotational.Sensors.MultiSensor multiSensor(w(displayUnit="1/min"))
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  FluidHeatFlow.Sources.Ambient ambient1(
    medium=FluidHeatFlow.Media.Water(),
    constantAmbientPressure=100000,
    constantAmbientTemperature=293.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={50,-80})));
  FluidHeatFlow.Sources.IdealPump idealPump(
    medium=FluidHeatFlow.Media.Water(),
    m=0,
    V_flow0=0.18,
    T0=293.15,
    wNominal=104.71975511966,
    dp0=500000) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={50,-50})));
  FluidHeatFlow.Sensors.VolumeFlowSensor volumeFlowSensor(medium=
        FluidHeatFlow.Media.Water()) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={50,-20})));
  FluidHeatFlow.Sensors.PressureSensor pressureSensor(medium=
        FluidHeatFlow.Media.Water()) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,0})));
  FluidHeatFlow.Components.OneWayValve oneWayValve(
    medium=FluidHeatFlow.Media.Water(),
    m=0,
    frictionLoss=0,
    T0=293.15,
    V_flowNominal=0.18,
    dpForward=10000,
    dpNominal=500000,
    V_flowBackward=1e-6) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={50,20})));
  FluidHeatFlow.Components.Pipe pipe(
    m=0,
    V_flowLaminar=0.09,
    V_flowNominal=0.18,
    h_g=25,
    medium=FluidHeatFlow.Media.Water(),
    T0=293.15,
    dpLaminar=10000,
    dpNominal=30000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,50})));
  FluidHeatFlow.Sources.Ambient ambient2(
    medium=FluidHeatFlow.Media.Water(),
    constantAmbientPressure=100000,
    constantAmbientTemperature=293.15) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={50,82})));
equation
  connect(idealPump.flowPort_a, ambient1.flowPort)
    annotation (Line(points={{50,-60},{50,-70}}, color={255,0,0}));
  connect(speed.flange, multiSensor.flange_a)
    annotation (Line(points={{0,-50},{10,-50}}));
  connect(oneWayValve.flowPort_a, volumeFlowSensor.flowPort_b)
    annotation (Line(points={{50,10},{50,-10}}, color={255,0,0}));
  connect(volumeFlowSensor.flowPort_a, idealPump.flowPort_b)
    annotation (Line(points={{50,-30},{50,-40}}, color={255,0,0}));
  connect(ambient2.flowPort, pipe.flowPort_b)
    annotation (Line(points={{50,72},{50,60}}, color={255,0,0}));
  connect(pipe.flowPort_a, oneWayValve.flowPort_b)
    annotation (Line(points={{50,40},{50,30}}, color={255,0,0}));
  connect(multiSensor.flange_b, idealPump.flange_a)
    annotation (Line(points={{30,-50},{40,-50}}));
  connect(oneWayValve.flowPort_a, pressureSensor.flowPort)
    annotation (Line(points={{50,10},{50,0},{30,0}}, color={255,0,0}));
  connect(gain.y, speed.w_ref)
    annotation (Line(points={{-29,-50},{-22,-50}}, color={0,0,127}));
  connect(trapezoid.y, gain.u)
    annotation (Line(points={{-59,-50},{-52,-50}}, color={0,0,127}));
  annotation (experiment(
      StopTime=2,
      Interval=0.001,
      Tolerance=1e-06), Documentation(
        info="<html>
<p>
There are two reservoirs at ambient pressure, the second one 25 m higher than the first one.
The ideal pump is driven by a speed source, starting from zero and going up to 1.2 times nominal speed.
To avoid water flowing back, the one way valve is used.
</p>
</html>"));
end WaterPump;
