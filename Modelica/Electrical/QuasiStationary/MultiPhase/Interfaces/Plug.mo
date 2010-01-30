within Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces;
connector Plug "Basic multiphase plug"
  parameter Integer m=3 "number of phases";
  SinglePhase.Interfaces.Pin pin[m];
  annotation (Documentation(info="<html>

<p>
This multiphase plug contains a vector of <i>m</i> <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">single phase pins</a>.
The <a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive</a> and
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">negative plug</a> are 
derived from this base connector.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
end Plug;
