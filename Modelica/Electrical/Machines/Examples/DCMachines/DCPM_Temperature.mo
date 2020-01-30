within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_Temperature
  "Test example: Investigate temperature dependency of a DCPM motor"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "Actual armature voltage";
  parameter SI.Voltage Ve=100 "Actual excitation voltage";
  parameter SI.AngularVelocity w0=
      Modelica.Units.Conversions.from_rpm(1500) "No-load speed";
  parameter SI.Torque TLoad=63.66 "Nominal load torque";
  parameter SI.Inertia JLoad=0.15
    "Load's moment of inertia";
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
    wMechanical(start=w0, fixed=true),
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
    phiMechanical(fixed=true),
    ia(fixed=true),
    TaOperational=293.15,
    alpha20a=dcpmData.alpha20a,
    useThermalPort=true)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,70})));
  Modelica.Electrical.Analog.Basic.Ground groundArmature annotation (
      Placement(transformation(
        origin={-80,40},
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
    useSupport=false,
    stepTorque=-TLoad,
    offsetTorque=0,
    startTime=0.1) annotation (Placement(transformation(extent={{60,-10},
            {40,10}})));
  Machines.Thermal.DCMachines.ThermalAmbientDCPM thermalAmbientDCPM(
    useTemperatureInputs=true,
    Ta=293.15,
    Tpm=293.15)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.Exponentials exponential(
    offset=293.15,
    outMax=60,
    riseTime=3600,
    riseTimeConst=0.5,
    fallTimeConst=0.5,
    startTime=0.1)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.Constant const(k=293.15)
    annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData(
    alpha20a(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
    TaNominal=353.15,
    TaRef=353.15) "DC machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

equation
  connect(loadInertia.flange_b, loadTorque.flange)
    annotation (Line(points={{30,0},{30,0},{40,0}}));
  connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
      points={{0,0},{10,0}}));
  connect(armatureVoltage.n, groundArmature.p) annotation (Line(
      points={{-80,60},{-80,50}}, color={0,0,255}));
  connect(armatureVoltage.p, dcpm.pin_ap) annotation (Line(
      points={{-80,80},{-4,80},{-4,10}}, color={0,0,255}));
  connect(armatureVoltage.n, dcpm.pin_an) annotation (Line(
      points={{-80,60},{-16,60},{-16,10}}, color={0,0,255}));
  connect(exponential.y, thermalAmbientDCPM.TArmature) annotation (Line(
      points={{-39,-50},{-20,-50},{-20,-42}}, color={0,0,127}));
  connect(const.y, thermalAmbientDCPM.TPermanentMagnet) annotation (Line(
      points={{19,-50},{-10,-50},{-10,-42}}, color={0,0,127}));
  connect(dcpm.thermalPort, thermalAmbientDCPM.thermalPort) annotation (
      Line(points={{-10,-10},{-10,-15},{-10,-20}}, color={191,0,0}));
  annotation (experiment(StopTime=3.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<strong>Test example: Investigate influence of armature temperature on a DCPM motor</strong><br>
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
<li>The armature winding material is set to Copper.</li>
<li>Armature reference temperature is set to 80 degC.</li>
<li>Nominal armature temperature is set to 80 degC.</li>
</ul>
So the machine is at the beginning in cold condition, ending in warm condition
(with the same armature resistance as the unmodified machine).
</html>"));
end DCPM_Temperature;
