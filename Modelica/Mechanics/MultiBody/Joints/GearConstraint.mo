within Modelica.Mechanics.MultiBody.Joints;
model GearConstraint "Ideal 3-dim. gearbox (arbitrary shaft directions)"
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Interfaces.Frame_a bearing "Coordinate system fixed in the bearing"
   annotation (Placement(transformation(
        origin={0,-100},
        extent={{-16,-16},{16,16}},
        rotation=90)));

  parameter Real ratio(start=2) "Gear speed ratio";

  parameter Modelica.Mechanics.MultiBody.Types.Axis n_a={1,0,0}
    "Axis of rotation of shaft a (same coordinates in frame_a, frame_b, bearing)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={1,0,0}
    "Axis of rotation of shaft b (same coordinates in frame_a, frame_b, bearing)";

  parameter SI.Position r_a[3]={0,0,0}
    "Vector from frame bearing to frame_a resolved in bearing";
  parameter SI.Position r_b[3]={0,0,0}
    "Vector from frame bearing to frame_b resolved in bearing";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use joint coordinates (phi_a, phi_b, w_a, w_b) as states" annotation(Dialog(tab="Advanced"));
  parameter Boolean checkTotalPower=false
    "= true, if total power flowing into this component shall be determined (must be zero)"
    annotation (Dialog(tab="Advanced"));

  SI.Angle phi_b(start=0, stateSelect=stateSelect)
    "Relative rotation angle of revolute joint at frame_b";
  SI.AngularVelocity w_b(start=0, stateSelect=stateSelect)
    "First derivative of angle phi_b (relative angular velocity b)";
  SI.AngularAcceleration a_b(start=0)
    "Second derivative of angle phi_b (relative angular acceleration b)";
  SI.Power totalPower
    "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";

  Modelica.Mechanics.MultiBody.Joints.Revolute actuatedRevolute_a(
    useAxisFlange=true,
    n=n_a,
    animation=false) annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute actuatedRevolute_b(
    useAxisFlange=true,
    n=n_b,
    animation=false) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear(
                                                    ratio=ratio)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation1(animation=false, r=r_b)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation2(animation=false, r=r_a)
    annotation (Placement(transformation(
        origin={-20,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  /* Implementation notes:

     The GearConstraint model consists primarily of two revolute joints that are
     connected together and to a support/mounting. In this first phase the two
     revolute joints can be rotated independently from each other and therefore
     there are two degrees of freedom. If the rotational angles of these joints
     would be used as generalized coordinates phi_a, phi_b with associated generalized
     torques tau_a, tau_b (torques along the axes of rotations), then the equations
     of motion (Kane&#39;s equations or Lagrange&#39;s equations of the second kind) are
     in the rows for phi_a, phi_b:
        .... = ... + {...., tau_a, tau_b, ....}

     Now the kinematic constraint for the gear is added:

         0 = phi_a - ratio*phi_b;

     or on velocity level:

         0 = G * {der(phi_a), der(phi_b)};   G = [1, -ratio]

     According to Lagrange&#39;s equations of the first kind, the generalized forces
     must be replaced by G'*lambda, where lambda is the new constraint force
     due this constraint. Therefore, the equations of motions are changed to

       .... = .... + {...., G'*lambda, .....}

     This is equivalent to add the equations

       tau_a = lambda
       tau_b = -ratio*lambda

     or

       0 = tau_b + ratio*tau_a;

     The two equations

       0 = phi_a - ratio*phi_b
       0 = tau_b + ratio*tau_a

     are completely identical to the equations of an ideal gear (without mounting)
     that connects the axis flanges of the two revolute joints. This in turn
     means that the two rotational flanges of the revolute joints just have to be
     connected by an IdealGear component (without mounting).
  */
  assert(cardinality(bearing) > 0,
    "Connector bearing of component is not connected");

  phi_b = actuatedRevolute_b.phi;
  w_b = der(phi_b);
  a_b = der(w_b);

  // Measure power for test purposes
  if checkTotalPower then
    totalPower =
      frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) +
      bearing.f*Frames.resolve2(bearing.R, der(bearing.r_0)) +
      frame_a.t*Frames.angularVelocity2(frame_a.R) +
      frame_b.t*Frames.angularVelocity2(frame_b.R) +
      bearing.t*Frames.angularVelocity2(bearing.R);
  else
    totalPower = 0;
  end if;

  connect(actuatedRevolute_a.axis, idealGear.flange_a)
    annotation (Line(points={{-50,10},{-50,40},{-10,40}}));
  connect(idealGear.flange_b, actuatedRevolute_b.axis)
    annotation (Line(points={{10,40},{50,40},{50,10}}));
  connect(actuatedRevolute_a.frame_a,fixedTranslation2. frame_b) annotation (Line(
      points={{-40,0},{-35,0},{-30,0}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation2.frame_a, bearing) annotation (Line(
      points={{-10,0},{-4,0},{0,0},{0,-100}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_a, bearing)
    annotation (Line(
      points={{10,0},{0,0},{0,-100}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_b, actuatedRevolute_b.frame_a)
    annotation (Line(
      points={{30,0},{40,0}},
      color={95,95,95},
      thickness=0.5));
  connect(frame_a, actuatedRevolute_a.frame_b)
    annotation (Line(
      points={{-100,0},{-80,0},{-80,0},{-60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(actuatedRevolute_b.frame_b, frame_b)
    annotation (Line(
      points={{60,0},{80,0},{80,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
      Rectangle(origin = {-35,60},
        fillColor = {255,255,255},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-15,-40},{15,40}}),
      Rectangle(origin = {-35,0},
        fillColor = {255,255,255},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-15,-21},{15,21}}),
      Line(points = {{-80,20},{-60,20}}),
      Line(points = {{-80,-20},{-60,-20}}),
      Line(points = {{-70,-20},{-70,-86}}),
      Line(points = {{0,40},{0,-100}}),
      Line(points = {{-10,40},{10,40}}),
      Line(points = {{-10,80},{10,80}}),
      Line(points = {{60,-20},{80,-20}}),
      Line(points = {{60,20},{80,20}}),
      Line(points = {{70,-20},{70,-86}}),
      Rectangle(origin = {-75,0},
        lineColor = {64,64,64},
        fillColor = {191,191,191},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-25,-10},{25,10}}),
      Rectangle(origin = {75,0},
        lineColor = {64,64,64},
        fillColor = {191,191,191},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-25,-10},{25,10}}),
      Rectangle(origin = {-35,-19},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {-35,-8},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {-35,19},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {-35,8},
        fillColor = {255,255,255},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {0,60},
        lineColor = {64,64,64},
        fillColor = {191,191,191},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-20,-10},{20,10}}),
      Rectangle(origin = {-35,98},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {-35,87},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {-35,50},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-4},{15,4}}),
      Rectangle(origin = {-35,22},
        fillColor = {102,102,102},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {-35,33},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {-35,70},
        fillColor = {255,255,255},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-4},{15,4}}),
      Rectangle(origin = {35,60},
        fillColor = {255,255,255},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-15,-21},{15,21}}),
      Rectangle(origin = {35,41},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {35,52},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {35,79},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {35,68},
        fillColor = {255,255,255},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {35,0},
        fillColor = {255,255,255},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-15,-40},{15,40}}),
      Rectangle(origin = {35,38},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {35,27},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {35,-10},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-4},{15,4}}),
      Rectangle(origin = {35,-27},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {35,10},
        fillColor = {255,255,255},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-4},{15,4}}),
      Rectangle(origin = {-35,40},
        fillColor = {255,255,255},
        extent = {{-15,-61},{15,60}}),
      Rectangle(origin = {35,21},
        fillColor = {255,255,255},
        extent = {{-15,-61},{15,60}}),
      Line(points = {{70,-86},{-70,-86}}),
      Text(
        extent={{-150,-80},{150,-50}},
        textString = "%ratio"),
      Text(
          textColor={0,0,255},
          extent={{-150,150},{150,110}},
          textString="%name")}),
    Documentation(info="<html>
<p>This ideal massless joint provides a gear constraint between
frames <code>frame_a</code> and <code>frame_b</code>. The axes of rotation
of <code>frame_a</code> and <code>frame_b</code> may be arbitrary.</p>
<p><strong>Reference</strong><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1-dim. Powertrains</a>. In: <em>Proceedings of the 3rd International
Modelica Conference</em>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>
</html>"));
end GearConstraint;
