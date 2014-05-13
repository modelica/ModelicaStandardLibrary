within ModelicaTest.Fluid.TestComponents.Sensors;
model TestTemperature2
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Vessels.ClosedVolume volume1_1(
    use_T_start=false,
    redeclare package Medium = Medium,
    h_start=1e5,
    nPorts=3,
    use_portsData=false,
    V=1e-4)      annotation (Placement(transformation(extent={{-34,30},{-14,50}},
          rotation=0)));

  Modelica.Fluid.Sources.MassFlowSource_h source1(
    nPorts=1,
    m_flow=1,
    h=2e5,
    redeclare package Medium = Medium,
    use_m_flow_in=true)
                   annotation (Placement(transformation(extent={{-68,30},{-48,
            50}}, rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume volume1_2(
    use_T_start=false,
    redeclare package Medium = Medium,
    h_start=1.5e5,
    nPorts=3,
    use_portsData=false,
    V=1e-4)      annotation (Placement(transformation(extent={{36,30},{56,50}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_ph sink1(nPorts=1,             redeclare
      package Medium =
               Medium,
    h=5e4,
    p=101325)
    annotation (Placement(transformation(extent={{100,30},{80,50}}, rotation=0)));
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp ramp(
    height=2,
    offset=-1,
    duration=10,
    startTime=2)
               annotation (Placement(transformation(extent={{-100,30},{-80,50}},
          rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume volume2_1(
    use_T_start=false,
    redeclare package Medium = Medium,
    h_start=1e5,
    nPorts=2,
    use_portsData=false,
    V=1e-4)      annotation (Placement(transformation(extent={{-34,-30},{-14,
            -10}}, rotation=0)));
  Modelica.Fluid.Sources.MassFlowSource_h source2(
    nPorts=1,
    m_flow=1,
    h=2e5,
    redeclare package Medium = Medium,
    use_m_flow_in=true)
                   annotation (Placement(transformation(extent={{-68,-30},{-48,
            -10}}, rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume volume2_2(
    use_T_start=false,
    redeclare package Medium = Medium,
    h_start=1.5e5,
    nPorts=2,
    use_portsData=false,
    V=1e-4)      annotation (Placement(transformation(extent={{36,-30},{56,-10}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_ph sink2(nPorts=1,             redeclare
      package Medium =
               Medium,
    h=5e4,
    p=101325)
    annotation (Placement(transformation(extent={{100,-30},{80,-10}}, rotation=
            0)));
  Modelica.Fluid.Sensors.Temperature Tmix1_1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-34,24},{-14,4}})));
  Modelica.Fluid.Sensors.Temperature Tmix1_2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{36,24},{56,4}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort Tmix2(redeclare package Medium =
        Medium) annotation (Placement(transformation(extent={{0,-30},{20,-10}},
          rotation=0)));
  Modelica.SIunits.TemperatureDifference Tdiff = if source1.m_flow_in > 0 then Tmix2.T - Tmix1_1.T else Tmix2.T - Tmix1_2.T;
equation
  assert(abs(Tdiff)/50 < 1e-3, "OnePortTemperature and TwoPortTemperature shall give the same result");
  connect(ramp.y, source1.m_flow_in)     annotation (Line(
      points={{-79,40},{-74,40},{-74,48},{-68,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp.y, source2.m_flow_in)     annotation (Line(
      points={{-79,40},{-76,40},{-76,-12},{-68,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(source1.ports[1], volume1_1.ports[1])         annotation (Line(
      points={{-48,40},{-36,40},{-36,30},{-26.6667,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1_1.ports[2], volume1_2.ports[2])         annotation (Line(
      points={{-24,30},{46,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1_2.ports[1], sink1.ports[1])     annotation (Line(
      points={{43.3333,30},{61,30},{61,40},{80,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source2.ports[1], volume2_1.ports[1])         annotation (Line(
      points={{-48,-20},{-36,-20},{-36,-30},{-26,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume2_1.ports[2], Tmix2.port_a)     annotation (Line(
      points={{-22,-30},{-12,-30},{-12,-20},{0,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tmix2.port_b, volume2_2.ports[2])     annotation (Line(
      points={{20,-20},{32,-20},{32,-30},{48,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume2_2.ports[1],sink2. ports[1])     annotation (Line(
      points={{44,-30},{61,-30},{61,-20},{80,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tmix1_1.port, volume1_1.ports[3]) annotation (Line(
      points={{-24,24},{-24,30},{-21.3333,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tmix1_2.port, volume1_2.ports[3]) annotation (Line(
      points={{46,24},{46,30},{48.6667,30}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (experiment(StopTime=15));
end TestTemperature2;
