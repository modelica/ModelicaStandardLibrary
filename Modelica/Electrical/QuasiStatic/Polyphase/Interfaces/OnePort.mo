within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model OnePort "Two plugs, reference connection and declaration of voltage and current"
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
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
  SI.AngularVelocity omega
    "Angular velocity of reference frame";

  PositivePlug plug_p(final m=m)
    "Positive quasi-static polyphase plug" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  NegativePlug plug_n(final m=m)
    "Negative quasi-static polyphase plug" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
equation
  Connections.branch(plug_p.reference, plug_n.reference);
  plug_p.reference.gamma = plug_n.reference.gamma;
  omega = der(plug_p.reference.gamma);
  v = plug_p.pin.v - plug_n.pin.v;
  i = plug_p.pin.i;
  plug_p.pin.i + plug_n.pin.i = fill(Complex(0), m);
  annotation (Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">negative plug</a> and defines
the complex voltage differences as well as the complex currents (into the positive plug).
A <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_p\">positive</a> and
a <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_n\">negative adapter</a>
are used to give easy access to the single pins of both plugs. Additionally, the angular velocity of the
quasi-static system is explicitly defined as variable. This model is mainly intended to be used with textual representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.TwoPlug\">TwoPlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end OnePort;
