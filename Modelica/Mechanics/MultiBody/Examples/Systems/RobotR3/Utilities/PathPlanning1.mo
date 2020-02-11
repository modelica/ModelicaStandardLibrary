within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model PathPlanning1
  "Generate reference angles for fastest kinematic movement"
  extends Blocks.Icons.Block;

  parameter Modelica.Units.NonSI.Angle_deg angleBegDeg = 0 "Start angle";
  parameter Modelica.Units.NonSI.Angle_deg angleEndDeg = 1 "End angle";
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
          textColor={192,192,192},
          textString="w"),
        Line(points={{-80,0},{-41,69},{26,69},{58,0}}),
        Text(extent={{-70,-44},{84,-68}}, textString="1 axis")}),
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
