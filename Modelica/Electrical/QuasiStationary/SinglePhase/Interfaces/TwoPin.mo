within Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces;
partial model TwoPin "Two pins"
  Modelica.SIunits.ComplexVoltage v;
  Modelica.SIunits.ComplexCurrent i;
  Modelica.SIunits.AngularVelocity omega = der(pin_p.reference.gamma);
  QuasiStationary.SinglePhase.Interfaces.PositivePin pin_p "Positive pin"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  QuasiStationary.SinglePhase.Interfaces.NegativePin pin_n "Negative pin"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation
  Connections.branch(pin_p.reference, pin_n.reference);
  pin_p.reference.gamma = pin_n.reference.gamma;
  i = pin_p.i;
  v = pin_p.v - pin_n.v;
  annotation (Diagram(graphics),
                       Documentation(info="<html>
<p>
This partial model uses a <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive</a>
and <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a> and defines the complex voltage difference as well as the complex current (into the positive pin). Additionally, the angular velocity of the quasi stationary system is explicitely defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end TwoPin;
