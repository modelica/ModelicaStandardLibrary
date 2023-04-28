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
  BasicMachines.DCMachines.DC_CompoundExcited dcce(
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
    excitationTurnsRatio=dcceData.excitationTurnsRatio)
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=tRamp,
    startTime=tStart,
    height=-100,
    offset=101)
      annotation (Placement(transformation(extent={{60,0},{40,20}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-70,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant const(k=160)
    annotation (Placement(transformation(extent={{94,-50},{74,-30}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(useSupport=false)
    annotation (Placement(transformation(extent={{60,-50},{40,-30}})));
  Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,10})));
  parameter Utilities.ParameterRecords.DcCompoundExcitedData dcceData(excitationTurnsRatio=-7e-4)
    "DC machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Analog.Sources.ConstantVoltage constantVoltage(V=Ve)
    annotation (Placement(transformation(
        origin={-50,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(dcce.pin_esp,dcce. pin_an) annotation (Line(points={{-20,-34},{-20,-30},{-16,-30}}, color={0,0,255}));
  connect(speed.flange,dcce. flange) annotation (Line(points={{40,-40},{0,-40}}, color={0,0,0}));
  connect(const.y, speed.w_ref) annotation (Line(points={{73,-40},{62,-40}}, color={0,0,127}));
  connect(dcce.pin_ap, variableResistor.n) annotation (Line(points={{-4,-30},{0,-30},{0,0},{-1.77636e-15,0}}, color={0,0,255}));
  connect(ground.p, dcce.pin_en) annotation (Line(points={{-60,40},{-24,40},{-24,-40},{-20,-40}}, color={0,0,255}));
  connect(ramp.y, variableResistor.R) annotation (Line(points={{39,10},{12,10}}, color={0,0,127}));
  connect(variableResistor.p, dcce.pin_en)
    annotation (Line(points={{0,20},{0,40},{-24,40},{-24,-40},{-20,-40}}, color={0,0,255}));
  connect(constantVoltage.n, dcce.pin_en)
    annotation (Line(points={{-50,-20},{-50,-10},{-24,-10},{-24,-40},{-20,-40}}, color={0,0,255}));
  connect(constantVoltage.p, dcce.pin_eep) annotation (Line(points={{-50,-40},{-50,-50},{-20,-50},{-20,-46}}, color={0,0,255}));
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
