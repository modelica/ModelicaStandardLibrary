within Modelica.Mechanics.MultiBody.Examples.Elementary;
model PointGravityWithPointMasses
  "Two point masses in a point gravity field (rotation of bodies is neglected)"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(
    mue=1,
    gravitySphereDiameter=0.1,
    gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity)
                               annotation (Placement(transformation(extent={{-80,-20},
            {-60,0}},        rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.PointMass body1(
    m=1,
    sphereDiameter=0.1,
    r_0(start={0,0.6,0}, fixed=true),
    v_0(start={1,0,0}, fixed=true))
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.PointMass body2(
    m=1,
    sphereDiameter=0.1,
    r_0(start={0.6,0.6,0}, fixed=true),
    v_0(start={0.6,0,0}, fixed=true))
    annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.PointMass body3(
    m=1,
    sphereDiameter=0.1,
    r_0(start={0,0.8,0}, fixed=true),
    v_0(start={0.6,0,0}, fixed=true))
    annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.PointMass body4(
    m=1,
    sphereDiameter=0.1,
    r_0(start={0.3,0.8,0}, fixed=true),
    v_0(start={0.6,0,0}, fixed=true))
    annotation (Placement(transformation(extent={{20,60},{40,80}}, rotation=0)));
  Forces.Spring spring(showMass=false, c=10,
    fixedRotationAtFrame_b=true,
    fixedRotationAtFrame_a=true)             annotation (Placement(
        transformation(extent={{0,60},{20,80}}, rotation=0)));
equation

  connect(spring.frame_a, body3.frame_a) annotation (Line(
      points={{0,70},{-10,70}},
      color={95,95,95},
      thickness=0.5));
  connect(spring.frame_b, body4.frame_a) annotation (Line(
      points={{20,70},{30,70}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}),
            graphics),
    experiment(StopTime=2),
    Documentation(info="<HTML>
<p>
This model demonstrates the usage of model Parts.PointMass in a
point gravity field. The PointMass model has the feature that
that rotation is not taken into account and can therefore also not be
calculated. This example demonstrates two cases where this does not matter:
If a PointMass is not connected (body1, body2), the orientation object in
these point masses is set to a unit rotation.
If a PointMass is connected by a line force element, such as
the used Forces.LineForceWithMass component, then the orientation object
is set to a unit rotation within the line force element.
These are the two cases where the rotation is automatically set to
a default value, when the physical system does not provide the equations.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Elementary/PointGravityWithPointMasses.png\">
</HTML>"));
end PointGravityWithPointMasses;
