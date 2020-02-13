within Modelica.Electrical.Analog.Basic;
model CCC "Linear current-controlled current source"
  extends Interfaces.TwoPort;
  parameter Real gain(start=1) "Current gain";

equation
  i2 = i1*gain;
  v1 = 0;
  annotation (defaultComponentName="ccc",
    Documentation(info="<html>
<p>The linear current-controlled current source is a TwoPort. The right port current i2 is controlled by the left port current i1 via</p>
<blockquote><pre>
i2 = i1 * gain.
</pre></blockquote>
<p>The left port voltage is zero. Any current gain can be chosen.</p>
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
        Line(points={{-90,100},{-40,100},{-40,-100},{-90,-100}},
                                                               color={0,0,255}),
        Ellipse(extent={{20,20},{60,-20}}, lineColor={0,0,255}),
        Line(points={{-20,60},{20,60}}, color={0,0,255}),
        Polygon(
          points={{20,60},{10,63},{10,57},{20,60}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{90,100},{40,100},{40,20}},
                                               color={0,0,255}),
        Line(points={{90,-100},{40,-100},{40,-20}},
                                                  color={0,0,255}),
        Line(points={{20,0},{60,0}}, color={0,0,255}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}));
end CCC;
