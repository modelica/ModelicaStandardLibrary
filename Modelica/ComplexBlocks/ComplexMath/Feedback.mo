within Modelica.ComplexBlocks.ComplexMath;
block Feedback
  "Output difference between commanded input 1 and feedback input 2"

  Interfaces.ComplexInput u1 annotation (Placement(transformation(extent={{-100,
            -20},{-60,20}}), iconTransformation(extent={{-100,-20},{-60,20}})));
  Interfaces.ComplexInput u2 annotation (Placement(transformation(
        origin={0,-100},
        extent={{-20,-20},{20,20}},
        rotation=90), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Interfaces.ComplexOutput y annotation (Placement(transformation(extent={{80,-10},
            {100,10}}), iconTransformation(extent={{80,-10},{100,10}})));

  parameter Boolean useConjugateInput1=false
    "If true, input 1 is processed conjugate complex";
  parameter Boolean useConjugateInput2=false
    "If true, input 2 is processed conjugate complex";

equation
  y = (if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1) -
    (if useConjugateInput2 then Modelica.ComplexMath.conj(u2) else u2);
  annotation (
    Documentation(info="<html>
<p>
This blocks computes output <code>y</code> as <em>difference</em> of the
commanded input <code>u1</code> and the feedback
input <code>u2</code>. Optionally, either input <code>u1</code> or <code>u2</code> or both inputs can be processed conjugate complex, when parameters <code>useConjugateInput1</code> and <code>useConjugateInput2</code> are <code>true</code>, respectively.
</p>
<blockquote><pre>
y = (if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1)
  - (if useConjugateInput1 then Modelica.ComplexMath.conj(u2) else u2);
</pre></blockquote>
<p>
<strong>Example</strong> parameters:
</p>
<ul>
<li><code>useConjugateInput1 = true</code>,</li>
<li><code>useConjugateInput2 = false</code></li>
</ul>
<p>
result in the following equation:
</p>
<blockquote><pre>
y = Modelica.ComplexMath.conj(u1) - u2
</pre></blockquote>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(
              extent={{-20,20},{20,-20}},
              lineColor={85,170,255},
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid),Line(points={{-60,0},{-20,0}},
          color={85,170,255}),
                           Line(points={{20,0},{80,0}}, color={85,170,255}),
          Line(points={{0,-20},{0,-60}}, color={85,170,255}),
                              Text(
              extent={{-150,94},{150,44}},
              textString="%name",
              textColor={0,0,255}),                       Text(
              extent={{20,-20},{100,-100}},
          textColor={85,170,255},
          textString="-")}));
end Feedback;
