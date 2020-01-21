within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model OnePort
  parameter Integer m(min=1) = 3 "Number of phases";
  Modelica.SIunits.ComplexVoltage v[m] "Complex voltage";
  Modelica.SIunits.Voltage abs_v[m]=Modelica.ComplexMath.abs(v)
    "Magnitude of complex voltage";
  Modelica.SIunits.Angle arg_v[m]=Modelica.ComplexMath.arg(v)
    "Argument of complex voltage";
  Modelica.SIunits.ComplexCurrent i[m] "Complex current";
  Modelica.SIunits.Current abs_i[m]=Modelica.ComplexMath.abs(i)
    "Magnitude of complex current";
  Modelica.SIunits.Angle arg_i[m]=Modelica.ComplexMath.arg(i)
    "Argument of complex current";
  Modelica.SIunits.ActivePower P[m]={Modelica.ComplexMath.real(v[k]*
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Active power";
  Modelica.SIunits.ActivePower P_total=sum(P) "Total active power";
  Modelica.SIunits.ReactivePower Q[m]={Modelica.ComplexMath.imag(v[k]*
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Reactive power";
  Modelica.SIunits.ReactivePower Q_total=sum(Q) "Total reactive power";
  Modelica.SIunits.ApparentPower S[m]={Modelica.ComplexMath.abs(v[k]*
      Modelica.ComplexMath.conj(i[k])) for k in 1:m}
    "Magnitude of complex apparent power";
  Modelica.SIunits.ApparentPower S_total=sqrt(P_total^2 + Q_total^2)
    "Magnitude of total complex apparent power";
  Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in 1
      :m} "Power factor";
  /*
  Real pf_total = cos(Modelica.ComplexMath.arg(Complex(P_total,Q_total)))
    "Total power factor";
  */
  Modelica.SIunits.AngularVelocity omega
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
end OnePort;
