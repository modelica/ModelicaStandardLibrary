within Modelica.Mechanics.MultiBody;
package Sensors "Sensors to measure variables" 
  model AbsoluteSensor 
    "Measure absolute kinematic quantities of a frame connector" 
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Frames;
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialAbsoluteSensor(final n_out=3*((if get_r_abs then 1 else 
                  0) + (if get_v_abs then 1 else 0) + (if get_a_abs then 1 else 
                  0) + (if get_angles then 1 else 0) + (if get_w_abs then 1 else 
                  0) + (if get_z_abs then 1 else 0)));
    Interfaces.Frame_resolve frame_resolve 
      "If connected, the output signals are resolved in this frame" 
      annotation (Placement(transformation(
          origin={0,100},
          extent={{-16,-16},{16,16}},
          rotation=270)));
    parameter Boolean animation=true 
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean resolveInFrame_a=false 
      "= true, if vectors are resolved in frame_a, otherwise in the world frame (if connector frame_resolve is connected, vectors are resolved in frame_resolve)";
    parameter Boolean get_r_abs=true 
      "= true, to measure the position vector from the origin of the world frame to the origin of frame_a in [m]";
    parameter Boolean get_v_abs=false 
      "= true, to measure the absolute velocity of the origin of frame_a in [m/s]";
    parameter Boolean get_a_abs=false 
      "= true, to measure the absolute acceleration of the origin of frame_a in [m/s^2]";
    parameter Boolean get_angles=false 
      "= true, to measure the 3 rotation angles to rotate the world frame into frame_a along the axes defined in 'sequence' below in [rad]";
    parameter Boolean get_w_abs=false 
      "= true, to measure the absolute angular velocity of frame_a in [rad/s]";
    parameter Boolean get_z_abs=false 
      "= true, to measure the absolute angular acceleration to frame_a in [rad/s^2]";
    parameter Types.RotationSequence sequence(
      min={1,1,1},
      max={3,3,3}) = {1,2,3} 
      " Angles are returned to rotate world frame around axes sequence[1], sequence[2] and finally sequence[3] into frame_a"
      annotation (Evaluate=true, Dialog(group="if get_angles = true", enable=get_angles));
    parameter SI.Angle guessAngle1=0 
      " Select angles[1] such that abs(angles[1] - guessAngle1) is a minimum" 
      annotation (Dialog(group="if get_angles = true", enable=get_angles));
    input SI.Diameter arrowDiameter=world.defaultArrowDiameter 
      " Diameter of arrow from world frame to frame_a" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
      " Color of arrow from world frame to frame_a" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    
    annotation (
      preferedView="info",
      Icon(graphics={
          Text(
            extent={{19,109},{150,84}}, 
            lineColor={192,192,192}, 
            textString="resolve"), 
          Line(
            points={{-84,0},{-84,84},{0,84},{0,100}}, 
            color={95,95,95}, 
            pattern=LinePattern.Dot), 
          Text(
            extent={{-132,52},{-96,27}}, 
            lineColor={128,128,128}, 
            textString="a")}),
      Diagram(graphics={Line(
            points={{-84,0},{-84,82},{0,82},{0,98}}, 
            color={95,95,95}, 
            pattern=LinePattern.Dot)}),
      Documentation(info="<HTML>
<p>
Absolute kinematic quantities of frame_a are
computed and provided at the output signal connector <b>y</b>
in packed format in the order
</p>
<ol>
<li> absolute position vector (= r_abs)</li>
<li> absolute velocity vectory (= v_abs)</li>
<li> absolute acceleration vector (= a_abs)</li> 
<li> 3 angles to rotate the world frame into frame_a (= angles)</li>
<li> absolute angular velocity vector (= w_abs)</li>
<li> absolute angular acceleration vector (= z_abs)</li>
</ol>
<p>
For example, if parameters <b>get_v</b> and <b>get_w</b>
are <b>true</b> and all other get_XXX parameters are <b>false</b>, then
y contains 6 elements:
</p>
<pre>
 y[1:3] = absolute velocity
 y[4:6] = absolute angular velocity
</pre>
<p>
In the following figure the animation of an AbsoluteSensor
component is shown. The light blue coordinate system is
frame_a and the yellow arrow is the animated sensor.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Sensors/AbsoluteSensor.png\">
</p>
<p>
If <b>frame_resolve</b> is connected to another frame, then the
provided absolute kinematic vectors are resolved in this frame.
If <b>frame_resolve</b> is <b>not</b> connected then the
coordinate system in which the relative quantities are
resolved is defined by parameter <b>resolveInFrame_a</b>.
If this parameter is <b>true</b>, then the
provided kinematic vectors are resolved in frame_a of this
component. Otherwise, the kinematic vectors are resolved in 
the world frame. For example, if frame_resolve is not
connected and if resolveInFrame_a = <b>false</b>, and
get_v = <b>true</b>, then
</p>
<pre>
  y = <b>der</b>(frame_a.r) // resolved in world frame 
</pre>
<p>
is returned, i.e., the derivative of the distance frame_a.r_0
from the origin of the world frame to the origin of frame_a, 
resolved in the world frame.
</p>
<p>
Note, the cut-force and the cut-torque in frame_resolve are
always zero, whether frame_resolve is connected or not.
</p>
<p>
If <b>get_angles</b> = <b>true</b>, the 3 angles to rotate the world 
frame into frame_a along the axes defined by parameter <b>sequence</b>
are returned. For example, if sequence = {3,1,2} then the world frame is
rotated around angles[1] along the z-axis, afterwards it is rotated
around angles[2] along the x-axis, and finally it is rotated around
angles[3] along the y-axis and is then identical to frame_a.
The 3 angles are returned in the range
</p>
<pre>
    -<font face=\"Symbol\">p</font> &lt;= angles[i] &lt;= <font face=\"Symbol\">p</font>
</pre>
<p>
There are <b>two solutions</b> for \"angles[1]\" in this range.
Via parameter <b>guessAngle1</b> (default = 0) the
returned solution is selected such that |angles[1] - guessAngle1| is
minimal. The transformation matrix between the world frame and
frame_a may be in a singular configuration with respect to \"sequence\", i.e.,
there is an infinite number of angle values leading to the same
transformation matrix. In this case, the returned solution is
selected by setting angles[1] = guessAngle1. Then angles[2]
and angles[3] can be uniquely determined in the above range.
</p>
<p>
Note, that parameter <b>sequence</b> has the restriction that
only values 1,2,3 can be used and that sequence[1] &ne; sequence[2]
and sequence[2] &ne; sequence[3]. Often used values are:
</p>
<pre>
  sequence = <b>{1,2,3}</b>  // Cardan angle sequence
           = <b>{3,1,3}</b>  // Euler angle sequence
           = <b>{3,2,1}</b>  // Tait-Bryan angle sequence
</pre>
<p>
Exact definition of the returned quantities:
</p>
<ol>
<li>r_abs is vector frame_a.r_0, resolved according to table below.</li>
<li>v_abs is vector <b>der</b>(frame_a.r_0), resolved according to table below.</li>
<li>a_abs is vector <b>der</b>(<b>der</b>(frame_a.r_0)), resolved according to 
            table below.</li>
<li>angles is a vector of 3 angles such that
    frame_a.R = Frames.axesRotations(sequence, angles).</li>
<li>w_abs is vector Modelica.Mechanics.MultiBody.Frames.angularVelocity1(frame_a.R, <b>der</b>(frame_a.R)),
            resolved according to table below.</li>
<li>z_abs is vector <b>der</b>(w_abs) (= derivative of absolute angular 
            velocity of frame_a with respect to the world frame,
            resolved according to table below).</li> 
</ol>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>frame_resolve is</i></b></th>
      <th><b><i>resolveInFrame_a =</i></b></th>
      <th><b><i>vector is resolved in</i></b></th>
  </tr>
  <tr><td valign=\"top\">connected</td>
      <td valign=\"top\">true</td>
      <td valign=\"top\"><b>frame_resolve</b></td>
  </tr>
  <tr><td valign=\"top\">connected</td>
      <td valign=\"top\">false</td>
      <td valign=\"top\"><b>frame_resolve</b></td>
  </tr>
  <tr><td valign=\"top\">not connected</td>
      <td valign=\"top\">true</td>
      <td valign=\"top\"><b>frame_a</b></td>
  </tr>
  <tr><td valign=\"top\">not connected</td>
      <td valign=\"top\">false</td>
      <td valign=\"top\"><b>world frame</b></td>
  </tr>
</table><br>
</HTML>
"));
    
  protected 
    SI.Position r_abs[3] 
      "Dummy or position vector from origin of the world frame to origin of frame_a (resolved in frame_resolve, frame_a or world frame)";
    SI.Velocity v_abs[3] 
      "Dummy or velocity of origin of frame_a with respect to origin of world frame (resolved in frame_resolve, frame_a or world frame)";
    SI.Acceleration a_abs[3] 
      "Dummy or acceleration of origin of frame_a with respect to origin of word frame (resolved in frame_resolve, frame_a or world frame)";
    SI.Angle angles[3] 
      "Dummy or angles to rotate world frame into frame_a via 'sequence'";
    SI.AngularVelocity w_abs[3] 
      "Dummy or angular velocity of frame_a with respect to world frame (resolved in frame_resolve, frame_a or world frame)";
    SI.AngularAcceleration z_abs[3] 
      "Dummy or angular acceleration of frame_a with respect to world frame (resolved in frame_resolve, frame_a or world frame)";
    
    SI.Velocity v_abs_0[3] 
      "Dummy or absolute velocity of origin of frame_a resolved in world frame";
    SI.AngularVelocity w_abs_0[3] 
      "Dummy or absolute angular velocity of frame_a resolved in world frame";
    parameter Integer i1=1;
    parameter Integer i2=if get_r_abs then i1 + 3 else i1;
    parameter Integer i3=if get_v_abs then i2 + 3 else i2;
    parameter Integer i4=if get_a_abs then i3 + 3 else i3;
    parameter Integer i5=if get_angles then i4 + 3 else i4;
    parameter Integer i6=if get_w_abs then i5 + 3 else i5;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
      r_head=frame_a.r_0,
      diameter=arrowDiameter,
      specularCoefficient=specularCoefficient,
      color=arrowColor) if world.enableAnimation and animation;
  equation 
    if get_angles then
      angles = Frames.axesRotationsAngles(frame_a.R, sequence, guessAngle1);
    else
      angles = zeros(3);
    end if;
    
    if cardinality(frame_resolve) == 1 then
      // frame_resolve is connected
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);
      
      if get_r_abs then
        r_abs = Frames.resolve2(frame_resolve.R, frame_a.r_0);
      else
        r_abs = zeros(3);
      end if;
      
      if get_v_abs or get_a_abs then
        v_abs_0 = der(frame_a.r_0);
        v_abs = Frames.resolve2(frame_resolve.R, v_abs_0);
      else
        v_abs_0 = zeros(3);
        v_abs = zeros(3);
      end if;
      
      if get_a_abs then
        a_abs = Frames.resolve2(frame_resolve.R, der(v_abs_0));
      else
        a_abs = zeros(3);
      end if;
      
      if get_w_abs or get_z_abs then
        w_abs_0 = Modelica.Mechanics.MultiBody.Frames.angularVelocity1(frame_a.R);
        w_abs = Frames.resolve2(frame_resolve.R, w_abs_0);
      else
        w_abs_0 = zeros(3);
        w_abs = zeros(3);
      end if;
      
      if get_z_abs then
        z_abs = Frames.resolve2(frame_resolve.R, der(w_abs_0));
      else
        z_abs = zeros(3);
      end if;
    else
      // frame_resolve is NOT connected
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();
      
      if get_r_abs then
        if resolveInFrame_a then
          r_abs = Modelica.Mechanics.MultiBody.Frames.resolve2(frame_a.R, frame_a.r_0);
        else
          r_abs = frame_a.r_0;
        end if;
      else
        r_abs = zeros(3);
      end if;
      
      if get_v_abs or get_a_abs then
        v_abs_0 = der(frame_a.r_0);
        if resolveInFrame_a then
          v_abs = Modelica.Mechanics.MultiBody.Frames.resolve2(frame_a.R, v_abs_0);
        else
          v_abs = v_abs_0;
        end if;
      else
        v_abs_0 = zeros(3);
        v_abs = zeros(3);
      end if;
      
      if get_a_abs then
        if resolveInFrame_a then
          a_abs = Modelica.Mechanics.MultiBody.Frames.resolve2(frame_a.R, der(v_abs_0));
        else
          a_abs = der(v_abs_0);
        end if;
      else
        a_abs = zeros(3);
      end if;
      
      w_abs_0 = zeros(3);
      if get_w_abs or get_z_abs then
        if resolveInFrame_a then
          w_abs = Modelica.Mechanics.MultiBody.Frames.angularVelocity2(frame_a.R);
        else
          w_abs = Modelica.Mechanics.MultiBody.Frames.angularVelocity1(frame_a.R);
        end if;
      else
        w_abs = zeros(3);
      end if;
      
      if get_z_abs then
        /* if w_abs and z_abs are resolved in the world frame, we have
            z_abs = der(w_abs)
         if w_abs and z_abs are resolved in frame_a, we have
            z_abs = R*der(transpose(R)*w_abs)
                  = R*(der(transpose(R))*w_abs + transpose(R)*der(w_abs)))
                  = R*(transpose(R)*R*der(transpose(R))*w_abs + transpose(R)*der(w_abs)))
                  = skew(w_abs)*w_abs + der(w_abs)
                  = der(w_abs)  // since cross(w_abs, w_abs) = 0
      */
        z_abs = der(w_abs);
      else
        z_abs = zeros(3);
      end if;
    end if;
    
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    
    if get_r_abs then
      y[i1:i1 + 2] = r_abs;
    end if;
    
    if get_v_abs then
      y[i2:i2 + 2] = v_abs;
    end if;
    
    if get_a_abs then
      y[i3:i3 + 2] = a_abs;
    end if;
    
    if get_angles then
      y[i4:i4 + 2] = angles;
    end if;
    
    if get_w_abs then
      y[i5:i5 + 2] = w_abs;
    end if;
    
    if get_z_abs then
      y[i6:i6 + 2] = z_abs;
    end if;
  end AbsoluteSensor;
  extends Modelica.Icons.Library;
  
  model RelativeSensor 
    "Measure relative kinematic quantities between two frame connectors" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Frames;
    import Modelica.Mechanics.MultiBody.Types;
    
    extends Interfaces.PartialRelativeSensor(final n_out=3*((if 
            get_r_rel then 1 else 0) + (if get_v_rel then 1 else 0) + (if 
            get_a_rel then 1 else 0) + (if get_angles then 1 else 0) + (if 
            get_w_rel then 1 else 0) + (if get_z_rel then 1 else 0)));
    Interfaces.Frame_resolve frame_resolve 
      "If connected, the output signals are resolved in this frame" 
      annotation (Placement(transformation(
          origin={-60,-100},
          extent={{-16,-16},{16,16}},
          rotation=270)));
    
    parameter Boolean animation=true 
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean resolveInFrame_a=true 
      "= true, if relative vectors from frame_a to frame_b are resolved before differentiation in frame_a, otherwise in frame_b. If frame_resolve is connected, the vector and its derivatives are resolved in frame_resolve";
    parameter Boolean get_r_rel=true 
      "= true, to measure the relative position vector from the origin of frame_a to the origin of frame_b in [m]";
    parameter Boolean get_v_rel=false 
      "= true, to measure the relative velocity of the origin of frame_b with respect to frame_a in [m/s]";
    parameter Boolean get_a_rel=false 
      "= true, to measure the relative acceleration of the origin of frame_b with respect to frame_a in [m/s^2]";
    parameter Boolean get_angles=false 
      "= true, to measure the 3 rotation angles to rotate frame_a into frame_b along the axes defined in 'sequence' below in [rad]";
    parameter Boolean get_w_rel=false 
      "= true, to measure the relative angular velocity of frame_b with respect to frame_a in [rad/s]";
    parameter Boolean get_z_rel=false 
      "= true, to measure the relative angular acceleration of frame_b with respect to frame_a in [rad/s^2]";
    parameter Types.RotationSequence sequence(
      min={1,1,1},
      max={3,3,3}) = {1,2,3} 
      " Angles are returned to rotate frame_a around axes sequence[1], sequence[2] and finally sequence[3] into frame_b"
      annotation (Evaluate=true, Dialog(group="if get_angles = true", enable=get_angles));
    parameter SI.Angle guessAngle1=0 
      " Select angles[1] such that abs(angles[1] - guessAngle1) is a minimum" 
      annotation (Dialog(group="if get_angles = true", enable=get_angles));
    input SI.Diameter arrowDiameter=world.defaultArrowDiameter 
      " Diameter of relative arrow from frame_a to frame_b" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
      " Color of relative arrow from frame_a to frame_b" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    
    SI.Position r_rel[3] 
      "Dummy or relative position vector (resolved in frame_a, frame_b or frame_resolve)";
    SI.Velocity v_rel[3] 
      "Dummy or relative velocity vector (resolved in frame_a, frame_b or frame_resolve";
    SI.Acceleration a_rel[3] 
      "Dummy or relative acceleration vector (resolved in frame_a, frame_b or frame_resolve";
    SI.Angle angles[3] 
      "Dummy or angles to rotate frame_a into frame_b via 'sequence'";
    SI.AngularVelocity w_rel[3] 
      "Dummy or relative angular velocity vector (resolved in frame_a, frame_b or frame_resolve";
    SI.AngularAcceleration z_rel[3] 
      "Dummy or relative angular acceleration vector (resolved in frame_a, frame_b or frame_resolve";
    Frames.Orientation R_rel 
      "Dummy or relative orientation object from frame_a to frame_b";
  protected 
    SI.Position r_rel_ab[3] 
      "Dummy or relative position vector resolved in frame_a or frame_b";
    SI.Velocity der_r_rel_ab[3] 
      "Dummy or derivative of relative position vector (resolved in frame_a, frame_b or frame_resolve)";
    SI.AngularVelocity w_rel_ab[3] 
      "Dummy or angular velocity of frame_b with respect to frame_a (resolved in frame_a or frame_b)";
    Frames.Orientation R_resolve 
      "Dummy or relative orientation of frame_a or frame_b with respect to frame_resolve";
    
    parameter Integer i1=1;
    parameter Integer i2=if get_r_rel then i1 + 3 else i1;
    parameter Integer i3=if get_v_rel then i2 + 3 else i2;
    parameter Integer i4=if get_a_rel then i3 + 3 else i3;
    parameter Integer i5=if get_angles then i4 + 3 else i4;
    parameter Integer i6=if get_w_rel then i5 + 3 else i5;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
      r=frame_a.r_0,
      r_head=frame_b.r_0 - frame_a.r_0,
      diameter=arrowDiameter,
      color=arrowColor,
      specularCoefficient) if world.enableAnimation and animation;
    annotation (
      preferedView="info",
      Icon(graphics={Line(
            points={{-60,-94},{-60,-76},{0,-76},{0,-76}}, 
            color={95,95,95}, 
            pattern=LinePattern.Dot), Text(
            extent={{-157,-49},{-26,-74}}, 
            lineColor={192,192,192}, 
            pattern=LinePattern.Dot, 
            textString="resolve")}),
      Diagram(graphics={Line(
            points={{-60,-98},{-60,-76},{0,-76},{0,-76}}, 
            color={95,95,95}, 
            pattern=LinePattern.Dot)}),
      Documentation(info="<HTML>
<p>
Relative kinematic quantities between frame_a and frame_b are
determined and provided at the output signal connector <b>y</b>
in packed format in the order
</p>
<ol>
<li> relative position vector (= r_rel)</li>
<li> relative velocity vectory (= v_rel)</li>
<li> relative acceleration vector (= a_rel))</li> 
<li> 3 angles to rotate frame_a into frame_b (= angles)</li>
<li> relative angular velocity vector (= w_rel)</li>
<li> relative angular acceleration vector (= z_rel)</li>
</ol>
<p>
For example, if parameters <b>get_v_rel</b> and <b>get_w_rel</b>
are <b>true</b> and all other get_XXX parameters are <b>false</b>, then
y contains 6 elements:
</p>
<pre>
 y = relative velocity
 y = relative angular velocity
</pre>
<p>
In the following figure the animation of a RelativeSensor
component is shown. The light blue coordinate system is
frame_a, the dark blue coordinate system is frame_b, and
the yellow arrow is the animated sensor.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Sensors/RelativeSensor.png\">
</p>
<p>
If parameter <b>resolveInFrame_a</b> = <b>true</b>, then the
provided relative kinematic vectors of frame_b with respect to
frame_a are resolved before differentiation in frame_a. If this 
parameter is <b>false</b>, the relative kinematic vectors are 
resolved before differentiation in frame_b.
If <b>frame_resolve</b> is connected to another frame, then the
kinematic vector as defined above and/or its required derivatives 
are resolved in frame_resolve. Note, derivatives
of relative kinematic quantities are always performed with
respect to frame_a (<b>resolveInFrame_a</b> = <b>true</b>)
or with respect to frame_b (<b>resolveInFrame_a</b> = <b>false</b>).
The resulting vector is then resolved in frame_resolve, if this
connector is connected.
</p>
<p>
For example, if frame_resolve is not
connected and if resolveInFrame_a = <b>false</b>, and
get_v = <b>true</b>, then
</p>
<pre>
  y = v_rel 
    = <b>der</b>(r_rel)
</pre>
is returned (r_rel = resolve2(frame_b.R, frame_b.r_0 - frame_a.r0)), i.e.,
the derivative of the relative distance from frame_a to frame_b, 
resolved in frame_b. If frame_resolve is connected, then
</p>
<pre>
  y = v_rel 
    = resolve2(frame_resolve.R, <b>der</b>(r_rel))
</pre>
<p>
is returned, i.e., the previous relative velocity vector is
additionally resolved in frame_resolve.
</p>
<p>
Note, the cut-force and the cut-torque in frame_resolve are
always zero, whether frame_resolve is connected or not.
</p>
<p>
If <b>get_angles</b> = <b>true</b>, the 3 angles to rotate frame_a
into frame_b along the axes defined by parameter <b>sequence</b>
are returned. For example, if sequence = {3,1,2} then frame_a is
rotated around angles[1] along the z-axis, afterwards it is rotated
around angles[2] along the x-axis, and finally it is rotated around
angles[3] along the y-axis and is then identical to frame_b.
The 3 angles are returned in the range
</p>
<pre>
    -<font face=\"Symbol\">p</font> &lt;= angles[i] &lt;= <font face=\"Symbol\">p</font>
</pre>
<p>
There are <b>two solutions</b> for \"angles[1]\" in this range.
Via parameter <b>guessAngle1</b> (default = 0) the
returned solution is selected such that |angles[1] - guessAngle1| is
minimal. The relative transformation matrix between frame_a and
frame_b may be in a singular configuration with respect to \"sequence\", i.e.,
there is an infinite number of angle values leading to the same relative
transformation matrix. In this case, the returned solution is
selected by setting angles[1] = guessAngle1. Then angles[2]
and angles[3] can be uniquely determined in the above range.
</p>
<p>
Note, that parameter <b>sequence</b> has the restriction that
only values 1,2,3 can be used and that sequence[1] &ne; sequence[2]
and sequence[2] &ne; sequence[3]. Often used values are:
</p>
<pre>
  sequence = <b>{1,2,3}</b>  // Cardan angle sequence
           = <b>{3,1,3}</b>  // Euler angle sequence
           = <b>{3,2,1}</b>  // Tait-Bryan angle sequence
</pre>
<p>
Exact definition of the returned quantities
(r_rel_ab, R_rel_ab, w_rel_ab are defined below the enumeration):
</p>
<ol>
<li>r_rel is vector r_rel_ab, resolved according to table below.</li>
<li>v_rel is vector <b>der</b>(r_rel_ab), resolved according to table below.</li>
<li>a_rel is vector <b>der</b>(<b>der</b>(r_rel_ab)), resolved according to 
            table below.</li>
<li>angles is a vector of 3 angles such that
    R_rel_ab = Frames.axesRotations(sequence, angles).</li>
<li>w_rel is vector w_rel_ab, resolved according to table below.</li>
<li>z_rel is vector <b>der</b>(w_rel_ab), resolved according to table below.</li>
</ol>
<p>
using the auxiliary quantities
</p>
<ol>
<li> r_rel_ab is vector frame_b.r_0 - frame_a.r_0, resolved either in frame_a or
     frame_b according to parameter resolveInFrame_a.</li>
<li> R_rel_ab is orientation object Frames.relativeRotation(frame_a.R, frame_b.R).</li>
<li> w_rel_ab is vector Frames.angularVelocity1(R_rel_ab, der(R_rel_ab)), resolved either
     in frame_a or frame_b according to parameter resolveInFrame_a.</li>
</ol>
<p>
and resolved in the following frame
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>frame_resolve is</i></b></th>
      <th><b><i>resolveInFrame_a =</i></b></th>
      <th><b><i>vector is resolved in</i></b></th>
  </tr>
  <tr><td valign=\"top\">connected</td>
      <td valign=\"top\">true</td>
      <td valign=\"top\"><b>frame_resolve</b></td>
  </tr>
  <tr><td valign=\"top\">connected</td>
      <td valign=\"top\">false</td>
      <td valign=\"top\"><b>frame_resolve</b></td>
  </tr>
  <tr><td valign=\"top\">not connected</td>
      <td valign=\"top\">true</td>
      <td valign=\"top\"><b>frame_a</b></td>
  </tr>
  <tr><td valign=\"top\">not connected</td>
      <td valign=\"top\">false</td>
      <td valign=\"top\"><b>frame_b</b></td>
  </tr>
</table><br>
</HTML>"));
  equation 
    if get_angles or get_w_rel or get_z_rel then
      R_rel = Modelica.Mechanics.MultiBody.Frames.relativeRotation(frame_a.R, frame_b.R);
    else
      R_rel = Modelica.Mechanics.MultiBody.Frames.nullRotation();
    end if;
    
    if get_angles then
      angles = Frames.axesRotationsAngles(R_rel, sequence, guessAngle1);
    else
      angles = zeros(3);
    end if;
    
    if cardinality(frame_resolve) == 1 then
      // frame_resolve is connected
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);
      
      if resolveInFrame_a then
        R_resolve = Frames.relativeRotation(frame_a.R, frame_resolve.R);
      else
        R_resolve = Frames.relativeRotation(frame_b.R, frame_resolve.R);
      end if;
      
      if get_r_rel or get_v_rel or get_a_rel then
        if resolveInFrame_a then
          r_rel_ab = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
        else
          r_rel_ab = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);
        end if;
        r_rel = Frames.resolve2(R_resolve, r_rel_ab);
      else
        r_rel_ab = zeros(3);
        r_rel = zeros(3);
      end if;
      
      if get_v_rel or get_a_rel then
        der_r_rel_ab = der(r_rel_ab);
      else
        der_r_rel_ab = zeros(3);
      end if;
      
      if get_v_rel then
        v_rel = Frames.resolve2(R_resolve, der_r_rel_ab);
      else
        v_rel = zeros(3);
      end if;
      
      if get_a_rel then
        a_rel = Frames.resolve2(R_resolve, der(der_r_rel_ab));
      else
        a_rel = zeros(3);
      end if;
      
      if get_w_rel or get_z_rel then
        if resolveInFrame_a then
          w_rel_ab = Modelica.Mechanics.MultiBody.Frames.angularVelocity1(R_rel);
        else
          w_rel_ab = Modelica.Mechanics.MultiBody.Frames.angularVelocity2(R_rel);
        end if;
        w_rel = Frames.resolve2(R_resolve, w_rel_ab);
      else
        w_rel = zeros(3);
        w_rel_ab = zeros(3);
      end if;
      
      if get_z_rel then
        z_rel = Frames.resolve2(R_resolve, der(w_rel_ab));
      else
        z_rel = zeros(3);
      end if;
      
    else
      // frame_resolve is NOT connected
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();
      R_resolve = Frames.nullRotation();
      r_rel_ab = zeros(3);
      der_r_rel_ab = zeros(3);
      w_rel_ab = zeros(3);
      
      if get_r_rel or get_v_rel or get_a_rel then
        if resolveInFrame_a then
          r_rel = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
        else
          r_rel = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);
        end if;
      else
        r_rel = zeros(3);
      end if;
      
      if get_v_rel or get_a_rel then
        v_rel = der(r_rel);
      else
        v_rel = zeros(3);
      end if;
      
      if get_a_rel then
        a_rel = der(v_rel);
      else
        a_rel = zeros(3);
      end if;
      
      if get_w_rel or get_z_rel then
        if resolveInFrame_a then
          w_rel = Frames.angularVelocity1(R_rel);
        else
          w_rel = Frames.angularVelocity2(R_rel);
        end if;
      else
        w_rel = zeros(3);
      end if;
      
      if get_z_rel then
        z_rel = der(w_rel);
      else
        z_rel = zeros(3);
      end if;
    end if;
    
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    frame_b.f = zeros(3);
    frame_b.t = zeros(3);
    
    if get_r_rel then
      y[i1:i1 + 2] = r_rel;
    end if;
    
    if get_v_rel then
      y[i2:i2 + 2] = v_rel;
    end if;
    
    if get_a_rel then
      y[i3:i3 + 2] = a_rel;
    end if;
    
    if get_angles then
      y[i4:i4 + 2] = angles;
    end if;
    
    if get_w_rel then
      y[i5:i5 + 2] = w_rel;
    end if;
    
    if get_z_rel then
      y[i6:i6 + 2] = z_rel;
    end if;
  end RelativeSensor;
  
  model RelativeSensorNew 
    "Measure relative position vector between two frame connectors" 
    
    import SI = Modelica.SIunits;
    extends Modelica.Icons.RotationalSensor;
    Interfaces.Frame_a frame_a 
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{
              -116,-16},{-84,16}}, rotation=0)));
    Interfaces.Frame_b frame_b 
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{84,
              -16},{116,16}}, rotation=0)));
    Blocks.Interfaces.RealOutput r_rel[3] 
      "Relative position vector frame_b.r_0 - frame_a.r_0 resolved in frame_a or frame_b"
      annotation (Placement(transformation(
          origin={-80,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    
    parameter Boolean animation=true 
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean resolveInFrame_a=true 
      "= true, if relative vectors from frame_a to frame_b are resolved before differentiation in frame_a, otherwise in frame_b";
    input SI.Diameter arrowDiameter=world.defaultArrowDiameter 
      " Diameter of relative arrow from frame_a to frame_b" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
      " Color of relative arrow from frame_a to frame_b" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
    
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
      r=frame_a.r_0,
      r_head=frame_b.r_0 - frame_a.r_0,
      diameter=arrowDiameter,
      color=arrowColor,
      specularCoefficient) if world.enableAnimation and animation;
    
    encapsulated model RelativePosition "Determine relative position" 
      import Modelica;
      import Modelica.Mechanics.MultiBody.Frames;
      extends Modelica.Blocks.Interfaces.BlockIcon;
      
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
        "Coordinate system a"                                                       annotation (Placement(
            transformation(extent={{-116,-16},{-84,16}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b 
        "Coordinate system b"                                                       annotation (Placement(
            transformation(extent={{84,-16},{116,16}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput r_rel[3] 
        "Relative position vector, frame_b.r_0 - frame_a.r_0, resolved in frame_a or frame_b depending on parameter resolveInFrame_a)"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      parameter Boolean resolveInFrame_a=true 
        "= true, if relative vectors from frame_a to frame_b are resolved before differentiation in frame_a, otherwise in frame_b";
      
    equation 
       frame_a.f = zeros(3);
       frame_a.t = zeros(3);
       frame_b.f = zeros(3);
       frame_b.t = zeros(3);
       if resolveInFrame_a then
          r_rel = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
       else
          r_rel = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);
       end if;
      
      annotation (Icon(graphics={Text(
              extent={{-78,-60},{78,-82}}, 
              lineColor={0,0,0}, 
              textString="r_rel")}));
    end RelativePosition;
    
  protected 
    RelativePosition relativePosition annotation (Placement(transformation(
            extent={{-70,-10},{-50,10}}, rotation=0)));
    annotation (Diagram(graphics),
                         Icon(graphics={
          Line(
            points={{-70,0},{-96,0}}, 
            color={0,0,0}, 
            smooth=Smooth.None), 
          Line(
            points={{96,0},{70,0}}, 
            color={0,0,0}, 
            smooth=Smooth.None), 
          Line(
            points={{-80,0},{-80,-100}}, 
            color={0,0,127}, 
            smooth=Smooth.None), 
          Text(
            extent={{-116,-62},{-44,-76}}, 
            lineColor={0,0,0}, 
            textString="r_rel"), 
          Text(
            extent={{-112,51},{-76,26}}, 
            lineColor={128,128,128}, 
            textString="a"), 
          Text(
            extent={{78,51},{114,26}}, 
            lineColor={128,128,128}, 
            textString="b")}));
  equation 
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of component is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of component is not connected");
    
    connect(relativePosition.frame_a, frame_a) annotation (Line(
        points={{-70,0},{-100,0}},
        color={95,95,95},
        thickness=2,
        smooth=Smooth.None));
    connect(relativePosition.frame_b, frame_b) annotation (Line(
        points={{-50,0},{100,0}},
        color={95,95,95},
        thickness=2,
        smooth=Smooth.None));
    connect(relativePosition.r_rel, r_rel) annotation (Line(
        points={{-60,-11},{-60,-60.5},{-60,-110},{-80,-110}},
        color={0,0,127},
        smooth=Smooth.None));
  end RelativeSensorNew;
  
  model Distance 
    "Measure the distance between the origins of two frame connectors" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Frames;
    import Modelica.Mechanics.MultiBody.Types;
    
    extends Interfaces.PartialTwoFrames;
    extends Modelica.Icons.TranslationalSensor;
    Modelica.Blocks.Interfaces.RealOutput distance 
      "Distance between the origin of frame_a and the origin of frame_b" 
      annotation (Placement(transformation(
          origin={0,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    
    parameter Boolean animation=true 
      "= true, if animation shall be enabled (show arrow)";
    input SI.Diameter arrowDiameter=world.defaultArrowDiameter 
      "Diameter of relative arrow from frame_a to frame_b" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
      "Color of relative arrow from frame_a to frame_b" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Position s_small(min=sqrt(Modelica.Constants.small))=1.E-10 
      "Prevent zero-division if distance between frame_a and frame_b is zero" 
      annotation (Dialog(tab="Advanced"));
  protected 
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
      r=frame_a.r_0,
      r_head=frame_b.r_0 - frame_a.r_0,
      diameter=arrowDiameter,
      color=arrowColor,
      specularCoefficient=specularCoefficient) if world.enableAnimation and animation;
    annotation (
      preferedView="info",
      Icon(graphics={
          Line(points={{0,-60},{0,-100}}), 
          Line(points={{-70,0},{-101,0}}, color={0,0,0}), 
          Line(points={{70,0},{100,0}}, color={0,0,0}), 
          Text(extent={{-128,30},{133,78}}, textString="%name")}),
      Diagram(graphics={
          Line(points={{-70,0},{-101,0}}, color={0,0,0}), 
          Line(points={{70,0},{100,0}}, color={0,0,0}), 
          Line(points={{0,-60},{0,-100}}), 
          Text(extent={{-22,70},{20,46}}, textString="s"), 
          Line(points={{-98,40},{88,40}}), 
          Polygon(
            points={{102,40},{87,46},{87,34},{102,40}}, 
            lineColor={0,0,255}, 
            fillColor={0,0,255}, 
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<HTML>
<p>
The <b>distance</b> between the origins of frame_a
and of frame_b are determined and provided at the 
output signal connector <b>distance</b>. This 
distance is always positive. <b>Derivatives</b> of this
signal can be easily obtained by connecting the
block 
<a href=\"Modelica://Modelica.Blocks.Continuous.Der\">Modelica.Blocks.Continuous.Der</a>
to \"distance\" (this block performs analytic differentiation
of the input signal using the der(..) operator).
</p>
<p>
In the following figure the animation of a Distance
sensor is shown. The light blue coordinate system is
frame_a, the dark blue coordinate system is frame_b, and
the yellow arrow is the animated sensor.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Sensors/Distance.png\">
</p>
<p>
If the distance is smaller as parameter <b>s_small</b> (in the \"advanced\" menu),
it is approximated such that its derivative is
finite for zero distance. Without such an approximation, the derivative would
be infinite and a division by zero would occur. The approximation is performed
in the following way: If distance > s_small, it is computed as sqrt(r*r) where
r is the position vector from the origin of frame_a to the origin of frame_b.
If the distance becomes smaller as s_small, the \"sqrt()\" function is approximated
by a second order polynomial, such that the function value and its first derivative
are identical for sqrt() and the polynomial at s_small. Futhermore, the polynomial
passes through zero. The effect is, that the distance function is continuous and
differentiable everywhere. The derivative at zero distance is 3/(2*s_small).
</p>
</HTML>"));
  protected 
    SI.Position r_rel_0[3] = frame_b.r_0 - frame_a.r_0 
      "Position vector from frame_a to frame_b resolved in world frame";
    SI.Area L2 = r_rel_0*r_rel_0;
    SI.Area s_small2 = s_small^2;
  equation 
    frame_a.f = zeros(3);
    frame_b.f = zeros(3);
    frame_a.t = zeros(3);
    frame_b.t = zeros(3);
    
    distance =  smooth(1,if L2 > s_small2 then sqrt(L2) else L2/(2*s_small)*(3-L2/s_small2));
  end Distance;
  
  model CutForce "Measure cut force vector" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialCutForceSensor;
    Modelica.Blocks.Interfaces.RealOutput force[3] 
      "Cut force resolved in frame_a/frame_b or in frame_resolved, if connected"
         annotation (Placement(transformation(
          origin={-80,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    
    parameter Boolean animation=true 
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean positiveSign=true 
      "= true, if force with positive sign is returned (= frame_a.f), otherwise with negative sign (= frame_b.f)";
    parameter Boolean resolveInFrame_a=true 
      "= true, if force is resolved in frame_a/frame_b, otherwise in the world frame (if connector frame_resolve is connected, the force is resolved in frame_resolve)";
    input Real N_to_m(unit="N/m") = 1000 
      " Force arrow scaling (length = force/N_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter forceDiameter=world.defaultArrowDiameter 
      " Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.
        ForceColor " Color of force arrow" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    
    annotation (
      preferedView="info",
      Icon(graphics={Text(
            extent={{-190,-70},{-74,-96}}, 
            lineColor={192,192,192}, 
            textString="force")}),
      Diagram(graphics),
      Documentation(info="<HTML>
<p>
The cut-force acting at the component to which frame_b is
connected is determined and provided at the output signal connector 
<b>force</b> (= frame_a.f). If parameter <b>positiveSign</b> =
<b>false</b>, the negative cut-force is provided (= frame_b.f).
If <b>frame_resolve</b> is connected to another frame, then the
cut-force is resolved in frame_resolve.
If <b>frame_resolve</b> is <b>not</b> connected then the
coordinate system in which the cut-force is resolved
is defined by parameter <b>resolveInFrame_a</b>.
If this parameter is <b>true</b>, then the
cut-force is resolved in frame_a, otherwise it is
resolved in the world frame.
</p>
<p>
In the following figure the animation of a CutForce
sensor is shown. The dark blue coordinate system is frame_b, 
and the green arrow is the cut force acting at frame_b and
with negative sign at frame_a.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Sensors/CutForce.png\">
</p>
</HTML>"));
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
    SI.Position f_in_m[3]=frame_a.f*(if positiveSign then +1 else -1)/N_to_m 
      "Force mapped from N to m for animation";
    Visualizers.Advanced.Arrow forceArrow(
      diameter=forceDiameter,
      color=forceColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=f_in_m,
      r_head=-f_in_m) if world.enableAnimation and animation;
  equation 
    if cardinality(frame_resolve) == 1 then
      force = Frames.resolve2(frame_resolve.R, Frames.resolve1(frame_a.R,
        frame_a.f))*(if positiveSign then +1 else -1);
    elseif resolveInFrame_a then
      force = frame_a.f*(if positiveSign then +1 else -1);
    else
      force = Frames.resolve1(frame_a.R, frame_a.f)*(if positiveSign then +1 else 
              -1);
    end if;
  end CutForce;
  
  model CutTorque "Measure cut torque vector" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialCutForceSensor;
    Modelica.Blocks.Interfaces.RealOutput torque[3] 
      "Cut torque resolved in frame_a/frame_b or in frame_resolved, if connected"
         annotation (Placement(transformation(
          origin={-80,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    
    parameter Boolean animation=true 
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean positiveSign=true 
      "= true, if torque with positive sign is returned (= frame_a.t), otherwise with negative sign (= frame_b.t)";
    parameter Boolean resolveInFrame_a=true 
      "= true, if torque is resolved in frame_a/frame_b, otherwise in the world frame (if connector frame_resolve is connected, the torque is resolved in frame_resolve)";
    input Real Nm_to_m(unit="N.m/m") = 1000 
      " Torque arrow scaling (length = torque/Nm_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter torqueDiameter=world.defaultArrowDiameter 
      " Diameter of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor 
      " Color of torque arrow" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    
    annotation (
      preferedView="info",
      Icon(graphics={Text(
            extent={{-168,-72},{-52,-98}}, 
            lineColor={192,192,192}, 
            textString="torque")}),
      Diagram(graphics),
      Documentation(info="<HTML>
<p>
The cut-torque acting at the component to which frame_b is
connected is determined and provided at the output signal connector 
<b>torque</b> (= frame_a.t). If parameter <b>positiveSign</b> =
<b>false</b>, the negative cut-force is provided (= frame_b.t).
If <b>frame_resolve</b> is connected to another frame, then the
cut-torque is resolved in frame_resolve.
If <b>frame_resolve</b> is <b>not</b> connected then the
coordinate system in which the cut-torque is resolved
is defined by parameter <b>resolveInFrame_a</b>.
If this parameter is <b>true</b>, then the
cut-torque is resolved in frame_a, otherwise it is
resolved in the world frame.
</p>
<p>
In the following figure the animation of a CutTorque
sensor is shown. The dark blue coordinate system is frame_b, 
and the green arrow is the cut torque acting at frame_b and
with negative sign at frame_a.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Sensors/CutTorque.png\">
</p>
</HTML>"));
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
    SI.Position t_in_m[3]=frame_a.t*(if positiveSign then +1 else -1)/Nm_to_m 
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.DoubleArrow torqueArrow(
      diameter=torqueDiameter,
      color=torqueColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=t_in_m,
      r_head=-t_in_m) if world.enableAnimation and animation;
  equation 
    if cardinality(frame_resolve) == 1 then
      torque = Frames.resolve2(frame_resolve.R, Frames.resolve1(frame_a.R,
        frame_a.t))*(if positiveSign then +1 else -1);
    elseif resolveInFrame_a then
      torque = frame_a.t*(if positiveSign then +1 else -1);
    else
      torque = Frames.resolve1(frame_a.R, frame_a.t)*(if positiveSign then +1 else 
              -1);
    end if;
  end CutTorque;
  
  model CutForceAndTorque "Measure cut force and cut torque vector" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialCutForceSensor;
    Modelica.Blocks.Interfaces.RealOutput load[6] 
      "Cut force and cut torque resolved in frame_a/frame_b or in frame_resolved, if connected"
         annotation (Placement(transformation(
          origin={-80,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    
    parameter Boolean animation=true 
      "= true, if animation shall be enabled (show force and torque arrow)";
    parameter Boolean positiveSign=true 
      "= true, if force and torque with positive sign is returned (= frame_a.f/.t), otherwise with negative sign (= frame_b.f/.t)";
    parameter Boolean resolveInFrame_a=true 
      "= true, if force and torque are resolved in frame_a/frame_b, otherwise in the world frame (if connector frame_resolve is connected, the force/torque is resolved in frame_resolve)";
    input Real N_to_m(unit="N/m") = 1000 
      " Force arrow scaling (length = force/N_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Real Nm_to_m(unit="N.m/m") = 1000 
      " Torque arrow scaling (length = torque/Nm_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter forceDiameter=world.defaultArrowDiameter 
      " Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter torqueDiameter=forceDiameter " Diameter of torque arrow" 
                                  annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor 
      " Color of force arrow" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor 
      " Color of torque arrow" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    
    SI.Force force[3] 
      "Cut force resolved in frame_a/frame_b or in frame_resolved, if connected";
    SI.Torque torque[3] 
      "Cut torque resolved in frame_a/frame_b or in frame_resolved, if connected";
    annotation (
      preferedView="info",
      Icon(graphics),
      Diagram(graphics),
      Documentation(info="<HTML>
<p>
The cut-force and cut-torque acting at the component to which frame_b is
connected are determined and provided at the output signal connector 
<b>load</b>:
</p>
<pre>
  load[1:3] = frame_a.f;
  load[4:6] = frame_a.t;
</pre>
<p>
If parameter <b>positiveSign</b> =
<b>false</b>, the negative cut-force and negative
cut-torque is provided (= frame_b.f and frame_b.t).
If <b>frame_resolve</b> is connected to another frame, then the
cut-force and cut-torque are resolved in frame_resolve.
If <b>frame_resolve</b> is <b>not</b> connected then the
coordinate system in which the cut-force and cut-torque is resolved
is defined by parameter <b>resolveInFrame_a</b>.
If this parameter is <b>true</b>, then the
cut-force and cut-torque is resolved in frame_a, otherwise it is
resolved in the world frame.
</p>
<p>
In the following figure the animation of a CutForceAndTorque
sensor is shown. The dark blue coordinate system is frame_b, 
and the green arrows are the cut force and the cut torque,
respectively, acting at frame_b and
with negative sign at frame_a.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Sensors/CutForceAndTorque.png\">
</p>
</HTML>"));
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
    parameter Integer csign=if positiveSign then +1 else -1;
    SI.Position f_in_m[3]=frame_a.f*csign/N_to_m 
      "Force mapped from N to m for animation";
    SI.Position t_in_m[3]=frame_a.t*csign/Nm_to_m 
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.Arrow forceArrow(
      diameter=forceDiameter,
      color=forceColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=f_in_m,
      r_head=-f_in_m) if world.enableAnimation and animation;
    Visualizers.Advanced.DoubleArrow torqueArrow(
      diameter=torqueDiameter,
      color=torqueColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=t_in_m,
      r_head=-t_in_m) if world.enableAnimation and animation;
  equation 
    if cardinality(frame_resolve) == 1 then
      force = Frames.resolve2(frame_resolve.R, Frames.resolve1(frame_a.R,
        frame_a.f))*csign;
      torque = Frames.resolve2(frame_resolve.R, Frames.resolve1(frame_a.R,
        frame_a.t))*csign;
    elseif resolveInFrame_a then
      force = frame_a.f*csign;
      torque = frame_a.t*csign;
    else
      force = Frames.resolve1(frame_a.R, frame_a.f)*csign;
      torque = Frames.resolve1(frame_a.R, frame_a.t)*csign;
    end if;
    
    load[1:3] = force;
    load[4:6] = torque;
  end CutForceAndTorque;
  
  model Power "Measure power flowing from frame_a to frame_b" 
    import SI = Modelica.SIunits;
    extends Modelica.Icons.RotationalSensor;
    
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
    Modelica.Blocks.Interfaces.RealOutput power 
      "Power at frame_a as output signal" 
      annotation (Placement(transformation(
          origin={-80,-110},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    
    annotation (
      Diagram(graphics={
          Line(points={{-70,0},{-101,0}}, color={0,0,0}), 
          Line(points={{70,0},{100,0}}, color={0,0,0}), 
          Line(points={{-80,0},{-80,-100}}, color={0,0,127})}),
      Icon(graphics={
          Line(points={{-70,0},{-101,0}}, color={0,0,0}), 
          Line(points={{70,0},{100,0}}, color={0,0,0}), 
          Line(points={{-80,0},{-80,-100}}, color={0,0,127}), 
          Text(
            extent={{-60,-92},{16,-114}}, 
            lineColor={0,0,0}, 
            textString="power"), 
          Text(extent={{-128,126},{126,68}}, textString="%name")}),
      Documentation(info="<HTML>
<p>
This component provides the power flowing from frame_a to frame_b
as output signal <b>power</b>.
</p>
</HTML>"));
  equation 
    defineBranch(frame_a.R, frame_b.R);
    frame_a.r_0 = frame_b.r_0;
    frame_a.R = frame_b.R;
    zeros(3) = frame_a.f + frame_b.f;
    zeros(3) = frame_a.t + frame_b.t;
    power = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0))
       + frame_a.t*Frames.angularVelocity2(frame_a.R);
  end Power;
  annotation (preferedView="info", Documentation(info="<HTML>
<p>
Package <b>Sensors</b> contains <b>ideal measurement</b>
components to determine absolute and relative kinematic
quantities, as well as cut-forces and cut-torques. All
measured quantities can be provided in every desired
coordinate system.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Sensors.AbsoluteSensor\">AbsoluteSensor</a></td>
      <td valign=\"top\"> Measure absolute kinematic quantities of a frame connector<br>
       <img src=\"../Images/MultiBody/Sensors/AbsoluteSensor.png\"></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Sensors.RelativeSensor\">RelativeSensor</a></td>
      <td valign=\"top\"> Measure relative kinematic quantities between two frame connectors<br>
       <img src=\"../Images/MultiBody/Sensors/RelativeSensor.png\"></td> </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Sensors.Distance\">Distance</a></td>
      <td valign=\"top\"> Measure distance between the origins of two frame connectors <br>
       <img src=\"../Images/MultiBody/Sensors/Distance.png\"></td></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Sensors.CutForce\">CutForce</a></td>
      <td valign=\"top\"> Measure cut force vector <br>
       <img src=\"../Images/MultiBody/Sensors/CutForce.png\"></td></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Sensors.CutTorque\">CutTorque</a></td>
      <td valign=\"top\"> Measure cut torque vector <br>
       <img src=\"../Images/MultiBody/Sensors/CutTorque.png\"></td></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Sensors.CutForceAndTorque\">CutForceAndTorque</a></td>
      <td valign=\"top\"> Measure cut force and cut torque vector <br>
       <img src=\"../Images/MultiBody/Sensors/CutForceAndTorque.png\"></td></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Sensors.Power\">Power</a></td>
      <td valign=\"top\"> Measure power flowing from frame_a to frame_b</td>
  </tr>
</table>
</HTML>"));
end Sensors;
