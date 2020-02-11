within Modelica.Mechanics.MultiBody.Parts;
model Mounting1D
  "Propagate 1-dim. support torque to 3-dim. system (provided world.driveTrainMechanics3D=true)"
  parameter SI.Angle phi0=0 "Fixed offset angle of housing";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0}
    "Axis of rotation = axis of support torque (resolved in frame_a)"
     annotation (Evaluate=true);
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
    "(right) flange fixed in housing" annotation (Placement(transformation(
          extent={{110,10},{90,-10}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a if world.driveTrainMechanics3D
    "Frame in which housing is fixed (connector is removed, if world.driveTrainMechanics3D=false)"
    annotation (Placement(transformation(
        origin={0,-100},
        extent={{-20,-20},{20,20}},
        rotation=90)));
protected
  outer Modelica.Mechanics.MultiBody.World world;

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
  Housing housing(t=-n*flange_b.tau) if world.driveTrainMechanics3D
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
equation
  flange_b.phi = phi0;
  connect(housing.frame_a, frame_a) annotation (Line(
      points={{20,-50},{0,-50},{0,-100}},
      color={95,95,95},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-80,-60},{80,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,60},{150,20}},
          textColor={0,0,255},
          textString="%name"),
        Line(points={{80,-60},{40,-100}}),
        Line(points={{40,-60},{0,-100}}),
        Line(points={{0,-60},{-40,-100}}),
        Line(points={{-40,-60},{-80,-100}}),
        Line(points={{0,-60},{0,0}}),
        Line(points={{0,0},{90,0}})}), Documentation(info="<html>
<p>This component is used to acquire support torques from a 1-dim.-rotational
mechanical system (e.g., components from Modelica.Mechanics.Rotational)
and to propagate them to a carrier body.</p>
<p>The 1-dim. support torque at <code>flange_b</code> is transformed into 3-dim. space under
consideration of the rotation axis, parameter <code>n</code>, which has to be given in the
local coordinate system of <code>frame_a</code>.</p>
<p>All components of a 1-dim.-rotational mechanical system that are connected to <strong>a</strong> common
<strong>Mounting1D</strong> element need to have the same axis of rotation
along parameter vector <code>n</code>. This means that, e.g., bevel
gears where the axis of rotation of <code>flange_a</code> and
<code>flange_b</code> are different cannot be described properly by
connecting to the <strong>Mounting1D</strong> component. In this case, a combination of several
<strong>Mounting1D</strong> components or the component <strong>BevelGear1D</strong> should be used.</p>
<p><strong>Reference</strong><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1-dim. Powertrains</a>. In: <em>Proceedings of the 3rd International
Modelica Conference</em>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>
</html>"));
end Mounting1D;
