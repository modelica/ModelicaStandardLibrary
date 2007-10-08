within Modelica.Electrical.Analog.Examples;
model CauerLowPassSC 
  "Cauer low-pass filter with operational amplifiers and switched capacitors" 
model Rn 
    
  parameter Real clock=1;
  parameter Modelica.SIunits.Resistance R(min=Modelica.Constants.eps)=1 "Resistance";
  Modelica.Blocks.Sources.BooleanPulse BooleanPulse1(period=clock) 
    annotation (extent=[-10,50; 10,70]);
  annotation (
    uses(Modelica(version="2.2")),
    Diagram,
    Icon(
      Bitmap(extent=[-62,6; -62,14], name=""),
      Rectangle(extent=[-80,32; 80,-30], style(pattern=0)),
      Text(
        extent=[-30,-40; 30,-72],
        string="R=%R",
        style(
          color=0,
          rgbcolor={0,0,0},
          fillPattern=1)),
      Line(points=[-74,0; -80,0; -60,0], style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[-80,-20; -60,-20; -60,-16; -40,-8; -4,-8],
                                                            style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[80,0; 60,0], style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[-60,2; -60,-4], style(
          color=60,
          rgbcolor={170,255,170},
          fillPattern=1)),
      Line(points=[-4,2; -4,-18],  style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[4,2; 4,-18],  style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Text(
        extent=[-60,80; 60,40],
        style(
          color=3,
          rgbcolor={0,0,255},
          fillPattern=1),
        string="%name"),
      Line(points=[-92,0; -80,0], style(
          color=75,
          rgbcolor={85,85,255},
          fillPattern=1)),
      Line(points=[90,0; 80,0; 80,0], style(
          color=75,
          rgbcolor={85,85,255},
          fillPattern=1)),
      Line(points=[4,-8; 40,-8; 60,-4], style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[60,0; 60,-4], style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[60,-16; 60,-20; 80,-20], style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1))));
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=clock/R) 
    annotation (extent=[-20,-20; 20,20]);
  Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch IdealCommutingSwitch1 
    annotation (extent=[-60,-10; -40,10],  rotation=180);
  Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch IdealCommutingSwitch2 
    annotation (extent=[40,-10; 60,10]);
  Modelica.Electrical.Analog.Basic.Ground Ground1 
    annotation (extent=[-66,-32; -54,-20],
                                         rotation=0);
  Modelica.Electrical.Analog.Basic.Ground Ground2 
    annotation (extent=[54,-32; 66,-20]);
  Modelica.Electrical.Analog.Interfaces.NegativePin n1 
    annotation (extent=[-112,-10; -92,10]);
  Modelica.Electrical.Analog.Interfaces.NegativePin n2 
    annotation (extent=[90,-8; 110,12]);
equation 
  connect(IdealCommutingSwitch1.p,Capacitor1. p) annotation (points=[-40,
          -1.22461e-015; -42,-1.22461e-015; -44,0; -20,0],
                                                         style(color=3,
        rgbcolor={0,0,255}));
  connect(Capacitor1.n,IdealCommutingSwitch2. p) 
    annotation (points=[20,0; 40,0], style(color=3, rgbcolor={0,0,255}));
  connect(IdealCommutingSwitch2.control,BooleanPulse1. y) annotation (points=[50,
        8; 50,30; 20,30; 20,60; 11,60],
                              style(color=5, rgbcolor={255,0,255}));
  connect(IdealCommutingSwitch1.control,BooleanPulse1. y) annotation (points=[
        -50,-8; -50,30; 20,30; 20,60; 11,60],  style(color=5, rgbcolor={255,0,
          255}));
  connect(Ground2.p,IdealCommutingSwitch2. n2) annotation (points=[60,-20; 60,0],
                                      style(color=3, rgbcolor={0,0,255}));
  connect(IdealCommutingSwitch2.n1,n2)  annotation (points=[60,5; 80,5; 80,2;
        100,2], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(n1, IdealCommutingSwitch1.n2) annotation (points=[-102,0; -81,0; -81,
          1.22461e-015; -60,1.22461e-015],
                                         style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(Ground1.p, IdealCommutingSwitch1.n1) annotation (points=[-60,-20; -60,
          -5],
             style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
end Rn;
  
model Rp 
  annotation (uses(Modelica(version="2.2")), Diagram,
    Icon(
      Bitmap(extent=[-62,4; -62,12], name=""),
      Rectangle(extent=[-80,30; 80,-32], style(pattern=0)),
      Line(points=[-92,0; -80,0], style(
          color=75,
          rgbcolor={85,85,255},
          fillPattern=1)),
      Line(points=[80,0; 92,0], style(
          color=75,
          rgbcolor={85,85,255},
          fillPattern=1)),
      Text(
        extent=[-40,-40; 32,-72],
        string="R=%R",
        style(
          color=0,
          rgbcolor={0,0,0},
          fillPattern=1)),
      Line(points=[-74,0; -80,0; -60,0], style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[-80,-20; -60,-20; -60,-16; -40,-10; -4,-10],
                                                            style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[4,-10; 40,-10; 60,-16; 60,-20; 80,-20],
                                                       style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[80,0; 60,0], style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[60,0; 60,-4], style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[-60,0; -60,-6], style(
          color=60,
          rgbcolor={170,255,170},
          fillPattern=1)),
      Line(points=[-4,0; -4,-20],  style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Line(points=[4,0; 4,-20],  style(
          color=59,
          rgbcolor={85,255,85},
          fillPattern=1)),
      Text(
        extent=[-60,80; 60,40],
        style(
          color=3,
          rgbcolor={0,0,255},
          fillPattern=1),
        string="%name")));
  parameter Real clock=1;
  parameter Modelica.SIunits.Resistance R(min=Modelica.Constants.eps)=1 "Resistance";
  Modelica.Blocks.Sources.BooleanPulse BooleanPulse1(period=clock) 
    annotation (extent=[-10,50; 10,70]);
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=clock/R) 
    annotation (extent=[-20,-20; 20,20]);
  Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch IdealCommutingSwitch1 
    annotation (extent=[-60,-10; -40,10],  rotation=180);
  Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch IdealCommutingSwitch2 
    annotation (extent=[40,-10; 60,10]);
  Modelica.Electrical.Analog.Basic.Ground Ground1 
    annotation (extent=[-64,40; -54,52], rotation=180);
  Modelica.Electrical.Analog.Basic.Ground Ground2 
    annotation (extent=[56,-44; 66,-32]);
  Modelica.Electrical.Analog.Interfaces.NegativePin n1 
    annotation (extent=[-112,-10; -92,10]);
  Modelica.Electrical.Analog.Interfaces.NegativePin n2 
    annotation (extent=[90,-8; 110,12]);
equation 
  connect(IdealCommutingSwitch1.p, Capacitor1.p) annotation (points=[-40,
          -1.22461e-015; -42,-1.22461e-015; -44,0; -20,0],
                                                         style(color=3,
        rgbcolor={0,0,255}));
  connect(Capacitor1.n, IdealCommutingSwitch2.p) 
    annotation (points=[20,0; 40,0], style(color=3, rgbcolor={0,0,255}));
  connect(IdealCommutingSwitch2.control, BooleanPulse1.y) annotation (points=[50,
        8; 50,30; 20,30; 20,60; 11,60],
                              style(color=5, rgbcolor={255,0,255}));
  connect(IdealCommutingSwitch1.control, BooleanPulse1.y) annotation (points=[
        -50,-8; -50,30; 20,30; 20,60; 11,60],  style(color=5, rgbcolor={255,0,
          255}));
  connect(Ground1.p, IdealCommutingSwitch1.n2) annotation (points=[-59,40; -60,
          40; -60,1.22461e-015],               style(color=3, rgbcolor={0,0,255}));
  connect(Ground2.p, IdealCommutingSwitch2.n2) annotation (points=[61,-32; 60,
        -32; 60,0],                   style(color=3, rgbcolor={0,0,255}));
  connect(IdealCommutingSwitch1.n1, n1) annotation (points=[-60,-5; -99,-5; -99,
          0; -102,0],
                    style(color=3, rgbcolor={0,0,255}));
  connect(IdealCommutingSwitch2.n1, n2) annotation (points=[60,5; 80,5; 80,2;
        100,2], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
end Rp;
  annotation (
    Coordsys(extent=[-250,-200; 250,200]),
    uses(Modelica(version="2.2")),
    Diagram(        Text(extent=[-100,180; 94,140], string="CauerLowPassSC")),
    experiment(StopTime=60, NumberOfIntervals=1500),
    experimentSetupOutput,
    Documentation(revisions="<html>
<ul>
<li><i>January 13, 2006</i> 
       by Christoph Clauss<br>
       included into Modelica Standard Library</li>
<li><i>September 15, 2005</i>
       by by Peter Trappe designed and by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</html>", info="<html>
The example CauerLowPassSC is a low-pass-filter of the fifth order. It is realized
using an switched-capacitor network with operational amplifiers. The voltage source V is the input voltage (step),
and the OP5.out.v is the filter output voltage. The pulse response is calculated.
<p>
This model is identical to the CauerLowPassAnalog example, but inverting. To get the same response
as that of the CauerLowPassAnalog example, a negative voltage step is used as input.
<p>
This model is identical to the CauerLowPassOPV example. But the resistors are realized by
switched capacitors. There are two such resistors Rp (of value +1), and Rn (of value -1).
In this models the switching clock source is included. In a typical switched capacitor circuit
there would be a central clock source.
<p>
The simulation end time should be 60. Please plot both V.v (which is the inverted input voltage) and OP5.p.v (output voltage). Compare this result with the CauerLowPassAnalog result.
<p>
Due to the recharging of the capacitances after switching the performance of simulation is not as good as in the CauerLowPassOPV example.
<p>
</html>"),
    Icon(
      Rectangle(extent=[-100,-100; 80,50],   style(fillColor=7)),
      Polygon(points=[-100,50; -80,70; 100,70; 80,50; -100,50],      style(
            fillColor=7)),
      Polygon(points=[100,70; 100,-80; 80,-100; 80,50; 100,70],      style(
            fillColor=7)),
      Text(
        extent=[-96,3; 77,-49],
        string="Example",
        style(color=3)),
      Text(
        extent=[-120,132; 120,73],
        string="%name",
        style(color=1))));
  parameter Real l1=1.304;
  parameter Real l2=0.8586;
  parameter Real c1=1.072;
  parameter Real c2=1/(1.704992^2*l1);
  parameter Real c3=1.682;
  parameter Real c4=1/(1.179945^2*l2);
  parameter Real c5=0.7262;
  Modelica.Electrical.Analog.Basic.Capacitor C1(C=c1 + c2) 
    annotation (extent=[-193,30; -173,50], rotation=0);
  Modelica.Electrical.Analog.Basic.Capacitor C2(C=c2) 
    annotation (extent=[-241,-70; -221,-50]);
  Modelica.Electrical.Analog.Basic.Capacitor C3(C=l1) 
    annotation (extent=[-91,30; -71,50],   rotation=0);
  Modelica.Electrical.Analog.Basic.Capacitor C4(C=c4) 
    annotation (extent=[-31,50; -11,70]);
  Modelica.Electrical.Analog.Basic.Capacitor C5(C=c2) 
    annotation (extent=[-31,-100; -11,-80],
                                         rotation=0);
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op1 
    annotation (extent=[-201,-50; -161,-10]);
  Modelica.Electrical.Analog.Basic.Ground G 
    annotation (extent=[-189,-76; -175,-60]);
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op2 
    annotation (extent=[-101,-50; -61,-10]);
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op3 
    annotation (extent=[5,-50; 45,-10]);
  Modelica.Electrical.Analog.Basic.Ground G1 
    annotation (extent=[-88,-76; -74,-60]);
  Modelica.Electrical.Analog.Basic.Capacitor C6(C=c2 + c3 + c4) 
    annotation (extent=[8,30; 28,50],    rotation=0);
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op4 
    annotation (extent=[99,-50; 139,-10]);
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op5 
    annotation (extent=[199,-50; 239,-10]);
  Modelica.Electrical.Analog.Basic.Capacitor C7(C=l2) 
    annotation (extent=[109,30; 129,50], rotation=0);
  Modelica.Electrical.Analog.Basic.Capacitor C8(C=c4) 
    annotation (extent=[159,-130; 179,-110],
                                         rotation=0);
  Modelica.Electrical.Analog.Basic.Capacitor C9(C=c4 + c5) 
    annotation (extent=[207,10; 227,30], rotation=0);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n1 
    annotation (extent=[-215,-22; -211,-18]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n2 
    annotation (extent=[-215,18; -211,22]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n3 
    annotation (extent=[-215,38; -211,42]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n4 
    annotation (extent=[-159,42; -163,38], rotation=180);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n5 
    annotation (extent=[-115,-32; -111,-28]);
protected 
  Modelica.Electrical.Analog.Interfaces.PositivePin p1 
    annotation (extent=[-155,-122; -149,-118]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n6 
    annotation (extent=[-63,38; -59,42]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n7 
    annotation (extent=[-7,-32; -3,-28]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n8 
    annotation (extent=[-7,18; -3,22]);
protected 
  Modelica.Electrical.Analog.Interfaces.PositivePin p2 
    annotation (extent=[-7,38; -3,42]);
protected 
  Modelica.Electrical.Analog.Interfaces.PositivePin out1 
    annotation (extent=[43,-122; 47,-118]);
protected 
  Modelica.Electrical.Analog.Interfaces.PositivePin p3 
    annotation (extent=[57,78; 61,82]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n9 
    annotation (extent=[85,18; 89,22]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n10 
    annotation (extent=[85,-32; 89,-28]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n11 
    annotation (extent=[137,38; 141,42]);
public 
  Modelica.Electrical.Analog.Basic.Ground G2 
    annotation (extent=[11,-76; 25,-60]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n12 
    annotation (extent=[237,58; 241,62]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n13 
    annotation (extent=[237,18; 241,22]);
protected 
  Modelica.Electrical.Analog.Interfaces.PositivePin p4 
    annotation (extent=[187,18; 193,22]);
protected 
  Modelica.Electrical.Analog.Interfaces.NegativePin n14 
    annotation (extent=[187,-32; 193,-28]);
public 
  Modelica.Electrical.Analog.Basic.Ground G3 
    annotation (extent=[112,-76; 126,-60]);
  Modelica.Electrical.Analog.Basic.Ground G4 
    annotation (extent=[212,-76; 226,-60]);
  Modelica.Electrical.Analog.Sources.StepVoltage V(startTime=1) 
    annotation (extent=[-251,-160; -231,-140], rotation=90);
  Modelica.Electrical.Analog.Basic.Ground Ground1 
    annotation (extent=[-247,-182; -235,-170]);
  Rn R4(clock=0.1) annotation (extent=[-140,-40; -120,-20]);
  Rn R5(clock=0.1) annotation (extent=[-140,-80; -120,-60]);
  Rn R8(clock=0.1) annotation (extent=[60,10; 80,30]);
  Rn R9(clock=0.1) annotation (extent=[60,-40; 80,-20]);
  Rp R1(clock=0.1) annotation (extent=[-240,-30; -220,-10]);
  Rp R2(clock=0.1) annotation (extent=[-240,10; -220,30]);
  Rp R3(clock=0.1) annotation (extent=[-200,70; -180,90]);
  Rp Rp1(clock=0.1) annotation (extent=[-32,10; -12,30]);
  Rp R7(clock=0.1) annotation (extent=[-32,-40; -12,-20]);
  Rp R10(clock=0.1) annotation (extent=[160,-40; 180,-20]);
  Rp R11(clock=0.1) annotation (extent=[208,50; 228,70]);
equation 
  connect(Op1.in_p,G. p) annotation (points=[-201,-40; -201,-50; -181,-50; -181,
        -60; -182,-60], style(color=3, rgbcolor={0,0,255}));
  connect(G1.p,Op2. in_p) annotation (points=[-81,-60; -81,-50; -101,-50; -101,
        -40], style(color=3, rgbcolor={0,0,255}));
  connect(n1,Op1. in_n) annotation (points=[-213,-20; -201,-20], style(color=3,
        rgbcolor={0,0,255}));
  connect(C2.n,n1)  annotation (points=[-221,-60; -213,-60; -213,-20], style(
        color=3, rgbcolor={0,0,255}));
  connect(n1,n2) 
    annotation (points=[-213,-20; -213,20],style(color=3, rgbcolor={0,0,255}));
  connect(n2,n3) 
    annotation (points=[-213,20; -213,40],style(color=3, rgbcolor={0,0,255}));
  connect(n3,C1. p) 
    annotation (points=[-213,40; -193,40], style(color=3, rgbcolor={0,0,255}));
  connect(C1.n,n4) 
    annotation (points=[-173,40; -161,40], style(color=3, rgbcolor={0,0,255}));
  connect(n4,Op1. out) annotation (points=[-161,40; -161,-30], style(color=3,
        rgbcolor={0,0,255}));
  connect(C5.p,Op1. out) annotation (points=[-31,-90; -161,-90; -161,-30],
      style(color=3, rgbcolor={0,0,255}));
  connect(n5,Op2. in_n) annotation (points=[-113,-30; -113,-20; -101,-20],
      style(color=3, rgbcolor={0,0,255}));
  connect(C3.p,n5)  annotation (points=[-91,40; -113,40; -113,-30], style(color=
         3, rgbcolor={0,0,255}));
  connect(C2.p,p1)  annotation (points=[-241,-60; -241,-120; -152,-120], style(
        color=3, rgbcolor={0,0,255}));
  connect(C3.n,n6) 
    annotation (points=[-71,40; -61,40], style(color=3, rgbcolor={0,0,255}));
  connect(n6,Op2. out) 
    annotation (points=[-61,40; -61,-30], style(color=3, rgbcolor={0,0,255}));
  connect(n7,Op3. in_n) annotation (points=[-5,-30; -5,-20; 5,-20], style(color=
         3, rgbcolor={0,0,255}));
  connect(C5.n,n7)  annotation (points=[-11,-90; -5,-90; -5,-30],   style(color=
         3, rgbcolor={0,0,255}));
  connect(n7,n8)  annotation (points=[-5,-30; -5,20],      style(color=3,
        rgbcolor={0,0,255}));
  connect(C6.p,p2) 
    annotation (points=[8,40; -5,40], style(color=3, rgbcolor={0,0,255}));
  connect(n8,p2) 
    annotation (points=[-5,20; -5,40],style(color=3, rgbcolor={0,0,255}));
  connect(C4.n,p2)  annotation (points=[-11,60; -5,60; -5,40], style(color=3,
        rgbcolor={0,0,255}));
  connect(C6.n,Op3. out) annotation (points=[28,40; 45,40; 45,-30], style(color=
         3, rgbcolor={0,0,255}));
  connect(Op3.out,out1) 
    annotation (points=[45,-30; 45,-120], style(color=3, rgbcolor={0,0,255}));
  connect(p1,out1)  annotation (points=[-152,-120; 45,-120], style(color=3,
        rgbcolor={0,0,255}));
  connect(out1,C8. p) annotation (points=[45,-120; 159,-120], style(color=3,
        rgbcolor={0,0,255}));
  connect(C4.p,p3)  annotation (points=[-31,60; -41,60; -41,80; 59,80], style(
        color=3, rgbcolor={0,0,255}));
  connect(n9,n10) 
    annotation (points=[87,20; 87,-30],style(color=3, rgbcolor={0,0,255}));
  connect(n10,Op4. in_n) annotation (points=[87,-30; 87,-20; 99,-20],  style(
        color=3, rgbcolor={0,0,255}));
  connect(n9,C7. p) annotation (points=[87,20; 87,40; 109,40],style(color=3,
        rgbcolor={0,0,255}));
  connect(C7.n,n11) 
    annotation (points=[129,40; 139,40], style(color=3, rgbcolor={0,0,255}));
  connect(n11,Op4. out) 
    annotation (points=[139,40; 139,-30], style(color=3, rgbcolor={0,0,255}));
  connect(G2.p,Op3. in_p) annotation (points=[18,-60; 5,-60; 5,-40], style(
        color=3, rgbcolor={0,0,255}));
  connect(p3,n12)  annotation (points=[59,80; 239,80; 239,60], style(color=3,
        rgbcolor={0,0,255}));
  connect(C9.n,n13) 
    annotation (points=[227,20; 239,20],
                                       style(color=3, rgbcolor={0,0,255}));
  connect(n12,n13) 
    annotation (points=[239,60; 239,20],style(color=3, rgbcolor={0,0,255}));
  connect(n13,Op5. out) 
    annotation (points=[239,20; 239,-30],style(color=3, rgbcolor={0,0,255}));
  connect(C9.p,p4) 
    annotation (points=[207,20; 190,20],
                                       style(color=3, rgbcolor={0,0,255}));
  connect(p4,n14) 
    annotation (points=[190,20; 190,-30],style(color=3, rgbcolor={0,0,255}));
  connect(Op5.in_n,n14)  annotation (points=[199,-20; 190,-20; 190,-30], style(
        color=3, rgbcolor={0,0,255}));
  connect(C8.n,n14)  annotation (points=[179,-120; 190,-120; 190,-30], style(
        color=3, rgbcolor={0,0,255}));
  connect(Op4.in_p,G3. p) annotation (points=[99,-40; 99,-60; 119,-60],   style(
        color=3, rgbcolor={0,0,255}));
  connect(Op5.in_p,G4. p) annotation (points=[199,-40; 199,-60; 219,-60], style(
        color=3, rgbcolor={0,0,255}));
  connect(V.p, Ground1.p)            annotation (points=[-241,-160; -241,-170],
      style(color=3, rgbcolor={0,0,255}));
  connect(R4.n2, n5) annotation (points=[-120,-29.8; -116,-29.8; -116,-30; -113,
        -30], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(Op1.out, R4.n1) annotation (points=[-161,-30; -140.2,-30], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R5.n1, p1) annotation (points=[-140.2,-70; -152,-70; -152,-120],
      style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R5.n2, n5) annotation (points=[-120,-69.8; -116,-69.8; -116,-70; -113,
        -70; -113,-30], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(p3, R8.n1) annotation (points=[59,80; 59.8,80; 59.8,20], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R8.n2, n9) annotation (points=[80,20.2; 84,20.2; 84,20; 87,20], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(Op3.out, R9.n1) annotation (points=[45,-30; 59.8,-30], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R9.n2, n10) annotation (points=[80,-29.8; 84,-29.8; 84,-30; 87,-30],
      style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R1.n1, V.n)            annotation (points=[-240.2,-20; -250,-20; -250,
        -130; -241,-130; -241,-140], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R1.n2, n1) annotation (points=[-220,-19.8; -216,-19.8; -216,-20; -213,
        -20], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R2.n2, n2) annotation (points=[-220,20.2; -218,20.2; -218,20; -213,20],
      style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R2.n1, n6) annotation (points=[-240.2,20; -240,20; -240,100; -61,100;
        -61,40], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R3.n1, n3) annotation (points=[-200.2,80; -213,80; -213,40], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R3.n2, n4) annotation (points=[-180,80.2; -170,80.2; -170,80; -161,80;
        -161,40], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(Rp1.n2, n8) annotation (points=[-12,20.2; -8,20.2; -8,20; -5,20],
      style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(Rp1.n1, n11) annotation (points=[-32.2,20; -52,20; -52,100; 139,100;
        139,40], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(Op2.out, R7.n1) annotation (points=[-61,-30; -32.2,-30], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R7.n2, n7) annotation (points=[-12,-29.8; -8,-29.8; -8,-30; -5,-30],
      style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R10.n1, Op4.out) annotation (points=[159.8,-30; 139,-30], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R10.n2, n14) annotation (points=[180,-29.8; 186,-29.8; 186,-30; 190,
        -30], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R11.n2, n12) annotation (points=[228,60.2; 234,60.2; 234,60; 239,60],
      style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
  connect(R11.n1, p4) annotation (points=[207.8,60; 190,60; 190,20], style(
      color=3,
      rgbcolor={0,0,255},
      fillPattern=1));
end CauerLowPassSC;
