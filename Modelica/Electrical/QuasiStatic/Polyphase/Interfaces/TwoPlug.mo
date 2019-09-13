within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model TwoPlug "Two plugs with pin-adapter"
  parameter Integer m(min=1) = 3 "Number of phases";
  Modelica.SIunits.ComplexVoltage v[m] "Complex voltage";
  Modelica.SIunits.Voltage abs_v[m]=Modelica.ComplexMath.'abs'(v)
    "Magnitude of complex voltage";
  Modelica.SIunits.Angle arg_v[m]=Modelica.ComplexMath.arg(v)
    "Argument of complex voltage";
  Modelica.SIunits.ComplexCurrent i[m] "Complex current";
  Modelica.SIunits.Current abs_i[m]=Modelica.ComplexMath.'abs'(i)
    "Magnitude of complex current";
  Modelica.SIunits.Angle arg_i[m]=Modelica.ComplexMath.arg(i)
    "Argument of complex current";
  Modelica.SIunits.ActivePower P[m]={Modelica.ComplexMath.real(v[k]*
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Active power";
  Modelica.SIunits.ActivePower P_total=sum(P) "Total active power";
  Modelica.SIunits.ReactivePower Q[m]={Modelica.ComplexMath.imag(v[k]*
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Reactive power";
  Modelica.SIunits.ReactivePower Q_total=sum(Q) "Total reactive power";
  Modelica.SIunits.ApparentPower S[m]={Modelica.ComplexMath.'abs'(v[k]*
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
  Basic.PlugToPins_p plugToPins_p(final m=m) annotation (Placement(
        transformation(extent={{-80,-10},{-60,10}})));
  Basic.PlugToPins_n plugToPins_n(final m=m) annotation (Placement(
        transformation(
        origin={70,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  omega = der(plug_p.reference.gamma);
  v = plug_p.pin.v - plug_n.pin.v;
  i = plug_p.pin.i;
  connect(plug_p, plugToPins_p.plug_p) annotation (Line(points={{-100,0},{-93,
          0},{-86,0},{-72,0}}, color={85,170,255}));
  connect(plugToPins_n.plug_n, plug_n)
    annotation (Line(points={{72,0},{86,0},{100,0}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">negative plug</a> and defines the complex voltage differences as well as the complex currents (into the positive plug). A <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_p\">positive</a> and
a <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_n\">negative adapter</a> are used to give easy access to the single pins of both plugs. Additionally, the angular velocity of the quasi-static system is explicitly defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>,
</p>
</html>"));
end TwoPlug;
