within Modelica.Blocks.Math;
block Feedback "Output difference between commanded and feedback input"

  Interfaces.RealInput u1 "Commanded input" annotation (Placement(transformation(extent={{-100,
            -20},{-60,20}})));
  Interfaces.RealInput u2 "Feedback input" annotation (Placement(transformation(
        origin={0,-80},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  Interfaces.RealOutput y annotation (Placement(transformation(extent={{80,-10},
            {100,10}})));

equation
  y = u1 - u2;
  annotation (
    Documentation(info="<html>
<p>
This blocks computes output <strong>y</strong> as <em>difference</em> of the
commanded input <strong>u1</strong> and the feedback
input <strong>u2</strong>:
</p>
<blockquote><pre>
<strong>y</strong> = <strong>u1</strong> - <strong>u2</strong>;
</pre></blockquote>
<p>
Example:
</p>
<blockquote><pre>
   parameter:   n = 2

results in the following equations:

   y = u1 - u2
</pre></blockquote>

</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          lineColor={0,0,127},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          extent={{-20,-20},{20,20}}),
        Line(points={{-60,0},{-20,0}}, color={0,0,127}),
        Line(points={{20,0},{80,0}}, color={0,0,127}),
        Line(points={{0,-20},{0,-60}}, color={0,0,127}),
        Text(extent={{-14,-94},{82,0}}, textString="-"),
        Text(
          textColor={0,0,255},
          extent={{-150,40},{150,80}},
          textString="%name")}));
end Feedback;
