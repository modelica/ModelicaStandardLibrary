within Modelica.Mechanics.Translational.Components;
model IdealRollingWheel
  "Simple 1-dim. model of an ideal rolling wheel without inertia"
  extends Modelica.Mechanics.Rotational.Components.IdealRollingWheel;
  annotation (
    Documentation(info="<html>
<p>Couples rotational and translational motion, like an ideal rolling wheel, specifying the wheel radius.</p>
</html>"));
end IdealRollingWheel;
