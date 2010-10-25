within Modelica.Mechanics.MultiBody.Examples.Elementary;
model PointGravity "Two point masses in a point gravity field"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(
    mue=1,
    gravitySphereDiameter=0.1,
    gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity)
                               annotation (Placement(transformation(extent={{
            -20,-20},{0,0}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    m=1,
    sphereDiameter=0.1,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    r_0(start={0,0.6,0}, fixed=true),
    v_0(start={1,0,0}, fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    r_CM={0,0,0})
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body body2(
    m=1,
    sphereDiameter=0.1,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    r_0(start={0.6,0.6,0}, fixed=true),
    v_0(start={0.6,0,0}, fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    r_CM={0,0,0})
    annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
equation

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}),
            graphics),
    experiment(StopTime=5),
    Documentation(info="<HTML>
<p>
This model demonstrates a point gravity field. Two bodies
are placed in the gravity field. The initial positions and velocities of
these bodies are selected such that one body rotates on a circle and
the other body rotates on an ellipse around the center of the
point gravity field.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Elementary/PointGravity.png\"
ALT=\"model Examples.Elementary.PointGravity\">
</HTML>"));
end PointGravity;
