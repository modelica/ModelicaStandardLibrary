within Modelica.Clocked.ClockSignals.Interfaces;
connector ClockInput = input Clock "'input Clock' as connector"
  annotation (defaultComponentName="u",
       Icon(graphics={Polygon(
          points={{-34,6},{20,0},{-34,-8},{-34,6}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dot,
          lineThickness=0.5),
                      Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)},
            coordinateSystem(extent={{-100,-100},{100,100}},
        preserveAspectRatio=true, initialScale=0.2)),    Diagram(coordinateSystem(
        preserveAspectRatio=true, initialScale=0.2,
        extent={{-100,-100},{100,100}}),
        graphics={Polygon(
          points={{0,50},{100,0},{0,-50},{0,50}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid), Text(
          extent={{-10,85},{-10,60}},
          textColor={0,0,255},
          textString="%name",
        fillPattern=FillPattern.Solid,
        fillColor={128,0,255})}),
    Documentation(info="<html>
<p>
Connector with one input signal of type Clock.
</p>
</html>"));
