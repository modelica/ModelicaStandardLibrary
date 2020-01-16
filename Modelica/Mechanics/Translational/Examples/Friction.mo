within Modelica.Mechanics.Translational.Examples;
model Friction "Use of model Stop"
  extends Modelica.Icons.Example;
  Modelica.Mechanics.Translational.Components.MassWithStopAndFriction stop1(
    L=1,
    s(fixed=true),
    v(fixed=true),
    smax=25,
    smin=-25,
    m=1,
    F_prop=1,
    F_Coulomb=5,
    F_Stribeck=10,
    fexp=2) annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Translational.Sources.Force force annotation (Placement(transformation(
          extent={{-20,60},{0,80}})));
  Modelica.Blocks.Sources.Sine sineForce(amplitude=25, f=0.25)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Mechanics.Translational.Components.MassWithStopAndFriction stop2(
    L=1,
    smax=0.9,
    smin=-0.9,
    F_Coulomb=3,
    F_Stribeck=5,
    s(start=0, fixed=true),
    m=1,
    F_prop=1,
    fexp=2,
    v(start=-5, fixed=true)) annotation (Placement(transformation(extent={{38,-60},{58,-40}})));
  Translational.Components.Spring spring(s_rel0=1, c=500) annotation (
      Placement(transformation(extent={{0,-60},{20,-40}})));
  Translational.Components.Fixed fixed2(s0=-1.75) annotation (Placement(
        transformation(extent={{-40,-60},{-20,-40}})));
  Translational.Sources.Force force2 annotation (Placement(transformation(
          extent={{-20,0},{0,20}})));
  Components.Mass mass(
    m=1,
    L=1,
    s(fixed=true),
    v(fixed=true))
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Components.SupportFriction supportFriction(f_pos=Examples.Utilities.GenerateStribeckFrictionTable(
            F_prop=1,
            F_Coulomb=5,
            F_Stribeck=10,
            fexp=2,
            v_max=12,
            nTable=50))
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
equation
  connect(spring.flange_b, stop2.flange_a)
    annotation (Line(points={{20,-50},{38,-50}}, color={0,127,0}));
  connect(sineForce.y, force.f)
    annotation (Line(points={{-39,70},{-22,70}}, color={0,0,127}));
  connect(spring.flange_a, fixed2.flange) annotation (Line(
      points={{0,-50},{-30,-50}}, color={0,127,0}));
  connect(force.flange, stop1.flange_a) annotation (Line(
      points={{0,70},{20,70}}, color={0,127,0}));
  connect(force2.flange, mass.flange_a) annotation (Line(
      points={{0,10},{10,10}},  color={0,127,0}));
  connect(mass.flange_b, supportFriction.flange_a) annotation (Line(
      points={{30,10},{40,10}}, color={0,127,0}));
  connect(sineForce.y, force2.f) annotation (Line(
      points={{-39,70},{-30,70},{-30,10},{-22,10}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
              extent={{-100,80},{-80,60}},
              textString="1)",
              lineColor={0,0,255}),Text(
              extent={{-100,20},{-80,0}},
              textString="2)",
              lineColor={0,0,255}),Text(
              extent={{-100,-40},{-80,-60}},
              textColor={0,0,255},
              textString="3)")}),
    Documentation(info="<html>
<ol>
<li> Simulate and then plot stop1.f as a function of stop1.v
     This gives the Stribeck curve.</li>
<li> The same model is also available by modeling the system with a Mass and
     a SupportFriction model. The SupportFriction model defines the friction characteristic
     with a table. The table is constructed with function
     Examples.Utilities.GenerateStribeckFrictionTable(&hellip;) to generate the
     same friction characteristic as with stop1.
     The simulation results of stop1 and of model mass are therefore identical.</li>
<li> Model stop2 gives an example for a hard stop. However there
     can arise some problems with the used modeling approach (use of
     <strong>reinit</strong>(&hellip;), convergence problems). In this case use the ElastoGap
     to model a stop (see example Preload).</li>
</ol>
</html>"),
    experiment(StopTime=5.0, Interval=0.001));
end Friction;
