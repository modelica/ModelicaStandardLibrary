within Modelica.Magnetic.FundamentalWave.Components;
model Short "Salient reluctance"
  extends Interfaces.PartialTwoPortElementary;

equation
  connect(port_p, port_n) annotation (Line(points={{-100,0},{-1,0},{-1,0},{100,
          0}},                                              color={255,128,0}));
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
        Line(points={{-100,0},{100,0}}, color={255,128,0})}),
    Documentation(info="<html>
<p>
This is a simple short cut branch.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica.Magnetic.FundamentalWave.Components.Idle\">Idle</a>
</p>

</html>"),
    Diagram(graphics));
end Short;
