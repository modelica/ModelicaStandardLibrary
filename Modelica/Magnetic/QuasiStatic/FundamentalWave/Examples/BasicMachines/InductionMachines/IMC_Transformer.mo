within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Transformer "Induction machine with squirrel cage starting with transformer"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=imc.fsNominal "Nominal frequency";
  parameter SI.Time tStart1=0.1 "Start time";
  parameter SI.Time tStart2=2.0
    "Start time of bypass transformer";
  parameter SI.Torque TLoad=161.4 "Nominal load torque";
  parameter SI.AngularVelocity wLoad(displayUnit="rev/min")=
       1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage
    imcQS(
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    Rs=imcData.Rs,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    Lssigma=imcData.Lssigma,
    Jr=imcData.Jr,
    Js=imcData.Js,
    frictionParameters=imcData.frictionParameters,
    wMechanical(fixed=true),
    gammar(fixed=true, start=pi/2),
    gamma(fixed=true, start=-pi/2),
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    Lm=imcData.Lm,
    Lrsigma=imcData.Lrsigma,
    Rr=imcData.Rr,
    TrRef=imcData.TrRef,
    TsOperational=293.15,
    alpha20r=imcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor iSensorQS(m=m) annotation (Placement(transformation(
        origin={-40,80},
        extent={{-10,10},{10,-10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource sineVoltageQS(
    final m=m,
    f=fNominal,
    V=fill(VNominal/sqrt(3), m)) annotation (Placement(transformation(origin={-70,80}, extent={{10,10},{-10,-10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(final m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,50})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS annotation (Placement(transformation(
        origin={-80,20},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep1QS[m](each startTime=tStart1) annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Ideal.IdealClosingSwitch idealCloserQS(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={-10,80},
        extent={{-10,10},{10,-10}})));
  Modelica.Electrical.QuasiStatic.Machines.BasicMachines.Transformers.Yy.Yy00 transformerQS(
    n=transformerData.n,
    R1=transformerData.R1,
    L1sigma=transformerData.L1sigma,
    R2=transformerData.R2,
    L2sigma=transformerData.L2sigma,
    alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T1Ref=293.15,
    T2Ref=293.15,
    T1Operational=293.15,
    T2Operational=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={20,80})));

  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground ground2QS annotation (Placement(transformation(
        origin={20,50},
        extent={{-10,-10},{10,10}})));
  parameter Modelica.Electrical.Machines.Utilities.TransformerData transformerData(
    f=fNominal,
    V1=VNominal,
    C1=Modelica.Utilities.Strings.substring(
        transformerQS.VectorGroup,
        1,
        1),
    V2=VNominal/sqrt(3),
    C2=Modelica.Utilities.Strings.substring(
        transformerQS.VectorGroup,
        2,
        2),
    SNominal=50E3,
    v_sc=0.06,
    P_sc=500) "Transformer data" annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep2QS[m](each startTime=tStart2) annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Ideal.IdealCommutingSwitch idealCommutingSwitchQS(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(50E-5, m)) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        origin={50,80})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=JLoad) annotation (Placement(transformation(extent={{50,10},{30,30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque quadraticLoadTorqueQS(
    w_nominal=wLoad,
    TorqueDirection=false,
    tau_nominal=-TLoad,
    useSupport=false) annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Magnetic.QuasiStatic.FundamentalWave.Utilities.TerminalBox terminalBoxQS(
      terminalConnection="D", m=m)
    annotation (Placement(transformation(extent={{80,26},{60,46}})));
  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData imcData "Induction machine data" annotation (Placement(transformation(extent={{80,52},{100,72}})));
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imc(
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    Jr=imcData.Jr,
    Js=imcData.Js,
    frictionParameters=imcData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    TrRef=imcData.TrRef,
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
    annotation (Placement(transformation(extent={{80,-90},{60,-70}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor iSensor(m=m) annotation (Placement(transformation(
        origin={-40,-20},
        extent={{-10,10},{10,-10}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={-70,-20},
        extent={{10,10},{-10,-10}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,-50})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-80,-80},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep1[m](each startTime=
        tStart1) annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={-10,-20},
        extent={{-10,10},{10,-10}})));
  Modelica.Electrical.Machines.BasicMachines.Transformers.Yy.Yy00 transformer(
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
        origin={20,-20})));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(
        transformation(
        origin={20,-50},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep2[m](each startTime=
        tStart2) annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Modelica.Electrical.Polyphase.Ideal.IdealCommutingSwitch
    idealCommutingSwitch(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(50E-5, m)) annotation (Placement(transformation(
        extent={{60,-10},{40,-30}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{50,-90},{30,-70}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque(
    w_nominal=wLoad,
    TorqueDirection=false,
    tau_nominal=-TLoad,
    useSupport=false) annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="D") annotation (Placement(transformation(extent={{80,-74},{60,-54}})));
initial equation
  sum(imc.is) = 0;
  imc.is[1:2] = zeros(2);
  imc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
  transformer.i2[1:2] = zeros(2);
equation
  connect(starQS.pin_n, groundQS.pin) annotation (Line(points={{-80,40},{-80,30}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sn, imcQS.plug_sn) annotation (Line(points={{76,30},{76,30}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sp, imcQS.plug_sp) annotation (Line(points={{64,30},{64,30}}, color={85,170,255}));
  connect(loadInertiaQS.flange_b, quadraticLoadTorqueQS.flange) annotation (Line(points={{30,20},{20,20}}));
  connect(imcQS.flange, loadInertiaQS.flange_a) annotation (Line(points={{60,20},{50,20}}));
  connect(starQS.plug_p, sineVoltageQS.plug_n) annotation (Line(points={{-80,60},{-80,80}}, color={85,170,255}));
  connect(booleanStep2QS.y, idealCommutingSwitchQS.control) annotation (Line(points={{-39,20},{-10,20},{-10,40},{50,40},{50,68}}, color={255,0,255}));
  connect(transformerQS.starpoint2, ground2QS.pin) annotation (Line(points={{25,70},{24,70},{24,60},{20,60}}, color={85,170,255}));
  connect(idealCommutingSwitchQS.plug_p, terminalBoxQS.plugSupply) annotation (Line(points={{60,80},{70,80},{70,32}}, color={85,170,255}));
  connect(transformerQS.plug2, idealCommutingSwitchQS.plug_n1) annotation (Line(points={{30,80},{36,80},{36,76},{40,76}}, color={85,170,255}));
  connect(sineVoltageQS.plug_p, iSensorQS.plug_p) annotation (Line(points={{-60,80},{-50,80}}, color={85,170,255}));
  connect(booleanStep1QS.y, idealCloserQS.control) annotation (Line(points={{-39,50},{-10,50},{-10,68}}, color={255,0,255}));
  connect(iSensorQS.plug_n, idealCloserQS.plug_p) annotation (Line(points={{-30,80},{-20,80}}, color={85,170,255}));
  connect(transformerQS.plug1, idealCloserQS.plug_n) annotation (Line(points={{10,80},{0,80}}, color={85,170,255}));
  connect(idealCloserQS.plug_n, idealCommutingSwitchQS.plug_n2) annotation (Line(points={{0,80},{0,100},{40,100},{40,80}}, color={85,170,255}));
  connect(star.pin_n,ground. p)
    annotation (Line(points={{-80,-60},{-80,-70}},
                                                 color={0,0,255}));
  connect(terminalBox.plug_sp, imc.plug_sp) annotation (Line(points={{64,-70},{64,-70}}, color={0,0,255}));
  connect(loadInertia.flange_b,quadraticLoadTorque. flange) annotation (
      Line(
      points={{30,-80},{20,-80}}));
  connect(imc.flange, loadInertia.flange_a) annotation (Line(points={{60,-80},{50,-80}}));
  connect(star.plug_p,sineVoltage. plug_n) annotation (Line(
      points={{-80,-40},{-80,-20}},
                                  color={0,0,255}));
  connect(booleanStep2.y,idealCommutingSwitch. control) annotation (Line(
      points={{-39,-80},{-10,-80},{-10,-60},{50,-60},{50,-32}},
                               color={255,0,255}));
  connect(transformer.starpoint2,ground2. p) annotation (Line(
      points={{25,-30},{25,-40},{20,-40}}, color={0,0,255}));
  connect(idealCommutingSwitch.plug_p, terminalBox.plugSupply) annotation (Line(points={{60,-20},{70,-20},{70,-68}}, color={0,0,255}));
  connect(transformer.plug2,idealCommutingSwitch. plug_n1) annotation (Line(points={{30,-20},{36,-20},{36,-24},{40,-24}}, color={0,0,255}));
  connect(sineVoltage.plug_p, iSensor.plug_p) annotation (Line(points={{-60,-20},{-50,-20}}, color={0,0,255}));
  connect(booleanStep1.y,idealCloser. control) annotation (Line(
      points={{-39,-50},{-10,-50},{-10,-32},{-10,-32}},
                                 color={255,0,255}));
  connect(iSensor.plug_n, idealCloser.plug_p) annotation (Line(points={{-30,-20},{-20,-20}}, color={0,0,255}));
  connect(transformer.plug1,idealCloser. plug_n) annotation (Line(
      points={{10,-20},{0,-20}},color={0,0,255}));
  connect(idealCloser.plug_n,idealCommutingSwitch. plug_n2) annotation (
      Line(
      points={{0,-20},{0,0},{40,0},{40,-20}},
                              color={0,0,255}));
  connect(terminalBox.plug_sn, imc.plug_sn) annotation (Line(points={{76,-70},{76,-70}}, color={0,0,255}));
  annotation (experiment(StopTime=2.5, Interval=0.0001, Tolerance=1e-06), Documentation(
        info="<html>
<p>At start time tStart1 three-phase voltage is supplied to the induction machine with squirrel cage via the transformer;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed;
at start time tStart2 the machine is fed directly from the voltage source, finally reaching nominal speed.</p>
<p>
Simulate for 2.5 seconds and plot (versus time):</p>

<ul>
<li><code>currentQuasiRMSSensor|currentQuasiRMSSensorQS.I</code>: (equivalent) stator current RMS</li>
<li><code>imc|imcQS.wMechanical</code>: machine speed</li>
<li><code>imc|imcQS.tauElectrical</code>: machine torque</li>
</ul>
<p>Default machine parameters are used.</p>
</html>"),
    Diagram(graphics={
        Text(
          extent={{80,8},{160,0}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),
                                            Text(
                  extent={{80,-92},{160,-100}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase transient")}));
end IMC_Transformer;
