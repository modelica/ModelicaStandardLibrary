within Modelica.ComplexBlocks.ComplexMath;
block Atan "Output the arc tangent of the input"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.atan(uInternal);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{0,-80},{0,68}},
          color={192,192,192}),Line(points={{-80,-80},{-52.7,-75.2},{-37.4,
          -69.7},{-26.9,-63},{-19.7,-55.2},{-14.1,-45.8},{-10.1,-36.4},{-6.03,
          -23.9},{-1.21,-5.06},{5.23,21},{9.25,34.1},{13.3,44.2},{18.1,52.9},
          {24.5,60.8},{33.4,67.6},{47,73.6},{69.5,78.6},{80,80}}, color={85,
              170,255}),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-86,68},{-14,20}},
              textColor={192,192,192},
              textString="atan")}),
    Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>tangent-inverse</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<blockquote><pre>
y= <strong>atan</strong>(uInternal);
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/atan.png\"
     alt=\"atan.png\">
</div>

</html>"));
end Atan;
