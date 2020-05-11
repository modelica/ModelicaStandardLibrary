within Modelica.Mechanics.MultiBody.Joints;
model Spherical
  "Spherical joint (3 constraints and no potential states, or 3 degrees-of-freedom and 3 states)"

  import Modelica.Mechanics.MultiBody.Frames;

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Boolean animation=true
    "= true, if animation shall be enabled (show sphere)";
  parameter SI.Distance sphereDiameter=world.defaultJointLength
    "Diameter of sphere representing the spherical joint"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of sphere representing the spherical joint"
    annotation (Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

  parameter Boolean angles_fixed = false
    "= true, if angles_start are used as initial values, else as guess values"
    annotation(Evaluate=true, choices(checkBox=true), Dialog(tab="Initialization"));
  parameter SI.Angle angles_start[3]={0,0,0}
    "Initial values of angles to rotate frame_a around 'sequence_start' axes into frame_b"
    annotation (Dialog(tab="Initialization"));
  parameter Types.RotationSequence sequence_start={1,2,3}
    "Sequence of rotations to rotate frame_a into frame_b at initial time"
    annotation (Evaluate=true, Dialog(tab="Initialization"));

  parameter Boolean w_rel_a_fixed = false
    "= true, if w_rel_a_start are used as initial values, else as guess values"
    annotation(Evaluate=true, choices(checkBox=true), Dialog(tab="Initialization"));
  parameter SI.AngularVelocity w_rel_a_start[3]={0,0,0}
    "Initial values of angular velocity of frame_b with respect to frame_a, resolved in frame_a"
    annotation (Dialog(tab="Initialization"));

  parameter Boolean z_rel_a_fixed = false
    "= true, if z_rel_a_start are used as initial values, else as guess values"
    annotation(Evaluate=true, choices(checkBox=true), Dialog(tab="Initialization"));
  parameter SI.AngularAcceleration z_rel_a_start[3]={0,0,0}
    "Initial values of angular acceleration z_rel_a = der(w_rel_a)"
    annotation (Dialog(tab="Initialization"));

  parameter Boolean enforceStates=false
    "= true, if relative variables of spherical joint shall be used as states (StateSelect.always)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean useQuaternions=true
    "= true, if quaternions shall be used as states otherwise use 3 angles as states (provided enforceStates=true)"
    annotation (Evaluate=true, Dialog(tab="Advanced", enable=enforceStates));
  parameter Types.RotationSequence sequence_angleStates={1,2,3}
    "Sequence of rotations to rotate frame_a into frame_b around the 3 angles used as states"
     annotation (Evaluate=true, Dialog(tab="Advanced", enable=enforceStates
           and not useQuaternions));

  final parameter Frames.Orientation R_rel_start=
      Frames.axesRotations(sequence_start, angles_start, zeros(3))
    "Orientation object from frame_a to frame_b at initial time";

protected
  Visualizers.Advanced.Shape sphere(
    shapeType="sphere",
    color=sphereColor,
    specularCoefficient=specularCoefficient,
    length=sphereDiameter,
    width=sphereDiameter,
    height=sphereDiameter,
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    r_shape={-0.5,0,0}*sphereDiameter,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;

  // Declarations for quaternions (dummies, if quaternions are not used)
  parameter Frames.Quaternions.Orientation Q_start=
            Modelica.Mechanics.MultiBody.Frames.to_Q(R_rel_start)
    "Quaternion orientation object from frame_a to frame_b at initial time";
  Frames.Quaternions.Orientation Q(start=Q_start, each stateSelect=if
        enforceStates and useQuaternions then StateSelect.prefer else
        StateSelect.never)
    "Quaternion orientation object from frame_a to frame_b (dummy value, if quaternions are not used as states)";

  // Declaration for 3 angles
  parameter SI.Angle phi_start[3]=if sequence_start[1] ==
      sequence_angleStates[1] and sequence_start[2] == sequence_angleStates[2]
       and sequence_start[3] == sequence_angleStates[3] then angles_start else
       Frames.axesRotationsAngles(R_rel_start, sequence_angleStates)
    "Potential angle states at initial time";
  SI.Angle phi[3](start=phi_start, each stateSelect=if enforceStates and not
        useQuaternions then StateSelect.always else StateSelect.never)
    "Dummy or 3 angles to rotate frame_a into frame_b";
  SI.AngularVelocity phi_d[3](each stateSelect=if enforceStates and not
        useQuaternions then StateSelect.always else StateSelect.never)
    "= der(phi)";
  SI.AngularAcceleration phi_dd[3] "= der(phi_d)";

  // Other declarations
  SI.AngularVelocity w_rel[3](start=Frames.resolve2(R_rel_start, w_rel_a_start),
        fixed = fill(w_rel_a_fixed,3), each stateSelect=if
        enforceStates and useQuaternions then StateSelect.always else
        StateSelect.never)
    "Dummy or relative angular velocity of frame_b with respect to frame_a, resolved in frame_b";
  Frames.Orientation R_rel
    "Dummy or relative orientation object to rotate from frame_a to frame_b";
  Frames.Orientation R_rel_inv
    "Dummy or relative orientation object to rotate from frame_b to frame_a";
initial equation
  if angles_fixed then
    if not enforceStates then
      // no states defined in spherical object
      zeros(3) = Frames.Orientation.equalityConstraint(Frames.absoluteRotation(frame_a.R,R_rel_start),frame_b.R);
    elseif useQuaternions then
      // Quaternions Q are used as states
      zeros(3) = Frames.Quaternions.Orientation.equalityConstraint(Q, Q_start);
    else
      // The 3 angles 'phi' are used as states
      phi = phi_start;
    end if;
  end if;

  if z_rel_a_fixed then
    // Initialize acceleration variables
    der(w_rel) = Frames.resolve2(R_rel_start, z_rel_a_start);
  end if;
equation
  // torque balance
  zeros(3) = frame_a.t;
  zeros(3) = frame_b.t;

  if enforceStates then
    Connections.branch(frame_a.R, frame_b.R);

    frame_b.r_0 = frame_a.r_0;
    if Connections.rooted(frame_a.R) then
      R_rel_inv = Frames.nullRotation();
      frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
      zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
    else
      R_rel_inv = Frames.inverseRotation(R_rel);
      frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
      zeros(3) = frame_b.f + Frames.resolve2(R_rel, frame_a.f);
    end if;

    // Compute relative orientation object
    if useQuaternions then
      // Use Quaternions as states (with dynamic state selection)
      {0} = Frames.Quaternions.orientationConstraint(Q);
      w_rel = Frames.Quaternions.angularVelocity2(Q, der(Q));
      R_rel = Frames.from_Q(Q, w_rel);

      // Dummies
      phi = zeros(3);
      phi_d = zeros(3);
      phi_dd = zeros(3);

    else
      // Use angles as states
      phi_d = der(phi);
      phi_dd = der(phi_d);
      R_rel = Frames.axesRotations(sequence_angleStates, phi, phi_d);
      w_rel = Frames.angularVelocity2(R_rel);

      // Dummies
      Q = zeros(4);
    end if;

  else
    // Spherical joint does not have states
    frame_b.r_0 = frame_a.r_0;
    //frame_b.r_0 = transpose(frame_b.R.T)*(frame_b.R.T*(transpose(frame_a.R.T)*(frame_a.R.T*frame_a.r_0)));

    zeros(3) = frame_a.f + Frames.resolveRelative(frame_b.f, frame_b.R, frame_a.R);

    if w_rel_a_fixed or z_rel_a_fixed then
      w_rel = Frames.angularVelocity2(frame_b.R) - Frames.resolve2(frame_b.R,
         Frames.angularVelocity1(frame_a.R));
    else
      w_rel = zeros(3);
    end if;

    // Dummies
    R_rel = Frames.nullRotation();
    R_rel_inv = Frames.nullRotation();
    Q = zeros(4);
    phi = zeros(3);
    phi_d = zeros(3);
    phi_dd = zeros(3);
  end if;
  annotation (
    Documentation(info="<html>
<p>
Joint with <strong>3 constraints</strong> that define that the origin of
frame_a and the origin of frame_b coincide. By default this joint
defines only the 3 constraints without any potential states.
If parameter <strong>enforceStates</strong> is set to <strong>true</strong>
in the \"Advanced\" menu, three states are introduced.
Depending on parameter <strong>useQuaternions</strong> these are either
quaternions and the relative angular velocity or 3 angles
and the angle derivatives. In the latter case the orientation
of frame_b is computed by rotating frame_a along the axes defined
in parameter vector \"sequence_angleStates\" (default = {1,2,3}, i.e.,
the Cardan angle sequence) around the angles used as states.
For example, the default is to rotate the x-axis of frame_a
around angles[1], the new y-axis around angles[2] and the new z-axis
around angles[3], arriving at frame_b. If angles are used
as states there is the slight disadvantage that
a singular configuration is present leading to a division by zero.
</p>
<p>
If this joint is used in a <strong>chain</strong> structure, a Modelica translator
has to select orientation coordinates of a body as states, if the
default setting is used. It is usually better to use relative coordinates
in the spherical joint as states, and therefore in this situation
parameter enforceStates might be set to <strong>true</strong>.
</p>
<p>
If this joint is used in a <strong>loop</strong> structure, the default
setting results in a <strong>cut-joint</strong> that
breaks the loop in independent kinematic pieces, hold together
by the constraints of this joint. As a result, a Modelica translator
will first try to select 3 generalized coordinates in the joints of
the remaining parts of the loop and their first derivative as states
and if this is not possible, e.g., because there are only spherical
joints in the loop, will select coordinates from a body of the loop
as states.
</p>
<p>
In the following figure the animation of a spherical
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint.
(here: angles_start = {45, 45, 45}<sup>o</sup>).
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Spherical.png\">
</div>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-70,-70},{70,70}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-49,-50},{51,50}},
          lineColor={128,128,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,70},{71,-68}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,10},{-68,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{23,10},{100,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-24,25},{26,-25}},
          fillPattern=FillPattern.Sphere,
          fillColor={160,160,164}),
        Text(
          extent={{-150,-115},{150,-75}},
          textString="%name",
          textColor={0,0,255})}));
end Spherical;
