within Modelica.Mechanics.Rotational.Sources;
model Accelerate
  "Forced movement of a flange according to an acceleration signal"
  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  SI.Angle phi(
    start=0,
    fixed=true,
    stateSelect=StateSelect.prefer)
    "Rotation angle of flange with respect to support";
  SI.AngularVelocity w(
    start=0,
    fixed=true,
    stateSelect=StateSelect.prefer)
    "Angular velocity of flange with respect to support";
  SI.AngularAcceleration a
    "Angular acceleration of flange with respect to support";

  Modelica.Blocks.Interfaces.RealInput a_ref(unit="rad/s2")
    "Absolute angular acceleration of flange with respect to support as input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

equation
  phi = flange.phi - phi_support;
  w = der(phi);
  a = der(w);
  a = a_ref;
  annotation (
    Documentation(info="<html>
<p>
The input signal <strong>a_ref</strong> defines an <strong>angular acceleration</strong>
in [rad/s2]. Flange <strong>flange</strong> is <strong>forced</strong> to move relative to flange support with
this acceleration. The angular velocity <strong>w</strong> and the rotation angle
<strong>phi</strong> of the flange are automatically determined by integration of
the acceleration.
</p>
<p>
The input signal can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Rectangle(lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-100.0,-20.0},{100.0,20.0}}),
    Line(points={{-30.0,-32.0},{30.0,-32.0}}),
    Line(points={{0.0,52.0},{0.0,32.0}}),
    Line(points={{-29.0,32.0},{30.0,32.0}}),
    Line(points={{0.0,-32.0},{0.0,-100.0}}),
    Text(textColor={0,0,255},
      extent={{-150.0,60.0},{150.0,100.0}},
      textString="%name"),
    Text(extent={{-140,-60},{-40,-30}},
          textColor={128,128,128},
          horizontalAlignment=TextAlignment.Right,
          textString="a_ref")}));
end Accelerate;
