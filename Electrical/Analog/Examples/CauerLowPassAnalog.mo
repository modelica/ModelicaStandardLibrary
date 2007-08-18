within Modelica.Electrical.Analog.Examples;
model CauerLowPassAnalog "Cauer low pass filter with analog components" 
  annotation (uses(Modelica(version="2.2")), Diagram(
      Rectangle(extent=[-62,32; -58,28], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=75,
          rgbfillColor={85,85,255})),
      Rectangle(extent=[-2,28; 2,32], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=75,
          rgbfillColor={85,85,255})),
      Rectangle(extent=[58,32; 62,28], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=75,
          rgbfillColor={85,85,255})),
      Rectangle(extent=[58,-48; 62,-52], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=75,
          rgbfillColor={85,85,255})),
      Rectangle(extent=[-2,-48; 2,-52], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=75,
          rgbfillColor={85,85,255})),
      Rectangle(extent=[-62,-48; -58,-52], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=75,
          rgbfillColor={85,85,255})),
                    Text(extent=[-110,116; 100,64], string="CauerLowPassAnalog")),
    Coordsys(extent=[-200,-100; 200,100]),
    experiment(StopTime=60),
    experimentSetupOutput,
    Documentation(revisions="<html>
<ul>
<li><i>January 13, 2006</i> 
       by Christoph Clauss<br>
       included into Modelica Standard Library</li>
<li><i>September 15, 2005</i>
       by Peter Trappe designed and by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</html>", info="<html>
 
<p>
The example Cauer Filter is a low-pass-filter of the fifth order. It is realized
using an analog network. The voltage source V is the input voltage (step),
and the R2.p.v is the filter output voltage. The pulse response is calculated.
<p>
The simulation end time should be 60. Please plot both V.p.v (input voltage) and R2.p.v (output voltage). 
<p>
</html>"),
      Icon(
      Rectangle(extent=[-80,-90; 100,60],    style(fillColor=7)),
      Polygon(points=[-80,60; -60,80; 120,80; 100,60; -80,60],       style(
            fillColor=7)),
      Polygon(points=[120,80; 120,-70; 100,-90; 100,60; 120,80],     style(
            fillColor=7)),
      Text(
        extent=[-76,13; 97,-39],
        string="Example",
        style(color=3)),
      Text(
        extent=[-100,142; 140,83],
        string="%name",
        style(color=1))));
  parameter Modelica.SIunits.Inductance l1=1.304;
  parameter Modelica.SIunits.Inductance l2=0.8586;
  parameter Modelica.SIunits.Capacitance c1=1.072;
  parameter Modelica.SIunits.Capacitance c2=1/(1.704992^2*l1);
  parameter Modelica.SIunits.Capacitance c3=1.682;
  parameter Modelica.SIunits.Capacitance c4=1/(1.179945^2*l2);
  parameter Modelica.SIunits.Capacitance c5=0.7262;
  Modelica.Electrical.Analog.Basic.Ground G 
    annotation (extent=[-10,-90; 10,-70]);
  Modelica.Electrical.Analog.Basic.Capacitor C1(C=c1) 
    annotation (extent=[-70,-30; -50,-10], rotation=270);
  Modelica.Electrical.Analog.Basic.Capacitor C2(C=c2) 
    annotation (extent=[-40,20; -20,40]);
  Modelica.Electrical.Analog.Basic.Capacitor C3(C=c3) 
    annotation (extent=[-10,-30; 10,-10],  rotation=270);
  Modelica.Electrical.Analog.Basic.Capacitor C4(C=c4) 
    annotation (extent=[20,20; 40,40]);
  Modelica.Electrical.Analog.Basic.Capacitor C5(C=c5) 
    annotation (extent=[50,-30; 70,-10], rotation=270);
  Modelica.Electrical.Analog.Basic.Inductor L1(L=l1) 
    annotation (extent=[-40,60; -20,80]);
  Modelica.Electrical.Analog.Basic.Inductor L2(L=l2) 
    annotation (extent=[20,60; 40,80]);
  Modelica.Electrical.Analog.Basic.Resistor R1 
    annotation (extent=[-100,20; -80,40]);
  Modelica.Electrical.Analog.Basic.Resistor R2 
    annotation (extent=[90,-30; 110,-10], rotation=270);
  Modelica.Electrical.Analog.Sources.StepVoltage V(startTime=1, offset=0) 
    annotation (extent=[-110,-20; -90,0], rotation=270);
equation 
  connect(R1.n,C1. p) annotation (points=[-80,30; -60,30; -60,-10], style(color=
         3, rgbcolor={0,0,255}));
  connect(C1.n,G. p) annotation (points=[-60,-30; -60,-50; 0,-50; 0,-70], style(
        color=3, rgbcolor={0,0,255}));
  connect(R1.n,C2. p) 
    annotation (points=[-80,30; -40,30], style(color=3, rgbcolor={0,0,255}));
  connect(L1.p,C2. p) 
    annotation (points=[-40,70; -40,30], style(color=3, rgbcolor={0,0,255}));
  connect(L1.p,C1. p) annotation (points=[-40,70; -40,30; -60,30; -60,-10],
      style(color=3, rgbcolor={0,0,255}));
  connect(L1.n,C2. n) 
    annotation (points=[-20,70; -20,30], style(color=3, rgbcolor={0,0,255}));
  connect(C2.n,C3. p) annotation (points=[-20,30; 1.83697e-015,30;
        1.83697e-015,-10],
              style(color=3, rgbcolor={0,0,255}));
  connect(C2.n,C4. p) 
    annotation (points=[-20,30; 20,30], style(color=3, rgbcolor={0,0,255}));
  connect(L1.n,C3. p) annotation (points=[-20,70; -20,30; 1.83697e-015,30;
        1.83697e-015,-10], style(color=3, rgbcolor={0,0,255}));
  connect(L1.n,C4. p) annotation (points=[-20,70; -20,30; 20,30], style(color=3,
        rgbcolor={0,0,255}));
  connect(L2.p,C4. p) 
    annotation (points=[20,70; 20,30], style(color=3, rgbcolor={0,0,255}));
  connect(C2.n,L2. p) annotation (points=[-20,30; 20,30; 20,70], style(color=3,
        rgbcolor={0,0,255}));
  connect(C3.p,L2. p) annotation (points=[1.83697e-015,-10; 0,-10; 0,30; 20,
        30; 20,70],
                style(color=3, rgbcolor={0,0,255}));
  connect(L2.n,C4. n) 
    annotation (points=[40,70; 40,30], style(color=3, rgbcolor={0,0,255}));
  connect(L2.n,C5. p) annotation (points=[40,70; 40,30; 60,30; 60,-10], style(
        color=3, rgbcolor={0,0,255}));
  connect(L2.n,R2. p) annotation (points=[40,70; 40,30; 100,30; 100,-10], style(
        color=3, rgbcolor={0,0,255}));
  connect(R2.n,G. p) annotation (points=[100,-30; 100,-50; 0,-50; 0,-70], style(
        color=3, rgbcolor={0,0,255}));
  connect(C4.n,C5. p) annotation (points=[40,30; 60,30; 60,-10], style(color=3,
        rgbcolor={0,0,255}));
  connect(C4.n,R2. p) annotation (points=[40,30; 100,30; 100,-10], style(color=
          3, rgbcolor={0,0,255}));
  connect(C3.n,G. p) annotation (points=[-1.83697e-015,-30; 0,-30; 0,-70],
      style(color=3, rgbcolor={0,0,255}));
  connect(C5.n,G. p) annotation (points=[60,-30; 60,-50; 0,-50; 0,-70], style(
        color=3, rgbcolor={0,0,255}));
  connect(C1.n,C3. n) annotation (points=[-60,-30; -60,-50; 0,-50; 0,-30;
        -1.83697e-015,-30], style(color=3, rgbcolor={0,0,255}));
  connect(C1.n,C5. n) annotation (points=[-60,-30; -60,-50; 60,-50; 60,-30],
      style(color=3, rgbcolor={0,0,255}));
  connect(R2.n,C5. n) annotation (points=[100,-30; 100,-50; 60,-50; 60,-30],
      style(color=3, rgbcolor={0,0,255}));
  connect(R2.n,C3. n) annotation (points=[100,-30; 100,-50; 0,-50; 0,-30;
        -1.83697e-015,-30], style(color=3, rgbcolor={0,0,255}));
  connect(R2.n,C1. n) annotation (points=[100,-30; 100,-50; -60,-50; -60,-30],
      style(color=3, rgbcolor={0,0,255}));
  connect(C5.p,R2. p) annotation (points=[60,-10; 60,30; 100,30; 100,-10],
      style(
      color=3,
      rgbcolor={0,0,255},
      fillColor=75,
      rgbfillColor={85,85,255},
      fillPattern=1));
  connect(R1.p, V.p) 
    annotation (points=[-100,30; -100,0], style(color=3, rgbcolor={0,0,255}));
  connect(V.n, G.p)            annotation (points=[-100,-20; -100,-70; 0,-70],
      style(color=3, rgbcolor={0,0,255}));
end CauerLowPassAnalog;
