within Modelica.Electrical.Analog.Ideal;
model Short "Short cut branch"
  extends Interfaces.OnePort;
equation
  v = 0;
  annotation (
    Documentation(info="<html>
<p>The model Short is a simple short cut branch. That means the voltage drop between both pins is zero. This device could be neglected if both pins are combined to one node. Besides connecting the nodes of both pins this device has no further function.</p>
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
        Line(points={{91,0},{-90,0}}, color={0,0,255}),
        Text(
          extent={{-150,130},{150,90}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
          Text(
            extent={{-100,100},{100,70}},
            textString="Short",
            textColor={0,0,255})}));
end Short;
