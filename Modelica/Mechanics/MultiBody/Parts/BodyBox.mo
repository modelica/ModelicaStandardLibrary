within Modelica.Mechanics.MultiBody.Parts;
model BodyBox
  "Rigid body with box shape. Mass and animation properties are computed from box data and density (12 potential states)"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Math.Vectors.normalizeWithAssert;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_a frame_a
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));
  parameter Boolean animation=true
    "= true, if animation shall be enabled (show box between frame_a and frame_b)";
  parameter SI.Position r[3](start={0.1,0,0})
    "Vector from frame_a to frame_b resolved in frame_a";
  parameter SI.Position r_shape[3]={0,0,0}
    "Vector from frame_a to box origin, resolved in frame_a";
  parameter Modelica.Mechanics.MultiBody.Types.Axis lengthDirection=
     to_unit1(r - r_shape)
    "Vector in length direction of box, resolved in frame_a"
    annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis widthDirection={0,1,0}
    "Vector in width direction of box, resolved in frame_a"
    annotation (Evaluate=true);
  parameter SI.Length length=Modelica.Math.Vectors.length(r - r_shape)
    "Length of box";
  parameter SI.Distance width=length/world.defaultWidthFraction
    "Width of box";
  parameter SI.Distance height=width "Height of box";
  parameter SI.Distance innerWidth=0
    "Width of inner box surface (0 <= innerWidth <= width)";
  parameter SI.Distance innerHeight=innerWidth
    "Height of inner box surface (0 <= innerHeight <= height)";
  parameter SI.Density density=7700
    "Density of cylinder (e.g., steel: 7700 .. 7900, wood : 400 .. 800)";
  input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
    "Color of box" annotation (Dialog(colorSelector=true, enable=animation));
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

  final parameter SI.Mass mo(min=0) = density*length*width*height
    "Mass of box without hole";
  final parameter SI.Mass mi(min=0) = density*length*innerWidth*innerHeight
    "Mass of hole of box";
  final parameter SI.Mass m(min=0) = mo - mi "Mass of box";
  final parameter Frames.Orientation R=Frames.from_nxy(r, widthDirection)
    "Orientation object from frame_a to coordinates system spanned by r and widthDirection";
  final parameter SI.Position r_CM[3]=r_shape +
      normalizeWithAssert(lengthDirection)*length/2
    "Position vector from origin of frame_a to center of mass, resolved in frame_a";
  final parameter SI.Inertia I[3, 3]=Frames.resolveDyade1(R, diagonal({mo*(
      width*width + height*height) - mi*(innerWidth*innerWidth + innerHeight*
      innerHeight),mo*(length*length + height*height) - mi*(length*length +
      innerHeight*innerHeight),mo*(length*length + width*width) - mi*(length*
      length + innerWidth*innerWidth)}/12))
    "Inertia tensor of body box with respect to center of mass, parallel to frame_a";
  Body body(
    animation=false,
    r_CM=r_CM,
    m=m,
    I_11=I[1, 1],
    I_22=I[2, 2],
    I_33=I[3, 3],
    I_21=I[2, 1],
    I_31=I[3, 1],
    I_32=I[3, 2],
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
    shapeType="box",
    r_shape=r_shape,
    lengthDirection=lengthDirection,
    widthDirection=widthDirection,
    length=length,
    width=width,
    height=height,
    color=color,
    specularCoefficient=specularCoefficient) annotation (Placement(
        transformation(extent={{-30,-20},{10,20}})));

protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  r_0 = frame_a.r_0;
  v_0 = der(r_0);
  a_0 = der(v_0);

  assert(innerWidth <= width,
    "parameter innerWidth is greater than parameter width");
  assert(innerHeight <= height,
    "parameter innerHeight is greater than parameter height");
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
<strong>Rigid body</strong> with <strong>box</strong> shape.
The mass properties of the body (mass, center of mass,
inertia tensor) are computed
from the box data. Optionally, the box may be hollow.
The (outer) box shape is by default used in the animation.
The hollow part is not shown in the animation.
The two connector frames <strong>frame_a</strong> and <strong>frame_b</strong>
are always parallel to each other. Example of component
animation (note, that
the animation may be switched off via parameter animation = <strong>false</strong>):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyBox.png\" alt=\"Parts.BodyBox\">
</div>

<p>
A BodyBox component has potential states. For details of these
states and of the \"Advanced\" menu parameters, see model
<a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">MultiBody.Parts.Body</a>.</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{100,40},{100,-30},{90,-40},{90,30},{100,40}},
          lineColor={0,95,191},
          fillColor={0,95,191},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,30},{90,-40}},
          lineColor={0,127,255},
          pattern=LinePattern.None,
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,30},{-90,40},{100,40},{90,30},{-100,30}},
          lineColor={0,95,191},
          fillColor={0,95,191},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{150,-80},{-150,-50}},
          textString="r=%r"),
        Text(
          extent={{52,8},{88,-17}},
          textString="b"),
        Text(
          extent={{-87,12},{-51,-13}},
          textString="a")}));
end BodyBox;
