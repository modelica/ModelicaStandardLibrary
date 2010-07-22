within ModelicaTest.Fluid.TestComponents.Pipes;
model DynamicPipesWithTraceSubstances
  import Modelica.Fluid;
extends Modelica.Icons.Example;
//replaceable package Medium=Modelica.Media.Water.StandardWater;
 replaceable package Medium=Modelica.Media.Air.DryAirNasa(extraPropertiesNames={"CO2", "VOC"});

 Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium = Medium,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    length=2,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (alpha0=500),
    p_a_start=100000,
    p_b_start=100000,
    T_start=280)
            annotation (Placement(transformation(extent={{-30,68},{-10,88}},
          rotation=0)));

  Modelica.Fluid.Sources.Boundary_pT boundary2(nPorts=1,
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=false,
    p=100000,
    T=300,
    C={1.5E-3,0.05E-3})                                             annotation (Placement(
        transformation(extent={{70,54},{50,74}}, rotation=0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    redeclare package Medium=Medium,
    length=1,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    p_b_start=100000,
    T_start=340,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    p_a_start=100000)
            annotation (Placement(transformation(extent={{20,54},{40,74}},
          rotation=0)));

  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium=Medium,
    use_T_start=true,
    T_start=300,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    p_b_start=1.0e5,
    length=0.4,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    p_a_start=100000)
            annotation (Placement(transformation(extent={{-82,54},{-62,74}},
          rotation=0)));

  Modelica.Fluid.Sources.Boundary_pT boundary1(nPorts=1,
    T=280,
    redeclare package Medium = Medium,
    p=1.5e5)                                                        annotation (Placement(
        transformation(extent={{-108,54},{-88,74}}, rotation=0)));

  Modelica.Blocks.Sources.Ramp ramp(
    offset=1e5,
    startTime=5,
    duration=0,
    height=1.0e5)
                annotation (Placement(transformation(extent={{90,64},{78,76}},
          rotation=0)));

  Modelica.Fluid.Pipes.DynamicPipe pipe4(
    redeclare package Medium=Medium,
    length=1,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    p_b_start=100000,
    T_start=360,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    p_a_start=100000)
            annotation (Placement(transformation(extent={{-30,38},{-10,58}},
          rotation=0)));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{72,-94},{92,-74}}, rotation=0)));
  Modelica.Fluid.Fittings.TeeJunctionVolume junction1(
    redeclare package Medium = Medium,
    V=0.0001,
    p_start=100000,
    T_start=300)                       annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, rotation=90,
        origin={-42,64})));
  Modelica.Fluid.Fittings.TeeJunctionVolume junction2(
    redeclare package Medium = Medium,
    V=0.00001,
    p_start=100000,
    T_start=300)                       annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
                                   rotation=-90,
        origin={2,64})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[
                                              pipe2.n] heat(each Q_flow=200,
      each alpha=10000,
      each T_ref=350)
    annotation (Placement(transformation(extent={{-54,80},{-34,100}}, rotation=
            0)));
 Modelica.Fluid.Pipes.DynamicPipe pipe5(
    redeclare package Medium = Medium,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    length=2,
    use_HeatTransfer=true,
    p_a_start=100000,
    p_b_start=100000,
    T_start=280,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (alpha0=500))
            annotation (Placement(transformation(extent={{-30,10},{-10,30}},
          rotation=0)));

  Modelica.Fluid.Sources.Boundary_pT boundary4(nPorts=1,
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=false,
    p=100000,
    T=300,
    C={1.5E-3,0.05E-3})                                             annotation (Placement(
        transformation(extent={{68,-2},{48,18}}, rotation=0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe6(
    redeclare package Medium=Medium,
    length=1,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    p_b_start=100000,
    T_start=340,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    p_a_start=100000)
            annotation (Placement(transformation(extent={{14,-2},{34,18}},
          rotation=0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe7(
    redeclare package Medium=Medium,
    use_T_start=true,
    T_start=300,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    p_b_start=1.0e5,
    length=0.4,
    p_a_start=100000)
            annotation (Placement(transformation(extent={{-74,-2},{-54,18}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT boundary3(nPorts=1,
    redeclare package Medium = Medium,
    p=150000,
    T=280)                                                          annotation (Placement(
        transformation(extent={{-108,-2},{-88,18}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp ramp1(
    offset=1e5,
    startTime=5,
    duration=0,
    height=1.0e5)
                annotation (Placement(transformation(extent={{96,8},{84,20}},
          rotation=0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe8(
    redeclare package Medium=Medium,
    length=1,
    use_T_start=true,
    diameter=0.01,
    T_start=360,
    nNodes=5,
    m_flow_start=0.1,
    p_b_start=1.0e5,
    p_a_start=100000)
            annotation (Placement(transformation(extent={{-30,-12},{-10,8}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[
                                              pipe2.n] heat1(each Q_flow=200,
      each alpha=10000,
      each T_ref=350)
    annotation (Placement(transformation(extent={{-72,22},{-52,42}}, rotation=0)));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance3(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{-98,22},{-78,42}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance1(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{-90,80},{-70,100}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance2(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{32,80},{52,100}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance4(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{2,22},{22,42}})));
  Modelica.Fluid.Fittings.MultiPort multiPort(redeclare package Medium =
        Medium, nPorts_b=2)
    annotation (Placement(transformation(extent={{-46,-2},{-38,18}})));
equation
  connect(boundary1.ports[1], pipe1.port_a)
                                        annotation (Line(
      points={{-88,64},{-82,64}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe3.port_b, boundary2.ports[1])
                                        annotation (Line(
      points={{40,64},{50,64}},
      color={0,127,255},
      thickness=0.5));
  connect(heat.port, pipe2.heatPorts)
                                     annotation (Line(
      points={{-34,90},{-19.9,90},{-19.9,82.4}},
      color={191,0,0},
      thickness=0.5));
  connect(ramp1.y, boundary4.p_in) annotation (Line(
      points={{83.4,14},{76.7,14},{76.7,16},{70,16}},
      color={0,0,127},
      thickness=0.5));
  connect(boundary3.ports[1], pipe7.port_a)
                                        annotation (Line(
      points={{-88,8},{-74,8}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe5.port_b, pipe6.port_a) annotation (Line(
      points={{-10,20},{2,20},{2,8},{14,8}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe8.port_b, pipe6.port_a) annotation (Line(
      points={{-10,-2},{2,-2},{2,8},{14,8}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe6.port_b, boundary4.ports[1])
                                        annotation (Line(
      points={{34,8},{48,8}},
      color={0,127,255},
      thickness=0.5));
  connect(heat1.port, pipe5.heatPorts)
                                      annotation (Line(
      points={{-52,32},{-19.9,32},{-19.9,24.4}},
      color={191,0,0},
      thickness=0.5));
  connect(boundary2.p_in, ramp.y) annotation (Line(
      points={{72,72},{74.7,72},{74.7,70},{77.4,70}},
      color={0,0,127},
      thickness=0.5));
  connect(junction2.port_3, pipe3.port_a) annotation (Line(
      points={{12,64},{20,64}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pipe2.port_b, junction2.port_1) annotation (Line(
      points={{-10,78},{2,78},{2,74}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pipe4.port_b, junction2.port_2) annotation (Line(
      points={{-10,48},{2,48},{2,54}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pipe1.port_b, junction1.port_3) annotation (Line(
      points={{-62,64},{-52,64}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(junction1.port_1, pipe4.port_a) annotation (Line(
      points={{-42,54},{-42,48},{-30,48}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(junction1.port_2, pipe2.port_a) annotation (Line(
      points={{-42,74},{-42,78},{-30,78}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(traceSubstance1.port, pipe1.port_b) annotation (Line(
      points={{-80,80},{-60,80},{-60,64},{-62,64}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe7.port_a, traceSubstance3.port) annotation (Line(
      points={{-74,8},{-80,8},{-80,22},{-88,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe3.port_b, traceSubstance2.port) annotation (Line(
      points={{40,64},{42,64},{42,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(traceSubstance4.port, pipe6.port_a) annotation (Line(
      points={{12,22},{12,8},{14,8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe7.port_b, multiPort.port_a) annotation (Line(
      points={{-54,8},{-46,8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(multiPort.ports_b[1], pipe5.port_a) annotation (Line(
      points={{-38,10},{-32,10},{-32,20},{-30,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(multiPort.ports_b[2], pipe8.port_a) annotation (Line(
      points={{-38,6},{-38,8},{-32,8},{-32,-2},{-30,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}), graphics),
                       experiment(StopTime=20, Tolerance=1e-005),
    experimentSetupOutput,
    Documentation(info="<html>
Test of different dynamic pipe models with trace substances.
</html>"));
end DynamicPipesWithTraceSubstances;
