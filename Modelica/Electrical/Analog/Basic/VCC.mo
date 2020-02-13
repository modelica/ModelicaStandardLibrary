within Modelica.Electrical.Analog.Basic;
model VCC "Linear voltage-controlled current source"
  extends Interfaces.TwoPort;
  parameter SI.Conductance transConductance(start=1) "Transconductance";
equation
  i2 = v1*transConductance;
  i1 = 0;
  annotation (defaultComponentName="vcc",
    Documentation(info="<html>
<p>The linear voltage-controlled current source is a TwoPort. The right port current i2 is controlled by the left port voltage v1 via</p>
<blockquote><pre>
i2 = v1 * transConductance.
</pre></blockquote>
<p>The left port current is zero. Any transConductance can be chosen.</p>
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
          textColor={0,0,255}),
        Line(points={{-90,100},{-40,100},{-40,60}}, color={0,0,255}),
        Line(
          points={{10,25},{-40,25},{-40,-15}},
          color={0,0,255},
          origin={-80,-75},
          rotation=180)}));
end VCC;
