within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
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
          extent={{-92,98},{-16,68}},
          textString="q",
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left),
        Text(
          extent={{-92,46},{-16,16}},
          textString="qd",
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left),
        Text(
          extent={{-92,-16},{-16,-46}},
          textString="qdd",
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left),
        Text(
          extent={{-2,20},{80,-18}},
          textString="%axisUsed"),
        Text(
          extent={{2,52},{76,28}},
          textString="axis"),
        Text(
          extent={{-92,-70},{36,-96}},
          textString="moving",
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(info="<html>
<p>
This model stores the 4 reference variables q, qd, qdd, moving from the path planning on the axis control bus.
</p>
</html>"));
end PathToAxisControlBus;
