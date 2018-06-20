within Modelica.Electrical.Analog.Examples;
model CharacteristicThyristors "Characteristic of ideal thyristors"

  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Ideal.IdealThyristor IdealThyristor1(
                             off(start=true, fixed= true), Vknee=1)
                           annotation (Placement(transformation(extent={{-20,30},
            {0,50}})));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(V=10,
      offset=0,
    freqHz=1) annotation (Placement(transformation(
        origin={-40,-60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground Ground1
  annotation (Placement(transformation(extent={{-50,-108},{-30,-88}})));
  Modelica.Electrical.Analog.Basic.Resistor R3(R=1e-3)
  annotation (Placement(transformation(extent={{40,30},{60,50}})));

  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor IdealGTOThyristor1(
                                off(fixed=true, start=true), Vknee=1)
                              annotation (Placement(transformation(extent={{-20,0},
            {0,20}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1e-3)
  annotation (Placement(transformation(extent={{40,0},{60,20}})));

  Blocks.Sources.BooleanTable booleanStep1(table={1.25,3.2,4.2,4.25,5.7,5.72})
    annotation (Placement(transformation(extent={{-68,44},{-48,64}})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor IdealThyristor2(
                             off(start=true, fixed= true), Vknee=1)
                           annotation (Placement(transformation(extent={{-20,-50},
            {0,-30}})));
  Modelica.Electrical.Analog.Basic.Resistor R2(R=1e-3)
  annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor IdealGTOThyristor2(
                                off(fixed=true, start=true), Vknee=1)
                              annotation (Placement(transformation(extent={{-20,-80},
            {0,-60}})));
  Modelica.Electrical.Analog.Basic.Resistor R4(R=1e-3)
  annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Blocks.Sources.BooleanPulse booleanPulse(
    width=20,
    period=1,
    startTime=0.15)
    annotation (Placement(transformation(extent={{-68,-30},{-48,-10}})));
initial equation
 // IdealThyristor1.off = true;

equation
  connect(IdealThyristor1.n, R3.p)
  annotation (Line(points={{0,40},{40,40}}, color={0,0,255}));
  connect(Ground1.p, SineVoltage1.n)
  annotation (Line(points={{-40,-88},{-40,-70}}, color={0,0,255}));
  connect(SineVoltage1.p, IdealThyristor1.p)
  annotation (Line(points={{-40,-50},{-40,40},{-20,40}}, color={0,0,255}));
  connect(IdealGTOThyristor1.n, R1.p)
  annotation (Line(points={{0,10},{40,10}}, color={0,0,255}));
  connect(R3.n, R1.n)
  annotation (Line(points={{60,40},{60,10}}, color={0,0,255}));
  connect(IdealGTOThyristor1.p, IdealThyristor1.p)
  annotation (Line(points={{-20,10},{-20,40}}, color={0,0,255}));
  connect(IdealGTOThyristor1.fire, IdealThyristor1.fire)
  annotation (Line(points={{0,22},{0,36},{-2,36},{-2,44},{0,44},{0,52}},         color={255,0,255}));
  connect(IdealThyristor1.fire, booleanStep1.y) annotation (Line(
      points={{0,52},{0,54},{-47,54}},   color={255,0,255}));
  connect(IdealThyristor2.n,R2. p)
  annotation (Line(points={{0,-40},{40,-40}}, color={0,0,255}));
  connect(IdealGTOThyristor2.n,R4. p)
  annotation (Line(points={{0,-70},{40,-70}}, color={0,0,255}));
  connect(R2.n,R4. n)
  annotation (Line(points={{60,-40},{60,-70}}, color={0,0,255}));
  connect(IdealGTOThyristor2.p,IdealThyristor2. p)
  annotation (Line(points={{-20,-70},{-20,-40}}, color={0,0,255}));
  connect(IdealGTOThyristor2.fire,IdealThyristor2. fire)
  annotation (Line(points={{0,-58},{0,-44},{-2,-44},{-2,-36},{0,-36},{0,-28}},
                 color={255,0,255}));
  connect(R4.n, Ground1.p) annotation (Line(
      points={{60,-70},{60,-88},{-40,-88}}, color={0,0,255}));
  connect(R2.n, R1.n) annotation (Line(
      points={{60,-40},{60,10}}, color={0,0,255}));
  connect(SineVoltage1.p, IdealThyristor2.p) annotation (Line(
      points={{-40,-50},{-40,-40},{-20,-40}}, color={0,0,255}));
  connect(booleanPulse.y, IdealThyristor2.fire) annotation (Line(
      points={{-47,-20},{0,-20},{0,-28}},   color={255,0,255}));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-96,100},{98,60}},
          textString="Characteristic Thyristors",
          lineColor={0,0,255})}), Documentation(info="<html>
<p>This example compares the behavior of the <strong>ideal thyristor</strong> and the <strong>ideal GTO thyristor</strong> with <em>Vknee=1</em> both. The thyristors IdealThyristor1 and IdealGTOThyristor1 are controlled by an unregular Boolean fire signal. The aim is to show several cases for the fire signal in combination with the state (s&lt;0 or s&gt;0)of the thyristors. Please simulate until 6 seconds and compare IdealThyristor1.v with IdealGTOThyristor1.v, the same with IdealThyristor1.s and IdealGTOThyristor1.s (attention: s is a protected variable in each thyristor). Also compare IdealThyristor1.off and IdealGTOThyristor1.off and have a look at the fire signal (e.g. IdealThyristor1.fire). It can be seen that the IdealGTOThyristor1 reacts on switching off the fire signal whereas the IdealThyristor1 does not show this behavior.</p>
<p>The other thyristors IdealThyristor2 and IdealGTOThyristor2 are controlled by an periodic Boolean fire signal to show a typical use case. Please compare IdealThyristor2.v with IdealGTOThyristor2.v</p>
</html>",
   revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>Jan 23, 2013   </em>
       by Kristin Majetta and Christoph Clauss<br> revised<br>
       </li>
</ul>
<ul>
<li><em>Mai 7, 2004   </em>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</html>"), experiment(StopTime=6));
end CharacteristicThyristors;
