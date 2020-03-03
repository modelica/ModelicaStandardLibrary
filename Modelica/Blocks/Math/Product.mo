within Modelica.Blocks.Math;
block Product "Output product of the two inputs"
  extends Interfaces.SI2SO;

equation
  y = u1*u2;
  annotation (
    Documentation(info="<html>
<p>
This blocks computes the output <strong>y</strong>
as <em>product</em> of the two inputs <strong>u1</strong> and <strong>u2</strong>:
</p>
<blockquote><pre>
y = u1 * u2;
</pre></blockquote>

</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,60},{-40,60},{-30,40}}, color={0,0,127}),
        Line(points={{-100,-60},{-40,-60},{-30,-40}}, color={0,0,127}),
        Line(points={{50,0},{100,0}}, color={0,0,127}),
        Line(points={{-30,0},{30,0}}),
        Line(points={{-15,25.99},{15,-25.99}}),
        Line(points={{-15,-25.99},{15,25.99}}),
        Ellipse(lineColor={0,0,127}, extent={{-50,-50},{50,50}})}));
end Product;
