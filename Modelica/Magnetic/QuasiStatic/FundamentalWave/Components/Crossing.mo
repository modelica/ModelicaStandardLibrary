within Modelica.Magnetic.QuasiStatic.FundamentalWave.Components;
model Crossing "Crossing of connections"

  Interfaces.PositiveMagneticPort port_p1 "Connected with port_p2"
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Interfaces.NegativeMagneticPort port_n1 "Connected with port_n2"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Interfaces.PositiveMagneticPort port_p2 "Connected with port_p1"
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Interfaces.NegativeMagneticPort port_n2 "Connected with port_n1"
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
equation
  connect(port_p1, port_p2) annotation (Line(
      points={{-100,100},{-100,20},{0,20},{0,-20},{100,-20},{100,-100}}, color={255,170,85}));
  connect(port_n2, port_n1) annotation (Line(
      points={{100,100},{100,0},{-100,0},{-100,-100}}, color={255,170,85}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
              extent={{-150,110},{150,150}},
              textColor={0,0,255},
              textString="%name"),           Line(
              points={{-100,100},{-42,100},{42,-100},{100,-100}},
              color={255,170,85}),Line(
              points={{100,100},{42,100},{-40,-100},{-100,-100}},
              color={255,170,85})}),
    Documentation(info="<html>
<p>
This is a simple short cut branch.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Idle\">Idle</a>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Short\">Short</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Magnetic.FundamentalWave.Components.Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Magnetic.FundamentalWave.Components.Short</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Magnetic.FundamentalWave.Components.Crossing</a>
</p>

</html>"));
end Crossing;
