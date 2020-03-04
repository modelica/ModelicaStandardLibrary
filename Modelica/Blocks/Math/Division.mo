within Modelica.Blocks.Math;
block Division "Output first input divided by second input"
  extends Interfaces.SI2SO;

equation
  y = u1/u2;
  annotation (
    Documentation(info="<html>
<p>
This block computes the output <strong>y</strong>
by <em>dividing</em> the two inputs <strong>u1</strong> and <strong>u2</strong>:
</p>
<blockquote><pre>
y = u1 / u2;
</pre></blockquote>

</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,60},{-60,60},{0,0}}, color={0,0,127}),
        Line(points={{-100,-60},{-60,-60},{0,0}}, color={0,0,127}),
        Ellipse(lineColor={0,0,127}, extent={{-50,-50},{50,50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{50,0},{100,0}}, color={0,0,127}),
        Line(points={{-30,0},{30,0}}),
        Ellipse(fillPattern=FillPattern.Solid, extent={{-5,20},{5,30}}),
        Ellipse(fillPattern=FillPattern.Solid, extent={{-5,-30},{5,-20}}),
        Text(
          extent={{-60,90},{90,50}},
          textColor={128,128,128},
          textString="u1 / u2")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={         Line(points={{50,0},{100,0}},
          color={0,0,255})}));
end Division;
