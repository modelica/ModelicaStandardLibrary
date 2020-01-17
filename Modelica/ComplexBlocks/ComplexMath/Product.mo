within Modelica.ComplexBlocks.ComplexMath;
block Product "Output product of the two inputs"
  extends Interfaces.ComplexSI2SO;
equation
  y = u1Internal*u2Internal;
  annotation (
    Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> (element-wise)
as <em>product</em> of the corresponding elements of
the two inputs <code>u1</code> and <code>u2</code>. Optionally, either input <code>u1</code> or <code>u2</code> or both inputs can be processed conjugate complex, when parameters <code>useConjugateInput1</code> and <code>useConjugateInput2</code> are <code>true</code>, respectively. Depending on <code>useConjugateInput1</code> and <code>useConjugateInput2</code> the internal signals represent either the original or the conjugate complex input signal.
</p>
<blockquote><pre>
y = u1Inernal * u2Internal;
</pre></blockquote>

<p><strong>Example:</strong> If <code>useConjugateInput1 = true</code> and <code>useConjugateInput2 = false</code> the output signal <code>y = Modelica.ComplexMath.conj(u1) * u2</code>.</p>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-100,60},{-40,60},{-30,40}},
          color={85,170,255}),
                           Line(points={{-100,-60},{-40,-60},{-30,-40}},
          color={85,170,255}),
                           Line(points={{50,0},{100,0}}, color={85,170,255}),
          Line(points={{-30,0},{30,0}}, color={85,170,255}),
                                        Line(points={{-15,
          25.99},{15,-25.99}}, color={85,170,255}),
                               Line(points={{-15,-25.99},{15,
          25.99}}, color={85,170,255}),
                   Ellipse(extent={{-50,50},{50,-50}},
          lineColor={85,170,255})}));
end Product;
