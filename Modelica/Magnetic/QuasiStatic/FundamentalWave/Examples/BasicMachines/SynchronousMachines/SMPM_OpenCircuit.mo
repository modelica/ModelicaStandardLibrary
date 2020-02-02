within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMPM_OpenCircuit
  "Test example: PermanentMagnetSynchronousMachine with inverter"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  output SI.Voltage Vtr=potentialSensor.phi[1]
    "Transient voltage";
  output SI.Voltage Vqs=potentialSensorQS.abs_v[1]
    "QS voltage";
  FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpmQS(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    TsRef=smpmData.TsRef,
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    phiMechanical(start=0),
    m=m,
    Rs=smpmData.Rs*m/3,
    Lssigma=smpmData.Lssigma*m/3,
    Lmd=smpmData.Lmd*m/3,
    Lmq=smpmData.Lmq*m/3,
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    alpha20r=smpmData.alpha20r,
    TrOperational=293.15) annotation (Placement(transformation(extent={
            {-10,20},{10,40}})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
    useSupport=false,
    w_fixed(displayUnit="rad/s") = 2*pi*smpmData.fsNominal/smpmData.p,
    phi(start=0, fixed=true)) annotation (Placement(transformation(
          extent={{80,-10},{60,10}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false) "Synchronous machine data"
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,50})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,50})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PotentialSensor
    potentialSensorQS(m=m)
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    TsRef=smpmData.TsRef,
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    m=m,
    Rs=smpmData.Rs*m/3,
    Lssigma=smpmData.Lssigma*m/3,
    Lszero=smpmData.Lszero*m/3,
    Lmd=smpmData.Lmd*m/3,
    Lmq=smpmData.Lmq*m/3,
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    alpha20r=smpmData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));

  Modelica.Electrical.Polyphase.Basic.Star star(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,-20})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-20})));
  Modelica.Electrical.Polyphase.Sensors.PotentialSensor
    potentialSensor(m=m)
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor
    resistorQS(m=m, R_ref=fill(1e6*m/3, m))
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
equation
  connect(starQS.plug_p, smpmQS.plug_sn) annotation (Line(
      points={{-10,50},{-10,40},{-6,40}},
      color={85,170,255}));
  connect(groundQS.pin, starQS.pin_n) annotation (Line(
      points={{-40,50},{-30,50}},
      color={85,170,255}));
  connect(potentialSensorQS.plug_p, smpmQS.plug_sp) annotation (Line(
      points={{10,50},{10,40},{6,40}},
      color={85,170,255}));
  connect(constantSpeed.flange, smpm.flange) annotation (Line(
      points={{60,0},{50,0},{50,-40},{10,-40}}));
  connect(constantSpeed.flange, smpmQS.flange) annotation (Line(
      points={{60,0},{50,0},{50,30},{10,30}}));
  connect(ground.p, star.pin_n) annotation (Line(
      points={{-40,-20},{-30,-20}},
      color={0,0,255}));
  connect(star.plug_p, smpm.plug_sn) annotation (Line(
      points={{-10,-20},{-10,-30},{-6,-30}},
      color={0,0,255}));
  connect(potentialSensor.plug_p, smpm.plug_sp) annotation (Line(
      points={{10,-20},{10,-30},{6,-30}},
      color={0,0,255}));
  connect(resistorQS.plug_p, smpmQS.plug_sn) annotation (Line(
      points={{-10,60},{-10,40},{-6,40}},
      color={85,170,255}));
  connect(resistorQS.plug_n, smpmQS.plug_sp) annotation (Line(
      points={{10,60},{10,40},{6,40}},
      color={85,170,255}));
  annotation (
    experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6),
    Documentation(info="<html>
<p>
This example compares a time transient and a quasi-static model of a permanent magnet synchronous machine.
The machines are operated at constant mechanical angular velocity.</p>

<p>
Simulate for 0.1 second and plot (versus time):
</p>

<ul>
<li><code>potentialSenor.phi|potentialSensorQS.abs_y[1]</code>: potential of terminal</li>
</ul>

<h5>Note</h5>
<p>The resistors connected to the terminals of the windings of the quasi-static machine model are necessary to numerically stabilize the simulation.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-100,8},{-20,0}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),               Text(
                  extent={{-100,-92},{-20,-100}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
                  textString="%m phase transient")}));
end SMPM_OpenCircuit;
