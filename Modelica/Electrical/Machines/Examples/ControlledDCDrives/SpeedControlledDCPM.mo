within Modelica.Electrical.Machines.Examples.ControlledDCDrives;
model SpeedControlledDCPM
  "Speed controlled DC PM drive with H-bridge from battery"
  extends Utilities.PartialControlledDCPM;
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
    stepTorque=-driveData.tauNominal,
    offsetTorque=0,
    startTime=0.8)
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Utilities.LimitedPI speedController(
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=driveData.kpw,
    Ti=driveData.Tiw,
    constantLimits=true,
    yMax=driveData.tauMax)
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Modelica.Blocks.Continuous.FirstOrder preFilter(
    k=1,
    T=driveData.Tfw,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-160,0},{-140,20}})));
  Modelica.Blocks.Sources.Step step(
    offset=0,
    height=driveData.motorData.wNominal,
    startTime=0.2)                       annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-190,-10})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(initType=Modelica.Blocks.Types.Init.InitialOutput,
      Rising=driveData.aMax)
    annotation (Placement(transformation(extent={{-160,-40},{-140,-20}})));
equation
  connect(step.y, preFilter.u) annotation (Line(points={{-179,-10},{-170,-10},
          {-170,10},{-162,10}},
                              color={0,0,127}));
  connect(loadInertia.flange_b, loadTorque.flange)
    annotation (Line(points={{70,-40},{80,-40}}));
  connect(speedSensor.w, speedController.u_m) annotation (Line(points={{50,-81},
          {50,-90},{-116,-90},{-116,-22}},   color={0,0,127}));
  connect(speedController.y, tau2i.u)
    annotation (Line(points={{-99,-10},{-82,-10}},
                                                 color={0,0,127}));
  connect(step.y, slewRateLimiter.u) annotation (Line(points={{-179,-10},{
          -170,-10},{-170,-30},{-162,-30}}, color={0,0,127}));
  connect(speedController.u, preFilter.y) annotation (Line(points={{-122,-10},
          {-130,-10},{-130,10},{-139,10}}, color={0,0,127}));
  annotation (experiment(StopTime=1, Interval=0.0001), Documentation(info="<html>
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
    Diagram(coordinateSystem(extent={{-200,-100},{100,100}})));
end SpeedControlledDCPM;
