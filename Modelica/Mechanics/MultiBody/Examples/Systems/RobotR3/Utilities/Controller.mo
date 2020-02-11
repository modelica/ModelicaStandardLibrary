within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
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
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
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
        Rectangle(extent={{-80,40},{80,-40}}, lineColor={0,0,127}),
        Polygon(
          points={{-30,40},{-60,50},{-60,30},{-30,40}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{60,-30},{30,-40},{60,-50},{60,-30}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127}),
        Rectangle(
          extent={{-30,56},{30,24}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127}),
        Rectangle(
          extent={{-30,-24},{30,-56}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127})}),
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
