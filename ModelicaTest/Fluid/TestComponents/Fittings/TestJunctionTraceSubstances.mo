within ModelicaTest.Fluid.TestComponents.Fittings;
model TestJunctionTraceSubstances
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"});
  Modelica.Fluid.Fittings.TeeJunctionIdeal junction(
                                                  redeclare package Medium =
        Medium)                             annotation (Placement(
        transformation(extent={{0,-30},{20,-10}},  rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT source2(nPorts=1,
    T=278.15,
    redeclare package Medium = Medium,
    p=100000,
    X=Medium.X_default)
    annotation (Placement(transformation(
        origin={90,-20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Fluid.Sources.Boundary_pT source3(nPorts=1,
    T=283.15,
    redeclare package Medium = Medium,
    p=100000,
    X=Medium.X_default)
    annotation (Placement(transformation(
        origin={-30,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  Modelica.Fluid.Sources.Boundary_pT source1(
    T=system.T_ambient,
    use_p_in=true,
    redeclare package Medium = Medium,
    use_C_in=true,
    use_X_in=true,
    nPorts=1,
    p=500000)
    annotation (Placement(transformation(extent={{-68,-28},{-48,-8}},  rotation=
           0)));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    height=-40,
    offset=1E5 + 20)
                annotation (Placement(transformation(extent={{-100,24},{-80,44}},
          rotation=0)));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    length=1,
    diameter=0.1,
    redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{-24,-30},{-4,-10}},rotation=0)));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    length=1,
    diameter=0.1,
    redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{56,-30},{76,-10}}, rotation=0)));
  Modelica.Fluid.Pipes.StaticPipe pipe3(
    length=1,
    diameter=0.1,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(
        origin={-30,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Fluid.Fittings.TeeJunctionVolume junction1(
    redeclare package Medium = Medium,
    V=0.1,
    C_start={1E-4},
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    X_start=Medium.X_default)               annotation (Placement(
        transformation(extent={{30,-30},{50,-10}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT source4(nPorts=1,
    T=283.15,
    redeclare package Medium = Medium,
    p=100000,
    X=Medium.X_default)
    annotation (Placement(transformation(
        origin={10,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Fluid.Pipes.StaticPipe pipe4(
    length=1,
    diameter=0.1,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(
        origin={10,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Fluid.Sources.Boundary_pT source5(nPorts=1,
    T=283.15,
    redeclare package Medium = Medium,
    p=100000,
    X=Medium.X_default)
    annotation (Placement(transformation(
        origin={40,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Fluid.Pipes.StaticPipe pipe5(
    length=1,
    diameter=0.1,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(
        origin={40,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance2(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{56,4},{76,24}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{-70,16},{-50,36}})));
  Modelica.Blocks.Sources.Ramp C(duration=1, height=1.519E-3)
    "substance concentration, raising to 1000 PPM CO2"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.Constant X(k=0.02)
    annotation (Placement(transformation(extent={{-100,-8},{-80,12}})));
  Modelica.Blocks.Sources.RealExpression X2(y=1 - X.y) "Concentration of X[2]"
    annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
  Modelica.Fluid.Fittings.MultiPort multiPort(redeclare package Medium =
        Medium, nPorts_b=2)
    annotation (Placement(transformation(extent={{-42,-28},{-34,-8}})));
equation
  connect(ramp.y, source1.p_in) annotation (Line(points={{-79,34},{-74,34},{-74,
          -10},{-70,-10}},
        color={0,0,127}));
  connect(pipe1.port_b, junction.port_1)
    annotation (Line(points={{-4,-20},{0,-20}}, color={0,127,255}));
  connect(pipe2.port_b, source2.ports[1])
                                      annotation (Line(points={{76,-20},{76,-20},
          {80,-20}},
        color={0,127,255}));
  connect(junction.port_2, junction1.port_1) annotation (Line(
      points={{20,-20},{30,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(junction1.port_2, pipe2.port_a) annotation (Line(
      points={{50,-20},{56,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe3.port_b, source3.ports[1]) annotation (Line(
      points={{-30,40},{-30,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe4.port_a, junction.port_3) annotation (Line(
      points={{10,20},{10,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source4.ports[1], pipe4.port_b) annotation (Line(
      points={{10,60},{10,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source5.ports[1], pipe5.port_b) annotation (Line(
      points={{40,60},{40,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe5.port_a, junction1.port_3) annotation (Line(
      points={{40,20},{40,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(traceSubstance.port, pipe1.port_a) annotation (Line(
      points={{-60,16},{-28,16},{-28,-20},{-24,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(C.y, source1.C_in[1]) annotation (Line(
      points={{-79,-50},{-76,-50},{-76,-26},{-70,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe2.port_a, traceSubstance2.port) annotation (Line(
      points={{56,-20},{54,-20},{54,4},{66,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(X.y, source1.X_in[1]) annotation (Line(
      points={{-79,2},{-76,2},{-76,-22},{-70,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(X2.y, source1.X_in[2]) annotation (Line(
      points={{-79,-22},{-70,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(source1.ports[1], multiPort.port_a) annotation (Line(
      points={{-48,-18},{-42,-18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(multiPort.ports_b[1], pipe3.port_a) annotation (Line(
      points={{-34,-16},{-30,-16},{-30,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(multiPort.ports_b[2], pipe1.port_a) annotation (Line(
      points={{-34,-20},{-24,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}), graphics));
end TestJunctionTraceSubstances;
