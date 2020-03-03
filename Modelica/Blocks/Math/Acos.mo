within Modelica.Blocks.Math;
block Acos "Output the arc cosine of the input"
  extends Interfaces.SISO(y(unit="rad"));
equation
  y = Modelica.Math.acos(u);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,80},{-79.2,72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,49.8},
              {-53.5,37.3},{-30.2,19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},
              {75.2,-62.2},{77.6,-67.5},{80,-80}},
          smooth=Smooth.Bezier),
        Line(points={{0,-88},{0,68}}, color={192,192,192}),
        Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-86,-14},{-14,-62}},
          textColor={192,192,192},
          textString="acos")}),
    Documentation(info="<html>
<p>
This blocks computes the output <strong>y</strong> as the
<em>cosine-inverse</em> of the input <strong>u</strong>:
</p>
<blockquote><pre>
y = <strong>acos</strong>( u );
</pre></blockquote>
<p>
The absolute value of the input <strong>u</strong> need to
be less or equal to one (<strong>abs</strong>( u ) <= 1).
Otherwise an error occurs.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/acos.png\"
     alt=\"acos.png\">
</p>

</html>"));
end Acos;
