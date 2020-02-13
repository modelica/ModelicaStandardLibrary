within Modelica.Electrical.Analog.Examples.OpAmps;
model InvertingAmplifier "Inverting amplifier"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter SI.Frequency f=10 "Frequency of input voltage";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
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
        origin={-40,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={40,0})));
  OpAmpCircuits.Gain gain(k=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(vIn.p, gain.p1)
    annotation (Line(points={{-40,10},{-10,10}}, color={0,0,255}));
  connect(gain.n1, ground.p)
    annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
  connect(gain.n1, vIn.n)
    annotation (Line(points={{-10,-10},{-40,-10}}, color={0,0,255}));
  connect(gain.p2, vOut.n)
    annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
  connect(gain.n2, vOut.p)
    annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
  annotation (
    Documentation(info="<html>
<p>This is an inverting amplifier.</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end InvertingAmplifier;
