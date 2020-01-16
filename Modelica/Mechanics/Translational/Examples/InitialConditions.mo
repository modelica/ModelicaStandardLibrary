within Modelica.Mechanics.Translational.Examples;
model InitialConditions "Setting of initial conditions"

  extends Modelica.Icons.Example;

  Translational.Components.Fixed fixed2(s0=1) annotation (Placement(
        transformation(extent={{-90,30},{-70,50}})));
  Translational.Components.Spring s2(s_rel0=2, c=1e3) annotation (Placement(
        transformation(extent={{-60,30},{-40,50}})));
  Translational.Components.Mass m3(
    L=3,
    s(start=4.5, fixed=true),
    v(fixed=true),
    m=1) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Translational.Components.SpringDamper sd2(
    s_rel0=4,
    c=111,
    d=1) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Translational.Components.Mass m4(
    L=5,
    s(start=12.5, fixed=true),
    v(fixed=true),
    m=1) annotation (Placement(transformation(extent={{60,30},{80,50}})));

  Translational.Components.Fixed fixed1(s0=-1) annotation (Placement(
        transformation(extent={{-100,-70},{-80,-50}})));
  Translational.Components.Spring s1(
    s_rel0=1,
    c=1e3,
    s_rel(start=0.5, fixed=true)) annotation (Placement(transformation(
          extent={{-60,-70},{-40,-50}})));
  Translational.Components.Mass m1(
    L=1,
    v(fixed=true),
    m=1) annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Translational.Components.SpringDamper sd1(
    s_rel0=1,
    c=111,
    s_rel(start=1, fixed=true),
    v_rel(fixed=true),
    d=1) annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Translational.Components.Mass m2(L=2, m=1) annotation (Placement(
        transformation(extent={{60,-70},{80,-50}})));
equation
  connect(s2.flange_a, fixed2.flange) annotation (Line(
      points={{-60,40},{-80,40}}, color={0,127,0}));
  connect(s1.flange_a, fixed1.flange) annotation (Line(
      points={{-60,-60},{-90,-60}}, color={0,127,0}));
  connect(m1.flange_a, s1.flange_b) annotation (Line(
      points={{-20,-60},{-40,-60}}, color={0,127,0}));
  connect(sd1.flange_a, m1.flange_b) annotation (Line(
      points={{20,-60},{0,-60}}, color={0,127,0}));
  connect(m2.flange_a, sd1.flange_b) annotation (Line(
      points={{60,-60},{40,-60}}, color={0,127,0}));
  connect(m4.flange_a, sd2.flange_b) annotation (Line(
      points={{60,40},{40,40}}, color={0,127,0}));
  connect(sd2.flange_a, m3.flange_b) annotation (Line(
      points={{20,40},{0,40}}, color={0,127,0}));
  connect(m3.flange_a, s2.flange_b) annotation (Line(
      points={{-20,40},{-40,40}}, color={0,127,0}));
  annotation (
    Documentation(info="<html>
<p>
There are several ways to set initial conditions.
In the first system the position of the mass m3 was defined
by using the modifier s(start=4.5), the position of m4 by s(start=12.5).
These positions were chosen such that the system is at rest. To calculate
these values start at the left (fixed2) with a value of 1&nbsp;m. The spring s2
has an unstretched length of 2&nbsp;m and m3 an length of 3&nbsp;m, which leads to
</p>

<blockquote><pre>
  1   m (fixed2)
+ 2   m (spring s2)
+ 3/2 m (half of the length of mass m3)
-------
  4,5 m = s(start = 4.5) for m3
+ 3/2 m (half of the length of mass m3)
+ 4   m (springDamper sd2)
+ 5/2 m (half of length of mass m4)
-------
 12,5 m = s(start = 12.5) for m4
</pre></blockquote>

<p>
This selection of initial conditions can prioritize the selection of
those variables (m3.s and m4.s) as state variables.
</p>

<p>
In the second example, the lengths of the springs are given start values
but they cannot be used as state for pure springs (only for the spring/damper
combination). In this case the system is not at rest.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Examples/InitialConditions.png\" alt=\"Initial conditions\">
</blockquote>
</html>"),
    experiment(StopTime=5.0, Interval=0.001),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Line(points={{-80,58},{-80,46}}, color={0,0,255}),
        Text(
          extent={{-10,5},{10,-5}},
          textColor={255,0,0},
          textString="ref= 0 m",
          origin={-96,73},
          rotation=90),
        Line(
          points={{-10,76},{-10,50}},
          color={0,0,255}),
        Text(
          extent={{-40,82},{-20,72}},
          textColor={255,0,0},
          textString=" 4.5 m "),
        Line(
          points={{70,90},{70,50}},
          color={0,0,255}),
        Text(
          extent={{40,98},{60,88}},
          textColor={255,0,0},
          textString="12.5 m"),
        Text(
          extent={{-60,16},{-40,6}},
          textColor={0,0,255},
          textString="  2 m  "),
        Text(
          extent={{20,16},{40,6}},
          textColor={0,0,255},
          textString="  4 m  "),
        Text(
          extent={{-20,16},{0,6}},
          textString="  3 m  "),
        Text(
          extent={{60,16},{80,6}},
          textString="  5 m  "),
        Text(
          extent={{-60,-84},{-40,-94}},
          textColor={255,0,0},
          textString=" 0.5 m
 (1 m) "),
       Text(
          extent={{20,-84},{40,-94}},
          textColor={255,0,0},
          textString=" 1 m
 (1 m) "),
       Text(
          extent={{-20,-84},{0,-94}},
          textString="  1 m  "),
        Text(
          extent={{60,-84},{80,-94}},
          textString="  2 m  "),
        Line(
          points={{-90,-32},{-90,-56}},
          color={0,0,255}),
        Text(
          extent={{-10,5},{10,-5}},
          textColor={255,0,0},
          origin={-96,-35},
          rotation=90,
          textString="ref= -1 m"),
        Line(
          points={{-10,-32},{-10,-50}},
          color={0,0,255}),
        Text(
          extent={{-20,-22},{0,-32}},
          textColor={0,0,255},
          textString="  0 m  "),
        Line(
          points={{70,-32},{70,-50}},
          color={0,0,255}),
        Text(
          extent={{20,-24},{40,-34}},
          textColor={238,46,47},
          textString=" 2.5 m "),
        Line(
          points={{-90,54},{-80,54}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{-90,70},{-10,70}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{-90,86},{70,86}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Open}),
        Line(points={{-60,30},{-60,16}}, color={0,0,255}),
        Line(points={{-40,30},{-40,16}}, color={0,0,255}),
        Line(points={{-20,30},{-20,16}}, color={0,0,255}),
        Line(points={{0,30},{0,16}}, color={0,0,255}),
        Line(points={{20,30},{20,16}}, color={0,0,255}),
        Line(points={{40,30},{40,16}}, color={0,0,255}),
        Line(points={{60,30},{60,16}}, color={0,0,255}),
        Line(points={{80,30},{80,16}}, color={0,0,255}),
        Line(
          points={{-60,20},{-40,20}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.Open}),
        Line(
          points={{-20,20},{0,20}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.Open}),
        Line(
          points={{20,20},{40,20}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.Open}),
        Line(
          points={{60,20},{80,20}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.Open}),
        Line(
          points={{-90,90},{-90,46}},
          color={0,0,255}),
        Text(
          extent={{-90,66},{-70,56}},
          textColor={255,0,0},
          textString="1 m "),
        Line(
          points={{-60,-70},{-60,-84}},
          color={0,0,255}),
        Line(
          points={{-40,-70},{-40,-84}},
          color={0,0,255}),
        Line(
          points={{-20,-70},{-20,-84}},
          color={0,0,255}),
        Line(
          points={{0,-70},{0,-84}},
          color={0,0,255}),
        Line(
          points={{20,-70},{20,-84}},
          color={0,0,255}),
        Line(
          points={{40,-70},{40,-84}},
          color={0,0,255}),
        Line(
          points={{60,-70},{60,-84}},
          color={0,0,255}),
        Line(
          points={{80,-70},{80,-84}},
          color={0,0,255}),
        Line(
          points={{-60,-80},{-40,-80}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.Open}),
        Line(
          points={{-20,-80},{0,-80}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.Open}),
        Line(
          points={{20,-80},{40,-80}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.Open}),
        Line(
          points={{60,-80},{80,-80}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.Open}),
        Line(
          points={{-90,-36},{-10,-36}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.Open}),
        Line(
          points={{-10,-36},{70,-36}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.Open}),
        Text(
          extent={{-60,-24},{-40,-34}},
          textColor={238,46,47},
          textString="1 m ")}));
end InitialConditions;
