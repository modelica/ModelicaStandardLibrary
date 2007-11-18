within ;
package ObsoleteModelica3 
  "Library that contains components from Modelica Standard Library 2.2.2 that have been removed from version 3.0" 
  package Blocks 
    package Interfaces 
      package Adaptors 
      model AdaptorReal 
          "Completely obsolete adaptor between 'old' and 'new' Real signal connectors (only for backward compatibility)" 
        extends ObsoleteModelica3.Icons.ObsoleteBlock;
        Modelica.Blocks.Interfaces.RealSignal newReal 
            "Connector of Modelica version 2.1"                annotation (                            Hide=true,
              Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        RealPort oldReal(final n=1) "Connector of Modelica version 1.6" annotation (Placement(
                transformation(extent={{-120,-10},{-100,10}}, rotation=0)));
          
        annotation(structurallyIncomplete,
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Rectangle(
                  extent={{-100,40},{100,-40}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-144,96},{144,46}},
                  lineColor={0,0,0},
                  textString=""),
                Text(
                  extent={{-88,22},{88,-24}},
                  lineColor={0,0,255},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="adaptor"),
                Text(
                  extent={{-216,-58},{36,-80}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="port.signal")}),
                                      Documentation(info="<html>
<p>
Completely obsolete adaptor between the Real signal connector
of version 1.6 and version &ge; 2.1 of the Modelica Standard Library.
This block is only provided for backward compatibility.
</p>
</html>
"));
          
        protected 
        connector RealPort "Connector with signals of type Real" 
          parameter Integer n=1 "Dimension of signal vector" annotation (Hide=true);
          replaceable type SignalType = Real "type of signal";
          SignalType signal[n] "Real signals" annotation (Hide=true);
            
        end RealPort;
      equation 
        newReal = oldReal.signal[1];
      end AdaptorReal;
        
      model AdaptorBoolean 
          "Completely obsolete adaptor between 'old' and 'new' Boolean signal connectors (only for backward compatibility)" 
        extends ObsoleteModelica3.Icons.ObsoleteBlock;
        Modelica.Blocks.Interfaces.BooleanSignal newBoolean 
            "Connector of Modelica version 2.1" 
          annotation (                            Hide=true, Placement(
                transformation(extent={{100,-10},{120,10}}, rotation=0)));
        BooleanPort oldBoolean(final n=1) "Connector of Modelica version 1.6" annotation (Placement(
                transformation(extent={{-120,-10},{-100,10}}, rotation=0)));
          
        annotation(structurallyIncomplete,
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Rectangle(
                  extent={{-100,40},{100,-40}},
                  lineColor={255,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-144,96},{144,46}},
                  lineColor={0,0,0},
                  textString=""),
                Text(
                  extent={{-88,22},{88,-24}},
                  lineColor={255,0,255},
                  textString="adaptor"),
                Text(
                  extent={{-216,-58},{36,-80}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="port.signal")}),
                                      Documentation(info="<html>
<p>
Completely obsolete adaptor between the Real signal connector
of version 1.6 and version &ge; 2.1 of the Modelica Standard Library.
This block is only provided for backward compatibility.
</p>
</html>
"));
          
        protected 
        connector BooleanPort "Connector with signals of type Boolean" 
          parameter Integer n=1 "Dimension of signal vector" annotation (Hide=true);
          replaceable type SignalType = Boolean "type of signal";
          SignalType signal[n] "Boolean signals" annotation (Hide=true);
            
        end BooleanPort;
      equation 
          
        newBoolean = oldBoolean.signal[1];
          
      end AdaptorBoolean;
        
      model AdaptorInteger 
          "Completely obsolete adaptor between 'old' and 'new' Integer signal connectors (only for backward compatibility)" 
        extends ObsoleteModelica3.Icons.ObsoleteBlock;
        Modelica.Blocks.Interfaces.IntegerSignal newInteger 
            "Connector of Modelica version 2.1" 
          annotation (                            Hide=true, Placement(
                transformation(extent={{100,-10},{120,10}}, rotation=0)));
        IntegerPort oldInteger(final n=1) "Connector of Modelica version 1.6"  annotation (Placement(
                transformation(extent={{-120,-10},{-100,10}}, rotation=0)));
          
        annotation(structurallyIncomplete,
           Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Rectangle(
                  extent={{-100,40},{100,-40}},
                  lineColor={255,127,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-144,96},{144,46}},
                  lineColor={0,0,0},
                  textString=""),
                Text(
                  extent={{-88,22},{88,-24}},
                  lineColor={255,127,0},
                  textString="adaptor"),
                Text(
                  extent={{-216,-58},{36,-80}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="port.signal")}),
                                      Documentation(info="<html>
<p>
Completely obsolete adaptor between the Real signal connector
of version 1.6 and version &ge; 2.1 of the Modelica Standard Library.
This block is only provided for backward compatibility.
</p>
</html>
"));
          
        protected 
        connector IntegerPort "Connector with signals of type Integer" 
          parameter Integer n=1 "Dimension of signal vector" annotation (Hide=true);
          replaceable type SignalType = Integer "type of signal";
          SignalType signal[n] "Integer signals" annotation (Hide=true);
            
        end IntegerPort;
      equation 
          
        newInteger = oldInteger.signal[1];
          
      end AdaptorInteger;
      end Adaptors;
    end Interfaces;
    
    package Math 
      package UnitConversions 
        block ConvertAllUnits "Convert signal to a signal with different unit" 
          replaceable block ConversionBlock = 
              Modelica.Blocks.Interfaces.PartialConversionBlock 
            "Conversion block" 
            annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Internal replaceable block that is used to construct the
\"pull down menu\" of the available unit conversions.
</p>
</html>"));
          extends ConversionBlock;
          extends ObsoleteModelica3.Icons.ObsoleteBlock;
          
          annotation (
            defaultComponentName="convert",
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Line(points={{-90,0},{30,0}}, color=
                      {191,0,0}), Polygon(
                  points={{90,0},{30,20},{30,-20},{90,0}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}),
            Documentation(info="<html>
<p>This block implements the Modelica.SIunits.Conversions functions as a fixed causality block to
simplify their use. The block contains a replaceable block class <b>ConversionBlock</b> that can be
changed to be any of the blocks defined in Modelica.Blocks.Math.UnitConversions, and more generally, any
blocks that extend from Modelica.Blocks.Interfaces.PartialConversionBlock.
</p>

<p
The desired conversion can be selected in the parameter menu 
(the selected units are then displayed in the icon):</p>
</p>

<p>
<img src=\"../Modelica/Images/Blocks/ConvertAllUnits.png\">
</p>

</html>"));
        end ConvertAllUnits;
      end UnitConversions;
      
      block TwoInputs 
        "Change causality of input signals by defining that two input signals are identical (e.g. for inverse models)" 
        extends Modelica.Blocks.Interfaces.BlockIcon;
        extends ObsoleteModelica3.Icons.ObsoleteBlock;
            annotation(structurallyIncomplete,
              Window(
                x=0.15,
                y=0.21,
                width=0.6,
                height=0.6),
              Documentation(info="<HTML>
<p>
This block is used to enable asignment of values to variables preliminary
defined as outputs (e.g. useful for inverse model generation).
</p>

</HTML>
"),           Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={Text(
                extent={{-95,50},{95,-50}},
                lineColor={0,0,127},
                textString="=")}));
            Modelica.Blocks.Interfaces.RealInput u1 
          "Connector of first Real input signal" 
              annotation (                                       layer="icon",
            Placement(transformation(extent={{-139.742,-19.0044},{-100,20}},
                rotation=0)));
            Modelica.Blocks.Interfaces.RealInput u2 
          "Connector of second Real input signal (u1=u2)" 
                                           annotation (
              layer="icon", Placement(transformation(
              origin={120,0},
              extent={{-20,-20},{20,20}},
              rotation=180)));
      equation 
            u1 = u2;
      end TwoInputs;
      
          block TwoOutputs 
        "Change causality of output signals by defining that two output signals are identical (e.g. for inverse models)" 
            extends Modelica.Blocks.Interfaces.BlockIcon;
            extends ObsoleteModelica3.Icons.ObsoleteBlock;
            annotation(structurallyIncomplete,
              Window(
                x=0.21,
                y=0.28,
                width=0.6,
                height=0.6),
              Documentation(info="
<HTML>
<p>
This block is used to enable calculation of values preliminary defined as inputs.
(e.g. useful for inverse model generation).
</p>

</HTML>
"),           Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={Text(
                extent={{-95,50},{95,-50}},
                lineColor={0,0,127},
                textString="=")}));
            output Modelica.Blocks.Interfaces.RealOutput y1 
          "Connector of first Real output signal" 
              annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));
            output Modelica.Blocks.Interfaces.RealOutput y2 
          "Connector of second Real output signal (y1=y2)" 
                                                   annotation (Placement(
              transformation(
              origin={-110.366,-0.90289},
              extent={{-10.0005,-10},{10.0005,10}},
              rotation=180)));
          equation 
            y1 = y2;
          end TwoOutputs;
    end Math;
    
  end Blocks;
  annotation (uses(Modelica(version="3.0-development")));
  package Icons 
    partial block ObsoleteBlock "Icon for an obsolete block" 
      
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-102,102},{102,-102}}, 
              lineColor={255,0,0}, 
              pattern=LinePattern.Dash, 
              lineThickness=2)}),        Documentation(info="<html>
<p>
This partial class is intended to design a <em>default icon
for an obsolete class</em> that will be removed from the
PowerTrain library later on.
<p>
</html>",
        revisions="<html>
<img src=\"../Extras/Images/dlr_logo.png\"  width=60 >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <b>      Copyright &copy; 1999-2007, DLR Institute of Robotics and Mechatronics</b>
</html>"));
    equation 
      
    end ObsoleteBlock;
    
    partial class Enumeration "Icon for an enumeration (emulated by a package)" 
      
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(extent={{-138,164},{138,104}}, textString="%name"), 
            Ellipse(
              extent={{-100,100},{100,-100}}, 
              lineColor={255,0,127}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Text(
              extent={{-100,100},{100,-100}}, 
              lineColor={255,0,127}, 
              fillColor={223,159,191}, 
              fillPattern=FillPattern.Solid, 
              textString="e")}),
                          Documentation(info="<html>
<p>
This icon is designed for an <b>enumeration</b>
(that is emulated by a package).
</p>
</html>"));
    end Enumeration;
  end Icons;
  
  package Mechanics 
    package MultiBody 
      package Types 
        type AngularVelocity_degs = Modelica.Icons.TypeReal(final quantity="AngularVelocity", final unit
              =    "deg/s") "Angular velocity type in deg/s";
        type AngularAcceleration_degs2 = Modelica.Icons.TypeReal (final 
              quantity =                                                         "AngularAcceleration",
              final unit="deg/s2") "Angular acceleration type in deg/s^2";
        package Init 
          "Type, constants and menu choices to define initialization, as temporary solution until enumerations are available" 
          
          annotation (Documentation(info="<html>
  
</html>"),         uses(Modelica(version="2.2.2")));
          extends ObsoleteModelica3.Icons.Enumeration;
          
          constant Integer Free=1;
          constant Integer PositionVelocity=2;
          constant Integer SteadyState=3;
          constant Integer Position=4;
          constant Integer Velocity=5;
          constant Integer VelocityAcceleration=6;
          constant Integer PositionVelocityAcceleration=7;
          
          type Temp 
            "Temporary type of Init with choices for menus (until enumerations are available)" 
            
            extends Modelica.Icons.TypeInteger;
            annotation (choices(
                choice=Modelica.Mechanics.MultiBody.Types.Init.Free 
                  "free (no initialization)",
                choice=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity 
                  "initialize generalized position and velocity variables",
                choice=Modelica.Mechanics.MultiBody.Types.Init.SteadyState 
                  "initialize in steady state (velocity and acceleration are zero)",
                choice=Modelica.Mechanics.MultiBody.Types.Init.Position 
                  "initialize only generalized position variable(s)",
                choice=Modelica.Mechanics.MultiBody.Types.Init.Velocity 
                  "initialize only generalized velocity variable(s)",
                choice=Modelica.Mechanics.MultiBody.Types.Init.VelocityAcceleration 
                  "initialize generalized velocity and acceleration variables",
                choice=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocityAcceleration 
                  "initialize generalized position, velocity and acceleration variables"),
                Documentation(info="<html>
  
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.Init.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">Free</td>
    <td valign=\"top\">No initialization</td></tr>
 
<tr><td valign=\"top\">PositionVelocity</td>
    <td valign=\"top\">Initialize generalized position and velocity variables</td></tr>
 
<tr><td valign=\"top\">SteadyState</td>
    <td valign=\"top\">Initialize in steady state (velocity and acceleration are zero)</td></tr>
 
<tr><td valign=\"top\">Position </td>
    <td valign=\"top\">Initialize only generalized position variable(s)</td></tr>
 
<tr><td valign=\"top\">Velocity</td>
    <td valign=\"top\">Initialize only generalized velocity variable(s)</td></tr>
 
<tr><td valign=\"top\">VelocityAcceleration</td>
    <td valign=\"top\">Initialize generalized velocity and acceleration variables</td></tr>
 
<tr><td valign=\"top\">PositionVelocityAcceleration</td>
    <td valign=\"top\">Initialize generalized position, velocity and acceleration variables</td></tr>
 
</table>
 
</html>"));
            
          end Temp;
        end Init;
      end Types;

      package Sensors 
        model AbsoluteSensor 
          "Measure absolute kinematic quantities of a frame connector" 
          import SI = Modelica.SIunits;
          import Modelica.Mechanics.MultiBody.Frames;
          import Modelica.Mechanics.MultiBody.Types;
          extends Modelica.Mechanics.MultiBody.Interfaces.PartialAbsoluteSensor(final 
              n_out=3*((if get_r_abs then 1 else 0) + (if get_v_abs then 1 else 0) + (
                if get_a_abs then 1 else 0) + (if get_angles then 1 else 0) + (if 
                get_w_abs then 1 else 0) + (if get_z_abs then 1 else 0)));
          extends ObsoleteModelica3.Icons.ObsoleteBlock;
          
          Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve 
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
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
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
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Line(
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
<IMG SRC=\"../Modelica/Images/MultiBody/Sensors/AbsoluteSensor.png\">
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

        model RelativeSensor 
          "Measure relative kinematic quantities between two frame connectors" 
          
          import SI = Modelica.SIunits;
          import Modelica.Mechanics.MultiBody.Frames;
          import Modelica.Mechanics.MultiBody.Types;
          extends Modelica.Mechanics.MultiBody.Interfaces.PartialRelativeSensor(final 
              n_out=3*((if get_r_rel then 1 else 0) + (if get_v_rel then 1 else 0) + (
                if get_a_rel then 1 else 0) + (if get_angles then 1 else 0) + (if 
                get_w_rel then 1 else 0) + (if get_z_rel then 1 else 0)));
          extends ObsoleteModelica3.Icons.ObsoleteBlock;
          
          Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve 
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
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Line(
                  points={{-60,-94},{-60,-76},{0,-76},{0,-76}}, 
                  color={95,95,95}, 
                  pattern=LinePattern.Dot), Text(
                  extent={{-157,-49},{-26,-74}}, 
                  lineColor={192,192,192}, 
                  pattern=LinePattern.Dot, 
                  textString="resolve")}),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Line(
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
<IMG SRC=\"../Modelica/Images/MultiBody/Sensors/RelativeSensor.png\">
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
      end Sensors;
    end MultiBody;
    
    package Rotational 
      package Sensors 
        partial model AbsoluteSensor 
          "Base model to measure a single absolute flange variable" 
          
          extends Modelica.Icons.RotationalSensor;
          extends ObsoleteModelica3.Icons.ObsoleteBlock;
          
          Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
            "(left) flange to be measured (flange axis directed INTO cut plane)"
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput y "Sensor signal" 
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                  rotation=0)));
          annotation (
            Window(
              x=0.39,
              y=0.05,
              width=0.6,
              height=0.6),
            Documentation(info="<html>
<p>
This is the base class of a 1D rotational component with one flange and one
output signal y in order to measure an absolute kinematic quantity in the flange
and to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>
 
</HTML>
"),         Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={
                Line(points={{-70,0},{-90,0}}, color={0,0,0}),
                Line(points={{70,0},{100,0}}, color={0,0,127}),
                Text(
                  extent={{150,80},{-150,120}},
                  textString="%name",
                  lineColor={0,0,255})}),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={Line(points={{-70,0},{-90,0}}, color={0,
                      0,0}), Line(points={{70,0},{100,0}}, color={0,0,255})}));
        end AbsoluteSensor;
        
        partial model RelativeSensor 
          "Base model to measure a single relative variable between two flanges" 
          
          extends Modelica.Icons.RotationalSensor;
          extends ObsoleteModelica3.Icons.ObsoleteBlock;
          
          Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
            "(left) driving flange (flange axis directed INTO cut plane)" 
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                  rotation=0)));
          Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b 
            "(right) driven flange (flange axis directed OUT OF cut plane)" 
            annotation (Placement(transformation(extent={{90,-10},{110,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput y "Sensor signal" 
            annotation (Placement(transformation(
                origin={0,-110},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          annotation (
            Window(
              x=0.37,
              y=0.02,
              width=0.6,
              height=0.65),
            Documentation(info="<html>
<p>
This is a base class for 1D rotational components with two rigidly connected
flanges and one output signal y in order to measure relative kinematic quantities
between the two flanges or the cut-torque in the flange and
to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>
 
</HTML>
"),         Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={
                Line(points={{-70,0},{-90,0}}, color={0,0,0}),
                Line(points={{70,0},{90,0}}, color={0,0,0}),
                Line(points={{0,-100},{0,-70}}, color={0,0,127}),
                Text(
                  extent={{-150,70},{150,110}},
                  textString="%name",
                  lineColor={0,0,255})}),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={
                Line(points={{-70,0},{-90,0}}, color={0,0,0}),
                Line(points={{70,0},{90,0}}, color={0,0,0}),
                Line(points={{0,-100},{0,-70}}, color={0,0,255})}));
        end RelativeSensor;
      end Sensors;
      
      package Interfaces 
        partial model Bearing 
          "Base class for interface classes with bearing connector" 
          extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
          extends ObsoleteModelica3.Icons.ObsoleteBlock;
          
          Modelica.SIunits.Torque tau_support;
          
          Modelica.Mechanics.Rotational.Interfaces.Flange_a bearing 
            "Flange of bearing" 
                           annotation (Placement(transformation(extent={{-10,-110},
                    {10,-90}}, rotation=0)));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,-80},{20,-120}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid)}),
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                  extent={{-20,-80},{20,-120}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid)}),
            Documentation(info="<html>
<p>
This is a 1D rotational component with two flanges and an additional bearing flange.
It is a superclass for the two components TwoFlangesAndBearing and TwoFlangesAndBearingH.</p>
 
</HTML>
"));
          
        end Bearing;
        
        partial model TwoFlangesAndBearing 
          "Base class for a equation-based component with two rotational 1D flanges and one rotational 1D bearing flange" 
          
          extends ObsoleteModelica3.Mechanics.Rotational.Interfaces.Bearing;
          
          Modelica.SIunits.Angle phi_a;
          Modelica.SIunits.Angle phi_b;
          
          annotation (Documentation(info="<html>
<p>
This is a 1D rotational component with two flanges and an additional bearing flange.
It is used e.g. to build up equation-based parts of a drive train.</p>
 
</HTML>
"));
        equation 
          if cardinality(bearing) == 0 then
            bearing.phi = 0;
          else
            bearing.tau = tau_support;
          end if;
          
          0 = flange_a.tau + flange_b.tau + tau_support;
          
          phi_a = flange_a.phi - bearing.phi;
          phi_b = flange_b.phi - bearing.phi;
        end TwoFlangesAndBearing;
        
        partial model TwoFlangesAndBearingH 
          "Base class for a hierarchically composed component with two rotational 1D flanges and one rotational bearing flange" 
          
          extends ObsoleteModelica3.Mechanics.Rotational.Interfaces.Bearing;
          
          Adapter adapter(bearingConnected=cardinality(bearing) > 1) 
            annotation (Placement(transformation(
                origin={0,-60},
                extent={{-10,-10},{10,10}},
                rotation=90)));
        protected 
          encapsulated model Adapter 
            import Modelica;
            import ObsoleteModelica3;
            import TwoFlanges = 
              Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
            extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
            extends ObsoleteModelica3.Icons.ObsoleteBlock;
            parameter Boolean bearingConnected;
            
            annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                      -100},{100,100}}), graphics={Rectangle(
                    extent={{-90,10},{90,-10}},
                    lineColor={192,192,192},
                    fillColor={192,192,192},
                    fillPattern=FillPattern.Solid), Text(
                    extent={{-150,60},{150,20}},
                    textString="%name",
                    lineColor={0,0,255})}));
          equation 
            flange_a.phi = flange_b.phi;
            
            if bearingConnected then
              0 = flange_a.tau + flange_b.tau;
            else
              0 = flange_a.phi;
            end if;
          end Adapter;
        equation 
          tau_support = -adapter.flange_b.tau;
          connect(adapter.flange_a, bearing) annotation (Line(points={{
                  -6.12323e-016,-70},{0,-70},{0,-100}}, color={0,0,0}));
          annotation (Documentation(info="<html>
<p>
This is a 1D rotational component with two flanges and an additional bearing flange.
It is used e.g. to build up parts of a drive train consisting
of several base components.</p>
 
</HTML>
"));
        end TwoFlangesAndBearingH;
      end Interfaces;
      
      package Types 
        "Constants and types with choices, especially to build menus" 
        extends Modelica.Icons.Library;
        
        annotation (preferedView="info", Documentation(info="<HTML>
<p>
In this package <b>types</b> and <b>constants</b> are defined that are used
in library Modelica.Blocks. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));
        
        package Init 
          "Type, constants and menu choices to define initialization of absolute rotational quantities" 
          extends ObsoleteModelica3.Icons.Enumeration;
          constant Integer NoInit=1 
            "no initialization (phi_start, w_start are guess values)";
          constant Integer SteadyState=2 
            "steady state initialization (der(phi)=der(w)=0)";
          constant Integer InitialState=3 
            "initialization with phi_start, w_start";
          constant Integer InitialAngle=4 "initialization with phi_start";
          constant Integer InitialSpeed=5 "initialization with w_start";
          constant Integer InitialAcceleration=6 "initialization with a_start";
          constant Integer InitialAngleAcceleration=7 
            "initialization with phi_start, a_start";
          constant Integer InitialSpeedAcceleration=8 
            "initialization with w_start, a_start";
          constant Integer InitialAngleSpeedAcceleration=9 
            "initialization with phi_start, w_start, a_start";
          
          type Temp 
            "Temporary type of absolute initialization with choices for menus (until enumerations are available)" 
            extends Modelica.Icons.TypeInteger(min=1,max=9);
            
            annotation (Evaluate=true, choices(
                choice=Modelica.Mechanics.Rotational.Types.Init.NoInit 
                  "no initialization (phi_start, w_start are guess values)",
                choice=Modelica.Mechanics.Rotational.Types.Init.SteadyState 
                  "steady state initialization (der(phi)=der(w)=0)",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialState 
                  "initialization with phi_start, w_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialAngle 
                  "initialization with phi_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialSpeed 
                  "initialization with w_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialAcceleration 
                  "initialization with a_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialAngleAcceleration 
                  "initialization with phi_start, a_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialSpeedAcceleration 
                  "initialization with w_start, a_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialAngleSpeedAcceleration 
                  "initialization with phi_start, w_start, a_start"));
          end Temp;
          
          annotation (Documentation(info="<html>
<p>
Type <b>Init</b> defines initialization of absolute rotational
quantities.
</p>
 
</html>"));
        end Init;
        
        package InitRel 
          "Type, constants and menu choices to define initialization of relative rotational quantities" 
          extends ObsoleteModelica3.Icons.Enumeration;
          constant Integer NoInit=1 
            "no initialization (phi_rel_start, w_rel_start are guess values)";
          constant Integer SteadyState=2 
            "steady state initialization (der(phi_rel)=der(w_rel)=0)";
          constant Integer InitialState=3 
            "initialization with phi_rel_start, w_rel_start";
          constant Integer InitialAngle=4 "initialization with phi_rel_start";
          constant Integer InitialSpeed=5 "initialization with w_rel_start";
          
          type Temp 
            "Temporary type of absolute initialization with choices for menus (until enumerations are available)" 
            extends Modelica.Icons.TypeInteger(min=1,max=5);
            
            annotation (Evaluate=true, choices(
                choice=Modelica.Mechanics.Rotational.Types.Init.NoInit 
                  "no initialization (phi_rel_start, w_rel_start are guess values)",
                choice=Modelica.Mechanics.Rotational.Types.Init.SteadyState 
                  "steady state initialization (der(phi)=der(w)=0)",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialState 
                  "initialization with phi_rel_start, w_rel_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialAngle 
                  "initialization with phi_rel_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialSpeed 
                  "initialization with w_rel_start"));
          end Temp;
          
          annotation (Documentation(info="<html>
<p>
Type <b>Init</b> defines initialization of relative rotational
quantities.
</p>
 
</html>"));
        end InitRel;
      end Types;
      
      model GearEfficiency "Obsolete component (use model LossyGear instead)" 
        extends 
          ObsoleteModelica3.Mechanics.Rotational.Interfaces.TwoFlangesAndBearing;
        extends ObsoleteModelica3.Icons.ObsoleteBlock;
        
        parameter Real eta(
          min=Modelica.Constants.small,
          max=1) = 1 "Efficiency";
        Modelica.SIunits.Angle phi;
        Modelica.SIunits.Power power_a "Energy flowing into flange_a (= power)";
        Boolean driving_a 
          "True, if energy is flowing INTO and not out of flange flange_a";
        
        annotation (
          Window(
            x=0.23,
            y=0.06,
            width=0.69,
            height=0.62),
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Text(
                extent={{-150,100},{150,60}},
                textString="%name",
                lineColor={0,0,255}),
              Rectangle(
                extent={{-100,20},{100,-20}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={192,192,192}),
              Line(points={{-30,-40},{30,-40}}, color={0,0,0}),
              Line(points={{0,-40},{0,-90}}, color={0,0,0}),
              Polygon(
                points={{-30,-20},{60,-20},{60,-80},{70,-80},{50,-100},{30,-80},
                    {40,-80},{40,-30},{-30,-30},{-30,-20},{-30,-20}},
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-150,60},{150,20}},
                lineColor={0,0,0},
                textString="eta=%eta"),
              Line(points={{30,-50},{20,-60}}, color={0,0,0}),
              Line(points={{30,-40},{10,-60}}, color={0,0,0}),
              Line(points={{20,-40},{0,-60}}, color={0,0,0}),
              Line(points={{10,-40},{-10,-60}}, color={0,0,0}),
              Line(points={{0,-40},{-20,-60}}, color={0,0,0}),
              Line(points={{-10,-40},{-30,-60}}, color={0,0,0}),
              Line(points={{-20,-40},{-30,-50}}, color={0,0,0})}),
          obsolete=
              "This model can get stuck due when the torque direction varies, use LossyGear instead.",
          Documentation(info="<html>
<p>
THIS COMPONENT IS <b>OBSOLETE</b> and should <b>no longer be used</b>. It is only
kept for <b>backward compatibility</b> purposes. Use model
Modelica.Mechanics.Rotational.LossyGear instead which implements
gear efficiency in a much more reliable way.
</p>
<p>
This component consists of two rigidly connected flanges flange_a and flange_b without
inertia where an <b>efficency</b> coefficient <b>eta</b> reduces the driven
torque as function of the driving torque depending on the direction
of the energy flow, i.e., energy is always lost. This can be seen as a
simple model of the Coulomb friction acting between the teeth of a
gearbox.
</p>
<p>
Note, that most gearbox manufacturers provide tables of the
efficiency of a gearbox as function of the angular velocity
(efficiency becomes zero, if the angular velocity is zero).
However, such a table is practically useless for simulation purposes,
because in gearboxes always two types of friction is present:
(1) Friction in the <b>bearings</b> and (2) friction between
the teeth of the gear. (1) leads to a velocity dependent, additive
loss-torque, whereas (2) leads to a torque-dependent reduction of the
driving torque. The gearbox manufacturers measure both effects
together and determine the gear efficiency from it, although for
simulation purposes the two effects need to be separated.
Assume for example that only constant bearing friction, i.e.,
bearingTorque=const., is present, i.e.,
</p>
<pre>
   (1)  loadTorque = motorTorque - sign(w)*bearingTorque
</pre>
<p>
Gearbox manufacturers use the loss-formula
</p>
<pre>
   (2)  loadTorque = eta*motorTorque
</pre>
<p>
Comparing (1) and (2) gives a formulat for the efficiency eta:
</p>
<pre>
   eta = (1 - sign(w)*bearingTorque/motorTorque)
</pre>
<p>
When the motorTorque becomes smaller as the bearingTorque,
(2) is useless, because the efficiency is zero. To summarize,
be careful to determine the gear <b>efficiency</b> of this element
from tables of the gear manufacturers.
</p>
 
</HTML>
"),       Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Rectangle(
                extent={{-96,20},{96,-21}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={192,192,192}),
              Line(points={{-30,-40},{30,-40}}, color={0,0,0}),
              Line(points={{0,60},{0,40}}, color={0,0,0}),
              Line(points={{-30,40},{29,40}}, color={0,0,0}),
              Line(points={{0,-40},{0,-90}}, color={0,0,0}),
              Polygon(
                points={{-30,-20},{60,-20},{60,-80},{70,-80},{50,-100},{30,-80},
                    {40,-80},{40,-30},{-30,-30},{-30,-20},{-30,-20}},
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{16,83},{84,70}},
                lineColor={128,128,128},
                textString="rotation axis"),
              Polygon(
                points={{12,76},{-8,81},{-8,71},{12,76}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),
              Line(points={{-78,76},{-7,76}}, color={128,128,128}),
              Line(points={{30,-50},{20,-60}}, color={0,0,0}),
              Line(points={{30,-40},{10,-60}}, color={0,0,0}),
              Line(points={{20,-40},{0,-60}}, color={0,0,0}),
              Line(points={{10,-40},{-10,-60}}, color={0,0,0}),
              Line(points={{0,-40},{-20,-60}}, color={0,0,0}),
              Line(points={{-10,-40},{-30,-60}}, color={0,0,0}),
              Line(points={{-20,-40},{-30,-50}}, color={0,0,0})}));
        
      equation 
        phi = phi_a;
        phi = phi_b;
        power_a = flange_a.tau*der(phi);
        driving_a = power_a >= 0;
        flange_b.tau = -(if driving_a then eta*flange_a.tau else flange_a.tau/eta);
      end GearEfficiency;
      
      model Gear "Realistic model of a gearbox" 
        extends 
          ObsoleteModelica3.Mechanics.Rotational.Interfaces.TwoFlangesAndBearingH;
        
        parameter Real ratio=1 "transmission ratio (flange_a.phi/flange_b.phi)";
        parameter Real eta(
          min=Modelica.Constants.small,
          max=1) = 1 "Gear efficiency";
        parameter Real friction_pos[:, 2]=[0, 1] 
          "[w,tau] positive sliding friction characteristic (w>=0)";
        parameter Real peak(final min=1) = 1 
          "peak*friction_pos[1,2] = maximum friction torque at zero velocity";
        parameter Real c(
          final unit="N.m/rad",
          final min=Modelica.Constants.small) = 1.e5 
          "Gear elasticity (spring constant)";
        parameter Real d(
          final unit="N.m.s/rad",
          final min=0) = 0 "(relative) gear damping";
        parameter Modelica.SIunits.Angle b(final min=0)=0 "Total backlash";
        
        annotation (
          Documentation(info="<html>
<p>
This component models the essential effects of a gearbox, in particular
gear <b>efficiency</b> due to friction between the teeth, <b>bearing friction</b>,
gear <b>elasticity</b> and <b>damping</b>, <b>backlash</b>.
The inertia of the gear wheels is not modeled. If necessary, inertia
has to be taken into account by connecting components of model Inertia
to the left and/or the right flange.
</p>
 
</HTML>
"),       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-40,60},{40,-60}},
                lineColor={0,0,0},
                pattern=LinePattern.Solid,
                lineThickness=1,
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={192,192,192}),
              Polygon(
                points={{-60,-80},{-46,-80},{-20,-20},{20,-20},{46,-80},{60,-80},
                    {60,-90},{-60,-90},{-60,-80}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,10},{-60,-10}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={192,192,192}),
              Rectangle(
                extent={{60,10},{100,-10}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={192,192,192}),
              Polygon(
                points={{-60,10},{-60,20},{-40,40},{-40,-40},{-60,-20},{-60,10}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={128,128,128}),
              Polygon(
                points={{60,20},{40,40},{40,-40},{60,-20},{60,20}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-150,110},{150,70}},
                textString="%name=%ratio",
                lineColor={0,0,255}),
              Text(
                extent={{-150,-160},{150,-120}},
                lineColor={0,0,0},
                textString="c=%c")}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Text(
                extent={{2,29},{46,22}},
                lineColor={128,128,128},
                textString="rotation axis"),
              Polygon(
                points={{4,25},{-4,27},{-4,23},{4,25}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),
              Line(points={{-36,25},{-3,25}}, color={128,128,128})}));
        
        Modelica.Mechanics.Rotational.IdealGear gearRatio(final ratio=ratio) 
          annotation (Placement(transformation(extent={{-70,-10},{-50,10}},
                rotation=0)));
        ObsoleteModelica3.Mechanics.Rotational.GearEfficiency gearEfficiency(
                                      final eta=eta) 
          annotation (Placement(transformation(extent={{-30,-10},{-10,10}},
                rotation=0)));
        Modelica.Mechanics.Rotational.ElastoBacklash elastoBacklash(
          final b=b,
          final c=c,
          final phi_rel0=0,
          final d=d) annotation (Placement(transformation(extent={{50,-10},{70,10}},
                rotation=0)));
        Modelica.Mechanics.Rotational.BearingFriction bearingFriction(final 
            tau_pos=friction_pos, final peak=peak) 
          annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=
                  0)));
      equation 
        connect(flange_a, gearRatio.flange_a) 
          annotation (Line(points={{-100,0},{-70,0}}, color={0,0,0}));
        connect(gearRatio.flange_b, gearEfficiency.flange_a) 
          annotation (Line(points={{-50,0},{-30,0}}, color={0,0,0}));
        connect(gearEfficiency.flange_b, bearingFriction.flange_a) 
          annotation (Line(points={{-10,0},{10,0}}, color={0,0,0}));
        connect(bearingFriction.flange_b, elastoBacklash.flange_a) 
          annotation (Line(points={{30,0},{50,0}}, color={0,0,0}));
        connect(elastoBacklash.flange_b, flange_b) 
          annotation (Line(points={{70,0},{100,0}}, color={0,0,0}));
        connect(gearEfficiency.bearing, adapter.flange_b) annotation (Line(points={{-20,-10},
                {-20,-40},{6.12323e-016,-40},{6.12323e-016,-50}},           color={
                0,0,0}));
        connect(bearingFriction.support, adapter.flange_b) annotation (Line(
            points={{20,-10},{20,-40},{6.12323e-016,-40},{6.12323e-016,-50}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(gearRatio.support, adapter.flange_b) annotation (Line(
            points={{-60,-10},{-60,-40},{6.12323e-016,-40},{6.12323e-016,-50}},
            color={0,0,0},
            smooth=Smooth.None));
        
      end Gear;
    end Rotational;
  end Mechanics;
end ObsoleteModelica3;
