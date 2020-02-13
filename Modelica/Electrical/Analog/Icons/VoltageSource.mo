within Modelica.Electrical.Analog.Icons;
partial model VoltageSource "Icon for voltage sources"
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,60},{150,100}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-90,0},{90,0}}, color={0,0,255}),
        Line(points={{-80,20},{-60,20}}, color={0,0,255}),
        Line(points={{-70,30},{-70,10}}, color={0,0,255}),
        Line(points={{60,20},{80,20}}, color={0,0,255})}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>Just the common icon for voltage sources.</p>
</html>"));
end VoltageSource;
