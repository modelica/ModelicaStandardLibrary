within Modelica.Electrical.Analog.Basic;
model CCV "Linear current-controlled voltage source"
  extends Interfaces.TwoPort;

  parameter SI.Resistance transResistance(start=1) "Transresistance";

equation
  v2 = i1*transResistance;
  v1 = 0;
  annotation (defaultComponentName="ccv",
    Documentation(info="<html>
<p>The linear current-controlled voltage source is a TwoPort. The right port voltage v2 is controlled by the left port current i1 via</p>
<blockquote><pre>
v2 = i1 * transResistance.
</pre></blockquote>
<p>The left port voltage is zero. Any transResistance can be chosen.</p>
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
        Rectangle(
          extent={{-80,80},{80,-80}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{90,100},{40,100},{40,-100},{90,-100}},
                                                           color={0,0,255}),
        Ellipse(extent={{20,20},{60,-20}}, lineColor={0,0,255}),
        Line(points={{-20,60},{20,60}}, color={0,0,255}),
        Polygon(
          points={{20,60},{10,63},{10,57},{20,60}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{-90,100},{-40,100},{-40,-100},{-90,-100}},
                                                             color={0,0,255}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}));
end CCV;
