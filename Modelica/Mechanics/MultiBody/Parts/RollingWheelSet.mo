within Modelica.Mechanics.MultiBody.Parts;
model RollingWheelSet
  "Ideal rolling wheel set consisting of two ideal rolling wheels connected together by an axis"
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frameMiddle
    "Frame fixed in middle of axis connecting both wheels (y-axis: along wheel axis, z-axis: upwards)"
    annotation (Placement(transformation(extent={{-16,16},{16,-16}}),
        iconTransformation(extent={{-16,-16},{16,16}},
        rotation=90,
        origin={0,-20})));

  parameter Boolean animation=true
    "= true, if animation of wheel set shall be enabled";

  parameter SI.Radius R_wheel "Radius of one wheel";
  parameter SI.Mass m_wheel "Mass of one wheel";
  parameter SI.Inertia I_wheelAxis "Inertia along one wheel axis";
  parameter SI.Inertia I_wheelLong "Inertia perpendicular to one wheel axis";
  parameter SI.Distance track "Distance between the two wheels (= axle track)";
  parameter StateSelect stateSelect=StateSelect.always
    "Priority to use the generalized coordinates as states";

  SI.Position x(
    start=0,
    fixed=true,
    stateSelect=stateSelect) "x coordinate of center between wheels";
  SI.Position y(
    start=0,
    fixed=true,
    stateSelect=stateSelect) "y coordinate of center between wheels";
  SI.Angle phi(
    start=0,
    fixed=true,
    stateSelect=stateSelect) "Orientation angle of wheel axis along z-axis";
  SI.Angle theta1(
    start=0,
    fixed=true,
    stateSelect=stateSelect) "Angle of wheel 1";
  SI.Angle theta2(
    start=0,
    fixed=true,
    stateSelect=stateSelect) "Angle of wheel 2";
  SI.AngularVelocity der_theta1(
    start=0,
    fixed=true,
    stateSelect=stateSelect) "Derivative of theta 1";
  SI.AngularVelocity der_theta2(
    start=0,
    fixed=true,
    stateSelect=stateSelect) "Derivative of theta 2";

  parameter SI.Distance width_wheel=0.01 "Width of one wheel"
    annotation (
      Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Real hollowFraction=0.8
    "For ring-like wheel visualization: wheel radius / inner hole radius; i.e. 1.0: completely hollow, 0.0: full disc"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Types.Color color={30,30,30} "Color of wheels"
    annotation (Dialog(
      colorSelector=true,
      tab="Animation",
      group="if animation = true",
      enable=animation));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame1
    "Frame fixed in center point of left wheel (y-axis: along wheel axis, z-axis: upwards)"
    annotation (Placement(transformation(extent={{-96,16},{-64,-16}}),
        iconTransformation(extent={{-96,16},{-64,-16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame2
    "Frame fixed in center point of right wheel (y-axis: along wheel axis, z-axis: upwards)"
    annotation (Placement(transformation(extent={{64,16},{96,-16}})));
  Modelica.Mechanics.MultiBody.Parts.Body body2(
    final r_CM={0,0,0},
    final I_21=0,
    final I_31=0,
    final I_32=0,
    animation=false,
    final m=m_wheel,
    final I_11=I_wheelLong,
    final I_22=I_wheelAxis,
    final I_33=I_wheelLong) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={60,30})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape shape2(
    final animation=animation,
    final lengthDirection={0,1,0},
    final widthDirection={1,0,0},
    final color=color,
    final extra=hollowFraction,
    final shapeType="pipe",
    final r_shape={0,-width_wheel,0},
    final length=2*width_wheel,
    final width=2*R_wheel,
    final height=2*R_wheel) if animation annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,-38})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    final r_CM={0,0,0},
    final I_21=0,
    final I_31=0,
    final I_32=0,
    animation=false,
    final m=m_wheel,
    final I_11=I_wheelLong,
    final I_22=I_wheelAxis,
    final I_33=I_wheelLong) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,30})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape shape1(
    final animation=animation,
    final lengthDirection={0,1,0},
    final widthDirection={1,0,0},
    final color=color,
    final extra=hollowFraction,
    final shapeType="pipe",
    final r_shape={0,-width_wheel,0},
    final length=2*width_wheel,
    final width=2*R_wheel,
    final height=2*R_wheel) if animation annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-40})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis1
    "1-dim. rotational flange that drives the left wheel"
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis2
    "1-dim. rotational flange that drives the right wheel"
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Modelica.Mechanics.MultiBody.Joints.RollingWheelSet wheelSetJoint(
    animation=false,
    radius=R_wheel,
    track=track,
    stateSelect=StateSelect.default,
    x(fixed=false),
    y(fixed=false),
    phi(fixed=false),
    theta1(fixed=false),
    theta2(fixed=false),
    der_theta1(fixed=false),
    der_theta2(fixed=false))
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b support
    "Support of 1D axes" annotation (Placement(transformation(extent={{-10,70},
            {10,90}}), iconTransformation(extent={{-10,70},{10,90}})));
equation
  wheelSetJoint.x = x;
  wheelSetJoint.y = y;
  wheelSetJoint.phi = phi;
  wheelSetJoint.theta1 = theta1;
  wheelSetJoint.theta2 = theta2;
  der_theta1 = der(theta1);
  der_theta2 = der(theta2);

  connect(body2.frame_a, frame2) annotation (Line(
      points={{60,20},{60,0},{80,0}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, frame1) annotation (Line(
      points={{-60,20},{-60,0},{-80,0}},
      color={95,95,95},
      thickness=0.5));
  connect(shape1.frame_a, frame1) annotation (Line(
      points={{-60,-30},{-60,0},{-80,0}},
      color={95,95,95},
      thickness=0.5));
  connect(shape2.frame_a, frame2) annotation (Line(
      points={{60,-28},{60,0},{80,0}},
      color={95,95,95},
      thickness=0.5));
  connect(wheelSetJoint.frame2, frame2) annotation (Line(
      points={{8,50},{30,50},{30,0},{80,0}},
      color={95,95,95},
      thickness=0.5));
  connect(wheelSetJoint.frame1, frame1) annotation (Line(
      points={{-8,50},{-30,50},{-30,0},{-80,0}},
      color={95,95,95},
      thickness=0.5));
  connect(wheelSetJoint.axis1, axis1) annotation (Line(
      points={{-10,60},{-80,60},{-80,100},{-100,100}}));
  connect(wheelSetJoint.axis2, axis2) annotation (Line(
      points={{10,60},{80,60},{80,100},{100,100}}));
  connect(wheelSetJoint.support, support) annotation (Line(
      points={{0,58},{0,80}}));
  connect(wheelSetJoint.frameMiddle, frameMiddle) annotation (Line(
      points={{0,48},{0,46},{20,46},{20,0},{0,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    defaultComponentName="wheelSet",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(
          points={{0,76},{0,4}}),
        Ellipse(
          extent={{42,80},{118,-80}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          lineColor={64,64,64}),
        Ellipse(extent={{42,80},{118,-80}}, lineColor={64,64,64}),
        Rectangle(
          extent={{-100,-80},{100,-100}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-150,-105},{150,-145}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{86,24},{64,24},{64,12},{56,12}}),
        Line(points={{86,-24},{64,-24},{64,-12},{56,-12}}),
        Line(
          points={{100,100},{80,100},{80,-2}}),
        Polygon(
          points={{-62,6},{64,6},{64,-6},{6,-6},{6,-20},{-6,-20},{-6,-6},{-62,-6},{-62,6}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-118,80},{-42,-80}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          lineColor={64,64,64}),
        Line(
          points={{-96,100},{-80,100},{-80,4}}),
        Ellipse(extent={{-118,80},{-42,-80}}, lineColor={64,64,64}),
        Line(
          points={{-100,-80},{100,-80}})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(
            points={{0,-106},{0,-78}},
            color={0,0,255}),Polygon(
            points={{0,-60},{-6,-78},{6,-78},{0,-60}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),Text(
            extent={{12,-68},{30,-80}},
            textColor={0,0,255},
            textString="x"),Line(
            points={{6,-100},{-26,-100}},
            color={0,0,255}),Polygon(
            points={{-22,-94},{-22,-106},{-40,-100},{-22,-94}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),Text(
            extent={{-46,-80},{-28,-92}},
            textColor={0,0,255},
            textString="y")}),
    Documentation(info="<html>
<p>
Two wheels are connected by an axis and can rotate around this axis.
The wheels are rolling on the x-y plane of the world frame.
The coordinate system attached to the center of the wheel axis (frameMiddle)
is constrained so that it is always parallel to the x-y plane.
If all generalized coordinates are zero, frameMiddle is parallel
to the world frame.
</p>

<h4>Note</h4>
<p>
To work properly, the gravity acceleration vector g of the world must point in the negative z-axis, i.e.
</p>
<blockquote><pre>
<span style=\"font-family:'Courier New',courier; color:#0000ff;\">inner</span> <span style=\"font-family:'Courier New',courier; color:#ff0000;\">Modelica.Mechanics.MultiBody.World</span> world(n={0,0,-1});
</pre></blockquote>
</html>"));
end RollingWheelSet;
