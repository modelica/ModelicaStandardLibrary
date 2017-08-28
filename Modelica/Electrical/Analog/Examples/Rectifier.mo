within Modelica.Electrical.Analog.Examples;
model Rectifier "B6 diode bridge"
  extends Modelica.Icons.Example;
  import Modelica.Electrical.Analog.Ideal;
  parameter SI.Voltage VAC=400 "RMS line-to-line";
  parameter SI.Frequency f=50 "line frequency";
  parameter SI.Inductance LAC=60E-6 "line inductor";
  parameter SI.Resistance Ron=1E-3 "diode forward resistance";
  parameter SI.Conductance Goff=1E-3 "diode backward conductance";
  parameter SI.Voltage Vknee=2 "diode threshold voltage";
  parameter SI.Capacitance CDC=15E-3 "DC capacitance";
  parameter SI.Current IDC=500 "load current";
  output SI.Voltage uDC;
  output SI.Current iAC[3];
  output SI.Voltage uAC[3];
  output SI.Power Losses;

  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(freqHz=f,
       V=VAC*sqrt(2/3))
                      annotation (Placement(transformation(extent={{-70,10},{
            -90,30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage2(
    freqHz=f,
    phase=-2/3*Modelica.Constants.pi,
    V=VAC*sqrt(2/3))
                   annotation (Placement(transformation(extent={{-70,-10},{-90,
            10}})));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage3(
    freqHz=f,
    phase=-4/3*Modelica.Constants.pi,
    V=VAC*sqrt(2/3))
                   annotation (Placement(transformation(extent={{-70,-30},{-90,
            -10}})));
  Modelica.Electrical.Analog.Basic.Inductor Inductor1(L=LAC)
  annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Electrical.Analog.Basic.Inductor Inductor2(L=LAC, i(start=0, fixed=true))
  annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Electrical.Analog.Basic.Inductor Inductor3(L=LAC, i(start=0, fixed=true))
  annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Ideal.IdealDiode IdealDiode1(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={-20,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Ideal.IdealDiode IdealDiode2(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={0,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Ideal.IdealDiode IdealDiode3(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={20,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Ideal.IdealDiode IdealDiode4(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={-20,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Ideal.IdealDiode IdealDiode5(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={0,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Ideal.IdealDiode IdealDiode6(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={20,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=2*CDC)
  annotation (Placement(transformation(
        origin={40,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor2(C=2*CDC)
  annotation (Placement(transformation(
        origin={40,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground Ground1
  annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent SignalCurrent1
  annotation (Placement(transformation(
        origin={60,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant Constant1(k=IDC)
  annotation (Placement(transformation(extent={{100,-10},{80,10}})));
initial equation
  Capacitor1.v = VAC*sqrt(2)/2;
  Capacitor2.v = VAC*sqrt(2)/2;
equation
  uDC = Capacitor1.v + Capacitor2.v;
  iAC = {Inductor1.i,Inductor2.i,Inductor3.i};
  uAC[1] = Inductor1.n.v - Inductor2.n.v;
  uAC[2] = Inductor2.n.v - Inductor3.n.v;
  uAC[3] = Inductor3.n.v - Inductor1.n.v;
  Losses = IdealDiode1.v*IdealDiode1.i + IdealDiode2.v*IdealDiode2.i +
    IdealDiode3.v*IdealDiode3.i + IdealDiode4.v*IdealDiode4.i +
    IdealDiode5.v*IdealDiode5.i + IdealDiode6.v*IdealDiode6.i;
  connect(SineVoltage1.n, SineVoltage2.n)
    annotation (Line(points={{-90,20},{-90,0}}, color={0,0,255}));
  connect(SineVoltage2.n, SineVoltage3.n)
    annotation (Line(points={{-90,0},{-90,-20}}, color={0,0,255}));
  connect(SineVoltage1.p, Inductor1.p)
    annotation (Line(points={{-70,20},{-60,20}}, color={0,0,255}));
  connect(SineVoltage2.p, Inductor2.p)
    annotation (Line(points={{-70,0},{-67.5,0},{-65,0},{-60,0}}, color={0,0,255}));
  connect(SineVoltage3.p, Inductor3.p)
    annotation (Line(points={{-70,-20},{-60,-20}}, color={0,0,255}));
  connect(IdealDiode1.p, IdealDiode4.n)
    annotation (Line(points={{-20,30},{-20,-30}}, color={0,0,255}));
  connect(IdealDiode2.p, IdealDiode5.n)
    annotation (Line(points={{0,30},{0,16},{0,0},{0,-30}}, color={0,0,255}));
  connect(IdealDiode3.p, IdealDiode6.n)
    annotation (Line(points={{20,30},{20,-30}}, color={0,0,255}));
  connect(IdealDiode1.n, IdealDiode2.n)
    annotation (Line(points={{-20,50},{0,50}}, color={0,0,255}));
  connect(IdealDiode2.n, IdealDiode3.n)
    annotation (Line(points={{0,50},{20,50}}, color={0,0,255}));
  connect(IdealDiode4.p, IdealDiode5.p)
    annotation (Line(points={{-20,-50},{0,-50}}, color={0,0,255}));
  connect(IdealDiode5.p, IdealDiode6.p)
    annotation (Line(points={{0,-50},{20,-50}}, color={0,0,255}));
  connect(Capacitor2.n, IdealDiode6.p)
    annotation (Line(points={{40,-50},{20,-50}}, color={0,0,255}));
  connect(IdealDiode3.n, Capacitor1.p)
    annotation (Line(points={{20,50},{40,50}}, color={0,0,255}));
  connect(Capacitor1.n, Capacitor2.p)
    annotation (Line(points={{40,30},{40,-30}}, color={0,0,255}));
  connect(Capacitor2.p, Ground1.p)
    annotation (Line(points={{40,-30},{40,0},{50,0},{50,-60}}, color={0,0,255}));
  connect(Capacitor1.p, SignalCurrent1.p)
    annotation (Line(points={{40,50},{60,50},{60,10}}, color={0,0,255}));
  connect(SignalCurrent1.n, Capacitor2.n)
    annotation (Line(points={{60,-10},{60,-50},{40,-50}}, color={0,0,255}));
  connect(Constant1.y, SignalCurrent1.i)
    annotation (Line(points={{79,0},{79,0},{67,0}}, color={0,0,255}));
  connect(Inductor1.n, IdealDiode1.p)
    annotation (Line(points={{-40,20},{-20,20},{-20,30}}, color={0,0,255}));
  connect(Inductor2.n, IdealDiode2.p)
    annotation (Line(points={{-40,0},{0,0},{0,30}}, color={0,0,255}));
  connect(Inductor3.n, IdealDiode3.p)
    annotation (Line(points={{-40,-20},{20,-20},{20,30}}, color={0,0,255}));
annotation (
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-80,90},{80,70}},
          textString="Rectifier"),
        Line(points={{-16,18},{-16,2},{-18,6},{-14,6},{-16,2}}),
        Line(points={{-30,22},{-26,20},{-30,18},{-30,22}}),
        Line(points={{32,30},{32,-30},{30,-26},{34,-26},{32,-30}}),
        Text(
          extent={{-38,16},{-22,8}},
          textString="iAC"),
        Text(
          extent={{-14,8},{2,0}},
          textString="uAC"),
        Text(
          extent={{22,-16},{38,-24}},
          textString="uDC")}),
  experiment(StopTime=0.1, Interval=1e-005),
  Documentation(info="<html>
<p>The rectifier example shows a B6 diode bridge fed by a three-phase sinusoidal voltage, loaded by a DC current.
DC capacitors start at ideal no-load voltage, thus making easier initial transient.</p>
<p>Simulate until T=0.1 s. Plot in separate windows:
<br>uDC ... DC-voltage
<br>iAC ... AC-currents 1..3
<br>uAC ... AC-voltages 1..3 (distorted)
<br>Try different load currents iDC = 0..approximately 500 A. You may watch losses (of the whole diode bridge) trying different diode parameters.</p>
</html>",
   revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>Mai 7, 2004   </em>
       by Anton Haumer<br> realized<br>
       </li>
</ul>
</html>"));
end Rectifier;
