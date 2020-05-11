within Modelica.Mechanics.Translational.Components;
model ElastoGap "1D translational spring damper combination with gap"
  extends Modelica.Mechanics.Translational.Interfaces.PartialCompliantWithRelativeStates;
  parameter SI.TranslationalSpringConstant c(final min=0, start=1)
    "Spring constant";
  parameter SI.TranslationalDampingConstant d(final min=0, start=1)
    "Damping constant";
  parameter SI.Position s_rel0=0 "Unstretched spring length";
  parameter Real n(final min=1) = 1
    "Exponent of spring force ( f_c = -c*|s_rel-s_rel0|^n )";
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  /*
Please note that initialization might fail due to the nonlinear spring characteristic
(spring force is zero for s_rel > s_rel0)
if a positive force is acting on the element and no other force balances this force
(e.g., when setting both initial velocity and acceleration to 0)
*/
  Boolean contact "= true, if contact, otherwise no contact";
protected
  SI.Force f_c "Spring force";
  SI.Force f_d2 "Linear damping force";
  SI.Force f_d
    "Linear damping force which is limited by spring force (|f_d| <= |f_c|)";
equation
  // Modify contact force, so that it is only "pushing" and not
  // "pulling/sticking" and that it is continuous
  contact = s_rel < s_rel0;
  f_c = smooth(1, noEvent(if contact then -c*abs(s_rel - s_rel0)^n else 0));
  f_d2 = if contact then d*v_rel else 0;
  f_d = smooth(0, noEvent(if contact then (if f_d2 < f_c then f_c else if
    f_d2 > -f_c then -f_c else f_d2) else 0));
  f = f_c + f_d;
  lossPower = f_d*v_rel;
  annotation (
    Documentation(info="<html>
<p>
This component models a spring damper combination that can lift off.
It can be connected between a sliding mass and the housing (model
<a href=\"modelica://Modelica.Mechanics.Translational.Components.Fixed\">Fixed</a>),
to describe the contact of a sliding mass with the housing.
</p>

<p>
As long as s_rel &gt; s_rel0, no force is exerted (s_rel = flange_b.s - flange_a.s).
If s_rel &le; s_rel0, the contact force is basically computed with a linear
spring/damper characteristic. With parameter n&ge;1 (exponent of spring force),
a nonlinear spring force can be modeled:
</p>

<blockquote><pre>
desiredContactForce = c*|s_rel - s_rel0|^n + d*<strong>der</strong>(s_rel)
</pre></blockquote>

<p>
Note, Hertzian contact is described by:
</p>
<ul>
<li> Contact between two metallic spheres: n=1.5</li>
<li> Contact between two metallic plates: n=1</li>
</ul>

<p>
The above force law leads to the following difficulties:
</p>

<ol>
<li> If the damper force becomes larger as the spring force and with opposite sign,
     the contact force would be \"pulling/sticking\" which is unphysical, since during
     contact only pushing forces can occur.</li>

<li> When contact occurs with a non-zero relative speed (which is the usual
     situation), the damping force has a non-zero value and therefore the contact
     force changes discontinuously at s_rel = s_rel0. Again, this is not physical
     because the force can only change continuously. (Note, this component is not an
     idealized model where a steep characteristic is approximated by a discontinuity,
     but it shall model the steep characteristic.)</li>
</ol>

<p>
In the literature there are several proposals to fix problem (2). Especially, often
the following model is used (see, e.g.,
Lankarani, Nikravesh: Continuous Contact Force Models for Impact
Analysis in Multibody Systems, Nonlinear Dynamics 5, pp. 193-207, 1994,
<a href=\"https://link.springer.com/article/10.1007/BF00045676\">pdf-download</a>):
</p>

<blockquote><pre>
f = c*s_rel^n + (d*s_rel^n)*<strong>der</strong>(s_rel)
</pre></blockquote>

<p>
However, this and other models proposed in literature violate
issue (1), i.e., unphysical pulling forces can occur (if d*<strong>der</strong>(s_rel)
becomes large enough). Note, if the force law is of the form \"f = f_c + f_d\", then a
necessary condition is that |f_d| &le; |f_c|, otherwise (1) and (2) are violated.
For this reason, the most simplest approach is used in the ElastoGap model
to fix both problems by using this necessary condition in the force law directly.
If s_rel0 = 0, the equations are:
</p>

<blockquote><pre>
<strong>if</strong> s_rel &ge; 0 <strong>then</strong>
   f = 0;    // contact force
<strong>else</strong>
   f_c  = -c*|s_rel|^n;          // contact spring force (Hertzian contact force)
   f_d2 = d*<strong>der</strong>(s_rel);         // linear contact damper force
   f_d  = <strong>if</strong> f_d2 &lt;  f_c <strong>then</strong>  f_c <strong>else</strong>
          <strong>if</strong> f_d2 &gt; -f_c <strong>then</strong> -f_c <strong>else</strong> f_d2;  // bounded damper force
   f    = f_c + f_d;            // contact force
<strong>end if</strong>;
</pre></blockquote>

<p>
Note, since |f_d| &le; |f_c|, pulling forces cannot occur and the contact force
is always continuous, especially around the start of the penetration at s_rel = s_rel0.
</p>

<p>
In the next figure, a typical simulation with the ElastoGap model is shown
(<a href=\"modelica://Modelica.Mechanics.Translational.Examples.ElastoGap\">Examples.ElastoGap</a>)
where the different effects are visualized:
</p>

<ol>
<li> Curve 1 (elastoGap1.f) is the unmodified contact force, i.e., the linear spring/damper
     characteristic. A pulling/sticking force is present at the end of the contact.</li>
<li> Curve 2 (elastoGap2.f) is the contact force, where the force is explicitly set to
     zero when pulling/sticking occurs. The contact force is discontinuous when contact starts.</li>
<li> Curve 3 (elastoGap3.f) is the ElastoGap model of this library. No discontinuity and no
     pulling/sticking occurs.</li>
</ol>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Components/ElastoGap.png\" alt=\"Elasto gap\">
</div>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-98,0},{-48,0}}, color={0,127,0}),
          Line(
              points={{-48,36},{-48,-38}},
              thickness=1,
          color={0,127,0}),                Line(
              points={{-12,-38},{-12,36}},
              thickness=1,
          color={0,127,0}),Line(points={{-12,-28},{70,-28},{70,24}}, color={0,127,0}),
                                          Line(points={{70,0},{98,0}},
                   color={0,127,0}),
          Line(points={{-12,24},{0,24},{6,34},{18,14},{30,34},{42,14},{54,34},{60,24},{70,24}}, color={0,127,0}),
          Rectangle(
              extent={{10,-6},{50,-50}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid,
          lineColor={0,127,0}),              Line(points={{-52,-70},{28,-70}}, color={95,127,95}),
                                                                               Polygon(
          points={{58,-70},{28,-60},{28,-80},{58,-70}},
          lineColor={95,127,95},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid),    Text(
              extent={{-150,100},{150,60}},
              textString="%name",
              textColor={0,0,255}), Text(
              extent={{-150,-125},{150,-95}},
              textString="c=%c"),Text(
              extent={{-150,-160},{150,-130}},
              textString="d=%d"),
          Line(
              visible=useHeatPort,
              points={{-100,-100},{-100,-44},{22,-44},{22,-28}},
              color={191,0,0},
              pattern=LinePattern.Dot),
          Line(points={{0,-50},{50,-50},{50,-6},{0,-6}}, color={0,127,0})}));
end ElastoGap;
