within Modelica.Electrical.Analog.Examples;
model ControlledSwitchWithArc

  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{20,-20},{40,0}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V=50)
    annotation (Placement(transformation(
        origin={-20,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor inductor1(L=0.1)
    annotation (Placement(transformation(extent={{40,30},{60,50}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1
    annotation (Placement(transformation(
        origin={80,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.ControlledIdealClosingSwitch switch1
                   annotation (Placement(transformation(extent={{0,30},{20,50}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground2
    annotation (Placement(transformation(extent={{20,-100},{40,-80}},
          rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage2(V=50)
    annotation (Placement(transformation(
        origin={-20,-60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor inductor2(L=0.1)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor2
    annotation (Placement(transformation(
        origin={80,-60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.ControlledCloserWithArc switch2
                   annotation (Placement(transformation(extent={{0,-50},{20,
            -30}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=1, freqHz=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-10})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
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
          40},{0,40}},     color={0,0,255}));
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
  connect(sineVoltage.p, switch1.control) annotation (Line(
      points={{-70,0},{-40,0},{-40,50},{10,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sineVoltage.p, switch2.control) annotation (Line(
      points={{-70,0},{-40,0},{-40,-30},{10,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sineVoltage.n, ground.p) annotation (Line(
      points={{-70,-20},{-70,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-100,80},{100,60}},
          lineColor={0,0,255},
          textString="Compare voltage and current of inductor1 and inductor2")}),
    experiment(
      StopTime=6,
      Interval=0.00025,
      Tolerance=1e-006),
    Documentation(info="<html>
<P>
This example is to compare the behaviour of switch models with
and without an electric arc taking into consideration.<br><br>

</P>
<P>
Simulate until T=2 s.
</P>
<P>
Plot in one windows:<br> <br>
switch1.i and switch2.i <br><br>

The difference in the closing area shows that the simple arc model avoids
the suddenly switching.

</P>
</html>",
        revisions="<html>
<ul>
<li><i>May, 2009   </i>
       by Anton Haumer<br> initially realized<br>
       </li>
</ul>
</html>"));
end ControlledSwitchWithArc;
