within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_Drive
  "Test example: drive with 2 permanent magnet DC machines"
  extends Modelica.Icons.Example;
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData "DC machine data"
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm1(
    VaNominal=dcpmData.VaNominal,
    IaNominal=dcpmData.IaNominal,
    wNominal=dcpmData.wNominal,
    TaNominal=dcpmData.TaNominal,
    Ra=dcpmData.Ra,
    TaRef=dcpmData.TaRef,
    La=dcpmData.La,
    Jr=dcpmData.Jr,
    useSupport=false,
    Js=dcpmData.Js,
    frictionParameters=dcpmData.frictionParameters,
    coreParameters=dcpmData.coreParameters,
    strayLoadParameters=dcpmData.strayLoadParameters,
    brushParameters=dcpmData.brushParameters,
    TaOperational=293.15,
    alpha20a=dcpmData.alpha20a,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    ia(fixed=true))
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  BasicMachines.DCMachines.DC_PermanentMagnet dcpm2(
    VaNominal=dcpmData.VaNominal,
    IaNominal=dcpmData.IaNominal,
    wNominal=dcpmData.wNominal,
    TaNominal=dcpmData.TaNominal,
    Ra=dcpmData.Ra,
    TaRef=dcpmData.TaRef,
    La=dcpmData.La,
    Jr=dcpmData.Jr,
    useSupport=false,
    Js=dcpmData.Js,
    frictionParameters=dcpmData.frictionParameters,
    coreParameters=dcpmData.coreParameters,
    strayLoadParameters=dcpmData.strayLoadParameters,
    brushParameters=dcpmData.brushParameters,
    TaOperational=293.15,
    alpha20a=dcpmData.alpha20a,
    phiMechanical(fixed=false),
    wMechanical(fixed=false),
    ia(fixed=true))
    annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
  Mechanics.Rotational.Components.Coupling coupling
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  ControlledDCDrives.Utilities.DcdcInverter dcdcInverter1(fS=1000, VMax=
        dcpmData.VaNominal)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  ControlledDCDrives.Utilities.DcdcInverter dcdcInverter2(fS=1000, VMax=
        dcpmData.VaNominal)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=0.5,
    height=0.5*dcpmData.VaNominal,
    offset=0,
    startTime=0.25)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Blocks.Sources.Ramp ramp2(
    duration=0.5,
    height=0.1*dcpmData.VaNominal,
    offset=0.5*dcpmData.VaNominal,
    startTime=1.25)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Analog.Ideal.IdealClosingSwitch switch annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,-30})));
  Blocks.Sources.BooleanStep booleanStep(startTime=1)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Analog.Sensors.MultiSensor multiSensor annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={10,70})));
  Analog.Sources.ConstantVoltage constantVoltage(V=dcpmData.VaNominal)
    annotation (Placement(transformation(extent={{-10,30},{-30,50}})));
  Analog.Basic.Resistor resistor(R=0.05*dcpmData.VaNominal/1000)
    annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={14,40})));
  Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,30})));
equation
  connect(dcpm1.flange, coupling.flange_a)
    annotation (Line(points={{-30,-60},{-10,-60}}, color={0,0,0}));
  connect(dcpm2.flange, coupling.flange_b)
    annotation (Line(points={{30,-60},{10,-60}}, color={0,0,0}));
  connect(booleanStep.y, switch.control)
    annotation (Line(points={{11,-30},{18,-30}}, color={255,0,255}));
  connect(ramp2.y, dcdcInverter2.vRef)
    annotation (Line(points={{11,0},{28,0}}, color={0,0,127}));
  connect(dcdcInverter1.vRef, ramp1.y)
    annotation (Line(points={{-52,0},{-69,0}}, color={0,0,127}));
  connect(dcpm1.pin_ap, dcdcInverter1.pin_pMot) annotation (Line(points={{-34,-50},
          {-30,-50},{-30,-20},{-34,-20},{-34,-10}}, color={0,0,255}));
  connect(dcdcInverter1.pin_nMot, dcpm1.pin_an) annotation (Line(points={{-46,-10},
          {-46,-20},{-50,-20},{-50,-50},{-46,-50}}, color={0,0,255}));
  connect(switch.n, dcpm2.pin_ap)
    annotation (Line(points={{30,-40},{30,-50},{34,-50}}, color={0,0,255}));
  connect(switch.p, dcdcInverter2.pin_nMot)
    annotation (Line(points={{30,-20},{34,-20},{34,-10}}, color={0,0,255}));
  connect(dcdcInverter2.pin_pMot, dcpm2.pin_an) annotation (Line(points={{46,-10},
          {46,-20},{50,-20},{50,-50},{46,-50}}, color={0,0,255}));
  connect(multiSensor.nc, dcdcInverter2.pin_pBat) annotation (Line(points={{10,80},
          {10,90},{46,90},{46,10}}, color={0,0,255}));
  connect(multiSensor.nc, dcdcInverter1.pin_pBat) annotation (Line(points={{10,80},
          {10,90},{-34,90},{-34,10}}, color={0,0,255}));
  connect(multiSensor.pc, multiSensor.pv)
    annotation (Line(points={{10,60},{20,60},{20,70}}, color={0,0,255}));
  connect(ground.p, constantVoltage.n)
    annotation (Line(points={{-70,40},{-30,40}}, color={0,0,255}));
  connect(constantVoltage.p, resistor.p)
    annotation (Line(points={{-10,40},{4,40}}, color={0,0,255}));
  connect(dcdcInverter1.pin_nBat, constantVoltage.n)
    annotation (Line(points={{-46,10},{-46,40},{-30,40}}, color={0,0,255}));
  connect(dcdcInverter2.pin_nBat, constantVoltage.n) annotation (Line(points={{34,
          10},{34,20},{-46,20},{-46,40},{-30,40}}, color={0,0,255}));
  connect(multiSensor.pc, resistor.n) annotation (Line(points={{10,60},{32,60},{
          32,40},{24,40}}, color={0,0,255}));
  connect(multiSensor.nv, constantVoltage.n) annotation (Line(points={{0,70},{-46,
          70},{-46,40},{-30,40}}, color={0,0,255}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<p>
This example demonstrates how to use a <a href=\"modelica://Modelica.Mechanics.Rotational.Components.Coupling\">coupling</a> 
to implement a drive consisting if two permanent magnet DC machines. 
Note that <code>dcpm1</code> is turning in positive direction, whereas <code>dcpm2</code> is turning in the opposite direction. 
Therefore, the armature of <code>dcpm2</code> is connected reversed to the source.
</p>
<p>
Machine <code>dcpm1</code> starts the drive with a voltage ramp up to half of the no-load speed, the armature of <code>dcpm2</code> is not connected. 
Since the induced voltage of <code>dcpm2</code> is the same as that of <code>dcdcInverter2</code>, the <code>switch</code> is closed without any transient. 
After that, the armature voltage of <code>dcpm2</code> is slightly increased, causing <code>dcpm2</code> to drive as motor and <code>dcpm1</code> to brake as generator. 
Therefore, the speed <code>coupling.w</code> increases. 
</p>
<p>
Note that in stationary operation the <code>battery</code> only delivers the losses of both machines, since power is exchanged directly between both machines. 
Only during short time spans with transient operation power is delivered back to the <code>battery</code>, 
which is the case after accelerating the whole drive when angular velocity settles. 
An additional energy storage between the battery and the inverters (like a large capacitor or a super capacitor) would help to avoid such situations 
and to smooth possible current spikes.
</p>
</html>"));
end DCPM_Drive;
