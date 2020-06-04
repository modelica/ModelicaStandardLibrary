within ModelicaTest;
package MultiBody "Test models for Modelica.Mechanics.MultiBody"
  import Modelica.Mechanics.MultiBody;
  model PlanarLoopWithMove
    "Move block + multi-body system where index reduction can fail"

    extends Modelica.Icons.Example;
    parameter SI.Length rh1[3]={0.5,0,0} "Position vector from r1 to r4";
    parameter SI.Length rv1[3]={0,0.5,0} "Position vector from r1 to r2";
    parameter SI.Length rv2[3]={0.1,0.5,0} "Position vector from r4 to r2";
    final parameter SI.Length rh2[3]=rv2 + rh1 - rv1
      "Position vector from r2 to r3";

    inner MultiBody.World world(
      axisDiameter=0.6/40,
      axisLength=0.8) annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
    MultiBody.Joints.Revolute r1(useAxisFlange=true)
      annotation (Placement(transformation(
          origin={0,-10},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    MultiBody.Joints.Revolute r2 annotation (Placement(
          transformation(extent={{20,30},{40,50}})));
    MultiBody.Joints.Revolute r3 annotation (Placement(
          transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={90,10})));
    MultiBody.Joints.RevolutePlanarLoopConstraint r4
      annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
    MultiBody.Parts.FixedTranslation rod1(r=rv1) annotation (
       Placement(transformation(
          origin={0,20},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    MultiBody.Parts.FixedTranslation rod2(r=rh1) annotation (
       Placement(transformation(extent={{20,-60},{40,-40}})));
    MultiBody.Parts.BodyShape bodyShape(
      m=1,
      r=rh2,
      r_CM=rh2/2) annotation (Placement(transformation(extent={{50,30},{70,50}})));
    MultiBody.Parts.FixedTranslation rod3(r=rv2) annotation (
       Placement(transformation(
          origin={90,-20},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Blocks.Math.MatrixGain deg2rad1(
      K=[2*Modelica.Math.asin(1)/180,0,0;0,2*Modelica.Math.asin(1)/180,0; 0,0,2*Modelica.Math.asin(1)/180])
      annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0,0,10,0; 1,10,10,0; 2,20,10,0; 3,30,10,0],
      extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints)
      annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
    Modelica.Mechanics.Rotational.Sources.Move move
      annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  equation
    connect(world.frame_b, r1.frame_a) annotation (Line(
        points={{-20,-50},{-6.66134e-16,-50},{-6.66134e-16,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(rod1.frame_a, r1.frame_b) annotation (Line(
        points={{-6.66134e-016,10},{-6.66134e-016,6},{-6.66134e-016,0},{4.44089e-016,
            0}},
        thickness=0.5));
    connect(rod2.frame_a, world.frame_b) annotation (Line(
        points={{20,-50},{-20,-50}},
        color={95,95,95},
        thickness=0.5));
    connect(rod1.frame_b, r2.frame_a) annotation (Line(
        points={{4.44089e-16,30},{4.44089e-16,40},{20,40}},
        color={95,95,95},
        thickness=0.5));
    connect(bodyShape.frame_b, r3.frame_a) annotation (Line(
        points={{70,40},{90,40},{90,20}},
        color={95,95,95},
        thickness=0.5));
    connect(rod2.frame_b, r4.frame_a) annotation (Line(
        points={{40,-50},{50,-50}},
        color={95,95,95},
        thickness=0.5));
    connect(r4.frame_b, rod3.frame_a) annotation (Line(
        points={{70,-50},{90,-50},{90,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(rod3.frame_b, r3.frame_b) annotation (Line(
        points={{90,-10},{90,0}},
        color={95,95,95},
        thickness=0.5));
    connect(combiTimeTable.y, deg2rad1.u) annotation (Line(
        points={{-79,-10},{-72,-10}}, color={0,0,127}));
    connect(move.flange, r1.axis) annotation (Line(
        points={{-20,-10},{-10,-10}}));
    connect(deg2rad1.y, move.u) annotation (Line(
        points={{-49,-10},{-42,-10}}, color={0,0,127}));
    connect(r2.frame_b, bodyShape.frame_a) annotation (Line(
        points={{40,40},{50,40}},
        color={95,95,95},
        thickness=0.5));
    annotation (experiment(StopTime=3), Documentation(info="<html>
<p>
This model is a combination of a multi-body system with a kinematic loop
and a Move block, where symbolic transformation is difficult:
</p>

<p>
Standard symbolic transformation works in the following way if functions
are present with annotation \"InineAfterIndexReduction = true\".
</p>

<ol>
<li> These functions are not inlined, the Pantelides algorithm
     is applied and the equations are symbolically differentiated.</li>

<li> The functions are inlined and further symbolic transformation
     is performed (sorting the equations, dummy derivative method etc..</li>
</ol>

<p>
The model contains the following functions that have annotation
\"InineAfterIndexReduction = true\":
</p>

<ol>
<li> MultiBody.Frames.resolve1/resolve2(..) functions are used to transform the coordinates
     of a vector in another coordinate system. When these functions need to be differentiated
     in the Pantelides algorithm, then Euler's differentiation rule is applied with the angular velocity
     that is usually a factor of 2-3 more efficient as if direct differentiation
     is applied. The drawback is that the sparsity structure is more \"coarse\" and
     this lets the Pantelides algorithm fail in this example (this happens usually only
     in systems with kinematic loops). This means that the differentiated equation system
     is structurally singular, after the functions with annotation \"InineAfterIndexReduction = true\"
     are inlined.</li>
<li> The Rotational.Sources.Move block is using internally functions to express that
     an input u[2] is the derivative of input u[1]. In order that this is possible, the functions
     have the annotation \"InineAfterIndexReduction = true\" so that the differentiation takes place
     with the not inlined functions. After the Pantelides algorithm and the differentiation
     is applied, the functions are inlined to enhance efficiency.</li>
</ol>

<p>
The problem with (1) is that after inlining the functions with
annotation \"InineAfterIndexReduction = true\", the equations are structurally singular, but the
source of the singularity is now known. One remedy is to restart symbolic processing and to
inline all functions with \"InineAfterIndexReduction = true\" before the Pantelides algorithm
is applied. In the model, this approach is in principal successful and the model would
be structurally regular. However, the Move block is no longer working correctly if the Pantelides
algorithm is applied with inlining. For this reason in MSL 3.2.1 build 3, the annotation
\"InineAfterIndexReduction = true\" in the Move block has been replaced by
annotation \"Inline = false\". This results in slightly less efficient code, but is more robust
in the situation at hand.
</p>
</html>"));
  end PlanarLoopWithMove;
  extends Modelica.Icons.ExamplesPackage;

  model SphericalDoublePendulum
    "Double pendulum with two spherical joints and two bodies"
    extends Modelica.Icons.Example;
    inner MultiBody.World world annotation (Placement(
          transformation(extent={{-88,0},{-68,20}})));
    MultiBody.Parts.BodyBox boxBody1(width=0.06, r={0.4,0.0,
          -0.3}) annotation (Placement(transformation(extent={{-10,0},{10,20}})));
    MultiBody.Parts.BodyBox boxBody2(width=0.06, r={0.3,-0.4,
          0}) annotation (Placement(transformation(extent={{74,0},{94,20}})));
    MultiBody.Joints.Spherical Spherical1(
      enforceStates=true,
      useQuaternions=false,
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false,
      w_rel_a_start={0.05235987755982989,0.03490658503988659,0.0174532925199433})
      annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
    MultiBody.Joints.Spherical Spherical2(
      enforceStates=true,
      useQuaternions=false,
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false) annotation (Placement(transformation(extent={{32,0},
              {52,20}})));
    MultiBody.Parts.BodyBox boxBody3(width=0.06, r={0.4,0.0,
          -0.3}) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    MultiBody.Parts.BodyBox boxBody4(width=0.06, r={0.3,-0.4,
          0}) annotation (Placement(transformation(extent={{76,-40},{96,-20}})));
    MultiBody.Joints.Spherical Spherical3(
      enforceStates=true,
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false,
      w_rel_a_start={0.05235987755982989,0.03490658503988659,0.0174532925199433})
      annotation (Placement(transformation(extent={{-52,-40},{-32,-20}})));
    MultiBody.Joints.Spherical Spherical4(
      enforceStates=true,
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false) annotation (Placement(transformation(extent={{32,-40},
              {52,-20}})));
    MultiBody.Parts.BodyBox boxBody5(
      width=0.06,
      r={0.4,0.0,-0.3},
      useQuaternions=true) annotation (Placement(transformation(extent={{-10,-80},
              {10,-60}})));
    MultiBody.Parts.BodyBox boxBody6(
      width=0.06,
      r={0.3,-0.4,0},
      useQuaternions=true) annotation (Placement(transformation(extent={{74,-80},
              {94,-60}})));
    MultiBody.Joints.Spherical Spherical5(
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false,
      w_rel_a_start={0.05235987755982989,0.03490658503988659,0.0174532925199433})
      annotation (Placement(transformation(extent={{-52,-80},{-32,-60}})));
    MultiBody.Joints.Spherical Spherical6(
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false) annotation (Placement(transformation(extent={{32,-80},
              {52,-60}})));
  equation

    connect(boxBody1.frame_b, Spherical2.frame_a) annotation (Line(
        points={{10,10},{32,10}},
        thickness=0.5));
    connect(Spherical2.frame_b, boxBody2.frame_a) annotation (Line(
        points={{52,10},{74,10}},
        thickness=0.5));
    connect(world.frame_b, Spherical1.frame_a) annotation (Line(
        points={{-68,10},{-52,10}},
        thickness=0.5));
    connect(Spherical1.frame_b, boxBody1.frame_a) annotation (Line(
        points={{-32,10},{-10,10}},
        thickness=0.5));
    connect(boxBody3.frame_b, Spherical4.frame_a) annotation (Line(
        points={{10,-30},{32,-30}},
        thickness=0.5));
    connect(Spherical4.frame_b, boxBody4.frame_a) annotation (Line(
        points={{52,-30},{76,-30}},
        thickness=0.5));
    connect(Spherical3.frame_b, boxBody3.frame_a) annotation (Line(
        points={{-32,-30},{-10,-30}},
        thickness=0.5));
    connect(world.frame_b, Spherical3.frame_a) annotation (Line(
        points={{-68,10},{-60,10},{-60,-30},{-52,-30}},
        thickness=0.5));
    connect(boxBody5.frame_b, Spherical6.frame_a) annotation (Line(
        points={{10,-70},{32,-70}},
        thickness=0.5));
    connect(Spherical6.frame_b, boxBody6.frame_a) annotation (Line(
        points={{52,-70},{74,-70}},
        thickness=0.5));
    connect(Spherical5.frame_b, boxBody5.frame_a) annotation (Line(
        points={{-32,-70},{-10,-70}},
        thickness=0.5));
    connect(Spherical5.frame_a, world.frame_b) annotation (Line(
        points={{-52,-70},{-60,-70},{-60,10},{-68,10}},
        thickness=0.5));
    annotation (experiment(StopTime=3), Documentation(info="<html>
<p>
This example demonstrates that by using joint and body
elements animation is automatically available. Also the revolute
joints are animated. Note, that animation of every component
can be switched of by setting the first parameter <strong>animation</strong>
to <strong>false</strong> or by setting <strong>enableAnimation</strong> in the <strong>world</strong>
object to <strong>false</strong> to switch off animation of all components.
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulum.png\"
alt=\"model Examples.Elementary.DoublePendulum\">
</div>
</html>"));
  end SphericalDoublePendulum;

  model WorldGroundVisualization "Demonstrate visualization of world's ground plane"
    extends Modelica.Icons.Example;

    MultiBody.Visualizers.FixedArrow visGroundAxis(
      animation=true,
      r_tail={0,0,0},
      n=world.groundAxis_u,
      length=world.nominalLength/4) "Visualize arrow in direction of world.groundAxis_u" annotation (Placement(transformation(extent={{0,-10},{20,10}})));

    inner MultiBody.World world(
      groundLength_v=0.2,
      animateGround=true,
      groundAxis_u={1,0.3,0},
      groundColor={0,128,0},
      n={-0.2,0.3,-1},
      groundLength_u=1,
      animateGravity=true,
      gravityType=MultiBody.Types.GravityTypes.UniformGravity)
                        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  equation
    connect(visGroundAxis.frame_a, world.frame_b) annotation (Line(
        points={{0,0},{-20,0}},
        color={95,95,95},
        thickness=0.5));
    annotation (experiment(StopTime=1));
  end WorldGroundVisualization;

  package FourbarVariants "Test joints and assembly joints with four bar loop"
    extends Modelica.Icons.ExamplesPackage;
    model SphericalAndUniversal
      "One kinematic loop with four bars (with Spherical and Universal joint)"

      extends Modelica.Icons.Example;

      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,-80},{-60,-60}})));
      MultiBody.Joints.Revolute j1(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true, start=5.235987755982989)) annotation (Placement(
            transformation(extent={{-54,-40},{-34,-20}})));
      MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        boxWidth=0.05) annotation (Placement(transformation(extent={{12,-80},{32,-60}})));
      MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1},
          diameter=0.05) annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=
            0.05) annotation (Placement(transformation(
            origin={50,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.FixedTranslation b3(r={1,0,0},
          animation=false) annotation (Placement(transformation(extent={{-32,-80},
                {-12,-60}})));
      MultiBody.Joints.Spherical spherical(animation=false)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      MultiBody.Parts.FixedTranslation FixedTranslation1(r={
            1,-0.3,-0.1}, animation=false) annotation (Placement(transformation(
              extent={{12,20},{32,40}})));
      MultiBody.Joints.Universal Universal1(n_b={0,1,0}, n_a=
           {0,0,1}) annotation (Placement(transformation(extent={{44,20},{64,40}})));
    equation
      j1_phi = j1.phi;
      j2_s = j2.s;
      j1_w = j1.w;
      j2_v = j2.v;
      connect(j2.frame_b, b2.frame_a) annotation (Line(
          points={{32,-70},{50,-70},{50,-60}},
          thickness=0.5));
      connect(j1.frame_b, b1.frame_a) annotation (Line(
          points={{-34,-30},{-30,-30},{-30,-10}},
          thickness=0.5));
      connect(j1.frame_a, world.frame_b) annotation (Line(
          points={{-54,-30},{-60,-30},{-60,-70}},
          thickness=0.5));
      connect(b3.frame_a, world.frame_b) annotation (Line(
          points={{-32,-70},{-60,-70}},
          thickness=0.5));
      connect(b3.frame_b, j2.frame_a) annotation (Line(
          points={{-12,-70},{12,-70}},
          thickness=0.5));
      connect(b1.frame_b, spherical.frame_a) annotation (Line(
          points={{-30,10},{-30,30},{-20,30}},
          thickness=0.5));
      connect(spherical.frame_b, FixedTranslation1.frame_a) annotation (Line(
          points={{0,30},{12,30}},
          thickness=0.5));
      connect(FixedTranslation1.frame_b, Universal1.frame_a) annotation (Line(
          points={{32,30},{44,30}},
          thickness=0.5));
      connect(b2.frame_b, Universal1.frame_b) annotation (Line(
          points={{50,-40},{50,-2},{80,-2},{80,30},{64,30}},
          thickness=0.5));
      annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
This is a second version of the \"four-bar\" mechanism, see figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar2.png\" alt=\"model Examples.Loops.Fourbar2\">
</div>

<p>
In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <strong>UniversalSpherical</strong>
that is a rod connecting a spherical and a universal joint. This joint is defined
by <strong>1 constraint</strong> stating that the distance between the two spherical joints is
constant. Using this joint in a kinematic loop reduces the sizes of
non-linear algebraic equations. For this loop, only one non-linear
algebraic system of equations of order 1 remains.
</p>
<p>
At the UniversalSpherical joint an additional frame_ia fixed to the rod
is present where components can be attached to the connecting rod. In this
example just a coordinate system is attached to visualize frame_ia (coordinate
system on the right in blue color).
</p>
<p>
Another feature is that the length of the connecting rod can be
automatically calculated during <strong>initialization</strong>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the rod length of joint
\"UniversalSpherical\" is computed during initialization since parameter
<strong>computeLength</strong> = <strong>true</strong> is set in the joint parameter
menu. The main advantage is that during initialization no non-linear
system of equation is solved and therefore initialization always works.
To be precise, the following trivial non-linear equation is actually solved
for rodLength:
</p>
<blockquote><pre>
   rodLength*rodLength = f(angle of revolute joint, distance of prismatic joint)
</pre></blockquote>
</html>"));
    end SphericalAndUniversal;

    model SphericalSpherical
      "One kinematic loop with four bars (with SphericalSpherical joint)"

      extends Modelica.Icons.Example;

      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,-80},{-60,-60}})));
      MultiBody.Joints.Revolute j1(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true, start=5.235987755982989)) annotation (Placement(
            transformation(extent={{-54,-40},{-34,-20}})));
      MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        a(fixed=false),
        s(fixed=true),
        v(fixed=false)) annotation (Placement(transformation(extent={{12,-80},{32,-60}})));
      MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1},
          diameter=0.05) annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=
            0.05) annotation (Placement(transformation(
            origin={50,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Joints.SphericalSpherical sphericalSpherical(
          computeRodLength=true, m=1) annotation (Placement(transformation(
              extent={{0,20},{-20,40}})));
      MultiBody.Parts.FixedTranslation b3(r={1,0,0},
          animation=false) annotation (Placement(transformation(extent={{-32,-80},
                {-12,-60}})));
    equation
      connect(j2.frame_b, b2.frame_a) annotation (Line(
          points={{32,-70},{50,-70},{50,-60}},
          thickness=0.5));
      connect(j1.frame_b, b1.frame_a) annotation (Line(
          points={{-34,-30},{-30,-30},{-30,-10}},
          thickness=0.5));
      connect(j1.frame_a, world.frame_b) annotation (Line(
          points={{-54,-30},{-60,-30},{-60,-70}},
          thickness=0.5));
      connect(b1.frame_b, sphericalSpherical.frame_b) annotation (Line(
          points={{-30,10},{-30,30},{-20,30}},
          thickness=0.5));
      connect(sphericalSpherical.frame_a, b2.frame_b) annotation (Line(
          points={{0,30},{50,30},{50,-40}},
          thickness=0.5));
      j1_phi = j1.phi;
      j2_s = j2.s;
      j1_w = j1.w;
      j2_v = j2.v;
      connect(b3.frame_a, world.frame_b) annotation (Line(
          points={{-32,-70},{-60,-70}},
          thickness=0.5));
      connect(b3.frame_b, j2.frame_a) annotation (Line(
          points={{-12,-70},{12,-70}},
          thickness=0.5));
      annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
This is a third version of the \"four-bar\" mechanism. In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <strong>SphericalSpherical</strong>
that is a rod with two spherical joints on each side. This joint is defined
by <strong>1 constraint</strong> stating that the distance between the two spherical joints is
constant. Using this joint in a kinematic loop reduces the sizes of
non-linear algebraic equations. For this loop, only one non-linear
algebraic system of equations of order 1 remains.
</p>
<p>
The SphericalSpherical joint may be massless or may have a point mass in
the middle of the rod to approximate in an convenient way the rod
mass properties.
</p>
<p>
Another nice feature is that the <strong>length</strong> of the connecting rod can be
automatically calculated during <strong>initialization</strong>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the length parameter of joint
\"SphericalSpherical\" is computed during initialization since parameter
<strong>computeLength</strong> = <strong>true</strong> is set in the joint parameter
menu (this sets \"fixed=false\" on parameter \"length\").
</p>
</html>"));
    end SphericalSpherical;

    model UniversalSpherical
      "One kinematic loop with four bars (with UniversalSpherical joint)"

      extends Modelica.Icons.Example;

      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,-80},{-60,-60}})));
      MultiBody.Joints.Revolute j1(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true, start=5.235987755982989)) annotation (Placement(
            transformation(extent={{-54,-40},{-34,-20}})));
      MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        boxWidth=0.01,
        a(fixed=false),
        s(fixed=false),
        v(fixed=false)) annotation (Placement(transformation(extent={{12,-80},{32,-60}})));
      MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1},
          diameter=0.05) annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=
            0.05) annotation (Placement(transformation(
            origin={50,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Joints.UniversalSpherical universalSpherical(
          rRod_ia={-1,0.3,0.1}, n1_a={0,1,0.1}) annotation (Placement(
            transformation(extent={{0,20},{-20,40}})));
      MultiBody.Parts.FixedTranslation b3(animation=false, r=
           {0.8,0,0}) annotation (Placement(transformation(extent={{-32,-80},{-12,
                -60}})));
      MultiBody.Visualizers.FixedFrame fixedFrame4
        annotation (Placement(transformation(
            origin={-10,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      j1_phi = j1.phi;
      j2_s = j2.s;
      j1_w = j1.w;
      j2_v = j2.v;
      connect(j2.frame_b, b2.frame_a) annotation (Line(
          points={{32,-70},{50,-70},{50,-60}},
          thickness=0.5));
      connect(j1.frame_b, b1.frame_a) annotation (Line(
          points={{-34,-30},{-30,-30},{-30,-10}},
          thickness=0.5));
      connect(j1.frame_a, world.frame_b) annotation (Line(
          points={{-54,-30},{-60,-30},{-60,-70}},
          thickness=0.5));
      connect(b1.frame_b, universalSpherical.frame_b) annotation (Line(
          points={{-30,10},{-30,30},{-20,30}},
          thickness=0.5));
      connect(universalSpherical.frame_a, b2.frame_b) annotation (Line(
          points={{0,30},{50,30},{50,-40}},
          thickness=0.5));
      connect(b3.frame_a, world.frame_b) annotation (Line(
          points={{-32,-70},{-60,-70}},
          thickness=0.5));
      connect(b3.frame_b, j2.frame_a) annotation (Line(
          points={{-12,-70},{12,-70}},
          thickness=0.5));
      connect(fixedFrame4.frame_a, universalSpherical.frame_ia) annotation (
          Line(
          points={{-10,60},{-10,50},{-6,50},{-6,40}},
          thickness=0.5));
      annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
This is a fourth version of the \"four-bar\" mechanism. In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <strong>UniversalSpherical</strong>
that is a rod with a spherical and a universal joint on two sides. This joint is defined
by <strong>1 constraint</strong> stating that the distance between the two spherical joints is
constant. Using this joint in a kinematic loop reduces the sizes of
non-linear algebraic equations. For this loop, only one non-linear
algebraic system of equations of order 1 remains.
</p>
<p>
The essential difference to joint SphericalSpherical is that the
orientation of the rod can be computed by removing one degree of freedom
of one of the spherical joints (i.e., replacing it by a universal joint).
Usually, the eigenrotation of the connecting rod is of no technical
interest and by this approximation it is constrained to move in a
somewhat arbitrary way. This allows to have an additional connector,
<strong>frame_ia</strong>, to be fixed on the rod, where other objects can be attached.
In this example, the coordinate system of frame_ia is visualized.
</p>
<p>
Another nice feature is that the <strong>length</strong> of the connecting rod can be
automatically calculated during <strong>initialization</strong>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the length parameter of joint
\"UniversalSpherical\" is computed during initialization since parameter
<strong>computeLength</strong> = <strong>true</strong> is set in the joint parameter
menu (this sets \"fixed=false\" on parameter \"length\").
</p>
</html>"));
    end UniversalSpherical;

    model JointUSR "One kinematic loop with four bars (using JointUSR joint)"

      extends Modelica.Icons.Example;

      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,-80},{-60,-60}})));
      MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        s(fixed=true),
        v(fixed=true, start=-0.4)) annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
      MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=
            0.05) annotation (Placement(transformation(
            origin={40,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.FixedTranslation b3(animation=false, r=
           {1,0,0}) annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
      MultiBody.Visualizers.FixedFrame fixedFrame
        annotation (Placement(transformation(
            origin={30,30},
            extent={{-10,-10},{10,10}})));
      MultiBody.Joints.Assemblies.JointUSR jointUSR(
        n1_a={0,1,0},
        n_b={1,0,0},
        rRod2_ib={0,0.5,0.1},
        checkTotalPower=true,
        rRod1_ia={-1,0.3,-0.1}) annotation (Placement(transformation(extent={{0,
                0},{-20,20}})));
      MultiBody.Parts.Body Body1(
        m=1,
        I_11=0.1,
        I_22=0.1,
        I_33=0.1,
        r_CM={0.01,0,0}) annotation (Placement(transformation(extent={{-30,30},
                {-50,50}})));
      MultiBody.Parts.Body Body2(
        m=1,
        I_11=0.1,
        I_22=0.1,
        I_33=0.1,
        r_CM=jointUSR.eRod1_ia/2) annotation (Placement(transformation(extent={
                {20,50},{40,70}})));
      MultiBody.Parts.Body Body3(
        m=1,
        I_11=0.1,
        I_22=0.1,
        I_33=0.1,
        r_CM={0,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-10,70})));
      Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1) annotation (
         Placement(transformation(
            origin={-60,10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      j1_phi = jointUSR.revolute.phi;
      j2_s = j2.s;
      j1_w = der(jointUSR.revolute.phi);
      j2_v = j2.v;
      connect(j2.frame_b, b2.frame_a) annotation (Line(
          points={{30,-70},{40,-70},{40,-40}},
          thickness=0.5));
      connect(b3.frame_a, world.frame_b) annotation (Line(
          points={{-30,-70},{-60,-70}},
          thickness=0.5));
      connect(b3.frame_b, j2.frame_a) annotation (Line(
          points={{-10,-70},{10,-70}},
          thickness=0.5));
      connect(world.frame_b, jointUSR.frame_b) annotation (Line(
          points={{-60,-70},{-40,-70},{-40,10},{-20,10}},
          thickness=0.5));
      connect(jointUSR.frame_a, b2.frame_b) annotation (Line(
          points={{0,10},{40,10},{40,-20}},
          thickness=0.5));
      connect(damper.flange_b, jointUSR.axis) annotation (Line(
          points={{-60,20},{-50,20},{-50,18},{-20,18}}));
      connect(damper.flange_a, jointUSR.bearing) annotation (Line(
          points={{-60,0},{-50,0},{-50,14},{-20,14}}));
      connect(Body1.frame_a, jointUSR.frame_ib) annotation (Line(
          points={{-30,40},{-18,40},{-18,20}},
          color={95,95,95},
          thickness=0.5));
      connect(Body2.frame_a, jointUSR.frame_ia) annotation (Line(
          points={{20,60},{10,60},{10,30},{-2,30},{-2,20}},
          color={95,95,95},
          thickness=0.5));
      connect(Body3.frame_a, jointUSR.frame_im) annotation (Line(
          points={{-10,60},{-10,20},{-10,20}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedFrame.frame_a, jointUSR.frame_ia) annotation (Line(
          points={{20,30},{-2,30},{-2,20}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=2), Documentation(info="<html>
<p>
This is a fourth version of the \"four-bar\" mechanism. In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <strong>UniversalSpherical</strong>
that is a rod with a spherical and a universal joint on two sides. This joint is defined
by <strong>1 constraint</strong> stating that the distance between the two spherical joints is
constant. Using this joint in a kinematic loop reduces the sizes of
non-linear algebraic equations. For this loop, only one non-linear
algebraic system of equations of order 1 remains.
</p>
<p>
The essential difference to joint SphericalSpherical is that the
orientation of the rod can be computed by removing one degree of freedom
of one of the spherical joints (i.e., replacing it by a universal joint).
Usually, the eigenrotation of the connecting rod is of no technical
interest and by this approximation it is constrained to move in a
somewhat arbitrary way. This allows to have an additional connector,
<strong>frame_ia</strong>, to be fixed on the rod, where other objects can be attached.
In this example, the coordinate system of frame_ia is visualized.
</p>
<p>
Another nice feature is that the <strong>length</strong> of the connecting rod can be
automatically calculated during <strong>initialization</strong>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the length parameter of joint
\"UniversalSpherical\" is computed during initialization since parameter
<strong>computeLength</strong> = <strong>true</strong> is set in the joint parameter
menu (this sets \"fixed=false\" on parameter \"length\").
</p>
</html>"));
    end JointUSR;

    model JointSSR "One kinematic loop with four bars (using JointSSR joint)"

      extends Modelica.Icons.Example;
      parameter SI.Distance L=Modelica.Math.Vectors.length({-1,
          0.3,0.1});
      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,-80},{-60,-60}})));
      MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        s(fixed=true),
        v(fixed=true, start=-0.2)) annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
      MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=
            0.05) annotation (Placement(transformation(
            origin={40,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.FixedTranslation b3(animation=false, r=
           {1,0,0}) annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
      MultiBody.Joints.Assemblies.JointSSR jointSSR(
        n_b={1,0,0},
        rRod2_ib={0,0.5,0.1},
        rod1Length=L,
        checkTotalPower=true,
        rod1Mass=0.1) annotation (Placement(transformation(extent={{0,0},{-20,20}})));
      MultiBody.Visualizers.FixedFrame FixedFrame1
        annotation (Placement(transformation(extent={{-30,60},{-50,80}})));
      MultiBody.Parts.Body Body1(r_CM=jointSSR.rRod2_ib/2, m=
           0.1) annotation (Placement(transformation(extent={{-30,30},{-50,50}})));
      MultiBody.Parts.Body Body2(m=0.1, r_CM={0,0,0})
        annotation (Placement(transformation(extent={{0,30},{20,50}})));
      Modelica.Mechanics.Rotational.Components.Damper damper(d=0.5) annotation (
         Placement(transformation(
            origin={-60,10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      j1_phi = jointSSR.revolute.phi;
      j2_s = j2.s;
      j1_w = der(jointSSR.revolute.phi);
      j2_v = j2.v;
      connect(jointSSR.axis, damper.flange_b) annotation (Line(points={{-20,18},
              {-50,18},{-50,20},{-60,20}}));
      connect(jointSSR.bearing, damper.flange_a) annotation (Line(points={{-20,
              14},{-50,14},{-50,0},{-60,0}}));
      connect(world.frame_b, b3.frame_a) annotation (Line(
          points={{-60,-70},{-30,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, jointSSR.frame_b) annotation (Line(
          points={{-60,-70},{-40,-70},{-40,10},{-20,10}},
          color={95,95,95},
          thickness=0.5));
      connect(b3.frame_b, j2.frame_a) annotation (Line(
          points={{-10,-70},{10,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(j2.frame_b, b2.frame_a) annotation (Line(
          points={{30,-70},{40,-70},{40,-40}},
          color={95,95,95},
          thickness=0.5));
      connect(b2.frame_b, jointSSR.frame_a) annotation (Line(
          points={{40,-20},{40,10},{0,10}},
          color={95,95,95},
          thickness=0.5));
      connect(Body1.frame_a, jointSSR.frame_ib) annotation (Line(
          points={{-30,40},{-18,40},{-18,20}},
          color={95,95,95},
          thickness=0.5));
      connect(Body2.frame_a, jointSSR.frame_im) annotation (Line(
          points={{0,40},{-10,40},{-10,20}},
          color={95,95,95},
          thickness=0.5));
      connect(FixedFrame1.frame_a, jointSSR.frame_ib) annotation (Line(
          points={{-30,70},{-18,70},{-18,20}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1), Documentation(info="<html>
<p>
This is a fourth version of the \"four-bar\" mechanism. In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <strong>UniversalSpherical</strong>
that is a rod with a spherical and a universal joint on two sides. This joint is defined
by <strong>1 constraint</strong> stating that the distance between the two spherical joints is
constant. Using this joint in a kinematic loop reduces the sizes of
non-linear algebraic equations. For this loop, only one non-linear
algebraic system of equations of order 1 remains.
</p>
<p>
The essential difference to joint SphericalSpherical is that the
orientation of the rod can be computed by removing one degree of freedom
of one of the spherical joints (i.e., replacing it by a universal joint).
Usually, the eigenrotation of the connecting rod is of no technical
interest and by this approximation it is constrained to move in a
somewhat arbitrary way. This allows to have an additional connector,
<strong>frame_ia</strong>, to be fixed on the rod, where other objects can be attached.
In this example, the coordinate system of frame_ia is visualized.
</p>
<p>
Another nice feature is that the <strong>length</strong> of the connecting rod can be
automatically calculated during <strong>initialization</strong>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the length parameter of joint
\"UniversalSpherical\" is computed during initialization since parameter
<strong>computeLength</strong> = <strong>true</strong> is set in the joint parameter
menu (this sets \"fixed=false\" on parameter \"length\").
</p>
</html>"));
    end JointSSR;

    model JointUSP "One kinematic loop with four bars (using JointUSP joint)"

      extends Modelica.Icons.Example;

      output SI.Angle revolute_phi "angle of revolute joint j1";
      output SI.Position prismatic_s "distance of prismatic joint j2";
      output SI.AngularVelocity revolute_w "axis speed of revolute joint j1";
      output SI.Velocity prismatic_v "axis velocity of prismatic joint j2";

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,-80},{-60,-60}})));
      MultiBody.Joints.Revolute revolute(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true, start=5.235987755982989)) annotation (Placement(
            transformation(extent={{-40,-40},{-20,-20}})));
      MultiBody.Parts.BodyCylinder body1(r={0,0.5,0.1},
          diameter=0.05) annotation (Placement(transformation(
            origin={-10,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body3(r={0,0.2,0},
          diameter=0.05) annotation (Placement(transformation(
            origin={40,60},
            extent={{-10,-10},{10,10}})));
      MultiBody.Parts.FixedTranslation ground_rod(animation=
            false, r={1.2,0,0}) annotation (Placement(transformation(extent={{-32,
                -80},{-12,-60}})));
      MultiBody.Joints.Assemblies.JointUSP jointUSP(
        rRod2_ib={0,0.2,0},
        n1_a={0,0,-1},
        n_b={-1,0,0},
        rod1Diameter=0.04,
        boxWidth=0.05,
        rRod1_ia={1,-0.3,0.1}) annotation (Placement(transformation(extent={{0,
                20},{20,40}})));
      MultiBody.Parts.BodyCylinder body2(r={1,-0.3,0.1},
          diameter=0.05) annotation (Placement(transformation(extent={{-10,50},
                {-30,70}})));
      Modelica.Mechanics.Translational.Components.Damper damper(d=50)
        annotation (Placement(transformation(
            origin={50,30},
            extent={{10,-10},{-10,10}},
            rotation=270)));
    equation
      revolute_phi = revolute.phi;
      prismatic_s = jointUSP.prismatic.s;
      revolute_w = revolute.w;
      prismatic_v = der(jointUSP.prismatic.s);
      connect(jointUSP.bearing, damper.flange_a) annotation (Line(points={{20,
              34},{38,34},{38,18},{50,18},{50,20}}, color={0,191,0}));
      connect(jointUSP.axis, damper.flange_b) annotation (Line(points={{20,38},
              {38,38},{38,40},{50,40}}, color={0,191,0}));
      connect(ground_rod.frame_b, jointUSP.frame_b) annotation (Line(
          points={{-12,-70},{30,-70},{30,30},{20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, ground_rod.frame_a) annotation (Line(
          points={{-60,-70},{-32,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, revolute.frame_a) annotation (Line(
          points={{-60,-70},{-50,-70},{-50,-30},{-40,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute.frame_b, body1.frame_a) annotation (Line(
          points={{-20,-30},{-10,-30},{-10,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(body1.frame_b, jointUSP.frame_a) annotation (Line(
          points={{-10,0},{-10,30},{0,30}},
          color={95,95,95},
          thickness=0.5));
      connect(jointUSP.frame_ia, body2.frame_a) annotation (Line(
          points={{2,40},{2,60},{-10,60}},
          color={95,95,95},
          thickness=0.5));
      connect(jointUSP.frame_ib, body3.frame_a) annotation (Line(
          points={{18,40},{18,60},{30,60}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=5), Documentation(info=""));
    end JointUSP;
  end FourbarVariants;

  package Frames "Test functions of package Frames"
    extends Modelica.Icons.ExamplesPackage;
    model AngularVelocity "Test angular velocity functions"

      import Modelica.Mechanics.MultiBody.Frames.{angularVelocity1, angularVelocity2, resolve1};
      extends Modelica.Icons.Example;
      MultiBody.Frames.Orientation R=body.frame_a.R;
      SI.AngularVelocity wa[3]=angularVelocity2(R);
      SI.AngularVelocity w1[3]=resolve1(R, wa);
      SI.AngularVelocity w2[3]=angularVelocity1(R);
      SI.AngularVelocity w_err[3]=w2 - w1;
      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,20},{-60,40}})));
      MultiBody.Parts.FixedTranslation bar2(r={0.8,0,0},
          animation=false) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      MultiBody.Forces.Spring spring1(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={-40,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyShape body(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r={0.4,0,0},
        r_CM={0.2,0,0},
        width=0.05,
        angles_start={0.174532925199433,0.174532925199433,0.174532925199433},
        a_0(each fixed=false),
        angles_fixed=true,
        r_0(each fixed=true, start={0.2,-0.5,0.1}),
        v_0(each fixed=true),
        w_0_fixed=true,
        z_0_fixed=false) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      MultiBody.Forces.Spring spring2(
        c=20,
        s_unstretched=0,
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5) annotation (Placement(transformation(
            origin={20,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Forces.WorldTorque FrameTorque1(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={10,0,0}) annotation (
          Placement(transformation(extent={{90,-40},{70,-20}})));
    equation
      connect(bar2.frame_a, world.frame_b) annotation (Line(
          points={{-20,30},{-60,30}},
          thickness=0.5));
      connect(spring1.frame_b, body.frame_a) annotation (Line(
          points={{-40,-10},{-40,-30},{-20,-30}},
          thickness=0.5));
      connect(spring2.frame_b, body.frame_b) annotation (Line(
          points={{20,-10},{20,-30},{0,-30}},
          thickness=0.5));
      connect(bar2.frame_b, spring2.frame_a) annotation (Line(
          points={{0,30},{20,30},{20,10}},
          thickness=0.5));
      connect(spring1.frame_a, world.frame_b) annotation (Line(
          points={{-40,10},{-40,30},{-60,30}},
          thickness=0.5));
      connect(FrameTorque1.frame_b, body.frame_b) annotation (Line(
          points={{30,-30},{0,-30}},
          thickness=0.5));
      connect(Constant1.y, FrameTorque1.torque) annotation (Line(points={{69,-30},{52,-30}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end AngularVelocity;
  end Frames;

  package Forces
    extends Modelica.Icons.ExamplesPackage;
    model DifferentiationOfForces
      extends Modelica.Icons.Example;
      inner MultiBody.World world(gravityType=MultiBody.Types.GravityTypes.UniformGravity)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-70,70})));
      MultiBody.Joints.Revolute rev(
        n={0,0,1},
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-70,40})));
      MultiBody.Parts.BodyBox body(r={1,0,0}) annotation (
          Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Blocks.Sources.Sine sine1[3](each f=1) annotation (
          Placement(transformation(extent={{80,20},{60,40}})));
      MultiBody.Sensors.CutForce cutForce annotation (
          Placement(transformation(extent={{0,0},{-20,20}})));
      Modelica.Blocks.Continuous.Der der1[3] annotation (Placement(
            transformation(extent={{20,-60},{40,-40}})));
      Modelica.Blocks.Continuous.Der der2[3] annotation (Placement(
            transformation(extent={{50,-60},{70,-40}})));
      MultiBody.Forces.WorldForceAndTorque forceAndTorque(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{40,20},{20,0}})));
      Modelica.Blocks.Sources.Sine sine2[3](each f=1) annotation (
          Placement(transformation(extent={{80,-20},{60,0}})));
    equation
      connect(world.frame_b, rev.frame_a) annotation (Line(
          points={{-70,60},{-70,50}},
          color={95,95,95},
          thickness=0.5));
      connect(body.frame_a, rev.frame_b) annotation (Line(
          points={{-60,10},{-70,10},{-70,30}},
          color={95,95,95},
          thickness=0.5));
      connect(cutForce.frame_b, body.frame_b) annotation (Line(
          points={{-20,10},{-40,10}},
          color={95,95,95},
          thickness=0.5));
      connect(cutForce.force, der1.u)
        annotation (Line(points={{-2,-1},{-2,-50},{18,-50}},color={0,0,127}));
      connect(der1.y, der2.u)
        annotation (Line(points={{41,-50},{48,-50}}, color={0,0,127}));
      connect(forceAndTorque.frame_b, cutForce.frame_a) annotation (Line(
          points={{20,10},{0,10}},
          color={95,95,95},
          thickness=0.5));
      connect(sine1.y, forceAndTorque.force) annotation (Line(
          points={{59,30},{50,30},{50,16},{42,16}},         color={0,0,127}));
      connect(sine2.y, forceAndTorque.torque) annotation (Line(
          points={{59,-10},{50,-10},{50,4},{42,4}},         color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end DifferentiationOfForces;

    model Force
      extends Modelica.Icons.Example;
      inner MultiBody.World world(defaultN_to_m=600) annotation (Placement(transformation(
            extent={{-100,80},{-80,100}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,32},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,40},{20,60}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,500,0}) annotation (
          Placement(transformation(
            origin={50,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,0},{-70,20}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}})));
      MultiBody.Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-70},{-68,-50}})));
      MultiBody.Parts.FixedRotation fixedRotation(n={0,0,1}, angle=45) annotation (
          Placement(transformation(extent={{-8,-90},{12,-70}})));
      MultiBody.Forces.Force force1(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_b)
        annotation (Placement(transformation(extent={{60,40},{40,60}})));
      MultiBody.Forces.Force force2(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve)
        annotation (Placement(transformation(extent={{60,-10},{40,-30}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={0,500,0}) annotation (
          Placement(transformation(
            origin={70,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-60,0},{-40,20}})));
      MultiBody.Joints.Revolute Revolute4(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-60,-70},{-40,-50}})));
      MultiBody.Parts.Fixed fixed2(animation=false, r={1.5,0.25,0}) annotation (Placement(
            transformation(extent={{100,40},{80,60}})));
      MultiBody.Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0}) annotation (
          Placement(transformation(extent={{100,-30},{80,-10}})));
    equation
      connect(force1.frame_b, body1.frame_b)
        annotation (Line(points={{40,50},{20,50}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,42},{-20,50},{0,50}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(
          points={{-20,-30},{-20,-20},{0,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(force2.frame_b, body2.frame_b)
        annotation (Line(
          points={{40,-20},{20,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-60,10},{-70,10}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-40,10},{-20,10},{-20,22}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation.frame_b, force2.frame_resolve)
        annotation (Line(points={{12,-80},{46,-80},{46,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed3.frame_b, Revolute4.frame_a)
        annotation (Line(
          points={{-68,-60},{-60,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(
          points={{-40,-60},{-20,-60},{-20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed3.frame_b, fixedRotation.frame_a)
        annotation (Line(
          points={{-68,-60},{-64,-60},{-64,-80},{-8,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, force1.force) annotation (Line(points={{50,79},{50,
              70},{56,70},{56,62}}, color={0,0,127}));
      connect(Constant2.y, force2.force) annotation (Line(points={{70,-59},{70,
              -50},{56,-50},{56,-32}}, color={0,0,127}));
      connect(force1.frame_a, fixed2.frame_b) annotation (Line(
          points={{60,50},{60,50},{80,50}},
          thickness=0.5,
          color={95,95,95}));
      connect(fixed4.frame_b, force2.frame_a) annotation (Line(
          points={{80,-20},{60,-20}},
          thickness=0.5,
          color={95,95,95}));
      annotation (experiment(StopTime=1.1));
    end Force;

    model Force2
      extends Modelica.Icons.Example;
      inner MultiBody.World world(defaultN_to_m=600) annotation (Placement(transformation(
            extent={{-190,60},{-170,80}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-130,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));

      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{-110,40},{-90,60}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,500,0}) annotation (
          Placement(transformation(
            origin={-60,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-200,0},{-180,20}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{-110,-30},{-90,-10}})));
      MultiBody.Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-198,-70},{-178,-50}})));
      MultiBody.Parts.FixedRotation fixedRotation(n={0,0,1}, angle=45) annotation (
          Placement(transformation(extent={{-118,-90},{-98,-70}})));
      MultiBody.Forces.Force force1(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_b)
        annotation (Placement(transformation(extent={{-50,40},{-70,60}})));
      MultiBody.Forces.Force force2(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve)
        annotation (Placement(transformation(extent={{-50,-10},{-70,-30}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-130,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={0,500,0}) annotation (
          Placement(transformation(
            origin={-40,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-170,0},{-150,20}})));
      MultiBody.Joints.Revolute Revolute4(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-170,-70},{-150,-50}})));
      MultiBody.Parts.Fixed fixed2(animation=false, r={1.5,0.25,0}) annotation (Placement(
            transformation(extent={{-10,40},{-30,60}})));
      MultiBody.Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0}) annotation (
          Placement(transformation(extent={{-10,-30},{-30,-10}})));
      MultiBody.Joints.Revolute Revolute5(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={80,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));

      MultiBody.Parts.BodyCylinder body3(r={1,0,0}) annotation (Placement(transformation(
              extent={{100,40},{120,60}})));
      Modelica.Blocks.Sources.Constant Constant3[6](k={0,500,0,0,0,0})
        annotation (Placement(transformation(
            origin={150,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      MultiBody.Parts.Fixed fixed5(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{10,0},{30,20}})));
      MultiBody.Parts.BodyCylinder body4(r={1,0,0}) annotation (Placement(transformation(
              extent={{100,-30},{120,-10}})));
      MultiBody.Parts.Fixed fixed6(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{12,-70},{32,-50}})));
      MultiBody.Parts.FixedRotation fixedRotation1(n={0,0,1}, angle=45) annotation (
          Placement(transformation(extent={{92,-90},{112,-70}})));
      MultiBody.Forces.ForceAndTorque force3
        annotation (Placement(transformation(extent={{162,40},{142,60}})));
      MultiBody.Forces.ForceAndTorque force4(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve)
        annotation (Placement(transformation(extent={{160,-10},{140,-30}})));
      MultiBody.Joints.Revolute Revolute6(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={80,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));

      Modelica.Blocks.Sources.Constant Constant4[6](k={0,500,0,0,0,0})
        annotation (Placement(transformation(
            origin={170,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Joints.Revolute Revolute7(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{48,0},{68,20}})));
      MultiBody.Joints.Revolute Revolute8(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{38,-70},{58,-50}})));
      MultiBody.Parts.Fixed fixed7(animation=false, r={1.5,0.25,0}) annotation (Placement(
            transformation(extent={{200,40},{180,60}})));
      MultiBody.Parts.Fixed fixed8(animation=false, r={1.5,-0.25,0}) annotation (
          Placement(transformation(extent={{200,-30},{180,-10}})));
    equation
      connect(force1.frame_b, body1.frame_b)
        annotation (Line(points={{-70,50},{-90,50}}));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-130,40},{-130,50},{-110,50}}));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-130,-30},{-130,-20},{-110,-20}}));
      connect(force2.frame_b, body2.frame_b)
        annotation (Line(points={{-70,-20},{-90,-20}}));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-170,10},{-174,10},{-180,10}}));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-150,10},{-130,10},{-130,20}}));
      connect(fixedRotation.frame_b, force2.frame_resolve)
        annotation (Line(points={{-98,-80},{-64,-80},{-64,-30}}));
      connect(fixed3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-178,-60},{-170,-60}}));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-150,-60},{-130,-60},{-130,-50}}));
      connect(fixed3.frame_b, fixedRotation.frame_a) annotation (Line(points={{
              -178,-60},{-174,-60},{-174,-80},{-118,-80}}));
      connect(Constant1.y, force1.force) annotation (Line(points={{-60,79},{-60,
              70},{-54,70},{-54,62}}, color={0,0,127}));
      connect(Constant2.y, force2.force) annotation (Line(points={{-40,-59},{-40,
              -50},{-54,-50},{-54,-32}}, color={0,0,127}));
      connect(force1.frame_a, fixed2.frame_b) annotation (Line(
          points={{-50,50},{-38.5,50},{-30,50}},
          thickness=0.5));
      connect(fixed4.frame_b, force2.frame_a) annotation (Line(
          points={{-30,-20},{-40,-20},{-50,-20}},
          thickness=0.5));
      connect(force3.frame_b, body3.frame_b)
        annotation (Line(points={{142,50},{120,50}}));
      connect(Revolute5.frame_b, body3.frame_a)
        annotation (Line(points={{80,40},{80,50},{100,50}}));
      connect(Revolute6.frame_b, body4.frame_a)
        annotation (Line(points={{80,-30},{80,-20},{100,-20}}));
      connect(force4.frame_b, body4.frame_b)
        annotation (Line(points={{140,-20},{120,-20}}));
      connect(Revolute7.frame_a, fixed5.frame_b)
        annotation (Line(points={{48,10},{30,10}}));
      connect(Revolute7.frame_b, Revolute5.frame_a)
        annotation (Line(points={{68,10},{80,10},{80,20}}));
      connect(fixedRotation1.frame_b, force4.frame_resolve)
        annotation (Line(points={{112,-80},{142,-80},{142,-30}}));
      connect(fixed6.frame_b, Revolute8.frame_a)
        annotation (Line(points={{32,-60},{38,-60}}));
      connect(Revolute8.frame_b, Revolute6.frame_a)
        annotation (Line(points={{58,-60},{80,-60},{80,-50}}));
      connect(fixed6.frame_b, fixedRotation1.frame_a)
        annotation (Line(points={{32,-60},{36,-60},{36,-80},{92,-80}}));
      connect(force3.frame_a, fixed7.frame_b) annotation (Line(
          points={{162,50},{171.5,50},{180,50}},
          thickness=0.5));
      connect(fixed8.frame_b, force4.frame_a) annotation (Line(
          points={{180,-20},{170,-20},{160,-20}},
          thickness=0.5));
      connect(Constant3[1:3].y, force3.force[1:3]) annotation (Line(
          points={{150,79},{150,70},{160,70},{160,60.6667}}, color={0,0,127}));
      connect(Constant3[4:6].y, force3.torque[1:3]) annotation (Line(
          points={{150,79},{150,70},{152,70},{152,60.6667}}, color={0,0,127}));
      connect(Constant4[1:3].y, force4.force[1:3]) annotation (Line(
          points={{170,-59},{170,-48},{158,-48},{158,-30.6667}}, color={0,0,127}));
      connect(Constant4[4:6].y, force4.torque[1:3]) annotation (Line(
          points={{170,-59},{170,-48},{150,-48},{150,-30.6667}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1), Diagram(coordinateSystem(
              preserveAspectRatio=true, extent={{-200,-100},{200,100}})));
    end Force2;

    model ForcesAndTorques
      extends Modelica.Icons.Example;
      inner MultiBody.World world(defaultN_to_m=600,
        defaultNm_to_m=120) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,40},{20,60}})));
      Modelica.Blocks.Sources.Constant Constant1[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(
            origin={50,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,0},{-70,20}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}})));
      MultiBody.Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-70},{-68,-50}})));
      MultiBody.Parts.FixedRotation fixedRotation(n={0,0,1}, angle=45) annotation (
          Placement(transformation(extent={{-8,-90},{12,-70}})));
      MultiBody.Forces.ForceAndTorque forceAndTorque1
            annotation (Placement(transformation(extent=
                {{62,40},{42,60}})));
      MultiBody.Forces.ForceAndTorque forceAndTorque2(
        resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve)
        annotation (Placement(transformation(extent={{60,-10},{40,-30}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(
            origin={70,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-52,0},{-32,20}})));
      MultiBody.Joints.Revolute Revolute4(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-60,-70},{-40,-50}})));
      MultiBody.Parts.Fixed fixed2(animation=false, r={1.5,0.25,0}) annotation (Placement(
            transformation(extent={{100,40},{80,60}})));
      MultiBody.Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0}) annotation (
          Placement(transformation(extent={{100,-30},{80,-10}})));
    equation
      connect(forceAndTorque1.frame_b, body1.frame_b)
        annotation (Line(points={{42,50},{20,50}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,40},{-20,50},{0,50}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,-30},{-20,-20},{0,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(forceAndTorque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,-20},{20,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-52,10},{-70,10}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-32,10},{-20,10},{-20,20}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation.frame_b, forceAndTorque2.frame_resolve)
        annotation (Line(points={{12,-80},{42,-80},{42,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-68,-60},{-60,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-40,-60},{-20,-60},{-20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed3.frame_b, fixedRotation.frame_a)
        annotation (Line(points={{-68,-60},{-64,-60},{-64,-80},{-8,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(forceAndTorque1.frame_a, fixed2.frame_b) annotation (Line(
          points={{62,50},{71.5,50},{71.5,50},{80,50}},
          thickness=0.5,
          color={95,95,95}));
      connect(fixed4.frame_b, forceAndTorque2.frame_a) annotation (Line(
          points={{80,-20},{70,-20},{60,-20}},
          thickness=0.5,
          color={95,95,95}));
      connect(Constant1[1:3].y, forceAndTorque1.force[1:3]) annotation (Line(
          points={{50,79},{50,70},{60,70},{60,60.6667}}, color={0,0,127}));
      connect(Constant1[4:6].y, forceAndTorque1.torque[1:3]) annotation (Line(
          points={{50,79},{50,70},{52,70},{52,60.6667}}, color={0,0,127}));
      connect(Constant2[1:3].y, forceAndTorque2.force[1:3]) annotation (Line(
          points={{70,-59},{70,-48},{58,-48},{58,-30.6667}}, color={0,0,127}));
      connect(Constant2[4:6].y, forceAndTorque2.torque[1:3]) annotation (Line(
          points={{70,-59},{70,-48},{50,-48},{50,-30.6667}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end ForcesAndTorques;

    model ForceWithTwoMasses
      extends Modelica.Icons.Example;
      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-100,20},{-80,40}})));
      MultiBody.Joints.Revolute revolute(phi(fixed=true), w(
            fixed=true)) annotation (Placement(transformation(extent={{-40,20},
                {-20,40}})));
      MultiBody.Parts.BodyBox BodyBox1(r={0.7,0,0})
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      MultiBody.Parts.FixedTranslation FixedTranslation1(
        r={0,-0.9,0},
        width=0.01,
        animation=false) annotation (Placement(transformation(
            origin={-60,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Forces.LineForceWithTwoMasses force(
        L_a=0.3,
        L_b=0.3,
        m_a=1,
        m_b=1) annotation (Placement(transformation(extent={{-20,-20},{0,-40}})));
      MultiBody.Parts.FixedTranslation FixedTranslation2(
        width=0.01,
        animation=false,
        r={0,0.1,0}) annotation (Placement(transformation(
            origin={-60,50},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.Translational.Components.Damper damper(d=10)
        annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
    equation
      connect(BodyBox1.frame_a, revolute.frame_b)
        annotation (Line(points={{0,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(force.frame_a, FixedTranslation1.frame_b)
        annotation (Line(points={{-20,-30},{-60,-30},{-60,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(force.frame_b, BodyBox1.frame_b)
        annotation (Line(points={{0,-30},{40,-30},{40,30},{20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, FixedTranslation2.frame_a)
        annotation (Line(points={{-80,30},{-60,30},{-60,40}},
          color={95,95,95},
          thickness=0.5));
      connect(FixedTranslation2.frame_b, revolute.frame_a) annotation (Line(
            points={{-60,60},{-60,70},{-46,70},{-46,30},{-40,30}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, FixedTranslation1.frame_a)
        annotation (Line(points={{-80,30},{-60,30},{-60,0}},
          color={95,95,95},
          thickness=0.5));
      connect(force.flange_a, damper.flange_a) annotation (Line(points={{-16,-41},
              {-16,-54},{-20,-54},{-20,-70}}, color={0,191,0}));
      connect(force.flange_b, damper.flange_b) annotation (Line(points={{-4,-41},
              {-4,-54},{0,-54},{0,-70}}, color={0,191,0}));
      annotation (
        experiment(StopTime=3));
    end ForceWithTwoMasses;

    model ForceWithTwoMasses2
      extends Modelica.Icons.Example;
      parameter Real m=2;
      parameter Real tol=1e-4;
      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-90,0},{-70,20}})));
      MultiBody.Joints.Revolute revolute1(phi(fixed=true), w(
            fixed=true)) annotation (Placement(transformation(extent={{-10,60},{10,80}})));
      MultiBody.Parts.BodyBox bodyBox1(r={0.7,0,0})
        annotation (Placement(transformation(extent={{20,60},{40,80}})));
      MultiBody.Parts.FixedTranslation rod1(
        r={0,-0.9,0},
        width=0.01,
        animation=false) annotation (Placement(transformation(
            origin={-30,40},
            extent={{-10,-10},{10,10}})));
      MultiBody.Joints.Assemblies.JointUPS jointUPS(nAxis_ia=
           {0.7,1.2,0}, animation=true) annotation (Placement(transformation(
              extent={{-2,52},{22,28}})));
      MultiBody.Parts.Body body1(
        r_CM=0.2*jointUPS.eAxis_ia,
        cylinderDiameter=0.05,
        animation=true,
        m=m,
        I_11=0,
        I_22=0,
        I_33=0) annotation (Placement(transformation(extent={{-14,10},{-34,30}})));
      MultiBody.Parts.Body body2(
        r_CM=-0.2*jointUPS.eAxis_ia,
        cylinderDiameter=0.05,
        animation=true,
        m=m,
        I_11=0,
        I_22=0,
        I_33=0) annotation (Placement(transformation(extent={{32,10},{52,30}})));
      MultiBody.Parts.FixedTranslation rod2(
        r={0,0.3,0},
        width=0.01,
        animation=false) annotation (Placement(transformation(
            origin={-30,70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.Translational.Components.Damper damper1(d=3)
        annotation (Placement(transformation(extent={{0,14},{20,-6}})));
      MultiBody.Joints.Revolute revolute2(phi(fixed=true), w(
            fixed=true)) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      MultiBody.Parts.BodyBox bodyBox2(r={0.7,0,0})
        annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
      MultiBody.Parts.FixedTranslation rod3(
        width=0.01,
        r={0,-0.9,0.3},
        animation=false) annotation (Placement(transformation(
            origin={-30,-60},
            extent={{-10,-10},{10,10}})));
      MultiBody.Parts.FixedTranslation rod4(
        width=0.01,
        r={0,0.3,0.3},
        animation=false) annotation (Placement(transformation(
            origin={-30,-30},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.Translational.Components.Damper damper2(d=3)
        annotation (Placement(transformation(extent={{0,-80},{20,-100}})));
      MultiBody.Forces.LineForceWithTwoMasses
        lineForceWithTwoMasses(
        L_a=0.2,
        L_b=0.2,
        cylinderLength_a=0.2,
        cylinderLength_b=1.2,
        massDiameterFaction=2.2,
        m_a=m,
        m_b=m) annotation (Placement(transformation(extent={{0,-50},{20,-70}})));
    equation
      assert(revolute1.phi - revolute2.phi < tol,
        "Angles of joints must be equal");
      assert(revolute1.w - revolute2.w < tol, "Angles of joints must be equal");
      connect(jointUPS.bearing, damper1.flange_a) annotation (Line(points={{5.2,28},{5.2,16},{0,16},{0,4}},
                                           color={0,127,0}));
      connect(jointUPS.axis, damper1.flange_b) annotation (Line(points={{14.8,28},{14.8,16},{20,16},{20,4}},
                                        color={0,127,0}));
      connect(jointUPS.frame_ib, body2.frame_a) annotation (Line(
          points={{19.6,28},{19.6,20},{32,20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, rod2.frame_a) annotation (Line(
          points={{-70,10},{-50,10},{-50,70},{-40,70}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, rod1.frame_a) annotation (Line(
          points={{-70,10},{-50,10},{-50,40},{-40,40}},
          color={95,95,95},
          thickness=0.5));
      connect(rod2.frame_b, revolute1.frame_a) annotation (Line(
          points={{-20,70},{-10,70}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute1.frame_b, bodyBox1.frame_a) annotation (Line(
          points={{10,70},{20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox1.frame_b, jointUPS.frame_b) annotation (Line(
          points={{40,70},{50,70},{50,40},{22,40}},
          color={95,95,95},
          thickness=0.5));
      connect(body1.frame_a, jointUPS.frame_ia) annotation (Line(
          points={{-14,20},{0.4,20},{0.4,28}},
          color={95,95,95},
          thickness=0.5));
      connect(rod1.frame_b, jointUPS.frame_a) annotation (Line(
          points={{-20,40},{-2,40}},
          color={95,95,95},
          thickness=0.5));
      connect(rod4.frame_b, revolute2.frame_a) annotation (Line(
          points={{-20,-30},{-10,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute2.frame_b, bodyBox2.frame_a) annotation (Line(
          points={{10,-30},{20,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, rod4.frame_a) annotation (Line(
          points={{-70,10},{-50,10},{-50,-30},{-40,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(rod3.frame_a, rod4.frame_a) annotation (Line(
          points={{-40,-60},{-50,-60},{-50,-30},{-40,-30}},
          thickness=0.5,
          color={95,95,95}));
      connect(lineForceWithTwoMasses.frame_a, rod3.frame_b) annotation (Line(
          points={{0,-60},{-20,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(lineForceWithTwoMasses.frame_b, bodyBox2.frame_b) annotation (
          Line(
          points={{20,-60},{50,-60},{50,-30},{40,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(lineForceWithTwoMasses.flange_b, damper2.flange_b) annotation (
          Line(points={{16,-71},{20,-71},{20,-90}}, color={0,127,0}));
      connect(lineForceWithTwoMasses.flange_a, damper2.flange_a)
        annotation (Line(points={{4,-71},{0,-71},{0,-90}},   color={0,127,0}));
      annotation (experiment(StopTime=3));
    end ForceWithTwoMasses2;

    model FrameForces
      extends Modelica.Icons.Example;
      inner MultiBody.World world(defaultN_to_m=600)
           annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      MultiBody.Joints.Revolute Revolute1(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-40,40},{-20,60}})));
      MultiBody.Parts.BodyCylinder BodyCylinder1(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,40},{20,60}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,500,0}) annotation (
          Placement(transformation(extent={{100,40},{80,60}})));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-80,40},{-60,60}})));
      MultiBody.Forces.WorldForce frameForce1(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{60,40},{40,60}})));
      MultiBody.Joints.Revolute Revolute2(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-40,0},{-20,20}})));
      MultiBody.Parts.BodyCylinder BodyCylinder2(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,0},{20,20}})));
      MultiBody.Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-80,0},{-60,20}})));
      MultiBody.Forces.WorldForce frameForce2(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{60,0},{40,20}})));
      MultiBody.Parts.FixedRotation FixedRotation1(n={0,0,1}, angle=45) annotation (
          Placement(transformation(extent={{-40,-40},{-20,-20}})));
    equation
      connect(BodyCylinder1.frame_a, Revolute1.frame_b)
        annotation (Line(points={{0,50},{-20,50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-60,50},{-40,50}},
          color={95,95,95},
          thickness=0.5));
      connect(frameForce1.frame_b, BodyCylinder1.frame_b)
        annotation (Line(points={{40,50},{20,50}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, frameForce1.force)
        annotation (Line(points={{79,50},{62,50}}, color={0,0,127}));
      connect(BodyCylinder2.frame_a, Revolute2.frame_b)
        annotation (Line(points={{0,10},{-20,10}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed2.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-60,10},{-40,10}},
          color={95,95,95},
          thickness=0.5));
      connect(frameForce2.frame_b, BodyCylinder2.frame_b)
        annotation (Line(points={{40,10},{20,10}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed2.frame_b, FixedRotation1.frame_a)
        annotation (Line(points={{-60,10},{-50,10},{-50,-30},{-40,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(FixedRotation1.frame_b, frameForce2.frame_resolve)
        annotation (Line(points={{-20,-30},{50,-30},{50,0}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, frameForce2.force) annotation (Line(points={{79,50},
              {72,50},{72,10},{62,10}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end FrameForces;

    model FrameForces2
      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;
      inner MultiBody.World world annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
      MultiBody.Joints.Revolute Revolute1(
        phi(fixed=true),
        w(fixed=true),
        useAxisFlange=false) annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      MultiBody.Parts.BodyCylinder BodyCylinder1(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,60},{20,80}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,500,0}) annotation (
          Placement(transformation(extent={{100,60},{80,80}})));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-80,60},{-60,80}})));
      MultiBody.Forces.WorldForce frameForce1(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{60,60},{40,80}})));
      MultiBody.Joints.Revolute Revolute2(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-40,20},{-20,40}})));
      MultiBody.Parts.BodyCylinder BodyCylinder2(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,20},{20,40}})));
      MultiBody.Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-80,20},{-60,40}})));
      MultiBody.Forces.WorldForce frameForce2(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{60,20},{40,40}})));
      MultiBody.Joints.Revolute Revolute3(
        phi(fixed=true),
        w(fixed=true),
        useAxisFlange=false) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
      MultiBody.Parts.BodyCylinder BodyCylinder3(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,-30},{20,-10}})));
      Modelica.Blocks.Sources.Constant Constant2[3](k={0,500,0}) annotation (
          Placement(transformation(extent={{100,-30},{80,-10}})));
      MultiBody.Forces.WorldForce frameForce3(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.world)
        annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
      MultiBody.Joints.Revolute Revolute4(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-40,-70},{-20,-50}})));
      MultiBody.Parts.BodyCylinder BodyCylinder4(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,-70},{20,-50}})));
      MultiBody.Forces.WorldForce frameForce4(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    equation
      assert(Revolute1.phi - Revolute2.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute1.w - Revolute2.w < tol, "Angles of joints must be equal");
      assert(Revolute3.phi - Revolute4.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute3.w - Revolute4.w < tol, "Angles of joints must be equal");
      connect(BodyCylinder1.frame_a, Revolute1.frame_b)
        annotation (Line(points={{0,70},{-20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-60,70},{-40,70}},
          color={95,95,95},
          thickness=0.5));
      connect(frameForce1.frame_b, BodyCylinder1.frame_b)
        annotation (Line(points={{40,70},{20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, frameForce1.force)
        annotation (Line(points={{79,70},{62,70}}, color={0,0,127}));
      connect(BodyCylinder2.frame_a, Revolute2.frame_b)
        annotation (Line(points={{0,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed2.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-60,30},{-40,30}},
          color={95,95,95},
          thickness=0.5));
      connect(frameForce2.frame_b, BodyCylinder2.frame_b)
        annotation (Line(points={{40,30},{20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, frameForce2.force) annotation (Line(points={{79,70},{70,70},{70,30},{62,30}},
                                        color={0,0,127}));
      connect(BodyCylinder2.frame_b, frameForce2.frame_resolve) annotation (
          Line(
          points={{20,30},{30,30},{30,8},{50,8},{50,20}},
          color={95,95,95},
          thickness=0.5));
      connect(BodyCylinder3.frame_a, Revolute3.frame_b)
        annotation (Line(points={{0,-20},{-20,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(frameForce3.frame_b, BodyCylinder3.frame_b)
        annotation (Line(points={{40,-20},{20,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant2.y, frameForce3.force)
        annotation (Line(points={{79,-20},{62,-20}}, color={0,0,127}));
      connect(BodyCylinder4.frame_a, Revolute4.frame_b)
        annotation (Line(points={{0,-60},{-20,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(frameForce4.frame_b, BodyCylinder4.frame_b)
        annotation (Line(points={{40,-60},{20,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant2.y, frameForce4.force) annotation (Line(points={{79,-20},{70,-20},{70,-60},{62,-60}},
                                           color={0,0,127}));
      connect(world.frame_b, Revolute3.frame_a) annotation (Line(
          points={{-70,-40},{-50,-40},{-50,-20},{-40,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(frameForce4.frame_resolve, world.frame_b) annotation (Line(
          points={{50,-70},{50,-88},{-50,-88},{-50,-40},{-70,-40}},
          color={95,95,95},
          pattern=LinePattern.Dash));
      connect(Revolute4.frame_a, world.frame_b) annotation (Line(
          points={{-40,-60},{-50,-60},{-50,-40},{-70,-40}},
          color={95,95,95},
          thickness=0.5));
      annotation (
        experiment(StopTime=2, Tolerance=1e-006),
        Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
    end FrameForces2;

    model FrameForcesAndTorques
      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;
      inner MultiBody.World world(defaultN_to_m=600,
         defaultNm_to_m=120) annotation (Placement(transformation(extent={{-100,80},
                {-80,100}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,60},{20,80}})));
      Modelica.Blocks.Sources.Constant Constant1[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(extent={{100,60},{80,80}})));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-100,20},{-80,40}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}})));
      MultiBody.Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-98,-70},{-78,-50}})));
      MultiBody.Forces.WorldForceAndTorque frameTorque1(
        resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{60,60},{40,80}})));
      MultiBody.Forces.WorldForceAndTorque frameTorque2(
        resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{60,-10},{40,-30}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(extent={{100,-30},{80,-10}})));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-60,20},{-40,40}})));
      MultiBody.Joints.Revolute Revolute4(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-60,-70},{-40,-50}})));
      MultiBody.Parts.FixedRotation FixedRotation1(angle=45,
          n={0,0,1})
        annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
    equation

      connect(frameTorque1.frame_b, body1.frame_b)
        annotation (Line(points={{40,70},{20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,60},{-20,70},{0,70}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,-30},{-20,-20},{0,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(frameTorque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,-20},{20,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-60,30},{-80,30}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-40,30},{-20,30},{-20,40}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed2.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-78,-60},{-60,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-40,-60},{-20,-60},{-20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1[1:3].y, frameTorque1.force[1:3]) annotation (Line(
          points={{79,70},{72,70},{72,65.3333},{62,65.3333}}, color={0,0,127}));
      connect(Constant1[4:6].y, frameTorque1.torque[1:3]) annotation (Line(
          points={{79,70},{72,70},{72,77.3333},{62,77.3333}}, color={0,0,127}));
      connect(Constant2[1:3].y, frameTorque2.force[1:3]) annotation (Line(
          points={{79,-20},{72,-20},{72,-15.3333},{62,-15.3333}}, color={0,0,127}));
      connect(Constant2[4:6].y, frameTorque2.torque[1:3]) annotation (Line(
          points={{79,-20},{72,-20},{72,-27.3333},{62,-27.3333}}, color={0,0,127}));
      connect(fixed2.frame_b, FixedRotation1.frame_a) annotation (Line(
          points={{-78,-60},{-70,-60},{-70,-80},{0,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(FixedRotation1.frame_b, frameTorque2.frame_resolve) annotation (
          Line(
          points={{20,-80},{50,-80},{50,-30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end FrameForcesAndTorques;

    model FrameForcesAndTorques2
      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;
      inner MultiBody.World world(defaultN_to_m=600,
         defaultNm_to_m=120) annotation (Placement(transformation(extent={{-100,80},
                {-80,100}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,60},{20,80}})));
      Modelica.Blocks.Sources.Constant Constant1[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(extent={{100,60},{80,80}})));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-100,20},{-80,40}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}})));
      MultiBody.Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-98,-70},{-78,-50}})));
      MultiBody.Forces.WorldForceAndTorque frameTorque1(
        resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{60,60},{40,80}})));
      MultiBody.Forces.WorldForceAndTorque frameTorque2(
        resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{60,-10},{40,-30}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(extent={{100,-30},{80,-10}})));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-60,20},{-40,40}})));
      MultiBody.Joints.Revolute Revolute4(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-60,-70},{-40,-50}})));
    equation
      assert(Revolute1.phi - Revolute2.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute1.w - Revolute2.w < tol, "Angles of joints must be equal");
      assert(Revolute3.phi - Revolute4.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute3.w - Revolute4.w < tol, "Angles of joints must be equal");

      connect(frameTorque1.frame_b, body1.frame_b)
        annotation (Line(points={{40,70},{20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,60},{-20,70},{0,70}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,-30},{-20,-20},{0,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(frameTorque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,-20},{20,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-60,30},{-80,30}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-40,30},{-20,30},{-20,40}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed2.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-78,-60},{-60,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-40,-60},{-20,-60},{-20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1[1:3].y, frameTorque1.force[1:3]) annotation (Line(
          points={{79,70},{72,70},{72,65.3333},{62,65.3333}}, color={0,0,127}));
      connect(Constant1[4:6].y, frameTorque1.torque[1:3]) annotation (Line(
          points={{79,70},{72,70},{72,77.3333},{62,77.3333}}, color={0,0,127}));
      connect(Constant2[1:3].y, frameTorque2.force[1:3]) annotation (Line(
          points={{79,-20},{72,-20},{72,-15.3333},{62,-15.3333}}, color={0,0,127}));
      connect(Constant2[4:6].y, frameTorque2.torque[1:3]) annotation (Line(
          points={{79,-20},{72,-20},{72,-27.3333},{62,-27.3333}}, color={0,0,127}));
      connect(body2.frame_b, frameTorque2.frame_resolve) annotation (Line(
          points={{20,-20},{30,-20},{30,-40},{50,-40},{50,-30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=2, Tolerance=1e-6));
    end FrameForcesAndTorques2;

    model FrameForcesAndTorques3
      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;
      inner MultiBody.World world(defaultN_to_m=600,
         defaultNm_to_m=120) annotation (Placement(transformation(extent={{-100,20},
                {-80,40}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,60},{20,80}})));
      Modelica.Blocks.Sources.Constant Constant1[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(extent={{100,60},{80,80}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}})));
      MultiBody.Forces.WorldForceAndTorque frameTorque1(
        resolveInFrame=MultiBody.Types.ResolveInFrameB.world)
        annotation (Placement(transformation(extent={{60,60},{40,80}})));
      MultiBody.Forces.WorldForceAndTorque frameTorque2(
        resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{60,-10},{40,-30}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(extent={{100,-30},{80,-10}})));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-60,20},{-40,40}})));
      MultiBody.Joints.Revolute Revolute4(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-60,-70},{-40,-50}})));
      MultiBody.Parts.FixedTranslation fixedTranslation(r={0,
            0,1}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-70,0})));
    equation
      assert(Revolute1.phi - Revolute2.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute1.w - Revolute2.w < tol, "Angles of joints must be equal");
      assert(Revolute3.phi - Revolute4.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute3.w - Revolute4.w < tol, "Angles of joints must be equal");
      connect(frameTorque1.frame_b, body1.frame_b)
        annotation (Line(points={{40,70},{20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,60},{-20,70},{0,70}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,-30},{-20,-20},{0,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(frameTorque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,-20},{20,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-40,30},{-20,30},{-20,40}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-40,-60},{-20,-60},{-20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1[1:3].y, frameTorque1.force[1:3]) annotation (Line(
          points={{79,70},{72,70},{72,65.3333},{62,65.3333}}, color={0,0,127}));
      connect(Constant1[4:6].y, frameTorque1.torque[1:3]) annotation (Line(
          points={{79,70},{72,70},{72,77.3333},{62,77.3333}}, color={0,0,127}));
      connect(Constant2[1:3].y, frameTorque2.force[1:3]) annotation (Line(
          points={{79,-20},{72,-20},{72,-15.3333},{62,-15.3333}}, color={0,0,127}));
      connect(Constant2[4:6].y, frameTorque2.torque[1:3]) annotation (Line(
          points={{79,-20},{72,-20},{72,-27.3333},{62,-27.3333}}, color={0,0,127}));
      connect(world.frame_b, Revolute3.frame_a) annotation (Line(
          points={{-80,30},{-60,30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_a, world.frame_b) annotation (Line(
          points={{-70,10},{-70,30},{-80,30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_b, Revolute4.frame_a) annotation (Line(
          points={{-70,-10},{-70,-60},{-60,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_a, frameTorque2.frame_resolve) annotation (Line(
          points={{-60,-60},{-70,-60},{-70,-80},{50,-80},{50,-30},{50,-30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=2, Tolerance=1e-6));
    end FrameForcesAndTorques3;

    model FrameTorques
      extends Modelica.Icons.Example;
      inner MultiBody.World world(defaultNm_to_m=120)
           annotation (Placement(transformation(extent={{-100,80},
                {-80,100}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-30,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,80},{20,100}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,100,0}) annotation (
          Placement(transformation(extent={{100,80},{80,100}})));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-80,20},{-60,40}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,0},{20,20}})));
      MultiBody.Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-80,-40},{-60,-20}})));
      MultiBody.Parts.FixedRotation FixedRotation1(n={0,0,1}, angle=45) annotation (
          Placement(transformation(extent={{0,-60},{20,-40}})));
      MultiBody.Forces.WorldTorque frameTorque1(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{60,80},{40,100}})));
      MultiBody.Forces.WorldTorque frameTorque2(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{60,20},{40,0}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={0,100,0}) annotation (
          Placement(transformation(extent={{100,0},{80,20}})));
    equation
      connect(fixed2.frame_b, FixedRotation1.frame_a)
        annotation (Line(points={{-60,-30},{-52,-30},{-52,-50},{0,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(frameTorque1.frame_b, body1.frame_b)
        annotation (Line(points={{40,90},{20,90}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-60,30},{-30,30},{-30,40}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-30,60},{-30,90},{0,90}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed2.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-60,-30},{-30,-30},{-30,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-30,0},{-30,10},{0,10}},
          color={95,95,95},
          thickness=0.5));
      connect(frameTorque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,10},{20,10}},
          color={95,95,95},
          thickness=0.5));
      connect(FixedRotation1.frame_b, frameTorque2.frame_resolve)
        annotation (Line(points={{20,-50},{50,-50},{50,0}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, frameTorque1.torque) annotation (Line(
          points={{79,90},{62,90}}, color={0,0,127}));
      connect(Constant2.y, frameTorque2.torque) annotation (Line(
          points={{79,10},{62,10}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end FrameTorques;

    model FrameTorques2
      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;
      inner MultiBody.World world(defaultNm_to_m=120)
          annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-30,90},
            extent={{-10,-10},{10,10}})));
      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,80},{20,100}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,100,0}) annotation (
          Placement(transformation(extent={{100,80},{80,100}})));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-82,80},{-62,100}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,40},{20,60}})));
      MultiBody.Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-80,40},{-60,60}})));
      MultiBody.Forces.WorldTorque frameTorque1(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{60,80},{40,100}})));
      MultiBody.Forces.WorldTorque frameTorque2(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{60,60},{40,40}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-30,50},
            extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.Constant Constant2[3](k={0,100,0}) annotation (
          Placement(transformation(extent={{100,40},{80,60}})));
      MultiBody.Joints.Revolute Revolute3(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-30,-20},
            extent={{-10,-10},{10,10}})));
      MultiBody.Parts.BodyCylinder body3(r={1,0,0}) annotation (Placement(transformation(
              extent={{-4,-30},{16,-10}})));
      Modelica.Blocks.Sources.Constant Constant3[3](k={0,100,0}) annotation (
          Placement(transformation(extent={{100,-30},{80,-10}})));
      MultiBody.Parts.BodyCylinder body4(r={1,0,0}) annotation (Placement(transformation(
              extent={{-4,-70},{16,-50}})));
      MultiBody.Forces.WorldTorque frameTorque3(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.world)
        annotation (Placement(transformation(extent={{56,-30},{36,-10}})));
      MultiBody.Forces.WorldTorque frameTorque4(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{56,-50},{36,-70}})));
      MultiBody.Joints.Revolute Revolute4(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-30,-60},
            extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.Constant Constant4[3](k={0,100,0}) annotation (
          Placement(transformation(extent={{100,-70},{80,-50}})));
    equation
      assert(Revolute1.phi - Revolute2.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute1.w - Revolute2.w < tol, "Angles of joints must be equal");
      assert(Revolute3.phi - Revolute4.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute3.w - Revolute4.w < tol, "Angles of joints must be equal");
      connect(frameTorque1.frame_b, body1.frame_b)
        annotation (Line(points={{40,90},{20,90}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-62,90},{-40,90}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,90},{0,90}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed2.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-60,50},{-40,50}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,50},{0,50}},
          color={95,95,95},
          thickness=0.5));
      connect(frameTorque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,50},{20,50}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, frameTorque1.torque) annotation (Line(
          points={{79,90},{62,90}}, color={0,0,127}));
      connect(Constant2.y, frameTorque2.torque) annotation (Line(
          points={{79,50},{62,50}}, color={0,0,127}));
      connect(body2.frame_b, frameTorque2.frame_resolve) annotation (Line(
          points={{20,50},{30,50},{30,30},{50,30},{50,40}},
          color={95,95,95},
          thickness=0.5));
      connect(frameTorque3.frame_b, body3.frame_b)
        annotation (Line(points={{36,-20},{16,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_b, body3.frame_a)
        annotation (Line(points={{-20,-20},{-4,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_b, body4.frame_a)
        annotation (Line(points={{-20,-60},{-4,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(frameTorque4.frame_b, body4.frame_b)
        annotation (Line(points={{36,-60},{16,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant3.y, frameTorque3.torque) annotation (Line(
          points={{79,-20},{58,-20}}, color={0,0,127}));
      connect(Constant4.y, frameTorque4.torque) annotation (Line(
          points={{79,-60},{58,-60}}, color={0,0,127}));
      connect(world.frame_b, Revolute3.frame_a) annotation (Line(
          points={{-70,-20},{-40,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, Revolute4.frame_a) annotation (Line(
          points={{-70,-20},{-60,-20},{-60,-60},{-40,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_a, frameTorque4.frame_resolve) annotation (Line(
          points={{-40,-60},{-60,-60},{-60,-80},{46,-80},{46,-70}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end FrameTorques2;

    model LineForceWithMass
      "Example to demonstrate how to construct force elements with masses"

      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;
      SI.Force rod_f_diff[3]=rod1.frame_b.f - rod3.frame_b.f
        "Difference of cut-forces in rod1 and rod3";
      SI.Force body_f_diff[3]=bodyBox1.frame_b.f - bodyBox2.frame_b.f
        "Difference of cut-forces in bodyBox1 and bodyBox2";
      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,60},{-60,80}})));
      MultiBody.Joints.Revolute revolute1(phi(fixed=true), w(
            fixed=true)) annotation (Placement(transformation(extent={{-20,80},
                {0,100}})));
      MultiBody.Parts.BodyBox bodyBox1(r={0.7,0,0})
        annotation (Placement(transformation(extent={{20,80},{40,100}})));
      MultiBody.Parts.FixedTranslation rod1(
        r={0,-0.9,0},
        width=0.01,
        animation=false) annotation (Placement(transformation(
            origin={-40,54},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Joints.Assemblies.JointUPS jointUPS(nAxis_ia=
           {0.7,1.2,0}, animation=true) annotation (Placement(transformation(
              extent={{0,50},{20,30}})));
      MultiBody.Parts.FixedTranslation rod2(
        r={0,0.3,0},
        width=0.01,
        animation=false) annotation (Placement(transformation(
            origin={-40,84},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.Translational.Components.Damper damper1(d=3)
        annotation (Placement(transformation(extent={{0,22},{20,2}})));
      MultiBody.Joints.Revolute revolute2(phi(fixed=true), w(
            fixed=true)) annotation (Placement(transformation(extent={{-20,-30},
                {0,-10}})));
      MultiBody.Parts.BodyBox bodyBox2(r={0.7,0,0})
        annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
      MultiBody.Parts.FixedTranslation rod3(
        width=0.01,
        animation=false,
        r={0,-0.9,0.3}) annotation (Placement(transformation(
            origin={-40,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.FixedTranslation rod4(
        width=0.01,
        r={0,0.3,0.3},
        animation=false) annotation (Placement(transformation(
            origin={-40,-20},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.Translational.Components.Damper damper2(d=3)
        annotation (Placement(transformation(extent={{4,-80},{24,-100}})));
      MultiBody.Forces.LineForceWithMass lineForceWithMass(m=
           0) annotation (Placement(transformation(extent={{4,-50},{24,-70}})));
    equation
      assert(rod_f_diff[1] < tol and rod_f_diff[2] < tol and rod_f_diff[3] <
        tol, "Difference in rod positions must be less then tolerance");
      assert(body_f_diff[1] < tol and body_f_diff[2] < tol and body_f_diff[3]
         < tol, "Difference in rod positions must be less then tolerance");

      connect(jointUPS.bearing, damper1.flange_a) annotation (Line(points={{6,30},{6,20},{0,20},{0,12}},
                                         color={0,127,0}));
      connect(jointUPS.axis, damper1.flange_b) annotation (Line(points={{14,30},{14,20},{20,20},{20,12}},
                                        color={0,127,0}));
      connect(world.frame_b, rod2.frame_a) annotation (Line(
          points={{-60,70},{-40,70},{-40,74}},
          thickness=0.5,
          color={95,95,95}));
      connect(world.frame_b, rod1.frame_a) annotation (Line(
          points={{-60,70},{-40,70},{-40,64}},
          thickness=0.5,
          color={95,95,95}));
      connect(rod2.frame_b, revolute1.frame_a) annotation (Line(
          points={{-40,94},{-40,98},{-30,98},{-30,90},{-20,90}},
          thickness=0.5,
          color={95,95,95}));
      connect(revolute1.frame_b, bodyBox1.frame_a) annotation (Line(
          points={{0,90},{12,90},{20,90}},
          thickness=0.5,
          color={95,95,95}));
      connect(bodyBox1.frame_b, jointUPS.frame_b) annotation (Line(
          points={{40,90},{50,90},{50,40},{20,40}},
          thickness=0.5,
          color={95,95,95}));
      connect(rod1.frame_b, jointUPS.frame_a) annotation (Line(
          points={{-40,44},{-40,40},{0,40}},
          thickness=0.5,
          color={95,95,95}));
      connect(rod4.frame_b, revolute2.frame_a) annotation (Line(
          points={{-40,-10},{-40,-6},{-30,-6},{-30,-20},{-20,-20}},
          thickness=0.5,
          color={95,95,95}));
      connect(revolute2.frame_b, bodyBox2.frame_a) annotation (Line(
          points={{0,-20},{20,-20}},
          thickness=0.5,
          color={95,95,95}));
      connect(world.frame_b, rod4.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-36},{-40,-36},{-40,-30}},
          thickness=0.5,
          color={95,95,95}));
      connect(rod3.frame_a, rod4.frame_a) annotation (Line(
          points={{-40,-40},{-40,-30}},
          thickness=0.5,
          color={95,95,95}));
      connect(damper2.flange_a, lineForceWithMass.flange_a) annotation (Line(
          points={{4,-90},{4,-70},{8,-70}}, color={0,127,0}));
      connect(damper2.flange_b, lineForceWithMass.flange_b) annotation (Line(
          points={{24,-90},{24,-70},{20,-70}}, color={0,127,0}));
      connect(rod3.frame_b, lineForceWithMass.frame_a) annotation (Line(
          points={{-40,-60},{4,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(lineForceWithMass.frame_b, bodyBox2.frame_b) annotation (Line(
          points={{24,-60},{50,-60},{50,-20},{40,-20}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=3), Documentation(info="<html>
<p>
With this example it is demonstrated how to use the MultiBody.Joints.Assemblies.JointUPS
joint to build up a force element with masses and inertias (note, MultiBody.Forces.LineForceWithMass
is a default line force element with a point mass to approximate the mass properties of the
component):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ForceWithMasses.png\"
alt=\"model Examples.Elementary.ForceWithMasses\">
</div>

<p>
A JointUPS consists of
a universal, prismatic and spherical joint aggregation that approximates
a real force component, such as a hydraulic cylinder. At frame frame_ia at the
universal joint and at frame frame_ib at the spherical joint, bodies can be
attached describing the mass properties of the component. Between the 1-dimensional
mechanical translational flanges \"axis\" and \"bearing\" a one-dimensional
force law can be attached, e.g., from the Modelica.Mechanics.Translational or
the HyLib package (= library of hydraulic components). In this example, just
a linear damper is connected here.
</p>
</html>"));
    end LineForceWithMass;

    model LineForceWithTwoMasses
      "Example to demonstrate how to construct force elements with masses"

      extends Modelica.Icons.Example;
      parameter SI.Mass m=1 "Mass of point masses";
      SI.Force rod_f_diff[3]=rod1.frame_b.f - rod3.frame_b.f
        "Difference of cut-forces in rod1 and rod3";
      SI.Force body_f_diff[3]=bodyBox1.frame_b.f - bodyBox2.frame_b.f
        "Difference of cut-forces in bodyBox1 and bodyBox2";
      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,60},{-60,80}})));
      MultiBody.Joints.Revolute revolute1(phi(fixed=true), w(
            fixed=true)) annotation (Placement(transformation(extent={{-20,80},
                {0,100}})));
      MultiBody.Parts.BodyBox bodyBox1(r={0.7,0,0})
        annotation (Placement(transformation(extent={{20,80},{40,100}})));
      MultiBody.Parts.FixedTranslation rod1(
        r={0,-0.9,0},
        width=0.01,
        animation=false) annotation (Placement(transformation(
            origin={-40,54},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Joints.Assemblies.JointUPS jointUPS(nAxis_ia=
           {0.7,1.2,0}, animation=true) annotation (Placement(transformation(
              extent={{0,50},{20,30}})));
      MultiBody.Parts.Body body1(
        r_CM=0.2*jointUPS.eAxis_ia,
        cylinderDiameter=0.05,
        animation=true,
        m=m,
        I_11=0,
        I_22=0,
        I_33=0) annotation (Placement(transformation(extent={{-14,14},{-34,34}})));
      MultiBody.Parts.Body body2(
        r_CM=-0.2*jointUPS.eAxis_ia,
        cylinderDiameter=0.05,
        animation=true,
        m=m,
        I_11=0,
        I_22=0,
        I_33=0) annotation (Placement(transformation(extent={{32,14},{52,34}})));
      MultiBody.Parts.FixedTranslation rod2(
        r={0,0.3,0},
        width=0.01,
        animation=false) annotation (Placement(transformation(
            origin={-40,84},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.Translational.Components.Damper damper1(d=3)
        annotation (Placement(transformation(extent={{0,24},{20,4}})));
      MultiBody.Joints.Revolute revolute2(phi(fixed=true), w(
            fixed=true)) annotation (Placement(transformation(extent={{-20,-30},
                {0,-10}})));
      MultiBody.Parts.BodyBox bodyBox2(r={0.7,0,0})
        annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
      MultiBody.Parts.FixedTranslation rod3(
        width=0.01,
        r={0,-0.9,0.3},
        animation=false) annotation (Placement(transformation(
            origin={-40,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.FixedTranslation rod4(
        width=0.01,
        r={0,0.3,0.3},
        animation=false) annotation (Placement(transformation(
            origin={-40,-20},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.Translational.Components.Damper damper2(d=3)
        annotation (Placement(transformation(extent={{0,-80},{20,-100}})));
      MultiBody.Forces.LineForceWithTwoMasses
        lineForceWithTwoMasses(
        L_a=0.2,
        L_b=0.2,
        cylinderLength_a=0.2,
        cylinderLength_b=1.2,
        massDiameterFaction=2.2,
        m_a=m,
        m_b=m) annotation (Placement(transformation(extent={{0,-54},{20,-74}})));
    equation
      connect(jointUPS.bearing, damper1.flange_a) annotation (Line(points={{6,
              30},{6,20},{0,20},{0,14}}, color={0,127,0}));
      connect(jointUPS.axis, damper1.flange_b) annotation (Line(points={{14,30},
              {14,20},{20,20},{20,14}}, color={0,127,0}));
      connect(jointUPS.frame_ib, body2.frame_a) annotation (Line(
          points={{18,30},{18,24},{32,24}},
          thickness=0.5));
      connect(world.frame_b, rod2.frame_a) annotation (Line(
          points={{-60,70},{-40,70},{-40,74}},
          thickness=0.5,
          color={95,95,95}));
      connect(world.frame_b, rod1.frame_a) annotation (Line(
          points={{-60,70},{-40,70},{-40,64}},
          thickness=0.5,
          color={95,95,95}));
      connect(rod2.frame_b, revolute1.frame_a) annotation (Line(
          points={{-40,94},{-40,98},{-30,98},{-30,90},{-20,90}},
          thickness=0.5,
          color={95,95,95}));
      connect(revolute1.frame_b, bodyBox1.frame_a) annotation (Line(
          points={{0,90},{12,90},{20,90}},
          thickness=0.5,
          color={95,95,95}));
      connect(bodyBox1.frame_b, jointUPS.frame_b) annotation (Line(
          points={{40,90},{50,90},{50,40},{20,40}},
          thickness=0.5,
          color={95,95,95}));
      connect(body1.frame_a, jointUPS.frame_ia) annotation (Line(
          points={{-14,24},{2,24},{2,30}},
          thickness=0.5));
      connect(rod1.frame_b, jointUPS.frame_a) annotation (Line(
          points={{-40,44},{-40,40},{0,40}},
          thickness=0.5,
          color={95,95,95}));
      connect(rod4.frame_b, revolute2.frame_a) annotation (Line(
          points={{-40,-10},{-40,-6},{-30,-6},{-30,-20},{-20,-20}},
          thickness=0.5,
          color={95,95,95}));
      connect(revolute2.frame_b, bodyBox2.frame_a) annotation (Line(
          points={{0,-20},{20,-20}},
          thickness=0.5,
          color={95,95,95}));
      connect(world.frame_b, rod4.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-36},{-40,-36},{-40,-30}},
          thickness=0.5,
          color={95,95,95}));
      connect(rod3.frame_a, rod4.frame_a) annotation (Line(
          points={{-40,-40},{-40,-30}},
          thickness=0.5,
          color={95,95,95}));
      connect(lineForceWithTwoMasses.frame_a, rod3.frame_b) annotation (Line(
          points={{0,-64},{-40,-64},{-40,-60}},
          thickness=0.5,
          color={95,95,95}));
      connect(lineForceWithTwoMasses.frame_b, bodyBox2.frame_b) annotation (
          Line(
          points={{20,-64},{50,-64},{50,-20},{40,-20}},
          thickness=0.5,
          color={95,95,95}));
      connect(lineForceWithTwoMasses.flange_b, damper2.flange_b) annotation (
          Line(points={{16,-75},{20,-75},{20,-90}}, color={0,127,0}));
      connect(lineForceWithTwoMasses.flange_a, damper2.flange_a)
        annotation (Line(points={{4,-75},{0,-75},{0,-90}}, color={0,127,0}));
      annotation (experiment(StopTime=3), Documentation(info="<html>
<p>
With this example it is demonstrated how to use the MultiBody.Joints.Assemblies.JointUPS
joint to build up a force element with masses and inertias (note, MultiBody.Forces.LineForceWithMass
is a default line force element with a point mass to approximate the mass properties of the
component):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ForceWithMasses.png\"
alt=\"model Examples.Elementary.ForceWithMasses\">
</div>

<p>
A JointUPS consists of
a universal, prismatic and spherical joint aggregation that approximates
a real force component, such as a hydraulic cylinder. At frame frame_ia at the
universal joint and at frame frame_ib at the spherical joint, bodies can be
attached describing the mass properties of the component. Between the 1-dimensional
mechanical translational flanges \"axis\" and \"bearing\" a one-dimensional
force law can be attached, e.g., from the Modelica.Mechanics.Translational or
the HyLib package (= library of hydraulic components). In this example, just
a linear damper is connected here.
</p>
</html>"));
    end LineForceWithTwoMasses;

    model Torque
      extends Modelica.Icons.Example;
      inner MultiBody.World world(defaultNm_to_m=120)
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,40},{20,60}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={-100,100,0}) annotation (
         Placement(transformation(
            origin={50,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-100,0},{-80,20}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}})));
      MultiBody.Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-98,-70},{-78,-50}})));
      MultiBody.Parts.FixedRotation fixedRotation(n={0,0,1}, angle=45) annotation (
          Placement(transformation(extent={{-8,-90},{12,-70}})));
      MultiBody.Forces.Torque torque1(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_b)
        annotation (Placement(transformation(extent={{62,40},{42,60}})));
      MultiBody.Forces.Torque torque2(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve)
        annotation (Placement(transformation(extent={{60,-10},{40,-30}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={-100,100,0}) annotation (
         Placement(transformation(
            origin={70,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-52,0},{-32,20}})));
      MultiBody.Joints.Revolute Revolute4(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-60,-70},{-40,-50}})));
      MultiBody.Parts.Fixed fixed2(animation=false, r={1.5,0.25,0}) annotation (Placement(
            transformation(extent={{100,40},{80,60}})));
      MultiBody.Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0}) annotation (
          Placement(transformation(extent={{100,-30},{80,-10}})));
    equation
      connect(torque1.frame_b, body1.frame_b)
        annotation (Line(points={{42,50},{20,50}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,40},{-20,50},{0,50}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,-30},{-20,-20},{0,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(torque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,-20},{20,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-52,10},{-80,10}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-32,10},{-20,10},{-20,20}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation.frame_b, torque2.frame_resolve)
        annotation (Line(points={{12,-80},{46,-80},{46,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-78,-60},{-60,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-40,-60},{-20,-60},{-20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed3.frame_b, fixedRotation.frame_a)
        annotation (Line(points={{-78,-60},{-70,-60},{-70,-80},{-8,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, torque1.torque) annotation (Line(points={{50,79},{50,
              72},{58,72},{58,62}}, color={0,0,255}));
      connect(Constant2.y, torque2.torque) annotation (Line(points={{70,-59},{
              70,-42},{56,-42},{56,-32}}, color={0,0,255}));
      connect(torque1.frame_a, fixed2.frame_b) annotation (Line(
          points={{62,50},{80,50}},
          thickness=0.5));
      connect(fixed4.frame_b, torque2.frame_a) annotation (Line(
          points={{80,-20},{60,-20}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Torque;

    model Torque2
      extends Modelica.Icons.Example;
      inner MultiBody.World world(defaultNm_to_m=120)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,40},{20,60}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={-100,100,0}) annotation (
         Placement(transformation(
            origin={50,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,0},{-70,20}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}})));
      MultiBody.Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-70},{-68,-50}})));
      MultiBody.Parts.FixedRotation fixedRotation(n={0,0,1}, angle=45) annotation (
          Placement(transformation(extent={{-8,-90},{12,-70}})));
      MultiBody.Forces.Torque torque1(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_b)
        annotation (Placement(transformation(extent={{62,40},{42,60}})));
      MultiBody.Forces.Torque torque2(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve)
        annotation (Placement(transformation(extent={{60,-10},{40,-30}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={-100,100,0}) annotation (
         Placement(transformation(
            origin={70,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-52,0},{-32,20}})));
      MultiBody.Joints.Revolute Revolute4(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-62,-70},{-42,-50}})));
      MultiBody.Parts.Fixed fixed2(animation=false, r={1.5,0.25,0}) annotation (Placement(
            transformation(extent={{100,40},{80,60}})));
      MultiBody.Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0}) annotation (
          Placement(transformation(extent={{100,-30},{80,-10}})));
      MultiBody.Joints.Revolute Revolute5(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,-160},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body3(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-150},{20,-130}})));
      Modelica.Blocks.Sources.Constant Constant3[6](k={0,0,0,-100,100,0})
        annotation (Placement(transformation(
            origin={50,-100},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      MultiBody.Parts.Fixed fixed5(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,-190},{-70,-170}})));
      MultiBody.Parts.BodyCylinder body4(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-220},{20,-200}})));
      MultiBody.Parts.Fixed fixed6(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-260},{-68,-240}})));
      MultiBody.Parts.FixedRotation fixedRotation1(n={0,0,1}, angle=45) annotation (
          Placement(transformation(extent={{-8,-280},{12,-260}})));
      MultiBody.Forces.ForceAndTorque torque3
        annotation (Placement(transformation(extent={{62,-150},{42,-130}})));
      MultiBody.Forces.ForceAndTorque torque4(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve)
        annotation (Placement(transformation(extent={{60,-200},{40,-220}})));
      MultiBody.Joints.Revolute Revolute6(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-20,-229},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant4[6](k={0,0,0,-100,100,0})
        annotation (Placement(transformation(
            origin={70,-260},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Joints.Revolute Revolute7(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-52,-190},{-32,-170}})));
      MultiBody.Joints.Revolute Revolute8(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-62,-260},{-42,-240}})));
      MultiBody.Parts.Fixed fixed7(animation=false, r={1.5,0.25,0}) annotation (Placement(
            transformation(extent={{100,-150},{80,-130}})));
      MultiBody.Parts.Fixed fixed8(animation=false, r={1.5,-0.25,0}) annotation (
          Placement(transformation(extent={{100,-220},{80,-200}})));
    equation
      connect(torque1.frame_b, body1.frame_b)
        annotation (Line(points={{42,50},{20,50}}));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,40},{-20,50},{0,50}}));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,-30},{-20,-20},{0,-20}}));
      connect(torque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,-20},{20,-20}}));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-52,10},{-70,10}}));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-32,10},{-20,10},{-20,20}}));
      connect(fixedRotation.frame_b, torque2.frame_resolve)
        annotation (Line(points={{12,-80},{46,-80},{46,-30}}));
      connect(fixed3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-68,-60},{-62,-60}}));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-42,-60},{-20,-60},{-20,-50}}));
      connect(fixed3.frame_b, fixedRotation.frame_a)
        annotation (Line(points={{-68,-60},{-64,-60},{-64,-80},{-8,-80}}));
      connect(Constant1.y, torque1.torque) annotation (Line(points={{50,79},{50,
              72},{58,72},{58,62}}, color={0,0,255}));
      connect(Constant2.y, torque2.torque) annotation (Line(points={{70,-59},{
              70,-42},{56,-42},{56,-32}}, color={0,0,255}));
      connect(torque1.frame_a, fixed2.frame_b) annotation (Line(
          points={{62,50},{80,50}},
          thickness=0.5));
      connect(fixed4.frame_b, torque2.frame_a) annotation (Line(
          points={{80,-20},{60,-20}},
          thickness=0.5));
      connect(torque3.frame_b, body3.frame_b)
        annotation (Line(points={{42,-140},{20,-140}}));
      connect(Revolute5.frame_b, body3.frame_a)
        annotation (Line(points={{-20,-150},{-20,-140},{0,-140}}));
      connect(Revolute6.frame_b, body4.frame_a)
        annotation (Line(points={{-20,-219},{-20,-210},{0,-210}}));
      connect(torque4.frame_b, body4.frame_b)
        annotation (Line(points={{40,-210},{20,-210}}));
      connect(Revolute7.frame_a, fixed5.frame_b)
        annotation (Line(points={{-52,-180},{-70,-180}}));
      connect(Revolute7.frame_b, Revolute5.frame_a)
        annotation (Line(points={{-32,-180},{-20,-180},{-20,-170}}));
      connect(fixedRotation1.frame_b, torque4.frame_resolve)
        annotation (Line(points={{12,-270},{42,-270},{42,-220}}));
      connect(fixed6.frame_b, Revolute8.frame_a)
        annotation (Line(points={{-68,-250},{-62,-250}}));
      connect(Revolute8.frame_b, Revolute6.frame_a)
        annotation (Line(points={{-42,-250},{-20,-250},{-20,-239}}));
      connect(fixed6.frame_b, fixedRotation1.frame_a)
        annotation (Line(points={{-68,-250},{-64,-250},{-64,-270},{-8,-270}}));
      connect(torque3.frame_a, fixed7.frame_b) annotation (Line(
          points={{62,-140},{80,-140}},
          thickness=0.5));
      connect(fixed8.frame_b, torque4.frame_a) annotation (Line(
          points={{80,-210},{60,-210}},
          thickness=0.5));
      connect(Constant3[1:3].y, torque3.force) annotation (Line(
          points={{50,-111},{56,-111},{56,-120},{60,-120},{60,-128}}, color={0,0,127}));
      connect(Constant3[4:6].y, torque3.torque) annotation (Line(
          points={{50,-111},{51,-111},{51,-128},{52,-128}}, color={0,0,127}));
      connect(Constant4[1:3].y, torque4.force) annotation (Line(
          points={{70,-249},{64,-249},{64,-243},{58,-243},{58,-222}}, color={0,0,127}));
      connect(Constant4[4:6].y, torque4.torque) annotation (Line(
          points={{70,-249},{70,-240},{52,-240},{52,-222},{50,-222}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-300},{100,100}})), experiment(StopTime=1.1));
    end Torque2;

    model Torque3
      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;
      inner MultiBody.World world(defaultNm_to_m=120)
          annotation (Placement(transformation(extent={{10,-32},{30,-12}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-120,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{-100,40},{-80,60}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={-100,100,0}) annotation (
         Placement(transformation(
            origin={-50,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-190,0},{-170,20}})));
      MultiBody.Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{-100,-30},{-80,-10}})));
      MultiBody.Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-188,-70},{-168,-50}})));
      MultiBody.Forces.Torque torque1(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_b)
        annotation (Placement(transformation(extent={{-38,40},{-58,60}})));
      MultiBody.Forces.Torque torque2(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve)
        annotation (Placement(transformation(extent={{-40,-10},{-60,-30}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-120,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={-100,100,0}) annotation (
         Placement(transformation(
            origin={-30,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-160,0},{-140,20}})));
      MultiBody.Joints.Revolute Revolute4(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-160,-70},{-140,-50}})));
      MultiBody.Parts.Fixed fixed2(animation=false, r={1.5,0.25,0}) annotation (Placement(
            transformation(extent={{0,40},{-20,60}})));
      MultiBody.Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0}) annotation (
          Placement(transformation(extent={{0,-30},{-20,-10}})));
      MultiBody.Joints.Revolute Revolute5(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={80,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder body3(r={1,0,0}) annotation (Placement(transformation(
              extent={{100,40},{120,60}})));
      Modelica.Blocks.Sources.Constant Constant3[6](k={0,0,0,-100,100,0})
        annotation (Placement(transformation(
            origin={150,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      MultiBody.Parts.BodyCylinder body4(r={1,0,0}) annotation (Placement(transformation(
              extent={{100,-30},{120,-10}})));
      MultiBody.Forces.ForceAndTorque torque3(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.world)
        annotation (Placement(transformation(extent={{160,40},{140,60}})));
      MultiBody.Forces.ForceAndTorque torque4(
          resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve)
        annotation (Placement(transformation(extent={{160,-10},{140,-30}})));
      MultiBody.Joints.Revolute Revolute6(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={80,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant4[6](k={0,0,0,-100,100,0})
        annotation (Placement(transformation(
            origin={170,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Joints.Revolute Revolute7(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{40,0},{60,20}})));
      MultiBody.Joints.Revolute Revolute8(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{40,-70},{60,-50}})));
      MultiBody.Parts.Fixed fixed7(animation=false, r={1.5,0.25,0}) annotation (Placement(
            transformation(extent={{200,40},{180,60}})));
      MultiBody.Parts.Fixed fixed8(animation=false, r={1.5,-0.25,0}) annotation (
          Placement(transformation(extent={{200,-30},{180,-10}})));
    equation
      assert(Revolute1.phi - Revolute2.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute1.w - Revolute2.w < tol, "Angles of joints must be equal");
      assert(Revolute3.phi - Revolute4.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute3.w - Revolute4.w < tol, "Angles of joints must be equal");

      assert(Revolute5.phi - Revolute6.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute5.w - Revolute6.w < tol, "Angles of joints must be equal");
      assert(Revolute7.phi - Revolute8.phi < tol,
        "Angles of joints must be equal");
      assert(Revolute7.w - Revolute8.w < tol, "Angles of joints must be equal");
      connect(torque1.frame_b, body1.frame_b)
        annotation (Line(points={{-58,50},{-80,50}}));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-120,40},{-120,50},{-100,50}}));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-120,-30},{-120,-20},{-100,-20}}));
      connect(torque2.frame_b, body2.frame_b)
        annotation (Line(points={{-60,-20},{-80,-20}}));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-160,10},{-170,10}}));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-140,10},{-120,10},{-120,20}}));
      connect(fixed3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-168,-60},{-160,-60}}));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-140,-60},{-120,-60},{-120,-50}}));
      connect(Constant1.y, torque1.torque) annotation (Line(points={{-50,79},{-50,
              72},{-42,72},{-42,62}}, color={0,0,255}));
      connect(Constant2.y, torque2.torque) annotation (Line(points={{-30,-59},{
              -30,-42},{-44,-42},{-44,-32}}, color={0,0,255}));
      connect(torque1.frame_a, fixed2.frame_b) annotation (Line(
          points={{-38,50},{-20,50}},
          thickness=0.5));
      connect(fixed4.frame_b, torque2.frame_a) annotation (Line(
          points={{-20,-20},{-40,-20}},
          thickness=0.5));
      connect(torque3.frame_b, body3.frame_b)
        annotation (Line(points={{140,50},{120,50}}));
      connect(Revolute5.frame_b, body3.frame_a)
        annotation (Line(points={{80,40},{80,50},{100,50}}));
      connect(Revolute6.frame_b, body4.frame_a)
        annotation (Line(points={{80,-30},{80,-20},{100,-20}}));
      connect(torque4.frame_b, body4.frame_b)
        annotation (Line(points={{140,-20},{120,-20}}));
      connect(Revolute7.frame_b, Revolute5.frame_a)
        annotation (Line(points={{60,10},{80,10},{80,20}}));
      connect(Revolute8.frame_b, Revolute6.frame_a)
        annotation (Line(points={{60,-60},{80,-60},{80,-50}}));
      connect(torque3.frame_a, fixed7.frame_b) annotation (Line(
          points={{160,50},{180,50}},
          thickness=0.5));
      connect(fixed8.frame_b, torque4.frame_a) annotation (Line(
          points={{180,-20},{160,-20}},
          thickness=0.5));
      connect(Constant3[1:3].y, torque3.force[1:3]) annotation (Line(
          points={{150,79},{150,70},{158,70},{158,60.6667}}, color={0,0,127}));
      connect(Constant3[4:6].y, torque3.torque[1:3]) annotation (Line(
          points={{150,79},{150,60.6667}}, color={0,0,127}));
      connect(Constant4[1:3].y, torque4.force[1:3]) annotation (Line(
          points={{170,-59},{170,-48},{158,-48},{158,-30.6667}}, color={0,0,127}));
      connect(Constant4[4:6].y, torque4.torque[1:3]) annotation (Line(
          points={{170,-59},{170,-48},{150,-48},{150,-30.6667}}, color={0,0,127}));
      connect(body2.frame_b, torque2.frame_resolve) annotation (Line(
          points={{-80,-20},{-74,-20},{-74,-42},{-54,-42},{-54,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, Revolute7.frame_a) annotation (Line(
          points={{30,-22},{34,-22},{34,10},{40,10}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, Revolute8.frame_a) annotation (Line(
          points={{30,-22},{34,-22},{34,-60},{40,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, torque4.frame_resolve) annotation (Line(
          points={{30,-22},{34,-22},{34,-80},{142,-80},{142,-30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=2, Tolerance=1e-6), Diagram(
            coordinateSystem(preserveAspectRatio=true, extent={{-200,-100},{200,
                100}})));
    end Torque3;

    model WorldForces
      extends Modelica.Icons.Example;
      inner MultiBody.World world(defaultN_to_m=600,defaultNm_to_m=200)
            annotation (Placement(transformation(extent={{-100,20},
                {-80,40}})));
      MultiBody.Joints.Revolute Revolute1(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-40,60},{-20,80}})));
      MultiBody.Parts.BodyCylinder BodyCylinder1(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,60},{20,80}})));
      MultiBody.Forces.WorldForce worldForce
        annotation (Placement(transformation(extent={{60,60},{40,80}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,500,0}) annotation (
          Placement(transformation(extent={{100,60},{80,80}})));
      MultiBody.Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-80,-20},{-60,0}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-30,10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Parts.BodyCylinder BodyCylinder2(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,20},{20,40}})));
      MultiBody.Forces.WorldTorque worldTorque1
        annotation (Placement(transformation(extent={{60,20},{40,40}})));
      Modelica.Blocks.Sources.Constant Constant2[3](k={100,100,100})
        annotation (Placement(transformation(extent={{100,20},{80,40}})));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-80,60},{-60,80}})));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-50,-100},{-30,-80}})));
      MultiBody.Parts.BodyCylinder BodyCylinder3(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,-60},{20,-40}})));
      Modelica.Blocks.Sources.Constant Constant4[6](k={0,500,0,100,100,100})
        annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
      MultiBody.Parts.Fixed fixed3(r={0,-1,0}) annotation (Placement(transformation(
              extent={{-80,-100},{-60,-80}})));
      MultiBody.Joints.Revolute Revolute4(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-10,-70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Forces.WorldForceAndTorque forceAndTorque(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.world)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={50,-50})));
    equation
      connect(BodyCylinder1.frame_a, Revolute1.frame_b)
        annotation (Line(points={{0,70},{-20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(worldForce.frame_b, BodyCylinder1.frame_b)
        annotation (Line(points={{40,70},{20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed2.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-60,-10},{-30,-10},{-30,0}},
          color={95,95,95},
          thickness=0.5));
      connect(BodyCylinder2.frame_a, Revolute2.frame_b)
        annotation (Line(points={{0,30},{-30,30},{-30,20}},
          color={95,95,95},
          thickness=0.5));
      connect(worldTorque1.frame_b, BodyCylinder2.frame_b)
        annotation (Line(points={{40,30},{20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-60,70},{-40,70}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed3.frame_b, Revolute3.frame_a)
        annotation (Line(points={{-60,-90},{-50,-90}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-30,-90},{-10,-90},{-10,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_b, BodyCylinder3.frame_a)
        annotation (Line(points={{-10,-60},{-10,-50},{0,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, worldForce.force) annotation (Line(
          points={{79,70},{62,70}}, color={0,0,127}));
      connect(Constant2.y, worldTorque1.torque) annotation (Line(
          points={{79,30},{62,30}}, color={0,0,127}));
      connect(forceAndTorque.frame_b, BodyCylinder3.frame_b) annotation (Line(
          points={{40,-50},{20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant4[1:3].y, forceAndTorque.force) annotation (Line(
          points={{79,-50},{70,-50},{70,-44},{62,-44}}, color={0,0,127}));
      connect(Constant4[4:6].y, forceAndTorque.torque) annotation (Line(
          points={{79,-50},{72,-50},{72,-56},{62,-56}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end WorldForces;

    model WorldForces2
      extends Modelica.Icons.Example;
      inner MultiBody.World world(defaultN_to_m=600)
          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            origin={86,-10})));

      parameter Real tol=1e-4;
      MultiBody.Joints.Revolute Revolute1(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-40,60},{-20,80}})));
      MultiBody.Parts.BodyCylinder BodyCylinder1(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,60},{20,80}})));
      MultiBody.Forces.WorldForce worldForce
        annotation (Placement(transformation(extent={{60,60},{40,80}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,500,0}) annotation (
          Placement(transformation(extent={{100,60},{80,80}})));
      MultiBody.Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-80,60},{-60,80}})));
      MultiBody.Joints.Revolute Revolute2(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-42,18},{-22,38}})));
      MultiBody.Parts.BodyCylinder BodyCylinder2(r={1,0,0}) annotation (Placement(
            transformation(extent={{-2,18},{18,38}})));
      MultiBody.Forces.WorldForce worldForce1(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{58,18},{38,38}})));
      Modelica.Blocks.Sources.Constant Constant2[3](k={0,500,0}) annotation (
          Placement(transformation(extent={{98,18},{78,38}})));
      MultiBody.Parts.Fixed fixed2(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-82,18},{-62,38}})));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-40,-60},{-20,-40}})));
      MultiBody.Parts.BodyCylinder BodyCylinder3(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,-60},{20,-40}})));
      MultiBody.Parts.Fixed fixed3(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-80,-60},{-60,-40}})));
      MultiBody.Forces.WorldForce worldForce2(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
      Modelica.Blocks.Sources.Sine sine(amplitude=500, f=1/0.403)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            origin={90,-50})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{100,-94},{80,-74}})));
    equation
      assert((Revolute1.phi - Revolute2.phi) < tol,
        "Angles of Revolute1 and Revolute2 must be equal (diff<tol)");
      assert((Revolute1.w - Revolute2.w) < tol,
        "Angles of Revolute1 and Revolute2 must be equal (diff<tol)");
      connect(BodyCylinder1.frame_a, Revolute1.frame_b)
        annotation (Line(points={{0,70},{-20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(worldForce.frame_b, BodyCylinder1.frame_b)
        annotation (Line(points={{40,70},{20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-60,70},{-40,70}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, worldForce.force) annotation (Line(
          points={{79,70},{62,70}}, color={0,0,127}));
      connect(BodyCylinder2.frame_a, Revolute2.frame_b)
        annotation (Line(points={{-2,28},{-22,28}},
          color={95,95,95},
          thickness=0.5));
      connect(worldForce1.frame_b, BodyCylinder2.frame_b)
        annotation (Line(points={{38,28},{18,28}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed2.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-62,28},{-42,28}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant2.y, worldForce1.force) annotation (Line(
          points={{77,28},{60,28}}, color={0,0,127}));
      connect(world.frame_b, worldForce1.frame_resolve) annotation (Line(
          points={{76,-10},{64,-10},{64,18},{48,18}},
          color={95,95,95},
          thickness=0.5));
      connect(BodyCylinder3.frame_a, Revolute3.frame_b)
        annotation (Line(points={{0,-50},{-20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed3.frame_b, Revolute3.frame_a)
        annotation (Line(points={{-60,-50},{-40,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(worldForce2.frame_b, BodyCylinder3.frame_b) annotation (Line(
          points={{40,-50},{20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(sine.y, worldForce2.force[2]) annotation (Line(
          points={{79,-50},{62,-50}}, color={0,0,127}));
      connect(const.y, worldForce2.force[1]) annotation (Line(
          points={{79,-84},{72,-84},{72,-51.3333},{62,-51.3333}}, color={0,0,127}));
      connect(const.y, worldForce2.force[3]) annotation (Line(
          points={{79,-84},{72,-84},{72,-48.6667},{62,-48.6667}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end WorldForces2;

    model WorldTorques
      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;
      inner MultiBody.World world(defaultNm_to_m=200)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            origin={80,18})));
      MultiBody.Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-80,40},{-60,60}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-40,50},
            extent={{-10,-10},{10,10}})));
      MultiBody.Parts.BodyCylinder BodyCylinder2(r={1,0,0}) annotation (Placement(
            transformation(extent={{-10,40},{10,60}})));
      MultiBody.Forces.WorldTorque worldTorque1
        annotation (Placement(transformation(extent={{46,40},{26,60}})));
      Modelica.Blocks.Sources.Constant Constant2[3](k={100,100,100})
        annotation (Placement(transformation(extent={{90,40},{70,60}})));
      MultiBody.Parts.Fixed fixed1(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-80,-20},{-60,0}})));
      MultiBody.Joints.Revolute Revolute1(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-40,-10},
            extent={{-10,-10},{10,10}})));
      MultiBody.Parts.BodyCylinder BodyCylinder1(r={1,0,0}) annotation (Placement(
            transformation(extent={{-10,-20},{10,0}})));
      MultiBody.Forces.WorldTorque worldTorque2(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{48,-20},{28,0}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={100,100,100})
        annotation (Placement(transformation(extent={{90,-20},{70,0}})));
      MultiBody.Joints.Revolute Revolute3(
        phi(fixed=true),
        w(fixed=true),
        n={0,1,0}) annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
      MultiBody.Parts.BodyCylinder BodyCylinder3(r={1,0,0})
        annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
      MultiBody.Parts.Fixed fixed3(r={0,0.5,0}) annotation (
          Placement(transformation(extent={{-80,-70},{-60,-50}})));
      Modelica.Blocks.Sources.Sine sine[3](amplitude={100,100,100}, f={5,5,
            5}) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            origin={80,-60})));
      MultiBody.Forces.WorldTorque worldTorque3(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
    equation
      assert((Revolute1.phi - Revolute2.phi) < tol,
        "Angles of Revolute1 and Revolute2 must be equal (diff<tol)");
      assert((Revolute1.w - Revolute2.w) < tol,
        "Angular velocity of Revolute1 and Revolute2 must be equal (diff<tol)");
      connect(fixed2.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-60,50},{-50,50}},
          color={95,95,95},
          thickness=0.5));
      connect(BodyCylinder2.frame_a, Revolute2.frame_b)
        annotation (Line(points={{-10,50},{-30,50}},
          color={95,95,95},
          thickness=0.5));
      connect(worldTorque1.frame_b, BodyCylinder2.frame_b)
        annotation (Line(points={{26,50},{10,50}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant2.y, worldTorque1.torque) annotation (Line(
          points={{69,50},{48,50}}, color={0,0,127}));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-60,-10},{-50,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(BodyCylinder1.frame_a, Revolute1.frame_b)
        annotation (Line(points={{-10,-10},{-30,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(worldTorque2.frame_b, BodyCylinder1.frame_b)
        annotation (Line(points={{28,-10},{10,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1.y, worldTorque2.torque) annotation (Line(
          points={{69,-10},{50,-10}}, color={0,0,127}));
      connect(world.frame_b, worldTorque2.frame_resolve) annotation (Line(
          points={{70,18},{38,18},{38,0}},
          color={95,95,95},
          thickness=0.5));
      connect(BodyCylinder3.frame_a, Revolute3.frame_b)
        annotation (Line(points={{-10,-60},{-30,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed3.frame_b, Revolute3.frame_a)
        annotation (Line(points={{-60,-60},{-50,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(worldTorque3.frame_b, BodyCylinder3.frame_b) annotation (Line(
          points={{30,-60},{10,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(sine.y, worldTorque3.torque) annotation (Line(
          points={{69,-60},{52,-60}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end WorldTorques;

    model WorldForceAndTorque
      extends Modelica.Icons.Example;

      parameter Real tol=1e-4;

      inner MultiBody.World world annotation (Placement(transformation(extent={{94,-32},{74,-12}})));
      MultiBody.Joints.Revolute Revolute3(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-70,52},{-50,72}})));
      MultiBody.Parts.BodyCylinder BodyCylinder3(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,52},{20,72}})));
      Modelica.Blocks.Sources.Constant Constant4[6](k={0,500,0,100,100,100})
        annotation (Placement(transformation(extent={{94,52},{74,72}})));
      MultiBody.Parts.Fixed fixed3(r={0,-1,0}) annotation (Placement(transformation(
              extent={{-100,52},{-80,72}})));
      MultiBody.Joints.Revolute Revolute4(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-30,62},
            extent={{-10,-10},{10,10}})));
      MultiBody.Forces.WorldForceAndTorque forceAndTorque(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.world)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={44,62})));
      MultiBody.Joints.Revolute Revolute1(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-70,10},{-50,30}})));
      MultiBody.Parts.BodyCylinder BodyCylinder1(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,10},{20,30}})));
      Modelica.Blocks.Sources.Constant Constant1[6](k={0,500,0,100,100,100})
        annotation (Placement(transformation(extent={{94,10},{74,30}})));
      MultiBody.Parts.Fixed fixed1(r={0,-1,0}) annotation (Placement(transformation(
              extent={{-100,10},{-80,30}})));
      MultiBody.Joints.Revolute Revolute2(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-30,20},
            extent={{-10,-10},{10,10}})));
      MultiBody.Forces.WorldForceAndTorque forceAndTorque1(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={44,20})));
      MultiBody.Joints.Revolute Revolute5(phi(fixed=true), w(fixed=true)) annotation (
          Placement(transformation(extent={{-70,-70},{-50,-50}})));
      MultiBody.Parts.BodyCylinder BodyCylinder2(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,-70},{20,-50}})));
      Modelica.Blocks.Sources.Constant Constant2[6](k={0,500,0,100,100,100})
        annotation (Placement(transformation(extent={{94,-70},{74,-50}})));
      MultiBody.Parts.Fixed fixed2(r={0,-1,0}) annotation (Placement(transformation(
              extent={{-100,-70},{-80,-50}})));
      MultiBody.Joints.Revolute Revolute6(
        n={0,1,0},
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(
            origin={-30,-60},
            extent={{-10,-10},{10,10}})));
      MultiBody.Forces.WorldForceAndTorque forceAndTorque2(
          resolveInFrame=MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={46,-60})));
    equation

      assert((Revolute1.phi - Revolute3.phi) < tol,
        "Angles of Revolute1 and Revolute2 must be equal (diff<tol)");
      assert((Revolute2.phi - Revolute4.phi) < tol,
        "Angles of Revolute1 and Revolute2 must be equal (diff<tol)");
      assert((Revolute1.w - Revolute3.w) < tol,
        "Angular velocity of Revolute1 and Revolute2 must be equal (diff<tol)");
      assert((Revolute2.w - Revolute4.w) < tol,
        "Angular velocity of Revolute1 and Revolute2 must be equal (diff<tol)");
      connect(fixed3.frame_b, Revolute3.frame_a)
        annotation (Line(points={{-80,62},{-70,62}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-50,62},{-40,62}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute4.frame_b, BodyCylinder3.frame_a)
        annotation (Line(points={{-20,62},{0,62}},
          color={95,95,95},
          thickness=0.5));
      connect(forceAndTorque.frame_b, BodyCylinder3.frame_b) annotation (Line(
          points={{34,62},{20,62}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant4[1:3].y, forceAndTorque.force) annotation (Line(
          points={{73,62},{64,62},{64,68},{56,68}}, color={0,0,127}));
      connect(Constant4[4:6].y, forceAndTorque.torque) annotation (Line(
          points={{73,62},{66,62},{66,56},{56,56}}, color={0,0,127}));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-80,20},{-70,20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute1.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-50,20},{-40,20}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute2.frame_b, BodyCylinder1.frame_a)
        annotation (Line(points={{-20,20},{0,20}},
          color={95,95,95},
          thickness=0.5));
      connect(forceAndTorque1.frame_b, BodyCylinder1.frame_b) annotation (Line(
          points={{34,20},{20,20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, forceAndTorque1.frame_resolve) annotation (Line(
          points={{74,-22},{60,-22},{60,10},{44,10}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant1[1:3].y, forceAndTorque1.force) annotation (Line(
          points={{73,20},{66,20},{66,26},{56,26}}, color={0,0,127}));
      connect(Constant1[4:6].y, forceAndTorque1.torque) annotation (Line(
          points={{73,20},{64,20},{64,14},{56,14}}, color={0,0,127}));
      connect(fixed2.frame_b, Revolute5.frame_a)
        annotation (Line(points={{-80,-60},{-70,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute5.frame_b, Revolute6.frame_a)
        annotation (Line(points={{-50,-60},{-40,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Revolute6.frame_b, BodyCylinder2.frame_a)
        annotation (Line(points={{-20,-60},{0,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(forceAndTorque2.frame_b, BodyCylinder2.frame_b) annotation (Line(
          points={{36,-60},{20,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(Constant2[1:3].y, forceAndTorque2.force) annotation (Line(
          points={{73,-60},{66,-60},{66,-54},{58,-54}}, color={0,0,127}));
      connect(Constant2[4:6].y, forceAndTorque2.torque) annotation (Line(
          points={{73,-60},{66,-60},{66,-66},{58,-66}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end WorldForceAndTorque;

    model Spring

      extends Modelica.Icons.Example;
      inner MultiBody.World world
        annotation (Placement(transformation(extent={{-96,40},{-76,60}})));
      parameter Real tol=1e-4;
      MultiBody.Parts.FixedTranslation fixedTranslation(
          animation=false, r={1,0,0})
        annotation (Placement(transformation(extent={{-26,40},{-6,60}})));
      MultiBody.Forces.Spring spring(s_unstretched=0.1, c=10)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-48,16})));
      MultiBody.Forces.Spring spring1(s_unstretched=0.1, c(
            fixed=false, start=1)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={12,16})));
      MultiBody.Parts.Body body(m=1, r_CM={0,0,0})
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-48,-20})));
      MultiBody.Parts.Body body1(m=1, r_CM={0,0,0})
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={12,-20})));
      MultiBody.Joints.Prismatic prismatic(
        v(fixed=true),
        n={0,1,0},
        s(fixed=true, start=-1)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-68,16})));
      MultiBody.Joints.Prismatic prismatic1(
        v(fixed=true),
        n={0,1,0},
        s(start=-1, fixed=true),
        a(fixed=true, start=-0.81)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-4,16})));
    equation
      assert(body.r_0[2] - body.r_0[2] < tol,
        "Position of the bodies must be equal (less then tolerance)");
      assert(body.v_0[2] - body.v_0[2] < tol,
        "Velocity of the bodies must be equal (less then tolerance)");
      connect(world.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{-76,50},{-26,50}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring.frame_a) annotation (Line(
          points={{-76,50},{-48,50},{-48,26}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_b, spring1.frame_a) annotation (Line(
          points={{-6,50},{12,50},{12,26}},
          color={95,95,95},
          thickness=0.5));
      connect(body.frame_a, spring.frame_b) annotation (Line(
          points={{-48,-10},{-48,6}},
          color={95,95,95},
          thickness=0.5));
      connect(body1.frame_a, spring1.frame_b) annotation (Line(
          points={{12,-10},{12,-2},{12,-2},{12,6}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic.frame_a, spring.frame_a) annotation (Line(
          points={{-68,26},{-48,26}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic.frame_b, spring.frame_b) annotation (Line(
          points={{-68,6},{-48,6}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic1.frame_a, spring1.frame_a) annotation (Line(
          points={{-4,26},{12,26}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic1.frame_b, spring1.frame_b) annotation (Line(
          points={{-4,6},{12,6}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=3));
    end Spring;

    model Spring2

      extends Modelica.Icons.Example;
      inner MultiBody.World world
        annotation (Placement(transformation(extent={{-96,40},{-76,60}})));
      parameter Real tol=1e-4;
      MultiBody.Parts.FixedTranslation fixedTranslation(
          animation=false, r={1,0,0})
        annotation (Placement(transformation(extent={{-26,40},{-6,60}})));
      MultiBody.Forces.Spring spring(s_unstretched=0.1, c=10)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-48,16})));
      MultiBody.Forces.Spring spring1(s_unstretched=0.1, c=
            10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={12,16})));
      MultiBody.Parts.Body body(
        m=1,
        r_CM={0,0,0},
        v_0(each fixed=true),
        r_0(each fixed=true, start={1,-1,-0.4}),
        angles_fixed=true,
        w_0_fixed=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={12,-20})));
      MultiBody.Parts.Body body1(
        m=1,
        r_CM={0,0,0},
        v_0(each fixed=true, start={1,0.4,0.5}),
        r_0(each fixed=true, start={-0.1,-0.2,-0.15}),
        I_11=1,
        I_22=0.3,
        I_33=0.5,
        angles_fixed=true,
        w_0_fixed=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-48,-20})));
      MultiBody.Forces.Spring spring2(
        s_unstretched=0.1,
        m=1,
        c=10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={70,16})));
      MultiBody.Parts.Body body2(
        m=1,
        r_CM={0,0,0},
        v_0(each fixed=true, start={1,0.4,0.5}),
        r_0(each fixed=true, start={2.1,-0.2,-0.15}),
        angles_fixed=true,
        w_0_fixed=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={70,-20})));
      MultiBody.Parts.FixedTranslation fixedTranslation1(
          animation=false, r={1,0,0})
        annotation (Placement(transformation(extent={{28,40},{48,60}})));
    equation
      assert(body.r_0[2] - body.r_0[2] < tol,
        "Position of the bodies must be equal (less then tolerance)");
      assert(body.v_0[2] - body.v_0[2] < tol,
        "Velocity of the bodies must be equal (less then tolerance)");
      connect(world.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{-76,50},{-26,50}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring.frame_a) annotation (Line(
          points={{-76,50},{-48,50},{-48,26}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_b, spring1.frame_a) annotation (Line(
          points={{-6,50},{12,50},{12,26}},
          color={95,95,95},
          thickness=0.5));
      connect(body2.frame_a, spring2.frame_b) annotation (Line(
          points={{70,-10},{70,6}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation1.frame_a, fixedTranslation.frame_b) annotation (
          Line(
          points={{28,50},{-6,50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation1.frame_b, spring2.frame_a) annotation (Line(
          points={{48,50},{70,50},{70,26}},
          color={95,95,95},
          thickness=0.5));
      connect(body1.frame_a, spring.frame_b) annotation (Line(
          points={{-48,-10},{-48,6}},
          color={95,95,95},
          thickness=0.5));
      connect(body.frame_a, spring1.frame_b) annotation (Line(
          points={{12,-10},{12,-2},{12,-2},{12,6}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=3));
    end Spring2;

    model Damper

      extends Modelica.Icons.Example;
      inner MultiBody.World world
        annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
      parameter Real tol=1e-4;
      MultiBody.Forces.Damper damper(d=10) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={-40,-50})));
      MultiBody.Joints.Prismatic prismatic(
        useAxisFlange=false,
        s(fixed=true, start=0.5),
        v(fixed=true, start=-0.1),
        stateSelect=StateSelect.never)
        annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
      MultiBody.Forces.Force force
        annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
      MultiBody.Parts.Body body(m=5, r_CM={0,0,0})
        annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
      Modelica.Blocks.Sources.Sine sine(f=2, amplitude=50)
        annotation (Placement(transformation(extent={{90,-10},{70,10}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{90,20},{70,40}})));
      MultiBody.Forces.Damper damper1(d=10,useHeatPort=true)
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            origin={-30,110})));
      MultiBody.Joints.Prismatic prismatic1(
        useAxisFlange=false,
        stateSelect=StateSelect.always,
        s(start=0.5, fixed=true),
        v(start=-0.1, fixed=true))
        annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
      MultiBody.Forces.Force force1
        annotation (Placement(transformation(extent={{-40,60},{-20,40}})));
      MultiBody.Parts.Body body1(
        m=5,
        r_CM={0,0,0},
        useQuaternions=false,
        r_0(start={0.5,0,0}),
        v_0(start={-0.1,0,0}),
        angles_fixed=false,
        w_0_fixed=false)
        annotation (Placement(transformation(extent={{10,70},{30,90}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=
            100, T(fixed=true))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,120})));
      MultiBody.Forces.Damper damper2(d(fixed=false, start=3))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={50,-70})));
      MultiBody.Joints.Prismatic prismatic2(
        useAxisFlange=false,
        s(fixed=true, start=0.5),
        v(fixed=true, start=-0.1),
        a(fixed=true, start=0.2))
        annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
      MultiBody.Forces.Force force2
        annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
      MultiBody.Parts.Body body2(m=5,r_CM={0,0,0})
        annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
      MultiBody.Parts.FixedTranslation fixedTranslation(r={0,
            0.1,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,-10})));
      MultiBody.Parts.FixedTranslation fixedTranslation1(r={
            0,0.1,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={0,-100})));
    equation
      assert(body.r_0[1] - body1.r_0[1] < tol and body1.r_0[1] - body2.r_0[1]
         < tol and body.r_0[1] - body2.r_0[1] < tol,
        "Positions of bodies  must be equal (diff<tol)");
      assert(body.v_0[1] - body1.v_0[1] < tol and body1.v_0[1] - body2.v_0[1]
         < tol and body.v_0[1] - body2.v_0[1] < tol,
        "Positions of bodies must be equal (diff<tol)");

      connect(prismatic.frame_b, body.frame_a) annotation (Line(
          points={{-30,-80},{-20,-80},{-20,-50},{-10,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(damper.frame_b, body.frame_a) annotation (Line(
          points={{-30,-50},{-10,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(force.frame_b, body.frame_a) annotation (Line(
          points={{-30,-20},{-20,-20},{-20,-50},{-10,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(sine.y, force.force[1]) annotation (Line(
          points={{69,0},{-46,0},{-46,-6.66667}},                      color={0,0,127}));
      connect(const.y, force.force[2]) annotation (Line(
          points={{69,30},{-50,30},{-50,-8},{-46,-8}},     color={0,0,127}));
      connect(const.y, force.force[3]) annotation (Line(
          points={{69,30},{-50,30},{-50,-9.33333},{-46,-9.33333}},
                                                                 color={0,0,127}));
      connect(world.frame_b, prismatic1.frame_a) annotation (Line(
          points={{-100,30},{-90,30},{-90,80},{-40,80}},
          color={95,95,95},
          thickness=0.5));
      connect(damper1.frame_a, world.frame_b) annotation (Line(
          points={{-40,110},{-50,110},{-50,80},{-90,80},{-90,30},{-100,30}},
          color={95,95,95},
          thickness=0.5));
      connect(force1.frame_a, world.frame_b) annotation (Line(
          points={{-40,50},{-50,50},{-50,80},{-90,80},{-90,30},{-100,30}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic1.frame_b, body1.frame_a) annotation (Line(
          points={{-20,80},{10,80}},
          color={95,95,95},
          thickness=0.5));
      connect(damper1.frame_b, body1.frame_a) annotation (Line(
          points={{-20,110},{-10,110},{-10,80},{10,80}},
          color={95,95,95},
          thickness=0.5));
      connect(force1.frame_b, body1.frame_a) annotation (Line(
          points={{-20,50},{-10,50},{-10,80},{10,80}},
          color={95,95,95},
          thickness=0.5));
      connect(const.y, force1.force[2]) annotation (Line(
          points={{69,30},{-50,30},{-50,38},{-36,38}},     color={0,0,127}));
      connect(const.y, force1.force[3]) annotation (Line(
          points={{69,30},{-50,30},{-50,39.3333},{-36,39.3333}},
                                                               color={0,0,127}));
      connect(sine.y, force1.force[1]) annotation (Line(
          points={{69,0},{-36,0},{-36,36.6667}},                     color={0,0,127}));
      connect(heatCapacitor.port, damper1.heatPort) annotation (Line(
          points={{-80,120},{-40,120}},           color={191,0,0}));
      connect(prismatic2.frame_b, body2.frame_a) annotation (Line(
          points={{60,-100},{70,-100},{70,-70},{80,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(damper2.frame_b, body2.frame_a) annotation (Line(
          points={{60,-70},{80,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(force2.frame_b, body2.frame_a) annotation (Line(
          points={{60,-40},{70,-40},{70,-70},{80,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(const.y, force2.force[2]) annotation (Line(
          points={{69,30},{50,30},{50,-28},{44,-28}},        color={0,0,127}));
      connect(const.y, force2.force[3]) annotation (Line(
          points={{69,30},{50,30},{50,-29.3333},{44,-29.3333}},  color={0,0,127}));
      connect(sine.y, force2.force[1]) annotation (Line(
          points={{69,0},{44,0},{44,-26.6667}},                        color={0,0,127}));
      connect(fixedTranslation.frame_a, world.frame_b) annotation (Line(
          points={{-90,0},{-90,30},{-100,30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation1.frame_a, fixedTranslation.frame_b) annotation (
          Line(
          points={{-10,-100},{-90,-100},{-90,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic.frame_a, fixedTranslation.frame_b) annotation (Line(
          points={{-50,-80},{-60,-80},{-60,-50},{-90,-50},{-90,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(damper.frame_a, fixedTranslation.frame_b) annotation (Line(
          points={{-50,-50},{-90,-50},{-90,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(force.frame_a, fixedTranslation.frame_b) annotation (Line(
          points={{-50,-20},{-60,-20},{-60,-50},{-90,-50},{-90,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation1.frame_b, force2.frame_a) annotation (Line(
          points={{10,-100},{30,-100},{30,-40},{40,-40}},
          color={95,95,95},
          thickness=0.5));
      connect(damper2.frame_a, fixedTranslation1.frame_b) annotation (Line(
          points={{40,-70},{30,-70},{30,-100},{10,-100}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic2.frame_a, fixedTranslation1.frame_b) annotation (Line(
          points={{40,-100},{10,-100}},
          color={95,95,95},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(extent={{-120,-120},{100,140}},
              preserveAspectRatio=true)), experiment(StopTime=7));
    end Damper;

    model Damper2

      extends Modelica.Icons.Example;
      inner MultiBody.World world
        annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
      parameter Real tol=1e-4;
      MultiBody.Forces.Damper damper(d=310) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={-40,-50})));
      MultiBody.Joints.Prismatic prismatic(
        useAxisFlange=false,
        s(fixed=true, start=0.5),
        v(fixed=true, start=-0.1))
        annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
      MultiBody.Forces.Force force
        annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
      MultiBody.Parts.Body body(m=5, r_CM={0,0,0})
        annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=50,
        rising=0.1,
        width=0.15,
        falling=0.1,
        period=0.5,
        offset=-30)
        annotation (Placement(transformation(extent={{90,-10},{70,10}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{90,20},{70,40}})));
      MultiBody.Forces.Damper damper1(     useHeatPort=true, d=310)
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            origin={-30,110})));
      MultiBody.Joints.Prismatic prismatic1(
        useAxisFlange=false,
        s(fixed=true, start=0.5),
        v(fixed=true, start=-0.1))
        annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
      MultiBody.Forces.Force force1
        annotation (Placement(transformation(extent={{-40,60},{-20,40}})));
      MultiBody.Parts.Body body1(
        m=5,
        r_CM={0,0,0})
        annotation (Placement(transformation(extent={{10,70},{30,90}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=
            100, T(fixed=true))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,120})));
      MultiBody.Forces.Damper damper2(d(fixed=false, start=3))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={50,-70})));
      MultiBody.Joints.Prismatic prismatic2(
        useAxisFlange=false,
        s(fixed=true, start=0.5),
        v(fixed=true, start=-0.1),
        a(fixed=true, start=0.2))
        annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
      MultiBody.Forces.Force force2
        annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
      MultiBody.Parts.Body body2(m=5,r_CM={0,0,0})
        annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
      MultiBody.Parts.FixedTranslation fixedTranslation(r={0,
            0.1,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,-10})));
      MultiBody.Parts.FixedTranslation fixedTranslation1(r={
            0,0.1,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={0,-100})));
    equation
      assert(body.r_0[1] - body1.r_0[1] < tol and body1.r_0[1] - body2.r_0[1]
         < tol and body.r_0[1] - body2.r_0[1] < tol,
        "Positions of bodies  must be equal (diff<tol)");
      assert(body.v_0[1] - body1.v_0[1] < tol and body1.v_0[1] - body2.v_0[1]
         < tol and body.v_0[1] - body2.v_0[1] < tol,
        "Positions of bodies must be equal (diff<tol)");

      connect(prismatic.frame_b, body.frame_a) annotation (Line(
          points={{-30,-80},{-20,-80},{-20,-50},{-10,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(damper.frame_b, body.frame_a) annotation (Line(
          points={{-30,-50},{-10,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(force.frame_b, body.frame_a) annotation (Line(
          points={{-30,-20},{-20,-20},{-20,-50},{-10,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(trapezoid.y, force.force[1]) annotation (Line(points={{69,0},{-46,0},{-46,-6.66667}}, color={0,0,127}));
      connect(const.y, force.force[2]) annotation (Line(
          points={{69,30},{-50,30},{-50,-8},{-46,-8}},     color={0,0,127}));
      connect(const.y, force.force[3]) annotation (Line(
          points={{69,30},{-50,30},{-50,-9.33333},{-46,-9.33333}},
                                                                 color={0,0,127}));
      connect(world.frame_b, prismatic1.frame_a) annotation (Line(
          points={{-100,30},{-90,30},{-90,80},{-40,80}},
          color={95,95,95},
          thickness=0.5));
      connect(damper1.frame_a, world.frame_b) annotation (Line(
          points={{-40,110},{-50,110},{-50,80},{-90,80},{-90,30},{-100,30}},
          color={95,95,95},
          thickness=0.5));
      connect(force1.frame_a, world.frame_b) annotation (Line(
          points={{-40,50},{-50,50},{-50,80},{-90,80},{-90,30},{-100,30}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic1.frame_b, body1.frame_a) annotation (Line(
          points={{-20,80},{10,80}},
          color={95,95,95},
          thickness=0.5));
      connect(damper1.frame_b, body1.frame_a) annotation (Line(
          points={{-20,110},{-10,110},{-10,80},{10,80}},
          color={95,95,95},
          thickness=0.5));
      connect(force1.frame_b, body1.frame_a) annotation (Line(
          points={{-20,50},{-10,50},{-10,80},{10,80}},
          color={95,95,95},
          thickness=0.5));
      connect(const.y, force1.force[2]) annotation (Line(
          points={{69,30},{-50,30},{-50,38},{-36,38}},     color={0,0,127}));
      connect(const.y, force1.force[3]) annotation (Line(
          points={{69,30},{-50,30},{-50,39.3333},{-36,39.3333}},
                                                               color={0,0,127}));
      connect(trapezoid.y, force1.force[1]) annotation (Line(points={{69,0},{-36,0},{-36,36.6667}}, color={0,0,127}));
      connect(heatCapacitor.port, damper1.heatPort) annotation (Line(
          points={{-80,120},{-40,120}},           color={191,0,0}));
      connect(prismatic2.frame_b, body2.frame_a) annotation (Line(
          points={{60,-100},{70,-100},{70,-70},{80,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(damper2.frame_b, body2.frame_a) annotation (Line(
          points={{60,-70},{80,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(force2.frame_b, body2.frame_a) annotation (Line(
          points={{60,-40},{70,-40},{70,-70},{80,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(const.y, force2.force[2]) annotation (Line(
          points={{69,30},{50,30},{50,-28},{44,-28}},        color={0,0,127}));
      connect(const.y, force2.force[3]) annotation (Line(
          points={{69,30},{50,30},{50,-29.3333},{44,-29.3333}},  color={0,0,127}));
      connect(trapezoid.y, force2.force[1]) annotation (Line(points={{69,0},{44,0},{44,-26.6667}}, color={0,0,127}));
      connect(fixedTranslation.frame_a, world.frame_b) annotation (Line(
          points={{-90,0},{-90,30},{-100,30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation1.frame_a, fixedTranslation.frame_b) annotation (
          Line(
          points={{-10,-100},{-90,-100},{-90,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic.frame_a, fixedTranslation.frame_b) annotation (Line(
          points={{-50,-80},{-60,-80},{-60,-50},{-90,-50},{-90,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(damper.frame_a, fixedTranslation.frame_b) annotation (Line(
          points={{-50,-50},{-90,-50},{-90,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(force.frame_a, fixedTranslation.frame_b) annotation (Line(
          points={{-50,-20},{-60,-20},{-60,-50},{-90,-50},{-90,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation1.frame_b, force2.frame_a) annotation (Line(
          points={{10,-100},{30,-100},{30,-40},{40,-40}},
          color={95,95,95},
          thickness=0.5));
      connect(damper2.frame_a, fixedTranslation1.frame_b) annotation (Line(
          points={{40,-70},{30,-70},{30,-100},{10,-100}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic2.frame_a, fixedTranslation1.frame_b) annotation (Line(
          points={{40,-100},{10,-100}},
          color={95,95,95},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(extent={{-120,-120},{100,140}},
              preserveAspectRatio=true)), experiment(StopTime=7));
    end Damper2;

    model SpringDamperParallel
      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;
      final parameter Real d(fixed=false, start=2);

      inner MultiBody.World world
        annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      MultiBody.Forces.SpringDamperParallel
        springDamperParallel(
        s_unstretched=0.2,
        d=10,
        c=100) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={20,80})));
      MultiBody.Parts.PointMass pm1(m=5, v_0(start={0.1,0,0}))
        annotation (Placement(transformation(extent={{70,70},{90,90}})));
      MultiBody.Joints.Universal universal(
        phi_a(fixed=true),
        w_a(fixed=true),
        w_b(fixed=true),
        phi_b(fixed=true, start=0.78539816339745))
        annotation (Placement(transformation(extent={{0,110},{20,130}})));
      MultiBody.Joints.Prismatic prismatic(s(fixed=true,
            start=0.1), v(fixed=true, start=0.1))
        annotation (Placement(transformation(extent={{30,110},{50,130}})));
      MultiBody.Parts.FixedTranslation fixedTranslation(r={1,
            0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,20})));
      MultiBody.Parts.FixedTranslation fixedTranslation1(r={
            1,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,-60})));
      MultiBody.Forces.SpringDamperParallel
        springDamperParallel1(
        s_unstretched=0.2,
        d=10,
        c(fixed=false, start=3)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={20,-10})));
      MultiBody.Parts.PointMass pm2(
        m=5,
        stateSelect=StateSelect.default,
        r_0(start={1,0.1,0.1}),
        v_0(start={0.1,0,0}))
        annotation (Placement(transformation(extent={{70,-20},{90,0}})));
      MultiBody.Joints.Universal universal1(
        phi_a(fixed=true),
        w_a(fixed=true),
        w_b(fixed=true),
        phi_b(fixed=true, start=0.78539816339745))
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      MultiBody.Joints.Prismatic prismatic1(
        s(start=0.1, fixed=true),
        v(start=0.1, fixed=true),
        a(fixed=true, start=1.8))
        annotation (Placement(transformation(extent={{30,20},{50,40}})));
      MultiBody.Forces.SpringDamperParallel
        springDamperParallel2(
        s_unstretched=0.2,
        d=d,
        c=100) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={20,-100})));
      MultiBody.Parts.PointMass pm3(
        m=5,
        v_0(start={0.1,0,0}),
        stateSelect=StateSelect.always)
        annotation (Placement(transformation(extent={{70,-110},{90,-90}})));
      MultiBody.Joints.Universal universal2(
        phi_a(fixed=true),
        w_a(fixed=true),
        w_b(fixed=true),
        phi_b(fixed=true, start=0.78539816339745))
        annotation (Placement(transformation(extent={{0,-50},{20,-70}})));
      MultiBody.Joints.Prismatic prismatic2(
        s(fixed=true, start=0.1),
        v(fixed=true, start=0.1),
        a(start=1.8, fixed=true))
        annotation (Placement(transformation(extent={{32,-70},{52,-50}})));
    equation
      assert(pm1.v_0[1] - pm2.v_0[1] < tol and pm2.v_0[1] - pm3.v_0[1] < tol
         and pm1.v_0[1] - pm3.v_0[1] < tol, "");
      assert(pm1.v_0[2] - pm2.v_0[2] < tol and pm2.v_0[2] - pm3.v_0[2] < tol
         and pm1.v_0[2] - pm3.v_0[2] < tol, "");
      assert(pm1.v_0[3] - pm2.v_0[3] < tol and pm2.v_0[3] - pm3.v_0[3] < tol
         and pm1.v_0[3] - pm3.v_0[3] < tol, "");
      connect(world.frame_b, springDamperParallel.frame_a) annotation (Line(
          points={{-80,50},{-60,50},{-60,80},{10,80}},
          color={95,95,95},
          thickness=0.5));
      connect(pm1.frame_a, springDamperParallel.frame_b) annotation (Line(
          points={{80,80},{30,80}},
          color={95,95,95},
          thickness=0.5));
      connect(springDamperParallel.frame_a, universal.frame_a) annotation (Line(
          points={{10,80},{-10,80},{-10,120},{0,120}},
          color={95,95,95},
          thickness=0.5));
      connect(universal.frame_b, prismatic.frame_a) annotation (Line(
          points={{20,120},{30,120}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic.frame_b, pm1.frame_a) annotation (Line(
          points={{50,120},{60,120},{60,80},{80,80}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_a, world.frame_b) annotation (Line(
          points={{-60,30},{-60,50},{-80,50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation1.frame_a, fixedTranslation.frame_b) annotation (
          Line(
          points={{-60,-50},{-60,10}},
          color={95,95,95},
          thickness=0.5));
      connect(pm2.frame_a, springDamperParallel1.frame_b) annotation (Line(
          points={{80,-10},{30,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(springDamperParallel1.frame_a, universal1.frame_a) annotation (
          Line(
          points={{10,-10},{-10,-10},{-10,30},{0,30}},
          color={95,95,95},
          thickness=0.5));
      connect(universal1.frame_b, prismatic1.frame_a) annotation (Line(
          points={{20,30},{30,30}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic1.frame_b, pm2.frame_a) annotation (Line(
          points={{50,30},{60,30},{60,-10},{80,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(springDamperParallel1.frame_a, fixedTranslation.frame_b)
        annotation (Line(
          points={{10,-10},{-60,-10},{-60,10}},
          color={95,95,95},
          thickness=0.5));
      connect(pm3.frame_a, springDamperParallel2.frame_b) annotation (Line(
          points={{80,-100},{30,-100}},
          color={95,95,95},
          thickness=0.5));
      connect(springDamperParallel2.frame_a, universal2.frame_a) annotation (
          Line(
          points={{10,-100},{-10,-100},{-10,-60},{0,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(universal2.frame_b, prismatic2.frame_a) annotation (Line(
          points={{20,-60},{32,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic2.frame_b, pm3.frame_a) annotation (Line(
          points={{52,-60},{64,-60},{64,-100},{80,-100}},
          color={95,95,95},
          thickness=0.5));
      connect(springDamperParallel2.frame_a, fixedTranslation1.frame_b)
        annotation (Line(
          points={{10,-100},{-60,-100},{-60,-70}},
          color={95,95,95},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(extent={{-100,-120},{100,140}},
              preserveAspectRatio=true)), experiment(StopTime=1.1, Tolerance=
              1e-007));
    end SpringDamperParallel;

    model SpringDamperSeries
      extends Modelica.Icons.Example;

      inner MultiBody.World world
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
      MultiBody.Forces.SpringDamperSeries sps1(
        c=10,
        s_unstretched=0.1,
        d=10)
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
      MultiBody.Forces.Spring s1(c=10, s_unstretched=0.1)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      MultiBody.Parts.PointMass pointMass(m=1)
        annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
      MultiBody.Joints.Universal universal1(
        phi_a(fixed=true),
        w_a(fixed=true),
        w_b(fixed=true),
        phi_b(fixed=true, start=0.78539816339745))
        annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
      MultiBody.Joints.Prismatic prismatic1(s(fixed=true,
            start=0.1), v(fixed=true, start=0.1))
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
    equation
      connect(s1.frame_a, world.frame_b) annotation (Line(
          points={{-30,0},{-50,0}},
          color={95,95,95},
          thickness=0.5));
      connect(sps1.frame_a, s1.frame_a) annotation (Line(
          points={{-30,-30},{-40,-30},{-40,0},{-30,0}},
          color={95,95,95},
          thickness=0.5));
      connect(s1.frame_b, pointMass.frame_a) annotation (Line(
          points={{-10,0},{0,0},{0,-20},{50,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(sps1.frame_b, pointMass.frame_a) annotation (Line(
          points={{-10,-30},{0,-30},{0,-20},{50,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(s1.frame_a, universal1.frame_a) annotation (Line(
          points={{-30,0},{-40,0},{-40,30},{-30,30}},
          color={95,95,95},
          thickness=0.5));
      connect(pointMass.frame_a, prismatic1.frame_b) annotation (Line(
          points={{50,-20},{40,-20},{40,30},{20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(universal1.frame_b, prismatic1.frame_a) annotation (Line(
          points={{-10,30},{0,30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.0),        Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
    end SpringDamperSeries;

    model EngineGasForce "Example for gas force computation"
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Translational.Components.Fixed fixed annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Modelica.Mechanics.Translational.Components.Mass mass(m=1, L=0) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      Modelica.Mechanics.Translational.Sources.Position position(exact=true) annotation (Placement(transformation(extent={{40,-10},{20,10}})));
      MultiBody.Examples.Loops.Utilities.GasForce2 gasForce(
        L=0.2,
        d=0.1,
        k0=0.01,
        k1=1.1,
        k=1.08) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Modelica.Blocks.Sources.Sine sine(
        f=1,
        phase=0,
        startTime=0,
        offset=0.1,
        amplitude=0.0999999) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    equation
      connect(sine.y, position.s_ref) annotation (Line(points={{59,0},{42,0}},     color={0,0,127}));
      connect(gasForce.flange_b, mass.flange_a) annotation (Line(points={{-40,0},{-20,0}}, color={0,127,0}));
      connect(gasForce.flange_a, fixed.flange) annotation (Line(points={{-60,0},{-80,0}}, color={0,127,0}));
      connect(position.flange, mass.flange_b) annotation (Line(points={{20,0},{0,0}}, color={0,127,0}));
      annotation (experiment(StopTime=1), Documentation(info="<html>
<p>
Simple model to test gasForce element used in some multi-body examples,
see <a href=\"modelica://MultiBody.Examples.Loops\">MultiBody.Examples.Loops</a>.
</p>
<p>
To generate the pressure-stroke diagram, simulate the example for 1&nbsp;s
and plot gasForce.press over gasForce.s_rel.
</p>
</html>"));
    end EngineGasForce;
  end Forces;

  package Joints "Test MultiBody.Joints"
    extends Modelica.Icons.ExamplesPackage;
    model Revolute
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Visualizers.FixedArrow axis(
        length=0.5,
        n={0,0,1}) annotation (Placement(transformation(extent={{10,60},{30,80}})));
      MultiBody.Joints.Revolute revolute(
        n={0,0,1},
        cylinderDiameter=1/15,
        a(fixed=false),
        phi(fixed=true, start=0.7853981633974483),
        w(fixed=true)) annotation (Placement(transformation(extent={{-22,20},{-2,
                40}})));
      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, revolute.frame_a) annotation (Line(
          points={{-40,30},{-22,30}},
          thickness=0.5));
      connect(revolute.frame_b, body.frame_a) annotation (Line(
          points={{-2,30},{20,30}},
          thickness=0.5));
      connect(revolute.frame_b, axis.frame_a) annotation (Line(
          points={{-2,30},{4,30},{4,70},{10,70}},
          thickness=0.5));
      connect(frame_a.frame_a, revolute.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, revolute.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Revolute;

    model RevoluteInitialization
      extends Modelica.Icons.Example;
      parameter Real expectedC=49.05;
      parameter Real tol=1e-4;

      inner MultiBody.World world(gravityType=MultiBody.Types.GravityTypes.UniformGravity)
        annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      MultiBody.Joints.Revolute rev(
        n={0,0,1},
        useAxisFlange=true,
        a(fixed=true),
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(extent={{-40,0},{-20,
                20}})));
      Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1) annotation (
         Placement(transformation(extent={{-40,40},{-20,60}})));
      MultiBody.Parts.BodyShape body(
        r={1,0,0},
        r_CM={0.5,0,0},
        m=1) annotation (Placement(transformation(extent={{0,0},{20,20}})));
      MultiBody.Parts.Fixed fixed(r={1,0.2,0}, width=0.02)
        annotation (Placement(transformation(
            origin={50,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Forces.Spring spring(s_unstretched=0.1, c(
            fixed=false, start=100)) annotation (Placement(transformation(
            origin={50,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));

    equation
      assert(spring.c - expectedC < tol,
        "Expected spring stiffness constant is not equal to the actual constant");
      connect(world.frame_b, rev.frame_a) annotation (Line(
          points={{-60,10},{-40,10}},
          thickness=0.5));
      connect(damper.flange_b, rev.axis) annotation (Line(points={{-20,50},{-16,
              50},{-16,26},{-30,26},{-30,20}}));
      connect(rev.support, damper.flange_a) annotation (Line(points={{-36,20},{
              -36,26},{-48,26},{-48,50},{-40,50}}));
      connect(rev.frame_b, body.frame_a) annotation (Line(
          points={{-20,10},{0,10}},
          thickness=0.5));
      connect(fixed.frame_b, spring.frame_a) annotation (Line(
          points={{50,60},{50,40}},
          thickness=0.5));
      connect(body.frame_b, spring.frame_b) annotation (Line(
          points={{20,10},{50,10},{50,20}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end RevoluteInitialization;

    model Prismatic
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Visualizers.FixedArrow axis(
        length=0.5,
        n={1,1,0}) annotation (Placement(transformation(extent={{10,60},{30,80}})));
      MultiBody.Joints.Prismatic prismatic(
        n={1,1,0},
        a(fixed=false),
        s(fixed=true, start=0.3),
        v(fixed=true)) annotation (Placement(transformation(extent={{-20,20},{0,
                40}})));
      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, prismatic.frame_a) annotation (Line(
          points={{-40,30},{-20,30}},
          thickness=0.5));
      connect(prismatic.frame_b, body.frame_a) annotation (Line(
          points={{0,30},{20,30}},
          thickness=0.5));
      connect(prismatic.frame_b, axis.frame_a) annotation (Line(
          points={{0,30},{4,30},{4,70},{10,70}},
          thickness=0.5));
      connect(frame_a.frame_a, prismatic.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-20,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, prismatic.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{0,30}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Prismatic;

    model Cylindrical
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Visualizers.FixedArrow axis(
        length=0.5,
        n={0,0,1}) annotation (Placement(transformation(extent={{10,60},{30,80}})));
      MultiBody.Joints.Cylindrical cylindrical(
        n={0,0,1},
        cylinderDiameter=1/15,
        a(fixed=false),
        phi(fixed=true, start=0.7853981633974483),
        s(fixed=true, start=0.3),
        v(fixed=true),
        w(fixed=true),
        wd(fixed=false)) annotation (Placement(transformation(extent={{-22,20},
                {-2,40}})));
      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, cylindrical.frame_a) annotation (Line(
          points={{-40,30},{-22,30}},
          thickness=0.5));
      connect(cylindrical.frame_b, body.frame_a) annotation (Line(
          points={{-2,30},{20,30}},
          thickness=0.5));
      connect(cylindrical.frame_b, axis.frame_a) annotation (Line(
          points={{-2,30},{4,30},{4,70},{10,70}},
          thickness=0.5));
      connect(frame_a.frame_a, cylindrical.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, cylindrical.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Cylindrical;

    model Universal
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Visualizers.FixedArrow axis2(
        length=0.5,
        n={0,1,0},
        animation=false) annotation (Placement(transformation(extent={{10,60},{
                30,80}})));
      MultiBody.Joints.Universal universal(
        n_a={0,0,1},
        cylinderDiameter=1/15,
        cylinderLength=0.2,
        a_a(fixed=false),
        a_b(fixed=false),
        phi_a(fixed=true, start=1.570796326794897),
        phi_b(fixed=true, start=0.7853981633974483),
        w_a(fixed=true),
        w_b(fixed=true)) annotation (Placement(transformation(extent={{-24,20},
                {-4,40}})));
      MultiBody.Parts.Body body(
        m=1,
        r_CM={0.5,0,0},
        animation=true) annotation (Placement(transformation(extent={{20,20},{
                40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedArrow axis1(
        length=0.5,
        n={0,0,1},
        animation=false) annotation (Placement(transformation(extent={{-34,60},
                {-14,80}})));
    equation
      connect(world.frame_b, universal.frame_a) annotation (Line(
          points={{-40,30},{-24,30}},
          thickness=0.5));
      connect(universal.frame_b, body.frame_a) annotation (Line(
          points={{-4,30},{20,30}},
          thickness=0.5));
      connect(universal.frame_b, axis2.frame_a) annotation (Line(
          points={{-4,30},{4,30},{4,70},{10,70}},
          thickness=0.5));
      connect(frame_a.frame_a, universal.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-24,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, universal.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-4,30}},
          thickness=0.5));
      connect(universal.frame_a, axis1.frame_a) annotation (Line(
          points={{-24,30},{-24,30},{-24,56},{-48,56},{-48,70},{-34,70}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Universal;

    model Planar
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                -10},{-40,10}})));
      MultiBody.Visualizers.FixedArrow axis2(
        length=0.5,
        n={0,1,0}) annotation (Placement(transformation(extent={{40,30},{60,50}})));
      MultiBody.Joints.Planar planar(
        n={0,1,0},
        n_x={0,0,1},
        cylinderLength=1/10,
        cylinderDiameter=1/15,
        boxWidth=0.4*planar.cylinderDiameter,
        a_x(fixed=false),
        a_y(fixed=false),
        phi(fixed=true, start=0.7853981633974483),
        s_x(fixed=true, start=0.5),
        s_y(fixed=true, start=0.5),
        v_x(fixed=true),
        v_y(fixed=true),
        w(fixed=true),
        wd(fixed=false)) annotation (Placement(transformation(extent={{-10,-10},
                {10,10}})));
      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={20,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedArrow axis1(
        length=0.5,
        n={0,0,1},
        r_tail={0,0,0.5}) annotation (Placement(transformation(extent={{-8,30},
                {12,50}})));
    equation
      connect(world.frame_b, planar.frame_a) annotation (Line(
          points={{-40,0},{-20,0},{-10,0}},
          thickness=0.5));
      connect(planar.frame_b, body.frame_a) annotation (Line(
          points={{10,0},{40,0}},
          thickness=0.5));
      connect(planar.frame_b, axis2.frame_a) annotation (Line(
          points={{10,0},{20,0},{20,40},{40,40}},
          thickness=0.5));
      connect(frame_a.frame_a, planar.frame_a) annotation (Line(
          points={{-20,-30},{-20,0},{-10,0}},
          thickness=0.5));
      connect(frame_a1.frame_a, planar.frame_b) annotation (Line(
          points={{20,-30},{20,-30},{20,0},{10,0}},
          thickness=0.5));
      connect(planar.frame_a, axis1.frame_a) annotation (Line(
          points={{-10,0},{-20,0},{-20,40},{-8,40}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Planar;

    model Spherical
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                -10},{-40,10}})));
      MultiBody.Joints.Spherical spherical(
        angles_start={0.7853981633974483,0.7853981633974483,0.7853981633974483},
        angles_fixed=true,
        w_rel_a_fixed=true,
        z_rel_a_fixed=false) annotation (Placement(transformation(extent={{-10,
                -10},{10,10}})));

      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={20,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, spherical.frame_a) annotation (Line(
          points={{-40,0},{-20,0},{-10,0}},
          thickness=0.5));
      connect(spherical.frame_b, body.frame_a) annotation (Line(
          points={{10,0},{40,0}},
          thickness=0.5));
      connect(frame_a.frame_a, spherical.frame_a) annotation (Line(
          points={{-20,-30},{-20,0},{-10,0}},
          thickness=0.5));
      connect(frame_a1.frame_a, spherical.frame_b) annotation (Line(
          points={{20,-30},{20,-30},{20,0},{10,0}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Spherical;

    model FreeMotion
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Joints.FreeMotion freeMotion(
        angles_start={0.7853981633974483,0.7853981633974483,0.7853981633974483},
        a_rel_a(each fixed=false),
        angles_fixed=true,
        r_rel_a(each fixed=true, start={0.5,0.4,0}),
        v_rel_a(each fixed=true),
        w_rel_a_fixed=true,
        z_rel_a_fixed=false) annotation (Placement(transformation(extent={{-22,
                20},{-2,40}})));

      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, freeMotion.frame_a) annotation (Line(
          points={{-40,30},{-22,30}},
          thickness=0.5));
      connect(freeMotion.frame_b, body.frame_a) annotation (Line(
          points={{-2,30},{20,30}},
          thickness=0.5));
      connect(frame_a.frame_a, freeMotion.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, freeMotion.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end FreeMotion;

    model FreeMotionScalarInit
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Joints.FreeMotionScalarInit
        freeMotionScalarInit(
        use_angle=true,
        use_r=true,
        r_rel_a_1(start=0.5, fixed=true),
        r_rel_a_2(start=0.4, fixed=true),
        r_rel_a_3(start=0, fixed=true),
        r_rel_a_1_stateSelect=StateSelect.always,
        r_rel_a_2_stateSelect=StateSelect.always,
        r_rel_a_3_stateSelect=StateSelect.always,
        use_v=true,
        v_rel_a_1(fixed=true),
        v_rel_a_2(fixed=true),
        v_rel_a_3(fixed=true),
        v_rel_a_1_stateSelect=StateSelect.always,
        v_rel_a_2_stateSelect=StateSelect.always,
        v_rel_a_3_stateSelect=StateSelect.always,
        angle_1(start=0.78539816339745, fixed=true),
        angle_2(start=0.78539816339745, fixed=true),
        angle_3(start=0.78539816339745, fixed=true),
        angle_1_stateSelect=StateSelect.always,
        angle_2_stateSelect=StateSelect.always,
        angle_3_stateSelect=StateSelect.always,
        use_angle_d=true,
        angle_d_1(fixed=true),
        angle_d_2(fixed=true),
        angle_d_3(fixed=true),
        angle_d_1_stateSelect=StateSelect.always,
        angle_d_2_stateSelect=StateSelect.always,
        angle_d_3_stateSelect=StateSelect.always) annotation (Placement(
            transformation(extent={{-22,20},{-2,40}})));

      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, freeMotionScalarInit.frame_a) annotation (Line(
          points={{-40,30},{-22,30}},
          thickness=0.5));
      connect(freeMotionScalarInit.frame_b, body.frame_a) annotation (Line(
          points={{-2,30},{20,30}},
          thickness=0.5));
      connect(frame_a.frame_a, freeMotionScalarInit.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, freeMotionScalarInit.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end FreeMotionScalarInit;

    model FreeMotionScalarInit2
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Joints.FreeMotionScalarInit
        freeMotionScalarInit(
        use_angle=true,
        use_r=true,
        r_rel_a_1(start=0.5, fixed=true),
        r_rel_a_2(start=0.4, fixed=true),
        r_rel_a_3(start=0, fixed=true),
        r_rel_a_1_stateSelect=StateSelect.always,
        r_rel_a_2_stateSelect=StateSelect.always,
        r_rel_a_3_stateSelect=StateSelect.always,
        use_v=true,
        v_rel_a_1(fixed=true),
        v_rel_a_2(fixed=true),
        v_rel_a_3(fixed=true),
        v_rel_a_1_stateSelect=StateSelect.always,
        v_rel_a_2_stateSelect=StateSelect.always,
        v_rel_a_3_stateSelect=StateSelect.always,
        angle_1_stateSelect=StateSelect.always,
        angle_2_stateSelect=StateSelect.always,
        angle_3_stateSelect=StateSelect.always,
        use_angle_d=false,
        use_w=true,
        w_rel_b_1(fixed=true),
        w_rel_b_2(fixed=true),
        w_rel_b_3(fixed=true),
        w_rel_b_1_stateSelect=StateSelect.always,
        w_rel_b_2_stateSelect=StateSelect.always,
        w_rel_b_3_stateSelect=StateSelect.always,
        angle_1(start=0.78539816339745, fixed=true),
        angle_2(start=0.78539816339745, fixed=true),
        angle_3(start=0.78539816339745, fixed=true)) annotation (Placement(
            transformation(extent={{-22,20},{-2,40}})));

      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, freeMotionScalarInit.frame_a) annotation (Line(
          points={{-40,30},{-22,30}},
          thickness=0.5));
      connect(freeMotionScalarInit.frame_b, body.frame_a) annotation (Line(
          points={{-2,30},{20,30}},
          thickness=0.5));
      connect(frame_a.frame_a, freeMotionScalarInit.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, freeMotionScalarInit.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end FreeMotionScalarInit2;

    model FreeMotionScalarInit3
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Joints.FreeMotionScalarInit freeMotionScalarInit(
        use_angle=true,
        use_r=true,
        r_rel_a_1_stateSelect=StateSelect.always,
        r_rel_a_2_stateSelect=StateSelect.always,
        r_rel_a_3_stateSelect=StateSelect.always,
        use_v=true,
        v_rel_a_1(fixed=true),
        v_rel_a_2(fixed=true),
        v_rel_a_3(fixed=true),
        v_rel_a_1_stateSelect=StateSelect.always,
        v_rel_a_2_stateSelect=StateSelect.always,
        v_rel_a_3_stateSelect=StateSelect.always,
        angle_1_stateSelect=StateSelect.always,
        angle_2_stateSelect=StateSelect.always,
        angle_3_stateSelect=StateSelect.always,
        w_rel_b_1_stateSelect=StateSelect.always,
        w_rel_b_2_stateSelect=StateSelect.always,
        w_rel_b_3_stateSelect=StateSelect.always,
        use_a=true,
        a_rel_a_1(fixed=true),
        a_rel_a_2(fixed=true),
        a_rel_a_3(fixed=true),
        use_angle_d=true,
        angle_d_1(fixed=true),
        angle_d_2(fixed=true),
        angle_d_3(fixed=true),
        r_rel_a_1(start=0.5),
        r_rel_a_2(start=0.4),
        r_rel_a_3(start=0),
        use_w=false,
        use_angle_dd=false,
        angle_1(start=0.78539816339745, fixed=true),
        angle_2(start=0.78539816339745, fixed=true),
        angle_3(start=0.78539816339745, fixed=true)) annotation (Placement(
            transformation(extent={{-22,20},{-2,40}})));

      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Forces.Spring spring(c=100)
        annotation (Placement(transformation(extent={{-20,48},{0,68}})));
    equation
      connect(world.frame_b, freeMotionScalarInit.frame_a) annotation (Line(
          points={{-40,30},{-22,30}},
          thickness=0.5));
      connect(freeMotionScalarInit.frame_b, body.frame_a) annotation (Line(
          points={{-2,30},{20,30}},
          thickness=0.5));
      connect(frame_a.frame_a, freeMotionScalarInit.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, freeMotionScalarInit.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          thickness=0.5));
      connect(world.frame_b, spring.frame_a) annotation (Line(
          points={{-40,30},{-30,30},{-30,58},{-20,58}},
          color={95,95,95},
          thickness=0.5));
      connect(spring.frame_b, body.frame_a) annotation (Line(
          points={{0,58},{12,58},{12,30},{20,30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end FreeMotionScalarInit3;

    model FreeMotionScalarInit4
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Joints.FreeMotionScalarInit freeMotionScalarInit(
        use_angle=true,
        use_r=true,
        r_rel_a_1_stateSelect=StateSelect.always,
        r_rel_a_2_stateSelect=StateSelect.always,
        r_rel_a_3_stateSelect=StateSelect.always,
        use_v=true,
        v_rel_a_1(fixed=true),
        v_rel_a_2(fixed=true),
        v_rel_a_3(fixed=true),
        v_rel_a_1_stateSelect=StateSelect.always,
        v_rel_a_2_stateSelect=StateSelect.always,
        v_rel_a_3_stateSelect=StateSelect.always,
        angle_1_stateSelect=StateSelect.always,
        angle_2_stateSelect=StateSelect.always,
        angle_3_stateSelect=StateSelect.always,
        w_rel_b_1_stateSelect=StateSelect.always,
        w_rel_b_2_stateSelect=StateSelect.always,
        w_rel_b_3_stateSelect=StateSelect.always,
        use_a=true,
        a_rel_a_1(fixed=true),
        a_rel_a_2(fixed=true),
        a_rel_a_3(fixed=true),
        use_angle_d=true,
        angle_d_1(fixed=true),
        angle_d_2(fixed=true),
        angle_d_3(fixed=true),
        r_rel_a_1(start=0.5),
        r_rel_a_2(start=0.4),
        r_rel_a_3(start=0),
        use_w=false,
        angle_1(start=0.78539816339745, fixed=false),
        angle_2(start=0.78539816339745, fixed=false),
        angle_3(start=0.78539816339745, fixed=false),
        use_angle_dd=true,
        angle_dd_1(fixed=true),
        angle_dd_2(fixed=true),
        angle_dd_3(fixed=true))                      annotation (Placement(
            transformation(extent={{-22,20},{-2,40}})));

      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Forces.Spring spring(c=100)
        annotation (Placement(transformation(extent={{-20,48},{0,68}})));
    equation
      connect(world.frame_b, freeMotionScalarInit.frame_a) annotation (Line(
          points={{-40,30},{-22,30}},
          thickness=0.5));
      connect(freeMotionScalarInit.frame_b, body.frame_a) annotation (Line(
          points={{-2,30},{20,30}},
          thickness=0.5));
      connect(frame_a.frame_a, freeMotionScalarInit.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, freeMotionScalarInit.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          thickness=0.5));
      connect(world.frame_b, spring.frame_a) annotation (Line(
          points={{-40,30},{-30,30},{-30,58},{-20,58}},
          color={95,95,95},
          thickness=0.5));
      connect(spring.frame_b, body.frame_a) annotation (Line(
          points={{0,58},{12,58},{12,30},{20,30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end FreeMotionScalarInit4;

    model FreeMotionScalarInit5
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,20},
                {-40,40}})));
      MultiBody.Joints.FreeMotionScalarInit freeMotionScalarInit1(
        use_r=true,
        r_rel_a_1(start=0.5, fixed=true),
        r_rel_a_2(start=0.4, fixed=true),
        r_rel_a_3(start=0, fixed=true),
        r_rel_a_1_stateSelect=StateSelect.always,
        r_rel_a_2_stateSelect=StateSelect.always,
        r_rel_a_3_stateSelect=StateSelect.always,
        use_v=true,
        v_rel_a_1(fixed=true),
        v_rel_a_2(fixed=true),
        v_rel_a_3(fixed=true),
        v_rel_a_1_stateSelect=StateSelect.always,
        v_rel_a_2_stateSelect=StateSelect.always,
        v_rel_a_3_stateSelect=StateSelect.always,
        use_angle=false,
        angle_1(start=0.78539816339745),
        angle_2(start=0.78539816339745),
        angle_3(start=0.78539816339745),
        use_angle_d=false)                        annotation (Placement(
            transformation(extent={{-22,20},{-2,40}})));
      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Joints.FreeMotionScalarInit freeMotionScalarInit2(
        use_angle=true,
        angle_1(start=0.78539816339745, fixed=true),
        angle_2(start=0.78539816339745, fixed=true),
        angle_3(start=0.78539816339745, fixed=true),
        angle_1_stateSelect=StateSelect.always,
        angle_2_stateSelect=StateSelect.always,
        angle_3_stateSelect=StateSelect.always,
        use_angle_d=true,
        angle_d_1(fixed=true),
        angle_d_2(fixed=true),
        angle_d_3(fixed=true),
        angle_d_1_stateSelect=StateSelect.always,
        angle_d_2_stateSelect=StateSelect.always,
        angle_d_3_stateSelect=StateSelect.always,
        use_r=false,
        r_rel_a_1(start=0.5, fixed=false),
        r_rel_a_2(start=0.4, fixed=false),
        r_rel_a_3(start=0, fixed=false),
        use_v=false,
        v_rel_a_1(fixed=false),
        v_rel_a_2(fixed=false),
        v_rel_a_3(fixed=false))                   annotation (Placement(
            transformation(extent={{-20,46},{0,66}})));
    equation
      connect(world.frame_b, freeMotionScalarInit1.frame_a)
                                                           annotation (Line(
          points={{-40,30},{-22,30}},
          thickness=0.5));
      connect(freeMotionScalarInit1.frame_b, body.frame_a)
                                                          annotation (Line(
          points={{-2,30},{20,30}},
          thickness=0.5));
      connect(frame_a.frame_a, freeMotionScalarInit1.frame_a)
                                                             annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, freeMotionScalarInit1.frame_b)
                                                              annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          thickness=0.5));
      connect(world.frame_b, freeMotionScalarInit2.frame_a) annotation (Line(
          points={{-40,30},{-30,30},{-30,56},{-20,56}},
          color={95,95,95},
          thickness=0.5));
      connect(freeMotionScalarInit2.frame_b, body.frame_a) annotation (Line(
          points={{0,56},{12,56},{12,30},{20,30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end FreeMotionScalarInit5;

    model SphericalSpherical
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                -10},{-40,10}})));
      MultiBody.Joints.SphericalSpherical sphericalSpherical(
        rodLength={1,0.2,0}*{1,0.2,0},
        m=1,
        rRod_0(start={1,0.2,0})) annotation (Placement(transformation(extent={{
                -20,-10},{0,10}})));
      MultiBody.Joints.Prismatic Prismatic1(animation=false)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      MultiBody.Parts.Fixed Fixed1(r={1,0.2,0}, animation=
            false) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    equation
      connect(world.frame_b, sphericalSpherical.frame_a)
        annotation (Line(points={{-40,0},{-20,0}}));
      connect(sphericalSpherical.frame_b, Prismatic1.frame_a)
        annotation (Line(points={{0,0},{20,0}}));
      connect(Prismatic1.frame_b, Fixed1.frame_b)
        annotation (Line(points={{40,0},{60,0}}));
      annotation (experiment(StopTime=1.1));
    end SphericalSpherical;

    model JointUSP
      extends Modelica.Icons.Example;

      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Parts.Fixed Fixed1(animation=false, r={1.7,
            0.1,0}) annotation (Placement(transformation(extent={{40,20},{20,40}})));
      MultiBody.Joints.Assemblies.JointUSP jointUSP(rRod1_ia=
           rRod1_ia, rRod2_ib=rRod2_ib) annotation (Placement(transformation(
              extent={{-20,20},{0,40}})));
      MultiBody.Visualizers.FixedArrow n1_a(
        length=0.5,
        color={0,0,200},
        n={0,0,1}) annotation (Placement(transformation(extent={{-46,60},{-26,
                80}})));
      MultiBody.Visualizers.FixedArrow n2_ia(
        length=0.5,
        n=jointUSP.e2_ia,
        color={0,128,0}) annotation (Placement(transformation(extent={{-20,60},
                {0,80}})));
      MultiBody.Visualizers.FixedArrow rRod1(
        r_tail={0,-0.1,0},
        n=rRod1_ia,
        length=Modelica.Math.Vectors.length(rRod1_ia)) annotation (Placement(
            transformation(extent={{-20,-20},{0,0}})));
      MultiBody.Visualizers.FixedArrow rRod2(
        r_tail={0,-0.1,0},
        n=rRod2_ib,
        length=Modelica.Math.Vectors.length(rRod2_ib)) annotation (Placement(
            transformation(extent={{40,-20},{20,0}})));
      MultiBody.Visualizers.FixedArrow prism(
        r_tail={0,-0.1,0},
        n={-1,0,0},
        color={255,0,0},
        length=0.2) annotation (Placement(transformation(extent={{0,-60},{-20,-40}})));
    equation
      connect(world.frame_b, jointUSP.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}));
      connect(jointUSP.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}));
      connect(jointUSP.frame_a, n1_a.frame_a) annotation (Line(points={{-20,30},
              {-32,30},{-32,54},{-50,54},{-50,70},{-46,70}}));
      connect(n2_ia.frame_a, jointUSP.frame_ia) annotation (Line(points={{-20,
              70},{-24,70},{-24,46},{-18,46},{-18,40}}));
      connect(jointUSP.frame_ia, rRod1.frame_a) annotation (Line(points={{-18,
              40},{-26,40},{-26,-10},{-20,-10}}));
      connect(rRod2.frame_a, jointUSP.frame_ib) annotation (Line(points={{40,-10},
              {56,-10},{56,58},{-2,58},{-2,40}}));
      connect(prism.frame_a, jointUSP.frame_b) annotation (Line(points={{0,-50},
              {10,-50},{10,30},{0,30}}));
      annotation (experiment(StopTime=1.1));
    end JointUSP;

    model JointUPS
      extends Modelica.Icons.Example;

      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Parts.Fixed Fixed1(animation=false, r={1.7,
            0.1,0}) annotation (Placement(transformation(extent={{40,20},{20,40}})));
      MultiBody.Joints.Assemblies.JointUPS jointUPS(nAxis_ia=
           rRod1_ia) annotation (Placement(transformation(extent={{-20,20},{0,
                40}})));
      MultiBody.Visualizers.FixedArrow n1_a(
        length=0.5,
        color={0,0,200},
        n={0,0,1}) annotation (Placement(transformation(extent={{-46,60},{-26,
                80}})));
      MultiBody.Visualizers.FixedArrow n2_ia(
        length=0.5,
        n=jointUPS.e2_ia,
        color={0,128,0}) annotation (Placement(transformation(extent={{-20,60},
                {0,80}})));
      MultiBody.Visualizers.FixedArrow rRod1(
        r_tail={0,-0.1,0},
        n=rRod1_ia,
        length=Modelica.Math.Vectors.length(rRod1_ia)) annotation (Placement(
            transformation(extent={{-20,-20},{0,0}})));
    equation
      connect(world.frame_b, jointUPS.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}));
      connect(jointUPS.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}));
      connect(jointUPS.frame_a, n1_a.frame_a) annotation (Line(points={{-20,30},
              {-32,30},{-32,54},{-50,54},{-50,70},{-46,70}}));
      connect(n2_ia.frame_a, jointUPS.frame_ia) annotation (Line(points={{-20,
              70},{-24,70},{-24,46},{-18,46},{-18,40}}));
      connect(jointUPS.frame_ia, rRod1.frame_a) annotation (Line(points={{-18,
              40},{-26,40},{-26,-10},{-20,-10}}));
      annotation (experiment(StopTime=1.1));
    end JointUPS;

    model JointSSR
      extends Modelica.Icons.Example;

      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real L=Modelica.Math.Vectors.length(rRod1_ia);
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Parts.Fixed Fixed1(animation=false, r={1.5,
            0.1,0}) annotation (Placement(transformation(extent={{40,20},{20,40}})));
      MultiBody.Joints.Assemblies.JointSSR jointSSR(
        rRod2_ib=rRod2_ib,
        rod1Mass=1,
        rod1Length=L,
        revoluteDiameter=0.05) annotation (Placement(transformation(extent={{-20,
                20},{0,40}})));
      MultiBody.Visualizers.FixedArrow rRod2(
        n=rRod2_ib,
        length=Modelica.Math.Vectors.length(rRod2_ib),
        r_tail={0.05,0.1,0}) annotation (Placement(transformation(extent={{40,-20},
                {20,0}})));
      MultiBody.Visualizers.FixedArrow prism(
        color={255,0,0},
        length=0.3,
        n={0,0,1}) annotation (Placement(transformation(extent={{0,-60},{-20,-40}})));
    equation
      connect(world.frame_b, jointSSR.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}));
      connect(jointSSR.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}));
      connect(rRod2.frame_a, jointSSR.frame_ib) annotation (Line(points={{40,-10},
              {56,-10},{56,58},{-2,58},{-2,40}}));
      connect(prism.frame_a, jointSSR.frame_b) annotation (Line(points={{0,-50},
              {10,-50},{10,30},{0,30}}));
      annotation (experiment(StopTime=1.1));
    end JointSSR;

    model JointUSR
      extends Modelica.Icons.Example;

      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Parts.Fixed Fixed1(animation=false, r={1.5,
            0.1,0}) annotation (Placement(transformation(extent={{40,20},{20,40}})));
      MultiBody.Joints.Assemblies.JointUSR jointUSR(rRod1_ia=
           rRod1_ia, rRod2_ib=rRod2_ib) annotation (Placement(transformation(
              extent={{-20,20},{0,40}})));
      MultiBody.Visualizers.FixedArrow n1_a(
        length=0.5,
        color={0,0,200},
        n={0,0,1}) annotation (Placement(transformation(extent={{-46,60},{-26,
                80}})));
      MultiBody.Visualizers.FixedArrow n2_ia(
        length=0.5,
        n=jointUSR.e2_ia,
        color={0,128,0}) annotation (Placement(transformation(extent={{-20,60},
                {0,80}})));
      MultiBody.Visualizers.FixedArrow rRod1(
        r_tail={0,-0.1,0},
        n=rRod1_ia,
        length=Modelica.Math.Vectors.length(rRod1_ia)) annotation (Placement(
            transformation(extent={{-20,-20},{0,0}})));
      MultiBody.Visualizers.FixedArrow rRod2(
        r_tail={0,-0.1,0},
        n=rRod2_ib,
        length=Modelica.Math.Vectors.length(rRod2_ib)) annotation (Placement(
            transformation(extent={{40,-20},{20,0}})));
      MultiBody.Visualizers.FixedArrow prism(
        color={255,0,0},
        n={0,0,1},
        length=0.3) annotation (Placement(transformation(extent={{0,-60},{-20,-40}})));
    equation
      connect(world.frame_b, jointUSR.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}));
      connect(jointUSR.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}));
      connect(jointUSR.frame_a, n1_a.frame_a) annotation (Line(points={{-20,30},
              {-32,30},{-32,54},{-50,54},{-50,70},{-46,70}}));
      connect(n2_ia.frame_a, jointUSR.frame_ia) annotation (Line(points={{-20,
              70},{-24,70},{-24,46},{-18,46},{-18,40}}));
      connect(jointUSR.frame_ia, rRod1.frame_a) annotation (Line(points={{-18,
              40},{-26,40},{-26,-10},{-20,-10}}));
      connect(rRod2.frame_a, jointUSR.frame_ib) annotation (Line(points={{40,-10},
              {56,-10},{56,58},{-2,58},{-2,40}}));
      connect(prism.frame_a, jointUSR.frame_b) annotation (Line(points={{0,-50},
              {10,-50},{10,30},{0,30}}));
      annotation (experiment(StopTime=1.1));
    end JointUSR;

    model JointRRR
      extends Modelica.Icons.Example;

      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Parts.Fixed Fixed1(animation=false, r={1.5,
            0.1,0}) annotation (Placement(transformation(extent={{40,20},{20,40}})));
      MultiBody.Joints.Assemblies.JointRRR jointRRR(rRod1_ia=
           rRod1_ia, rRod2_ib=rRod2_ib) annotation (Placement(transformation(
              extent={{-20,20},{0,40}})));
      MultiBody.Visualizers.FixedArrow n1_a(
        n={0,0,1},
        length=0.4,
        color={255,0,0}) annotation (Placement(transformation(extent={{-46,60},
                {-26,80}})));
      MultiBody.Visualizers.FixedArrow rRod1(
        r_tail={0,-0.1,0},
        n=rRod1_ia,
        length=Modelica.Math.Vectors.length(rRod1_ia)) annotation (Placement(
            transformation(extent={{-20,-20},{0,0}})));
      MultiBody.Visualizers.FixedArrow rRod2(
        r_tail={0,-0.1,0},
        n=rRod2_ib,
        length=Modelica.Math.Vectors.length(rRod2_ib)) annotation (Placement(
            transformation(extent={{40,-20},{20,0}})));
      MultiBody.Visualizers.FixedArrow prism(
        n={0,0,1},
        length=0.4,
        color={255,0,0}) annotation (Placement(transformation(extent={{0,-60},{
                -20,-40}})));
      MultiBody.Visualizers.FixedArrow n1_a1(
        n={0,0,1},
        length=0.4,
        color={255,0,0}) annotation (Placement(transformation(extent={{-10,66},
                {10,86}})));
    equation
      connect(world.frame_b, jointRRR.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}));
      connect(jointRRR.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}));
      connect(jointRRR.frame_a, n1_a.frame_a) annotation (Line(points={{-20,30},
              {-32,30},{-32,54},{-50,54},{-50,70},{-46,70}}));
      connect(jointRRR.frame_ia, rRod1.frame_a) annotation (Line(points={{-18,
              40},{-26,40},{-26,-10},{-20,-10}}));
      connect(rRod2.frame_a, jointRRR.frame_ib) annotation (Line(points={{40,-10},
              {56,-10},{56,58},{-2,58},{-2,40}}));
      connect(prism.frame_a, jointRRR.frame_b) annotation (Line(points={{0,-50},
              {10,-50},{10,30},{0,30}}));
      connect(n1_a1.frame_a, jointRRR.frame_im) annotation (Line(
          points={{-10,76},{-10,76},{-10,40}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end JointRRR;

    model JointRRP
      extends Modelica.Icons.Example;

      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Parts.Fixed Fixed1(animation=false, r={1.7,
            0.1,0}) annotation (Placement(transformation(extent={{40,20},{20,40}})));
      MultiBody.Joints.Assemblies.JointRRP jointRRP(rRod1_ia=
           rRod1_ia, rRod2_ib=rRod2_ib) annotation (Placement(transformation(
              extent={{-20,20},{0,40}})));
      MultiBody.Visualizers.FixedArrow n1_a(
        n={0,0,1},
        length=0.4,
        color={255,0,0}) annotation (Placement(transformation(extent={{-46,60},
                {-26,80}})));
      MultiBody.Visualizers.FixedArrow n2_ia(
        n=jointRRP.e_im,
        length=0.4,
        color={255,0,0}) annotation (Placement(transformation(extent={{-20,60},
                {0,80}})));
      MultiBody.Visualizers.FixedArrow rRod1(
        r_tail={0,-0.1,0},
        n=rRod1_ia,
        length=Modelica.Math.Vectors.length(rRod1_ia)) annotation (Placement(
            transformation(extent={{-20,-20},{0,0}})));
      MultiBody.Visualizers.FixedArrow rRod2(
        r_tail={0,-0.1,0},
        n=rRod2_ib,
        length=Modelica.Math.Vectors.length(rRod2_ib)) annotation (Placement(
            transformation(extent={{40,-20},{20,0}})));
      MultiBody.Visualizers.FixedArrow prism(
        r_tail={0,-0.1,0},
        n={-1,0,0},
        color={255,0,0},
        length=0.4) annotation (Placement(transformation(extent={{0,-60},{-20,-40}})));
    equation
      connect(world.frame_b, jointRRP.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}));
      connect(jointRRP.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}));
      connect(jointRRP.frame_a, n1_a.frame_a) annotation (Line(points={{-20,30},
              {-32,30},{-32,54},{-50,54},{-50,70},{-46,70}}));
      connect(jointRRP.frame_ia, rRod1.frame_a) annotation (Line(points={{-18,
              40},{-26,40},{-26,-10},{-20,-10}}));
      connect(rRod2.frame_a, jointRRP.frame_ib) annotation (Line(points={{40,-10},
              {56,-10},{56,58},{-2,58},{-2,40}}));
      connect(prism.frame_a, jointRRP.frame_b) annotation (Line(points={{0,-50},
              {10,-50},{10,30},{0,30}}));
      connect(jointRRP.frame_im, n2_ia.frame_a) annotation (Line(
          points={{-10,40},{-10,55.5},{-20,55.5},{-20,70}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end JointRRP;

    model JointSSP
      extends Modelica.Icons.Example;

      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real L=Modelica.Math.Vectors.length(rRod1_ia);
      parameter Real rRod2_ib[3]={-0.52,0.2,0};
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-60,
                20},{-40,40}})));
      MultiBody.Parts.Fixed Fixed1(animation=false, r={1.5,
            0.1,0}) annotation (Placement(transformation(extent={{40,20},{20,40}})));
      MultiBody.Joints.Assemblies.JointSSP jointSSP(
        rRod2_ib=rRod2_ib,
        rod1Mass=1,
        rod1Length=L,
        n_b={0,0,1},
        s_guess=-10) annotation (Placement(transformation(extent={{-20,20},{0,
                40}})));
      MultiBody.Visualizers.FixedArrow rRod2(
        n=rRod2_ib,
        length=Modelica.Math.Vectors.length(rRod2_ib),
        r_tail={0.05,0.1,0}) annotation (Placement(transformation(extent={{40,-20},
                {20,0}})));
      MultiBody.Visualizers.FixedArrow prism(
        color={255,0,0},
        length=0.3,
        n={0,0,1}) annotation (Placement(transformation(extent={{0,-60},{-20,-40}})));
    equation
      connect(world.frame_b, jointSSP.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}));
      connect(jointSSP.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}));
      connect(rRod2.frame_a, jointSSP.frame_ib) annotation (Line(points={{40,-10},
              {56,-10},{56,58},{-2,58},{-2,40}}));
      connect(prism.frame_a, jointSSP.frame_b) annotation (Line(points={{0,-50},
              {10,-50},{10,30},{0,30}}));
      annotation (experiment(StopTime=1.1));
    end JointSSP;

    model CheckConstaintTorqueUniversalJoint
      extends Modelica.Icons.Example;

      inner MultiBody.World world
        annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
      MultiBody.Parts.BodyCylinder bodyCylinder(r={1,0,0})
        annotation (Placement(transformation(extent={{20,10},{40,30}})));
      MultiBody.Forces.WorldTorque torque
        annotation (Placement(transformation(extent={{-20,-40},{0,-60}})));
      Modelica.Blocks.Sources.Constant signalTorque_y(k=3)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      Modelica.Blocks.Sources.Constant signalTorque_x(k=2)
        annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
      Modelica.Blocks.Sources.Constant signalTorque_z(k=4)
        annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
      MultiBody.Joints.Universal universal(
        phi_a(fixed=true),
        phi_b(fixed=true),
        w_a(fixed=true),
        w_b(fixed=true))
        annotation (Placement(transformation(extent={{-46,10},{-26,30}})));
    equation
      connect(torque.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{0,-50},{10,-50},{10,20},{20,20}},
          color={95,95,95},
          thickness=0.5));
      connect(signalTorque_x.y, torque.torque[1]) annotation (Line(
          points={{-39,-20},{-30,-20},{-30,-48.6667},{-22,-48.6667}}, color={0,0,127}));
      connect(signalTorque_y.y, torque.torque[2]) annotation (Line(
          points={{-39,-50},{-22,-50}}, color={0,0,127}));
      connect(signalTorque_z.y, torque.torque[3]) annotation (Line(
          points={{-39,-80},{-30,-80},{-30,-51.3333},{-22,-51.3333}}, color={0,0,127}));
      connect(world.frame_b, universal.frame_a) annotation (Line(
          points={{-80,20},{-46,20}},
          color={95,95,95},
          thickness=0.5));
      connect(universal.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{-26,20},{20,20}},
          color={95,95,95},
          thickness=0.5));
      annotation(experiment(StopTime=1.0));
    end CheckConstaintTorqueUniversalJoint;

    model Revolute2
      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-90,
                20},{-70,40}})));
      MultiBody.Visualizers.FixedArrow axis(
        length=0.5,
        n={0,0,1}) annotation (Placement(transformation(extent={{10,60},{30,80}})));
      MultiBody.Joints.Revolute revolute(
        n={0,0,1},
        cylinderDiameter=1/15,
        w(fixed=true, start=2),
        phi(fixed=true, start=0.78539816339745)) annotation (Placement(
            transformation(extent={{-20,20},{0,40}})));
      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1,
        I_11=0.1,
        I_22=0.1,
        I_33=0.1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Visualizers.FixedFrame frame_a1(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Joints.Revolute revolute1(
        n={0,0,1},
        cylinderDiameter=1/15,
        useAxisFlange=true,
        phi(fixed=true, start=0.78539816339745)) annotation (Placement(
            transformation(extent={{-22,-48},{-2,-28}})));
      MultiBody.Parts.Body body1(
        animation=false,
        r_CM={0,0,0},
        m=1,
        I_11=0.1,
        I_22=0.1,
        I_33=0.1) annotation (Placement(transformation(extent={{20,-48},{40,-28}})));
      Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
          useSupport=true, w_fixed=2)
        annotation (Placement(transformation(extent={{-88,-34},{-68,-14}})));
      MultiBody.Joints.Revolute revolute2(
        cylinderDiameter=1/15,
        a(fixed=false),
        useAxisFlange=true,
        w(fixed=true, start=4),
        n={1,0,0},
        phi(fixed=true, start=0.78539816339745)) annotation (Placement(
            transformation(extent={{54,-130},{74,-110}})));
      MultiBody.Parts.Body body2(
        animation=false,
        r_CM={0,0,0},
        m=1,
        I_11=0.5,
        I_22=0,
        I_33=0) annotation (Placement(transformation(extent={{88,-130},{108,-110}})));
      MultiBody.Joints.Revolute revolute3(
        cylinderDiameter=1/15,
        a(fixed=false),
        useAxisFlange=true,
        phi(fixed=true, start=0),
        n={1,0,0},
        w(start=20, fixed=true)) annotation (Placement(transformation(extent={{
                -32,-130},{-12,-110}})));
      Modelica.Mechanics.Rotational.Components.Damper damper(d=0.6)
        annotation (Placement(transformation(extent={{12,-96},{32,-76}})));
      MultiBody.Parts.BodyCylinder bodyCylinder(
        density=2.5e4,
        diameter=0.2,
        r={1,0,0})
        annotation (Placement(transformation(extent={{14,-130},{34,-110}})));
    equation
      assert(revolute.phi - revolute1.phi < tol,
        "Angles of joints must be equal");
      assert(revolute.w - revolute1.w < tol, "Angles of joints must be equal");
      connect(world.frame_b, revolute.frame_a) annotation (Line(
          points={{-70,30},{-20,30}},
          thickness=0.5));
      connect(revolute.frame_b, body.frame_a) annotation (Line(
          points={{0,30},{10,30},{20,30}},
          thickness=0.5));
      connect(revolute.frame_b, axis.frame_a) annotation (Line(
          points={{0,30},{4,30},{4,70},{10,70}},
          thickness=0.5));
      connect(frame_a.frame_a, revolute.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-20,30}},
          thickness=0.5));
      connect(frame_a1.frame_a, revolute.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{0,30}},
          thickness=0.5));
      connect(revolute1.frame_a, world.frame_b) annotation (Line(
          points={{-22,-38},{-46,-38},{-46,30},{-70,30}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute1.frame_b, body1.frame_a) annotation (Line(
          points={{-2,-38},{20,-38}},
          color={95,95,95},
          thickness=0.5));
      connect(constantSpeed.support, revolute1.support) annotation (Line(
          points={{-78,-34},{-78,-28},{-18,-28}}));
      connect(constantSpeed.flange, revolute1.axis) annotation (Line(
          points={{-68,-24},{-12,-24},{-12,-28}}));
      connect(body2.frame_a, revolute2.frame_b) annotation (Line(
          points={{88,-120},{74,-120}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute3.axis, damper.flange_a) annotation (Line(
          points={{-22,-110},{-20,-110},{-20,-86},{12,-86}}));
      connect(revolute3.frame_a, world.frame_b) annotation (Line(
          points={{-32,-120},{-46,-120},{-46,30},{-70,30}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute3.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{-12,-120},{14,-120}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyCylinder.frame_b, revolute2.frame_a) annotation (Line(
          points={{34,-120},{54,-120}},
          color={95,95,95},
          thickness=0.5));
      connect(damper.flange_b, revolute2.axis) annotation (Line(
          points={{32,-86},{64,-86},{64,-110}}));
      annotation (experiment(StopTime=1.1), Diagram(coordinateSystem(extent={{-100,
                -140},{120,100}}, preserveAspectRatio=true)));
    end Revolute2;

    model RevolutePlanarLoopConstraint
      extends Modelica.Icons.Example;
      parameter Real tor=1000;
      Real k;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-160,
                40},{-140,60}})));
      MultiBody.Joints.RevolutePlanarLoopConstraint revolute(
          n={0,1,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={6,-6})));
      MultiBody.Joints.Revolute revolute1(n={0,1,0},
          useAxisFlange=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={8,52})));
      MultiBody.Joints.Revolute revolute3(
        n={0,1,0},
        phi(fixed=true, start=1.5707963267949),
        w(fixed=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={82,52})));
      MultiBody.Joints.Revolute revolute4(n={0,1,0}, phi(
            start=1.5707963267949)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={76,-6})));
      MultiBody.Parts.BodyCylinder bodyCylinder(r={1,0,0},
          diameter=0.2)
        annotation (Placement(transformation(extent={{36,42},{56,62}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque
        annotation (Placement(transformation(extent={{-14,74},{6,94}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=k)
        annotation (Placement(transformation(extent={{-46,74},{-26,94}})));
      MultiBody.Parts.BodyCylinder bodyCylinder1(r={1,0,0},
          diameter=0.2) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={106,20})));
      MultiBody.Parts.BodyCylinder bodyCylinder2(r={1,0,0},
          diameter=0.2) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={42,-6})));
      MultiBody.Parts.BodyCylinder bodyCylinder3(r={1,0,0},
          diameter=0.2) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,22})));
      MultiBody.Joints.Revolute revolute2(
        n={1,0,0},
        phi(fixed=true, start=0),
        w(fixed=true, start=2*Modelica.Constants.pi))
        annotation (Placement(transformation(extent={{-122,40},{-102,60}})));
      MultiBody.Parts.FixedRotation fixedRotation(n={0,1,0},
          angle=90)
        annotation (Placement(transformation(extent={{-86,40},{-66,60}})));
      MultiBody.Parts.FixedRotation fixedRotation1(angle=45,
          n={0,0,1})
        annotation (Placement(transformation(extent={{-52,40},{-32,60}})));
    equation
      if (time < 1) then
        k = tor;
      else
        k = 0;
      end if;
      connect(revolute1.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{18,52},{36,52}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyCylinder.frame_b, revolute3.frame_a) annotation (Line(
          points={{56,52},{72,52}},
          color={95,95,95},
          thickness=0.5));
      connect(torque.flange, revolute1.axis) annotation (Line(
          points={{6,84},{6,62},{8,62}}));
      connect(realExpression.y, torque.tau) annotation (Line(
          points={{-25,84},{-16,84}}, color={0,0,127}));
      connect(revolute3.frame_b, bodyCylinder1.frame_a) annotation (Line(
          points={{92,52},{102,52},{102,30},{106,30}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyCylinder1.frame_b, revolute4.frame_a) annotation (Line(
          points={{106,10},{98,10},{98,-6},{86,-6}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute4.frame_b, bodyCylinder2.frame_a) annotation (Line(
          points={{66,-6},{62.5,-6},{62.5,-6},{59,-6},{59,-6},{52,-6}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyCylinder2.frame_b, revolute.frame_a) annotation (Line(
          points={{32,-6},{28,-6},{28,-6},{24,-6},{24,-6},{16,-6}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute.frame_b, bodyCylinder3.frame_a) annotation (Line(
          points={{-4,-6},{-12,-6},{-12,12},{-20,12}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyCylinder3.frame_b, revolute1.frame_a) annotation (Line(
          points={{-20,32},{-12,32},{-12,52},{-2,52}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, revolute2.frame_a) annotation (Line(
          points={{-140,50},{-122,50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation.frame_b, fixedRotation1.frame_a) annotation (Line(
          points={{-66,50},{-52,50}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute2.frame_b, fixedRotation.frame_a) annotation (Line(
          points={{-102,50},{-86,50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation1.frame_b, revolute1.frame_a) annotation (Line(
          points={{-32,50},{-18,50},{-18,52},{-2,52}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=5), Diagram(coordinateSystem(extent={{-160,
                -40},{120,100}}, preserveAspectRatio=true)));
    end RevolutePlanarLoopConstraint;

    model FreeMotion2
      extends Modelica.Icons.Example;
      parameter Real tol=1e-4;
      inner MultiBody.World world(animateWorld=true,
          animateGravity=true) annotation (Placement(transformation(extent={{-100,
                0},{-80,20}})));
      MultiBody.Joints.FreeMotion freeMotion(
        z_rel_a_fixed=false,
        a_rel_a(each fixed=false),
        angles_fixed=false,
        w_rel_a_fixed=false,
        r_rel_a(each fixed=false),
        enforceStates=false) annotation (Placement(transformation(extent={{60,0},
                {40,20}})));

      MultiBody.Parts.Fixed fixed(r={1,0,0}, animation=false)
        annotation (Placement(transformation(extent={{96,0},{76,20}})));
      MultiBody.Parts.BodyBox bodyBox(r={0.5,0,0})
        annotation (Placement(transformation(extent={{-4,0},{16,20}})));
      MultiBody.Joints.Prismatic prismatic(
        useAxisFlange=true,
        s(fixed=true, start=0.3),
        v(fixed=true, start=0.1),
        stateSelect=StateSelect.never)
        annotation (Placement(transformation(extent={{-64,0},{-44,20}})));
      MultiBody.Joints.Universal universal(
        phi_a(fixed=true),
        phi_b(fixed=true),
        w_a(fixed=true, start=0.3),
        w_b(fixed=true, start=0.3))
        annotation (Placement(transformation(extent={{-34,0},{-14,20}})));
      Modelica.Mechanics.Translational.Components.Spring spring(c=10, s_rel0=
            0.3)
        annotation (Placement(transformation(extent={{-64,26},{-44,46}})));
      MultiBody.Parts.BodyBox bodyBox1(r={0.5,0,0})
        annotation (Placement(transformation(extent={{-4,-62},{16,-42}})));
      MultiBody.Joints.Prismatic prismatic1(
        useAxisFlange=true,
        s(fixed=true, start=0.3),
        v(fixed=true, start=0.1))
        annotation (Placement(transformation(extent={{-64,-62},{-44,-42}})));
      MultiBody.Joints.Universal universal1(
        phi_a(fixed=true),
        phi_b(fixed=true),
        w_a(fixed=true, start=0.3),
        w_b(fixed=true, start=0.3))
        annotation (Placement(transformation(extent={{-34,-62},{-14,-42}})));
      Modelica.Mechanics.Translational.Components.Spring spring1(c=10,s_rel0=
            0.3)
        annotation (Placement(transformation(extent={{-64,-36},{-44,-16}})));
    equation
      assert(bodyBox1.frame_b.r_0[1] - freeMotion.r_rel_a[1] - 1 < tol and
        bodyBox1.frame_b.r_0[2] - freeMotion.r_rel_a[2] < tol and bodyBox1.frame_b.r_0
        [3] - freeMotion.r_rel_a[3] < tol, "Position of bodies must be equal");
      assert(prismatic.s - prismatic1.s < tol,
        "Position of bodies must be equal");

      connect(freeMotion.frame_a, fixed.frame_b) annotation (Line(
          points={{60,10},{76,10}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox.frame_b, freeMotion.frame_b) annotation (Line(
          points={{16,10},{40,10}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic.frame_b, universal.frame_a) annotation (Line(
          points={{-44,10},{-34,10}},
          color={95,95,95},
          thickness=0.5));
      connect(universal.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-14,10},{-4,10}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic.frame_a, world.frame_b) annotation (Line(
          points={{-64,10},{-80,10}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic.support, spring.flange_a) annotation (Line(
          points={{-58,16},{-64,16},{-64,36}}, color={0,127,0}));
      connect(prismatic.axis, spring.flange_b) annotation (Line(
          points={{-46,16},{-44,16},{-44,36}}, color={0,127,0}));
      connect(prismatic1.frame_b, universal1.frame_a) annotation (Line(
          points={{-44,-52},{-34,-52}},
          color={95,95,95},
          thickness=0.5));
      connect(universal1.frame_b, bodyBox1.frame_a) annotation (Line(
          points={{-14,-52},{-4,-52}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic1.frame_a, world.frame_b) annotation (Line(
          points={{-64,-52},{-77,-52},{-77,10},{-80,10}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic1.support, spring1.flange_a) annotation (Line(
          points={{-58,-46},{-64,-46},{-64,-26}}, color={0,127,0}));
      connect(prismatic1.axis, spring1.flange_b) annotation (Line(
          points={{-46,-46},{-44,-46},{-44,-26}}, color={0,127,0}));
      annotation (experiment(StopTime=2, Tolerance=1e-006));
    end FreeMotion2;

    model SphericalSpherical2
      extends Modelica.Icons.Example;
      parameter Real tol1=1e-4;
      parameter Real tol2=1e-3;

      Modelica.Blocks.Interfaces.RealOutput r1[3]
        "Relative position vector frame_b.r_0 - frame_a.r_0 resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(extent={{62,40},{42,60}})));
      Modelica.Blocks.Interfaces.RealOutput r2[3]
        "Relative position vector frame_b.r_0 - frame_a.r_0 resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(extent={{62,-50},{42,-30}})));
      Modelica.Blocks.Interfaces.RealOutput r3[3]
        "Relative position vector frame_b.r_0 - frame_a.r_0 resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(extent={{100,0},{80,20}})));

      inner MultiBody.World world(animateWorld=true,
          animateGravity=true) annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
      MultiBody.Joints.SphericalSpherical sphericalSpherical(
        m=3,
        kinematicConstraint=false,
        rodLength=1) annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
      MultiBody.Joints.Spherical spherical
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      MultiBody.Parts.FixedTranslation fixedTranslation(r={
            0.5,0,0})
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      MultiBody.Parts.FixedTranslation fixedTranslation1(r={
            0.5,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      MultiBody.Sensors.RelativeSensor rs1(
        final get_r_rel=true,
        get_v_rel=true,
        get_w_rel=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,40})));
      MultiBody.Parts.BodyBox bodyBox(
        r={0.5,0,0},
        width=0.1,
        height=0.1,
        angles_fixed=true,
        w_0_fixed=true,
        w_0_start={1,0,0},
        r_0(start={1,0,0}))
        annotation (Placement(transformation(extent={{40,70},{60,90}})));
      MultiBody.Joints.Spherical spherical1
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      MultiBody.Parts.BodyBox bodyBox1(
        r={0.5,0,0},
        width=0.1,
        height=0.1,
        angles_fixed=true,
        w_0_fixed=true,
        w_0_start={1,0,0})
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));
      MultiBody.Parts.Body body(
        r_CM={0,0,0},
        m=3,
        angles_fixed=true,
        w_0_fixed=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-20,-20})));
      MultiBody.Joints.SphericalSpherical
        sphericalSpherical1(
        m=3,
        computeRodLength=true,
        kinematicConstraint=true) annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
      MultiBody.Parts.BodyBox bodyBox2(
        r={0.5,0,0},
        width=0.1,
        height=0.1,
        v_0(start={0,0,0}),
        angles_fixed=true,
        w_0_fixed=true,
        r_0(start={1,0,0}, each fixed=true),
        w_0_start={1,0,0})
        annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
      MultiBody.Sensors.RelativeSensor rs2(
        final get_r_rel=true,
        get_v_rel=true,
        get_w_rel=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,-50})));
      MultiBody.Sensors.RelativeSensor rs3(
        final get_r_rel=true,
        get_v_rel=true,
        get_w_rel=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={120,0})));
      MultiBody.Joints.FreeMotionScalarInit
        freeMotionScalarInit(
        use_r=true,
        r_rel_a_2(fixed=true),
        r_rel_a_3(fixed=true),
        use_v=true,
        v_rel_a_2(fixed=true),
        v_rel_a_3(fixed=true))
        annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
      MultiBody.Joints.FreeMotionScalarInit
        freeMotionScalarInit1(
        use_r=true,
        use_v=true,
        v_rel_a_2(fixed=true),
        v_rel_a_3(fixed=true))
        annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
    equation
      assert(r1[1] < tol2 and r1[2] < tol2 and r1[3] < tol2,
        "Difference in positions between bodies is too much");
      assert(r2[1] < tol2 and r2[2] < tol2 and r2[3] < tol2,
         "Difference in positions between bodies is too much");
      assert(r3[1] < tol1 and r3[2] < tol1 and r3[3] < tol1,
        "Difference in positions between bodies is too much");
      connect(world.frame_b, sphericalSpherical.frame_a)
        annotation (Line(
          points={{-100,30},{-90,30},{-90,80},{-30,80}},
          color={95,95,95},
          thickness=0.5));
      connect(spherical.frame_a, world.frame_b) annotation (Line(
          points={{-80,0},{-90,0},{-90,30},{-100,30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_a, spherical.frame_b) annotation (Line(
          points={{-50,0},{-60,0}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation1.frame_b, spherical1.frame_a) annotation (Line(
          points={{10,0},{20,0}},
          color={95,95,95},
          thickness=0.5));
      connect(spherical1.frame_b, bodyBox1.frame_a) annotation (Line(
          points={{40,0},{50,0}},
          color={95,95,95},
          thickness=0.5));
      connect(sphericalSpherical.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-10,80},{40,80}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox.frame_b, rs1.frame_a) annotation (Line(
          points={{60,80},{80,80},{80,50}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox1.frame_b, rs1.frame_b) annotation (Line(
          points={{70,0},{80,0},{80,30}},
          color={95,95,95},
          thickness=0.5));
      connect(body.frame_a, fixedTranslation.frame_b) annotation (Line(
          points={{-20,-10},{-20,0},{-30,0}},
          color={95,95,95},
          thickness=0.5));
      connect(body.frame_a, fixedTranslation1.frame_a) annotation (Line(
          points={{-20,-10},{-20,0},{-10,0}},
          color={95,95,95},
          thickness=0.5));
      connect(sphericalSpherical1.frame_a, world.frame_b) annotation (Line(
          points={{-30,-80},{-90,-80},{-90,30},{-100,30}},
          color={95,95,95},
          thickness=0.5));
      connect(sphericalSpherical1.frame_b, bodyBox2.frame_a) annotation (Line(
          points={{-10,-80},{40,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox2.frame_b, rs2.frame_b) annotation (Line(
          points={{60,-80},{80,-80},{80,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox1.frame_b, rs2.frame_a) annotation (Line(
          points={{70,0},{80,0},{80,-40}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox.frame_b, rs3.frame_a) annotation (Line(
          points={{60,80},{120,80},{120,10}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox2.frame_b, rs3.frame_b) annotation (Line(
          points={{60,-80},{120,-80},{120,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(freeMotionScalarInit.frame_a, world.frame_b) annotation (Line(
          points={{-30,50},{-50,50},{-50,80},{-90,80},{-90,30},{-100,30}},
          color={95,95,95},
          thickness=0.5));
      connect(freeMotionScalarInit.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-10,50},{10,50},{10,80},{40,80}},
          color={95,95,95},
          thickness=0.5));
      connect(freeMotionScalarInit1.frame_a, world.frame_b) annotation (Line(
          points={{-30,-50},{-50,-50},{-50,-80},{-90,-80},{-90,30},{-100,30}},
          color={95,95,95},
          thickness=0.5));
      connect(freeMotionScalarInit1.frame_b, bodyBox2.frame_a) annotation (Line(
          points={{-10,-50},{10,-50},{10,-80},{40,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(rs1.r_rel, r1) annotation (Line(
          points={{69,50},{52,50}}, color={0,0,127}));
      connect(rs2.r_rel, r2) annotation (Line(
          points={{69,-40},{52,-40}}, color={0,0,127}));
      connect(rs3.r_rel, r3) annotation (Line(
          points={{109,10},{90,10}},  color={0,0,127}));
      annotation (experiment(StopTime=2, Tolerance=1e-006), Diagram(
            coordinateSystem(extent={{-120,-100},{140,100}},
              preserveAspectRatio=false)));
    end SphericalSpherical2;

    model UniversalSpherical
      extends Modelica.Icons.Example;
      parameter Real tol1=1e-4;
      parameter Real tol2=1e-3;

      Modelica.Blocks.Interfaces.RealOutput r1[3]
        "Relative position vector frame_b.r_0 - frame_a.r_0 resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(extent={{30,40},{10,60}})));
      Modelica.Blocks.Interfaces.RealOutput r2[3]
        "Relative position vector frame_b.r_0 - frame_a.r_0 resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(extent={{30,-50},{10,-30}})));
      Modelica.Blocks.Interfaces.RealOutput r3[3]
        "Relative position vector frame_b.r_0 - frame_a.r_0 resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(extent={{70,0},{50,20}})));

      inner MultiBody.World world(animateWorld=true,
          animateGravity=true) annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
      MultiBody.Parts.FixedTranslation fixedTranslation(r={-1,
            0,0})
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      MultiBody.Sensors.RelativeSensor rs1(
        final get_r_rel=true,
        get_v_rel=true,
        get_w_rel=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={50,40})));
      MultiBody.Parts.BodyBox bodyBox(
        r={0.5,0,0},
        width=0.1,
        height=0.1,
        r_0(start = {1, 0, 0}),
        angles_fixed=true,
        w_0_fixed=true,
        w_0_start={0,0,0})
        annotation (Placement(transformation(extent={{10,70},{30,90}})));
      MultiBody.Joints.Spherical spherical1
        annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      MultiBody.Parts.BodyBox bodyBox1(
        r={0.5,0,0},
        width=0.1,
        height=0.1,
        w_0_start={0,0,0},
        angles_fixed=true,
        w_0_fixed=true)
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));
      MultiBody.Parts.BodyBox bodyBox2(
        r={0.5,0,0},
        width=0.1,
        height=0.1,
        v_0(start={0,0,0}),
        angles_fixed=true,
        w_0_fixed=true,
        r_0(start={1,0,0}, each fixed=true),
        w_0_start={0,0,0})
        annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
      MultiBody.Sensors.RelativeSensor rs2(
        final get_r_rel=true,
        get_v_rel=true,
        get_w_rel=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={50,-50})));
      MultiBody.Sensors.RelativeSensor rs3(
        final get_r_rel=true,
        get_v_rel=true,
        get_w_rel=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={90,0})));
      MultiBody.Joints.UniversalSpherical universalSpherical(
          kinematicConstraint=false)
        annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
      MultiBody.Joints.UniversalSpherical
        universalSpherical1(computeRodLength=true)
        annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
      MultiBody.Joints.Universal universal(
        w_a(fixed=true),
        w_b(fixed=true),
        n_a={0,0,1},
        n_b={0,1,0},
        phi_a(fixed=true, start=0),
        phi_b(fixed=true, start=3.1415926535898))
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      MultiBody.Joints.FreeMotionScalarInit init(
        use_r=true,
        use_v=true,
        v_rel_a_2(fixed=true),
        v_rel_a_3(fixed=true),
        r_rel_a_2(fixed=true),
        r_rel_a_3(fixed=true))
        annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
      MultiBody.Joints.FreeMotionScalarInit init2(
        use_r=true,
        use_v=true,
        v_rel_a_2(fixed=true),
        v_rel_a_3(fixed=true))
        annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
    equation
      assert(r1[1] < tol2 and r1[2] < tol2 and r1[3] < tol2,
        "Difference in positions between bodies is too much");
      assert(r2[1] < tol2 and r2[2] < tol2 and r2[3] < tol2,
         "Difference in positions between bodies is too much");
      assert(r3[1] < tol1 and r3[2] < tol1 and r3[3] < tol1,
        "Difference in positions between bodies is too much");
      connect(spherical1.frame_b, bodyBox1.frame_a) annotation (Line(
          points={{0,0},{10,0}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox.frame_b, rs1.frame_a) annotation (Line(
          points={{30,80},{50,80},{50,50}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox1.frame_b, rs1.frame_b) annotation (Line(
          points={{30,0},{50,0},{50,30}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox2.frame_b, rs2.frame_b) annotation (Line(
          points={{30,-80},{50,-80},{50,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox1.frame_b, rs2.frame_a) annotation (Line(
          points={{30,0},{50,0},{50,-40}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox.frame_b, rs3.frame_a) annotation (Line(
          points={{30,80},{90,80},{90,10}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox2.frame_b, rs3.frame_b) annotation (Line(
          points={{30,-80},{90,-80},{90,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, universalSpherical.frame_a) annotation (Line(
          points={{-100,30},{-90,30},{-90,80},{-50,80}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, universal.frame_a) annotation (Line(
          points={{-100,30},{-90,30},{-90,0},{-80,0}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, universalSpherical1.frame_a) annotation (Line(
          points={{-100,30},{-90,30},{-90,-80},{-50,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(universalSpherical.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-30,80},{10,80}},
          color={95,95,95},
          thickness=0.5));
      connect(universalSpherical1.frame_b, bodyBox2.frame_a) annotation (Line(
          points={{-30,-80},{10,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(universal.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{-60,0},{-50,0}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_b, spherical1.frame_a) annotation (Line(
          points={{-30,0},{-20,0}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, init.frame_a) annotation (Line(
          points={{-100,30},{-90,30},{-90,80},{-70,80},{-70,50},{-50,50}},
          color={95,95,95},
          thickness=0.5));
      connect(init.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-30,50},{-10,50},{-10,80},{10,80}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, init2.frame_a) annotation (Line(
          points={{-100,30},{-90,30},{-90,-80},{-70,-80},{-70,-50},{-50,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(init2.frame_b, bodyBox2.frame_a) annotation (Line(
          points={{-30,-50},{-10,-50},{-10,-80},{10,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(rs1.r_rel, r1) annotation (Line(
          points={{39,50},{20,50}}, color={0,0,127}));
      connect(rs3.r_rel, r3) annotation (Line(
          points={{79,10},{60,10}},   color={0,0,127}));
      connect(rs2.r_rel, r2) annotation (Line(
          points={{39,-40},{20,-40}},
                                    color={0,0,127}));
      annotation (experiment(StopTime=2, Tolerance=1e-006), Diagram(
            coordinateSystem(extent={{-120,-100},{120,100}},
              preserveAspectRatio=false)));
    end UniversalSpherical;

    model PrismaticInit
      extends Modelica.Icons.Example;
      parameter Real expectedC=87.4862;
      parameter Real tol=1e-4;

      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-66,
                0},{-46,20}})));
      MultiBody.Joints.Prismatic prismatic(
        s(fixed=true, start=0.3),
        n={1,-1,0},
        v(fixed=true, start=0),
        a(start=0, fixed=true)) annotation (Placement(transformation(extent={{-12,
                0},{8,20}})));
      MultiBody.Parts.Body body(
        animation=false,
        r_CM={0,0,0},
        m=1) annotation (Placement(transformation(extent={{50,0},{70,20}})));
      MultiBody.Forces.Spring spring(c(fixed=false, start=20),
          s_unstretched=0.1)
        annotation (Placement(transformation(extent={{24,36},{44,56}})));
      MultiBody.Parts.FixedTranslation fixedTranslation(r={
            sqrt(0.045),0,0})
        annotation (Placement(transformation(extent={{-16,36},{4,56}})));
    equation
      assert(spring.c - expectedC < tol,
        "Expected spring stiffness constant is not equal to the actual constant");
      connect(world.frame_b, prismatic.frame_a) annotation (Line(
          points={{-46,10},{-12,10}},
          thickness=0.5));
      connect(prismatic.frame_b, body.frame_a) annotation (Line(
          points={{8,10},{8,10},{50,10}},
          thickness=0.5));
      connect(body.frame_a, spring.frame_b) annotation (Line(
          points={{50,10},{48,10},{48,46},{44,46}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{-46,10},{-32,10},{-32,46},{-16,46}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_b, spring.frame_a) annotation (Line(
          points={{4,46},{24,46}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=5));
    end PrismaticInit;

    model JointUSP2
      extends Modelica.Icons.Example;
      inner MultiBody.World world(animateWorld=true,
          animateGravity=true) annotation (Placement(transformation(extent={{-80,
                14},{-60,34}})));
      Real k;
      parameter Real tau=10;
      MultiBody.Joints.Assemblies.JointUSP jointUSP(
        n1_a={0,1,0} "y axis",
        rRod1_ia={1,1,0},
        n_b={0,0,1},
        rRod2_ib={-1,1,0}) annotation (Placement(transformation(extent={{-18,40},
                {2,60}})));

      MultiBody.Parts.Body body(m=10, r_CM={0,0,0})
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,82})));
      Modelica.Mechanics.Translational.Components.Spring spring(c=10, s_rel0=
            0.5) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={32,66})));
      MultiBody.Parts.FixedTranslation fixedTranslation(r={2,
            0,0})
        annotation (Placement(transformation(extent={{-38,-16},{-18,4}})));
      MultiBody.Joints.Revolute revolute(phi(fixed=true), w(
            fixed=true))
        annotation (Placement(transformation(extent={{12,-16},{32,4}})));
      MultiBody.Parts.BodyBox bodyBox(r={-1.4141,0,0})
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={44,14})));
    equation
      if (time < 1) then
        k = tau;
      else
        k = 0;
      end if;
      connect(jointUSP.frame_im, body.frame_a) annotation (Line(
          points={{-8,60},{-4,60},{-4,72},{0,72}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, jointUSP.frame_a) annotation (Line(
          points={{-60,24},{-40,24},{-40,50},{-18,50}},
          color={95,95,95},
          thickness=0.5));
      connect(spring.flange_a, jointUSP.axis) annotation (Line(
          points={{32,76},{18,76},{18,58},{2,58}}, color={0,127,0}));
      connect(jointUSP.bearing, spring.flange_b) annotation (Line(
          points={{2,54},{16,54},{16,56},{32,56}}, color={0,127,0}));
      connect(world.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{-60,24},{-50,24},{-50,-6},{-38,-6}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_b, revolute.frame_a) annotation (Line(
          points={{-18,-6},{12,-6}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute.frame_b, bodyBox.frame_a) annotation (Line(
          points={{32,-6},{38,-6},{38,4},{44,4}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox.frame_b, jointUSP.frame_b) annotation (Line(
          points={{44,24},{24,24},{24,50},{2,50}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=4));
    end JointUSP2;

    model JointUPS2
      extends Modelica.Icons.Example;

      MultiBody.Joints.Assemblies.JointUPS jointUPS
        annotation (Placement(transformation(extent={{-4,-28},{32,8}})));
      inner MultiBody.World world(animateWorld=true,
          animateGravity=true) annotation (Placement(transformation(extent={{-60,
                -40},{-40,-20}})));
      MultiBody.Parts.Body body(m=10, r_CM={0,0,0})
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,34})));
      Modelica.Mechanics.Translational.Components.Spring spring(c=10, s_rel0=
            0.5) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={12,26})));
      MultiBody.Parts.FixedTranslation fixedTranslation(r={2,
            0,0})
        annotation (Placement(transformation(extent={{-18,-70},{2,-50}})));
      MultiBody.Parts.BodyBox bodyBox(r={-1.4141,0,0})
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={64,-40})));
      MultiBody.Joints.Universal universal(
        phi_a(fixed=true),
        phi_b(fixed=true),
        w_a(fixed=true, start=2),
        w_b(fixed=true, start=2),
        n_a={0,0,1})
        annotation (Placement(transformation(extent={{22,-74},{42,-54}})));
    equation
      connect(world.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{-40,-30},{-30,-30},{-30,-60},{-18,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, jointUPS.frame_a) annotation (Line(
          points={{-40,-30},{-20,-30},{-20,-10},{-4,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(jointUPS.axis, spring.flange_b) annotation (Line(
          points={{21.2,8},{20,8},{20,26},{22,26}}, color={0,127,0}));
      connect(jointUPS.bearing, spring.flange_a) annotation (Line(
          points={{6.8,8},{6,8},{6,26},{2,26}}, color={0,127,0}));
      connect(jointUPS.frame_ib, body.frame_a) annotation (Line(
          points={{28.4,8},{39.2,8},{39.2,24},{50,24}},
          color={95,95,95},
          thickness=0.5));
      connect(jointUPS.frame_b, bodyBox.frame_b) annotation (Line(
          points={{32,-10},{48,-10},{48,-30},{64,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_b, universal.frame_a) annotation (Line(
          points={{2,-60},{12,-60},{12,-64},{22,-64}},
          color={95,95,95},
          thickness=0.5));
      connect(universal.frame_b, bodyBox.frame_a) annotation (Line(
          points={{42,-64},{54,-64},{54,-50},{64,-50}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=4));
    end JointUPS2;

    model GearConstraint
      extends Modelica.Icons.Example;
      MultiBody.Joints.GearConstraint gearConstraint(
        ratio=10,
        phi_b(fixed=true, start=0),
        w_b(fixed=true, start=0)) annotation (Placement(transformation(extent={
                {34,40},{54,60}})));
      inner MultiBody.World world(driveTrainMechanics3D=true,
          g=0) annotation (Placement(transformation(extent={{-62,10},{-42,30}})));
      MultiBody.Parts.BodyCylinder cyl1(
        diameter=0.1,
        color={0,128,0},
        r={0.4,0,0}) annotation (Placement(transformation(extent={{2,40},{22,60}})));
      MultiBody.Parts.BodyCylinder cyl2(r={0.4,0,0},
          diameter=0.2) annotation (Placement(transformation(extent={{64,20},{
                84,40}})));
      MultiBody.Forces.Torque torque1 annotation (Placement(
            transformation(extent={{-26,40},{-6,60}})));
      Modelica.Blocks.Sources.Sine sine[3](amplitude={2,0,0}, f={1,1,1})
        annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
      MultiBody.Parts.Fixed fixed annotation (Placement(
            transformation(extent={{-48,-90},{-28,-70}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia1(
        J=cyl1.I[1, 1],
        phi(fixed=true, start=0.0),
        w(fixed=true, start=0.0)) annotation (Placement(transformation(extent={
                {-20,-40},{0,-20}})));
      Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio=10,
          useSupport=true) annotation (Placement(transformation(extent={{12,-40},
                {32,-20}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=cyl2.I[1, 1])
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
        annotation (Placement(transformation(extent={{-48,-40},{-28,-20}})));
      MultiBody.Parts.Mounting1D mounting1D annotation (
          Placement(transformation(extent={{-20,-70},{0,-50}})));
      MultiBody.Visualizers.FixedFrame fixedFrame2
        annotation (Placement(transformation(extent={{92,20},{112,40}})));
      MultiBody.Visualizers.FixedFrame fixedFrame1
        annotation (Placement(transformation(extent={{4,70},{24,90}})));
    equation
      connect(cyl1.frame_b, gearConstraint.frame_a) annotation (Line(
          points={{22,50},{34,50}},
          color={95,95,95},
          thickness=0.5));
      connect(torque1.frame_b, cyl1.frame_a) annotation (Line(
          points={{-6,50},{2,50}},
          color={95,95,95},
          thickness=0.5));
      connect(torque1.frame_a, world.frame_b) annotation (Line(
          points={{-26,50},{-36,50},{-36,20},{-42,20}},
          color={95,95,95},
          thickness=0.5));
      connect(sine.y, torque1.torque) annotation (Line(
          points={{-79,70},{-22,70},{-22,62}}, color={0,0,127}));
      connect(inertia1.flange_b, idealGear.flange_a) annotation (Line(
          points={{0,-30},{12,-30}}));
      connect(torque2.flange, inertia1.flange_a) annotation (Line(
          points={{-28,-30},{-20,-30}}));
      connect(sine[1].y, torque2.tau) annotation (Line(
          points={{-79,70},{-72,70},{-72,-30},{-50,-30}}, color={0,0,127}));
      connect(mounting1D.flange_b, torque2.support) annotation (Line(
          points={{0,-60},{4,-60},{4,-48},{-38,-48},{-38,-40}}));
      connect(fixed.frame_b, mounting1D.frame_a) annotation (Line(
          points={{-28,-80},{-10,-80},{-10,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, gearConstraint.frame_b) annotation (Line(
          points={{-42,20},{60,20},{60,50},{54,50}},
          color={95,95,95},
          thickness=0.5));
      connect(cyl2.frame_a, gearConstraint.bearing) annotation (Line(
          points={{64,30},{44,30},{44,40}},
          color={95,95,95},
          thickness=0.5));
      connect(mounting1D.flange_b, idealGear.flange_b) annotation (Line(
          points={{0,-60},{38,-60},{38,-30},{32,-30}}));
      connect(inertia2.flange_a, idealGear.support) annotation (Line(
          points={{60,-50},{22,-50},{22,-40}}));
      connect(cyl2.frame_b, fixedFrame2.frame_a) annotation (Line(
          points={{84,30},{92,30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedFrame1.frame_a, cyl1.frame_a) annotation (Line(
          points={{4,80},{2,80},{2,50}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=5));
    end GearConstraint;
  end Joints;

  package Parts "Test MultiBody.Parts"
    extends Modelica.Icons.ExamplesPackage;
    model FixedTranslation

      import Modelica.Mechanics.MultiBody.Visualizers;
      extends Modelica.Icons.Example;
      parameter SI.Length length=0.5 "Length of axes of frames";
      parameter SI.Diameter diameter=length/30 "Diameter of frame axes";
      MultiBody.Frames.Orientation R;
      MultiBody.Parts.FixedTranslation fixedTranslation(r={1,
            0.5,0}) annotation (Placement(transformation(extent={{10,0},{30,20}})));
      Visualizers.FixedFrame frameT1(length=length, diameter=diameter)
        annotation (Placement(transformation(extent={{-10,20},{-30,40}})));
      Visualizers.FixedFrame frameT2(length=length, diameter=diameter)
        annotation (Placement(transformation(extent={{50,0},{70,20}})));
      MultiBody.Parts.Fixed fixed1(animation=false)
        annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
      inner MultiBody.World world(animateWorld=false,
          gravityType=MultiBody.Types.GravityTypes.NoGravity)
        annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
      MultiBody.Visualizers.FixedArrow arrow(
        n={1,0.5,0},
        color={0,0,255},
        r_tail={0.03,0.1,0},
        length=1.05) annotation (Placement(transformation(extent={{10,-20},{
                30,0}})));
    equation
      R = MultiBody.Frames.nullRotation();
      connect(fixed1.frame_b, arrow.frame_a) annotation (Line(
          points={{-10,-10},{10,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed1.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{-10,-10},{0,-10},{0,10},{10,10}},
          color={95,95,95},
          thickness=0.5));
      connect(frameT1.frame_a, fixedTranslation.frame_a) annotation (Line(
          points={{-10,30},{0,30},{0,10},{10,10}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_b, frameT2.frame_a) annotation (Line(
          points={{30,10},{50,10}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end FixedTranslation;

    model BodyShape "Simple spring/damper/mass system"
      import Modelica.Icons;
      extends Icons.Example;
      parameter Boolean animation=true "= true, if animation shall be enabled";
      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,20},{-60,40}})));
      MultiBody.Parts.FixedTranslation bar2(r={0.8,0,0},
          animation=false) annotation (Placement(transformation(extent={{20,20},
                {40,40}})));
      MultiBody.Forces.Spring spring1(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyShape body(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r={0.4,0,0},
        r_CM={0.2,0,0},
        width=0.05,
        angles_fixed=false) annotation (Placement(transformation(extent={{20,-40},
                {40,-20}})));
      MultiBody.Forces.Spring spring2(
        c=20,
        s_unstretched=0,
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5) annotation (Placement(transformation(
            origin={60,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Joints.FreeMotion freeMotion(
        w_rel_a_fixed=true,
        v_rel_a(each fixed=true),
        angles_fixed=true,
        r_rel_a(start={0.2,-0.5,0.1}, each fixed=true)) annotation (Placement(
            transformation(extent={{-40,-40},{-20,-20}})));
    equation
      connect(world.frame_b, bar2.frame_a) annotation (Line(
          points={{-60,30},{20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring1.frame_a) annotation (Line(
          points={{-60,30},{0,30},{0,10}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, freeMotion.frame_a) annotation (Line(
          points={{-60,30},{-50,30},{-50,-30},{-40,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(spring1.frame_b, body.frame_a) annotation (Line(
          points={{0,-10},{0,-30},{20,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(freeMotion.frame_b, body.frame_a) annotation (Line(
          points={{-20,-30},{20,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(body.frame_b, spring2.frame_b) annotation (Line(
          points={{40,-30},{60,-30},{60,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(bar2.frame_b, spring2.frame_a) annotation (Line(
          points={{40,30},{60,30},{60,10}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=10), Documentation(info="<html>
<p>
This is the same example as \"FreeBody\". The only difference
is that with the <strong>FreeMotion</strong> joint explicitly 6 degrees of
freedom are introduced. The advantage is that <strong>no non-linear system
of equations</strong> occurs any more, because the FreeMotion joint is
described by a set of <strong>non-redundant</strong> variables. The disadvantage is
that there is an orientation for which this description is singular
(see description of FreeMotion joint). In technical systems it is
often possible to use the FreeMotion joint such that the singularity
</p>
</html>"));
    end BodyShape;

    model FreeBodies
      "Test whether enforceStates=true works for all body types (#300)"
      extends Modelica.Icons.Example;
      parameter Boolean animation=true "= true, if animation shall be enabled";
      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-100,20},{-80,40}})));
      MultiBody.Parts.FixedTranslation bar2(r={0.8,0,0},
          animation=false) annotation (Placement(transformation(extent={{60,20},{80,40}})));
      MultiBody.Forces.Spring spring1(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={50,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyShape bodyShape(
        I_11=1,
        I_22=1,
        I_33=1,
        r={0.4,0,0},
        r_CM={0.2,0,0},
        width=0.05,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true),
        angles_fixed=true,
        w_0_fixed=true,
        enforceStates=true,
        m=1,
        angles_start={0.17453292519943,0.17453292519943,0.17453292519943})
        annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
      MultiBody.Forces.Spring spring2(
        c=20,
        s_unstretched=0,
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5) annotation (Placement(transformation(
            origin={90,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.Body body(
        I_11=0.1,
        I_22=0.1,
        I_33=0.1,
        enforceStates=true,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true),
        m=1,
        r_CM={0,-0.3,0},
        angles_fixed=true,
        w_0_fixed=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-60,-30})));
      MultiBody.Forces.Spring spring3(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={-60,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyBox bodyBox(
        r={0,-0.3,0},
        width=0.05,
        enforceStates=true,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true),
        angles_fixed=true,
        w_0_fixed=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-30,-30})));
      MultiBody.Forces.Spring spring4(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        s_unstretched=0,
        c=100) annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Forces.Spring spring5(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        s_unstretched=0,
        c=100) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyCylinder bodyCylinder(
        r={0,-0.3,0},
        diameter=0.05,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true),
        enforceStates=true,
        angles_fixed=true,
        w_0_fixed=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={0,-30})));
      MultiBody.Parts.PointMass pointMass(
        m=1,
        sphereDiameter=0.1,
        stateSelect=StateSelect.always,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={30,-30})));
      MultiBody.Forces.Spring spring6(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0,
        fixedRotationAtFrame_b=true) annotation (Placement(transformation(
            origin={30,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(bar2.frame_a, world.frame_b) annotation (Line(
          points={{60,30},{-80,30}},
          color={95,95,95},
          thickness=0.5));
      connect(spring1.frame_b, bodyShape.frame_a) annotation (Line(
          points={{50,-10},{50,-30},{60,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(bar2.frame_b, spring2.frame_a) annotation (Line(
          points={{80,30},{90,30},{90,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring1.frame_a, world.frame_b) annotation (Line(
          points={{50,10},{50,30},{-80,30}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape.frame_b, spring2.frame_b) annotation (Line(
          points={{80,-30},{90,-30},{90,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring3.frame_a) annotation (Line(
          points={{-80,30},{-60,30},{-60,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring3.frame_b, body.frame_a) annotation (Line(
          points={{-60,-10},{-60,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring4.frame_a) annotation (Line(
          points={{-80,30},{-30,30},{-30,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring4.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-30,-10},{-30,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring5.frame_a) annotation (Line(
          points={{-80,30},{1.77636e-15,30},{1.77636e-15,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring5.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{0,-10},{0,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring6.frame_a) annotation (Line(
          points={{-80,30},{30,30},{30,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring6.frame_b, pointMass.frame_a) annotation (Line(
          points={{30,-10},{30,-30}},
          color={95,95,95},
          thickness=0.5));
      annotation (
        experiment(StopTime=10),
        Documentation(info="<html>

</html>"));
    end FreeBodies;

    model FreeBodies2
      "Test whether enforceStates=true works for all body types (#300)"
      extends Modelica.Icons.Example;
      parameter Boolean animation=true "= true, if animation shall be enabled";
      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-100,20},{-80,40}})));
      MultiBody.Parts.FixedTranslation bar2(r={0.8,0,0},
          animation=false) annotation (Placement(transformation(extent={{60,20},{80,40}})));
      MultiBody.Forces.Spring spring1(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={50,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyShape bodyShape(
        I_11=1,
        I_22=1,
        I_33=1,
        r={0.4,0,0},
        r_CM={0.2,0,0},
        width=0.05,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true),
        angles_fixed=true,
        w_0_fixed=true,
        enforceStates=true,
        m=1,
        angles_start={0.17453292519943,0.17453292519943,0.17453292519943})
        annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
      MultiBody.Forces.Spring spring2(
        c=20,
        s_unstretched=0,
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5) annotation (Placement(transformation(
            origin={90,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.Body body(
        I_11=0.1,
        I_22=0.1,
        I_33=0.1,
        enforceStates=true,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        m=1,
        r_CM={0,-0.3,0},
        angles_fixed=true,
        w_0_fixed=true,
        v_0(each fixed=true, start={-0.1,-0.1,-0.1}),
        w_0_start={-0.1,-0.1,-0.1}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-60,-30})));
      MultiBody.Forces.Spring spring3(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={-60,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyBox bodyBox(
        r={0,-0.3,0},
        width=0.05,
        enforceStates=true,
        angles_fixed=true,
        w_0_fixed=true,
        w_0_start={-0.1,-0.1,-0.1},
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-30,-30})));
      MultiBody.Forces.Spring spring4(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        s_unstretched=0,
        c=100) annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Forces.Spring spring5(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        s_unstretched=0,
        c=100) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyCylinder bodyCylinder(
        r={0,-0.3,0},
        diameter=0.05,
        enforceStates=true,
        angles_fixed=true,
        w_0_fixed=true,
        w_0_start={-0.1,-0.1,-0.1},
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={0,-30})));
      MultiBody.Parts.PointMass pointMass(
        m=1,
        sphereDiameter=0.1,
        stateSelect=StateSelect.always,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={30,-30})));
      MultiBody.Forces.Spring spring6(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0,
        fixedRotationAtFrame_b=true) annotation (Placement(transformation(
            origin={30,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(bar2.frame_a, world.frame_b) annotation (Line(
          points={{60,30},{-80,30}},
          color={95,95,95},
          thickness=0.5));
      connect(spring1.frame_b, bodyShape.frame_a) annotation (Line(
          points={{50,-10},{50,-30},{60,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(bar2.frame_b, spring2.frame_a) annotation (Line(
          points={{80,30},{90,30},{90,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring1.frame_a, world.frame_b) annotation (Line(
          points={{50,10},{50,30},{-80,30}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape.frame_b, spring2.frame_b) annotation (Line(
          points={{80,-30},{90,-30},{90,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring3.frame_a) annotation (Line(
          points={{-80,30},{-60,30},{-60,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring3.frame_b, body.frame_a) annotation (Line(
          points={{-60,-10},{-60,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring4.frame_a) annotation (Line(
          points={{-80,30},{-30,30},{-30,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring4.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-30,-10},{-30,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring5.frame_a) annotation (Line(
          points={{-80,30},{1.77636e-15,30},{1.77636e-15,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring5.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{0,-10},{0,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring6.frame_a) annotation (Line(
          points={{-80,30},{30,30},{30,10}},
          color={95,95,95},
          thickness=0.5));
      connect(pointMass.frame_a, spring6.frame_b) annotation (Line(
          points={{30,-30},{30,-10}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=10), Documentation(info="<html>

</html>"));
    end FreeBodies2;

    model FreeBodiesEnforceStatesFalse
      "Test whether enforceStates=false give any undesired output"
      extends Modelica.Icons.Example;
      parameter Boolean animation=true "= true, if animation shall be enabled";
      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-100,20},{-80,40}})));
      MultiBody.Parts.FixedTranslation bar2(r={0.8,0,0},
          animation=false) annotation (Placement(transformation(extent={{60,20},{80,40}})));
      MultiBody.Forces.Spring spring1(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={50,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyShape bodyShape(
        I_11=1,
        I_22=1,
        I_33=1,
        r={0.4,0,0},
        r_CM={0.2,0,0},
        width=0.05,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true),
        angles_fixed=true,
        w_0_fixed=true,
        m=1,
        angles_start={0.17453292519943,0.17453292519943,0.17453292519943},
        enforceStates=false) annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
      MultiBody.Forces.Spring spring2(
        c=20,
        s_unstretched=0,
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5) annotation (Placement(transformation(
            origin={90,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.Body body(
        I_11=0.1,
        I_22=0.1,
        I_33=0.1,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        m=1,
        r_CM={0,-0.3,0},
        angles_fixed=true,
        w_0_fixed=true,
        v_0(each fixed=true, start={-0.1,-0.1,-0.1}),
        w_0_start={-0.1,-0.1,-0.1},
        enforceStates=false) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-60,-30})));
      MultiBody.Forces.Spring spring3(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={-60,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyBox bodyBox(
        r={0,-0.3,0},
        width=0.05,
        angles_fixed=true,
        w_0_fixed=true,
        w_0_start={-0.1,-0.1,-0.1},
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true),
        enforceStates=false) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-30,-30})));
      MultiBody.Forces.Spring spring4(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        s_unstretched=0,
        c=100) annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Forces.Spring spring5(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        s_unstretched=0,
        c=100) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Parts.BodyCylinder bodyCylinder(
        r={0,-0.3,0},
        diameter=0.05,
        angles_fixed=true,
        w_0_fixed=true,
        w_0_start={-0.1,-0.1,-0.1},
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true),
        enforceStates=false) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={0,-30})));
      MultiBody.Parts.PointMass pointMass(
        m=1,
        sphereDiameter=0.1,
        r_0(start={0.2,-0.5,0.1}, each fixed=true),
        v_0(each fixed=true),
        stateSelect=StateSelect.never) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={30,-30})));
      MultiBody.Forces.Spring spring6(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0,
        fixedRotationAtFrame_b=true) annotation (Placement(transformation(
            origin={30,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(bar2.frame_a, world.frame_b) annotation (Line(
          points={{60,30},{-80,30}},
          color={95,95,95},
          thickness=0.5));
      connect(spring1.frame_b, bodyShape.frame_a) annotation (Line(
          points={{50,-10},{50,-30},{60,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(bar2.frame_b, spring2.frame_a) annotation (Line(
          points={{80,30},{90,30},{90,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring1.frame_a, world.frame_b) annotation (Line(
          points={{50,10},{50,30},{-80,30}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape.frame_b, spring2.frame_b) annotation (Line(
          points={{80,-30},{90,-30},{90,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring3.frame_a) annotation (Line(
          points={{-80,30},{-60,30},{-60,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring3.frame_b, body.frame_a) annotation (Line(
          points={{-60,-10},{-60,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring4.frame_a) annotation (Line(
          points={{-80,30},{-30,30},{-30,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring4.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-30,-10},{-30,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring5.frame_a) annotation (Line(
          points={{-80,30},{1.77636e-15,30},{1.77636e-15,10}},
          color={95,95,95},
          thickness=0.5));
      connect(spring5.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{0,-10},{0,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, spring6.frame_a) annotation (Line(
          points={{-80,30},{30,30},{30,10}},
          color={95,95,95},
          thickness=0.5));
      connect(pointMass.frame_a, spring6.frame_b) annotation (Line(
          points={{30,-30},{30,-10}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=10), Documentation(info="<html>
<p>This test case is made with the intent of verifying what choices are made by the compiler in terms of state selection when wrong indications are given, here all the bodies have the flag enforceStates=false but the bodies positions and velocities are the only possible states.</p>
<p><br>Dymola ignores the flag and uses bodies variables as states.</p>
</html>"));
    end FreeBodiesEnforceStatesFalse;

    model Bodies

      extends Modelica.Icons.Example;
      MultiBody.Parts.Body body2(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r_0(start={0.8,0.2,0}),
        r_CM={0,0,0}) annotation (Placement(transformation(extent={{-20,20},{0,
                40}})));
      MultiBody.Parts.BodyShape bodyShape(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r_CM={0.3,0,0},
        r={0.6,0,0},
        width=0.05) annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
      MultiBody.Parts.BodyBox BodyBox1(r={1,0,0})
        annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      MultiBody.Parts.BodyCylinder bodyCylinder(r={1,0,0},
          innerDiameter=bodyCylinder.diameter/2) annotation (Placement(
            transformation(extent={{-20,-100},{0,-80}})));
      MultiBody.Parts.Fixed Fixed3(animation=false, r={0,-0.3,
            0}) annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
      MultiBody.Parts.Fixed Fixed4(animation=false, r={0,-0.6,
            0}) annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
      MultiBody.Parts.Fixed Fixed5(animation=false, r={0,-0.8,
            0}) annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
      MultiBody.Parts.Body body1(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r_CM={0.3,0,0},
        r_0(start={0.8,0.2,0})) annotation (Placement(transformation(extent={{-20,
                60},{0,80}})));
      MultiBody.Parts.Fixed Fixed1(animation=false, r={0,0.2,
            0}) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      MultiBody.Parts.Fixed Fixed2(animation=false, r={0,0,0})
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{
                40,0},{60,20}})));
    equation

      connect(Fixed1.frame_b, body1.frame_a) annotation (Line(
          points={{-60,70},{-20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(Fixed2.frame_b, body2.frame_a) annotation (Line(
          points={{-60,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(Fixed3.frame_b, bodyShape.frame_a) annotation (Line(
          points={{-60,-10},{-20,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(Fixed4.frame_b, BodyBox1.frame_a) annotation (Line(
          points={{-60,-50},{-20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(Fixed5.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{-60,-90},{-20,-90}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Bodies;

    model PointMass "Test MultiBody.Parts.PointMass"
      extends Modelica.Icons.Example;

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,-10},{-60,10}})));
      MultiBody.Parts.FixedTranslation fixedTranslation(r={1,
            0,0}) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      MultiBody.Parts.PointMass pointMass(m=5) annotation (
          Placement(transformation(extent={{40,-10},{60,10}})));
      MultiBody.Joints.Revolute rev(phi(fixed=true), w(fixed=
             true)) annotation (Placement(transformation(extent={{-40,-10},{-20,
                10}})));
    equation
      connect(fixedTranslation.frame_b, pointMass.frame_a) annotation (Line(
          points={{20,0},{50,0}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, rev.frame_a) annotation (Line(
          points={{-60,0},{-40,0}},
          color={95,95,95},
          thickness=0.5));
      connect(rev.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{-20,0},{0,0}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end PointMass;

    model FixedRotation

      import Modelica.Mechanics.MultiBody.Visualizers;
      extends Modelica.Icons.Example;
      parameter SI.Length length=0.5 "Length of axes of frames";
      parameter SI.Diameter diameter=length/30 "Diameter of frame axes";
      MultiBody.Frames.Orientation R;
      Visualizers.FixedFrame frameT1(length=length, diameter=diameter)
        annotation (Placement(transformation(extent={{-20,20},{-40,40}})));
      Visualizers.FixedFrame frameT2(length=length, diameter=diameter)
        annotation (Placement(transformation(extent={{60,10},{80,30}})));
      inner MultiBody.World world(animateWorld=false,
          gravityType=MultiBody.Types.GravityTypes.NoGravity)
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
      MultiBody.Parts.FixedRotation fixedRotation(angle=47)
        annotation (Placement(transformation(extent={{20,10},{40,30}})));
      MultiBody.Parts.FixedRotation fixedRotation1(
        r={1,1,1},
        rotationType=MultiBody.Types.RotationTypes.TwoAxesVectors,
        n_x={0,1,0},
        n_y={0,0,1})
        annotation (Placement(transformation(extent={{20,-20},{40,0}})));

      Visualizers.FixedFrame frameT3(length=length, diameter=diameter)
        annotation (Placement(transformation(extent={{60,-20},{80,0}})));
      MultiBody.Parts.FixedRotation fixedRotation2(
        n_x={0,1,0},
        n_y={0,0,1},
        rotationType=MultiBody.Types.RotationTypes.PlanarRotationSequence,
        angles={30,20,10},
        r={-1,0,1})
        annotation (Placement(transformation(extent={{20,-50},{40,-30}})));

      Visualizers.FixedFrame frameT4(length=length, diameter=diameter)
        annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
    equation
      R = MultiBody.Frames.nullRotation();
      connect(frameT1.frame_a, fixedRotation.frame_a) annotation (Line(
          points={{-20,30},{0,30},{0,20},{20,20}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation.frame_b, frameT2.frame_a) annotation (Line(
          points={{40,20},{60,20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
          points={{-20,-10},{0,-10},{0,20},{20,20}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation1.frame_b, frameT3.frame_a) annotation (Line(
          points={{40,-10},{60,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation2.frame_b, frameT4.frame_a) annotation (Line(
          points={{40,-40},{60,-40}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation1.frame_a, world.frame_b) annotation (Line(
          points={{20,-10},{-20,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation2.frame_a, world.frame_b) annotation (Line(
          points={{20,-40},{0,-40},{0,-10},{-20,-10}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end FixedRotation;

    model FlyingBodies

      extends Modelica.Icons.Example;
      MultiBody.Parts.BodyShape bodyShape(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r_CM={0.3,0,0},
        r={0.6,0,0},
        width=0.05,
        v_0(each fixed=true),
        angles_fixed=true,
        w_0_fixed=true,
        w_0_start={1,0.3,0.2},
        r_0(each fixed=true, start={1,1,1})) annotation (Placement(
            transformation(extent={{-20,0},{0,20}})));
      MultiBody.Parts.BodyBox BodyBox1(
        r={1,0,0},
        r_0(each fixed=true, start={-0.1,-0.3,-0.2}),
        v_0(each fixed=true),
        angles_fixed=true,
        w_0_fixed=true,
        w_0_start={1,0.3,0.2}) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      MultiBody.Parts.BodyCylinder bodyCylinder(
        r={1,0,0},
        innerDiameter=bodyCylinder.diameter/2,
        r_0(each fixed=true),
        v_0(each fixed=true),
        angles_fixed=true,
        w_0_fixed=true,
        w_0_start={5,-0.4,0.5}) annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      MultiBody.Parts.Body body1(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r_CM={0.3,0,0},
        r_0(start={0.8,0.2,0}, each fixed=true),
        v_0(each fixed=true, start={0,0,0}),
        angles_fixed=true,
        angles_start={0,0,0},
        w_0_fixed=true,
        w_0_start={1,0.3,0.2}) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      inner MultiBody.World world(
        animateWorld=false,
        animateGravity=false,
        gravityType=MultiBody.Types.GravityTypes.NoGravity)
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
      MultiBody.Visualizers.FixedFrame fixedFrame
        annotation (Placement(transformation(extent={{-40,40},{-60,60}})));
      MultiBody.Visualizers.FixedFrame fixedFrame1
        annotation (Placement(transformation(extent={{-40,0},{-60,20}})));
      MultiBody.Visualizers.FixedFrame fixedFrame2
        annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
      MultiBody.Visualizers.FixedFrame fixedFrame3
        annotation (Placement(transformation(extent={{-40,-80},{-60,-60}})));
    equation

      connect(fixedFrame.frame_a, body1.frame_a) annotation (Line(
          points={{-40,50},{-20,50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedFrame1.frame_a, bodyShape.frame_a) annotation (Line(
          points={{-40,10},{-20,10}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedFrame2.frame_a, BodyBox1.frame_a) annotation (Line(
          points={{-40,-30},{-20,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedFrame3.frame_a, bodyCylinder.frame_a) annotation (Line(
          points={{-40,-70},{-20,-70}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=4));
    end FlyingBodies;

    package Rotor1D
      extends Modelica.Icons.ExamplesPackage;
      model Rotor1D_1
        extends Modelica.Icons.Example;
        parameter Real tol=1e-3;
        inner MultiBody.World world(driveTrainMechanics3D=
              true) annotation (Placement(transformation(extent={{-100,20},{-80,
                  40}})));
        MultiBody.Joints.Spherical spherical1(
          angles_fixed=true,
          w_rel_a_fixed=true,
          z_rel_a_fixed=false) annotation (Placement(transformation(extent={{-70,
                  20},{-50,40}})));
        MultiBody.Parts.BodyCylinder bodyCylinder1(r={0.25,0,
              0}, diameter=0.05) annotation (Placement(transformation(extent={{
                  -40,20},{-20,40}})));
        MultiBody.Parts.FixedRotation fixedRotation1(angle=
              45, n={0,1,0}) annotation (Placement(transformation(extent={{-10,
                  20},{10,40}})));
        MultiBody.Joints.Revolute revolute(
          n={1,0,0},
          a(fixed=false),
          phi(fixed=true),
          w(fixed=true, start=8.726646259971648)) annotation (Placement(
              transformation(extent={{20,20},{40,40}})));
        MultiBody.Parts.FixedTranslation fixedTranslation(r=
              {-0.1,0,0}) annotation (Placement(transformation(extent={{50,20},
                  {70,40}})));
        MultiBody.Parts.BodyCylinder bodyCylinder2(diameter=
              0.1, r={0.2,0,0}) annotation (Placement(transformation(extent={{
                  80,20},{100,40}})));
        MultiBody.Parts.Fixed fixed annotation (Placement(
              transformation(extent={{-100,-40},{-80,-20}})));
        MultiBody.Joints.Spherical spherical2(
          angles_fixed=true,
          w_rel_a_fixed=true,
          z_rel_a_fixed=false) annotation (Placement(transformation(extent={{-70,
                  -40},{-50,-20}})));
        MultiBody.Parts.BodyCylinder bodyCylinder3(
          r={0.25,0,0},
          diameter=0.05,
          color={0,128,0}) annotation (Placement(transformation(extent={{-40,-40},
                  {-20,-20}})));
        MultiBody.Parts.FixedRotation fixedRotation2(n={0,1,
              0}, angle=45) annotation (Placement(transformation(extent={{-10,-40},
                  {10,-20}})));
        MultiBody.Parts.FixedTranslation fixedTranslation1(r=
             {-0.1,0,0}) annotation (Placement(transformation(extent={{50,-40},
                  {70,-20}})));
        MultiBody.Parts.BodyCylinder bodyCylinder4(
          diameter=0.1,
          r={0.2,0,0},
          color={0,128,0}) annotation (Placement(transformation(extent={{80,-40},
                  {100,-20}})));
        MultiBody.Parts.Rotor1D rotor1D(
          J=bodyCylinder4.I[1, 1],
          n={1,0,0},
          a(fixed=false),
          phi(fixed=true),
          w(fixed=true, start=8.726646259971648)) annotation (Placement(
              transformation(extent={{20,-50},{40,-70}})));
      equation
        assert(bodyCylinder2.r_0[1] - bodyCylinder4.r_0[1] < tol and
          bodyCylinder2.r_0[2] - bodyCylinder4.r_0[2] < tol and bodyCylinder2.r_0
          [3] - bodyCylinder4.r_0[3] < tol, "Position of bodies must be equal");
        assert(bodyCylinder2.v_0[1] - bodyCylinder4.v_0[1] < tol and
          bodyCylinder2.v_0[2] - bodyCylinder4.v_0[2] < tol and bodyCylinder2.v_0
          [3] - bodyCylinder4.v_0[3] < tol,
          "Velocities of bodies must be equal");
        connect(world.frame_b, spherical1.frame_a) annotation (Line(
            points={{-80,30},{-70,30}},
            color={95,95,95},
            thickness=0.5));
        connect(spherical1.frame_b, bodyCylinder1.frame_a) annotation (Line(
            points={{-50,30},{-40,30}},
            color={95,95,95},
            thickness=0.5));
        connect(bodyCylinder1.frame_b, fixedRotation1.frame_a) annotation (Line(
            points={{-20,30},{-10,30}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedRotation1.frame_b, revolute.frame_a) annotation (Line(
            points={{10,30},{20,30}},
            color={95,95,95},
            thickness=0.5));
        connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
            points={{40,30},{50,30}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedTranslation.frame_b, bodyCylinder2.frame_a) annotation (
            Line(
            points={{70,30},{80,30}},
            color={95,95,95},
            thickness=0.5));
        connect(spherical2.frame_b, bodyCylinder3.frame_a) annotation (Line(
            points={{-50,-30},{-40,-30}},
            color={95,95,95},
            thickness=0.5));
        connect(bodyCylinder3.frame_b, fixedRotation2.frame_a) annotation (Line(
            points={{-20,-30},{-10,-30}},
            color={95,95,95},
            thickness=0.5));
        connect(fixed.frame_b, spherical2.frame_a) annotation (Line(
            points={{-80,-30},{-70,-30}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedTranslation1.frame_b, bodyCylinder4.frame_a) annotation (
            Line(
            points={{70,-30},{80,-30}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedRotation2.frame_b, fixedTranslation1.frame_a) annotation (
            Line(
            points={{10,-30},{50,-30}},
            color={95,95,95},
            thickness=0.5));
        connect(rotor1D.frame_a, fixedRotation2.frame_b) annotation (Line(
            points={{30,-50},{30,-30},{10,-30}},
            color={95,95,95},
            thickness=0.5));
        annotation (experiment(StopTime=5, Tolerance=1e-008));
      end Rotor1D_1;

      model Rotor1D_2
        extends Modelica.Icons.Example;
        parameter Real tol=1e-3;

        MultiBody.Parts.BodyShape bodyCylinder(
          r={0.5,0,0},
          m=0,
          I_11=2,
          I_22=0,
          I_33=0,
          shapeType="cylinder",
          width=0.1,
          animateSphere=false,
          r_shape={0.1,0,0},
          r_CM={0,0,0}) annotation (Placement(transformation(extent={{30,0},{50,
                  20}})));
        MultiBody.Joints.Revolute revolute(
          n={1,0,0},
          a(fixed=false),
          phi(fixed=true),
          w(fixed=true)) annotation (Placement(transformation(extent={{0,0},{20,
                  20}})));
        inner MultiBody.World world(g=0,
            driveTrainMechanics3D=true) annotation (Placement(transformation(
                extent={{-40,0},{-20,20}})));
        MultiBody.Forces.Torque torque(resolveInFrame=
              MultiBody.Types.ResolveInFrameAB.frame_resolve)
          annotation (Placement(transformation(extent={{30,30},{50,50}})));
        Modelica.Blocks.Sources.Sine sine[3](amplitude={1,0,0}, f={1,1,1})
          annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
        inner MultiBody.Parts.Fixed fixed annotation (
            Placement(transformation(extent={{-40,-90},{-20,-70}})));
        MultiBody.Parts.Rotor1D rotor1D(
          J=2,
          phi(fixed=true),
          w(fixed=true)) annotation (Placement(transformation(extent={{30,-40},
                  {50,-20}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
          annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        MultiBody.Parts.Mounting1D mounting1D annotation (
            Placement(transformation(extent={{-20,-60},{0,-40}})));
      equation
        assert(bodyCylinder.body.w_a[1] - rotor1D.w < tol,
          "Error, difference between angular velocities too big");

        connect(world.frame_b, revolute.frame_a) annotation (Line(
            points={{-20,10},{0,10}},
            color={95,95,95},
            thickness=0.5));
        connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
            points={{20,10},{30,10}},
            color={95,95,95},
            thickness=0.5));
        connect(torque.frame_b, bodyCylinder.frame_b) annotation (Line(
            points={{50,40},{60,40},{60,10},{50,10}},
            color={95,95,95},
            thickness=0.5));
        connect(torque.frame_resolve, world.frame_b) annotation (Line(
            points={{44,50},{44,64},{-10,64},{-10,10},{-20,10}},
            color={95,95,95},
            pattern=LinePattern.Dot));
        connect(torque.frame_a, world.frame_b) annotation (Line(
            points={{30,40},{-10,40},{-10,10},{-20,10}},
            color={95,95,95},
            thickness=0.5));
        connect(sine.y, torque.torque) annotation (Line(
            points={{-69,60},{34,60},{34,52}}, color={0,0,127}));
        connect(fixed.frame_b, rotor1D.frame_a) annotation (Line(
            points={{-20,-80},{40,-80},{40,-40}},
            color={95,95,95},
            thickness=0.5));
        connect(torque1.flange, rotor1D.flange_a) annotation (Line(
            points={{20,-30},{30,-30}}));
        connect(mounting1D.flange_b, torque1.support) annotation (Line(
            points={{0,-50},{10,-50},{10,-40}}));
        connect(mounting1D.frame_a, fixed.frame_b) annotation (Line(
            points={{-10,-60},{-10,-80},{-20,-80}},
            color={95,95,95},
            thickness=0.5));
        connect(sine[1].y, torque1.tau) annotation (Line(
            points={{-69,60},{-60,60},{-60,-30},{-2,-30}}, color={0,0,127}));
        annotation (experiment(StopTime=3));
      end Rotor1D_2;

      model Rotor1D_3
        extends Modelica.Icons.Example;
        parameter Real tol=1e-3;

        MultiBody.Parts.BodyShape bodyCylinder(
          r={0.5,0,0},
          m=0,
          I_11=2,
          I_22=0,
          I_33=0,
          shapeType="cylinder",
          width=0.1,
          animateSphere=false,
          r_shape={0.1,0,0},
          r_CM={0,0,0}) annotation (Placement(transformation(extent={{50,0},{70,
                  20}})));
        MultiBody.Joints.Revolute revolute(
          n={1,0,0},
          a(fixed=false),
          phi(fixed=true),
          w(fixed=true)) annotation (Placement(transformation(extent={{20,0},{
                  40,20}})));
        inner MultiBody.World world(g=0,
            driveTrainMechanics3D=true) annotation (Placement(transformation(
                extent={{-80,0},{-60,20}})));
        MultiBody.Forces.Torque torque(resolveInFrame=
              MultiBody.Types.ResolveInFrameAB.frame_resolve)
          annotation (Placement(transformation(extent={{50,30},{70,50}})));
        Modelica.Blocks.Sources.Sine sine1[3](amplitude={1,0,0}, f={1,1,1})
          annotation (Placement(transformation(extent={{100,70},{80,90}})));
        MultiBody.Parts.Rotor1D rotor1D(
          J=2,
          phi(fixed=true),
          w(fixed=true)) annotation (Placement(transformation(extent={{50,-50},
                  {70,-30}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
          annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
        MultiBody.Parts.Mounting1D mounting1D annotation (
            Placement(transformation(extent={{0,-66},{20,-46}})));
        MultiBody.Joints.Revolute r1(
          n={0,1,0},
          useAxisFlange=true,
          w(fixed=true)) annotation (Placement(transformation(extent={{-30,0},{
                  -10,20}})));
        Modelica.Mechanics.Rotational.Sources.Position position1(useSupport=
              true) annotation (Placement(transformation(extent={{-50,50},{-30,
                  70}})));
        Modelica.Blocks.Sources.Sine sine2(amplitude=2, f=1) annotation (
            Placement(transformation(extent={{-100,50},{-80,70}})));
        MultiBody.Parts.Mounting1D mounting1D1 annotation (
            Placement(transformation(extent={{-60,24},{-40,44}})));
        MultiBody.Joints.Revolute r2(
          n={0,1,0},
          useAxisFlange=true,
          w(fixed=true)) annotation (Placement(transformation(extent={{-30,-90},
                  {-10,-70}})));
        Modelica.Mechanics.Rotational.Sources.Position position2(useSupport=
              true) annotation (Placement(transformation(extent={{-50,-40},{-30,
                  -20}})));
        MultiBody.Parts.Mounting1D mounting1D2 annotation (
            Placement(transformation(extent={{-60,-66},{-40,-46}})));
        MultiBody.Parts.Fixed fixed annotation (Placement(
              transformation(extent={{-80,-90},{-60,-70}})));
      equation
        assert(bodyCylinder.body.w_a[1] - rotor1D.w < tol,
          "Error, difference between angular velocities too big");
        connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
            points={{40,10},{50,10}},
            color={95,95,95},
            thickness=0.5));
        connect(torque.frame_b, bodyCylinder.frame_b) annotation (Line(
            points={{70,40},{80,40},{80,10},{70,10}},
            color={95,95,95},
            thickness=0.5));
        connect(sine1.y, torque.torque) annotation (Line(
            points={{79,80},{54,80},{54,52}}, color={0,0,127}));
        connect(torque1.flange, rotor1D.flange_a) annotation (Line(
            points={{40,-40},{50,-40}}));
        connect(mounting1D.flange_b, torque1.support) annotation (Line(
            points={{20,-56},{30,-56},{30,-50}}));
        connect(r1.frame_a, world.frame_b) annotation (Line(
            points={{-30,10},{-60,10}},
            color={95,95,95},
            thickness=0.5));
        connect(position1.flange, r1.axis) annotation (Line(
            points={{-30,60},{-20,60},{-20,20}}));
        connect(position1.support, mounting1D1.flange_b) annotation (Line(
            points={{-40,50},{-40,34}}));
        connect(mounting1D1.frame_a, world.frame_b) annotation (Line(
            points={{-50,24},{-50,10},{-60,10}},
            color={95,95,95},
            thickness=0.5));
        connect(sine2.y, position1.phi_ref) annotation (Line(
            points={{-79,60},{-52,60}}, color={0,0,127}));
        connect(r1.frame_b, revolute.frame_a) annotation (Line(
            points={{-10,10},{20,10}},
            color={95,95,95},
            thickness=0.5));
        connect(torque.frame_resolve, revolute.frame_a) annotation (Line(
            points={{64,50},{10,50},{10,10},{20,10}},
            color={95,95,95},
            pattern=LinePattern.Dot));
        connect(torque.frame_a, revolute.frame_a) annotation (Line(
            points={{50,40},{10,40},{10,10},{20,10}},
            color={95,95,95},
            thickness=0.5));
        connect(position2.flange, r2.axis) annotation (Line(
            points={{-30,-30},{-20,-30},{-20,-70}}));
        connect(position2.support, mounting1D2.flange_b) annotation (Line(
            points={{-40,-40},{-40,-56}}));
        connect(fixed.frame_b, r2.frame_a) annotation (Line(
            points={{-60,-80},{-30,-80}},
            color={95,95,95},
            thickness=0.5));
        connect(fixed.frame_b, mounting1D2.frame_a) annotation (Line(
            points={{-60,-80},{-50,-80},{-50,-66}},
            color={95,95,95},
            thickness=0.5));
        connect(sine2.y, position2.phi_ref) annotation (Line(
            points={{-79,60},{-70,60},{-70,30},{-92,30},{-92,-30},{-52,-30}}, color={0,0,127}));
        connect(r2.frame_b, rotor1D.frame_a) annotation (Line(
            points={{-10,-80},{60,-80},{60,-50}},
            color={95,95,95},
            thickness=0.5));
        connect(r2.frame_b, mounting1D.frame_a) annotation (Line(
            points={{-10,-80},{10,-80},{10,-66}},
            color={95,95,95},
            thickness=0.5));
        connect(sine1[1].y, torque1.tau) annotation (Line(
            points={{79,80},{54,80},{54,60},{92,60},{92,-20},{0,-20},{0,-40},{
                18,-40}}, color={0,0,127}));
        annotation (experiment(StopTime=2));
      end Rotor1D_3;

      model GearConstraint
        extends Modelica.Icons.Example;
        parameter Real tol=1e-3;

        MultiBody.Joints.GearConstraint gearConstraint(
          ratio=10,
          phi_b(fixed=true),
          w_b(fixed=true),
          checkTotalPower=true)
                           annotation (Placement(transformation(extent={{40,40},
                  {60,60}})));
        inner MultiBody.World world(g=0,
            driveTrainMechanics3D=true) annotation (Placement(transformation(
                extent={{-60,10},{-40,30}})));
        MultiBody.Parts.BodyCylinder cyl1(
          diameter=0.1,
          color={0,128,0},
          r={0.4,0,0}) annotation (Placement(transformation(extent={{10,40},{30,
                  60}})));
        MultiBody.Parts.BodyCylinder cyl2(r={0.4,0,0},
            diameter=0.2) annotation (Placement(transformation(extent={{70,40},
                  {90,60}})));
        MultiBody.Forces.Torque torque1(resolveInFrame=
              MultiBody.Types.ResolveInFrameAB.frame_b)
          annotation (Placement(transformation(extent={{-20,40},{0,60}})));
        Modelica.Blocks.Sources.Sine sine[3](amplitude={2,0,0}, f={1,1,1})
          annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
        MultiBody.Parts.Fixed fixed annotation (Placement(
              transformation(extent={{-60,-90},{-40,-70}})));
        Modelica.Mechanics.Rotational.Components.Inertia inertia1(
          J=cyl1.I[1, 1],
          a(fixed=false),
          phi(fixed=true, start=0),
          w(fixed=true, start=0)) annotation (Placement(transformation(extent={
                  {-20,-40},{0,-20}})));
        Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio=10,
            useSupport=true) annotation (Placement(transformation(extent={{10,-40},
                  {30,-20}})));
        Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=cyl2.I[1, 1])
          annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
          annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
        MultiBody.Parts.Mounting1D mounting1D annotation (
            Placement(transformation(extent={{-20,-70},{0,-50}})));
      equation
        assert(cyl2.body.w_a[1] - inertia2.w < tol,
          "Error, difference between angular velocities too big");
        connect(world.frame_b, gearConstraint.bearing) annotation (Line(
            points={{-40,20},{50,20},{50,40}},
            color={95,95,95},
            thickness=0.5));
        connect(cyl1.frame_b, gearConstraint.frame_a) annotation (Line(
            points={{30,50},{40,50}},
            color={95,95,95},
            thickness=0.5));
        connect(gearConstraint.frame_b, cyl2.frame_a) annotation (Line(
            points={{60,50},{70,50}},
            color={95,95,95},
            thickness=0.5));
        connect(torque1.frame_b, cyl1.frame_a) annotation (Line(
            points={{0,50},{10,50}},
            color={95,95,95},
            thickness=0.5));
        connect(torque1.frame_a, world.frame_b) annotation (Line(
            points={{-20,50},{-30,50},{-30,20},{-40,20}},
            color={95,95,95},
            thickness=0.5));
        connect(sine.y, torque1.torque) annotation (Line(
            points={{-79,70},{-16,70},{-16,62}}, color={0,0,127}));
        connect(inertia1.flange_b, idealGear.flange_a) annotation (Line(
            points={{0,-30},{10,-30}}));
        connect(idealGear.flange_b, inertia2.flange_a) annotation (Line(
            points={{30,-30},{40,-30}}));
        connect(torque2.flange, inertia1.flange_a) annotation (Line(
            points={{-30,-30},{-20,-30}}));
        connect(sine[1].y, torque2.tau) annotation (Line(
            points={{-79,70},{-72,70},{-72,-30},{-52,-30}}, color={0,0,127}));
        connect(mounting1D.flange_b, idealGear.support) annotation (Line(
            points={{0,-60},{10,-60},{10,-50},{20,-50},{20,-40}}));
        connect(mounting1D.flange_b, torque2.support) annotation (Line(
            points={{0,-60},{10,-60},{10,-50},{-40,-50},{-40,-40}}));
        connect(fixed.frame_b, mounting1D.frame_a) annotation (Line(
            points={{-40,-80},{-10,-80},{-10,-70}},
            color={95,95,95},
            thickness=0.5));
        annotation (experiment(StopTime=5));
      end GearConstraint;

      model GearConstraint2
        extends Modelica.Icons.Example;
        MultiBody.Joints.GearConstraint gc1(
          ratio=5,
          phi_b(fixed=true),
          w_b(fixed=true),
          r_a={1,0,0},
          r_b={1,0,0},
          n_a={1,0,0},
          n_b={1,0,0},
          checkTotalPower=true)
          annotation (Placement(transformation(extent={{128,34},{148,54}})));
        inner MultiBody.World world annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              origin={-54,10})));
        parameter Real tol=1e-4;
        MultiBody.Joints.GearConstraint gc2(
          phi_b(fixed=true),
          w_b(fixed=true),
          n_a={1,0,0},
          n_b={1,0,0},
          r_a={1,0,0},
          r_b={1,0,0},
          ratio=2.5,
          checkTotalPower=true)
                     annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={138,-56})));
        MultiBody.Parts.BodyCylinder bodyCylinder(
          diameter=0.3,
          r={0.1,0,0},
          angles_fixed=false,
          w_0_fixed=false)
          annotation (Placement(transformation(extent={{32,32},{52,52}})));
        MultiBody.Parts.BodyCylinder bodyCylinder1(
          diameter=0.3,
          r={0.1,0,0},
          angles_fixed=false,
          w_0_fixed=false)
          annotation (Placement(transformation(extent={{30,-94},{52,-72}})));
        MultiBody.Parts.BodyCylinder bodyCylinder2(
          diameter=0.3,
          r={0.2,0,0},
          angles_fixed=false,
          w_0_fixed=false)
          annotation (Placement(transformation(extent={{186,16},{206,36}})));
        MultiBody.Parts.BodyCylinder bodyCylinder3(
          diameter=0.3,
          r={0.2,0,0},
          angles_fixed=false,
          w_0_fixed=false)
          annotation (Placement(transformation(extent={{182,-66},{202,-46}})));
        MultiBody.Visualizers.FixedFrame fixedFrame
          annotation (Placement(transformation(extent={{188,40},{196,48}})));
        MultiBody.Visualizers.FixedFrame fixedFrame1
          annotation (Placement(transformation(extent={{186,-44},{194,-36}})));
        Modelica.Blocks.Sources.Ramp ramp[3](height={100,0,0}, duration={2,2,2})
          annotation (Placement(transformation(
              extent={{-6,-6},{6,6}},
              origin={-80,70})));
        MultiBody.Parts.FixedTranslation fixedTranslation(r=
              {0,0,1}, animation=false) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-18,-14})));
        MultiBody.Visualizers.FixedFrame fixedFrame2
          annotation (Placement(transformation(extent={{36,54},{44,62}})));
        MultiBody.Visualizers.FixedFrame fixedFrame3
          annotation (Placement(transformation(extent={{34,-60},{42,-52}})));
        MultiBody.Parts.FixedTranslation fixedTranslation1(r=
             {0.5,0,0})
          annotation (Placement(transformation(extent={{82,30},{102,52}})));
        MultiBody.Parts.FixedTranslation fixedTranslation2(r=
             {0.5,0,0})
          annotation (Placement(transformation(extent={{78,-94},{98,-72}})));
        MultiBody.Forces.Torque torque1
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        MultiBody.Forces.Torque torque2
          annotation (Placement(transformation(extent={{-8,-44},{12,-64}})));
      equation
        assert((bodyCylinder2.body.w_a[1] - (2*bodyCylinder3.body.w_a[1])) <
          tol,
          "Difference in angular speed between body2 and body3 must be fixed");
        connect(gc2.frame_b, bodyCylinder3.frame_a) annotation (Line(
            points={{148,-56},{182,-56}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedFrame1.frame_a, gc2.frame_b) annotation (Line(
            points={{186,-40},{172,-40},{172,-56},{148,-56}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedTranslation.frame_a, world.frame_b) annotation (Line(
            points={{-18,-4},{-18,-4},{-18,10},{-44,10}},
            color={95,95,95},
            thickness=0.5));
        connect(gc1.frame_b, bodyCylinder2.frame_a) annotation (Line(
            points={{148,44},{168,44},{168,26},{186,26}},
            color={95,95,95},
            thickness=0.5));
        connect(gc1.frame_b, fixedFrame.frame_a) annotation (Line(
            points={{148,44},{188,44}},
            color={95,95,95},
            thickness=0.5));
        connect(bodyCylinder.frame_b, fixedTranslation1.frame_a) annotation (
            Line(
            points={{52,42},{68,42},{68,41},{82,41}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedTranslation1.frame_b, gc1.frame_a) annotation (Line(
            points={{102,41},{114,41},{114,44},{128,44}},
            color={95,95,95},
            thickness=0.5));
        connect(bodyCylinder1.frame_b, fixedTranslation2.frame_a) annotation (
            Line(
            points={{52,-83},{78,-83}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedTranslation2.frame_b, gc2.frame_a) annotation (Line(
            points={{98,-83},{114,-83},{114,-56},{128,-56}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedTranslation.frame_a, gc1.bearing) annotation (Line(
            points={{-18,-4},{-18,10},{138,10},{138,34}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedTranslation.frame_a, torque1.frame_a) annotation (Line(
            points={{-18,-4},{-18,40},{-10,40}},
            color={95,95,95},
            thickness=0.5));
        connect(torque1.frame_b, bodyCylinder.frame_a) annotation (Line(
            points={{10,40},{22,40},{22,42},{32,42}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedTranslation.frame_b, torque2.frame_a) annotation (Line(
            points={{-18,-24},{-10,-24},{-10,-54},{-8,-54}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedTranslation.frame_b, gc2.bearing) annotation (Line(
            points={{-18,-24},{-18,-104},{138,-104},{138,-66}},
            color={95,95,95},
            thickness=0.5));
        connect(torque2.frame_b, bodyCylinder1.frame_a) annotation (Line(
            points={{12,-54},{26,-54},{26,-83},{30,-83}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedFrame2.frame_a, bodyCylinder.frame_a) annotation (Line(
            points={{36,58},{36,42},{32,42}},
            color={95,95,95},
            thickness=0.5));
        connect(fixedFrame3.frame_a, bodyCylinder1.frame_a) annotation (Line(
            points={{34,-56},{30,-56},{30,-83}},
            color={95,95,95},
            thickness=0.5));
        connect(ramp.y, torque1.torque) annotation (Line(
            points={{-73.4,70},{-36,70},{-36,52},{-6,52}}, color={0,0,127}));
        connect(ramp.y, torque2.torque) annotation (Line(
            points={{-73.4,70},{-73.4,-68},{-4,-68},{-4,-66}}, color={0,0,127}));

        annotation (Diagram(coordinateSystem(extent={{-100,-140},{240,100}},
                preserveAspectRatio=true)), experiment(StopTime=5));
      end GearConstraint2;

      model GearConstraint3
        "Test of GearConstraint (totalPower has to be zero)"
        extends Modelica.Icons.Example;

        inner MultiBody.World world annotation (Placement(transformation(
                extent={{-80,-20},{-60,0}})));
        MultiBody.Joints.GearConstraint gearConstraint(
          ratio=10,
          n_a={1,0,0},
          n_b={0,1,0},
          checkTotalPower=true,
          actuatedRevolute_a(phi(fixed=true), w(fixed=true)))
          annotation (Placement(transformation(extent={{0,40},{20,60}})));
        MultiBody.Joints.Revolute revolute1(useAxisFlange=true, n={
              1,0,0},
          stateSelect=StateSelect.always,
          phi(fixed=true),
          w(fixed=true))
          annotation (Placement(transformation(extent={{-46,0},{-26,-20}})));
        MultiBody.Joints.Revolute revolute2(useAxisFlange=true, n={
              0,1,0},
          stateSelect=StateSelect.always,
          phi(fixed=true),
          w(fixed=true))
                      annotation (Placement(transformation(extent={{0,0},{20,-20}})));
        MultiBody.Joints.Revolute revolute3(useAxisFlange=true, n={
              0,0,1},
          stateSelect=StateSelect.always,
          phi(fixed=true),
          w(fixed=true))
                      annotation (Placement(transformation(extent={{46,0},{66,-20}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque1
          annotation (Placement(transformation(extent={{-52,-45},{-42,-35}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque2
          annotation (Placement(transformation(extent={{-4,-45},{6,-35}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque3
          annotation (Placement(transformation(extent={{42,-45},{52,-35}})));
        Modelica.Blocks.Sources.Sine sine1(amplitude=110, f=5)
          annotation (Placement(transformation(extent={{-72,-46},{-60,-34}})));
        Modelica.Blocks.Sources.Sine sine2(amplitude=120, f=6)
          annotation (Placement(transformation(extent={{-24,-46},{-12,-34}})));
        Modelica.Blocks.Sources.Sine sine3(amplitude=130, f=7)
          annotation (Placement(transformation(extent={{24,-46},{36,-34}})));
        Modelica.Blocks.Sources.Sine sine4[3](amplitude={140,150,160}, f={8,9,10})
          annotation (Placement(transformation(extent={{-96,60},{-76,80}})));
        MultiBody.Parts.BodyBox bodyBox1(
          r={0.1,0.1,0.1},
          length=0.1,
          width=0.1) annotation (Placement(transformation(extent={{76,-20},{96,0}})));
        MultiBody.Parts.BodyBox bodyBox2(
          length=0.1,
          width=0.1,
          r={1.1,1.2,1.3})
          annotation (Placement(transformation(extent={{30,40},{50,60}})));
        MultiBody.Parts.BodyBox bodyBox3(
          length=0.1,
          width=0.1,
          r={0.11,0.12,0.13})
          annotation (Placement(transformation(extent={{-32,40},{-12,60}})));
        MultiBody.Forces.Torque torque
          annotation (Placement(transformation(extent={{-62,40},{-42,60}})));
      equation
        assert(abs(gearConstraint.totalPower) < 1e-3, "Error, energy balance of gearConstraint is wrong");

        connect(world.frame_b, revolute1.frame_a) annotation (Line(
            points={{-60,-10},{-46,-10}},
            color={95,95,95},
            thickness=0.5));
        connect(revolute1.frame_b, revolute2.frame_a) annotation (Line(
            points={{-26,-10},{0,-10}},
            color={95,95,95},
            thickness=0.5));
        connect(revolute2.frame_b, revolute3.frame_a) annotation (Line(
            points={{20,-10},{46,-10}},
            color={95,95,95},
            thickness=0.5));
        connect(torque1.flange, revolute1.axis) annotation (Line(
            points={{-42,-40},{-36,-40},{-36,-20}}));
        connect(torque2.flange, revolute2.axis) annotation (Line(
            points={{6,-40},{10,-40},{10,-20}}));
        connect(torque3.flange, revolute3.axis) annotation (Line(
            points={{52,-40},{56,-40},{56,-20}}));
        connect(sine1.y, torque1.tau) annotation (Line(
            points={{-59.4,-40},{-53,-40}}, color={0,0,127}));
        connect(torque2.tau, sine2.y) annotation (Line(
            points={{-5,-40},{-11.4,-40}}, color={0,0,127}));
        connect(torque3.tau, sine3.y) annotation (Line(
            points={{41,-40},{36.6,-40}}, color={0,0,127}));
        connect(revolute3.frame_b, bodyBox1.frame_a) annotation (Line(
            points={{66,-10},{76,-10}},
            color={95,95,95},
            thickness=0.5));
        connect(gearConstraint.frame_b, bodyBox2.frame_a) annotation (Line(
            points={{20,50},{30,50}},
            color={95,95,95},
            thickness=0.5));
        connect(gearConstraint.frame_a, bodyBox3.frame_b) annotation (Line(
            points={{-8.88178e-016,50},{-12,50}},
            color={95,95,95},
            thickness=0.5));
        connect(gearConstraint.bearing, revolute3.frame_b) annotation (Line(
            points={{10,40},{10,20},{72,20},{72,-10},{66,-10}},
            color={95,95,95},
            thickness=0.5));
        connect(bodyBox3.frame_a, torque.frame_b) annotation (Line(
            points={{-32,50},{-42,50}},
            color={95,95,95},
            thickness=0.5));
        connect(torque.frame_a, revolute1.frame_a) annotation (Line(
            points={{-62,50},{-72,50},{-72,20},{-52,20},{-52,-10},{-46,-10}},
            color={95,95,95},
            thickness=0.5));
        connect(sine4.y, torque.torque) annotation (Line(
            points={{-75,70},{-58,70},{-58,62}}, color={0,0,127}));
        annotation (Documentation(info="<html>
</html>"),experiment(StopTime=1.0));
      end GearConstraint3;

      model GearConstraint4
        "Test of GearConstraint (totalPower has to be zero and angles and position vectors from absoluteSensors need to be identical)"
        extends Modelica.Icons.Example;

        inner MultiBody.World world(
          animateWorld=false,
          g=0) annotation(Placement(transformation(extent={{-140,40},{-120,60}})));
        MultiBody.Joints.FreeMotion freeMotion1(
          animation=false,
          r_rel_a(each fixed=true),
          v_rel_a(each fixed=true),
          a_rel_a(each fixed=false),
          angles_fixed=true,
          w_rel_a_fixed=true,
          useQuaternions=false) annotation(Placement(transformation(extent={{-119,92},
                  {-99,112}})));
        MultiBody.Parts.Fixed fixed1 annotation(Placement(transformation(extent={{-149,92},
                  {-129,112}})));
        MultiBody.Parts.BodyBox bodyBox1(
          r={1,0,0},
          width=0.1,
          density=70) annotation(Placement(transformation(extent={{-89,92},{-69,112}})));
        MultiBody.Joints.Revolute revolute1(
          phi(fixed=true),
          w(fixed=true)) annotation(Placement(transformation(extent={{-29,92},{-9,112}})));
        MultiBody.Parts.FixedTranslation fixedTranslation1(
          animation=false,
          r={0,0,0.05}) annotation(Placement(transformation(extent={{-59,92},{-39,112}})));
        MultiBody.Parts.FixedRotation fixedRotation1(
          animation=false,
          rotationType=MultiBody.Types.RotationTypes.PlanarRotationSequence,
          n={0,1,0},
          angle=60,
          angles={0,90,0}) annotation(Placement(transformation(extent={{36,67},{56,87}})));
        MultiBody.Parts.BodyShape bodyShape1(
          animateSphere=false,
          r={0,0,0},
          r_CM={0,0,0},
          m=0,
          I_11=1.5,
          I_22=0,
          I_33=0,
          length=0.05,
          width=0.2,
          color={255,255,0}) annotation(Placement(transformation(extent={{66,67},{86,87}})));
        MultiBody.Parts.FixedTranslation fixedTranslation2(
          animation=false,
          r={0,0,0.025}) annotation(Placement(transformation(extent={{1,92},{21,112}})));
        MultiBody.Forces.Torque torque1 annotation(Placement(transformation(extent={{-29,82},
                  {-9,62}})));
        Modelica.Blocks.Sources.Constant constVec3[3](k={0,0,1})
          annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
        MultiBody.Joints.GearConstraint gearConstraint(
          ratio=10,
          phi_b(fixed=true),
          w_b(fixed=true),
          checkTotalPower=true)
                           annotation(Placement(transformation(extent={{126,112},{146,
                  132}})));
        MultiBody.Parts.BodyCylinder cyl1(
          r={0.4,0,0},
          diameter=0.1,
          color={0,128,0},
          r_0(
            start={0,0,0},
            each fixed=false)) annotation(Placement(transformation(extent={{96,112},{116,132}})));
        MultiBody.Parts.BodyCylinder cyl2(
          r={0.4,0,0},
          diameter=0.2) annotation(Placement(transformation(extent={{160,112},{180,
                  132}})));
        MultiBody.Forces.Torque torque2 annotation(Placement(transformation(extent={{66,112},
                  {86,132}})));
        Modelica.Blocks.Sources.Sine sine[3](
          amplitude={2,0,0},
          f={1,1,1}) annotation(Placement(transformation(extent={{41,132},{61,152}})));
        MultiBody.Parts.FixedTranslation fixedTranslation4(
          animation=false,
          r={0.4,0,0}) annotation(Placement(transformation(extent={{36,92},{56,112}})));
        MultiBody.Joints.FreeMotion freeMotion2(
          animation=false,
          r_rel_a(each fixed=true),
          v_rel_a(each fixed=true),
          a_rel_a(each fixed=false),
          angles_fixed=true,
          w_rel_a_fixed=true,
          useQuaternions=false) annotation(Placement(transformation(extent={{-119,-58},
                  {-99,-38}})));
        MultiBody.Parts.Fixed fixed2 annotation(Placement(transformation(extent={{-149,
                  -58},{-129,-38}})));
        MultiBody.Parts.BodyBox bodyBox3(
          r={1,0,0},
          width=0.1,
          density=70) annotation(Placement(transformation(extent={{-89,-58},{-69,-38}})));
        MultiBody.Joints.Revolute revolute2(
          phi(fixed=true),
          w(fixed=true)) annotation(Placement(transformation(extent={{-29,-58},{-9,-38}})));
        MultiBody.Parts.FixedTranslation fixedTranslation5(
          animation=false,
          r={0,0,0.05}) annotation(Placement(transformation(extent={{-59,-58},{-39,-38}})));
        MultiBody.Parts.FixedRotation fixedRotation2(
          animation=false,
          rotationType=MultiBody.Types.RotationTypes.PlanarRotationSequence,
          n={0,1,0},
          angle=60,
          angles={0,90,0}) annotation(Placement(transformation(extent={{36,-83},{56,-63}})));
        MultiBody.Parts.BodyShape bodyShape2(
          animateSphere=false,
          r={0,0,0},
          r_CM={0,0,0},
          m=0,
          I_11=1.5,
          I_22=0,
          I_33=0,
          length=0.05,
          width=0.2,
          color={255,255,0}) annotation(Placement(transformation(extent={{66,-83},{86,
                  -63}})));
        MultiBody.Parts.FixedTranslation fixedTranslation7(
          animation=false,
          r={0,0,0.025}) annotation(Placement(transformation(extent={{1,-58},{21,-38}})));
        MultiBody.Forces.Torque torque3 annotation(Placement(transformation(extent={{-29,-30},
                  {-9,-10}})));
        MultiBody.Parts.FixedTranslation fixedTranslation8(
          animation=false,
          r={0.4,0,0}) annotation(Placement(transformation(extent={{36,-58},{56,-38}})));
        MultiBody.Parts.Rotor1D       inertia1(
          J=cyl1.I[1, 1],
          phi(
            fixed=true,
            start=0),
          w(fixed=true,
            start=0),
          a(fixed=false)) annotation(Placement(transformation(extent={{101,-8},{121,12}})));
        Modelica.Mechanics.Rotational.Components.IdealGear idealGear(
          useSupport=true,
          ratio=10) annotation(Placement(transformation(extent={{131,-8},{151,12}})));
        MultiBody.Parts.Rotor1D       inertia2(J=cyl2.I[1, 1]) annotation(Placement(transformation(extent={{160,-8},
                  {180,12}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque4(useSupport=true) annotation(Placement(transformation(extent={{71,-8},
                  {91,12}})));
        MultiBody.Parts.Mounting1D mounting1D annotation(Placement(transformation(extent={{56,-33},
                  {76,-13}})));
        Modelica.Blocks.Sources.Sine sine2(
          amplitude=2,
          f=1) annotation(Placement(transformation(extent={{31,-8},{51,12}})));
        MultiBody.Sensors.AbsoluteSensor absoluteSensor_MBS(get_r=
              true, get_angles=true)
          annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
        MultiBody.Sensors.AbsoluteSensor absoluteSensor_1D(get_r=
              true, get_angles=true)
          annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
        MultiBody.Parts.BodyCylinder cyl3(
          r={0.4,0,0},
          diameter=0.1,
          color={0,128,0},
          r_0(
            start={0,0,0},
            each fixed=false)) annotation(Placement(transformation(extent={{100,-80},{120,
                  -60}})));
        MultiBody.Parts.BodyCylinder cyl4(
          r={0.4,0,0},
          diameter=0.2) annotation(Placement(transformation(extent={{160,-80},{180,
                  -60}})));
      equation
          connect(freeMotion1.frame_b,bodyBox1.frame_a) annotation(Line(
            points={{-99,102},{-94,102},{-89,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(bodyBox1.frame_b,fixedTranslation1.frame_a) annotation(Line(
            points={{-69,102},{-64,102},{-59,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(revolute1.frame_a,fixedTranslation1.frame_b) annotation(Line(
            points={{-29,102},{-34,102},{-39,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(bodyShape1.frame_a,fixedRotation1.frame_b) annotation(Line(
            points={{66,77},{61,77},{56,77}},
            color={95,95,95},
            thickness=0.0625));
          connect(revolute1.frame_b,fixedTranslation2.frame_a) annotation(Line(
            points={{-9,102},{-4,102},{1,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(fixedRotation1.frame_a,fixedTranslation2.frame_b) annotation(Line(
            points={{36,77},{31,77},{26,77},{26,102},{21,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(torque1.frame_a,fixedTranslation1.frame_b) annotation(Line(
            points={{-29,72},{-34,72},{-34,102},{-39,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(torque1.frame_b,revolute1.frame_b) annotation(Line(
            points={{-9,72},{-4,72},{-4,102},{-9,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(fixed1.frame_b,freeMotion1.frame_a) annotation(Line(
            points={{-129,102},{-124,102},{-119,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(cyl1.frame_b,gearConstraint.frame_a) annotation(Line(
            points={{116,122},{121,122},{126,122}},
            color={95,95,95},
            thickness=0.5));
          connect(gearConstraint.frame_b,cyl2.frame_a) annotation(Line(
            points={{146,122},{151,122},{160,122}},
            color={95,95,95},
            thickness=0.5));
          connect(torque2.frame_b,cyl1.frame_a) annotation(Line(
            points={{86,122},{91,122},{96,122}},
            color={95,95,95},
            thickness=0.5));
          connect(sine.y,torque2.torque) annotation(Line(
            points={{62,142},{67,142},{70.7,142},{70.7,134},{70,134}}, color={0,0,127}));
          connect(torque2.frame_a,fixedTranslation4.frame_b) annotation(Line(
            points={{66,122},{61,122},{61,102},{56,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(gearConstraint.bearing,fixedTranslation4.frame_b) annotation(Line(
            points={{136,112},{136,107},{136,102},{61,102},{56,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(freeMotion2.frame_b,bodyBox3.frame_a) annotation(Line(
            points={{-99,-48},{-94,-48},{-89,-48}},
            color={95,95,95},
            thickness=0.0625));
          connect(bodyBox3.frame_b,fixedTranslation5.frame_a) annotation(Line(
            points={{-69,-48},{-64,-48},{-59,-48}},
            color={95,95,95},
            thickness=0.0625));
          connect(revolute2.frame_a,fixedTranslation5.frame_b) annotation(Line(
            points={{-29,-48},{-34,-48},{-39,-48}},
            color={95,95,95},
            thickness=0.0625));
          connect(bodyShape2.frame_a,fixedRotation2.frame_b) annotation(Line(
            points={{66,-73},{61,-73},{56,-73}},
            color={95,95,95},
            thickness=0.0625));
          connect(revolute2.frame_b,fixedTranslation7.frame_a) annotation(Line(
            points={{-9,-48},{-4,-48},{1,-48}},
            color={95,95,95},
            thickness=0.0625));
          connect(fixedRotation2.frame_a,fixedTranslation7.frame_b) annotation(Line(
            points={{36,-73},{31,-73},{26,-73},{26,-48},{21,-48}},
            color={95,95,95},
            thickness=0.0625));
          connect(torque3.frame_a,fixedTranslation5.frame_b) annotation(Line(
            points={{-29,-20},{-34,-20},{-34,-48},{-39,-48}},
            color={95,95,95},
            thickness=0.0625));
          connect(torque3.frame_b,revolute2.frame_b) annotation(Line(
            points={{-9,-20},{-4,-20},{-4,-48},{-9,-48}},
            color={95,95,95},
            thickness=0.0625));
          connect(fixed2.frame_b,freeMotion2.frame_a) annotation(Line(
            points={{-129,-48},{-124,-48},{-119,-48}},
            color={95,95,95},
            thickness=0.0625));
          connect(inertia1.flange_b,idealGear.flange_a) annotation(Line(
            points={{121,2},{126,2},{131,2}}));
          connect(idealGear.flange_b,inertia2.flange_a) annotation(Line(
            points={{151,2},{160,2}}));
          connect(torque4.flange,inertia1.flange_a) annotation(Line(
            points={{91,2},{96,2},{101,2}}));
          connect(mounting1D.flange_b,idealGear.support) annotation(Line(
            points={{76,-23},{81,-23},{141,-23},{141,-13},{141,-8}}));
          connect(mounting1D.flange_b,torque4.support) annotation(Line(
            points={{76,-23},{81,-23},{81,-13},{81,-8}}));
          connect(mounting1D.frame_a,fixedTranslation8.frame_b) annotation(Line(
            points={{66,-33},{66,-38},{66,-48},{61,-48},{56,-48}},
            color={95,95,95},
            thickness=0.0625));
          connect(fixedTranslation4.frame_a,fixedTranslation2.frame_b) annotation(Line(
            points={{36,102},{31,102},{26,102},{21,102}},
            color={95,95,95},
            thickness=0.0625));
          connect(fixedTranslation8.frame_a,fixedTranslation7.frame_b) annotation(Line(
            points={{36,-48},{31,-48},{26,-48},{21,-48}},
            color={95,95,95},
            thickness=0.0625));
          connect(sine2.y,torque4.tau) annotation(Line(
            points={{52,2},{57,2},{64,2},{69,2}},
            color={0,0,127},
            thickness=0.0625));
        connect(freeMotion2.frame_b, absoluteSensor_1D.frame_a) annotation (Line(
            points={{-99,-48},{-99,-10},{-90,-10}},
            color={95,95,95},
            thickness=0.5));
        connect(freeMotion1.frame_b, absoluteSensor_MBS.frame_a) annotation (Line(
            points={{-99,102},{-98,102},{-98,20},{-90,20}},
            color={95,95,95},
            thickness=0.5));
        connect(inertia1.frame_a, fixedTranslation8.frame_b) annotation (Line(
            points={{111,-8},{111,-48},{56,-48}},
            color={95,95,95},
            thickness=0.5));
        connect(inertia2.frame_a, fixedTranslation8.frame_b) annotation (Line(
            points={{170,-8},{170,-48},{56,-48}},
            color={95,95,95},
            thickness=0.5));
        connect(cyl3.frame_b, cyl4.frame_a) annotation (Line(
            points={{120,-70},{160,-70}},
            color={95,95,95},
            thickness=0.5));
        connect(cyl3.frame_b, fixedTranslation8.frame_b) annotation (Line(
            points={{120,-70},{132,-70},{132,-48},{56,-48}},
            color={95,95,95},
            thickness=0.5));
        connect(constVec3.y, torque1.torque) annotation (Line(
            points={{-39,50},{-25,50},{-25,60}}, color={0,0,127}));
        connect(constVec3.y, torque3.torque) annotation (Line(
            points={{-39,50},{-26,50},{-26,-8},{-25,-8}}, color={0,0,127}));
        annotation (
          experiment(StopTime=2),
          Diagram(coordinateSystem(extent={{-160,-120},{180,160}},
                preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-64,34},{-96,-32}},
                lineColor={255,85,85},
                lineThickness=0.5),
              Text(
                extent={{-150,-72},{-56,-90}},
                textColor={255,85,85},
                lineThickness=0.5,
                fillPattern=FillPattern.Solid,
                textString="Compare angles and position vector r",
                fontSize=11),
              Line(
                points={{-112,-72},{-88,-28}},
                color={255,85,85},
                thickness=0.5,
                arrow={Arrow.None,Arrow.Filled})}),
          Documentation(info="<html>
<p>
This test model was proposed in ticket <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/951\">#951 (comment:4)</a>.
</p>
</html>"));
      end GearConstraint4;

      model Bevel1D
        extends Modelica.Icons.Example;
        parameter Real tol=1e-3;

        MultiBody.Joints.GearConstraint gearConstraint(
          ratio=10,
          phi_b(fixed=true),
          w_b(fixed=true)) annotation (Placement(transformation(extent={{40,40},
                  {60,60}})));
        inner MultiBody.World world(g=0,
            driveTrainMechanics3D=true) annotation (Placement(transformation(
                extent={{-60,10},{-40,30}})));
        MultiBody.Parts.BodyCylinder cyl1(
          diameter=0.1,
          color={0,128,0},
          r={0.4,0,0}) annotation (Placement(transformation(extent={{10,40},{30,
                  60}})));
        MultiBody.Parts.BodyCylinder cyl2(r={0.4,0,0},
            diameter=0.2) annotation (Placement(transformation(extent={{70,40},
                  {90,60}})));
        MultiBody.Forces.Torque torque1(resolveInFrame=
              MultiBody.Types.ResolveInFrameAB.frame_b)
          annotation (Placement(transformation(extent={{-20,40},{0,60}})));
        Modelica.Blocks.Sources.Sine sine[3](amplitude={2,0,0}, f={1,1,1})
          annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
        MultiBody.Parts.Fixed fixed annotation (Placement(
              transformation(extent={{-8,-76},{12,-56}})));
        Modelica.Mechanics.Rotational.Components.Inertia inertia1(
          J=cyl1.I[1, 1],
          a(fixed=false),
          phi(fixed=true, start=0),
          w(fixed=true, start=0)) annotation (Placement(transformation(extent={
                  {-20,-40},{0,-20}})));
        Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=cyl2.I[1, 1])
          annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=false)
          annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
        MultiBody.Parts.BevelGear1D bevelGear1D(ratio=10)
          annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
      equation
        assert(cyl2.body.w_a[1] - inertia2.w < tol,
          "Error, difference between angular velocities too big");
        connect(world.frame_b, gearConstraint.bearing) annotation (Line(
            points={{-40,20},{50,20},{50,40}},
            color={95,95,95},
            thickness=0.5));
        connect(cyl1.frame_b, gearConstraint.frame_a) annotation (Line(
            points={{30,50},{40,50}},
            color={95,95,95},
            thickness=0.5));
        connect(gearConstraint.frame_b, cyl2.frame_a) annotation (Line(
            points={{60,50},{70,50}},
            color={95,95,95},
            thickness=0.5));
        connect(torque1.frame_b, cyl1.frame_a) annotation (Line(
            points={{0,50},{10,50}},
            color={95,95,95},
            thickness=0.5));
        connect(torque1.frame_a, world.frame_b) annotation (Line(
            points={{-20,50},{-30,50},{-30,20},{-40,20}},
            color={95,95,95},
            thickness=0.5));
        connect(sine.y, torque1.torque) annotation (Line(
            points={{-79,70},{-16,70},{-16,62}}, color={0,0,127}));
        connect(torque2.flange, inertia1.flange_a) annotation (Line(
            points={{-30,-30},{-20,-30}}));
        connect(sine[1].y, torque2.tau) annotation (Line(
            points={{-79,70},{-72,70},{-72,-30},{-52,-30}}, color={0,0,127}));
        connect(inertia1.flange_b, bevelGear1D.flange_a) annotation (Line(
            points={{0,-30},{10,-30}}));
        connect(bevelGear1D.flange_b, inertia2.flange_a) annotation (Line(
            points={{30,-30},{40,-30}}));
        connect(fixed.frame_b, bevelGear1D.frame_a) annotation (Line(
            points={{12,-66},{20,-66},{20,-40}},
            color={95,95,95},
            thickness=0.5));
        annotation (experiment(StopTime=5));
      end Bevel1D;
    end Rotor1D;
  end Parts;

  package Sensors "Test MultiBody.Sensors"
    extends Modelica.Icons.ExamplesPackage;

    model AbsoluteSensor "Simple pendulum with one revolute joint and one body"
      extends Modelica.Icons.Example;
      parameter Real tol=1e-3;
      inner MultiBody.World world(gravityType=MultiBody.Types.GravityTypes.UniformGravity)
        annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      MultiBody.Joints.Revolute rev(
        n={0,0,1},
        useAxisFlange=true,
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(extent={{-40,0},{-20,
                20}})));
      Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1) annotation (
         Placement(transformation(extent={{-40,40},{-20,60}})));
      MultiBody.Parts.BodyBox box(r={1,0,0}, animation=false)
        annotation (Placement(transformation(extent={{0,0},{20,20}})));
      MultiBody.Sensors.AbsoluteSensor sensor_frame_a1(
        get_angles=true,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_a,
        get_r=true,
        get_v=true,
        get_a=true,
        get_w=true,
        get_z=true) annotation (Placement(transformation(extent={{40,40},{60,20}})));

      MultiBody.Sensors.AbsoluteSensor sensor_world1(
        get_angles=true,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.world,
        get_r=true,
        get_v=true,
        get_a=true,
        get_w=true,
        get_z=true) annotation (Placement(transformation(extent={{40,-20},{60,0}})));

      MultiBody.Sensors.AbsoluteSensor sensor_frame_a2(
        get_angles=true,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_resolve,
        get_r=true,
        get_v=true,
        get_a=true,
        get_w=true,
        get_z=true) annotation (Placement(transformation(extent={{40,60},{60,80}})));

      MultiBody.Sensors.AbsoluteSensor sensor_world2(
        get_angles=true,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_resolve,
        get_r=true,
        get_v=true,
        get_a=true,
        get_w=true,
        get_z=true) annotation (Placement(transformation(extent={{40,-40},{60,-60}})));

      Modelica.Blocks.Math.Add err1[18](each k2=-1) annotation (Placement(
            transformation(extent={{80,40},{100,60}})));
      Modelica.Blocks.Math.Add err2[18](each k2=-1) annotation (Placement(
            transformation(extent={{80,-40},{100,-20}})));
    equation
      for i in 1:18 loop
        assert(err1[i].y < tol and err2[i].y < tol,
          "Errors must be less then tolerance");
      end for;
      connect(world.frame_b, rev.frame_a) annotation (Line(
          points={{-60,10},{-40,10}},
          thickness=0.5));
      connect(damper.flange_b, rev.axis) annotation (Line(points={{-20,50},{-20,
              50},{-20,30},{-30,30},{-30,20}}));
      connect(rev.support, damper.flange_a) annotation (Line(points={{-36,20},{
              -36,30},{-40,30},{-40,50}}));
      connect(rev.frame_b, box.frame_a) annotation (Line(
          points={{-20,10},{0,10}},
          thickness=0.5));
      connect(box.frame_b, sensor_frame_a1.frame_a) annotation (Line(
          points={{20,10},{30,10},{30,30},{40,30}},
          thickness=0.5));
      connect(box.frame_b, sensor_world1.frame_a) annotation (Line(
          points={{20,10},{30,10},{30,-10},{40,-10}},
          thickness=0.5));
      connect(box.frame_b, sensor_frame_a2.frame_a) annotation (Line(
          points={{20,10},{30,10},{30,70},{40,70}},
          thickness=0.5));
      connect(box.frame_b, sensor_world2.frame_a) annotation (Line(
          points={{20,10},{30,10},{30,-50},{40,-50}},
          thickness=0.5));
      connect(sensor_world2.frame_resolve, world.frame_b) annotation (Line(
          points={{60,-50},{60,-50},{70,-50},{70,-76},{-50,-76},{-50,10},{-60,
              10}},
          pattern=LinePattern.Dot));

      connect(sensor_frame_a2.frame_resolve, rev.frame_b) annotation (Line(
          points={{60,70},{60,70},{70,70},{70,90},{-10,90},{-10,10},{-20,10}},
          pattern=LinePattern.Dot));
      connect(sensor_frame_a2.r[1:3], err1[1:3].u1) annotation (Line(
          points={{40,58.3333},{40,56},{78,56}}, color={0,0,127}));
      connect(sensor_frame_a2.v[1:3], err1[4:6].u1) annotation (Line(
          points={{44,58.3333},{44,56},{78,56}}, color={0,0,127}));
      connect(sensor_frame_a2.a[1:3], err1[7:9].u1) annotation (Line(
          points={{48,58.3333},{48,56},{78,56}}, color={0,0,127}));
      connect(sensor_frame_a2.angles[1:3], err1[10:12].u1) annotation (Line(
          points={{52,58.3333},{52,56},{78,56}}, color={0,0,127}));
      connect(sensor_frame_a2.w[1:3], err1[13:15].u1) annotation (Line(
          points={{56,58.3333},{56,56},{78,56}}, color={0,0,127}));
      connect(sensor_frame_a2.z[1:3], err1[16:18].u1) annotation (Line(
          points={{60,58.3333},{60,56},{78,56}}, color={0,0,127}));
      connect(sensor_frame_a1.r[1:3], err1[1:3].u2) annotation (Line(
          points={{40,41.6667},{40,44},{78,44}}, color={0,0,127}));
      connect(sensor_frame_a1.v[1:3], err1[4:6].u2) annotation (Line(
          points={{44,41.6667},{44,44},{78,44}}, color={0,0,127}));
      connect(sensor_frame_a1.a[1:3], err1[7:9].u2) annotation (Line(
          points={{48,41.6667},{48,44},{78,44}}, color={0,0,127}));
      connect(sensor_frame_a1.angles[1:3], err1[10:12].u2) annotation (Line(
          points={{52,41.6667},{52,44},{78,44}}, color={0,0,127}));
      connect(sensor_frame_a1.w[1:3], err1[13:15].u2) annotation (Line(
          points={{56,41.6667},{56,44},{78,44}}, color={0,0,127}));
      connect(sensor_frame_a1.z[1:3], err1[16:18].u2) annotation (Line(
          points={{60,41.6667},{60,44},{78,44}}, color={0,0,127}));
      connect(sensor_world1.r[1:3], err2[1:3].u1) annotation (Line(
          points={{40,-21.6667},{40,-24},{78,-24}}, color={0,0,127}));
      connect(sensor_world1.v[1:3], err2[4:6].u1) annotation (Line(
          points={{44,-21.6667},{44,-24},{78,-24}}, color={0,0,127}));
      connect(sensor_world1.a[1:3], err2[7:9].u1) annotation (Line(
          points={{48,-21.6667},{48,-24},{78,-24}}, color={0,0,127}));
      connect(sensor_world1.angles[1:3], err2[10:12].u1) annotation (Line(
          points={{52,-21.6667},{52,-24},{78,-24}}, color={0,0,127}));
      connect(sensor_world1.w[1:3], err2[13:15].u1) annotation (Line(
          points={{56,-21.6667},{56,-24},{78,-24}}, color={0,0,127}));
      connect(sensor_world1.z[1:3], err2[16:18].u1) annotation (Line(
          points={{60,-21.6667},{60,-24},{78,-24}}, color={0,0,127}));
      connect(sensor_world2.r[1:3], err2[1:3].u2) annotation (Line(
          points={{40,-38.3333},{40,-36},{78,-36}}, color={0,0,127}));
      connect(sensor_world2.v[1:3], err2[4:6].u2) annotation (Line(
          points={{44,-38.3333},{44,-36},{78,-36}}, color={0,0,127}));
      connect(sensor_world2.a[1:3], err2[7:9].u2) annotation (Line(
          points={{48,-38.3333},{48,-36},{78,-36}}, color={0,0,127}));
      connect(sensor_world2.angles[1:3], err2[10:12].u2) annotation (Line(
          points={{52,-38.3333},{52,-36},{78,-36}}, color={0,0,127}));
      connect(sensor_world2.w[1:3], err2[13:15].u2) annotation (Line(
          points={{56,-38.3333},{56,-36},{78,-36}}, color={0,0,127}));
      connect(sensor_world2.z[1:3], err2[16:18].u2) annotation (Line(
          points={{60,-38.3333},{60,-36},{78,-36}}, color={0,0,127}));
      annotation (experiment(StopTime=5), Documentation(info=""));
    end AbsoluteSensor;

    model AbsoluteSensor2
      extends Modelica.Icons.Example;
      inner MultiBody.World world(animateWorld=true,
          animateGravity=true) annotation (Placement(transformation(extent={{-80,
                -10},{-60,10}})));
      MultiBody.Parts.FixedRotation fixedRotation(
        r={0.5,0.5,0.1},
        rotationType=MultiBody.Types.RotationTypes.PlanarRotationSequence,
        angles={45,45,45},
        animation=false) annotation (Placement(transformation(extent={{-40,-10},
                {-20,10}})));

      MultiBody.Visualizers.FixedFrame frame_a(color_x={0,
            128,255}) annotation (Placement(transformation(
            origin={-10,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Sensors.AbsoluteSensor freeMotion(
          resolveInFrame=MultiBody.Types.ResolveInFrameA.world,
          get_r=true)
        annotation (Placement(transformation(extent={{16,-8},{36,12}})));
    equation
      connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
          points={{-60,0},{-40,0}},
          thickness=0.5));
      connect(fixedRotation.frame_b, freeMotion.frame_a) annotation (Line(
          points={{-20,0},{-6,0},{-6,2},{16,2}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation.frame_b, frame_a.frame_a) annotation (Line(
          points={{-20,0},{-10,0},{-10,-30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end AbsoluteSensor2;

    model RelativeSensor
      extends Modelica.Icons.Example;
      parameter Real tol=1e-3;
      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-100,20},{-80,40}})));
      MultiBody.Joints.Revolute revolute(
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(extent={{-70,20},{-50,
                40}})));
      MultiBody.Parts.BodyBox BodyBox1(r={0.7,0,0}) annotation (Placement(transformation(
              extent={{-40,20},{-20,40}})));
      MultiBody.Parts.Fixed fixed(r={-0.9,0,0.3}) annotation (Placement(transformation(
              extent={{-100,-80},{-80,-60}})));
      MultiBody.Joints.Revolute revolute1(
        a(fixed=false),
        phi(fixed=true, start=0.7853981633974483),
        w(fixed=true)) annotation (Placement(transformation(extent={{-70,-80},{
                -50,-60}})));
      MultiBody.Parts.BodyBox BodyBox2(r={0.7,0,0}) annotation (Placement(transformation(
              extent={{-40,-80},{-20,-60}})));
      MultiBody.Sensors.RelativeSensor relative_a1(
        get_r_rel=true,
        get_v_rel=true,
        get_a_rel=true,
        get_w_rel=true,
        get_z_rel=true,
        get_angles=true,
        resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_a)
        annotation (Placement(transformation(
            origin={30,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Sensors.RelativeSensor relative_a2(
        get_r_rel=true,
        get_v_rel=true,
        get_a_rel=true,
        get_w_rel=true,
        get_z_rel=true,
        get_angles=true,
        resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve)
        annotation (Placement(transformation(
            origin={50,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Math.Add err1[18](each k2=-1) annotation (Placement(
            transformation(extent={{80,-30},{100,-10}})));
      MultiBody.Sensors.RelativeSensor relative_b2(
        resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_resolve,
        get_r_rel=true,
        get_v_rel=true,
        get_a_rel=true,
        get_w_rel=true,
        get_z_rel=true,
        get_angles=true) annotation (Placement(transformation(
            origin={-10,-10},
            extent={{-10,10},{10,-10}},
            rotation=90)));

      MultiBody.Sensors.RelativeSensor relative_b1(
        resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_b,
        get_r_rel=true,
        get_v_rel=true,
        get_a_rel=true,
        get_w_rel=true,
        get_z_rel=true,
        get_angles=true) annotation (Placement(transformation(
            origin={10,-40},
            extent={{-10,10},{10,-10}},
            rotation=90)));

      Modelica.Blocks.Math.Add err2[18](each k2=-1) annotation (Placement(
            transformation(extent={{-40,-10},{-60,-30}})));
      MultiBody.Sensors.RelativeSensor relativeSensor(
        resolveInFrame=MultiBody.Types.ResolveInFrameAB.frame_a,
        get_r_rel=true,
        get_angles=true,
        sequence={3,2,1})
        annotation (Placement(transformation(extent={{-70,50},{-50,70}})));

    equation
      for i in 1:18 loop
        assert(err1[i].y < tol and err2[i].y < tol,
          "Errors must be less then tolerance");
      end for;
      connect(relative_a2.frame_resolve, revolute1.frame_b) annotation (Line(
          points={{42,-30},{42,-28},{34,-28},{34,-60},{-46,-60},{-46,-70},{-50,
              -70}},
          pattern=LinePattern.Dot));
      connect(relative_b2.frame_resolve, BodyBox1.frame_a) annotation (Line(
          points={{-2,0},{-2,0},{-2,10},{-2,10},{-46,10},{-46,30},{-40,30}},
          pattern=LinePattern.Dot));
      connect(fixed.frame_b, revolute1.frame_a) annotation (Line(
          points={{-80,-70},{-70,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute1.frame_b, BodyBox2.frame_a) annotation (Line(
          points={{-50,-70},{-40,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute.frame_b, BodyBox1.frame_a) annotation (Line(
          points={{-50,30},{-40,30}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, revolute.frame_a) annotation (Line(
          points={{-80,30},{-70,30}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, relativeSensor.frame_a) annotation (Line(
          points={{-80,30},{-74,30},{-74,60},{-70,60}},
          color={95,95,95},
          thickness=0.5));
      connect(relativeSensor.frame_b, revolute.frame_b) annotation (Line(
          points={{-50,60},{-46,60},{-46,30},{-50,30}},
          color={95,95,95},
          thickness=0.5));
      connect(relative_a1.r_rel[1:3], err1[1:3].u1) annotation (Line(
          points={{41.6667,-20},{46,-20},{46,-14},{78,-14}}, color={0,0,127}));
      connect(relative_a1.v_rel[1:3], err1[4:6].u1) annotation (Line(
          points={{41.6667,-16},{46,-16},{46,-14},{78,-14}}, color={0,0,127}));
      connect(relative_a1.a_rel[1:3], err1[7:9].u1) annotation (Line(
          points={{41.6667,-12},{46,-12},{46,-14},{78,-14}}, color={0,0,127}));
      connect(relative_a1.angles[1:3], err1[10:12].u1) annotation (Line(
          points={{41.6667,-8},{46,-8},{46,-14},{78,-14}}, color={0,0,127}));
      connect(relative_a1.w_rel[1:3], err1[13:15].u1) annotation (Line(
          points={{41.6667,-4},{46,-4},{46,-14},{78,-14}}, color={0,0,127}));
      connect(relative_a1.z_rel[1:3], err1[16:18].u1) annotation (Line(
          points={{41.6667,0},{46,0},{46,-14},{78,-14}}, color={0,0,127}));
      connect(relative_a2.r_rel[1:3], err1[1:3].u2) annotation (Line(
          points={{61.6667,-50},{70,-50},{70,-26},{78,-26}}, color={0,0,127}));
      connect(relative_a2.v_rel[1:3], err1[4:6].u2) annotation (Line(
          points={{61.6667,-46},{70,-46},{70,-26},{78,-26}}, color={0,0,127}));
      connect(relative_a2.a_rel[1:3], err1[7:9].u2) annotation (Line(
          points={{61.6667,-42},{70,-42},{70,-26},{78,-26}}, color={0,0,127}));
      connect(relative_a2.angles[1:3], err1[10:12].u2) annotation (Line(
          points={{61.6667,-38},{70,-38},{70,-26},{78,-26}}, color={0,0,127}));
      connect(relative_a2.w_rel[1:3], err1[13:15].u2) annotation (Line(
          points={{61.6667,-34},{70,-34},{70,-26},{78,-26}}, color={0,0,127}));
      connect(relative_a2.z_rel[1:3], err1[16:18].u2) annotation (Line(
          points={{61.6667,-30},{70,-30},{70,-26},{78,-26}}, color={0,0,127}));
      connect(relative_b1.r_rel[1:3], err2[1:3].u1) annotation (Line(
          points={{-1.66667,-50},{-6,-50},{-6,-26},{-38,-26}}, color={0,0,127}));
      connect(relative_b1.v_rel[1:3], err2[4:6].u1) annotation (Line(
          points={{-1.66667,-46},{-6,-46},{-6,-26},{-38,-26}}, color={0,0,127}));
      connect(relative_b1.a_rel[1:3], err2[7:9].u1) annotation (Line(
          points={{-1.66667,-42},{-6,-42},{-6,-26},{-38,-26}}, color={0,0,127}));
      connect(relative_b1.angles[1:3], err2[10:12].u1) annotation (Line(
          points={{-1.66667,-38},{-6,-38},{-6,-26},{-38,-26}}, color={0,0,127}));
      connect(relative_b1.w_rel[1:3], err2[13:15].u1) annotation (Line(
          points={{-1.66667,-34},{-6,-34},{-6,-26},{-38,-26}}, color={0,0,127}));
      connect(relative_b1.z_rel[1:3], err2[16:18].u1) annotation (Line(
          points={{-1.66667,-30},{-6,-30},{-6,-26},{-38,-26}}, color={0,0,127}));
      connect(relative_b2.r_rel[1:3], err2[1:3].u2) annotation (Line(
          points={{-21.6667,-20},{-26,-20},{-26,-14},{-38,-14}}, color={0,0,127}));
      connect(relative_b2.v_rel[1:3], err2[4:6].u2) annotation (Line(
          points={{-21.6667,-16},{-26,-16},{-26,-14},{-38,-14}}, color={0,0,127}));
      connect(relative_b2.a_rel[1:3], err2[7:9].u2) annotation (Line(
          points={{-21.6667,-12},{-26,-12},{-26,-14},{-38,-14}}, color={0,0,127}));
      connect(relative_b2.angles[1:3], err2[10:12].u2) annotation (Line(
          points={{-21.6667,-8},{-26,-8},{-26,-14},{-38,-14}}, color={0,0,127}));
      connect(relative_b2.w_rel[1:3], err2[13:15].u2) annotation (Line(
          points={{-21.6667,-4},{-26,-4},{-26,-14},{-38,-14}}, color={0,0,127}));
      connect(relative_b2.z_rel[1:3], err2[16:18].u2) annotation (Line(
          points={{-21.6667,0},{-26,0},{-26,-14},{-38,-14}}, color={0,0,127}));
      connect(relative_a1.frame_a, BodyBox2.frame_b) annotation (Line(
          points={{30,-20},{30,-70},{-20,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(relative_a2.frame_a, BodyBox2.frame_b) annotation (Line(
          points={{50,-50},{50,-70},{-20,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(relative_b1.frame_a, BodyBox2.frame_b) annotation (Line(
          points={{10,-50},{10,-70},{-20,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(relative_b2.frame_a, BodyBox2.frame_b) annotation (Line(
          points={{-10,-20},{-10,-70},{-20,-70}},
          color={95,95,95},
          thickness=0.5));
      connect(relative_a1.frame_b, BodyBox1.frame_b) annotation (Line(
          points={{30,0},{30,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(relative_a2.frame_b, BodyBox1.frame_b) annotation (Line(
          points={{50,-30},{52,-30},{52,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(relative_b1.frame_b, BodyBox1.frame_b) annotation (Line(
          points={{10,-30},{12,-30},{12,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(relative_b2.frame_b, BodyBox1.frame_b) annotation (Line(
          points={{-10,0},{-10,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=2));
    end RelativeSensor;

    model Distance "Test Sensors.Distance"
      extends Modelica.Icons.Example;
      inner MultiBody.World world(gravityType=MultiBody.Types.GravityTypes.UniformGravity)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      MultiBody.Joints.Revolute rev(
        n={0,0,1},
        useAxisFlange=true,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(extent={{-20,0},{0,
                20}})));
      Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1) annotation (
         Placement(transformation(extent={{-20,40},{0,60}})));
      MultiBody.Parts.Fixed fixed(r={0,-1,0}) annotation (
          Placement(transformation(
            origin={-50,-50},
            extent={{-10,-10},{10,10}})));
      MultiBody.Sensors.Distance Distance1 annotation (
          Placement(transformation(extent={{-20,-60},{0,-40}})));
      MultiBody.Parts.BodyBox BodyBox1(r={0.5,0,0})
        annotation (Placement(transformation(extent={{20,0},{40,20}})));
      Modelica.Blocks.Continuous.Der Der1 annotation (Placement(transformation(
              extent={{0,-100},{20,-80}})));
      Modelica.Blocks.Continuous.Der Der2 annotation (Placement(transformation(
              extent={{40,-100},{60,-80}})));
    equation
      connect(world.frame_b, rev.frame_a) annotation (Line(
          points={{-40,10},{-20,10}},
          thickness=0.5));
      connect(damper.flange_b, rev.axis) annotation (Line(points={{0,50},{4,50},
              {4,26},{-10,26},{-10,20}}));
      connect(rev.support, damper.flange_a) annotation (Line(points={{-16,20},{
              -16,26},{-28,26},{-28,50},{-20,50}}));
      connect(rev.frame_b, BodyBox1.frame_a) annotation (Line(
          points={{0,10},{20,10}},
          thickness=0.5));
      connect(Distance1.frame_b, BodyBox1.frame_b) annotation (Line(
          points={{0,-50},{60,-50},{60,10},{40,10}},
          thickness=0.5));
      connect(Distance1.frame_a, fixed.frame_b) annotation (Line(
          points={{-20,-50},{-40,-50}},
          thickness=0.5));
      connect(Der1.y, Der2.u)
        annotation (Line(points={{21,-90},{38,-90}}, color={0,0,255}));
      connect(Distance1.distance, Der1.u) annotation (Line(
          points={{-10,-61},{-10,-90},{-2,-90}}, color={0,0,127}));
      annotation (experiment(StopTime=5));
    end Distance;

    model Distance2 "Test MultiBody.Sensors.Distance"
      extends Modelica.Icons.Example;

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,0},{-60,20}})));
      MultiBody.Joints.Revolute Revolute1(
        a(fixed=false),
        phi(fixed=true, start=0.5235987755982988),
        w(fixed=true)) annotation (Placement(transformation(extent={{-40,0},{-20,
                20}})));
      MultiBody.Parts.BodyBox BodyBox1(r={1,0,0}, width=0.08)
        annotation (Placement(transformation(extent={{0,0},{20,20}})));
      MultiBody.Parts.Fixed fixed(r={1,0,0}) annotation (
          Placement(transformation(
            origin={70,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      MultiBody.Sensors.Distance distance1 annotation (
          Placement(transformation(extent={{40,0},{60,20}})));
      Modelica.Blocks.Continuous.Der Der1 annotation (Placement(transformation(
              extent={{60,-30},{80,-10}})));
      Modelica.Blocks.Logical.LessEqualThreshold LessEqualThreshold1
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      MultiBody.Sensors.Distance distance2 annotation (
          Placement(transformation(extent={{-40,30},{-20,50}})));
    equation
      connect(world.frame_b, Revolute1.frame_a) annotation (Line(
          points={{-60,10},{-40,10}},
          thickness=0.5));
      connect(Revolute1.frame_b, BodyBox1.frame_a) annotation (Line(
          points={{-20,10},{0,10}},
          thickness=0.5));
      connect(BodyBox1.frame_b, distance1.frame_a) annotation (Line(
          points={{20,10},{40,10}},
          thickness=0.5));
      connect(distance1.frame_b, fixed.frame_b) annotation (Line(
          points={{60,10},{70,10},{70,40}},
          thickness=0.5));
      connect(distance1.distance, Der1.u)
        annotation (Line(points={{50,-1},{50,-20},{58,-20}}, color={0,0,127}));
      connect(distance1.distance, LessEqualThreshold1.u)
        annotation (Line(points={{50,-1},{50,-50},{58,-50}}, color={0,0,127}));
      connect(Revolute1.frame_a, distance2.frame_a) annotation (Line(
          points={{-40,10},{-50,10},{-50,40},{-40,40}},
          thickness=0.5));
      connect(Revolute1.frame_b, distance2.frame_b) annotation (Line(
          points={{-20,10},{-10,10},{-10,40},{-20,40}},
          thickness=0.5));
      annotation (experiment(StopTime=0.5, Tolerance=1e-010));
    end Distance2;

    model CutForce
      extends Modelica.Icons.Example;
      parameter Real tol=1e-3;
      inner MultiBody.World world(defaultN_to_m=10) annotation (Placement(
            transformation(extent={{-100,0},{-80,20}})));
      MultiBody.Sensors.CutForce cutForce1a
        annotation (Placement(transformation(extent={{-20,20},{0,0}})));
      MultiBody.Parts.FixedTranslation translate1a(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,10},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body1a(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,0},{80,20}})));
      MultiBody.Sensors.CutForce cutForce2a(
        positiveSign=false,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.world)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      MultiBody.Parts.FixedTranslation translate2a(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-30},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body2a(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
      MultiBody.Parts.FixedRotation rotate1a(
        n={0,0,1},
        angle=90,
        r={0,0,-0.2}) annotation (Placement(transformation(extent={{-60,0},{-40,
                20}})));
      MultiBody.Parts.FixedRotation rotate2a(
        n={0,0,1},
        angle=90,
        r={0,0,0.2}) annotation (Placement(transformation(extent={{-60,-40},{-40,
                -20}})));
      MultiBody.Sensors.CutForce cutForce1b(
          resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_resolve)
        annotation (Placement(transformation(extent={{-20,60},{0,80}})));
      MultiBody.Parts.FixedTranslation translate1b(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body1b(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      MultiBody.Parts.FixedRotation rotate1b(
        n={0,0,1},
        angle=90,
        r={0,0,-0.6}) annotation (Placement(transformation(extent={{-60,60},{-40,
                80}})));
      Modelica.Blocks.Math.Add err1[3](each k2=-1) annotation (Placement(
            transformation(extent={{10,30},{30,50}})));
      MultiBody.Sensors.CutForce cutForce2b(
        positiveSign=false,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_resolve)
        annotation (Placement(transformation(extent={{-20,-80},{0,-100}})));
      MultiBody.Parts.FixedTranslation translate2b(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-90},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body2b(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
      MultiBody.Parts.FixedRotation rotate2b(
        n={0,0,1},
        angle=90,
        r={0,0,0.6}) annotation (Placement(transformation(extent={{-60,-100},{-40,
                -80}})));
      Modelica.Blocks.Math.Add err2[3](each k2=-1) annotation (Placement(
            transformation(extent={{10,-70},{30,-50}})));
    equation
      for i in 1:3 loop
        assert(err1[i].y < tol and err2[i].y < tol,
          "Errors must be less then tolerance");
      end for;

      connect(world.frame_b, rotate1a.frame_a) annotation (Line(
          points={{-80,10},{-60,10}},
          thickness=0.5));
      connect(rotate1a.frame_b, cutForce1a.frame_a) annotation (Line(
          points={{-40,10},{-20,10}},
          thickness=0.5));
      connect(rotate2a.frame_b, cutForce2a.frame_a) annotation (Line(
          points={{-40,-30},{-20,-30}},
          thickness=0.5));
      connect(rotate2a.frame_a, world.frame_b) annotation (Line(
          points={{-60,-30},{-70,-30},{-70,10},{-80,10}},
          thickness=0.5));
      connect(rotate1b.frame_b, cutForce1b.frame_a) annotation (Line(
          points={{-40,70},{-20,70}},
          thickness=0.5));
      connect(cutForce1b.frame_resolve, rotate1b.frame_b) annotation (Line(
          points={{-2,60},{-2,60},{-2,50},{-40,50},{-40,70}},
          pattern=LinePattern.Dot));
      connect(world.frame_b, rotate1b.frame_a) annotation (Line(
          points={{-80,10},{-70,10},{-70,70},{-60,70}},
          thickness=0.5));
      connect(rotate2b.frame_b, cutForce2b.frame_a) annotation (Line(
          points={{-40,-90},{-20,-90}},
          thickness=0.5));
      connect(rotate2b.frame_a, world.frame_b) annotation (Line(
          points={{-60,-90},{-70,-90},{-70,10},{-80,10}},
          thickness=0.5));
      connect(cutForce2b.frame_resolve, world.frame_b) annotation (Line(
          points={{-2,-80},{-2,-60},{-74,-60},{-74,10},{-80,10}},
          pattern=LinePattern.Dot));
      connect(cutForce1b.frame_b, translate1b.frame_a) annotation (Line(
          points={{0,70},{20,70}},
          thickness=0.5));
      connect(translate1b.frame_b, body1b.frame_a) annotation (Line(
          points={{40,70},{60,70}},
          thickness=0.5));
      connect(cutForce1a.frame_b, translate1a.frame_a) annotation (Line(
          points={{0,10},{10,10},{10,10},{20,10}},
          thickness=0.5));
      connect(translate1a.frame_b, body1a.frame_a) annotation (Line(
          points={{40,10},{50,10},{60,10}},
          thickness=0.5));
      connect(cutForce2a.frame_b, translate2a.frame_a) annotation (Line(
          points={{0,-30},{20,-30}},
          thickness=0.5));
      connect(translate2a.frame_b, body2a.frame_a) annotation (Line(
          points={{40,-30},{60,-30}},
          thickness=0.5));
      connect(cutForce2b.frame_b, translate2b.frame_a) annotation (Line(
          points={{0,-90},{20,-90}},
          thickness=0.5));
      connect(translate2b.frame_b, body2b.frame_a) annotation (Line(
          points={{40,-90},{60,-90}},
          thickness=0.5));
      connect(cutForce1b.force, err1.u1) annotation (Line(
          points={{-18,59},{-18,46},{8,46}}, color={0,0,127}));
      connect(cutForce1a.force, err1.u2) annotation (Line(
          points={{-18,21},{-18,34},{8,34}}, color={0,0,127}));
      connect(cutForce2a.force, err2.u1) annotation (Line(
          points={{-18,-41},{-18,-54},{8,-54}}, color={0,0,127}));
      connect(cutForce2b.force, err2.u2) annotation (Line(
          points={{-18,-79},{-18,-66},{8,-66}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end CutForce;

    model CutForce2
      extends Modelica.Icons.Example;
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-80,
                -20},{-60,0}})));
      MultiBody.Sensors.CutForce cutForce annotation (
          Placement(transformation(extent={{0,-20},{20,0}})));
      MultiBody.Parts.FixedRotation fixedRotation(
        r={0.5,0.5,0.1},
        rotationType=MultiBody.Types.RotationTypes.PlanarRotationSequence,
        animation=false) annotation (Placement(transformation(extent={{-40,-20},
                {-20,0}})));

      MultiBody.Visualizers.FixedFrame frame_b(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={30,30},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Forces.WorldForce WorldForce1(animation=
            false) annotation (Placement(transformation(extent={{60,-20},{40,0}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={500,0,0}) annotation (
          Placement(transformation(extent={{100,-20},{80,0}})));
    equation
      connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
          points={{-60,-10},{-40,-10}},
          thickness=0.5));
      connect(fixedRotation.frame_b, cutForce.frame_a) annotation (Line(
          points={{-20,-10},{0,-10}},
          thickness=0.5));
      connect(cutForce.frame_b, WorldForce1.frame_b) annotation (Line(
          points={{20,-10},{40,-10}},
          thickness=0.5));
      connect(frame_b.frame_a, cutForce.frame_b) annotation (Line(
          points={{30,20},{30,20},{30,-10},{20,-10}},
          thickness=0.5));
      connect(Constant1.y, WorldForce1.force) annotation (Line(
          points={{79,-10},{62,-10}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end CutForce2;

    model CutForce3
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-80,
                -20},{-60,0}})));
      Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce(animation=true) annotation (
          Placement(transformation(extent={{0,-20},{20,0}})));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
        r={0.5,0.5,0.1},
        rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
        animation=false) annotation (Placement(transformation(extent={{-40,-20},
                {-20,0}})));

      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_b(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={30,30},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Forces.WorldForce WorldForce1(animation=
            false) annotation (Placement(transformation(extent={{60,-20},{40,0}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={500,0,0}) annotation (
          Placement(transformation(extent={{100,-20},{80,0}})));
    equation
      connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
          points={{-60,-10},{-40,-10}},
          thickness=0.5));
      connect(fixedRotation.frame_b, cutForce.frame_a) annotation (Line(
          points={{-20,-10},{0,-10}},
          thickness=0.5));
      connect(cutForce.frame_b, WorldForce1.frame_b) annotation (Line(
          points={{20,-10},{40,-10}},
          thickness=0.5));
      connect(frame_b.frame_a, cutForce.frame_b) annotation (Line(
          points={{30,20},{30,20},{30,-10},{20,-10}},
          thickness=0.5));
      connect(Constant1.y, WorldForce1.force) annotation (Line(
          points={{79,-10},{62,-10}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end CutForce3;

    model CutTorque
      extends Modelica.Icons.Example;
      parameter Real tol=1e-3;
      inner MultiBody.World world(defaultNm_to_m=10,n={0,0,-1}) annotation (
          Placement(transformation(extent={{-100,0},{-80,20}})));
      MultiBody.Sensors.CutTorque cutTorque1a
        annotation (Placement(transformation(extent={{-20,20},{0,0}})));
      MultiBody.Parts.FixedTranslation translate1a(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,10},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body1a(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,0},{80,20}})));
      MultiBody.Sensors.CutTorque cutTorque2a(
        positiveSign=false,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.world)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      MultiBody.Parts.FixedTranslation translate2a(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-30},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body2a(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
      MultiBody.Parts.FixedRotation rotate1a(
        n={0,0,1},
        angle=90,
        r={0,0,-0.2}) annotation (Placement(transformation(extent={{-60,0},{-40,
                20}})));
      MultiBody.Parts.FixedRotation rotate2a(
        n={0,0,1},
        angle=90,
        r={0,0,0.2}) annotation (Placement(transformation(extent={{-60,-40},{-40,
                -20}})));
      MultiBody.Sensors.CutTorque cutTorque1b(
          resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_resolve)
        annotation (Placement(transformation(extent={{-20,60},{0,80}})));
      MultiBody.Parts.FixedTranslation translate1b(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body1b(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      MultiBody.Parts.FixedRotation rotate1b(
        n={0,0,1},
        angle=90,
        r={0,0,-0.6}) annotation (Placement(transformation(extent={{-60,60},{-40,
                80}})));
      Modelica.Blocks.Math.Add err1[3](each k2=-1) annotation (Placement(
            transformation(extent={{10,30},{30,50}})));
      MultiBody.Sensors.CutTorque cutTorque2b(
        positiveSign=false,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_resolve)
        annotation (Placement(transformation(extent={{-20,-80},{0,-100}})));
      MultiBody.Parts.FixedTranslation translate2b(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-90},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body2b(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
      MultiBody.Parts.FixedRotation rotate2b(
        n={0,0,1},
        angle=90,
        r={0,0,0.6}) annotation (Placement(transformation(extent={{-60,-100},{-40,
                -80}})));
      Modelica.Blocks.Math.Add err2[3](each k2=-1) annotation (Placement(
            transformation(extent={{10,-70},{30,-50}})));
    equation
      for i in 1:3 loop
        assert(err1[i].y < tol and err2[i].y < tol,
          "Errors must be less then tolerance");
      end for;

      connect(world.frame_b, rotate1a.frame_a) annotation (Line(
          points={{-80,10},{-60,10}},
          thickness=0.5));
      connect(rotate1a.frame_b, cutTorque1a.frame_a) annotation (Line(
          points={{-40,10},{-20,10}},
          thickness=0.5));
      connect(rotate2a.frame_b, cutTorque2a.frame_a) annotation (Line(
          points={{-40,-30},{-20,-30}},
          thickness=0.5));
      connect(rotate2a.frame_a, world.frame_b) annotation (Line(
          points={{-60,-30},{-70,-30},{-70,10},{-80,10}},
          thickness=0.5));
      connect(rotate1b.frame_b, cutTorque1b.frame_a) annotation (Line(
          points={{-40,70},{-20,70}},
          thickness=0.5));
      connect(cutTorque1b.frame_resolve, rotate1b.frame_b) annotation (Line(
          points={{-2,60},{-20,60},{-20,46},{-40,46},{-40,70}},
          pattern=LinePattern.Dot));
      connect(world.frame_b, rotate1b.frame_a) annotation (Line(
          points={{-80,10},{-70,10},{-70,70},{-60,70}},
          thickness=0.5));
      connect(rotate2b.frame_b, cutTorque2b.frame_a) annotation (Line(
          points={{-40,-90},{-20,-90}},
          thickness=0.5));
      connect(rotate2b.frame_a, world.frame_b) annotation (Line(
          points={{-60,-90},{-70,-90},{-70,10},{-80,10}},
          thickness=0.5));
      connect(cutTorque2b.frame_resolve, world.frame_b) annotation (Line(
          points={{-2,-80},{-2,-60},{-74,-60},{-74,10},{-80,10}},
          pattern=LinePattern.Dot));
      connect(cutTorque1b.frame_b, translate1b.frame_a) annotation (Line(
          points={{0,70},{20,70}},
          thickness=0.5));
      connect(translate1b.frame_b, body1b.frame_a) annotation (Line(
          points={{40,70},{60,70}},
          thickness=0.5));
      connect(cutTorque1a.frame_b, translate1a.frame_a) annotation (Line(
          points={{0,10},{10,10},{10,10},{20,10}},
          thickness=0.5));
      connect(translate1a.frame_b, body1a.frame_a) annotation (Line(
          points={{40,10},{50,10},{60,10}},
          thickness=0.5));
      connect(cutTorque2a.frame_b, translate2a.frame_a) annotation (Line(
          points={{0,-30},{20,-30}},
          thickness=0.5));
      connect(translate2a.frame_b, body2a.frame_a) annotation (Line(
          points={{40,-30},{60,-30}},
          thickness=0.5));
      connect(cutTorque2b.frame_b, translate2b.frame_a) annotation (Line(
          points={{0,-90},{20,-90}},
          thickness=0.5));
      connect(translate2b.frame_b, body2b.frame_a) annotation (Line(
          points={{40,-90},{60,-90}},
          thickness=0.5));
      connect(cutTorque1b.torque, err1.u1) annotation (Line(
          points={{-18,59},{-18,46},{8,46}}, color={0,0,127}));
      connect(cutTorque1a.torque, err1.u2) annotation (Line(
          points={{-18,21},{-18,34},{8,34}}, color={0,0,127}));
      connect(cutTorque2a.torque, err2.u1) annotation (Line(
          points={{-18,-41},{-18,-54},{8,-54}}, color={0,0,127}));
      connect(cutTorque2b.torque, err2.u2) annotation (Line(
          points={{-18,-79},{-18,-66},{8,-66}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end CutTorque;

    model CutTorque2
      extends Modelica.Icons.Example;
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-80,
                -20},{-60,0}})));
      MultiBody.Sensors.CutTorque cutTorque annotation (
          Placement(transformation(extent={{0,-20},{20,0}})));
      MultiBody.Parts.FixedRotation fixedRotation(
        r={0.5,0.5,0.1},
        rotationType=MultiBody.Types.RotationTypes.PlanarRotationSequence,
        animation=false) annotation (Placement(transformation(extent={{-40,-20},
                {-20,0}})));

      MultiBody.Visualizers.FixedFrame frame_b(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={30,30},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      MultiBody.Forces.WorldTorque worldTorque(animation=
            false) annotation (Placement(transformation(extent={{60,-20},{40,0}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={500,0,0}) annotation (
          Placement(transformation(extent={{100,-20},{80,0}})));
    equation
      connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
          points={{-60,-10},{-40,-10}},
          thickness=0.5));
      connect(Constant1.y, worldTorque.torque)
        annotation (Line(points={{79,-10},{62,-10}}, color={0,0,255}));
      connect(fixedRotation.frame_b, cutTorque.frame_a) annotation (Line(
          points={{-20,-10},{0,-10}},
          thickness=0.5));
      connect(cutTorque.frame_b, worldTorque.frame_b) annotation (Line(
          points={{20,-10},{40,-10}},
          thickness=0.5));
      connect(frame_b.frame_a, cutTorque.frame_b) annotation (Line(
          points={{30,20},{30,20},{30,-10},{20,-10}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end CutTorque2;

    model CutTorque3
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-80,
                -20},{-60,0}})));
      Modelica.Mechanics.MultiBody.Sensors.CutTorque cutTorque(animation=true) annotation (
          Placement(transformation(extent={{0,-20},{20,0}})));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
        r={0.5,0.5,0.1},
        rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
        animation=false) annotation (Placement(transformation(extent={{-40,-20},
                {-20,0}})));

      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_b(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={30,30},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Forces.WorldTorque worldTorque(animation=
            false) annotation (Placement(transformation(extent={{60,-20},{40,0}})));
      Modelica.Blocks.Sources.Constant Constant1[3](k={500,0,0}) annotation (
          Placement(transformation(extent={{100,-20},{80,0}})));
    equation
      connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
          points={{-60,-10},{-40,-10}},
          thickness=0.5));
      connect(Constant1.y, worldTorque.torque)
        annotation (Line(points={{79,-10},{62,-10}}, color={0,0,255}));
      connect(fixedRotation.frame_b, cutTorque.frame_a) annotation (Line(
          points={{-20,-10},{0,-10}},
          thickness=0.5));
      connect(cutTorque.frame_b, worldTorque.frame_b) annotation (Line(
          points={{20,-10},{40,-10}},
          thickness=0.5));
      connect(frame_b.frame_a, cutTorque.frame_b) annotation (Line(
          points={{30,20},{30,20},{30,-10},{20,-10}},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end CutTorque3;

    model CutForceAndTorque1
      extends Modelica.Icons.Example;
      parameter Real tol=1e-3;
      inner MultiBody.World world(defaultN_to_m=10,
         defaultNm_to_m=10) annotation (Placement(
            transformation(extent={{-100,0},{-80,20}})));
      Modelica.Blocks.Math.Add err1[6](each k2=-1) annotation (Placement(
            transformation(extent={{10,30},{30,50}})));
      Modelica.Blocks.Math.Add err2[6](each k2=-1) annotation (Placement(
            transformation(extent={{10,-70},{30,-50}})));
      MultiBody.Sensors.CutForceAndTorque cutForce1a
            annotation (Placement(transformation(extent={{-20,
                20},{0,0}})));
      MultiBody.Sensors.CutForceAndTorque cutForce1b(
        resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_resolve)
        annotation (Placement(transformation(extent={{-20,60},{0,80}})));
      MultiBody.Sensors.CutForceAndTorque cutForce2a(
        positiveSign=false,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.world)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      MultiBody.Sensors.CutForceAndTorque cutForce2b(
        positiveSign=false,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_resolve)
        annotation (Placement(transformation(extent={{-20,-80},{0,-100}})));
      MultiBody.Parts.FixedTranslation translate1a(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,10},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.FixedTranslation translate1b(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.FixedTranslation translate2a(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-30},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.FixedTranslation translate2b(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-90},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.FixedRotation rotate1a(
        n={0,0,1},
        angle=90,
        r={0,0,-0.2}) annotation (Placement(transformation(extent={{-60,0},{-40,
                20}})));
      MultiBody.Parts.FixedRotation rotate1b(
        n={0,0,1},
        angle=90,
        r={0,0,-0.6}) annotation (Placement(transformation(extent={{-60,60},{-40,
                80}})));
      MultiBody.Parts.FixedRotation rotate2a(
        n={0,0,1},
        angle=90,
        r={0,0,0.2}) annotation (Placement(transformation(extent={{-60,-40},{-40,
                -20}})));
      MultiBody.Parts.FixedRotation rotate2b(
        n={0,0,1},
        angle=90,
        r={0,0,0.6}) annotation (Placement(transformation(extent={{-60,-100},{-40,
                -80}})));
      MultiBody.Parts.Body body1a(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,0},{80,20}})));
      MultiBody.Parts.Body body1b(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      MultiBody.Parts.Body body2a(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
      MultiBody.Parts.Body body2b(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
    equation
      for i in 1:6 loop
        assert(err1[i].y < tol and err2[i].y < tol,
          "Errors must be less then tolerance");
      end for;
      connect(world.frame_b, rotate1a.frame_a) annotation (Line(
          points={{-80,10},{-60,10}},
          thickness=0.5));
      connect(rotate1a.frame_b, cutForce1a.frame_a) annotation (Line(
          points={{-40,10},{-20,10}},
          thickness=0.5));
      connect(rotate2a.frame_b, cutForce2a.frame_a) annotation (Line(
          points={{-40,-30},{-20,-30}},
          thickness=0.5));
      connect(rotate2a.frame_a, world.frame_b) annotation (Line(
          points={{-60,-30},{-70,-30},{-70,10},{-80,10}},
          thickness=0.5));
      connect(rotate1b.frame_b, cutForce1b.frame_a) annotation (Line(
          points={{-40,70},{-20,70}},
          thickness=0.5));
      connect(cutForce1b.frame_resolve, rotate1b.frame_b) annotation (Line(
          points={{-2,60},{-2,60},{-2,54},{-40,54},{-40,70}},
          pattern=LinePattern.Dot));
      connect(world.frame_b, rotate1b.frame_a) annotation (Line(
          points={{-80,10},{-70,10},{-70,70},{-60,70}},
          thickness=0.5));
      connect(rotate2b.frame_b, cutForce2b.frame_a) annotation (Line(
          points={{-40,-90},{-20,-90}},
          thickness=0.5));
      connect(rotate2b.frame_a, world.frame_b) annotation (Line(
          points={{-60,-90},{-70,-90},{-70,10},{-80,10}},
          thickness=0.5));
      connect(cutForce2b.frame_resolve, world.frame_b) annotation (Line(
          points={{-2,-80},{-2,-60},{-74,-60},{-74,10},{-80,10}},
          pattern=LinePattern.Dot));
      connect(cutForce1b.frame_b, translate1b.frame_a) annotation (Line(
          points={{0,70},{20,70}},
          thickness=0.5));
      connect(translate1b.frame_b, body1b.frame_a) annotation (Line(
          points={{40,70},{60,70}},
          thickness=0.5));
      connect(cutForce1a.frame_b, translate1a.frame_a) annotation (Line(
          points={{0,10},{10,10},{10,10},{20,10}},
          thickness=0.5));
      connect(translate1a.frame_b, body1a.frame_a) annotation (Line(
          points={{40,10},{50,10},{50,10},{60,10}},
          thickness=0.5));
      connect(cutForce2a.frame_b, translate2a.frame_a) annotation (Line(
          points={{0,-30},{20,-30}},
          thickness=0.5));
      connect(translate2a.frame_b, body2a.frame_a) annotation (Line(
          points={{40,-30},{60,-30}},
          thickness=0.5));
      connect(cutForce2b.frame_b, translate2b.frame_a) annotation (Line(
          points={{0,-90},{20,-90}},
          thickness=0.5));
      connect(translate2b.frame_b, body2b.frame_a) annotation (Line(
          points={{40,-90},{60,-90}},
          thickness=0.5));
      connect(cutForce1b.force[1:3], err1[1:3].u1) annotation (Line(
          points={{-18,58.3333},{-18,46},{8,46}}, color={0,0,127}));
      connect(cutForce1b.torque[1:3], err1[4:6].u1) annotation (Line(
          points={{-10,58.3333},{-10,46},{8,46}}, color={0,0,127}));
      connect(cutForce1a.force[1:3], err1[1:3].u2) annotation (Line(
          points={{-18,21.6667},{-18,34},{8,34}}, color={0,0,127}));
      connect(cutForce1a.torque[1:3], err1[4:6].u2) annotation (Line(
          points={{-10,21.6667},{-10,34},{8,34}}, color={0,0,127}));
      connect(cutForce2a.force[1:3], err2[1:3].u1) annotation (Line(
          points={{-18,-41.6667},{-18,-54},{8,-54}}, color={0,0,127}));
      connect(cutForce2a.torque[1:3], err2[4:6].u1) annotation (Line(
          points={{-10,-41.6667},{-10,-54},{8,-54}}, color={0,0,127}));
      connect(cutForce2b.force[1:3], err2[1:3].u2) annotation (Line(
          points={{-18,-78.3333},{-18,-66},{8,-66}}, color={0,0,127}));
      connect(cutForce2b.torque[1:3], err2[4:6].u2) annotation (Line(
          points={{-10,-78.3333},{-10,-66},{8,-66}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end CutForceAndTorque1;

    model CutForceAndTorque2
      extends Modelica.Icons.Example;
      parameter Real tol=1e-3;
      inner MultiBody.World world(defaultN_to_m=10,
          defaultNm_to_m=10,n={0,0,-1}) annotation (
          Placement(transformation(extent={{-100,0},{-80,20}})));
      MultiBody.Sensors.CutForceAndTorque cutForce1a
         annotation (Placement(transformation(extent={{-20,
                20},{0,0}})));
      MultiBody.Parts.FixedTranslation translate1a(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,10},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body1a(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,0},{80,20}})));
      MultiBody.Sensors.CutForceAndTorque cutForce2a(
        positiveSign=false,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.world)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      MultiBody.Parts.FixedTranslation translate2a(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-30},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body2a(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
      MultiBody.Parts.FixedRotation rotate1a(
        n={0,0,1},
        angle=90,
        r={0,0,-0.2}) annotation (Placement(transformation(extent={{-60,0},{-40,
                20}})));
      MultiBody.Parts.FixedRotation rotate2a(
        n={0,0,1},
        angle=90,
        r={0,0,0.2}) annotation (Placement(transformation(extent={{-60,-40},{-40,
                -20}})));
      MultiBody.Sensors.CutForceAndTorque cutForce1b(
        resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_resolve)
        annotation (Placement(transformation(extent={{-20,60},{0,80}})));
      MultiBody.Parts.FixedTranslation translate1b(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body1b(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      MultiBody.Parts.FixedRotation rotate1b(
        n={0,0,1},
        angle=90,
        r={0,0,-0.6}) annotation (Placement(transformation(extent={{-60,60},{-40,
                80}})));
      Modelica.Blocks.Math.Add err1[6](each k2=-1) annotation (Placement(
            transformation(extent={{10,30},{30,50}})));
      MultiBody.Sensors.CutForceAndTorque cutForce2b(
        positiveSign=false,
        resolveInFrame=MultiBody.Types.ResolveInFrameA.frame_resolve)
        annotation (Placement(transformation(extent={{-20,-80},{0,-100}})));
      MultiBody.Parts.FixedTranslation translate2b(r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-90},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      MultiBody.Parts.Body body2b(r_CM={0,0,0}, m=1)
        annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
      MultiBody.Parts.FixedRotation rotate2b(
        n={0,0,1},
        angle=90,
        r={0,0,0.6}) annotation (Placement(transformation(extent={{-60,-100},{-40,
                -80}})));
      Modelica.Blocks.Math.Add err2[6](each k2=-1) annotation (Placement(
            transformation(extent={{8,-72},{28,-52}})));
    equation
      for i in 1:6 loop
        assert(err1[i].y < tol and err2[i].y < tol,
          "Errors must be less then tolerance");
      end for;

      connect(world.frame_b, rotate1a.frame_a) annotation (Line(
          points={{-80,10},{-60,10}},
          thickness=0.5));
      connect(rotate1a.frame_b, cutForce1a.frame_a) annotation (Line(
          points={{-40,10},{-20,10}},
          thickness=0.5));
      connect(rotate2a.frame_b, cutForce2a.frame_a) annotation (Line(
          points={{-40,-30},{-20,-30}},
          thickness=0.5));
      connect(rotate2a.frame_a, world.frame_b) annotation (Line(
          points={{-60,-30},{-70,-30},{-70,10},{-80,10}},
          thickness=0.5));
      connect(rotate1b.frame_b, cutForce1b.frame_a) annotation (Line(
          points={{-40,70},{-20,70}},
          thickness=0.5));
      connect(cutForce1b.frame_resolve, rotate1b.frame_b) annotation (Line(
          points={{-2,60},{-2,60},{-2,54},{-40,54},{-40,70}},
          pattern=LinePattern.Dot));
      connect(world.frame_b, rotate1b.frame_a) annotation (Line(
          points={{-80,10},{-70,10},{-70,70},{-60,70}},
          thickness=0.5));
      connect(rotate2b.frame_b, cutForce2b.frame_a) annotation (Line(
          points={{-40,-90},{-20,-90}},
          thickness=0.5));
      connect(rotate2b.frame_a, world.frame_b) annotation (Line(
          points={{-60,-90},{-70,-90},{-70,10},{-80,10}},
          thickness=0.5));
      connect(cutForce2b.frame_resolve, world.frame_b) annotation (Line(
          points={{-2,-80},{-2,-60},{-74,-60},{-74,10},{-80,10}},
          pattern=LinePattern.Dot));
      connect(cutForce1b.frame_b, translate1b.frame_a) annotation (Line(
          points={{0,70},{20,70}},
          thickness=0.5));
      connect(translate1b.frame_b, body1b.frame_a) annotation (Line(
          points={{40,70},{60,70}},
          thickness=0.5));
      connect(cutForce1a.frame_b, translate1a.frame_a) annotation (Line(
          points={{0,10},{20,10},{20,10}},
          thickness=0.5));
      connect(translate1a.frame_b, body1a.frame_a) annotation (Line(
          points={{40,10},{50,10},{50,10},{60,10}},
          thickness=0.5));
      connect(cutForce2a.frame_b, translate2a.frame_a) annotation (Line(
          points={{0,-30},{20,-30}},
          thickness=0.5));
      connect(translate2a.frame_b, body2a.frame_a) annotation (Line(
          points={{40,-30},{60,-30}},
          thickness=0.5));
      connect(cutForce2b.frame_b, translate2b.frame_a) annotation (Line(
          points={{0,-90},{20,-90}},
          thickness=0.5));
      connect(translate2b.frame_b, body2b.frame_a) annotation (Line(
          points={{40,-90},{60,-90}},
          thickness=0.5));
      connect(cutForce1a.force[1:3], err1[1:3].u2) annotation (Line(
          points={{-18,21.6667},{-18,34},{8,34}}, color={0,0,127}));
      connect(cutForce1a.torque[1:3], err1[4:6].u2) annotation (Line(
          points={{-10,21.6667},{-10,34},{8,34}}, color={0,0,127}));
      connect(cutForce1b.force[1:3], err1[1:3].u1) annotation (Line(
          points={{-18,58.3333},{-18,46},{8,46}}, color={0,0,127}));
      connect(cutForce1b.torque[1:3], err1[4:6].u1) annotation (Line(
          points={{-10,58.3333},{-10,46},{8,46}}, color={0,0,127}));
      connect(cutForce2a.force[1:3], err2[1:3].u1) annotation (Line(
          points={{-18,-41.6667},{-18,-56},{6,-56}}, color={0,0,127}));
      connect(cutForce2a.torque[1:3], err2[4:6].u1) annotation (Line(
          points={{-10,-41.6667},{-10,-56},{6,-56}}, color={0,0,127}));
      connect(cutForce2b.force[1:3], err2[1:3].u2) annotation (Line(
          points={{-18,-78.3333},{-18,-68},{6,-68}}, color={0,0,127}));
      connect(cutForce2b.torque[1:3], err2[4:6].u2) annotation (Line(
          points={{-10,-78.3333},{-10,-68},{6,-68}}, color={0,0,127}));
      annotation (experiment(StopTime=1.1));
    end CutForceAndTorque2;

    model CutForceAndTorque3
      extends Modelica.Icons.Example;
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{-80,
                -20},{-60,0}})));
      MultiBody.Sensors.CutForceAndTorque cutForceAndTorque
        annotation (Placement(transformation(extent={{0,-20},{20,0}})));
      MultiBody.Parts.FixedRotation fixedRotation(
        r={0.5,0.5,0.1},
        rotationType=MultiBody.Types.RotationTypes.PlanarRotationSequence,
        animation=false) annotation (Placement(transformation(extent={{-40,-20},
                {-20,0}})));

      MultiBody.Visualizers.FixedFrame frame_b(color_x={0,0,
            200}) annotation (Placement(transformation(
            origin={30,30},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Constant Constant1[6](k={500,0,0,450,-250,0})
        annotation (Placement(transformation(extent={{100,-20},{80,0}})));
      MultiBody.Forces.WorldForceAndTorque forceAndTorque(
          animation=false, resolveInFrame=MultiBody.Types.ResolveInFrameB.world)
        annotation (Placement(transformation(extent={{60,-20},{40,0}})));
    equation
      connect(Constant1[1:3].y, forceAndTorque.force[1:3]) annotation (Line(
          points={{79,-10},{70,-10},{70,-17.3333},{62,-17.3333}}, color={0,0,127}));
      connect(Constant1[4:6].y, forceAndTorque.torque[1:3]) annotation (Line(
          points={{79,-10},{70,-10},{70,-5.33333},{62,-5.33333}}, color={0,0,127}));
      connect(forceAndTorque.frame_b, cutForceAndTorque.frame_b) annotation (
          Line(
          points={{40,-10},{20,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(cutForceAndTorque.frame_b, frame_b.frame_a) annotation (Line(
          points={{20,-10},{30,-10},{30,20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
          points={{-60,-10},{-40,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation.frame_b, cutForceAndTorque.frame_a) annotation (
          Line(
          points={{-20,-10},{0,-10}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end CutForceAndTorque3;
  end Sensors;

  package Visualizers "Test MultiBody.Visualizers"
    extends Modelica.Icons.ExamplesPackage;

    model Shapes "Test and show models Visualizers.FixedShape"
      import Modelica.Icons;
      extends Icons.Example;
      MultiBody.Parts.Fixed fixed(animation=false)
        annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      MultiBody.Visualizers.FixedShape box(
        widthDirection={1,0,0},
        r_shape={0,0,0},
        lengthDirection={0.5,1,-0.5},
        length=0.12,
        width=0.08,
        height=0.08,
        color={155,155,155},
        shapeType="box") annotation (Placement(transformation(
            origin={-60,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Visualizers.FixedShape sphere(
        r_shape={0.2,0,0},
        lengthDirection={0.5,1,-0.5},
        length=0.1,
        widthDirection={-0.5,1,0},
        width=0.1,
        height=0.1,
        color={155,155,155},
        shapeType="sphere") annotation (Placement(transformation(
            origin={-30,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Visualizers.FixedShape cylinder(
        widthDirection={1,0,0},
        length=0.1,
        width=0.1,
        height=0.1,
        r_shape={0.4,0,0},
        lengthDirection={0.5,1,-0.5},
        extra=5,
        color={155,155,155},
        shapeType="cylinder") annotation (Placement(transformation(
            origin={-4,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Visualizers.FixedShape pipe(
        widthDirection={1,0,0},
        length=0.1,
        width=0.1,
        height=0.1,
        r_shape={0.8,0,0},
        lengthDirection={0.5,1,-0.5},
        extra=0.7,
        shapeType="pipe",
        color={155,155,155}) annotation (Placement(transformation(
            origin={42,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Visualizers.FixedShape beam(
        widthDirection={1,0,0},
        length=0.1,
        width=0.1,
        height=0.1,
        r_shape={0,-0.2,0},
        lengthDirection={0.5,1,-0.5},
        extra=0,
        shapeType="beam",
        color={155,155,155}) annotation (Placement(transformation(
            origin={-60,10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    protected
      MultiBody.Interfaces.Frame_b frame_b1 annotation (
          Placement(transformation(extent={{-61,-11},{-59,-9}})));
    public
      MultiBody.Visualizers.FixedShape gearwheel(
        widthDirection={1,0,0},
        width=0.1,
        height=0.1,
        r_shape={0.2,-0.2,0},
        extra=20,
        length=0.04,
        lengthDirection={0.5,1,-2},
        shapeType="gearwheel",
        color={155,155,155}) annotation (Placement(transformation(
            origin={-32,10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Visualizers.FixedShape spring(
        widthDirection={1,0,0},
        length=0.1,
        width=0.1,
        height=0.02,
        r_shape={0.4,-0.2,0},
        extra=4,
        lengthDirection={0.5,1,-0.5},
        shapeType="spring",
        color={155,155,155}) annotation (Placement(transformation(
            origin={-2,10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Visualizers.FixedShape cone(
        widthDirection={1,0,0},
        length=0.1,
        width=0.1,
        height=0.1,
        r_shape={0.6,0,0},
        lengthDirection={0.5,1,-0.5},
        extra=0.5,
        shapeType="cone",
        color={155,155,155}) annotation (Placement(transformation(
            origin={20,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false) annotation (Placement(transformation(extent={{
                40,0},{60,20}})));
    equation
      connect(fixed.frame_b, box.frame_a)
        annotation (Line(
          points={{-80,50},{-60,50},{-60,60}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed.frame_b, sphere.frame_a)
        annotation (Line(
          points={{-80,50},{-30,50},{-30,60}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed.frame_b, cylinder.frame_a)
        annotation (Line(
          points={{-80,50},{-4,50},{-4,60}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed.frame_b, pipe.frame_a)
        annotation (Line(
          points={{-80,50},{42,50},{42,60}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed.frame_b, frame_b1)
        annotation (Line(
          points={{-80,50},{-74,50},{-74,-10},{-60,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(beam.frame_a, frame_b1)
        annotation (Line(points={{-60,0},{-60,-10}}));
      connect(frame_b1, gearwheel.frame_a)
        annotation (Line(points={{-60,-10},{-32,-10},{-32,0}}));
      connect(frame_b1, spring.frame_a)
        annotation (Line(points={{-60,-10},{-2,-10},{-2,0}}));
      connect(fixed.frame_b, cone.frame_a)
        annotation (Line(
          points={{-80,50},{20,50},{20,60}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1));
    end Shapes;

    model Arrow "Test and show models Visualizers.FixedShape"
      import Modelica.Icons;
      extends Icons.Example;
      MultiBody.Parts.Fixed fixed3(animation=false, r={0.2,-0.6,
            0}) annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      MultiBody.Visualizers.SignalArrow arrow
        annotation (Placement(transformation(
            origin={-30,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Sine sine[3](
        amplitude={0.1,0.05,0.8},
        f={2,1,2},
        each offset=0.2) annotation (Placement(transformation(extent={{12,20},{
                -8,40}})));
      MultiBody.Visualizers.FixedArrow fixedArrow(length=0.3,
          color={0,0,255}) annotation (Placement(transformation(
            origin={-70,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      inner MultiBody.World world(animateWorld=false,
          gravityType=MultiBody.Types.GravityTypes.NoGravity)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
    equation
      connect(arrow.frame_a, fixed3.frame_b)
        annotation (Line(
          points={{-30,20},{-30,0}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedArrow.frame_a, fixed3.frame_b)
        annotation (Line(
          points={{-70,20},{-70,0},{-30,0}},
          color={95,95,95},
          thickness=0.5));
      connect(sine.y, arrow.r_head) annotation (Line(
          points={{-9,30},{-18,30}}, color={0,0,127}));
      annotation (experiment(StopTime=1));
    end Arrow;

    model Torus "Test and show models Visualizers.Torus"

      extends Modelica.Icons.Example;
      inner MultiBody.World world(animateWorld=false,
          animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      MultiBody.Parts.FixedTranslation fixedTranslation(
          animation=false, r={2,0,0})
        annotation (Placement(transformation(extent={{-26,50},{-6,70}})));
      MultiBody.Visualizers.Torus torus1(r=0.2)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      MultiBody.Visualizers.Torus torus2(
        r=0.2,
        opening=0.78539816339745,
        startAngle=-2.3561944901923,
        stopAngle=2.3561944901923)
        annotation (Placement(transformation(extent={{4,50},{24,70}})));
      MultiBody.Visualizers.FixedFrame fixedFrame(color_x={
            255,0,0}, length=1)
        annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
      MultiBody.Visualizers.FixedFrame fixedFrame1(color_x={
            255,0,0}, length=1)
        annotation (Placement(transformation(extent={{12,76},{32,96}})));
    equation

      connect(world.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{-40,30},{-32,30},{-32,60},{-26,60}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, torus1.frame_a) annotation (Line(
          points={{-40,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedTranslation.frame_b, torus2.frame_a) annotation (Line(
          points={{-6,60},{4,60}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedFrame.frame_a, torus1.frame_a) annotation (Line(
          points={{-10,-20},{-32,-20},{-32,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedFrame1.frame_a, torus2.frame_a) annotation (Line(
          points={{12,86},{0,86},{0,60},{4,60}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=2));
    end Torus;

    model VoluminousWheel
      extends Modelica.Icons.Example;
      MultiBody.Visualizers.VoluminousWheel voluminousWheel
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      inner MultiBody.World world(axisColor_x={255,0,0},
          animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    equation

      connect(world.frame_b, voluminousWheel.frame_a) annotation (Line(
          points={{-40,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1.01));
    end VoluminousWheel;

    model ColorMaps "Show all color maps"

      extends Modelica.Icons.Example;
      inner MultiBody.World world(animateGravity=false,
          animateWorld=false)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      MultiBody.Visualizers.PipeWithScalarField jet(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.01:0.5,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5)
        annotation (Placement(transformation(extent={{-20,60},{0,80}})));
      MultiBody.Visualizers.PipeWithScalarField hot(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            MultiBody.Visualizers.Colors.ColorMaps.hot)
        annotation (Placement(transformation(extent={{-20,30},{0,50}})));
      MultiBody.Parts.FixedTranslation translate2(animation=
            false, r={0,0,-0.3})
        annotation (Placement(transformation(extent={{-48,30},{-28,50}})));
      MultiBody.Visualizers.PipeWithScalarField gray(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            MultiBody.Visualizers.Colors.ColorMaps.gray)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      MultiBody.Parts.FixedTranslation translate3(animation=
            false, r={0,0,-0.6})
        annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
      MultiBody.Visualizers.PipeWithScalarField spring(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            MultiBody.Visualizers.Colors.ColorMaps.spring)
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
      MultiBody.Parts.FixedTranslation translate4(animation=
            false, r={0,0,-0.9})
        annotation (Placement(transformation(extent={{-48,-30},{-28,-10}})));
      MultiBody.Visualizers.PipeWithScalarField summer(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            MultiBody.Visualizers.Colors.ColorMaps.summer)
        annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      MultiBody.Parts.FixedTranslation translate5(animation=
            false, r={0,0,-1.2})
        annotation (Placement(transformation(extent={{-48,-60},{-28,-40}})));
      MultiBody.Parts.FixedTranslation translate6(animation=
            false, r={0,0,-1.5})
        annotation (Placement(transformation(extent={{-48,-90},{-28,-70}})));
      MultiBody.Visualizers.PipeWithScalarField autumn(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            MultiBody.Visualizers.Colors.ColorMaps.autumn)
        annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
      MultiBody.Parts.FixedTranslation translate7(animation=
            false, r={0,0,-1.8})
        annotation (Placement(transformation(extent={{-48,-120},{-28,-100}})));
      MultiBody.Visualizers.PipeWithScalarField winter(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            MultiBody.Visualizers.Colors.ColorMaps.winter)
        annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
    equation

      connect(world.frame_b, jet.frame_a) annotation (Line(
          points={{-60,70},{-20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, translate2.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,40},{-48,40}},
          color={95,95,95},
          thickness=0.5));
      connect(translate2.frame_b, hot.frame_a) annotation (Line(
          points={{-28,40},{-20,40}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, translate3.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,10},{-48,10}},
          color={95,95,95},
          thickness=0.5));
      connect(translate3.frame_b, gray.frame_a) annotation (Line(
          points={{-28,10},{-20,10}},
          color={95,95,95},
          thickness=0.5));
      connect(translate4.frame_b, spring.frame_a) annotation (Line(
          points={{-28,-20},{-20,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, translate4.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-20},{-48,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(translate5.frame_b, summer.frame_a) annotation (Line(
          points={{-28,-50},{-20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, translate5.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-50},{-48,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, translate6.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-80},{-48,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(translate6.frame_b, autumn.frame_a) annotation (Line(
          points={{-28,-80},{-20,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, translate7.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-110},{-48,-110}},
          color={95,95,95},
          thickness=0.5));
      connect(translate7.frame_b, winter.frame_a) annotation (Line(
          points={{-28,-110},{-20,-110}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=0.1));
    end ColorMaps;

    model Planes "Test and show models Visualizers.Plane"
      extends Modelica.Icons.Example;

      inner MultiBody.World world(animateWorld=false, animateGravity=false) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      MultiBody.Visualizers.Rectangle surfaceWireframe(
        direction_u={1,-0.4,0},
        direction_v={0,1,0},
        length_u=3,
        length_v=2,
        nu=8,
        nv=3,
        wireframe=true,
        color={0,230,0})      annotation (Placement(transformation(extent={{30,10},{50,30}})));
      MultiBody.Parts.FixedRotation fixedRotation(
        rotationType=MultiBody.Types.RotationTypes.TwoAxesVectors,
        n_x={1,0,0},
        animation=false,
        r={0,2.3,0}) annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      MultiBody.Visualizers.FixedFrame fixedFrameOfWireframe(color_x={255,0,0}) annotation (Placement(transformation(extent={{30,40},{50,60}})));
      MultiBody.Visualizers.Rectangle surfaceSolid(
        direction_u={1,0,0},
        direction_v={0,1,0},
        length_u=3,
        length_v=2,
        nu=8,
        nv=3,
        color={85,85,255},
        wireframe=false) annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
      MultiBody.Visualizers.FixedFrame fixedFrame(color_x={255,0,0}) annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
    equation
      connect(fixedRotation.frame_a, world.frame_b) annotation (Line(
          points={{-20,20},{-40,20},{-40,0},{-60,0}},
          color={95,95,95},
          thickness=0.5));
      connect(surfaceSolid.frame_a, world.frame_b) annotation (Line(
          points={{30,-20},{-40,-20},{-40,0},{-60,0}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedFrame.frame_a, world.frame_b) annotation (Line(
          points={{30,-50},{20,-50},{20,-20},{-40,-20},{-40,0},{-60,0}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation.frame_b, fixedFrameOfWireframe.frame_a) annotation (Line(
          points={{0,20},{20,20},{20,50},{30,50}},
          color={95,95,95},
          thickness=0.5));
      connect(fixedRotation.frame_b, surfaceWireframe.frame_a) annotation (Line(
          points={{0,20},{30,20}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=1));
    end Planes;
  end Visualizers;

  package InitializationConversion "Test conversion of the initialization"
    extends Modelica.Icons.ExamplesPackage;
    model Rotor1D
      extends Modelica.Icons.Example;

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-100,20},{-80,40}})));
      MultiBody.Parts.Rotor1D rotor1D1(
        J=1,
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(extent={{-70,40},{-50,
                60}})));
      MultiBody.Parts.Rotor1D rotor1D2(
        J=1,
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        w(fixed=true, start=1.74532925199433),
        phi(fixed=true, start=1.5707963267949)) annotation (Placement(
            transformation(extent={{-40,40},{-20,60}})));
      MultiBody.Parts.Rotor1D rotor1D3(
        J=1,
        stateSelect=StateSelect.prefer,
        phi(fixed=true),
        w(fixed=true,displayUnit="rad/s")) annotation (Placement(transformation(
              extent={{-10,40},{10,60}})));
      MultiBody.Parts.Rotor1D rotor1D4(
        J=1,
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        w(fixed=true),
        phi(fixed=true)) annotation (Placement(transformation(extent={{20,40},{
                40,60}})));
      MultiBody.Parts.Rotor1D rotor1D5(
        J=1,
        stateSelect=StateSelect.prefer,
        a(fixed=true),
        w(fixed=true),
        phi(fixed=true)) annotation (Placement(transformation(extent={{-60,0},{
                -40,20}})));
      MultiBody.Parts.Rotor1D rotor1D6(
        J=1,
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=false),
        w(fixed=true)) annotation (Placement(transformation(extent={{0,0},{20,
                20}})));
      Modelica.Mechanics.Rotational.Components.Spring spring(c=1e4) annotation (
         Placement(transformation(extent={{-30,0},{-10,20}})));
      MultiBody.Parts.Rotor1D rotor1D7(
        J=1,
        a(start=0.05235987755982989, fixed=true),
        stateSelect=StateSelect.prefer,
        w(fixed=true, start=0.03490658503988659),
        phi(fixed=true, start=0.017453292519943)) annotation (Placement(
            transformation(extent={{-60,-40},{-40,-20}})));
      MultiBody.Parts.Rotor1D rotor1D8(
        J=1,
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=false),
        w(fixed=true)) annotation (Placement(transformation(extent={{0,-40},{20,
                -20}})));
      Modelica.Mechanics.Rotational.Components.Spring spring1(c=1e4)
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
      MultiBody.Parts.Rotor1D rotor1D9(
        J=1,
        a(start=0.05235987755982989, fixed=true),
        w(fixed=true, start=0.03490658503988659),
        phi(fixed=true, start=0.017453292519943)) annotation (Placement(
            transformation(extent={{-60,-80},{-40,-60}})));
      MultiBody.Parts.Rotor1D rotor1D10(
        J=1,
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=false),
        w(fixed=true)) annotation (Placement(transformation(extent={{0,-80},{20,
                -60}})));
      Modelica.Mechanics.Rotational.Components.Spring spring2(c=1e4)
        annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
    equation
      connect(world.frame_b, rotor1D1.frame_a) annotation (Line(
          points={{-80,30},{-60,30},{-60,40}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, rotor1D2.frame_a) annotation (Line(
          points={{-80,30},{-30,30},{-30,40}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, rotor1D3.frame_a) annotation (Line(
          points={{-80,30},{0,30},{0,40}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, rotor1D4.frame_a) annotation (Line(
          points={{-80,30},{30,30},{30,40}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, rotor1D5.frame_a) annotation (Line(
          points={{-80,30},{-74,30},{-74,-8},{-50,-8},{-50,0}},
          color={95,95,95},
          thickness=0.5));
      connect(rotor1D5.frame_a, rotor1D6.frame_a) annotation (Line(
          points={{-50,0},{-50,-8},{10,-8},{10,0}},
          color={95,95,95},
          thickness=0.5));
      connect(spring.flange_a, rotor1D5.flange_b) annotation (Line(
          points={{-30,10},{-40,10}}));
      connect(spring.flange_b, rotor1D6.flange_a) annotation (Line(
          points={{-10,10},{0,10}}));
      connect(world.frame_b, rotor1D7.frame_a) annotation (Line(
          points={{-80,30},{-74,30},{-74,-48},{-50,-48},{-50,-40}},
          color={95,95,95},
          thickness=0.5));
      connect(rotor1D7.frame_a, rotor1D8.frame_a) annotation (Line(
          points={{-50,-40},{-50,-48},{10,-48},{10,-40}},
          color={95,95,95},
          thickness=0.5));
      connect(spring1.flange_a, rotor1D7.flange_b) annotation (Line(
          points={{-30,-30},{-40,-30}}));
      connect(spring1.flange_b, rotor1D8.flange_a) annotation (Line(
          points={{-10,-30},{0,-30}}));
      connect(world.frame_b, rotor1D9.frame_a) annotation (Line(
          points={{-80,30},{-74,30},{-74,-88},{-50,-88},{-50,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(rotor1D9.frame_a, rotor1D10.frame_a) annotation (Line(
          points={{-50,-80},{-50,-88},{10,-88},{10,-80}},
          color={95,95,95},
          thickness=0.5));
      connect(spring2.flange_a, rotor1D9.flange_b) annotation (Line(
          points={{-30,-70},{-40,-70}}));
      connect(spring2.flange_b, rotor1D10.flange_a) annotation (Line(
          points={{-10,-70},{0,-70}}));
      annotation (experiment(StopTime=1.1), Diagram(graphics={Rectangle(
              extent={{-66,-16},{100,-94}},
              lineColor={255,170,85},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid), Text(
              extent={{20,-30},{100,-80}},
              textColor={0,0,255},
              textString="This two parts are identical
concerning structure, parameters
and initialization.
But for compatibility reasons
they were not deleted yet.")}));
    end Rotor1D;

    model Joints
      extends Modelica.Icons.Example;

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,60},{-60,80}})));
      MultiBody.Joints.Revolute revolute(
        a(start=0.174532925199433, fixed=false),
        stateSelect=StateSelect.always,
        phi(fixed=true, start=0.7853981633974483),
        w(fixed=true, start=0.174532925199433)) annotation (Placement(
            transformation(extent={{-50,60},{-30,80}})));
      MultiBody.Parts.BodyBox bodyBox(r={1,0,0}) annotation (
         Placement(transformation(extent={{-20,60},{0,80}})));
      MultiBody.Joints.Revolute actuatedRevolute(
        a(start=-0.174532925199433, fixed=false),
        stateSelect=StateSelect.always,
        phi(fixed=true, start=0.5235987755982988),
        w(fixed=true, start=-0.174532925199433)) annotation (Placement(
            transformation(extent={{10,60},{30,80}})));
      MultiBody.Parts.BodyBox bodyBox1(r={1,0,0})
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
      MultiBody.Joints.Prismatic prismatic(
        stateSelect=StateSelect.always,
        a(fixed=false, start=1),
        s(fixed=true, start=1),
        v(fixed=true, start=1)) annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
      MultiBody.Parts.BodyBox bodyBox2(r={1,0,0})
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      MultiBody.Joints.Prismatic actuatedPrismatic(
        stateSelect=StateSelect.always,
        a(fixed=false, start=0.6),
        v(fixed=true, start=0.4),
        s(fixed=true, start=0.2)) annotation (Placement(transformation(extent={
                {10,20},{30,40}})));
      MultiBody.Joints.Cylindrical cylindrical(
        stateSelect=StateSelect.always,
        a(fixed=false, start=4),
        phi(fixed=true, start=1.047197551196598),
        s(fixed=true, start=1),
        v(fixed=true, start=3),
        w(fixed=true, start=0.03490658503988659),
        wd(fixed=false, start=0.08726646259971647)) annotation (Placement(
            transformation(extent={{-50,-20},{-30,0}})));
      MultiBody.Parts.BodyBox bodyBox3(r={1,0,0})
        annotation (Placement(transformation(extent={{40,20},{60,40}})));
      MultiBody.Parts.BodyBox bodyBox4(r={1,0,0})
        annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
      MultiBody.Joints.Universal universal(
        a_a(start=0.5235987755982988, fixed=false),
        a_b(start=-0.5235987755982988, fixed=false),
        stateSelect=StateSelect.always,
        phi_a(fixed=true, start=-0.174532925199433),
        phi_b(fixed=true, start=0.174532925199433),
        w_a(fixed=true, start=0.3490658503988659),
        w_b(fixed=true, start=-0.3490658503988659)) annotation (Placement(
            transformation(extent={{10,-20},{30,0}})));
      MultiBody.Parts.BodyBox bodyBox5(r={1,0,0})
        annotation (Placement(transformation(extent={{40,-20},{60,0}})));
      MultiBody.Joints.Planar planar(
        stateSelect=StateSelect.always,
        a_x(fixed=false, start=2),
        a_y(fixed=false, start=1),
        phi(fixed=true, start=0.05235987755982989),
        s_x(fixed=true, start=1),
        s_y(fixed=true, start=2),
        v_x(fixed=true, start=1),
        v_y(fixed=true, start=2),
        w(fixed=true, start=0.0174532925199433),
        wd(fixed=false, start=0.03490658503988659)) annotation (Placement(
            transformation(extent={{-50,-60},{-30,-40}})));
      MultiBody.Parts.BodyBox bodyBox6(r={1,0,0})
        annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      MultiBody.Joints.Spherical spherical(
        sequence_start={3,1,3},
        angles_start={0.3490658503988659,-0.5235987755982988,0.6981317007977318},
        angles_fixed=true,
        w_rel_a_fixed=true,
        z_rel_a_fixed=false,
        w_rel_a_start={0.0174532925199433,0.03490658503988659,
            0.05235987755982989},
        z_rel_a_start={0.03490658503988659,0.05235987755982989,
            0.06981317007977318}) annotation (Placement(transformation(extent={
                {10,-60},{30,-40}})));

      MultiBody.Parts.BodyBox bodyBox7(r={1,0,0})
        annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
      MultiBody.Parts.BodyBox bodyBox8(r={1,0,0})
        annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
      MultiBody.Joints.FreeMotion freeMotion(
        angles_start={0.3490658503988659,0.5235987755982988,0.6981317007977318},
        a_rel_a(each fixed=false),
        angles_fixed=true,
        r_rel_a(each fixed=true, start={1,1,1}),
        v_rel_a(each fixed=true),
        w_rel_a_fixed=true,
        z_rel_a_fixed=false) annotation (Placement(transformation(extent={{-50,
                -100},{-30,-80}})));

    equation
      connect(world.frame_b, revolute.frame_a) annotation (Line(
          points={{-60,70},{-50,70}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-30,70},{-20,70}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox.frame_b, actuatedRevolute.frame_a) annotation (Line(
          points={{0,70},{10,70}},
          color={95,95,95},
          thickness=0.5));
      connect(actuatedRevolute.frame_b, bodyBox1.frame_a) annotation (Line(
          points={{30,70},{40,70}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox1.frame_b, prismatic.frame_a) annotation (Line(
          points={{60,70},{70,70},{70,50},{-60,50},{-60,30},{-50,30}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic.frame_b, bodyBox2.frame_a) annotation (Line(
          points={{-30,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox2.frame_b, actuatedPrismatic.frame_a) annotation (Line(
          points={{0,30},{10,30}},
          color={95,95,95},
          thickness=0.5));
      connect(actuatedPrismatic.frame_b, bodyBox3.frame_a) annotation (Line(
          points={{30,30},{40,30}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox3.frame_b, cylindrical.frame_a) annotation (Line(
          points={{60,30},{70,30},{70,10},{-60,10},{-60,-10},{-50,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(cylindrical.frame_b, bodyBox4.frame_a) annotation (Line(
          points={{-30,-10},{-20,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox4.frame_b, universal.frame_a) annotation (Line(
          points={{0,-10},{10,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(universal.frame_b, bodyBox5.frame_a) annotation (Line(
          points={{30,-10},{40,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox5.frame_b, planar.frame_a) annotation (Line(
          points={{60,-10},{70,-10},{70,-30},{-60,-30},{-60,-50},{-50,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(planar.frame_b, bodyBox6.frame_a) annotation (Line(
          points={{-30,-50},{-20,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyBox6.frame_b, spherical.frame_a) annotation (Line(
          points={{0,-50},{10,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(spherical.frame_b, bodyBox7.frame_a) annotation (Line(
          points={{30,-50},{40,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(freeMotion.frame_a, bodyBox7.frame_b) annotation (Line(
          points={{-50,-90},{-60,-90},{-60,-70},{70,-70},{70,-50},{60,-50}},
          color={95,95,95},
          thickness=0.5));
      connect(freeMotion.frame_b, bodyBox8.frame_a) annotation (Line(
          points={{-30,-90},{-20,-90}},
          color={95,95,95},
          thickness=0.5));
      annotation (experiment(StopTime=0.2));
    end Joints;

    model Bodies
      extends Modelica.Icons.Example;

      inner MultiBody.World world annotation (Placement(
            transformation(extent={{-80,60},{-60,80}})));
      MultiBody.Parts.Body body(
        sequence_start={3,2,1},
        a_0(each fixed=false, start={2,2,2}),
        angles_fixed=true,
        r_0(each fixed=true, start={1,2,3}),
        v_0(each fixed=true, start={1,2,3}),
        w_0_fixed=true,
        z_0_fixed=false,
        w_0_start={0.06981317007977318,0.05235987755982989,0.03490658503988659},
        z_0_start={0.05235987755982989,0.06981317007977318,0.05235987755982989},
        r_CM={0,0,0},
        m=1,
        angles_start={0.34906585039887,0.5235987755983,0.69813170079773})
        annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

      MultiBody.Parts.PointMass pointMass(
        m=2,
        a_0(each fixed=false, start={5,4,3}),
        r_0(each fixed=true, start={1,2,3}),
        v_0(each fixed=true, start={2,3,4})) annotation (Placement(
            transformation(extent={{0,0},{20,20}})));
      MultiBody.Parts.BodyShape body1(
        sequence_start={3,2,1},
        a_0(each fixed=false, start={2,2,2}),
        angles_fixed=true,
        r_0(each fixed=true, start={1,2,3}),
        v_0(each fixed=true, start={1,2,3}),
        w_0_fixed=true,
        z_0_fixed=false,
        w_0_start={0.06981317007977318,0.05235987755982989,0.03490658503988659},
        z_0_start={0.05235987755982989,0.06981317007977318,0.05235987755982989},
        r_CM={0,0,0},
        m=1,
        r={0,0,0},
        angles_start={0.34906585039887,0.5235987755983,0.69813170079773})
        annotation (Placement(transformation(extent={{0,40},{20,60}})));

      MultiBody.Parts.BodyBox body2(
        sequence_start={3,2,1},
        a_0(each fixed=false, start={2,2,2}),
        angles_fixed=true,
        r_0(each fixed=true, start={1,2,3}),
        v_0(each fixed=true, start={1,2,3}),
        w_0_fixed=true,
        z_0_fixed=false,
        w_0_start={0.06981317007977318,0.05235987755982989,0.03490658503988659},
        z_0_start={0.05235987755982989,0.06981317007977318,0.05235987755982989},
        r={1,0,0},
        angles_start={0.34906585039887,0.5235987755983,0.69813170079773})
        annotation (Placement(transformation(extent={{40,40},{60,60}})));

      MultiBody.Parts.BodyCylinder body3(
        sequence_start={3,2,1},
        a_0(each fixed=false, start={2,2,2}),
        angles_fixed=true,
        r_0(each fixed=true, start={1,2,3}),
        v_0(each fixed=true, start={1,2,3}),
        w_0_fixed=true,
        z_0_fixed=false,
        w_0_start={0.06981317007977318,0.05235987755982989,0.03490658503988659},
        z_0_start={0.05235987755982989,0.06981317007977318,0.05235987755982989},
        r={1,0,0},
        angles_start={0.34906585039887,0.5235987755983,0.69813170079773})
        annotation (Placement(transformation(extent={{-42,0},{-22,20}})));

      annotation (experiment(StopTime=0.2));
    end Bodies;

  end InitializationConversion;
end MultiBody;
