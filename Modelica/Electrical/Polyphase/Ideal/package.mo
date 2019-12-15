within Modelica.Electrical.Polyphase;
package Ideal "Polyphase components with idealized behaviour"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This package contains analog electrical polyphase components with idealized behaviour,
like thyristor, diode, switch, transformer.
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
        Line(
          origin={10,40},
          points={{-100,-40},{80,-40}},
          color={0,0,255}),
        Polygon(
          origin={10,40},
          fillColor={255,255,255},
          points={{20,-40},{-40,0},{-40,-80},{20,-40}}),
        Line(
          origin={-10,0},
          points={{40,40},{40,-40}},
          color={0,0,255})}));
end Ideal;
