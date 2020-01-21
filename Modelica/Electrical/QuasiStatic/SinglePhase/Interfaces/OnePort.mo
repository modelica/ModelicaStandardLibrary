within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model OnePort "Two pins, current through"
  extends TwoPin;
equation
  pin_p.i + pin_n.i = Complex(0);
  annotation (Documentation(info="<html>
<p>
This partial model is based on <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPin\">TwoPin</a> and
additionally considers the complex current balance of the
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">positive</a> and the
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">negative pin</a>.
This model is intended to be used with textual representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPinElementary\">TwoPinElementary</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPin\">TwoPin</a>
</p>
</html>"));
end OnePort;
