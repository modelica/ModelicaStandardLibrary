within Modelica.Fluid.Examples;
model IncompressibleFluidNetwork
  "Multi-way connections of pipes and incompressible medium model"
  extends Modelica.Icons.Example;
  replaceable package Medium =
      Modelica.Media.Incompressible.Examples.Essotherm650
    constrainedby Modelica.Media.Interfaces.PartialMedium;

  model Pipe = Modelica.Fluid.Pipes.DynamicPipe;
  //model Pipe = Modelica.Fluid.Pipes.DynamicPipe(nNodes=1,modelStructure=Types.ModelStructure.a_v_b);

  Sources.Boundary_pT source(nPorts=1,
    redeclare package Medium = Medium,
    p=5.0e5,
    T=300) annotation (Placement(transformation(extent={{-98,4},{-86,16}},
          rotation=0)));
  Pipe pipe1(
    use_T_start=true,
    length=10,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    p_a_start=500000)                  annotation (Placement(transformation(
          extent={{-80,0},{-60,20}}, rotation=0)));

  Pipe pipe2(
    use_T_start=true,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    length=0.5,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    p_a_start=500000)                  annotation (Placement(transformation(
        origin={-50,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  Pipe pipe3(
    use_T_start=true,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    length=0.5,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    p_a_start=500000)                  annotation (Placement(transformation(
        origin={-50,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Pipe pipe4(
    use_T_start=true,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    length=2,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    p_a_start=500000)                  annotation (Placement(transformation(
          extent={{-20,-40},{0,-20}}, rotation=0)));
  Pipe pipe6(
    use_T_start=true,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    length=20,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    p_a_start=500000)                  annotation (Placement(transformation(
          extent={{20,-30},{40,-10}}, rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible valve1(
    redeclare package Medium = Medium,
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=1,
    rho_nominal=1000,
    dp_nominal=30000)
                annotation (Placement(transformation(extent={{-46,40},{-26,60}},
          rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible valve2(
    redeclare package Medium = Medium,
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=1,
    rho_nominal=1000,
    dp_nominal=30000)
                annotation (Placement(transformation(extent={{-46,-20},{-26,
            -40}}, rotation=0)));
  Pipe pipe7(
    use_T_start=true,
    length=10,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    p_a_start=500000)                  annotation (Placement(transformation(
          extent={{-20,40},{0,60}}, rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible valve3(
    redeclare package Medium = Medium,
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=1,
    rho_nominal=1000,
    dp_nominal=30000)
                annotation (Placement(transformation(extent={{60,0},{80,20}},
          rotation=0)));
  Sources.Boundary_pT sink(nPorts=1,
    redeclare package Medium = Medium,
    T=300,
    p=1.0e5)
           annotation (Placement(transformation(extent={{98,4},{86,16}},
          rotation=0)));
  inner Modelica.Fluid.System system
                        annotation (Placement(transformation(extent={{70,-92},
            {90,-72}},  rotation=0)));
  Modelica.Blocks.Sources.Step valveOpening1(
    height=-0.2,
    offset=1,
    startTime=1) annotation (Placement(transformation(extent={{-80,70},{-60,
            90}},  rotation=0)));
  Modelica.Blocks.Sources.Step valveOpening2(
    height=-0.2,
    offset=1,
    startTime=2) annotation (Placement(transformation(extent={{-80,-70},{-60,
            -50}}, rotation=0)));
  Modelica.Blocks.Sources.Step valveOpening3(
    height=-0.2,
    offset=1,
    startTime=3) annotation (Placement(transformation(extent={{40,70},{60,90}},
          rotation=0)));
  Pipe pipe8(
    use_T_start=true,
    length=10,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    p_a_start=500000)                  annotation (Placement(transformation(
        origin={10,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Pipe pipe9(
    use_T_start=true,
    length=10,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    p_a_start=500000)                  annotation (Placement(transformation(
          extent={{20,40},{40,60}}, rotation=0)));
  Pipe pipe10(
    use_T_start=true,
    length=10,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    p_a_start=500000)                  annotation (Placement(transformation(
          extent={{20,0},{40,20}},  rotation=0)));
  Pipe pipe5(
    use_T_start=true,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    length=20,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    p_a_start=500000)                  annotation (Placement(transformation(
          extent={{20,-60},{40,-40}}, rotation=0)));
equation
  connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-86,10},{-80,
          10}}, color={0,127,255}));
  connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-60,10},{-50,10},
          {-50,0}},      color={0,127,255}));
  connect(pipe1.port_b, pipe2.port_a) annotation (Line(points={{-60,10},{-50,10},
          {-50,20}},     color={0,127,255}));
  connect(pipe2.port_b, valve1.port_a) annotation (Line(points={{-50,40},{-50,
          50},{-46,50}}, color={0,127,255}));
  connect(valve2.port_b, pipe4.port_a) annotation (Line(points={{-26,-30},{-26,
          -30},{-20,-30}},
                 color={0,127,255}));
  connect(pipe3.port_b, valve2.port_a) annotation (Line(points={{-50,-20},{-50,
          -30},{-46,-30}},     color={0,127,255}));
  connect(valve1.port_b, pipe7.port_a) annotation (Line(points={{-26,50},{-26,
          50},{-20,50}},
                color={0,127,255}));
  connect(pipe6.port_b, valve3.port_a) annotation (Line(points={{40,-20},{50,
          -20},{50,10},{60,10}}, color={0,127,255}));
  connect(valve3.port_b, sink.ports[1]) annotation (Line(points={{80,10},{80,
          10},{86,10}},
        color={0,127,255}));
  connect(valveOpening1.y, valve1.opening) annotation (Line(points={{-59,80},
          {-36,80},{-36,58}},       color={0,0,127}));
  connect(valveOpening2.y, valve2.opening) annotation (Line(points={{-59,-60},
          {-36,-60},{-36,-38}},        color={0,0,127}));
  connect(valveOpening3.y, valve3.opening) annotation (Line(points={{61,80},{
          70,80},{70,18}},        color={0,0,127}));
  connect(pipe7.port_b, pipe9.port_a)
    annotation (Line(points={{0,50},{0,50},{20,50}},
                                              color={0,127,255}));
  connect(pipe7.port_b, pipe8.port_a) annotation (Line(points={{0,50},{10,50},{
          10,40}}, color={0,127,255}));
  connect(pipe9.port_b, valve3.port_a) annotation (Line(points={{40,50},{50,
          50},{50,10},{60,10}},
                        color={0,127,255}));
  connect(pipe8.port_b, pipe10.port_a) annotation (Line(points={{10,20},{10,10},
          {20,10}},color={0,127,255}));
  connect(pipe10.port_b, valve3.port_a) annotation (Line(points={{40,10},{60,10}},
                            color={0,127,255}));
  connect(pipe4.port_b, pipe6.port_a) annotation (Line(
      points={{0,-30},{10,-30},{10,-20},{20,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe8.port_b, pipe4.port_b) annotation (Line(
      points={{10,20},{10,-30},{0,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe5.port_a, pipe4.port_b) annotation (Line(
      points={{20,-50},{10,-50},{10,-30},{0,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe5.port_b, valve3.port_a) annotation (Line(
      points={{40,-50},{50,-50},{50,10},{60,10}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),
                      graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
         Documentation(info="<html>
This example demonstrates two aspects: the efficient treatment of multi-way connections
and the usage of an incompressible medium model.
<p>
Normally one would expect bad equation systems in multi-way connections
and possibly introduce mixing volumes to work around this.
Here the problem is treated with the the modelStructure=av_vb in the
<a href=\"Modelica://Modelica.Fluid.Pipes.DynamicPipe\">DynamicPipe</a> model.
Each pipe exposes the states of the outer fluid segments to the respective fluid ports.
Consequently the pressures of all connected pipe segments get lumped together into one mass balance
spanning the whole connection set. With the stream concept in the fluid ports, the energy and substance
balances remain independent in the connected pipe segments.
</p>
<p>
The model does not contain pressure dynamics as an incompressible medium is used (Essotherm650).
Pressure dynamics becomes present with a compressible medium model (e.g. StandardWater).
</p>

<p align=\"center\">
<img src=\"../Images/Fluid/Examples/IncompressibleFluidNetwork.png\" border=\"1\">
</p>

</html>"),
    experiment(StopTime=5),
    __Dymola_Commands(file=
          "Scripts/Fluid/IncompressibleFluidNetwork/plotJunctionPressuresAndValves.mos"
        "Plot junction pressures and valves"));
end IncompressibleFluidNetwork;
