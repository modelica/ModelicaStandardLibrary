within Modelica.Blocks.Math;
block Add "Output the sum of the two inputs"
  extends Interfaces.SI2SO;

  parameter Real k1=+1 "Gain of input signal 1";
  parameter Real k2=+1 "Gain of input signal 2";

equation
  y = k1*u1 + k2*u2;
  annotation (
    Documentation(info="<html>
<p>
This blocks computes output <strong>y</strong> as <em>sum</em> of the
two input signals <strong>u1</strong> and <strong>u2</strong>:
</p>
<blockquote><pre>
<strong>y</strong> = k1*<strong>u1</strong> + k2*<strong>u2</strong>;
</pre></blockquote>
<p>
Example:
</p>
<blockquote><pre>
   parameter:   k1= +2, k2= -3

results in the following equations:

   y = 2 * u1 - 3 * u2
</pre></blockquote>

</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,60},{-74,24},{-44,24}}, color={0,0,127}),
        Line(points={{-100,-60},{-74,-24},{-44,-24}}, color={0,0,127}),
        Ellipse(lineColor={0,0,127}, extent={{-50,-50},{50,50}}),
        Line(points={{50,0},{100,0}}, color={0,0,127}),
        Text(extent={{-40,40},{40,-40}}, textString="+"),
        Text(extent={{-100,52},{5,92}}, textString="%k1"),
        Text(extent={{-100,-92},{5,-52}}, textString="%k2")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={         Line(points={{50,0},{100,0}},
          color={0,0,255}),                                        Line(
          points={{50,0},{100,0}}, color={0,0,127})}));
end Add;
