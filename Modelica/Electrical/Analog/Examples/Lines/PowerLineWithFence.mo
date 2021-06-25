within Modelica.Electrical.Analog.Examples.Lines;
model PowerLineWithFence
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Lines.M_OLine line(
    N=2,  c = Ccomp, g = fill(1e-12, div(g.n * (g.n + 1), 2)), l = Lcomp,
    length=100e3,  lines = g.n, r = g.R1) annotation (
    Placement(visible = true, transformation(origin={-28,18},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage Ub(
    V=Ua.V,
    phase=-2.0943951023932,
    f=Ua.f) annotation (Placement(visible=true, transformation(
        origin={-62,18},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor rgUL(R = 1) annotation (
    Placement(visible = true, transformation(origin={-86,-32},    extent = {{-8, 8}, {8, -8}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(extent={{-96,-64},{-76,-44}},      rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage Uc(
    V=Ua.V,
    phase=2.0943951023932,
    f=Ua.f) annotation (Placement(visible=true, transformation(
        origin={-62,-2},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=500) annotation (Placement(
        visible=true, transformation(
        origin={10,34},
        extent={{-8,-8},{8,8}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=r1.R) annotation (Placement(
        visible=true, transformation(
        origin={10,18},
        extent={{-8,-8},{8,8}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r3(R=r1.R) annotation (Placement(
        visible=true, transformation(
        origin={10,-2},
        extent={{-8,-8},{8,8}},
        rotation=0)));
  parameter Modelica.Electrical.Analog.Lines.Functions.LineGeometry g(
    n=4,
    x={0,-3.048,3.048,-9.144},
    y={12.192,12.192,12.192,3.048},
    r=1e-3/2*{12.7,12.7,12.7,4.064},
    R1=1e-3*{0.348,0.348,0.348,1.802},
    k_s={0.287,0.287,0.287,0.779},
    f=60)
    annotation (Placement(transformation(extent={{42,6},{62,26}})));
  Modelica.Electrical.Analog.Sources.SineVoltage Ua(V=345e3*sqrt(2/3), f=60)
    annotation (Placement(visible=true, transformation(
        origin={-62,36},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor body(R=1000) annotation (
      Placement(visible=true, transformation(
        origin={-18,-22},
        extent={{-8,8},{8,-8}},
        rotation=270)));

  parameter Real Rcomp[div(g.n * (g.n + 1), 2)]( each fixed=false) "Compact resistance matrix (ohm/m)";
  parameter Real Xcomp[div(g.n * (g.n + 1), 2)]( each fixed=false) "Compact reactance matrix (ohm/m)";
  parameter Real Lcomp[div(g.n * (g.n + 1), 2)]( each fixed=false) "Compact inductance (H/m)";

protected
  parameter Real Ccomp[div(g.n * (g.n + 1), 2)] = Modelica.Electrical.Analog.Lines.Functions.LineCmatrix(
                                    n = g.n, x = g.x, y = g.y, r = g.r);
initial algorithm
  (Rcomp,Xcomp,Lcomp) :=Modelica.Electrical.Analog.Lines.Functions.LineZmatrix(
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
    Line(points={{-86,-44},{-86,-40}},      color = {0, 0, 255}));
  connect(r1.p, line.n[1])
    annotation (Line(points={{2,34},{-18,34},{-18,18}}, color={0,0,255}));
  connect(r2.p, line.n[2])
    annotation (Line(points={{2,18},{-18,18}}, color={0,0,255}));
  connect(r1.n, r2.n) annotation (Line(points={{18,34},{22,34},{22,18},{18,18}},
        color={0,0,255}));
  connect(r2.n, r3.n) annotation (Line(points={{18,18},{22,18},{22,-2},{18,-2}},
        color={0,0,255}));
  connect(r3.p, line.n[3])
    annotation (Line(points={{2,-2},{-14,-2},{-14,14},{-18,14},{-18,18}},
                                                        color={0,0,255}));
  connect(Ua.n, line.p[1])
    annotation (Line(points={{-52,36},{-38,36},{-38,18}}, color={0,0,255}));
  connect(Ub.n, line.p[2])
    annotation (Line(points={{-52,18},{-38,18}}, color={0,0,255}));
  connect(Uc.n, line.p[3])
    annotation (Line(points={{-52,-2},{-38,-2},{-38,18}}, color={0,0,255}));
  connect(Ua.p, rgUL.p)
    annotation (Line(points={{-72,36},{-86,36},{-86,-24}}, color={0,0,255}));
  connect(Ub.p, rgUL.p)
    annotation (Line(points={{-72,18},{-86,18},{-86,-24}}, color={0,0,255}));
  connect(Uc.p, rgUL.p)
    annotation (Line(points={{-72,-2},{-86,-2},{-86,-24}}, color={0,0,255}));
  connect(body.p, line.n[4])
    annotation (Line(points={{-18,-14},{-18,18}}, color={0,0,255}));
  connect(body.n, ground.p) annotation (Line(points={{-18,-30},{-18,-44},{-86,
          -44}}, color={0,0,255}));
  connect(body.n, r3.n) annotation (Line(points={{-18,-30},{-18,-44},{22,-44},
          {22,-2},{18,-2}}, color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(extent = {{-100, -70}, {80, 70}})),
    Documentation(info="<html>
<p>This example shows the usage of M_OLine in a overhead PowerLine. The line geometry is the one shown in figure 4.1 of [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">EmtpTheoryBook</a>].</p>
<p>A common rule-of-thumb states that for steady-state analysis at industrial frequency each segment (PI model) should be not longer than one tenth of the wave length. For 50 Hz, the wavelength is 6000 km, therefore each pi should not overcome 60 km. This is why for our 100 km line we have chosen just two trunks. </p>
<p>This example has some limitations:</p>
<p>- the results are are valid only for their steady-state trend. If we want to simulate transients effectively, the number of trunks must be enlarged consistently. See example &quot;CmpLineTrunks&quot;. </p>
<p>- since it is based on M_OLine, which requires zero-valued resistances on the off-diagonal elements of Z impedance matrix, it does not take into account the influence of the soil resistance into Z matrix; however, for simulations like this one in wh&igrave;ch the current through the soil is neglibible and we analyse the results at power frequency where soil resistance is very low, this implies negligible errors</p>
<p><br>The considered line is a three-phase line with a fence all along the line (conductor #4). An interesting result of this example is the fence steady-state due to the capacitive coupling with the other wires.</p>
<p><u>Test 1:</u></p>
<p>Simulate the model as it is: a person (body) is supposed to be touching the fence, and absorbs the current body.i, around 1A, by large lethal</p>
<p><u>Test 2:</u></p>
<p>Simulate the model changing the body resistance to 1e6 or removing body: the steady-state fence voltage line.n[4] has changed from 1390V to 5930 (peak). So there exists a marked difference between the open-circuit voltage and body voltage which, although being much lower, is still very dangerous.</p>
<p><u>Test 3:</u></p>
<p>Simulate the original model reducing the line length to 3 km. The body current has fallen slightly below 30 mA (RMS), which is considered the maximum safe current a body can resist over 5s.</p>
<p>Note that the fence voltage before the human contact is roughtly the same for all lengths while the current flowing when contact occurs is very dependent on the line length. </p>
</html>",        revisions="<html>
<li><em>May, 2021</em> 
        Massimo Ceraolo of the University of Pisa <br> 
        originally created</li> 
</html>"),
    experiment(
      StopTime=0.04,
      Interval=0.0001,
      __Dymola_Algorithm="Dassl"));
end PowerLineWithFence;
