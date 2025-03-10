within Modelica.Electrical.Machines.Examples.SynchronousMachines;
model SMPM_Braking
  "Test example: PermanentMagnetSynchronousMachine acting as brake"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  constant Real unitK( unit="rad/(s.Ohm)")=1 annotation(HideResult=true);
  parameter SI.Resistance R=1 "Nominal braking resistance";
  parameter SI.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p
    "Nominal speed";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet smpm(
    phiMechanical(start=0, fixed=true),
    useSupport=false,
    useThermalPort=false,
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    Lszero=smpmData.Lszero,
    Lssigma=smpmData.Lssigma,
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    Lmd=smpmData.Lmd,
    Lmq=smpmData.Lmq,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    wMechanical(start=wNominal, fixed=true),
    TrOperational=293.15,
    alpha20r=smpmData.alpha20r)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-80,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,0})));
  parameter Machines.Utilities.ParameterRecords.SM_PermanentMagnetData smpmData(
      useDamperCage=false) "Synchronous machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(
        origin={-10,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  PowerConverters.ACDC.DiodeBridge2mPulse diodeBridge2mPulse(m=m) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-10,30})));
  Analog.Basic.VariableResistor variableResistor
    annotation (Placement(transformation(extent={{0,50},{-20,70}})));
  Blocks.Math.Gain          gain(k=R/wNominal)
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,30})));
  Blocks.Nonlinear.Limiter          limiter(           uMin=0.1, uMax=10)
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,60})));
  Blocks.Math.Gain          ac2dc(k=pi^2/8)
                                 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={10,80})));
  Polyphase.Basic.Star                     starM(final m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-10})));
  Sensors.VoltageQuasiRMSSensor          voltageQuasiRMSSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,-10})));
  Analog.Basic.Resistor grounding(R=1e6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,30})));
initial equation
  smpm.is[1:2] = zeros(2);
  smpm.i_0_s = 0;

equation
  connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}},
      color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, terminalBox.plugSupply)
    annotation (Line(points={{-10,-10},{-10,-10},{-10,-28}}, color={0,0,255}));
  connect(diodeBridge2mPulse.ac, currentQuasiRMSSensor.plug_p)
    annotation (Line(points={{-10,20},{-10,15},{-10,10}},
                                                        color={0,0,255}));
  connect(variableResistor.p, diodeBridge2mPulse.dc_p) annotation (Line(points={{0,60},{
          0,50},{-4,50},{-4,40}},               color={0,0,255}));
  connect(variableResistor.n, diodeBridge2mPulse.dc_n)
    annotation (Line(points={{-20,60},{-20,50},{-16,50},{-16,40}},
                                                             color={0,0,255}));
  connect(smpm.flange, inertiaLoad.flange_a)
    annotation (Line(points={{0,-40},{50,-40}}));
  connect(gain.u, speedSensor.w)
    annotation (Line(points={{40,18},{40,11}},      color={0,0,127}));
  connect(limiter.u, gain.y)
    annotation (Line(points={{40,48},{40,41}}, color={0,0,127}));
  connect(limiter.y, ac2dc.u)
    annotation (Line(points={{40,71},{40,80},{22,80}}, color={0,0,127}));
  connect(ac2dc.y, variableResistor.R)
    annotation (Line(points={{-1,80},{-10,80},{-10,72}}, color={0,0,127}));
  connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
        points={{-50,-10},{-48,-10},{-40,-10}}, color={0,0,255}));
  connect(voltageQuasiRMSSensor.plug_p, currentQuasiRMSSensor.plug_n)
    annotation (Line(points={{-20,-10},{-20,-10},{-10,-10}}, color={0,0,
          255}));
  connect(smpm.flange, speedSensor.flange)
    annotation (Line(points={{0,-40},{40,-40},{40,-10}}));
  connect(terminalBox.starpoint, starM.pin_n) annotation (Line(points={{-20,-28},{-20,-28},{-70,-28},{-70,-10}},
                                          color={0,0,255}));
  connect(ground.p, variableResistor.n)
    annotation (Line(points={{-70,60},{-46,60},{-20,60}}, color={0,0,255}));
  connect(ground.p, grounding.n)
    annotation (Line(points={{-70,60},{-70,60},{-70,40}}, color={0,0,255}));
  connect(starM.pin_n, grounding.p)
    annotation (Line(points={{-70,-10},{-70,5},{-70,20}}, color={0,0,255}));
  annotation (experiment(StopTime=0.8, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>
A synchronous machine with permanent magnets starts braking from nominal speed by feeding a diode bridge,
which in turn feeds a braking resistor.
Since induced voltage is reduced proportional to falling speed, the braking resistance is set proportional to speed to
achieve constant current and torque.</p>

<p>Default machine parameters are used.</p>
</html>"));
end SMPM_Braking;
