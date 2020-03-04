within Modelica.Blocks.Math;
block RealToInteger "Convert Real to Integer signal"
  extends Modelica.Blocks.Icons.IntegerBlock;
public
  Interfaces.RealInput u "Connector of Real input signal" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.IntegerOutput y "Connector of Integer output signal" annotation (
     Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = if (u > 0) then integer(floor(u + 0.5)) else integer(ceil(u - 0.5));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
        Text(
          textColor={0,0,127},
          extent={{-100.0,-40.0},{0.0,40.0}},
          textString="R"),
        Text(
          textColor={255,127,0},
          extent={{20.0,-40.0},{120.0,40.0}},
          textString="I"),
        Polygon(
          lineColor={255,127,0},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid,
          points={{50.0,0.0},{30.0,20.0},{30.0,10.0},{0.0,10.0},{0.0,-10.0},{
              30.0,-10.0},{30.0,-20.0},{50.0,0.0}})}), Documentation(info="<html>
<p>
This block computes the output <strong>y</strong>
as <em>nearest integer value</em> of the input <strong>u</strong>:
</p>
<blockquote><pre>
y = <strong>integer</strong>( <strong>floor</strong>( u + 0.5 ) )  for  u &gt; 0;
y = <strong>integer</strong>( <strong>ceil </strong>( u - 0.5 ) )  for  u &lt; 0;
</pre></blockquote>
</html>"));
end RealToInteger;
