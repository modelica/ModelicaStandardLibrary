within Modelica.Electrical.Analog.Examples.Lines;
model CompareCmatrix
  extends Modelica.Icons.Example;

//********************************************
model MTL_Cmatrix
  "Y-matrix with capacitive coupling for a multi-conductor line"
  parameter Integer n(final min=1) = 3 "Number of conductors";
  parameter Real C[n,n]( each final unit="F/m")  "Capacitance matrix; off-diagonal elements are negative";
  parameter Modelica.Units.SI.Length len=100e3 "line length";
  Modelica.Electrical.Analog.Interfaces.PositivePin p[n] "Vector pin"
    annotation (Placement(transformation(extent={{-110,0},{-90,80}}),
        iconTransformation(extent={{-110,0},{-90,80}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pn "Reference pin"
    annotation (Placement(transformation(extent={{-112,-84},{-90,-62}}),
        iconTransformation(extent={{-112,-84},{-90,-62}})));
  Modelica.Units.SI.Voltage v[n] "Conductor Voltages with respect to reference";
  Modelica.Units.SI.Current i[n] "Current through conductors";
equation
  for j in 1:n loop
    v[j] = p[j].v - pn.v;
    i[j] = p[j].i;
  end for;
  0=sum(p[j].i for j in 1:n) + pn.i;
  i = len*C*der(v);

  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-96,8},{98,-14}},
          textColor={0,0,0},
          textStyle={TextStyle.Bold},
          textString="i=C*der(v)"),
        Text(
          extent={{-94,136},{96,118}},
          textColor={0,0,255},
          textString="%name")}));
end MTL_Cmatrix;
//********************************************


  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(extent={{76,-52},{96,-32}},        rotation = 0)));
  parameter Real Rcomp[div(g.n * (g.n + 1), 2)](each final unit="Ohm/m", each fixed=false) "Compact resistance matrix";
  parameter Real Xcomp[div(g.n * (g.n + 1), 2)](each final unit="Ohm/m", each fixed=false) "Compact reactance matrix";
  parameter Real Lcomp[div(g.n * (g.n + 1), 2)](each final unit="H/m",  each fixed=false) "Compact inductance";
  parameter Real C[g.n,g.n](                   each final unit="F/m",  each fixed=false);
  parameter Real Ccomp[div(g.n * (g.n + 1), 2)](each final unit="F/m",  each fixed=false);
  parameter Modelica.Units.SI.Length len=100e3;
  parameter Real CL[div(g.n * (g.n + 1), 2)]=Ccomp*len;
  MTL_Cmatrix MTL_C(
    n=g.n,
    C=C,
    len=len) annotation (Placement(transformation(extent={{92,0},{112,20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage v2(
    V=v1.V,
    phase=-2.0943951023932,
    f=v1.f) annotation (Placement(visible=true, transformation(
        origin={38,6},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SineVoltage v3(
    V=v1.V,
    phase=2.0943951023932,
    f=v1.f) annotation (Placement(visible=true, transformation(
        origin={38,-12},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SineVoltage v1(V=345e3*sqrt(2/3), f=60)
    annotation (Placement(visible=true, transformation(
        origin={38,26},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=r1n.R) annotation (Placement(
        visible=true, transformation(
        origin={64,26},
        extent={{-8,-8},{8,8}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=r1.R) annotation (Placement(
        visible=true, transformation(
        origin={64,6},
        extent={{-8,-8},{8,8}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r3(R=r1.R) annotation (Placement(
        visible=true, transformation(
        origin={64,-12},
        extent={{-8,-8},{8,8}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor c12(C=CL[2])
                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-18,42})));
  Modelica.Electrical.Analog.Basic.Capacitor c23(C=CL[5])
                                                 annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-18,8})));
  Modelica.Electrical.Analog.Basic.Capacitor c10(C=CL[1])
                                                 annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-66,32})));
  Modelica.Electrical.Analog.Basic.Capacitor c13(C=CL[3])
                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,22})));
  Modelica.Electrical.Analog.Basic.Capacitor c30(C=CL[6])
                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-36,-22})));
  Modelica.Electrical.Analog.Basic.Capacitor c20(C=CL[4])
                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-54,-22})));
  Modelica.Electrical.Analog.Basic.Ground ground1
                                                 annotation (
    Placement(visible = true, transformation(extent={{-28,-56},{-8,-36}},       rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage v2a(
    V=v1.V,
    phase=-2.0943951023932,
    f=v1.f) annotation (Placement(visible=true, transformation(
        origin={-114,18},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SineVoltage v3a(
    V=v1.V,
    phase=2.0943951023932,
    f=v1.f) annotation (Placement(visible=true, transformation(
        origin={-114,-2},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SineVoltage v1a(V=345e3*sqrt(2/3), f=60)
    annotation (Placement(visible=true, transformation(
        origin={-114,48},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  parameter Modelica.Electrical.Analog.Lines.Functions.LineGeometry g(
    n=3,
    x={0,-3.048,3.048},
    y={12.192,12.192,12.192},
    r=1e-3/2*{12.7,12.7,12.7},
    R1=1e-3*{0.348,0.348,0.348},
    k_s={0.287,0.287,0.287},
    f=60)
    annotation (Placement(transformation(extent={{82,38},{102,58}})));
  Modelica.Electrical.Analog.Basic.Resistor r1n(R= 1000.0) annotation (
      Placement(visible=true, transformation(
        origin={-88,48},
        extent={{-8,-8},{8,8}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r2n(R=r1n.R) annotation (Placement(
        visible=true, transformation(
        origin={-88,18},
        extent={{-8,-8},{8,8}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r3n(R=r1n.R) annotation (Placement(
        visible=true, transformation(
        origin={-88,-2},
        extent={{-8,-8},{8,8}},
        rotation=0)));
initial algorithm
  (Ccomp,C) :=Modelica.Electrical.Analog.Lines.Functions.lineCmatrix(
     n = g.n,
     x = g.x,
     y = g.y,
     r = g.r);
  (Rcomp,Xcomp,Lcomp) :=Modelica.Electrical.Analog.Lines.Functions.lineZmatrix(
    n=g.n,
    x=g.x,
    y=g.y,
    r=g.r,
    R1=g.R1,
    k_s=g.k_s,
    rho=g.rho,
    f=g.f);
equation
  connect(v1.n,r1. p)
    annotation (Line(points={{48,26},{56,26}}, color={0,0,255}));
  connect(v2.n, r2.p)
    annotation (Line(points={{48,6},{56,6}}, color={0,0,255}));
  connect(v3.n, r3.p)
    annotation (Line(points={{48,-12},{56,-12}},          color={0,0,255}));
  connect(r1.n, MTL_C.p[1]) annotation (Line(points={{72,26},{78,26},{78,20},
          {92,20},{92,14}}, color={0,0,255}));
  connect(r2.n, MTL_C.p[2]) annotation (Line(points={{72,6},{78,6},{78,16},{
          92,16},{92,14}}, color={0,0,255}));
  connect(r3.n, MTL_C.p[3]) annotation (Line(points={{72,-12},{80,-12},{80,12},
          {92,12},{92,14}}, color={0,0,255}));
  connect(v1.p, v2.p)
    annotation (Line(points={{28,26},{20,26},{20,6},{28,6}},
                                                           color={0,0,255}));
  connect(v2.p, v3.p)
    annotation (Line(points={{28,6},{20,6},{20,-12},{28,-12}},
                                                             color={0,0,255}));
  connect(MTL_C.pn, ground.p) annotation (Line(points={{91.9,2.7},{86,2.7},{
          86,-32}}, color={0,0,255}));
  connect(c30.n, ground1.p)
    annotation (Line(points={{-36,-32},{-36,-36},{-18,-36}}, color={0,0,255}));
  connect(c20.n, ground1.p)
    annotation (Line(points={{-54,-32},{-54,-36},{-18,-36}}, color={0,0,255}));
  connect(c10.n, ground1.p)
    annotation (Line(points={{-66,22},{-66,-36},{-18,-36}}, color={0,0,255}));
  connect(c10.p, c12.p)
    annotation (Line(points={{-66,42},{-66,52},{-18,52}}, color={0,0,255}));
  connect(c12.n, c23.p)
    annotation (Line(points={{-18,32},{-18,18}}, color={0,0,255}));
  connect(v1a.p, v2a.p) annotation (Line(points={{-124,48},{-132,48},{-132,18},{
          -124,18}}, color={0,0,255}));
  connect(v2a.p, v3a.p) annotation (Line(points={{-124,18},{-132,18},{-132,-2},
          {-124,-2}},color={0,0,255}));
  connect(c12.p, c13.p)
    annotation (Line(points={{-18,52},{0,52},{0,32}},     color={0,0,255}));
  connect(c13.n, c23.n)
    annotation (Line(points={{0,12},{0,-2},{-18,-2}},     color={0,0,255}));
  connect(v1a.n, r1n.p)
    annotation (Line(points={{-104,48},{-96,48}}, color={0,0,255}));
  connect(r1n.n, c12.p) annotation (Line(points={{-80,48},{-66,48},{-66,52},{
          -18,52}}, color={0,0,255}));
  connect(v3a.n, r3n.p)
    annotation (Line(points={{-104,-2},{-96,-2}}, color={0,0,255}));
  connect(v2a.n, r2n.p)
    annotation (Line(points={{-104,18},{-96,18}}, color={0,0,255}));
  connect(r2n.n, c23.p) annotation (Line(points={{-80,18},{-40,18},{-40,24},{
          -18,24},{-18,18}},
                         color={0,0,255}));
  connect(r3n.n, c23.n)
    annotation (Line(points={{-80,-2},{-18,-2}}, color={0,0,255}));
  connect(c10.n, c20.n) annotation (Line(points={{-66,22},{-66,-36},{-54,-36},
          {-54,-32}}, color={0,0,255}));
  connect(ground1.p, v3a.p) annotation (Line(points={{-18,-36},{-132,-36},{
          -132,-2},{-124,-2}}, color={0,0,255}));
  connect(ground.p, v3.p) annotation (Line(points={{86,-32},{20,-32},{20,-12},
          {28,-12}}, color={0,0,255}));
  connect(c20.p, c23.p) annotation (Line(points={{-54,-12},{-54,18},{-40,18},
          {-40,24},{-18,24},{-18,18}}, color={0,0,255}));
  connect(c30.p, c23.n)
    annotation (Line(points={{-36,-12},{-36,-2},{-18,-2}}, color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-140,-60},{120,60}})),
    Documentation(info="<html>
<p>
MSL uses, inside <a href=\"modelica://Modelica.Electrical.Analog.Lines.M_OLine\">M_OLine</a>,
a network of physical capacitors to model capacitive effects across conductors.
</p>
<p>
Instead, in typical PowerSystems approach, a capacitance matrix is used, corresponding to
the vector equation:
</p>
<p>
<strong>i</strong>=<em><strong>C&nbsp;</strong></em>d<strong>v</strong>/dt&nbsp;
</p>
<p>
where
</p>
<ul>
  <li>
    <em><strong>i</strong></em> is the vector of currents entering a multiple-conductor lines
    (n conductors with a return wire gives rise to n currents),
  </li>
  <li>
    <em><strong>v</strong></em> is the vector of voltages at a port of a multiple-conductor
    lines (n conductors with a return wire gives rise to n voltages).
  </li>
</ul>
<p>
The <em><strong>C</strong></em> matrix is symmetrical, and therefore it has n(n+1) independent
terms. the diagonal terms of this matrix are negative.
</p>
<p>
The capacitive coupling across conductors can be modelled equivalently through a network of
n(n+1) capacitors, and simple conversion formulas exist, which can for instance be found in
[<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">EmtpTheoryBook</a>],
page 3-12.
</p>
<p>
The support function
<a href=\"modelica://Modelica.Electrical.Analog.Lines.Functions.lineCmatrix\">LineCmatrix</a>
already contains these formulas and puts these capacitance values in an array called
<strong>Ccompact</strong>.
</p>
<p>
This example is to show the perfect equivalence of capacitor matrix and Ccompact values
(here stored in an array named <strong>Ccomp</strong>). Just check for equality
<code>r1n.i</code> and <code>r1.i</code>.
</p>
</html>",
      revisions="<html>
<p><i>June, 2023 Massimo Ceraolo of the University of Pisa </i></p>
<p><i>originally created </i></p>
</html>"),
    experiment(
      StopTime=0.04,
      Interval=1e-05,
      Tolerance=1e-06));
end CompareCmatrix;
