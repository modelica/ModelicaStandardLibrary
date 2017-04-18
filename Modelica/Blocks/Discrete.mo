within Modelica.Blocks;
package Discrete
  "Library of discrete input/output blocks with fixed sample period"

  extends Modelica.Icons.Package;

  block Sampler "Ideal sampling of continuous signals"
    extends Interfaces.DiscreteSISO;

  equation
    when {sampleTrigger, initial()} then
      y = u;
    end when;
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Ellipse(lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{25.0,-10.0},{45.0,10.0}}),
        Line(points={{-100.0,0.0},{-45.0,0.0}},
          color={0,0,127}),
        Line(points={{45.0,0.0},{100.0,0.0}},
          color={0,0,127}),
        Line(points={{-35.0,0.0},{30.0,35.0}},
          color={0,0,127}),
        Ellipse(lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-45.0,-10.0},{-25.0,10.0}})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Ellipse(
            extent={{-25,-10},{-45,10}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{45,-10},{25,10}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,0},{-45,0}}, color={0,0,255}),
          Line(points={{45,0},{100,0}}, color={0,0,255}),
          Line(points={{-35,0},{30,35}}, color={0,0,255})}),
      Documentation(info="<html>
<p>
Samples the continues input signal with a sampling rate defined
via parameter <strong>samplePeriod</strong>.
</p>
</html>"));
  end Sampler;

  block ZeroOrderHold "Zero order hold of a sampled-data system"
    extends Interfaces.DiscreteSISO;
    output Real ySample(start=0, fixed=true);

  equation
    when {sampleTrigger, initial()} then
      ySample = u;
    end when;
    /* Define y=ySample with an infinitesimal delay to break potential
       algebraic loops if both the continuous and the discrete part have
       direct feedthrough
    */
    y = pre(ySample);
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Line(points={{-78.0,-42.0},{-52.0,-42.0},{-52.0,0.0},{-26.0,0.0},{-26.0,24.0},{-6.0,24.0},{-6.0,64.0},{18.0,64.0},{18.0,20.0},{38.0,20.0},{38.0,0.0},{44.0,0.0},{44.0,0.0},{62.0,0.0}},
          color={0,0,127})}),
      Documentation(info="<html>
<p>
The output is identical to the sampled input signal at sample
time instants and holds the output at the value of the last
sample instant during the sample points.
</p>
</html>"));
  end ZeroOrderHold;

  block FirstOrderHold "First order hold of a sampled-data system"
    extends Modelica.Blocks.Interfaces.DiscreteSISO;
  protected
    Modelica.SIunits.Time tSample;
    Real uSample;
    Real pre_uSample;
    Real c;
  initial equation
    pre(tSample) = time;
    pre(uSample) = u;
    pre(pre_uSample) = u;
    pre(c) = 0.0;
  equation
    when sampleTrigger then
      tSample = time;
      uSample = u;
      pre_uSample = pre(uSample);
      c = if firstTrigger then 0 else (uSample - pre_uSample)/samplePeriod;
    end when;
    /* Use pre_uSample and pre(c) to break potential algebraic loops by an
       infinitesimal delay if both the continuous and the discrete part
       have direct feedthrough.
    */
    y = pre_uSample + pre(c)*(time - tSample);
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Line(points={{-79.0,-41.0},{-59.0,-33.0},{-40.0,1.0},{-20.0,9.0},{0.0,63.0},{21.0,20.0},{41.0,10.0},{60.0,20.0}},
          color={0,0,127}),
        Line(points={{60.0,20.0},{81.0,10.0}},
          color={0,0,127})}),
      Documentation(info="<html>
<p>
The output signal is the extrapolation through the
values of the last two sampled input signals.
</p>
</html>"));
  end FirstOrderHold;

  block UnitDelay "Unit Delay Block"
    parameter Real y_start=0 "Initial value of output signal";
    extends Interfaces.DiscreteSISO;

  equation
    when sampleTrigger then
      y = pre(u);
    end when;

  initial equation
      y = y_start;
    annotation (
      Documentation(info="<html>
<p>
This block describes a unit delay:
</p>
<pre>
          1
     y = --- * u
          z
</pre>
<p>
that is, the output signal y is the input signal u of the
previous sample instant. Before the second sample instant,
the output y is identical to parameter yStart.
</p>

</html>"), Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Line(points={{-30.0,0.0},{30.0,0.0}},
        color={0,0,127}),
      Text(lineColor={0,0,127},
        extent={{-90.0,10.0},{90.0,90.0}},
        textString="1"),
      Text(lineColor={0,0,127},
        extent={{-90.0,-90.0},{90.0,-10.0}},
        textString="z")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Text(
            extent={{-160,10},{-140,-10}},
            textString="u",
            lineColor={0,0,255}),
          Text(
            extent={{115,10},{135,-10}},
            textString="y",
            lineColor={0,0,255}),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255}),
          Line(points={{40,0},{-40,0}}),
          Text(
            extent={{-55,55},{55,5}},
            textString="1"),
          Text(
            extent={{-55,-5},{55,-55}},
            textString="z")}));
  end UnitDelay;

  block TransferFunction "Discrete Transfer Function block"
    parameter Real b[:]={1} "Numerator coefficients of transfer function.";
    parameter Real a[:]={1} "Denominator coefficients of transfer function.";
    extends Interfaces.DiscreteSISO;
    output Real x[size(a, 1) - 1](each start=0, each fixed=true)
      "State of transfer function from controller canonical form";
  protected
    parameter Integer nb=size(b, 1) "Size of Numerator of transfer function";
    parameter Integer na=size(a, 1) "Size of Denominator of transfer function";
    Real x1(start=0,fixed=true);
    Real xext[size(a, 1)](each start=0, each fixed=true);

  equation
    when sampleTrigger then
      /* State variables x are defined according to
       controller canonical form. */
      x1 = (u - a[2:size(a, 1)]*pre(x))/a[1];
      xext = vector([x1; pre(x)]);
      x = xext[1:size(x, 1)];
      y = vector([zeros(na - nb, 1); b])*xext;
    end when;
    /* This is a non-sampled equation and above there are two separate
       when-clauses. This breaks feedback loops without direct terms,
       since in that case y will be independent of x1 (and only dependent
       on pre(x)).
    */
    /* Corresponding (simpler) version using when-semantics of Modelica 1.3:
   equation
     when sampleTrigger then
      [x; xn] = [x1; pre(x)];
      [u] = transpose([a])*[x1; pre(x)];
      [y] = transpose([zeros(na - nb, 1); b])*[x1; pre(x)];
     end when;
*/
    annotation (
      Documentation(info="<html>
<p>The <strong>discrete transfer function</strong> block defines the
transfer function between the input signal u and the output
signal y. The numerator has the order nb-1, the denominator
has the order na-1.</p>
<pre>
          b(1)*z^(nb-1) + b(2)*z^(nb-2) + ... + b(nb)
   y(z) = -------------------------------------------- * u(z)
          a(1)*z^(na-1) + a(2)*z^(na-2) + ... + a(na)
</pre>
<p>State variables <strong>x</strong> are defined according to
<strong>controller canonical</strong> form. Initial values of the
states can be set as start values of <strong>x</strong>.</p>
<p>Example:</p>
<pre>     Blocks.Discrete.TransferFunction g(b = {2,4}, a = {1,3});
</pre>
<p>results in the following transfer function:</p>
<pre>        2*z + 4
   y = --------- * u
         z + 3
</pre>

</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>November 15, 2000</em>
    by <a href=\"http://www.dynasim.se\">Hans Olsson</a>:<br>
    Converted to when-semantics of Modelica 1.4 with special
    care to avoid unnecessary algebraic loops.</li>
<li><em>June 18, 2000</em>
    by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
    Realized based on a corresponding model of Dieter Moormann
    and Hilding Elmqvist.</li>
</ul>
</html>"),
      Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Line(points={{82.0,0.0},{-84.0,0.0}},
        color={0,0,127}),
      Text(lineColor={0,0,127},
        extent={{-92.0,12.0},{86.0,92.0}},
        textString="b(z)"),
      Text(lineColor={0,0,127},
        extent={{-90.0,-90.0},{90.0,-12.0}},
        textString="a(z)")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(
            points={{40,0},{-44,0}},
            thickness=0.5),
          Text(
            extent={{-54,54},{54,4}},
            textString="b(z)"),
          Text(
            extent={{-54,-6},{56,-56}},
            textString="a(z)"),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255})}));
  end TransferFunction;

  block StateSpace "Discrete State Space block"
    parameter Real A[:, size(A, 1)]=[1, 0; 0, 1]
      "Matrix A of state space model";
    parameter Real B[size(A, 1), :]=[1; 1] "Matrix B of state space model";
    parameter Real C[:, size(A, 1)]=[1, 1] "Matrix C of state space model";
    parameter Real D[size(C, 1), size(B, 2)]=zeros(size(C, 1), size(B, 2))
      "Matrix D of state space model";

    extends Interfaces.DiscreteMIMO(final nin=size(B, 2), final nout=size(C, 1));
    output Real x[size(A, 1)] "State vector";

  equation
    when sampleTrigger then
      x = A*pre(x) + B*u;
      y = C*pre(x) + D*u;
    end when;
    annotation (
      Documentation(info="<html>
<p>
The <strong>discrete state space</strong> block defines the relation
between the input u and the output y in state space form:
</p>
<pre>
    x = A * pre(x) + B * u
    y = C * pre(x) + D * u
</pre>
<p>
where pre(x) is the value of the discrete state x at
the previous sample time instant.
The input is a vector of length nu, the output is a vector
of length ny and nx is the number of states. Accordingly
</p>
<pre>
        A has the dimension: A(nx,nx),
        B has the dimension: B(nx,nu),
        C has the dimension: C(ny,nx),
        D has the dimension: D(ny,nu)
</pre>
<p>
Example:
</p>
<pre>
     parameter: A = [0.12, 2;3, 1.5]
     parameter: B = [2, 7;3, 1]
     parameter: C = [0.1, 2]
     parameter: D = zeros(ny,nu)

results in the following equations:
  [x[1]]   [0.12  2.00] [pre(x[1])]   [2.0  7.0] [u[1]]
  [    ] = [          ]*[         ] + [        ]*[    ]
  [x[2]]   [3.00  1.50] [pre(x[2])]   [0.1  2.0] [u[2]]
                             [pre(x[1])]            [u[1]]
       y[1]   = [0.1  2.0] * [         ] + [0  0] * [    ]
                             [pre(x[2])]            [u[2]]
</pre>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-90,15},{-15,90}},
            textString="A",
            lineColor={0,0,127}),
          Text(
            extent={{15,15},{90,90}},
            textString="B",
            lineColor={0,0,127}),
          Text(
            extent={{-52,28},{54,-20}},
            textString="z",
            lineColor={0,0,127}),
          Text(
            extent={{-90,-15},{-15,-90}},
            textString="C",
            lineColor={0,0,127}),
          Text(
            extent={{15,-15},{90,-90}},
            textString="D",
            lineColor={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Text(
            extent={{-54,50},{52,-10}},
            textString="zx=Ax+Bu"),
          Text(
            extent={{-56,14},{54,-50}},
            textString="  y=Cx+Du"),
          Line(points={{-102,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255})}));
  end StateSpace;

  block TriggeredSampler "Triggered sampling of continuous signals"
    extends Modelica.Blocks.Icons.DiscreteBlock;
    parameter Real y_start=0 "initial value of output signal";

    Modelica.Blocks.Interfaces.RealInput u "Connector with a Real input signal"
                                                          annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y
      "Connector with a Real output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
          transformation(
          origin={0,-118},
          extent={{-20,-20},{20,20}},
          rotation=90)));
  equation
    when trigger then
      y = u;
    end when;
  initial equation
    y = y_start;
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Ellipse(lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{25.0,-10.0},{45.0,10.0}}),
        Line(points={{-100.0,0.0},{-45.0,0.0}},
          color={0,0,127}),
        Line(points={{45.0,0.0},{100.0,0.0}},
          color={0,0,127}),
        Line(points={{0.0,-100.0},{0.0,-26.0}},
          color={255,0,255}),
        Line(points={{-35.0,0.0},{28.0,-48.0}},
          color={0,0,127}),
        Ellipse(lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-45.0,-10.0},{-25.0,10.0}})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Ellipse(
            extent={{-25,-10},{-45,10}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{45,-10},{25,10}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,0},{-45,0}}, color={0,0,255}),
          Line(points={{45,0},{100,0}}, color={0,0,255}),
          Line(points={{-35,0},{28,-48}}, color={0,0,255}),
          Line(points={{0,-100},{0,-26}}, color={255,0,255})}),
      Documentation(info="<html>
<p>
Samples the continuous input signal whenever the trigger input
signal is rising (i.e., trigger changes from <strong>false</strong> to
<strong>true</strong>) and provides the sampled input signal as output.
Before the first sampling, the output signal is equal to
the initial value defined via parameter <strong>y0</strong>.
</p>
</html>"));
  end TriggeredSampler;

  block TriggeredMax
    "Compute maximum, absolute value of continuous signal at trigger instants"

    extends Modelica.Blocks.Icons.DiscreteBlock;
    Modelica.Blocks.Interfaces.RealInput u "Connector with a Real input signal"
                                           annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y
      "Connector with a Real output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
          transformation(
          origin={0,-118},
          extent={{-20,-20},{20,20}},
          rotation=90)));
  equation
    when trigger then
       y = max(pre(y), abs(u));
    end when;
  initial equation
    y = 0;
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Ellipse(lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{25.0,-10.0},{45.0,10.0}}),
        Line(points={{-100.0,0.0},{-45.0,0.0}},
          color={0,0,127}),
        Line(points={{45.0,0.0},{100.0,0.0}},
          color={0,0,127}),
        Line(points={{0.0,-100.0},{0.0,-26.0}},
          color={255,0,255}),
        Line(points={{-35.0,0.0},{28.0,-48.0}},
          color={0,0,127}),
        Text(extent={{-86.0,24.0},{82.0,82.0}},
          color={0,0,127},
          textString="max"),
        Ellipse(lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-45.0,-10.0},{-25.0,10.0}})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Ellipse(
            extent={{-25,-10},{-45,10}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{45,-10},{25,10}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,0},{-45,0}}, color={0,0,255}),
          Line(points={{45,0},{100,0}}, color={0,0,255}),
          Line(points={{-35,0},{28,-48}}, color={0,0,255}),
          Line(points={{0,-100},{0,-26}}, color={255,0,255})}),
      Documentation(info="<html>
<p>
Samples the continuous input signal whenever the trigger input
signal is rising (i.e., trigger changes from <strong>false</strong> to
<strong>true</strong>). The maximum, absolute value of the input signal
at the sampling point is provided as output signal.
</p>
</html>"));
  end TriggeredMax;
  annotation (Documentation(info="<html>
<p>
This package contains <strong>discrete control blocks</strong>
with <strong>fixed sample period</strong>.
Every component of this package is structured in the following way:
</p>
<ol>
<li> A component has <strong>continuous real</strong> input and output signals.</li>
<li> The <strong>input</strong> signals are <strong>sampled</strong> by the given sample period
     defined via parameter <strong>samplePeriod</strong>.
     The first sample instant is defined by parameter <strong>startTime</strong>.</li>
<li> The <strong>output</strong> signals are computed from the sampled input signals.</li>
</ol>
<p>
A <strong>sampled data system</strong> may consist of components of package <strong>Discrete</strong>
and of every other purely <strong>algebraic</strong> input/output block, such
as the components of packages <strong>Modelica.Blocks.Math</strong>,
<strong>Modelica.Blocks.Nonlinear</strong> or <strong>Modelica.Blocks.Sources</strong>.
</p>

</html>", revisions="<html>
<ul>
<li><em>October 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New components TriggeredSampler and TriggeredMax added.</li>
<li><em>June 18, 2000</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized based on a corresponding library of Dieter Moormann and
       Hilding Elmqvist.</li>
</ul>
</html>"), Icon(graphics={
        Line(points={{-88,0},{-45,0}}, color={95,95,95}),
        Ellipse(
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-45,-10},{-25,10}}),
        Line(points={{-35,0},{24,52}}, color={95,95,95}),
        Ellipse(
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{25,-10},{45,10}}),
        Line(points={{45,0},{82,0}}, color={95,95,95})}));
end Discrete;
