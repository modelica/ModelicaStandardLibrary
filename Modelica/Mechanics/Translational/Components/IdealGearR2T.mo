within Modelica.Mechanics.Translational.Components;
model IdealGearR2T
  "Gearbox transforming rotational into translational motion"
  extends Modelica.Mechanics.Rotational.Components.IdealGearR2T;
  annotation (
    Documentation(info="<html>
<p>Couples rotational and translational motion, like a toothed wheel with a toothed rack, specifying the ratio of rotational / translational motion.</p>
</html>"));
end IdealGearR2T;
