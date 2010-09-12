within ModelicaTest;
package MultiBody "Test models for Modelica.Mechanics.MultiBody"
extends Modelica.Icons.ExamplesPackage;

  encapsulated model SphericalDoublePendulum
    "Double pendulum with two spherical joints and two bodies"
    import ObsoleteModelica3;

    import Modelica;
    import Modelica.Mechanics.MultiBody;
    extends Modelica.Icons.Example;
    inner Modelica.Mechanics.MultiBody.World world
                                annotation (Placement(transformation(extent={{
              -88,0},{-68,20}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody1(
                                     width=0.06, r={0.4,0.0,-0.3})
      annotation (Placement(transformation(extent={{-10,0},{10,20}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody2(
                                     width=0.06, r={0.3,-0.4,0})
      annotation (Placement(transformation(extent={{74,0},{94,20}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Joints.Spherical Spherical1(
      enforceStates=true,
      useQuaternions=false,
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false,
      w_rel_a_start={0.05235987755982989,0.03490658503988659,0.0174532925199433})
                                   annotation (Placement(transformation(extent=
              {{-52,0},{-32,20}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Joints.Spherical Spherical2(
      enforceStates=true,
      useQuaternions=false,
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false)
      annotation (Placement(transformation(extent={{32,0},{52,20}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody3(
                                     width=0.06, r={0.4,0.0,-0.3})
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody4(
                                     width=0.06, r={0.3,-0.4,0})
      annotation (Placement(transformation(extent={{76,-40},{96,-20}}, rotation=
             0)));
    Modelica.Mechanics.MultiBody.Joints.Spherical Spherical3(
      enforceStates=true,
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false,
      w_rel_a_start={0.05235987755982989,0.03490658503988659,0.0174532925199433})
                                   annotation (Placement(transformation(extent=
              {{-52,-40},{-32,-20}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Joints.Spherical Spherical4(
                                          enforceStates=true,
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false)             annotation (Placement(transformation(
            extent={{32,-40},{52,-20}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody5(
      width=0.06,
      r={0.4,0.0,-0.3},
      useQuaternions=true) annotation (Placement(transformation(extent={{-10,
              -80},{10,-60}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody6(
      width=0.06,
      r={0.3,-0.4,0},
      useQuaternions=true) annotation (Placement(transformation(extent={{74,-80},
              {94,-60}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Joints.Spherical Spherical5(
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false,
      w_rel_a_start={0.05235987755982989,0.03490658503988659,0.0174532925199433})
      annotation (Placement(transformation(extent={{-52,-80},{-32,-60}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Joints.Spherical Spherical6(
      angles_fixed=true,
      w_rel_a_fixed=true,
      z_rel_a_fixed=false)  annotation (Placement(transformation(extent={{32,
              -80},{52,-60}}, rotation=0)));
  equation

    connect(boxBody1.frame_b, Spherical2.frame_a)
      annotation (Line(
        points={{10,10},{32,10}},
        color={0,0,0},
        thickness=0.5));
    connect(Spherical2.frame_b, boxBody2.frame_a)
      annotation (Line(
        points={{52,10},{74,10}},
        color={0,0,0},
        thickness=0.5));
    connect(world.frame_b, Spherical1.frame_a)
      annotation (Line(
        points={{-68,10},{-52,10}},
        color={0,0,0},
        thickness=0.5));
    connect(Spherical1.frame_b, boxBody1.frame_a)
      annotation (Line(
        points={{-32,10},{-10,10}},
        color={0,0,0},
        thickness=0.5));
    connect(boxBody3.frame_b, Spherical4.frame_a)
      annotation (Line(
        points={{10,-30},{32,-30}},
        color={0,0,0},
        thickness=0.5));
    connect(Spherical4.frame_b, boxBody4.frame_a)
      annotation (Line(
        points={{52,-30},{76,-30}},
        color={0,0,0},
        thickness=0.5));
    connect(Spherical3.frame_b, boxBody3.frame_a)
      annotation (Line(
        points={{-32,-30},{-10,-30}},
        color={0,0,0},
        thickness=0.5));
    connect(world.frame_b, Spherical3.frame_a) annotation (Line(
        points={{-68,10},{-60,10},{-60,-30},{-52,-30}},
        color={0,0,0},
        thickness=0.5));
    connect(boxBody5.frame_b, Spherical6.frame_a)
      annotation (Line(
        points={{10,-70},{32,-70}},
        color={0,0,0},
        thickness=0.5));
    connect(Spherical6.frame_b, boxBody6.frame_a)
      annotation (Line(
        points={{52,-70},{74,-70}},
        color={0,0,0},
        thickness=0.5));
    connect(Spherical5.frame_b, boxBody5.frame_a)
      annotation (Line(
        points={{-32,-70},{-10,-70}},
        color={0,0,0},
        thickness=0.5));
    connect(Spherical5.frame_a, world.frame_b) annotation (Line(
        points={{-52,-70},{-60,-70},{-60,10},{-68,10}},
        color={0,0,0},
        thickness=0.5));
    annotation (
      experiment(StopTime=3),
      Window(
        x=0.29,
        y=0,
        width=0.71,
        height=0.85),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Documentation(info="<html>
<p>
This example demonstrates that by using joint and body
elements animation is automatically available. Also the revolute
joints are animated. Note, that animation of every component
can be switched of by setting the first parameter <b>animation</b>
to <b>false</b> or by setting <b>enableAnimation</b> in the <b>world</b>
object to <b>false</b> to switch off animation of all components.
</p>


<IMG src=\"modelica://ModelicaTest/Images/Examples/Elementary/DoublePendulum.png\"
ALT=\"model Examples.Elementary.DoublePendulum\">


</HTML>"),
      uses);
  end SphericalDoublePendulum;

  package FourbarVariants "Test joints and assembly joints with four bar loop"
  extends Modelica.Icons.ExamplesPackage;
    model SphericalAndUniversal
      "One kinematic loop with four bars (with Spherical and Universal joint)"

      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;

      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
            transformation(extent={{-80,-80},{-60,-60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute j1(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true, start=5.235987755982989))
                     annotation (Placement(transformation(extent={{-54,-40},{
                -34,-20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        boxWidth=0.05,
        s_offset=-0.2)
        annotation (Placement(transformation(extent={{12,-80},{32,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1}, diameter=0.05)
        annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=0.05)
        annotation (Placement(transformation(
            origin={50,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(r={1.2,0,0}, animation=false)
        annotation (Placement(transformation(extent={{-32,-80},{-12,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Spherical spherical(animation=false)
        annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation FixedTranslation1(r={1,-0.3,-0.1},
          animation=false) annotation (Placement(transformation(extent={{12,20},
                {32,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Universal Universal1(n_b={0,1,0}, n_a={0,0,1})
        annotation (Placement(transformation(extent={{44,20},{64,40}}, rotation=
               0)));
    equation
      j1_phi = j1.phi;
      j2_s = j2.s;
      j1_w = j1.w;
      j2_v = j2.v;
      connect(j2.frame_b, b2.frame_a) annotation (Line(
          points={{32,-70},{50,-70},{50,-60}},
          color={0,0,0},
          thickness=0.5));
      connect(j1.frame_b, b1.frame_a) annotation (Line(
          points={{-34,-30},{-30,-30},{-30,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(j1.frame_a, world.frame_b) annotation (Line(
          points={{-54,-30},{-60,-30},{-60,-70}},
          color={0,0,0},
          thickness=0.5));
      connect(b3.frame_a, world.frame_b)
        annotation (Line(
          points={{-32,-70},{-60,-70}},
          color={0,0,0},
          thickness=0.5));
      connect(b3.frame_b, j2.frame_a)
        annotation (Line(
          points={{-12,-70},{12,-70}},
          color={0,0,0},
          thickness=0.5));
      connect(b1.frame_b, spherical.frame_a) annotation (Line(
          points={{-30,10},{-30,30},{-20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(spherical.frame_b, FixedTranslation1.frame_a) annotation (Line(
          points={{0,30},{12,30}},
          color={0,0,0},
          thickness=0.5));
      connect(FixedTranslation1.frame_b, Universal1.frame_a) annotation (Line(
          points={{32,30},{44,30}},
          color={0,0,0},
          thickness=0.5));
      connect(b2.frame_b, Universal1.frame_b) annotation (Line(
          points={{50,-40},{50,-2},{80,-2},{80,30},{64,30}},
          color={0,0,0},
          thickness=0.5));
      annotation (
        experiment(StopTime=5),
        Documentation(info="<html>
<p>
This is a second version of the \"four-bar\" mechanism, see figure:
</p>

<IMG src=\"modelica://ModelicaTest/Images/MultiBody/Examples/Loops/Fourbar2.png\" ALT=\"model Examples.Loops.Fourbar2\">

<p>
In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <b>UniversalSpherical</b>
that is a rod connecting a spherical and a universal joint. This joint is defined
by <b>1 constraint</b> stating that the distance between the two spherical joints is
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
automatically calculated during <b>initialization</b>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the rod length of joint
\"UniversalSpherical\" is computed during initialization since parameter
<b>computeLength</b> = <b>true</b> is set in the joint parameter
menu. The main advantage is that during initialization no non-linear
system of equation is solved and therefore initialization always works.
To be precise, the following trivial non-linear equation is actually solved
for rodLength:
</p>
<pre>
   rodLength*rodLength = f(angle of revolute joint, distance of prismatic joint)
</pre>
</html>"));
    end SphericalAndUniversal;

    encapsulated model SphericalSpherical
      "One kinematic loop with four bars (with SphericalSpherical joint)"
      import ObsoleteModelica3;

      import Modelica;
      import Modelica.Mechanics.MultiBody;
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;

      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-80,-80},{-60,-60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute j1(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true, start=5.235987755982989))
        annotation (Placement(transformation(extent={{-54,-40},{-34,-20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        a(fixed=false),
        s(fixed=true),
        v(fixed=false),
        s_offset=-0.2)
        annotation (Placement(transformation(extent={{12,-80},{32,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(
                                      r={0,0.5,0.1}, diameter=0.05)
        annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(
                                      r={0,0.2,0}, diameter=0.05)
        annotation (Placement(transformation(
            origin={50,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Joints.SphericalSpherical sphericalSpherical(
                                                             computeRodLength=true,
           m=1) annotation (Placement(transformation(extent={{0,20},{-20,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(
                                          r={1.2,0,0}, animation=false)
        annotation (Placement(transformation(extent={{-32,-80},{-12,-60}},
              rotation=0)));
    equation
      connect(j2.frame_b, b2.frame_a)
        annotation (Line(points={{32,-70},{50,-70},{50,-60}}));
      connect(j1.frame_b, b1.frame_a)
        annotation (Line(points={{-34,-30},{-30,-30},{-30,-10}}));
      connect(j1.frame_a, world.frame_b)
        annotation (Line(points={{-54,-30},{-60,-30},{-60,-70}}));
      connect(b1.frame_b, sphericalSpherical.frame_b)
        annotation (Line(points={{-30,10},{-30,30},{-20,30}}));
      connect(sphericalSpherical.frame_a, b2.frame_b)
        annotation (Line(points={{0,30},{50,30},{50,-40}}));
      j1_phi = j1.phi;
      j2_s = j2.s;
      j1_w = j1.w;
      j2_v = j2.v;
      connect(b3.frame_a, world.frame_b) annotation (Line(points={{-32,-70},{
              -60,-70}}));
      connect(b3.frame_b, j2.frame_a) annotation (Line(points={{-12,-70},{12,
              -70}}));
      annotation (
        experiment(StopTime=5),
        Documentation(info="<html>
<p>
This is a third version of the \"four-bar\" mechanism. In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <b>SphericalSpherical</b>
that is a rod with two spherical joints on each side. This joint is defined
by <b>1 constraint</b> stating that the distance between the two spherical joints is
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
Another nice feature is that the <b>length</b> of the connecting rod can be
automatically calculated during <b>initialization</b>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the length parameter of joint
\"SphericalSpherical\" is computed during initialization since parameter
<b>computeLength</b> = <b>true</b> is set in the joint parameter
menu (this sets \"fixed=false\" on parameter \"length\").
</p>
</html>
"));
    end SphericalSpherical;

    encapsulated model UniversalSpherical
      "One kinematic loop with four bars (with UniversalSpherical joint)"
      import ObsoleteModelica3;

      import Modelica;
      import Modelica.Mechanics.MultiBody;
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;

      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-80,-80},{-60,-60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute j1(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true, start=5.235987755982989))
        annotation (Placement(transformation(extent={{-54,-40},{-34,-20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        boxWidth=0.01,
        a(fixed=false),
        s(fixed=false),
        v(fixed=false),
        s_offset=-0.2)                      annotation (Placement(
            transformation(extent={{12,-80},{32,-60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(
                                      r={0,0.5,0.1}, diameter=0.05)
        annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(
                                      r={0,0.2,0}, diameter=0.05)
        annotation (Placement(transformation(
            origin={50,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Joints.UniversalSpherical universalSpherical(
                                                             rRod_ia={-1,0.3,0.1},
          n1_a={0,1,0.1}) annotation (Placement(transformation(extent={{0,20},{
                -20,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(
                                          animation=false, r={1,0,0})
        annotation (Placement(transformation(extent={{-32,-80},{-12,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame fixedFrame4
        annotation (Placement(transformation(
            origin={-10,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      j1_phi = j1.phi;
      j2_s = j2.s;
      j1_w = j1.w;
      j2_v = j2.v;
      connect(j2.frame_b, b2.frame_a)
        annotation (Line(points={{32,-70},{50,-70},{50,-60}}));
      connect(j1.frame_b, b1.frame_a)
        annotation (Line(points={{-34,-30},{-30,-30},{-30,-10}}));
      connect(j1.frame_a, world.frame_b)
        annotation (Line(points={{-54,-30},{-60,-30},{-60,-70}}));
      connect(b1.frame_b, universalSpherical.frame_b)
        annotation (Line(points={{-30,10},{-30,30},{-20,30}}));
      connect(universalSpherical.frame_a, b2.frame_b)
        annotation (Line(points={{0,30},{50,30},{50,-40}}));
      connect(b3.frame_a, world.frame_b) annotation (Line(points={{-32,-70},{
              -60,-70}}));
      connect(b3.frame_b, j2.frame_a) annotation (Line(points={{-12,-70},{12,
              -70}}));
      connect(fixedFrame4.frame_a, universalSpherical.frame_ia)
        annotation (Line(points={{-10,60},{-10,50},{-6,50},{-6,40}}, color={0,0,
              0}));
      annotation (
        experiment(StopTime=5),
        Documentation(info="<html>
<p>
This is a fourth version of the \"four-bar\" mechanism. In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <b>UniversalSpherical</b>
that is a rod with a spherical and a universal joint on two sides. This joint is defined
by <b>1 constraint</b> stating that the distance between the two spherical joints is
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
<b>frame_ia</b>, to be fixed on the rod, where other objects can be attached.
In this example, the coordinate system of frame_ia is visualized.
</p>
<p>
Another nice feature is that the <b>length</b> of the connecting rod can be
automatically calculated during <b>initialization</b>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the length parameter of joint
\"UniversalSpherical\" is computed during initialization since parameter
<b>computeLength</b> = <b>true</b> is set in the joint parameter
menu (this sets \"fixed=false\" on parameter \"length\").
</p>
</html>"));
    end UniversalSpherical;

    encapsulated model UniversalSpherical_2
      "One kinematic loop with four bars (with UniversalSpherical joint)"
      import ObsoleteModelica3;

      import Modelica;
      import Modelica.Mechanics.MultiBody;
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;

      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-80,-80},{-60,-60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute j1(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true, start=5.235987755982989))
        annotation (Placement(transformation(extent={{-54,-40},{-34,-20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        boxWidth=0.01,
        a(fixed=false),
        s(fixed=false),
        v(fixed=false),
        s_offset=-0.2)                      annotation (Placement(
            transformation(extent={{12,-80},{32,-60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(
                                      r={0,0.5,0.1}, diameter=0.05)
        annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(
                                      r={0,0.2,0}, diameter=0.05)
        annotation (Placement(transformation(
            origin={50,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Joints.UniversalSpherical universalSpherical(
        n1_a={0,1,0.1},
        rRod_ia={{-1,0.3,0.1}*{-1,0.3,0.1},0,0},
        rRod_a(start={-1,0.3,0.1})) annotation (Placement(transformation(extent=
               {{0,20},{-20,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(
                                          animation=false, r={1,0,0})
        annotation (Placement(transformation(extent={{-32,-80},{-12,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame fixedFrame4
        annotation (Placement(transformation(
            origin={-10,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      j1_phi = j1.phi;
      j2_s = j2.s;
      j1_w = j1.w;
      j2_v = j2.v;
      connect(j2.frame_b, b2.frame_a)
        annotation (Line(points={{32,-70},{50,-70},{50,-60}}));
      connect(j1.frame_b, b1.frame_a)
        annotation (Line(points={{-34,-30},{-30,-30},{-30,-10}}));
      connect(j1.frame_a, world.frame_b)
        annotation (Line(points={{-54,-30},{-60,-30},{-60,-70}}));
      connect(b1.frame_b, universalSpherical.frame_b)
        annotation (Line(points={{-30,10},{-30,30},{-20,30}}));
      connect(universalSpherical.frame_a, b2.frame_b)
        annotation (Line(points={{0,30},{50,30},{50,-40}}));
      connect(b3.frame_a, world.frame_b) annotation (Line(points={{-32,-70},{
              -60,-70}}));
      connect(b3.frame_b, j2.frame_a) annotation (Line(points={{-12,-70},{12,
              -70}}));
      connect(fixedFrame4.frame_a, universalSpherical.frame_ia)
        annotation (Line(points={{-10,60},{-10,50},{-6,50},{-6,40}}, color={0,0,
              0}));
      annotation (
        experiment(StopTime=5),
        Documentation(info="<html>
<p>
This is a fourth version of the \"four-bar\" mechanism. In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <b>UniversalSpherical</b>
that is a rod with a spherical and a universal joint on two sides. This joint is defined
by <b>1 constraint</b> stating that the distance between the two spherical joints is
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
<b>frame_ia</b>, to be fixed on the rod, where other objects can be attached.
In this example, the coordinate system of frame_ia is visualized.
</p>
<p>
Another nice feature is that the <b>length</b> of the connecting rod can be
automatically calculated during <b>initialization</b>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the length parameter of joint
\"UniversalSpherical\" is computed during initialization since parameter
<b>computeLength</b> = <b>true</b> is set in the joint parameter
menu (this sets \"fixed=false\" on parameter \"length\").
</p>
</html>"));
    end UniversalSpherical_2;

    encapsulated model JointUSR
      "One kinematic loop with four bars (using JointUSR joint)"
      import ObsoleteModelica3;

      import Modelica;
      import Modelica.Mechanics.MultiBody;
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;

      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-80,-80},{-60,-60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        s(fixed=true),
        v(fixed=true, start=-0.4),
        s_offset=-0.2)
        annotation (Placement(transformation(extent={{12,-80},{32,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(
                                      r={0,0.2,0}, diameter=0.05)
        annotation (Placement(transformation(
            origin={50,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(
                                          animation=false, r={1.2,0,0})
        annotation (Placement(transformation(extent={{-32,-80},{-12,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame fixedFrame
        annotation (Placement(transformation(
            origin={-6,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSR jointUSR(
        n1_a={0,1,0},
        n_b={1,0,0},
        rRod2_ib={0,0.5,0.1},
        checkTotalPower=true,
        rRod1_ia={-1,0.3,-0.1}) annotation (Placement(transformation(extent={{0,
                0},{-20,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body Body1(
        m=1,
        I_11=0.1,
        I_22=0.1,
        I_33=0.1,
        r_CM={0.01,0,0}) annotation (Placement(transformation(extent={{-74,40},
                {-54,60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body Body2(
        m=1,
        I_11=0.1,
        I_22=0.1,
        I_33=0.1,
        r_CM=jointUSR.eRod1_ia/2) annotation (Placement(transformation(extent={
                {20,40},{40,60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body Body3(
        m=1,
        I_11=0.1,
        I_22=0.1,
        I_33=0.1) annotation (Placement(transformation(extent={{-38,68},{-18,88}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Damper damper(
                                                  d=0.1)
        annotation (Placement(transformation(
            origin={-64,12},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      j1_phi = jointUSR.revolute.phi;
      j2_s = j2.s;
      j1_w = der(jointUSR.revolute.phi);
      j2_v = j2.v;
      connect(j2.frame_b, b2.frame_a)
        annotation (Line(points={{32,-70},{50,-70},{50,-60}}));
      connect(b3.frame_a, world.frame_b) annotation (Line(points={{-32,-70},{
              -60,-70}}));
      connect(b3.frame_b, j2.frame_a) annotation (Line(points={{-12,-70},{12,
              -70}}));
      connect(world.frame_b, jointUSR.frame_b)
        annotation (Line(points={{-60,-70},{-50,-70},{-50,10},{-20,10}}));
      connect(jointUSR.frame_a, b2.frame_b)
        annotation (Line(points={{0,10},{50,10},{50,-40}}));
      connect(jointUSR.frame_ia, fixedFrame.frame_a)
        annotation (Line(points={{-2,20},{-4,32},{-6,32},{-6,40}}));
      connect(jointUSR.frame_ia, Body2.frame_a)
        annotation (Line(points={{-2,20},{-4,32},{10,32},{10,50},{20,50}}));
      connect(jointUSR.frame_ib, Body1.frame_a)
        annotation (Line(points={{-18,20},{-18,30},{-80,30},{-80,50},{-74,50}}));
      connect(Body3.frame_a, jointUSR.frame_im) annotation (Line(points={{-38,
              78},{-48,78},{-48,34},{-10,34},{-10,20}}, color={0,0,0}));
      connect(damper.flange_b, jointUSR.axis)
        annotation (Line(points={{-64,22},{-36,22},{-36,18},{-20,18}}, color={0,
              0,0}));
      connect(jointUSR.bearing, damper.flange_a)
        annotation (Line(points={{-20,14},{-54,14},{-54,2},{-64,2}}, color={0,0,
              0}));
      annotation (
        experiment(StopTime=2),
        Documentation(info="<html>
<p>
This is a fourth version of the \"four-bar\" mechanism. In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <b>UniversalSpherical</b>
that is a rod with a spherical and a universal joint on two sides. This joint is defined
by <b>1 constraint</b> stating that the distance between the two spherical joints is
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
<b>frame_ia</b>, to be fixed on the rod, where other objects can be attached.
In this example, the coordinate system of frame_ia is visualized.
</p>
<p>
Another nice feature is that the <b>length</b> of the connecting rod can be
automatically calculated during <b>initialization</b>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the length parameter of joint
\"UniversalSpherical\" is computed during initialization since parameter
<b>computeLength</b> = <b>true</b> is set in the joint parameter
menu (this sets \"fixed=false\" on parameter \"length\").
</p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics),
        experimentSetupOutput);
    end JointUSR;

    encapsulated model JointSSR
      "One kinematic loop with four bars (using JointSSR joint)"
      import ObsoleteModelica3;

      import Modelica;
      import Modelica.Mechanics.MultiBody;
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Distance L=Modelica.Math.Vectors.length(
                                                                    {-1,0.3,0.1});
      output SI.Angle j1_phi "angle of revolute joint j1";
      output SI.Position j2_s "distance of prismatic joint j2";
      output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
      output SI.Velocity j2_v "axis velocity of prismatic joint j2";

      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-80,-80},{-60,-60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        s(fixed=true),
        v(fixed=true, start=-0.2),
        s_offset=-0.2)
        annotation (Placement(transformation(extent={{12,-80},{32,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(
                                      r={0,0.2,0}, diameter=0.05)
        annotation (Placement(transformation(
            origin={50,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(
                                          animation=false, r={1.2,0,0})
        annotation (Placement(transformation(extent={{-32,-80},{-12,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSR jointSSR(
        n_b={1,0,0},
        rRod2_ib={0,0.5,0.1},
        rod1Length=L,
        checkTotalPower=true,
        rod1Mass=0.1) annotation (Placement(transformation(extent={{-2,0},{-22,
                20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame FixedFrame1
        annotation (Placement(transformation(extent={{-40,60},{-60,80}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body Body1(
                                 r_CM=jointSSR.rRod2_ib/2, m=0.1)
        annotation (Placement(transformation(extent={{-30,30},{-50,50}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body Body2(
                                 m=0.1) annotation (Placement(transformation(
              extent={{20,30},{40,50}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Damper damper(
                                                  d=0.5)
        annotation (Placement(transformation(
            origin={-62,16},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      j1_phi = jointSSR.revolute.phi;
      j2_s = j2.s;
      j1_w = der(jointSSR.revolute.phi);
      j2_v = j2.v;
      connect(j2.frame_b, b2.frame_a)
        annotation (Line(points={{32,-70},{50,-70},{50,-60}}));
      connect(b3.frame_a, world.frame_b) annotation (Line(points={{-32,-70},{
              -60,-70}}));
      connect(b3.frame_b, j2.frame_a) annotation (Line(points={{-12,-70},{12,
              -70}}));
      connect(world.frame_b, jointSSR.frame_b)
        annotation (Line(points={{-60,-70},{-50,-70},{-50,10},{-22,10}}));
      connect(jointSSR.frame_a, b2.frame_b)
        annotation (Line(points={{-2,10},{50,10},{50,-40}}));
      connect(FixedFrame1.frame_a, jointSSR.frame_ib)
        annotation (Line(points={{-40,70},{-20,70},{-20,20}}, color={0,0,0}));
      connect(Body1.frame_a, jointSSR.frame_ib)
        annotation (Line(points={{-30,40},{-20,40},{-20,20}}, color={0,0,0}));
      connect(Body2.frame_a, jointSSR.frame_im)
        annotation (Line(points={{20,40},{-12,40},{-12,20}}, color={0,0,0}));
      connect(jointSSR.axis, damper.flange_b)
        annotation (Line(points={{-22,18},{-42,18},{-42,26},{-62,26}}, color={0,
              0,0}));
      connect(jointSSR.bearing, damper.flange_a)
        annotation (Line(points={{-22,14},{-52,14},{-52,6},{-62,6}}, color={0,0,
              0}));
      annotation (
        experiment(StopTime=1.1),
        Documentation(info="<html>
<p>
This is a fourth version of the \"four-bar\" mechanism. In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <b>UniversalSpherical</b>
that is a rod with a spherical and a universal joint on two sides. This joint is defined
by <b>1 constraint</b> stating that the distance between the two spherical joints is
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
<b>frame_ia</b>, to be fixed on the rod, where other objects can be attached.
In this example, the coordinate system of frame_ia is visualized.
</p>
<p>
Another nice feature is that the <b>length</b> of the connecting rod can be
automatically calculated during <b>initialization</b>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the length parameter of joint
\"UniversalSpherical\" is computed during initialization since parameter
<b>computeLength</b> = <b>true</b> is set in the joint parameter
menu (this sets \"fixed=false\" on parameter \"length\").
</p>
</html>"));
    end JointSSR;

    encapsulated model JointUSP
      "One kinematic loop with four bars (using JointUSP joint)"
      import ObsoleteModelica3;

      import Modelica;
      import Modelica.Mechanics.MultiBody;
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;

      output SI.Angle revolute_phi "angle of revolute joint j1";
      output SI.Position prismatic_s "distance of prismatic joint j2";
      output SI.AngularVelocity revolute_w "axis speed of revolute joint j1";
      output SI.Velocity prismatic_v "axis velocity of prismatic joint j2";

      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-80,-80},{-60,-60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute(
        n={1,0,0},
        stateSelect=StateSelect.always,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true, start=5.235987755982989))
        annotation (Placement(transformation(extent={{-54,-40},{-34,-20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder body1(
                                         r={0,0.5,0.1}, diameter=0.05)
        annotation (Placement(transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder body3(
                                         r={0,0.2,0}, diameter=0.05)
        annotation (Placement(transformation(
            origin={50,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation ground_rod(
                                                  animation=false, r={1.2,0,0})
        annotation (Placement(transformation(extent={{-32,-80},{-12,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSP jointUSP(
        rRod2_ib={0,0.2,0},
        n1_a={0,0,-1},
        n_b={-1,0,0},
        rod1Diameter=0.04,
        boxWidth=0.05,
        rRod1_ia={1,-0.3,0.1}) annotation (Placement(transformation(extent={{0,
                20},{20,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder body2(
                                         r={1,-0.3,0.1}, diameter=0.05)
        annotation (Placement(transformation(extent={{8,60},{28,80}}, rotation=
                0)));
      Modelica.Mechanics.Translational.Components.Damper damper(
                                                     d=50)
        annotation (Placement(transformation(
            origin={52,30},
            extent={{10,-10},{-10,10}},
            rotation=270)));
    equation
      revolute_phi = revolute.phi;
      prismatic_s = jointUSP.prismatic.s;
      revolute_w = revolute.w;
      prismatic_v = der(jointUSP.prismatic.s);
      connect(revolute.frame_b, body1.frame_a) annotation (Line(
          points={{-34,-30},{-30,-30},{-30,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(revolute.frame_a, world.frame_b) annotation (Line(
          points={{-54,-30},{-60,-30},{-60,-70}},
          color={0,0,0},
          thickness=0.5));
      connect(ground_rod.frame_a, world.frame_b)
        annotation (Line(
          points={{-32,-70},{-60,-70}},
          color={0,0,0},
          thickness=0.5));
      connect(body1.frame_b, jointUSP.frame_a) annotation (Line(
          points={{-30,10},{-30,30},{0,30}},
          color={0,0,0},
          thickness=0.5));
      connect(ground_rod.frame_b, jointUSP.frame_b) annotation (Line(
          points={{-12,-70},{30,-70},{30,30},{20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(jointUSP.frame_ib, body3.frame_a) annotation (Line(
          points={{18,40},{18,48},{50,48},{50,60}},
          color={0,0,0},
          thickness=0.5));
      connect(jointUSP.frame_ia, body2.frame_a)
        annotation (Line(
          points={{2,40},{2,70},{8,70}},
          color={0,0,0},
          thickness=0.5));
      connect(jointUSP.bearing, damper.flange_a) annotation (Line(points={{20,
              34},{38,34},{38,10},{52,10},{52,20}}, color={0,191,0}));
      connect(jointUSP.axis, damper.flange_b) annotation (Line(points={{20,38},
              {38,38},{38,44},{52,44},{52,40}}, color={0,191,0}));
      annotation (
        experiment(StopTime=5),
        Documentation(info=""));
    end JointUSP;
  end FourbarVariants;

  package Frames "Test functions of package Frames"
    extends Modelica.Icons.ExamplesPackage;
    model AngularVelocity "Test angular velocity functions"
      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody.Frames.*;
      extends Modelica.Icons.Example;
      Modelica.Mechanics.MultiBody.Frames.Orientation R=body.frame_a.R;
      SI.AngularVelocity wa[3]=angularVelocity2(R);
      SI.AngularVelocity w1[3]=resolve1(R, wa);
      SI.AngularVelocity w2[3]=angularVelocity1(R);
      SI.AngularVelocity w_err[3]=w2 - w1;
      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-60,20},{-40,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar2(
                                            r={0.8,0,0}, animation=false)
        annotation (Placement(transformation(extent={{0,20},{20,40}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Forces.Spring spring1(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={-24,6},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape body(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r={0.4,0,0},
        r_CM={0.2,0,0},
        width=0.05,
        angles_start={0.174532925199433,0.174532925199433,0.174532925199433},
        a_0(fixed=false),
        angles_fixed=true,
        r_0(fixed=true, start={0.2,-0.5,0.1}),
        v_0(fixed=true),
        w_0_fixed=true,
        z_0_fixed=false)
        annotation (Placement(transformation(extent={{0,-40},{20,-20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Spring spring2(
        c=20,
        s_unstretched=0,
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5) annotation (Placement(transformation(
            origin={42,6},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Forces.WorldTorque FrameTorque1(
          resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{58,-42},{38,-22}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant Constant1[3](k={10,0,0})
        annotation (Placement(transformation(extent={{94,-42},{74,-22}},
              rotation=0)));
    equation
      connect(bar2.frame_a, world.frame_b)
        annotation (Line(
          points={{0,30},{-40,30}},
          color={0,0,0},
          thickness=0.5));
      connect(spring1.frame_b, body.frame_a) annotation (Line(
          points={{-24,-4},{-24,-30},{0,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(spring2.frame_b, body.frame_b)
        annotation (Line(
          points={{42,-4},{20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(bar2.frame_b, spring2.frame_a) annotation (Line(
          points={{20,30},{42,30},{42,16}},
          color={0,0,0},
          thickness=0.5));
      connect(spring1.frame_a, world.frame_b) annotation (Line(
          points={{-24,16},{-24,30},{-40,30}},
          color={0,0,0},
          thickness=0.5));
      connect(FrameTorque1.frame_b, body.frame_b) annotation (Line(
          points={{38,-32},{30,-32},{30,-30},{20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(Constant1.y,FrameTorque1.torque)
        annotation (Line(points={{73,-32},{60,-32}}, color={0,0,255}));
      annotation (experiment(StopTime=1.1));
    end AngularVelocity;
  end Frames;

  package Forces
  extends Modelica.Icons.ExamplesPackage;
    model DifferentiationOfForces
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.
            UniformGravity) annotation (Placement(transformation(extent={{-80,0},
                {-60,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute rev(        n={0,0,1},
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true))             annotation (Placement(transformation(extent=
                {{-40,0},{-20,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox body(r={1,0,0})
        annotation (Placement(transformation(extent={{0,0},{20,20}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.FrameForceAndTorque
        frameForceAndTorque
        annotation (Placement(transformation(extent={{-40,-40},{-20,-20}},
              rotation=0)));
      Modelica.Blocks.Sources.Sine sine[6] annotation (Placement(transformation(
              extent={{-80,-40},{-60,-20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce
        annotation (Placement(transformation(extent={{0,-40},{20,-20}},
              rotation=0)));
      Modelica.Blocks.Continuous.Der der1[3] annotation (Placement(
            transformation(extent={{20,-70},{40,-50}}, rotation=0)));
      Modelica.Blocks.Continuous.Der der2[3] annotation (Placement(
            transformation(extent={{54,-70},{74,-50}}, rotation=0)));
    equation
      connect(world.frame_b,rev. frame_a)
        annotation (Line(
          points={{-60,10},{-40,10}},
          color={95,95,95},
          thickness=0.5));
      connect(body.frame_a,rev. frame_b) annotation (Line(
          points={{0,10},{-20,10}},
          color={95,95,95},
          thickness=0.5));
      connect(sine.y, frameForceAndTorque.load) annotation (Line(points={{-59,
              -30},{-42,-30}}, color={0,0,127}));
      connect(frameForceAndTorque.frame_b, cutForce.frame_a) annotation (Line(
          points={{-20,-30},{0,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(cutForce.frame_b, body.frame_b) annotation (Line(
          points={{20,-30},{30,-30},{30,10},{20,10}},
          color={95,95,95},
          thickness=0.5));
      connect(cutForce.force, der1.u) annotation (Line(points={{2,-41},{2,-60},
              {18,-60}}, color={0,0,127}));
      connect(frameForceAndTorque.frame_resolve, body.frame_a) annotation (Line(
          points={{-30,-20},{-30,-14},{-12,-14},{-12,10},{0,10}},
          color={95,95,95},
          pattern=LinePattern.Dot));
      connect(der1.y, der2.u) annotation (Line(points={{41,-60},{52,-60}},
            color={0,0,127}));
      annotation (experiment(StopTime=1.1),
                  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics));
    end DifferentiationOfForces;

    model Force
      extends Modelica.Icons.Example;
      import Modelica.Mechanics.MultiBody.*;
      inner World world annotation (Placement(transformation(extent={{-80,60},{
                -60,80}}, rotation=0)));
      Joints.Revolute Revolute1(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,40},{20,60}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,500,0})
        annotation (Placement(transformation(
            origin={50,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,0},{-70,20}}, rotation=0)));
      Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}}, rotation=0)));
      Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-70},{-68,-50}}, rotation=0)));
      Parts.FixedRotation fixedRotation(n={0,0,1}, angle=45)
        annotation (Placement(transformation(extent={{-8,-90},{12,-70}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Force force1(
                          N_to_m=600, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
                                      annotation (Placement(transformation(
              extent={{62,40},{42,60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Force force2(
                          N_to_m=600, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
                                      annotation (Placement(transformation(
              extent={{60,-10},{40,-30}}, rotation=0)));
      Joints.Revolute Revolute2(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={0,500,0})
        annotation (Placement(transformation(
            origin={70,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Joints.Revolute Revolute3 annotation (Placement(transformation(extent={{
                -52,0},{-32,20}}, rotation=0)));
      Joints.Revolute Revolute4 annotation (Placement(transformation(extent={{
                -62,-70},{-42,-50}}, rotation=0)));
      Parts.Fixed fixed2(animation=false, r={1.5,0.25,0})
        annotation (Placement(transformation(extent={{100,40},{80,60}},
              rotation=0)));
      Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0})
        annotation (Placement(transformation(extent={{100,-30},{80,-10}},
              rotation=0)));
    equation
      connect(force1.frame_b, body1.frame_b) annotation (Line(points={{42,50},{
              20,50}}));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,40},{-20,50},{0,50}}));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,-30},{-20,-20},{0,-20}}));
      connect(force2.frame_b, body2.frame_b) annotation (Line(points={{40,-20},
              {20,-20}}));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-52,10},{-70,10}}));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-32,10},{-20,10},{-20,20}}));
      connect(fixedRotation.frame_b, force2.frame_resolve)
        annotation (Line(points={{12,-80},{46,-80},{46,-30}}));
      connect(fixed3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-68,-60},{-62,-60}}));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-42,-60},{-20,-60},{-20,-50}}));
      connect(fixed3.frame_b, fixedRotation.frame_a)
        annotation (Line(points={{-68,-60},{-64,-60},{-64,-80},{-8,-80}}));
      connect(Constant1.y,force1.force)
        annotation (Line(points={{50,79},{50,72},{58,72},{58,62}}, color={0,0,
              255}));
      connect(Constant2.y,force2.force)
        annotation (Line(points={{70,-59},{70,-42},{56,-42},{56,-32}}, color={0,
              0,255}));
      connect(force1.frame_a, fixed2.frame_b) annotation (Line(
          points={{62,50},{71.5,50},{71.5,50},{80,50}},
          color={0,0,0},
          thickness=0.5));
      connect(fixed4.frame_b, force2.frame_a) annotation (Line(
          points={{80,-20},{70,-20},{70,-20},{60,-20}},
          color={0,0,0},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
                  experiment(StopTime=1.1));
    end Force;

    model Force2
      extends Modelica.Icons.Example;
      import Modelica.Mechanics.MultiBody.*;
      inner World world annotation (Placement(transformation(extent={{-80,60},{
                -60,80}}, rotation=0)));
      Joints.Revolute Revolute1(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));

      Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,40},{20,60}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,500,0})
        annotation (Placement(transformation(
            origin={50,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,0},{-70,20}}, rotation=0)));
      Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}}, rotation=0)));
      Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-70},{-68,-50}}, rotation=0)));
      Parts.FixedRotation fixedRotation(n={0,0,1}, angle=45)
        annotation (Placement(transformation(extent={{-8,-90},{12,-70}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Force force1(
                          N_to_m=600, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
                                      annotation (Placement(transformation(
              extent={{62,40},{42,60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Force force2(
                          N_to_m=600, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
                                      annotation (Placement(transformation(
              extent={{60,-10},{40,-30}}, rotation=0)));
      Joints.Revolute Revolute2(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={0,500,0})
        annotation (Placement(transformation(
            origin={70,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Joints.Revolute Revolute3 annotation (Placement(transformation(extent={{
                -52,0},{-32,20}}, rotation=0)));
      Joints.Revolute Revolute4 annotation (Placement(transformation(extent={{
                -62,-70},{-42,-50}}, rotation=0)));
      Parts.Fixed fixed2(animation=false, r={1.5,0.25,0})
        annotation (Placement(transformation(extent={{100,40},{80,60}},
              rotation=0)));
      Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0})
        annotation (Placement(transformation(extent={{100,-30},{80,-10}},
              rotation=0)));
      Joints.Revolute Revolute5(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,-180},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Parts.BodyCylinder body3(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-170},{20,-150}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Constant3[6](k={0,500,0,0,0,0})
        annotation (Placement(transformation(
            origin={50,-120},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Parts.Fixed fixed5(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,-210},{-70,-190}}, rotation=0)));
      Parts.BodyCylinder body4(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-240},{20,-220}}, rotation=0)));
      Parts.Fixed fixed6(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-280},{-68,-260}}, rotation=0)));
      Parts.FixedRotation fixedRotation1(n={0,0,1}, angle=45)
        annotation (Placement(transformation(extent={{-8,-300},{12,-280}},
              rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.ForceAndTorque force3(
                                   N_to_m=600)
        annotation (Placement(transformation(extent={{62,-170},{42,-150}},
              rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.ForceAndTorque force4(
                                   N_to_m=600)
        annotation (Placement(transformation(extent={{60,-220},{40,-240}},
              rotation=0)));
      Joints.Revolute Revolute6(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,-250},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant4[6](k={0,500,0,0,0,0})
        annotation (Placement(transformation(
            origin={70,-280},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Joints.Revolute Revolute7 annotation (Placement(transformation(extent={{
                -52,-210},{-32,-190}}, rotation=0)));
      Joints.Revolute Revolute8 annotation (Placement(transformation(extent={{
                -62,-280},{-42,-260}}, rotation=0)));
      Parts.Fixed fixed7(animation=false, r={1.5,0.25,0})
        annotation (Placement(transformation(extent={{100,-170},{80,-150}},
              rotation=0)));
      Parts.Fixed fixed8(animation=false, r={1.5,-0.25,0})
        annotation (Placement(transformation(extent={{100,-240},{80,-220}},
              rotation=0)));
    equation
      connect(force1.frame_b, body1.frame_b) annotation (Line(points={{42,50},{
              20,50}}));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,40},{-20,50},{0,50}}));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,-30},{-20,-20},{0,-20}}));
      connect(force2.frame_b, body2.frame_b) annotation (Line(points={{40,-20},
              {20,-20}}));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-52,10},{-70,10}}));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-32,10},{-20,10},{-20,20}}));
      connect(fixedRotation.frame_b, force2.frame_resolve)
        annotation (Line(points={{12,-80},{46,-80},{46,-30}}));
      connect(fixed3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-68,-60},{-62,-60}}));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-42,-60},{-20,-60},{-20,-50}}));
      connect(fixed3.frame_b, fixedRotation.frame_a)
        annotation (Line(points={{-68,-60},{-64,-60},{-64,-80},{-8,-80}}));
      connect(Constant1.y,force1.force)
        annotation (Line(points={{50,79},{50,72},{58,72},{58,62}}, color={0,0,
              255}));
      connect(Constant2.y,force2.force)
        annotation (Line(points={{70,-59},{70,-42},{56,-42},{56,-32}}, color={0,
              0,255}));
      connect(force1.frame_a, fixed2.frame_b) annotation (Line(
          points={{62,50},{71.5,50},{71.5,50},{80,50}},
          color={0,0,0},
          thickness=0.5));
      connect(fixed4.frame_b, force2.frame_a) annotation (Line(
          points={{80,-20},{70,-20},{70,-20},{60,-20}},
          color={0,0,0},
          thickness=0.5));
      connect(force3.frame_b, body3.frame_b)
        annotation (Line(points={{42,-160},{20,-160}}));
      connect(Revolute5.frame_b, body3.frame_a)
        annotation (Line(points={{-20,-170},{-20,-160},{0,-160}}));
      connect(Revolute6.frame_b, body4.frame_a)
        annotation (Line(points={{-20,-240},{-20,-230},{0,-230}}));
      connect(force4.frame_b, body4.frame_b)
        annotation (Line(points={{40,-230},{20,-230}}));
      connect(Revolute7.frame_a, fixed5.frame_b)
        annotation (Line(points={{-52,-200},{-70,-200}}));
      connect(Revolute7.frame_b, Revolute5.frame_a)
        annotation (Line(points={{-32,-200},{-20,-200},{-20,-190}}));
      connect(fixedRotation1.frame_b, force4.frame_resolve)
        annotation (Line(points={{12,-290},{46,-290},{46,-240}}));
      connect(fixed6.frame_b, Revolute8.frame_a)
        annotation (Line(points={{-68,-270},{-62,-270}}));
      connect(Revolute8.frame_b, Revolute6.frame_a)
        annotation (Line(points={{-42,-270},{-20,-270},{-20,-260}}));
      connect(fixed6.frame_b, fixedRotation1.frame_a)
        annotation (Line(points={{-68,-270},{-64,-270},{-64,-290},{-8,-290}}));
      connect(Constant3.y,force3.load)          annotation (Line(points={{50,
              -131},{50,-138},{58,-138},{58,-148}}, color={0,0,255}));
      connect(Constant4.y,force4.load)          annotation (Line(points={{70,
              -269},{70,-252},{56,-252},{56,-242}}, color={0,0,255}));
      connect(force3.frame_a, fixed7.frame_b) annotation (Line(
          points={{62,-160},{71.5,-160},{71.5,-160},{80,-160}},
          color={0,0,0},
          thickness=0.5));
      connect(fixed8.frame_b, force4.frame_a) annotation (Line(
          points={{80,-230},{70,-230},{70,-230},{60,-230}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Force2;

    model ForcesAndTorques
      extends Modelica.Icons.Example;
      import Modelica.Mechanics.MultiBody.*;
      inner World world annotation (Placement(transformation(extent={{-80,60},{
                -60,80}}, rotation=0)));
      Joints.Revolute Revolute1(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,40},{20,60}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Constant1[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(
            origin={50,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,0},{-70,20}}, rotation=0)));
      Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}}, rotation=0)));
      Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-70},{-68,-50}}, rotation=0)));
      Parts.FixedRotation fixedRotation(n={0,0,1}, angle=45)
        annotation (Placement(transformation(extent={{-8,-90},{12,-70}},
              rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.ForceAndTorque
        forceAndTorque1(                    Nm_to_m=120, N_to_m=600)
        annotation (Placement(transformation(extent={{62,40},{42,60}}, rotation=
               0)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.ForceAndTorque
        forceAndTorque2(                    Nm_to_m=120, N_to_m=600)
        annotation (Placement(transformation(extent={{60,-10},{40,-30}},
              rotation=0)));
      Joints.Revolute Revolute2(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(
            origin={70,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Joints.Revolute Revolute3 annotation (Placement(transformation(extent={{
                -52,0},{-32,20}}, rotation=0)));
      Joints.Revolute Revolute4 annotation (Placement(transformation(extent={{
                -62,-70},{-42,-50}}, rotation=0)));
      Parts.Fixed fixed2(animation=false, r={1.5,0.25,0})
        annotation (Placement(transformation(extent={{100,40},{80,60}},
              rotation=0)));
      Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0})
        annotation (Placement(transformation(extent={{100,-30},{80,-10}},
              rotation=0)));
    equation
      connect(forceAndTorque1.frame_b, body1.frame_b)
        annotation (Line(points={{42,50},{20,50}}));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,40},{-20,50},{0,50}}));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,-30},{-20,-20},{0,-20}}));
      connect(forceAndTorque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,-20},{20,-20}}));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-52,10},{-70,10}}));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-32,10},{-20,10},{-20,20}}));
      connect(fixedRotation.frame_b, forceAndTorque2.frame_resolve)
        annotation (Line(points={{12,-80},{46,-80},{46,-30}}));
      connect(fixed3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-68,-60},{-62,-60}}));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-42,-60},{-20,-60},{-20,-50}}));
      connect(fixed3.frame_b, fixedRotation.frame_a)
        annotation (Line(points={{-68,-60},{-64,-60},{-64,-80},{-8,-80}}));
      connect(Constant1.y,forceAndTorque1.load)
        annotation (Line(points={{50,79},{50,72},{58,72},{58,62}}, color={0,0,
              255}));
      connect(Constant2.y,forceAndTorque2.load)
        annotation (Line(points={{70,-59},{70,-42},{56,-42},{56,-32}}, color={0,
              0,255}));
      connect(forceAndTorque1.frame_a, fixed2.frame_b) annotation (Line(
          points={{62,50},{71.5,50},{71.5,50},{80,50}},
          color={0,0,0},
          thickness=0.5));
      connect(fixed4.frame_b, forceAndTorque2.frame_a) annotation (Line(
          points={{80,-20},{70,-20},{70,-20},{60,-20}},
          color={0,0,0},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
                  experiment(StopTime=1.1));
    end ForcesAndTorques;

    model ForceWithTwoMasses
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-100,20},{-80,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute
                                         annotation (Placement(transformation(
              extent={{-40,20},{-20,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox BodyBox1(
                                       r={0.7,0,0})
        annotation (Placement(transformation(extent={{0,20},{20,40}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation FixedTranslation1(
        r={0,-0.9,0},
        width=0.01,
        animation=false) annotation (Placement(transformation(
            origin={-60,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses force(
        L_a=0.3,
        L_b=0.3,
        m_a=1,
        m_b=1) annotation (Placement(transformation(extent={{-20,-20},{0,-40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation FixedTranslation2(
        width=0.01,
        animation=false,
        r={0,0.1,0}) annotation (Placement(transformation(
            origin={-60,50},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.Translational.Components.Damper damper(
                                                     d=10)
        annotation (Placement(transformation(extent={{-20,-80},{0,-60}},
              rotation=0)));
    equation
      connect(BodyBox1.frame_a, revolute.frame_b)
        annotation (Line(points={{0,30},{-20,30}}));
      connect(force.frame_a, FixedTranslation1.frame_b)
        annotation (Line(points={{-20,-30},{-60,-30},{-60,-20}}));
      connect(force.frame_b, BodyBox1.frame_b)
        annotation (Line(points={{0,-30},{40,-30},{40,30},{20,30}}));
      connect(world.frame_b, FixedTranslation2.frame_a)
        annotation (Line(points={{-80,30},{-60,30},{-60,40}}));
      connect(FixedTranslation2.frame_b, revolute.frame_a)
        annotation (Line(points={{-60,60},{-60,70},{-46,70},{-46,30},{-40,30}}));
      connect(world.frame_b, FixedTranslation1.frame_a)
        annotation (Line(points={{-80,30},{-60,30},{-60,0}}));
      connect(force.flange_a, damper.flange_a) annotation (Line(points={{-16,
              -41},{-16,-54},{-20,-54},{-20,-70}}, color={0,191,0}));
      connect(force.flange_b, damper.flange_b)
        annotation (Line(points={{-4,-41},{-4,-54},{0,-54},{0,-70}}, color={0,
              191,0}));
      annotation (experiment(StopTime=3), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics),
                  Diagram);
    end ForceWithTwoMasses;

    model FrameForces
      extends Modelica.Icons.Example;
      import Modelica.Mechanics.MultiBody.*;
      inner World world annotation (Placement(transformation(extent={{-100,80},
                {-80,100}}, rotation=0)));
      Joints.Revolute Revolute1 annotation (Placement(transformation(extent={{
                -40,40},{-20,60}}, rotation=0)));
      Parts.BodyCylinder BodyCylinder1(r={1,0,0})
        annotation (Placement(transformation(extent={{0,40},{20,60}}, rotation=
                0)));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,500,0})
        annotation (Placement(transformation(extent={{100,40},{80,60}},
              rotation=0)));
      Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-80,40},{-60,60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.WorldForce frameForce1(
                                    N_to_m=600, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b)
                                                annotation (Placement(
            transformation(extent={{60,40},{40,60}}, rotation=0)));
      Joints.Revolute Revolute2 annotation (Placement(transformation(extent={{
                -40,0},{-20,20}}, rotation=0)));
      Parts.BodyCylinder BodyCylinder2(r={1,0,0}) annotation (Placement(
            transformation(extent={{0,0},{20,20}}, rotation=0)));
      Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-80,0},{-60,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.WorldForce frameForce2(
                                    N_to_m=600, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve)
                                                annotation (Placement(
            transformation(extent={{60,0},{40,20}}, rotation=0)));
      Parts.FixedRotation FixedRotation1(n={0,0,1}, angle=45)
        annotation (Placement(transformation(extent={{-40,-40},{-20,-20}},
              rotation=0)));
    equation
      connect(BodyCylinder1.frame_a, Revolute1.frame_b)
        annotation (Line(points={{0,50},{-20,50}}));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-60,50},{-40,50}}));
      connect(frameForce1.frame_b, BodyCylinder1.frame_b)
        annotation (Line(points={{40,50},{20,50}}));
      connect(Constant1.y,frameForce1.force)
        annotation (Line(points={{79,50},{62,50}}, color={0,0,255}));
      connect(BodyCylinder2.frame_a, Revolute2.frame_b)
        annotation (Line(points={{0,10},{-20,10}}));
      connect(fixed2.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-60,10},{-40,10}}));
      connect(frameForce2.frame_b, BodyCylinder2.frame_b)
        annotation (Line(points={{40,10},{20,10}}));
      connect(fixed2.frame_b, FixedRotation1.frame_a)
        annotation (Line(points={{-60,10},{-52,10},{-52,-30},{-40,-30}}));
      connect(FixedRotation1.frame_b, frameForce2.frame_resolve)
        annotation (Line(points={{-20,-30},{50,-30},{50,0}}));
      connect(Constant1.y,frameForce2.force)
        annotation (Line(points={{79,50},{72,50},{72,10},{62,10}}, color={0,0,
              255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end FrameForces;

    model FrameForcesAndTorques
      extends Modelica.Icons.Example;
      import Modelica.Mechanics.MultiBody.*;
      inner World world annotation (Placement(transformation(extent={{-100,80},
                {-80,100}}, rotation=0)));
      Joints.Revolute Revolute1(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,60},{20,80}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Constant1[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(extent={{100,60},{80,80}},
              rotation=0)));
      Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-80,20},{-60,40}}, rotation=0)));
      Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}}, rotation=0)));
      Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-70},{-68,-50}}, rotation=0)));
      Parts.FixedRotation FixedRotation1(n={0,0,1}, angle=45)
        annotation (Placement(transformation(extent={{-8,-90},{12,-70}},
              rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.FrameForceAndTorque
        frameTorque1(                         Nm_to_m=120, N_to_m=600)
        annotation (Placement(transformation(extent={{60,60},{40,80}}, rotation=
               0)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.FrameForceAndTorque
        frameTorque2(                         Nm_to_m=120, N_to_m=600)
        annotation (Placement(transformation(extent={{60,-10},{40,-30}},
              rotation=0)));
      Joints.Revolute Revolute2(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[6](k={0,500,0,-100,100,0})
        annotation (Placement(transformation(extent={{100,-30},{80,-10}},
              rotation=0)));
      Joints.Revolute Revolute3 annotation (Placement(transformation(extent={{
                -52,20},{-32,40}}, rotation=0)));
      Joints.Revolute Revolute4 annotation (Placement(transformation(extent={{
                -62,-70},{-42,-50}}, rotation=0)));
    equation
      connect(frameTorque1.frame_b, body1.frame_b)
        annotation (Line(points={{40,70},{20,70}}));
      connect(Constant1.y,frameTorque1.load)
        annotation (Line(points={{79,70},{62,70}}, color={0,0,255}));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-20,60},{-20,70},{0,70}}));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-20,-30},{-20,-20},{0,-20}}));
      connect(frameTorque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,-20},{20,-20}}));
      connect(Constant2.y,frameTorque2.load)
        annotation (Line(points={{79,-20},{62,-20}}, color={0,0,255}));
      connect(Revolute3.frame_a, fixed1.frame_b)
        annotation (Line(points={{-52,30},{-60,30}}));
      connect(Revolute3.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-32,30},{-20,30},{-20,40}}));
      connect(FixedRotation1.frame_b, frameTorque2.frame_resolve)
        annotation (Line(points={{12,-80},{50,-80},{50,-30}}));
      connect(fixed2.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-68,-60},{-62,-60}}));
      connect(Revolute4.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-42,-60},{-20,-60},{-20,-50}}));
      connect(fixed2.frame_b, FixedRotation1.frame_a)
        annotation (Line(points={{-68,-60},{-64,-60},{-64,-80},{-8,-80}}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end FrameForcesAndTorques;

    model FrameTorques
      import Modelica.Mechanics.MultiBody.*;
      extends Modelica.Icons.Example;
      inner World world annotation (Placement(transformation(extent={{-100,80},
                {-80,100}}, rotation=0)));
      Joints.Revolute Revolute1(n={0,1,0})
        annotation (Placement(transformation(
            origin={-30,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,80},{20,100}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,100,0})
        annotation (Placement(transformation(extent={{100,80},{80,100}},
              rotation=0)));
      Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-80,20},{-60,40}}, rotation=0)));
      Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,0},{20,20}}, rotation=0)));
      Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-80,-40},{-60,-20}}, rotation=0)));
      Parts.FixedRotation FixedRotation1(n={0,0,1}, angle=45)
        annotation (Placement(transformation(extent={{0,-60},{20,-40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.WorldTorque frameTorque1(
                                      Nm_to_m=120, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b)
        annotation (Placement(transformation(extent={{60,80},{40,100}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.WorldTorque frameTorque2(
                                      Nm_to_m=120, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve)
        annotation (Placement(transformation(extent={{60,20},{40,0}}, rotation=
                0)));
      Joints.Revolute Revolute2(n={0,1,0})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={0,100,0})
        annotation (Placement(transformation(extent={{100,0},{80,20}}, rotation=
               0)));
    equation
      connect(fixed2.frame_b, FixedRotation1.frame_a)
        annotation (Line(points={{-60,-30},{-52,-30},{-52,-50},{0,-50}}));
      connect(frameTorque1.frame_b, body1.frame_b)
        annotation (Line(points={{40,90},{20,90}}));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-60,30},{-30,30},{-30,40}}));
      connect(Revolute1.frame_b, body1.frame_a)
        annotation (Line(points={{-30,60},{-30,90},{0,90}}));
      connect(fixed2.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-60,-30},{-30,-30},{-30,-20}}));
      connect(Revolute2.frame_b, body2.frame_a)
        annotation (Line(points={{-30,0},{-30,10},{0,10}}));
      connect(frameTorque2.frame_b, body2.frame_b)
        annotation (Line(points={{40,10},{20,10}}));
      connect(FixedRotation1.frame_b, frameTorque2.frame_resolve)
        annotation (Line(points={{20,-50},{50,-50},{50,0}}));
      connect(Constant1.y, frameTorque1.torque) annotation (Line(
          points={{79,90},{62,90}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Constant2.y, frameTorque2.torque) annotation (Line(
          points={{79,10},{62,10}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end FrameTorques;

    model LineForceWithTwoMasses
      "Example to demonstrate how to construct force elements with masses"
      import SI = Modelica.SIunits;

      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Mass m=1 "Mass of point masses";
      SI.Force rod_f_diff[3]=rod1.frame_b.f - rod3.frame_b.f
        "Difference of cut-forces in rod1 and rod3";
      SI.Force body_f_diff[3]=bodyBox1.frame_b.f - bodyBox2.frame_b.f
        "Difference of cut-forces in bodyBox1 and bodyBox2";
      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-80,60},{-60,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute1
                                          annotation (Placement(transformation(
              extent={{-20,60},{0,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox1(
                                       r={0.7,0,0})
        annotation (Placement(transformation(extent={{20,60},{40,80}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod1(
        r={0,-0.9,0},
        width=0.01,
        animation=false) annotation (Placement(transformation(
            origin={-40,54},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS jointUPS(
                                                    nAxis_ia={0.7,1.2,0}, animation=
           true) annotation (Placement(transformation(extent={{0,50},{20,30}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body body1(
        r_CM=0.2*jointUPS.eAxis_ia,
        cylinderDiameter=0.05,
        animation=true,
        m=m,
        I_11=0,
        I_22=0,
        I_33=0) annotation (Placement(transformation(extent={{-14,14},{-34,34}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body body2(
        r_CM=-0.2*jointUPS.eAxis_ia,
        cylinderDiameter=0.05,
        animation=true,
        m=m,
        I_11=0,
        I_22=0,
        I_33=0) annotation (Placement(transformation(extent={{32,14},{52,34}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(
        r={0,0.3,0},
        width=0.01,
        animation=false) annotation (Placement(transformation(
            origin={-40,84},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.Translational.Components.Damper damper1(
                                                      d=3)
        annotation (Placement(transformation(extent={{0,24},{20,4}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute2
                                          annotation (Placement(transformation(
              extent={{-20,-40},{0,-20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox2(
                                       r={0.7,0,0})
        annotation (Placement(transformation(extent={{20,-40},{40,-20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod3(
        width=0.01,
        r={0,-0.9,0.3},
        animation=false) annotation (Placement(transformation(
            origin={-40,-46},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod4(
        width=0.01,
        r={0,0.3,0.3},
        animation=false) annotation (Placement(transformation(
            origin={-40,-16},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.Translational.Components.Damper damper2(
                                                      d=3)
        annotation (Placement(transformation(extent={{0,-76},{20,-96}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses
        lineForceWithTwoMasses(
        L_a=0.2,
        L_b=0.2,
        cylinderLength_a=0.2,
        cylinderLength_b=1.2,
        massDiameterFaction=2.2,
        m_a=m,
        m_b=m) annotation (Placement(transformation(extent={{0,-50},{20,-70}},
              rotation=0)));
    equation
      connect(jointUPS.bearing, damper1.flange_a)
        annotation (Line(points={{6,30},{6,20},{0,20},{0,14}}, color={0,191,0}));
      connect(jointUPS.axis, damper1.flange_b)
        annotation (Line(points={{14,30},{14,20},{20,20},{20,14}}, color={0,191,
              0}));
      connect(jointUPS.frame_ib, body2.frame_a)
        annotation (Line(
          points={{18,30},{18,24},{32,24}},
          color={0,0,0},
          thickness=0.5));
      connect(world.frame_b, rod2.frame_a) annotation (Line(
          points={{-60,70},{-40,70},{-40,74}},
          color={0,0,0},
          thickness=0.5));
      connect(world.frame_b, rod1.frame_a) annotation (Line(
          points={{-60,70},{-40,70},{-40,64}},
          color={0,0,0},
          thickness=0.5));
      connect(rod2.frame_b, revolute1.frame_a) annotation (Line(
          points={{-40,94},{-40,98},{-28,98},{-28,70},{-20,70}},
          color={0,0,0},
          thickness=0.5));
      connect(revolute1.frame_b, bodyBox1.frame_a)
        annotation (Line(
          points={{0,70},{20,70}},
          color={0,0,0},
          thickness=0.5));
      connect(bodyBox1.frame_b, jointUPS.frame_b) annotation (Line(
          points={{40,70},{46,70},{46,40},{20,40}},
          color={0,0,0},
          thickness=0.5));
      connect(body1.frame_a, jointUPS.frame_ia)
        annotation (Line(
          points={{-14,24},{2,24},{2,30}},
          color={0,0,0},
          thickness=0.5));
      connect(rod1.frame_b, jointUPS.frame_a) annotation (Line(
          points={{-40,44},{-40,40},{0,40}},
          color={0,0,0},
          thickness=0.5));
      connect(rod4.frame_b, revolute2.frame_a) annotation (Line(
          points={{-40,-6},{-40,-2},{-28,-2},{-28,-30},{-20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(revolute2.frame_b, bodyBox2.frame_a)
        annotation (Line(
          points={{0,-30},{20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(world.frame_b, rod4.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-32},{-40,-32},{-40,-26}},
          color={0,0,0},
          thickness=0.5));
      connect(rod3.frame_a, rod4.frame_a)
        annotation (Line(
          points={{-40,-36},{-40,-26}},
          color={0,0,0},
          thickness=0.5));
      connect(lineForceWithTwoMasses.frame_a, rod3.frame_b) annotation (Line(
          points={{0,-60},{-40,-60},{-40,-56}},
          color={0,0,0},
          thickness=0.5));
      connect(lineForceWithTwoMasses.frame_b, bodyBox2.frame_b) annotation (Line(
          points={{20,-60},{54,-60},{54,-30},{40,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(lineForceWithTwoMasses.flange_b, damper2.flange_b)
        annotation (Line(points={{16,-71},{20,-71},{20,-86}}, color={0,191,0}));
      connect(lineForceWithTwoMasses.flange_a, damper2.flange_a)
        annotation (Line(points={{4,-71},{0,-71},{0,-86}}, color={0,191,0}));
      annotation (
        experiment(StopTime=3),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Documentation(info="<html>
<p>
With this example it is demonstrated how to use the Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS
joint to build up a force element with masses and inertias (note, Modelica.Mechanics.MultiBody.Forces.LineForceWithMass
is a default line force element with a point mass to approximate the mass properties of the
component):
</p>

<IMG src=\"modelica://ModelicaTest/Images/Examples/Elementary/ForceWithMasses.png\"
ALT=\"model Examples.Elementary.ForceWithMasses\">

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
</html>"),        Diagram);
    end LineForceWithTwoMasses;

    model Torque
      extends Modelica.Icons.Example;
      import Modelica.Mechanics.MultiBody.*;
      inner World world annotation (Placement(transformation(extent={{-80,60},{
                -60,80}}, rotation=0)));
      Joints.Revolute Revolute1(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,40},{20,60}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Constant1[3](k={-100,100,0})
        annotation (Placement(transformation(
            origin={50,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,0},{-70,20}}, rotation=0)));
      Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}}, rotation=0)));
      Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-70},{-68,-50}}, rotation=0)));
      Parts.FixedRotation fixedRotation(n={0,0,1}, angle=45)
        annotation (Placement(transformation(extent={{-8,-90},{12,-70}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Torque torque1(
                            Nm_to_m=120, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
                                         annotation (Placement(transformation(
              extent={{62,40},{42,60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Torque torque2(
                            Nm_to_m=120, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
                                         annotation (Placement(transformation(
              extent={{60,-10},{40,-30}}, rotation=0)));
      Joints.Revolute Revolute2(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={-100,100,0})
        annotation (Placement(transformation(
            origin={70,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Joints.Revolute Revolute3 annotation (Placement(transformation(extent={{
                -52,0},{-32,20}}, rotation=0)));
      Joints.Revolute Revolute4 annotation (Placement(transformation(extent={{
                -62,-70},{-42,-50}}, rotation=0)));
      Parts.Fixed fixed2(animation=false, r={1.5,0.25,0})
        annotation (Placement(transformation(extent={{100,40},{80,60}},
              rotation=0)));
      Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0})
        annotation (Placement(transformation(extent={{100,-30},{80,-10}},
              rotation=0)));
    equation
      connect(torque1.frame_b, body1.frame_b) annotation (Line(points={{42,50},
              {20,50}}));
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
      connect(Constant1.y,torque1.torque)
        annotation (Line(points={{50,79},{50,72},{58,72},{58,62}}, color={0,0,
              255}));
      connect(Constant2.y,torque2.torque)
        annotation (Line(points={{70,-59},{70,-42},{56,-42},{56,-32}}, color={0,
              0,255}));
      connect(torque1.frame_a, fixed2.frame_b)
        annotation (Line(
          points={{62,50},{80,50}},
          color={0,0,0},
          thickness=0.5));
      connect(fixed4.frame_b, torque2.frame_a)
        annotation (Line(
          points={{80,-20},{60,-20}},
          color={0,0,0},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
                  experiment(StopTime=1.1));
    end Torque;

    model Torque2
      extends Modelica.Icons.Example;
      import Modelica.Mechanics.MultiBody.*;
      inner World world annotation (Placement(transformation(extent={{-80,60},{
                -60,80}}, rotation=0)));
      Joints.Revolute Revolute1(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Parts.BodyCylinder body1(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,40},{20,60}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Constant1[3](k={-100,100,0})
        annotation (Placement(transformation(
            origin={50,90},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,0},{-70,20}}, rotation=0)));
      Parts.BodyCylinder body2(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-30},{20,-10}}, rotation=0)));
      Parts.Fixed fixed3(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-70},{-68,-50}}, rotation=0)));
      Parts.FixedRotation fixedRotation(n={0,0,1}, angle=45)
        annotation (Placement(transformation(extent={{-8,-90},{12,-70}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Torque torque1(
                            Nm_to_m=120, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
                                         annotation (Placement(transformation(
              extent={{62,40},{42,60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Torque torque2(
                            Nm_to_m=120, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
                                         annotation (Placement(transformation(
              extent={{60,-10},{40,-30}}, rotation=0)));
      Joints.Revolute Revolute2(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={-100,100,0})
        annotation (Placement(transformation(
            origin={70,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Joints.Revolute Revolute3 annotation (Placement(transformation(extent={{
                -52,0},{-32,20}}, rotation=0)));
      Joints.Revolute Revolute4 annotation (Placement(transformation(extent={{
                -62,-70},{-42,-50}}, rotation=0)));
      Parts.Fixed fixed2(animation=false, r={1.5,0.25,0})
        annotation (Placement(transformation(extent={{100,40},{80,60}},
              rotation=0)));
      Parts.Fixed fixed4(animation=false, r={1.5,-0.25,0})
        annotation (Placement(transformation(extent={{100,-30},{80,-10}},
              rotation=0)));
      Joints.Revolute Revolute5(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,-160},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Parts.BodyCylinder body3(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-150},{20,-130}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Constant3[6](k={0,0,0,-100,100,0})
        annotation (Placement(transformation(
            origin={50,-100},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Parts.Fixed fixed5(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-90,-190},{-70,-170}}, rotation=0)));
      Parts.BodyCylinder body4(r={1,0,0}) annotation (Placement(transformation(
              extent={{0,-220},{20,-200}}, rotation=0)));
      Parts.Fixed fixed6(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-88,-260},{-68,-240}}, rotation=0)));
      Parts.FixedRotation fixedRotation1(n={0,0,1}, angle=45)
        annotation (Placement(transformation(extent={{-8,-280},{12,-260}},
              rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.ForceAndTorque torque3(
                                    Nm_to_m=120)
        annotation (Placement(transformation(extent={{62,-150},{42,-130}},
              rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.ForceAndTorque torque4(
                                    Nm_to_m=120)
        annotation (Placement(transformation(extent={{60,-200},{40,-220}},
              rotation=0)));
      Joints.Revolute Revolute6(n={0,1,0})
        annotation (Placement(transformation(
            origin={-20,-230},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant Constant4[6](k={0,0,0,-100,100,0})
        annotation (Placement(transformation(
            origin={70,-260},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Joints.Revolute Revolute7 annotation (Placement(transformation(extent={{
                -52,-190},{-32,-170}}, rotation=0)));
      Joints.Revolute Revolute8 annotation (Placement(transformation(extent={{
                -62,-260},{-42,-240}}, rotation=0)));
      Parts.Fixed fixed7(animation=false, r={1.5,0.25,0})
        annotation (Placement(transformation(extent={{100,-150},{80,-130}},
              rotation=0)));
      Parts.Fixed fixed8(animation=false, r={1.5,-0.25,0})
        annotation (Placement(transformation(extent={{100,-220},{80,-200}},
              rotation=0)));
    equation
      connect(torque1.frame_b, body1.frame_b) annotation (Line(points={{42,50},
              {20,50}}));
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
      connect(Constant1.y,torque1.torque)
        annotation (Line(points={{50,79},{50,72},{58,72},{58,62}}, color={0,0,
              255}));
      connect(Constant2.y,torque2.torque)
        annotation (Line(points={{70,-59},{70,-42},{56,-42},{56,-32}}, color={0,
              0,255}));
      connect(torque1.frame_a, fixed2.frame_b)
        annotation (Line(
          points={{62,50},{80,50}},
          color={0,0,0},
          thickness=0.5));
      connect(fixed4.frame_b, torque2.frame_a)
        annotation (Line(
          points={{80,-20},{60,-20}},
          color={0,0,0},
          thickness=0.5));
      connect(torque3.frame_b, body3.frame_b)
        annotation (Line(points={{42,-140},{20,-140}}));
      connect(Revolute5.frame_b, body3.frame_a)
        annotation (Line(points={{-20,-150},{-20,-140},{0,-140}}));
      connect(Revolute6.frame_b, body4.frame_a)
        annotation (Line(points={{-20,-220},{-20,-210},{0,-210}}));
      connect(torque4.frame_b, body4.frame_b)
        annotation (Line(points={{40,-210},{20,-210}}));
      connect(Revolute7.frame_a, fixed5.frame_b)
        annotation (Line(points={{-52,-180},{-70,-180}}));
      connect(Revolute7.frame_b, Revolute5.frame_a)
        annotation (Line(points={{-32,-180},{-20,-180},{-20,-170}}));
      connect(fixedRotation1.frame_b, torque4.frame_resolve)
        annotation (Line(points={{12,-270},{46,-270},{46,-220}}));
      connect(fixed6.frame_b, Revolute8.frame_a)
        annotation (Line(points={{-68,-250},{-62,-250}}));
      connect(Revolute8.frame_b, Revolute6.frame_a)
        annotation (Line(points={{-42,-250},{-20,-250},{-20,-240}}));
      connect(fixed6.frame_b, fixedRotation1.frame_a)
        annotation (Line(points={{-68,-250},{-64,-250},{-64,-270},{-8,-270}}));
      connect(Constant3.y,torque3.load)          annotation (Line(points={{50,
              -111},{50,-118},{58,-118},{58,-128}}, color={0,0,255}));
      connect(Constant4.y,torque4.load)          annotation (Line(points={{70,
              -249},{70,-232},{56,-232},{56,-222}}, color={0,0,255}));
      connect(torque3.frame_a, fixed7.frame_b)
        annotation (Line(
          points={{62,-140},{80,-140}},
          color={0,0,0},
          thickness=0.5));
      connect(fixed8.frame_b, torque4.frame_a)
        annotation (Line(
          points={{80,-210},{60,-210}},
          color={0,0,0},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-300},{100,100}},
            grid={1,1}), graphics),
                  experiment(StopTime=1.1));
    end Torque2;

    model WorldForces
      extends Modelica.Icons.Example;
      import Modelica.Mechanics.MultiBody.*;
      inner World world annotation (Placement(transformation(extent={{-100,20},
                {-80,40}}, rotation=0)));
      Joints.Revolute Revolute1 annotation (Placement(transformation(extent={{
                -40,60},{-20,80}}, rotation=0)));
      Parts.BodyCylinder BodyCylinder1(r={1,0,0})
        annotation (Placement(transformation(extent={{0,60},{20,80}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Forces.WorldForce worldForce(
                                   N_to_m=600) annotation (Placement(
            transformation(extent={{60,60},{40,80}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Constant1[3](k={0,500,0})
        annotation (Placement(transformation(extent={{100,60},{80,80}},
              rotation=0)));
      Parts.Fixed fixed2(r={0,-0.5,0}) annotation (Placement(transformation(
              extent={{-80,-20},{-60,0}}, rotation=0)));
      Joints.Revolute Revolute2(n={0,1,0})
        annotation (Placement(transformation(
            origin={-30,10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Parts.BodyCylinder BodyCylinder2(r={1,0,0})
        annotation (Placement(transformation(extent={{0,20},{20,40}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Forces.WorldTorque worldTorque1(
                                      Nm_to_m=200)
        annotation (Placement(transformation(extent={{60,20},{40,40}}, rotation=
               0)));
      Modelica.Blocks.Sources.Constant Constant2[3](k={100,100,100})
        annotation (Placement(transformation(extent={{100,20},{80,40}},
              rotation=0)));
      Parts.Fixed fixed1(r={0,0.5,0}) annotation (Placement(transformation(
              extent={{-80,60},{-60,80}}, rotation=0)));
      Joints.Revolute Revolute3 annotation (Placement(transformation(extent={{
                -50,-100},{-30,-80}}, rotation=0)));
      Parts.BodyCylinder BodyCylinder3(r={1,0,0})
        annotation (Placement(transformation(extent={{0,-60},{20,-40}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant Constant4[6](k={0,500,0,100,100,100})
        annotation (Placement(transformation(extent={{100,-60},{80,-40}},
              rotation=0)));
      Parts.Fixed fixed3(r={0,-1,0}) annotation (Placement(transformation(
              extent={{-80,-100},{-60,-80}}, rotation=0)));
      Joints.Revolute Revolute4(n={0,1,0})
        annotation (Placement(transformation(
            origin={-10,-70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.WorldForceAndTorque
        ForceTorque(                         N_to_m=600, Nm_to_m=200)
        annotation (Placement(transformation(extent={{60,-60},{40,-40}},
              rotation=0)));
    equation
      connect(BodyCylinder1.frame_a, Revolute1.frame_b)
        annotation (Line(points={{0,70},{-20,70}}));
      connect(worldForce.frame_b, BodyCylinder1.frame_b)
        annotation (Line(points={{40,70},{20,70}}));
      connect(fixed2.frame_b, Revolute2.frame_a)
        annotation (Line(points={{-60,-10},{-30,-10},{-30,0}}));
      connect(BodyCylinder2.frame_a, Revolute2.frame_b)
        annotation (Line(points={{0,30},{-30,30},{-30,20}}));
      connect(worldTorque1.frame_b, BodyCylinder2.frame_b)
        annotation (Line(points={{40,30},{20,30}}));
      connect(fixed1.frame_b, Revolute1.frame_a)
        annotation (Line(points={{-60,70},{-40,70}}));
      connect(fixed3.frame_b, Revolute3.frame_a)
        annotation (Line(points={{-60,-90},{-50,-90}}));
      connect(Revolute3.frame_b, Revolute4.frame_a)
        annotation (Line(points={{-30,-90},{-10,-90},{-10,-80}}));
      connect(ForceTorque.frame_b, BodyCylinder3.frame_b)
        annotation (Line(points={{40,-50},{20,-50}}));
      connect(Revolute4.frame_b, BodyCylinder3.frame_a)
        annotation (Line(points={{-10,-60},{-10,-50},{0,-50}}));
      connect(Constant4.y, ForceTorque.load) annotation (Line(
          points={{79,-50},{62,-50}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Constant1.y, worldForce.force) annotation (Line(
          points={{79,70},{62,70}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Constant2.y, worldTorque1.torque) annotation (Line(
          points={{79,30},{62,30}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end WorldForces;
  end Forces;

  package Joints "Test MultiBody.Joints"
  extends Modelica.Icons.ExamplesPackage;
    model Revolute

      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow axis(
        length=0.5,
        color={0,0,0},
        diameter=0.02,
        n={0,0,1}) annotation (Placement(transformation(extent={{10,60},{30,80}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute(
        n={0,0,1},
        cylinderDiameter=1/15,
        a(fixed=false),
        phi(fixed=true, start=0.7853981633974483),
        w(fixed=true))         annotation (Placement(transformation(extent={{
                -22,20},{-2,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body body(
                                animation=false)
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a(
                                               color_x={0,128,255})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a1(
                                                color_x={0,0,200})
        annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, revolute.frame_a)
        annotation (Line(
          points={{-40,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(revolute.frame_b, body.frame_a)
        annotation (Line(
          points={{-2,30},{20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(revolute.frame_b, axis.frame_a) annotation (Line(
          points={{-2,30},{4,30},{4,70},{10,70}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a.frame_a, revolute.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a1.frame_a, revolute.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          color={0,0,0},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end Revolute;

    model RevoluteInitialization

      inner Modelica.Mechanics.MultiBody.World world(
                                  gravityType=Modelica.Mechanics.MultiBody.Types.
            GravityTypes.UniformGravity)
                            annotation (Placement(transformation(extent={{-80,0},
                {-60,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute rev(
                                            n={0,0,1},
        useAxisFlange=true,
        a(fixed=true),
        phi(fixed=true),
        w(fixed=true))                annotation (Placement(transformation(
              extent={{-40,0},{-20,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Damper damper(
                                                  d=0.1)
        annotation (Placement(transformation(extent={{-40,40},{-20,60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape body(
        r={1,0,0},
        r_CM={0.5,0,0},
        m=1) annotation (Placement(transformation(extent={{0,0},{20,20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed(
                                  r={1,0.2,0}, width=0.02)
        annotation (Placement(transformation(
            origin={50,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Forces.Spring spring(
                                     s_unstretched=0.1, c(fixed=false) = 100)
        annotation (Placement(transformation(
            origin={50,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));

    equation
      connect(world.frame_b, rev.frame_a)
        annotation (Line(
          points={{-60,10},{-40,10}},
          color={0,0,0},
          thickness=0.5));
      connect(damper.flange_b, rev.axis) annotation (Line(points={{-20,50},{-16,
              50},{-16,26},{-30,26},{-30,20}}, color={0,0,0}));
      connect(rev.support, damper.flange_a) annotation (Line(points={{-36,20},{
              -36,26},{-48,26},{-48,50},{-40,50}}, color={0,0,0}));
      connect(rev.frame_b, body.frame_a)
        annotation (Line(
          points={{-20,10},{0,10}},
          color={0,0,0},
          thickness=0.5));
      connect(fixed.frame_b, spring.frame_a)
        annotation (Line(
          points={{50,60},{50,40}},
          color={0,0,0},
          thickness=0.5));
      connect(body.frame_b, spring.frame_b)
        annotation (Line(
          points={{20,10},{50,10},{50,20}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1),
                  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics));
    end RevoluteInitialization;

    model Prismatic

      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow axis(
        length=0.5,
        color={0,0,0},
        diameter=0.02,
        n={1,1,0}) annotation (Placement(transformation(extent={{10,60},{30,80}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(
        n={1,1,0},
        a(fixed=false),
        s(fixed=true, start=0.3),
        v(fixed=true))
                   annotation (Placement(transformation(extent={{-20,20},{0,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body body(
                                animation=false)
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a(
                                               color_x={0,128,255})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a1(
                                                color_x={0,0,200})
        annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, prismatic.frame_a)
        annotation (Line(
          points={{-40,30},{-20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(prismatic.frame_b, body.frame_a)
        annotation (Line(
          points={{0,30},{20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(prismatic.frame_b, axis.frame_a) annotation (Line(
          points={{0,30},{4,30},{4,70},{10,70}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a.frame_a, prismatic.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a1.frame_a, prismatic.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{0,30}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Prismatic;

    model Cylindrical

      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow axis(
        length=0.5,
        color={0,0,0},
        diameter=0.02,
        n={0,0,1}) annotation (Placement(transformation(extent={{10,60},{30,80}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Cylindrical cylindrical(
        n={0,0,1},
        cylinderDiameter=1/15,
        a(fixed=false),
        phi(fixed=true, start=0.7853981633974483),
        s(fixed=true, start=0.3),
        v(fixed=true),
        w(fixed=true),
        wd(fixed=false))
                     annotation (Placement(transformation(extent={{-22,20},{-2,
                40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body body(
                                animation=false)
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a(
                                               color_x={0,128,255})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a1(
                                                color_x={0,0,200})
        annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, cylindrical.frame_a)
        annotation (Line(
          points={{-40,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(cylindrical.frame_b, body.frame_a)
        annotation (Line(
          points={{-2,30},{20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(cylindrical.frame_b, axis.frame_a) annotation (Line(
          points={{-2,30},{4,30},{4,70},{10,70}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a.frame_a, cylindrical.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a1.frame_a, cylindrical.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          color={0,0,0},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end Cylindrical;

    model Universal

      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow axis2(
        length=0.5,
        color={0,0,0},
        diameter=0.02,
        n={0,1,0},
        animation=false) annotation (Placement(transformation(extent={{10,60},{
                30,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Universal universal(
        n_a={0,0,1},
        cylinderDiameter=1/15,
        cylinderLength=0.2,
        a_a(fixed=false),
        a_b(fixed=false),
        phi_a(fixed=true, start=1.570796326794897),
        phi_b(fixed=true, start=0.7853981633974483),
        w_a(fixed=true),
        w_b(fixed=true))    annotation (Placement(transformation(extent={{-24,
                20},{-4,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body body(
                                animation=false)
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a(
                                               color_x={0,128,255})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a1(
                                                color_x={0,0,200})
        annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow axis1(
        length=0.5,
        color={0,0,0},
        diameter=0.02,
        n={0,0,1},
        animation=false) annotation (Placement(transformation(extent={{-34,60},
                {-14,80}}, rotation=0)));
    equation
      connect(world.frame_b, universal.frame_a)
        annotation (Line(
          points={{-40,30},{-24,30}},
          color={0,0,0},
          thickness=0.5));
      connect(universal.frame_b, body.frame_a)
        annotation (Line(
          points={{-4,30},{20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(universal.frame_b, axis2.frame_a) annotation (Line(
          points={{-4,30},{4,30},{4,70},{10,70}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a.frame_a, universal.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-24,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a1.frame_a, universal.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-4,30}},
          color={0,0,0},
          thickness=0.5));
      connect(universal.frame_a, axis1.frame_a) annotation (Line(
          points={{-24,30},{-24,30},{-24,56},{-48,56},{-48,70},{-34,70}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Universal;

    model Planar

      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow axis2(
        length=0.5,
        color={0,0,0},
        diameter=0.02,
        n={0,1,0}) annotation (Placement(transformation(extent={{10,60},{30,80}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Planar planar(
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
        wd(fixed=false))
        annotation (Placement(transformation(extent={{-22,20},{-2,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body body(
                                animation=false)
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a(
                                               color_x={0,128,255})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a1(
                                                color_x={0,0,200})
        annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow axis1(
        length=0.5,
        color={0,0,0},
        diameter=0.02,
        n={0,0,1},
        r_tail={0,0,0.5}) annotation (Placement(transformation(extent={{-34,60},
                {-14,80}}, rotation=0)));
    equation
      connect(world.frame_b, planar.frame_a)
        annotation (Line(
          points={{-40,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(planar.frame_b, body.frame_a)
        annotation (Line(
          points={{-2,30},{20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(planar.frame_b, axis2.frame_a) annotation (Line(
          points={{-2,30},{4,30},{4,70},{10,70}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a.frame_a, planar.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a1.frame_a, planar.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          color={0,0,0},
          thickness=0.5));
      connect(planar.frame_a, axis1.frame_a) annotation (Line(
          points={{-22,30},{-24,30},{-24,56},{-48,56},{-48,70},{-34,70}},
          color={0,0,0},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end Planar;

    model Spherical

      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Spherical spherical(
        angles_start={0.7853981633974483,0.7853981633974483,0.7853981633974483},
        angles_fixed=true,
        w_rel_a_fixed=true,
        z_rel_a_fixed=false)
        annotation (Placement(transformation(extent={{-22,20},{-2,40}},
              rotation=0)));

      Modelica.Mechanics.MultiBody.Parts.Body body(
                                animation=false)
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a(
                                               color_x={0,128,255})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a1(
                                                color_x={0,0,200})
        annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, spherical.frame_a)
        annotation (Line(
          points={{-40,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(spherical.frame_b, body.frame_a)
        annotation (Line(
          points={{-2,30},{20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a.frame_a, spherical.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a1.frame_a, spherical.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end Spherical;

    model FreeMotion

      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.FreeMotion freeMotion(
        angles_start={0.7853981633974483,0.7853981633974483,0.7853981633974483},
        a_rel_a(fixed=false),
        angles_fixed=true,
        r_rel_a(fixed=true, start={0.5,0.4,0}),
        v_rel_a(fixed=true),
        w_rel_a_fixed=true,
        z_rel_a_fixed=false)       annotation (Placement(transformation(extent=
                {{-22,20},{-2,40}}, rotation=0)));

      Modelica.Mechanics.MultiBody.Parts.Body body(
                                animation=false,
        r_CM={0,0,0},
        m=1)
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a(
                                               color_x={0,128,255})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a1(
                                                color_x={0,0,200})
        annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, freeMotion.frame_a)
        annotation (Line(
          points={{-40,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(freeMotion.frame_b, body.frame_a)
        annotation (Line(
          points={{-2,30},{20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a.frame_a, freeMotion.frame_a) annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a1.frame_a, freeMotion.frame_b) annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          color={0,0,0},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end FreeMotion;

    model FreeMotionScalarInit

      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit
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
        angle_d_3_stateSelect=StateSelect.always)
                                  annotation (Placement(transformation(extent=
                {{-22,20},{-2,40}}, rotation=0)));

      Modelica.Mechanics.MultiBody.Parts.Body body(
                                animation=false,
        r_CM={0,0,0},
        m=1)
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a(
                                               color_x={0,128,255})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a1(
                                                color_x={0,0,200})
        annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, freeMotionScalarInit.frame_a)
        annotation (Line(
          points={{-40,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(freeMotionScalarInit.frame_b, body.frame_a)
        annotation (Line(
          points={{-2,30},{20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a.frame_a, freeMotionScalarInit.frame_a)
                                                   annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a1.frame_a, freeMotionScalarInit.frame_b)
                                                    annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          color={0,0,0},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end FreeMotionScalarInit;

    model FreeMotionScalarInit2

      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit
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
        angle_3(start=0.78539816339745, fixed=true))
                                  annotation (Placement(transformation(extent=
                {{-22,20},{-2,40}}, rotation=0)));

      Modelica.Mechanics.MultiBody.Parts.Body body(
                                animation=false,
        r_CM={0,0,0},
        m=1)
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a(
                                               color_x={0,128,255})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a1(
                                                color_x={0,0,200})
        annotation (Placement(transformation(
            origin={10,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, freeMotionScalarInit.frame_a)
        annotation (Line(
          points={{-40,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(freeMotionScalarInit.frame_b, body.frame_a)
        annotation (Line(
          points={{-2,30},{20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a.frame_a, freeMotionScalarInit.frame_a)
                                                   annotation (Line(
          points={{-30,0},{-30,30},{-22,30}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a1.frame_a, freeMotionScalarInit.frame_b)
                                                    annotation (Line(
          points={{10,0},{12,0},{12,30},{-2,30}},
          color={0,0,0},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end FreeMotionScalarInit2;

    model SphericalSpherical

      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.SphericalSpherical sphericalSpherical(
                                                             rodLength={1,0.2,0}
            *{1,0.2,0}, m=1) annotation (Placement(transformation(extent={{-20,
                20},{0,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Prismatic Prismatic1(
                                            animation=false)
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed1(
                                   r={1,0.2,0}, animation=false)
        annotation (Placement(transformation(extent={{80,20},{60,40}}, rotation=
               0)));
    equation
      connect(world.frame_b, sphericalSpherical.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}, color={0,0,0}));
      connect(sphericalSpherical.frame_b, Prismatic1.frame_a)
        annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
      connect(Prismatic1.frame_b, Fixed1.frame_b)
        annotation (Line(points={{40,30},{60,30}}, color={0,0,0}));
      annotation (experiment(StopTime=1.1));
    end SphericalSpherical;

    model JointUSP
      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed1(
                                   animation=false, r={1.7,0.1,0})
        annotation (Placement(transformation(extent={{40,20},{20,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSP jointUSP(
                                                    rRod1_ia=rRod1_ia, rRod2_ib=
           rRod2_ib) annotation (Placement(transformation(extent={{-20,20},{0,
                40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow n1_a(
        length=0.5,
        color={0,0,200},
        n={0,0,1},
        diameter=d) annotation (Placement(transformation(extent={{-46,60},{-26,
                80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow n2_ia(
        length=0.5,
        n=jointUSP.e2_ia,
        diameter=d,
        color={0,128,0}) annotation (Placement(transformation(extent={{-20,60},
                {0,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod1(
        diameter=d,
        r_tail={0,-0.1,0},
        n=rRod1_ia,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod1_ia))
        annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod2(
        diameter=d,
        r_tail={0,-0.1,0},
        n=rRod2_ib,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod2_ib))
        annotation (Placement(transformation(extent={{40,-20},{20,0}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow prism(
        diameter=d,
        r_tail={0,-0.1,0},
        n={-1,0,0},
        color={255,0,0},
        length=0.2) annotation (Placement(transformation(extent={{0,-60},{-20,
                -40}}, rotation=0)));
    equation
      connect(world.frame_b, jointUSP.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}, color={0,0,0}));
      connect(jointUSP.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
      connect(jointUSP.frame_a, n1_a.frame_a) annotation (Line(points={{-20,30},
              {-32,30},{-32,54},{-50,54},{-50,70},{-46,70}}, color={0,0,0}));
      connect(n2_ia.frame_a, jointUSP.frame_ia) annotation (Line(points={{-20,
              70},{-24,70},{-24,46},{-18,46},{-18,40}}, color={0,0,0}));
      connect(jointUSP.frame_ia, rRod1.frame_a) annotation (Line(points={{-18,
              40},{-26,40},{-26,-10},{-20,-10}}, color={0,0,0}));
      connect(rRod2.frame_a, jointUSP.frame_ib) annotation (Line(points={{40,
              -10},{56,-10},{56,58},{-2,58},{-2,40}}, color={0,0,0}));
      connect(prism.frame_a, jointUSP.frame_b)
        annotation (Line(points={{0,-50},{10,-50},{10,30},{0,30}}, color={0,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end JointUSP;

    model JointUPS
      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed1(
                                   animation=false, r={1.7,0.1,0})
        annotation (Placement(transformation(extent={{40,20},{20,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS jointUPS(
                                                    nAxis_ia=rRod1_ia)
        annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow n1_a(
        length=0.5,
        color={0,0,200},
        n={0,0,1},
        diameter=d) annotation (Placement(transformation(extent={{-46,60},{-26,
                80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow n2_ia(
        length=0.5,
        n=jointUPS.e2_ia,
        diameter=d,
        color={0,128,0}) annotation (Placement(transformation(extent={{-20,60},
                {0,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod1(
        diameter=d,
        r_tail={0,-0.1,0},
        n=rRod1_ia,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod1_ia))
        annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=
               0)));
    equation
      connect(world.frame_b, jointUPS.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}, color={0,0,0}));
      connect(jointUPS.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
      connect(jointUPS.frame_a, n1_a.frame_a) annotation (Line(points={{-20,30},
              {-32,30},{-32,54},{-50,54},{-50,70},{-46,70}}, color={0,0,0}));
      connect(n2_ia.frame_a, jointUPS.frame_ia) annotation (Line(points={{-20,
              70},{-24,70},{-24,46},{-18,46},{-18,40}}, color={0,0,0}));
      connect(jointUPS.frame_ia, rRod1.frame_a) annotation (Line(points={{-18,
              40},{-26,40},{-26,-10},{-20,-10}}, color={0,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end JointUPS;

    model JointSSR
      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real L=Modelica.Math.Vectors.length(
                                               rRod1_ia);
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed1(
                                   animation=false, r={1.5,0.1,0})
        annotation (Placement(transformation(extent={{40,20},{20,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSR jointSSR(
        rRod2_ib=rRod2_ib,
        rod1Mass=1,
        rod1Length=L,
        revoluteDiameter=0.05) annotation (Placement(transformation(extent={{
                -20,20},{0,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod2(
        diameter=d,
        n=rRod2_ib,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod2_ib),
        r_tail={0.05,0.1,0}) annotation (Placement(transformation(extent={{40,
                -20},{20,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow prism(
        diameter=d,
        color={255,0,0},
        length=0.3,
        n={0,0,1}) annotation (Placement(transformation(extent={{0,-60},{-20,
                -40}}, rotation=0)));
    equation
      connect(world.frame_b, jointSSR.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}, color={0,0,0}));
      connect(jointSSR.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
      connect(rRod2.frame_a, jointSSR.frame_ib) annotation (Line(points={{40,
              -10},{56,-10},{56,58},{-2,58},{-2,40}}, color={0,0,0}));
      connect(prism.frame_a, jointSSR.frame_b)
        annotation (Line(points={{0,-50},{10,-50},{10,30},{0,30}}, color={0,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end JointSSR;

    model JointUSR
      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed1(
                                   animation=false, r={1.5,0.1,0})
        annotation (Placement(transformation(extent={{40,20},{20,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSR jointUSR(
                                                    rRod1_ia=rRod1_ia, rRod2_ib=
           rRod2_ib) annotation (Placement(transformation(extent={{-20,20},{0,
                40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow n1_a(
        length=0.5,
        color={0,0,200},
        n={0,0,1},
        diameter=d) annotation (Placement(transformation(extent={{-46,60},{-26,
                80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow n2_ia(
        length=0.5,
        n=jointUSR.e2_ia,
        diameter=d,
        color={0,128,0}) annotation (Placement(transformation(extent={{-20,60},
                {0,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod1(
        diameter=d,
        r_tail={0,-0.1,0},
        n=rRod1_ia,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod1_ia))
        annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod2(
        diameter=d,
        r_tail={0,-0.1,0},
        n=rRod2_ib,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod2_ib))
        annotation (Placement(transformation(extent={{40,-20},{20,0}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow prism(
        diameter=d,
        color={255,0,0},
        n={0,0,1},
        length=0.3) annotation (Placement(transformation(extent={{0,-60},{-20,
                -40}}, rotation=0)));
    equation
      connect(world.frame_b, jointUSR.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}, color={0,0,0}));
      connect(jointUSR.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
      connect(jointUSR.frame_a, n1_a.frame_a) annotation (Line(points={{-20,30},
              {-32,30},{-32,54},{-50,54},{-50,70},{-46,70}}, color={0,0,0}));
      connect(n2_ia.frame_a, jointUSR.frame_ia) annotation (Line(points={{-20,
              70},{-24,70},{-24,46},{-18,46},{-18,40}}, color={0,0,0}));
      connect(jointUSR.frame_ia, rRod1.frame_a) annotation (Line(points={{-18,
              40},{-26,40},{-26,-10},{-20,-10}}, color={0,0,0}));
      connect(rRod2.frame_a, jointUSR.frame_ib) annotation (Line(points={{40,
              -10},{56,-10},{56,58},{-2,58},{-2,40}}, color={0,0,0}));
      connect(prism.frame_a, jointUSR.frame_b)
        annotation (Line(points={{0,-50},{10,-50},{10,30},{0,30}}, color={0,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                  experiment(StopTime=1.1));
    end JointUSR;

    model JointRRR
      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed1(
                                   animation=false, r={1.5,0.1,0})
        annotation (Placement(transformation(extent={{40,20},{20,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR jointRRR(
                                                    rRod1_ia=rRod1_ia, rRod2_ib=
           rRod2_ib) annotation (Placement(transformation(extent={{-20,20},{0,
                40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow n1_a(
        n={0,0,1},
        diameter=d,
        length=0.4,
        color={255,0,0}) annotation (Placement(transformation(extent={{-46,60},
                {-26,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod1(
        diameter=d,
        r_tail={0,-0.1,0},
        n=rRod1_ia,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod1_ia))
        annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod2(
        diameter=d,
        r_tail={0,-0.1,0},
        n=rRod2_ib,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod2_ib))
        annotation (Placement(transformation(extent={{40,-20},{20,0}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow prism(
        diameter=d,
        n={0,0,1},
        length=0.4,
        color={255,0,0}) annotation (Placement(transformation(extent={{0,-60},{
                -20,-40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow n1_a1(
        n={0,0,1},
        diameter=d,
        length=0.4,
        color={255,0,0}) annotation (Placement(transformation(extent={{-10,66},
                {10,86}}, rotation=0)));
    equation
      connect(world.frame_b, jointRRR.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}, color={0,0,0}));
      connect(jointRRR.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
      connect(jointRRR.frame_a, n1_a.frame_a) annotation (Line(points={{-20,30},
              {-32,30},{-32,54},{-50,54},{-50,70},{-46,70}}, color={0,0,0}));
      connect(jointRRR.frame_ia, rRod1.frame_a) annotation (Line(points={{-18,
              40},{-26,40},{-26,-10},{-20,-10}}, color={0,0,0}));
      connect(rRod2.frame_a, jointRRR.frame_ib) annotation (Line(points={{40,
              -10},{56,-10},{56,58},{-2,58},{-2,40}}, color={0,0,0}));
      connect(prism.frame_a, jointRRR.frame_b)
        annotation (Line(points={{0,-50},{10,-50},{10,30},{0,30}}, color={0,0,0}));
      connect(n1_a1.frame_a, jointRRR.frame_im) annotation (Line(
          points={{-10,76},{-10,76},{-10,40}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end JointRRR;

    model JointRRP
      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real rRod2_ib[3]={-0.5,0.2,0};
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed1(
                                   animation=false, r={1.7,0.1,0})
        annotation (Placement(transformation(extent={{40,20},{20,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRP jointRRP(
                                                    rRod1_ia=rRod1_ia, rRod2_ib=
           rRod2_ib) annotation (Placement(transformation(extent={{-20,20},{0,
                40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow n1_a(
        n={0,0,1},
        diameter=d,
        length=0.4,
        color={255,0,0}) annotation (Placement(transformation(extent={{-46,60},
                {-26,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow n2_ia(
        diameter=d,
        n=jointRRP.e_im,
        length=0.4,
        color={255,0,0}) annotation (Placement(transformation(extent={{-20,60},
                {0,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod1(
        diameter=d,
        r_tail={0,-0.1,0},
        n=rRod1_ia,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod1_ia))
        annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod2(
        diameter=d,
        r_tail={0,-0.1,0},
        n=rRod2_ib,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod2_ib))
        annotation (Placement(transformation(extent={{40,-20},{20,0}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow prism(
        diameter=d,
        r_tail={0,-0.1,0},
        n={-1,0,0},
        color={255,0,0},
        length=0.4) annotation (Placement(transformation(extent={{0,-60},{-20,
                -40}}, rotation=0)));
    equation
      connect(world.frame_b, jointRRP.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}, color={0,0,0}));
      connect(jointRRP.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
      connect(jointRRP.frame_a, n1_a.frame_a) annotation (Line(points={{-20,30},
              {-32,30},{-32,54},{-50,54},{-50,70},{-46,70}}, color={0,0,0}));
      connect(jointRRP.frame_ia, rRod1.frame_a) annotation (Line(points={{-18,
              40},{-26,40},{-26,-10},{-20,-10}}, color={0,0,0}));
      connect(rRod2.frame_a, jointRRP.frame_ib) annotation (Line(points={{40,
              -10},{56,-10},{56,58},{-2,58},{-2,40}}, color={0,0,0}));
      connect(prism.frame_a, jointRRP.frame_b)
        annotation (Line(points={{0,-50},{10,-50},{10,30},{0,30}}, color={0,0,0}));
      connect(jointRRP.frame_im, n2_ia.frame_a) annotation (Line(
          points={{-10,40},{-10,55.5},{-20,55.5},{-20,70}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end JointRRP;

    model JointSSP
      parameter Real d=0.015;
      parameter Real rRod1_ia[3]={1,0.3,0};
      parameter Real L=Modelica.Math.Vectors.length(
                                               rRod1_ia);
      parameter Real rRod2_ib[3]={-0.52,0.2,0};
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed1(
                                   animation=false, r={1.5,0.1,0})
        annotation (Placement(transformation(extent={{40,20},{20,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSP jointSSP(
        rRod2_ib=rRod2_ib,
        rod1Mass=1,
        rod1Length=L,
        n_b={0,0,1},
        s_guess=-10) annotation (Placement(transformation(extent={{-20,20},{0,
                40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow rRod2(
        diameter=d,
        n=rRod2_ib,
        color={0,0,0},
        length=Modelica.Math.Vectors.length(
                                       rRod2_ib),
        r_tail={0.05,0.1,0}) annotation (Placement(transformation(extent={{40,
                -20},{20,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow prism(
        diameter=d,
        color={255,0,0},
        length=0.3,
        n={0,0,1}) annotation (Placement(transformation(extent={{0,-60},{-20,
                -40}}, rotation=0)));
    equation
      connect(world.frame_b, jointSSP.frame_a)
        annotation (Line(points={{-40,30},{-20,30}}, color={0,0,0}));
      connect(jointSSP.frame_b, Fixed1.frame_b)
        annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
      connect(rRod2.frame_a, jointSSP.frame_ib) annotation (Line(points={{40,
              -10},{56,-10},{56,58},{-2,58},{-2,40}}, color={0,0,0}));
      connect(prism.frame_a, jointSSP.frame_b)
        annotation (Line(points={{0,-50},{10,-50},{10,30},{0,30}}, color={0,0,0}));
      annotation (experiment(StopTime=1.1));
    end JointSSP;

  end Joints;

  package Parts "Test MultiBody.Parts"
  extends Modelica.Icons.ExamplesPackage;
    model FixedTranslation
      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody.*;
      extends Modelica.Icons.Example;
      parameter SI.Length length=0.5 "Length of axes of frames";
      parameter SI.Diameter diameter=length/30 "Diameter of frame axes";
      Modelica.Mechanics.MultiBody.Frames.Orientation R;
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(
                                                        r={1,0.5,0})
        annotation (Placement(transformation(extent={{-40,40},{-20,60}},
              rotation=0)));
      Visualizers.FixedFrame frameT1(length=length, diameter=diameter)
        annotation (Placement(transformation(extent={{-60,60},{-80,80}},
              rotation=0)));
      Visualizers.FixedFrame frameT2(length=length, diameter=diameter)
        annotation (Placement(transformation(extent={{0,40},{20,60}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed1(
                                   animation=false)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}},
              rotation=0)));
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, gravityType=0)
        annotation (Placement(transformation(extent={{20,0},{40,20}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedArrow arrow(
        n={1,0.5,0},
        color={0,0,255},
        r_tail={0.03,0.1,0},
        length=1.05,
        diameter=0.02) annotation (Placement(transformation(extent={{-40,20},{
                -20,40}}, rotation=0)));
    equation
      R = Modelica.Mechanics.MultiBody.Frames.nullRotation();
      connect(frameT1.frame_a, fixedTranslation.frame_a)
        annotation (Line(points={{-60,70},{-50,70},{-50,50},{-40,50}}));
      connect(fixed1.frame_b, fixedTranslation.frame_a)
        annotation (Line(points={{-60,30},{-50,30},{-50,50},{-40,50}}));
      connect(fixedTranslation.frame_b, frameT2.frame_a)
        annotation (Line(points={{-20,50},{0,50}}));
      connect(arrow.frame_a, fixed1.frame_b)
        annotation (Line(
          points={{-40,30},{-60,30}},
          color={0,0,0},
          thickness=0.5));
      annotation (
        experiment(StopTime=1),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
                  experiment(StopTime=1.1));
    end FixedTranslation;

    encapsulated model BodyShape "Simple spring/damper/mass system"
      import Modelica.Icons;
      import Modelica.Mechanics.MultiBody;
      import Modelica.Mechanics.Rotational;
      import Modelica;
      extends Icons.Example;
      parameter Boolean animation=true "= true, if animation shall be enabled";
      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-60,40},{-40,60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar2(
                                            r={0.8,0,0}, animation=false)
        annotation (Placement(transformation(extent={{0,40},{20,60}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Forces.Spring spring1(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={-24,26},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape body(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r={0.4,0,0},
        r_CM={0.2,0,0},
        width=0.05) annotation (Placement(transformation(extent={{0,-20},{20,0}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Spring spring2(
        c=20,
        s_unstretched=0,
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5) annotation (Placement(transformation(
            origin={42,26},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Joints.FreeMotion freeMotion(
          arrowDiameter=0.04, r_rel_a(start={0.2,-0.5,0.1}))
                              annotation (Placement(transformation(extent={{-30,
                -40},{-10,-20}}, rotation=0)));
    equation
      connect(bar2.frame_a, world.frame_b)
        annotation (Line(
          points={{0,50},{-40,50}},
          color={0,0,0},
          thickness=0.5));
      connect(spring1.frame_b, body.frame_a) annotation (Line(
          points={{-24,16},{-24,-10},{0,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(spring2.frame_b, body.frame_b)
        annotation (Line(
          points={{42,16},{20,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(bar2.frame_b, spring2.frame_a)
        annotation (Line(
          points={{20,50},{42,50},{42,36}},
          color={0,0,0},
          thickness=0.5));
      connect(spring1.frame_a, world.frame_b) annotation (Line(
          points={{-24,36},{-24,50},{-40,50}},
          color={0,0,0},
          thickness=0.5));
      connect(world.frame_b, freeMotion.frame_a) annotation (Line(
          points={{-40,50},{-34,50},{-34,-30},{-30,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(freeMotion.frame_b, body.frame_a) annotation (Line(
          points={{-10,-30},{-6,-30},{-6,-10},{0,-10}},
          color={0,0,0},
          thickness=0.5));
      annotation (
        experiment(StopTime=10),
        Window(
          x=0.29,
          y=0,
          width=0.71,
          height=0.85),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Documentation(info="<html>
<p>
This is the same example as \"FreeBody\". The only difference
is that with the <b>FreeMotion</b> joint explicitly 6 degrees of
freedom are introduced. The advantage is that <b>no non-linear system
of equations</b> occurs any more, because the FreeMotion joint is
described by a set of <b>non-redundant</b> variables. The disadvantage is
that there is an orientation for which this description is singular
(see description of FreeMotion joint). In technical systems it is
often possible to use the FreeMotion joint such that the singularity
</p>
</html>"));
    end BodyShape;

    model PointMass "Test Modelica.Mechanics.MultiBody.Parts.PointMass"
      extends Modelica.Icons.Example;

      inner Modelica.Mechanics.MultiBody.World world
        annotation (Placement(transformation(extent={{-60,20},{-40,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={1,0,0})
        annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.PointMass pointMass(m=5)
        annotation (Placement(transformation(extent={{60,20},{80,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute rev(
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true))
        annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=
               0)));
    equation
      connect(fixedTranslation.frame_b,pointMass. frame_a) annotation (Line(
          points={{40,30},{70,30}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, rev.frame_a) annotation (Line(
          points={{-40,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(rev.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{0,30},{20,30}},
          color={95,95,95},
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
        experiment(StopTime=1.1),
                  experiment(StopTime=1));
    end PointMass;

    model Bodies
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;
      Modelica.Mechanics.MultiBody.Parts.Body body2(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r_0(start={0.8,0.2,0}))
                               annotation (Placement(transformation(extent={{
                -20,20},{0,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r_CM={0.3,0,0},
        r={0.6,0,0},
        width=0.05) annotation (Placement(transformation(extent={{-20,-20},{0,0}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox BodyBox1(
                                       r={1,0,0})
        annotation (Placement(transformation(extent={{-20,-60},{0,-40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder(
                                                r={1,0,0}, innerDiameter=
            bodyCylinder.diameter/2) annotation (Placement(transformation(
              extent={{-20,-100},{0,-80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed3(
                                   animation=false, r={0,-0.3,0})
        annotation (Placement(transformation(extent={{-80,-20},{-60,0}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed4(
                                   animation=false, r={0,-0.6,0})
        annotation (Placement(transformation(extent={{-80,-60},{-60,-40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed5(
                                   animation=false, r={0,-0.8,0})
        annotation (Placement(transformation(extent={{-80,-100},{-60,-80}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body body1(
        m=1,
        I_11=1,
        I_22=1,
        I_33=1,
        r_CM={0.3,0,0},
        r_0(start={0.8,0.2,0}))
                        annotation (Placement(transformation(extent={{-20,60},{
                0,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed1(
                                   animation=false, r={0,0.2,0})
        annotation (Placement(transformation(extent={{-80,60},{-60,80}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed Fixed2(
                                   animation=false, r={0,0,0})
        annotation (Placement(transformation(extent={{-80,20},{-60,40}},
              rotation=0)));
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{40,0},{60,20}}, rotation=
                0)));
    equation

      connect(Fixed3.frame_b, bodyShape.frame_a)
        annotation (Line(points={{-60,-10},{-20,-10}}));
      connect(Fixed4.frame_b, BodyBox1.frame_a)
        annotation (Line(points={{-60,-50},{-20,-50}}));
      connect(Fixed5.frame_b, bodyCylinder.frame_a)
        annotation (Line(points={{-60,-90},{-20,-90}}));
      connect(Fixed1.frame_b, body1.frame_a) annotation (Line(points={{-60,70},
              {-20,70}}));
      connect(Fixed2.frame_b, body2.frame_a) annotation (Line(points={{-60,30},
              {-20,30}}));
      annotation (experiment(StopTime=1.1),
                  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics));
    end Bodies;

    model FreeBodies
      "Test whether enforceStates=true works for all body types (#300)"
      extends Modelica.Icons.Example;
      parameter Boolean animation=true "= true, if animation shall be enabled";
      inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
            transformation(extent={{-94,20},{-74,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar2(r={0.8,0,0}, animation=false)
        annotation (Placement(transformation(extent={{56,20},{76,40}},rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Spring spring1(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={36,6},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape(
        I_11=1,
        I_22=1,
        I_33=1,
        r={0.4,0,0},
        r_CM={0.2,0,0},
        width=0.05,
        r_0(start={0.2,-0.5,0.1}, fixed=true),
        v_0(fixed=true),
        angles_fixed=true,
        w_0_fixed=true,
        enforceStates=true,
        m=1,
        angles_start={0.17453292519943,0.17453292519943,0.17453292519943})
        annotation (Placement(transformation(extent={{56,-40},{76,-20}},rotation=0)));
      Modelica.Mechanics.MultiBody.Forces.Spring spring2(
        c=20,
        s_unstretched=0,
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5) annotation (Placement(transformation(
            origin={96,6},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Parts.Body body(
        I_11=0.1,
        I_22=0.1,
        I_33=0.1,
        enforceStates=true,
        r_0(start={0.2,-0.5,0.1}, fixed=true),
        v_0(fixed=true),
        m=1,
        r_CM={0,-0.3,0},
        angles_fixed=true,
        w_0_fixed=true)  annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-60,-30})));
      Modelica.Mechanics.MultiBody.Forces.Spring spring3(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0) annotation (Placement(transformation(
            origin={-60,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox(
        r={0,-0.3,0},
        width=0.05,
        enforceStates=true,
        r_0(start={0.2,-0.5,0.1}, fixed=true),
        v_0(fixed=true),
        angles_fixed=true,
        w_0_fixed=true)                                  annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-36,-30})));
      Modelica.Mechanics.MultiBody.Forces.Spring spring4(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        s_unstretched=0,
        c=100)           annotation (Placement(transformation(
            origin={-36,-2},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Forces.Spring spring5(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        s_unstretched=0,
        c=100)           annotation (Placement(transformation(
            origin={-6,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder(
        r={0,-0.3,0},
        diameter=0.05,
        r_0(start={0.2,-0.5,0.1}, fixed=true),
        v_0(fixed=true),
        enforceStates=true,
        angles_fixed=true,
        w_0_fixed=true)     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-6,-30})));
      Modelica.Mechanics.MultiBody.Parts.PointMass pointMass(
        m=1,
        sphereDiameter=0.1,
        stateSelect=StateSelect.always,
        r_0(start={0.2,-0.5,0.1}, fixed=true),
        v_0(fixed=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={16,-36})));
      Modelica.Mechanics.MultiBody.Forces.Spring spring6(
        width=0.1,
        coilWidth=0.005,
        numberOfWindings=5,
        c=20,
        s_unstretched=0,
        fixedRotationAtFrame_b=true)
                         annotation (Placement(transformation(
            origin={16,-2},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(bar2.frame_a, world.frame_b)
        annotation (Line(
          points={{56,30},{12,30},{-74,30}},
          color={95,95,95},
          thickness=0.5));
      connect(spring1.frame_b, bodyShape.frame_a)
                                             annotation (Line(
          points={{36,-4},{36,-30},{56,-30}},
          color={95,95,95},
          thickness=0.5));
      connect(bar2.frame_b, spring2.frame_a)
        annotation (Line(
          points={{76,30},{96,30},{96,16}},
          color={95,95,95},
          thickness=0.5));
      connect(spring1.frame_a, world.frame_b) annotation (Line(
          points={{36,16},{36,30},{-74,30}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape.frame_b, spring2.frame_b)
                                             annotation (Line(
          points={{76,-30},{96,-30},{96,-4}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, spring3.frame_a) annotation (Line(
          points={{-74,30},{-60,30},{-60,10}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(spring3.frame_b, body.frame_a) annotation (Line(
          points={{-60,-10},{-60,-20}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, spring4.frame_a) annotation (Line(
          points={{-74,30},{-36,30},{-36,8}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(spring4.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-36,-12},{-36,-20}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, spring5.frame_a) annotation (Line(
          points={{-74,30},{-6,30},{-6,10}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(spring5.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{-6,-10},{-6,-12.5},{-6,-12.5},{-6,-15},{-6,-20},{-6,-20}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, spring6.frame_a) annotation (Line(
          points={{-74,30},{16,30},{16,8}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(spring6.frame_b, pointMass.frame_a) annotation (Line(
          points={{16,-12},{16,-24},{16,-24},{16,-36}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        experiment(StopTime=10),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Documentation(info="<html>

</html>"));
    end FreeBodies;

    package Rotor1D
      model Rotor1D_1
        inner Modelica.Mechanics.MultiBody.World world(driveTrainMechanics3D=
              true)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Joints.Spherical spherical1(
          angles_fixed=true,
          w_rel_a_fixed=true,
          z_rel_a_fixed=false)
          annotation (Placement(transformation(extent={{-70,20},{-50,40}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder1(r={0.25,0,0},
            diameter=0.05) annotation (Placement(transformation(extent={{-44,20},
                  {-24,40}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation1(angle=45,
            n={0,1,0}) annotation (Placement(transformation(extent={{-16,20},{4,
                  40}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Joints.Revolute revolute(
          n={1,0,0},
          a(fixed=false),
          phi(fixed=true),
          w(fixed=true, start=8.726646259971648))
                      annotation (Placement(transformation(extent={{14,20},{34,
                  40}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={-0.1,
              0,0}) annotation (Placement(transformation(extent={{42,20},{62,40}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder2(diameter=
              0.1, r={0.2,0,0}) annotation (Placement(transformation(extent={{
                  70,20},{90,40}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Fixed fixed
          annotation (Placement(transformation(extent={{-100,-40},{-80,-20}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Joints.Spherical spherical2(
          angles_fixed=true,
          w_rel_a_fixed=true,
          z_rel_a_fixed=false)
          annotation (Placement(transformation(extent={{-70,-40},{-50,-20}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder3(
          r={0.25,0,0},
          diameter=0.05,
          color={0,128,0}) annotation (Placement(transformation(extent={{-44,
                  -40},{-24,-20}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation2(n={0,1,0},
            angle=45) annotation (Placement(transformation(extent={{-16,-40},{4,
                  -20}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation1(r={
              -0.1,0,0}) annotation (Placement(transformation(extent={{24,-40},
                  {44,-20}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder4(
          diameter=0.1,
          r={0.2,0,0},
          color={0,128,0}) annotation (Placement(transformation(extent={{56,-40},
                  {76,-20}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D(
          J=bodyCylinder4.I[1, 1],
          n={1,0,0},
          a(fixed=false),
          phi(fixed=true),
          w(fixed=true, start=8.726646259971648))
                      annotation (Placement(transformation(extent={{28,-70},{48,
                  -50}}, rotation=0)));
      equation
        connect(world.frame_b, spherical1.frame_a) annotation (Line(
            points={{-80,30},{-70,30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(spherical1.frame_b, bodyCylinder1.frame_a) annotation (Line(
            points={{-50,30},{-44,30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(bodyCylinder1.frame_b, fixedRotation1.frame_a) annotation (Line(
            points={{-24,30},{-16,30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(fixedRotation1.frame_b, revolute.frame_a) annotation (Line(
            points={{4,30},{14,30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
            points={{34,30},{42,30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(fixedTranslation.frame_b, bodyCylinder2.frame_a) annotation (Line(
            points={{62,30},{70,30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(spherical2.frame_b, bodyCylinder3.frame_a) annotation (Line(
            points={{-50,-30},{-44,-30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(bodyCylinder3.frame_b, fixedRotation2.frame_a) annotation (Line(
            points={{-24,-30},{-16,-30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(fixed.frame_b, spherical2.frame_a) annotation (Line(
            points={{-80,-30},{-70,-30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(fixedTranslation1.frame_b, bodyCylinder4.frame_a) annotation (Line(
            points={{44,-30},{56,-30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(fixedRotation2.frame_b, fixedTranslation1.frame_a) annotation (Line(
            points={{4,-30},{24,-30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(rotor1D.frame_a, fixedRotation2.frame_b) annotation (Line(
            points={{38,-70},{38,-76},{10,-76},{10,-30},{4,-30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        annotation (
          experiment(StopTime=5, Tolerance=1e-008));
      end Rotor1D_1;

      model Rotor1D_2
        Modelica.Mechanics.MultiBody.Parts.BodyShape bodyCylinder(
          r={0.5,0,0},
          m=0,
          I_11=2,
          I_22=0,
          I_33=0,
          shapeType="cylinder",
          width=0.1,
          animateSphere=false,
          r_shape={0.1,0,0})
                     annotation (Placement(transformation(extent={{-12,20},{8,
                  40}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Joints.Revolute revolute(n={1,0,0},
          a(fixed=false),
          phi(fixed=true),
          w(fixed=true))
          annotation (Placement(transformation(extent={{-46,20},{-26,40}},
                rotation=0)));
        inner Modelica.Mechanics.MultiBody.World world(g=0,
            driveTrainMechanics3D=true)
                    annotation (Placement(transformation(extent={{-80,20},{-60,
                  40}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Forces.Torque torque(resolveInFrame=
              Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
          annotation (Placement(transformation(extent={{-12,50},{8,70}},
                rotation=0)));
        Modelica.Blocks.Sources.Sine sine[3](amplitude={1,0,0})
          annotation (Placement(transformation(extent={{-100,80},{-80,100}},
                rotation=0)));
        inner Modelica.Mechanics.MultiBody.Parts.Fixed fixed
                    annotation (Placement(transformation(extent={{-82,-70},{-62,
                  -50}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D(J=2)
          annotation (Placement(transformation(extent={{-20,-20},{0,0}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
          annotation (Placement(transformation(extent={{-52,-20},{-32,0}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D
          annotation (Placement(transformation(extent={{-66,-40},{-46,-20}},
                rotation=0)));
      equation
        connect(world.frame_b, revolute.frame_a) annotation (Line(
            points={{-60,30},{-46,30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
            points={{-26,30},{-12,30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(torque.frame_b, bodyCylinder.frame_b) annotation (Line(
            points={{8,60},{18,60},{18,30},{8,30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(torque.frame_resolve, world.frame_b) annotation (Line(
            points={{2,70},{2,84},{-50,84},{-50,30},{-60,30}},
            color={95,95,95},
            pattern=LinePattern.Dot,
            smooth=Smooth.None));
        connect(torque.frame_a, world.frame_b) annotation (Line(
            points={{-12,60},{-50,60},{-50,30},{-60,30}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(sine.y, torque.torque) annotation (Line(
            points={{-79,90},{-8,90},{-8,72}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(fixed.frame_b, rotor1D.frame_a)  annotation (Line(
            points={{-62,-60},{-10,-60},{-10,-20}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(torque1.flange,   rotor1D.flange_a) annotation (Line(
            points={{-32,-10},{-20,-10}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(mounting1D.flange_b,torque1.support)  annotation (Line(
            points={{-46,-30},{-42,-30},{-42,-20}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(mounting1D.frame_a, fixed.frame_b)  annotation (Line(
            points={{-56,-40},{-56,-60},{-62,-60}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(sine[1].y, torque1.tau) annotation (Line(
            points={{-79,90},{-70,90},{-70,60},{-92,60},{-92,-10},{-54,-10}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          experiment(StopTime=1.1));
      end Rotor1D_2;

      model Rotor1D_3
        Modelica.Mechanics.MultiBody.Parts.BodyShape bodyCylinder(
          r={0.5,0,0},
          m=0,
          I_11=2,
          I_22=0,
          I_33=0,
          shapeType="cylinder",
          width=0.1,
          animateSphere=false,
          r_shape={0.1,0,0})
                     annotation (Placement(transformation(extent={{50,0},{70,20}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Joints.Revolute revolute(n={1,0,0},
          a(fixed=false),
          phi(fixed=true),
          w(fixed=true))
          annotation (Placement(transformation(extent={{16,0},{36,20}},
                rotation=0)));
        inner Modelica.Mechanics.MultiBody.World world(g=0,
            driveTrainMechanics3D=true)
                    annotation (Placement(transformation(extent={{-84,0},{-64,
                  20}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Forces.Torque torque(resolveInFrame=
              Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
          annotation (Placement(transformation(extent={{50,30},{70,50}},
                rotation=0)));
        Modelica.Blocks.Sources.Sine sine1[3](amplitude={1,0,0})
          annotation (Placement(transformation(extent={{16,60},{36,80}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D(J=2)
          annotation (Placement(transformation(extent={{50,-46},{70,-26}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
          annotation (Placement(transformation(extent={{18,-46},{38,-26}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D
          annotation (Placement(transformation(extent={{4,-66},{24,-46}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Joints.Revolute r1(        n={0,1,0},
            useAxisFlange=true)
          annotation (Placement(transformation(extent={{-32,0},{-12,20}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Sources.Position position1(useSupport=
              true)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}},
                rotation=0)));
        Modelica.Blocks.Sources.Sine sine2(amplitude=2)
          annotation (Placement(transformation(extent={{-100,50},{-80,70}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D1
          annotation (Placement(transformation(extent={{-60,24},{-40,44}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Joints.Revolute r2(        n={0,1,0},
            useAxisFlange=true)
          annotation (Placement(transformation(extent={{-38,-90},{-18,-70}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Sources.Position position2(useSupport=
              true)
          annotation (Placement(transformation(extent={{-52,-40},{-32,-20}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D2
          annotation (Placement(transformation(extent={{-66,-66},{-46,-46}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Fixed fixed
          annotation (Placement(transformation(extent={{-86,-90},{-66,-70}},
                rotation=0)));
      equation
        connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
            points={{36,10},{50,10}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(torque.frame_b, bodyCylinder.frame_b) annotation (Line(
            points={{70,40},{80,40},{80,10},{70,10}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(sine1.y, torque.torque)
                                       annotation (Line(
            points={{37,70},{54,70},{54,52}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(torque1.flange,   rotor1D.flange_a) annotation (Line(
            points={{38,-36},{50,-36}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(mounting1D.flange_b,torque1.support)  annotation (Line(
            points={{24,-56},{28,-56},{28,-46}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(r1.frame_a, world.frame_b) annotation (Line(
            points={{-32,10},{-64,10}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(position1.flange,   r1.axis) annotation (Line(
            points={{-26,60},{-22,60},{-22,20}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(position1.support, mounting1D1.flange_b) annotation (Line(
            points={{-36,50},{-36,34},{-40,34}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(mounting1D1.frame_a, world.frame_b) annotation (Line(
            points={{-50,24},{-50,10},{-64,10}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(sine2.y, position1.phi_ref) annotation (Line(
            points={{-79,60},{-48,60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(r1.frame_b, revolute.frame_a) annotation (Line(
            points={{-12,10},{16,10}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(torque.frame_resolve, revolute.frame_a) annotation (Line(
            points={{64,50},{8,50},{8,10},{16,10}},
            color={95,95,95},
            pattern=LinePattern.Dot,
            smooth=Smooth.None));
        connect(torque.frame_a, revolute.frame_a) annotation (Line(
            points={{50,40},{8,40},{8,10},{16,10}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(position2.flange,   r2.axis) annotation (Line(
            points={{-32,-30},{-28,-30},{-28,-70}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(position2.support, mounting1D2.flange_b) annotation (Line(
            points={{-42,-40},{-42,-56},{-46,-56}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(fixed.frame_b, r2.frame_a) annotation (Line(
            points={{-66,-80},{-38,-80}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(fixed.frame_b, mounting1D2.frame_a) annotation (Line(
            points={{-66,-80},{-56,-80},{-56,-66}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(sine2.y, position2.phi_ref) annotation (Line(
            points={{-79,60},{-70,60},{-70,36},{-92,36},{-92,-30},{-54,-30}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(r2.frame_b, rotor1D.frame_a) annotation (Line(
            points={{-18,-80},{60,-80},{60,-46}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(r2.frame_b, mounting1D.frame_a) annotation (Line(
            points={{-18,-80},{14,-80},{14,-66}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(sine1[1].y, torque1.tau) annotation (Line(
            points={{37,70},{92,70},{92,-20},{0,-20},{0,-36},{16,-36}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          experiment(StopTime=1.1));
      end Rotor1D_3;

      model GearConstraint
        Modelica.Mechanics.MultiBody.Joints.GearConstraint gearConstraint(ratio=
             10) annotation (Placement(transformation(extent={{34,40},{54,60}},
                rotation=0)));
        inner Modelica.Mechanics.MultiBody.World world(
                    g=0, driveTrainMechanics3D=true)
                         annotation (Placement(transformation(extent={{-62,10},
                  {-42,30}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.BodyCylinder cyl1(
          diameter=0.1,
          color={0,128,0},
          r={0.4,0,0}) annotation (Placement(transformation(extent={{2,40},{22,
                  60}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.BodyCylinder cyl2(r={0.4,0,0},
            diameter=0.2) annotation (Placement(transformation(extent={{70,40},
                  {90,60}}, rotation=0)));
        Modelica.Mechanics.MultiBody.Forces.Torque torque1(resolveInFrame=
              Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
          annotation (Placement(transformation(extent={{-26,40},{-6,60}},
                rotation=0)));
        Modelica.Blocks.Sources.Sine sine[3](amplitude={2,0,0})
          annotation (Placement(transformation(extent={{-100,60},{-80,80}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Fixed fixed
          annotation (Placement(transformation(extent={{-48,-90},{-28,-70}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Components.Inertia inertia1(
            J=cyl1.I[1, 1],
          a(fixed=false),
          phi(fixed=true),
          w(fixed=true))    annotation (Placement(transformation(extent={{-20,
                  -40},{0,-20}}, rotation=0)));
        Modelica.Mechanics.Rotational.Components.IdealGear idealGear(
                                                          ratio=10, useSupport=
              true)
          annotation (Placement(transformation(extent={{12,-40},{32,-20}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Components.Inertia inertia2(
                                                       J=cyl2.I[1, 1])
          annotation (Placement(transformation(extent={{44,-40},{64,-20}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
          annotation (Placement(transformation(extent={{-48,-40},{-28,-20}},
                rotation=0)));
        Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D
          annotation (Placement(transformation(extent={{-20,-70},{0,-50}},
                rotation=0)));
      equation
        connect(world.frame_b, gearConstraint.bearing) annotation (Line(
            points={{-42,20},{44,20},{44,40}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(cyl1.frame_b, gearConstraint.frame_a) annotation (Line(
            points={{22,50},{34,50}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(gearConstraint.frame_b, cyl2.frame_a) annotation (Line(
            points={{54,50},{70,50}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(torque1.frame_b, cyl1.frame_a) annotation (Line(
            points={{-6,50},{2,50}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(torque1.frame_a, world.frame_b) annotation (Line(
            points={{-26,50},{-36,50},{-36,20},{-42,20}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        connect(sine.y, torque1.torque) annotation (Line(
            points={{-79,70},{-22,70},{-22,62}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(inertia1.flange_b, idealGear.flange_a) annotation (Line(
            points={{0,-30},{12,-30}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(idealGear.flange_b, inertia2.flange_a) annotation (Line(
            points={{32,-30},{44,-30}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(torque2.flange,   inertia1.flange_a) annotation (Line(
            points={{-28,-30},{-20,-30}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(sine[1].y, torque2.tau) annotation (Line(
            points={{-79,70},{-72,70},{-72,-30},{-50,-30}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(mounting1D.flange_b,idealGear.support)  annotation (Line(
            points={{0,-60},{22,-60},{22,-40}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(mounting1D.flange_b,torque2.support)  annotation (Line(
            points={{0,-60},{4,-60},{4,-48},{-38,-48},{-38,-40}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(fixed.frame_b, mounting1D.frame_a) annotation (Line(
            points={{-28,-80},{-10,-80},{-10,-70}},
            color={95,95,95},
            thickness=0.5,
            smooth=Smooth.None));
        annotation (
          experiment(StopTime=5),
          experimentSetupOutput);
      end GearConstraint;
    end Rotor1D;
  end Parts;

  package Sensors "Test MultiBody.Sensors"
  extends Modelica.Icons.ExamplesPackage;

    encapsulated model AbsoluteSensor
      "Simple pendulum with one revolute joint and one body"
      import Modelica;
      import Modelica.Mechanics.MultiBody;
      import ObsoleteModelica3;
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(
                                  gravityType=Modelica.Mechanics.MultiBody.Types.
            GravityTypes.UniformGravity)
                            annotation (Placement(transformation(extent={{-80,0},
                {-60,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute rev(
                                            n={0,0,1},
        useAxisFlange=true,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true))             annotation (Placement(transformation(extent=
                {{-40,0},{-20,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Damper damper(
                                                  d=0.1)
        annotation (Placement(transformation(extent={{-40,40},{-20,60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox box(
                                  r={1,0,0}, animation=false)
        annotation (Placement(transformation(extent={{0,0},{20,20}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.AbsoluteSensor
        sensor_frame_a1(
        resolveInFrame_a=true,
        get_r_abs=true,
        get_v_abs=true,
        get_a_abs=true,
        get_w_abs=true,
        get_z_abs=true,
        get_angles=true) annotation (Placement(transformation(extent={{40,22},{
                60,42}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.AbsoluteSensor
        sensor_world1(
        get_r_abs=true,
        get_v_abs=true,
        get_a_abs=true,
        get_w_abs=true,
        get_z_abs=true,
        resolveInFrame_a=false,
        get_angles=true) annotation (Placement(transformation(extent={{40,-20},
                {60,0}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.AbsoluteSensor
        sensor_frame_a2(
        get_r_abs=true,
        get_v_abs=true,
        get_a_abs=true,
        get_w_abs=true,
        get_z_abs=true,
        resolveInFrame_a=false,
        get_angles=true) annotation (Placement(transformation(extent={{40,60},{
                60,80}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.AbsoluteSensor
        sensor_world2(
        get_r_abs=true,
        get_v_abs=true,
        get_a_abs=true,
        get_w_abs=true,
        get_z_abs=true,
        resolveInFrame_a=true,
        get_angles=true) annotation (Placement(transformation(extent={{40,-40},
                {60,-60}}, rotation=0)));
      Modelica.Blocks.Math.Add err1[18](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{80,40},{100,60}},
              rotation=0)));
      Modelica.Blocks.Math.Add err2[18](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{80,-40},{100,-20}},
              rotation=0)));
    equation
      connect(world.frame_b, rev.frame_a)
        annotation (Line(
          points={{-60,10},{-40,10}},
          color={0,0,0},
          thickness=0.5));
      connect(damper.flange_b, rev.axis) annotation (Line(points={{-20,50},{-16,
              50},{-16,26},{-30,26},{-30,20}}, color={0,0,0}));
      connect(rev.support, damper.flange_a) annotation (Line(points={{-36,20},{
              -36,26},{-48,26},{-48,50},{-40,50}}, color={0,0,0}));
      connect(rev.frame_b, box.frame_a)
        annotation (Line(
          points={{-20,10},{0,10}},
          color={0,0,0},
          thickness=0.5));
      connect(box.frame_b, sensor_frame_a1.frame_a) annotation (Line(
          points={{20,10},{30,10},{30,32},{40,32}},
          color={0,0,0},
          thickness=0.5));
      connect(box.frame_b, sensor_world1.frame_a) annotation (Line(
          points={{20,10},{30,10},{30,-10},{40,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(box.frame_b, sensor_frame_a2.frame_a) annotation (Line(
          points={{20,10},{30,10},{30,70},{40,70}},
          color={0,0,0},
          thickness=0.5));
      connect(box.frame_b, sensor_world2.frame_a) annotation (Line(
          points={{20,10},{30,10},{30,-50},{40,-50}},
          color={0,0,0},
          thickness=0.5));
      connect(sensor_frame_a2.y,err1.u1)
        annotation (Line(points={{61,70},{68,70},{68,56},{78,56}}, color={0,0,
              255}));
      connect(sensor_frame_a1.y,err1.u2)
        annotation (Line(points={{61,32},{68,32},{68,44},{78,44}}, color={0,0,
              255}));
      connect(sensor_world1.y,err2.u1)
        annotation (Line(points={{61,-10},{68,-10},{68,-24},{78,-24}}, color={0,
              0,255}));
      connect(sensor_world2.y,err2.u2)
        annotation (Line(points={{61,-50},{70,-50},{70,-36},{78,-36}}, color={0,
              0,255}));
      connect(sensor_world2.frame_resolve, world.frame_b) annotation (Line(
          points={{50,-60},{50,-76},{-48,-76},{-48,10},{-60,10}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(sensor_frame_a2.frame_resolve, rev.frame_b) annotation (Line(
          points={{50,80},{50,80},{50,94},{-12,94},{-12,10},{-20,10}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      annotation (
        experiment(StopTime=5),
        Window(
          x=0.29,
          y=0,
          width=0.71,
          height=0.85),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Documentation(info=""));
    end AbsoluteSensor;

    model AbsoluteSensor2
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=true, animateGravity=true)
        annotation (Placement(transformation(extent={{-80,-20},{-60,0}},
              rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.AbsoluteSensor freeMotion
        annotation (Placement(transformation(extent={{0,-20},{20,0}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
        r={0.5,0.5,0.1},
        rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.
            PlanarRotationSequence,
        angles={45,45,45},
        animation=false) annotation (Placement(transformation(extent={{-40,-20},
                {-20,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_a(
                                               color_x={0,128,255})
        annotation (Placement(transformation(
            origin={-10,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(world.frame_b, fixedRotation.frame_a)
        annotation (Line(
          points={{-60,-10},{-40,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(fixedRotation.frame_b, freeMotion.frame_a)
        annotation (Line(
          points={{-20,-10},{0,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_a.frame_a, freeMotion.frame_a) annotation (Line(
          points={{-10,-40},{-10,-10},{0,-10}},
          color={0,0,0},
          thickness=0.5));
      annotation (
        experiment(StopTime=1.1),
                  experiment(StopTime=1.1));
    end AbsoluteSensor2;

    model RelativeSensor
      import Modelica.Mechanics.MultiBody.*;
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-100,20},{-80,40}}, rotation=0)));
      Joints.Revolute revolute(
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true))
        annotation (Placement(transformation(extent={{-68,20},{-48,40}},
              rotation=0)));
      Parts.BodyBox BodyBox1(r={0.7,0,0}) annotation (Placement(transformation(
              extent={{-40,20},{-20,40}}, rotation=0)));
      Parts.Fixed fixed(r={-0.9,0,0.3}) annotation (Placement(transformation(
              extent={{-100,-40},{-80,-20}}, rotation=0)));
      Joints.Revolute revolute1(
        a(fixed=false),
        phi(fixed=true, start=0.7853981633974483),
        w(fixed=true))        annotation (Placement(transformation(extent={{-68,
                -40},{-48,-20}}, rotation=0)));
      Parts.BodyBox BodyBox2(r={0.7,0,0}) annotation (Placement(transformation(
              extent={{-40,-40},{-20,-20}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.RelativeSensor relative_a1(
        resolveInFrame_a=true,
        get_r_rel=true,
        get_v_rel=true,
        get_a_rel=true,
        get_w_rel=true,
        get_z_rel=true,
        get_angles=true) annotation (Placement(transformation(
            origin={28,10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.RelativeSensor relative_a2(
        resolveInFrame_a=true,
        get_r_rel=true,
        get_v_rel=true,
        get_a_rel=true,
        get_w_rel=true,
        get_z_rel=true,
        get_angles=true) annotation (Placement(transformation(
            origin={50,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Math.Add err1[18](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=
               0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.RelativeSensor relative_b2(
        get_r_rel=true,
        get_v_rel=true,
        get_a_rel=true,
        get_w_rel=true,
        get_z_rel=true,
        resolveInFrame_a=false,
        get_angles=true) annotation (Placement(transformation(
            origin={-2,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.RelativeSensor relative_b1(
        get_r_rel=true,
        get_v_rel=true,
        get_a_rel=true,
        get_w_rel=true,
        get_z_rel=true,
        resolveInFrame_a=false,
        get_angles=true) annotation (Placement(transformation(
            origin={16,70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Math.Add err2[18](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{52,50},{72,70}}, rotation=
               0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.RelativeSensor relative_c(
                                        get_angles=true, sequence={3,2,1})
        annotation (Placement(transformation(
            origin={-70,70},
            extent={{-10,10},{10,-10}},
            rotation=90)));
    equation
      connect(BodyBox1.frame_a, revolute.frame_b)
        annotation (Line(points={{-40,30},{-48,30}}));
      connect(revolute.frame_a, world.frame_b)
        annotation (Line(points={{-68,30},{-80,30}}));
      connect(BodyBox2.frame_a, revolute1.frame_b)
        annotation (Line(points={{-40,-30},{-48,-30}}));
      connect(revolute1.frame_a, fixed.frame_b)
        annotation (Line(points={{-68,-30},{-80,-30}}));
      connect(BodyBox1.frame_b, relative_a2.frame_b) annotation (Line(
          points={{-20,30},{50,30},{50,0}},
          color={0,0,0},
          thickness=0.5));
      connect(BodyBox2.frame_b, relative_a2.frame_a) annotation (Line(
          points={{-20,-30},{50,-30},{50,-20}},
          color={0,0,0},
          thickness=0.5));
      connect(BodyBox1.frame_b, relative_a1.frame_b) annotation (Line(
          points={{-20,30},{28,30},{28,20}},
          color={0,0,0},
          thickness=0.5));
      connect(BodyBox2.frame_b, relative_a1.frame_a) annotation (Line(
          points={{-20,-30},{28,-30},{28,0}},
          color={0,0,0},
          thickness=0.5));
      connect(relative_a2.frame_resolve, revolute1.frame_b) annotation (Line(
          points={{60,-16},{60,-52},{-44,-52},{-44,-30},{-48,-30}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(relative_a1.y,err1.u1)
        annotation (Line(points={{39,10},{54,10},{54,16},{78,16}}, color={0,0,
              255}));
      connect(relative_a2.y,err1.u2)
        annotation (Line(points={{61,-10},{68,-10},{68,4},{78,4}}, color={0,0,
              255}));
      connect(relative_b2.frame_a, BodyBox2.frame_b) annotation (Line(
          points={{-2,40},{-2,-30},{-20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(relative_b1.frame_a, BodyBox2.frame_b) annotation (Line(
          points={{16,60},{16,-30},{-20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(relative_b1.y,err2.u1)
        annotation (Line(points={{27,70},{38,70},{38,66},{50,66}}, color={0,0,
              255}));
      connect(relative_b2.y,err2.u2)
        annotation (Line(points={{9,50},{28,50},{28,54},{50,54}}, color={0,0,
              255}));
      connect(relative_b2.frame_b, BodyBox1.frame_b) annotation (Line(
          points={{-2,60},{-2,68},{-20,68},{-20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(relative_b1.frame_b, BodyBox1.frame_b) annotation (Line(
          points={{16,80},{16,92},{-20,92},{-20,30}},
          color={0,0,0},
          thickness=0.5));
      connect(relative_b2.frame_resolve, BodyBox1.frame_a) annotation (Line(
          points={{8,44},{-32,44},{-32,56},{-44,56},{-44,30},{-40,30}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(world.frame_b, relative_c.frame_a) annotation (Line(
          points={{-80,30},{-70,30},{-70,60}},
          color={0,0,0},
          thickness=0.5));
      connect(revolute.frame_b, relative_c.frame_b) annotation (Line(
          points={{-48,30},{-46,30},{-46,94},{-70,94},{-70,80}},
          color={0,0,0},
          thickness=0.5));
      annotation (
        experiment(StopTime=2));
    end RelativeSensor;

    model Distance "Test Sensors.Distance"
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(
                                  gravityType=Modelica.Mechanics.MultiBody.Types.
            GravityTypes.UniformGravity)
                            annotation (Placement(transformation(extent={{-60,0},
                {-40,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute rev(
                                            n={0,0,1},
        useAxisFlange=true,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true))             annotation (Placement(transformation(extent=
                {{-20,0},{0,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Damper damper(
                                                  d=0.1)
        annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed(
                                  r={0,-1,0})
        annotation (Placement(transformation(
            origin={-50,-70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.MultiBody.Sensors.Distance Distance1
                                           annotation (Placement(transformation(
              extent={{-20,-60},{0,-40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox BodyBox1(
                                       r={0.5,0,0})
        annotation (Placement(transformation(extent={{20,0},{40,20}}, rotation=
                0)));
      Modelica.Blocks.Continuous.Der Der1 annotation (Placement(transformation(
              extent={{0,-100},{20,-80}}, rotation=0)));
      Modelica.Blocks.Continuous.Der Der2 annotation (Placement(transformation(
              extent={{40,-100},{60,-80}}, rotation=0)));
    equation
      connect(world.frame_b, rev.frame_a)
        annotation (Line(
          points={{-40,10},{-20,10}},
          color={0,0,0},
          thickness=0.5));
      connect(damper.flange_b, rev.axis) annotation (Line(points={{0,50},{4,50},
              {4,26},{-10,26},{-10,20}}, color={0,0,0}));
      connect(rev.support, damper.flange_a) annotation (Line(points={{-16,20},{
              -16,26},{-28,26},{-28,50},{-20,50}}, color={0,0,0}));
      connect(rev.frame_b, BodyBox1.frame_a)
        annotation (Line(
          points={{0,10},{20,10}},
          color={0,0,0},
          thickness=0.5));
      connect(Distance1.frame_b, BodyBox1.frame_b) annotation (Line(
          points={{0,-50},{60,-50},{60,10},{40,10}},
          color={0,0,0},
          thickness=0.5));
      connect(Distance1.frame_a, fixed.frame_b) annotation (Line(
          points={{-20,-50},{-50,-50},{-50,-60}},
          color={0,0,0},
          thickness=0.5));
      connect(Der1.y,Der2.u)
        annotation (Line(points={{21,-90},{38,-90}}, color={0,0,255}));
      connect(Distance1.distance, Der1.u) annotation (Line(
          points={{-10,-61},{-10,-90},{-2,-90}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        experiment(StopTime=5),
        Window(
          x=0.29,
          y=0,
          width=0.71,
          height=0.85),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Documentation(info=""));
    end Distance;

    model Distance2 "Test Modelica.Mechanics.MultiBody.Sensors.Distance"
      extends Modelica.Icons.Example;

      inner Modelica.Mechanics.MultiBody.World world
        annotation (Placement(transformation(extent={{-80,0},{-60,20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute Revolute1(
        a(fixed=false),
        phi(fixed=true, start=0.5235987755982988),
        w(fixed=true))
        annotation (Placement(transformation(extent={{-40,0},{-20,20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox BodyBox1(r={1,0,0}, width=0.08)
        annotation (Placement(transformation(extent={{0,0},{20,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r={1,0,0})
        annotation (Placement(transformation(
            origin={70,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Sensors.Distance distance1
        annotation (Placement(transformation(extent={{40,0},{60,20}}, rotation=
                0)));
      Modelica.Blocks.Continuous.Der Der1 annotation (Placement(transformation(
              extent={{60,-24},{80,-4}}, rotation=0)));
      Modelica.Blocks.Logical.LessEqualThreshold LessEqualThreshold1
        annotation (Placement(transformation(extent={{60,-50},{80,-30}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Sensors.Distance distance2
        annotation (Placement(transformation(extent={{-40,30},{-20,50}},
              rotation=0)));
    equation
      connect(world.frame_b, Revolute1.frame_a) annotation (Line(
          points={{-60,10},{-40,10}},
          color={0,0,0},
          thickness=0.5));
      connect(Revolute1.frame_b, BodyBox1.frame_a) annotation (Line(
          points={{-20,10},{0,10}},
          color={0,0,0},
          thickness=0.5));
      connect(BodyBox1.frame_b, distance1.frame_a) annotation (Line(
          points={{20,10},{40,10}},
          color={0,0,0},
          thickness=0.5));
      connect(distance1.frame_b, fixed.frame_b) annotation (Line(
          points={{60,10},{70,10},{70,40}},
          color={0,0,0},
          thickness=0.5));
      connect(distance1.distance, Der1.u) annotation (Line(points={{50,-1},{50,
              -14},{58,-14}}, color={0,0,127}));
      connect(distance1.distance, LessEqualThreshold1.u) annotation (Line(
            points={{50,-1},{50,-40},{58,-40}}, color={0,0,127}));
      connect(Revolute1.frame_a, distance2.frame_a) annotation (Line(
          points={{-40,10},{-46,10},{-46,40},{-40,40}},
          color={0,0,0},
          thickness=0.5));
      connect(Revolute1.frame_b, distance2.frame_b) annotation (Line(
          points={{-20,10},{-10,10},{-10,40},{-20,40}},
          color={0,0,0},
          thickness=0.5));
      annotation (
        experiment(
          StopTime=0.5,
          NumberOfIntervals=50000,
          Tolerance=1e-010));
    end Distance2;

    model CutForce
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-100,0},{-80,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce1a(
                                            N_to_m=10)
        annotation (Placement(transformation(extent={{-20,20},{0,0}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate1a(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,10},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body1a
                                  annotation (Placement(transformation(extent={
                {60,0},{80,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce2a(
        positiveSign=false,
        N_to_m=10,
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
                   annotation (Placement(transformation(extent={{-20,-40},{0,
                -20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate2a(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-30},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body2a
                                  annotation (Placement(transformation(extent={
                {60,-40},{80,-20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate1a(
        n={0,0,1},
        angle=90,
        r={0,0,-0.2}) annotation (Placement(transformation(extent={{-60,0},{-40,
                20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate2a(
        n={0,0,1},
        angle=90,
        r={0,0,0.2}) annotation (Placement(transformation(extent={{-60,-40},{
                -40,-20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce1b(
                                            N_to_m=10, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
        annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate1b(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body1b
                                  annotation (Placement(transformation(extent={
                {60,60},{80,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate1b(
        n={0,0,1},
        angle=90,
        r={0,0,-0.6}) annotation (Placement(transformation(extent={{-60,60},{
                -40,80}}, rotation=0)));
      Modelica.Blocks.Math.Add err1[3](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{10,30},{30,50}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce2b(
        positiveSign=false,
        N_to_m=10,
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
                   annotation (Placement(transformation(extent={{-20,-80},{0,
                -100}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate2b(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-90},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body2b
                                  annotation (Placement(transformation(extent={
                {60,-100},{80,-80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate2b(
        n={0,0,1},
        angle=90,
        r={0,0,0.6}) annotation (Placement(transformation(extent={{-60,-100},{
                -40,-80}}, rotation=0)));
      Modelica.Blocks.Math.Add err2[3](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{8,-72},{28,-52}},
              rotation=0)));
    equation

      connect(world.frame_b, rotate1a.frame_a)
        annotation (Line(
          points={{-80,10},{-60,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate1a.frame_b, cutForce1a.frame_a)
        annotation (Line(
          points={{-40,10},{-20,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2a.frame_b, cutForce2a.frame_a)
        annotation (Line(
          points={{-40,-30},{-20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2a.frame_a, world.frame_b) annotation (Line(
          points={{-60,-30},{-70,-30},{-70,10},{-80,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate1b.frame_b, cutForce1b.frame_a)
        annotation (Line(
          points={{-40,70},{-20,70}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce1b.frame_resolve, rotate1b.frame_b) annotation (Line(
          points={{-2,60},{-20,60},{-20,46},{-40,46},{-40,70}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(cutForce1b.force,err1.u1)
        annotation (Line(points={{-18,59},{-18,46},{8,46}}, color={0,0,255}));
      connect(cutForce1a.force,err1.u2)
        annotation (Line(points={{-18,21},{-18,34},{8,34}}, color={0,0,255}));
      connect(world.frame_b, rotate1b.frame_a) annotation (Line(
          points={{-80,10},{-70,10},{-70,70},{-60,70}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2b.frame_b, cutForce2b.frame_a)
        annotation (Line(
          points={{-40,-90},{-20,-90}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2b.frame_a, world.frame_b) annotation (Line(
          points={{-60,-90},{-70,-90},{-70,10},{-80,10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce2a.force,err2.u1)
        annotation (Line(points={{-18,-41},{-18,-56},{6,-56}}, color={0,0,255}));
      connect(cutForce2b.force,err2.u2)
        annotation (Line(points={{-18,-79},{-18,-68},{6,-68}}, color={0,0,255}));
      connect(cutForce2b.frame_resolve, world.frame_b) annotation (Line(
          points={{-2,-80},{-2,-58},{-74,-58},{-74,10},{-80,10}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(cutForce1b.frame_b, translate1b.frame_a)
        annotation (Line(
          points={{0,70},{20,70}},
          color={0,0,0},
          thickness=0.5));
      connect(translate1b.frame_b, body1b.frame_a)
        annotation (Line(
          points={{40,70},{60,70}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce1a.frame_b, translate1a.frame_a) annotation (Line(
          points={{0,10},{10,10},{10,10},{20,10}},
          color={0,0,0},
          thickness=0.5));
      connect(translate1a.frame_b, body1a.frame_a) annotation (Line(
          points={{40,10},{50,10},{50,10},{60,10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce2a.frame_b, translate2a.frame_a)
        annotation (Line(
          points={{0,-30},{20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(translate2a.frame_b, body2a.frame_a)
        annotation (Line(
          points={{40,-30},{60,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce2b.frame_b, translate2b.frame_a)
        annotation (Line(
          points={{0,-90},{20,-90}},
          color={0,0,0},
          thickness=0.5));
      connect(translate2b.frame_b, body2b.frame_a)
        annotation (Line(
          points={{40,-90},{60,-90}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end CutForce;

    model CutForce2
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-80,-20},{-60,0}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce
                                          annotation (Placement(transformation(
              extent={{0,-20},{20,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
        r={0.5,0.5,0.1},
        rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.
            PlanarRotationSequence,
        animation=false) annotation (Placement(transformation(extent={{-40,-20},
                {-20,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_b(
                                               color_x={0,0,200})
        annotation (Placement(transformation(
            origin={50,30},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Forces.WorldForce WorldForce1(
                                              animation=false)
        annotation (Placement(transformation(extent={{60,-20},{40,0}}, rotation=
               0)));
      Modelica.Blocks.Sources.Constant Constant1[3](k={500,0,0})
        annotation (Placement(transformation(extent={{100,-20},{80,0}},
              rotation=0)));
    equation
      connect(world.frame_b, fixedRotation.frame_a)
        annotation (Line(
          points={{-60,-10},{-40,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(Constant1.y,WorldForce1.force)
        annotation (Line(points={{79,-10},{62,-10}}, color={0,0,255}));
      connect(fixedRotation.frame_b, cutForce.frame_a)
        annotation (Line(
          points={{-20,-10},{0,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce.frame_b, WorldForce1.frame_b)
        annotation (Line(
          points={{20,-10},{40,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_b.frame_a, cutForce.frame_b) annotation (Line(
          points={{50,20},{50,14},{28,14},{28,-10},{20,-10}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end CutForce2;

    model CutTorque
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(
                                  n={0,0,-1})
        annotation (Placement(transformation(extent={{-100,0},{-80,20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Sensors.CutTorque cutTorque1a(
                                              Nm_to_m=10)
        annotation (Placement(transformation(extent={{-20,20},{0,0}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate1a(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,10},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body1a
                                  annotation (Placement(transformation(extent={
                {60,0},{80,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Sensors.CutTorque cutTorque2a(
        positiveSign=false,
        Nm_to_m=10,
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
                    annotation (Placement(transformation(extent={{-20,-40},{0,
                -20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate2a(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-30},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body2a
                                  annotation (Placement(transformation(extent={
                {60,-40},{80,-20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate1a(
        n={0,0,1},
        angle=90,
        r={0,0,-0.2}) annotation (Placement(transformation(extent={{-60,0},{-40,
                20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate2a(
        n={0,0,1},
        angle=90,
        r={0,0,0.2}) annotation (Placement(transformation(extent={{-60,-40},{
                -40,-20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Sensors.CutTorque cutTorque1b(
                                              Nm_to_m=10, resolveInFrame=
            Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
        annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate1b(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body1b
                                  annotation (Placement(transformation(extent={
                {60,60},{80,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate1b(
        n={0,0,1},
        angle=90,
        r={0,0,-0.6}) annotation (Placement(transformation(extent={{-60,60},{
                -40,80}}, rotation=0)));
      Modelica.Blocks.Math.Add err1[3](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{10,30},{30,50}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Sensors.CutTorque cutTorque2b(
        positiveSign=false,
        Nm_to_m=10,
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
                    annotation (Placement(transformation(extent={{-20,-80},{0,
                -100}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate2b(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-90},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body2b
                                  annotation (Placement(transformation(extent={
                {60,-100},{80,-80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate2b(
        n={0,0,1},
        angle=90,
        r={0,0,0.6}) annotation (Placement(transformation(extent={{-60,-100},{
                -40,-80}}, rotation=0)));
      Modelica.Blocks.Math.Add err2[3](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{8,-72},{28,-52}},
              rotation=0)));
    equation

      connect(world.frame_b, rotate1a.frame_a)
        annotation (Line(
          points={{-80,10},{-60,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate1a.frame_b, cutTorque1a.frame_a)
        annotation (Line(
          points={{-40,10},{-20,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2a.frame_b, cutTorque2a.frame_a)
        annotation (Line(
          points={{-40,-30},{-20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2a.frame_a, world.frame_b) annotation (Line(
          points={{-60,-30},{-70,-30},{-70,10},{-80,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate1b.frame_b, cutTorque1b.frame_a)
        annotation (Line(
          points={{-40,70},{-20,70}},
          color={0,0,0},
          thickness=0.5));
      connect(cutTorque1b.frame_resolve, rotate1b.frame_b) annotation (Line(
          points={{-2,60},{-20,60},{-20,46},{-40,46},{-40,70}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(cutTorque1b.torque,err1.u1)
        annotation (Line(points={{-18,59},{-18,46},{8,46}}, color={0,0,255}));
      connect(cutTorque1a.torque,err1.u2)
        annotation (Line(points={{-18,21},{-18,34},{8,34}}, color={0,0,255}));
      connect(world.frame_b, rotate1b.frame_a) annotation (Line(
          points={{-80,10},{-70,10},{-70,70},{-60,70}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2b.frame_b, cutTorque2b.frame_a)
        annotation (Line(
          points={{-40,-90},{-20,-90}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2b.frame_a, world.frame_b) annotation (Line(
          points={{-60,-90},{-70,-90},{-70,10},{-80,10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutTorque2a.torque,err2.u1)
        annotation (Line(points={{-18,-41},{-18,-56},{6,-56}}, color={0,0,255}));
      connect(cutTorque2b.torque,err2.u2)
        annotation (Line(points={{-18,-79},{-18,-68},{6,-68}}, color={0,0,255}));
      connect(cutTorque2b.frame_resolve, world.frame_b) annotation (Line(
          points={{-2,-80},{-2,-58},{-74,-58},{-74,10},{-80,10}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(cutTorque1b.frame_b, translate1b.frame_a)
        annotation (Line(
          points={{0,70},{20,70}},
          color={0,0,0},
          thickness=0.5));
      connect(translate1b.frame_b, body1b.frame_a)
        annotation (Line(
          points={{40,70},{60,70}},
          color={0,0,0},
          thickness=0.5));
      connect(cutTorque1a.frame_b, translate1a.frame_a) annotation (Line(
          points={{0,10},{10,10},{10,10},{20,10}},
          color={0,0,0},
          thickness=0.5));
      connect(translate1a.frame_b, body1a.frame_a) annotation (Line(
          points={{40,10},{50,10},{50,10},{60,10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutTorque2a.frame_b, translate2a.frame_a)
        annotation (Line(
          points={{0,-30},{20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(translate2a.frame_b, body2a.frame_a)
        annotation (Line(
          points={{40,-30},{60,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(cutTorque2b.frame_b, translate2b.frame_a)
        annotation (Line(
          points={{0,-90},{20,-90}},
          color={0,0,0},
          thickness=0.5));
      connect(translate2b.frame_b, body2b.frame_a)
        annotation (Line(
          points={{40,-90},{60,-90}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end CutTorque;

    model CutTorque2
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-80,-20},{-60,0}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Sensors.CutTorque cutTorque
                                            annotation (Placement(
            transformation(extent={{0,-20},{20,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
        r={0.5,0.5,0.1},
        rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.
            PlanarRotationSequence,
        animation=false) annotation (Placement(transformation(extent={{-40,-20},
                {-20,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_b(
                                               color_x={0,0,200})
        annotation (Placement(transformation(
            origin={50,30},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.MultiBody.Forces.WorldTorque worldTorque(
                                               animation=false)
        annotation (Placement(transformation(extent={{60,-20},{40,0}}, rotation=
               0)));
      Modelica.Blocks.Sources.Constant Constant1[3](k={500,0,0})
        annotation (Placement(transformation(extent={{100,-20},{80,0}},
              rotation=0)));
    equation
      connect(world.frame_b, fixedRotation.frame_a)
        annotation (Line(
          points={{-60,-10},{-40,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(Constant1.y,worldTorque.torque)
        annotation (Line(points={{79,-10},{62,-10}}, color={0,0,255}));
      connect(fixedRotation.frame_b, cutTorque.frame_a)
        annotation (Line(
          points={{-20,-10},{0,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutTorque.frame_b, worldTorque.frame_b)
        annotation (Line(
          points={{20,-10},{40,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_b.frame_a, cutTorque.frame_b) annotation (Line(
          points={{50,20},{50,14},{28,14},{28,-10},{20,-10}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end CutTorque2;

    model CutForceAndTorque1
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world
                                  annotation (Placement(transformation(extent={
                {-100,0},{-80,20}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.CutForceAndTorque
        cutForce1a(                                  N_to_m=10, Nm_to_m=10)
        annotation (Placement(transformation(extent={{-20,20},{0,0}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate1a(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,10},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body1a
                                  annotation (Placement(transformation(extent={
                {60,0},{80,20}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.CutForceAndTorque
        cutForce2a(
        positiveSign=false,
        resolveInFrame_a=false,
        N_to_m=10,
        Nm_to_m=10) annotation (Placement(transformation(extent={{-20,-40},{0,
                -20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate2a(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-30},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body2a
                                  annotation (Placement(transformation(extent={
                {60,-40},{80,-20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate1a(
        n={0,0,1},
        angle=90,
        r={0,0,-0.2}) annotation (Placement(transformation(extent={{-60,0},{-40,
                20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate2a(
        n={0,0,1},
        angle=90,
        r={0,0,0.2}) annotation (Placement(transformation(extent={{-60,-40},{
                -40,-20}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.CutForceAndTorque
        cutForce1b(                                  N_to_m=10, Nm_to_m=10)
        annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate1b(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body1b
                                  annotation (Placement(transformation(extent={
                {60,60},{80,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate1b(
        n={0,0,1},
        angle=90,
        r={0,0,-0.6}) annotation (Placement(transformation(extent={{-60,60},{
                -40,80}}, rotation=0)));
      Modelica.Blocks.Math.Add err1[6](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{10,30},{30,50}}, rotation=
               0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.CutForceAndTorque
        cutForce2b(
        positiveSign=false,
        resolveInFrame_a=false,
        N_to_m=10,
        Nm_to_m=10) annotation (Placement(transformation(extent={{-20,-80},{0,
                -100}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate2b(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-90},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body2b
                                  annotation (Placement(transformation(extent={
                {60,-100},{80,-80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate2b(
        n={0,0,1},
        angle=90,
        r={0,0,0.6}) annotation (Placement(transformation(extent={{-60,-100},{
                -40,-80}}, rotation=0)));
      Modelica.Blocks.Math.Add err2[6](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{8,-72},{28,-52}},
              rotation=0)));
    equation

      connect(world.frame_b, rotate1a.frame_a)
        annotation (Line(
          points={{-80,10},{-60,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate1a.frame_b, cutForce1a.frame_a)
        annotation (Line(
          points={{-40,10},{-20,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2a.frame_b, cutForce2a.frame_a)
        annotation (Line(
          points={{-40,-30},{-20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2a.frame_a, world.frame_b) annotation (Line(
          points={{-60,-30},{-70,-30},{-70,10},{-80,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate1b.frame_b, cutForce1b.frame_a)
        annotation (Line(
          points={{-40,70},{-20,70}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce1b.frame_resolve, rotate1b.frame_b) annotation (Line(
          points={{-2,60},{-20,60},{-20,46},{-40,46},{-40,70}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(cutForce1b.load,err1.u1)
        annotation (Line(points={{-18,59},{-18,46},{8,46}}, color={0,0,255}));
      connect(cutForce1a.load,err1.u2)
        annotation (Line(points={{-18,21},{-18,34},{8,34}}, color={0,0,255}));
      connect(world.frame_b, rotate1b.frame_a) annotation (Line(
          points={{-80,10},{-70,10},{-70,70},{-60,70}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2b.frame_b, cutForce2b.frame_a)
        annotation (Line(
          points={{-40,-90},{-20,-90}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2b.frame_a, world.frame_b) annotation (Line(
          points={{-60,-90},{-70,-90},{-70,10},{-80,10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce2a.load,err2.u1)
        annotation (Line(points={{-18,-41},{-18,-56},{6,-56}}, color={0,0,255}));
      connect(cutForce2b.load,err2.u2)
        annotation (Line(points={{-18,-79},{-18,-68},{6,-68}}, color={0,0,255}));
      connect(cutForce2b.frame_resolve, world.frame_b) annotation (Line(
          points={{-2,-80},{-2,-58},{-74,-58},{-74,10},{-80,10}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(cutForce1b.frame_b, translate1b.frame_a)
        annotation (Line(
          points={{0,70},{20,70}},
          color={0,0,0},
          thickness=0.5));
      connect(translate1b.frame_b, body1b.frame_a)
        annotation (Line(
          points={{40,70},{60,70}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce1a.frame_b, translate1a.frame_a) annotation (Line(
          points={{0,10},{10,10},{10,10},{20,10}},
          color={0,0,0},
          thickness=0.5));
      connect(translate1a.frame_b, body1a.frame_a) annotation (Line(
          points={{40,10},{50,10},{50,10},{60,10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce2a.frame_b, translate2a.frame_a)
        annotation (Line(
          points={{0,-30},{20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(translate2a.frame_b, body2a.frame_a)
        annotation (Line(
          points={{40,-30},{60,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce2b.frame_b, translate2b.frame_a)
        annotation (Line(
          points={{0,-90},{20,-90}},
          color={0,0,0},
          thickness=0.5));
      connect(translate2b.frame_b, body2b.frame_a)
        annotation (Line(
          points={{40,-90},{60,-90}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end CutForceAndTorque1;

    model CutForceAndTorque2
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(
                                  n={0,0,-1})
        annotation (Placement(transformation(extent={{-100,0},{-80,20}},
              rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.CutForceAndTorque
        cutForce1a(                                  N_to_m=10, Nm_to_m=10)
        annotation (Placement(transformation(extent={{-20,20},{0,0}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate1a(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,10},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body1a
                                  annotation (Placement(transformation(extent={
                {60,0},{80,20}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.CutForceAndTorque
        cutForce2a(
        positiveSign=false,
        resolveInFrame_a=false,
        N_to_m=10,
        Nm_to_m=10) annotation (Placement(transformation(extent={{-20,-40},{0,
                -20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate2a(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-30},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body2a
                                  annotation (Placement(transformation(extent={
                {60,-40},{80,-20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate1a(
        n={0,0,1},
        angle=90,
        r={0,0,-0.2}) annotation (Placement(transformation(extent={{-60,0},{-40,
                20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate2a(
        n={0,0,1},
        angle=90,
        r={0,0,0.2}) annotation (Placement(transformation(extent={{-60,-40},{
                -40,-20}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.CutForceAndTorque
        cutForce1b(                                  N_to_m=10, Nm_to_m=10)
        annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate1b(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body1b
                                  annotation (Placement(transformation(extent={
                {60,60},{80,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate1b(
        n={0,0,1},
        angle=90,
        r={0,0,-0.6}) annotation (Placement(transformation(extent={{-60,60},{
                -40,80}}, rotation=0)));
      Modelica.Blocks.Math.Add err1[6](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{10,30},{30,50}}, rotation=
               0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.CutForceAndTorque
        cutForce2b(
        positiveSign=false,
        resolveInFrame_a=false,
        N_to_m=10,
        Nm_to_m=10) annotation (Placement(transformation(extent={{-20,-80},{0,
                -100}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate2b(
                                                   r={0,-1,0})
        annotation (Placement(transformation(
            origin={30,-90},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.Body body2b
                                  annotation (Placement(transformation(extent={
                {60,-100},{80,-80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation rotate2b(
        n={0,0,1},
        angle=90,
        r={0,0,0.6}) annotation (Placement(transformation(extent={{-60,-100},{
                -40,-80}}, rotation=0)));
      Modelica.Blocks.Math.Add err2[6](
                                    each k2=
                                       -1)
        annotation (Placement(transformation(extent={{8,-72},{28,-52}},
              rotation=0)));
    equation

      connect(world.frame_b, rotate1a.frame_a)
        annotation (Line(
          points={{-80,10},{-60,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate1a.frame_b, cutForce1a.frame_a)
        annotation (Line(
          points={{-40,10},{-20,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2a.frame_b, cutForce2a.frame_a)
        annotation (Line(
          points={{-40,-30},{-20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2a.frame_a, world.frame_b) annotation (Line(
          points={{-60,-30},{-70,-30},{-70,10},{-80,10}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate1b.frame_b, cutForce1b.frame_a)
        annotation (Line(
          points={{-40,70},{-20,70}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce1b.frame_resolve, rotate1b.frame_b) annotation (Line(
          points={{-2,60},{-20,60},{-20,46},{-40,46},{-40,70}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(cutForce1b.load,err1.u1)
        annotation (Line(points={{-18,59},{-18,46},{8,46}}, color={0,0,255}));
      connect(cutForce1a.load,err1.u2)
        annotation (Line(points={{-18,21},{-18,34},{8,34}}, color={0,0,255}));
      connect(world.frame_b, rotate1b.frame_a) annotation (Line(
          points={{-80,10},{-70,10},{-70,70},{-60,70}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2b.frame_b, cutForce2b.frame_a)
        annotation (Line(
          points={{-40,-90},{-20,-90}},
          color={0,0,0},
          thickness=0.5));
      connect(rotate2b.frame_a, world.frame_b) annotation (Line(
          points={{-60,-90},{-70,-90},{-70,10},{-80,10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce2a.load,err2.u1)
        annotation (Line(points={{-18,-41},{-18,-56},{6,-56}}, color={0,0,255}));
      connect(cutForce2b.load,err2.u2)
        annotation (Line(points={{-18,-79},{-18,-68},{6,-68}}, color={0,0,255}));
      connect(cutForce2b.frame_resolve, world.frame_b) annotation (Line(
          points={{-2,-80},{-2,-58},{-74,-58},{-74,10},{-80,10}},
          color={0,0,0},
          pattern=LinePattern.Dot));
      connect(cutForce1b.frame_b, translate1b.frame_a)
        annotation (Line(
          points={{0,70},{20,70}},
          color={0,0,0},
          thickness=0.5));
      connect(translate1b.frame_b, body1b.frame_a)
        annotation (Line(
          points={{40,70},{60,70}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce1a.frame_b, translate1a.frame_a) annotation (Line(
          points={{0,10},{10,10},{10,10},{20,10}},
          color={0,0,0},
          thickness=0.5));
      connect(translate1a.frame_b, body1a.frame_a) annotation (Line(
          points={{40,10},{50,10},{50,10},{60,10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce2a.frame_b, translate2a.frame_a)
        annotation (Line(
          points={{0,-30},{20,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(translate2a.frame_b, body2a.frame_a)
        annotation (Line(
          points={{40,-30},{60,-30}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForce2b.frame_b, translate2b.frame_a)
        annotation (Line(
          points={{0,-90},{20,-90}},
          color={0,0,0},
          thickness=0.5));
      connect(translate2b.frame_b, body2b.frame_a)
        annotation (Line(
          points={{40,-90},{60,-90}},
          color={0,0,0},
          thickness=0.5));
      annotation (experiment(StopTime=1.1));
    end CutForceAndTorque2;

    model CutForceAndTorque3
      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{-80,-20},{-60,0}},
              rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Sensors.CutForceAndTorque
        cutForceAndTorque
        annotation (Placement(transformation(extent={{0,-20},{20,0}}, rotation=
                0)));
      Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
        r={0.5,0.5,0.1},
        rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.
            PlanarRotationSequence,
        animation=false) annotation (Placement(transformation(extent={{-40,-20},
                {-20,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame frame_b(
                                               color_x={0,0,200})
        annotation (Placement(transformation(
            origin={50,30},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      ObsoleteModelica3.Mechanics.MultiBody.Forces.WorldForceAndTorque
        worldForceAndTorque(                                   animation=false)
        annotation (Placement(transformation(extent={{60,-20},{40,0}}, rotation=
               0)));
      Modelica.Blocks.Sources.Constant Constant1[6](k={500,0,0,450,-250,0})
        annotation (Placement(transformation(extent={{100,-20},{80,0}},
              rotation=0)));
    equation
      connect(world.frame_b, fixedRotation.frame_a)
        annotation (Line(
          points={{-60,-10},{-40,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(fixedRotation.frame_b, cutForceAndTorque.frame_a)
        annotation (Line(
          points={{-20,-10},{0,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(cutForceAndTorque.frame_b, worldForceAndTorque.frame_b)
        annotation (Line(
          points={{20,-10},{40,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(frame_b.frame_a, cutForceAndTorque.frame_b) annotation (Line(
          points={{50,20},{50,14},{28,14},{28,-10},{20,-10}},
          color={0,0,0},
          thickness=0.5));
      connect(Constant1.y, worldForceAndTorque.load) annotation (Line(
          points={{79,-10},{62,-10}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        experiment(StopTime=1.1),
        experimentSetupOutput,
                  experiment(StopTime=1.1));
    end CutForceAndTorque3;
  end Sensors;

  package Visualizers "Test MultiBody.Visualizers"
  extends Modelica.Icons.ExamplesPackage;

    encapsulated model Shapes "Test and show models Visualizers.FixedShape"
      import Modelica.Icons;
      import Modelica.Mechanics.MultiBody;
      import Modelica.Mechanics.MultiBody.Visualizers;
      import Modelica;
      extends Icons.Example;
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed(
                                  animation=false)
        annotation (Placement(transformation(extent={{-100,40},{-80,60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape box(
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
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape sphere(
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
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape cylinder(
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
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape pipe(
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
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape beam(
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
      Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b1
                                            annotation (Placement(
            transformation(extent={{-61,-11},{-59,-9}}, rotation=0)));
    public
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape gearwheel(
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
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape spring(
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
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape cone(
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
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, animateGravity=false)
        annotation (Placement(transformation(extent={{40,0},{60,20}}, rotation=
                0)));
    equation
      connect(fixed.frame_b, box.frame_a) annotation (Line(points={{-80,50},{
              -60,50},{-60,60}}));
      connect(fixed.frame_b, sphere.frame_a) annotation (Line(points={{-80,50},
              {-30,50},{-30,60}}));
      connect(fixed.frame_b, cylinder.frame_a) annotation (Line(points={{-80,50},
              {-4,50},{-4,60}}));
      connect(fixed.frame_b, pipe.frame_a) annotation (Line(points={{-80,50},{
              42,50},{42,60}}));
      connect(fixed.frame_b, frame_b1) annotation (Line(points={{-80,50},{-74,
              50},{-74,-10},{-60,-10}}));
      connect(beam.frame_a, frame_b1)
        annotation (Line(points={{-60,0},{-60,-10}}));
      connect(frame_b1, gearwheel.frame_a) annotation (Line(points={{-60,-10},{
              -32,-10},{-32,0}}));
      connect(frame_b1, spring.frame_a) annotation (Line(points={{-60,-10},{-2,
              -10},{-2,0}}));
      connect(fixed.frame_b, cone.frame_a) annotation (Line(points={{-80,50},{
              20,50},{20,60}}));
      annotation (experiment(StopTime=1), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics));
    end Shapes;

    encapsulated model Arrow "Test and show models Visualizers.FixedShape"
      import Modelica.Icons;
      import Modelica.Mechanics.MultiBody;
      import Modelica.Mechanics.MultiBody.Visualizers;
      import Modelica;
      extends Icons.Example;
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed3(
                                   animation=false, r={0.2,-0.6,0})
        annotation (Placement(transformation(
            origin={-30,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Visualizers.SignalArrow arrow(diameter=0.02)
        annotation (Placement(transformation(
            origin={-30,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Sine sine[3](
        amplitude={0.1,0.05,0.8},
        freqHz={2,1,2},
        each offset=0.2)
                        annotation (Placement(transformation(extent={{12,20},{
                -8,40}}, rotation=0)));
      Visualizers.FixedArrow fixedArrow(length=0.3, color={0,0,255})
                  annotation (Placement(transformation(
            origin={-70,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      inner Modelica.Mechanics.MultiBody.World world(
                                  animateWorld=false, gravityType=0)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}},
              rotation=0)));
    equation
      connect(arrow.frame_a, fixed3.frame_b) annotation (Line(points={{-30,20},
              {-30,0}}));
      connect(fixedArrow.frame_a, fixed3.frame_b)
        annotation (Line(points={{-70,20},{-70,0},{-30,0}}));
      connect(sine.y, arrow.r_head) annotation (Line(
          points={{-9,30},{-18,30}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (experiment(StopTime=1), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics));
    end Arrow;

    model Torus "Test and show models Visualizers.Torus"

      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(animateWorld=false,
          animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(
          animation=false, r={2,0,0})
        annotation (Placement(transformation(extent={{-26,50},{-6,70}})));
      Modelica.Mechanics.MultiBody.Visualizers.Torus torus1(ro=0.2)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Modelica.Mechanics.MultiBody.Visualizers.Torus torus2(
        ro=0.2,
        opening=0.78539816339745,
        startAngle=-2.3561944901923,
        stopAngle=2.3561944901923)
        annotation (Placement(transformation(extent={{4,50},{24,70}})));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame fixedFrame(color_x={
            255,0,0}, length=1)
        annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame fixedFrame1(color_x={
            255,0,0}, length=1)
        annotation (Placement(transformation(extent={{12,76},{32,96}})));
    equation

      connect(world.frame_b, fixedTranslation.frame_a) annotation (Line(
          points={{-40,30},{-32,30},{-32,60},{-26,60}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, torus1.frame_a) annotation (Line(
          points={{-40,30},{-20,30}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(fixedTranslation.frame_b, torus2.frame_a) annotation (Line(
          points={{-6,60},{4,60}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(fixedFrame.frame_a, torus1.frame_a) annotation (Line(
          points={{-10,-20},{-32,-20},{-32,30},{-20,30}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(fixedFrame1.frame_a, torus2.frame_a) annotation (Line(
          points={{12,86},{0,86},{0,60},{4,60}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        Diagram(graphics),
        experiment(StopTime=2),
        experimentSetupOutput);
    end Torus;

    model VoluminousWheel
      extends Modelica.Icons.Example;
      Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel voluminousWheel
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      inner Modelica.Mechanics.MultiBody.World world(axisColor_x={255,0,0},
          animateGravity=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    equation

      connect(world.frame_b, voluminousWheel.frame_a) annotation (Line(
          points={{-40,30},{-20,30}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (Diagram(graphics));
    end VoluminousWheel;

    model ColorMaps "Show all color maps"

      extends Modelica.Icons.Example;
      inner Modelica.Mechanics.MultiBody.World world(
          animateGravity=false, animateWorld=false)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField jet(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.01:0.5,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5)
        annotation (Placement(transformation(extent={{-20,60},{0,80}})));
      Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField hot(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.hot)
        annotation (Placement(transformation(extent={{-20,30},{0,50}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate2(animation=
            false, r={0,0,-0.3})
        annotation (Placement(transformation(extent={{-48,30},{-28,50}})));
      Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField gray(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.gray)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate3(animation=
            false, r={0,0,-0.6})
        annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
      Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField spring(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.spring)
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate4(animation=
            false, r={0,0,-0.9})
        annotation (Placement(transformation(extent={{-48,-30},{-28,-10}})));
      Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField summer(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.summer)
        annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate5(animation=
            false, r={0,0,-1.2})
        annotation (Placement(transformation(extent={{-48,-60},{-28,-40}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate6(animation=
            false, r={0,0,-1.5})
        annotation (Placement(transformation(extent={{-48,-90},{-28,-70}})));
      Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField autumn(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.autumn)
        annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation translate7(animation=
            false, r={0,0,-1.8})
        annotation (Placement(transformation(extent={{-48,-120},{-28,-100}})));
      Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField winter(
        rOuter=0.1,
        length=0.5,
        xsi=0:0.02:1.0,
        T=0:0.01:0.5,
        T_min=0,
        T_max=0.5,
        redeclare function colorMap =
            Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.winter)
        annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
    equation

      connect(world.frame_b, jet.frame_a) annotation (Line(
          points={{-60,70},{-20,70}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, translate2.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,40},{-48,40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(translate2.frame_b, hot.frame_a) annotation (Line(
          points={{-28,40},{-20,40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, translate3.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,10},{-48,10}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(translate3.frame_b, gray.frame_a) annotation (Line(
          points={{-28,10},{-20,10}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(translate4.frame_b, spring.frame_a) annotation (Line(
          points={{-28,-20},{-20,-20}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, translate4.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-20},{-48,-20}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(translate5.frame_b, summer.frame_a) annotation (Line(
          points={{-28,-50},{-20,-50}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, translate5.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-50},{-48,-50}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, translate6.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-80},{-48,-80}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(translate6.frame_b, autumn.frame_a) annotation (Line(
          points={{-28,-80},{-20,-80}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, translate7.frame_a) annotation (Line(
          points={{-60,70},{-52,70},{-52,-110},{-48,-110}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(translate7.frame_b, winter.frame_a) annotation (Line(
          points={{-28,-110},{-20,-110}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-140},
                {100,100}}),
                graphics),
        experiment(StopTime=0.1),
        experimentSetupOutput);
    end ColorMaps;
  end Visualizers;

  package InitializationConversion "Test conversion of the initialization"
  extends Modelica.Icons.ExamplesPackage;
    model Rotor1D

      Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D1
        annotation (Placement(transformation(extent={{-70,40},{-50,60}},
              rotation=0)));
      inner Modelica.Mechanics.MultiBody.World world
        annotation (Placement(transformation(extent={{-100,20},{-80,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D2(
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=true, start=1.570796326794897),
        w(fixed=true, start=1.74532925199433))
                            annotation (Placement(transformation(extent={{-40,
                40},{-20,60}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D3(
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=false))
        annotation (Placement(transformation(extent={{-10,40},{10,60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D4(
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=false),
        w(fixed=true))
        annotation (Placement(transformation(extent={{20,40},{40,60}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D5(
        stateSelect=StateSelect.prefer,
        a(fixed=true),
        phi(fixed=false),
        w(fixed=true))
        annotation (Placement(transformation(extent={{-60,0},{-40,20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D6(
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=false),
        w(fixed=true))
        annotation (Placement(transformation(extent={{-8,0},{12,20}}, rotation=
                0)));
      Modelica.Mechanics.Rotational.Components.Spring spring(
                                                  c=1e4)
        annotation (Placement(transformation(extent={{-34,0},{-14,20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D7(
        a(start=0.05235987755982989, fixed=true),
        stateSelect=StateSelect.prefer,
        phi(fixed=false, start=0.0174532925199433),
        w(fixed=true, start=0.03490658503988659))
                   annotation (Placement(transformation(extent={{-60,-40},{-40,
                -20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D8(
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=false),
        w(fixed=true))
        annotation (Placement(transformation(extent={{-8,-40},{12,-20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring1(
                                                   c=1e4)
        annotation (Placement(transformation(extent={{-34,-40},{-14,-20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D9(
        a(start=0.05235987755982989, fixed=true),
        phi(fixed=true, start=0.0174532925199433),
        w(fixed=true, start=0.03490658503988659))
        annotation (Placement(transformation(extent={{-60,-80},{-40,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor1D10(
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=false),
        w(fixed=true))
        annotation (Placement(transformation(extent={{-8,-80},{12,-60}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring2(
                                                   c=1e4)
        annotation (Placement(transformation(extent={{-34,-80},{-14,-60}},
              rotation=0)));
    equation
      connect(world.frame_b, rotor1D1.frame_a) annotation (Line(
          points={{-80,30},{-60,30},{-60,40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, rotor1D2.frame_a) annotation (Line(
          points={{-80,30},{-30,30},{-30,40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, rotor1D3.frame_a) annotation (Line(
          points={{-80,30},{0,30},{0,40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, rotor1D4.frame_a) annotation (Line(
          points={{-80,30},{30,30},{30,40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(world.frame_b, rotor1D5.frame_a) annotation (Line(
          points={{-80,30},{-74,30},{-74,-8},{-50,-8},{-50,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(rotor1D5.frame_a, rotor1D6.frame_a) annotation (Line(
          points={{-50,0},{-50,-8},{2,-8},{2,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(spring.flange_a, rotor1D5.flange_b) annotation (Line(
          points={{-34,10},{-40,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring.flange_b, rotor1D6.flange_a) annotation (Line(
          points={{-14,10},{-8,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(world.frame_b, rotor1D7.frame_a) annotation (Line(
          points={{-80,30},{-74,30},{-74,-48},{-50,-48},{-50,-40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(rotor1D7.frame_a, rotor1D8.frame_a) annotation (Line(
          points={{-50,-40},{-50,-48},{2,-48},{2,-40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(spring1.flange_a, rotor1D7.flange_b) annotation (Line(
          points={{-34,-30},{-40,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring1.flange_b, rotor1D8.flange_a) annotation (Line(
          points={{-14,-30},{-8,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(world.frame_b, rotor1D9.frame_a) annotation (Line(
          points={{-80,30},{-74,30},{-74,-88},{-50,-88},{-50,-80}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(rotor1D9.frame_a, rotor1D10.frame_a) annotation (Line(
          points={{-50,-80},{-50,-88},{2,-88},{2,-80}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(spring2.flange_a, rotor1D9.flange_b) annotation (Line(
          points={{-34,-70},{-40,-70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring2.flange_b, rotor1D10.flange_a) annotation (Line(
          points={{-14,-70},{-8,-70}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        experiment(StopTime=1.1),
        experimentSetupOutput);
    end Rotor1D;

    model Joints

      inner Modelica.Mechanics.MultiBody.World world
        annotation (Placement(transformation(extent={{-80,60},{-60,80}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute(
        a(start=0.174532925199433, fixed=false),
        stateSelect=StateSelect.always,
        phi(fixed=true, start=0.7853981633974483),
        w(fixed=true, start=0.174532925199433))
                            annotation (Placement(transformation(extent={{-48,
                60},{-28,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox(r={1,0,0})
        annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute actuatedRevolute(
        a(start=-0.174532925199433, fixed=false),
        stateSelect=StateSelect.always,
        phi(fixed=true, start=0.5235987755982988),
        w(fixed=false, start=-0.174532925199433))
                            annotation (Placement(transformation(extent={{8,60},
                {28,80}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox1(r={1,0,0})
        annotation (Placement(transformation(extent={{36,60},{56,80}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(
        stateSelect=StateSelect.always,
        a(fixed=false, start=1),
        s(fixed=true, start=1),
        v(fixed=true, start=1),
        s_offset=0.1)       annotation (Placement(transformation(extent={{-48,
                20},{-28,40}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox2(r={1,0,0})
        annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Prismatic actuatedPrismatic(
        stateSelect=StateSelect.always,
        a(fixed=false, start=0.6),
        s(fixed=false, start=0.2),
        v(fixed=true, start=0.4))
                     annotation (Placement(transformation(extent={{8,20},{28,40}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Cylindrical cylindrical(
        stateSelect=StateSelect.always,
        a(fixed=false, start=4),
        phi(fixed=true, start=1.047197551196598),
        s(fixed=true, start=1),
        v(fixed=true, start=3),
        w(fixed=true, start=0.03490658503988659),
        wd(fixed=false, start=0.08726646259971647))
                            annotation (Placement(transformation(extent={{-50,
                -20},{-30,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox3(r={1,0,0})
        annotation (Placement(transformation(extent={{40,20},{60,40}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox4(r={1,0,0})
        annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Universal universal(
        a_a(start=0.5235987755982988, fixed=false),
        a_b(start=-0.5235987755982988, fixed=false),
        stateSelect=StateSelect.always,
        phi_a(fixed=true, start=-0.174532925199433),
        phi_b(fixed=true, start=0.174532925199433),
        w_a(fixed=false, start=0.3490658503988659),
        w_b(fixed=false, start=-0.3490658503988659))
                            annotation (Placement(transformation(extent={{8,-20},
                {28,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox5(r={1,0,0})
        annotation (Placement(transformation(extent={{38,-20},{58,0}}, rotation=
               0)));
      Modelica.Mechanics.MultiBody.Joints.Planar planar(
        stateSelect=StateSelect.always,
        a_x(fixed=false, start=2),
        a_y(fixed=false, start=1),
        phi(fixed=true, start=0.05235987755982989),
        s_x(fixed=true, start=1),
        s_y(fixed=true, start=2),
        v_x(fixed=true, start=1),
        v_y(fixed=true, start=2),
        w(fixed=true, start=0.0174532925199433),
        wd(fixed=false, start=0.03490658503988659))
                            annotation (Placement(transformation(extent={{-52,
                -50},{-32,-30}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox6(r={1,0,0})
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Spherical spherical(
        sequence_start={3,1,3},
        angles_start={0.3490658503988659,-0.5235987755982988,0.6981317007977318},
        angles_fixed=true,
        w_rel_a_fixed=true,
        z_rel_a_fixed=false,
        w_rel_a_start={0.0174532925199433,0.03490658503988659,
            0.05235987755982989},
        z_rel_a_start={0.03490658503988659,0.05235987755982989,
            0.06981317007977318})
                               annotation (Placement(transformation(extent={{8,
                -50},{28,-30}}, rotation=0)));

      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox7(r={1,0,0})
        annotation (Placement(transformation(extent={{38,-50},{58,-30}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox8(r={1,0,0})
        annotation (Placement(transformation(extent={{-20,-80},{0,-60}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.FreeMotion freeMotion(
        angles_start={0.3490658503988659,0.5235987755982988,0.6981317007977318},
        a_rel_a(fixed=false),
        angles_fixed=true,
        r_rel_a(fixed=true, start={1,1,1}),
        v_rel_a(fixed=true),
        w_rel_a_fixed=true,
        z_rel_a_fixed=false)     annotation (Placement(transformation(extent={{
                -56,-80},{-36,-60}}, rotation=0)));

    equation
      connect(world.frame_b, revolute.frame_a) annotation (Line(
          points={{-60,70},{-48,70}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(revolute.frame_b, bodyBox.frame_a) annotation (Line(
          points={{-28,70},{-20,70}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bodyBox.frame_b, actuatedRevolute.frame_a) annotation (Line(
          points={{0,70},{8,70}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(actuatedRevolute.frame_b, bodyBox1.frame_a) annotation (Line(
          points={{28,70},{36,70}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bodyBox1.frame_b, prismatic.frame_a) annotation (Line(
          points={{56,70},{66,70},{66,46},{-54,46},{-54,30},{-48,30}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(prismatic.frame_b, bodyBox2.frame_a) annotation (Line(
          points={{-28,30},{-20,30}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bodyBox2.frame_b, actuatedPrismatic.frame_a) annotation (Line(
          points={{0,30},{8,30}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(actuatedPrismatic.frame_b, bodyBox3.frame_a) annotation (Line(
          points={{28,30},{40,30}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bodyBox3.frame_b, cylindrical.frame_a) annotation (Line(
          points={{60,30},{74,30},{74,8},{-60,8},{-60,-10},{-50,-10}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(cylindrical.frame_b, bodyBox4.frame_a) annotation (Line(
          points={{-30,-10},{-20,-10}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bodyBox4.frame_b, universal.frame_a) annotation (Line(
          points={{0,-10},{8,-10}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(universal.frame_b, bodyBox5.frame_a) annotation (Line(
          points={{28,-10},{38,-10}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bodyBox5.frame_b, planar.frame_a) annotation (Line(
          points={{58,-10},{72,-10},{72,-26},{-60,-26},{-60,-40},{-52,-40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(planar.frame_b, bodyBox6.frame_a) annotation (Line(
          points={{-32,-40},{-20,-40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bodyBox6.frame_b, spherical.frame_a) annotation (Line(
          points={{0,-40},{8,-40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(spherical.frame_b, bodyBox7.frame_a) annotation (Line(
          points={{28,-40},{38,-40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(freeMotion.frame_a, bodyBox7.frame_b) annotation (Line(
          points={{-56,-70},{-60,-70},{-60,-54},{70,-54},{70,-40},{58,-40}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(freeMotion.frame_b, bodyBox8.frame_a) annotation (Line(
          points={{-36,-70},{-20,-70}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        experiment(StopTime=0.2),
        experimentSetupOutput);
    end Joints;

    model Bodies

      inner Modelica.Mechanics.MultiBody.World world
        annotation (Placement(transformation(extent={{-80,60},{-60,80}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body body(
        sequence_start={3,2,1},
        angles_start={0.3490658503988659,0.5235987755982988,0.6981317007977318},
        a_0(fixed=false, start={2,2,2}),
        angles_fixed=true,
        r_0(fixed=true, start={1,2,3}),
        v_0(fixed=true, start={1,2,3}),
        w_0_fixed=true,
        z_0_fixed=false,
        w_0_start={0.06981317007977318,0.05235987755982989,0.03490658503988659},
        z_0_start={0.05235987755982989,0.06981317007977318,0.05235987755982989})
                           annotation (Placement(transformation(extent={{-42,40},
                {-22,60}}, rotation=0)));

      Modelica.Mechanics.MultiBody.Parts.PointMass pointMass(
        m=2,
        a_0(fixed=false, start={5,4,3}),
        r_0(fixed=true, start={1,2,3}),
        v_0(fixed=true, start={2,3,4}))
             annotation (Placement(transformation(extent={{-2,-2},{18,18}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape body1(
        sequence_start={3,2,1},
        angles_start={0.3490658503988659,0.5235987755982988,0.6981317007977318},
        a_0(fixed=false, start={2,2,2}),
        angles_fixed=true,
        r_0(fixed=true, start={1,2,3}),
        v_0(fixed=true, start={1,2,3}),
        w_0_fixed=true,
        z_0_fixed=false,
        w_0_start={0.06981317007977318,0.05235987755982989,0.03490658503988659},
        z_0_start={0.05235987755982989,0.06981317007977318,0.05235987755982989})
                           annotation (Placement(transformation(extent={{0,40},
                {20,60}}, rotation=0)));

      Modelica.Mechanics.MultiBody.Parts.BodyBox body2(
        sequence_start={3,2,1},
        angles_start={0.3490658503988659,0.5235987755982988,0.6981317007977318},
        a_0(fixed=false, start={2,2,2}),
        angles_fixed=true,
        r_0(fixed=true, start={1,2,3}),
        v_0(fixed=true, start={1,2,3}),
        w_0_fixed=true,
        z_0_fixed=false,
        w_0_start={0.06981317007977318,0.05235987755982989,0.03490658503988659},
        z_0_start={0.05235987755982989,0.06981317007977318,0.05235987755982989})
                           annotation (Placement(transformation(extent={{42,40},
                {62,60}}, rotation=0)));

      Modelica.Mechanics.MultiBody.Parts.BodyCylinder body3(
        sequence_start={3,2,1},
        angles_start={0.3490658503988659,0.5235987755982988,0.6981317007977318},
        a_0(fixed=false, start={2,2,2}),
        angles_fixed=true,
        r_0(fixed=true, start={1,2,3}),
        v_0(fixed=true, start={1,2,3}),
        w_0_fixed=true,
        z_0_fixed=false,
        w_0_start={0.06981317007977318,0.05235987755982989,0.03490658503988659},
        z_0_start={0.05235987755982989,0.06981317007977318,0.05235987755982989})
                           annotation (Placement(transformation(extent={{-44,0},
                {-24,20}}, rotation=0)));

      annotation (experiment(StopTime=0.2), experimentSetupOutput);
    end Bodies;

    partial model Internal
      "Check whether Advanced/axisTorqueBalance,axisForceBalance parameter is correctely converted"

      ObsoleteModelica3.Mechanics.MultiBody.Joints.Internal.RevoluteWithLengthConstraint
        revoluteWithLengthConstraint1 annotation (Placement(transformation(
              extent={{-60,38},{-40,58}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Joints.Internal.PrismaticWithLengthConstraint
        prismaticWithLengthConstraint1 annotation (Placement(transformation(
              extent={{2,38},{22,58}}, rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Joints.Internal.RevoluteWithLengthConstraint
        revoluteWithLengthConstraint2
        annotation (Placement(transformation(extent={{-58,0},{-38,20}},
              rotation=0)));
      ObsoleteModelica3.Mechanics.MultiBody.Joints.Internal.PrismaticWithLengthConstraint
        prismaticWithLengthConstraint2
        annotation (Placement(transformation(extent={{4,0},{24,20}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Internal.RevoluteWithLengthConstraint
        revoluteWithLengthConstraint3
        annotation (Placement(transformation(extent={{-58,-40},{-38,-20}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Internal.PrismaticWithLengthConstraint
        prismaticWithLengthConstraint3
        annotation (Placement(transformation(extent={{4,-40},{24,-20}},
              rotation=0)));

    end Internal;
  end InitializationConversion;
end MultiBody;
