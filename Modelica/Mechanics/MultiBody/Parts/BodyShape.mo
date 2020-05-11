within Modelica.Mechanics.MultiBody.Parts;
model BodyShape
  "Rigid body with mass, inertia tensor, different shapes for animation, and two frame connectors (12 potential states)"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_a frame_a
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show shape between frame_a and frame_b and optionally a sphere at the center of mass)";
  parameter Boolean animateSphere=true
    "= true, if mass shall be animated as sphere provided animation=true";
  parameter SI.Position r[3](start={0,0,0})
    "Vector from frame_a to frame_b resolved in frame_a";
  parameter SI.Position r_CM[3](start={0,0,0})
    "Vector from frame_a to center of mass, resolved in frame_a";
  parameter SI.Mass m(min=0, start=1) "Mass of rigid body";
  parameter SI.Inertia I_11(min=0) = 0.001 "Element (1,1) of inertia tensor"
    annotation (Dialog(group="Inertia tensor (resolved in center of mass, parallel to frame_a)"));
  parameter SI.Inertia I_22(min=0) = 0.001 "Element (2,2) of inertia tensor"
    annotation (Dialog(group="Inertia tensor (resolved in center of mass, parallel to frame_a)"));
  parameter SI.Inertia I_33(min=0) = 0.001 "Element (3,3) of inertia tensor"
    annotation (Dialog(group="Inertia tensor (resolved in center of mass, parallel to frame_a)"));
  parameter SI.Inertia I_21(min=-C.inf) = 0 "Element (2,1) of inertia tensor"
    annotation (Dialog(group="Inertia tensor (resolved in center of mass, parallel to frame_a)"));
  parameter SI.Inertia I_31(min=-C.inf) = 0 "Element (3,1) of inertia tensor"
    annotation (Dialog(group="Inertia tensor (resolved in center of mass, parallel to frame_a)"));
  parameter SI.Inertia I_32(min=-C.inf) = 0 "Element (3,2) of inertia tensor"
    annotation (Dialog(group="Inertia tensor (resolved in center of mass, parallel to frame_a)"));

  SI.Position r_0[3](start={0,0,0}, each stateSelect=if enforceStates then
        StateSelect.always else StateSelect.avoid)
    "Position vector from origin of world frame to origin of frame_a"
    annotation (Dialog(tab="Initialization",showStartAttribute=true));
  SI.Velocity v_0[3](start={0,0,0}, each stateSelect=if enforceStates then
        StateSelect.always else StateSelect.avoid)
    "Absolute velocity of frame_a, resolved in world frame (= der(r_0))"
    annotation (Dialog(tab="Initialization",showStartAttribute=true));
  SI.Acceleration a_0[3](start={0,0,0})
    "Absolute acceleration of frame_a resolved in world frame (= der(v_0))"
    annotation (Dialog(tab="Initialization",showStartAttribute=true));

  parameter Boolean angles_fixed=false
    "= true, if angles_start are used as initial values, else as guess values"
    annotation (
    Evaluate=true,
    choices(checkBox=true),
    Dialog(tab="Initialization"));
  parameter SI.Angle angles_start[3]={0,0,0}
    "Initial values of angles to rotate world frame around 'sequence_start' axes into frame_a"
    annotation (Dialog(tab="Initialization"));
  parameter Types.RotationSequence sequence_start={1,2,3}
    "Sequence of rotations to rotate world frame into frame_a at initial time"
    annotation (Evaluate=true, Dialog(tab="Initialization"));

  parameter Boolean w_0_fixed=false
    "= true, if w_0_start are used as initial values, else as guess values"
    annotation (
    Evaluate=true,
    choices(checkBox=true),
    Dialog(tab="Initialization"));
  parameter SI.AngularVelocity w_0_start[3]={0,0,0}
    "Initial or guess values of angular velocity of frame_a resolved in world frame"
    annotation (Dialog(tab="Initialization"));

  parameter Boolean z_0_fixed=false
    "= true, if z_0_start are used as initial values, else as guess values"
    annotation (
    Evaluate=true,
    choices(checkBox=true),
    Dialog(tab="Initialization"));
  parameter SI.AngularAcceleration z_0_start[3]={0,0,0}
    "Initial values of angular acceleration z_0 = der(w_0)"
    annotation (Dialog(tab="Initialization"));

  parameter Types.ShapeType shapeType="cylinder" "Type of shape" annotation (
     Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Position r_shape[3]={0,0,0}
    "Vector from frame_a to shape origin, resolved in frame_a" annotation (
      Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Types.Axis lengthDirection = to_unit1(r - r_shape)
    "Vector in length direction of shape, resolved in frame_a" annotation (
      Evaluate=true, Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Types.Axis widthDirection={0,1,0}
    "Vector in width direction of shape, resolved in frame_a" annotation (
      Evaluate=true, Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Length length=Modelica.Math.Vectors.length(r - r_shape)
    "Length of shape" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Distance width=length/world.defaultWidthFraction
    "Width of shape" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Distance height=width "Height of shape" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Types.ShapeExtra extra=0.0
    "Additional parameter depending on shapeType (see docu of Visualizers.Advanced.Shape)"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
    "Color of shape" annotation (Dialog(
      colorSelector=true,
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Diameter sphereDiameter=2*width "Diameter of sphere"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true and animateSphere = true",
      enable=animation and animateSphere));
  input Types.Color sphereColor=color "Color of sphere of mass" annotation (
      Dialog(
      colorSelector=true,
      tab="Animation",
      group="if animation = true and animateSphere = true",
      enable=animation and animateSphere));
  input Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Boolean enforceStates=false
    "= true, if absolute variables of body object shall be used as states (StateSelect.always)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean useQuaternions=true
    "= true, if quaternions shall be used as potential states otherwise use 3 angles as potential states"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Types.RotationSequence sequence_angleStates={1,2,3}
    "Sequence of rotations to rotate world frame into frame_a around the 3 angles used as potential states"
    annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
          useQuaternions));

  FixedTranslation frameTranslation(r=r, animation=false) annotation (
      Placement(transformation(extent={{-20,-20},{20,20}})));
  Body body(
    r_CM=r_CM,
    m=m,
    I_11=I_11,
    I_22=I_22,
    I_33=I_33,
    I_21=I_21,
    I_31=I_31,
    I_32=I_32,
    animation=false,
    sequence_start=sequence_start,
    angles_fixed=angles_fixed,
    angles_start=angles_start,
    w_0_fixed=w_0_fixed,
    w_0_start=w_0_start,
    z_0_fixed=z_0_fixed,
    z_0_start=z_0_start,
    useQuaternions=useQuaternions,
    sequence_angleStates=sequence_angleStates,
    enforceStates=false) annotation (Placement(transformation(extent={{-27.3333,
            -70.3333},{13,-30}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;
  Visualizers.Advanced.Shape shape1(
    shapeType=shapeType,
    color=color,
    specularCoefficient=specularCoefficient,
    length=length,
    width=width,
    height=height,
    lengthDirection=lengthDirection,
    widthDirection=widthDirection,
    r_shape=r_shape,
    extra=extra,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape2(
    shapeType="sphere",
    color=sphereColor,
    specularCoefficient=specularCoefficient,
    length=sphereDiameter,
    width=sphereDiameter,
    height=sphereDiameter,
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    r_shape=r_CM - {1,0,0}*sphereDiameter/2,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation and animateSphere;
equation
  r_0 = frame_a.r_0;
  v_0 = der(r_0);
  a_0 = der(v_0);
  connect(frame_a, frameTranslation.frame_a) annotation (Line(
      points={{-100,0},{-20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(frame_b, frameTranslation.frame_b) annotation (Line(
      points={{100,0},{20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(frame_a, body.frame_a) annotation (Line(
      points={{-100,0},{-60,0},{-60,-50.1666},{-27.3333,-50.1666}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
<strong>Rigid body</strong> with mass and inertia tensor and <strong>two frame connectors</strong>.
All parameter vectors have to be resolved in frame_a.
The <strong>inertia tensor</strong> has to be defined with respect to a
coordinate system that is parallel to frame_a with the
origin at the center of mass of the body. The coordinate system <strong>frame_b</strong>
is always parallel to <strong>frame_a</strong>.
</p>
<p>
By default, this component is visualized by any <strong>shape</strong> that can be
defined with Modelica.Mechanics.MultiBody.Visualizers.FixedShape. This shape is placed
between frame_a and frame_b (default: length(shape) = Frames.length(r)).
Additionally a <strong>sphere</strong> may be visualized that has
its center at the center of mass.
Note, that
the animation may be switched off via parameter animation = <strong>false</strong>.
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyShape.png\" alt=\"Parts.BodyShape\">
</div>

<p>
The following shapes can be defined via parameter <strong>shapeType</strong>,
e.g., shapeType=\"cone\":
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/FixedShape.png\" alt=\"Visualizers.FixedShape\">
</div>

<p>
A BodyShape component has potential states. For details of these
states and of the \"Advanced\" menu parameters, see model
<a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">MultiBody.Parts.Body</a>.
</p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,110},{150,70}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-100},{150,-70}},
          textString="r=%r"),
        Rectangle(
          extent={{-100,30},{101,-30}},
          lineColor={0,24,48},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          radius=10),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,24,48},
          fillPattern=FillPattern.Sphere,
          fillColor={0,127,255}),
        Text(
          extent={{-50,24},{55,-27}},
          textString="%m"),
        Text(
          extent={{55,12},{91,-13}},
          textString="b"),
        Text(
          extent={{-92,13},{-56,-12}},
          textString="a")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,9},{-100,43}}, color={128,128,128}),
        Line(points={{100,0},{100,44}}, color={128,128,128}),
        Line(points={{-100,40},{90,40}}, color={135,135,135}),
        Polygon(
          points={{90,44},{90,36},{100,40},{90,44}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,68},{20,40}},
          textColor={128,128,128},
          textString="r"),
        Line(points={{-100,-10},{-100,-90}}, color={128,128,128}),
        Line(points={{-100,-84},{-10,-84}}, color={128,128,128}),
        Polygon(
          points={{-10,-80},{-10,-88},{0,-84},{-10,-80}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-82,-66},{-56,-84}},
          textColor={128,128,128},
          textString="r_CM"),
        Line(points={{0,-46},{0,-90}}, color={128,128,128})}));
end BodyShape;
