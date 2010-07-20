within ModelicaTest.Fluid.TestComponents.Fittings;
model TestWallFriction
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  // Modelica.Media.Water.WaterIF97_ph
  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in all components"                        annotation (
    choicesAllMatching =                                                                            true);
  parameter Modelica.SIunits.Length roughness = 0.025e-3;

  Modelica.Fluid.Sources.Boundary_pT ambient_a(redeclare package Medium =
        Medium,
    p=system.p_ambient,
    T=system.T_ambient,
    use_p_in=true,
    nPorts=4)
    annotation (Placement(transformation(extent={{-38,40},{-18,60}}, rotation=0)));
  Modelica.Blocks.Sources.TimeTable p_table(table=[0,0.99999e5; 10,1.00001e5])
    annotation (Placement(transformation(extent={{-80,40},{-60,60}}, rotation=0)));

  Modelica.Fluid.Sources.Boundary_pT ambient_p1(nPorts=1,
    redeclare package Medium = Medium,
    p=1.0e5,
    T=Modelica.SIunits.Conversions.from_degC(80))
    annotation (Placement(transformation(extent={{62,40},{42,60}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT ambient_p2(nPorts=1,
    redeclare package Medium = Medium,
    p=1.0e5,
    T=Modelica.SIunits.Conversions.from_degC(80))
    annotation (Placement(transformation(extent={{60,10},{40,30}}, rotation=0)));
  Modelica.Fluid.Pipes.BaseClasses.WallFriction.TestWallFrictionAndGravity
    pipe1(
    length=1,
    diameter=0.1,
    redeclare package Medium = Medium,
    roughness=roughness,
    port_a(m_flow(start=-0.6)),
    redeclare package WallFriction =
        Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed,
    dp_small=0.1,
    show_Re=true)     annotation (Placement(transformation(extent={{0,40},{20,
            60}}, rotation=0)));
  Modelica.Fluid.Pipes.BaseClasses.WallFriction.TestWallFrictionAndGravity
    pipe2(
    length=1,
    diameter=0.1,
    redeclare package Medium = Medium,
    roughness=roughness,
    redeclare package WallFriction =
        Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed (
           from_dp=false,
           show_Re=true),
    port_a(m_flow(start=-0.6)))     annotation (Placement(transformation(extent={{0,10},{20,
            30}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT ambient_p3(nPorts=1,
    redeclare package Medium = Medium,
    p=1.0e5,
    T=Modelica.SIunits.Conversions.from_degC(80))
    annotation (Placement(transformation(extent={{60,-20},{40,0}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT ambient_p4(nPorts=1,
    redeclare package Medium = Medium,
    p=1.0e5,
    T=Modelica.SIunits.Conversions.from_degC(80))
    annotation (Placement(transformation(extent={{60,-50},{40,-30}}, rotation=0)));
  Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.TestWallFriction pipe3(
    length=1,
    diameter=0.1,
    redeclare package Medium = Medium,
    roughness=roughness,
    dp_small=0.1)        annotation (Placement(transformation(extent={{0,-20},{
            20,0}}, rotation=0)));
  Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.TestWallFriction pipe4(
    length=1,
    diameter=0.1,
    from_dp=false,
    redeclare package Medium = Medium,
    roughness=roughness) annotation (Placement(transformation(extent={{0,-50},{
            20,-30}}, rotation=0)));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{68,74},{88,94}}, rotation=0)));
equation
  connect(p_table.y, ambient_a.p_in)
                                    annotation (Line(points={{-59,50},{-52,50},
          {-52,58},{-40,58}}, color={0,0,127}));
  connect(ambient_a.ports[1], pipe1.port_a)
                                      annotation (Line(points={{-18,53},{-9,53},
          {-9,50},{0,50}},
        color={0,127,255}));
  connect(pipe1.port_b, ambient_p1.ports[1])
    annotation (Line(points={{20,50},{42,50}}, color={0,127,255}));
  connect(pipe2.port_b, ambient_p2.ports[1])
    annotation (Line(points={{20,20},{40,20}}, color={0,127,255}));
  connect(ambient_a.ports[2], pipe2.port_a)
                                      annotation (Line(points={{-18,51},{-12,51},
          {-12,20},{0,20}}, color={0,127,255}));
  connect(pipe3.port_b,ambient_p3.ports[1])
    annotation (Line(points={{20,-10},{40,-10}}, color={0,127,255}));
  connect(pipe4.port_b,ambient_p4.ports[1])
    annotation (Line(points={{20,-40},{40,-40}}, color={0,127,255}));
  connect(ambient_a.ports[3], pipe3.port_a)
                                      annotation (Line(points={{-18,49},{-12,49},
          {-12,-10},{0,-10}}, color={0,127,255}));
  connect(ambient_a.ports[4], pipe4.port_a)
                                      annotation (Line(points={{-18,47},{-12,47},
          {-12,-40},{0,-40}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=10, NumberOfIntervals=10000),
    experimentSetupOutput,
    Documentation(info="<html>
<p>
5 different wall friction models are compared.
</p>

<p>
pipe1 and pipe2 should be identical to pipe3 and pipe4 for
pipe1.WallFriction = WallFriction.QuadraticTurbulent (since the same equations).
</p>

<p>
pipe1 and pipe2 should be identical to pressureLossPipe for
pipe1.WallFriction = WallFriction.Detailed (since the same equations).
</p>
</html>"));
end TestWallFriction;
