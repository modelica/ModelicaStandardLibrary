within Modelica.Clocked.ClockSignals.Interfaces;
connector ClockOutput = output Clock "'output Clock' as connector"
                                  annotation (defaultComponentName="y",
  Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
        graphics={Polygon(
          points={{-10,6},{10,0},{-10,-6},{-10,6}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          pattern=LinePattern.Dot),
                               Polygon(
          points={{-100,99},{100,-1},{-100,-101},{-100,99}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
  Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
        graphics={Polygon(
          points={{-100,50},{0,0},{-100,-50},{-100,50}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{30,110},{30,60}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one output signal of type Clock.
</p>
</html>"));
