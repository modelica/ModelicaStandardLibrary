model Engine1b_analytic 
  "Model of one cylinder engine with gas force and analytic loop handling" 
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  extends Utilities.Engine1bBase;
  annotation (
    experiment(StopTime=0.5),
    Diagram,
    Coordsys(
      extent=[-100, -120; 150, 120],
      grid=[1, 1],
      component=[20, 20]),
    Documentation(info="<html>
<p>
This is the same model as Examples.Loops.Engine2a.
The only difference is that the central part of
the planar kinematic loop has been replaced by the
assembly joint \"Modelica.Mechanics.MultiBody.Joints.Assemblies.<b>JointRRP</b>\".
The advantage of using JointRRP is, that the
non-linear algebraic equation of this loop is solved analytically, and 
not numerically as in \"Examples.Loops.Engine2a\".
</p>
<p>
An animation of this example is shown in the figure below.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Loops/Engine.png\" ALT=\"model Examples.Loops.Engine\">
</p>
</html>"),
    experimentSetupOutput);
  Joints.Assemblies.JointRRP jointRRP(
    n_a={1,0,0},
    n_b={0,-1,0},
    animation=false,
    rRod1_ia={0,0.2,0},
    rRod2_ib={0,-0.1,0}) 
    annotation (extent=[50,34; 10,74],    rotation=90);
equation 
  connect(Mid.frame_b, jointRRP.frame_a) annotation (points=[51,-43; 58,-43; 58,
        -30; 30,-30; 30,32], style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
  connect(jointRRP.frame_b, cylPosition.frame_b) annotation (points=[30,76; 30,
        110; -19.5,110], style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
  connect(jointRRP.axis, gasForce.flange_b) annotation (points=[46,76; 46,82;
        119,82; 119,87], style(color=58, rgbcolor={0,127,0}));
  connect(jointRRP.bearing, gasForce.flange_a) annotation (points=[38,76; 38,
        114; 119,114; 119,107], style(color=58, rgbcolor={0,127,0}));
  connect(jointRRP.frame_ib, Piston.frame_a) annotation (points=[52,70; 120,70;
        120,64], style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
  connect(jointRRP.frame_ia, Rod2.frame_a) annotation (points=[52,38; 80,38; 80,
        -10; 120,-10; 120,-1], style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
end Engine1b_analytic;
