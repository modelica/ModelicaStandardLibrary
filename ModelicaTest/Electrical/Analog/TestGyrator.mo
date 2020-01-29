within ModelicaTest.Electrical.Analog;
model TestGyrator "Simple demo to test Gyrator"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(transformation(extent={{-40,-54},{-20,-34}})));
  Modelica.Electrical.Analog.Basic.Gyrator gyrator(G1=1, G2=2) annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage v1(V=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,0})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage v2(V=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,0})));
  Modelica.Electrical.Analog.Basic.Ground ground2
    annotation (Placement(transformation(extent={{20,-54},{40,-34}})));
equation
  connect(v1.p, gyrator.p1) annotation (Line(points={{-30,10},{-30,20},{-10,20},{-10,8}}, color={0,0,255}));
  connect(v1.n, gyrator.n1) annotation (Line(points={{-30,-10},{-30,-20},{-10,-20},{-10,-12}}, color={0,0,255}));
  connect(v1.n, ground1.p) annotation (Line(points={{-30,-10},{-30,-34}}, color={0,0,255}));
  connect(v2.p, gyrator.p2) annotation (Line(points={{30,10},{30,20},{10,20},{10,8}}, color={0,0,255}));
  connect(v2.n, gyrator.n2) annotation (Line(points={{30,-10},{30,-20},{10,-20},{10,-12}}, color={0,0,255}));
  connect(v2.n,ground2. p) annotation (Line(points={{30,-10},{30,-34}}, color={0,0,255}));
  annotation (experiment(StopTime=1),
    Documentation(info="<html>
<p>This simple circuit uses the Gyrator.</p>
</html>"));
end TestGyrator;
