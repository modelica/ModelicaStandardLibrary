within Modelica.Mechanics.Rotational.Examples;
model GenerationOfFMUs
  "Example to demonstrate variants to generate FMUs (Functional Mock-up Units)"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine1(f=2, amplitude=10)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Mechanics.Rotational.Examples.Utilities.DirectInertia
    directInertia(J=1.1)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Mechanics.Rotational.Examples.Utilities.InverseInertia
    inverseInertia(J=2.2)
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Mechanics.Rotational.Examples.Utilities.SpringDamper
    springDamper(c=1e4, d=100)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2a(
    J=1.1,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque2
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Components.TorqueToAngleAdaptor
    torqueToAngle2a(use_a=false)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2b(
    J=2.2,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{70,-20},{90,0}})));
  Components.TorqueToAngleAdaptor
    torqueToAngle2b(use_a=false)
    annotation (Placement(transformation(extent={{70,-20},{50,0}})));
  Modelica.Mechanics.Rotational.Examples.Utilities.Spring spring(c=1e4)
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia3a(
    J=1.1,
    phi(fixed=true, start=0),
    w(fixed=true, start=0)) annotation (Placement(transformation(extent=
           {{-30,-80},{-10,-60}})));
  Modelica.Mechanics.Rotational.Sources.Torque   force3
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Components.TorqueToAngleAdaptor
    torqueToAngle3a(use_w=false, use_a=false)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia3b(
    J=2.2,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{70,-80},{90,-60}})));
  Components.TorqueToAngleAdaptor
    torqueToAngle3b(use_w=false, use_a=false)
    annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
equation
  connect(sine1.y, directInertia.tauDrive)
    annotation (Line(points={{-79,50},{-2,50}}, color={0,0,127}));
  connect(directInertia.phi, inverseInertia.phi)
    annotation (Line(points={{21,58},{38,58}}, color={0,0,127}));
  connect(directInertia.w, inverseInertia.w)
    annotation (Line(points={{21,53},{38,53}}, color={0,0,127}));
  connect(directInertia.a, inverseInertia.a)
    annotation (Line(points={{21,47},{38,47}}, color={0,0,127}));
  connect(inverseInertia.tau, directInertia.tau)
    annotation (Line(points={{39,42},{22,42}}, color={0,0,127}));
  connect(sine1.y, torque2.tau) annotation (Line(points={{-79,50},{-70,
          50},{-70,-10},{-62,-10}}, color={0,0,127}));
  connect(sine1.y, force3.tau) annotation (Line(points={{-79,50},{-70,
          50},{-70,-70},{-62,-70}}, color={0,0,127}));
  connect(torqueToAngle2b.flange, inertia2b.flange_a)
    annotation (Line(points={{62,-10},{70,-10}}));
  connect(inertia2a.flange_b, torqueToAngle2a.flange)
    annotation (Line(points={{-10,-10},{-2,-10}}));
  connect(torque2.flange, inertia2a.flange_a)
    annotation (Line(points={{-40,-10},{-30,-10}}));
  connect(inertia3a.flange_b, torqueToAngle3a.flange)
    annotation (Line(points={{-10,-70},{-2,-70}}));
  connect(force3.flange, inertia3a.flange_a)
    annotation (Line(points={{-40,-70},{-30,-70}}));
  connect(torqueToAngle3b.flange, inertia3b.flange_a)
    annotation (Line(points={{62,-70},{70,-70}}));
  connect(torqueToAngle2a.phi, springDamper.phi1)
    annotation (Line(points={{3,-2},{18,-2}}, color={0,0,127}));
  connect(torqueToAngle2a.w, springDamper.w1) annotation (Line(points={{3,
          -7},{10.5,-7},{10.5,-7},{18,-7}}, color={0,0,127}));
  connect(torqueToAngle2a.tau, springDamper.tau1)
    annotation (Line(points={{4,-18},{19,-18}}, color={0,0,127}));
  connect(springDamper.tau2, torqueToAngle2b.tau)
    annotation (Line(points={{41,-18},{56,-18}}, color={0,0,127}));
  connect(springDamper.phi2, torqueToAngle2b.phi)
    annotation (Line(points={{42,-2},{57,-2}}, color={0,0,127}));
  connect(springDamper.w2, torqueToAngle2b.w) annotation (Line(points={{42,
          -7},{50,-7},{50,-7},{57,-7}}, color={0,0,127}));
  connect(torqueToAngle3a.phi, spring.phi1)
    annotation (Line(points={{3,-62},{18,-62}}, color={0,0,127}));
  connect(torqueToAngle3a.tau, spring.tau1)
    annotation (Line(points={{4,-78},{19,-78}}, color={0,0,127}));
  connect(spring.phi2, torqueToAngle3b.phi)
    annotation (Line(points={{42,-62},{57,-62}}, color={0,0,127}));
  connect(spring.tau2, torqueToAngle3b.tau)
    annotation (Line(points={{41,-78},{56,-78}}, color={0,0,127}));
  annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>
This example demonstrates how to generate an input/output block (e.g. in form of an
FMU - <a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>) from various Rotational components.
The goal is to export such an input/output block from Modelica and import
it in another modeling environment. The essential issue is that before
exporting it must be known in which way the component is utilized in the
target environment. Depending on the target usage, different flange variables
need to be in the interface with either input or output causality.
Note, this example model can be used to test the FMU export/import of a Modelica tool.
Just export the components marked in the icons as \"toFMU\" as FMUs and import
them back. The models should then still work and give the same results as a
pure Modelica model.
</p>

<p>
<strong>Connecting two inertias</strong><br>
The upper part (DirectInertia, InverseInertia)
demonstrates how to export two inertias and connect them
together in a target system. This requires that one of the inertias
(here: DirectInertia)
is defined to have states and the angle, angular velocity and
angular acceleration are provided in the interface.
The other mass (here: InverseInertia) is moved according
to the provided input angle, angular velocity and angular acceleration.
</p>

<p>
<strong>Connecting a force element that needs angles and angular velocities</strong><br>
The middle part (SpringDamper) demonstrates how to export a force element
that needs both angles and angular velocities for its force law and connect this
force law in a target system between two inertias.
</p>

<p>
<strong>Connecting a force element that needs only angles</strong><br>
The lower part (Spring) demonstrates how to export a force element
that needs only angles for its force law and connect this
force law in a target system between two inertias.
</p>
</html>"));
end GenerationOfFMUs;
