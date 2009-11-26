within ModelicaTest.Fluid.TestComponents.Vessels;
model TestMixingVolumes
  extends Modelica.Icons.Example;
  // package Medium = Modelica.Media.Water.StandardWater;
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;
  Modelica.Fluid.Vessels.ClosedVolume mixingVolume1(
    V=1e-3,
    use_T_start=false,
    h_start=1e5,
    redeclare package Medium = Medium,
    nPorts=3,
    use_portsData=false)
               annotation (Placement(transformation(extent={{-30,40},{-10,60}},
          rotation=0)));

  Modelica.Fluid.Sources.MassFlowSource_h flowSource2(nPorts=1,
    m_flow=1,
    h=2e5,
    redeclare package Medium = Medium)
                   annotation (Placement(transformation(extent={{-98,24},{-78,
            44}}, rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume mixingVolume2(
    V=1e-3,
    use_T_start=false,
    h_start=1e5,
    redeclare package Medium = Medium,
    nPorts=3,
    use_portsData=false)
               annotation (Placement(transformation(extent={{10,40},{30,60}},
          rotation=0)));
  Modelica.Fluid.Sensors.Temperature Tmix_in(
                                         redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}}, rotation=0)));
  Modelica.Fluid.Sensors.Temperature Tmix_out(
                                          redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{40,50},{60,70}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_ph sink2(nPorts=1,             redeclare
      package Medium =
               Medium,
    h=Medium.h_default,
    p=101325)
    annotation (Placement(transformation(extent={{100,30},{80,50}}, rotation=0)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
equation
  connect(flowSource2.ports[1], mixingVolume1.ports[2])
                                                  annotation (Line(points={{-78,34},
          {-52,34},{-20,34},{-20,40}},
                           color={0,127,255}));
  connect(mixingVolume2.ports[2],sink2. ports[1])
                                            annotation (Line(points={{20,40},{
          20,40},{80,40}},
                   color={0,127,255}));
  connect(Tmix_in.port, mixingVolume1.ports[1]) annotation (Line(
      points={{-50,50},{-50,36},{-22,36},{-22,40},{-22.6667,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tmix_out.port, mixingVolume2.ports[1]) annotation (Line(
      points={{50,50},{50,40},{17.3333,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mixingVolume1.ports[3], mixingVolume2.ports[3]) annotation (Line(
      points={{-17.3333,40},{-17.3333,36},{22.6667,36},{22.6667,40}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}),
                      graphics),
                       experiment(StopTime=10));
end TestMixingVolumes;
