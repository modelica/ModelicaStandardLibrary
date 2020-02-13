within Modelica.Electrical.Analog.Ideal;
model Idle "Idle branch"
  extends Interfaces.OnePort;
equation
  i = 0;
  annotation (
    Documentation(info="<html>
<p>The model Idle is a simple idle running branch. That means between both pins no current is running. This ideal device is of no influence on the circuit. Therefore, it can be neglected in each case. For purposes of completeness this component is part of the MSL, as an opposite of the short cut.</p>
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
        Line(points={{-90,0},{-41,0}}, color={0,0,255}),
        Line(points={{91,0},{40,0}}, color={0,0,255}),
        Text(
          extent={{-150,130},{150,90}},
          textString="%name",
          textColor={0,0,255})}));
end Idle;
