within Modelica.Mechanics.MultiBody.Examples.Elementary;
model ForceAndTorque "Demonstrate usage of ForceAndTorque element"
  extends Modelica.Icons.Example;
  inner World world(animateGravity=false) annotation (Placement(transformation(
          extent={{-90,30},{-70,50}}, rotation=0)));
  Parts.BodyCylinder body(r={1,0,0}) annotation (Placement(transformation(
          extent={{0,30},{20,50}}, rotation=0)));
  Parts.Fixed fixed1(r={0,-0.5,0}, width=0.03)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}}, rotation=
            0)));
  Parts.FixedRotation fixedRotation(n={0,0,1}, angle=30)
    annotation (Placement(transformation(extent={{-8,-30},{12,-10}}, rotation=0)));
  Forces.ForceAndTorque forceAndTorque(Nm_to_m=120, N_to_m=1200,
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
    annotation (Placement(transformation(extent={{60,50},{40,30}}, rotation=0)));
  Joints.Revolute revolute2(n={0,1,0},
    phi(fixed=true),
    w(fixed=true))        annotation (Placement(transformation(
        origin={-20,20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Constant torque[3](k={-100,100,0})
    annotation (Placement(transformation(
        origin={40,-10},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Joints.Revolute revolute1(phi(fixed=true), w(fixed=true))
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}}, rotation=
            0)));
  Parts.Fixed fixed2(width=0.03, r={1.5,0.25,0})
    annotation (Placement(transformation(extent={{100,30},{80,50}}, rotation=0)));
  Modelica.Blocks.Sources.Constant force[3](k={0,1000,0})
    annotation (Placement(transformation(
        origin={80,-10},
        extent={{10,-10},{-10,10}},
        rotation=270)));
equation
  connect(revolute2.frame_b, body.frame_a) annotation (Line(
      points={{-20,30},{-20,40},{0,40}},
      color={95,95,95},
      thickness=0.5));
  connect(forceAndTorque.frame_b, body.frame_b)
    annotation (Line(
      points={{40,40},{20,40}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed1.frame_b, revolute1.frame_a)
    annotation (Line(
      points={{-70,0},{-60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.frame_b, revolute2.frame_a)
    annotation (Line(
      points={{-40,0},{-20,0},{-20,10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed2.frame_b, forceAndTorque.frame_a)
    annotation (Line(
      points={{80,40},{60,40}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation.frame_a, fixed1.frame_b) annotation (Line(
      points={{-8,-20},{-65,-20},{-65,0},{-70,0}},
      color={95,95,95},
      thickness=0.5));
  connect(forceAndTorque.frame_resolve, fixedRotation.frame_b) annotation (Line(
      points={{42,30},{42,30},{20,30},{20,-20},{12,-20}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(force.y, forceAndTorque.force) annotation (Line(
      points={{80,1},{80,10},{58,10},{58,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(torque.y, forceAndTorque.torque) annotation (Line(
      points={{40,1},{40,10},{50,10},{50,28}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics),
    Documentation(info="<HTML>
In this example the usage of the general force element
\"<a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.ForceAndTorque\">ForceAndTorque</a>\"
is shown. A \"ForceAndTorque\" element is connected
between a body and a fixed point in the world system. The force and torque
is defined by the \"Constant\" block. The two vectors are resolved in the
coordinate system defined by the \"fixedRotation\" component that is
fixed in the world system:
</p>
<p>
The animation view at time = 0 is shown in the figure below.
The yellow line is directed from frame_a to frame_b of the
forceAndTorque component. The green arrow characterizes the
force acting at the body whereas the green double arrow characterizes
the torque acting at the body. The lengths of the two vectors
are proportional to the lengths of the force and torque vectors
(constant scaling factors are defined as parameters in the
forceAndTorque component):
</p>
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/ForceAndTorque.png\">
</HTML>
"));
end ForceAndTorque;
