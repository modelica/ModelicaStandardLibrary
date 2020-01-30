within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
connector Pin "Quasi-static single-phase pin"
  SI.ComplexElectricPotential v "Complex potential at the quasi-static single-phase pin";
  flow SI.ComplexCurrent i "Complex current flowing into the quasi-static single-phase pin";
  annotation (Documentation(info="<html>
<p>
The potential of this connector is the complex voltage and the flow variable is the complex current.
The <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">positive</a> and
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">negative pin</a> are
derived from this base connector.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>
</p>

</html>"));
end Pin;
