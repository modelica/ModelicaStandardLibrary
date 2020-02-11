within Modelica.Mechanics.MultiBody.Interfaces;
partial model LineForceBase "Base model for line force elements"
  extends PartialTwoFrames;
  parameter SI.Distance s_small=1e-10
    "Prevent zero-division if distance between frame_a and frame_b is zero"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean fixedRotationAtFrame_a=false
    "= true, if rotation frame_a.R is fixed (to directly connect line forces)"
     annotation (Evaluate=true, choices(checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));
  parameter Boolean fixedRotationAtFrame_b=false
    "= true, if rotation frame_b.R is fixed (to directly connect line forces)"
     annotation (Evaluate=true, choices(checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));

  SI.Distance length
    "Distance between the origin of frame_a and the origin of frame_b";
  SI.Position s
    "(Guarded) distance between the origin of frame_a and the origin of frame_b (>= s_small))";
  SI.Position r_rel_0[3]
    "Position vector from frame_a to frame_b resolved in world frame";
  Real e_rel_0[3](each final unit="1")
    "Unit vector in direction from frame_a to frame_b, resolved in world frame";
equation
  assert(noEvent(length > s_small), "
The distance between the origin of frame_a and the origin of frame_b
of a line force component became smaller as parameter s_small
(= a small number, defined in the \"Advanced\" menu). The distance is
set to s_small, although it is smaller, to avoid a division by zero
when computing the direction of the line force. Possible reasons
for this situation:
- At initial time the distance may already be zero: Change the initial
  positions of the bodies connected by this element.
- Hardware stops are not modeled or are modeled not stiff enough.
  Include stops, e.g., stiff springs, or increase the stiffness
  if already present.
- Another error in your model may lead to unrealistically large forces
  and torques that would in reality destroy the stops.
- The flange_b connector might be defined by a pre-defined motion,
  e.g., with Modelica.Mechanics.Translational.Position and the
  predefined flange_b.s is zero or negative.
");

  // Determine relative position vector between the two frames
  r_rel_0 = frame_b.r_0 - frame_a.r_0;
  length = Modelica.Math.Vectors.length(r_rel_0);
  s = Frames.Internal.maxWithoutEvent(length, s_small);
  e_rel_0 = r_rel_0/s;

  // Additional equations, if direct connections of line forces
  if fixedRotationAtFrame_a then
    Connections.root(frame_a.R);
    frame_a.R = Frames.nullRotation();
  else
    frame_a.t = zeros(3);
  end if;

  if fixedRotationAtFrame_b then
    Connections.root(frame_b.R);
    frame_b.R = Frames.nullRotation();
  else
    frame_b.t = zeros(3);
  end if;

  annotation (Documentation(info="<html>
<p>
All <strong>line force</strong> elements should be based on this base model.
This model defines frame_a and frame_b and computes the (guarded) relative
distance <strong>s</strong>. An assertion is raised if the relative
distance <strong>length</strong> became smaller as parameter <strong>s_small</strong>.
</p>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(visible=fixedRotationAtFrame_a, extent={{-70,30},{-130,-30}}, lineColor={255,0,0}),
        Text(visible=fixedRotationAtFrame_a,
          extent={{-62,50},{-140,30}},
          textColor={255,0,0},
          textString="R=0"),
        Ellipse(visible=fixedRotationAtFrame_b, extent={{70,30},{130,-30}}, lineColor={255,0,0}),
        Text(visible=fixedRotationAtFrame_b,
          extent={{62,50},{140,30}},
          textColor={255,0,0},
          textString="R=0")}));
end LineForceBase;
