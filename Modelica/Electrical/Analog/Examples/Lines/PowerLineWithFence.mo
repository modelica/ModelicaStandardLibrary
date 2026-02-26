within Modelica.Electrical.Analog.Examples.Lines;
model PowerLineWithFence
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Lines.M_OLine line(
    N=2,
    c = Ccomp,
    g = fill(1e-12, div(g.n * (g.n + 1), 2)),
    l = Lcomp,
    length(displayUnit="km") = 100000,
    lines = g.n, r = g.R1) annotation (
    Placement(visible = true, transformation(origin={-10,10},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage v2(
    V=v1.V,
    phase=-2.0943951023932,
    f=v1.f) annotation (Placement(visible=true, transformation(
        origin={-50,10},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor rgUL(R = 1) annotation (
    Placement(visible = true, transformation(origin={-70,-30},    extent={{-10,10},{10,-10}},  rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(extent={{-80,-70},{-60,-50}},      rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage v3(
    V=v1.V,
    phase=2.0943951023932,
    f=v1.f) annotation (Placement(visible=true, transformation(
        origin={-50,-10},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=500) annotation (Placement(
        visible=true, transformation(
        origin={30,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=r1.R) annotation (Placement(
        visible=true, transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r3(R=r1.R) annotation (Placement(
        visible=true, transformation(
        origin={30,-10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  parameter Modelica.Electrical.Analog.Lines.Functions.LineGeometry g(
    n=4,
    x={0,-3.048,3.048,-9.144},
    y={12.192,12.192,12.192,3.048},
    r=1e-3/2*{12.7,12.7,12.7,4.064},
    R1=1e-3*{0.348,0.348,0.348,1.802},
    k_s={0.287,0.287,0.287,0.779},
    f=60)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Electrical.Analog.Sources.SineVoltage v1(
    V=345e3*sqrt(2/3),
    f=60)
    annotation (Placement(visible=true, transformation(
        origin={-50,30},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor body(R=1000) annotation (
      Placement(visible=true, transformation(
        origin={0,-30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  parameter Real Rcomp[div(g.n * (g.n + 1), 2)](each final unit="Ohm/m", each fixed=false) "Compact resistance matrix";
  parameter Real Xcomp[div(g.n * (g.n + 1), 2)](each final unit="Ohm/m", each fixed=false) "Compact reactance matrix";
  parameter Real Lcomp[div(g.n * (g.n + 1), 2)](each final unit="H/m",  each fixed=false) "Compact inductance";
  parameter Real Ccomp[div(g.n * (g.n + 1), 2)](each final unit="F/m")=
    Modelica.Electrical.Analog.Lines.Functions.lineCmatrix(
      n = g.n, x = g.x, y = g.y, r = g.r);
initial algorithm
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
  connect(ground.p, rgUL.n) annotation (
    Line(points={{-70,-50},{-70,-40}},      color = {0, 0, 255}));
  connect(r1.p, line.n[1])
    annotation (Line(points={{20,30},{0,30},{0,10}},    color={0,0,255}));
  connect(r2.p, line.n[2])
    annotation (Line(points={{20,10},{0,10}},  color={0,0,255}));
  connect(r1.n, r2.n) annotation (Line(points={{40,30},{50,30},{50,10},{40,10}},
        color={0,0,255}));
  connect(r2.n, r3.n) annotation (Line(points={{40,10},{50,10},{50,-10},{40,-10}},
        color={0,0,255}));
  connect(r3.p, line.n[3])
    annotation (Line(points={{20,-10},{0,-10},{0,10}},  color={0,0,255}));
  connect(v1.n, line.p[1])
    annotation (Line(points={{-40,30},{-20,30},{-20,10}}, color={0,0,255}));
  connect(v2.n, line.p[2])
    annotation (Line(points={{-40,10},{-20,10}}, color={0,0,255}));
  connect(v3.n, line.p[3])
    annotation (Line(points={{-40,-10},{-20,-10},{-20,10}},
                                                          color={0,0,255}));
  connect(v1.p, rgUL.p)
    annotation (Line(points={{-60,30},{-70,30},{-70,-20}}, color={0,0,255}));
  connect(v2.p, rgUL.p)
    annotation (Line(points={{-60,10},{-70,10},{-70,-20}}, color={0,0,255}));
  connect(v3.p, rgUL.p)
    annotation (Line(points={{-60,-10},{-70,-10},{-70,-20}},
                                                           color={0,0,255}));
  connect(body.p, line.n[4])
    annotation (Line(points={{0,-20},{0,10}},     color={0,0,255}));
  connect(body.n, ground.p) annotation (Line(points={{0,-40},{0,-50},{-70,-50}},
                 color={0,0,255}));
  connect(body.n, r3.n) annotation (Line(points={{0,-40},{0,-50},{50,-50},{50,-10},{40,-10}},
                            color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
This example shows the usage of <a href=\"modelica://Modelica.Electrical.Analog.Lines.M_OLine\">M_OLine</a>
in a overhead PowerLine. The line geometry is the one shown in figure 4.11 of
[<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Theory Book</a>].
</p>
<p>
A common rule-of-thumb states that for steady-state analysis at industrial frequency each
segment (PI model) should be not longer than one tenth of the wave length. For 50&nbsp;Hz,
the wavelength is 6000&nbsp;km, therefore each pi should not overcome 60&nbsp;km. This is
why for our 100&nbsp;km line we have chosen just two trunks.
</p>
<p>
This example has some limitations:
</p>
<ul>
  <li>
    the results are valid only for their steady-state trend. If we want to simulate transients
    effectively, the number of trunks must be enlarged consistently. See example
    &quot;CompareLineTrunks&quot;.
  </li>
  <li>
    since it is based on <a href=\"modelica://Modelica.Electrical.Analog.Lines.M_OLine\">M_OLine</a>,
    which requires zero-valued resistances on the off-diagonal elements of Z impedance matrix,
    it does not take into account the influence of the soil resistance into Z matrix; however,
    for simulations like this one in which the current through the soil is negligible and we
    analyse the results at power frequency where soil resistance is very low, this implies
    negligible errors.
  </li>
</ul>
<p>
The considered line is a three-phase line with a fence all along the line (conductor #4).
An interesting result of this example is the fence steady-state voltage due to the capacitive
coupling with the other wires.
</p>

<h5>Test 1:</h5>
<p>
Simulate the model as it is: a person (body) is supposed to be touching the fence, and
absorbs the current <code>body.i</code>, around 1&nbsp;A (RMS), by large lethal.
</p>

<h5>Test 2:</h5>
<p>
Simulate the model changing the body resistance to 1e6&nbsp;&ohm; or removing body: the steady-state
fence voltage <code>line.n[4].v</code> has changed from 1429&nbsp;V to 5594&nbsp;V (peak).
So there exists a marked difference between the open-circuit voltage and actual body
voltage which, although being much lower, is still very dangerous.
</p>

<h5>Test 3:</h5>
<p>
Simulate the original model reducing the line length to 3&nbsp;km. The body current has fallen
to around 30&nbsp;mA (RMS), which is considered the maximum safe current a body can resist over
5&nbsp;s.
</p>
<p>
Note that the fence voltage before the human contact is roughtly the same for all lengths while
the current flowing when contact occurs is very dependent on the line length.
</p>
</html>",
      revisions="<html>
<p>June, 2023 Massimo Ceraolo of the University of Pisa </p>
<p>originally created </p>
</html>"),
    experiment(
      StopTime=0.04,
      Interval=1e-05,
      Tolerance=1e-06),
    Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
end PowerLineWithFence;
