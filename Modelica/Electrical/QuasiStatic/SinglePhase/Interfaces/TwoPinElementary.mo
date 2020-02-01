within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model TwoPinElementary "Elementary two pins with reference connection, without declaration of voltage and current"
  import Modelica.Constants.eps;
  SI.AngularVelocity omega "Angular velocity of reference frame";

  PositivePin pin_p "Positive quasi-static single-phase pin" annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}})));
  NegativePin pin_n "Negative quasi-static single-phase pin" annotation (Placement(transformation(
          extent={{90,-10},{110,10}})));
equation
  Connections.branch(pin_p.reference, pin_n.reference);
  pin_p.reference.gamma = pin_n.reference.gamma;
  omega = der(pin_p.reference.gamma);
  annotation (Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">negative pin</a>,
but no complex voltage, current, power, etc. Additionally, the angular velocity of the quasi-static system
is explicitly defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPin\">TwoPin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end TwoPinElementary;
