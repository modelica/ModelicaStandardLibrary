within Modelica.Electrical.Analog.Examples;
model SwitchWithArc "Comparison of switch models both with and without arc"

  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=1)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V=50)
    annotation (Placement(transformation(
        origin={-20,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor inductor1(L=0.1, i(start=0, fixed=true))
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=1)
    annotation (Placement(transformation(
        origin={80,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1
                   annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Electrical.Analog.Basic.Ground ground2
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage2(V=50)
    annotation (Placement(transformation(
        origin={-20,-60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor inductor2(L=0.1, i(start=0, fixed=true))
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=1)
    annotation (Placement(transformation(
        origin={80,-60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.CloserWithArc switch2(
    dVdt=10000,
    V0=30,
    Vmax=60,
    off(fixed=true))
                   annotation (Placement(transformation(extent={{0,-50},{20,
            -30}})));

equation
  connect(inductor1.n,resistor1. p) annotation (Line(points={{60,40},{80,40},
          {80,30}}, color={0,0,255}));
  connect(resistor1.n,ground1. p)
    annotation (Line(points={{80,10},{80,0},{30,0}}, color={0,0,255}));
  connect(constantVoltage1.n,ground1. p)
    annotation (Line(points={{-20,10},{-20,0},{30,0}}, color={0,0,255}));
  connect(switch1.n,inductor1. p)
    annotation (Line(points={{20,40},{40,40}}, color={0,0,255}));
  connect(constantVoltage1.p,switch1. p) annotation (Line(points={{-20,30},{-20,
          40},{0,40}}, color={0,0,255}));
  connect(inductor2.n,resistor2. p) annotation (Line(points={{60,-40},{80,-40},
          {80,-50}}, color={0,0,255}));
  connect(resistor2.n,ground2. p)
    annotation (Line(points={{80,-70},{80,-80},{30,-80}}, color={0,0,255}));
  connect(constantVoltage2.n,ground2. p)
    annotation (Line(points={{-20,-70},{-20,-80},{30,-80}}, color={0,0,255}));
  connect(switch2.n,inductor2. p)
    annotation (Line(points={{20,-40},{40,-40}}, color={0,0,255}));
  connect(constantVoltage2.p,switch2. p) annotation (Line(points={{-20,-50},{
          -20,-40},{0,-40}}, color={0,0,255}));
  connect(booleanPulse.y, switch1.control) annotation (Line(points={{-59,-20},
          {-40,-20},{-40,60},{10,60},{10,47}}, color={255,0,255}));
  connect(booleanPulse.y, switch2.control) annotation (Line(points={{-59,-20},
          {10,-20},{10,-30}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-100,80},{100,60}},
          textColor={0,0,255},
          textString="Compare voltage and current of inductor1 and inductor2")}),
    experiment(
      StopTime=2,
      Interval=0.00025,
      Tolerance=1e-006),
    Documentation(info="<html>
<p>This example is to compare the behaviour of switch models with and without an electric arc taking into consideration.</p>
<ul>
<li>Simulate until T=2 s.</li>
<li>Plot in one window:  <code>switch1.i</code> and <code>switch2.i</code></li>
</ul>
<p>The difference in the closing area shows that the simple arc model avoids the suddenly switching.</p>
</html>",
        revisions="<html>
<ul>
<li><em>May, 2009   </em>
       by Anton Haumer<br> initially realized<br>
       </li>
</ul>
</html>"));
end SwitchWithArc;
