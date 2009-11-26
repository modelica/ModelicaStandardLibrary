within ModelicaTest.Fluid.TestComponents.Vessels;
model TestInitialization
  extends Modelica.Icons.Example;

  package Medium = Modelica.Media.Air.SimpleAir;
  //package Medium = Modelica.Media.Air.MoistAir;

  Modelica.Fluid.Sources.Boundary_pT sou1(nPorts=1,redeclare package Medium =
        Medium,
    p=101330,
    T=293.15)                                       annotation (Placement(
        transformation(extent={{-90,10},{-70,30}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT sin1(nPorts=1,redeclare package Medium =
        Medium,
    p=101320,
    T=293.15)                                       annotation (Placement(
        transformation(extent={{90,10},{70,30}},   rotation=0)));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    redeclare package Medium = Medium,
    length=1,
    diameter=0.25) annotation (Placement(transformation(extent={{-50,10},{-30,
            30}},
          rotation=0)));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    redeclare package Medium = Medium,
    length=1,
    diameter=0.25) annotation (Placement(transformation(extent={{30,10},{50,30}},
          rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume vol1(
    redeclare package Medium = Medium,
    V=0.1,
    nPorts=2,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.25),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.25)})
    annotation (Placement(transformation(extent={{-10,20},{10,40}},rotation=0)));
  inner Modelica.Fluid.System system
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
          extent={{-100,-8},{100,-14}},
          lineColor={0,0,255},
          textString=
              "Problem: Medium SimpleAir missing stateSelect.prefer on pressure p (see Ticket #63)"),
        Text(
          extent={{-100,-28},{100,-34}},
          lineColor={0,0,255},
          textString=
              "This leads to the bad state m without start value and results in a division by zero"),
        Text(
          extent={{-100,-46},{100,-52}},
          lineColor={0,0,255},
          textString="Work-around: Use Medium MoistAir.")}),
                       experiment(StopTime=1));
end TestInitialization;
