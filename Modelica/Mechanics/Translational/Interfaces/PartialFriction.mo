within Modelica.Mechanics.Translational.Interfaces;
partial model PartialFriction "Base model of Coulomb friction elements"

  //extends Translational.Interfaces.PartialRigid;
  parameter Real m_inv_fixed(unit="kg-1")=0
    "Virtual inverse mass in locked state to handle fix point iteration problems if the velocity is not selected as state"
    annotation (Dialog(tab="Advanced"));
  parameter SI.Velocity v_small=1e-3
    "Relative velocity near to zero (see model info text)"
    annotation (Dialog(tab="Advanced"));
  // Equations to define the following variables have to be defined in subclasses
  SI.Velocity v_relfric "Relative velocity between frictional surfaces";
  SI.Acceleration a_relfric
    "Relative acceleration between frictional surfaces";
  //SI.Force f "Friction force (positive, if directed in opposite direction of v_relfric)";
  SI.Force f0 "Friction force for v_relfric=0 and forward sliding";
  SI.Force f0_max "Maximum friction force for v_relfric=0 and locked";
  Boolean free "= true, if frictional element is not active";
  // Equations to define the following variables are given in this class
  Real sa(unit="1")
    "Path parameter of friction characteristic f = f(a_relfric)";
  Boolean startForward(start=false, fixed=true)
    "= true, if v_relfric=0 and start of forward sliding";
  Boolean startBackward(start=false, fixed=true)
    "= true, if v_relfric=0 and start of backward sliding";
  Boolean locked(start=false) "= true, if v_relfric=0 and not sliding";
  constant Integer Unknown=3 "Value of mode is not known";
  constant Integer Free=2 "Element is not active";
  constant Integer Forward=1 "v_relfric > 0 (forward sliding)";
  constant Integer Stuck=0
    "v_relfric = 0 (forward sliding, locked or backward sliding)";
  constant Integer Backward=-1 "v_relfric < 0 (backward sliding)";
  Integer mode(
    final min=Backward,
    final max=Unknown,
    start=Unknown,
    fixed=true)
    "Mode of friction (-1: backward sliding, 0: stuck, 1: forward sliding, 2: inactive, 3: unknown)";
protected
  constant SI.Acceleration unitAcceleration=1 annotation (HideResult=true);
  constant SI.Force unitForce=1 annotation (HideResult=true);
equation
  /* Friction characteristic
   (locked is introduced to help the Modelica translator determining
   the different structural configurations,
   if for each configuration special code shall be generated)
*/
  startForward = pre(mode) == Stuck and (sa > f0_max/unitForce or pre(
    startForward) and sa > f0/unitForce) or pre(mode) == Backward and
    v_relfric > v_small or initial() and (v_relfric > 0);
  startBackward = pre(mode) == Stuck and (sa < -f0_max/unitForce or pre(
    startBackward) and sa < -f0/unitForce) or pre(mode) == Forward and
    v_relfric < -v_small or initial() and (v_relfric < 0);
  locked = not free and not (pre(mode) == Forward or startForward or pre(
    mode) == Backward or startBackward);

  a_relfric/unitAcceleration = if locked then m_inv_fixed*sa*unitForce else if free then sa
    else if startForward then sa - f0_max/unitForce
    else if startBackward then sa + f0_max/unitForce
    else if pre(mode) == Forward then sa - f0_max/unitForce
    else if pre(mode) == Backward then sa + f0_max/unitForce
    else sa - sign(v_relfric)*f0_max/unitForce;

  /* Friction force "f" has to be defined in a subclass. Example for possible
     realization of a brake utilizing interpolation by ExternalCombiTable1D see:
     Modelica.Mechanics.Translational.Components.Brake
  */

  // finite state machine to determine configuration
  mode = if free then Free else (if (pre(mode) == Forward or pre(mode) ==
    Free or startForward) and v_relfric > 0 then Forward else if (pre(mode)
     == Backward or pre(mode) == Free or startBackward) and v_relfric < 0
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
