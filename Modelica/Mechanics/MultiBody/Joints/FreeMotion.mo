within Modelica.Mechanics.MultiBody.Joints;
model FreeMotion
  "Free motion joint (6 degrees-of-freedom, 12 potential states)"

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show arrow from frame_a to frame_b)";

  SI.Position r_rel_a[3](start={0,0,0}, each stateSelect=if enforceStates then
              StateSelect.always else StateSelect.prefer)
    "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v_rel_a[3](start={0,0,0}, each stateSelect=if enforceStates then StateSelect.always else
              StateSelect.prefer)
    "= der(r_rel_a), i.e., velocity of origin of frame_b with respect to origin of frame_a, resolved in frame_a"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Acceleration a_rel_a[3](start={0,0,0}) "= der(v_rel_a)"
    annotation(Dialog(group="Initialization", showStartAttribute=true));

  parameter Boolean angles_fixed = false
    "= true, if angles_start are used as initial values, else as guess values"
    annotation(Evaluate=true, choices(checkBox=true), Dialog(group="Initialization"));
  parameter SI.Angle angles_start[3]={0,0,0}
    "Initial values of angles to rotate frame_a around 'sequence_start' axes into frame_b"
    annotation (Dialog(group="Initialization"));
  parameter Types.RotationSequence sequence_start={1,2,3}
    "Sequence of rotations to rotate frame_a into frame_b at initial time"
    annotation (Evaluate=true, Dialog(group="Initialization"));

  parameter Boolean w_rel_a_fixed = false
    "= true, if w_rel_a_start are used as initial values, else as guess values"
    annotation(Evaluate=true, choices(checkBox=true), Dialog(group="Initialization"));
  parameter SI.AngularVelocity w_rel_a_start[3]={0,0,0}
    "Initial values of angular velocity of frame_b with respect to frame_a, resolved in frame_a"
    annotation (Dialog(group="Initialization"));

  parameter Boolean z_rel_a_fixed = false
    "= true, if z_rel_a_start are used as initial values, else as guess values"
    annotation(Evaluate=true, choices(checkBox=true), Dialog(group="Initialization"));
  parameter SI.AngularAcceleration z_rel_a_start[3]={0,0,0}
    "Initial values of angular acceleration z_rel_a = der(w_rel_a)"
    annotation (Dialog(group="Initialization"));

  input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
    "Color of arrow"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter Boolean enforceStates=true
    "= true, if relative variables between frame_a and frame_b shall be used as states"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean useQuaternions=true
    "= true, if quaternions shall be used as states otherwise use 3 angles as states"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Types.RotationSequence sequence_angleStates={1,2,3}
    "Sequence of rotations to rotate frame_a into frame_b around the 3 angles used as states"
     annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
          useQuaternions));

  final parameter Frames.Orientation R_rel_start=
      Modelica.Mechanics.MultiBody.Frames.axesRotations(sequence_start, angles_start,zeros(3))
    "Orientation object from frame_a to frame_b at initial time";

protected
  Visualizers.Advanced.Arrow arrow(
    r_head=r_rel_a,
    color=arrowColor,
    specularCoefficient=specularCoefficient,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;

  // Declarations for quaternions (dummies, if quaternions are not used)
  parameter Frames.Quaternions.Orientation Q_start=Frames.to_Q(R_rel_start)
    "Quaternion orientation object from frame_a to frame_b at initial time";
  Frames.Quaternions.Orientation Q(start=Q_start, each stateSelect=if
        enforceStates then (if useQuaternions then StateSelect.prefer else
        StateSelect.never) else StateSelect.default)
    "Quaternion orientation object from frame_a to frame_b (dummy value, if quaternions are not used as states)";

  // Declaration for 3 angles
  parameter SI.Angle phi_start[3]=if sequence_start[1] ==
      sequence_angleStates[1] and sequence_start[2] == sequence_angleStates[2]
       and sequence_start[3] == sequence_angleStates[3] then angles_start else
            Frames.axesRotationsAngles(R_rel_start,
      sequence_angleStates) "Potential angle states at initial time";
  SI.Angle phi[3](start=phi_start, each stateSelect=if enforceStates then (if
        useQuaternions then StateSelect.never else StateSelect.always) else
        StateSelect.prefer)
    "Dummy or 3 angles to rotate frame_a into frame_b";
  SI.AngularVelocity phi_d[3](each stateSelect=if enforceStates then (if
        useQuaternions then StateSelect.never else StateSelect.always) else
        StateSelect.prefer) "= der(phi)";
  SI.AngularAcceleration phi_dd[3] "= der(phi_d)";

  // Other declarations
  SI.AngularVelocity w_rel_b[3](start=Frames.resolve2(R_rel_start, w_rel_a_start),
                                fixed=fill(w_rel_a_fixed,3),
                                each stateSelect=if enforceStates then
                                (if useQuaternions then StateSelect.always else
                                StateSelect.avoid) else StateSelect.prefer)
    "Dummy or relative angular velocity of frame_b with respect to frame_a, resolved in frame_b";
  Frames.Orientation R_rel
    "Dummy or relative orientation object to rotate from frame_a to frame_b";
  Frames.Orientation R_rel_inv
    "Dummy or relative orientation object to rotate from frame_b to frame_a";

initial equation
  if angles_fixed then
    // Initialize positional variables
    if not enforceStates then
      // no states defined
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
    der(w_rel_b) = Frames.resolve2(R_rel_start, z_rel_a_start);
  end if;

equation
  // Kinematic differential equations for translational motion
  der(r_rel_a) = v_rel_a;
  der(v_rel_a) = a_rel_a;

  // Kinematic relationships
  frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r_rel_a);

  // Cut-forces and cut-torques are zero
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.f = zeros(3);
  frame_b.t = zeros(3);

  if enforceStates then
    Connections.branch(frame_a.R, frame_b.R);

    if Connections.rooted(frame_a.R) then
      R_rel_inv = Frames.nullRotation();
      frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
    else
      R_rel_inv = Frames.inverseRotation(R_rel);
      frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
    end if;

    // Compute relative orientation object
    if useQuaternions then
      // Use Quaternions as states (with dynamic state selection)
      {0} = Frames.Quaternions.orientationConstraint(Q);
      w_rel_b = Frames.Quaternions.angularVelocity2(Q, der(Q));
      R_rel = Frames.from_Q(Q, w_rel_b);

      // Dummies
      phi = zeros(3);
      phi_d = zeros(3);
      phi_dd = zeros(3);

    else
      // Use angles as states
      phi_d = der(phi);
      phi_dd = der(phi_d);
      R_rel = Frames.axesRotations(sequence_angleStates, phi, phi_d);
      w_rel_b = Frames.angularVelocity2(R_rel);

      // Dummies
      Q = zeros(4);
    end if;

  else
    // Free motion joint does not have states
    if w_rel_a_fixed or z_rel_a_fixed then
      w_rel_b = Frames.angularVelocity2(frame_b.R) - Frames.resolve2(frame_b.
        R, Frames.angularVelocity1(frame_a.R));
    else
      // dummy
      w_rel_b = zeros(3);
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
Joint which does not constrain the motion between frame_a and frame_b.
Such a joint is only meaningful if the <strong>relative</strong> distance and orientation
between frame_a and frame_b, and their derivatives, shall be used
as <strong>states</strong>.
</p>
<p>
Note, that <strong>bodies</strong> such as Parts.Body, Parts.BodyShape,
have potential states describing the distance
and orientation, and their derivatives, between the <strong>world frame</strong> and
a <strong>body fixed frame</strong>.
Therefore, if these potential state variables are suited,
a FreeMotion joint is not needed.
</p>
<p>
The states of the FreeMotion object are:
</p>
<ul>
<li> The <strong>relative position vector</strong> r_rel_a from the origin of
     frame_a to the origin of frame_b, resolved in
     frame_a and the <strong>relative velocity</strong> v_rel_a of the origin of
     frame_b with respect to the origin of frame_a, resolved in frame_a
     (= der(r_rel_a)).
</li>
<li> If parameter <strong>useQuaternions</strong> in the \"Advanced\" menu
     is <strong>true</strong> (this is the default), then <strong>4 quaternions</strong>
     are states. Additionally, the coordinates of the
     relative angular velocity vector are 3 potential states.<br>
     If <strong>useQuaternions</strong> in the \"Advanced\" menu
     is <strong>false</strong>, then <strong>3 angles</strong> and the derivatives of
     these angles are potential states. The orientation of frame_b
     is computed by rotating frame_a along the axes defined
     in parameter vector \"sequence_angleStates\" (default = {1,2,3}, i.e.,
     the Cardan angle sequence) around the angles used as states.
     For example, the default is to rotate the x-axis of frame_a
     around angles[1], the new y-axis around angles[2] and the new z-axis
     around angles[3], arriving at frame_b.
 </li>
</ul>
<p>
The quaternions have the slight disadvantage that there is a
non-linear constraint equation between the 4 quaternions.
Therefore, at least one non-linear equation has to be solved
during simulation. A tool might, however, analytically solve this
simple constraint equation. Using the 3 angles as states has the
disadvantage that there is a singular configuration in which a
division by zero will occur. If it is possible to determine in advance
for an application class that this singular configuration is outside
of the operating region, the 3 angles might be used as
states by setting <strong>useQuaternions</strong> = <strong>false</strong>.
</p>
<p>
In text books about 3-dimensional mechanics often 3 angles and the
angular velocity are used as states. This is not the case here, since
3 angles and their derivatives are used as states
(if useQuaternions = false). The reason
is that for real-time simulation the discretization formula of the
integrator might be \"inlined\" and solved together with the model equations.
By appropriate symbolic transformation the performance is
drastically increased if angles and their
derivatives are used as states, instead of angles and the angular
velocity.
</p>
<p>
If parameter
<strong>enforceStates</strong> is set to <strong>true</strong> (= the default)
in the \"Advanced\" menu,
then FreeMotion variables are forced to be used as states according
to the setting of parameters \"useQuaternions\" and
\"sequence_angleStates\".
</p>
<p>
In the following figure the animation of a FreeMotion
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint.
(here: r_rel_a_start = {0.5, 0, 0.5}, angles_start = {45, 45, 45}<sup>o</sup>).
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/FreeMotion.png\">
</div>

</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{-86,31},{-74,61},{-49,83},{-17,92},{19,88},{40,69},{59,48}},
          color={160,160,164},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Polygon(
          points={{90,0},{50,20},{50,-20},{90,0}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{69,58},{49,40},{77,28},{69,58}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{150,-35},{-150,-75}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-70,-5},{-90,5}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,-5},{30,5}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{11,-5},{-9,5}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,-5},{-50,5}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}));
end FreeMotion;
