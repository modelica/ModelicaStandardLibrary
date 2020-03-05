within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialFriction "Partial model of Coulomb friction elements"

  // parameter SI.AngularVelocity w_small=1 "Relative angular velocity near to zero (see model info text)";
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

  a_relfric/unitAngularAcceleration = if locked then 0 else if free then sa
     else if startForward then sa - tau0_max/unitTorque else if
    startBackward then sa + tau0_max/unitTorque else if pre(mode) ==
    Forward then sa - tau0_max/unitTorque else sa + tau0_max/unitTorque;

  /* Friction torque has to be defined in a subclass. Example for a clutch:
   tau = if locked then sa else
         if free then   0 else
         cgeo*fn*(if startForward then          Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], w_relfric, 1) else
                  if startBackward then        -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -w_relfric, 1) else
                  if pre(mode) == Forward then  Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], w_relfric, 1) else
                                               -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -w_relfric, 1));
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
This procedure is implemented in a \"clean\" way by state events and
leads to a mixed continuous/discrete systems of equations if friction elements
are dynamically coupled which have to be solved by appropriate
numerical methods. The method is described in
(see also a short sketch in <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>):
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
</html>"));
end PartialFriction;
