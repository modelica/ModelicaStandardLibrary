within Modelica.Mechanics.MultiBody.Examples.Elementary;
model UserDefinedGravityField
  "Demonstrate the modeling of a user-defined gravity field"
   extends Modelica.Icons.Example;
   parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg geodeticLatitude = 0
    "Geodetic latitude";
   parameter Modelica.SIunits.Position height = 20
    "Height of pendulum attachment point over WGS84 earth ellipsoid";
   Modelica.SIunits.Acceleration gravity[3]=body.g_0
    "Gravity acceleration at center of mass of body";
  inner Modelica.Mechanics.MultiBody.World world(
    gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity,
      redeclare function gravityAcceleration =
        Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities.theoreticalNormalGravityWGS84
        (mue=1, phi=geodeticLatitude),
    axisLength=10,
    nominalLength=10)              annotation (Placement(transformation(extent={{-80,-20},
            {-60,0}},        rotation=0)));
  Joints.Revolute rev(n={0,0,1},useAxisFlange=true,
    phi(fixed=true),
    w(fixed=true))             annotation (Placement(transformation(extent={{-14,20},
            {6,40}},        rotation=0)));
  Rotational.Components.Damper damper(d=0.1)
    annotation (Placement(transformation(extent={{-14,60},{6,80}}, rotation=0)));
  Parts.Body body(r_CM={10,0,0},
    m=1000.0,
    sphereDiameter=1)
    annotation (Placement(transformation(extent={{26,20},{46,40}},rotation=0)));
  Parts.FixedTranslation fixedTranslation(r={0,height,0}, width=0.3)
                                                     annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,8})));
equation
  connect(damper.flange_b,rev. axis) annotation (Line(points={{6,70},{10,70},{10,
          46},{-4,46},{-4,40}},   color={0,0,0}));
  connect(rev.support,damper. flange_a) annotation (Line(points={{-10,40},{-10,46},
          {-22,46},{-22,70},{-14,70}},     color={0,0,0}));
  connect(body.frame_a,rev. frame_b) annotation (Line(
      points={{26,30},{6,30}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-60,-10},{-40,-10},{-40,-2}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation.frame_b, rev.frame_a) annotation (Line(
      points={{-40,18},{-40,30},{-14,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (experiment(StopTime=10, Tolerance=1e-008),
                                      experimentSetupOutput,
    Diagram(graphics),
    Documentation(info="<html>
<p>
This example demonstrates a user defined gravity field.
Function \"world.gravityAcceleration\" is redeclared to function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities.theoreticalNormalGravityWGS84\">theoreticalNormalGravityWGS84</a>
that computes the theoretical gravity of the
<a href=\"http://earth-info.nga.mil/GandG/publications/tr8350.2/wgs84fin.pdf\">WGS84 ellipsoid earth model</a> at and close to
the earth ellipsoid surface. In the gravity field, a large, single pendulum is present. Via parameter \"geodeticLatitude\", the geodetic latitude on the earth can be defined, where the pendulum is present. The world frame is located at the WGS84 earth ellipsoid at this latitude. The result variable
\"gravity\" is the gravity vector at the center of mass of the pendulum mass.
Since the height of this mass is changing, the value of the gravity is also changing
(the difference is in the order of 0.00001).
</p>

<p>
The result of the simulation is slightly different at the equator (geodeticLatitude=0)
and at the poles (geodeticLatitude=90). For example, after 10 s of simulation time
the rotation angle of the pendulum, rev.phi, has the following values:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td><b><i>latitude [deg]</i></b></td>
    <td><b><i>rev.phi [rad]</i></b></td></tr>
<tr><td> = 0</td>
    <td>= -2.39 rad</td></tr>

<tr><td>= 90</td>
    <td>= -2.42 rad</td></tr>
</table>
</html>"));
end UserDefinedGravityField;
