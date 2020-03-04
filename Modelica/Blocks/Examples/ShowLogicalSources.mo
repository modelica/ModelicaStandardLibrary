within Modelica.Blocks.Examples;
model ShowLogicalSources
  "Demonstrates the usage of logical sources together with their diagram animation"
  extends Modelica.Icons.Example;
  Sources.BooleanTable table(table={2,4,6,8}) annotation (Placement(
        transformation(extent={{-60,-100},{-40,-80}})));
  Sources.BooleanConstant const annotation (Placement(transformation(extent={
            {-60,60},{-40,80}})));
  Sources.BooleanStep step(startTime=4) annotation (Placement(transformation(
          extent={{-60,20},{-40,40}})));
  Sources.BooleanPulse pulse(period=1.5) annotation (Placement(transformation(
          extent={{-60,-20},{-40,0}})));

  Sources.SampleTrigger sample(period=0.5) annotation (Placement(
        transformation(extent={{-60,-60},{-40,-40}})));
  Sources.BooleanExpression booleanExpression(y=pulse.y and step.y)
    annotation (Placement(transformation(extent={{20,20},{80,40}})));
  annotation (experiment(StopTime=10), Documentation(info="<html>
<p>
This simple example demonstrates the logical sources in
<a href=\"modelica://Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a> and demonstrate
their diagram animation (see \"small circle\" close to the output connector).
The \"booleanExpression\" source shows how a logical expression can be defined
in its parameter menu referring to variables available on this level of the
model.
</p>

</html>"));
end ShowLogicalSources;
