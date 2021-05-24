within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Steinmetz
  "Induction machine with squirrel cage and Steinmetz-connection"

  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
  parameter SI.Time tStart1=0.1 "Start time";
  parameter SI.Capacitance Cr=0.0035
    "Motor's running capacitor";
  parameter SI.Capacitance Cs=5*Cr
    "Motor's (additional) starting capacitor";
  parameter SI.AngularVelocity wSwitch(displayUnit="rev/min")=
       1350*2*Modelica.Constants.pi/60
    "Speed for switching off the starting capacitor";
  parameter SI.Torque TLoad=2/3*161.4 "Nominal load torque";
  parameter SI.AngularVelocity wLoad(displayUnit="rev/min")=
       1462.5*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage aimc(
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    ratioCommonStatorLeakage=aimcData.ratioCommonStatorLeakage,
    frictionParameters=aimcData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=aimcData.statorCoreParameters,
    strayLoadParameters=aimcData.strayLoadParameters,
    TrRef=aimcData.TrRef,
    Rs=aimcData.Rs*m/3,
    Lssigma=aimcData.Lssigma*m/3,
    Lszero=aimcData.Lszero*m/3,
    Lm=aimcData.Lm*m/3,
    Lrsigma=aimcData.Lrsigma*m/3,
    Rr=aimcData.Rr*m/3,
    TsOperational=293.15,
    effectiveStatorTurns=aimcData.effectiveStatorTurns,
    alpha20r=aimcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(f=
        fNominal, V=sqrt(2)*VNominal) annotation (Placement(
        transformation(extent={{-50,90},{-70,70}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=tStart1)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealCloser
    annotation (Placement(transformation(
        origin={-20,80},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque(
    w_nominal=wLoad,
    TorqueDirection=false,
    tau_nominal=-TLoad,
    useSupport=false) annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox TerminalBox1(
      terminalConnection="D")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_p3(m=m, k=3)
    annotation (Placement(transformation(
        origin={-30,18},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_p2(m=m, k=2)
    annotation (Placement(transformation(
        origin={-10,18},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_p1(m=m, k=1)
    annotation (Placement(transformation(
        origin={10,18},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Capacitor cRun(C=Cr) annotation (
      Placement(transformation(
        origin={10,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor cStart(C=Cs) annotation (
      Placement(transformation(
        origin={30,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealOpener
    annotation (Placement(transformation(
        origin={30,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
        wSwitch) annotation (Placement(transformation(
        origin={60,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor relSpeedSensor annotation (
      Placement(transformation(extent={{-10,-10},{10,10}}, origin={30,-20})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData
    aimcData "Induction machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
    annotation (Placement(transformation(
        origin={-10,-10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
initial equation
  aimc.is = zeros(3);
  aimc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
  cStart.v = 0;
  cRun.v = 0;
equation
  connect(ground.p, sineVoltage.n)
    annotation (Line(points={{-80,80},{-70,80}}, color={0,0,255}));
  connect(sineVoltage.p, idealCloser.p)
    annotation (Line(points={{-50,80},{-30,80}}, color={0,0,255}));
  connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-29,50},{-20,50},{-20,68}},
                                  color={255,0,255}));
  connect(plugToPin_p3.pin_p, sineVoltage.n) annotation (Line(points={{-30,20},{-70,20},{-70,80}},
                                  color={0,0,255}));
  connect(idealCloser.n, plugToPin_p2.pin_p)
    annotation (Line(points={{-10,80},{-10,20}}, color={0,0,255}));
  connect(cRun.n, plugToPin_p1.pin_p)
    annotation (Line(points={{10,30},{10,20}}, color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange)
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(cRun.p, idealCloser.n) annotation (Line(points={{10,50},{10,80},{-10,80}},
                     color={0,0,255}));
  connect(plugToPin_p1.pin_p, cStart.n)
    annotation (Line(points={{10,20},{30,20},{30,30}}, color={0,0,255}));
  connect(idealOpener.n, cStart.p) annotation (Line(points={{30,60},{30,50}},
                                  color={0,0,255}));
  connect(idealOpener.p, idealCloser.n) annotation (Line(points={{30,80},{-10,80}},
                             color={0,0,255}));
  connect(greaterThreshold.y, idealOpener.control) annotation (Line(
        points={{60,51},{60,70},{42,70}}, color={255,0,255}));
  connect(TerminalBox1.plug_sn, aimc.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}}, color={0,0,255}));
  connect(TerminalBox1.plug_sp, aimc.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}}, color={0,0,255}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  connect(relSpeedSensor.flange, aimc.flange) annotation (Line(
      points={{20,-20},{20,-40},{0,-40}}));
  connect(relSpeedSensor.w, greaterThreshold.u) annotation (Line(
      points={{41,-20},{60,-20},{60,28}}, color={0,0,127}));
  connect(plugToPin_p3.plug_p, currentQuasiRMSSensor.plug_p) annotation (
      Line(
      points={{-30,16},{-30,0},{-10,0}}, color={0,0,255}));
  connect(plugToPin_p2.plug_p, currentQuasiRMSSensor.plug_p) annotation (
      Line(
      points={{-10,16},{-10,0}},         color={0,0,255}));
  connect(plugToPin_p1.plug_p, currentQuasiRMSSensor.plug_p) annotation (
      Line(
      points={{10,16},{10,0},{-10,0}}, color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, TerminalBox1.plugSupply)
    annotation (Line(
      points={{-10,-20},{-10,-28}}, color={0,0,255}));
  annotation (experiment(Interval=0.0001, Tolerance=1e-06, StopTime=1),             Documentation(
        info="<html>
<p>At start time tStart single-phase voltage is supplied to the induction machine with squirrel cage;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
finally reaching nominal speed.</p>

<p>Default machine parameters are used.</p>
</html>"));
end IMC_Steinmetz;
