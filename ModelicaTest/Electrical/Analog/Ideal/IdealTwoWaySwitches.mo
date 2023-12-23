within ModelicaTest.Electrical.Analog.Ideal;
model IdealTwoWaySwitches "Test of IdealTwoWaySwitch and ControlledIdealTwoWaySwitch"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation(Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,0})));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=2)
    annotation(Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,20})));
  Modelica.Electrical.Analog.Ideal.IdealTwoWaySwitch twoWay annotation (Placement(transformation(extent={{-40,50},{-20,30}})));
  Modelica.Electrical.Analog.Ideal.ControlledIdealTwoWaySwitch controlledTwoWay annotation (Placement(transformation(extent={{40,70},{60,50}})));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=1)
    annotation(Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-20})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.5) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Electrical.Analog.Basic.Resistor r3(R=1)
    annotation(Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,20})));
  Modelica.Electrical.Analog.Basic.Resistor r4(R=2)
    annotation(Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-20})));
equation
  connect(ground.p, constantVoltage.n) annotation (Line(points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
  connect(r1.n, r2.p) annotation (Line(points={{20,10},{20,-10}}, color={0,0,255}));
  connect(r2.n, constantVoltage.n) annotation (Line(points={{20,-30},{20,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
  connect(constantVoltage.p, twoWay.p) annotation (Line(points={{-80,10},{-80,40},{-40,40}}, color={0,0,255}));
  connect(twoWay.n2, r1.p) annotation (Line(points={{-20,40},{20,40},{20,30}}, color={0,0,255}));
  connect(twoWay.n1, r2.p) annotation (Line(points={{-20,36},{-16,36},{-16,0},{20,0},{20,-10}}, color={0,0,255}));
  connect(booleanStep.y, twoWay.control) annotation (Line(points={{-39,0},{-30,0},{-30,28}}, color={255,0,255}));
  connect(controlledTwoWay.p, twoWay.p) annotation (Line(points={{40,60},{-80,60},{-80,40},{-40,40}}, color={0,0,255}));
  connect(controlledTwoWay.control, r2.p) annotation (Line(points={{50,50},{50,0},{20,0},{20,-10}}, color={0,0,255}));
  connect(controlledTwoWay.n2, r3.p) annotation (Line(points={{60,60},{80,60},{80,30}}, color={0,0,255}));
  connect(controlledTwoWay.n1, r4.p) annotation (Line(points={{60,56},{68,56},{68,0},{80,0},{80,-10}}, color={0,0,255}));
  connect(r3.n, r4.p) annotation (Line(points={{80,10},{80,-10}}, color={0,0,255}));
  connect(r4.n, constantVoltage.n) annotation (Line(points={{80,-30},{80,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
  annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
A test example for the two switches <a href=\"modelica:/Modelica.Electrical.Analog.Ideal.IdealTwoWaySwitch\">IdealTwoWaySwitch</a>
and <a href=\"modelica:/Modelica.Electrical.Analog.Ideal.ControlledIdealTwoWaySwitch\">ControlledIdealTwoWaySwitch</a>
</p>
</html>"));
end IdealTwoWaySwitches;
