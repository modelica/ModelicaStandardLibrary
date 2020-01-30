within Modelica.Magnetic.FluxTubes.Examples.Utilities;
model TranslatoryArmatureAndStopper
  "Mass with free travel between two stoppers"

  parameter SI.Length L(start=0)
    "Length of component from left flange to right flange (= flange_b.s - flange_a.s)";
  parameter SI.Mass m(start=1) "Armature mass";

  parameter SI.TranslationalSpringConstant c(start=1e11)
    "Spring stiffness between impact partners";
  parameter SI.TranslationalDampingConstant d(start=2e7)
    "Damping coefficient between impact partners";
  parameter Real n(final min=1) = 2
    "Exponent of spring forces (f_c = c*|s_rel|^n)"
    annotation (Evaluate=true);

  parameter SI.Position x_max(start=10e-3)
    "Position of stopper at maximum armature position";
  parameter SI.Position x_min(start=0)
    "Position of stopper at minimum armature position";
  SI.Position s(start=0)
    "Absolute position of center of component (= flange_a.s + L/2)";
  SI.Velocity v(start=0)
    "Absolute velocity of components (= der(s))";
  SI.Acceleration a(start=0)
    "Absolute acceleration of components (= der(v))";
  Modelica.Mechanics.Translational.Components.Mass mass(final L=L, final
      m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.Translational.Components.Fixed limit_xMin(s0=x_min)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Mechanics.Translational.Components.Fixed limit_xMax(s0=x_max)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Modelica.Mechanics.Translational.Components.ElastoGap stopper_xMax(
    final c=c,
    final d=d,
    final n=n,
    final s_rel0=0) annotation (Placement(transformation(extent={{50,-30},
            {70,-10}})));
  Modelica.Mechanics.Translational.Components.ElastoGap stopper_xMin(
    final c=c,
    final d=d,
    final n=n,
    final s_rel0=0) annotation (Placement(transformation(extent={{-70,-30},
            {-50,-10}})));

equation
  mass.s = s;
  mass.v = v;
  mass.a = a;
  connect(mass.flange_a, stopper_xMin.flange_b) annotation (Line(points={
          {-10,0},{-40,0},{-40,-20},{-50,-20}}, color={0,127,0}));
  connect(limit_xMax.flange, stopper_xMax.flange_b)
    annotation (Line(points={{70,-40},{70,-20}}, color={0,191,0}));
  connect(stopper_xMax.flange_a, mass.flange_b) annotation (Line(points={
          {50,-20},{40,-20},{40,0},{10,0}}, color={0,127,0}));
  connect(mass.flange_a, flange_a) annotation (Line(points={{-10,0},{-32.5,
          0},{-55,0},{-100,0}}, color={0,127,0}));
  connect(limit_xMin.flange, stopper_xMin.flange_a)
    annotation (Line(points={{-70,-40},{-70,-20}}, color={0,127,0}));
  connect(flange_b, mass.flange_b)
    annotation (Line(points={{100,0},{10,0}}, color={0,127,0}));
  annotation (
    defaultComponentName="armature",
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={Line(
                points={{-80,-60},{-80,-80}},
                color={160,160,164},
                thickness=0.5),Line(
                points={{-80,-76},{-40,-76}},
                color={160,160,164},
                thickness=0.5,
                arrow={Arrow.None,Arrow.Filled}),Text(
                extent={{-84,-82},{-76,-92}},
                textColor={160,160,164},
                textString="0"),Text(
                extent={{-46,-82},{-38,-92}},
                textColor={160,160,164},
                textString="x"),Ellipse(
                extent={{-82,-78},{-78,-74}},
                lineColor={175,175,175},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
        extent={{-90,10},{90,-10}},
        fillPattern=FillPattern.HorizontalCylinder,
        fillColor={255,127,0}),
      Text(
        extent={{-120,140},{120,100}},
        textColor={0,0,255},
        textString="%name"),
      Rectangle(
        extent={{-50,60},{50,-60}},
        fillPattern=FillPattern.HorizontalCylinder,
        fillColor={255,127,0}),
      Rectangle(
        extent={{-80,-20},{-88,-80}},
        lineColor={255,128,0},
        fillColor={255,128,0},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{88,-20},{80,-80}},
        lineColor={255,128,0},
        fillColor={255,128,0},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-80,80},{-88,20}},
        lineColor={255,128,0},
        fillColor={255,128,0},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{88,80},{80,20}},
        lineColor={255,128,0},
        fillColor={255,128,0},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-100,-100},{100,-140}},
        textString="m=%m"),
      Line(points={{-50,-80},{30,-80}}),
      Polygon(
        points={{60,-80},{30,-70},{30,-90},{60,-80}},
        lineColor={128,128,128},
        fillColor={128,128,128},
        fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
In translatory actuators with limited stroke, the armature with its inertia can travel between two stoppers.
</p>
</html>"));
end TranslatoryArmatureAndStopper;
