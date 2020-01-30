within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model TwoPlug "Two plugs with pin-adapter, reference connection and declaration of voltage and current"
  extends Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.TwoPlugElementary;

  SI.ComplexVoltage v[m] "Complex voltage";
  SI.Voltage abs_v[m]=Modelica.ComplexMath.abs(v)
    "Magnitude of complex voltage";
  SI.Angle arg_v[m]=Modelica.ComplexMath.arg(v)
    "Argument of complex voltage";
  SI.ComplexCurrent i[m] "Complex current";
  SI.Current abs_i[m]=Modelica.ComplexMath.abs(i)
    "Magnitude of complex current";
  SI.Angle arg_i[m]=Modelica.ComplexMath.arg(i)
    "Argument of complex current";
  SI.ActivePower P[m]={Modelica.ComplexMath.real(v[k]*
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Active power";
  SI.ActivePower P_total=sum(P) "Total active power";
  SI.ReactivePower Q[m]={Modelica.ComplexMath.imag(v[k]*
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Reactive power";
  SI.ReactivePower Q_total=sum(Q) "Total reactive power";
  SI.ApparentPower S[m]={Modelica.ComplexMath.abs(v[k]*
      Modelica.ComplexMath.conj(i[k])) for k in 1:m}
    "Magnitude of complex apparent power";
  SI.ApparentPower S_total=sqrt(P_total^2 + Q_total^2)
    "Magnitude of total complex apparent power";
  Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in 1
      :m} "Power factor";
  /*
  Real pf_total = cos(Modelica.ComplexMath.arg(Complex(P_total,Q_total)))
   "Total power factor";
  */
equation
  v = plug_p.pin.v - plug_n.pin.v;
  i = plug_p.pin.i;
  annotation (Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">negative plug</a>,
but no complex voltage and complex current.
A <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_p\">positive</a> and
a <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_n\">negative adapter</a>
are used to give easy access to the single pins of both plugs. Additionally, the angular velocity of the
quasi-static system is explicitly defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.TwoPlug\">TwoPlugElementary</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end TwoPlug;
