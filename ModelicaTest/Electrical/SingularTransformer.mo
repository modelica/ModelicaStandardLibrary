within ModelicaTest.Electrical;
model SingularTransformer
  extends Modelica.Icons.Example;
  parameter Real L=2 annotation (Evaluate=true);
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage1(
    V=220,
    phase=0,
    f=50,
    offset=0) annotation (Placement(transformation(
        origin={-82,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(
        transformation(extent={{-92,0},{-72,20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor11(R=0.1) annotation (
      Placement(transformation(extent={{-82,50},{-62,70}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor12(R=0.1) annotation (
      Placement(transformation(extent={{58,50},{78,70}})));
  Modelica.Electrical.Analog.Basic.Resistor load1(R=2) annotation (Placement(
        transformation(
        origin={78,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(
        transformation(extent={{68,0},{88,20}})));
  Modelica.Electrical.Analog.Basic.Transformer basicTransformer(
    L1=L,
    L2=L,
    M=L,
    i1(fixed=true)) annotation (Placement(transformation(extent={{-10,32},{10,52}})));
equation
  connect(sineVoltage1.n, ground1.p)
    annotation (Line(points={{-82,30},{-82,20}}, color={0,0,255}));
  connect(sineVoltage1.p, resistor11.p)
    annotation (Line(points={{-82,50},{-82,60}}, color={0,0,255}));
  connect(load1.n, ground2.p)
    annotation (Line(points={{78,30},{78,20}}, color={0,0,255}));
  connect(resistor12.n, load1.p)
    annotation (Line(points={{78,60},{78,50}}, color={0,0,255}));
  connect(ground1.p, basicTransformer.n1)
    annotation (Line(points={{-82,20},{-10,20},{-10,37}}, color={0,0,255}));
  connect(basicTransformer.n2, ground2.p)
    annotation (Line(points={{10,37},{10,20},{78,20}}, color={0,0,255}));
  connect(basicTransformer.p1, resistor11.n) annotation (Line(points={{-10,47},
          {-10,48},{-30,48},{-46,48},{-46,60},{-62,60}}, color={0,0,255}));
  connect(basicTransformer.p2, resistor12.p) annotation (Line(points={{10,47},
          {10,46},{20,46},{40,46},{40,60},{58,60}}, color={0,0,255}));
  annotation (
    Documentation(info="<html>
<p>
This model shows a transformer, where the transformer has not 2 states, but only
1 state since L1=L2=M. Some tools might be not able to detect this. In this
case, translation or simulation fails with a division by zero.
</p>
</html>"),
    experiment(StopTime=1.1));
end SingularTransformer;
