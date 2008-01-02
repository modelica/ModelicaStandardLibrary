model Rectifier "B6 diode bridge" 
  extends Modelica.Icons.Example;
  import Modelica.Electrical.Analog.Ideal;
  parameter Modelica.SIunits.Voltage VAC=400 "RMS line-to-line";
  parameter Modelica.SIunits.Frequency f=50 "line frequency";
  parameter Modelica.SIunits.Inductance LAC=60E-6 "line inductor";
  parameter Modelica.SIunits.Resistance Roff=1E-3 "diode forward resistance";
  parameter Modelica.SIunits.Conductance Gon=1E-3 "diode backward conductance";
  parameter Modelica.SIunits.Voltage Vknee=2 "diode threshold voltage";
  parameter Modelica.SIunits.Capacitance CDC=15E-3 "DC capacitance";
  parameter Modelica.SIunits.Current IDC=500 "load current";
  output Modelica.SIunits.Voltage uDC;
  output Modelica.SIunits.Current iAC[3];
  output Modelica.SIunits.Voltage uAC[3];
  output Modelica.SIunits.Power Losses;
  
annotation (
  Diagram(
    Text(
      extent=[-80, 90; 80, 70],
      string="Rectifier",
      style(color=0, rgbcolor={0,0,0})),
    Line(points=[-16, 18; -16, 2; -18, 6; -14, 6; -16, 2], style(
          color=0, rgbcolor={0,0,0})),
    Line(points=[-30, 22; -26, 20; -30, 18; -30, 22], style(color=0,
          rgbcolor={0,0,0})),
    Line(points=[32, 30; 32, -30; 30, -26; 34, -26; 32, -30], style(
          color=0, rgbcolor={0,0,0})),
    Text(
      extent=[-38, 16; -22, 8],
      string="iAC",
      style(color=0, rgbcolor={0,0,0})),
    Text(
      extent=[-14, 8; 2, 0],
      string="uAC",
      style(color=0, rgbcolor={0,0,0})),
    Text(
      extent=[22, -16; 38, -24],
      string="uDC",
      style(color=0, rgbcolor={0,0,0}))),
  experiment(StopTime=0.1, Interval=1e-005),
  experimentSetupOutput(
    doublePrecision=true,
    states=false,
    derivatives=false,
    inputs=false,
    auxiliaries=false),
  Documentation(info="<HTML>
<P>
The rectifier example shows a B6 diode bridge fed by a three phase sinusoidal voltage, loaded by a DC current.<br>
DC capacitors start at ideal no-load voltage, thus making easier initial transient.
</P>
<P>
Simulate until T=0.1 s.<br><br>
Plot in separate windows:<br><br>
uDC ... DC-voltage<br>
iAC ... AC-currents 1..3<br>
uAC ... AC-voltages 1..3 (distorted)<br>
Try different load currents iDC = 0..approximately 500 A.
</P>
<p>
You may watch Losses (of the whole diode bridge) trying different diode parameters.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Mai 7, 2004   </i>
       by Anton Haumer<br> realized<br>
       </li>
</ul>
</HTML>
"));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(freqHz=f,
       V=VAC*sqrt(2/3)) 
                      annotation (extent=[-70, 10; -90, 30]);
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage2(
    freqHz=f,
    phase=-2/3*Modelica.Constants.pi,
    V=VAC*sqrt(2/3)) 
                   annotation (extent=[-70, -10; -90, 10]);
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage3(
    freqHz=f,
    phase=-4/3*Modelica.Constants.pi,
    V=VAC*sqrt(2/3)) 
                   annotation (extent=[-70, -30; -90, -10]);
  Modelica.Electrical.Analog.Basic.Inductor Inductor1(L=LAC) 
  annotation (extent=[-60, 10; -40, 30]);
  Modelica.Electrical.Analog.Basic.Inductor Inductor2(L=LAC) 
  annotation (extent=[-60, -10; -40, 10]);
  Modelica.Electrical.Analog.Basic.Inductor Inductor3(L=LAC) 
  annotation (extent=[-60, -30; -40, -10]);
  Ideal.IdealDiode IdealDiode1(
    Roff=Roff,
    Gon=Gon,
    Vknee=Vknee) 
               annotation (extent=[-30, 30; -10, 50], rotation=90);
  Ideal.IdealDiode IdealDiode2(
    Roff=Roff,
    Gon=Gon,
    Vknee=Vknee) 
               annotation (extent=[-10, 30; 10, 50], rotation=90);
  Ideal.IdealDiode IdealDiode3(
    Roff=Roff,
    Gon=Gon,
    Vknee=Vknee) 
               annotation (extent=[10, 30; 30, 50], rotation=90);
  Ideal.IdealDiode IdealDiode4(
    Roff=Roff,
    Gon=Gon,
    Vknee=Vknee) 
               annotation (extent=[-30, -50; -10, -30], rotation=90);
  Ideal.IdealDiode IdealDiode5(
    Roff=Roff,
    Gon=Gon,
    Vknee=Vknee) 
               annotation (extent=[-10, -50; 10, -30], rotation=90);
  Ideal.IdealDiode IdealDiode6(
    Roff=Roff,
    Gon=Gon,
    Vknee=Vknee) 
               annotation (extent=[10, -50; 30, -30], rotation=90);
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=2*CDC) 
  annotation (extent=[30, 30; 50, 50], rotation=-90);
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor2(C=2*CDC) 
  annotation (extent=[30, -50; 50, -30], rotation=-90);
  Modelica.Electrical.Analog.Basic.Ground Ground1 
  annotation (extent=[40, -80; 60, -60]);
  Modelica.Electrical.Analog.Sources.SignalCurrent SignalCurrent1 
  annotation (extent=[50, -10; 70, 10], rotation=-90);
  Modelica.Blocks.Sources.Constant Constant1(k={IDC}) 
  annotation (extent=[100, -10; 80, 10], rotation=0);
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
                                        annotation (points=[-90, 20;
      -90, 0], style(color=3, rgbcolor={0,0,255}));
  connect(SineVoltage2.n, SineVoltage3.n) 
                                        annotation (points=[-90, 0; -90,
       -20], style(color=3, rgbcolor={0,0,255}));
  connect(SineVoltage1.p, Inductor1.p) 
                                     annotation (points=[-70, 20; -60,
       20], style(color=3, rgbcolor={0,0,255}));
  connect(SineVoltage2.p, Inductor2.p) 
                                     annotation (points=[-70, 0; -60,
       0], style(color=3, rgbcolor={0,0,255}));
  connect(SineVoltage3.p, Inductor3.p) 
                                     annotation (points=[-70, -20; -60,
       -20], style(color=3, rgbcolor={0,0,255}));
  connect(IdealDiode1.p, IdealDiode4.n) 
                                      annotation (points=[-20, 30; -20,
       -30], style(color=3, rgbcolor={0,0,255}));
  connect(IdealDiode2.p, IdealDiode5.n) 
                                      annotation (points=[-6.12303e-016,30; 0,
        16; 1.76911e-022,0; 6.12303e-016,0; 6.12303e-016,-30],
     style(color=3, rgbcolor={0,0,255}));
  connect(IdealDiode3.p, IdealDiode6.n) 
                                      annotation (points=[20, 30; 20,
       -30], style(color=3, rgbcolor={0,0,255}));
  connect(IdealDiode1.n, IdealDiode2.n) 
                                      annotation (points=[-20,50; 6.12303e-016,
        50],             style(color=3, rgbcolor={0,0,255}));
  connect(IdealDiode2.n, IdealDiode3.n) 
                                      annotation (points=[6.12303e-016,50; 20,
        50],                     style(color=3, rgbcolor={0,0,255}));
  connect(IdealDiode4.p, IdealDiode5.p) 
                                      annotation (points=[-20,-50;
        -6.12303e-016,-50],
             style(color=3, rgbcolor={0,0,255}));
  connect(IdealDiode5.p, IdealDiode6.p) 
                                      annotation (points=[-6.12303e-016,-50; 20,
        -50],         style(color=3, rgbcolor={0,0,255}));
  connect(Capacitor2.n, IdealDiode6.p) 
                                     annotation (points=[40, -50; 20,
       -50], style(color=3, rgbcolor={0,0,255}));
  connect(IdealDiode3.n, Capacitor1.p) 
                                     annotation (points=[20, 50; 40,
      50], style(color=3, rgbcolor={0,0,255}));
  connect(Capacitor1.n, Capacitor2.p) 
                                    annotation (points=[40, 30; 40, -30],
     style(color=3, rgbcolor={0,0,255}));
  connect(Capacitor2.p, Ground1.p) 
                                 annotation (points=[40, -30; 40, 0;
      50, 0; 50, -60], style(color=3, rgbcolor={0,0,255}));
  connect(Capacitor1.p, SignalCurrent1.p) 
                                        annotation (points=[40, 50;
      60, 50; 60, 10], style(color=3, rgbcolor={0,0,255}));
  connect(SignalCurrent1.n, Capacitor2.n) 
                                        annotation (points=[60, -10;
      60, -50; 40, -50], style(color=3, rgbcolor={0,0,255}));
  connect(Constant1.outPort, SignalCurrent1.inPort) 
                                                  annotation (points=[79,0; 79,
        0.05; 67.05,0.05],            style(color=3, rgbcolor={0,0,
        255}));
  connect(Inductor1.n, IdealDiode1.p) 
                                    annotation (points=[-40, 20; -20,
       20; -20, 30], style(color=3, rgbcolor={0,0,255}));
  connect(Inductor2.n, IdealDiode2.p) 
                                    annotation (points=[-40,0; -6.12303e-016,0;
        -6.12303e-016,30],    style(color=3, rgbcolor={0,0,255}));
  connect(Inductor3.n, IdealDiode3.p) 
                                    annotation (points=[-40, -20; 20,
       -20; 20, 30], style(color=3, rgbcolor={0,0,255}));
end Rectifier;
