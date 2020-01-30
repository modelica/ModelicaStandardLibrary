within Modelica.Electrical.Machines.Examples.DCMachines;
model DCEE_Start
  "Test example: DC with electrical excitation starting with voltage ramp"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "Actual armature voltage";
  parameter SI.Time tStart=0.2
    "Start of armature voltage ramp";
  parameter SI.Time tRamp=0.8 "Armature voltage ramp";
  parameter SI.Voltage Ve=100 "Actual excitation voltage";
  parameter SI.Torque TLoad=63.66 "Nominal load torque";
  parameter SI.Time tStep=1.5 "Time of load torque step";
  parameter SI.Inertia JLoad=0.15
    "Load's moment of inertia";
  Machines.BasicMachines.DCMachines.DC_ElectricalExcited dcee(
    VaNominal=dceeData.VaNominal,
    IaNominal=dceeData.IaNominal,
    wNominal=dceeData.wNominal,
    TaNominal=dceeData.TaNominal,
    Ra=dceeData.Ra,
    TaRef=dceeData.TaRef,
    La=dceeData.La,
    Jr=dceeData.Jr,
    useSupport=false,
    Js=dceeData.Js,
    frictionParameters=dceeData.frictionParameters,
    coreParameters=dceeData.coreParameters,
    strayLoadParameters=dceeData.strayLoadParameters,
    brushParameters=dceeData.brushParameters,
    IeNominal=dceeData.IeNominal,
    Re=dceeData.Re,
    TeRef=dceeData.TeRef,
    Le=dceeData.Le,
    sigmae=dceeData.sigmae,
    TaOperational=293.15,
    alpha20a=dceeData.alpha20a,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    ia(fixed=true),
    alpha20e=dceeData.alpha20e,
    TeOperational=293.15,
    ie(fixed=true))
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
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=Ve)
    annotation (Placement(transformation(
        origin={-40,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
      Placement(transformation(
        origin={-70,-50},
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
  parameter Utilities.ParameterRecords.DcElectricalExcitedData dceeData "DC machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(ramp.y, signalVoltage.v) annotation (Line(points={{-59,70},{-10,70},{-10,52}},
                         color={0,0,255}));
  connect(signalVoltage.p, dcee.pin_ap) annotation (Line(points={{0,40},{
          0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
  connect(signalVoltage.n, ground.p)
    annotation (Line(points={{-20,40},{-60,40}}, color={0,0,255}));
  connect(dcee.pin_an, ground.p) annotation (Line(points={{-16,-30},{-16,
          -20},{-20,-20},{-20,40},{-60,40}}, color={0,0,255}));
  connect(constantVoltage.n, groundExcitation.p)
    annotation (Line(points={{-40,-50},{-60,-50}}, color={0,0,255}));
  connect(dcee.pin_ep, constantVoltage.p) annotation (Line(points={{-20,-34},
          {-30,-34},{-30,-30},{-40,-30}}, color={0,0,255}));
  connect(dcee.pin_en, constantVoltage.n) annotation (Line(points={{-20,-46},
          {-30,-46},{-30,-50},{-40,-50}}, color={0,0,255}));
  connect(loadInertia.flange_b, loadTorqueStep.flange)
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(dcee.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<strong>Test example: Electrically separate excited DC machine started with an armature voltage ramp</strong><br>
A voltage ramp is applied to the armature, causing the DC machine to start,
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcee.ia: armature current</li>
<li>dcee.wMechanical: motor's speed</li>
<li>dcee.tauElectrical: motor's torque</li>
<li>dcee.ie: excitation current</li>
</ul>
Default machine parameters of model <em>DC_ElectricalExcited</em> are used.
</html>"));
end DCEE_Start;
