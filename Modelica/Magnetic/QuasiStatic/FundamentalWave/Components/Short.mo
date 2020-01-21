within Modelica.Magnetic.QuasiStatic.FundamentalWave.Components;
model Short "Short connection"
  extends Interfaces.TwoPortElementary;
equation
  connect(port_p, port_n) annotation (Line(points={{-100,0},{-1,0},{-1,0},{100,0}}, color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-100,0},{100,0}}, color={255,170,85}),
        Text(
          extent={{150,60},{-150,20}},
          textColor={0,0,255},
          textString="%name")}),
      Documentation(info="<html>
<p>
This is a simple short cut branch.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Idle\">Idle</a>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Crossing\">Crossing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Magnetic.FundamentalWave.Components.Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Magnetic.FundamentalWave.Components.Short</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Magnetic.FundamentalWave.Components.Crossing</a>
</p>

</html>"));
end Short;
