within ModelicaTest.Fluid.TestComponents.Vessels;
model TestInitialization
  extends Modelica.Icons.Example;

  package Medium = Modelica.Media.Air.SimpleAir;
  //package Medium = Modelica.Media.Air.MoistAir;

  Modelica.Fluid.Sources.Boundary_pT sou1(nPorts=1,redeclare package Medium =
        Medium,
    p=101330,
    T=293.15)                                       annotation (Placement(
        transformation(extent={{-90,10},{-70,30}})));
  Modelica.Fluid.Sources.Boundary_pT sin1(nPorts=1,redeclare package Medium =
        Medium,
    p=101320,
    T=293.15)                                       annotation (Placement(
        transformation(extent={{90,10},{70,30}})));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    redeclare package Medium = Medium,
    diameter=0.25,
    length=10)     annotation (Placement(transformation(extent={{-50,10},{-30,
            30}})));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    redeclare package Medium = Medium,
    diameter=0.25,
    length=10)     annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Modelica.Fluid.Vessels.ClosedVolume vol1(
    redeclare package Medium = Medium,
    nPorts=2,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.25),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.25)},
    V=100)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      use_eps_Re=true)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
equation
  connect(sou1.ports[1], pipe1.port_a) annotation (Line(
      points={{-70,20},{-50,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe1.port_b, vol1.ports[1]) annotation (Line(
      points={{-30,20},{-2,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol1.ports[2], pipe2.port_a) annotation (Line(
      points={{2,20},{30,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe2.port_b, sin1.ports[1]) annotation (Line(
      points={{50,20},{70,20}},
      color={0,127,255},
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-100,-28},{100,-34}},
          lineColor={0,0,255},
          textString="See Documentation view for more info.")}),
                       experiment(StopTime=1, Tolerance=1e-6),
    Documentation(info="<html>
<p><h4>Original intention:</h4></p>
<p><br/>Ticket #63: Medium SimpleAir was missing stateSelect.prefer on pressure p. This led to the bad state m without start value and resulted in a division by zero. Work-around: Use Medium MoistAir.</p>
<p><h4>New intention:</h4></p>
<p>Ticket #1222 (TestInitialization does not initialize): The model uses StaticPipe models connected to a ClosedVolume with port models. This results in algebraic loops for the pressures between the pipes and the volume. The use of homotopy in its current form results in additional nonlinear equation systems. </p>
<p>Ticket #736 (Use of m_flow_small, m_flow_turbulent and dp_small): The model is motivated by air conditioning that is characterized by relatively small mass flow rates and very small pressure drops. The overall pressure drop is 10 Pa from source to sink. This pressure drop is almost completely taken by the tank outlet towards pipe2 under steady conditions. The pipes have a pressure drop between about 5 Pa and 1e-2 Pa each during the transient simulation. The mass flow rate starts at about 0.2 kg/s and reaches a steady value at about 6e-3 kg/s.</p>
<p>The classic setting in the Advanced tab of the system model introduce m_flow_small=1e-2 kg/s and dp_small=1 Pa per default. In particular dp_small is too large for the pipe models and can hardly be used for regularization of zero flow -- note that it may be appropriate for other component models, like the tank outlet. dp_small largely depends on the flow characteristics of individual component models.</p>
<p>With the new setting system.use_eps_Re=true only a nominal mass flow rate is configured. The nominal and small pressure drops as well as the transition between laminar and turbulent flow are calculated inside each component model individually. Using the default system.m_flow_nominall=1 kg/s, the pipes adjust their nominal pressure drop dp_fric_nominal to 100 Pa and dp_small to 1e-2 Pa. The volume adjusts the transition between laminar and turbulent flow through its ports at about m_flow_turbulent=4e-4 kg/s.</p>
<p>The variable <code><b>pipe1.port_a.m_flow</b></code> shows best the difference between different settings, e.g. for system.use_eps_Re=true vs. false.</p>
</html>"));
end TestInitialization;
