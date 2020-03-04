within Modelica.Blocks.Math;
block Sqrt "Output the square root of the input (input >= 0 required)"
  extends Interfaces.SISO;

equation
  y = sqrt(u);
  annotation (
    defaultComponentName="sqrt1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-80},{-79.2,-68.7},{-78.4,-64},{-76.8,-57.3},{-73.6,-47.9},
              {-67.9,-36.1},{-59.1,-22.2},{-46.2,-6.49},{-28.5,10.7},{-4.42,
              30},{27.7,51.3},{69.5,74.7},{80,80}},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-88},{-80,68}}, color={192,192,192}),
        Text(
          extent={{-8,-4},{64,-52}},
          textColor={192,192,192},
          textString="sqrt")}),
    Documentation(info="<html>
<p>
This blocks computes the output <strong>y</strong>
as <em>square root</em> of the input <strong>u</strong>:
</p>
<blockquote><pre>
y = <strong>sqrt</strong>( u );
</pre></blockquote>
<p>
The input shall be zero or positive.
Otherwise an error occurs.
</p>

</html>"));
end Sqrt;
