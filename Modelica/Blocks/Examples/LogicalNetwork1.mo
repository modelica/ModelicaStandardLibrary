within Modelica.Blocks.Examples;
model LogicalNetwork1 "Demonstrates the usage of logical blocks"

  extends Modelica.Icons.Example;
  Sources.BooleanTable table2(table={1,3,5,7}) annotation (Placement(
        transformation(extent={{-80,-20},{-60,0}})));
  Sources.BooleanTable table1(table={2,4,6,8}) annotation (Placement(
        transformation(extent={{-80,20},{-60,40}})));
  Logical.Not Not1 annotation (Placement(transformation(extent={{-40,-20},{-20,
            0}})));

  Logical.And And1 annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Logical.Or Or1 annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Logical.Pre Pre1 annotation (Placement(transformation(extent={{-40,-60},{-20,
            -40}})));
equation

  connect(table2.y, Not1.u)
    annotation (Line(points={{-59,-10},{-42,-10}}, color={255,0,255}));
  connect(And1.y, Or1.u2) annotation (Line(points={{21,-10},{28,-10},{28,22},
          {38,22}}, color={255,0,255}));
  connect(table1.y, Or1.u1)
    annotation (Line(points={{-59,30},{38,30}}, color={255,0,255}));
  connect(Not1.y, And1.u1)
    annotation (Line(points={{-19,-10},{-2,-10}}, color={255,0,255}));
  connect(Pre1.y, And1.u2) annotation (Line(points={{-19,-50},{-10,-50},{-10,
          -18},{-2,-18}}, color={255,0,255}));
  connect(Or1.y, Pre1.u) annotation (Line(points={{61,30},{68,30},{68,-70},{-60,
          -70},{-60,-50},{-42,-50}}, color={255,0,255}));

  annotation (experiment(StopTime=10), Documentation(info="<html>
<p>
This example demonstrates a network of logical blocks. Note, that
the Boolean values of the input and output signals are visualized
in the diagram animation, by the small \"circles\" close to the connectors.
If a \"circle\" is \"white\", the signal is <strong>false</strong>. It a
\"circle\" is \"green\", the signal is <strong>true</strong>.
</p>
</html>"));
end LogicalNetwork1;
