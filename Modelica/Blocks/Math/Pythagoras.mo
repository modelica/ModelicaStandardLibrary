within Modelica.Blocks.Math;
block Pythagoras "Determine the hypotenuse or leg of a right triangle"
  extends Interfaces.SI2SO;
  parameter Boolean u1IsHypotenuse = false "= true, if u1 is the hypotenuse and y is one leg";
  Interfaces.BooleanOutput valid "= true, if y is a valid result" annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
protected
  Real y2 "Square of y";
equation
  if not u1IsHypotenuse then
    y2 = u1^2 + u2^2;
    y = sqrt(y2);
    valid = true;
  else
    y2 = u1^2 - u2^2;
    valid = y2 >= 0;
    y = if noEvent(y2 >= 0) then sqrt(y2) else 0;
  end if;

  annotation (Icon(graphics={
        Polygon(
          points={{34,-80},{34,80},{-36,-40},{34,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,60},{22,60}},
          pattern=LinePattern.Dash),
        Line(
          points={{34,0},{100,0}},
          pattern=LinePattern.Dash),
        Line(
          points={{-100,-60},{0,-60}},
          pattern=LinePattern.Dash),
        Line(
          visible=u1IsHypotenuse,
          points={{22,60},{34,60}},
          pattern=LinePattern.Dash),
        Line(
          visible=u1IsHypotenuse,
          points={{-12,0},{34,0}},
          pattern=LinePattern.Dash)}), Documentation(info="<html>
<p>This block determines the hypotenuse <code>y = sqrt(u1^2 + u2^2)</code>
if the boolean parameter <code>u1IsHyotenuse = false</code>.
In this case the two inputs <code>u1</code> and
<code>u2</code> are interpreted as the legs of a right triangle
and the boolean output <code>valid</code> is always equal to
<code>true</code>.</p>

<p>If <code>u1IsHyotenuse = true</code>, input <code>u1</code> is interpreted as hypotenuse and <code>u2</code>
is one of the two legs of a right triangle.
Then, the other of the two legs of the right triangle is the output, determined by
<code>y = sqrt(u1^2 - u2^2)</code>, if <code>u1^2 - u2^2 &ge; 0</code>; in this case the
boolean output <code>valid</code> is equal to <code>true</code>. In case of <code>u1^2 - u2^2 &lt; 0</code>, the
output <code>y = 0</code> and <code>valid</code> is set to <code>false</code>.</p>
</html>"));
end Pythagoras;
