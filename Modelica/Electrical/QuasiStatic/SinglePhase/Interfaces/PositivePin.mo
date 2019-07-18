within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
connector PositivePin "Positive quasi-static single-phase pin"
  extends Pin;
  QuasiStatic.Types.Reference reference "Reference";
  annotation (
    Diagram(graphics={Text(
          extent={{-100,100},{100,60}},
          textColor={0,0,255},
          textString="%name"), Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}),
    Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>

<p>
The positive pin is based on <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">Pin</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angular velocity of the quasi-static voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">negative pin</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
end PositivePin;
