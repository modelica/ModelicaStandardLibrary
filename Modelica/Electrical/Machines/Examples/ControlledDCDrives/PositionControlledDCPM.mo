within Modelica.Electrical.Machines.Examples.ControlledDCDrives;
model PositionControlledDCPM
  "Position controlled DC PM drive with H-bridge from battery"
  extends Utilities.PartialControlledDCPM;
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
    stepTorque=-driveData.tauNominal,
    offsetTorque=0,
    startTime=2.3)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Utilities.LimitedPI speedController(
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=driveData.kpw,
    Ti=driveData.Tiw,
    constantLimits=true,
    yMax=driveData.tauMax)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Utilities.LimitedPI positionController(
    constantLimits=true,
    k=driveData.kpP,
    useI=false,
    yMax=driveData.wMax,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-60})));
  Modelica.Blocks.Sources.KinematicPTP2 kinematicPTP(
    qd_max={driveData.wMax},
    qdd_max={driveData.aMax},
    q_end={200},
    startTime=0.2)
                 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-140,0})));
equation
  connect(positionController.y, speedController.u)
    annotation (Line(points={{-89,0},{-82,0}},   color={0,0,127}));
  connect(angleSensor.phi, positionController.u_m) annotation (Line(
        points={{70,-71},{70,-90},{-106,-90},{-106,-12}},
                                                       color={0,0,127}));
  connect(kinematicPTP.q[1], positionController.u) annotation (Line(
        points={{-129,8},{-120,8},{-120,0},{-112,0}}, color={0,0,127}));
  connect(speedSensor.flange, angleSensor.flange)
    annotation (Line(points={{50,-50},{70,-50}}));
  connect(speedSensor.w, speedController.u_m) annotation (Line(points={{50,-71},
          {50,-80},{-76,-80},{-76,-12}},     color={0,0,127}));
  connect(loadInertia.flange_b, loadTorque.flange)
    annotation (Line(points={{70,-30},{80,-30}}));
  connect(speedController.y, tau2i.u)
    annotation (Line(points={{-59,0},{-52,0},{-52,1.55431e-15}},
                                                 color={0,0,127}));
  annotation (experiment(StopTime=2.5, Interval=0.0001),
                                                       Documentation(info="<html>
<p>This model demonstrates how a position controller for a speed controlled DC PM drive works.</p>
<p>
The inner current controller is parameterized according to the absolute optimum.
The middle control loop is formed by the speed controller which is parameterized according to the symmetrical optimum.
The outer control loop is formed by the position controller which is parameterized to avoid an overshot in the position.
</p>
<p>
At time=0.2 s the kinematicPTP starts to prescribe the reference position with limited speed and limited acceleration.
At time=2.3 s a load torque step is applied, causing the drive to slightly leave the end position until the position controller brings the drive back to the desired position.
</p>
<p>
Further reading:
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">Tutorial at the Modelica Conference 2017</a>
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-160,-100},{100,100}})));
end PositionControlledDCPM;
