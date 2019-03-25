within Modelica.Mechanics.MultiBody.Examples.Elementary;
model PointGravityWithPointMasses2
  "Rigidly connected point masses in a point gravity field"
  extends Modelica.Icons.Example;
  model PointMass = Modelica.Mechanics.MultiBody.Parts.PointMass (
    m=1, sphereColor={255,0,0}) "Point mass used at all places of this example"
    annotation (
      Documentation(info="<html>
<p>
Point mass used at all places in this example (has a mass  of 1 kg and a blue color)
</p>
</html>"));

  PointMass pointMass1(
    r_0(start={3,0,0}, each fixed=true),
    v_0(start={0,0,-1}, each fixed=true))
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  PointMass pointMass2 annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  PointMass pointMass3(
    r_0(start={2,1,0}, fixed={true,false,false}),
    v_0(start={0,0,-1}, fixed={true,false,false}))
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  PointMass pointMass4(
    r_0(start={2,-1,0}, fixed={false,false,true}),
    v_0(start={0,0,-1}, fixed={false,false,true}))
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  PointMass pointMass5(
    r_0(start={2,0,1}, fixed={false,false,true}),
    v_0(start={0,0,-1}, fixed={false,false,true}))
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  PointMass pointMass6 annotation (Placement(transformation(extent={{0,-100},{20,-80}})));

  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={1,0,0})
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation1(r={-1,0,0})
    annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation2(r={0,1,0})
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation3(r={0,-1,0})
    annotation (Placement(transformation(extent={{0,-40},{-20,-20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation4(r={0,0,1})
    annotation (Placement(transformation(
        origin={10,60},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation5(r={0,0,-1})
    annotation (Placement(transformation(
        origin={10,-60},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  inner World world(
    gravitySphereDiameter=0.1,
    gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity,
    mue=5)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Joints.FreeMotion freeMotion annotation (Placement(transformation(extent={{
            -40,60},{-20,80}})));
  SystemWithStandardBodies referenceSystem annotation (Placement(transformation(
          extent={{60,-60},{80,-40}})));

  model SystemWithStandardBodies
    "For comparison purposes, an equivalent model with Bodies instead of PointMasses"

    model PointMass = Modelica.Mechanics.MultiBody.Parts.Body (
      final m=1,
      final r_CM={0,0,0},
      final I_11=0,
      final I_22=0,
      final I_33=0,
      final I_21=0,
      final I_31=0,
      final I_32=0)
      "Body used at all places of the comparison model with zero inertia tensor"
      annotation (Documentation(info="<html>
<p>
Body used at all places of the comparison model with zero inertia tensor (and mass = 1 kg and a red color).
</p>
</html>"));

    PointMass pointMass1(
      r_0(start={3,0,0}, each fixed=true),
      v_0(start={0,0,-1}, each fixed=true),
      angles_fixed=true,
      w_0_fixed=true)
      annotation (Placement(transformation(extent={{40,-20},{
                60,0}})));
    PointMass pointMass2
      annotation(Placement(transformation(extent={{-60,-20},{
                -80,0}})));
    PointMass pointMass3
      annotation(Placement(transformation(extent={{40,10},{60,
                30}})));
    PointMass pointMass4
      annotation(Placement(transformation(extent={{-50,-50},{
                -70,-30}})));
    PointMass pointMass5
      annotation(Placement(transformation(extent={{0,60},{20,
                80}})));
    PointMass pointMass6
      annotation(Placement(transformation(extent={{2,-102},{
                22,-82}})));

    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={1,0,0})
      annotation(Placement(transformation(extent={{0,-20},{20,0}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation1(r={-1,0,0})
      annotation (Placement(transformation(extent={{-20,-20},{-40,0}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation2(r={0,1,0})
      annotation (Placement(transformation(extent={{0,10},{20,30}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation3(r={0,-1,0})
      annotation (Placement(transformation(extent={{-20,-50},{-40,-30}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation4(r={0,0,1})
      annotation (Placement(transformation(
            origin={-10,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation5(r={0,0,-1})
      annotation (Placement(transformation(
            origin={-10,-70},
            extent={{10,-10},{-10,10}},
            rotation=90)));

  equation
    connect(fixedTranslation1.frame_a, fixedTranslation.frame_a)
      annotation(Line(
          points={{-20,-10},{0,-10}},
          color={95,95,95},
          thickness=0.5));
    connect(fixedTranslation1.frame_a, fixedTranslation2.frame_a)
      annotation(Line(
          points={{-20,-10},{-10,-10},{-10,20},{0,20}},
          color={95,95,95},
          thickness=0.5));
    connect(fixedTranslation3.frame_a, fixedTranslation.frame_a)
      annotation(Line(
          points={{-20,-40},{-10,-40},{-10,-10},{0,-10}},
          color={95,95,95},
          thickness=0.5));
    connect(fixedTranslation1.frame_a, fixedTranslation4.frame_a)
      annotation(Line(
          points={{-20,-10},{-10,-10},{-10,40}},
          color={95,95,95},
          thickness=0.5));
    connect(fixedTranslation5.frame_a, fixedTranslation.frame_a)
      annotation(Line(
          points={{-10,-60},{-10,-10},{0,-10}},
          color={95,95,95},
          thickness=0.5));
    connect(fixedTranslation2.frame_b, pointMass3.frame_a)
      annotation(Line(
          points={{20,20},{40,20}},
          color={95,95,95},
          thickness=0.5));
    connect(fixedTranslation3.frame_b, pointMass4.frame_a)
      annotation(Line(
          points={{-40,-40},{-50,-40}},
          color={95,95,95},
          thickness=0.5));
    connect(pointMass5.frame_a, fixedTranslation4.frame_b)
      annotation(Line(
          points={{0,70},{-10,70},{-10,60}},
          color={95,95,95},
          thickness=0.5));
    connect(fixedTranslation5.frame_b, pointMass6.frame_a)
      annotation(Line(
          points={{-10,-80},{-10,-92},{2,-92}},
          color={95,95,95},
          thickness=0.5));
    connect(fixedTranslation.frame_b, pointMass1.frame_a)
      annotation(Line(
          points={{20,-10},{40,-10}},
          color={95,95,95},
          thickness=0.5));
    connect(fixedTranslation1.frame_b, pointMass2.frame_a)
      annotation(Line(
          points={{-40,-10},{-60,-10}},
          color={95,95,95},
          thickness=0.5));
    annotation (Documentation(info="<html>
<p>
In order to compare the results of the \"PointMass\" example where
6 point masses are rigidly connected together, in this comparison model,
an equivalent system is setup, with the only difference that the
point masses are replaced by Bodies with zero inertia.
</p>
</html>"));
  end SystemWithStandardBodies;

equation
  connect(fixedTranslation1.frame_a, fixedTranslation.frame_a)
    annotation(Line(
      points={{0,0},{20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_a, fixedTranslation2.frame_a)
    annotation(Line(
      points={{0,0},{10,0},{10,30},{20,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation3.frame_a, fixedTranslation.frame_a)
    annotation(Line(
      points={{0,-30},{10,-30},{10,0},{20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_a, fixedTranslation4.frame_a)
    annotation(Line(
      points={{0,0},{10,0},{10,50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation5.frame_a, fixedTranslation.frame_a)
    annotation(Line(
      points={{10,-50},{10,0},{20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation2.frame_b, pointMass3.frame_a)
    annotation (Line(
      points={{40,30},{70,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation3.frame_b, pointMass4.frame_a)
    annotation (Line(
      points={{-20,-30},{-40,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(pointMass5.frame_a, fixedTranslation4.frame_b)
    annotation (Line(
      points={{10,90},{10,70}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation5.frame_b, pointMass6.frame_a)
    annotation (Line(
      points={{10,-70},{10,-90}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, pointMass1.frame_a)
    annotation (Line(
      points={{40,0},{70,0}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_b, pointMass2.frame_a)
    annotation (Line(
      points={{-20,0},{-50,0}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, freeMotion.frame_a) annotation (Line(
      points={{-60,70},{-40,70}},
      color={95,95,95},
      thickness=0.5));
  connect(freeMotion.frame_b, fixedTranslation1.frame_a) annotation (Line(
      points={{-20,70},{-10,70},{-10,20},{10,20},{10,0},{0,0}},
      color={95,95,95},
      thickness=0.5));

  annotation (
    experiment(
      StopTime=3.0,
      Tolerance=1e-006),
    Documentation(info="<html>
<p>
This model demonstrates the usage of model Parts.PointMass in a
point gravity field. 6 point masses are connected rigidly together.
Translating such a model results in an error, because point masses do
not define an orientation object. The example demonstrates that in such
a case (when the orientation object is not defined by an object that
is connected to a point mass), a \"MultiBody.Joints.FreeMotion\" joint
has to be used, to define the degrees of freedom of this structure.
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
object visualizes the point masses in \"red\", whereas the \"referenceSystem\" shows
its bodies in \"blue\".

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PointGravityWithPointMasses2.png\">
</p></html>"));
end PointGravityWithPointMasses2;
