within Modelica.Mechanics.MultiBody.Forces;
model LineForceWithMass "General line force component with an optional point mass on the connection line"
  import Modelica.Mechanics.MultiBody.Types;
  extends Interfaces.LineForceBase;

  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_b
    "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
    annotation (Placement(transformation(
        origin={60,100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_a
    "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
    annotation (Placement(transformation(
        origin={-60,100},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  parameter Boolean animateLine=true
    "= true, if a line shape between frame_a and frame_b shall be visualized";
  parameter Boolean animateMass=true
    "= true, if point mass shall be visualized as sphere provided m > 0";
  parameter SI.Mass m(min=0)=0
    "Mass of point mass on the connection line between the origin of frame_a and the origin of frame_b";
  parameter Real lengthFraction(
    unit="1",
    min=0,
    max=1) = 0.5
    "Location of point mass with respect to frame_a as a fraction of the distance from frame_a to frame_b";
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", enable=animateLine or animateMass));
  parameter Types.ShapeType lineShapeType="cylinder"
    "Type of shape visualizing the line from frame_a to frame_b"
    annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
  input SI.Length lineShapeWidth=world.defaultArrowDiameter "Width of shape"
    annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
  input SI.Length lineShapeHeight=lineShapeWidth "Height of shape"
    annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
  parameter Types.ShapeExtra lineShapeExtra=0.0 "Extra parameter for shape"
    annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
  input Types.Color lineShapeColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
    "Color of line shape"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animateLine = true", enable=animateLine));
  input Real massDiameter=world.defaultBodyDiameter
    "Diameter of point mass sphere"
    annotation (Dialog(tab="Animation", group="if animateMass = true", enable=animateMass));
  input Types.Color massColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
    "Color of point mass"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animateMass = true", enable=animateMass));

protected
  SI.Force fa "Force from flange_a";
  SI.Force fb "Force from flange_b";
  SI.Position r_CM_0[3](each stateSelect=StateSelect.avoid)
    "Position vector from world frame to point mass, resolved in world frame";
  SI.Velocity v_CM_0[3](each stateSelect=StateSelect.avoid)
    "First derivative of r_CM_0";
  SI.Acceleration ag_CM_0[3] "der(v_CM_0) - gravityAcceleration";

  Visualizers.Advanced.Shape lineShape(
    shapeType=lineShapeType,
    color=lineShapeColor,
    specularCoefficient=specularCoefficient,
    length=length,
    width=lineShapeWidth,
    height=lineShapeHeight,
    lengthDirection=e_rel_0,
    widthDirection=Frames.resolve1(frame_a.R, {0,1,0}),
    extra=lineShapeExtra,
    r=frame_a.r_0) if world.enableAnimation and animateLine;

  Visualizers.Advanced.Shape massShape(
    shapeType="sphere",
    color=massColor,
    specularCoefficient=specularCoefficient,
    length=massDiameter,
    width=massDiameter,
    height=massDiameter,
    lengthDirection=e_rel_0,
    widthDirection={0,1,0},
    r_shape=e_rel_0*(length*lengthFraction - massDiameter/2),
    r=frame_a.r_0) if world.enableAnimation and animateMass and m > 0;

equation
  flange_a.s = 0;
  flange_b.s = length;

  // Determine translational flange forces
  if cardinality(flange_a) > 0 and cardinality(flange_b) > 0 then
    fa = flange_a.f;
    fb = flange_b.f;
  elseif cardinality(flange_a) > 0 and cardinality(flange_b) == 0 then
    fa = flange_a.f;
    fb = -fa;
  elseif cardinality(flange_a) == 0 and cardinality(flange_b) > 0 then
    fa = -fb;
    fb = flange_b.f;
  else
    fa = 0;
    fb = 0;
  end if;

  /* Force and torque balance of point mass
     - Kinematics for center of mass CM of point mass including gravity
       r_CM_0 = frame_a.r0 + r_rel_CM_0;
       v_CM_0 = der(r_CM_0);
       ag_CM_0 = der(v_CM_0) - world.gravityAcceleration(r_CM_0);
     - Power balance for the connection line
       (f1=force on frame_a side, f2=force on frame_b side, h=lengthFraction)
       0 = f1*va - m*ag_CM*(va+(vb-va)*h) + f2*vb
         = (f1 - m*ag_CM*(1-h))*va + (f2 - m*ag_CM*h)*vb
       since va and vb are completely independent from other
       the parenthesis must vanish:
         f1 := m*ag_CM*(1-h)
         f2 := m*ag_CM*h
     - Force balance on frame_a and frame_b finally results in
         0 = frame_a.f + e_rel_a*fa - f1_a
         0 = frame_b.f + e_rel_b*fb - f2_b
       and therefore
         frame_a.f = -e_rel_a*fa + m*ag_CM_a*(1-h)
         frame_b.f = -e_rel_b*fb + m*ag_CM_b*h
  */
  if m > 0 then
    r_CM_0 = frame_a.r_0 + r_rel_0*lengthFraction;
    v_CM_0 = der(r_CM_0);
    ag_CM_0 = der(v_CM_0) - world.gravityAcceleration(r_CM_0);
    frame_a.f = Frames.resolve2(frame_a.R, (m*(1 - lengthFraction))*ag_CM_0 - e_rel_0*fa);
    frame_b.f = Frames.resolve2(frame_b.R, (m*lengthFraction)*ag_CM_0 - e_rel_0*fb);
  else
    r_CM_0 = zeros(3);
    v_CM_0 = zeros(3);
    ag_CM_0 = zeros(3);
    frame_a.f = -Frames.resolve2(frame_a.R, e_rel_0*fa);
    frame_b.f = -Frames.resolve2(frame_b.R, e_rel_0*fb);
  end if;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-100,-40},{-20,40}},
          startAngle=70,
          endAngle=290,
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          closure=EllipseClosure.Radial),
        Ellipse(
          extent={{-90,-30},{-30,30}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          startAngle=65,
          endAngle=295,
          lineColor={255,255,255}),
        Ellipse(
          extent={{-90,-30},{-30,30}},
          startAngle=70,
          endAngle=290,
          lineColor={0,0,0},
          closure=EllipseClosure.None),
        Ellipse(
          extent={{20,-40},{100,40}},
          startAngle=-110,
          endAngle=110,
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          closure=EllipseClosure.Radial),
        Ellipse(
          extent={{30,-30},{90,30}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          startAngle=-115,
          endAngle=115,
          lineColor={255,255,255}),
        Ellipse(
          extent={{30,-30},{90,30}},
          startAngle=-110,
          endAngle=110,
          lineColor={0,0,0},
          closure=EllipseClosure.None),
          Ellipse(
          extent={{-76,16},{-44,-16}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
          Ellipse(
          extent={{44,16},{76,-16}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
          Line(points={{-60,0},{-30,30},{-30,70},{-60,70},{-60,100}}),
          Line(points={{60,0},{30,30},{30,70},{60,70},{60,100}}),
          Line(
            points={{-60,0},{60,0}},
            pattern=LinePattern.Dot),
          Ellipse(
            extent={{-8,8},{8,-8}},
            fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-50},{150,-90}},
          textString="%name",
          textColor={0,0,255}),
        Ellipse(visible=fixedRotationAtFrame_a, extent={{-70,30},{-130,-30}}, lineColor={255,0,0}),
        Text(visible=fixedRotationAtFrame_a,
          extent={{-62,50},{-140,30}},
          textColor={255,0,0},
          textString="R=0"),
        Ellipse(visible=fixedRotationAtFrame_b, extent={{70,30},{130,-30}}, lineColor={255,0,0}),
        Text(visible=fixedRotationAtFrame_b,
          extent={{62,50},{140,30}},
          textColor={255,0,0},
          textString="R=0")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-60,80},{46,80}}, color={0,0,255}),
        Polygon(
          points={{60,80},{45,86},{45,74},{60,80}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,98},{40,82}},
          textString="length",
          textColor={0,0,255}),
        Ellipse(
          extent={{-100,-40},{-20,40}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-90,-30},{-30,30}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,-40},{100,40}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{31,-29},{91,30}},
          lineColor={128,128,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,39},{50,-41}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-74,15},{-45,-13}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{45,15},{74,-13}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Line(points={{-60,0},{-60,24},{-40,24},{-40,60},{-60,60},{-60,100}}),
        Line(points={{60,1},{60,21},{40,21},{40,60},{60,60},{60,100}}),
        Line(
          points={{-60,0},{60,0}},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-8,8},{8,-8}},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,0},{-31,0}}, color={0,0,255}),
        Polygon(points={{-19,0},{-31,3},{-31,-3},{-19,0}}, lineColor={0,0,255}),
        Line(points={{-60,16},{0,16}}, color={0,0,255}),
        Line(points={{0,0},{0,20}}, color={0,0,255}),
        Text(
          extent={{-49,-11},{-8,-21}},
          textString="e_rel_0"),
        Polygon(points={{0,16},{-12,19},{-12,13},{0,16}}, lineColor={0,0,255}),
        Text(
          extent={{-50,35},{51,26}},
          textString="length*lengthFraction"),
        Line(
          points={{-17,26},{-26,16}},
          pattern=LinePattern.Dot,
          color={0,0,255}),
        Line(
          points={{-31,-13},{-40,0}},
          pattern=LinePattern.Dot,
          color={0,0,255})}),
    Documentation(info="<html>
<p>
This component is used to exert a <strong>line force</strong>
between the origin of frame_a and the origin of frame_b
by attaching components of the <strong>1-dimensional translational</strong>
mechanical library of Modelica (Modelica.Mechanics.Translational)
between the two flange connectors <strong>flange_a</strong> and
<strong>flange_b</strong>. Optionally, there is a <strong>point mass</strong> on the line
connecting the origin of frame_a and the origin of frame_b.
This point mass approximates the <strong>mass</strong> of the <strong>force element</strong>.
The distance of the point mass from frame_a as a fraction of the
distance between frame_a and frame_b is defined via
parameter <strong>lengthFraction</strong> (default is 0.5, i.e., the point
mass is in the middle of the line).
</p>
<p>
In the translational library there is the implicit assumption that
forces of components that have only one flange connector act with
opposite sign on the bearings of the component. This assumption
is also used in the LineForceWithMass component: If a connection
is present to only one of the flange connectors, then the force
in this flange connector acts implicitly with opposite sign also
in the other flange connector.
</p>
</html>"));
end LineForceWithMass;
