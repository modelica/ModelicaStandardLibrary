within Modelica.Mechanics.MultiBody;
package Interfaces
  "Connectors and partial models for 3-dim. mechanical components"

  extends Modelica.Icons.InterfacesPackage;

  connector Frame
    "Coordinate system fixed to the component with one cut-force and cut-torque (no icon)"

    SI.Position r_0[3]
      "Position vector from world frame to the connector frame origin, resolved in world frame";
    Frames.Orientation R
      "Orientation object to rotate the world frame into the connector frame";
    flow SI.Force f[3] "Cut-force resolved in connector frame" annotation (
        unassignedMessage="All Forces cannot be uniquely calculated.
The reason could be that the mechanism contains
a planar loop or that joints constrain the
same motion. For planar loops, use for one
revolute joint per loop the joint
Joints.RevolutePlanarLoopConstraint instead of
Joints.Revolute.");
    flow SI.Torque t[3] "Cut-torque resolved in connector frame";
    annotation (Documentation(info="<html>
<p>
Basic definition of a coordinate system that is fixed to a mechanical
component. In the origin of the coordinate system the cut-force
and the cut-torque is acting. This component has no icon definition
and is only used by inheritance from frame connectors to define
different icons.
</p>
</html>"));
  end Frame;

  connector Frame_a
    "Coordinate system fixed to the component with one cut-force and cut-torque (filled rectangular icon)"
    extends Frame;

    annotation (defaultComponentName="frame_a",
     Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.16), graphics={Rectangle(
            extent={{-10,10},{10,-10}},
            lineColor={95,95,95},
            lineThickness=0.5), Rectangle(
            extent={{-30,100},{30,-100}},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid)}),
     Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.16), graphics={Text(
            extent={{-140,-50},{140,-90}},
            textString="%name"), Rectangle(
            extent={{-12,40},{12,-40}},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
Basic definition of a coordinate system that is fixed to a mechanical
component. In the origin of the coordinate system the cut-force
and the cut-torque is acting.
This component has a filled rectangular icon.
</p>
</html>"));
  end Frame_a;

  connector Frame_b
    "Coordinate system fixed to the component with one cut-force and cut-torque (non-filled rectangular icon)"
    extends Frame;

    annotation (defaultComponentName="frame_b",
     Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.16), graphics={Rectangle(
            extent={{-10,10},{10,-10}},
            lineColor={95,95,95},
            lineThickness=0.5), Rectangle(
            extent={{-30,100},{30,-100}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
     Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.16), graphics={Text(
            extent={{-140,-50},{140,-90}},
            textString="%name"), Rectangle(
            extent={{-12,40},{12,-40}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
Basic definition of a coordinate system that is fixed to a mechanical
component. In the origin of the coordinate system the cut-force
and the cut-torque is acting. This component has a non-filled rectangular icon.
</p>
</html>"));
  end Frame_b;

  connector Frame_resolve
    "Coordinate system fixed to the component used to express in which coordinate system a vector is resolved (non-filled rectangular icon)"
    extends Frame;

    annotation (defaultComponentName="frame_resolve",
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.16), graphics={Rectangle(
              extent={{-10,10},{10,-10}},
              lineColor={95,95,95},
              pattern=LinePattern.Dot), Rectangle(
              extent={{-30,100},{30,-100}},
              lineColor={95,95,95},
              pattern=LinePattern.Dot,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.16), graphics={Text(
              extent={{-140,-50},{140,-90}},
              textString="%name"), Rectangle(
              extent={{-12,40},{12,-40}},
              lineColor={95,95,95},
              pattern=LinePattern.Dot,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
Basic definition of a coordinate system that is fixed to a mechanical
component. In the origin of the coordinate system the cut-force
and the cut-torque is acting. This coordinate system is used to
express in which coordinate system a vector is resolved.
A component that uses a Frame_resolve connector has to set the
cut-force and cut-torque of this frame to zero. When connecting
from a Frame_resolve connector to another frame connector,
by default the connecting line has line style \"dotted\".
This component has a non-filled rectangular icon.
</p>
</html>"));
  end Frame_resolve;

  connector FlangeWithBearing
    "Connector consisting of 1-dim. rotational flange and its bearing frame"
    parameter Boolean includeBearingConnector=false
      "= true, if bearing frame connector is present, otherwise not present";
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
      "1-dim. rotational flange";
    Modelica.Mechanics.MultiBody.Interfaces.Frame bearingFrame if
      includeBearingConnector
      "3-dim. frame in which the 1-dim. shaft is mounted";

    annotation (
      defaultComponentName="flange",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-20,1},{20,-1}},
            lineColor={135,135,135},
            lineThickness=0.5),
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,25},{100,-25}},
            lineColor={64,64,64},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Line(points={{-80,60},{80,60}}),
          Line(points={{-80,-60},{80,-60}}),
          Line(points={{0,100},{0,60}}),
          Line(points={{0,-60},{0,-100}}),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={135,135,135}),
          Rectangle(extent={{-100,25},{100,-25}}, lineColor={64,64,64})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(
            points={{-50,-40},{50,-40}},
            thickness=0.5),
          Line(
            points={{-50,40},{50,40}},
            thickness=0.5),
          Text(
            extent={{-158,-66},{158,-124}},
            textString="%name"),
          Rectangle(
            extent={{-60,60},{60,-60}},
            lineColor={255,255,255},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,15},{60,-15}},
            lineColor={64,64,64},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Line(points={{0,60},{0,40}}),
          Line(points={{0,-40},{0,-60}}),
          Line(points={{-50,40},{50,40}}),
          Line(points={{-50,-40},{50,-40}}),
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={135,135,135}),
          Rectangle(extent={{-60,15},{60,-15}}, lineColor={64,64,64})}),
      Documentation(info="<html>
<p>
This hierarchical connector models a 1-dim. rotational flange
connector and its optional bearing defined by a 3-dim. frame connector.
If a connection to the subconnectors should be clearly visible,
connect first an  instance of
<a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearingAdaptor\">FlangeWithBearingAdaptor</a>
to the FlangeWithBearing connector.
</p>
</html>"));

  end FlangeWithBearing;

  model FlangeWithBearingAdaptor
    "Adaptor to allow direct connections to the sub-connectors of FlangeWithBearing"
    parameter Boolean includeBearingConnector=false
      "= true, if bearing frame connector is present, otherwise not present";

    Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing flangeAndFrame(
        includeBearingConnector=includeBearingConnector)
      "Compound connector consisting of 1-dim. rotational flange and 3-dim. frame mounting"
                                   annotation (Placement(transformation(extent=
              {{-130,-30},{-70,30}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange
      "1-dim. rotational flange"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Frame_a frame if includeBearingConnector
      "3-dim. frame in which the 1-dim. shaft is mounted" annotation (Placement(
          transformation(
          origin={0,-100},
          extent={{-16,-16},{16,16}},
          rotation=90)));

  equation
    connect(flange, flangeAndFrame.flange) annotation (Line(
        points={{0,0},{-100,0}}));
    connect(frame, flangeAndFrame.bearingFrame) annotation (Line(
        points={{0,-100},{0,-40},{-100,-40},{-100,0}},
        thickness=0.5));
    annotation (
      defaultComponentName="adaptor",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,30},{20,-100}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-100,-10},{-100,-40},{0,-40},{0,-100}},
            thickness=0.5),
          Line(points={{-90,0},{0,0}}),
          Text(
            extent={{-216,88},{86,36}},
            lineColor={0,0,255},
            textString="%name")}),
      Documentation(info="<html>
<p>
Adaptor object to make a more visible connection to the flange and frame
subconnectors of a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing\">FlangeWithBearing</a>
connector.
</p>
</html>"));
  end FlangeWithBearingAdaptor;

  partial model PartialTwoFrames
    "Base model for components providing two frame connectors + outer world + assert to guarantee that the component is connected"

    Interfaces.Frame_a frame_a
      "Coordinate system a fixed to the component with one cut-force and cut-torque"
      annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
    Interfaces.Frame_b frame_b
      "Coordinate system b fixed to the component with one cut-force and cut-torque"
      annotation (Placement(transformation(extent={{84,-16},{116,16}})));
  protected
    outer Modelica.Mechanics.MultiBody.World world;
  equation
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of component is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of component is not connected");
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Text(
            extent={{-136,-25},{-100,-50}},
            lineColor={128,128,128},
            textString="a"), Text(
            extent={{100,-25},{136,-50}},
            lineColor={128,128,128},
            textString="b")}),
      Documentation(info="<html>
<p>
This partial model provides two frame connectors, access to the world
object and an assert to check that both frame connectors are connected.
Therefore, inherit from this partial model if the two frame connectors are
needed and if the two frame connectors should be connected for a correct model.
</p>
</html>"));
  end PartialTwoFrames;

  partial model PartialTwoFramesDoubleSize
    "Base model for components providing two frame connectors + outer world + assert to guarantee that the component is connected (default icon size is factor 2 larger as usual)"

    Interfaces.Frame_a frame_a
      "Coordinate system fixed to the component with one cut-force and cut-torque"
     annotation (Placement(transformation(extent={{-108,-8},{-92,8}})));
    Interfaces.Frame_b frame_b
      "Coordinate system fixed to the component with one cut-force and cut-torque"
      annotation (Placement(transformation(extent={{92,-8},{108,8}})));

  protected
    outer Modelica.Mechanics.MultiBody.World world;
  equation
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of component is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of component is not connected");
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.2), graphics={Text(
            extent={{-117,-13},{-106,-23}},
            lineColor={128,128,128},
            textString="a"), Text(
            extent={{110,-15},{122,-25}},
            lineColor={128,128,128},
            textString="b")}),
      Documentation(info="<html>
<p>
This partial model provides two frame connectors, access to the world
object and an assert to check that both frame connectors are connected.
Therefore, inherit from this partial model if the two frame connectors are
needed and if the two frame connectors should be connected for a correct model.
</p>
<p>
When dragging \"PartialTwoFrames\", the default size is a factor of two
larger as usual. This partial model is used by the Joint.Assemblies
joint aggregation models.
</p>
</html>"));
  end PartialTwoFramesDoubleSize;

  partial model PartialOneFrame_a
    "Base model for components providing one frame_a connector + outer world + assert to guarantee that the component is connected"

    Interfaces.Frame_a frame_a
      "Coordinate system fixed to the component with one cut-force and cut-torque" annotation (Placement(
          transformation(extent={{-116,-16},{-84,16}})));
  protected
    outer Modelica.Mechanics.MultiBody.World world;
  equation
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of component is not connected");
    annotation (Documentation(info="<html>
<p>
This partial model provides one frame_a connector, access to the world
object and an assert to check that the frame_a connector is connected.
Therefore, inherit from this partial model if the frame_a connector is
needed and if this connector should be connected for a correct model.
</p>
</html>"));
  end PartialOneFrame_a;

  partial model PartialOneFrame_b
    "Base model for components providing one frame_b connector + outer world + assert to guarantee that the component is connected"

    Interfaces.Frame_b frame_b
      "Coordinate system fixed to the component with one cut-force and cut-torque"
      annotation (Placement(transformation(extent={{84,-16},{116,16}})));
  protected
    outer Modelica.Mechanics.MultiBody.World world;
  equation
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of component is not connected");
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Text(
            extent={{94,-20},{130,-45}},
            lineColor={128,128,128},
            textString="b")}),
      Documentation(info="<html>
<p>
This partial model provides one frame_b connector, access to the world
object and an assert to check that the frame_b connector is connected.
Therefore, inherit from this partial model if the frame_b connector is
needed and if this connector should be connected for a correct model.
</p>
</html>"));
  end PartialOneFrame_b;

  partial model PartialElementaryJoint
    "Base model for elementary joints (has two frames + outer world + assert to guarantee that the joint is connected)"

    Interfaces.Frame_a frame_a
      "Coordinate system fixed to the joint with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{
              -116,-16},{-84,16}})));
    Interfaces.Frame_b frame_b
      "Coordinate system fixed to the joint with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{84,
              -16},{116,16}})));

  protected
    outer Modelica.Mechanics.MultiBody.World world;
  equation
    Connections.branch(frame_a.R, frame_b.R);
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of joint object is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of joint object is not connected");
    annotation (Documentation(info="<html>
<p>
All <strong>elementary joints</strong> should inherit from this base model, i.e.,
joints that are directly defined by equations, provided they compute
either the rotation object of frame_b from the rotation object of frame_a
and from relative quantities (or vice versa), or there is a constraint
equation between the rotation objects of the two frames.
In other cases, a joint object should inherit from
<strong>Interfaces.PartialTwoFrames</strong> (e.g., joint Spherical, because there
is no constraint between the rotation objects of frame_a and frame_b
or joint Cylindrical because it is not an elementary joint).
</p>
<p>
This partial model provides two frame connectors, a \"Connections.branch\"
between frame_a and frame_b, access to the world
object and an assert to check that both frame connectors are connected.
</p>
</html>"));
  end PartialElementaryJoint;

  partial model PartialForce
    "Base model for force elements (provide frame_b.f and frame_b.t in subclasses)"
    extends PartialTwoFrames;
    SI.Position r_rel_b[3]
      "Position vector from origin of frame_a to origin of frame_b, resolved in frame_b";
  equation
    // Determine relative position vector between frame_a and frame_b
    r_rel_b = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);

    // Force and torque balance between frame_a and frame_b
    zeros(3) = frame_a.f + Frames.resolveRelative(frame_b.f, frame_b.R, frame_a.R);
    zeros(3) = frame_a.t + Frames.resolveRelative(frame_b.t + cross(r_rel_b, frame_b.f), frame_b.R, frame_a.R);
    annotation (Documentation(info="<html>
<p>
All <strong>3-dimensional force</strong> and <strong>torque elements</strong>
should be based on this superclass.
This model defines frame_a and frame_b, computes the relative
translation and rotation between the two frames and calculates
the cut-force and cut-torque at frame_a by a force and torque
balance from the cut-force and cut-torque at frame_b.
As a result, in a subclass, only the relationship between
the cut-force and cut-torque at frame_b has to be defined as
a function of the following relative quantities:
</p>
<pre>
  r_rel_b[3]: Position vector from origin of frame_a to origin
              of frame_b, resolved in frame_b
  R_rel     : Relative orientation object to rotate from frame_a to frame_b
</pre>
<p>
Assume that force f = {100,0,0} should be applied on the body
to which this force element is attached at frame_b, then
the definition should be:
</p>
<pre>
   <strong>model</strong> Constant_x_Force
      extends Modelica.Mechanics.MultiBody.Interfaces.PartialForce;
   <strong>equation</strong>
      frame_b.f = {-100, 0, 0};
      frame_b.t = zeros(3);
   <strong>end</strong> Constant_x_Force;
</pre>
<p>
Note, that frame_b.f and frame_b.t are flow variables and therefore
the negative value of frame_b.f and frame_b.t is acting at the part
to which this force element is connected.
</p>
</html>"));
  end PartialForce;

  partial model LineForceBase "Base model for line force elements"
    extends PartialTwoFrames;
    parameter SI.Distance s_small=1e-10
      "Prevent zero-division if distance between frame_a and frame_b is zero"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean fixedRotationAtFrame_a=false
      "=true, if rotation frame_a.R is fixed (to directly connect line forces)"
       annotation (Evaluate=true, choices(checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));
    parameter Boolean fixedRotationAtFrame_b=false
      "=true, if rotation frame_b.R is fixed (to directly connect line forces)"
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
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Ellipse(visible=fixedRotationAtFrame_a, extent={{-70,30},{-130,-30}}, lineColor={255,0,0}),
          Text(visible=fixedRotationAtFrame_a,
            extent={{-62,50},{-140,30}},
            lineColor={255,0,0},
            textString="R=0"),
          Ellipse(visible=fixedRotationAtFrame_b, extent={{70,30},{130,-30}}, lineColor={255,0,0}),
          Text(visible=fixedRotationAtFrame_b,
            extent={{62,50},{140,30}},
            lineColor={255,0,0},
            textString="R=0")}));
  end LineForceBase;

  partial model PartialLineForce "Base model for massless line force elements"
    extends LineForceBase;

    Modelica.SIunits.Position r_rel_a[3]
      "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a";
    Real e_a[3](each final unit="1")
      "Unit vector on the line connecting the origin of frame_a with the origin of frame_b resolved in frame_a (directed from frame_a to frame_b)";
    SI.Force f
      "Line force acting on frame_a and on frame_b (positive, if acting on frame_b and directed from frame_a to frame_b)";
  equation
    // Determine relative position vector between the two frames
    r_rel_a = Frames.resolve2(frame_a.R, r_rel_0);
    e_a = r_rel_a/s;

    // Determine forces and torques at frame_a and frame_b
    frame_a.f = -e_a*f;
    frame_b.f = -Frames.resolve2(Frames.relativeRotation(frame_a.R, frame_b.R), frame_a.f);

    annotation (Documentation(info="<html>
<p>
All massless <strong>line force</strong> elements should be based on this base model.
This model defines frame_a and frame_b, computes the (guarded) relative
distance <strong>s</strong> and provides the force and torque
balance of the cut-forces and cut-torques at frame_a and
frame_b, respectively. In sub-models, only the line force <strong>f</strong>,
acting at frame_b on the line from frame_a to frame_b, as a function
of the relative distance <strong>s</strong> and its derivative <strong>der</strong>(<strong>s</strong>)
has to be defined. Example:
</p>
<pre>
   <strong>model</strong> Spring
      <strong>parameter</strong> Real c \"spring constant\",
      <strong>parameter</strong> Real s_unstretched \"unstretched spring length\";
      <strong>extends</strong> Modelica.Mechanics.MultiBody.Interfaces.PartialLineForce;
   <strong>equation</strong>
      f = c*(s-s_unstretched);
   <strong>end</strong> Spring;
</pre>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Ellipse(visible=fixedRotationAtFrame_a, extent={{-70,30},{-130,-30}}, lineColor={255,0,0}),
          Text(visible=fixedRotationAtFrame_a,
            extent={{-62,50},{-140,30}},
            lineColor={255,0,0},
            textString="R=0"),
          Ellipse(visible=fixedRotationAtFrame_b, extent={{70,30},{130,-30}}, lineColor={255,0,0}),
          Text(visible=fixedRotationAtFrame_b,
            extent={{62,50},{140,30}},
            lineColor={255,0,0},
            textString="R=0")}));
  end PartialLineForce;

  partial model PartialAbsoluteSensor
    "Base model to measure an absolute frame variable"
    extends Modelica.Icons.RotationalSensor;
    parameter Integer n_out = 1 "Number of output signals";
    Interfaces.Frame_a frame_a
      "Coordinate system from which absolute quantities are provided as output signals"
      annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));

    Modelica.Blocks.Interfaces.RealOutput y[n_out]
      "Measured data as signal vector"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  protected
    outer Modelica.Mechanics.MultiBody.World world;

  equation
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of absolute sensor object is not connected");
    annotation (
      Documentation(info="<html>
<p>
This is the base class of a 3-dim. mechanics component with one frame and one
output port in order to measure an absolute quantity in the frame connector
and to provide the measured signal as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-70,0},{-100,0}}),
          Line(points={{70,0},{100,0}}, color={0,0,255}),
          Text(
            extent={{-132,-125},{131,-79}},
            textString="%name",
            lineColor={0,0,255})}));
  end PartialAbsoluteSensor;

  partial model PartialRelativeSensor
    "Base model to measure a relative variable between two frames"
    extends Modelica.Icons.RotationalSensor;
    parameter Integer n_out = 1 "Number of output signals";
    Interfaces.Frame_a frame_a "Coordinate system a" annotation (Placement(
          transformation(extent={{-116,-16},{-84,16}})));
    Interfaces.Frame_b frame_b "Coordinate system b" annotation (Placement(
          transformation(extent={{84,-16},{116,16}})));

    Modelica.Blocks.Interfaces.RealOutput y[n_out]
      "Measured data as signal vector"
      annotation (Placement(transformation(
          origin={0,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));
  protected
    outer Modelica.Mechanics.MultiBody.World world;

  equation
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of relative sensor object is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of relative sensor object is not connected");

    annotation (
      Documentation(info="<html>
<p>
This is a base class for 3-dim. mechanical components with two frames
and one output port in order to measure relative quantities
between the two frames or the cut-forces/torques in the frame and
to provide the measured signals as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-70,0},{-101,0}}),
          Line(points={{70,0},{100,0}}),
          Line(points={{0,-100},{0,-70}}, color={0,0,127}),
          Text(
            extent={{-132,76},{129,124}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-118,52},{-82,27}},
            lineColor={128,128,128},
            textString="a"),
          Text(
            extent={{85,53},{121,28}},
            lineColor={128,128,128},
            textString="b")}));
  end PartialRelativeSensor;

  partial model PartialVisualizer
    "Base model for visualizers (has a frame_a on the left side + outer world + assert to guarantee that the component is connected)"

    Interfaces.Frame_a frame_a
      "Coordinate system in which visualization data is resolved" annotation (Placement(
          transformation(extent={{-116,-16},{-84,16}})));
  protected
    outer Modelica.Mechanics.MultiBody.World world;
  equation
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of visualizer object is not connected");
    annotation (Documentation(info="<html>
<p>
This partial model provides one frame_a connector, access to the world
object and an assert to check that the frame_a connector is connected.
It is used by inheritance from all visualizer objects.
</p>
</html>"));
  end PartialVisualizer;

  model ZeroPosition
    "Set absolute position vector of frame_resolve to a zero vector and the orientation object to a null rotation"
     extends Modelica.Blocks.Icons.Block;
    Interfaces.Frame_resolve frame_resolve
      annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  equation
    Connections.root(frame_resolve.R);
    frame_resolve.R = Modelica.Mechanics.MultiBody.Frames.nullRotation();
    frame_resolve.r_0 = zeros(3);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-74,24},{80,-20}},
            textString="r = 0")}), Documentation(info="<html>
<p>
Element consisting of a frame (frame_resolve) that is fixed in the world
frame and has it's position and orientation identical with the world, i.e.
the position vector from origin of world frame to frame_resolve is zero vector
and the relative orientation between those two frames is identity matrix.
</p>
<p>
This component provides no visualization.
</p>
</html>"));
  end ZeroPosition;

  partial function partialGravityAcceleration "Interface for the gravity function used in the World object"
    extends Modelica.Icons.Function;
     input Modelica.SIunits.Position r[3]
      "Position vector from world frame to actual point, resolved in world frame";
     output Modelica.SIunits.Acceleration gravity[3]
      "Gravity acceleration at position r, resolved in world frame";
    annotation (Documentation(info="<html>
<p>
This partial function defines the interface to the gravity function
used in the World object. All gravity field functions must inherit
from this function. The input to the function is the absolute position
vector of a point in the gravity field, whereas the output is the
gravity acceleration at this point, resolved in the world frame.
</p>
</html>"));
  end partialGravityAcceleration;

  partial function partialSurfaceCharacteristic "Interface for a function returning surface characteristics"
    extends Modelica.Icons.Function;
     input Integer nu "Number of points in u-Dimension";
     input Integer nv "Number of points in v-Dimension";
     input Boolean multiColoredSurface=false
      "= true: Color is defined for each surface point";
     output Modelica.SIunits.Position X[nu,nv]
      "[nu,nv] positions of points in x-Direction resolved in surface frame";
     output Modelica.SIunits.Position Y[nu,nv]
      "[nu,nv] positions of points in y-Direction resolved in surface frame";
     output Modelica.SIunits.Position Z[nu,nv]
      "[nu,nv] positions of points in z-Direction resolved in surface frame";
     output Real C[if multiColoredSurface then nu else 0,
                   if multiColoredSurface then nv else 0,3]
      "[nu,nv,3] Color array, defining the color for each surface point";
    annotation (Documentation(info="<html>
<p>This partial function defines the interface of a function that returns
surface characteristics for an object visualization, see e.g.
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.torus\">Visualizers.Advanced.SurfaceCharacteristics.torus</a>.
</p>
</html>"));
  end partialSurfaceCharacteristic;

  partial function partialColorMap
    "Interface for a function returning a color map"
    extends Modelica.Icons.Function;
    input Integer n_colors=64 "Number of colors in the color map";
    output Real colorMap[n_colors,3] "Color map to map a scalar to a color";
    annotation (Documentation(info="<html>
<p>
This partial function defines the interface of a function that returns
a color map. Predefined color map functions are defined in package
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps</a>.
</p>
</html>"));
  end partialColorMap;

  annotation (Documentation(info="<html>
<p>
This package contains connectors and partial models (i.e., models
that are only used to build other models) of the MultiBody library.
</p>
</html>"));
end Interfaces;
