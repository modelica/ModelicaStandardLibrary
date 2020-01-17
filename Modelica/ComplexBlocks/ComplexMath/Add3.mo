within Modelica.ComplexBlocks.ComplexMath;
block Add3 "Output the sum of the three inputs"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;

  parameter Complex k1=Complex(1, 0) "Gain of upper input";
  parameter Boolean useConjugateInput1=false
    "If true, input 1 is processed conjugate complex";

  parameter Complex k2=Complex(1, 0) "Gain of middle input";
  parameter Boolean useConjugateInput2=false
    "If true, input 2 is processed conjugate complex";

  parameter Complex k3=Complex(1, 0) "Gain of lower input";
  parameter Boolean useConjugateInput3=false
    "If true, input 3 is processed conjugate complex";

  Interfaces.ComplexInput u1 "Connector 1 of Complex input signals"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Interfaces.ComplexInput u2 "Connector 2 of Complex input signals"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.ComplexInput u3 "Connector 3 of Complex input signals"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Interfaces.ComplexOutput y "Connector of Complex output signals"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  y = k1*(if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1)
     + k2*(if useConjugateInput2 then Modelica.ComplexMath.conj(u2) else u2)
     + k3*(if useConjugateInput3 then Modelica.ComplexMath.conj(u3) else u3);
  annotation (
    Documentation(info="<html>
<p>
This blocks computes output <code>y</code> as <em>sum</em> of the
three input signals <code>u1</code>, <code>u2</code> and <code>u3</code>. Optionally, inputs <code>u1</code> and <code>u2</code> and <code>u3</code> can be processed conjugate complex, when parameters <code>useConjugateInput1</code> and <code>useConjugateInput2</code> and <code>useConjugateInput3</code> are <code>true</code>, respectively.
</p>
<blockquote><pre>
y = k1*(if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1)
  + k2*(if useConjugateInput2 then Modelica.ComplexMath.conj(u2) else u2)
  + k3*(if useConjugateInput3 then Modelica.ComplexMath.conj(u3) else u3);
</pre></blockquote>
<p>
<strong>Example</strong> parameters:
</p>
<ul>
<li><code>k1 = +2</code>,</li>
<li><code>k2 = -3</code>,</li>
<li><code>k3 = +1</code>,</li>
<li><code>useConjugateInput1 = true</code>,</li>
<li><code>useConjugateInput2 = false</code></li>
<li><code>useConjugateInput3 = false</code></li>
</ul>

<p>
result in the following equation:
</p>
<blockquote><pre>
y = 2 * Modelica.ComplexMath.conj(u1) - 3 * u2 + u3;
</pre></blockquote>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Text(extent={{-98,50},{5,90}}, textString="%k1"),
            Text(extent={{-98,-20},{5,20}}, textString="%k2"),
            Text(extent={{-98,-50},{5,-90}}, textString="%k3"),
            Text(extent={{10,40},{90,-40}},
          textColor={85,170,255},
          textString="+")}));
end Add3;
