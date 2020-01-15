within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialTwoFlanges
  "Partial model for a component with two rotational 1-dim. shaft flanges"

  Flange_a flange_a "Flange of left shaft" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b "Flange of right shaft" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  annotation (Documentation(info="<html>
<p>
This is a 1-dim. rotational component with two flanges.
It is used e.g., to build up parts of a drive train consisting
of several components.
</p>
</html>"));
end PartialTwoFlanges;
