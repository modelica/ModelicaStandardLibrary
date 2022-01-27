within Modelica.Electrical.Analog.Examples.Lines;
model CompareLosslessLines
  "Compare lossless lines with different load"
  extends Modelica.Icons.Example;
  import Modelica.Units.SI;
  import Modelica.Constants.small;
  parameter Real l(final min=small, final unit="H/m")=250e-9 "Inductance per meter";
  parameter Real c(final min=small, final unit="F/m")=100e-12 "Capacitance per meter";
  parameter SI.Length len=1 "Length of line";
  parameter SI.Velocity c0=1/sqrt(l*c) "Speed of EM wave";
  parameter SI.Time td=len/c0 "Transmission delay";
  parameter SI.Impedance z0=sqrt(l/c) "Characteristic impedance";
  Sources.SignalVoltage source1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-30,60})));
  Basic.Resistor ri1(R=z0)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Basic.Ground ground1
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Modelica.Electrical.Analog.Lines.TLine line1(Z0=z0, TD=td,
    er(start=0),
    v2(start=0))
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  Ideal.Idle load1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={48,60})));
  Sources.SignalVoltage source2 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-30,0})));
  Basic.Resistor ri2(R=z0)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Basic.Ground ground2
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Electrical.Analog.Lines.TLine line2(
    Z0=z0,
    TD=td,
    er(start=0),
    v2(start=0))
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Basic.Resistor load2(R=z0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,0})));
  Sources.SignalVoltage source3 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-30,-60})));
  Basic.Ground ground3
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  Modelica.Electrical.Analog.Lines.TLine line3(
    Z0=z0,
    TD=td,
    er(start=0),
    v2(start=0))
    annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  Basic.Resistor ri3(R=z0)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Ideal.Short load3 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-60})));
  Blocks.Sources.Pulse pulse(
    amplitude=10,
    width=50,
    period=td,
    nperiod=1,
    startTime=td/2)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(source1.n, ground1.p)
    annotation (Line(points={{-30,50},{-30,40},{20,40}}, color={0,0,255}));
  connect(source1.n, line1.n1)
    annotation (Line(points={{-30,50},{10,50}}, color={0,0,255}));
  connect(line1.p2, load1.p)
    annotation (Line(points={{30,70},{48,70}}, color={0,0,255}));
  connect(line1.n2, load1.n)
    annotation (Line(points={{30,50},{48,50}}, color={0,0,255}));
  connect(source2.n, ground2.p)
    annotation (Line(points={{-30,-10},{-30,-20},{20,-20}}, color={0,0,255}));
  connect(source2.n, line2.n1)
    annotation (Line(points={{-30,-10},{10,-10}}, color={0,0,255}));
  connect(line2.p2, load2.p)
    annotation (Line(points={{30,10},{50,10}}, color={0,0,255}));
  connect(line2.n2, load2.n)
    annotation (Line(points={{30,-10},{50,-10}}, color={0,0,255}));
  connect(source3.n, ground3.p)
    annotation (Line(points={{-30,-70},{-30,-80},{20,-80}}, color={0,0,255}));
  connect(source3.n, line3.n1)
    annotation (Line(points={{-30,-70},{10,-70}}, color={0,0,255}));
  connect(line3.p2, load3.p)
    annotation (Line(points={{30,-50},{50,-50}}, color={0,0,255}));
  connect(line3.n2, load3.n)
    annotation (Line(points={{30,-70},{50,-70}}, color={0,0,255}));
  connect(pulse.y, source2.v)
    annotation (Line(points={{-69,0},{-42,0}}, color={0,0,127}));
  connect(pulse.y, source1.v) annotation (Line(points={{-69,0},{-60,0},{-60,60},
          {-42,60}}, color={0,0,127}));
  connect(pulse.y, source3.v) annotation (Line(points={{-69,0},{-60,0},{-60,-60},
          {-42,-60}}, color={0,0,127}));
  connect(load1.n, ground1.p)
    annotation (Line(points={{48,50},{48,40},{20,40}}, color={0,0,255}));
  connect(load2.n, ground2.p)
    annotation (Line(points={{50,-10},{50,-20},{20,-20}}, color={0,0,255}));
  connect(load3.n, ground3.p)
    annotation (Line(points={{50,-70},{50,-80},{20,-80}}, color={0,0,255}));
  connect(source1.p, ri1.p)
    annotation (Line(points={{-30,70},{-20,70}}, color={0,0,255}));
  connect(ri1.n, line1.p1)
    annotation (Line(points={{0,70},{10,70}}, color={0,0,255}));
  connect(source2.p, ri2.p)
    annotation (Line(points={{-30,10},{-20,10}}, color={0,0,255}));
  connect(ri2.n, line2.p1)
    annotation (Line(points={{0,10},{6,10},{6,10},{10,10}}, color={0,0,255}));
  connect(source3.p, ri3.p)
    annotation (Line(points={{-30,-50},{-20,-50}}, color={0,0,255}));
  connect(ri3.n, line3.p1)
    annotation (Line(points={{0,-50},{10,-50}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=2e-08,
      Interval=1e-10,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
This example compares three lossless lines with different loads.
Inductance per meter (l=250&nbsp;nH/m) and capacitance per meter (c=100&nbsp;pF/m) are estimated for an average coaxial cable with characteristic impedance z0=&radic;(l/c)=50&nbsp;&Omega;.
The speed of the electromagnetic wave is given by c0=1/&radic;(l*c)=2*10<sup>8</sup>&nbsp;m/s. Using a cable with a length of len=1&nbsp;m, we obtain a delay td=len/c0=5&nbsp;ns.
The sources impress a single voltage pulse with height=10&nbsp;V and length=td/2, starting at td/2.
Due to the inner resistances of the sources ri=z0 the pulse at the input of the line (<code>v1</code>) has a height of 5&nbsp;V.
Simulate for 20&nbsp;ns and compare for each of the lines: <code>v1</code>, <code>v2</code> and <code>i1</code>, <code>i2</code>.
</p>
<h4>1. load = idle</h4>
<p>
The voltage pulse at the beginning of the line (<code>line1.v1</code>) starts at 2.5&nbsp;ns and lasts for 2.5&nbsp;ns. It arrives at 7.5&nbsp;ns at the end of the line (<code>line1.v2</code>),
and is reflected giving a pulse of 10&nbsp;V (superposition of arriving and reflected pulse).
At 12.5&nbsp;ns the reflected pulse arrives at the beginning of the line, with a height of 5&nbsp;V (voltage divider of z0 and ri).
Bear in mind that the source voltage is zero at that time, i.e. a short.
The current at the end of the line (<code>line1.i2</code>) is zero since the load is implemented as an idle.
The current at the beginning of the line, <code>line1.i1</code>, is 5&nbsp;V/z0=100&nbsp;mA at 2.5&nbsp;mA and 12.5&nbsp;ns.
</p>
<h4>2. load = z0</h4>
<p>
The voltage pulse at the beginning of the line (<code>line2.v1</code>) starts at 2.5&nbsp;ns and lasts for 2.5&nbsp;ns. It arrives at 7.5&nbsp;ns at the end of the line (<code>line2.v2</code>).
Due to load resistance=z0 no reflection occurs.
The current at the beginning of the line, <code>line2.i1</code>, is 5&nbsp;V/z0=100&nbsp;mA at 2.5&nbsp;ns.
The current at the end of the line, <code>line2.i2</code> is -5&nbsp;V/z0=100&nbsp;mA at 7.5&nbsp;ns.
</p>
<h4>3. load = short</h4>
<p>
The voltage pulse at the beginning of the line (<code>line3.v1</code>) starts at 2.5&nbsp;ns and lasts for 2.5&nbsp;ns.
Since the load is implemented as a short, the voltage at the end of the line (<code>line3.v2</code>) is zero.
This is possible due to a reflection with negative sign, i.e. the superposition of arriving and reflected pulse gives zero.
The reflected voltage pulse arrives at 12.5&nbsp;ns at the beginning of the line.
The current pulse at the beginning of the line (<code>line3.i1</code>) is 5&nbsp;V/z0=100&nbsp;mA at 2.5 ns.
At the end of the line (<code>line3.i2</code>) a reflection occurs at 7.5&nbsp;ns giving a current pulse of 200&nbsp;mA (superposition of arriving and reflected pulse).
The reflected pulse (100&nbsp;mA) arrives at 12.5&nbsp;ns at the beginning of the line (<code>line3.i1</code>).
</p>
</html>",
        revisions="<html>
<ul>
<li><em>May, 2021</em>
        implemented by Anton Haumer, Technical University of Applied Sciences Regensburg
</li>
</ul>
</html>"));
end CompareLosslessLines;
