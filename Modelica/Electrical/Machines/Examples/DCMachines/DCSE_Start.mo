within Modelica.Electrical.Machines.Examples.DCMachines;
model DCSE_Start
  "Test example: DC with serial excitation starting with voltage ramp"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "Actual armature voltage";
  parameter SI.Time tStart=0.1 "Start of resistance ramp";
  parameter SI.Time tRamp=0.9 "Resistance ramp";
  parameter SI.Torque TLoad=63.66 "Nominal load torque";
  parameter SI.AngularVelocity wLoad(displayUnit="rev/min")=
       1410*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter SI.Inertia JLoad=0.15
    "Load's moment of inertia";
  Machines.BasicMachines.DCMachines.DC_SeriesExcited dcse(
    VaNominal=dcseData.VaNominal,
    IaNominal=dcseData.IaNominal,
    wNominal=dcseData.wNominal,
    TaNominal=dcseData.TaNominal,
    TeNominal=dcseData.TeNominal,
    Ra=dcseData.Ra,
    TaRef=dcseData.TaRef,
    La=dcseData.La,
    Jr=dcseData.Jr,
    useSupport=false,
    Js=dcseData.Js,
    frictionParameters=dcseData.frictionParameters,
    coreParameters=dcseData.coreParameters,
    strayLoadParameters=dcseData.strayLoadParameters,
    brushParameters=dcseData.brushParameters,
    Re=dcseData.Re,
    TeRef=dcseData.TeRef,
    Le=dcseData.Le,
    sigmae=dcseData.sigmae,
    TaOperational=293.15,
    alpha20a=dcseData.alpha20a,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    ia(fixed=true),
    alpha20e=dcseData.alpha20e,
    TeOperational=293.15)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=tRamp,
    startTime=tStart,
    height=-1,
    offset=1) annotation (Placement(transformation(extent={{60,0},{40,20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=Va)
    annotation (Placement(transformation(extent={{0,50},{-20,30}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-70,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque(
    w_nominal=wLoad,
    TorqueDirection=false,
    tau_nominal=-TLoad,
    useSupport=false) annotation (Placement(transformation(extent={{90,-50},
            {70,-30}})));
  Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,10})));
  parameter Utilities.ParameterRecords.DcSeriesExcitedData dcseData "DC machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(constantVoltage.n, ground.p)
    annotation (Line(points={{-20,40},{-60,40}}, color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange)
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(dcse.pin_an, dcse.pin_ep) annotation (Line(points={{-16,-30},{-20,
          -30},{-20,-34}}, color={0,0,255}));
  connect(dcse.pin_en, constantVoltage.n) annotation (Line(points={{-20,-46},
          {-30,-46},{-30,-20},{-20,-20},{-20,40}}, color={0,0,255}));
  connect(dcse.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  connect(constantVoltage.p, variableResistor.p) annotation (Line(
      points={{0,40},{0,20}}, color={0,0,255}));
  connect(variableResistor.n, dcse.pin_ap) annotation (Line(
      points={{0,0},{0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
  connect(ramp.y, variableResistor.R) annotation (Line(
      points={{39,10},{12,10}}, color={0,0,127}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<strong>Test example: Series excited DC machine started with a series resistor</strong><br>
At constant source voltage, a series resistor limiting the armature current, is reduced according to a ramp, causing the DC machine to start,
and accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcse.ia: armature current</li>
<li>dcse.wMechanical: motor's speed</li>
<li>dcse.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <em>DC_SeriesExcited</em> are used.
</html>"));
end DCSE_Start;
