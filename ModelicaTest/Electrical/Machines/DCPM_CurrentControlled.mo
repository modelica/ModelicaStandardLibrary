within ModelicaTest.Electrical.Machines;
model DCPM_CurrentControlled "Current controlled DCPM drive"
  extends Modelica.Icons.Example;
  parameter ModelicaTest.Electrical.Machines.DCPM_Utilities.DriveData driveData(
      redeclare ModelicaTest.Electrical.Machines.DCPM_Utilities.M48V
      machineData)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  ModelicaTest.Electrical.Machines.DCPM_Utilities.DCPM dcpm(
    machineData=driveData.machineData,
    iA(fixed=true),
    phi(fixed=true),
    w(fixed=true))
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,-50})));
  Modelica.Blocks.Sources.Step iRef(
    height=driveData.machineData.IANominal,
    offset=0,
    startTime=0.1)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(
    J=driveData.JL,
    phi(fixed=false),
    w(fixed=false))
    annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
  Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque torqueLoad(
    tau_nominal=-driveData.machineData.tauNominal,
    TorqueDirection=false,
    w_nominal=driveData.machineData.wNominal)
    annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage voltageSource
    annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={20,-30})));
  Modelica.Blocks.Continuous.FirstOrder deadTime(
    k=1,
    T=driveData.Td,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,20})));
  Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI currentController(
    k=driveData.controllerData.kpI,
    Ti=driveData.controllerData.TiI,
    useFF=true,
    KFF=driveData.machineData.kPhi,
    yMax=driveData.VBat,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=0) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
equation
  connect(dcpm.shaft, inertiaLoad.flange_a)
    annotation (Line(points={{40,-70},{50,-70}}, color={0,0,0}));
  connect(torqueLoad.flange, inertiaLoad.flange_b)
    annotation (Line(points={{80,-70},{70,-70}}, color={0,0,0}));
  connect(ground.p,dcpm. pin_n)
    annotation (Line(points={{20,-50},{24,-50},{24,-60}},  color={0,0,255}));
  connect(ground.p, currentSensor.p)
    annotation (Line(points={{20,-50},{20,-40}}, color={0,0,255}));
  connect(currentSensor.n,voltageSource. n)
    annotation (Line(points={{20,-20},{20,-10}}, color={0,0,255}));
  connect(voltageSource.p,dcpm. pin_p)
    annotation (Line(points={{40,-10},{40,-50},{36,-50},{36,-60}}, color={0,0,255}));
  connect(deadTime.y, voltageSource.v)
    annotation (Line(points={{30,9},{30,2}}, color={0,0,127}));
  connect(iRef.y, currentController.u)
    annotation (Line(points={{-19,40},{-12,40}}, color={0,0,127}));
  connect(currentSensor.i, currentController.u_m)
    annotation (Line(points={{9,-30},{-6,-30},{-6,28}}, color={0,0,127}));
  connect(dcpm.w, currentController.feedForward)
    annotation (Line(points={{19,-70},{0,-70},{0,28}}, color={0,0,127}));
  connect(currentController.y, deadTime.u)
    annotation (Line(points={{11,40},{30,40},{30,32}}, color={0,0,127}));
  annotation (experiment(
      StopTime=1,
      Interval=0.0001,
      Tolerance=1e-06), Documentation(info="<html>
<p>
Simulates a current controlled DCPM machine. The load applies a linearly speed dependent torque, which in the end causes the drive to operate in nominal operation.
</p>
<p>
Additionally, the handling of parameter records can be tested:
By simply redeclaring the machine parameter record instantiated in the drive parameter record, a machine with different parameters can be simulated.
</p>
</html>"));
end DCPM_CurrentControlled;
