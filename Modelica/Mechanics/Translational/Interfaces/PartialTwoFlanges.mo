within Modelica.Mechanics.Translational.Interfaces;
partial model PartialTwoFlanges
  "Component with two translational 1D flanges"

  Flange_a flange_a
    "(left) driving flange (flange axis directed into cut plane, e. g. from left to right)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b
    "(right) driven flange (flange axis directed out of cut plane)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  annotation (Documentation(info="<html>
<p>
This is a 1D translational component with two flanges.
It is used e.g., to built up parts of a drive train consisting
of several base components.
</p>
</html>"));
end PartialTwoFlanges;
