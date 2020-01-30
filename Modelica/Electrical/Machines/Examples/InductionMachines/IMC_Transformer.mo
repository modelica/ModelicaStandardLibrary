within Modelica.Electrical.Machines.Examples.InductionMachines;
model IMC_Transformer
  "Test example: InductionMachineSquirrelCage transformer starting"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.Time tStart1=0.1 "Start time";
  parameter SI.Time tStart2=2.0
    "Start time of bypass transformer";
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
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(
        origin={0,80},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={-30,90},
        extent={{10,10},{-10,-10}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep1[m](each startTime=
        tStart1) annotation (Placement(transformation(extent={{-60,40},{-40,
            60}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={0,50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Machines.BasicMachines.Transformers.Yy.Yy00 transformer(
    n=transformerData.n,
    R1=transformerData.R1,
    L1sigma=transformerData.L1sigma,
    R2=transformerData.R2,
    L2sigma=transformerData.L2sigma,
    T1Ref=293.15,
    alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T2Ref=293.15,
    alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T1Operational=293.15,
    T2Operational=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,30})));

  Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(
        transformation(
        origin={-50,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  parameter Machines.Utilities.TransformerData transformerData(
    f=fNominal,
    V1=VNominal,
    C1=Modelica.Utilities.Strings.substring(
        transformer.VectorGroup,
        1,
        1),
    V2=VNominal/sqrt(3),
    C2=Modelica.Utilities.Strings.substring(
        transformer.VectorGroup,
        2,
        2),
    SNominal=50E3,
    v_sc=0.06,
    P_sc=500) "Transformer data"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep2[m](each startTime=
        tStart2) annotation (Placement(transformation(extent={{-60,-10},{
            -40,10}})));
  Modelica.Electrical.Polyphase.Ideal.IdealCommutingSwitch
    idealCommutingSwitch(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(50E-5, m)) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque(
    w_nominal=wLoad,
    TorqueDirection=false,
    tau_nominal=-TLoad,
    useSupport=false) annotation (Placement(transformation(extent={{90,-50},
            {70,-30}})));
  Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  parameter Utilities.ParameterRecords.IM_SquirrelCageData aimcData "Induction machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
initial equation
  aimc.is = zeros(3);
  aimc.ir = zeros(2);
  transformer.i1[1:2] = zeros(2);
equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}},
      color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (
      Line(
      points={{60,-40},{70,-40}}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  connect(star.plug_p, sineVoltage.plug_n) annotation (Line(
      points={{-50,90},{-40,90}},
      color={0,0,255}));
  connect(booleanStep2.y, idealCommutingSwitch.control) annotation (Line(
      points={{-39,0},{-12,0}},color={255,0,255}));
  connect(transformer.starpoint2, ground2.p) annotation (Line(
      points={{-30,25},{-30,20},{-40,20}},
      color={0,0,255}));
  connect(idealCommutingSwitch.plug_p, terminalBox.plugSupply)
    annotation (Line(
      points={{0,-10},{-10,-10},{-10,-28}},
      color={0,0,255}));
  connect(transformer.plug2, idealCommutingSwitch.plug_n1) annotation (
      Line(
      points={{-20,20},{-4,20},{-4,10}}, color={0,0,255}));
  connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
      Line(
      points={{-20,90},{0,90}},
      color={0,0,255}));
  connect(booleanStep1.y, idealCloser.control) annotation (Line(
      points={{-39,50},{-12,50}},color={255,0,255}));
  connect(currentQuasiRMSSensor.plug_n, idealCloser.plug_p) annotation (
      Line(
      points={{0,70},{0,60}},
      color={0,0,255}));
  connect(transformer.plug1, idealCloser.plug_n) annotation (Line(
      points={{-20,40},{0,40}},
      color={0,0,255}));
  connect(idealCloser.plug_n, idealCommutingSwitch.plug_n2) annotation (
      Line(
      points={{0,40},{0,10}}, color={0,0,255}));
  annotation (experiment(StopTime=2.5, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>
At start time tStart1 three-phase voltage is supplied to the induction machine with squirrel cage via the transformer;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed;
at start time tStart2 the machine is fed directly from the voltage source, finally reaching nominal speed.</p>

<p>Simulate for 2.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
end IMC_Transformer;
