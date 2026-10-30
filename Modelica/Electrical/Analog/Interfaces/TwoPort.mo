within Modelica.Electrical.Analog.Interfaces;
partial model TwoPort
  "Component with two electrical ports, including current"
  extends FourPin;

equation
  0 = p1.i + n1.i;
  0 = p2.i + n2.i;
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
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
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
<p>TwoPort is a partial model that consists of two ports. Like OnePort each port has two pins. It is assumed that the current flowing into the positive  pin   is identical to the current flowing out of pin n. This currents of each port are  provided explicitly as currents i1 and i2, the voltages respectively as v1 and v2.</p>
</html>"));
end TwoPort;
