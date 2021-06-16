within Modelica.Electrical.Analog.Examples.Lines;
model OscilloscopeProbe "Demonstrate 10:1 probe at an oscilloscope"
  extends Modelica.Icons.Example;
  import Modelica.Units.SI;
  import Modelica.Constants.small;
  parameter Real attenuation=10 "Attenuation factor";
  parameter SI.Resistance RProbe=(attenuation - 1)*ROsci "Resistance of probe";
  parameter SI.Capacitance CProbe=ROsci/RProbe*(COsci + len*c) "Capacitance of probe";
  parameter SI.Length len=1 "Length of line";
  parameter Real r(final min=small, final unit="Ohm/m")=25e-3 "resistance per meter";
  parameter Real c(final min=small, final unit="F/m")=100e-12 "Capacitance per meter";
  parameter Integer N=10 "Number of lumped segments";
  parameter SI.Resistance ROsci=1e6 "Resistance of oscilloscope";
  parameter SI.Capacitance COsci=20e-12 "Capacitance of oscilloscope";
  Modelica.Electrical.Analog.Sources.PulseVoltage pulseVoltage(V=100, width=50,
    period=1e-3,
    startTime=0.5e-3)
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,0})));
  Modelica.Electrical.Analog.Basic.Resistor ri(R=50)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor rProbe(R=RProbe)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Modelica.Electrical.Analog.Basic.Capacitor cProbe(C=CProbe)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Electrical.Analog.Lines.ULine      line(
    r=r,
    c=c,
    length=len,
    N=N)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Electrical.Analog.Basic.Resistor rOsci(R=ROsci)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,0})));
  Modelica.Electrical.Analog.Basic.Capacitor cOsci(C=COsci)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor oscilloscope annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,0})));
initial equation
  cProbe.v=0;
  line.C.v=zeros(N);
  cOsci.v=0;
equation
  connect(pulseVoltage.n, ground.p)
    annotation (Line(points={{-80,-10},{-80,-20}}, color={0,0,255}));
  connect(rOsci.p, oscilloscope.p)
    annotation (Line(points={{50,10},{80,10}}, color={0,0,255}));
  connect(rOsci.n, oscilloscope.n)
    annotation (Line(points={{50,-10},{80,-10}}, color={0,0,255}));
  connect(ri.p, pulseVoltage.p)
    annotation (Line(points={{-80,30},{-80,10}}, color={0,0,255}));
  connect(rProbe.p, cProbe.p)
    annotation (Line(points={{-50,40},{-50,20}}, color={0,0,255}));
  connect(rProbe.n, cProbe.n)
    annotation (Line(points={{-30,40},{-30,20},{-30,20}}, color={0,0,255}));
  connect(cOsci.p, rOsci.p)
    annotation (Line(points={{30,10},{50,10}}, color={0,0,255}));
  connect(cOsci.n, rOsci.n)
    annotation (Line(points={{30,-10},{50,-10}}, color={0,0,255}));
  connect(ground.p, rOsci.n) annotation (Line(points={{-80,-20},{40,-20},{40,-10},
          {50,-10}}, color={0,0,255}));
  connect(line.p2, rOsci.p) annotation (Line(points={{10,30},{40,30},{40,10},{50,
          10}}, color={0,0,255}));
  connect(line.p1, cProbe.n)
    annotation (Line(points={{-10,30},{-30,30},{-30,20}}, color={0,0,255}));
  connect(line.p3, rOsci.n) annotation (Line(points={{0,20},{0,-20},{40,-20},{40,
          -10},{50,-10}}, color={0,0,255}));
  connect(ri.n, cProbe.p)
    annotation (Line(points={{-60,30},{-50,30},{-50,20}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.01,
      Interval=1e-06,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
An oscilloscope (input impedance <code>R<sub>Osci</sub>=1 M&Omega;, C<sub>Osci</sub>=20 pF</code>) is connected
via a coaxial cable (<code>len=1 m, c=100 pF/m</code>)
to a probe (attenuation factor 10:1, i.e. <code>R<sub>Probe</sub>=9*R<sub>Osci</sub></code>).
The impedance of the probe has to be balanced <code>C<sub>Probe</sub>*R<sub>Probe</sub>=R<sub>Osci</sub>*(C<sub>Osci</sub> + len*c)</code> to preserve the signal shape (1 kHz pulse).
Note that the resistance of the cable is neglectible. The source needs a (small) inner resistance.
</p>
</html>",
        revisions="<html>
<ul>
<li><em>May, 2021</em>
        implemented by Anton Haumer, Technical University of Applied Sciences Regensburg
</li>
</ul>
</html>"));
end OscilloscopeProbe;
