within ModelicaTest.Fluid.TestComponents.Sources;
model TestSources "Test model for models in source package"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"});
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium =
               Medium,
    nPorts=1,
    use_C_in=true,
    use_p_in=true)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Fluid.Sources.Boundary_ph boundary1(redeclare package Medium =
               Medium,
    nPorts=1,
    use_p_in=true,
    use_X_in=false,
    use_C_in=true)
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(redeclare package Medium =
               Medium,
    use_C_in=true,
    nPorts=1,
    m_flow=0.1)
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary3(redeclare package Medium =
               Medium,
    use_C_in=true,
    nPorts=1,
    m_flow=0.1)
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Modelica.Fluid.Sources.FixedBoundary boundary4(redeclare package Medium =
        Medium, nPorts=1)
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  Modelica.Fluid.Sources.Boundary_pT boundary5(redeclare package Medium =
        Medium,     nPorts=1)
                annotation (Placement(transformation(extent={{80,0},{60,20}})));
  Modelica.Fluid.Sources.Boundary_ph boundary6(nPorts=2, redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{96,-70},{76,-50}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(
    length=1,
    diameter=0.25,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    length=1,
    diameter=0.25,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    length=1,
    diameter=0.25,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Fluid.Pipes.StaticPipe pipe3(
    length=1,
    diameter=0.25,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent={{60,70},
            {80,90}},          rotation=0)));
  Modelica.Blocks.Sources.Ramp C(duration=1, height=1.519E-3)
    "substance concentration, raising to 1000 PPM CO2"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Ramp P(
    duration=2,
    height=-100,
    offset=101325 + 50) "Pressure"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  Modelica.Fluid.Sensors.TraceSubstancesTwoPort traceSubstance1(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{22,40},{42,60}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance2(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{-22,14},{-2,34}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance3(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{26,-26},{46,-6}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance4(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{-20,-74},{0,-54}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal junction(
                                                  redeclare package Medium =
        Medium)                             annotation (Placement(
        transformation(extent={{26,-50},{46,-30}}, rotation=0)));
equation
  connect(boundary.ports[1], pipe.port_a) annotation (Line(
      points={{-30,50},{-20,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary1.ports[1], pipe1.port_a) annotation (Line(
      points={{-30,10},{0,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe1.port_b, boundary5.ports[1]) annotation (Line(
      points={{20,10},{60,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary2.ports[1], pipe2.port_a) annotation (Line(
      points={{-30,-40},{0,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary3.ports[1], pipe3.port_a) annotation (Line(
      points={{-30,-80},{0,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe3.port_b, boundary6.ports[2]) annotation (Line(
      points={{20,-80},{46,-80},{46,-62},{76,-62}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(C.y, boundary.C_in[1]) annotation (Line(
      points={{-79,50},{-70,50},{-70,42},{-52,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P.y, boundary1.p_in) annotation (Line(
      points={{-79,10},{-72,10},{-72,18},{-52,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P.y, boundary.p_in) annotation (Line(
      points={{-79,10},{-72,10},{-72,58},{-52,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(C.y, boundary1.C_in[1]) annotation (Line(
      points={{-79,50},{-70,50},{-70,2},{-52,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe.port_b, traceSubstance1.port_a) annotation (Line(
      points={{0,50},{22,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(traceSubstance1.port_b, boundary4.ports[1]) annotation (Line(
      points={{42,50},{60,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe3.port_a, traceSubstance4.port) annotation (Line(
      points={{0,-80},{-6,-80},{-6,-74},{-10,-74}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(traceSubstance.port, pipe.port_b) annotation (Line(
      points={{10,70},{6,70},{6,50},{0,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe1.port_a, traceSubstance2.port) annotation (Line(
      points={{0,10},{-6,10},{-6,14},{-12,14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(C.y, boundary2.C_in[1]) annotation (Line(
      points={{-79,50},{-64,50},{-64,-48},{-50,-48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(C.y, boundary3.C_in[1]) annotation (Line(
      points={{-79,50},{-64,50},{-64,-88},{-50,-88}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe2.port_b, junction.port_1) annotation (Line(
      points={{20,-40},{26,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(junction.port_3, traceSubstance3.port) annotation (Line(
      points={{36,-30},{36,-26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(junction.port_2, boundary6.ports[1]) annotation (Line(
      points={{46,-40},{52,-40},{52,-58},{76,-58}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics), experiment(StopTime=2));
end TestSources;
