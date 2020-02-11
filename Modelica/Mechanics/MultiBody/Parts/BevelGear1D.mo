within Modelica.Mechanics.MultiBody.Parts;
model BevelGear1D
  "1D gearbox with arbitrary shaft directions and 3-dim. bearing frame (3D dynamic effects are taken into account provided world.driveTrainMechanics3D=true)"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;

  parameter Real ratio(start=1) "Gear speed ratio";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_a={1,0,0}
    "Axis of rotation of flange_a, resolved in frame_a"
    annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={1,0,0}
    "Axis of rotation of flange_b, resolved in frame_a"
    annotation (Evaluate=true);
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a if world.driveTrainMechanics3D
    "Bearing frame" annotation (Placement(transformation(
        origin={0,-100},
        extent={{-20,-20},{20,20}},
        rotation=90)));

protected
  outer World world;
  parameter Real e_a[3](each final unit="1")=
    Modelica.Math.Vectors.normalizeWithAssert(n_a)
    "Unit vector in direction of flange_a rotation axis";
  parameter Real e_b[3](each final unit="1")=
    Modelica.Math.Vectors.normalizeWithAssert(n_b)
    "Unit vector in direction of flange_b rotation axis";
  encapsulated model Housing
    import Modelica;
    input Modelica.Units.SI.Torque t[3];
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation (
        Placement(transformation(extent={{-116,-16},{-84,16}})));
  equation
    frame_a.f = zeros(3);
    frame_a.t = t;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),Text(
                extent={{-150,110},{150,150}},
                textColor={0,0,255},
                textString="%name")}));
  end Housing;
  Housing housing(t=-flange_a.tau*e_a - flange_b.tau*e_b) if world.driveTrainMechanics3D
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));

equation
  flange_a.phi = ratio*flange_b.phi;
  0 = ratio*flange_a.tau + flange_b.tau;
  connect(housing.frame_a, frame_a) annotation (Line(
      points={{20,-50},{0,-50},{0,-100}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
      Text(origin = {0,-40},
        textColor={0,0,255},
        extent = {{-150,150},{150,180}},
          textString="%name"),
      Text(origin = {0,-10},
        extent = {{-150,-66},{150,-36}},
          textString="ratio=%ratio"),
      Rectangle(origin = {-35,60},
        fillColor = {255,255,255},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-15,-40},{15,40}}),
      Rectangle(origin = {-35,0},
        fillColor = {255,255,255},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-15,-21},{15,21}}),
      Line(points = {{-80,20},{-60,20}}),
      Line(points = {{-80,-20},{-60,-20}}),
      Line(points = {{-70,-20},{-70,-86}}),
      Line(points = {{0,40},{0,-100}}),
      Line(points = {{-10,40},{10,40}}),
      Line(points = {{-10,80},{10,80}}),
      Line(points = {{60,-20},{80,-20}}),
      Line(points = {{60,20},{80,20}}),
      Line(points = {{70,-20},{70,-86}}),
      Line(points = {{70,-86},{-70,-86}}),
      Rectangle(origin = {-75,0},
        lineColor = {64,64,64},
        fillColor = {191,191,191},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-25,-10},{25,10}}),
      Rectangle(origin = {75,0},
        lineColor = {64,64,64},
        fillColor = {191,191,191},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-25,-10},{25,10}}),
      Rectangle(origin = {-35,-19},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {-35,-8},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {-35,19},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {-35,8},
        fillColor = {255,255,255},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {0,60},
        lineColor = {64,64,64},
        fillColor = {191,191,191},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-20,-10},{20,10}}),
      Rectangle(origin = {-35,98},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {-35,87},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {-35,50},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-4},{15,4}}),
      Rectangle(origin = {-35,22},
        fillColor = {102,102,102},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {-35,33},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {-35,70},
        fillColor = {255,255,255},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-4},{15,4}}),
      Rectangle(origin = {35,60},
        fillColor = {255,255,255},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-15,-21},{15,21}}),
      Rectangle(origin = {35,41},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {35,52},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {35,79},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {35,68},
        fillColor = {255,255,255},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {35,0},
        fillColor = {255,255,255},
        fillPattern = FillPattern.HorizontalCylinder,
        extent = {{-15,-40},{15,40}}),
      Rectangle(origin = {35,38},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {35,27},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {35,-10},
        fillColor = {204,204,204},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-4},{15,4}}),
      Rectangle(origin = {35,-38},
        fillColor = {102,102,102},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-2},{15,2}}),
      Rectangle(origin = {35,-27},
        fillColor = {153,153,153},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-3},{15,3}}),
      Rectangle(origin = {35,10},
        fillColor = {255,255,255},
        fillPattern = FillPattern.Solid,
        extent = {{-15,-4},{15,4}}),
      Rectangle(origin = {-35,40},
        fillColor = {255,255,255},
        extent = {{-15,-61},{15,60}}),
      Rectangle(origin={35,21},
        fillColor = {255,255,255},
        extent = {{-15,-61},{15,60}})}),
    Documentation(
        info="<html>
<p>This component is used to model a 1-dim. gearbox
with non-parallel axes (defined by parameters <code>n_a</code>, <code>n_b</code>).
A 3-dim. <code>bearing</code> frame is necessary to reflect the
correct support torque, as the axes of rotation of <code>flange_a</code> and
<code>flange_b</code> and the direction of the support torque vector
are different in general.</p>
<p>Note: The name BevelGear1D is kept only for simplicity. Regardless,
this component could be used to model any kind of gearbox with non-parallel axes.
For a usage example, see <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Rotational3DEffects.BevelGear1D\">Examples.Rotational3DEffects.BevelGear1D</a>.</p>

<p><strong>Reference</strong><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1-dim. Powertrains</a>. In: <em>Proceedings of the 3rd International
Modelica Conference</em>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158
</p>
</html>"));
end BevelGear1D;
