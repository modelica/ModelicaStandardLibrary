within ModelicaTest.Fluid.TestComponents.Valves;
model TestValveCompressible "Test case for incompressible fluid valve"
  extends Modelica.Icons.Example;
  Modelica.Fluid.Sources.Boundary_pT SourceP1(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=1000000,
    T(displayUnit="degC") = 673.15)
  annotation (Placement(transformation(extent={{-76,-22},{-56,-2}}, rotation=0)));
  Modelica.Fluid.Valves.ValveCompressible V1(
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=1,
    CvData=Modelica.Fluid.Types.CvTypes.Av,
    Av=240e-6,
    dp_nominal=500000,
    rho_nominal=3,
    p_nominal=1000000)
            annotation (Placement(transformation(extent={{-26,-22},{-6,-2}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT SinkP1(nPorts=1,
  redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    p=100000,
    T=673.15)
  annotation (Placement(transformation(extent={{46,-22},{26,-2}},
                                                                rotation=0)));
  Modelica.Blocks.Sources.Constant Opening(k=1)
              annotation (Placement(transformation(extent={{-78,22},{-58,42}},
          rotation=0)));
  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent={{64,60},
            {84,80}},          rotation=0)));
  Modelica.Blocks.Sources.Sine downstreamPressure(
    amplitude=5e5,
    freqHz=1,
    offset=6e5,
    phase=2.2165681500328)
    annotation (Placement(transformation(extent={{14,20},{34,40}})));
equation

  connect(V1.port_b,SinkP1.ports[1])
                                  annotation (Line(points={{-6,-12},{26,-12}}));
  connect(Opening.y,V1. opening)
  annotation (Line(points={{-57,32},{-16,32},{-16,-4}}, color={0,0,255}));
  connect(SourceP1.ports[1],V1.port_a)
                                   annotation (Line(points={{-56,-12},{-26,-12}},
        color={0,127,255}));
  connect(downstreamPressure.y, SinkP1.p_in) annotation (Line(
      points={{35,30},{60,30},{60,-4},{48,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics), experiment);
end TestValveCompressible;
