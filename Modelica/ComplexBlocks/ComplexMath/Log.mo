within Modelica.ComplexBlocks.ComplexMath;
block Log
  "Output the natural (base e) logarithm of the input (input <> '0' required)"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.log(uInternal);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-80,-80},{-80,68}}, color={
          192,192,192}),Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-79.2,
          -50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},{-75.2,-11.4},{-72.8,
          -1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},{-47,38.1},{-31.8,
          48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}}, color={85,170,
              255}),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-6,-24},{66,-72}},
              textColor={192,192,192},
              textString="log")}),
    Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>natural (base e) logarithm</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<blockquote><pre>
y = <strong>log</strong>(uInternal);
</pre></blockquote>
<p>
An error occurs if the elements of the input <code>u</code> is zero.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/log.png\"
     alt=\"log.png\">
</div>

</html>"));
end Log;
