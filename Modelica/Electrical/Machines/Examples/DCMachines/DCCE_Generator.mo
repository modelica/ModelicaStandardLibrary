within Modelica.Electrical.Machines.Examples.DCMachines;
model DCCE_Generator "Test example: DC with compound excitation generating power"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Voltage Va=100 "Actual armature voltage";
  parameter Modelica.Units.SI.Time tStart=0.1 "Start of resistance ramp";
  parameter Modelica.Units.SI.Time tRamp=0.9 "Resistance ramp";
  parameter SI.Voltage Ve=100 "Actual excitation voltage";
  parameter Modelica.Units.SI.Torque TLoad=63.66 "Nominal load torque";
  parameter Modelica.Units.SI.AngularVelocity wLoad(displayUnit="rev/min")=1410*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter Modelica.Units.SI.Inertia JLoad=0.15 "Load's moment of inertia";
  BasicMachines.DCMachines.DC_CompoundExcited dcce1(
    VaNominal=dcceData.VaNominal,
    IaNominal=dcceData.IaNominal,
    wNominal=dcceData.wNominal,
    TaNominal=dcceData.TaNominal,
    ia(fixed=true, start=-1),
    IeNominal=dcceData.IeNominal,
    Ree=dcceData.Ree,
    TeNominal=dcceData.TeNominal,
    Ra=dcceData.Ra,
    TaRef=dcceData.TaRef,
    La=dcceData.La,
    Jr=dcceData.Jr,
    Js=dcceData.Js,
    frictionParameters=dcceData.frictionParameters,
    coreParameters=dcceData.coreParameters,
    strayLoadParameters=dcceData.strayLoadParameters,
    brushParameters=dcceData.brushParameters,
    Res=dcceData.Res,
    TeRef=dcceData.TeRef,
    Le=dcceData.Le,
    sigmae=dcceData.sigmae,
    TaOperational=293.15,
    alpha20a=dcceData.alpha20a,
    alpha20e=dcceData.alpha20e,
    TeOperational=293.15,
    excitationTurnsRatio=dcceData.excitationTurnsRatio) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=tRamp,
    startTime=tStart,
    height=-100,
    offset=101) annotation (Placement(transformation(extent={{60,50},{40,70}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(
        origin={-70,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant const(k=160)
    annotation (Placement(transformation(extent={{94,-10},{74,10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed1(useSupport=false)
    annotation (Placement(transformation(extent={{60,20},{40,40}})));
  Modelica.Electrical.Analog.Basic.VariableResistor variableResistor1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,60})));
  parameter Utilities.ParameterRecords.DcCompoundExcitedData dcceData(excitationTurnsRatio=-7e-4)
    "DC machine data"
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Analog.Sources.ConstantVoltage constantVoltage1(V=Ve)
    annotation (Placement(transformation(
        origin={-50,50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  BasicMachines.QuasiStaticDCMachines.DC_CompoundExcited dcce2(
    VaNominal=dcceData.VaNominal,
    IaNominal=dcceData.IaNominal,
    wNominal=dcceData.wNominal,
    TaNominal=dcceData.TaNominal,
    ia(start=-1),
    IeNominal=dcceData.IeNominal,
    Ree=dcceData.Ree,
    TeNominal=dcceData.TeNominal,
    Ra=dcceData.Ra,
    TaRef=dcceData.TaRef,
    La=dcceData.La,
    Jr=dcceData.Jr,
    Js=dcceData.Js,
    frictionParameters=dcceData.frictionParameters,
    coreParameters=dcceData.coreParameters,
    strayLoadParameters=dcceData.strayLoadParameters,
    brushParameters=dcceData.brushParameters,
    Res=dcceData.Res,
    TeRef=dcceData.TeRef,
    Le=dcceData.Le,
    sigmae=dcceData.sigmae,
    TaOperational=293.15,
    alpha20a=dcceData.alpha20a,
    alpha20e=dcceData.alpha20e,
    TeOperational=293.15,
    excitationTurnsRatio=dcceData.excitationTurnsRatio)
      annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Blocks.Sources.Ramp ramp2(
    duration=tRamp,
    startTime=tStart,
    height=-100,
    offset=101)
      annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
  Analog.Basic.Ground ground2 annotation (Placement(
        transformation(
        origin={-70,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Mechanics.Rotational.Sources.Speed speed2(useSupport=false)
    annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
  Analog.Basic.VariableResistor variableResistor2
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-20})));
  Analog.Sources.ConstantVoltage constantVoltage2(V=Ve)
    annotation (Placement(transformation(
        origin={-50,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(dcce1.pin_esp, dcce1.pin_an) annotation (Line(points={{-20,36},{-20,40},{-16,40}}, color={0,0,255}));
  connect(speed1.flange, dcce1.flange) annotation (Line(points={{40,30},{0,30}}, color={0,0,0}));
  connect(const.y, speed1.w_ref) annotation (Line(points={{73,0},{68,0},{68,30},{62,30}}, color={0,0,127}));
  connect(dcce1.pin_ap, variableResistor1.n) annotation (Line(points={{-4,40},{0,40},{0,50}}, color={0,0,255}));
  connect(ground1.p, dcce1.pin_en) annotation (Line(points={{-60,80},{-24,80},{-24,30},{-20,30}}, color={0,0,255}));
  connect(ramp1.y, variableResistor1.R) annotation (Line(points={{39,60},{12,60}}, color={0,0,127}));
  connect(variableResistor1.p, dcce1.pin_en)
    annotation (Line(points={{0,70},{0,80},{-24,80},{-24,30},{-20,30}}, color={0,0,255}));
  connect(constantVoltage1.n, dcce1.pin_en)
    annotation (Line(points={{-50,60},{-50,70},{-24,70},{-24,30},{-20,30}}, color={0,0,255}));
  connect(constantVoltage1.p, dcce1.pin_eep) annotation (Line(points={{-50,40},{-50,20},{-20,20},{-20,24}}, color={0,0,255}));
  connect(dcce2.pin_esp, dcce2.pin_an) annotation (Line(points={{-20,-44},{-20,-40},{-16,-40}}, color={0,0,255}));
  connect(speed2.flange, dcce2.flange) annotation (Line(points={{40,-50},{0,-50}}, color={0,0,0}));
  connect(dcce2.pin_ap, variableResistor2.n) annotation (Line(points={{-4,-40},{0,-40},{0,-30}}, color={0,0,255}));
  connect(ground2.p, dcce2.pin_en) annotation (Line(points={{-60,0},{-24,0},{-24,-50},{-20,-50}}, color={0,0,255}));
  connect(ramp2.y, variableResistor2.R) annotation (Line(points={{39,-20},{12,-20}}, color={0,0,127}));
  connect(variableResistor2.p, dcce2.pin_en)
    annotation (Line(points={{0,-10},{0,0},{-24,0},{-24,-50},{-20,-50}}, color={0,0,255}));
  connect(constantVoltage2.n, dcce2.pin_en)
    annotation (Line(points={{-50,-20},{-50,-10},{-24,-10},{-24,-50},{-20,-50}}, color={0,0,255}));
  connect(constantVoltage2.p, dcce2.pin_eep) annotation (Line(points={{-50,-40},{-50,-60},{-20,-60},{-20,-56}}, color={0,0,255}));
  connect(const.y, speed2.w_ref) annotation (Line(points={{73,0},{68,0},{68,-50},{62,-50}}, color={0,0,127}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<h4>Test example: Compound excited DC machine with a variable resistor as load</h4>
<p>Compound excitation is a combination of series and shunt excitation. The shunt part maintains a constant idle voltage utilizing saturation effects.</p>
<p>When a load is applied, the series part increases the excitation flux to keep the voltage constant.</p>
<p>This behaviour can be adapted by the <span style=\"font-family: Courier New;\">dcce.excitationTurnsRatio</span> parameter. If the voltage should rise or fall with load applied. </p>
<p>Simulate for 2 seconds and plot (versus time): </p>
<ul>
<li>dcce.va: armature voltage</li>
<li>dcce.ia: armature current</li>
<li>dcce.tauElectrical: motor&apos;s torque</li>
</ul>
<p>Default machine parameters of model <i>DC_CompoundExcited</i> are used.</p>
<p>It is very imported to set a start value with <span style=\"font-family: Courier New;\">fixed=true</span> to <span style=\"font-family: Courier New;\">dcce.ia</span> as the excitation needs an initial stimulus to build up.</p>
</html>"));
end DCCE_Generator;
