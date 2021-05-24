within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase;
model IMS_Start_Polyphase
  "Starting of polyphase induction machine with slip rings"

  extends Modelica.Icons.Example;
  constant Integer m3=3 "Number of stator phases of three-phase system";
  parameter Integer m=5 "Number of stator phases" annotation(Evaluate=true);
  parameter Integer mr=5 "Number of rotor phases" annotation(Evaluate=true);
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=aimsData.fsNominal "Nominal frequency";
  parameter SI.Time tOn=0.1 "Start time of machine";
  parameter SI.Resistance RStart=0.16/aimsData.turnsRatio^2
    "Starting resistance";
  parameter SI.Time tRheostat=1.0
    "Time of shortening the rheostat";
  parameter SI.Torque T_Load=161.4 "Nominal load torque";
  parameter SI.AngularVelocity w_Load(displayUnit="rev/min")=
       Modelica.Units.Conversions.from_rpm(1440.45)
    "Nominal load speed";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(m=m,
      terminalConnection="Y") annotation (Placement(transformation(extent={{20,46},
            {40,66}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
      terminalConnection="Y", m=m3) annotation (Placement(transformation(
          extent={{20,-54},{40,-34}})));
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing aimsM(
    Jr=aimsData.Jr,
    Js=aimsData.Js,
    p=aimsData.p,
    fsNominal=aimsData.fsNominal,
    TsRef=aimsData.TsRef,
    alpha20s(displayUnit="1/K") = aimsData.alpha20s,
    ratioCommonStatorLeakage=aimsData.ratioCommonStatorLeakage,
    frictionParameters=aimsData.frictionParameters,
    statorCoreParameters=aimsData.statorCoreParameters,
    strayLoadParameters=aimsData.strayLoadParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    ratioCommonRotorLeakage=aimsData.ratioCommonRotorLeakage,
    TrRef=aimsData.TrRef,
    alpha20r(displayUnit="1/K") = aimsData.alpha20r,
    useTurnsRatio=aimsData.useTurnsRatio,
    VsNominal=aimsData.VsNominal,
    VrLockedRotor=aimsData.VrLockedRotor,
    rotorCoreParameters=aimsData.rotorCoreParameters,
    TurnsRatio=aimsData.turnsRatio,
    mr=mr,
    m=m,
    Rs=aimsData.Rs*m/3,
    Lssigma=aimsData.Lssigma*m/3,
    Lszero=aimsData.Lszero*m/3,
    Lm=aimsData.Lm*m/3,
    Lrsigma=aimsData.Lrsigma*mr/3,
    Lrzero=aimsData.Lrzero*mr/3,
    Rr=aimsData.Rr*mr/3,
    TsOperational=293.15,
    effectiveStatorTurns=aimsData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing aims3(
    p=aimsData.p,
    fsNominal=aimsData.fsNominal,
    Rs=aimsData.Rs,
    TsRef=aimsData.TsRef,
    alpha20s(displayUnit="1/K") = aimsData.alpha20s,
    ratioCommonStatorLeakage=aimsData.ratioCommonStatorLeakage,
    Lszero=aimsData.Lszero,
    Lssigma=aimsData.Lssigma,
    Jr=aimsData.Jr,
    Js=aimsData.Js,
    frictionParameters=aimsData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=aimsData.statorCoreParameters,
    strayLoadParameters=aimsData.strayLoadParameters,
    Lm=aimsData.Lm,
    Lrsigma=aimsData.Lrsigma,
    ratioCommonRotorLeakage=aimsData.ratioCommonRotorLeakage,
    Lrzero=aimsData.Lrzero,
    Rr=aimsData.Rr,
    TrRef=aimsData.TrRef,
    alpha20r(displayUnit="1/K") = aimsData.alpha20r,
    useTurnsRatio=aimsData.useTurnsRatio,
    VsNominal=aimsData.VsNominal,
    VrLockedRotor=aimsData.VrLockedRotor,
    rotorCoreParameters=aimsData.rotorCoreParameters,
    m=m3,
    TurnsRatio=aimsData.turnsRatio,
    TsOperational=566.3,
    effectiveStatorTurns=aimsData.effectiveStatorTurns,
    TrOperational=566.3)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Electrical.Machines.Utilities.SwitchedRheostat rheostatM(
    tStart=tRheostat,
    m=mr,
    RStart=RStart*mr/m3)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Electrical.Machines.Utilities.SwitchedRheostat rheostat3(
    RStart=RStart,
    tStart=tRheostat,
    m=m3) annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
    annotation (Placement(transformation(extent={{50,30},{70,50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia3(J=J_Load)
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueM(
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false,
    w_nominal=w_Load) annotation (Placement(transformation(extent={{100,
            30},{80,50}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque3(
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false,
    w_nominal=w_Load) annotation (Placement(transformation(extent={{100,-70},
            {80,-50}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SlipRingData aimsData
    "Induction machine data"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
        transformation(origin={-90,50}, extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Polyphase.Basic.Star starM(final m=m)
    annotation (Placement(transformation(extent={{-70,62},{-90,82}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltageM(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2.0)*VsNominal, m),
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m))
    annotation (Placement(transformation(origin={-50,72}, extent={{10,-10},{-10,
            10}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloserM(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*m3/m, m)) annotation (Placement(transformation(origin={-20,
            72}, extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStepM[m](each startTime=tOn, each
      startValue=false) annotation (Placement(transformation(extent={{-10,-10},
            {10,10}}, origin={-40,40})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentRMSsensorM(m=m) annotation (Placement(transformation(
        origin={10,72},
        extent={{-10,10},{10,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground3 annotation (Placement(
        transformation(origin={-90,-52}, extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Polyphase.Basic.Star star3(final m=m3)
    annotation (Placement(transformation(extent={{-70,-40},{-90,-20}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage3(
    final m=m3,
    V=fill(sqrt(2.0)*VsNominal, m3),
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m3),
    f=fill(fNominal, m3)) annotation (Placement(transformation(origin={-50,-30},
          extent={{10,-10},{-10,10}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser3(
    final m=m3,
    Ron=fill(1e-5, m3),
    Goff=fill(1e-5, m3)) annotation (Placement(transformation(origin={-20,-30},
          extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep3[m3](each startTime=tOn,
      each startValue=false) annotation (Placement(transformation(extent={{-10,
            -10},{10,10}}, origin={-40,-60})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
    currentRMSsensor3(m=3) annotation (Placement(transformation(
        origin={10,-30},
        extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Math.Gain gain(k=(m/m3))
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{80,10},{100,-10}})));
initial equation
  aims3.is[1:2] = zeros(2);
  aims3.ir[1:3] = zeros(3);
  aimsM.is[1:2] = zeros(2);
  aimsM.ir[1:mr - 2] = zeros(mr - 2);
equation
  connect(loadInertia3.flange_b, quadraticLoadTorque3.flange) annotation (
     Line(points={{70,-60},{76,-60},{80,-60}}));
  connect(aims3.flange, loadInertia3.flange_a) annotation (Line(points={{
          40,-60},{40,-60},{50,-60}}));
  connect(terminalBox3.plug_sn, aims3.plug_sn)
    annotation (Line(points={{24,-50},{24,-50}}, color={0,0,255}));
  connect(terminalBox3.plug_sp, aims3.plug_sp)
    annotation (Line(points={{36,-50},{36,-50}}, color={0,0,255}));
  connect(rheostat3.plug_p, aims3.plug_rp) annotation (Line(points={{10,-54},
          {10,-54},{20,-54}}, color={0,0,255}));
  connect(rheostat3.plug_n, aims3.plug_rn) annotation (Line(points={{10,-66},
          {10,-66},{20,-66}}, color={0,0,255}));
  connect(loadInertiaM.flange_b, quadraticLoadTorqueM.flange)
    annotation (Line(points={{70,40},{70,40},{80,40}}));
  connect(aimsM.flange, loadInertiaM.flange_a)
    annotation (Line(points={{40,40},{40,40},{50,40}}));
  connect(terminalBoxM.plug_sp, aimsM.plug_sp)
    annotation (Line(points={{36,50},{36,50}}, color={0,0,255}));
  connect(terminalBoxM.plug_sn, aimsM.plug_sn)
    annotation (Line(points={{24,50},{24,50}}, color={0,0,255}));
  connect(rheostatM.plug_p, aimsM.plug_rp) annotation (Line(
      points={{10,46},{20,46}},
      color={0,0,255}));
  connect(rheostatM.plug_n, aimsM.plug_rn) annotation (Line(
      points={{10,34},{20,34}},
      color={0,0,255}));
  connect(starM.pin_n, groundM.p) annotation (Line(points={{-90,72},{-90,
          72},{-90,60}}, color={0,0,255}));
  connect(sineVoltageM.plug_n, starM.plug_p) annotation (Line(points={{-60,
          72},{-60,72},{-70,72}}, color={0,0,255}));
  connect(sineVoltageM.plug_p, idealCloserM.plug_p) annotation (Line(
      points={{-40,72},{-30,72}},
      color={0,0,255}));
  connect(idealCloserM.plug_n, currentRMSsensorM.plug_p) annotation (Line(
      points={{-10,72},{0,72}},
      color={0,0,255}));
  connect(booleanStepM.y, idealCloserM.control) annotation (Line(
      points={{-29,40},{-20,40},{-20,60}},
      color={255,0,255}));
  connect(star3.pin_n, ground3.p)
    annotation (Line(points={{-90,-30},{-90,-42}}, color={0,0,255}));
  connect(sineVoltage3.plug_n, star3.plug_p) annotation (Line(points={{-60,
          -30},{-60,-30},{-70,-30}}, color={0,0,255}));
  connect(sineVoltage3.plug_p, idealCloser3.plug_p) annotation (Line(
      points={{-40,-30},{-30,-30}},
      color={0,0,255}));
  connect(idealCloser3.plug_n, currentRMSsensor3.plug_p) annotation (Line(
      points={{-10,-30},{0,-30}},
      color={0,0,255}));
  connect(booleanStep3.y, idealCloser3.control) annotation (Line(
      points={{-29,-60},{-20,-60},{-20,-42}},
      color={255,0,255}));
  connect(currentRMSsensorM.I, gain.u) annotation (Line(
      points={{10,83},{10,90},{38,90}},
      color={0,0,127}));
  connect(currentRMSsensor3.plug_n, terminalBox3.plugSupply) annotation (
      Line(
      points={{20,-30},{30,-30},{30,-48}},
      color={0,0,255}));
  connect(currentRMSsensorM.plug_n, terminalBoxM.plugSupply) annotation (
      Line(
      points={{20,72},{30,72},{30,52}},
      color={0,0,255}));
  connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
      points={{10,-19},{10,0},{82,0}},
      color={0,0,127}));
  connect(feedback.u2, gain.y) annotation (Line(
      points={{90,8},{90,16},{100,16},{100,90},{61,90}},
      color={0,0,127}));
  annotation (
    experiment(
      StopTime=1.5,
      Interval=1E-4,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
At start time <code>tOn</code> voltages are supplied to the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing\">induction machines with sliprings</a>.
The two machine start from standstill, accelerating inertias against load torque quadratic dependent on speed,
using a starting resistance. At time tRheostat external rotor resistance is shortened, finally reaching nominal speed. Two equivalent machines with different numbers of phases are compared and their equal behavior is demonstrated.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: machine torque</li>
<li><code>aimsM|M3.wMechanical</code>: machine speed</li>
<li><code>feedback.y</code>: zero since difference of three-phase current phasor and scaled polyphase current phasor are equal</li>
</ul>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={       Text(
                extent={{40,68},{100,60}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textString="%m-phase machine",
                textStyle={TextStyle.Bold}),Text(
                extent={{40,-32},{100,-40}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textString="Three-phase machine",
                textStyle={TextStyle.Bold})}));
end IMS_Start_Polyphase;
