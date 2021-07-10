within Modelica.Electrical.Machines.Examples.ControlledDCDrives;
model SpeedControlledDCPM
  "Speed controlled DC PM drive with H-bridge from battery"
  extends Utilities.PartialControlledDCPM;
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
    stepTorque=-driveData.tauNominal,
    offsetTorque=0,
    startTime=0.8)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Utilities.LimitedPI speedController(
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=driveData.kpw,
    Ti=driveData.Tiw,
    constantLimits=true,
    yMax=driveData.tauMax)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Continuous.FirstOrder preFilter(
    k=1,
    T=driveData.Tfw,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Sources.Step step(
    offset=0,
    height=driveData.motorData.wNominal,
    startTime=0.2)                       annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-150,0})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(initType=Modelica.Blocks.Types.Init.InitialOutput,
      Rising=driveData.aMax)
    annotation (Placement(transformation(extent={{-120,-30},{-100,-10}})));
equation
  connect(step.y, preFilter.u) annotation (Line(points={{-139,0},{-130,0},{-130,
          20},{-122,20}},     color={0,0,127}));
  connect(loadInertia.flange_b, loadTorque.flange)
    annotation (Line(points={{70,-30},{80,-30}}));
  connect(speedSensor.w, speedController.u_m) annotation (Line(points={{50,-71},
          {50,-90},{-76,-90},{-76,-12}},     color={0,0,127}));
  connect(speedController.y, tau2i.u)
    annotation (Line(points={{-59,0},{-56,0} ,{-52,0}},   color={0,0,127}));
  connect(step.y, slewRateLimiter.u) annotation (Line(points={{-139,0},{-130,0},
          {-130,-20},{-122,-20}},           color={0,0,127}));
  connect(speedController.u, preFilter.y) annotation (Line(points={{-82,0},{-90,
          0},{-90,20},{-99,20}},           color={0,0,127}));
  annotation (experiment(StopTime=1, Interval=0.5e-04,Tolerance=1e-06), Documentation(info="<html>
<p>This model demonstrates how a speed controller for a current controlled DC PM drive works.</p>
<p>
The inner current controller is parameterized according to the absolute optimum.
The outer control loop is formed by the speed controller which is parameterized according to the symmetrical optimum.
</p>
<p>
At time=0.2 s a reference speed step is applied, causing the drive to accelerate to the desired speed.
At time=0.8 s a load torque step is applied, causing the drive to decelerate until the speed controller brings the drive back to the desired speed.
</p>
<p>
You may try a slewRateLimiter instead of the prefilter to limit the speed rise i.e. the torque.
</p>
<p>
Further reading:
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">Tutorial at the Modelica Conference 2017</a>
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-160,-100},{100,100}})));
end SpeedControlledDCPM;
