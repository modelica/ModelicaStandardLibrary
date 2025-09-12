within Modelica.Electrical.Machines.Examples.InductionMachines;
model IMC_Conveyor
  "Test example: InductionMachineSquirrelCage with inverter driving a conveyor"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  constant SI.Frequency unitFrequency=1 annotation(HideResult=true);
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=aimcData.fsNominal
    "Nominal frequency";
  parameter SI.AngularVelocity wNominal=2*pi*fNominal/aimcData.p
    "Nominal speed";
  parameter SI.Torque TLoad=161.4 "Nominal load torque";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  parameter SI.Length r=0.05 "Transmission radius";
  Machines.BasicMachines.InductionMachines.IM_SquirrelCage aimc(
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    Rs=aimcData.Rs,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    Lszero=aimcData.Lszero,
    Lssigma=aimcData.Lssigma,
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    frictionParameters=aimcData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=aimcData.statorCoreParameters,
    strayLoadParameters=aimcData.strayLoadParameters,
    Lm=aimcData.Lm,
    Lrsigma=aimcData.Lrsigma,
    Rr=aimcData.Rr,
    TrRef=aimcData.TrRef,
    TsOperational=293.15,
    alpha20r=aimcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
  Blocks.Sources.CombiTimeTable dutyCycle(
    table=[0,0; 1,1; 4,1; 5,0; 10,0; 11, -1; 14,-1; 15,0; 20,0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Machines.Utilities.VfController vfController(
    final m=m,
    VNominal=VNominal,
    fNominal=fNominal)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage(
      final m=m) annotation (Placement(transformation(
        origin={0,60},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  parameter Utilities.ParameterRecords.IM_SquirrelCageData aimcData "Induction machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Blocks.Math.Gain gain(k=fNominal)
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio=1/r)
    annotation (Placement(transformation(extent={{12,-50},{32,-30}})));
  Mechanics.Translational.Components.Mass mass(m=JLoad/r^2)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Mechanics.Translational.Sources.SignForce signForce(                           v0(
        displayUnit="m/s") = 0.01*wNominal*r, f_nominal=-TLoad/r)
    annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
initial equation
  aimc.is[1:2] = zeros(2);
  aimc.ir = zeros(2);

equation
  connect(signalVoltage.plug_n, star.plug_p)
    annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(vfController.y, signalVoltage.v)
    annotation (Line(points={{-19,60},{-12,60}},color={0,0,255}));
  connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p)
    annotation (Line(points={{0,50},{0,40},{0,10}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
    annotation (Line(
      points={{-10,-28},{-10,-20},{0,-20},{0,-10}},
      color={0,0,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}},
      color={0,0,255}));
  connect(vfController.u, gain.y)
    annotation (Line(points={{-42,60},{-49,60}}, color={0,0,127}));
  connect(dutyCycle.y[1], gain.u)
    annotation (Line(points={{-79,60},{-72,60}}, color={0,0,127}));
  connect(aimc.flange, idealGearR2T.flangeR)
    annotation (Line(points={{0,-40},{12,-40}}));
  connect(idealGearR2T.flangeT, mass.flange_a)
    annotation (Line(points={{32,-40},{36,-40},{40,-40}}, color={0,127,0}));
  connect(mass.flange_b, signForce.flange)
    annotation (Line(points={{60,-40},{66,-40},{70,-40}}, color={0,127,0}));
  annotation (experiment(StopTime=20, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is driven by a load cycle of acceleration, constant speed, deceleration and standstill.
The mechanical load is a constant torque like a conveyor (with regularization around zero speed).</p>

<p>Simulate for 20 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
end IMC_Conveyor;
