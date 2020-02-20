within Modelica.Clocked.BooleanSignals.NonPeriodic;
block BooleanChange "Indicate Boolean signal changing"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.BooleanInput u
    "Connector of Boolean input signal."
    annotation (Placement(transformation(extent = {{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    "Connector of Boolean output signal."
    annotation (Placement(transformation(extent = {{100,-10},{120,10}})));

equation
  if firstTick() then
    y = false;
  else
    y = not (u == previous(u));
  end if;

  annotation (
    Icon(graphics={
      Text(
        extent = {{-90,36},{90,-36}},
        textColor = {160,160,164},
        textString = "change()")}),
    Documentation(info="<html><p>
This block is a synchronous version of
<a href=\"modelica://Modelica.Blocks.Math.BooleanChange\">Modelica.Blocks.Math.BooleanChange</a>.
It uses <code>previous</code> instead of the implicit <code>pre</code> of
<code>change</code> to set the Boolean output <code>y</code> to
<code>true</code> when the boolean input <code>u</code> changed. Thus, it's
logic is:</p>
<blockquote><pre>
if firstTick() then
  y = false;
else
  y = not (u == previous(u));
end if;
</pre></blockquote>
<p>
<strong>This block might be superfluous and replaced by
</strong><code>Modelica.Blocks.Math.BooleanChange</code><strong> when the semantics
of </strong><code>change</code><strong> are relaxed and well-defined for
clocked discrete-time partitions.</strong></p>
</html>"));
end BooleanChange;
