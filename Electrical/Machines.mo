package Machines "Library for electric machines" 
  extends Modelica.Icons.Library2;
  annotation (
  version="1.8.1", versionDate="2006-12-01",
  Settings(NewStateSelection=true, Evaluate=true),
  preferedView="info", Documentation(info="<HTML>
<p>
This package contains components to model electrical machines:
<ul>
<li>Examples: test examples</li>
<li>BasicMachines: basic machine models</li>
<li>Sensors: sensors, usefull when modelling machines</li>
<li>SpacePhasors: an independent library for using space phasors</li>
<li>Interfaces: Space phasor connector and partial machine models</li>
</ul>
</p>
<p>
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
You may have a look at a short summary of space phasor theory at <a href=\"http://www.haumer.at/refimg/SpacePhasors.pdf\">http://www.haumer.at/refimg/SpacePhasors.pdf</a>
</p>
<p>
<b>Further development:</b>
<ul>
<li>generalizing space phasor theory to m phases with arbitrary spatial angle of the coils</li>
<li>generalizing space phasor theory to arbitrary number of windings and winding factor of the coils</li>
<li>MachineModels: other machine types</li>
<li>effects: saturation, skin-effect, other losses than ohmic, ...</li>
</ul>
</p>
<p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
</p>
<p>
Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
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
       added BasicMachines.SynchronousInductionMachines.SM_ElectricalExcitedDamperCage<br>
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
  </ul>
</HTML>"),
    Icon(
      Rectangle(extent=[-60,60; 60,-60],    style(
          color=3,
          rgbcolor={0,0,255},
          gradient=2,
          fillColor=69,
          rgbfillColor={0,128,255})),
      Rectangle(extent=[-60,60; -80,-60],    style(
          color=10,
          gradient=2,
          fillColor=10)),
      Rectangle(extent=[60,10; 80,-10],  style(
          color=10,
          rgbcolor={95,95,95},
          gradient=2,
          fillColor=10,
          rgbfillColor={95,95,95})),
      Rectangle(extent=[-60,70; 20,50], style(
          color=10,
          rgbcolor={95,95,95},
          fillColor=10,
          rgbfillColor={95,95,95})),
  Polygon(points=[-70,-90; -60,-90; -30,-20; 20,-20; 50,-90; 60,-90; 60,-100;
            -70,-100; -70,-90],               style(
      color=0,
      gradient=0,
      fillColor=0,
      fillPattern=1))));
  
  package Examples "Test examples" 
    extends Modelica.Icons.Library2;
    annotation (Documentation(info="<HTML>
<p>
This package contains test examples of electric machines,<br>
and a package utilities with components used for the examples.
</p>

</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>

  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.01 2004/09/18 Anton Haumer<br>
       adapted to improved MoveToRotational</li>
  <li> v1.02 2004/09/19 Anton Haumer<br>
       added examples for DC machines</li>
  <li> v1.03 2004/09/24 Anton Haumer<br>
       usage of Sensors.CurrentRMSsensor<br>
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
  </ul>
</HTML>"), Icon(Ellipse(extent=[-80,44; 60,-96], style(color=10, rgbcolor={95,
                95,95})), Polygon(points=[-40,36; -40,-88; 60,-26; -40,36],
            style(
            color=10,
            rgbcolor={95,95,95},
            fillColor=10,
            rgbfillColor={95,95,95}))));
    
    model AIMC_DOL 
      "Test example 1: AsynchronousInductionMachineSquirrelCage direct-on-line" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Time tStart1=0.1 "start time";
      parameter Modelica.SIunits.Torque T_Load=161.4 "nominal load torque";
      parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm 
        rpmLoad=1440.45 "nominal load speed";
      parameter Modelica.SIunits.Inertia J_Load=0.29 "load's moment of inertia";
      annotation (
        Diagram,
        experiment(StopTime=1.5, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>1st Test example: Asynchronous induction Machine with squirrel cage - direct on line starting</b><br>
At start time tStart three phase voltage is supplied to the asynchronous induction machine with squirrel cage;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>CurrentRMSsensor1.I: stator current RMS</li>
<li>AIMC1.rpm_mechanical: motor's speed</li>
<li>AIMC1.tau_electrical: motor's torque</li>
</ul>
Default machine parameters of model <i>AIM_SquirrelCage</i> are used.
</p>
</HTML>"));
      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage 
        AIMC1 
        annotation (extent=[-20,-50; 0,-30],     rotation=0);
      Machines.Sensors.CurrentRMSsensor CurrentRMSsensor1 
        annotation (extent=[10,-10; -10,10],rotation=-90);
      Modelica.Electrical.MultiPhase.Sources.SineVoltage SineVoltage1(
        final m=m,
        freqHz=fill(fNominal, m),
        V=fill(sqrt(2/3)*VNominal, m)) 
        annotation (extent=[10,70; -10,50],    rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Modelica.Blocks.Sources.BooleanStep BooleanStep1[m](each startTime=tStart1) 
        annotation (extent=[-80,30; -60,50]);
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch IdealCloser1(final m=m) 
        annotation (extent=[10,20; -10,40],    rotation=-90);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-50; 60,-30]);
      Modelica.Mechanics.Rotational.QuadraticSpeedDependentTorque 
        QuadraticLoadTorque1(
                    w_nominal=Modelica.SIunits.Conversions.from_rpm(rpmLoad),
          tau_nominal=-T_Load,
        TorqueDirection=false) 
        annotation (extent=[90,-50; 70,-30]);
      Utilities.TerminalBox TerminalBox1(StarDelta="D") 
        annotation (extent=[-20,-30; 0,-10]);
    equation 
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(SineVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-6.12303e-016,70; -6.12303e-016,90; -50,90],
                                                        style(color=3));
      connect(SineVoltage1.plug_p, IdealCloser1.plug_p) 
        annotation (points=[6.12303e-016,50; 0,48; 1.22461e-015,46;
            6.12303e-016,46; 6.12303e-016,40], style(color=3));
      connect(AIMC1.flange_a, LoadInertia.flange_a)  annotation (points=[0,-40;
            40,-40], style(color=0, rgbcolor={0,0,0}));
      connect(LoadInertia.flange_b, QuadraticLoadTorque1.flange) 
        annotation (points=[60,-40; 70,-40], style(color=0, rgbcolor={0,0,0}));
      connect(BooleanStep1.y, IdealCloser1.control) annotation (points=[-59,40;
            -20,40; -20,30; -7,30],
                     style(color=5, rgbcolor={255,0,255}));
      connect(TerminalBox1.negativeMachinePlug, AIMC1.plug_sn) annotation (
          points=[-16,-30; -16,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.positiveMachinePlug, AIMC1.plug_sp) annotation (
          points=[-4,-30; -4,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.plugToGrid, CurrentRMSsensor1.plug_n) annotation (
          points=[-10,-28; -10,-20; -6.12303e-016,-20; -6.12303e-016,-10],
          style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(IdealCloser1.plug_n, CurrentRMSsensor1.plug_p) annotation (points=[
            -6.12303e-016,20; -6.12303e-016,17; 6.12303e-016,17; 6.12303e-016,
            10], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
    end AIMC_DOL;
    
    model AIMC_YD 
      "Test example 2: AsynchronousInductionMachineSquirrelCage Y-D" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Time tStart1=0.1 "start time";
      parameter Modelica.SIunits.Time tStart2=2.0 "2nd start time";
      parameter Modelica.SIunits.Torque T_Load=161.4 "nominal load torque";
      parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm 
        rpmLoad=1440.45 "nominal load speed";
      parameter Modelica.SIunits.Inertia J_Load=0.29 "load's moment of inertia";
      annotation (
        Diagram,
        experiment(StopTime=2.5, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>2nd Test example: Asynchronous induction Machine with squirrel cage - Y-D starting</b><br>
At start time tStart three phase voltage is supplied to the asynchronous induction machine with squirrel cage, first star-connected, then delta-connetced; the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 2.5 seconds and plot (versus time):
<ul>
<li>CurrentRMSsensor1.I: stator current RMS</li>
<li>AIMC1.rpm_mechanical: motor's speed</li>
<li>AIMC1.tau_electrical: motor's torque</li>
</ul>
Default machine parameters of model <i>AIM_SquirrelCage</i> are used.
</p>
</HTML>"));
      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage 
        AIMC1 
        annotation (extent=[-20,-50; 0,-30],     rotation=0);
      Machines.Sensors.CurrentRMSsensor CurrentRMSsensor1 
        annotation (extent=[10,-10; -10,10],rotation=-90);
      Modelica.Electrical.MultiPhase.Sources.SineVoltage SineVoltage1(
        final m=m,
        freqHz=fill(fNominal, m),
        V=fill(sqrt(2/3)*VNominal, m)) 
        annotation (extent=[10,70; -10,50],    rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Modelica.Blocks.Sources.BooleanStep BooleanStep1[m](each startTime=tStart1) 
        annotation (extent=[-80, 30; -60, 50]);
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch IdealCloser1(final m=m) 
        annotation (extent=[10,20; -10,40],    rotation=-90);
      Machines.Examples.Utilities.SwitchYD SwitchYD1 
                                            annotation (extent=[-20,-30; 0,-10]);
      Modelica.Blocks.Sources.BooleanStep BooleanStep2[m](each startTime=tStart2) 
        annotation (extent=[-80,-30; -60,-10]);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-50; 60,-30]);
      Modelica.Mechanics.Rotational.QuadraticSpeedDependentTorque 
        QuadraticLoadTorque1(
                    w_nominal=Modelica.SIunits.Conversions.from_rpm(rpmLoad),
          tau_nominal=-T_Load,
        TorqueDirection=false) 
        annotation (extent=[90,-50; 70,-30]);
    equation 
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(SineVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-6.12303e-016,70; -6.12303e-016,90; -50,90],
                                                        style(color=3));
      connect(SineVoltage1.plug_p, IdealCloser1.plug_p) 
        annotation (points=[6.12303e-016,50; 0,48; 1.22461e-015,46;
            6.12303e-016,46; 6.12303e-016,40], style(color=3));
      connect(SwitchYD1.plug_NS, AIMC1.plug_sn)  annotation (points=[-20,-30;
            -16,-30],
                   style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(AIMC1.flange_a, LoadInertia.flange_a)  annotation (points=[0,-40;
            40,-40], style(color=0, rgbcolor={0,0,0}));
      connect(LoadInertia.flange_b, QuadraticLoadTorque1.flange) 
        annotation (points=[60,-40; 70,-40], style(color=0, rgbcolor={0,0,0}));
      connect(BooleanStep1.y, IdealCloser1.control) annotation (points=[-59,40;
            -20,40; -20,30; -7,30],
                 style(color=5, rgbcolor={255,0,255}));
      connect(BooleanStep2.y, SwitchYD1.control) annotation (points=[-59,-20;
            -21,-20],style(color=5, rgbcolor={255,0,255}));
      connect(IdealCloser1.plug_n, CurrentRMSsensor1.plug_p) annotation (points=[
            -6.12303e-016,20; -6.12303e-016,18; 6.12303e-016,18; 6.12303e-016,
            10], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(CurrentRMSsensor1.plug_n, SwitchYD1.plug_P) annotation (points=[
            -6.12303e-016,-10; -6.12303e-016,-10; 0,-8; 0,-10], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(AIMC1.plug_sp, SwitchYD1.pug_PS) annotation (points=[-4,-30; 0,
            -30], style(color=3, rgbcolor={0,0,255}));
    end AIMC_YD;
    
    model AIMS_start "Test example 3: AsynchronousInductionMachineSlipRing" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Time tStart1=0.1 "1st start time";
      parameter Modelica.SIunits.Resistance Rstart=0.16 "starting resistance";
      parameter Modelica.SIunits.Time tStart2=1.0 "2nd start time";
      parameter Modelica.SIunits.Torque T_Load=161.4 "nominal load torque";
      parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm 
        rpmLoad=1440.45 "nominal load speed";
      parameter Modelica.SIunits.Inertia J_Load=0.29 "load's moment of inertia";
      annotation (
        Diagram,
        experiment(StopTime=1.5, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>3rd Test example: Asynchronous induction Machine with slipring rotor - resistance starting</b><br>
At start time tStart1 three phase voltage is supplied to the asynchronous induction machine with sliprings;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
using a starting resistance. At time tStart2 tStart2 is shortened, finally reaching nominal speed.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>CurrentRMSsensor1.I: stator current RMS</li>
<li>AIMS1.rpm_mechanical: motor's speed</li>
<li>AIMS1.tau_electrical: motor's torque</li>
</ul>
Default machine parameters of model <i>AIM_SlipRing</i> are used.
</p>
</HTML>"));
      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing AIMS1 
        annotation (extent=[-20,-50; 0,-30],     rotation=0);
      Machines.Sensors.CurrentRMSsensor CurrentRMSsensor1 
        annotation (extent=[10,-10; -10,10],rotation=-90);
      Modelica.Electrical.MultiPhase.Sources.SineVoltage SineVoltage1(
        final m=m,
        freqHz=fill(fNominal, m),
        V=fill(sqrt(2/3)*VNominal, m)) 
        annotation (extent=[10,70; -10,50],    rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Modelica.Blocks.Sources.BooleanStep BooleanStep1[m](each startTime=tStart1) 
        annotation (extent=[-80,30; -60,50]);
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch IdealCloser1(final m=m) 
        annotation (extent=[10,20; -10,40],    rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Star Star3(final m=m) 
        annotation (extent=[-50,-100; -70,-80]);
      Modelica.Electrical.Analog.Basic.Ground Ground3 
        annotation (extent=[-100,-100; -80,-80],  rotation=-90);
      Modelica.Electrical.MultiPhase.Ideal.IdealCommutingSwitch 
        IdealCommutingSwitch1(m=m) 
        annotation (extent=[-30,-50; -50,-30],   rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Resistor Resistor1(m=m, R=fill(Rstart, m)) 
        annotation (extent=[-50,-80; -70,-60]);
      Modelica.Electrical.MultiPhase.Basic.Star Star4(final m=m) 
        annotation (extent=[-80,-80; -100,-60]);
      Modelica.Blocks.Sources.BooleanStep BooleanStep2[m](each startTime=tStart2) 
        annotation (extent=[-80,-50; -60,-30]);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-50; 60,-30]);
      Modelica.Mechanics.Rotational.QuadraticSpeedDependentTorque 
        QuadraticLoadTorque1(
                    w_nominal=Modelica.SIunits.Conversions.from_rpm(rpmLoad),
          tau_nominal=-T_Load,
        TorqueDirection=false) 
        annotation (extent=[90,-50; 70,-30]);
      Utilities.TerminalBox TerminalBox1(StarDelta="D") 
        annotation (extent=[-20,-30; 0,-10]);
    equation 
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(SineVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-6.12303e-016,70; -6.12303e-016,90; -50,90],
                                                        style(color=3));
      connect(SineVoltage1.plug_p, IdealCloser1.plug_p) 
        annotation (points=[6.12303e-016,50; 0,48; 1.22461e-015,46;
            6.12303e-016,46; 6.12303e-016,40], style(color=3));
      connect(Star3.pin_n, Ground3.p) 
        annotation (points=[-70,-90; -80,-90],   style(color=3));
      connect(Star4.plug_p, Resistor1.plug_n) annotation (points=[-80,-70; -70,
            -70],  style(
          color=3,
          rgbcolor={0,0,255},
          gradient=2,
          fillColor=69,
          rgbfillColor={0,128,255}));
      connect(Resistor1.plug_p, IdealCommutingSwitch1.plug_n1) annotation (
          points=[-50,-70; -45,-70; -45,-50],    style(
          color=3,
          rgbcolor={0,0,255},
          gradient=2,
          fillColor=69,
          rgbfillColor={0,128,255}));
      connect(AIMS1.plug_rn, Star3.plug_p)  annotation (points=[-20,-46; -20,
            -90; -50,-90],
           style(color=3, rgbcolor={0,0,255}));
      connect(IdealCommutingSwitch1.plug_n2, AIMS1.plug_rn)  annotation (points=[
            -40,-50; -28,-50; -28,-46; -20,-46],
                                            style(color=3, rgbcolor={0,0,255}));
      connect(LoadInertia.flange_b, QuadraticLoadTorque1.flange) 
        annotation (points=[60,-40; 70,-40], style(color=0, rgbcolor={0,0,0}));
      connect(AIMS1.flange_a, LoadInertia.flange_a)  annotation (points=[0,-40;
            40,-40],
                  style(color=0, rgbcolor={0,0,0}));
      connect(IdealCommutingSwitch1.plug_p, AIMS1.plug_rp)  annotation (points=[
            -40,-30; -30,-30; -30,-34; -20,-34],  style(color=3, rgbcolor={0,0,
              255}));
      connect(BooleanStep1.y, IdealCloser1.control) annotation (points=[-59,40;
            -20,40; -20,30; -7,30],
                    style(color=5, rgbcolor={255,0,255}));
      connect(BooleanStep2.y, IdealCommutingSwitch1.control) annotation (points=[
            -59,-40; -48,-40], style(color=5, rgbcolor={255,0,255}));
      connect(IdealCloser1.plug_n, CurrentRMSsensor1.plug_p) annotation (points=[
            -6.12303e-016,20; -6.12303e-016,16; 6.12303e-016,16; 6.12303e-016,
            10], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.negativeMachinePlug, AIMS1.plug_sn) annotation (
          points=[-16,-30; -16,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.positiveMachinePlug, AIMS1.plug_sp) annotation (
          points=[-4,-30; -4,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.plugToGrid, CurrentRMSsensor1.plug_n) annotation (
          points=[-10,-28; -10,-20; -6.12303e-016,-20; -6.12303e-016,-10],
          style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
    end AIMS_start;
    
    model AIMC_Inverter 
      "Test example 4: AsynchronousInductionMachineSquirrelCage with inverter" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Frequency f=50 "actual frequency";
      parameter Modelica.SIunits.Time tRamp=1 "frequency ramp";
      parameter Modelica.SIunits.Torque T_Load=161.4 "nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.2 "time of load torque step";
      parameter Modelica.SIunits.Inertia J_Load=0.29 "load's moment of inertia";
      annotation (
        Diagram,
        experiment(StopTime=1.5, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>4th Test example: Asynchronous induction Machine with squirrel cage fed by an ideal inverter</b><br>
An ideal frequency inverter is modeled by using a VfController and a threephase SignalVoltage.<br>
Frequency is raised by a ramp, causing the asynchronous induction machine with squirrel cage to start, 
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>CurrentRMSsensor1.I: stator current RMS</li>
<li>AIMC1.rpm_mechanical: motor's speed</li>
<li>AIMC1.tau_electrical: motor's torque</li>
</ul>
Default machine parameters of model <i>AIM_SquirrelCage</i> are used.
</p>
</HTML>"));
      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage 
        AIMC1 
        annotation (extent=[-20,-50; 0,-30],     rotation=0);
      Machines.Sensors.CurrentRMSsensor CurrentRMSsensor1 
        annotation (extent=[10,-10; -10,10],rotation=-90);
      Modelica.Blocks.Sources.Ramp Ramp1(height=f, duration=tRamp) 
        annotation (extent=[-80,50; -60,70]);
      Machines.Examples.Utilities.VfController VfController1(
        final m=m,
        VNominal=VNominal,
        fNominal=fNominal) annotation (extent=[-40,50; -20,70]);
      Modelica.Electrical.MultiPhase.Sources.SignalVoltage SignalVoltage1(final m=m) 
        annotation (extent=[10,70; -10,50],    rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-50; 60,-30]);
      Modelica.Mechanics.Rotational.TorqueStep TorqueStep1(startTime=tStep, stepTorque=-T_Load) 
                    annotation (extent=[90,-50; 70,-30]);
      Utilities.TerminalBox TerminalBox1 annotation (extent=[-20,-30; 0,-10]);
    equation 
      connect(SignalVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-6.12303e-016,70; -6.12303e-016,90; -50,90],
                                                        style(color=3));
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(AIMC1.flange_a, LoadInertia.flange_a)  annotation (points=[0,-40;
            40,-40], style(color=0, rgbcolor={0,0,0}));
      connect(Ramp1.y, VfController1.u) annotation (points=[-59,60; -42,60], style(
            color=3, rgbcolor={0,0,255}));
      connect(VfController1.y, SignalVoltage1.v) annotation (points=[-19,60; -7,
            60],     style(color=3, rgbcolor={0,0,255}));
      connect(TorqueStep1.flange, LoadInertia.flange_b) 
        annotation (points=[70,-40; 60,-40], style(color=0, rgbcolor={0,0,0}));
      connect(SignalVoltage1.plug_p, CurrentRMSsensor1.plug_p) annotation (points=[
            6.12303e-016,50; 6.12303e-016,40; 6.12303e-016,40; 6.12303e-016,30;
            6.12303e-016,10; 6.12303e-016,10],   style(color=3, rgbcolor={0,0,
              255}));
      connect(TerminalBox1.negativeMachinePlug, AIMC1.plug_sn) annotation (
          points=[-16,-30; -16,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.positiveMachinePlug, AIMC1.plug_sp) annotation (
          points=[-4,-30; -4,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.plugToGrid, CurrentRMSsensor1.plug_n) annotation (
          points=[-10,-28; -10,-20; -6.12303e-016,-20; -6.12303e-016,-10],
          style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
    end AIMC_Inverter;
    
    model SMR_Inverter 
      "Test example 5: SynchronousInductionMachineReluctanceRotor with inverter" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Frequency f=50 "actual frequency";
      parameter Modelica.SIunits.Time tRamp=1 "frequency ramp";
      parameter Modelica.SIunits.Torque T_Load=46 "nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.2 "time of load torque step";
      parameter Modelica.SIunits.Inertia J_Load=0.29 "load's moment of inertia";
      annotation (
        Diagram,
        experiment(StopTime=1.5, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>5th Test example: Synchronous Induction Machine with Reluctance rotor fed by an ideal inverter</b><br>
An ideal frequency inverter is modeled by using a VfController and a threephase SignalVoltage.<br>
Frequency is raised by a ramp, causing the reluctance machine to start, 
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>CurrentRMSsensor1.I: stator current RMS</li>
<li>SMRD1.rpm_mechanical: motor's speed</li>
<li>SMRD1.tau_electrical: motor's torque</li>
<li>RotorAngle.rotorAngle: rotor displacement angle</li>
</ul>
Default machine parameters of model <i>SM_ReluctanceRotorDamperCage</i> are used.
</p>
</HTML>"));
      Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotorDamperCage
        SMR1 
        annotation (extent=[-20,-50; 0,-30]);
      Machines.Sensors.CurrentRMSsensor CurrentRMSsensor1 
        annotation (extent=[10,20; -10,40], rotation=-90);
      Machines.Sensors.RotorAngle RotorAngle1(p=SMR1.p) 
        annotation (extent=[10,-30; 30,-50],
                                           rotation=90);
      Modelica.Blocks.Sources.Ramp Ramp1(height=f, duration=tRamp) 
        annotation (extent=[-80,50; -60,70]);
      Machines.Examples.Utilities.VfController VfController1(
        final m=m,
        VNominal=VNominal,
        fNominal=fNominal) annotation (extent=[-40,50; -20,70]);
      Modelica.Electrical.MultiPhase.Sources.SignalVoltage SignalVoltage1(final m=m) 
        annotation (extent=[10,70; -10,50],    rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-50; 60,-30]);
      Modelica.Mechanics.Rotational.TorqueStep TorqueStep1(startTime=tStep, stepTorque=-T_Load) 
                    annotation (extent=[90,-50; 70,-30]);
      Utilities.TerminalBox TerminalBox1 annotation (extent=[-20,-30; 0,-10]);
    equation 
      connect(SignalVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-6.12303e-016,70; -6.12303e-016,90; -50,90],
                                                        style(color=3));
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(SMR1.flange_a, LoadInertia.flange_a)  annotation (points=[0,-40;
            40,-40], style(color=0, rgbcolor={0,0,0}));
      connect(Ramp1.y, VfController1.u) 
        annotation (points=[-59,60; -42,60], style(color=3, rgbcolor={0,0,255}));
      connect(VfController1.y, SignalVoltage1.v) 
        annotation (points=[-19,60; -7,60],  style(color=3, rgbcolor={0,0,255}));
      connect(LoadInertia.flange_b, TorqueStep1.flange) 
        annotation (points=[60,-40; 70,-40], style(color=0, rgbcolor={0,0,0}));
      connect(CurrentRMSsensor1.plug_p, SignalVoltage1.plug_p) annotation (
          points=[6.12303e-016,40; 6.12303e-016,42.5; 6.12303e-016,42.5;
            6.12303e-016,45; 6.12303e-016,50; 6.12303e-016,50], style(color=3,
            rgbcolor={0,0,255}));
      connect(SMR1.plug_sn, RotorAngle1.plug_n)  annotation (points=[-16,-30;
            -16,-20; 26,-20; 26,-30],
                      style(color=3, rgbcolor={0,0,255}));
      connect(SMR1.plug_sp, RotorAngle1.plug_p)  annotation (points=[-4,-30; 14,
            -30],                 style(color=3, rgbcolor={0,0,255}));
      connect(SMR1.flange_a, RotorAngle1.flange) 
        annotation (points=[0,-40; 10,-40],style(color=0, rgbcolor={0,0,0}));
      connect(TerminalBox1.positiveMachinePlug, SMR1.plug_sp)  annotation (points=[-4,-30;
            -4,-30],         style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.negativeMachinePlug, SMR1.plug_sn)  annotation (
          points=[-16,-30; -16,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.plugToGrid, CurrentRMSsensor1.plug_n) annotation (
          points=[-10,-28; -10,20; -6.12303e-016,20],        style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
    end SMR_Inverter;
    
    model SMPM_Inverter 
      "Test example 6: PermanentMagnetSynchronousInductionMachine with inverter" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Frequency f=50 "actual frequency";
      parameter Modelica.SIunits.Time tRamp=1 "frequency ramp";
      parameter Modelica.SIunits.Torque T_Load=181.4 "nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.2 "time of load torque step";
      parameter Modelica.SIunits.Inertia J_Load=0.29 "load's moment of inertia";
      annotation (
        Diagram,
        experiment(StopTime=1.5, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>6th Test example: Permanent Magnet Synchronous Induction Machine fed by an ideal inverter</b><br>
An ideal frequency inverter is modeled by using a VfController and a threephase SignalVoltage.<br>
Frequency is raised by a ramp, causing the permanent magnet synchronous induction machine to start, 
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>CurrentRMSsensor1.I: stator current RMS</li>
<li>PMSMD1.rpm_mechanical: motor's speed</li>
<li>PMSMD1.tau_electrical: motor's torque</li>
<li>RotorAngle.rotorAngle: rotor displacement angle</li>
</ul>
Default machine parameters of model <i>SM_PermanentMagnetDamperCage</i> are used.
</p>
<p>
<b>In practice it is nearly impossible to drive a PMSMD without current controller.</b>
</p>
</HTML>"));
      Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnetDamperCage
        SMPM1 
        annotation (extent=[-20,-50; 0,-30],     rotation=0);
      Machines.Sensors.CurrentRMSsensor CurrentRMSsensor1 
        annotation (extent=[10,20; -10,40], rotation=-90);
      Machines.Sensors.RotorAngle RotorAngle1(p=SMPM1.p) 
        annotation (extent=[30,-50; 10,-30],
                                           rotation=-90);
      Modelica.Blocks.Sources.Ramp Ramp1(height=f, duration=tRamp) 
        annotation (extent=[-80,50; -60,70]);
      Machines.Examples.Utilities.VfController VfController1(
        final m=m,
        VNominal=VNominal,
        fNominal=fNominal,
        BasePhase=+Modelica.Constants.pi/2) 
        annotation (extent=[-40,50; -20,70]);
      Modelica.Electrical.MultiPhase.Sources.SignalVoltage SignalVoltage1(final m=m) 
        annotation (extent=[10,70; -10,50],    rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-50; 60,-30]);
      Modelica.Mechanics.Rotational.TorqueStep TorqueStep1(startTime=tStep, stepTorque=-
            T_Load) annotation (extent=[90,-50; 70,-30]);
      Utilities.TerminalBox TerminalBox1 annotation (extent=[-20,-30; 0,-10]);
    equation 
      connect(SignalVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-6.12303e-016,70; -6.12303e-016,90; -50,90],
                                                        style(color=3));
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(Ramp1.y, VfController1.u) 
        annotation (points=[-59,60; -42,60], style(color=3, rgbcolor={0,0,255}));
      connect(VfController1.y, SignalVoltage1.v) 
        annotation (points=[-19,60; -7,60],  style(color=3, rgbcolor={0,0,255}));
      connect(LoadInertia.flange_b, TorqueStep1.flange) 
        annotation (points=[60,-40; 70,-40], style(color=0, rgbcolor={0,0,0}));
      connect(SignalVoltage1.plug_p, CurrentRMSsensor1.plug_p) annotation (points=[
            6.12303e-016,50; 0,50; 0,40; 6.12303e-016,40], style(color=3,
            rgbcolor={0,0,255}));
      connect(RotorAngle1.plug_n, SMPM1.plug_sn)  annotation (points=[26,-30;
            26,-20; -16,-20; -16,-30],
                      style(color=3, rgbcolor={0,0,255}));
      connect(RotorAngle1.plug_p, SMPM1.plug_sp)  annotation (points=[14,-30;
            -4,-30],                 style(color=3, rgbcolor={0,0,255}));
      connect(RotorAngle1.flange, SMPM1.flange_a) 
        annotation (points=[10,-40; 0,-40],style(color=0, rgbcolor={0,0,0}));
      connect(SMPM1.flange_a, LoadInertia.flange_a) 
        annotation (points=[0,-40; 40,-40], style(color=0, rgbcolor={0,0,0}));
      connect(TerminalBox1.negativeMachinePlug, SMPM1.plug_sn)  annotation (points=[-16,-30;
            -16,-30],          style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.positiveMachinePlug, SMPM1.plug_sp)  annotation (
          points=[-4,-30; -4,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.plugToGrid, CurrentRMSsensor1.plug_n) annotation (
          points=[-10,-28; -10,20; -6.12303e-016,20],        style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
    end SMPM_Inverter;
    
    model SMEE_Gen 
      "Test example 7: ElectricalExcitedSynchronousInductionMachine as Generator" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm rpm
        =                                                                       1499 
        "nominal speed";
      parameter Modelica.SIunits.Current Ie = 19 "excitation current";
      parameter Modelica.SIunits.Current Ie0 = 10 "initial excitation current";
      parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg gamma0 = 0 
        "initial rotor displacement angle";
      annotation (
        Diagram,
        experiment(StopTime=30, Interval=0.005),
        experimentSetupOutput(doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>7th Test example: Electrical Excited Synchronous Induction Machine as generator</b><br>
An electrically excited synchronous generator is connected to the grid and driven with constant speed. 
Since speed is slightly smaller than synchronous speed corresponding to mains frequency, 
rotor angle is very slowly increased. This allows to see several charactersistics dependent on rotor angle.
Simulate for 30 seconds and plot (versus RotorAngle1.rotorAngle):
<ul>
<li>SMEED1.tau_electrical</li>
<li>CurrentRMSsensor1.I</li>
<li>ElectricalPowerSensor1.P</li>
<li>ElectricalPowerSensor1.Q</li>
<li>MechanicalPowerSensor1.P</li>
</ul>
Default machine parameters of model <i>SM_ElectricalExcitedDamperCage</i> are used.
</p>
</HTML>"));
      Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcitedDamperCage
        SMEE1(phi_mechanical(start=-(Modelica.Constants.pi +
              Modelica.SIunits.Conversions.from_deg(gamma0))/SMEE1.p)) 
        annotation (extent=[-20,-50; 0,-30],     rotation=0);
      Machines.Sensors.RotorAngle RotorAngle1(p=SMEE1.p) 
        annotation (extent=[30,-50; 10,-30],
                                           rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground Ground3 
        annotation (extent=[-100,-60; -80,-40],  rotation=-90);
      Modelica.Mechanics.Rotational.ConstantSpeed ConstantSpeed1(final w_fixed=
            Modelica.SIunits.Conversions.from_rpm(rpm)) 
        annotation (extent=[90,-50; 70,-30]);
      Sensors.MechanicalPowerSensor MechanicalPowerSensor1 
        annotation (extent=[40,-50; 60,-30]);
      Sensors.ElectricalPowerSensor ElectricalPowerSensor1 
        annotation (extent=[-10,50; 10,70],  rotation=-90);
      Sensors.CurrentRMSsensor CurrentRMSsensor1 
        annotation (extent=[10,20; -10,40],    rotation=-90);
      Modelica.Electrical.MultiPhase.Sources.SineVoltage SineVoltage1(
        final m=m,
        final V=fill(VNominal*sqrt(2), m),
        final freqHz=fill(fNominal, m)) 
        annotation (extent=[-20,80; -40,100]);
      Modelica.Electrical.MultiPhase.Basic.Star Star1(
                                  final m=m) 
        annotation (extent=[-50,80; -70,100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100,80; -80,100],   rotation=-90);
      Modelica.Electrical.Analog.Sources.RampCurrent RampCurrent1(
        duration=0.1,
        I=Ie - Ie0,
        offset=Ie0)        annotation (extent=[-60,-50; -40,-30], rotation=90);
      Utilities.TerminalBox TerminalBox1 annotation (extent=[-20,-30; 0,-10]);
    equation 
      connect(RotorAngle1.plug_n, SMEE1.plug_sn)  annotation (points=[26,-30;
            26,-20; -16,-20; -16,-30],
                      style(color=3, rgbcolor={0,0,255}));
      connect(RotorAngle1.plug_p, SMEE1.plug_sp)  annotation (points=[14,-30;
            -4,-30],                 style(color=3, rgbcolor={0,0,255}));
      connect(RotorAngle1.flange, SMEE1.flange_a) 
        annotation (points=[10,-40; 0,-40],style(color=0, rgbcolor={0,0,0}));
      connect(Star1.pin_n,Ground1. p) 
        annotation (points=[-70,90; -80,90],   style(color=3));
      connect(Star1.plug_p, SineVoltage1.plug_n) annotation (points=[-50,90;
            -40,90], style(color=3, rgbcolor={0,0,255}));
      connect(ElectricalPowerSensor1.plug_ni, CurrentRMSsensor1.plug_p) 
        annotation (points=[6.12303e-016,50; 1.76911e-022,46; 6.12303e-016,46;
            6.12303e-016,40], style(color=3, rgbcolor={0,0,255}));
      connect(SMEE1.flange_a, MechanicalPowerSensor1.flange_a) 
        annotation (points=[0,-40; 40,-40], style(color=0, rgbcolor={0,0,0}));
      connect(MechanicalPowerSensor1.flange_b, ConstantSpeed1.flange) 
        annotation (points=[60,-40; 70,-40], style(color=0, rgbcolor={0,0,0}));
      connect(SineVoltage1.plug_p, ElectricalPowerSensor1.plug_p) annotation (
          points=[-20,90; -6.12303e-016,90; -6.12303e-016,70], style(color=3,
            rgbcolor={0,0,255}));
      connect(RampCurrent1.p, Ground3.p) annotation (points=[-50,-50; -80,-50],
          style(color=3, rgbcolor={0,0,255}));
      connect(RampCurrent1.p, SMEE1.pin_en)  annotation (points=[-50,-50; -40,
            -50; -40,-46; -20,-46], style(color=3, rgbcolor={0,0,255}));
      connect(RampCurrent1.n, SMEE1.pin_ep)  annotation (points=[-50,-30; -40,
            -30; -40,-34; -20,-34], style(color=3, rgbcolor={0,0,255}));
      connect(SMEE1.plug_sn, TerminalBox1.negativeMachinePlug)  annotation (
          points=[-16,-30; -16,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(SMEE1.plug_sp, TerminalBox1.positiveMachinePlug)  annotation (
          points=[-4,-30; -4,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.plugToGrid, CurrentRMSsensor1.plug_n) annotation (
          points=[-10,-28; -10,20; -6.12303e-016,20],        style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(ElectricalPowerSensor1.plug_nv, SMEE1.plug_sn) annotation (points=
           [-10,60; -16,60; -16,-30], style(color=3, rgbcolor={0,0,255}));
    end SMEE_Gen;
    
    model DCPM_start 
      "Test example 8: DC with permanent magnet starting with voltage ramp" 
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Voltage Va=100 "actual armature voltage";
      parameter Modelica.SIunits.Time tStart=0.2 "armature voltage ramp";
      parameter Modelica.SIunits.Time tRamp=0.8 "armature voltage ramp";
      parameter Modelica.SIunits.Torque T_Load=63.66 "nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.5 "time of load torque step";
      parameter Modelica.SIunits.Inertia J_Load=0.15 "load's moment of inertia";
      annotation (
        Diagram,
        experiment(StopTime=2, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>8th Test example: Permanent magnet DC Machine started with an armature voltage ramp</b><br>
A voltage ramp is applied to the armature, causing the DC machine to start, 
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>DCPM1.ia: armature current</li>
<li>DCPM1.rpm_mechanical: motor's speed</li>
<li>DCPM1.tau_electrical: motor's torque</li>
</ul>
Default machine parameters of model <i>DC_PermanentMagnet</i> are used.
</p>
</HTML>"));
      Machines.BasicMachines.DCMachines.DC_PermanentMagnet DCPM1 
        annotation (extent=[-20,-50; 0,-30]);
      Modelica.Blocks.Sources.Ramp Ramp1(duration=tRamp, height=Va,
        startTime=tStart) 
        annotation (extent=[-80,60; -60,80]);
      Modelica.Electrical.Analog.Sources.SignalVoltage SignalVoltage1 
        annotation (extent=[0,30; -20,50],   rotation=0);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-80,30; -60,50],  rotation=-90);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-50; 60,-30]);
      Modelica.Mechanics.Rotational.TorqueStep TorqueStep1(startTime=tStep, stepTorque=-
            T_Load) annotation (extent=[90,-50; 70,-30]);
    equation 
      connect(DCPM1.flange_a, LoadInertia.flange_a) annotation (points=[0,-40;
            40,-40], style(color=0, rgbcolor={0,0,0}));
      connect(Ramp1.y, SignalVoltage1.v) annotation (points=[-59,70; -10,70;
            -10,47], style(color=3, rgbcolor={0,0,255}));
      connect(SignalVoltage1.p, DCPM1.pin_ap) annotation (points=[0,40; 0,-20;
            -4,-20; -4,-30], style(color=3, rgbcolor={0,0,255}));
      connect(SignalVoltage1.n, Ground1.p) annotation (points=[-20,40; -60,40],
                     style(color=3, rgbcolor={0,0,255}));
      connect(DCPM1.pin_an, SignalVoltage1.n) annotation (points=[-16,-30; -16,
            -20; -20,-20; -20,40],
                               style(color=3, rgbcolor={0,0,255}));
      connect(LoadInertia.flange_b, TorqueStep1.flange) 
        annotation (points=[60,-40; 70,-40], style(color=0, rgbcolor={0,0,0}));
    end DCPM_start;
    
    model DCEE_start 
      "Test example 9: DC with electrical ecxitation starting with voltage ramp" 
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Voltage Va=100 "actual armature voltage";
      parameter Modelica.SIunits.Time tStart=0.2 "armature voltage ramp";
      parameter Modelica.SIunits.Time tRamp=0.8 "armature voltage ramp";
      parameter Modelica.SIunits.Voltage Ve=100 "actual excitation voltage";
      parameter Modelica.SIunits.Torque T_Load=63.66 "nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.5 "time of load torque step";
      parameter Modelica.SIunits.Inertia J_Load=0.15 "load's moment of inertia";
      annotation (
        Diagram,
        experiment(StopTime=2, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>9th Test example: Electrically separate excited DC Machine started with an armature voltage ramp</b><br>
A voltage ramp is applied to the armature, causing the DC machine to start, 
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>DCEE1.ia: armature current</li>
<li>DCEE1.rpm_mechanical: motor's speed</li>
<li>DCEE1.tau_electrical: motor's torque</li>
<li>DCEE1.ie: excitation current</li>
</ul>
Default machine parameters of model <i>DC_ElectricalExcited</i> are used.
</p>
</HTML>"));
      Machines.BasicMachines.DCMachines.DC_ElectricalExcited DCEE1 
        annotation (extent=[-20,-50; 0,-30]);
      Modelica.Blocks.Sources.Ramp Ramp1(duration=tRamp, height=Va,
        startTime=tStart) 
        annotation (extent=[-80,60; -60,80]);
      Modelica.Electrical.Analog.Sources.SignalVoltage SignalVoltage1 
        annotation (extent=[0,30; -20,50],   rotation=0);
      Modelica.Electrical.Analog.Basic.Ground Grounda 
        annotation (extent=[-80,30; -60,50],  rotation=-90);
      Modelica.Electrical.Analog.Sources.ConstantVoltage ConstantVoltage1(V=Ve) 
        annotation (extent=[-50,-50; -30,-30], rotation=270);
      Modelica.Electrical.Analog.Basic.Ground Grounde 
        annotation (extent=[-80,-60; -60,-40],rotation=-90);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-50; 60,-30]);
      Modelica.Mechanics.Rotational.TorqueStep TorqueStep1(startTime=tStep, stepTorque=-
            T_Load) annotation (extent=[90,-50; 70,-30]);
    equation 
      connect(DCEE1.flange_a, LoadInertia.flange_a) annotation (points=[0,-40;
            40,-40], style(color=0, rgbcolor={0,0,0}));
      connect(Ramp1.y, SignalVoltage1.v) annotation (points=[-59,70; -10,70;
            -10,47], style(color=3, rgbcolor={0,0,255}));
      connect(SignalVoltage1.p,DCEE1. pin_ap) annotation (points=[0,40; 0,-20;
            -4,-20; -4,-30], style(color=3, rgbcolor={0,0,255}));
      connect(SignalVoltage1.n,Grounda. p) annotation (points=[-20,40; -60,40],
                     style(color=3, rgbcolor={0,0,255}));
      connect(DCEE1.pin_an, Grounda.p) annotation (points=[-16,-30; -16,-20;
            -20,-20; -20,40; -60,40],
                                style(color=3, rgbcolor={0,0,255}));
      connect(ConstantVoltage1.n, Grounde.p) annotation (points=[-40,-50; -60,
            -50], style(color=3, rgbcolor={0,0,255}));
      connect(DCEE1.pin_ep, ConstantVoltage1.p) annotation (points=[-20,-34;
            -30,-34; -30,-30; -40,-30], style(color=3, rgbcolor={0,0,255}));
      connect(DCEE1.pin_en, ConstantVoltage1.n) annotation (points=[-20,-46;
            -30,-46; -30,-50; -40,-50],
                                    style(color=3, rgbcolor={0,0,255}));
      connect(LoadInertia.flange_b, TorqueStep1.flange) 
        annotation (points=[60,-40; 70,-40], style(color=0, rgbcolor={0,0,0}));
    end DCEE_start;
    
    model DCSE_start 
      "Test example 10: DC with serial excitation starting with voltage ramp" 
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Voltage Va=100 "actual armature voltage";
      parameter Modelica.SIunits.Time tStart=0.2 "armature voltage ramp";
      parameter Modelica.SIunits.Time tRamp=0.8 "armature voltage ramp";
      parameter Modelica.SIunits.Torque T_Load=63.66 "nominal load torque";
      parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm 
        rpmLoad=1402.5 "nominal load speed";
      parameter Modelica.SIunits.Inertia J_Load=0.15 "load's moment of inertia";
      annotation (
        Diagram,
        experiment(StopTime=2, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>10th Test example: Series excited DC Machine started with an armature voltage ramp</b><br>
A voltage ramp is applied to the armature, causing the DC machine to start, 
and accelerating inertiasagainst load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>DCSE1.ia: armature current</li>
<li>DCSE1.rpm_mechanical: motor's speed</li>
<li>DCSE1.tau_electrical: motor's torque</li>
</ul>
Default machine parameters of model <i>DC_SeriesExcited</i> are used.
</p>
</HTML>"));
      Machines.BasicMachines.DCMachines.DC_SeriesExcited DCSE1 
        annotation (extent=[-20,-50; 0,-30]);
      Modelica.Blocks.Sources.Ramp Ramp1(duration=tRamp, height=Va,
        startTime=tStart) 
        annotation (extent=[-80,60; -60,80]);
      Modelica.Electrical.Analog.Sources.SignalVoltage SignalVoltage1 
        annotation (extent=[0,30; -20,50],   rotation=0);
      Modelica.Electrical.Analog.Basic.Ground Grounda 
        annotation (extent=[-80,30; -60,50],  rotation=-90);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-50; 60,-30]);
      Modelica.Mechanics.Rotational.QuadraticSpeedDependentTorque 
        QuadraticLoadTorque1(
        w_nominal=Modelica.SIunits.Conversions.from_rpm(rpmLoad),
        tau_nominal=-T_Load,
        TorqueDirection=false) 
        annotation (extent=[90,-50; 70,-30]);
    equation 
      connect(DCSE1.flange_a, LoadInertia.flange_a) annotation (points=[0,-40;
            40,-40], style(color=0, rgbcolor={0,0,0}));
      connect(Ramp1.y, SignalVoltage1.v) annotation (points=[-59,70; -10,70;
            -10,47], style(color=3, rgbcolor={0,0,255}));
      connect(SignalVoltage1.p,DCSE1. pin_ap) annotation (points=[0,40; 0,-20;
            -4,-20; -4,-30], style(color=3, rgbcolor={0,0,255}));
      connect(SignalVoltage1.n,Grounda. p) annotation (points=[-20,40; -60,40],
                     style(color=3, rgbcolor={0,0,255}));
      connect(LoadInertia.flange_b, QuadraticLoadTorque1.flange) 
        annotation (points=[60,-40; 70,-40], style(color=0, rgbcolor={0,0,0}));
      connect(DCSE1.pin_an, DCSE1.pin_ep) annotation (points=[-16,-30; -20,-30; -20,
            -34], style(color=3, rgbcolor={0,0,255}));
      connect(DCSE1.pin_en, SignalVoltage1.n) annotation (points=[-20,-46; -30,
            -46; -30,-20; -20,-20; -20,40], style(color=3, rgbcolor={0,0,255}));
    end DCSE_start;
    
    model TransformerTestbench "Transformer Testbench" 
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Resistance RL[3]=fill(1/3,3);
      annotation (Documentation(info="<HTML>
<p>
Transformer testbench:<br>
You may choose different connections as well as vary the load (even not symmetrical).<br>
<b>Please pay attention</b> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).<br>
In some cases it may be necessary to ground the transformer's starpoint 
even though the source's or load's starpoint are grounded; you may use a reasonable high earthing resistance.
</p>
</HTML>"),
        Diagram,
        experiment(StopTime=0.1),
        experimentSetupOutput);
      Modelica.Electrical.MultiPhase.Sources.SineVoltage source(freqHz=fill(50, 3),
          V=fill(sqrt(2/3)*100, 3)) 
        annotation (extent=[-80,-20; -100,0],rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Star starS 
        annotation (extent=[-100,-50; -80,-30],rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground groundS 
        annotation (extent=[-100,-80; -80,-60]);
      Sensors.ElectricalPowerSensor electricalPowerSensorS 
        annotation (extent=[-90,0; -70,20]);
      Sensors.CurrentRMSsensor currentRMSsensorS 
        annotation (extent=[-60,20; -40,0]);
      Sensors.VoltageRMSsensor voltageRMSsensorS 
        annotation (extent=[-30,-20; -50,0],   rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Delta deltaS 
        annotation (extent=[-50,-40; -30,-20], rotation=-90);
      Machines.BasicMachines.Transformers.Transformer transformer(
                                           redeclare model transformer = 
            Machines.BasicMachines.Transformers.Yd.Yd01) 
        annotation (extent=[-20,-10; 20,30]);
      Modelica.Electrical.Analog.Basic.Resistor earth(R=1e6) 
        annotation (extent=[10,-50; -10,-30], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground ground 
        annotation (extent=[-10,-80; 10,-60]);
      Sensors.VoltageRMSsensor voltageRMSsensorL 
        annotation (extent=[30,-20; 50,0],   rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Delta deltaL 
        annotation (extent=[50,-40; 30,-20], rotation=-90);
      Sensors.CurrentRMSsensor currentRMSsensorL 
        annotation (extent=[40,20; 60,0]);
      Sensors.ElectricalPowerSensor electricalPowerSensorL 
        annotation (extent=[70,0; 90,20]);
      Modelica.Electrical.MultiPhase.Basic.Resistor load(R=RL) 
        annotation (extent=[100,-20; 80,0],rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Star starL 
        annotation (extent=[100,-50; 80,-30],  rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground groundL 
        annotation (extent=[80,-80; 100,-60]);
    equation 
      connect(starS.pin_n, groundS.p) 
        annotation (points=[-90,-50; -90,-60], style(color=3, rgbcolor={0,0,255}));
      connect(source.plug_n, starS.plug_p) 
        annotation (points=[-90,-20; -90,-30], style(color=3, rgbcolor={0,0,255}));
      connect(starL.pin_n, groundL.p) 
        annotation (points=[90,-50; 90,-60], style(color=3, rgbcolor={0,0,255}));
      connect(load.plug_n, starL.plug_p) 
        annotation (points=[90,-20; 90,-30], style(color=3, rgbcolor={0,0,255}));
      connect(earth.n,ground. p) 
        annotation (points=[-6.12303e-016,-50; 0,-50; 0,-60],style(color=3, rgbcolor={0,0,255}));
      connect(electricalPowerSensorS.plug_nv, starS.plug_p) 
        annotation (points=[-80,0; -80,-30; -90,-30],   style(color=3, rgbcolor={0,0,255}));
      connect(source.plug_p, electricalPowerSensorS.plug_p) 
        annotation (points=[-90,0; -90,10],style(color=3, rgbcolor={0,0,255}));
      connect(electricalPowerSensorS.plug_ni, currentRMSsensorS.plug_p) 
        annotation (points=[-70,10; -60,10],
                                           style(color=3, rgbcolor={0,0,255}));
      connect(currentRMSsensorL.plug_n, electricalPowerSensorL.plug_p) 
        annotation (points=[60,10; 70,10],
                                         style(color=3, rgbcolor={0,0,255}));
      connect(electricalPowerSensorL.plug_ni, load.plug_p) 
        annotation (points=[90,10; 90,0],style(color=3, rgbcolor={0,0,255}));
      connect(currentRMSsensorS.plug_n, voltageRMSsensorS.plug_p) 
        annotation (points=[-40,10; -40,0],  style(color=3, rgbcolor={0,0,255}));
      connect(currentRMSsensorL.plug_p, voltageRMSsensorL.plug_p) 
        annotation (points=[40,10; 40,0],  style(color=3, rgbcolor={0,0,255}));
      connect(electricalPowerSensorL.plug_nv, starL.plug_p) 
        annotation (points=[80,0; 80,-30; 90,-30],   style(color=3, rgbcolor={0,0,255}));
      connect(voltageRMSsensorS.plug_n, deltaS.plug_p) 
        annotation (points=[-40,-20; -40,-20], style(color=3, rgbcolor={0,0,255}));
      connect(deltaL.plug_p, voltageRMSsensorL.plug_n) 
        annotation (points=[40,-20; 40,-20], style(color=3, rgbcolor={0,0,255}));
      connect(currentRMSsensorS.plug_n, transformer.plug1) 
        annotation (points=[-40,10; -20,10],
                                           style(color=3, rgbcolor={0,0,255}));
      connect(transformer.plug2, currentRMSsensorL.plug_p) 
        annotation (points=[20,10; 40,10],
                                         style(color=3, rgbcolor={0,0,255}));
      connect(deltaS.plug_n, voltageRMSsensorS.plug_p) 
        annotation (points=[-40,-40; -50,-40; -50,0; -40,0],     style(color=3, rgbcolor={0,0,255}));
      connect(deltaL.plug_n, voltageRMSsensorL.plug_p) 
        annotation (points=[40,-40; 50,-40; 50,0; 40,0],     style(color=3, rgbcolor={0,0,255}));
    end TransformerTestbench;
    
    model Rectifier6pulse "6-pulse rectifier with 1 transformer" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=100*sqrt(2/3) 
        "amplitude of star-voltage";
      parameter Modelica.SIunits.Frequency f=50 "frequency";
      parameter Modelica.SIunits.Resistance RL=0.4 "load resistance";
      parameter Modelica.SIunits.Capacitance C=0.005 "total DC-capacitance";
      parameter Modelica.SIunits.Voltage VC0=sqrt(3)*V;
      annotation (Documentation(info="<HTML>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a transformer a diode bridge rectifier with a DC burden.<br>
Using f=50 Hz, simulate for 0.1 seconds (5 periods) and compare voltages and currents of source and DC burden, 
neglecting initial transient.
</p>
</HTML>"), Diagram,
        experiment(StopTime=0.1),
        experimentSetupOutput);
      Modelica.Electrical.MultiPhase.Sources.SineVoltage source(
        m=m,
        V=fill(V, m),
        freqHz=fill(f, m)) annotation (extent=[-80,-20; -100,0], rotation=-90);
      Modelica.Electrical.MultiPhase.Basic.Star starAC(m=m) 
        annotation (extent=[-100,-50; -80,-30],   rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground groundAC 
        annotation (extent=[-100,-80; -80,-60]);
      Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor 
        annotation (extent=[-80,-10; -60,10]);
      Machines.BasicMachines.Transformers.Transformer transformer1(
                                            redeclare model transformer = 
            Machines.BasicMachines.Transformers.Dy.Dy01) 
        annotation (extent=[-50,30; -30,50]);
      Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode1(m=m) 
        annotation (extent=[-10,50; -30,70],rotation=90);
      Modelica.Electrical.MultiPhase.Basic.Star star1(m=m) 
        annotation (extent=[10,80; -10,60], rotation=180);
      Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode2(m=m) 
        annotation (extent=[-10,10; -30,30],  rotation=90);
      Modelica.Electrical.MultiPhase.Basic.Star star2(m=m) 
        annotation (extent=[-10,0; 10,20],    rotation=0);
      Modelica.Electrical.Analog.Basic.Resistor load(R=RL) 
        annotation (extent=[60,-10; 40,10],   rotation=-90);
      Modelica.Electrical.Analog.Basic.Capacitor cDC1(C=2*C, v(start=VC0/2)) 
        annotation (extent=[80,10; 60,30],   rotation=-90);
      Modelica.Electrical.Analog.Basic.Capacitor cDC2(C=2*C, v(start=VC0/2)) 
        annotation (extent=[80,-30; 60,-10],   rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground groundDC 
        annotation (extent=[80,-20; 100,0]);
    equation 
      connect(cDC1.n, cDC2.p) 
        annotation (points=[70,10; 70,-10],   style(color=3));
      connect(cDC1.n, groundDC.p) 
        annotation (points=[70,10; 70,0; 90,0],  style(color=3));
      connect(starAC.plug_p, source.plug_n) 
        annotation (points=[-90,-30; -90,-20], style(color=3));
      connect(diode1.plug_n, star1.plug_p) 
        annotation (points=[-20,70; -10,70], style(color=3));
      connect(diode2.plug_p, star2.plug_p) 
        annotation (points=[-20,10; -10,10],   style(color=3));
      connect(diode2.plug_n, diode1.plug_p) 
        annotation (points=[-20,30; -20,50], style(color=3, rgbcolor={0,0,255}));
      connect(starAC.pin_n, groundAC.p) 
        annotation (points=[-90,-50; -90,-60], style(color=3, rgbcolor={0,0,255}));
      connect(source.plug_p, currentSensor.plug_p) 
        annotation (points=[-90,0; -80,0], style(color=3, rgbcolor={0,0,255}));
      connect(load.p, cDC1.p) 
        annotation (points=[50,10; 50,30; 70,30], style(color=3, rgbcolor={0,0,255}));
      connect(load.n, cDC2.n) 
        annotation (points=[50,-10; 50,-30; 70,-30], style(color=3, rgbcolor={0,0,255}));
      connect(star1.pin_n, cDC1.p) 
        annotation (points=[10,70; 70,70; 70,30], style(color=3, rgbcolor={0,0,255}));
      connect(star2.pin_n, cDC2.n) 
        annotation (points=[10,10; 20,10; 20,-70; 70,-70; 70,-30], style(color=3, rgbcolor={0,0,255}));
      connect(currentSensor.plug_n, transformer1.plug1) 
        annotation (points=[-60,0; -60,40; -50,40], style(color=3, rgbcolor={0,0,255}));
      connect(diode1.plug_p, transformer1.plug2) 
        annotation (points=[-20,50; -20,40; -30,40], style(color=3, rgbcolor={0,0,255}));
    end Rectifier6pulse;
    
    model Rectifier12pulse "12-pulse rectifier with 2 transformers" 
      extends Modelica.Icons.Example;
      extends Machines.Examples.Rectifier6pulse(RL=0.2);
      annotation (Documentation(info="<HTML>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via two transformers (Dd0 and Dy1) two diode bridge rectifiers with a single DC burden.<br>
Using f=50 Hz, simulate for 0.1 seconds (5 periods) and compare voltages and currents of source and DC burden, 
neglecting initial transient.
</p>
</HTML>"), Diagram,
        experiment(StopTime=0.1),
        experimentSetupOutput);
      Machines.BasicMachines.Transformers.Transformer transformer2(
                                            redeclare model transformer = 
            Machines.BasicMachines.Transformers.Dd.Dd00) 
        annotation (extent=[-50,-50; -30,-30]);
      Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode3(m=m) 
        annotation (extent=[-10,-30; -30,-10], rotation=90);
      Modelica.Electrical.MultiPhase.Basic.Star star3(m=m) 
        annotation (extent=[-10,0; 10,-20],   rotation=0);
      Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode4(m=m) 
        annotation (extent=[-10,-70; -30,-50],rotation=90);
      Modelica.Electrical.MultiPhase.Basic.Star star4(m=m) 
        annotation (extent=[-10,-60; 10,-80], rotation=0);
    equation 
      connect(diode3.plug_n, star3.plug_p) 
        annotation (points=[-20,-10; -10,-10], style(color=3));
      connect(diode4.plug_p, star4.plug_p) 
        annotation (points=[-20,-70; -10,-70], style(color=3));
      connect(diode4.plug_n, diode3.plug_p) 
        annotation (points=[-20,-50; -20,-30], style(color=3, rgbcolor={0,0,255}));
      connect(diode3.plug_p, transformer2.plug2) 
        annotation (points=[-20,-30; -20,-40; -30,-40], style(color=3, rgbcolor={0,0,255}));
      connect(star4.pin_n, cDC2.n) 
        annotation (points=[10,-70; 70,-70; 70,-30], style(color=3, rgbcolor={0,0,255}));
      connect(transformer2.plug1, currentSensor.plug_n) 
        annotation (points=[-50,-40; -60,-40; -60,0], style(color=3, rgbcolor={0,0,255}));
      connect(star3.pin_n, cDC1.p) 
        annotation (points=[10,-10; 18,-10; 18,-8; 22,-8; 22,-10; 30,-10; 30,70; 70,70; 70,30],
          style(color=3, rgbcolor={0,0,255}));
    end Rectifier12pulse;
    
    model AIMC_Steinmetz 
      "AsynchronousInductionMachineSquirrelCage Steinmetz-connection" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "number of phases";
      parameter Modelica.SIunits.Voltage VNominal=100 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Time tStart1=0.1 "start time";
      parameter Modelica.SIunits.Capacitance Cr=0.0035 
        "motor's running capacitor";
      parameter Modelica.SIunits.Capacitance Cs=5*Cr 
        "motor's (additional) starting capacitor";
      parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm 
        rpmSwitch=
          1350 "speed for switching off the starting capacitor";
      parameter Modelica.SIunits.Torque T_Load=2/3*161.4 "nominal load torque";
      parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm 
        rpmLoad=
          1462.5 "nominal load speed";
      parameter Modelica.SIunits.Inertia J_Load=0.29 "load's moment of inertia";
      annotation (
        Diagram,
        experiment(StopTime=1.5, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>Asynchronous induction Machine with squirrel cage - Steinmetz-connection</b><br>
At start time tStart single phase voltage is supplied to the asynchronous induction machine with squirrel cage;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Default machine parameters of model <i>AIM_SquirrelCage</i> are used.
</p>
</HTML>"));
      Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage 
        AIMC1 
        annotation (extent=[-20,-50; 0,-30],     rotation=0);
      Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(
        freqHz=fNominal,
        V=sqrt(2)*VNominal) 
        annotation (extent=[-50,100; -70,80],  rotation=0);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Modelica.Blocks.Sources.BooleanStep BooleanStep(startTime=tStart1) 
        annotation (extent=[-50,60; -30,80]);
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch IdealCloser1 
        annotation (extent=[-10,80; -30,100],  rotation=-180);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-50; 60,-30]);
      Modelica.Mechanics.Rotational.QuadraticSpeedDependentTorque 
        QuadraticLoadTorque1(
                    w_nominal=Modelica.SIunits.Conversions.from_rpm(rpmLoad),
          tau_nominal=-T_Load,
        TorqueDirection=false) 
        annotation (extent=[90,-50; 70,-30]);
      Utilities.TerminalBox TerminalBox1(StarDelta="D") 
        annotation (extent=[-20,-30; 0,-10]);
      Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p3(m=m, k=3) 
        annotation (extent=[-40,-20; -20,0], rotation=90);
      Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p2(m=m, k=2) 
        annotation (extent=[-20,-20; 0,0], rotation=90);
      Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p1(m=m, k=1) 
        annotation (extent=[0,-20; 20,0], rotation=90);
      Modelica.Electrical.Analog.Basic.Capacitor Crun(C=Cr) 
        annotation (extent=[0,10; 20,30], rotation=-90);
      Modelica.Electrical.Analog.Basic.Capacitor Cstart(C=Cs) 
        annotation (extent=[20,10; 40,30],rotation=-90);
      Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealOpener1 
        annotation (extent=[20,40; 40,60], rotation=-90);
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor 
        annotation (extent=[20,-40; 40,-20], rotation=90);
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
            Modelica.SIunits.Conversions.from_rpm(rpmSwitch)) 
        annotation (extent=[40,10; 60,30], rotation=90);
    equation 
      connect(AIMC1.flange_a, LoadInertia.flange_a)  annotation (points=[0,-40;
            40,-40], style(color=0, rgbcolor={0,0,0}));
      connect(TerminalBox1.negativeMachinePlug, AIMC1.plug_sn) annotation (
          points=[-16,-30; -16,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(TerminalBox1.positiveMachinePlug, AIMC1.plug_sp) annotation (
          points=[-4,-30; -4,-30], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1));
      connect(Ground1.p, SineVoltage1.n) 
        annotation (points=[-80,90; -70,90], style(color=3, rgbcolor={0,0,255}));
      connect(SineVoltage1.p, IdealCloser1.p) 
        annotation (points=[-50,90; -30,90], style(color=3, rgbcolor={0,0,255}));
      connect(BooleanStep.y, IdealCloser1.control) annotation (points=[-29,70; -20,
            70; -20,83], style(color=5, rgbcolor={255,0,255}));
      connect(plugToPin_p3.plug_p, plugToPin_p2.plug_p) 
        annotation (points=[-30,-20; -10,-20], style(color=3, rgbcolor={0,0,255}));
      connect(plugToPin_p2.plug_p,plugToPin_p1. plug_p) 
        annotation (points=[-10,-20; 10,-20], style(color=3, rgbcolor={0,0,255}));
      connect(plugToPin_p3.pin_p, SineVoltage1.n) annotation (points=[-30,0; -70,0;
            -70,90],         style(color=3, rgbcolor={0,0,255}));
      connect(IdealCloser1.n, plugToPin_p2.pin_p) 
        annotation (points=[-10,90; -10,0], style(color=3, rgbcolor={0,0,255}));
      connect(Crun.n, plugToPin_p1.pin_p) 
        annotation (points=[10,10; 10,0], style(color=3, rgbcolor={0,0,255}));
      connect(LoadInertia.flange_b, QuadraticLoadTorque1.flange) 
        annotation (points=[60,-40; 70,-40], style(color=0, rgbcolor={0,0,0}));
      connect(Crun.p, IdealCloser1.n)      annotation (points=[10,30; 10,90; -10,90],
          style(color=3, rgbcolor={0,0,255}));
      connect(plugToPin_p1.pin_p, Cstart.n)     annotation (points=[10,0; 30,0; 30,
            10], style(color=3, rgbcolor={0,0,255}));
      connect(idealOpener1.n, Cstart.p) 
        annotation (points=[30,40; 30,30], style(color=3, rgbcolor={0,0,255}));
      connect(idealOpener1.p, IdealCloser1.n) annotation (points=[30,60; 30,90; -10,
            90], style(color=3, rgbcolor={0,0,255}));
      connect(AIMC1.flange_a, speedSensor.flange_a) 
        annotation (points=[0,-40; 30,-40], style(color=0, rgbcolor={0,0,0}));
      connect(speedSensor.w, greaterThreshold.u) annotation (points=[30,-19; 30,-10;
            50,-10; 50,8], style(color=74, rgbcolor={0,0,127}));
      connect(greaterThreshold.y, idealOpener1.control) annotation (points=[50,31;
            50,50; 37,50], style(color=5, rgbcolor={255,0,255}));
      connect(plugToPin_p2.plug_p, TerminalBox1.plugToGrid) 
        annotation (points=[-10,-20; -10,-28], style(color=3, rgbcolor={0,0,255}));
    end AIMC_Steinmetz;
    
    package Utilities "Library with auxiliary models for testing" 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<HTML>
<p>
This package contains components utility components for testing examples.
</p>

</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
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
  </ul>
</HTML>"));
      
      block VfController "Voltage-Frequency-Controller" 
        extends Modelica.Blocks.Interfaces.SIMO(final nout=m,
          u(redeclare type SignalType = Modelica.SIunits.Frequency),
          y(redeclare type SignalType = Modelica.SIunits.Voltage));
        constant Real pi=Modelica.Constants.pi;
        parameter Integer m=3 "number of phases";
        parameter Modelica.SIunits.Voltage VNominal 
          "nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal "nominal frequency";
        parameter Modelica.SIunits.Angle BasePhase=0 "common phase shift";
        output Modelica.SIunits.Angle x(start=0, fixed=true) "Integrator state";
        output Modelica.SIunits.Voltage amplitude;
        annotation (
          Diagram,
          Icon(
            Line(points=[-100, -100; 0, 60; 80, 60], style(color=3)),
            Line(points=[-70, 0; -60.2, 29.9; -53.8, 46.5; -48.2, 58.1; -43.3,
                  65.2; -38.3, 69.2; -33.4, 69.8; -28.5, 67; -23.6, 61; -18.6, 52;
                   -13, 38.6; -5.98, 18.6; 8.79, -26.9; 15.1, -44; 20.8, -56.2;
                  25.7, -64; 30.6, -68.6; 35.5, -70; 40.5, -67.9; 45.4, -62.5;
                  50.3, -54.1; 55.9, -41.3; 63, -21.7; 70, 0], style(color=8)),
            Line(points=[-40, 0; -30.2, 29.9; -23.8, 46.5; -18.2, 58.1; -13.3,
                  65.2; -8.3, 69.2; -3.4, 69.8; 1.5, 67; 6.4, 61; 11.4, 52; 17,
                  38.6; 24.02, 18.6; 38.79, -26.9; 45.1, -44; 50.8, -56.2; 55.7,
                  -64; 60.6, -68.6; 65.5, -70; 70.5, -67.9; 75.4, -62.5; 80.3, -54.1;
                   85.9, -41.3; 93, -21.7; 100, 0], style(color=8)),
            Line(points=[-100, 0; -90.2, 29.9; -83.8, 46.5; -78.2, 58.1; -73.3,
                  65.2; -68.3, 69.2; -63.4, 69.8; -58.5, 67; -53.6, 61; -48.6, 52;
                   -43, 38.6; -35.98, 18.6; -21.21, -26.9; -14.9, -44; -9.2, -56.2;
                   -4.3, -64; 0.6, -68.6; 5.5, -70; 10.5, -67.9; 15.4, -62.5;
                  20.3, -54.1; 25.9, -41.3; 33, -21.7; 40, 0], style(color=8))),
          Documentation(info="<HTML>
<p>
Simple Voltage-Frequency-Controller.<br>
Amplitude of voltage is linear dependent (VNominal/fNominal) on Frequency (input signal \"u\"), but limited by VNominal (nominal RMS voltage per phase).<br>
m sine-waves with amplitudes as described above are provided as output signal \"y\".<br>
The sine-waves are intended to feed a m-phase SignalVoltage.<br>
Phase shifts between sine-waves may be choosen by the user; default values are <i>(k-1)/m*pi for k in 1:m</i>.
</p>
</HTML>"));
      equation 
      //amplitude = sqrt(2)*VNominal*min(abs(u)/fNominal, 1);
        amplitude = sqrt(2)*VNominal*(if abs(u)<fNominal then abs(u)/fNominal else 1);
        der(x) = 2*pi*u;
        y = {amplitude*sin(x + BasePhase - (k - 1)*2/m*pi) for k in 1:m};
      end VfController;
      
      model SwitchYD "Y-D-switch" 
        constant Integer m=3 "number of phases";
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_P(final m=m) 
          annotation (extent=[90, 90; 110, 110]);
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug pug_PS(final m=m) 
          annotation (extent=[90, -110; 110, -90]);
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_NS(final m=m) 
          annotation (extent=[-110, -110; -90, -90]);
        annotation (Diagram, Icon(Line(points=[-80, 52; -40, 0; -2, 52; -40, 0; -40,
                   -52], style(
                color=3,
                rgbcolor={0,0,255},
                thickness=2,
                fillColor=7,
                rgbfillColor={255,255,255},
                fillPattern=1)), Line(points=[0, 40; 0, -40; 80, 0; 0, 40], style(
                color=3,
                rgbcolor={0,0,255},
                thickness=2,
                fillColor=7,
                rgbfillColor={255,255,255},
                fillPattern=1))),
          Documentation(info="<HTML>
<p>
Simple Star-Delta-switch.<br>
If <i>control</i> is false, plug_PS and plug_NS are star connected and plug_PS connected to plug_P.<br>
If <i>control</i> is true, plug_PS and plug_NS are delta connected and they are connected to plug_P.
</p>
</HTML>"));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) 
          annotation (extent=[60, -50; 80, -30]);
        Modelica.Electrical.MultiPhase.Basic.Delta delta(final m=m) 
          annotation (extent=[80, -80; 60, -60]);
        Modelica.Electrical.MultiPhase.Ideal.IdealCommutingSwitch 
          idealCommutingSwitch(                                                        final m=m) 
          annotation (extent=[-10, -70; 10, -50]);
        Modelica.Blocks.Interfaces.BooleanInput control[m] 
          annotation (extent=[-120,-10; -100,10],  rotation=0);
      equation 
        connect(delta.plug_p, plug_P) annotation (points=[80, -70; 100, -70; 100,
               100], style(color=3, rgbcolor={0,0,255}));
        connect(delta.plug_p, pug_PS) annotation (points=[80, -70; 100, -70; 100,
               -100], style(color=3, rgbcolor={0,0,255}));
        connect(idealCommutingSwitch.plug_n2, delta.plug_n) annotation (points=[
              10, -60; 10, -70; 60, -70], style(color=3, rgbcolor={0,0,255}));
        connect(idealCommutingSwitch.plug_n1, star.plug_p) annotation (points=[10,
               -55; 10, -40; 60, -40], style(color=3, rgbcolor={0,0,255}));
        connect(idealCommutingSwitch.plug_p, plug_NS) annotation (points=[-10, -60;
               -100, -60; -100, -100], style(color=3, rgbcolor={0,0,255}));
        connect(control, idealCommutingSwitch.control) annotation (points=[-110,0; 0,
              0; 0,-52],          style(
            color=5,
            rgbcolor={255,0,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
      end SwitchYD;
      
      model TerminalBox "terminal box Y/D-connection" 
        constant Integer m=3 "number of phases";
        parameter String StarDelta="Y" 
          annotation(choices(choice="Y" "Star connection",choice="D" 
              "Delta connection"));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug 
          positiveMachinePlug(
            final m=m) 
          annotation (extent=[50,-110; 70,-90]);
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug 
          negativeMachinePlug(
            final m=m) 
          annotation (extent=[-70,-110; -50,-90]);
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) if (StarDelta<>"D") 
          annotation (extent=[-80,-70; -60,-90], rotation=-180);
        Modelica.Electrical.MultiPhase.Basic.Delta delta(final m=m) if (StarDelta=="D") 
          annotation (extent=[-20,-70; -40,-50]);
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plugToGrid(final m=m) 
          annotation (extent=[-10,-70; 10,-90]);
        annotation (Diagram,
          Icon(Polygon(points=[-80,-80; -80,-84; -80,-120; -40,-140; 40,-140; 80,-110;
                  80,-84; 76,-80; -80,-80],
                                         style(
                color=10,
                rgbcolor={95,95,95},
                fillColor=10,
                rgbfillColor={135,135,135})), Text(
              extent=[-40,-90; 40,-130],
              string="%StarDelta",
              style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=10,
                rgbfillColor={135,135,135},
                fillPattern=1))),
          Documentation(info="<html>
<p>
TerminalBox: at the bottom connected to both machine plugs, connect at the top to the grid as usual,<br>
choosing Y-connection (StarDelta=Y) or D-connection (StarDelta=D).
</p>
</html>"));
        Modelica.Electrical.Analog.Interfaces.NegativePin starpoint if (StarDelta<>"D") 
          annotation (extent=[-100,-90; -80,-70]);
      equation 
        connect(negativeMachinePlug, star.plug_p) 
          annotation (points=[-60,-100; -60,-80],
            style(color=3, rgbcolor={0,0,255}));
        connect(negativeMachinePlug, delta.plug_n) 
                                              annotation (points=[-60,-100; -40,-100;
              -40,-60],
            style(color=3, rgbcolor={0,0,255}));
        connect(delta.plug_p, positiveMachinePlug) 
                                              annotation (points=[-20,-60; 60,-60; 60,
              -100],
            style(color=3, rgbcolor={0,0,255}));
        connect(positiveMachinePlug, plugToGrid) 
                                              annotation (points=[60,-100; 0,-100; 0,
              -80],
            style(color=3, rgbcolor={0,0,255}));
        connect(star.pin_n, starpoint) annotation (points=[-80,-80; -90,-80],
                        style(color=3, rgbcolor={0,0,255}));
      end TerminalBox;
      
    end Utilities;
  end Examples;
  
  package BasicMachines "Basic machine models" 
    extends Modelica.Icons.Library2;
    annotation (Documentation(info="<HTML>
<p>
This package contains components for modeling electrical machines, specially threephase induction machines, based on space phasor theory:
<ul>
<li>package AsynchronousInductionMachines: models of three phase asynchronous induction machines</li>
<li>package SynchronousInductionMachines: models of three phase synchronous induction machines</li>
<li>package DCMachines: models of DC machines with different excitation</li>
<li>package Transformers: Threephase transformers (see detailled documentation in subpackage)</li>
<li>package Components: components for modeling machines and transformers</li>
</ul>
The induction machine models use package SpacePhasors.
</p>

</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
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
  </ul>
<HTML>"), Icon(
        Rectangle(extent=[-60,60; 60,-60],    style(
            color=3,
            rgbcolor={0,0,255},
            gradient=2,
            fillColor=69,
            rgbfillColor={0,128,255})),
        Rectangle(extent=[-60,60; -80,-60],    style(
            color=10,
            gradient=2,
            fillColor=10)),
        Rectangle(extent=[60,10; 80,-10],  style(
            color=10,
            rgbcolor={95,95,95},
            gradient=2,
            fillColor=10,
            rgbfillColor={95,95,95})),
        Rectangle(extent=[-60,70; 20,50], style(
            color=10,
            rgbcolor={95,95,95},
            fillColor=10,
            rgbfillColor={95,95,95})),
    Polygon(points=[-70,-90; -60,-90; -30,-20; 20,-20; 50,-90; 60,-90; 60,-100;
              -70,-100; -70,-90],               style(
        color=0,
        gradient=0,
        fillColor=0,
        fillPattern=1))));
    
    package AsynchronousInductionMachines 
      "Models of asynchronous induction machines" 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<HTML>
<p>
This package contains models of asynchronous induction machines, based on space phasor theory:
<ul>
<li>AIM_SquirrelCage: asynchronous induction machine with squirrel cage</li>
<li>AIM_SlipRing: asynchronous induction machine with wound rotor</li>
</ul>
These models use package SpacePhasors.
</p>
</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
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
  </ul>
</HTML>"));
      
      model AIM_SquirrelCage 
        "Asynchronous induction machine with squirrel cage rotor" 
        extends Machines.BasicMachines.Components.BasicAIM(airGapS(final Lm=Lm));
        parameter Modelica.SIunits.Inductance Lm=3*sqrt(1 - 0.0667)/(2*pi*fNominal) 
          "|Nominal resistances and inductances|main field inductance";
        parameter Modelica.SIunits.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*fNominal) 
          "|Nominal resistances and inductances|rotor stray inductance (equivalent three phase winding)";
        parameter Modelica.SIunits.Resistance Rr=0.04 
          "|Nominal resistances and inductances|warm rotor resistance (equivalent three phase winding)";
        Machines.BasicMachines.Components.SquirrelCage squirrelCageR(final 
            Lrsigma =                                                              Lrsigma, final Rr=Rr) 
          annotation (extent=[-10, -40; 10, -20], rotation=-90);
        annotation (defaultComponentName="AIMC",
          Documentation(info="<HTML>
<p>
<b>Model of a three phase asynchronous induction machine with squirrel cage.</b><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed ccordinate system. Both together connected via a stator-fixed <i>AirGap</i> model. Only losses in stator and rotor resistance are taken into account.
</p>
<p>
<b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td>161.4</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1440.45</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>24.346</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>92.7</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.875</td><td> </td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase in warm condition</td>
</tr>
<tr>
<td>rotor resistance</td>
<td>0.04</td><td>Ohm in warm condition</td>
</tr>
<tr>
<td>stator reactance Xs</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>rotor reactance Xr</td>
<td>3</td><td>Ohm</td>
</tr>
<tr>
<td>total stray coefficient sigma</td>
<td>0.0667</td><td> </td>
</tr>
<tr>
<td>These values give the following inductances, <br>assuming equal stator and rotor stray inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xs * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>rotor stray inductance</td>
<td>Xr * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance per phase</td>
<td>sqrt(Xs*Xr * (1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</p>
</HTML>"),       Diagram);
      equation 
        connect(airGapS.spacePhasor_r, squirrelCageR.spacePhasor_r) 
          annotation (points=[10,-10; 10,-20], style(color=3, rgbcolor={0,0,255}));
      end AIM_SquirrelCage;
      
      model AIM_SlipRing "Asynchronous induction machine with slipring rotor" 
        extends Machines.BasicMachines.Components.BasicAIM(airGapS(final Lm=Lm));
        parameter Modelica.SIunits.Inductance Lm=3*sqrt(1 - 0.0667)/(2*pi*fNominal) 
          "|Nominal resistances and inductances|main field inductance";
        parameter Modelica.SIunits.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*
            fNominal) 
          "|Nominal resistances and inductances|rotor stray inductance per phase";
        parameter Modelica.SIunits.Resistance Rr=0.04 
          "|Nominal resistances and inductances|warm rotor resistance per phase";
        parameter Boolean useTurnsRatio=true 
          "use TurnsRatio or calculate from locked-rotor voltage?";
        parameter Real TurnsRatio(final min=Modelica.Constants.small)=1 
          "(ws*xis) / (wr*xir)" 
          annotation(Dialog(enable=useTurnsRatio));
        parameter Modelica.SIunits.Voltage VsNom=100 
          "Nominal stator voltage per phase" 
          annotation(Dialog(enable=not useTurnsRatio));
        parameter Modelica.SIunits.Voltage Vr_LR=100*
          (2*pi*fNominal*Lm)/sqrt(Rs^2+(2*pi*fNominal*(Lm+Lssigma))^2) 
          "Locked-rotor voltage per phase" 
          annotation(Dialog(enable=not useTurnsRatio));
        output Modelica.SIunits.Current i_0_r(stateSelect=StateSelect.prefer) = spacePhasorR.zero.i 
          "rotor zero-sequence current";
        output Modelica.SIunits.Voltage vr[m] = plug_rp.pin.v - plug_rn.pin.v 
          "rotor instantaneous voltages";
        output Modelica.SIunits.Current ir[m] = plug_rp.pin.i 
          "rotor instantaneous currents";
      protected 
        final parameter Real internalTurnsRatio=if useTurnsRatio then TurnsRatio else 
          VsNom/Vr_LR*(2*pi*fNominal*Lm)/sqrt(Rs^2+(2*pi*fNominal*(Lm+Lssigma))^2);
      public 
        Machines.SpacePhasors.Components.SpacePhasor spacePhasorR 
          annotation (extent=[10, -40; -10, -20], rotation=90);
        Modelica.Electrical.MultiPhase.Ideal.IdealTransformer IdealTransformer1
          (                                                                     final m=m, final n=
              fill(1/internalTurnsRatio, m)) 
          annotation (extent=[10,-70; -10,-50], rotation=90);
        Modelica.Electrical.MultiPhase.Basic.Star Star1(final m=m) 
          annotation (extent=[-20,-60; -40,-40]);
        Modelica.Electrical.Analog.Basic.Ground Ground1 
          annotation (extent=[-60,-70; -40,-50], rotation=0);
        Modelica.Electrical.MultiPhase.Basic.Inductor lrsigma(final m=m, final L=fill(Lrsigma, m)) 
          annotation (extent=[30,-90; 10,-70]);
        Modelica.Electrical.MultiPhase.Basic.Resistor rr(final m=m, final R=fill(Rr, m)) 
          annotation (extent=[60,-90; 40,-70]);
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_rp(final m=m) 
          annotation (extent=[-110,70; -90,50]);
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_rn(final m=m) 
          annotation (extent=[-110,-50; -90,-70]);
        annotation (defaultComponentName="AIMS",
          Documentation(info="<HTML>
<p>
<b>Model of a three phase asynchronous induction machine with slipring rotor.</b><br>
Resistance and stray inductance of stator and rotor are modeled directly in stator respectively rotor phases, then using space phasor transformation and a stator-fixed <i>AirGap</i> model. Only losses in stator and rotor resistance are taken into account.
</p>
<p>
<b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td>161.4</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1440.45</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>24.346</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>92.7</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.875</td><td> </td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase in warm condition</td>
</tr>
<tr>
<td>rotor resistance</td>
<td>0.04</td><td>Ohm per phase in warm condition</td>
</tr>
<tr>
<td>stator reactance Xs</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>rotor reactance Xr</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>total stray coefficient sigma</td>
<td>0.0667</td><td> </td>
</tr>
<tr>
<td>TurnsRatio</td>
<td>1</td><td>effective ratio of stator and rotor current (ws*xis) / (wr*xir)</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xs * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>rotor stray inductance</td>
<td>Xr * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance per phase</td>
<td>sqrt(Xs*Xr * (1-sigma))/(2*pi*f)</td><td> </td>
</tr>
</table>
</p>
<p>
Parameter TurnsRatio could be obtained from the following relationship 
at standstill with open rotor circuit at nominal voltage and nominal frequency, <br>
using the locked-rotor voltage VR, no-load stator current I0 and powerfactor PF0:<br>
TurnsRatio * <u>V</u><sub>R</sub> = <u>V</u><sub>s</sub> - (R<sub>s</sub> + j X<sub>s,sigma</sub>) <u>I</u><sub>0</sub>
</p>
</HTML>"),   Diagram,
          Icon(Line(points=[-100,50; -100,20; -60,20], style(color=3, rgbcolor={0,
                    0,255})), Line(points=[-100,-50; -100,-20; -60,-20], style(
                  color=3, rgbcolor={0,0,255}))));
      equation 
        connect(rr.plug_n, lrsigma.plug_p) 
          annotation (points=[40,-80; 30,-80],   style(color=3));
        connect(spacePhasorR.plug_n, IdealTransformer1.plug_n2) annotation (
            points=[-10,-40; -10,-50], style(color=3, rgbcolor={0,0,255}));
        connect(spacePhasorR.plug_p, IdealTransformer1.plug_p2) annotation (
            points=[10,-40; 10,-50], style(color=3, rgbcolor={0,0,255}));
        connect(IdealTransformer1.plug_p1, lrsigma.plug_n)    annotation (points=[10,
              -70; 10,-80],             style(color=3, rgbcolor={0,0,255}));
        connect(Star1.pin_n, Ground1.p) annotation (points=[-40,-50; -50,-50],
            style(color=3, rgbcolor={0,0,255}));
        connect(Star1.plug_p, IdealTransformer1.plug_n2) annotation (points=[-20,
              -50; -10,-50], style(color=3, rgbcolor={0,0,255}));
        connect(IdealTransformer1.plug_n1, plug_rn) annotation (points=[-10,-70;
              -10,-80; -60,-80; -60,-60; -100,-60], style(color=3, rgbcolor={0,0,
                255}));
        connect(rr.plug_p, plug_rp)        annotation (points=[60,-80; 60,-90;
              -80,-90; -80,60; -100,60],  style(color=3, rgbcolor={0,0,255}));
        connect(spacePhasorR.ground, spacePhasorR.zero) annotation (points=[-10,-20;
              -10,-14; -6.12303e-016,-14; -6.12303e-016,-20],      style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=3,
            rgbfillColor={0,0,255},
            fillPattern=1));
        connect(airGapS.spacePhasor_r, spacePhasorR.spacePhasor) 
          annotation (points=[10,-10; 10,-20], style(color=3, rgbcolor={0,0,255}));
      end AIM_SlipRing;
      
    end AsynchronousInductionMachines;
    
    package SynchronousInductionMachines 
      "Models of synchronous induction machines" 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<HTML>
<p>
This package contains models of synchronous induction machines, based on space phasor theory:
<ul>
<li>SM_PermanentMagnetDamperCage: synchronous induction machine with permanent magnet excitation, with damper cage</li>
<li>SM_ElectricalExcitedDamperCage: synchronous induction machine with electrical excitation 
    and damper cage</li>
<li>SM_ReluctanceRotorDamperCage: induction machine with reluctance rotor and damper cage<br>
i.e. a squirrel cage rotor with magnetic poles due to different airgap width</li>
</ul>
These models use package SpacePhasors.
</p>
<p>
<b>Please keep in mind:</b><br>
<ul>
<li>We keep the same reference system as for motors, i.e.:<br>
    Positive RotorDisplacementAngle means acting as motor,<br>
    with positive electric power consumption and positive mechanical power output.
<li>ElectricalAngle = p * MechanicalAngle</li>
<li>real axis = d-axis<br>
    imaginary= q-axis</li>
<li>Voltage induced by the magnet wheel (d-axis) is located in the q-axis.</li>
</ul>
</p>

</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
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
  </ul>
</HTML>"));
      
      model SM_PermanentMagnetDamperCage 
        "Permanent magnet synchronous induction machine" 
        extends Machines.BasicMachines.Components.BasicSM(
            Lssigma=0.1/(2*pi*fNominal),
            airGapR(
              final Lmd=Lmd,
              final Lmq=Lmq));
        parameter Modelica.SIunits.Voltage V0=112.3 
          "|Excitation|no-load RMS voltage per phase @ fNominal";
        parameter Modelica.SIunits.Inductance Lmd=0.3/(2*pi*fNominal) 
          "|Nominal resistances and inductances|main field inductance in d-axis";
        parameter Modelica.SIunits.Inductance Lmq=0.3/(2*pi*fNominal) 
          "|Nominal resistances and inductances|main field inductance in q-axis";
        parameter Boolean DamperCage = true "damper cage is present?" 
          annotation(Dialog(group = "DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigma=0.05/(2*pi*fNominal) 
          "damper stray inductance in d-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigma 
          "damper stray inductance in q-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        parameter Modelica.SIunits.Resistance Rr=0.04 
          "warm damper resistance in d-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rr 
          "warm damper resistance in q-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        output Modelica.SIunits.Current idq_dr[2](each stateSelect=StateSelect.prefer)=
          damperCage.spacePhasor_r.i_ if DamperCage 
          "damper space phasor current / rotor fixed frame";
      protected 
        final parameter Modelica.SIunits.Current Ie=sqrt(2)*V0/(Lmd*2*pi*fNominal) 
          "equivalent excitation current";
      public 
        Machines.BasicMachines.Components.PermanentMagnet permanentMagnet(Ie=Ie) 
          annotation (extent=[-10, -70; 10, -50], rotation=-90);
        Components.DamperCage damperCage(
          final Lrsigma=Lrsigma,
          final Lrsigmaq=Lrsigmaq,
          final Rr=Rr,
          final Rrq=Rrq) if DamperCage 
          annotation (extent=[-10,-40; 10,-20], rotation=-90);
        annotation (defaultComponentName="SMPM",
          Diagram,
          Icon(
            Rectangle(extent=[-130,10; -100,-10],
                style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=2,
                rgbfillColor={0,255,0})),
            Rectangle(extent=[-100,10; -70,-10],
                style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=1,
                rgbfillColor={255,0,0})),
             Ellipse(extent=[-134,34; -66,-34], style(color=3, rgbcolor={0,0,255}))),
          Documentation(info="<HTML>
<p>
<b>Model of a three phase permanent magnet synchronous induction machine.</b><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation and a rotor-fixed <i>AirGap</i> model. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed ccordinate system. Permanent magnet excitation is modelled by a constant equivalent excitation current feeding the d-axis. Only losses in stator and damper resistance are taken into account.
</p>
<p>
Whether a damper cage is present or not, can be selected with Boolean parameter DamperCage (default = true).
</p>
<p>
<b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>no-load voltage per phase</td>
<td>112.3</td><td>V RMS @ nominal speed</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td>181.4</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>28.5</td><td>kW</td>
</tr>
<tr>
<td>nominal rotor angle</td>
<td>20.75</td><td>degree</td>
</tr>
<tr>
<td>efficiency</td>
<td>95.0</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.98</td><td> </td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase in warm condition</td>
</tr>
<tr>
<td>stator reactance Xd</td>
<td>0.4</td><td>Ohm per phase in d-axis</td>
</tr>
<tr>
<td>stator reactance Xq</td>
<td>0.4</td><td>Ohm per phase in q-axis</td>
</tr>
<tr>
<td>stator stray reactance Xss</td>
<td>0.1</td><td>Ohm per phase</td>
</tr>
<tr>
<td>damper resistance in d-axis</td>
<td>0.04</td><td>Ohm in warm condition</td>
</tr>
<tr>
<td>damper resistance in q-axis</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>damper stray reactance in d-axis XDds</td>
<td>0.05</td><td>Ohm</td>
</tr>
<tr>
<td>damper stray reactance in q-axis XDqs</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>main field inductance in d-axis</td>
<td>(Xd - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance in q-axis</td>
<td>(Xq - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in d-axis</td>
<td>XDds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in q-axis</td>
<td>XDqs/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</p>
</HTML>"));
      equation 
        connect(airGapR.spacePhasor_r, damperCage.spacePhasor_r) annotation (
            points=[10,-10; 10,-20; 10,-20], style(color=3, rgbcolor={0,0,255}));
        connect(airGapR.spacePhasor_r, permanentMagnet.spacePhasor_r) 
          annotation (points=[10,-10; 20,-10; 20,-50; 10,-50], style(color=3,
              rgbcolor={0,0,255}));
      end SM_PermanentMagnetDamperCage;
      
      model SM_ElectricalExcitedDamperCage 
        "Electrical excited synchronous induction machine with damper cage" 
        extends Machines.BasicMachines.Components.BasicSM(
          Lssigma=0.1/(2*pi*fNominal),
            airGapR(
              final Lmd=Lmd,
              final Lmq=Lmq));
        parameter Modelica.SIunits.Inductance Lmd=1.5/(2*pi*fNominal) 
          "|Nominal resistances and inductances|main field inductance in d-axis";
        parameter Modelica.SIunits.Inductance Lmq=1.5/(2*pi*fNominal) 
          "|Nominal resistances and inductances|main field inductance in q-axis";
        parameter Boolean DamperCage = true "damper cage is present?" 
          annotation(Dialog(group = "DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigma=0.05/(2*pi*fNominal) 
          "damper stray inductance in d-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigma 
          "damper stray inductance in q-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        parameter Modelica.SIunits.Resistance Rr=0.04 
          "warm damper resistance in d-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rr 
          "warm damper resistance in q-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        parameter Modelica.SIunits.Voltage VNominal=100 
          "|Excitation|nominal stator RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 
          "|Excitation|nominal frequency";
        parameter Modelica.SIunits.Current Ie0=10 
          "|Excitation|no-load excitation current @ nominal voltage and frequency";
        parameter Modelica.SIunits.Resistance Re=2.5 
          "|Excitation|warm excitation resistance";
        parameter Real sigmae(min=0, max=1)=0.025 
          "|Excitation|stray fraction of total excitation inductance";
        output Modelica.SIunits.Current idq_dr[2](each stateSelect=StateSelect.prefer)=
          damperCage.spacePhasor_r.i_ if DamperCage 
          "damper space phasor current / rotor fixed frame";
        output Modelica.SIunits.Voltage ve = pin_ep.v-pin_en.v 
          "excitation voltage";
        output Modelica.SIunits.Current ie = pin_ep.i "excitation current";
      protected 
        final parameter Real TurnsRatio = sqrt(2)*VNominal/(2*pi*fNominal*Lmd*Ie0) 
          "stator current / excitation current";
        final parameter Modelica.SIunits.Inductance Lesigma = Lmd*TurnsRatio^2 * sigmae/(1-sigmae);
      public 
        Components.DamperCage damperCage(
          final Lrsigma=Lrsigma,
          final Lrsigmaq=Lrsigmaq,
          final Rr=Rr,
          final Rrq=Rrq) if DamperCage 
          annotation (extent=[-10,-40; 10,-20], rotation=-90);
        Components.ElectricalExcitation electricalExcitation(final TurnsRatio=
              TurnsRatio) 
          annotation (extent=[10,-50; -10,-70], rotation=90);
        Modelica.Electrical.Analog.Basic.Resistor re(final R=Re) 
          annotation (extent=[40,-70; 60,-90],   rotation=180);
        Modelica.Electrical.Analog.Basic.Inductor lesigma(final L=Lesigma) 
          annotation (extent=[30,-90; 10,-70]);
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
          annotation (extent=[-110,70; -90,50]);
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
          annotation (extent=[-90,-50; -110,-70]);
        annotation (defaultComponentName="SMEE",
          Diagram,
          Icon(
             Ellipse(extent=[-134,34; -66,-34], style(color=3, rgbcolor={0,0,255})),
            Line(points=[-100,50; -100,20; -130,20; -130,-4], style(color=3,
                  rgbcolor={0,0,255})),
            Line(points=[-130,-4; -129,1; -125,5; -120,6; -115,5; -111,1; -110,-4],
                style(color=3, rgbcolor={0,0,255})),
            Line(points=[-110,-4; -109,1; -105,5; -100,6; -95,5; -91,1; -90,-4],
                style(color=3, rgbcolor={0,0,255})),
            Line(points=[-90,-4; -89,1; -85,5; -80,6; -75,5; -71,1; -70,-4],style(
                  color=3, rgbcolor={0,0,255})),
            Line(points=[-100,-50; -100,-20; -70,-20; -70,-2], style(color=3,
                  rgbcolor={0,0,255}))),
          Documentation(info="<HTML>
<p>
<b>Model of a three phase electrical excited synchronous induction machine with damper cage.</b><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation and a rotor-fixed <i>AirGap</i> model. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed ccordinate system. Electrical excitation is modelled by converting excitation current and voltage to d-axis space phasors. Only losses in stator, damper and excitation resistance are taken into account.
</p>
<p>
Whether a damper cage is present or not, can be selected with Boolean parameter DamperCage (default = true).
</p>
<p>
<b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>no-load excitation current<br>
    @ nominal voltage and frequency</td>
<td>10</td><td>A DC</td>
</tr>
<tr>
<td>warm excitation resistance</td>
<td>2.5</td><td>Ohm</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal apparent power</td>
<td>-30000</td><td>VA</td>
</tr>
<tr>
<td>power factor</td>
<td>-1.0</td><td>ind./cap.</td>
</tr>
<tr>
<td>nominal excitation current</td>
<td>19</td><td>A</td>
</tr>
<tr>
<td>efficiency w/o excitation</td>
<td>97.1</td><td>%</td>
</tr>
<tr>
<td>nominal torque</td>
<td>-196.7</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>nominal rotor angle</td>
<td>-57.23</td><td>degree</td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase in warm condition</td>
</tr>
<tr>
<td>stator reactance Xd</td>
<td>1.6</td><td>Ohm per phase in d-axis</td>
</tr>
<tr>
<td>giving Kc</td>
<td>0.625</td><td> </td>
</tr>
<tr>
<td>stator reactance Xq</td>
<td>1.6</td><td>Ohm per phase in q-axis</td>
</tr>
<tr>
<td>stator stray reactance Xss</td>
<td>0.1</td><td>Ohm per phase</td>
</tr>
<tr>
<td>damper resistance in d-axis</td>
<td>0.04</td><td>Ohm in warm condition</td>
</tr>
<tr>
<td>damper resistance in q-axis</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>damper stray reactance in d-axis XDds</td>
<td>0.1</td><td>Ohm</td>
</tr>
<tr>
<td>damper stray reactance in q-axis XDqs</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>excitation stray inductance</td>
<td>2.5</td><td>% of total excitation inductance</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>main field inductance in d-axis</td>
<td>(Xd - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance in q-axis</td>
<td>(Xq - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in d-axis</td>
<td>XDds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in q-axis</td>
<td>XDqs/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</p>
</HTML>"));
      equation 
        connect(electricalExcitation.pin_en, pin_en) annotation (points=[-10,-70; -70,
              -70; -70,-60; -100,-60], style(color=3, rgbcolor={0,0,255}));
        connect(pin_ep, re.p) annotation (points=[-100,60; -80,60; -80,-90; 60,-90;
              60,-80], style(color=3, rgbcolor={0,0,255}));
        connect(lesigma.p, re.n) 
          annotation (points=[30,-80; 40,-80], style(color=3, rgbcolor={0,0,255}));
        connect(lesigma.n, electricalExcitation.pin_ep) 
          annotation (points=[10,-80; 10,-70], style(color=3, rgbcolor={0,0,255}));
        connect(airGapR.spacePhasor_r, damperCage.spacePhasor_r) 
          annotation (points=[10,-10; 10,-20], style(color=3, rgbcolor={0,0,255}));
        connect(airGapR.spacePhasor_r, electricalExcitation.spacePhasor_r) 
          annotation (points=[10,-10; 20,-10; 20,-50; 10,-50],
                                               style(color=3, rgbcolor={0,0,255}));
      end SM_ElectricalExcitedDamperCage;
      
      model SM_ReluctanceRotorDamperCage 
        "Synchronous induction machine with reluctance rotor and damper cage" 
        extends Machines.BasicMachines.Components.BasicSM(
          Lssigma=0.1/(2*pi*fNominal),
            airGapR(
              final Lmd=Lmd,
              final Lmq=Lmq));
        parameter Modelica.SIunits.Inductance Lmd=2.9/(2*pi*fNominal) 
          "|Nominal resistances and inductances|main field inductance in d-axis";
        parameter Modelica.SIunits.Inductance Lmq=0.9/(2*pi*fNominal) 
          "|Nominal resistances and inductances|main field inductance in q-axis";
        parameter Boolean DamperCage = true "damper cage is present?" 
          annotation(Dialog(group = "DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigma=0.05/(2*pi*fNominal) 
          "damper stray inductance in d-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigma 
          "damper stray inductance in q-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        parameter Modelica.SIunits.Resistance Rr=0.04 
          "warm damper resistance in d-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rr 
          "warm damper resistance in q-axis" 
          annotation(Dialog(group = "DamperCage", enable = DamperCage));
        Components.DamperCage damperCage(
          final Lrsigma=Lrsigma,
          final Lrsigmaq=Lrsigmaq,
          final Rr=Rr,
          final Rrq=Rrq) if DamperCage 
          annotation (extent=[-10,-40; 10,-20], rotation=-90);
        annotation (defaultComponentName="SMR",
          Diagram,
          Icon(
            Rectangle(extent=[-130,10; -100,-10], style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=7,
                rgbfillColor={255,255,255})),
            Rectangle(extent=[-100,10; -70,-10], style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=7,
                rgbfillColor={255,255,255})),
             Ellipse(extent=[-134,34; -66,-34], style(color=3, rgbcolor={0,0,255}))),
          Documentation(info="<HTML>
<p>
<b>Model of a three phase synchronous induction machine with reluctance rotor and damper cage.</b><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed ccordinate system. Both together connected via a rotor-fixed <i>AirGap</i> model. Only losses in stator and rotor resistance are taken into account.
</p>
<p>
Whether a damper cage is present or not, can be selected with Boolean parameter DamperCage (default = true).
</p>
<p>
<b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>50</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td> 46</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td> 7.23</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>96.98</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.497</td><td> </td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase in warm condition</td>
</tr>
<tr>
<td>rotor resistance in d-axis</td>
<td>0.04</td><td>Ohm in warm condition</td>
</tr>
<tr>
<td>rotor resistance in q-axis</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>stator reactance Xsd in d-axis</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>stator reactance Xsq in q-axis</td>
<td>1</td><td>Ohm</td>
</tr>
<tr>
<td>stator stray reactance Xss</td>
<td>0.1</td><td>Ohm per phase</td>
</tr>
<tr>
<td>rotor stray reactance in d-axis Xrds</td>
<td>0.1</td><td>Ohm per phase</td>
</tr>
<tr>
<td>rotor stray reactance in q-axis Xrqs</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>rotor stray inductance in d-axis</td>
<td>Xrds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>rotor stray inductance in q-axis</td>
<td>Xrqs/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance per phase in d-axis</td>
<td>(Xsd-Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance per phase in q-axis</td>
<td>(Xsq-Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</p>
</HTML>"));
      equation 
        connect(airGapR.spacePhasor_r, damperCage.spacePhasor_r) 
          annotation (points=[10,-10; 10,-20], style(color=3, rgbcolor={0,0,255}));
      end SM_ReluctanceRotorDamperCage;
    end SynchronousInductionMachines;
    
    package DCMachines "Models of DC machines" 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<HTML>
<p>
This package contains models of DC machines:
<ul>
<li>DC_PermanentMagnet: DC machine with permanent magnet excitation</li>
<li>DC_ElectricalExcited: DC machine with electrical shunt or separate excitation</li>
<li>DC_SeriesExcited: DC machine with series excitation</li>
</ul>
</p>

</HTML>
", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
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
  </ul>
</HTML>"));
      
      model DC_PermanentMagnet "Permanent magnet DC machine" 
        extends Machines.BasicMachines.Components.BasicDCMachine(
        final TurnsRatio=(VaNominal-Ra*IaNominal)/(Modelica.SIunits.Conversions.from_rpm(rpmNominal)*Le*IeNominal),
            airGapDC(final Le=Le));
      protected 
        final parameter Modelica.SIunits.Inductance Le=1 
          "|Excitation|total field excitation inductance";
        constant Modelica.SIunits.Current IeNominal=1 
          "equivalent excitation current";
      public 
        Modelica.Electrical.Analog.Basic.Ground eGround 
          annotation (extent=[-20,-70; 0,-50]);
        Modelica.Electrical.Analog.Sources.ConstantCurrent ie(I=IeNominal) 
          annotation (extent=[0,-50; 20,-30], rotation=90);
        annotation (defaultComponentName="DCPM",
          Diagram,
          Icon(
            Rectangle(extent=[-130,10; -100,-10],
                style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=2,
                rgbfillColor={0,255,0})),
            Rectangle(extent=[-100,10; -70,-10],
                style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=1,
                rgbfillColor={255,0,0}))),
          Documentation(info="<HTML>
<p>
<b>Model of a DC Machine with Permanent magnet.</b><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <i>AirGapDC</i> model. Permanent magnet excitation is modelled by a constant equivalent excitation current feeding AirGapDC. Only losses in armature resistance are taken into account. No saturation is modelled.
</p>
<p>
<b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.15</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal armature voltage</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>nominal armature current</td>
<td>100</td><td>A</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1425</td><td>rpm</td>
</tr>
<tr>
<td>nominal torque</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>9.5</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>95.0</td><td>%</td>
</tr>
<tr>
<td>armature resistance</td>
<td>0.05</td><td>Ohm in warm condition</td>
</tr>
<tr>
<td>armature inductance</td>
<td>0.0015</td><td>H</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and compensation windig, if present.
</p>
</HTML>"));
      equation 
        assert(VaNominal > Ra*IaNominal, "VaNominal has to be > (Ra+Re)*IaNominal");
        connect(eGround.p, ie.p) 
          annotation (points=[-10,-50; 10,-50], style(color=3, rgbcolor={0,0,255}));
        connect(airGapDC.pin_ep, ie.n) annotation (points=[10,-10; 10,-30; 10,-30], style(
              color=3, rgbcolor={0,0,255}));
        connect(airGapDC.pin_en, eGround.p) annotation (points=[-10,-10; -10,
              -50], style(color=3, rgbcolor={0,0,255}));
      end DC_PermanentMagnet;
      
      model DC_ElectricalExcited 
        "Electrical shunt/separate excited linear DC machine" 
        extends Machines.BasicMachines.Components.BasicDCMachine(
          final TurnsRatio=(VaNominal-Ra*IaNominal)/(Modelica.SIunits.Conversions.from_rpm(rpmNominal)*Le*IeNominal),
            airGapDC(final Le=Le));
        parameter Modelica.SIunits.Current IeNominal=1 
          "|Excitation|nominal excitation current";
        parameter Modelica.SIunits.Resistance Re=100 
          "|Excitation|warm field excitation resistance";
        parameter Modelica.SIunits.Inductance Le=1 
          "|Excitation|total field excitation inductance";
        output Modelica.SIunits.Voltage ve = pin_ep.v-pin_en.v 
          "Field excitation voltage";
        output Modelica.SIunits.Current ie = pin_ep.i 
          "Field excitation current";
        Modelica.Electrical.Analog.Basic.Resistor re(final R=Re) 
          annotation (extent=[-40,-30; -60,-50], rotation=180);
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
          annotation (extent=[-110,70; -90,50]);
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
          annotation (extent=[-90,-50; -110,-70]);
        annotation (defaultComponentName="DCEE",
          Diagram,
          Icon(
            Line(points=[-130,-4; -129,1; -125,5; -120,6; -115,5; -111,1; -110,
                  -4],
                style(color=3, rgbcolor={0,0,255})),
            Line(points=[-110,-4; -109,1; -105,5; -100,6; -95,5; -91,1; -90,-4],
                style(color=3, rgbcolor={0,0,255})),
            Line(points=[-90,-4; -89,1; -85,5; -80,6; -75,5; -71,1; -70,-4],style(
                  color=3, rgbcolor={0,0,255})),
            Line(points=[-100,-50; -100,-20; -70,-20; -70,-2], style(color=3,
                  rgbcolor={0,0,255})),
            Line(points=[-100,50; -100,20; -130,20; -130,-4], style(color=3,
                  rgbcolor={0,0,255}))),
          Documentation(info="<HTML>
<p>
<b>Model of a DC Machine with Electrical shunt or separate excitation.</b><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <i>AirGapDC</i> model.<br>
Only losses in armature and excitation resistance are taken into account. No saturation is modelled.<br>
Shunt or separate excitation is defined by the user's external circuit.
</p>
<p>
<b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.15</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal armature voltage</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>nominal armature current</td>
<td>100</td><td>A</td>
</tr>
<tr>
<td>nominal torque</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1425</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>9.5</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>95.0</td><td>% only armature</td>
</tr>
<tr>
<td>efficiency</td>
<td>94.06</td><td>% including excitation</td>
</tr>
<tr>
<td>armature resistance</td>
<td>0.05</td><td>Ohm in warm condition</td>
</tr>
<tr>
<td>aramture inductance</td>
<td>0.0015</td><td>H</td>
</tr>
<tr>
<td>nominal excitation voltage</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>nominal excitation current</td>
<td>1</td><td>A</td>
</tr>
<tr>
<td>excitation resistance</td>
<td>100</td><td>Ohm in warm condition</td>
</tr>
<tr>
<td>excitation inductance</td>
<td>1</td><td>H</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and 
compensation windig, if present.<br>
Armature current does not cover excitation current of a shunt excitation; in this case total current drawn from the grid = armature current + excitation current.
</p>
</HTML>"));
      equation 
        assert(VaNominal > Ra*IaNominal, "VaNominal has to be > (Ra+Re)*IaNominal");
        connect(re.p, pin_ep) annotation (points=[-60,-40; -80,-40; -80,60; -100,60],
            style(color=3, rgbcolor={0,0,255}));
        connect(pin_en, airGapDC.pin_en) annotation (points=[-100,-60; -10,-60;
              -10,-10], style(color=3, rgbcolor={0,0,255}));
        connect(re.n, airGapDC.pin_ep) annotation (points=[-40,-40; 10,-40; 10,
              -10], style(color=3, rgbcolor={0,0,255}));
      end DC_ElectricalExcited;
      
      model DC_SeriesExcited "Series excited linear DC machine" 
        extends Machines.BasicMachines.Components.BasicDCMachine(
          rpmNominal =  1402.5,
          final TurnsRatio=(VaNominal-(Ra+Re)*IaNominal)/(Modelica.SIunits.Conversions.from_rpm(rpmNominal)*Le*IaNominal),
          airGapDC(final Le=Le));
        parameter Modelica.SIunits.Resistance Re=0.01 
          "|Excitation|warm field excitation resistance";
        parameter Modelica.SIunits.Inductance Le=0.0005 
          "|Excitation|total field excitation inductance";
        output Modelica.SIunits.Voltage ve = pin_ep.v-pin_en.v 
          "Field excitation voltage";
        output Modelica.SIunits.Current ie = pin_ep.i 
          "Field excitation current";
        Modelica.Electrical.Analog.Basic.Resistor re(final R=Re) 
          annotation (extent=[-40,-30; -60,-50], rotation=180);
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
          annotation (extent=[-110,70; -90,50]);
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
          annotation (extent=[-90,-50; -110,-70]);
        annotation (defaultComponentName="DCSE",
          Diagram,
          Icon(
            Line(points=[-100,-10; -105,-9; -109,-5; -110,0; -109,5; -105,9; -100,10],
                style(color=3, rgbcolor={0,0,255})),
            Line(points=[-100,-30; -105,-29; -109,-25; -110,-20; -109,-15; -105, -11; -100,-10],
                style(color=3, rgbcolor={0,0,255})),
            Line(points=[-100,10; -105,11; -109,15; -110,20; -109,25; -105,29; -100,30],
                style(color=3, rgbcolor={0,0,255})),
            Line(points=[-100,50; -100,30], style(color=3, rgbcolor={0,0,255})),
            Line(points=[-100,-30; -100,-50], style(color=3, rgbcolor={0,0,255}))),
          Documentation(info="<HTML>
<p>
<b>Model of a DC Machine with Series excitation.</b><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <i>AirGapDC</i> model.<br>
Only losses in armature and excitation resistance are taken into account. No saturation is modelled.<br>
Series excitation has to be connected by the user's external circuit.
</p>
<p>
<b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.15</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal armature voltage</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>nominal armature current</td>
<td>100</td><td>A</td>
</tr>
<tr>
<td>nominal torque</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1410</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>9.4</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>94.0</td><td>% only armature</td>
</tr>
<tr>
<td>armature resistance</td>
<td>0.05</td><td>Ohm in warm condition</td>
</tr>
<tr>
<td>aramture inductance</td>
<td>0.0015</td><td>H</td>
</tr>
<tr>
<td>excitation resistance</td>
<td>0.01</td><td>Ohm in warm condition</td>
</tr>
<tr>
<td>excitation inductance</td>
<td>0.0005</td><td>H</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and 
compensation windig, if present.<br>
Parameter nominal armature voltage includes voltage drop of series excitation;<br>
but for output the voltage is splitted into:<br>
va = armature voltage without voltage drop of series excitation<br>
ve = voltage drop of series excitation
</p>
</HTML>"));
      equation 
        assert(VaNominal > (Ra+Re)*IaNominal, "VaNominal has to be > (Ra+Re)*IaNominal");
        connect(re.p, pin_ep) annotation (points=[-60,-40; -80,-40; -80,60;
              -100,60],
            style(color=3, rgbcolor={0,0,255}));
        connect(pin_en, airGapDC.pin_en) annotation (points=[-100,-60; -10,-60;
              -10,-10], style(color=3, rgbcolor={0,0,255}));
        connect(re.n, airGapDC.pin_ep) annotation (points=[-40,-40; 10,-40; 10,
              -10], style(color=3, rgbcolor={0,0,255}));
      end DC_SeriesExcited;
    end DCMachines;
    
    package Transformers "Library for technical 3phase transformers" 
      extends Modelica.Icons.Library2;
      annotation (
      version="1.0.0", versionDate="2006-11-20",
      preferedView="info", Documentation(info="<HTML>
<p>
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
</p>
<p>
Transformers are modeled by an ideal transformer, adding primary and secondary winding resistances and stray inductances.<br>
All transformers extend from the base model <i>PartialTransformer</i>, adding the primary and secondary connection.<br>
<b>VectorGroup</b> defines the phase shift between primary and secondary voltages, expressed by a number phase shift/30 degree
(i.e. the hour on a clock face). Therefore each transformer is identified by two characters and a two-digit number, 
e.g. Yd11 ... primary connection Y (star), secondfary connection d (delta), vector group 11 (phase shift 330 degree)<br>
With the \"supermodel\" <i>Tranformer</i>&nbsp; the user may choose primary and secondary connection as well as the vector group.<br>
It calculates winding ratio as well as primary and secondary winding resistances and stray inductances, 
distributing them equally to primary and secondary winding, from the following parameters:<br>
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
</p>
<p>
<b>Please pay attention</b> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).<br>
<b>In some cases (Yy or Yz) it may be necessary to ground one of the transformer's starpoints 
even though the source's and/or load's starpoint are grounded; you may use a reasonable high earthing resistance.</b>
</p>
<p>
<b>Limitations and assumptions:</b><br>
<ul>
<li>number of phases is limited to 3, therefore definition as a constant m=3</li>
<li>symmetry of the 3 phases resp. limbs</li>
<li>temperature dependency is neglected, i.e. resistances are constant</li>
<li>saturation is neglected, i.e. inductances are constant</li>
<li>magnetizing current is neglected</li>
<li>magnetizing losses are neglected</li>
<li>additional (stray) losses are neglected</li>
</ul>
</p>
<p>
<b>Further development:</b>
<ul>
<li>modeling magnetizing current, including saturation</li>
<li>temperature dependency of winding resistances</li>
</ul>
</p>
<p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
</p>
<p>
Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>",     revisions="<HTML>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer<br>
       first stable release</li>
  </ul>
</HTML>"),     Icon(
          Ellipse(extent=[-100,30; 20,-90],style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[-40,30; 80,-90], style(color=3, rgbcolor={0,0,255}))));
      
      model Transformer "transformer: choose connection/vector group" 
        parameter Modelica.SIunits.Frequency f=50 "nominal frequency";
        parameter Modelica.SIunits.Voltage V1=100 
          "primary nominal line-to-line voltage (RMS)";
        parameter Modelica.SIunits.Voltage V2=100 
          "secondary open circuit line-to-line voltage (RMS) @ primary nominal voltage";
        parameter Modelica.SIunits.ApparentPower SNominal=30E3 
          "nominal apparent power";
        parameter Real v_sc(final min=0, final max=1)=0.05 
          "impedance voltage drop pu";
        parameter Modelica.SIunits.Power P_sc=300 
          "short-circuit (copper) losses";
        extends transformer(final n=V1/V2,
          final R1=R1ph, final L1sigma=L1ph,
          final R2=R2ph, final L2sigma=L2ph);
        replaceable model transformer = 
            Machines.BasicMachines.Transformers.Yy.Yy00 extends 
          Machines.BasicMachines.Components.BasicTransformer 
          annotation (choicesFromPackage=true, choicesAllMatching=true);
      protected 
        parameter Modelica.SIunits.Voltage V1ph = V1/(if C1=="D" then 1 else sqrt(3));
        parameter Modelica.SIunits.Current I1ph = SNominal/(3*V1ph);
        parameter Modelica.SIunits.Voltage V2ph = V2/(if C2=="d" then 1 else sqrt(3));
        parameter Modelica.SIunits.Current I2ph = SNominal/(3*V2ph);
        parameter Modelica.SIunits.Impedance Z1ph = 0.5*v_sc*V1ph/I1ph;
        parameter Modelica.SIunits.Resistance R1ph= 0.5*P_sc/(3*I1ph^2);
        parameter Modelica.SIunits.Inductance L1ph= sqrt(Z1ph^2-R1ph^2)/(2*Modelica.Constants.pi*f);
        parameter Modelica.SIunits.Impedance Z2ph = 0.5*v_sc*V2ph/I2ph;
        parameter Modelica.SIunits.Resistance R2ph= 0.5*P_sc/(3*I2ph^2);
        parameter Modelica.SIunits.Inductance L2ph= sqrt(Z2ph^2-R2ph^2)/(2*Modelica.Constants.pi*f);
        annotation (Diagram);
      end Transformer;
      
      package Yy "transformers: primary Y / secondary y" 
        extends Modelica.Icons.Library2;
        annotation (Documentation(info="<HTML>
<p>
This package contains transformers primary Y connected / secondary y connected in all possbile vector groups.
</p>
</HTML>",     revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(
            Text(
              extent=[0,40; 0,-100],
              style(color=3, rgbcolor={0,0,255}),
              string="Yy")));
        
        model Yy00 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yy00");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100],style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_p) 
            annotation (points=[10,10; 10,20; 50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Yy00;
        
        model Yy02 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yy02");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[50,-30; 30,-10]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot2.plug_p) 
            annotation (points=[50,0; 50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, star2.plug_p) 
            annotation (points=[10,10; 20,10; 20,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Yy02;
        
        model Yy04 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yy04");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[30,10; 50,30]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(Rot2.plug_n, l2sigma.plug_p) 
            annotation (points=[50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot2.plug_p) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Yy04;
        
        model Yy06 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yy06");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n3) 
            annotation (points=[50,0; 50,-20; 10,-20; 10,-10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, star2.plug_p) 
            annotation (points=[10,10; 20,10; 20,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Yy06;
        
        model Yy08 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yy08");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[50,10; 30,30]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(Rot2.plug_p, l2sigma.plug_p) 
            annotation (points=[50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Yy08;
        
        model Yy10 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yy10");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[30,-30; 50,-10]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot2.plug_n) 
            annotation (points=[50,0; 50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Rot2.plug_p) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, star2.plug_p) 
            annotation (points=[10,10; 20,10; 20,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Yy10;
      end Yy;
      
      package Yd "transformers: primary Y / secondary d" 
        extends Modelica.Icons.Library2;
        annotation (Documentation(info="<HTML>
<p>
This package contains transformers primary Y connected / secondary d connected in all possbile vector groups.
</p>
</HTML>",     revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(
            Text(
              extent=[0,40; 0,-100],
              style(color=3, rgbcolor={0,0,255}),
              string="Yd")));
        
        model Yd01 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yd01");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[50,-30; 30,-10]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_p, r2.plug_n) 
            annotation (points=[50,-20; 90,-20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Delta2.plug_n) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_p) 
            annotation (points=[10,10; 10,20; 50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
        end Yd01;
        
        model Yd03 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yd03");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[30,10; 50,30]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[50,-30; 30,-10]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_n, r2.plug_n) 
            annotation (points=[50,20; 90,20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot2.plug_p) 
            annotation (points=[50,0; 50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Delta2.plug_p) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
        end Yd03;
        
        model Yd05 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yd05");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[30,10; 50,30]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_n, r2.plug_n) 
            annotation (points=[50,20; 90,20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, l2sigma.plug_p) 
            annotation (points=[10,-10; 10,-20; 50,-20; 50,0], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Delta2.plug_p) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
        end Yd05;
        
        model Yd07 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yd07");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[50,10; 30,30]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_p, r2.plug_n) 
            annotation (points=[50,20; 90,20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Delta2.plug_n) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n3) 
            annotation (points=[50,0; 50,-20; 10,-20; 10,-10], style(color=3, rgbcolor={0,0,255}));
        end Yd07;
        
        model Yd09 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yd09");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[30,-30; 50,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[50,10; 30,30]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(Rot2.plug_p, l2sigma.plug_p) 
            annotation (points=[50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_n, r2.plug_n) 
            annotation (points=[50,-20; 90,-20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3,rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
        end Yd09;
        
        model Yd11 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yd11");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[30,-30; 50,-10]);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_n, r2.plug_n) 
            annotation (points=[50,-20; 90,-20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_p) 
            annotation (points=[10,10; 10,20; 50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
        end Yd11;
      end Yd;
      
      package Yz "transformers: primary Y / secondary zig-zag" 
        extends Modelica.Icons.Library2;
        annotation (Documentation(info="<HTML>
<p>
This package contains transformers primary Y connected / secondary zig-zag connected in all possbile vector groups.
</p>
</HTML>",     revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(
            Text(
              extent=[0,40; 0,-100],
              style(color=3, rgbcolor={0,0,255}),
              string="Yz")));
        
        model Yz01 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yz01");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,-10; 20,10], rotation=90);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m) 
            annotation (extent=[30,30; 50,10], rotation=180);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_p) annotation (points=[50,0; 50,20], style(color=3, rgbcolor={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2) 
            annotation (points=[30,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor= {0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Yz01;
        
        model Yz03 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yz03");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,10; 20,-10], rotation=90);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m) 
            annotation (extent=[30,30; 50,10], rotation=180);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_p) 
            annotation (points=[50,0; 50,20], style(color=3, rgbcolor={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2) 
            annotation (points=[30,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Yz03;
        
        model Yz05 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yz05");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,-10; 20,10], rotation=90);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3,rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n2) 
            annotation (points=[50,0; 50,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
        end Yz05;
        
        model Yz07 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yz07");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,10; 20,-10], rotation=90);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n2) 
            annotation (points=[50,0; 50,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Yz07;
        
        model Yz09 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yz09");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,-10; 20,10], rotation=90);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m) 
            annotation (extent=[50,30; 30,10], rotation=180);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_n) 
            annotation (points=[50,0; 50,20; 50,20], style(color=3, rgbcolor={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2) 
            annotation (points=[30,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
        end Yz09;
        
        model Yz11 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Yz11");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m) 
            annotation (extent=[-20,-90; 0,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1 
            annotation (extent=[-60,-110; -40,-90]);
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,10; 20,-10], rotation=90);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m) 
            annotation (extent=[50,30; 30,10], rotation=180);
          annotation (Diagram);
        equation 
          connect(star1.pin_n, starpoint1) 
            annotation (points=[-10,-90; -10,-100; -50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, star1.plug_p) 
            annotation (points=[-10,-5; -10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3,rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_n) 
            annotation (points=[50,0; 50,20], style(color=3, rgbcolor={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2) 
            annotation (points=[30,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Yz11;
      end Yz;
      
      package Dy "transformers: primary D / secondary y" 
        extends Modelica.Icons.Library2;
        annotation (Documentation(info="<HTML>
<p>
This package contains transformers primary D connected / secondary y connected in all possbile vector groups.
</p>
</HTML>",     revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(
            Text(
              extent=[0,40; 0,-100],
              style(color=3, rgbcolor={0,0,255}),
              string="Dy")));
        
        model Dy01 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dy01");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[50,-30; 30,-10]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot2.plug_p) 
            annotation (points=[50,0; 50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p) 
            annotation (points=[-50,-20; -90,-20;-90,0], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, star2.plug_p) 
            annotation (points=[10,10; 20,10; 20,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Dy01;
        
        model Dy03 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dy03");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[30,10; 50,30]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(Rot2.plug_n, l2sigma.plug_p) 
            annotation (points=[50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p) 
            annotation (points=[-50,-20; -90,-20; -90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot2.plug_p) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Dy03;
        
        model Dy05 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dy05");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p) 
            annotation (points=[-50,-20; -90,-20; -90,0], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3,rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n3) 
            annotation (points=[50,0; 50,-20; 10,-20; 10,-10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, star2.plug_p) 
            annotation (points=[10,10; 20,10; 20,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Dy05;
        
        model Dy07 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dy07");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[50,10; 30,30]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(Rot2.plug_p, l2sigma.plug_p) 
            annotation (points=[50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
        end Dy07;
        
        model Dy09 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dy09");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[30,-30; 50,-10]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100],style(color=3, rgbcolor={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot2.plug_n) 
            annotation (points=[50,0; 50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Rot2.plug_p) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, star2.plug_p) 
            annotation (points=[10,10; 20,10; 20,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Dy09;
        
        model Dy11 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dy11");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n, starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_p) 
            annotation (points=[10,10; 10,20; 50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
        end Dy11;
      end Dy;
      
      package Dd "transformers: primary D / secondary d" 
        extends Modelica.Icons.Library2;
        annotation (Documentation(info="<HTML>
<p>
This package contains transformers primary D connected / secondary d connected in all possbile vector groups.
</p>
</HTML>",     revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(
            Text(
              extent=[0,40; 0,-100],
              style(color=3, rgbcolor={0,0,255}),
              string="Dd")));
        
        model Dd00 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dd00");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[50,-30; 30,-10]);
          annotation (Diagram);
        equation 
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_p, r2.plug_n) 
            annotation (points=[50,-20; 90,-20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_p) 
            annotation (points=[10,10; 10,20; 50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Delta2.plug_n) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0, 0,255}));
        end Dd00;
        
        model Dd02 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dd02");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[30,10; 50,30]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[50,-30; 30,-10]);
          annotation (Diagram);
        equation 
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_n, r2.plug_n) 
            annotation (points=[50,20; 90,20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot2.plug_p) 
            annotation (points=[50,0; 50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Delta2.plug_p) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
        end Dd02;
        
        model Dd04 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dd04");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[30,10; 50,30]);
          annotation (Diagram);
        equation 
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_n, r2.plug_n) 
            annotation (points=[50,20; 90,20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,1; 10,1; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Delta2.plug_p) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, l2sigma.plug_p) 
            annotation (points=[10,-10; 10,-20; 50,-20; 50,0], style(color=3, rgbcolor={0,0,255}));
        end Dd04;
        
        model Dd06 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dd06");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[50,10; 30,30]);
          annotation (Diagram);
        equation 
          connect(Delta2.plug_p, r2.plug_n) 
            annotation (points=[50,20; 90,20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p) 
            annotation (points=[-50,-20; -90,-20;-90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_n, core.plug_p2) 
            annotation (points=[30,20; 10,20; 10,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, l2sigma.plug_p) 
            annotation (points=[10,-10; 10,-20; 50,-20; 50,0], style(color=3, rgbcolor={0,0,255}));
        end Dd06;
        
        model Dd08 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dd08");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m) 
            annotation (extent=[50,10; 30,30]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[30,-30; 50,-10]);
          annotation (Diagram);
        equation 
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_n, r2.plug_n) 
            annotation (points=[50,-20; 90,-20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(Rot2.plug_p, l2sigma.plug_p) 
            annotation (points=[50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n1, Delta1.plug_n) 
            annotation (points=[-10,-5; -10,-20; -30,-20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n) 
            annotation (points=[10,10; 10,20; 30,20], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
        end Dd08;
        
        model Dd10 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dd10");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m) 
            annotation (extent=[30,-30; 50,-10]);
          annotation (Diagram);
        equation 
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(Delta2.plug_n, r2.plug_n) 
            annotation (points=[50,-20; 90,-20; 90,0], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n2, core.plug_p3) 
            annotation (points=[10,4; 10,-4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_p) 
            annotation (points=[10,10; 10,20; 50,20; 50,0], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p) 
            annotation (points=[10,-10; 10,-20; 30,-20], style(color=3, rgbcolor={0,0,255}));
        end Dd10;
      end Dd;
      
      package Dz "transformers: primary D / secondary ziag-zag" 
        extends Modelica.Icons.Library2;
        annotation (Documentation(info="<HTML>
<p>
This package contains transformers primary D connected / secondary d connected in all possbile vector groups.
</p>
</HTML>",     revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</HTML>"),      Icon(
            Text(
              extent=[0,40; 0,-100],
              style(color=3, rgbcolor={0,0,255}),
              string="Dz")));
        
        model Dz00 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dz00");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,-10; 20,10], rotation=90);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m) 
            annotation (extent=[30,30; 50,10], rotation=180);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_p) 
            annotation (points=[50,0; 50,20], style(color=3, rgbcolor={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2) 
            annotation (points=[30,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Dz00;
        
        model Dz02 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dz02");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,10; 20,-10], rotation=90);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m) 
            annotation (extent=[30,30; 50,10], rotation=180);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_p) 
            annotation (points=[50,0; 50,20], style(color=3, rgbcolor={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2) 
            annotation (points=[30,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Dz02;
        
        model Dz04 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dz04");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,-10; 20,10], rotation=90);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n2) 
            annotation (points=[50,0; 50,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
        end Dz04;
        
        model Dz06 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dz06");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,10; 20,-10], rotation=90);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, core.plug_n2) 
            annotation (points=[50,0; 50,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
        end Dz06;
        
        model Dz08 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dz08");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,-10; 20,10], rotation=90);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m) 
            annotation (extent=[50,30; 30,10], rotation=180);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5; -10,5], style(color=3, rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_n) 
            annotation (points=[50,0; 50,20; 50,20], style(color=3, rgbcolor={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2) 
            annotation (points=[30,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
        end Dz08;
        
        model Dz10 
          annotation (defaultComponentName="transformer");
          extends Machines.BasicMachines.Components.BasicTransformer(final 
              VectorGroup =                                                            "Dz10");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m) 
            annotation (extent=[0,-90; 20,-70], rotation=-90);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2 
            annotation (extent=[40,-110; 60,-90]);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m) 
            annotation (extent=[40,10; 20,-10], rotation=90);
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m) 
            annotation (extent=[50,30; 30,10], rotation=180);
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m) 
            annotation (extent=[-50,-30; -30,-10]);
          annotation (Diagram);
        equation 
          connect(star2.pin_n,starpoint2) 
            annotation (points=[10,-90; 10,-100; 50,-100], style(color=3, rgbcolor={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) 
            annotation (points=[-90,0; -90,-20; -50,-20], style(color=3, rgbcolor={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) 
            annotation (points=[-50,0; -50,20; -10,20; -10,5], style(color=3,rgbcolor={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) 
            annotation (points=[-30,-20; -10,-20; -10,-5], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p) 
            annotation (points=[10,10; 30,10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) 
            annotation (points=[10,-4; 20,-4; 20,-10; 30,-10], style(color=3, rgbcolor={0,0,255}));
          connect(core.plug_n3, star2.plug_p) 
            annotation (points=[10,-10; 10,-70; 10,-70], style(color=3, rgbcolor={0,0,255}));
          connect(l2sigma.plug_p, Rot22.plug_n) 
            annotation (points=[50,0; 50,20], style(color=3, rgbcolor={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2) 
            annotation (points=[30,20; 20,20; 20,4; 10,4], style(color=3, rgbcolor={0,0,255}));
        end Dz10;
      end Dz;
      
    end Transformers;
    
    package Components "Machine components like AirGaps" 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<HTML>
<p>
This package contains components for modeling electrical machines, specially threephase induction machines, based on space phasor theory.
These models use package SpacePhasors.
</p>
</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
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
  </ul>
</HTML>"));
      
      partial model BasicAIM "Partial model for asynchronous induction machine" 
        extends Interfaces.PartialBasicMachine(J_Rotor=0.29);
        constant Real pi=Modelica.Constants.pi;
        constant Integer m=3 "number of phases";
        parameter Integer p(min=1)=2 "number of pole pairs (Integer)";
        parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
        parameter Modelica.SIunits.Resistance Rs=0.03 
          "|Nominal resistances and inductances|warm stator resistance per phase";
        parameter Modelica.SIunits.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*fNominal) 
          "|Nominal resistances and inductances|stator stray inductance per phase";
        output Modelica.SIunits.Voltage vs[m] = plug_sp.pin.v - plug_sn.pin.v 
          "stator instantaneous voltages";
        output Modelica.SIunits.Current is[m] = plug_sp.pin.i 
          "stator instantaneous currents";
        output Modelica.SIunits.Current i_0_s( stateSelect=StateSelect.prefer) = spacePhasorS.zero.i 
          "stator zero-sequence current";
        output Modelica.SIunits.Current idq_ss[2] = airGapS.i_ss 
          "stator space phasor current / stator fixed frame";
        output Modelica.SIunits.Current idq_sr[2](each stateSelect=StateSelect.prefer) = airGapS.i_sr 
          "stator space phasor current / rotor fixed frame";
        output Modelica.SIunits.Current idq_rs[2] = airGapS.i_rs 
          "rotor space phasor current / stator fixed frame";
        output Modelica.SIunits.Current idq_rr[2](each stateSelect=StateSelect.prefer) = airGapS.i_rr 
          "rotor space phasor current / rotor fixed frame";
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m) 
          annotation (extent=[50,90; 70,110]);
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m) 
          annotation (extent=[-70,90; -50,110]);
        annotation (Documentation(info="<HTML>
<p>
Partial model for induction machine models, containing:
<ul>
<li>main parts of the icon</li>
<li>stator plugs</li>
<li>mechanical connectors</li>
</ul>
</p>
</HTML>"),Diagram,
          Icon(Line(points=[-50,100; -20,100; -20,70], style(color=3, rgbcolor={0,
                    0,255})), Line(points=[50,100; 20,100; 20,70], style(color=3,
                  rgbcolor={0,0,255}))));
        Modelica.Electrical.MultiPhase.Basic.Resistor rs(final m=m, final R=fill(Rs, m)) 
          annotation (extent=[60,50; 40,70]);
        Modelica.Electrical.MultiPhase.Basic.Inductor lssigma(final m=m, final L=fill(Lssigma, m)) 
          annotation (extent=[30,50; 10,70]);
        SpacePhasors.Components.SpacePhasor spacePhasorS 
          annotation (extent=[10,40; -10,20],   rotation=90);
        replaceable AirGapS airGapS(final p=p, final m=3) extends PartialAirGap
          annotation (extent=[-10,-10; 10,10], rotation=-90);
      equation 
        connect(rs.plug_n,lssigma. plug_p) 
          annotation (points=[40,60; 30,60],   style(color=3));
        connect(lssigma.plug_n,spacePhasorS. plug_p) 
          annotation (points=[10,60; 10,40],           style(color=3));
        connect(spacePhasorS.plug_n, plug_sn) annotation (points=[-10,40; -10,60;
              -60,60; -60,100],
                            style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=10,
            rgbfillColor={95,95,95},
            fillPattern=1));
        connect(spacePhasorS.ground,spacePhasorS. zero) annotation (points=[-10,20;
              -10,14; -6.12303e-016,14; -6.12303e-016,20],     style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=3,
            rgbfillColor={0,0,255},
            fillPattern=1));
        connect(rs.plug_p, plug_sp) annotation (points=[60,60; 60,100], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=10,
            rgbfillColor={95,95,95},
            fillPattern=1));
        connect(airGapS.flange_a, inertiaRotor.flange_a) 
                                                        annotation (points=[10,
              6.12303e-016; 35,6.12303e-016; 35,-1.22461e-015; 60,-1.22461e-015],
            style(color=0, rgbcolor={0,0,0}));
        connect(spacePhasorS.spacePhasor, airGapS.spacePhasor_s) 
                                                                annotation (
            points=[10,20; 10,10], style(color=3, rgbcolor={0,0,255}));
        connect(airGapS.support, internalSupport) 
                                                 annotation (points=[-10,
              -6.12303e-016; -90,-6.12303e-016; -90,-100; 20,-100], style(color=
               0, rgbcolor={0,0,0}));
      end BasicAIM;
      
      partial model BasicSM "Partial model for synchronous induction machine" 
        extends Interfaces.PartialBasicMachine(J_Rotor=0.29);
        constant Real pi=Modelica.Constants.pi;
        constant Integer m=3 "number of phases";
        parameter Integer p(min=1)=2 "number of pole pairs (Integer)";
        parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
        parameter Modelica.SIunits.Resistance Rs=0.03 
          "|Nominal resistances and inductances|warm stator resistance per phase";
        parameter Modelica.SIunits.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*fNominal) 
          "|Nominal resistances and inductances|stator stray inductance per phase";
        output Modelica.SIunits.Voltage vs[m] = plug_sp.pin.v - plug_sn.pin.v 
          "stator instantaneous voltages";
        output Modelica.SIunits.Current is[m] = plug_sp.pin.i 
          "stator instantaneous currents";
        output Modelica.SIunits.Current i_0_s( stateSelect=StateSelect.prefer) = spacePhasorS.zero.i 
          "stator zero-sequence current";
        output Modelica.SIunits.Current idq_ss[2] = airGapR.i_ss 
          "stator space phasor current / stator fixed frame";
        output Modelica.SIunits.Current idq_sr[2](each stateSelect=StateSelect.prefer) = airGapR.i_sr 
          "stator space phasor current / rotor fixed frame";
        output Modelica.SIunits.Current idq_rs[2] = airGapR.i_rs 
          "rotor space phasor current / stator fixed frame";
        output Modelica.SIunits.Current idq_rr[2](each stateSelect=StateSelect.prefer) = airGapR.i_rr 
          "rotor space phasor current / rotor fixed frame";
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m) 
          annotation (extent=[50,90; 70,110]);
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m) 
          annotation (extent=[-70,90; -50,110]);
        annotation (Documentation(info="<HTML>
<p>
Partial model for induction machine models, containing:
<ul>
<li>main parts of the icon</li>
<li>stator plugs</li>
<li>mechanical connectors</li>
</ul>
</p>
</HTML>"),Diagram,
          Icon(Line(points=[-50,100; -20,100; -20,70], style(color=3, rgbcolor={0,
                    0,255})), Line(points=[50,100; 20,100; 20,70], style(color=3,
                  rgbcolor={0,0,255}))));
        Modelica.Electrical.MultiPhase.Basic.Resistor rs(final m=m, final R=fill(Rs, m)) 
          annotation (extent=[60,50; 40,70]);
        Modelica.Electrical.MultiPhase.Basic.Inductor lssigma(final m=m, final L=fill(Lssigma, m)) 
          annotation (extent=[30,50; 10,70]);
        SpacePhasors.Components.SpacePhasor spacePhasorS 
          annotation (extent=[10,40; -10,20],   rotation=90);
        replaceable AirGapR airGapR(final p=p, final m=3) extends PartialAirGap
          annotation (extent=[-10,-10; 10,10], rotation=-90);
      equation 
        connect(rs.plug_n,lssigma. plug_p) 
          annotation (points=[40,60; 30,60],   style(color=3));
        connect(lssigma.plug_n,spacePhasorS. plug_p) 
          annotation (points=[10,60; 10,40],           style(color=3));
        connect(spacePhasorS.plug_n, plug_sn) annotation (points=[-10,40; -10,60;
              -60,60; -60,100],
                            style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=10,
            rgbfillColor={95,95,95},
            fillPattern=1));
        connect(spacePhasorS.ground,spacePhasorS. zero) annotation (points=[-10,20;
              -10,14; -6.12303e-016,14; -6.12303e-016,20],     style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=3,
            rgbfillColor={0,0,255},
            fillPattern=1));
        connect(rs.plug_p, plug_sp) annotation (points=[60,60; 60,100], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=10,
            rgbfillColor={95,95,95},
            fillPattern=1));
        connect(airGapR.flange_a, inertiaRotor.flange_a) 
                                                        annotation (points=[10,
              6.12303e-016; 35,6.12303e-016; 35,-1.22461e-015; 60,-1.22461e-015],
            style(color=0, rgbcolor={0,0,0}));
        connect(spacePhasorS.spacePhasor,airGapR. spacePhasor_s) 
                                                                annotation (
            points=[10,20; 10,10], style(color=3, rgbcolor={0,0,255}));
        connect(airGapR.support, internalSupport) 
                                                 annotation (points=[-10,
              -6.12303e-016; -90,-6.12303e-016; -90,-100; 20,-100], style(color=
               0, rgbcolor={0,0,0}));
      end BasicSM;
      
      partial model PartialAirGap "Partial airgap model" 
        parameter Integer m=3 "number of phases";
        parameter Integer p(min=1) "number of pole pairs";
        output Modelica.SIunits.Torque tau_electrical;
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
        Real RotationMatrix[2,2] "matrix of rotation from rotor to stator";
      public 
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
          annotation (extent=[-10,110; 10,90]);
        Modelica.Mechanics.Rotational.Interfaces.Flange_a support 
          "support at which the reaction torque is acting" 
             annotation (extent=[-10,-110; 10,-90]);
        Machines.Interfaces.SpacePhasor spacePhasor_s 
          annotation (extent=[-110,90; -90,110]);
        Machines.Interfaces.SpacePhasor spacePhasor_r 
          annotation (extent=[90,90; 110,110]);
        annotation (
          Diagram,
          Icon(
            Ellipse(extent=[-90, 90; 90, -92], style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=7,
                rgbfillColor={255,255,255})),
            Ellipse(extent=[-80, 80; 80, -80], style(color=3)),
            Rectangle(extent=[-10, 90; 10, -80], style(
                color=3,
                gradient=1,
                fillColor=10)),
            Text(
              extent=[-150,-90; 150,-150],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),
          Documentation(info="<HTML>
<p>
Partial model of the airgap, using only equations.
</p>
</HTML>"));
      equation 
        // mechanical angle of the rotor of an equivalent 2-pole machine
        gamma=p*(flange_a.phi-support.phi);
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
        tau_electrical = m/2*p*(spacePhasor_s.i_[2]*psi_ms[1] - spacePhasor_s.i_[1]*psi_ms[2]);
        flange_a.tau = -tau_electrical;
        support.tau = tau_electrical;
      end PartialAirGap;
      
      model AirGapS "Airgap in stator-fixed coordinate system" 
        parameter Modelica.SIunits.Inductance Lm "main field inductance";
        extends PartialAirGap;
        Modelica.SIunits.Current i_ms[2] 
          "Magnetizing current space phasor with respect to the stator fixed frame";
      protected 
        parameter Modelica.SIunits.Inductance L[2,2]={{Lm,0},{0,Lm}} 
          "inductance matrix";
        annotation (defaultComponentName="airGap",
          Diagram,
          Icon(
            Text(
              extent=[-80, 40; 0, -40],
              string="S",
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=1,
                fillColor=10,
                rgbfillColor={128,128,128})),
            Text(
              extent=[-150,-90; 150,-150],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),
          Documentation(info="<HTML>
<p>
Model of the airgap in stator-fixed coordinate system, using only equations.
</p>
</HTML>"));
      equation 
        // Magnetizing current with respect to the stator reference frame
        i_ms = i_ss + i_rs;
        // Magnetizing flux linkage with respect to the stator reference frame
        psi_ms = L*i_ms;
        // Magnetizing flux linkage with respect to the rotor reference frame
        psi_mr = transpose(RotationMatrix)*psi_ms;
      end AirGapS;
      
      model AirGapR "Airgap in rotor-fixed coordinate system" 
        parameter Modelica.SIunits.Inductance Lmd 
          "main field inductance d-axis";
        parameter Modelica.SIunits.Inductance Lmq 
          "main field inductance q-axis";
        extends PartialAirGap;
        Modelica.SIunits.Current i_mr[2] 
          "Magnetizing current space phasor with respect to the stator fixed frame";
      protected 
        parameter Modelica.SIunits.Inductance L[2,2]={{Lmd,0},{0,Lmq}} 
          "inductance matrix";
        annotation (defaultComponentName="airGap",
          Diagram,
          Icon(
            Text(
              extent=[0, 40; 80, -40],
              string="R",
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=1,
                fillColor=10,
                rgbfillColor={128,128,128})),
            Text(
              extent=[-150,-90; 150,-150],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),
          Documentation(info="<HTML>
<p>
Model of the airgap in rotor-fixed coordinate system, using only equations.
</p>
</HTML>"));
      equation 
        // Magnetizing current with respect to the rotor reference frame
        i_mr = i_sr + i_rr;
        // Main flux linkage with respect to the stator reference frame
        psi_mr = L*i_mr;
        // Main flux linkage with respect to the stator reference frame
        psi_ms = RotationMatrix*psi_mr;
        // Stator voltage induction
      end AirGapR;
      
      model SquirrelCage "Squirrel Cage" 
        parameter Modelica.SIunits.Inductance Lrsigma 
          "rotor stray inductance per phase translated to stator";
        parameter Modelica.SIunits.Resistance Rr 
          "warm rotor resistance per phase translated to stator";
        Machines.Interfaces.SpacePhasor spacePhasor_r 
          annotation (extent=[-110,90; -90,110]);
        annotation (
          Diagram,
          Icon(
            Ellipse(extent=[-60, 45; -30, 75]),
            Ellipse(extent=[-30, 45; 0, 75]),
            Ellipse(extent=[0, 45; 30, 75]),
            Ellipse(extent=[30, 45; 60, 75]),
            Rectangle(extent=[-60, 30; 60, 60], style(color=7, fillColor=7)),
            Line(points=[-100,60; -60,60]),
            Line(points=[60, 60; 80, 60; 80, 40], style(color=3, rgbcolor={0,0,
                    255})),
            Rectangle(extent=[60, 40; 100, -40], style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=7,
                rgbfillColor={255,255,255})),
            Line(points=[80, -40; 80, -60], style(color=3, rgbcolor={0,0,255})),
            Line(points=[60, -60; 100, -60], style(color=3, rgbcolor={0,0,255})),
            Line(points=[70, -80; 90, -80], style(color=3, rgbcolor={0,0,255})),
            Line(points=[66, -70; 94, -70], style(color=3, rgbcolor={0,0,255})),
            Text(
              extent=[-150,-90; 150,-150],
              style(color=3, rgbcolor={0,0,255}),
              string="%name"),
            Line(points=[-100,90; -100,60], style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=3,
                rgbfillColor={0,0,255},
                fillPattern=1))),
          Documentation(info="<HTML>
<p>
Model of a squirrel cage / damper cage in two axis.
</p>
</HTML>"));
      equation 
        spacePhasor_r.v_ = Rr * spacePhasor_r.i_ + Lrsigma * der(spacePhasor_r.i_);
      end SquirrelCage;
      
      model DamperCage "Squirrel Cage" 
        parameter Modelica.SIunits.Inductance Lrsigma 
          "stray inductance in d-axis per phase translated to stator";
        parameter Modelica.SIunits.Inductance Lrsigmaq 
          "stray inductance in q-axis per phase translated to stator";
        parameter Modelica.SIunits.Resistance Rr 
          "warm resistance in d-axis per phase translated to stator";
        parameter Modelica.SIunits.Resistance Rrq 
          "warm resistance in q-axis per phase translated to stator";
        Machines.Interfaces.SpacePhasor spacePhasor_r 
          annotation (extent=[-110,90; -90,110]);
        annotation (
          Diagram,
          Icon(
            Line(points=[60,60; 100,60],     style(color=3, rgbcolor={0,0,255})),
            Line(points=[70,40; 90,40],     style(color=3, rgbcolor={0,0,255})),
            Line(points=[66,50; 94,50],     style(color=3, rgbcolor={0,0,255})),
            Text(
              extent=[-150,-90; 150,-150],
              style(color=3, rgbcolor={0,0,255}),
              string="%name"),
            Ellipse(extent=[-60,90; -40,70], style(color=3, rgbcolor={0,0,255})),
            Ellipse(extent=[-40,90; -20,70], style(color=3, rgbcolor={0,0,255})),
            Ellipse(extent=[-20,90; 0,70], style(color=3, rgbcolor={0,0,255})),
            Line(points=[-80,0; -80,-20], style(color=3, rgbcolor={0,0,255})),
            Rectangle(extent=[20,90; 60,70], style(color=3, rgbcolor={0,0,255})),
            Line(points=[60,80; 80,80; 80,60], style(color=3, rgbcolor={0,0,255})),
            Line(points=[-100,90; -100,80; -60,80], style(color=3, rgbcolor={0,
                    0,255})),
            Line(points=[-100,90; -100,80; -80,80; -80,60], style(color=3,
                  rgbcolor={0,0,255})),
            Ellipse(extent=[-90,60; -70,40], style(color=3, rgbcolor={0,0,255})),
            Ellipse(extent=[-90,40; -70,20], style(color=3, rgbcolor={0,0,255})),
            Ellipse(extent=[-90,20; -70,0], style(color=3, rgbcolor={0,0,255})),
            Rectangle(extent=[-80,0; -70,60],   style(color=7, fillColor=7)),
            Line(points=[0,80; 20,80], style(color=3, rgbcolor={0,0,255})),
            Rectangle(extent=[-90,-20; -70,-60], style(color=3, rgbcolor={0,0,255})),
            Line(points=[-100,-80; -60,-80], style(color=3, rgbcolor={0,0,255})),
            Line(points=[-90,-100; -70,-100],
                                            style(color=3, rgbcolor={0,0,255})),
            Line(points=[-94,-90; -66,-90], style(color=3, rgbcolor={0,0,255})),
            Line(points=[-80,-60; -80,-80], style(color=3, rgbcolor={0,0,255})),
            Rectangle(extent=[0,70; -60,80],    style(color=7, fillColor=7))),
          Documentation(info="<HTML>
<p>
Model of an unsymmetrical damper cage cage in two axis.
</p>
</HTML>"));
        
      equation 
        spacePhasor_r.v_[1] = Rr * spacePhasor_r.i_[1] + Lrsigma * der(spacePhasor_r.i_[1]);
        spacePhasor_r.v_[2] = Rrq * spacePhasor_r.i_[2] + Lrsigmaq * der(spacePhasor_r.i_[2]);
      end DamperCage;
      
      model ElectricalExcitation "Electrical excitation" 
        parameter Real TurnsRatio=1 "stator current / excitation current";
        Modelica.SIunits.Current ie "excitation current";
        Modelica.SIunits.Voltage ve "excitation voltage";
        Machines.Interfaces.SpacePhasor spacePhasor_r 
          annotation (extent=[-110,90; -90,110]);
        annotation (
          Diagram,
          Icon(
            Text(
              extent=[-150,-90; 150,-150],
              style(color=3, rgbcolor={0,0,255}),
              string="%name"),
            Polygon(points=[-90,100; -70,106; -70,94; -90,100],     style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=3,
                rgbfillColor={0,0,255})),
            Ellipse(extent=[-70,40; 10,-40], style(color=3, rgbcolor={0,0,255})),
            Ellipse(extent=[-10,40; 70,-40], style(color=3, rgbcolor={0,0,255})),
            Line(points=[-30,0; -54,32; -50,20; -44,26; -54,32], style(color=3,
                  rgbcolor={0,0,255})),
            Line(points=[-30,0; -54,-32; -50,-20; -44,-26; -54,-32], style(
                  color=3, rgbcolor={0,0,255})),
            Line(points=[-54,32; -54,100; -70,100], style(color=3, rgbcolor={0,
                    0,255})),
            Line(points=[90,100; 30,100; 30,40], style(color=3, rgbcolor={0,0,
                    255})),
            Line(points=[30,-40; 30,-100; 90,-100], style(color=3, rgbcolor={0,
                    0,255}))),
          Documentation(info="<HTML>
<p>
Model of an electrical excitation, converting excitation to space phasor.
</p>
</HTML>"));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
          annotation (extent=[90,110; 110,90]);
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
          annotation (extent=[110,-110; 90,-90]);
      equation 
        pin_ep.i + pin_en.i = 0;
        ie = +pin_ep.i;
        ve = pin_ep.v - pin_en.v;
        spacePhasor_r.i_ = {-ie*TurnsRatio,0};
        ve = spacePhasor_r.v_[1]*TurnsRatio;
      end ElectricalExcitation;
      
      model PermanentMagnet "Permanent magnet excitation" 
        parameter Modelica.SIunits.Current Ie "Equivalent excitation current";
        Machines.Interfaces.SpacePhasor spacePhasor_r 
          annotation (extent=[-110,90; -90,110]);
        annotation (
          Diagram,
          Icon(
            Ellipse(extent=[-60, 60; 60, 20], style(
                color=1,
                rgbcolor={255,0,0},
                fillColor=1,
                rgbfillColor={255,0,0})),
            Ellipse(extent=[-60, -20; 60, -60], style(
                color=2,
                rgbcolor={0,255,0},
                fillColor=2,
                rgbfillColor={0,255,0})),
            Rectangle(extent=[-60, 40; 60, 0], style(
                color=1,
                rgbcolor={255,0,0},
                fillColor=1,
                rgbfillColor={255,0,0})),
            Polygon(points=[-90, 100; -70, 106; -70, 94; -90, 100], style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=3,
                rgbfillColor={0,0,255})),
            Rectangle(extent=[-60, 0; 60, -40], style(
                color=2,
                rgbcolor={0,255,0},
                pattern=0,
                thickness=2,
                fillColor=2,
                rgbfillColor={0,255,0},
                fillPattern=1)),
            Line(points=[-60, -40; -60, 0], style(
                color=2,
                rgbcolor={0,255,0},
                fillColor=2,
                rgbfillColor={0,255,0},
                fillPattern=1)),
            Line(points=[60, -40; 60, 0], style(
                color=2,
                rgbcolor={0,255,0},
                fillColor=2,
                rgbfillColor={0,255,0},
                fillPattern=1)),
            Line(points=[0, 100; -70, 100], style(color=3, rgbcolor={0,0,255})),
            Line(points=[0, 100; 0, 60], style(
                color=1,
                rgbcolor={255,0,0},
                fillColor=1,
                rgbfillColor={255,0,0})),
            Text(
              extent=[-150,-90; 150,-150],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),
          Documentation(info="<HTML>
<p>
Model of a permanent magnet excitation, characterized by an equivalent excitation current.
</p>
</HTML>"));
      equation 
        spacePhasor_r.i_ = {-Ie,0};
      end PermanentMagnet;
      
      partial model BasicDCMachine "Partial model for DC machine" 
        extends Interfaces.PartialBasicMachine(J_Rotor=0.15);
        parameter Modelica.SIunits.Voltage VaNominal=100 
          "|Nominal parameters|nominal armature voltage";
        parameter Modelica.SIunits.Current IaNominal=100 
          "|Nominal parameters|nominal armature current";
        parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm 
          rpmNominal =  1425 "|Nominal parameters|nominal speed";
        parameter Modelica.SIunits.Resistance Ra=0.05 
          "|Nominal resistances and inductances|warm armature resistance";
        parameter Modelica.SIunits.Inductance La=0.0015 
          "|Nominal resistances and inductances|armature inductance";
        parameter Real TurnsRatio 
          "Ratio of armature turns over number of turns of the excitation winding";
        output Modelica.SIunits.Voltage va = pin_ap.v-pin_an.v 
          "armature voltage";
        output Modelica.SIunits.Current ia = pin_ap.i "armature current";
        annotation (Documentation(info="<HTML>
<p>
Partial model for DC machine models, containing:
<ul>
<li>main parts of the icon</li>
<li>armature pins</li>
<li>mechanical connectors</li>
</ul>
</p>
</HTML>"),Diagram,
          Icon(Line(points=[-50,100; -20,100; -20,70], style(color=3, rgbcolor={0,
                    0,255})), Line(points=[50,100; 20,100; 20,70], style(color=3,
                  rgbcolor={0,0,255}))));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap 
          annotation (extent=[50,110; 70,90]);
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_an 
          annotation (extent=[-70,110; -50,90]);
        Modelica.Electrical.Analog.Basic.Resistor ra(final R=Ra) 
          annotation (extent=[60,50; 40,70]);
        Modelica.Electrical.Analog.Basic.Inductor la(final L=La) 
          annotation (extent=[30,50; 10,70]);
        replaceable AirGapDC airGapDC(final TurnsRatio=TurnsRatio) extends 
          PartialAirGapDC annotation (extent=[-10,-10; 10,10], rotation=-90);
      equation 
        connect(la.p,ra. n) 
          annotation (points=[30,60; 40,60], style(color=3, rgbcolor={0,0,255}));
        connect(la.n, airGapDC.pin_ap) 
          annotation (points=[10,60; 10,10], style(color=3, rgbcolor={0,0,255}));
        connect(airGapDC.pin_an, pin_an) annotation (points=[-10,10; -10,60; -60,60;
              -60,100], style(color=3, rgbcolor={0,0,255}));
        connect(airGapDC.flange_a, inertiaRotor.flange_a) annotation (points=[10,
              6.12303e-016; 24,6.12303e-016; 24,-1.22461e-015; 60,-1.22461e-015],
            style(color=0, rgbcolor={0,0,0}));
        connect(airGapDC.support, internalSupport) annotation (points=[-10,
              -6.12303e-016; -90,-6.12303e-016; -90,-100; 20,-100], style(color=
               0, rgbcolor={0,0,0}));
        connect(pin_ap,ra. p) 
          annotation (points=[60,100; 60,60], style(color=3, rgbcolor={0,0,255}));
      end BasicDCMachine;
      
      partial model PartialAirGapDC "Partial airgap model of a DC machine" 
        parameter Real TurnsRatio 
          "Ratio of armature turns over number of turns of the excitation winding";
        Modelica.SIunits.AngularVelocity w "Angluar velocity";
        Modelica.SIunits.Voltage vei 
          "Voltage drop across field excitation inductance";
        Modelica.SIunits.Current ie "Excitation current";
        Modelica.SIunits.MagneticFlux psi_e "Excitation flux";
        Modelica.SIunits.Voltage vai "Induced armature voltage";
        Modelica.SIunits.Current ia "Armature current";
        output Modelica.SIunits.Torque tau_electrical;
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
          annotation (extent=[-10,110; 10,90]);
        Modelica.Mechanics.Rotational.Interfaces.Flange_a support 
          "support at which the reaction torque is acting" 
             annotation (extent=[-10,-110; 10,-90]);
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap 
          annotation (extent=[-110,110; -90,90]);
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
          annotation (extent=[90,110; 110,90]);
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_an 
          annotation (extent=[-110,-110; -90,-90]);
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
          annotation (extent=[90,-110; 110,-90]);
        annotation (
          Diagram,
          Icon(
            Ellipse(extent=[-90, 90; 90, -92], style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=7,
                rgbfillColor={255,255,255})),
            Ellipse(extent=[-80, 80; 80, -80], style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=7,
                rgbfillColor={255,255,255})),
            Rectangle(extent=[-10, 90; 10, -80], style(
                color=3,
                gradient=1,
                fillColor=10)),
            Text(
              extent=[0,40; 80,-40],
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=1,
                fillColor=10,
                rgbfillColor={128,128,128}),
              string="E"),
            Text(
              extent=[-150,-100; 150,-160],
              style(color=3, rgbcolor={0,0,255}),
              string="%name"),
            Text(
              extent=[-80,40; 0,-40],
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=1,
                fillColor=10,
                rgbfillColor={128,128,128}),
              string="A")),
          Documentation(info="<HTML>
<p>
Linear model of the airgap (without saturation effects) of a DC machine, using only equations.<br>
Induced excitation voltage is calculated from der(flux), where flux is defined by excitation inductance times excitation current.<br>
Induced armature voltage is calculated from flux times angular velocity.
</p>
</HTML>"));
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
        vei = der(psi_e);
        // mechanical speed
        w = der(flange_a.phi)-der(support.phi);
        // induced armature voltage
        vai = TurnsRatio * psi_e * w;
        // electrical torque (ia is perpendicular to flux)
        tau_electrical = TurnsRatio * psi_e * ia;
        flange_a.tau = -tau_electrical;
        support.tau = tau_electrical;
      end PartialAirGapDC;
      
      model AirGapDC "Linear airgap model of a DC machine" 
        extends PartialAirGapDC;
        parameter Modelica.SIunits.Inductance Le "Excitation inductance";
        annotation (defaultComponentName="airGap",
          Diagram,
          Icon(
            Text(
              extent=[-150,-100; 150,-160],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),
          Documentation(info="<HTML>
<p>
Linear model of the airgap (without saturation effects) of a DC machine, using only equations.<br>
Induced excitation voltage is calculated from der(flux), where flux is defined by excitation inductance times excitation current.<br>
Induced armature voltage is calculated from flux times angular velocity.
</p>
</HTML>"));
      equation 
        // excitation flux: linearly dependent on excitation current
        psi_e = Le * ie;
      end AirGapDC;
      
      partial model BasicTransformer "partial model of threephase transformer" 
        constant Integer m(min=1) = 3 "number of phases";
        constant String VectorGroup="Yy00";
        parameter Real n=1 
          "primary voltage (line-to-line) / secondary voltage (line-to-line)";
        parameter Modelica.SIunits.Resistance R1=5E-3/(if C1=="D" then 1 else 3) 
          "warm primary resistance per phase";
        parameter Modelica.SIunits.Inductance L1sigma=78E-6/(if C1=="D" then 1 else 3) 
          "primary stray inductance per phase";
        parameter Modelica.SIunits.Resistance R2=5E-3/(if C2=="d" then 1 else 3) 
          "warm secondary resistance per phase";
        parameter Modelica.SIunits.Inductance L2sigma=78E-6/(if C2=="d" then 1 else 3) 
          "secondary stray inductance per phase";
        output Modelica.SIunits.Voltage v1[m]=plug1.pin.v "primary voltage";
        output Modelica.SIunits.Current i1[m]=plug1.pin.i "primary current";
        output Modelica.SIunits.Voltage v2[m]=plug2.pin.v "secondary voltage";
        output Modelica.SIunits.Current i2[m]=plug2.pin.i "secondary current";
      protected 
        constant String C1 = Modelica.Utilities.Strings.substring(VectorGroup,1,1);
        constant String C2 = Modelica.Utilities.Strings.substring(VectorGroup,2,2);
        parameter Real ni=n*(if C2=="z" then sqrt(3) else 2)*(if C2=="d" then 1 else sqrt(3))/(if C1=="D" then 1 else sqrt(3));
      public 
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug1(final m=m) annotation (extent=[-110, -10; -90, 10]);
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug2(final m=m) annotation (extent=[90, -10; 110, 10]);
        Modelica.Electrical.MultiPhase.Basic.Resistor r1(final m=m, final R=fill(R1,m)) 
          annotation (extent=[-90,-10; -70,10]);
        Modelica.Electrical.MultiPhase.Basic.Inductor l1sigma(final m=m, final L=fill(L1sigma, m)) 
          annotation (extent=[-70,-10; -50,10]);
        Modelica.Electrical.MultiPhase.Basic.Resistor r2(final m=m, final R=fill(R2,m)) 
          annotation (extent=[70,-10; 90,10]);
        Modelica.Electrical.MultiPhase.Basic.Inductor l2sigma(final m=m, final L=fill(L2sigma, m)) 
          annotation (extent=[50,-10; 70,10]);
        annotation (Diagram, Icon(
            Ellipse(extent=[-90,60; 30,-60], style(color=3, rgbcolor={0,0,255})),
            Ellipse(extent=[-30,60; 90,-60], style(color=3, rgbcolor={0,0,255})),
            Text(
              extent=[0,100; 0,60],
              style(color=3, rgbcolor={0,0,255}),
              string="%name"),
            Text(
              extent=[0,40; 0,-40],
              style(color=3, rgbcolor={0,0,255}),
              string="%VectorGroup"),
            Text(
              extent=[0,-60; 0,-100],
              style(color=3, rgbcolor={0,0,255}),
              string="n=%n")));
        replaceable IdealCore core(
          final m=m,
          final n12=ni,
          final n13=ni) extends PartialCore 
          annotation (extent=[-10,-10; 10,10]);
      equation 
        connect(r1.plug_n,l1sigma. plug_p) 
          annotation (points=[-70,0; -70,0], style(color=3, rgbcolor={0,0,255}));
        connect(l2sigma.plug_n,r2. plug_p) 
          annotation (points=[70,0; 70,0], style(color=3, rgbcolor={0,0,255}));
        connect(plug1, r1.plug_p) 
          annotation (points=[-100,0; -90,0], style(color=3, rgbcolor={0,0,255}));
        connect(r2.plug_n, plug2) 
          annotation (points=[90,0; 100,0], style(color=3, rgbcolor={0,0,255}));
      end BasicTransformer;
      
      partial model PartialCore 
        "partial model of transformer core with 3 windings" 
        parameter Integer m(final min=1) = 3 "number of phases";
        parameter Real n12=1 "Turns ratio 1:2";
        parameter Real n13=2 "Turns ratio 1:3";
        Modelica.SIunits.Voltage v1[m] = plug_p1.pin.v  - plug_n1.pin.v;
        Modelica.SIunits.Current i1[m] = plug_p1.pin.i;
        Modelica.SIunits.Voltage v2[m] = plug_p2.pin.v  - plug_n2.pin.v;
        Modelica.SIunits.Current i2[m] = plug_p2.pin.i;
        Modelica.SIunits.Voltage v3[m] = plug_p3.pin.v  - plug_n3.pin.v;
        Modelica.SIunits.Current i3[m] = plug_p3.pin.i;
        Modelica.SIunits.Current im[m] = i1 + i2/n12 + i3/n13 
          "magnetizing current";
        annotation (Icon(
            Text(extent=[-100,130; 100,110],  string="%name"),
            Ellipse(extent=[-45, -50; -20, -25]),
            Ellipse(extent=[-45, -25; -20, 0]),
            Ellipse(extent=[-45, 0; -20, 25]),
            Ellipse(extent=[-45, 25; -20, 50]),
            Rectangle(extent=[-46,-50; -34,50],   style(color=7, fillColor=7)),
            Line(points=[-90, 50; -32, 50]),
            Line(points=[-90, -50; -32, -50]),
            Ellipse(extent=[20,40; 45,65]),
            Ellipse(extent=[20,65; 45,90]),
            Rectangle(extent=[36,40; 46,90],    style(color=7, fillColor=7)),
            Line(points=[32,90; 90,90]),
            Line(points=[34,40; 92,40]),
            Ellipse(extent=[20,-90; 45,-65]),
            Ellipse(extent=[20,-65; 45,-40]),
            Rectangle(extent=[36,-90; 46,-40],  style(color=7, fillColor=7)),
            Line(points=[32,-40; 90,-40]),
            Line(points=[34,-90; 92,-90])),
          Diagram,
          Window(
            x=0.29,
            y=0.07,
            width=0.6,
            height=0.6));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p1(final m=
              m) annotation (extent=[-110,40; -90,60]);
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n1(final m=
              m) annotation (extent=[-110,-60; -90,-40]);
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p2(final m=
              m) annotation (extent=[90,90; 110,110]);
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n2(final m=
              m) annotation (extent=[90,30; 110,50]);
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p3(final m=
              m) annotation (extent=[90,-30; 110,-50]);
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n3(final m=
              m) annotation (extent=[90,-90; 110,-110]);
      equation 
        plug_p1.pin.i + plug_n1.pin.i = zeros(m);
        plug_p2.pin.i + plug_n2.pin.i = zeros(m);
        plug_p3.pin.i + plug_n3.pin.i = zeros(m);
      end PartialCore;
      
      model IdealCore "ideal transformer with 3 windings" 
        
        annotation (defaultComponentName="core", Diagram);
        extends PartialCore;
      equation 
        im = zeros(m);
        v1 = n12*v2;
        v1 = n13*v3;
      end IdealCore;
      
    end Components;
  end BasicMachines;
  
  package Sensors "Sensors for machine modelling" 
   extends Modelica.Icons.Library2;
    annotation (Documentation(info="<HTML>
<p>
This package contains sensors that are usefull when modelling machines.
</p>

</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>

  <ul>
  <li> v1.03 2004/09/24 Anton Haumer</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed RotorAngle</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support, also in sensor RotorAngle<br>
       to ease the implementation of a 3D-frame in a future release</li>
  </ul>
</HTML>"), Icon(
        Ellipse(extent=[-74,46; 66,-94],   style(color=0, fillColor=7)),
        Line(points=[-4,46; -4,16], style(color=0)),
        Line(points=[18.9,8.8; 36.2,33.3],    style(color=0)),
        Line(points=[-26.9,8.8; -44.2,33.3],    style(color=0)),
        Line(points=[33.6,-10.3; 61.8,-0.1],  style(color=0)),
        Line(points=[-41.6,-10.3; -69.8,-0.1],  style(color=0)),
        Line(points=[-4,-24; 5.02,4.6], style(color=0)),
        Polygon(points=[-4.48,7.6; 14,2; 14,33.2; -4.48,7.6],        style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Ellipse(extent=[-9,-19; 1,-29],style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))));
    
    model VoltageRMSsensor "length of spcae phasor -> RMS voltage" 
      constant Integer m(final min=1) = 3 "number of phases";
      Modelica.Blocks.Interfaces.RealOutput V(redeclare type SignalType = 
            Modelica.SIunits.Voltage) 
        annotation (extent=[-10,-120; 10,-100], rotation=-90);
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m) 
        annotation (extent=[-110,-10; -90,10]);
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m) 
        annotation (extent=[90,-10; 110,10]);
      Modelica.Electrical.MultiPhase.Sensors.VoltageSensor VoltageSensor1(final m=m) 
        annotation (extent=[-10,40; 10,60]);
      Modelica.Blocks.Math.Gain Gain1(final k=1/sqrt(2)) 
        annotation (extent=[-10,-80; 10,-60], rotation=-90);
      Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasor1 
        annotation (extent=[-10,0; 10,20], rotation=-90);
      Machines.SpacePhasors.Blocks.ToPolar ToPolar1 
        annotation (extent=[-10,-40; 10,-20], rotation=-90);
      annotation (Diagram, Icon(
          Ellipse(extent=[-70,70; 70,-70],   style(color=0, fillColor=7)),
          Line(points=[0,70; 0,40],   style(color=0)),
          Line(points=[22.9,32.8; 40.2,57.3],   style(color=0)),
          Line(points=[-22.9,32.8; -40.2,57.3],   style(color=0)),
          Line(points=[37.6,13.7; 65.8,23.9],   style(color=0)),
          Line(points=[-37.6,13.7; -65.8,23.9],   style(color=0)),
          Line(points=[0,0; 9.02,28.6],   style(color=0)),
          Polygon(points=[-0.48,31.6; 18,26; 18,57.2; -0.48,31.6],     style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Ellipse(extent=[-5,5; 5,-5],   style(
              color=0,
              gradient=0,
              fillColor=0,
              fillPattern=1)),
          Line(points=[-90,0; -70,0], style(color=3, rgbcolor={0,0,255})),
          Line(points=[70,0; 90,0], style(color=3, rgbcolor={0,0,255})),
          Line(points=[0,-70; 0,-100], style(color=3, rgbcolor={0,0,255})),
          Text(
            extent=[-40,-20; 40,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="V RMS")),
        Documentation(info="<HTML>
<p>
Measured 3-phase instantaneous voltages are transformed to the corresponding space phasor; <br>
output is length of the space phasor divided by sqrt(2), thus giving in sinusoidal stationary state RMS voltage.
</p>
</HTML>"));
    equation 
      connect(plug_p, VoltageSensor1.plug_p) 
        annotation (points=[-100,0; -100,50; -10,50],
                                            style(color=3, rgbcolor={0,0,255}));
      connect(VoltageSensor1.plug_n, plug_n) 
        annotation (points=[10,50; 100,50; 100,0],
                                          style(color=3, rgbcolor={0,0,255}));
      connect(VoltageSensor1.v, ToSpacePhasor1.u) annotation (points=[0,39; 0,
            22; -7.34764e-016,22],
                               style(color=3, rgbcolor={0,0,255}));
      connect(ToSpacePhasor1.y, ToPolar1.u) annotation (points=[6.73533e-016,-1;
            6.73533e-016,-8.5; -7.34764e-016,-8.5; -7.34764e-016,-18], style(color=
              3, rgbcolor={0,0,255}));
      connect(ToPolar1.y[1], Gain1.u) annotation (points=[-0.5,-41; -0.5,-49.5;
            -7.34764e-016,-49.5; -7.34764e-016,-58], style(color=3, rgbcolor={0,0,
              255}));
      connect(Gain1.y, V) annotation (points=[6.73533e-016,-81; 6.73533e-016,
            -91.5; 0,-91.5; 0,-110],
                              style(color=3, rgbcolor={0,0,255}));
    end VoltageRMSsensor;
    
    model CurrentRMSsensor "length of spcae phasor -> RMS current" 
      constant Integer m(final min=1) = 3 "number of phases";
      Modelica.Blocks.Interfaces.RealOutput I(redeclare type SignalType = 
            Modelica.SIunits.Current) 
        annotation (extent=[-10,-120; 10,-100], rotation=-90);
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m) 
        annotation (extent=[-110,-10; -90,10]);
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m) 
        annotation (extent=[90,-10; 110,10]);
      Modelica.Electrical.MultiPhase.Sensors.CurrentSensor CurrentSensor1(final m=m) 
        annotation (extent=[-10,40; 10,60]);
      Modelica.Blocks.Math.Gain Gain1(final k=1/sqrt(2)) 
        annotation (extent=[-10,-80; 10,-60], rotation=-90);
      Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasor1 
        annotation (extent=[-10,0; 10,20], rotation=-90);
      Machines.SpacePhasors.Blocks.ToPolar ToPolar1 
        annotation (extent=[-10,-40; 10,-20], rotation=-90);
      annotation (Diagram, Icon(
          Ellipse(extent=[-70,70; 70,-70],   style(color=0, fillColor=7)),
          Line(points=[0,70; 0,40],   style(color=0)),
          Line(points=[22.9,32.8; 40.2,57.3],   style(color=0)),
          Line(points=[-22.9,32.8; -40.2,57.3],   style(color=0)),
          Line(points=[37.6,13.7; 65.8,23.9],   style(color=0)),
          Line(points=[-37.6,13.7; -65.8,23.9],   style(color=0)),
          Line(points=[0,0; 9.02,28.6],   style(color=0)),
          Polygon(points=[-0.48,31.6; 18,26; 18,57.2; -0.48,31.6],     style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Ellipse(extent=[-5,5; 5,-5],   style(
              color=0,
              gradient=0,
              fillColor=0,
              fillPattern=1)),
          Line(points=[-90,0; -70,0], style(color=3, rgbcolor={0,0,255})),
          Line(points=[70,0; 90,0], style(color=3, rgbcolor={0,0,255})),
          Line(points=[0,-70; 0,-100], style(color=3, rgbcolor={0,0,255})),
          Text(
            extent=[-40,-20; 40,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="A RMS")),
        Documentation(info="<HTML>
<p>
Measured 3-phase instantaneous currents are transformed to the corresponding space phasor; <br>
output is length of the space phasor divided by sqrt(2), thus giving in sinusoidal stationary state RMS current.
</p>
</HTML>"));
    equation 
      connect(plug_p, CurrentSensor1.plug_p) 
        annotation (points=[-100,0; -100,50; -10,50],
                                            style(color=3, rgbcolor={0,0,255}));
      connect(CurrentSensor1.plug_n, plug_n) 
        annotation (points=[10,50; 100,50; 100,0],
                                          style(color=3, rgbcolor={0,0,255}));
      connect(CurrentSensor1.i, ToSpacePhasor1.u) annotation (points=[0,39; 0,
            22; -7.34764e-016,22],
                               style(color=3, rgbcolor={0,0,255}));
      connect(ToSpacePhasor1.y, ToPolar1.u) annotation (points=[6.73533e-016,-1;
            6.73533e-016,-8.5; -7.34764e-016,-8.5; -7.34764e-016,-18], style(color=
              3, rgbcolor={0,0,255}));
      connect(ToPolar1.y[1], Gain1.u) annotation (points=[-0.5,-41; -0.5,-49.5;
            -7.34764e-016,-49.5; -7.34764e-016,-58], style(color=3, rgbcolor={0,0,
              255}));
      connect(Gain1.y,I)  annotation (points=[6.73533e-016,-81; 6.73533e-016,
            -91.5; 0,-91.5; 0,-110],
                              style(color=3, rgbcolor={0,0,255}));
    end CurrentRMSsensor;
    
    model ElectricalPowerSensor "instantaneous power from spcae phasors" 
      constant Integer m(final min=1) = 3 "number of phases";
      Modelica.Blocks.Interfaces.RealOutput P(redeclare type SignalType = 
            Modelica.SIunits.Power) 
        annotation (extent=[-60,120; -40,100],  rotation=-90);
      Modelica.Blocks.Interfaces.RealOutput Q(redeclare type SignalType = 
            Modelica.SIunits.Power) 
        annotation (extent=[40,120; 60,100], rotation=-90);
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m) 
        annotation (extent=[-110,-10; -90,10]);
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_ni(final m=m) 
        annotation (extent=[90,-10; 110,10]);
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_nv(final m=m) 
        annotation (extent=[-10,-110; 10,-90]);
      annotation (Icon(
          Ellipse(extent=[-70,70; 70,-70],   style(color=0, fillColor=7)),
          Line(points=[0,70; 0,40],   style(color=0)),
          Line(points=[22.9,32.8; 40.2,57.3],   style(color=0)),
          Line(points=[-22.9,32.8; -40.2,57.3],   style(color=0)),
          Line(points=[37.6,13.7; 65.8,23.9],   style(color=0)),
          Line(points=[-37.6,13.7; -65.8,23.9],   style(color=0)),
          Line(points=[0,0; 9.02,28.6],   style(color=0)),
          Polygon(points=[-0.48,31.6; 18,26; 18,57.2; -0.48,31.6],     style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Ellipse(extent=[-5,5; 5,-5],   style(
              color=0,
              gradient=0,
              fillColor=0,
              fillPattern=1)),
          Line(points=[-90,0; -70,0], style(color=3, rgbcolor={0,0,255})),
          Line(points=[70,0; 90,0], style(color=3, rgbcolor={0,0,255})),
          Text(
            extent=[-40,-20; 40,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="P Q"),
          Line(points=[0,-70; 0,-90],  style(color=3, rgbcolor={0,0,255})),
          Line(points=[-10,70; -10,80; -50,80; -50,100], style(color=3, rgbcolor={0,
                  0,255})),
          Line(points=[10,70; 10,80; 50,80; 50,100], style(color=3, rgbcolor={0,0,
                  255}))),
          Diagram,
        Documentation(info="<HTML>
<p>
3-phase instantaneous voltages (plug_p - plug_nv) and currents (plug_p - plug_ni) are transformed to the corresponding space phasors, <br>
which are used to calculate power quantities:<br>
P = instantaneous power, thus giving in stationary state active power.<br>
Q = giving in stationary state reactive power.<br>
</p>
</HTML>"));
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
    end ElectricalPowerSensor;
    
    model MechanicalPowerSensor "torque x speed" 
      extends Modelica.Mechanics.Rotational.Interfaces.TwoFlanges;
      Modelica.Blocks.Interfaces.RealOutput P(redeclare type SignalType = 
            Modelica.SIunits.Power) 
        annotation (extent=[-10,-100; 10,-120],   rotation=90);
      annotation (Icon(
          Ellipse(extent=[-70,70; 70,-70],   style(color=0, fillColor=7)),
          Line(points=[0,70; 0,40],   style(color=0)),
          Line(points=[22.9,32.8; 40.2,57.3],   style(color=0)),
          Line(points=[-22.9,32.8; -40.2,57.3],   style(color=0)),
          Line(points=[37.6,13.7; 65.8,23.9],   style(color=0)),
          Line(points=[-37.6,13.7; -65.8,23.9],   style(color=0)),
          Line(points=[0,0; 9.02,28.6],   style(color=0)),
          Polygon(points=[-0.48,31.6; 18,26; 18,57.2; -0.48,31.6],     style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Ellipse(extent=[-5,5; 5,-5],   style(
              color=0,
              gradient=0,
              fillColor=0,
              fillPattern=1)),
          Line(points=[-70,0; -90,0],   style(color=0)),
          Line(points=[70,0; 90,0],   style(color=0)),
          Line(points=[0,-100; 0,-70]),
          Text(
            extent=[-40,-20; 40,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="Pmech")), Diagram,
        Documentation(info="<HTML>
<p>
Calculates (mechanical) power from torque times angular speed.
</p>
</HTML>"));
      Modelica.Mechanics.Rotational.Sensors.TorqueSensor TorqueSensor1 
        annotation (extent=[20,-10; 40,10]);
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor SpeedSensor1 
        annotation (extent=[-40,-20; -20,0], rotation=-90);
      Modelica.Blocks.Math.Product Product1 
        annotation (extent=[-10,-80; 10,-60], rotation=-90);
    equation 
      connect(flange_a, TorqueSensor1.flange_a) 
        annotation (points=[-100,0; 20,0], style(color=0, rgbcolor={0,0,0}));
      connect(TorqueSensor1.flange_b, flange_b) 
        annotation (points=[40,0; 100,0], style(color=0, rgbcolor={0,0,0}));
      connect(SpeedSensor1.flange_a, flange_a) 
        annotation (points=[-30,0; -100,0], style(color=0, rgbcolor={0,0,0}));
      connect(SpeedSensor1.w, Product1.u2) annotation (points=[-30,-21; -30,-40;
            -6,-40; -6,-58], style(color=3, rgbcolor={0,0,255}));
      connect(TorqueSensor1.tau, Product1.u1) annotation (points=[22,-11; 22,
            -40; 6,-40; 6,-58], style(color=3, rgbcolor={0,0,255}));
      connect(Product1.y, P) annotation (points=[6.73533e-016,-81; 6.73533e-016,
            -90.5; 0,-90.5; 0,-110], style(color=3, rgbcolor={0,0,255}));
    end MechanicalPowerSensor;
    
    model RotorAngle "Rotor lagging angle" 
      constant Integer m=3 "number of phases";
      parameter Integer p(min=1) "number of pole pairs";
      Modelica.Blocks.Interfaces.RealOutput rotorAngle(redeclare type 
          SignalType = 
            Modelica.SIunits.Angle) annotation (extent=[100,-10; 120,10]);
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m) 
        annotation (extent=[-110,50; -90,70]);
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m) 
        annotation (extent=[-110,-70; -90,-50]);
      Modelica.Electrical.MultiPhase.Sensors.VoltageSensor VoltageSensor1(final m=m) 
        annotation (extent=[-90,0; -70,-20],rotation=90);
      Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasorVS 
        annotation (extent=[-60,-20; -40,0],    rotation=0);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange 
        annotation (extent=[-10,90; 10,110]);
      Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relativeAngleSensor 
        annotation (extent=[40,70; 20,90]);
      Modelica.Blocks.Sources.Constant constant_(final k=Modelica.Constants.pi/2) 
        annotation (extent=[-50,30; -30,50]);
      Modelica.Blocks.Math.Add add(final k2=1, final k1=p) 
        annotation (extent=[-20,10; 0,30],  rotation=-90);
      Machines.SpacePhasors.Blocks.Rotator rotatorVS2R 
        annotation (extent=[-20,0; 0,-20],     rotation=0);
      Machines.SpacePhasors.Blocks.ToPolar ToPolarVSR 
        annotation (extent=[20,-20; 40,0],    rotation=0);
      Modelica.Blocks.Routing.DeMultiplex2 deMultiplex2(final n1=1,
           final n2=1) annotation (extent=[60,-20; 80,0]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a support 
        "support at which the reaction torque is acting" 
           annotation (extent=[90,90; 110,110]);
    protected 
      Interfaces.Adapter adapter(final bearingConnected=cardinality(support) > 1) 
        annotation (extent=[80,70; 60,90]);
      annotation (
        Diagram,
        Icon(
          Ellipse(extent=[-60, 80; 60, 40], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255})),
          Ellipse(extent=[-60, -40; 60, -80], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255})),
          Rectangle(extent=[-60, 60; 60, 40], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Rectangle(extent=[-60, -40; 60, -60], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Rectangle(extent=[-40, 40; 40, -40], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Line(points=[0, 0; -80, 80], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Polygon(points=[-80, 80; -68, 76; -76, 68; -80, 80], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Line(points=[0, 0; 0, 80], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Polygon(points=[0, 84; 4, 72; -4, 72; 0, 84], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Rectangle(extent=[80,120; 120,80],     style(color=8, fillColor=8))),
        Documentation(info="<HTML>
<p>
Calculates rotor lagging angle by measuring the stator phase voltages, transforming them to the correspondig space phasor in stator-fixed coordinate system, <br>
rotating the space phasor to the rotor-fixed coordinate system and calculating the angle of this space phasor.
</p>
<p>
The sensor's housing is implicitely fixed.<br>
Since the machine's stator also implicitely fixed, the angle at the flange 
is equal to the angle of the machine's rotor against the stator.
</p>
</HTML>"));
    equation 
      connect(constant_.y, add.u2) annotation (points=[-29,40; -16,40; -16,32],
          style(color=3, rgbcolor={0,0,255}));
      connect(add.y, rotatorVS2R.angle) annotation (points=[-10,9; -10,2],
                                                 style(color=3, rgbcolor={0,0,255}));
      connect(ToSpacePhasorVS.y, rotatorVS2R.u) annotation (points=[-39,-10;
            -22,-10],                    style(color=3, rgbcolor={0,0,255}));
      connect(rotatorVS2R.y, ToPolarVSR.u) 
        annotation (points=[1,-10; 18,-10],
                                         style(color=3, rgbcolor={0,0,255}));
      connect(ToPolarVSR.y, deMultiplex2.u) 
        annotation (points=[41,-10; 58,-10],
                                         style(color=3, rgbcolor={0,0,255}));
      connect(plug_p, VoltageSensor1.plug_p) annotation (points=[-100,60; -80,
            60; -80,0],
                     style(color=3, rgbcolor={0,0,255}));
      connect(plug_n, VoltageSensor1.plug_n) annotation (points=[-100,-60; -80,
            -60; -80,-20],style(color=3, rgbcolor={0,0,255}));
      connect(VoltageSensor1.v, ToSpacePhasorVS.u) 
        annotation (points=[-69,-10; -62,-10],
                                             style(color=3, rgbcolor={0,0,255}));
      connect(deMultiplex2.y2[1], rotorAngle) annotation (points=[81,-16; 90,-16;
            90,0; 110,0], style(color=3, rgbcolor={0,0,255}));
      connect(relativeAngleSensor.phi_rel, add.u1) annotation (points=[30,69;
            30,40; -4,40; -4,32],
                           style(color=3, rgbcolor={0,0,255}));
      connect(relativeAngleSensor.flange_b, flange) annotation (points=[20,80;
            0,80; 0,100], style(color=0, rgbcolor={0,0,0}));
      connect(relativeAngleSensor.flange_a, adapter.flange_b) 
        annotation (points=[40,80; 60,80], style(color=0, rgbcolor={0,0,0}));
      connect(adapter.flange_a, support) annotation (points=[80,80; 100,80; 100,
            100], style(color=0, rgbcolor={0,0,0}));
    end RotorAngle;
  end Sensors;
  
  package SpacePhasors "Library with space phasor-models" 
    extends Modelica.Icons.Library2;
    annotation (Documentation(info="<HTML>
<p>
This package contains components, blocks and functions to utilize space phasor theory.
</p>

</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
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
</HTML>"), Icon(
        Line(points=[-8,-26; 64,46; 44,38; 56,26; 64,46], style(
            color=3,
            rgbcolor={0,0,255},
            thickness=2)),
        Line(points=[-8,-26; 64,-98; 56,-78; 44,-90; 64,-98], style(
            color=3,
            rgbcolor={0,0,255},
            thickness=2))));
    
    package Components "Basic space phasor models" 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<HTML>
<p>
This package contains basic space phasor models.<br>
Real and imaginary part of voltage space phasor are the potentials v_[2] of the space phasor connector; (implicit grounded).<br>
Real and imaginary part of current space phasor are the currents i_[2] at the space phasor connector;
a ground has to be used where necessary for currents flowing back.
</p>
</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>

  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.60 2005/11/03 Anton Haumer<br>
       added Rotator</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
</HTML>"));
      
      model SpacePhasor 
        "Physical transformation: three phase <-> space phasors" 
        constant Integer m=3 "number of phases";
        constant Real pi=Modelica.Constants.pi;
        Modelica.SIunits.Voltage v[m] "instantaneous phase voltages";
        Modelica.SIunits.Current i[m] "instantaneous phase currents";
      protected 
        parameter Real TransformationMatrix[ 2, m]=2/m*
          {{cos(+(k - 1)/m*2*pi) for k in 1:m}, {+sin(+(k - 1)/m*2*pi) for k in 1:m}};
        parameter Real InverseTransformation[m, 2]=
          {{cos(-(k - 1)/m*2*pi), -sin(-(k - 1)/m*2*pi)} for k in 1:m};
      public 
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m) 
          annotation (extent=[-110, 90; -90, 110]);
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m) 
          annotation (extent=[-110, -110; -90, -90]);
        Modelica.Electrical.Analog.Interfaces.PositivePin zero 
          annotation (extent=[90,-10; 110,10]);
        Modelica.Electrical.Analog.Interfaces.NegativePin ground 
          annotation (extent=[90, -110; 110, -90]);
        Modelica.Electrical.Analog.Basic.Ground gnd 
          annotation (extent=[60, -110; 80, -90]);
        annotation (
          Diagram,
          Icon(
            Line(points=[0, 0; 80, 80; 60, 72; 72, 60; 80, 80], style(color=3)),
            Line(points=[0, 0; 80, -80; 72, -60; 60, -72; 80, -80], style(color=
                   3)),
            Line(points=[-80, 0; -73.33, 10; -66.67, 17.32; -60, 20; -53.33,
                  17.32; -46.67, 10; -40, 0; -33.33, -10; -26.67, -17.32; -20,
                  -20; -13.33, -17.32; -6.67, -10; 0, 0], style(color=3)),
            Line(points=[-90, 0; -83.33, 10; -76.67, 17.32; -70, 20; -63.33,
                  17.32; -56.67, 10; -50, 0; -43.33, -10; -36.67, -17.32; -30,
                  -20; -23.33, -17.32; -16.67, -10; -10, 0], style(color=3)),
            Line(points=[-70, 0; -63.33, 10; -56.67, 17.32; -50, 20; -43.33,
                  17.32; -36.67, 10; -30, 0; -23.33, -10; -16.67, -17.32; -10,
                  -20; -3.33, -17.32; 3.33, -10; 10, 0], style(color=3)),
            Text(
              extent=[-150,-100; 150,-160],
              style(color=3, rgbcolor={0,0,255}),
              string="%name"),
            Text(
              extent=[40,10; 90,-10],
              style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=3,
                rgbfillColor={0,0,255},
                fillPattern=1),
              string="zero"),
            Line(points=[90,-100; 60,-100], style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=3,
                rgbfillColor={0,0,255},
                fillPattern=1)),
            Line(points=[60,-84; 60,-116], style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=3,
                rgbfillColor={0,0,255},
                fillPattern=1)),
            Line(points=[50,-90; 50,-110], style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=3,
                rgbfillColor={0,0,255},
                fillPattern=1)),
            Line(points=[40,-96; 40,-104], style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=3,
                rgbfillColor={0,0,255},
                fillPattern=1))),
          Documentation(info="<HTML>
<p>
Physical transformation of voltages and currents: three phases &lt;-&gt; space phasors:<br>
x[k] = X0 + {cos(-(k - 1)/m*2*pi),-sin(-(k - 1)/m*2*pi) * X[Re,Im]<br>
and vice versa:<br>
X0 = sum(x[k])/m<br>
X[Re,Im] = sum(2/m*{cos((k - 1)/m*2*pi),sin((k - 1)/m*2*pi)}*x[k])<br>
were x designates three phase values, X[Re,Im] designates the space phasor and X0 designates the zero sequence system.<br>
<i>Physcial transformation</i> means that both voltages and currents are transformed in both directions.<br>
Zero-sequence voltage and current are present at pin zero. An additional zero-sequence impedance could be connected between pin zero and pin ground.
</p>
</HTML>"));
        Interfaces.SpacePhasor spacePhasor annotation (extent=[90,90; 110,110]);
      equation 
        v = plug_p.pin.v - plug_n.pin.v;
        i = +plug_p.pin.i;
        i = -plug_n.pin.i;
        zero.v = 1/m*sum(v);
        spacePhasor.v_ = TransformationMatrix *v;
      //v  = fill(zero.v,m) + InverseTransformation*spacePhasor.v_;
        -zero.i = 1/m*sum(i);
        -spacePhasor.i_ = TransformationMatrix *i;
      //-i  = fill(zero.i,m) + InverseTransformation*spacePhasor.i_;
        connect(gnd.p, ground) annotation (points=[70,-90; 100,-90; 100,-100], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=3,
            rgbfillColor={0,0,255},
            fillPattern=1));
      end SpacePhasor;
      
      model Rotator "Rotates space phasor" 
        constant Real pi=Modelica.Constants.pi;
      protected 
        Real RotationMatrix[2,2] = {{+cos(-angle),-sin(-angle)},{+sin(-angle),+cos(-angle)}};
      //Real InverseRotator[2,2] = {{+cos(+angle),-sin(+angle)},{+sin(+angle),+cos(+angle)}};
      public 
        Interfaces.SpacePhasor spacePhasor_a annotation (extent=[-110,90; -90,
              110]);
        Interfaces.SpacePhasor spacePhasor_b annotation (extent=[90,90; 110,110]);
        Modelica.Blocks.Interfaces.RealInput angle(
            redeclare type SignalType = Modelica.SIunits.Angle) 
          annotation (extent=[-20,-140; 20,-100],rotation=-270);
        annotation (
          Diagram,
          Icon(
            Rectangle(extent=[50,-2; -2,-50],   style(
                pattern=0,
                fillColor=7,
                fillPattern=1)),
            Line(points=[0,0; 80,0; 60,10; 60,-10; 80,0],      style(color=3)),
            Line(points=[0,0; 0,80; -10,60; 10,60; 0,80],      style(color=3)),
            Polygon(points=[50,0; 42,14; 54,16; 50,0],     style(color=3,
                  fillColor=3)),
            Ellipse(extent=[-50,50; 50,-50],   style(color=3)),
            Rectangle(extent=[-50,50; -2,-50],   style(pattern=0, fillColor=7)),
            Rectangle(extent=[50,-2; -2,-50],   style(
                pattern=0,
                fillColor=7,
                fillPattern=1))),
          Documentation(info="<HTML>
<p>
Rotates space phasors of left connector to right connector by the angle provided by the input signal \"angle\" from one coordinate system into another.
</p>
</HTML>"));
      equation 
        spacePhasor_b.v_ = RotationMatrix*spacePhasor_a.v_;
      //spacePhasor_a.v_ = InverseRotator*spacePhasor_b.v_;
        spacePhasor_b.i_ = RotationMatrix*spacePhasor_a.i_;
      //spacePhasor_a.i_ = InverseRotator*spacePhasor_b.i_;
      end Rotator;
      
    end Components;
    
    package Blocks "Blocks for space phasor transformation" 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<HTML>
<p>
This package contains space phasor transformation blocks for use in controllers:
<ul>
<li>ToSpacePhasor: transforms a set of threephase values to space phasor and zero sequence system</li>
<li>FromSpacePhasor: transforms a space phasor and zero sequence system to a set of threephase values</li>
<li>Rotator: rotates a space phasor (from one coordinate system into another)</li>
<li>ToPolar: Converts a space phasor from rectangular coordinates to polar coordinates</li>
<li>FromPolar: Converts a space phasor from polar coordinates to rectangular coordinates</li>
</ul>
</p>

</HTML>", revisions="<HTML>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>

  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.30 2004/11/05 Anton Haumer<br>
       several improvements in SpacePhasors.Blocks</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
</HTML>"));
      
      block ToSpacePhasor "Conversion: three phase -> space phasor" 
        extends Modelica.Blocks.Interfaces.MIMO(final nin=m, final nout=2);
        constant Integer m=3 "number of phases";
        constant Real pi=Modelica.Constants.pi;
      protected 
        parameter Real TransformationMatrix[ 2, m]=2/m*
          {{cos(+(k - 1)/m*2*pi) for k in 1:m}, {+sin(+(k - 1)/m*2*pi) for k in 1:m}};
        parameter Real InverseTransformation[m, 2]=
          {{cos(-(k - 1)/m*2*pi), -sin(-(k - 1)/m*2*pi)} for k in 1:m};
      public 
        Modelica.Blocks.Interfaces.RealOutput zero 
          annotation (extent=[100,-70; 120,-90]);
        annotation (
          Diagram,
          Icon(
            Line(points=[0, 0; 80, 80; 60, 72; 72, 60; 80, 80], style(color=3)),
            Line(points=[0, 0; 80, -80; 72, -60; 60, -72; 80, -80], style(color=
                   3)),
            Line(points=[-80, 0; -73.33, 10; -66.67, 17.32; -60, 20; -53.33,
                  17.32; -46.67, 10; -40, 0; -33.33, -10; -26.67, -17.32; -20,
                  -20; -13.33, -17.32; -6.67, -10; 0, 0], style(color=3)),
            Line(points=[-90, 0; -83.33, 10; -76.67, 17.32; -70, 20; -63.33,
                  17.32; -56.67, 10; -50, 0; -43.33, -10; -36.67, -17.32; -30,
                  -20; -23.33, -17.32; -16.67, -10; -10, 0], style(color=3)),
            Line(points=[-70, 0; -63.33, 10; -56.67, 17.32; -50, 20; -43.33,
                  17.32; -36.67, 10; -30, 0; -23.33, -10; -16.67, -17.32; -10,
                  -20; -3.33, -17.32; 3.33, -10; 10, 0], style(color=3)),
            Text(
              extent=[-12,-74; 64,-86],
              string="zero",
              style(color=0, rgbcolor={0,0,0}))),
          Documentation(info="<HTML>
<p>
Transformation of threephase values (voltages or currents) to space phasor and zero sequence value.
</p>
</HTML>"));
      equation 
        zero = 1/m*sum(u);
        y = TransformationMatrix *u;
      //u = fill(zero,m) + InverseTransformation*y;
      end ToSpacePhasor;
      
      block FromSpacePhasor "Conversion: space phasor -> three phase" 
        extends Modelica.Blocks.Interfaces.MIMO(final nin=2, final nout=m);
        constant Integer m=3 "number of phases";
        constant Real pi=Modelica.Constants.pi;
      protected 
        parameter Real TransformationMatrix[ 2, m]=2/m*
          {{cos(+(k - 1)/m*2*pi) for k in 1:m}, {+sin(+(k - 1)/m*2*pi) for k in 1:m}};
        parameter Real InverseTransformation[m, 2]=
          {{cos(-(k - 1)/m*2*pi), -sin(-(k - 1)/m*2*pi)} for k in 1:m};
      public 
        Modelica.Blocks.Interfaces.RealInput zero 
          annotation (extent=[-140,-60; -100,-100]);
        annotation (
          Diagram,
          Icon(
            Line(points=[0, 0; -80, 80; -60, 72; -72, 60; -80, 80], style(color=
                   3)),
            Line(points=[0, 0; -80, -80; -72, -60; -60, -72; -80, -80], style(
                  color=3)),
            Line(points=[0, 0; 6.67, 10; 13.33, 17.32; 20, 20; 26.67, 17.32;
                  33.33, 10; 40, 0; 46.67, -10; 53.33, -17.32; 60, -20; 66.67,
                  -17.32; 73.33, -10; 80, 0], style(color=3)),
            Line(points=[-10, 0; -3.33, 10; 3.33, 17.32; 10, 20; 16.67, 17.32;
                  23.33, 10; 30, 0; 36.67, -10; 43.33, -17.32; 50, -20; 56.67,
                  -17.32; 63.33, -10; 70, 0], style(color=3)),
            Line(points=[10, 0; 16.67, 10; 23.33, 17.32; 30, 20; 36.67, 17.32;
                  43.33, 10; 50, 0; 56.67, -10; 63.33, -17.32; 70, -20; 76.67,
                  -17.32; 83.33, -10; 90, 0], style(color=3)),
            Text(
              extent=[-62,-74; 14,-86],
              string="zero",
              style(color=0, rgbcolor={0,0,0}))),
          Documentation(info="<HTML>
<p>
Transformation of space phasor and zero sequence value to threephase values (voltages or currents).
</p>
</HTML>"));
      equation 
        y = fill(zero,m) + InverseTransformation*u;
      //zero = 1/m*sum(y);
      //u = TransformationMatrix *y;
      end FromSpacePhasor;
      
      block Rotator "Rotates space phasor" 
        extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
      protected 
        Real RotationMatrix[2,2] = {{+cos(-angle),-sin(-angle)},{+sin(-angle),+cos(-angle)}};
      //Real InverseRotator[2,2] = {{+cos(+angle),-sin(+angle)},{+sin(+angle),+cos(+angle)}};
      public 
        Modelica.Blocks.Interfaces.RealInput angle(
            redeclare type SignalType = Modelica.SIunits.Angle) 
          annotation (extent=[-20,-140; 20,-100],rotation=-270);
        annotation (
          Diagram,
          Icon(
            Line(points=[0, 0; 0, 80; -10, 60; 10, 60; 0, 80], style(color=3)),
            Line(points=[0, 0; 80, 0; 60, 10; 60, -10; 80, 0], style(color=3)),
            Ellipse(extent=[-50, 50; 50, -50], style(color=3)),
            Rectangle(extent=[-50, 50; -2, -50], style(pattern=0, fillColor=7)),
            Rectangle(extent=[50, -2; -2, -50], style(
                pattern=0,
                fillColor=7,
                fillPattern=1)),
            Polygon(points=[50, 0; 42, 14; 54, 16; 50, 0], style(color=3,
                  fillColor=3)),
            Text(
              extent=[-88,-72; 84,-92],
              string="angle",
              style(color=0, rgbcolor={0,0,0}))),
          Documentation(info="<HTML>
<p>
Rotates a space phasor (voltage or current) by the angle provided by the input signal \"angle\" from one coordinate system into another.
</p>
</HTML>"));
      equation 
        y = RotationMatrix*u;
      //u = InverseRotator*y;
      end Rotator;
      
      block ToPolar "Converts a space phasor to polar coordinates" 
        extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
        constant Real small=Modelica.Constants.small;
        annotation (
          Diagram,
          Icon(
            Line(points=[-60, 60; -60, -60; 60, -60], style(color=3, rgbcolor={
                    0,0,255})),
            Line(points=[-100, -100; 100, 100], style(color=3, rgbcolor={0,0,
                    255})),
            Polygon(points=[26, 26; 14, 20; 20, 14; 26, 26], style(color=3,
                  rgbcolor={0,0,255})),
            Line(points=[-18, -18; -14, -22; -10, -28; -6, -34; -2, -44; 0, -52;
                   0, -60], style(color=3, rgbcolor={0,0,255})),
            Polygon(points=[-18, -18; -14, -26; -10, -22; -18, -18], style(
                  color=3, rgbcolor={0,0,255})),
            Text(
              extent=[-100, 100; -6, -6],
              style(color=3, rgbcolor={0,0,255}),
              string="R"),
            Text(
              extent=[6, 6; 100, -100],
              style(color=3, rgbcolor={0,0,255}),
              string="P")),
          Documentation(info="<HTML>
<p>
Converts a space phasor from rectangular coordinates to polar coordinates.
</p>
</HTML>"));
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
      end ToPolar;
      
      block FromPolar "Converts a space phasor from polar coordinates" 
        extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
        annotation (
          Diagram,
          Icon(
            Line(points=[-60, 60; -60, -60; 60, -60], style(color=3, rgbcolor={
                    0,0,255})),
            Line(points=[-100, -100; 100, 100], style(color=3, rgbcolor={0,0,
                    255})),
            Polygon(points=[26, 26; 14, 20; 20, 14; 26, 26], style(color=3,
                  rgbcolor={0,0,255})),
            Line(points=[-18, -18; -14, -22; -10, -28; -6, -34; -2, -44; 0, -52;
                   0, -60], style(color=3, rgbcolor={0,0,255})),
            Polygon(points=[-18, -18; -14, -26; -10, -22; -18, -18], style(
                  color=3, rgbcolor={0,0,255})),
            Text(
              extent=[-100, 100; -6, -6],
              style(color=3, rgbcolor={0,0,255}),
              string="P"),
            Text(
              extent=[6, 6; 100, -100],
              style(color=3, rgbcolor={0,0,255}),
              string="R")),
          Documentation(info="<HTML>
<p>
Converts a space phasor from polar coordinates to rectangular coordinates.
</p>
</HTML>"));
      equation 
        y = u[1]*{cos(u[2]),sin(u[2])};
      end FromPolar;
    end Blocks;
    
    package Functions "Functions for space phasor transformation" 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<HTML>
<p>
This package contains space phasor transformation functions for use in calculations:
<ul>
<li>ToSpacePhasor: transforms a set of threephase values to space phasor and zero sequence system</li>
<li>FromSpacePhasor: transforms a space phasor and zero sequence system to a set of threephase values</li>
<li>Rotator: rotates a space phasor (from one coordinate system into another)</li>
<li>ToPolar: Converts a space phasor from rectangular coordinates to polar coordinates</li>
<li>FromPolar: Converts a space phasor from polar coordinates to rectangular coordinates</li>
</p>

</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  </ul>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>

  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
</HTML>"));
      
      function ToSpacePhasor "Conversion: three phase -> space phasor" 
        extends Modelica.Icons.Function;
        constant Integer m=3 "number of phases";
        constant Real pi=Modelica.Constants.pi;
        input Real x[3];
        output Real y[2];
        output Real y0;
        annotation (Documentation(info="<HTML>
<p>
Transformation of three phase values (voltages or currents) to space phasor and zero sequence value:<br>
y[k] = X0 + {cos(-(k - 1)/m*2*pi),-sin(-(k - 1)/m*2*pi) * X[Re,Im]<br>
were y designates three phase values, X[Re,Im] designates the space phasor and X0 designates the zero sequence system.
</p>
</HTML>"));
      algorithm 
        y := zeros(2);
        for k in 1:m loop
          y := y + 2/m*{+cos((k - 1)/m*2*pi), +sin(+(k - 1)/m*2*pi)}*x[k];
        end for;
        y0 := 1/m*sum(x);
      end ToSpacePhasor;
      
      function FromSpacePhasor "Conversion: space phasor -> three phase" 
        extends Modelica.Icons.Function;
        constant Integer m=3 "number of phases";
        constant Real pi=Modelica.Constants.pi;
        input Real x[2];
        input Real x0;
        output Real y[3];
        annotation (Documentation(info="<HTML>
<p>
Transformation of space phasor and zero sequence value to three phase values (voltages or currents):<br>
Y0 = sum(x[k])/m<br>
Y[Re,Im] = sum(2/m*{cos((k - 1)/m*2*pi),sin((k - 1)/m*2*pi)}*x[k])<br>
were x designates three phase values, Y[Re,Im] designates the space phasor and Y0 designates the zero sequence system.
</p>
</HTML>"));
      algorithm 
        for k in 1:m loop
          y[k] := x0 + {cos(-(k - 1)/m*2*pi),-sin(-(k - 1)/m*2*pi)}*x;
        end for;
      end FromSpacePhasor;
      
      function Rotator "Rotates space phasor" 
        extends Modelica.Icons.Function;
        input Real x[2];
        input Modelica.SIunits.Angle angle;
        output Real y[2];
      protected 
        Real RotationMatrix[2,2] = {{+cos(-angle),-sin(-angle)},{+sin(-angle),+cos(-angle)}};
        annotation (Documentation(info="<HTML>
<p>
Rotates a space phasor (voltage or current) by the angle provided by input argument \"angle\" from one coordinate system into another:<br>
y[Re,Im] := {{+cos(-angle),-sin(-angle)},{+sin(-angle),+cos(-angle)}}*x[Re,Im]<br>
where y[Re,Im] designates the space phasor in the new coordinate system (twisted by angle against old coordinate system) and y[Re,Im] designates the space phasor in the old coordinate system.
</p>
</HTML>"));
      algorithm 
        y := RotationMatrix*x;
      end Rotator;
      
      function ToPolar "Converts a space phasor to polar coordinates" 
        extends Modelica.Icons.Function;
        constant Real small=Modelica.Constants.small;
        input Real x[2];
        output Real absolute;
        output Modelica.SIunits.Angle angle;
        annotation (Documentation(info="<HTML>
<p>
Converts a space phasor from rectangular coordinates to polar coordinates, providing angle=0 for {0,0}.
</p>
</HTML>"));
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
      end ToPolar;
      
      function FromPolar "Converts a space phasor from polar coordinates" 
        extends Modelica.Icons.Function;
        constant Real pi=Modelica.Constants.pi;
        constant Real small=Modelica.Constants.small;
        input Real absolute;
        input Modelica.SIunits.Angle angle;
        output Real x[2];
        annotation (Documentation(info="<HTML>
<p>
Converts a space phasor from polar coordinates to rectangular coordinates.
</p>
</HTML>"));
      algorithm 
        x := absolute*{cos(angle),sin(angle)};
      end FromPolar;
    end Functions;
  end SpacePhasors;
  
  package Interfaces "SpacePhasor connector and PartialMachines" 
    extends Modelica.Icons.Library2;
    annotation (Documentation(info="<HTML>
<p>
This package contains the space phasor connector and partial models for machine models.
</p>

</HTML>", revisions="<HTML>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
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
  </ul>
</HTML>"), Icon(Polygon(points=[-70,-30; -10,30; 50,-30; -10,-90; -70,-30],
            style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=3,
            rgbfillColor={0,0,255},
            fillPattern=1))));
    
    connector SpacePhasor "Connector for Space Phasors" 
      Modelica.SIunits.Voltage v_[2];
      flow Modelica.SIunits.Current i_[2];
      annotation (Diagram(Polygon(points=[0,100; -100,0; 0,-100; 100,0; 0,100],
              style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})), Text(
            extent=[-150,-90; 150,-150],
            style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1),
            string="%name")),            Icon(Polygon(points=[0,100; -100,0; 0,-100;
                100,0; 0,100], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255}))),
        Documentation(info="<HTML>
<p>
Connector for Space Phasors:
<ul>
<li>Voltage v_[2] ... Real and Imaginary part of voltage space phasor</li>
<li>Current i_[2] ... Real and Imaginary part of current space phasor</li>
</ul>
</p>
</HTML>"));
    end SpacePhasor;
    
    model Adapter 
      "from Modelica.Mechanics.Rotational.Interfaces.TwoFlangesAndBearingH" 
      extends Modelica.Mechanics.Rotational.Interfaces.TwoFlanges;
      parameter Boolean bearingConnected;
      annotation (Icon(Rectangle(extent=[-90, 10; 90, -10], style(color=8,
                fillColor=8)), Text(extent=[0, 60; 0, 20], string="%name")));
    equation 
      flange_a.phi = flange_b.phi;
      if bearingConnected then
        0 = flange_a.tau + flange_b.tau;
      else
        0 = flange_a.phi;
      end if;
    end Adapter;
    
    partial model PartialBasicMachine "Partial model for all machines" 
      parameter Modelica.SIunits.Inertia J_Rotor "rotor's moment of inertia";
      parameter Modelica.SIunits.Inertia J_Stator=J_Rotor 
        "stator's moment of inertia";
      output Modelica.SIunits.Angle phi_mechanical = flange_a.phi-support.phi 
        "mechanical angle of rotor against stator";
      output Modelica.SIunits.AngularVelocity w_mechanical = der(phi_mechanical) 
        "mechanical angular velocity of rotor against stator";
      output Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm 
        rpm_mechanical = Modelica.SIunits.Conversions.to_rpm(w_mechanical) 
        "mechanical speed of rotor against stator [rpm]";
      output Modelica.SIunits.Torque tau_electrical = inertiaRotor.flange_a.tau 
        "electromagnetic torque";
      output Modelica.SIunits.Torque tau_shaft = -flange_a.tau "shaft torque";
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
        annotation (extent=[90,-10; 110,10]);
      Modelica.Mechanics.Rotational.Inertia inertiaRotor(final J=J_Rotor) 
        annotation (extent=[80,10; 60,-10],   rotation=-180);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a support 
        "support at which the reaction torque is acting" 
           annotation (extent=[90,-110; 110,-90]);
      Modelica.Mechanics.Rotational.Inertia inertiaStator(final J=J_Stator) 
        annotation (extent=[80,-90; 60,-110], rotation=-180);
    protected 
      Machines.Interfaces.Adapter adapter(final bearingConnected=cardinality(support) > 1) 
        annotation (extent=[30,-90; 50,-110],   rotation=180);
      Modelica.Mechanics.Rotational.Interfaces.Flange_b internalSupport 
        annotation (extent=[19,-101; 21,-99]);
      annotation (
        Icon(
          Rectangle(extent=[-40,60; 80,-60],    style(
              color=3,
              rgbcolor={0,0,255},
              gradient=2,
              fillColor=69,
              rgbfillColor={0,128,255})),
          Rectangle(extent=[-40,60; -60,-60],    style(
              color=10,
              gradient=2,
              fillColor=10)),
          Rectangle(extent=[80,10; 100,-10], style(
              color=10,
              rgbcolor={95,95,95},
              gradient=2,
              fillColor=10,
              rgbfillColor={95,95,95})),
          Rectangle(extent=[-40,70; 40,50], style(
              color=10,
              rgbcolor={95,95,95},
              fillColor=10,
              rgbfillColor={95,95,95})),
      Polygon(points=[-50,-90; -40,-90; -10,-20; 40,-20; 70,-90; 80,-90; 80,-100;
                -50,-100; -50,-90],               style(
          color=0,
          gradient=0,
          fillColor=0,
          fillPattern=1)),
          Text(
            extent=[-150,-120; 150,-180],
            style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=10,
              rgbfillColor={95,95,95},
              fillPattern=1),
            string="%name"),
          Rectangle(extent=[80,-80; 120,-120],   style(color=8, fillColor=8))),
        Documentation(info="<HTML>
<p>
Base partial model DC machines:
<ul>
<li>main parts of the icon</li>
<li>mechanical flange</li>
<li>mechanical support</li>
</ul>
<p>
Besides the mechanical connector <i>flange_a</i> (i.e. the shaft) the machines have a second mechanical connector <i>support</i>.<br>
If nothing is connected to <i>support</i>, it is assumed that the stator is fixed.<br>
Otherwise reaction torque (i.e. airGap torque, minus acceleration torque for stator's moment of inertia) can be measured at <i>support</i>.<br>
One may also fix the the shaft and let rotate the stator; parameter Js is only of importance when the stator is rotating.<br>
<b>Take care:</b> Even if You connect only a sensor (e.g. Modelica.Mechanics.Rotational.Sensors.RelAngleSensor or Machines.Sensors.RotorDisplacementAngle) to the <i>support</i>, You have to fix the <i>support</i>!
</p>
</p>
</HTML>"),
        Diagram);
    equation 
      connect(inertiaRotor.flange_b, flange_a) annotation (points=[80,
            1.22461e-015; 92,1.22461e-015; 92,0; 100,0],
                                           style(color=0, rgbcolor={0,0,0}));
      connect(inertiaStator.flange_b, support) 
        annotation (points=[80,-100; 100,-100], style(color=0, rgbcolor={0,0,0}));
      connect(adapter.flange_a, inertiaStator.flange_a) annotation (points=[50,-100;
            60,-100],
                   style(color=0, rgbcolor={0,0,0}));
      connect(adapter.flange_b, internalSupport) 
        annotation (points=[30,-100; 20,-100], style(color=0, rgbcolor={0,0,0}));
    end PartialBasicMachine;
    
    partial model PartialBasicInductionMachine 
      "Partial model for induction machine" 
      extends PartialBasicMachine(J_Rotor=0.29);
      constant Real pi=Modelica.Constants.pi;
      constant Integer m=3 "number of phases";
      parameter Integer p(min=1)=2 "number of pole pairs (Integer)";
      output Modelica.SIunits.Voltage vs[m] = plug_sp.pin.v - plug_sn.pin.v 
        "stator instantaneous voltages";
      output Modelica.SIunits.Current is[m] = plug_sp.pin.i 
        "stator instantaneous currents";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m) 
        annotation (extent=[50,90; 70,110]);
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m) 
        annotation (extent=[-70,90; -50,110]);
      annotation (Documentation(info="<HTML>
<p>
Partial model for induction machine models, containing:
<ul>
<li>main parts of the icon</li>
<li>stator plugs</li>
<li>mechanical connectors</li>
</ul>
</p>
</HTML>"),
        Diagram,
        Icon(Line(points=[-50,100; -20,100; -20,70], style(color=3, rgbcolor={0,
                  0,255})), Line(points=[50,100; 20,100; 20,70], style(color=3,
                rgbcolor={0,0,255}))));
    end PartialBasicInductionMachine;
    
    partial model PartialBasicDCMachine "Partial model for DC machine" 
      extends PartialBasicMachine(J_Rotor=0.15);
      output Modelica.SIunits.Voltage va = pin_ap.v-pin_an.v "armature voltage";
      output Modelica.SIunits.Current ia = pin_ap.i "armature current";
      annotation (Documentation(info="<HTML>
<p>
Partial model for DC machine models, containing:
<ul>
<li>main parts of the icon</li>
<li>armature pins</li>
<li>mechanical connectors</li>
</ul>
</p>
</HTML>"),
        Diagram,
        Icon(Line(points=[-50,100; -20,100; -20,70], style(color=3, rgbcolor={0,
                  0,255})), Line(points=[50,100; 20,100; 20,70], style(color=3,
                rgbcolor={0,0,255}))));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap 
        annotation (extent=[50,110; 70,90]);
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_an 
        annotation (extent=[-70,110; -50,90]);
    end PartialBasicDCMachine;
    
  end Interfaces;
end Machines;
