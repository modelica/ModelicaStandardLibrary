within Modelica.Electrical.Analog.Ideal;
model IdealOpAmp "Ideal operational amplifier (norator-nullator pair)"
  SI.Voltage v1 "Voltage drop over the left port";
  SI.Voltage v2 "Voltage drop over the right port";
  SI.Current i1 "Current flowing from pos. to neg. pin of the left port";
  SI.Current i2 "Current flowing from pos. to neg. pin of the right port";
  Interfaces.PositivePin p1 "Positive pin of the left port" annotation (
      Placement(transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
  Interfaces.NegativePin n1 "Negative pin of the left port" annotation (
      Placement(transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent={{-110,50},{-90,70}})));
  Interfaces.PositivePin p2 "Positive pin of the right port" annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));
  Interfaces.NegativePin n2 "Negative pin of the right port" annotation (
      Placement(transformation(
        origin={0,-100},
        extent={{10,-10},{-10,10}},
        rotation=270)));
equation
  v1 = p1.v - n1.v;
  v2 = p2.v - n2.v;
  0 = p1.i + n1.i;
  0 = p2.i + n2.i;
  i1 = p1.i;
  i2 = p2.i;
  v1 = 0;
  i1 = 0;
  annotation (defaultComponentName="opAmp",
    Documentation(info="<html>
<p>
The ideal OpAmp is a two-port. The left port is fixed to <em>v1=0</em> and <em>i1=0</em>
(nullator). At the right port both any voltage <em>v2</em> and any current <em>i2</em>
are possible (norator).
</p>
</html>",
        revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{60,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,130},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{70,0},{-70,80},{-70,-80},{70,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{0,-40},{0,-100}}, color={0,0,255}),
        Line(points={{-100,60},{-70,60}}, color={0,0,255}),
        Line(points={{-100,-60},{-70,-60}}, color={0,0,255}),
        Line(points={{70,0},{100,0}}, color={0,0,255}),
        Line(points={{-60,50},{-40,50}}, color={0,0,255}),
        Line(points={{-60,-50},{-40,-50}}, color={0,0,255}),
        Line(points={{-50,-40},{-50,-60}}, color={0,0,255})}));
end IdealOpAmp;
