within Modelica.Electrical.Analog.Examples.OpAmps;
model VoltageFollower "Reproduce input voltage"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vps=+15 "Positive supply";
  parameter SI.Voltage Vns=-15 "Negative supply";
  parameter SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter SI.Frequency f=10 "Frequency of input voltage";
  parameter SI.Resistance Ri=1
    "Inner resistance of input voltage source";
  parameter SI.Resistance Rl=1 "Load resistance";
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
    Vps=Vps,
    Vns=Vns,
    v_in(start=0))
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
    V=2*Vin,
    rising=0.2/f,
    width=0.3/f,
    falling=0.2/f,
    period=1/f,
    nperiod=-1,
    offset=-Vin,
    startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,-20})));
  Modelica.Electrical.Analog.Basic.Resistor ri(R=Ri)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Electrical.Analog.Basic.Resistor rl(R=Rl) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-18})));
equation
  connect(ground.p, vIn.n) annotation (Line(
      points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{20,0},{60,0},{60,-10}}, color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{-10,-80},{60,-80},{60,-30}}, color={0,0,255}));
  connect(opAmp.out, opAmp.in_n) annotation (Line(
      points={{20,0},{30,0},{30,20},{-10,20},{-10,6},{0,6}}, color={0,0,255}));
  connect(vIn.p, ri.p) annotation (Line(
      points={{-80,10},{-60,10}}, color={0,0,255}));
  connect(ri.n, opAmp.in_p) annotation (Line(
      points={{-40,10},{-20,10},{-20,-6},{0,-6}}, color={0,0,255}));
  connect(opAmp.out, rl.p) annotation (Line(
      points={{20,0},{30,0},{30,-8}}, color={0,0,255}));
  connect(ground.p, rl.n) annotation (Line(
      points={{-10,-80},{30,-80},{30,-28}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is a voltage follower. It reproduces the input voltage at the output without loading the input voltage source with a stiff output.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end VoltageFollower;
