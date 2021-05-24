within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMEE_LoadDump
  "Test example: ElectricalExcitedSynchronousMachine with voltage controller"

  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  parameter SI.AngularVelocity wNominal=2*pi*smeeData.fsNominal
      /smee.p "Nominal speed";
  parameter SI.Impedance ZNominal=3*smeeData.VsNominal^2/
      smeeData.SNominal "Nominal load impedance";
  parameter Real powerFactor(
    min=0,
    max=1) = 0.8 "Load power factor";
  parameter SI.Resistance RLoad=ZNominal*powerFactor
    "Load resistance";
  parameter SI.Inductance LLoad=ZNominal*sqrt(1 -
      powerFactor^2)/(2*pi*smeeData.fsNominal) "Load inductance";
  parameter SI.Voltage Ve0=smee.IeOpenCircuit*
      Modelica.Electrical.Machines.Thermal.convertResistance(
            smee.Re,
            smee.TeRef,
            smee.alpha20e,
            smee.TeOperational) "No load excitation voltage";
  parameter Real k=2*Ve0/smeeData.VsNominal "Voltage controller: gain";
  parameter SI.Time Ti=smeeData.Td0Transient/2
    "Voltage controller: integral time constant";
  output Real controlError=(setPointGain.y - voltageQuasiRMSSensor.V)/
      smeeData.VsNominal;
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited
    smee(
    fsNominal=smeeData.fsNominal,
    TsRef=smeeData.TsRef,
    ratioCommonStatorLeakage=smeeData.ratioCommonStatorLeakage,
    Lrsigmad=smeeData.Lrsigmad,
    Lrsigmaq=smeeData.Lrsigmaq,
    Rrd=smeeData.Rrd,
    Rrq=smeeData.Rrq,
    TrRef=smeeData.TrRef,
    VsNominal=smeeData.VsNominal,
    IeOpenCircuit=smeeData.IeOpenCircuit,
    Re=smeeData.Re,
    TeRef=smeeData.TeRef,
    sigmae=smeeData.sigmae,
    useDamperCage=true,
    p=2,
    Jr=0.29,
    Js=0.29,
    statorCoreParameters(VRef=100),
    strayLoadParameters(IRef=100),
    brushParameters(ILinear=0.01),
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    TsOperational=293.15,
    alpha20s=smeeData.alpha20s,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    alpha20r=smeeData.alpha20r,
    TrOperational=293.15,
    TeOperational=293.15,
    alpha20e=smeeData.alpha20e)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData(
    SNominal=30e3,
    VsNominal=100,
    fsNominal=50,
    IeOpenCircuit=10,
    x0=0.1,
    xd=1.6,
    xq=1.6,
    xdTransient=0.1375,
    xdSubtransient=0.121428571,
    xqSubtransient=0.148387097,
    Ta=0.014171268,
    Td0Transient=0.261177343,
    Td0Subtransient=0.006963029,
    Tq0Subtransient=0.123345081,
    TsSpecification=293.15,
    TsRef=293.15,
    alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    TrSpecification=293.15,
    TrRef=293.15,
    alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    TeSpecification=293.15,
    TeRef=293.15,
    alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero)
    "Synchronous machine data"
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));

  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,0},
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed
    annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
  Modelica.Blocks.Sources.Ramp speedRamp(height=wNominal, duration=1)
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-50})));
  Modelica.Blocks.Math.Gain setPointGain(k=(smeeData.VsNominal/wNominal)/
        unitMagneticFlux)
    annotation (Placement(transformation(extent={{-50,-90},{-70,-70}})));
  Modelica.Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(
      ToSpacePhasor1(y(each start=1E-3, each fixed=true))) annotation (
      Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270)));
  Modelica.Blocks.Continuous.LimPID voltageController(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    yMax=2.5*Ve0,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    Td=0.001)
    annotation (Placement(transformation(extent={{-70,-20},{-50,-40}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage excitationVoltage
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-30,-30})));
  Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
      Placement(transformation(
        origin={-30,-60},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
    annotation (Placement(transformation(
        origin={10,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanPulse loadControl(period=4, startTime=2)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Electrical.Polyphase.Ideal.CloserWithArc switch(
    m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m),
    V0=fill(30, m),
    dVdt=fill(10e3, m),
    Vmax=fill(60, m),
    closerWithArc(off(start=fill(true, m), fixed=fill(true, m))))
    annotation (Placement(transformation(extent={{0,40},{-20,60}})));
  Modelica.Electrical.Polyphase.Basic.Resistor loadResistor(m=m, R=fill(
        RLoad, m))
    annotation (Placement(transformation(extent={{-30,40},{-50,60}})));
  Modelica.Electrical.Polyphase.Basic.Inductor loadInductor(m=m, L=fill(
        LLoad, m))
    annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
  Modelica.Electrical.Polyphase.Basic.Star star(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,30})));
protected
  constant SI.MagneticFlux unitMagneticFlux=1
    annotation (HideResult=true);
public
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=m)
    annotation (Placement(transformation(extent={{-50,90},{-30,70}})));
initial equation
  smee.airGap.V_msr = Complex(0, 0);
  //conditional damper cage currents are defined as fixed start values
  smee.ie = 0;
equation
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{4,-20},{4,-20}}, color={0,0,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{16,-20},{16,-20}}, color={0,0,255}));
  connect(excitationVoltage.p, smee.pin_ep) annotation (Line(
      points={{-30,-20},{-20,-20},{-20,-24},{0,-24}}, color={0,0,255}));
  connect(excitationVoltage.n, smee.pin_en) annotation (Line(
      points={{-30,-40},{-20,-40},{-20,-36},{0,-36}}, color={0,0,255}));
  connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
      points={{-30,-40},{-30,-50}}, color={0,0,255}));
  connect(voltageQuasiRMSSensor.plug_n, smee.plug_sn) annotation (Line(
      points={{0,-10},{4,-10},{4,-20}}, color={0,0,255}));
  connect(voltageQuasiRMSSensor.plug_p, smee.plug_sp) annotation (Line(
      points={{0,10},{16,10},{16,-20}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
    annotation (Line(
      points={{10,-18},{10,20}}, color={0,0,255}));
  connect(smee.flange, speed.flange) annotation (Line(
      points={{20,-30},{30,-30}}));
  connect(speed.flange, speedSensor.flange) annotation (Line(
      points={{30,-30},{30,-40}}));
  connect(speedRamp.y, speed.w_ref) annotation (Line(
      points={{59,-30},{52,-30}}, color={0,0,127}));
  connect(setPointGain.y, voltageController.u_s) annotation (Line(
      points={{-71,-80},{-80,-80},{-80,-30},{-72,-30}}, color={0,0,127}));
  connect(speedSensor.w, setPointGain.u) annotation (Line(
      points={{30,-61},{30,-80},{-48,-80}}, color={0,0,127}));
  connect(voltageQuasiRMSSensor.V, voltageController.u_m) annotation (
      Line(
      points={{-11,0},{-60,0},{-60,-18}}, color={0,0,127}));
  connect(voltageController.y, excitationVoltage.v) annotation (Line(
      points={{-49,-30},{-42,-30}}, color={0,0,127}));
  connect(loadInductor.plug_p, loadResistor.plug_n) annotation (Line(
      points={{-60,50},{-50,50}}, color={0,0,255}));
  connect(loadResistor.plug_p, switch.plug_n) annotation (Line(
      points={{-30,50},{-20,50}}, color={0,0,255}));
  connect(switch.plug_p, currentQuasiRMSSensor.plug_p) annotation (Line(
      points={{0,50},{10,50},{10,40}}, color={0,0,255}));
  connect(star.plug_p, loadInductor.plug_n) annotation (Line(
      points={{-90,40},{-90,50},{-80,50}}, color={0,0,255}));
  connect(star.pin_n, ground.p) annotation (Line(
      points={{-90,20},{-90,10}}, color={0,0,255}));
  connect(loadControl.y, booleanReplicator.u) annotation (Line(points={{-59,80},{-52,80}}, color={255,0,255}));
  connect(booleanReplicator.y, switch.control) annotation (Line(points={{-29,80},{-10,80},{-10,62}}, color={255,0,255}));
  annotation (experiment(StopTime=10, Interval=1E-4, Tolerance=1e-06), Documentation(info="<html>
<p>An electrically excited synchronous generator is started with a speed ramp, then driven with constant speed.
Voltage is controlled, the set point depends on speed. After start-up the generator is loaded, the load is rejected.</p>

<p>Simulate for 10 seconds and plot:</p>

<ul>
<li>voltageQuasiRMSSensor.V</li>
<li>smee.tauElectrical</li>
<li>smee.ie</li>
</ul>

<p>Default machine parameters are used</p>
</html>"));
end SMEE_LoadDump;
