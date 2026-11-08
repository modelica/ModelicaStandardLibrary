within ModelicaTest.Electrical.PowerConverters.Examples.DCAC.PolyphaseTwoLevel;
model IdealInverterDrive "Test of pulse width modulation methods"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage V_LL=400 "RMS line-to-line voltage";
  parameter SI.Voltage V_DC=sqrt(2)*V_LL "Ideal DC volatge";
  parameter SI.Voltage Vmax=2/3*V_DC*cos(pi/6) "Max. output voltage";
  parameter SI.Frequency f_sw=2000 "Switching frequency";
  parameter SI.Voltage VNom=Vmax/sqrt(2) "Nominal RMS output voltage";
  parameter SI.Current INom=25*sqrt(3) "Nominal RMS phase current";
  parameter SI.Impedance ZNom=VNom/INom "Nominal reference impedance";
  parameter SI.Frequency fNom=50 "Nominal frequency";
  parameter SI.Frequency fRef=50 "Reference frequency";
  parameter SI.Torque TLoad=161.4 "Nominal load torque";
  parameter SI.AngularVelocity wLoad=Modelica.Units.Conversions.from_rpm(1440.45) "Nominal load speed";
  parameter SI.Inertia JLoad=0.29 "Load's moment of inertia";
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcPos(V=V_DC/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,80})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcNeg(V=V_DC/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,40})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,60})));
  Modelica.Electrical.PowerConverters.DCAC.Polyphase2Level multiPhase2Level
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Sources.Constant refFrequ(k=fRef)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    VNominal=VNom, fNominal=fNom, BasePhase=pi/2)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasorRef
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Electrical.PowerConverters.DCAC.Control.PWM pwm(
    pwmType=Modelica.Electrical.PowerConverters.Types.PWMType.SVPWM,
    uMax=Vmax, f=f_sw)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
  Modelica.Electrical.Machines.Utilities.TerminalBox
    terminalBox(terminalConnection="Y")
    annotation (Placement(transformation(extent={{20,-34},{40,-14}})));
  Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage
    imc(
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    Rs=imcData.Rs,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    Lszero=imcData.Lszero,
    Lssigma=imcData.Lssigma,
    Jr=imcData.Jr,
    Js=imcData.Js,
    frictionParameters=imcData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true, start=2*pi*fRef/imcData.p),
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    Lm=imcData.Lm,
    Lrsigma=imcData.Lrsigma,
    Rr=imcData.Rr,
    TrRef=imcData.TrRef,
    TsOperational=293.15,
    alpha20r=imcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData
    imcData(
    Rs=0.03*ZNom,
    Rr=0.04*ZNom,
    Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*imcData.fsNominal)*ZNom,
    Lm=3*sqrt(1 - 0.0667)/(2*pi*imcData.fsNominal)*ZNom,
    Lrsigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*imcData.fsNominal)*ZNom)
    "Induction machine data"
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    loadTorque(
    useSupport=false,
    tau_nominal=-TLoad,
    TorqueDirection=false,
    w_nominal=wLoad)
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor annotation
    (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={28,50})));
  Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor annotation
    (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-10})));
  Modelica.Blocks.Math.Harmonic h01V(f=fRef, k=1)
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Blocks.Math.Harmonic h01I(f=fRef, k=1)
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Modelica.Blocks.Math.RootMeanSquare rmsI(f=fRef)
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Modelica.Blocks.Math.RootMeanSquare rmsV(f=fRef)
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
initial equation
  imc.is[1:2] = zeros(2);
  imc.ir = zeros(2);
equation
  connect(pwm.fire_p, multiPhase2Level.fire_p)
    annotation (Line(points={{-6,41},{-6,48}},        color={255,0,255}));
  connect(pwm.fire_n, multiPhase2Level.fire_n)
    annotation (Line(points={{6,41},{6,48}},          color={255,0,255}));
  connect(dcNeg.n, multiPhase2Level.dc_n) annotation (Line(points={{-40,30},{-20,
          30},{-20,54},{-10,54}},
                           color={0,0,255}));
  connect(dcPos.p, multiPhase2Level.dc_p) annotation (Line(points={{-40,90},{-20,
          90},{-20,66},{-10,66}},
                           color={0,0,255}));
  connect(dcPos.n, ground.p)
    annotation (Line(points={{-40,70},{-40,60}}, color={0,0,255}));
  connect(ground.p, dcNeg.p)
    annotation (Line(points={{-40,60},{-40,50}}, color={0,0,255}));
  connect(pwm.u, toSpacePhasorRef.y)
    annotation (Line(points={{0,18},{0,10},{-19,10}},
                                               color={0,0,127}));
  connect(vfController.y, toSpacePhasorRef.u)
    annotation (Line(points={{-49,10},{-42,10}},
                                               color={0,0,127}));
  connect(refFrequ.y, vfController.u)
    annotation (Line(points={{-79,10},{-72,10}},
                                               color={0,0,127}));
  connect(loadTorque.flange,loadInertia. flange_b)
    annotation (Line(points={{80,-40},{70,-40}}));
  connect(terminalBox.plug_sn, imc.plug_sn)
    annotation (Line(points={{24,-30},{24,-30}}, color={0,0,255}));
  connect(terminalBox.plug_sp, imc.plug_sp)
    annotation (Line(points={{36,-30},{36,-30}}, color={0,0,255}));
  connect(imc.flange, loadInertia.flange_a)
    annotation (Line(points={{40,-40},{50,-40}}));
  connect(multiPhase2Level.ac, currentSensor.plug_p)
    annotation (Line(points={{10,60},{28,60}},         color={0,0,255}));
  connect(terminalBox.plugSupply, currentSensor.plug_n)
    annotation (Line(points={{30,-28},{28,-28},{28,40}}, color={0,0,255}));
  connect(terminalBox.plug_sp, voltageSensor.plug_p)
    annotation (Line(points={{36,-30},{36,-20},{50,-20}}, color={0,0,255}));
  connect(terminalBox.plug_sn, voltageSensor.plug_n)
    annotation (Line(points={{24,-30},{24,0},{50,0}}, color={0,0,255}));
  connect(voltageSensor.v[1], h01V.u)
    annotation (Line(points={{61,-10},{78,-10}}, color={0,0,127}));
  connect(currentSensor.i[1], h01I.u)
    annotation (Line(points={{39,50},{78,50}}, color={0,0,127}));
  connect(currentSensor.i[1], rmsI.u) annotation (Line(points={{39,50},{70,50},
          {70,80},{78,80}}, color={0,0,127}));
  connect(voltageSensor.v[1], rmsV.u) annotation (Line(points={{61,-10},{70,-10},
          {70,20},{78,20}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.5,
      Interval=0.001,
      Tolerance=1e-07),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(0.40, 0.50)}))));
end IdealInverterDrive;
