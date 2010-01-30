within Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces;
connector NegativePlug "Negative multiphase connector"
  extends Plug;
  Types.Reference reference;
  annotation (Icon(graphics={Ellipse(
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
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString=
               "%name")}),
  Documentation(info="<html>

<p>
The negative plug is based on <a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>. 
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angluar velocity of each quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive plug</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
</p>
</html>"));
end NegativePlug;
