within ModelicaTest.Electrical;
package Machines
  extends Modelica.Icons.ExamplesPackage;
  model SMPM_VoltageSourceWithLosses
    "Test example: PermanentMagnetSynchronousMachine fed by FOC"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    constant Integer m=3 "Number of phases";
    parameter SI.Current Idq[2]={-53.5, 84.6}
      "Desired d- and q-current";
    parameter SI.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p
      "Nominal speed";
    parameter SI.Torque TLoad=181.4 "Nominal load torque";
    parameter SI.Inertia JLoad=0.29
      "Load's moment of inertia";
    Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet
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

    Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage(
        final m=m) annotation (Placement(transformation(
          origin={-10,50},
          extent={{10,10},{-10,-10}},
          rotation=270)));
    Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
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
    Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor(m=m)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-10,0})));
    Modelica.Electrical.Machines.Utilities.DQCurrentController dqCurrentController(
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
    Modelica.Electrical.Polyphase.Basic.Star starM(final m=m) annotation (
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
    connect(id.y, dqCurrentController.id) annotation (Line(
        points={{-69,70},{-60,70},{-60,56},{-52,56}}, color={0,0,127}));
    connect(iq.y, dqCurrentController.iq) annotation (Line(
        points={{-69,30},{-60,30},{-60,44},{-52,44}}, color={0,0,127}));
    connect(angleSensor.phi, dqCurrentController.phi) annotation (Line(
        points={{10,11},{10,34},{-34,34},{-34,38}}, color={0,0,127}));
    connect(dqCurrentController.y, signalVoltage.v) annotation (Line(
        points={{-29,50},{-17,50}}, color={0,0,127}));
    connect(currentSensor.i, dqCurrentController.iActual) annotation (Line(
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
A synchronous machine with permanent magnets accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are controlled by the dqCurrentController,
and the output voltages fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.</p>
<p>
Default machine parameters of model <a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a> are used.
</p>
</html>"));
  end SMPM_VoltageSourceWithLosses;

  model DCPM_CurrentControlled "Current controlled DCPM drive"
    extends Modelica.Icons.Example;
    parameter ModelicaTest.Electrical.Machines.DCPM_Utilities.DriveData driveData(
      redeclare ModelicaTest.Electrical.Machines.DCPM_Utilities.M48V machineData)
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
    ModelicaTest.Electrical.Machines.DCPM_Utilities.DCPM dcpm(
      machineData=driveData.machineData,
      iA(fixed=true),
      phi(fixed=true),
      w(fixed=true))
      annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={10,-50})));
    Modelica.Blocks.Sources.Step iRef(
      height=driveData.machineData.IANominal,
      offset=0,
      startTime=0.1)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(
      J=driveData.JL,
      phi(fixed=false),
      w(fixed=false))
      annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque torqueLoad(
      tau_nominal=-driveData.machineData.tauNominal,
      TorqueDirection=false,
      w_nominal=driveData.machineData.wNominal)
      annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
    Modelica.Electrical.Analog.Sources.SignalVoltage voltageSource
      annotation (Placement(transformation(extent={{40,-20},{20,0}})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-30})));
    Modelica.Blocks.Continuous.FirstOrder deadTime(
      k=1,
      T=driveData.Td,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={30,20})));
    Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI currentController(
      k=driveData.controllerData.kpI,
      Ti=driveData.controllerData.TiI,
      useFF=true,
      KFF=driveData.machineData.kPhi,
      yMax=driveData.VBat,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      x_start=0,
      y_start=0) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  equation
    connect(dcpm.shaft, inertiaLoad.flange_a)
      annotation (Line(points={{40,-70},{50,-70}}, color={0,0,0}));
    connect(torqueLoad.flange, inertiaLoad.flange_b)
      annotation (Line(points={{80,-70},{70,-70}}, color={0,0,0}));
    connect(ground.p,dcpm. pin_n)
      annotation (Line(points={{20,-50},{24,-50},{24,-60}},  color={0,0,255}));
    connect(ground.p, currentSensor.p)
      annotation (Line(points={{20,-50},{20,-40}}, color={0,0,255}));
    connect(currentSensor.n,voltageSource. n)
      annotation (Line(points={{20,-20},{20,-10}}, color={0,0,255}));
    connect(voltageSource.p,dcpm. pin_p)
      annotation (Line(points={{40,-10},{40,-50},{36,-50},{36,-60}}, color={0,0,255}));
    connect(deadTime.y, voltageSource.v)
      annotation (Line(points={{30,9},{30,2}}, color={0,0,127}));
    connect(iRef.y, currentController.u)
      annotation (Line(points={{-19,40},{-12,40}}, color={0,0,127}));
    connect(currentSensor.i, currentController.u_m)
      annotation (Line(points={{9,-30},{-6,-30},{-6,28}}, color={0,0,127}));
    connect(dcpm.w, currentController.feedForward)
      annotation (Line(points={{19,-70},{0,-70},{0,28}}, color={0,0,127}));
    connect(currentController.y, deadTime.u)
      annotation (Line(points={{11,40},{30,40},{30,32}}, color={0,0,127}));
    annotation (experiment(
        StopTime=1,
        Interval=0.0001,
        Tolerance=1e-06), Documentation(info="<html>
<p>
Simulates a current controlled DCPM machine. The load applies a linearly speed dependent torque, which in the end causes the drive to operate in nominal operation.
</p>
<p>
Additionally, the handling of parameter records can be tested:
By simply redeclaring the machine parameter record instantiated in the drive parameter record, a machine with different parameters can be simulated.
</p>
</html>"));
  end DCPM_CurrentControlled;

  model DCPM_SpeedControlled "Speed controlled DCPM drive"
    extends Modelica.Icons.Example;
    parameter ModelicaTest.Electrical.Machines.DCPM_Utilities.DriveData driveData(
      redeclare ModelicaTest.Electrical.Machines.DCPM_Utilities.M48V machineData)
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
    ModelicaTest.Electrical.Machines.DCPM_Utilities.DCPM dcpm(
      machineData=driveData.machineData,
      iA(fixed=true),
      phi(fixed=true),
      w(fixed=true))
      annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={10,-50})));
    Modelica.Blocks.Sources.Step wRef(
      height=driveData.machineData.wNominal,
      offset=0,
      startTime=0.1)
      annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(
      J=driveData.JL,
      phi(fixed=false),
      w(fixed=false))
      annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueLoad(
      stepTorque=-driveData.machineData.tauNominal,
      offsetTorque=0,
      startTime=0.7)
      annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
    Modelica.Electrical.Analog.Sources.SignalVoltage voltageSource
      annotation (Placement(transformation(extent={{40,-20},{20,0}})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-30})));
    Modelica.Blocks.Continuous.FirstOrder deadTime(
      k=1,
      T=driveData.Td,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={30,20})));
    Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI currentController(
      k=driveData.controllerData.kpI,
      Ti=driveData.controllerData.TiI,
      useFF=true,
      KFF=driveData.machineData.kPhi,
      yMax=driveData.VBat,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      x_start=0,
      y_start=0) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
    Modelica.Blocks.Continuous.FirstOrder preFilter(
      k=1,
      T=driveData.controllerData.Tiw,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI
      speedController(
      k=driveData.controllerData.kpw/driveData.machineData.kPhi,
      Ti=driveData.controllerData.Tiw,
      useFF=false,
      yMax=driveData.IMax,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      x_start=0,
      y_start=0)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  equation
    connect(dcpm.shaft, inertiaLoad.flange_a)
      annotation (Line(points={{40,-70},{50,-70}}, color={0,0,0}));
    connect(torqueLoad.flange, inertiaLoad.flange_b)
      annotation (Line(points={{80,-70},{70,-70}}, color={0,0,0}));
    connect(ground.p,dcpm. pin_n)
      annotation (Line(points={{20,-50},{24,-50},{24,-60}},  color={0,0,255}));
    connect(ground.p, currentSensor.p)
      annotation (Line(points={{20,-50},{20,-40}}, color={0,0,255}));
    connect(currentSensor.n,voltageSource. n)
      annotation (Line(points={{20,-20},{20,-10}}, color={0,0,255}));
    connect(voltageSource.p,dcpm. pin_p)
      annotation (Line(points={{40,-10},{40,-50},{36,-50},{36,-60}}, color={0,0,255}));
    connect(deadTime.y, voltageSource.v)
      annotation (Line(points={{30,9},{30,2}}, color={0,0,127}));
    connect(currentSensor.i, currentController.u_m)
      annotation (Line(points={{9,-30},{-6,-30},{-6,28}}, color={0,0,127}));
    connect(dcpm.w, currentController.feedForward)
      annotation (Line(points={{19,-70},{0,-70},{0,28}}, color={0,0,127}));
    connect(wRef.y, preFilter.u)
      annotation (Line(points={{-79,40},{-72,40}}, color={0,0,127}));
    connect(currentController.y, deadTime.u)
      annotation (Line(points={{11,40},{30,40},{30,32}}, color={0,0,127}));
    connect(preFilter.y, speedController.u)
      annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
    connect(speedController.y, currentController.u)
      annotation (Line(points={{-19,40},{-12,40}}, color={0,0,127}));
    connect(dcpm.w, speedController.u_m)
      annotation (Line(points={{19,-70},{-36,-70},{-36,28}}, color={0,0,127}));
    annotation (experiment(
        StopTime=1,
        Interval=0.0001,
        Tolerance=1e-06), Documentation(info="<html>
<p>
Simulates a speed controlled DCPM machine. The load applies a torque step, which in the end causes the drive to operate in nominal operation.
</p>
<p>
Additionally, the handling of parameter records can be tested:
By simply redeclaring the machine parameter record instantiated in the drive parameter record, a machine with different parameters can be simulated.
</p>
</html>"));
  end DCPM_SpeedControlled;

  package DCPM_Utilities "Utilities for DC_Drives"
    extends Modelica.Icons.UtilitiesPackage;
    model DCPM "Simple DC PM model"
      extends Modelica.Electrical.Machines.Icons.Machine;
      parameter MachineData machineData
        annotation (Placement(transformation(extent={{60,40},{80,60}})));
      output Modelica.Units.SI.Current iA(start=0) = resistor.i
        "Armature current";
      output Modelica.Units.SI.Angle phi(start=0) = shaft.phi "Shaft angle";
      Modelica.Blocks.Interfaces.RealOutput w(start=0, unit="rad/s", displayUnit="1/min")
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-110,0})));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive armature pin"
        annotation (Placement(transformation(extent={{50,90},{70,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative armature pin"
        annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft "Shaft"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=machineData.RA,
          T_ref=293.15)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,60})));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L=machineData.LA)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,30})));
      Modelica.Electrical.Analog.Basic.RotationalEMF emf(k=machineData.kPhi)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,0})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia(J=machineData.J)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,-30})));
    equation
      connect(resistor.n, inductor.p)
        annotation (Line(points={{-1.77636e-15,50},{0,50},{0,40},{0,40}},color={0,0,255}));
      connect(inductor.n, emf.p)
        annotation (Line(points={{-1.77636e-15,20},{0,20},{0,10}},color={0,0,255}));
      connect(emf.flange, inertia.flange_a)
        annotation (Line(points={{10,0},{40,0}}, color={0,0,0}));
      connect(resistor.p, pin_p)
        annotation (Line(points={{0,70},{0,80},{60,80},{60,100}}, color={0,0,255}));
      connect(emf.n, pin_n)
        annotation (Line(points={{0,-10},{0,-20},{-60,-20},{-60,100}}, color={0,0,255}));
      connect(inertia.flange_b, shaft)
        annotation (Line(points={{60,0},{100,0}}, color={0,0,0}));
      connect(inertia.flange_b, speedSensor.flange)
        annotation (Line(points={{60,0},{80,0},{80,-20}}, color={0,0,0}));
      connect(speedSensor.w, w)
        annotation (Line(points={{80,-41},{80,-60},{-80,-60}, {-80,0},{-110,0}}, color={0,0,127}));
      annotation (
        Icon(graphics={Text(
              extent={{-100,-100},{100,-140}},
              textColor={28,108,200},
              textString="%name")}), Documentation(info="<html>
<p>
Simple model of a DC PM machine, comprising armature resistance, armature inductance, emf (including torque generation), inertia and speed measurement.
</p>
</html>"));
    end DCPM;

    record DriveData "Parameters of the whole drive"
      extends Modelica.Icons.Record;
      import Modelica.Constants.pi;
      replaceable parameter
        ModelicaTest.Electrical.Machines.DCPM_Utilities.MachineData machineData
        annotation (choicesAllMatching=true, Placement(transformation(extent={{
                -10,40},{10,60}})));

      parameter ControllerData controllerData(
        kpI=machineData.LA/(2*Td),
        TiI=machineData.LA/machineData.RA,
        Tsub=2*Td,
        kpw=(machineData.J + JL)/(2*controllerData.Tsub),
        Tiw=4*controllerData.Tsub)
        annotation (Placement(transformation(extent={{-10,0},{10,20}})));
      parameter Modelica.Units.SI.Inertia JL=machineData.J "Load inertia";
      parameter Modelica.Units.SI.Voltage VBat=1.2*machineData.VANominal
        "Battery voltage";
      parameter Modelica.Units.SI.Current IMax=1.5*machineData.IANominal
        "Max. armature current";
      parameter Modelica.Units.SI.Frequency fSwitch=1e3 "Switching frequency";
      parameter Modelica.Units.SI.Time Td=0.5/fSwitch "Dead time of inverter"
        annotation (Dialog(enable=false));
      annotation(defaultComponentPrefixes="parameter", defaultComponentName="driveData",
        Documentation(info="<html>
<p>
The drive parameter record contains the machine parameter record, additional parameters and fills the controller parameter record.
Simulating another machine (with different parameters), the machine parameter record can be redeclared.
</p>
</html>"));
    end DriveData;

    record ControllerData "Controller parameters"
      extends Modelica.Icons.Record;
      parameter Real kpI "Proportional gain of current controller";
      parameter Modelica.Units.SI.Time TiI
        "Integral time constant of current controller";
      parameter Modelica.Units.SI.Time Tsub "Substitute time constant";
      parameter Real kpw "Porportional gain of speed controller";
      parameter Modelica.Units.SI.Time Tiw
        "Integral time constant of speed controller";
      annotation(defaultComponentPrefixes="parameter", defaultComponentName="controllerData",
        Documentation(info="<html>
<p>
The controller parameter record is used in the drive parameters record, and filled in that record (based on the machine parameters).
</p>
</html>"));
    end ControllerData;

    record MachineData "Standard machine parameters"
      extends Modelica.Icons.Record;
      import Modelica.Constants.pi;
      parameter Modelica.Units.SI.Voltage VANominal=100
        "Nominal armature voltage";
      parameter Modelica.Units.SI.Current IANominal=100
        "Nominal armature current";
      parameter Modelica.Units.SI.AngularVelocity wNominal=1425*pi/30
        "Nominal speed";
      parameter Modelica.Units.SI.Resistance RA=0.05 "Armature resistance";
      parameter Modelica.Units.SI.Inductance LA=0.0015 "Armature inductance";
      parameter Modelica.Units.SI.Voltage ViNominal=VANominal - RA*IANominal
        "Nominal induced voltage" annotation (Dialog(enable=false));
      parameter Modelica.Units.SI.ElectricalTorqueConstant kPhi=ViNominal/
          wNominal "Flux constant";
      parameter Modelica.Units.SI.Inertia J=0.29 "Rotor inertia";
      parameter Modelica.Units.SI.Torque tauNominal=kPhi*IANominal
        "Nominal torque" annotation (Dialog(enable=false));
      annotation(defaultComponentPrefixes="parameter", defaultComponentName="machineData",
        Documentation(info="<html>
<p>
The machine parameter record contains all necessary parameters of a DC PM machine.
It is used to parameterize the DCPM model, and it is used in the drive parameter record.
Extending from this record, the parameters of other machines (with different parameters) can be saved.
</p>
</html>"));
    end MachineData;

    record M48V "Real machine 48 V"
      import Modelica.Constants.pi;
      extends ModelicaTest.Electrical.Machines.DCPM_Utilities.MachineData(
        VANominal=48,
        IANominal=25,
        wNominal=3500*pi/30,
        RA=0.24,
        LA=0.004,
        J=0.0008);
      annotation(defaultComponentPrefixes="parameter", defaultComponentName="machineData",
        Documentation(info="<html>
<p>
Machine parameters of a real 48 W / 1 kW DCPM machine.
</p>
</html>"));
    end M48V;
  end DCPM_Utilities;
end Machines;
