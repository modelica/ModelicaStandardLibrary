within Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces;
partial model OnePort "Two pins, current through"
  extends QuasiStationary.SinglePhase.Interfaces.TwoPin;
equation
  pin_p.i + pin_n.i = Complex(0);
  annotation (Diagram(graphics),
                       Documentation(info="<html>
<p>
This partial model is based on <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.TwoPin\">TwoPin</a> and 
additionally considers the complex current balance of the  
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive</a> and the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a>. 
This model is intended to be used with textual representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.TwoPin\">TwoPin</a>
</p>
</html>"));
end OnePort;
