within Modelica.Electrical.Batteries.Examples;
model SuperCapDischargeCharge "Discharge and charge idealized supercap"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Batteries.Utilities.PulseSeries pulseSeries(
    n1=5,
    T1=10,
    Tp1=10,
    n2=5,
    Tp=10,
    startTime=10)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Electrical.Batteries.BatteryStacks.SuperCap superCap(
    Vnom=48,
    C=500,
    Rs=0.002,
    Idis=0.05,
    useHeatPort=false) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={40,0})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Modelica.Blocks.Continuous.Integrator energy(u(unit="W"), y(unit="J"))
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  Modelica.Blocks.Math.Gain gain(k=300)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
equation
  connect(superCap.n, ground.p) annotation (Line(points={{40,-10},{40,-20},
          {20,-20}}, color={0,0,255}));
  connect(signalCurrent.n, ground.p)
    annotation (Line(points={{0,-10},{0,-20},{20,-20}}, color={0,0,255}));
  connect(signalCurrent.p, powerSensor.pc)
    annotation (Line(points={{0,10},{0,40},{10,40}}, color={0,0,255}));
  connect(powerSensor.nc, superCap.p)
    annotation (Line(points={{30,40},{40,40},{40,10}}, color={0,0,255}));
  connect(powerSensor.nv, ground.p)
    annotation (Line(points={{20,30},{20,-20}}, color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv)
    annotation (Line(points={{10,40},{10,50},{20,50}}, color={0,0,255}));
  connect(powerSensor.power, energy.u)
    annotation (Line(points={{10,29},{10,20},{58,20}}, color={0,0,127}));
  connect(gain.y, signalCurrent.i) annotation (Line(points={{-29,0},{-12,0}}, color={0,0,127}));
  connect(pulseSeries.y, gain.u)
    annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  annotation (experiment(
      StopTime=720,
      Interval=0.01,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>A supercap with a capacitance of 500 F, starting initially at nominal voltage 48 V,
is discharged with 5 current pulses of 240 A for 10 seconds, and breaks between the pulses of 10 seconds.
Subsequently, the supercap is charged again with 5 current pulses of 240 A for 10 seconds, and breaks between the pulses of 10 seconds.
In the end, the supercap is in no-load condition to reveal self-discharge effects.
</p>
<p>
Note that self-discharge is set to an unrealistic high value, to show self-discharge within a rather short time span.<br>
The other parameters of the supercap is set to estimated but realistic values:
</p>
<ul>
<li><code>C = 500 F</code></li>
<li><code>Vnom = 48 V</code></li>
<li><code>Qnom = C*Vnom = 24,000 As</code></li>
<li><code>Ri = 2 m&Omega;</code></li>
</ul>
<p>Simulate and plot terminal voltage <code>supercap.v</code>.</p>
<p>
Plotting <code>energy.y</code>, it is remarkable that first energy is delivered by the supercap,
but then due to the losses more energy is consumed to recharge the supercap.
</p>
</html>"));
end SuperCapDischargeCharge;
