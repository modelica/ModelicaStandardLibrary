within Modelica.Clocked.RealSignals.Periodic;
block TransferFunction "Discrete-time Transfer Function block"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Real b[:]={1} "Numerator coefficients of transfer function.";
  parameter Real a[:] "Denominator coefficients of transfer function.";

  output Real x[size(a, 1) - 1](each start=0.0)
    "State vector of controller canonical form";
protected
  parameter Integer nb=size(b, 1) "Size of Numerator of transfer function";
  parameter Integer na=size(a, 1)
    "Size of Denominator of transfer function";
  Real x1;
  Real xext[size(a, 1)];

equation
  when Clock() then
    /* State variables x are defined according to
       controller canonical form. */
    x1 = (u - a[2:size(a, 1)]*previous(x))/a[1];
    xext = vector([x1; previous(x)]);
    x = xext[1:size(x, 1)];
    y = vector([zeros(na - nb, 1); b])*xext;
  end when;
  annotation (
    Documentation(info="<html>
<p>The <strong>discrete transfer function</strong> block defines the
transfer function between the input signal u and the output
signal y. The numerator has the order nb-1, the denominator
has the order na-1.</p>
<blockquote><pre>
       b(1)*z^(nb-1) + b(2)*z^(nb-2) + &hellip; + b(nb)
y(z) = -------------------------------------------- * u(z)
       a(1)*z^(na-1) + a(2)*z^(na-2) + &hellip; + a(na)
</pre></blockquote>
<p>State variables <strong>x</strong> are defined according to
<strong>controller canonical</strong> form. Initial values of the
states can be set as start values of <strong>x</strong>.</p>
<p>Example:</p>
<blockquote><pre>
TransferFunction g(b = {2,4}, a = {1,3});
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
<li><em>August 13, 2012</em>
    by <a href=\"http://www.dlr.de/rm/\">Bernhard Thiele</a>:<br>
    Used the original code from Blocks.Discrete.TransferFunction and converted it into
    the Modelica 3.3 clocked equation style.</li>
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
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{82,0},{-84,0}}, color={0,0,127}),
        Text(
          extent={{-92,92},{86,12}},
          textColor={0,0,127},
          textString="b(z)"),
        Text(
          extent={{-90,-12},{90,-90}},
          textColor={0,0,127},
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
