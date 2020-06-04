within Modelica.ComplexBlocks.ComplexMath;
block Asin "Output the arc sine of the input"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.asin(uInternal);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{0,-80},{0,68}},
          color={192,192,192}),Line(points={{-80,-80},{-79.2,-72.8},{-77.6,
          -67.5},{-73.6,-59.4},{-66.3,-49.8},{-53.5,-37.3},{-30.2,-19.7},{
          37.4,24.8},{57.5,40.8},{68.7,52.7},{75.2,62.2},{77.6,67.5},{80,80}}, color=
              {85,170,255}),                                                   Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-88,78},{-16,30}},
              textColor={192,192,192},
              textString="asin")}),
    Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>sine-inverse</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<blockquote><pre>
y = <strong>asin</strong>(uInternal);
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/asin.png\"
     alt=\"asin.png\">
</div>

</html>"));
end Asin;
