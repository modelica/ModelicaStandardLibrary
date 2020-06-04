within Modelica.Mechanics.Rotational.Components;
model ElastoBacklash
  "Backlash connected in series to linear spring and damper (backlash is modeled with elasticity)"

  parameter SI.RotationalSpringConstant c(final min=Modelica.Constants.small,
      start=1.0e5) "Spring constant (c > 0 required)";
  parameter SI.RotationalDampingConstant d(final min=0, start=0)
    "Damping constant";
  parameter SI.Angle b(final min=0) = 0 "Total backlash";
  parameter SI.Angle phi_rel0=0 "Unstretched spring angle";

  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
protected
  final parameter SI.Angle bMax=b/2
    "Backlash in range bMin <= phi_rel - phi_rel0 <= bMax";
  final parameter SI.Angle bMin=-bMax
    "Backlash in range bMin <= phi_rel - phi_rel0 <= bMax";
  SI.Torque tau_c;
  SI.Torque tau_d;
  SI.Angle phi_diff=phi_rel - phi_rel0;

  // A minimum backlash is defined in order to avoid an infinite
  // number of state events if backlash b is set to zero.
  constant SI.Angle bEps=1e-10 "Minimum backlash";

equation
  if initial() then
    /* During initialization the characteristic is modified, in order that
        it is a strict monotone rising function. Otherwise, initialization might
        result in a singular system when the characteristic has to be
        inverted. The characteristic is modified in the range 1.5*bMin <= phi_rel - phi_rel0 <= 1.5 bMax,
        so that in this range a linear characteristic is present that approaches the original
        function continuously at its limits, e.g.,
          original:  tau(1.5*bMax) = c*(phi_diff - bMax)
                                   = c*(0.5*bMax)
          initial :  tau(1.5*bMax) = (c/3)*phi_diff
                                   = (c/3)*(3/2)*bMax
                                   = (c/2)*bMax
     */
    tau_c = if phi_diff > 1.5*bMax then c*(phi_diff - bMax) else if
      phi_diff < 1.5*bMin then c*(phi_diff - bMin) else (c/3)*phi_diff;
    tau_d = d*w_rel;
    tau = tau_c + tau_d;
    lossPower = tau_d*w_rel;
  else
    /*
     if abs(b) <= bEps then
        tau_c = c*phi_diff;
        tau_d = d*w_rel;
        tau   = tau_c + tau_d;
     elseif phi_diff > bMax then
        tau_c = c*(phi_diff - bMax);
        tau_d = d*w_rel;
        tau   = smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else tau_c + min(tau_c,tau_d)));
     elseif phi_diff < bMin then
        tau_c = c*(phi_diff - bMin);
        tau_d = d*w_rel;
        tau   = smooth(0, noEvent(if tau_c + tau_d >= 0 then 0 else tau_c + max(tau_c,tau_d)));
     else
        tau_c = 0;
        tau_d = 0;
        tau   = 0;
     end if;

     This is written in the form below, in order that parameter "b"
     is not evaluated during translation (i.e., in the above form
     it cannot be changed anymore after translation).
   */

    tau_c = if abs(b) <= bEps then c*phi_diff else if phi_diff > bMax then
      c*(phi_diff - bMax) else if phi_diff < bMin then c*(phi_diff - bMin)
       else 0;
    tau_d = d*w_rel;
    tau = if abs(b) <= bEps then tau_c + tau_d else if phi_diff > bMax
       then smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else tau_c + min(
      tau_c, tau_d))) else if phi_diff < bMin then smooth(0, noEvent(if
      tau_c + tau_d >= 0 then 0 else tau_c + max(tau_c, tau_d))) else 0;
    lossPower = if abs(b) <= bEps then tau_d*w_rel else if phi_diff > bMax
       then smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else min(tau_c,
      tau_d)*w_rel)) else if phi_diff < bMin then smooth(0, noEvent(if
      tau_c + tau_d >= 0 then 0 else max(tau_c, tau_d)*w_rel)) else 0;
  end if;
  annotation (
    Documentation(info="<html>
<p>
This element consists of a <strong>backlash</strong> element <strong>connected in series</strong>
to a <strong>spring</strong> and <strong>damper</strong> element which are <strong>connected in parallel</strong>.
The spring constant shall be non-zero, otherwise the component cannot be used.
</p>

<p>
In combination with components IdealGear, the ElastoBacklash model
can be used to model a gear box with backlash, elasticity and damping.
</p>

<p>
During initialization, the backlash characteristic is replaced by a continuous
approximation in the backlash region, in order to reduce problems during
initialization, especially for inverse models.
</p>

<p>
If the backlash b is smaller as 1e-10 rad (especially, if b=0),
then the backlash is ignored and the component reduces to a spring/damper
element in parallel.
</p>

<p>
In the backlash region (-b/2 &le; flange_b.phi - flange_a.phi - phi_rel0 &le; b/2) no torque
is exerted (flange_b.tau = 0). Outside of this region, contact is present and
the contact torque is basically computed with a linear
spring/damper characteristic:
</p>

<blockquote><pre>
desiredContactTorque = c*phi_contact + d*<strong>der</strong>(phi_contact)

         phi_contact = phi_rel - phi_rel0 - b/2 <strong>if</strong> phi_rel - phi_rel0 &gt;  b/2
                     = phi_rel - phi_rel0 + b/2 <strong>if</strong> phi_rel - phi_rel0 &lt; -b/2

         phi_rel     = flange_b.phi - flange_a.phi;
</pre></blockquote>

<p>
This torque characteristic leads to the following difficulties:
</p>

<ol>
<li> If the damper torque becomes larger as the spring torque and with opposite sign,
     the contact torque would be \"pulling/sticking\" which is unphysical, since during
     contact only pushing torques can occur.</li>

<li> When contact occurs with a non-zero relative speed (which is the usual
     situation), the damping torque has a non-zero value and therefore the contact
     torque changes discontinuously at phi_rel = phi_rel0. Again, this is not physical
     because the torque can only change continuously. (Note, this component is not an
     idealized model where a steep characteristic is approximated by a discontinuity,
     but it shall model the steep characteristic.)</li>
</ol>

<p>
In the literature there are several proposals to fix problem (2). However, there
seems to be no proposal to avoid sticking. For this reason, the most simple
approach is used in the ElastoBacklash model, to fix both problems by slight changes
to the linear spring/damper characteristic:
</p>

<blockquote><pre>
// Torque characteristic when phi_rel > phi_rel0
<strong>if</strong> phi_rel - phi_rel0 &lt; b/2 <strong>then</strong>
   tau_c = 0;          // spring torque
   tau_d = 0;          // damper torque
   flange_b.tau = 0;
<strong>else</strong>
   tau_c = c*(phi_rel - phi_rel0);    // spring torque
   tau_d = d*<strong>der</strong>(phi_rel);            // damper torque
   flange_b.tau = <strong>if</strong> tau_c + tau_d &le; 0 <strong>then</strong> 0 <strong>else</strong> tau_c + <strong>min</strong>( tau_c, tau_d );
<strong>end if</strong>;
</pre></blockquote>

<p>
Note, when sticking would occur (tau_c + tau_d &le; 0), then the contact torque
is explicitly set to zero. The \"min(tau_c, tau_d)\" part in the if-expression,
limits the damping torque when it is pushing. This means that at the start of
the contact (phi_rel - phi_rel0 = b/2), the damping torque is zero and is continuous.
The effect of both modifications is that the absolute value of the damping torque
is always limited by the absolute value of the spring torque: |tau_d| &le; |tau_c|.
</p>

<p>
In the next figure, a typical simulation with the ElastoBacklash model is shown
(<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.Backlash\">Examples.Backlash</a>)
where the different effects are visualized:
</p>

<ol>
<li> Curve 1 (elastoBacklash1.tau) is the unmodified contact torque, i.e., the linear spring/damper
     characteristic. A pulling/sticking torque is present at the end of the contact.</li>
<li> Curve 2 (elastoBacklash2.tau) is the contact torque, where the torque is explicitly set to
     zero when pulling/sticking occurs. The contact torque is discontinuous at begin of
     contact.</li>
<li> Curve 3 (elastoBacklash3.tau) is the ElastoBacklash model of this library. No discontinuity and no
     pulling/sticking occurs.</li>
</ol>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/Components/elastoBacklash.png\" alt=\"Results of simulation with the ElastoBacklash model\">
</div>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"),
    Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}),
      graphics={
    Line(points={{-80,32},{-58,32},{-48,0},{-34,61},{-20,0},{-8,60},{0,30},{20,30}}),
    Rectangle(extent={{-60,-10},{-10,-50}},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-60,-50},{0,-50}}),
    Line(points={{-60,-10},{0,-10}}),
    Line(points={{-10,-30},{20,-30}}),
    Line(points={{-80,-30},{-60,-30}}),
    Line(points={{-80,32},{-80,-30}}),
    Line(points={{20,30},{20,-30}}),
    Line(points={{-90,0},{-80,0}}),
    Line(points={{90,0},{80,0}}),
    Line(points={{20,0},{60,0},{60,-30}}),
    Line(points={{40,-12},{40,-40},{80,-40},{80,0}}),
    Text(extent={{-150,-130},{150,-90}},
      textString="b=%b"),
    Text(extent={{-150,100},{150,60}},
      textColor={0,0,255},
      textString="%name"),
    Text(extent={{-152,-92},{148,-52}},
      textString="c=%c"),
    Line(visible=useHeatPort,
      points={{-100,-100},{-100,-43},{-34,-43}},
      color={191,0,0},
      pattern=LinePattern.Dot)}));
end ElastoBacklash;
