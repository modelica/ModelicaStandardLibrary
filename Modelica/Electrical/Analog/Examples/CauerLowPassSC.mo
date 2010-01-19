within Modelica.Electrical.Analog.Examples;
model CauerLowPassSC
  "Cauer low-pass filter with operational amplifiers and switched capacitors"
model Rn "negative resistance"
  parameter Modelica.SIunits.Time clock=1 "clock";
  parameter Modelica.SIunits.Resistance R(min=Modelica.Constants.eps)=1
      "Resistance";
  Modelica.Blocks.Sources.BooleanPulse BooleanPulse1(period=clock)
    annotation (Placement(transformation(extent={{-10,50},{10,70}}, rotation=0)));

  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=clock/R)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch IdealCommutingSwitch1
    annotation (Placement(transformation(
          origin={-50,0},
          extent={{-10,-10},{10,10}},
          rotation=180)));
  Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch IdealCommutingSwitch2
    annotation (Placement(transformation(extent={{40,-10},{60,10}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground Ground1
    annotation (Placement(transformation(extent={{-66,-32},{-54,-20}}, rotation=
             0)));
  Modelica.Electrical.Analog.Basic.Ground Ground2
    annotation (Placement(transformation(extent={{54,-32},{66,-20}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}}, rotation=
             0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2
    annotation (Placement(transformation(extent={{90,-8},{110,12}}, rotation=0)));
equation
  connect(IdealCommutingSwitch1.p,Capacitor1. p) annotation (Line(points={{-40,
            -1.22465e-015},{-42,-1.22465e-015},{-44,0},{-20,0}}, color={0,0,255}));
  connect(Capacitor1.n,IdealCommutingSwitch2. p)
    annotation (Line(points={{20,0},{40,0}}, color={0,0,255}));
  connect(IdealCommutingSwitch2.control,BooleanPulse1. y) annotation (Line(
          points={{50,8},{50,30},{20,30},{20,60},{11,60}}, color={255,0,255}));
  connect(IdealCommutingSwitch1.control,BooleanPulse1. y) annotation (Line(
          points={{-50,-8},{-50,30},{20,30},{20,60},{11,60}}, color={255,0,255}));
  connect(Ground2.p,IdealCommutingSwitch2. n2) annotation (Line(points={{60,-20},
            {60,0}}, color={0,0,255}));
  connect(IdealCommutingSwitch2.n1,n2)  annotation (Line(
        points={{60,5},{80,5},{80,2},{100,2}},
        color={0,0,255}));
  connect(n1, IdealCommutingSwitch1.n2) annotation (Line(
        points={{-102,0},{-81,0},{-81,1.22465e-015},{-60,1.22465e-015}},
        color={0,0,255}));
  connect(Ground1.p, IdealCommutingSwitch1.n1) annotation (Line(
        points={{-60,-20},{-60,-5}},
        color={0,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}),
            graphics),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Bitmap(extent={{-62,6},{-62,14}}, fileName=""),
          Rectangle(
            extent={{-80,32},{80,-30}},
            pattern=LinePattern.None,
            lineColor={0,0,255}),
          Text(
            extent={{-30,-40},{30,-72}},
            lineColor={0,0,0},
            textString="R=%R"),
          Line(points={{-74,0},{-80,0},{-60,0}}, color={85,255,85}),
          Line(points={{-80,-20},{-60,-20},{-60,-16},{-40,-8},{-4,-8}}, color={
                85,255,85}),
          Line(points={{80,0},{60,0}}, color={85,255,85}),
          Line(points={{-60,2},{-60,-4}}, color={170,255,170}),
          Line(points={{-4,2},{-4,-18}}, color={85,255,85}),
          Line(points={{4,2},{4,-18}}, color={85,255,85}),
          Text(
            extent={{-60,80},{60,40}},
            lineColor={0,0,255},
            textString="%name"),
          Line(points={{-92,0},{-80,0}}, color={85,85,255}),
          Line(points={{90,0},{80,0},{80,0}}, color={85,85,255}),
          Line(points={{4,-8},{40,-8},{60,-4}}, color={85,255,85}),
          Line(points={{60,0},{60,-4}}, color={85,255,85}),
          Line(points={{60,-16},{60,-20},{80,-20}}, color={85,255,85})}));
end Rn;

model Rp "positive resistance"

  parameter Modelica.SIunits.Time clock=1 "clock";
  parameter Modelica.SIunits.Resistance R(min=Modelica.Constants.eps)=1
      "Resistance";
  Modelica.Blocks.Sources.BooleanPulse BooleanPulse1(period=clock)
    annotation (Placement(transformation(extent={{-10,50},{10,70}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=clock/R)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch IdealCommutingSwitch1
    annotation (Placement(transformation(
          origin={-50,0},
          extent={{-10,-10},{10,10}},
          rotation=180)));
  Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch IdealCommutingSwitch2
    annotation (Placement(transformation(extent={{40,-10},{60,10}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground Ground1
    annotation (Placement(transformation(
          origin={-59,46},
          extent={{-5,-6},{5,6}},
          rotation=180)));
  Modelica.Electrical.Analog.Basic.Ground Ground2
    annotation (Placement(transformation(extent={{56,-44},{66,-32}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}}, rotation=
             0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2
    annotation (Placement(transformation(extent={{90,-8},{110,12}}, rotation=0)));
equation
  connect(IdealCommutingSwitch1.p, Capacitor1.p) annotation (Line(points={{-40,
            -1.22465e-015},{-42,-1.22465e-015},{-44,0},{-20,0}}, color={0,0,255}));
  connect(Capacitor1.n, IdealCommutingSwitch2.p)
    annotation (Line(points={{20,0},{40,0}}, color={0,0,255}));
  connect(IdealCommutingSwitch2.control, BooleanPulse1.y) annotation (Line(
          points={{50,8},{50,30},{20,30},{20,60},{11,60}}, color={255,0,255}));
  connect(IdealCommutingSwitch1.control, BooleanPulse1.y) annotation (Line(
          points={{-50,-8},{-50,30},{20,30},{20,60},{11,60}}, color={255,0,255}));
  connect(Ground1.p, IdealCommutingSwitch1.n2) annotation (Line(points={{-59,40},
            {-60,40},{-60,1.22465e-015}}, color={0,0,255}));
  connect(Ground2.p, IdealCommutingSwitch2.n2) annotation (Line(points={{61,-32},
            {60,-32},{60,0}}, color={0,0,255}));
  connect(IdealCommutingSwitch1.n1, n1) annotation (Line(points={{-60,-5},{-99,
            -5},{-99,0},{-102,0}}, color={0,0,255}));
  connect(IdealCommutingSwitch2.n1, n2) annotation (Line(
        points={{60,5},{80,5},{80,2},{100,2}},
        color={0,0,255}));
  annotation (Diagram(coordinateSystem(
            preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                                                     graphics),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Bitmap(extent={{-62,4},{-62,12}}, fileName=""),
          Rectangle(
            extent={{-80,30},{80,-32}},
            pattern=LinePattern.None,
            lineColor={0,0,255}),
          Line(points={{-92,0},{-80,0}}, color={85,85,255}),
          Line(points={{80,0},{92,0}}, color={85,85,255}),
          Text(
            extent={{-40,-40},{32,-72}},
            lineColor={0,0,0},
            textString="R=%R"),
          Line(points={{-74,0},{-80,0},{-60,0}}, color={85,255,85}),
          Line(points={{-80,-20},{-60,-20},{-60,-16},{-40,-10},{-4,-10}}, color
              ={85,255,85}),
          Line(points={{4,-10},{40,-10},{60,-16},{60,-20},{80,-20}}, color={85,
                255,85}),
          Line(points={{80,0},{60,0}}, color={85,255,85}),
          Line(points={{60,0},{60,-4}}, color={85,255,85}),
          Line(points={{-60,0},{-60,-6}}, color={170,255,170}),
          Line(points={{-4,0},{-4,-20}}, color={85,255,85}),
          Line(points={{4,0},{4,-20}}, color={85,255,85}),
          Text(
            extent={{-60,80},{60,40}},
            lineColor={0,0,255},
            textString="%name")}));
end Rp;

  parameter Modelica.SIunits.Capacitance l1=1.304 "filter coefficient i1";
  parameter Modelica.SIunits.Capacitance l2=0.8586 "filter coefficient i2";
  parameter Modelica.SIunits.Capacitance c1=1.072 "filter coefficient c1";
  parameter Modelica.SIunits.Capacitance c2=1/(1.704992^2*l1)
    "filter coefficient c2";
  parameter Modelica.SIunits.Capacitance c3=1.682 "filter coefficient c3";
  parameter Modelica.SIunits.Capacitance c4=1/(1.179945^2*l2)
    "filter coefficient c4";
  parameter Modelica.SIunits.Capacitance c5=0.7262 "filter coefficient c5";
  Modelica.Electrical.Analog.Basic.Capacitor C1(C=c1 + c2)
    annotation (Placement(transformation(extent={{-193,30},{-173,50}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.Capacitor C2(C=c2)
    annotation (Placement(transformation(extent={{-241,-70},{-221,-50}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C3(C=l1)
    annotation (Placement(transformation(extent={{-91,30},{-71,50}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C4(C=c4)
    annotation (Placement(transformation(extent={{-31,50},{-11,70}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C5(C=c2)
    annotation (Placement(transformation(extent={{-31,-100},{-11,-80}},
          rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op1
    annotation (Placement(transformation(extent={{-201,-50},{-161,-10}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground G
    annotation (Placement(transformation(extent={{-189,-76},{-175,-60}},
          rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op2
    annotation (Placement(transformation(extent={{-101,-50},{-61,-10}},
          rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op3
    annotation (Placement(transformation(extent={{5,-50},{45,-10}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground G1
    annotation (Placement(transformation(extent={{-88,-76},{-74,-60}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.Capacitor C6(C=c2 + c3 + c4)
    annotation (Placement(transformation(extent={{8,30},{28,50}}, rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op4
    annotation (Placement(transformation(extent={{99,-50},{139,-10}}, rotation=
            0)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op5
    annotation (Placement(transformation(extent={{199,-50},{239,-10}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.Capacitor C7(C=l2)
    annotation (Placement(transformation(extent={{109,30},{129,50}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C8(C=c4)
    annotation (Placement(transformation(extent={{159,-130},{179,-110}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C9(C=c4 + c5)
    annotation (Placement(transformation(extent={{207,10},{227,30}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n1
    annotation (Placement(transformation(extent={{-215,-22},{-211,-18}},
          rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n2
    annotation (Placement(transformation(extent={{-215,18},{-211,22}}, rotation=
           0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n3
    annotation (Placement(transformation(extent={{-215,38},{-211,42}}, rotation=
           0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n4
    annotation (Placement(transformation(
        origin={-161,40},
        extent={{2,2},{-2,-2}},
        rotation=180)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n5
    annotation (Placement(transformation(extent={{-115,-32},{-111,-28}},
          rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin p1
    annotation (Placement(transformation(extent={{-155,-122},{-149,-118}},
          rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n6
    annotation (Placement(transformation(extent={{-63,38},{-59,42}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n7
    annotation (Placement(transformation(extent={{-7,-32},{-3,-28}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n8
    annotation (Placement(transformation(extent={{-7,18},{-3,22}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin p2
    annotation (Placement(transformation(extent={{-7,38},{-3,42}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin out1
    annotation (Placement(transformation(extent={{43,-122},{47,-118}}, rotation=
           0)));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin p3
    annotation (Placement(transformation(extent={{57,78},{61,82}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n9
    annotation (Placement(transformation(extent={{85,18},{89,22}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n10
    annotation (Placement(transformation(extent={{85,-32},{89,-28}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n11
    annotation (Placement(transformation(extent={{137,38},{141,42}}, rotation=0)));
public
  Modelica.Electrical.Analog.Basic.Ground G2
    annotation (Placement(transformation(extent={{11,-76},{25,-60}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n12
    annotation (Placement(transformation(extent={{237,58},{241,62}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n13
    annotation (Placement(transformation(extent={{237,18},{241,22}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin p4
    annotation (Placement(transformation(extent={{187,18},{193,22}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n14
    annotation (Placement(transformation(extent={{187,-32},{193,-28}}, rotation=
           0)));
public
  Modelica.Electrical.Analog.Basic.Ground G3
    annotation (Placement(transformation(extent={{112,-76},{126,-60}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.Ground G4
    annotation (Placement(transformation(extent={{212,-76},{226,-60}}, rotation=
           0)));
  Modelica.Electrical.Analog.Sources.StepVoltage V(startTime=1)
    annotation (Placement(transformation(
        origin={-241,-150},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Ground Ground1
    annotation (Placement(transformation(extent={{-247,-182},{-235,-170}},
          rotation=0)));
  Rn R4(clock=0.1) annotation (Placement(transformation(extent={{-140,-40},{
            -120,-20}}, rotation=0)));
  Rn R5(clock=0.1) annotation (Placement(transformation(extent={{-140,-80},{
            -120,-60}}, rotation=0)));
  Rn R8(clock=0.1) annotation (Placement(transformation(extent={{60,10},{80,30}},
          rotation=0)));
  Rn R9(clock=0.1) annotation (Placement(transformation(extent={{60,-40},{80,
            -20}}, rotation=0)));
  Rp R1(clock=0.1) annotation (Placement(transformation(extent={{-240,-30},{
            -220,-10}}, rotation=0)));
  Rp R2(clock=0.1) annotation (Placement(transformation(extent={{-240,10},{-220,
            30}}, rotation=0)));
  Rp R3(clock=0.1) annotation (Placement(transformation(extent={{-200,70},{-180,
            90}}, rotation=0)));
  Rp Rp1(clock=0.1) annotation (Placement(transformation(extent={{-32,10},{-12,
            30}}, rotation=0)));
  Rp R7(clock=0.1) annotation (Placement(transformation(extent={{-32,-40},{-12,
            -20}}, rotation=0)));
  Rp R10(clock=0.1) annotation (Placement(transformation(extent={{160,-40},{180,
            -20}}, rotation=0)));
  Rp R11(clock=0.1) annotation (Placement(transformation(extent={{208,50},{228,
            70}}, rotation=0)));
equation
  connect(Op1.in_p,G. p) annotation (Line(points={{-201,-40},{-201,-50},{-181,
          -50},{-181,-60},{-182,-60}}, color={0,0,255}));
  connect(G1.p,Op2. in_p) annotation (Line(points={{-81,-60},{-81,-50},{-101,
          -50},{-101,-40}}, color={0,0,255}));
  connect(n1,Op1. in_n) annotation (Line(points={{-213,-20},{-201,-20}}, color=
          {0,0,255}));
  connect(C2.n,n1)  annotation (Line(points={{-221,-60},{-213,-60},{-213,-20}},
        color={0,0,255}));
  connect(n1,n2)
    annotation (Line(points={{-213,-20},{-213,20}}, color={0,0,255}));
  connect(n2,n3)
    annotation (Line(points={{-213,20},{-213,40}}, color={0,0,255}));
  connect(n3,C1. p)
    annotation (Line(points={{-213,40},{-193,40}}, color={0,0,255}));
  connect(C1.n,n4)
    annotation (Line(points={{-173,40},{-161,40}}, color={0,0,255}));
  connect(n4,Op1. out) annotation (Line(points={{-161,40},{-161,-30}}, color={0,
          0,255}));
  connect(C5.p,Op1. out) annotation (Line(points={{-31,-90},{-161,-90},{-161,
          -30}}, color={0,0,255}));
  connect(n5,Op2. in_n) annotation (Line(points={{-113,-30},{-113,-20},{-101,
          -20}}, color={0,0,255}));
  connect(C3.p,n5)  annotation (Line(points={{-91,40},{-113,40},{-113,-30}},
        color={0,0,255}));
  connect(C2.p,p1)  annotation (Line(points={{-241,-60},{-241,-120},{-152,-120}},
        color={0,0,255}));
  connect(C3.n,n6)
    annotation (Line(points={{-71,40},{-61,40}}, color={0,0,255}));
  connect(n6,Op2. out)
    annotation (Line(points={{-61,40},{-61,-30}}, color={0,0,255}));
  connect(n7,Op3. in_n) annotation (Line(points={{-5,-30},{-5,-20},{5,-20}},
        color={0,0,255}));
  connect(C5.n,n7)  annotation (Line(points={{-11,-90},{-5,-90},{-5,-30}},
        color={0,0,255}));
  connect(n7,n8)  annotation (Line(points={{-5,-30},{-5,20}}, color={0,0,255}));
  connect(C6.p,p2)
    annotation (Line(points={{8,40},{-5,40}}, color={0,0,255}));
  connect(n8,p2)
    annotation (Line(points={{-5,20},{-5,40}}, color={0,0,255}));
  connect(C4.n,p2)  annotation (Line(points={{-11,60},{-5,60},{-5,40}}, color={
          0,0,255}));
  connect(C6.n,Op3. out) annotation (Line(points={{28,40},{45,40},{45,-30}},
        color={0,0,255}));
  connect(Op3.out,out1)
    annotation (Line(points={{45,-30},{45,-120}}, color={0,0,255}));
  connect(p1,out1)  annotation (Line(points={{-152,-120},{45,-120}}, color={0,0,
          255}));
  connect(out1,C8. p) annotation (Line(points={{45,-120},{159,-120}}, color={0,
          0,255}));
  connect(C4.p,p3)  annotation (Line(points={{-31,60},{-41,60},{-41,80},{59,80}},
        color={0,0,255}));
  connect(n9,n10)
    annotation (Line(points={{87,20},{87,-30}}, color={0,0,255}));
  connect(n10,Op4. in_n) annotation (Line(points={{87,-30},{87,-20},{99,-20}},
        color={0,0,255}));
  connect(n9,C7. p) annotation (Line(points={{87,20},{87,40},{109,40}}, color={
          0,0,255}));
  connect(C7.n,n11)
    annotation (Line(points={{129,40},{139,40}}, color={0,0,255}));
  connect(n11,Op4. out)
    annotation (Line(points={{139,40},{139,-30}}, color={0,0,255}));
  connect(G2.p,Op3. in_p) annotation (Line(points={{18,-60},{5,-60},{5,-40}},
        color={0,0,255}));
  connect(p3,n12)  annotation (Line(points={{59,80},{239,80},{239,60}}, color={
          0,0,255}));
  connect(C9.n,n13)
    annotation (Line(points={{227,20},{239,20}}, color={0,0,255}));
  connect(n12,n13)
    annotation (Line(points={{239,60},{239,20}}, color={0,0,255}));
  connect(n13,Op5. out)
    annotation (Line(points={{239,20},{239,-30}}, color={0,0,255}));
  connect(C9.p,p4)
    annotation (Line(points={{207,20},{190,20}}, color={0,0,255}));
  connect(p4,n14)
    annotation (Line(points={{190,20},{190,-30}}, color={0,0,255}));
  connect(Op5.in_n,n14)  annotation (Line(points={{199,-20},{190,-20},{190,-30}},
        color={0,0,255}));
  connect(C8.n,n14)  annotation (Line(points={{179,-120},{190,-120},{190,-30}},
        color={0,0,255}));
  connect(Op4.in_p,G3. p) annotation (Line(points={{99,-40},{99,-60},{119,-60}},
        color={0,0,255}));
  connect(Op5.in_p,G4. p) annotation (Line(points={{199,-40},{199,-60},{219,-60}},
        color={0,0,255}));
  connect(V.p, Ground1.p)            annotation (Line(points={{-241,-160},{-241,
          -170}}, color={0,0,255}));
  connect(R4.n2, n5) annotation (Line(
      points={{-120,-29.8},{-116,-29.8},{-116,-30},{-113,-30}},
      color={0,0,255}));
  connect(Op1.out, R4.n1) annotation (Line(
      points={{-161,-30},{-140.2,-30}},
      color={0,0,255}));
  connect(R5.n1, p1) annotation (Line(
      points={{-140.2,-70},{-152,-70},{-152,-120}},
      color={0,0,255}));
  connect(R5.n2, n5) annotation (Line(
      points={{-120,-69.8},{-116,-69.8},{-116,-70},{-113,-70},{-113,-30}},
      color={0,0,255}));
  connect(p3, R8.n1) annotation (Line(
      points={{59,80},{59.8,80},{59.8,20}},
      color={0,0,255}));
  connect(R8.n2, n9) annotation (Line(
      points={{80,20.2},{84,20.2},{84,20},{87,20}},
      color={0,0,255}));
  connect(Op3.out, R9.n1) annotation (Line(
      points={{45,-30},{59.8,-30}},
      color={0,0,255}));
  connect(R9.n2, n10) annotation (Line(
      points={{80,-29.8},{84,-29.8},{84,-30},{87,-30}},
      color={0,0,255}));
  connect(R1.n1, V.n)            annotation (Line(
      points={{-240.2,-20},{-250,-20},{-250,-130},{-241,-130},{-241,-140}},
      color={0,0,255}));
  connect(R1.n2, n1) annotation (Line(
      points={{-220,-19.8},{-216,-19.8},{-216,-20},{-213,-20}},
      color={0,0,255}));
  connect(R2.n2, n2) annotation (Line(
      points={{-220,20.2},{-218,20.2},{-218,20},{-213,20}},
      color={0,0,255}));
  connect(R2.n1, n6) annotation (Line(
      points={{-240.2,20},{-240,20},{-240,100},{-61,100},{-61,40}},
      color={0,0,255}));
  connect(R3.n1, n3) annotation (Line(
      points={{-200.2,80},{-213,80},{-213,40}},
      color={0,0,255}));
  connect(R3.n2, n4) annotation (Line(
      points={{-180,80.2},{-170,80.2},{-170,80},{-161,80},{-161,40}},
      color={0,0,255}));
  connect(Rp1.n2, n8) annotation (Line(
      points={{-12,20.2},{-8,20.2},{-8,20},{-5,20}},
      color={0,0,255}));
  connect(Rp1.n1, n11) annotation (Line(
      points={{-32.2,20},{-52,20},{-52,100},{139,100},{139,40}},
      color={0,0,255}));
  connect(Op2.out, R7.n1) annotation (Line(
      points={{-61,-30},{-32.2,-30}},
      color={0,0,255}));
  connect(R7.n2, n7) annotation (Line(
      points={{-12,-29.8},{-8,-29.8},{-8,-30},{-5,-30}},
      color={0,0,255}));
  connect(R10.n1, Op4.out) annotation (Line(
      points={{159.8,-30},{139,-30}},
      color={0,0,255}));
  connect(R10.n2, n14) annotation (Line(
      points={{180,-29.8},{186,-29.8},{186,-30},{190,-30}},
      color={0,0,255}));
  connect(R11.n2, n12) annotation (Line(
      points={{228,60.2},{234,60.2},{234,60},{239,60}},
      color={0,0,255}));
  connect(R11.n1, p4) annotation (Line(
      points={{207.8,60},{190,60},{190,20}},
      color={0,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-250,
            -200},{250,200}}), graphics={Text(
          extent={{-100,180},{94,140}},
          textString="CauerLowPassSC",
          lineColor={0,0,255})}),
    experiment(StopTime=60, NumberOfIntervals=1500),
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
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-250,-200},{250,
            200}}), graphics={
        Rectangle(
          extent={{-100,-100},{80,50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-96,3},{77,-49}},
          lineColor={0,0,255},
          textString="Example"),
        Text(
          extent={{-120,132},{120,73}},
          lineColor={255,0,0},
          textString="%name")}));
end CauerLowPassSC;
