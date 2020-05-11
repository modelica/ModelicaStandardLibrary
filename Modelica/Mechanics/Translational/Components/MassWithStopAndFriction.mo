within Modelica.Mechanics.Translational.Components;
model MassWithStopAndFriction
  "Sliding mass with hard stop and Stribeck friction"
  extends PartialFrictionWithStop;
  SI.Velocity v(start=0, stateSelect=StateSelect.always)
    "Absolute velocity of flange_a and flange_b";
  SI.Acceleration a(start=0)
    "Absolute acceleration of flange_a and flange_b";
  parameter SI.Mass m(start=1) "Mass";
  parameter Real F_prop(
    final unit="N.s/m",
    final min=0,
    start=1) "Velocity dependent friction";
  parameter SI.Force F_Coulomb(start=5)
    "Constant friction: Coulomb force";
  parameter SI.Force F_Stribeck(start=10) "Stribeck effect";
  parameter Real fexp(
    final unit="s/m",
    final min=0,
    start=2) "Exponential decay";
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
  Integer stopped
    "Mode of stop (-1: hard stop at flange_a, 0: no stop, +1: hard stop at flange_b";
  encapsulated partial model PartialFrictionWithStop
    "Base model of Coulomb friction elements with stop"

    import Modelica;
    import Modelica.Mechanics.Translational.Interfaces.PartialRigid;
    parameter Modelica.Units.SI.Position smax(start=25)
      "Right stop for (right end of) sliding mass";
    parameter Modelica.Units.SI.Position smin(start=-25)
      "Left stop for (left end of) sliding mass";
    parameter Modelica.Units.SI.Velocity v_small=1e-3
      "Relative velocity near to zero (see model info text)"
      annotation (Dialog(tab="Advanced"));
    // Equations to define the following variables have to be defined in subclasses
    Modelica.Units.SI.Velocity v_relfric "Relative velocity between frictional surfaces";
    Modelica.Units.SI.Acceleration a_relfric
      "Relative acceleration between frictional surfaces";
    Modelica.Units.SI.Force f
      "Friction force (positive, if directed in opposite direction of v_rel)";
    Modelica.Units.SI.Force f0 "Friction force for v=0 and forward sliding";
    Modelica.Units.SI.Force f0_max "Maximum friction force for v=0 and locked";
    Boolean free "= true, if frictional element is not active";
    // Equations to define the following variables are given in this class
    Real sa(unit="1")
      "Path parameter of friction characteristic f = f(a_relfric)";
    Boolean startForward(start=false, fixed=true)
      "= true, if v_rel=0 and start of forward sliding or v_rel > v_small";
    Boolean startBackward(start=false, fixed=true)
      "= true, if v_rel=0 and start of backward sliding or v_rel < -v_small";
    Boolean locked(start=false) "= true, if v_rel=0 and not sliding";
    extends PartialRigid(s(start=0, stateSelect=StateSelect.always));
    constant Integer Unknown=3 "Value of mode is not known";
    constant Integer Free=2 "Element is not active";
    constant Integer Forward=1 "v_rel > 0 (forward sliding)";
    constant Integer Stuck=0
      "v_rel = 0 (forward sliding, locked or backward sliding)";
    constant Integer Backward=-1 "v_rel < 0 (backward sliding)";
    Integer mode(
      final min=Backward,
      final max=Unknown,
      start=Unknown,
      fixed=true)
      "Mode of friction (-1: backward sliding, 0: stuck, 1: forward sliding, 2: inactive, 3: unknown)";
  protected
    constant Modelica.Units.SI.Acceleration unitAcceleration=1 annotation (HideResult=true);
    constant Modelica.Units.SI.Force unitForce=1 annotation (HideResult=true);
  equation
    /* Friction characteristic
   (locked is introduced to help the Modelica translator determining
   the different structural configurations,
   if for each configuration special code shall be generated)
*/
    startForward = pre(mode) == Stuck and (sa > f0_max/unitForce and s < (
      smax - L/2) or pre(startForward) and sa > f0/unitForce and s < (smax
       - L/2)) or pre(mode) == Backward and v_relfric > v_small or initial()
       and (v_relfric > 0);
    startBackward = pre(mode) == Stuck and (sa < -f0_max/unitForce and s >
      (smin + L/2) or pre(startBackward) and sa < -f0/unitForce and s > (
      smin + L/2)) or pre(mode) == Forward and v_relfric < -v_small or
      initial() and (v_relfric < 0);
    locked = not free and not (pre(mode) == Forward or startForward or pre(
      mode) == Backward or startBackward);

    a_relfric/unitAcceleration = if locked then 0 else if free then sa
       else if startForward then sa - f0_max/unitForce else if
      startBackward then sa + f0_max/unitForce else if pre(mode) == Forward
       then sa - f0_max/unitForce else sa + f0_max/unitForce;

    /* Friction torque has to be defined in a subclass. Example for a clutch:
   f = if locked then sa else
       if free then   0 else
       cgeo*fn*(if startForward then          Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], v_relfric, 1) else
                if startBackward then        -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -v_relfric, 1) else
                if pre(mode) == Forward then  Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], v_relfric, 1) else
                                             -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -v_relfric, 1));
*/
    // finite state machine to determine configuration
    mode = if free then Free else (if (pre(mode) == Forward or pre(mode)
       == Free or startForward) and v_relfric > 0 and s < (smax - L/2)
       then Forward else if (pre(mode) == Backward or pre(mode) == Free or
      startBackward) and v_relfric < 0 and s > (smin + L/2) then Backward
       else Stuck);
    annotation (Documentation(info="<html>
<p>
Basic model for Coulomb friction that models the stuck phase in a reliable way.<br>
Additionally, a left and right stop are handled.
</p>
</html>"));
  end PartialFrictionWithStop;
equation
  // Constant auxiliary variables
  f0 = (F_Coulomb + F_Stribeck);
  f0_max = f0*1.001;
  free = f0 <= 0 and F_prop <= 0 and s > smin + L/2 and s < smax - L/2;
  // Velocity and acceleration of flanges
  v = der(s);
  a = der(v);
  v_relfric = v;
  a_relfric = a;
  // Equilibrium of forces
  0 = flange_a.f + flange_b.f - f - m*der(v);
  // Friction force
  f = if locked then sa*unitForce else if free then 0 else (if startForward
     then F_prop*v + F_Coulomb + F_Stribeck else if startBackward then
    F_prop*v - F_Coulomb - F_Stribeck else if pre(mode) == Forward then
    F_prop*v + F_Coulomb + F_Stribeck*Modelica.Math.exp(-fexp*abs(v)) else F_prop*v -
    F_Coulomb - F_Stribeck*Modelica.Math.exp(-fexp*abs(v)));
  lossPower = f*v_relfric;
  when (initial()) then
    assert(s > smin + L/2 or s >= smin + L/2 and v >= 0,
      "Error in initialization of hard stop. (s - L/2) must be >= smin\n"
       + "(s=" + String(s) + ", L=" + String(L) + ", smin=" + String(smin)
       + ")");
    assert(s < smax - L/2 or s <= smax - L/2 and v <= 0,
      "Error in initialization of hard stop. (s + L/2) must be <= smax\n"
       + "(s=" + String(s) + ", L=" + String(L) + ", smax=" + String(smax)
       + ")");
  end when;

  // Define events for hard stops and reinitialize the state variables velocity v and position s
  stopped = if s <= smin + L/2 then -1 else if s >= smax - L/2 then +1
     else 0;
  when stopped <> 0 then
    reinit(s, if stopped < 0 then smin + L/2 else smax - L/2);
    reinit(v, 0);
  end when;
  /*
Version 1:

  when not (s < smax - L/2) then
    reinit(s, smax - L/2);
    if (not initial() or v>0) then
      reinit(v, 0);
    end if;
  end when;

  when not (s > smin + L/2) then
    reinit(s, smin + L/2);
    if (not initial() or v<0) then
      reinit(v, 0);
    end if;
  end when;

Version 2:
        stopped := if s <= smin + L/2 then -1 else if s >= smax - L/2 then +1 else 0;
      when (initial()) then
        assert(s > smin + L/2 or s >= smin + L/2 and v >= 0,
          "Error in initialization of hard stop. (s - L/2) must be >= smin\n"+
          "(s=" + String(s) + ", L=" + String(L) + ", smin=" + String(smin) + ")");
        assert(s < smax - L/2 or s <= smax - L/2 and v <= 0,
          "Error in initialization of hard stop. (s + L/2) must be <= smax\n"+
          "(s=" + String(s) + ", L=" + String(L) + ", smax=" + String(smax) + ")");
      end when;
      when stopped <> 0 then
        reinit(s, if stopped < 0 then smin + L/2 else smax - L/2);
        if (not initial() or stopped*v>0) then
           reinit(v, 0);
        end if;
      end when;
*/
  annotation (
    Documentation(info="<html>
<p>This element describes the <em>Stribeck friction characteristics</em> of a sliding mass,
i. e. the frictional force acting between the sliding mass and the support. Included is a
<em>hard stop</em> for the position.</p>
<p>
The surface is fixed and there is friction between sliding mass and surface.
The frictional force f is given for positive velocity v by:
</p>
<blockquote><pre>
f = F_Coulomb + F_prop * v + F_Stribeck * exp (-fexp * v)
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Components/Stribeck.png\" alt=\"Stribeck friction\">
</div>

<p>
The distance between the left and the right connector is given by parameter L.
The position of the center of gravity, coordinate s, is in the middle between
the two flanges.</p>
<p>
There are hard stops at smax and smin, i. e. if
<em><code>flange_a.s &gt;= smin</code></em> and <em><code>flange_b.s &lt;= xmax </code></em> the sliding mass can move freely.</p>
<p>When the absolute velocity becomes zero, the sliding mass becomes stuck, i.e., the absolute position remains constant. In this phase the
friction force is calculated from a force balance due to the requirement that the
absolute acceleration shall be zero. The elements begin to slide when the friction
force exceeds a threshold value, called the maximum static friction force, computed via:</p>
<blockquote><pre>
maximum_static_friction =  F_Coulomb + F_Stribeck
</pre></blockquote>
<p>
<font color=\"#ff0000\"> <strong>This requires the states Stop.s and Stop.v</strong> </font>. If these states are eliminated during the index reduction
the model will not work. To avoid this any inertias should be connected via springs
to the Stop element, other sliding masses, dampers or hydraulic chambers must be avoided.</p>
<p>For more details of the used friction model see the following reference:</p>

<dl>
<dt>Beater P. (1999):</dt>
<dd><em>Entwurf hydraulischer Maschinen</em> (in German), Springer Verlag Berlin Heidelberg New York, <a href=\"https://doi.org/10.1007/978-3-642-58395-7\">DOI 10.1007/978-3-642-58395-7</a>.</dd>
</dl>

<p>The friction model is implemented in a \"clean\" way by state events and leads to
continuous/discrete systems of equations which have to be solved by appropriate
numerical methods. The method is described in
(see also a short sketch in <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>):
</p>

<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><em>Hybrid Modeling in Modelica based on the Synchronous Data Flow Principle</em>.
    CACSD'99, Aug. 22.-26, Hawaii. </dd>
</dl>

<p>More precise friction models take into account the elasticity of the material when
the two elements are \"stuck\", as well as other effects, like hysteresis. This has
the advantage that the friction element can be completely described by a differential
equation without events. The drawback is that the system becomes stiff (about 10-20 times
slower simulation) and that more material constants have to be supplied which requires more
sophisticated identification. For more details, see the following references, especially
(Armstrong and Canudas de Wit 1996):</p>
<dl>
<dt>
Armstrong B. (1991):</dt>
<dd><em>Control of Machines with Friction</em>. Kluwer Academic Press, Boston MA.<br>
</dd>
<dt>Armstrong B., and Canudas de Wit C. (1996): </dt>
<dd><em>Friction Modeling and Compensation.</em> The Control Handbook, edited by W.S.Levine, CRC Press, pp. 1369-1382.<br>
</dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J., and Lischinsky P. (1995): </dt>
<dd><em>A new model for control of systems with friction.</em> IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<br>
</dd>
</dl>

<h4>Optional heatPort</h4>
<p>
The dissipated energy is transported in form of heat to the optional heatPort connector
that can be enabled via parameter \"useHeatPort\". Independently whether the heatPort is
or is not enabled, the dissipated power is defined with variable \"lossPower\".
If contact occurs at the hard stops, the lossPower is not correctly modelled
at this time instant, because the hard stop would introduce a Dirac impulse
in the lossPower due to the discontinuously changing kinetic energy of the mass
(lossPower is the derivative of the kinetic energy at the time instant of the impact).
</p>

</html>",
      revisions="<html>
<h4>Release Notes</h4>
<ul>
<li><em>First Version from December 7, 1999 by P. Beater (based on Rotational.BearingFriction)</em></li>
<li><em>July 14, 2001 by P. Beater, assert on initialization added, diagram modified</em></li>
<li><em>October 11, 2001, by Hans Olsson, Dassault Syst&egrave;mes AB, modified assert to handle start at stops,
modified event logic such if you have friction parameters equal to zero you do not get events
between the stops.</em></li>
<li><em>June 10, 2002 by P. Beater, StateSelect.always for variables s and v (instead of fixed=true). </em></li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,0},{100,0}},color={0,127,0}),
        Polygon(
          points={{80,-100},{50,-90},{50,-110},{80,-100}},
          lineColor={95,127,95},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,-100},{50,-100}}, color={95,127,95}),
        Rectangle(
          extent={{-30,30},{30,-30}},
          fillPattern=FillPattern.Sphere,
          fillColor={166,221,166},
          lineColor={0,127,0}),
        Rectangle(
          extent={{-64,-16},{-56,-46}},
          fillPattern=FillPattern.Solid,
          lineColor={0,127,0},
          fillColor={0,127,0}),
        Rectangle(
          extent={{56,-16},{64,-46}},
          fillPattern=FillPattern.Solid,
          lineColor={0,127,0},
          fillColor={0,127,0}),
        Text( extent={{-150,80},{150,40}},
              textString="%name",
              textColor={0,0,255}),
        Line(points={{-50,-90},{-28,-68}}, color={0,127,0}),
        Line(points={{-30,-90},{-8,-68}}, color={0,127,0}),
        Line(points={{-10,-90},{12,-68}}, color={0,127,0}),
        Line(points={{10,-90},{32,-68}}, color={0,127,0}),
        Text(
          extent={{-150,-110},{150,-140}},
          textString="m=%m"),
        Line(
          visible=useHeatPort,
          points={{-100,-100},{-100,-40},{3,-40}},
          color={191,0,0},
          pattern=LinePattern.Dot),
        Rectangle(
          extent={{-70,-46},{70,-70}},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid,
          lineColor={0,127,0})}));
end MassWithStopAndFriction;
