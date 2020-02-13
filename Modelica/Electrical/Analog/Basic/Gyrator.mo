within Modelica.Electrical.Analog.Basic;
model Gyrator "Gyrator"
  extends Interfaces.TwoPort;
  parameter SI.Conductance G1(start=1) "Primary gyration conductance";
  parameter SI.Conductance G2(start=1) "Secondary gyration conductance";
equation
  i1 = G2*v2;
  i2 = -G1*v1;
  annotation (
    Documentation(info="<html>
<p>A gyrator is a two-port element defined by the following equations:</p>
<blockquote><pre>
i1 =  G2 * v2
i2 = -G1 * v1
</pre></blockquote>
<p>where the constants <em>G1</em>, <em>G2</em> are called the gyration conductance.</p>
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
        Line(points={{-40,30},{40,30}}, color={0,0,255}),
        Line(points={{-20,-30},{20,-30}}, color={0,0,255}),
        Polygon(
          points={{30,34},{40,30},{30,26},{30,34}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{-5,10},{-10,-10}}),
        Line(points={{9,10},{4,-9}}),
        Line(points={{-12,10},{16,10}}),
        Text(
          extent={{-29,69},{30,40}},
          textString="G1"),
        Text(
          extent={{-29,-39},{29,-68}},
          textString="G2"),
        Text(
          extent={{-150,151},{150,111}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{-10,-26},{-20,-30},{-10,-34},{-10,-26}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{-100,100},{-40,100},{-40,60}}, color={0,0,255}),
        Line(
          points={{20,25},{-40,25},{-40,-15}},
          color={0,0,255},
          origin={80,75},
          rotation=360),
        Line(
          points={{-35,-20},{25,-20},{25,20}},
          color={0,0,255},
          origin={-65,-80},
          rotation=360),
        Line(
          points={{20,-25},{-40,-25},{-40,15}},
          color={0,0,255},
          origin={80,-75},
          rotation=360)}));
end Gyrator;
