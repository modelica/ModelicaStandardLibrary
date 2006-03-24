model EngineV6_analytic
  "V6 engine with 6 cylinders, 6 planar loops, 1 degree-of-freedom and analytic handling of kinematic loops"

  import Cv = Modelica.SIunits.Conversions;
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  inner Modelica.Mechanics.MultiBody.World world(animateWorld=false,
      animateGravity =                                                              false)
    annotation (extent=[-60, -20; -40, 0]);
  Utilities.EngineV6_analytic engine(redeclare model Cylinder =
        Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.Cylinder_analytic_CAD)
    annotation (extent=[-20, 0; 20, 40]);
  Modelica.Mechanics.Rotational.Inertia load(phi(
      start=0,
      fixed=true,
      stateSelect=StateSelect.always), w(
      start=10,
      fixed=true,
      stateSelect=StateSelect.always)) annotation (extent=[40, 10; 60, 30]);
equation

  annotation (
    Diagram,
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Documentation(info="<HTML>
<p>
This is the same model as the example \"EngineV6\". However, the cylinders
have been built up with component Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR that
solves the non-linear system of equations in an aggregation of 3 revolution
joints <b>analytically</b>:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Loops/EngineV6_CAD_small.png\">
</p>
<p>
This model is about 15 times faster as the EngineV6 example and <b>no</b> linear or
non-linear system of equations occur. In contrast, the \"EngineV6\" example
leads to 6 systems of nonlinear equations (every system has dimension = 5, with
Evaluate=false and dimension=1 with Evaluate=true) and a linear system of equations
of about 40. This shows the power of the analytic loop handling.
</p>
</HTML>
"));
  connect(world.frame_b, engine.frame_a)
    annotation (points=[-40,-10; 0,-10; 0,-0.2], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(engine.flange_b, load.flange_a)
    annotation (points=[22, 20; 40, 20], style(color=0));
end EngineV6_analytic;
