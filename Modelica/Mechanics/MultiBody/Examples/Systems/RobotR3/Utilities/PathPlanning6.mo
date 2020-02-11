within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model PathPlanning6
  "Generate reference angles for fastest kinematic movement"
  extends Blocks.Icons.Block;

  parameter Integer naxis=6 "Number of driven axis";
  parameter Modelica.Units.NonSI.Angle_deg angleBegDeg[naxis] = zeros(naxis)
    "Start angles";
  parameter Modelica.Units.NonSI.Angle_deg angleEndDeg[naxis] = ones(naxis)
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
          textColor={192,192,192},
          textString="w"),
        Line(points={{-80,0},{-41,69},{26,69},{58,0}}),
        Text(extent={{-70,-44},{84,-68}}, textString="6 axes")}),
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
