within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase;
model IMC_DOL_Polyphase
  "Direct on line start of polyphase induction machine with squirrel cage"
  extends Modelica.Icons.Example;
  constant Integer m3=3 "Number of stator phases of three-phase system";
  parameter Integer m=5 "Number of stator phases" annotation(Evaluate=true);
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
  parameter SI.Time tOn=0.1 "Start time of machine";
  parameter SI.Torque T_Load=161.4 "Nominal load torque";
  parameter SI.AngularVelocity w_Load(displayUnit="rev/min")=
       1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
  parameter Integer p=2 "Number of pole pairs";
  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
        transformation(
        origin={-90,50},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Polyphase.Basic.Star starM(final m=m) annotation (
      Placement(transformation(extent={{-70,62},{-90,82}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltageM(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2.0)*VsNominal, m),
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m)) annotation (Placement(transformation(
        origin={-50,72},
        extent={{10,-10},{-10,10}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloserM(
    final m=m,
    Ron=fill(1e-5*m/m3, m),
    Goff=fill(1e-5*m3/m, m)) annotation (Placement(transformation(origin={-20,
            72}, extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStepM[m](each startTime=tOn, each
      startValue=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,40})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSsensorM(m=m)
    annotation (Placement(transformation(origin={10,72}, extent={{-10,-10},{10,
            10}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(m=m,
      terminalConnection="Y") annotation (Placement(transformation(extent={{20,56},
            {40,76}})));
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage aimcM(
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    ratioCommonStatorLeakage=aimcData.ratioCommonStatorLeakage,
    frictionParameters=aimcData.frictionParameters,
    statorCoreParameters=aimcData.statorCoreParameters,
    strayLoadParameters=aimcData.strayLoadParameters,
    TrRef=aimcData.TrRef,
    alpha20r(displayUnit="1/K") = aimcData.alpha20r,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    m=m,
    Rs=aimcData.Rs*m/3,
    Lssigma=aimcData.Lssigma*m/3,
    Lszero=aimcData.Lszero*m/3,
    Lm=aimcData.Lm*m/3,
    Lrsigma=aimcData.Lrsigma*m/3,
    Rr=aimcData.Rr*m/3,
    TsOperational=293.15,
    effectiveStatorTurns=aimcData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
    annotation (Placement(transformation(extent={{50,40},{70,60}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueM(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false) annotation (Placement(transformation(extent={{100,
            40},{80,60}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData
    aimcData "Induction machine data"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Electrical.Analog.Basic.Ground ground3 annotation (Placement(
        transformation(
        origin={-90,-52},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Polyphase.Basic.Star star3(final m=m3) annotation (
     Placement(transformation(extent={{-70,-40},{-90,-20}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage3(
    final m=m3,
    V=fill(sqrt(2.0)*VsNominal, m3),
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m3),
    f=fill(fNominal, m3)) annotation (Placement(transformation(
        origin={-50,-30},
        extent={{10,-10},{-10,10}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser3(
    final m=m3,
    Ron=fill(1e-5, m3),
    Goff=fill(1e-5, m3)) annotation (Placement(transformation(origin={-20,-30},
          extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep3[m3](each startTime=tOn,
      each startValue=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-62})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSsensor3(m=3)
    annotation (Placement(transformation(origin={10,-30}, extent={{-10,10},{10,
            -10}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
      terminalConnection="Y", m=m3) annotation (Placement(transformation(
          extent={{20,-46},{40,-26}})));
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage aimc3(
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    Rs=aimcData.Rs,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    Lssigma=aimcData.Lssigma,
    ratioCommonStatorLeakage=aimcData.ratioCommonStatorLeakage,
    Lszero=aimcData.Lszero,
    frictionParameters=aimcData.frictionParameters,
    statorCoreParameters=aimcData.statorCoreParameters,
    strayLoadParameters=aimcData.strayLoadParameters,
    Lm=aimcData.Lm,
    Lrsigma=aimcData.Lrsigma,
    Rr=aimcData.Rr,
    TrRef=aimcData.TrRef,
    alpha20r(displayUnit="1/K") = aimcData.alpha20r,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    m=3,
    TsOperational=293.15,
    effectiveStatorTurns=aimcData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{20,-62},{40,-42}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia3(J=J_Load)
    annotation (Placement(transformation(extent={{50,-62},{70,-42}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque3(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false) annotation (Placement(transformation(extent={{100,-62},
            {80,-42}})));
  Modelica.Blocks.Math.Gain gain(k=(m/m3)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,32})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{80,10},{100,-10}})));
initial equation
  aimc3.is[1:2] = zeros(2);
  aimc3.ir[1:2] = zeros(2);
  aimcM.is[1:2] = zeros(2);
  aimcM.rotorCage.electroMagneticConverter.Phi = Complex(0, 0);

equation
  connect(starM.pin_n, groundM.p) annotation (Line(points={{-90,72},{-90,
          70},{-90,60}}, color={0,0,255}));
  connect(sineVoltageM.plug_n, starM.plug_p) annotation (Line(points={{-60,
          72},{-60,72},{-70,72}}, color={0,0,255}));
  connect(aimcM.flange, loadInertiaM.flange_a)
    annotation (Line(points={{40,50},{40,50},{50,50}}));
  connect(terminalBoxM.plug_sn, aimcM.plug_sn)
    annotation (Line(points={{24,60},{24,60}}, color={0,0,255}));
  connect(terminalBoxM.plug_sp, aimcM.plug_sp)
    annotation (Line(points={{36,60},{36,60}}, color={0,0,255}));
  connect(sineVoltageM.plug_p, idealCloserM.plug_p) annotation (Line(
      points={{-40,72},{-30,72}},
      color={0,0,255}));
  connect(idealCloserM.plug_n, currentRMSsensorM.plug_p) annotation (Line(
      points={{-10,72},{0,72}},
      color={0,0,255}));
  connect(booleanStepM.y, idealCloserM.control) annotation (Line(
      points={{-20,51},{-20,60}}, color={255,0,255}));
  connect(star3.pin_n, ground3.p)
    annotation (Line(points={{-90,-30},{-90,-42}}, color={0,0,255}));
  connect(sineVoltage3.plug_n, star3.plug_p) annotation (Line(points={{-60,
          -30},{-60,-30},{-70,-30}}, color={0,0,255}));
  connect(aimc3.flange, loadInertia3.flange_a) annotation (Line(points={{
          40,-52},{40,-52},{50,-52}}));
  connect(loadInertia3.flange_b, quadraticLoadTorque3.flange) annotation (
     Line(points={{70,-52},{74,-52},{76,-52},{80,-52}}));
  connect(terminalBox3.plug_sn, aimc3.plug_sn)
    annotation (Line(points={{24,-42},{24,-42}}, color={0,0,255}));
  connect(terminalBox3.plug_sp, aimc3.plug_sp)
    annotation (Line(points={{36,-42},{36,-42}}, color={0,0,255}));
  connect(terminalBox3.plugSupply, currentRMSsensor3.plug_n) annotation (
      Line(points={{30,-40},{30,-30},{20,-30}}, color={0,0,255}));
  connect(sineVoltage3.plug_p, idealCloser3.plug_p) annotation (Line(
      points={{-40,-30},{-30,-30}},
      color={0,0,255}));
  connect(idealCloser3.plug_n, currentRMSsensor3.plug_p) annotation (Line(
      points={{-10,-30},{0,-30}},
      color={0,0,255}));
  connect(booleanStep3.y, idealCloser3.control) annotation (Line(
      points={{-20,-51},{-20,-42}}, color={255,0,255}));
  connect(currentRMSsensorM.I, gain.u) annotation (Line(
      points={{10,61},{10,44}}, color={0,0,127}));
  connect(loadInertiaM.flange_b, quadraticLoadTorqueM.flange) annotation (
     Line(
      points={{70,50},{80,50}}));
  connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
      points={{10,-19},{10,0},{82,0}},
      color={0,0,127}));
  connect(feedback.u2, gain.y) annotation (Line(
      points={{90,8},{90,16},{10,16},{10,21}},
      color={0,0,127}));
  connect(currentRMSsensorM.plug_n, terminalBoxM.plugSupply) annotation (
      Line(
      points={{20,72},{30,72},{30,62}},
      color={0,0,255}));
  annotation (
    experiment(
      StopTime=1.5,
      Interval=1E-4,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
At start time tStart voltages are supplied to the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage\">polyphase induction machines with squirrel cage</a>.
The machines starts from standstill, accelerating
inertias against load torque quadratic dependent on speed, finally reaching nominal speed. Two equivalent machines with different numbers of phases are compared and their equal behavior is demonstrated.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: machine torque</li>
<li><code>aimsM/M3.wMechanical</code>: machine speed</li>
<li><code>feedback.y</code>: zero since difference of three-phase current phasor and scaled polyphase current phasor are equal</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={       Text(
                extent={{20,88},{100,80}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textString="%m-phase machine",
                textStyle={TextStyle.Bold}),Text(
                extent={{20,-22},{100,-30}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textString="Three-phase machine",
                textStyle={TextStyle.Bold})}));
end IMC_DOL_Polyphase;
