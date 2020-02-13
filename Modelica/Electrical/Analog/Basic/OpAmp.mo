within Modelica.Electrical.Analog.Basic;
model OpAmp "Simple nonideal model of an OpAmp with limitation"
  parameter Real Slope(start=10000)
    "Slope of the out.v/vin characteristic at vin=0";
  Modelica.Electrical.Analog.Interfaces.PositivePin in_p
    "Positive pin of the input port" annotation (Placement(transformation(
          extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin in_n
    "Negative pin of the input port" annotation (Placement(transformation(
          extent={{-90,50},{-110,70}}), iconTransformation(extent={{-90,50},{-110,70}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin out "Output pin"
    annotation (Placement(transformation(extent={{110,-10},{90,10}}), iconTransformation(extent={{110,-10},{90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin VMax
    "Positive output voltage limitation" annotation (Placement(transformation(
          extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin VMin
    "Negative output voltage limitation" annotation (Placement(transformation(
          extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  SI.Voltage vin "Input voltage";
protected
  Real f "Auxiliary variable";
  Real absSlope;
equation
  in_p.i = 0;
  in_n.i = 0;
  VMax.i = 0;
  VMin.i = 0;
  vin = in_p.v - in_n.v;
  f = 2/(VMax.v - VMin.v);
  absSlope = if (Slope < 0) then -Slope else Slope;
  out.v = (VMax.v + VMin.v)/2 + absSlope*vin/(1 + absSlope*smooth(0, (if (f*
    vin < 0) then -f*vin else f*vin)));
  annotation (
    Documentation(info="<html>
<p>The OpAmp is a simple nonideal model with a smooth out.v = f(vin) characteristic, where &quot;vin = in_p.v - in_n.v&quot;. The characteristic is limited by VMax.v and VMin.v. Its slope at vin=0 is the parameter Slope, which must be positive. (Therefore, the absolute value of Slope is taken into calculation.)</p>
</html>",
        revisions="<html>
<ul>
<li><em> 2000   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{70,0},{-70,80},{-70,-80},{70,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{-45,-10},{-20,-10},{-14,-9},{-11,-7},{-9,7},{-6,9},{0,
              10},{20,10}}, color={0,0,255}),
        Line(points={{0,40},{0,100}}, color={0,0,255}),
        Line(points={{0,-40},{0,-100}}, color={0,0,255}),
        Line(points={{-100,60},{-70,60}}, color={0,0,255}),
        Line(points={{-100,-60},{-70,-60}}, color={0,0,255}),
        Line(points={{70,0},{100,0}}, color={0,0,255}),
        Line(points={{-58,50},{-38,50}}, color={0,0,255}),
        Line(points={{-49,-40},{-49,-61}}, color={0,0,255}),
        Line(points={{-60,-51},{-38,-51}}, color={0,0,255}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}));
end OpAmp;
