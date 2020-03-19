within Modelica.Mechanics.Translational.Examples;
model GenerationOfFMUs
  "Example to demonstrate variants to generate FMUs (Functional Mock-up Units)"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine1(f=2, amplitude=10)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Mechanics.Translational.Examples.Utilities.DirectMass directMass(
      m=1.1) annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Mechanics.Translational.Examples.Utilities.InverseMass
    inverseMass(m=2.2)
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Mechanics.Translational.Examples.Utilities.SpringDamper
    springDamper(c=1e4, d=100)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Mechanics.Translational.Components.Mass mass2a(
    m=1.1,
    s(fixed=true, start=0),
    v(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  Modelica.Mechanics.Translational.Sources.Force force2
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition2a(use_pder2=false)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Mechanics.Translational.Components.Mass mass2b(
    m=2.2,
    s(fixed=true, start=0),
    v(fixed=true, start=0))
    annotation (Placement(transformation(extent={{70,-20},{90,0}})));
  Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition2b(use_pder2=false)
    annotation (Placement(transformation(extent={{70,-20},{50,0}})));
  Modelica.Mechanics.Translational.Examples.Utilities.Spring spring(c=1e4)
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Mechanics.Translational.Components.Mass mass3a(
    m=1.1,
    s(fixed=true, start=0),
    v(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
  Modelica.Mechanics.Translational.Sources.Force force3
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition3a(use_pder=false, use_pder2=false)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Mechanics.Translational.Components.Mass mass3b(
    m=2.2,
    s(fixed=true, start=0),
    v(fixed=true, start=0))
    annotation (Placement(transformation(extent={{70,-80},{90,-60}})));
  Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition3b(use_pder=false, use_pder2=false)
    annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
equation
  connect(sine1.y, directMass.fDrive)
    annotation (Line(points={{-79,50},{-2,50}},  color={0,0,127}));
  connect(directMass.s, inverseMass.s)
    annotation (Line(points={{21,58},{38,58}},color={0,0,127}));
  connect(directMass.v,inverseMass.v)
    annotation (Line(points={{21,53},{30,53},{30,55},{38,55}},
                                              color={0,0,127}));
  connect(directMass.a, inverseMass.a)
    annotation (Line(points={{21,47},{30,47},{30,45},{38,45}},
                                              color={0,0,127}));
  connect(inverseMass.f, directMass.f)
    annotation (Line(points={{39,42},{22,42}}, color={0,0,127}));
  connect(force2.flange, mass2a.flange_a)
    annotation (Line(points={{-40,-10},{-30,-10}}, color={0,127,0}));
  connect(mass2a.flange_b, forceToPosition2a.flange)
    annotation (Line(points={{-10,-10},{-2,-10}},  color={0,127,0}));
  connect(forceToPosition2b.flange, mass2b.flange_a)
    annotation (Line(points={{62,-10},{70,-10}}, color={0,127,0}));
  connect(force3.flange, mass3a.flange_a)
    annotation (Line(points={{-40,-70},{-30,-70}}, color={0,127,0}));
  connect(mass3a.flange_b, forceToPosition3a.flange)
    annotation (Line(points={{-10,-70},{-2,-70}},  color={0,127,0}));
  connect(forceToPosition3b.flange, mass3b.flange_a)
    annotation (Line(points={{62,-70},{70,-70}}, color={0,127,0}));
  connect(forceToPosition2a.f, springDamper.f1)
    annotation (Line(points={{3,-18},{19,-18}}, color={0,0,127}));
  connect(springDamper.f2, forceToPosition2b.f)
    annotation (Line(points={{41,-18},{57,-18}}, color={0,0,127}));
  connect(forceToPosition3a.f, spring.f1)
    annotation (Line(points={{3,-78},{19,-78}}, color={0,0,127}));
  connect(spring.f2, forceToPosition3b.f)
    annotation (Line(points={{41,-78},{57,-78}}, color={0,0,127}));
  connect(forceToPosition3a.p, spring.s1)
    annotation (Line(points={{3,-62},{18,-62}}, color={0,0,127}));
  connect(spring.s2, forceToPosition3b.p)
    annotation (Line(points={{42,-62},{57,-62}}, color={0,0,127}));
  connect(forceToPosition2a.p, springDamper.s1)
    annotation (Line(points={{3,-2},{18,-2}}, color={0,0,127}));
  connect(forceToPosition2a.pder, springDamper.v1) annotation (Line(
        points={{3,-5},{10,-5},{10,-5},{18,-5}},
                                               color={0,0,127}));
  connect(springDamper.s2, forceToPosition2b.p)
    annotation (Line(points={{42,-2},{57,-2}}, color={0,0,127}));
  connect(forceToPosition2b.pder, springDamper.v2) annotation (Line(
        points={{57,-5},{50,-5},{50,-5},{42,-5}}, color={0,0,127}));
  connect(sine1.y, force2.f) annotation (Line(points={{-79,50},{-70,50},
          {-70,-10},{-62,-10}}, color={0,0,127}));
  connect(sine1.y, force3.f) annotation (Line(points={{-79,50},{-70,50},
          {-70,-70},{-62,-70}}, color={0,0,127}));
  annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>
This example demonstrates how to generate an input/output block (e.g. in form of an
FMU - <a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>) from various Translational components.
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
<strong>Connecting two masses</strong><br>
The upper part (DirectMass, InverseMass)
demonstrates how to export two masses and connect them
together in a target system. This requires that one of the masses
(here: DirectMass)
is defined to have states and the position, velocity and
acceleration are provided in the interface.
The other mass (here: InverseMass) is moved according
to the provided input position, velocity and acceleration.
</p>

<p>
<strong>Connecting a force element that needs position and velocities</strong><br>
The middle part (SpringDamper) demonstrates how to export a force element
that needs both position and velocities for its force law and connect this
force law in a target system between two masses.
</p>

<p>
<strong>Connecting a force element that needs only positions</strong><br>
The lower part (Spring) demonstrates how to export a force element
that needs only positions for its force law and connect this
force law in a target system between two masses.
</p>
</html>"));
end GenerationOfFMUs;
