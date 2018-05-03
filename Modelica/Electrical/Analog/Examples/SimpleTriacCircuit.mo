within Modelica.Electrical.Analog.Examples;
model SimpleTriacCircuit "Simple triac test circuit"
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Electrical.Analog.Basic.Inductor L(L=2e-6, i(start=0, fixed=true),
    p(                                                          v(  start=0)))
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Electrical.Analog.Basic.Resistor R(R=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,30})));
  Modelica.Electrical.Analog.Sources.SineVoltage V(V=30, freqHz=10000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-10})));
  Modelica.Electrical.Analog.Semiconductors.SimpleTriac simpleTriac(VDRM=400, VRRM=400,
    thyristor1(                                                                         vGK(           start=0)))
                          annotation (Placement(transformation(
        extent={{-13,-13},{11,11}},
        rotation=270,
        origin={1,23})));
  Modelica.Electrical.Analog.Sources.PulseCurrent pulseCurrent(
    I=0.005,
    width=10,
    startTime=0.00002,
    period=0.00005)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-10})));

initial equation
     simpleTriac.thyristor.vControl=0;
    simpleTriac.thyristor1.vControl=0;

equation
  connect(L.n, R.p) annotation (Line(
      points={{40,60},{60,60},{60,40}}, color={0,0,255}));
  connect(R.n, V.p) annotation (Line(
      points={{60,20},{60,0}}, color={0,0,255}));
  connect(V.n, ground.p) annotation (Line(
      points={{60,-20},{60,-40},{0,-40}}, color={0,0,255}));
  connect(simpleTriac.p, ground.p) annotation (Line(
      points={{0,11.52},{0,-40}}, color={0,0,255}));
  connect(simpleTriac.n, L.p) annotation (Line(
      points={{0,36},{0,60},{20,60}}, color={0,0,255}));
  connect(pulseCurrent.n, simpleTriac.g) annotation (Line(
      points={{-40,0},{-40,40},{-11.52,40},{-11.52,31.44}}, color={0,0,255}));
  connect(pulseCurrent.p, ground.p) annotation (Line(
      points={{-40,-20},{-40,-40},{0,-40}}, color={0,0,255}));
  annotation (experiment(
      StopTime=0.001,
      Interval=5e-7,
      Tolerance=1e-12),
    Documentation(revisions="<html>
<ul>
<li><em>November 25, 2009   </em><br>

       by Susann Wolf<br><br>
       </li>
</ul>
</html>", info="<html>
<p>The simple TRIAC example shows how the SimpleTriac is used within an alternating current circuit.</p>
<p>The TRIAC is not conducting until the Gate input g becomes positive. Then it becomes &quot;conducting&quot;. If the TRIAC voltage changes its direction, the TRIAC becomes blocking. Due to the antiparallel connection of the internal two thyristors the same behavior is repeated in the negative half-wave.</p>
<p>Simulate until 0.001 seconds. Display V.p.v (input voltage), simpleTriac.g.i  (gate input), and both simplelTriac.n.v and simpleTriac.n.i, which demonstrate the TRIAC behavior.</p>
</html>"));
end SimpleTriacCircuit;
