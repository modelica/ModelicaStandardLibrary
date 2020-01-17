within Modelica.ComplexBlocks.ComplexMath;
block Gain "Output the product of a gain value with the input signal"

  parameter Complex k(re(start=1), im(start=0))
    "Gain value multiplied with input signal";
  parameter Boolean useConjugateInput=false
    "If true, input is processed conjugate complex";
  Interfaces.ComplexInput u "Input signal connector" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.ComplexOutput y "Output signal connector" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

equation
  y = k*(if useConjugateInput then Modelica.ComplexMath.conj(u) else u);
  annotation (
    Documentation(info="<html>
<p>
This block computes output <code>y</code> as
<em>product</em> of gain <code>k</code> with the
input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> either the original or the conjugate complex input signal are processed.
</p>
<blockquote><pre>
y = k * (if useConjugateInput then Modelica.ComplexMath.conj(u) else u);
</pre></blockquote>
<p><strong>Example:</strong> If <code>useConjugateInput = true</code> and <code>k = 2</code> the output signal <code>y = 2 * Modelica.ComplexMath.conj(u)</code>.</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
          points={{-100,-100},{-100,100},{100,0},{-100,-100}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),    Text(
              extent={{-150,-140},{150,-100}},
              textString="k=%k"),Text(
              extent={{-150,140},{150,100}},
              textString="%name",
              textColor={0,0,255})}));
end Gain;
