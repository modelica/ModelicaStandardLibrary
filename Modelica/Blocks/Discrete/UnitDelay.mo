within Modelica.Blocks.Discrete;
block UnitDelay "Unit Delay Block"
  parameter Real y_start=0 "Initial value of output signal";
  extends Interfaces.DiscreteSISO;

equation
  when sampleTrigger then
    y = pre(u);
  end when;

initial equation
    y = y_start;
  annotation (
    Documentation(info="<html>
<p>
This block describes a unit delay:
</p>
<blockquote><pre>
     1
y = --- * u
     z
</pre></blockquote>
<p>
that is, the output signal y is the input signal u of the
previous sample instant. Before the second sample instant,
the output y is identical to parameter yStart.
</p>

</html>"),
         Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Line(points={{-30.0,0.0},{30.0,0.0}},
      color={0,0,127}),
    Text(textColor={0,0,127},
      extent={{-90.0,10.0},{90.0,90.0}},
      textString="1"),
    Text(textColor={0,0,127},
      extent={{-90.0,-90.0},{90.0,-10.0}},
      textString="z")}));
end UnitDelay;
