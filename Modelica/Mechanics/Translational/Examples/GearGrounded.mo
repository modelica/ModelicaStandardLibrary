within Modelica.Mechanics.Translational.Examples;
model GearGrounded "Translational grounded gear"
  extends Modelica.Icons.Example;

  Sources.Force force annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Components.IdealGear idealGear(
    ratio=1.6,
    useSupport=true) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Components.Mass mass1(
    m=0.1) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Components.Mass mass2(
    m=7,
    s(fixed=true, start=0),
    v(fixed=true, start=0)) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Components.SpringDamper springDamper(
    c=160,
    d=10,
    s_rel0=0.1) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Components.SpringDamper springDamperSupport(
    s_rel(fixed=true),
    v_rel(fixed=true),
    c=800,
    d=50) annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Blocks.Sources.Ramp ramp(
    height=10,
    duration=0.6,
    offset=springDamper.s_rel0*springDamper.c/idealGear.ratio,
    startTime=0.3)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Components.Fixed fixed annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Components.Fixed fixed1 annotation (Placement(transformation(extent={{70,-10},{90,10}})));
equation
  connect(mass1.flange_b, idealGear.flange_a) annotation (Line(points={{-20,0},{-10,0}}, color={0,127,0}));
  connect(idealGear.flange_b, mass2.flange_a) annotation (Line(points={{10,0},{20,0}}, color={0,127,0}));
  connect(ramp.y, force.f) annotation (Line(points={{-79,0},{-72,0}}, color={0,0,127}));
  connect(force.flange, mass1.flange_a) annotation (Line(points={{-50,0},{-40,0}}, color={0,127,0}));
  connect(fixed.flange, springDamperSupport.flange_a) annotation (Line(points={{-60,-40},{-40,-40}}, color={0,127,0}));
  connect(springDamperSupport.flange_b, idealGear.support) annotation (Line(points={{-20,-40},{0,-40},{0,-10}}, color={0,127,0}));
  connect(mass2.flange_b, springDamper.flange_a) annotation (Line(points={{40,0},{50,0}}, color={0,127,0}));
  connect(springDamper.flange_b, fixed1.flange) annotation (Line(points={{70,0},{80,0}}, color={0,127,0}));
  annotation (
    experiment(
      StopTime=3.0,
      Interval=0.001),
    Documentation(info="<html>
<p>
The <code>flange_a</code> of the ideal gear is driven by an external ramp-formed
force.
Via the elastically mounted gear the translational energy is transmitted to
a load mass where a preload force of <code>springDamper</code> acts against
the external force.
For ratio <code>idealGear.ratio&nbsp;&gt;&nbsp;1</code> the driven flange
<code>flange_b</code> performs smaler movement then the driving flange
<code>flange_a</code>.
</p>
<p>
Simulate for 3&nbsp;seconds and plot e.g. the position of masses:
<code>mass1.s</code>, <code>mass2.s</code>
</p>
</html>"));
end GearGrounded;
