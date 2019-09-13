within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
connector NegativePlug "Negative quasi-static polyphase plug"
  extends Plug;
  QuasiStatic.Types.Reference reference;
  annotation (
    Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(graphics={Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,100},{100,60}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>

<p>
The negative plug is based on <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.Plug\">Plug</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angular velocity of each quasi-static voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">positive plug</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
</p>
</html>"));
end NegativePlug;
