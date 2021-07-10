within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Inverter
  "Induction machine with squirrel cage and inverter"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  import Modelica.Constants.small;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100 "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.Frequency f=50 "Maximum operational frequency";
  parameter SI.Time tRamp=1 "Frequency ramp";
  parameter SI.Torque TLoad=161.4*min(1, fNominal/abs(f)) "Nominal load torque";
  parameter SI.Time tStep=1.2 "Time of load torque step";
  parameter SI.Inertia JLoad=0.29 "Load's moment of inertia";
  SI.Frequency fs=ramp.y "Stator frequency";
  SI.Frequency fr=s*fs "Rotor frequency";
  Real s=if noEvent(abs(fs)<small) then 0 else 1 - aimc.wMechanical*aimcData.p/(2*pi*fs) "Slip";
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage
    aimc(
    m=m,
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    frictionParameters=aimcData.frictionParameters,
    phiMechanical(fixed=true, start=0),
    wMechanical(fixed=true, start=0),
    statorCoreParameters=aimcData.statorCoreParameters,
    strayLoadParameters=aimcData.strayLoadParameters,
    TrRef=aimcData.TrRef,
    Rs=aimcData.Rs*m/3,
    Lssigma=aimcData.Lssigma*m/3,
    Lm=aimcData.Lm*m/3,
    Lrsigma=aimcData.Lrsigma*m/3,
    Rr=aimcData.Rr*m/3,
    TsOperational=293.15,
    effectiveStatorTurns=aimcData.effectiveStatorTurns,
    alpha20r=aimcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentQuasiRMSSensor(m=m)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=
            270)));
  Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp) annotation (
     Placement(transformation(extent={{-90,50},{-70,70}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.VfController
    vfController(
      final m=m,
      VNominal=VNominal,
      fNominal=fNominal)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableVoltageSource
    voltageSource(final m=m) annotation (Placement(transformation(
        origin={0,60},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star
    star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
    startTime=tStep,
    stepTorque=-TLoad,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
            {70,-30}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.TerminalBox
    terminalBox(m=m, terminalConnection="Y")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData
    aimcData "Induction machine data" annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    ground1 annotation (Placement(
        transformation(
        origin={-50,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
initial equation
  aimc.rotorCage.port_p.reference.gamma=0;
equation
  connect(ramp.y, vfController.u)
    annotation (Line(points={{-69,60},{-52,60}}, color={0,0,255}));
  connect(loadTorqueStep.flange, loadInertia.flange_b)
    annotation (Line(points={{70,-40},{60,-40}}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  connect(ramp.y, voltageSource.f) annotation (Line(points={{-69,60},{-60,60},{-60,
          80},{-20,80},{-20,66},{-12,66}}, color={0,0,127}));
  connect(vfController.y, voltageSource.V) annotation (Line(points={{-29,60},{-20,
          60},{-20,54},{-12,54}}, color={85,170,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn)
    annotation (Line(points={{-16,-30},{-16,-30}}, color={85,170,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp)
    annotation (Line(points={{-4,-30},{-4,-30}}, color={85,170,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n) annotation (
      Line(points={{-10,-28},{-10,-20},{-1.77636e-15,-20},{-1.77636e-15,-10}},
        color={85,170,255}));
  connect(currentQuasiRMSSensor.plug_p, voltageSource.plug_p)
    annotation (Line(points={{0,10},{0,50}}, color={85,170,255}));
  connect(star.plug_p, voltageSource.plug_n)
    annotation (Line(points={{-50,90},{0,90},{0,70}}, color={85,170,255}));
  connect(star.pin_n, ground.pin)
    annotation (Line(points={{-70,90},{-80,90}}, color={85,170,255}));
  connect(ground1.pin, terminalBox.starpoint) annotation (Line(points={{-40,-30},
          {-30,-30},{-30,-28},{-20,-28}}, color={85,170,255}));
  annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is raised by a ramp, causing the induction machine with squirrel cage to start,
and accelerate inertias. At time <code>tStep</code> a load step is applied.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li><code>currentQuasiRMSSensor.I</code>: stator current RMS</li>
<li><code>aimc.wMechanical</code>: machine speed</li>
<li><code>aimc.tauElectrical</code>: machine torque</li>
<li><code>fs</code>: stator frequency</li>
<li><code>fr</code>: rotor frequency</li>
<li><code>s</code>: slip</li>
</ul>

<p>
Compare with transient models 
<a href=\"modelica://Modelica.Electrical.Machines.Examples.InductionMachines.IMC_Inverter\">IMC_Inverter (Electrical.Machines)</a> and
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.IMC_Inverter\">IMC_Inverter (FundamentalWave)</a>. 
Note that electrical transients are neglected, but mechanical transients are taken into account. 
</p>

<h4>Theoretical thoughts</h4>

<p>
By setting the stator resistance <code>Rs = 0</code>, comparing quasistatic points of operation for different stator frequencies <code>fs</code>, 
it can be seen that</p>

<ul>
<li>in the base region <code>fs &le; fNominal</code> rotor frequency <code>fr</code> is constant, if the load torque is constant,</li>
<li>whereas in the field weakening region <code>f &ge; fNominal</code> slip is constant, 
if load torque is adapted according to <code>tau = tauNominal*fNominal/f</code>.</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
end IMC_Inverter;
