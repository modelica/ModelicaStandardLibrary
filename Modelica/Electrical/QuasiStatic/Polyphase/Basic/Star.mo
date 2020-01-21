within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model Star "Star connection"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  PlugToPins_p plugToPins_p(final m=m) annotation (Placement(transformation(
          extent={{-80,-10},{-60,10}})));
equation
  for j in 1:m loop
    connect(plugToPins_p.pin_p[j], pin_n);
  end for;
  connect(plug_p, plugToPins_p.plug_p) annotation (Line(points={{-100,0},{-93,
          0},{-86,0},{-72,0}}, color={85,170,255}));
  annotation (Icon(graphics={Line(
              points={{80,0},{0,0}},
              color={85,170,255},
              thickness=0.5),Line(
              points={{0,0},{-39,68}},
              color={85,170,255},
              thickness=0.5),Line(
              points={{0,0},{-38,-69}},
              color={85,170,255},
              thickness=0.5), Line(points={{-90,0},{-40,0}}, color={85,170,255}),
          Line(points={{80,0},{90,0}}, color={85,170,255}),
        Text(
          extent={{-150,70},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-110},{150,-70}},
          textString="m=%m")}),
      Documentation(info="<html>
<p>
Star (wye) connection of a polyphase circuit. The potentials at the star points are the same.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.MultiStar\">MultiStar</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.MultiDelta\">MultiDelta</a>
</p>
</html>"));
end Star;
