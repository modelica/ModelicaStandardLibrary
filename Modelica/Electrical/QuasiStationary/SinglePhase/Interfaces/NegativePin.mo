within Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces;
connector NegativePin "Negative Connector"
  extends QuasiStationary.SinglePhase.Interfaces.Pin;
  Types.Reference reference "Reference";
  annotation (Diagram(graphics={Text(
          extent={{-100,100},{100,60}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString=
               "%name"), Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
                            Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>

<p>
The negative pin is based on <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angluar velocity of the quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive pin</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
end NegativePin;
