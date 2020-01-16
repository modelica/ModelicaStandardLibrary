within Modelica.Mechanics.Translational.Examples;
model Damper "Use of damper models"

  extends Modelica.Icons.Example;

  Translational.Components.Mass mass1(
    L=1,
    s(start=3, fixed=true),
    v(start=10, fixed=true),
    m=1) annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Translational.Components.Damper damper1(d=25) annotation (Placement(
        transformation(extent={{-10,50},{10,70}})));
  Translational.Components.Fixed fixed1(s0=4.5) annotation (Placement(
        transformation(extent={{30,50},{50,70}})));
  Translational.Components.Mass mass2(
    L=1,
    s(start=3, fixed=true),
    v(start=10, fixed=true),
    m=1) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Translational.Components.Damper damper2(d=25) annotation (Placement(
        transformation(extent={{-10,0},{10,20}})));
  Translational.Components.Fixed fixed2(s0=4.5) annotation (Placement(
        transformation(extent={{30,-10},{50,10}})));
  Translational.Components.Mass mass3(
    L=1,
    s(start=3, fixed=true),
    v(start=10, fixed=true),
    m=1) annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Translational.Components.Fixed fixed3(s0=4.5) annotation (Placement(
        transformation(extent={{30,-70},{50,-50}})));
  Translational.Components.Spring spring2(s_rel0=1, c=1) annotation (
      Placement(transformation(extent={{-10,-20},{10,0}})));
  Translational.Components.SpringDamper springDamper3(
    s_rel0=1,
    d=25,
    c=1) annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
equation
  connect(mass1.flange_b, damper1.flange_a)
    annotation (Line(points={{-40,60},{-10,60}}, color={0,127,0}));
  connect(mass2.flange_b, damper2.flange_a)
    annotation (Line(points={{-40,0},{-20,0},{-20,10},{-10,10}},
                                                 color={0,127,0}));
  connect(damper2.flange_b, spring2.flange_b)
    annotation (Line(points={{10,10},{20,10},{20,-10},{10,-10}},
                                              color={0,127,0}));
  connect(damper2.flange_a, spring2.flange_a)
    annotation (Line(points={{-10,10},{-20,10},{-20,-10},{-10,-10}},
                                                  color={0,127,0}));
  connect(mass3.flange_b, springDamper3.flange_a)
    annotation (Line(points={{-40,-60},{-10,-60}}, color={0,127,0}));
  connect(damper1.flange_b, fixed1.flange) annotation (Line(
      points={{10,60},{40,60}},color={0,127,0}));
  connect(damper2.flange_b, fixed2.flange) annotation (Line(points={{10,10},{20,10},{20,0},{40,0}},
                                                                                     color={0,127,0}));
  connect(springDamper3.flange_b, fixed3.flange) annotation (Line(
      points={{10,-60},{40,-60}},color={0,127,0}));
  annotation (Documentation(info="<html>
<p>
Demonstrate usage of a translational damper component in various configurations.
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end Damper;
