

package Rotational "1-dimensional rotational mechanical components" 
  extends Modelica.Icons.Library2;
  
  package SIunits = Modelica.SIunits ;
  package Math = Modelica.Math ;
  
  annotation (
    Coordsys(
      extent=[0, 0; 367, 487], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.06, 
      y=0, 
      width=0.29, 
      height=0.52, 
      library=1, 
      autolayout=1), 
    Documentation(info="
<HTML>
<p>
<b>Content</b><br><br>
1. Overview of library Modelica.Mechanics.Rotational<br>
2. Components of the library<br>
3. Flange connectors<br>
4. Sign conventions<br>
5. User-defined components<br>
6. Requirements for simulation tools
</p><br>

<p><b>1. Overview of library Modelica.Mechanics.Rotational</b></p>

<p>
This package contains components to model <b>1-dimensional rotational
mechanical</b> systems, including different types of gearboxes,
shafts with inertia, external torques, spring/damper elements,
frictional elements, backlash, elements to measure angle, angular velocity,
angular acceleration and the cut-torque of a flange. In sublibrary
<b>Examples</b> several examples are present to demonstrate the usage of
the elements. Just open the corresponding example model and simulate
the model according to the provided description. 
</p>

<p>
A unique feature of this library is the <b>component-oriented</b>
modeling of <b>Coulomb friction</b> elements, such as friction in bearings,
clutches, brakes, and gear efficiency. Even (dynamically) coupled 
friction elements, e.g., as in automatic gearboxes, can be handeled
<b>without</b> introducing stiffness which leads to fast simulations.
The underlying theory is new and is based on the solution of mixed
continuous/discrete systems of equations, i.e., equations where the
<b>unknowns</b> are of type Real, <b>Integer</b> or <b>Boolean</b>.
Provided appropriate numerical algorithms for the solution of such types of 
systems are available in the simulation tool, the simulation of
(dynamically) coupled friction elements of this library is 
<b>efficient</b> and <b>reliable</b>.
</p>

<IMG SRC=\"Modelica.Mechanics.Rotational.drive1.gif\" ALT=\"drive1\">

<p>
A simple example of the usage of this library is given in the
figure above. This drive consists of a shaft with inertia J1=0.2 which 
is connected via an ideal gearbox with gear ratio=5 to a second shaft 
with inertia J2=5. The left shaft is driven via an external, 
sinusoidal torque. 
The <b>filled</b> and <b>non-filled grey squares</b> at the left and 
right side of a component represent <b>mechanical flanges</b>.
Drawing a line between such squares means that the corresponding
flanges are <b>rigidly attached</b> to each other. 
By convention in this library, the connector characterized as a
<b>filled</b> grey square is called <b>flange_a</b> and placed at the
left side of the component in the \"design view\" and the connector
characterized as a <b>non-filled</b> grey square is called <b>flange_b</b>
and placed at the right side of the component in the \"design view\".
The two connectors are completely <b>identical</b>, with the only 
exception that the graphical layout is a little bit different in order
to distinguish them for easier access of the connector variables.
For example, <tt>J1.flange_a.tau</tt> is the cut-torque in the connector 
<tt>flange_a</tt> of component <tt>J1</tt>.
</p>

<p>
The components of this
library can be <b>connected</b> together in an <b>arbitrary</b> way. E.g. it is
possible to connect two springs or two shafts with inertia directly
together, see figure below.
</p>

<IMG SRC=\"Modelica.Mechanics.Rotational.driveConnections.gif\" ALT=\"driveConnections\">

<br><br>


<p><b>2. Components of the library</b></p>

<p>
This package contains the following model components:
</p>

<pre>
   <b>Examples</b>         Sublibrary containing example models.
   <b>Interfaces</b>       Sublibrary containing interface definitions.
   <b>Inertia</b>          Rotational component with inertia.
   <b>IdealGear</b>        Ideal gear transforming rotational in rotational motion.
   <b>IdealPlanetary</b>   Ideal standard planetary gear.
   <b>Torque</b>           External torque defined as input signal which accelerates
                    the connected flange for positive input signal.
   <b>Accelerate</b>       Forced movement of a flange with an angular acceleration
                    given as input signal (positive acceleration for 
                    positive input signal).
   <b>Fixed</b>            Fixing flange in housing at a predefined angle.
   <b>Spring</b>           Linear spring.
   <b>Damper</b>           Linear damper.
   <b>SpringDamper</b>     Linear spring and linear damper in parallel connection.
   <b>ElastoBacklash</b>   Linear spring, linear damper and backlash in series
                    connection (backlash is modeled with elasticity).
   <b>BearingFriction</b>  Coulomb friction in the bearings.
   <b>Clutch</b>           Frictional clutch where the clutch pressure force is an
                    input signal (= Coulomb friction between two flanges).
   <b>Brake</b>            Frictional brake where the brake pressure force is an
                    input signal (= Coulomb friction between flange
                    and housing).
   <b>GearEfficiency</b>   Efficiency of a gearbox.
   <b>Gear</b>             Realistic model of a gearbox (taking into account 
                    efficiency, bearing friction, elasticity, damping, backlash)
   <b>TorqueSensor</b>     Ideal sensor to measure the torque in a flange.
   <b>AngleSensor</b>      Ideal sensor to measure the absolute angle of a flange.
   <b>SpeedSensor</b>      Ideal sensor to measure the absolute angular velocity
                    of a flange.
   <b>AccSensor</b>        Ideal sensor to measure the absolute angular
                    acceleration of a flange.
   <b>RelAngleSensor</b>   Ideal sensor to measure the relative angle 
                    between two flanges.
   <b>RelSpeedSensor</b>   Ideal sensor to measure the relative angular velocity  
                    between two flanges.
   <b>RelAccSensor</b>     Ideal sensor to measure the relative angular
                    acceleration between two flanges.

</pre>

<p><b>3. Flange connectors</b></p>

<p>
A flange is described by the connector class
Interfaces.<b>Flange_a</b>
or Interfaces.<b>Flange_b</b>. As already noted, the two connector
classes are completely identical. There is only a difference in the icons,
in order to easier identify a flange variable in a diagram.
Both connector classes contain the following variables:
</p>

<pre>
   SIunits.Angle       phi  \"absolute rotation angle of flange\"; 
   <b>flow</b> SIunits.Torque tau  \"cut-torque in the flange\";
</pre>

<p>
If needed, the angular velocity <tt>w</tt> and the
angular acceleration <tt>a</tt> of a flange connector can be
determined by differentiation of the flange angle <tt>phi</tt>:
</p>

<pre>
     w = der(phi);    a = der(w);

</pre>


<p><b>4. Sign conventions</b></p>

<p>
The variables of a component of this library can be accessed in the
usual way. However, since most of these variables are basically elements
of <b>vectors</b>, i.e., have a direction, the question arises how the
signs of variables shall be interpreted. The basic idea is explained
at hand of the following figure:
</p>

<IMG SRC=\"Modelica.Mechanics.Rotational.drive2.gif\" ALT=\"drive2\">

<p>
In the figure, three identical drive trains are shown. The only
difference is that the gear of the middle drive train and the
gear as well as the right inertia of the lower drive train
are horizontally flipped with regards to the upper drive train.
The signs of variables are now interpreted in the following way:
Due to the 1-dimensional nature of the model, all components are
basically connected together along one line (more complicated
cases are discussed below). First, one has to define
a <b>positive</b> direction of this line, called <b>axis of rotation</b>. 
In the top part of the figure this is characterized by an arrow 
defined as <tt>axis of rotation</tt>. The simple rule is now:
If a variable of a component is positive and can be interpreted as
the element of a vector (e.g. torque or angular velocity vector), the
corresponding vector is directed into the positive direction
of the axis of rotation. In the following figure, the right-most
inertias of the figure above are displayed with the positive
vector direction displayed according to this rule:
</p>

<IMG SRC=\"Modelica.Mechanics.Rotational.drive3.gif\" ALT=\"drive3\">

<p>
The cut-torques <tt>J2.flange_a.tau, J4.flange_a.tau, J6.flange_b.tau</tt>
of the right inertias are all identical and are directed into the
direction of rotation if the values are positive. Similiarily,
the angular velocities <tt>J2.w, J4.w, J6.w</tt> of the right inertias
are all identical and are also directed into the
direction of rotation if the values are positive. Some special
cases are shown in the next figure:
</p>

<IMG SRC=\"Modelica.Mechanics.Rotational.drive4.gif\" ALT=\"drive4\">

<p>
In the upper part of the figure, two variants of the connection of an 
external torque and an inertia are shown. In both cases, a positive
signal input into the torque component accelerates the inertias
<tt>inertia1, inertia2</tt> into the positive axis of rotation,
i.e., the angular accelerations <tt>inertia1.a, inertia2.a</tt>
are positive and are directed along the \"axis of rotation\" arrow.
In the lower part of the figure the connection of inertias with 
a planetary gear are shown. Note, that the three flanges of the
planetary gearbox are located along the axis of rotation and that
the axis direction determines the positive rotation along these
flanges. As a result, the positive rotation for <tt>inertia4, inertia6</tt>
is as indicated with the additional grey arrows.
</p><br>


<p><b>5. User-defined components</b></p>

<p>
In this section some hints are given to define your own 
1-dimensional rotational components which are compatible with the
elements of this package.
It is convenient to define a new
component by inheritance from one of the following base classes,
which are defined in sublibrary Interfaces:
</p>

<pre>
  <b>Rigid</b>            Rigid connection of two rotational 1D flanges
                   (used for elements with inertia).
  <b>Compliant</b>        Compliant connection of two rotational 1D flanges
                   (used for force laws such as a spring or a damper).
  <b>TwoFlanges</b>       General connection of two rotational 1D flanges
                   (used for gearboxes).
  <b>AbsoluteSensor</b>   Measure absolute flange variables.
  <b>RelativeSensor</b>   Measure relative flange variables.
</pre>

<p>
The difference between these base classes are the auxiliary
variables defined in the model and the relations between
the flange variables already defined in the base class.
For example, in model <b>Rigid</b> the flanges flange_a and
flange_b are rigidly connected, i.e., flange_a.phi = flange_b.phi,
whereas in model <b>Compliant</b> the cut-torques are the
same, i.e., flange_a.tau + flange_b.tau = 0.
</p>

<p>
The equations of a mechanical component are vector equations, i.e.,
they need to be expressed in a common coordinate system.
Therefore, for a component a <b>local axis of rotation</b> has to be
defined. All vector quantities, such as cut-torques or angular
velocities have to be expressed according to this definition.
Examples for such a definition are given in the following figure
for an inertia component and a planetary gearbox:
</p>

<IMG SRC=\"Modelica.Mechanics.Rotational.driveAxis.gif\" ALT=\"driveAxis\">

<p>
As can be seen, all vectors are directed into the direction
of the rotation axis. The angles in the flanges are defined
correspondingly. For example, the angle <tt>sun.phi</tt> in the
flange of the sun wheel of the planetary gearbox is positive,
if rotated in mathematical positive direction (= counter clock
wise) along the axis of rotation.
</p>

<p>
On first view, one may assume that the selected local
coordinate system has an influence on the usage of the
component. But this is not the case, as shown in the next figure:
</p>

<IMG SRC=\"Modelica.Mechanics.Rotational.inertias.gif\" ALT=\"inertias\">

<p>
In the figure the <b>local</b> axes of rotation of the components
are shown. The connection of two inertias in the left and in the
right part of the figure are completely equivalent, i.e., the right
part is just a different drawing of the left part. This is due to the
fact, that by a connection, the two local coordinate systems are
made identical and the (automatically) generated connection equations
(= angles are identical, cut-torques sum-up to zero) are also
expressed in this common coordinate system. Therefore, even if in 
the left figure it seems to be that the angular velocity vector of
<tt>J2</tt> goes from right to left, in reality it goes from
left to right as shown in the right part of the figure, where the
local coordinate systems are drawn such that they are aligned.
Note, that the simple rule stated in section 4. (Sign conventions)
also determines that
the angular velocity of <tt>J2</tt> in the left part of the
figure is directed from left to right.
</p>

<p>
To summarize, the local coordinate system selected for a component
is just necessary, in order that the equations of this component
are expressed correctly. The selection of the coordinate system
is arbitrary and has no influence on the usage of the component.
Especially, the actual direction of, e.g., a cut-torque is most
easily determined by the rule of section 4. A more strict determination
by aligning coordinate systems and then using the vector direction
of the local coordinate systems, often requires a re-drawing of the
diagram and is therefore less convenient to use.
</p><br>


<p><b>6. Requirements for simulation tools</b></p>

<p>
This library is designed in a fully object oriented way in order that
components can be connected together in every meaningful combination
(e.g. direct connection of two springs or two inertias).
As a consequence, most models lead to a system of 
differential-algebraic equations of <b>index 3</b> (= constraint 
equations have to be differentiated twice in order to arrive at
a state space representation) and the Modelica translator or
the simulator has to cope with this system representation.
According to our present knowledge, this requires that the
Modelica translator is able to symbolically differentiate equations
(otherwise it is e.g. not possible to provide consistent initial
conditions; even if consistent initial conditions are present, most 
numerical DAE integrators can cope at most with index 2 DAEs). 
</p>


</p>
The elements of this library can be connected together in an
arbitrary way. However, difficulties may occur, if the elements which can <b>lock</b> the 
<b>relative motion</b> between two flanges are connected <b>rigidly</b> 
together such that essentially the <b>same relative motion</b> can be locked. 
The reason is 
that the cut-torque in the locked phase is not uniquely defined if the 
elements are locked at the same time instant (i.e., there does not exist a 
unique solution) and some simulation systems may not be
able to handle this situation, since this leads to a singularity during
simulation. Currently, this type of problem can occur with the
Coulomb friction elements <b>BearingFriction, Clutch, Brake</b> when
the elements become stuck:
</p>

<IMG SRC=\"Modelica.Mechanics.Rotational.driveConnections2.gif\" ALT=\"driveConnections2\">

<p>
In the figure above two typical situations are shown: In the upper part of
the figure, the series connection of rigidly attached BearingFriction and
Clutch components are shown. This does not hurt, because the BearingFriction
element can lock the relative motion between the element and the housing,
whereas the clutch element can lock the relative motion between the two
connected flanges. Contrary, the drive train in the lower part of the figure
may give rise to simulation problems, because the BearingFriction element
and the Brake element can lock the relative motion between a flange and
the housing and these flanges are rigidly connected together, i.e., 
essentially the same relative motion can be locked. These difficulties
may be solved by either introducing a compliance between these flanges
or by combining the BearingFriction and Brake element into 
one component and resolving the ambiguity of the frictional torque in the
stuck mode. A tool may handle this situation also <b>automatically</b>,
by picking one solution of the infinitely many, e.g., the one where
the difference to the value of the previous time instant is as small
as possible.
</p>


<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Systemdynamik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Nov. 4, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br> 
       Improved documentation and improved graphical layout of the diagram level.
       Changes according to the Twente meeting introduced. Especially:
       Alias names, instead of extends. Model Shaft renamed to Inertia.
       Torque1D renamed to Torque. 
       AccMotion renamed to Accelerate. LockedL, LockedR replaced by Fixed.
       SpeedSensor splitted into AngleSensor and
       SpeedSensor. RelSpeedSensor splitted into RelAngleSensor and
       RelSpeedSensor. Initialization of friction elements improved.
       Flanges renamed to flange_a, flange_b. MoveAngle renamed to 
       KinematicPTP, vectorized and moved to Blocks.Sources.<br>
       Advice given from P. Beater, H. Elmqvist, S.E.-Mattsson, H. Olsson
       is appreciated.</li>

<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Documentation and icons improved. Appropriate initial conditions 
       introduced as start values in the demo models. Bearing model
       replaced by FixedRight and FixedLeft models; sensor elements replaced by 
       TorqueSensor, SpeedSensor, AccSensor; new sensor elements 
       RelSpeedSensor, RelAccSensor to measure relative kinematic quantitites.
       New elements GearEfficiency and Gear.</li>
 
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized a first version based on an existing Dymola library
       of Martin Otter and Hilding Elmqvist.</li>
</ul>
<br>


<p><b>Copyright (C) 1999, Modelica Design Group and DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package 
Modelica in file \"Modelica/package.mo\".
</i></p>

</HTML>
"), 
    Icon(
      Line(points=[-83, -66; -63, -66], style(color=0)), 
      Line(points=[36, -68; 56, -68], style(color=0)), 
      Line(points=[-73, -66; -73, -91], style(color=0)), 
      Line(points=[46, -68; 46, -91], style(color=0)), 
      Line(points=[-83, -29; -63, -29], style(color=0)), 
      Line(points=[36, -32; 56, -32], style(color=0)), 
      Line(points=[-73, -9; -73, -29], style(color=0)), 
      Line(points=[46, -12; 46, -32], style(color=0)), 
      Line(points=[-73, -91; 46, -91], style(color=0)), 
      Rectangle(extent=[-47, -17; 27, -80], style(
          color=0, 
          gradient=2, 
          fillColor=8)), 
      Rectangle(extent=[-87, -41; -47, -54], style(
          color=0, 
          gradient=2, 
          fillColor=8)), 
      Rectangle(extent=[27, -42; 66, -56], style(
          color=0, 
          gradient=2, 
          fillColor=8))));
  package Examples "Demonstration examples of the components of this package" 
    extends Modelica.Icons.Library;
    
    package SIunits = Modelica.SIunits ;
    annotation (
      Coordsys(
        extent=[0, 0; 484, 316], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.01, 
        y=0.01, 
        width=0.48, 
        height=0.47, 
        library=1, 
        autolayout=1), 
      Documentation(info="
<HTML>
<p>
This package contains example models to demonstrate the usage of the
Modelica.Mechanics.Rotational package. Open the models and
simulate them according to the provided description in the models.
The following demo models are present:
</p>

<pre>
   <b>First</b>            First example using simple, basic elements
   <b>Friction</b>         Example to demonstrate usage of a clutch and a brake
   <b>CoupledClutches</b>  Example to demonstrate usage of 3 dynamically
                    coupled clutches.
</pre>


<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Systemdynamik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Appropriate initial conditions provided as start values in the model.
       <br><br>

<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized a first version based on an existing Dymola library
       of Martin Otter and Hilding Elmqvist.
</li>
</ul>
<br>

<p><b>Copyright (C) 1999, Modelica Design Group and DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package 
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
    model First "First example: simple drive train" 
      extends Modelica.Icons.Example;
      
      parameter Real amplitude=10;
      parameter SIunits.Frequency freqHz=5;
      parameter SIunits.Inertia Jmotor=0.1;
      parameter SIunits.Inertia Jload=2;
      parameter Real ratio=10;
      parameter Real damping=10;
      annotation (
        Coordsys(
          extent=[-140, -100; 220, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.23, 
          y=0.02, 
          width=0.52, 
          height=0.64), 
        Documentation(info="
<HTML>
<p>
The drive train consists of a motor inertia which is driven by
a sine-wave motor torque. Via a gearbox the rotational energy is 
transmitted to a load inertia. Elasticity in the gearbox is modelled
by a spring element. A linear damper is used to model the 
damping in the gearbox bearing. 
</p>

<p>
Note, that a force component (like the damper of this example) which is
acting between a shaft and the housing has to be fixed in the housing
on one side via component Fixed.
</p>

<p>
Simulate for 1 second and plot the following variables:<br>
  angular velocities of inertias inertia2 and 3: inertia2.w, inertia3.w
</p>


<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
      Modelica.Mechanics.Rotational.Fixed fixed annotation (extent=[100, -40; 
            120, -20]);
      Modelica.Mechanics.Rotational.Torque torque annotation (extent=[-60, 20
            ; -40, 40]);
      Modelica.Mechanics.Rotational.Inertia inertia1(J=Jmotor) annotation (
          extent=[-20, 20; 0, 40]);
      Modelica.Mechanics.Rotational.IdealGear idealGear(ratio=ratio) 
        annotation (extent=[20, 20; 40, 40]);
      Modelica.Mechanics.Rotational.Inertia inertia2(
        J=2, 
        phi(start=0), 
        w(start=0)) annotation (extent=[60, 20; 80, 40]);
      Modelica.Mechanics.Rotational.Spring spring(c=1.e4) annotation (extent=[
            140, 20; 160, 40]);
      Modelica.Mechanics.Rotational.Inertia inertia3(
        J=Jload, 
        phi(start=0), 
        w(start=0)) annotation (extent=[180, 20; 200, 40]);
      Modelica.Mechanics.Rotational.Damper damper(d=damping) annotation (
          extent=[100, 0; 120, 20], rotation=-90);
      Modelica.Blocks.Sources.Sine sine(amplitude={amplitude}, freqHz={freqHz}
        ) annotation (extent=[-100, 20; -80, 40]);
    equation 
      connect(torque.flange_b, inertia1.flange_a) annotation (points=[-40
            , 30; -20, 30]);
    equation 
      connect(inertia1.flange_b, idealGear.flange_a) annotation (points=[0
            , 30; 20, 30]);
    equation 
      connect(idealGear.flange_b, inertia2.flange_a) annotation (points=[
            40, 30; 60, 30]);
    equation 
      connect(inertia2.flange_b, spring.flange_a) annotation (points=[80, 
            30; 140, 30]);
    equation 
      connect(spring.flange_b, inertia3.flange_a) annotation (points=[160
            , 30; 180, 30]);
    equation 
      connect(inertia2.flange_b, damper.flange_a) annotation (points=[80, 
            30; 110, 30; 110, 20]);
    equation 
      connect(sine.outPort, torque.inPort) annotation (points=[-79, 30; -
            64, 30; -62, 30]);
    equation 
      connect(damper.flange_b, fixed.flange_b) annotation (points=[110, 0
            ; 110, -30]);
    end First;
    model Friction "Drive train with clutch and brake" 
      extends Modelica.Icons.Example;
      
      output SIunits.Torque tMotor "driving torque of inertia3";
      output SIunits.Torque tClutch "friction torque of clutch";
      output SIunits.Torque tBrake "friction torque of brake";
      output SIunits.Torque tSpring "spring torque";
      annotation (
        Coordsys(
          extent=[-100, -100; 240, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.05, 
          y=0.04, 
          width=0.65, 
          height=0.74), 
        Documentation(info="
<HTML>
<p>
This drive train contains a frictional <b>clutch</b> and a <b>brake</b>.
Simulate the system for 1 second using the following initial
values (defined already in the model):
</p>

<pre>
   inertia1.w =  90 (or brake.w)
   inertia2.w =  90
   inertia3.w = 100
</pre>

<p>
Plot the output signals  
</p>

<pre>
    tMotor    Torque of motor
    tClutch   Torque in clutch
    tBrake    Torque in brake
    tSpring   Torque in spring
</pre>

<p>
as well as the absolute angular velocities of the three inertia components 
(inertia1.w, inertia2.w, inertia3.w).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"));
      Modelica.Mechanics.Rotational.Torque torque annotation (extent=[-80, -20
            ; -60, 0]);
      Modelica.Mechanics.Rotational.Inertia inertia3(
        J=1, 
        phi(start=0), 
        w(start=100)) annotation (extent=[-40, -20; -20, 0]);
      Modelica.Mechanics.Rotational.Clutch clutch(fn_max=160) annotation (
          extent=[0, -20; 20, 0]);
      Modelica.Mechanics.Rotational.Inertia inertia2(
        J=0.05, 
        phi(start=0), 
        w(start=90)) annotation (extent=[40, -20; 60, 0]);
      Modelica.Mechanics.Rotational.SpringDamper spring(c=160, d=1) 
        annotation (extent=[80, -20; 100, 0]);
      Modelica.Mechanics.Rotational.Inertia inertia1(
        J=1, 
        phi(start=0), 
        w(start=90)) annotation (extent=[160, -20; 180, 0]);
      Modelica.Mechanics.Rotational.Brake brake(fn_max=1600) annotation (
          extent=[120, -20; 140, 0]);
      Modelica.Blocks.Sources.Constant const(k={1}) annotation (extent=[0, 20
            ; 20, 40], rotation=-90);
      Modelica.Blocks.Sources.Step step(startTime={0.5}) annotation (extent=[
            120, 20; 140, 40], rotation=-90);
    equation 
      connect(torque.flange_b, inertia3.flange_a) annotation (points=[-60
            , -10; -40, -10]);
    equation 
      connect(inertia3.flange_b, clutch.flange_a) annotation (points=[-20
            , -10; 0, -10]);
    equation 
      connect(clutch.flange_b, inertia2.flange_a) annotation (points=[20, 
            -10; 40, -10]);
    equation 
      connect(inertia2.flange_b, spring.flange_a) annotation (points=[60, 
            -10; 80, -10]);
    equation 
      connect(spring.flange_b, brake.flange_a) annotation (points=[100, -
            10; 120, -10]);
    equation 
      connect(brake.flange_b, inertia1.flange_a) annotation (points=[140, 
            -10; 160, -10]);
    equation 
      connect(const.outPort, clutch.inPort) annotation (points=[10, 18; 10
            , 0]);
    equation 
      connect(step.outPort, brake.inPort) annotation (points=[130, 18; 130
            , 2]);
    equation 
      torque.tau = if time < step.startTime[1] then 200*sin(100*time)
         else 0;
      tMotor = torque.tau;
      tClutch = clutch.tau;
      tBrake = brake.tau;
      tSpring = spring.tau;
    end Friction;
    model CoupledClutches "Drive train with 3 dynamically coupled clutches" 
      extends Modelica.Icons.Example;
      
      parameter SIunits.Frequency freqHz=0.2 
        "frequency of sine function to invoke clutch1";
      parameter SIunits.Time T2=0.4 "time when clutch2 is invoked";
      parameter SIunits.Time T3=0.9 "time when clutch3 is invoked";
      annotation (
        Coordsys(
          extent=[-100, -100; 260, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.18, 
          y=0.04, 
          width=0.67, 
          height=0.7), 
        Documentation(info="
<HTML>
<p>
This example demonstrates how variable structure drive trains are handeled.
The drive train consists of 4 inertias and 3 clutches, where the clutches 
are controlled by input signals. The system has 2^3=8 different configurations
and 3^3 = 27 different states (every clutch may be in forward sliding,
backward sliding or locked mode when the relative angular velocity is zero).
By invoking the clutches at different time instances, the switching of the
configurations can be studied.
</p>

<p>
Simulate the system for 1.2 seconds with the following initial values:<br>
J1.w = 10.
</p>

<p>
Plot the following variables:<br>
angular velocities of inertias (J1.w, J2.w, J3.w, J4.w),
frictional torques of clutches (clutchX.tau),
frictional mode of clutches (clutchX.mode) where  
mode = -1/0/+1 means backward sliding, locked, forward sliding.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>
<HTML>
 
"));
      Modelica.Mechanics.Rotational.Inertia J1(
        J=1, 
        phi(start=0), 
        w(start=10)) annotation (extent=[-20, 20; 0, 40]);
      Modelica.Mechanics.Rotational.Torque torque annotation (extent=[-60, 20
            ; -40, 40]);
      Modelica.Mechanics.Rotational.Clutch clutch1(peak=1.1, fn_max=20) 
        annotation (extent=[20, 20; 40, 40]);
      Modelica.Blocks.Sources.Sine sin1(amplitude={10}, freqHz={5}) 
        annotation (extent=[-100, 20; -80, 40]);
      Modelica.Blocks.Sources.Step step1(startTime={T2}) annotation (extent=[
            100, 60; 120, 80], rotation=-90);
      Modelica.Mechanics.Rotational.Inertia J2(J=1) annotation (extent=[60, 20
            ; 80, 40]);
      Modelica.Mechanics.Rotational.Clutch clutch2(peak=1.1, fn_max=20) 
        annotation (extent=[100, 20; 120, 40]);
      Modelica.Mechanics.Rotational.Inertia J3(J=1) annotation (extent=[140, 
            20; 160, 40]);
      Modelica.Mechanics.Rotational.Clutch clutch3(peak=1.1, fn_max=20) 
        annotation (extent=[180, 20; 200, 40]);
      Modelica.Mechanics.Rotational.Inertia J4(J=1) annotation (extent=[220, 
            20; 240, 40]);
      Modelica.Blocks.Sources.Sine sin2(
        amplitude={1}, 
        freqHz={freqHz}, 
        phase={1.57}) annotation (extent=[20, 60; 40, 80], rotation=-90);
      Modelica.Blocks.Sources.Step step2(startTime={T3}) annotation (extent=[
            180, 60; 200, 80], rotation=-90);
    equation 
      connect(clutch1.flange_b, J2.flange_a) annotation (points=[40, 30; 
            60, 30]);
    equation 
      connect(J1.flange_b, clutch1.flange_a) annotation (points=[0, 30; 20
            , 30]);
    equation 
      connect(clutch2.flange_b, J3.flange_a) annotation (points=[120, 30; 
            140, 30]);
    equation 
      connect(J2.flange_b, clutch2.flange_a) annotation (points=[80, 30; 
            100, 30]);
    equation 
      connect(clutch3.flange_b, J4.flange_a) annotation (points=[200, 30; 
            220, 30]);
    equation 
      connect(J3.flange_b, clutch3.flange_a) annotation (points=[160, 30; 
            180, 30]);
    equation 
      connect(sin1.outPort, torque.inPort) annotation (points=[-78, 30; -
            62, 30]);
    equation 
      connect(torque.flange_b, J1.flange_a) annotation (points=[-40, 30; -
            20, 30]);
    equation 
      connect(sin2.outPort, clutch1.inPort) annotation (points=[30, 58; 30
            , 40]);
    equation 
      connect(step1.outPort, clutch2.inPort) annotation (points=[110, 58; 
            110, 40]);
    equation 
      connect(step2.outPort, clutch3.inPort) annotation (points=[190, 60; 
            190, 40]);
    end CoupledClutches;
  end Examples;
  package Interfaces 
    "Connectors and partial models for 1D rotational mechanical components" 
    extends Modelica.Icons.Library;
    package SIunits = Modelica.SIunits ;
    
    annotation (
      Coordsys(
        extent=[0, 0; 442, 394], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.01, 
        y=0.01, 
        width=0.34, 
        height=0.4, 
        library=1, 
        autolayout=1), 
      Documentation(info="
<HTML>
<p>
This package contains connectors and partial models for 1D rotational mechanical
components. In particular
</p>

<pre>
  <b>Flange_a</b>       flange_a flange of a component.
  <b>Flange_b</b>      Right flange of a component.
  <b>Rigid</b>            Rigid connection of two rotational 1D flanges
                   (used for elements with inertia).
  <b>Compliant</b>        Compliant connection of two rotational 1D flanges
                   (used for force laws such as a spring or a damper).
  <b>TwoFlanges</b>       Component with two rotational 1D flanges
  <b>AbsoluteSensor</b>   Base class to measure absolute flange variables.
  <b>Relative Sensor</b>  Base class to measure relative flange variables.
</pre>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Systemdynamik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       New components: TwoFlanges, AbsoluteSensor, RelativeSensor.</li>
       <br><br></li>

<li><i>June 28, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
<br>

<p><b>Copyright (C) 1999, Modelica Design Group and DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package 
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
    
    connector Flange_a "1D rotational flange (filled square icon)" 
      SIunits.Angle phi "Absolute rotation angle of flange";
      flow SIunits.Torque tau "Cut torque in the flange";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.23, 
          y=0.02, 
          width=0.56, 
          height=0.68), 
        Documentation(info="<HTML>
<p>
This is a connector for 1D rotational mechanical systems and models
a mechanical flange. The following variables are defined in this connector:
</p>

<pre>
   <b>phi</b>: Absolute rotation angle of the flange in [rad].
   <b>tau</b>: Cut-torque in the flange in [Nm].
</pre>

<p>
There is a second connector for flanges: Flange_b. The connectors
Flange_a and Flange_b are completely identical. There is only a difference
in the icons, in order to easier identify a flange variable in a diagram.
For a discussion on the actual direction of the cut-torque tau and
of the rotation angle, see the information text of package Rotational
(section 4. Sign conventions).
</p>

<p>
If needed, the absolute angular velocity w and the 
absolute angular acceleration a of the flange can be determined by
differentiation of the flange angle phi: 
</p>

<pre>
     w = der(phi);    a = der(w)
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Nov. 2, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Improved documentation.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</HTML>
"), 
        Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=0, fillColor
                =10))), 
        Diagram(Rectangle(extent=[-100, -100; 100, 100], style(color=0, 
                fillColor=10)), Text(
            extent=[-100, -120; 100, -220], 
            string="%name", 
            style(color=0))), 
        Terminal(Rectangle(extent=[-100, -100; 100, 100], style(color=0, 
                fillColor=10))));
    end Flange_a;
    
    connector Flange_b "1D rotational flange (non-filled square icon)" 
      SIunits.Angle phi "Absolute rotation angle of flange";
      flow SIunits.Torque tau "Cut torque in the flange";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.21, 
          y=0.05, 
          width=0.48, 
          height=0.65), 
        Documentation(info="<HTML>
<p>
This is a connector for 1D rotational mechanical systems and models
a mechanical flange. The following variables are defined in this connector:
</p>

<pre>
   <b>phi</b>: Absolute rotation angle of the flange in [rad].
   <b>tau</b>: Cut-torque in the flange in [Nm].
</pre>

<p>
There is a second connector for flanges: Flange_a. The connectors
Flange_a and Flange_b are completely identical. There is only a difference
in the icons, in order to easier identify a flange variable in a diagram.
For a discussion on the actual direction of the cut-torque tau and
of the rotation angle, see the information text of package Rotational
(section 4. Sign conventions).
</p>

<p>
If needed, the absolute angular velocity w and the 
absolute angular acceleration a of the flange can be determined by
differentiation of the flange angle phi: 
</p>

<pre>
     w = der(phi);    a = der(w)
</pre>


<p><b>Release Notes:</b></p>
<ul>
<li><i>Nov. 2, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Improved documentation.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
        Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=0, fillColor
                =7))), 
        Diagram(Rectangle(extent=[-100, -100; 100, 100], style(color=0, 
                fillColor=7)), Text(
            extent=[-100, -120; 100, -220], 
            string="%name", 
            style(color=0))), 
        Terminal(Rectangle(extent=[-100, -100; 100, 100], style(color=0, 
                fillColor=7))));
    end Flange_b;
    
    partial model Rigid 
      "Base class for the rigid connection of two rotational 1D flanges" 
      SIunits.Angle phi 
        "Absolute rotation angle of component (= flange_a.phi = flange_b.phi)";
      
      Interfaces.Flange_a flange_a 
        "(left) driving flange (flange axis directed INTO cut plane)" 
        annotation (extent=[-110, -10; -90, 10]);
      Interfaces.Flange_b flange_b 
        "(right) driven flange (flange axis directed OUT OF cut plane)" 
        annotation (extent=[90, -10; 110, 10]);
      annotation (
        Documentation(info="
<HTML>
<p>
This is a 1D rotational component with two rigidly connected flanges,
i.e., flange_a.phi = flange_b.phi. It is used e.g. to built up components
with inertia.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
        Diagram(
          Line(points=[140, 0; 110, 0], style(color=0, fillColor=0)), 
          Polygon(points=[140, 3; 150, 0; 140, -3; 140, 3; 140, 3], style(
                color=0, fillColor=0)), 
          Line(points=[-120, 0; -150, 0], style(color=0, fillColor=0)), 
          Polygon(points=[-120, 3; -110, 0; -120, -3; -120, 3], style(color=0
                , fillColor=0)), 
          Text(extent=[-150, 16; -114, 6], string="flange_a.tau"), 
          Text(extent=[-148, -4; -114, -14], string="flange_a.phi"), 
          Text(extent=[112, 16; 148, 6], string="flange_b.tau"), 
          Text(extent=[114, -4; 148, -14], string="flange_b.phi")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.18, 
          y=0.3, 
          width=0.61, 
          height=0.66));
    equation 
      flange_a.phi = phi;
      flange_b.phi = phi;
    end Rigid;
    
    partial model Compliant 
      "Base class for the compliant connection of two rotational 1D flanges" 
      SIunits.Angle phi_rel(start=0) 
        "Relative rotation angle (= flange_b.phi - flange_a.phi)";
      SIunits.Torque tau "Torque between flanges (= flange_b.tau)";
      Interfaces.Flange_a flange_a 
        "(left) driving flange (flange axis directed INTO cut plane)" 
        annotation (extent=[-110, -10; -90, 10]);
      Interfaces.Flange_b flange_b 
        "(right) driven flange (flange axis directed OUT OF cut plane)" 
        annotation (extent=[90, -10; 110, 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.32, 
          y=0.01, 
          width=0.6, 
          height=0.6), 
        Documentation(info="
<HTML>
<p>
This is a 1D rotational component with a compliant connection of two
rotational 1D flanges where inertial effects between the two
flanges are neglected. The basic assumption is that the cut-torques
of the two flanges sum-up to zero, i.e., they have the same absolute value 
but opposite sign: flange_a.tau + flange_b.tau = 0. This base class
is used to built up force elements such as springs, dampers, friction.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
        Diagram(
          Polygon(points=[-120, 3; -110, 0; -120, -3; -120, 3], style(color=0
                , fillColor=0)), 
          Line(points=[-120, 0; -149, 0], style(color=0, fillColor=0)), 
          Line(points=[139, -1; 110, -1], style(color=0, fillColor=0)), 
          Polygon(points=[139, 2; 149, -1; 139, -4; 139, 2], style(color=0, 
                fillColor=0)), 
          Text(extent=[-150, 16; -114, 6], string="flange_a.tau"), 
          Text(extent=[-148, -4; -114, -14], string="flange_a.phi"), 
          Text(extent=[112, 16; 148, 6], string="flange_b.tau"), 
          Text(extent=[114, -4; 148, -14], string="flange_b.phi")));
    equation 
      phi_rel = flange_b.phi - flange_a.phi;
      flange_b.tau = tau;
      flange_a.tau = -tau;
    end Compliant;
    
    partial model TwoFlanges 
      "Base class for a component with two rotational 1D flanges" 
      Interfaces.Flange_a flange_a annotation (extent=[-110, -10; -90, 10]);
      Interfaces.Flange_b flange_b annotation (extent=[90, -10; 110, 10]);
      annotation (
        Documentation(info="
<HTML>
<p>
This is a 1D rotational component with two flanges.
It is used e.g. to built up parts of a drive train consisting
of several base components. There are specialized versions of this
base class for rigidly connected flanges (Interfaces.Rigid) and
for a compliant connection of flanges (Interfaces.Compliant).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
        Diagram(
          Line(points=[140, 0; 110, 0], style(color=0, fillColor=0)), 
          Polygon(points=[140, 3; 150, 0; 140, -3; 140, 3; 140, 3], style(
                color=0, fillColor=0)), 
          Line(points=[-120, 0; -150, 0], style(color=0, fillColor=0)), 
          Polygon(points=[-120, 3; -110, 0; -120, -3; -120, 3], style(color=0
                , fillColor=0)), 
          Text(extent=[-150, 16; -114, 6], string="flange_a.tau"), 
          Text(extent=[-148, -4; -114, -14], string="flange_a.phi"), 
          Text(extent=[112, 16; 148, 6], string="flange_b.tau"), 
          Text(extent=[114, -4; 148, -14], string="flange_b.phi")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.37, 
          y=0.05, 
          width=0.6, 
          height=0.6));
    end TwoFlanges;
    
    partial model FrictionBase "Base class of Coulomb friction elements" 
      parameter SIunits.AngularVelocity w_small=1 
        "Relative angular velocity near to zero (see model info text)";
      
      
        // Equations to define the following variables have to be defined in subclasses
      SIunits.AngularVelocity w_relfric 
        "Relative angular velocity between frictional surfaces";
      SIunits.AngularAcceleration a_relfric 
        "Relative angular acceleration between frictional surfaces";
      SIunits.Torque tau 
        "Friction torque (positive, if directed in opposite direction of w_rel)"
        ;
      SIunits.Torque tau0 "Friction torque for w=0 and forward sliding";
      SIunits.Torque tau0_max "Maximum friction torque for w=0 and locked";
      Boolean free "true, if frictional element is not active";
      
      // Equations to define the following variables are given in this class
      Real sa "Path parameter of friction characteristic tau = f(a_relfric)";
      
      Boolean startForward 
        "true, if w_rel=0 and start of forward sliding or w_rel > w_small";
      Boolean startBackward 
        "true, if w_rel=0 and start of backward sliding or w_rel < -w_small";
      Boolean locked "true, if w_rel=0 and not sliding";
      
      constant Integer Unknown=3 "Value of mode is not known";
      constant Integer Free=2 "Element is not active";
      constant Integer Forward=1 "w_rel > 0 (forward sliding)";
      constant Integer Stuck=0 
        "w_rel = 0 (forward sliding, locked or backward sliding)";
      constant Integer Backward=-1 "w_rel < 0 (backward sliding)";
      Integer mode(
        final min=Backward, 
        final max=Unknown, 
        start=Unknown);
      annotation (Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), Window(
          x=0.21, 
          y=0.04, 
          width=0.78, 
          height=0.87));
    equation 
      /* Friction characteristic
     (locked is introduced to help the Modelica translator determining
      the different structural configurations, if for each configuration
      special code shall be generated)
  */
      startForward = pre(mode) == Stuck and (sa > tau0_max or pre(startForward
        ) and sa > tau0) or pre(mode) == Backward and w_relfric > w_small or 
        initial() and noEvent(w_relfric > 0);
      startBackward = pre(mode) == Stuck and (sa < -tau0_max or pre(
        startBackward) and sa < -tau0) or pre(mode) == Forward and w_relfric < 
        -w_small or initial() and noEvent(w_relfric < 0);
      locked = not free and not (pre(mode) == Forward or startForward or pre(
        mode) == Backward or startBackward);
      
      a_relfric = if locked then 0 else if free then sa else if startForward
         then sa - tau0 else if startBackward then sa + tau0 else if pre(mode)
         == Forward then sa - tau0 else sa + tau0;
      
      /* Friction torque has to be defined in a subclass. Example for a clutch:
       tau = if locked then sa else if free then 0 else cgeo*fn*
                (if startForward  then  Math.tempInterpol1( w_relfric, mue_pos, 2)
             else if startBackward then -Math.tempInterpol1(-w_relfric, mue_pos, 2)
             else if pre(mode) == Forward then Math.tempInterpol1(w_relfric, mue_pos, 2) 
             else -Math.tempInterpol1(-w_relfric, mue_pos, 2));
  */
      
      // finite state machine to determine configuration
      mode = if free then Free else (if (pre(mode) == Forward or pre(mode) == 
        Free or startForward) and w_relfric > 0 then Forward else if (pre(mode)
         == Backward or pre(mode) == Free or startBackward) and w_relfric < 0
         then Backward else Stuck);
    end FrictionBase;
    
    partial model AbsoluteSensor 
      "Base class to measure a single absolute flange variable" 
      extends Modelica.Icons.RotationalSensor;
      Interfaces.Flange_a flange_a 
        "(left) flange to be measured (flange axis directed INTO cut plane)" 
        annotation (extent=[-110, -10; -90, 10]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=1) annotation (extent
          =[100, -10; 120, 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[1, 1], 
          component=[20, 20]), 
        Window(
          x=0.39, 
          y=0.05, 
          width=0.6, 
          height=0.6), 
        Documentation(info="
<HTML>
<p>
This is the base class of a 1D rotational component with one flange and one 
output signal in order to measure an absolute kinematic quantity in the flange
and to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
        Icon(
          Line(points=[-70, 0; -90, 0], style(color=0)), 
          Line(points=[70, 0; 100, 0]), 
          Text(extent=[-110, 80; 110, 120], string="%name")), 
        Diagram(
          Line(points=[-120, 0; -150, 0], style(color=0, fillColor=0)), 
          Polygon(points=[-120, 3; -110, 0; -120, -3; -120, 3], style(color=0
                , fillColor=0)), 
          Line(points=[-70, 0; -90, 0], style(color=0)), 
          Line(points=[70, 0; 100, 0]), 
          Text(extent=[-150, 16; -114, 6], string="flange_a.tau"), 
          Text(extent=[-148, -4; -114, -14], string="flange_a.phi")));
    end AbsoluteSensor;
    
    model RelativeSensor 
      "Base class to measure a single relative variable between two flanges" 
      extends Modelica.Icons.RotationalSensor;
      
      Interfaces.Flange_a flange_a 
        "(left) driving flange (flange axis directed INTO cut plane)" 
        annotation (extent=[-110, -10; -90, 10]);
      Interfaces.Flange_b flange_b 
        "(right) driven flange (flange axis directed OUT OF cut plane)" 
        annotation (extent=[90, -10; 110, 10]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=1) annotation (extent
          =[-10, -100; 10, -120], rotation=90);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[1, 1], 
          component=[20, 20]), 
        Window(
          x=0.37, 
          y=0.02, 
          width=0.6, 
          height=0.65), 
        Documentation(info="
<HTML>
<p>
This is a base class for 1D rotational components with two rigidly connected
flanges and one output signal in order to measure relative kinematic quantities
between the two flanges or the cut-torque in the flange and
to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
        Icon(
          Line(points=[-70, 0; -90, 0], style(color=0)), 
          Line(points=[70, 0; 90, 0], style(color=0)), 
          Line(points=[0, -100; 0, -70]), 
          Text(extent=[-110, 80; 110, 120], string="%name")), 
        Diagram(
          Line(points=[140, 0; 110, 0], style(color=0, fillColor=0)), 
          Polygon(points=[140, 3; 150, 0; 140, -3; 140, 3; 140, 3], style(
                color=0, fillColor=0)), 
          Line(points=[-120, 0; -150, 0], style(color=0, fillColor=0)), 
          Polygon(points=[-120, 3; -110, 0; -120, -3; -120, 3], style(color=0
                , fillColor=0)), 
          Line(points=[-70, 0; -90, 0], style(color=0)), 
          Line(points=[70, 0; 90, 0], style(color=0)), 
          Line(points=[0, -100; 0, -70]), 
          Text(extent=[-150, 16; -114, 6], string="flange_a.tau"), 
          Text(extent=[-148, -4; -114, -14], string="flange_a.phi"), 
          Text(extent=[112, 16; 148, 6], string="flange_b.tau"), 
          Text(extent=[114, -4; 148, -14], string="flange_b.phi")));
    end RelativeSensor;
    
  end Interfaces;
  package Sensors 
    "Sensors to measure variables in 1D rotational mechanical components" 
    extends Modelica.Icons.Library;
    package SIunits = Modelica.SIunits ;
    
    model TorqueSensor 
      "Ideal sensor to measure the torque between two flanges (= flange_a.tau)"
       
      extends Modelica.Icons.RotationalSensor;
      SIunits.Torque tau 
        "Torque in flange flange_a and flange_b (= flange_a.tau = -flange_b.tau)"
        ;
      annotation (
        Documentation(info="
<HTML>
<p>
Measures the <b>cut-torque between two flanges</b> in an ideal way
and provides the result as output signal outPort.signal[1] = flange_a.tau
(to be further processed with blocks of the Modelica.Blocks library).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized.
</li>
</ul>

</HTML>
"), 
        Icon(
          Text(extent=[-39, -71; 41, -121], string="tau", style(color=0)), 
          Line(points=[-80, -100; -80, 0]), 
          Line(points=[-70, 0; -90, 0], style(color=0)), 
          Line(points=[70, 0; 90, 0], style(color=0)), 
          Text(extent=[-110, 80; 110, 120], string="%name")), 
        Diagram(
          Text(extent=[-60, -80; -29, -101], string="tau"), 
          Polygon(points=[14, 85; -6, 90; -6, 80; 14, 85], style(color=10, 
                fillColor=10)), 
          Line(points=[-76, 85; -5, 85], style(color=10, fillColor=10)), 
          Text(
            extent=[18, 92; 86, 79], 
            string="rotation axis", 
            style(color=10)), 
          Line(points=[-70, 0; -90, 0], style(color=0)), 
          Text(extent=[-148, -4; -114, -14], string="flange_a.phi"), 
          Polygon(points=[-120, 3; -110, 0; -120, -3; -120, 3], style(color=0
                , fillColor=0)), 
          Line(points=[-120, 0; -150, 0], style(color=0, fillColor=0)), 
          Text(extent=[-150, 16; -114, 6], string="flange_a.tau"), 
          Line(points=[140, 0; 110, 0], style(color=0, fillColor=0)), 
          Polygon(points=[140, 3; 150, 0; 140, -3; 140, 3; 140, 3], style(
                color=0, fillColor=0)), 
          Line(points=[70, 0; 90, 0], style(color=0)), 
          Text(extent=[112, 16; 148, 6], string="flange_b.tau"), 
          Text(extent=[114, -4; 148, -14], string="flange_b.phi"), 
          Line(points=[-80, -100; -80, 0])), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[1, 1], 
          component=[20, 20]), 
        Window(
          x=0.43, 
          y=0.11, 
          width=0.55, 
          height=0.59));
      Interfaces.Flange_a flange_a annotation (extent=[-110, -10; -90, 10]);
      Interfaces.Flange_b flange_b annotation (extent=[90, -10; 110, 10]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=1) annotation (extent
          =[-89, -100; -69, -120], rotation=90);
    equation 
      flange_a.phi = flange_b.phi;
      flange_a.tau = tau;
      flange_b.tau = -tau;
      tau = outPort.signal[1];
    end TorqueSensor;
    model AngleSensor "Ideal sensor to measure the absolute flange angle" 
      extends Interfaces.AbsoluteSensor;
      SIunits.Angle phi "Absolute angle of flange";
      annotation (
        Documentation(info="
<HTML>
<p>
Measures the <b>absolute angle phi</b> of a flange in an ideal
way and provides the result as output signal outPort.signal[1]
(to be further processed with blocks of the Modelica.Blocks library).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized.
</li>
</ul>

</HTML>
"), 
        Icon(Text(extent=[70, -30; 120, -80], string="phi", style(color=0))), 
        Diagram(
          Text(extent=[70, -11; 100, -31], string="phi"), 
          Text(
            extent=[14, 101; 82, 88], 
            string="rotation axis", 
            style(color=10)), 
          Polygon(points=[10, 94; -10, 99; -10, 89; 10, 94], style(color=10, 
                fillColor=10)), 
          Line(points=[-80, 94; -9, 94], style(color=10, fillColor=10))), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[1, 1], 
          component=[20, 20]), 
        Window(
          x=0.08, 
          y=0.09, 
          width=0.6, 
          height=0.6));
    equation 
      phi = flange_a.phi;
      phi = outPort.signal[1];
      0 = flange_a.tau;
    end AngleSensor;
    model SpeedSensor 
      "Ideal sensor to measure the absolute flange angular velocity" 
      extends Interfaces.AbsoluteSensor;
      SIunits.AngularVelocity w "Absolute angular velocity of flange";
      annotation (
        Documentation(info="
<HTML>
<p>
Measures the <b>absolute angular velocity w</b> of a flange in an ideal
way and provides the result as output signal outPort.signal[1]
(to be further processed with blocks of the Modelica.Blocks library).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized.
</li>
</ul>

</HTML>
"), 
        Icon(Text(extent=[70, -30; 120, -80], string="w", style(color=0))), 
        Diagram(
          Text(extent=[69, -10; 100, -30], string="w"), 
          Polygon(points=[13, 93; -7, 98; -7, 88; 13, 93], style(color=10, 
                fillColor=10)), 
          Line(points=[-77, 93; -6, 93], style(color=10, fillColor=10)), 
          Text(
            extent=[14, 100; 82, 87], 
            string="rotation axis", 
            style(color=10))), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[1, 1], 
          component=[20, 20]), 
        Window(
          x=0.12, 
          y=0.08, 
          width=0.6, 
          height=0.6));
    equation 
      w = der(flange_a.phi);
      w = outPort.signal[1];
      0 = flange_a.tau;
    end SpeedSensor;
    model AccSensor 
      "Ideal sensor to measure the absolute flange angular acceleration" 
      extends Interfaces.AbsoluteSensor;
      SIunits.AngularAcceleration a "Absolute angular acceleration of flange";
      SIunits.AngularVelocity w "Absolute angular velocity of flange";
      annotation (
        Documentation(info="
<HTML>
<p>
Measures the <b>absolute angular acceleration a</b> of a flange in an ideal
way and provides the result as output signal (to be further processed with 
blocks of the Modelica.Blocks library).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized.
</li>
</ul>

</HTML>
"), 
        Icon(Text(extent=[70, -30; 120, -80], string="a", style(color=0))), 
        Diagram(
          Text(extent=[69, -11; 100, -31], string="a"), 
          Polygon(points=[13, 93; -7, 98; -7, 88; 13, 93], style(color=10, 
                fillColor=10)), 
          Line(points=[-77, 93; -6, 93], style(color=10, fillColor=10)), 
          Text(
            extent=[17, 100; 85, 87], 
            string="rotation axis", 
            style(color=10))), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[1, 1], 
          component=[20, 20]), 
        Window(
          x=0.17, 
          y=0.12, 
          width=0.6, 
          height=0.6));
    equation 
      w = der(flange_a.phi);
      a = der(w);
      a = outPort.signal[1];
      0 = flange_a.tau;
    end AccSensor;
    model RelAngleSensor 
      "Ideal sensor to measure the relative angle between two flanges" 
      extends Interfaces.RelativeSensor;
      SIunits.Angle phi_rel 
        "Relative angle between two flanges (= flange_b.phi - flange_a.phi)";
      annotation (
        Documentation(info="
<HTML>
<p>
Measures the <b>relative angle phi_rel</b> between two flanges
in an ideal way and provides the result as output signal outPort.signal[1]
(to be further processed with blocks of the Modelica.Blocks library).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized.
</li>
</ul>

</HTML>
"), 
        Icon(Text(extent=[20, -70; 160, -100], string="phi_rel", style(color=0))), 
        Diagram(
          Text(extent=[24, -76; 65, -96], string="phi_rel"), 
          Polygon(points=[13, 93; -7, 98; -7, 88; 13, 93], style(color=10, 
                fillColor=10)), 
          Line(points=[-77, 93; -6, 93], style(color=10, fillColor=10)), 
          Text(
            extent=[17, 100; 85, 87], 
            string="rotation axis", 
            style(color=10))), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[1, 1], 
          component=[20, 20]), 
        Window(
          x=0.12, 
          y=0.17, 
          width=0.6, 
          height=0.6));
    equation 
      phi_rel = flange_b.phi - flange_a.phi;
      phi_rel = outPort.signal[1];
      0 = flange_a.tau;
      0 = flange_b.tau;
    end RelAngleSensor;
    model RelSpeedSensor 
      "Ideal sensor to measure the relative angular velocity between two flanges"
       
      
      extends Interfaces.RelativeSensor;
      SIunits.Angle phi_rel 
        "Relative angle between two flanges (flange_b.phi - flange_a.phi)";
      SIunits.AngularVelocity w_rel 
        "Relative angular velocity between two flanges";
      annotation (
        Documentation(info="
<HTML>
<p>
Measures the <b>relative angular velocity w_rel</b> between two flanges
in an ideal way and provides the result as output signal outPort.signal[1]
(to be further processed with blocks of the Modelica.Blocks library).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized.
</li>
</ul>

</HTML>
"), 
        Icon(Text(extent=[20, -70; 160, -100], string="w_rel", style(color=0))), 
        Diagram(
          Text(extent=[25, -79; 65, -98], string="w_rel"), 
          Polygon(points=[13, 93; -7, 98; -7, 88; 13, 93], style(color=10, 
                fillColor=10)), 
          Line(points=[-77, 93; -6, 93], style(color=10, fillColor=10)), 
          Text(
            extent=[17, 100; 85, 87], 
            string="rotation axis", 
            style(color=10))), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[1, 1], 
          component=[20, 20]), 
        Window(
          x=0.12, 
          y=0.05, 
          width=0.6, 
          height=0.6));
    equation 
      phi_rel = flange_b.phi - flange_a.phi;
      w_rel = der(phi_rel);
      w_rel = outPort.signal[1];
      0 = flange_a.tau;
      0 = flange_b.tau;
    end RelSpeedSensor;
    model RelAccSensor 
      "Ideal sensor to measure the relative angular acceleration between two flanges"
       
      
      extends Interfaces.RelativeSensor;
      SIunits.Angle phi_rel 
        "Relative angle between two flanges (flange_b.phi - flange_a.phi)";
      SIunits.AngularVelocity w_rel 
        "Relative angular velocity between two flanges";
      SIunits.AngularAcceleration a_rel 
        "Relative angular aceleration between two flanges";
      annotation (
        Documentation(info="
<HTML>
<p>
Measures the <b>relative angular acceleration a_rel</b> between two flanges
in an ideal way and provides the result as output signal outPort.signal[1]
(to be further processed with blocks of the Modelica.Blocks library).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized.
</li>
</ul>

</HTML>
"), 
        Icon(Text(extent=[20, -70; 160, -100], string="a_rel", style(color=0))), 
        Diagram(
          Text(extent=[18, -81; 58, -100], string="a_rel"), 
          Polygon(points=[13, 93; -7, 98; -7, 88; 13, 93], style(color=10, 
                fillColor=10)), 
          Line(points=[-77, 93; -6, 93], style(color=10, fillColor=10)), 
          Text(
            extent=[17, 100; 85, 87], 
            string="rotation axis", 
            style(color=10))), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[1, 1], 
          component=[20, 20]), 
        Window(
          x=0.14, 
          y=0.08, 
          width=0.6, 
          height=0.6));
    equation 
      phi_rel = flange_b.phi - flange_a.phi;
      w_rel = der(phi_rel);
      a_rel = der(w_rel);
      a_rel = outPort.signal[1];
      0 = flange_a.tau;
      0 = flange_b.tau;
    end RelAccSensor;
    annotation (Coordsys(
        extent=[0, 0; 370, 270], 
        grid=[1, 1], 
        component=[20, 20]), Window(
        x=0.06, 
        y=0.53, 
        width=0.3, 
        height=0.31, 
        library=1, 
        autolayout=1));
  end Sensors;
  model Inertia "1D-rotational component with inertia" 
    extends Interfaces.Rigid;
    parameter SIunits.Inertia J=1 "Moment of inertia";
    SIunits.AngularVelocity w "Absolute angular velocity of component";
    SIunits.AngularAcceleration a "Absolute angular acceleration of component"
      ;
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.2, 
        y=0.05, 
        width=0.7, 
        height=0.63), 
      Documentation(info="
<HTML>
<p>
Rotational component with <b>inertia</b> and two rigidly connected flanges.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</HTML>
"), 
      Icon(
        Line(points=[-80, -25; -60, -25], style(color=0)), 
        Line(points=[60, -25; 80, -25], style(color=0)), 
        Line(points=[-70, -25; -70, -70], style(color=0)), 
        Line(points=[70, -25; 70, -70], style(color=0)), 
        Line(points=[-80, 25; -60, 25], style(color=0)), 
        Line(points=[60, 25; 80, 25], style(color=0)), 
        Line(points=[-70, 45; -70, 25], style(color=0)), 
        Line(points=[70, 45; 70, 25], style(color=0)), 
        Line(points=[-70, -70; 70, -70], style(color=0)), 
        Rectangle(extent=[-50, 50; 50, -50], style(
            color=0, 
            gradient=2, 
            fillColor=8)), 
        Rectangle(extent=[-90, 10; -50, -10], style(
            color=0, 
            gradient=2, 
            fillColor=8)), 
        Rectangle(extent=[50, 10; 90, -10], style(
            color=0, 
            gradient=2, 
            fillColor=8)), 
        Text(extent=[-100, 120; 100, 60], string="%name=%J")), 
      Diagram(
        Line(points=[-80, -25; -60, -25], style(color=0)), 
        Line(points=[60, -25; 80, -25], style(color=0)), 
        Line(points=[-70, -25; -70, -70], style(color=0)), 
        Line(points=[70, -25; 70, -70], style(color=0)), 
        Line(points=[-80, 25; -60, 25], style(color=0)), 
        Line(points=[60, 25; 80, 25], style(color=0)), 
        Line(points=[-70, 45; -70, 25], style(color=0)), 
        Line(points=[70, 45; 70, 25], style(color=0)), 
        Line(points=[-70, -70; 70, -70], style(color=0)), 
        Rectangle(extent=[-50, 50; 50, -50], style(
            color=0, 
            gradient=2, 
            fillColor=8)), 
        Rectangle(extent=[-90, 10; -50, -10], style(
            color=0, 
            gradient=2, 
            fillColor=8)), 
        Rectangle(extent=[50, 10; 90, -10], style(
            color=0, 
            gradient=2, 
            fillColor=8)), 
        Polygon(points=[0, -90; -20, -85; -20, -95; 0, -90], style(color=10, 
              fillColor=10)), 
        Line(points=[-90, -90; -19, -90], style(color=10, fillColor=10)), 
        Text(
          extent=[4, -83; 72, -96], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[9, 73; 19, 70; 9, 67; 9, 73], style(color=0, fillColor
              =0)), 
        Line(points=[9, 70; -21, 70], style(color=0, fillColor=0)), 
        Text(extent=[25, 77; 77, 65], string="w = der(phi) ")));
  equation 
    w = der(phi);
    a = der(w);
    J*a = flange_a.tau + flange_b.tau;
  end Inertia;
  model IdealGear "Ideal gear without inertia" 
    extends Interfaces.TwoFlanges;
    parameter Real ratio=1 "Transmission ratio (flange_a.phi/flange_b.phi)";
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.29, 
        y=0.31, 
        width=0.6, 
        height=0.57), 
      Documentation(info="
<HTML>
<p>
This element characterices any type of gear box which is fixed in the
ground and which has one driving shaft and one driven shaft.
The gear is <b>ideal</b>, i.e., it does not have inertia, elasticity, damping
or backlash. If these effects have to be considered, the gear has to be 
connected to other elements in an appropriate way.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Icon(
        Rectangle(extent=[-40, 20; -20, -20], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-40, 140; -20, 20], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[20, 100; 40, 60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[20, 60; 40, -60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[40, 10; 90, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-20, 90; 20, 70], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-90, 10; -40, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Text(extent=[-100, -64; 98, -124], string="%name=%ratio")), 
      Diagram(
        Rectangle(extent=[-40, 20; -20, -20], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-40, 140; -20, 20], style(
            color=0, 
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[20, 100; 40, 60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[20, 60; 40, -60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-90, 10; -40, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[40, 10; 90, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-20, 90; 20, 70], style(
            color=0, 
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Line(points=[-90, -90; -19, -90], style(color=10, fillColor=10)), 
        Polygon(points=[0, -90; -20, -85; -20, -95; 0, -90], style(color=10, 
              fillColor=10)), 
        Text(
          extent=[5, -82; 73, -95], 
          string="rotation axis", 
          style(color=10))));
  equation 
    flange_a.phi = ratio*flange_b.phi;
    0 = ratio*flange_a.tau + flange_b.tau;
  end IdealGear;
  model IdealPlanetary "Ideal planetary gear box" 
    parameter Real ratio=100/50 
      "number of ring_teeth/sun_teeth (e.g. ratio=100/50)";
    
    // kinematic relationship
    Interfaces.Flange_a sun "sun flange (flange axis directed INTO cut plane)"
       annotation (extent=[-110, -10; -90, 10]);
    Interfaces.Flange_a carrier 
      "carrier flange (flange axis directed INTO cut plane)" annotation (extent
        =[-90, 30; -110, 50]);
    Interfaces.Flange_b ring 
      "ring flange (flange axis directed OUT OF cut plane)" annotation (extent=
          [110, -10; 90, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.25, 
        y=0.01, 
        width=0.54, 
        height=0.56), 
      Documentation(info="<HTML>
<p>
The IdealPlanetary gear box is an ideal gear without inertia, 
elasticity, damping or backlash consisting
of an inner <b>sun</b> wheel, an outer <b>ring</b> wheel and a
<b>planet</b> wheel located between sun and ring wheel. The bearing
of the planet wheel shaft is fixed in the planet <b>carrier</b>.
The component can be connected to other elements at the
sun, ring and/or carrier flanges. It is not possible to connect
to the planet wheel. If inertia shall not be neglected, 
the sun, ring and carrier inertias can be easily added by attaching
inertias (= model Inertia) to the corresponding connectors. 
The inertias of the planet wheels are always neglected.
</p>

<p>
The icon of the planetary gear signals that the sun and carrier
flanges are on the left side and the ring flange is on the right side
of the gear box. However, this component is generic and is valid 
independantly how the flanges are actually placed (e.g. sun wheel 
may be placed on the right side instead on the left side in reality).
</p>

<p>
The ideal planetary gearbox is uniquely defined by the ratio
of the number of ring teeth zr with respect to the number of
sun teeth zs. For example, if there are 100 ring teeth and 
50 sun teeth then ratio = zr/zs = 2. The number of planet teeth
zp has to fulfill the following relationship:
</p>

<pre>
   <b>zp := (zr - zs) / 2</b>
</pre>

<p>
Therefore, in the above example zp = 25 is required.
</p>

<p>
According to the overall convention, the positive direction of all
vectors, especially the absolute angular velocities and cut-torques 
in the flanges, are along the axis vector displayed in the icon.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 5, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Icon(
        Rectangle(extent=[50, 100; 10, -100], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-10, 45; -50, 85], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-10, 30; -50, -30], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-50, 10; -90, -10], style(
            color=8, 
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[90, 10; 50, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[50, 100; -50, 105], style(
            color=9, 
            fillColor=9, 
            fillPattern=1)), 
        Rectangle(extent=[50, -100; -50, -105], style(
            color=9, 
            fillColor=9, 
            fillPattern=1)), 
        Rectangle(extent=[-80, 70; -50, 60], style(
            color=0, 
            gradient=2, 
            arrow=1, 
            fillColor=8, 
            fillPattern=1)), 
        Line(points=[-90, 40; -70, 40], style(color=0)), 
        Line(points=[-80, 50; -60, 50], style(color=0)), 
        Line(points=[-70, 50; -70, 40], style(color=0)), 
        Line(points=[-80, 80; -59, 80], style(color=0)), 
        Line(points=[-70, 100; -70, 80], style(color=0)), 
        Text(extent=[-121, -101; 137, -174], string="%name=%ratio")), 
      Diagram(
        Rectangle(extent=[50, 100; 10, -100], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-10, 45; -50, 85], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-10, 30; -50, -30], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-50, 10; -90, -10], style(
            color=8, 
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[90, 10; 50, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[50, 100; -50, 105], style(
            color=9, 
            fillColor=9, 
            fillPattern=1)), 
        Rectangle(extent=[50, -100; -50, -105], style(
            color=9, 
            fillColor=9, 
            fillPattern=1)), 
        Rectangle(extent=[-80, 70; -50, 60], style(
            color=0, 
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Line(points=[-90, 40; -70, 40], style(color=0)), 
        Line(points=[-80, 50; -60, 50], style(color=0)), 
        Line(points=[-70, 50; -70, 40], style(color=0)), 
        Line(points=[-80, 80; -59, 80], style(color=0)), 
        Line(points=[-70, 90; -70, 80], style(color=0)), 
        Line(points=[-26, -42; -32, -2], style(pattern=3)), 
        Line(points=[36, -26; 64, -60], style(pattern=3)), 
        Text(extent=[58, -66; 98, -78], string="ring gear"), 
        Text(extent=[-112, 111; -56, 87], string="planet carrier "), 
        Text(extent=[-47, -42; -3, -56], string="sun gear"), 
        Polygon(points=[58, 130; 28, 140; 28, 120; 58, 130], style(
            color=10, 
            fillColor=10, 
            fillPattern=1)), 
        Line(points=[-52, 130; 28, 130], style(
            color=0, 
            fillColor=10, 
            fillPattern=1)), 
        Line(points=[-92, 93; -70, 80], style(pattern=3)), 
        Polygon(points=[-120, 3; -110, 0; -120, -3; -120, 3], style(color=0, 
              fillColor=0)), 
        Line(points=[-120, 0; -149, 0], style(color=0, fillColor=0)), 
        Polygon(points=[-120, 42; -110, 39; -120, 36; -120, 42], style(color=0
              , fillColor=0)), 
        Line(points=[-120, 39; -149, 39], style(color=0, fillColor=0)), 
        Line(points=[139, -1; 110, -1], style(color=0, fillColor=0)), 
        Polygon(points=[139, 2; 149, -1; 139, -4; 139, 2], style(color=0, 
              fillColor=0)), 
        Text(extent=[-150, 14; -114, 4], string="sun.tau"), 
        Text(extent=[-148, -4; -114, -14], string="sun.phi"), 
        Text(extent=[-148, 35; -114, 25], string="carrier.phi"), 
        Text(extent=[-147, 53; -114, 43], string="carrier.tau"), 
        Text(extent=[112, 16; 148, 6], string="ring.tau"), 
        Text(extent=[114, -4; 148, -14], string="ring.phi"), 
        Polygon(points=[-7, -86; -27, -81; -27, -91; -7, -86], style(color=10
              , fillColor=10)), 
        Line(points=[-97, -86; -26, -86], style(color=10, fillColor=10)), 
        Text(
          extent=[-96, -71; -28, -84], 
          string="rotation axis", 
          style(color=10))));
  equation 
    (1 + ratio)*carrier.phi = sun.phi + ratio*ring.phi;
    
    // torque balance (no inertias)
    ring.tau = ratio*sun.tau;
    carrier.tau = -(1 + ratio)*sun.tau;
  end IdealPlanetary;
  model Torque "Input signal acting as external torque on a flange" 
    SIunits.Torque tau "Torque (a positive value accelerates the flange)";
    Modelica.Blocks.Interfaces.InPort inPort(final n=1) 
      "Connector of input signal used as torque" annotation (extent=[-140, -20
          ; -100, 20]);
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b 
      "(Right) flange" annotation (extent=[90, -10; 110, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.26, 
        y=0, 
        width=0.67, 
        height=0.72), 
      Documentation(info="<HTML>
<p>
The input signal <b>inPort.signal[1]</b> defines an external
torque <b>tau</b> in [Nm] which acts (with negative sign) at 
a flange connector, i.e., the component connected to this 
flange is driven by torque <b>tau</b>.</p>
<p>
The input signal can be provided from one of the signal generator
blocks of Modelica.Blocks.Sources.

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Icon(
        Rectangle(extent=[20, 10; 90, -11], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-99, 30; 10, -30], style(
            color=3, 
            pattern=1, 
            thickness=1, 
            gradient=2, 
            arrow=0, 
            fillColor=8, 
            fillPattern=1)), 
        Polygon(points=[20, 20; 10, 30; 10, -30; 20, -20; 20, 20], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Text(extent=[-100, 128; 100, 68], string="%name"), 
        Text(
          extent=[-100, -40; -20, -90], 
          string="tau", 
          style(color=0))), 
      Diagram(
        Line(points=[139, -1; 110, -1], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Polygon(points=[139, 2; 149, -1; 139, -4; 139, 2], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Text(extent=[-124, 37; -95, 13], string="tau"), 
        Line(points=[-100, 0; -90, 0]), 
        Text(extent=[112, 16; 148, 6], string="flange_b.tau"), 
        Text(extent=[114, -4; 148, -14], string="flange_b.phi"), 
        Text(
          extent=[14, 64; 82, 51], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[10, 57; -10, 62; -10, 52; 10, 57], style(color=10, 
              fillColor=10)), 
        Line(points=[-80, 57; -9, 57], style(color=10, fillColor=10)), 
        Rectangle(extent=[-89, 30; 10, -30], style(
            color=3, 
            pattern=1, 
            thickness=1, 
            gradient=2, 
            arrow=0, 
            fillColor=8, 
            fillPattern=1)), 
        Polygon(points=[20, 20; 10, 30; 10, -30; 20, -20; 20, 20], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Rectangle(extent=[20, 10; 90, -11], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1))));
  equation 
    tau = inPort.signal[1];
    flange_b.tau = -tau;
  end Torque;
  model Accelerate 
    "Forced movement of a flange according to an acceleration signal" 
    parameter SIunits.Angle phi_start=0 "Start angle";
    parameter SIunits.AngularVelocity w_start=0 "Start angular velocity";
    
    SIunits.Angle phi(final start=phi_start) 
      "absolute rotation angle of flange flange_b";
    SIunits.AngularVelocity w(final start=w_start) 
      "absolute angular velocity of flange flange_b";
    SIunits.AngularAcceleration a 
      "absolute angular acceleration of flange flange_b";
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
        extent=[90, -10; 110, 10]);
    Modelica.Blocks.Interfaces.InPort inPort(final n=1) 
      "Angular acceleration as input signal" annotation (extent=[-140, -20; 
          -100, 20]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.22, 
        y=0.01, 
        width=0.47, 
        height=0.55), 
      Documentation(info="
<HTML>
<p>
The input signal inPort.signal[1] defines an <b>angular acceleration</b>
<b>a</b> in [rad/s2]. Flange <b>flange_b</b> is <b>forced</b> to move with 
this acceleration. The angular velocity <b>w</b> and the rotation angle
<b>phi</b> of the flange are automatically determined by integration of 
the acceleration.
</p>

<p>
The input signal can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       renamed (previous name: Move).</li>

<li><i>June 29, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized.</li>
</ul>

</HTML>
"), 
      Icon(
        Text(
          extent=[-108, -24; -68, -64], 
          string="a", 
          style(color=0)), 
        Text(extent=[-100, 120; 98, 60], string="%name"), 
        Rectangle(extent=[-100, 20; 90, -20], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Line(points=[-30, -32; 30, -32], style(color=0)), 
        Line(points=[0, 52; 0, 32], style(color=0)), 
        Line(points=[-29, 32; 30, 32], style(color=0)), 
        Line(points=[0, -32; 0, -60], style(color=0))), 
      Diagram(
        Text(extent=[-118, 76; -78, 36], string="a"), 
        Line(points=[140, 0; 110, 0], style(color=0, fillColor=0)), 
        Polygon(points=[140, 3; 150, 0; 140, -3; 140, 3; 140, 3], style(color=
                0, fillColor=0)), 
        Rectangle(extent=[-100, 20; 90, -20], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Line(points=[-30, -32; 30, -32], style(color=0)), 
        Line(points=[0, 52; 0, 32], style(color=0)), 
        Line(points=[-29, 32; 30, 32], style(color=0)), 
        Line(points=[0, -32; 0, -60], style(color=0)), 
        Text(extent=[112, 16; 148, 6], string="flange_b.tau"), 
        Text(extent=[114, -4; 148, -14], string="flange_b.phi"), 
        Text(
          extent=[4, -83; 72, -96], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[0, -90; -20, -85; -20, -95; 0, -90], style(color=10, 
              fillColor=10)), 
        Line(points=[-90, -90; -19, -90], style(color=10, fillColor=10))));
  equation 
    phi = flange_b.phi;
    w = der(phi);
    a = der(w);
    a = inPort.signal[1];
  end Accelerate;
  model Fixed "Flange fixed in housing at a given angle" 
    parameter SIunits.Angle phi0=0 "Fixed offset angle of housing";
    
    Interfaces.Flange_b flange_b "(right) flange fixed in housing" annotation 
      (extent=[10, 10; -10, -10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.35, 
        y=0.08, 
        width=0.63, 
        height=0.73), 
      Icon(
        Text(extent=[-120, -80; 116, -140], string="%name=%phi0"), 
        Line(points=[-80, -40; 80, -40], style(color=0)), 
        Line(points=[80, -40; 40, -80], style(color=0)), 
        Line(points=[40, -40; 0, -80], style(color=0)), 
        Line(points=[0, -40; -40, -80], style(color=0)), 
        Line(points=[-40, -40; -80, -80], style(color=0)), 
        Line(points=[0, -40; 0, -10], style(color=0))), 
      Documentation(info="
<HTML>
<p>
The <b>flange</b> of a 1D rotational mechanical system is <b>fixed</b>
at an angle phi0 in the <b>housing</b>. May be used:
</p>

<ul>
<li> to connect a compliant element, such as a spring or a damper, 
     between an inertia or gearbox component and the housing.

<li> to fix a rigid element, such as an inertia, with a specific
     angle to the housing.
</ul>


<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Diagram(
        Line(points=[-80, -40; 80, -40], style(color=0)), 
        Line(points=[80, -40; 40, -80], style(color=0)), 
        Line(points=[40, -40; 0, -80], style(color=0)), 
        Line(points=[0, -40; -40, -80], style(color=0)), 
        Line(points=[-40, -40; -80, -80], style(color=0)), 
        Line(points=[0, -40; 0, -10], style(color=0)), 
        Text(extent=[12, 18; 48, 8], string="flange_b.tau"), 
        Line(points=[40, 2; 10, 2], style(color=0, fillColor=0)), 
        Text(extent=[14, -2; 48, -12], string="flange_b.phi"), 
        Polygon(points=[40, 5; 50, 2; 40, -1; 40, 5; 40, 5], style(color=0, 
              fillColor=0)), 
        Polygon(points=[8, 46; -12, 51; -12, 41; 8, 46], style(color=10, 
              fillColor=10)), 
        Line(points=[-82, 46; -11, 46], style(color=10, fillColor=10)), 
        Text(
          extent=[12, 53; 80, 40], 
          string="rotation axis", 
          style(color=10))));
  equation 
    flange_b.phi = phi0;
  end Fixed;
  model Spring "Linear 1D rotational spring" 
    extends Interfaces.Compliant;
    parameter Real c(final unit="N.m/rad", final min=0) "Spring constant";
    parameter SIunits.Angle phi_rel0=0 "Unstretched spring angle";
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.21, 
        y=0.02, 
        width=0.8, 
        height=0.69), 
      Documentation(info="
<HTML>
<p>
A <b>linear 1D rotational spring</b>. The component can be connected either 
between two inertias/gears to describe the shaft elasticity, or between
a inertia/gear and the housing (component Fixed), to describe
a coupling of the element with the housing via a spring.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Icon(Text(extent=[-100, 100; 100, 40], string="%name=%c"), Line(points=[
              -90, 0; -58, 0; -43, -30; -13, 30; 17, -30; 47, 30; 62, 0; 90, 0]
            , style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0))), 
      Diagram(
        Line(points=[-68, 0; -68, 65], style(color=10)), 
        Line(points=[72, 0; 72, 65], style(color=10)), 
        Line(points=[-68, 60; 72, 60], style(color=10)), 
        Polygon(points=[62, 63; 72, 60; 62, 57; 62, 63], style(color=10, 
              fillColor=10)), 
        Text(
          extent=[-22, 62; 18, 87], 
          string="phi_rel", 
          style(color=3)), 
        Text(
          extent=[12, -61; 80, -74], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[8, -68; -12, -63; -12, -73; 8, -68], style(color=10, 
              fillColor=10)), 
        Line(points=[-82, -68; -11, -68], style(color=10, fillColor=10)), 
        Line(points=[-80, 0; -60, 0; -42, -32; -12, 30; 18, -30; 48, 28; 62, 0
              ; 80, 0])));
  equation 
    tau = c*(phi_rel - phi_rel0);
  end Spring;
  model Damper "Linear 1D rotational damper" 
    extends Interfaces.Compliant;
    parameter Real d(
      final unit="N.m.s/rad", 
      final min=0) = 0 "Damping constant";
    SIunits.AngularVelocity w_rel 
      "Relative angular velocity between flange_b and flange_a";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.23, 
        y=0.05, 
        width=0.6, 
        height=0.6), 
      Documentation(info="
<HTML>
<p>
<b>Linear, velocity dependent damper</b> element. It can be either connected 
between an inertia or gear and the housing (component Fixed), or 
between two inertia/gear elements.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Icon(
        Line(points=[-90, 0; -60, 0], style(color=0)), 
        Line(points=[-60, -30; -60, 30], style(color=0)), 
        Line(points=[-60, -30; 60, -30], style(color=0)), 
        Line(points=[-60, 30; 60, 30], style(color=0)), 
        Rectangle(extent=[-60, 30; 30, -30], style(color=0, fillColor=8)), 
        Line(points=[30, 0; 90, 0], style(color=0)), 
        Text(extent=[-80, 100; 80, 40], string="%name=%d")), 
      Diagram(
        Line(points=[-90, 0; -60, 0], style(color=0)), 
        Line(points=[-60, -30; -60, 30], style(color=0)), 
        Line(points=[-60, -30; 60, -30], style(color=0)), 
        Line(points=[-60, 30; 60, 30], style(color=0)), 
        Rectangle(extent=[-60, 30; 30, -30], style(color=0, fillColor=8)), 
        Line(points=[30, 0; 90, 0], style(color=0)), 
        Line(points=[-68, 0; -68, 65], style(color=10)), 
        Text(
          extent=[-22, 62; 18, 87], 
          string="phi_rel", 
          style(color=3)), 
        Line(points=[-68, 60; 72, 60], style(color=10)), 
        Line(points=[72, 0; 72, 65], style(color=10)), 
        Polygon(points=[62, 63; 72, 60; 62, 57; 62, 63], style(color=10, 
              fillColor=10)), 
        Polygon(points=[10, -60; -10, -55; -10, -65; 10, -60], style(color=10
              , fillColor=10)), 
        Line(points=[-80, -60; -9, -60], style(color=10, fillColor=10)), 
        Text(
          extent=[14, -53; 82, -66], 
          string="rotation axis", 
          style(color=10))));
  equation 
    w_rel = der(phi_rel);
    tau = d*w_rel;
  end Damper;
  model SpringDamper "Linear 1D rotational spring and damper in parallel" 
    extends Interfaces.Compliant;
    parameter Real c(final unit="N.m/rad", final min=0) "Spring constant";
    parameter SIunits.Angle phi_rel0=0 "Unstretched spring angle";
    parameter Real d(
      final unit="N.m.s/rad", 
      final min=0) = 0 "Damping constant";
    SIunits.AngularVelocity w_rel 
      "Relative angular velocity between flange_b and flange_a";
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.14, 
        y=0.03, 
        width=0.56, 
        height=0.62), 
      Documentation(info="
<HTML>
<p>
A <b>spring</b> and <b>damper</b> element <b>connected in parallel</b>. 
The component can be
connected either between two inertias/gears to describe the shaft elasticity
and damping, or between an inertia/gear and the housing (component Fixed),
to describe a coupling of the element with the housing via a spring/damper.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Icon(
        Line(points=[-80, 40; -60, 40; -45, 10; -15, 70; 15, 10; 45, 70; 60, 
              40; 80, 40], style(color=0)), 
        Text(extent=[-100, 129; 100, 69], string="%name=%c"), 
        Line(points=[-80, 40; -80, -70], style(color=0)), 
        Line(points=[-80, -70; -52, -70], style(color=0)), 
        Rectangle(extent=[-52, -40; 38, -100], style(color=0, fillColor=8)), 
        Line(points=[-52, -40; 68, -40], style(color=0)), 
        Line(points=[-52, -100; 68, -100], style(color=0)), 
        Line(points=[38, -70; 80, -70], style(color=0)), 
        Line(points=[80, 40; 80, -70], style(color=0)), 
        Line(points=[-90, 0; -80, 0], style(color=0)), 
        Line(points=[80, 0; 90, 0], style(color=0)), 
        Text(
          extent=[-101, -147; 98, -107], 
          string="d=%d", 
          style(color=0))), 
      Diagram(
        Line(points=[-80, 32; -58, 32; -43, 2; -13, 62; 17, 2; 47, 62; 62, 32
              ; 80, 32], style(color=0, thickness=2)), 
        Line(points=[-68, 32; -68, 97], style(color=10)), 
        Line(points=[72, 32; 72, 97], style(color=10)), 
        Line(points=[-68, 92; 72, 92], style(color=10)), 
        Polygon(points=[62, 95; 72, 92; 62, 89; 62, 95], style(color=10, 
              fillColor=10)), 
        Text(
          extent=[-20, 72; 20, 97], 
          string="phi_rel", 
          style(color=3)), 
        Rectangle(extent=[-52, -20; 38, -80], style(color=0, fillColor=8)), 
        Line(points=[-52, -80; 68, -80], style(color=0)), 
        Line(points=[-52, -20; 68, -20], style(color=0)), 
        Line(points=[38, -50; 80, -50], style(color=0)), 
        Line(points=[-80, -50; -52, -50], style(color=0)), 
        Line(points=[-80, 32; -80, -50], style(color=0)), 
        Line(points=[80, 32; 80, -50], style(color=0)), 
        Line(points=[-90, 0; -80, 0], style(color=0)), 
        Line(points=[90, 0; 80, 0], style(color=0)), 
        Text(
          extent=[15, -87; 83, -100], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[11, -94; -9, -89; -9, -99; 11, -94], style(color=10, 
              fillColor=10)), 
        Line(points=[-79, -94; -8, -94], style(color=10, fillColor=10))));
  equation 
    w_rel = der(phi_rel);
    tau = c*(phi_rel - phi_rel0) + d*w_rel;
  end SpringDamper;
  model ElastoBacklash 
    "Backlash connected in series to linear spring and damper (backlash is modeled with elasticity)"
     
    extends Interfaces.Compliant;
    parameter SIunits.Angle b(final min=0) = 0 "Total backlash";
    parameter Real c(
      final unit="N.m/rad", 
      final min=Modelica.Constants.SMALL) = 1.e5 
      "Spring constant (c > 0 required)";
    parameter SIunits.Angle phi_rel0=0 "Unstretched spring angle";
    parameter Real d(
      final unit="N.m.s/rad", 
      final min=0) = 0 "Damping constant";
    SIunits.AngularVelocity w_rel 
      "Relative angular velocity between flange_b and flange_a";
  protected 
    SIunits.Angle b2=b/2;
    // A minimum backlash is defined in order to avoid an infinite
    // number of state events if backlash b is set to zero.
    constant SIunits.Angle b_min=1.e-10 "minimum backlash";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.07, 
        y=0.01, 
        width=0.6, 
        height=0.59), 
      Documentation(info="
<HTML>
<p>
This element consists of a <b>backlash</b> element <b>connected in series</b>
to a <b>spring</b> and <b>damper</b> element which are <b>connected in parallel</b>. 
The spring constant shall be non-zero, otherwise the component cannot be used.
</p>

<p>
In combination with components IdealGear, the ElastoBacklash model
can be used to model a gear box with backlash, elasticity and damping.
</p>


<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Icon(
        Text(extent=[-100, 130; 100, 70], string="%name=%c"), 
        Line(points=[-80, 32; -58, 32; -48, 0; -34, 61; -20, 0; -8, 60; 0, 30
              ; 20, 30], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Rectangle(extent=[-60, -20; -10, -80], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0, 
            fillColor=8)), 
        Line(points=[-52, -80; 0, -80], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[-52, -20; 0, -20], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[-10, -50; 20, -50], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[-80, -50; -60, -50], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[-80, 32; -80, -50], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[20, 30; 20, -50], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[-90, 0; -80, 0], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[90, 0; 80, 0], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[20, 0; 60, 0; 60, -30], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[40, -12; 40, -40; 80, -40; 80, 0], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Text(
          extent=[-99, -130; 100, -90], 
          string="b=%b", 
          style(color=0))), 
      Diagram(
        Line(points=[-80, 32; -58, 32; -48, 0; -34, 60; -20, 0; -8, 60; 0, 30
              ; 20, 30], style(color=0, thickness=2)), 
        Line(points=[-68, 32; -68, 97], style(color=10)), 
        Line(points=[80, 0; 80, 96], style(color=10)), 
        Line(points=[-68, 92; 72, 92], style(color=10)), 
        Polygon(points=[70, 95; 80, 92; 70, 89; 70, 95], style(color=10, 
              fillColor=10)), 
        Text(
          extent=[-10, 70; 30, 95], 
          string="phi_rel", 
          style(color=10)), 
        Rectangle(extent=[-60, -20; -10, -80], style(
            color=0, 
            thickness=2, 
            fillColor=8)), 
        Line(points=[-52, -80; 0, -80], style(color=0, thickness=2)), 
        Line(points=[-52, -20; 0, -20], style(color=0, thickness=2)), 
        Line(points=[-10, -50; 20, -50], style(color=0, thickness=2)), 
        Line(points=[-80, -50; -60, -50], style(color=0, thickness=2)), 
        Line(points=[-80, 32; -80, -50], style(color=0, thickness=2)), 
        Line(points=[20, 30; 20, -50], style(color=0, thickness=2)), 
        Line(points=[-90, 0; -80, 0], style(color=0)), 
        Line(points=[90, 0; 80, 0], style(color=0, thickness=2)), 
        Line(points=[20, 0; 60, 0; 60, -30], style(color=0, thickness=2)), 
        Line(points=[40, -12; 40, -40; 80, -40; 80, 0], style(color=0, 
              thickness=2)), 
        Line(points=[30, 0; 30, 64], style(color=10)), 
        Line(points=[30, 60; 80, 60], style(color=10)), 
        Polygon(points=[70, 63; 80, 60; 70, 57; 70, 63], style(color=10, 
              fillColor=10)), 
        Text(
          extent=[39, 60; 68, 46], 
          string="b", 
          style(
            color=9, 
            fillColor=8, 
            fillPattern=1)), 
        Text(
          extent=[15, -89; 83, -102], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[11, -96; -9, -91; -9, -101; 11, -96], style(color=10, 
              fillColor=10)), 
        Line(points=[-79, -96; -8, -96], style(color=10, fillColor=10))));
  equation 
    w_rel = der(phi_rel);
    tau = if b2 > b_min then (if phi_rel > b2 then c*(phi_rel - phi_rel0 - b2)
       + d*w_rel else (if phi_rel < -b2 then c*(phi_rel - phi_rel0 + b2) + d*
      w_rel else 0)) else c*(phi_rel - phi_rel0) + d*w_rel;
  end ElastoBacklash;
  model BearingFriction "Coulomb friction in bearings " 
    extends Interfaces.Rigid;
    
    parameter Real tau_pos[:, :]=[0, 1] 
      "[w,tau] Positive sliding friction characteristic (w>=0)";
    parameter Real peak(final min=1) = 1 
      "peak*tau_pos[1,2] = Maximum friction torque for w==0";
    
    extends Interfaces.FrictionBase;
    
    SIunits.AngularVelocity w 
      "Absolute angular velocity of flange_a and flange_b";
    SIunits.AngularAcceleration a 
      "Absolute angular acceleration of flange_a and flange_b";
    
    annotation (
      Documentation(info="
<HTML>
<p>
This element describes <b>Coulomb friction</b> in <b>bearings</b>,
i.e., a frictional torque acting between a flange and the housing. 
The positive sliding friction torque \"tau\" has to be defined 
by table \"tau_pos\" as function of the absolute angular velocity \"w\".
E.g.
<p>

<pre>
       w | tau
      ---+-----
       0 |   0
       1 |   2
       2 |   5
       3 |   8
</pre>

<p>
gives the following table:
</p>

<pre>
   tau_pos = [0, 0
              1, 2
              2, 5
              3, 8];
</pre>

<p>
Currently, only linear interpolation in the table is supported.
Outside of the table, extrapolation through the last
two table entries is used. It is assumed that the negative
sliding friction force has the same characteristic with negative
values. Friction is modelled in the following way:
</p>

<p>
When the absolute angular velocity \"w\" is not zero, the friction torque 
is a function of w and of a constant normal force. This dependency
is defined via table tau_pos and can be determined by measurements,
e.g. by driving the gear with constant velocity and measuring the
needed motor torque (= friction torque).
</p>

<p>
When the absolute angular velocity becomes zero, the elements
connected by the friction element become stuck, i.e., the absolute
angle remains constant. In this phase the friction torque is 
calculated from a torque balance due to the requirement, that 
the absolute acceleration shall be zero.  The elements begin 
to slide when the friction torque exceeds a threshold value, 
called the maximum static friction torque, computed via:
</p>

<pre>
   maximum_static_friction = <b>peak</b> * sliding_friction(w=0)  (<b>peak</b> >= 1)
</pre>

<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled which have to be solved by appropriate
numerical methods. The method is described in:
</p>

<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):
<dd><b>Hybrid Modeling in Modelica based on the Synchronous 
    Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.
</dl>

<p>
More precise friction models take into account the elasticity of the
material when the two elements are \"stuck\", as well as other effects,
like hysteresis. This has the advantage that the friction element can
be completely described by a differential equation without events. The
drawback is that the system becomes stiff (about 10-20 times slower
simulation) and that more material constants have to be supplied which
requires more sophisticated identification. For more details, see the
following references, especially (Armstrong and Canudas de Witt 1996):
</p>

<dl>
<dt>Armstrong B. (1991):
<dd><b>Control of Machines with Friction</b>. Kluwer Academic
    Press, Boston MA.<br><br>

<dt>Armstrong B., and Canudas de Wit C. (1996):
<dd><b>Friction Modeling and Compensation.</b>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br><br>

<dt>Canudas de Wit C., Olsson H., Astroem K.J., and Lischinsky P. (1995):
<dd><b>A new model for control of systems with friction.</b>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<br><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.25, 
        y=0.01, 
        width=0.73, 
        height=0.92), 
      Icon(
        Rectangle(extent=[-90, 10; 90, -10], style(
            color=0, 
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-60, -10; 60, -60], style(color=0)), 
        Rectangle(extent=[-60, -10; 60, -25], style(
            color=0, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-60, -45; 60, -61], style(
            color=0, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-50, -18; 50, -50], style(
            color=0, 
            fillColor=7, 
            fillPattern=1)), 
        Polygon(points=[60, -60; 60, -70; 75, -70; 75, -80; -75, -80; -75, -70
              ; -60, -70; -60, -60; 60, -60], style(
            color=0, 
            fillColor=9, 
            fillPattern=1)), 
        Line(points=[-75, -10; -75, -70], style(color=0)), 
        Line(points=[75, -10; 75, -70], style(color=0)), 
        Rectangle(extent=[-60, 60; 60, 10], style(color=0)), 
        Rectangle(extent=[-60, 60; 60, 45], style(
            color=0, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-60, 25; 60, 10], style(
            color=0, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-50, 51; 50, 19], style(
            color=0, 
            fillColor=7, 
            fillPattern=1)), 
        Line(points=[-75, 70; -75, 10], style(color=0)), 
        Polygon(points=[60, 60; 60, 70; 75, 70; 75, 80; -75, 80; -75, 70; -60
              , 70; -60, 60; 60, 60], style(
            color=0, 
            fillColor=9, 
            fillPattern=1)), 
        Line(points=[75, 70; 75, 10], style(color=0)), 
        Text(extent=[-101, 130; 100, 91], string="%name")), 
      Diagram(
        Rectangle(extent=[-90, 10; 90, -10], style(
            color=0, 
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-60, -10; 60, -60], style(color=0)), 
        Rectangle(extent=[-60, -10; 60, -25], style(
            color=0, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-60, -45; 60, -61], style(
            color=0, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-50, -18; 50, -50], style(
            color=0, 
            fillColor=7, 
            fillPattern=1)), 
        Polygon(points=[60, -60; 60, -70; 75, -70; 75, -80; -75, -80; -75, -70
              ; -60, -70; -60, -60; 60, -60], style(
            color=0, 
            fillColor=9, 
            fillPattern=1)), 
        Line(points=[-75, -10; -75, -70], style(color=0)), 
        Line(points=[75, -10; 75, -70], style(color=0)), 
        Rectangle(extent=[-60, 60; 60, 10], style(color=0)), 
        Rectangle(extent=[-60, 60; 60, 45], style(
            color=0, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-60, 25; 60, 10], style(
            color=0, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-50, 51; 50, 19], style(
            color=0, 
            fillColor=7, 
            fillPattern=1)), 
        Line(points=[-75, 70; -75, 10], style(color=0)), 
        Polygon(points=[60, 60; 60, 70; 75, 70; 75, 80; -75, 80; -75, 70; -60
              , 70; -60, 60; 60, 60], style(
            color=0, 
            fillColor=9, 
            fillPattern=1)), 
        Line(points=[75, 70; 75, 10], style(color=0)), 
        Line(points=[-20, -24; 38, -24], style(color=1, thickness=4)), 
        Polygon(points=[-20, -19; -20, -29; -36, -24; -20, -19], style(
            color=1, 
            fillColor=1, 
            fillPattern=1)), 
        Text(
          extent=[-45, -23; 49, -51], 
          string="tau (friction torque)", 
          style(color=1)), 
        Text(
          extent=[19, -90; 87, -103], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[15, -97; -5, -92; -5, -102; 15, -97], style(color=10, 
              fillColor=10)), 
        Line(points=[-75, -97; -4, -97], style(color=10, fillColor=10))));
  equation 
    // Constant auxiliary variables
    tau0 = Math.tempInterpol1(0, tau_pos, 2);
    tau0_max = peak*tau0;
    free = false;
    
    // Angular velocity and angular acceleration of flanges
    w = der(phi);
    a = der(w);
    w_relfric = w;
    a_relfric = a;
    
    // Equilibrium of torques
    0 = flange_a.tau + flange_b.tau - tau;
    
    // Friction torque
    tau = if locked then sa else (if startForward then Math.tempInterpol1(w, 
      tau_pos, 2) else if startBackward then -Math.tempInterpol1(-w, tau_pos, 2
      ) else if pre(mode) == Forward then Math.tempInterpol1(w, tau_pos, 2)
       else -Math.tempInterpol1(-w, tau_pos, 2));
  end BearingFriction;
  model Clutch "Clutch based on Coulomb friction " 
    extends Interfaces.Compliant;
    
    parameter Real mue_pos[:, :]=[0, 0.5] 
      "[w,mue] positive sliding friction coefficient (w_rel>=0)";
    parameter Real peak(final min=1) = 1 
      "peak*mue_pos[1,2] = maximum value of mue for w_rel==0";
    parameter Real cgeo(final min=0) = 1 
      "Geometry constant containing friction distribution assumption";
    parameter SIunits.Force fn_max(final min=0) = 1 "Maximum normal force";
    
    extends Interfaces.FrictionBase;
    
    SIunits.AngularVelocity w_rel 
      "Relative angular velocity (flange_b.w - flange_a.w)";
    SIunits.AngularAcceleration a_rel 
      "Relative angular acceleration (flange_b.a - flange_a.a)";
    
    Real mue0 "Friction coefficient for w=0 and forward sliding";
    SIunits.Force fn "Normal force (fn=fn_max*inPort.signal)";
    Modelica.Blocks.Interfaces.InPort inPort(final n=1) 
      "Normalized force signal (= normal_force/fn_max; clutch is engaged if > 0)"
       annotation (extent=[-20, 130; 20, 90], rotation=90);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.05, 
        y=0.01, 
        width=0.76, 
        height=0.62), 
      Icon(
        Polygon(points=[-30, 40; -60, 50; -60, 30; -30, 40], style(fillColor=3
              , fillPattern=1)), 
        Line(points=[0, 90; -90, 70; -90, 40; -30, 40], style(
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[0, 90; 90, 70; 90, 40; 30, 40]), 
        Polygon(points=[30, 40; 60, 50; 60, 30; 30, 40], style(fillColor=3, 
              fillPattern=1)), 
        Rectangle(extent=[10, 60; 30, -60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-30, 60; -10, -60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[30, 10; 90, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-90, 10; -30, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Text(extent=[-100, -120; 100, -60], string="%name")), 
      Documentation(info="
<HTML>
<p>
This component models a <b>clutch</b>, i.e., a component with
two flanges where friction is present between the two flanges
and these flanges are pressed together via a normal force.
The normal force fn has to be provided as input signal u in a normalized form,
fn = fn_max*u, where fn_max has to be provided as parameter. Friction in the
clutch is modelled in the following way:
</p>

<p>
When the relative angular velocity is not zero, the friction torque is a
function of the velocity dependent friction coefficient  mue(w_rel) , of
the normal force \"fn\", and of a geometry constant \"cgeo\" which takes into
account the geometry of the device and the assumptions on the friction
distributions:
</p>

<pre>
        frictional_torque = <b>cgeo</b> * <b>mue</b>(w_rel) * <b>fn</b>
</pre>

<p>
   Typical values of coefficients of friction:
</p>

<pre>
      dry operation   :  <b>mue</b> = 0.2 .. 0.4
      operating in oil:  <b>mue</b> = 0.05 .. 0.1
</pre>

<p>
   When plates are pressed together, where  <b>ri</b>  is the inner radius,  
   <b>ro</b> is the outer radius and <b>N</b> is the number of friction interfaces,
   the geometry constant is calculated in the following way under the
   assumption of a uniform rate of wear at the interfaces:
</p>

<pre>
         <b>cgeo</b> = <b>N</b>*(<b>r0</b> + <b>ri</b>)/2

</pre>

<p>
    The positive part of the friction characteristic <b>mue</b>(w_rel),
    w_rel >= 0, is defined via table mue_pos (first column = w_rel,
    second column = mue). Currently, only linear interpolation in
    the table is supported.
</p>

<p>
   When the relative angular velocity becomes zero, the elements
   connected by the friction element become stuck, i.e., the relative
   angle remains constant. In this phase the friction torque is 
   calculated from a torque balance due to the requirement, that 
   the relative acceleration shall be zero.  The elements begin 
   to slide when the friction torque exceeds a threshold value, 
   called the  maximum static friction torque, computed via:
</p>

<pre>
       frictional_torque = <b>peak</b> * <b>cgeo</b> * <b>mue</b>(w_rel=0) * <b>fn</b>   (<b>peak</b> >= 1)
</pre>

<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled. The method is described in:
</p>

<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):
<dd><b>Hybrid Modeling in Modelica based on the Synchronous 
    Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.
</dl>

<p>
More precise friction models take into account the elasticity of the
material when the two elements are \"stuck\", as well as other effects,
like hysteresis. This has the advantage that the friction element can
be completely described by a differential equation without events. The
drawback is that the system becomes stiff (about 10-20 times slower
simulation) and that more material constants have to be supplied which
requires more sophisticated identification. For more details, see the
following references, especially (Armstrong and Canudas de Witt 1996):
</p>

<dl>
<dt>Armstrong B. (1991):
<dd><b>Control of Machines with Friction</b>. Kluwer Academic
    Press, Boston MA.<br><br>

<dt>Armstrong B., and Canudas de Wit C. (1996):
<dd><b>Friction Modeling and Compensation.</b>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br><br>

<dt>Canudas de Wit C., Olsson H., Astroem K.J., and Lischinsky P. (1995):
<dd><b>A new model for control of systems with friction.</b>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<br><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized first version.
</li>
</ul>

</HTML>
"), 
      Diagram(
        Polygon(points=[-30, 40; -60, 50; -60, 30; -30, 40], style(fillColor=3
              , fillPattern=1)), 
        Line(points=[0, 90; -90, 70; -90, 40; -30, 40], style(
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[0, 90; 90, 70; 90, 40; 30, 40]), 
        Polygon(points=[30, 40; 60, 50; 60, 30; 30, 40], style(fillColor=3, 
              fillPattern=1)), 
        Rectangle(extent=[10, 60; 30, -60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-30, 60; -10, -60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[30, 10; 90, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-90, 10; -30, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Text(
          extent=[19, -90; 87, -103], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[15, -97; -5, -92; -5, -102; 15, -97], style(color=10, 
              fillColor=10)), 
        Line(points=[-75, -97; -4, -97], style(color=10, fillColor=10))));
  equation 
    // Constant auxiliary variable
    mue0 = Math.tempInterpol1(0, mue_pos, 2);
    
    // Relative quantities
    w_rel = der(phi_rel);
    a_rel = der(w_rel);
    w_relfric = w_rel;
    a_relfric = a_rel;
    
    // Normal force and friction torque for w_rel=0
    fn = fn_max*inPort.signal[1];
    free = fn <= 0;
    tau0 = mue0*cgeo*fn;
    tau0_max = peak*tau0;
    
    // friction torque    
    tau = if locked then sa else if free then 0 else cgeo*fn*(if startForward
       then Math.tempInterpol1(w_rel, mue_pos, 2) else if startBackward then -
      Math.tempInterpol1(-w_rel, mue_pos, 2) else if pre(mode) == Forward then 
      Math.tempInterpol1(w_rel, mue_pos, 2) else -Math.tempInterpol1(-w_rel, 
      mue_pos, 2));
  end Clutch;
  model OneWayClutch "Series connection of freewheel and clutch" 
    extends Interfaces.Compliant;
    
    parameter Real mue_pos[:, :]=[0, 0.5] 
      "[w,mue] positive sliding friction coefficient (w_rel>=0)";
    parameter Real peak(final min=1) = 1 
      "peak*mue_pos[1,2] = maximum value of mue for w_rel==0";
    parameter Real cgeo(final min=0) = 1 
      "Geometry constant containing friction distribution assumption";
    parameter SIunits.Force fn_max(final min=0) = 1 "Maximum normal force";
    parameter SIunits.AngularVelocity w_small(min=Modelica.Constants.EPS) = 1 
      "Relative angular velocity near to zero (see model info text)";
    
    SIunits.AngularVelocity w_rel 
      "Relative angular velocity (flange_b.w - flange_a.w)";
    SIunits.AngularAcceleration a_rel 
      "Relative angular acceleration (flange_b.a - flange_a.a)";
    Real u "normalized force input signal (0..1)";
    SIunits.Force fn "Normal force (fn=fn_max*inPort.signal)";
    
    Boolean startForward 
      "true, if w_rel=0 and start of forward sliding or w_rel > w_small";
    Boolean locked "true, if w_rel=0 and not sliding";
    Boolean stuck(final start=false) "w_rel=0 (forward sliding or locked)";
    
  protected 
    SIunits.Torque tau0 "Friction torque for w=0 and sliding";
    SIunits.Torque tau0_max "Maximum friction torque for w=0 and locked";
    Real mue0 "Friction coefficient for w=0 and sliding";
    Boolean free "true, if frictional element is not active";
    Real sa "path parameter of tau = f(a_rel) Friction characteristic";
    constant Real eps0=1.0e-4 "Relative hysteresis epsilon";
    SIunits.Torque tau0_max_low "lowest value for tau0_max";
    parameter Real peak2=max([peak, 1 + eps0]);
  public 
    Modelica.Blocks.Interfaces.InPort inPort(final n=1) annotation (extent=[-
          20, 130; 20, 90], rotation=90);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.01, 
        y=0, 
        width=0.7, 
        height=0.92), 
      Icon(
        Polygon(points=[-30, 40; -60, 50; -60, 30; -30, 40], style(fillColor=3
              , fillPattern=1)), 
        Line(points=[0, 90; -90, 70; -90, 40; -30, 40], style(
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[0, 90; 90, 70; 90, 40; 30, 40]), 
        Polygon(points=[30, 40; 60, 50; 60, 30; 30, 40], style(fillColor=3, 
              fillPattern=1)), 
        Rectangle(extent=[10, 60; 30, -60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-30, 60; -10, -60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[30, 10; 90, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-90, 10; -30, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Text(extent=[-100, -120; 100, -60], string="%name"), 
        Polygon(points=[-10, 30; 50, 0; -10, -30; -10, 30], style(
            color=1, 
            fillColor=1, 
            fillPattern=1))), 
      Documentation(info="
<HTML>
<p>
This component models a <b>one-way clutch</b>, i.e., a component with
two flanges where friction is present between the two flanges
and these flanges are pressed together via a normal force. These
flanges maybe sliding with respect to each other 

Parallel connection of ClutchCombi and of FreeWheel.
                     The element is introduced to resolve the ambiguity
                     of the constraint torques of the elements.

<p>
A one-way-clutch is an element where a clutch is connected in parallel
to a free wheel. This special element is provided, because such
a parallel connection introduces an ambiguity into the model
(the constraint torques are not uniquely defined when both
elements are stuck) and this element resolves it by introducing 
<b>one</b> constraint torque and not two.
</p>

<p>
Note, initial values have to be chosen for the model, such that the
relative speed of the one-way-clutch >= 0. Otherwise, the configuration
is physically not possible and an error occurs.
</p>

<p>
The normal force fn has to be provided as input signal u in a normalized form,
fn = fn_max*u, where fn_max has to be provided as parameter. Friction in the
clutch is modelled in the following way:
</p>

<p>
When the relative angular velocity is positive, the friction torque is a
function of the velocity dependent friction coefficient  mue(w_rel) , of
the normal force \"fn\", and of a geometry constant \"cgeo\" which takes into
account the geometry of the device and the assumptions on the friction
distributions:
</p>

<pre>
        frictional_torque = <b>cgeo</b> * <b>mue</b>(w_rel) * <b>fn</b>
</pre>

<p>
   Typical values of coefficients of friction:
</p>

<pre>
      dry operation   :  <b>mue</b> = 0.2 .. 0.4
      operating in oil:  <b>mue</b> = 0.05 .. 0.1
</pre>

<p>
   When plates are pressed together, where  <b>ri</b>  is the inner radius,  
   <b>ro</b> is the outer radius and <b>N</b> is the number of friction interfaces,
   the geometry constant is calculated in the following way under the
   assumption of a uniform rate of wear at the interfaces:
</p>

<pre>
         <b>cgeo</b> = <b>N</b>*(<b>r0</b> + <b>ri</b>)/2

</pre>

<p>
    The positive part of the friction characteristic <b>mue</b>(w_rel),
    w_rel >= 0, is defined via table mue_pos (first column = w_rel,
    second column = mue). Currently, only linear interpolation in
    the table is supported.
</p>

<p>
   When the relative angular velocity becomes zero, the elements
   connected by the friction element become stuck, i.e., the relative
   angle remains constant. In this phase the friction torque is 
   calculated from a torque balance due to the requirement, that 
   the relative acceleration shall be zero.  The elements begin 
   to slide when the friction torque exceeds a threshold value, 
   called the  maximum static friction torque, computed via:
</p>

<pre>
       frictional_torque = <b>peak</b> * <b>cgeo</b> * <b>mue</b>(w_rel=0) * <b>fn</b>   (<b>peak</b> >= 1)
</pre>

<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled. The method is described in:
</p>

<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):
<dd><b>Hybrid Modeling in Modelica based on the Synchronous 
    Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.
</dl>


<p><b>Release Notes:</b></p>
<ul>
<li><i>Version 0.9 (Nov. 26, 1999)</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

<p><b>Copyright (C) 1999, DLR.</b></p>
</HTML>
"));
  equation 
    // Constant auxiliary variable
    mue0 = Math.tempInterpol1(0, mue_pos, 2);
    tau0_max_low = eps0*mue0*cgeo*fn_max;
    
    // Relative quantities
    w_rel = der(phi_rel);
    a_rel = der(w_rel);
    
    // Normal force and friction torque for w_rel=0
    u = inPort.signal[1];
    free = u <= 0;
    fn = if free then 0 else fn_max*u;
    tau0 = mue0*cgeo*fn;
    tau0_max = if free then tau0_max_low else peak2*tau0;
    
    /* Friction characteristic
       (locked is introduced to help the Modelica translator determining
       the different structural configurations, if for each configuration
       special code shall be generated)
    */
    startForward = pre(stuck) and (sa > tau0_max or pre(startForward) and sa
       > tau0 or w_rel > w_small) or initial() and noEvent(w_rel > 0);
    locked = pre(stuck) and not startForward;
    
    // acceleration and friction torque    
    a_rel = if locked then 0 else sa - tau0;
    tau = if locked then sa else (if free then 0 else cgeo*fn*
      Math.tempInterpol1(w_rel, mue_pos, 2));
    
    // Determine configuration
    stuck = locked or w_rel <= 0;
  end OneWayClutch;
  model Brake "Brake based on Coulomb friction " 
    extends Interfaces.Rigid;
    
    parameter Real mue_pos[:, :]=[0, 0.5] 
      "[w,mue] positive sliding friction coefficient (w_rel>=0)";
    parameter Real peak(final min=1) = 1 
      "peak*mue_pos[1,2] = maximum value of mue for w_rel==0";
    parameter Real cgeo(final min=0) = 1 
      "Geometry constant containing friction distribution assumption";
    parameter SIunits.Force fn_max(final min=0) = 1 "Maximum normal force";
    
    extends Interfaces.FrictionBase;
    
    SIunits.AngularVelocity w 
      "Absolute angular velocity of flange_a and flange_b";
    SIunits.AngularAcceleration a 
      "Absolute angular acceleration of flange_a and flange_b";
    
    Real mue0 "Friction coefficient for w=0 and forward sliding";
    SIunits.Force fn "Normal force (=fn_max*inPort.signal)";
    
    // Constant auxiliary variable
    Modelica.Blocks.Interfaces.InPort inPort(final n=1) 
      "Normalized force signal (= normal_force/fn_max; brake is active if > 0)"
       annotation (extent=[-20, 130; 20, 90], rotation=90);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.05, 
        y=0.01, 
        width=0.74, 
        height=0.71), 
      Icon(
        Rectangle(extent=[-90, 10; -18, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-18, 60; 20, -60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[20, 10; 90, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Polygon(points=[40, 40; 70, 50; 70, 30; 40, 40], style(fillColor=3, 
              fillPattern=1)), 
        Rectangle(extent=[30, 54; 40, 25], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Polygon(points=[-40, 40; -70, 50; -70, 30; -40, 40], style(fillColor=3
              , fillPattern=1)), 
        Rectangle(extent=[-40, 55; -30, 25], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Line(points=[0, 90; 90, 70; 90, 40; 70, 40]), 
        Line(points=[0, 90; -90, 70; -90, 40; -70, 40], style(
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Text(extent=[-100, -120; 100, -60], string="%name")), 
      Documentation(info="
<HTML>
<p>
This component models a <b>brake</b>, i.e., a component where a frictional
torque is acting between the housing and a flange and a controlled normal
force presses the flange to the housing in order to increase friction.
The normal force fn has to be provided as input signal u in a normalized
form, fn = fn_max*u, where fn_max has to be provided as parameter. 
Friction in the brake is modelled in the following way:
</p>

<p>
When the absolute angular velocity \"w\" is not zero, the friction torque 
is a function of the velocity dependent friction coefficient  mue(w) , of
the normal force \"fn\", and of a geometry constant \"cgeo\" which takes into
account the geometry of the device and the assumptions on the friction
distributions:
</p>

<pre>
        frictional_torque = <b>cgeo</b> * <b>mue</b>(w) * <b>fn</b>
</pre>

<p>
   Typical values of coefficients of friction:
</p>

<pre>
      dry operation   :  <b>mue</b> = 0.2 .. 0.4
      operating in oil:  <b>mue</b> = 0.05 .. 0.1
</pre>

<p>
   When plates are pressed together, where  <b>ri</b>  is the inner radius,  
   <b>ro</b> is the outer radius and <b>N</b> is the number of friction interfaces,
   the geometry constant is calculated in the following way under the
   assumption of a uniform rate of wear at the interfaces:
</p>

<pre>
         <b>cgeo</b> = <b>N</b>*(<b>r0</b> + <b>ri</b>)/2

</pre>

<p>
    The positive part of the friction characteristic <b>mue</b>(w),
    w >= 0, is defined via table mue_pos (first column = w,
    second column = mue). Currently, only linear interpolation in
    the table is supported.
</p>

<p>
   When the absolute angular velocity becomes zero, the elements
   connected by the friction element become stuck, i.e., the absolute
   angle remains constant. In this phase the friction torque is 
   calculated from a torque balance due to the requirement, that 
   the absolute acceleration shall be zero.  The elements begin 
   to slide when the friction torque exceeds a threshold value, 
   called the  maximum static friction torque, computed via:
</p>

<pre>
       frictional_torque = <b>peak</b> * <b>cgeo</b> * <b>mue</b>(w=0) * <b>fn</b>   (<b>peak</b> >= 1)
</pre>

<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled. The method is described in:
</p>

<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):
<dd><b>Hybrid Modeling in Modelica based on the Synchronous 
    Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.
</dl>

<p>
More precise friction models take into account the elasticity of the
material when the two elements are \"stuck\", as well as other effects,
like hysteresis. This has the advantage that the friction element can
be completely described by a differential equation without events. The
drawback is that the system becomes stiff (about 10-20 times slower
simulation) and that more material constants have to be supplied which
requires more sophisticated identification. For more details, see the
following references, especially (Armstrong and Canudas de Witt 1996):
</p>

<dl>
<dt>Armstrong B. (1991):
<dd><b>Control of Machines with Friction</b>. Kluwer Academic
    Press, Boston MA.<br><br>

<dt>Armstrong B., and Canudas de Wit C. (1996):
<dd><b>Friction Modeling and Compensation.</b>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br><br>

<dt>Canudas de Wit C., Olsson H., Astroem K.J., and Lischinsky P. (1995):
<dd><b>A new model for control of systems with friction.</b>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<br><br>
</dl>
<br>


<p><b>Release Notes:</b></p>
<ul>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized first version.
</li>
</ul>

</HTML>
"), 
      Diagram(
        Text(
          extent=[14, -73; 82, -86], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[10, -80; -10, -75; -10, -85; 10, -80], style(color=10
              , fillColor=10)), 
        Line(points=[-80, -80; -9, -80], style(color=10, fillColor=10)), 
        Rectangle(extent=[-90, 10; -18, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-18, 60; 20, -60], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[20, 10; 90, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Polygon(points=[40, 40; 70, 50; 70, 30; 40, 40], style(fillColor=3, 
              fillPattern=1)), 
        Rectangle(extent=[30, 54; 40, 25], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Polygon(points=[-40, 40; -70, 50; -70, 30; -40, 40], style(fillColor=3
              , fillPattern=1)), 
        Rectangle(extent=[-40, 55; -30, 25], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Line(points=[0, 90; 90, 70; 90, 40; 70, 40]), 
        Line(points=[0, 90; -90, 70; -90, 40; -70, 40], style(
            pattern=1, 
            thickness=1, 
            arrow=0))));
  equation 
    mue0 = Math.tempInterpol1(0, mue_pos, 2);
    
    
      // Angular velocity and angular acceleration of flanges flange_a and flange_b
    w = der(phi);
    a = der(w);
    w_relfric = w;
    a_relfric = a;
    
    // Torque equilibrium, normal force and friction torque for w_rel=0
    0 = flange_a.tau + flange_b.tau - tau;
    fn = fn_max*inPort.signal[1];
    tau0 = mue0*cgeo*fn;
    tau0_max = peak*tau0;
    free = fn <= 0;
    
    // friction torque    
    tau = if locked then sa else if free then 0 else cgeo*fn*(if startForward
       then Math.tempInterpol1(w, mue_pos, 2) else if startBackward then -
      Math.tempInterpol1(-w, mue_pos, 2) else if pre(mode) == Forward then 
      Math.tempInterpol1(w, mue_pos, 2) else -Math.tempInterpol1(-w, mue_pos, 2
      ));
  end Brake;
  model GearEfficiency "Efficiency of a gearbox" 
    extends Interfaces.Rigid;
    
    parameter Real eta(
      min=Modelica.Constants.SMALL, 
      max=1) = 1 "Efficiency";
    SIunits.Power power_a "Energy flowing into flange_a (= power)";
    Boolean driving_a 
      "True, if energy is flowing INTO and not out of flange flange_a";
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.23, 
        y=0.06, 
        width=0.69, 
        height=0.62), 
      Icon(
        Text(extent=[-100, 120; 98, 60], string="%name=%eta"), 
        Rectangle(extent=[-90, 20; 90, -20], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Line(points=[-60, -40; 0, -40], style(color=0)), 
        Line(points=[-30, 60; -30, 40], style(color=0)), 
        Line(points=[-59, 40; 0, 40], style(color=0)), 
        Line(points=[-30, -40; -30, -80], style(color=0)), 
        Polygon(points=[-60, -20; 30, -20; 30, -80; 40, -80; 20, -100; 0, -80
              ; 10, -80; 10, -30; -60, -30; -60, -20; -60, -20], style(
            color=1, 
            gradient=0, 
            fillColor=1, 
            fillPattern=1))), 
      Documentation(info="
<HTML>
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

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Diagram(
        Rectangle(extent=[-90, 20; 90, -20], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Line(points=[-60, -40; 0, -40], style(color=0)), 
        Line(points=[-30, 60; -30, 40], style(color=0)), 
        Line(points=[-59, 40; 0, 40], style(color=0)), 
        Line(points=[-30, -40; -30, -80], style(color=0)), 
        Polygon(points=[-60, -20; 30, -20; 30, -80; 40, -80; 20, -100; 0, -80
              ; 10, -80; 10, -30; -60, -30; -60, -20; -60, -20], style(
            color=1, 
            gradient=0, 
            fillColor=1, 
            fillPattern=1)), 
        Text(
          extent=[16, 83; 84, 70], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[12, 76; -8, 81; -8, 71; 12, 76], style(color=10, 
              fillColor=10)), 
        Line(points=[-78, 76; -7, 76], style(color=10, fillColor=10))));
  equation 
    power_a = flange_a.tau*der(phi);
    driving_a = power_a >= 0;
    flange_b.tau = -(if driving_a then eta*flange_a.tau else flange_a.tau/eta)
      ;
  end GearEfficiency;
  model Gear "Realistic model of a gearbox" 
    extends Interfaces.TwoFlanges;
    
    parameter Real ratio=1 "transmission ratio (flange_a.phi/flange_b.phi)";
    parameter Real eta(
      min=Modelica.Constants.SMALL, 
      max=1) = 1 "Gear efficiency";
    parameter Real friction_pos[:, :]=[0, 1] 
      "[w,tau] positive sliding friction characteristic (w>=0)";
    parameter Real peak(final min=1) = 1 
      "peak*friction_pos[1,1] = maximum friction torque at zero velocity";
    parameter Real c(
      final unit="N.m/rad", 
      final min=Modelica.Constants.SMALL) = 1.e5 
      "Gear elasticity (spring constant)";
    parameter Real d(
      final unit="N.m.s/rad", 
      final min=0) = 0 "(relative) gear damping";
    parameter SIunits.Angle b(final min=0) = 0 "Total backlash";
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.15, 
        y=0.07, 
        width=0.6, 
        height=0.55), 
      Documentation(info="
<HTML>
<p>
This component models the essential effects of a gearbox, in particular
gear <b>efficiency</b> due to friction between the teeth, <b>bearing friction</b>,
gear <b>elasticity</b> and <b>damping</b>, <b>backlash</b>.
The inertia of the gear wheels is not modeled. If necessary, inertia
has to be taken into account by connecting components of model Inertia
to the left and/or the right flange.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>July 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

</HTML>
"), 
      Icon(
        Rectangle(extent=[-90, 10; -60, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[60, 10; 90, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Rectangle(extent=[-40, 60; 40, -60], style(
            color=3, 
            pattern=1, 
            thickness=1, 
            gradient=2, 
            arrow=0, 
            fillColor=8, 
            fillPattern=1)), 
        Polygon(points=[-60, 10; -60, 20; -40, 40; -40, -40; -60, -20; -60, 10
              ], style(
            color=10, 
            gradient=2, 
            fillColor=10, 
            fillPattern=1)), 
        Polygon(points=[60, 20; 40, 40; 40, -40; 60, -20; 60, 20], style(
            color=10, 
            fillColor=10, 
            fillPattern=1)), 
        Polygon(points=[-60, -90; -50, -90; -20, -30; 20, -30; 48, -90; 60, 
              -90; 60, -100; -60, -100; -60, -90], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Text(extent=[-100, 128; 100, 68], string="%name=%ratio"), 
        Text(
          extent=[-100, -152; 99, -112], 
          string="c=%c", 
          style(color=0))), 
      Diagram(
        Text(
          extent=[2, 29; 46, 22], 
          string="rotation axis", 
          style(color=10)), 
        Polygon(points=[4, 25; -4, 27; -4, 23; 4, 25], style(color=10, 
              fillColor=10)), 
        Line(points=[-36, 25; -3, 25], style(color=10, fillColor=10))));
    Modelica.Mechanics.Rotational.IdealGear gearRatio(final ratio=ratio) 
      annotation (extent=[-80, -10; -60, 10]);
    Modelica.Mechanics.Rotational.GearEfficiency gearEfficiency(final eta=eta)
       annotation (extent=[-34, -10; -14, 10]);
    Modelica.Mechanics.Rotational.BearingFriction bearingFriction(final 
        tau_pos=friction_pos, final peak=peak) annotation (extent=[6, 10; 26, 
          -10]);
    Modelica.Mechanics.Rotational.ElastoBacklash elastoBacklash(
      final b=b, 
      final c=c, 
      final phi_rel0=0, 
      final d=d) annotation (extent=[50, -10; 70, 10]);
  equation 
    connect(gearRatio.flange_b, gearEfficiency.flange_a) annotation (points=
          [-60, 0; -34, 0]);
  equation 
    connect(gearEfficiency.flange_b, bearingFriction.flange_a) annotation (
        points=[-14, 0; 6, 0]);
  equation 
    connect(bearingFriction.flange_b, elastoBacklash.flange_a) annotation (
        points=[26, 0; 50, 0]);
  equation 
    connect(elastoBacklash.flange_b, flange_b) annotation (points=[70, 0; 
          100, 0]);
  equation 
    connect(gearRatio.flange_a, flange_a) annotation (points=[-80, 0; -100, 
          0]);
  end Gear;
end Rotational;

