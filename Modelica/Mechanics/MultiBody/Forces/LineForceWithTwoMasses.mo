within Modelica.Mechanics.MultiBody.Forces;
model LineForceWithTwoMasses
  "General line force component with two optional point masses on the connection line"

  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.LineForceBase;
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_b
    "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
    annotation (Placement(transformation(
        origin={60,110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_a
    "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
    annotation (Placement(transformation(
        origin={-60,110},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  parameter Boolean animate=true "= true, if animation shall be enabled";
  parameter Boolean animateMasses=true
    "= true, if point masses shall be visualized provided animate=true and m_a, m_b > 0";
  parameter SI.Mass m_a(min=0)=0
    "Mass of point mass a on the connection line between the origin of frame_a and the origin of frame_b";
  parameter SI.Mass m_b(min=0)=0
    "Mass of point mass b on the connection line between the origin of frame_a and the origin of frame_b";
  parameter SI.Position L_a=0
    "Distance between point mass a and frame_a (positive, if in direction of frame_b)";
  parameter SI.Position L_b=L_a
    "Distance between point mass b and frame_b (positive, if in direction of frame_a)";
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", enable=animate));
  input SI.Diameter cylinderDiameter_a=world.defaultForceWidth
    "Diameter of cylinder at frame_a"
    annotation (Dialog(tab="Animation", group="Cylinder at frame_a if animate = true", enable=animate));
  parameter SI.Length cylinderLength_a=2*L_a "Length of cylinder at frame_a"
    annotation (Dialog(tab="Animation", group="Cylinder at frame_a if animate = true", enable=animate));
  input Types.Color color_a={155,155,155} "Color of cylinder at frame_a"
    annotation (Dialog(colorSelector=true, tab="Animation", group="Cylinder at frame_a if animate = true", enable=animate));
  input Real diameterFraction=0.8
    "Diameter of cylinder at frame_b with respect to diameter of cylinder at frame_a"
    annotation (Dialog(tab="Animation", group="Cylinder at frame_b if animate = true", enable=animate));
  parameter SI.Length cylinderLength_b=2*L_b "Length of cylinder at frame_b"
    annotation (Dialog(tab="Animation", group="Cylinder at frame_b if animate = true", enable=animate));
  input Types.Color color_b={100,100,100} "Color of cylinder at frame_b"
    annotation (Dialog(colorSelector=true, tab="Animation", group="Cylinder at frame_b if animate = true", enable=animate));
  input Real massDiameterFaction=1.7
    "Diameter of point mass spheres with respect to cylinderDiameter_a"
    annotation (Dialog(tab="Animation", group="if animate = true and animateMasses = true", enable=animate and animateMasses));
  input Types.Color massColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
    "Color of point masses"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animate = true and animateMasses = true", enable=animate and animateMasses));

protected
  SI.Force fa "Force from flange_a";
  SI.Force fb "Force from flange_b";
  SI.Position r_CM1_0[3](each stateSelect=StateSelect.avoid)
    "Position vector from world frame to point mass 1, resolved in world frame";
  SI.Position r_CM2_0[3](each stateSelect=StateSelect.avoid)
    "Position vector from world frame to point mass 2, resolved in world frame";
  SI.Velocity v_CM1_0[3](each stateSelect=StateSelect.avoid)
    "der(r_CM_1_0) - velocity of point mass 1";
  SI.Velocity v_CM2_0[3](each stateSelect=StateSelect.avoid)
    "der(r_CM_2_0) - velocity of point mass 2";
  SI.Acceleration ag_CM1_0[3] "der(v_CM1_0) - gravityAcceleration(r_CM1_0)";
  SI.Acceleration ag_CM2_0[3] "der(v_CM2_0) - gravityAcceleration(r_CM2_0)";
  SI.Force aux1_0[3] "Auxiliary force 1";
  SI.Force aux2_0[3] "Auxiliary force 2";

  input SI.Length cylinderDiameter_b=cylinderDiameter_a*diameterFraction;
  input SI.Length massDiameter=cylinderDiameter_a*massDiameterFaction;
  parameter Boolean animateMasses2=world.enableAnimation and animate and animateMasses and m_a > 0 and m_b > 0;
  Visualizers.Advanced.Shape cylinder_a(
    shapeType="cylinder",
    color=color_a,
    specularCoefficient=specularCoefficient,
    length=cylinderLength_a,
    width=cylinderDiameter_a,
    height=cylinderDiameter_a,
    lengthDirection=e_rel_0,
    widthDirection={0,1,0},
    r=frame_a.r_0) if world.enableAnimation and animate;

  Visualizers.Advanced.Shape cylinder_b(
    shapeType="cylinder",
    color=color_b,
    specularCoefficient=specularCoefficient,
    length=cylinderLength_b,
    width=cylinderDiameter_b,
    height=cylinderDiameter_b,
    lengthDirection=-e_rel_0,
    widthDirection={0,1,0},
    r=frame_b.r_0) if world.enableAnimation and animate;

  Visualizers.Advanced.Shape sphere_a(
    shapeType="sphere",
    color=massColor,
    specularCoefficient=specularCoefficient,
    length=massDiameter,
    width=massDiameter,
    height=massDiameter,
    lengthDirection=e_rel_0,
    widthDirection={0,1,0},
    r_shape=e_rel_0*(L_a - massDiameter/2),
    r=frame_a.r_0) if animateMasses2;

  Visualizers.Advanced.Shape sphere_b(
    shapeType="sphere",
    color=massColor,
    specularCoefficient=specularCoefficient,
    length=massDiameter,
    width=massDiameter,
    height=massDiameter,
    lengthDirection=-e_rel_0,
    widthDirection={0,1,0},
    r_shape=-e_rel_0*(L_b - massDiameter/2),
    r=frame_b.r_0) if animateMasses2;

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

  /* Force and torque balance of the two point masses
     - Kinematics for center of masses CM1, CM2 of point masses including gravity
       (L = length, va = der(frame_a.r_0), vb = der(frame_b.r_0))
       r_CM1_0 = frame_a.r_0 + e_rel_0*L_a;
       r_CM2_0 = frame_b.r_0 - e_rel_0*L_b;
       v_CM1_0 = der(r_CM1_0);
       v_CM2_0 = der(r_CM2_0);
       ag_CM1_0 = der(v_CM1_0) - world.gravityAcceleration(r_CM1_0);
       ag_CM2_0 = der(v_CM2_0) - world.gravityAcceleration(r_CM2_0);
       der(e_rel_0) = der(r_rel_0/sqrt(r_rel_0*r_rel_0))
                    = 1/L*(I - e_rel_0*e_rel_0')*der(r_rel_0)
                    = 1/L*(I - e_rel_0*e_rel_0')*(vb - va)
       v_CM1_0 = va + L_a/L*(I - e_rel_0*e_rel_0')*(vb - va)
       v_CM2_0 = vb - L_b/L*(I - e_rel_0*e_rel_0')*(vb - va)
     - Power balance for the connection line
       (f1=force on frame_a side, f2=force on frame_b side)
       0 = f1*va - m_a*ag_CM1*v_CM1 + f2*vb - m_b*ag_CM2*v_CM2
         = f1*va - m_a*ag_CM1*(va + L_a/L*(I - e_rel*e_rel')*(vb - va)) +
           f2*vb - m_b*ag_CM2*(vb - L_b/L*(I - e_rel*e_rel')*(vb - va))
         = (f1 - m_a*ag_CM1*(I - L_a/L*(I - e_rel*e_rel'))
               - m_b*ag_CM2*(L_b/L*(I - e_rel*e_rel')))*va +
           (f2 - m_b*ag_CM2*(I - L_b/L*(I - e_rel_0*e_rel_0'))
               - m_a*ag_CM1*(L_a/L*(I - e_rel*e_rel')))*vb
         = va*(f1 - m_a*ag_CM1 +
               (m_a*ag_CM1*L_a/L - m_b*ag_CM2*L_b/L)*(I - e_rel*e_rel')) +
           vb*(f2 - m_b*ag_CM2 +
               (m_b*ag_CM2*L_b/L - m_a*ag_CM1*L_a/L)*(I - e_rel*e_rel'))
       since va and vb are completely independent from other
       the parenthesis must vanish:
         f1 := m_a*ag_CM1 - (m_a*ag_CM1*L_a/L - m_b*ag_CM2*L_b/L)*(I - e_rel*e_rel')
         f2 := m_b*ag_CM2 + (m_a*ag_CM1*L_a/L - m_b*ag_CM2*L_b/L)*(I - e_rel*e_rel')
       or
         aux1 := ag_CM1*(m_a*L_a/L) - ag_CM2*(m_b*L_b/L);
         aux2 := aux1 - (aux1'*e_rel)*e_rel
         f1 := m_a*ag_CM1 - aux2
         f2 := m_b*ag_CM2 + aux2
     - Force balance on frame_a and frame_b finally results in
         0 = frame_a.f + e_rel_a*fa - f1_a
         0 = frame_b.f + e_rel_b*fb - f2_b
       and therefore
         frame_a.f = -e_rel_a*fa + m_a*ag_CM1 - aux2
         frame_b.f = -e_rel_b*fb + m_b*ag_CM2 + aux2
  */
  if m_a > 0 or m_b > 0 then
    r_CM1_0 = frame_a.r_0 + e_rel_0*L_a;
    r_CM2_0 = frame_b.r_0 - e_rel_0*L_b;
    v_CM1_0 = der(r_CM1_0);
    v_CM2_0 = der(r_CM2_0);
    ag_CM1_0 = der(v_CM1_0) - world.gravityAcceleration(r_CM1_0);
    ag_CM2_0 = der(v_CM2_0) - world.gravityAcceleration(r_CM2_0);
    aux1_0 = ag_CM1_0*(m_a*L_a/length) - ag_CM2_0*(m_b*L_b/length);
    aux2_0 = aux1_0 - (aux1_0*e_rel_0)*e_rel_0;
    frame_a.f = Frames.resolve2(frame_a.R, m_a*ag_CM1_0 - aux2_0 - e_rel_0*fa);
    frame_b.f = Frames.resolve2(frame_b.R, m_b*ag_CM2_0 + aux2_0 - e_rel_0*fb);
  else
    r_CM1_0 = zeros(3);
    r_CM2_0 = zeros(3);
    v_CM1_0 = zeros(3);
    v_CM2_0 = zeros(3);
    ag_CM1_0 = zeros(3);
    ag_CM2_0 = zeros(3);
    aux1_0 = zeros(3);
    aux2_0 = zeros(3);
    frame_a.f = -Frames.resolve2(frame_a.R, e_rel_0*fa);
    frame_b.f = -Frames.resolve2(frame_b.R, e_rel_0*fb);
  end if;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
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
        Text(
          extent={{-150,-55},{150,-95}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-52,40},{48,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-74,15},{-45,-13}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{45,14},{74,-14}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Line(points={{-60,0},{-60,23},{-30,23},{-30,70},{-60,70},{-60,101}}),
        Line(points={{60,0},{60,20},{30,20},{30,70},{60,70},{60,100}}),
        Line(
          points={{-23,0},{25,0}},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{23,8},{39,-8}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-39,8},{-23,-8}},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,0},{-29,0}}),
        Line(points={{29,0},{60,0}}),
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
          extent={{-42,91},{30,79}},
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
          extent={{-49,39},{51,-41}},
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
        Line(points={{-60,0},{-60,24},{-40,24},{-40,60},{-60,60},{-60,110}}),
        Line(points={{60,1},{60,21},{40,21},{40,60},{60,60},{60,110}}),
        Line(
          points={{-60,0},{60,0}},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{20,8},{36,-8}},
          fillPattern=FillPattern.Solid),
        Line(points={{-18,-18},{11,-18}}, color={0,0,255}),
        Polygon(points={{23,-18},{11,-15},{11,-21},{23,-18}}, lineColor={0,0,
              255}),
        Line(points={{-60,16},{-37,16}}, color={0,0,255}),
        Line(points={{-25,0},{-25,20}}, color={0,0,255}),
        Text(
          extent={{-38,-20},{33,-35}},
          textString="e_rel_0"),
        Polygon(points={{-25,16},{-37,19},{-37,13},{-25,16}}, lineColor={0,0,
              255}),
        Text(
          extent={{-39,31},{-22,21}},
          textString="L_a"),
        Ellipse(
          extent={{-33,7},{-17,-9}},
          fillPattern=FillPattern.Solid),
        Line(points={{29,3},{29,22}}, color={0,0,255}),
        Line(points={{29,16},{60,16}}, color={0,0,255}),
        Polygon(points={{29,16},{41,19},{41,13},{29,16}}, lineColor={0,0,255}),
        Text(
          extent={{15,36},{32,26}},
          textString="L_b"),
        Line(
          points={{37,18},{30,27}},
          pattern=LinePattern.Dot,
          color={0,0,255})}),
    Documentation(info="<html>
<p>
This component is used to exert a <strong>line force</strong>
between the origin of frame_a and the origin of frame_b
by attaching components of the <strong>1-dimensional translational</strong>
mechanical library of Modelica (Modelica.Mechanics.Translational)
between the two flange connectors <strong>flange_a</strong> and
<strong>flange_b</strong>. Optionally, there are <strong>two point masses</strong> on the line
connecting the origin of frame_a and the origin of frame_b.
These point masses approximate the <strong>masses</strong> of the <strong>force element</strong>.
The locations of the two point masses are defined by their
(fixed) distances of L_a relative to frame_a and of L_b relative
to frame_b, respectively.
</p>
<p>
In example
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.LineForceWithTwoMasses\">
MultiBody.Examples.Elementary.LineForceWithTwoMasses</a> the usage of this
line force element is shown and is compared with an alternative
implementation using a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS\">
MultiBody.Joints.Assemblies.JointUPS</a> component.
The composition diagram of this example
is displayed in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/LineForceWithTwoMassesDiagram.png\">
</div>

<p>
The animation view at time = 0 is shown in the next figure.
The system on the left side in the front is the animation with
the LineForceWithTwoMasses component whereas the system on the right
side in the back is the animation with the JointUPS component.
Both implementations yield the same result. However, the implementation
with the LineForceWithTwoMasses component is simpler.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/LineForceWithTwoMasses2.png\">
</div>

<p>
In the translational library there is the implicit assumption that
forces of components that have only one flange connector act with
opposite sign on the bearings of the component. This assumption
is also used in the LineForceWithTwoMasses component: If a connection
is present to only one of the flange connectors, then the force
in this flange connector acts implicitly with opposite sign also
in the other flange connector.
</p>
</html>"));
end LineForceWithTwoMasses;
