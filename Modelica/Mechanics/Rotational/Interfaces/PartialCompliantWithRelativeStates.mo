within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialCompliantWithRelativeStates
  "Partial model for the compliant connection of two rotational 1-dim. shaft flanges where the relative angle and speed are used as preferred states"

  SI.Angle phi_rel(
    start=0,
    stateSelect=stateSelect,
    nominal=if phi_nominal >= Modelica.Constants.eps then phi_nominal else
        1) "Relative rotation angle (= flange_b.phi - flange_a.phi)";
  SI.AngularVelocity w_rel(start=0, stateSelect=stateSelect)
    "Relative angular velocity (= der(phi_rel))";
  SI.AngularAcceleration a_rel(start=0)
    "Relative angular acceleration (= der(w_rel))";
  SI.Torque tau "Torque between flanges (= flange_b.tau)";
  Flange_a flange_a "Left flange of compliant 1-dim. rotational component"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b "Right flange of compliant 1-dim. rotational component"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  parameter SI.Angle phi_nominal(
    displayUnit="rad",
    min=0.0) = 1e-4 "Nominal value of phi_rel (used for scaling)"
    annotation (Dialog(tab="Advanced"));
  parameter StateSelect stateSelect=StateSelect.prefer
    "Priority to use phi_rel and w_rel as states"
    annotation (HideResult=true, Dialog(tab="Advanced"));

equation
  phi_rel = flange_b.phi - flange_a.phi;
  w_rel = der(phi_rel);
  a_rel = der(w_rel);
  flange_b.tau = tau;
  flange_a.tau = -tau;
  annotation (Documentation(info="<html>
<p>
This is a 1-dim. rotational component with a compliant connection of two
rotational 1-dim. flanges where inertial effects between the two
flanges are neglected. The basic assumption is that the cut-torques
of the two flanges sum-up to zero, i.e., they have the same absolute value
but opposite sign: flange_a.tau + flange_b.tau = 0. This base class
is used to built up force elements such as springs, dampers, friction.
</p>

<p>
The relative angle and the relative speed are defined as preferred states.
The reason is that for some drive trains, such as drive
trains in vehicles, the absolute angle is quickly increasing during operation.
Numerically, it is better to use relative angles between drive train components
because they remain in a limited size. For this reason, StateSelect.prefer
is set for the relative angle of this component.
</p>

<p>
In order to improve the numerics, a nominal value for the relative angle
can be provided via parameter <strong>phi_nominal</strong> in the Advanced menu.
The default is 1e-4 rad since relative angles are usually
in this order and the step size control of an integrator would be
practically switched off, if a default of 1 rad would be used.
This nominal value might also be computed from other values, such
as \"phi_nominal = tau_nominal / c\" for a rotational spring, if tau_nominal
and c are more meaningful for the user.
</p>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"));
end PartialCompliantWithRelativeStates;
