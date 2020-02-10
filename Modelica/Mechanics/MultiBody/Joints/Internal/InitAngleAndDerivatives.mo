within Modelica.Mechanics.MultiBody.Joints.Internal;
model InitAngleAndDerivatives "Internal model to initialize the angels and their derivatives for Joints.FreeMotionScalarInit"
  extends Interfaces.PartialTwoFrames;
  extends Modelica.Blocks.Icons.Block;

  import Modelica.Units.SI;
  import Modelica.Mechanics.MultiBody.Frames;

  parameter Modelica.Mechanics.MultiBody.Types.RotationSequence sequence_start={1,2,3}
    "Sequence of angle rotations";
  parameter Boolean statesAngle=false
    "= true, if at least one element of angle shall be used as state"
    annotation(Evaluate=true);
  parameter Boolean statesAngleDer=false
    "= true, if at least one element of angle derivatives shall be used as state"
    annotation(Evaluate=true);

  Frames.Orientation R_rel
    "Relative orientation object to rotate from frame_a to frame_b";
  Frames.Orientation R_rel_inv
    "Relative orientation object to rotate from frame_b to frame_a";

  Blocks.Interfaces.RealOutput angle[3](each final quantity="Angle", each final unit="rad") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
  Blocks.Interfaces.RealOutput angleDer[3](each final quantity="AngularVelocity", each final unit="rad/s") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-110})));
protected
  SI.AngularVelocity w[3]
    "Relative angular velocity of frame_b with respect to frame_a resolved in frame_a";

initial equation
  if not statesAngle and statesAngleDer then
    angle = Frames.axesRotationsAngles(R_rel, sequence_start, 0);
  end if;

equation
  if statesAngle then
    // At least one element of vector angle is (potential) state
    Connections.branch(frame_a.R, frame_b.R);

    R_rel = Frames.axesRotations(sequence_start, angle, angleDer);
    angleDer = der(angle);
    w = zeros(3);

    if Connections.rooted(frame_a.R) then
      R_rel_inv = Frames.nullRotation();
      frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
    else
      R_rel_inv = Frames.inverseRotation(R_rel);
      frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
    end if;

  else
    // None element of vector angle is state
    R_rel_inv = Frames.nullRotation();
    R_rel = Frames.relativeRotation(frame_a.R,frame_b.R);
    w = Frames.Internal.from_anglesd(sequence_start, angle, angleDer);
    w = Modelica.Mechanics.MultiBody.Frames.angularVelocity1(R_rel);

    if statesAngleDer then
      // At least one element of vector angleDer is (potential) state
      // (angle is initialized using an initial equation)
      angleDer = der(angle);
    else
      // None element of angle and angleDer is state
      angle = Frames.axesRotationsAngles(R_rel, sequence_start, 0);
    end if;

  end if;

  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.f = zeros(3);
  frame_b.t = zeros(3);

  annotation (
    Icon(graphics={Text(
         extent={{-84,-58},{86,-86}},
         textString="angle")}),
    Documentation(info="<html>
<p>
Compute three rotational angles <code>angle</code> and their derivatives
<code>angleDer</code> for a&nbsp;given rotational sequence
<code>sequence_start</code> from a&nbsp;relative orientation from
<code>frame_a</code> to <code>frame_b</code>.
The calculation of both <code>angle</code> and <code>angleDer</code>
depends on whether at least one element of these variables is a&nbsp;state
or not.
This decision must be made in the class which uses this block and
indicated accordingly in <code>statesAngle</code> and&nbsp;/&nbsp;or
<code>statesAngleDer</code>.
</p>
</html>"));
end InitAngleAndDerivatives;
