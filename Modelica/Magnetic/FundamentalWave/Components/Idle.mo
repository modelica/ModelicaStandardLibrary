within Modelica.Magnetic.FundamentalWave.Components;
model Idle "Salient reluctance"
  extends Interfaces.PartialTwoPort;
equation
  Phi = Complex(0,0);
  annotation (Icon(graphics={
        Text(
          extent={{0,60},{0,100}},
          lineColor={255,128,0},
          textString =                         "%name"),
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{-40,0}}, color={255,128,0}),
        Line(points={{40,0},{100,0}}, color={255,128,0})}),
    Documentation(info="<html>
<p>
This is a simple idle running branch.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>
</p>

</html>"),
    Diagram(graphics={
        Line(points={{-100,0},{-60,0}}, color={255,128,0}),
        Line(points={{60,0},{100,0}}, color={255,128,0}),
        Line(points={{-60,0},{-40,2},{-18,6},{0,14},{12,26}}, color={255,128,0}),
        Line(points={{60,0},{40,-2},{18,-6},{0,-14},{-12,-26}}, color={255,128,
              0})}));
end Idle;
