package Machines "Library for electric machines" 
  extends Modelica.Icons.Library;
  import Modelica.Electrical.MultiPhase;
  annotation (version="1.01", versionDate="2004-09-18",
  Settings(NewStateSelection=true, Evaluate=true),
  Documentation(info="<HTML>
<p>
This package contains components to model electrical machines:
<ul>
<li>Examples: test examples</li>
<li>Auxiliary: auxiliary components for testing examples</li>
<li>Interfaces: Space phasor connector and partial machine models</li>
<li>Basic: machine models</li>
<li>SpacePhasors: an independent library for using space phasors</li>
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
  <li> v1.01 2004/09/18 Anton Haumer<br>
       moved common equations from machine models to PartialMachine<br>
       improved MoveToRotational</li>
  </ul>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
  
package MoveToRotational 
  annotation (uses(Modelica(version="2.1 Beta1")), Documentation(info="<HTML>
<p>
Components that are usefull to model mechanical load of electrical machines.<br>
Will be moved to Modelica.Mechanical.Rotational.
</p>
</HTML>"));
    
  partial model PartialSpeedDependentTorque 
      "Partial model of a torque acting at the flange (accelerates the flange)" 
    Modelica.SIunits.AngularVelocity w = der(flange.phi) 
        "Angular velocity at flange";
    Modelica.SIunits.Torque tau = flange.tau 
        "accelerating torque acting at flange";
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange 
        "Flange on which torque is acting" 
      annotation (extent=[-120,-10; -100,10]);
    Modelica.Mechanics.Rotational.Interfaces.Flange_a bearing 
        "Bearing at which the reaction torque (i.e., -flange.tau) is acting" 
         annotation (extent=[-10,-130; 10,-110]);
    annotation (
      Diagram,
      Icon(
        Rectangle(extent=[-96,96; 96,-96], style(
            color=7,
            rgbcolor={255,255,255},
            fillColor=7,
            rgbfillColor={255,255,255})),
        Line(points=[-30,-70; 30,-70],   style(color=0)),
        Line(points=[-30,-90; -10,-70],   style(color=0)),
        Line(points=[-10,-90; 10,-70],   style(color=0)),
        Rectangle(extent=[-20,-100; 20,-140],  style(color=8, fillColor=8)),
        Line(points=[10,-90; 30,-70],   style(color=0)),
        Line(points=[0,-70; 0,-110],  style(color=0)),
        Line(points=[-70,40; -60,56; -44,74; -16,88; 18,92; 48,86; 74,70; 90,48;
              100,20], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Polygon(points=[-100,0; -54,32; -86,54; -100,0], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Text(
          extent=[-162,162; 162,98],
          style(color=3, rgbcolor={0,0,255}),
          string="%name")),
      Documentation(info="<HTML>
<p>
Partial model of torque dependent on speed that accelerates the flange.
</p>
</HTML>"));
  equation 
    if cardinality(bearing) == 0 then
      bearing.phi = 0;
    else
      bearing.tau = -flange.tau;
    end if;
  end PartialSpeedDependentTorque;
    
  model LinearSpeedDependentTorque "Linear dependency of torque versus speed" 
    extends PartialSpeedDependentTorque;
    parameter Modelica.SIunits.Torque tau_nominal "nominal torque";
    parameter Modelica.SIunits.AngularVelocity w_nominal(min=Modelica.Constants.eps) 
        "nominal speed";
    annotation (
      Diagram,
      Icon(Line(points=[-100, -100; 100, 100], style(color=3))),
      Documentation(info="<HTML>
<p>
Model of torque, linearly dependent on angular velocity of flange.<br>
Torque acts accelerating in both directions of rotation.
</p>
</HTML>"));
  equation 
    tau = -tau_nominal*(w/w_nominal);
  end LinearSpeedDependentTorque;
    
  model QuadraticSpeedDependentTorque 
      "Quadratic dependency of torque versus speed" 
    extends PartialSpeedDependentTorque;
    parameter Modelica.SIunits.Torque tau_nominal "nominal torque";
    parameter Modelica.SIunits.AngularVelocity w_nominal(min=Modelica.Constants.eps) 
        "nominal speed";
    annotation (
      Diagram,
      Icon(Line(points=[-100, -100; -80, -98; -60, -92; -40, -82; -20, -68; 0,
               -50; 20, -28; 40, -2; 60, 28; 80, 62; 100, 100], style(color=3))),
      Documentation(info="<HTML>
<p>
Model of torque, quadratic dependent on angular velocity of flange.<br>
Torque acts accelerating in both directions of rotation.
</p>
</HTML>"));
  equation 
    tau = -tau_nominal*smooth(1,if w >= 0 then (w/w_nominal)^2 else -(w/w_nominal^2));
  end QuadraticSpeedDependentTorque;
    
  model ConstantTorque "Constant torque, not dependent on speed" 
    extends PartialSpeedDependentTorque;
    parameter Modelica.SIunits.Torque tau_constant "constant torque";
    annotation (
      Diagram,
      Icon(Line(points=[-98,0; 100,0], style(color=3))),
      Documentation(info="<HTML>
<p>
Model of constant torque, not dependent on angular velocity of flange.<br>
Torque acts accelerating.
</p>
</HTML>"));
  equation 
    tau = -tau_constant;
  end ConstantTorque;
    
  model ConstantSpeed "Constant speed, not dependent on torque" 
    extends PartialSpeedDependentTorque;
    parameter Modelica.SIunits.AngularVelocity w_fixed "fixed speed";
    annotation (
      Diagram,
      Icon(Line(points=[0,-100; 0,100], style(color=3))),
      Documentation(info="<HTML>
<p>
Model of <b>fixed</b> angular verlocity of flange, not dependent on torque.
</p>
</HTML>"));
  equation 
    w = w_fixed;
  end ConstantSpeed;
end MoveToRotational;
  
  package Examples "Test examples" 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains test examples of electric machines.
</p>
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
  <li> v1.01 2004/09/18 Anton Haumer<br>
       adapted to improved MoveToRotational</li>
  </ul>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
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
      output Modelica.SIunits.Current i_ss_magnitude =  SpacePhasors.Functions.ToPolar(AIMC1.idq_ss) 
        "Stator current magnitude";
      output Modelica.SIunits.Current i_rr_magnitude =  SpacePhasors.Functions.ToPolar(AIMC1.idq_rr) 
        "Rotor current magnitude";
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
Default machine parameters of model <i>AsynchronousInductionMachineSquirrelCage</i> are used.
</p>
</HTML>"));
      MultiPhase.Sources.SineVoltage SineVoltage1(
        final m=m,
        freqHz=fill(fNominal, m),
        V=fill(sqrt(2/3)*VNominal, m)) 
        annotation (extent=[-10, 80; -30, 60], rotation=-90);
      MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Modelica.Blocks.Sources.BooleanStep BooleanStep1[m](each startTime=tStart1) 
        annotation (extent=[-80, 30; -60, 50]);
      MultiPhase.Ideal.IdealClosingSwitch IdealCloser1(final m=m) 
        annotation (extent=[-10, 30; -30, 50], rotation=-90);
      MultiPhase.Basic.Delta Delta1(final m=m) 
        annotation (extent=[-20,-10; -40,10]);
      Machines.Basic.AsynchronousInductionMachineSquirrelCage AIMC1 
        annotation (extent=[-40, -30; -20, -10], rotation=0);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[20,-30; 40,-10]);
      MoveToRotational.QuadraticSpeedDependentTorque QuadraticLoadTorque1(
                    w_nominal=Modelica.SIunits.Conversions.from_rpm(rpmLoad),
          tau_nominal=-T_Load) 
        annotation (extent=[50,-30; 70,-10]);
    equation 
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(SineVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-20, 80; -20, 90; -50, 90], style(color=3));
      connect(SineVoltage1.plug_p, IdealCloser1.plug_p) 
        annotation (points=[-20, 60; -20, 50], style(color=3));
      connect(IdealCloser1.plug_n, Delta1.plug_p) annotation (points=[-20,30; -20,0],
                     style(color=3, rgbcolor={0,0,255}));
      connect(AIMC1.flange_a, LoadInertia.flange_a)  annotation (points=[-20,-20; 20,
            -20],    style(color=0, rgbcolor={0,0,0}));
      connect(LoadInertia.flange_b, QuadraticLoadTorque1.flange) 
        annotation (points=[40,-20; 49,-20], style(color=0, rgbcolor={0,0,0}));
      connect(AIMC1.plug_sn, Delta1.plug_n)  annotation (points=[-36,-10; -40,-10; -40,
            0], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={95,95,95},
          fillPattern=1));
      connect(AIMC1.plug_sp, Delta1.plug_p)  annotation (points=[-24,-10; -20,-10;
            -20,0], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={95,95,95},
          fillPattern=1));
      connect(BooleanStep1.y, IdealCloser1.control) annotation (points=[-59,40;
            -27,40], style(color=5, rgbcolor={255,0,255}));
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
      output Modelica.SIunits.Current i_ss_magnitude = SpacePhasors.Functions.ToPolar(AIMC1.idq_ss) 
        "Stator current magnitude";
      output Modelica.SIunits.Current i_rr_magnitude = SpacePhasors.Functions.ToPolar(AIMC1.idq_rr) 
        "Rotor current magnitude";
      annotation (
        Diagram,
        experiment(StopTime=2.5, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>2nd Test example: Asynchronous induction Machine with squirrel cage - Y-D starting</b><br>
At start time tStart three phase voltage is supplied to the asynchronous induction machine with squirrel cage, first star-connected, then delta-connetced; the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Default machine parameters of model <i>AsynchronousInductionMachineSquirrelCage</i> are used.
</p>
</HTML>"));
      MultiPhase.Sources.SineVoltage SineVoltage1(
        final m=m,
        freqHz=fill(fNominal, m),
        V=fill(sqrt(2/3)*VNominal, m)) 
        annotation (extent=[-10, 80; -30, 60], rotation=-90);
      MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Modelica.Blocks.Sources.BooleanStep BooleanStep1[m](each startTime=tStart1) 
        annotation (extent=[-80, 30; -60, 50]);
      MultiPhase.Ideal.IdealClosingSwitch IdealCloser1(final m=m) 
        annotation (extent=[-10, 30; -30, 50], rotation=-90);
      Machines.Basic.AsynchronousInductionMachineSquirrelCage AIMC1 
        annotation (extent=[-40, -30; -20, -10], rotation=0);
      Auxiliary.SwitchYD SwitchYD1 annotation (extent=[-40, 0; -20, 20]);
      Modelica.Blocks.Sources.BooleanStep BooleanStep2[m](each startTime=tStart2) 
        annotation (extent=[-80, 0; -60, 20]);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[20,-30; 40,-10]);
      MoveToRotational.QuadraticSpeedDependentTorque QuadraticLoadTorque1(
                    w_nominal=Modelica.SIunits.Conversions.from_rpm(rpmLoad),
          tau_nominal=-T_Load) 
        annotation (extent=[50,-30; 70,-10]);
    equation 
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(SineVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-20, 80; -20, 90; -50, 90], style(color=3));
      connect(SineVoltage1.plug_p, IdealCloser1.plug_p) 
        annotation (points=[-20, 60; -20, 50], style(color=3));
      connect(IdealCloser1.plug_n, SwitchYD1.plug_P) annotation (points=[-20,
            30; -20, 20], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(SwitchYD1.pug_PS, AIMC1.plug_sp)  annotation (points=[-20,0; -20,
            -10; -24,-10],
                   style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(SwitchYD1.plug_NS, AIMC1.plug_sn)  annotation (points=[-40,0; -40,
            -10; -36,-10],
                   style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(AIMC1.flange_a, LoadInertia.flange_a)  annotation (points=[-20,-20;
            20,-20], style(color=0, rgbcolor={0,0,0}));
      connect(LoadInertia.flange_b, QuadraticLoadTorque1.flange) 
        annotation (points=[40,-20; 49,-20], style(color=0, rgbcolor={0,0,0}));
      connect(BooleanStep1.y, IdealCloser1.control) annotation (points=[-59,40; -27,
            40], style(color=5, rgbcolor={255,0,255}));
      connect(BooleanStep2.y, SwitchYD1.control) annotation (points=[-59,10;
            -41,10], style(color=5, rgbcolor={255,0,255}));
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
      output Modelica.SIunits.Current i_ss_magnitude = SpacePhasors.Functions.ToPolar(AIMS1.idq_ss) 
        "Stator current magnitude";
      output Modelica.SIunits.Current i_rr_magnitude =  SpacePhasors.Functions.ToPolar(AIMS1.idq_rr) 
        "Rotor current magnitude";
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
Default machine parameters of model <i>AsynchronousInductionMachineSlipRing</i> are used.
</p>
</HTML>"));
      MultiPhase.Sources.SineVoltage SineVoltage1(
        final m=m,
        freqHz=fill(fNominal, m),
        V=fill(sqrt(2/3)*VNominal, m)) 
        annotation (extent=[10,80; -10,60],    rotation=-90);
      MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Modelica.Blocks.Sources.BooleanStep BooleanStep1[m](each startTime=tStart1) 
        annotation (extent=[-80, 30; -60, 50]);
      MultiPhase.Ideal.IdealClosingSwitch IdealCloser1(final m=m) 
        annotation (extent=[10,30; -10,50],    rotation=-90);
      MultiPhase.Basic.Delta Delta1(final m=m) 
        annotation (extent=[0,-10; -20,10]);
      Machines.Basic.AsynchronousInductionMachineSlipRing AIMS1 
        annotation (extent=[-20,-30; 0,-10],     rotation=0);
      MultiPhase.Basic.Star Star3(final m=m) 
        annotation (extent=[-50,-80; -70,-60]);
      Modelica.Electrical.Analog.Basic.Ground Ground3 
        annotation (extent=[-100,-80; -80,-60],   rotation=-90);
      MultiPhase.Ideal.IdealCommutingSwitch IdealCommutingSwitch1(m=m) 
        annotation (extent=[-30,-30; -50,-10],   rotation=-90);
      MultiPhase.Basic.Resistor Resistor1(m=m, R=fill(Rstart, m)) 
        annotation (extent=[-50,-60; -70,-40]);
      MultiPhase.Basic.Star Star4(final m=m) 
        annotation (extent=[-80,-60; -100,-40]);
      Modelica.Blocks.Sources.BooleanStep BooleanStep2[m](each startTime=tStart2) 
        annotation (extent=[-100,-30; -80,-10]);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[40,-30; 60,-10]);
      MoveToRotational.QuadraticSpeedDependentTorque QuadraticLoadTorque1(
                    w_nominal=Modelica.SIunits.Conversions.from_rpm(rpmLoad),
          tau_nominal=-T_Load) 
        annotation (extent=[70,-30; 90,-10]);
    equation 
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(SineVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-6.12303e-016,80; -6.12303e-016,90; -50,90],
                                                        style(color=3));
      connect(SineVoltage1.plug_p, IdealCloser1.plug_p) 
        annotation (points=[6.12303e-016,60; 0,58; 1.22461e-015,56;
            6.12303e-016,56; 6.12303e-016,50], style(color=3));
      connect(Star3.pin_n, Ground3.p) 
        annotation (points=[-70,-70; -80,-70],   style(color=3));
      connect(Star4.plug_p, Resistor1.plug_n) annotation (points=[-80,-50; -70,
            -50],  style(
          color=3,
          rgbcolor={0,0,255},
          gradient=2,
          fillColor=69,
          rgbfillColor={0,128,255}));
      connect(Resistor1.plug_p, IdealCommutingSwitch1.plug_n1) annotation (
          points=[-50,-50; -45,-50; -45,-30],    style(
          color=3,
          rgbcolor={0,0,255},
          gradient=2,
          fillColor=69,
          rgbfillColor={0,128,255}));
      connect(AIMS1.plug_rn, Star3.plug_p)  annotation (points=[-20,-26; -20,
            -70; -50,-70],
           style(color=3, rgbcolor={0,0,255}));
      connect(Delta1.plug_n, AIMS1.plug_sn)  annotation (points=[-20,0; -20,-10;
            -16,-10],
           style(color=3, rgbcolor={0,0,255}));
      connect(Delta1.plug_p, AIMS1.plug_sp)  annotation (points=[0,0; 0,-10; -4,
            -10],
           style(color=3, rgbcolor={0,0,255}));
      connect(IdealCloser1.plug_n, Delta1.plug_p) annotation (points=[
            -6.12303e-016,30; -6.12303e-016,16; 0,16; 0,0],
                     style(color=3, rgbcolor={0,0,255}));
      connect(IdealCommutingSwitch1.plug_n2, AIMS1.plug_rn)  annotation (points=[
            -40,-30; -28,-30; -28,-26; -20,-26],
                                            style(color=3, rgbcolor={0,0,255}));
      connect(LoadInertia.flange_b, QuadraticLoadTorque1.flange) 
        annotation (points=[60,-20; 69,-20], style(color=0, rgbcolor={0,0,0}));
      connect(AIMS1.flange_a, LoadInertia.flange_a)  annotation (points=[0,-20;
            40,-20],
                  style(color=0, rgbcolor={0,0,0}));
      connect(IdealCommutingSwitch1.plug_p, AIMS1.plug_rp)  annotation (points=
            [-40,-10; -30,-10; -30,-14; -20,-14], style(color=3, rgbcolor={0,0,
              255}));
      connect(BooleanStep1.y, IdealCloser1.control) annotation (points=[-59,40;
            -7,40], style(color=5, rgbcolor={255,0,255}));
      connect(BooleanStep2.y, IdealCommutingSwitch1.off) annotation (points=[
            -79,-20; -48,-20], style(color=5, rgbcolor={255,0,255}));
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
      output Modelica.SIunits.Current i_ss_magnitude = SpacePhasors.Functions.ToPolar(AIMC1.idq_ss) 
        "Stator current magnitude";
      output Modelica.SIunits.Current i_rr_magnitude = SpacePhasors.Functions.ToPolar(AIMC1.idq_rr) 
        "Rotor current magnitude";
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
Default machine parameters of model <i>AsynchronousInductionMachineSquirrelCage</i> are used.
</p>
</HTML>"));
      Modelica.Blocks.Sources.Ramp Ramp1(height=f, duration=tRamp) 
        annotation (extent=[-100, 50; -80, 70]);
      Auxiliary.VfController VfController1(
        final m=m,
        VNominal=VNominal,
        fNominal=fNominal) annotation (extent=[-60, 50; -40, 70]);
      MultiPhase.Sources.SignalVoltage SignalVoltage1(final m=m) 
        annotation (extent=[-10, 70; -30, 50], rotation=-90);
      MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Machines.Basic.AsynchronousInductionMachineSquirrelCage AIMC1 
        annotation (extent=[-40, -30; -20, -10], rotation=0);
      MultiPhase.Basic.Star Star2(final m=m) 
        annotation (extent=[-50, -20; -70, 0]);
      Modelica.Blocks.Sources.Step Step1(height=-T_Load, startTime=tStep) 
        annotation (extent=[50,0; 70,20]);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[20,-30; 40,-10]);
      Modelica.Mechanics.Rotational.Torque Torque1 
        annotation (extent=[70,-30; 50,-10]);
    equation 
      connect(SignalVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-20, 70; -20, 90; -50, 90], style(color=3));
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(SignalVoltage1.plug_p, AIMC1.plug_sp)  annotation (points=[-20,50;
            -20,-10; -24,-10],
                        style(color=3, rgbcolor={0,0,255}));
      connect(AIMC1.plug_sn, Star2.plug_p)  annotation (points=[-36,-10; -50,
            -10],
           style(color=3, rgbcolor={0,0,255}));
      connect(AIMC1.flange_a, LoadInertia.flange_a)  annotation (points=[-20,
            -20; 20,-20],
                     style(color=0, rgbcolor={0,0,0}));
      connect(LoadInertia.flange_b, Torque1.flange_b) 
        annotation (points=[40,-20; 50,-20], style(color=0, rgbcolor={0,0,0}));
      connect(Ramp1.y, VfController1.u) annotation (points=[-79,60; -62,60], style(
            color=3, rgbcolor={0,0,255}));
      connect(VfController1.y, SignalVoltage1.v) annotation (points=[-39,60;
            -27,60], style(color=3, rgbcolor={0,0,255}));
      connect(Step1.y, Torque1.tau) annotation (points=[71,10; 80,10; 80,-20;
            72,-20], style(color=3, rgbcolor={0,0,255}));
    end AIMC_Inverter;
    
    model AIMR_Inverter 
      "Test example 5: AsynchronousInductionMachineReluctanceRotor with inverter" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "number of phases";
      parameter Real p=2 "number of pole pairs";
      parameter Modelica.SIunits.Voltage VNominal=100 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Frequency f=50 "actual frequency";
      parameter Modelica.SIunits.Time tRamp=1 "frequency ramp";
      parameter Modelica.SIunits.Torque T_Load=43.3 "nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.2 "time of load torque step";
      parameter Modelica.SIunits.Inertia J_Load=0.29 "load's moment of inertia";
      output Modelica.SIunits.Angle theta = RotorAngle1.y "Rotor angle";
      output Modelica.SIunits.Current i_ss_magnitude = SpacePhasors.Functions.ToPolar(AIMR1.idq_ss) 
        "Stator current magnitude";
      output Modelica.SIunits.Current i_rr_magnitude = SpacePhasors.Functions.ToPolar(AIMR1.idq_rr) 
        "Rotor current magnitude";
      annotation (
        Diagram,
        experiment(StopTime=1.5, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>5th Test example: Asynchronous induction Machine with reluctance rotor fed by an ideal inverter</b><br>
An ideal frequency inverter is modeled by using a VfController and a threephase SignalVoltage.<br>
Frequency is raised by a ramp, causing the reluctance machine to start, 
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Default machine parameters of model <i>AsynchronousInductionMachineReluctanceRotor</i> are used.
</p>
</HTML>"));
      Modelica.Blocks.Sources.Ramp Ramp1(height=f, duration=tRamp) 
        annotation (extent=[-100,50; -80,70]);
      Auxiliary.VfController VfController1(
        final m=m,
        VNominal=VNominal,
        fNominal=fNominal) annotation (extent=[-60, 50; -40, 70]);
      MultiPhase.Sources.SignalVoltage SignalVoltage1(final m=m) 
        annotation (extent=[-10, 70; -30, 50], rotation=-90);
      MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Machines.Basic.AsynchronousInductionMachineReluctanceRotor AIMR1 
                 annotation (extent=[-40, -30; -20, -10]);
      MultiPhase.Basic.Star Star2(final m=m) 
        annotation (extent=[-50, -20; -70, 0]);
      Auxiliary.RotorAngle RotorAngle1(p=p) 
        annotation (extent=[-10,20; 10,40]);
      MultiPhase.Sensors.VoltageSensor VoltageSensor1 
        annotation (extent=[-20,20; -40,0]);
      Modelica.Mechanics.Rotational.Sensors.AngleSensor AngleSensor1 
        annotation (extent=[10, -20; -10, 0], rotation=90);
      Modelica.Blocks.Sources.Step Step1(height=-T_Load, startTime=tStep) 
        annotation (extent=[50,0; 70,20]);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[20,-30; 40,-10]);
      Modelica.Mechanics.Rotational.Torque Torque1 
        annotation (extent=[70,-30; 50,-10]);
    equation 
      connect(SignalVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-20, 70; -20, 90; -50, 90], style(color=3));
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(Star2.plug_p, AIMR1.plug_sn) annotation (points=[-50,-10; -36,-10],
           style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(AIMR1.plug_sn, VoltageSensor1.plug_n) annotation (points=[-36,-10;
            -36,-5; -40,-5; -40,10],
                      style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(AIMR1.plug_sp, VoltageSensor1.plug_p) annotation (points=[-24,-10;
            -24,-6; -20,-6; -20,10],
                      style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(AIMR1.plug_sp, SignalVoltage1.plug_p) annotation (points=[-24,-10;
            -24,-6; -20,-6; -20,50],
                       style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(AIMR1.flange_a, AngleSensor1.flange_a) annotation (points=[-20,
            -20; 6.12303e-016,-20],  style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(LoadInertia.flange_b,Torque1. flange_b) 
        annotation (points=[40,-20; 50,-20], style(color=0, rgbcolor={0,0,0}));
      connect(AIMR1.flange_a, LoadInertia.flange_a) annotation (points=[-20,-20;
            20,-20], style(color=0, rgbcolor={0,0,0}));
      connect(Ramp1.y, VfController1.u) 
        annotation (points=[-79,60; -62,60], style(color=3, rgbcolor={0,0,255}));
      connect(VfController1.y, SignalVoltage1.v) 
        annotation (points=[-39,60; -27,60], style(color=3, rgbcolor={0,0,255}));
      connect(Step1.y, Torque1.tau) annotation (points=[71,10; 80,10; 80,-20;
            72,-20],
                  style(color=3, rgbcolor={0,0,255}));
      connect(VoltageSensor1.v, RotorAngle1.u) annotation (points=[-30,21; -30,30;
            -12,30], style(color=3, rgbcolor={0,0,255}));
      connect(AngleSensor1.phi, RotorAngle1.angle) annotation (points=[
            -6.73533e-016,1; -6.73533e-016,9.5; 0,9.5; 0,20], style(color=3,
            rgbcolor={0,0,255}));
    end AIMR_Inverter;
    
    model PMSMD_Inverter "Test example 6: PSMD with inverter" 
      extends Modelica.Icons.Example;
      constant Integer m=3 "number of phases";
      parameter Real p=2 "number of pole pairs";
      parameter Modelica.SIunits.Voltage VNominal=100 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Frequency f=50 "actual frequency";
      parameter Modelica.SIunits.Time tRamp=1 "frequency ramp";
      parameter Modelica.SIunits.Torque T_Load=181.4 "nominal load torque";
      parameter Modelica.SIunits.Time tStep=1.2 "time of load torque step";
      parameter Modelica.SIunits.Inertia J_Load=0.29 "load's moment of inertia";
      output Modelica.SIunits.Angle theta = RotorAngle1.y "Rotor angle";
      output Modelica.SIunits.Current i_ss_magnitude = SpacePhasors.Functions.ToPolar(PMSMD1.idq_ss) 
        "Stator current magnitude";
      output Modelica.SIunits.Current i_dr_magnitude = SpacePhasors.Functions.ToPolar(PMSMD1.idq_dr) 
        "Damper current magnitude";
      annotation (
        Diagram,
        experiment(StopTime=1.5, Interval=0.001),
        experimentSetupOutput(
          doublePrecision=true),
        Documentation(info="<HTML>
<p>
<b>6th Test example: Permanent magnet Synchronous induction Machine fed by an ideal inverter</b><br>
An ideal frequency inverter is modeled by using a VfController and a threephase SignalVoltage.<br>
Frequency is raised by a ramp, causing the permanent magnet synchronous induction machine to start, 
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Default machine parameters of model <i>PermanentMagnetSynchronousMachineDamperCage</i> are used.
</p>
<p>
<b>In practice it is nearly impossible to drive a PMSMD without current controller.</b>
</p>
</HTML>"));
      Modelica.Blocks.Sources.Ramp Ramp1(height=f, duration=tRamp) 
        annotation (extent=[-100, 50; -80, 70]);
      Auxiliary.VfController VfController1(
        final m=m,
        VNominal=VNominal,
        fNominal=fNominal,
        BasePhase=+Modelica.Constants.pi/2) 
        annotation (extent=[-60, 50; -40, 70]);
      MultiPhase.Sources.SignalVoltage SignalVoltage1(final m=m) 
        annotation (extent=[-10,70; -30,50],   rotation=-90);
      MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-50, 80; -70, 100]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-100, 80; -80, 100], rotation=-90);
      Machines.Basic.PermanentMagnetSynchronousMachineDamperCage PMSMD1 
        annotation (extent=[-40, -30; -20, -10], rotation=0);
      MultiPhase.Basic.Star Star2(final m=m) 
        annotation (extent=[-50, -20; -70, 0]);
      Auxiliary.RotorAngle RotorAngle1(p=p) 
        annotation (extent=[-10,20; 10,40]);
      MultiPhase.Sensors.VoltageSensor VoltageSensor1 
        annotation (extent=[-20,20; -40,0]);
      Modelica.Mechanics.Rotational.Sensors.AngleSensor AngleSensor1 
        annotation (extent=[10, -20; -10, 0], rotation=90);
      Modelica.Blocks.Sources.Step Step1(height=-T_Load, startTime=tStep) 
        annotation (extent=[50,0; 70,20]);
      Modelica.Mechanics.Rotational.Inertia LoadInertia(J=J_Load) 
        annotation (extent=[20,-30; 40,-10]);
      Modelica.Mechanics.Rotational.Torque Torque1 
        annotation (extent=[70,-30; 50,-10]);
    equation 
      connect(SignalVoltage1.plug_n, Star1.plug_p) 
        annotation (points=[-20,70; -20,90; -50,90],    style(color=3));
      connect(Star1.pin_n, Ground1.p) 
        annotation (points=[-70, 90; -80, 90], style(color=3));
      connect(SignalVoltage1.plug_p, PMSMD1.plug_sp) annotation (points=[-20,50;
            -20,-4; -24,-4; -24,-10],
                        style(color=3, rgbcolor={0,0,255}));
      connect(PMSMD1.plug_sn, Star2.plug_p) annotation (points=[-36,-10; -50,-10],
           style(color=3, rgbcolor={0,0,255}));
      connect(VoltageSensor1.plug_n, PMSMD1.plug_sn) annotation (points=[-40,10;
            -40,-4; -36,-4; -36,-10],
                        style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(VoltageSensor1.plug_p, PMSMD1.plug_sp) annotation (points=[-20,10;
            -20,-4; -24,-4; -24,-10],
                        style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(PMSMD1.flange_a, AngleSensor1.flange_a) annotation (points=[-20,
            -20; 6.12303e-016,-20],  style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(LoadInertia.flange_b,Torque1. flange_b) 
        annotation (points=[40,-20; 50,-20], style(color=0, rgbcolor={0,0,0}));
      connect(PMSMD1.flange_a, LoadInertia.flange_a) annotation (points=[-20,-20;
            20,-20], style(color=0, rgbcolor={0,0,0}));
      connect(Ramp1.y, VfController1.u) 
        annotation (points=[-79,60; -62,60], style(color=3, rgbcolor={0,0,255}));
      connect(VfController1.y, SignalVoltage1.v) 
        annotation (points=[-39,60; -27,60], style(color=3, rgbcolor={0,0,255}));
      connect(VoltageSensor1.v, RotorAngle1.u) annotation (points=[-30,21; -30,30;
            -12,30], style(color=3, rgbcolor={0,0,255}));
      connect(AngleSensor1.phi, RotorAngle1.angle) annotation (points=[
            -6.73533e-016,1; -6.73533e-016,9.5; 0,9.5; 0,20], style(color=3,
            rgbcolor={0,0,255}));
      connect(Step1.y, Torque1.tau) annotation (points=[71,10; 80,10; 80,-20;
            72,-20],
                  style(color=3, rgbcolor={0,0,255}));
    end PMSMD_Inverter;
  end Examples;
  
  package Auxiliary "Library with auxiliary models for testing" 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains components auxiliary components for testing examples.
</p>
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
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
    block VfController "Voltage-Frequency-Controller" 
      import Modelica.Math;
      import SI = Modelica.SIunits;
      extends Modelica.Blocks.Interfaces.SIMO(final nout=m);
      constant Real pi=Modelica.Constants.pi;
      parameter Integer m=3 "number of phases";
      parameter Modelica.SIunits.Voltage VNominal 
        "nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal "nominal frequency";
      parameter Modelica.SIunits.Angle BasePhase=0 
        "common phase shift for all phases";
      output Real x[m](each start=0, each fixed=true) "Integrator states";
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
Amplitude of voltage is linear dependent (VNominal/fNominal) on Frequency (inPort), but limited by VNominal (nominal RMS voltage per phase).<br>
m sine-waves with amplitudes as described above are provided at outPort.<br>
The sine-waves are intended to feed a m-phase SignalVoltage.<br>
Phase shifts between sine-waves may be choosen by the user; default values are <i>(k-1)/m*pi for k in 1:m</i>.
</p>
</HTML>"));
    protected 
      SI.Voltage v;
      SI.Voltage amplitude[m];
      SI.Frequency frequency[m];
      SI.Angle phase[m];
    equation 
      v = sqrt(2)*min(abs(u)*VNominal/fNominal, VNominal);
      amplitude = fill(v, m);
      frequency = fill(u, m);
      phase= fill(BasePhase, m) - {(k - 1)*2/m*pi for k in 1:m};
      der(x) = 2*pi*frequency;
      y = {amplitude[k]*Math.sin(x[k] + phase[k]) for k in 1:m};
    end VfController;
    
    block RotorAngle "Rotor lagging angle" 
      extends Modelica.Blocks.Interfaces.MISO(final nin=m);
      constant Integer m=3 "number of phases";
      parameter Real p "number of pole pairs";
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
              fillPattern=1))),
        Documentation(info="<HTML>
<p>
Calculates rotor lagging angle by transforming the signals of stator phase voltages to the correspondig space phasor in stator.fixed coordinate system, rotating the space phasor to the rotor-fixed coordinate system and calculating the angle of this space phasor.<br>
Input signals: stator phase voltages and mechanical rotor angle.
</p>
</HTML>"));
      Modelica.Blocks.Interfaces.RealInput angle(
         redeclare type SignalType = Modelica.SIunits.Angle) 
        annotation (extent=[-10, -110; 10, -90], rotation=-270);
      Modelica.Blocks.Math.Gain gain(final k=p) 
        annotation (extent=[-10,-60; 10,-80],   rotation=-90);
      Modelica.Blocks.Sources.Constant constant_(final k=Modelica.Constants.pi/2) 
        annotation (extent=[-40, -70; -20, -50]);
      Modelica.Blocks.Math.Add add(
        final k1=1,
        final k2=1) annotation (extent=[-10, -30; 10, -50], rotation=-90);
      SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasorVS 
        annotation (extent=[-40,-10; -20,10],   rotation=0);
      SpacePhasors.Blocks.Rotator rotatorVS2R 
        annotation (extent=[-10, 10; 10, -10], rotation=0);
      SpacePhasors.Blocks.ToPolar ToPolarVSR 
        annotation (extent=[20,-10; 40,10],   rotation=0);
      Modelica.Blocks.Routing.DeMultiplex2 deMultiplex2(final n1=1,
           final n2=1) annotation (extent=[60, -10; 80, 10]);
    equation 
      connect(u, ToSpacePhasorVS.u) 
        annotation (points=[-120,0; -42,0], style(color=3, rgbcolor={0,0,255}));
      connect(angle, gain.u) annotation (points=[0,-100; 0,-82; -7.34764e-016,
            -82],
          style(color=3, rgbcolor={0,0,255}));
      connect(constant_.y, add.u2) annotation (points=[-19,-60; -6,-60; -6,-52],
          style(color=3, rgbcolor={0,0,255}));
      connect(gain.y, add.u1) annotation (points=[6.73533e-016,-59; 6,-59; 6,
            -52],
          style(color=3, rgbcolor={0,0,255}));
      connect(add.y, rotatorVS2R.angle) annotation (points=[6.73533e-016,-29;
            6.73533e-016,-20.5; 0,-20.5; 0,-10], style(color=3, rgbcolor={0,0,255}));
      connect(ToSpacePhasorVS.y, rotatorVS2R.u) annotation (points=[-19,0; -32,0;
            -32,4; -28,4; -28,0; -12,0], style(color=3, rgbcolor={0,0,255}));
      connect(rotatorVS2R.y, ToPolarVSR.u) 
        annotation (points=[11,0; 18,0], style(color=3, rgbcolor={0,0,255}));
      connect(ToPolarVSR.y, deMultiplex2.u) 
        annotation (points=[41,0; 58,0], style(color=3, rgbcolor={0,0,255}));
      connect(deMultiplex2.y2[1], y) annotation (points=[81,-6; 88,-6; 88,0; 110,0],
          style(color=3, rgbcolor={0,0,255}));
    end RotorAngle;
    
    model SwitchYD "Y-D-switch" 
      constant Integer m=3 "number of phases";
      MultiPhase.Interfaces.PositivePlug plug_P(final m=m) 
        annotation (extent=[90, 90; 110, 110]);
      MultiPhase.Interfaces.PositivePlug pug_PS(final m=m) 
        annotation (extent=[90, -110; 110, -90]);
      MultiPhase.Interfaces.NegativePlug plug_NS(final m=m) 
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
      MultiPhase.Basic.Star star(final m=m) 
        annotation (extent=[60, -50; 80, -30]);
      MultiPhase.Basic.Delta delta(final m=m) 
        annotation (extent=[80, -80; 60, -60]);
      MultiPhase.Ideal.IdealCommutingSwitch idealCommutingSwitch(final m=m) 
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
      connect(control, idealCommutingSwitch.off) annotation (points=[-110,0; 0,
            0; 0,-52],          style(
          color=5,
          rgbcolor={255,0,255},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
    end SwitchYD;
  end Auxiliary;
  
  package Interfaces 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains the space phasor connector and a partial models for machine models.
</p>
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
  <li> v1.01 2004/09/18 Anton Haumer<br>
       moved common equations from machine models to PartialMachine</li>
  </ul>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
    connector SpacePhasor 
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
              rgbfillColor={0,0,255})), Text(
            extent=[-150,-90; 150,-150],
            style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1),
            string="%name")),
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
    
    partial model PartialMachine 
      constant Real pi=Modelica.Constants.pi;
      output Modelica.SIunits.Angle phi_mechanical = flange_a.phi 
        "mechanical angle of rotor";
      output Modelica.SIunits.AngularVelocity w_mechanical = der(flange_a.phi) 
        "mechanical angular velocity";
      output Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm 
        rpm_mechanical = Modelica.SIunits.Conversions.to_rpm(w_mechanical) 
        "mechanical speed [rpm]";
      output Modelica.SIunits.Torque tau_electrical = inertia.flange_a.tau 
        "electromagnetic torque";
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
        annotation (extent=[90,-10; 110,10]);
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
            extent=[-150,-110; 150,-170],
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
</ul>
</p>
</HTML>"),
        Diagram);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a bearing 
        "Bearing at which the reaction torque (i.e., -flange.tau) is acting" 
           annotation (extent=[90,-110; 110,-90]);
      Modelica.Mechanics.Rotational.Inertia inertia 
        annotation (extent=[60,10; 40,-10],   rotation=-180);
    equation 
      if cardinality(bearing) == 0 then
        bearing.phi = 0;
      else
        bearing.tau = -flange_a.tau;
      end if;
      connect(inertia.flange_b, flange_a) annotation (points=[60,1.22461e-015;
            79,1.22461e-015; 79,0; 100,0], style(color=0, rgbcolor={0,0,0}));
    end PartialMachine;
    
    partial model PartialInductionMachine 
      extends PartialMachine;
      constant Integer m=3 "number of phases";
      MultiPhase.Interfaces.NegativePlug plug_sn(final m=m) 
        annotation (extent=[-70,90; -50,110]);
      MultiPhase.Interfaces.PositivePlug plug_sp(final m=m) 
        annotation (extent=[50,90; 70,110]);
      annotation (Documentation(info="<HTML>
<p>
Partial model for induction machine models, containing:
<ul>
<li>main parts of the icon</li>
<li>stator plugs</li>
<li>mechanical flange</li>
</ul>
</p>
</HTML>"),
        Diagram,
        Icon(Line(points=[-50,100; -20,100; -20,70], style(color=3, rgbcolor={0,
                  0,255})), Line(points=[50,100; 20,100; 20,70], style(color=3,
                rgbcolor={0,0,255}))));
    end PartialInductionMachine;
  end Interfaces;
  
  package Basic "Basic machine models" 
    extends Modelica.Icons.Library;
    import Machines.Basic.Components.*;
    annotation (Documentation(info="<HTML>
<p>
This package contains components for modeling electrical machines, specially threephase induction machines, based on space phasor theory:
<ul>
<li>AsynchronousInductionMachineSquirrelCage: model of a three phase asynchronous induction machine with squirrel cage</li>
<li>AsynchronousInductionMachineSlipRing: model of a three phase asynchronous induction machine with slipring rotor</li>
<li>AsynchronousInductionMachineReluctanceRotor: model of a three phase asynchronous induction machine with reluctance rotor</li>
<li>PermanentMagnetSynchronousMachineDamperCage: model of a permanent magnet synchronous induction machine with damper</li>
<li>package Components: components for modeling machines</li>
</ul>
These models use package SpacePhasors.
</p>
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
  <li> v1.01 2004/09/18 Anton Haumer<br>
       moved common equations from machine models to PartialMachine</li>
  </ul>
  </dd>
</p>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
    model AsynchronousInductionMachineSquirrelCage 
      "Asynchronous induction machine with squirrel cage rotor" 
      extends Interfaces.PartialInductionMachine(inertia(final J=J));
      parameter Real p=2 "number of pole pairs";
      constant Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Resistance Rs=0.03 
        "|Impedances|warm stator resistance per phase";
      parameter Modelica.SIunits.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*
          fNominal) "|Impedances|stator stray inductance per phase";
      parameter Modelica.SIunits.Inductance Lm=3*sqrt(1 - 0.0667)/(2*pi*fNominal) 
        "|Impedances|main inductance";
      parameter Modelica.SIunits.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*
          fNominal) "|Impedances|rotor stray inductance";
      parameter Modelica.SIunits.Resistance Rr=0.04 
        "|Impedances|warm rotor resistance";
      parameter Modelica.SIunits.Inertia J=0.29 "moment of inertia";
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
      MultiPhase.Basic.Resistor rs(final m=m, final R=fill(Rs, m)) 
        annotation (extent=[60,50; 40,70]);
      MultiPhase.Basic.Inductor lssigma(final m=m, final L=fill(Lssigma, m)) 
        annotation (extent=[30,50; 10,70]);
      SpacePhasors.Components.SpacePhasor spacePhasorS 
        annotation (extent=[10, 40; -10, 20], rotation=90);
      AirGapS airGapS(final p=p, final Lm=Lm) 
        annotation (extent=[-10,-10; 10,10],   rotation=-90);
      Components.SquirrelCage squirrelCageR(final Lrsigma=Lrsigma, final Rr=Rr) 
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
<td>4</td><td> </td>
</tr>
<tr>
<td>moment of inertia</td>
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
<td>main inductance per phase</td>
<td>sqrt(Xs*Xr * (1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</p>
</HTML>"),     Diagram);
    equation 
      connect(rs.plug_n, lssigma.plug_p) 
        annotation (points=[40,60; 30,60],   style(color=3));
      connect(lssigma.plug_n, spacePhasorS.plug_p) 
        annotation (points=[10,60; 10,40],           style(color=3));
      connect(spacePhasorS.plug_n, plug_sn) annotation (points=[-10,40; -10,60; -60,
            60; -60,100], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={95,95,95},
          fillPattern=1));
      connect(rs.plug_p, plug_sp) annotation (points=[60,60; 60,100], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=10,
          rgbfillColor={95,95,95},
          fillPattern=1));
      connect(spacePhasorS.ground, spacePhasorS.zero) annotation (points=[-10,
            20; -10,14; -6.12303e-016,14; -6.12303e-016,20], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(spacePhasorS.spacePhasor, airGapS.spacePhasor_s) annotation (
          points=[10,20; 10,10], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(airGapS.spacePhasor_r, squirrelCageR.spacePhasor_r) annotation (
          points=[10,-10; 10,-20], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(airGapS.flange_a, inertia.flange_a) annotation (points=[10,
            6.12303e-016; 26,6.12303e-016; 26,-1.22461e-015; 40,-1.22461e-015],
          style(color=0, rgbcolor={0,0,0}));
    end AsynchronousInductionMachineSquirrelCage;
    
    model AsynchronousInductionMachineSlipRing 
      "Asynchronous induction machine with slipring rotor" 
      extends Interfaces.PartialInductionMachine(inertia(final J=J));
      parameter Real p=2 "number of pole pairs";
      constant Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Resistance Rs=0.03 
        "|Impedances|warm stator resistance per phase";
      parameter Modelica.SIunits.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*
          fNominal) "|Impedances|stator stray inductance per phase";
      parameter Modelica.SIunits.Inductance Lm=3*sqrt(1 - 0.0667)/(2*pi*fNominal) 
        "|Impedances|main inductance";
      parameter Modelica.SIunits.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*
          fNominal) "|Impedances|rotor stray inductance per phase";
      parameter Modelica.SIunits.Resistance Rr=0.04 
        "|Impedances|warm rotor resistance per phase";
      parameter Modelica.SIunits.Inertia J=0.29 "moment of inertia";
      parameter Real TurnsRatio=1 "w1*xi1 / w2*xi2";
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
      output Modelica.SIunits.Current i_0_r = spacePhasorR.zero.i 
        "rotor zero-sequence current";
      output Modelica.SIunits.Current ir[m] = plug_rp.pin.i 
        "rotor instantaneous currents";
      MultiPhase.Basic.Resistor resistorS(final m=m, final R=fill(Rs, m)) 
        annotation (extent=[60,50; 40,70]);
      MultiPhase.Basic.Inductor inductorSs(final m=m, final L=fill(Lssigma, m)) 
        annotation (extent=[30,50; 10,70]);
      SpacePhasors.Components.SpacePhasor spacePhasorS 
        annotation (extent=[10,40; -10,20],   rotation=90);
      AirGapS airGapS(final p=p, final Lm=Lm) 
        annotation (extent=[-10,-10; 10,10],   rotation=-90);
      SpacePhasors.Components.SpacePhasor spacePhasorR 
        annotation (extent=[10, -40; -10, -20], rotation=90);
      MultiPhase.Basic.Inductor inductorRs(final m=m, final L=fill(Lrsigma, m)) 
        annotation (extent=[30,-90; 10,-70]);
      MultiPhase.Basic.Resistor resistorR(final m=m, final R=fill(Rr, m)) 
        annotation (extent=[60,-90; 40,-70]);
      MultiPhase.Interfaces.PositivePlug plug_rp(final m=m) 
        annotation (extent=[-110,70; -90,50]);
      MultiPhase.Interfaces.NegativePlug plug_rn(final m=m) 
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
<td>4</td><td> </td>
</tr>
<tr>
<td>moment of inertia</td>
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
<td>1</td><td>effective ratio of stator and rotor current (w1*xi1 / w2*xi2)</td>
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
<td>main inductance per phase</td>
<td>sqrt(Xs*Xr * (1-sigma))/(2*pi*f)</td><td> </td>
</tr>
</table>
</p>
</HTML>"), Diagram,
        Icon(Line(points=[-100,50; -100,20; -60,20], style(color=3, rgbcolor={0,
                  0,255})), Line(points=[-100,-50; -100,-20; -60,-20], style(
                color=3, rgbcolor={0,0,255}))));
      MultiPhase.Ideal.IdealTransformer IdealTransformer1(final m=m, final n=
            fill(1/TurnsRatio, m)) 
        annotation (extent=[10,-70; -10,-50], rotation=90);
      MultiPhase.Basic.Star Star1(final m=m) 
        annotation (extent=[-20,-60; -40,-40]);
      Modelica.Electrical.Analog.Basic.Ground Ground1 
        annotation (extent=[-60,-70; -40,-50], rotation=0);
    equation 
      connect(resistorS.plug_n, inductorSs.plug_p) 
        annotation (points=[40,60; 30,60],   style(color=3));
      connect(inductorSs.plug_n, spacePhasorS.plug_p) 
        annotation (points=[10,60; 10,40],           style(color=3));
      connect(resistorR.plug_n, inductorRs.plug_p) 
        annotation (points=[40,-80; 30,-80],   style(color=3));
      connect(spacePhasorR.plug_n, IdealTransformer1.plug_n2) annotation (
          points=[-10,-40; -10,-50], style(color=3, rgbcolor={0,0,255}));
      connect(spacePhasorR.plug_p, IdealTransformer1.plug_p2) annotation (
          points=[10,-40; 10,-50], style(color=3, rgbcolor={0,0,255}));
      connect(IdealTransformer1.plug_p1, inductorRs.plug_n) annotation (points=[10,
            -70; 10,-80],             style(color=3, rgbcolor={0,0,255}));
      connect(Star1.pin_n, Ground1.p) annotation (points=[-40,-50; -50,-50],
          style(color=3, rgbcolor={0,0,255}));
      connect(Star1.plug_p, IdealTransformer1.plug_n2) annotation (points=[-20,
            -50; -10,-50], style(color=3, rgbcolor={0,0,255}));
      connect(IdealTransformer1.plug_n1, plug_rn) annotation (points=[-10,-70;
            -10,-80; -60,-80; -60,-60; -100,-60], style(color=3, rgbcolor={0,0,
              255}));
      connect(resistorR.plug_p, plug_rp) annotation (points=[60,-80; 60,-100;
            -80,-100; -80,60; -100,60], style(color=3, rgbcolor={0,0,255}));
      connect(resistorS.plug_p, plug_sp) annotation (points=[60,60; 60,100],
          style(color=3, rgbcolor={0,0,255}));
      connect(plug_sn, spacePhasorS.plug_n) annotation (points=[-60,100; -60,60;
            -10,60; -10,40], style(color=3, rgbcolor={0,0,255}));
      connect(spacePhasorS.ground, spacePhasorS.zero) annotation (points=[-10,
            20; -10,14; -6.12303e-016,14; -6.12303e-016,20], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(spacePhasorR.ground, spacePhasorR.zero) annotation (points=[-10,
            -20; -10,-14; -6.12303e-016,-14; -6.12303e-016,-20], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(spacePhasorS.spacePhasor, airGapS.spacePhasor_s) annotation (
          points=[10,20; 10,10], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(airGapS.spacePhasor_r, spacePhasorR.spacePhasor) annotation (
          points=[10,-10; 10,-20], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(airGapS.flange_a, inertia.flange_a) annotation (points=[10,
            6.12303e-016; 25,6.12303e-016; 25,-1.22461e-015; 40,-1.22461e-015],
          style(color=0, rgbcolor={0,0,0}));
    end AsynchronousInductionMachineSlipRing;
    
    model AsynchronousInductionMachineReluctanceRotor 
      "Asynchronous induction machine with reluctance rotor" 
      extends Interfaces.PartialInductionMachine(inertia(final J=J));
      parameter Real p=2 "number of pole pairs";
      constant Modelica.SIunits.Frequency fNominal=50 "nominal frequency";
      parameter Modelica.SIunits.Resistance Rs=0.03 
        "|Impedances|warm stator resistance per phase";
      parameter Modelica.SIunits.Inductance Lssigma=0.1/(2*pi*fNominal) 
        "|Impedances|stator stray inductance per phase";
      parameter Modelica.SIunits.Inductance Lmd=2.9/(2*pi*fNominal) 
        "|Impedances|main inductance d-axis";
      parameter Modelica.SIunits.Inductance Lmq=0.9/(2*pi*fNominal) 
        "|Impedances|main inductance q-axis";
      parameter Modelica.SIunits.Inductance Lrsigma=0.1/(2*pi*fNominal) 
        "|Impedances|rotor stray inductance";
      parameter Modelica.SIunits.Resistance Rr=0.04 
        "|Impedances|warm rotor resistance";
      parameter Modelica.SIunits.Inertia J=0.29 "moment of inertia";
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
      MultiPhase.Basic.Resistor resistorS(final m=m, final R=fill(Rs, m)) 
        annotation (extent=[60,50; 40,70]);
      MultiPhase.Basic.Inductor inductorSs(final m=m, final L=fill(Lssigma, m)) 
        annotation (extent=[30,50; 10,70]);
      SpacePhasors.Components.SpacePhasor spacePhasorS 
        annotation (extent=[10,40; -10,20],   rotation=90);
      AirGapR airGapR(
        final p=p,
        final Lmd=Lmd,
        final Lmq=Lmq) annotation (extent=[-10,-10; 10,10],   rotation=-90);
      Components.SquirrelCage squirrelCageR(final Lrsigma=Lrsigma, final Rr=Rr) 
        annotation (extent=[-10, -40; 10, -20], rotation=-90);
      annotation (defaultComponentName="AIMR",
        Diagram,
        Icon(
          Polygon(points=[-130,20; -130,28; -122,34; -114,38; -106,40; -94,40;
                -86,38; -76,34; -70,28; -70,20; -80,20; -80,-12; -80,-20; -70,
                -20; -70,-28; -76,-34; -86,-38; -94,-40; -104,-40; -114,-38;
                -124,-34; -130,-28; -130,-20; -120,-20; -120,-8; -120,20; -130,
                20], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1))),
        Documentation(info="<HTML>
<p>
<b>Model of a three phase asynchronous induction machine with reluctance rotor.</b><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed ccordinate system. Both together connected via a rotor-fixed <i>AirGap</i> model. Only losses in stator and rotor resistance are taken into account.
</p>
<p>
<b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td>number of pole pairs p</td>
<td>4</td><td> </td>
</tr>
<tr>
<td>moment of inertia</td>
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
<td> 43.3</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td> 6.801</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>96.8</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.468</td><td> </td>
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
<td>rotor stray reactance Xrs</td>
<td>0.1</td><td>Ohm per phase</td>
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
<td>rotor stray inductance</td>
<td>Xrs/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main inductance per phase in d-axis</td>
<td>(Xsd-Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main inductance per phase in q-axis</td>
<td>(Xsq-Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</p>
</HTML>"));
    equation 
      connect(resistorS.plug_n, inductorSs.plug_p) 
        annotation (points=[40,60; 30,60],   style(color=3));
      connect(inductorSs.plug_n, spacePhasorS.plug_p) 
        annotation (points=[10,60; 10,40],           style(color=3));
      connect(resistorS.plug_p, plug_sp) annotation (points=[60,60; 60,100],
          style(color=3, rgbcolor={0,0,255}));
      connect(spacePhasorS.plug_n, plug_sn) annotation (points=[-10,40; -12,40;
            -12,60; -60,60; -60,100], style(color=3, rgbcolor={0,0,255}));
      connect(spacePhasorS.spacePhasor, airGapR.spacePhasor_s) annotation (
          points=[10,20; 10,10; 10,10], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(airGapR.spacePhasor_r, squirrelCageR.spacePhasor_r) annotation (
          points=[10,-10; 10,-20], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(spacePhasorS.ground, spacePhasorS.zero) annotation (points=[-10,
            20; -10,14; -6.12303e-016,14; -6.12303e-016,20], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(airGapR.flange_a, inertia.flange_a) annotation (points=[10,
            6.12303e-016; 25,6.12303e-016; 25,-1.22461e-015; 40,-1.22461e-015],
          style(color=0, rgbcolor={0,0,0}));
    end AsynchronousInductionMachineReluctanceRotor;
    
    model PermanentMagnetSynchronousMachineDamperCage 
      "Permanent magnet synchronous induction machine with damper" 
      extends Interfaces.PartialInductionMachine(inertia(final J=J));
      parameter Real p=2 "number of pole pairs";
      parameter Modelica.SIunits.Frequency fNominal=50 
        "|Excitation|nominal frequency";
      parameter Modelica.SIunits.Voltage V0=112.3 
        "|Excitation|no-load RMS voltage @ fNominal";
      parameter Modelica.SIunits.Resistance Rs=0.03 
        "|Impedances|warm stator resistance per phase";
      parameter Modelica.SIunits.Inductance Lssigma=0.1/(2*pi*fNominal) 
        "|Impedances|stator stray inductance per phase";
      parameter Modelica.SIunits.Inductance Lmd=0.3/(2*pi*fNominal) 
        "|Impedances|main inductance d-axis";
      parameter Modelica.SIunits.Inductance Lmq=0.3/(2*pi*fNominal) 
        "|Impedances|main inductance q-axis";
      parameter Modelica.SIunits.Inductance Lrsigma=0.05/(2*pi*fNominal) 
        "|Impedances|damper stray inductance";
      parameter Modelica.SIunits.Resistance Rr=0.04 
        "|Impedances|warm damper resistance";
      parameter Modelica.SIunits.Inertia J=0.29 "moment of inertia";
      output Modelica.SIunits.Current is[m] = plug_sp.pin.i 
        "stator instantaneous currents";
      output Modelica.SIunits.Current i_0_s( stateSelect=StateSelect.prefer) = spacePhasorS.zero.i 
        "stator zero-sequence current";
      output Modelica.SIunits.Current idq_ss[2] = airGapR.i_ss 
        "stator space phasor current / stator fixed frame";
      output Modelica.SIunits.Current idq_sr[2](each stateSelect=StateSelect.prefer) = airGapR.i_sr 
        "stator space phasor current / rotor fixed frame";
      output Modelica.SIunits.Current idq_dr[2](each stateSelect=StateSelect.prefer) = squirrelCageD.spacePhasor_r.i_ 
        "damper space phasor current / rotor fixed frame";
    protected 
      parameter Modelica.SIunits.Current Ie=sqrt(2)*V0/(Lmd*2*pi*fNominal) 
        "equivalent wxcitation current";
    public 
      MultiPhase.Basic.Resistor resistorS(final m=m, final R=fill(Rs, m)) 
        annotation (extent=[60,50; 40,70]);
      MultiPhase.Basic.Inductor inductorSs(final m=m, final L=fill(Lssigma, m)) 
        annotation (extent=[30,50; 10,70]);
      SpacePhasors.Components.SpacePhasor spacePhasorS 
        annotation (extent=[10, 40; -10, 20], rotation=90);
      AirGapR airGapR(
        final p=p,
        final Lmd=Lmd,
        final Lmq=Lmq) annotation (extent=[-10,-10; 10,10],   rotation=-90);
      Components.SquirrelCage squirrelCageD(final Lrsigma=Lrsigma, final Rr=Rr) 
        annotation (extent=[-10, -40; 10, -20], rotation=-90);
      Components.PermanentMagnet permanentMagnet(Ie=Ie) 
        annotation (extent=[-10, -70; 10, -50], rotation=-90);
      annotation (defaultComponentName="PMSMD",
        Diagram,
        Icon(
          Rectangle(extent=[-110,0; -90,-30], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Rectangle(extent=[-110,30; -90,0], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=1,
              rgbfillColor={255,0,0})),
          Ellipse(extent=[-134,34; -66,-34], style(color=3, rgbcolor={0,0,255}))),
        Documentation(info="<HTML>
<p>
<b>Model of a three phase permanent magnet synchronous induction machine with damper cage.</b><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation and a rotor-fixed <i>AirGap</i> model. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed ccordinate system. Permanent magnet excitation is modelled by a constant equivalent excitation current feeding the d-axis. Only losses in stator and damper resistance are taken into account.
</p>
<p>
<b>Default values for machine's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td>number of pole pairs p</td>
<td>4</td><td> </td>
</tr>
<tr>
<td>moment of inertia</td>
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
<td>damper resistance</td>
<td>0.04</td><td>Ohm in warm condition</td>
</tr>
<tr>
<td>damper stray reactance Xds</td>
<td>0.05</td><td>Ohm</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>main inductance in d-axis</td>
<td>(Xd - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main inductance in q-axis</td>
<td>(Xq - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance</td>
<td>Xds/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</p>
</HTML>"));
    equation 
      connect(resistorS.plug_n, inductorSs.plug_p) 
        annotation (points=[40,60; 30,60],   style(color=3));
      connect(inductorSs.plug_n, spacePhasorS.plug_p) 
        annotation (points=[10,60; 10,40],           style(color=3));
      connect(resistorS.plug_p, plug_sp) annotation (points=[60,60; 60,100],
          style(color=3, rgbcolor={0,0,255}));
      connect(spacePhasorS.plug_n, plug_sn) annotation (points=[-10,40; -12,40;
            -12,60; -60,60; -60,100], style(color=3, rgbcolor={0,0,255}));
      connect(spacePhasorS.ground, spacePhasorS.zero) annotation (points=[-10,
            20; -10,14; -6.12303e-016,14; -6.12303e-016,20],
                                                         style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(spacePhasorS.spacePhasor, airGapR.spacePhasor_s) annotation (
          points=[10,20; 10,10], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(airGapR.spacePhasor_r, squirrelCageD.spacePhasor_r) annotation (
          points=[10,-10; 10,-20], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(airGapR.spacePhasor_r, permanentMagnet.spacePhasor_r) annotation (
         points=[10,-10; 10,-50], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(airGapR.flange_a, inertia.flange_a) annotation (points=[10,
            6.12303e-016; 24,6.12303e-016; 24,-1.22461e-015; 40,-1.22461e-015],
          style(color=0, rgbcolor={0,0,0}));
    end PermanentMagnetSynchronousMachineDamperCage;
    
    package Components 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<HTML>
<p>
This package contains components for modeling electrical machines, specially threephase induction machines, based on space phasor theory:
<ul>
<li>AirGapS: model of an airgap whose coordinate system is fixed to the stator</li>
<li>AirGapR: model of an airgap whose coordinate system is fixed to the rotor</li>
<li>SquirrelCage: model of a squirrel cage rotor</li>
<li>PermanentMagnet: model of a permanent magnet excitation</li>
</ul>
These models use package SpacePhasors.
</p>
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
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
      
      model AirGapS "Airgap in stator-fixed coordinate system" 
        constant Integer m=3 "number of phases";
        parameter Real p "number of pole pairs";
        parameter Modelica.SIunits.Inductance Lm "main inductance";
        output Modelica.SIunits.Torque tau_electrical;
        Modelica.SIunits.Angle gammam "Rotor angle";
        Modelica.SIunits.Current i_ss[2] 
          "Stator current space phasor with respect to the stator fixed frame";
        Modelica.SIunits.Current i_sr[2] 
          "Stator current space phasor with respect to the rotor fixed frame";
        Modelica.SIunits.Current i_rs[2] 
          "Rotor current space phasor with respect to the stator fixed frame";
        Modelica.SIunits.Current i_rr[2] 
          "Rotor current space phasor with respect to the rotor fixed frame";
        Modelica.SIunits.Current i_ms[2] 
          "Magnetizing current space phasor with respect to the stator fixed frame";
        Modelica.SIunits.MagneticFlux psi_ms[2] 
          "Magnetizing flux phasor with respect to the stator fixed frame";
        Modelica.SIunits.MagneticFlux psi_mr[2] 
          "Magnetizing flux phasor with respect to the rotor fixed frame";
        Real RotationMatrix[2,2] "matrix of rotation from rotor to stator";
      protected 
        parameter Modelica.SIunits.Inductance L[2,2] = {{Lm,0},{0,Lm}} 
          "inductance matrix";
      public 
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
          annotation (extent=[-10, 90; 10, 110]);
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
        Interfaces.SpacePhasor spacePhasor_s 
          annotation (extent=[-110,90; -90,110]);
        Interfaces.SpacePhasor spacePhasor_r 
          annotation (extent=[90,90; 110,110]);
      equation 
        // mechanical angle of the rotor of an equivalent 2-pole machine
        gammam=p*flange_a.phi;
        RotationMatrix={{+cos(gammam),-sin(gammam)},{+sin(gammam),+cos(gammam)}};
        i_ss = spacePhasor_s.i_;
        i_ss = RotationMatrix*i_sr;
        i_rr = spacePhasor_r.i_;
        i_rs = RotationMatrix*i_rr;
        // Magnetizing current with respect to the stator reference frame
        i_ms = i_ss + i_rs;
        // Magnetizing flux linkage with respect to the stator reference frame
        psi_ms = L*i_ms;
        // Magnetizing flux linkage with respect to the rotor reference frame
        psi_mr = transpose(RotationMatrix)*psi_ms;
        // Stator voltage induction
        spacePhasor_s.v_ = der(psi_ms);
        // Rotor voltage induction
        spacePhasor_r.v_ = der(psi_mr);
        // Electromechanical torque (cross product of current and flux space phasor)
        tau_electrical = m/2*p*(spacePhasor_s.i_[2]*psi_ms[1] - spacePhasor_s.i_[1]*psi_ms[2]);
        flange_a.tau = -tau_electrical;
      end AirGapS;
      
      model AirGapR "Airgap in stator-fixed coordinate system" 
        constant Integer m=3 "number of phases";
        parameter Real p "number of pole pairs";
        parameter Modelica.SIunits.Inductance Lmd "main inductance d-axis";
        parameter Modelica.SIunits.Inductance Lmq "main inductance q-axis";
        output Modelica.SIunits.Torque tau_electrical;
        Modelica.SIunits.Angle gammam;
        Modelica.SIunits.Current i_ss[2] 
          "Stator current space phasor with respect to the stator fixed frame";
        Modelica.SIunits.Current i_sr[2] 
          "Stator current space phasor with respect to the rotor fixed frame";
        Modelica.SIunits.Current i_rs[2] 
          "Rotor current space phasor with respect to the stator fixed frame";
        Modelica.SIunits.Current i_rr[2] 
          "Rotor current space phasor with respect to the rotor fixed frame";
        Modelica.SIunits.Current i_mr[2] 
          "Magnetizing current space phasor with respect to the stator fixed frame";
        Modelica.SIunits.MagneticFlux psi_ms[2] 
          "Magnetizing flux phasor with respect to the stator fixed frame";
        Modelica.SIunits.MagneticFlux psi_mr[2] 
          "Magnetizing flux phasor with respect to the rotor fixed frame";
        Real RotationMatrix[2,2] "matrix of rotation from rotor to stator";
      protected 
        parameter Modelica.SIunits.Inductance L[2,2] = {{Lmd,0},{0,Lmq}} 
          "inductance matrix";
      public 
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
          annotation (extent=[-10, 90; 10, 110]);
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
Model of the airgap in stator-fixed coordinate system, using only equations.
</p>
</HTML>"));
        Interfaces.SpacePhasor spacePhasor_s 
          annotation (extent=[-110,90; -90,110]);
        Interfaces.SpacePhasor spacePhasor_r 
          annotation (extent=[90,90; 110,110]);
      equation 
        // mechanical angle of the rotor of an equivalent 2-pole machine
        gammam=p*flange_a.phi;
        RotationMatrix={{+cos(gammam),-sin(gammam)},{+sin(gammam),+cos(gammam)}};
        i_ss = spacePhasor_s.i_;
        i_ss = RotationMatrix*i_sr;
        i_rr = spacePhasor_r.i_;
        i_rs = RotationMatrix*i_rr;
        // Magnetizing current with respect to the rotor reference frame
        i_mr = i_sr + i_rr;
        // Main flux linkage with respect to the stator reference frame
        psi_mr = L*i_mr;
        // Main flux linkage with respect to the stator reference frame
        psi_ms = RotationMatrix*psi_mr;
        // Stator voltage induction
        spacePhasor_s.v_ = der(psi_ms);
        // Rotor voltage induction
        spacePhasor_r.v_ = der(psi_mr);
        // Electromechanical torque (cross product of current and flux space phasor)
        tau_electrical = m/2*p*(spacePhasor_s.i_[2]*psi_ms[1] - spacePhasor_s.i_[1]*psi_ms[2]);
        flange_a.tau = -tau_electrical;
      end AirGapR;
      
      model SquirrelCage "Squirrel Cage" 
        parameter Modelica.SIunits.Inductance Lrsigma 
          "rotor stray inductance per phase translated to stator";
        parameter Modelica.SIunits.Resistance Rr 
          "warm rotor resistance per phase translated to stator";
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
        Interfaces.SpacePhasor spacePhasor_r 
                                           annotation (extent=[-110,90; -90,110]);
      equation 
        spacePhasor_r.v_ = Rr * spacePhasor_r.i_ + Lrsigma * der(spacePhasor_r.i_);
      end SquirrelCage;
      
      model PermanentMagnet "Permanent magnet excitation" 
        parameter Modelica.SIunits.Current Ie "Equivalent excitation current";
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
        Interfaces.SpacePhasor spacePhasor_r 
          annotation (extent=[-110,90; -90,110]);
      equation 
        spacePhasor_r.i_ = {-Ie,0};
      end PermanentMagnet;
    end Components;
  end Basic;
  
  package SpacePhasors "Library with space phasor-models" 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains components, blocks and functions to utilize space phasor theory.
</p>
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
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
    package Components "Basic space phasor models" 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<HTML>
<p>
This package contains basic space phasor models:
<ul>
<li>SpacePhasor: physical transformation of voltages and currents three phase <-> space phasors</li>
</ul>
Real and imaginary part of voltage space phasor are the potentials v_[2] of the space phasor connector; (implicit grounded).<br>
Real and imaginary part of current space phasor are the currents i_[2] at the space phasor connector;
a ground has to be used where necessary for currents flowing back.<br>
Zero-sequence voltage and current are present at pin zero. An additional zero-sequence impedance could be connected between pin zero and pin ground.
</p>
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
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
      
      model SpacePhasor 
        "Physical transformation: three phase <-> space phasors" 
        constant Real pi=Modelica.Constants.pi;
        constant Integer m=3 "number of phases";
        Modelica.SIunits.Voltage v[m] "instantaneous phase voltages";
        Modelica.SIunits.Current i[m] "instantaneous phase currents";
      protected 
        parameter Real TransformationMatrix[m, 2]=
          {{cos(-(k - 1)/m*2*pi),-sin(-(k - 1)/m*2*pi)} for k in 1:m};
      public 
        MultiPhase.Interfaces.PositivePlug plug_p(final m=m) 
          annotation (extent=[-110, 90; -90, 110]);
        MultiPhase.Interfaces.NegativePlug plug_n(final m=m) 
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
Physical transformation of voltages and currents: three phases <-> space phasors:<br>
x[k] = X0 + {cos(-(k - 1)/m*2*pi),-sin(-(k - 1)/m*2*pi) * X[Re,Im]<br>
and vice versa:<br>
X0 = sum(x[k])/m<br>
X[Re,Im] = sum(2/m*{cos((k - 1)/m*2*pi),sin((k - 1)/m*2*pi)}*x[k])<br>
were x designates three phase values, X[Re,Im] designates the space phasor and X0 designates the zero sequence system.<br>
<i>Physcial transformation</i> means that both voltages and currents are transformed in both directions.
</p>
</HTML>"));
        Interfaces.SpacePhasor spacePhasor annotation (extent=[90,90; 110,110]);
      equation 
        v = plug_p.pin.v - plug_n.pin.v;
        i = +plug_p.pin.i;
        i = -plug_n.pin.i;
        v = fill(zero.v, m) + TransformationMatrix*spacePhasor.v_;
        -i = fill(zero.i, m) + TransformationMatrix*spacePhasor.i_;
        connect(gnd.p, ground) annotation (points=[70,-90; 100,-90; 100,-100], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=3,
            rgbfillColor={0,0,255},
            fillPattern=1));
      end SpacePhasor;
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
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
      
      block ToSpacePhasor "Conversion: three phase -> space phasor" 
        extends Modelica.Blocks.Interfaces.MIMO(final nin=m, final nout=2);
        constant Integer m=3 "number of phases";
        Modelica.Blocks.Interfaces.RealOutput zero 
          annotation (extent=[90, -80; 110, -100]);
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
                  -20; -3.33, -17.32; 3.33, -10; 10, 0], style(color=3))),
          Documentation(info="<HTML>
<p>
Transformation of threephase values (voltages or currents) to space phasor and zero sequence value, using <i>Function TospacePhasor</i>.
</p>
</HTML>"));
      equation 
        (y,zero) = Functions.ToSpacePhasor(u);
      end ToSpacePhasor;
      
      block FromSpacePhasor "Conversion: space phasor -> three phase" 
        extends Modelica.Blocks.Interfaces.MIMO(final nin=2, final nout=m);
        constant Integer m=3 "number of phases";
        Modelica.Blocks.Interfaces.RealInput zero 
          annotation (extent=[-110, -80; -90, -100]);
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
                  -17.32; 83.33, -10; 90, 0], style(color=3))),
          Documentation(info="<HTML>
<p>
Transformation of space phasor and zero sequence value to threephase values (voltages or currents), using <i>Function FromSpacecePhasor</i>.
</p>
</HTML>"));
      equation 
        y = Functions.FromSpacePhasor(u, zero);
      end FromSpacePhasor;
      
      block Rotator "Rotates space phasor" 
        extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
        Modelica.Blocks.Interfaces.RealInput angle(
            redeclare type SignalType = Modelica.SIunits.Angle) 
          annotation (extent=[-10, 110; 10, 90], rotation=-270);
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
                  fillColor=3))),
          Documentation(info="<HTML>
<p>
Rotates a space phasor (voltage or current) by the angle provided by inPort <i>Angle</i> from one coordinate system into another, using <i>Function Rotator</i>.
</p>
</HTML>"));
      equation 
        y = Functions.Rotator(u, angle);
      end Rotator;
      
      block ToPolar "Converts a space phasor to polar coordinates" 
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
              string="R"),
            Text(
              extent=[6, 6; 100, -100],
              style(color=3, rgbcolor={0,0,255}),
              string="P")),
          Documentation(info="<HTML>
<p>
Converts a space phasor from rectangular coordinates to polar coordinates, using <i>Function ToPolar</i>.
</p>
</HTML>"));
      equation 
        (y[1],y[2]) = Functions.ToPolar(u);
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
Converts a space phasor from polar coordinates to rectangular coordinates, using <i>Function FromPolar</i>.
</p>
</HTML>"));
      equation 
        y = Functions.FromPolar(u[1], u[2]);
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
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
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
          y := y + 2/m*{cos((k - 1)/m*2*pi),sin((k - 1)/m*2*pi)}*x[k];
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
        annotation (Documentation(info="<HTML>
<p>
Rotates a space phasor (voltage or current) by the angle provided by inPort <i>Angle</i> from one coordinate system into another:<br>
y[Re,Im] := {{+cos(-angle),-sin(-angle)},{+sin(-angle),+cos(-angle)}}*x[Re,Im]<br>
where y[Re,Im] designates the space phasor in the new coordinate system (twisted by angle against old coordinate system) and y[Re,Im] designates the space phasor in the old coordinate system.
</p>
</HTML>"));
      algorithm 
        y := {{+cos(-angle),-sin(-angle)},{+sin(-angle),+cos(-angle)}}*x;
      end Rotator;
      
      function ToPolar "Converts a space phasor to polar coordinates" 
        extends Modelica.Icons.Function;
        constant Real pi=Modelica.Constants.pi;
        constant Real small=Modelica.Constants.SMALL;
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
        angle := if (abs(x[1]) <= small and abs(x[2]) <= small) then 0 else 
          Modelica.Math.atan2(x[2], x[1]);
      end ToPolar;
      
      function FromPolar "Converts a space phasor from polar coordinates" 
        extends Modelica.Icons.Function;
        constant Real pi=Modelica.Constants.pi;
        constant Real small=Modelica.Constants.SMALL;
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
end Machines;
