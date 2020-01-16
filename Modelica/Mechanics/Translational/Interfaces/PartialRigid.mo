within Modelica.Mechanics.Translational.Interfaces;
partial model PartialRigid
  "Rigid connection of two translational 1D flanges"
  SI.Position s
    "Absolute position of center of component (s = flange_a.s + L/2 = flange_b.s - L/2)";
  parameter SI.Length L(start=0)
    "Length of component, from left flange to right flange (= flange_b.s - flange_a.s)";
  extends Translational.Interfaces.PartialTwoFlanges;
equation
  flange_a.s = s - L/2;
  flange_b.s = s + L/2;
  annotation (Documentation(info="<html>
<p>
This is a 1-dim. translational component with two <em>rigidly</em> connected flanges.
The fixed distance between the left and the right flange is defined by parameter \"L\".
The forces at the right and left flange can be different.
It is used e.g., to built up sliding masses.
</p>
</html>"));
end PartialRigid;
