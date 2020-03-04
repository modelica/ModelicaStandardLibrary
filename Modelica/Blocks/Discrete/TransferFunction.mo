within Modelica.Blocks.Discrete;
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
<blockquote><pre>
       b(1)*z^(nb-1) + b(2)*z^(nb-2) + ... + b(nb)
y(z) = -------------------------------------------- * u(z)
       a(1)*z^(na-1) + a(2)*z^(na-2) + ... + a(na)
</pre></blockquote>
<p>State variables <strong>x</strong> are defined according to
<strong>controller canonical</strong> form. Initial values of the
states can be set as start values of <strong>x</strong>.</p>
<p>Example:</p>
<blockquote><pre>
Blocks.Discrete.TransferFunction g(b = {2,4}, a = {1,3});
</pre></blockquote>
<p>results in the following transfer function:</p>
<blockquote><pre>
     2*z + 4
y = --------- * u
      z + 3
</pre></blockquote>

</html>",
        revisions="<html>
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
    Text(textColor={0,0,127},
      extent={{-92.0,12.0},{86.0,92.0}},
      textString="b(z)"),
    Text(textColor={0,0,127},
      extent={{-90.0,-90.0},{90.0,-12.0}},
      textString="a(z)")}));
end TransferFunction;
