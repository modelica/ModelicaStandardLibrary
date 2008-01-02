package Math "Mathematical functions as input/output blocks" 
  
  extends Modelica.Icons.Library;
  
  annotation( Window(
      x=0.05,
      y=0.09,
      width=0.44,
      height=0.71,
      library=1,
      autolayout=1),Documentation(info="<html>
<p>
This package contains basic <b>mathematical operations</b>,
such as summation and multiplication, and basic <b>mathematical
functions</b>, such as <b>sqrt</b> and <b>sin</b>, as
input/output blocks. All blocks of this library can be either
connected with continuous blocks or with sampled-data blocks.
In particular the following operations and functions are
provided:
</p>

<pre>   <b>TwoInputs</b>     Change causality of input signals.
   <b>TwoOutputs</b>    Change causality of output signals.
   <b>Gain</b>          Output the input multiplied by a scalar gain
   <b>MatrixGain</b>    Output the product of a gain matrix with the input
   <b>Sum</b>           Output the sum of the elements of the input vector
   <b>Feedback</b>      Output difference between commanded and feedback input
   <b>Add</b>           Output the sum of the two inputs
   <b>Add3</b>          Output the sum of the three inputs
   <b>Product</b>       Output product of the two inputs
   <b>Division</b>      Output first input divided by second input
   <b>Abs</b>           Output the absolute value of the input
   <b>Sign</b>          Output the sign of the input
   <b>Sqrt</b>          Output the square root of the input
   <b>Sin</b>           Output the sine of the input
   <b>Cos</b>           Output the cosine of the input
   <b>Tan</b>           Output the tangent of the input
   <b>Asin</b>          Output the arc sine of the input
   <b>Acos</b>          Output the arc cosine of the input
   <b>Atan</b>          Output the arc tangent of the input
   <b>Atan2</b>         Output atan(u1/u2) of the inputs u1 and u2
   <b>Sinh</b>          Output the hyperbolic sine of the input
   <b>Cosh</b>          Output the hyperbolic cosine of the input
   <b>Tanh</b>          Output the hyperbolic tangent of the input
   <b>Exp</b>           Output the exponential (base e) of the input
   <b>Log</b>           Output the natural (base e) logarithm of the input
   <b>Log10</b>         Output the base 10 logarithm of the input
   <b>RealToInteger</b> Output the nearest Integer value to the input
   <b>IntegerToReal</b> Output the input as Real value
   <b>Max</b>           Output the maximum of the two inputs
   <b>Min</b>           Output the minimum of the two inputs
   <b>Edge</b>          Set output to true at rising edge of the input
   <b>BooleanChange</b> Set output to true when Boolean input changes
   <b>IntegerChange</b> Set output to true when Integer input changes
</pre>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New blocks added: RealToInteger, IntegerToReal, Max, Min, Edge, BooleanChange, IntegerChange.
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized (partly based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist).
</li>
</ul>
<br>


<p><b>Copyright &copy; 1999-2002, Modelica Association and DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  
  block TwoInputs "Change causality of input signals (e.g. for inverse models)"
    
    
    extends Interfaces.BlockIcon;
    parameter Integer n=1 "number of input signals";
    annotation( Documentation(info="<html>
<p>This block is used to enable assignment of values to
variables preliminary defined as outputs (e.g. useful for
inverse model generation).</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 28, 2001</i>
       by Michael Th&uuml;mmel:<br>
       Realized.</li>
</ul>
</HTML>"));
    
    Interfaces.InPort inPort1(n=n) annotation( extent=[-140, -20; -100, 20]);
    Interfaces.InPort inPort2(n=n) annotation(
      extent=[100, -20; 140, 20],
      rotation=180);
  equation 
    inPort1.signal = inPort2.signal;
  end TwoInputs;
  
  block TwoOutputs 
    "Change causality of output signals (e.g. for inverse models)" 
    extends Interfaces.BlockIcon;
    parameter Integer n=1 "number of input signals";
    annotation( Documentation(info="<html>
<p>This block is used to enable assignment of values to
variables preliminary defined as inputs (e.g. useful for
inverse model generation).</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 28, 2001</i>
       by Michael Th&uuml;mmel:<br>
       Realized.</li>
</ul>
</HTML>"));
    
    Interfaces.OutPort OutPort1(n=n) annotation( extent=[100, -10; 120, 10]);
    Interfaces.OutPort OutPort2(n=n) annotation( extent=[-120, -10; -100, 10],
        rotation=180);
  equation 
    OutPort1.signal = OutPort2.signal;
  end TwoOutputs;
  
  block Gain 
    "Output the element-wise product of a gain vector with the input signal vector"
    
    
    parameter Real k[:]={1} 
      "Gain vector multiplied element-wise with input vector";
  protected 
    Real u[size(k, 1)] "Input signals";
    Real y[size(k, 1)] "Output signals";
  public 
    Interfaces.InPort inPort(final n=size(k, 1)) "Input signal connector" 
      annotation( extent=[-140, -20; -100, 20]);
    Interfaces.OutPort outPort(final n=size(k, 1)) "Output signal connector" 
      annotation( extent=[100, -10; 120, 10]);
    annotation(
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal as
<i>element-wise product</i> of gain <i>k</i> with the
input <b>u</b> = inPort.signal:
</p>

<pre>    y[i] = k[i] * u[i];
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"),   Icon(
        Polygon(points=[-100, -100; -100, 100; 100, 0; -100, -100], style(color=
               3, fillColor=7)),
        Text(
          extent=[-150, -140; 150, -100],
          string="k=%k",
          style(color=0)),
        Text(extent=[-150, 140; 150, 100], string="%name")),
      Diagram(Polygon(points=[-100, -100; -100, 100; 100, 0; -100, -100], style(
             color=3, fillColor=7)), Text(extent=[-76, 38; 0, -34], string="k")));
  equation 
    u = inPort.signal;
    y = outPort.signal;
    for i in 1:size(k, 1) loop
      y[i] = k[i]*u[i];
    end for;
  end Gain;
  
  block MatrixGain 
    "Output the product of a gain matrix with the input signal vector" 
    parameter Real K[:, :]=[1, 0; 0, 1] 
      "Gain matrix which is multiplied with the input";
    extends Interfaces.MIMO(final nin=size(K, 2), final nout=size(K, 1));
    annotation(
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal as <i>product</i> of the
gain matrix <b>K</b> with the input signal vector <b>u</b> = inPort.signal:
</p>

<pre>    <b>y</b> = <b>K</b> * <b>u</b>;
</pre>

<p>
Example:
</p>

<pre>   parameter: <b>K</b> = [0.12 2; 3 1.5]

   results in the following equations:

     | y[1] |     | 0.12  2.00 |   | u[1] |
     |      |  =  |            | * |      |
     | y[2] |     | 3.00  1.50 |   | u[2] |
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"),   Icon(Text(
          extent=[-90, -60; 90, 60],
          string="*K",
          style(color=9)), Text(extent=[-150, 150; 150, 110], string="%name")),
      Diagram(Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=
               7)), Text(
          extent=[-90, -60; 90, 60],
          string="*K",
          style(color=9))));
  equation 
    y = K*u;
  end MatrixGain;
  
  block Sum "Output the sum of the elements of the input vector" 
    extends Interfaces.MISO;
    
    parameter Real k[nin]=ones(nin) "Optional: sum coefficients";
    
    annotation(
      Documentation(info="<html>
<p>This block computes the output y=outPort.signal[1] as
<i>sum</i> of the elements of the input signal vector
<b>u</b>=inPort.signal:</p>

<pre>    y = u[1] + u[2] + ... + u[nin];
</pre>

<p>Example: With parameter <tt>nin = 3</tt> results the following equation:</p>

<pre>    y = u[1] + u[2] + u[3];
</pre>

<p>Optionally, the <tt>parameter Real k[nin]=ones(nin)</tt> could be
changed to weight the sum elements in order to calculate the scalar
product</p>

<pre>    y = <b>k</b>*<b>u</b> = k[1]*u[1] + k[2]*u[2] + ... + k[nin]*u[nin]  .
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Oct. 25, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Realized an improved implementation with avoidance of an
       algorithm section, which would lead to expensive function calls.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</HTML>
"),   Icon(
        Line(
          points=[26, 38; 26, 42; -34, 42; 6, 0; -34, -42; 26, -42; 26, -38],
          style(color=0, thickness=1)),
        Text(extent=[-150, 150; 150, 110], string="%name")),
      Diagram(
        Rectangle(
          extent=[-100, -100; 100, 100],
          style(color=3, fillColor=7)),
        Line(
          points=[26, 38; 26, 42; -34, 42; 6, 0; -34, -42; 26, -42; 26, -38],
          style(color=0, thickness=1))));
  equation 
    y = k*u;
  end Sum;
  
  block Feedback "Output difference between commanded and feedback input" 
    parameter Integer n=1 "size of input and feedback signal";
    Interfaces.InPort inPort1(final n=n) annotation( extent=[-100, -20; -60, 20]);
    Interfaces.InPort inPort2(final n=n) annotation( extent=[-20, -100; 20, -60],
             rotation=90);
    Interfaces.OutPort outPort(final n=n) annotation( extent=[80, -10; 100, 10]);
    annotation(
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal as <i>difference</i> of the
commanded input <b>u1</b>=inPort1.signal and the feedback
input <b>u2</b>=inPort2.signal:
</p>

<pre>    <b>y</b> = <b>u1</b> - <b>u2</b>;
</pre>

<p>
Example:
</p>

<pre>     parameter:   n = 2

  results in the following equations:

     y[1] = u1[1] - u2[1]
     y[2] = u1[2] - u2[2]
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"),   Icon(
        Ellipse(extent=[-20, 20; 20, -20], style(
            pattern=1,
            thickness=1,
            fillColor=30,
            fillPattern=1)),
        Line(points=[-60, 0; -20, 0]),
        Line(points=[20, 0; 80, 0]),
        Line(points=[0, -20; 0, -60]),
        Text(
          extent=[-12, 10; 84, -84],
          string="-",
          style(color=0)),
        Text(extent=[-100, 110; 100, 60], string="%name")),
      Diagram(
        Ellipse(extent=[-20, 20; 20, -20], style(
            pattern=1,
            thickness=1,
            fillColor=30,
            fillPattern=1)),
        Line(points=[-60, 0; -20, 0]),
        Line(points=[20, 0; 80, 0]),
        Line(points=[0, -20; 0, -60]),
        Text(
          extent=[-12, 10; 84, -84],
          string="-",
          style(color=0))));
  equation 
    outPort.signal = inPort1.signal - inPort2.signal;
  end Feedback;
  
  block Add "Output the sum of the two inputs" 
    extends Interfaces.MI2MO;
    parameter Real k1=+1 "Gain of upper input";
    parameter Real k2=+1 "Gain of lower input";
    annotation(
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal as <i>sum</i> of the
two input signals <b>u1</b>=inPort1.signal and <b>u2</b>=inPort2.signal:
</p>

<pre>    <b>y</b> = k1*<b>u1</b> + k2*<b>u2</b>;
</pre>

<p>
Example:
</p>

<pre>     parameter:   n = 2, k1= +2, k2= -3

  results in the following equations:

     y[1] = 2 * u1[1] - 3 * u2[1]
     y[2] = 2 * u1[2] - 3 * u2[2]
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"),   Icon(
        Text(
          extent=[-98, -52; 7, -92],
          string="%k2",
          style(color=0)),
        Text(
          extent=[-100, 90; 5, 50],
          string="%k1",
          style(color=0)),
        Text(extent=[-150, 150; 150, 110], string="%name"),
        Line(points=[-100, 60; -40, 60; -30, 40]),
        Ellipse(extent=[-50, 50; 50, -50]),
        Line(points=[-100, -60; -40, -60; -30, -40]),
        Line(points=[-15, -25.99; 15, 25.99], style(color=0)),
        Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
        Line(points=[50, 0; 100, 0]),
        Line(points=[-100, 60; -74, 24; -44, 24]),
        Line(points=[-100, -60; -74, -28; -42, -28]),
        Ellipse(extent=[-50, 50; 50, -50]),
        Line(points=[50, 0; 100, 0]),
        Text(
          extent=[-38, 34; 38, -34],
          string="+",
          style(color=0)),
        Text(
          extent=[-100, 52; 5, 92],
          string="%k1",
          style(color=0)),
        Text(
          extent=[-100, -52; 5, -92],
          string="%k2",
          style(color=0))),
      Diagram(
        Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
        Text(
          extent=[-98, -52; 7, -92],
          string="%k2",
          style(color=0)),
        Text(
          extent=[-100, 90; 5, 50],
          string="%k1",
          style(color=0)),
        Line(points=[-100, 60; -40, 60; -30, 40]),
        Ellipse(extent=[-50, 50; 50, -50]),
        Line(points=[-100, -60; -40, -60; -30, -40]),
        Line(points=[-15, -25.99; 15, 25.99], style(color=0)),
        Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
        Line(points=[50, 0; 100, 0]),
        Line(points=[-100, 60; -74, 24; -44, 24]),
        Line(points=[-100, -60; -74, -28; -42, -28]),
        Ellipse(extent=[-50, 50; 50, -50]),
        Line(points=[50, 0; 100, 0]),
        Text(
          extent=[-38, 34; 38, -34],
          string="+",
          style(color=0)),
        Text(
          extent=[-100, 52; 5, 92],
          string="k1",
          style(color=0)),
        Text(
          extent=[-100, -52; 5, -92],
          string="k2",
          style(color=0))));
  equation 
    y = k1*u1 + k2*u2;
  end Add;
  
  block Add3 "Output the sum of the three inputs" 
    extends Interfaces.BlockIcon;
    
    parameter Real k1=+1 "Gain of upper input";
    parameter Real k2=+1 "Gain of middle input";
    parameter Real k3=+1 "Gain of lower input";
    parameter Integer n=1 "Dimension of input and output vectors.";
    Interfaces.InPort inPort1(final n=n) "Connector 1 of Real input signals" 
      annotation( extent=[-140, 60; -100, 100]);
    Interfaces.InPort inPort2(final n=n) "Connector 2 of Real input signals" 
      annotation( extent=[-140, -20; -100, 20]);
    Interfaces.InPort inPort3(final n=n) "Connector 3 of Real input signals" 
      annotation( extent=[-140, -100; -100, -60]);
    Interfaces.OutPort outPort(final n=n) "Connector of Real output signals" 
      annotation( extent=[100, -10; 120, 10]);
    annotation(
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal as <i>sum</i> of the
three input signals <b>u1</b>=inPort1.signal, <b>u2</b>=inPort2.signal
and <b>u3</b>=inPort3.signal:
</p>

<pre>    <b>y</b> = k1*<b>u1</b> + k2*<b>u2</b> + k3*<b>u3</b>;
</pre>

<p>
Example:
</p>

<pre>     parameter:   n = 2, k1= +2, k2= -3, k3=1;

  results in the following equations:

     y[1] = 2 * u1[1] - 3 * u2[1] + u3[1];
     y[2] = 2 * u1[2] - 3 * u2[2] + u3[2];
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"),   Icon(
        Text(
          extent=[-100, 50; 5, 90],
          string="%k1",
          style(color=0)),
        Text(
          extent=[-100, -20; 5, 20],
          string="%k2",
          style(color=0)),
        Text(
          extent=[-100, -50; 5, -90],
          string="%k3",
          style(color=0)),
        Text(
          extent=[2, 36; 100, -44],
          string="+",
          style(color=0))),
      Diagram(
        Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
        Text(
          extent=[-100, 50; 5, 90],
          string="%k1",
          style(color=0)),
        Text(
          extent=[-100, -20; 5, 20],
          string="%k2",
          style(color=0)),
        Text(
          extent=[-100, -50; 5, -90],
          string="%k3",
          style(color=0)),
        Text(
          extent=[2, 36; 100, -44],
          string="+",
          style(color=0)),
        Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
        Text(
          extent=[-100, 50; 5, 90],
          string="k1",
          style(color=0)),
        Text(
          extent=[-100, -20; 5, 20],
          string="k2",
          style(color=0)),
        Text(
          extent=[-100, -50; 5, -90],
          string="k3",
          style(color=0)),
        Text(
          extent=[2, 36; 100, -44],
          string="+",
          style(color=0))));
  equation 
    outPort.signal = k1*inPort1.signal + k2*inPort2.signal + k3*inPort3.signal;
  end Add3;
  
  block Product "Output product of the two inputs" 
    extends Interfaces.MI2MO;
    annotation(
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <i>product</i> of the corresponding elements of
the two inputs <b>u1</b>=inPort1.signal and <b>u2</b>=inPort2.signal:
</p>

<pre>    y[i] = u1[i] * u2[i];
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"),   Icon(
        Line(points=[-100, 60; -40, 60; -30, 40]),
        Line(points=[-100, -60; -40, -60; -30, -40]),
        Line(points=[50, 0; 100, 0]),
        Line(points=[-30, 0; 30, 0], style(color=0)),
        Line(points=[-15, 25.99; 15, -25.99], style(color=0)),
        Line(points=[-15, -25.99; 15, 25.99], style(color=0)),
        Ellipse(extent=[-50, 50; 50, -50])),
      Diagram(
        Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
        Line(points=[-100, 60; -40, 60; -30, 40]),
        Line(points=[-100, -60; -40, -60; -30, -40]),
        Line(points=[50, 0; 100, 0]),
        Line(points=[-30, 0; 30, 0], style(color=0)),
        Line(points=[-15, 25.99; 15, -25.99], style(color=0)),
        Line(points=[-15, -25.99; 15, 25.99], style(color=0)),
        Ellipse(extent=[-50, 50; 50, -50])));
  equation 
    for i in 1:n loop
      y[i] = u1[i]*u2[i];
    end for;
  end Product;
  
  block Division "Output first input divided by second input" 
    extends Interfaces.MI2MO;
    annotation(
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
by <i>dividing</i> the corresponding elements of
the two inputs <b>u1</b>=inPort1.signal and <b>u2</b>=inPort2.signal:
</p>

<pre>    y[i] = u1[i] / u2[i];
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"),   Icon(
        Line(points=[50, 0; 100, 0]),
        Line(points=[-30, 0; 30, 0], style(color=0)),
        Ellipse(extent=[-5, 20; 5, 30], style(color=0, fillColor=0)),
        Ellipse(extent=[-5, -20; 5, -30], style(color=0, fillColor=0)),
        Ellipse(extent=[-50, 50; 50, -50]),
        Text(extent=[-150, 150; 150, 110], string="%name"),
        Line(points=[-100, 60; -66, 60; -40, 30]),
        Line(points=[-100, -60; 0, -60; 0, -50])),
      Diagram(
        Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
        Line(points=[50, 0; 100, 0]),
        Line(points=[-30, 0; 30, 0], style(color=0)),
        Ellipse(extent=[-5, 20; 5, 30], style(color=0, fillColor=0)),
        Ellipse(extent=[-5, -20; 5, -30], style(color=0, fillColor=0)),
        Ellipse(extent=[-50, 50; 50, -50]),
        Line(points=[-100, 60; -66, 60; -40, 30]),
        Line(points=[-100, -60; 0, -60; 0, -50])));
  equation 
    for i in 1:n loop
      y[i] = u1[i]/u2[i];
    end for;
  end Division;
  
  block Abs "Output the absolute value of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Polygon(points=[92, 0; 70, 8; 70, -8; 92, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, 80; 0, 0; 80, 80], style(color=0)),
        Line(points=[0, -14; 0, 68], style(color=8)),
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Text(
          extent=[-34, -28; 38, -76],
          string="abs",
          style(color=8)),
        Line(points=[-88, 0; 76, 0], style(color=8))),
      Diagram(
        Line(points=[-100, 0; 76, 0], style(color=8)),
        Polygon(points=[92, 0; 76, 6; 76, -6; 92, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, 80; 0, 0; 80, 80], style(color=0)),
        Line(points=[0, -80; 0, 68], style(color=8)),
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Line(points=[0, -80; 0, 68], style(color=8)),
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Text(
          extent=[7, 98; 34, 78],
          string="outPort",
          style(color=9)),
        Text(
          extent=[74, -8; 96, -28],
          string="inPort",
          style(color=9)),
        Text(extent=[52, -3; 72, -23], string="1"),
        Text(extent=[-86, -1; -66, -21], string="-1"),
        Text(extent=[-28, 79; -8, 59], string="1")),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <i>absolute value</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>abs</b>( u[i] );
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = abs(u);
  end Abs;
  
  block Sign "Output the sign of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, -80; 0, -80], style(color=0)),
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Line(points=[0, -80; 0, 68], style(color=8)),
        Text(
          extent=[-90, 72; -18, 24],
          string="sign",
          style(color=8)),
        Line(points=[0, 80; 80, 80], style(color=0)),
        Rectangle(extent=[-2, 2; 2, -4], style(
            color=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, -80; 0, -80], style(color=0)),
        Line(points=[-0.01, 0; 0.01, 0], style(color=0)),
        Line(points=[0, 80; 80, 80], style(color=0)),
        Rectangle(extent=[-2, 2; 2, -4], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
              fillColor=8)),
        Line(points=[0, -90; 0, 84], style(color=8)),
        Text(
          extent=[7, 102; 32, 82],
          string="outPort",
          style(color=9)),
        Text(
          extent=[70, -6; 94, -26],
          string="inPort",
          style(color=9)),
        Text(extent=[-25, 86; -5, 70], string="1"),
        Text(extent=[5, -72; 25, -88], string="-1")),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <b>sign</b> of the input <b>u</b>=inPort.signal:
</p>

<pre>            1  <b>if</b> u[i] > 0
    y[i] =  0  <b>if</b> u[i] == 0
           -1  <b>if</b> u[i] < 0
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = sign(u);
  end Sign;
  
  block Sqrt "Output the square root of the input (input >= 0 required)" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Line(points=[-90, -80; 68, -80], style(color=8)),
        Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -79.2, -68.7; -78.4, -64; -76.8, -57.3; -73.6, -
              47.9; -67.9, -36.1; -59.1, -22.2; -46.2, -6.49; -28.5, 10.7; -
              4.42, 30; 27.7, 51.3; 69.5, 74.7; 80, 80], style(color=0)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, -88; -80, 68], style(color=8)),
        Text(
          extent=[-8, -4; 64, -52],
          string="sqrt",
          style(color=8))),
      Diagram(
        Line(points=[-92, -80; 84, -80], style(color=8)),
        Polygon(points=[100, -80; 84, -74; 84, -86; 100, -80], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -79.2, -68.7; -78.4, -64; -76.8, -57.3; -73.6, -
              47.9; -67.9, -36.1; -59.1, -22.2; -46.2, -6.49; -28.5, 10.7; -
              4.42, 30; 27.7, 51.3; 69.5, 74.7; 80, 80], style(color=0)),
        Polygon(points=[-80, 98; -86, 82; -74, 82; -80, 98], style(color=8,
              fillColor=8)),
        Line(points=[-80, -90; -80, 84], style(color=8)),
        Text(
          extent=[-71, 98; -44, 78],
          string="outPort",
          style(color=9)),
        Text(
          extent=[60, -52; 84, -72],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <i>square root</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = sqrt( u[i] );
</pre>

<p>
All elements of the input vector shall be zero or positive.
Otherwise an error occurs.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = sqrt(u);
  end Sqrt;
  
  block Sin "Output the sine of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -80, 68], style(color=8)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4, 74.6;
                -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3, 59.4;
                -14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2; 23.7, -64.2;
                29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6; 51.9, -71.5;
              57.5, -61.9; 63.9, -47.2; 72, -24.8; 80, 0], style(color=0)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Text(
          extent=[12, 84; 84, 36],
          string="sin",
          style(color=8))),
      Diagram(
        Line(points=[-80, 80; -88, 80], style(color=8)),
        Line(points=[-80, -80; -88, -80], style(color=8)),
        Line(points=[-80, -90; -80, 84], style(color=8)),
        Text(
          extent=[-75, 98; -46, 78],
          string="outPort",
          style(color=9)),
        Polygon(points=[-80, 96; -86, 80; -74, 80; -80, 96], style(color=8,
              fillColor=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4, 74.6;
                -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3, 59.4;
                -14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2; 23.7, -64.2;
                29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6; 51.9, -71.5;
              57.5, -61.9; 63.9, -47.2; 72, -24.8; 80, 0], style(color=0)),
        Text(extent=[-105, 72; -85, 88], string="1"),
        Text(extent=[70, 25; 90, 5], string="2*pi"),
        Text(extent=[-105, -72; -85, -88], string="-1"),
        Text(
          extent=[76, -10; 98, -30],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <b>sine</b> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>sin</b>( u[i] );
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = Modelica.Math.sin(u);
  end Sin;
  
  block Cos "Output the cosine of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -80, 68], style(color=8)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, 80; -74.4, 78.1; -68.7, 72.3; -63.1, 63; -56.7, 48.7;
                -48.6, 26.6; -29.3, -32.5; -22.1, -51.7; -15.7, -65.3; -10.1, -
              73.8; -4.42, -78.8; 1.21, -79.9; 6.83, -77.1; 12.5, -70.6; 18.1,
              -60.6; 24.5, -45.7; 32.6, -23; 50.3, 31.3; 57.5, 50.7; 63.9, 64.6;
                69.5, 73.4; 75.2, 78.6; 80, 80], style(color=0)),
        Text(
          extent=[-36, 82; 36, 34],
          string="cos",
          style(color=8))),
      Diagram(
        Line(points=[-80, 80; -88, 80], style(color=8)),
        Line(points=[-80, -80; -88, -80], style(color=8)),
        Line(points=[-80, -90; -80, 84], style(color=8)),
        Text(
          extent=[-75, 102; -48, 82],
          string="outPort",
          style(color=9)),
        Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=8,
              fillColor=8)),
        Text(extent=[-103, 72; -83, 88], string="1"),
        Text(extent=[-79, -72; -59, -88], string="-1"),
        Text(extent=[70, 25; 90, 5], string="2*pi"),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-80, 80; -74.4, 78.1; -68.7, 72.3; -63.1, 63; -56.7, 48.7;
                -48.6, 26.6; -29.3, -32.5; -22.1, -51.7; -15.7, -65.3; -10.1, -
              73.8; -4.42, -78.8; 1.21, -79.9; 6.83, -77.1; 12.5, -70.6; 18.1,
              -60.6; 24.5, -45.7; 32.6, -23; 50.3, 31.3; 57.5, 50.7; 63.9, 64.6;
                69.5, 73.4; 75.2, 78.6; 80, 80], style(color=0)),
        Text(
          extent=[74, -4; 98, -24],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <b>cos</b> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>cos</b>( u[i] );
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = Modelica.Math.cos(u);
  end Cos;
  
  block Tan "Output the tangent of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Line(points=[0, -80; 0, 68], style(color=8)),
        Line(points=[-80, -80; -78.4, -68.4; -76.8, -59.7; -74.4, -50; -71.2, -
              40.9; -67.1, -33; -60.7, -24.8; -51.1, -17.2; -35.8, -9.98; -4.42,
                -1.07; 33.4, 9.12; 49.4, 16.2; 59.1, 23.2; 65.5, 30.6; 70.4,
              39.1; 73.6, 47.4; 76, 56.1; 77.6, 63.8; 80, 80], style(color=0)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Text(
          extent=[-90, 72; -18, 24],
          string="tan",
          style(color=8))),
      Diagram(
        Line(points=[0, 80; -8, 80], style(color=8)),
        Line(points=[0, -80; -8, -80], style(color=8)),
        Line(points=[0, -88; 0, 86], style(color=8)),
        Text(
          extent=[11, 100; 38, 80],
          string="outPort",
          style(color=9)),
        Polygon(points=[0, 102; -6, 86; 6, 86; 0, 102], style(color=8,
              fillColor=8)),
        Text(extent=[-37, -72; -17, -88], string="-5.8"),
        Text(extent=[-33, 86; -13, 70], string=" 5.8"),
        Text(extent=[70, 25; 90, 5], string="1.4"),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -78.4, -68.4; -76.8, -59.7; -74.4, -50; -71.2, -
              40.9; -67.1, -33; -60.7, -24.8; -51.1, -17.2; -35.8, -9.98; -4.42,
                -1.07; 33.4, 9.12; 49.4, 16.2; 59.1, 23.2; 65.5, 30.6; 70.4,
              39.1; 73.6, 47.4; 76, 56.1; 77.6, 63.8; 80, 80], style(color=0)),
        Text(
          extent=[70, -6; 94, -26],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <b>tan</b> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>tan</b>( u[i] );
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>
</HTML>
"));
  equation 
    y = Modelica.Math.tan(u);
  end Tan;
  
  block Asin "Output the arc sine of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Line(points=[0, -80; 0, 68], style(color=8)),
        Line(points=[-80, -80; -79.2, -72.8; -77.6, -67.5; -73.6, -59.4; -66.3,
                -49.8; -53.5, -37.3; -30.2, -19.7; 37.4, 24.8; 57.5, 40.8; 68.7,
                52.7; 75.2, 62.2; 77.6, 67.5; 80, 80], style(color=0)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Text(
          extent=[-88, 78; -16, 30],
          string="asin",
          style(color=8))),
      Diagram(
        Line(points=[0, 80; -8, 80], style(color=8)),
        Line(points=[0, -80; -8, -80], style(color=8)),
        Line(points=[0, -90; 0, 84], style(color=8)),
        Text(
          extent=[9, 102; 36, 82],
          string="outPort",
          style(color=9)),
        Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
              fillColor=8)),
        Text(extent=[-40, -72; -15, -88], string="-pi/2"),
        Text(extent=[-38, 88; -13, 72], string=" pi/2"),
        Text(extent=[70, 25; 90, 5], string="+1"),
        Text(extent=[-90, 21; -70, 1], string="-1"),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -79.2, -72.8; -77.6, -67.5; -73.6, -59.4; -66.3,
                -49.8; -53.5, -37.3; -30.2, -19.7; 37.4, 24.8; 57.5, 40.8; 68.7,
                52.7; 75.2, 62.2; 77.6, 67.5; 80, 80], style(color=0)),
        Text(
          extent=[74, -4; 100, -26],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise as the
<i>sine-inverse</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>asin</b>( u[i] );
</pre>

<p>
The absolute values of the elements of the input <b>u</b> need to
be less or equal to one (<b>abs</b>( u[i] ) <= 1).
Otherwise an error occurs.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>
</HTML>
"));
  equation 
    y = Modelica.Math.asin(u);
  end Asin;
  
  block Acos "Output the arc cosine of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Line(points=[-80, 80; -79.2, 72.8; -77.6, 67.5; -73.6, 59.4; -66.3,
              49.8; -53.5, 37.3; -30.2, 19.7; 37.4, -24.8; 57.5, -40.8; 68.7, -
              52.7; 75.2, -62.2; 77.6, -67.5; 80, -80], style(color=0)),
        Line(points=[0, -88; 0, 68], style(color=8)),
        Line(points=[-90, -80; 68, -80], style(color=8)),
        Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(color=8,
              fillColor=8)),
        Text(
          extent=[-86, -14; -14, -62],
          string="acos",
          style(color=8))),
      Diagram(
        Line(points=[0, 80; -8, 80], style(color=8)),
        Line(points=[0, -80; -8, -80], style(color=8)),
        Line(points=[0, -90; 0, 84], style(color=8)),
        Text(
          extent=[13, 100; 42, 82],
          string="outPort",
          style(color=9)),
        Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
              fillColor=8)),
        Line(points=[-100, -80; 84, -80], style(color=8)),
        Polygon(points=[100, -80; 84, -74; 84, -86; 100, -80], style(color=8,
              fillColor=8)),
        Line(points=[-80, 80; -79.2, 72.8; -77.6, 67.5; -73.6, 59.4; -66.3,
              49.8; -53.5, 37.3; -30.2, 19.7; 37.4, -24.8; 57.5, -40.8; 68.7, -
              52.7; 75.2, -62.2; 77.6, -67.5; 80, -80], style(color=0)),
        Text(extent=[-30, 88; -5, 72], string=" pi"),
        Text(extent=[-94, -57; -74, -77], string="-1"),
        Text(extent=[80, -45; 100, -65], string="+1"),
        Text(
          extent=[76, -84; 102, -102],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>

<p>
This block computes the output <b>y</b>=outPort.signal element-wise as the
<i>cosine-inverse</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>acos</b>( u[i] );
</pre>

<p>
The absolute values of the elements of the input <b>u</b> need to
be less or equal to one (<b>abs</b>( u[i] ) <= 1).
Otherwise an error occurs.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>
</HTML>
"));
  equation 
    y = Modelica.Math.acos(u);
  end Acos;
  
  block Atan "Output the arc tangent of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Line(points=[0, -80; 0, 68], style(color=8)),
        Line(points=[-80, -80; -52.7, -75.2; -37.4, -69.7; -26.9, -63; -19.7, -
              55.2; -14.1, -45.8; -10.1, -36.4; -6.03, -23.9; -1.21, -5.06;
              5.23, 21; 9.25, 34.1; 13.3, 44.2; 18.1, 52.9; 24.5, 60.8; 33.4,
              67.6; 47, 73.6; 69.5, 78.6; 80, 80], style(color=0)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Text(
          extent=[-86, 68; -14, 20],
          string="atan",
          style(color=8))),
      Diagram(
        Line(points=[0, 80; -8, 80], style(color=8)),
        Line(points=[0, -80; -8, -80], style(color=8)),
        Line(points=[0, -90; 0, 84], style(color=8)),
        Text(
          extent=[13, 102; 42, 82],
          string="outPort",
          style(color=9)),
        Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
              fillColor=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -52.7, -75.2; -37.4, -69.7; -26.9, -63; -19.7, -
              55.2; -14.1, -45.8; -10.1, -36.4; -6.03, -23.9; -1.21, -5.06;
              5.23, 21; 9.25, 34.1; 13.3, 44.2; 18.1, 52.9; 24.5, 60.8; 33.4,
              67.6; 47, 73.6; 69.5, 78.6; 80, 80], style(color=0)),
        Text(extent=[-32, 91; -12, 71], string="1.4"),
        Text(extent=[-32, -71; -12, -91], string="-1.4"),
        Text(extent=[73, 26; 93, 10], string=" 5.8"),
        Text(extent=[-103, 20; -83, 4], string="-5.8"),
        Text(
          extent=[66, -8; 94, -28],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise as the
<i>tangent-inverse</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>atan</b>( u[i] );
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>
</HTML>
"));
  equation 
    y = Modelica.Math.atan(u);
  end Atan;
  
  block Atan2 "Output atan(u1/u2) of the inputs u1 and u2" 
    extends Interfaces.MI2MO;
    annotation(
      Icon(
        Text(extent=[-150, 150; 150, 110], string="%name"),
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Line(points=[0, -80; 0, 68], style(color=8)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, -34.9; -46.1, -31.4; -29.4, -27.1; -18.3, -21.5; -
              10.3, -14.5; -2.03, -3.17; 7.97, 11.6; 15.5, 19.4; 24.3, 25; 39,
              30; 62.1, 33.5; 80, 34.9], style(color=0)),
        Line(points=[-80, 45.1; -45.9, 48.7; -29.1, 52.9; -18.1, 58.6; -10.2,
              65.8; -1.82, 77.2; 0, 80], style(color=0)),
        Line(points=[0, -80; 8.93, -67.2; 17.1, -59.3; 27.3, -53.6; 42.1, -49.4;
                69.9, -45.8; 80, -45.1], style(color=0)),
        Text(
          extent=[-90, -46; -18, -94],
          string="atan2",
          style(color=8))),
      Diagram(
        Line(points=[0, 80; -8, 80], style(color=8)),
        Line(points=[0, -80; -8, -80], style(color=8)),
        Line(points=[0, -90; 0, 84], style(color=8)),
        Text(
          extent=[11, 98; 42, 78],
          string="outPort",
          style(color=9)),
        Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
              fillColor=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[0, -80; 8.93, -67.2; 17.1, -59.3; 27.3, -53.6; 42.1, -49.4;
                69.9, -45.8; 80, -45.1], style(color=0)),
        Line(points=[-80, -34.9; -46.1, -31.4; -29.4, -27.1; -18.3, -21.5; -
              10.3, -14.5; -2.03, -3.17; 7.97, 11.6; 15.5, 19.4; 24.3, 25; 39,
              30; 62.1, 33.5; 80, 34.9], style(color=0)),
        Line(points=[-80, 45.1; -45.9, 48.7; -29.1, 52.9; -18.1, 58.6; -10.2,
              65.8; -1.82, 77.2; 0, 80], style(color=0)),
        Text(extent=[-30, 89; -10, 70], string="pi"),
        Text(extent=[-30, -69; -10, -88], string="-pi"),
        Text(extent=[-30, 49; -10, 30], string="pi/2"),
        Line(points=[0, 40; -8, 40], style(color=8)),
        Line(points=[0, -40; -8, -40], style(color=8)),
        Text(extent=[-30, -31; -10, -50], string="-pi/2"),
        Text(
          extent=[48, 0; 100, -34],
          string="inPort1 / inPort2",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise as the
<i>tangent-inverse</i> of the input <b>u1</b>=inPort1.signal divided by
input <b>u2</b>=inPort2.signal:
</p>

<pre>    y[i] = <b>atan2</b>( u1[i], u2[i] );
</pre>

<p>
u1[i] and u2[i] shall not be zero at the same time instant.
<b>Atan2</b> uses the sign of u1[i] and u2[i] in order to construct
the solution in the range -180 deg <= y[i] <= 180 deg, whereas
block <b>Atan</b> gives a solution in the range
-90 deg <= y[i] <= 90 deg.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = Modelica.Math.atan2(u1, u2);
  end Atan2;
  
  block Sinh "Output the hyperbolic sine of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Text(
          extent=[-86, 80; -14, 32],
          string="sinh",
          style(color=8)),
        Line(points=[0, -80; 0, 68], style(color=8)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Line(points=[-80, -80; -76, -65.4; -71.2, -51.4; -65.5, -38.8; -59.1, -
              28.1; -51.1, -18.7; -41.4, -11.4; -27.7, -5.5; -4.42, -0.653;
              24.5, 4.57; 39, 10.1; 49.4, 17.2; 57.5, 25.9; 63.9, 35.8; 69.5,
              47.4; 74.4, 60.4; 78.4, 73.8; 80, 80], style(color=0)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8))),
      Diagram(
        Line(points=[0, 80; -8, 80], style(color=8)),
        Line(points=[0, -80; -8, -80], style(color=8)),
        Line(points=[0, -90; 0, 84], style(color=8)),
        Text(
          extent=[9, 98; 34, 78],
          string="outPort",
          style(color=9)),
        Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
              fillColor=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -76, -65.4; -71.2, -51.4; -65.5, -38.8; -59.1, -
              28.1; -51.1, -18.7; -41.4, -11.4; -27.7, -5.5; -4.42, -0.653;
              24.5, 4.57; 39, 10.1; 49.4, 17.2; 57.5, 25.9; 63.9, 35.8; 69.5,
              47.4; 74.4, 60.4; 78.4, 73.8; 80, 80], style(color=0)),
        Text(extent=[-31, 72; -11, 88], string="27"),
        Text(extent=[-35, -88; -15, -72], string="-27"),
        Text(extent=[70, 25; 90, 5], string="4"),
        Text(extent=[-98, 21; -78, 1], string="-4"),
        Text(
          extent=[72, -6; 96, -26],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise as the
<i>hyperbolic sine</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>sinh</b>( u[i] );
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = Modelica.Math.sinh(u);
  end Sinh;
  
  block Cosh "Output the hyperbolic cosine of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Line(points=[0, -80; 0, 68], style(color=8)),
        Text(
          extent=[4, 66; 66, 20],
          string="cosh",
          style(color=8)),
        Line(points=[-80, 80; -77.6, 61.1; -74.4, 39.3; -71.2, 20.7; -67.1,
              1.29; -63.1, -14.6; -58.3, -29.8; -52.7, -43.5; -46.2, -55.1; -39,
                -64.3; -30.2, -71.7; -18.9, -77.1; -4.42, -79.9; 10.9, -79.1;
              23.7, -75.2; 34.2, -68.7; 42.2, -60.6; 48.6, -51.2; 54.3, -40;
              59.1, -27.5; 63.1, -14.6; 67.1, 1.29; 71.2, 20.7; 74.4, 39.3;
              77.6, 61.1; 80, 80], style(color=0)),
        Line(points=[-90, -86.083; 68, -86.083], style(color=8)),
        Polygon(points=[90, -86.083; 68, -78.083; 68, -94.083; 90, -86.083],
            style(color=8, fillColor=8))),
      Diagram(
        Line(points=[0, 80; -8, 80], style(color=8)),
        Line(points=[0, -80; -8, -80], style(color=8)),
        Line(points=[0, -90; 0, 84], style(color=8)),
        Text(
          extent=[11, 98; 38, 78],
          string="outPort",
          style(color=9)),
        Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
              fillColor=8)),
        Line(points=[-100, -86.083; 84, -86.083], style(color=8)),
        Polygon(points=[100, -86.083; 84, -80.083; 84, -92.083; 100, -86.083],
            style(color=8, fillColor=8)),
        Line(points=[-80, 80; -77.6, 61.1; -74.4, 39.3; -71.2, 20.7; -67.1,
              1.29; -63.1, -14.6; -58.3, -29.8; -52.7, -43.5; -46.2, -55.1; -39,
                -64.3; -30.2, -71.7; -18.9, -77.1; -4.42, -79.9; 10.9, -79.1;
              23.7, -75.2; 34.2, -68.7; 42.2, -60.6; 48.6, -51.2; 54.3, -40;
              59.1, -27.5; 63.1, -14.6; 67.1, 1.29; 71.2, 20.7; 74.4, 39.3;
              77.6, 61.1; 80, 80], style(color=0)),
        Text(extent=[-31, 72; -11, 88], string="27"),
        Text(extent=[62, -67; 82, -87], string="4"),
        Text(extent=[-104, -63; -84, -83], string="-4"),
        Text(
          extent=[78, -54; 100, -74],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise as the
<i>hyperbolic cosine</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>cosh</b>( u[i] );
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = Modelica.Math.cosh(u);
  end Cosh;
  
  block Tanh "Output the hyperbolic tangent of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Line(points=[0, -90; 0, 84], style(color=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Line(points=[-80, -80; -47.8, -78.7; -35.8, -75.7; -27.7, -70.6; -22.1,
                -64.2; -17.3, -55.9; -12.5, -44.3; -7.64, -29.2; -1.21, -4.82;
              6.83, 26.3; 11.7, 42; 16.5, 54.2; 21.3, 63.1; 26.9, 69.9; 34.2,
              75; 45.4, 78.4; 72, 79.9; 80, 80], style(color=0)),
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Text(
          extent=[-88, 72; -16, 24],
          string="tanh",
          style(color=8)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8))),
      Diagram(
        Line(points=[0, 80; -8, 80], style(color=8)),
        Line(points=[0, -80; -8, -80], style(color=8)),
        Line(points=[0, -90; 0, 84], style(color=8)),
        Text(
          extent=[9, 98; 42, 80],
          string="outPort",
          style(color=9)),
        Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
              fillColor=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -47.8, -78.7; -35.8, -75.7; -27.7, -70.6; -22.1,
                -64.2; -17.3, -55.9; -12.5, -44.3; -7.64, -29.2; -1.21, -4.82;
              6.83, 26.3; 11.7, 42; 16.5, 54.2; 21.3, 63.1; 26.9, 69.9; 34.2,
              75; 45.4, 78.4; 72, 79.9; 80, 80], style(color=0)),
        Text(extent=[70, 25; 90, 5], string="4"),
        Text(extent=[-106, 21; -86, 1], string="-4"),
        Text(extent=[-29, 72; -9, 88], string="1"),
        Text(extent=[3, -72; 23, -88], string="-1"),
        Text(
          extent=[72, -8; 98, -26],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise as the
<i>hyperbolic tangent</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>tanh</b>( u[i] );
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>
</HTML>
"));
  equation 
    y = Modelica.Math.tanh(u);
  end Tanh;
  
  block Exp "Output the exponential (base e) of the input" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Line(points=[0, -80; 0, 68], style(color=8)),
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Text(
          extent=[-86, 50; -14, 2],
          string="exp",
          style(color=8)),
        Line(points=[-80, -80; -31, -77.9; -6.03, -74; 10.9, -68.4; 23.7, -61;
              34.2, -51.6; 43, -40.3; 50.3, -27.8; 56.7, -13.5; 62.3, 2.23;
              67.1, 18.6; 72, 38.2; 76, 57.6; 80, 80], style(color=0)),
        Line(points=[-90, -80.3976; 68, -80.3976], style(color=8)),
        Polygon(points=[90, -80.3976; 68, -72.3976; 68, -88.3976; 90, -80.3976],
              style(color=8, fillColor=8))),
      Diagram(
        Line(points=[0, 80; -8, 80], style(color=8)),
        Line(points=[0, -80; -8, -80], style(color=8)),
        Line(points=[0, -90; 0, 84], style(color=8)),
        Text(
          extent=[9, 100; 40, 80],
          string="outPort",
          style(color=9)),
        Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8,
              fillColor=8)),
        Line(points=[-100, -80.3976; 84, -80.3976], style(color=8)),
        Polygon(points=[100, -80.3976; 84, -74.3976; 84, -86.3976; 100, -
              80.3976], style(color=8, fillColor=8)),
        Line(points=[-80, -80; -31, -77.9; -6.03, -74; 10.9, -68.4; 23.7, -61;
              34.2, -51.6; 43, -40.3; 50.3, -27.8; 56.7, -13.5; 62.3, 2.23;
              67.1, 18.6; 72, 38.2; 76, 57.6; 80, 80], style(color=0)),
        Text(extent=[-31, 72; -11, 88], string="20"),
        Text(extent=[-92, -83; -72, -103], string="-3"),
        Text(extent=[70, -83; 90, -103], string="3"),
        Text(extent=[-18, -53; 2, -73], string="1"),
        Text(
          extent=[66, -52; 96, -72],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise as the
<i>exponential</i> (of base e) of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>exp</b>( u[i] );
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = Modelica.Math.exp(u);
  end Exp;
  
  block Log 
    "Output the natural (base e) logarithm of the input (input > 0 required)" 
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Line(points=[-80, -80; -80, 68], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8, -
              21.3; -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9; -57.5,
                28; -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7, 78.1; 80,
                80], style(color=0)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Text(
          extent=[-6, -24; 66, -72],
          string="log",
          style(color=8))),
      Diagram(
        Line(points=[-80, 80; -88, 80], style(color=8)),
        Line(points=[-80, -80; -88, -80], style(color=8)),
        Line(points=[-80, -90; -80, 84], style(color=8)),
        Text(
          extent=[-67, 98; -40, 80],
          string="outPort",
          style(color=9)),
        Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=8,
              fillColor=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8, -
              21.3; -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9; -57.5,
                28; -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7, 78.1; 80,
                80], style(color=0)),
        Text(extent=[-105, 72; -85, 88], string="3"),
        Text(extent=[-109, -88; -89, -72], string="-3"),
        Text(extent=[70, -3; 90, -23], string="20"),
        Text(extent=[-78, -1; -58, -21], string="1"),
        Text(
          extent=[68, 28; 94, 8],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise as the
<i>natural (base e) logarithm</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>log</b>( u[i] );
</pre>

<p>
An error occurs if the elements of the input <b>u</b> are
zero or negative.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = Modelica.Math.log(u);
  end Log;
  
  block Log10 "Output the base 10 logarithm of the input (input > 0 required)" 
    
    extends Interfaces.MIMOs;
    annotation(
      Icon(
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Line(points=[-79.8, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8, -
              21.3; -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9; -57.5,
                28; -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7, 78.1; 80,
                80], style(color=0)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -80, 68], style(color=8)),
        Text(
          extent=[-30, -22; 60, -70],
          string="log10",
          style(color=8))),
      Diagram(
        Line(points=[-80, 80; -88, 80], style(color=8)),
        Line(points=[-80, -80; -88, -80], style(color=8)),
        Line(points=[-80, -90; -80, 84], style(color=8)),
        Text(
          extent=[-65, 96; -38, 78],
          string="outPort",
          style(color=9)),
        Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=8,
              fillColor=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-79.8, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8, -
              21.3; -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9; -57.5,
                28; -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7, 78.1; 80,
                80], style(color=0)),
        Text(extent=[70, -3; 90, -23], string="20"),
        Text(extent=[-78, -1; -58, -21], string="1"),
        Text(extent=[-109, 72; -89, 88], string=" 1.3"),
        Text(extent=[-109, -88; -89, -72], string="-1.3"),
        Text(
          extent=[62, 30; 90, 10],
          string="inPort",
          style(color=9))),
      Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise as the
<i>base 10 logarithm</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>log10</b>( u[i] );
</pre>

<p>
An error occurs if the elements of the input <b>u</b> are
zero or negative.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
  equation 
    y = Modelica.Math.log10(u);
  end Log10;
  
  block RealToInteger "Convert real to integer signals" 
    extends Interfaces.IntegerBlockIcon;
    parameter Integer n=1 "Number of input and output signals";
  protected 
    Real u[n];
    annotation( Icon(
        Text(extent=[-100, 60; 0, -60], string="R"),
        Text(
          extent=[20, 60; 120, -60],
          string="I",
          style(color=45)),
        Polygon(points=[50, 0; 30, 20; 30, 10; 00, 10; 0, -10; 30, -10; 30, -20;
                50, 0], style(color=45, fillColor=45))), Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <i>nearest integer value</i> of the input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = <b>integer</b>( <b>floor</b>( u[i] + 0.5 ) )  for  u[i] &gt; 0;
    y[i] = <b>integer</b>( <b>ceil </b>( u[i] - 0.5 ) )  for  u[i] &lt; 0;
</pre>
</html>
"));
  public 
    Interfaces.InPort inPort(final n=n) annotation( extent=[-140, -20; -100, 20]);
    Interfaces.IntegerOutPort outPort(final n=n) annotation( extent=[100, -10;
          120, 10]);
  equation 
    u = inPort.signal;
    for i in 1:n loop
      outPort.signal[i] = if (u[i] > 0) then integer(floor(u[i] + 0.5)) else 
        integer(ceil(u[i] - 0.5));
    end for;
  end RealToInteger;
  
  block IntegerToReal "Convert integer to real signals" 
    extends Interfaces.BlockIcon;
    parameter Integer n=1 
      "Number of input signals (= number of output signals)";
    annotation( Icon(
        Text(
          extent=[-120, 60; -20, -60],
          string="I",
          style(color=45)),
        Text(extent=[0, 60; 100, -60], string="R"),
        Polygon(points=[10, 0; -10, 20; -10, 10; -40, 10; -40, -10; -10, -10; -
              10, -20; 10, 0], style(fillColor=73))), Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <i>Real equivalent</i> of the Integer input <b>u</b>=inPort.signal:
</p>

<pre>    y[i] = u[i];
</pre>

<p>where <b>u</b> is of Integer and <b>y</b> of Real type.</p>
</html>
"));
    Interfaces.OutPort outPort(final n=n) annotation( extent=[100, -10; 120, 10]);
    Interfaces.IntegerInPort inPort(final n=n) annotation( extent=[-140, -20; -
          100, 20]);
  equation 
    outPort.signal = inPort.signal;
  end IntegerToReal;
  
  block Max "Pass through the largest signal" 
    extends Interfaces.MI2MO;
    annotation( Icon(Text(
          extent=[-90, 36; 90, -36],
          style(color=9),
          string="max()")), Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <i>maximum</i> of the two inputs <b>u1</b>=inPort1.signal and <b>u2</b>=inPort2.signal:
</p>

<pre>    y[i] = <b>max</b> ( u1[i] , u2[i] );
</pre>
</html>
"));
  equation 
    for i in 1:n loop
      y[i] = max(u1[i], u2[i]);
    end for;
  end Max;
  
  block Min "Pass through the smallest signal" 
    extends Interfaces.MI2MO;
    annotation( Icon(Text(
          extent=[-90, 36; 90, -36],
          style(color=9),
          string="min()")), Documentation(info="<html>
<p>
This block computes the output <b>y</b>=outPort.signal element-wise
as <i>minimum</i> of the two inputs <b>u1</b>=inPort1.signal and <b>u2</b>=inPort2.signal:
</p>

<pre>    y[i] = <b>min</b> ( u1[i] , u2[i] );
</pre>
</html>
"));
  equation 
    for i in 1:n loop
      y[i] = min(u1[i], u2[i]);
    end for;
  end Min;
  
  block Edge "Indicates rising edge of boolean signal" 
    extends Interfaces.BooleanMIMOs;
    annotation( Icon(Text(
          extent=[-90, 36; 90, -36],
          style(color=9),
          string="edge()")), Documentation(info="<html>
<p>
This block sets the Boolean output <b>y</b>=outPort.signal element-wise
to true, when the Boolean input <b>u</b>=inPort.signal shows a <i>rising edge</i>:
</p>

<pre>    y[i] = <b>edge</b>( u[i] );
</pre>
</html>
"));
  equation 
    for i in 1:n loop
      y[i] = edge(u[i]);
    end for;
    annotation( Icon);
  end Edge;
  
  block BooleanChange "Indicates boolean signal changing" 
    extends Interfaces.BooleanMIMOs;
    annotation( Icon(Text(
          extent=[-90, 36; 90, -36],
          style(color=9),
          string="change()")), Documentation(info="<html>
<p>
This block sets the Boolean output <b>y</b>=outPort.signal element-wise
to true, when the Boolean input <b>u</b>=inPort.signal shows a <i>rising
or falling edge</i>, i.e., when the signal changes:
</p>

<pre>    y[i] = <b>change</b>( u[i] );
</pre>
</html>
"));
  equation 
    for i in 1:n loop
      y[i] = change(u[i]);
    end for;
  end BooleanChange;
  
  block IntegerChange "Indicates integer signal changing" 
    extends Interfaces.IntegerMIBooleanMOs;
    annotation( Icon(Text(
          extent=[-90, 36; 90, -36],
          style(color=9),
          string="change()")), Documentation(info="<html>
<p>
This block sets the Boolean output <b>y</b>=outPort.signal element-wise
to true, when the Integer input <b>u</b>=inPort.signal changes:
</p>

<pre>    y[i] = <b>change</b>( u[i] );
</pre>
</html>
"));
  equation 
    for i in 1:n loop
      y[i] = change(u[i]);
    end for;
  end IntegerChange;
end Math;
