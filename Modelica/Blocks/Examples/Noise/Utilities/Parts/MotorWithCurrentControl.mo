within Modelica.Blocks.Examples.Noise.Utilities.Parts;
model MotorWithCurrentControl
  "Synchronous machine with current controller and measurement noise"
  extends Modelica.Electrical.Machines.Icons.TransientMachine;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.Frequency f=50 "Actual frequency";
  parameter SI.Time tRamp=1 "Frequency ramp";
  parameter SI.Torque TLoad=181.4 "Nominal load torque";
  parameter SI.Time tStep=1.2 "Time of load torque step";
  parameter SI.Inertia JLoad=0.29 "Load's moment of inertia";

  Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    Lszero=smpmData.Lszero,
    Lssigma=smpmData.Lssigma,
    Jr=smpmData.Jr,    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    wMechanical(fixed=true),
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
    phiMechanical(fixed=true),
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    TrOperational=293.15,
    alpha20r=smpmData.alpha20r)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Electrical.Polyphase.Sources.SignalCurrent signalCurrent(final m=m)
    annotation (Placement(transformation(
        origin={-10,50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m)
    annotation (Placement(transformation(extent={{-10,80},{-30,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(
        origin={-50,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.DQToThreePhase dqToThreePhase(
      p=smpm.p)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Electrical.Polyphase.Basic.Star starM(final m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-10})));
  Modelica.Electrical.Analog.Basic.Ground groundM
    annotation (Placement(transformation(
        origin={-80,-28},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y") annotation (Placement(transformation(extent={{-20,-30},
            {0,-10}})));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p)
    annotation (Placement(transformation(
        origin={20,-40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,0})));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={50,-40})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,0})));
  Modelica.Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,-10})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
    annotation (Placement(transformation(
        origin={-10,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=0.29)
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false) "Data for motor"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Blocks.Sources.Constant id(k=0)
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
  Modelica.Blocks.Interfaces.RealInput iq_rms1 annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}),iconTransformation(extent={{-140,40},
            {-100,80}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange
    "Right flange of shaft"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput phi(unit="rad")
    "Absolute angle of flange as output signal" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={110,80}), iconTransformation(extent={{40,70},{60,90}})));
  output Real phi_motor(unit="rad", displayUnit="deg")=angleSensor.phi
    "Rotational position";
  output Real w(unit="rad/s")=speedSensor.w "Rotational speed";
  Modelica.Blocks.Math.Add addNoise
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  .Modelica.Blocks.Noise.UniformNoise uniformNoise(
    samplePeriod=1/200,
    y_min=-0.01,
    y_max=0.01) annotation (Placement(transformation(extent={{26,76},{46,96}})));
equation
  connect(star.pin_n, ground.p) annotation (Line(points={{-30,90},{-40,90}}, color={0,0,255}));
  connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
        points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
  connect(rotorDisplacementAngle.plug_p, smpm.plug_sp) annotation (Line(
        points={{14,-30},{6,-30},{-4,-30}}, color={0,0,255}));
  connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
      points={{-16,-26},{-16,-30}}, color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
      points={{-4,-26},{-4,-30}}, color={0,0,255}));
  connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(
      points={{0,-40},{6,-40},{10,-40}}));
  connect(signalCurrent.plug_p, star.plug_p) annotation (Line(
      points={{-10,60},{-10,90}}, color={0,0,255}));
  connect(angleSensor.flange, rotorDisplacementAngle.flange) annotation (Line(
      points={{10,-10},{10,-40}}));
  connect(angleSensor.phi, dqToThreePhase.phi) annotation (Line(points={{10,11},
          {10,30},{-40,30},{-40,38}},          color={0,0,127}));
  connect(groundM.p, terminalBox.starpoint) annotation (Line(
      points={{-70,-28},{-20,-28},{-20,-24}}, color={0,0,255}));
  connect(smpm.flange, torqueSensor.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply) annotation (
      Line(
      points={{-20,-10},{-10,-10},{-10,-24}}, color={0,0,255}));
  connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
      points={{-50,-10},{-40,-10}}, color={0,0,255}));
  connect(starM.pin_n, groundM.p) annotation (Line(
      points={{-70,-10},{-70,-28}}, color={0,0,255}));
  connect(dqToThreePhase.y, signalCurrent.i) annotation (Line(points={{
          -29,50},{-22,50},{-22,50}}, color={0,0,127}));
  connect(speedSensor.flange, smpm.flange) annotation (Line(
      points={{30,-10},{30,-40},{0,-40}}));
  connect(torqueSensor.flange_b, inertiaLoad.flange_a) annotation (Line(
      points={{60,-40},{60,-40},{70,-40}}));
  connect(signalCurrent.plug_n, currentQuasiRMSSensor.plug_p) annotation (
     Line(
      points={{-10,40},{-10,10}}, color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, voltageQuasiRMSSensor.plug_p)
    annotation (Line(
      points={{-10,-10},{-20,-10}}, color={0,0,255}));
  connect(inertiaLoad.flange_b, flange) annotation (Line(
      points={{90,-40},{90,-40},{90,0},{100,0}}));
  connect(angleSensor.phi, addNoise.u2) annotation (Line(
      points={{10,11},{10,30},{50,30},{50,74},{58,74}}, color={0,0,127}));
  connect(addNoise.y, phi) annotation (Line(
      points={{81,80},{110,80}}, color={0,0,127}));
  connect(uniformNoise.y, addNoise.u1) annotation (Line(
      points={{47,86},{58,86}}, color={0,0,127}));
  connect(id.y, dqToThreePhase.d) annotation (Line(points={{-69,70},{-60,
          70},{-60,56},{-52,56}}, color={0,0,127}));
  connect(iq_rms1, dqToThreePhase.q) annotation (Line(points={{-120,60},
          {-100,60},{-100,44},{-52,44}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
A synchronous machine with permanent magnets, current controller and
measurement noise of &plusmn;0.01 rad accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are converted to three-phase currents,
and fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.
</p>

<p>
Default machine parameters of model
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a>
are used.
</p>

<p>
This motor is used in the
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.ActuatorWithNoise\">Examples.NoiseExamples.ActuatorWithNoise</a>
actuator example
</p>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"),
   Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{40,50},{-100,100}},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None), Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        textColor={0,0,255})}));
end MotorWithCurrentControl;
