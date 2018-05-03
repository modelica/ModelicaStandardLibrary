within Modelica.Mechanics.MultiBody.Examples.Elementary;
model LineForceWithTwoMasses
  "Demonstrate line force with two point masses using a JointUPS and alternatively a LineForceWithTwoMasses component"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Mass m=1 "Mass of point masses";
  SI.Force rod_f_diff[3]=rod1.frame_b.f - rod3.frame_b.f
    "Difference of cut-forces in rod1 and rod3";
  SI.Force body_f_diff[3]=bodyBox1.frame_b.f - bodyBox2.frame_b.f
    "Difference of cut-forces in bodyBox1 and bodyBox2";

  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(phi(fixed=true), w(
        fixed=true)) annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox1(r={0.7,0,0})
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod1(
    r={0,-0.9,0},
    width=0.01,
    animation=false) annotation (Placement(transformation(
        origin={-40,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS jointUPS(nAxis_ia={0.7,1.2,0}, animation=
       true) annotation (Placement(transformation(extent={{-12,52},{12,28}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    r_CM=0.2*jointUPS.eAxis_ia,
    cylinderDiameter=0.05,
    animation=true,
    m=m,
    I_11=0,
    I_22=0,
    I_33=0) annotation (Placement(transformation(extent={{-20,18},{-40,38}})));
  Modelica.Mechanics.MultiBody.Parts.Body body2(
    r_CM=-0.2*jointUPS.eAxis_ia,
    cylinderDiameter=0.05,
    animation=true,
    m=m,
    I_11=0,
    I_22=0,
    I_33=0) annotation (Placement(transformation(extent={{20,18},{40,38}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(
    r={0,0.3,0},
    width=0.01,
    animation=false) annotation (Placement(transformation(
        origin={-40,80},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Mechanics.Translational.Components.Damper damper1(
                                                  d=3)
    annotation (Placement(transformation(extent={{-10,20},{10,0}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(phi(fixed=true), w(
        fixed=true)) annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox2(r={0.7,0,0})
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod3(
    width=0.01,
    r={0,-0.9,0.3},
    animation=false) annotation (Placement(transformation(
        origin={-40,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod4(
    width=0.01,
    r={0,0.3,0.3},
    animation=false) annotation (Placement(transformation(
        origin={-40,-30},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Mechanics.Translational.Components.Damper damper2(
                                                  d=3)
    annotation (Placement(transformation(extent={{-10,-64},{10,-44}})));
  Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses
    lineForceWithTwoMasses(
    L_a=0.2,
    L_b=0.2,
    cylinderLength_a=0.2,
    cylinderLength_b=1.2,
    massDiameterFaction=2.2,
    m_a=m,
    m_b=m) annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
equation
  connect(jointUPS.bearing, damper1.flange_a)
    annotation (Line(points={{-4.8,28},{-4.8,20},{-10,20},{-10,10}},
                                                                 color={0,127,0}));
  connect(jointUPS.axis, damper1.flange_b)
    annotation (Line(points={{4.8,28},{4.8,20},{10,20},{10,10}},
                                                             color={0,127,0}));
  connect(jointUPS.frame_ib, body2.frame_a)
    annotation (Line(
      points={{9.6,28},{20,28}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, rod2.frame_a) annotation (Line(
      points={{-70,0},{-60,0},{-60,64},{-40,64},{-40,70}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, rod1.frame_a) annotation (Line(
      points={{-70,0},{-60,0},{-60,64},{-40,64},{-40,60}},
      color={95,95,95},
      thickness=0.5));
  connect(rod2.frame_b, revolute1.frame_a) annotation (Line(
      points={{-40,90},{-20,90}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.frame_b, bodyBox1.frame_a)
    annotation (Line(
      points={{0,90},{20,90}},
      color={95,95,95},
      thickness=0.5));
  connect(bodyBox1.frame_b, jointUPS.frame_b) annotation (Line(
      points={{40,90},{50,90},{50,40},{12,40}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, jointUPS.frame_ia)
    annotation (Line(
      points={{-20,28},{-9.6,28}},
      color={95,95,95},
      thickness=0.5));
  connect(rod1.frame_b, jointUPS.frame_a) annotation (Line(
      points={{-40,40},{-12,40}},
      color={95,95,95},
      thickness=0.5));
  connect(rod4.frame_b, revolute2.frame_a) annotation (Line(
      points={{-40,-20},{-20,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b, bodyBox2.frame_a)
    annotation (Line(
      points={{0,-20},{20,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, rod4.frame_a) annotation (Line(
      points={{-70,0},{-60,0},{-60,-50},{-40,-50},{-40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(rod3.frame_a, rod4.frame_a)
    annotation (Line(
      points={{-40,-60},{-40,-40}},
      thickness=0.5));
  connect(lineForceWithTwoMasses.frame_a, rod3.frame_b) annotation (Line(
      points={{-10,-80},{-40,-80}},
      color={95,95,95},
      thickness=0.5));
  connect(lineForceWithTwoMasses.frame_b, bodyBox2.frame_b) annotation (Line(
      points={{10,-80},{50,-80},{50,-20},{40,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(lineForceWithTwoMasses.flange_b, damper2.flange_b)
    annotation (Line(points={{6,-69},{10,-69},{10,-54}},  color={0,127,0}));
  connect(lineForceWithTwoMasses.flange_a, damper2.flange_a)
    annotation (Line(points={{-6,-69},{-10,-69},{-10,-54}},
                                                       color={0,127,0}));
  annotation (
    experiment(StopTime=3),
    Documentation(info="<html>
<p>
It is demonstrated how to implement line force components
that shall have mass properties. Two alternative implementations
are given:
</p>
<ul>
<li> With <a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS\">JointUPS</a>:<br>
     Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS is an aggregation
     of a universal, a prismatic and a spherical joint that approximates
     a real force component, such as a hydraulic cylinder. At the two
     frames of the prismatic joint (frame_ia, frame_ib of jointUPS)
     two bodies are attached. The parameters are selected such that
     the center of masses of the two bodies are located on the line
     connecting frame_a and frame_b of the jointUPS component.
     Both bodies have the same mass and the inertia tensor is set to zero,
     i.e., the two bodies are treated as point masses.</li>
<li> With <a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses\">LineForceWithTwoMasses</a>:<br>
     Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses is a line force component
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
(depending on the chosen relative tolerance of the integration,
the difference is in the order of 1e-10 ... 1e-15).
</p>
<p>
Note, that the implementation with the LineForceWithTwoMasses
component is simpler and more convenient.
An animation of this simulation is shown in the figure below.
The system on the left side in the front is the animation with
the LineForceWithTwoMasses component whereas the system on the right
side in the back is the animation with the JointUPS component.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/LineForceWithTwoMasses2.png\">
</blockquote>
</html>"));
end LineForceWithTwoMasses;
