within Modelica.Blocks.Math;
block Log
  "Output the logarithm (default base e) of the input (input > 0 required)"

  extends Interfaces.SISO;
  parameter Real base = Modelica.Constants.e "Base of logarithm" annotation(Evaluate=true);

equation
  y = Modelica.Math.log(u)/Modelica.Math.log(base);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},
              {-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},
              {-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}},
          smooth=Smooth.Bezier),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-6,-24},{66,-72}},
          textColor={192,192,192},
          textString="log")}),
    Documentation(info="<html>
<p>
This blocks computes the output <strong>y</strong> as the
<em>logarithm</em> to the parameter <em>base</em> of the input <strong>u</strong>:
</p>
<blockquote><pre>
y = <strong>log</strong>( u ) / <strong>log</strong>( base );
</pre></blockquote>
<p>
An error occurs if the input <strong>u</strong> is
zero or negative.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/log.png\"
     alt=\"log.png\">
</p>

</html>"));
end Log;
