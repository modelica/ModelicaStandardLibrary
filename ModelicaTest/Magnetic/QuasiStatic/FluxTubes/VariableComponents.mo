within ModelicaTest.Magnetic.QuasiStatic.FluxTubes;
model VariableComponents "Test of reluctance and permeance model with signal inputs"
  extends Modelica.Icons.Example;
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.VariableReluctance reluctance annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.VariablePermeance permeance annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={20,0})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.Ground ground annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Sources.ConstantMagneticFlux magFluxSource(
    gamma(fixed=true),
    f=50,
    Phi=Complex(1, 0)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-40,0})));
  Modelica.Blocks.Sources.Ramp rampPermeance(
    height=1,
    duration=0.3,
    offset=0,
    startTime=0.6) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Sources.Ramp rampReluctance(
    height=1,
    duration=0.3,
    offset=0,
    startTime=0.1) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
equation
  connect(rampPermeance.y, permeance.G_m) annotation (Line(points={{1,0},{8,0}}, color={0,0,127}));
  connect(reluctance.R_m, rampReluctance.y) annotation (Line(points={{52,-2.22045e-15},{56,-2.22045e-15},{56,0},{59,0}}, color={0,0,127}));
  connect(magFluxSource.port_p, ground.port) annotation (Line(points={{-40,-10},{-40,-30},{0,-30}}, color={255,170,85}));
  connect(ground.port, permeance.port_n) annotation (Line(points={{0,-30},{20,-30},{20,-10}}, color={255,170,85}));
  connect(ground.port, reluctance.port_n) annotation (Line(points={{0,-30},{40,-30},{40,-10}}, color={255,170,85}));
  connect(magFluxSource.port_n, permeance.port_p) annotation (Line(points={{-40,10},{-40,30},{20,30},{20,10}}, color={255,170,85}));
  connect(reluctance.port_p, permeance.port_p) annotation (Line(points={{40,10},{40,30},{20,30},{20,10}}, color={255,170,85}));
  annotation (experiment(StopTime=1));
end VariableComponents;
