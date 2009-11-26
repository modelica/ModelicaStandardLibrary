within ModelicaTest.Fluid.TestComponents.Valves;
model TestValveCoefficients
  "Test case to compare different choices of flow coefficient"
  extends Modelica.Icons.Example;
  Modelica.Fluid.Sources.Boundary_pT SourceP1(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=200000)
  annotation (Placement(transformation(extent={{-94,18},{-74,38}},  rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible V1(
    rho_nominal=1000,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=1,
    CvData=Modelica.Fluid.Types.CvTypes.Av,
    Av=240e-6,
    dp_nominal=100000)
            annotation (Placement(transformation(extent={{-44,18},{-24,38}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT SinkP1(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=100000)
  annotation (Placement(transformation(extent={{28,18},{8,38}}, rotation=0)));
  Modelica.Blocks.Sources.Constant Opening(k=1)
              annotation (Placement(transformation(extent={{-96,62},{-76,82}},
          rotation=0)));
  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent={{64,60},
            {84,80}},          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT SourceP2(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=200000)
  annotation (Placement(transformation(extent={{-94,-18},{-74,2}},  rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible V2(
    rho_nominal=1000,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    CvData=Modelica.Fluid.Types.CvTypes.Kv,
    m_flow_nominal=1,
    Kv=9,
    dp_nominal=100000)
            annotation (Placement(transformation(extent={{-44,-18},{-24,2}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT SinkP2(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=100000)
  annotation (Placement(transformation(extent={{28,-18},{8,2}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT SourceP3(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=200000)
  annotation (Placement(transformation(extent={{-94,-56},{-74,-36}},rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible V3(
    rho_nominal=1000,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    CvData=Modelica.Fluid.Types.CvTypes.Cv,
    Cv=10,
    m_flow_nominal=1,
    dp_nominal=100000)
            annotation (Placement(transformation(extent={{-44,-56},{-24,-36}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT SinkP3(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=100000)
  annotation (Placement(transformation(extent={{28,-56},{8,-36}},
                                                                rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT SourceP4(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=200000)
  annotation (Placement(transformation(extent={{-94,-88},{-74,-68}},rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible V4(
    rho_nominal=1000,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    Cv=10,
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    dp_nominal=100000,
    m_flow_nominal=2.4)
            annotation (Placement(transformation(extent={{-44,-88},{-24,-68}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT SinkP4(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=100000)
  annotation (Placement(transformation(extent={{28,-88},{8,-68}},
                                                                rotation=0)));
equation

  connect(V1.port_b,SinkP1.ports[1])
                                  annotation (Line(points={{-24,28},{8,28}}));
  connect(Opening.y,V1. opening)
  annotation (Line(points={{-75,72},{-34,72},{-34,36}}, color={0,0,255}));
  connect(SourceP1.ports[1],V1.port_a)
                                   annotation (Line(points={{-74,28},{-44,28}},
        color={0,127,255}));
  connect(V2.port_b,SinkP2.ports[1])
                                  annotation (Line(points={{-24,-8},{8,-8}}));
  connect(SourceP2.ports[1],V2.port_a)
                                   annotation (Line(points={{-74,-8},{-44,-8}},
        color={0,127,255}));
  connect(V3.port_b,SinkP3.ports[1])
                                  annotation (Line(points={{-24,-46},{8,-46}}));
  connect(SourceP3.ports[1],V3.port_a)
                                   annotation (Line(points={{-74,-46},{-44,-46}},
        color={0,127,255}));
  connect(V2.opening, Opening.y) annotation (Line(
      points={{-34,0},{-34,8},{-62,8},{-62,72},{-75,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(V3.opening, Opening.y) annotation (Line(
      points={{-34,-38},{-34,-26},{-62,-26},{-62,72},{-75,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(V4.port_b,SinkP4.ports[1])
                                  annotation (Line(points={{-24,-78},{8,-78}}));
  connect(SourceP4.ports[1],V4.port_a)
                                   annotation (Line(points={{-74,-78},{-44,-78}},
        color={0,127,255}));
  connect(V4.opening, Opening.y) annotation (Line(
      points={{-34,-70},{-34,-58},{-62,-58},{-62,72},{-75,72}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics));
end TestValveCoefficients;
