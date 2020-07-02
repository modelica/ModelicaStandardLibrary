within Modelica.Mechanics.Translational.Sources;
model Accelerate
  "Forced movement of a flange according to an acceleration signal"
  extends
    Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2(
    s(start=0,
      fixed=true,
      stateSelect=StateSelect.prefer));
  SI.Velocity v(
    start=0,
    fixed=true,
    stateSelect=StateSelect.prefer) "Absolute velocity of flange";
  SI.Acceleration a "Absolute acceleration of flange";

  Modelica.Blocks.Interfaces.RealInput a_ref(unit="m/s2")
    "Absolute acceleration of flange as input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));

equation
  v = der(s);
  a = der(v);
  a = a_ref;

  annotation (
    Documentation(info="<html>
<p>
The input signal <strong>a_ref</strong> in [m/s2] moves the 1D translational flange
connector flange with a&nbsp;predefined <em>acceleration</em>, i.e., the flange
is <em>forced</em> to move relative to the support connector with this acceleration.
The velocity and the position of the flange are also predefined and are determined by
integration of the acceleration.
</p>
<p>
The acceleration <var>a<sub>ref</sub></var>(<var>t</var>) can be provided from one
of the signal generator blocks of the block library Modelica.Blocks.Source.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-30,-32},{30,-32}}, color={0,127,0}),
        Line(points={{0,-32},{0,-100}}, color={0,127,0}),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Line(points={{-29,32},{30,32}}, color={0,127,0}),
        Line(points={{0,52},{0,32}}, color={0,127,0}),
        Text(extent={{150,60},{-150,100}},
          textString="%name",
          textColor={0,0,255}),
        Text(extent={{-140,-60},{-40,-30}},
          textColor={128,128,128},
          horizontalAlignment=TextAlignment.Right,
          textString="a_ref")}));
end Accelerate;
