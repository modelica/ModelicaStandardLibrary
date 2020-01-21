within Modelica.Magnetic.FundamentalWave.Components;
model Short "Short cut branch"
  extends Magnetic.FundamentalWave.Interfaces.TwoPortElementary;
equation
  connect(port_p, port_n) annotation (Line(points={{-100,0},{-1,0},{-1,0},{100,0}}, color={255,128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={    Line(points={{-100,0},{100,0}},
          color={255,128,0}),
          Text(
              extent={{-150,20},{150,60}},
              textColor={0,0,255},
              textString="%name")}),
                                Documentation(info="<html>
<p>
This is a simple short cut branch.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Crossing</a>
</p>

</html>"));
end Short;
