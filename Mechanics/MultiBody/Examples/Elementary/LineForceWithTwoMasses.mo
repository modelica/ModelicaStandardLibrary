model LineForceWithTwoMasses 
  "Demonstrate line force with two point masses using a JointUPS and alternatively a LineForceWithTwoMasses component"
  
  
  import SI = Modelica.SIunits;
  
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Mass m=1 "Mass of point masses";
  SI.Force rod_f_diff[3]=rod1.frame_b.f - rod3.frame_b.f 
    "Difference of cut-forces in rod1 and rod3";
  SI.Force body_f_diff[3]=bodyBox1.frame_b.f - bodyBox2.frame_b.f 
    "Difference of cut-forces in bodyBox1 and bodyBox2";
  annotation (
    experiment(StopTime=3),
    Diagram,
    Documentation(info="<html>
<p>
It is demonstrated how to implement line force components
that shall have mass properties. Two alternative implementations
are given:
</p>
<ul>
<li> With
     <a href=\"Modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS\">JointUPS</a>:<br>
     MultiBody.Joints.Assemblies.JointUPS is an aggregation
     of a universal, a prismatic and a spherical joint that approximates
     a real force component, such as a hydraulic cylinder. At the two
     frames of the prismatic joint (frame_ia, frame_ib of jointUPS)
     two bodies are attached. The parameters are selected such that
     the center of masses of the two bodies are located on the line
     connecting frame_a and frame_b of the jointUPS component.
     Both bodies have the same mass and the inertia tensor is set to zero,
     i.e., the two bodies are treated as point masses.</li>
<li> With <a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses\">
     LineForceWithTwoMasses</a>:<br>
     MultiBody.Forces.LineForceWithTwoMasses is a line force component 
     with the built-in property that two point masses are located
     on the line on which the line force is acting.
     The parameters are selected in such a way that the same
     system as with the jointUPS component is described.</li>
</ul>
<p>
In both cases, a linear 1-dimensional translational damper from the
Modelica.Mechanics.Translational library is used as
line force between the two attachment points. Simulate
this system and plot the differences of the cut forces at both sides
of the line force component (\"rod_f_diff\" and \"body_f_diff\"). 
Both vectors should be zero
(depending on the choosen relative tolerance of the integration,
the difference is in the order of 1.e-10 ... 1.e-15).
</p>
<p>
Note, that the implementation with the LineForceWithTwoMasses
component is simpler and more convenient. 
An animation of this simulation is shown in the figure below.
The system on the left side in the front is the animation with
the LineForceWithTwoMasses component whereas the system on the right
side in the back is the animation with the JointUPS component.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/LineForceWithTwoMasses2.png\">
</p>
</html>"),
    Coordsys(grid=[1, 1], component=[20, 20]));
  
  inner MultiBody.World world annotation (extent=[-80, 60; -60, 80]);
  MultiBody.Joints.Revolute revolute1(initType=MultiBody.Types.Init.
        PositionVelocity) annotation (extent=[-20, 60; 0, 80]);
  MultiBody.Parts.BodyBox bodyBox1(r={0.7,0,0}) 
    annotation (extent=[20, 60; 40, 80]);
  MultiBody.Parts.FixedTranslation rod1(
    r={0,-0.9,0},
    width=0.01,
    animation=false) annotation (extent=[-50, 44; -30, 64], rotation=-90);
  MultiBody.Joints.Assemblies.JointUPS jointUPS(nAxis_ia={0.7,1.2,0}, animation=
       true) annotation (extent=[0, 50; 20, 30]);
  annotation (Diagram);
  MultiBody.Parts.Body body1(
    r_CM=0.2*jointUPS.eAxis_ia,
    cylinderDiameter=0.05,
    animation=true,
    m=m,
    I_11=0,
    I_22=0,
    I_33=0) annotation (extent=[-14, 14; -34, 34]);
  MultiBody.Parts.Body body2(
    r_CM=-0.2*jointUPS.eAxis_ia,
    cylinderDiameter=0.05,
    animation=true,
    m=m,
    I_11=0,
    I_22=0,
    I_33=0) annotation (extent=[32, 14; 52, 34]);
  MultiBody.Parts.FixedTranslation rod2(
    r={0,0.3,0},
    width=0.01,
    animation=false) annotation (extent=[-50, 94; -30, 74], rotation=-90);
  Modelica.Mechanics.Translational.Damper damper1(d=3) 
    annotation (extent=[0, 24; 20, 4]);
  MultiBody.Joints.Revolute revolute2(initType=MultiBody.Types.Init.
        PositionVelocity) annotation (extent=[-20, -40; 0, -20]);
  MultiBody.Parts.BodyBox bodyBox2(r={0.7,0,0}) 
    annotation (extent=[20, -40; 40, -20]);
  MultiBody.Parts.FixedTranslation rod3(
    width=0.01,
    r={0,-0.9,0.3},
    animation=false) annotation (extent=[-50, -56; -30, -36], rotation=-90);
  MultiBody.Parts.FixedTranslation rod4(
    width=0.01,
    r={0,0.3,0.3},
    animation=false) annotation (extent=[-50, -6; -30, -26], rotation=-90);
  Modelica.Mechanics.Translational.Damper damper2(d=3) 
    annotation (extent=[0, -76; 20, -96]);
  MultiBody.Forces.LineForceWithTwoMasses lineForceWithTwoMasses(
    L_a=0.2,
    L_b=0.2,
    cylinderLength_a=0.2,
    cylinderLength_b=1.2,
    massDiameterFaction=2.2,
    m_a=m,
    m_b=m) annotation (extent=[0, -50; 20, -70]);
equation 
  connect(jointUPS.bearing, damper1.flange_a) 
    annotation (points=[6, 30; 6, 20; 0, 20; 0, 14], style(color=58));
  connect(jointUPS.axis, damper1.flange_b) 
    annotation (points=[14, 30; 14, 20; 20, 20; 20, 14], style(color=58));
  connect(jointUPS.frame_ib, body2.frame_a) 
    annotation (points=[18, 29; 18, 24; 31, 24], style(color=0, thickness=2));
  connect(world.frame_b, rod2.frame_a) annotation (points=[-59, 70; -40, 70; -40,
         73], style(color=0, thickness=2));
  connect(world.frame_b, rod1.frame_a) annotation (points=[-59, 70; -40, 70; -40,
         65], style(color=0, thickness=2));
  connect(rod2.frame_b, revolute1.frame_a) annotation (points=[-40, 95; -40, 98;
         -28, 98; -28, 70; -21, 70], style(color=0, thickness=2));
  connect(revolute1.frame_b, bodyBox1.frame_a) 
    annotation (points=[1, 70; 19, 70], style(color=0, thickness=2));
  connect(bodyBox1.frame_b, jointUPS.frame_b) annotation (points=[41, 70; 46,
        70; 46, 40; 21, 40], style(color=0, thickness=2));
  connect(body1.frame_a, jointUPS.frame_ia) 
    annotation (points=[-13, 24; 2, 24; 2, 30], style(color=0, thickness=2));
  connect(rod1.frame_b, jointUPS.frame_a) annotation (points=[-40, 43; -40, 40;
         -1, 40], style(color=0, thickness=2));
  connect(rod4.frame_b, revolute2.frame_a) annotation (points=[-40, -5; -40, -2;
         -28, -2; -28, -30; -21, -30], style(color=0, thickness=2));
  connect(revolute2.frame_b, bodyBox2.frame_a) 
    annotation (points=[1, -30; 19, -30], style(color=0, thickness=2));
  connect(world.frame_b, rod4.frame_a) annotation (points=[-59, 70; -52, 70; -52,
         -32; -40, -32; -40, -27], style(color=0, thickness=2));
  connect(rod3.frame_a, rod4.frame_a) 
    annotation (points=[-40, -35; -40, -27], style(color=0, thickness=2));
  connect(lineForceWithTwoMasses.frame_a, rod3.frame_b) annotation (points=[-1,
         -60; -40, -60; -40, -57], style(color=0, thickness=2));
  connect(lineForceWithTwoMasses.frame_b, bodyBox2.frame_b) annotation (points=
        [21, -60; 54, -60; 54, -30; 41, -30], style(color=0, thickness=2));
  connect(lineForceWithTwoMasses.flange_b, damper2.flange_b) 
    annotation (points=[16, -71; 20, -71; 20, -86], style(color=58));
  connect(lineForceWithTwoMasses.flange_a, damper2.flange_a) 
    annotation (points=[4, -71; 0, -71; 0, -86], style(color=58));
end LineForceWithTwoMasses;
