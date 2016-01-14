within ModelicaTest.Fluid.TestComponents.Valves;
model TestValveCharacteristics "Test characteristics of a valve"
extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT source1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=200000)
  annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Fluid.Valves.ValveIncompressible valve_linear(
    rho_nominal=1000,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=1,
    CvData=Modelica.Fluid.Types.CvTypes.Av,
    Av=240e-6,
    redeclare function valveCharacteristic =
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.linear,
    dp_nominal=100000)
            annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Modelica.Fluid.Sources.Boundary_pT sink1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    nPorts=1,
    p=100000)
  annotation (Placement(transformation(extent={{42,20},{22,40}})));
  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent={{60,60},
            {80,80}})));
  Modelica.Blocks.Sources.Ramp opening(
    height=1,
    offset=0,
    duration=1,
    startTime=0.1)
              annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Fluid.Valves.ValveIncompressible valve_constant(
    rho_nominal=1000,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=1,
    CvData=Modelica.Fluid.Types.CvTypes.Av,
    Av=240e-6,
    redeclare function valveCharacteristic =
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.one,
    dp_nominal=100000)
            annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  Modelica.Fluid.Valves.ValveIncompressible valve_quadratic(
    rho_nominal=1000,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=1,
    CvData=Modelica.Fluid.Types.CvTypes.Av,
    Av=240e-6,
    dp_nominal=100000,
    redeclare function valveCharacteristic =
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.quadratic)
            annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  Modelica.Fluid.Sources.Boundary_pT source2(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=200000)
  annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Fluid.Sources.Boundary_pT sink2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    nPorts=1,
    p=100000)
  annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  Modelica.Fluid.Sources.Boundary_pT source3(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=200000)
  annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Fluid.Sources.Boundary_pT sink3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    nPorts=1,
    p=100000)
  annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  Modelica.Fluid.Valves.ValveIncompressible valve_equalPercentage(
    rho_nominal=1000,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=1,
    CvData=Modelica.Fluid.Types.CvTypes.Av,
    Av=240e-6,
    dp_nominal=100000,
    redeclare function valveCharacteristic =
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.equalPercentage
        (delta=0.01))
            annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
  Modelica.Fluid.Sources.Boundary_pT source4(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=200000)
  annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Fluid.Sources.Boundary_pT sink4(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    nPorts=1,
    p=100000)
  annotation (Placement(transformation(extent={{40,-100},{20,-80}})));
equation
  connect(source1.ports[1], valve_linear.port_a)
                                   annotation (Line(points={{-60,30},{-45,30},{
          -30,30}},
        color={0,127,255}));
  connect(opening.y, valve_linear.opening) annotation (Line(
      points={{-59,70},{-20,70},{-20,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(opening.y, valve_constant.opening) annotation (Line(
      points={{-59,70},{-40,70},{-40,6},{-20,6},{-20,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(valve_linear.port_b, sink1.ports[1]) annotation (Line(
      points={{-10,30},{22,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(opening.y, valve_quadratic.opening) annotation (Line(
      points={{-59,70},{-40,70},{-40,-36},{-20,-36},{-20,-42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(valve_constant.port_a, source2.ports[1]) annotation (Line(
      points={{-30,-10},{-60,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valve_constant.port_b, sink2.ports[1]) annotation (Line(
      points={{-10,-10},{20,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source3.ports[1], valve_quadratic.port_a) annotation (Line(
      points={{-60,-50},{-30,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sink3.ports[1], valve_quadratic.port_b) annotation (Line(
      points={{20,-50},{-10,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(opening.y, valve_equalPercentage.opening) annotation (Line(
      points={{-59,70},{-40,70},{-40,-76},{-20,-76},{-20,-82}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(source4.ports[1], valve_equalPercentage.port_a) annotation (Line(
      points={{-60,-90},{-30,-90}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sink4.ports[1], valve_equalPercentage.port_b) annotation (Line(
      points={{20,-90},{-10,-90}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
 experiment(StopTime=1.2));
end TestValveCharacteristics;
