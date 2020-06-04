within Modelica.Mechanics.MultiBody.Parts;
model BodyCylinder
  "Rigid body with cylinder shape. Mass and animation properties are computed from cylinder data and density (12 potential states)"

  import Modelica.Units.NonSI;
  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Math.Vectors.normalizeWithAssert;
  import Modelica.Units.Conversions.to_unit1;
  import Modelica.Constants.pi;

  Interfaces.Frame_a frame_a
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));
  parameter Boolean animation=true
    "= true, if animation shall be enabled (show cylinder between frame_a and frame_b)";
  parameter SI.Position r[3](start={0.1,0,0})
    "Vector from frame_a to frame_b, resolved in frame_a";
  parameter SI.Position r_shape[3]={0,0,0}
    "Vector from frame_a to cylinder origin, resolved in frame_a";
  parameter Modelica.Mechanics.MultiBody.Types.Axis lengthDirection=
    to_unit1(r - r_shape)
    "Vector in length direction of cylinder, resolved in frame_a"
    annotation (Evaluate=true);
  parameter SI.Length length=Modelica.Math.Vectors.length(r - r_shape)
    "Length of cylinder";
  parameter SI.Distance diameter=length/world.defaultWidthFraction
    "Diameter of cylinder";
  parameter SI.Distance innerDiameter=0
    "Inner diameter of cylinder (0 <= innerDiameter <= Diameter)";
  parameter SI.Density density=7700
    "Density of cylinder (e.g., steel: 7700 .. 7900, wood : 400 .. 800)";
  input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
    "Color of cylinder"
    annotation (Dialog(colorSelector=true, enable=animation));
  input Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(enable=animation));

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

  final parameter SI.Distance radius=diameter/2 "Radius of cylinder";
  final parameter SI.Distance innerRadius=innerDiameter/2
    "Inner-Radius of cylinder";
  final parameter SI.Mass mo(min=0) = density*pi*length*radius*radius
    "Mass of cylinder without hole";
  final parameter SI.Mass mi(min=0) = density*pi*length*innerRadius*
    innerRadius "Mass of hole of cylinder";
  final parameter SI.Inertia I22=(mo*(length*length + 3*radius*radius) - mi*(
      length*length + 3*innerRadius*innerRadius))/12
    "Inertia with respect to axis through center of mass, perpendicular to cylinder axis";
  final parameter SI.Mass m(min=0) = mo - mi "Mass of cylinder";
  final parameter Frames.Orientation R=Frames.from_nxy(r, {0,1,0})
    "Orientation object from frame_a to frame spanned by cylinder axis and axis perpendicular to cylinder axis";
  final parameter SI.Position r_CM[3]=r_shape +
      normalizeWithAssert(lengthDirection)*length/2
    "Position vector from frame_a to center of mass, resolved in frame_a";
  final parameter SI.Inertia I[3, 3]=Frames.resolveDyade1(R, diagonal({(mo*
      radius*radius - mi*innerRadius*innerRadius)/2,I22,I22}))
    "Inertia tensor of cylinder with respect to center of mass, resolved in frame parallel to frame_a";

  Body body(
    r_CM=r_CM,
    m=m,
    I_11=I[1, 1],
    I_22=I[2, 2],
    I_33=I[3, 3],
    I_21=I[2, 1],
    I_31=I[3, 1],
    I_32=I[3, 2],
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
    enforceStates=false) annotation (Placement(transformation(extent={{-30,-80},
            {10,-40}})));
  FixedTranslation frameTranslation(
    r=r,
    animation=animation,
    shapeType="pipecylinder",
    r_shape=r_shape,
    lengthDirection=lengthDirection,
    length=length,
    width=diameter,
    height=diameter,
    extra=innerDiameter/diameter,
    color=color,
    specularCoefficient=specularCoefficient,
    widthDirection={0,1,0}) annotation (Placement(transformation(extent={{-30,
            -20},{10,20}})));

protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  r_0 = frame_a.r_0;
  v_0 = der(r_0);
  a_0 = der(v_0);

  assert(innerDiameter < diameter,
    "parameter innerDiameter is greater than parameter diameter");
  connect(frameTranslation.frame_a, frame_a) annotation (Line(
      points={{-30,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(frameTranslation.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(frame_a, body.frame_a) annotation (Line(
      points={{-100,0},{-70,0},{-70,-60},{-30,-60}},
      color={95,95,95},
      thickness=0.5));
  annotation (Documentation(info="<html>
<p>
<strong>Rigid body</strong> with <strong>cylinder</strong> shape.
The mass properties of the body (mass, center of mass,
inertia tensor) are computed
from the cylinder data. Optionally, the cylinder may be hollow.
The cylinder shape is by default used in the animation.
The two connector frames <strong>frame_a</strong> and <strong>frame_b</strong>
are always parallel to each other. Example of component
animation (note, that
the animation may be switched off via parameter animation = <strong>false</strong>):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyCylinder.png\" alt=\"Parts.BodyCylinder\">
</div>

<p>
A BodyCylinder component has potential states. For details of these
states and of the \"Advanced\" menu parameters, see model
<a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">MultiBody.Parts.Body</a>.</p></html>"),
      Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{150,-80},{-150,-50}},
          textString="r=%r"),
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,24,48},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          radius=10),
        Text(
          extent={{-87,13},{-51,-12}},
          textString="a"),
        Text(
          extent={{51,12},{87,-13}},
          textString="b")}));
end BodyCylinder;
