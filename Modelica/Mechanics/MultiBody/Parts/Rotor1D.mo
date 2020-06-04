within Modelica.Mechanics.MultiBody.Parts;
model Rotor1D
  "1D inertia attachable on 3-dim. bodies (3D dynamic effects are taken into account if world.driveTrainMechanics3D=true)"

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show rotor as cylinder)";
  parameter SI.Inertia J(min=0,start=1)
    "Moment of inertia of rotor around its axis of rotation";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0}
    "Axis of rotation resolved in frame_a"
      annotation (Evaluate=true);
  parameter SI.Position r_center[3]=zeros(3)
    "Position vector from origin of frame_a to center of cylinder"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Distance cylinderLength=2*world.defaultJointLength
    "Length of cylinder representing the rotor" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Distance cylinderDiameter=2*world.defaultJointWidth
    "Diameter of cylinder representing the rotor" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  input Modelica.Mechanics.MultiBody.Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
    "Color of cylinder representing the rotor" annotation (Dialog(
      colorSelector=true,
      tab="Animation",
      group="if animation = true",
      enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient=world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use rotor angle (phi) and rotor speed (w) as states"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean exact=true
    "= true, if exact calculations; false if influence of bearing on rotor acceleration is neglected to avoid an algebraic loop"
    annotation (Evaluate=true, Dialog(tab="Advanced"));

  SI.Angle phi(start=0, stateSelect=stateSelect)
    "Rotation angle of rotor with respect to frame_a (= flange_a.phi = flange_b.phi)";
  SI.AngularVelocity w(start=0, stateSelect=stateSelect)
    "Angular velocity of rotor with respect to frame_a";
  SI.AngularAcceleration a(start=0)
    "Angular acceleration of rotor with respect to frame_a";

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    "(left) driving flange (flange axis directed INTO cut plane)" annotation (
     Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
    "(right) driven flange (flange axis directed OUT OF cut plane)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a if world.driveTrainMechanics3D
    "Frame in which rotor housing is fixed (connector is removed, if world.driveTrainMechanics3D=false)"
    annotation (Placement(transformation(
        origin={0,-100},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  encapsulated model RotorWith3DEffects
    "1D inertia attachable on 3-dim. bodies (3D dynamic effects are taken into account)"

    import Modelica;
    import Modelica.Units.SI;
    import Modelica.Mechanics.MultiBody.Frames;
    import Modelica.Mechanics.MultiBody.Types;

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show rotor as cylinder)";
    parameter SI.Inertia J(min=0) = 1
      "Moment of inertia of rotor around its axis of rotation";
    parameter Types.Axis n={1,0,0} "Axis of rotation resolved in frame_a";
    parameter SI.Position r_center[3]=zeros(3)
      "Position vector from origin of frame_a to center of cylinder"
      annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    parameter SI.Distance cylinderLength=2*world.defaultJointLength
      "Length of cylinder representing the rotor" annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    parameter SI.Distance cylinderDiameter=2*world.defaultJointWidth
      "Diameter of cylinder representing the rotor" annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
      "Color of cylinder representing the rotor" annotation (Dialog(
        colorSelector=true,
        tab="Animation",
        group="if animation = true",
        enable=animation));
    input Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    parameter StateSelect stateSelect=StateSelect.default
      "Priority to use rotor angle (phi) and rotor speed (w) as states"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean exact=true
      "= true, if exact calculations; false if influence of bearing on rotor acceleration is neglected to avoid an algebraic loop"
      annotation (Evaluate=true, Dialog(tab="Advanced"));

    SI.AngularVelocity w_a[3]
      "Angular velocity of frame_a, resolved in frame_a";
    SI.Angle phi(start=0, final stateSelect=stateSelect)
      "Rotation angle of rotor with respect to frame_a (= flange_a.phi = flange_b.phi)"
      annotation (Dialog(showStartAttribute=true));

    SI.AngularVelocity w(start=0, stateSelect=stateSelect)
      "Angular velocity of rotor with respect to frame_a"
      annotation (Dialog(showStartAttribute=true));
    SI.AngularAcceleration a(start=0)
      "Angular acceleration of rotor with respect to frame_a"
      annotation (Dialog(showStartAttribute=true));

    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
      "(left) driving flange (flange axis directed INTO cut plane)"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
      "(right) driven flange (flange axis directed OUT OF cut plane)"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
      "Frame in which rotor housing is fixed" annotation (Placement(
          transformation(
          origin={0,-100},
          extent={{-20,-20},{20,20}},
          rotation=90)));

  protected
    outer Modelica.Mechanics.MultiBody.World world;
    parameter Real e[3](each final unit="1")=
      Modelica.Math.Vectors.normalizeWithAssert(n)
      "Unit vector in direction of rotor axis, resolved in frame_a";
    parameter SI.Inertia nJ[3]=J*e;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinder(
      shapeType="cylinder",
      color=cylinderColor,
      specularCoefficient=specularCoefficient,
      length=cylinderLength,
      width=cylinderDiameter,
      height=cylinderDiameter,
      lengthDirection=n,
      widthDirection={0,1,0},
      extra=1,
      r_shape=r_center - e*(cylinderLength/2),
      r=frame_a.r_0,
      R=Frames.absoluteRotation(frame_a.R, Frames.planarRotation(
              e,
              phi,
              0))) if world.enableAnimation and animation;
  equation
    phi = flange_a.phi;
    phi = flange_b.phi;
    w = der(phi);
    a = der(w);

    w_a = Modelica.Mechanics.MultiBody.Frames.angularVelocity2(frame_a.R);
    if exact then
      J*a = flange_a.tau + flange_b.tau - nJ*der(w_a);
    else
      J*a = flange_a.tau + flange_b.tau;
    end if;

    /* Reaction torque:
        t = n*(J*a - flange_a.tau - flange_b.tau) + cross(w_a, nJ*w)

     Since
        J*a = flange_a.tau + flange_b.tau - nJ*der(w_a);

     the reaction torque can be simplified to
        t = n*(- nJ*der(w_a)) + cross(w_a, nJ*w)

  */
    frame_a.f = zeros(3);
    frame_a.t = cross(w_a, nJ*w) - e*(nJ*der(w_a));
    annotation (Documentation(info="<html>
<p>
This component is used to model the gyroscopic torques exerted by a 1-dim.
inertia (so called <em>rotor</em>) on its 3-dim. carrier body. Gyroscopic torques
appear, if the vector of the carrier body's angular velocity is not parallel
to the vector of the rotor's axis. The axis of rotation of the rotor is defined by
the parameter <code>n</code>, which has to be given in the local coordinate system
of <code>frame_a</code>. The default animation of this component is
shown in the figure below.</p>

<div>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Rotor1D.png\" alt=\"model Parts.Rotor1D\">
</div>

<p>This component is a replacement for
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.Inertia\">Modelica.Mechanics.Rotational.Components.Inertia</a>
for the case, that a 1-dim.-rotational mechanical system should be attached with a 3-dim.
carrier body.</p>
<p>The Boolean parameter <code>exact</code> was introduced due to performance
reasons. If <code>exact</code> is set to <strong>false</strong>, the influence of the carrier body
motion on the angular velocity of the rotor is neglected. This influence is usually
negligible if the 1-dim.-rotational mechanical system accelerates much faster as the base body (this is,
e.g., the case in vehicle powertrains). The essential advantage is
that an algebraic loop is removed since then there is only an
action on acceleration level from the powertrain to the base body
but not vice versa.</p>
<p><strong>Reference</strong><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1-dim. Powertrains</a>. In: <em>Proceedings of the 3rd International
Modelica Conference</em>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-100,10},{100,-10}},
            lineColor={64,64,64},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Line(points={{-80,-25},{-60,-25}}),
          Line(points={{60,-25},{80,-25}}),
          Line(points={{-70,-25},{-70,-70}}),
          Line(points={{70,-25},{70,-70}}),
          Line(points={{-80,25},{-60,25}}),
          Line(points={{60,25},{80,25}}),
          Line(points={{-70,45},{-70,25}}),
          Line(points={{70,45},{70,25}}),
          Line(points={{-70,-70},{70,-70}}),
          Rectangle(
            extent={{-50,50},{50,-50}},
            lineColor={64,64,64},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={255,255,255},
            radius=10),
          Rectangle(
            extent={{-50,50},{50,-50}},
            lineColor={64,64,64},
            radius=10),
          Text(
            extent={{-148,112},{152,72}},
            textString="%name=%J",
            textColor={0,0,255}),
          Line(points={{0,-70},{0,-100}})}));
  end RotorWith3DEffects;

protected
  outer Modelica.Mechanics.MultiBody.World world;
  parameter Real e[3](each final unit="1")=
    Modelica.Math.Vectors.normalizeWithAssert(n)
    "Unit vector in direction of rotor axis, resolved in frame_a";
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color=cylinderColor,
    specularCoefficient=specularCoefficient,
    length=cylinderLength,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection=n,
    widthDirection={0,1,0},
    extra=1,
    r_shape=r_center - e*(cylinderLength/2),
    r=zeros(3),
    R=Modelica.Mechanics.MultiBody.Frames.planarRotation(
          e,
          phi,
          0)) if world.enableAnimation and animation and not world.driveTrainMechanics3D;

  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J, stateSelect=
        StateSelect.never) if not world.driveTrainMechanics3D annotation (
      Placement(transformation(extent={{-20,-20},{20,20}})));
  RotorWith3DEffects rotorWith3DEffects(
    animation=animation,
    J=J,
    n=n,
    r_center=r_center,
    cylinderLength=cylinderLength,
    cylinderDiameter=cylinderDiameter,
    cylinderColor=cylinderColor,
    specularCoefficient=specularCoefficient,
    exact=exact,
    stateSelect=StateSelect.never) if world.driveTrainMechanics3D annotation (
     Placement(transformation(extent={{-20,-80},{20,-40}})));
equation
  phi = flange_a.phi;
  w = der(phi);
  a = der(w);

  connect(inertia.flange_a, flange_a) annotation (Line(
      points={{-20,0},{-100,0}}));
  connect(inertia.flange_b, flange_b) annotation (Line(
      points={{20,0},{100,0}}));
  connect(rotorWith3DEffects.flange_b, flange_b) annotation (Line(
      points={{20,-60},{60,-60},{60,0},{100,0}}));
  connect(rotorWith3DEffects.flange_a, flange_a) annotation (Line(
      points={{-20,-60},{-60,-60},{-60,0},{-100,0}}));
  connect(rotorWith3DEffects.frame_a, frame_a) annotation (Line(
      points={{0,-80},{0,-100}},
      color={95,95,95},
      thickness=0.5));
  annotation (Documentation(info="<html>
<p>This component is used to model the gyroscopic torques exerted by a 1-dim.
inertia (so called <em>rotor</em>) on its 3-dim. carrier body. Gyroscopic torques
appear, if the vector of the carrier body's angular velocity is not parallel
to the vector of the rotor's axis. The axis of rotation of the rotor is defined by
the parameter <code>n</code>, which has to be given in the local coordinate system
of <code>frame_a</code>. The default animation of this component is
shown in the figure below.</p>
<div>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Rotor1D.png\" alt=\"model Parts.Rotor1D\">
</div>
<p>This component is a replacement for
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.Inertia\">Modelica.Mechanics.Rotational.Components.Inertia</a>
for the case, that a 1-dim.-rotational mechanical system should be attached with a 3-dim.
carrier body.</p>
<p>The Boolean parameter <code>exact</code> was introduced due to performance
reasons. If <code>exact</code> is set to <strong>false</strong>, the influence of the carrier body
motion on the angular velocity of the rotor is neglected. This influence is usually
negligible if the 1-dim.-rotational mechanical system accelerates much faster as the base body (this is,
e.g., the case in vehicle powertrains). The essential advantage is
that an algebraic loop is removed since then there is only an
action on acceleration level from the powertrain to the base body
but not vice versa.</p>
<p><strong>Reference</strong><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1-dim. Powertrains</a>. In: <em>Proceedings of the 3rd International
Modelica Conference</em>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,10},{100,-10}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Line(points={{-80,-25},{-60,-25}}),
        Line(points={{60,-25},{80,-25}}),
        Line(points={{-70,-25},{-70,-70}}),
        Line(points={{70,-25},{70,-70}}),
        Line(points={{-80,25},{-60,25}}),
        Line(points={{60,25},{80,25}}),
        Line(points={{-70,45},{-70,25}}),
        Line(points={{70,45},{70,25}}),
        Line(points={{-70,-70},{70,-70}}),
        Rectangle(
          extent={{-50,50},{50,-50}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          radius=10),
        Rectangle(
          extent={{-50,50},{50,-50}},
          lineColor={64,64,64},
          radius=10),
        Text(
          extent={{-150,125},{150,85}},
          textColor={0,0,255},
          textString="%name"),
        Line(points={{0,-70},{0,-100}}),
        Text(
          extent={{-150,80},{150,50}},
          textString="%J")}));
end Rotor1D;
