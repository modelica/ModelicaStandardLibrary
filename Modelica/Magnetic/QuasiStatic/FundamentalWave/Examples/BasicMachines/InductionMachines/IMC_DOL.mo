within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_DOL
  "Induction machine with squirrel cage started directly on line (DOL)"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=imc.fsNominal "Nominal frequency";
  parameter SI.Time tOn=0.1 "Start time of machine";
  parameter SI.Torque T_Load=161.4 "Nominal load torque";
  parameter SI.AngularVelocity w_Load(displayUnit="rev/min")=
       1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter SI.Inertia J_Load=0.5 "Load inertia";
  parameter Integer p=2 "Number of pole pairs";
  output SI.Current Itr=currentQuasiRMSSensor.I
    "Transient RMS current";
  output SI.Current Iqs=currentQuasiRMSSensorQS.I
    "QS RMS current";
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource
    voltageSourceQS(
    m=m,
    f=fNominal,
    V=fill(VsNominal, m),
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m)) annotation (Placement(transformation(
        origin={-60,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={-70,20},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,20})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor
    powerSensorQS(m=m) annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorQS(m=m)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Ideal.IdealClosingSwitch
    idealCloserQS(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*3/m, m)) annotation (Placement(transformation(
        origin={-60,70},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStepQS[m](each startTime=
        tOn, each startValue=false) annotation (Placement(
        transformation(extent={{-100,60},{-80,80}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
     Placement(transformation(extent={{-60,-90},{-80,-70}})));
  Modelica.Electrical.Polyphase.Sources.CosineVoltage cosineVoltage(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2.0)*VsNominal, m)) annotation (Placement(
        transformation(
        origin={-60,-60},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*3/m, m)) annotation (Placement(transformation(
        origin={-60,-30},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tOn,
      each startValue=false) annotation (Placement(transformation(
          extent={{-100,-40},{-80,-20}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(final m=m)
    annotation (Placement(transformation(origin={0,-20},   extent={{-10,-10},{10,
            10}})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBox(m=m,
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{20,-54},{40,-34}})));
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imc(
    Jr=imcData.Jr,
    Js=imcData.Js,
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    frictionParameters=imcData.frictionParameters,
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    alpha20r(displayUnit="1/K") = imcData.alpha20r,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lszero=imcData.Lszero*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    TrRef=imcData.TrRef,
    m=m,
    TsOperational=293.15,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=J_Load)
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false) annotation (Placement(transformation(extent={{100,-70},{80,-50}})));
  Modelica.Electrical.Polyphase.Sensors.PowerSensor powerSensor(final
      m=m) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=
        J_Load) annotation (Placement(transformation(extent={{50,30},{70,50}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueQS(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false) annotation (Placement(transformation(extent={{100,30},{80,50}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData
    imcData "Induction machine data"
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
  FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imcQS(
    Jr=imcData.Jr,
    Js=imcData.Js,
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    frictionParameters=imcData.frictionParameters,
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    alpha20r(displayUnit="1/K") = imcData.alpha20r,
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    TrRef=imcData.TrRef,
    m=m,
    wMechanical(fixed=true),
    gammar(fixed=true, start=pi/2),
    gamma(fixed=true, start=-pi/2),
    TsOperational=293.15,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    TrOperational=293.15) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    groundMachineQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-10,10})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
                                                                    m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-10,30})));
  Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y")
    annotation (Placement(transformation(extent={{20,46},{40,66}})));
  Modelica.Electrical.Polyphase.Basic.Star starMachine(final m=Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
                                                                                                                           m)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-12,-70})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (Placement(transformation(
        origin={-12,-90},
        extent={{-10,-10},{10,10}})));
initial equation
  sum(imc.is) = 0;
  imc.is[1:2] = zeros(2);
  imc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);

equation
  connect(groundQS.pin, starQS.pin_n)
    annotation (Line(points={{-80,20},{-80,20}}, color={85,170,255}));
  connect(starQS.plug_p, voltageSourceQS.plug_n)
    annotation (Line(points={{-60,20},{-60,30}}, color={85,170,255}));
  connect(powerSensorQS.currentN, currentQuasiRMSSensorQS.plug_p)
    annotation (Line(points={{-20,80},{-10,80}}, color={85,170,255}));
  connect(powerSensorQS.voltageP, powerSensorQS.currentP) annotation (
      Line(points={{-30,90},{-40,90},{-40,80}}, color={85,170,255}));
  connect(powerSensorQS.voltageN, starQS.plug_p) annotation (Line(
        points={{-30,70},{-30,20},{-60,20}}, color={85,170,255}));
  connect(booleanStepQS.y, idealCloserQS.control) annotation (Line(
      points={{-79,70},{-72,70}}, color={255,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-80,-80},{-80,-80}}, color={0,0,255}));
  connect(cosineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{-60,-70},{-60,-80}}, color={0,0,255}));
  connect(imc.flange, loadInertia.flange_a) annotation (Line(points={{40,-60},{50,-60}}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange)
    annotation (Line(points={{70,-60},{80,-60}}));
  connect(terminalBox.plug_sn, imc.plug_sn) annotation (Line(points={{24,-50},{24,-50}}, color={0,0,255}));
  connect(terminalBox.plug_sp, imc.plug_sp) annotation (Line(points={{36,-50},{36,-50}}, color={0,0,255}));
  connect(booleanStep.y, idealCloser.control) annotation (Line(
      points={{-79,-30},{-72,-30}}, color={255,0,255}));
  connect(idealCloser.plug_p, cosineVoltage.plug_p) annotation (Line(
      points={{-60,-40},{-60,-50}},
      color={0,0,255}));
  connect(idealCloserQS.plug_p, voltageSourceQS.plug_p) annotation (
      Line(
      points={{-60,60},{-60,50}},
      color={85,170,255}));
  connect(idealCloserQS.plug_n, powerSensorQS.currentP) annotation (
      Line(
      points={{-60,80},{-40,80}},
      color={85,170,255}));
  connect(idealCloser.plug_n, powerSensor.pc) annotation (Line(
      points={{-60,-20},{-40,-20}},
      color={0,0,255}));
  connect(powerSensor.nc, currentQuasiRMSSensor.plug_p)
    annotation (Line(points={{-20,-20},{-10,-20}}, color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, terminalBox.plugSupply) annotation (Line(points={{10,-20},{30,-20},{30,-48}}, color={0,0,255}));
  connect(loadInertiaQS.flange_b, quadraticLoadTorqueQS.flange)
    annotation (Line(points={{70,40},{80,40}}));
  connect(powerSensor.pv, powerSensor.pc) annotation (Line(
      points={{-30,-10},{-40,-10},{-40,-20}},
      color={0,0,255}));
  connect(powerSensor.nv, star.plug_p) annotation (Line(
      points={{-30,-30},{-30,-80},{-60,-80}},
      color={0,0,255}));
  connect(imcQS.flange, loadInertiaQS.flange_a) annotation (Line(
      points={{40,40},{50,40}}));
  connect(terminalBoxQS.plug_sn, imcQS.plug_sn) annotation (Line(
      points={{24,50},{24,50}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, imcQS.plug_sp) annotation (Line(
      points={{36,50},{36,50}},
      color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,40},{-10,52},{20,52}},
      color={85,170,255}));
  connect(currentQuasiRMSSensorQS.plug_n, terminalBoxQS.plugSupply)
    annotation (Line(points={{10,80},{30,80},{30,52}},  color={85,170,255}));
  connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
      points={{-10,20},{-10,20}},
      color={85,170,255}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (Line(points={{-12,-60},{-12,-48},{20,-48}}, color={0,0,255}));
  connect(groundMachine.p, starMachine.pin_n) annotation (Line(points={{-12,-80},{-12,-80}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
                                            Text(
                  extent={{20,-92},{100,-100}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
                  textString="%m phase transient"),     Text(
          extent={{20,8},{100,0}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static")}),
        experiment(StopTime=1, Interval=0.0001, Tolerance=1E-6),
    Documentation(info="<html>
<p>
This example compares a time transient and a quasi-static model of a polyphase induction machine.
At start time <code>tOn</code> a transient and a quasi-static polyphase voltage source are
connected to an induction machine. The machine starts from standstill, accelerating inertias
against load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<p>
Simulate for 1 second and plot (versus time):
</p>

<ul>
<li><code>currentQuasiRMSSensor|currentQuasiRMSSensorQS.I</code>: (equivalent) RMS stator current</li>
<li><code>imc|imcQS.wMechanical</code>: machine speed</li>
<li><code>imc|imcQS.tauElectrical</code>: machine torque</li>
</ul>
</html>"));
end IMC_DOL;
