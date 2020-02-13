within Modelica.Electrical.Analog.Interfaces;
partial model FourPin "Component with two pairs of each two electrical pins"
  SI.Voltage v1 "Voltage drop of port 1 (= p1.v - n1.v)";
  SI.Voltage v2 "Voltage drop of port 2 (= p2.v - n2.v)";
  SI.Current i1 "Current flowing from pos. to neg. pin of port 1";
  SI.Current i2 "Current flowing from pos. to neg. pin of port 2";
  PositivePin p1 "Positive electrical pin of port 1" annotation (Placement(
        transformation(extent={{-110,90},{-90,110}}), iconTransformation(extent={{-110,90},{-90,110}})));
  NegativePin n1 "Negative electrical pin of port 1" annotation (Placement(
        transformation(extent={{-90,-110},{-110,-90}}), iconTransformation(extent={{-90,-110},{-110,-90}})));
  PositivePin p2 "Positive electrical pin of port 2" annotation (Placement(
        transformation(extent={{110,90},{90,110}}), iconTransformation(extent={{110,90},{90,110}})));
  NegativePin n2 "Negative electrical pin of port 2" annotation (Placement(
        transformation(extent={{90,-110},{110,-90}}), iconTransformation(extent={{90,-110},{110,-90}})));
equation
  v1 = p1.v - n1.v;
  v2 = p2.v - n2.v;
  i1 = p1.i;
  i2 = p2.i;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}),               graphics={
        Polygon(
          points={{-124,103},{-114,100},{-124,97},{-124,103}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{-140,100},{-115,100}},
                                           color={160,160,164}),
        Polygon(
          points={{130,-97},{140,-100},{130,-103},{130,-97}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{114,-100},{139,-100}},
                                           color={160,160,164}),
        Text(
          extent={{113,-96},{129,-81}},
          textColor={160,160,164},
          textString="i2"),
        Text(
          extent={{122,102},{139,117}},
          textColor={160,160,164},
          textString="i2"),
        Polygon(
          points={{124,103},{114,100},{124,97},{124,103}},
          lineColor={160,160,164},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Line(points={{115,100},{140,100}}, color={160,160,164}),
        Line(points={{-140,-100},{-115,-100}},
                                             color={160,160,164}),
        Polygon(
          points={{-130,-97},{-140,-100},{-130,-103},{-130,-97}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-131,-97},{-114,-82}},
          textColor={160,160,164},
          textString="i1"),
        Text(
          extent={{-140,103},{-123,118}},
          textColor={160,160,164},
          textString="i1")}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>FourPin is a partial model that consists of two pairs of each two electrical pins.</p>
</html>"));
end FourPin;
