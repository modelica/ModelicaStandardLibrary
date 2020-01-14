within Modelica.Magnetic.FundamentalWave.Components;
model Crossing "Crossing of two branches"

  Interfaces.PositiveMagneticPort port_p1
    "Positive port_p1 connected with port_p2"
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Interfaces.PositiveMagneticPort port_p2
    "Positive port_p2 connected with port_p1"
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Interfaces.NegativeMagneticPort port_n1
    "Negative port_n1 connected with port_n2"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Interfaces.NegativeMagneticPort port_n2
    "Negative port_n2 connected with port_n1"
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
equation
  connect(port_p1, port_p2) annotation (Line(
      points={{-100,100},{-100,20},{0,20},{0,-20},{100,-20},{100,-100}}, color={255,128,0}));
  connect(port_n1, port_n2) annotation (Line(
      points={{-100,-100},{-100,0},{100,0},{100,100}}, color={255,128,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
              extent={{-150,110},{150,150}},
              textColor={0,0,255},
              textString="%name"),           Line(
              points={{100,100},{40,100},{-40,-100},{-100,-100}},
              color={255,128,0}),Line(
              points={{-100,100},{-40,100},{40,-100},{100,-100}},
              color={255,128,0})}),
    Documentation(info="<html>
<p>
This is a simple crossing of two branches. The ports <code>port_p1</code> and <code>port_p2</code> are connected, as well as <code>port_n1</code> and <code>port_n2</code>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>
</p>

</html>"));
end Crossing;
