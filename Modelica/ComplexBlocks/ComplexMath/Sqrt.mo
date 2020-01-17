within Modelica.ComplexBlocks.ComplexMath;
block Sqrt
  "Output the square root of the input (= principal square root of complex number)"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.sqrt(uInternal);
  annotation (
    defaultComponentName="sqrt1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-90,-80},{68,-80}}, color={
          192,192,192}),Polygon(
              points={{90,-80},{68,-72},{68,-88},{90,-80}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-79.2,
          -68.7},{-78.4,-64},{-76.8,-57.3},{-73.6,-47.9},{-67.9,-36.1},{-59.1,
          -22.2},{-46.2,-6.49},{-28.5,10.7},{-4.42,30},{27.7,51.3},{69.5,
          74.7},{80,80}}, color={85,170,255}),
                          Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-88},{-80,68}},
          color={192,192,192}),Text(
              extent={{-8,-4},{64,-52}},
              textColor={192,192,192},
              textString="sqrt")}),
    Documentation(info="<html>
<p>
This blocks computes the output <code>y</code>
as <em>square root</em> of the input <code>u</code> (= principal square root of the complex input). Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<blockquote><pre>
y = <strong>sqrt</strong>(uInternal);
</pre></blockquote>
</html>"));
end Sqrt;
