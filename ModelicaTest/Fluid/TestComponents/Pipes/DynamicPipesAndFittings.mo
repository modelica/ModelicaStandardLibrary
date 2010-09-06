within ModelicaTest.Fluid.TestComponents.Pipes;
model DynamicPipesAndFittings
  import Modelica.Fluid;
extends Modelica.Icons.Example;
replaceable package Medium=Modelica.Media.Water.StandardWater;
//replaceable package Medium=Modelica.Media.Air.DryAirNasa;  //

 Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium = Medium,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (                                                                alpha0=
           500),
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    use_HeatTransfer=true,
    p_a_start=100000,
    p_b_start=100000,
    T_start=280)
            annotation (Placement(transformation(extent={{-30,68},{-10,88}},
          rotation=0)));

  Modelica.Fluid.Sources.Boundary_pT boundary2(nPorts=1,
    redeclare package Medium = Medium,
    p=1e5,
    T=300,
    use_p_in=true,
    use_T_in=false)                                      annotation (Placement(
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
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    length=0.4,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    p_a_start=100000,
    p_b_start=100000,
    T_start=300)
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
    height=1.0e5,
    duration=1) annotation (Placement(transformation(extent={{90,64},{78,76}},
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

  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
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
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    use_HeatTransfer=true,
    p_a_start=100000,
    p_b_start=100000,
    T_start=280,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
            annotation (Placement(transformation(extent={{-30,10},{-10,30}},
          rotation=0)));

  Modelica.Fluid.Sources.Boundary_pT boundary4(nPorts=1,
    redeclare package Medium = Medium,
    p=1e5,
    T=300,
    use_p_in=true,
    use_T_in=false)                                      annotation (Placement(
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
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    length=0.4,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    p_a_start=100000,
    p_b_start=100000,
    T_start=300)
            annotation (Placement(transformation(extent={{-80,-2},{-60,18}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT boundary3(nPorts=1,
    redeclare package Medium = Medium,
    p=150000,
    T=280)                                                          annotation (Placement(
        transformation(extent={{-108,-2},{-88,18}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp ramp1(
    offset=1e5,
    startTime=5,
    height=1.0e5,
    duration=1) annotation (Placement(transformation(extent={{96,8},{84,20}},
          rotation=0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe8(
    redeclare package Medium=Medium,
    length=1,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    p_a_start=100000,
    p_b_start=100000,
    T_start=360,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
            annotation (Placement(transformation(extent={{-30,-12},{-10,8}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[
                                              pipe2.n] heat1(each Q_flow=200,
      each alpha=10000,
      each T_ref=350)
    annotation (Placement(transformation(extent={{-72,22},{-52,42}}, rotation=0)));
 Modelica.Fluid.Pipes.DynamicPipe pipe9(
    redeclare package Medium = Medium,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (                                                                alpha0=
           500),
    use_HeatTransfer=true,
    p_a_start=100000,
    p_b_start=100000,
    T_start=280,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
            annotation (Placement(transformation(extent={{-29,-50},{-9,-30}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT boundary5(nPorts=1,
    redeclare package Medium = Medium,
    p=1e5,
    T=300,
    use_p_in=true,
    use_T_in=false)                                      annotation (Placement(
        transformation(extent={{70,-62},{50,-42}}, rotation=0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe10(
    redeclare package Medium=Medium,
    length=1,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    m_flow_start=0.1,
    p_b_start=100000,
    T_start=340,
    p_a_start=100000)
            annotation (Placement(transformation(extent={{14,-62},{34,-42}},
          rotation=0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe11(
    redeclare package Medium=Medium,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
    m_flow_start=0.1,
    length=0.4,
    p_a_start=100000,
    p_b_start=100000,
    T_start=300)
            annotation (Placement(transformation(extent={{-74,-62},{-54,-42}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT boundary6(nPorts=1,
    redeclare package Medium = Medium,
    p=150000,
    T=280)                                                          annotation (Placement(
        transformation(extent={{-110,-62},{-90,-42}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp ramp2(
    offset=1e5,
    startTime=5,
    height=1.0e5,
    duration=1) annotation (Placement(transformation(extent={{96,-52},{84,-40}},
          rotation=0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe12(
    redeclare package Medium=Medium,
    length=1,
    use_T_start=true,
    diameter=0.01,
    nNodes=5,
    m_flow_start=0.1,
    p_a_start=100000,
    p_b_start=100000,
    T_start=360,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
            annotation (Placement(transformation(extent={{-29,-72},{-9,-52}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[
                                              pipe2.n] heat2(each Q_flow=200,
      each alpha=10000,
      each T_ref=350)
    annotation (Placement(transformation(extent={{-72,-38},{-52,-18}}, rotation=
           0)));
  Modelica.Fluid.Fittings.MultiPort muliPort11(nPorts_b=2, redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-50,-62},{-42,-42}})));
  Modelica.Fluid.Fittings.MultiPort multiPort10(nPorts_b=2, redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{10,-62},{2,-42}})));
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
      points={{-88,8},{-80,8}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe7.port_b, pipe5.port_a) annotation (Line(
      points={{-60,8},{-42,8},{-42,20},{-30,20}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe7.port_b, pipe8.port_a) annotation (Line(
      points={{-60,8},{-42,8},{-42,-2},{-30,-2}},
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
  connect(ramp2.y, boundary5.p_in) annotation (Line(
      points={{83.4,-46},{77.7,-46},{77.7,-44},{72,-44}},
      color={0,0,127},
      thickness=0.5));
  connect(boundary6.ports[1], pipe11.port_a)
                                         annotation (Line(
      points={{-90,-52},{-74,-52}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe10.port_b, boundary5.ports[1])
                                         annotation (Line(
      points={{34,-52},{50,-52}},
      color={0,127,255},
      thickness=0.5));
  connect(heat2.port, pipe9.heatPorts)
                                      annotation (Line(
      points={{-52,-28},{-18.9,-28},{-18.9,-35.6}},
      color={191,0,0},
      thickness=0.5));
  connect(pipe11.port_b, muliPort11.port_a) annotation (Line(
      points={{-54,-52},{-50,-52}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(muliPort11.ports_b[2], pipe12.port_a) annotation (Line(
      points={{-42,-54},{-40,-54},{-40,-62},{-29,-62}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(muliPort11.ports_b[1], pipe9.port_a) annotation (Line(
      points={{-42,-50},{-40,-50},{-40,-40},{-29,-40}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(multiPort10.port_a, pipe10.port_a) annotation (Line(
      points={{10,-52},{14,-52}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pipe9.port_b, multiPort10.ports_b[1]) annotation (Line(
      points={{-9,-40},{0,-40},{0,-50},{2,-50}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pipe12.port_b, multiPort10.ports_b[2]) annotation (Line(
      points={{-9,-62},{0,-62},{0,-54},{2,-54}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
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
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}),
                      graphics),
                       experiment(StopTime=20, Tolerance=1e-005),
    experimentSetupOutput,
    Documentation(info="<html>
Test of different dynamic pipe models. The first system uses explicit junctions, in the third system some of the pipe models are replaced by non-symmetric components.
</html>"));
end DynamicPipesAndFittings;
