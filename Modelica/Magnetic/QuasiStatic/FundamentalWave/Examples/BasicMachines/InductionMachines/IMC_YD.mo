within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_YD "Induction machine with squirrel cage starting Y-D"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=imc.fsNominal "Nominal frequency";
  parameter SI.Time tStart1=0.1 "Start time";
  parameter SI.Time tStart2=2.0 "Start time from Y to D";
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
    Jr=imcData.Jr,
    Js=imcData.Js,
    frictionParameters=imcData.frictionParameters,
    wMechanical(fixed=true),
    gammar(fixed=true, start=pi/2),
    gamma(fixed=true, start=-pi/2),
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    Lrsigma=imcData.Lrsigma,
    TrRef=imcData.TrRef,
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lm=imcData.Lm*m/3,
    Rr=imcData.Rr*m/3,
    m=m,
    TsOperational=293.15,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    alpha20r=imcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorQS(m=m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,70})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource sineVoltageQS(
    final m=m,
    f=fNominal,
    V=fill(VNominal/sqrt(3), m)) annotation (Placement(transformation(
        origin={-30,90},
        extent={{10,10},{-10,-10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(final m=m) annotation (Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS annotation (Placement(transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStepQS[m](each startTime=tStart1) annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Ideal.IdealClosingSwitch idealCloserQS(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={0,90},
        extent={{-10,10},{10,-10}})));
  Magnetic.QuasiStatic.FundamentalWave.Utilities.SwitchYD switchYDQS(final m=m)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Sources.BooleanStep booleanStepYDQS[m](each startTime=tStart2) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=JLoad) annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque quadraticLoadTorqueQS(
    w_nominal=wLoad,
    TorqueDirection=false,
    tau_nominal=-TLoad,
    useSupport=false) annotation (Placement(transformation(extent={{100,10},{80,30}})));
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
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
                                                    currentQuasiRMSSensor annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270,
        origin={30,-30})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={-30,-10},
        extent={{10,10},{-10,-10}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,-20},{-70,0}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=
        tStart1) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={0,-10},
        extent={{-10,10},{10,-10}})));
  Modelica.Electrical.Machines.Utilities.SwitchYD
                                         switchYD(m=m) annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Blocks.Sources.BooleanStep booleanStepYD[m](each startTime=
        tStart2) annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque(
    w_nominal=wLoad,
    TorqueDirection=false,
    tau_nominal=-TLoad,
    useSupport=false) annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
initial equation
  sum(imc.is) = 0;
  imc.is[1:2] = zeros(2);
  imc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
equation
  connect(starQS.pin_n, groundQS.pin) annotation (Line(points={{-70,90},{-80,90}}, color={85,170,255}));
  connect(sineVoltageQS.plug_n, starQS.plug_p) annotation (Line(points={{-40,90},{-50,90}}, color={85,170,255}));
  connect(sineVoltageQS.plug_p, idealCloserQS.plug_p) annotation (Line(points={{-20,90},{-10,90}}, color={85,170,255}));
  connect(loadInertiaQS.flange_b, quadraticLoadTorqueQS.flange) annotation (Line(points={{70,20},{80,20}}));
  connect(booleanStepQS.y, idealCloserQS.control) annotation (Line(points={{-59,60},{0,60},{0,78}}, color={255,0,255}));
  connect(booleanStepYDQS.y, switchYDQS.control) annotation (Line(points={{-19,40},{18,40}}, color={255,0,255}));
  connect(idealCloserQS.plug_n, currentQuasiRMSSensorQS.plug_p) annotation (Line(points={{10,90},{10,90},{28,90},{28,90},{30,90},{30,80},{30,80}}, color={85,170,255}));
  connect(switchYDQS.plug_sn, imcQS.plug_sn) annotation (Line(points={{24,30},{24,30}}, color={85,170,255}));
  connect(switchYDQS.plug_sp, imcQS.plug_sp) annotation (Line(points={{36,30},{36,30}}, color={85,170,255}));
  connect(switchYDQS.plugSupply, currentQuasiRMSSensorQS.plug_n) annotation (Line(points={{30,50},{30,60}}, color={85,170,255}));
  connect(imcQS.flange, loadInertiaQS.flange_a) annotation (Line(points={{40,20},{50,20}}));
  connect(star.pin_n,ground. p)
    annotation (Line(points={{-70,-10},{-80,-10}},
                                                 color={0,0,255}));
  connect(sineVoltage.plug_n,star. plug_p)
    annotation (Line(points={{-40,-10},{-50,-10}},    color={0,0,255}));
  connect(sineVoltage.plug_p,idealCloser. plug_p) annotation (Line(points={{-20,-10},{-10,-10}},
                                        color={0,0,255}));
  connect(loadInertia.flange_b,quadraticLoadTorque. flange)
    annotation (Line(points={{70,-80},{80,-80}}));
  connect(booleanStep.y,idealCloser. control) annotation (Line(points={{-59,-40},{0,-40},{0,-22}},
                                          color={255,0,255}));
  connect(booleanStepYD.y,switchYD. control)
    annotation (Line(points={{-19,-60},{18,-60}},  color={255,0,255}));
  connect(idealCloser.plug_n,currentQuasiRMSSensor. plug_p)
    annotation (Line(points={{10,-10},{30,-10},{30,-20}},
                                                    color={0,0,255}));
  connect(switchYD.plug_sn, imc.plug_sn) annotation (Line(points={{24,-70},{24,-70}}, color={0,0,255}));
  connect(switchYD.plug_sp, imc.plug_sp) annotation (Line(points={{36,-70},{36,-70}}, color={0,0,255}));
  connect(switchYD.plugSupply,currentQuasiRMSSensor. plug_n) annotation (
      Line(
      points={{30,-50},{30,-40}}, color={0,0,255}));
  connect(imc.flange, loadInertia.flange_a) annotation (Line(points={{40,-80},{50,-80}}));
  annotation (experiment(StopTime=2.5,Interval=0.0001,Tolerance=1e-06),
    Documentation(
        info="<html>
<p>
At start time tStart three-phase voltage is supplied to the induction machine with squirrel cage, first star-connected, then delta-connected; the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<p>Simulate for 2.5 seconds and plot (versus time):</p>

<ul>
<li><code>currentQuasiRMSSensor|currentQuasiRMSSensorQS.I</code>: (equivalent) stator current RMS</li>
<li><code>imc|imcQS.wMechanical</code>: machine speed</li>
<li><code>imc|imcQS.tauElectrical</code>: machine torque</li>
</ul>
<p>
Default machine parameters are used.</p>
</html>"),
    Diagram(graphics={
        Text(
          extent={{-60,20},{20,12}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"), Text(
                  extent={{-60,-80},{20,-88}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
                  textString="%m phase transient")}));
end IMC_YD;
