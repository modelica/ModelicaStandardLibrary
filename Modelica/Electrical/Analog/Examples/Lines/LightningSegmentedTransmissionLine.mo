within Modelica.Electrical.Analog.Examples.Lines;
model LightningSegmentedTransmissionLine
  "Lightning on a segmented transmission line"
  extends Modelica.Icons.Example;
  import Modelica.Units.SI;
  import Modelica.Constants.small;
  parameter SI.Resistance Rload=200 "Load resistance";
  parameter Real r(final min=small, final unit="Ohm/m")=25e-6 "Resistance per meter";
  parameter Real g(final min=small, final unit="S/m")=15e-12 "Conductance per meter";
  parameter Real l(final min=small, final unit="H/m")=1e-6 "Inductance per meter";
  parameter Real c(final min=small, final unit="F/m")=15e-12 "Capacitance per meter";
  parameter SI.Length len=100e3 "Length of line";
  parameter Integer N=100 "Number of segments";
  Modelica.Electrical.Analog.Lines.OLine line1(
    r=r,
    l=l,
    g=g,
    c=c,
    length=len/2,
    N=N)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Electrical.Analog.Lines.OLine line2(
    r=r,
    l=l,
    g=g,
    c=c,
    length=len/2,
    N=N)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Sources.SineVoltage source(V=380e3*sqrt(2/3), f=50) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,10})));
  Basic.Resistor load(R=Rload) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,10})));
  Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Sources.LightningImpulseCurrent lightningImpulseCurrent(
    approximation=Modelica.Electrical.Analog.Types.ImpulseApproximation.Heidler,
    I=10e3,
    startTime=0.02)                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,10})));
initial equation
  line1.v=zeros(N);
  line1.i=zeros(N + 1);
  line2.v=zeros(N);
  line2.i[2:N + 1]=zeros(N);
equation
  connect(line1.p1, source.p)
    annotation (Line(points={{-40,20},{-60,20}}, color={0,0,255}));
  connect(line2.p2, load.p)
    annotation (Line(points={{40,20},{60,20}}, color={0,0,255}));
  connect(source.n, ground.p) annotation (Line(points={{-60,0},{-60,
          -10},{0,-10}}, color={0,0,255}));
  connect(ground.p, load.n)
    annotation (Line(points={{0,-10},{60,-10},{60,0}}, color={0,0,255}));
  connect(line1.p2, lightningImpulseCurrent.n) annotation (Line(points={{-20,20},
          {0,20}},                                                                         color={0,0,255}));
  connect(lightningImpulseCurrent.n, line2.p1) annotation (Line(points={{0,20},{
          20,20}},                                                                        color={0,0,255}));
  connect(ground.p, lightningImpulseCurrent.p) annotation (Line(points={{0,-10},
          {0,0}},                                                                                 color={0,0,255}));
  connect(ground.p, line1.p3)
    annotation (Line(points={{0,-10},{-30,-10},{-30,10}}, color={0,0,255}));
  connect(ground.p, line2.p3)
    annotation (Line(points={{0,-10},{30,-10},{30,10}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.025,
      Interval=1e-06,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
This example shows what happens when a lightning hits a transmission line.
We consider a segmented single-phase equivalent circuit taking losses into account with two parts of the transmission line, each 50 km long.
The RMS voltage is 380 kV / &#x221A;3, the RMS load current is roughly 1090 A.
Realistic parameters of the 380 kV transmission line are used.
Note that after the source starts, the traveling wave arrives at the load 350 &micro;s later.
After 20 ms, a lightning (10/350 &micro;s) with an amplitude of 10 kA hits the transmission line just in the middle.
Note that the traveling wave hits source and load approximately 200 &micro;s after the lightning hits the transmission line.
Plot voltage and current at the load. Without overvoltage protection, the load would be destroyed.
Note that using a sparse solver saves some simulation time.
Using a <a href=\"modelica://Modelica.Electrical.Analog.Examples.Lines.LightningLosslessTransmissionLine\">lossless transmission line model</a> simulates even much quicker.
</p>
</html>",
        revisions="<html>
<ul>
<li><em>May, 2021</em>
        implemented by Anton Haumer, Technical University of Applied Sciences Regensburg
</li>
</ul>
</html>"));
end LightningSegmentedTransmissionLine;
