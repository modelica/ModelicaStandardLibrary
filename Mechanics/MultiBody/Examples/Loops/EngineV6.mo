model EngineV6 
  "V6 engine with 6 cylinders, 6 planar loops and 1 degree-of-freedom" 
  
  import Cv = Modelica.SIunits.Conversions;
  
  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute bearing(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.06,
    animation=animation) annotation (extent=[-90, 20; -70, 0], rotation=0);
  inner Modelica.Mechanics.MultiBody.World world(animateWorld=false,
      animateGravity =                                                              false) 
    annotation (extent=[-120, 20; -100, 40]);
  Modelica.Mechanics.Rotational.Inertia inertia(phi(
      stateSelect=StateSelect.always,
      fixed=true,
      start=0), w(
      stateSelect=StateSelect.always,
      fixed=true,
      start=10)) annotation (extent=[-110, -30; -90, -10]);
  Utilities.Cylinder cylinder1(
    crankAngleOffset=Cv.from_deg(-30),
    cylinderInclination=Cv.from_deg(-30),
    animation=animation) annotation (extent=[-50, 4; -30, 34]);
  Utilities.Cylinder cylinder2(
    crankAngleOffset=Cv.from_deg(90),
    cylinderInclination=Cv.from_deg(30),
    animation=animation) annotation (extent=[-20, 4; 0, 34]);
  Utilities.Cylinder cylinder3(
    crankAngleOffset=Cv.from_deg(-150),
    cylinderInclination=Cv.from_deg(-30),
    animation=animation) annotation (extent=[10, 4; 30, 34]);
  Utilities.Cylinder cylinder4(
    crankAngleOffset=Cv.from_deg(-90),
    cylinderInclination=Cv.from_deg(30),
    animation=animation) annotation (extent=[39, 4; 59, 34]);
  Utilities.Cylinder cylinder5(
    crankAngleOffset=Cv.from_deg(300),
    cylinderInclination=Cv.from_deg(-30),
    animation=animation) annotation (extent=[70, 4; 90, 34]);
  Utilities.Cylinder cylinder6(
    crankAngleOffset=Cv.from_deg(150),
    cylinderInclination=Cv.from_deg(30),
    animation=animation) annotation (extent=[100, 4; 120, 34]);
equation 
  
  annotation (
    Diagram,
    Coordsys(
      extent=[-120, -100; 120, 100],
      grid=[1, 1],
      component=[20, 20]),
    Documentation(info="<HTML>
<p>
This is a V6 engine with 6 cylinders. It is hierarchically built
up by using instances of one cylinder. For more details on the
modeling of one cylinder, see example 
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine\">Engine</a>.
An animation of the engine is shown in the figure below.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Loops/EngineV6.png\" ALT=\"model Examples.Loops.EngineV6\">
</p>
</HTML>
"));
  connect(bearing.frame_b, cylinder1.crank_a) 
    annotation (points=[-69, 10; -51, 10], style(color=0, thickness=2));
  connect(cylinder1.crank_b, cylinder2.crank_a) 
    annotation (points=[-29, 10; -21, 10], style(color=0, thickness=2));
  connect(cylinder2.crank_b, cylinder3.crank_a) 
    annotation (points=[1, 10; 9, 10], style(color=0, thickness=2));
  connect(cylinder3.crank_b, cylinder4.crank_a) 
    annotation (points=[31, 10; 38, 10], style(color=0, thickness=2));
  connect(cylinder4.crank_b, cylinder5.crank_a) 
    annotation (points=[60, 10; 69, 10], style(color=0, thickness=2));
  connect(cylinder5.crank_b, cylinder6.crank_a) 
    annotation (points=[91, 10; 99, 10], style(color=0, thickness=2));
  connect(cylinder5.cylinder_b, cylinder6.cylinder_a) 
    annotation (points=[91, 32; 99, 32], style(color=0, thickness=2));
  connect(cylinder4.cylinder_b, cylinder5.cylinder_a) 
    annotation (points=[60, 32; 69, 32], style(color=0, thickness=2));
  connect(cylinder4.cylinder_a, cylinder3.cylinder_b) 
    annotation (points=[38, 32; 31, 32], style(color=0, thickness=2));
  connect(cylinder3.cylinder_a, cylinder2.cylinder_b) 
    annotation (points=[9, 32; 1, 32], style(color=0, thickness=2));
  connect(cylinder2.cylinder_a, cylinder1.cylinder_b) 
    annotation (points=[-21, 32; -29, 32], style(color=0, thickness=2));
  connect(inertia.flange_b, bearing.axis) 
    annotation (points=[-90, -20; -80, -20; -80, 0], style(color=0));
  connect(world.frame_b, cylinder1.cylinder_a) annotation (points=[-99, 30; -59,
         30; -59, 32; -51, 32], style(color=0, thickness=2));
  connect(world.frame_b, bearing.frame_a) annotation (points=[-99, 30; -96, 30;
         -96, 10; -91, 10], style(color=0, thickness=2));
end EngineV6;
