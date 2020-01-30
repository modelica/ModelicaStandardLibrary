within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialCompliant
  "Partial model for the compliant connection of two rotational 1-dim. shaft flanges"

  SI.Angle phi_rel(start=0)
    "Relative rotation angle (= flange_b.phi - flange_a.phi)";
  SI.Torque tau "Torque between flanges (= flange_b.tau)";
  Flange_a flange_a "Left flange of compliant 1-dim. rotational component"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b "Right flange of compliant 1-dim. rotational component"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  phi_rel = flange_b.phi - flange_a.phi;
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
</html>"));
end PartialCompliant;
