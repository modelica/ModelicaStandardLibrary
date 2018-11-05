within Modelica;
package ComplexBlocks
  "Library of basic input/output control blocks with Complex signals"
  extends Modelica.Icons.Package;

  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;

    class Contact "Contact"
      extends Modelica.Icons.Contact;
      annotation (Documentation(info="<html>
<h4>Main authors</h4>

<p>
<strong>Anton Haumer</strong><br>
<a href=\"https://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
D-93049 Regensburg, Germany<br>
email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a><br>
</p>

<p>
<strong>Dr. Christian Kral</strong><br>
  <a href=\"https://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
  A-1060 Vienna, Austria<br>
  email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>

<h4>Acknowledgements</h4>

<p>
Copyright &copy; 1998-2018, Modelica Association, Anton Haumer and Christian Kral.
</p>
</html>"));
    end Contact;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (Documentation(info="<html>

<h5>Version 3.2.2</h5>

<ul>
<li>Added block
    <a href=\"modelica://Modelica.ComplexBlocks.ComplexMath.Conj\">Conj</a> for conjugate complex signal processing
    </li>
<li>Added optional conjugate complex input processing to all partial interfaces and complex blocks</li>
</ul>

<h5>Version 3.2</h5>

<ul>
<li>Introduction of first version</li>
</ul>

</html>"));
    end ReleaseNotes;

    annotation (Documentation(info="<html>
<p>
This library contains blocks for processing complex signals.
</p>
</html>"));
  end UsersGuide;

  package Examples
    "Library of examples to demonstrate the usage of package Blocks"
    extends Modelica.Icons.ExamplesPackage;

    model TestConversionBlock "Test the conversion blocks"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.Ramp len(duration=1, offset=1E-6) annotation (
          Placement(transformation(extent={{-80,10},{-60,30}})));
      Modelica.Blocks.Sources.Ramp phi(height=4*Modelica.Constants.pi, duration=
           1) annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
      Modelica.ComplexBlocks.ComplexMath.PolarToComplex polarToComplex
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    equation
      connect(phi.y, polarToComplex.phi) annotation (Line(points={{-59,-20},{-50,
              -20},{-50,-6},{-46,-6},{-42,-6}}, color={0,0,127}));
      connect(len.y, polarToComplex.len) annotation (Line(
          points={{-59,20},{-50,20},{-50,6},{-42,6}}, color={0,0,127}));
      connect(polarToComplex.y, complexToReal.u) annotation (Line(
          points={{-19,0},{-2,0}}, color={85,170,255}));
      annotation (Documentation(info="<html>
<p>A Complex signal is defined by its length and angle, both linearly rising with time.
Plotting the imaginary part versus the real part, you will see an Archimedean spiral.</p>
</html>"), experiment(StopTime=1.01, Interval=0.001));
    end TestConversionBlock;

    model ShowTransferFunction "Test Complex Transfer Function Block"
      extends Modelica.Icons.Example;
      parameter Real d=1/sqrt(2) "Damping coefficient";
      parameter Real b[:]={1} "Numerator polynomial coefficients of the transfer function";
      parameter Real a[:]={1,2*d,1} "Denominator polynomial coefficients of the transfer function";
      parameter Real wMin=0.01 "Lower bound for frequency sweep";
      parameter Real wMax=100 "Upper bound for frequency sweep";
      Real lg_w=log10(logFrequencySweep.y) "Logarithm of frequency";
      Real dB=20*log10(complexToPolar.len) "Magnitude of the transfer function in decibel";
      Modelica.SIunits.Angle phi(displayUnit="deg")=complexToPolar.phi "Argument of the transfer function";
      Modelica.ComplexBlocks.Sources.LogFrequencySweep logFrequencySweep(
        duration=1,
        wMin=wMin,
        wMax=wMax)
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
      Modelica.ComplexBlocks.Sources.ComplexConstant const(k(re=1, im=0))
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Modelica.ComplexBlocks.ComplexMath.TransferFunction transferFunction(b=b,
          a=a)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    equation
      connect(const.y, transferFunction.u)
        annotation (Line(points={{-59,0},{-50.5,0},{-42,0}}, color={85,170,255}));
      connect(logFrequencySweep.y, transferFunction.w)
        annotation (Line(points={{-59,-30},{-30,-30},{-30,-12}}, color={0,0,127}));
      connect(transferFunction.y, complexToPolar.u)
        annotation (Line(points={{-19,0},{-2,0}}, color={85,170,255}));
      annotation (
        experiment(StopTime=1, Interval=0.001), Documentation(info=
                   "<html>
<p>This example shows the response of a PT2 defined by its transfer function</p>
<pre>
            1
H(jw)=-------------------
      1 + 2 d jw + (jw)^2
</pre>
<p>Frequency performs a logarithmic ramp from 0.01 to 100 s^-1.</p>
<p>
Plot the magnitude locus (in dB) dB versus lg_w and the phase locus versus lg_w.
</p>
</html>"));
    end ShowTransferFunction;
    annotation (Documentation(info="<html>
<p>This library demonstrates the usage of Complex blocks.</p>
</html>"));
  end Examples;

  package Interfaces
    "Library of connectors and partial models for input/output blocks"
    extends Modelica.Icons.InterfacesPackage;

    connector ComplexInput = input Complex "'input Complex' as connector"
      annotation (
      defaultComponentName="u",
      Icon(coordinateSystem(
          extent={{-100,-100},{100,100}},
          preserveAspectRatio=true,
          initialScale=0.2), graphics={Polygon(
            points={{-100,100},{100,0},{-100,-100},{-100,100}},
            lineColor={85,170,255},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          initialScale=0.2,
          extent={{-100,-100},{100,100}}), graphics={Polygon(
            points={{0,50},{100,0},{0,-50},{0,50}},
            lineColor={85,170,255},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-10,85},{-10,60}},
            lineColor={0,0,127},
            textString="%name")}),
      Documentation(info="<html>
<p>
Connector with one input signal of type Complex.
</p>
</html>"));

    connector ComplexOutput = output Complex "'output Complex' as connector"
      annotation (
      defaultComponentName="y",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Polygon(
            points={{-100,100},{100,0},{-100,-100},{-100,100}},
            lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
            points={{-100,50},{0,0},{-100,-50},{-100,50}},
            lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{30,110},{30,60}},
            lineColor={0,0,127},
            textString="%name")}),
      Documentation(info="<html>
<p>
Connector with one output signal of type Complex.
</p>
</html>"));

    partial block ComplexSO "Single Output continuous control block"
      extends Modelica.Blocks.Icons.Block;
      ComplexOutput y "Connector of Complex output signal" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));
      annotation (Documentation(info="<html>
<p>
Block has one continuous Complex output signal.
</p>
</html>"));
    end ComplexSO;

    partial block ComplexMO "Multiple Output continuous control block"
      extends Modelica.Blocks.Icons.Block;
      parameter Integer nout(min=1) = 1 "Number of outputs";
      ComplexOutput y[nout] "Connector of Complex output signals" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));
      annotation (Documentation(info="<html>
<p>
Block has one continuous Complex output signal vector.
</p>
</html>"));
    end ComplexMO;

    partial block ComplexSISO
      "Single Input Single Output continuous control block"
      extends Modelica.Blocks.Icons.Block;
      ComplexInput u "Connector of Complex input signal" annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}})));
      ComplexOutput y "Connector of Complex output signal" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));
      parameter Boolean useConjugateInput=false
        "If true, input is processed conjugate complex";
    protected
      Complex uInternal=(if useConjugateInput then Modelica.ComplexMath.conj(u)
           else u)
        "Equals either u or conjugate complex input u if useComplexInput = true";
      annotation (Documentation(info="<html>
<p>
Block has one continuous Complex input and one continuous Complex output signal.
</p>
</html>"));
    end ComplexSISO;

    partial block ComplexSI2SO
      "2 Single Input / 1 Single Output continuous control block"
      extends Modelica.Blocks.Icons.Block;
      ComplexInput u1 "Connector of Complex input signal 1" annotation (
          Placement(transformation(extent={{-140,40},{-100,80}})));
      ComplexInput u2 "Connector of Complex input signal 2" annotation (
          Placement(transformation(extent={{-140,-80},{-100,-40}})));
      ComplexOutput y "Connector of Complex output signal" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));
      parameter Boolean useConjugateInput1=false
        "If true, input 1 is processed conjugate complex";
      parameter Boolean useConjugateInput2=false
        "If true, input 2 is processed conjugate complex";
    protected
      Complex u1Internal=(if useConjugateInput1 then Modelica.ComplexMath.conj(
          u1) else u1)
        "Equals either u1 or conjugate complex input u1 if useComplexInput1 = true";
      Complex u2Internal=(if useConjugateInput2 then Modelica.ComplexMath.conj(
          u2) else u2)
        "Equals either u2 or conjugate complex input u2 if useComplexInput2 = true";
      annotation (Documentation(info="<html>
<p>
Block has two continuous Complex input signals u1 and u2 and one
continuous Complex output signal y.
</p>
</html>"));
    end ComplexSI2SO;

    partial block ComplexSIMO
      "Single Input Multiple Output continuous control block"
      extends Modelica.Blocks.Icons.Block;
      parameter Integer nout=1 "Number of outputs";

      ComplexInput u "Connector of Complex input signal" annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}})));
      ComplexOutput y[nout] "Connector of Complex output signals" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));

      parameter Boolean useConjugateInput=false
        "If true, input is processed conjugate complex";
    protected
      Complex uInternal=(if useConjugateInput then Modelica.ComplexMath.conj(u)
           else u)
        "Equals either u or conjugate complex input u if useComplexInput = true";

      annotation (Documentation(info="<html>
<p>
 Block has one continuous Complex input signal and a
vector of continuous Complex output signals.
</p>
</html>"));
    end ComplexSIMO;

    partial block ComplexMISO
      "Multiple Input Single Output continuous control block"
      extends Modelica.Blocks.Icons.Block;
      parameter Integer nin=1 "Number of inputs";
      ComplexInput u[nin] "Connector of Complex input signals" annotation (
          Placement(transformation(extent={{-140,-20},{-100,20}})));
      ComplexOutput y "Connector of Complex output signal" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));

      parameter Boolean useConjugateInput[nin]=fill(false, nin)
        "If true, inputs are processed conjugate complex";
    protected
      Complex uInternal[nin]={if useConjugateInput[k] then
          Modelica.ComplexMath.conj(u[k]) else u[k] for k in 1:nin}
        "Equals either u or conjugate complex input u if useComplexInput = true";

      annotation (Documentation(info="<html>
<p>
Block has a vector of continuous Complex input signals and
one continuous Complex output signal.
</p>
</html>"));
    end ComplexMISO;

    partial block ComplexMIMO
      "Multiple Input Multiple Output continuous control block"
      extends Modelica.Blocks.Icons.Block;
      parameter Integer nin=1 "Number of inputs";
      parameter Integer nout=1 "Number of outputs";
      ComplexInput u[nin] "Connector of Complex input signals" annotation (
          Placement(transformation(extent={{-140,-20},{-100,20}})));
      ComplexOutput y[nout] "Connector of Complex output signals" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));
      parameter Boolean useConjugateInput[nin]=fill(false, nin)
        "If true, inputs are processed conjugate complex";
    protected
      Complex uInternal[nin]={if useConjugateInput[k] then
          Modelica.ComplexMath.conj(u[k]) else u[k] for k in 1:nin}
        "Equals either u or conjugate complex input u if useComplexInput = true";

      annotation (Documentation(info="<html>
<p>
Block has a continuous Complex input vector and a continuous Complex output signal vector.
The signal sizes of the input and output vector may be different.
</p>
</html>"));
    end ComplexMIMO;

    partial block ComplexMIMOs
      "Multiple Input Multiple Output continuous control block with same number of inputs and outputs"
      extends Modelica.Blocks.Icons.Block;
      parameter Integer n=1 "Number of inputs (= number of outputs)";
      ComplexInput u[n] "Connector of Complex input signals" annotation (
          Placement(transformation(extent={{-140,-20},{-100,20}})));
      ComplexOutput y[n] "Connector of Complex output signals" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));

      parameter Boolean useConjugateInput[n]=fill(false, n)
        "If true, inputs are processed conjugate complex";
    protected
      Complex uInternal[n]={if useConjugateInput[k] then
          Modelica.ComplexMath.conj(u[k]) else u[k] for k in 1:n}
        "Equals either u or conjugate complex input u if useComplexInput = true";

      annotation (Documentation(info="<html>
<p>
Block has a continuous Complex input vector and a continuous Complex output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</html>"));
    end ComplexMIMOs;

    partial block ComplexMI2MO
      "2 Multiple Input / Multiple Output continuous control block"
      extends Modelica.Blocks.Icons.Block;
      parameter Integer n=1 "Dimension of input and output vectors.";
      ComplexInput u1[n] "Connector 1 of Complex input signals" annotation (
          Placement(transformation(extent={{-140,40},{-100,80}})));
      ComplexInput u2[n] "Connector 2 of Complex input signals" annotation (
          Placement(transformation(extent={{-140,-80},{-100,-40}})));
      ComplexOutput y[n] "Connector of Complex output signals" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));

      parameter Boolean useConjugateInput1[n]=fill(false, n)
        "If true, inputs 1 are processed conjugate complex";
      parameter Boolean useConjugateInput2[n]=fill(false, n)
        "If true, inputs 2 are processed conjugate complex";
    protected
      Complex u1Internal[n]={if useConjugateInput1[k] then
          Modelica.ComplexMath.conj(u1[k]) else u1[k] for k in 1:n}
        "Equals either u1 or conjugate complex input u1 if useComplexInput = true";
      Complex u2Internal[n]={if useConjugateInput2[k] then
          Modelica.ComplexMath.conj(u2[k]) else u2[k] for k in 1:n}
        "Equals either u1 or conjugate complex input u1 if useComplexInput = true";

      annotation (Documentation(info="<html>
<p>
Block has two continuous Complex input vectors u1 and u2 and one
continuous Complex output vector y.
All vectors have the same number of elements.
</p>
</html>"));
    end ComplexMI2MO;

    partial block ComplexSignalSource "Base class for continuous signal source"
      extends ComplexBlocks.Interfaces.ComplexSO;
      parameter Complex offset=Complex(0) "Offset of output signal y";
      parameter SIunits.Time startTime=0
        "Output y = offset for time < startTime";
      annotation (Documentation(info="<html>
<p>
Basic block for Complex sources.
This component has one continuous Complex output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"));
    end ComplexSignalSource;
    annotation (Documentation(info="<html>
<p>This library defines Complex input and output signals, as well as partial blocks.</p>
</html>"));
  end Interfaces;

  package ComplexMath
    "Library of mathematical functions as input/output blocks"
    extends Modelica.Icons.Package;

    block Conj "Output is equal to the conjugate complex input signal"

      extends Modelica.ComplexBlocks.Interfaces.ComplexSISO(final
          useConjugateInput=true);

    equation
      y = uInternal;
      annotation (
        Documentation(info="<html>
<p>
This block computes output <code>y</code> as
<em>conjugate complex</em> input <code>u</code>.
</p>
<pre>
    y = Modelica.ComplexMath.conj(u)
</pre>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  points={{-40,0},{40,0}},
                  color={0,0,255}),Line(
                  points={{-40,0},{40,0}},
                  color={0,0,255},
                  rotation=60),Line(
                  points={{-40,0},{40,0}},
                  color={0,0,255},
                  rotation=120)}));
    end Conj;

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
<pre>
    y = k * (if useConjugateInput then Modelica.ComplexMath.conj(u) else u);
</pre>
<p><strong>Example:</strong> If <code>useConjugateInput = true</code> and <code>k = 2</code> the output signal <code>y = 2 * Modelica.ComplexMath.conj(u)</code>.</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Polygon(
                  points={{-100,-100},{-100,100},{100,0},{-100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-150,-140},{150,-100}},
                  textString="k=%k"),Text(
                  extent={{-150,140},{150,100}},
                  textString="%name",
                  lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Polygon(
                  points={{-100,-100},{-100,100},{100,0},{-100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-76,38},{0,-34}},
                  textString="k",
                  lineColor={0,0,255})}));
    end Gain;

    block Sum "Output the sum of the elements of the input vector"
      extends Interfaces.ComplexMISO;
      parameter Complex k[nin]=fill(Complex(1, 0), nin)
        "Optional: sum coefficients";
    equation
      y = k*uInternal;
      annotation (
        defaultComponentName="sum1",
        Documentation(info="<html>
<p>
This blocks computes output <code>y</code> as
<em>sum</em> of the elements of the input signal vector
<code>u</code>:
</p>
<pre>
    <code>y</code> = <code>u</code>[1] + <code>u</code>[2] + ...;
</pre>
<p>
Example:
</p>
<pre>
     parameter:   nin = 3;

  results in the following equations:

     y = u[1] + u[2] + u[3];
</pre>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  points={{26,42},{-34,42},{6,2},{-34,-38},{26,-38}})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(
                  points={{26,42},{-34,42},{6,2},{-34,-38},{26,-38}})}));
    end Sum;

    block Feedback
      "Output difference between commanded input 1 and feedback input 2"

      Interfaces.ComplexInput u1 annotation (Placement(transformation(extent={{
                -100,-20},{-60,20}})));
      Interfaces.ComplexInput u2 annotation (Placement(transformation(
            origin={0,-80},
            extent={{-20,-20},{20,20}},
            rotation=90)));
      Interfaces.ComplexOutput y annotation (Placement(transformation(extent={{
                80,-10},{100,10}})));

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
<pre>
  y = (if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1)
    - (if useConjugateInput1 then Modelica.ComplexMath.conj(u2) else u2);
</pre>
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
<pre>
     y = Modelica.ComplexMath.conj(u1) - u2
</pre>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Ellipse(
                  extent={{-20,20},{20,-20}},
                  lineColor={0,0,127},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.Solid),Line(points={{-60,0},{-20,0}},
              color={0,0,127}),Line(points={{20,0},{80,0}}, color={0,0,127}),
              Line(points={{0,-20},{0,-60}}, color={0,0,127}),Text(
                  extent={{-14,0},{82,-94}},
                  textString="-"),Text(
                  extent={{-150,94},{150,44}},
                  textString="%name",
                  lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Ellipse(
                  extent={{-20,20},{20,-20}},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,255}),Line(points={{-60,0},{-20,0}}, color={0,0,255}),
              Line(points={{20,0},{80,0}}, color={0,0,255}),Line(points=
               {{0,-20},{0,-60}}, color={0,0,255}),Text(
                  extent={{-12,10},{84,-84}},
                  textString="-")}));
    end Feedback;

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
<pre>
  y = k1*u1Internal + k2*u2Internal;
</pre>
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
<pre>
     y = 2 * Modelica.ComplexMath.conj(u1) - 3 * u2
</pre>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Text(
                  extent={{-98,-52},{7,-92}},
                  textString="%k2"),Text(
                  extent={{-100,90},{5,50}},
                  textString="%k1"),   Line(points={{-100,60},{-40,60},{-30,40}},
              color={0,0,255}),Ellipse(extent={{-50,50},{50,-50}}, lineColor={0,
              0,255}),Line(points={{-100,-60},{-40,-60},{-30,-40}}, color={0,0,255}),
              Line(points={{-15,-25.99},{15,25.99}}),
              Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{50,0},{100,0}},
              color={0,0,255}),Line(points={{-100,60},{-74,24},{-44,24}}, color=
               {0,0,127}),Line(points={{-100,-60},{-74,-28},{-42,-28}}, color={
              0,0,127}),Ellipse(extent={{-50,50},{50,-50}}, lineColor={0,0,127}),
              Line(points={{50,0},{100,0}}, color={0,0,127}),Text(
                  extent={{-38,34},{38,-34}},
                  textString="+"),Text(
                  extent={{-100,52},{5,92}},
                  textString="%k1"),Text(
                  extent={{-100,-52},{5,-92}},
                  textString="%k2")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-98,-52},{7,-92}},
                  textString="%k2"),Text(
                  extent={{-100,90},{5,50}},
                  textString="%k1"),Line(points={{-100,60},{-40,60},{-30,40}},
              color={0,0,255}),Ellipse(extent={{-50,50},{50,-50}}, lineColor={0,
              0,255}),Line(points={{-100,-60},{-40,-60},{-30,-40}}, color={0,0,255}),
              Line(points={{-15,-25.99},{15,25.99}}),
              Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{50,0},{100,0}},
              color={0,0,255}),Line(points={{-100,60},{-74,24},{-44,24}}, color=
               {0,0,127}),Line(points={{-100,-60},{-74,-28},{-42,-28}}, color={
              0,0,127}),Ellipse(extent={{-50,50},{50,-50}}, lineColor={0,0,127}),
              Line(points={{50,0},{100,0}}, color={0,0,127}),Text(
                  extent={{-38,34},{38,-34}},
                  textString="+"),Text(
                  extent={{-100,52},{5,92}},
                  textString="k1"),Text(
                  extent={{-100,-52},{5,-92}},
                  textString="k2")}));
    end Add;

    block Add3 "Output the sum of the three inputs"
      extends Modelica.Blocks.Icons.Block;

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
<pre>
  y = k1*(if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1)
    + k2*(if useConjugateInput2 then Modelica.ComplexMath.conj(u2) else u2)
    + k3*(if useConjugateInput3 then Modelica.ComplexMath.conj(u3) else u3);</pre>
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
<pre>
     y = 2 * Modelica.ComplexMath.conj(u1) - 3 * u2 + u3;
</pre>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Text(
                  extent={{-100,50},{5,90}},
                  textString="%k1"),Text(
                  extent={{-100,-20},{5,20}},
                  textString="%k2"),Text(
                  extent={{-100,-50},{5,-90}},
                  textString="%k3"),Text(
                  extent={{2,36},{100,-44}},
                  textString="+")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-100,50},{5,90}},
                  textString="%k1"),Text(
                  extent={{-100,-20},{5,20}},
                  textString="%k2"),Text(
                  extent={{-100,-50},{5,-90}},
                  textString="%k3"),Text(
                  extent={{2,36},{100,-44}},
                  textString="+"),Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-100,50},{5,90}},
                  textString="k1"),Text(
                  extent={{-100,-20},{5,20}},
                  textString="k2"),Text(
                  extent={{-100,-50},{5,-90}},
                  textString="k3"),Text(
                  extent={{2,36},{100,-44}},
                  textString="+")}));
    end Add3;

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
<pre>
  y = u1Inernal * u2Internal;
</pre>

<p><strong>Example:</strong> If <code>useConjugateInput1 = true</code> and <code>useConjugateInput2 = false</code> the output signal <code>y = Modelica.ComplexMath.conj(u1) * u2</code>.</p>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-100,60},{-40,60},{-30,40}},
              color={0,0,127}),Line(points={{-100,-60},{-40,-60},{-30,-40}},
              color={0,0,127}),Line(points={{50,0},{100,0}}, color={0,0,127}),
              Line(points={{-30,0},{30,0}}),Line(points={{-15,
              25.99},{15,-25.99}}),Line(points={{-15,-25.99},{15,
              25.99}}),Ellipse(extent={{-50,50},{50,-50}},
              lineColor={0,0,127})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-100,60},{-40,60},
              {-30,40}}, color={0,0,255}),Line(points={{-100,-60},{-40,-60},{-30,
              -40}}, color={0,0,255}),Line(points={{50,0},{100,0}}, color={0,0,255}),
              Line(points={{-30,0},{30,0}}),Line(points={{
              -15,25.99},{15,-25.99}}),Line(points={{-15,-25.99},
              {15,25.99}}),Ellipse(extent={{-50,50},{50,-50}},
              lineColor={0,0,255})}));
    end Product;

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
<pre>
    y = u1Internal / u2Internal;
</pre>

<p><strong>Example:</strong> If <code>useConjugateInput1 = true</code> and <code>useConjugateInput2 = false</code> the output signal <code>y = Modelica.ComplexMath.conj(u1) / u2</code>.</p>


</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{50,0},{100,0}}, color={0,0,127}),
              Line(points={{-30,0},{30,0}}),Ellipse(
                  extent={{-5,20},{5,30}},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-5,-20},{5,-30}},
                  fillPattern=FillPattern.Solid),Ellipse(extent={{-50,50},{50,-50}},
                lineColor={0,0,127}),
              Line(points={{-100,60},{-66,60},{-40,30}},
              color={0,0,127}),Line(points={{-100,-60},{0,-60},{0,-50}}, color=
              {0,0,127}),
            Text(
              extent={{-60,94},{90,54}},
              lineColor={128,128,128},
              textString="u1 / u2")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{50,0},{100,0}},
              color={0,0,255}),Line(points={{-30,0},{30,0}}),
              Ellipse(
                  extent={{-5,20},{5,30}},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-5,-20},{5,-30}},
                  fillPattern=FillPattern.Solid),Ellipse(extent={{-50,50},{50,-50}},
              lineColor={0,0,255}),Line(points={{-100,60},{-66,60},{-40,30}},
              color={0,0,255}),Line(points={{-100,-60},{0,-60},{0,-50}}, color=
              {0,0,255})}));
    end Division;

    block Sqrt
      "Output the square root of the input (= principal square root of complex number)"
      extends Interfaces.ComplexSISO;
    equation
      y = Modelica.ComplexMath.'sqrt'(uInternal);
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
              74.7},{80,80}}),Polygon(
                  points={{-80,90},{-88,68},{-72,68},{-80,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-88},{-80,68}},
              color={192,192,192}),Text(
                  extent={{-8,-4},{64,-52}},
                  lineColor={192,192,192},
                  textString="sqrt")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-92,-80},{84,-80}}, color=
              {192,192,192}),Polygon(
                  points={{100,-80},{84,-74},{84,-86},{100,-80}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-79.2,
              -68.7},{-78.4,-64},{-76.8,-57.3},{-73.6,-47.9},{-67.9,-36.1},{-59.1,
              -22.2},{-46.2,-6.49},{-28.5,10.7},{-4.42,30},{27.7,51.3},{69.5,
              74.7},{80,80}}),Polygon(
                  points={{-80,98},{-86,82},{-74,82},{-80,98}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-90},{-80,84}},
              color={192,192,192}),Text(
                  extent={{-71,98},{-44,78}},
                  lineColor={160,160,164},
                  textString="y"),Text(
                  extent={{60,-52},{84,-72}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code>
as <em>square root</em> of the input <code>u</code> (= principal square root of the complex input). Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>sqrt</strong>(uInternal);
</pre>
</html>"));
    end Sqrt;

    block Sin "Output the sine of the input"
      extends Interfaces.ComplexSISO;
    equation
      y = Modelica.ComplexMath.sin(uInternal);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Polygon(
                  points={{-80,90},{-88,68},{-72,68},{-80,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-80,68}},
              color={192,192,192}),Line(points={{-90,0},{68,0}}, color={192,192,192}),
              Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},
              {-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},
              {-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},
              {23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{
              51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={
              0,0,0}),Polygon(
                  points={{90,0},{68,8},{68,-8},{90,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{12,84},{84,36}},
                  lineColor={192,192,192},
                  textString="sin")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-80,80},{-88,80}}, color={
              192,192,192}),Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
              Line(points={{-80,-90},{-80,84}}, color={192,192,192}),Text(
                  extent={{-75,98},{-46,78}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{-80,96},{-86,80},{-74,80},{-80,96}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
              color={192,192,192}),Polygon(
                  points={{100,0},{84,6},{84,-6},{100,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,0},{-68.7,
              34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,
              79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,
              21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},
              {40.6,-80},{46.2,-77.6},{51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{
              72,-24.8},{80,0}}),Text(
                  extent={{-105,72},{-85,88}},
                  textString="1",
                  lineColor={0,0,255}),Text(
                  extent={{70,25},{90,5}},
                  textString="2*pi",
                  lineColor={0,0,255}),Text(
                  extent={{-105,-72},{-85,-88}},
                  textString="-1",
                  lineColor={0,0,255}),Text(
                  extent={{76,-10},{98,-30}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code>
as <strong>sine</strong> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>sin</strong>(uInternal);
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/sin.png\"
     alt=\"sin.png\">
</p>

</html>"));
    end Sin;

    block Cos "Output the cosine of the input"
      extends Interfaces.ComplexSISO;
    equation
      y = Modelica.ComplexMath.cos(uInternal);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Polygon(
                  points={{-80,90},{-88,68},{-72,68},{-80,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-80,68}},
              color={192,192,192}),Line(points={{-90,0},{68,0}}, color={192,192,192}),
              Polygon(
                  points={{90,0},{68,8},{68,-8},{90,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,80},{-74.4,
              78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},{-48.6,26.6},{-29.3,-32.5},
              {-22.1,-51.7},{-15.7,-65.3},{-10.1,-73.8},{-4.42,-78.8},{1.21,-79.9},
              {6.83,-77.1},{12.5,-70.6},{18.1,-60.6},{24.5,-45.7},{32.6,-23},{
              50.3,31.3},{57.5,50.7},{63.9,64.6},{69.5,73.4},{75.2,78.6},{80,80}}),Text(
                  extent={{-36,82},{36,34}},
                  lineColor={192,192,192},
                  textString="cos")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-80,80},{-88,80}}, color={
              192,192,192}),Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
              Line(points={{-80,-90},{-80,84}}, color={192,192,192}),Text(
                  extent={{-75,102},{-48,82}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{-80,100},{-86,84},{-74,84},{-80,100}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-103,72},{-83,88}},
                  textString="1",
                  lineColor={0,0,255}),Text(
                  extent={{-79,-72},{-59,-88}},
                  textString="-1",
                  lineColor={0,0,255}),Text(
                  extent={{70,25},{90,5}},
                  textString="2*pi",
                  lineColor={0,0,255}),Line(points={{-100,0},{84,0}}, color={
              192,192,192}),Polygon(
                  points={{100,0},{84,6},{84,-6},{100,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,80},{-74.4,
              78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},{-48.6,26.6},{-29.3,-32.5},
              {-22.1,-51.7},{-15.7,-65.3},{-10.1,-73.8},{-4.42,-78.8},{1.21,-79.9},
              {6.83,-77.1},{12.5,-70.6},{18.1,-60.6},{24.5,-45.7},{32.6,-23},{
              50.3,31.3},{57.5,50.7},{63.9,64.6},{69.5,73.4},{75.2,78.6},{80,80}}),Text(
                  extent={{74,-4},{98,-24}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code>
as <strong>cos</strong> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>cos</strong>(uInternal);
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/cos.png\"
     alt=\"cos.png\">
</p>

</html>"));
    end Cos;

    block Tan "Output the tangent of the input"
      extends Interfaces.ComplexSISO;
    equation
      y = Modelica.ComplexMath.tan(uInternal);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Polygon(
                  points={{0,90},{-8,68},{8,68},{0,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{0,-80},{0,68}},
              color={192,192,192}),Line(points={{-80,-80},{-78.4,-68.4},{-76.8,
              -59.7},{-74.4,-50},{-71.2,-40.9},{-67.1,-33},{-60.7,-24.8},{-51.1,
              -17.2},{-35.8,-9.98},{-4.42,-1.07},{33.4,9.12},{49.4,16.2},{59.1,
              23.2},{65.5,30.6},{70.4,39.1},{73.6,47.4},{76,56.1},{77.6,63.8},{
              80,80}}),Line(points={{-90,0},{68,0}}, color={192,192,192}),
              Polygon(
                  points={{90,0},{68,8},{68,-8},{90,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-90,72},{-18,24}},
                  lineColor={192,192,192},
                  textString="tan")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,192,192}),
              Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
              Line(points={{0,-88},{0,86}}, color={192,192,192}),Text(
                  extent={{11,100},{38,80}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{0,102},{-6,86},{6,86},{0,102}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-37,-72},{-17,-88}},
                  textString="-5.8",
                  lineColor={0,0,255}),Text(
                  extent={{-33,86},{-13,70}},
                  textString=" 5.8",
                  lineColor={0,0,255}),Text(
                  extent={{70,25},{90,5}},
                  textString="1.4",
                  lineColor={0,0,255}),Line(points={{-100,0},{84,0}}, color={
              192,192,192}),Polygon(
                  points={{100,0},{84,6},{84,-6},{100,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-78.4,
              -68.4},{-76.8,-59.7},{-74.4,-50},{-71.2,-40.9},{-67.1,-33},{-60.7,
              -24.8},{-51.1,-17.2},{-35.8,-9.98},{-4.42,-1.07},{33.4,9.12},{
              49.4,16.2},{59.1,23.2},{65.5,30.6},{70.4,39.1},{73.6,47.4},{76,
              56.1},{77.6,63.8},{80,80}}),Text(
                  extent={{70,-6},{94,-26}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code>
as <strong>tan</strong> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>tan</strong>(uInternal);
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/tan.png\"
     alt=\"tan.png\">
</p>

</html>"));
    end Tan;

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
              37.4,24.8},{57.5,40.8},{68.7,52.7},{75.2,62.2},{77.6,67.5},{80,80}}),Line(points={{-90,0},{68,0}}, color={192,192,192}),
              Polygon(
                  points={{90,0},{68,8},{68,-8},{90,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-88,78},{-16,30}},
                  lineColor={192,192,192},
                  textString="asin")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,192,192}),
              Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
              Line(points={{0,-90},{0,84}}, color={192,192,192}),Text(
                  extent={{9,102},{36,82}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{0,100},{-6,84},{6,84},{0,100}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-40,-72},{-15,-88}},
                  textString="-pi/2",
                  lineColor={0,0,255}),Text(
                  extent={{-38,88},{-13,72}},
                  textString=" pi/2",
                  lineColor={0,0,255}),Text(
                  extent={{70,25},{90,5}},
                  textString="+1",
                  lineColor={0,0,255}),Text(
                  extent={{-90,21},{-70,1}},
                  textString="-1",
                  lineColor={0,0,255}),Line(points={{-100,0},{84,0}}, color={
              192,192,192}),Polygon(
                  points={{100,0},{84,6},{84,-6},{100,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-79.2,
              -72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,-49.8},{-53.5,-37.3},{-30.2,
              -19.7},{37.4,24.8},{57.5,40.8},{68.7,52.7},{75.2,62.2},{77.6,67.5},
              {80,80}}),Text(
                  extent={{74,-4},{100,-26}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>sine-inverse</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>asin</strong>(uInternal);
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/asin.png\"
     alt=\"asin.png\">
</p>

</html>"));
    end Asin;

    block Acos "Output the arc cosine of the input"
      extends Interfaces.ComplexSISO;
    equation
      y = Modelica.ComplexMath.acos(uInternal);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Polygon(
                  points={{0,90},{-8,68},{8,68},{0,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,80},{-79.2,
              72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,49.8},{-53.5,37.3},{-30.2,
              19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},{75.2,-62.2},{77.6,-67.5},
              {80,-80}}),Line(points={{0,-88},{0,68}}, color={
              192,192,192}),Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
              Polygon(
                  points={{90,-80},{68,-72},{68,-88},{90,-80}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-86,-14},{-14,-62}},
                  lineColor={192,192,192},
                  textString="acos")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,192,192}),
              Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
              Line(points={{0,-90},{0,84}}, color={192,192,192}),Text(
                  extent={{13,100},{42,82}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{0,100},{-6,84},{6,84},{0,100}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-100,-80},{84,-80}},
              color={192,192,192}),Polygon(
                  points={{100,-80},{84,-74},{84,-86},{100,-80}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,80},{-79.2,
              72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,49.8},{-53.5,37.3},{-30.2,
              19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},{75.2,-62.2},{77.6,-67.5},
              {80,-80}}),Text(
                  extent={{-30,88},{-5,72}},
                  textString=" pi",
                  lineColor={0,0,255}),Text(
                  extent={{-94,-57},{-74,-77}},
                  textString="-1",
                  lineColor={0,0,255}),Text(
                  extent={{80,-45},{100,-65}},
                  textString="+1",
                  lineColor={0,0,255}),Text(
                  extent={{76,-84},{102,-102}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>cosine-inverse</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>acos</strong>(uInternal);
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/acos.png\"
     alt=\"acos.png\">
</p>

</html>"));
    end Acos;

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
              {24.5,60.8},{33.4,67.6},{47,73.6},{69.5,78.6},{80,80}}),
              Line(points={{-90,0},{68,0}}, color={192,192,192}),Polygon(
                  points={{90,0},{68,8},{68,-8},{90,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-86,68},{-14,20}},
                  lineColor={192,192,192},
                  textString="atan")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,192,192}),
              Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
              Line(points={{0,-90},{0,84}}, color={192,192,192}),Text(
                  extent={{13,102},{42,82}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{0,100},{-6,84},{6,84},{0,100}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
              color={192,192,192}),Polygon(
                  points={{100,0},{84,6},{84,-6},{100,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-52.7,
              -75.2},{-37.4,-69.7},{-26.9,-63},{-19.7,-55.2},{-14.1,-45.8},{-10.1,
              -36.4},{-6.03,-23.9},{-1.21,-5.06},{5.23,21},{9.25,34.1},{13.3,
              44.2},{18.1,52.9},{24.5,60.8},{33.4,67.6},{47,73.6},{69.5,78.6},{
              80,80}}),Text(
                  extent={{-32,91},{-12,71}},
                  textString="1.4",
                  lineColor={0,0,255}),Text(
                  extent={{-32,-71},{-12,-91}},
                  textString="-1.4",
                  lineColor={0,0,255}),Text(
                  extent={{73,26},{93,10}},
                  textString=" 5.8",
                  lineColor={0,0,255}),Text(
                  extent={{-103,20},{-83,4}},
                  textString="-5.8",
                  lineColor={0,0,255}),Text(
                  extent={{66,-8},{94,-28}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>tangent-inverse</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y= <strong>atan</strong>(uInternal);
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan.png\"
     alt=\"atan.png\">
</p>

</html>"));
    end Atan;

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
                  lineColor={192,192,192},
                  textString="sinh"),Line(points={{0,-80},{0,68}}, color={192,192,192}),
              Line(points={{-90,0},{68,0}}, color={192,192,192}),Line(
              points={{-80,-80},{-76,-65.4},{-71.2,-51.4},{-65.5,-38.8},{-59.1,
              -28.1},{-51.1,-18.7},{-41.4,-11.4},{-27.7,-5.5},{-4.42,-0.653},{
              24.5,4.57},{39,10.1},{49.4,17.2},{57.5,25.9},{63.9,35.8},{69.5,
              47.4},{74.4,60.4},{78.4,73.8},{80,80}}),Polygon(
                  points={{90,0},{68,8},{68,-8},{90,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,192,192}),
              Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
              Line(points={{0,-90},{0,84}}, color={192,192,192}),Text(
                  extent={{9,98},{34,78}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{0,100},{-6,84},{6,84},{0,100}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
              color={192,192,192}),Polygon(
                  points={{100,0},{84,6},{84,-6},{100,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-76,-65.4},
              {-71.2,-51.4},{-65.5,-38.8},{-59.1,-28.1},{-51.1,-18.7},{-41.4,-11.4},
              {-27.7,-5.5},{-4.42,-0.653},{24.5,4.57},{39,10.1},{49.4,17.2},{
              57.5,25.9},{63.9,35.8},{69.5,47.4},{74.4,60.4},{78.4,73.8},{80,80}}),Text(
                  extent={{-31,72},{-11,88}},
                  textString="27",
                  lineColor={0,0,255}),Text(
                  extent={{-35,-88},{-15,-72}},
                  textString="-27",
                  lineColor={0,0,255}),Text(
                  extent={{70,25},{90,5}},
                  textString="4",
                  lineColor={0,0,255}),Text(
                  extent={{-98,21},{-78,1}},
                  textString="-4",
                  lineColor={0,0,255}),Text(
                  extent={{72,-6},{96,-26}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>hyperbolic sine</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>sinh</strong>(uInternal);
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/sinh.png\"
     alt=\"sinh.png\">
</p>

</html>"));
    end Sinh;

    block Cosh "Output the hyperbolic cosine of the input"
      extends Interfaces.ComplexSISO;
    equation
      y = Modelica.ComplexMath.cosh(uInternal);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Polygon(
                  points={{0,90},{-8,68},{8,68},{0,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{0,-80},{0,68}},
              color={192,192,192}),Text(
                  extent={{4,66},{66,20}},
                  lineColor={192,192,192},
                  textString="cosh"),Line(points={{-80,80},{-77.6,61.1},{-74.4,
              39.3},{-71.2,20.7},{-67.1,1.29},{-63.1,-14.6},{-58.3,-29.8},{-52.7,
              -43.5},{-46.2,-55.1},{-39,-64.3},{-30.2,-71.7},{-18.9,-77.1},{-4.42,
              -79.9},{10.9,-79.1},{23.7,-75.2},{34.2,-68.7},{42.2,-60.6},{48.6,
              -51.2},{54.3,-40},{59.1,-27.5},{63.1,-14.6},{67.1,1.29},{71.2,
              20.7},{74.4,39.3},{77.6,61.1},{80,80}}),Line(
              points={{-90,-86.083},{68,-86.083}}, color={192,192,192}),Polygon(
                  points={{90,-86.083},{68,-78.083},{68,-94.083},{90,-86.083}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,192,192}),
              Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
              Line(points={{0,-90},{0,84}}, color={192,192,192}),Text(
                  extent={{11,98},{38,78}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{0,100},{-6,84},{6,84},{0,100}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-100,-86.083},{
              84,-86.083}}, color={192,192,192}),Polygon(
                  points={{100,-86.083},{84,-80.083},{84,-92.083},{100,-86.083}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,80},{-77.6,
              61.1},{-74.4,39.3},{-71.2,20.7},{-67.1,1.29},{-63.1,-14.6},{-58.3,
              -29.8},{-52.7,-43.5},{-46.2,-55.1},{-39,-64.3},{-30.2,-71.7},{-18.9,
              -77.1},{-4.42,-79.9},{10.9,-79.1},{23.7,-75.2},{34.2,-68.7},{42.2,
              -60.6},{48.6,-51.2},{54.3,-40},{59.1,-27.5},{63.1,-14.6},{67.1,
              1.29},{71.2,20.7},{74.4,39.3},{77.6,61.1},{80,80}}),
              Text(
                  extent={{-31,72},{-11,88}},
                  textString="27",
                  lineColor={0,0,255}),Text(
                  extent={{62,-67},{82,-87}},
                  textString="4",
                  lineColor={0,0,255}),Text(
                  extent={{-104,-63},{-84,-83}},
                  textString="-4",
                  lineColor={0,0,255}),Text(
                  extent={{78,-54},{100,-74}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>hyperbolic cosine</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>cosh</strong>(uInternal);
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/cosh.png\"
     alt=\"cosh.png\">
</p>

</html>"));
    end Cosh;

    block Tanh "Output the hyperbolic tangent of the input"
      extends Interfaces.ComplexSISO;
    equation
      y = Modelica.ComplexMath.tanh(uInternal);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{0,-90},{0,84}}, color={192,192,192}),
              Line(points={{-100,0},{84,0}}, color={192,192,192}),
              Line(points={{-80,-80},{-47.8,-78.7},{-35.8,-75.7},{-27.7,-70.6},
              {-22.1,-64.2},{-17.3,-55.9},{-12.5,-44.3},{-7.64,-29.2},{-1.21,-4.82},
              {6.83,26.3},{11.7,42},{16.5,54.2},{21.3,63.1},{26.9,69.9},{34.2,
              75},{45.4,78.4},{72,79.9},{80,80}}),Polygon(
                  points={{0,90},{-8,68},{8,68},{0,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-88,72},{-16,24}},
                  lineColor={192,192,192},
                  textString="tanh"),Polygon(
                  points={{90,0},{68,8},{68,-8},{90,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,192,192}),
              Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
              Line(points={{0,-90},{0,84}}, color={192,192,192}),Text(
                  extent={{9,98},{42,80}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{0,100},{-6,84},{6,84},{0,100}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
              color={192,192,192}),Polygon(
                  points={{100,0},{84,6},{84,-6},{100,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-47.8,
              -78.7},{-35.8,-75.7},{-27.7,-70.6},{-22.1,-64.2},{-17.3,-55.9},{-12.5,
              -44.3},{-7.64,-29.2},{-1.21,-4.82},{6.83,26.3},{11.7,42},{16.5,
              54.2},{21.3,63.1},{26.9,69.9},{34.2,75},{45.4,78.4},{72,79.9},{80,
              80}}),Text(
                  extent={{70,25},{90,5}},
                  textString="4",
                  lineColor={0,0,255}),Text(
                  extent={{-106,21},{-86,1}},
                  textString="-4",
                  lineColor={0,0,255}),Text(
                  extent={{-29,72},{-9,88}},
                  textString="1",
                  lineColor={0,0,255}),Text(
                  extent={{3,-72},{23,-88}},
                  textString="-1",
                  lineColor={0,0,255}),Text(
                  extent={{72,-8},{98,-26}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>hyperbolic tangent</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>tanh</strong>(uInternal);
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\"
     alt=\"tanh.png\">
</p>

</html>"));
    end Tanh;

    block Exp "Output the exponential (base e) of the input"
      extends Interfaces.ComplexSISO;
    equation
      y = Modelica.ComplexMath.exp(uInternal);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{0,-80},{0,68}}, color={192,192,192}),
              Polygon(
                  points={{0,90},{-8,68},{8,68},{0,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-86,50},{-14,2}},
                  lineColor={192,192,192},
                  textString="exp"),Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},
              {10.9,-68.4},{23.7,-61},{34.2,-51.6},{43,-40.3},{50.3,-27.8},{
              56.7,-13.5},{62.3,2.23},{67.1,18.6},{72,38.2},{76,57.6},{80,80}}),Line(points={{-90,-80.3976},{68,-80.3976}}, color=
              {192,192,192}),Polygon(
                  points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,192,192}),
              Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
              Line(points={{0,-90},{0,84}}, color={192,192,192}),Text(
                  extent={{9,100},{40,80}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{0,100},{-6,84},{6,84},{0,100}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-100,-80.3976},{
              84,-80.3976}}, color={192,192,192}),Polygon(
                  points={{100,-80.3976},{84,-74.3976},{84,-86.3976},{100,-80.3976}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-31,-77.9},
              {-6.03,-74},{10.9,-68.4},{23.7,-61},{34.2,-51.6},{43,-40.3},{50.3,
              -27.8},{56.7,-13.5},{62.3,2.23},{67.1,18.6},{72,38.2},{76,57.6},{
              80,80}}),Text(
                  extent={{-31,72},{-11,88}},
                  textString="20",
                  lineColor={0,0,255}),Text(
                  extent={{-92,-83},{-72,-103}},
                  textString="-3",
                  lineColor={0,0,255}),Text(
                  extent={{70,-83},{90,-103}},
                  textString="3",
                  lineColor={0,0,255}),Text(
                  extent={{-18,-53},{2,-73}},
                  textString="1",
                  lineColor={0,0,255}),Text(
                  extent={{66,-52},{96,-72}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>exponential</em> (of base e) of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>exp</strong>(uInternal);
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\"
     alt=\"exp.png\">
</p>

</html>"));
    end Exp;

    block Log
      "Output the natural (base e) logarithm of the input (input <> '0' required)"
      extends Interfaces.ComplexSISO;
    equation
      y = Modelica.ComplexMath.log(uInternal);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-80,-80},{-80,68}}, color={
              192,192,192}),Polygon(
                  points={{-80,90},{-88,68},{-72,68},{-80,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-79.2,
              -50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},{-75.2,-11.4},{-72.8,
              -1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},{-47,38.1},{-31.8,
              48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}}),
              Line(points={{-90,0},{68,0}}, color={192,192,192}),Polygon(
                  points={{90,0},{68,8},{68,-8},{90,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-6,-24},{66,-72}},
                  lineColor={192,192,192},
                  textString="log")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-80,80},{-88,80}}, color={
              192,192,192}),Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
              Line(points={{-80,-90},{-80,84}}, color={192,192,192}),Text(
                  extent={{-67,98},{-40,80}},
                  lineColor={160,160,164},
                  textString="y"),Polygon(
                  points={{-80,100},{-86,84},{-74,84},{-80,100}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
              color={192,192,192}),Polygon(
                  points={{100,0},{84,6},{84,-6},{100,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-79.2,
              -50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},{-75.2,-11.4},{-72.8,
              -1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},{-47,38.1},{-31.8,
              48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}}),
              Text(
                  extent={{-105,72},{-85,88}},
                  textString="3",
                  lineColor={0,0,255}),Text(
                  extent={{-109,-88},{-89,-72}},
                  textString="-3",
                  lineColor={0,0,255}),Text(
                  extent={{70,-3},{90,-23}},
                  textString="20",
                  lineColor={0,0,255}),Text(
                  extent={{-78,-1},{-58,-21}},
                  textString="1",
                  lineColor={0,0,255}),Text(
                  extent={{68,28},{94,8}},
                  lineColor={160,160,164},
                  textString="u")}),
        Documentation(info="<html>
<p>
This blocks computes the output <code>y</code> as the
<em>natural (base e) logarithm</em> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<pre>
    y = <strong>log</strong>(uInternal);
</pre>
<p>
An error occurs if the elements of the input <code>u</code> is zero.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/log.png\"
     alt=\"log.png\">
</p>

</html>"));
    end Log;

    block RealToComplex "Converts Cartesian representation to complex"
      extends Modelica.ComplexBlocks.Interfaces.ComplexSO;
      Blocks.Interfaces.RealInput re annotation (Placement(transformation(
              extent={{-130,40},{-90,80}}), iconTransformation(extent={{-140,40},
                {-100,80}})));
      Blocks.Interfaces.RealInput im annotation (Placement(transformation(
              extent={{-130,-80},{-90,-40}}), iconTransformation(extent={{-140,
                -80},{-100,-40}})));
    equation
      y = Complex(re, im);
      annotation (Icon(graphics={Text(
                  extent={{-100,80},{-20,40}},
                  lineColor={0,0,127},
                  textString="re"),Text(
                  extent={{-100,-40},{-20,-80}},
                  lineColor={0,0,127},
                  textString="im"),Polygon(
                  points={{20,0},{0,20},{0,10},{-30,10},{-30,-10},{0,-10},{0,-20},
                {20,0}},
                  lineColor={0,128,255},
                  fillColor={85,170,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{20,60},{100,-60}},
                  lineColor={85,170,255},
              textString="C")}),     Documentation(info="<html>
<p>Converts the Real inputs <em>re</em> (real part) and <em>im</em> (imaginary part) to the Complex output <em>y</em>.</p>
</html>"));
    end RealToComplex;

    block PolarToComplex "Converts polar representation to complex"
      extends Modelica.ComplexBlocks.Interfaces.ComplexSO;
      Blocks.Interfaces.RealInput len annotation (Placement(transformation(
              extent={{-130,40},{-90,80}}), iconTransformation(extent={{-140,40},
                {-100,80}})));
      Blocks.Interfaces.RealInput phi(unit="rad") annotation (Placement(transformation(
              extent={{-130,-80},{-90,-40}}), iconTransformation(extent={{-140,
                -80},{-100,-40}})));
    equation
      y = Complex(len*cos(phi), len*sin(phi));
      annotation (Icon(graphics={Text(
                  extent={{-100,80},{-20,40}},
                  lineColor={0,0,127},
                  textString="len"),Text(
                  extent={{-100,-40},{-20,-80}},
                  lineColor={0,0,127},
                  textString="phi"),Polygon(
                  points={{20,0},{0,20},{0,10},{-30,10},{-30,-10},{0,-10},{0,-20},
                {20,0}},
                  lineColor={0,128,255},
                  fillColor={85,170,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{20,60},{100,-60}},
                  lineColor={85,170,255},
              textString="C")}),     Documentation(info="<html>
<p>Converts the Real inputs <em>len</em> (length, absolute) and <em>phi</em> (angle, argument) to the Complex output <em>y</em>.</p>
</html>"));
    end PolarToComplex;

    block ComplexToReal "Converts complex to Cartesian representation"
      extends Modelica.Blocks.Icons.Block;
      Blocks.Interfaces.RealOutput re annotation (Placement(transformation(
              extent={{100,40},{140,80}}), iconTransformation(extent={{100,40},
                {140,80}})));
      Blocks.Interfaces.RealOutput im annotation (Placement(transformation(
              extent={{100,-80},{140,-40}}), iconTransformation(extent={{100,-80},
                {140,-40}})));
      Interfaces.ComplexInput u
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      parameter Boolean useConjugateInput=false
        "If true, input is processed conjugate complex";
    equation
      re = u.re;
      im = (if useConjugateInput then -u.im else u.im);
      annotation (Icon(graphics={Text(
                  extent={{20,80},{100,40}},
                  lineColor={0,0,127},
                  textString="re"),Text(
                  extent={{20,-40},{100,-80}},
                  lineColor={0,0,127},
                  textString="im"),Polygon(
                  points={{40,0},{20,20},{20,10},{-10,10},{-10,-10},{20,-10},{
                20,-20},{40,0}},
                  lineColor={0,128,255},
                  fillColor={85,170,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-100,60},{-20,-60}},
                  lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid,
              textString="C")}),     Documentation(info="<html>
<p>Converts the Complex input <em>u</em> to the Real outputs <em>re</em> (real part) and <em>im</em> (imaginary part).</p>
</html>"));
    end ComplexToReal;

    block ComplexToPolar "Converts complex to polar representation"
      extends Modelica.Blocks.Icons.Block;
      Blocks.Interfaces.RealOutput len annotation (Placement(transformation(
              extent={{100,40},{140,80}}), iconTransformation(extent={{100,40},
                {140,80}})));
      Blocks.Interfaces.RealOutput phi(unit="rad") annotation (Placement(transformation(
              extent={{100,-80},{140,-40}}), iconTransformation(extent={{100,-80},
                {140,-40}})));
      Interfaces.ComplexInput u
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      parameter Boolean useConjugateInput=false
        "If true, input is processed conjugate complex";
    equation
      len = (u.re^2 + u.im^2)^0.5;
      phi = (if useConjugateInput then Modelica.Math.atan2(-u.im, u.re) else
        Modelica.Math.atan2(u.im, u.re));

      annotation (Icon(graphics={Text(
                  extent={{20,80},{100,40}},
                  lineColor={0,0,127},
                  textString="len"),Text(
                  extent={{20,-40},{100,-80}},
                  lineColor={0,0,127},
                  textString="phi"),Polygon(
                  points={{40,0},{20,20},{20,10},{-10,10},{-10,-10},{20,-10},{
                20,-20},{40,0}},
                  lineColor={0,128,255},
                  fillColor={85,170,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-100,60},{-20,-60}},
                  lineColor={85,170,255},
              textString="C")}),     Documentation(info="<html>
<p>Converts the Complex input <em>u</em> to the Real outputs <em>len</em> (length, absolute) and <em>phi</em> (angle, argument).</p>
</html>"));
    end ComplexToPolar;

    block Bode "Calculate quantities to plot Bode diagram"
      parameter Boolean useDivisor = true "Use divisor input, if true" annotation(Evaluate = true, HideResult = true, choices(  checkBox = true));
      constant Modelica.SIunits.AmplitudeLevelDifference dB = 20 "Amplitude level difference";
      Interfaces.ComplexInput u "Dividend if useDivisor == true" annotation (Placement(transformation(extent={{-140,40},{-100,80}}),   iconTransformation(extent={{-140,40},{-100,80}})));
      Interfaces.ComplexInput divisor if useDivisor "Divisor" annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(extent={{-140,-80},{-100,-40}})));
      Blocks.Interfaces.RealOutput abs_y "Absolute value of ratio u / divisor" annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,-110}),                                                                              iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,-110})));
      Blocks.Interfaces.RealOutput arg_y(unit="rad") "Angle of ratio u / divisor" annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,-110}),                                                                                iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,-110})));
      Interfaces.ComplexOutput y "Quotient y = u / divisor" annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
      Sources.ComplexConstant complexOne(final k=Complex(1, 0)) if not useDivisor "Complex(1,0)" annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
      Division division(final useConjugateInput1=false, final useConjugateInput2=false)
                        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      ComplexToPolar complexToPolar(final useConjugateInput=false) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,-20})));
      Blocks.Interfaces.RealOutput dB_y(unit="dB") "Log10 of absolute value of ratio u / divisor in dB" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-110}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-110})));
      Blocks.Math.Log10 log10_y annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={-10,-70})));
      Blocks.Math.Gain gain(final k=dB) annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
      Blocks.Nonlinear.Limiter limiter(final uMax=Modelica.Constants.inf, final uMin=Modelica.Constants.eps) annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
    equation

      connect(complexOne.y, division.u2) annotation (Line(points={{-79,-40},{-70,-40},{-70,-6},{-62,-6}}, color={85,170,255}));
      connect(divisor, division.u2) annotation (Line(points={{-120,-60},{-70,-60},{-70,-6},{-62,-6}}, color={85,170,255}));
      connect(division.u1, u) annotation (Line(points={{-62,6},{-70,6},{-70,60},{-120,60}}, color={85,170,255}));
      connect(division.y, y) annotation (Line(points={{-39,0},{110,0},{110,0}}, color={85,170,255}));
      connect(complexToPolar.u, y) annotation (Line(points={{0,-8},{0,0},{110,0}},  color={85,170,255}));
      connect(complexToPolar.phi, arg_y) annotation (Line(points={{6,-32},{6,-40},{60,-40},{60,-110}}, color={0,0,127}));
      connect(complexToPolar.len, abs_y) annotation (Line(points={{-6,-32},{-6,-40},{-60,-40},{-60,-110}}, color={0,0,127}));
      connect(log10_y.y, gain.u) annotation (Line(points={{1,-70},{8,-70}},     color={0,0,127}));
      connect(gain.y, dB_y) annotation (Line(points={{31,-70},{40,-70},{40,-90},{0,-90},{0,-110}},color={0,0,127}));
      connect(limiter.y, log10_y.u) annotation (Line(points={{-29,-70},{-22,-70}}, color={0,0,127}));
      connect(complexToPolar.len, limiter.u) annotation (Line(points={{-6,-32},{-6,-40},{-60,-40},{-60,-70},{-52,-70}}, color={0,0,127}));
      annotation (Icon(graphics={Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
            Line(points={{-78,44},{80,44}}, color={135,135,135}),
            Line(points={{-78,34},{80,34}}, color={135,135,135}),
            Line(points={{-78,20},{80,20}}, color={135,135,135}),
            Line(points={{-78,-2},{80,-2}}, color={135,135,135}),
            Line(points={{-78,-48},{80,-48}}, color={135,135,135}),
            Line(points={{-50,-48},{-50,44}}, color={135,135,135}),
            Line(points={{50,-48},{50,44}}, color={135,135,135}),
            Line(points={{-78,40},{80,40}}, color={135,135,135}),
                                   Polygon(
                  points={{90,-48},{68,-40},{68,-56},{90,-48}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                            Polygon(
                  points={{-70,90},{-78,68},{-62,68},{-70,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
            Line(points={{-70,-56},{-70,68}}, color={135,135,135}),
            Line(
              points={{-78,44},{-50,44},{70,-66}},
              color={0,0,255},
              thickness=0.5),               Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
            Text(
              extent={{-80,-90},{-40,-70}},
              lineThickness=0.5,
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid,
              textString="|y|",
              lineColor={128,128,128}),
            Text(
              extent={{-20,-90},{20,-70}},
              lineThickness=0.5,
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid,
              textString="dB",
              lineColor={128,128,128}),
            Text(
              extent={{40,-90},{80,-70}},
              lineThickness=0.5,
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid,
              lineColor={128,128,128},
              textString="angle"),
            Text(
              visible = useDivisor,
              extent={{-56,94},{94,54}},
              lineColor={128,128,128},
              textString="u / divisor")}),
        Documentation(info="<html>
<p>This complex block is used to determine variables of a Bode diagram for the output <code>y</code>.
The output <code>y</code> is calculated by <code>u / divisor</code> if <code>useDivisor == true</code>.
Otherwise the output <code>y = u</code>.</p>
<ul>
<li><code>abs_y</code> Absolute value of <code>y</code></li>
<li><code>arg_y</code> Angle of <code>y</code></li>
<li><code>dB_y</code> Logarithm to the base 10 of the absolute value of <code>y</code> in dB</li>
</ul>
</html>"));
    end Bode;

    block TransferFunction "Complex Transfer Function"
      extends Modelica.ComplexBlocks.Interfaces.ComplexSISO;
      import Modelica.ComplexMath.j;
      import Modelica.ComplexMath.'sum';
      parameter Real b[:]={1}
        "Numerator coefficients of transfer function (e.g., 2*s+3 is specified as {2,3})";
      parameter Real a[:]={1}
        "Denominator coefficients of transfer function (e.g., 5*s+6 is specified as {5,6})";
      Modelica.Blocks.Interfaces.RealInput w "Frequency input" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));
    protected
      Complex bw[size(b,1)];
      Complex aw[size(a,1)];
      Complex bSum;
      Complex aSum;
    equation
      bw = {b[i]*(j*w)^(i-1) for i in 1:size(b,1)};
      aw = {a[i]*(j*w)^(i-1) for i in 1:size(a,1)};
      bSum = Complex(sum(bw.re), sum(bw.im));
      aSum = Complex(sum(aw.re), sum(aw.im));
      y = u*bSum/aSum;
      annotation (Icon(graphics={
          Text(
            lineColor={0,0,127},
            extent={{-90,10},{90,90}},
              textString="b(jw)"),
            Line(points={{-80,0},{80,0}},
              color={0,0,127}),
          Text(
            lineColor={0,0,127},
            extent={{-90,-90},{90,-10}},
              textString="a(jw)")}), Documentation(info="<html>
<p>
The complex input u is multiplied by the complex transfer function (depending on frequency input w) to obtain the complex output y (nb = dimension of b, na = dimension of a):
</p>
<pre>
           b[1]*(jw)^[nb-1] + b[2]*(jw)^[nb-2] + ... + b[nb]
   y(jw) = ------------------------------------------------- * u(jw)
           a[1]*(jw)^[na-1] + a[2]*(jw)^[na-2] + ... + a[na]
</pre>
</html>"));
    end TransferFunction;
    annotation (Documentation(info="<html>
<p>
This package contains basic <strong>mathematical operations</strong>,
such as summation and multiplication, and basic <strong>mathematical
functions</strong>, such as <strong>sqrt</strong> and <strong>sin</strong>, as
input/output blocks. All blocks of this library can be either
connected with continuous blocks or with sampled-data blocks.
</p>
</html>", revisions="<html>
</html>"), Icon(graphics={Line(
            points={{-80,-2},{-68.7,32.2},{-61.5,51.1},{-55.1,64.4},{-49.4,72.6},
                {-43.8,77.1},{-38.2,77.8},{-32.6,74.6},{-26.9,67.7},{-21.3,57.4},
                {-14.9,42.1},{-6.83,19.2},{10.1,-32.8},{17.3,-52.2},{23.7,-66.2},
                {29.3,-75.1},{35,-80.4},{40.6,-82},{46.2,-79.6},{51.9,-73.5},{
                57.5,-63.9},{63.9,-49.2},{72,-26.8},{80,-2}},
            color={95,95,95},
            smooth=Smooth.Bezier)}));
  end ComplexMath;

  package Routing "Library of blocks to combine and extract signals"
    extends Modelica.Icons.Package;

    block Replicator "Signal replicator"
      extends Modelica.ComplexBlocks.Interfaces.ComplexSIMO;
    equation
      y = fill(u, nout);
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{-100,0},{-6,0}}, color={0,0,127}),
            Line(points={{100,0},{10,0}}, color={0,0,127}),
            Line(points={{0,0},{100,10}}, color={0,0,127}),
            Line(points={{0,0},{100,-10}}, color={0,0,127}),
            Ellipse(
              extent={{-14,16},{16,-14}},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This block replicates the input signal to an array of <code>nout</code> identical output signals.
</p>
</html>"));
    end Replicator;

  block ExtractSignal "Extract signals from an input signal vector"
    extends Modelica.ComplexBlocks.Interfaces.ComplexMIMO;
    parameter Integer extract[nout]=1:nout "Extracting vector";

  equation
    for i in 1:nout loop
      y[i] = u[extract[i]];

    end for;
    annotation (
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-90,51},{-50,-49}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Rectangle(
              extent={{50,50},{90,-50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Polygon(
              points={{-94.4104,1.90792},{-94.4104,-2.09208},{-90.4104,-0.0920762},
                  {-94.4104,1.90792}},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Line(points={{-72,2},{-60.1395,12.907},{-49.1395,12.907}}, color={0,0,127}),
            Line(points={{-73,4},{-59,40},{-49,40}}, color={0,0,127}),
            Line(points={{-113,0},{-76.0373,-0.0180176}}, color={0,0,127}),
            Line(points={{-73,-5},{-60,-40},{-49,-40}}, color={0,0,127}),
            Line(points={{-72,-2},{-60.0698,-12.907},{-49.0698,-12.907}}, color={
                  0,0,127}),
            Polygon(
              points={{-48.8808,-11},{-48.8808,-15},{-44.8808,-13},{-48.8808,-11}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Line(points={{-46,13},{-35,13},{35,-30},{45,-30}}, color={0,0,127}),
            Line(points={{-45,40},{-35,40},{35,0},{44,0}}, color={0,0,127}),
            Line(points={{-45,-40},{-34,-40},{35,30},{44,30}}, color={0,0,127}),
            Polygon(
              points={{-49,42},{-49,38},{-45,40},{-49,42}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Polygon(
              points={{-48.8728,-38.0295},{-48.8728,-42.0295},{-44.8728,-40.0295},
                  {-48.8728,-38.0295}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Polygon(
              points={{-48.9983,14.8801},{-48.9983,10.8801},{-44.9983,12.8801},{-48.9983,
                  14.8801}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Line(points={{80,0},{100,0}}, color={0,0,127}),
            Polygon(
              points={{43.1618,32.3085},{43.1618,28.3085},{47.1618,30.3085},{
                  43.1618,32.3085}},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Polygon(
              points={{43.2575,1.80443},{43.2575,-2.19557},{47.2575,-0.195573},{
                  43.2575,1.80443}},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Polygon(
              points={{43.8805,-28.1745},{43.8805,-32.1745},{47.8805,-30.1745},{
                  43.8805,-28.1745}},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Line(points={{48,0},{70,0}}, color={0,0,127}),
            Line(points={{47,30},{60,30},{73,3}}, color={0,0,127}),
            Line(points={{49,-30},{60,-30},{74,-4}}, color={0,0,127}),
            Text(
              extent={{-150,-150},{150,-110}},
              textString="extract=%extract"),
            Ellipse(
              extent={{-81.0437,4.59255},{-71.0437,-4.90745}},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Ellipse(
              extent={{69.3052,4.12743},{79.3052,-5.37257}},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127})}),
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-90,50},{-50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{50,50},{90,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-94.4104,1.90792},{-94.4104,-2.09208},{-90.4104,-0.0920762},
                  {-94.4104,1.90792}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-72,2},{-60.1395,12.907},{-49.1395,12.907}}, color={0,0,255}),
            Line(points={{-73,4},{-59,40},{-49,40}}, color={0,0,255}),
            Line(points={{-112,0},{-75.0373,-0.0180176}}, color={0,0,255}),
            Ellipse(
              extent={{-80.0437,4.59255},{-70.0437,-4.90745}},
              lineColor={0,0,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-73,-5},{-60,-40},{-49,-40}}, color={0,0,255}),
            Line(points={{-72,-2},{-60.0698,-12.907},{-49.0698,-12.907}}, color={
                  0,0,255}),
            Polygon(
              points={{-48.8808,-11},{-48.8808,-15},{-44.8808,-13},{-48.8808,-11}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-46,13},{-35,13},{35,-30},{45,-30}}, color={0,0,255}),
            Line(points={{-45,40},{-35,40},{35,0},{44,0}}, color={0,0,255}),
            Line(points={{-45,-40},{-34,-40},{35,30},{44,30}}, color={0,0,255}),
            Polygon(
              points={{-49,42},{-49,38},{-45,40},{-49,42}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-48.8728,-38.0295},{-48.8728,-42.0295},{-44.8728,-40.0295},
                  {-48.8728,-38.0295}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-48.9983,14.8801},{-48.9983,10.8801},{-44.9983,12.8801},{-48.9983,
                  14.8801}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{70.3052,4.12743},{80.3052,-5.37257}},
              lineColor={0,0,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Line(points={{80,0},{105,0}}, color={0,0,255}),
            Polygon(
              points={{44.1618,32.3085},{44.1618,28.3085},{48.1618,30.3085},{
                  44.1618,32.3085}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{44.2575,1.80443},{44.2575,-2.19557},{48.2575,-0.195573},{
                  44.2575,1.80443}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{44.8805,-28.1745},{44.8805,-32.1745},{48.8805,-30.1745},{
                  44.8805,-28.1745}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{48,0},{70,0}}, color={0,0,255}),
            Line(points={{47,30},{60,30},{73,3}}, color={0,0,255}),
            Line(points={{49,-30},{60,-30},{74,-4}}, color={0,0,255}),
            Rectangle(extent={{-100,80},{100,-81}}, lineColor={0,0,255})}),
      Documentation(info="<html>
<p>Extract signals from the input connector and transfer them
to the output connector.</p>
<p>The extracting scheme is given by the integer vector 'extract'.
This vector specifies, which input signals are taken and in which
order they are transferred to the output vector. Note, that the
dimension of 'extract' has to match the number of outputs.
Additionally, the dimensions of the input connector signals and
the output connector signals have to be explicitly defined via the
parameters 'nin' and 'nout'.</p>
<p>Example:</p>
<pre>     nin = 7 \"Number of inputs\";
     nout = 4 \"Number of outputs\";
     extract[nout] = {6,3,3,2} \"Extracting vector\";
</pre>
<p>extracts four output signals (nout=4) from the seven elements of the
input vector (nin=7):</p>
<pre>   output no. 1 is set equal to input no. 6
   output no. 2 is set equal to input no. 3
   output no. 3 is set equal to input no. 3
   output no. 4 is set equal to input no. 2
</pre>
</html>"));
  end ExtractSignal;

  block Extractor
    "Extract scalar signal out of signal vector dependent on IntegerRealInput index"

    extends Modelica.ComplexBlocks.Interfaces.ComplexMISO;

    parameter Boolean allowOutOfRange=false "Index may be out of range";
    parameter Complex outOfRangeValue=Complex(1e10,0) "Output signal if index is out of range";

    Modelica.Blocks.Interfaces.IntegerInput index annotation (Placement(
            transformation(
            origin={0,-120},
            extent={{-20,-20},{20,20}},
            rotation=90)));
    protected
    Complex k[nin];
  equation

    when {initial(),change(index)} then

      for i in 1:nin loop
        k[i] = if index == i then Complex(1,0) else Complex(0,0);

      end for;

    end when;

    y = if not allowOutOfRange or index > 0 and index <= nin then
                k*u else outOfRangeValue;
    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-80,50},{-40,-50}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-84.4104,1.9079},{-84.4104,-2.09208},{-80.4104,-0.09208},{
                  -84.4104,1.9079}},
              lineColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Line(points={{-62,2},{-50.1395,12.907},{-39.1395,12.907}}, color={0,0,127}),
            Line(points={{-63,4},{-49,40},{-39,40}}, color={0,0,127}),
            Line(points={{-102,0},{-65.0373,-0.01802}}, color={0,0,127}),
            Ellipse(
              extent={{-70.0437,4.5925},{-60.0437,-4.90745}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Line(points={{-63,-5},{-50,-40},{-39,-40}}, color={0,0,127}),
            Line(points={{-62,-2},{-50.0698,-12.907},{-39.0698,-12.907}}, color={
                  0,0,127}),
            Polygon(
              points={{-38.8808,-11},{-38.8808,-15},{-34.8808,-13},{-38.8808,-11}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-39,42},{-39,38},{-35,40},{-39,42}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-38.8728,-38.0295},{-38.8728,-42.0295},{-34.8728,-40.0295},
                  {-38.8728,-38.0295}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-38.9983,14.8801},{-38.9983,10.8801},{-34.9983,12.8801},{-38.9983,
                  14.8801}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-30,50},{30,-50}},
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}),
            Line(points={{100,0},{0,0}}, color={0,0,127}),
            Line(points={{0,2},{0,-104}}, color={255,128,0}),
            Line(points={{-35,40},{-20,40}}, color={0,0,127}),
            Line(points={{-35,13},{-20,13}}, color={0,0,127}),
            Line(points={{-35,-13},{-20,-13}}, color={0,0,127}),
            Line(points={{-35,-40},{-20,-40}}, color={0,0,127}),
            Polygon(points={{0,0},{-20,13},{-20,13},{0,0},{0,0}}, lineColor={0,0,
                  127}),
            Ellipse(
              extent={{-6,6},{6,-6}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This block extracts a scalar output signal out the
vector of input signals dependent on the Integer
value of the additional u index:</p>
<pre>    y = u [ index ] ;
</pre>
<p>where index is an additional Integer input signal.</p>
</html>"));
  end Extractor;

    model ComplexPassThrough
      "Pass a Complex signal through without modification"
      extends Modelica.Blocks.Interfaces.SISO;
    equation
      y = u;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
                color={0,0,127})}),
                        Documentation(info="<html>
<p>
Passes a Complex signal through without modification.  Enables signals to be read out of one bus, have their name changed and be sent back to a bus.
</p>
</html>"));
    end ComplexPassThrough;
    annotation (Documentation(info="<html>
<p>
This package contains blocks to combine and extract signals.
</p>
</html>"),   Icon(graphics={
          Line(points={{-90,0},{4,0}}, color={95,95,95}),
          Line(points={{88,65},{48,65},{-8,0}}, color={95,95,95}),
          Line(points={{-8,0},{93,0}}, color={95,95,95}),
          Line(points={{87,-65},{48,-65},{-8,0}}, color={95,95,95})}));
  end Routing;

  package Sources "Library of signal source blocks generating Complex signals"
    extends Modelica.Icons.SourcesPackage;

    block ComplexExpression
      "Set output signal to a time varying Complex expression"

      Modelica.ComplexBlocks.Interfaces.ComplexOutput y=Complex(0)
        "Value of Complex output" annotation (Dialog(group=
              "Time varying output signal"), Placement(transformation(extent={{
                100,-10},{120,10}})));

      annotation (defaultComponentName="complexExpr",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
                  extent={{-100,40},{100,-40}},
                  lineThickness=5.0,
                  fillColor={235,235,235},
                  fillPattern=FillPattern.Solid,
                  borderPattern=BorderPattern.Raised),Text(
                  extent={{-96,15},{96,-15}},
                  textString="%y"),Text(
                  extent={{-150,90},{140,50}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>
The (time varying) Complex output signal of this block can be defined in its
parameter menu via variable <strong>y</strong>. The purpose is to support the
easy definition of Complex expressions in a block diagram.
Note, that \"time\" is a built-in variable that is always
accessible and represents the \"model time\" and that
Variable <strong>y</strong> is both a variable and a connector.
</p>
</html>"));

    end ComplexExpression;

    block ComplexConstant "Generate constant signal of type Complex"
      parameter Complex k(re(start=1),im(start=0)) "Constant output value";
      extends Modelica.ComplexBlocks.Interfaces.ComplexSO;

    equation
      y = k;
      annotation (
        defaultComponentName="complexConst",
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-80,68},{-80,-80}}, color={
              192,192,192}),Polygon(
                  points={{-80,90},{-88,68},{-72,68},{-80,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-90,-70},{82,-70}},
              color={192,192,192}),Polygon(
                  points={{90,-70},{68,-62},{68,-78},{90,-70}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,0},{80,0}}),Text(
                  extent={{-150,-150},{150,-110}},
                  textString="k=%k")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Polygon(
                  points={{-80,90},{-86,68},{-74,68},{-80,90}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
              color={95,95,95}),Line(
                  points={{-80,0},{80,0}},
                  color={0,0,255},
                  thickness=0.5),Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                  points={{90,-70},{68,-64},{68,-76},{90,-70}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-83,92},{-30,74}},
                  textString="y"),Text(
                  extent={{70,-80},{94,-100}},
                  textString="time"),Text(
                  extent={{-101,8},{-81,-12}},
                  textString="k")}),
        Documentation(info="<html>
<p>
The Complex output y is a constant signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Constant.png\"
     alt=\"Constant.png\">
</p>
</html>"));
    end ComplexConstant;

    block ComplexStep "Generate step signal of type Complex"
      parameter Complex height=Complex(1) "Height of step";
      extends ComplexBlocks.Interfaces.ComplexSignalSource;

    equation
      y = offset + (if time < startTime then Complex(0) else height);
      annotation (defaultComponentName="complexStep",
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-80,68},{-80,-80}}, color={
              192,192,192}),Polygon(
                  points={{-80,90},{-88,68},{-72,68},{-80,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-90,-70},{82,-70}},
              color={192,192,192}),Polygon(
                  points={{90,-70},{68,-62},{68,-78},{90,-70}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-70},{0,-70},
              {0,50},{80,50}}),Text(
                  extent={{-150,-150},{150,-110}},
                  textString="startTime=%startTime")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Polygon(
                  points={{-80,90},{-86,68},{-74,68},{-80,90}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
              color={95,95,95}),Line(
                  points={{-80,-18},{0,-18},{0,50},{80,50}},
                  color={0,0,255},
                  thickness=0.5),Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                  points={{90,-70},{68,-64},{68,-76},{90,-70}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{70,-80},{94,-100}},
                  textString="time"),Text(
                  extent={{-21,-72},{25,-90}},
                  textString="startTime"),Line(points={{0,-17},{0,-71}}, color=
              {95,95,95}),Text(
                  extent={{-68,-36},{-22,-54}},
                  textString="offset"),Line(points={{-13,50},{-13,-17}}, color=
              {95,95,95}),Polygon(
                  points={{2,50},{-19,50},{2,50}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-13,50},{-16,37},{-9,37},{-13,50}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-68,26},{-22,8}},
                  textString="height"),Polygon(
                  points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(points={{-13,-18},{-13,-70}},
              color={95,95,95}),Polygon(
                  points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-72,100},{-31,80}},
                  textString="y")}),
        Documentation(info="<html>
<p>
The Complex output y is a step signal (of real and imaginary part):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Step.png\"
     alt=\"Step.png\">
</p>

</html>"));
    end ComplexStep;

    block ComplexRotatingPhasor
      "Generate a phasor with constant magnitude and constant angular velocity of type Complex"
      parameter Real magnitude=1 "Magnitude of complex phasor";
      parameter Modelica.SIunits.AngularVelocity w=1
        "Constant angular velocity of complex phasor";
      parameter Modelica.SIunits.Angle phi0=0
        "Initial angle of complex phasor at time = 0";
      extends Modelica.ComplexBlocks.Interfaces.ComplexSO;
      Modelica.SIunits.Angle phi "Angle";
    equation
      phi = w*time + phi0;
      y = magnitude*Modelica.ComplexMath.exp(Complex(0, phi));
      annotation (defaultComponentName="complexRotating",
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
                  points={{-10,90},{-16,68},{-4,68},{-10,90}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(points={{-10,68},{-10,-90}},
              color={95,95,95}),Line(points={{-90,0},{82,0}}, color={95,95,95}),
              Polygon(
                  points={{90,0},{68,6},{68,-6},{90,0}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(
                  points={{-10,0},{50,50}},
                  color={0,0,255}),
                                 Polygon(
                  points={{50,50},{29,41},{38,30},{50,50}},
                  lineColor={95,95,95},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),Line(points={{-47,35},{-40,40},
              {-32,44},{-20,47},{-7,46},{5,42},{18,34},{26,23},{31,10}}, color={192,192,192},
              smooth=Smooth.Bezier),
                         Polygon(
                  points={{-52,29},{-32,36},{-42,47},{-52,29}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
The output y is a complex phasor with constant magnitude, spinning with constant angular velocity.
</p>

</html>"));
    end ComplexRotatingPhasor;

    block ComplexRampPhasor "Generate a phasor with ramped magnitude and constant angle"
      extends Modelica.ComplexBlocks.Interfaces.ComplexSO;
      import Modelica.Constants.eps;
      parameter Real magnitude1(final min=0,start=1) "Magnitude of complex phasor at startTime"
        annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasor.png"));
      parameter Real magnitude2(final min=0,start=1) "Magnitude of complex phasor at startTime+duration";
      parameter Boolean useLogRamp = false "Ramp appears linear on a logarithmic scale, if true";
      parameter Modelica.SIunits.Angle phi(start=0) "Angle of complex phasor";
      parameter Modelica.SIunits.Time startTime=0 "Start time of frequency sweep";
      parameter Modelica.SIunits.Time duration(min=0.0, start=1) "Duration of ramp (= 0.0 gives a Step)";
      Real magnitude "Actual magnitude of complex phasor";
    equation
      assert(not useLogRamp or (magnitude1>eps and magnitude2>eps),
        "ComplexRampPhasor: magnitude1 and magnitude2 have to be greater than eps, if useLogRamp = true");
      magnitude = if not useLogRamp then
        magnitude1 + (if time < startTime then
          0 else
          if time < (startTime + max(duration,eps)) then
            (time - startTime)*(magnitude2-magnitude1)/max(duration,eps)
          else
          magnitude2-magnitude1)
      else
        if time < startTime then magnitude1 else
        if time < (startTime + max(duration,eps)) then
          10^(log10(magnitude1) + (log10(magnitude2) - log10(magnitude1))*min(1, (time-startTime)/max(duration,eps)))
        else
          magnitude2;

      y = magnitude*Modelica.ComplexMath.exp(Complex(0, phi));

      annotation (defaultComponentName="complexRamp",
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
                  points={{-10,90},{-16,68},{-4,68},{-10,90}},
                  lineColor={192,192,192},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(points={{-10,68},{-10,-90}},
              color={95,95,95}),Line(points={{-90,0},{82,0}}, color={95,95,95}),
              Polygon(
                  points={{90,0},{68,6},{68,-6},{90,0}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(
                  points={{-10,-10},{14,10}},
                  color={0,0,255}),
                                 Polygon(
                  points={{28,22},{7,13},{16,2},{28,22}},
                  lineColor={95,95,95},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),Line(
                  points={{-10,6},{50,56}},
                  color={0,0,255}),
                                 Polygon(
                  points={{66,70},{45,61},{54,50},{66,70}},
                  lineColor={95,95,95},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
The output y is a complex phasor with constant angle and a ramped magnitude.
</p>

<p>
In case of <code>useLogRamp == false</code> the magnitude ramp is linear:
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasorLinear.png\"
     alt=\"ComplexRampPhasorLinear.png\">
</p>

<p>
In case of <code>useLogRamp == true</code> the magnitude ramp appears linear on a logarithmic scale:
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasorLog.png\"
     alt=\"ComplexRampPhasorLog.png\">
</p>

</html>"));
    end ComplexRampPhasor;

    block LogFrequencySweep "Logarithmic frequency sweep"
      extends Modelica.Blocks.Interfaces.SO;
      import Modelica.Constants.eps;
      parameter Real wMin(final min=eps) "Start frequency"
        annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/LogFrequencySweep.png"));
      parameter Real wMax(final min=eps) "End frequency";
      parameter Modelica.SIunits.Time startTime=0 "Start time of frequency sweep";
      parameter Modelica.SIunits.Time duration(min=0.0, start=1) "Duration of ramp (= 0.0 gives a Step)";
    equation
      y = if time < startTime then wMin else
        if time < (startTime + max(duration,eps)) then
          10^(log10(wMin) + (log10(wMax) - log10(wMin))*min(1, (time-startTime)/max(duration,eps)))
        else
          wMax;
       annotation (defaultComponentName="logSweep",
         Documentation(info="<html>
<p>The output <code>y</code> performs a logarithmic frequency sweep.
The logarithm of frequency <code>w</code> performs a linear ramp from <code>log10(wMin)</code> to <code>log10(wMax)</code>.
The output is the decimal power of this logarithmic ramp.
</p>
<p>For <code>time &lt; startTime</code> the output is equal to <code>wMin</code>.</p>
<p>For <code>time &gt; startTime+duration</code> the output is equal to <code>wMax</code>.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LogFrequencySweep.png\"
     alt=\"LogFrequencySweep.png\">
</p>

</html>"),
        Icon(graphics={
            Line(points={{-78,44},{80,44}}, color={135,135,135}),
            Line(points={{-78,34},{80,34}}, color={135,135,135}),
            Line(points={{-78,20},{80,20}}, color={135,135,135}),
            Line(points={{-78,-2},{80,-2}}, color={135,135,135}),
            Line(points={{-78,-48},{80,-48}}, color={135,135,135}),
            Line(
              points={{-70,-48},{-50,-48},{50,44},{70,44}}),
            Line(points={{-50,-48},{-50,44}}, color={135,135,135}),
            Line(points={{50,-48},{50,44}}, color={135,135,135}),
            Line(points={{-78,40},{80,40}}, color={135,135,135}),
                                   Polygon(
                  points={{90,-48},{68,-40},{68,-56},{90,-48}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                            Polygon(
                  points={{-70,90},{-78,68},{-62,68},{-70,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
            Line(points={{-70,-56},{-70,68}}, color={135,135,135})}));
    end LogFrequencySweep;
  end Sources;
  annotation (Documentation(info="<html>
<p>This library hosts blocks using Complex inputs and outputs.</p>
<p>It depends on the implementation of Complex.</p>
</html>"), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
          preserveAspectRatio=true), graphics={
        Rectangle(
          origin={0.0,35.1488},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Rectangle(
          origin={0.0,-34.8512},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid,
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Line(origin={-51.25,0.0}, points={{21.25,-35.0},{-13.75,-35.0},{-13.75,
              35.0},{6.25,35.0}}),
        Polygon(
          origin={-40.0,35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
        Line(origin={51.25,0.0}, points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},
              {-6.25,-35.0}}),
        Polygon(
          origin={40.0,-35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}));
end ComplexBlocks;
