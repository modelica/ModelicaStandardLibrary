within Modelica.Magnetic.FundamentalWave.Components;
model Idle "Idle running branch"
  extends Magnetic.FundamentalWave.Interfaces.TwoPort;
equation
  Phi = Complex(0, 0);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={           Line(points={{-100,0},{-40,0}},
          color={255,128,0}),Line(points={{40,0},{100,0}}, color={255,128,0}),
          Text(
              extent={{-150,20},{150,60}},
              textColor={0,0,255},
              textString="%name")}),
    Documentation(info="<html>
<p>
This is a simple idle running branch.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Crossing</a>
</p>

</html>"));
end Idle;
