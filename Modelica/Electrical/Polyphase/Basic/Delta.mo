within Modelica.Electrical.Polyphase.Basic;
model Delta "Delta (polygon) connection"
  parameter Integer m(final min=2) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));

equation
  for j in 1:m-1 loop
    connect(plug_n.pin[j], plug_p.pin[j + 1]);
  end for;
  connect(plug_n.pin[m], plug_p.pin[1]);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(
          points={{-40,68},{-40,-70},{79,0},{-40,68},{-40,67}},
          thickness=0.5,
          color={0,0,255}),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{80,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,-110},{150,-70}},
          textString="m=%m"),
        Text(
          extent={{-150,70},{150,110}},
          textString="%name",
          textColor={0,0,255})}), Documentation(info=
         "<html>
<p>
Connects in a cyclic way plug_n.pin[j] to plug_p.pin[j+1],
thus establishing a so-called delta (or polygon) connection
when used in parallel to another component.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStar\">MultiStar</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiDelta\">MultiDelta</a>
</p>
</html>"));
end Delta;
