within Modelica.Clocked.IntegerSignals.NonPeriodic;
block IntegerChange "Indicate Integer signal changing"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.IntegerInput u(start=0)
    "Connector of Integer input signal."
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
<a href=\"modelica://Modelica.Blocks.Math.IntegerChange\">Modelica.Blocks.Math.IntegerChange</a>.
It uses <code>previous</code> instead of the implicit <code>pre</code> of
<code>change</code> to set the Boolean output <code>y</code> to
<code>true</code> when the integer input <code>u</code> changed. Thus, it's
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
</strong><code>Modelica.Blocks.Math.IntegerChange</code><strong> when the semantics
of </strong><code>change</code><strong> are relaxed and well-defined for
clocked discrete-time partitions.</strong></p>
</html>"));
end IntegerChange;
