package Translational "1-dimensional translational mechanical components" 
  
  import SI = Modelica.SIunits;
  
  extends Modelica.Icons.Library2;
  
  annotation(
    Window(
      x=0.05,
      y=0.09,
      width=0.39,
      height=0.47,
      library=1,
      autolayout=1),
    Icon(
      Line(points=[-84, -73; 66, -73], style(color=0)),
      Rectangle(extent=[-81, -22; -8, -65], style(
          color=0,
          gradient=3,
          fillColor=8,
          fillPattern=1)),
      Line(points=[-8, -43; -1, -43; 6, -64; 17, -23; 29, -65; 40, -23; 50, -44;
              61, -44], style(color=0)),
      Line(points=[-59, -73; -84, -93], style(color=0)),
      Line(points=[-11, -73; -36, -93], style(color=0)),
      Line(points=[-34, -73; -59, -93], style(color=0)),
      Line(points=[14, -73; -11, -93], style(color=0)),
      Line(points=[39, -73; 14, -93], style(color=0)),
      Line(points=[63, -73; 38, -93], style(color=0))), Documentation(info="<html>
<p>
This package contains components to model <i>1-dimensional translational
mechanical</i> systems.
</p>

<p>
The <i>filled</i> and <i>non-filled green squares</i> at the left and
right side of a component represent <i>mechanical flanges</i>.
Drawing a line between such squares means that the corresponding
flanges are <i>rigidly attached</i> to each other. The components of this
library can be usually connected together in an arbitrary way. E.g. it is
possible to connect two springs or two sliding masses with inertia directly
together.

<p> The only <i>connection restriction</i> is that the Coulomb friction
elements (Stop) should be only connected
together provided a compliant element, such as a spring, is in between.
The reason is that otherwise the frictional force is not uniquely
defined if the elements are stuck at the same time instant (i.e., there
does not exist a unique solution) and some simulation systems may not be
able to handle this situation, since this leads to a singularity during
simulation. It can only be resolved in a \"clean way\" by combining the
two connected friction elements into
one component and resolving the ambiguity of the frictional force in the
stuck mode.
</p>

<p> Another restriction arises if the hard stops in model Stop are used, i. e.
the movement of the mass is limited by a stop at smax or smin.
<font color=\"#ff0000\"> <b>This requires the states Stop.s and Stop.v</b> </font>. If these states are eliminated during the index reduction
the model will not work. To avoid this any inertias should be connected via springs
to the Stop element, other sliding masses, dampers or hydraulic chambers must be avoided. </p>


<p>
In the <i>icon</i> of every component an <i>arrow</i> is displayed in grey
color. This arrow characterizes the coordinate system in which the vectors
of the component are resolved. It is directed into the positive
translational direction (in the mathematical sense).
In the flanges of a component, a coordinate system is rigidly attached
to the flange. It is called <i>flange frame</i> and is directed in parallel
to the component coordinate system. As a result, e.g., the positive
cut-force of a \"left\" flange (flange_a) is directed into the flange, whereas
the positive cut-force of a \"right\" flange (flange_b) is directed out of the
flange. A flange is described by a Modelica connector containing
the following variables:
</p>

<pre>
   SIunits.Position s  \"absolute position of flange\";
   <i>flow</i> Force f        \"cut-force in the flange\";
</pre>

<p>
This package contains the following model components:
</p>

<pre>
   <i>Interfaces</i>       Sublibrary containing interface definitions.
   <i>Examples</i>         Examples of library usage.

   <i>SlidingMass</i>      Translational component with inertia.
   <i>Stop</i>             Sliding mass with Coulomb friction and hard stops.
   <i>Rod</i>              Massless rod.
   <i>Spring</i>           Linear spring.
   <i>Damper</i>           Linear damper.
   <i>SpringDamper</i>     Linear spring and linear damper in parallel connection.
   <i>ElastoGap</i>        Linear spring and linear damper that can lift off.

   <i>Position</i>         Drive a flange with a reference position given as input signal.
   <i>Accelerate</i>       Drive a flange with an acceleration given as input signal.
   <i>Move</i>             Drive a flange with a reference position, velocity and
                    acceleration given as input signal.
   <i>Fixed</i>            Fixed flange at a predefined position.
   <i>Force</i>            External force defined as input signal.

   <i>ForceSensor</i>      Ideal sensor to measure the force in a flange.
   <i>PositionSensor</i>   Ideal sensor to measure absolute position of a flange.
   <i>SpeedSensor</i>      Ideal sensor to measure absolute velocity of a flange.
   <i>AccSensor</i>        Ideal sensor to measure absolute acceleration of a flange.

</pre>

<p>
This library is designed in a fully object oriented way in order that
components can be connected together in every meaningful combination
(e.g. direct connection of two springs or two shafts with inertia).
As a consequence, most models lead to a system of
differential-algebraic equations of <i>index 3</i> (= constraint
equations have to be differentiated twice in order to arrive at
a state space representation) and the Modelica translator or
the simulator has to cope with this system representation.
According to our present knowledge, this requires that the
Modelica translator is able to symbolically differentiate equations
(otherwise it is e.g. not possible to provide consistent initial
conditions; even if consistent initial conditions are present, most
numerical DAE integrators can cope at most with index 2 DAEs).
</p>

<b>Main Author:</b><i><ul> Peter Beater</i> <br>
    Universit&auml;t Paderborn, Abteilung Soest<br>
    Fachbereich Maschinenbau/Automatisierungstechnik<br>
    L&uuml;becker Ring 2 <br>
    D 59494 Soest <br>
    Germany <br>
email: <A HREF=\"mailto:Beater@mailso.uni-paderborn.de\">Beater@mailso.uni-paderborn.de</A><br>
</ul>
<br>

<p><b>Release
 Notes:</b></p>
<ul>
<li><i>Version 1.0 (January 5, 2000)</i>
       by Peter Beater <br>
       Realized a first version based on Modelica library Mechanics.Rotational
       by Martin Otter and an existing Dymola library onedof.lib by Peter Beater.
       <br>
<li><i>Version 1.01 (July 18, 2001)</i>
       by Peter Beater <br>
       Assert statement added to \"Stop\", small bug fixes in examples.

       <br><br>


</li>
</ul>
<br>


<p><b>Copyright &copy; 2000-2002, Modelica Association and Universit&auml;t Paderborn, FB 12.</b></p>

<p><i>
The Modelica package is free software; it can be redistributed and/or modified
under the terms of the Modelica license , see the license conditions
and the accompanying disclaimer in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  package Examples "Demonstration examples of the components of this package" 
    
    extends Modelica.Icons.Library;
    
    annotation(
      Window(
        x=0.07,
        y=0.14,
        width=0.51,
        height=0.4,
        library=1,
        autolayout=1),
      Documentation(info="<html>
<p>
This package contains example models to demonstrate the usage of the
Translational package. Open the models and
simulate them according to the provided description in the models.
The following examples are present:
</p>

<pre>
   <i>SignConvention</i>    Examples for the used sign conventions using simple, basic elements
   <i>InitialConditions</i> Setting of initial conditions
   <i>Accelerate </i>       Use of model accelerate
   <i>Damper</i>            Use of damper elements
   <i>Oscillator</i>        Oscillator demonstrates the use of initial conditions
   <i>Sensors</i>           Sensors for translational systems
   <i>Friction</i>          Stribeck friction characteristics
   <i>PreLoad</i>           Positioning of a spool using ElastoGap models
</pre>

<ul>
<li><i>First Version from December 7, 1999 by P. Beater</i> </li>
</ul>
</HTML>
"));
    encapsulated model SignConvention "Examples for the used sign conventions."
      
      
      import Modelica.Icons;
      import Modelica.Blocks.Sources;
      import Modelica.Mechanics.Translational;
      
      extends Icons.Example;
      annotation( Documentation(info="<html>
<p>
If all arrows point in the same direction a positive force
results in a positive acceleration a, velocity v and position s.
</p>
For a force of 1 N and a mass of 1 Kg this leads to
<pre>
        a = 1 m/s2
        v = 1 m/s after 1 s (SlidingMass1.v)
        s = 0.5 m after 1 s (SlidingMass1.s)
</pre>
The acceleration is not available for plotting.
<p>
</p>
System 1) and 2) are equivalent. It doesn't matter whether the
force pushes at flange_a in system 1 or pulls at flange_b in system 2.
</p><p>
It is of course possible to ignore the arrows and connect the models
in an arbitrary way. But then it is hard see in what direction the
force acts.
</p><p>
In the third system the two arrows are opposed which means that the
force acts in the opposite direction (in the same direction as in
the two other examples).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from December 10, 1999 by P. Beater </i> </li>
</ul>
</HTML>
"), Diagram(
          Text(extent=[-100, 80; -82, 60], string="1)"),
          Text(extent=[-100, 40; -82, 20], string="2)"),
          Text(extent=[-100, -20; -82, -40], string="3)")));
      Translational.SlidingMass SlidingMass1(L=1) annotation( extent=[36, 60;
            56, 80]);
      Translational.Force Force1 annotation( extent=[-4, 60; 16, 80]);
      Sources.Constant Constant1 annotation( extent=[-44, 60; -24, 80]);
      Translational.SlidingMass SlidingMass2(L=1) annotation( extent=[36, 0; 56,
              20]);
      Translational.Force Force2 annotation( extent=[-4, 20; 16, 40]);
      Sources.Constant Constant2 annotation( extent=[-44, 20; -24, 40]);
      Translational.SlidingMass SlidingMass3(L=1) annotation( extent=[-40, -40;
              -20, -20]);
      Translational.Force Force3 annotation( extent=[20, -40; 0, -20]);
      Sources.Constant Constant3 annotation( extent=[60, -40; 40, -20]);
    equation 
      connect(Constant1.outPort, Force1.inPort) annotation( points=[-23, 70; -6,
              70]);
      connect(Constant2.outPort, Force2.inPort) annotation( points=[-23, 30; -6,
              30]);
      connect(Force3.inPort, Constant3.outPort) annotation( points=[22, -30; 39,
              -30]);
      connect(Force1.flange_b, SlidingMass1.flange_a) annotation( points=[16,
            70; 36, 70], style(color=58));
      connect(Force2.flange_b, SlidingMass2.flange_b) annotation( points=[16,
            30; 82, 30; 82, 10; 56, 10], style(color=58));
      connect(SlidingMass3.flange_b, Force3.flange_b) annotation( points=[-20,
            -30; 0, -30], style(color=58));
    end SignConvention;
    
    encapsulated model InitialConditions "Setting of initial conditions" 
      import Modelica.Icons;
      import Modelica.Mechanics.Translational;
      
      extends Icons.Example;
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.45,
          y=0.01,
          width=0.56,
          height=0.83),
        Documentation(info="There are several ways to set initial conditions.

In the first system the position of the sliding mass m3 was defined
by using the modifier s(start=4.5), the position of m5 by s(start=12.5).
These positions were chosen such that the system is a rest. To calculate
these values start at the left (Fixed1) with a value of 1 m. The spring
has an unstreched length of 2 m and m3 an length of 3 m, which leads to

        1   m (Fixed1)
      + 2   m (Spring S2)
      + 3/2 m (half of the length of SlidingMass m3)
      -------
        4,5 m = s(start = 4.5) for m3
      + 3/2 m (half of the length of SlidingMass m3)
      + 4   m (SpringDamper 4
      + 5/2 m (half of length of SlidingMass m5)
      -------
       12,5 m = s(start = 12.5) for m5

This selection of initial conditions has the effect that Dymola selects
those variables (m3.s and m5.s) as state variables.

In the second example the length of the springs are given as start values
but they cannot be used as state for pure springs (only for the spring/damper
combination). In this case the system is not at rest.

<html> <IMG SRC=../Images/Fig.translational.examples.InitialConditions.png>  </HTML>
<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from December 10, 1999 by P. Beater </i> </li>
<li><i>Parameters and documentation modified, July 17, 2001 by P. Beater </i> </li>
</ul>
</HTML>


"));
      Translational.SlidingMass M3(L=3, s(start=4.5)) annotation( extent=[-20,
            60; 0, 80]);
      Translational.Spring S2(s_rel0=2, c=1e3) annotation( extent=[-60, 60; -40,
              80]);
      Translational.Fixed Fixed1(s0=1) annotation( extent=[-100, 60; -80, 80]);
      Translational.SpringDamper SD4(s_rel0=4, c=111) annotation( extent=[20,
            60; 40, 80]);
      Translational.SlidingMass M5(L=5, s(start=12.5)) annotation( extent=[60,
            60; 80, 80]);
      Translational.SlidingMass M1(L=1) annotation( extent=[-20, -20; 0, 0]);
      Translational.Spring S1(
        s_rel0=1,
        c=1e3,
        s_rel(start=1)) annotation( extent=[-58, -20; -38, 0]);
      Translational.Fixed Fixed2(s0=-1) annotation( extent=[-100, -20; -80, 0]);
      Translational.SpringDamper SD1(
        s_rel0=1,
        c=111,
        s_rel(start=1)) annotation( extent=[20, -20; 40, 0]);
      Translational.SlidingMass M2(L=2) annotation( extent=[60, -20; 80, 0]);
    equation 
      connect(Fixed1.flange_b, S2.flange_a) annotation( points=[-90, 70; -60,
            70], style(color=53));
      connect(S2.flange_b, M3.flange_a) annotation( points=[-40, 70; -20, 70],
          style(color=53));
      connect(M3.flange_b, SD4.flange_a) annotation( points=[0, 70; 20, 70],
          style(color=53));
      connect(SD4.flange_b, M5.flange_a) annotation( points=[40, 70; 60, 70],
          style(color=53));
      connect(Fixed2.flange_b, S1.flange_a) annotation( points=[-90, -10; -58,
            -10], style(color=53));
      connect(S1.flange_b, M1.flange_a) annotation( points=[-38, -10; -20, -10],
            style(color=53));
      connect(M1.flange_b, SD1.flange_a) annotation( points=[0, -10; 20, -10],
          style(color=53));
      connect(SD1.flange_b, M2.flange_a) annotation( points=[40, -10; 60, -10],
            style(color=53));
    end InitialConditions;
    
    encapsulated model WhyArrows "Use of arrows in Mechanics.Translational" 
      import Modelica.Icons;
      import Modelica.Mechanics.Translational;
      
      extends Icons.Example;
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.45,
          y=0.01,
          width=0.56,
          height=0.83),
        Documentation(info="When using the models of the translational sublibrary
it is recommended to make sure that all arrows point in
the same direction because then all component have the
same reference system.

In the example the distance from flange_a of Rod1 to flange_b
of Rod2 is 2 m. The distance from flange_a of Rad1 to flange_b
of Rod3 is also 2 m though it is difficult to see that. Without
the arrows it would be almost impossible to notice.

That all arrows point in the same direction is a sufficient
condition for an easy use of the library. There are cases
where horizontally flipped models can be used without
problems.

<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from July 17, 2001 by P. Beater </i> </li>
</ul>
</HTML>


"),     Diagram(
          Text(extent=[-80, 14; 90, 0], string=
                "PositionSensor2.s = PositionSensor3.s"),
          Text(extent=[-84, 4; 88, -16], string=
                "PositionSensor3.s <> PositionSensor1.s"),
          Text(extent=[-82, -80; 94, -92], string="Both systems are equivalent"),
          Line(points=[-90, -28; 90, -28], style(thickness=2))));
      Translational.Fixed Fixed1 annotation( extent=[-20, 20; 0, 40]);
      Translational.Rod Rod1(L=1) annotation( extent=[-48, 20; -28, 40]);
      Translational.Rod Rod2(L=1) annotation( extent=[20, 20; 40, 40]);
      Translational.Rod Rod3(L=1) annotation( extent=[-30, 58; -50, 78]);
      Translational.Sensors.PositionSensor PositionSensor2 annotation( extent=[
            60, 20; 80, 40]);
      Translational.Sensors.PositionSensor PositionSensor1 annotation( extent=[
            -60, 20; -80, 40]);
      Translational.Sensors.PositionSensor PositionSensor3 annotation( extent=[
            -60, 58; -80, 78]);
      Translational.Fixed Fixed3(s0=-1.9) annotation( extent=[-100, -60; -80, -
            40]);
      Translational.Spring Spring1(s_rel0=2, c=11) annotation( extent=[-74, -60;
              -54, -40]);
      Translational.SlidingMass SlidingMass1(L=2) annotation( extent=[-46, -60;
              -26, -40]);
      Translational.Fixed Fixed2(s0=-1.9) annotation( extent=[4, -60; 24, -40]);
      Translational.Spring Spring2(s_rel0=2, c=11) annotation( extent=[30, -60;
              50, -40]);
      Translational.SlidingMass SlidingMass2(L=2) annotation( extent=[78, -60;
            58, -40]);
    equation 
      connect(Rod1.flange_b, Fixed1.flange_b) annotation( points=[-28, 30; -10,
              30], style(color=58));
      connect(Fixed1.flange_b, Rod2.flange_a) annotation( points=[-10, 30; 20,
            30], style(color=58));
      connect(Rod3.flange_a, Fixed1.flange_b) annotation( points=[-30, 68; -10,
              68; -10, 30], style(color=58));
      connect(Rod2.flange_b, PositionSensor2.flange_a) annotation( points=[40,
            30; 60, 30], style(color=58));
      connect(PositionSensor1.flange_a, Rod1.flange_a) annotation( points=[-60,
              30; -48, 30], style(color=58));
      connect(PositionSensor3.flange_a, Rod3.flange_b) annotation( points=[-60,
              68; -50, 68], style(color=58));
      connect(Fixed3.flange_b, Spring1.flange_a) annotation( points=[-90, -50;
            -74, -50], style(color=58));
      connect(Spring1.flange_b, SlidingMass1.flange_b) annotation( points=[-54,
              -50; -54, -72; -26, -72; -26, -50], style(color=58));
      connect(Fixed2.flange_b, Spring2.flange_a) annotation( points=[14, -50;
            30, -50], style(color=58));
      connect(Spring2.flange_b, SlidingMass2.flange_b) annotation( points=[50,
            -50; 58, -50], style(color=58));
    end WhyArrows;
    
    encapsulated model Accelerate "Use of model accelerate." 
      import Modelica.Icons;
      import Modelica.Blocks.Sources;
      import Modelica.Mechanics.Translational;
      
      extends Icons.Example;
      Translational.Accelerate Accelerate1 annotation( extent=[-40, 20; -20, 40]);
      Translational.SlidingMass SlidingMass1(L=1) annotation( extent=[40, 20;
            60, 40]);
      Sources.Constant Constant1 annotation( extent=[-100, 20; -80, 40]);
    equation 
      connect(Constant1.outPort, Accelerate1.inPort) annotation( points=[-79,
            30; -42, 30]);
      connect(Accelerate1.flange_b, SlidingMass1.flange_a) annotation( points=[
            -20, 30; 40, 30], style(color=58));
    end Accelerate;
    
    encapsulated model Damper "Use of damper models." 
      import Modelica.Icons;
      import Modelica.Mechanics.Translational;
      
      extends Icons.Example;
      annotation( Documentation(info="Release notes:
--------------

2001 - 7  - 14: Damping parameters increased (from 1 to 25)
"));
      Translational.SlidingMass SlidingMass1(
        L=1,
        v(start=10),
        s(start=3)) annotation( extent=[-80, 60; -60, 80]);
      Translational.Damper Damper1(d=25) annotation( extent=[-20, 60; 0, 80]);
      Translational.Fixed Fixed1(s0=4.5) annotation( extent=[22, 60; 42, 80]);
      Translational.SlidingMass SlidingMass2(
        L=1,
        v(start=10),
        s(start=3)) annotation( extent=[-80, 0; -60, 20]);
      Translational.Damper Damper2(d=25) annotation( extent=[-20, 0; 0, 20]);
      Translational.Fixed Fixed2(s0=4.5) annotation( extent=[20, 0; 40, 20]);
      Translational.SlidingMass SlidingMass3(
        L=1,
        v(start=10),
        s(start=3)) annotation( extent=[-80, -60; -60, -40]);
      Translational.Fixed Fixed3(s0=4.5) annotation( extent=[20, -60; 40, -40]);
      Translational.Spring Spring1(s_rel0=1) annotation( extent=[-20, -20; 0, 0]);
      Translational.SpringDamper SpringDamper1(s_rel0=1, d=25) annotation(
          extent=[-20, -60; 0, -40]);
    equation 
      connect(SlidingMass1.flange_b, Damper1.flange_a) annotation( points=[-60,
              70; -20, 70], style(color=58));
      connect(Damper1.flange_b, Fixed1.flange_b) annotation( points=[0, 70; 32,
              70], style(color=58));
      connect(SlidingMass2.flange_b, Damper2.flange_a) annotation( points=[-60,
              10; -20, 10], style(color=58));
      connect(Damper2.flange_b, Fixed2.flange_b) annotation( points=[0, 10; 30,
              10], style(color=58));
      connect(Damper2.flange_b, Spring1.flange_b) annotation( points=[0, 10; 0,
              -10], style(color=58));
      connect(Damper2.flange_a, Spring1.flange_a) annotation( points=[-20, 10;
            -20, -10], style(color=58));
      connect(SlidingMass3.flange_b, SpringDamper1.flange_a) annotation( points=
           [-60, -50; -20, -50], style(color=58));
      connect(SpringDamper1.flange_b, Fixed3.flange_b) annotation( points=[0, -
            50; 30, -50], style(color=58));
    end Damper;
    
    encapsulated model Oscillator 
      "Oscillator demonstrates the use of initial conditions." 
      import Modelica.Icons;
      import Modelica.Blocks.Sources;
      import Modelica.Mechanics.Translational;
      
      extends Icons.Example;
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.45,
          y=0.01,
          width=0.56,
          height=0.83),
        Documentation(info="A spring - mass system is a mechanical oscillator. If no
damping is included and the system is excited at resonance
frequency infinite amplitudes will result.

The resonant frequency is given by

omega_res = sqrt(c / m)

with: c spring stiffness
      m mass

To make sure that the system is initially at rest the initial
conditions s(start=0) and v(start=0) for the SlindingMass
are set.

If damping is added the amplitudes are bounded.
<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from December 10, 1999 by P. Beater </i> </li>
</ul>
</HTML>
"));
      Translational.SlidingMass SlidingMass1(
        L=1,
        s(start=-0.5),
        v(start=0.0)) annotation( extent=[-20, 40; 0, 60]);
      Translational.Spring Spring1(s_rel0=1, c=10000) annotation( extent=[20,
            40; 40, 60]);
      Translational.Fixed Fixed1(s0=1.0) annotation( extent=[60, 40; 80, 60]);
      Translational.Force Force1 annotation( extent=[-60, 40; -40, 60]);
      Sources.Sine Sine1(freqHz={15.9155}) annotation( extent=[-100, 40; -80,
            60]);
      Translational.SlidingMass SlidingMass2(
        L=1,
        s(start=-0.5),
        v(start=0.0)) annotation( extent=[-20, -60; 0, -40]);
      Translational.Spring Spring2(s_rel0=1, c=10000) annotation( extent=[20, -
            60; 40, -40]);
      Translational.Fixed Fixed2(s0=1.0) annotation( extent=[60, -60; 80, -40]);
      Translational.Force Force2 annotation( extent=[-60, -60; -40, -40]);
      Sources.Sine Sine2(freqHz={15.9155}) annotation( extent=[-100, -60; -80,
            -40]);
      Translational.Damper Damper1(d=10) annotation( extent=[20, -36; 40, -16]);
    equation 
      connect(Sine1.outPort, Force1.inPort) annotation( points=[-79, 50; -62,
            50]);
      connect(Sine2.outPort, Force2.inPort) annotation( points=[-79, -50; -62,
            -50]);
      connect(Force1.flange_b, SlidingMass1.flange_a) annotation( points=[-40,
            50; -20, 50], style(color=58));
      connect(Spring1.flange_b, Fixed1.flange_b) annotation( points=[40, 50; 70,
              50], style(color=58));
      connect(SlidingMass1.flange_b, Spring1.flange_a) annotation( points=[0,
            50; 20, 50], style(color=58));
      connect(Force2.flange_b, SlidingMass2.flange_a) annotation( points=[-40,
            -50; -20, -50], style(color=58));
      connect(Spring2.flange_a, Damper1.flange_a) annotation( points=[20, -50;
            20, -26], style(color=58));
      connect(SlidingMass2.flange_b, Spring2.flange_a) annotation( points=[0, -
            50; 20, -50], style(color=58));
      connect(Damper1.flange_b, Spring2.flange_b) annotation( points=[40, -26;
            40, -50], style(color=58));
      connect(Spring2.flange_b, Fixed2.flange_b) annotation( points=[40, -50;
            70, -50], style(color=58));
    end Oscillator;
    
    encapsulated model Sensors "Sensors for translational systems." 
      import Modelica.Icons;
      import Modelica.Blocks.Sources;
      import Modelica.Mechanics.Translational;
      
      extends Icons.Example;
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.45,
          y=0.01,
          width=0.56,
          height=0.83),
        Documentation(info="These sensors measure

   force f in N
   position s in m
   velocity v in m/s
   acceleration a in m/s2

Dhe measured velocity and acceleration is independent on
the flange the sensor is connected to. The position
depends on the flange (flange_a or flange_b) and the
length L of the component.

Plot PositionSensor1.s, PositionSensor2.s and SlidingMass1.s
to see the difference.
<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from December 10, 1999 by P. Beater </i> </li>
</ul>
</HTML>
"));
      Translational.Sensors.ForceSensor ForceSensor1 annotation( extent=[-20,
            40; 0, 60]);
      Translational.Sensors.SpeedSensor SpeedSensor1 annotation( extent=[20, -
            40; 40, -20]);
      Translational.Sensors.PositionSensor PositionSensor1 annotation( extent=[
            20, 0; 40, 20]);
      Translational.Sensors.AccSensor AccSensor1 annotation( extent=[20, -80;
            40, -60]);
      Translational.SlidingMass SlidingMass1(L=1) annotation( extent=[20, 40;
            40, 60]);
      Translational.Force Force1 annotation( extent=[-60, 40; -40, 60]);
      Sources.Sine Sine1(amplitude={10}, freqHz={4}) annotation( extent=[-100,
            40; -80, 60]);
      Translational.Sensors.PositionSensor PositionSensor2 annotation( extent=[
            60, 40; 80, 60]);
    equation 
      connect(Sine1.outPort, Force1.inPort) annotation( points=[-79, 50; -62,
            50]);
      connect(ForceSensor1.flange_b, SlidingMass1.flange_a) annotation( points=
            [0, 50; 20, 50], style(color=58));
      connect(SlidingMass1.flange_b, PositionSensor2.flange_a) annotation(
          points=[40, 50; 60, 50], style(color=58));
      connect(Force1.flange_b, ForceSensor1.flange_a) annotation( points=[-40,
            50; -20, 50], style(color=58));
      connect(SlidingMass1.flange_a, PositionSensor1.flange_a) annotation(
          points=[20, 50; 20, 10], style(color=58));
      connect(PositionSensor1.flange_a, SpeedSensor1.flange_a) annotation(
          points=[20, 10; 20, -30], style(color=58));
      connect(SpeedSensor1.flange_a, AccSensor1.flange_a) annotation( points=[
            20, -30; 20, -70], style(color=58));
    end Sensors;
    
    encapsulated model Friction "Use of model Stop" 
      import Modelica.Icons;
      import Modelica.Blocks.Sources;
      import Modelica.Mechanics.Translational;
      
      extends Icons.Example;
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(
          Text(extent=[-56, -88; 62, -100], string="simulate 5 s"),
          Text(extent=[-100, 80; -80, 60], string="1)"),
          Text(extent=[-100, 20; -80, 0], string="2)")),
        Window(
          x=0.45,
          y=0.01,
          width=0.56,
          height=0.83),
        Documentation(info="1) Simulate and then plot Stop1.f as a function of Stop1.v
   This gives the Stribeck curve.

2) This model gives an example for a hard stop. However there
   can arise some problems with the used modeling approach (use of
   Reinit, convergence problems). In this case use the ElastoGap
   to model a stop (see example Preload).
<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from December 10, 1999 by P. Beater </i> </li>
</ul>
</HTML>
"));
      Translational.Stop Stop1(L=1) annotation( extent=[60, 60; 80, 80]);
      Translational.Force Force1 annotation( extent=[18, 60; 38, 80]);
      Sources.Sine Sine1(amplitude={25}, freqHz={0.25}) annotation( extent=[-20,
              60; 0, 80]);
      Translational.Stop Stop2(
        L=1,
        smax=0.9,
        smin=-0.9,
        F_Coulomb=3,
        F_Stribeck=5,
        s(start=0),
        v(start=-5)) annotation( extent=[60, 0; 80, 20]);
      Translational.Spring Spring1(s_rel0=1, c=500) annotation( extent=[20, 0;
            40, 20]);
      Translational.Fixed Fixed1(s0=-1.75) annotation( extent=[-22, 0; -2, 20]);
    equation 
      connect(Sine1.outPort, Force1.inPort) annotation( points=[1, 70; 16, 70]);
      connect(Force1.flange_b, Stop1.flange_a) annotation( points=[38, 70; 60,
            70], style(color=58));
      connect(Fixed1.flange_b, Spring1.flange_a) annotation( points=[-12, 10;
            20, 10], style(color=58));
      connect(Spring1.flange_b, Stop2.flange_a) annotation( points=[40, 10; 60,
              10], style(color=58));
    end Friction;
    
    encapsulated model PreLoad "Preload of a spool using ElastoGap models." 
      import Modelica.Icons;
      import Modelica.Blocks.Sources;
      import Modelica.Mechanics.Translational;
      
      extends Icons.Example;
      
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.45,
          y=0.01,
          width=0.56,
          height=0.83),
        Diagram(
          Text(extent=[-98, -68; 102, -94], string=
                "positive force => spool moves in positive direction "),
          Text(extent=[-32, -46; 38, -62], string="Simulate for 100 s"),
          Text(extent=[-100, -54; 100, -80], string=
                "plot Spool.s as a function of Force1.f")),
        Documentation(info="When designing hydraulic valves it is often necessary to hold the spool in
a certain position as long as an external force is below a threshold value.
If this force exceeds the treshold value a linear relation between force
and position is desired.
There are designs that need only one spring to accomplish this task. Using
the ElastoGap elements this design can be modelled easily.
Drawing of spool.
<HTML> <IMG SRC=../Images/PreLoad.png> </HTML>
<HTML> <IMG SRC=../Images/PreLoad3.png> </HTML>
<HTML> <IMG SRC=../Images/PreLoad4.png> </HTML>
Spool position s as a function of working force f.
<HTML> <IMG SRC=../Images/PreLoad2.png> </HTML>
<HTML>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from December 10, 1999 by P. Beater </i> </li>
<li><i>July 17, 2001, parameters changed, by P. Beater </i> </li>
<li><i>Ocotber 5, 2002, object diagram and parameters changed, by P. Beater </i> </li>
</ul>
</HTML>
"));
      Translational.ElastoGap InnerContactA(
        s_rel0=1e-3,
        c=1000e3,
        d=250) annotation( extent=[-68, 20; -48, 40]);
      Translational.ElastoGap InnerContactB(
        s_rel0=1e-3,
        c=1000e3,
        d=250) annotation( extent=[54, 20; 74, 40], style(color=58));
      Translational.SlidingMass Spool(
        L=0.19,
        m=0.150,
        s(start=14.75e-3)) annotation( extent=[6, -42; 46, -2]);
      Translational.Fixed FixedLe(s0=-95.5e-3) annotation(
          extent=[-98, 58; -78, 78]);
      Translational.SlidingMass SpringPlateA(
        L=2e-3,
        m=10e-3,
        s(start=-93e-3)) annotation( extent=[-40, 58; -20, 78]);
      Translational.SlidingMass SpringPlateB(
        L=2e-3,
        m=10e-3,
        s(start=-69.25e-3)) annotation( extent=[26, 58; 46, 78], style(color=58));
      Translational.Spring Spring(c=20e3, s_rel0=25e-3) 
        annotation( extent=[-8, 58; 12, 78]);
      Translational.ElastoGap OuterContactA(
        s_rel0=1.5e-3,
        c=1000e3,
        d=250) annotation( extent=[-74, 58; -54, 78]);
      Translational.ElastoGap OuterContactB(
        c=1000e3,
        d=250,
        s_rel0=1.5e-3) annotation( extent=[60, 58; 80, 78]);
      Translational.Rod Rod1(L=7e-3) annotation( extent=[-40, 32;
              -20, 52]);
      Translational.Damper Friction(d=2500) annotation( extent=[
            -98, 14; -78, 34], rotation=-90);
      Translational.Force Force1 annotation( extent=[-32, -32; -
            12, -12]);
      Translational.Rod Housing(L=30.5e-3) annotation( extent=[-
            8, 78; 12, 98]);
      Translational.Rod Rod3(L=5.75e-3) annotation( extent=[-40,
              -2; -20, 18]);
      Translational.Rod Rod4(L=5.75e-3) annotation( extent=[26,
            -2; 46, 18]);
      Translational.Rod Rod2(L=7e-3) annotation( extent=[26, 32;
              46, 52]);
      Sources.Sine Sine1(amplitude={150}, freqHz={0.01}) 
        annotation( extent=[-76, -32; -56, -12]);
    equation 
      connect(OuterContactA.flange_b, SpringPlateA.flange_a) annotation( points=[-
            54, 68; -40, 68], style(color=58));
      connect(SpringPlateA.flange_b, Spring.flange_a) annotation( points=[-20, 68;
            -8, 68], style(color=58));
      connect(Spring.flange_b, SpringPlateB.flange_a) annotation( points=[12, 68;
            26, 68], style(color=58));
      connect(SpringPlateB.flange_b, OuterContactB.flange_a) annotation( points=[46,
              68; 60, 68], style(color=58));
      connect(FixedLe.flange_b, OuterContactA.flange_a) annotation( points=[-88, 68;
              -74, 68], style(color=58));
      connect(Friction.flange_a, FixedLe.flange_b) annotation( points=[-88, 34; -88,
              68], style(color=58));
      connect(FixedLe.flange_b, Housing.flange_a) annotation( points=[-88, 68; -88,
              88; -8, 88], style(color=58));
      connect(OuterContactB.flange_b, Housing.flange_b) annotation( points=[80, 68;
              80, 88; 12, 88], style(color=58));
      connect(SpringPlateA.flange_b, Rod1.flange_a) annotation( points=[-20, 68; -
            20, 52; -40, 52; -40, 42], style(color=58));
      connect(InnerContactA.flange_a, Rod3.flange_a) annotation( points=[-68, 30; -
            80, 30; -80, 8; -40, 8], style(color=58));
      connect(InnerContactA.flange_b, Rod1.flange_b) annotation( points=[-48, 30; -
            12, 30; -12, 42; -20, 42], style(color=58));
      connect(Rod2.flange_a, InnerContactB.flange_a) annotation( points=[26, 42; 26,
              30; 54, 30], style(color=58));
      connect(Rod4.flange_b, InnerContactB.flange_b) annotation( points=[46, 8; 80,
              8; 80, 30; 74, 30], style(color=58));
      connect(Friction.flange_b, Rod3.flange_a) annotation( points=[-88, 14; -88, 8;
              -40, 8], style(color=58));
      connect(Sine1.outPort, Force1.inPort) annotation( points=[-55, -22; -34, -22],
            style(color=3));
      connect(Force1.flange_b, Spool.flange_a) annotation( points=[-12, -22; 6, -22],
               style(color=58));
      connect(Rod3.flange_b, Rod4.flange_a) annotation( points=[-20, 8; 26, 8],
          style(color=58));
      connect(Rod2.flange_b, SpringPlateB.flange_a) annotation( points=[46, 42; 46,
              54; 26, 54; 26, 68], style(color=58));
      connect(Spool.flange_a, Rod4.flange_a) annotation( points=[6, -20; 6, 8; 26,
            8], style(color=58));
    end PreLoad;
  end Examples;
  
  package Interfaces "Interfaces for 1D translational mechanical components" 
    
    extends Modelica.Icons.Library;
    
    connector Flange_a 
      "(left) 1D translational flange (flange axis directed INTO cut plane, e. g. from left to right)"
      
      
      annotation(
        Coordsys(extent=[-100, -100; 100, 100]),
        Window(
          x=0.27,
          y=0.05,
          width=0.39,
          height=0.83),
        Documentation(info="<html>

This is a flange for 1D translational mechanical systems. In the cut plane of
the flange a unit vector n, called flange axis, is defined which is directed
INTO the cut plane, i. e. from left to right. All vectors in the cut plane are
resolved with respect to
this unit vector. E.g. force f characterizes a vector which is directed in
the direction of n with value equal to f. When this flange is connected to
other 1D translational flanges, this means that the axes vectors of the connected
flanges are identical.
</p>
<p>
The following variables are transported through this connector:
<pre>

  s: Absolute position of the flange in [m]. A positive translation
     means that the flange is translated along the flange axis.
  f: Cut-force in direction of the flange axis in [N].
</pre>
</HTML>
"),     Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=58, fillColor=
                 58))),
        Diagram(Rectangle(extent=[-100, -100; 100, 100], style(color=58,
                fillColor=58)), Text(
            extent=[-100, -120; 100, -220],
            string="%name",
            style(color=58))),
        Terminal(Rectangle(extent=[-100, -100; 100, 100], style(color=58,
                fillColor=58))));
      
      SI.Position s "absolute position of flange";
      flow SI.Force f "cut force directed into flange";
    end Flange_a;
    
    connector Flange_b 
      "right 1D translational flange (flange axis directed OUT OF cut plane)" 
      SI.Position s "absolute position of flange";
      flow SI.Force f "cut force directed into flange";
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.27,
          y=0.05,
          width=0.39,
          height=0.83),
        Documentation(info="<html>
This is a flange for 1D translational mechanical systems. In the cut plane of
the flange a unit vector n, called flange axis, is defined which is directed
OUT OF the cut plane. All vectors in the cut plane are resolved with respect to
this unit vector. E.g. force f characterizes a vector which is directed in
the direction of n with value equal to f. When this flange is connected to
other 1D translational flanges, this means that the axes vectors of the connected
flanges are identical.
</p>
<p>
The following variables are transported through this connector:
<pre>

  s: Absolute position of the flange in [m]. A positive translation
     means that the flange is translated along the flange axis.
  f: Cut-force in direction of the flange axis in [N].
</pre>
</HTML>
"),     Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=58, fillColor=
                 7))),
        Diagram(Rectangle(extent=[-100, -100; 100, 100], style(color=58,
                fillColor=7)), Text(
            extent=[-100, -120; 100, -220],
            string="%name",
            style(color=58))),
        Terminal(Rectangle(extent=[-100, -100; 100, 100], style(color=58))));
    end Flange_b;
    
    partial model Rigid "Rigid connection of two translational 1D flanges " 
      SI.Position s 
        "absolute position of center of component (s = flange_a.s + L/2 = flange_b.s - L/2)";
      parameter SI.Length L=0 
        "length of component from left flange to right flange (= flange_b.s - flange_a.s)";
      Flange_a flange_a 
        "(left) driving flange (flange axis directed INTO cut plane, i. e. from left to right)"
         annotation( extent=[-110, -10; -90, 10]);
      Flange_b flange_b 
        "(right) driven flange (flange axis directed OUT OF cut plane, i. e. from right to left)"
         annotation( extent=[90, -10; 110, 10]);
      annotation(
        Documentation(info="<html>
<p>
This is a 1D translational component with two <i>rigidly</i> connected flanges.
The distance between the left and the right flange is always constant, i. e. L.
The forces at the right and left flange can be different.
It is used e.g. to built up sliding masses.

<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater  (based on Rotational.Rigid)</i> </li>
</ul>
</HTML>
"),     Diagram,
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.14,
          y=0.05,
          width=0.71,
          height=0.58));
    equation 
      flange_a.s = s - L/2;
      flange_b.s = s + L/2;
    end Rigid;
    
    partial model Compliant 
      "Compliant connection of two translational 1D flanges" 
      Flange_a flange_a 
        "(left) driving flange (flange axis directed INTO cut plane, e. g. from left to right)"
         annotation( extent=[-110, -10; -90, 10]);
      Flange_b flange_b 
        "(right) driven flange (flange axis directed OUT OF cut plane)" 
        annotation( extent=[90, -10; 110, 10]);
      SI.Distance s_rel "relative distance (= flange_b.s - flange_a.s)";
      SI.Force f 
        "forcee between flanges (positive in direction of flange axis R)";
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.17,
          y=0.09,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
This is a 1D translational component with a <i>compliant </i>connection of two
translational 1D flanges where inertial effects between the two
flanges are not included. The absolute value of the force at the left and the right
flange is the same. It is used to built up springs, dampers etc.
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.Compliant)</i> </li>
</ul>
</HTML>
"),     Diagram(Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(
                color=10, fillColor=10)), Line(points=[-60, -90; 20, -90],
              style(color=0, fillColor=10))));
    equation 
      s_rel = flange_b.s - flange_a.s;
      flange_b.f = f;
      flange_a.f = -f;
    end Compliant;
    
    partial model TwoFlanges "Component with two translational 1D flanges " 
      Flange_a flange_a 
        "(left) driving flange (flange axis directed INTO cut plane, e. g. from left to right)"
         annotation( extent=[-110, -10; -90, 10]);
      Flange_b flange_b 
        "(right) driven flange (flange axis directed OUT OF cut plane)" 
        annotation( extent=[90, -10; 110, 10]);
      annotation(
        Documentation(info="<html>
<p>
This is a 1D translational component with two flanges.
It is used e.g. to built up parts of a drive train consisting
of several base components.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.TwoFlanges)</i> </li>
</ul>
</HTML>
"),     Diagram,
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.08,
          y=0.18,
          width=0.6,
          height=0.6));
    end TwoFlanges;
    
    partial model AbsoluteSensor 
      "Device to measure a single absolute flange variable" 
      
      extends Modelica.Icons.TranslationalSensor;
      
      Flange_a flange_a 
        "(left) flange to be measured (flange axis directed INTO cut plane, e. g. from left to right)"
         annotation( extent=[-110, -10; -90, 10]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=1) annotation( extent=
            [100, -10; 120, 10]);
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.36,
          y=0.04,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
This is the superclass of a 1D translational component with one flange and one
output signal in order to measure an absolute kinematic quantity in the flange
and to provide the measured signal as output signal for further processing
with the Modelica.Blocks blocks.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Version 1.0 (July 18, 1999)</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

<p><b>Copyright &copy; 1999-2002, Modelica Association and DLR.</b></p>
</HTML>
"),     Icon(
          Line(points=[-100, -90; -20, -90], style(
              color=0,
              fillColor=10,
              fillPattern=1)),
          Polygon(points=[10, -90; -20, -80; -20, -100; 10, -90], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Line(points=[-70, 0; -90, 0], style(color=0)),
          Line(points=[70, 0; 100, 0]),
          Text(extent=[-118, 99; 118, 40], string="%name")),
        Diagram(Line(points=[-70, 0; -90, 0], style(color=0)), Line(points=[70,
                  0; 100, 0])));
    end AbsoluteSensor;
    
    partial model RelativeSensor 
      "Device to measure a single relative variable between two flanges" 
      
      extends Modelica.Icons.TranslationalSensor;
      
      Flange_a flange_a 
        "(left) driving flange (flange axis directed INTO cut plane, e. g. from left to right)"
         annotation( extent=[-110, -10; -90, 10]);
      Flange_b flange_b 
        "(right) driven flange (flange axis directed OUT OF cut plane)" 
        annotation( extent=[90, -10; 110, 10]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=1) annotation( extent=
            [-10, -100; 10, -120], rotation=90);
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.04,
          y=0.05,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
This is a superclass for 1D translational components with two rigidly connected
flanges and one output signal in order to measure relative kinematic quantities
between the two flanges or the cut-force in the flange and
to provide the measured signal as output signal for further processing
with the Modelica.Blocks blocks.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Version 1.0 (July 18, 1999)</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

<p><b>Copyright &copy; 1999-2002, Modelica Association and DLR.</b></p>
</HTML>
"),     Icon(
          Line(points=[-51, 34; 29, 34], style(
              color=0,
              fillColor=10,
              fillPattern=1)),
          Polygon(points=[59, 34; 29, 44; 29, 24; 59, 34], style(
              color=0,
              fillColor=10,
              fillPattern=1)),
          Line(points=[-70, 0; -90, 0], style(color=0)),
          Line(points=[70, 0; 90, 0], style(color=0)),
          Line(points=[0, -100; 0, -60]),
          Text(extent=[-117, 116; 115, 52], string="%name")),
        Diagram(
          Line(points=[-70, 0; -90, 0], style(color=0)),
          Line(points=[70, 0; 90, 0], style(color=0)),
          Line(points=[0, -100; 0, -60])));
    end RelativeSensor;
    
    partial model FrictionBase "Base class of Coulomb friction elements" 
      extends Rigid;
      parameter SI.Position smax=25 
        "right stop for (right end of) sliding mass";
      parameter SI.Position smin=-25 "left stop for (left end of) sliding mass";
      parameter SI.Velocity v_small=1e-3 
        "Relative velocity near to zero (see model info text)";
      
        // Equations to define the following variables have to be defined in subclasses
      SI.Velocity v_relfric "Relative velocity between frictional surfaces";
      SI.Acceleration a_relfric 
        "Relative acceleration between frictional surfaces";
      SI.Force f 
        "Friction force (positive, if directed in opposite direction of v_rel)";
      SI.Force f0 "Friction force for v=0 and forward sliding";
      SI.Force f0_max "Maximum friction force for v=0 and locked";
      Boolean free "true, if frictional element is not active";
      
      // Equations to define the following variables are given in this class
      Real sa "Path parameter of friction characteristic f = f(a_relfric)";
      
      Boolean startForward 
        "true, if v_rel=0 and start of forward sliding or v_rel > v_small";
      Boolean startBackward 
        "true, if v_rel=0 and start of backward sliding or v_rel < -v_small";
      Boolean locked "true, if v_rel=0 and not sliding";
      
      constant Integer Unknown=3 "Value of mode is not known";
      constant Integer Free=2 "Element is not active";
      constant Integer Forward=1 "v_rel > 0 (forward sliding)";
      constant Integer Stuck=0 
        "v_rel = 0 (forward sliding, locked or backward sliding)";
      constant Integer Backward=-1 "v_rel < 0 (backward sliding)";
      Integer mode(
        final min=Backward,
        final max=Unknown,
        start=Unknown);
      annotation( Documentation(info="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Version from January 5, 2000 by P. Beater
(based on Translational.FrictionBase from Martin Otter)</i> </li>
</ul>
</HTML>
"));
    equation 
      /* Friction characteristic
     (locked is introduced to help the Modelica translator determining
      the different structural configurations, if for each configuration
      special code shall be generated)
  */
      
      startForward = pre(mode) == Stuck and (sa > f0_max and s < (smax - L/2) or 
            pre(startForward) and sa > f0 and s < (smax - L/2)) or pre(mode)
         == Backward and v_relfric > v_small or initial() and (v_relfric > 0);
      startBackward = pre(mode) == Stuck and (sa < -f0_max and s > (smin + L/2) or 
            pre(startBackward) and sa < -f0 and s > (smin + L/2)) or pre(mode)
         == Forward and v_relfric < -v_small or initial() and (v_relfric < 0);
      
      locked = not free and not (pre(mode) == Forward or startForward or pre(
        mode) == Backward or startBackward);
      
      a_relfric = if locked then 0 else if free then sa else if startForward then 
              sa - f0 else if startBackward then sa + f0 else if pre(mode) ==
        Forward then sa - f0 else sa + f0;
      
      /* Friction torque has to be defined in a subclass. Example for a clutch:
       f = if locked then sa else if free then 0 else cgeo*fn*
                (if startForward  then  Math.tempInterpol1( w_relfric, mue_pos, 2)
             else if startBackward then -Math.tempInterpol1(-w_relfric, mue_pos, 2)
             else if pre(mode) == Forward then Math.tempInterpol1(w_relfric, mue_pos, 2)
             else -Math.tempInterpol1(-w_relfric, mue_pos, 2));
  */
      
      // finite state machine to determine configuration
      
      mode = if free then Free else (if (pre(mode) == Forward or pre(mode) ==
        Free or startForward) and v_relfric > 0 and s < (smax - L/2) then 
        Forward else if (pre(mode) == Backward or pre(mode) == Free or 
        startBackward) and v_relfric < 0 and s > (smin + L/2) then Backward else 
              Stuck);
      
    end FrictionBase;
  end Interfaces;
  
  model SlidingMass "Sliding mass with inertia" 
    extends Interfaces.Rigid;
    parameter SI.Mass m=1 "mass of the sliding mass";
    SI.Velocity v "absolute velocity of component";
    SI.Acceleration a "absolute acceleration of component";
    
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.23,
        y=0.06,
        width=0.7,
        height=0.63),
      Documentation(info="<html>
<p>
Sliding mass with <i>inertia, without friction</i> and two rigidly connected flanges.
</p>
<p>
The sliding mass has the length L, the position coordinate s is in the middle.
Sign convention: A positive force at flange flange_a moves the sliding mass in the positive direction.
A negative force at flange flange_a moves the sliding mass to the negative direction.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.Shaft)</i> </li>
</ul>
</HTML>
"),   Icon(
        Line(points=[-100, 0; -55, 0], style(color=58)),
        Line(points=[55, 0; 100, 0], style(color=58)),
        Rectangle(extent=[-55, -30; 56, 30], style(
            color=0,
            gradient=3,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10)),
        Text(extent=[0, 100; 0, 40], string="%name")),
      Diagram(
        Line(points=[-100, 0; -55, 0], style(color=58)),
        Line(points=[55, 0; 100, 0], style(color=58)),
        Rectangle(extent=[-55, -30; 55, 30], style(
            color=0,
            gradient=3,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10)),
        Line(points=[-100, -29; -100, -61], style(color=0)),
        Line(points=[100, -61; 100, -28], style(color=0)),
        Line(points=[-98, -60; 98, -60], style(color=0)),
        Polygon(points=[-101, -60; -96, -59; -96, -61; -101, -60], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[100, -60; 95, -61; 95, -59; 100, -60], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-44, -41; 51, -57], string="Length L"),
        Line(points=[0, 30; 0, 53], style(color=0)),
        Line(points=[-72, 40; 1, 40], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[-7, 42; -7, 38; -1, 40; -7, 42], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-61, 53; -9, 42], string="Position s")));
  equation 
    
    v = der(s);
    a = der(v);
    m*a = flange_a.f + flange_b.f;
  end SlidingMass;
  
  model Stop "Sliding mass with hard stop and Stribeck friction" 
    extends Modelica.Mechanics.Translational.Interfaces.FrictionBase(
  s(stateSelect=  StateSelect.always));
    Modelica.SIunits.Velocity v(stateSelect=  StateSelect.always) 
      "Absolute velocity of flange_a and flange_b";
    Modelica.SIunits.Acceleration a 
      "Absolute acceleration of flange_a and flange_b";
    parameter Modelica.SIunits.Mass m=1 "mass";
    
    parameter Real F_prop(
      final unit="N/ (m/s)",
      final min=0)=  1 "velocity dependent friction";
    parameter Modelica.SIunits.Force F_Coulomb=5 
      "constant friction: Coulomb force";
    parameter Modelica.SIunits.Force F_Stribeck=10 "Stribeck effect";
    parameter Real fexp(
      final unit="1/ (m/s)",
      final min=0)=  2 "exponential decay";
    
    annotation(
      Documentation(info="
<HTML>
<P>This element describes the <i>Stribeck friction characteristics</i> of a sliding mass,
i. e. the frictional force acting between the sliding mass and the support. Included is a
<i>hard stop</i> for the position. <BR>
The surface is fixed and there is friction between sliding mass and surface.
The frictional force f is given for positive velocity v by:</P>
<i><uL>
f = F_Coulomb + F_prop * v + F_Stribeck * exp (-fexp * v)</i> </ul><br>


<IMG SRC=../Images/Stribeck.png>
<br><br>
The distance between the left and the right connector is given by parameter L.
The position of the center of gravity, coordinate s, is in the middle between
the two flanges. </p>
<p>
There are hard stops at smax and smin, i. e. if <i><uL>
flange_a.s &gt;= smin
<ul>    and </ul>
flange_b.s &lt;= xmax </ul></i>
the sliding mass can move freely.</p>

<p>When the absolute velocity becomes zero, the sliding mass becomes stuck, i.e., the absolute position remains constant. In this phase the
friction force is calculated from a force balance due to the requirement that the
absolute acceleration shall be zero. The elements begin to slide when the friction
force exceeds a threshold value, called the maximum static friction force, computed via: </P>

<i><uL>

   maximum_static_friction =  F_Coulomb + F_Stribeck
</i> </ul>


<font color=\"#ff0000\"> <b>This requires the states Stop.s and Stop.v</b> </font>. If these states are eliminated during the index reduction
the model will not work. To avoid this any inertias should be connected via springs
to the Stop element, other sliding masses, dampers or hydraulic chambers must be avoided. </p>

<p>For more details of the used friction model see the following reference: <br> <br>
Beater P. (1999): <DD><a href=\"http://www.springer.de/cgi-bin/search_book.pl?isbn=3-540-65444-5\">
Entwurf hydraulischer Maschinen</a>. Springer Verlag Berlin Heidelberg New York.</DL></P>

<P>The friction model is implemented in a \"clean\" way by state events and leads to
continuous/discrete systems of equations which have to be solved by appropriate
numerical methods. The method is described in: </P>
<DL>
Otter M., Elmqvist H., and Mattsson S.E. (1999):
<i><DD>Hybrid Modeling in Modelica based on the Synchronous Data Flow Principle</i>. CACSD'99, Aug. 22.-26, Hawaii. </DD>
</DL>

<P>More precise friction models take into account the elasticity of the material when
the two elements are \"stuck\", as well as other effects, like hysteresis. This has
the advantage that the friction element can be completely described by a differential
equation without events. The drawback is that the system becomes stiff (about 10-20 times
slower simulation) and that more material constants have to be supplied which requires more
sophisticated identification. For more details, see the following references, especially
(Armstrong and Canudas de Witt 1996): </P>
<DL>
Armstrong B. (1991):
<i><DD>Control of Machines with Friction</i>. Kluwer Academic Press, Boston MA.<BR>
</DD>
<DT>Armstrong B., and Canudas de Wit C. (1996): </DT>
<i><DD>Friction Modeling and Compensation.</i> The Control Handbook, edited by W.S.Levine, CRC Press, pp. 1369-1382.<BR>
</DD>
<DT>Canudas de Wit C., Olsson H., Astroem K.J., and Lischinsky P. (1995): </DT>
<i><DD>A new model for control of systems with friction.</i> IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<BR>
</DD>
</DL>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from December 7, 1999 by P. Beater (based on Rotational.BearingFriction)</i> </li>
<li><i>July 14, 2001 by P. Beater, assert on initialization added, diagram modified </i> </li>
<li><i>October 11, 2001, by Hans Olsson, Dynasim, modified assert to handle start at stops,
modified event logic such if you have friction parameters equal to zero you do not get events
between the stops.</i> </li>
<li><i>June 10, 2002 by P. Beater, StateSelect.always for variables s and v (instead of fixed=true). </i> </li>
</ul>
</HTML>
"),   Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.45,
        y=0.01,
        width=0.56,
        height=0.83),
      Icon(
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10)),
        Rectangle(extent=[-30, 30; 35, -35], style(
            color=0,
            gradient=3,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-90, 0; -30, 0], style(color=58)),
        Rectangle(extent=[-70, -45; 74, -60], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-63, -15; -55, -45], style(
            color=0,
            arrow=1,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[60, -16; 69, -45], style(
            color=0,
            arrow=1,
            fillColor=0,
            fillPattern=1)),
        Line(points=[29, 0; 90, 0], style(color=58)),
        Text(extent=[0, 100; 0, 40], string="%name")),
      Diagram(
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10)),
        Rectangle(extent=[-30, 26; 35, -9], style(
            color=0,
            gradient=3,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-90, 0; -30, 0], style(color=58)),
        Line(points=[35, 0; 90, 0], style(color=58)),
        Rectangle(extent=[-68, -14; 76, -29], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-119, 43; -111, 17], style(
            color=0,
            arrow=1,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-111, 43; -111, 50], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-151, 49; -113, 49], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-149, 51; -126, 60], string="s min"),
        Polygon(points=[-121, 52; -111, 49; -121, 46; -121, 52], style(color=0,
                fillColor=0)),
        Rectangle(extent=[124, 42; 132, 17], style(
            color=0,
            arrow=1,
            fillColor=0,
            fillPattern=1)),
        Line(points=[124, 39; 124, 87], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-19, 78; 121, 78], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-17, 83; 6, 92], string="s max"),
        Polygon(points=[114, 81; 124, 78; 114, 75; 114, 81], style(color=0,
              fillColor=0)),
        Line(points=[5, 26; 5, 63], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-77, 58; -1, 58], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-75, 60; -38, 71], string="Position s"),
        Polygon(points=[-5, 61; 5, 58; -5, 55; -5, 61], style(color=0,
              fillColor=0)),
        Line(points=[-100, -10; -100, -60], style(color=0)),
        Line(points=[100, -10; 100, -60], style(color=0)),
        Polygon(points=[90, -47; 100, -50; 90, -53; 90, -47], style(color=0,
              fillColor=0)),
        Polygon(points=[-90, -47; -90, -53; -100, -50; -90, -47], style(color=
                0, fillColor=0)),
        Line(points=[-90, -50; 92, -50], style(color=0)),
        Text(extent=[-11, -46; 26, -36], string="Length L")));
  equation 
    
    // Constant auxiliary variables
    f0 = (F_Coulomb + F_Stribeck);
    f0_max = f0*1.001;
    free = f0 <= 0 and F_prop <= 0 and s > smin + L/2 and s < smax - L/2;
    
    // Velocity and acceleration of flanges
    v = der(s);
    a = der(v);
    v_relfric = v;
    a_relfric = a;
    
    // Equilibrium of forces
    0 = flange_a.f + flange_b.f - f - m*der(v);
    
    // Friction force
    f = if locked then sa else if free then 0 else 
            (if startForward then F_prop*v + F_Coulomb +
      F_Stribeck else if startBackward then F_prop*v - F_Coulomb - F_Stribeck else 
            if pre(mode) == Forward then F_prop*v + F_Coulomb + F_Stribeck*exp(-
      fexp*abs(v)) else F_prop*v - F_Coulomb - F_Stribeck*exp(-fexp*abs(v)));
    
      // Define events for hard stops and reinitiliaze the state variables velocity v and position s
  algorithm 
    when (initial()) then
      assert(s > smin + L/2 or s >= smin + L/2 and v >= 0,
        "Error in initialization of hard stop. (s - L/2) must be >= smin ");
      assert(s < smax - L/2 or s <= smax - L/2 and v <= 0,
        "Error in initialization of hard stop. (s + L/2) must be <= smax ");
    end when;
    
    when not (s < smax - L/2) then
      reinit(s, smax - L/2);
      if (not initial() or v>0) then
        reinit(v, 0);
      end if;
    end when;
    
    when not (s > smin + L/2) then
      reinit(s, smin + L/2);
      if (not initial() or v<0) then
        reinit(v, 0);
      end if;
    end when;
  end Stop;
  
  model Rod "Rod without inertia" 
    extends Interfaces.Rigid;
    
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.23,
        y=0.06,
        width=0.7,
        height=0.63),
      Documentation(info="<html>
<p>
Rod <i>without inertia</i> and two rigidly connected flanges.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater</i> </li>
</ul>
</HTML>
"),   Icon(
        Line(points=[-100, 0; -55, 0], style(color=58)),
        Line(points=[55, 0; 100, 0], style(color=58)),
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10)),
        Rectangle(extent=[-55, 10; 53, -10], style(
            color=9,
            fillColor=8,
            fillPattern=1)),
        Text(extent=[0, 100; 0, 40], string="%name")),
      Diagram(
        Line(points=[-100, 0; -55, 0], style(color=58)),
        Line(points=[55, 0; 100, 0], style(color=58)),
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10)),
        Rectangle(extent=[-55, 3; 53, -4], style(
            color=9,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-100, -29; -100, -61], style(color=0)),
        Line(points=[100, -61; 100, -28], style(color=0)),
        Line(points=[-98, -60; 98, -60], style(color=0)),
        Polygon(points=[-101, -60; -96, -59; -96, -61; -101, -60], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[100, -60; 95, -61; 95, -59; 100, -60], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-44, -41; 51, -57], string="Length L")));
  equation 
    0 = flange_a.f + flange_b.f;
  end Rod;
  
  model Spring "Linear 1D translational spring" 
    extends Interfaces.Compliant;
    parameter SI.Distance s_rel0=0 "unstretched spring length";
    parameter Real c(
      final unit="N/m",
      final min=0)=  1 "spring constant ";
    
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.21,
        y=0.12,
        width=0.56,
        height=0.64),
      Documentation(info="<html>
<p>
A <i>linear 1D translational spring</i>. The component can be connected either
between two sliding masses, or between
a sliding mass and the housing (model Fixed), to describe
a coupling of the slidin mass with the housing via a spring.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.Spring)</i> </li>
</ul>
</HTML>
"),   Icon(
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10)),
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Text(extent=[0, 110; 0, 50], string="%name"),
        Line(points=[-86, 0; -60, 0; -44, -30; -16, 30; 14, -30; 44, 30; 60, 0;
                84, 0], style(color=0))),
      Diagram(
        Line(points=[-100, 0; -100, 65], style(color=10)),
        Line(points=[100, 0; 100, 65], style(color=10)),
        Line(points=[-100, 60; 100, 60], style(color=10)),
        Polygon(points=[90, 63; 100, 60; 90, 57; 90, 63], style(color=10,
              fillColor=10)),
        Text(
          extent=[-22, 62; 18, 87],
          string="s_rel",
          style(color=3)),
        Line(points=[-86, 0; -60, 0; -44, -30; -16, 30; 14, -30; 44, 30; 60, 0;
                84, 0], style(color=0))));
  equation 
    f = c*(s_rel - s_rel0);
  end Spring;
  
  model Damper "Linear 1D translational damper" 
    extends Interfaces.Compliant;
    parameter Real d(
      final unit="N/ (m/s)",
      final min=0)=  0 "damping constant [N/ (m/s)]";
    SI.Velocity v_rel "relative velocity between flange_a and flange_b";
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.23,
        y=0.05,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p>
<i>Linear, velocity dependent damper</i> element. It can be either connected
between a sliding mass and the housing (model Fixed), or
between two sliding masses.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.Damper)</i> </li>
</ul>
</HTML>
"),   Icon(
        Line(points=[-90, 0; -60, 0], style(color=0)),
        Line(points=[-60, -30; -60, 30], style(color=0)),
        Line(points=[-60, -30; 60, -30], style(color=0)),
        Line(points=[-60, 30; 60, 30], style(color=0)),
        Rectangle(extent=[-60, 30; 30, -30], style(color=0, fillColor=8)),
        Line(points=[30, 0; 90, 0], style(color=0)),
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10)),
        Text(extent=[0, 106; 0, 46], string="%name")),
      Diagram(
        Line(points=[-90, 0; -60, 0], style(color=0)),
        Line(points=[-60, -30; -60, 30], style(color=0)),
        Line(points=[-60, -30; 60, -30], style(color=0)),
        Line(points=[-60, 30; 60, 30], style(color=0)),
        Rectangle(extent=[-60, 30; 30, -30], style(color=0, fillColor=8)),
        Line(points=[30, 0; 90, 0], style(color=0)),
        Line(points=[-50, 60; 50, 60], style(color=10)),
        Polygon(points=[50, 63; 60, 60; 50, 57; 50, 63], style(color=10,
              fillColor=10)),
        Text(
          extent=[-40, 68; 38, 90],
          string="der(s_rel)",
          style(color=10))));
  equation 
    v_rel = der(s_rel);
    f = d*v_rel;
  end Damper;
  
  model SpringDamper "Linear 1D translational spring and damper in parallel" 
    extends Interfaces.Compliant;
    parameter SI.Position s_rel0=0 "unstretched spring length";
    parameter Real c(
      final unit="N/m",
      final min=0)=  1 "spring constant";
    parameter Real d(
      final unit="N/(m/s)",
      final min=0)=  1 "damping constant";
    SI.Velocity v_rel "relative velocity between flange_a and flange_b";
    
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.2,
        y=0.03,
        width=0.64,
        height=0.68),
      Documentation(info="<html>
<p>
A <i>spring and damper element connected in parallel</i>.
The component can be
connected either between two sliding masses to describe the elasticity
and damping, or between a sliding mass and the housing (model Fixed),
to describe a coupling of the sliding mass with the housing via a spring/damper.
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.SpringDamper)</i> </li>
</ul>
</HTML>
"),   Icon(
        Line(points=[-80, 40; -60, 40; -45, 10; -15, 70; 15, 10; 45, 70; 60, 40;
                80, 40], style(color=0)),
        Line(points=[-80, 40; -80, -70], style(color=0)),
        Line(points=[-80, -70; -52, -70], style(color=0)),
        Rectangle(extent=[-52, -49; 38, -91], style(color=0, fillColor=8)),
        Line(points=[-52, -49; 68, -49], style(color=0)),
        Line(points=[-51, -91; 69, -91], style(color=0)),
        Line(points=[38, -70; 80, -70], style(color=0)),
        Line(points=[80, 40; 80, -70], style(color=0)),
        Line(points=[-90, 0; -80, 0], style(color=0)),
        Line(points=[80, 0; 90, 0], style(color=0)),
        Polygon(points=[53, -18; 23, -8; 23, -28; 53, -18], style(color=10,
              fillColor=10)),
        Line(points=[-57, -18; 23, -18], style(color=0, fillColor=10)),
        Text(extent=[1, 140; 1, 80], string="%name")),
      Diagram(
        Line(points=[-80, 32; -58, 32; -43, 2; -13, 62; 17, 2; 47, 62; 62, 32;
              80, 32], style(color=0, thickness=2)),
        Line(points=[-100, 31; -100, 96], style(color=10)),
        Line(points=[100, 29; 100, 94], style(color=10)),
        Line(points=[-98, 82; 100, 82], style(color=10)),
        Polygon(points=[90, 85; 100, 82; 90, 79; 90, 85], style(color=10,
              fillColor=10)),
        Text(
          extent=[-21, 61; 19, 86],
          string="s_rel",
          style(color=3)),
        Rectangle(extent=[-52, -28; 38, -72], style(color=0, fillColor=8)),
        Line(points=[-51, -72; 69, -72], style(color=0)),
        Line(points=[-52, -28; 68, -28], style(color=0)),
        Line(points=[38, -50; 80, -50], style(color=0)),
        Line(points=[-80, -50; -52, -50], style(color=0)),
        Line(points=[-80, 32; -80, -50], style(color=0)),
        Line(points=[80, 32; 80, -50], style(color=0)),
        Line(points=[-90, 0; -80, 0], style(color=0)),
        Line(points=[90, 0; 80, 0], style(color=0))));
  equation 
    v_rel = der(s_rel);
    f = c*(s_rel - s_rel0) + d*v_rel;
  end SpringDamper;
  
  model ElastoGap "1D translational spring damper combination with gap" 
    extends Interfaces.Compliant;
    parameter SI.Position s_rel0=0 "unstretched spring length";
    parameter Real c(
      final unit="N/m",
      final min=0)=  1 "spring constant";
    parameter Real d(
      final unit="N/ (m/s)",
      final min=0)=  1 "damping constant";
    SI.Velocity v_rel "relative velocity between flange_a and flange_b";
    Boolean Contact "false, if s_rel > l ";
    
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.23,
        y=0.04,
        width=0.62,
        height=0.69),
      Documentation(info="<html>
<p>
A <i>linear translational spring damper combination that can lift off</i>.
The component can be connected
between
a sliding mass and the housing (model Fixed), to describe
the contact of a sliding mass with the housing.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater</i> </li>
</ul>
</HTML>
"),   Diagram(
        Line(points=[-100, 0; -50, 0], style(color=58)),
        Line(points=[-48, 34; -48, -46], style(color=0, thickness=4)),
        Line(points=[8, 40; 8, 2], style(color=0)),
        Line(points=[-2, 0; 38, 0; 38, 44; -2, 44], style(color=0)),
        Line(points=[38, 22; 72, 22], style(color=0)),
        Line(points=[-12, -38; -12, 20], style(color=0, thickness=4)),
        Line(points=[-12, 22; 8, 22], style(color=0)),
        Line(points=[-12, -38; -2, -38], style(color=0)),
        Line(points=[72, 0; 90, 0], style(color=58)),
        Line(points=[72, 22; 72, -42], style(color=0)),
        Line(points=[-2, -38; 10, -28; 22, -48; 38, -28; 50, -48; 64, -28; 72,
              -40], style(color=0)),
        Rectangle(extent=[8, 44; 38, 0], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Text(
          extent=[-28, -80; 12, -55],
          string="s_rel",
          style(color=3)),
        Line(points=[-100, -29; -100, -61], style(color=0)),
        Line(points=[100, -61; 100, -28], style(color=0)),
        Line(points=[-98, -60; 98, -60], style(color=0)),
        Polygon(points=[-101, -60; -96, -59; -96, -61; -101, -60], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[100, -60; 95, -61; 95, -59; 100, -60], style(
            color=0,
            fillColor=0,
            fillPattern=1))),
      Icon(
        Line(points=[-100, 0; -50, 0], style(color=58)),
        Line(points=[-48, 34; -48, -46], style(color=0, thickness=4)),
        Line(points=[8, 40; 8, 2], style(color=0)),
        Line(points=[-2, 0; 38, 0; 38, 44; -2, 44], style(color=0)),
        Line(points=[38, 22; 72, 22], style(color=0)),
        Line(points=[-12, -38; -12, 20], style(color=0, thickness=4)),
        Line(points=[-12, 22; 8, 22], style(color=0)),
        Line(points=[-12, -38; -2, -38], style(color=0)),
        Line(points=[74, 0; 100, 0], style(color=58)),
        Line(points=[72, 22; 72, -42], style(color=0)),
        Line(points=[-2, -38; 10, -28; 22, -48; 38, -28; 50, -48; 64, -28; 72,
              -40], style(color=0)),
        Rectangle(extent=[8, 44; 38, 0], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10)),
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Text(extent=[0, 120; 0, 60], string="%name")));
  equation 
    
    v_rel = der(s_rel);
    Contact = s_rel < s_rel0;
    f = if Contact then (c*(s_rel - s_rel0) + d*v_rel) else 0;
  end ElastoGap;
  
  model Position 
    "Forced movement of a flange according to a reference position" 
    parameter Boolean exact=false 
      "true/false exact treatment/filtering the input signal";
    parameter SI.Frequency f_crit=50 
      "if exact=false, critical frequency of filter to filter input signal";
    
    output SI.Position s_ref "reference position defined with the input signal";
    output SI.Position s "absolute position of flange_b";
    output SI.Velocity v "absolute velocity of flange_b";
    output SI.Acceleration a "absolute acceleration of flange_b";
  protected 
    parameter Real w_crit=2*Modelica.Constants.pi*f_crit 
      "critical frequency in [1/s]";
    constant Real af=1.3617 "s coefficient of Bessel filter";
    constant Real bf=0.6180 "s*s coefficient of Bessel filter";
  public 
    Interfaces.Flange_b flange_b annotation( extent=[90, -10; 110, 10]);
    Modelica.Blocks.Interfaces.InPort inPort(final n=1) 
      "Flange position as input signal" annotation( extent=[-140, -20; -100, 20]);
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.33,
        y=0.01,
        width=0.66,
        height=0.62),
      Documentation(info="<HTML>
<p>
The input signal inPort.signal[1] defines the <b>reference
position</b> <b>s_ref</b> in [m]. Flange <b>flange_b</b> is <b>forced</b>
to move according to this reference motion. According to parameter
<b>exact</b> (default = <b>false</b>), this is done in the following way:
<ol>
<li><b>exact=true</b><br>
    The reference position is treated <b>exactly</b>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least twice. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal twice
    in order to compute the reference acceleration of the flange.</li>
<li><b>exact=false</b><br>
    The reference position is <b>filtered</b> and the second derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This second derivative is <b>not</b> computed by
    numerical differentiation but by an appropriate realization of the
    filter. For filtering, a second order Bessel filter is used.
    The critical frequency (also called cut-off frequency) of the
    filter is defined via parameter <b>f_crit</b> in [Hz]. This value
    should be selected in such a way that it is higher as the essential
    low frequencies in the signal.</li>
</ol>

<p>
The input signal can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 19, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>.<br>
       Realized.</li>
</ul>

</HTML>
"),   Icon(
        Text(
          extent=[-80, -20; -80, -80],
          string="s",
          style(color=0)),
        Line(points=[-95, 0; 90, 0], style(color=58)),
        Text(extent=[0, 86; 0, 26], string="%name")),
      Diagram(Polygon(points=[46, -90; 26, -85; 26, -95; 46, -90], style(color=
                10, fillColor=10)), Line(points=[-44, -90; 27, -90], style(
              color=10, fillColor=10))));
  equation 
    s_ref = inPort.signal[1];
    s = flange_b.s;
    v = der(s);
    a = der(v);
    
    if exact then
      s = s_ref;
    else
      // Filter: a = s_ref/(1 + (af/w_crit)*S + (bf/w_crit^2)*S^2)
      a = ((s_ref - s)*w_crit - af*v)*(w_crit/bf);
    end if;
    
  initial equation 
    if not exact then
      s = s_ref;
    end if;
  end Position;
  
  model Accelerate 
    "Forced movement of a flange according to an acceleration signal" 
    parameter SI.Position s_start=0 "Start position";
    parameter SI.Velocity v_start=0 "Start velocity";
    
    SI.Acceleration a "absolute acceleration of flange_b";
    SI.Velocity v(final start=v_start, final fixed=true) 
      "absolute velocity of flange_b";
    SI.Position s(final start=s_start, final fixed=true) 
      "absolute position of flange_b";
    
    Modelica.Blocks.Interfaces.InPort inPort(final n=1) 
      "Connector of input signal used as force" annotation( extent=[-140, -20;
          -100, 20]);
    Interfaces.Flange_b flange_b annotation( extent=[90, -10; 110, 10]);
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.23,
        y=0.07,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p>
The input signal \"a\"  in [m/s2] of connector \"i\" moves the 1D translational flange
connector flange_b with a predefined <i>acceleration</i>, i.e., the flange
is <i>forced</i> to move with this acceleration. The velocity and the
position of the flange are also predefined and are determined by
integration of the acceleration.
</p>

<p>
The acceleration \"a(t)\" can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Source.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.AccMotion)</i> </li>
</ul>
</HTML>
"),   Icon(
        Line(points=[-95, 0; 90, 0], style(color=58)),
        Text(
          extent=[-80, -20; -80, -80],
          string="a",
          style(color=0)),
        Text(extent=[0, 80; 0, 20], string="%name")),
      Diagram(Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=
               10, fillColor=10)), Line(points=[-60, -90; 20, -90], style(color=
               0, fillColor=10))));
  equation 
    s = flange_b.s;
    v = der(s);
    a = der(v);
    a = inPort.signal[1];
  end Accelerate;
  
  model Move 
    "Forced movement of a flange according to a position, velocity and acceleration signal"
    
    
    SI.Position s "absolute position of flange_b";
    SI.Velocity v "absolute velocity of flange_b";
    SI.Acceleration a "absolute acceleration of flange_b";
    
  protected 
    Real constraintResidue;
    Real constraintResidue_d;
    Real constraintResidue_dd;
  public 
    Modelica.Blocks.Interfaces.InPort inPort(final n=3) annotation( extent=[-
          140, -20; -100, 20]);
    Interfaces.Flange_b flange_b annotation( extent=[90, -10; 110, 10]);
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Documentation(info="<html>
<p>
Flange <b>flange_b</b> is <b>forced</b> to move with a predefined motion
according to the input signals:
</p>

<pre>
    inPort.signal[1]: position of flange
    inPort.signal[2]: velocity of flange
    inPort.signal[3]: acceleration of flange
</pre>

<p>
The user has to guarantee that the input signals are consistent to each other,
i.e., that inPort.signal[2] is the derivative of inPort.signal[1] and that
inPort.signal[3] is the derivative of inPort.signal[2]. There are, however,
also applications where by purpose these conditions do not hold. For example,
if only the position dependent terms of a mechanical system shall be
calculated, one may provide position = position(t) and set the velocity
and the acceleration to zero.
</p>

<p>
The input signals can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>

<p>
Note, this model utilizes the non-standard function <b>constrain(..)</b>
and assumes that this function is supported by the Modelica translator:
</p>
<pre>
   Real r[:], rd[:], rdd[:];
      ...
   r   = ..
   rd  = ...
   rdd = ...
   constrain(r,rd,rdd);
</pre>
<p>
where r, rd and rdd are variables which need to be computed
somewhere else. A simple implementation of constrain() is:
</p>

<pre>
   r = 0;
</pre>

<p>
However, this implementation requires that r(t) is given as analytical,
smooth function in order that it can be differentiated and it does
not allow applications such as the one sketched above.
Function constrain()
is used to explicitly inform the Modelica translator that
rd is the derivative of r and rdd is the derivative of rd
and that all derivatives need to be identical to zero.
The Modelica translator can utilize this information to use
rd and rdd whenever the Pantelides algorithm requires to compute
the derivatives of r (and takes rd and rdd instead of actually
differentiating r).
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 25, 2001</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       realized.</li>
</ul>

</HTML>
"),   Diagram(Polygon(points=[0, -90; -20, -85; -20, -95; 0, -90], style(color=
                10, fillColor=10)), Line(points=[-90, -90; -19, -90], style(
              color=10, fillColor=10))),
      Icon(
        Text(
          extent=[-140, -62; 20, -100],
          string="phi,w,a",
          style(color=0)),
        Line(points=[-95, 0; 90, 0], style(color=58)),
        Text(extent=[0, 80; 0, 20], string="%name")),
      Window(
        x=0.27,
        y=0.05,
        width=0.6,
        height=0.6));
  equation 
    s = flange_b.s;
    v = der(s);
    a = der(v);
    
    constraintResidue = inPort.signal[1] - s;
    constraintResidue_d = inPort.signal[2] - v;
    constraintResidue_dd = inPort.signal[3] - a;
    constrain(constraintResidue, constraintResidue_d, constraintResidue_dd);
  end Move;
  
  model Fixed "Fixed flange" 
    parameter SI.Position s0=0 "fixed offset position of housing";
    
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.41,
        y=0.02,
        width=0.42,
        height=0.58),
      Icon(
        Line(points=[-80, -40; 80, -40], style(color=0)),
        Line(points=[80, -40; 40, -80], style(color=0)),
        Line(points=[40, -40; 0, -80], style(color=0)),
        Line(points=[0, -40; -40, -80], style(color=0)),
        Line(points=[-40, -40; -80, -80], style(color=0)),
        Line(points=[0, -40; 0, -10], style(color=0)),
        Text(extent=[0, -90; 0, -150], string="%name")),
      Diagram(
        Line(points=[-80, -40; 80, -40], style(color=0)),
        Line(points=[80, -40; 40, -80], style(color=0)),
        Line(points=[40, -40; 0, -80], style(color=0)),
        Line(points=[0, -40; -40, -80], style(color=0)),
        Line(points=[-40, -40; -80, -80], style(color=0)),
        Line(points=[0, -40; 0, -10], style(color=0)),
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10))),
      Documentation(info="<html>
<p>
The <i>flange</i> of a 1D translational mechanical system <i>fixed</i>
at an position s0 in the <i>housing</i>. May be used:
</p>

<ul>
<li> to connect a compliant element, such as a spring or a damper,
     between a sliding mass and the housing.

<li> to fix a rigid element, such as a sliding mass, at a specific
     position.
</ul>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.LockedR)</i> </li>
</ul>
</HTML>
"));
    Interfaces.Flange_b flange_b annotation( extent=[-10, -10; 10, 10],
        rotation=180);
  equation 
    flange_b.s = s0;
  end Fixed;
  
  model Force "External force acting on a drive train element as input signal" 
    
    SI.Force f "driving force";
    
    Interfaces.Flange_b flange_b annotation( extent=[90, -10; 110, 10]);
    Modelica.Blocks.Interfaces.InPort inPort(final n=1) 
      "Connector of input signal used as force" annotation( extent=[-140, -20;
          -100, 20]);
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.05,
        y=0.01,
        width=0.69,
        height=0.83),
      Documentation(info="<html>
<p>
The input signal \"s\" in [N] characterizes an <i>external
force</i> which acts (with positive sign) at a flange,
i.e., the component connected to the flange is driven by force f.
</p>


<p>
Input signal s can be provided from one of the signal generator
blocks of Modelica.Blocks.Source.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.Torque1D)</i> </li>
</ul>
</HTML>
"),   Icon(
        Polygon(points=[-100, 10; 20, 10; 20, 41; 90, 0; 20, -41; 20, -10; -100,
                -10; -100, 10], style(color=10, fillColor=58)),
        Text(
          extent=[-100, -40; -47, -88],
          string="f",
          style(color=0)),
        Text(extent=[0, 109; 0, 49], string="%name")),
      Diagram(
        Polygon(points=[50, -90; 20, -80; 20, -100; 50, -90], style(color=10,
              fillColor=10)),
        Line(points=[-60, -90; 20, -90], style(color=0, fillColor=10)),
        Polygon(points=[-100, 10; 20, 10; 20, 41; 90, 0; 20, -41; 20, -10; -100,
                -10; -100, 10], style(color=10, fillColor=58))));
  equation 
    f = inPort.signal[1];
    flange_b.f = -f;
  end Force;
  
  model RelativeStates "Definition of relative state variables" 
    extends Interfaces.TwoFlanges;
    SI.Position s_rel(stateSelect=StateSelect.prefer) 
      "relative position used as state variable";
    SI.Velocity v_rel(stateSelect=StateSelect.prefer) 
      "relative velocity used as state variable";
    SI.Acceleration a_rel "relative angular acceleration";
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.23,
        y=0.02,
        width=0.72,
        height=0.83),
      Documentation(info="<html>
<p>
Usually, the absolute position and the absolute velocity of
Modelica.Mechanics.Translational.Inertia models are used as state variables.
In some circumstances, relative quantities are better suited, e.g.,
because it may be easier to supply initial values.
In such cases, model <b>RelativeStates</b> allows the definition of state variables
in the following way:
</p>

<ul>
<li> Connect an instance of this model between two flange connectors.</li>
<li> The <b>relative position</b> and the <b>relative velocity</b>
     between the two connectors are used as <b>state variables</b>.
</ul>

<p>
An example is given in the next figure
</p>

<IMG SRC=\"../Images/relativeStates2.png\" ALT=\"relativeStates2\">

<p>
Here, the relative position and the relative velocity between
the two masses are used as state variables. Additionally, the
simulator selects either the absolute position and absolute
velocity of model mass1 or of model mass2 as state variables.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 19, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>
</HTML>
"),   Icon(
        Ellipse(extent=[-40, 40; 40, -40], style(color=4, fillColor=4)),
        Text(extent=[-40, 40; 40, -40], string="S"),
        Line(points=[-92, 0; -42, 0], style(color=0, pattern=3)),
        Line(points=[40, 0; 90, 0], style(
            color=0,
            pattern=3,
            fillColor=4)),
        Text(extent=[0, 110; 0, 50], string="%name")),
      Diagram(
        Ellipse(extent=[-40, 40; 40, -40], style(color=4, fillColor=4)),
        Text(extent=[-40, 40; 40, -40], string="S"),
        Line(points=[40, 0; 90, 0], style(
            color=0,
            pattern=2,
            fillColor=4)),
        Line(points=[-100, -10; -100, -80], style(color=9)),
        Line(points=[100, -10; 100, -80], style(color=9)),
        Polygon(points=[80, -65; 80, -55; 100, -60; 80, -65], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Line(points=[-100, -60; 80, -60], style(color=9)),
        Text(extent=[-30, -70; 30, -90], string="w_rel"),
        Line(points=[-76, 80; -5, 80], style(color=10, fillColor=10)),
        Polygon(points=[14, 80; -6, 85; -6, 75; 14, 80], style(color=10,
              fillColor=10)),
        Text(
          extent=[18, 87; 86, 74],
          string="rotation axis",
          style(color=10)),
        Line(points=[-90, 0; -40, 0], style(
            color=0,
            pattern=2,
            fillColor=4))));
  equation 
    s_rel = flange_b.s - flange_a.s;
    v_rel = der(s_rel);
    a_rel = der(v_rel);
    flange_a.f = 0;
    flange_b.f = 0;
  end RelativeStates;
  
  package Sensors "Sensor for 1D translational mechanical quantities" 
    
    extends Modelica.Icons.Library2;
    
    annotation(
      Window(
        x=0.08,
        y=0.16,
        width=0.23,
        height=0.39,
        library=1,
        autolayout=1),
      Icon(
        Rectangle(extent=[-76, -81; 64, -1], style(color=0, fillColor=7)),
        Polygon(points=[-6, -61; -16, -37; 4, -37; -6, -61], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-6, -21; -6, -37], style(color=0)),
        Line(points=[-76, -21; -6, -21], style(color=0)),
        Line(points=[-56, -61; -56, -81], style(color=0)),
        Line(points=[-36, -61; -36, -81], style(color=0)),
        Line(points=[-16, -61; -16, -81], style(color=0)),
        Line(points=[4, -61; 4, -81], style(color=0)),
        Line(points=[24, -61; 24, -81], style(color=0)),
        Line(points=[44, -61; 44, -81], style(color=0))));
    model ForceSensor "Ideal sensor to measure the force between two flanges" 
      extends Interfaces.RelativeSensor;
      SI.Force f 
        "force in flange_a and flange_b (f = flange_a.f = -flange_b.f)";
      annotation(
        Documentation(info="<html>
<p>
Measures the <i>cut-force between two flanges</i> in an ideal way
and provides the result as output signal (to be further processed
with blocks of the Modelica.Blocks library).
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater</i> </li>
</ul>
</HTML>
"),     Icon(Text(
            extent=[40, -70; 120, -120],
            string="f",
            style(color=0))),
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.27,
          y=0.08,
          width=0.6,
          height=0.6));
    equation 
      flange_a.s = flange_b.s;
      flange_a.f = f;
      flange_b.f = -f;
      f = outPort.signal[1];
    end ForceSensor;
    
    model PositionSensor "Ideal sensor to measure the absolute position" 
      extends Modelica.Icons.TranslationalSensor;
      
      SI.Position s "Absolute position of flange";
      
      Interfaces.Flange_a flange_a 
        "(left) flange to be measured (flange axis directed INTO cut plane, e. g. from left to right)"
         annotation( extent=[-110, -10; -90, 10]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=1) annotation( extent=
            [100, -10; 120, 10]);
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.04,
          y=0.05,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
Measures the <i>absolute position s</i> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater</i> </li>
</ul>
</HTML>
"),     Icon(
          Line(points=[-70, 0; -90, 0], style(color=0)),
          Line(points=[70.4, 0; 100, 0]),
          Text(
            extent=[80, -28; 114, -62],
            string="s",
            style(color=0)),
          Text(extent=[0, 100; 0, 40], string="%name")),
        Diagram(Line(points=[100, 0; 70, 0]), Line(points=[-70, 0; -92, 0],
              style(color=53))));
    equation 
      s = flange_a.s;
      s = outPort.signal[1];
      0 = flange_a.f;
    end PositionSensor;
    
    model SpeedSensor "Ideal sensor to measure the absolute velocity" 
      extends Modelica.Icons.TranslationalSensor;
      SI.Position s "Absolute position of flange";
      SI.Velocity v "Absolute velocity of flange";
      
      Interfaces.Flange_a flange_a 
        "(left) flange to be measured (flange axis directed INTO cut plane, e. g. from left to right)"
         annotation( extent=[-110, -10; -90, 10]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=1) annotation( extent=
            [100, -10; 120, 10]);
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.04,
          y=0.05,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
Measures the <i>absolute velocity v</i> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater</i> </li>
</ul>
</HTML>
"),     Icon(
          Line(points=[-70, 0; -90, 0], style(color=0)),
          Line(points=[70.4, 0; 100, 0]),
          Text(
            extent=[80, -28; 111, -61],
            string="v",
            style(color=0)),
          Text(extent=[0, 100; 0, 40], string="%name")),
        Diagram(Line(points=[-70, 0; -90, 0], style(color=53)), Line(points=[
                100, 0; 70, 0], style(color=0))));
    equation 
      s = flange_a.s;
      v = der(s);
      v = outPort.signal[1];
      0 = flange_a.f;
    end SpeedSensor;
    
    model AccSensor "Ideal sensor to measure the absolute acceleration" 
      extends Modelica.Icons.TranslationalSensor;
      SI.Velocity v "Absolute velocity of flange";
      SI.Acceleration a "Absolute acceleration of a flange";
      
      Interfaces.Flange_a flange_a 
        "(left) flange to be measured (flange axis directed INTO cut plane, e. g. from left to right)"
         annotation( extent=[-110, -10; -90, 10]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=1) annotation( extent=
            [100, -10; 120, 10]);
      annotation(
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.14,
          y=0.08,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
Measures the <i>absolute acceleration a</i>
of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater</i> </li>
</ul>
</HTML>
"),     Icon(
          Line(points=[-70, 0; -90, 0], style(color=0)),
          Line(points=[70.4, 0; 100, 0]),
          Text(
            extent=[80, -28; 115, -60],
            string="a",
            style(color=0)),
          Text(extent=[0, 100; 0, 40], string="%name")),
        Diagram(Line(points=[-70, 0; -90, 0], style(color=53)), Line(points=[
                100, 0; 70, 0])));
    equation 
      v = der(flange_a.s);
      a = der(v);
      a = outPort.signal[1];
      0 = flange_a.f;
    end AccSensor;
  end Sensors;
end Translational;
