encapsulated model ThreeSprings
  "3-dim. springs in series and parallel connection"
  import Modelica.Icons;
  import Modelica.Mechanics.MultiBody;
  import Modelica.Mechanics.Rotational;
  import Modelica;
  import ZeroMass;
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
This example demonstrates that <b>3-dimensional line force</b> elements
(here: Modelica.Mechanics.MultiBody.Forces.Spring elements) can be connected together
in <b>series</b> without having a body with mass at the
connection point (as usually required by multi-body programs).
This is advantageous since stiff systems can be avoided, say, due to
a stiff spring and a small mass at the connection point.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/ThreeSprings.png\"
ALT=\"model Examples.Elementary.ThreeSprings\">
</p>
</html>"));
  inner Modelica.Mechanics.MultiBody.World world(animateWorld=animation)
    annotation (extent=[-60, 20; -40, 40]);
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    animation=animation,
    r_CM={0,-0.2,0},
    r_0_start={0.5,-0.3,0},
    m=0.8,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    initType=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity,
    sphereDiameter=0.2) annotation (extent=[40, -80; 20, -60], rotation=-90);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar1(animation=animation, r={0.3,0,0})
    annotation (extent=[-20, 20; 0, 40]);
  Modelica.Mechanics.MultiBody.Forces.Spring spring1(
    s_unstretched=0.1,
    width=0.1,
    coilWidth=0.005,
    numberOfWindings=5,
    c=20,
    animation=animation) annotation (extent=[20, 0; 40, 20], rotation=-90);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar2(animation=animation, r={0,0,0.3})
    annotation (extent=[-40, 0; -20, -20], rotation=90);
  Modelica.Mechanics.MultiBody.Forces.Spring spring2(
    s_unstretched=0.1,
    width=0.1,
    coilWidth=0.005,
    numberOfWindings=5,
    c=40,
    animation=animation) annotation (extent=[20, -48; 40, -28], rotation=-90);
  Modelica.Mechanics.MultiBody.Forces.Spring spring3(
    s_unstretched=0.1,
    width=0.1,
    coilWidth=0.005,
    numberOfWindings=5,
    c=20,
    animation=animation) annotation (extent=[-20, -42; 0, -22], rotation=0);
equation
  connect(world.frame_b, bar1.frame_a)
    annotation (points=[-39, 30; -21, 30], style(color=0, thickness=2));
  connect(world.frame_b, bar2.frame_a) annotation (points=[-39, 30; -30, 30; -30,
         1], style(color=0, thickness=2));
  connect(bar1.frame_b, spring1.frame_a)
    annotation (points=[1, 30; 30, 30; 30, 21], style(color=0, thickness=2));
  connect(bar2.frame_b, spring3.frame_a) annotation (points=[-30, -21; -30, -32;
         -21, -32], style(color=0, thickness=2));
  connect(spring2.frame_b, body1.frame_a)
    annotation (points=[30, -49; 30, -59], style(color=0, thickness=2));
  connect(spring3.frame_b, spring1.frame_b)
    annotation (points=[1, -32; 30, -14; 30, -1], style(color=0, thickness=2));
  connect(spring2.frame_a, spring1.frame_b)
    annotation (points=[30, -27; 30, -1], style(color=0, thickness=2));
end ThreeSprings;
