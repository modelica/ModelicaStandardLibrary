within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model Delta "Delta (polygon) connection"
  parameter Integer m(final min=2) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));

  PlugToPins_p plugToPins_p(final m=m) annotation (Placement(transformation(
          extent={{-80,-10},{-60,10}})));
  PlugToPins_n plugToPins_n(final m=m) annotation (Placement(transformation(
          extent={{80,-10},{60,10}})));
equation
  for j in 1:m-1 loop
    connect(plugToPins_n.pin_n[j], plugToPins_p.pin_p[j + 1]);
  end for;
  connect(plugToPins_n.pin_n[m], plugToPins_p.pin_p[1]);
  connect(plug_p, plugToPins_p.plug_p) annotation (Line(points={{-100,0},{-93,
          0},{-86,0},{-72,0}}, color={85,170,255}));
  connect(plugToPins_n.plug_n, plug_n) annotation (Line(points={{72,0},{79,
          0},{79,0},{86,0},{86,0},{100,0}}, color={85,170,255}));
  annotation (Icon(graphics={Line(
              points={{-40,68},{-40,-70},{79,0},{-40,68},{-40,67}},
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
Delta (polygon) connection of a polyphase circuit.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.MultiStar\">MultiStar</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.MultiDelta\">MultiDelta</a>
</p></html>"));
end Delta;
