within Modelica.ComplexBlocks.ComplexMath;
block Division "Output first input divided by second input"
  extends Interfaces.ComplexSI2SO;
  parameter Boolean useConjugateInput1=false
    "If true, input 1 is processed conjugate complex";
  parameter Boolean useConjugateInput2=false
    "If true, input 2 is processed conjugate complex";
equation
  y = (if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1)/(
    if useConjugateInput2 then Modelica.ComplexMath.conj(u2) else u2);
  annotation (
    Documentation(info="<html>
<p>
This block computes the output <code>y</code> (element-wise)
by <em>dividing</em> the corresponding elements of
the two inputs <code>u1</code> and <code>u2</code>. Optionally, either input <code>u1</code> or <code>u2</code> or both inputs can be processed conjugate complex, when parameters <code>useConjugateInput1</code> and <code>useConjugateInput2</code> are <code>true</code>, respectively. Depending on <code>useConjugateInput1</code> and <code>useConjugateInput2</code> the internal signals represent either the original or the conjugate complex input signal.
</p>
<blockquote><pre>
y = u1Internal / u2Internal;
</pre></blockquote>

<p><strong>Example:</strong> If <code>useConjugateInput1 = true</code> and <code>useConjugateInput2 = false</code> the output signal <code>y = Modelica.ComplexMath.conj(u1) / u2</code>.</p>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
          Line(points={{-100,60},{-60,60},{0,0}}, color={85,170,255}),
          Line(points={{-100,-60},{-60,-60},{0,0}}, color={85,170,255}),
          Ellipse(extent={{-50,50},{50,-50}}, lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{50,0},{100,0}}, color={85,170,255}),
          Line(points={{-30,0},{30,0}}, color={85,170,255}),
                                        Ellipse(
              extent={{-5,20},{5,30}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),    Ellipse(
              extent={{-5,-20},{5,-30}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,90},{90,50}},
          textColor={128,128,128},
          textString="u1 / u2")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={          Line(points={{50,0},{100,0}},
          color={0,0,255})}));
end Division;
