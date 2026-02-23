within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialFriction "Partial model of Coulomb friction elements"

  parameter Real J_inv_fixed(unit="kg-1.m-2")=0
    "Virtual inverse moment of inertia in locked state to handle fix point iteration problems if the velocity is not selected as state"
    annotation (Dialog(tab="Advanced"));
  parameter SI.AngularVelocity w_small=1.0e10
    "Relative angular velocity near to zero if jumps due to a reinit(..) of the velocity can occur (set to low value only if such impulses can occur)"
    annotation (Dialog(tab="Advanced"));
  // Equations to define the following variables have to be defined in subclasses
  SI.AngularVelocity w_relfric
    "Relative angular velocity between frictional surfaces";
  SI.AngularAcceleration a_relfric
    "Relative angular acceleration between frictional surfaces";
  //SI.Torque tau "Friction torque (positive, if directed in opposite direction of w_rel)";
  SI.Torque tau0 "Friction torque for w_relfric=0 and forward sliding";
  SI.Torque tau0_max "Maximum friction torque for w_relfric=0 and locked";
  Boolean free "= true, if frictional element is not active";
  // Equations to define the following variables are given in this class
  Real sa(final unit="1")
    "Path parameter of friction characteristic tau = f(a_relfric)";
  Boolean startForward(start=false, fixed=true)
    "= true, if w_relfric=0 and start of forward sliding";
  Boolean startBackward(start=false, fixed=true)
    "= true, if w_relfric=0 and start of backward sliding";
  Boolean locked(start=false) "= true, if w_rel=0 and not sliding";
  constant Integer Unknown=3 "Value of mode is not known";
  constant Integer Free=2 "Element is not active";
  constant Integer Forward=1 "w_relfric > 0 (forward sliding)";
  constant Integer Stuck=0
    "w_relfric = 0 (forward sliding, locked or backward sliding)";
  constant Integer Backward=-1 "w_relfric < 0 (backward sliding)";
  Integer mode(
    final min=Backward,
    final max=Unknown,
    start=Unknown,
    fixed=true)
    "Mode of friction (-1: backward sliding, 0: stuck, 1: forward sliding, 2: inactive, 3: unknown)";
protected
  constant SI.AngularAcceleration unitAngularAcceleration=1
    annotation (HideResult=true);
  constant SI.Torque unitTorque=1 annotation (HideResult=true);
equation
  /* Friction characteristic
   locked is introduced to help the Modelica translator determining
   the different structural configurations,
   if for each configuration special code shall be generated
*/
  startForward = pre(mode) == Stuck and (sa > tau0_max/unitTorque or pre(
    startForward) and sa > tau0/unitTorque) or pre(mode) == Backward and
    w_relfric > w_small or initial() and (w_relfric > 0);
  startBackward = pre(mode) == Stuck and (sa < -tau0_max/unitTorque or pre(
    startBackward) and sa < -tau0/unitTorque) or pre(mode) == Forward and
    w_relfric < -w_small or initial() and (w_relfric < 0);
  locked = not free and not (pre(mode) == Forward or startForward or pre(
    mode) == Backward or startBackward);

  a_relfric/unitAngularAcceleration = if locked then J_inv_fixed*sa*unitTorque else if free then sa
    else if startForward then sa - tau0_max/unitTorque
    else if startBackward then sa + tau0_max/unitTorque
    else if pre(mode) == Forward then sa - tau0_max/unitTorque
    else if pre(mode) == Backward then sa + tau0_max/unitTorque
    else sa - sign(w_relfric)*tau0_max/unitTorque;

  /* Friction torque "tau" has to be defined in a subclass. Example for possible
     realization of a clutch utilizing interpolation by ExternalCombiTable1D see:
     Modelica.Mechanics.Rotational.Components.Clutch
*/

  // finite state machine to determine configuration
  mode = if free then Free else (if (pre(mode) == Forward or pre(mode) ==
    Free or startForward) and w_relfric > 0 then Forward else if (pre(mode)
     == Backward or pre(mode) == Free or startBackward) and w_relfric < 0
     then Backward else Stuck);
  annotation (Documentation(info="<html>
<p>
Basic model for Coulomb friction that models the stuck phase in a reliable way.
</p>

<p>
This procedure is implemented in a&nbsp;&quot;clean&quot; way
by state events and leads to a&nbsp;mixed continuous/discrete
system of equations if friction elements are dynamically coupled
which has to be solved by appropriate numerical methods.
The method is described in [Otter1999]
(see also a&nbsp;short sketch in
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>).
</p>
<p>
The parameter <code>w_small</code> is introduced for particular
cases where a&nbsp;reinit is triggered at zero velocity. 
For such &ndash; rather rare &ndash; cases the friction handling
logic is no longer correct. On the other hand, introducing
<code>w_small</code> in general leads to problems when more
friction elements are connected together. To omit such problems
in the most common situations, the parameter has a&nbsp;large
value per default, thus eliminating its effect.
The user has to <strong>set <code>w_small</code> to
a&nbsp;small value only when</strong> the special case with
<strong>reinit occurs</strong>.
</p>

<h4>References</h4>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>[Otter1999]</td>
    <td>Otter M., Elmqvist H., and Mattsson S.E.,
        &quot;<a href=\"https://ieeexplore.ieee.org/document/808640\">Hybrid
        Modeling in Modelica based on the Synchronous Data Flow Principle</a>&quot;,
        <em>CACSD'99</em>,
        Aug. 22.-26, Hawaii 1999.
    </td>
  </tr>
</table> 
</html>"));
end PartialFriction;
