within Modelica.Mechanics.Translational.Examples;
model SignConvention "Examples for the used sign conventions"
  extends Modelica.Icons.Example;
  Translational.Components.Mass mass1(
    L=1,
    s(fixed=true),
    v(fixed=true),
    m=1) annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Translational.Sources.Force force1 annotation (Placement(transformation(
          extent={{0,60},{20,80}})));
  Modelica.Blocks.Sources.Constant constant1(k=1) annotation (Placement(
        transformation(extent={{-40,60},{-20,80}})));
  Translational.Components.Mass mass2(
    L=1,
    s(fixed=true),
    v(fixed=true),
    m=1) annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Translational.Sources.Force force2 annotation (Placement(transformation(
          extent={{0,20},{20,40}})));
  Modelica.Blocks.Sources.Constant constant2(k=1) annotation (Placement(
        transformation(extent={{-40,20},{-20,40}})));
  Translational.Components.Mass mass3(
    L=1,
    s(fixed=true),
    v(fixed=true),
    m=1) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Translational.Sources.Force force3(useSupport=false)
                                                      annotation (Placement(
        transformation(extent={{20,-40},{0,-20}})));
  Modelica.Blocks.Sources.Constant constant3(k=1) annotation (Placement(
        transformation(extent={{60,-40},{40,-20}})));
  Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
equation
  connect(constant1.y, force1.f)
    annotation (Line(points={{-19,70},{-2,70}}, color={0,0,127}));
  connect(constant2.y, force2.f)
    annotation (Line(points={{-19,30},{-2,30}}, color={0,0,127}));
  connect(constant3.y, force3.f)
    annotation (Line(points={{39,-30},{22,-30}}, color={0,0,127}));
  connect(force1.flange, mass1.flange_a) annotation (Line(
      points={{20,70},{40,70}}, color={0,127,0}));
  connect(force2.flange, mass2.flange_b) annotation (Line(
      points={{20,30},{70,30},{70,10},{60,10}}, color={0,127,0}));
  connect(mass3.flange_b, force3.flange) annotation (Line(
      points={{-20,-30},{0,-30}}, color={0,127,0}));
  connect(fixed.flange, force3.support) annotation (Line(
      points={{10,-50},{10,-40}}, color={0,127,0}));
  annotation (
    Documentation(info="<html>
<p>
If all arrows point in the same direction, a positive force
results in a positive acceleration&nbsp;<var>a</var>, velocity&nbsp;<var>v</var> and position&nbsp;<var>s</var>.
</p>
<p>
For a force of 1&nbsp;N and a mass of 1&nbsp;kg this leads to
</p>
<blockquote><pre>
a = 1 m/s2
v = 1 m/s after 1 s (SlidingMass1.v)
s = 0.5 m after 1 s (SlidingMass1.s)
</pre></blockquote>
<p>
The acceleration is not available for plotting.
</p>
<p>
System 1) and 2) are equivalent. It doesn't matter whether the
force pushes at flange_a in system&nbsp;1 or pulls at flange_b in system&nbsp;2.
</p><p>
It is of course possible to ignore the arrows and connect the models
in an arbitrary way. But then it is hard see in what direction the
force acts.
</p><p>
In the third system the two arrows are opposed which means that the
force acts in the opposite direction (in the same direction as in
the two other examples).
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}),graphics={Text(
              extent={{-100,80},{-82,60}},
              textString="1)",
              lineColor={0,0,255}),Text(
              extent={{-100,40},{-82,20}},
              textString="2)",
              lineColor={0,0,255}),Text(
              extent={{-100,-20},{-82,-40}},
              textString="3)",
              lineColor={0,0,255})}),
    experiment(StopTime=1.0, Interval=0.001));
end SignConvention;
