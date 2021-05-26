within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Initialize "Steady-state initialization of induction machine with squirrel cage"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=imc.fsNominal "Nominal frequency";
  parameter SI.AngularVelocity wSync=2*pi*fNominal/imcData.p "Synchronous speed";
  parameter SI.Time tStart=0.5 "Start time";
  parameter SI.Torque TLoad=161.4 "Nominal load torque";
  parameter SI.AngularVelocity wLoad(displayUnit="rev/min")=
       1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage
    imcQS(
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    wMechanical(fixed=true, start=2*pi*imcData.fsNominal/imcData.p),
    gammar(fixed=true, start=pi/2),
    gamma(fixed=true, start=-pi/2),
    Jr=imcData.Jr,
    Js=imcData.Js,
    frictionParameters=imcData.frictionParameters,
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    TrRef=imcData.TrRef,
    m=m,
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    TsOperational=293.15,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    alpha20r=imcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorQS(m=m)
    annotation (Placement(transformation(origin={-40,80}, extent={{-10,10},{10,
            -10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource sineVoltageQS(
    final m=m,
    f=fNominal,
    V=fill(VNominal, m))
                annotation (Placement(transformation(
        origin={-70,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(final m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-70,40})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS annotation (Placement(transformation(origin={-70,10}, extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=JLoad) annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepQS(
    useSupport=false,
    startTime=tStart,
    stepTorque=-TLoad,
    offsetTorque=0)
    annotation (Placement(transformation(extent={{60,40},{40,60}})));
  Utilities.MultiTerminalBox
                        terminalBoxQS(m=m, terminalConnection="Y")
                                                              annotation (Placement(transformation(extent={{-20,56},{0,76}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData
    imcData "Induction machine data"
    annotation (Placement(transformation(extent={{70,72},{90,92}})));

  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imc(
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    Jr=imcData.Jr,
    Js=imcData.Js,
    frictionParameters=imcData.frictionParameters,
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    TrRef=imcData.TrRef,
    phiMechanical(fixed=true),
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lszero=imcData.Lszero*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    m=m,
    TsOperational=293.15,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    alpha20r=imcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));

  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(m=m)
    annotation (Placement(transformation(origin={-40,-20}, extent={{-10,10},{10,
            -10}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2)*VNominal, m))   annotation (Placement(transformation(
        origin={-70,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-70,-60})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-70,-90},
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
    useSupport=false,
    startTime=tStart,
    stepTorque=-TLoad,
    offsetTorque=0) annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBox(m=m,
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{-20,-44},{0,-24}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starMachineQS(final m=Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,38})));
  Modelica.Electrical.Polyphase.Basic.Star starMachine(final m=Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,-62})));
initial equation
  imc.wMechanical = wSync;
  sum(imc.is) = 0;
  der(imc.airGap.V_msr.re) = 0;
  der(imc.airGap.V_msr.im) = 0;
  der(imc.airGap.V_mrr.re) = 0;
  der(imc.airGap.V_mrr.im) = 0;
equation
  connect(starQS.pin_n, groundQS.pin) annotation (Line(points={{-70,30},{-70,20}}, color={85,170,255}));
  connect(sineVoltageQS.plug_n, starQS.plug_p) annotation (Line(points={{-70,60},{-70,50}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sn, imcQS.plug_sn) annotation (Line(points={{-16,60},{-16,60}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sp, imcQS.plug_sp) annotation (Line(points={{-4,60},{-4,60}}, color={85,170,255}));
  connect(terminalBoxQS.plugSupply, currentQuasiRMSSensorQS.plug_n) annotation (Line(points={{-10,62},{-10,80},{-30,80}}, color={85,170,255}));
  connect(loadInertiaQS.flange_b, torqueStepQS.flange) annotation (Line(points={{30,50},{40,50}}));
  connect(imcQS.flange, loadInertiaQS.flange_a) annotation (Line(points={{0,50},{10,50}}));
  connect(sineVoltageQS.plug_p, currentQuasiRMSSensorQS.plug_p) annotation (Line(points={{-70,80},{-50,80}}, color={85,170,255}));
  connect(star.pin_n,ground. p) annotation (Line(points={{-70,-70},{-70,-80}},
                      color={0,0,255}));
  connect(sineVoltage.plug_n,star. plug_p)
    annotation (Line(points={{-70,-40},{-70,-50}},
                                                 color={0,0,255}));
  connect(terminalBox.plug_sn, imc.plug_sn) annotation (Line(points={{-16,-40},{-16,-40}}, color={0,0,255}));
  connect(terminalBox.plug_sp, imc.plug_sp) annotation (Line(points={{-4,-40},{-4,-40}}, color={0,0,255}));
  connect(terminalBox.plugSupply,currentQuasiRMSSensor. plug_n)
    annotation (Line(
      points={{-10,-38},{-10,-20},{-30,-20}},
                                    color={0,0,255}));
  connect(loadInertia.flange_b,torqueStep. flange) annotation (Line(
      points={{30,-50},{40,-50}}));
  connect(imc.flange, loadInertia.flange_a) annotation (Line(points={{0,-50},{10,-50}}));
  connect(sineVoltage.plug_p,currentQuasiRMSSensor. plug_p) annotation (
      Line(
      points={{-70,-20},{-50,-20}},        color={0,0,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (Line(points={{-40,48},{-40,62},{-20,62}}, color={85,170,255}));
  connect(terminalBox.starpoint, starMachine.plug_p) annotation (Line(points={{-20,-38},{-40,-38},{-40,-52}}, color={0,0,255}));
  connect(starMachine.pin_n, ground.p) annotation (Line(points={{-40,-72},{-40,-80},{-70,-80}}, color={0,0,255}));
  connect(starMachineQS.pin_n, groundQS.pin) annotation (Line(points={{-40,28},{-40,20},{-70,20}}, color={85,170,255}));
  annotation (experiment(StopTime=1.5, Interval=0.00001, Tolerance=1e-06), Documentation(
        info="<html>
<strong>Test example: Steady-State Initialization of an induction machine with squirrel cage</strong><br>
The induction machine with squirrel cage is initialized in steady-state at no-load;
at time tStart a load torque step is applied.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li><code>currentQuasiRMSSensor|currentQuasiRMSSensorQS.I</code>: (equivalent) RMS stator current</li>
<li><code>imc|imcQS.wMechanical</code>: machine speed</li>
<li><code>imc|imcQS.tauElectrical</code>: machine torque</li>
</ul>
Default machine parameters of model <em>IM_SquirrelCage</em> are used.
</html>"),
    Diagram(graphics={
        Text(
          extent={{20,8},{100,0}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),
                                            Text(
                  extent={{20,-92},{100,-100}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase transient")}));
end IMC_Initialize;
