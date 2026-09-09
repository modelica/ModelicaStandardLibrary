within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_CurrentControlled
  "Test example: DC with permanent magnet starting with current controller"
  extends Modelica.Icons.Example;
  parameter SI.Torque TLoad=ViNominal*dcpmData.IaNominal/dcpmData.wNominal "Nominal load torque";
  parameter SI.AngularVelocity wLoad=dcpmData.wNominal "Nominal load torque";
  parameter SI.Inertia JLoad=dcpmData.Jr "Load's moment of inertia";
  parameter SI.Resistance Ra=Modelica.Electrical.Machines.Thermal.convertResistance(
    dcpmData.Ra,
    dcpmData.TaRef,
    dcpmData.alpha20a,
    dcpmData.TaNominal) "Warm armature resistance";
  parameter SI.Voltage ViNominal=dcpmData.VaNominal - Ra*dcpmData.IaNominal "Nominal induced voltage";
  parameter SI.Time Ta=dcpmData.La/Ra "Armature time constant";
  parameter SI.Time Ts=1e-3 "Dead time of inverter";
  parameter SI.Resistance k=Ra*Ta/(2*Ts) "Current controller proportional gain";
  parameter SI.Time Ti=Ta "Current controller integral time constant";
  parameter SI.MagneticFlux kPhi=ViNominal/dcpmData.wNominal "Voltage constant";
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
    VaNominal=dcpmData.VaNominal,
    IaNominal=dcpmData.IaNominal,
    wNominal=dcpmData.wNominal,
    TaNominal=dcpmData.TaNominal,
    Ra=dcpmData.Ra,
    TaRef=dcpmData.TaRef,
    La=dcpmData.La,
    Jr=dcpmData.Jr,
    useSupport=false,
    Js=dcpmData.Js,
    frictionParameters=dcpmData.frictionParameters,
    coreParameters=dcpmData.coreParameters,
    strayLoadParameters=dcpmData.strayLoadParameters,
    brushParameters=dcpmData.brushParameters,
    TaOperational=293.15,
    alpha20a=dcpmData.alpha20a,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    ia(fixed=true))
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Blocks.Sources.Step          step(
    height=dcpmData.IaNominal,
    offset=0,
    startTime=0.1)    annotation (Placement(transformation(extent={{-80,50},{-60,
            70}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
    annotation (Placement(transformation(extent={{20,20},{0,40}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-18,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque loadTorque(
    useSupport=false,
    tau_nominal=-TLoad,
    TorqueDirection=false,
    w_nominal=wLoad)
    annotation (Placement(transformation(extent={{90,-30},{70,-10}})));
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData "DC machine data"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Analog.Sensors.CurrentSensor currentSensor annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,10})));
  Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-38})));
  Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=Ts,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Blocks.Continuous.LimPID PID(withFeedForward=true, initType=Modelica.Blocks.Types.Init.InitialOutput,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    yMax=dcpmData.VaNominal,
    kFF=kPhi)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
equation
  connect(signalVoltage.n, ground.p)
    annotation (Line(points={{0,30},{0,0},{-8,0}}, color={0,0,255}));
  connect(loadInertia.flange_b, loadTorque.flange)
    annotation (Line(points={{60,-20},{70,-20}}));
  connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
      points={{20,-20},{40,-20}}));
  connect(dcpm.pin_an, ground.p)
    annotation (Line(points={{4,-10},{4,0},{-8,0}}, color={0,0,255}));
  connect(signalVoltage.p, currentSensor.p)
    annotation (Line(points={{20,30},{20,20}}, color={0,0,255}));
  connect(currentSensor.n, dcpm.pin_ap)
    annotation (Line(points={{20,0},{16,0},{16,-10}}, color={0,0,255}));
  connect(dcpm.flange, speedSensor.flange)
    annotation (Line(points={{20,-20},{30,-20},{30,-28}}));
  connect(firstOrder.y, signalVoltage.v)
    annotation (Line(points={{1,60},{10,60},{10,42}}, color={0,0,127}));
  connect(PID.y, firstOrder.u)
    annotation (Line(points={{-29,60},{-22,60}}, color={0,0,127}));
  connect(step.y, PID.u_s)
    annotation (Line(points={{-59,60},{-52,60}}, color={0,0,127}));
  connect(currentSensor.i, PID.u_m) annotation (Line(points={{31,10},{100,10},{100,
          -82},{-40,-82},{-40,48}}, color={0,0,127}));
  connect(speedSensor.w, PID.u_ff) annotation (Line(points={{30,-49},{30,-70},{-34,
          -70},{-34,48}}, color={0,0,127}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<strong>Test example: Permanent magnet DC machine started with current controller</strong><br>
The current controller is parameterized according to absolute optimum.
At time 0.1 s a reference current step with height = nominal armature current is applied,
causing the DC machine to start, and accelerating inertias.
<br>The machine is loaded by a quadratic speed dependent load torque.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcpm.ia: armature current</li>
<li>dcpm.wMechanical: motor's speed</li>
<li>dcpm.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <em>DC_PermanentMagnet</em> are used.
</html>"));
end DCPM_CurrentControlled;
