within Modelica.Electrical.Machines.Examples.ControlledDCDrives;
model PositionControlledDCPM
  "Position controlled DC PM drive with H-bridge from battery"
  extends Utilities.PartialControlledDCPM;
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
    stepTorque=-driveData.tauNominal,
    offsetTorque=0,
    startTime=2.3)
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Utilities.LimitedPI speedController(
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=driveData.kpw,
    Ti=driveData.Tiw,
    constantLimits=true,
    yMax=driveData.tauMax)
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Utilities.LimitedPI positionController(
    constantLimits=true,
    k=driveData.kpP,
    useI=false,
    yMax=driveData.wMax,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{-150,-20},{-130,0}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-70})));
  Modelica.Blocks.Sources.KinematicPTP2 kinematicPTP(
    qd_max={driveData.wMax},
    qdd_max={driveData.aMax},
    q_end={200},
    startTime=0.2)
                 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-180,-10})));
equation
  connect(positionController.y, speedController.u)
    annotation (Line(points={{-129,-10},{-122,-10}},
                                                 color={0,0,127}));
  connect(angleSensor.phi, positionController.u_m) annotation (Line(
        points={{70,-81},{70,-100},{-146,-100},{-146,-22}},
                                                       color={0,0,127}));
  connect(kinematicPTP.q[1], positionController.u) annotation (Line(
        points={{-169,-2},{-160,-2},{-160,-10},{-152,-10}},
                                                      color={0,0,127}));
  connect(speedSensor.flange, angleSensor.flange)
    annotation (Line(points={{50,-60},{70,-60}}));
  connect(speedSensor.w, speedController.u_m) annotation (Line(points={{50,-81},
          {50,-90},{-116,-90},{-116,-22}},   color={0,0,127}));
  connect(loadInertia.flange_b, loadTorque.flange)
    annotation (Line(points={{70,-40},{80,-40}}));
  connect(speedController.y, tau2i.u)
    annotation (Line(points={{-99,-10},{-82,-10}},
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
    Diagram(coordinateSystem(extent={{-200,-100},{100,100}})));
end PositionControlledDCPM;
