within Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator;
model ForceStrokeBehaviour
  "Force-stroke characteristic of the permeance model at constant current"

  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-70,-30},{-50,-10}})));
  FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator actuator(x(start=0),
      material=Material.HardMagnetic.PlasticNdFeB()) annotation (
      Placement(transformation(extent={{-30,0},{-10,20}})));
  Modelica.Electrical.Analog.Sources.ConstantCurrent source(I=3)
    annotation (Placement(transformation(
        origin={-60,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Ramp sweepX(
    height=7.99e-3,
    duration=8,
    offset=-3.995e-3,
    startTime=-4) annotation (Placement(transformation(extent={{70,0},{50,
            20}})));
  Modelica.Mechanics.Translational.Sources.Position feedX(exact=true)
    annotation (Placement(transformation(extent={{30,0},{10,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[-0.004, -8.8729,
        -9.07503, 0.00332; -0.0035, -9.05239, -9.25042, 0.00352; -0.003,
        -9.1915, -9.38558, 0.00371; -0.0025, -9.28247, -9.47266, 0.0039;
        -0.002, -9.3587, -9.54503, 0.00409; -0.0015, -9.41568, -9.59782,
        0.00429; -0.001, -9.45496, -9.6331, 0.00448; -0.0005, -9.47427, -9.64839,
        0.00467; 0, -9.48639, -9.65616, 0.00486; 0.0005, -9.48623, -9.65174,
        0.00505; 0.001, -9.4732, -9.63435, 0.00524; 0.0015, -9.44143, -9.59825,
        0.00543; 0.002, -9.39915, -9.55226, 0.00562; 0.0025, -9.33166, -9.47988,
        0.00581; 0.003, -9.23707, -9.38112, 0.006; 0.0035, -9.09497, -9.23417,
        0.00619; 0.004, -8.91839, -9.05337, 0.00638])
    "Column 1: position, col.2: force with non-linear stator iron, col.3: force with mu_rFe=const.=1000, col.4: inductance with mu_rFe=const.=1000"
    annotation (Placement(transformation(extent={{50,30},{70,50}})));
equation
  connect(ground.p, source.n)
    annotation (Line(points={{-60,-10},{-60,0}}, color={0,0,255}));
  connect(source.n, actuator.n) annotation (Line(points={{-60,0},{-46,0},{-46,0},{-30,0}},
                            color={0,0,255}));
  connect(source.p, actuator.p) annotation (Line(points={{-60,20},{-46,20},{-46,20},{-30,20}},
                              color={0,0,255}));
  connect(sweepX.y, feedX.s_ref)
    annotation (Line(points={{49,10},{32,10}}, color={0,0,127}));
  connect(feedX.flange, actuator.flange)
    annotation (Line(points={{10,10},{-10,10}}, color={0,127,0}));
  connect(feedX.s_ref, comparisonWithFEA.u)
    annotation (Line(points={{32,10},{40,10},{40,40},{48,40}},
                                                       color={0,0,127}));
  annotation (experiment(
      StartTime=-4,
      StopTime=4,
      Tolerance=1e-007), Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> for an explanation of both converter models.<br>
</p>
<p>
Simulation of the force-stroke characteristic of the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> with a constant current I=3A and a forced armature movement (similar to measurements in reality) shows the dependency of both force-generating permeances G_ma and G_mb as well as inductance L on armature position x. <strong>Simulate for 8 s</strong> and <strong>plot vs.</strong> armature position <strong>feedX.flange_b.s</strong> (same physical quantities together in a common diagram for comparison):</p>
<blockquote><pre>
feedX.flange_b.f            // force of permeance model (permeance of stator iron neglected in this model)
comparisonWithFEA.y[1]      // force of FEA model with non-linear stator iron 1.0718
comparisonWithFEA.y[2]      // force of FEA model with mu_rFe=const.=1000
actuator.g_ma.G_m           // permeance G_ma
actuator.g_mb.G_m           // permeance G_mb
actuator.L                  // inductance of permeance model
comparisonWithFEA.y[3]      // inductance of FEA model for comparison (mu_rFe=const.=1000).
</pre></blockquote>
</html>"));
end ForceStrokeBehaviour;
