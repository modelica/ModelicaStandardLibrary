within Modelica.Electrical.Analog.Examples;
model IdealTriacCircuit "Ideal triac test circuit"
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-12,-40},{8,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor R(R=20) annotation (
      Placement(transformation(
        extent={{-10,-10},{12,12}},
        origin={-44,32})));
  Modelica.Electrical.Analog.Sources.SineVoltage V(V=5, f=2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-42,-20})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(width=50,
    period=0.25,
    startTime=0.1)
    annotation (Placement(transformation(extent={{-22,0},{-6,16}})));
 Modelica.Electrical.Analog.Ideal.IdealTriac idealTriac(capacitor(v(start=0, fixed=true)),idealThyristor(
                                                        off(               start=true, fixed=true)), idealThyristor1(off(start=true, fixed=true)))
    annotation (Placement(transformation(extent={{6,20},{32,46}})));

equation
  connect(V.n, ground.p) annotation (Line(
      points={{-32,-20},{-2,-20}}, color={0,0,255}));
  connect(R.p, V.p) annotation (Line(
      points={{-54,33},{-60,33},{-60,-20},{-52,-20}}, color={0,0,255}));
  connect(R.n, idealTriac.n) annotation (Line(
      points={{-32,33},{6,33}}, color={0,0,255}));
  connect(idealTriac.p, ground.p) annotation (Line(
      points={{32.52,33},{42,33},{42,-20},{-2,-20}}, color={0,0,255}));
  connect(idealTriac.fire1, booleanPulse.y) annotation (Line(
      points={{6,18.18},{0,18.18},{0,8},{-5.2,8}},    color={255,0,255}));
  annotation (experiment(StopTime=2),
    Documentation(revisions="<html>
<ul>
<li><em>November 25, 2009   </em><br>

       by Susann Wolf<br><br>
       </li>
</ul>
</html>", info="<html>
<p>The simple ideal TRIAC example shows how a triac is used within an alternating current circuit.</p>
<p>The TRIAC is not conducting until the Boolean input becomes true (internally coded by 1, therefore the input is called fire<strong>1</strong>). Then it becomes &quot;conducting&quot;, the knee voltage is reached. If the TRIAC voltage falls below the knee voltage, the TRIAC becomes blocking. Due to the antiparallel connection of the internal two thyristors the same behavior is repeated in the negative half-wave.</p>
<p>Simulate until 2 seconds. Display V.p.v (input voltage), booleanPulse.y (fire1 input), and both idealTriac.n.v and idealTriac.n.i, which demonstrate the TRIAC behavior.</p>
</html>"));
end IdealTriacCircuit;
