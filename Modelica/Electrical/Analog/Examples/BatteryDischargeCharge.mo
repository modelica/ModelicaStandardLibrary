within Modelica.Electrical.Analog.Examples;
model BatteryDischargeCharge "Discharge and charge idealized battery"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Batteries.BatteryOCV_SOCtable battery(
    OCVmax=12,
    Qnom=36000,
    OCVmin=10,
    OCV_SOC=[0,0; 0.1,0.9; 1,1],
    Isc=1200,
    useHeatPort=false,
    SOC(fixed=true, start=0.99)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={20,0})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,0})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        table=[0,0; 60,1; 120,0; 180,1; 240,0; 300,1; 360,0;
        420,1; 480,0; 540,1; 600,0; 600,1; 660,0; 720,-1; 780,0;
        840,-1; 900,0; 960,-1; 1020,0; 1080,-1; 1140,0; 1200,-1;
        1260,0; 1320,-1; 1380,0; 1440,0],
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Modelica.Blocks.Continuous.FirstOrder
    firstOrder(
    k=98,
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Continuous.Integrator energy(u(unit="W"), y(unit="J"))
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
equation
  connect(battery.n, ground.p)
    annotation (Line(points={{20,-10},{20,-20},{0,-20}}, color={0,0,255}));
  connect(signalCurrent.n, ground.p)
    annotation (Line(points={{-20,-10},{-20,-20},{0,-20}}, color={0,0,255}));
  connect(combiTimeTable.y[1], firstOrder.u)
    annotation (Line(points={{-67,0},{-62,0}}, color={0,0,127}));
  connect(firstOrder.y, signalCurrent.i)
    annotation (Line(points={{-39,0},{-32,0}}, color={0,0,127}));
  connect(signalCurrent.p, powerSensor.pc) annotation (Line(points={{-20,10},
          {-20,40},{-10,40}}, color={0,0,255}));
  connect(powerSensor.nc, battery.p)
    annotation (Line(points={{10,40},{20,40},{20,10}}, color={0,0,255}));
  connect(powerSensor.nv, ground.p)
    annotation (Line(points={{0,30},{0,-20}}, color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv)
    annotation (Line(points={{-10,40},{-10,50},{0,50}}, color={0,0,255}));
  connect(powerSensor.power, energy.u)
    annotation (Line(points={{-10,29},{-10,20},{28,20}}, color={0,0,127}));
  annotation (experiment(
      StopTime=1440,
      Interval=0.1,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>An idealized battery with a nominal charge of 10 Ah is 99 % charged at the beginning.</p>
<p>It is first discharged with 6 current pulses of 98 A for 1 minute, and breaks between the pulses of 1 minute, reaching SOC = 0.01.</p>
<p>Subsequently, it is charged with 6 current pulses of 98 A for 1 minute, and breaks between the pulses of 1 minute, reaching SOC = 0.99 again.</p>
<p>Simulate and plot terminal voltage <code>battery.v</code> versus state of charge <code>battery.SOC</code>.<p>
<p>Note: Dependency of OCV on SOC can be chosen either linear (<code>useLinearSOCDependency=true</code>) or table based.</p>
<p>Plotting <code>energy.y</code>, it is remarkable that first energy is delivered by the battery, but then due to the losses more energy is consumed to recharge the battery.</p>
</html>"));
end BatteryDischargeCharge;
