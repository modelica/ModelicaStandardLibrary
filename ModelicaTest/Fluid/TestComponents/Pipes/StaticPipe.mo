within ModelicaTest.Fluid.TestComponents.Pipes;
model StaticPipe
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater;
  //Modelica.Media.Water.StandardWater;

  Modelica.Fluid.Pipes.StaticPipe pipe1(
    redeclare package Medium = Medium,
    length=10,
    diameter=2.54e-2,
    p_a_start=500000,
    p_b_start=100000) annotation (Placement(transformation(extent={{-10,0},{10,
            20}}, rotation=0)));

  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1,
    redeclare package Medium = Medium,
    p=200000,
    T=300)   annotation (Placement(transformation(extent={{56,4},{44,16}},
          rotation=0)));

  inner Modelica.Fluid.System system
                        annotation (Placement(transformation(extent={{-100,60},
            {-80,80}}, rotation=0)));
  Modelica.Blocks.Sources.TimeTable p_table(table=[0,1e5; 10,3e5])
    annotation (Placement(transformation(extent={{-90,20},{-70,40}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT source(
    redeclare package Medium = Medium,
    p=system.p_ambient,
    T=system.T_ambient,
    use_p_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-56,4},{-44,16}},  rotation=0)));
equation
  connect(pipe1.port_b, sink.ports[1]) annotation (Line(
      points={{10,10},{44,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source.ports[1], pipe1.port_a) annotation (Line(
      points={{-44,10},{-10,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(p_table.y, source.p_in) annotation (Line(
      points={{-69,30},{-62,30},{-62,14.8},{-57.2,14.8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}),
            graphics),
    experiment(StopTime=10, NumberOfIntervals=10000),
    Documentation(info="<html>
Test of the StaticPipe model.
</html>"));
end StaticPipe;
