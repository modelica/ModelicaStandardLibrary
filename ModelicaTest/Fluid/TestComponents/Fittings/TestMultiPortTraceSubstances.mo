within ModelicaTest.Fluid.TestComponents.Fittings;
model TestMultiPortTraceSubstances
  "Test model for multiport and volumes with trace substances."
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"});
  Modelica.Fluid.Sources.Boundary_pT source2(
    redeclare package Medium = Medium,
    X=Medium.X_default,
    nPorts=3,
    p=100000,
    T=278.15)
    annotation (Placement(transformation(
        origin={90,-20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  Modelica.Fluid.Sources.Boundary_pT source1(
    T=system.T_ambient,
    use_p_in=true,
    redeclare package Medium = Medium,
    use_C_in=true,
    use_X_in=true,
    nPorts=3,
    p=500000)
    annotation (Placement(transformation(extent={{-68,-28},{-48,-8}},  rotation=
           0)));
  Modelica.Blocks.Sources.Ramp P(
    duration=1,
    height=-40,
    offset=1E5 + 20)
                annotation (Placement(transformation(extent={{-100,24},{-80,44}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp C(duration=1, height=1.519E-3)
    "substance concentration, raising to 1000 PPM CO2"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.Constant X(k=0.02)
    annotation (Placement(transformation(extent={{-100,-8},{-80,12}})));
  Modelica.Blocks.Sources.RealExpression X2(y=1 - X.y) "Concentration of X[2]"
    annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
  Modelica.Fluid.Vessels.ClosedVolume volume1(
    redeclare package Medium = Medium,
    nPorts=3,
    C_start={1E-4},
    use_portsData=false,
    V=1) annotation (Placement(transformation(extent={{12,20},{32,40}})));
  Modelica.Fluid.Vessels.ClosedVolume volume2(
    redeclare package Medium = Medium,
    nPorts=3,
    C_start={1E-4},
    use_portsData=false,
    V=1) annotation (Placement(transformation(extent={{12,-20},{32,0}})));
  Modelica.Fluid.Vessels.ClosedVolume volume3(
    redeclare package Medium = Medium,
    V=1,
    nPorts=3,
    C_start={1E-4},
    use_portsData=false)
    annotation (Placement(transformation(extent={{12,-80},{32,-60}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance1(      redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{36,24},{56,44}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance2(      redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{34,-16},{54,4}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance3(      redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{36,-76},{56,-56}})));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    diameter=0.1,
    redeclare package Medium = Medium,
    length=1) annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    diameter=0.1,
    redeclare package Medium = Medium,
    length=1) annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Modelica.Fluid.Pipes.StaticPipe pipe3(
    diameter=0.1,
    redeclare package Medium = Medium,
    length=1,
    nParallel=1) annotation (Placement(transformation(extent={{52,-90},{72,-70}})));
  Modelica.Fluid.Fittings.MultiPort multiPort(
                                       nPorts_b=2, redeclare package Medium =
        Medium)                             annotation (Placement(
        transformation(extent={{-36,-10},{-28,10}},rotation=0)));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{-54,18},{-34,38}})));
  Modelica.Fluid.Pipes.StaticPipe pipe4(
    diameter=0.1,
    redeclare package Medium = Medium,
    length=1) annotation (Placement(transformation(extent={{-16,10},{4,30}})));
  Modelica.Fluid.Pipes.StaticPipe pipe5(
    diameter=0.1,
    redeclare package Medium = Medium,
    length=1) annotation (Placement(transformation(extent={{-16,-30},{4,-10}})));
  Modelica.Fluid.Pipes.StaticPipe pipe6(
    diameter=0.1,
    redeclare package Medium = Medium,
    length=1,
    nParallel=1) annotation (Placement(transformation(extent={{-16,-90},{4,-70}})));
equation
  connect(P.y, source1.p_in)    annotation (Line(points={{-79,34},{-74,34},{-74,
          -10},{-70,-10}},
        color={0,0,127}));
  connect(C.y, source1.C_in[1]) annotation (Line(
      points={{-79,-50},{-76,-50},{-76,-26},{-70,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(X.y, source1.X_in[1]) annotation (Line(
      points={{-79,2},{-76,2},{-76,-22},{-70,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(X2.y, source1.X_in[2]) annotation (Line(
      points={{-79,-22},{-70,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(volume1.ports[3], traceSubstance1.port) annotation (Line(
      points={{24.6667,20},{34,20},{34,24},{46,24}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume2.ports[3], traceSubstance2.port) annotation (Line(
      points={{24.6667,-20},{34,-20},{34,-16},{44,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume3.ports[3], traceSubstance3.port) annotation (Line(
      points={{24.6667,-80},{25,-80},{25,-76},{46,-76}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1.ports[2], pipe1.port_a) annotation (Line(
      points={{22,20},{50,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume2.ports[2], pipe2.port_a) annotation (Line(
      points={{22,-20},{50,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume3.ports[2], pipe3.port_a) annotation (Line(
      points={{22,-80},{52,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe1.port_b, source2.ports[1]) annotation (Line(
      points={{70,20},{70,-6},{80,-6},{80,-22.6667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe2.port_b, source2.ports[2]) annotation (Line(
      points={{70,-20},{80,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe3.port_b, source2.ports[3]) annotation (Line(
      points={{72,-80},{76,-80},{76,-17.3333},{80,-17.3333}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source1.ports[2], traceSubstance.port) annotation (Line(
      points={{-48,-18},{-44,-18},{-44,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source1.ports[1], multiPort.port_a) annotation (Line(
      points={{-48,-15.3333},{-44,-15.3333},{-44,0},{-36,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source1.ports[3], pipe6.port_a) annotation (Line(
      points={{-48,-20.6667},{-32,-20.6667},{-32,-80},{-16,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(multiPort.ports_b[1], pipe4.port_a) annotation (Line(
      points={{-28,2},{-22,2},{-22,20},{-16,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(multiPort.ports_b[2], pipe5.port_a) annotation (Line(
      points={{-28,-2},{-22,-2},{-22,-20},{-16,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe4.port_b, volume1.ports[1]) annotation (Line(
      points={{4,20},{19.3333,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe5.port_b, volume2.ports[1]) annotation (Line(
      points={{4,-20},{19.3333,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe6.port_b, volume3.ports[1]) annotation (Line(
      points={{4,-80},{19.3333,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}), graphics));
end TestMultiPortTraceSubstances;
