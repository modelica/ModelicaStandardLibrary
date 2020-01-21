within Modelica.Magnetic.QuasiStatic.FundamentalWave.Components;
model Idle "Idle running branch"
  extends Interfaces.TwoPort;
equation
  Phi = Complex(0, 0);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={           Line(points={{-100,0},{-40,0}},
          color={255,170,85}),Line(points={{40,0},{100,0}}, color={255,170,
          85}),
        Text(
          extent={{150,60},{-150,20}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
This is a simple idle running branch.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Short\">Short</a>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Crossing\">Crossing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Magnetic.FundamentalWave.Components.Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Magnetic.FundamentalWave.Components.Short</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Magnetic.FundamentalWave.Components.Crossing</a>
</p>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
                      Line(points={{60,0},{100,0}}, color={255,170,85})}));
end Idle;
