within Modelica.Electrical.Analog.Ideal;
model IdealOpAmpLimited "Ideal operational amplifier with limitation"
  Interfaces.PositivePin in_p "Positive pin of the input port" annotation (
      Placement(transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
  Interfaces.NegativePin in_n "Negative pin of the input port" annotation (
      Placement(transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent={{-110,50},{-90,70}})));
  Interfaces.PositivePin out "Output pin" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Interfaces.PositivePin VMax "Positive output voltage limitation"
    annotation (Placement(transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},{10,110}})));
  Interfaces.NegativePin VMin "Negative output voltage limitation"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  SI.Voltage vin "Input voltage";
protected
  Real s(start=0, final unit="1") "Auxiliary variable";
  constant SI.Voltage unitVoltage=1 annotation (HideResult=true);

equation
  in_p.i = 0;
  in_n.i = 0;
  VMax.i = 0;
  VMin.i = 0;
  vin = in_p.v - in_n.v;
  in_p.v - in_n.v = unitVoltage*smooth(0, (if s < -1 then s + 1 else if s > 1
     then s - 1 else 0));
  out.v = smooth(0, if s < -1 then VMin.v else if s > 1 then VMax.v else (
    VMax.v - VMin.v)*s/2 + (VMax.v + VMin.v)/2);
  annotation (defaultComponentName="opAmp",
    Documentation(info="<html>
<p>
The ideal OpAmp with limitation behaves like an ideal OpAmp without limitation,
if the output voltage is within the limits VMin and VMax. In this case
the input voltage vin = in_p.v - in_n.v is zero.
If the input voltage vin less than 0, the output voltage is out.v = VMin.
If the input voltage is vin larger than 0, the output voltage is out.v = VMax.
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
        Polygon(
          points={{70,0},{-70,80},{-70,-80},{70,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{-100,60},{-70,60}}, color={0,0,255}),
        Line(points={{-100,-60},{-70,-60}}, color={0,0,255}),
        Line(points={{-60,50},{-40,50}}, color={0,0,255}),
        Line(points={{-50,-40},{-50,-60}}, color={0,0,255}),
        Line(points={{-60,-50},{-40,-50}}, color={0,0,255}),
        Line(points={{70,0},{100,0}}, color={0,0,255}),
        Line(points={{-45,-10},{-10,-10},{-10,10},{20,10}}, color={0,0,255}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{0,40},{0,100}}, color={0,0,255}),
        Line(points={{0,-100},{0,-40}}, color={0,0,255})}));
end IdealOpAmpLimited;
