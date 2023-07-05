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
    Placement(visible = true, transformation(extent={{90,-80},{110,-60}},       rotation = 0)));
  parameter Modelica.Units.SI.ResistancePerUnitLength Rcomp[div(g.n * (g.n + 1), 2)](each fixed=false) "Compact resistance matrix";
  parameter Modelica.Units.SI.ReactancePerUnitLength Xcomp[div(g.n * (g.n + 1), 2)](each fixed=false) "Compact reactance matrix";
  parameter Modelica.Units.SI.InductancePerUnitLength Lcomp[div(g.n * (g.n + 1), 2)](each fixed=false) "Compact inductance";
  parameter Modelica.Units.SI.CapacitancePerUnitLength C[g.n,g.n](each fixed=false);
  parameter Modelica.Units.SI.CapacitancePerUnitLength Ccomp[div(g.n * (g.n + 1), 2)](each fixed=false);
  parameter Modelica.Units.SI.Length len=100e3;
  parameter Real CL[div(g.n * (g.n + 1), 2)]=Ccomp*len;
  MTL_Cmatrix MTL_C(
    n=g.n,
    C=C,
    len=len) annotation (Placement(transformation(extent={{100,0},{120,20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage v2(
    V=v1.V,
    phase=-2.0943951023932,
    f=v1.f) annotation (Placement(visible=true, transformation(
        origin={50,10},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SineVoltage v3(
    V=v1.V,
    phase=2.0943951023932,
    f=v1.f) annotation (Placement(visible=true, transformation(
        origin={50,-20},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SineVoltage v1(V=345e3*sqrt(2/3), f=60)
    annotation (Placement(visible=true, transformation(
        origin={50,40},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=r1n.R) annotation (Placement(
        visible=true, transformation(
        origin={80,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=r1.R) annotation (Placement(
        visible=true, transformation(
        origin={80,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r3(R=r1.R) annotation (Placement(
        visible=true, transformation(
        origin={80,-20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor c12(C=CL[2])
                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,30})));
  Modelica.Electrical.Analog.Basic.Capacitor c23(C=CL[5])
                                                 annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-10,-10})));
  Modelica.Electrical.Analog.Basic.Capacitor c10(C=CL[1])
                                                 annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-60,-40})));
  Modelica.Electrical.Analog.Basic.Capacitor c13(C=CL[3])
                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,10})));
  Modelica.Electrical.Analog.Basic.Capacitor c30(C=CL[6])
                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-20,-40})));
  Modelica.Electrical.Analog.Basic.Capacitor c20(C=CL[4])
                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,-40})));
  Modelica.Electrical.Analog.Basic.Ground ground1
                                                 annotation (
    Placement(visible = true, transformation(extent={{-30,-90},{-10,-70}},      rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage v2a(
    V=v1.V,
    phase=-2.0943951023932,
    f=v1.f) annotation (Placement(visible=true, transformation(
        origin={-110,10},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SineVoltage v3a(
    V=v1.V,
    phase=2.0943951023932,
    f=v1.f) annotation (Placement(visible=true, transformation(
        origin={-110,-20},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SineVoltage v1a(V=345e3*sqrt(2/3), f=60)
    annotation (Placement(visible=true, transformation(
        origin={-110,40},
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
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Modelica.Electrical.Analog.Basic.Resistor r1n(R= 1000.0) annotation (
      Placement(visible=true, transformation(
        origin={-80,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r2n(R=r1n.R) annotation (Placement(
        visible=true, transformation(
        origin={-80,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r3n(R=r1n.R) annotation (Placement(
        visible=true, transformation(
        origin={-80,-20},
        extent={{-10,-10},{10,10}},
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
    annotation (Line(points={{60,40},{70,40}}, color={0,0,255}));
  connect(v2.n, r2.p)
    annotation (Line(points={{60,10},{70,10}},
                                             color={0,0,255}));
  connect(v3.n, r3.p)
    annotation (Line(points={{60,-20},{70,-20}},          color={0,0,255}));
  connect(r1.n, MTL_C.p[1]) annotation (Line(points={{90,40},{96,40},{96,18},{100,18},{100,14}},
                            color={0,0,255}));
  connect(r2.n, MTL_C.p[2]) annotation (Line(points={{90,10},{90,14},{100,14}},
                           color={0,0,255}));
  connect(r3.n, MTL_C.p[3]) annotation (Line(points={{90,-20},{96,-20},{96,10},{100,10},{100,14}},
                            color={0,0,255}));
  connect(v1.p, v2.p)
    annotation (Line(points={{40,40},{30,40},{30,10},{40,10}},
                                                           color={0,0,255}));
  connect(v2.p, v3.p)
    annotation (Line(points={{40,10},{30,10},{30,-20},{40,-20}},
                                                             color={0,0,255}));
  connect(MTL_C.pn, ground.p) annotation (Line(points={{99.9,2.7},{100,2.7},{100,-60}},
                    color={0,0,255}));
  connect(c30.n, ground1.p)
    annotation (Line(points={{-20,-50},{-20,-70}},           color={0,0,255}));
  connect(c20.n, ground1.p)
    annotation (Line(points={{-40,-50},{-40,-60},{-20,-60},{-20,-70}},
                                                             color={0,0,255}));
  connect(c10.n, ground1.p)
    annotation (Line(points={{-60,-50},{-60,-60},{-20,-60},{-20,-70}},
                                                            color={0,0,255}));
  connect(c10.p, c12.p)
    annotation (Line(points={{-60,-30},{-60,40},{-10,40}},color={0,0,255}));
  connect(c12.n, c23.p)
    annotation (Line(points={{-10,20},{-10,0}},  color={0,0,255}));
  connect(v1a.p, v2a.p) annotation (Line(points={{-120,40},{-120,10}},
                     color={0,0,255}));
  connect(v2a.p, v3a.p) annotation (Line(points={{-120,10},{-120,-20}},
                     color={0,0,255}));
  connect(c12.p, c13.p)
    annotation (Line(points={{-10,40},{10,40},{10,20}},   color={0,0,255}));
  connect(c13.n, c23.n)
    annotation (Line(points={{10,0},{10,-20},{-10,-20}},  color={0,0,255}));
  connect(v1a.n, r1n.p)
    annotation (Line(points={{-100,40},{-90,40}}, color={0,0,255}));
  connect(r1n.n, c12.p) annotation (Line(points={{-70,40},{-10,40}},
                    color={0,0,255}));
  connect(v3a.n, r3n.p)
    annotation (Line(points={{-100,-20},{-90,-20}},
                                                  color={0,0,255}));
  connect(v2a.n, r2n.p)
    annotation (Line(points={{-100,10},{-90,10}}, color={0,0,255}));
  connect(r2n.n, c23.p) annotation (Line(points={{-70,10},{-10,10},{-10,0}},
                         color={0,0,255}));
  connect(r3n.n, c23.n)
    annotation (Line(points={{-70,-20},{-10,-20}},
                                                 color={0,0,255}));
  connect(ground1.p, v3a.p) annotation (Line(points={{-20,-70},{-20,-60},{-120,-60},{-120,-20}},
                               color={0,0,255}));
  connect(ground.p, v3.p) annotation (Line(points={{100,-60},{100,-40},{30,-40},{30,-20},{40,-20}},
                     color={0,0,255}));
  connect(c20.p, c23.p) annotation (Line(points={{-40,-30},{-40,10},{-10,10},{-10,0}},
                                       color={0,0,255}));
  connect(c30.p, c23.n)
    annotation (Line(points={{-20,-30},{-20,-20},{-10,-20}},
                                                           color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-120,-100},{120,100}})),
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
      Tolerance=1e-06),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end CompareCmatrix;
