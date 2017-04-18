within Modelica.Electrical.Analog.Examples;
model CauerLowPassAnalog "Cauer low pass filter with analog components"
  extends Modelica.Icons.Example;

  parameter SI.Inductance l1=1.304 "filter coefficient I1";
  parameter SI.Inductance l2=0.8586 "filter coefficient I2";
  parameter SI.Capacitance c1=1.072 "filter coefficient c1";
  parameter SI.Capacitance c2=1/(1.704992^2*l1)
    "filter coefficient c2";
  parameter SI.Capacitance c3=1.682 "filter coefficient c3";
  parameter SI.Capacitance c4=1/(1.179945^2*l2)
    "filter coefficient c4";
  parameter SI.Capacitance c5=0.7262 "filter coefficient c5";
  Modelica.Electrical.Analog.Basic.Ground G
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Electrical.Analog.Basic.Capacitor C1(C=c1, v(start=0, fixed=true))
    annotation (Placement(transformation(
        origin={-60,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));

Modelica.Electrical.Analog.Basic.Capacitor C2(C=c2)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Electrical.Analog.Basic.Capacitor C3(C=c3,v(start=0, fixed=true))
    annotation (Placement(transformation(
        origin={0,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor C4(C=c4)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Electrical.Analog.Basic.Capacitor C5(C=c5,v(start=0, fixed=true))
    annotation (Placement(transformation(
        origin={60,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor L1(L=l1,i(start=0, fixed=true))
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Electrical.Analog.Basic.Inductor L2(L=l2,i(start=0, fixed=true))
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Electrical.Analog.Basic.Resistor R2(R=1)
    annotation (Placement(transformation(
        origin={100,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.StepVoltage V(startTime=1, offset=0,
    V=1)
    annotation (Placement(transformation(
        origin={-100,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(R1.n,C1.p) annotation (Line(points={{-80,30},{-60,30},{-60,-10}}, color={0,0,255}));
  connect(C1.n,G.p) annotation (Line(points={{-60,-30},{-60,-50},{0,-50},{0,
        -70}}, color={0,0,255}));
  connect(L1.p,C2.p) annotation (Line(points={{-40,70},{-40,30}}, color={0,0,255}));
  connect(L1.p,C1.p) annotation (Line(points={{-40,70},{-40,30},{-60,30},{-60,
        -10}}, color={0,0,255}));
  connect(L1.n,C2.n) annotation (Line(points={{-20,70},{-20,30}}, color={0,0,
        255}));
  connect(C2.n,C3.p) annotation (Line(points={{-20,30},{0,30},{0,-10}}, color={0,0,255}));
  connect(C2.n,C4.p) annotation (Line(points={{-20,30},{20,30}}, color={0,0,255}));
  connect(C2.n,L2.p) annotation (Line(points={{-20,30},{20,30},{20,70}}, color={0,0,255}));
  connect(L2.n,C4.n) annotation (Line(points={{40,70},{40,30}}, color={0,0,
        255}));
  connect(C4.n,C5.p) annotation (Line(points={{40,30},{60,30},{60,-10}}, color={0,0,255}));
  connect(C4.n,R2.p) annotation (Line(points={{40,30},{100,30},{100,-10}}, color={0,0,255}));
  connect(C1.n,C3.n) annotation (Line(points={{-60,-30},{-60,-50},{0,-50},{0,
        -30}}, color={0,0,255}));
  connect(C1.n,C5.n) annotation (Line(points={{-60,-30},{-60,-50},{60,-50},{60,
        -30}}, color={0,0,255}));
  connect(R2.n,C1.n) annotation (Line(points={{100,-30},{100,-50},{-60,-50},{
        -60,-30}}, color={0,0,255}));
  connect(R1.p,V.p) annotation (Line(points={{-100,30},{-100,0}}, color={0,0,
        255}));
  connect(V.n,G.p) annotation (Line(points={{-100,-20},{-100,-70},{
         0,-70}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false,extent={{-120,-100},{120,100}}), graphics={
        Rectangle(
          extent={{-62,32},{-58,28}},
          lineColor={0,0,255},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,28},{2,32}},
          lineColor={0,0,255},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{58,32},{62,28}},
          lineColor={0,0,255},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{58,-48},{62,-52}},
          lineColor={0,0,255},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,-48},{2,-52}},
          lineColor={0,0,255},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,-48},{-58,-52}},
          lineColor={0,0,255},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,100},{120,80}},
          textString="CauerLowPassAnalog",
          lineColor={0,0,255})}),
    experiment(StopTime=60),
    Documentation(revisions="<html>
<ul>
<li><em>January 13, 2006</em>
       by Christoph Clauss<br>
       included into Modelica Standard Library</li>
<li><em>September 15, 2005</em>
       by Peter Trappe designed and by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</html>", info="<html>
<p>The example Cauer Filter is a low-pass-filter of the fifth order. It is realized using an analog network. The voltage source V is the input voltage (step), and the R2.p.v is the filter output voltage. The pulse response is calculated.</p>
<p>The simulation end time should be 60. Please plot both V.p.v (input voltage) and R2.p.v (output voltage).</p>
</html>"));
end CauerLowPassAnalog;
