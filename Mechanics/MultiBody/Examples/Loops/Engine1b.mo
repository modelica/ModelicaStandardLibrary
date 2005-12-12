model Engine1b 
  "Model of one cylinder engine with gas force and preparation for assembly joint JointRRP" 
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  extends Utilities.Engine1bBase;
  annotation (
    experiment(StopTime=0.5),
    Diagram(
      Rectangle(extent=[3,117; 88,-23], style(
          color=1,
          rgbcolor={255,0,0},
          thickness=2)),
      Text(
        extent=[76,-26; 151,-39],
        style(
          color=1,
          rgbcolor={255,0,0},
          thickness=2),
        string="jointRRP in model"),
      Text(
        extent=[65,-34; 140,-52],
        style(
          color=1,
          rgbcolor={255,0,0},
          thickness=2),
        string="Loops.Engine2b")),
    Coordsys(
      extent=[-100, -120; 150, 120],
      grid=[1, 1],
      component=[20, 20]),
    Documentation(info="<html>
<p>
This is a model of the mechanical part of one cylinder of an engine.
It is similiar to Loops.Engine1. The difference is that a simple
model for the gas force in the cylinder is added and that the 
model is restructured in such a way, that the central part of
the planar kinematic loop can be easily replaced by the
assembly joint \"Modelica.Mechanics.MultiBody.Joints.Assemblies.<b>JointRRP</b>\".
This exchange of the kinematic loop is shown in
\"Examples.Loops.Engine2b\". The advantage of using JointRRP is, that the
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
  Modelica.Mechanics.MultiBody.Joints.Revolute B2(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05,
    planarCutJoint=true)   annotation (extent=[40,20; 60,40],    rotation=0);
  Modelica.Mechanics.MultiBody.Joints.Revolute B1(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) 
                         annotation (extent=[40,-20; 60,0],      rotation=0);
  Modelica.Mechanics.MultiBody.Joints.ActuatedPrismatic Cylinder(
    boxWidth=0.02, n={0,-1,0}) 
                   annotation (extent=[40,87; 60,107],    rotation=-90);
  Parts.FixedTranslation Rod1(r={0,0.2,0}, animation=false) 
    annotation (extent=[60,0; 80,20], rotation=90);
  Parts.FixedTranslation Rod3(r={0,-0.1,0}, animation=false) 
    annotation (extent=[40,68; 60,48],rotation=90);
equation 
  connect(B1.frame_b, Rod1.frame_a) annotation (points=[61,-10; 70,-10; 70,-1],
      style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
  connect(Rod1.frame_b, B2.frame_b) annotation (points=[70,21; 70,30; 61,30],
      style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
  connect(Cylinder.frame_b, Rod3.frame_a) annotation (points=[50,86; 50,69],
      style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
  connect(B2.frame_a, Rod3.frame_b) annotation (points=[39,30; 30,30; 30,44; 50,
        44; 50,47], style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
  connect(cylPosition.frame_b, Cylinder.frame_a) annotation (points=[-19.5,110;
        50,110; 50,108], style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
  connect(gasForce.flange_a, Cylinder.bearing) annotation (points=[119,107; 119,
        112; 70,112; 70,101; 56,101], style(color=58, rgbcolor={0,127,0}));
  connect(Cylinder.axis, gasForce.flange_b) annotation (points=[56,89; 71,89;
        71,80; 119,80; 119,87], style(color=58, rgbcolor={0,127,0}));
  connect(Piston.frame_a, Rod3.frame_a) annotation (points=[120,64; 120,75; 50,
        75; 50,69], style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
  connect(B1.frame_b, Rod2.frame_a) annotation (points=[61,-10; 120,-10; 120,-1],
      style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
  connect(Mid.frame_b, B1.frame_a) annotation (points=[51,-43; 57,-43; 57,-28;
        30,-28; 30,-10; 39,-10], style(
      color=0,
      rgbcolor={0,0,0},
      thickness=2));
end Engine1b;
