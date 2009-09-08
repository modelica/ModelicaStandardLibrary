model PointGravityWithPointMasses2
  "Rigidly connected point masses in a point gravity field"
  extends Modelica.Icons.Example;
  model PointMass = Modelica.Mechanics.MultiBody.Parts.PointMass (m=1, sphereColor={
          255,0,0});

  PointMass pointMass1(
    initType=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity,
    r_0_start={3,0,0},
    v_0_start={0,0,-1})
                       annotation (extent=[60,-10; 80,10]);

  PointMass pointMass2 annotation (extent=[-60,-10; -40,10]);
  PointMass pointMass3(initType=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity,
      r_0_start={2,1,0},
    v_0_start={0,0,-1})
                       annotation (extent=[60,20; 80,40]);
  PointMass pointMass4 annotation (extent=[-50,-40; -30,-20]);
  PointMass pointMass5 annotation (extent=[0,80; 20,100]);
  PointMass pointMass6 annotation (extent=[0,-100; 20,-80]);

  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={1,0,0})
                  annotation (extent=[20,-10; 40,10]);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation1(r={-1,0,0})
                 annotation (extent=[0,-10; -20,10]);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation2(r={0,1,0})
                 annotation (extent=[20,20; 40,40]);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation3(r={0,-1,0})
                 annotation (extent=[0,-40; -20,-20]);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation4(r={0,0,1})
                 annotation (extent=[0,50; 20,70],  rotation=90);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation5(r={0,0,-1})
                 annotation (extent=[0,-50; 20,-70],  rotation=90);

  annotation (Diagram,
    experiment(StopTime=3, Tolerance=1e-006),
    experimentSetupOutput,
    Documentation(info="<html>
<p>
This model demonstrates the usage of model Parts.PointMass in a
point gravity field. 6 point masses are connected rigidly together.
Translating such a model results in an error, because point masses do
not define an orientation object. The example demonstrates that in such
a case (when the orientation object is not defined by an object that
is connected to a point mass), a \"MultiBody.Joints.FreeMotion\" joint
has to be used, to define the the degrees of freedom of this structure.
</p>

<p>
In order to demonstrate that this approach is correct, in model
\"referenceSystem\", the same system is again provided, but this time
modeled with a generic body (Parts.Body) where the inertia tensor is
set to zero. In this case, no FreeMotion object is needed because every
body provides its absolute translational and rotational position and
velocity as potential states.
</p>

<p>
The two systems should move exactly in the same way. The system with the PointMasses
object visulizes the point masses in \"red\", whereas the \"referenceSystem\" shows
its bodies in \"blue\".
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/PointGravityWithPointMasses2.png\">
</p>
</html>"));
  inner World world(                             gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity, mue=
        5)
    annotation (extent=[-80,60; -60,80]);
  Joints.FreeMotion freeMotion annotation (extent=[-40,60; -20,80]);

model SystemWithStandardBodies
  extends Modelica.Icons.Example;
  model PointMass = Modelica.Mechanics.MultiBody.Parts.Body(m=1,I_11=0,I_22=0,I_33=0);

  PointMass pointMass1(
    r_0_start={3,0,0},
    initType=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity,
    v_0_start={0,0,-1})
                       annotation (extent=[40,-20; 60,0]);
  PointMass pointMass2 annotation (extent=[-60,-20; -80,0]);
  PointMass pointMass3 annotation (extent=[40,10; 60,30]);
  PointMass pointMass4 annotation (extent=[-50,-50; -70,-30]);
  PointMass pointMass5 annotation (extent=[0,60; 20,80]);
  PointMass pointMass6 annotation (extent=[2,-102; 22,-82]);

  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation( r={1,0,0})
                  annotation (extent=[0,-20; 20,0]);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation1( r={-1,0,0})
                 annotation (extent=[-20,-20; -40,0]);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation2( r={0,1,0})
                 annotation (extent=[0,10; 20,30]);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation3( r={0,-1,0})
                 annotation (extent=[-20,-50; -40,-30]);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation4( r={0,0,1})
                 annotation (extent=[-20,40; 0,60], rotation=90);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation5( r={0,0,-1})
                 annotation (extent=[-20,-60; 0,-80], rotation=90);

  annotation (Diagram);

equation
  connect(fixedTranslation1.frame_a, fixedTranslation.frame_a)
                                                         annotation (points=[
        -20,-10; 0,-10], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation1.frame_a, fixedTranslation2.frame_a)
                                                          annotation (points=[
        -20,-10; -10,-10; -10,20; 0,20], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation3.frame_a, fixedTranslation.frame_a)
                                                         annotation (points=[
        -20,-40; -10,-40; -10,-10; 0,-10], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation1.frame_a, fixedTranslation4.frame_a)
                                                          annotation (points=[
        -20,-10; -10,-10; -10,40], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation5.frame_a, fixedTranslation.frame_a)
                                                         annotation (points=[
        -10,-60; -10,-10; 0,-10], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation2.frame_b, pointMass3.frame_a)
                                                      annotation (points=[20,20;
        40,20], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation3.frame_b, pointMass4.frame_a)
                                                      annotation (points=[-40,-40;
        -50,-40],      style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(pointMass5.frame_a, fixedTranslation4.frame_b)
                                                      annotation (points=[0,70;
        -10,70; -10,60],
                     style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation5.frame_b, pointMass6.frame_a)
                                                      annotation (points=[-10,-80;
        -10,-92; 2,-92],style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation.frame_b, pointMass1.frame_a)
                                                     annotation (points=[20,-10;
        40,-10], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation1.frame_b, pointMass2.frame_a)
                                                      annotation (points=[-40,-10;
        -60,-10],      style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
end SystemWithStandardBodies;

  SystemWithStandardBodies referenceSystem annotation (extent=[60,-60; 80,-40]);
equation
  connect(fixedTranslation1.frame_a, fixedTranslation.frame_a)
                                                         annotation (points=[0,0; 20,
        0],              style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation1.frame_a, fixedTranslation2.frame_a)
                                                          annotation (points=[0,0; 10,
        0; 10,30; 20,30],                style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation3.frame_a, fixedTranslation.frame_a)
                                                         annotation (points=[0,-30;
        10,-30; 10,0; 20,0],               style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation1.frame_a, fixedTranslation4.frame_a)
                                                          annotation (points=[0,0; 10,
        0; 10,50],                 style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation5.frame_a, fixedTranslation.frame_a)
                                                         annotation (points=[10,-50;
        10,0; 20,0],              style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation2.frame_b, pointMass3.frame_a)
                                                      annotation (points=[40,30;
        70,30], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation3.frame_b, pointMass4.frame_a)
                                                      annotation (points=[-20,-30;
        -40,-30],      style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(pointMass5.frame_a, fixedTranslation4.frame_b)
                                                      annotation (points=[10,90;
        10,70],      style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation5.frame_b, pointMass6.frame_a)
                                                      annotation (points=[10,-70;
        10,-90],        style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation.frame_b, pointMass1.frame_a)
                                                     annotation (points=[40,0; 70,
        0],      style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedTranslation1.frame_b, pointMass2.frame_a)
                                                      annotation (points=[-20,0;
        -50,0],        style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(world.frame_b, freeMotion.frame_a) annotation (points=[-60,70; -40,70],
      style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(freeMotion.frame_b, fixedTranslation1.frame_a) annotation (points=[
        -20,70; -10,70; -10,20; 10,20; 10,0; 0,0], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
end PointGravityWithPointMasses2;
