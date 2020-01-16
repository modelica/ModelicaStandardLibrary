within Modelica.Mechanics.Translational.Examples;
model WhyArrows "Use of arrows in Mechanics.Translational"

  extends Modelica.Icons.Example;

  Translational.Components.Fixed fixed annotation (Placement(transformation(
          extent={{-20,20},{0,40}})));
  Translational.Components.Rod rod1(L=1) annotation (Placement(
        transformation(extent={{-48,20},{-28,40}})));
  Translational.Components.Rod rod2(L=1) annotation (Placement(
        transformation(extent={{20,20},{40,40}})));
  Translational.Components.Rod rod3(L=1) annotation (Placement(
        transformation(extent={{-30,58},{-50,78}})));
  Translational.Sensors.PositionSensor positionSensor2 annotation (
      Placement(transformation(extent={{60,20},{80,40}})));
  Translational.Sensors.PositionSensor positionSensor1 annotation (
      Placement(transformation(extent={{-60,20},{-80,40}})));
  Translational.Sensors.PositionSensor positionSensor3 annotation (
      Placement(transformation(extent={{-60,58},{-80,78}})));
  Translational.Components.Fixed fixed1(s0=-1.9) annotation (Placement(
        transformation(extent={{-100,-60},{-80,-40}})));
  Translational.Components.Spring spring1(s_rel0=2, c=11) annotation (
      Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Translational.Components.Mass mass1(
    L=2,
    s(fixed=true),
    v(fixed=true),
    m=1) annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
  Translational.Components.Fixed fixed2(s0=-1.9) annotation (Placement(
        transformation(extent={{0,-60},{20,-40}})));
  Translational.Components.Spring spring2(s_rel0=2, c=11) annotation (
      Placement(transformation(extent={{30,-60},{50,-40}})));
  Translational.Components.Mass inertia2(
    L=2,
    m=1,
    s(fixed=true),
    v(fixed=true)) annotation (Placement(transformation(extent={{80,-60},{
            60,-40}})));
equation
  connect(spring1.flange_b, mass1.flange_b) annotation (Line(points={{-60,-50},
          {-60,-72},{-30,-72},{-30,-50}}, color={0,127,0}));
  connect(spring2.flange_b, inertia2.flange_b)
    annotation (Line(points={{50,-50},{60,-50}}, color={0,127,0}));
  connect(rod3.flange_b, positionSensor3.flange) annotation (Line(
      points={{-50,68},{-60,68}}, color={0,127,0}));
  connect(rod1.flange_a, positionSensor1.flange) annotation (Line(
      points={{-48,30},{-60,30}}, color={0,127,0}));
  connect(rod1.flange_b, fixed.flange) annotation (Line(
      points={{-28,30},{-10,30}}, color={0,127,0}));
  connect(rod3.flange_a, fixed.flange) annotation (Line(
      points={{-30,68},{-10,68},{-10,30}}, color={0,127,0}));
  connect(fixed.flange, rod2.flange_a) annotation (Line(
      points={{-10,30},{20,30}}, color={0,127,0}));
  connect(rod2.flange_b, positionSensor2.flange) annotation (Line(
      points={{40,30},{60,30}}, color={0,127,0}));
  connect(fixed1.flange, spring1.flange_a) annotation (Line(
      points={{-90,-50},{-80,-50}}, color={0,127,0}));
  connect(fixed2.flange, spring2.flange_a) annotation (Line(
      points={{10,-50},{30,-50}}, color={0,127,0}));
  annotation (
    Documentation(info="<html>
<p>
When using the models of the translational sublibrary
it is recommended to make sure that all arrows point in
the same direction because then all component have the
same reference system.
In the example the distance from flange_a of Rod1 to flange_b
of Rod2 is 2&nbsp;m. The distance from flange_a of Rod1 to flange_b
of Rod3 is also 2&nbsp;m though it is difficult to see that. Without
the arrows it would be almost impossible to notice.
That all arrows point in the same direction is a sufficient
condition for an easy use of the library. There are cases
where horizontally flipped models can be used without
problems.
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
              extent={{-84,10},{88,2}},
              textColor={0,0,255},
              textString="positionSensor2.s = positionSensor3.s"),Text(
              extent={{-78,-4},{86,-12}},
              textColor={0,0,255},
              textString="positionSensor3.s <>positionSensor1.s"),Text(
              extent={{-82,-80},{92,-88}},
              textString="Both systems are equivalent",
              textColor={0,0,255}),Line(
              points={{-90,-28},{90,-28}},
              thickness=0.5,
              color={0,0,255})}),
    experiment(StopTime=1.0, Interval=0.001));
end WhyArrows;
