within Modelica.Mechanics.MultiBody.Examples.Systems;
package RobotR3
  "Library to demonstrate robot system models based on the Manutec r3 robot"

  model oneAxis
    "Model of one axis of robot (controller, motor, gearbox) with simple load"

    extends Modelica.Icons.Example;
    parameter SI.Mass mLoad(min=0)=15 "Mass of load";
    parameter Real kp=5 "Gain of position controller of axis 2";
    parameter Real ks=0.5 "Gain of speed controller of axis 2";
    parameter SI.Time Ts=0.05
      "Time constant of integrator of speed controller of axis 2";
    parameter Real startAngle(unit="deg") = 0 "Start angle of axis 2";
    parameter Real endAngle(unit="deg") = 120 "End angle of axis 2";

    parameter SI.Time swingTime=0.5
      "Additional time after reference motion is in rest before simulation is stopped";
    parameter SI.AngularVelocity refSpeedMax=3 "Maximum reference speed";
    parameter SI.AngularAcceleration refAccMax=10
      "Maximum reference acceleration";

    Components.AxisType1 axis(
      w=5500,
      ratio=210,
      c=8,
      cd=0.01,
      Rv0=0.5,
      Rv1=(0.1/130),
      kp=kp,
      ks=ks,
      Ts=Ts) annotation (Placement(transformation(extent={{20,0},{40,20}})));
    Modelica.Mechanics.Rotational.Components.Inertia load(J=1.3*mLoad)
      annotation (Placement(transformation(extent={{60,0},{80,20}})));
    Components.PathPlanning1 pathPlanning(
      swingTime=swingTime,
      angleBegDeg=startAngle,
      angleEndDeg=endAngle,
      speedMax=refSpeedMax,
      accMax=refAccMax) annotation (Placement(transformation(extent={{-60,0},
              {-40,20}})));
  protected
    Components.ControlBus controlBus annotation (Placement(transformation(
            extent={{-32,10},{8,50}})));
  equation
    connect(axis.flange, load.flange_a)
      annotation (Line(
        points={{40,10},{60,10}},
        color={128,128,128},
        thickness=0.5));
    connect(pathPlanning.controlBus, controlBus) annotation (Line(
        points={{-40,10},{-15,10},{-15,28},{-12,28},{-12,30}},
        color={255,204,51},
        thickness=0.5));
    connect(controlBus.axisControlBus1, axis.axisControlBus) annotation (
      Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}), Line(
        points={{-11.9,30.1},{-11.9,29},{-9,29},{-9,10},{20,10}},
        color={255,204,51},
        thickness=0.5));
    annotation (
      Documentation(info="<html>
<p>
With this model one axis of the r3 robot is checked.
The mechanical structure is replaced by a simple
load inertia.
</p>
</html>"),      experiment(StopTime=1.6),
      __Dymola_Commands(file="modelica://Modelica/Resources/Scripts/Dymola/Mechanics/MultiBody/Examples/Systems/oneAxisPlot.mos"
          "Plot result"));
  end oneAxis;

  model fullRobot
    "Six degree of freedom robot with path planning, controllers, motors, brakes, gears and mechanics"
    extends Modelica.Icons.Example;

    parameter SI.Mass mLoad(min=0) = 15 "Mass of load";
    parameter SI.Position rLoad[3]={0.1,0.25,0.1}
      "Distance from last flange to load mass";
    parameter SI.Acceleration g=9.81 "Gravity acceleration";
    parameter SI.Time refStartTime=0 "Start time of reference motion";
    parameter SI.Time refSwingTime=0.5
      "Additional time after reference motion is in rest before simulation is stopped";

    parameter Real startAngle1(unit="deg") = -60 "Start angle of axis 1"
      annotation (Dialog(tab="Reference", group="startAngles"));
    parameter Real startAngle2(unit="deg") = 20 "Start angle of axis 2"
      annotation (Dialog(tab="Reference", group="startAngles"));
    parameter Real startAngle3(unit="deg") = 90 "Start angle of axis 3"
      annotation (Dialog(tab="Reference", group="startAngles"));
    parameter Real startAngle4(unit="deg") = 0 "Start angle of axis 4"
      annotation (Dialog(tab="Reference", group="startAngles"));
    parameter Real startAngle5(unit="deg") = -110 "Start angle of axis 5"
      annotation (Dialog(tab="Reference", group="startAngles"));
    parameter Real startAngle6(unit="deg") = 0 "Start angle of axis 6"
      annotation (Dialog(tab="Reference", group="startAngles"));

    parameter Real endAngle1(unit="deg") = 60 "End angle of axis 1"
      annotation (Dialog(tab="Reference", group="endAngles"));
    parameter Real endAngle2(unit="deg") = -70 "End angle of axis 2"
      annotation (Dialog(tab="Reference", group="endAngles"));
    parameter Real endAngle3(unit="deg") = -35 "End angle of axis 3"
      annotation (Dialog(tab="Reference", group="endAngles"));
    parameter Real endAngle4(unit="deg") = 45 "End angle of axis 4"
      annotation (Dialog(tab="Reference", group="endAngles"));
    parameter Real endAngle5(unit="deg") = 110 "End angle of axis 5"
      annotation (Dialog(tab="Reference", group="endAngles"));
    parameter Real endAngle6(unit="deg") = 45 "End angle of axis 6"
      annotation (Dialog(tab="Reference", group="endAngles"));

    parameter SI.AngularVelocity refSpeedMax[6]={3,1.5,5,3.1,3.1,4.1}
      "Maximum reference speeds of all joints"
      annotation (Dialog(tab="Reference", group="Limits"));
    parameter SI.AngularAcceleration refAccMax[6]={15,15,15,60,60,60}
      "Maximum reference accelerations of all joints"
      annotation (Dialog(tab="Reference", group="Limits"));

    parameter Real kp1=5 "Gain of position controller"
      annotation (Dialog(tab="Controller", group="Axis 1"));
    parameter Real ks1=0.5 "Gain of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 1"));
    parameter SI.Time Ts1=0.05
      "Time constant of integrator of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 1"));
    parameter Real kp2=5 "Gain of position controller"
      annotation (Dialog(tab="Controller", group="Axis 2"));
    parameter Real ks2=0.5 "Gain of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 2"));
    parameter SI.Time Ts2=0.05
      "Time constant of integrator of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 2"));
    parameter Real kp3=5 "Gain of position controller"
      annotation (Dialog(tab="Controller", group="Axis 3"));
    parameter Real ks3=0.5 "Gain of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 3"));
    parameter SI.Time Ts3=0.05
      "Time constant of integrator of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 3"));
    parameter Real kp4=5 "Gain of position controller"
      annotation (Dialog(tab="Controller", group="Axis 4"));
    parameter Real ks4=0.5 "Gain of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 4"));
    parameter SI.Time Ts4=0.05
      "Time constant of integrator of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 4"));
    parameter Real kp5=5 "Gain of position controller"
      annotation (Dialog(tab="Controller", group="Axis 5"));
    parameter Real ks5=0.5 "Gain of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 5"));
    parameter SI.Time Ts5=0.05
      "Time constant of integrator of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 5"));
    parameter Real kp6=5 "Gain of position controller"
      annotation (Dialog(tab="Controller", group="Axis 6"));
    parameter Real ks6=0.5 "Gain of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 6"));
    parameter SI.Time Ts6=0.05
      "Time constant of integrator of speed controller"
      annotation (Dialog(tab="Controller", group="Axis 6"));
    Components.MechanicalStructure mechanics(
      mLoad=mLoad,
      rLoad=rLoad,
      g=g) annotation (Placement(transformation(extent={{40,-30},{100,30}})));
    Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.PathPlanning6
      pathPlanning(
      naxis=6,
      angleBegDeg={startAngle1,startAngle2,startAngle3,startAngle4,startAngle5,
          startAngle6},
      angleEndDeg={endAngle1,endAngle2,endAngle3,endAngle4,endAngle5,endAngle6},
      speedMax=refSpeedMax,
      accMax=refAccMax,
      startTime=refStartTime,
      swingTime=refSwingTime) annotation (Placement(transformation(extent={{0,70},{-20,90}})));

    RobotR3.Components.AxisType1 axis1(
      w=4590,
      ratio=-105,
      c=43,
      cd=0.005,
      Rv0=0.4,
      Rv1=(0.13/160),
      kp=kp1,
      ks=ks1,
      Ts=Ts1) annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
    RobotR3.Components.AxisType1 axis2(
      w=5500,
      ratio=210,
      c=8,
      cd=0.01,
      Rv1=(0.1/130),
      Rv0=0.5,
      kp=kp2,
      ks=ks2,
      Ts=Ts2) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));

    RobotR3.Components.AxisType1 axis3(
      w=5500,
      ratio=60,
      c=58,
      cd=0.04,
      Rv0=0.7,
      Rv1=(0.2/130),
      kp=kp3,
      ks=ks3,
      Ts=Ts3) annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
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
      Ts=Ts4) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
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
      Ts=Ts5) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
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
      Ts=Ts6) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  protected
    Components.ControlBus controlBus
      annotation (Placement(transformation(
          origin={-80,0},
          extent={{-20,-20},{20,20}},
          rotation=90)));
  equation
    connect(axis2.flange, mechanics.axis2) annotation (Line(points={{0,-30},{20,-30},{20,-13.5},{40,-13.5}}));
    connect(axis1.flange, mechanics.axis1) annotation (Line(points={{0,-50},{30,-50},{30,-22.5},{40,-22.5}}));
    connect(axis3.flange, mechanics.axis3) annotation (Line(points={{0,-10},{10,-10},{10,-4.5},{40,-4.5}}));
    connect(axis4.flange, mechanics.axis4) annotation (Line(points={{0,10},{10,10},{10,4.5},{40,4.5}}));
    connect(axis5.flange, mechanics.axis5)
      annotation (Line(points={{0,30},{20,30},{20,13.5},{40,13.5}}));
    connect(axis6.flange, mechanics.axis6) annotation (Line(points={{0,50},{30,50},{30,22.5},{40,22.5}}));
    connect(controlBus, pathPlanning.controlBus)
                                         annotation (Line(
        points={{-80,0},{-80,80},{-20,80}},
        color={255,204,51},
        thickness=0.5));
    connect(controlBus.axisControlBus1, axis1.axisControlBus) annotation (
      Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}), Line(
        points={{-80.1,0.1},{-80.1,-4.5},{-79,-4.5},{-79,-7},{-68,-7},{-68,-50},{-20,-50}},
        color={255,204,51},
        thickness=0.5));

    connect(controlBus.axisControlBus2, axis2.axisControlBus) annotation (
      Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}), Line(
        points={{-80.1,0.1},{-79,0.1},{-79,-5},{-64,-5},{-64,-30},{-20,-30}},
        color={255,204,51},
        thickness=0.5));

    connect(controlBus.axisControlBus3, axis3.axisControlBus) annotation (Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}), Line(
        points={{-80.1,0.1},{-77,0.1},{-77,-2.5},{-60,-2.5},{-60,-10},{-20,-10}},
        color={255,204,51},
        thickness=0.5));

    connect(controlBus.axisControlBus4, axis4.axisControlBus) annotation (Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}), Line(
        points={{-80.1,0.1},{-60,0.1},{-60,10},{-20,10}},
        color={255,204,51},
        thickness=0.5));
    connect(controlBus.axisControlBus5, axis5.axisControlBus) annotation (
      Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}), Line(
        points={{-80.1,0.1},{-77,0.1},{-77,3},{-64,3},{-64,30},{-20,30}},
        color={255,204,51},
        thickness=0.5));
    connect(controlBus.axisControlBus6, axis6.axisControlBus) annotation (
      Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}), Line(
        points={{-80.1,0.1},{-79,0.1},{-79,5},{-68,5},{-68,50},{-20,50}},
        color={255,204,51},
        thickness=0.5));
    annotation (
      experiment(StopTime=2),
      __Dymola_Commands(
        file="modelica://Modelica/Resources/Scripts/Dymola/Mechanics/MultiBody/Examples/Systems/Run.mos"
          "Simulate",
        file="modelica://Modelica/Resources/Scripts/Dymola/Mechanics/MultiBody/Examples/Systems/fullRobotPlot.mos"
          "Plot result of axis 3 + animate"),
      Documentation(info="<html>
<p>
This example animates a motion of a detailed model of the robot
with predefined axes' angles over time.
For animation, CAD data is used.
Translate and simulate with the default settings
(default simulation stop time = 2&nbsp;s).
</p>
<p>
The path planning block incorporates a simulation termination condition.
Thus, the simulation can be terminated before reaching the stop time.
The condition depends on the start and end positions of the joints, and on their
reference speeds and reference accelerations.
For current settings, the termination condition should indeed be fulfilled right before the simulation stops.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Systems/r3_fullRobot.png\" alt=\"model Examples.Loops.Systems.RobotR3.fullRobot\">
</p>
</html>"));
  end fullRobot;
  extends Modelica.Icons.ExamplesPackage;

  package Components "Library of components of the robot"
    extends Modelica.Icons.Package;

    expandable connector AxisControlBus "Data bus for one robot axis"
      extends Modelica.Icons.SignalSubBus;

      Boolean motion_ref "= true, if reference motion is not in rest" annotation(HideResult=false);
      SI.Angle angle_ref "Reference angle of axis flange" annotation(HideResult=false);
      SI.Angle angle "Angle of axis flange" annotation(HideResult=false);
      SI.AngularVelocity speed_ref "Reference speed of axis flange" annotation(HideResult=false);
      SI.AngularVelocity speed "Speed of axis flange" annotation(HideResult=false);
      SI.AngularAcceleration acceleration_ref
        "Reference acceleration of axis flange" annotation(HideResult=false);
      SI.AngularAcceleration acceleration "Acceleration of axis flange" annotation(HideResult=false);
      SI.Current current_ref "Reference current of motor" annotation(HideResult=false);
      SI.Current current "Current of motor" annotation(HideResult=false);
      SI.Angle motorAngle "Angle of motor flange" annotation(HideResult=false);
      SI.AngularVelocity motorSpeed "Speed of motor flange" annotation(HideResult=false);

      annotation (defaultComponentPrefixes="protected",
                  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}})),
        Documentation(info="<html>
<p>
Signal bus that is used to communicate all signals for <strong>one</strong> axis.
This is an expandable connector which has a \"default\" set of
signals. Note, the input/output causalities of the signals are
determined from the connections to this bus.
</p>

</html>"));
    end AxisControlBus;

    expandable connector ControlBus "Data bus for all axes of robot"
      extends Modelica.Icons.SignalBus;
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus1 "Bus of axis 1";
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus2 "Bus of axis 2";
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus3 "Bus of axis 3";
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus4 "Bus of axis 4";
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus5 "Bus of axis 5";
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus6 "Bus of axis 6";

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}})),
        Documentation(info="<html>
<p>
Signal bus that is used to communicate <strong>all signals</strong> of the robot.
This is an expandable connector which has a \"default\" set of
signals. Note, the input/output causalities of the signals are
determined from the connections to this bus.
</p>
</html>"));
    end ControlBus;

    model PathPlanning1
      "Generate reference angles for fastest kinematic movement"
      extends Blocks.Icons.Block;

      parameter Real angleBegDeg(unit="deg") = 0 "Start angle";
      parameter Real angleEndDeg(unit="deg") = 1 "End angle";
      parameter SI.AngularVelocity speedMax = 3 "Maximum axis speed";
      parameter SI.AngularAcceleration accMax = 2.5 "Maximum axis acceleration";
      parameter SI.Time startTime=0 "Start time of movement";
      parameter SI.Time swingTime=0.5
        "Additional time after reference motion is in rest before simulation is stopped";
      final parameter SI.Angle angleBeg=Cv.from_deg(angleBegDeg) "Start angles";
      final parameter SI.Angle angleEnd=Cv.from_deg(angleEndDeg) "End angles";
      ControlBus controlBus
        annotation (Placement(transformation(
            origin={100,0},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Blocks.Sources.KinematicPTP2 path(
        q_end={angleEnd},
        qd_max={speedMax},
        qdd_max={accMax},
        startTime=startTime,
        q_begin={angleBeg})
                          annotation (Placement(transformation(extent={{-50,-10},
                {-30,10}})));
      PathToAxisControlBus pathToAxis1(final nAxis=1, final axisUsed=1)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));

      Blocks.Logical.TerminateSimulation terminateSimulation(condition=time >= path.endTime
             + swingTime) annotation (Placement(transformation(extent={{-50,-30},
                {30,-24}})));
    equation
      connect(path.q, pathToAxis1.q) annotation (Line(points={{-29,8},{
              -2,8}}, color={0,0,127}));
      connect(path.qd, pathToAxis1.qd) annotation (Line(points={{-29,3},
              {-2,3}}, color={0,0,127}));
      connect(path.qdd, pathToAxis1.qdd) annotation (Line(points={{-29,
              -3},{-2,-3}}, color={0,0,127}));
      connect(path.moving, pathToAxis1.moving) annotation (Line(
            points={{-29,-8},{-2,-8}}, color={255,0,255}));
      connect(pathToAxis1.axisControlBus, controlBus.axisControlBus1) annotation (
        Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(
          points={{20,0},{60,0},{60,-0.1},{100.1,-0.1}},
          color={255,204,51},
          thickness=0.5));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,78},{-80,-82}}, color={192,192,192}),
            Line(points={{-90,0},{82,0}}, color={192,192,192}),
            Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-42,55},{29,12}},
              lineColor={192,192,192},
              textString="w"),
            Line(points={{-80,0},{-41,69},{26,69},{58,0}}),
            Text(
              extent={{-73,-44},{82,-69}},
              textString="1 axis")}),
        Documentation(info="<html>
<p>
Given
</p>
<ul>
<li> start and end angle of an axis</li>
<li> maximum speed of the axis</li>
<li> maximum acceleration of the axis</li>
</ul>

<p>
this component computes the fastest movement under the
given constraints. This means, that:
</p>

<ol>
<li> The axis accelerates with the maximum acceleration
     until the maximum speed is reached.</li>
<li> Drives with the maximum speed as long as possible.</li>
<li> Decelerates with the negative of the maximum acceleration
     until rest.</li>
</ol>

<p>
The acceleration, constant velocity and deceleration
phase are determined in such a way that the movement
starts form the start angles and ends at the end angles.
The output of this block are the computed angles, angular velocities
and angular acceleration and this information is stored as reference
motion on the controlBus of the r3 robot.
</p>

</html>"));
    end PathPlanning1;

    model PathPlanning6
      "Generate reference angles for fastest kinematic movement"
      extends Blocks.Icons.Block;

      parameter Integer naxis=6 "Number of driven axis";
      parameter Real angleBegDeg[naxis](each unit="deg") = zeros(naxis)
        "Start angles";
      parameter Real angleEndDeg[naxis](each unit="deg") = ones(naxis)
        "End angles";
      parameter SI.AngularVelocity speedMax[naxis]=fill(3, naxis)
        "Maximum axis speed";
      parameter SI.AngularAcceleration accMax[naxis]=fill(2.5, naxis)
        "Maximum axis acceleration";
      parameter SI.Time startTime=0 "Start time of movement";
      parameter SI.Time swingTime=0.5
        "Additional time after reference motion is in rest before simulation is stopped";
      final parameter SI.Angle angleBeg[:]=Cv.from_deg(angleBegDeg)
        "Start angles";
      final parameter SI.Angle angleEnd[:]=Cv.from_deg(angleEndDeg)
        "End angles";
      ControlBus controlBus
        annotation (Placement(transformation(
            origin={100,0},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Blocks.Sources.KinematicPTP2 path(
        q_end=angleEnd,
        qd_max=speedMax,
        qdd_max=accMax,
        startTime=startTime,
        q_begin=angleBeg) annotation (Placement(transformation(extent={{-90,-80},
                {-70,-60}})));
      PathToAxisControlBus pathToAxis1(nAxis=naxis, axisUsed=1)
        annotation (Placement(transformation(extent={{-10,70},{10,90}})));
      PathToAxisControlBus pathToAxis2(nAxis=naxis, axisUsed=2)
        annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      PathToAxisControlBus pathToAxis3(nAxis=naxis, axisUsed=3)
        annotation (Placement(transformation(extent={{-10,10},{10,30}})));
      PathToAxisControlBus pathToAxis4(nAxis=naxis, axisUsed=4)
        annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
      PathToAxisControlBus pathToAxis5(nAxis=naxis, axisUsed=5)
        annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
      PathToAxisControlBus pathToAxis6(nAxis=naxis, axisUsed=6)
        annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));

      Blocks.Logical.TerminateSimulation terminateSimulation(condition=time >= path.endTime
             + swingTime) annotation (Placement(transformation(extent={{-50,
                -100},{30,-94}})));
    equation
      connect(path.q, pathToAxis1.q) annotation (Line(points={{-69,-62},
              {-60,-62},{-60,88},{-12,88}}, color={0,0,127}));
      connect(path.qd, pathToAxis1.qd) annotation (Line(points={{-69,
              -67},{-59,-67},{-59,83},{-12,83}}, color={0,0,127}));
      connect(path.qdd, pathToAxis1.qdd) annotation (Line(points={{-69,
              -73},{-58,-73},{-58,77},{-12,77}}, color={0,0,127}));
      connect(path.moving, pathToAxis1.moving) annotation (Line(
            points={{-69,-78},{-57,-78},{-57,72},{-12,72}}, color={255,0,255}));
      connect(path.q, pathToAxis2.q) annotation (Line(points={{-69,-62},
              {-60,-62},{-60,58},{-12,58}}, color={0,0,127}));
      connect(path.qd, pathToAxis2.qd) annotation (Line(points={{-69,
              -67},{-59,-67},{-59,53},{-12,53}}, color={0,0,127}));
      connect(path.qdd, pathToAxis2.qdd) annotation (Line(points={{-69,
              -73},{-58,-73},{-58,47},{-12,47}}, color={0,0,127}));
      connect(path.moving, pathToAxis2.moving) annotation (Line(
            points={{-69,-78},{-57,-78},{-57,42},{-12,42}}, color={255,0,255}));
      connect(path.q, pathToAxis3.q) annotation (Line(points={{-69,-62},
              {-60,-62},{-60,28},{-12,28}}, color={0,0,127}));
      connect(path.qd, pathToAxis3.qd) annotation (Line(points={{-69,
              -67},{-59,-67},{-59,23},{-12,23}}, color={0,0,127}));
      connect(path.qdd, pathToAxis3.qdd) annotation (Line(points={{-69,
              -73},{-58,-73},{-58,17},{-12,17}}, color={0,0,127}));
      connect(path.moving, pathToAxis3.moving) annotation (Line(
            points={{-69,-78},{-57,-78},{-57,12},{-12,12}}, color={255,0,255}));
      connect(path.q, pathToAxis4.q) annotation (Line(points={{-69,-62},
              {-60,-62},{-60,-2},{-12,-2}}, color={0,0,127}));
      connect(path.qd, pathToAxis4.qd) annotation (Line(points={{-69,
              -67},{-59,-67},{-59,-7},{-12,-7}}, color={0,0,127}));
      connect(path.qdd, pathToAxis4.qdd) annotation (Line(points={{-69,
              -73},{-58,-73},{-58,-13},{-12,-13}}, color={0,0,127}));
      connect(path.moving, pathToAxis4.moving) annotation (Line(
            points={{-69,-78},{-57,-78},{-57,-18},{-12,-18}}, color={255,0,255}));
      connect(path.q, pathToAxis5.q) annotation (Line(points={{-69,-62},
              {-60,-62},{-60,-32},{-12,-32}}, color={0,0,127}));
      connect(path.qd, pathToAxis5.qd) annotation (Line(points={{-69,
              -67},{-59,-67},{-59,-37},{-12,-37}}, color={0,0,127}));
      connect(path.qdd, pathToAxis5.qdd) annotation (Line(points={{-69,
              -73},{-58,-73},{-58,-43},{-12,-43}}, color={0,0,127}));
      connect(path.moving, pathToAxis5.moving) annotation (Line(
            points={{-69,-78},{-57,-78},{-57,-48},{-12,-48}}, color={255,0,255}));
      connect(path.q, pathToAxis6.q) annotation (Line(points={{-69,-62},
              {-12,-62}}, color={0,0,127}));
      connect(path.qd, pathToAxis6.qd) annotation (Line(points={{-69,
              -67},{-12,-67}}, color={0,0,127}));
      connect(path.qdd, pathToAxis6.qdd) annotation (Line(points={{-69,
              -73},{-12,-73}}, color={0,0,127}));
      connect(path.moving, pathToAxis6.moving) annotation (Line(
            points={{-69,-78},{-12,-78}}, color={255,0,255}));
      connect(pathToAxis1.axisControlBus, controlBus.axisControlBus1) annotation (
        Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(
          points={{10,80},{80,80},{80,6},{100,6},{100,-0.1},{100.1,-0.1}},
          color={255,204,51},
          thickness=0.5));
      connect(pathToAxis2.axisControlBus, controlBus.axisControlBus2) annotation (
        Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(
          points={{10,50},{70,50},{70,4},{100,4},{100,-0.1},{100.1,-0.1}},
          color={255,204,51},
          thickness=0.5));
      connect(pathToAxis3.axisControlBus, controlBus.axisControlBus3) annotation (Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(
          points={{10,20},{60,20},{60,2},{100,2},{100,-0.1},{100.1,-0.1}},
          color={255,204,51},
          thickness=0.5));
      connect(pathToAxis4.axisControlBus, controlBus.axisControlBus4) annotation (Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(
          points={{10,-10},{60,-10},{60,-0.1},{100.1,-0.1}},
          color={255,204,51},
          thickness=0.5));
      connect(pathToAxis5.axisControlBus, controlBus.axisControlBus5) annotation (
        Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(
          points={{10,-40},{70,-40},{70,-3},{100.1,-3},{100.1,-0.1}},
          color={255,204,51},
          thickness=0.5));
      connect(pathToAxis6.axisControlBus, controlBus.axisControlBus6) annotation (
        Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(
          points={{10,-70},{80,-70},{80,-6},{100,-6},{100,-0.1},{100.1,-0.1}},
          color={255,204,51},
          thickness=0.5));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,78},{-80,-82}}, color={192,192,192}),
            Line(points={{-90,0},{82,0}}, color={192,192,192}),
            Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-42,55},{29,12}},
              lineColor={192,192,192},
              textString="w"),
            Line(points={{-80,0},{-41,69},{26,69},{58,0}}),
            Text(
              extent={{-70,-43},{85,-68}},
              textString="6 axes")}),
        Documentation(info="<html>
<p>
Given
</p>
<ul>
<li> start and end angles of every axis</li>
<li> maximum speed of every axis</li>
<li> maximum acceleration of every axis</li>
</ul>

<p>
this component computes the fastest movement under the
given constraints. This means, that:
</p>

<ol>
<li> Every axis accelerates with the maximum acceleration
     until the maximum speed is reached.</li>
<li> Drives with the maximum speed as long as possible.</li>
<li> Decelerates with the negative of the maximum acceleration
     until rest.</li>
</ol>

<p>
The acceleration, constant velocity and deceleration
phase are determined in such a way that the movement
starts form the start angles and ends at the end angles.
The output of this block are the computed angles, angular velocities
and angular acceleration and this information is stored as reference
motion on the controlBus of the r3 robot.
</p>

</html>"));
    end PathPlanning6;

    model PathToAxisControlBus "Map path planning to one axis control bus"
      extends Modelica.Blocks.Icons.Block;

      parameter Integer nAxis=6 "Number of driven axis";
      parameter Integer axisUsed=1
        "Map path planning of axisUsed to axisControlBus";
      Blocks.Interfaces.RealInput q[nAxis]
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Blocks.Interfaces.RealInput qd[nAxis]
        annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
      Blocks.Interfaces.RealInput qdd[nAxis]
        annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
      AxisControlBus axisControlBus
        annotation (Placement(transformation(
            origin={100,0},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Blocks.Routing.RealPassThrough q_axisUsed
        annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
      Blocks.Routing.RealPassThrough qd_axisUsed
        annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
      Blocks.Routing.RealPassThrough qdd_axisUsed
        annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
      Blocks.Interfaces.BooleanInput moving[nAxis]
        annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
      Blocks.Routing.BooleanPassThrough motion_ref_axisUsed
        annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    equation
      connect(q_axisUsed.u, q[axisUsed]) annotation (Line(points={{-42,60},{-60,
              60},{-60,80},{-120,80}}, color={0,0,127}));
      connect(qd_axisUsed.u, qd[axisUsed]) annotation (Line(points={{-42,20},{
              -80,20},{-80,30},{-120,30}}, color={0,0,127}));
      connect(qdd_axisUsed.u, qdd[axisUsed]) annotation (Line(points={{-42,-20},
              {-80,-20},{-80,-30},{-120,-30}}, color={0,0,127}));
      connect(motion_ref_axisUsed.u, moving[axisUsed]) annotation (Line(
            points={{-42,-60},{-60,-60},{-60,-80},{-120,-80}}, color={255,0,255}));
      connect(motion_ref_axisUsed.y, axisControlBus.motion_ref) annotation (
        Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(points={{-19,-60},{24,-60},{24,-8},{100,-8},{100,-0.1},{100.1,-0.1}},
                                        color={255,0,255}));
      connect(qdd_axisUsed.y, axisControlBus.acceleration_ref) annotation (
        Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(points={{-19,-20},{20,-20},{20,-4},{100,-4},{100,-0.1},{100.1,-0.1}},
                                      color={0,0,127}));
      connect(qd_axisUsed.y, axisControlBus.speed_ref) annotation (
        Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(points={{-19,20},{20,20},{20,0},{100.1,0},{100.1,-0.1}},
                      color={0,0,127}));
      connect(q_axisUsed.y, axisControlBus.angle_ref) annotation (
        Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}), Line(points={{-19,60},{24,60},{24,4},{100,4},{100,-0.1},{100.1,-0.1}},
                      color={0,0,127}));
      annotation (defaultComponentName="pathToAxis1",
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-100,98},{-24,68}},
              textString="q"),
            Text(
              extent={{-94,46},{-18,16}},
              textString="qd"),
            Text(
              extent={{-96,-16},{-20,-46}},
              textString="qdd"),
            Text(
              extent={{-2,20},{80,-18}},
              textString="%axisUsed"),
            Text(
              extent={{2,52},{76,28}},
              textString="axis"),
            Text(
              extent={{-94,-70},{32,-96}},
              textString="moving")}),
        Documentation(info="<html>
<p>
This model stores the 4 reference variables q, qd, qdd, moving from the path planning on the axis control bus.
</p>
</html>"));
    end PathToAxisControlBus;

    model GearType1 "Motor inertia and gearbox model for r3 joints 1,2,3"
      extends Modelica.Mechanics.Rotational.Icons.Gearbox;
      extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;

      parameter Real i=-105 "Gear ratio";
      parameter Real c(unit="N.m/rad") = 43 "Spring constant";
      parameter Real d(unit="N.m.s/rad") = 0.005 "Damper constant";
      parameter SI.Torque Rv0=0.4 "Viscous friction torque at zero velocity";
      parameter Real Rv1(unit="N.m.s/rad") = (0.13/160)
        "Viscous friction coefficient (R=Rv0+Rv1*abs(qd))";
      parameter Real peak=1
        "Maximum static friction torque is peak*Rv0 (peak >= 1)";
      SI.AngularAcceleration a_rel=der(spring.w_rel)
        "Relative angular acceleration of spring";
      constant SI.AngularVelocity unitAngularVelocity = 1;
      constant SI.Torque unitTorque = 1;

      Modelica.Mechanics.Rotational.Components.IdealGear gear(
                                                   ratio=i, useSupport=false)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Mechanics.Rotational.Components.SpringDamper spring(
                                                        c=c, d=d)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
                                                                    tau_pos=[0,
             Rv0/unitTorque; 1, (Rv0 + Rv1*unitAngularVelocity)/unitTorque],
          useSupport=false) annotation (Placement(
            transformation(extent={{-60,-10},{-40,10}})));
    equation
      connect(spring.flange_b, gear.flange_a)
        annotation (Line(points={{10,0},{40,0}}));
      connect(bearingFriction.flange_b, spring.flange_a)
        annotation (Line(points={{-40,0},{-10,0}}));
      connect(gear.flange_b, flange_b)
        annotation (Line(points={{60,0},{100,0}}));
      connect(bearingFriction.flange_a, flange_a)
        annotation (Line(points={{-60,0},{-100,0}}));
    initial equation
      spring.w_rel = 0;
      a_rel = 0;
      annotation (
        Documentation(info="<html>
<p>
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
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-150,100},{150,60}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-36,40},{36,-30}},
              textString="1")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{72,30},{130,22}},
              textString="flange of joint axis"), Text(
              extent={{-128,26},{-70,18}},
              textString="flange of motor axis")}));
    end GearType1;

    model GearType2 "Motor inertia and gearbox model for r3 joints 4,5,6"
      extends Modelica.Mechanics.Rotational.Icons.Gearbox;
      extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;

      parameter Real i=-99 "Gear ratio";
      parameter SI.Torque Rv0=21.8 "Viscous friction torque at zero velocity";
      parameter Real Rv1=9.8
        "Viscous friction coefficient in [Nms/rad] (R=Rv0+Rv1*abs(qd))";
      parameter Real peak=(26.7/21.8)
        "Maximum static friction torque is peak*Rv0 (peak >= 1)";

      constant SI.AngularVelocity unitAngularVelocity = 1;
      constant SI.Torque unitTorque = 1;
      Modelica.Mechanics.Rotational.Components.IdealGear gear(
                                                   ratio=i, useSupport=false)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
                                                                    tau_pos=[0,
             Rv0/unitTorque; 1, (Rv0 + Rv1*unitAngularVelocity)/unitTorque], peak=peak,
        useSupport=false)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    equation
      connect(gear.flange_b, bearingFriction.flange_a)
        annotation (Line(points={{-20,0},{20,0}}));
      connect(bearingFriction.flange_b, flange_b)
        annotation (Line(points={{40,0},{100,0}}));
      connect(gear.flange_a, flange_a)
        annotation (Line(points={{-40,0},{-100,0}}));
      annotation (
        Documentation(info="<html>
<p>
The elasticity and damping in the gearboxes of the outermost
three joints of the robot is neglected.
Default values for all parameters are given for joint 4.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-150,100},{150,60}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-36,40},{36,-30}},
              textString="2")}));
    end GearType2;

    model Motor "Motor model including current controller of r3 motors"
      extends Electrical.Machines.Icons.Machine;
      parameter SI.Inertia J(min=0)=0.0013 "Moment of inertia of motor";
      parameter Real k=1.1616 "Gain of motor";
      parameter Real w=4590 "Time constant of motor";
      parameter Real D=0.6 "Damping constant of motor";
      parameter SI.AngularVelocity w_max=315 "Maximum speed of motor";
      parameter SI.Current i_max=9 "Maximum current of motor";

      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_motor
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Electrical.Analog.Sources.SignalVoltage Vs
        annotation (Placement(transformation(
            origin={-80,-40},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.IdealOpAmp power
        annotation (Placement(transformation(extent={{40,50},{60,70}})));
      Modelica.Electrical.Analog.Ideal.IdealOpAmp diff
        annotation (Placement(transformation(extent={{-60,34},{-40,54}})));
      Electrical.Analog.Basic.EMF emf( k=k, useSupport=false)
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
      Modelica.Electrical.Analog.Basic.Inductor La(L=(250/(2*D*w)))
        annotation (Placement(transformation(
            origin={80,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor Ra(R=250)
        annotation (Placement(transformation(
            origin={80,60},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor Rd2(R=100)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,-10})));
      Modelica.Electrical.Analog.Basic.Capacitor C(C=0.004*D/w)
        annotation (Placement(transformation(extent={{0,60},{20,80}})));
      Modelica.Electrical.Analog.Ideal.IdealOpAmp OpI
        annotation (Placement(transformation(extent={{0,34},{20,54}})));
      Modelica.Electrical.Analog.Basic.Resistor Ri(R=10)
        annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
      Modelica.Electrical.Analog.Basic.Resistor Rd1(R=100)
        annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
      Modelica.Electrical.Analog.Basic.Resistor Rp1(R=200)
        annotation (Placement(transformation(extent={{41,82},{56,98}})));
      Modelica.Electrical.Analog.Basic.Resistor Rp2(R=50)
        annotation (Placement(transformation(
            origin={20,90},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      Modelica.Electrical.Analog.Basic.Resistor Rd4(R=100)
        annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
      Modelica.Electrical.Analog.Sources.SignalVoltage hall2
        annotation (Placement(transformation(
            origin={-60,-40},
            extent={{10,10},{-10,-10}},
            rotation=90)));
      Modelica.Electrical.Analog.Basic.Resistor Rd3(R=100)
        annotation (Placement(transformation(
            origin={-60,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Basic.Ground g1
        annotation (Placement(transformation(extent={{-90,-74},{-70,-54}})));
      Modelica.Electrical.Analog.Basic.Ground g2
        annotation (Placement(transformation(extent={{-70,-74},{-50,-54}})));
      Modelica.Electrical.Analog.Basic.Ground g3
        annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor hall1
        annotation (Placement(transformation(
            origin={20,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground g4
        annotation (Placement(transformation(extent={{10,-74},{30,-54}})));
      Modelica.Electrical.Analog.Basic.Ground g5
        annotation (Placement(transformation(
            origin={-6,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Sensors.AngleSensor phi
        annotation (Placement(transformation(
            origin={80,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed
        annotation (Placement(transformation(
            origin={50,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia Jmotor(
                                                   J=J)
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus
        annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
      Blocks.Math.Gain convert1(k(unit="V/A")=1)
                                annotation (Placement(transformation(extent={{-24,-46},{-36,-34}})));
      Blocks.Math.Gain convert2(k(unit="V/A")=1)
                                annotation (Placement(transformation(extent={{-64,-97},{-76,-85}})));
    initial equation
      // initialize motor in steady state
      der(C.v) = 0;
      der(La.i) = 0;

    equation
      connect(La.n, emf.p) annotation (Line(points={{80,20},{40,20},{40,10}}, color={0,0,255}));
      connect(Ra.n, La.p) annotation (Line(points={{80,50},{80,40}}));
      connect(Rd2.n, diff.n1) annotation (Line(points={{-80,0},{-80,50},{-60,50}}, color={0,0,255}));
      connect(C.n, OpI.p2) annotation (Line(points={{20,70},{30,70},{30,44},{20,44}}, color={0,0,255}));
      connect(OpI.p2, power.p1) annotation (Line(points={{20,44},{30,44},{30,54},{40,54}}, color={0,0,255}));
      connect(Vs.p, Rd2.p) annotation (Line(points={{-80,-30},{-80,-20}}, color={0,0,255}));
      connect(diff.n1, Rd1.p)
        annotation (Line(points={{-60,50},{-80,50},{-80,70},{-60,70}}, color={0,0,255}));
      connect(Rd1.n, diff.p2) annotation (Line(points={{-40,70},{-30,70},{-30,44},{-40,44}}, color={0,0,255}));
      connect(diff.p2, Ri.p) annotation (Line(points={{-40,44},{-30,44},{-30,60}}, color={0,0,255}));
      connect(Ri.n, OpI.n1) annotation (Line(points={{-10,60},{-10,50},{0,50}}, color={0,0,255}));
      connect(OpI.n1, C.p) annotation (Line(points={{0,50},{-10,50},{-10,70},{0,70}}, color={0,0,255}));
      connect(power.n1, Rp1.p)
        annotation (Line(points={{40,66},{35,66},{35,90},{41,90}}, color={0,0,255}));
      connect(power.p2, Rp1.n) annotation (Line(points={{60,60},{60,90},{56,90}}, color={0,0,255}));
      connect(Rp1.p, Rp2.p) annotation (Line(points={{41,90},{28,90}}));
      connect(power.p2, Ra.p)
        annotation (Line(points={{60,60},{60,80},{80,80},{80,70}}, color={0,0,255}));
      connect(Rd3.p, hall2.p) annotation (Line(points={{-60,-20},{-60,-30}}, color={0,0,255}));
      connect(Rd3.n, diff.p1) annotation (Line(points={{-60,0},{-60,38}}, color={0,0,255}));
      connect(Rd3.n, Rd4.p) annotation (Line(points={{-60,0},{-60,10},{-50,10}}, color={0,0,255}));
      connect(Vs.n, g1.p) annotation (Line(points={{-80,-50},{-80,-54}}, color={0,0,255}));
      connect(g2.p, hall2.n) annotation (Line(points={{-60,-54},{-60,-50}}));
      connect(Rd4.n, g3.p) annotation (Line(points={{-30,10},{-20,10},{-20,0}}, color={0,0,255}));
      connect(g3.p, OpI.p1) annotation (Line(points={{-20,0},{-20,30},{0,30},{0,38}}, color={0,0,255}));
      connect(g5.p, Rp2.n)
        annotation (Line(points={{4,90},{12,90}}));
      connect(emf.n, hall1.p)
        annotation (Line(points={{40,-10},{40,-20},{20,-20},{20,-30}}, color={0,0,255}));
      connect(hall1.n, g4.p) annotation (Line(points={{20,-50},{20,-54}}));
      connect(emf.flange, phi.flange)
        annotation (Line(points={{50,0},{60,0},{60,-30},{80,-30}}));
      connect(emf.flange, speed.flange)
        annotation (Line(points={{50,0},{60,0},{60,-30},{50,-30}}));
      connect(OpI.n2, power.n2)
        annotation (Line(points={{10,34},{10,30},{50,30},{50,50}}, color={0,0,255}));
      connect(OpI.p1, OpI.n2) annotation (Line(points={{0,38},{0,30},{10,30},{10,34}}, color={0,0,255}));
      connect(OpI.p1, diff.n2) annotation (Line(points={{0,38},{0,30},{-50,30},{-50,34}}, color={0,0,255}));
      connect(Jmotor.flange_b, flange_motor)
        annotation (Line(
          points={{90,0},{100,0}},
          color={128,128,128},
          thickness=0.5));
      connect(phi.phi, axisControlBus.motorAngle)
        annotation (Line(points={{80,-51},{80,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,-3},{6,-3}}));
      connect(speed.w, axisControlBus.motorSpeed)
        annotation (Line(points={{50,-51},{50,-98},{0.1,-98},{0.1,-99.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,-3},{6,-3}}));
      connect(hall1.i, axisControlBus.current)
        annotation (Line(points={{9,-40},{0,-40},{0,-100},{0.1,-100},{0.1,-99.9}}, color={0,0,127}), Text(
          string="%second",
          index=2,
          extent={{0,3},{0,3}}));
      connect(hall1.i, convert1.u) annotation (Line(points={{9,-40},{-22.8,-40}}, color={0,0,127}));
      connect(convert1.y, hall2.v) annotation (Line(points={{-36.6,-40},{-48,-40}},
                     color={0,0,127}));
      connect(convert2.u, axisControlBus.current_ref)
        annotation (Line(points={{-62.8,-91},{-50,-91},{-50,-100},{0.1,-100},{0.1,-99.9}},
                                                                      color={0,0,127}),
          Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
      connect(convert2.y, Vs.v) annotation (Line(points={{-76.6,-91},{-100,-91},{-100,-40},{-92,-40}},
                                 color={0,0,127}));
      connect(emf.flange, Jmotor.flange_a) annotation (Line(
          points={{50,0},{70,0}}));
      annotation (
        Documentation(info="<html>
<p>
Default values are given for the motor of joint 1.
The input of the motor is the desired current
(the actual current is proportional to the torque
produced by the motor).
</p>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{-150,110},{150,70}},
              textString="%name",
              lineColor={0,0,255})}));
    end Motor;

    model Controller "P-PI cascade controller for one axis"
      extends Blocks.Icons.Block;

      parameter Real kp=10 "Gain of position controller";
      parameter Real ks=1 "Gain of speed controller";
      parameter SI.Time Ts=0.01
        "Time constant of integrator of speed controller";
      parameter Real ratio=1 "Gear ratio of gearbox";

      Modelica.Blocks.Math.Gain gain1(k=ratio)
        annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Modelica.Blocks.Continuous.PI PI(k=ks, T=Ts)
        annotation (Placement(transformation(extent={{60,0},{80,20}})));
      Modelica.Blocks.Math.Feedback feedback1
        annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
      Modelica.Blocks.Math.Gain P(k=kp) annotation (Placement(transformation(
              extent={{-20,0},{0,20}})));
      Modelica.Blocks.Math.Add3 add3(k3=-1) annotation (Placement(
            transformation(extent={{20,0},{40,20}})));
      Modelica.Blocks.Math.Gain gain2(k=ratio)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus
        annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
    equation
      connect(gain1.y, feedback1.u1)
        annotation (Line(points={{-59,10},{-48,10}}, color={0,0,127}));
      connect(feedback1.y, P.u)
        annotation (Line(points={{-31,10},{-22,10}}, color={0,0,127}));
      connect(P.y, add3.u2) annotation (Line(points={{1,10},{18,10}}, color={0,
              0,127}));
      connect(gain2.y, add3.u1)
        annotation (Line(points={{-39,50},{10,50},{10,18},{18,18}}, color={0,0,
              127}));
      connect(add3.y, PI.u)
        annotation (Line(points={{41,10},{58,10}}, color={0,0,127}));
      connect(gain2.u, axisControlBus.speed_ref)
        annotation (Line(points={{-62,50},{-94,50},{-94,-34},{-6,-34},{-6,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
          string="%second",
          index=2,
          extent={{6,3},{6,3}}));
      connect(gain1.u, axisControlBus.angle_ref)
        annotation (Line(points={{-82,10},{-90,10},{-90,-30},{-4,-30},{-4,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
          string="%second",
          index=3,
          extent={{6,3},{6,3}}));
      connect(feedback1.u2, axisControlBus.motorAngle)
        annotation (Line(points={{-40,2},{-40,-26},{-2,-26},{-2,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
          string="%second",
          index=2,
          extent={{6,3},{6,3}}));
      connect(add3.u3, axisControlBus.motorSpeed)
        annotation (Line(points={{18,2},{10,2},{10,-26},{0,-26},{0,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
          string="%second",
          index=3,
          extent={{6,3},{6,3}}));
      connect(PI.y, axisControlBus.current_ref)
        annotation (Line(points={{81,10},{90,10},{90,-30},{2,-30},{2,-99.9},{0.1,-99.9}},
                                                                          color={0,0,127}),
          Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(extent={{-80,40},{80,-40}}, lineColor={0,0,255}),
            Polygon(
              points={{-30,40},{-60,50},{-60,30},{-30,40}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,-30},{30,-40},{60,-50},{60,-30}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Rectangle(
              extent={{-30,56},{30,24}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Rectangle(
              extent={{-30,-24},{30,-56}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This controller has an inner PI-controller to control the motor speed,
and an outer P-controller to control the motor position of one axis.
The reference signals are with respect to the gear-output, and the
gear ratio is used in the controller to determine the motor
reference signals. All signals are communicated via the
\"axisControlBus\".
</p>
</html>"));
    end Controller;

    model AxisType1 "Axis model of the r3 joints 1,2,3"
      extends AxisType2(redeclare GearType1 gear(c=c, d=cd));
      parameter Real c(unit="N.m/rad") = 43 "Spring constant"
        annotation (Dialog(group="Gear"));
      parameter Real cd(unit="N.m.s/rad") = 0.005 "Damper constant"
        annotation (Dialog(group="Gear"));
      annotation (Documentation(info="<html>
<p>
Model of axis 1, 2, 3 of the robot r3. An axis consists of a gearbox with modelled gear elasticity and bearing friction,
a model of the electrical motor and a continuous-time cascade controller.
</p>
</html>"));
    end AxisType1;

    model AxisType2 "Axis model of the r3 joints 4,5,6"
      parameter Real kp=10 "Gain of position controller"
        annotation (Dialog(group="Controller"));
      parameter Real ks=1 "Gain of speed controller"
        annotation (Dialog(group="Controller"));
      parameter SI.Time Ts=0.01
        "Time constant of integrator of speed controller"
        annotation (Dialog(group="Controller"));
      parameter Real k=1.1616 "Gain of motor"
        annotation (Dialog(group="Motor"));
      parameter Real w=4590 "Time constant of motor"
        annotation (Dialog(group="Motor"));
      parameter Real D=0.6 "Damping constant of motor"
        annotation (Dialog(group="Motor"));
      parameter SI.Inertia J(min=0) = 0.0013 "Moment of inertia of motor"
        annotation (Dialog(group="Motor"));
      parameter Real ratio=-105 "Gear ratio" annotation (Dialog(group="Gear"));
      parameter SI.Torque Rv0=0.4
        "Viscous friction torque at zero velocity in [Nm]"
        annotation (Dialog(group="Gear"));
      parameter Real Rv1(unit="N.m.s/rad") = (0.13/160)
        "Viscous friction coefficient in [Nms/rad]"
        annotation (Dialog(group="Gear"));
      parameter Real peak=1
        "Maximum static friction torque is peak*Rv0 (peak >= 1)"
        annotation (Dialog(group="Gear"));

      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      replaceable GearType2 gear(
        Rv0=Rv0,
        Rv1=Rv1,
        peak=peak,
        i=ratio) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Motor motor(
        J=J,
        k=k,
        w=w,
        D=D) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      RobotR3.Components.Controller controller(
        kp=kp,
        ks=ks,
        Ts=Ts,
        ratio=ratio) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus
        annotation (Placement(transformation(
            origin={-100,0},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
        annotation (Placement(transformation(extent={{40,60},{20,80}})));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
        annotation (Placement(transformation(
            origin={30,50},
            extent={{-10,10},{10,-10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Sensors.AccSensor accSensor
        annotation (Placement(transformation(extent={{40,20},{20,40}})));
      Modelica.Mechanics.Rotational.Components.InitializeFlange
        initializeFlange(                          stateSelect=StateSelect.prefer)
        annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
      Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(
              extent={{-65,-65},{-55,-55}})));
    equation
      connect(gear.flange_b, flange)
        annotation (Line(points={{40,0},{100,0}}));
      connect(gear.flange_b, angleSensor.flange)
        annotation (Line(points={{40,0},{60,0},{60,70},{40,70}}));
      connect(gear.flange_b, speedSensor.flange)
        annotation (Line(points={{40,0},{60,0},{60,50},{40,50}}));
      connect(motor.flange_motor, gear.flange_a)
        annotation (Line(points={{0,0},{20,0}}));
      connect(gear.flange_b, accSensor.flange)
        annotation (Line(points={{40,0},{60,0},{60,30},{40,30}}));
      connect(motor.axisControlBus, axisControlBus) annotation (Line(
          points={{-10,-10},{-10,-20},{-94,-20},{-94,0},{-100,0}},
          color={255,204,51},
          thickness=0.5));
      connect(angleSensor.phi, axisControlBus.angle) annotation (Text(
          string="%second",
          index=2,
          extent={{6,3},{6,3}}), Line(points={{19,70},{0,70},{0,52},{-102,52},{-102,0},{-99.9,0},{-99.9,-0.1}}, color={0,0,127}));
      connect(speedSensor.w, axisControlBus.speed) annotation (Text(
          string="%second",
          index=2,
          extent={{6,3},{6,3}}), Line(points={{19,50},{0,50},{0,50},{-99.9,50},{-99.9,-0.1}}, color={0,0,127}));
      connect(accSensor.a, axisControlBus.acceleration) annotation (Text(
          string="%second",
          index=2,
          extent={{6,3},{6,3}}), Line(points={{19,30},{0,30},{0,48},{-98,48},{-98,-0.1},{-99.9,-0.1}}, color={0,0,127}));
      connect(axisControlBus.angle_ref, initializeFlange.phi_start) annotation (
        Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}), Line(points={{-99.9,-0.1},{-99.9,0},{-98,0},{-98,-42},{-42,-42}}));
      connect(axisControlBus.speed_ref, initializeFlange.w_start) annotation (
        Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}), Line(points={{-99.9,-0.1},{-100,-0.1},{-100,-50},{-42,-50}},
                          color={0,0,127}));
      connect(initializeFlange.flange, flange) annotation (Line(points={{-20,-50},{60,-50},{60,0},{100,0}}));
      connect(const.y, initializeFlange.a_start) annotation (Line(points={{-54.5,
              -60},{-48,-60},{-48,-58},{-42,-58}}, color={0,0,127}));
      connect(controller.axisControlBus, axisControlBus) annotation (Line(
          points={{-50,-10},{-50,-20},{-94,-20},{-94,0},{-100,0}},
          color={255,204,51},
          thickness=0.5));
      annotation (
        Documentation(info="<html>
<p>
The axis model consists of the <strong>controller</strong>, the <strong>motor</strong> including current
controller and the <strong>gearbox</strong> including gear elasticity and bearing friction.
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
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Rectangle(
              extent={{-100,50},{100,-50}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}), Text(
              extent={{-150,100},{150,60}},
              textString="%name",
              lineColor={0,0,255})}));
    end AxisType2;

    model MechanicalStructure
      "Model of the mechanical part of the r3 robot (without animation)"
      import Modelica.SIunits.Conversions.to_unit1;

      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter SI.Mass mLoad(min=0)=15 "Mass of load";
      parameter SI.Position rLoad[3]={0,0.25,0}
        "Distance from last flange to load mass>";
      parameter SI.Acceleration g=9.81 "Gravity acceleration";
      SI.Angle q[6] "Joint angles";
      SI.AngularVelocity qd[6] "Joint speeds";
      SI.AngularAcceleration qdd[6] "Joint accelerations";
      SI.Torque tau[6] "Joint driving torques";
      //r0={0,0.351,0},

      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis1
        annotation (Placement(transformation(extent={{-210,-160},{-190,-140}}), iconTransformation(extent={{-210,-160},{-190,-140}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis2
        annotation (Placement(transformation(extent={{-210,-100},{-190,-80}}), iconTransformation(extent={{-210,-100},{-190,-80}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis3
        annotation (Placement(transformation(extent={{-210,-40},{-190,-20}}), iconTransformation(extent={{-210,-40},{-190,-20}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis4
        annotation (Placement(transformation(extent={{-210,20},{-190,40}}), iconTransformation(extent={{-210,20},{-190,40}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis5
        annotation (Placement(transformation(extent={{-210,80},{-190,100}}), iconTransformation(extent={{-210,80},{-190,100}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis6
        annotation (Placement(transformation(extent={{-210,140},{-190,160}}), iconTransformation(extent={{-210,140},{-190,160}})));
      inner Modelica.Mechanics.MultiBody.World world(
        g=(g)*Modelica.Math.Vectors.length(({0,-1,0})),
        n={0,-1,0},
        animateWorld=false,
        animateGravity=false,
        enableAnimation=animation)
        annotation (Placement(transformation(extent={{40,-170},{20,-150}})));
      Modelica.Mechanics.MultiBody.Joints.Revolute r1(
        n={0,1,0},
        useAxisFlange=true,
        animation=animation)
        annotation (Placement(transformation(
            origin={-80,-140},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Joints.Revolute r2(
        n={1,0,0},
        useAxisFlange=true,
        animation=animation)
        annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
      Modelica.Mechanics.MultiBody.Joints.Revolute r3(
        n={1,0,0},
        useAxisFlange=true,
        animation=animation)
        annotation (Placement(transformation(
            origin={-50,-50},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Joints.Revolute r4(
        n={0,1,0},
        useAxisFlange=true,
        animation=animation)
        annotation (Placement(transformation(
            origin={-80,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Joints.Revolute r5(
        n={1,0,0},
        useAxisFlange=true,
        animation=animation)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Modelica.Mechanics.MultiBody.Joints.Revolute r6(
        n={0,1,0},
        useAxisFlange=true,
        animation=animation)
        annotation (Placement(transformation(
            origin={-20,100},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b0(
        r={0,0.351,0},
        shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b0.dxf",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.225,
        width=0.3,
        height=0.3,
        color={0,0,255},
        animation=animation,
        animateSphere=false,
        r_CM={0,0,0},
        m=1)
        annotation (Placement(transformation(
            extent={{-20,-170},{-40,-150}})));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b1(
        r={0,0.324,0.3},
        I_22=1.16,
        shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b1.dxf",
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.25,
        width=0.15,
        height=0.2,
        animation=animation,
        animateSphere=false,
        color={255,0,0},
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(
            origin={-80,-110},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b2(
        r={0,0.65,0},
        r_CM={0.172,0.205,0},
        m=56.5,
        I_11=2.58,
        I_22=0.64,
        I_33=2.73,
        I_21=-0.46,
        shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b2.dxf",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.5,
        width=0.2,
        height=0.15,
        animation=animation,
        animateSphere=false,
        color={255,178,0}) annotation (Placement(transformation(
            origin={-20,-70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b3(
        r={0,0.414,-0.155},
        r_CM={0.064,-0.034,0},
        m=26.4,
        I_11=0.279,
        I_22=0.245,
        I_33=0.413,
        I_21=-0.070,
        shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b3.dxf",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.15,
        width=0.15,
        height=0.15,
        animation=animation,
        animateSphere=false,
        color={255,0,0}) annotation (Placement(transformation(
            origin={-80,-30},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b4(
        r={0,0.186,0},
        r_CM={0,0,0},
        m=28.7,
        I_11=1.67,
        I_22=0.081,
        I_33=1.67,
        shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b4.dxf",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.73,
        width=0.1,
        height=0.1,
        animation=animation,
        animateSphere=false,
        color={255,178,0}) annotation (Placement(transformation(
            origin={-80,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b5(
        r={0,0.125,0},
        r_CM={0,0,0},
        m=5.2,
        I_11=1.25,
        I_22=0.81,
        I_33=1.53,
        shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b5.dxf",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.225,
        width=0.075,
        height=0.1,
        animation=animation,
        animateSphere=false,
        color={0,0,255}) annotation (Placement(transformation(
            origin={-20,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b6(
        r={0,0,0},
        r_CM={0.05,0.05,0.05},
        m=0.5,
        shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b6.dxf",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        animation=animation,
        animateSphere=false,
        color={0,0,255}) annotation (Placement(transformation(
            origin={-20,130},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape load(
        r={0,0,0},
        r_CM=rLoad,
        m=mLoad,
        r_shape={0,0,0},
        widthDirection={1,0,0},
        width=0.05,
        height=0.05,
        color={255,0,0},
        lengthDirection = to_unit1(rLoad),
        length=Modelica.Math.Vectors.length(rLoad),
        animation=animation)
        annotation (Placement(transformation(
            origin={-20,160},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      q = {r1.phi,r2.phi,r3.phi,r4.phi,r5.phi,r6.phi};
      qd = der(q);
      qdd = der(qd);
      tau = {r1.tau, r2.tau, r3.tau, r4.tau, r5.tau, r6.tau};

      connect(load.frame_a, b6.frame_b)
        annotation (Line(
          points={{-20,150},{-20,140}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, b0.frame_a) annotation (Line(
          points={{20,-160},{-20,-160}},
          color={95,95,95},
          thickness=0.5));
      connect(b0.frame_b, r1.frame_a) annotation (Line(
          points={{-40,-160},{-80,-160},{-80,-150}},
          color={95,95,95},
          thickness=0.5));
      connect(b1.frame_b, r2.frame_a) annotation (Line(
          points={{-80,-100},{-80,-90},{-60,-90}},
          color={95,95,95},
          thickness=0.5));
      connect(r1.frame_b, b1.frame_a) annotation (Line(
          points={{-80,-130},{-80,-120}},
          color={95,95,95},
          thickness=0.5));
      connect(r2.frame_b, b2.frame_a) annotation (Line(
          points={{-40,-90},{-20,-90},{-20,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(b2.frame_b, r3.frame_a) annotation (Line(
          points={{-20,-60},{-20,-50},{-40,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(r2.axis, axis2) annotation (Line(points={{-50,-80},{-50,-76},{-180,-76},{-180,-90},{-200,-90}}));
      connect(r1.axis, axis1) annotation (Line(points={{-90,-140},{-180,-140},{-180,-150},{-200,-150}}));
      connect(r3.frame_b, b3.frame_a) annotation (Line(
          points={{-60,-50},{-80,-50},{-80,-40}},
          color={95,95,95},
          thickness=0.5));
      connect(b3.frame_b, r4.frame_a) annotation (Line(
          points={{-80,-20},{-80,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(r3.axis, axis3)
        annotation (Line(points={{-50,-60},{-50,-64},{-180,-64},{-180,-30},{-200,-30}}));
      connect(r4.axis, axis4)
        annotation (Line(points={{-90,0},{-180,0},{-180,30},{-200,30}}));
      connect(r4.frame_b, b4.frame_a)
        annotation (Line(
          points={{-80,10},{-80,20}},
          color={95,95,95},
          thickness=0.5));
      connect(b4.frame_b, r5.frame_a) annotation (Line(
          points={{-80,40},{-80,50},{-60,50}},
          color={95,95,95},
          thickness=0.5));
      connect(r5.axis, axis5) annotation (Line(points={{-50,60},{-50,90},{-200,90}}));
      connect(r5.frame_b, b5.frame_a) annotation (Line(
          points={{-40,50},{-20,50},{-20,60}},
          color={95,95,95},
          thickness=0.5));
      connect(b5.frame_b, r6.frame_a) annotation (Line(
          points={{-20,80},{-20,90}},
          color={95,95,95},
          thickness=0.5));
      connect(r6.axis, axis6)
        annotation (Line(points={{-30,100},{-180,100},{-180,150},{-200,150}}));
      connect(r6.frame_b, b6.frame_a)
        annotation (Line(
          points={{-20,110},{-20,120}},
          color={95,95,95},
          thickness=0.5));
      annotation (
        Documentation(info="<html>
<p>
This model contains the mechanical components of the r3 robot
(multibody system).
</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-200,-200},{200,200}}), graphics={
            Rectangle(
              extent={{-200,200},{200,-200}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-200,250},{200,210}},
              textString="%name",
              lineColor={0,0,255}),
            Bitmap(extent={{-130,-195},{195,195}},
              fileName="modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Systems/robot_kr15.png"),
            Text(
              extent={{-190,-130},{-130,-170}},
              textString="1"),
            Text(
              extent={{-190,-70},{-130,-110}},
              textString="2"),
            Text(
              extent={{-190,-10},{-130,-50}},
              textString="3"),
            Text(
              extent={{-190,48},{-130,8}},
              textString="4"),
            Text(
              extent={{-190,110},{-130,70}},
              textString="5"),
            Text(
              extent={{-190,170},{-130,130}},
              textString="6")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-200,-200},{200,200}})));
    end MechanicalStructure;

    annotation (Documentation(info="<html>
<p>
This library contains the different components
of the r3 robot. Usually, there is no need to
use this library directly.
</p>
</html>"));
  end Components;

  annotation (
    Documentation(info="<html>
<p>
This package contains models of the robot r3 of the company Manutec.
These models are used to demonstrate in which way complex
robot models might be built up by testing first the component
models individually before composing them together.
Furthermore, it is shown how CAD data can be used
for animation.
</p>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Systems/robot_kr15.png\"
alt=\"model Examples.Systems.RobotR3\">

<p>
The following models are available:
</p>
<pre>
   <strong>oneAxis</strong>   Test one axis (controller, motor, gearbox).
   <strong>fullRobot</strong> Test complete robot model.
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
       from: <a href=\"http://www.robotic.dlr.de/Martin.Otter\">http://www.robotic.dlr.de/Martin.Otter</a>.
</pre>
<p>
The path planning is performed in a simple way by using essentially
the Modelica.Mechanics.Rotational.KinematicPTP block. A user defines
a path by start and end angle of every axis. A path is planned such
that all axes are moving as fast as possible under the given
restrictions of maximum joint speeds and maximum joint accelerations.
The actual r3 robot from Manutec had a different path planning strategy.
Today's path planning algorithms from robot companies are much
more involved.
</p>
<p>
In order to get a nice animation, CAD data from a KUKA robot
is used, since CAD data of the original r3 robot was not available.
The KUKA CAD data was derived from public data of
<a href=\"http://www.kuka-robotics.com/\">
KUKA</a>.
Since dimensions of the corresponding KUKA robot are similar but not
identical to the r3 robot, the data of the r3 robot (such as arm lengths) have been modified, such that it matches the CAD data.
</p>
<p>
In this model, a simplified P-PI cascade controller for every
axes is used. The parameters have been manually adjusted by
simulations. The original r3 controllers are more complicated.
The reason to use simplified controllers is to have a simpler demo.
</p>
</html>"));

end RobotR3;
