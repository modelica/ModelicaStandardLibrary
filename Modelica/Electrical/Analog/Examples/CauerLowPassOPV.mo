within Modelica.Electrical.Analog.Examples;
model CauerLowPassOPV "Cauer low pass filter with operational amplifiers"

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
    annotation (Placement(transformation(extent={{-192,10},{-172,30}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.Capacitor C2(C=c2)
    annotation (Placement(transformation(extent={{-240,-90},{-220,-70}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C3(C=l1)
    annotation (Placement(transformation(extent={{-90,10},{-70,30}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C4(C=c4)
    annotation (Placement(transformation(extent={{-30,30},{-10,50}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C5(C=c2)
    annotation (Placement(transformation(extent={{-30,-120},{-10,-100}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R1
    annotation (Placement(transformation(extent={{-240,-50},{-220,-30}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R2
    annotation (Placement(transformation(extent={{-240,-10},{-220,10}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R3
    annotation (Placement(transformation(extent={{-193,50},{-173,70}}, rotation=
           0)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op1
    annotation (Placement(transformation(extent={{-200,-70},{-160,-30}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground G
    annotation (Placement(transformation(extent={{-188,-96},{-174,-80}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R4(R=-1)
    annotation (Placement(transformation(extent={{-140,-60},{-120,-40}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R5(R=-1)
    annotation (Placement(transformation(extent={{-140,-100},{-120,-80}},
          rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op2
    annotation (Placement(transformation(extent={{-100,-70},{-60,-30}},
          rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op3
    annotation (Placement(transformation(extent={{6,-70},{46,-30}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground G1
    annotation (Placement(transformation(extent={{-87,-96},{-73,-80}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.Resistor R6
    annotation (Placement(transformation(extent={{-31,-10},{-11,10}}, rotation=
            0)));
  Modelica.Electrical.Analog.Basic.Resistor R7
    annotation (Placement(transformation(extent={{-31,-60},{-11,-40}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.Capacitor C6(C=c2 + c3 + c4)
    annotation (Placement(transformation(extent={{9,10},{29,30}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R8(R=-1)
    annotation (Placement(transformation(extent={{60,-10},{80,10}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R9(R=-1)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R10
    annotation (Placement(transformation(extent={{160,-60},{180,-40}}, rotation=
           0)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op4
    annotation (Placement(transformation(extent={{100,-70},{140,-30}}, rotation=
           0)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin Op5
    annotation (Placement(transformation(extent={{200,-70},{240,-30}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.Capacitor C7(C=l2)
    annotation (Placement(transformation(extent={{110,10},{130,30}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C8(C=c4)
    annotation (Placement(transformation(extent={{160,-150},{180,-130}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C9(C=c4 + c5)
    annotation (Placement(transformation(extent={{208,-10},{228,10}}, rotation=
            0)));
  Modelica.Electrical.Analog.Basic.Resistor R11
    annotation (Placement(transformation(extent={{209,30},{229,50}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n1
    annotation (Placement(transformation(extent={{-214,-42},{-210,-38}},
          rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n2
    annotation (Placement(transformation(extent={{-214,-2},{-210,2}}, rotation=
            0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n3
    annotation (Placement(transformation(extent={{-214,18},{-210,22}}, rotation=
           0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n4
    annotation (Placement(transformation(
        origin={-160,20},
        extent={{2,2},{-2,-2}},
        rotation=180)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n5
    annotation (Placement(transformation(extent={{-114,-52},{-110,-48}},
          rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin p1
    annotation (Placement(transformation(extent={{-154,-142},{-148,-138}},
          rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n6
    annotation (Placement(transformation(extent={{-62,18},{-58,22}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n7
    annotation (Placement(transformation(extent={{-6,-52},{-2,-48}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n8
    annotation (Placement(transformation(extent={{-6,-2},{-2,2}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin p2
    annotation (Placement(transformation(extent={{-6,18},{-2,22}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin out1
    annotation (Placement(transformation(extent={{44,-142},{48,-138}}, rotation=
           0)));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin p3
    annotation (Placement(transformation(extent={{58,58},{62,62}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n9
    annotation (Placement(transformation(extent={{86,-2},{90,2}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n10
    annotation (Placement(transformation(extent={{86,-52},{90,-48}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n11
    annotation (Placement(transformation(extent={{138,18},{142,22}}, rotation=0)));
public
  Modelica.Electrical.Analog.Basic.Ground G2
    annotation (Placement(transformation(extent={{12,-96},{26,-80}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n12
    annotation (Placement(transformation(extent={{238,38},{242,42}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n13
    annotation (Placement(transformation(extent={{238,-2},{242,2}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin p4
    annotation (Placement(transformation(extent={{188,-2},{194,2}}, rotation=0)));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin n14
    annotation (Placement(transformation(extent={{188,-52},{194,-48}}, rotation=
           0)));
public
  Modelica.Electrical.Analog.Basic.Ground G3
    annotation (Placement(transformation(extent={{113,-96},{127,-80}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.Ground G4
    annotation (Placement(transformation(extent={{213,-96},{227,-80}}, rotation=
           0)));
  Modelica.Electrical.Analog.Sources.StepVoltage V(startTime=1)
    annotation (Placement(transformation(
        origin={-240,-170},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Ground Ground1
    annotation (Placement(transformation(extent={{-246,-202},{-234,-190}},
          rotation=0)));
equation
  connect(Op1.in_p, G.p) annotation (Line(points={{-200,-60},{-200,-70},{-180,
          -70},{-180,-80},{-181,-80}}, color={0,0,255}));
  connect(G1.p, Op2.in_p) annotation (Line(points={{-80,-80},{-80,-70},{-100,
          -70},{-100,-60}}, color={0,0,255}));
  connect(R1.n, n1) annotation (Line(points={{-220,-40},{-212,-40}}, color={0,0,
          255}));
  connect(n1, Op1.in_n) annotation (Line(points={{-212,-40},{-200,-40}}, color=
          {0,0,255}));
  connect(C2.n, n1) annotation (Line(points={{-220,-80},{-212,-80},{-212,-40}},
        color={0,0,255}));
  connect(R2.n, n2)
    annotation (Line(points={{-220,0},{-212,0}}, color={0,0,255}));
  connect(n1, n2)
    annotation (Line(points={{-212,-40},{-212,0}}, color={0,0,255}));
  connect(n2, n3)
    annotation (Line(points={{-212,0},{-212,20}}, color={0,0,255}));
  connect(n3, C1.p)
    annotation (Line(points={{-212,20},{-192,20}}, color={0,0,255}));
  connect(n3, R3.p) annotation (Line(points={{-212,20},{-212,60},{-193,60}},
        color={0,0,255}));
  connect(C1.n, n4)
    annotation (Line(points={{-172,20},{-160,20}}, color={0,0,255}));
  connect(R3.n, n4) annotation (Line(points={{-173,60},{-160,60},{-160,20}},
        color={0,0,255}));
  connect(n4, Op1.out) annotation (Line(points={{-160,20},{-160,-50}}, color={0,
          0,255}));
  connect(R4.p, Op1.out) annotation (Line(points={{-140,-50},{-160,-50}}, color=
         {0,0,255}));
  connect(C5.p, Op1.out) annotation (Line(points={{-30,-110},{-160,-110},{-160,
          -50}}, color={0,0,255}));
  connect(R4.n, n5) annotation (Line(points={{-120,-50},{-112,-50}}, color={0,0,
          255}));
  connect(n5, Op2.in_n) annotation (Line(points={{-112,-50},{-112,-40},{-100,
          -40}}, color={0,0,255}));
  connect(C3.p, n5) annotation (Line(points={{-90,20},{-112,20},{-112,-50}},
        color={0,0,255}));
  connect(R5.n, n5) annotation (Line(points={{-120,-90},{-112,-90},{-112,-50}},
        color={0,0,255}));
  connect(R5.p, p1) annotation (Line(points={{-140,-90},{-151,-90},{-151,-140}},
        color={0,0,255}));
  connect(C2.p, p1) annotation (Line(points={{-240,-80},{-240,-140},{-151,-140}},
        color={0,0,255}));
  connect(C3.n, n6)
    annotation (Line(points={{-70,20},{-60,20}}, color={0,0,255}));
  connect(n6, Op2.out)
    annotation (Line(points={{-60,20},{-60,-50}}, color={0,0,255}));
  connect(R2.p, n6) annotation (Line(points={{-240,0},{-240,80},{-60,80},{-60,
          20}}, color={0,0,255}));
  connect(Op2.out, R7.p)
    annotation (Line(points={{-60,-50},{-31,-50}}, color={0,0,255}));
  connect(R7.n, n7)
    annotation (Line(points={{-11,-50},{-4,-50}}, color={0,0,255}));
  connect(n7, Op3.in_n) annotation (Line(points={{-4,-50},{-4,-40},{6,-40}},
        color={0,0,255}));
  connect(C5.n, n7) annotation (Line(points={{-10,-110},{-4,-110},{-4,-50}},
        color={0,0,255}));
  connect(R6.n, n8)
    annotation (Line(points={{-11,0},{-4,0}}, color={0,0,255}));
  connect(n7, n8) annotation (Line(points={{-4,-50},{-4,0},{-4,0}}, color={0,0,
          255}));
  connect(C6.p, p2)
    annotation (Line(points={{9,20},{-4,20}}, color={0,0,255}));
  connect(n8, p2)
    annotation (Line(points={{-4,0},{-4,20}}, color={0,0,255}));
  connect(C4.n, p2) annotation (Line(points={{-10,40},{-4,40},{-4,20}}, color={
          0,0,255}));
  connect(C6.n, Op3.out) annotation (Line(points={{29,20},{46,20},{46,-50}},
        color={0,0,255}));
  connect(R9.p, Op3.out)
    annotation (Line(points={{60,-50},{46,-50}}, color={0,0,255}));
  connect(Op3.out, out1)
    annotation (Line(points={{46,-50},{46,-140}}, color={0,0,255}));
  connect(p1, out1) annotation (Line(points={{-151,-140},{46,-140}}, color={0,0,
          255}));
  connect(out1, C8.p) annotation (Line(points={{46,-140},{160,-140}}, color={0,
          0,255}));
  connect(C4.p, p3) annotation (Line(points={{-30,40},{-40,40},{-40,60},{60,60}},
        color={0,0,255}));
  connect(p3, R8.p)
    annotation (Line(points={{60,60},{60,0}}, color={0,0,255}));
  connect(R8.n, n9)
    annotation (Line(points={{80,0},{88,0}}, color={0,0,255}));
  connect(n9, n10)
    annotation (Line(points={{88,0},{88,-50}}, color={0,0,255}));
  connect(R9.n, n10)
    annotation (Line(points={{80,-50},{88,-50}}, color={0,0,255}));
  connect(n10, Op4.in_n) annotation (Line(points={{88,-50},{88,-40},{100,-40}},
        color={0,0,255}));
  connect(n9, C7.p) annotation (Line(points={{88,0},{88,20},{110,20}}, color={0,
          0,255}));
  connect(C7.n, n11)
    annotation (Line(points={{130,20},{140,20}}, color={0,0,255}));
  connect(R6.p, n11) annotation (Line(points={{-31,0},{-48,0},{-48,80},{140,80},
          {140,20}}, color={0,0,255}));
  connect(n11, Op4.out)
    annotation (Line(points={{140,20},{140,-50}}, color={0,0,255}));
  connect(Op4.out, R10.p)
    annotation (Line(points={{140,-50},{160,-50}}, color={0,0,255}));
  connect(G2.p, Op3.in_p) annotation (Line(points={{19,-80},{6,-80},{6,-60}},
        color={0,0,255}));
  connect(R11.n, n12)
    annotation (Line(points={{229,40},{240,40}}, color={0,0,255}));
  connect(p3, n12) annotation (Line(points={{60,60},{240,60},{240,40}}, color={
          0,0,255}));
  connect(C9.n, n13)
    annotation (Line(points={{228,0},{240,0}}, color={0,0,255}));
  connect(n12, n13)
    annotation (Line(points={{240,40},{240,0}}, color={0,0,255}));
  connect(n13, Op5.out)
    annotation (Line(points={{240,0},{240,-50}}, color={0,0,255}));
  connect(C9.p, p4)
    annotation (Line(points={{208,0},{191,0}}, color={0,0,255}));
  connect(R11.p, p4) annotation (Line(points={{209,40},{191,40},{191,0}}, color=
         {0,0,255}));
  connect(R10.n, n14)
    annotation (Line(points={{180,-50},{191,-50}}, color={0,0,255}));
  connect(p4, n14)
    annotation (Line(points={{191,0},{191,-50}}, color={0,0,255}));
  connect(Op5.in_n, n14) annotation (Line(points={{200,-40},{191,-40},{191,-50}},
        color={0,0,255}));
  connect(C8.n, n14) annotation (Line(points={{180,-140},{191,-140},{191,-50}},
        color={0,0,255}));
  connect(Op4.in_p, G3.p) annotation (Line(points={{100,-60},{100,-80},{120,-80}},
        color={0,0,255}));
  connect(Op5.in_p, G4.p) annotation (Line(points={{200,-60},{200,-80},{220,-80}},
        color={0,0,255}));
  connect(V.p, Ground1.p)            annotation (Line(points={{-240,-180},{-240,
          -190}}, color={0,0,255}));
  connect(V.n, R1.p)            annotation (Line(points={{-240,-160},{-250,-160},
          {-250,-40},{-240,-40}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-250,
            -200},{250,200}}), graphics={Text(
          extent={{-130,172},{80,120}},
          textString="CauerLowPassOPV",
          lineColor={0,0,255})}),
    experiment(StopTime=60),
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
The example Cauer Filter is a low-pass-filter of the fifth order. It is realized
using an analog network with operational amplifiers. The voltage source V is the input voltage (step),
and the OP5.out.v is the filter output voltage. The pulse response is calculated.
<p>
This model is identical to the CauerLowPassAnalog example, but inverting. To get the same response
as that of the CauerLowPassAnalog example, a negative voltage step is used as input.
<p>
The simulation end time should be 60. Please plot both V.v (which is the inverted input voltage) and OP5.p.v (output voltage). Compare this result with the CauerLowPassAnalog result.
<p>
During translation some warnings are issued concerning resistor values (Value=-1 not in range[0,1.e+100]).
Do not worry about it. The negative values are o.k.
<p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-250,-200},{250,
            200}}), graphics={
        Rectangle(
          extent={{-100,-80},{80,70}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{-100,70},{-80,90},{100,90},{80,70},{-100,70}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{100,90},{100,-60},{80,-80},{80,70},{100,90}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-96,23},{77,-29}},
          lineColor={0,0,255},
          textString="Example"),
        Text(
          extent={{-120,152},{120,93}},
          lineColor={255,0,0},
          textString="%name")}));
end CauerLowPassOPV;
