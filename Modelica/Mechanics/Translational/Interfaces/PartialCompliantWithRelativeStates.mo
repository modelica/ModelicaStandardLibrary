within Modelica.Mechanics.Translational.Interfaces;
partial model PartialCompliantWithRelativeStates
  "Base model for the compliant connection of two translational 1-dim. shaft flanges where the relative position and relative velocities are used as states"

  parameter StateSelect stateSelect=StateSelect.prefer
    "Priority to use s_rel and v_rel as states"
    annotation (HideResult=true, Dialog(tab="Advanced"));
  parameter SI.Distance s_nominal=1e-4
    "Nominal value of s_rel (used for scaling)"
    annotation (Dialog(tab="Advanced"));

  SI.Position s_rel(
    start=0,
    stateSelect=stateSelect,
    nominal=s_nominal) "Relative distance (= flange_b.s - flange_a.s)";
  SI.Velocity v_rel(start=0, stateSelect=stateSelect)
    "Relative velocity (= der(s_rel))";

  SI.Force f "Forces between flanges (= flange_b.f)";
  extends Translational.Interfaces.PartialTwoFlanges;
equation
  s_rel = flange_b.s - flange_a.s;
  v_rel = der(s_rel);
  flange_b.f = f;
  flange_a.f = -f;
  annotation (Documentation(info="<html>
<p>
This is a 1-dim. translational component with a compliant connection of two
translational 1-dim. flanges where inertial effects between the two
flanges are neglected. The basic assumption is that the cut-forces
of the two flanges sum-up to zero, i.e., they have the same absolute value
but opposite sign: flange_a.f + flange_b.f = 0. This base class
is used to built up force elements such as springs, dampers, friction.
</p>

<p>
The difference to base class \"PartialCompliant\" is that the relative
distance and the relative velocity are defined as preferred states.
The reason is that for a large class of drive trains,
the absolute position is quickly increasing during operation.
Numerically, it is better to use relative distances between drive train components
because they remain in a limited size. For this reason, StateSelect.prefer
is set for the relative distance of this component.
</p>

<p>
In order to improve the numerics, a nominal value for the relative distance
should be set, since drive train distances are in a small order and
then step size control of the integrator is practically switched off for
such a variable. A default nominal value of s_nominal = 1e-4 is defined.
This nominal value might also be computed from other values, such
as \"s_nominal = f_nominal / c\" for a spring, if f_nominal
and c have more meaningful values for the user.
</p>

</html>"));
end PartialCompliantWithRelativeStates;
