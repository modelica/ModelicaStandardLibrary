within ModelicaTest.Fluid.TestComponents.Valves;
model TestCheckValve "Test case for check valve"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  Modelica.Fluid.Sources.Boundary_pT SourceP1(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    T(displayUnit="degC") = 298.15)
  annotation (Placement(transformation(extent={{-76,-22},{-56,-2}})));
  Fluid.Valves.ValveIncompressible  V1(
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=2,
    checkValve=true,
    dp_nominal=100000)
            annotation (Placement(transformation(extent={{-26,-22},{-6,
            -2}})));
  Modelica.Fluid.Sources.Boundary_pT SinkP1(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    p=100000,
    T=293.15)
  annotation (Placement(transformation(extent={{46,-22},{26,-2}})));
  inner Modelica.Fluid.System system(use_eps_Re=true)
                                   annotation (Placement(transformation(extent={{64,60},
            {84,80}})));
  Modelica.Blocks.Sources.Ramp downstreamPressure(
    duration=0.6,
    startTime=0.6,
    height=2e5,
    offset=1e5)
    annotation (Placement(transformation(extent={{14,20},{34,40}})));
  Modelica.Blocks.Sources.Constant const(k=0.5)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation

  connect(V1.port_b,SinkP1.ports[1])
                                  annotation (Line(points={{-6,-12},{26,
          -12}}));
  connect(SourceP1.ports[1],V1.port_a)
                                   annotation (Line(points={{-56,-12},{
          -26,-12}}, color={0,127,255}));
  connect(downstreamPressure.y, SinkP1.p_in) annotation (Line(
      points={{35,30},{60,30},{60,-4},{48,-4}}, color={0,0,127}));
  connect(const.y, V1.opening) annotation (Line(
      points={{-39,30},{-16,30},{-16,-4}}, color={0,0,127}));
  annotation (experiment(StopTime=2));
end TestCheckValve;
