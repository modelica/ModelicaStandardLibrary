within Modelica.Electrical.Analog.Examples;
model InvertingAmp "Inverting amplifier"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vps=+15 "Positive supply";
  parameter SI.Voltage Vns=-15 "Negative supply";
  parameter SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter SI.Frequency f=10 "Frequency of input voltage";
  parameter Real k=2 "Desired amplification";
  parameter SI.Resistance R1=1000 "Arbitrary resistance";
  parameter SI.Resistance R2=k*R1 "Calculated resistance to reach desired amplification k";
  Modelica.Electrical.Analog.Ideal.IdealOpAmpLimited opAmp(
    out(i(start=0, fixed=false)))
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
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
        origin={50,-20})));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=R1)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=R2)
    annotation (Placement(transformation(extent={{20,50},{0,70}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,0})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage vSourcePos(V=Vps) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,20})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage vSourceNeg(V=Vns) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-40,-20})));
equation
  connect(r1.n, r2.n) annotation (Line(
      points={{-20,60},{0,60}}, color={0,0,255}));
  connect(r2.n, opAmp.in_n) annotation (Line(
      points={{0,60},{-10,60},{-10,6},{0,6}}, color={0,0,255}));
  connect(r2.p, opAmp.out) annotation (Line(
      points={{20,60},{30,60},{30,0},{20,0}}, color={0,0,255}));
  connect(ground.p, opAmp.in_p) annotation (Line(
      points={{-10,-60},{-10,-6},{0,-6}}, color={0,0,255}));
  connect(vIn.p, r1.p) annotation (Line(
      points={{-80,10},{-80,60},{-40,60}}, color={0,0,255}));
  connect(ground.p, vIn.n) annotation (Line(
      points={{-10,-60},{-80,-60},{-80,-10}}, color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{-10,-60},{50,-60},{50,-30}}, color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
  connect(ground1.p, vSourcePos.n)
    annotation (Line(points={{-50,0},{-40,0},{-40,10}}, color={0,0,255}));
  connect(vSourcePos.p, opAmp.VMax)
    annotation (Line(points={{-40,30},{10,30},{10,10}}, color={0,0,255}));
  connect(vSourcePos.n, vSourceNeg.n)
    annotation (Line(points={{-40,10},{-40,-10}}, color={0,0,255}));
  connect(vSourceNeg.p, opAmp.VMin)
    annotation (Line(points={{-40,-30},{10,-30},{10,-10}}, color={0,0,255}));
  annotation (
    Documentation(info="<html>
<p>This is an inverting amplifier. Resistance R1 can be chosen, R2 is defined by the desired amplification k.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end InvertingAmp;
