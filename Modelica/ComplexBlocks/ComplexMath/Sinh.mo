within Modelica.ComplexBlocks.ComplexMath;
block Sinh "Output the hyperbolic sine of the input"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.sinh(uInternal);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-86,80},{-14,32}},
              textColor={192,192,192},
              textString="sinh"),Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),Line(
          points={{-80,-80},{-76,-65.4},{-71.2,-51.4},{-65.5,-38.8},{-59.1,
          -28.1},{-51.1,-18.7},{-41.4,-11.4},{-27.7,-5.5},{-4.42,-0.653},{
          24.5,4.57},{39,10.1},{49.4,17.2},{57.5,25.9},{63.9,35.8},{69.5,
          47.4},{74.4,60.4},{78.4,73.8},{80,80}}, color={85,170,255}),
                                                  Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>hyperbolic sine</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<blockquote><pre>
y = <strong>sinh</strong>(uInternal);
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/sinh.png\"
     alt=\"sinh.png\">
</div>

</html>"));
end Sinh;
