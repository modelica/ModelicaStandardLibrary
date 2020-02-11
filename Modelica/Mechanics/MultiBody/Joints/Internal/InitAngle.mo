within Modelica.Mechanics.MultiBody.Joints.Internal;
model InitAngle
 "Internal model to initialize the angels for Joints.FreeMotionScalarInit"
  extends Modelica.Blocks.Icons.Block;

  import Modelica.Mechanics.MultiBody.Frames;

  parameter Modelica.Mechanics.MultiBody.Types.RotationSequence sequence_start={1,2,3}
   "Sequence of angle rotations";

  Interfaces.Frame_a frame_a
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  Frames.Orientation R_rel
   "Relative orientation object to rotate from frame_a to frame_b";
  Frames.Orientation R_rel_inv
   "Relative orientation object to rotate from frame_b to frame_a";

  Blocks.Interfaces.RealOutput angle[3](each final quantity="Angle", each final unit="rad") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
equation
  Connections.branch(frame_a.R, frame_b.R);
  R_rel = Frames.axesRotations(sequence_start,
                               {angle[1], angle[2], angle[3]},
                               {der(angle[1]), der(angle[2]), der(angle[3])});
  if Connections.rooted(frame_a.R) then
     R_rel_inv = Frames.nullRotation();
     frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
  else
     R_rel_inv = Frames.inverseRotation(R_rel);
     frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
  end if;

  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.f = zeros(3);
  frame_b.t = zeros(3);

  annotation (Icon(graphics={Text(
         extent={{-84,-58},{86,-86}},
         textString="angle")}), Documentation(info="<html>
<p>
Compute three rotational angles <strong>angle</strong> for a given rotational sequence
<strong>sequence_start</strong> from a relative orientation from frame_a to frame_b.
</p>
</html>"));
end InitAngle;
