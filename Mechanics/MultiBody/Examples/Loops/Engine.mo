model Engine "Model of one cylinder engine" 
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  annotation (
    experiment(StopTime=5),
    Diagram,
    Coordsys(
      extent=[-100, -120; 150, 120],
      grid=[1, 1],
      component=[20, 20]),
    Documentation(info="<html>
<p>
This is a model of the mechanical part of one cylinder of an engine. 
The combustion is not modelled. The \"inertia\" component at the lower
left part is the output inertia of the engine driving the gearbox.
The angular velocity of the output inertia has a start value of 10 rad/s
in order to demonstrate the movement of the engine.
</p>
<p>
The engine is modeled solely by revolute and prismatic joints.
Since this results in a <b>planar</b> loop there is the well known
difficulty that the cut-forces perpendicular to the loop cannot be
uniquely computed, as well as the cut-torques within the plane.
This ambiguity is resolved by using the option <b>planarCutJoint</b>
in the <b>Advanced</b> menu of one revolute joint in every planar loop
(here: joint B1). This option sets the cut-force in direction of the
axis of rotation, as well as the cut-torques perpendicular to the axis
of rotation at this joint to zero and makes the problem mathematically
well-formed.
</p>
<p>
An animation of this example is shown in the figure below.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Loops/Engine.png\" ALT=\"model Examples.Loops.Engine\">
</p>
</html>"));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder Piston(diameter=0.1, r={0,-0.1,0}) 
    annotation (extent=[121, 56; 60, 77], rotation=270);
  Modelica.Mechanics.MultiBody.Parts.BodyBox Rod(
    widthDirection={1,0,0},
    width=0.02,
    height=0.06,
    r={0,-0.2,0},
    color={0,0,200}) annotation (extent=[80, 15; 100, -5], rotation=90);
  Modelica.Mechanics.MultiBody.Joints.Revolute B2(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (extent=[80, 22; 100, 42], rotation=0);
  Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute Bearing(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (extent=[-10, -80; 10, -100], rotation=0);
  inner Modelica.Mechanics.MultiBody.World world annotation (extent=[-50, -100; -30, -80]);
  Modelica.Mechanics.Rotational.Inertia Inertia(phi(
      fixed=true,
      start=0,
      stateSelect=StateSelect.always), w(
      fixed=true,
      start=10,
      stateSelect=StateSelect.always)) annotation (extent=[-28, -120; -8, -100]);
  Modelica.Mechanics.MultiBody.Parts.BodyBox Crank4(
    height=0.05,
    widthDirection={1,0,0},
    width=0.02,
    r={0,-0.1,0}) annotation (extent=[105.5, -65; 125.5, -85], rotation=90);
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder Crank3(r={0.1,0,0}, diameter=0.03) annotation (
    extent=[81.5, -71; 101.5, -51],
    rotation=0,
    style(color=0, thickness=2));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder Crank1(diameter=0.05, r={0.1,0,0}) 
    annotation (extent=[24, -100; 44, -80], rotation=0);
  Modelica.Mechanics.MultiBody.Parts.BodyBox Crank2(
    r={0,0.1,0},
    height=0.05,
    widthDirection={1,0,0},
    width=0.02) annotation (extent=[60, -86; 80, -66], rotation=90);
  Modelica.Mechanics.MultiBody.Joints.Revolute B1(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05,
    planarCutJoint=true) annotation (extent=[80, -30; 100, -10], rotation=0);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mid(r={0.05,0,0}) 
    annotation (extent=[70, -53; 90, -33]);
  Modelica.Mechanics.MultiBody.Joints.Prismatic Cylinder(
    n={0,1,0},
    s_start=-0.25,
    boxWidth=0.02) annotation (extent=[80, 86; 100, 106], rotation=-90);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation cylPosition(r={0.15,0.55,0}, animation=false) 
    annotation (extent=[-0.5, 100; 19.5, 120]);
equation 
  connect(world.frame_b, Bearing.frame_a) 
    annotation (points=[-29, -90; -11, -90], style(color=0, thickness=2));
  connect(Crank2.frame_a, Crank1.frame_b) annotation (points=[70, -87; 70, -90;
         45, -90], style(
      color=0,
      thickness=2,
      fillColor=8,
      fillPattern=1));
  connect(Crank2.frame_b, Crank3.frame_a) annotation (points=[70, -65; 70, -61;
         80.5, -61], style(
      color=0,
      thickness=2,
      fillColor=8,
      fillPattern=1));
  connect(Bearing.frame_b, Crank1.frame_a) annotation (points=[11, -90; 23, -90],
       style(
      color=0,
      thickness=2,
      fillColor=8,
      fillPattern=1));
  connect(Cylinder.frame_b, Piston.frame_b) annotation (points=[90, 85; 90,
        54.95; 90.5, 54.95], style(color=0, thickness=2));
  connect(cylPosition.frame_b, Cylinder.frame_a) annotation (points=[20.5, 110;
         90, 110; 90, 107], style(color=0, thickness=2));
  connect(world.frame_b, cylPosition.frame_a) annotation (points=[-29, -90; -20,
         -90; -20, 110; -1.5, 110], style(color=0, thickness=2));
  connect(Crank3.frame_b, Crank4.frame_a) annotation (points=[102.5, -61; 115,
        -61; 115, -64; 115.5, -64], style(color=0, thickness=2));
  connect(B1.frame_a, Mid.frame_b) annotation (points=[79, -20; 70, -20; 70, -32;
         98, -32; 98, -43; 91, -43], style(color=0, thickness=2));
  connect(B1.frame_b, Rod.frame_b) annotation (points=[101, -20; 112, -20; 112,
         -9; 90, -9; 90, -6], style(color=0, thickness=2));
  connect(Rod.frame_a, B2.frame_b) annotation (points=[90, 16; 90, 21; 110, 21;
         110, 32; 101, 32], style(color=0, thickness=2));
  connect(B2.frame_a, Piston.frame_b) annotation (points=[79, 32; 70, 32; 70,
        46; 90.5, 46; 90.5, 54.95], style(color=0, thickness=2));
  connect(Inertia.flange_b, Bearing.axis) annotation (points=[-8, -110; 0, -110;
         0, -100], style(
      color=0,
      fillColor=7,
      fillPattern=1));
  connect(Mid.frame_a, Crank2.frame_b) annotation (points=[69, -43; 63, -43; 63,
         -61; 70, -61; 70, -65], style(color=0, thickness=2));
end Engine;
