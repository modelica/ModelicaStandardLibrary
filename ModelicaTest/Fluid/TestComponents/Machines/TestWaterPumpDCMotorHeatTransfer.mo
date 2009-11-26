within ModelicaTest.Fluid.TestComponents.Machines;
model TestWaterPumpDCMotorHeatTransfer
  "Test pump with dc motor (startup transient)"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT Source(nPorts=1, redeclare package Medium
      = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=100000)
  annotation (Placement(transformation(extent={{-50,-60},{-30,-40}},rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT Sink(nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    use_p_in=false,
    p=100000)
  annotation (Placement(transformation(extent={{80,0},{60,20}},  rotation=0)));
  Modelica.Fluid.Machines.Pump pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=1,
    N_nominal=1500,
    use_HeatTransfer=true,
    use_powerCharacteristic=true,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          V_flow_nominal={0,0.001,0.0015}, head_nominal={100,50,0}),
    redeclare function powerCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticPower
        (V_flow_nominal={0,0.001,0.0015}, W_nominal={550,650,800}),
    p_a_start=100000,
    p_b_start=100000)     annotation (Placement(transformation(extent={{-10,-5},
            {20,25}},  rotation=0)));
  Modelica.Blocks.Sources.Step valveOpening(
    offset=1,
    startTime=5,
    height=-1)
  annotation (Placement(transformation(extent={{70,40},{50,60}},   rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible Valve(
                                             redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    m_flow_nominal=1,
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    dp_nominal=1000000)
  annotation (Placement(transformation(extent={{31,0},{49,20}},  rotation=0)));
  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent={{50,-70},
            {70,-50}},         rotation=0)));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet
    motor(
    La=1e-3,
    Jr=0.1,
    inertiaRotor(w(
        fixed=true,
        displayUnit="1/min",
        start=0.10471975511966)),
    VaNominal=400,
    wNominal(displayUnit="1/min") = 157.07963267949,
    Ra=10,
    IaNominal=10)
           annotation (Placement(transformation(extent={{-54,28},{-30,52}})));
  Modelica.Electrical.Analog.Sources.StepVoltage stepVoltage(
    startTime=1,
    offset=0.1,
    V=400) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,40})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,2},{-70,24}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor housing(C=460*1)
    annotation (Placement(transformation(extent={{-1,-20},{19,-40}})));
equation
  connect(Valve.port_b,Sink.ports[1])    annotation (Line(points={{49,10},{60,
          10}},
        color={0,127,255}));
  connect(Valve.port_a,pump.port_b)      annotation (Line(points={{31,10},{20,
          10}},                             color={0,127,255}));
  connect(pump.port_a,Source.ports[1])
                                     annotation (Line(points={{-10,10},{-20,10},
          {-20,-50},{-30,-50}},
                              color={0,127,255}));
  connect(valveOpening.y, Valve.opening) annotation (Line(
      points={{49,50},{40,50},{40,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(motor.pin_ap, stepVoltage.p) annotation (Line(
      points={{-34.8,52},{-34,52},{-34,60},{-80,60},{-80,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(stepVoltage.n, motor.pin_an) annotation (Line(
      points={{-80,30},{-62,30},{-62,52},{-49.2,52}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(stepVoltage.n, ground.p) annotation (Line(
      points={{-80,30},{-80,24}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pump.heatPort, housing.port) annotation (Line(
      points={{11,1},{20,1},{20,-20},{9,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pump.shaft, motor.flange) annotation (Line(
      points={{5,25},{5,40},{-30,40}},
      color={0,0,0},
      smooth=Smooth.None));
annotation (
  Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}),
          graphics),
  experiment(StopTime=8, Tolerance=1e-006),
  Documentation(info=""));
end TestWaterPumpDCMotorHeatTransfer;
