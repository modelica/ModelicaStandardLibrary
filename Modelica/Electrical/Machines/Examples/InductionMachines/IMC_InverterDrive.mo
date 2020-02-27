within Modelica.Electrical.Machines.Examples.InductionMachines;
model IMC_InverterDrive
  "Test example: InductionMachineSquirrelCage inverter drive"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  import Modelica.Electrical.Polyphase.Functions.factorY2DC;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=400
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.Resistance RGrid=10e-3 "Grid choke resistance";
  parameter SI.Inductance LGrid=500e-6 "Grid choke inductance";
  parameter SI.Voltage VDC=factorY2DC(m)*VNominal/sqrt(3) "Theoretical DC voltage";
  parameter SI.Capacitance CDC=5e-3 "DC capacitor";
  parameter SI.Torque TLoad=161.4 "Nominal load torque";
  parameter SI.AngularVelocity wLoad=1440.45*2*pi/60 "Nominal load speed";
  parameter SI.Inertia JLoad=0.29 "Load's moment of inertia";
  Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    final phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    final f=fill(fNominal, m),
    final offset=zeros(m),
    final startTime=zeros(m),
    final V=fill(VNominal*sqrt(2/3), m))
  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-30})));
  Polyphase.Basic.Star star(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-60})));
  Analog.Basic.Ground ground annotation (Placement(transformation(
        origin={-80,-90},
        extent={{-10,-10},{10,10}})));
  Sensors.CurrentQuasiRMSSensor gridCurrent
   annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,0})));
  Polyphase.Basic.Resistor resistor(
    final m=m,
    final R=fill(RGrid, m),
    final T_ref=fill(20, m),
    final alpha=zeros(m),
    final T=fill(20, m))   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Polyphase.Basic.Inductor inductor(m=m, final L=fill(LGrid, m))
  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,60})));

  PowerConverters.ACDC.DiodeBridge2mPulse rectifier
    annotation (Placement(transformation(extent={{-68,60},{-48,80}})));
  Analog.Basic.Capacitor capacitor(v(fixed=true, start=VDC), C=CDC)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,70})));
  PowerConverters.DCAC.Polyphase2Level inverter annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={0,70})));
  Machines.Sensors.CurrentQuasiRMSSensor machineCurrent annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,0})));
  Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
    annotation (Placement(transformation(extent={{20,-24},{40,-4}})));
  Machines.BasicMachines.InductionMachines.IM_SquirrelCage aimc(
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    Rs=aimcData.Rs,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    Lszero=aimcData.Lszero,
    Lssigma=aimcData.Lssigma,
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    frictionParameters=aimcData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=aimcData.statorCoreParameters,
    strayLoadParameters=aimcData.strayLoadParameters,
    Lm=aimcData.Lm,
    Lrsigma=aimcData.Lrsigma,
    Rr=aimcData.Rr,
    TrRef=aimcData.TrRef,
    TsOperational=293.15,
    alpha20r=aimcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  parameter Utilities.ParameterRecords.IM_SquirrelCageData aimcData(
    Rs=0.03*16,
    Rr=0.04*16,
    Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*aimcData.fsNominal)*16,
    Lm=3*sqrt(1 - 0.0667)/(2*pi*aimcData.fsNominal)*16,
    Lrsigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*aimcData.fsNominal)*16) "Induction machine data"
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque loadTorque(
    useSupport=false, tau_nominal=-TLoad,
    TorqueDirection=false,
    w_nominal=wLoad)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Blocks.Sources.Ramp ramp(height=fNominal,
    startTime=0,
    duration=1.2)
    annotation (
     Placement(transformation(extent={{-10,-10},{10,10}},
        origin={-20,-50})));
  Machines.Utilities.VfController vfController(
    final m=m,
    VNominal=VNominal,
    fNominal=fNominal,
    EconomyMode=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-20})));

  SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,10})));
  PowerConverters.DCAC.Control.PWM pwm(uMax=VDC, f=2000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,40})));
initial equation
  inductor.i[1:2] = zeros(2);
  aimc.is[1:3] = zeros(3);
  aimc.ir = zeros(2);
equation
  connect(loadTorque.flange, loadInertia.flange_b)
    annotation (Line(points={{80,-30},{70,-30}}));
  connect(terminalBox.plugSupply, machineCurrent.plug_n)
    annotation (Line(points={{30,-18},{30,-10}},
                                               color={0,0,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
      points={{24,-20},{24,-20}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
      points={{36,-20},{36,-20}},
      color={0,0,255}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{40,-30},{50,-30}}));
  connect(vfController.u, ramp.y)
    annotation (Line(points={{0,-32},{0,-50},{-9,-50}},
                                               color={0,0,127}));
  connect(toSpacePhasor.u, vfController.y)
    annotation (Line(points={{0,-2},{0,-9}},   color={0,0,127}));
  connect(pwm.u, toSpacePhasor.y)
    annotation (Line(points={{0,28},{0,21}},   color={0,0,127}));
  connect(inverter.fire_p, pwm.fire_p)
    annotation (Line(points={{-6,58},{-6,51}}, color={255,0,255}));
  connect(inverter.fire_n, pwm.fire_n)
    annotation (Line(points={{6,58},{6,51}}, color={255,0,255}));
  connect(inverter.ac, machineCurrent.plug_p)
    annotation (Line(points={{10,70},{30,70},{30,10}}, color={0,0,255}));
  connect(capacitor.p, inverter.dc_p) annotation (Line(points={{-30,80},{-20,80},
          {-20,76},{-10,76}}, color={0,0,255}));
  connect(capacitor.n, inverter.dc_n) annotation (Line(points={{-30,60},{-20,60},
          {-20,64},{-10,64}}, color={0,0,255}));
  connect(rectifier.dc_p, capacitor.p) annotation (Line(points={{-48,76},{-40,76},
          {-40,80},{-30,80}}, color={0,0,255}));
  connect(rectifier.dc_n, capacitor.n) annotation (Line(points={{-48,64},{-40,64},
          {-40,60},{-30,60}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{-80,-40},{-80,-50}},   color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-80,-70},{-80,-80}}, color={0,0,255}));
  connect(resistor.plug_n, inductor.plug_p)
    annotation (Line(points={{-80,40},{-80,50}},   color={0,0,255}));
  connect(inductor.plug_n, rectifier.ac)
    annotation (Line(points={{-80,70},{-68,70}},  color={0,0,255}));
  connect(resistor.plug_p, gridCurrent.plug_p)
    annotation (Line(points={{-80,20},{-80,10}}, color={0,0,255}));
  connect(gridCurrent.plug_n, sineVoltage.plug_p)
    annotation (Line(points={{-80,-10},{-80,-20}}, color={0,0,255}));
  annotation (experiment(
      StopTime=1.5,
      Interval=5e-05,
      Tolerance=1e-06), Documentation(
        info="<html>
<p>
This is a model of a complete inverter drive comprising:
</p>
<ul>
<li>a grid model and a line choke</li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2mPulse\">a diode rectifier</a></li>
<li>a buffer capacitor</li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Polyphase2Level\">a switching inverter</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.PWM\">a pulse width modulation</a></li>
<li><a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">a voltage/frequency characteristic</a></li>
<li>the reference frequency ramped up</li>
<li>an induction machine with squirrel cage</li>
<li>a load inertia and quadratic speed dependent load torque (like a fan or pump)</li>
</ul>
<p>Please note: Be patient, two switching devices cause many event iterations which cost performance.</p>
<p>Note that due to the voltage drop the voltage at the machine can't reach the full voltage which means torque reduction.</p>
<p>Default machine parameters are adapted to nominal phase voltage 400 V and nominal phase current 25 A.</p>
</html>"));
end IMC_InverterDrive;
