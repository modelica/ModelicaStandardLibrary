within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model TwoPin "Two pins"
  import Modelica.Constants.eps;
  Modelica.SIunits.ComplexVoltage v "Complex voltage";
  Modelica.SIunits.Voltage abs_v=Modelica.ComplexMath.abs(v) "Magnitude of complex voltage";
  Modelica.SIunits.Angle arg_v=Modelica.ComplexMath.arg(v) "Argument of complex voltage";
  Modelica.SIunits.ComplexCurrent i "Complex current";
  Modelica.SIunits.Current abs_i=Modelica.ComplexMath.abs(i) "Magnitude of complex current";
  Modelica.SIunits.Angle arg_i=Modelica.ComplexMath.arg(i) "Argument of complex current";
  Modelica.SIunits.ActivePower P=Modelica.ComplexMath.real(v*
      Modelica.ComplexMath.conj(i)) "Active power";
  Modelica.SIunits.ReactivePower Q=Modelica.ComplexMath.imag(v*
      Modelica.ComplexMath.conj(i)) "Reactive power";
  Modelica.SIunits.ApparentPower S=Modelica.ComplexMath.abs(v*
      Modelica.ComplexMath.conj(i)) "Magnitude of complex apparent power";
  Real pf=cos(Modelica.ComplexMath.arg(Complex(P, Q))) "Power factor";
  Modelica.SIunits.AngularVelocity omega "Angular velocity of reference frame";

  PositivePin pin_p "Positive quasi-static single-phase pin" annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}})));
  NegativePin pin_n "Negative quasi-static single-phase pin" annotation (Placement(transformation(
          extent={{90,-10},{110,10}})));
equation
  Connections.branch(pin_p.reference, pin_n.reference);
  pin_p.reference.gamma = pin_n.reference.gamma;
  omega = der(pin_p.reference.gamma);
  v = pin_p.v - pin_n.v;
  i = pin_p.i;
  annotation (Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">negative pin</a> and defines the complex voltage difference as well as the complex current (into the positive pin). Additionally, the angular velocity of the quasi-static system is explicitly defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end TwoPin;
