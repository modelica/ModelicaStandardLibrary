within Modelica.Mechanics.Translational.Examples;
model Oscillator "Oscillator demonstrates the use of initial conditions"

  extends Modelica.Icons.Example;

  Translational.Components.Mass mass1(
    L=1,
    s(start=-0.5, fixed=true),
    v(start=0, fixed=true),
    m=1) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Translational.Components.Spring spring1(s_rel0=1, c=10000) annotation (
      Placement(transformation(extent={{20,20},{40,40}})));
  Translational.Components.Fixed fixed1(s0=1) annotation (Placement(
        transformation(extent={{60,20},{80,40}})));
  Translational.Sources.Force force1 annotation (Placement(transformation(
          extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Sine sine1(f=15.9155) annotation (Placement(
        transformation(extent={{-100,20},{-80,40}})));
  Translational.Components.Mass mass2(
    L=1,
    s(start=-0.5, fixed=true),
    v(start=0, fixed=true),
    m=1) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Translational.Components.Spring spring2(s_rel0=1, c=10000) annotation (
      Placement(transformation(extent={{20,-50},{40,-30}})));
  Translational.Components.Fixed fixed2(s0=1) annotation (Placement(
        transformation(extent={{60,-40},{80,-20}})));
  Translational.Sources.Force force2 annotation (Placement(transformation(
          extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Sine sine2(f=15.9155) annotation (Placement(
        transformation(extent={{-100,-40},{-80,-20}})));
  Translational.Components.Damper damper1(d=10) annotation (Placement(
        transformation(extent={{20,-30},{40,-10}})));
equation
  connect(mass1.flange_b, spring1.flange_a)
    annotation (Line(points={{0,30},{20,30}}, color={0,127,0}));
  connect(spring2.flange_a, damper1.flange_a)
    annotation (Line(points={{20,-40},{10,-40},{10,-20},{20,-20}},
                                                 color={0,127,0}));
  connect(mass2.flange_b, spring2.flange_a)
    annotation (Line(points={{0,-30},{10,-30},{10,-40},{20,-40}},
                                                color={0,127,0}));
  connect(damper1.flange_b, spring2.flange_b)
    annotation (Line(points={{40,-20},{50,-20},{50,-40},{40,-40}},
                                                 color={0,127,0}));
  connect(sine1.y, force1.f)
    annotation (Line(points={{-79,30},{-62,30}}, color={0,0,127}));
  connect(sine2.y, force2.f)
    annotation (Line(points={{-79,-30},{-62,-30}}, color={0,0,127}));
  connect(spring1.flange_b, fixed1.flange) annotation (Line(
      points={{40,30},{70,30}}, color={0,127,0}));
  connect(force2.flange, mass2.flange_a) annotation (Line(
      points={{-40,-30},{-20,-30}}, color={0,127,0}));
  connect(force1.flange, mass1.flange_a) annotation (Line(
      points={{-40,30},{-20,30}}, color={0,127,0}));
  connect(spring2.flange_b, fixed2.flange) annotation (Line(
      points={{40,-40},{50,-40},{50,-30},{70,-30}},
                                  color={0,127,0}));
  annotation (Documentation(info="<html>
<p>
A spring - mass system is a mechanical oscillator. If no
damping is included and the system is excited at resonance
frequency infinite amplitudes will result.
The resonant frequency is given by
omega_res&nbsp;=&nbsp;sqrt(c&nbsp;/&nbsp;m)
with:
</p>

<blockquote>
  c &hellip; spring stiffness and<br>
  m &hellip; mass.
</blockquote>

<p>
To make sure that the system is initially at rest the initial
conditions s(start=-0.5) and v(start=0) for the sliding masses
are set.
If damping is added the amplitudes are bounded.
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end Oscillator;
