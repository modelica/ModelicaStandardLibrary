package RobotR3 
  "Library to demonstrate robot system models based on the Manutec r3 robot" 
  
  model oneAxis 
    "Model of one axis of robot (controller, motor, gearbox) with simple load" 
    
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Example;
    parameter SI.Mass mLoad=15 "mass of load";
    parameter Real kp=5 "gain of position controller of axis 2";
    parameter Real ks=0.5 "gain of speed controller of axis 2";
    parameter SI.Time Ts=0.05 
      "time constant of integrator of speed controller of axis 2";
    parameter Real startAngle(unit="deg") = 0 "start angle of axis 2";
    parameter Real endAngle(unit="deg") = 120 "end angle of axis 2";
    
    parameter SI.Time swingTime=0.5 
      "additional time after reference motion is in rest before simulation is stopped";
    parameter SI.AngularVelocity refSpeedMax=3 "maximum reference speed";
    parameter SI.AngularAcceleration refAccMax=10 
      "maximum reference acceleration";
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.13,
        y=0.11,
        width=0.58,
        height=0.66),
      Documentation(info="<HTML>
<p>
With this model one axis of the r3 robot is checked.
The mechanical structure is replaced by a simple
load inertia.
</p>
</HTML>
"),   Diagram,
      experiment(StopTime=1.6),
      Commands(file="oneAxisPlot.mos" "plot"));
    
    Components.AxisType1 axis(
      w=5500,
      ratio=210,
      c=8,
      cd=0.01,
      Rv0=0.5,
      Rv1=(0.1/130),
      kp=kp,
      ks=ks,
      Ts=Ts) annotation (extent=[20, 0; 40, 20]);
    Modelica.Mechanics.Rotational.Inertia load(J=1.3*mLoad) 
      annotation (extent=[54, 0; 74, 20]);
    RobotR3.Components.PathPlanning path(
      naxis=1,
      startTime=0,
      swingTime=swingTime,
      angleBegDeg={startAngle},
      angleEndDeg={endAngle},
      speedMax={refSpeedMax},
      accMax={refAccMax}) annotation (extent=[-50, 0; -30, 20]);
  protected 
    RobotR3.Components.Bus bus(naxis=1) 
      annotation (extent=[-3, 0; 0, 40], rotation=90);
  equation 
    connect(axis.flange, load.flange_a) 
      annotation (points=[41, 10; 54, 10], style(color=10, thickness=2));
    connect(axis.bus, bus.axis[1]) 
      annotation (points=[19, 10; -1, 10], style(color=77));
    connect(path.bus, bus) 
      annotation (points=[-29, 10; -2, 10; -2, 20; -1.5, 20], style(color=77));
  end oneAxis;
  
  model fullRobot 
    "6 degree of freedom robot with path planning, controllers, motors, brakes, gears and mechanics" 
    
    annotation (
      Diagram,
      Coordsys(grid=[0.5, 0.5], component=[20, 20]),
      Icon(
        Rectangle(extent=[-99.5, 100; 100, -100], style(color=0, fillColor=8)),
        Bitmap(extent=[-75.5, 98.25; 87, -96.75], name=
              "../../../../Images/MultiBody/Examples/Systems/robot_kr15.bmp"),
        Text(extent=[-111.5, 130; 108.5, 100], string="%name"),
        Text(
          extent=[-104.5, -104; 115, -128],
          string="mLoad=%mLoad",
          style(color=0))),
      experiment(StopTime=3),
      Commands(file="fullRobotPlot.mos" "plot"),
      Documentation(info="<HTML>
<p>
This is a detailed model of the robot. For animation CAD data
is used. Translate and simulate with the default settings
(default simulation time = 3 s). Use command script \"Scripts\\ExamplesfullRobotPlot.mos\"
to plot variables.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Systems/r3_fullRobot.png\" ALT=\"model Examples.Loops.Systems.RobotR3.fullRobot\">
</p>
</HTML>"));
    
    import SI = Modelica.SIunits;
    
    parameter SI.Mass mLoad=15 "mass of load";
    parameter SI.Position rLoad[3]={0.1,0.25,0.1} 
      "distance from last flange to load mass";
    parameter SI.Acceleration g=9.81 "gravity acceleration";
    parameter SI.Time refStartTime=0 "start time of reference motion";
    parameter SI.Time refSwingTime=0.7 
      "additional time after reference motion is in rest before simulation is stopped";
    
    parameter Real startAngle1(unit="deg") = -60 
      "|Reference|startAngles| start angle of axis 1";
    parameter Real startAngle2(unit="deg") = 20 
      "|Reference|startAngles| start angle of axis 2";
    parameter Real startAngle3(unit="deg") = 90 
      "|Reference|startAngles| start angle of axis 3";
    parameter Real startAngle4(unit="deg") = 0 
      "|Reference|startAngles| start angle of axis 4";
    parameter Real startAngle5(unit="deg") = -110 
      "|Reference|startAngles| start angle of axis 5";
    parameter Real startAngle6(unit="deg") = 0 
      "|Reference|startAngles| start angle of axis 6";
    
    parameter Real endAngle1(unit="deg") = 60 
      "|Reference|endAngles| end angle of axis 1";
    parameter Real endAngle2(unit="deg") = -70 
      "|Reference|endAngles| end angle of axis 2";
    parameter Real endAngle3(unit="deg") = -35 
      "|Reference|endAngles| end angle of axis 3";
    parameter Real endAngle4(unit="deg") = 45 
      "|Reference|endAngles| end angle of axis 4";
    parameter Real endAngle5(unit="deg") = 110 
      "|Reference|endAngles| end angle of axis 5";
    parameter Real endAngle6(unit="deg") = 45 
      "|Reference|endAngles| end angle of axis 6";
    
    parameter SI.AngularVelocity refSpeedMax[6]={3,1.5,5,3.1,3.1,4.1} 
      "|Reference|Limits| Maximum reference speeds of all joints";
    parameter SI.AngularAcceleration refAccMax[6]={15,15,15,60,60,60} 
      "|Reference|Limits| Maximum reference accelerations of all joints";
    
    parameter Real kp1=5 "|Controller|Axis 1| gain of position controller";
    parameter Real ks1=0.5 "|Controller|Axis 1| gain of speed controller";
    parameter SI.Time Ts1=0.05 
      "|Controller|Axis 1| time constant of integrator of speed controller";
    parameter Real kp2=5 "|Controller|Axis 2| gain of position controller";
    parameter Real ks2=0.5 "|Controller|Axis 2| gain of speed controller";
    parameter SI.Time Ts2=0.05 
      "|Controller|Axis 2| time constant of integrator of speed controller";
    parameter Real kp3=5 "|Controller|Axis 3| gain of position controller";
    parameter Real ks3=0.5 "|Controller|Axis 3| gain of speed controller";
    parameter SI.Time Ts3=0.05 
      "|Controller|Axis 3| time constant of integrator of speed controller";
    parameter Real kp4=5 "|Controller|Axis 4| gain of position controller";
    parameter Real ks4=0.5 "|Controller|Axis 4| gain of speed controller";
    parameter SI.Time Ts4=0.05 
      "|Controller|Axis 4| time constant of integrator of speed controller";
    parameter Real kp5=5 "|Controller|Axis 5| gain of position controller";
    parameter Real ks5=0.5 "|Controller|Axis 5| gain of speed controller";
    parameter SI.Time Ts5=0.05 
      "|Controller|Axis 5| time constant of integrator of speed controller";
    parameter Real kp6=5 "|Controller|Axis 6| gain of position controller";
    parameter Real ks6=0.5 "|Controller|Axis 6| gain of speed controller";
    parameter SI.Time Ts6=0.05 
      "|Controller|Axis 6| time constant of integrator of speed controller";
    Components.MechanicalStructure mechanics(
      mLoad=mLoad,
      rLoad=rLoad,
      g=g) annotation (extent=[35, -35; 95, 25]);
    RobotR3.Components.PathPlanning path(
      naxis=6,
      angleBegDeg={startAngle1,startAngle2,startAngle3,startAngle4,startAngle5,
          startAngle6},
      angleEndDeg={endAngle1,endAngle2,endAngle3,endAngle4,endAngle5,endAngle6},
      speedMax=refSpeedMax,
      accMax=refAccMax,
      startTime=refStartTime,
      swingTime=refSwingTime) annotation (extent=[-80, -25; -60, -5]);
    
    RobotR3.Components.AxisType1 axis1(
      w=4590,
      ratio=-105,
      c=43,
      cd=0.005,
      Rv0=0.4,
      Rv1=(0.13/160),
      kp=kp1,
      ks=ks1,
      Ts=Ts1) annotation (extent=[-25, -55; -5, -75]);
    RobotR3.Components.AxisType1 axis2(
      w=5500,
      ratio=210,
      c=8,
      cd=0.01,
      Rv1=(0.1/130),
      Rv0=0.5,
      kp=kp2,
      ks=ks2,
      Ts=Ts2) annotation (extent=[-25, -35; -5, -55]);
    
    RobotR3.Components.AxisType1 axis3(
      w=5500,
      ratio=60,
      c=58,
      cd=0.04,
      Rv0=0.7,
      Rv1=(0.2/130),
      kp=kp3,
      ks=ks3,
      Ts=Ts3) annotation (extent=[-25, -15; -5, -35]);
    RobotR3.Components.AxisType2 axis4(
      k=0.2365,
      w=6250,
      D=0.55,
      J=1.6e-4,
      ratio=-99,
      Rv0=21.8,
      Rv1=9.8,
      peak=26.7/21.8,
      kp=kp4,
      ks=ks4,
      Ts=Ts4) annotation (extent=[-25, 5; -5, -15]);
    RobotR3.Components.AxisType2 axis5(
      k=0.2608,
      w=6250,
      D=0.55,
      J=1.8e-4,
      ratio=79.2,
      Rv0=30.1,
      Rv1=0.03,
      peak=39.6/30.1,
      kp=kp5,
      ks=ks5,
      Ts=Ts5) annotation (extent=[-25, 25; -5, 5]);
    RobotR3.Components.AxisType2 axis6(
      k=0.0842,
      w=7400,
      D=0.27,
      J=4.3e-5,
      ratio=-99,
      Rv0=10.9,
      Rv1=3.92,
      peak=16.8/10.9,
      kp=kp6,
      ks=ks6,
      Ts=Ts6) annotation (extent=[-25, 45; -5, 25]);
  protected 
    RobotR3.Components.Bus bus(naxis=6) 
      annotation (extent=[-42.5, -75; -40, 45.5], rotation=90);
  equation 
    connect(axis2.flange, mechanics.axis2) annotation (points=[-4, -45; 25, -45;
           25, -21.5; 33.5, -21.5], style(color=0));
    connect(path.bus, bus) annotation (points=[-59, -15; -41.25, -15; -41.25, -14.75],
         style(color=77));
    connect(axis2.bus, bus.axis[2]) 
      annotation (points=[-26, -45; -40, -45], style(color=77));
    connect(axis1.bus, bus.axis[1]) 
      annotation (points=[-26, -65; -40, -65], style(color=77));
    connect(axis3.bus, bus.axis[3]) 
      annotation (points=[-26, -25; -40, -25], style(color=77));
    connect(axis4.bus, bus.axis[4]) 
      annotation (points=[-26, -5; -40, -5], style(color=77));
    connect(axis5.bus, bus.axis[5]) 
      annotation (points=[-26, 15; -40, 15], style(color=77));
    connect(axis6.bus, bus.axis[6]) 
      annotation (points=[-26, 35; -40, 35], style(color=77));
    connect(axis1.flange, mechanics.axis1) annotation (points=[-4, -65; 30, -65;
           30, -30.5; 33.5, -30.5], style(color=0));
    connect(axis3.flange, mechanics.axis3) annotation (points=[-4, -25; 15, -25;
           15, -12.5; 33.5, -12.5], style(color=0));
    connect(axis4.flange, mechanics.axis4) annotation (points=[-4, -5; 15, -5;
          15, -3.5; 33.5, -3.5], style(color=0));
    connect(axis5.flange, mechanics.axis5) 
      annotation (points=[-4, 15; 10, 15; 10, 5.5; 33.5, 5.5], style(color=0));
    connect(axis6.flange, mechanics.axis6) annotation (points=[-4, 35; 20, 35;
          20, 14.5; 33.5, 14.5], style(color=0));
  end fullRobot;
  extends Modelica.Icons.Library;
  import SI = Modelica.SIunits;
  
  package Components "Library of components of the robot" 
    extends Modelica.Icons.Library;
    
    connector AxisBus "Data bus for one robot axis" 
      import Modelica.Blocks.Interfaces;
      Interfaces.BooleanSignal motion_ref 
        "true, if reference motion is not in rest";
      Interfaces.RealSignal angle_ref(redeclare type SignalType = SI.Angle) 
        "reference angle of axis flange";
      Interfaces.RealSignal angle(redeclare type SignalType = SI.Angle) 
        "angle of axis flange";
      Interfaces.RealSignal speed_ref(redeclare type SignalType = 
            SI.AngularVelocity) "reference speed of axis flange";
      Interfaces.RealSignal speed(redeclare type SignalType = 
            SI.AngularVelocity) "speed of axis flange";
      Interfaces.RealSignal acceleration_ref(redeclare type SignalType = 
            SI.AngularAcceleration) "reference acceleration of axis flange";
      Interfaces.RealSignal acceleration(redeclare type SignalType = 
            SI.AngularAcceleration) "acceleration of axis flange";
      Interfaces.RealSignal current_ref(redeclare type SignalType = SI.Current)
        "reference current of motor";
      Interfaces.RealSignal current(redeclare type SignalType = SI.Current) 
        "current of motor";
      Interfaces.RealSignal motorAngle(redeclare type SignalType = SI.Angle) 
        "angle of motor flange";
      Interfaces.RealSignal motorSpeed(redeclare type SignalType = 
            SI.AngularVelocity) "speed of motor flange";
      annotation (
        Icon(Rectangle(extent=[-100, 100; 100, -100], style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-134, 168; 134, 108],
            string="%name",
            style(color=77))),
        Diagram(Text(
            extent=[-134, 168; 134, 108],
            string="%name",
            style(color=77)), Rectangle(extent=[-100, 100; 100, -100], style(
              color=77,
              fillColor=77,
              fillPattern=1))),
        Documentation(info="<HTML>
<p>Defines connector for signalbus.</p>
</HTML>
"));
    end AxisBus;
    
    connector Bus "Data bus for all axes of robot" 
      parameter Integer naxis=6;
      AxisBus axis[naxis];
      
      annotation (
        Icon(Rectangle(extent=[-100, 100; 100, -100], style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-134, 168; 134, 108],
            string="%name",
            style(color=77))),
        Diagram(Text(
            extent=[-138, 168; 130, 108],
            string="%name",
            style(color=77)), Rectangle(extent=[-100, 100; 100, -100], style(
              color=77,
              fillColor=77,
              fillPattern=1))),
        Documentation(info="<HTML>
<p>Defines connector for signalbus.</p>
</HTML>
"));
    end Bus;
    
    model PathPlanning 
      "Generate reference angles for fastest kinematic movement" 
      
      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
      parameter Integer naxis=6 "number of driven axis";
      parameter Real angleBegDeg[naxis](unit="deg") = zeros(naxis) 
        "start angles";
      parameter Real angleEndDeg[naxis](unit="deg") = ones(naxis) "end angles";
      parameter SI.AngularVelocity speedMax[naxis]=fill(3, naxis) 
        "maximum axis speed";
      parameter SI.AngularAcceleration accMax[naxis]=fill(2.5, naxis) 
        "maximum axis acceleration";
      parameter SI.Time startTime=0 "start time of movement";
      parameter SI.Time swingTime=0.5 
        "additional time after reference motion is in rest before simulation is stopped";
      Boolean motion_ref "True if reference motions of all axes is not in rest";
      final parameter SI.Angle angleBeg[:]=Cv.from_deg(angleBegDeg) 
        "start angles";
      final parameter SI.Angle angleEnd[:]=Cv.from_deg(angleEndDeg) 
        "end angles";
      constant Real eps=100*Modelica.Constants.eps;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-100, 100; 100, -100], style(color=0, fillColor=7)),
          Text(extent=[-119, 178; 121, 102], string="%name"),
          Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 88; -80, 90], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Line(points=[-80, 78; -80, -82], style(color=8)),
          Line(points=[-90, 0; 82, 0], style(color=8)),
          Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Text(
            extent=[-42, 55; 29, 12],
            string="w",
            style(color=8)),
          Line(points=[-80, 0; -41, 69; 26, 69; 58, 0], style(color=0))),
        Window(
          x=0.03,
          y=0,
          width=0.88,
          height=0.79),
        Documentation(info="Given
- start and end angles of every axis
- maximum speed of every axis
- maximum acceleration of every axis
this component computes the fastest movement under the
given constraints. This means, that:
1. Every axis accelerates with the maximum acceleration
   until the maximum speed is reached.
2. Drives with the maximum speed as long as possible.
3. Decelerates with the negative of the maximum acceleration
   until rest.
The acceleration, constant velocity and deceleration
phase are determined in such a way that the movement
starts form the start angles and ends at the end angles.
The output of this block are the computed angles and the
computed angular speeds as function of time. The ordering is:
   reference[1] = reference angle 1
            [2] = reference speed 1
            [3] = reference angle 2
            [4] = reference speed 2
                  ...
"),     Diagram);
      
    public 
      RobotR3.Components.Bus bus(naxis=naxis) 
        annotation (extent=[100, -10; 120, 10]);
      RobotR3.Components.KinematicPTPc kinematicPTP(
        q_end=angleEnd,
        qd_max=speedMax,
        qdd_max=accMax,
        startTime=startTime,
        q_begin=angleBeg) annotation (extent=[-10, -10; 10, 10]);
    equation 
      motion_ref = time <= kinematicPTP.endTime;
      for i in 1:naxis loop
        bus.axis[i].angle_ref = kinematicPTP.q[i];
        bus.axis[i].speed_ref = kinematicPTP.qd[i];
        bus.axis[i].acceleration_ref = kinematicPTP.qdd[i];
        bus.axis[i].motion_ref = if abs(angleBeg[i] - angleEnd[i]) > eps then 
          motion_ref else false;
      end for;
      
      when time >= kinematicPTP.endTime + swingTime then
        terminate("end condition reached");
      end when;
    end PathPlanning;
    
    model GearType1 "Motor inertia and gearbox model for r3 joints 1,2,3 " 
      extends Modelica.Mechanics.Rotational.Interfaces.TwoFlanges;
      parameter Real i=-105 "gear ratio";
      parameter Real c(unit="N.m/rad") = 43 "spring constant";
      parameter Real d(unit="N.m.s/rad") = 0.005 "damper constant";
      parameter SI.Torque Rv0=0.4 "viscous friction torque at zero velocity";
      parameter Real Rv1(unit="N.m.s/rad") = (0.13/160) 
        "viscous friction coefficient (R=Rv0+Rv1*abs(qd))";
      parameter Real peak=1 
        "peak*Rv0 = maximum static friction torque (peak >= 1)";
      SI.AngularAcceleration a_rel=der(spring.w_rel) 
        "Relative angular acceleration of spring";
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.22,
          y=0,
          width=0.71,
          height=0.71),
        Documentation(info="
Models the gearbox used in the first three joints with all its effects,
like elasticity and friction.
Coulomb friction is approximated by a friction element acting
at the \"motor\"-side. In reality, bearing friction should be
also incorporated at the driven side of the gearbox. However,
this would require considerable more effort for the measurement
of the friction parameters.
Default values for all parameters are given for joint 1.
Model relativeStates is used to define the relative angle
and relative angular velocity across the spring (=gear elasticity)
as state variables. The reason is, that a default initial
value of zero of these states makes always sense.
If the absolute angle and the absolute angular velocity of model
Jmotor would be used as states, and the load angle (= joint angle of
robot) is NOT zero, one has always to ensure that the initial values
of the motor angle and of the joint angle are modified correspondingly.
Otherwise, the spring has an unrealistic deflection at initial time.
Since relative quantities are used as state variables, this simplifies
the definition of initial values considerably.
"),     Icon(
          Rectangle(extent=[-100,10; -60,-10],  style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, 10; -60, 20; -40, 40; -40, -40; -60, -20; -60,
                10], style(
              color=10,
              gradient=2,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[-40, 60; 40, -60], style(
              color=3,
              pattern=1,
              thickness=1,
              gradient=2,
              arrow=0,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[60, 20; 40, 40; 40, -40; 60, -20; 60, 20], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[60,10; 100,-10],  style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, -90; -50, -90; -20, -30; 20, -30; 48, -90; 60, -90;
                 60, -100; -60, -100; -60, -90], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Text(extent=[0, 128; 0, 68], string="%name"),
          Text(extent=[-36, 40; 36, -30], string="1")),
        Diagram(Text(
            extent=[72, 30; 130, 22],
            string="flange of joint axis",
            style(color=0)), Text(
            extent=[-128, 26; -70, 18],
            string="flange of motor axis",
            style(color=0))));
      
      Modelica.Mechanics.Rotational.IdealGear gear(ratio=i) 
        annotation (extent=[50, -10; 70, 10]);
      Modelica.Mechanics.Rotational.SpringDamper spring(c=c, d=d) 
        annotation (extent=[0, -10; 20, 10]);
      Modelica.Mechanics.Rotational.BearingFriction bearingFriction(tau_pos=[0,
             Rv0; 1, Rv0 + Rv1]) annotation (extent=[-60, -10; -40, 10]);
    equation 
      connect(spring.flange_b, gear.flange_a) 
        annotation (points=[20, 0; 50, 0], style(color=10, thickness=2));
      connect(bearingFriction.flange_b, spring.flange_a) 
        annotation (points=[-40, 0; 0, 0], style(color=10, thickness=2));
      connect(gear.flange_b, flange_b) 
        annotation (points=[70, 0; 100, 0], style(color=10, thickness=2));
      connect(bearingFriction.flange_a, flange_a) 
        annotation (points=[-60, 0; -100, 0], style(color=10, thickness=2));
    initial equation 
      spring.w_rel = 0;
      a_rel = 0;
    end GearType1;
    
    model GearType2 "Motor inertia and gearbox model for r3 joints 4,5,6  " 
      extends Modelica.Mechanics.Rotational.Interfaces.TwoFlanges;
      parameter Real i=-99 "gear ratio";
      parameter SI.Torque Rv0=21.8 "viscous friction torque at zero velocity";
      parameter Real Rv1=9.8 
        "viscous friction coefficient in [Nms/rad] (R=Rv0+Rv1*abs(qd))";
      parameter Real peak=(26.7/21.8) 
        "peak*Rv0 = maximum static friction torque (peak >= 1)";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.13,
          y=0.27,
          width=0.63,
          height=0.63),
        Documentation(info="The elasticity and damping in the gearboxes of the outermost
three joints of the robot is neglected.
Default values for all parameters are given for joint 4.
"),     Icon(
          Rectangle(extent=[-100,10; -60,-10],  style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, 10; -60, 20; -40, 40; -40, -40; -60, -20; -60,
                10], style(
              color=10,
              gradient=2,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[-40, 60; 40, -60], style(
              color=3,
              pattern=1,
              thickness=1,
              gradient=2,
              arrow=0,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[60, 20; 40, 40; 40, -40; 60, -20; 60, 20], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[60,10; 100,-10],  style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, -90; -50, -90; -20, -30; 20, -30; 48, -90; 60, -90;
                 60, -100; -60, -100; -60, -90], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Text(extent=[0, 128; 0, 68], string="%name"),
          Text(extent=[-36, 40; 38, -30], string="2")),
        Diagram);
      
      Modelica.Mechanics.Rotational.IdealGear gear(ratio=i) 
        annotation (extent=[-28, -10; -8, 10]);
      Modelica.Mechanics.Rotational.BearingFriction bearingFriction(tau_pos=[0,
             Rv0; 1, Rv0 + Rv1], peak=peak) 
        annotation (extent=[30, -10; 50, 10]);
    equation 
      connect(gear.flange_b, bearingFriction.flange_a) 
        annotation (points=[-8, 0; 30, 0], style(color=10, thickness=2));
      connect(bearingFriction.flange_b, flange_b) 
        annotation (points=[50, 0; 100, 0], style(color=10, thickness=2));
      connect(gear.flange_a, flange_a) 
        annotation (points=[-28, 0; -100, 0], style(color=10, thickness=2));
    end GearType2;
    
    model Motor "Motor model including current controller of r3 motors " 
      extends Modelica.Icons.MotorIcon;
      parameter SI.Inertia J=0.0013 "moment of inertia of motor";
      parameter Real k=1.1616 "gain of motor";
      parameter Real w=4590 "time constant of motor";
      parameter Real D=0.6 "damping constant of motor";
      parameter SI.AngularVelocity w_max=315 "maximum speed of motor";
      parameter SI.Current i_max=9 "maximum current of motor";
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.03,
          y=0.04,
          width=0.68,
          height=0.8),
        Documentation(info=" Default values are given for the motor of joint 1.
The input of the motor is the desired current
(the actual current is proportional to the torque
produced by the motor).
"),     Icon(Text(extent=[0, 120; 0, 60], string="%name"), Line(points=[80, -102;
                 80, -10], style(color=77))),
        Diagram);
      
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_motor 
        annotation (extent=[90, -10; 110, 10]);
      Modelica.Electrical.Analog.Sources.SignalVoltage Vs 
        annotation (extent=[-80, -10; -100, 10], rotation=-90);
      Modelica.Electrical.Analog.Ideal.IdealOpAmp diff 
        annotation (extent=[-64, 15; -44, 35]);
      Modelica.Electrical.Analog.Ideal.IdealOpAmp power 
        annotation (extent=[16, 15; 36, 35]);
      Modelica.Electrical.Analog.Basic.EMF emf(k=k) 
        annotation (extent=[46, -10; 66, 10]);
      Modelica.Electrical.Analog.Basic.Inductor La(L=(250/(2*D*w))) 
        annotation (extent=[46, 20; 66, 40], rotation=-90);
      Modelica.Electrical.Analog.Basic.Resistor Ra(R=250) 
        annotation (extent=[46, 50; 66, 70], rotation=-90);
      Modelica.Electrical.Analog.Basic.Resistor Rd2(R=100) 
        annotation (extent=[-86, 22; -71, 38]);
      Modelica.Electrical.Analog.Basic.Capacitor C(C=0.004*D/w) 
        annotation (extent=[-14, 36; 6, 56]);
      Modelica.Electrical.Analog.Ideal.IdealOpAmp OpI 
        annotation (extent=[-14, 10; 6, 30]);
      Modelica.Electrical.Analog.Basic.Resistor Rd1(R=100) 
        annotation (extent=[-63, 37; -48, 53]);
      Modelica.Electrical.Analog.Basic.Resistor Ri(R=10) 
        annotation (extent=[-37, 17; -22, 33]);
      Modelica.Electrical.Analog.Basic.Resistor Rp1(R=200) 
        annotation (extent=[17, 38; 32, 54]);
      Modelica.Electrical.Analog.Basic.Resistor Rp2(R=50) 
        annotation (extent=[4, 64; 18, 80], rotation=90);
      Modelica.Electrical.Analog.Basic.Resistor Rd4(R=100) 
        annotation (extent=[-55, -15; -40, 1]);
      Modelica.Electrical.Analog.Sources.SignalVoltage hall2 
        annotation (extent=[-59, -40; -79, -60], rotation=90);
      Modelica.Electrical.Analog.Basic.Resistor Rd3(R=100) 
        annotation (extent=[-76, -30; -62, -14], rotation=90);
      Modelica.Electrical.Analog.Basic.Ground g1 
        annotation (extent=[-100, -37; -80, -17]);
      Modelica.Electrical.Analog.Basic.Ground g2 
        annotation (extent=[-79, -90; -59, -70]);
      Modelica.Electrical.Analog.Basic.Ground g3 
        annotation (extent=[-34, -27; -14, -7]);
      Modelica.Electrical.Analog.Sensors.CurrentSensor hall1 
        annotation (extent=[6, -60; 26, -40], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground g4 
        annotation (extent=[6, -84; 26, -64]);
      Modelica.Electrical.Analog.Basic.Ground g5 
        annotation (extent=[1, 83; 21, 103], rotation=180);
      Modelica.Mechanics.Rotational.Sensors.AngleSensor phi 
        annotation (extent=[66, -49; 86, -29], rotation=-90);
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed 
        annotation (extent=[45, -50; 65, -30], rotation=-90);
      Modelica.Mechanics.Rotational.Inertia Jmotor(J=J) 
        annotation (extent=[70, -10; 90, 10]);
      RobotR3.Components.AxisBus bus 
        annotation (extent=[70, -120; 90, -100], rotation=90);
      Blocks.Math.Gain convert1 annotation(extent=[-30,-56; -42,-44]);
      Blocks.Math.Gain convert2 annotation(extent=[-30,-101; -42,-89]);
    equation 
      connect(La.n, emf.p) annotation (points=[56, 20; 56, 10]);
      connect(Ra.n, La.p) annotation (points=[56, 50; 56, 40]);
      connect(Rd2.n, diff.n1) annotation (points=[-71, 30; -64, 30]);
      connect(C.n, OpI.p2) annotation (points=[6, 46; 6, 20]);
      connect(OpI.p2, power.p1) annotation (points=[6, 20; 16, 20]);
      connect(Vs.p, Rd2.p) annotation (points=[-90, 10; -90, 30; -86, 30]);
      connect(diff.n1, Rd1.p) 
        annotation (points=[-64, 30; -68, 30; -68, 45; -63, 45]);
      connect(Rd1.n, diff.p2) annotation (points=[-48, 45; -44, 45; -44, 25]);
      connect(diff.p2, Ri.p) annotation (points=[-44, 25; -37, 25]);
      connect(Ri.n, OpI.n1) annotation (points=[-22, 25; -14, 25]);
      connect(OpI.n1, C.p) annotation (points=[-14, 25; -14, 46]);
      connect(power.n1, Rp1.p) 
        annotation (points=[16, 30; 11, 30; 11, 46; 17, 46]);
      connect(power.p2, Rp1.n) annotation (points=[36, 25; 36, 46; 32, 46]);
      connect(Rp1.p, Rp2.p) annotation (points=[17, 46; 11, 46; 11, 64]);
      connect(power.p2, Ra.p) 
        annotation (points=[36, 25; 42, 25; 42, 80; 56, 80; 56, 70]);
      connect(Rd3.p, hall2.p) annotation (points=[-69, -30; -69, -40]);
      connect(Rd3.n, diff.p1) annotation (points=[-69, -14; -69, 20; -64, 20]);
      connect(Rd3.n, Rd4.p) annotation (points=[-69, -14; -69, -7; -55, -7]);
      connect(Vs.n, g1.p) annotation (points=[-90, -10; -90, -17]);
      connect(g2.p, hall2.n) annotation (points=[-69, -70; -69, -60]);
      connect(Rd4.n, g3.p) annotation (points=[-40, -7; -24, -7]);
      connect(g3.p, OpI.p1) annotation (points=[-24, -7; -24, 15; -14, 15]);
      connect(g5.p, Rp2.n) 
        annotation (points=[11,83; 11,81.5; 11,81.5; 11,80]);
      connect(emf.n, hall1.p) 
        annotation (points=[56, -10; 56, -24; 16, -24; 16, -40]);
      connect(hall1.n, g4.p) annotation (points=[16, -60; 16, -64]);
      connect(emf.flange_b, phi.flange_a) 
        annotation (points=[66, 0; 66, -29; 76, -29], style(pattern=3));
      connect(emf.flange_b, speed.flange_a) 
        annotation (points=[66, 0; 66, -30; 55, -30], style(pattern=3));
      connect(OpI.n2, power.n2) 
        annotation (points=[-4, 10; -4, 4; 26, 4; 26, 15]);
      connect(OpI.p1, OpI.n2) annotation (points=[-14, 15; -14, 10; -4, 10]);
      connect(OpI.p1, diff.n2) annotation (points=[-14, 15; -54, 15]);
      connect(Jmotor.flange_a, emf.flange_b) 
        annotation (points=[70, 0; 66, 0], style(color=10, thickness=2));
      connect(Jmotor.flange_b, flange_motor) 
        annotation (points=[90, 0; 100, 0], style(color=10, thickness=2));
    initial equation 
      // initialize motor in steady state
      der(C.v) = 0;
      der(La.i) = 0;
    equation 
      connect(phi.phi, bus.motorAngle) annotation(points=[76,-50; 76,-95; 80,
            -95; 80,-107], style(color=3, rgbcolor={0,0,255}));
      connect(speed.w, bus.motorSpeed) annotation(points=[55,-51; 55,-95; 80,
            -95; 80,-107], style(color=3, rgbcolor={0,0,255}));
      connect(hall1.i, bus.current) annotation(points=[6,-50; -10,-50; -10,-95;
            80,-95; 80,-105], style(color=3, rgbcolor={0,0,255}));
      connect(hall1.i, convert1.u) annotation(points=[6,-50; -28.8,-50], style(
          color=3,
          rgbcolor={0,0,255},
          pattern=3));
      connect(convert1.y, hall2.v) annotation(points=[-42.6,-50; -62,-50],
          style(
          color=3,
          rgbcolor={0,0,255},
          pattern=3));
      connect(convert2.u, bus.current_ref) annotation(points=[-28.8,-95; 80,-95;
            80,-109], style(color=3, rgbcolor={0,0,255}));
      connect(convert2.y, Vs.v) annotation(points=[-42.6,-95; -108,-95; -108,
            4.28612e-016; -97,4.28612e-016], style(color=3, rgbcolor={0,0,255}));
    end Motor;
    
    model Controller 
      parameter Real kp=10 "gain of position controller";
      parameter Real ks=1 "gain of speed controller";
      parameter SI.Time Ts=0.01 
        "time constant of integrator of speed controller";
      parameter Real ratio=1 "gear ratio of gearbox";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Diagram,
        Icon(
          Rectangle(extent=[-100, -100; 100, 100], style(
              color=3,
              pattern=1,
              thickness=1,
              gradient=0,
              arrow=0,
              fillColor=30,
              fillPattern=1)),
          Rectangle(extent=[-30, 54; 30, 24], style(fillColor=7, fillPattern=1)),
          Polygon(points=[-30, 40; -60, 50; -60, 30; -30, 40], style(
              color=3,
              fillColor=3,
              fillPattern=1)),
          Line(points=[-31, -41; -78, -41; -78, 39; -30, 39]),
          Rectangle(extent=[-30, -26; 30, -56], style(fillColor=7, fillPattern=
                  1)),
          Polygon(points=[60, -32; 30, -42; 60, -52; 60, -32], style(fillColor=
                  3, fillPattern=1)),
          Line(points=[30, 39; 76, 39; 76, -41; 30, -41]),
          Text(extent=[-100, 150; 100, 110], string="%name")),
        Window(
          x=0.01,
          y=0.01,
          width=0.84,
          height=0.76));
      
      Modelica.Blocks.Math.Gain gain1(k=ratio) 
        annotation (extent=[-70, 0; -50, 20]);
      Modelica.Blocks.Continuous.PI PI(k=ks, T=Ts) 
        annotation (extent=[60, 0; 80, 20], rotation=0);
      Modelica.Blocks.Math.Feedback feedback1 
        annotation (extent=[-46, 0; -26, 20]);
      Modelica.Blocks.Math.Gain P(k=kp) annotation (extent=[-16, 0; 4, 20]);
      Modelica.Blocks.Math.Add3 add3(k3=-1) annotation (extent=[20, 0; 40, 20]);
      Modelica.Blocks.Math.Gain gain2(k=ratio) 
        annotation (extent=[-60, 40; -40, 60]);
      RobotR3.Components.AxisBus bus 
        annotation (extent=[-10, -120; 10, -100], rotation=90);
    equation 
      connect(gain1.y, feedback1.u1) 
        annotation (points=[-49, 10; -44, 10]);
      connect(feedback1.y, P.u) 
        annotation (points=[-27, 10; -18, 10]);
      connect(P.y, add3.u2) annotation (points=[5, 10; 18, 10]);
      connect(gain2.y, add3.u1) 
        annotation (points=[-39, 50; 10, 50; 10, 18; 18, 18], style(color=3));
      connect(add3.y, PI.u) 
        annotation (points=[41, 10; 58, 10], style(color=3));
      connect(gain2.u, bus.speed_ref) annotation(points=[-62,50; -90,50; -90,
            -80; 0,-80; 0,-105], style(color=3, rgbcolor={0,0,255}));
      connect(gain1.u, bus.angle_ref) annotation(points=[-72,10; -80,10; -80,
            -80; 0,-80; 0,-105], style(color=3, rgbcolor={0,0,255}));
      connect(feedback1.u2, bus.motorAngle) annotation(points=[-36,2; -36,-80;
            0,-80; 0,-104], style(color=3, rgbcolor={0,0,255}));
      connect(add3.u3, bus.motorSpeed) annotation(points=[18,2; 10,2; 10,-70; 0,
            -70; 0,-105], style(color=3, rgbcolor={0,0,255}));
      connect(PI.y, bus.current_ref) annotation(points=[81,10; 90,10; 90,-80; 0,
            -80; 0,-106], style(color=3, rgbcolor={0,0,255}));
    end Controller;
    
    model AxisType1 "Axis model of the r3 joints 1,2,3 " 
      parameter Real kp=10 "|Controller| gain of position controller";
      parameter Real ks=1 "|Controller| gain of speed controller";
      parameter SI.Time Ts=0.01 
        "|Controller| time constant of integrator of speed controller";
      parameter Real k=1.1616 "|Motor| gain of motor";
      parameter Real w=4590 "|Motor| time constant of motor";
      parameter Real D=0.6 "|Motor| damping constant of motor";
      parameter SI.Inertia J=0.0013 "|Motor| moment of inertia of motor";
      parameter Real ratio=-105 "|Gear| gear ratio";
      parameter Real c(unit="N.m/rad") = 43 "|Gear| spring constant";
      parameter Real cd(unit="N.m.s/rad") = 0.005 "|Gear| damper constant";
      parameter SI.Torque Rv0=0.4 
        "|Gear| viscous friction torque at zero velocity in [Nm]";
      parameter Real Rv1(unit="N.m.s/rad") = (0.13/160) 
        "|Gear| viscous friction coefficient in [Nms/rad]";
      parameter Real peak=1 
        "|Gear| peak*Rv0 = maximum static friction torque (peak >= 1)";
      SI.Angle phi_flange(stateSelect=StateSelect.prefer) = flange.phi;
      SI.AngularVelocity w_flange(stateSelect=StateSelect.prefer) = der(
        phi_flange);
      SI.AngularAcceleration a_flange=der(w_flange);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.16,
          y=0.02,
          width=0.76,
          height=0.84),
        Documentation(info="<HTML>
<p>
The axis model consists of the <b>controller</b>, the <b>motor</b> including current
controller and the <b>gearbox</b> including gear elasticity and bearing friction.
The only difference to the axis model of joints 4,5,6 (= model axisType2) is
that elasticity and damping in the gear boxes are not neglected.
</p>
<p>
The input signals of this component are the desired angle and desired angular
velocity of the joint. The reference signals have to be \"smooth\" (position
has to be differentiable at least 2 times). Otherwise, the gear elasticity
leads to significant oscillations.
</p>
<p>
Default values of the parameters are given for the axis of joint 1.
</p>
</HTML>
"),     Icon(Rectangle(extent=[-100, 50; 100, -50], style(
              color=9,
              gradient=2,
              fillColor=9,
              fillPattern=1)), Text(extent=[0, 110; 0, 50], string="%name")),
        Diagram);
      
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange 
        annotation (extent=[100, -10; 120, 10]);
      GearType1 gear(
        c=c,
        d=cd,
        Rv0=Rv0,
        Rv1=Rv1,
        peak=peak,
        i=ratio) annotation (extent=[0, -10; 20, 10]);
      Motor motor(
        J=J,
        k=k,
        w=w,
        D=D) annotation (extent=[-30, -10; -10, 10]);
      RobotR3.Components.Controller controller(
        kp=kp,
        ks=ks,
        Ts=Ts,
        ratio=ratio) annotation (extent=[-70, -10; -50, 10]);
      RobotR3.Components.AxisBus bus 
        annotation (extent=[-120, -10; -100, 10], rotation=0);
      Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor 
        annotation (extent=[20, -50; 40, -30], rotation=-90);
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor 
        annotation (extent=[60, -30; 40, -50], rotation=90);
      Modelica.Mechanics.Rotational.Sensors.AccSensor accSensor 
        annotation (extent=[60, -50; 80, -30], rotation=-90);
    initial equation 
      // initialize in approximate steady state
      phi_flange = bus.angle_ref;
      w_flange = bus.speed_ref;
      a_flange = 0;
    equation 
      connect(controller.bus, bus) annotation (points=[-60, -11; -60, -17; -90,
             -17; -90, 0; -110, 0], style(color=77));
      connect(motor.bus, bus) annotation (points=[-12, -11; -12, -17; -90, -17;
             -90, 0; -110, 0], style(color=77));
      connect(gear.flange_b, flange) 
        annotation (points=[20, 0; 110, 0], style(color=0));
      connect(gear.flange_b, angleSensor.flange_a) 
        annotation (points=[20, 0; 30, 0; 30, -30], style(color=0));
      connect(gear.flange_b, speedSensor.flange_a) 
        annotation (points=[20, 0; 50, 0; 50, -30], style(color=0));
      connect(motor.flange_motor, gear.flange_a) 
        annotation (points=[-10, 0; 0, 0], style(color=0));
      connect(gear.flange_b, accSensor.flange_a) 
        annotation (points=[20, 0; 70, 0; 70, -30], style(color=0));
      connect(angleSensor.phi, bus.angle) annotation(points=[30,-51; 30,-90;
            -90,-90; -90,0; -103,0], style(color=3, rgbcolor={0,0,255}));
      connect(speedSensor.w, bus.speed) annotation(points=[50,-51; 50,-90; -90,
            -90; -90,0; -102,0], style(color=3, rgbcolor={0,0,255}));
      connect(accSensor.a, bus.acceleration) annotation(points=[70,-51; 70,-90;
            -90,-90; -90,0; -105,0], style(color=3, rgbcolor={0,0,255}));
    end AxisType1;
    
    model AxisType2 "Axis model of the r3 joints 4,5,6 " 
      parameter Real kp=10 "|Controller| gain of position controller";
      parameter Real ks=1 "|Controller| gain of speed controller";
      parameter SI.Time Ts=0.01 
        "|Controller| time constant of integrator of speed controller";
      parameter Real k=1.1616 "|Motor| gain of motor";
      parameter Real w=4590 "|Motor| time constant of motor";
      parameter Real D=0.6 "|Motor| damping constant of motor";
      parameter SI.Inertia J=0.0013 "|Motor| moment of inertia of motor";
      parameter Real ratio=-105 "|Gear| gear ratio";
      parameter SI.Torque Rv0=0.4 
        "|Gear| viscous friction torque at zero velocity in [Nm]";
      parameter Real Rv1(unit="N.m.s/rad") = (0.13/160) 
        "|Gear| viscous friction coefficient in [Nms/rad]";
      parameter Real peak=1 
        "|Gear| peak*Rv0 = maximum static friction torque (peak >= 1)";
      SI.Angle phi_flange(stateSelect=StateSelect.prefer) = flange.phi;
      SI.AngularVelocity w_flange(stateSelect=StateSelect.prefer) = der(
        phi_flange);
      SI.AngularAcceleration a_flange=der(w_flange);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.16,
          y=0.02,
          width=0.76,
          height=0.84),
        Documentation(info="<HTML>
<p>
The axis model consists of the <b>controller</b>, the <b>motor</b> including current
controller and the <b>gearbox</b> including gear elasticity and bearing friction.
The only difference to the axis model of joints 4,5,6 (= model axisType2) is
that elasticity and damping in the gear boxes are not neglected.
</p>
<p>
The input signals of this component are the desired angle and desired angular
velocity of the joint. The reference signals have to be \"smooth\" (position
has to be differentiable at least 2 times). Otherwise, the gear elasticity
leads to significant oscillations.
</p>
<p>
Default values of the parameters are given for the axis of joint 1.
</p>
</HTML>
"),     Icon(Rectangle(extent=[-100, 50; 100, -50], style(
              color=9,
              gradient=2,
              fillColor=9,
              fillPattern=1)), Text(extent=[0, 110; 0, 50], string="%name")),
        Diagram);
      
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange 
        annotation (extent=[100, -10; 120, 10]);
      GearType2 gear(
        Rv0=Rv0,
        Rv1=Rv1,
        peak=peak,
        i=ratio) annotation (extent=[0, -10; 20, 10]);
      Motor motor(
        J=J,
        k=k,
        w=w,
        D=D) annotation (extent=[-30, -10; -10, 10]);
      RobotR3.Components.Controller controller(
        kp=kp,
        ks=ks,
        Ts=Ts,
        ratio=ratio) annotation (extent=[-70, -10; -50, 10]);
      RobotR3.Components.AxisBus bus 
        annotation (extent=[-120, -10; -100, 10], rotation=0);
      Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor 
        annotation (extent=[20, -39; 40, -19], rotation=-90);
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor 
        annotation (extent=[60, -20; 40, -40], rotation=90);
      Modelica.Mechanics.Rotational.Sensors.AccSensor accSensor 
        annotation (extent=[60, -40; 80, -20], rotation=-90);
    initial equation 
      // initialize in approximate steady state
      phi_flange = bus.angle_ref;
      w_flange = bus.speed_ref;
      a_flange = 0;
    equation 
      connect(controller.bus, bus) annotation (points=[-60, -11; -60, -30; -90,
             -30; -90, 0; -110, 0], style(color=77));
      connect(motor.bus, bus) annotation (points=[-12, -11; -12, -40; -90, -40;
             -90, 0; -110, 0], style(color=77));
      connect(gear.flange_b, flange) 
        annotation (points=[20, 0; 110, 0], style(color=0));
      connect(gear.flange_b, angleSensor.flange_a) 
        annotation (points=[20, 0; 30, 0; 30, -19], style(color=0));
      connect(gear.flange_b, speedSensor.flange_a) 
        annotation (points=[20, 0; 50, 0; 50, -20], style(color=0));
      connect(motor.flange_motor, gear.flange_a) 
        annotation (points=[-10, 0; 0, 0], style(color=0));
      connect(gear.flange_b, accSensor.flange_a) 
        annotation (points=[20, 0; 70, 0; 70, -20], style(color=0));
      connect(angleSensor.phi, bus.angle) annotation(points=[30,-40; 30,-90;
            -90,-90; -90,0; -104,0], style(color=3, rgbcolor={0,0,255}));
      connect(speedSensor.w, bus.speed) annotation(points=[50,-41; 50,-90; -90,
            -90; -90,0; -104,0], style(color=3, rgbcolor={0,0,255}));
      connect(accSensor.a, bus.acceleration) annotation(points=[70,-41; 70,-90;
            -90,-90; -90,0; -104,0], style(color=3, rgbcolor={0,0,255}));
    end AxisType2;
    
    model MechanicalStructure 
      "Model of the mechanical part of the r3 robot (without animation)" 
      
      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter SI.Mass mLoad=15 "mass of load";
      parameter SI.Position rLoad[3]={0,0.25,0} 
        "distance from last flange to load mass>";
      parameter SI.Acceleration g=9.81 "gravity acceleration";
      SI.Angle q[6] "joint angles";
      SI.AngularVelocity qd[6] "joint speeds";
      SI.AngularAcceleration qdd[6] "joint accelerations";
      SI.Torque tau[6] "joint driving torques";
      //r0={0,0.351,0},
      annotation (
        Coordsys(
          extent=[-200, -200; 200, 200],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.16,
          y=0.06,
          width=0.73,
          height=0.87),
        Documentation(info="<HTML>
<p>
This model contains the mechanical components of the r3 robot
(multibody system).
</p>
</HTML>
"),     Icon(
          Rectangle(extent=[-200, 200; 200, -200], style(
              gradient=0,
              fillColor=8,
              fillPattern=1)),
          Text(extent=[-200, 280; 200, 200], string="%name"),
          Text(extent=[-200, -150; -140, -190], string="1"),
          Text(extent=[-200, -30; -140, -70], string="3"),
          Text(extent=[-200, -90; -140, -130], string="2"),
          Text(extent=[-200, 90; -140, 50], string="5"),
          Text(extent=[-200, 28; -140, -12], string="4"),
          Text(extent=[-198, 150; -138, 110], string="6"),
          Bitmap(extent=[-130, 195; 195, -195], name=
                "../../../../Images/MultiBody/Examples/Systems/robot_kr15.bmp")),
        Diagram);
      
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis1 
        annotation (extent=[-220, -180; -200, -160]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis2 
        annotation (extent=[-220, -120; -200, -100]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis3 
        annotation (extent=[-220, -60; -200, -40]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis4 
        annotation (extent=[-220, 0; -200, 20]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis5 
        annotation (extent=[-220, 60; -200, 80]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis6 
        annotation (extent=[-220, 120; -200, 140]);
      inner MultiBody.World world(
        g=(g)*MultiBody.Frames.length(({0,-1,0})),
        n={0,-1,0},
        animateWorld=false,
        animateGravity=false) annotation (extent=[-100, -200; -80, -180]);
      MultiBody.Joints.ActuatedRevolute r1(n={0,1,0}) 
        annotation (extent=[-80, -170; -60, -150], rotation=90);
      MultiBody.Joints.ActuatedRevolute r2(n={1,0,0}) 
        annotation (extent=[-50, -110; -30, -90]);
      MultiBody.Joints.ActuatedRevolute r3(n={1,0,0}) 
        annotation (extent=[-60, -46; -40, -26], rotation=180);
      MultiBody.Joints.ActuatedRevolute r4(n={0,1,0}) 
        annotation (extent=[-80, 0; -60, 20], rotation=90);
      MultiBody.Joints.ActuatedRevolute r5(n={1,0,0}) 
        annotation (extent=[-60, 70; -40, 90]);
      MultiBody.Joints.ActuatedRevolute r6(n={0,1,0}) 
        annotation (extent=[-70, 120; -50, 140], rotation=90);
      MultiBody.Parts.BodyShape b0(
        r={0,0.351,0},
        shapeType="0",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.225,
        width=0.3,
        height=0.3,
        color={0,0,255},
        animation=animation,
        animateSphere=false) 
        annotation (extent=[-40, -180; -20, -160], rotation=90);
      MultiBody.Parts.BodyShape b1(
        r={0,0.324,0.3},
        I_22=1.16,
        shapeType="1",
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.25,
        width=0.15,
        height=0.2,
        animation=animation,
        animateSphere=false,
        color={255,0,0}) annotation (extent=[-80, -128; -60, -108], rotation=90);
      MultiBody.Parts.BodyShape b2(
        r={0,0.65,0},
        r_CM={0.172,0.205,0},
        m=56.5,
        I_11=2.58,
        I_22=0.64,
        I_33=2.73,
        I_21=-0.46,
        shapeType="2",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.5,
        width=0.2,
        height=0.15,
        animation=animation,
        animateSphere=false,
        color={255,178,0}) annotation (extent=[-26, -80; -6, -60], rotation=90);
      MultiBody.Parts.BodyShape b3(
        r={0,0.414,-0.155},
        r_CM={0.064,-0.034,0},
        m=26.4,
        I_11=0.279,
        I_22=0.245,
        I_33=0.413,
        I_21=-0.070,
        shapeType="3",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.15,
        width=0.15,
        height=0.15,
        animation=animation,
        animateSphere=false,
        color={255,0,0}) annotation (extent=[-76, -32; -96, -12], rotation=90);
      MultiBody.Parts.BodyShape b4(
        r={0,0.186,0},
        r_CM={0,0,0},
        m=28.7,
        I_11=1.67,
        I_22=0.081,
        I_33=1.67,
        shapeType="4",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.73,
        width=0.1,
        height=0.1,
        animation=animation,
        animateSphere=false,
        color={255,178,0}) annotation (extent=[-80, 40; -60, 60], rotation=90);
      MultiBody.Parts.BodyShape b5(
        r={0,0.125,0},
        r_CM={0,0,0},
        m=5.2,
        I_11=1.25,
        I_22=0.81,
        I_33=1.53,
        shapeType="5",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.225,
        width=0.075,
        height=0.1,
        animation=animation,
        animateSphere=false,
        color={0,0,255}) annotation (extent=[-30, 88; -10, 108], rotation=90);
      MultiBody.Parts.BodyShape b6(
        r={0,0,0},
        r_CM={0.05,0.05,0.05},
        m=0.5,
        shapeType="6",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        animation=animation,
        animateSphere=false,
        color={0,0,255}) annotation (extent=[-70, 150; -50, 170], rotation=90);
      MultiBody.Parts.BodyShape load(
        r_CM=rLoad,
        m=mLoad,
        r_shape={0,0,0},
        widthDirection={1,0,0},
        width=0.05,
        height=0.05,
        color={255,0,0},
        lengthDirection=rLoad,
        length=MultiBody.Frames.length(rLoad)) 
        annotation (extent=[-70, 178; -50, 198], rotation=90);
    equation 
      connect(r6.frame_b, b6.frame_a) 
        annotation (points=[-60, 141; -60, 149], style(thickness=2));
      q = {r1.phi,r2.phi,r3.phi,r4.phi,r5.phi,r6.phi};
      qd = der(q);
      qdd = der(qd);
      tau = {r1.axis.tau,r2.axis.tau,r3.axis.tau,r4.axis.tau,r5.axis.tau,r6.
        axis.tau};
      connect(load.frame_a, b6.frame_b) 
        annotation (points=[-60, 177; -60, 171]);
      connect(world.frame_b, b0.frame_a) annotation (points=[-79, -190; -30, -190;
             -30, -181], style(color=0, thickness=2));
      connect(b0.frame_b, r1.frame_a) annotation (points=[-30, -159; -30, -146;
             -48, -146; -48, -180; -70, -180; -70, -171], style(color=0,
            thickness=2));
      connect(b1.frame_b, r2.frame_a) annotation (points=[-70, -107; -70, -100;
             -51, -100], style(color=0, thickness=2));
      connect(r1.frame_b, b1.frame_a) annotation (points=[-70, -149; -70, -129],
           style(color=0, thickness=2));
      connect(r2.frame_b, b2.frame_a) annotation (points=[-29, -100; -16, -100;
             -16, -81], style(color=0, thickness=2));
      connect(b2.frame_b, r3.frame_a) annotation (points=[-16, -59; -16, -36; -39,
             -36], style(color=0, thickness=2));
      connect(r2.axis, axis2) annotation (points=[-40, -90; -42, -90; -42, -80;
             -160, -80; -160, -110; -210, -110], style(color=0));
      connect(r1.axis, axis1) annotation (points=[-80, -160; -160, -160; -160,
            -170; -210, -170], style(color=0));
      connect(r3.frame_b, b3.frame_a) annotation (points=[-61, -36; -86, -36; -86,
             -33], style(color=0, thickness=2));
      connect(b3.frame_b, r4.frame_a) annotation (points=[-86, -11; -86, -8; -70,
             -8; -70, -1], style(color=0, thickness=2));
      connect(r3.axis, axis3) 
        annotation (points=[-50, -46; -50, -50; -210, -50], style(color=0));
      connect(r4.axis, axis4) 
        annotation (points=[-80, 10; -210, 10], style(color=0));
      connect(r4.frame_b, b4.frame_a) 
        annotation (points=[-70, 21; -70, 39], style(color=0, thickness=2));
      connect(b4.frame_b, r5.frame_a) annotation (points=[-70, 61; -70, 80; -61,
             80], style(color=0, thickness=2));
      connect(r5.axis, axis5) annotation (points=[-50, 90; -50, 94; -160, 94; -160,
             70; -210, 70], style(color=0));
      connect(r5.frame_b, b5.frame_a) annotation (points=[-39, 80; -20, 80; -20,
             87], style(color=0, thickness=2));
      connect(b5.frame_b, r6.frame_a) annotation (points=[-20, 109; -20, 114; -60,
             114; -60, 119], style(color=0, thickness=2));
      connect(r6.axis, axis6) 
        annotation (points=[-70, 130; -210, 130], style(color=0));
    end MechanicalStructure;
    
    block KinematicPTPc 
      "Move as fast as possible along a distance within given kinematic constraints" 
      
      parameter Real q_begin[:]={0} "Start position";
      parameter Real q_end[:]={1} "End position";
      parameter Real qd_max[:](final min=Modelica.Constants.SMALL) = {1} 
        "Maximum velocities der(q)";
      parameter Real qdd_max[:](final min=Modelica.Constants.SMALL) = {1} 
        "Maximum accelerations der(qd)";
      parameter SI.Time startTime=0 "Time instant at which movement starts";
      
      extends Modelica.Blocks.Interfaces.BlockIcon;
      final parameter Integer nout=max([size(q_begin, 1); size(q_end, 1); size(
          qd_max, 1); size(qdd_max, 1)]);
      output SI.Time endTime "Time instant at which movement stops";
      
    protected 
      parameter Real p_q_begin[nout]=(if size(q_begin, 1) == 1 then ones(nout)*
          q_begin[1] else q_begin);
      parameter Real p_q_end[nout]=(if size(q_end, 1) == 1 then ones(nout)*
          q_end[1] else q_end);
      parameter Real p_qd_max[nout]=(if size(qd_max, 1) == 1 then ones(nout)*
          qd_max[1] else qd_max);
      parameter Real p_qdd_max[nout]=(if size(qdd_max, 1) == 1 then ones(nout)*
          qdd_max[1] else qdd_max);
      parameter Real p_deltaq[nout]=p_q_end - p_q_begin;
      constant Real eps=10*Modelica.Constants.eps;
      Real sd_max_inv;
      Real sdd_max_inv;
      Real sd_max;
      Real sdd_max;
      Real sdd;
      Real aux1[nout];
      Real aux2[nout];
      SI.Time Ta1;
      SI.Time Ta2;
      SI.Time Tv;
      SI.Time Te;
      Boolean noWphase;
      SI.Time Ta1s;
      SI.Time Ta2s;
      SI.Time Tvs;
      SI.Time Tes;
      Real sd_max2;
      Real s1;
      Real s2;
      Real s3;
      Real s;
      Real sd;
      Real constraintResidue;
      Real r_s;
      Real r_sd;
      Real r_sdd;
      Real constraintResidue_d;
      Real constraintResidue_dd;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.17,
          y=0.05,
          width=0.69,
          height=0.72),
        Icon(
          Line(points=[-80, 78; -80, -82], style(color=8)),
          Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 88; -80, 90], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Line(points=[-90, 0; 17, 0], style(color=8)),
          Line(points=[-80, 0; -70, 0; -70, 70; -50, 70; -50, 0; -15, 0; -15, -70;
                 5, -70; 5, 0; 18, 0], style(color=0, thickness=1)),
          Text(
            extent=[40, 93; 96, 56],
            string="q",
            style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Text(
            extent=[38, 23; 94, -14],
            style(
              color=0,
              fillColor=0,
              fillPattern=1),
            string="qd"),
          Text(
            extent=[28, -51; 95, -88],
            style(
              color=0,
              fillColor=0,
              fillPattern=1),
            string="qdd")),
        Diagram(
          Rectangle(extent=[-100, -100; 100, 100], style(
              color=3,
              gradient=0,
              fillColor=0,
              fillPattern=0)),
          Line(points=[-80, 78; -80, -82], style(color=8)),
          Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 88; -80, 90], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Line(points=[-90, 0; 82, 0], style(color=8)),
          Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Line(points=[-80, 0; -70, 0; -70, 70; -30, 70; -30, 0; 20, 0; 20, -70;
                 60, -70; 60, 0; 68, 0], style(color=0, thickness=2)),
          Text(
            extent=[-76, 98; -19, 83],
            string="acceleration",
            style(color=8)),
          Text(
            extent=[69, 24; 91, 12],
            string="time",
            style(color=8))),
        Documentation(info="
<HTML>
<p>
The goal is to move as <b>fast</b> as possible along a distance
<b>deltaq</b>
under given <b>kinematical constraints</b>. The distance can be a positional or
angular range. In robotics such a movement is called <b>PTP</b> (Point-To-Point).
This source block generates the <b>acceleration</b> qdd of this signal
as output. After integrating the output two times, the position q is
obtained. The signal is constructed in such a way that it is not possible
to move faster, given the <b>maximally</b> allowed <b>velocity</b> qd_max and
the <b>maximally</b> allowed <b>acceleration</b> qdd_max.
</p>
<p>
If several distances are given (vector deltaq has more than 1 element),
an acceleration output vector is constructed such that all signals
are in the same periods in the acceleration, constant velocity
and deceleration phase. This means that only one of the signals
is at its limits whereas the others are sychnronized in such a way
that the end point is reached at the same time instant.
</p>
<p>
This element is useful to generate a reference signal for a controller
which controls a drive train or in combination with model
Modelica.Mechanics.Rotational.<b>Accelerate</b> to drive
a flange according to a given acceleration.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>June 27, 2001</i>
       by Bernhard Bachmann.<br>
       Bug fixed that element is also correct if startTime is not zero.</li>
<li><i>Nov. 3, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Vectorized and moved from Rotational to Blocks.Sources.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized.</li>
</ul>
</HTML>
"));
    public 
      Modelica.Blocks.Interfaces.RealOutput q[nout] 
        annotation (extent=[100, 60; 120, 80]);
      Modelica.Blocks.Interfaces.RealOutput qd[nout] 
        annotation (extent=[100, -10; 120, 10]);
      Modelica.Blocks.Interfaces.RealOutput qdd[nout] 
        annotation (extent=[100, -80; 120, -60]);
    equation 
      for i in 1:nout loop
        aux1[i] = p_deltaq[i]/p_qd_max[i];
        aux2[i] = p_deltaq[i]/p_qdd_max[i];
      end for;
      
      sd_max_inv = max(abs(aux1));
      sdd_max_inv = max(abs(aux2));
      
      if sd_max_inv <= eps or sdd_max_inv <= eps then
        sd_max = 0;
        sdd_max = 0;
        Ta1 = 0;
        Ta2 = 0;
        noWphase = false;
        Tv = 0;
        Te = 0;
        Ta1s = 0;
        Ta2s = 0;
        Tvs = 0;
        Tes = 0;
        sd_max2 = 0;
        s1 = 0;
        s2 = 0;
        s3 = 0;
        r_sdd = 0;
        r_sd = 0;
        r_s = 0;
      else
        sd_max = 1/max(abs(aux1));
        sdd_max = 1/max(abs(aux2));
        Ta1 = sqrt(1/sdd_max);
        Ta2 = sd_max/sdd_max;
        noWphase = Ta2 >= Ta1;
        Tv = if noWphase then Ta1 else 1/sd_max;
        Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;
        Ta1s = Ta1 + startTime;
        Ta2s = Ta2 + startTime;
        Tvs = Tv + startTime;
        Tes = Te + startTime;
        sd_max2 = sdd_max*Ta1;
        s1 = sdd_max*(if noWphase then Ta1*Ta1 else Ta2*Ta2)/2;
        s2 = s1 + (if noWphase then sd_max2*(Te - Ta1) - (sdd_max/2)*(Te - Ta1)
          ^2 else sd_max*(Tv - Ta2));
        s3 = s2 + sd_max*(Te - Tv) - (sdd_max/2)*(Te - Tv)*(Te - Tv);
        
        if time < startTime then
          r_sdd = 0;
          r_sd = 0;
          r_s = 0;
        elseif noWphase then
          if time < Ta1s then
            r_sdd = sdd_max;
            r_sd = sdd_max*(time - startTime);
            r_s = (sdd_max/2)*(time - startTime)*(time - startTime);
          elseif time < Tes then
            r_sdd = -sdd_max;
            r_sd = sd_max2 - sdd_max*(time - Ta1s);
            r_s = s1 + sd_max2*(time - Ta1s) - (sdd_max/2)*(time - Ta1s)*(time
               - Ta1s);
          else
            r_sdd = 0;
            r_sd = 0;
            r_s = s2;
          end if;
        elseif time < Ta2s then
          r_sdd = sdd_max;
          r_sd = sdd_max*(time - startTime);
          r_s = (sdd_max/2)*(time - startTime)*(time - startTime);
        elseif time < Tvs then
          r_sdd = 0;
          r_sd = sd_max;
          r_s = s1 + sd_max*(time - Ta2s);
        elseif time < Tes then
          r_sdd = -sdd_max;
          r_sd = sd_max - sdd_max*(time - Tvs);
          r_s = s2 + sd_max*(time - Tvs) - (sdd_max/2)*(time - Tvs)*(time - Tvs);
        else
          r_sdd = 0;
          r_sd = 0;
          r_s = s3;
        end if;
        
      end if;
      
      // acceleration
      qdd = p_deltaq*sdd;
      qd = p_deltaq*sd;
      q = p_q_begin + p_deltaq*s;
      endTime = Tes;
      
      sd = der(s);
      sdd = der(sd);
      
      constraintResidue = r_s - s;
      constraintResidue_d = r_sd - sd;
      constraintResidue_dd = r_sdd - sdd;
      constrain(constraintResidue, constraintResidue_d, constraintResidue_dd);
    end KinematicPTPc;
    
    annotation (Documentation(info="<html>
<p>
This library contains the different components
of the r3 robot. Usually, there is no need to
use this library directly.
</p>
</html>"));
  end Components;
  
  annotation (
    version="0.9",
    versionDate="2004-01-12",
    preferedView="info",
    uses(MultiBody(version="0.98")),
    Documentation(info="<HTML>
<p>
This package contains models of the robot r3 of the company Manutec.
These models are used to demonstrate in which way complex 
robot models might be built up by testing first the component
models individually before composing them together. 
Furthermore, it is shown how CAD data can be used
for animation.
</p>
<IMG SRC=\"../Images/MultiBody/Examples/Systems/robot_kr15.bmp\" 
ALT=\"model Examples.Systems.RobotR3\">
<p>
The following models are available:
</p>
<pre>
   <b>oneAxis</b>   Test one axis (controller, motor, gearbox).
   <b>fullRobot</b> Test complete robot model.
</pre>
<p>
The r3 robot is no longer manufactured. In fact the company 
Manutec does no longer exist.
The parameters of this robot have been determined by measurements
in the laboratory of DLR. The measurement procedure is described in:
</p>
<pre>
   Tuerk S. (1990): Zur Modellierung der Dynamik von Robotern mit
       rotatorischen Gelenken. Fortschrittberichte VDI, Reihe 8, Nr. 211,
       VDI-Verlag 1990.
</pre>
<p>
The robot model is described in detail in
</p>
<pre>
   Otter M. (1995): Objektorientierte Modellierung mechatronischer
       Systeme am Beispiel geregelter Roboter. Dissertation,
       Fortschrittberichte VDI, Reihe 20, Nr. 147, VDI-Verlag 1995.
       This report can be downloaded as compressed postscript file
       from: <a href=\"http://www.robotic.dlr.de/Martin.Otter/publications.html\">http://www.robotic.dlr.de/Martin.Otter/publications.html</a>.
</pre>
<p>
The path planning is performed in a simple way by using essentially
the Modelica.Mechanics.Rotational.KinematicPTP block. A user defines
a path by start and end angle of every axis. A path is planned such
that all axes are moving as fast as possible under the given 
restrictions of maximum joint speeds and maximum joint accelerations.
The actual r3 robot from Manutec had a different path planning strategy.
Todays path planning algorithms from robot companies are much
more involved. 
</p>
<p>
In order to get a nice animation, CAD data from a KUKA robot
is used, since CAD data of the original r3 robot was not available.
The KUKA CAD data was derived from public data of KUKA available at:
<a href=\"http://www.kuka-roboter.de/english/produkte/cad/low_payloads.html\">
http://www.kuka-roboter.de/english/produkte/cad/low_payloads.html</a>.
Since dimensions of the corresponding KUKA robot are similar but not
identical to the r3 robot, the data of the r3 robot (such as arm lengths) have been modified, such that it matches the CAD data.
</p>
<p>
In this model, a simplified P-PI cascade controller for every
axes is used. The parameters have been manually adjusted by
simulations. The original r3 controllers are more complicated.
The reason to use simplified controllers is to have a simpler demo.
</p>
</HTML>
"));
end RobotR3;
