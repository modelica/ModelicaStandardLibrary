within Modelica.Electrical.Machines.Examples.InductionMachines;
model IMC_YD
  "Test example: InductionMachineSquirrelCage Y-D"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.Time tStart1=0.1 "Start time";
  parameter SI.Time tStart2=2.0 "Start time from Y to D";
  parameter SI.Torque TLoad=161.4 "Nominal load torque";
  parameter SI.AngularVelocity wLoad(displayUnit="rev/min")=
       1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
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
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270,
        origin={0,-10})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={-30,90},
        extent={{10,-10},{-10,10}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=
        tStart1) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={0,20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Machines.Utilities.SwitchYD switchYD(m=m)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.BooleanStep booleanStepYD[m](each startTime=
        tStart2) annotation (Placement(transformation(extent={{-80,-40},{-60,
            -20}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque(
    w_nominal=wLoad,
    TorqueDirection=false,
    tau_nominal=-TLoad,
    useSupport=false) annotation (Placement(transformation(extent={{90,-60},{70,
            -40}})));
  parameter Utilities.ParameterRecords.IM_SquirrelCageData aimcData "Induction machine data"
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
initial equation
  aimc.is = zeros(3);
  aimc.ir = zeros(2);
equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{-40,90},{-50,90}},      color={0,0,255}));
  connect(sineVoltage.plug_p, idealCloser.plug_p) annotation (Line(points={{-20,90},
          {0,90},{0,30}},               color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange)
    annotation (Line(points={{60,-50},{70,-50}}));
  connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-59,30},
          {-20,30},{-20,20},{-12,20}},    color={255,0,255}));
  connect(booleanStepYD.y, switchYD.control)
    annotation (Line(points={{-59,-30},{-22,-30}}, color={255,0,255}));
  connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p)
    annotation (Line(points={{0,10},{0,0}},         color={0,0,255}));
  connect(switchYD.plug_sn, aimc.plug_sn) annotation (Line(
      points={{-16,-40},{-16,-40}},
      color={0,0,255}));
  connect(switchYD.plug_sp, aimc.plug_sp) annotation (Line(
      points={{-4,-40},{-4,-40}},
      color={0,0,255}));
  connect(switchYD.plugSupply, currentQuasiRMSSensor.plug_n) annotation (
      Line(
      points={{-10,-20},{0,-20}},
      color={0,0,255}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-50},{40,-50}}));
  annotation (experiment(StopTime=2.5, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>At start time tStart three-phase voltage is supplied to the induction machine with squirrel cage,
first star-connected, then delta-connected; the machine starts from standstill, accelerating inertias against
load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<p>Simulate for 2.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
end IMC_YD;
