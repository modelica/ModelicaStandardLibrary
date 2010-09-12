within Modelica.Mechanics.MultiBody.Examples.Systems;
package RobotR3
  "Library to demonstrate robot system models based on the Manutec r3 robot"

  model oneAxis
    "Model of one axis of robot (controller, motor, gearbox) with simple load"

    import SI = Modelica.SIunits;
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
      Ts=Ts) annotation (Placement(transformation(extent={{20,0},{40,20}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia load(
                                               J=1.3*mLoad)
      annotation (Placement(transformation(extent={{54,0},{74,20}}, rotation=0)));
    Components.PathPlanning1 pathPlanning(
      swingTime=swingTime,
      angleBegDeg=startAngle,
      angleEndDeg=endAngle,
      speedMax=refSpeedMax,
      accMax=refAccMax)   annotation (Placement(transformation(extent={{-60,0},
              {-40,20}}, rotation=0)));
  protected
    Components.ControlBus controlBus annotation (Placement(transformation(
            extent={{-32,10},{8,50}}, rotation=0)));
  equation
    connect(axis.flange, load.flange_a)
      annotation (Line(
        points={{40,10},{54,10}},
        color={128,128,128},
        thickness=0.5));
    connect(pathPlanning.controlBus, controlBus) annotation (Line(
        points={{-40,10},{-15,10},{-15,28},{-12,28},{-12,30}},
        color={255,204,51},
        thickness=0.5));
    connect(controlBus.axisControlBus1, axis.axisControlBus) annotation (
      __Dymola_Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3]), Line(
        points={{-12,30},{-12,29},{-9,29},{-9,10},{20,10}},
        color={255,204,51},
        thickness=0.5));
    annotation (
      Documentation(info="<HTML>
<p>
With this model one axis of the r3 robot is checked.
The mechanical structure is replaced by a simple
load inertia.
</p>
</HTML>
"),   Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      experiment(StopTime=1.6),
      __Dymola_Commands(file="modelica://Modelica/Resources/Scripts/Dymola/Mechanics/MultiBody/Examples/Systems/oneAxisPlot.mos"
          "Plot result"));
  end oneAxis;

  model fullRobot
    "6 degree of freedom robot with path planning, controllers, motors, brakes, gears and mechanics"
    extends Modelica.Icons.Example;

    import SI = Modelica.SIunits;

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
      g=g) annotation (Placement(transformation(extent={{35,-35},{95,25}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.PathPlanning6
      pathPlanning(
      naxis=6,
      angleBegDeg={startAngle1,startAngle2,startAngle3,startAngle4,startAngle5,
          startAngle6},
      angleEndDeg={endAngle1,endAngle2,endAngle3,endAngle4,endAngle5,endAngle6},
      speedMax=refSpeedMax,
      accMax=refAccMax,
      startTime=refStartTime,
      swingTime=refSwingTime) annotation (Placement(transformation(extent={{-5,
              50},{-25,70}}, rotation=0)));

    RobotR3.Components.AxisType1 axis1(
      w=4590,
      ratio=-105,
      c=43,
      cd=0.005,
      Rv0=0.4,
      Rv1=(0.13/160),
      kp=kp1,
      ks=ks1,
      Ts=Ts1) annotation (Placement(transformation(extent={{-25,-75},{-5,-55}},
            rotation=0)));
    RobotR3.Components.AxisType1 axis2(
      w=5500,
      ratio=210,
      c=8,
      cd=0.01,
      Rv1=(0.1/130),
      Rv0=0.5,
      kp=kp2,
      ks=ks2,
      Ts=Ts2) annotation (Placement(transformation(extent={{-25,-55},{-5,-35}},
            rotation=0)));

    RobotR3.Components.AxisType1 axis3(
      w=5500,
      ratio=60,
      c=58,
      cd=0.04,
      Rv0=0.7,
      Rv1=(0.2/130),
      kp=kp3,
      ks=ks3,
      Ts=Ts3) annotation (Placement(transformation(extent={{-25,-35},{-5,-15}},
            rotation=0)));
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
      Ts=Ts4) annotation (Placement(transformation(extent={{-25,-15},{-5,5}},
            rotation=0)));
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
      Ts=Ts5) annotation (Placement(transformation(extent={{-25,5},{-5,25}},
            rotation=0)));
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
      Ts=Ts6) annotation (Placement(transformation(extent={{-25,25},{-5,45}},
            rotation=0)));
  protected
    Components.ControlBus controlBus
      annotation (Placement(transformation(
          origin={-80,-10},
          extent={{-20,-20},{20,20}},
          rotation=90)));
  equation
    connect(axis2.flange, mechanics.axis2) annotation (Line(points={{-5,-45},{
            25,-45},{25,-21.5},{33.5,-21.5}}, color={0,0,0}));
    connect(axis1.flange, mechanics.axis1) annotation (Line(points={{-5,-65},{
            30,-65},{30,-30.5},{33.5,-30.5}}, color={0,0,0}));
    connect(axis3.flange, mechanics.axis3) annotation (Line(points={{-5,-25},{
            15,-25},{15,-12.5},{33.5,-12.5}}, color={0,0,0}));
    connect(axis4.flange, mechanics.axis4) annotation (Line(points={{-5,-5},{15,
            -5},{15,-3.5},{33.5,-3.5}}, color={0,0,0}));
    connect(axis5.flange, mechanics.axis5)
      annotation (Line(points={{-5,15},{10,15},{10,5.5},{33.5,5.5}}, color={0,0,
            0}));
    connect(axis6.flange, mechanics.axis6) annotation (Line(points={{-5,35},{20,
            35},{20,14.5},{33.5,14.5}}, color={0,0,0}));
    connect(controlBus, pathPlanning.controlBus)
                                         annotation (Line(
        points={{-80,-10},{-80,60},{-25,60}},
        color={255,204,51},
        thickness=0.5));
    connect(controlBus.axisControlBus1, axis1.axisControlBus) annotation (
      __Dymola_Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3]), Line(
        points={{-80,-10},{-80,-14.5},{-79,-14.5},{-79,-17},{-65,-17},{-65,-65},
            {-25,-65}},
        color={255,204,51},
        thickness=0.5));

    connect(controlBus.axisControlBus2, axis2.axisControlBus) annotation (
      __Dymola_Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3]), Line(
        points={{-80,-10},{-79,-10},{-79,-15},{-62.5,-15},{-62.5,-45},{-25,-45}},
        color={255,204,51},
        thickness=0.5));

    connect(controlBus.axisControlBus3, axis3.axisControlBus) annotation (
      __Dymola_Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3]), Line(
        points={{-80,-10},{-77,-10},{-77,-12.5},{-61,-12.5},{-61,-25},{-25,-25}},
        color={255,204,51},
        thickness=0.5));

    connect(controlBus.axisControlBus4, axis4.axisControlBus) annotation (
      __Dymola_Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3]), Line(
        points={{-80,-10},{-60.5,-10},{-60.5,-5},{-25,-5}},
        color={255,204,51},
        thickness=0.5));
    connect(controlBus.axisControlBus5, axis5.axisControlBus) annotation (
      __Dymola_Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3]), Line(
        points={{-80,-10},{-77,-10},{-77,-7},{-63,-7},{-63,15},{-25,15}},
        color={255,204,51},
        thickness=0.5));
    connect(controlBus.axisControlBus6, axis6.axisControlBus) annotation (
      __Dymola_Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3]), Line(
        points={{-80,-10},{-79,-10},{-79,-5},{-65,-5},{-65,35},{-25,35}},
        color={255,204,51},
        thickness=0.5));
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={0.5,0.5}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={0.5,0.5}), graphics),
      experiment(StopTime=2),
      __Dymola_Commands(
        file="modelica://Modelica/Resources/Scripts/Dymola/Mechanics/MultiBody/Examples/Systems/Run.mos"
          "Simulate",
        file="modelica://Modelica/Resources/Scripts/Dymola/Mechanics/MultiBody/Examples/Systems/fullRobotPlot.mos"
          "Plot result of axis 3 + animate"),
      Documentation(info="<HTML>
<p>
This is a detailed model of the robot. For animation CAD data
is used. Translate and simulate with the default settings
(default simulation time = 3 s). Use command script \"modelica://Modelica/Resources/Scripts/Dymola/ExamplesfullRobotPlot.mos\"
to plot variables.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Systems/r3_fullRobot.png\" ALT=\"model Examples.Loops.Systems.RobotR3.fullRobot\">

</HTML>"));
  end fullRobot;
  extends Modelica.Icons.ExamplesPackage;
  import SI = Modelica.SIunits;

  package Components "Library of components of the robot"
    extends Modelica.Icons.Package;

    expandable connector AxisControlBus "Data bus for one robot axis"
      extends Modelica.Icons.SignalSubBus;
      import SI = Modelica.SIunits;

      Boolean motion_ref "= true, if reference motion is not in rest";
      SI.Angle angle_ref "Reference angle of axis flange";
      SI.Angle angle "Angle of axis flange";
      SI.AngularVelocity speed_ref "Reference speed of axis flange";
      SI.AngularVelocity speed "Speed of axis flange";
      SI.AngularAcceleration acceleration_ref
        "Reference acceleration of axis flange";
      SI.AngularAcceleration acceleration "Acceleration of axis flange";
      SI.Current current_ref "Reference current of motor";
      SI.Current current "Current of motor";
      SI.Angle motorAngle "Angle of motor flange";
      SI.AngularVelocity motorSpeed "Speed of motor flange";

      annotation (defaultComponentPrefixes="protected",
                  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-20,2},{22,-2}},
              lineColor={255,204,51},
              lineThickness=0.5)}),
        Documentation(info="<html>
<p>
Signal bus that is used to communicate all signals for <b>one</b> axis.
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
                100,100}}), graphics={Rectangle(
              extent={{-20,2},{22,-2}},
              lineColor={255,204,51},
              lineThickness=0.5)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        Documentation(info="<html>
<p>
Signal bus that is used to communicate <b>all signals</b> of the robot.
This is an expandable connector which has a \"default\" set of
signals. Note, the input/output causalities of the signals are
determined from the connections to this bus.
</p>
</html>"));
    end ControlBus;

    model PathPlanning1
      "Generate reference angles for fastest kinematic movement"

      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
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
                {-30,10}}, rotation=0)));
      PathToAxisControlBus pathToAxis1(final nAxis=1, final axisUsed=1)
        annotation (Placement(transformation(extent={{0,-10},{20,10}}, rotation=
               0)));

      Blocks.Logical.TerminateSimulation terminateSimulation(condition=time >= path.endTime
             + swingTime) annotation (Placement(transformation(extent={{-50,-30},
                {30,-24}}, rotation=0)));
    equation
      connect(path.q, pathToAxis1.q)         annotation (Line(points={{-29,8},{
              -2,8}}, color={0,0,127}));
      connect(path.qd, pathToAxis1.qd)         annotation (Line(points={{-29,3},
              {-2,3}}, color={0,0,127}));
      connect(path.qdd, pathToAxis1.qdd)         annotation (Line(points={{-29,
              -3},{-2,-3}}, color={0,0,127}));
      connect(path.moving, pathToAxis1.moving)             annotation (Line(
            points={{-29,-8},{-2,-8}}, color={255,0,255}));
      connect(pathToAxis1.axisControlBus, controlBus.axisControlBus1) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(
          points={{20,0},{100,0}},
          color={255,204,51},
          thickness=0.5));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}},
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
            Line(points={{-80,0},{-41,69},{26,69},{58,0}}, color={0,0,0}),
            Text(
              extent={{-73,-44},{82,-69}},
              lineColor={0,0,0},
              textString="1 axis")}),
        Documentation(info="<html>
<p>
Given
</p>
<ul>
<li> start and end angle of an axis</li>
<li> maximum speed of the axis </li>
<li> maximum acceleration of the axis </li>
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

</html>
"),     Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics));
    end PathPlanning1;

    model PathPlanning6
      "Generate reference angles for fastest kinematic movement"

      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
      parameter Integer naxis=6 "number of driven axis";
      parameter Real angleBegDeg[naxis](unit="deg") = zeros(naxis)
        "Start angles";
      parameter Real angleEndDeg[naxis](unit="deg") = ones(naxis) "End angles";
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
                {-70,-60}}, rotation=0)));
      PathToAxisControlBus pathToAxis1(nAxis=naxis, axisUsed=1)
        annotation (Placement(transformation(extent={{-10,70},{10,90}},
              rotation=0)));
      PathToAxisControlBus pathToAxis2(nAxis=naxis, axisUsed=2)
        annotation (Placement(transformation(extent={{-10,40},{10,60}},
              rotation=0)));
      PathToAxisControlBus pathToAxis3(nAxis=naxis, axisUsed=3)
        annotation (Placement(transformation(extent={{-10,10},{10,30}},
              rotation=0)));
      PathToAxisControlBus pathToAxis4(nAxis=naxis, axisUsed=4)
        annotation (Placement(transformation(extent={{-10,-20},{10,0}},
              rotation=0)));
      PathToAxisControlBus pathToAxis5(nAxis=naxis, axisUsed=5)
        annotation (Placement(transformation(extent={{-10,-50},{10,-30}},
              rotation=0)));
      PathToAxisControlBus pathToAxis6(nAxis=naxis, axisUsed=6)
        annotation (Placement(transformation(extent={{-10,-80},{10,-60}},
              rotation=0)));

      Blocks.Logical.TerminateSimulation terminateSimulation(condition=time >= path.endTime
             + swingTime) annotation (Placement(transformation(extent={{-50,
                -100},{30,-94}}, rotation=0)));
    equation
      connect(path.q, pathToAxis1.q)         annotation (Line(points={{-69,-62},
              {-60,-62},{-60,88},{-12,88}}, color={0,0,127}));
      connect(path.qd, pathToAxis1.qd)         annotation (Line(points={{-69,
              -67},{-59,-67},{-59,83},{-12,83}}, color={0,0,127}));
      connect(path.qdd, pathToAxis1.qdd)         annotation (Line(points={{-69,
              -73},{-58,-73},{-58,77},{-12,77}}, color={0,0,127}));
      connect(path.moving, pathToAxis1.moving)             annotation (Line(
            points={{-69,-78},{-57,-78},{-57,72},{-12,72}}, color={255,0,255}));
      connect(path.q, pathToAxis2.q)         annotation (Line(points={{-69,-62},
              {-60,-62},{-60,58},{-12,58}}, color={0,0,127}));
      connect(path.qd, pathToAxis2.qd)         annotation (Line(points={{-69,
              -67},{-59,-67},{-59,53},{-12,53}}, color={0,0,127}));
      connect(path.qdd, pathToAxis2.qdd)         annotation (Line(points={{-69,
              -73},{-58,-73},{-58,47},{-12,47}}, color={0,0,127}));
      connect(path.moving, pathToAxis2.moving)             annotation (Line(
            points={{-69,-78},{-57,-78},{-57,42},{-12,42}}, color={255,0,255}));
      connect(path.q, pathToAxis3.q)         annotation (Line(points={{-69,-62},
              {-60,-62},{-60,28},{-12,28}}, color={0,0,127}));
      connect(path.qd, pathToAxis3.qd)         annotation (Line(points={{-69,
              -67},{-59,-67},{-59,23},{-12,23}}, color={0,0,127}));
      connect(path.qdd, pathToAxis3.qdd)         annotation (Line(points={{-69,
              -73},{-58,-73},{-58,17},{-12,17}}, color={0,0,127}));
      connect(path.moving, pathToAxis3.moving)             annotation (Line(
            points={{-69,-78},{-57,-78},{-57,12},{-12,12}}, color={255,0,255}));
      connect(path.q, pathToAxis4.q)         annotation (Line(points={{-69,-62},
              {-60,-62},{-60,-2},{-12,-2}}, color={0,0,127}));
      connect(path.qd, pathToAxis4.qd)         annotation (Line(points={{-69,
              -67},{-59,-67},{-59,-7},{-12,-7}}, color={0,0,127}));
      connect(path.qdd, pathToAxis4.qdd)         annotation (Line(points={{-69,
              -73},{-58,-73},{-58,-13},{-12,-13}}, color={0,0,127}));
      connect(path.moving, pathToAxis4.moving)             annotation (Line(
            points={{-69,-78},{-57,-78},{-57,-18},{-12,-18}}, color={255,0,255}));
      connect(path.q, pathToAxis5.q)         annotation (Line(points={{-69,-62},
              {-60,-62},{-60,-32},{-12,-32}}, color={0,0,127}));
      connect(path.qd, pathToAxis5.qd)         annotation (Line(points={{-69,
              -67},{-59,-67},{-59,-37},{-12,-37}}, color={0,0,127}));
      connect(path.qdd, pathToAxis5.qdd)         annotation (Line(points={{-69,
              -73},{-58,-73},{-58,-43},{-12,-43}}, color={0,0,127}));
      connect(path.moving, pathToAxis5.moving)             annotation (Line(
            points={{-69,-78},{-57,-78},{-57,-48},{-12,-48}}, color={255,0,255}));
      connect(path.q, pathToAxis6.q)         annotation (Line(points={{-69,-62},
              {-12,-62}}, color={0,0,127}));
      connect(path.qd, pathToAxis6.qd)         annotation (Line(points={{-69,
              -67},{-12,-67}}, color={0,0,127}));
      connect(path.qdd, pathToAxis6.qdd)         annotation (Line(points={{-69,
              -73},{-12,-73}}, color={0,0,127}));
      connect(path.moving, pathToAxis6.moving)             annotation (Line(
            points={{-69,-78},{-12,-78}}, color={255,0,255}));
      connect(pathToAxis1.axisControlBus, controlBus.axisControlBus1) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(
          points={{10,80},{80,80},{80,7},{98,7}},
          color={255,204,51},
          thickness=0.5));
      connect(pathToAxis2.axisControlBus, controlBus.axisControlBus2) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(
          points={{10,50},{77,50},{77,5},{97,5}},
          color={255,204,51},
          thickness=0.5));
      connect(pathToAxis3.axisControlBus, controlBus.axisControlBus3) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(
          points={{10,20},{75,20},{75,3},{96,3}},
          color={255,204,51},
          thickness=0.5));
      connect(pathToAxis4.axisControlBus, controlBus.axisControlBus4) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(
          points={{10,-10},{73,-10},{73,0},{100,0}},
          color={255,204,51},
          thickness=0.5));
      connect(pathToAxis5.axisControlBus, controlBus.axisControlBus5) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(
          points={{10,-40},{75,-40},{75,-3},{100,-3},{100,0}},
          color={255,204,51},
          thickness=0.5));
      connect(pathToAxis6.axisControlBus, controlBus.axisControlBus6) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(
          points={{10,-70},{78,-70},{78,-6},{98,-6}},
          color={255,204,51},
          thickness=0.5));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}},
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
            Line(points={{-80,0},{-41,69},{26,69},{58,0}}, color={0,0,0}),
            Text(
              extent={{-70,-43},{85,-68}},
              lineColor={0,0,0},
              textString="6 axes")}),
        Documentation(info="<html>
<p>
Given
</p>
<ul>
<li> start and end angles of every axis</li>
<li> maximum speed of every axis </li>
<li> maximum acceleration of every axis </li>
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

</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics));
    end PathPlanning6;

    model PathToAxisControlBus "Map path planning to one axis control bus"
      extends Blocks.Interfaces.BlockIcon;

      parameter Integer nAxis=6 "Number of driven axis";
      parameter Integer axisUsed=1
        "Map path planning of axisUsed to axisControlBus";
      Blocks.Interfaces.RealInput q[nAxis]
        annotation (Placement(transformation(extent={{-140,60},{-100,100}},
              rotation=0)));
      Blocks.Interfaces.RealInput qd[nAxis]
        annotation (Placement(transformation(extent={{-140,10},{-100,50}},
              rotation=0)));
      Blocks.Interfaces.RealInput qdd[nAxis]
        annotation (Placement(transformation(extent={{-140,-50},{-100,-10}},
              rotation=0)));
      AxisControlBus axisControlBus
        annotation (Placement(transformation(
            origin={100,0},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Blocks.Routing.RealPassThrough q_axisUsed
        annotation (Placement(transformation(extent={{-40,50},{-20,70}},
              rotation=0)));
      Blocks.Routing.RealPassThrough qd_axisUsed
        annotation (Placement(transformation(extent={{-40,10},{-20,30}},
              rotation=0)));
      Blocks.Routing.RealPassThrough qdd_axisUsed
        annotation (Placement(transformation(extent={{-40,-30},{-20,-10}},
              rotation=0)));
      Blocks.Interfaces.BooleanInput moving[nAxis]
        annotation (Placement(transformation(extent={{-140,-100},{-100,-60}},
              rotation=0)));
      Blocks.Routing.BooleanPassThrough motion_ref_axisUsed
        annotation (Placement(transformation(extent={{-40,-70},{-20,-50}},
              rotation=0)));
    equation
      connect(q_axisUsed.u, q[axisUsed]) annotation (Line(points={{-42,60},{-60,
              60},{-60,80},{-120,80}}, color={0,0,127}));
      connect(qd_axisUsed.u, qd[axisUsed]) annotation (Line(points={{-42,20},{
              -80,20},{-80,30},{-120,30}}, color={0,0,127}));
      connect(qdd_axisUsed.u, qdd[axisUsed]) annotation (Line(points={{-42,-20},
              {-80,-20},{-80,-30},{-120,-30}}, color={0,0,127}));
      connect(motion_ref_axisUsed.u, moving[axisUsed])     annotation (Line(
            points={{-42,-60},{-60,-60},{-60,-80},{-120,-80}}, color={255,0,255}));
      connect(motion_ref_axisUsed.y, axisControlBus.motion_ref) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(points={{-19,-60},{44,-60},{
              44,-8},{102,-8},{102,0},{100,0}}, color={255,0,255}));
      connect(qdd_axisUsed.y, axisControlBus.acceleration_ref) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(points={{-19,-20},{40,-20},{
              40,-4},{98,-4},{98,0},{100,0}}, color={0,0,127}));
      connect(qd_axisUsed.y, axisControlBus.speed_ref) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(points={{-19,20},{20,20},{20,
              0},{100,0}}, color={0,0,127}));
      connect(q_axisUsed.y, axisControlBus.angle_ref) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(points={{-19,60},{40,60},{40,
              4},{96,4}}, color={0,0,127}));
      annotation (defaultComponentName="pathToAxis1",
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.1), graphics),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.1), graphics={
            Text(
              extent={{-100,98},{-24,68}},
              lineColor={0,0,0},
              textString="q"),
            Text(
              extent={{-94,46},{-18,16}},
              lineColor={0,0,0},
              textString="qd"),
            Text(
              extent={{-96,-16},{-20,-46}},
              lineColor={0,0,0},
              textString="qdd"),
            Text(
              extent={{-2,20},{80,-18}},
              lineColor={0,0,0},
              textString="%axisUsed"),
            Text(
              extent={{2,52},{76,28}},
              lineColor={0,0,0},
              textString="axis"),
            Text(
              extent={{-94,-70},{32,-96}},
              lineColor={0,0,0},
              textString="moving")}));
    end PathToAxisControlBus;

    model GearType1 "Motor inertia and gearbox model for r3 joints 1,2,3 "
      extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
      parameter Real i=-105 "gear ratio";
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
        annotation (Placement(transformation(extent={{50,-10},{70,10}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper spring(
                                                        c=c, d=d)
        annotation (Placement(transformation(extent={{0,-10},{20,10}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
                                                                    tau_pos=[0,
             Rv0/unitTorque; 1, (Rv0 + Rv1*unitAngularVelocity)/unitTorque],
          useSupport=false)                                                  annotation (Placement(
            transformation(extent={{-60,-10},{-40,10}}, rotation=0)));
    equation
      connect(spring.flange_b, gear.flange_a)
        annotation (Line(
          points={{20,0},{50,0}},
          color={128,128,128},
          thickness=0.5));
      connect(bearingFriction.flange_b, spring.flange_a)
        annotation (Line(
          points={{-40,0},{0,0}},
          color={128,128,128},
          thickness=0.5));
      connect(gear.flange_b, flange_b)
        annotation (Line(
          points={{70,0},{100,0}},
          color={128,128,128},
          thickness=0.5));
      connect(bearingFriction.flange_a, flange_a)
        annotation (Line(
          points={{-60,0},{-100,0}},
          color={128,128,128},
          thickness=0.5));
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
</html>
"),     Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Rectangle(
              extent={{-100,10},{-60,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{-60,10},{-60,20},{-40,40},{-40,-40},{-60,-20},{-60,10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Rectangle(
              extent={{-40,60},{40,-60}},
              lineColor={0,0,0},
              pattern=LinePattern.Solid,
              lineThickness=0.25,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{60,20},{40,40},{40,-40},{60,-20},{60,20}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{60,10},{100,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{-60,-90},{-50,-90},{-20,-30},{20,-30},{48,-90},{60,-90},
                  {60,-100},{-60,-100},{-60,-90}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{0,128},{0,68}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-36,40},{36,-30}},
              textString="1",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={Text(
              extent={{72,30},{130,22}},
              lineColor={0,0,0},
              textString="flange of joint axis"), Text(
              extent={{-128,26},{-70,18}},
              lineColor={0,0,0},
              textString="flange of motor axis")}));
    end GearType1;

    model GearType2 "Motor inertia and gearbox model for r3 joints 4,5,6  "
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
        annotation (Placement(transformation(extent={{-28,-10},{-8,10}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
                                                                    tau_pos=[0,
             Rv0/unitTorque; 1, (Rv0 + Rv1*unitAngularVelocity)/unitTorque], peak=peak,
        useSupport=false)
        annotation (Placement(transformation(extent={{30,-10},{50,10}},
              rotation=0)));
    equation
      connect(gear.flange_b, bearingFriction.flange_a)
        annotation (Line(
          points={{-8,0},{30,0}},
          color={128,128,128},
          thickness=0.5));
      connect(bearingFriction.flange_b, flange_b)
        annotation (Line(
          points={{50,0},{100,0}},
          color={128,128,128},
          thickness=0.5));
      connect(gear.flange_a, flange_a)
        annotation (Line(
          points={{-28,0},{-100,0}},
          color={128,128,128},
          thickness=0.5));
      annotation (
        Documentation(info="<html>
<p>
The elasticity and damping in the gearboxes of the outermost
three joints of the robot is neglected.
Default values for all parameters are given for joint 4.
</p>
</html>
"),     Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Rectangle(
              extent={{-100,10},{-60,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{-60,10},{-60,20},{-40,40},{-40,-40},{-60,-20},{-60,10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Rectangle(
              extent={{-40,60},{40,-60}},
              lineColor={0,0,0},
              pattern=LinePattern.Solid,
              lineThickness=0.25,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{60,20},{40,40},{40,-40},{60,-20},{60,20}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{60,10},{100,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Polygon(
              points={{-60,-90},{-50,-90},{-20,-30},{20,-30},{48,-90},{60,-90},
                  {60,-100},{-60,-100},{-60,-90}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{0,128},{0,68}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-36,40},{38,-30}},
              textString="2",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end GearType2;

    model Motor "Motor model including current controller of r3 motors "
      extends Modelica.Icons.MotorIcon;
      parameter SI.Inertia J(min=0)=0.0013 "Moment of inertia of motor";
      parameter Real k=1.1616 "Gain of motor";
      parameter Real w=4590 "Time constant of motor";
      parameter Real D=0.6 "Damping constant of motor";
      parameter SI.AngularVelocity w_max=315 "Maximum speed of motor";
      parameter SI.Current i_max=9 "Maximum current of motor";

      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_motor
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Sources.SignalVoltage Vs
        annotation (Placement(transformation(
            origin={-90,0},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.IdealOpAmp diff
        annotation (Placement(transformation(extent={{-64,15},{-44,35}},
              rotation=0)));
      Modelica.Electrical.Analog.Ideal.IdealOpAmp power
        annotation (Placement(transformation(extent={{16,15},{36,35}}, rotation=
               0)));
      Electrical.Analog.Basic.EMF emf( k=k, useSupport=false)
        annotation (Placement(transformation(extent={{46,-10},{66,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Inductor La(L=(250/(2*D*w)))
        annotation (Placement(transformation(
            origin={56,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor Ra(R=250)
        annotation (Placement(transformation(
            origin={56,60},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor Rd2(R=100)
        annotation (Placement(transformation(extent={{-86,22},{-71,38}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Capacitor C(C=0.004*D/w)
        annotation (Placement(transformation(extent={{-14,36},{6,56}}, rotation=
               0)));
      Modelica.Electrical.Analog.Ideal.IdealOpAmp OpI
        annotation (Placement(transformation(extent={{-14,10},{6,30}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Resistor Rd1(R=100)
        annotation (Placement(transformation(extent={{-63,37},{-48,53}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor Ri(R=10)
        annotation (Placement(transformation(extent={{-37,17},{-22,33}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor Rp1(R=200)
        annotation (Placement(transformation(extent={{17,38},{32,54}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Resistor Rp2(R=50)
        annotation (Placement(transformation(
            origin={11,72},
            extent={{-8,-7},{8,7}},
            rotation=90)));
      Modelica.Electrical.Analog.Basic.Resistor Rd4(R=100)
        annotation (Placement(transformation(extent={{-55,-15},{-40,1}},
              rotation=0)));
      Modelica.Electrical.Analog.Sources.SignalVoltage hall2
        annotation (Placement(transformation(
            origin={-70,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.Analog.Basic.Resistor Rd3(R=100)
        annotation (Placement(transformation(
            origin={-70,-22},
            extent={{-8,-7},{8,7}},
            rotation=90)));
      Modelica.Electrical.Analog.Basic.Ground g1
        annotation (Placement(transformation(extent={{-100,-37},{-80,-17}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground g2
        annotation (Placement(transformation(extent={{-80,-91},{-60,-71}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground g3
        annotation (Placement(transformation(extent={{-34,-27},{-14,-7}},
              rotation=0)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor hall1
        annotation (Placement(transformation(
            origin={16,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground g4
        annotation (Placement(transformation(extent={{6,-84},{26,-64}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground g5
        annotation (Placement(transformation(
            origin={11,93},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Sensors.AngleSensor phi
        annotation (Placement(transformation(
            origin={76,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed
        annotation (Placement(transformation(
            origin={55,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia Jmotor(
                                                   J=J)
        annotation (Placement(transformation(extent={{70,-10},{90,10}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus
        annotation (Placement(transformation(extent={{60,-120},{100,-80}},
              rotation=0)));
      Blocks.Math.Gain convert1(k=1)
                                annotation (Placement(transformation(extent={{
                -30,-56},{-42,-44}}, rotation=0)));
      Blocks.Math.Gain convert2(k=1)
                                annotation (Placement(transformation(extent={{
                -30,-101},{-42,-89}}, rotation=0)));
    initial equation
      // initialize motor in steady state
      der(C.v) = 0;
      der(La.i) = 0;

    equation
      connect(La.n, emf.p) annotation (Line(points={{56,20},{56,15},{56,10}}));
      connect(Ra.n, La.p) annotation (Line(points={{56,50},{56,40}}));
      connect(Rd2.n, diff.n1) annotation (Line(points={{-71,30},{-64,30}}));
      connect(C.n, OpI.p2) annotation (Line(points={{6,46},{6,20}}));
      connect(OpI.p2, power.p1) annotation (Line(points={{6,20},{16,20}}));
      connect(Vs.p, Rd2.p) annotation (Line(points={{-90,10},{-90,30},{-86,30}}));
      connect(diff.n1, Rd1.p)
        annotation (Line(points={{-64,30},{-68,30},{-68,45},{-63,45}}));
      connect(Rd1.n, diff.p2) annotation (Line(points={{-48,45},{-44,45},{-44,
              25}}));
      connect(diff.p2, Ri.p) annotation (Line(points={{-44,25},{-37,25}}));
      connect(Ri.n, OpI.n1) annotation (Line(points={{-22,25},{-14,25}}));
      connect(OpI.n1, C.p) annotation (Line(points={{-14,25},{-14,46}}));
      connect(power.n1, Rp1.p)
        annotation (Line(points={{16,30},{11,30},{11,46},{17,46}}));
      connect(power.p2, Rp1.n) annotation (Line(points={{36,25},{36,46},{32,46}}));
      connect(Rp1.p, Rp2.p) annotation (Line(points={{17,46},{11,46},{11,64}}));
      connect(power.p2, Ra.p)
        annotation (Line(points={{36,25},{42,25},{42,80},{56,80},{56,70}}));
      connect(Rd3.p, hall2.p) annotation (Line(points={{-70,-30},{-70,-60}}));
      connect(Rd3.n, diff.p1) annotation (Line(points={{-70,-14},{-70,20},{-64,
              20}}));
      connect(Rd3.n, Rd4.p) annotation (Line(points={{-70,-14},{-70,-7},{-55,-7}}));
      connect(Vs.n, g1.p) annotation (Line(points={{-90,-10},{-90,-17}}));
      connect(g2.p, hall2.n) annotation (Line(points={{-70,-71},{-70,-40}}));
      connect(Rd4.n, g3.p) annotation (Line(points={{-40,-7},{-24,-7}}));
      connect(g3.p, OpI.p1) annotation (Line(points={{-24,-7},{-24,15},{-14,15}}));
      connect(g5.p, Rp2.n)
        annotation (Line(points={{11,83},{11,81.5},{11,81.5},{11,80}}));
      connect(emf.n, hall1.p)
        annotation (Line(points={{56,-10},{56,-24},{16,-24},{16,-40}}));
      connect(hall1.n, g4.p) annotation (Line(points={{16,-60},{16,-62},{16,-62},
              {16,-64}}));
      connect(emf.flange, phi.flange)
        annotation (Line(points={{66,0},{66,-30},{76,-30}}, pattern=LinePattern.Dot));
      connect(emf.flange, speed.flange)
        annotation (Line(points={{66,0},{66,-30},{55,-30}}, pattern=LinePattern.Dot));
      connect(OpI.n2, power.n2)
        annotation (Line(points={{-4,10},{-4,4},{26,4},{26,15}}));
      connect(OpI.p1, OpI.n2) annotation (Line(points={{-14,15},{-14,10},{-4,10}}));
      connect(OpI.p1, diff.n2) annotation (Line(points={{-14,15},{-54,15}}));
      connect(Jmotor.flange_b, flange_motor)
        annotation (Line(
          points={{90,0},{100,0}},
          color={128,128,128},
          thickness=0.5));
      connect(phi.phi, axisControlBus.motorAngle)
                                       annotation (Line(points={{76,-51},{76,
              -100},{80,-100}}, color={0,0,127}));
      connect(speed.w, axisControlBus.motorSpeed)
                                       annotation (Line(points={{55,-51},{55,
              -95},{80,-95},{80,-100}}, color={0,0,127}));
      connect(hall1.i, axisControlBus.current)
                                    annotation (Line(points={{6,-50},{-10,-50},
              {-10,-95},{80,-95},{80,-100}}, color={0,0,127}));
      connect(hall1.i, convert1.u) annotation (Line(points={{6,-50},{-28.8,-50}},
            color={0,0,127}));
      connect(convert1.y, hall2.v) annotation (Line(points={{-42.6,-50},{-63,-50}},
                     color={0,0,127}));
      connect(convert2.u, axisControlBus.current_ref)
                                           annotation (Line(points={{-28.8,-95},
              {80,-95},{80,-100}}, color={0,0,127}));
      connect(convert2.y, Vs.v) annotation (Line(points={{-42.6,-95},{-108,-95},
              {-108,1.28588e-015},{-97,1.28588e-015}}, color={0,0,127}));
      connect(emf.flange, Jmotor.flange_a) annotation (Line(
          points={{66,0},{70,0}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Documentation(info="<html>
<p>
Default values are given for the motor of joint 1.
The input of the motor is the desired current
(the actual current is proportional to the torque
produced by the motor).
</p>
</html>
"),     Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Text(
              extent={{0,120},{0,60}},
              textString="%name",
              lineColor={0,0,255}), Line(
              points={{80,-102},{80,-10}},
              color={255,204,51},
              thickness=0.5)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics));
    end Motor;

    model Controller "P-PI cascade controller for one axis"
      parameter Real kp=10 "Gain of position controller";
      parameter Real ks=1 "Gain of speed controller";
      parameter SI.Time Ts=0.01
        "Time constant of integrator of speed controller";
      parameter Real ratio=1 "Gear ratio of gearbox";

      Modelica.Blocks.Math.Gain gain1(k=ratio)
        annotation (Placement(transformation(extent={{-70,0},{-50,20}},
              rotation=0)));
      Modelica.Blocks.Continuous.PI PI(k=ks, T=Ts)
        annotation (Placement(transformation(extent={{60,0},{80,20}}, rotation=
                0)));
      Modelica.Blocks.Math.Feedback feedback1
        annotation (Placement(transformation(extent={{-46,0},{-26,20}},
              rotation=0)));
      Modelica.Blocks.Math.Gain P(k=kp) annotation (Placement(transformation(
              extent={{-16,0},{4,20}}, rotation=0)));
      Modelica.Blocks.Math.Add3 add3(k3=-1) annotation (Placement(
            transformation(extent={{20,0},{40,20}}, rotation=0)));
      Modelica.Blocks.Math.Gain gain2(k=ratio)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus
        annotation (Placement(transformation(extent={{-20,-120},{20,-80}},
              rotation=0)));
    equation
      connect(gain1.y, feedback1.u1)
        annotation (Line(points={{-49,10},{-44,10}}, color={0,0,127}));
      connect(feedback1.y, P.u)
        annotation (Line(points={{-27,10},{-18,10}}, color={0,0,127}));
      connect(P.y, add3.u2) annotation (Line(points={{5,10},{18,10}}, color={0,
              0,127}));
      connect(gain2.y, add3.u1)
        annotation (Line(points={{-39,50},{10,50},{10,18},{18,18}}, color={0,0,
              127}));
      connect(add3.y, PI.u)
        annotation (Line(points={{41,10},{58,10}}, color={0,0,127}));
      connect(gain2.u, axisControlBus.speed_ref)
                                      annotation (Line(points={{-62,50},{-90,50},
              {-90,-100},{0,-100}}, color={0,0,127}));
      connect(gain1.u, axisControlBus.angle_ref)
                                      annotation (Line(points={{-72,10},{-80,10},
              {-80,-100},{0,-100}}, color={0,0,127}));
      connect(feedback1.u2, axisControlBus.motorAngle)
                                            annotation (Line(points={{-36,2},{
              -36,-100},{0,-100}}, color={0,0,127}));
      connect(add3.u3, axisControlBus.motorSpeed)
                                       annotation (Line(points={{18,2},{0,2},{0,
              -100}}, color={0,0,127}));
      connect(PI.y, axisControlBus.current_ref)
                                     annotation (Line(points={{81,10},{90,10},{
              90,-100},{0,-100}}, color={0,0,127}));
      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,0},
              pattern=LinePattern.Solid,
              lineThickness=0.25,
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-30,54},{30,24}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{-30,40},{-60,50},{-60,30},{-30,40}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-31,-41},{-78,-41},{-78,39},{-30,39}}, color={0,0,255}),
            Rectangle(
              extent={{-30,-26},{30,-56}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{60,-32},{30,-42},{60,-52},{60,-32}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Line(points={{30,39},{76,39},{76,-41},{30,-41}}, color={0,0,255}),
            Text(
              extent={{-100,150},{100,110}},
              textString="%name",
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

    model AxisType1 "Axis model of the r3 joints 1,2,3 "
      extends AxisType2(redeclare GearType1 gear(c=c, d=cd));
      parameter Real c(unit="N.m/rad") = 43 "Spring constant"
        annotation (Dialog(group="Gear"));
      parameter Real cd(unit="N.m.s/rad") = 0.005 "Damper constant"
        annotation (Dialog(group="Gear"));
    end AxisType1;

    model AxisType2 "Axis model of the r3 joints 4,5,6 "
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
      parameter Real ratio=-105 "Gear ratio"  annotation (Dialog(group="Gear"));
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
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      replaceable GearType2 gear(
        Rv0=Rv0,
        Rv1=Rv1,
        peak=peak,
        i=ratio) annotation (Placement(transformation(extent={{0,-10},{20,10}},
              rotation=0)));
      Motor motor(
        J=J,
        k=k,
        w=w,
        D=D) annotation (Placement(transformation(extent={{-30,-10},{-10,10}},
              rotation=0)));
      RobotR3.Components.Controller controller(
        kp=kp,
        ks=ks,
        Ts=Ts,
        ratio=ratio) annotation (Placement(transformation(extent={{-70,-10},{
                -50,10}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus
        annotation (Placement(transformation(
            origin={-100,0},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
        annotation (Placement(transformation(extent={{30,60},{50,80}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
        annotation (Placement(transformation(
            origin={40,50},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Sensors.AccSensor accSensor
        annotation (Placement(transformation(extent={{30,20},{50,40}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.InitializeFlange
        initializeFlange(                          stateSelect=StateSelect.prefer)
        annotation (Placement(transformation(extent={{-40,-60},{-20,-40}},
              rotation=0)));
      Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(
              extent={{-65,-65},{-55,-55}}, rotation=0)));
    equation
      connect(gear.flange_b, flange)
        annotation (Line(points={{20,0},{100,0}}, color={0,0,0}));
      connect(gear.flange_b, angleSensor.flange)
        annotation (Line(points={{20,0},{20,70},{30,70}}, color={0,0,0}));
      connect(gear.flange_b, speedSensor.flange)
        annotation (Line(points={{20,0},{24,0},{24,50},{30,50}}, color={0,0,0}));
      connect(motor.flange_motor, gear.flange_a)
        annotation (Line(points={{-10,0},{0,0}}, color={0,0,0}));
      connect(gear.flange_b, accSensor.flange)
        annotation (Line(points={{20,0},{28,0},{28,30},{30,30}}, color={0,0,0}));
      connect(controller.axisControlBus, axisControlBus) annotation (Line(
          points={{-60,-10},{-60,-20},{-95,-20},{-95,-4},{-100,-4},{-100,0}},
          color={255,204,51},
          thickness=0.5));
      connect(motor.axisControlBus, axisControlBus) annotation (Line(
          points={{-12,-10},{-12,-20},{-95,-20},{-95,-5},{-100,-5},{-100,0}},
          color={255,204,51},
          thickness=0.5));
      connect(angleSensor.phi, axisControlBus.angle) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(points={{51,70},{70,70},{70,
              84},{-98,84},{-98,9},{-100,9},{-100,0}}, color={0,0,127}));
      connect(speedSensor.w, axisControlBus.speed) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(points={{51,50},{74,50},{74,
              87},{-100,87},{-100,0}}, color={0,0,127}));
      connect(accSensor.a, axisControlBus.acceleration) annotation (
        __Dymola_Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3]), Line(points={{51,30},{77,30},{77,
              90},{-102,90},{-102,0},{-100,0}}, color={0,0,127}));
      connect(axisControlBus.angle_ref, initializeFlange.phi_start) annotation (
        __Dymola_Text(
          string="%first",
          index=-1,
          extent=[-6,3; -6,3]), Line(points={{-100,0},{-100,-7},{
              -97,-7},{-97,-42},{-42,-42}}, color={0,0,0}));
      connect(axisControlBus.speed_ref, initializeFlange.w_start) annotation (
        __Dymola_Text(
          string="%first",
          index=-1,
          extent=[-6,3; -6,3]), Line(points={{-100,0},{-99,0},{-99,
              -50},{-42,-50}}, color={0,0,127}));
      connect(initializeFlange.flange, flange) annotation (Line(points={{-20,
              -50},{80,-50},{80,0},{100,0}}, color={0,0,0}));
      connect(const.y, initializeFlange.a_start) annotation (Line(points={{-54.5,
              -60},{-48,-60},{-48,-58},{-42,-58}},       color={0,0,127}));
      annotation (
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
"),     Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Rectangle(
              extent={{-100,50},{100,-50}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}), Text(
              extent={{-150,57},{150,97}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics));
    end AxisType2;

    model MechanicalStructure
      "Model of the mechanical part of the r3 robot (without animation)"

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
        annotation (Placement(transformation(extent={{-220,-180},{-200,-160}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis2
        annotation (Placement(transformation(extent={{-220,-120},{-200,-100}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis3
        annotation (Placement(transformation(extent={{-220,-60},{-200,-40}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis4
        annotation (Placement(transformation(extent={{-220,0},{-200,20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis5
        annotation (Placement(transformation(extent={{-220,60},{-200,80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis6
        annotation (Placement(transformation(extent={{-220,120},{-200,140}},
              rotation=0)));
      inner Modelica.Mechanics.MultiBody.World world(
        g=(g)*Modelica.Math.Vectors.length(
                                      ({0,-1,0})),
        n={0,-1,0},
        animateWorld=false,
        animateGravity=false,
        enableAnimation=animation)
                              annotation (Placement(transformation(extent={{
                -100,-200},{-80,-180}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute r1(n={0,1,0},useAxisFlange=true,
          animation=animation)
        annotation (Placement(transformation(
            origin={-70,-160},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Joints.Revolute r2(n={1,0,0},useAxisFlange=true,
          animation=animation)
        annotation (Placement(transformation(extent={{-50,-110},{-30,-90}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute r3(n={1,0,0},useAxisFlange=true,
          animation=animation)
        annotation (Placement(transformation(
            origin={-50,-36},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Joints.Revolute r4(n={0,1,0},useAxisFlange=true,
          animation=animation)
        annotation (Placement(transformation(
            origin={-70,10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Joints.Revolute r5(n={1,0,0},useAxisFlange=true,
          animation=animation)
        annotation (Placement(transformation(extent={{-60,70},{-40,90}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute r6(n={0,1,0},useAxisFlange=true,
          animation=animation)
        annotation (Placement(transformation(
            origin={-60,130},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b0(
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
        animateSphere=false,
        r_CM={0,0,0},
        m=1)
        annotation (Placement(transformation(
            origin={-30,-170},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b1(
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
        color={255,0,0},
        r_CM={0,0,0},
        m=1)             annotation (Placement(transformation(
            origin={-70,-118},
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
        shapeType="2",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.5,
        width=0.2,
        height=0.15,
        animation=animation,
        animateSphere=false,
        color={255,178,0}) annotation (Placement(transformation(
            origin={-16,-70},
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
        shapeType="3",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.15,
        width=0.15,
        height=0.15,
        animation=animation,
        animateSphere=false,
        color={255,0,0}) annotation (Placement(transformation(
            origin={-86,-22},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b4(
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
        color={255,178,0}) annotation (Placement(transformation(
            origin={-70,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b5(
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
        color={0,0,255}) annotation (Placement(transformation(
            origin={-20,98},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape b6(
        r={0,0,0},
        r_CM={0.05,0.05,0.05},
        m=0.5,
        shapeType="6",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        animation=animation,
        animateSphere=false,
        color={0,0,255}) annotation (Placement(transformation(
            origin={-60,160},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape load(
        r_CM=rLoad,
        m=mLoad,
        r_shape={0,0,0},
        widthDirection={1,0,0},
        width=0.05,
        height=0.05,
        color={255,0,0},
        lengthDirection=rLoad,
        length=Modelica.Math.Vectors.length(              rLoad),
        animation=animation)
        annotation (Placement(transformation(
            origin={-60,188},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      connect(r6.frame_b, b6.frame_a)
        annotation (Line(
          points={{-60,140},{-60,150}},
          color={95,95,95},
          thickness=0.5));
      q = {r1.phi,r2.phi,r3.phi,r4.phi,r5.phi,r6.phi};
      qd = der(q);
      qdd = der(qd);
      tau = {r1.axis.tau,r2.axis.tau,r3.axis.tau,r4.axis.tau,r5.axis.tau,r6.
        axis.tau};
      connect(load.frame_a, b6.frame_b)
        annotation (Line(
          points={{-60,178},{-60,170}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, b0.frame_a) annotation (Line(
          points={{-80,-190},{-30,-190},{-30,-180}},
          color={95,95,95},
          thickness=0.5));
      connect(b0.frame_b, r1.frame_a) annotation (Line(
          points={{-30,-160},{-30,-146},{-48,-146},{-48,-180},{-70,-180},{-70,
              -170}},
          color={95,95,95},
          thickness=0.5));
      connect(b1.frame_b, r2.frame_a) annotation (Line(
          points={{-70,-108},{-70,-100},{-50,-100}},
          color={95,95,95},
          thickness=0.5));
      connect(r1.frame_b, b1.frame_a) annotation (Line(
          points={{-70,-150},{-70,-128}},
          color={95,95,95},
          thickness=0.5));
      connect(r2.frame_b, b2.frame_a) annotation (Line(
          points={{-30,-100},{-16,-100},{-16,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(b2.frame_b, r3.frame_a) annotation (Line(
          points={{-16,-60},{-16,-36},{-40,-36}},
          color={95,95,95},
          thickness=0.5));
      connect(r2.axis, axis2) annotation (Line(points={{-40,-90},{-42,-90},{-42,
              -80},{-160,-80},{-160,-110},{-210,-110}}, color={0,0,0}));
      connect(r1.axis, axis1) annotation (Line(points={{-80,-160},{-160,-160},{
              -160,-170},{-210,-170}}, color={0,0,0}));
      connect(r3.frame_b, b3.frame_a) annotation (Line(
          points={{-60,-36},{-88,-36},{-86,-32}},
          color={95,95,95},
          thickness=0.5));
      connect(b3.frame_b, r4.frame_a) annotation (Line(
          points={{-86,-12},{-86,-8},{-70,-8},{-70,0}},
          color={95,95,95},
          thickness=0.5));
      connect(r3.axis, axis3)
        annotation (Line(points={{-50,-46},{-50,-50},{-210,-50}}, color={0,0,0}));
      connect(r4.axis, axis4)
        annotation (Line(points={{-80,10},{-210,10}}, color={0,0,0}));
      connect(r4.frame_b, b4.frame_a)
        annotation (Line(
          points={{-70,20},{-70,40}},
          color={95,95,95},
          thickness=0.5));
      connect(b4.frame_b, r5.frame_a) annotation (Line(
          points={{-70,60},{-70,80},{-60,80}},
          color={95,95,95},
          thickness=0.5));
      connect(r5.axis, axis5) annotation (Line(points={{-50,90},{-50,94},{-160,
              94},{-160,70},{-210,70}}, color={0,0,0}));
      connect(r5.frame_b, b5.frame_a) annotation (Line(
          points={{-40,80},{-20,80},{-20,88}},
          color={95,95,95},
          thickness=0.5));
      connect(b5.frame_b, r6.frame_a) annotation (Line(
          points={{-20,108},{-20,116},{-60,116},{-60,120}},
          color={95,95,95},
          thickness=0.5));
      connect(r6.axis, axis6)
        annotation (Line(points={{-70,130},{-210,130}}, color={0,0,0}));
      annotation (
        Documentation(info="<HTML>
<p>
This model contains the mechanical components of the r3 robot
(multibody system).
</p>
</HTML>
"),     Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-200,-200},{200,200}},
            grid={2,2}), graphics={
            Rectangle(
              extent={{-200,200},{200,-200}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-200,250},{200,210}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-200,-150},{-140,-190}},
              textString="1",
              lineColor={0,0,255}),
            Text(
              extent={{-200,-30},{-140,-70}},
              textString="3",
              lineColor={0,0,255}),
            Text(
              extent={{-200,-90},{-140,-130}},
              textString="2",
              lineColor={0,0,255}),
            Text(
              extent={{-200,90},{-140,50}},
              textString="5",
              lineColor={0,0,255}),
            Text(
              extent={{-200,28},{-140,-12}},
              textString="4",
              lineColor={0,0,255}),
            Text(
              extent={{-198,150},{-138,110}},
              textString="6",
              lineColor={0,0,255}),
            Bitmap(extent={{-130,195},{195,-195}}, fileName=
                  "modelica://Modelica/Resources/Images/MultiBody/Examples/Systems/robot_kr15.bmp")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-200,-200},{200,200}},
            grid={2,2}), graphics));
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
    Documentation(info="<HTML>
<p>
This package contains models of the robot r3 of the company Manutec.
These models are used to demonstrate in which way complex
robot models might be built up by testing first the component
models individually before composing them together.
Furthermore, it is shown how CAD data can be used
for animation.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Systems/robot_kr15.bmp\"
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
