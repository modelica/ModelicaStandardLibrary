within Modelica.Electrical;


package Machines "Library for electric machines"
  extends Modelica.Icons.Library2;

  package Examples "Test examples"
    extends Modelica.Icons.Library2;

    model AIMC_DOL
      "Test example 1: AsynchronousInductionMachineSquirrelCage direct-on-line"
      extends Modelica.Icons.Example2;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
      parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
      parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
      parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="1/min")=1440.45*2*Modelica.Constants.pi/60
        "Nominal load speed";
      parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";
      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
        aimc
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
        annotation (Placement(transformation(
            origin={0,0},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
        final m=m,
        freqHz=fill(fNominal, m),
        V=fill(sqrt(2/3)*VNominal, m))
        annotation (Placement(transformation(
            origin={0,60},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-50,80},{-70,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-90,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tStart1)
        annotation (Placement(transformation(extent={{-80,30},{-60,50}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(final m=m)
        annotation (Placement(transformation(
            origin={0,30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
        quadraticLoadTorque(
        w_nominal=wLoad,
        TorqueDirection=false,
        tau_nominal=-TLoad,
        useSupport=false)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}},
              rotation=0)));
      Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}},
              rotation=0)));
    equation
      connect(star.pin_n, ground.p)
        annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
      connect(sineVoltage.plug_n, star.plug_p)
        annotation (Line(points={{1.83697e-015,70},{1.83697e-015,90},{-50,90}},
            color={0,0,255}));
      connect(sineVoltage.plug_p, idealCloser.plug_p)
        annotation (Line(points={{-1.83697e-015,50},{0,48},{1.22461e-015,46},{
              1.83697e-015,46},{1.83697e-015,40}}, color={0,0,255}));
      connect(booleanStep.y, idealCloser.control)   annotation (Line(points={{
              -59,40},{-20,40},{-20,30},{-7,30}}, color={255,0,255}));
      connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p)
                                                             annotation (Line(
          points={{-1.83697e-015,20},{-1.83697e-015,17},{1.83697e-015,17},{
              1.83697e-015,10}},
          color={0,0,255}));
      connect(terminalBox.plug_sn, aimc.plug_sn)   annotation (Line(
          points={{-16,-30},{-16,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sp, aimc.plug_sp)   annotation (Line(
          points={{-4,-30},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
                                                                 annotation (Line(
          points={{-10,-28},{-10,-20},{-1.83697e-015,-20},{-1.83697e-015,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (
          Line(
          points={{60,-40},{70,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(aimc.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=1.5, Interval=0.001),
        Documentation(info="<HTML>
<b>1st Test example: Asynchronous induction machine with squirrel cage - direct on line starting</b><br>
At start time tStart three phase voltage is supplied to the asynchronous induction machine with squirrel cage;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <i>AIM_SquirrelCage</i> are used.
</HTML>"));
    end AIMC_DOL;

    model AIMC_YD
      "Test example 2a: AsynchronousInductionMachineSquirrelCage Y-D"
      extends Modelica.Icons.Example2;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
      parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
      parameter Modelica.SIunits.Time tStart2=2.0 "Start time from Y to D";
      parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
      parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="1/min")=1440.45*2*Modelica.Constants.pi/60
        "Nominal load speed";
      parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";
      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
        aimc
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
        annotation (Placement(transformation(
            origin={0,0},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
        final m=m,
        freqHz=fill(fNominal, m),
        V=fill(sqrt(2/3)*VNominal, m))
        annotation (Placement(transformation(
            origin={0,60},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-50,80},{-70,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-90,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tStart1)
        annotation (Placement(transformation(extent={{-80,30},{-60,50}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m)
        annotation (Placement(transformation(
            origin={0,30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Machines.Utilities.SwitchYD switchYD  annotation (Placement(
            transformation(extent={{-20,-30},{0,-10}}, rotation=0)));
      Modelica.Blocks.Sources.BooleanStep booleanStepYD[m](each startTime=
            tStart2)
        annotation (Placement(transformation(extent={{-80,-30},{-60,-10}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
        quadraticLoadTorque(
        w_nominal=wLoad,
        TorqueDirection=false,
        tau_nominal=-TLoad,
        useSupport=false)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}},
              rotation=0)));
    equation
      connect(star.pin_n, ground.p)
        annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
      connect(sineVoltage.plug_n, star.plug_p)
        annotation (Line(points={{1.83697e-015,70},{1.83697e-015,90},{-50,90}},
            color={0,0,255}));
      connect(sineVoltage.plug_p, idealCloser.plug_p)
        annotation (Line(points={{-1.83697e-015,50},{0,48},{1.22461e-015,46},{
              1.83697e-015,46},{1.83697e-015,40}}, color={0,0,255}));
      connect(loadInertia.flange_b, quadraticLoadTorque.flange)
        annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
      connect(booleanStep.y, idealCloser.control)   annotation (Line(points={{
              -59,40},{-20,40},{-20,30},{-7,30}}, color={255,0,255}));
      connect(booleanStepYD.y, switchYD.control) annotation (Line(points={{-59,
              -20},{-21,-20}}, color={255,0,255}));
      connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p)
                                                             annotation (Line(
          points={{-1.83697e-015,20},{-1.83697e-015,18},{1.83697e-015,18},{
              1.83697e-015,10}},
          color={0,0,255}));
      connect(switchYD.plug_sn, aimc.plug_sn)   annotation (Line(
          points={{-16,-30},{-16,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(switchYD.plug_sp, aimc.plug_sp)   annotation (Line(
          points={{-4,-30},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(switchYD.plugSupply, currentQuasiRMSSensor.plug_n)
                                                              annotation (Line(
          points={{-10,-10},{-1.83697e-015,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(aimc.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=2.5, Interval=0.001),
        Documentation(info="<HTML>
<b>2nd/a Test example: Asynchronous induction machine with squirrel cage - Y-D starting</b><br>
At start time tStart three phase voltage is supplied to the asynchronous induction machine with squirrel cage, first star-connected, then delta-connetced; the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 2.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <i>AIM_SquirrelCage</i> are used.
</HTML>"));
    end AIMC_YD;

    model AIMC_Transformer
      "Test example 2b: AsynchronousInductionMachineSquirrelCage transformer starting"
      extends Modelica.Icons.Example2;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
      parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
      parameter Modelica.SIunits.Time tStart2=2.0
        "Start time of bypass transformer";
      parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
      parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="1/min")=1440.45*2*Modelica.Constants.pi/60
        "Nominal load speed";
      parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";
      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
        aimc
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
        annotation (Placement(transformation(
            origin={0,80},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
        final m=m,
        freqHz=fill(fNominal, m),
        V=fill(sqrt(2/3)*VNominal, m))
        annotation (Placement(transformation(
            origin={-30,90},
            extent={{10,10},{-10,-10}},
            rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-50,80},{-70,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-90,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.BooleanStep booleanStep1[m](each startTime=tStart1)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(final m=m)
        annotation (Placement(transformation(
            origin={0,50},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Machines.BasicMachines.Transformers.Yy.Yy00 transformer(
        n=transformerData.n,
        R1=transformerData.R1,
        L1sigma=transformerData.L1sigma,
        R2=transformerData.R2,
        L2sigma=transformerData.L2sigma) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-20,30})));
      Modelica.Electrical.Analog.Basic.Ground ground2
        annotation (Placement(transformation(
            origin={-50,20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.Utilities.TransformerData transformerData(
        f=fNominal,
        V1=VNominal,
        C1=Modelica.Utilities.Strings.substring(
            transformer.VectorGroup, 1, 1),
        V2=VNominal/sqrt(3),
        C2=Modelica.Utilities.Strings.substring(
            transformer.VectorGroup, 2, 2),
        SNominal=50E3,
        v_sc=0.06,
        P_sc=500)    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica.Blocks.Sources.BooleanStep booleanStep2[m](each startTime=tStart2)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Ideal.IdealCommutingSwitch
        idealCommutingSwitch(final m=m, Goff=fill(5E-4, m))
        annotation (Placement(transformation(
            origin={0,0},
            extent={{10,10},{-10,-10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
        quadraticLoadTorque(
        w_nominal=wLoad,
        TorqueDirection=false,
        tau_nominal=-TLoad,
        useSupport=false)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}},
              rotation=0)));
      Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}},
              rotation=0)));
    equation
      connect(star.pin_n, ground.p)
        annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
      connect(terminalBox.plug_sn, aimc.plug_sn)   annotation (Line(
          points={{-16,-30},{-16,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sp, aimc.plug_sp)   annotation (Line(
          points={{-4,-30},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (
          Line(
          points={{60,-40},{70,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(aimc.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));

      connect(star.plug_p, sineVoltage.plug_n) annotation (Line(
          points={{-50,90},{-40,90}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(booleanStep2.y, idealCommutingSwitch.control)
                                                           annotation (Line(
          points={{-39,0},{-14,0},{-14,1.46958e-015},{-8,1.46958e-015}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(transformer.starpoint2, ground2.p) annotation (Line(
          points={{-30,25},{-30,20},{-40,20}},
          color={0,0,255},
          smooth=Smooth.None));

      connect(idealCommutingSwitch.plug_p, terminalBox.plugSupply)  annotation (
          Line(
          points={{-1.83697e-015,-10},{-10,-10},{-10,-28}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(transformer.plug2, idealCommutingSwitch.plug_n1) annotation (Line(
          points={{-20,20},{-5,20},{-5,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (Line(
          points={{-20,90},{1.83697e-015,90}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(booleanStep1.y, idealCloser.control) annotation (Line(
          points={{-39,50},{-7,50}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(currentQuasiRMSSensor.plug_n, idealCloser.plug_p) annotation (Line(
          points={{-1.83697e-015,70},{-1.83697e-015,65},{1.83697e-015,65},{
              1.83697e-015,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(transformer.plug1, idealCloser.plug_n) annotation (Line(
          points={{-20,40},{-1.83697e-015,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(idealCloser.plug_n, idealCommutingSwitch.plug_n2) annotation (Line(
          points={{-1.83697e-015,40},{1.83697e-015,40},{1.83697e-015,10}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}),
                graphics),
        experiment(StopTime=2.5, Interval=0.001),
        Documentation(info="<HTML>
<b>2nd/b Test example: Asynchronous induction machine with squirrel cage - transformer starting</b><br>
At start time tStart1 three phase voltage is supplied to the asynchronous induction machine with squirrel cage via the transformer;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed;
at start time tStart2 the machine is fed directly from the voltage source, finally reaching nominal speed.<br>
Simulate for 2.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <i>AIM_SquirrelCage</i> are used.
</HTML>"));
    end AIMC_Transformer;

    model AIMS_Start "Test example 3: AsynchronousInductionMachineSlipRing"
      extends Modelica.Icons.Example2;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
      parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
      parameter Modelica.SIunits.Resistance Rstart=0.16 "Starting resistance";
      parameter Modelica.SIunits.Time tStart2=1.0
        "Start time of shorting starting resistance";
      parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
      parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="1/min")=1440.45*2*Modelica.Constants.pi/60
        "Nominal load speed";
      parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";

      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing aims
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
        annotation (Placement(transformation(
            origin={0,0},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
        final m=m,
        freqHz=fill(fNominal, m),
        V=fill(sqrt(2/3)*VNominal, m))
        annotation (Placement(transformation(
            origin={0,60},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-50,80},{-70,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-90,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tStart1)
        annotation (Placement(transformation(extent={{-80,30},{-60,50}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m)
        annotation (Placement(transformation(
            origin={0,30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
        quadraticLoadTorque(
        w_nominal=wLoad,
        TorqueDirection=false,
        tau_nominal=-TLoad,
        useSupport=false)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}},
              rotation=0)));
      Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}},
              rotation=0)));
      Machines.Utilities.SwitchedRheostat switchedRheostat(RStart=Rstart, tStart=tStart2)
        annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
    equation
      connect(star.pin_n, ground.p)
        annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
      connect(sineVoltage.plug_n, star.plug_p)
        annotation (Line(points={{1.83697e-015,70},{1.83697e-015,90},{-50,90}},
            color={0,0,255}));
      connect(sineVoltage.plug_p, idealCloser.plug_p)
        annotation (Line(points={{-1.83697e-015,50},{0,48},{1.22461e-015,46},{
              1.83697e-015,46},{1.83697e-015,40}}, color={0,0,255}));
      connect(loadInertia.flange_b, quadraticLoadTorque.flange)
        annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
      connect(booleanStep.y, idealCloser.control)   annotation (Line(points={{
              -59,40},{-20,40},{-20,30},{-7,30}}, color={255,0,255}));
      connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p)
                                                             annotation (Line(
          points={{-1.83697e-015,20},{-1.83697e-015,16},{1.83697e-015,16},{
              1.83697e-015,10}},
          color={0,0,255}));
      connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
                                                                 annotation (Line(
          points={{-10,-28},{-10,-20},{-1.83697e-015,-20},{-1.83697e-015,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sn, aims.plug_sn)   annotation (Line(
          points={{-16,-30},{-16,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sp, aims.plug_sp)   annotation (Line(
          points={{-4,-30},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(aims.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(switchedRheostat.plug_p, aims.plug_rp) annotation (Line(
          points={{-30,-34},{-20,-34}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(switchedRheostat.plug_n, aims.plug_rn) annotation (Line(
          points={{-30,-46},{-20,-46}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=1.5, Interval=0.001),
        Documentation(info="<HTML>
<b>3rd Test example: Asynchronous induction machine with slipring rotor - resistance starting</b><br>
At start time tStart1 three phase voltage is supplied to the asynchronous induction machine with sliprings;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
using a starting resistance. At time tStart2 external rotor resistance is shortened, finally reaching nominal speed.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aims.wMechanical: motor's speed</li>
<li>aims.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <i>AIM_SlipRing</i> are used.
</HTML>"));
    end AIMS_Start;

    model AIMC_Inverter
      "Test example 4: AsynchronousInductionMachineSquirrelCage with inverter"
      extends Modelica.Icons.Example2;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
      parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
      parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
      parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
      parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";

      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
        aimc
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
        annotation (Placement(transformation(
            origin={0,0},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp)
        annotation (Placement(transformation(extent={{-80,50},{-60,70}},
              rotation=0)));
      Machines.Utilities.VfController vfController(
        final m=m,
        VNominal=VNominal,
        fNominal=fNominal) annotation (Placement(transformation(extent={{-40,50},
                {-20,70}}, rotation=0)));
      Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(final m=
            m)
        annotation (Placement(transformation(
            origin={0,60},
            extent={{10,10},{-10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-50,80},{-70,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-90,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
                                                              startTime=tStep,
          stepTorque=-TLoad,
        useSupport=false)
                    annotation (Placement(transformation(extent={{90,-50},{70,
                -30}}, rotation=0)));
      Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
                                         annotation (Placement(transformation(
              extent={{-20,-30},{0,-10}}, rotation=0)));
    equation
      connect(signalVoltage.plug_n, star.plug_p)
        annotation (Line(points={{1.83697e-015,70},{1.83697e-015,90},{-50,90}},
            color={0,0,255}));
      connect(star.pin_n, ground.p)
        annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
      connect(ramp.y, vfController.u)   annotation (Line(points={{-59,60},{-42,
              60}}, color={0,0,255}));
      connect(vfController.y, signalVoltage.v)   annotation (Line(points={{-19,60},
              {-7,60}},     color={0,0,255}));
      connect(loadTorqueStep.flange, loadInertia.flange_b)
        annotation (Line(points={{70,-40},{60,-40}}, color={0,0,0}));
      connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p)
                                                               annotation (Line(
            points={{-1.83697e-015,50},{-1.83697e-015,40},{6.12303e-016,40},{
              6.12303e-016,10},{1.83697e-015,10}}, color={0,0,255}));
      connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
                                                                 annotation (Line(
          points={{-10,-28},{-10,-20},{0,-20},{0,-10},{-1.83697e-015,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sn, aimc.plug_sn)   annotation (Line(
          points={{-16,-30},{-16,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sp, aimc.plug_sp)   annotation (Line(
          points={{-4,-30},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(aimc.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=1.5, Interval=0.001),
        Documentation(info="<HTML>
<b>4th Test example: Asynchronous induction machine with squirrel cage fed by an ideal inverter</b><br>
An ideal frequency inverter is modeled by using a VfController and a threephase SignalVoltage.<br>
Frequency is raised by a ramp, causing the asynchronous induction machine with squirrel cage to start,
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <i>AIM_SquirrelCage</i> are used.
</HTML>"));
    end AIMC_Inverter;

    model SMR_Inverter
      "Test example 5: SynchronousInductionMachineReluctanceRotor with inverter"
      extends Modelica.Icons.Example2;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
      parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
      parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
      parameter Modelica.SIunits.Torque TLoad=46 "Nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
      parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";

      Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor
        smr
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
        annotation (Placement(transformation(
            origin={0,30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smr.p)
        annotation (Placement(transformation(
            origin={20,-40},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp)
        annotation (Placement(transformation(extent={{-80,50},{-60,70}},
              rotation=0)));
      Machines.Utilities.VfController vfController(
        final m=m,
        VNominal=VNominal,
        fNominal=fNominal) annotation (Placement(transformation(extent={{-40,50},
                {-20,70}}, rotation=0)));
      Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(final m=
            m)
        annotation (Placement(transformation(
            origin={0,60},
            extent={{10,10},{-10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-50,80},{-70,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-90,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
                                                              startTime=tStep,
          stepTorque=-TLoad,
        useSupport=false)
                    annotation (Placement(transformation(extent={{90,-50},{70,
                -30}}, rotation=0)));
      Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
                                         annotation (Placement(transformation(
              extent={{-20,-30},{0,-10}}, rotation=0)));
    equation
      connect(signalVoltage.plug_n, star.plug_p)
        annotation (Line(points={{1.83697e-015,70},{1.83697e-015,90},{-50,90}},
            color={0,0,255}));
      connect(star.pin_n, ground.p)
        annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
      connect(ramp.y, vfController.u)
        annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
      connect(vfController.y, signalVoltage.v)
        annotation (Line(points={{-19,60},{-7,60}}, color={0,0,255}));
      connect(loadInertia.flange_b, loadTorqueStep.flange)
        annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
      connect(currentQuasiRMSSensor.plug_p, signalVoltage.plug_p)
                                                               annotation (Line(
            points={{1.83697e-015,40},{1.83697e-015,42.5},{6.12303e-016,42.5},{
              6.12303e-016,50},{-1.83697e-015,50}},color={0,0,255}));
      connect(smr.plug_sn, rotorDisplacementAngle.plug_n)    annotation (Line(
            points={{-16,-30},{-16,-20},{26,-20},{26,-30}}, color={0,0,255}));
      connect(smr.plug_sp, rotorDisplacementAngle.plug_p)    annotation (Line(
            points={{-4,-30},{14,-30}}, color={0,0,255}));
      connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
                                                                 annotation (Line(
          points={{-10,-28},{-10,0},{-1.83697e-015,0},{-1.83697e-015,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sp, smr.plug_sp)   annotation (Line(
          points={{-4,-30},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sn, smr.plug_sn)   annotation (Line(
          points={{-16,-30},{-16,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(smr.flange, rotorDisplacementAngle.flange) annotation (Line(
          points={{0,-40},{10,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(smr.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=1.5, Interval=0.001),
        Documentation(info="<HTML>
<b>5th Test example: Synchronous induction machine with reluctance rotor fed by an ideal inverter</b><br>
An ideal frequency inverter is modeled by using a VfController and a threephase SignalVoltage.<br>
Frequency is raised by a ramp, causing the reluctance machine to start,
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>smr.wMechanical: motor's speed</li>
<li>smr.tauElectrical: motor's torque</li>
<li>rotorDisplacementAngle.rotorDisplacementAngle: rotor displacement angle</li>
</ul>
Default machine parameters of model <i>SM_ReluctanceRotor</i> are used.
</HTML>"));
    end SMR_Inverter;

    model SMPM_Inverter
      "Test example 6: PermanentMagnetSynchronousInductionMachine with inverter"
      extends Modelica.Icons.Example2;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
      parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
      parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
      parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
      parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";

      Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
        smpm
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
        annotation (Placement(transformation(
            origin={0,30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p)
        annotation (Placement(transformation(
            origin={20,-40},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp)
        annotation (Placement(transformation(extent={{-80,50},{-60,70}},
              rotation=0)));
      Machines.Utilities.VfController vfController(
        final m=m,
        VNominal=VNominal,
        fNominal=fNominal,
        BasePhase=+Modelica.Constants.pi/2)
        annotation (Placement(transformation(extent={{-40,50},{-20,70}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(final m=
            m)
        annotation (Placement(transformation(
            origin={0,60},
            extent={{10,10},{-10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-50,80},{-70,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-90,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
                                                              startTime=tStep,
          stepTorque=-TLoad,
        useSupport=false)
                    annotation (Placement(transformation(extent={{90,-50},{70,
                -30}}, rotation=0)));
      Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
                                         annotation (Placement(transformation(
              extent={{-20,-30},{0,-10}}, rotation=0)));
    equation
      connect(signalVoltage.plug_n, star.plug_p)
        annotation (Line(points={{1.83697e-015,70},{1.83697e-015,90},{-50,90}},
            color={0,0,255}));
      connect(star.pin_n, ground.p)
        annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
      connect(ramp.y, vfController.u)
        annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
      connect(vfController.y, signalVoltage.v)
        annotation (Line(points={{-19,60},{-7,60}}, color={0,0,255}));
      connect(loadInertia.flange_b, loadTorqueStep.flange)
        annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
      connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p)
                                                               annotation (Line(
            points={{-1.83697e-015,50},{0,50},{0,40},{1.83697e-015,40}},color={
              0,0,255}));
      connect(rotorDisplacementAngle.plug_n, smpm.plug_sn)    annotation (Line(
            points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
      connect(rotorDisplacementAngle.plug_p, smpm.plug_sp)    annotation (Line(
            points={{14,-30},{-4,-30}}, color={0,0,255}));
      connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
                                                                 annotation (Line(
          points={{-10,-28},{-10,0},{-1.83697e-015,0},{-1.83697e-015,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sn, smpm.plug_sn)   annotation (Line(
          points={{-16,-30},{-16,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sp, smpm.plug_sp)   annotation (Line(
          points={{-4,-30},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(
          points={{0,-40},{10,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(smpm.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=1.5, Interval=0.001),
        Documentation(info="<HTML>
<b>6th Test example: Permanent magnet synchronous induction machine fed by an ideal inverter</b><br>
An ideal frequency inverter is modeled by using a VfController and a threephase SignalVoltage.<br>
Frequency is raised by a ramp, causing the permanent magnet synchronous induction machine to start,
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>smpm.wMechanical: motor's speed</li>
<li>smpm.tauElectrical: motor's torque</li>
<li>rotorDisplacementAngle.rotorDisplacementAngle: rotor displacement angle</li>
</ul>
Default machine parameters of model <i>SM_PermanentMagnet</i> are used.
<p>
<b>In practice it is nearly impossible to drive a PMSMD without current controller.</b>
</p>
</HTML>"));
    end SMPM_Inverter;

    model SMEE_Generator
      "Test example 7a: ElectricalExcitedSynchronousInductionMachine as Generator"
      extends Modelica.Icons.Example2;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
      parameter Modelica.SIunits.AngularVelocity wActual(displayUnit="1/min")=1499*2*Modelica.Constants.pi/60
        "Actual speed";
      parameter Modelica.SIunits.Current Ie = 19 "Excitation current";
      parameter Modelica.SIunits.Current Ie0 = 10 "Initial excitation current";
      parameter Modelica.SIunits.Angle gamma0(displayUnit="deg")=0
        "Initial rotor displacement angle";
      Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
        smee(
        useSupport=true, phiMechanical(start=-(Modelica.Constants.pi +gamma0)/smee.p, fixed=true),
        fsNominal=smeeData.fsNominal,
        Rs=smeeData.Rs,
        TsRef=smeeData.TsRef,
        alpha20s=smeeData.alpha20s,
        Lssigma=smeeData.Lssigma,
        Lmd=smeeData.Lmd,
        Lmq=smeeData.Lmq,
        Lrsigmad=smeeData.Lrsigmad,
        Lrsigmaq=smeeData.Lrsigmaq,
        Rrd=smeeData.Rrd,
        Rrq=smeeData.Rrq,
        TrRef=smeeData.TrRef,
        alpha20r=smeeData.alpha20r,
        VsNominal=smeeData.VsNominal,
        IeOpenCircuit=smeeData.IeOpenCircuit,
        Re=smeeData.Re,
        TeRef=smeeData.TeRef,
        alpha20e=smeeData.alpha20e,
        sigmae=smeeData.sigmae)
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smee.p,
          useSupport=true)
        annotation (Placement(transformation(
            origin={20,-40},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundExcitation
        annotation (Placement(transformation(
            origin={-90,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                                final w_fixed=wActual)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}},
              rotation=0)));
      Machines.Sensors.MechanicalPowerSensor mechanicalPowerSensor(useSupport=true)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Machines.Sensors.ElectricalPowerSensor electricalPowerSensor
        annotation (Placement(transformation(
            origin={0,60},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
        annotation (Placement(transformation(
            origin={0,30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
        final m=m,
        final V=fill(VNominal*sqrt(2), m),
        final freqHz=fill(fNominal, m))
        annotation (Placement(transformation(extent={{-20,80},{-40,100}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-50,80},{-70,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-90,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(
        duration=0.1,
        I=Ie - Ie0,
        offset=Ie0)        annotation (Placement(transformation(
            origin={-50,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
                                         annotation (Placement(transformation(
              extent={{-20,-30},{0,-10}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed
        annotation (Placement(transformation(extent={{70,-70},{90,-50}})));
      parameter Utilities.SynchronousMachineData smeeData
        annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    equation
      connect(rotorDisplacementAngle.plug_n, smee.plug_sn)    annotation (Line(
            points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
      connect(rotorDisplacementAngle.plug_p, smee.plug_sp)    annotation (Line(
            points={{14,-30},{-4,-30}}, color={0,0,255}));
      connect(star.pin_n, ground.p)
        annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
      connect(star.plug_p, sineVoltage.plug_n)   annotation (Line(points={{-50,
              90},{-40,90}}, color={0,0,255}));
      connect(electricalPowerSensor.plug_ni, currentQuasiRMSSensor.plug_p)
        annotation (Line(points={{-1.83697e-015,50},{1.76911e-022,46},{
              1.83697e-015,46},{1.83697e-015,40}}, color={0,0,255}));
      connect(mechanicalPowerSensor.flange_b, constantSpeed.flange)
        annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
      connect(sineVoltage.plug_p, electricalPowerSensor.plug_p)   annotation (Line(
            points={{-20,90},{1.83697e-015,90},{1.83697e-015,70}},   color={0,0,
              255}));
      connect(rampCurrent.p, groundExcitation.p)
                                         annotation (Line(points={{-50,-50},{
              -80,-50}}, color={0,0,255}));
      connect(rampCurrent.p, smee.pin_en)    annotation (Line(points={{-50,-50},
              {-40,-50},{-40,-46},{-20,-46}}, color={0,0,255}));
      connect(rampCurrent.n, smee.pin_ep)    annotation (Line(points={{-50,-30},
              {-40,-30},{-40,-34},{-20,-34}}, color={0,0,255}));
      connect(electricalPowerSensor.plug_nv, smee.plug_sn)   annotation (Line(
            points={{-10,60},{-16,60},{-16,-30}}, color={0,0,255}));
      connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
                                                                 annotation (Line(
          points={{-10,-28},{-10,0},{-1.83697e-015,0},{-1.83697e-015,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sn, smee.plug_sn)   annotation (Line(
          points={{-16,-30},{-16,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sp, smee.plug_sp)   annotation (Line(
          points={{-4,-30},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(constantSpeed.support, fixed.flange) annotation (Line(
          points={{80,-50},{80,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(mechanicalPowerSensor.support, fixed.flange) annotation (Line(
          points={{50,-50},{50,-60},{80,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(smee.support, fixed.flange) annotation (Line(
          points={{0,-50},{0,-60},{80,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(rotorDisplacementAngle.support, smee.support) annotation (Line(
          points={{10,-50},{0,-50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(smee.flange, rotorDisplacementAngle.flange) annotation (Line(
          points={{0,-40},{10,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(smee.flange, mechanicalPowerSensor.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=30, Interval=0.005),
        Documentation(info="<HTML>
<b>Test example 7a: Electrical excited synchronous induction machine as generator</b><br>
An electrically excited synchronous generator is connected to the grid and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. This allows to see several charactersistics dependent on rotor angle.
Simulate for 30 seconds and plot (versus rotorDisplacementAngle.rotorDisplacementAngle):
<ul>
<li>smee.tauElectrical</li>
<li>currentQuasiRMSSensor.I</li>
<li>electricalPowerSensor.P</li>
<li>electricalPowerSensor.Q</li>
<li>mechanicalPowerSensor.P</li>
</ul>
Default machine parameters of model <i>SM_ElectricalExcited</i> are used.
</HTML>"));
    end SMEE_Generator;

    model SMEE_LoadDump
      "Test example 7b: ElectricalExcitedSynchronousInductionMachine with voltage controller"
      extends Modelica.Icons.Example2;
      import Modelica.Constants.pi;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smeeData.fsNominal/smee.p
        "Nominal speed";
      parameter Modelica.SIunits.Impedance ZNominal=3*smeeData.VsNominal^2/smeeData.SNominal
        "Nominal load impedance";
      parameter Real powerFactor(min=0, max=1)=0.8 "Load power factor";
      parameter Modelica.SIunits.Resistance RLoad=ZNominal*powerFactor
        "Load resistance";
      parameter Modelica.SIunits.Inductance LLoad=ZNominal*sqrt(1-powerFactor^2)/(2*pi*smeeData.fsNominal)
        "Load inductance";
      parameter Modelica.SIunits.Voltage Ve0=smee.IeOpenCircuit*
        Modelica.Electrical.Machines.Thermal.convertResistance(smee.Re, smee.TeRef, smee.alpha20e, smee.TeOperational)
        "No load excitation voltage";
      parameter Real k=2*Ve0/smeeData.VsNominal "Voltage controller: gain";
      parameter Modelica.SIunits.Time Ti=smeeData.Td0Transient/2
        "Voltage controller: integral time constant";
      output Real controlError=(setPointGain.y - voltageQuasiRMSSensor.V)/smeeData.VsNominal;
      Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
        smee(
        fsNominal=smeeData.fsNominal,
        Rs=smeeData.Rs,
        TsRef=smeeData.TsRef,
        Lssigma=smeeData.Lssigma,
        Lmd=smeeData.Lmd,
        Lmq=smeeData.Lmq,
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
        alpha20s=smeeData.alpha20s,
        useDamperCage=true,
        alpha20r=smeeData.alpha20r,
        alpha20e=smeeData.alpha20e)
        annotation (Placement(transformation(extent={{0,-40},{20,-20}},
              rotation=0)));
      parameter Utilities.SynchronousMachineData smeeData
        annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
      Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
        annotation (Placement(transformation(extent={{0,-20},{20,0}},    rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-20,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Mechanics.Rotational.Sources.Speed speed
        annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
      Blocks.Sources.Ramp speedRamp(height=wNominal, duration=1)
        annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
      Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-50})));
      Blocks.Math.Gain setPointGain(k=smeeData.VsNominal/wNominal)
        annotation (Placement(transformation(extent={{-50,-90},{-70,-70}})));
      Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(V(start=1E-3, fixed=true))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,0})));
      Blocks.Continuous.LimPID voltageController(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=k,
        Ti=Ti,
        yMax=2.5*Ve0,
        yMin=0)
        annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
      Analog.Sources.SignalVoltage excitationVoltage annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-30,-30})));
      Modelica.Electrical.Analog.Basic.Ground groundExcitation
        annotation (Placement(transformation(
            origin={-30,-60},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
        annotation (Placement(transformation(
            origin={10,30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Blocks.Sources.BooleanPulse loadControl(period=4, startTime=2)
        annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
      MultiPhase.Ideal.CloserWithArc switch(     m=m)
        annotation (Placement(transformation(extent={{0,40},{-20,60}})));
      MultiPhase.Basic.Resistor loadResistor(m=m, R=fill(RLoad, m))
        annotation (Placement(transformation(extent={{-30,40},{-50,60}})));
      MultiPhase.Basic.Inductor loadInductor(m=m, L=fill(LLoad, m))
        annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
      MultiPhase.Basic.Star star(m=m) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,30})));
    equation
      connect(terminalBox.plug_sn, smee.plug_sn)   annotation (Line(
          points={{4,-20},{4,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plug_sp, smee.plug_sp)   annotation (Line(
          points={{16,-20},{16,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(ground.p, terminalBox.starpoint) annotation (Line(
          points={{-10,-10},{-10,-18},{1,-18}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(excitationVoltage.p, smee.pin_ep) annotation (Line(
          points={{-30,-20},{-20,-20},{-20,-24},{0,-24}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(excitationVoltage.n, smee.pin_en) annotation (Line(
          points={{-30,-40},{-20,-40},{-20,-36},{0,-36}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
          points={{-30,-40},{-30,-50}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageQuasiRMSSensor.plug_n, smee.plug_sn) annotation (Line(
          points={{-1.83697e-015,-10},{4,-10},{4,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageQuasiRMSSensor.plug_p, smee.plug_sp) annotation (Line(
          points={{1.83697e-015,10},{16,10},{16,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n) annotation (
          Line(
          points={{10,-18},{10,1},{10,20},{10,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(smee.flange, speed.flange) annotation (Line(
          points={{20,-30},{30,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(speed.flange, speedSensor.flange) annotation (Line(
          points={{30,-30},{30,-35},{30,-40},{30,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(speedRamp.y, speed.w_ref) annotation (Line(
          points={{59,-30},{52,-30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(setPointGain.y, voltageController.u_s)
                                       annotation (Line(
          points={{-71,-80},{-80,-80},{-80,-30},{-72,-30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(speedSensor.w, setPointGain.u) annotation (Line(
          points={{30,-61},{30,-80},{-48,-80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(voltageQuasiRMSSensor.V, voltageController.u_m)
                                                annotation (Line(
          points={{-11,2.02067e-015},{-90,2.02067e-015},{-90,-52},{-60,-52},{
              -60,-42}},
          color={0,0,127},
          smooth=Smooth.None));

      connect(voltageController.y, excitationVoltage.v)
                                          annotation (Line(
          points={{-49,-30},{-37,-30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(loadInductor.plug_p, loadResistor.plug_n)
                                                    annotation (Line(
          points={{-60,50},{-50,50}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(loadResistor.plug_p, switch.plug_n)    annotation (Line(
          points={{-30,50},{-20,50}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(switch.plug_p, currentQuasiRMSSensor.plug_p)        annotation (Line(
          points={{0,50},{10,50},{10,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(star.plug_p, loadInductor.plug_n) annotation (Line(
          points={{-90,40},{-90,50},{-80,50}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(loadControl.y, switch.control[1])          annotation (Line(
          points={{-19,80},{-10,80},{-10,57}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(loadControl.y, switch.control[2])          annotation (Line(
          points={{-19,80},{-10,80},{-10,57}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(loadControl.y, switch.control[3])          annotation (Line(
          points={{-19,80},{-10,80},{-10,57}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}),
                graphics),
        experiment(StopTime=10, Interval=0.001),
        Documentation(info="<html>
<b>Test example 7b: Electrical excited synchronous induction machine with voltage controller</b><br>
An electrically excited synchronous generator is started with a speed ramp, then driven with constant speed.
Voltage is controlled, the set point depends on speed. After start-up the generator is loaded, the load is rejected.
Simulate for 10 seconds and plot:
<ul>
<li>voltageQuasiRMSSensor.V</li>
<li>smee.tauElectrical</li>
<li>smee.ie</li>
</ul>
Default machine parameters of model <i>SM_ElectricalExcited</i> are used.
One could try to optimize the controller parameters.
</html>"),
        experimentSetupOutput);
    end SMEE_LoadDump;

    model DCPM_Start
      "Test example 8: DC with permanent magnet starting with voltage ramp"
      extends Modelica.Icons.Example2;
      parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
      parameter Modelica.SIunits.Time tStart=0.2
        "Start of armature voltage ramp";
      parameter Modelica.SIunits.Time tRamp=0.8 "Armature voltage ramp";
      parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.5 "Time of load torque step";
      parameter Modelica.SIunits.Inertia JLoad=0.15 "Load's moment of inertia";

      Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Modelica.Blocks.Sources.Ramp ramp(
        duration=tRamp,
        height=Va,
        startTime=tStart)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}},
              rotation=0)));
      Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
        annotation (Placement(transformation(extent={{0,30},{-20,50}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-70,40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
                                                              startTime=tStep,
          stepTorque=-TLoad,
        useSupport=false)
                    annotation (Placement(transformation(extent={{90,-50},{70,
                -30}}, rotation=0)));
    equation
      connect(ramp.y, signalVoltage.v)   annotation (Line(points={{-59,70},{-10,
              70},{-10,47}}, color={0,0,255}));
      connect(signalVoltage.p, dcpm.pin_ap)   annotation (Line(points={{0,40},{
              0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
      connect(signalVoltage.n, ground.p)   annotation (Line(points={{-20,40},{
              -60,40}}, color={0,0,255}));
      connect(dcpm.pin_an, signalVoltage.n)   annotation (Line(points={{-16,-30},
              {-16,-20},{-20,-20},{-20,40}}, color={0,0,255}));
      connect(loadInertia.flange_b, loadTorqueStep.flange)
        annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
      connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=2, Interval=0.001),
        Documentation(info="<HTML>
<b>8th Test example: Permanent magnet DC machine started with an armature voltage ramp</b><br>
A voltage ramp is applied to the armature, causing the DC machine to start,
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcpm.ia: armature current</li>
<li>dcpm.wMechanical: motor's speed</li>
<li>dcpm.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <i>DC_PermanentMagnet</i> are used.
</HTML>"));
    end DCPM_Start;

    model DCEE_Start
      "Test example 9: DC with electrical ecxitation starting with voltage ramp"
      extends Modelica.Icons.Example2;
      parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
      parameter Modelica.SIunits.Time tStart=0.2
        "Start of armature voltage ramp";
      parameter Modelica.SIunits.Time tRamp=0.8 "Armature voltage ramp";
      parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
      parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.5 "Time of load torque step";
      parameter Modelica.SIunits.Inertia JLoad=0.15 "Load's moment of inertia";

      Machines.BasicMachines.DCMachines.DC_ElectricalExcited dcee
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Modelica.Blocks.Sources.Ramp ramp(
        duration=tRamp,
        height=Va,
        startTime=tStart)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}},
              rotation=0)));
      Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
        annotation (Placement(transformation(extent={{0,30},{-20,50}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-70,40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=Ve)
        annotation (Placement(transformation(
            origin={-40,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundExcitation
        annotation (Placement(transformation(
            origin={-70,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
                                                              startTime=tStep,
          stepTorque=-TLoad,
        useSupport=false)
                    annotation (Placement(transformation(extent={{90,-50},{70,
                -30}}, rotation=0)));
    equation
      connect(ramp.y, signalVoltage.v)   annotation (Line(points={{-59,70},{-10,
              70},{-10,47}}, color={0,0,255}));
      connect(signalVoltage.p, dcee.pin_ap)   annotation (Line(points={{0,40},{
              0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
      connect(signalVoltage.n, ground.p)   annotation (Line(points={{-20,40},{
              -60,40}}, color={0,0,255}));
      connect(dcee.pin_an, ground.p)   annotation (Line(points={{-16,-30},{-16,
              -20},{-20,-20},{-20,40},{-60,40}}, color={0,0,255}));
      connect(constantVoltage.n, groundExcitation.p)
                                             annotation (Line(points={{-40,-50},
              {-60,-50}}, color={0,0,255}));
      connect(dcee.pin_ep, constantVoltage.p)   annotation (Line(points={{-20,
              -34},{-30,-34},{-30,-30},{-40,-30}}, color={0,0,255}));
      connect(dcee.pin_en, constantVoltage.n)   annotation (Line(points={{-20,
              -46},{-30,-46},{-30,-50},{-40,-50}}, color={0,0,255}));
      connect(loadInertia.flange_b, loadTorqueStep.flange)
        annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
      connect(dcee.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=2, Interval=0.001),
        Documentation(info="<HTML>
<b>9th Test example: Electrically separate excited DC machine started with an armature voltage ramp</b><br>
A voltage ramp is applied to the armature, causing the DC machine to start,
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcee.ia: armature current</li>
<li>dcee.wMechanical: motor's speed</li>
<li>dcee.tauElectrical: motor's torque</li>
<li>dcee.ie: excitation current</li>
</ul>
Default machine parameters of model <i>DC_ElectricalExcited</i> are used.
</HTML>"));
    end DCEE_Start;

    model DCSE_Start
      "Test example 10: DC with serial excitation starting with voltage ramp"
      extends Modelica.Icons.Example2;
      parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
      parameter Modelica.SIunits.Time tStart=0.1 "Start of resistance ramp";
      parameter Modelica.SIunits.Time tRamp=0.9 "Resistance ramp";
      parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
      parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="1/min")=1410*2*Modelica.Constants.pi/60
        "Nominal load speed";
      parameter Modelica.SIunits.Inertia JLoad=0.15 "Load's moment of inertia";

      Machines.BasicMachines.DCMachines.DC_SeriesExcited dcse
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Modelica.Blocks.Sources.Ramp ramp(
        duration=tRamp,
        startTime=tStart,
        height=-1,
        offset=1)
        annotation (Placement(transformation(extent={{60,0},{40,20}},
              rotation=0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=Va)
        annotation (Placement(transformation(extent={{0,50},{-20,30}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-70,40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
        quadraticLoadTorque(
        w_nominal=wLoad,
        TorqueDirection=false,
        tau_nominal=-TLoad,
        useSupport=false)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.VariableResistor variableResistor annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,10})));
    equation
      connect(constantVoltage.n, ground.p) annotation (Line(points={{-20,40},{
              -60,40}}, color={0,0,255}));
      connect(loadInertia.flange_b, quadraticLoadTorque.flange)
        annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
      connect(dcse.pin_an, dcse.pin_ep)   annotation (Line(points={{-16,-30},{
              -20,-30},{-20,-34}}, color={0,0,255}));
      connect(dcse.pin_en, constantVoltage.n) annotation (Line(points={{-20,-46},
              {-30,-46},{-30,-20},{-20,-20},{-20,40}}, color={0,0,255}));
      connect(dcse.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(constantVoltage.p, variableResistor.p)
                                                   annotation (Line(
          points={{0,40},{0,20},{1.83697e-015,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(variableResistor.n, dcse.pin_ap) annotation (Line(
          points={{-1.83697e-015,0},{0,0},{0,-20},{-4,-20},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(ramp.y, variableResistor.R) annotation (Line(
          points={{39,10},{25,10},{25,10},{11,10}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=2, Interval=0.001),
        Documentation(info="<HTML>
<b>10th Test example: Series excited DC machine started with a series resistor</b><br>
At constant source voltage, a series resistor limiting the armature current, is reduced according to a ramp, causing the DC machine to start,
and accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcse.ia: armature current</li>
<li>dcse.wMechanical: motor's speed</li>
<li>dcse.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <i>DC_SeriesExcited</i> are used.
</HTML>"));
    end DCSE_Start;

    model DCSE_SinglePhase
      "Test example 11: DC with serial excitation starting with voltage ramp"
      extends Modelica.Icons.Example2;
      parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage RMS";
      parameter Modelica.SIunits.Time tStart=0.1 "Start of resistance ramp";
      parameter Modelica.SIunits.Time tRamp=0.9 "Resistance ramp";
      parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
      parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="1/min")=1410*2*Modelica.Constants.pi/60
        "Nominal load speed";
      parameter Modelica.SIunits.Inertia JLoad=0.15 "Load's moment of inertia";

      Machines.BasicMachines.DCMachines.DC_SeriesExcited dcse
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Modelica.Blocks.Sources.Ramp ramp(
        duration=tRamp,
        startTime=tStart,
        height=-1,
        offset=1)
        annotation (Placement(transformation(extent={{60,0},{40,20}},
              rotation=0)));
      Analog.Sources.SineVoltage constantVoltage(V=sqrt(2)*Va, freqHz=50)
        annotation (Placement(transformation(extent={{0,50},{-20,30}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-70,40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
        quadraticLoadTorque(
        w_nominal=wLoad,
        TorqueDirection=false,
        tau_nominal=-TLoad,
        useSupport=false)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.VariableResistor variableResistor annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,10})));
    equation
      connect(constantVoltage.n, ground.p) annotation (Line(points={{-20,40},{
              -60,40}}, color={0,0,255}));
      connect(loadInertia.flange_b, quadraticLoadTorque.flange)
        annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
      connect(dcse.pin_an, dcse.pin_ep)   annotation (Line(points={{-16,-30},{
              -20,-30},{-20,-34}}, color={0,0,255}));
      connect(dcse.pin_en, constantVoltage.n) annotation (Line(points={{-20,-46},
              {-30,-46},{-30,-20},{-20,-20},{-20,40}}, color={0,0,255}));
      connect(dcse.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(constantVoltage.p, variableResistor.p)
                                                   annotation (Line(
          points={{0,40},{0,20},{1.83697e-015,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(variableResistor.n, dcse.pin_ap) annotation (Line(
          points={{-1.83697e-015,0},{0,0},{0,-20},{-4,-20},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(ramp.y, variableResistor.R) annotation (Line(
          points={{39,10},{25,10},{25,10},{11,10}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=2, Interval=0.0005),
        Documentation(info="<HTML>
<b>11th Test example: Series excited DC machine at singlephase AC voltage started with a series resistor</b><br>
At sinusoidal source voltage, a series resistor limiting the armature current, is reduced according to a ramp, causing the DC machine to start,
and accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcse.ia: armature current</li>
<li>dcse.wMechanical: motor's speed</li>
<li>dcse.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <i>DC_SeriesExcited</i> are used.<br>
<b>Note:</b><br>
Since both the field and the armature current are sinusoidal, the waveform of the torque is the square of sine.
Due to the additional inductive voltage drops, output of the motor is lower, compared to the same motor (DCSE_Start) at DC voltage.
</HTML>"));
    end DCSE_SinglePhase;

    model DC_Comparison
      "Test example 12: Compare torque-speed characteristic of DC motors"
      extends Modelica.Icons.Example2;
      parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
      parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
      parameter Modelica.SIunits.AngularVelocity w0=Modelica.SIunits.Conversions.from_rpm(1500)
        "No-load speed";
      parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
      parameter Modelica.SIunits.Time tStart=0.5
        "Start ofload torque ramp ramp";
      parameter Modelica.SIunits.Time tRamp=2.0 "Load torque ramp";
      parameter Modelica.SIunits.Inertia JLoad=0.15 "Load's moment of inertia";

      Machines.BasicMachines.DCMachines.DC_ElectricalExcited dcee(wMechanical(start=
             w0, fixed=true), ie(start=1, fixed=true))
        annotation (Placement(transformation(extent={{-20,-10},{0,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                                                                       rotation=90,
            origin={-80,70})));
      Modelica.Electrical.Analog.Basic.Ground groundArmature
        annotation (Placement(transformation(
            origin={-80,40},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage excitationVoltage(V=Ve)
        annotation (Placement(transformation(
            origin={-80,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundExcitation
        annotation (Placement(transformation(
            origin={-80,-80},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J=JLoad)
        annotation (Placement(transformation(extent={{10,-10},{30,10}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque loadTorque1(useSupport=false)
        annotation (Placement(transformation(extent={{60,-10},{40,10}}, rotation=0)));
      Modelica.Blocks.Sources.Ramp ramp(
        startTime=tStart,
        height=-TLoad,
        duration=tRamp,
        offset=0) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    equation
      connect(loadInertia1.flange_b, loadTorque1.flange)
        annotation (Line(points={{30,0},{30,0},{40,0}},
                                                     color={0,0,0}));
      connect(dcee.flange, loadInertia1.flange_a)
                                                 annotation (Line(
          points={{0,0},{10,0}},
          color={0,0,0},
          smooth=Smooth.None));

      connect(ramp.y, loadTorque1.tau)
                                      annotation (Line(
          points={{79,0},{62,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(armatureVoltage.n, groundArmature.p) annotation (Line(
          points={{-80,60},{-80,50}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
          points={{-80,-60},{-80,-70}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(armatureVoltage.p, dcee.pin_ap) annotation (Line(
          points={{-80,80},{-30,80},{-30,20},{-4,20},{-4,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(armatureVoltage.n, dcee.pin_an) annotation (Line(
          points={{-80,60},{-40,60},{-40,10},{-16,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(excitationVoltage.p, dcee.pin_ep) annotation (Line(
          points={{-80,-40},{-60,-40},{-60,6},{-20,6}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(excitationVoltage.n, dcee.pin_en) annotation (Line(
          points={{-80,-60},{-50,-60},{-50,-6},{-20,-6}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=3, Interval=0.001),
        Documentation(info="<HTML>
<b>12th Test example: Compare characteristic of DC motors</b><br>
The motors are started at no-load speed, then a load ramp is applied.<br>
Simulate for 3 seconds and plot (versus time):
<ul>
<li>dcxx.ia: armature current</li>
<li>dcxx.wMechanical: motor's speed</li>
<li>dcxx.tauElectrical: motor's torque</li>
</ul>
Default machine parameters are used.
</HTML>"),
        experimentSetupOutput);
    end DC_Comparison;

    model DCPM_Temperature
      "Test example 13: Investigate temperature dependecy of a DCPM motor"
      extends Modelica.Icons.Example2;
      parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
      parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
      parameter Modelica.SIunits.AngularVelocity w0=Modelica.SIunits.Conversions.from_rpm(1500)
        "No-load speed";
      parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
      parameter Modelica.SIunits.Inertia JLoad=0.15 "Load's moment of inertia";

      Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(           wMechanical(start=
             w0, fixed=true),
        alpha20a(displayUnit="1/K") = Machines.Thermal.Constants.alpha20Copper,
        useThermalPort=true,
        TaNominal=353.15,
        TaRef=353.15)
        annotation (Placement(transformation(extent={{-20,-10},{0,10}},
              rotation=0)));

      Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                                                                       rotation=90,
            origin={-80,70})));
      Modelica.Electrical.Analog.Basic.Ground groundArmature
        annotation (Placement(transformation(
            origin={-80,40},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
        annotation (Placement(transformation(extent={{10,-10},{30,10}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
        useSupport=false,
        stepTorque=-TLoad,
        offsetTorque=0,
        startTime=0.1)
        annotation (Placement(transformation(extent={{60,-10},{40,10}}, rotation=0)));
      Thermal.DCMachines.ThermalAmbientDCPM thermalAmbientDCPM(useTemperatureInputs=true)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Modelica.Blocks.Sources.Exponentials exponential(
        offset=293.15,
        outMax=60,
        riseTime=3600,
        riseTimeConst=0.5,
        fallTimeConst=0.5,
        startTime=0.1)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    equation
      connect(loadInertia.flange_b, loadTorque.flange)
        annotation (Line(points={{30,0},{30,0},{40,0}},
                                                     color={0,0,0}));
      connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
          points={{0,0},{10,0}},
          color={0,0,0},
          smooth=Smooth.None));

      connect(armatureVoltage.n, groundArmature.p) annotation (Line(
          points={{-80,60},{-80,50}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(armatureVoltage.p,dcpm. pin_ap) annotation (Line(
          points={{-80,80},{-4,80},{-4,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(armatureVoltage.n,dcpm. pin_an) annotation (Line(
          points={{-80,60},{-16,60},{-16,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(dcpm.thermalPort, thermalAmbientDCPM.thermalPort) annotation (Line(
          points={{-10,-10},{-10,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(thermalAmbientDCPM.T_a, exponential.y)
                                              annotation (Line(
          points={{-18,-40},{-18,-50},{-39,-50}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}),
                graphics),
        experiment(StopTime=3, Interval=0.001),
        Documentation(info="<HTML>
<b>13th Test example: Investigate influence of armature temperature on a DCPM motor</b><br>
The motor starts at no-load speed, then a load step is applied.<br>
Beginning with the load step, the armature temperature rises exponentially from 20 degC to 80 degC.<br>
Simulate for 3 seconds and plot (versus time):
<ul>
<li>dcpm.ia: armature current</li>
<li>dcpm.wMechanical: motor's speed</li>
<li>dcpm.tauElectrical: motor's torque</li>
<li>thermalAmbientDCPM.Q_flow_a: motor's armature losses</li>
</ul>
Default machine parameters are used, but:
<ul>
<li>The aramature winding material is set to Copper.</li>
<li>Armature reference temperature is set to 80 degC.</li>
<li>Nominal armature temperature is set to 80 degC.</li>
</ul>
So the machine is at the beginning in cold condition, ending in warm condition
(with the same armature resistance as the unmodified machine).
</HTML>"),
        experimentSetupOutput);
    end DCPM_Temperature;

    model DCPM_Cooling "Test example 14: Cooling of a DCPM motor"
      extends Modelica.Icons.Example2;
      parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
      parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
      parameter Modelica.SIunits.AngularVelocity w0=Modelica.SIunits.Conversions.from_rpm(1500)
        "No-load speed";
      parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
      parameter Modelica.SIunits.Inertia JLoad=0.15 "Load's moment of inertia";
      parameter Modelica.SIunits.Temperature TAmbient=293.15
        "Ambient temperature";
      parameter Modelica.SIunits.HeatCapacity Ca=20 "Armature's heat capacity";
      parameter Modelica.SIunits.HeatCapacity Cc=50 "Core's heat capacity";
      final parameter Modelica.SIunits.Power Losses=dcpm.Ra*dcpm.IaNominal^2
        "Nominal Losses";
      final parameter Modelica.SIunits.Temperature T0=293.15
        "Reference temperature 20 degC";
      final parameter Modelica.SIunits.TemperatureDifference dTCoolant=10
        "Coolant's temperature rise";
      final parameter Modelica.SIunits.TemperatureDifference dTArmature=dcpm.TaNominal-T0-dTCoolant/2
        "Armature's temperature rise over coolant";
      parameter Modelica.SIunits.ThermalConductance G_armature_core=2*Losses/dTArmature
        "Heat conductance armature - core";
      parameter Modelica.SIunits.ThermalConductance G_core_cooling=2*Losses/dTArmature
        "Heat conductance core - cooling";
      parameter Modelica.SIunits.VolumeFlowRate CoolantFlow=50 "Coolant flow";
      Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
        wMechanical(start=w0, fixed=true),
        alpha20a(displayUnit="1/K") = Machines.Thermal.Constants.alpha20Copper,
        useThermalPort=true,
        TaNominal=353.15,
        TaRef=353.15)
        annotation (Placement(transformation(extent={{-20,20},{0,40}},
              rotation=0)));

      Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                                                                       rotation=90,
            origin={-80,70})));
      Modelica.Electrical.Analog.Basic.Ground groundArmature
        annotation (Placement(transformation(
            origin={-80,40},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
        annotation (Placement(transformation(extent={{10,20},{30,40}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque loadTorque(
        useSupport=false)
        annotation (Placement(transformation(extent={{60,20},{40,40}},  rotation=0)));
      Modelica.Blocks.Sources.Pulse pulse(
        amplitude=-1.5*TLoad,
        offset=0,
        period=1)
        annotation (Placement(transformation(extent={{90,20},{70,40}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor armature(C=Ca, T(start=
             TAmbient, fixed=true))                                              annotation (
         Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-50,-40})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor armatureCore(G=
            G_armature_core)
        annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor core(C=Cc, T(start=
              TAmbient, fixed=true))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-10,-40})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor coreCooling(G=
            G_core_cooling)
        annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient inlet(
          constantAmbientTemperature=TAmbient)
        annotation (Placement(transformation(extent={{-10,-80},{-30,-60}})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow(
                               T0=TAmbient, constantVolumeFlow=CoolantFlow)
             annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
      Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe cooling(tapT=0.5, T0=
            TAmbient)
        annotation (Placement(transformation(extent={{30,-60},{50,-80}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient outlet(
          constantAmbientTemperature=TAmbient)
        annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
            TAmbient)
        annotation (Placement(transformation(extent={{42,-10},{22,10}})));
    protected
      Machines.Interfaces.DCMachines.ThermalPortDCPM thermalPort
        annotation (Placement(transformation(extent={{-14,-4},{-6,4}})));
    equation
      connect(loadInertia.flange_b, loadTorque.flange)
        annotation (Line(points={{30,30},{30,30},{40,30}},
                                                     color={0,0,0}));
      connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
          points={{0,30},{10,30}},
          color={0,0,0},
          smooth=Smooth.None));

      connect(armatureVoltage.n, groundArmature.p) annotation (Line(
          points={{-80,60},{-80,50}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(armatureVoltage.p,dcpm. pin_ap) annotation (Line(
          points={{-80,80},{-4,80},{-4,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(armatureVoltage.n,dcpm. pin_an) annotation (Line(
          points={{-80,60},{-16,60},{-16,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(armature.port, armatureCore.port_a)           annotation (Line(
          points={{-50,-30},{-40,-30}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(armatureCore.port_b, core.port)               annotation (Line(
          points={{-20,-30},{-10,-30}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(core.port, coreCooling.port_a)                 annotation (Line(
          points={{-10,-30},{0,-30}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(pulse.y, loadTorque.tau) annotation (Line(
          points={{69,30},{62,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(coreCooling.port_b, cooling.heatPort)          annotation (Line(
          points={{20,-30},{40,-30},{40,-60}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(cooling.flowPort_b, outlet.flowPort)      annotation (Line(
          points={{50,-70},{60,-70}},
          color={255,0,0},
          smooth=Smooth.None));
      connect(inlet.flowPort, volumeFlow.flowPort_a)   annotation (Line(
          points={{-10,-70},{0,-70}},
          color={255,0,0},
          smooth=Smooth.None));
      connect(volumeFlow.flowPort_b, cooling.flowPort_a)    annotation (Line(
          points={{20,-70},{30,-70}},
          color={255,0,0},
          smooth=Smooth.None));
      connect(dcpm.thermalPort, thermalPort)  annotation (Line(
          points={{-10,20},{-10,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(fixedTemperature.port, thermalPort.heatPort_stray)  annotation (Line(
          points={{22,0},{-10,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(fixedTemperature.port, thermalPort.heatPort_friction)  annotation (
          Line(
          points={{22,0},{-10,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(fixedTemperature.port, thermalPort.heatPort_brush)  annotation (Line(
          points={{22,0},{-10,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(fixedTemperature.port, thermalPort.heatPort_pm)  annotation (Line(
          points={{22,0},{-10,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(armature.port, thermalPort.heatPort_a)  annotation (Line(
          points={{-50,-30},{-50,0},{-10,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(core.port, thermalPort.heatPort_core)  annotation (Line(
          points={{-10,-30},{-10,-15},{-10,-15},{-10,0}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}),
                graphics),
        experiment(StopTime=25, Interval=0.001),
        Documentation(info="<HTML>
<b>14th Test example: Demonstrate cooling of a DCPM motor</b><br>
The motor starts at no-load speed, then load pulses are applied.<br>
The cooling circuit consists of armature's thermal capacitance,
a thermal conductance between armature and core, core's thermal capacitance and
a thermal conductance between core and coolant.
The coolant flow circuit consists of inlet, volume flow, a pipe connected to the core and the outlet.<br>
<b>Please note:</b>
<ul>
<li>All unused heat ports of the thermal port (i.e. without loss sources in the machine: brush, stray, friction, permanent magnet) have to be connected to a constant temperature source.</li>
<li>The thermal capacitances (i.e. time constants) are unusual small to provide short simulation time!</li>
<li>The coolant is a theoretical coolant with specific mass = 1 kg/m3 and cp = 1 J/kg.K.</li>
<li>The thermal conductances as well as the coolant flow are parametrized such way, that:<li>
</ul>
<ol>
<li>the total coolant's temperature rise is 10 K (over coolant inlet)</li>
<li>the core's temperature rise is 27.5 K (over coolant's average temperature between inlet and outlet)</li>
<li>the armature's temperature rise is 55 K (over coolant's average temperature between inlet and outlet)</li>
</ol>
Simulate for 25 seconds and plot (versus time):
<ul>
<li>armature.T: armature temperature</li>
<li>core.T: core temperature</li>
<li>cooling.T: coolant temperature at outlet</li>
</ul>
Therefore the armature temperature would reach nominal armature temperature at constant nominal load.<br>
Default machine parameters are used, but:
<ul>
<li>The aramature winding material is set to Copper.</li>
<li>Armature reference temperature is set to 80 degC.</li>
<li>Nominal armature temperature is set to 80 degC.</li>
</ul>
</HTML>"));
    end DCPM_Cooling;

    model DCPM_QuasiStationary
      "Test example 15: Compare DCPM motors transient - quasistationary"
      extends Modelica.Icons.Example2;
      parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
      parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
      parameter Modelica.SIunits.AngularVelocity w0=Modelica.SIunits.Conversions.from_rpm(1500)
        "No-load speed";
      parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
      parameter Modelica.SIunits.Inertia JLoad=0.15 "Load's moment of inertia";
      Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm1(
              wMechanical(start=w0, fixed=true), alpha20a(displayUnit="1/K"))
        annotation (Placement(transformation(extent={{-20,20},{0,40}},
              rotation=0)));

      Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                                                                       rotation=90,
            origin={-80,50})));
      Modelica.Electrical.Analog.Basic.Ground groundArmature
        annotation (Placement(transformation(
            origin={-80,20},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J=JLoad)
        annotation (Placement(transformation(extent={{10,20},{30,40}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque loadTorque1(useSupport=false)
        annotation (Placement(transformation(extent={{60,20},{40,40}},  rotation=0)));
      Modelica.Blocks.Sources.Pulse pulse(
        amplitude=-1.5*TLoad,
        offset=0,
        period=1)
        annotation (Placement(transformation(extent={{100,-10},{80,10}})));
      Machines.BasicMachines.QuasiStationaryDCMachines.DC_PermanentMagnet dcpm2
        (     wMechanical(start=w0, fixed=true), alpha20a(displayUnit="1/K"))
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia2(J=JLoad)
        annotation (Placement(transformation(extent={{10,-40},{30,-20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque loadTorque2(useSupport=false)
        annotation (Placement(transformation(extent={{60,-40},{40,-20}},rotation=0)));
    equation
      connect(loadInertia1.flange_b, loadTorque1.flange)
        annotation (Line(points={{30,30},{30,30},{40,30}},
                                                     color={0,0,0}));
      connect(dcpm1.flange, loadInertia1.flange_a)
                                                 annotation (Line(
          points={{0,30},{10,30}},
          color={0,0,0},
          smooth=Smooth.None));

      connect(armatureVoltage.n, groundArmature.p) annotation (Line(
          points={{-80,40},{-80,30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(armatureVoltage.p, dcpm1.pin_ap)
                                              annotation (Line(
          points={{-80,60},{-4,60},{-4,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(armatureVoltage.n, dcpm1.pin_an)
                                              annotation (Line(
          points={{-80,40},{-16,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(pulse.y, loadTorque1.tau)
                                       annotation (Line(
          points={{79,0},{70,0},{70,30},{62,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(loadInertia2.flange_b,loadTorque2. flange)
        annotation (Line(points={{30,-30},{30,-30},{40,-30}},
                                                     color={0,0,0}));
      connect(dcpm2.flange,loadInertia2. flange_a)
                                                 annotation (Line(
          points={{0,-30},{10,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(pulse.y, loadTorque2.tau) annotation (Line(
          points={{79,0},{70,0},{70,-30},{62,-30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(armatureVoltage.p, dcpm2.pin_ap) annotation (Line(
          points={{-80,60},{-40,60},{-40,0},{-4,0},{-4,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(armatureVoltage.n, dcpm2.pin_an) annotation (Line(
          points={{-80,40},{-60,40},{-60,-20},{-16,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}),
                graphics),
        experiment(StopTime=2, Interval=0.001),
        Documentation(info="<HTML>
<b>15th Test example: Compare DCPM motors transient and quasistationary</b><br>
The motors start at no-load speed, then load pulses are applied.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcpm1.ia: armature current of transient model</li>
<li>dcpm1.wMechanical: motor's speed of transient model</li>
<li>dcpm1.tauElectrical: motor's torque of transient model</li>
<li>dcpm2.ia: armature current of quasistationary model</li>
<li>dcpm2.wMechanical: motor's speed of quasistationary model</li>
<li>dcpm2.tauElectrical: motor's torque of quasistationary model</li>
</ul>
</HTML>"),
        experimentSetupOutput);
    end DCPM_QuasiStationary;

    model AIMC_Steinmetz
      "AsynchronousInductionMachineSquirrelCage Steinmetz-connection"
      extends Modelica.Icons.Example2;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
      parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
      parameter Modelica.SIunits.Capacitance Cr=0.0035
        "Motor's running capacitor";
      parameter Modelica.SIunits.Capacitance Cs=5*Cr
        "Motor's (additional) starting capacitor";
      parameter Modelica.SIunits.AngularVelocity wSwitch(displayUnit="1/min")=1350*2*Modelica.Constants.pi/60
        "Speed for switching off the starting capacitor";
      parameter Modelica.SIunits.Torque TLoad=2/3*161.4 "Nominal load torque";
      parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="1/min")=1462.5*2*Modelica.Constants.pi/60
        "Nominal load speed";
      parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";

      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
        aimc(useSupport=true)
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz=
            fNominal, V=sqrt(2)*VNominal)
        annotation (Placement(transformation(extent={{-50,100},{-70,80}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-90,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=tStart1)
        annotation (Placement(transformation(extent={{-50,60},{-30,80}},
              rotation=0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealCloser
        annotation (Placement(transformation(
            origin={-20,90},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Components.Inertia loadInertia(
                                                        J=JLoad)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
        quadraticLoadTorque(
        w_nominal=wLoad,
        TorqueDirection=false,
        tau_nominal=-TLoad)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}},
              rotation=0)));
      Machines.Utilities.TerminalBox TerminalBox1(
                                         terminalConnection="D")
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p3(m=m, k=3)
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p2(m=m, k=2)
        annotation (Placement(transformation(
            origin={-10,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p1(m=m, k=1)
        annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Basic.Capacitor cRun(C=Cr)
        annotation (Placement(transformation(
            origin={10,20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Capacitor cStart(C=Cs)
        annotation (Placement(transformation(
            origin={30,20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealOpener
        annotation (Placement(transformation(
            origin={30,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
        wSwitch)
        annotation (Placement(transformation(
            origin={50,20},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed
        annotation (Placement(transformation(extent={{70,-70},{90,-50}})));
      Modelica.Mechanics.Rotational.Sensors.RelSpeedSensor relSpeedSensor
                                                                 annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-50})));
    equation
      connect(ground.p, sineVoltage.n)
        annotation (Line(points={{-80,90},{-70,90}}, color={0,0,255}));
      connect(sineVoltage.p, idealCloser.p)
        annotation (Line(points={{-50,90},{-30,90}}, color={0,0,255}));
      connect(booleanStep.y, idealCloser.control)  annotation (Line(points={{
              -29,70},{-20,70},{-20,83}}, color={255,0,255}));
      connect(plugToPin_p3.pin_p, sineVoltage.n)  annotation (Line(points={{-30,
              -8},{-70,-8},{-70,90}}, color={0,0,255}));
      connect(idealCloser.n, plugToPin_p2.pin_p)
        annotation (Line(points={{-10,90},{-10,-8}}, color={0,0,255}));
      connect(cRun.n, plugToPin_p1.pin_p)
        annotation (Line(points={{10,10},{10,-8}}, color={0,0,255}));
      connect(loadInertia.flange_b, quadraticLoadTorque.flange)
        annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
      connect(cRun.p, idealCloser.n)       annotation (Line(points={{10,30},{10,
              90},{-10,90}}, color={0,0,255}));
      connect(plugToPin_p1.pin_p,cStart. n)     annotation (Line(points={{10,-8},
              {30,-8},{30,10}}, color={0,0,255}));
      connect(idealOpener.n, cStart.p)
        annotation (Line(points={{30,40},{30,37.5},{30,37.5},{30,35},{30,30},{
              30,30}},                             color={0,0,255}));
      connect(idealOpener.p, idealCloser.n)   annotation (Line(points={{30,60},
              {30,90},{-10,90}}, color={0,0,255}));
      connect(greaterThreshold.y, idealOpener.control)  annotation (Line(points=
             {{50,31},{50,50},{37,50}}, color={255,0,255}));
      connect(TerminalBox1.plug_sn, aimc.plug_sn)  annotation (Line(
          points={{-16,-30},{-16,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(TerminalBox1.plug_sp, aimc.plug_sp)  annotation (Line(
          points={{-4,-30},{-4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(TerminalBox1.plugSupply, plugToPin_p2.plug_p) annotation (Line(
          points={{-10,-28},{-10,-12}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(TerminalBox1.plugSupply, plugToPin_p3.plug_p) annotation (Line(
          points={{-10,-28},{-10,-20},{-30,-20},{-30,-12}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(TerminalBox1.plugSupply, plugToPin_p1.plug_p) annotation (Line(
          points={{-10,-28},{-10,-20},{10,-20},{10,-12}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(quadraticLoadTorque.support, fixed.flange) annotation (Line(
          points={{80,-50},{80,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(relSpeedSensor.flange_a, fixed.flange) annotation (Line(
          points={{20,-60},{80,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(relSpeedSensor.w_rel, greaterThreshold.u) annotation (Line(
          points={{31,-50},{30,-50},{30,-20},{50,-20},{50,8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(aimc.support, fixed.flange) annotation (Line(
          points={{0,-50},{0,-60},{80,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(aimc.flange, relSpeedSensor.flange_b) annotation (Line(
          points={{0,-40},{20,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(aimc.flange, loadInertia.flange_a) annotation (Line(
          points={{0,-40},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=1.5, Interval=0.001),
        Documentation(info="<HTML>
<b>Asynchronous induction machine with squirrel cage - Steinmetz-connection</b><br>
At start time tStart single phase voltage is supplied to the asynchronous induction machine with squirrel cage;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Default machine parameters of model <i>AIM_SquirrelCage</i> are used.
</HTML>"));
    end AIMC_Steinmetz;

    model TransformerTestbench "Transformer Testbench"
      extends Modelica.Icons.Example2;
      parameter Modelica.SIunits.Resistance RL[3]=fill(1/3,3) "Load resistance";
      Modelica.Electrical.MultiPhase.Sources.SineVoltage source(freqHz=fill(50, 3),
          V=fill(sqrt(2/3)*100, 3))
        annotation (Placement(transformation(
            origin={-90,-10},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Star starS
        annotation (Placement(transformation(
            origin={-90,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundS
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}},
              rotation=0)));
      Machines.Sensors.ElectricalPowerSensor electricalPowerSensorS
        annotation (Placement(transformation(extent={{-90,0},{-70,20}},
              rotation=0)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorS
        annotation (Placement(transformation(extent={{-60,20},{-40,0}},
              rotation=0)));
      Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensorS
        annotation (Placement(transformation(
            origin={-40,-10},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Delta deltaS
        annotation (Placement(transformation(
            origin={-40,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor earth(R=1e6)
        annotation (Placement(transformation(
            origin={0,-40},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundT
        annotation (Placement(transformation(extent={{-10,-80},{10,-60}},
              rotation=0)));
      Machines.Sensors.VoltageQuasiRMSSensor voltageRMSSensorL
        annotation (Placement(transformation(
            origin={40,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Delta deltaL
        annotation (Placement(transformation(
            origin={40,-30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorL
        annotation (Placement(transformation(extent={{40,20},{60,0}}, rotation=
                0)));
      Machines.Sensors.ElectricalPowerSensor electricalPowerSensorL
        annotation (Placement(transformation(extent={{70,0},{90,20}}, rotation=
                0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor load(R=RL)
        annotation (Placement(transformation(
            origin={90,-10},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Star starL
        annotation (Placement(transformation(
            origin={90,-40},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundL
        annotation (Placement(transformation(extent={{80,-80},{100,-60}},
              rotation=0)));
      Machines.Utilities.TransformerData transformerData(
        C1=Modelica.Utilities.Strings.substring(transformer.VectorGroup,1,1),
        C2=Modelica.Utilities.Strings.substring(transformer.VectorGroup,2,2))
                                              annotation (Placement(
            transformation(extent={{-10,40},{10,60}}, rotation=0)));
      Machines.BasicMachines.Transformers.Yd.Yd01 transformer(
        n=transformerData.n,
        R1=transformerData.R1,
        L1sigma=transformerData.L1sigma,
        R2=transformerData.R2,
        L2sigma=transformerData.L2sigma) annotation (Placement(transformation(
              extent={{-20,-10},{20,30}}, rotation=0)));
    equation
      connect(starS.pin_n, groundS.p)
        annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
      connect(source.plug_n, starS.plug_p)
        annotation (Line(points={{-90,-20},{-90,-30}}, color={0,0,255}));
      connect(starL.pin_n, groundL.p)
        annotation (Line(points={{90,-50},{90,-60}}, color={0,0,255}));
      connect(load.plug_n, starL.plug_p)
        annotation (Line(points={{90,-20},{90,-30}}, color={0,0,255}));
      connect(earth.n, groundT.p)
        annotation (Line(points={{-1.83697e-015,-50},{0,-50},{0,-60}}, color={0,
              0,255}));
      connect(electricalPowerSensorS.plug_nv, starS.plug_p)
        annotation (Line(points={{-80,0},{-80,-30},{-90,-30}}, color={0,0,255}));
      connect(source.plug_p, electricalPowerSensorS.plug_p)
        annotation (Line(points={{-90,-1.77636e-015},{-90,10}},
                                                    color={0,0,255}));
      connect(electricalPowerSensorS.plug_ni, currentQuasiRMSSensorS.plug_p)
        annotation (Line(points={{-70,10},{-60,10}}, color={0,0,255}));
      connect(currentQuasiRMSSensorL.plug_n, electricalPowerSensorL.plug_p)
        annotation (Line(points={{60,10},{70,10}}, color={0,0,255}));
      connect(electricalPowerSensorL.plug_ni, load.plug_p)
        annotation (Line(points={{90,10},{90,-1.77636e-015}},
                                                  color={0,0,255}));
      connect(currentQuasiRMSSensorS.plug_n, voltageQuasiRMSSensorS.plug_p)
        annotation (Line(points={{-40,10},{-40,-1.77636e-015}},
                                                    color={0,0,255}));
      connect(currentQuasiRMSSensorL.plug_p, voltageRMSSensorL.plug_p)
        annotation (Line(points={{40,10},{40,0}}, color={0,0,255}));
      connect(electricalPowerSensorL.plug_nv, starL.plug_p)
        annotation (Line(points={{80,0},{80,-30},{90,-30}}, color={0,0,255}));
      connect(voltageQuasiRMSSensorS.plug_n, deltaS.plug_p)
        annotation (Line(points={{-40,-20},{-40,-20}}, color={0,0,255}));
      connect(deltaL.plug_p, voltageRMSSensorL.plug_n)
        annotation (Line(points={{40,-20},{40,-20}}, color={0,0,255}));
      connect(deltaS.plug_n, voltageQuasiRMSSensorS.plug_p)
        annotation (Line(points={{-40,-40},{-50,-40},{-50,-1.77636e-015},{-40,
              -1.77636e-015}},                                         color={0,
              0,255}));
      connect(deltaL.plug_n, voltageRMSSensorL.plug_p)
        annotation (Line(points={{40,-40},{50,-40},{50,0},{40,0}}, color={0,0,
              255}));
      connect(currentQuasiRMSSensorS.plug_n, transformer.plug1)
                                                           annotation (Line(
          points={{-40,10},{-20,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(transformer.plug2, currentQuasiRMSSensorL.plug_p)
                                                           annotation (Line(
          points={{20,10},{40,10}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (Documentation(info="<HTML>
Transformer testbench:<br>
You may choose different connections as well as vary the load (even not symmetrical).<br>
<b>Please pay attention</b> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).<br>
In some cases it may be necessary to ground the transformer's starpoint
even though the source's or load's starpoint are grounded; you may use a reasonable high earthing resistance.
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        experiment(StopTime=0.1));
    end TransformerTestbench;

    model Rectifier6pulse "6-pulse rectifier with 1 transformer"
      extends Modelica.Icons.Example2;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=100*sqrt(2/3)
        "Amplitude of star-voltage";
      parameter Modelica.SIunits.Frequency f=50 "Frequency";
      parameter Modelica.SIunits.Resistance RL=0.4 "Load resistance";
      parameter Modelica.SIunits.Capacitance C=0.005 "Total DC-capacitance";
      parameter Modelica.SIunits.Voltage VC0=sqrt(3)*V
        "Initial voltage of capacitance";
      Modelica.Electrical.MultiPhase.Sources.SineVoltage source(
        m=m,
        V=fill(V, m),
        freqHz=fill(f, m)) annotation (Placement(transformation(
            origin={-90,-10},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Star starAC(m=m)
        annotation (Placement(transformation(
            origin={-90,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundAC
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor(m=m)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode1(m=m)
        annotation (Placement(transformation(
            origin={-20,60},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.MultiPhase.Basic.Star star1(m=m)
        annotation (Placement(transformation(
            origin={0,70},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode2(m=m)
        annotation (Placement(transformation(
            origin={-20,20},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.MultiPhase.Basic.Star star2(m=m)
        annotation (Placement(transformation(extent={{-10,0},{10,20}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Resistor load(R=RL)
        annotation (Placement(transformation(
            origin={50,0},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Capacitor cDC1(C=2*C, v(start=VC0/2))
        annotation (Placement(transformation(
            origin={70,20},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Capacitor cDC2(C=2*C, v(start=VC0/2))
        annotation (Placement(transformation(
            origin={70,-20},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundDC
        annotation (Placement(transformation(extent={{80,-20},{100,0}},
              rotation=0)));
      Machines.Utilities.TransformerData transformerData1(
        C1=Modelica.Utilities.Strings.substring(transformer1.VectorGroup,1,1),
        C2=Modelica.Utilities.Strings.substring(transformer1.VectorGroup,2,2))
                                               annotation (Placement(
            transformation(extent={{-60,60},{-40,80}}, rotation=0)));
      Machines.BasicMachines.Transformers.Dy.Dy01 transformer1(
        n=transformerData1.n,
        R1=transformerData1.R1,
        L1sigma=transformerData1.L1sigma,
        R2=transformerData1.R2,
        L2sigma=transformerData1.L2sigma) annotation (Placement(transformation(
              extent={{-50,30},{-30,50}}, rotation=0)));
    equation
      connect(cDC1.n, cDC2.p)
        annotation (Line(points={{70,10},{70,-10}}, color={0,0,255}));
      connect(cDC1.n, groundDC.p)
        annotation (Line(points={{70,10},{70,0},{90,0}}, color={0,0,255}));
      connect(starAC.plug_p, source.plug_n)
        annotation (Line(points={{-90,-30},{-90,-20}}, color={0,0,255}));
      connect(diode1.plug_n, star1.plug_p)
        annotation (Line(points={{-20,70},{-10,70}}, color={0,0,255}));
      connect(diode2.plug_p, star2.plug_p)
        annotation (Line(points={{-20,10},{-10,10}}, color={0,0,255}));
      connect(diode2.plug_n, diode1.plug_p)
        annotation (Line(points={{-20,30},{-20,50}}, color={0,0,255}));
      connect(starAC.pin_n, groundAC.p)
        annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
      connect(source.plug_p, currentSensor.plug_p)
        annotation (Line(points={{-90,-1.77636e-015},{-85,-1.77636e-015},{-85,0},
              {-80,0}},                            color={0,0,255}));
      connect(load.p, cDC1.p)
        annotation (Line(points={{50,10},{50,30},{70,30}}, color={0,0,255}));
      connect(load.n, cDC2.n)
        annotation (Line(points={{50,-10},{50,-30},{70,-30}}, color={0,0,255}));
      connect(star1.pin_n, cDC1.p)
        annotation (Line(points={{10,70},{70,70},{70,30}}, color={0,0,255}));
      connect(star2.pin_n, cDC2.n)
        annotation (Line(points={{10,10},{20,10},{20,-70},{70,-70},{70,-30}},
            color={0,0,255}));
      connect(transformer1.plug1, currentSensor.plug_n) annotation (Line(
          points={{-50,40},{-60,40},{-60,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(transformer1.plug2, diode1.plug_p) annotation (Line(
          points={{-30,40},{-20,40},{-20,50}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (Documentation(info="<HTML>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a transformer a diode bridge rectifier with a DC burden.<br>
Using f=50 Hz, simulate for 0.1 seconds (5 periods) and compare voltages and currents of source and DC burden,
neglecting initial transient.
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                   graphics),
        experiment(StopTime=0.1));
    end Rectifier6pulse;

    model Rectifier12pulse "12-pulse rectifier with 2 transformers"
      extends Machines.Examples.Rectifier6pulse(RL=0.2);
      Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode3(m=m)
        annotation (Placement(transformation(
            origin={-20,-20},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.MultiPhase.Basic.Star star3(m=m)
        annotation (Placement(transformation(extent={{-10,0},{10,-20}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode4(m=m)
        annotation (Placement(transformation(
            origin={-20,-60},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.MultiPhase.Basic.Star star4(m=m)
        annotation (Placement(transformation(extent={{-10,-60},{10,-80}},
              rotation=0)));
      Machines.BasicMachines.Transformers.Dd.Dd00 transformer2(
        n=transformerData2.n,
        R1=transformerData2.R1,
        L1sigma=transformerData2.L1sigma,
        R2=transformerData2.R2,
        L2sigma=transformerData2.L2sigma) annotation (Placement(transformation(
              extent={{-50,-50},{-30,-30}}, rotation=0)));
      Machines.Utilities.TransformerData transformerData2(
        C1=Modelica.Utilities.Strings.substring(transformer2.VectorGroup,1,1),
        C2=Modelica.Utilities.Strings.substring(transformer2.VectorGroup,2,2))
                                               annotation (Placement(
            transformation(extent={{-60,-80},{-40,-60}}, rotation=0)));
    equation
      connect(diode3.plug_n, star3.plug_p)
        annotation (Line(points={{-20,-10},{-10,-10}}, color={0,0,255}));
      connect(diode4.plug_p, star4.plug_p)
        annotation (Line(points={{-20,-70},{-10,-70}}, color={0,0,255}));
      connect(diode4.plug_n, diode3.plug_p)
        annotation (Line(points={{-20,-50},{-20,-30}}, color={0,0,255}));
      connect(star4.pin_n, cDC2.n)
        annotation (Line(points={{10,-70},{70,-70},{70,-30}}, color={0,0,255}));
      connect(star3.pin_n, cDC1.p)
        annotation (Line(points={{10,-10},{18,-10},{18,-8},{22,-8},{22,-10},{30,
              -10},{30,70},{70,70},{70,30}}, color={0,0,255}));
      connect(transformer2.plug2, diode4.plug_n) annotation (Line(
          points={{-30,-40},{-20,-40},{-20,-50}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(transformer2.plug1, currentQuasiRMSSensor.plug_n) annotation (Line(
          points={{-50,-40},{-60,-40},{-60,0}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (Documentation(info="<HTML>
Test example with multiphase components:<br>
Star-connected voltage source feeds via two transformers (Dd0 and Dy1) two diode bridge rectifiers with a single DC burden.<br>
Using f=50 Hz, simulate for 0.1 seconds (5 periods) and compare voltages and currents of source and DC burden,
neglecting initial transient.
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                   graphics),
        experiment(StopTime=0.1));
    end Rectifier12pulse;

    annotation (Documentation(info="<HTML>
This package contains test examples of electric machines.
</HTML>", revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.01 2004/09/18 Anton Haumer<br>
       adapted to improved MoveToRotational</li>
  <li> v1.02 2004/09/19 Anton Haumer<br>
       added examples for DC machines</li>
  <li> v1.03 2004/09/24 Anton Haumer<br>
       usage of Sensors.CurrentRMSSensor<br>
       added example for DC machine with series excitation</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.3.1 2004/11/06 Anton Haumer<br>
       small changes in Utilities.VfController</li>
  <li> v1.52 2005/10/12 Anton Haumer<br>
       new example for electrical excited synchronous induction machine</li>
  <li> v1.6.1 2004/11/22 Anton Haumer<br>
       introduced Utilities.TerminalBox</li>
  <li> v2.1.2 2010/02/09 Anton Haumer<br>
       included new Examples (AIMC_Transformer, DC_Comparison)</li>
  </ul>
</HTML>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Ellipse(extent={{-80,44},{60,-96}},
              lineColor={95,95,95}), Polygon(
            points={{-40,36},{-40,-88},{60,-26},{-40,36}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid)}));
  end Examples;

  package BasicMachines "Basic machine models"
    extends Modelica.Icons.Library2;

    package AsynchronousInductionMachines
      "Models of asynchronous induction machines"
      extends Modelica.Icons.Library;

      model AIM_SquirrelCage
        "Asynchronous induction machine with squirrel cage rotor"
        extends Machines.Interfaces.PartialBasicInductionMachine(
          final idq_ss = airGapS.i_ss,
          final idq_sr = airGapS.i_sr,
          final idq_rs = airGapS.i_rs,
          final idq_rr = airGapS.i_rr,
          redeclare final
            Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMC
            thermalAmbient(final Tr=TrOperational),
          redeclare final
            Machines.Interfaces.AsynchronousInductionMachines.ThermalPortAIMC
            thermalPort,
          redeclare final
            Machines.Interfaces.AsynchronousInductionMachines.ThermalPortAIMC
            internalThermalPort);
        Components.AirGapS airGapS(            final p=p, final m=3, final Lm=Lm)
          annotation (Placement(transformation(
              origin={0,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        parameter Modelica.SIunits.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi*fsNominal))
          "Main field inductance"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lrsigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal))
          "Rotor stray inductance (equivalent three phase winding)"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance Rr(start=0.04)
          "Rotor resistance (equivalent three phase winding) at TRef"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of rotor resistance"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(
                   start=0)
          "Temperature coefficient of rotor resistance at 20 degC"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of rotor resistance"
           annotation(Dialog(group="Operational temperatures", enable=not useThermalPort));
        Machines.BasicMachines.Components.SquirrelCage squirrelCageR(
          final Lrsigma=Lrsigma,
          final Rr=Rr,
          final useHeatPort=true,
          final T_ref=TrRef,
          final T=TrRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef))
          annotation (Placement(transformation(
              origin={0,-30},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      equation
        connect(airGapS.spacePhasor_r, squirrelCageR.spacePhasor_r)
          annotation (Line(points={{10,-10},{10,-20},{10,-20}},
                                                       color={0,0,255}));
        connect(spacePhasorS.spacePhasor, airGapS.spacePhasor_s) annotation (Line(
            points={{10,20},{10,20},{10,10},{10,10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapS.support, internalSupport) annotation (Line(
            points={{-10,1.83697e-015},{-10,0},{-40,0},{-40,-90},{60,-90},{60,
                -100}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(airGapS.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,-1.83697e-015},{36,-1.83697e-015},{36,1.22465e-015},{70,
                1.22465e-015}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(squirrelCageR.heatPort, internalThermalPort.heatPort_r)
          annotation (Line(
            points={{-10,-30},{50,-30},{50,-80},{0,-80}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (defaultComponentName="aimc",
          Documentation(info="<HTML>
<b>Model of a three phase asynchronous induction machine with squirrel cage.</b><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed ccordinate system. Both together connected via a stator-fixed <i>AirGap</i> model. Only losses in stator and rotor resistance are taken into account.
<br><b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">number of pole pairs p</td>
<td valign=\"top\">2</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">rotor's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">nominal frequency fNominal</td>
<td valign=\"top\">50</td><td valign=\"top\">Hz</td>
</tr>
<tr>
<td valign=\"top\">nominal voltage per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">V RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal current per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">A RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal torque</td>
<td valign=\"top\">161.4</td><td valign=\"top\">Nm</td>
</tr>
<tr>
<td valign=\"top\">nominal speed</td>
<td valign=\"top\">1440.45</td><td valign=\"top\">rpm</td>
</tr>
<tr>
<td valign=\"top\">nominal mechanical output</td>
<td valign=\"top\">24.346</td><td valign=\"top\">kW</td>
</tr>
<tr>
<td valign=\"top\">efficiency</td>
<td valign=\"top\">92.7</td><td valign=\"top\">%</td>
</tr>
<tr>
<td valign=\"top\">power factor</td>
<td valign=\"top\">0.875</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator resistance</td>
<td valign=\"top\">0.03</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TsRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20s </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">rotor resistance</td>
<td valign=\"top\">0.04</td><td valign=\"top\">Ohm at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TrRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20r </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">stator reactance Xs</td>
<td valign=\"top\">3</td><td valign=\"top\">Ohm per phase</td>
</tr>
<tr>
<td valign=\"top\">rotor reactance Xr</td>
<td valign=\"top\">3</td><td valign=\"top\">Ohm</td>
</tr>
<tr>
<td valign=\"top\">total stray coefficient sigma</td>
<td valign=\"top\">0.0667</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator operational temperature TsOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">rotor operational temperature TrOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">These values give the following inductances:</td>
<td valign=\"top\"> </td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator stray inductance per phase</td>
<td valign=\"top\">Xs * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">rotor stray inductance</td>
<td valign=\"top\">Xr * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">main field inductance per phase</td>
<td valign=\"top\">sqrt(Xs*Xr * (1-sigma))/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
</table>
</HTML>"),       Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}}),
                         graphics));
      end AIM_SquirrelCage;

      model AIM_SlipRing "Asynchronous induction machine with slipring rotor"
        extends Machines.Interfaces.PartialBasicInductionMachine(
          final idq_ss = airGapS.i_ss,
          final idq_sr = airGapS.i_sr,
          final idq_rs = airGapS.i_rs,
          final idq_rr = airGapS.i_rr,
          redeclare final
            Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMS
            thermalAmbient(final Tr=TrOperational),
          redeclare final
            Machines.Interfaces.AsynchronousInductionMachines.ThermalPortAIMS
            thermalPort,
          redeclare final
            Machines.Interfaces.AsynchronousInductionMachines.ThermalPortAIMS
            internalThermalPort);
        Components.AirGapS airGapS(final p=p, final m=3, final Lm=Lm)
          annotation (Placement(transformation(
              origin={0,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        parameter Modelica.SIunits.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi*fsNominal))
          "Main field inductance"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lrsigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal))
          "Rotor stray inductance per phase"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance Rr(start=0.04)
          "Rotor resistance per phase at TRef"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of rotor resistance"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(
                   start=0)
          "Temperature coefficient of rotor resistance at 20 degC"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useTurnsRatio(start=true)
          "Use turnsRatio or calculate from locked-rotor voltage?";
        parameter Real turnsRatio(final min=Modelica.Constants.small, start=1)
          "Effective number of stator turns / effective number of rotor turns"
          annotation(Dialog(enable=useTurnsRatio));
        parameter Modelica.SIunits.Voltage VsNominal(start=100)
          "Nominal stator voltage per phase"
          annotation(Dialog(enable=not useTurnsRatio));
        parameter Modelica.SIunits.Voltage VrLockedRotor(start=100*(2*pi*fsNominal*Lm)/sqrt(Rs^2+(2*pi*fsNominal*(Lm+Lssigma))^2))
          "Locked-rotor voltage per phase"
          annotation(Dialog(enable=not useTurnsRatio));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of rotor resistance"
           annotation(Dialog(group="Operational temperatures", enable=not useThermalPort));
        output Modelica.SIunits.Current i_0_r(stateSelect=StateSelect.prefer) = spacePhasorR.zero.i
          "Rotor zero-sequence current";
        output Modelica.SIunits.Voltage vr[m] = plug_rp.pin.v - plug_rn.pin.v
          "Rotor instantaneous voltages";
        output Modelica.SIunits.Current ir[m] = plug_rp.pin.i
          "Rotor instantaneous currents";
      protected
        final parameter Real internalTurnsRatio=if useTurnsRatio then turnsRatio else
          VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs^2+(2*pi*fsNominal*(Lm+Lssigma))^2);
      public
        Machines.SpacePhasors.Components.SpacePhasor spacePhasorR(final
            turnsRatio =                                                           internalTurnsRatio)
          annotation (Placement(transformation(
              origin={0,-30},
              extent={{-10,10},{10,-10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Inductor lrsigma(final m=m, final L=fill(Lrsigma, m))
          annotation (Placement(transformation(extent={{20,-80},{40,-60}},
                rotation=0)));
        Modelica.Electrical.MultiPhase.Basic.Resistor rr(
          final m=m,
          final R=fill(Rr, m),
          final T_ref=fill(TrRef,m),
          final alpha=fill(Machines.Thermal.convertAlpha(
                                                alpha20r, TrRef), m),
          final useHeatPort=true,
          final T=fill(TrRef,m))
          annotation (Placement(transformation(extent={{40,-40},{20,-60}},
                rotation=0)));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_rp(final m=m)
          "Positive rotor plug"
          annotation (Placement(transformation(extent={{-110,70},{-90,50}},
                rotation=0)));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_rn(final m=m)
          "Negative rotor plug"
          annotation (Placement(transformation(extent={{-110,-50},{-90,-70}},
                rotation=0)));
      equation
        connect(spacePhasorR.ground, spacePhasorR.zero) annotation (Line(
            points={{-10,-20},{-10,-14},{6.12323e-016,-14},{6.12323e-016,-20}},
            color={0,0,255}));

        connect(airGapS.spacePhasor_r, spacePhasorR.spacePhasor)
          annotation (Line(points={{10,-10},{10,-15},{10,-15},{10,-20}},
                                                       color={0,0,255}));
        connect(spacePhasorS.spacePhasor, airGapS.spacePhasor_s) annotation (Line(
            points={{10,20},{10,20},{10,10},{10,10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapS.support, internalSupport) annotation (Line(
            points={{-10,1.83697e-015},{-40,1.83697e-015},{-40,-90},{60,-90},{
                60,-100}},
            color={0,0,0},
            smooth=Smooth.None));

        connect(airGapS.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,-1.83697e-015},{34,-1.83697e-015},{34,1.22465e-015},{70,
                1.22465e-015}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(spacePhasorR.plug_n, plug_rn) annotation (Line(
            points={{-10,-40},{-10,-60},{-100,-60}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(rr.heatPort, internalThermalPort.heatPort_r) annotation (Line(
            points={{30,-40},{50,-40},{50,-80},{0,-80}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(rr.plug_n, spacePhasorR.plug_p) annotation (Line(
            points={{20,-50},{10,-50},{10,-40}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(rr.plug_p, lrsigma.plug_n) annotation (Line(
            points={{40,-50},{40,-70}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(lrsigma.plug_p, plug_rp) annotation (Line(
            points={{20,-70},{-80,-70},{-80,60},{-100,60}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (defaultComponentName="aims",
          Documentation(info="<HTML>
<b>Model of a three phase asynchronous induction machine with slipring rotor.</b><br>
Resistance and stray inductance of stator and rotor are modeled directly in stator respectively rotor phases, then using space phasor transformation and a stator-fixed <i>AirGap</i> model. Only losses in stator and rotor resistance are taken into account.
<br><b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">number of pole pairs p</td>
<td valign=\"top\">2</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">rotor's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">nominal frequency fNominal</td>
<td valign=\"top\">50</td><td valign=\"top\">Hz</td>
</tr>
<tr>
<td valign=\"top\">nominal voltage per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">V RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal current per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">A RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal torque</td>
<td valign=\"top\">161.4</td><td valign=\"top\">Nm</td>
</tr>
<tr>
<td valign=\"top\">nominal speed</td>
<td valign=\"top\">1440.45</td><td valign=\"top\">rpm</td>
</tr>
<tr>
<td valign=\"top\">nominal mechanical output</td>
<td valign=\"top\">24.346</td><td valign=\"top\">kW</td>
</tr>
<tr>
<td valign=\"top\">efficiency</td>
<td valign=\"top\">92.7</td><td valign=\"top\">%</td>
</tr>
<tr>
<td valign=\"top\">power factor</td>
<td valign=\"top\">0.875</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator resistance</td>
<td valign=\"top\">0.03</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TsRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20s </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">rotor resistance</td>
<td valign=\"top\">0.04</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TrRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20r </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">stator reactance Xs</td>
<td valign=\"top\">3</td><td valign=\"top\">Ohm per phase</td>
</tr>
<tr>
<td valign=\"top\">rotor reactance Xr</td>
<td valign=\"top\">3</td><td valign=\"top\">Ohm per phase</td>
</tr>
<tr>
<td valign=\"top\">total stray coefficient sigma</td>
<td valign=\"top\">0.0667</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">turnsRatio</td>
<td valign=\"top\">1</td><td valign=\"top\">effective ratio of stator and rotor current</td>
</tr>
<tr>
<td valign=\"top\">stator operational temperature TsOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">rotor operational temperature TrOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">These values give the following inductances:</td>
<td valign=\"top\"> </td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator stray inductance per phase</td>
<td valign=\"top\">Xs * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">rotor stray inductance</td>
<td valign=\"top\">Xr * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">main field inductance per phase</td>
<td valign=\"top\">sqrt(Xs*Xr * (1-sigma))/(2*pi*f)</td><td valign=\"top\"> </td>
</tr>
</table>
<p>
Parameter turnsRatio could be obtained from the following relationship
at standstill with open rotor circuit at nominal voltage and nominal frequency, <br>
using the locked-rotor voltage VR, no-load stator current I0 and powerfactor PF0:<br>
turnsRatio * <u>V</u><sub>R</sub> = <u>V</u><sub>s</sub> - (R<sub>s</sub> + j X<sub>s,sigma</sub>) <u>I</u><sub>0</sub>
</p>
</HTML>"),   Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}}),
                     graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Line(points={{-100,50},{-100,20},{-60,
                    20}}, color={0,0,255}), Line(points={{-100,-50},{-100,-20},
                    {-60,-20}}, color={0,0,255})}));
      end AIM_SlipRing;

      annotation (Documentation(info="<HTML>
This package contains models of asynchronous induction machines, based on space phasor theory:
<ul>
<li>AIM_SquirrelCage: asynchronous induction machine with squirrel cage</li>
<li>AIM_SlipRing: asynchronous induction machine with wound rotor</li>
</ul>
These models use package SpacePhasors.
</HTML>", revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.02 2004/09/19 Anton Haumer</li>
  <li> v1.03 2004/09/24 Anton Haumer<br>
       consistent naming of inductors and resistors in machine models</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.3.2 2004/11/10 Anton Haumer<br>
       ReluctanceRotor moved to SynchronousMachines</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v1.6.3 2005/11/25 Anton Haumer<br>
       easier parametrisation of SlipRing model</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</HTML>"));
    end AsynchronousInductionMachines;

    package SynchronousInductionMachines
      "Models of synchronous induction machines"
      extends Modelica.Icons.Library;

      model SM_PermanentMagnet "Permanent magnet synchronous induction machine"
        extends Machines.Interfaces.PartialBasicInductionMachine(
            Lssigma(start=0.1/(2*pi*fsNominal)),
            final idq_ss = airGapR.i_ss,
            final idq_sr = airGapR.i_sr,
            final idq_rs = airGapR.i_rs,
            final idq_rr = airGapR.i_rr,
          redeclare final
            Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMPM
            thermalAmbient(final useDamperCage = useDamperCage, final Tr=TrOperational),
          redeclare final
            Machines.Interfaces.SynchronousInductionMachines.ThermalPortSMPM
            thermalPort(final useDamperCage = useDamperCage),
          redeclare final
            Machines.Interfaces.SynchronousInductionMachines.ThermalPortSMPM
            internalThermalPort(final useDamperCage = useDamperCage));
        Components.AirGapR airGapR(final p=p, final m=3, final Lmd=Lmd, final Lmq=Lmq)
          annotation (Placement(transformation(
              origin={0,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage"
           annotation(Dialog(group="Operational temperatures", enable=not useThermalPort and useDamperCage));
        parameter Modelica.SIunits.Voltage VsOpenCircuit(start=112.3)
          "Open circuit RMS voltage per phase @ fsNominal";
        parameter Modelica.SIunits.Inductance Lmd(start=0.3/(2*pi*fsNominal))
          "Main field inductance in d-axis"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lmq(start=0.3/(2*pi*fsNominal))
          "Main field inductance in q-axis"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useDamperCage(start = true)
          "Enable / disable damper cage"
          annotation(Evaluate=true, Dialog(tab="Nominal resistances and inductances", group = "DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*fsNominal))
          "Damper stray inductance in d-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Damper stray inductance in q-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Damper resistance in d-axis at TRef"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Damper resistance in q-axis at TRef"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(
                   start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        output Modelica.SIunits.Current idq_dr[2](each stateSelect=StateSelect.prefer)=
          damperCage.spacePhasor_r.i_ if useDamperCage
          "Damper space phasor current / rotor fixed frame";
      protected
        final parameter Modelica.SIunits.Current Ie=sqrt(2)*VsOpenCircuit/(Lmd*2*pi*fsNominal)
          "Equivalent excitation current";
      public
        Machines.BasicMachines.Components.PermanentMagnet permanentMagnet(final Ie=Ie)
          annotation (Placement(transformation(
              origin={0,-50},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Components.DamperCage damperCage(
          final Lrsigmad=Lrsigmad,
          final Lrsigmaq=Lrsigmaq,
          final Rrd=Rrd,
          final Rrq=Rrq,
          final T_ref=TrRef,
          final alpha=Machines.Thermal.convertAlpha(
                                           alpha20r, TrRef),
          final useHeatPort=true,
          final T=TrRef) if useDamperCage
          annotation (Placement(transformation(
              origin={0,-30},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      equation
        connect(airGapR.spacePhasor_r, damperCage.spacePhasor_r) annotation (Line(
              points={{10,-10},{10,-14},{10,-20},{10,-20}},
                                          color={0,0,255}));
        connect(airGapR.spacePhasor_r, permanentMagnet.spacePhasor_r)
          annotation (Line(points={{10,-10},{20,-10},{20,-40},{10,-40}}, color=
                {0,0,255}));
        connect(spacePhasorS.spacePhasor, airGapR.spacePhasor_s) annotation (Line(
            points={{10,20},{10,15},{10,10},{10,10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapR.support, internalSupport) annotation (Line(
            points={{-10,1.83697e-015},{-40,1.83697e-015},{-40,-90},{60,-90},{
                60,-100}},
            color={0,0,0},
            smooth=Smooth.None));

        connect(airGapR.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,-1.83697e-015},{35,-1.83697e-015},{35,1.22465e-015},{70,
                1.22465e-015}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(damperCage.heatPort, internalThermalPort.heatPort_r) annotation (Line(
            points={{-10,-30},{50,-30},{50,-80},{0,-80}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (defaultComponentName="smpm",
          Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
                  100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-130,10},{-100,-10}},
                lineColor={0,0,0},
                fillColor={0,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,10},{-70,-10}},
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}),
          Documentation(info="<HTML>
<b>Model of a three phase permanent magnet synchronous induction machine.</b><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation and a rotor-fixed <i>AirGap</i> model. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed ccordinate system. Permanent magnet excitation is modelled by a constant equivalent excitation current feeding the d-axis. Only losses in stator and damper resistance are taken into account.
<br>Whether a damper cage is present or not, can be selected with Boolean parameter useDamperCage (default = true).
<br><b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">number of pole pairs p</td>
<td valign=\"top\">2</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">rotor's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">nominal frequency fNominal</td>
<td valign=\"top\">50</td><td valign=\"top\">Hz</td>
</tr>
<tr>
<td valign=\"top\">nominal voltage per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">V RMS</td>
</tr>
<tr>
<td valign=\"top\">no-load voltage per phase</td>
<td valign=\"top\">112.3</td><td valign=\"top\">V RMS @ nominal speed</td>
</tr>
<tr>
<td valign=\"top\">nominal current per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">A RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal torque</td>
<td valign=\"top\">181.4</td><td valign=\"top\">Nm</td>
</tr>
<tr>
<td valign=\"top\">nominal speed</td>
<td valign=\"top\">1500</td><td valign=\"top\">rpm</td>
</tr>
<tr>
<td valign=\"top\">nominal mechanical output</td>
<td valign=\"top\">28.5</td><td valign=\"top\">kW</td>
</tr>
<tr>
<td valign=\"top\">nominal rotor angle</td>
<td valign=\"top\">20.75</td><td valign=\"top\">degree</td>
</tr>
<tr>
<td valign=\"top\">efficiency</td>
<td valign=\"top\">95.0</td><td valign=\"top\">%</td>
</tr>
<tr>
<td valign=\"top\">power factor</td>
<td valign=\"top\">0.98</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator resistance</td>
<td valign=\"top\">0.03</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TsRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20s </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">stator reactance Xd</td>
<td valign=\"top\">0.4</td><td valign=\"top\">Ohm per phase in d-axis</td>
</tr>
<tr>
<td valign=\"top\">stator reactance Xq</td>
<td valign=\"top\">0.4</td><td valign=\"top\">Ohm per phase in q-axis</td>
</tr>
<tr>
<td valign=\"top\">stator stray reactance Xss</td>
<td valign=\"top\">0.1</td><td valign=\"top\">Ohm per phase</td>
</tr>
<tr>
<td valign=\"top\">damper resistance in d-axis</td>
<td valign=\"top\">0.04</td><td valign=\"top\">Ohm at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">damper resistance in q-axis</td>
<td valign=\"top\">same as d-axis</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">reference temperature TrRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20r </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">damper stray reactance in d-axis XDds</td>
<td valign=\"top\">0.05</td><td valign=\"top\">Ohm</td>
</tr>
<tr>
<td valign=\"top\">damper stray reactance in q-axis XDqs</td>
<td valign=\"top\">same as d-axis</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator operational temperature TsOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">damper operational temperature TrOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">These values give the following inductances:</td>
<td valign=\"top\"> </td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">main field inductance in d-axis</td>
<td valign=\"top\">(Xd - Xss)/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">main field inductance in q-axis</td>
<td valign=\"top\">(Xq - Xss)/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator stray inductance per phase</td>
<td valign=\"top\">Xss/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">damper stray inductance in d-axis</td>
<td valign=\"top\">XDds/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">damper stray inductance in q-axis</td>
<td valign=\"top\">XDqs/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
</table>
</HTML>"));
      end SM_PermanentMagnet;

      model SM_ElectricalExcited
        "Electrical excited synchronous induction machine with damper cage"
        extends Machines.Interfaces.PartialBasicInductionMachine(
            Lssigma(start=0.1/(2*pi*fsNominal)),
            final idq_ss = airGapR.i_ss,
            final idq_sr = airGapR.i_sr,
            final idq_rs = airGapR.i_rs,
            final idq_rr = airGapR.i_rr,
          redeclare final
            Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMEE
            thermalAmbient(final useDamperCage = useDamperCage, final Te=TeOperational, final Tr=TrOperational),
          redeclare final
            Machines.Interfaces.SynchronousInductionMachines.ThermalPortSMEE
            thermalPort(final useDamperCage = useDamperCage),
          redeclare final
            Machines.Interfaces.SynchronousInductionMachines.ThermalPortSMEE
            internalThermalPort(final useDamperCage = useDamperCage));
        Components.AirGapR airGapR(            final p=p, final m=3, final Lmd=Lmd, final Lmq=Lmq)
          annotation (Placement(transformation(
              origin={0,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage"
           annotation(Dialog(group="Operational temperatures", enable=not useThermalPort and useDamperCage));
        parameter Modelica.SIunits.Inductance Lmd(start=1.5/(2*pi*fsNominal))
          "Main field inductance in d-axis"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lmq(start=1.5/(2*pi*fsNominal))
          "Main field inductance in q-axis"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useDamperCage(start = true)
          "Enable / disable damper cage"
          annotation(Evaluate=true, Dialog(tab="Nominal resistances and inductances", group = "DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*fsNominal))
          "Damper stray inductance in d-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Damper stray inductance in q-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Damper resistance in d-axis at TRef"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Damper resistance in q-axis at TRef"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(
                   start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Voltage VsNominal(start=100)
          "Nominal stator RMS voltage per phase"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Current IeOpenCircuit(start=10)
          "Open circuit excitation current @ nominal voltage and frequency"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Resistance Re(start=2.5)
          "Excitation resistance at TRef"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef(start=293.15)
          "Reference temperture of excitation resistance"
           annotation(Dialog(tab="Excitation"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(
          start=0) "Temperature coefficient of excitation resistance"
           annotation(Dialog(tab="Excitation"));
        parameter Real sigmae(min=0, max=0.99, start=0.025)
          "Stray fraction of total excitation inductance"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeOperational(start=293.15)
          "Operational excitation temperature"
           annotation(Dialog(group="Operational temperatures", enable=not useThermalPort));
        output Modelica.SIunits.Current idq_dr[2](each stateSelect=StateSelect.prefer)=
          damperCage.spacePhasor_r.i_ if useDamperCage
          "Damper space phasor current / rotor fixed frame";
        output Modelica.SIunits.Voltage ve = pin_ep.v-pin_en.v
          "Excitation voltage";
        output Modelica.SIunits.Current ie = pin_ep.i "Excitation current";
      protected
        final parameter Real turnsRatio = sqrt(2)*VsNominal/(2*pi*fsNominal*Lmd*IeOpenCircuit)
          "Stator current / excitation current";
        final parameter Modelica.SIunits.Inductance Lesigma = Lmd*turnsRatio^2*3/2 * sigmae/(1-sigmae);
      public
        Components.DamperCage damperCage(
          final Lrsigmad=Lrsigmad,
          final Lrsigmaq=Lrsigmaq,
          final Rrd=Rrd,
          final Rrq=Rrq,
          final T_ref=TrRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef),
          final useHeatPort=true,
          final T=TrRef) if useDamperCage
          annotation (Placement(transformation(
              origin={0,-30},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Components.ElectricalExcitation electricalExcitation(final turnsRatio=turnsRatio)
          annotation (Placement(transformation(
              origin={0,-50},
              extent={{10,10},{-10,-10}},
              rotation=90)));
        Modelica.Electrical.Analog.Basic.Resistor re(
          final R=Re,
          final T_ref=TeRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
          final useHeatPort=true,
          final T=TeRef)
          annotation (Placement(transformation(
              origin={30,-60},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Electrical.Analog.Basic.Inductor lesigma(final L=Lesigma)
          annotation (Placement(transformation(extent={{20,-80},{40,-60}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          "Positive excitation pin"
          annotation (Placement(transformation(extent={{-110,70},{-90,50}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          "Negative excitation pin"
          annotation (Placement(transformation(extent={{-90,-50},{-110,-70}},
                rotation=0)));

      equation
        connect(electricalExcitation.pin_en, pin_en) annotation (Line(points={{-10,-60},
                {-70,-60},{-100,-60}},                    color={0,0,255}));
        connect(airGapR.spacePhasor_r, damperCage.spacePhasor_r)
          annotation (Line(points={{10,-10},{10,-20},{10,-20}},
                                                       color={0,0,255}));
        connect(airGapR.spacePhasor_r, electricalExcitation.spacePhasor_r)
          annotation (Line(points={{10,-10},{20,-10},{20,-40},{10,-40}}, color=
                {0,0,255}));
        connect(spacePhasorS.spacePhasor, airGapR.spacePhasor_s) annotation (Line(
            points={{10,20},{10,15},{10,10},{10,10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapR.support, internalSupport) annotation (Line(
            points={{-10,1.83697e-015},{-10,0},{-40,0},{-40,-90},{60,-90},{60,
                -100}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(airGapR.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,-1.83697e-015},{35,-1.83697e-015},{35,1.22465e-015},{70,
                1.22465e-015}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(re.heatPort, internalThermalPort.heatPort_e) annotation (Line(
            points={{30,-50},{50,-50},{50,-80},{0,-80}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(damperCage.heatPort, internalThermalPort.heatPort_r) annotation (Line(
            points={{-10,-30},{50,-30},{50,-80},{0,-80}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(electricalExcitation.pin_ep, re.n) annotation (Line(
            points={{10,-60},{20,-60}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(re.p, lesigma.n) annotation (Line(
            points={{40,-60},{40,-70}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(lesigma.p, pin_ep) annotation (Line(
            points={{20,-70},{-80,-70},{-80,60},{-100,60}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (defaultComponentName="smee",
          Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255}),
              Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0,
                    255}),
              Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111,
                    1},{-110,-4}}, color={0,0,255}),
              Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1},
                    {-90,-4}}, color={0,0,255}),
              Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70,
                    -4}}, color={0,0,255}),
              Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0,
                    0,255})}),
          Documentation(info="<HTML>
<b>Model of a three phase electrical excited synchronous induction machine with damper cage.</b><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation and a rotor-fixed <i>AirGap</i> model. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed ccordinate system. Electrical excitation is modelled by converting excitation current and voltage to d-axis space phasors. Only losses in stator, damper and excitation resistance are taken into account.
<br>Whether a damper cage is present or not, can be selected with Boolean parameter useDamperCage (default = true).
<br><b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">number of pole pairs p</td>
<td valign=\"top\">2</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">rotor's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">nominal frequency fNominal</td>
<td valign=\"top\">50</td><td valign=\"top\">Hz</td>
</tr>
<tr>
<td valign=\"top\">nominal voltage per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">V RMS</td>
</tr>
<tr>
<td valign=\"top\">no-load excitation current<br>
    @ nominal voltage and frequency</td>
<td valign=\"top\">10</td><td valign=\"top\">A DC</td>
</tr>
<tr>
<td valign=\"top\">warm excitation resistance</td>
<td valign=\"top\">2.5</td><td valign=\"top\">Ohm</td>
</tr>
<tr>
<td valign=\"top\">nominal current per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">A RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal apparent power</td>
<td valign=\"top\">-30000</td><td valign=\"top\">VA</td>
</tr>
<tr>
<td valign=\"top\">power factor</td>
<td valign=\"top\">-1.0</td><td valign=\"top\">ind./cap.</td>
</tr>
<tr>
<td valign=\"top\">nominal excitation current</td>
<td valign=\"top\">19</td><td valign=\"top\">A</td>
</tr>
<tr>
<td valign=\"top\">efficiency w/o excitation</td>
<td valign=\"top\">97.1</td><td valign=\"top\">%</td>
</tr>
<tr>
<td valign=\"top\">nominal torque</td>
<td valign=\"top\">-196.7</td><td valign=\"top\">Nm</td>
</tr>
<tr>
<td valign=\"top\">nominal speed</td>
<td valign=\"top\">1500</td><td valign=\"top\">rpm</td>
</tr>
<tr>
<td valign=\"top\">nominal rotor angle</td>
<td valign=\"top\">-57.23</td><td valign=\"top\">degree</td>
</tr>
<tr>
<td valign=\"top\">stator resistance</td>
<td valign=\"top\">0.03</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TsRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20s </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">stator reactance Xd</td>
<td valign=\"top\">1.6</td><td valign=\"top\">Ohm per phase in d-axis</td>
</tr>
<tr>
<td valign=\"top\">giving Kc</td>
<td valign=\"top\">0.625</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator reactance Xq</td>
<td valign=\"top\">1.6</td><td valign=\"top\">Ohm per phase in q-axis</td>
</tr>
<tr>
<td valign=\"top\">stator stray reactance Xss</td>
<td valign=\"top\">0.1</td><td valign=\"top\">Ohm per phase</td>
</tr>
<tr>
<td valign=\"top\">damper resistance in d-axis</td>
<td valign=\"top\">0.04</td><td valign=\"top\">Ohm at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">damper resistance in q-axis</td>
<td valign=\"top\">same as d-axis</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">reference temperature TrRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20r </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">damper stray reactance in d-axis XDds</td>
<td valign=\"top\">0.05</td><td valign=\"top\">Ohm</td>
</tr>
<tr>
<td valign=\"top\">damper stray reactance in q-axis XDqs</td>
<td valign=\"top\">same as d-axis</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">excitation resistance</td>
<td valign=\"top\">2.5</td><td valign=\"top\">Ohm at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TeRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20e </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">excitation stray inductance</td>
<td valign=\"top\">2.5</td><td valign=\"top\">% of total excitation inductance</td>
</tr>
<tr>
<td valign=\"top\">stator operational temperature TsOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">damper operational temperature TrOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">excitation operational temperature TeOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">These values give the following inductances:</td>
<td valign=\"top\"> </td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">main field inductance in d-axis</td>
<td valign=\"top\">(Xd - Xss)/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">main field inductance in q-axis</td>
<td valign=\"top\">(Xq - Xss)/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator stray inductance per phase</td>
<td valign=\"top\">Xss/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">damper stray inductance in d-axis</td>
<td valign=\"top\">XDds/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">damper stray inductance in q-axis</td>
<td valign=\"top\">XDqs/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
</table>
</HTML>"));
      end SM_ElectricalExcited;

      model SM_ReluctanceRotor
        "Synchronous induction machine with reluctance rotor and damper cage"
        extends Machines.Interfaces.PartialBasicInductionMachine(
            Lssigma(start=0.1/(2*pi*fsNominal)),
            final idq_ss = airGapR.i_ss,
            final idq_sr = airGapR.i_sr,
            final idq_rs = airGapR.i_rs,
            final idq_rr = airGapR.i_rr,
          redeclare final
            Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMR
            thermalAmbient(final useDamperCage = useDamperCage, final Tr=TrOperational),
          redeclare final
            Machines.Interfaces.SynchronousInductionMachines.ThermalPortSMR
            thermalPort(final useDamperCage = useDamperCage),
          redeclare final
            Machines.Interfaces.SynchronousInductionMachines.ThermalPortSMR
            internalThermalPort(final useDamperCage = useDamperCage));
        Components.AirGapR airGapR(final p=p, final m=3, final Lmd=Lmd, final Lmq=Lmq)
          annotation (Placement(transformation(
              origin={0,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage"
           annotation(Dialog(group="Operational temperatures", enable=not useThermalPort and useDamperCage));
        parameter Modelica.SIunits.Inductance Lmd(start=2.9/(2*pi*fsNominal))
          "Main field inductance in d-axis"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lmq(start=0.9/(2*pi*fsNominal))
          "Main field inductance in q-axis"
           annotation(Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useDamperCage(start = true)
          "Enable / disable damper cage"
          annotation(Evaluate=true, Dialog(tab="Nominal resistances and inductances", group = "DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*fsNominal))
          "Damper stray inductance in d-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Damper stray inductance in q-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Damper resistance in d-axis at TRef"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Damper resistance in q-axis at TRef"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(
                   start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation(Dialog(tab="Nominal resistances and inductances", group = "DamperCage", enable = useDamperCage));
        Components.DamperCage damperCage(
          final Lrsigmad=Lrsigmad,
          final Lrsigmaq=Lrsigmaq,
          final Rrd=Rrd,
          final Rrq=Rrq,
          final T_ref=TrRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef),
          final useHeatPort=true,
          final T=TrRef) if useDamperCage
          annotation (Placement(transformation(
              origin={0,-30},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      equation
        connect(airGapR.spacePhasor_r, damperCage.spacePhasor_r)
          annotation (Line(points={{10,-10},{10,-12.5},{10,-20},{10,-20}},
                                                       color={0,0,255}));
        connect(spacePhasorS.spacePhasor, airGapR.spacePhasor_s) annotation (Line(
            points={{10,20},{10,10},{10,10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapR.support, internalSupport) annotation (Line(
            points={{-10,1.83697e-015},{-40,1.83697e-015},{-40,-90},{60,-90},{
                60,-100}},
            color={0,0,0},
            smooth=Smooth.None));

        connect(airGapR.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,-1.83697e-015},{34,-1.83697e-015},{34,1.22465e-015},{70,
                1.22465e-015}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(damperCage.heatPort, internalThermalPort.heatPort_r) annotation (Line(
            points={{-10,-30},{50,-30},{50,-80},{0,-80}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (defaultComponentName="smr",
          Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
                  100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-130,10},{-100,-10}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,10},{-70,-10}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}),
          Documentation(info="<HTML>
<b>Model of a three phase synchronous induction machine with reluctance rotor and damper cage.</b><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed ccordinate system. Both together connected via a rotor-fixed <i>AirGap</i> model. Only losses in stator and rotor resistance are taken into account.
<br>Whether a damper cage is present or not, can be selected with Boolean parameter useDamperCage (default = true).
<br><b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">number of pole pairs p</td>
<td valign=\"top\">2</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">rotor's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">nominal frequency fNominal</td>
<td valign=\"top\">50</td><td valign=\"top\">Hz</td>
</tr>
<tr>
<td valign=\"top\">nominal voltage per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">V RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal current per phase</td>
<td valign=\"top\">50</td><td valign=\"top\">A RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal torque</td>
<td valign=\"top\"> 46</td><td valign=\"top\">Nm</td>
</tr>
<tr>
<td valign=\"top\">nominal speed</td>
<td valign=\"top\">1500</td><td valign=\"top\">rpm</td>
</tr>
<tr>
<td valign=\"top\">nominal mechanical output</td>
<td valign=\"top\"> 7.23</td><td valign=\"top\">kW</td>
</tr>
<tr>
<td valign=\"top\">efficiency</td>
<td valign=\"top\">96.98</td><td valign=\"top\">%</td>
</tr>
<tr>
<td valign=\"top\">power factor</td>
<td valign=\"top\">0.497</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator resistance</td>
<td valign=\"top\">0.03</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TsRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20s </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">rotor resistance in d-axis</td>
<td valign=\"top\">0.04</td><td valign=\"top\">Ohm at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">rotor resistance in q-axis</td>
<td valign=\"top\">same as d-axis</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">reference temperature TrRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20r </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">stator reactance Xsd in d-axis</td>
<td valign=\"top\">3</td><td valign=\"top\">Ohm per phase</td>
</tr>
<tr>
<td valign=\"top\">stator reactance Xsq in q-axis</td>
<td valign=\"top\">1</td><td valign=\"top\">Ohm</td>
</tr>
<tr>
<td valign=\"top\">stator stray reactance Xss</td>
<td valign=\"top\">0.1</td><td valign=\"top\">Ohm per phase</td>
</tr>
<tr>
<td valign=\"top\">rotor stray reactance in d-axis Xrds</td>
<td valign=\"top\">0.05</td><td valign=\"top\">Ohm per phase</td>
</tr>
<tr>
<td valign=\"top\">rotor stray reactance in q-axis Xrqs</td>
<td valign=\"top\">same as d-axis</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator operational temperature TsOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">damper operational temperature TrOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">These values give the following inductances:</td>
<td valign=\"top\"> </td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">stator stray inductance per phase</td>
<td valign=\"top\">Xss/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">rotor stray inductance in d-axis</td>
<td valign=\"top\">Xrds/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">rotor stray inductance in q-axis</td>
<td valign=\"top\">Xrqs/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">main field inductance per phase in d-axis</td>
<td valign=\"top\">(Xsd-Xss)/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">main field inductance per phase in q-axis</td>
<td valign=\"top\">(Xsq-Xss)/(2*pi*fNominal)</td><td valign=\"top\"> </td>
</tr>
</table>
</HTML>"));
      end SM_ReluctanceRotor;
      annotation (Documentation(info="<HTML>
This package contains models of synchronous induction machines, based on space phasor theory:
<ul>
<li>SM_PermanentMagnet: synchronous induction machine with permanent magnet excitation, with damper cage</li>
<li>SM_ElectricalExcited: synchronous induction machine with electrical excitation
    and damper cage</li>
<li>SM_ReluctanceRotor: induction machine with reluctance rotor and damper cage<br>
i.e. a squirrel cage rotor with magnetic poles due to different airgap width</li>
</ul>
These models use package SpacePhasors.
<br><b>Please keep in mind:</b><br>
<ul>
<li>We keep the same reference system as for motors, i.e.:<br>
    Positive RotorDisplacementAngle means acting as motor,<br>
    with positive electric power consumption and positive mechanical power output.
<li>ElectricalAngle = p * MechanicalAngle</li>
<li>real axis = d-axis<br>
    imaginary= q-axis</li>
<li>Voltage induced by the magnet wheel (d-axis) is located in the q-axis.</li>
</ul>
</HTML>", revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.02  2004/09/19 Anton Haumer</li>
  <li> v1.03  2004/09/24 Anton Haumer<br>
       consistent naming of inductors and resistors in machine models</li>
  <li> v1.1   2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.2   2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.3.2 2004/11/10 Anton Haumer<br>
       ReluctanceRotor moved to SynchronousMachines</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v1.52  2005/10/12 Anton Haumer<br>
       added SM_ElectricalExcited</li>
  <li> v1.53  2005/10/14 Anton Haumer<br>
       introduced unsymmetrical DamperCage for Synchronous Machines</li>
  <li> v1.6.2 2005/10/23 Anton Haumer<br>
       selectable DamperCage for Synchronous Machines</li>
  <li> v1.7.1 2006/02/06 Anton Haumer<br>
       changed some naming of synchronous machines, not affecting existing models</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</HTML>"));
    end SynchronousInductionMachines;

    package DCMachines "Models of DC machines"
      extends Modelica.Icons.Library;

      model DC_PermanentMagnet "Permanent magnet DC machine"
        extends Machines.Interfaces.PartialBasicDCMachine(
          final ViNominal = VaNominal - Machines.Thermal.convertResistance(Ra,TaRef,alpha20a,TaNominal)*IaNominal,
          final psi_eNominal = Lme*IeNominal,
          redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCPM
            thermalAmbient,
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM
            thermalPort,
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM
            internalThermalPort);
        Components.AirGapDC airGapDC(final turnsRatio=turnsRatio, final Le=Lme,
          final quasiStationary=quasiStationary)
          annotation (Placement(transformation(
              origin={0,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground eGround
          annotation (Placement(transformation(extent={{-20,-60},{0,-40}},
                rotation=0)));
        Modelica.Electrical.Analog.Sources.ConstantCurrent ie(I=IeNominal)
          annotation (Placement(transformation(
              origin={10,-30},
              extent={{-10,-10},{10,10}},
              rotation=90)));
      protected
        constant Modelica.SIunits.Inductance Lme=1
          "Field excitation inductance";
        constant Modelica.SIunits.Current IeNominal=1
          "Equivalent excitation current";
      equation
        connect(eGround.p, ie.p)
          annotation (Line(points={{-10,-40},{10,-40}}, color={0,0,255}));
        connect(airGapDC.pin_ep, ie.n) annotation (Line(points={{10,-10},{10,
                -15},{10,-20}},
                       color={0,0,255}));
        connect(airGapDC.pin_en, eGround.p) annotation (Line(points={{-10,-10},
                {-10,-20},{-10,-40}},
                            color={0,0,255}));
        connect(airGapDC.pin_ap, la.n) annotation (Line(
            points={{10,10},{10,35},{10,35},{10,60}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapDC.pin_an, pin_an) annotation (Line(
            points={{-10,10},{-10,60},{-60,60},{-60,100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapDC.support, internalSupport) annotation (Line(
            points={{-10,1.83697e-015},{-26,0},{-40,0},{-40,-90},{60,-90},{60,
                -100}},
            color={0,0,0},
            smooth=Smooth.None));

        connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,-1.83697e-015},{36,-1.83697e-015},{36,1.22465e-015},{70,
                1.22465e-015}},
            color={0,0,0},
            smooth=Smooth.None));
        annotation (defaultComponentName="dcpm",
          Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
                  100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Rectangle(
                extent={{-130,10},{-100,-10}},
                lineColor={0,0,0},
                fillColor={0,255,0},
                fillPattern=FillPattern.Solid), Rectangle(
                extent={{-100,10},{-70,-10}},
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid)}),
          Documentation(info="<HTML>
<b>Model of a DC Machine with permanent magnets.</b><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <i>AirGapDC</i> model. Permanent magnet excitation is modelled by a constant equivalent excitation current feeding AirGapDC. Only losses in armature resistance are taken into account. No saturation is modelled.
<br><b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">stator's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">rotor's moment of inertia</td>
<td valign=\"top\">0.15</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">nominal armature voltage</td>
<td valign=\"top\">100</td><td valign=\"top\">V</td>
</tr>
<tr>
<td valign=\"top\">nominal armature current</td>
<td valign=\"top\">100</td><td valign=\"top\">A</td>
</tr>
<tr>
<td valign=\"top\">nominal speed</td>
<td valign=\"top\">1425</td><td valign=\"top\">rpm</td>
</tr>
<tr>
<td valign=\"top\">nominal torque</td>
<td valign=\"top\">63.66</td><td valign=\"top\">Nm</td>
</tr>
<tr>
<td valign=\"top\">nominal mechanical output</td>
<td valign=\"top\">9.5</td><td valign=\"top\">kW</td>
</tr>
<tr>
<td valign=\"top\">efficiency</td>
<td valign=\"top\">95.0</td><td valign=\"top\">%</td>
</tr>
<tr>
<td valign=\"top\">armature resistance</td>
<td valign=\"top\">0.05</td><td valign=\"top\">Ohm at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TaRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20a </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">armature inductance</td>
<td valign=\"top\">0.0015</td><td valign=\"top\">H</td>
</tr>
<tr>
<td valign=\"top\">armature nominal temperature TaNominal</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">armature operational temperature TaOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and compensation windig, if present.
</HTML>"));
      end DC_PermanentMagnet;

      model DC_ElectricalExcited
        "Electrical shunt/separate excited linear DC machine"
        extends Machines.Interfaces.PartialBasicDCMachine(
          final ViNominal = VaNominal - Machines.Thermal.convertResistance(Ra,TaRef,alpha20a,TaNominal)*IaNominal,
          final psi_eNominal = Lme*IeNominal,
          redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCEE
            thermalAmbient(final Te=TeOperational),
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE
            thermalPort,
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE
            internalThermalPort);
        parameter Modelica.SIunits.Current IeNominal(start=1)
          "Nominal excitation current"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Resistance Re(start=100)
          "Field excitation resistance at TRef"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef(start=293.15)
          "Reference temperature of excitation resistance"
           annotation(Dialog(tab="Excitation"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(
                   start=0) "Temperature coefficient of excitation resistance"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Inductance Le(start=1)
          "Total field excitation inductance"
           annotation(Dialog(tab="Excitation"));
        parameter Real sigmae(min=0, max=0.99, start=0)
          "Stray fraction of total excitation inductance"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeOperational(start=293.15)
          "Operational (shunt) excitation temperature"
           annotation(Dialog(group="Operational temperatures", enable=not useThermalPort));
        output Modelica.SIunits.Voltage ve = pin_ep.v-pin_en.v
          "Field excitation voltage";
        output Modelica.SIunits.Current ie = pin_ep.i
          "Field excitation current";
        Components.AirGapDC airGapDC(final turnsRatio=turnsRatio, final Le=Lme,
          final quasiStationary=quasiStationary)
          annotation (Placement(transformation(
              origin={0,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Analog.Basic.Ground ground
          annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
        Components.CompoundDCExcitation compoundDCExcitation(final
            excitationTurnsRatio=1)
          annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
        Analog.Basic.Ground groundSE
          annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));

        Modelica.Electrical.Analog.Basic.Resistor re(
          final R=Re,
          final T_ref=TeRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
          final useHeatPort=true,
          final T=TeRef)
          annotation (Placement(transformation(
              origin={-80,40},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Components.InductorDC lesigma(final L=Lesigma, final quasiStationary=
              quasiStationary)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,10})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          "Positive excitation pin"
          annotation (Placement(transformation(extent={{-110,70},{-90,50}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          "Negative excitation pin"
          annotation (Placement(transformation(extent={{-90,-50},{-110,-70}},
                rotation=0)));
      protected
        final parameter Modelica.SIunits.Inductance Lme = Le*(1 - sigmae)
          "Main part of excitation inductance";
        final parameter Modelica.SIunits.Inductance Lesigma = Le*sigmae
          "Stray part of excitation inductance"
          annotation(Evaluate=true);
      equation
        connect(airGapDC.pin_ap, la.n) annotation (Line(
            points={{10,10},{10,35},{10,35},{10,60}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapDC.pin_an, pin_an) annotation (Line(
            points={{-10,10},{-10,60},{-60,60},{-60,100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapDC.support, internalSupport) annotation (Line(
            points={{-10,1.83697e-015},{-10,0},{-40,0},{-40,-90},{60,-90},{60,
                -100}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,-1.83697e-015},{35,-1.83697e-015},{35,1.22465e-015},{70,
                1.22465e-015}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(re.heatPort, internalThermalPort.heatPort_e) annotation (Line(
            points={{-70,40},{50,40},{50,-80},{0,-80}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(re.p, pin_ep) annotation (Line(
            points={{-80,50},{-80,60},{-100,60}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(re.n, lesigma.p) annotation (Line(
            points={{-80,30},{-80,20}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(ground.p, airGapDC.pin_en) annotation (Line(
            points={{-20,-10},{-15,-10},{-15,-10},{-10,-10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapDC.pin_en, compoundDCExcitation.pin_n) annotation (Line(
            points={{-10,-10},{-10,-10},{-10,-10},{-10,-10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapDC.pin_ep, compoundDCExcitation.pin_p) annotation (Line(
            points={{10,-10},{10,-10},{10,-10},{10,-10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(groundSE.p, compoundDCExcitation.pin_sen) annotation (Line(
            points={{-20,-30},{-10,-30}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(pin_en, compoundDCExcitation.pin_en) annotation (Line(
            points={{-100,-60},{2,-60},{2,-30}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(compoundDCExcitation.pin_ep, lesigma.n) annotation (Line(
            points={{10,-29.8},{10,-40},{-80,-40},{-80,0}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (defaultComponentName="dcee",
          Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111,
                    1},{-110,-4}}, color={0,0,255}),
              Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1},
                    {-90,-4}}, color={0,0,255}),
              Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70,
                    -4}}, color={0,0,255}),
              Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0,
                    0,255}),
              Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0,
                    255})}),
          Documentation(info="<HTML>
<b>Model of a DC Machine with electrical shunt or separate excitation.</b><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <i>AirGapDC</i> model.<br>
Only losses in armature and excitation resistance are taken into account. No saturation is modelled.<br>
Shunt or separate excitation is defined by the user's external circuit.
<br><b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">stator's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">rotor's moment of inertia</td>
<td valign=\"top\">0.15</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">nominal armature voltage</td>
<td valign=\"top\">100</td><td valign=\"top\">V</td>
</tr>
<tr>
<td valign=\"top\">nominal armature current</td>
<td valign=\"top\">100</td><td valign=\"top\">A</td>
</tr>
<tr>
<td valign=\"top\">nominal torque</td>
<td valign=\"top\">63.66</td><td valign=\"top\">Nm</td>
</tr>
<tr>
<td valign=\"top\">nominal speed</td>
<td valign=\"top\">1425</td><td valign=\"top\">rpm</td>
</tr>
<tr>
<td valign=\"top\">nominal mechanical output</td>
<td valign=\"top\">9.5</td><td valign=\"top\">kW</td>
</tr>
<tr>
<td valign=\"top\">efficiency</td>
<td valign=\"top\">95.0</td><td valign=\"top\">% only armature</td>
</tr>
<tr>
<td valign=\"top\">efficiency</td>
<td valign=\"top\">94.06</td><td valign=\"top\">% including excitation</td>
</tr>
<tr>
<td valign=\"top\">armature resistance</td>
<td valign=\"top\">0.05</td><td valign=\"top\">Ohm at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TaRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20a </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">armature inductance</td>
<td valign=\"top\">0.0015</td><td valign=\"top\">H</td>
</tr>
<tr>
<td valign=\"top\">nominal excitation voltage</td>
<td valign=\"top\">100</td><td valign=\"top\">V</td>
</tr>
<tr>
<td valign=\"top\">nominal excitation current</td>
<td valign=\"top\">1</td><td valign=\"top\">A</td>
</tr>
<tr>
<td valign=\"top\">excitation resistance</td>
<td valign=\"top\">100</td><td valign=\"top\">Ohm at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TeRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20e </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">excitation inductance</td>
<td valign=\"top\">1</td><td valign=\"top\">H</td>
</tr>
<tr>
<td valign=\"top\">stray part of excitation inductance</td>
<td valign=\"top\">0</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">armature nominal temperature TaNominal</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">armature operational temperature TaOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">(shunt) excitation operational temperature TeOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and
compensation windig, if present.<br>
Armature current does not cover excitation current of a shunt excitation; in this case total current drawn from the grid = armature current + excitation current.
</HTML>"));
      end DC_ElectricalExcited;

      model DC_SeriesExcited "Series excited linear DC machine"
        extends Machines.Interfaces.PartialBasicDCMachine(wNominal(start=1410*2*pi/60),
          final ViNominal = VaNominal - (Machines.Thermal.convertResistance(Ra,TaRef,alpha20a,TaNominal) +
                                         Machines.Thermal.convertResistance(Re,TeRef,alpha20e,TeNominal))*IaNominal,
          final psi_eNominal = Lme*abs(IaNominal),
          redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCSE
            thermalAmbient(final Tse=TeOperational),
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE
            thermalPort,
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE
            internalThermalPort);
        parameter Modelica.SIunits.Resistance Re(start=0.01)
          "Series excitation resistance at TRef"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef(start=293.15)
          "Reference temperature of excitation resistance"
           annotation(Dialog(tab="Excitation"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(
                   start=0) "Temperature coefficient of excitation resistance"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Inductance Le(start=0.0005)
          "Total field excitation inductance"
           annotation(Dialog(tab="Excitation"));
        parameter Real sigmae(min=0, max=0.99, start=0)
          "Stray fraction of total excitation inductance"
           annotation(Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeNominal(start=293.15)
          "Nominal series excitation temperature"
           annotation(Dialog(tab="Nominal parameters"));
        parameter Modelica.SIunits.Temperature TeOperational(start=293.15)
          "Operational series excitation temperature"
           annotation(Dialog(group="Operational temperatures", enable=not useThermalPort));
        output Modelica.SIunits.Voltage ve = pin_ep.v-pin_en.v
          "Field excitation voltage";
        output Modelica.SIunits.Current ie = pin_ep.i
          "Field excitation current";
        Components.AirGapDC airGapDC(final turnsRatio=turnsRatio, final Le=Lme,
          final quasiStationary=quasiStationary)
          annotation (Placement(transformation(
              origin={0,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Components.CompoundDCExcitation compoundDCExcitation(final
            excitationTurnsRatio=1)
          annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
        Analog.Basic.Ground ground
          annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
        Analog.Basic.Ground groundE
          annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
        Modelica.Electrical.Analog.Basic.Resistor re(
          final R=Re,
          final T_ref=TeRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
          final useHeatPort=true,
          final T=TeRef)
          annotation (Placement(transformation(
              origin={-80,40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Components.InductorDC lesigma(final L=Lesigma, final quasiStationary=
              quasiStationary)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,10})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          "Positive series excitation pin"
          annotation (Placement(transformation(extent={{-110,70},{-90,50}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          "Negative series excitation pin"
          annotation (Placement(transformation(extent={{-90,-50},{-110,-70}},
                rotation=0)));
      protected
        final parameter Modelica.SIunits.Inductance Lme = Le*(1 - sigmae)
          "Main part of excitation inductance";
        final parameter Modelica.SIunits.Inductance Lesigma = Le*sigmae
          "Stray part of excitation inductance"
          annotation(Evaluate=true);
      equation
        connect(airGapDC.pin_ap, la.n) annotation (Line(
            points={{10,10},{10,35},{10,35},{10,60}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapDC.pin_an, pin_an) annotation (Line(
            points={{-10,10},{-10,60},{-60,60},{-60,100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapDC.support, internalSupport) annotation (Line(
            points={{-10,1.83697e-015},{-10,0},{-40,0},{-40,-90},{60,-90},{60,
                -100}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,-1.83697e-015},{32,-1.83697e-015},{36,1.22465e-015},{70,
                1.22465e-015}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(re.heatPort, internalThermalPort.heatPort_se) annotation (Line(
            points={{-70,40},{50,40},{50,-80},{0,-80}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(pin_ep, re.p) annotation (Line(
            points={{-100,60},{-80,60},{-80,50}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(re.n, lesigma.p) annotation (Line(
            points={{-80,30},{-80,20},{-80,20}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapDC.pin_en, compoundDCExcitation.pin_n) annotation (Line(
            points={{-10,-10},{-10,-10},{-10,-10},{-10,-10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(compoundDCExcitation.pin_p, airGapDC.pin_ep) annotation (Line(
            points={{10,-10},{10,-10},{10,-10},{10,-10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(airGapDC.pin_en, ground.p) annotation (Line(
            points={{-10,-10},{-15,-10},{-15,-10},{-20,-10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(compoundDCExcitation.pin_sen, pin_en) annotation (Line(
            points={{-10,-30},{-10,-60},{-100,-60}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(compoundDCExcitation.pin_sep, lesigma.n) annotation (Line(
            points={{-2,-30},{-2,-40},{-80,-40},{-80,0}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(compoundDCExcitation.pin_en, groundE.p) annotation (Line(
            points={{2,-30},{2,-40},{10,-40}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (defaultComponentName="dcse",
          Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{-100,-10},{-105,-9},{-109,-5},{-110,0},{-109,5},{-105,
                    9},{-100,10}}, color={0,0,255}),
              Line(points={{-100,-30},{-105,-29},{-109,-25},{-110,-20},{-109,-15},
                    {-105,-11},{-100,-10}}, color={0,0,255}),
              Line(points={{-100,10},{-105,11},{-109,15},{-110,20},{-109,25},{-105,
                    29},{-100,30}}, color={0,0,255}),
              Line(points={{-100,50},{-100,30}}, color={0,0,255}),
              Line(points={{-100,-30},{-100,-50}}, color={0,0,255})}),
          Documentation(info="<HTML>
<b>Model of a DC Machine with series excitation.</b><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <i>AirGapDC</i> model.<br>
Only losses in armature and excitation resistance are taken into account. No saturation is modelled.<br>
Series excitation has to be connected by the user's external circuit.
<br><b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">stator's moment of inertia</td>
<td valign=\"top\">0.29</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">rotor's moment of inertia</td>
<td valign=\"top\">0.15</td><td valign=\"top\">kg.m2</td>
</tr>
<tr>
<td valign=\"top\">nominal armature voltage</td>
<td valign=\"top\">100</td><td valign=\"top\">V</td>
</tr>
<tr>
<td valign=\"top\">nominal armature current</td>
<td valign=\"top\">100</td><td valign=\"top\">A</td>
</tr>
<tr>
<td valign=\"top\">nominal torque</td>
<td valign=\"top\">63.66</td><td valign=\"top\">Nm</td>
</tr>
<tr>
<td valign=\"top\">nominal speed</td>
<td valign=\"top\">1410</td><td valign=\"top\">rpm</td>
</tr>
<tr>
<td valign=\"top\">nominal mechanical output</td>
<td valign=\"top\">9.4</td><td valign=\"top\">kW</td>
</tr>
<tr>
<td valign=\"top\">efficiency</td>
<td valign=\"top\">94.0</td><td valign=\"top\">% only armature</td>
</tr>
<tr>
<td valign=\"top\">armature resistance</td>
<td valign=\"top\">0.05</td><td valign=\"top\">Ohm at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TaRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20a </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">armature inductance</td>
<td valign=\"top\">0.0015</td><td valign=\"top\">H</td>
</tr>
<tr>
<td valign=\"top\">excitation resistance</td>
<td valign=\"top\">0.01</td><td valign=\"top\">Ohm at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature TeRef</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20e</td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">excitation inductance</td>
<td valign=\"top\">0.0005</td><td valign=\"top\">H</td>
</tr>
<tr>
<td valign=\"top\">stray part of excitation inductance</td>
<td valign=\"top\">0</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">armature nominal temperature TaNominal</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">series excitation nominal temperature TeNominal</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">armature operational temperature TaOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">series excitation operational temperature TeOperational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and
compensation windig, if present.<br>
Parameter nominal armature voltage includes voltage drop of series excitation;<br>
but for output the voltage is splitted into:<br>
va = armature voltage without voltage drop of series excitation<br>
ve = voltage drop of series excitation
</HTML>"));
      end DC_SeriesExcited;
      annotation (Documentation(info="<HTML>
This package contains models of DC machines:
<ul>
<li>DC_PermanentMagnet: DC machine with permanent magnet excitation</li>
<li>DC_ElectricalExcited: DC machine with electrical shunt or separate excitation</li>
<li>DC_SeriesExcited: DC machine with series excitation</li>
</ul>
</HTML>
",     revisions=
             "<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.02 2004/09/19 Anton Haumer</li>
  <li> v1.03 2004/09/24 Anton Haumer<br>
       added DC machine with series excitation</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</HTML>"));
    end DCMachines;

    package QuasiStationaryDCMachines "Models of quasistationary DC machines"
      extends Modelica.Icons.Library;

      model DC_PermanentMagnet "Quasistationary permanent magnet DC machine"
        extends Machines.BasicMachines.DCMachines.DC_PermanentMagnet(final
            quasiStationary = true);
          extends Machines.Icons.QuasiStationaryMachineIcon;
        annotation (defaultComponentName="dcpm",
          Documentation(info="<HTML>
<b>Quasistaionary model of a DC Machine with permanent magnets.</b><br>
This model is fully compatible with the
<a href=Modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet>transient machine model of a DC machine with permanent magnets</a>;
the only difference is that electrical transients are neglected.
</HTML>"));
      end DC_PermanentMagnet;

      model DC_ElectricalExcited
        "Quasistationary electrical shunt/separate excited linear DC machine"
        extends Machines.BasicMachines.DCMachines.DC_ElectricalExcited(final
            quasiStationary = true);
        extends Machines.Icons.QuasiStationaryMachineIcon;
        annotation (defaultComponentName="dcee",
          Documentation(info="<HTML>
<b>Quasistaionary model of a DC Machine with electrical shunt or separate excitation.</b><br>
This model is fully compatible with the
<a href=Modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_ElectricalExcited>transient machine model of a DC machine with electrical shunt or separate excitation</a>;
the only difference is that electrical transients are neglected.
</HTML>"));
      end DC_ElectricalExcited;

      model DC_SeriesExcited "Quasistationary series excited linear DC machine"
        extends Machines.BasicMachines.DCMachines.DC_SeriesExcited(final
            quasiStationary = true);
        extends Machines.Icons.QuasiStationaryMachineIcon;
        annotation (defaultComponentName="dcse",
          Documentation(info="<HTML>
<b>Quasistaionary model of a DC Machine with Series excitation.</b><br>
This model is fully compatible with the
<a href=Modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_SeriesExcited>transient machine model of a DC machine with with series excitation</a>;
the only difference is that electrical transients are neglected.
</HTML>"));
      end DC_SeriesExcited;
      annotation (Documentation(info="<HTML>
<p>
This package contains quasistationary models of DC machines;
these models are fully compatible with the
<a href=Modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines>transient machine models of DC machines</a>;
the only difference is that electrical transients are neglected.
</p>
<h4>Please note:</h4>
<p>
Quasistationary DC machine models are basically different from quasistationary induction machine models:
Quasistaionary DC machine models neglect electrical transients, i.e. setting <code>der(i) = 0</code>,
whereas quasistationary induction machine models are based on time phasor theory,
see <a href=Modelica://Modelica.Electrical.QuasiStationary>QuasiStationary Library</a>,
where e.g. <code>L*der(i)</code> is replaced by <code>j*omega*L*(I_re+j*I_im)</code>.
</p>
</HTML>
",     revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v2.3.0 2010/02/16 Anton Haumer<br>
       first impementation</li>
  </ul>
</HTML>"));
    end QuasiStationaryDCMachines;

    package Transformers "Library for technical 3phase transformers"
      extends Modelica.Icons.Library2;

      package Yy "Transformers: primary Y / secondary y"
        extends Modelica.Icons.Library2;

        model Yy00 "Transformer Yy0"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yy00");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_p)
            annotation (Line(points={{10,10},{10,20},{50,20},{50,0}}, color={0,
                  0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy0
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"),            Diagram(coordinateSystem(preserveAspectRatio=true,
                  extent={{-100,-100},{100,100}}),
                              graphics));
        end Yy00;

        model Yy02 "Transformer Yy2"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yy02");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l2sigma.plug_p, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          connect(core.plug_p2, star2.plug_p)
            annotation (Line(points={{10,10},{20,10},{20,-70},{10,-70}}, color=
                  {0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy2
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yy02;

        model Yy04 "Transformer Yy4"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yy04");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(Rot2.plug_n, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_p)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy4
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yy04;

        model Yy06 "Transformer Yy6"

          extends Machines.Interfaces.PartialBasicTransformer(
           final VectorGroup="Yy06");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n3)
            annotation (Line(points={{50,0},{50,-20},{10,-20},{10,-10}}, color=
                  {0,0,255}));
          connect(core.plug_p2, star2.plug_p)
            annotation (Line(points={{10,10},{20,10},{20,-70},{10,-70}}, color=
                  {0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy6
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yy06;

        model Yy08 "Transformer Yy8"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yy08");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(Rot2.plug_p, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70},{10,-70}},
                color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy8
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yy08;

        model Yy10 "Transformer Yy10"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yy10");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l2sigma.plug_p, Rot2.plug_n)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_p)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          connect(core.plug_p2, star2.plug_p)
            annotation (Line(points={{10,10},{20,10},{20,-70},{10,-70}}, color=
                  {0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy10
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yy10;
        annotation (Documentation(info="<HTML>
This package contains transformers primary Y connected / secondary y connected in all possbile vector groups.
</HTML>",     revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{0,40},{0,-100}},
                lineColor={0,0,255},
                textString="Yy")}));
      end Yy;

      package Yd "Transformers: primary Y / secondary d"
        extends Modelica.Icons.Library2;

        model Yd01 "Transformer Yd1"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yd01");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(Delta2.plug_p, r2.plug_n)
            annotation (Line(points={{50,-20},{90,-20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-70},{-10,-70}},color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, Delta2.plug_n)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          connect(core.plug_p2, l2sigma.plug_p)
            annotation (Line(points={{10,10},{10,20},{50,20},{50,0}}, color={0,
                  0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd1
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yd01;

        model Yd03 "Transformer Yd3"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yd03");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(Delta2.plug_n, r2.plug_n)
            annotation (Line(points={{50,20},{90,20},{90,0}}, color={0,0,255}));
          connect(l2sigma.plug_p, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-70},{-10,-70}},color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Delta2.plug_p)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd3
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yd03;

        model Yd05 "Transformer Yd5"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yd05");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(Delta2.plug_n, r2.plug_n)
            annotation (Line(points={{50,20},{90,20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-70},{-10,-70}},color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, l2sigma.plug_p)
            annotation (Line(points={{10,-10},{10,-20},{50,-20},{50,0}}, color=
                  {0,0,255}));
          connect(core.plug_p2, Delta2.plug_p)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd5
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yd05;

        model Yd07 "Transformer Yd7"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yd07");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(Delta2.plug_p, r2.plug_n)
            annotation (Line(points={{50,20},{90,20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Delta2.plug_n)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n3)
            annotation (Line(points={{50,0},{50,-20},{10,-20},{10,-10}}, color=
                  {0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd7
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yd07;

        model Yd09 "Transformer Yd9"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yd09");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(Rot2.plug_p, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(Delta2.plug_n, r2.plug_n)
            annotation (Line(points={{50,-20},{90,-20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd9
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yd09;

        model Yd11 "Transformer Yd11"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yd11");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}},
                  rotation=0)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(Delta2.plug_n, r2.plug_n)
            annotation (Line(points={{50,-20},{90,-20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-70},{-10,-70}},color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          connect(core.plug_p2, l2sigma.plug_p)
            annotation (Line(points={{10,10},{10,20},{50,20},{50,0}}, color={0,
                  0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd11
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yd11;
        annotation (Documentation(info="<HTML>
This package contains transformers primary Y connected / secondary d connected in all possbile vector groups.
</HTML>",     revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{0,40},{0,-100}},
                lineColor={0,0,255},
                textString="Yd")}));
      end Yd;

      package Yz "Transformers: primary Y / secondary zig-zag"
        extends Modelica.Icons.Library2;

        model Yz01 "Transformer Yz1"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yz01");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-70},{-10,-70}}, color={0,0,
                  255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_p) annotation (Line(points={{50,0},
                  {50,20}}, color={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2)
            annotation (Line(points={{30,20},{20,20},{20,4},{10,4}}, color={0,0,
                  255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz1
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yz01;

        model Yz03 "Transformer Yz3"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yz03");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2)
            annotation (Line(points={{30,20},{20,20},{20,4},{10,4}}, color={0,0,
                  255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz3
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yz03;

        model Yz05 "Transformer Yz5"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yz05");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-70},{-10,-70}},color={0,0,
                  255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-40},{10,-70},{10,-70}},
                                                         color={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n2)
            annotation (Line(points={{50,0},{50,20},{20,20},{20,4},{10,4}},
                color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz5
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yz05;

        model Yz07 "Transformer Yz7"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yz07");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(l2sigma.plug_p, core.plug_n2)
            annotation (Line(points={{50,0},{50,20},{20,20},{20,4},{10,4}},
                color={0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-40},{10,-70},{10,-70}},
                                                         color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz7
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yz07;

        model Yz09 "Transformer Yz9"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yz09");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-70},{-10,-70}}, color={0,0,
                  255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70}}, color={0,0,
                  255}));
          connect(l2sigma.plug_p, Rot22.plug_n)
            annotation (Line(points={{50,0},{50,20},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2)
            annotation (Line(points={{30,20},{20,20},{20,4},{10,4}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz9
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yz09;

        model Yz11 "Transformer Yz11"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Yz11");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1)
            annotation (Line(points={{-10,-90},{-10,-100},{-50,-100}}, color={0,
                  0,255}));
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, star1.plug_p)
            annotation (Line(points={{-10,-5},{-10,-37.5},{-10,-70},{-10,-70}},
                                                          color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_n)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2)
            annotation (Line(points={{30,20},{20,20},{20,4},{10,4}}, color={0,0,
                  255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz11
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Yz11;
        annotation (Documentation(info="<HTML>
This package contains transformers primary Y connected / secondary zig-zag connected in all possbile vector groups.
</HTML>",     revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{0,40},{0,-100}},
                lineColor={0,0,255},
                textString="Yz")}));
      end Yz;

      package Dy "Transformers: primary D / secondary y"
        extends Modelica.Icons.Library2;

        model Dy01 "Transformer Dy1"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dy01");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}},
                  rotation=0)));
        equation
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(l2sigma.plug_p, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p)
            annotation (Line(points={{-50,-20},{-90,-20},{-90,0}}, color={0,0,
                  255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          connect(core.plug_p2, star2.plug_p)
            annotation (Line(points={{10,10},{20,10},{20,-70},{10,-70}}, color=
                  {0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy1
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dy01;

        model Dy03 "Transformer Dy3"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dy03");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}},
                  rotation=0)));
        equation
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(Rot2.plug_n, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p)
            annotation (Line(points={{-50,-20},{-90,-20},{-90,0}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_p2, Rot2.plug_p)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-40},{10,-70},{10,-70}},
                                                         color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy3
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dy03;

        model Dy05 "Transformer Dy5"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dy05");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
        equation
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(Delta1.plug_p, r1.plug_p)
            annotation (Line(points={{-50,-20},{-90,-20},{-90,0}}, color={0,0,
                  255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n3)
            annotation (Line(points={{50,0},{50,-20},{10,-20},{10,-10}}, color=
                  {0,0,255}));
          connect(core.plug_p2, star2.plug_p)
            annotation (Line(points={{10,10},{20,10},{20,-70},{10,-70}}, color=
                  {0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy5
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dy05;

        model Dy07 "Transformer Dy7"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dy07");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}},
                  rotation=0)));
        equation
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(Rot2.plug_p, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-40},{10,-70},{10,-70}},
                                                         color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy7
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dy07;

        model Dy09 "Transformer Dy9"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dy09");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}},
                  rotation=0)));
        equation
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(l2sigma.plug_p, Rot2.plug_n)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5},{-10,5}},
                color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_p)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          connect(core.plug_p2, star2.plug_p)
            annotation (Line(points={{10,10},{20,10},{20,-70},{10,-70}}, color=
                  {0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy9
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dy09;

        model Dy11 "Transformer Dy11"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dy11");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
        equation
          connect(star2.pin_n, starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-40},{10,-70},{10,-70}},
                                                         color={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_p)
            annotation (Line(points={{10,10},{10,20},{50,20},{50,0}}, color={0,
                  0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy11
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dy11;
        annotation (Documentation(info="<HTML>
This package contains transformers primary D connected / secondary y connected in all possbile vector groups.
</HTML>",     revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{0,40},{0,-100}},
                lineColor={0,0,255},
                textString="Dy")}));
      end Dy;

      package Dd "Transformers: primary D / secondary d"
        extends Modelica.Icons.Library2;

        model Dd00 "Transformer Dd0"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dd00");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}},
                  rotation=0)));
        equation
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(Delta2.plug_p, r2.plug_n)
            annotation (Line(points={{50,-20},{90,-20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_p)
            annotation (Line(points={{10,10},{10,20},{50,20},{50,0}}, color={0,
                  0,255}));
          connect(core.plug_n3, Delta2.plug_n)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd0
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dd00;

        model Dd02 "Transformer Dd2"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dd02");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}},
                  rotation=0)));
        equation
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(Delta2.plug_n, r2.plug_n)
            annotation (Line(points={{50,20},{90,20},{90,0}}, color={0,0,255}));
          connect(l2sigma.plug_p, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Delta2.plug_p)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd2
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dd02;

        model Dd04 "Transformer Dd4"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dd04");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}},
                  rotation=0)));
        equation
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(Delta2.plug_n, r2.plug_n)
            annotation (Line(points={{50,20},{90,20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,1},{10,1},{10,-4}}, color={0,0,
                  255}));
          connect(core.plug_p2, Delta2.plug_p)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, l2sigma.plug_p)
            annotation (Line(points={{10,-10},{10,-20},{50,-20},{50,0}}, color=
                  {0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd4
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dd04;

        model Dd06 "Transformer Dd6"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dd06");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}},
                  rotation=0)));
        equation
          connect(Delta2.plug_p, r2.plug_n)
            annotation (Line(points={{50,20},{90,20},{90,0}}, color={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p)
            annotation (Line(points={{-50,-20},{-90,-20},{-90,0}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(Delta2.plug_n, core.plug_p2)
            annotation (Line(points={{30,20},{10,20},{10,10}}, color={0,0,255}));
          connect(core.plug_n3, l2sigma.plug_p)
            annotation (Line(points={{10,-10},{10,-20},{50,-20},{50,0}}, color=
                  {0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd6
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dd06;

        model Dd08 "Transformer Dd8"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dd08");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}},
                  rotation=0)));
        equation
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(Delta2.plug_n, r2.plug_n)
            annotation (Line(points={{50,-20},{90,-20},{90,0}}, color={0,0,255}));
          connect(Rot2.plug_p, l2sigma.plug_p)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(core.plug_n1, Delta1.plug_n)
            annotation (Line(points={{-10,-5},{-10,-20},{-30,-20}}, color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n)
            annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd8
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dd08;

        model Dd10 "Transformer Dd10"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dd10");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}},
                  rotation=0)));
        equation
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(Delta2.plug_n, r2.plug_n)
            annotation (Line(points={{50,-20},{90,-20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_p)
            annotation (Line(points={{10,10},{10,20},{50,20},{50,0}}, color={0,
                  0,255}));
          connect(core.plug_n3, Delta2.plug_p)
            annotation (Line(points={{10,-10},{10,-20},{30,-20}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd10
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dd10;
        annotation (Documentation(info="<HTML>
This package contains transformers primary D connected / secondary d connected in all possbile vector groups.
</HTML>",     revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{0,40},{0,-100}},
                lineColor={0,0,255},
                textString="Dd")}));
      end Dd;

      package Dz "Transformers: primary D / secondary ziag-zag"
        extends Modelica.Icons.Library2;

        model Dz00 "Transformer Dz0"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dz00");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
        equation
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5},{-10,5}},
                color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2)
            annotation (Line(points={{30,20},{20,20},{20,4},{10,4}}, color={0,0,
                  255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz0
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dz00;

        model Dz02 "Transformer Dz2"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dz02");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
        equation
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2)
            annotation (Line(points={{30,20},{20,20},{20,4},{10,4}}, color={0,0,
                  255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-40},{10,-70},{10,-70}},
                                                         color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz2
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dz02;

        model Dz04 "Transformer Dz4"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dz04");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
        equation
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(l2sigma.plug_p, core.plug_n2)
            annotation (Line(points={{50,0},{50,20},{20,20},{20,4},{10,4}},
                color={0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz4
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dz04;

        model Dz06 "Transformer Dz6"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dz06");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
        equation
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-40},{10,-70},{10,-70}},
                                                         color={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n2)
            annotation (Line(points={{50,0},{50,20},{20,20},{20,4},{10,4}},
                color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz6
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dz06;

        model Dz08 "Transformer Dz8"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dz08");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
        equation
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5},{-10,5}},
                color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70}}, color={0,0,
                  255}));
          connect(l2sigma.plug_p, Rot22.plug_n)
            annotation (Line(points={{50,0},{50,20},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2)
            annotation (Line(points={{30,20},{20,20},{20,4},{10,4}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz8
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dz08;

        model Dz10 "Transformer Dz10"

          extends Machines.Interfaces.PartialBasicTransformer(
            final VectorGroup="Dz10");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}},
                  rotation=0)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}},
                  rotation=0)));
        equation
          connect(star2.pin_n,starpoint2)
            annotation (Line(points={{10,-90},{10,-100},{50,-100}}, color={0,0,
                  255}));
          connect(r1.plug_p, Delta1.plug_p)
            annotation (Line(points={{-90,0},{-90,-20},{-50,-20}}, color={0,0,
                  255}));
          connect(l1sigma.plug_n, core.plug_p1)
            annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,5}}, color=
                  {0,0,255}));
          connect(Delta1.plug_n, core.plug_n1)
            annotation (Line(points={{-30,-20},{-10,-20},{-10,-5}}, color={0,0,
                  255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n)
            annotation (Line(points={{10,-4},{20,-4},{20,-10},{30,-10}}, color=
                  {0,0,255}));
          connect(core.plug_n3, star2.plug_p)
            annotation (Line(points={{10,-10},{10,-70},{10,-70}}, color={0,0,
                  255}));
          connect(l2sigma.plug_p, Rot22.plug_n)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2)
            annotation (Line(points={{30,20},{20,20},{20,4},{10,4}}, color={0,0,
                  255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz10
<br>Typical parameters see:
<a href=Modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer>PartialBasicTransformer</a>
</html>"));
        end Dz10;
        annotation (Documentation(info="<HTML>
This package contains transformers primary D connected / secondary d connected in all possbile vector groups.
</HTML>",     revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{0,40},{0,-100}},
                lineColor={0,0,255},
                textString="Dz")}));
      end Dz;

      annotation (
       Documentation(info="<HTML>
This package contains components to model technical threephase transformers:
<ul>
<li>Transformer: transformer model to choose connection / vector group</li>
<li>Yy: Transformers with primary primary Y / secondary y</li>
<li>Yd: Transformers with primary primary Y / secondary d</li>
<li>Yz: Transformers with primary primary Y / secondary zig-zag</li>
<li>Dy: Transformers with primary primary D / secondary y</li>
<li>Dd: Transformers with primary D / secondary d</li>
<li>Dz: Transformers with primary D / secondary zig-zag</li>
</ul>
<p>
Transformers are modeled by an ideal transformer, adding primary and secondary winding resistances and stray inductances.<br>
All transformers extend from the base model <i>PartialTransformer</i>, adding the primary and secondary connection.<br>
<b>VectorGroup</b> defines the phase shift between primary and secondary voltages, expressed by a number phase shift/30 degree
(i.e. the hour on a clock face). Therefore each transformer is identified by two characters and a two-digit number,
e.g. Yd11 ... primary connection Y (star), secondary connection d (delta), vector group 11 (phase shift 330 degree)<br>
With the \"supermodel\" <i>Tranformer</i>&nbsp; the user may choose primary and secondary connection as well as the vector group.<br>
It calculates winding ratio as well as primary and secondary winding resistances and stray inductances,
distributing them equally to primary and secondary winding, from the following parameters:
</p>
<ul>
<li>nominal frequency</li>
<li>primary voltage (RMS line-to-line)</li>
<li>secondary voltage (RMS line-to-line)</li>
<li>nominal apparent power</li>
<li>impedance voltage drop</li>
<li>short-circuit copper losses</li>
</ul>
The <b>impedance voltage drop</b> indicates the (absolute value of the) voltage drop at nominal load (current) as well as
the voltage we have to apply to the primary winding to achieve nominal current in the short-circuited secondary winding.
<p>
<b>Please pay attention</b> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).<br>
<b>In some cases (Yy or Yz) it may be necessary to ground one of the transformer's starpoints
even though the source's and/or load's starpoint are grounded; you may use a reasonable high earthing resistance.</b>
</p>
<b>Limitations and assumptions:</b><br>
<ul>
<li>number of phases is limited to 3, therefore definition as a constant m=3</li>
<li>symmetry of the 3 phases resp. limbs</li>
<li>saturation is neglected, i.e. inductances are constant</li>
<li>magnetizing current is neglected</li>
<li>magnetizing losses are neglected</li>
<li>additional (stray) losses are neglected</li>
</ul>
<b>Further development:</b>
<ul>
<li>modeling magnetizing current, including saturation</li>
<li>temperature dependency of winding resistances</li>
</ul>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
</p>
</HTML>",     revisions="<HTML>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer<br>
       first stable release</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</HTML>"),     Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(
              points={{-80,36},{-60,16},{-60,-64},{-80,-84},{-80,36}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder),
            Polygon(
              points={{60,36},{40,16},{40,-64},{60,-84},{60,36}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder),
            Polygon(
              points={{-10,26},{-20,16},{-20,-64},{-10,-74},{0,-64},{0,16},{-10,
                  26}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),
            Polygon(
              points={{-80,36},{60,36},{40,16},{0,16},{-10,26},{-20,16},{-60,16},
                  {-80,36}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),
            Polygon(
              points={{-80,-84},{60,-84},{40,-64},{0,-64},{-10,-74},{-20,-64},{
                  -60,-64},{-80,-84}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),
            Rectangle(
              extent={{-88,12},{-52,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={0,0,255}),
            Rectangle(
              extent={{-94,4},{-46,-52}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={170,170,255}),
            Rectangle(
              extent={{-28,12},{8,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={0,0,255}),
            Rectangle(
              extent={{-34,4},{14,-52}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={170,170,255}),
            Rectangle(
              extent={{32,12},{68,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={0,0,255}),
            Rectangle(
              extent={{26,4},{74,-52}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={170,170,255})}));
    end Transformers;

    package Components "Machine components like AirGaps"
      extends Modelica.Icons.Library;

      partial model PartialAirGap "Partial airgap model"
        parameter Integer m=3 "Number of phases";
        parameter Integer p(min=1) "Number of pole pairs";
        output Modelica.SIunits.Torque tauElectrical;
        Modelica.SIunits.Angle gamma "Rotor displacement angle";
        Modelica.SIunits.Current i_ss[2]
          "Stator current space phasor with respect to the stator fixed frame";
        Modelica.SIunits.Current i_sr[2]
          "Stator current space phasor with respect to the rotor fixed frame";
        Modelica.SIunits.Current i_rs[2]
          "Rotor current space phasor with respect to the stator fixed frame";
        Modelica.SIunits.Current i_rr[2]
          "Rotor current space phasor with respect to the rotor fixed frame";
        Modelica.SIunits.MagneticFlux psi_ms[2]
          "Magnetizing flux phasor with respect to the stator fixed frame";
        Modelica.SIunits.MagneticFlux psi_mr[2]
          "Magnetizing flux phasor with respect to the rotor fixed frame";
        Real RotationMatrix[2,2] "Matrix of rotation from rotor to stator";
      public
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
          annotation (Placement(transformation(extent={{-10,110},{10,90}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a support
          "Support at which the reaction torque is acting"
             annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                rotation=0)));
        Machines.Interfaces.SpacePhasor spacePhasor_s
          annotation (Placement(transformation(extent={{-110,90},{-90,110}},
                rotation=0)));
        Machines.Interfaces.SpacePhasor spacePhasor_r
          annotation (Placement(transformation(extent={{90,90},{110,110}},
                rotation=0)));
      equation
        // mechanical angle of the rotor of an equivalent 2-pole machine
        gamma=p*(flange.phi-support.phi);
        RotationMatrix={{+cos(gamma),-sin(gamma)},{+sin(gamma),+cos(gamma)}};
        i_ss = spacePhasor_s.i_;
        i_ss = RotationMatrix*i_sr;
        i_rr = spacePhasor_r.i_;
        i_rs = RotationMatrix*i_rr;
        // Stator voltage induction
        spacePhasor_s.v_ = der(psi_ms);
        // Rotor voltage induction
        spacePhasor_r.v_ = der(psi_mr);
        // Electromechanical torque (cross product of current and flux space phasor)
        tauElectrical = m/2*p*(spacePhasor_s.i_[2]*psi_ms[1] - spacePhasor_s.i_[1]*psi_ms[2]);
        flange.tau = -tauElectrical;
        support.tau = tauElectrical;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Ellipse(
                extent={{-90,90},{90,-92}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-80,80},{80,-80}}, lineColor={0,0,255}),
              Rectangle(
                extent={{-10,90},{10,-80}},
                lineColor={0,0,0},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={128,128,128}),
              Text(
                extent={{-150,-90},{150,-150}},
                lineColor={0,0,255},
                textString="%name")}),
          Documentation(info="<HTML>
Partial model of the airgap, using only equations.
</HTML>"));
      end PartialAirGap;

      model AirGapS "Airgap in stator-fixed coordinate system"
        parameter Modelica.SIunits.Inductance Lm "Main field inductance";
        extends PartialAirGap;
        Modelica.SIunits.Current i_ms[2]
          "Magnetizing current space phasor with respect to the stator fixed frame";
      protected
        parameter Modelica.SIunits.Inductance L[2,2]={{Lm,0},{0,Lm}}
          "Inductance matrix";
      equation
        // Magnetizing current with respect to the stator reference frame
        i_ms = i_ss + i_rs;
        // Magnetizing flux linkage with respect to the stator reference frame
        psi_ms = L*i_ms;
        // Magnetizing flux linkage with respect to the rotor reference frame
        psi_mr = transpose(RotationMatrix)*psi_ms;
        annotation (defaultComponentName="airGap",
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Text(
                extent={{-80,40},{0,-40}},
                lineColor={0,0,0},
                textString="S"), Text(
                extent={{-150,-90},{150,-150}},
                lineColor={0,0,255},
                textString="%name")}),
          Documentation(info="<HTML>
Model of the airgap in stator-fixed coordinate system, using only equations.
</HTML>"));
      end AirGapS;

      model AirGapR "Airgap in rotor-fixed coordinate system"
        parameter Modelica.SIunits.Inductance Lmd
          "Main field inductance d-axis";
        parameter Modelica.SIunits.Inductance Lmq
          "Main field inductance q-axis";
        extends PartialAirGap;
        Modelica.SIunits.Current i_mr[2]
          "Magnetizing current space phasor with respect to the rotor fixed frame";
      protected
        parameter Modelica.SIunits.Inductance L[2,2]={{Lmd,0},{0,Lmq}}
          "Inductance matrix";
      equation
        // Magnetizing current with respect to the rotor reference frame
        i_mr = i_sr + i_rr;
        // Main flux linkage with respect to the stator reference frame
        psi_mr = L*i_mr;
        // Main flux linkage with respect to the stator reference frame
        psi_ms = RotationMatrix*psi_mr;
        // Stator voltage induction
        annotation (defaultComponentName="airGap",
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Text(
                extent={{0,40},{80,-40}},
                lineColor={0,0,0},
                textString="R"), Text(
                extent={{-150,-90},{150,-150}},
                lineColor={0,0,255},
                textString="%name")}),
          Documentation(info="<HTML>
Model of the airgap in rotor-fixed coordinate system, using only equations.
</HTML>"));
      end AirGapR;

      model SquirrelCage "Squirrel Cage"
        parameter Modelica.SIunits.Inductance Lrsigma
          "Rotor stray inductance per phase translated to stator";
        parameter Modelica.SIunits.Resistance Rr
          "Rotor resistance per phase translated to stator at T_ref";
        parameter Modelica.SIunits.Temperature T_ref=293.15
          "Reference temperature";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
          "Temperature coefficient of resistance at T_ref";
        extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
        Modelica.SIunits.Resistance Rr_actual
          "Actual resistance = Rr*(1 + alpha*(T_heatPort - T_ref))";
        Machines.Interfaces.SpacePhasor spacePhasor_r
          annotation (Placement(transformation(extent={{-110,90},{-90,110}},
                rotation=0)));
      equation
        assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
        Rr_actual = Rr*(1 + alpha*(T_heatPort - T_ref));
        spacePhasor_r.v_ = Rr_actual*spacePhasor_r.i_ + Lrsigma*der(spacePhasor_r.i_);
        LossPower = Rr_actual*(spacePhasor_r.i_[1]*spacePhasor_r.i_[1] + spacePhasor_r.i_[2]*spacePhasor_r.i_[2]);
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Ellipse(extent={{-60,45},{-30,75}}, lineColor={0,0,255}),
              Ellipse(extent={{-30,45},{0,75}}, lineColor={0,0,255}),
              Ellipse(extent={{0,45},{30,75}}, lineColor={0,0,255}),
              Ellipse(extent={{30,45},{60,75}}, lineColor={0,0,255}),
              Rectangle(
                extent={{-60,30},{60,60}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-100,60},{-60,60}}, color={0,0,255}),
              Line(points={{60,60},{80,60},{80,40}}, color={0,0,255}),
              Rectangle(
                extent={{60,40},{100,-40}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{80,-40},{80,-60}}, color={0,0,255}),
              Line(points={{60,-60},{100,-60}}, color={0,0,255}),
              Line(points={{70,-80},{90,-80}}, color={0,0,255}),
              Line(points={{66,-70},{94,-70}}, color={0,0,255}),
              Text(
                extent={{-150,-90},{150,-150}},
                lineColor={0,0,255},
                textString="%name"),
              Line(points={{-100,90},{-100,60}}, color={0,0,255})}),
          Documentation(info="<HTML>
<p>
Model of a squirrel cage / symmetrical damper cage in two axis.
</p>
<p>
The squirrel cage has an optional (conditional) HeatPort,
which can be enabled or disabled by the Boolean parameter useHeatPort.
Temperatures of both axis are the same, both losses are added.
Material properties alpha of both axis are the same.
</p>
</HTML>"));
      end SquirrelCage;

      model DamperCage "Squirrel Cage"
        parameter Modelica.SIunits.Inductance Lrsigmad
          "Stray inductance in d-axis per phase translated to stator";
        parameter Modelica.SIunits.Inductance Lrsigmaq
          "Stray inductance in q-axis per phase translated to stator";
        parameter Modelica.SIunits.Resistance Rrd
          "Resistance in d-axis per phase translated to stator at T_ref";
        parameter Modelica.SIunits.Resistance Rrq
          "Resistance in q-axis per phase translated to stator at T_ref";
        parameter Modelica.SIunits.Temperature T_ref=293.15
          "Reference temperature of both resistances in d- and q-axis";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
          "Temperature coefficient of both resistances in d- and q-axis at T_ref";
        extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
        Modelica.SIunits.Resistance Rrd_actual
          "Actual resistance = Rrd*(1 + alpha*(T_heatPort - T_ref))";
        Modelica.SIunits.Resistance Rrq_actual
          "Actual resistance = Rrq*(1 + alpha*(T_heatPort - T_ref))";
        Machines.Interfaces.SpacePhasor spacePhasor_r
          annotation (Placement(transformation(extent={{-110,90},{-90,110}},
                rotation=0)));
      equation
        assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
        Rrd_actual = Rrd*(1 + alpha*(T_heatPort - T_ref));
        Rrq_actual = Rrq*(1 + alpha*(T_heatPort - T_ref));
        spacePhasor_r.v_[1] = Rrd_actual * spacePhasor_r.i_[1] + Lrsigmad * der(spacePhasor_r.i_[1]);
        spacePhasor_r.v_[2] = Rrq_actual * spacePhasor_r.i_[2] + Lrsigmaq * der(spacePhasor_r.i_[2]);
        LossPower = Rrd_actual*spacePhasor_r.i_[1]*spacePhasor_r.i_[1] + Rrq_actual*spacePhasor_r.i_[2]*spacePhasor_r.i_[2];
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{60,60},{100,60}}, color={0,0,255}),
              Line(points={{70,40},{90,40}}, color={0,0,255}),
              Line(points={{66,50},{94,50}}, color={0,0,255}),
              Text(
                extent={{-150,-90},{150,-150}},
                lineColor={0,0,255},
                textString="%name"),
              Ellipse(extent={{-60,90},{-40,70}}, lineColor={0,0,255}),
              Ellipse(extent={{-40,90},{-20,70}}, lineColor={0,0,255}),
              Ellipse(extent={{-20,90},{0,70}}, lineColor={0,0,255}),
              Line(points={{-80,0},{-80,-20}}, color={0,0,255}),
              Rectangle(extent={{20,90},{60,70}}, lineColor={0,0,255}),
              Line(points={{60,80},{80,80},{80,60}}, color={0,0,255}),
              Line(points={{-100,90},{-100,80},{-60,80}}, color={0,0,255}),
              Line(points={{-100,90},{-100,80},{-80,80},{-80,60}}, color={0,0,
                    255}),
              Ellipse(extent={{-90,60},{-70,40}}, lineColor={0,0,255}),
              Ellipse(extent={{-90,40},{-70,20}}, lineColor={0,0,255}),
              Ellipse(extent={{-90,20},{-70,0}}, lineColor={0,0,255}),
              Rectangle(
                extent={{-80,0},{-70,60}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{0,80},{20,80}}, color={0,0,255}),
              Rectangle(extent={{-90,-20},{-70,-60}}, lineColor={0,0,255}),
              Line(points={{-100,-80},{-60,-80}}, color={0,0,255}),
              Line(points={{-90,-100},{-70,-100}}, color={0,0,255}),
              Line(points={{-94,-90},{-66,-90}}, color={0,0,255}),
              Line(points={{-80,-60},{-80,-80}}, color={0,0,255}),
              Rectangle(
                extent={{0,70},{-60,80}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}),
          Documentation(info="<HTML>
<p>
Model of an usymmetrical damper cage in two axis.
</p>
<p>
The damper cage has an optional (conditional) HeatPort,
which can be enabled or disabled by the Boolean parameter useHeatPort.
Temperatures of both axis are the same, both losses are added.
Material properties alpha can be set differently for both d- and q-axis,
although reference temperature for both resistances is the same.
</p>
</HTML>"));
      end DamperCage;

      model ElectricalExcitation "Electrical excitation"
        parameter Real turnsRatio(start=1)
          "Ratio stator current / excitation current";
        Modelica.SIunits.Current ie "Excitation current";
        Modelica.SIunits.Voltage ve "Excitation voltage";
        Machines.Interfaces.SpacePhasor spacePhasor_r
          annotation (Placement(transformation(extent={{-110,90},{-90,110}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          annotation (Placement(transformation(extent={{90,110},{110,90}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          annotation (Placement(transformation(extent={{110,-110},{90,-90}},
                rotation=0)));
      equation
        pin_ep.i + pin_en.i = 0;
        ie = +pin_ep.i;
        ve = pin_ep.v - pin_en.v;
        spacePhasor_r.i_ = {-ie*turnsRatio,0};
        ve = spacePhasor_r.v_[1]*turnsRatio*3/2;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Text(
                extent={{-150,-90},{150,-150}},
                lineColor={0,0,255},
                textString="%name"),
              Polygon(
                points={{-90,100},{-70,106},{-70,94},{-90,100}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-70,40},{10,-40}}, lineColor={0,0,255}),
              Ellipse(extent={{-10,40},{70,-40}}, lineColor={0,0,255}),
              Line(points={{-30,0},{-54,32},{-50,20},{-44,26},{-54,32}}, color=
                    {0,0,255}),
              Line(points={{-30,0},{-54,-32},{-50,-20},{-44,-26},{-54,-32}},
                  color={0,0,255}),
              Line(points={{-54,32},{-54,100},{-70,100}}, color={0,0,255}),
              Line(points={{90,100},{30,100},{30,40}}, color={0,0,255}),
              Line(points={{30,-40},{30,-100},{90,-100}}, color={0,0,255})}),
          Documentation(info="<HTML>
Model of an electrical excitation, converting excitation to space phasor.
</HTML>"));
      end ElectricalExcitation;

      model PermanentMagnet "Permanent magnet excitation"
        parameter Modelica.SIunits.Current Ie "Equivalent excitation current";
        Machines.Interfaces.SpacePhasor spacePhasor_r
          annotation (Placement(transformation(extent={{-110,90},{-90,110}},
                rotation=0)));
      equation
        spacePhasor_r.i_ = {-Ie,0};
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Ellipse(
                extent={{-60,60},{60,20}},
                lineColor={255,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-60,-20},{60,-60}},
                lineColor={0,255,0},
                fillColor={0,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,40},{60,0}},
                lineColor={255,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-90,100},{-70,106},{-70,94},{-90,100}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,0},{60,-40}},
                lineColor={0,255,0},
                pattern=LinePattern.None,
                lineThickness=0.5,
                fillColor={0,255,0},
                fillPattern=FillPattern.Solid),
              Line(points={{-60,-40},{-60,0}}, color={0,255,0}),
              Line(points={{60,-40},{60,0}}, color={0,255,0}),
              Line(points={{0,100},{-70,100}}, color={0,0,255}),
              Line(points={{0,100},{0,60}}, color={255,0,0}),
              Text(
                extent={{-150,-90},{150,-150}},
                lineColor={0,0,255},
                textString="%name")}),
          Documentation(info="<HTML>
Model of a permanent magnet excitation, characterized by an equivalent excitation current.
</HTML>"));
      end PermanentMagnet;

      model InductorDC
        "Ideal linear electrical inductor for electrical DC machines"
        extends Modelica.Electrical.Analog.Interfaces.OnePort;
        parameter Modelica.SIunits.Inductance L(start=1) "Inductance";
        parameter Boolean quasiStationary(start=false)
          "No electrical transients if true"
          annotation(Evaluate=true);
      equation
        v = if quasiStationary then 0 else L*der(i);
        annotation (
          Documentation(info="<html>
<p>The linear inductor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>v = L * di/dt</i>.
If <code>quasiStationary == false</code>, the electrical transients are neglected, i.e. the voltage drop is zero.</p>
</html>"),Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
              Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
              Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
              Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
              Rectangle(
                extent={{-60,-30},{60,0}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{60,0},{90,0}}, color={0,0,255}),
              Line(points={{-90,0},{-60,0}}, color={0,0,255}),
              Text(
                extent={{-138,-60},{144,-94}},
                lineColor={0,0,0},
                textString="L=%L"),
              Text(
                extent={{-152,79},{148,39}},
                textString="%name",
                lineColor={0,0,255}),
              Rectangle(visible=quasiStationary,
                extent={{-70,30},{70,-30}},
                lineColor={0,0,255},
                fillColor={85,170,255},
                fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
              Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
              Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
              Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
              Rectangle(
                extent={{-60,-30},{60,0}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{60,0},{96,0}}, color={0,0,255}),
              Line(points={{-96,0},{-60,0}}, color={0,0,255})}));
      end InductorDC;

      partial model PartialAirGapDC "Partial airgap model of a DC machine"
        parameter Boolean quasiStationary(start=false)
          "No electrical transients if true"
          annotation(Evaluate=true);
        parameter Real turnsRatio
          "Ratio of armature turns over number of turns of the excitation winding";
        Modelica.SIunits.AngularVelocity w "Angluar velocity";
        Modelica.SIunits.Voltage vei
          "Voltage drop across field excitation inductance";
        Modelica.SIunits.Current ie "Excitation current";
        Modelica.SIunits.MagneticFlux psi_e "Excitation flux";
        Modelica.SIunits.Voltage vai "Induced armature voltage";
        Modelica.SIunits.Current ia "Armature current";
        output Modelica.SIunits.Torque tauElectrical;
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
          annotation (Placement(transformation(extent={{-10,110},{10,90}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a support
          "Support at which the reaction torque is acting"
             annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap
          annotation (Placement(transformation(extent={{-110,110},{-90,90}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          annotation (Placement(transformation(extent={{90,110},{110,90}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_an
          annotation (Placement(transformation(extent={{-110,-110},{-90,-90}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          annotation (Placement(transformation(extent={{90,-110},{110,-90}},
                rotation=0)));
      equation
        // armature pins
        vai = pin_ap.v - pin_an.v;
        ia = + pin_ap.i;
        ia = - pin_an.i;
        // excitation pins
        vei = pin_ep.v - pin_en.v;
        ie = + pin_ep.i;
        ie = - pin_en.i;
        // induced voltage across field excitation inductance
        vei = if quasiStationary then 0 else der(psi_e);
        // mechanical speed
        w = der(flange.phi)-der(support.phi);
        // induced armature voltage
        vai = turnsRatio * psi_e * w;
        // electrical torque (ia is perpendicular to flux)
        tauElectrical = turnsRatio * psi_e * ia;
        flange.tau = -tauElectrical;
        support.tau = tauElectrical;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Ellipse(
                extent={{-90,90},{90,-92}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-10,90},{10,-80}},
                lineColor={0,0,0},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={128,128,128}),
              Text(
                extent={{0,40},{80,-40}},
                lineColor={0,0,0},
                textString="E"),
              Text(
                extent={{-150,-100},{150,-160}},
                lineColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-80,40},{0,-40}},
                lineColor={0,0,0},
                textString="A"),
              Rectangle(visible=quasiStationary,
                extent={{-10,90},{10,-80}},
                lineColor={170,213,255},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={170,213,255})}),
          Documentation(info="<HTML>
Linear model of the airgap (without saturation effects) of a DC machine, using only equations.<br>
Induced excitation voltage is calculated from der(flux), where flux is defined by excitation inductance times excitation current.
If <code>quasiStationary == false</code>, the electrical transients are neglected, i.e. the induced excitation voltage is zero.<br>
Induced armature voltage is calculated from flux times angular velocity.
</HTML>"));
      end PartialAirGapDC;

      model AirGapDC "Linear airgap model of a DC machine"
        extends PartialAirGapDC;
        parameter Modelica.SIunits.Inductance Le "Excitation inductance";
      equation
        // excitation flux: linearly dependent on excitation current
        psi_e = Le * ie;
        annotation (defaultComponentName="airGap",
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Text(
                extent={{-150,-100},{150,-160}},
                lineColor={0,0,255},
                textString="%name")}),
          Documentation(info="<HTML>
Linear model of the airgap (without saturation effects) of a DC machine, using only equations.<br>
Induced excitation voltage is calculated from der(flux), where flux is defined by excitation inductance times excitation current.<br>
Induced armature voltage is calculated from flux times angular velocity.
</HTML>"));
      end AirGapDC;

      model CompoundDCExcitation "Compound excitation = shunt + series"
        parameter Real excitationTurnsRatio
          "Ratio of series excitation turns over shunt excitation turns";
        Modelica.SIunits.Voltage v = pin_p.v - pin_n.v;
        Modelica.SIunits.Current i = pin_p.i;
        Modelica.SIunits.Voltage ve = pin_ep.v - pin_en.v;
        Modelica.SIunits.Current ie = pin_ep.i;
        Modelica.SIunits.Voltage vse = pin_sep.v - pin_sen.v;
        Modelica.SIunits.Current ise = pin_sep.i;
        Analog.Interfaces.PositivePin pin_p "Positive pin to airgap"
          annotation (Placement(transformation(extent={{90,110},{110,90}})));
        Analog.Interfaces.NegativePin pin_n "Negative pin to airgap"
          annotation (Placement(transformation(extent={{-110,110},{-90,90}})));
        Analog.Interfaces.PositivePin pin_ep "Positive pin to shunt excitation"
          annotation (Placement(transformation(extent={{90,-108},{110,-88}})));
        Analog.Interfaces.NegativePin pin_en "Negative pin to shunt excitation"
          annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
        Analog.Interfaces.PositivePin pin_sep
          "Positive pin to series excitation"
          annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
        Analog.Interfaces.NegativePin pin_sen
          "Negative pin to series excitation"
          annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
      equation
      //current balances
        pin_p.i + pin_n.i = 0;
        pin_ep.i + pin_en.i = 0;
        pin_sep.i + pin_sen.i = 0;
      //compound currents
        -i = ie + excitationTurnsRatio*ise;
      //induced voltages
        ve = v;
        vse = v*excitationTurnsRatio;
        annotation (Icon(graphics={
          Polygon(
            points={{-60,-40},{-40,-40},{0,4},{40,-40},{60,-40},{10,20},{10,60},
                    {20,60},{0,80},{-20,60},{-10,60},{-10,20},{-60,-40}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Text(extent={{-80,-40},{-40,-80}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="S"),
          Text(extent={{40,-40},{80,-80}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="E")}),
           Documentation(info="<HTML>
Model to compound the shunt excitation current and the series excitation current to the total excitation current w.r.t shunt excitation.
This model is intended to be placed between shunt and series excitation pins and the airgap;
the connection to airgap has to be grounded at one point.
</HTML>"));
      end CompoundDCExcitation;

      partial model PartialCore
        "Partial model of transformer core with 3 windings"
        parameter Integer m(final min=1) = 3 "Number of phases";
        parameter Real n12(start=1) "Turns ratio 1:2";
        parameter Real n13(start=1) "Turns ratio 1:3";
        Modelica.SIunits.Voltage v1[m] = plug_p1.pin.v  - plug_n1.pin.v;
        Modelica.SIunits.Current i1[m] = plug_p1.pin.i;
        Modelica.SIunits.Voltage v2[m] = plug_p2.pin.v  - plug_n2.pin.v;
        Modelica.SIunits.Current i2[m] = plug_p2.pin.i;
        Modelica.SIunits.Voltage v3[m] = plug_p3.pin.v  - plug_n3.pin.v;
        Modelica.SIunits.Current i3[m] = plug_p3.pin.i;
        Modelica.SIunits.Current im[m] = i1 + i2/n12 + i3/n13
          "Magnetizing current";
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p1(final m=
              m) annotation (Placement(transformation(extent={{-110,40},{-90,60}},
                rotation=0)));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n1(final m=
              m) annotation (Placement(transformation(extent={{-110,-60},{-90,
                  -40}}, rotation=0)));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p2(final m=
              m) annotation (Placement(transformation(extent={{90,90},{110,110}},
                rotation=0)));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n2(final m=
              m) annotation (Placement(transformation(extent={{90,30},{110,50}},
                rotation=0)));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p3(final m=
              m) annotation (Placement(transformation(extent={{90,-30},{110,-50}},
                rotation=0)));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n3(final m=
              m) annotation (Placement(transformation(extent={{90,-90},{110,
                  -110}}, rotation=0)));
      equation
        plug_p1.pin.i + plug_n1.pin.i = zeros(m);
        plug_p2.pin.i + plug_n2.pin.i = zeros(m);
        plug_p3.pin.i + plug_n3.pin.i = zeros(m);
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Text(
                extent={{-100,130},{100,110}},
                textString="%name",
                lineColor={0,0,255}),
              Ellipse(extent={{-45,-50},{-20,-25}}, lineColor={0,0,255}),
              Ellipse(extent={{-45,-25},{-20,0}}, lineColor={0,0,255}),
              Ellipse(extent={{-45,0},{-20,25}}, lineColor={0,0,255}),
              Ellipse(extent={{-45,25},{-20,50}}, lineColor={0,0,255}),
              Rectangle(
                extent={{-46,-50},{-34,50}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,50},{-32,50}}, color={0,0,255}),
              Line(points={{-90,-50},{-32,-50}}, color={0,0,255}),
              Ellipse(extent={{20,40},{45,65}}, lineColor={0,0,255}),
              Ellipse(extent={{20,65},{45,90}}, lineColor={0,0,255}),
              Rectangle(
                extent={{36,40},{46,90}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{32,90},{90,90}}, color={0,0,255}),
              Line(points={{34,40},{92,40}}, color={0,0,255}),
              Ellipse(extent={{20,-90},{45,-65}}, lineColor={0,0,255}),
              Ellipse(extent={{20,-65},{45,-40}}, lineColor={0,0,255}),
              Rectangle(
                extent={{36,-90},{46,-40}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{32,-40},{90,-40}}, color={0,0,255}),
              Line(points={{34,-90},{92,-90}}, color={0,0,255})}),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Documentation(info="<html>
Partial model of transformer core with 3 windings; saturation function flux versus magentizing current has to be defined.
</html>"));
      end PartialCore;

      model IdealCore "Ideal transformer with 3 windings"

        extends PartialCore;
      equation
        im = zeros(m);
        v1 = n12*v2;
        v1 = n13*v3;
        annotation (defaultComponentName="core", Diagram(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                         graphics),
          Documentation(info="<html>
Ideal transformer with 3 windings: no magnetizing current.
</html>"));
      end IdealCore;

      partial model BasicTransformer "Partial model of threephase transformer"
        extends Machines.Interfaces.PartialBasicTransformer;
      //dummy will be removed when conversion script is applicable
        annotation (Documentation(info="<html>
Partialmodel of a threephase transformer, containing primary and secondary resistances and stray inductances, as well as the iron core.
Circuit layout (vector group) of primary and secondary windings have to be defined.<br>
Exactly the same as Interfaces.PartialBasicTransformer, included for compatibility reasons.
</html>"));
      end BasicTransformer;

      annotation (Documentation(info="<HTML>
This package contains components for modeling electrical machines, specially threephase induction machines, based on space phasor theory.
These models use package SpacePhasors.
</HTML>", revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.02 2004/09/19 Anton Haumer<br>
       added AirGapDC models</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.52 2005/10/12 Anton Haumer<br>
       added electrical excitation</li>
  <li> v1.53 Beta 2005/10/14 Anton Haumer<br>
       introduced unsymmetrical DamperCage for Synchronous Machines</li>
  <li> v2.1.3 2010/02/10 Anton Haumer<br>
       prepared conditionalHeatPort of SquirrelCage and DamperCage</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</HTML>"));
    end Components;
    annotation (Documentation(info="<HTML>
This package contains components for modeling electrical machines, specially threephase induction machines, based on space phasor theory:
<ul>
<li>package AsynchronousInductionMachines: models of three phase asynchronous induction machines</li>
<li>package SynchronousInductionMachines: models of three phase synchronous induction machines</li>
<li>package DCMachines: models of DC machines with different excitation</li>
<li>package Transformers: Threephase transformers (see detailled documentation in subpackage)</li>
<li>package Components: components for modeling machines and transformers</li>
</ul>
The induction machine models use package SpacePhasors.
</HTML>", revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.00  2004/09/16 Anton Haumer</li>
  <li> v1.01  2004/09/18 Anton Haumer<br>
       moved common equations from machine models to PartialMachine</li>
  <li> v1.02  2004/09/19 Anton Haumer<br>
       new package structure for machine types<br>
       added DCMachine models</li>
  <li> v1.03  2004/09/24 Anton Haumer<br>
       added DC machine with series excitation</li>
  <li> v1.1   2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.2   2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.3.2 2004/11/10 Anton Haumer<br>
       ReluctanceRotor moved to SynchronousMachines</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v1.53  2005/10/14 Anton Haumer<br>
       introduced unsymmetrical DamperCage for Synchronous Machines</li>
  <li> v1.6.2 2005/10/23 Anton Haumer<br>
       selectable DamperCage for Synchronous Machines</li>
  <li> v1.6.3 2005/11/25 Anton Haumer<br>
       easier parametrisation of AsynchronousInductionMachines.AIM_SlipRing model</li>
  <li> v1.7.1 2006/02/06 Anton Haumer<br>
       changed some naming of synchronous machines, not affecting existing models</li>
  <li> v2.1.3 2010/02/10 Anton Haumer<br>
       prepared conditionalHeatPort of SquirrelCage and DamperCage</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</HTML>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(
            extent={{-60,60},{60,-60}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,128,255}),
          Rectangle(
            extent={{-60,60},{-80,-60}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={128,128,128}),
          Rectangle(
            extent={{60,10},{80,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={95,95,95}),
          Rectangle(
            extent={{-60,70},{20,50}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{
                60,-100},{-70,-100},{-70,-90}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end BasicMachines;

  package Sensors "Sensors for machine modelling"
   extends Modelica.Icons.Library2;

    model VoltageQuasiRMSSensor "Length of space phasor -> RMS voltage"
      constant Integer m(final min=1) = 3 "Number of phases";
      Modelica.Blocks.Interfaces.RealOutput V
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Sensors.VoltageSensor VoltageSensor1(final m=m)
        annotation (Placement(transformation(extent={{-10,40},{10,60}},
              rotation=0)));
      Modelica.Blocks.Math.Gain Gain1(final k=1/sqrt(2))
        annotation (Placement(transformation(
            origin={0,-70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasor1
        annotation (Placement(transformation(
            origin={0,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.SpacePhasors.Blocks.ToPolar ToPolar1
        annotation (Placement(transformation(
            origin={0,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(plug_p, VoltageSensor1.plug_p)
        annotation (Line(points={{-100,0},{-100,50},{-10,50}}, color={0,0,255}));
      connect(VoltageSensor1.plug_n, plug_n)
        annotation (Line(points={{10,50},{100,50},{100,0}}, color={0,0,255}));
      connect(VoltageSensor1.v, ToSpacePhasor1.u) annotation (Line(points={{0,39},{
              0,22},{2.20436e-015,22}},       color={0,0,255}));
      connect(ToSpacePhasor1.y, ToPolar1.u) annotation (Line(points={{
              -2.02067e-015,-1},{-2.02067e-015,-8.5},{2.20436e-015,-8.5},{
              2.20436e-015,-18}},  color={0,0,255}));
      connect(ToPolar1.y[1], Gain1.u) annotation (Line(points={{-0.5,-41},{-0.5,
              -49.5},{2.20436e-015,-49.5},{2.20436e-015,-58}},   color={0,0,255}));
      connect(Gain1.y, V) annotation (Line(points={{-2.02067e-015,-81},{
              -2.02067e-015,-91.5},{0,-91.5},{0,-110}},color={0,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                          graphics),
                           Icon(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,70},{0,40}}, color={0,0,0}),
            Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
            Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
            Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
            Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
            Polygon(
              points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Line(points={{0,-70},{0,-100}}, color={0,0,255}),
            Text(
              extent={{-40,-20},{40,-60}},
              lineColor={0,0,255},
              textString="V RMS")}),
        Documentation(info="<HTML>
Measured 3-phase instantaneous voltages are transformed to the corresponding space phasor; <br>
output is length of the space phasor divided by sqrt(2), thus giving in sinusoidal stationary state RMS voltage.
</HTML>"));
    end VoltageQuasiRMSSensor;

    model CurrentQuasiRMSSensor "Length of space phasor -> RMS current"
      constant Integer m(final min=1) = 3 "Number of phases";
      Modelica.Blocks.Interfaces.RealOutput I
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Sensors.CurrentSensor CurrentSensor1(final m=m)
        annotation (Placement(transformation(extent={{-10,40},{10,60}},
              rotation=0)));
      Modelica.Blocks.Math.Gain Gain1(final k=1/sqrt(2))
        annotation (Placement(transformation(
            origin={0,-70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasor1
        annotation (Placement(transformation(
            origin={0,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.SpacePhasors.Blocks.ToPolar ToPolar1
        annotation (Placement(transformation(
            origin={0,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(plug_p, CurrentSensor1.plug_p)
        annotation (Line(points={{-100,0},{-100,50},{-10,50}}, color={0,0,255}));
      connect(CurrentSensor1.plug_n, plug_n)
        annotation (Line(points={{10,50},{100,50},{100,0}}, color={0,0,255}));
      connect(CurrentSensor1.i, ToSpacePhasor1.u) annotation (Line(points={{0,39},{
              0,22},{2.20436e-015,22}},       color={0,0,255}));
      connect(ToSpacePhasor1.y, ToPolar1.u) annotation (Line(points={{
              -2.02067e-015,-1},{-2.02067e-015,-8.5},{2.20436e-015,-8.5},{
              2.20436e-015,-18}},  color={0,0,255}));
      connect(ToPolar1.y[1], Gain1.u) annotation (Line(points={{-0.5,-41},{-0.5,
              -49.5},{2.20436e-015,-49.5},{2.20436e-015,-58}},   color={0,0,255}));
      connect(Gain1.y,I)  annotation (Line(points={{-2.02067e-015,-81},{
              -2.02067e-015,-91.5},{0,-91.5},{0,-110}},color={0,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                          graphics),
                           Icon(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,70},{0,40}}, color={0,0,0}),
            Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
            Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
            Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
            Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
            Polygon(
              points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Line(points={{0,-70},{0,-100}}, color={0,0,255}),
            Text(
              extent={{-40,-20},{40,-60}},
              lineColor={0,0,255},
              textString="A RMS")}),
        Documentation(info="<HTML>
Measured 3-phase instantaneous currents are transformed to the corresponding space phasor; <br>
output is length of the space phasor divided by sqrt(2), thus giving in sinusoidal stationary state RMS current.
</HTML>"));
    end CurrentQuasiRMSSensor;

    model ElectricalPowerSensor "Instantaneous power from space phasors"
      constant Integer m(final min=1) = 3 "Number of phases";
      Modelica.Blocks.Interfaces.RealOutput P
        annotation (Placement(transformation(
            origin={-50,110},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealOutput Q
        annotation (Placement(transformation(
            origin={50,110},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_ni(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_nv(final m=m)
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
              rotation=0)));

    protected
      Modelica.SIunits.Voltage v_[2];
      Modelica.SIunits.Current i_[2];
    equation
      plug_p.pin.v = plug_ni.pin.v;
      plug_p.pin.i + plug_ni.pin.i = zeros(m);
      plug_nv.pin.i = zeros(m);
      v_ = Machines.SpacePhasors.Functions.ToSpacePhasor(plug_p.pin.v - plug_nv.pin.v);
      i_ = Machines.SpacePhasors.Functions.ToSpacePhasor(plug_p.pin.i);
      2/3*P = +v_[1]*i_[1]+v_[2]*i_[2];
      2/3*Q = -v_[1]*i_[2]+v_[2]*i_[1];
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,70},{0,40}}, color={0,0,0}),
            Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
            Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
            Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
            Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
            Polygon(
              points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-40,-20},{40,-60}},
              lineColor={0,0,255},
              textString="P Q"),
            Line(points={{0,-70},{0,-90}}, color={0,0,255}),
            Line(points={{-10,70},{-10,80},{-50,80},{-50,100}}, color={0,0,255}),
            Line(points={{10,70},{10,80},{50,80},{50,100}}, color={0,0,255})}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                  graphics),
        Documentation(info="<HTML>
3-phase instantaneous voltages (plug_p - plug_nv) and currents (plug_p - plug_ni) are transformed to the corresponding space phasors, <br>
which are used to calculate power quantities:<br>
P = instantaneous power, thus giving in stationary state active power.<br>
Q = giving in stationary state reactive power.<br>
</HTML>"));
    end ElectricalPowerSensor;

    model MechanicalPowerSensor "Mechanical power = torque x speed"
      extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
      parameter Boolean useSupport=false "Use support or fixed housing"
        annotation(Evaluate=true);
      Modelica.Blocks.Interfaces.RealOutput P
        annotation (Placement(transformation(
            origin={0,110},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
        annotation (Placement(transformation(extent={{20,-10},{40,10}},
              rotation=0)));
      Modelica.Blocks.Math.Product product
        annotation (Placement(transformation(
            origin={0,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.Rotational.Sensors.RelSpeedSensor relSpeedSensor
                                                                 annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,-30})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed if
                                                            (not useSupport)
        annotation (Placement(transformation(extent={{-40,-100},{-20,-80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a support if          useSupport
        "Support at which the reaction torque is acting"
           annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
              rotation=0)));
    equation
      connect(flange_a, torqueSensor.flange_a)
        annotation (Line(points={{-100,0},{-70,0},{-40,0},{20,0}},
                                                   color={0,0,0}));
      connect(torqueSensor.flange_b, flange_b)
        annotation (Line(points={{40,0},{100,0}}, color={0,0,0}));
      connect(product.y, P)  annotation (Line(points={{6.73556e-016,41},{
              6.73556e-016,52},{0,52},{0,110}},        color={0,0,255}));
      connect(torqueSensor.tau, product.u2) annotation (Line(
          points={{22,-11},{22,-20},{6,-20},{6,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(flange_a, relSpeedSensor.flange_b) annotation (Line(
          points={{-100,0},{-30,0},{-30,-20}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(relSpeedSensor.w_rel, product.u1) annotation (Line(
          points={{-19,-30},{-6,-30},{-6,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(relSpeedSensor.flange_a, fixed.flange) annotation (Line(
          points={{-30,-40},{-30,-90}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(relSpeedSensor.flange_a, support) annotation (Line(
          points={{-30,-40},{-30,-80},{0,-80},{0,-100}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,70},{0,40}}, color={0,0,0}),
            Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
            Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
            Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
            Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
            Polygon(
              points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-70,0},{-90,0}}, color={0,0,0}),
            Line(points={{70,0},{90,0}}, color={0,0,0}),
            Line(points={{0,70},{0,100}}, color={0,0,255}),
            Text(
              extent={{-40,-20},{40,-60}},
              lineColor={0,0,255},
              textString="Pmech"),
            Rectangle(
              extent={{-20,-80},{20,-120}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              visible=not useSupport,
              points={{-20,-100},{20,-100}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{-10,-100},{-20,-120}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{0,-100},{-10,-120}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{10,-100},{0,-120}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{20,-100},{10,-120}},
              color={0,0,0},
              smooth=Smooth.None)}),
                              Diagram(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}),
                                      graphics),
        Documentation(info="<HTML>
Calculates (mechanical) power from torque times angular speed.
</HTML>"));
    end MechanicalPowerSensor;

    model RotorDisplacementAngle "Rotor lagging angle"
      constant Integer m=3 "Number of phases";
      parameter Integer p(min=1) "Number of pole pairs";
      parameter Boolean useSupport=false "Use support or fixed housing"
        annotation(Evaluate=true);
      Modelica.Blocks.Interfaces.RealOutput rotorDisplacementAngle
        annotation (Placement(transformation(extent={{100,-10},{120,10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,50},{-90,70}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Sensors.VoltageSensor VoltageSensor1(final m=m)
        annotation (Placement(transformation(
            origin={-80,-10},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasorVS
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
        annotation (Placement(transformation(extent={{-10,90},{10,110}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relativeAngleSensor
        annotation (Placement(transformation(extent={{40,70},{20,90}}, rotation=
               0)));
      Modelica.Blocks.Sources.Constant constant_(final k=Modelica.Constants.pi/2)
        annotation (Placement(transformation(extent={{-50,30},{-30,50}},
              rotation=0)));
      Modelica.Blocks.Math.Add add(final k2=1, final k1=p)
        annotation (Placement(transformation(
            origin={-10,20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.SpacePhasors.Blocks.Rotator rotatorVS2R
        annotation (Placement(transformation(extent={{-20,0},{0,-20}}, rotation=
               0)));
      Machines.SpacePhasors.Blocks.ToPolar ToPolarVSR
        annotation (Placement(transformation(extent={{20,-20},{40,0}}, rotation=
               0)));
      Modelica.Blocks.Routing.DeMultiplex2 deMultiplex2(final n1=1,
           final n2=1) annotation (Placement(transformation(extent={{60,-20},{
                80,0}}, rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport
        "support at which the reaction torque is acting"
           annotation (Placement(transformation(extent={{90,90},{110,110}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed if
                                                   (not useSupport)
        annotation (Placement(transformation(extent={{90,70},{110,90}},
              rotation=0)));
    equation
      connect(constant_.y, add.u2) annotation (Line(points={{-29,40},{-16,40},{
              -16,32}}, color={0,0,255}));
      connect(add.y, rotatorVS2R.angle) annotation (Line(points={{-10,9},{-10,
              5.5},{-10,5.5},{-10,2}},
            color={0,0,255}));
      connect(ToSpacePhasorVS.y, rotatorVS2R.u) annotation (Line(points={{-39,
              -10},{-22,-10}}, color={0,0,255}));
      connect(rotatorVS2R.y, ToPolarVSR.u)
        annotation (Line(points={{1,-10},{18,-10}}, color={0,0,255}));
      connect(ToPolarVSR.y, deMultiplex2.u)
        annotation (Line(points={{41,-10},{58,-10}}, color={0,0,255}));
      connect(plug_p, VoltageSensor1.plug_p) annotation (Line(points={{-100,60},
              {-80,60},{-80,0}}, color={0,0,255}));
      connect(plug_n, VoltageSensor1.plug_n) annotation (Line(points={{-100,-60},
              {-80,-60},{-80,-20}}, color={0,0,255}));
      connect(VoltageSensor1.v, ToSpacePhasorVS.u)
        annotation (Line(points={{-69,-10},{-62,-10}}, color={0,0,255}));
      connect(deMultiplex2.y2[1], rotorDisplacementAngle) annotation (Line(
            points={{81,-16},{90,-16},{90,0},{110,0}}, color={0,0,255}));
      connect(relativeAngleSensor.phi_rel, add.u1) annotation (Line(points={{30,69},
              {30,40},{-4,40},{-4,32}},     color={0,0,255}));
      connect(relativeAngleSensor.flange_b, flange)
                                                   annotation (Line(points={{20,
              80},{0,80},{0,100}}, color={0,0,0}));
      connect(relativeAngleSensor.flange_a, support) annotation (Line(
          points={{40,80},{60,80},{60,100},{100,100}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(relativeAngleSensor.flange_a, fixed.flange) annotation (Line(
          points={{40,80},{100,80}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-60,80},{60,40}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-60,-40},{60,-80}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,60},{60,40}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,-40},{60,-60}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,0},{-80,80}}, color={0,0,255}),
            Polygon(
              points={{-80,80},{-68,76},{-76,68},{-80,80}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,0},{0,80}}, color={0,255,0}),
            Polygon(
              points={{0,84},{4,72},{-4,72},{0,84}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{80,120},{120,80}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              visible=not useSupport,
              points={{80,100},{120,100}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{90,120},{80,100}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{100,120},{90,100}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{110,120},{100,100}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{120,120},{110,100}},
              color={0,0,0},
              smooth=Smooth.None)}),
        Documentation(info="<HTML>
Calculates rotor lagging angle by measuring the stator phase voltages, transforming them to the correspondig space phasor in stator-fixed coordinate system, <br>
rotating the space phasor to the rotor-fixed coordinate system and calculating the angle of this space phasor.
<p>
The sensor's housing can be implicitely fixed (useSupport=false).<br>
If the machine's stator also implicitely fixed (useSupport=false), the angle at the flange
is equal to the angle of the machine's rotor against the stator.<br>
Otherwise, the sensor's support has to be connected to the machine's support.
</p>
</HTML>"));
    end RotorDisplacementAngle;
    annotation (Documentation(info="<HTML>
This package contains sensors that are usefull when modelling machines.
</HTML>", revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.03 2004/09/24 Anton Haumer</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed RotorDisplacementAngle</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support, also in sensor RotorDisplacementAngle<br>
       to ease the implementation of a 3D-frame in a future release</li>
  </ul>
</HTML>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Ellipse(
            extent={{-74,46},{66,-94}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-4,46},{-4,16}}, color={0,0,0}),
          Line(points={{18.9,8.8},{36.2,33.3}}, color={0,0,0}),
          Line(points={{-26.9,8.8},{-44.2,33.3}}, color={0,0,0}),
          Line(points={{33.6,-10.3},{61.8,-0.1}}, color={0,0,0}),
          Line(points={{-41.6,-10.3},{-69.8,-0.1}}, color={0,0,0}),
          Line(points={{-4,-24},{5.02,4.6}}, color={0,0,0}),
          Polygon(
            points={{-4.48,7.6},{14,2},{14,33.2},{-4.48,7.6}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-9,-19},{1,-29}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end Sensors;

  package SpacePhasors "Library with space phasor-models"
    extends Modelica.Icons.Library2;

    package Components "Basic space phasor models"
      extends Modelica.Icons.Library;

      model SpacePhasor
        "Physical transformation: three phase <-> space phasors"
        constant Integer m=3 "Number of phases";
        constant Real pi=Modelica.Constants.pi;
        parameter Real turnsRatio=1 "Turns ratio";
        Modelica.SIunits.Voltage v[m] "Instantaneous phase voltages";
        Modelica.SIunits.Current i[m] "Instantaneous phase currents";
      protected
        parameter Real TransformationMatrix[ 2, m]=2/m*
          {{cos(+(k - 1)/m*2*pi) for k in 1:m}, {+sin(+(k - 1)/m*2*pi) for k in 1:m}};
        parameter Real InverseTransformation[m, 2]=
          {{cos(-(k - 1)/m*2*pi), -sin(-(k - 1)/m*2*pi)} for k in 1:m};
      public
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
          annotation (Placement(transformation(extent={{-110,90},{-90,110}},
                rotation=0)));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
          annotation (Placement(transformation(extent={{-110,-110},{-90,-90}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.PositivePin zero
          annotation (Placement(transformation(extent={{90,-10},{110,10}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin ground
          annotation (Placement(transformation(extent={{90,-110},{110,-90}},
                rotation=0)));
        Machines.Interfaces.SpacePhasor spacePhasor annotation (Placement(transformation(
                extent={{90,90},{110,110}}, rotation=0)));
      equation
        v/turnsRatio = plug_p.pin.v - plug_n.pin.v;
        i*turnsRatio = +plug_p.pin.i;
        i*turnsRatio = -plug_n.pin.i;
        zero.v = 1/m*sum(v);
        spacePhasor.v_ = TransformationMatrix *v;
      //v  = fill(zero.v,m) + InverseTransformation*spacePhasor.v_;
        -zero.i = 1/m*sum(i);
        -spacePhasor.i_ = TransformationMatrix *i;
      //-i  = fill(zero.i,m) + InverseTransformation*spacePhasor.i_;
        ground.v = 0;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{0,0},{80,80},{60,72},{72,60},{80,80}}, color={0,0,
                    255}),
              Line(points={{0,0},{80,-80},{72,-60},{60,-72},{80,-80}}, color={0,
                    0,255}),
              Line(points={{-80,0},{-73.33,10},{-66.67,17.32},{-60,20},{-53.33,
                    17.32},{-46.67,10},{-40,0},{-33.33,-10},{-26.67,-17.32},{-20,
                    -20},{-13.33,-17.32},{-6.67,-10},{0,0}}, color={0,0,255}),
              Line(points={{-90,0},{-83.33,10},{-76.67,17.32},{-70,20},{-63.33,
                    17.32},{-56.67,10},{-50,0},{-43.33,-10},{-36.67,-17.32},{-30,
                    -20},{-23.33,-17.32},{-16.67,-10},{-10,0}}, color={0,0,255}),
              Line(points={{-70,0},{-63.33,10},{-56.67,17.32},{-50,20},{-43.33,
                    17.32},{-36.67,10},{-30,0},{-23.33,-10},{-16.67,-17.32},{-10,
                    -20},{-3.33,-17.32},{3.33,-10},{10,0}}, color={0,0,255}),
              Text(
                extent={{-150,-100},{150,-160}},
                lineColor={0,0,255},
                textString="%name"),
              Text(
                extent={{40,10},{90,-10}},
                lineColor={0,0,255},
                textString="zero"),
              Line(points={{90,-100},{60,-100}}, color={0,0,255}),
              Line(points={{60,-84},{60,-116}}, color={0,0,255}),
              Line(points={{50,-90},{50,-110}}, color={0,0,255}),
              Line(points={{40,-96},{40,-104}}, color={0,0,255})}),
          Documentation(info="<HTML>
Physical transformation of voltages and currents: three phases &lt;-&gt; space phasors:<br>
x[k] = X0 + {cos(-(k - 1)/m*2*pi),-sin(-(k - 1)/m*2*pi)}*X[Re,Im]<br>
and vice versa:<br>
X0 = sum(x[k])/m<br>
X[Re,Im] = sum(2/m*{cos((k - 1)/m*2*pi),sin((k - 1)/m*2*pi)}*x[k])<br>
were x designates three phase values, X[Re,Im] designates the space phasor and X0 designates the zero sequence system.<br>
<i>Physcial transformation</i> means that both voltages and currents are transformed in both directions.<br>
Zero-sequence voltage and current are present at pin zero. An additional zero-sequence impedance could be connected between pin zero and pin ground.
</HTML>"));
      end SpacePhasor;

      model Rotator "Rotates space phasor"
        constant Real pi=Modelica.Constants.pi;
      protected
        Real RotationMatrix[2,2] = {{+cos(-angle),-sin(-angle)},{+sin(-angle),+cos(-angle)}};
      //Real InverseRotator[2,2] = {{+cos(+angle),-sin(+angle)},{+sin(+angle),+cos(+angle)}};
      public
        Machines.Interfaces.SpacePhasor spacePhasor_a annotation (Placement(
              transformation(extent={{-110,90},{-90,110}}, rotation=0)));
        Machines.Interfaces.SpacePhasor spacePhasor_b annotation (Placement(
              transformation(extent={{90,90},{110,110}}, rotation=0)));
        Modelica.Blocks.Interfaces.RealInput angle
          annotation (Placement(transformation(
              origin={0,-120},
              extent={{-20,-20},{20,20}},
              rotation=90)));
      equation
        spacePhasor_b.v_ = RotationMatrix*spacePhasor_a.v_;
      //spacePhasor_a.v_ = InverseRotator*spacePhasor_b.v_;
        spacePhasor_b.i_ + RotationMatrix*spacePhasor_a.i_ = zeros(2);
      //spacePhasor_a.i_ + InverseRotator*spacePhasor_b.i_ = zeros(2);
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{50,-2},{-2,-50}},
                pattern=LinePattern.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255}),
              Line(points={{0,0},{80,0},{60,10},{60,-10},{80,0}}, color={0,0,
                    255}),
              Line(points={{0,0},{0,80},{-10,60},{10,60},{0,80}}, color={0,0,
                    255}),
              Polygon(
                points={{50,0},{42,14},{54,16},{50,0}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-50,50},{50,-50}}, lineColor={0,0,255}),
              Rectangle(
                extent={{-50,50},{-2,-50}},
                pattern=LinePattern.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255}),
              Rectangle(
                extent={{50,-2},{-2,-50}},
                pattern=LinePattern.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255})}),
          Documentation(info="<HTML>
Rotates space phasors of left connector to right connector by the angle provided by the input signal \"angle\" from one coordinate system into another.
</HTML>"));
      end Rotator;

      annotation (Documentation(info="<HTML>
This package contains basic space phasor models.<br>
Real and imaginary part of voltage space phasor are the potentials v_[2] of the space phasor connector; (implicit grounded).<br>
Real and imaginary part of current space phasor are the currents i_[2] at the space phasor connector;
a ground has to be used where necessary for currents flowing back.
</HTML>", revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.60 2005/11/03 Anton Haumer<br>
       added Rotator</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
</HTML>"));
    end Components;

    package Blocks "Blocks for space phasor transformation"
      extends Modelica.Icons.Library;

      block ToSpacePhasor "Conversion: three phase -> space phasor"
        extends Modelica.Blocks.Interfaces.MIMO(final nin=m, final nout=2);
        constant Integer m=3 "Number of phases";
        constant Real pi=Modelica.Constants.pi;
      protected
        parameter Real TransformationMatrix[ 2, m]=2/m*
          {{cos(+(k - 1)/m*2*pi) for k in 1:m}, {+sin(+(k - 1)/m*2*pi) for k in 1:m}};
        parameter Real InverseTransformation[m, 2]=
          {{cos(-(k - 1)/m*2*pi), -sin(-(k - 1)/m*2*pi)} for k in 1:m};
      public
        Modelica.Blocks.Interfaces.RealOutput zero
          annotation (Placement(transformation(extent={{100,-70},{120,-90}},
                rotation=0)));

      equation
        zero = 1/m*sum(u);
        y = TransformationMatrix *u;
      //u = fill(zero,m) + InverseTransformation*y;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{0,0},{80,80},{60,72},{72,60},{80,80}}, color={0,0,
                    255}),
              Line(points={{0,0},{80,-80},{72,-60},{60,-72},{80,-80}}, color={0,
                    0,255}),
              Line(points={{-80,0},{-73.33,10},{-66.67,17.32},{-60,20},{-53.33,
                    17.32},{-46.67,10},{-40,0},{-33.33,-10},{-26.67,-17.32},{-20,
                    -20},{-13.33,-17.32},{-6.67,-10},{0,0}}, color={0,0,255}),
              Line(points={{-90,0},{-83.33,10},{-76.67,17.32},{-70,20},{-63.33,
                    17.32},{-56.67,10},{-50,0},{-43.33,-10},{-36.67,-17.32},{-30,
                    -20},{-23.33,-17.32},{-16.67,-10},{-10,0}}, color={0,0,255}),
              Line(points={{-70,0},{-63.33,10},{-56.67,17.32},{-50,20},{-43.33,
                    17.32},{-36.67,10},{-30,0},{-23.33,-10},{-16.67,-17.32},{-10,
                    -20},{-3.33,-17.32},{3.33,-10},{10,0}}, color={0,0,255}),
              Text(
                extent={{-12,-74},{64,-86}},
                lineColor={0,0,0},
                textString="zero")}),
          Documentation(info="<HTML>
Transformation of threephase values (voltages or currents) to space phasor and zero sequence value.
</HTML>"));
      end ToSpacePhasor;

      block FromSpacePhasor "Conversion: space phasor -> three phase"
        extends Modelica.Blocks.Interfaces.MIMO(final nin=2, final nout=m);
        constant Integer m=3 "Number of phases";
        constant Real pi=Modelica.Constants.pi;
      protected
        parameter Real TransformationMatrix[ 2, m]=2/m*
          {{cos(+(k - 1)/m*2*pi) for k in 1:m}, {+sin(+(k - 1)/m*2*pi) for k in 1:m}};
        parameter Real InverseTransformation[m, 2]=
          {{cos(-(k - 1)/m*2*pi), -sin(-(k - 1)/m*2*pi)} for k in 1:m};
      public
        Modelica.Blocks.Interfaces.RealInput zero
          annotation (Placement(transformation(extent={{-140,-60},{-100,-100}},
                rotation=0)));
      equation
        y = fill(zero,m) + InverseTransformation*u;
      //zero = 1/m*sum(y);
      //u = TransformationMatrix *y;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{0,0},{-80,80},{-60,72},{-72,60},{-80,80}}, color={0,
                    0,255}),
              Line(points={{0,0},{-80,-80},{-72,-60},{-60,-72},{-80,-80}},
                  color={0,0,255}),
              Line(points={{0,0},{6.67,10},{13.33,17.32},{20,20},{26.67,17.32},
                    {33.33,10},{40,0},{46.67,-10},{53.33,-17.32},{60,-20},{
                    66.67,-17.32},{73.33,-10},{80,0}}, color={0,0,255}),
              Line(points={{-10,0},{-3.33,10},{3.33,17.32},{10,20},{16.67,17.32},
                    {23.33,10},{30,0},{36.67,-10},{43.33,-17.32},{50,-20},{
                    56.67,-17.32},{63.33,-10},{70,0}}, color={0,0,255}),
              Line(points={{10,0},{16.67,10},{23.33,17.32},{30,20},{36.67,17.32},
                    {43.33,10},{50,0},{56.67,-10},{63.33,-17.32},{70,-20},{
                    76.67,-17.32},{83.33,-10},{90,0}}, color={0,0,255}),
              Text(
                extent={{-62,-74},{14,-86}},
                lineColor={0,0,0},
                textString="zero")}),
          Documentation(info="<HTML>
Transformation of space phasor and zero sequence value to threephase values (voltages or currents).
</HTML>"));
      end FromSpacePhasor;

      block Rotator "Rotates space phasor"
        extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
      protected
        Real RotationMatrix[2,2] = {{+cos(-angle),-sin(-angle)},{+sin(-angle),+cos(-angle)}};
      //Real InverseRotator[2,2] = {{+cos(+angle),-sin(+angle)},{+sin(+angle),+cos(+angle)}};
      public
        Modelica.Blocks.Interfaces.RealInput angle
          annotation (Placement(transformation(
              origin={0,-120},
              extent={{-20,-20},{20,20}},
              rotation=90)));
      equation
        y = RotationMatrix*u;
      //u = InverseRotator*y;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{0,0},{0,80},{-10,60},{10,60},{0,80}}, color={0,0,
                    255}),
              Line(points={{0,0},{80,0},{60,10},{60,-10},{80,0}}, color={0,0,
                    255}),
              Ellipse(extent={{-50,50},{50,-50}}, lineColor={0,0,255}),
              Rectangle(
                extent={{-50,50},{-2,-50}},
                pattern=LinePattern.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255}),
              Rectangle(
                extent={{50,-2},{-2,-50}},
                pattern=LinePattern.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255}),
              Polygon(
                points={{50,0},{42,14},{54,16},{50,0}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-88,-72},{84,-92}},
                lineColor={0,0,0},
                textString="angle")}),
          Documentation(info="<HTML>
Rotates a space phasor (voltage or current) by the angle provided by the input signal \"angle\" from one coordinate system into another.
</HTML>"));
      end Rotator;

      block ToPolar "Converts a space phasor to polar coordinates"
        extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
        constant Real small=Modelica.Constants.small;
      equation
        y[1] = sqrt(u[1]^2 + u[2]^2);
        y[2] = if noEvent(y[1] <= small) then 0 else Modelica.Math.atan2(u[2], u[1]);
      /*
  if y[1] <= small then
    y[2] = 0;
  else
    if u[2] >= 0 then
      y[2] =  Modelica.Math.acos(u[1]/y[1]);
    else
      y[2] = -Modelica.Math.acos(u[1]/y[1]);
    end if;
  end if;
*/
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{-60,60},{-60,-60},{60,-60}}, color={0,0,255}),
              Line(points={{-100,-100},{100,100}}, color={0,0,255}),
              Polygon(points={{26,26},{14,20},{20,14},{26,26}}, lineColor={0,0,
                    255}),
              Line(points={{-18,-18},{-14,-22},{-10,-28},{-6,-34},{-2,-44},{0,-52},
                    {0,-60}}, color={0,0,255}),
              Polygon(points={{-18,-18},{-14,-26},{-10,-22},{-18,-18}},
                  lineColor={0,0,255}),
              Text(
                extent={{-100,100},{-6,-6}},
                lineColor={0,0,255},
                textString="R"),
              Text(
                extent={{6,6},{100,-100}},
                lineColor={0,0,255},
                textString="P")}),
          Documentation(info="<HTML>
Converts a space phasor from rectangular coordinates to polar coordinates.
</HTML>"));
      end ToPolar;

      block FromPolar "Converts a space phasor from polar coordinates"
        extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
      equation
        y = u[1]*{cos(u[2]),sin(u[2])};
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{-60,60},{-60,-60},{60,-60}}, color={0,0,255}),
              Line(points={{-100,-100},{100,100}}, color={0,0,255}),
              Polygon(points={{26,26},{14,20},{20,14},{26,26}}, lineColor={0,0,
                    255}),
              Line(points={{-18,-18},{-14,-22},{-10,-28},{-6,-34},{-2,-44},{0,-52},
                    {0,-60}}, color={0,0,255}),
              Polygon(points={{-18,-18},{-14,-26},{-10,-22},{-18,-18}},
                  lineColor={0,0,255}),
              Text(
                extent={{-100,100},{-6,-6}},
                lineColor={0,0,255},
                textString="P"),
              Text(
                extent={{6,6},{100,-100}},
                lineColor={0,0,255},
                textString="R")}),
          Documentation(info="<HTML>
Converts a space phasor from polar coordinates to rectangular coordinates.
</HTML>"));
      end FromPolar;
      annotation (Documentation(info="<HTML>
This package contains space phasor transformation blocks for use in controllers:
<ul>
<li>ToSpacePhasor: transforms a set of threephase values to space phasor and zero sequence system</li>
<li>FromSpacePhasor: transforms a space phasor and zero sequence system to a set of threephase values</li>
<li>Rotator: rotates a space phasor (from one coordinate system into another)</li>
<li>ToPolar: Converts a space phasor from rectangular coordinates to polar coordinates</li>
<li>FromPolar: Converts a space phasor from polar coordinates to rectangular coordinates</li>
</ul>
<p>
Space phasors are defined as vectors of length = 2,
the first element representing the real part and the second element representing the imaginary part of the space phasor.
</p>
</HTML>", revisions="<HTML>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.30 2004/11/05 Anton Haumer<br>
       several improvements in SpacePhasors.Blocks</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
</HTML>"));
    end Blocks;

    package Functions "Functions for space phasor transformation"
      extends Modelica.Icons.Library;

      function ToSpacePhasor "Conversion: three phase -> space phasor"
        extends Modelica.Icons.Function;
        constant Integer m=3 "Number of phases";
        constant Real pi=Modelica.Constants.pi;
        input Real x[3];
        output Real y[2];
        output Real y0;
      algorithm
        y := zeros(2);
        for k in 1:m loop
          y := y + 2/m*{+cos((k - 1)/m*2*pi), +sin(+(k - 1)/m*2*pi)}*x[k];
        end for;
        y0 := 1/m*sum(x);
        annotation (Inline=true, Documentation(info="<HTML>
Transformation of three phase values (voltages or currents) to space phasor and zero sequence value:<br>
y[k] = X0 + {cos(-(k - 1)/m*2*pi),-sin(-(k - 1)/m*2*pi)}*X[Re,Im]<br>
were y designates three phase values, X[Re,Im] designates the space phasor and X0 designates the zero sequence system.
</HTML>"));
      end ToSpacePhasor;

      function FromSpacePhasor "Conversion: space phasor -> three phase"
        extends Modelica.Icons.Function;
        constant Integer m=3 "Number of phases";
        constant Real pi=Modelica.Constants.pi;
        input Real x[2];
        input Real x0;
        output Real y[3];
      algorithm
        for k in 1:m loop
          y[k] := x0 + {cos(-(k - 1)/m*2*pi),-sin(-(k - 1)/m*2*pi)}*x;
        end for;
        annotation (Inline=true, Documentation(info="<HTML>
Transformation of space phasor and zero sequence value to three phase values (voltages or currents):<br>
Y0 = sum(x[k])/m<br>
Y[Re,Im] = sum(2/m*{cos((k - 1)/m*2*pi),sin((k - 1)/m*2*pi)}*x[k])<br>
were x designates three phase values, Y[Re,Im] designates the space phasor and Y0 designates the zero sequence system.
</HTML>"));
      end FromSpacePhasor;

      function Rotator "Rotates space phasor"
        extends Modelica.Icons.Function;
        input Real x[2];
        input Modelica.SIunits.Angle angle;
        output Real y[2];
      protected
        Real RotationMatrix[2,2] = {{+cos(-angle),-sin(-angle)},{+sin(-angle),+cos(-angle)}};
      algorithm
        y := RotationMatrix*x;
        annotation (Inline=true, Documentation(info="<HTML>
Rotates a space phasor (voltage or current) by the angle provided by input argument \"angle\" from one coordinate system into another:<br>
y[Re,Im] := {{+cos(-angle),-sin(-angle)},{+sin(-angle),+cos(-angle)}}*x[Re,Im]<br>
where y[Re,Im] designates the space phasor in the new coordinate system (twisted by angle against old coordinate system) and y[Re,Im] designates the space phasor in the old coordinate system.
</HTML>"));
      end Rotator;

      function ToPolar "Converts a space phasor to polar coordinates"
        extends Modelica.Icons.Function;
        constant Real small=Modelica.Constants.small;
        input Real x[2];
        output Real absolute;
        output Modelica.SIunits.Angle angle;
      algorithm
        absolute := sqrt(x[1]^2 + x[2]^2);
        angle := if absolute <= small then 0 else Modelica.Math.atan2(x[2], x[1]);
      /*
  if absolute <= small then
    angle := 0;
  else
    if x[2] >= 0 then
      angle :=  Modelica.Math.acos(x[1]/absolute);
    else
      angle := -Modelica.Math.acos(x[1]/absolute);
    end if;
  end if;
*/
        annotation (Inline=true, Documentation(info="<HTML>
Converts a space phasor from rectangular coordinates to polar coordinates, providing angle=0 for {0,0}.
</HTML>"));
      end ToPolar;

      function FromPolar "Converts a space phasor from polar coordinates"
        extends Modelica.Icons.Function;
        constant Real pi=Modelica.Constants.pi;
        constant Real small=Modelica.Constants.small;
        input Real absolute;
        input Modelica.SIunits.Angle angle;
        output Real x[2];
      algorithm
        x := absolute*{cos(angle),sin(angle)};
        annotation (Inline=true, Documentation(info="<HTML>
Converts a space phasor from polar coordinates to rectangular coordinates.
</HTML>"));
      end FromPolar;
      annotation (Documentation(info="<HTML>
This package contains space phasor transformation functions for use in calculations:
<ul>
<li>ToSpacePhasor: transforms a set of threephase values to space phasor and zero sequence system</li>
<li>FromSpacePhasor: transforms a space phasor and zero sequence system to a set of threephase values</li>
<li>Rotator: rotates a space phasor (from one coordinate system into another)</li>
<li>ToPolar: Converts a space phasor from rectangular coordinates to polar coordinates</li>
<li>FromPolar: Converts a space phasor from polar coordinates to rectangular coordinates</li>
</ul>
<p>
Space phasors are defined as vectors of length = 2,
the first element representing the real part and the second element representing the imaginary part of the space phasor.
</p>
</HTML>", revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>

  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
  </dd>

  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
</HTML>"));
    end Functions;
    annotation (Documentation(info="<HTML>
<p>
This package contains components, blocks and functions to utilize space phasor theory.
</p>
<p>
Space phasors are defined as vectors of length = 2,
the first element representing the real part and the second element representing the imaginary part of the space phasor.
</p>
<p>
You may have a look at a short summary of space phasor theory at <a href=\"http://www.haumer.at/refimg/SpacePhasors.pdf\">http://www.haumer.at/refimg/SpacePhasors.pdf</a>
</p>
</HTML>", revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.30 2004/11/05 Anton Haumer<br>
       several improvements in SpacePhasors.Blocks</li>
  <li> v1.60 2005/11/03 Anton Haumer<br>
       added Components.Rotator</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
</HTML>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Line(
            points={{-8,-26},{64,46},{44,38},{56,26},{64,46}},
            color={0,0,255},
            thickness=0.5), Line(
            points={{-8,-26},{64,-98},{56,-78},{44,-90},{64,-98}},
            color={0,0,255},
            thickness=0.5)}));
  end SpacePhasors;

  package Thermal "Library with models for connecting thermal models"
    extends Modelica.Icons.Library2;

    type LinearTemperatureCoefficient20 =
        Modelica.SIunits.LinearTemperatureCoefficient
      "Linear temperature coefficient with choices"
      annotation(choices(
        choice=Machines.Thermal.Constants.alpha20Zero
          "Not temperature dependent",
        choice=Machines.Thermal.Constants.alpha20Aluminium "Aluminium",
        choice=Machines.Thermal.Constants.alpha20Brass "Brass",
        choice=Machines.Thermal.Constants.alpha20Bronze "Bronze",
        choice=Machines.Thermal.Constants.alpha20Copper "Copper"));
    package Constants "Material Constants"
      constant Modelica.SIunits.LinearTemperatureCoefficient alpha20Zero=0
        "Not temperature dependent";
      constant Modelica.SIunits.LinearTemperatureCoefficient alpha20Aluminium=4.000e-3
        "Aluminium";
      constant Modelica.SIunits.LinearTemperatureCoefficient alpha20Brass =    1.100e-3 "Brass";
      constant Modelica.SIunits.LinearTemperatureCoefficient alpha20Bronze =  0.800e-3 "Bronze";
      constant Modelica.SIunits.LinearTemperatureCoefficient alpha20Copper =  3.920e-3 "Copper";
      annotation(Documentation(info="<HTML>
Material constants, especially linear temperature coefficients of commonly used conductor materials
</HTML>"));
    end Constants;

    function convertAlpha
      "Converts alpha from temperature 1 (default 20 degC) to temperature 2"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.LinearTemperatureCoefficient alpha1
        "Temperature coefficient at temperature 1 (default: 20 degC)";
      input Modelica.SIunits.Temperature T2 "Temperature 2";
      input Modelica.SIunits.Temperature T1=293.15
        "Temperature 1 (default: 20 degC)";
      output Modelica.SIunits.LinearTemperatureCoefficient alpha2
        "Temperature coefficient at TRef";
    algorithm
      alpha2 :=  alpha1 / (1 + alpha1*(T2 - T1));
      annotation(Inline=true, Documentation(info="<html>
<p>
From the temperature coefficient <code>alpha1</code> at temperature <code>T1</code> (default 20 degC = 293.15 K)
the temperature coefficient <code>alpha2</code> at temperature <code>T2</code> is calculated:
</p>
<pre>
                alpha1
  alpha2 = ------------------------
            1 + alpha1 * (T2 - T1)
</pre>
</html>"));
    end convertAlpha;

    function convertResistance
      "Converts resistance from reference temperature to an actual temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Resistance RRef "Resistance at TRef";
      input Modelica.SIunits.Temperature TRef "Reference temperature";
      input Modelica.SIunits.LinearTemperatureCoefficient alpha20
        "Temperature coefficient at 20 degC";
      input Modelica.SIunits.Temperature T "Actual temperature";
      output Modelica.SIunits.Resistance R "Actual resistance at T";
    algorithm
      R :=  RRef * (1 + Machines.Thermal.convertAlpha(alpha20, TRef)*(T - TRef));
      annotation(Inline=true, Documentation(info="<html>
<p>
From the temperature coefficient <code>alpha20</code> at 20 degC (equals to 293.15 K) the parameter <code>alphaRef</code> at <code>TRef</code>
</p>
<pre>
                        alpha20
  alphaRef = -------------------------------
              1 + alpha20 * (TRef - 293.15)
</pre>
<p>
is determined; using this value, actual resistance <code>R</code> with respect to the actual temperature <code>T</code> is calculated by
</p>
<pre>
   R
  ------ = 1 + alphaRef * (T - TRef)
   RRef
</pre>
<p>
where <code>RRef</code> is the resistance at the reference temperature <code>TRef</code>.
</p>
</html>"));
    end convertResistance;

    package AsynchronousInductionMachines
      "Thermal parts of asynchronous induction machines"
      extends Modelica.Icons.Library;
      model ThermalAmbientAIMC
        "Thermal ambient for asynchronous induction machine with squirrel cage"
        extends Machines.Interfaces.PartialThermalAmbientInductionMachines(
           redeclare final
            Machines.Interfaces.AsynchronousInductionMachines.ThermalPortAIMC
            thermalPort);
        parameter Modelica.SIunits.Temperature Tr(start=TDefault)
          "Temperature of rotor (squirrel cage)"
          annotation(Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flow_r = temperature_r.port.Q_flow
          "Heat flow rate of rotor (squirrel cage)";
        output Modelica.SIunits.HeatFlowRate Q_flow_total=
          Q_flow_s + Q_flow_r + Q_flow_core + Q_flow_stray + Q_flow_friction;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperature_r
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Interfaces.RealInput T_r if useTemperatureInputs
          "Temperature of squirrel cage"                        annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={80,-100})));
        Modelica.Blocks.Sources.Constant constT_r(final k=Tr) if not useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
      equation
        connect(constT_r.y, temperature_r.T)  annotation (Line(
            points={{-50,1},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(temperature_r.port, thermalPort.heatPort_r) annotation (Line(
            points={{-50,40},{-50,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(T_r, temperature_r.T) annotation (Line(
            points={{80,-100},{80,8},{-50,8},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
      annotation (Icon(graphics={
              Text(
                extent={{-100,-20},{100,-80}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                textString="AIMC")}),  Documentation(info="<HTML>
Thermal ambient for asynchronous induction machines with squirrel cage to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"));
      end ThermalAmbientAIMC;

      model ThermalAmbientAIMS
        "Thermal ambient for asynchronous induction machine with slipring"
        extends Machines.Interfaces.PartialThermalAmbientInductionMachines(
           redeclare final
            Machines.Interfaces.AsynchronousInductionMachines.ThermalPortAIMS
            thermalPort);
        parameter Modelica.SIunits.Temperature Tr(start=TDefault)
          "Temperature of rotor windings"
          annotation(Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flow_r = temperature_r.port.Q_flow
          "Heat flow rate of rotor (squirrel cage)";
        output Modelica.SIunits.HeatFlowRate Q_flow_total=
          Q_flow_s + Q_flow_r + Q_flow_core + Q_flow_stray + Q_flow_friction;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperature_r
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Interfaces.RealInput T_r if useTemperatureInputs
          "Temperature of rotor windings"                       annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={80,-100})));
        Modelica.Blocks.Sources.Constant constT_r(final k=Tr) if not useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector
          thermalCollectorRotor(m=thermalPort.m)
          annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
          temperature_brush(                                                     final T=TDefault)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,50})));
      equation
        connect(constT_r.y, temperature_r.T)  annotation (Line(
            points={{-50,1},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(thermalCollectorRotor.port_b, temperature_r.port) annotation (Line(
            points={{-50,60},{-50,40}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermalCollectorRotor.port_a, thermalPort.heatPort_r) annotation (
            Line(
            points={{-50,80},{-50,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(temperature_brush.port, thermalPort.heatPort_brush) annotation (
           Line(
            points={{6.12323e-016,60},{0,60},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
       annotation (Icon(graphics={
              Text(
                extent={{-100,-20},{100,-80}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                textString="AIMS")}),  Documentation(info="<HTML>
Thermal ambient for asynchronous induction machines with slipring rotor to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"));
      end ThermalAmbientAIMS;
    annotation(Documentation(info="<HTML>
Thermal parts for asynchronous induction machines
</HTML>"));
    end AsynchronousInductionMachines;

    package SynchronousInductionMachines
      "Thermal parts of synchronous induction machines"
      extends Modelica.Icons.Library;
      model ThermalAmbientSMPM
        "Thermal ambient for synchronous induction machine with permanent magnets"
        parameter Boolean useDamperCage(start = true)
          "Enable / disable damper cage"
          annotation(Evaluate=true);
        extends Machines.Interfaces.PartialThermalAmbientInductionMachines(
           redeclare final
            Machines.Interfaces.SynchronousInductionMachines.ThermalPortSMPM
            thermalPort(final useDamperCage = useDamperCage));
        parameter Modelica.SIunits.Temperature Tr(start=TDefault)
          "Temperature of damper cage (optional)"
          annotation(Dialog(enable=(not useTemperatureInputs and useDamperCage)));
        output Modelica.SIunits.HeatFlowRate Q_flow_r = temperature_r.port.Q_flow
          "Heat flow rate of damper cage (optional)";
        output Modelica.SIunits.HeatFlowRate Q_flow_pm = temperature_pm.port.Q_flow
          "Heat flow rate of permanent magnets";
        output Modelica.SIunits.HeatFlowRate Q_flow_total=
          Q_flow_s + Q_flow_r + Q_flow_pm + Q_flow_core + Q_flow_stray + Q_flow_friction;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperature_r
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Interfaces.RealInput T_r if (useTemperatureInputs and useDamperCage)
          "Temperature of damper cage (optional)"  annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={80,-100})));
        Modelica.Blocks.Sources.Constant constT_r(final k=if useDamperCage then Tr else TDefault) if (not useTemperatureInputs or not useDamperCage) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperature_pm(final T=TDefault)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
      equation
        connect(constT_r.y, temperature_r.T)  annotation (Line(
            points={{-50,1},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(temperature_r.port, thermalPort.heatPort_r) annotation (Line(
            points={{-50,40},{-50,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(T_r, temperature_r.T) annotation (Line(
            points={{80,-100},{80,10},{-50,10},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(temperature_pm.port, thermalPort.heatPort_pm) annotation (Line(
            points={{-20,40},{-20,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
      annotation (Icon(graphics={
              Text(
                extent={{-100,-20},{100,-80}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                textString="SMPM")}),  Documentation(info="<HTML>
Thermal ambient for synchronous induction machines with permanent magnets to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"));
      end ThermalAmbientSMPM;

      model ThermalAmbientSMEE
        "Thermal ambient for synchronous induction machine with electrical excitation"
        parameter Boolean useDamperCage(start = true)
          "Enable / disable damper cage"
          annotation(Evaluate=true);
        extends Machines.Interfaces.PartialThermalAmbientInductionMachines(
           redeclare final
            Machines.Interfaces.SynchronousInductionMachines.ThermalPortSMEE
            thermalPort(final useDamperCage = useDamperCage));
        parameter Modelica.SIunits.Temperature Tr(start=TDefault)
          "Temperature of damper cage (optional)"
          annotation(Dialog(enable=(not useTemperatureInputs and useDamperCage)));
        parameter Modelica.SIunits.Temperature Te(start=TDefault)
          "Temperature of excitation"
          annotation(Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flow_r = temperature_r.port.Q_flow
          "Heat flow rate of damper cage (optional)";
        output Modelica.SIunits.HeatFlowRate Q_flow_e = temperature_e.port.Q_flow
          "Heat flow rate of excitation";
        output Modelica.SIunits.HeatFlowRate Q_flow_total=
          Q_flow_s + Q_flow_r + Q_flow_e + Q_flow_core + Q_flow_stray + Q_flow_friction;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperature_r
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Interfaces.RealInput T_r if (useTemperatureInputs and useDamperCage)
          "Temperature of damper cage (optional)"                                   annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={80,-100})));
        Modelica.Blocks.Sources.Constant constT_r(final k=if useDamperCage then Tr else TDefault) if (not useTemperatureInputs or not useDamperCage) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperature_e
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
        Modelica.Blocks.Interfaces.RealInput T_e if useTemperatureInputs
          "Temperature of excitation"   annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-100})));
        Modelica.Blocks.Sources.Constant constT_e(final k=Te) if not useTemperatureInputs
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-10})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
          temperature_brush(                                                     final T=TDefault)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,50})));
      equation
        connect(constT_r.y, temperature_r.T)  annotation (Line(
            points={{-50,1},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(temperature_r.port, thermalPort.heatPort_r) annotation (Line(
            points={{-50,40},{-50,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(T_r, temperature_r.T) annotation (Line(
            points={{80,-100},{80,10},{-50,10},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(constT_e.y, temperature_e.T) annotation (Line(
            points={{-20,1},{-20,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T_e, temperature_e.T) annotation (Line(
            points={{0,-100},{0,6},{-20,6},{-20,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(temperature_e.port, thermalPort.heatPort_e) annotation (Line(
            points={{-20,40},{-20,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(temperature_brush.port, thermalPort.heatPort_brush) annotation (
           Line(
            points={{6.12323e-016,60},{0,60},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
      annotation (Icon(graphics={
              Text(
                extent={{-100,-20},{100,-80}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                textString="SMEE")}), Documentation(info="<HTML>
Thermal ambient for synchronous induction machines with electrical excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"));
      end ThermalAmbientSMEE;

      model ThermalAmbientSMR
        "Thermal ambient for synchronous induction machine with reluctance rotor"
        parameter Boolean useDamperCage(start = true)
          "Enable / disable damper cage"
          annotation(Evaluate=true);
        extends Machines.Interfaces.PartialThermalAmbientInductionMachines(
           redeclare final
            Machines.Interfaces.SynchronousInductionMachines.ThermalPortSMR
            thermalPort(final useDamperCage = useDamperCage));
        parameter Modelica.SIunits.Temperature Tr(start=TDefault)
          "Temperature of damper cage (optional)"
          annotation(Dialog(enable=(not useTemperatureInputs and useDamperCage)));
        output Modelica.SIunits.HeatFlowRate Q_flow_r = temperature_r.port.Q_flow
          "Heat flow rate of damper cage (optional))";
        output Modelica.SIunits.HeatFlowRate Q_flow_total=
          Q_flow_s + Q_flow_r + Q_flow_core + Q_flow_stray + Q_flow_friction;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperature_r
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Interfaces.RealInput T_r if (useTemperatureInputs and useDamperCage)
          "Temperature of damper cage (optional)"                                   annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={80,-100})));
        Modelica.Blocks.Sources.Constant constT_r(final k=if useDamperCage then Tr else TDefault) if (not useTemperatureInputs or not useDamperCage) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
      equation
        connect(constT_r.y, temperature_r.T)  annotation (Line(
            points={{-50,1},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(temperature_r.port, thermalPort.heatPort_r) annotation (Line(
            points={{-50,40},{-50,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(T_r, temperature_r.T) annotation (Line(
            points={{80,-100},{80,10},{-50,10},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
      annotation (Icon(graphics={
              Text(
                extent={{-100,-20},{100,-80}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                textString="SMR")}),  Documentation(info="<HTML>
Thermal ambient for synchronous induction machines with reluctance rotor to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"));
      end ThermalAmbientSMR;
    annotation(Documentation(info="<HTML>
Thermal parts for synchronous induction machines
</HTML>"));
    end SynchronousInductionMachines;

    package DCMachines "Thermal parts of DC machines"
      extends Modelica.Icons.Library;
      model ThermalAmbientDCPM
        "Thermal ambient for DC machine with permanent magnets"
        extends Machines.Interfaces.PartialThermalAmbientDCMachines(
           redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM
            thermalPort);
        output Modelica.SIunits.HeatFlowRate Q_flow_pm = temperature_pm.port.Q_flow
          "Heat flow rate of permanent magnets";
        output Modelica.SIunits.HeatFlowRate Q_flow_total=
          Q_flow_a + Q_flow_pm + Q_flow_core + Q_flow_stray + Q_flow_friction + Q_flow_brush;
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperature_pm(final T=TDefault)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
      equation
        connect(temperature_pm.port, thermalPort.heatPort_pm) annotation (Line(
            points={{-20,40},{-20,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
      annotation (Icon(graphics={
              Text(
                extent={{-100,-20},{100,-80}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                textString="DCPM")}),  Documentation(info="<HTML>
Thermal ambient for DC machines with permanent magnets to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"));
      end ThermalAmbientDCPM;

      model ThermalAmbientDCEE
        "Thermal ambient for DC machine with electrical excitation"
        extends Machines.Interfaces.PartialThermalAmbientDCMachines(
           redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE
            thermalPort);
        parameter Modelica.SIunits.Temperature Te(start=TDefault)
          "Temperature of (shunt) excitation"
          annotation(Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flow_e = temperature_e.port.Q_flow
          "Heat flow rate of (shunt) excitation";
        output Modelica.SIunits.HeatFlowRate Q_flow_total=
          Q_flow_a + Q_flow_e + Q_flow_core + Q_flow_stray + Q_flow_friction + Q_flow_brush;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperature_e
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
        Modelica.Blocks.Sources.Constant constT_e(final k=Te) if not useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-10})));
        Modelica.Blocks.Interfaces.RealInput T_e if useTemperatureInputs
          "Temperature of (shunt) excitation"            annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-100})));
      equation
        connect(temperature_e.port, thermalPort.heatPort_e) annotation (Line(
            points={{-20,40},{-20,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(constT_e.y, temperature_e.T) annotation (Line(
            points={{-20,1},{-20,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T_e, temperature_e.T) annotation (Line(
            points={{0,-100},{0,-60},{-40,-60},{-40,8},{-20,8},{-20,18}},
            color={0,0,127},
            smooth=Smooth.None));
      annotation (Icon(graphics={
              Text(
                extent={{-100,-20},{100,-80}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                textString="DCEE")}),  Documentation(info="<HTML>
Thermal ambient for DC machines with electrical (shunt) excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"));
      end ThermalAmbientDCEE;

      model ThermalAmbientDCSE
        "Thermal ambient for DC machine with series excitation"
        extends Machines.Interfaces.PartialThermalAmbientDCMachines(
           redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE
            thermalPort);
        parameter Modelica.SIunits.Temperature Tse(start=TDefault)
          "Temperature of series excitation"
          annotation(Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flow_se = temperature_se.port.Q_flow
          "Heat flow rate of series excitation";
        output Modelica.SIunits.HeatFlowRate Q_flow_total=
          Q_flow_a + Q_flow_se + Q_flow_core + Q_flow_stray + Q_flow_friction + Q_flow_brush;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperature_se
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Sources.Constant constT_se(final k=Tse) if not useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Blocks.Interfaces.RealInput T_se if useTemperatureInputs
          "Temperature of series excitation"             annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-40,-100})));
      equation
        connect(constT_se.y, temperature_se.T)
                                             annotation (Line(
            points={{-50,1},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T_se, temperature_se.T) annotation (Line(
            points={{-40,-100},{-40,-60},{-70,-60},{-70,8},{-50,8},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(temperature_se.port, thermalPort.heatPort_se) annotation (Line(
            points={{-50,40},{-50,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
      annotation (Icon(graphics={
              Text(
                extent={{-100,-20},{100,-80}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                textString="DCSE")}),  Documentation(info="<HTML>
Thermal ambient for DC machines with serial excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"));
      end ThermalAmbientDCSE;

      model ThermalAmbientDCCE
        "Thermal ambient for DC machine with compound excitation"
        extends Machines.Interfaces.PartialThermalAmbientDCMachines(
           redeclare final Machines.Interfaces.DCMachines.ThermalPortDCCE
            thermalPort);
        parameter Modelica.SIunits.Temperature Te(start=TDefault)
          "Temperature of (shunt) excitation"
          annotation(Dialog(enable=not useTemperatureInputs));
         parameter Modelica.SIunits.Temperature Tse(start=TDefault)
          "Temperature of series excitation"
          annotation(Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flow_e = temperature_e.port.Q_flow
          "Heat flow rate of (shunt) excitation";
        output Modelica.SIunits.HeatFlowRate Q_flow_se = temperature_se.port.Q_flow
          "Heat flow rate of series excitation";
        output Modelica.SIunits.HeatFlowRate Q_flow_total=
          Q_flow_a + Q_flow_e + Q_flow_se + Q_flow_core + Q_flow_stray + Q_flow_friction + Q_flow_brush;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperature_e
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
        Modelica.Blocks.Sources.Constant constT_e(final k=Te) if not useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-10})));
        Modelica.Blocks.Interfaces.RealInput T_e if useTemperatureInputs
          "Temperature of (shunt) excitation"            annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-100})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperature_se
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Sources.Constant constT_se(final k=Tse) if not useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Blocks.Interfaces.RealInput T_se if useTemperatureInputs
          "Temperature of series excitation"             annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-40,-100})));
      equation
        connect(temperature_e.port, thermalPort.heatPort_e) annotation (Line(
            points={{-20,40},{-20,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(constT_e.y, temperature_e.T) annotation (Line(
            points={{-20,1},{-20,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T_e, temperature_e.T) annotation (Line(
            points={{0,-100},{0,-60},{-40,-60},{-40,8},{-20,8},{-20,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(constT_se.y,temperature_se. T)
                                             annotation (Line(
            points={{-50,1},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T_se,temperature_se. T) annotation (Line(
            points={{-40,-100},{-40,-60},{-70,-60},{-70,8},{-50,8},{-50,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(temperature_se.port, thermalPort.heatPort_se) annotation (Line(
            points={{-50,40},{-50,100},{0,100}},
            color={191,0,0},
            smooth=Smooth.None));
      annotation (Icon(graphics={
              Text(
                extent={{-100,-20},{100,-80}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                textString="DCCE")}),  Documentation(info="<HTML>
Thermal ambient for DC machines with compound excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"));
      end ThermalAmbientDCCE;
    annotation(Documentation(info="<HTML>
Thermal parts for DC machines
</HTML>"));
    end DCMachines;

    model ThermalAmbientTransformer "Thermal ambient for transformers"
      parameter Boolean useTemperatureInputs=false
        "If true, temperature inputs are used; else, temperatures are constant"
        annotation(Evaluate=true);
      constant Modelica.SIunits.Temperature TDefault=293.15
        "Default temperature";
      parameter Modelica.SIunits.Temperature T1(start=TDefault)
        "Temperature of primary windings"
        annotation(Dialog(enable=not useTemperatureInputs));
      parameter Modelica.SIunits.Temperature T2(start=TDefault)
        "Temperature of secondary windings"
        annotation(Dialog(enable=not useTemperatureInputs));
      output Modelica.SIunits.HeatFlowRate Q_flow_1 = temperature_1.port.Q_flow
        "Heat flow rate of primary windings";
      output Modelica.SIunits.HeatFlowRate Q_flow_2 = temperature_2.port.Q_flow
        "Heat flow rate of secondary windings";
      output Modelica.SIunits.HeatFlowRate Q_flow_core = temperature_core.port.Q_flow
        "Heat flow rate of core losses";
      output Modelica.SIunits.HeatFlowRate Q_flow_total=Q_flow_1 + Q_flow_2 + Q_flow_core;
      Machines.Interfaces.ThermalPortTransformer thermalPort
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperature_1
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,30})));
      Modelica.Blocks.Sources.Constant constT_1(final k=T1) if
                                                      not useTemperatureInputs annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,-10})));
      Modelica.Blocks.Interfaces.RealInput T_1 if
                                         useTemperatureInputs
        "Temperature of primary windings"                     annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-80,-100})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperature_2
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={80,30})));
      Modelica.Blocks.Sources.Constant constT_2(final k=T1) if
                                                      not useTemperatureInputs annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={80,-10})));
      Modelica.Blocks.Interfaces.RealInput T_2 if
                                         useTemperatureInputs
        "Temperature of secondary windings"                   annotation (Placement(transformation(
            extent={{-20,20},{20,-20}},
            rotation=90,
            origin={80,-100})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperature_core(final T=
            TDefault)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,30})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector1(                                                        m=
           thermalPort.m)
        annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector2(                                                        m=
           thermalPort.m)
        annotation (Placement(transformation(extent={{70,60},{90,80}})));
    equation
      connect(T_1,temperature_1. T)           annotation (Line(
          points={{-80,-100},{-80,-60},{-100,-60},{-100,8},{-80,8},{-80,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(constT_1.y, temperature_1.T) annotation (Line(
          points={{-80,1},{-80,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T_2,temperature_2. T)           annotation (Line(
          points={{80,-100},{80,-60},{100,-60},{100,8},{80,8},{80,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(constT_2.y, temperature_2.T) annotation (Line(
          points={{80,1},{80,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(temperature_core.port, thermalPort.heatPort_core) annotation (Line(
          points={{6.12323e-016,40},{0,40},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(thermalCollector1.port_b, temperature_1.port) annotation (Line(
          points={{-80,60},{-80,40}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(thermalCollector2.port_b, temperature_2.port) annotation (Line(
          points={{80,60},{80,40}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(thermalCollector1.port_a, thermalPort.heatPort_1) annotation (Line(
          points={{-80,80},{-80,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(thermalCollector2.port_a, thermalPort.heatPort_2) annotation (Line(
          points={{80,80},{80,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-14,-8.26327e-016},{54,0}},
              color={191,0,0},
              thickness=0.5,
              origin={0,-6},
              rotation=90),
            Polygon(
              points={{-20,-20},{-20,20},{20,0},{-20,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid,
              origin={0,68},
              rotation=90),
            Text(
              extent={{-100,-20},{100,-80}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              textString="Trafo")}),  Documentation(info="<HTML>
Thermal ambient for transformers to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</HTML>"));
    end ThermalAmbientTransformer;
    annotation (Icon(graphics={             Ellipse(
            extent={{-86,50},{64,-100}},
            lineColor={191,0,0},
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid)}), Documentation(info="<HTML>
<h4>Thermal concept</h4>
<p>
Each machine model is equipped with a machine-specific conditional <code>thermalPort</code>.
If <code>useThermalPort == false</code>, a machine-specific thermal ambient precribing constant temperatures is used inside the machine.
If <code>useThermalPort == true</code>, a thermal model or machine-specific thermal ambient prescribing the temperatures has to be connected from outside.
On the other hand, all losses are dissipated to this internal or external thermal ambient.
</p>
<p>
The machine specific thermal connector contains <a href=Modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a>heatPort</a>s
for all relevant loss sources of the machine type, although some of the loss sources are not yet implemented;
these heatPorts are left unconnceted inside the machine, i.e. the HeatFlowRate is zero,
but they have to be connected to a constant temperature source in the internal or external thermal ambient.
Simple machine-specific thermal ambients for constant temperatures (<code>useTemperatureInputs == false</code>)
or temperatures prescribed via signal inputs (<code>useTemperatureInputs == true</code>) are provided in this package.
</p>
<h4>Loss sources</h4>
<p>
Up to now, only Ohmic losses in stator and rotor windings are implemented.
They are modeled as <a href=Modelica://Modelica.Electrical.Analog.Basic.Resistor>linearly temperature dependent rsistors</a>:
</p>
<pre>
   ROperational = RRef * (1 + alphaRef * (TOperational - TRef))
</pre>
<h5>Parameters:</h5>
<ul>
<li>Resistance <code>RRef</code> at reference temperature</li>
<li>Reference temperature <code>TRef</code></li>
<li>Linear temperature coefficient <code>alpha20</code> at 20&deg;C</li>
<li>Operational temperature <code>TOperational</code>
(if <code>useThermalPort == false</code>; otherwise, the operational temperature is provided via the heatPort)</li>
<li>Nominal temperature <code>TNominal</code>
(required for DC machines to calculate the turns ratio)</li>
</ul>
<p>
The linear temperature coefficient <code>alpha20</code> at 20&deg;C = 293.15 K has to be converted to reference temperature <code>TRef</code>:
</p>
<pre>
                        alpha20
  alphaRef = -------------------------------
              1 + alpha20 * (TRef - 293.15)
</pre>
<p>
For this reason, the function <a href=Modelica://Modelica.Electrical.Machines.Thermal.convertAlpha>convertAlpha</a> is provided.
In sub-package <a href=Modelica://Modelica.Electrical.Machines.Thermal.Constants>Constants</a> linear temperature coefficients at 20&deg;C for commonly used materials are defined.
</p>
<h4>Backwards compatibilty</h4>
<ul>
<li>The default / start values of all resistances are left unchanged.</li>
<li>The default / start values of all reference temperatures are set to 20&deg;C.</li>
<li>The default / start values of all linear temperature coefficents are set to 0.</li>
<li>The default / start values of all operational temperatures are set to 20&deg;C.</li>
<li>The default / start values of all nominal temperatures are set to 20&deg;C.</li>
</ul>
<h4>Machine specific thermalPorts</h4>
<h5><a href=Modelica://Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage>Asynchronous induction machine with squirrel cage</a></h5>
<ul>
<li><code>heatPort_s[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPort_r</code>: heatPort for the rotor cage</li>
<li><code>heatPort_core</code>: iron core losses (not yet connected/implemented)</li>
<li><code>heatPort_stray</code>: stray load losses (not yet connected/implemented)</li>
<li><code>heatPort_friction</code>: friction losses (not yet connected/implemented)</li>
</ul>
<h5><a href=Modelica://Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing>Asynchronous induction machine with slipring rotor</a></h5>
<ul>
<li><code>heatPort_s[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPort_r[m]</code>: m=3 heatPorts for the m=3 rotor phases</li>
<li><code>heatPort_brush</code>: brush losses (not yet connected/implemented)</li>
<li><code>heatPort_core</code>: iron core losses (not yet connected/implemented)</li>
<li><code>heatPort_stray</code>: stray load losses (not yet connected/implemented)</li>
<li><code>heatPort_friction</code>: friction losses (not yet connected/implemented)</li>
</ul>
<h5><a href=Modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet>Synchronous induction machine with permanent magnets</a></h5>
<ul>
<li><code>heatPort_s[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPort_r</code>: conditional (<code>useDamperCage=true/false</code>) heatPort for the damper cage</li>
<li><code>heatPort_pm</code>: permanet magnet losses (not yet connected/implemented)</li>
<li><code>heatPort_core</code>: iron core losses (not yet connected/implemented)</li>
<li><code>heatPort_stray</code>: stray load losses (not yet connected/implemented)</li>
<li><code>heatPort_friction</code>: friction losses (not yet connected/implemented)</li>
</ul>
<h5><a href=Modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited>Synchronous induction machine with electrical excitation</a></h5>
<ul>
<li><code>heatPort_s[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPort_r</code>: conditional (<code>useDamperCage=true/false</code>) heatPort for the damper cage</li>
<li><code>heatPort_e</code>: electrical excitation</li>
<li><code>heatPort_brush</code>: brush losses (not yet connected/implemented)</li>
<li><code>heatPort_core</code>: iron core losses (not yet connected/implemented)</li>
<li><code>heatPort_stray</code>: stray load losses (not yet connected/implemented)</li>
<li><code>heatPort_friction</code>: friction losses (not yet connected/implemented)</li>
</ul>
<h5><a href=Modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor>Synchronous induction machine with reluctance rotor</a></h5>
<ul>
<li><code>heatPort_s[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPort_r</code>: conditional (<code>useDamperCage=true/false</code>) heatPort for the damper cage</li>
<li><code>heatPort_core</code>: iron core losses (not yet connected/implemented)</li>
<li><code>heatPort_stray</code>: stray load losses (not yet connected/implemented)</li>
<li><code>heatPort_friction</code>: friction losses (not yet connected/implemented)</li>
</ul>
<h5><a href=Modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet>DC machine with permanent magnets</a></h5>
<ul>
<li><code>heatPort_a</code>: armature losses</li>
<li><code>heatPort_pm</code>: permanet magnet losses (not yet connected/implemented)</li>
<li><code>heatPort_brush</code>: brush losses (not yet connected/implemented)</li>
<li><code>heatPort_core</code>: iron core losses (not yet connected/implemented)</li>
<li><code>heatPort_stray</code>: stray load losses (not yet connected/implemented)</li>
<li><code>heatPort_friction</code>: friction losses (not yet connected/implemented)</li>
</ul>
<h5><a href=Modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_ElectricalExcited>DC machine with electrical (shunt) excitation</a></h5>
<ul>
<li><code>heatPort_a</code>: armature losses</li>
<li><code>heatPort_e</code>: electrical (shunt) excitation</li>
<li><code>heatPort_brush</code>: brush losses (not yet connected/implemented)</li>
<li><code>heatPort_core</code>: iron core losses (not yet connected/implemented)</li>
<li><code>heatPort_stray</code>: stray load losses (not yet connected/implemented)</li>
<li><code>heatPort_friction</code>: friction losses (not yet connected/implemented)</li>
</ul>
<h5><a href=Modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_SeriesExcited>DC machine with serial excitation</a></h5>
<ul>
<li><code>heatPort_a</code>: armature losses</li>
<li><code>heatPort_se</code>: electrical series excitation</li>
<li><code>heatPort_brush</code>: brush losses (not yet connected/implemented)</li>
<li><code>heatPort_core</code>: iron core losses (not yet connected/implemented)</li>
<li><code>heatPort_stray</code>: stray load losses (not yet connected/implemented)</li>
<li><code>heatPort_friction</code>: friction losses (not yet connected/implemented)</li>
</ul>
<h5><!--<a href=Modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_Compound>-->DC machine with compound excitation (not yet implemented)<!--</a>--></h5>
<ul>
<li><code>heatPort_a</code>: armature losses</li>
<li><code>heatPort_e</code>: electrical (shunt) excitation</li>
<li><code>heatPort_se</code>: electrical series excitation</li>
<li><code>heatPort_brush</code>: brush losses (not yet connected/implemented)</li>
<li><code>heatPort_core</code>: iron core losses (not yet connected/implemented)</li>
<li><code>heatPort_stray</code>: stray load losses (not yet connected/implemented)</li>
<li><code>heatPort_friction</code>: friction losses (not yet connected/implemented)</li>
</ul>
<h5><a href=Modelica://Modelica.Electrical.Machines.BasicMachines.Transformers>Transformers</a></h5>
<ul>
<li><code>heatPort1[m]</code>: m=3 heatPorts for the m=3 primary phases</li>
<li><code>heatPort2[m]</code>: m=3 heatPorts for the m=3 secondary phases</li>
<li><code>heatPort_core</code>: iron core losses (not yet connected/implemented)</li>
</ul>
</HTML>",   revisions="<HTML>
  <ul>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       first stable release of this subpackage:<br>
       conditional ThermalPort for all machines</li>
  </ul>
</HTML>"));
  end Thermal;

  package Interfaces "SpacePhasor connector and PartialMachines"
    extends Modelica.Icons.Library2;

    connector SpacePhasor "Connector for Space Phasors"
      Modelica.SIunits.Voltage v_[2] "1=real, 2=imaginary part";
      flow Modelica.SIunits.Current i_[2] "1=real, 2=imaginary part";
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{0,100},{-100,0},{0,-100},{100,0},{0,100}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-150,-90},{150,-150}},
              lineColor={0,0,255},
              textString="%name")}),     Icon(coordinateSystem(
              preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={Polygon(
              points={{0,100},{-100,0},{0,-100},{100,0},{0,100}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<HTML>
Connector for Space Phasors:
<ul>
<li>Voltage v_[2] ... Real and Imaginary part of voltage space phasor</li>
<li>Current i_[2] ... Real and Imaginary part of current space phasor</li>
</ul>
</HTML>"));
    end SpacePhasor;

    partial model PartialBasicMachine "Partial model for all machines"
      extends Machines.Icons.TransientMachineIcon;
      constant Modelica.SIunits.Angle pi=Modelica.Constants.pi;
      parameter Modelica.SIunits.Inertia Jr "Rotor's moment of inertia";
      parameter Boolean useSupport=false
        "Enable / disable (=fixed stator) support"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.Inertia Js(start=Jr)
        "Stator's moment of inertia"
        annotation(Dialog(enable=useSupport));
      parameter Boolean useThermalPort=false
        "Enable / disable (=fixed temperatures) thermal port"
        annotation(Evaluate=true);
      output Modelica.SIunits.Angle phiMechanical = flange.phi-internalSupport.phi
        "Mechanical angle of rotor against stator";
      output Modelica.SIunits.AngularVelocity wMechanical(displayUnit="1/min") = der(phiMechanical)
        "Mechanical angular velocity of rotor against stator";
      output Modelica.SIunits.Torque tauElectrical = inertiaRotor.flange_a.tau
        "Electromagnetic torque";
      output Modelica.SIunits.Torque tauShaft = -flange.tau "Shaft torque";
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Shaft"
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(final J=Jr)
        annotation (Placement(transformation(
            origin={80,0},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport
        "Support at which the reaction torque is acting"
           annotation (Placement(transformation(extent={{90,-110},{110,-90}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertiaStator(final J=Js) if useSupport
        annotation (Placement(transformation(
            origin={80,-100},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed if  (not useSupport)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=180,
            origin={90,-90})));
    protected
      Modelica.Mechanics.Rotational.Interfaces.Support internalSupport
        annotation (Placement(transformation(extent={{56,-104},{64,-96}},
              rotation=0)));
    equation
      connect(inertiaRotor.flange_b, flange)
                                            annotation (Line(points={{90,
              -1.22465e-015},{92,-1.22465e-015},{92,0},{100,0}},
                                                               color={0,0,0}));
      connect(inertiaStator.flange_b, support)
        annotation (Line(points={{90,-100},{100,-100}}, color={0,0,0}));
      connect(internalSupport, fixed.flange) annotation (Line(
          points={{60,-100},{60,-90},{90,-90}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(internalSupport, inertiaStator.flange_a) annotation (Line(
          points={{60,-100},{70,-100}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-120},{150,-180}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{80,-80},{120,-120}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              visible=not useSupport,
              points={{80,-100},{120,-100}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{90,-100},{80,-120}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{100,-100},{90,-120}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{110,-100},{100,-120}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              visible=not useSupport,
              points={{120,-100},{110,-120}},
              color={0,0,0},
              smooth=Smooth.None)}),
        Documentation(info="<HTML>
Base partial model DC machines:
<ul>
<li>main parts of the icon</li>
<li>mechanical shaft</li>
<li>mechanical support</li>
</ul>
Besides the mechanical connector <i>flange</i> (i.e. the shaft) the machines have a second mechanical connector <i>support</i>.<br>
If <i>useSupport</i> = false, it is assumed that the stator is fixed.<br>
Otherwise reaction torque (i.e. airGap torque, minus acceleration torque for stator's moment of inertia) can be measured at <i>support</i>.<br>
One may also fix the the shaft and let rotate the stator; parameter Js is only of importance when the stator is rotating.
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics));
    end PartialBasicMachine;

    partial model PartialBasicInductionMachine
      "Partial model for induction machine"
      extends PartialBasicMachine(Jr(start=0.29));
      constant Integer m=3 "Number of phases";
      parameter Integer p(min=1, start=2) "Number of pole pairs (Integer)";
      parameter Modelica.SIunits.Frequency fsNominal(start=50)
        "Nominal frequency";
      parameter Modelica.SIunits.Temperature TsOperational(start=293.15)
        "Operational temperature of stator resistance"
         annotation(Dialog(group="Operational temperatures", enable=not useThermalPort));
      parameter Modelica.SIunits.Resistance Rs(start=0.03)
        "Stator resistance per phase at TRef"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature TsRef(start=293.15)
        "Reference temperature of stator resistance"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s(
                 start=0)
        "Temperature coefficient of stator resistance at 20 degC"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal))
        "Stator stray inductance per phase"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      output Modelica.SIunits.Voltage vs[m] = plug_sp.pin.v - plug_sn.pin.v
        "Stator instantaneous voltages";
      output Modelica.SIunits.Current is[m] = plug_sp.pin.i
        "Stator instantaneous currents";
      output Modelica.SIunits.Current i_0_s( stateSelect=StateSelect.prefer) = spacePhasorS.zero.i
        "Stator zero-sequence current";
    // to be defined in model that extends from this partial (since airgap isn't included here)
      input Modelica.SIunits.Current idq_ss[2]
        "Stator space phasor current / stator fixed frame";
      input Modelica.SIunits.Current idq_sr[2](each stateSelect=StateSelect.prefer)
        "Stator space phasor current / rotor fixed frame";
      input Modelica.SIunits.Current idq_rs[2]
        "Rotor space phasor current / stator fixed frame";
      input Modelica.SIunits.Current idq_rr[2](each stateSelect=StateSelect.prefer)
        "Rotor space phasor current / rotor fixed frame";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m)
        "Positive stator plug"
        annotation (Placement(transformation(extent={{50,90},{70,110}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m)
        "Negative stator plug"
        annotation (Placement(transformation(extent={{-70,90},{-50,110}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor rs(
        final m=m,
        final R=fill(Rs, m),
        final T_ref=fill(TsRef, m),
        final alpha=fill(Machines.Thermal.convertAlpha(alpha20s, TsRef), m),
        final useHeatPort=true,
        final T=fill(TsRef,m))
        annotation (Placement(transformation(extent={{60,50},{40,70}}, rotation=
               0)));
      Modelica.Electrical.MultiPhase.Basic.Inductor lssigma(final m=m, final L=fill(Lssigma, m))
        annotation (Placement(transformation(extent={{30,50},{10,70}}, rotation=
               0)));
      SpacePhasors.Components.SpacePhasor spacePhasorS(final turnsRatio=1)
        annotation (Placement(transformation(
            origin={0,30},
            extent={{10,10},{-10,-10}},
            rotation=90)));
      replaceable PartialThermalPortInductionMachines thermalPort if useThermalPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      replaceable PartialThermalAmbientInductionMachines thermalAmbient(
        final useTemperatureInputs=false, final Ts=TsOperational) if not useThermalPort annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,-80})));
    protected
      replaceable PartialThermalPortInductionMachines internalThermalPort
        annotation (Placement(transformation(extent={{-4,-84},{4,-76}})));
    equation
      connect(plug_sp, rs.plug_p) annotation (Line(
          points={{60,100},{60,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(rs.plug_n, lssigma.plug_p) annotation (Line(
          points={{40,60},{30,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(lssigma.plug_n, spacePhasorS.plug_p) annotation (Line(
          points={{10,60},{10,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(spacePhasorS.plug_n, plug_sn) annotation (Line(
          points={{-10,40},{-10,60},{-60,60},{-60,100}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(spacePhasorS.ground,spacePhasorS. zero) annotation (Line(
          points={{-10,20},{-10,14},{-6.12323e-016,14},{-6.12323e-016,20}},
          color={0,0,255}));
      connect(thermalPort, internalThermalPort) annotation (Line(
          points={{0,-100},{0,-80}},
          color={199,0,0},
          smooth=Smooth.None));
      connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
          points={{-20,-80},{0,-80}},
          color={199,0,0},
          smooth=Smooth.None));
      connect(rs.heatPort, internalThermalPort.heatPort_s) annotation (Line(
          points={{50,50},{50,-80},{0,-80}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Documentation(info="<HTML>
Partial model for induction machine models
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-50,100},{-20,100},{-20,70}},
                color={0,0,255}), Line(points={{50,100},{20,100},{20,70}},
                color={0,0,255})}));
    end PartialBasicInductionMachine;

    partial connector PartialThermalPortInductionMachines
      "Partial thermal port of induction machines"
      constant Integer m=3 "Number of phases";

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_s[m]
        "Heat port of stator windings"
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_core
        "Heat port of (optional) core losses"
        annotation (Placement(transformation(extent={{0,10},{20,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_stray
        "Heat port of (optional) stray losses"
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_friction
        "Heat port of (optional) friction losses"
        annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
      annotation (Diagram(graphics={                           Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={199,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
                                    Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}), Icon(graphics={Rectangle(
              extent={{-110,110},{110,-110}},
              lineColor={199,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid), Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}), Documentation(info="<HTML>
Partial thermal port for induction machines
</HTML>"));
    end PartialThermalPortInductionMachines;

    partial model PartialThermalAmbientInductionMachines
      "Partial thermal ambient for induction machines"
      parameter Boolean useTemperatureInputs=false
        "If true, temperature inputs are used; else, temperatures are constant"
        annotation(Evaluate=true);
      constant Modelica.SIunits.Temperature TDefault=293.15
        "Default temperature";
      parameter Modelica.SIunits.Temperature Ts(start=TDefault)
        "Temperature of stator windings"
        annotation(Dialog(enable=not useTemperatureInputs));
      output Modelica.SIunits.HeatFlowRate Q_flow_s = temperature_s.port.Q_flow
        "Heat flow rate of stator windings";
      output Modelica.SIunits.HeatFlowRate Q_flow_core = temperature_core.port.Q_flow
        "Heat flow rate of core losses";
      output Modelica.SIunits.HeatFlowRate Q_flow_stray = temperature_stray.port.Q_flow
        "Heat flow rate of stray load losses";
      output Modelica.SIunits.HeatFlowRate Q_flow_friction = temperature_friction.port.Q_flow
        "Heat flow rate of friction losses";
      replaceable Machines.Interfaces.PartialThermalPortInductionMachines
        thermalPort
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperature_s
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,30})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperature_core(final T=TDefault)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,30})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperature_stray(final T=TDefault)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,30})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
        temperature_friction(                                                     final T=TDefault)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={80,30})));
      Modelica.Blocks.Interfaces.RealInput T_s if useTemperatureInputs
        "Temperature of stator windings"                      annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-80,-100})));
      Modelica.Blocks.Sources.Constant constT_s(final k=Ts) if not useTemperatureInputs annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,-10})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollectorStator(m=thermalPort.m)
        annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
    equation
      connect(constT_s.y, temperature_s.T)           annotation (Line(
          points={{-80,1},{-80,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T_s, temperature_s.T)           annotation (Line(
          points={{-80,-100},{-80,-60},{-100,-60},{-100,8},{-80,8},{-80,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(temperature_core.port, thermalPort.heatPort_core)
        annotation (Line(
          points={{20,40},{20,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(temperature_stray.port, thermalPort.heatPort_stray)
        annotation (Line(
          points={{50,40},{50,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(temperature_friction.port, thermalPort.heatPort_friction)
        annotation (Line(
          points={{80,40},{80,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(thermalCollectorStator.port_b, temperature_s.port) annotation (
          Line(
          points={{-80,60},{-80,40}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(thermalCollectorStator.port_a, thermalPort.heatPort_s)
        annotation (Line(
          points={{-80,80},{-80,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-14,-8.26327e-016},{54,0}},
              color={191,0,0},
              thickness=0.5,
              origin={0,-6},
              rotation=90),
            Polygon(
              points={{-20,-20},{-20,20},{20,0},{-20,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid,
              origin={0,68},
              rotation=90)}),      Documentation(info="<HTML>
Partial thermal ambient for induction machines
</HTML>"));
    end PartialThermalAmbientInductionMachines;

    partial model PartialBasicDCMachine "Partial model for DC machine"
      extends PartialBasicMachine(Jr(start=0.15));
      parameter Modelica.SIunits.Temperature TaOperational(start=293.15)
        "Operational armature temperature"
         annotation(Dialog(group="Operational temperatures", enable=not useThermalPort));
      parameter Modelica.SIunits.Voltage VaNominal(start=100)
        "Nominal armature voltage"
         annotation(Dialog(tab="Nominal parameters"));
      parameter Modelica.SIunits.Current IaNominal(start=100)
        "Nominal armature current (>0..Motor, <0..Generator)"
         annotation(Dialog(tab="Nominal parameters"));
      parameter Modelica.SIunits.AngularVelocity wNominal(displayUnit="1/min", start=1425*2*pi/60)
        "Nominal speed"
         annotation(Dialog(tab="Nominal parameters"));
      parameter Modelica.SIunits.Temperature TaNominal(start=293.15)
        "Nominal armature temperature"
         annotation(Dialog(tab="Nominal parameters"));
      parameter Modelica.SIunits.Resistance Ra(start=0.05)
        "Armature resistance at TRef"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature TaRef(start=293.15)
        "Reference temperature of armature resistance"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20a(
                 start=0) "Temperature coefficient of armature resistance"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance La(start=0.0015)
        "Armature inductance"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      output Modelica.SIunits.Voltage va = pin_ap.v-pin_an.v "Armature voltage";
      output Modelica.SIunits.Current ia = pin_ap.i "Armature current";
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap
        "Positive armature pin"
        annotation (Placement(transformation(extent={{50,110},{70,90}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_an
        "Negative armature pin"
        annotation (Placement(transformation(extent={{-70,110},{-50,90}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor ra(
        final R=Ra,
        final T_ref=TaRef,
        final alpha=Machines.Thermal.convertAlpha(alpha20a, TaRef),
        final useHeatPort=true,
        final T=TaRef)
        annotation (Placement(transformation(extent={{60,50},{40,70}}, rotation=0)));
      Machines.BasicMachines.Components.InductorDC la(final L=La, final
          quasiStationary =                                                             quasiStationary)
        annotation (Placement(transformation(extent={{30,50},{10,70}}, rotation=
               0)));

      replaceable PartialThermalPortDCMachines thermalPort if useThermalPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      replaceable PartialThermalAmbientDCMachines thermalAmbient(
        final useTemperatureInputs=false, final Ta=TaOperational) if not useThermalPort annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,-80})));
    protected
      constant Boolean quasiStationary=false "No electrical transients if true"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.Voltage ViNominal "Nominal induced Voltage";
      parameter Modelica.SIunits.MagneticFlux psi_eNominal
        "Nominal magnetic flux";
      parameter Real turnsRatio = ViNominal/(wNominal*psi_eNominal)
        "Ratio of armature turns over number of turns of the excitation winding";
      replaceable PartialThermalPortDCMachines internalThermalPort
        annotation (Placement(transformation(extent={{-4,-84},{4,-76}})));
    equation
      assert(ViNominal > Modelica.Constants.eps, "VaNominal has to be > (Ra[+Rse])*IaNominal");
      connect(la.p,ra. n)
        annotation (Line(points={{30,60},{40,60}}, color={0,0,255}));
      connect(pin_ap,ra. p)
        annotation (Line(points={{60,100},{60,60}}, color={0,0,255}));
      connect(thermalPort, internalThermalPort) annotation (Line(
          points={{0,-100},{0,-80}},
          color={199,0,0},
          smooth=Smooth.None));
      connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
          points={{-20,-80},{0,-80}},
          color={199,0,0},
          smooth=Smooth.None));
      connect(ra.heatPort, internalThermalPort.heatPort_a) annotation (Line(
          points={{50,50},{50,-80},{0,-80}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Documentation(info="<HTML>
Partial model for DC machine models.
</HTML>"), Icon(graphics={            Line(points={{-40,70},{-60,70},{-60,90}},
                color={0,0,255}), Line(points={{40,70},{60,70},{60,90}},
                color={0,0,255})}));
    end PartialBasicDCMachine;

    partial connector PartialThermalPortDCMachines
      "Partial thermal port of DC machines"

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_a
        "Heat port of armature"
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_core
        "Heat port of (optional) core losses"
        annotation (Placement(transformation(extent={{0,10},{20,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_stray
        "Heat port of (optional) stray losses"
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_friction
        "Heat port of (optional) friction losses"
        annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_brush
        "Heat port of (optional) brush losses"
        annotation (Placement(transformation(extent={{-10,30},{10,50}})));
      annotation (Diagram(graphics={                           Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={199,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
                                    Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}), Icon(graphics={Rectangle(
              extent={{-110,110},{110,-110}},
              lineColor={199,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid), Ellipse(
              extent={{-82,80},{78,-80}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}), Documentation(info="<HTML>
Partial thermal port for DC machines
</HTML>"));
    end PartialThermalPortDCMachines;

    partial model PartialThermalAmbientDCMachines
      "Partial thermal ambient for DC machines"
      parameter Boolean useTemperatureInputs=false
        "If true, temperature inputs are used; else, temperatures are constant"
        annotation(Evaluate=true);
      constant Modelica.SIunits.Temperature TDefault=293.15
        "Default temperature";
      parameter Modelica.SIunits.Temperature Ta(start=TDefault)
        "Temperature of armature"
        annotation(Dialog(enable=not useTemperatureInputs));
      output Modelica.SIunits.HeatFlowRate Q_flow_a = temperature_a.port.Q_flow
        "Heat flow rate of armature";
      output Modelica.SIunits.HeatFlowRate Q_flow_core = temperature_core.port.Q_flow
        "Heat flow rate of core losses";
      output Modelica.SIunits.HeatFlowRate Q_flow_stray = temperature_stray.port.Q_flow
        "Heat flow rate of stray load losses";
      output Modelica.SIunits.HeatFlowRate Q_flow_friction = temperature_friction.port.Q_flow
        "Heat flow rate of friction losses";
       output Modelica.SIunits.HeatFlowRate Q_flow_brush = temperature_brush.port.Q_flow
        "Heat flow rate of brushes";
      replaceable Machines.Interfaces.PartialThermalPortDCMachines thermalPort
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperature_a
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,30})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperature_core(final T=TDefault)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,30})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperature_stray(final T=TDefault)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={60,10})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
        temperature_friction(                                                     final T=TDefault)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={80,30})));
      Modelica.Blocks.Interfaces.RealInput T_a if useTemperatureInputs
        "Temperature of armature"                      annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-80,-100})));
      Modelica.Blocks.Sources.Constant constT_a(final k=Ta) if not useTemperatureInputs annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,-10})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperature_brush(final T=TDefault)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,10})));
    equation

      connect(constT_a.y, temperature_a.T) annotation (Line(
          points={{-80,1},{-80,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T_a, temperature_a.T) annotation (Line(
          points={{-80,-100},{-80,-60},{-100,-60},{-100,8},{-80,8},{-80,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(temperature_a.port, thermalPort.heatPort_a) annotation (Line(
          points={{-80,40},{-80,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(temperature_brush.port, thermalPort.heatPort_brush) annotation (Line(
          points={{20,20},{20,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(temperature_core.port, thermalPort.heatPort_core) annotation (Line(
          points={{40,40},{40,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(temperature_stray.port, thermalPort.heatPort_stray) annotation (Line(
          points={{60,20},{60,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(temperature_friction.port, thermalPort.heatPort_friction) annotation (
         Line(
          points={{80,40},{80,100},{0,100}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-14,-8.26327e-016},{54,0}},
              color={191,0,0},
              thickness=0.5,
              origin={0,-6},
              rotation=90),
            Polygon(
              points={{-20,-20},{-20,20},{20,0},{-20,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid,
              origin={0,68},
              rotation=90)}),      Documentation(info="<HTML>
Partial thermal ambient for induction machines
</HTML>"));
    end PartialThermalAmbientDCMachines;

    package AsynchronousInductionMachines
      "Thermal ports of asynchronous induction machines"
      extends Modelica.Icons.Library;
      connector ThermalPortAIMC
        "Thermal port of asynchronous induction machine with squirrel cage"
        extends Machines.Interfaces.PartialThermalPortInductionMachines;

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_r
          "Heat port of rotor (squirrel cage)"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        annotation (            Icon(graphics), Documentation(info="<HTML>
Thermal port for asnychronous induction machine with squirrel cage
</HTML>"));
      end ThermalPortAIMC;

      connector ThermalPortAIMS
        "Thermal port of asynchronous induction machine with slipring"
        extends Machines.Interfaces.PartialThermalPortInductionMachines;

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_r[m]
          "Heat port of rotor windings"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_brush
          "Heat port of (optional) brush losses"
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        annotation (            Icon(graphics), Documentation(info="<HTML>
Thermal port for asnychronous induction machine with slipring rotor
</HTML>"));
      end ThermalPortAIMS;
    annotation(Documentation(info="<HTML>
Thermal ports for asynchronous induction machines
</HTML>"));
    end AsynchronousInductionMachines;

    package SynchronousInductionMachines
      "Thermal ports of synchronous induction machines"
      extends Modelica.Icons.Library;
      connector ThermalPortSMPM
        "Thermal port of synchronous induction machine with permanent magnets"
        extends Machines.Interfaces.PartialThermalPortInductionMachines;
        parameter Boolean useDamperCage(start = true)
          "Enable / disable damper cage"
          annotation(Evaluate=true);

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_r if useDamperCage
          "Heat port of damper cage (optional)"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_pm
          "Heat port of permanent magnets"
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        annotation ( Icon(graphics), Documentation(info="<HTML>
Thermal port for snychronous induction machine with permanent magnets
</HTML>"));
      end ThermalPortSMPM;

      connector ThermalPortSMEE
        "Thermal port of synchronous induction machine with electrical excitation"
        extends Machines.Interfaces.PartialThermalPortInductionMachines;
        parameter Boolean useDamperCage(start = true)
          "Enable / disable damper cage"
          annotation(Evaluate=true);

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_r if useDamperCage
          "Heat port of damper cage (optional)"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_e
          "Heat port of excitation"
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_brush
          "Heat port of (optional) brush losses"
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        annotation ( Icon(graphics), Documentation(info="<HTML>
Thermal port for snychronous induction machine with electrical excitation
</HTML>"));
      end ThermalPortSMEE;

      connector ThermalPortSMR
        "Thermal port of synchronous induction machine with reluctance rotor"
        extends Machines.Interfaces.PartialThermalPortInductionMachines;
        parameter Boolean useDamperCage(start = true)
          "Enable / disable damper cage"
          annotation(Evaluate=true);

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_r if useDamperCage
          "Heat port of damper cage (optional)"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        annotation ( Icon(graphics), Documentation(info="<HTML>
Thermal port for snychronous induction machine with reluctance rotor
</HTML>"));
      end ThermalPortSMR;
    annotation(Documentation(info="<HTML>
Thermal ports for synchronous induction machines
</HTML>"));
    end SynchronousInductionMachines;

    package DCMachines "Thermal ports of DC machines"
      extends Modelica.Icons.Library;
      connector ThermalPortDCPM
        "Thermal port of DC machine with permanent magnets"
        extends Machines.Interfaces.PartialThermalPortDCMachines;

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_pm
          "Heat port of permanent magnets"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        annotation ( Icon(graphics), Documentation(info="<HTML>
Thermal port for DC machine with permanent magnets
</HTML>"));
      end ThermalPortDCPM;

      connector ThermalPortDCEE
        "Thermal port of DC machine with electrical excitation"
        extends Machines.Interfaces.PartialThermalPortDCMachines;

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_e
          "Heat port of (shunt) excitation"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        annotation ( Icon(graphics), Documentation(info="<HTML>
Thermal port for DC machine with electrical (shunt) excitation
</HTML>"));
      end ThermalPortDCEE;

      connector ThermalPortDCSE
        "Thermal port of DC machine with series excitation"
        extends Machines.Interfaces.PartialThermalPortDCMachines;

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_se
          "Heat port of series excitation"
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        annotation ( Icon(graphics), Documentation(info="<HTML>
Thermal port for DC machine with serial excitation
</HTML>"));
      end ThermalPortDCSE;

      connector ThermalPortDCCE
        "Thermal port of DC machine with compound excitation"
        extends Machines.Interfaces.PartialThermalPortDCMachines;

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_e
          "Heat port of (shunt) excitation"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_se
          "Heat port of series excitation"
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        annotation ( Icon(graphics), Documentation(info="<HTML>
Thermal port for DC machine with compound excitation
</HTML>"));
      end ThermalPortDCCE;
    annotation(Documentation(info="<HTML>
Thermal ports for DC machines
</HTML>"));
    end DCMachines;

    partial model PartialBasicTransformer
      "Partial model of threephase transformer"
      extends Machines.Icons.TransientTransformerIcon;
      constant Integer m(min=1) = 3 "Number of phases";
      constant String VectorGroup="Yy00";
      parameter Real n(start=1)
        "Ratio primary voltage (line-to-line) / secondary voltage (line-to-line)";
      parameter Modelica.SIunits.Resistance R1(start=5E-3/(if C1=="D" then 1 else 3))
        "Primary resistance per phase at TRef"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature T1Ref(start=293.15)
        "Reference temperature of primary resistance"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20_1(
                  start=0)
        "Temperature coefficient of primary resistance at 20 degC"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance L1sigma(start=78E-6/(if C1=="D" then 1 else 3))
        "Primary stray inductance per phase"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Resistance R2(start=5E-3/(if C2=="d" then 1 else 3))
        "Secondary resistance per phase at TRef"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature T2Ref(start=293.15)
        "Reference temperature of secondary resistance"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20_2(
                  start=0)
        "Temperature coefficient of secondary resistance at 20 degC"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance L2sigma(start=78E-6/(if C2=="d" then 1 else 3))
        "Secondary stray inductance per phase"
         annotation(Dialog(tab="Nominal resistances and inductances"));
      parameter Boolean useThermalPort=false
        "Enable / disable (=fixed temperatures) thermal port"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.Temperature T1Operational(start=293.15)
        "Operational temperature of primary resistance"
         annotation(Dialog(group="Operational temperatures", enable=not useThermalPort));
      parameter Modelica.SIunits.Temperature T2Operational(start=293.15)
        "Operational temperature of secondary resistance"
         annotation(Dialog(group="Operational temperatures", enable=not useThermalPort));
      output Modelica.SIunits.Voltage v1[m]=plug1.pin.v "Primary voltage";
      output Modelica.SIunits.Current i1[m]=plug1.pin.i "Primary current";
      output Modelica.SIunits.Voltage v2[m]=plug2.pin.v "Secondary voltage";
      output Modelica.SIunits.Current i2[m]=plug2.pin.i "Secondary current";
    protected
      constant String C1 = Modelica.Utilities.Strings.substring(VectorGroup,1,1);
      constant String C2 = Modelica.Utilities.Strings.substring(VectorGroup,2,2);
      parameter Real ni=n*(if C2=="z" then sqrt(3) else 2)*(if C2=="d" then 1 else sqrt(3))/(if C1=="D" then 1 else sqrt(3));
    public
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug1(final m=m)
        "Primary plug"                                                        annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug2(final m=m)
        "Secondary plug"                                                      annotation (Placement(
            transformation(extent={{90,-10},{110,10}}, rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor r1(
        final m=m,
        final R=fill(R1,m),
        final T_ref=fill(T1Ref,m),
        final alpha=fill(Machines.Thermal.convertAlpha(alpha20_1, T1Ref), m),
        final useHeatPort=true,
        final T=fill(T1Ref,m))
        annotation (Placement(transformation(extent={{-90,10},{-70,-10}}, rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Inductor l1sigma(final m=m, final L=fill(L1sigma, m))
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor r2(
        final m=m,
        final R=fill(R2,m),
        final T_ref=fill(T2Ref,m),
        final alpha=fill(Machines.Thermal.convertAlpha(alpha20_2, T2Ref), m),
        final useHeatPort=true,
        final T=fill(T2Ref,m))
        annotation (Placement(transformation(extent={{70,10},{90,-10}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Inductor l2sigma(final m=m, final L=fill(L2sigma, m))
        annotation (Placement(transformation(extent={{50,-10},{70,10}},
              rotation=0)));
      Machines.BasicMachines.Components.IdealCore core(
        final m=m,
        final n12=ni,
        final n13=ni)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
      Machines.Interfaces.ThermalPortTransformer thermalPort if useThermalPort
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Thermal.ThermalAmbientTransformer thermalAmbient(final
          useTemperatureInputs =                                                  false,
        final T1=T1Operational,
        final T2=T2Operational) if not useThermalPort
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,80})));
    protected
      Machines.Interfaces.ThermalPortTransformer internalThermalPort
        annotation (Placement(transformation(extent={{-4,76},{4,84}})));
    equation
      connect(r1.plug_n,l1sigma. plug_p)
        annotation (Line(points={{-70,0},{-70,0}}, color={0,0,255}));
      connect(l2sigma.plug_n,r2. plug_p)
        annotation (Line(points={{70,0},{70,0}}, color={0,0,255}));
      connect(plug1, r1.plug_p)
        annotation (Line(points={{-100,0},{-90,0}}, color={0,0,255}));
      connect(r2.plug_n, plug2)
        annotation (Line(points={{90,0},{100,0}}, color={0,0,255}));
      connect(thermalPort, internalThermalPort) annotation (Line(
          points={{0,100},{0,80}},
          color={199,0,0},
          smooth=Smooth.None));
      connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
          points={{-20,80},{0,80}},
          color={199,0,0},
          smooth=Smooth.None));
      connect(r1.heatPort, internalThermalPort.heatPort_1) annotation (Line(
          points={{-80,10},{-80,60},{0,60},{0,80}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(r2.heatPort, internalThermalPort.heatPort_2) annotation (Line(
          points={{80,10},{80,60},{0,60},{0,80}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                          graphics),
                           Icon(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{0,-60},{0,-100}},
              lineColor={0,0,255},
              textString="%VectorGroup"),
            Text(
              extent={{0,100},{0,60}},
              lineColor={0,0,255},
              textString="%name")}),
        Documentation(info="<html>
Partialmodel of a threephase transformer, containing primary and secondary resistances and stray inductances, as well as the iron core.
Circuit layout (vector group) of primary and secondary windings have to be defined.
<br><b>Default values for transformer's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">turns ratio n</td>
<td valign=\"top\">1</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">nominal frequency fNominal</td>
<td valign=\"top\">50</td><td valign=\"top\">Hz</td>
</tr>
<tr>
<td valign=\"top\">nominal voltage per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">V RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal current per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">A RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal apparent power</td>
<td valign=\"top\">30</td><td valign=\"top\">kVA</td>
</tr>
<tr>
<td valign=\"top\">primary resistance R1</td>
<td valign=\"top\">0.005</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature T1Ref</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20_1 </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">primary stray inductance L1sigma</td>
<td valign=\"top\">78E-6</td><td valign=\"top\">H per phase</td>
</tr>
<tr>
<td valign=\"top\">secondary resistance R2</td>
<td valign=\"top\">0.005</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature T2Ref</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20_2 </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">secondary stray inductance L2sigma</td>
<td valign=\"top\">78E-6</td><td valign=\"top\">H per phase</td>
</tr>
<tr>
<td valign=\"top\">operational temperature T1Operational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">operational temperature T2Operational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">These values give the operational parameters:</td>
<td valign=\"top\"> </td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">nominal voltage drop</td>
<td valign=\"top\">0.05</td><td valign=\"top\">p.u.</td>
</tr>
<tr>
<td valign=\"top\">nominal copper losses</td>
<td valign=\"top\">300</td><td valign=\"top\">W</td>
</tr>
</table>
</html>"));
    end PartialBasicTransformer;

    connector ThermalPortTransformer "Thermal port of transformers"
      constant Integer m=3 "number of phases";

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_1[m]
        "Heat port of primary windings"
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_2[m]
        "Heat port of secondary windings"
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_core
        "Heat port of (optional) core losses"
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      annotation (Diagram(graphics={                           Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={199,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
                                    Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}), Icon(graphics={Rectangle(
              extent={{-110,110},{110,-110}},
              lineColor={199,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid), Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
               Documentation(info="<HTML>
Thermal port for transformers
</HTML>"));
    end ThermalPortTransformer;
    annotation (Documentation(info="<HTML>
This package contains the space phasor connector and partial models for machine models.
</HTML>", revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.01 2004/09/18 Anton Haumer<br>
       moved common equations from machine models to PartialMachine</li>
  <li> v1.02 2004/09/19 Anton Haumer<br>
       added PartialDCMachine</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v1.51 Beta 2005/02/01 Anton Haumer<br>
       changed parameter polePairs to Integer</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</HTML>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Polygon(
            points={{-70,-30},{-10,30},{50,-30},{-10,-90},{-70,-30}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}));
  end Interfaces;

  package Icons "Icons for electrical machines"
    extends Modelica.Icons.Library2;

    partial model TransientMachineIcon

      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,60},{80,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-40,60},{-60,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Rectangle(
              extent={{80,10},{100,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={95,95,95}),
            Rectangle(
              extent={{-40,70},{40,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},{80,
                  -100},{-50,-100},{-50,-90}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
This icon is designed for a <b>transient machine</b> model.
</p>
</html>"));
    end TransientMachineIcon;

    partial model QuasiStationaryMachineIcon

      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,60},{80,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={170,213,255}),
            Rectangle(
              extent={{-40,60},{-60,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Rectangle(
              extent={{80,10},{100,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={95,95,95}),
            Rectangle(
              extent={{-40,70},{40,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},{80,
                  -100},{-50,-100},{-50,-90}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
This icon is designed for a <b>quasistationary machine</b> model.
</p>
</html>"));
    end QuasiStationaryMachineIcon;

    partial model FundamentalWaveMachineIcon

      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,60},{80,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,128,0}),
            Rectangle(
              extent={{-40,60},{-60,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Rectangle(
              extent={{80,10},{100,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={95,95,95}),
            Rectangle(
              extent={{-40,70},{40,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},{80,
                  -100},{-50,-100},{-50,-90}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
This icon is designed for a <b>fundamentalwave machine</b> model.
</p>
</html>"));
    end FundamentalWaveMachineIcon;

    model TransientTransformerIcon

      annotation (Icon(graphics={
            Polygon(
              points={{-70,60},{-50,40},{-50,-40},{-70,-60},{-70,60}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder),
            Polygon(
              points={{70,60},{50,40},{50,-40},{70,-60},{70,60}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder),
            Polygon(
              points={{0,50},{-10,40},{-10,-40},{0,-50},{10,-40},{10,40},{0,50}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),
            Polygon(
              points={{-70,60},{70,60},{50,40},{10,40},{0,50},{-10,40},{-50,40},{-70,
                  60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),
            Polygon(
              points={{-70,-60},{70,-60},{50,-40},{10,-40},{0,-50},{-10,-40},{-50,
                  -40},{-70,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),
            Rectangle(
              extent={{-78,36},{-42,-36}},
              lineColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={128,0,255}),
            Rectangle(
              extent={{-84,28},{-36,-28}},
              lineColor={0,128,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-18,36},{18,-36}},
              lineColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={128,0,255}),
            Rectangle(
              extent={{-24,28},{24,-28}},
              lineColor={0,128,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={0,128,255}),
            Rectangle(
              extent={{42,36},{78,-36}},
              lineColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={128,0,255}),
            Rectangle(
              extent={{36,28},{84,-28}},
              lineColor={0,128,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={0,128,255})}),   Documentation(info="<html>
<p>
This icon is designed for a <b>transient transformer</b> model.
</p>
</html>"));
    end TransientTransformerIcon;

    partial model QuasiStationaryTransformerIcon

      annotation (Icon(graphics={
            Polygon(
              points={{-70,60},{-50,40},{-50,-40},{-70,-60},{-70,60}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder),
            Polygon(
              points={{70,60},{50,40},{50,-40},{70,-60},{70,60}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder),
            Polygon(
              points={{0,50},{-10,40},{-10,-40},{0,-50},{10,-40},{10,40},{0,50}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),
            Polygon(
              points={{-70,60},{70,60},{50,40},{10,40},{0,50},{-10,40},{-50,40},{-70,
                  60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),
            Polygon(
              points={{-70,-60},{70,-60},{50,-40},{10,-40},{0,-50},{-10,-40},{-50,
                  -40},{-70,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),
            Rectangle(
              extent={{-78,36},{-42,-36}},
              lineColor={213,170,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={213,170,255}),
            Rectangle(
              extent={{-84,28},{-36,-28}},
              lineColor={170,213,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={170,213,255}),
            Rectangle(
              extent={{-18,36},{18,-36}},
              lineColor={213,170,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={213,170,255}),
            Rectangle(
              extent={{-24,28},{24,-28}},
              lineColor={170,213,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={170,213,255}),
            Rectangle(
              extent={{42,36},{78,-36}},
              lineColor={213,170,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={213,170,255}),
            Rectangle(
              extent={{36,28},{84,-28}},
              lineColor={170,213,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={170,213,255})}), Documentation(info="<html>
<p>
This icon is designed for a <b>quasistationary transformer</b> model.
</p>
</html>"));
    end QuasiStationaryTransformerIcon;

    annotation(Documentation(info="<html>
<p>
This package contains definitions for the graphical layout of machines.
The icons can be utilized by inheriting them in the desired class using \"extends\" or by directly copying the \"icon\" layer.
</p>
</html>"));
  end Icons;

  package Utilities "Library with auxiliary models for testing"
    extends Modelica.Icons.Library;

    block VfController "Voltage-Frequency-Controller"
      extends Modelica.Blocks.Interfaces.SIMO(final nout=m);
      constant Modelica.SIunits.Angle pi=Modelica.Constants.pi;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage VNominal
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal "Nominal frequency";
      parameter Modelica.SIunits.Angle BasePhase=0 "Common phase shift";
      output Modelica.SIunits.Angle x(start=0, fixed=true) "Integrator state";
      output Modelica.SIunits.Voltage amplitude;
    equation
    //amplitude = sqrt(2)*VNominal*min(abs(u)/fNominal, 1);
      amplitude = sqrt(2)*VNominal*(if abs(u)<fNominal then abs(u)/fNominal else 1);
      der(x) = 2*pi*u;
      y = {amplitude*sin(x + BasePhase - (k - 1)*2/m*pi) for k in 1:m};
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-100,-100},{0,60},{80,60}}, color={0,0,255}),
            Line(points={{-70,0},{-60.2,29.9},{-53.8,46.5},{-48.2,58.1},{-43.3,
                  65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},{-23.6,61},{-18.6,
                  52},{-13,38.6},{-5.98,18.6},{8.79,-26.9},{15.1,-44},{20.8,-56.2},
                  {25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,-67.9},{45.4,-62.5},
                  {50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}}, color={192,192,
                  192}),
            Line(points={{-40,0},{-30.2,29.9},{-23.8,46.5},{-18.2,58.1},{-13.3,
                  65.2},{-8.3,69.2},{-3.4,69.8},{1.5,67},{6.4,61},{11.4,52},{17,
                  38.6},{24.02,18.6},{38.79,-26.9},{45.1,-44},{50.8,-56.2},{
                  55.7,-64},{60.6,-68.6},{65.5,-70},{70.5,-67.9},{75.4,-62.5},{
                  80.3,-54.1},{85.9,-41.3},{93,-21.7},{100,0}}, color={192,192,
                  192}),
            Line(points={{-100,0},{-90.2,29.9},{-83.8,46.5},{-78.2,58.1},{-73.3,
                  65.2},{-68.3,69.2},{-63.4,69.8},{-58.5,67},{-53.6,61},{-48.6,
                  52},{-43,38.6},{-35.98,18.6},{-21.21,-26.9},{-14.9,-44},{-9.2,
                  -56.2},{-4.3,-64},{0.6,-68.6},{5.5,-70},{10.5,-67.9},{15.4,-62.5},
                  {20.3,-54.1},{25.9,-41.3},{33,-21.7},{40,0}}, color={192,192,
                  192})}),
        Documentation(info="<HTML>
Simple Voltage-Frequency-Controller.<br>
Amplitude of voltage is linear dependent (VNominal/fNominal) on frequency (input signal \"u\"), but limited by VNominal (nominal RMS voltage per phase).<br>
m sine-waves with amplitudes as described above are provided as output signal \"y\".<br>
The sine-waves are intended to feed a m-phase SignalVoltage.<br>
Phase shifts between sine-waves may be choosen by the user; default values are <i>(k-1)/m*pi for k in 1:m</i>.
</HTML>"));
    end VfController;

    model SwitchYD "Y-D-switch"
      constant Integer m=3 "Number of phases";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plugSupply(final m=m)
        "To grid"
        annotation (Placement(transformation(extent={{-10,90},{10,110}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m)
        "To positive stator plug"
        annotation (Placement(transformation(extent={{50,-90},{70,-110}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m)
        "To negative stator plug"
        annotation (Placement(transformation(extent={{-70,-90},{-50,-110}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{20,-50},{40,-30}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Delta delta(final m=m)
        annotation (Placement(transformation(extent={{40,-80},{20,-60}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Ideal.IdealCommutingSwitch
        idealCommutingSwitch(                                                        final m=m)
        annotation (Placement(transformation(extent={{-10,-70},{10,-50}},
              rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        annotation (Placement(transformation(extent={{-120,-10},{-100,10}},
              rotation=0)));
    equation
      connect(delta.plug_p, plugSupply)
                                    annotation (Line(points={{40,-70},{60,-70},
              {60,100},{0,100}}, color={0,0,255}));
      connect(delta.plug_p, plug_sp)
                                    annotation (Line(points={{40,-70},{60,-70},
              {60,-100}}, color={0,0,255}));
      connect(idealCommutingSwitch.plug_n2, delta.plug_n) annotation (Line(
            points={{10,-60},{10,-70},{20,-70}}, color={0,0,255}));
      connect(idealCommutingSwitch.plug_n1, star.plug_p) annotation (Line(
            points={{10,-55},{10,-40},{20,-40}}, color={0,0,255}));
      connect(idealCommutingSwitch.plug_p,plug_sn)  annotation (Line(points={{
              -10,-60},{-60,-60},{-60,-100}}, color={0,0,255}));
      connect(control, idealCommutingSwitch.control) annotation (Line(
          points={{-110,0},{0,0},{0,-52}},
          color={255,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                          graphics),
                           Icon(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Polygon(
              points={{-100,-60},{-60,-100},{58,-100},{100,-60},{100,60},{60,
                  100},{-60,100},{-100,60},{-100,-60}},
              lineColor={175,175,175},
              smooth=Smooth.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,52},{-40,0},{-2,52},{-40,0},{-40,-52}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{0,40},{0,-40},{80,0},{0,40}},
              color={0,0,255},
              thickness=0.5)}),
        Documentation(info="<HTML>
Simple Star-Delta-switch.<br>
If <i>control</i> is false, plug_sp and plug_sn are star connected and plug_sp connected to the supply plug.<br>
If <i>control</i> is true, plug_sp and plug_sn are delta connected and they are connected to the supply plug.
</HTML>"));
    end SwitchYD;

    model TerminalBox "Terminal box Y/D-connection"
      constant Integer m=3 "Number of phases";
      parameter String terminalConnection(start="Y") "Choose Y=star/D=delta"
        annotation(choices(choice="Y" "Star connection",choice="D"
            "Delta connection"));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m)
        "To positive stator plug"
        annotation (Placement(transformation(extent={{50,-90},{70,-110}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m)
        "To negative stator plug"
        annotation (Placement(transformation(extent={{-70,-90},{-50,-110}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) if (terminalConnection<>"D")
        annotation (Placement(transformation(
            origin={-70,-80},
            extent={{-10,10},{10,-10}},
            rotation=180)));
      Modelica.Electrical.MultiPhase.Basic.Delta delta(final m=m) if (terminalConnection=="D")
        annotation (Placement(transformation(extent={{-20,-70},{-40,-50}},
              rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plugSupply(final m=m)
        "To grid"
        annotation (Placement(transformation(extent={{-10,-70},{10,-90}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin starpoint if (terminalConnection<>"D")
        annotation (Placement(transformation(extent={{-100,-90},{-80,-70}},
              rotation=0)));
    equation
      connect(plug_sn, star.plug_p)
        annotation (Line(points={{-60,-100},{-60,-80}}, color={0,0,255}));
      connect(plug_sn, delta.plug_n)        annotation (Line(points={{-60,-100},
              {-40,-100},{-40,-60}}, color={0,0,255}));
      connect(delta.plug_p,plug_sp)         annotation (Line(points={{-20,-60},
              {60,-60},{60,-100}}, color={0,0,255}));
      connect(plug_sp, plugSupply)          annotation (Line(points={{60,-100},
              {0,-100},{0,-80}}, color={0,0,255}));
      connect(star.pin_n, starpoint) annotation (Line(points={{-80,-80},{-90,
              -80}}, color={0,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                          graphics),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Polygon(
              points={{-80,-80},{-80,-84},{-80,-120},{-40,-140},{40,-140},{80,-110},
                  {80,-84},{76,-80},{-80,-80}},
              lineColor={95,95,95},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid), Text(
              extent={{-40,-90},{40,-130}},
              lineColor={0,0,0},
              textString="%terminalConnection")}),
        Documentation(info="<html>
TerminalBox: at the bottom connected to both machine plugs, connect at the top to the grid as usual,<br>
choosing Y-connection (StarDelta=Y) or D-connection (StarDelta=D).
</html>"));
    end TerminalBox;

    model SwitchedRheostat "Rheostat which is shortened after a given time"
      constant Integer m= 3 "Number of phases";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        "To positive rotor plug"
        annotation (Placement(transformation(extent={{90,70},{110,50}}, rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        "To negative rotor plug"
        annotation (Placement(transformation(extent={{90,-50},{110,-70}}, rotation=0)));
      parameter Modelica.SIunits.Resistance RStart "Starting resistance";
      parameter Modelica.SIunits.Time tStart
        "Duration of switching on the starting resistor";
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-40,-70},{-60,-50}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-80,-60},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Ideal.IdealCommutingSwitch
        idealCommutingSwitch(final m=m)
        annotation (Placement(transformation(
            origin={40,20},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Resistor rheostat(
        final m=m,
        final R=fill(RStart, m))
        annotation (Placement(transformation(extent={{0,-30},{-20,-10}}, rotation=0)));
      Modelica.Electrical.MultiPhase.Basic.Star starRheostat(final m=m)
        annotation (Placement(transformation(extent={{-40,-30},{-60,-10}}, rotation=
               0)));
      Modelica.Blocks.Sources.BooleanStep booleanStep[m](
        final startTime=fill(tStart, m),
        final startValue=fill(false, m))
        annotation (Placement(transformation(extent={{-60,10},{-40,30}}, rotation=0)));
    equation

      connect(plug_p, idealCommutingSwitch.plug_p) annotation (Line(
          points={{100,60},{40,60},{40,30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(idealCommutingSwitch.plug_n2, plug_n) annotation (Line(
          points={{40,10},{40,-60},{100,-60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(rheostat.plug_p, idealCommutingSwitch.plug_n1) annotation (Line(
          points={{0,-20},{35,-20},{35,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(idealCommutingSwitch.plug_n2, star.plug_p) annotation (Line(
          points={{40,10},{40,-60},{-40,-60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(rheostat.plug_n, starRheostat.plug_p) annotation (Line(
          points={{-20,-20},{-40,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(starRheostat.pin_n, star.pin_n) annotation (Line(
          points={{-60,-20},{-60,-60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(star.pin_n, ground.p) annotation (Line(
          points={{-60,-60},{-70,-60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(booleanStep.y, idealCommutingSwitch.control) annotation (Line(
          points={{-39,20},{32,20}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (         Icon(graphics={
            Rectangle(
              extent={{26,40},{54,-40}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{100,60},{-40,60},{-40,40}}, color={0,0,255}),
            Line(points={{100,-60},{-40,-60},{-40,-40}}, color={0,0,255}),
            Ellipse(extent={{-44,40},{-36,32}}, lineColor={0,0,255}),
            Ellipse(extent={{-44,-32},{-36,-40}}, lineColor={0,0,255}),
            Line(points={{-80,40},{-42,-34}}, color={0,0,255}),
            Line(points={{40,40},{40,42},{40,60}}, color={0,0,255}),
            Line(points={{40,-40},{40,-60}}, color={0,0,255}),
            Line(points={{10,-80},{70,-80}}, color={0,0,255}),
            Line(points={{40,-60},{40,-80}}, color={0,0,255}),
            Line(points={{20,-90},{60,-90}}, color={0,0,255}),
            Line(points={{30,-100},{50,-100}}, color={0,0,255})}), Documentation(info="<HTML>
<p>Switched rheostat, used for starting asynchronous induction motors with slipring rotor:</p>
<p>The external rotor resistance <code>RStart</code> is shortened at time <code>tStart</code>.</p>
</HTML>"));
    end SwitchedRheostat;

    model RampedRheostat "Rheostat with linearly decreasing resistance"
      constant Integer m= 3 "Number of phases";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        "To positive rotor plug"
        annotation (Placement(transformation(extent={{90,70},{110,50}}, rotation=0)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        "To negative rotor plug"
        annotation (Placement(transformation(extent={{90,-50},{110,-70}}, rotation=0)));
      parameter Modelica.SIunits.Resistance RStart "Starting resistance";
      parameter Modelica.SIunits.Time tStart
        "Time instance of reducing the rheostat";
      parameter Modelica.SIunits.Time tRamp "Duration of ramp";
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-20,-70},{-40,-50}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-70,-60},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.VariableResistor rheostat(final m=m)
        annotation (Placement(transformation(
            origin={60,0},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Blocks.Sources.Ramp ramp[m](
        final height=fill(-RStart, m),
        final duration=fill(tRamp, m),
        final offset=fill(RStart, m),
        final startTime=fill(tStart, m))
        annotation (Placement(transformation(extent={{-20,-10},{0,10}}, rotation=0)));
    equation
      connect(plug_p, rheostat.plug_p) annotation (Line(
          points={{100,60},{60,60},{60,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(rheostat.plug_n, plug_n) annotation (Line(
          points={{60,-10},{60,-60},{100,-60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(rheostat.R, ramp.y) annotation (Line(
          points={{50,1.83697e-015},{26,1.83697e-015},{26,0},{1,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(rheostat.plug_n, star.plug_p) annotation (Line(
          points={{60,-10},{60,-60},{-20,-60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(star.pin_n, ground.p) annotation (Line(
          points={{-40,-60},{-60,-60}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (         Icon(graphics={
            Rectangle(
              extent={{26,40},{54,-40}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{100,-60},{40,-60},{40,-40}}, color={0,0,255}),
            Line(points={{10,-80},{70,-80}}, color={0,0,255}),
            Line(points={{40,-60},{40,-80}}, color={0,0,255}),
            Line(points={{20,-90},{60,-90}}, color={0,0,255}),
            Line(points={{30,-100},{50,-100}}, color={0,0,255}),
            Line(points={{40,40},{40,60},{100,60}}, color={0,0,255}),
            Rectangle(
              extent={{-100,40},{-20,-40}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,24},{-72,24},{-30,-30}}, color={0,0,255}),
            Polygon(
              points={{-20,6},{-10,0},{-20,-6},{-20,6}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{10,6},{20,0},{10,-6},{10,6}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-10,0},{10,0}}, color={0,0,255}),
            Line(points={{20,0},{26,0}}, color={0,0,255})}), Documentation(info="<HTML>
<p>Ramped rheostat, used for starting asynchronous induction motors with slipring rotor:</p>
<p>The external rotor resistance <code>RStart</code> is reduced to zero,
starting at time <code>tStart</code> with a linear ramp <code>tRamp</code>.</p>
</HTML>"));
    end RampedRheostat;

  record TransformerData "Calculates Impedances from nominal values"
    extends Modelica.Icons.Record;
    parameter Modelica.SIunits.Frequency f(start=50) "Nominal frequency";
    parameter Modelica.SIunits.Voltage V1(start=100)
        "Primary nominal line-to-line voltage (RMS)";
    parameter String C1(start="Y") "Choose primary connection"
      annotation(choices(choice="Y" "Star connection",
                         choice="D" "Delta connection"));
    parameter Modelica.SIunits.Voltage V2(start=100)
        "Secondary open circuit line-to-line voltage (RMS) @ primary nominal voltage";
    parameter String C2(start="y") "Choose secondary connection"
      annotation(choices(choice="y" "Star connection",
                         choice="d" "Delta connection",
                         choice="z" "Zig-zag connection"));
    parameter Modelica.SIunits.ApparentPower SNominal(start=30E3)
        "Nominal apparent power";
    parameter Real v_sc(final min=0, final max=1, start=0.05)
        "Impedance voltage drop pu";
    parameter Modelica.SIunits.Power P_sc(start=300)
        "Short-circuit (copper) losses";

    parameter Real n = V1/V2
        "Ratio primary voltage (line-to-line) / secondary voltage (line-to-line)"
      annotation(Dialog(tab="Result", enable = false));
    final parameter Modelica.SIunits.Voltage V1ph = V1/(if C1=="D" then 1 else sqrt(3))
        "Primary phase voltage (RMS)";
    final parameter Modelica.SIunits.Current I1ph = SNominal/(3*V1ph)
        "Primary phase current (RMS)";
    final parameter Modelica.SIunits.Voltage V2ph = V2/(if C2=="d" then 1 else sqrt(3))
        "Secondary phase voltage (RMS)";
    final parameter Modelica.SIunits.Current I2ph = SNominal/(3*V2ph)
        "Secondary phase current (RMS)";
    final parameter Modelica.SIunits.Impedance Z1ph = 0.5*v_sc*V1ph/I1ph
        "Primary impedance per phase";
    parameter Modelica.SIunits.Resistance R1= 0.5*P_sc/(3*I1ph^2)
        "Warm primary resistance per phase"
      annotation(Dialog(tab="Result", enable = false));
    parameter Modelica.SIunits.Inductance L1sigma= sqrt(Z1ph^2-R1^2)/(2*Modelica.Constants.pi*f)
        "Primary stray inductance per phase"
      annotation(Dialog(tab="Result", enable = false));
    final parameter Modelica.SIunits.Impedance Z2ph = 0.5*v_sc*V2ph/I2ph
        "Secondary impedance per phase";
    parameter Modelica.SIunits.Resistance R2= 0.5*P_sc/(3*I2ph^2)
        "Warm secondary resistance per phase"
      annotation(Dialog(tab="Result", enable = false));
    parameter Modelica.SIunits.Inductance L2sigma= sqrt(Z2ph^2-R2^2)/(2*Modelica.Constants.pi*f)
        "Secondary stray inductance per phase"
      annotation(Dialog(tab="Result", enable = false));
    annotation(Documentation(info="<HTML>
<p>The parameters of the transformer models are calculated from parameters normally given in a technical description.</p>
</HTML>"));
  end TransformerData;

    record SynchronousMachineData
      "Computes machine parameter from usual datasheet"
      extends Modelica.Icons.Record;
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.ApparentPower SNominal(start=30E3)
        "Nominal apparent power";
      parameter Modelica.SIunits.Voltage VsNominal(start=100)
        "Nominal stator voltage per phase";
      final parameter Modelica.SIunits.Current IsNominal=SNominal/(3*VsNominal)
        "Nominal stator current per phase";
      final parameter Modelica.SIunits.Impedance ZReference=VsNominal/IsNominal
        "Reference impedance";
      parameter Modelica.SIunits.Frequency fsNominal(start=50)
        "Nominal stator frequency";
      final parameter Modelica.SIunits.AngularVelocity omega=2*pi*fsNominal
        "Nominal angular frequency";
      parameter Modelica.SIunits.Current IeOpenCircuit(start=10)
        "Open circuit excitation current @ nominal voltage and frequency";
      final parameter Real turnsRatio = sqrt(2)*VsNominal/(omega*Lmd*IeOpenCircuit)
        "Stator current / excitation current";
      parameter Real x0(start=0.1)
        "Stator stray inductance per phase (approximately zero impedance) [pu]";
      parameter Real xd(start=1.6)
        "Synchronous reactance per phase, d-axis [pu]";
      parameter Real xq(start=1.6)
        "Synchronous reactance per phase, q-axis [pu]";
      parameter Real xdTransient(start=0.1375)
        "Transient reactance per phase, d-axis [pu]";
      parameter Real xdSubtransient(start=0.121428571)
        "Subtransient reactance per phase, d-axis [pu]";
      parameter Real xqSubtransient(start=0.148387097)
        "Subtransient reactance per phase, q-axis [pu]";
      parameter Modelica.SIunits.Time Ta(start=0.014171268)
        "Armature time constant";
      parameter Modelica.SIunits.Time Td0Transient(start=0.261177343)
        "Open circuit field time constant Td0'";
      parameter Modelica.SIunits.Time Td0Subtransient(start=0.006963029)
        "Open circuit subtransient time constant Td0'', d-axis";
      parameter Modelica.SIunits.Time Tq0Subtransient(start=0.123345081)
        "Open circuit subtransient time constant Tq0'', q-axis";
      parameter Modelica.SIunits.Temperature TsSpecification(start=293.15)
        "Specification temperature of stator resistance"
        annotation(Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TsRef(start=293.15)
        "Reference temperature of stator resistance"
        annotation(Dialog(tab="Material"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s(start=0)
        "Temperature coefficient of stator resistance at 20 degC"
        annotation(Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TrSpecification(start=293.15)
        "Specification temperature of (optional) damper cage"
        annotation(Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TrRef(start=293.15)
        "Reference temperature of damper resistances in d- and q-axis"
        annotation(Dialog(tab="Material"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=0)
        "Temperature coefficient of damper resistances in d- and q-axis"
        annotation(Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TeSpecification(start=293.15)
        "Specification excitation temperature"
        annotation(Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TeRef(start=293.15)
        "Reference temperture of excitation resistance"
        annotation(Dialog(tab="Material"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=0)
        "Temperature coefficient of excitation resistance"
        annotation(Dialog(tab="Material"));
      final parameter Real xmd = xd - x0
        "Main field reactance per phase, d-axis [pu]";
      final parameter Real xmq = xq - x0
        "Main field reactance per phase, q-axis [pu]";
      final parameter Real xe =  xmd^2/(xd - xdTransient)
        "Excitation reactance [pu]";
      final parameter Real xrd = xmd^2/(xdTransient - xdSubtransient)*(1 - (xmd/xe))^2 + xmd^2/xe
        "Damper reactance per phase, d-axis [pu]";
      final parameter Real xrq = xmq^2/(xq - xqSubtransient)
        "Damper reactance per phase, d-axis [pu]";
      final parameter Real rs = 2/(1/xdSubtransient + 1/xqSubtransient)/(omega*Ta)
        "Stator resistance per phase at specifaction temperature [pu]";
      final parameter Real rrd = (xrd - xmd^2/xe)/(omega*Td0Subtransient)
        "Damper resistance per phase at specification temperature, d-axis [pu]";
      final parameter Real rrq = xrq/(omega*Tq0Subtransient)
        "Damper resistance per phase at specification temperature, q-axis [pu]";
      final parameter Real re =  xe/(omega*Td0Transient)
        "Excitation resistance per phase at specification temperature [pu]";
      parameter Modelica.SIunits.Resistance Rs=
        Thermal.convertResistance(rs*ZReference,TsSpecification,alpha20s,TsRef)
        "Stator resistance per phase at TRef"
         annotation(Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lssigma=x0*ZReference/omega
        "Stator stray inductance per phase"
         annotation(Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lmd=xmd*ZReference/omega
        "Main field inductance in d-axis"
         annotation(Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lmq=xmq*ZReference/omega
        "Main field inductance in q-axis"
         annotation(Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lrsigmad=(xrd - xmd)*ZReference/omega
        "Damper stray inductance in d-axis"
         annotation(Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lrsigmaq=(xrq - xmq)*ZReference/omega
        "Damper stray inductance in q-axis"
         annotation(Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Rrd=
        Thermal.convertResistance(rrd*ZReference,TrSpecification,alpha20r,TrRef)
        "Damper resistance in d-axis at TRef"
         annotation(Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Rrq=
        Thermal.convertResistance(rrq*ZReference,TrSpecification,alpha20r,TrRef)
        "Damper resistance in q-axis at TRef"
         annotation(Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Re=3/2*turnsRatio^2*
        Thermal.convertResistance(re*ZReference,TeSpecification,alpha20e,TeRef)
        "Excitation resistance at TRef"
         annotation(Dialog(tab="Result", enable=false));
      parameter Real sigmae=1 - xmd/xe
        "Stray fraction of total excitation inductance"
         annotation(Dialog(tab="Result", enable=false));
      annotation (defaultComponentName="smeeData", defaultComponentPrefixes="parameter",
      Documentation(info="<html>
<p>The parameters of the
<a href=\"Modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">
synchronous machine model with electrical excitation (and damper)</a> are calculated from parameters
normally given in a technical description, according to the standard EN&nbsp;60034-4:2008&nbsp;Appendix&nbsp;C.</p>
</html>"));
    end SynchronousMachineData;

    annotation (Documentation(info="<HTML>
This package contains utility components for testing examples.
</HTML>",
        revisions="<HTML>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2010, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.3.1 2004/11/06 Anton Haumer<br>
       small changes in VfController</li>
  <li> v1.6.1 2004/11/22 Anton Haumer<br>
       introduced TerminalBox</li>
  <li> v2.1.1 2010/02/05 Anton Haumer<br>
       included rheostats (designed by Christian Kral)</li>
  </ul>
</HTML>"));
  end Utilities;
  annotation (
  Settings(NewStateSelection=true, Evaluate=true),
   Documentation(info="<HTML>
This package contains components to model electrical machines:
<ul>
<li>Examples: test examples</li>
<li>BasicMachines: basic machine models</li>
<li>Sensors: sensors, usefull when modelling machines</li>
<li>SpacePhasors: an independent library for using space phasors</li>
<li>Thermal: Couple machine models with simple thermal models</li>
<li>Interfaces: Space phasor connector and partial machine models</li>
<li>Utilities: Useful models used in Examples</li>
</ul>
<b>Limitations and assumptions:</b>
<ul>
<li>number of phases (of induction machines) is limited to 3, therefore definition as a constant m=3</li>
<li>phase symmetric windings as well as symmetry of the whole machine structure</li>
<li>all values are used in physical units, no scaling to p.u. is done</li>
<li>only basic harmonics (in space) are taken into account</li>
<li>waveform (with respect to time) of voltages and currents is not restricted</li>
<li>constant parameters, i.e. no saturation, no skin effect</li>
<li>no iron losses, eddy currents, friction losses;<br>
    only ohmic losses in stator and rotor winding</li>
</ul>
<p>
You may have a look at a short summary of space phasor theory at <a href=\"http://www.haumer.at/refimg/SpacePhasors.pdf\">http://www.haumer.at/refimg/SpacePhasors.pdf</a>
</p>
<b>Further development:</b>
<ul>
<li>generalizing space phasor theory to m phases with arbitrary spatial angle of the coils</li>
<li>generalizing space phasor theory to arbitrary number of windings and winding factor of the coils</li>
<li>MachineModels: other machine types</li>
<li>effects: saturation, skin-effect, other losses than ohmic, ...</li>
</ul>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral<br>
  Austrian Institute of Technology <a href=\"http://www.ait.ac.at/\">AIT</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2010, Modelica Association, Anton Haumer and AIT.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00  2004/09/16 Anton Haumer<br>
       first stable release</li>
  <li> v1.01  2004/09/18 Anton Haumer<br>
       moved common equations from machine models to PartialMachine<br>
       improved MoveToRotational</li>
  <li> v1.02  2004/09/19 Anton Haumer<br>
       new package structure for machine types<br>
       added DC machine models</li>
  <li> v1.03  2004/09/24 Anton Haumer<br>
       added package Sensors<br>
       added DC machine with series excitation<br>
       debugged and improved MoveToRotational</li>
  <li> v1.1   2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.2   2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.3   2004/11/05 Anton Haumer<br>
       several improvements in SpacePhasors.Blocks</li>
  <li> v1.3.1 2004/11/06 Anton Haumer<br>
       small changes in Examples.Utilities.VfController</li>
  <li> v1.3.2 2004/11/10 Anton Haumer<br>
       ReluctanceRotor moved to SynchronousMachines</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v1.51  2005/02/01 Anton Haumer<br>
       changed parameter polePairs to Integer</li>
  <li> v1.52  2005/10/12 Anton Haumer<br>
       added BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited<br>
       using new basicMachines.Components.ElectricalExcitation<br>
       as well as a new exmaple.</li>
  <li> v1.53  2005/10/14 Anton Haumer<br>
       introduced unsymmetrical DamperCage for Synchronous Machines</li>
  <li> v1.60  2005/11/04 Anton Haumer<br>
       added SpacePhasors.Components.Rotator<br>
       corrected consistent naming of parameters and variables</li>
  <li> v1.6.1 2005/11/22 Anton Haumer<br>
       improved Transformation and Rotation in SpacePhasor.<br>
       introduced Examples.Utilities.TerminalBox</li>
  <li> v1.6.2 2005/10/23 Anton Haumer<br>
       selectable DamperCage for Synchronous Machines</li>
  <li> v1.6.3 2005/11/25 Anton Haumer<br>
       easier parametrisation of AsynchronousInductionMachines.AIM_SlipRing model</li>
  <li> v1.7.0 2005/12/15 Anton Haumer<br>
       back-changed the naming to ensure backward compatibility</li>
  <li> v1.7.1 2006/02/06 Anton Haumer<br>
       changed some naming of synchronous machines, not affecting existing models</li>
  <li> v1.8.0 2006/11/26 Anton Haumer<br>
       introduced package Transformers<br>
       moved common parameters and functionality to partial models,<br>
       keeping Interfaces.PartialBasicInductionMachines resp. PartialBasicDCMachine for compatibility reasons.<br>
       implemented support showing reaction torque if connected</li>
  <li> v1.8.1 2006/12/01 Anton Haumer<br>
       resolved a compatibility issue with airGap</li>
  <li> v1.8.2 2007/01/15 Anton Haumer<br>
       resolved a bug in electrical excited synchronous induction machine</li>
  <li> v1.8.3 2007/06/08 Anton Haumer<br>
       documentation update</li>
  <li> v1.8.4 2007/06/25 Anton Haumer<br>
       corrected some typos in documentation</li>
  <li> v1.8.5 2007/06/26 Anton Haumer<br>
       consistent parameters of DCSE</li>
  <li> v1.8.6 2007/08/12 Anton Haumer<br>
       improved documentation</li>
  <li> v1.8.7 2007/08/20 Anton Haumer<br>
       corrected typo in documentation</li>
  <li> v1.8.8 2007/08/20 Anton Haumer<br>
       improved documentation</li>
  <li> v1.9.0 2007/08/24 Anton Haumer<br>
       removed redeclare type SignalType</li>
  <li> v1.9.1 2007/10/15 Anton Haumer<br>
       solved a bug with replaceable airgap / partial machines</li>
  <li> v1.9.2 2007/10/15 Anton Haumer<br>
       changed some names to be more concise (see conversion script)</li>
  <li> v2.0.0 2007/11/13 Anton Haumer<br>
       removed replaceable from airgaps<br>
       removed cardinality from support, using a boolean parameter<br>
       removed all nonSIunits</li>
  <li> v2.1.0 2009/08/26 Anton Haumer<br>
       set all useHeatPort=false</li>
  <li> v2.1.1 2010/02/05 Anton Haumer<br>
       included Utilities.rheostats (designed by Christian Kral)</li>
  <li> v2.1.2 2010/02/09 Anton Haumer<br>
       included new Examples (AIMC_Transformer, DC_Comparison)</li>
  <li> v2.1.3 2010/02/10 Anton Haumer<br>
       prepared conditionalHeatPort of SquirrelCage and DamperCage</li>
  <li> v2.2.0 2010/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  <li> v2.3.0 2010/02/16 Anton Haumer<br>
       quasistationary DC machine models</li>
  </ul>
</HTML>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255}),
        Rectangle(
          extent={{-60,60},{-80,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={128,128,128}),
        Rectangle(
          extent={{60,10},{80,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-60,70},{20,50}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{60,
              -100},{-70,-100},{-70,-90}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end Machines;
