within Modelica.Mechanics.MultiBody.Joints.Internal;
model RollingConstraintVerticalWheel
 "Rolling constraint for wheel that is always perpendicular to x-y plane"
 import Modelica.Mechanics.MultiBody.Frames;

   Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
   "Frame fixed in wheel center point. x-Axis: upwards, y-axis: along wheel axis"
     annotation (Placement(transformation(extent={{-16,4},{16,36}}),
         iconTransformation(extent={{-16,4},{16,36}})));

   parameter SI.Radius radius "Wheel radius";

   parameter Boolean lateralSlidingConstraint = true
   "= true, if lateral sliding constraint taken into account, = false if lateral force = 0 (needed to avoid overconstraining if two ideal rolling wheels are connect on one axis)"
                                                                                                       annotation(choices(checkBox=true),Evaluate=true);

   // Contact force
   SI.Force f_wheel_0[3]
   "Contact force acting on wheel, resolved in world frame";
   SI.Force f_lat "Contact force acting on wheel in lateral direction";
   SI.Force f_long
   "Contact force acting on wheel in longitudinal direction";
protected
    Real e_axis_0[3]
   "Unit vector along wheel axis, resolved in world frame";
    SI.Position rContact_0[3]
   "Distance vector from wheel center to contact point, resolved in world frame";

    // Coordinate system at contact point
    Real e_n_0[3]
   "Unit vector in normal direction of road at contact point, resolved in world frame";
    Real e_lat_0[3]
   "Unit vector in lateral direction of wheel at contact point, resolved in world frame";
    Real e_long_0[3]
   "Unit vector in longitudinal direction of wheel at contact point, resolved in world frame";

    // Slip velocities
    SI.Velocity v_0[3] "Velocity of wheel center, resolved in world frame";
    SI.AngularVelocity w_0[3]
   "Angular velocity of wheel, resolved in world frame";

    SI.Velocity vContact_0[3]
   "Velocity of wheel contact point, resolved in world frame";

    // Utility vectors
    Real aux[3];

equation
    // Coordinate system at contact point (e_long_0, e_lat_0, e_n_0)
    e_n_0    = {0,0,1};
    e_axis_0 = Frames.resolve1(frame_a.R, {0,1,0});
    aux      = cross(e_n_0, e_axis_0);
    e_long_0 = aux / Modelica.Math.Vectors.length(aux);
    e_lat_0  = cross(e_long_0, e_n_0);

    // Slip velocities
    rContact_0 = {0,0,-radius};
    v_0 = der(frame_a.r_0);
    w_0 = Frames.angularVelocity1(frame_a.R);
    vContact_0 = v_0 + cross(w_0, rContact_0);

    // Two non-holonomic constraint equations on velocity level (ideal rolling, no slippage)
    0 = vContact_0*e_long_0;
    if lateralSlidingConstraint then
       0 = vContact_0*e_lat_0;
       f_wheel_0 = f_lat*e_lat_0 + f_long*e_long_0;
    else
       0 = f_lat;
       f_wheel_0 = f_long*e_long_0;
    end if;

    // Force and torque balance at the wheel center
    zeros(3) = frame_a.f + Frames.resolve2(frame_a.R, f_wheel_0);
    zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, cross(rContact_0, f_wheel_0));
   annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
             -100},{100,100}}), graphics={
         Rectangle(
           extent={{-100,-60},{100,-80}},
           fillColor={175,175,175},
           fillPattern=FillPattern.Solid),
         Text(
           extent={{-148,-86},{152,-126}},
           textColor={0,0,255},
           textString="%name"),
         Line(
           points={{0,-60},{0,4}},
           pattern=LinePattern.Dot),
         Line(
           visible=lateralSlidingConstraint,
           points={{-98,-30},{-16,-30}}),
         Polygon(
           visible=lateralSlidingConstraint,
           points={{-40,-16},{-40,-42},{-6,-30},{-40,-16}},
           fillColor={255,255,255},
           fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Joint for a wheel rolling on the x-y plane of the world frame
intended for an idealized wheelset.
To meet this objective, the wheel always runs upright and enables no
slip in the longitudinal direction of the wheel/ground contact.
</p>
<p>
On the contrary, the wheel can optionally slip in the lateral direction
which is reasonable for the wheelset where just one of the wheels
should be laterally constrained.
</p>
<p>
The frame frame_a is placed in the intersection of the wheel spin axis
with the wheel middle plane and rotates with the wheel itself.
A wheel body collecting the mass and inertia should be connected to
this frame.
</p>

<h4>Note</h4>
<p>
To work properly, the gravity acceleration vector g of the world must point in the negative z-axis, i.e.
</p>
<blockquote><pre>
<span style=\"font-family:'Courier New',courier; color:#0000ff;\">inner</span> <span style=\"font-family:'Courier New',courier; color:#ff0000;\">Modelica.Mechanics.MultiBody.World</span> world(n={0,0,-1});
</pre></blockquote>
</html>"));
end RollingConstraintVerticalWheel;
