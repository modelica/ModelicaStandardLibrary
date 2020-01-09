within Modelica.Electrical.Polyphase;
package Basic "Basic components for electrical polyphase models"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This package contains basic analog electrical polyphase components.
</p>

</html>",
        revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Release Notes:</strong></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
</dl>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          origin={11.626,40},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-80,-70},{60,-10}}),
        Line(
          origin={11.626,40},
          points={{60,-40},{80,-40}},
          color={0,0,255}),
        Line(points={{-88.374,0},{-68.374,0}}, color={0,0,255})}));
end Basic;
