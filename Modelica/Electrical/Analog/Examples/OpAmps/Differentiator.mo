within Modelica.Electrical.Analog.Examples.OpAmps;
model Differentiator "Differentiating amplifier"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter SI.Frequency f=10 "Frequency of input voltage";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Sources.TrapezoidVoltage vIn(
    V=2*Vin,
    rising=0.2/f,
    width=0.3/f,
    falling=0.2/f,
    period=1/f,
    nperiod=-1,
    offset=-Vin,
    startTime=-(vIn.rising + vIn.width/2))
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={40,0})));
  OpAmpCircuits.Der der_(
    k=2,
    f=f,
    v(fixed=true))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(vIn.p, der_.p1)
    annotation (Line(points={{-40,10},{-10,10}}, color={0,0,255}));
  connect(vIn.n, der_.n1)
    annotation (Line(points={{-40,-10},{-10,-10}}, color={0,0,255}));
  connect(der_.n1, ground.p)
    annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
  connect(der_.p2, vOut.p)
    annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
  connect(der_.n2, vOut.n)
    annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is a (inverting) differentiating amplifier. Resistance R can be chosen, capacitance C is defined by the desired time constant resp. frequency.</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end Differentiator;
