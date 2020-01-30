within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_Cooling "Test example: Cooling of a DCPM motor"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "Actual armature voltage";
  parameter SI.Voltage Ve=100 "Actual excitation voltage";
  parameter SI.AngularVelocity w0=
      Modelica.Units.Conversions.from_rpm(1500) "No-load speed";
  parameter SI.Torque TLoad=63.66 "Nominal load torque";
  parameter SI.Inertia JLoad=0.15
    "Load's moment of inertia";
  parameter SI.Temperature TAmbient=293.15
    "Ambient temperature";
  parameter SI.HeatCapacity Ca=20
    "Armature's heat capacity";
  parameter SI.HeatCapacity Cc=50 "Core's heat capacity";
  final parameter SI.Power Losses=dcpm.Ra*dcpm.IaNominal^2
    "Nominal Losses";
  final parameter SI.Temperature T0=293.15
    "Reference temperature 20 degC";
  final parameter SI.TemperatureDifference dTCoolant=10
    "Coolant's temperature rise";
  final parameter SI.TemperatureDifference dTArmature=dcpm.TaNominal
       - T0 - dTCoolant/2 "Armature's temperature rise over coolant";
  parameter SI.ThermalConductance G_armature_core=2*Losses/
      dTArmature "Heat conductance armature - core";
  parameter SI.ThermalConductance G_core_cooling=2*Losses/
      dTArmature "Heat conductance core - cooling";
  parameter SI.VolumeFlowRate CoolantFlow=50 "Coolant flow";
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
    useThermalPort=true) "DC machine data"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
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
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Modelica.Mechanics.Rotational.Sources.Torque loadTorque(useSupport=
        false) annotation (Placement(transformation(extent={{60,20},{40,
            40}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=-1.5*TLoad,
    offset=0,
    period=1)
    annotation (Placement(transformation(extent={{90,20},{70,40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor armature(C=Ca, T(
        start=TAmbient, fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,-40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor armatureCore(
      G=G_armature_core)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor core(C=Cc, T(
        start=TAmbient, fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,-40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor coreCooling(G=
       G_core_cooling)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient inlet(
      constantAmbientTemperature=TAmbient, constantAmbientPressure=0)
    annotation (Placement(transformation(extent={{-10,-80},{-30,-60}})));
  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow(
    T0=TAmbient,
    constantVolumeFlow=CoolantFlow,
    m=0) annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Modelica.Thermal.FluidHeatFlow.Components.Pipe cooling(
    tapT=0.5,
    T0=TAmbient,
    m=0,
    h_g=0,
    V_flowLaminar=0.1,
    dpLaminar(displayUnit="Pa") = 0.1,
    V_flowNominal=1,
    dpNominal(displayUnit="Pa") = 1,
    T0fixed=false,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{30,-60},{50,-80}})));
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient outlet(
      constantAmbientTemperature=TAmbient, constantAmbientPressure=0)
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
      T=TAmbient)
    annotation (Placement(transformation(extent={{42,-10},{22,10}})));
protected
  Machines.Interfaces.DCMachines.ThermalPortDCPM thermalPort
    annotation (Placement(transformation(extent={{-14,-4},{-6,4}})));
public
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData(
    alpha20a(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
    TaNominal=353.15,
    TaRef=353.15)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

equation
  connect(loadInertia.flange_b, loadTorque.flange)
    annotation (Line(points={{30,30},{30,30},{40,30}}));
  connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
      points={{0,30},{10,30}}));
  connect(armatureVoltage.n, groundArmature.p) annotation (Line(
      points={{-80,60},{-80,50}}, color={0,0,255}));
  connect(armatureVoltage.p, dcpm.pin_ap) annotation (Line(
      points={{-80,80},{-4,80},{-4,40}}, color={0,0,255}));
  connect(armatureVoltage.n, dcpm.pin_an) annotation (Line(
      points={{-80,60},{-16,60},{-16,40}}, color={0,0,255}));
  connect(armature.port, armatureCore.port_a) annotation (Line(
      points={{-50,-30},{-40,-30}}, color={191,0,0}));
  connect(armatureCore.port_b, core.port) annotation (Line(
      points={{-20,-30},{-10,-30}}, color={191,0,0}));
  connect(core.port, coreCooling.port_a) annotation (Line(
      points={{-10,-30},{0,-30}}, color={191,0,0}));
  connect(pulse.y, loadTorque.tau) annotation (Line(
      points={{69,30},{62,30}}, color={0,0,127}));
  connect(coreCooling.port_b, cooling.heatPort) annotation (Line(
      points={{20,-30},{40,-30},{40,-60}}, color={191,0,0}));
  connect(cooling.flowPort_b, outlet.flowPort) annotation (Line(
      points={{50,-70},{60,-70}}, color={255,0,0}));
  connect(inlet.flowPort, volumeFlow.flowPort_a) annotation (Line(
      points={{-10,-70},{0,-70}}, color={255,0,0}));
  connect(volumeFlow.flowPort_b, cooling.flowPort_a) annotation (Line(
      points={{20,-70},{30,-70}}, color={255,0,0}));
  connect(armature.port, thermalPort.heatPortArmature) annotation (Line(
      points={{-50,-30},{-50,0},{-10,0}}, color={191,0,0}));
  connect(core.port, thermalPort.heatPortCore) annotation (Line(
      points={{-10,-30},{-10,0}}, color={191,0,0}));
  connect(fixedTemperature.port, thermalPort.heatPortStrayLoad)
    annotation (Line(
      points={{22,0},{-10,0}}, color={191,0,0}));
  connect(fixedTemperature.port, thermalPort.heatPortFriction)
    annotation (Line(
      points={{22,0},{-10,0}}, color={191,0,0}));
  connect(fixedTemperature.port, thermalPort.heatPortBrush) annotation (
      Line(
      points={{22,0},{-10,0}}, color={191,0,0}));
  connect(fixedTemperature.port, thermalPort.heatPortPermanentMagnet)
    annotation (Line(
      points={{22,0},{6,0},{6,-0.8},{-10.4,-0.8}}, color={191,0,0}));
  connect(dcpm.thermalPort, thermalPort) annotation (Line(points={{-10,20},
          {-10,10},{-10,0}}, color={191,0,0}));
  annotation (experiment(StopTime=25, Interval=1E-4, Tolerance=1E-6), Documentation(info=
         "<html>
<strong>Test example: Demonstrate cooling of a DCPM motor</strong><br>
The motor starts at no-load speed, then load pulses are applied.<br>
The cooling circuit consists of armature's thermal capacitance,
a thermal conductance between armature and core, core's thermal capacitance and
a thermal conductance between core and coolant.
The coolant flow circuit consists of inlet, volume flow, a pipe connected to the core and the outlet.<br>
<strong>Please note:</strong>
<ul>
<li>All unused heat ports of the thermal port (i.e., without loss sources in the machine: brush, stray, friction, permanent magnet) have to be connected to a constant temperature source.</li>
<li>The thermal capacitances (i.e., time constants) are unusual small to provide short simulation time!</li>
<li>The coolant is a theoretical coolant with specific mass = 1 kg/m3 and cp = 1 J/kg.K.</li>
<li>The thermal conductances as well as the coolant flow are parametrized such way, that:</li>
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
<li>The armature winding material is set to Copper.</li>
<li>Armature reference temperature is set to 80 degC.</li>
<li>Nominal armature temperature is set to 80 degC.</li>
</ul>
</html>"));
end DCPM_Cooling;
