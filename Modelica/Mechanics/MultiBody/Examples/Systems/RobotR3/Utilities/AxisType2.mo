within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
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
    "Viscous friction torque at zero velocity"
    annotation (Dialog(group="Gear"));
  parameter Real Rv1(unit="N.m.s/rad") = (0.13/160)
    "Viscous friction coefficient"
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
  Controller controller(
    kp=kp,
    ks=ks,
    Ts=Ts,
    ratio=ratio) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus annotation (Placement(transformation(
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
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{68,10},{100,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192},
          lineColor={64,64,64}),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-100,50},{66,-50}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-100,34},{62,-34}},
          fillPattern=FillPattern.Solid,
          fillColor={95,95,95},
          lineColor={0,0,0}),
        Rectangle(
          extent={{60,54},{80,-54}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Rectangle(
          extent={{60,54},{80,-54}}, lineColor={0,0,0})}));
end AxisType2;
