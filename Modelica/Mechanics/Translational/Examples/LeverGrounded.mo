within Modelica.Mechanics.Translational.Examples;
model LeverGrounded "Translational grounded lever"
  extends Modelica.Icons.Example;

  Sources.Force force(
    useSupport=false) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Components.Mass mass1(
    m=0.1) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Components.IdealLever idealLever(
    ratio=1.6, useSupport=true)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Components.Mass mass2(
    m=7,
    s(fixed=true, start=0),
    v(fixed=true, start=0)) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=10,
    f=5)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Components.Fixed fixed annotation (Placement(transformation(extent={{-48,-60},{-28,-40}})));
  Components.SpringDamper springDamper(
    s_rel(fixed=true),
    v_rel(fixed=true),
    c=800,
    d=50) annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
equation
  connect(mass1.flange_b, idealLever.flange_a) annotation (Line(points={{0,0},{10,0}},    color={0,127,0}));
  connect(idealLever.flange_b, mass2.flange_a) annotation (Line(points={{30,0},{40,0}}, color={0,127,0}));
  connect(sine.y, force.f) annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  connect(force.flange, mass1.flange_a) annotation (Line(points={{-30,0},{-20,0}}, color={0,127,0}));
  connect(fixed.flange, springDamper.flange_a) annotation (Line(points={{-38,-50},{-20,-50}}, color={0,127,0}));
  connect(springDamper.flange_b, idealLever.support) annotation (Line(points={{0,-50},{20,-50},{20,-10}}, color={0,127,0}));
  annotation (
    experiment(
      StopTime=1.0,
      Interval=0.001),
    Documentation(info="<html>
<p>
The <code>flange_a</code> of the lever is driven by a sine-wave motor force.
Via a lever the translational energy is transmitted to a load mass.
The lever is elastically mounted. 
For ratio <code>idealLever.ratio&nbsp;&gt;&nbsp;1</code> the 2nd class lever is
realized, i.e. the driven flange <code>flange_b</code> is located between the
driving flange <code>flange_a</code> and the lever&apos;s <code>support</code>.
</p>
<p>
Simulate for 1&nbsp;second and plot the velocities of masses:
<code>mass2.v</code>, <code>mass2.v</code>
</p>
</html>"));
end LeverGrounded;
