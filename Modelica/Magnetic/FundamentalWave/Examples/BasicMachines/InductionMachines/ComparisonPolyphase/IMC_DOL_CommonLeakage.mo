within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase;
model IMC_DOL_CommonLeakage
  "Direct on line start of polyphase induction machine with squirrel cage"
  extends Modelica.Icons.Example;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter Integer m=5 "Number of stator phases" annotation(Evaluate=true);
  final parameter Integer mBase=numberOfSymmetricBaseSystems(m) "Number of symmetric base systems";
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
  parameter SI.Time tOn=0.1 "Start time of machine";
  parameter SI.Torque T_Load=161.4 "Nominal load torque";
  parameter SI.AngularVelocity w_Load(displayUnit="rev/min")=
       1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
        transformation(
        origin={-90,-50},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Polyphase.Basic.Star starM(final m=m) annotation (
      Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-90,-18})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltageM(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2.0)*VsNominal, m),
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m)) annotation (Placement(transformation(
        origin={-90,10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloserM(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*3/m, m))  annotation (Placement(transformation(origin={-70,72},
                 extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStepM[m](each startTime=tOn, each
      startValue=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,40})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSsensor0(m=m)
    annotation (Placement(transformation(origin={-30,72},extent={{-10,-10},{10,
            10}})));
  Electrical.Machines.Utilities.MultiTerminalBox     terminalBox0(m=m,
      terminalConnection="Y") annotation (Placement(transformation(extent={{0,56},{
            20,76}})));
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage aimc0(
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    ratioCommonStatorLeakage=0,
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
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia0(J=J_Load)
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque0(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false) annotation (Placement(transformation(extent={{80,40},{60,
            60}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData
    aimcData "Induction machine data"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSsensorH(m=m)
    annotation (Placement(transformation(origin={-30,10}, extent={{-10,-10},{10,
            10}})));
  Electrical.Machines.Utilities.MultiTerminalBox
                                            terminalBoxH(m=m,
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{0,-4},{20,16}})));
  Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage
    aimcH(
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    ratioCommonStatorLeakage=0.5,
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
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Mechanics.Rotational.Components.Inertia loadInertiaH(J=J_Load)
    annotation (Placement(transformation(extent={{30,-20},{50,0}})));
  Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque quadraticLoadTorqueH(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false)
    annotation (Placement(transformation(extent={{80,-20},{60,0}})));
  Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor          currentRMSsensor1(m=m)
    annotation (Placement(transformation(origin={-30,-46},
                                                         extent={{-10,-10},{10,
            10}})));
  Electrical.Machines.Utilities.MultiTerminalBox     terminalBox1(m=m,
      terminalConnection="Y") annotation (Placement(transformation(extent={{0,-64},
            {20,-44}})));
  Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage
                                                                           aimc1(
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    ratioCommonStatorLeakage=1,
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
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Mechanics.Rotational.Components.Inertia          loadInertia1(J=J_Load)
    annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
  Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque1(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false) annotation (Placement(transformation(extent={{80,-80},{60,
            -60}})));
  Electrical.Polyphase.Basic.Star starBase0(m=mBase) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,52})));
  Electrical.Polyphase.Basic.Star starBaseH(m=mBase) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-8})));
  Electrical.Polyphase.Basic.Star starBase1(m=mBase) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-68})));
initial equation
  aimc0.is[1:m - 1] = zeros(m - 1);
  aimc0.rotorCage.electroMagneticConverter.Phi = Complex(0, 0);
  aimcH.is[1:m - 1] = zeros(m - 1);
  aimcH.rotorCage.electroMagneticConverter.Phi = Complex(0, 0);
  aimc1.is[1:2] = zeros(2);
  aimc1.rotorCage.electroMagneticConverter.Phi = Complex(0, 0);
equation
  connect(starM.pin_n, groundM.p) annotation (Line(points={{-90,-28},{-90,-40}},
                         color={0,0,255}));
  connect(sineVoltageM.plug_n, starM.plug_p) annotation (Line(points={{-90,0},{-90,
          -8}},                   color={0,0,255}));
  connect(aimc0.flange,loadInertia0. flange_a)
    annotation (Line(points={{20,50},{30,50}}));
  connect(terminalBox0.plug_sn,aimc0. plug_sn)
    annotation (Line(points={{4,60},{4,60}},   color={0,0,255}));
  connect(terminalBox0.plug_sp,aimc0. plug_sp)
    annotation (Line(points={{16,60},{16,60}}, color={0,0,255}));
  connect(sineVoltageM.plug_p, idealCloserM.plug_p) annotation (Line(
      points={{-90,20},{-90,72},{-80,72}},
      color={0,0,255}));
  connect(idealCloserM.plug_n,currentRMSsensor0. plug_p) annotation (Line(
      points={{-60,72},{-40,72}},
      color={0,0,255}));
  connect(booleanStepM.y, idealCloserM.control) annotation (Line(
      points={{-70,51},{-70,60}}, color={255,0,255}));
  connect(loadInertia0.flange_b,quadraticLoadTorque0. flange) annotation (
     Line(
      points={{50,50},{60,50}}));
  connect(currentRMSsensor0.plug_n,terminalBox0. plugSupply) annotation (
      Line(
      points={{-20,72},{10,72},{10,62}},
      color={0,0,255}));
  connect(aimcH.flange, loadInertiaH.flange_a)
    annotation (Line(points={{20,-10},{30,-10}}));
  connect(terminalBoxH.plug_sn, aimcH.plug_sn)
    annotation (Line(points={{4,0},{4,0}}, color={0,0,255}));
  connect(terminalBoxH.plug_sp, aimcH.plug_sp)
    annotation (Line(points={{16,0},{16,0}}, color={0,0,255}));
  connect(idealCloserM.plug_n, currentRMSsensorH.plug_p) annotation (Line(
        points={{-60,72},{-50,72},{-50,10},{-40,10}}, color={0,0,255}));
  connect(loadInertiaH.flange_b, quadraticLoadTorqueH.flange)
    annotation (Line(points={{50,-10},{60,-10}}));
  connect(currentRMSsensorH.plug_n, terminalBoxH.plugSupply)
    annotation (Line(points={{-20,10},{10,10},{10,2}}, color={0,0,255}));
  connect(aimc1.flange,loadInertia1. flange_a)
    annotation (Line(points={{20,-70},{30,-70}}));
  connect(terminalBox1.plug_sn,aimc1. plug_sn)
    annotation (Line(points={{4,-60},{4,-60}}, color={0,0,255}));
  connect(terminalBox1.plug_sp,aimc1. plug_sp)
    annotation (Line(points={{16,-60},{16,-60}},
                                               color={0,0,255}));
  connect(idealCloserM.plug_n,currentRMSsensor1. plug_p) annotation (Line(
      points={{-60,72},{-50,72},{-50,-46},{-40,-46}},
      color={0,0,255}));
  connect(loadInertia1.flange_b,quadraticLoadTorque1. flange) annotation (
     Line(
      points={{50,-70},{60,-70}}));
  connect(currentRMSsensor1.plug_n,terminalBox1. plugSupply) annotation (
      Line(
      points={{-20,-46},{10,-46},{10,-58}},
      color={0,0,255}));
  connect(terminalBox0.starpoint, starBase0.plug_p)
    annotation (Line(points={{0,62},{-10,62}}, color={0,0,255}));
  connect(starBaseH.plug_p, terminalBoxH.starpoint)
    annotation (Line(points={{-10,2},{0,2}}, color={0,0,255}));
  connect(starBase1.plug_p, terminalBox1.starpoint)
    annotation (Line(points={{-10,-58},{0,-58}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=1.5,
      Interval=1E-4,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
At start time tStart voltages are supplied to the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage\">polyphase induction machines with squirrel cage</a>.
The machines starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed. 
Three equivalent machines with different parameter <code>ratioCommonLeakage</code> are compared. 
Note that due to the mode of operation, the behaviour of all three machines is identical. 
Only when fed by switching power electronics, parameter <code>ratioCommonLeakage</code> is essential.
</p>
</html>"),
    Diagram(graphics={       Text(
                extent={{10,80},{90,72}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
          textString="ratioCommonLeakage=0",
          textColor={0,0,0}),             Text(
                extent={{10,22},{90,14}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
          textColor={0,0,0},
          textString="ratioCommonLeakage=0.5"),
                                          Text(
                extent={{10,-38},{90,-46}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
          textColor={0,0,0},
          textString="ratioCommonLeakage=1")}));
end IMC_DOL_CommonLeakage;
