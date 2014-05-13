within ModelicaTest.Fluid.TestComponents.Sensors;
model TestTemperature1
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.StandardWater;
  parameter Real diameter_a = 0.1;
  parameter Real diameter_b = 0.2;
  parameter Real A_rel = (diameter_a/diameter_b)^2;
  parameter Real zeta =  (1 - A_rel)^2;

  Modelica.Fluid.Vessels.ClosedVolume volume1(
    use_T_start=false,
    redeclare package Medium = Medium,
    h_start=1e5,
    nPorts=2,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_portsData=false,
    p_start=101325,
    V=1e-3)      annotation (Placement(transformation(extent={{-30,30},{-10,50}},
          rotation=0)));

  Modelica.Fluid.Sources.MassFlowSource_h source1(
    nPorts=1,
    m_flow=1,
    h=2e5,
    redeclare package Medium = Medium,
    use_m_flow_in=true)
                   annotation (Placement(transformation(extent={{-68,30},{-48,
            50}}, rotation=0)));
  Modelica.Fluid.Sensors.Temperature Tmix1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{0,60},{20,80}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_ph sink1( nPorts=1,            redeclare
      package Medium =
               Medium,
    h=5e4,
    p=101325)
    annotation (Placement(transformation(extent={{100,30},{80,50}}, rotation=0)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp ramp(
    height=2,
    offset=-1,
    startTime=2,
    duration=10)
               annotation (Placement(transformation(extent={{-100,30},{-80,50}},
          rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume volume2(
    use_T_start=false,
    redeclare package Medium = Medium,
    h_start=1e5,
    nPorts=2,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_portsData=false,
    p_start=101325,
    V=1e-3)      annotation (Placement(transformation(extent={{-32,-30},{-12,
            -10}}, rotation=0)));

  Modelica.Fluid.Sources.MassFlowSource_h source2(
    nPorts=1,
    m_flow=1,
    h=2e5,
    redeclare package Medium = Medium,
    use_m_flow_in=true)
                   annotation (Placement(transformation(extent={{-68,-30},{-48,
            -10}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_ph sink2(nPorts=1,            redeclare
      package Medium =
               Medium,
    h=5e4,
    p=101325)
    annotation (Placement(transformation(extent={{100,-30},{80,-10}}, rotation=
            0)));
  Modelica.Fluid.Sensors.TemperatureTwoPort Tmix2(redeclare package Medium =
        Medium) annotation (Placement(transformation(extent={{0,-30},{20,-10}},
          rotation=0)));
  Modelica.Fluid.Fittings.SimpleGenericOrifice orifice1(
    redeclare package Medium = Medium,
    diameter=diameter_a,
    zeta=zeta) annotation (Placement(transformation(extent={{40,30},{60,50}},
          rotation=0)));
  Modelica.Fluid.Fittings.SimpleGenericOrifice orifice2(
    redeclare package Medium = Medium,
    zeta=zeta,
    diameter=diameter_a) annotation (Placement(transformation(extent={{40,-30},{60,-10}},
          rotation=0)));
  Modelica.SIunits.TemperatureDifference Tdiff = Tmix2.T - Tmix1.T;
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
  connect(orifice1.port_b,sink1.ports[1])
                                       annotation (Line(
      points={{60,40},{80,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(orifice2.port_a, Tmix2.port_b) annotation (Line(
      points={{40,-20},{20,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(orifice2.port_b,sink2.ports[1])
                                       annotation (Line(
      points={{60,-20},{80,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tmix1.port, orifice1.port_a) annotation (Line(
      points={{10,60},{10,40},{40,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source1.ports[1], volume1.ports[1])     annotation (Line(
      points={{-48,40},{-34,40},{-34,30},{-22,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1.ports[2], orifice1.port_a) annotation (Line(
      points={{-18,30},{10,30},{10,40},{40,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source2.ports[1], volume2.ports[1])     annotation (Line(
      points={{-48,-20},{-35,-20},{-35,-30},{-24,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume2.ports[2], Tmix2.port_a) annotation (Line(
      points={{-20,-30},{-11,-30},{-11,-20},{0,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (experiment(StopTime=15));
end TestTemperature1;
