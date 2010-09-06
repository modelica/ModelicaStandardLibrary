within ModelicaTest.Fluid.TestComponents.Sensors;
model TestOnePortSensors2
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Vessels.ClosedVolume MixingVolume1(
    V=1e-3,
    use_T_start=false,
    redeclare package Medium = Medium,
    h_start=1e5,
    nPorts=2,
    use_portsData=false)
                 annotation (Placement(transformation(extent={{-34,30},{-14,50}},
          rotation=0)));

  Modelica.Fluid.Sources.MassFlowSource_h FlowSource2(nPorts=1,
    m_flow=1,
    h=2e5,
    redeclare package Medium = Medium,
    use_m_flow_in=true)
                   annotation (Placement(transformation(extent={{-68,30},{-48,
            50}}, rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume MixingVolume2(
    V=1e-3,
    use_T_start=false,
    redeclare package Medium = Medium,
    h_start=1.5e5,
    nPorts=2,
    use_portsData=false)
                 annotation (Placement(transformation(extent={{36,30},{56,50}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_ph Sink2(nPorts=1,             redeclare
      package Medium =
               Medium,
    p=101325,
    h=5e4)
    annotation (Placement(transformation(extent={{100,30},{80,50}}, rotation=0)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp ramp(
    height=2,
    offset=-1,
    duration=10)
               annotation (Placement(transformation(extent={{-100,30},{-80,50}},
          rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume MixingVolume3(
    V=1e-3,
    use_T_start=false,
    redeclare package Medium = Medium,
    h_start=1e5,
    nPorts=2,
    use_portsData=false)
                 annotation (Placement(transformation(extent={{-34,-30},{-14,
            -10}}, rotation=0)));
  Modelica.Fluid.Sources.MassFlowSource_h FlowSource1(nPorts=1,
    m_flow=1,
    h=2e5,
    redeclare package Medium = Medium,
    use_m_flow_in=true)
                   annotation (Placement(transformation(extent={{-68,-30},{-48,
            -10}}, rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume MixingVolume4(
    V=1e-3,
    use_T_start=false,
    redeclare package Medium = Medium,
    h_start=1.5e5,
    nPorts=2,
    use_portsData=false)
                 annotation (Placement(transformation(extent={{36,-30},{56,-10}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_ph Sink1(nPorts=1,             redeclare
      package Medium =
               Medium,
    p=101325,
    h=5e4)
    annotation (Placement(transformation(extent={{100,-30},{80,-10}}, rotation=
            0)));
  Modelica.Fluid.Sensors.TemperatureTwoPort Tmix2(redeclare package Medium =
        Medium) annotation (Placement(transformation(extent={{0,-30},{20,-10}},
          rotation=0)));
equation
  connect(ramp.y, FlowSource2.m_flow_in) annotation (Line(
      points={{-79,40},{-74,40},{-74,48},{-68,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp.y, FlowSource1.m_flow_in) annotation (Line(
      points={{-79,40},{-76,40},{-76,-12},{-68,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(FlowSource2.ports[1], MixingVolume1.ports[1]) annotation (Line(
      points={{-48,40},{-36,40},{-36,30},{-26,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MixingVolume1.ports[2], MixingVolume2.ports[2]) annotation (Line(
      points={{-22,30},{-5,30},{-5,32},{12,32},{12,30},{48,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MixingVolume2.ports[1], Sink2.ports[1]) annotation (Line(
      points={{44,30},{61,30},{61,40},{80,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(FlowSource1.ports[1], MixingVolume3.ports[1]) annotation (Line(
      points={{-48,-20},{-36,-20},{-36,-30},{-26,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MixingVolume3.ports[2], Tmix2.port_a) annotation (Line(
      points={{-22,-30},{-12,-30},{-12,-20},{0,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tmix2.port_b, MixingVolume4.ports[2]) annotation (Line(
      points={{20,-20},{32,-20},{32,-30},{48,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MixingVolume4.ports[1], Sink1.ports[1]) annotation (Line(
      points={{44,-30},{61,-30},{61,-20},{80,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}),
                      graphics),
                       experiment(StopTime=15, Algorithm="Euler"),
    experimentSetupOutput);
end TestOnePortSensors2;
