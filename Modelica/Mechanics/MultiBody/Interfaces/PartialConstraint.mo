within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialConstraint
  "Base model for elementary constraints"
  extends PartialTwoFrames;

  parameter Boolean x_locked=true
    "= true, if constraint force in x-direction, resolved in frame_a"
    annotation (Dialog(group="Constrain translational motion"), choices(checkBox=true));
  parameter Boolean y_locked=true
    "= true, if constraint force in y-direction, resolved in frame_a"
    annotation (Dialog(group="Constrain translational motion"), choices(checkBox=true));
  parameter Boolean z_locked=true
    "= true, if constraint force in z-direction, resolved in frame_a"
    annotation (Dialog(group="Constrain translational motion"), choices(checkBox=true));

protected
  SI.Position r_rel_a[3]
    "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a";
  Frames.Orientation R_rel
    "Relative orientation object from frame_a to frame_b";
  SI.InstantaneousPower P "Instantaneous power";

equation
  // Determine relative position and orientation
  r_rel_a = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
  R_rel = Frames.relativeRotation(frame_a.R, frame_b.R);

  // Constraint equations concerning translations
  if x_locked then
    r_rel_a[1]=0;
  else
    frame_a.f[1]=0;
  end if;

  if y_locked then
    r_rel_a[2]=0;
  else
    frame_a.f[2]=0;
  end if;

  if z_locked then
    r_rel_a[3]=0;
  else
    frame_a.f[3]=0;
  end if;

  // Force and torque balance
  zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
  zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t) - cross(r_rel_a, frame_a.f);
  // - cross(r_rel_a, frame_a.f) gives the same result like cross(r_rel_a, Frames.resolve1(R_rel, frame_b.f))

  // Instantaneous power
  P = frame_a.t * Frames.angularVelocity2(frame_a.R) +
      frame_b.t * Frames.angularVelocity2(frame_b.R) +
      frame_a.f * Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
      frame_b.f * Frames.resolve2(frame_b.R, der(frame_b.r_0));

  annotation (Documentation(info="<html>
<p>
All <strong>elementary joints defined by constraints</strong> should inherit
from this base model, i.e., joints that are directly defined by constraint
equations between the two frames.
</p>
<p>
This partial model provides relative kinematic quantities <code>r_rel_a</code>
and <code>R_rel</code> between the two frame connectors <code>frame_a</code>
and <code>frame_b</code>, and basic equations constraining translational movement.
The inheriting class shall additionally provide corresponding equations
constraining rotational movement.
</p>
</html>
"));
end PartialConstraint;
