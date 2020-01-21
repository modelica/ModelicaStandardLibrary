within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMS_Start "Starting of induction machine with slip rings"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of stator phases" annotation(Evaluate=true);
  parameter Integer mr=3 "Number of rotor phases" annotation(Evaluate=true);
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=ims.fsNominal "Nominal frequency";
  parameter SI.Time tOn=0.1 "Start time of machine";
  parameter SI.Resistance RStart=0.16/imsData.turnsRatio^
      2 "Starting resistance";
  parameter SI.Time tRheostat=1.0
    "Time of shortening the rheostat";
  parameter SI.Torque T_Load=161.4 "Nominal load torque";
  parameter SI.AngularVelocity w_Load(displayUnit="rev/min")=
       Modelica.Units.Conversions.from_rpm(1440.45)
    "Nominal load speed";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
  output SI.Current Itr=currentQuasiRMSSensor.I
    "Transient RMS current";
  output SI.Current Iqs=currentQuasiRMSSensorQS.I
    "QS RMS current";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        origin={-70,-80})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2.0)*VsNominal, m)) annotation (Placement(
        transformation(
        origin={-60,-60},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*3/m, m)) annotation (Placement(transformation(
        origin={-60,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tOn)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(m=m)
    annotation (Placement(transformation(origin={0,-20},   extent={{-10,-10},{10,
            10}})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBoxM(m=m,
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{20,-54},{40,-34}})));
  Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y")
    annotation (Placement(transformation(extent={{20,46},{40,66}})));
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing ims(
    Jr=imsData.Jr,
    Js=imsData.Js,
    p=imsData.p,
    fsNominal=imsData.fsNominal,
    TsRef=imsData.TsRef,
    alpha20s(displayUnit="1/K") = imsData.alpha20s,
    frictionParameters=imsData.frictionParameters,
    statorCoreParameters=imsData.statorCoreParameters,
    strayLoadParameters=imsData.strayLoadParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    TrRef=imsData.TrRef,
    alpha20r(displayUnit="1/K") = imsData.alpha20r,
    useTurnsRatio=imsData.useTurnsRatio,
    VsNominal=imsData.VsNominal,
    VrLockedRotor=imsData.VrLockedRotor,
    rotorCoreParameters=imsData.rotorCoreParameters,
    TurnsRatio=imsData.turnsRatio,
    Rs=imsData.Rs*m/3,
    Lssigma=imsData.Lssigma*m/3,
    Lszero=imsData.Lszero*m/3,
    Lm=imsData.Lm*m/3,
    Lrsigma=imsData.Lrsigma*mr/3,
    Lrzero=imsData.Lrzero*mr/3,
    Rr=imsData.Rr*mr/3,
    mr=mr,
    m=m,
    TsOperational=293.15,
    effectiveStatorTurns=imsData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing imsQS(
    p=imsData.p,
    fsNominal=imsData.fsNominal,
    TsRef=imsData.TsRef,
    alpha20s(displayUnit="1/K") = imsData.alpha20s,
    Jr=imsData.Jr,
    Js=imsData.Js,
    frictionParameters=imsData.frictionParameters,
    statorCoreParameters=imsData.statorCoreParameters,
    strayLoadParameters=imsData.strayLoadParameters,
    TrRef=imsData.TrRef,
    alpha20r(displayUnit="1/K") = imsData.alpha20r,
    useTurnsRatio=imsData.useTurnsRatio,
    VsNominal=imsData.VsNominal,
    VrLockedRotor=imsData.VrLockedRotor,
    rotorCoreParameters=imsData.rotorCoreParameters,
    Rs=imsData.Rs*m/3,
    Lssigma=imsData.Lssigma*m/3,
    Lm=imsData.Lm*m/3,
    gammar(fixed=true, start=pi/2),
    gamma(fixed=true, start=-pi/2),
    wMechanical(fixed=true),
    TurnsRatio=imsData.turnsRatio,
    Lrsigma=imsData.Lrsigma*mr/3,
    Rr=imsData.Rr*mr/3,
    mr=mr,
    m=m,
    TsOperational=566.3,
    effectiveStatorTurns=imsData.effectiveStatorTurns,
    TrOperational=566.3) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Electrical.Machines.Utilities.SwitchedRheostat rheostatM(
    tStart=tRheostat,
    m=mr,
    RStart=RStart*mr/3) annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  FundamentalWave.Utilities.SwitchedRheostat rheostatQS(
    tStart=tRheostat,
    RStart=RStart*mr/3,
    m=mr) annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=J_Load)
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=J_Load) annotation (Placement(transformation(extent={{50,30},{70,50}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque(
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false,
    w_nominal=w_Load) annotation (Placement(transformation(extent={{100,-70},{80,-50}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque quadraticLoadTorqueQS(
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false,
    w_nominal=w_Load) annotation (Placement(transformation(extent={{100,30},{80,50}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SlipRingData
    imsData "Induction machine data"
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource
    voltageSourceQS(
    m=m,
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m),
    f=fNominal,
    V=fill(VsNominal, m)) annotation (Placement(transformation(
        origin={-60,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={-70,20},
        extent={{-10,-10},{10,10}},
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
  Modelica.Electrical.Polyphase.Sensors.PowerSensor powerSensor(m=m)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
                                                                    m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-10,30})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    groundMachineQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-10,10})));
  Modelica.Electrical.Polyphase.Basic.Star starMachine(final m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-12,-70})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (Placement(
        transformation(origin={-12,-90}, extent={{-10,-10},{10,10}})));
initial equation
  sum(ims.is) = 0;
  ims.is[1:2] = zeros(2);
  sum(ims.ir) = 0;
  ims.ir[1:2] = zeros(2);

equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-80,-80},{-80,-80}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{-60,-70},{-60,-80}}, color={0,0,255}));
  connect(loadInertiaQS.flange_b, quadraticLoadTorqueQS.flange) annotation (Line(points={{70,40},{80,40}}));
  connect(imsQS.flange, loadInertiaQS.flange_a) annotation (Line(points={{40,40},{50,40}}));
  connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-79,-30},{-72,-30}},
                                          color={255,0,255}));
  connect(terminalBoxQS.plug_sn, imsQS.plug_sn)
    annotation (Line(points={{24,50},{24,50}}, color={0,0,255}));
  connect(terminalBoxQS.plug_sp, imsQS.plug_sp)
    annotation (Line(points={{36,50},{36,50}}, color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (
     Line(points={{70,-60},{80,-60}}));
  connect(ims.flange, loadInertia.flange_a) annotation (Line(points={{40,-60},{50,-60}}));
  connect(terminalBoxM.plug_sp, ims.plug_sp)
    annotation (Line(points={{36,-50},{36,-50}}, color={0,0,255}));
  connect(terminalBoxM.plug_sn, ims.plug_sn)
    annotation (Line(points={{24,-50},{24,-50}}, color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, terminalBoxM.plugSupply)
    annotation (Line(points={{10,-20},{30,-20},{30,-48}},  color={0,0,255}));
  connect(rheostatM.plug_p, ims.plug_rp) annotation (Line(
      points={{20,-54},{20,-54}},
      color={0,0,255}));
  connect(rheostatM.plug_n, ims.plug_rn) annotation (Line(
      points={{20,-66},{20,-66}},
      color={0,0,255}));
  connect(idealCloser.plug_p, sineVoltage.plug_p) annotation (Line(
      points={{-60,-40},{-60,-50}},
      color={0,0,255}));
  connect(imsQS.plug_rp, rheostatQS.plug_p) annotation (Line(points={{20,46},{20,46}}, color={85,170,255}));
  connect(rheostatQS.plug_n, imsQS.plug_rn) annotation (Line(points={{20,34},{20,34}}, color={85,170,255}));
  connect(groundQS.pin, starQS.pin_n)
    annotation (Line(points={{-80,20},{-80,20}}, color={85,170,255}));
  connect(starQS.plug_p, voltageSourceQS.plug_n)
    annotation (Line(points={{-60,20},{-60,30}}, color={85,170,255}));
  connect(powerSensorQS.currentN, currentQuasiRMSSensorQS.plug_p)
    annotation (Line(points={{-20,80},{-10,80}},          color={85,170,255}));
  connect(powerSensorQS.voltageP, powerSensorQS.currentP) annotation (
      Line(points={{-30,90},{-40,90},{-40,80}}, color={85,170,255}));
  connect(powerSensorQS.voltageN, starQS.plug_p) annotation (Line(
        points={{-30,70},{-30,20},{-60,20}}, color={85,170,255}));
  connect(booleanStepQS.y, idealCloserQS.control) annotation (Line(
      points={{-79,70},{-72,70}}, color={255,0,255}));
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
  connect(powerSensor.pc, powerSensor.pv) annotation (Line(
      points={{-40,-20},{-40,-10},{-30,-10}},
      color={0,0,255}));
  connect(powerSensor.nv, star.plug_p) annotation (Line(
      points={{-30,-30},{-30,-80},{-60,-80}},
      color={0,0,255}));
  connect(powerSensor.nc, currentQuasiRMSSensor.plug_p)
    annotation (Line(points={{-20,-20},{-10,-20}}, color={0,0,255}));
  connect(currentQuasiRMSSensorQS.plug_n, terminalBoxQS.plugSupply)
    annotation (Line(points={{10,80},{30,80},{30,52}},  color={85,170,255}));
  connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
      points={{-10,20},{-10,20}},
      color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,40},{-10,52},{20,52}},
      color={85,170,255}));
  connect(groundMachine.p,starMachine. pin_n) annotation (Line(points={{-12,-80},{-12,-80}}, color={0,0,255}));
  connect(terminalBoxM.starpoint, starMachine.plug_p) annotation (Line(points={{20,-48},{-12,-48},{-12,-60}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=1.5,
      Interval=0.0001,
      Tolerance=1e-06),
    Documentation(info="<html>

<p>
This example compares a time transient and a quasi-static model of a polyphase induction machine.
At start time <code>tOn</code> a transient and a quasi-static polyphase voltage source are connected to induction machine with sliprings. The machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
using a starting resistance. At time <code>tRheostat</code> external rotor resistance is shortened, finally reaching nominal speed.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensor.I|currentSensorQS.abs_i[1]</code>: (equivalent) RMS stator current</li>
<li><code>ims|imsQS.wMechanical</code>: machine speed</li>
<li><code>ims|imsQS.tauElectrical</code>: machine torque</li>
</ul>
<p>Default machine parameters are used.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={         Text(
                  extent={{20,8},{100,0}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),
        Text(
          extent={{20,-92},{100,-100}},
                  textStyle={TextStyle.Bold},
          textString="%m phase transient")}));
end IMS_Start;
