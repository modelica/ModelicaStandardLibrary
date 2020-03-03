within Modelica.Blocks.Math;
block Cosh "Output the hyperbolic cosine of the input"
  extends Interfaces.SISO;
equation
  y = Modelica.Math.cosh(u);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,68}}, color={192,192,192}),
        Text(
          extent={{4,66},{66,20}},
          textColor={192,192,192},
          textString="cosh"),
        Line(
          points={{-80,80},{-77.6,61.1},{-74.4,39.3},{-71.2,20.7},{-67.1,1.29},
              {-63.1,-14.6},{-58.3,-29.8},{-52.7,-43.5},{-46.2,-55.1},{-39,-64.3},
              {-30.2,-71.7},{-18.9,-77.1},{-4.42,-79.9},{10.9,-79.1},{23.7,-75.2},
              {34.2,-68.7},{42.2,-60.6},{48.6,-51.2},{54.3,-40},{59.1,-27.5},
              {63.1,-14.6},{67.1,1.29},{71.2,20.7},{74.4,39.3},{77.6,61.1},{
              80,80}},
          smooth=Smooth.Bezier),
        Line(points={{-90,-86.083},{68,-86.083}}, color={192,192,192}),
        Polygon(
          points={{90,-86.083},{68,-78.083},{68,-94.083},{90,-86.083}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This blocks computes the output <strong>y</strong> as the
<em>hyperbolic cosine</em> of the input <strong>u</strong>:
</p>
<blockquote><pre>
y = <strong>cosh</strong>( u );
</pre></blockquote>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/cosh.png\"
     alt=\"cosh.png\">
</p>

</html>"));
end Cosh;
