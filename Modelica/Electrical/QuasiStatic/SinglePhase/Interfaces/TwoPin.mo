within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model TwoPin "Two pins"
  import Modelica.Constants.eps;
  extends Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPinElementary;

  SI.ComplexVoltage v "Complex voltage";
  SI.Voltage abs_v=Modelica.ComplexMath.abs(v) "Magnitude of complex voltage";
  SI.Angle arg_v=Modelica.ComplexMath.arg(v) "Argument of complex voltage";
  SI.ComplexCurrent i "Complex current";
  SI.Current abs_i=Modelica.ComplexMath.abs(i) "Magnitude of complex current";
  SI.Angle arg_i=Modelica.ComplexMath.arg(i) "Argument of complex current";
  SI.ActivePower P=Modelica.ComplexMath.real(v*
      Modelica.ComplexMath.conj(i)) "Active power";
  SI.ReactivePower Q=Modelica.ComplexMath.imag(v*
      Modelica.ComplexMath.conj(i)) "Reactive power";
  SI.ApparentPower S=Modelica.ComplexMath.abs(v*
      Modelica.ComplexMath.conj(i)) "Magnitude of complex apparent power";
  Real pf=cos(Modelica.ComplexMath.arg(Complex(P, Q))) "Power factor";
  SI.AngularVelocity omega "Angular velocity of reference frame";

equation
  v = pin_p.v - pin_n.v;
  i = pin_p.i;
  annotation (Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">negative pin</a> and defines
the complex voltage difference as well as the complex current (into the positive pin).
Additionally, the angular velocity of the quasi-static system is explicitly defined as variable.
This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPinElementary\">TwoPinElementary</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end TwoPin;
