model PointGravity "Two point masses in a point gravity field" 
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  inner MultiBody.World world(
    gravityType=2,
    mue=1,
    gravitySphereDiameter=0.1) annotation (extent=[-20, -20; 0, 0]);
  MultiBody.Parts.Body body1(
    m=1,
    v_0_start={1,0,0},
    r_0_start={0,0.6,0},
    sphereDiameter=0.1,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    initType=MultiBody.Types.Init.PositionVelocity) 
    annotation (extent=[-20, 20; 0, 40]);
  MultiBody.Parts.Body body2(
    m=1,
    r_0_start={0.6,0.6,0},
    v_0_start={0.6,0,0},
    sphereDiameter=0.1,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    initType=MultiBody.Types.Init.PositionVelocity) 
    annotation (extent=[20, 20; 40, 40]);
equation 
  
  annotation (
    Diagram,
    experiment(StopTime=5),
    Documentation(info="<HTML>
<p>
This model demonstrates a point gravity field. Two bodies
are placed in the gravity field. The initial positions and velocities of 
these bodies are selected such that one body rotates on a circle and
the other body rotates on an ellipse around the center of the
point gravity field.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/PointGravity.png\" 
ALT=\"model Examples.Elementary.PointGravity\">
</p>
</HTML>"));
end PointGravity;
