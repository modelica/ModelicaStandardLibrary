within ModelicaTest.Electrical;
package Machines
  extends Modelica.Icons.ExamplesPackage;
  model SMPM_VoltageSourceWithLosses
    "Test example: PermanentMagnetSynchronousInductionMachine fed by FOC"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    constant Integer m=3 "Number of phases";
    parameter Modelica.SIunits.Current Idq[2]={-53.5, 84.6}
      "Desired d- and q-current";
    parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p
      "Nominal speed";
    parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
    parameter Modelica.SIunits.Inertia JLoad=0.29
      "Load's moment of inertia";
    Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
      smpm(
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
      wMechanical(
        start=-157.07963267949,
        fixed=true,
        displayUnit="rpm"),
      TrOperational=293.15,
      alpha20r=smpmData.alpha20r)
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

    Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
        final m=m) annotation (Placement(transformation(
          origin={-10,50},
          extent={{10,10},{-10,-10}},
          rotation=270)));
    Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
        Placement(transformation(extent={{-50,80},{-70,100}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
          transformation(
          origin={-90,90},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Blocks.Sources.Constant iq(k=Idq[2])
      annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
    Modelica.Blocks.Sources.Constant id(k=Idq[1])
      annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
    Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
        terminalConnection="Y")
      annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={10,0})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
      annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(            tau_nominal=-TLoad,
        w_nominal(displayUnit="rad/s") = wNominal,
      TorqueDirection=false)
      annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
    Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor(m=m)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-10,0})));
    Modelica.Electrical.Machines.Utilities.VoltageController voltageController(
      p=smpm.p,
      Ld=smpm.Lssigma + smpm.Lmd,
      Lq=smpm.Lssigma + smpm.Lmq,
      Rs=Modelica.Electrical.Machines.Thermal.convertResistance(
            smpm.Rs,
            smpm.TsRef,
            smpm.alpha20s,
            smpm.TsOperational),
      fsNominal=smpm.fsNominal,
      VsOpenCircuit=smpm.VsOpenCircuit)
      annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
    Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
      annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={40,-60})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={30,0})));
    Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p)
      annotation (Placement(transformation(
          origin={20,-40},
          extent={{-10,10},{10,-10}},
          rotation=270)));
    Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
          transformation(
          origin={-80,-28},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-60,-10})));
    Modelica.Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-30,-10})));
    parameter
      Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
      smpmData(
      useDamperCage=false,
      frictionParameters(PRef=500, power_w=1.5),
      strayLoadParameters(PRef=250, power_w=0.5),
      permanentMagnetLossParameters(PRef=250, power_w=0.9),
      statorCoreParameters(PRef=500))
      annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
    Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
      annotation (Placement(transformation(
          origin={-10,20},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  initial equation
    smpm.is[1:2] = zeros(2);

  equation
    connect(star.pin_n, ground.p)
      annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
    connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
        points={{-16,-30},{-16,-30}}, color={0,0,255}));
    connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
        points={{-4,-30},{-4,-30}}, color={0,0,255}));
    connect(quadraticSpeedDependentTorque.flange, inertiaLoad.flange_b)
      annotation (Line(
        points={{80,-40},{70,-40}}));
    connect(smpm.flange, angleSensor.flange) annotation (Line(
        points={{0,-40},{10,-40},{10,-10}}));
    connect(star.plug_p, signalVoltage.plug_n) annotation (Line(
        points={{-50,90},{-10,90},{-10,60}}, color={0,0,255}));
    connect(currentSensor.plug_n, terminalBox.plugSupply) annotation (Line(
        points={{-10,-10},{-10,-28}}, color={0,0,255}));
    connect(id.y, voltageController.id_rms) annotation (Line(
        points={{-69,70},{-60,70},{-60,56},{-52,56}}, color={0,0,127}));
    connect(iq.y, voltageController.iq_rms) annotation (Line(
        points={{-69,30},{-60,30},{-60,44},{-52,44}}, color={0,0,127}));
    connect(angleSensor.phi, voltageController.phi) annotation (Line(
        points={{10,11},{10,34},{-34,34},{-34,38}}, color={0,0,127}));
    connect(voltageController.y, signalVoltage.v) annotation (Line(
        points={{-29,50},{-17,50}}, color={0,0,127}));
    connect(currentSensor.i, voltageController.iActual) annotation (Line(
        points={{-21,1.9984e-015},{-46,1.9984e-015},{-46,38}}, color={0,0,127}));
    connect(inertiaLoad.flange_a, torqueSensor.flange_b) annotation (Line(
        points={{50,-40},{50,-60}}));
    connect(torqueSensor.flange_a, smpm.flange) annotation (Line(
        points={{30,-60},{30,-40},{0,-40}}));
    connect(speedSensor.flange, smpm.flange) annotation (Line(
        points={{30,-10},{30,-40},{0,-40}}));
    connect(rotorDisplacementAngle.flange, smpm.flange) annotation (Line(
        points={{10,-40},{0,-40}}));
    connect(rotorDisplacementAngle.plug_p, smpm.plug_sp) annotation (Line(
        points={{14,-30},{-4,-30}}, color={0,0,255}));
    connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
        points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
    connect(voltageQuasiRMSSensor.plug_p, currentSensor.plug_n) annotation (
       Line(
        points={{-20,-10},{-10,-10}}, color={0,0,255}));
    connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
        points={{-50,-10},{-40,-10}}, color={0,0,255}));
    connect(groundM.p, starM.pin_n) annotation (Line(
        points={{-70,-28},{-70,-10}}, color={0,0,255}));
    connect(currentQuasiRMSSensor.plug_n, currentSensor.plug_p) annotation (
       Line(
        points={{-10,10},{-10,10}}, color={0,0,255}));
    connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
       Line(
        points={{-10,40},{-10,30}}, color={0,0,255}));
    annotation (experiment(StopTime=2.0, Interval=0.001), Documentation(
          info="<html>
<p>
A synchronous induction machine with permanent magnets accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are controlled by the voltageController,
and the output voltages fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.</p>
<p>
Default machine parameters of model <a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a> are used.
</p>
</html>"));
  end SMPM_VoltageSourceWithLosses;
end Machines;
