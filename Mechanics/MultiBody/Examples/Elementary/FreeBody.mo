encapsulated model FreeBody 
  "Free flying body attached by two springs to environment" 
  import Modelica.Icons;
  import Modelica.Mechanics.MultiBody;
  import Modelica.Mechanics.Rotational;
  import Modelica;
  extends Icons.Example;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  annotation (
    experiment(StopTime=10),
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.29,
      y=0,
      width=0.71,
      height=0.85),
    Diagram,
    Documentation(info="<html>
<p>
This example demonstrates:
</p>
<ul>
<li>The animation of spring and damper components</li>
<li>A body can be freely moving without any connection to a joint.
    In this case body coordinates are used automatically as 
    states (whenever joints are present, it is first tried to
    use the generalized coordinates of the joints as states).</li>
<li>If a body is freely moving, the initial position and velocity of the body
    can be defined with the \"Initialization\" menu as shown with the
    body \"body1\" in the left part (click on \"Initialization\").</li>
</ul>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/FreeBody.png\" 
ALT=\"model Examples.Elementary.FreeBody\">
</p>
</html>"));
  inner Modelica.Mechanics.MultiBody.World world annotation (extent=[-60, 20; -40, 40]);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar2(r={0.8,0,0}, animation=false) 
    annotation (extent=[0, 20; 20, 40]);
  Modelica.Mechanics.MultiBody.Forces.Spring spring1(
    width=0.1,
    coilWidth=0.005,
    numberOfWindings=5,
    c=20,
    s_unstretched=0) annotation (extent=[-34, -4; -14, 16], rotation=-90);
  Modelica.Mechanics.MultiBody.Parts.BodyShape body(
    m=1,
    I_11=1,
    I_22=1,
    I_33=1,
    r={0.4,0,0},
    r_CM={0.2,0,0},
    r_0_start={0.2,-0.5,0.1},
    angles_start={10,10,10},
    width=0.05,
    initType=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity) 
    annotation (extent=[0, -40; 20, -20]);
  Modelica.Mechanics.MultiBody.Forces.Spring spring2(
    c=20,
    s_unstretched=0,
    width=0.1,
    coilWidth=0.005,
    numberOfWindings=5) annotation (extent=[32, -4; 52, 16], rotation=-90);
equation 
  connect(bar2.frame_a, world.frame_b) 
    annotation (points=[-1, 30; -39, 30], style(color=0, thickness=2));
  connect(spring1.frame_b, body.frame_a) annotation (points=[-24, -5; -24, -12;
         -1, -30], style(color=0, thickness=2));
  connect(spring2.frame_b, body.frame_b) 
    annotation (points=[42, -5; 21, -30], style(color=0, thickness=2));
  connect(bar2.frame_b, spring2.frame_a) 
    annotation (points=[21, 30; 42, 30; 42, 17], style(color=0, thickness=2));
  connect(spring1.frame_a, world.frame_b) annotation (points=[-24, 17; -24, 30;
         -39, 30], style(color=0, thickness=2));
end FreeBody;
