within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Conveyor "Induction machine with squirrel cage and inverter driving a conveyor"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  constant SI.Frequency unitFrequency=1 annotation(HideResult=true);
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=imcData.fsNominal
    "Nominal frequency";
  parameter SI.AngularVelocity wNominal=2*pi*fNominal/imcData.p
    "Nominal speed";
  parameter SI.Torque TLoad=161.4 "Nominal load torque";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  parameter SI.Length r=0.05 "Transmission radius";
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
    TrRef=imcData.TrRef,
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    m=m,
    TsOperational=293.15,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    alpha20r=imcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{60,10},{40,30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorQS(m=m)
    annotation (Placement(transformation(extent={{20,100},{40,80}})));
  Modelica.Blocks.Sources.CombiTimeTable dutyCycle(
    table=[0,0; 1,1; 4,1; 5,0; 10,0; 11,-1; 14,-1; 15,0; 20,0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Utilities.VfController vfControllerQS(
    final m=m,
    VNominal=VNominal,
    fNominal=fNominal) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableVoltageSource signalVoltageQS(final m=m)
    annotation (Placement(transformation(origin={0,90}, extent={{10,10},{-10,-10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(final m=m) annotation (Placement(transformation(extent={{-40,80},{-60,100}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS annotation (Placement(transformation(
        origin={-70,70},
        extent={{-10,-10},{10,10}})));
  Utilities.MultiTerminalBox terminalBoxQS(terminalConnection="Y", m=m) annotation (Placement(transformation(extent={{60,26},{40,46}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData
    imcData "Induction machine data"
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
  Modelica.Blocks.Math.Gain gainQS(k=fNominal/unitFrequency)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2TQS(ratio=1/r)
    annotation (Placement(transformation(extent={{32,10},{12,30}})));
  Modelica.Mechanics.Translational.Components.Mass massQS(m=JLoad/r^2)
    annotation (Placement(transformation(extent={{0,10},{-20,30}})));
  Modelica.Mechanics.Translational.Sources.SignForce signForceQS(v0(displayUnit
        ="m/s") = 0.01*wNominal*r, f_nominal=-TLoad/r)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundMachineQS
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={90,
            10})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starMachineQS(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={80,32})));
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
    annotation (Placement(transformation(extent={{60,-90},{40,-70}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(m=m)
    annotation (Placement(transformation(extent={{20,0},{40,-20}})));
  Modelica.Electrical.Machines.Utilities.VfController
                                             vfController(
    final m=m,
    VNominal=VNominal,
    fNominal=fNominal) annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage(
      final m=m) annotation (Placement(transformation(
        origin={0,-10},
        extent={{10,10},{-10,-10}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-40,-20},{-60,0}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-70,-30},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBox(
      terminalConnection="Y", m=m)
    annotation (Placement(transformation(extent={{60,-74},{40,-54}})));
  Modelica.Blocks.Math.Gain
                   gain(k=fNominal/unitFrequency)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Mechanics.Translational.Components.IdealGearR2T
                                                  idealGearR2T(ratio=1/r)
    annotation (Placement(transformation(extent={{32,-90},{12,-70}})));
  Modelica.Mechanics.Translational.Components.Mass
                                          mass(m=JLoad/r^2)
    annotation (Placement(transformation(extent={{0,-90},{-20,-70}})));
  Modelica.Mechanics.Translational.Sources.SignForce
                                            signForce(                           v0(
        displayUnit="m/s") = 0.01*wNominal*r, f_nominal=-TLoad/r)
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Modelica.Electrical.Polyphase.Basic.Star starMachine(final m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={80,-68})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (Placement(
        transformation(origin={90,-90}, extent={{-10,-10},{10,10}})));
initial equation
  sum(imc.is) = 0;
  imc.is[1:2] = zeros(2);
  imc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
equation
  connect(signalVoltageQS.plug_n, starQS.plug_p) annotation (Line(points={{-10,90},{-40,90}}, color={85,170,255}));
  connect(starQS.pin_n, groundQS.pin) annotation (Line(points={{-60,90},{-70,90},{-70,80}}, color={85,170,255}));
  connect(signalVoltageQS.plug_p, currentQuasiRMSSensorQS.plug_p) annotation (Line(points={{10,90},{20,90}}, color={85,170,255}));
  connect(terminalBoxQS.plugSupply, currentQuasiRMSSensorQS.plug_n) annotation (Line(points={{50,32},{50,90},{40,90}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sn, imcQS.plug_sn) annotation (Line(points={{56,30},{56,30}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sp, imcQS.plug_sp) annotation (Line(points={{44,30},{44,30}}, color={85,170,255}));
  connect(imcQS.flange, idealGearR2TQS.flangeR) annotation (Line(points={{40,20},{32,20}}));
  connect(idealGearR2TQS.flangeT, massQS.flange_a) annotation (Line(points={{12,20},{0,20}}, color={0,127,0}));
  connect(massQS.flange_b, signForceQS.flange) annotation (Line(points={{-20,20},{-30,20}}, color={0,127,0}));
  connect(vfControllerQS.y, signalVoltageQS.V) annotation (Line(points={{1,50},{6,50},{6,78}}, color={85,170,255}));
  connect(groundMachineQS.pin,starMachineQS. pin_n) annotation (Line(
      points={{90,20},{90,32}},   color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (Line(points={{70,32},{60,32}}, color={85,170,255}));
  connect(dutyCycle.y[1], gainQS.u) annotation (Line(points={{-79,50},{-72,50},{-72,50},{-62,50}}, color={0,0,127}));
  connect(gainQS.y, signalVoltageQS.f) annotation (Line(points={{-39,50},{-30,50},{-30,70},{-6,70},{-6,78}}, color={0,0,127}));
  connect(gainQS.y, vfControllerQS.u) annotation (Line(points={{-39,50},{-22,50}}, color={0,0,127}));
  connect(signalVoltage.plug_n,star. plug_p)
    annotation (Line(points={{-10,-10},{-40,-10}},    color={0,0,255}));
  connect(star.pin_n,ground. p)
    annotation (Line(points={{-60,-10},{-70,-10},{-70,-20}},
                                                 color={0,0,255}));
  connect(vfController.y,signalVoltage. v)
    annotation (Line(points={{-9,-50},{0,-50},{0,-22}},
                                                color={0,0,255}));
  connect(signalVoltage.plug_p,currentQuasiRMSSensor. plug_p)
    annotation (Line(points={{10,-10},{20,-10}},    color={0,0,255}));
  connect(terminalBox.plugSupply,currentQuasiRMSSensor. plug_n)
    annotation (Line(
      points={{50,-68},{50,-10},{40,-10}},          color={0,0,255}));
  connect(terminalBox.plug_sn, imc.plug_sn) annotation (Line(points={{56,-70},{56,-70}}, color={0,0,255}));
  connect(terminalBox.plug_sp, imc.plug_sp) annotation (Line(points={{44,-70},{44,-70}}, color={0,0,255}));
  connect(vfController.u,gain. y)
    annotation (Line(points={{-32,-50},{-39,-50}},
                                                 color={0,0,127}));
  connect(imc.flange, idealGearR2T.flangeR) annotation (Line(points={{40,-80},{32,-80}}));
  connect(idealGearR2T.flangeT,mass. flange_a)
    annotation (Line(points={{12,-80},{0,-80}},           color={0,127,0}));
  connect(mass.flange_b,signForce. flange)
    annotation (Line(points={{-20,-80},{-30,-80}},        color={0,127,0}));
  connect(dutyCycle.y[1], gain.u) annotation (Line(points={{-79,50},{-70,50},{-70,20},{-90,20},{-90,-50},{-62,-50}}, color={0,0,127}));
  connect(groundMachine.p,starMachine. pin_n) annotation (Line(points={{90,-80},{90,-68}},   color={0,0,255}));
  connect(terminalBox.starpoint, starMachine.plug_p) annotation (Line(points={{60,-68},{70,-68}}, color={0,0,255}));
  annotation (experiment(StopTime=20, Interval=0.0001, Tolerance=1e-06), Documentation(
        info="<html>
<p>
An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is driven by a load cycle of acceleration, constant speed, deceleration and standstill.
The mechanical load is a constant torque like a conveyor (with regularization around zero speed).
</p>
<p>Simulate for 20 seconds and plot (versus time):</p>
<ul>
<li><code>currentQuasiRMSSensor|currentQuasiRMSSensorQS.I</code>: (equivalent) stator current RMS</li>
<li><code>imc|imcQS.wMechanical</code>: machine speed</li>
<li><code>imc|imcQS.tauElectrical</code>: machine torque</li>
</ul>
<p>Default machine parameters are used.</p>
</html>"),
    Diagram(graphics={
        Text(
          extent={{20,60},{100,52}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),
                                            Text(
                  extent={{20,-40},{100,-48}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase transient")}));
end IMC_Conveyor;
