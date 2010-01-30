within Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces;
connector Pin "Basic connector"
  Modelica.SIunits.ComplexVoltage v "Complex potential at the node";
  flow Modelica.SIunits.ComplexCurrent i "Complex current flowing into the pin";
  annotation (Documentation(info="<html>
<p>
The potential of this connector is the complex voltage and the flow variable is the complex current.
The <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive</a> and
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a> are 
derived from this base connector.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>

</html>"));
end Pin;
