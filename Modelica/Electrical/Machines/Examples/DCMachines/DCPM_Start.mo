within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_Start
  "Test example: DC with permanent magnet starting with voltage ramp"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "Actual armature voltage";
  parameter SI.Time tStart=0.2
    "Start of armature voltage ramp";
  parameter SI.Time tRamp=0.8 "Armature voltage ramp";
  parameter SI.Torque TLoad=63.66 "Nominal load torque";
  parameter SI.Time tStep=1.5 "Time of load torque step";
  parameter SI.Inertia JLoad=0.15
    "Load's moment of inertia";
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
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=tRamp,
    height=Va,
    startTime=tStart) annotation (Placement(transformation(extent={{-80,
            60},{-60,80}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
    annotation (Placement(transformation(extent={{0,30},{-20,50}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-70,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
    startTime=tStep,
    stepTorque=-TLoad,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
            {70,-30}})));
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData "DC machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(ramp.y, signalVoltage.v) annotation (Line(points={{-59,70},{-10,70},{-10,52}},
                         color={0,0,255}));
  connect(signalVoltage.p, dcpm.pin_ap) annotation (Line(points={{0,40},{
          0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
  connect(signalVoltage.n, ground.p)
    annotation (Line(points={{-20,40},{-60,40}}, color={0,0,255}));
  connect(dcpm.pin_an, signalVoltage.n) annotation (Line(points={{-16,-30},
          {-16,-20},{-20,-20},{-20,40}}, color={0,0,255}));
  connect(loadInertia.flange_b, loadTorqueStep.flange)
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<strong>Test example: Permanent magnet DC machine started with an armature voltage ramp</strong><br>
A voltage ramp is applied to the armature, causing the DC machine to start,
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcpm.ia: armature current</li>
<li>dcpm.wMechanical: motor's speed</li>
<li>dcpm.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <em>DC_PermanentMagnet</em> are used.
</html>"));
end DCPM_Start;
