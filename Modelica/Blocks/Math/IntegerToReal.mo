within Modelica.Blocks.Math;
block IntegerToReal "Convert Integer to Real signals"
  extends Modelica.Blocks.Icons.Block;
  Interfaces.IntegerInput u "Connector of Integer input signal" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.RealOutput y "Connector of Real output signal" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = u;
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
        Text(
          textColor={255,127,0},
          extent={{-120.0,-40.0},{-20.0,40.0}},
          textString="I"),
        Text(
          textColor={0,0,127},
          extent={{0.0,-40.0},{100.0,40.0}},
          textString="R"),
        Polygon(
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          points={{10.0,0.0},{-10.0,20.0},{-10.0,10.0},{-40.0,10.0},{-40.0,-10.0},
              {-10.0,-10.0},{-10.0,-20.0},{10.0,0.0}})}), Documentation(info="<html>
<p>
This block computes the output <strong>y</strong>
as <em>Real equivalent</em> of the Integer input <strong>u</strong>:
</p>
<blockquote><pre>
y = u;
</pre></blockquote>
<p>where <strong>u</strong> is of Integer and <strong>y</strong> of Real type.</p>
</html>"));
end IntegerToReal;
