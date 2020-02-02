within Modelica.Electrical.Polyphase.Basic;
model Star "Star-connection"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));

equation
  for j in 1:m loop
    connect(plug_p.pin[j], pin_n);
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-150,70},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{80,0},{0,0}},
          thickness=0.5,
          color={0,0,255}),
        Line(
          points={{0,0},{-39,68}},
          thickness=0.5,
          color={0,0,255}),
        Line(
          points={{0,0},{-38,-69}},
          thickness=0.5,
          color={0,0,255}),
        Text(
          extent={{-150,-110},{150,-70}},
          textString="m=%m"),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{80,0},{90,0}}, color={0,0,255})}), Documentation(info=
         "<html>
<p>
Connects all pins of plug_p to pin_n, thus establishing a so-called star-connection.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStar\">MultiStar</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiDelta\">MultiDelta</a>
</p>

</html>"));
end Star;
