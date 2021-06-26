within Modelica.Electrical.Analog.Examples.Lines;
model LightningLosslessTransmissionLine
  "Lightning on a lossless transmission line"
  extends Modelica.Icons.Example;
  import Modelica.Units.SI;
  import Modelica.Constants.small;
  parameter SI.Resistance Rload=200 "Load resistance";
  parameter Real r(final min=small, final unit="Ohm/m")=25e-6 "Resistance per meter";
  parameter Real g(final min=small, final unit="S/m")=15e-12 "Conductance per meter";
  parameter Real l(final min=small, final unit="H/m")=1e-6 "Inductance per meter";
  parameter Real c(final min=small, final unit="F/m")=15e-12 "Capacitance per meter";
  parameter SI.Length len=100e3 "Length of line";
  parameter SI.Velocity c0=1/sqrt(l*c) "Speed of EM wave";
  parameter SI.Time td=len/c0 "Transmission delay";
  parameter SI.Impedance z0=sqrt(l/c) "Characteristic impedance for very high frequency";
  Modelica.Electrical.Analog.Lines.TLine line1(Z0=z0,
    TD=td/2,
    er(start=0),
    v2(start=0))
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Electrical.Analog.Lines.TLine line2(Z0=z0,
    TD=td/2,
    er(start=0),
    v2(start=0))
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
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
    startTime=0.02) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,10})));
equation
  connect(line1.p1, source.p)
    annotation (Line(points={{-40,20},{-60,20}}, color={0,0,255}));
  connect(line2.p2, load.p)
    annotation (Line(points={{40,20},{60,20}}, color={0,0,255}));
  connect(source.n, ground.p) annotation (Line(points={{-60,-3.55271e-15},{-60,
          -10},{0,-10}}, color={0,0,255}));
  connect(ground.p, load.n)
    annotation (Line(points={{0,-10},{60,-10},{60,-3.55271e-15}},
                                                         color={0,0,255}));
  connect(source.n, line1.n1)
    annotation (Line(points={{-60,0},{-40,0}}, color={0,0,255}));
  connect(line2.n2, load.n)
    annotation (Line(points={{40,0},{60,0}}, color={0,0,255}));
  connect(line1.n2, lightningImpulseCurrent.p) annotation (Line(points={{-20,0},{10,0}}, color={0,0,255}));
  connect(lightningImpulseCurrent.p, line2.n1) annotation (Line(points={{10,0},{20,0}}, color={0,0,255}));
  connect(line1.p2, lightningImpulseCurrent.n) annotation (Line(points={{-20,20},{10,20}}, color={0,0,255}));
  connect(lightningImpulseCurrent.n, line2.p1) annotation (Line(points={{10,20},{20,20}}, color={0,0,255}));
  connect(ground.p, lightningImpulseCurrent.p) annotation (Line(points={{0,-10},{10,-10},{10,0}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.025,
      Interval=1e-06,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
This example shows what happens when a lightning hits a transmission line.
We consider a lossless single-phase equivalent circuit with two parts of the transmission line, each 50 km long.
The RMS voltage is 380 kV / &#x221A;3, the RMS load current is roughly 1090 A.
Realistic parameters of the 380 kV transmission line are used.
Note that after the source starts, the traveling wave arrives at the load 350 &micro;s later.
After 20 ms, a lightning (10/350 &micro;s) with an amplitude of 10 kA hits the transmission line just in the middle.
Note that the traveling wave hits source and load approximately 200 &micro;s after the lightning hits the transmission line.
Plot voltage and current at the load. Without overvoltage protection, the load would be destroyed.
One could compare the results with that obtained by using a <a href=\"modelica://Modelica.Electrical.Analog.Examples.Lines.LightningSegmentedTransmissionLine\">transmission line model taking losses into account</a>.
</p>
</html>",
        revisions="<html>
<ul>
<li><em>May, 2021</em>
        implemented by Anton Haumer, Technical University of Applied Sciences Regensburg
</li>
</ul>
</html>"));
end LightningLosslessTransmissionLine;
