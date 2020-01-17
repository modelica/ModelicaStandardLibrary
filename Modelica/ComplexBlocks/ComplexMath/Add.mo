within Modelica.ComplexBlocks.ComplexMath;
block Add "Output the sum of the two inputs"
  extends Interfaces.ComplexSI2SO;
  parameter Complex k1=Complex(1, 0) "Gain of input 1";
  parameter Complex k2=Complex(1, 0) "Gain of input 2";
equation
  y = k1*u1Internal + k2*u2Internal;
  annotation (
    Documentation(info="<html>
<p>
This blocks computes output <code>y</code> as <em>sum</em> of the
two input signals <code>u1</code> and <code>u2</code>. Optionally, either input <code>u1</code> or <code>u2</code> or both inputs can be processed conjugate complex, when parameters <code>useConjugateInput1</code> and <code>useConjugateInput2</code> are <code>true</code>, respectively.
</p>
<blockquote><pre>
y = k1*u1Internal + k2*u2Internal;
</pre></blockquote>
<p>
<strong>Example</strong> parameters:
</p>
<ul>
<li><code>k1 = +2</code>,</li>
<li><code>k2 = -3</code>,</li>
<li><code>useConjugateInput1 = true</code>,</li>
<li><code>useConjugateInput2 = false</code></li>
</ul>
<p>
result in the following equation:
</p>
<blockquote><pre>
y = 2 * Modelica.ComplexMath.conj(u1) - 3 * u2
</pre></blockquote>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Text(extent={{-98,-52},{5,-92}},
            textString="%k2"), Text(extent={{-98,92},{5,52}}, textString="%k1"),
            Line(points={{50,0},{100,0}},color={0,0,255}),
            Line(points={{-100,60},{-74,24},{-44,24}},color={85,170,255}),
            Line(points={{-100,-60},{-74,-24},{-44,-24}},color={85,170,255}),
            Ellipse(extent={{-50,50},{50,-50}}, lineColor={85,170,255}),
            Line(points={{50,0},{100,0}}, color={85,170,255}),
            Text(extent={{-40,40},{40,-40}},
          textColor={85,170,255},
          textString="+")}));
end Add;
