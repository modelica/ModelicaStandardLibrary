within Modelica.Magnetic.QuasiStatic.FundamentalWave.Components;
model PolyphaseElectroMagneticConverter
  "Polyphase electromagnetic converter"
  import Modelica.Constants.pi;
  constant Complex j=Complex(0, 1);
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug
    plug_p(final m=m) "Positive plug" annotation (Placement(transformation(
        origin={-100,100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug
    plug_n(final m=m) "Negative plug" annotation (Placement(transformation(
        origin={-100,-100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  FundamentalWave.Interfaces.PositiveMagneticPort port_p
    "Positive complex magnetic port" annotation (Placement(transformation(
          extent={{90,90},{110,110}})));
  FundamentalWave.Interfaces.NegativeMagneticPort port_n
    "Negative complex magnetic port" annotation (Placement(transformation(
          extent={{90,-110},{110,-90}})));
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter Real effectiveTurns "Effective number of turns";
  constant SI.Angle orientation=0
    "Orientation of the first winding axis";
  // Local electric polyphase quantities
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
  Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in 1:m}
    "Power factor";

  // Local electromagnetic fundamental wave quantities
  SI.ComplexMagneticPotentialDifference V_m
    "Complex magnetic potential difference";
  SI.MagneticPotentialDifference abs_V_m=
      Modelica.ComplexMath.abs(V_m)
    "Magnitude of complex magnetic potential difference";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference";

  SI.ComplexMagneticFlux Phi "Complex magnetic flux";
  SI.MagneticPotentialDifference abs_Phi=
      Modelica.ComplexMath.abs(Phi) "Magnitude of complex magnetic flux";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
    "Argument of complex magnetic flux";

  SI.AngularVelocity omega=der(port_p.reference.gamma);
  // A technical solution with a rotator cannot be applied to the equations below
  final parameter Complex N=effectiveTurns*Modelica.ComplexMath.exp(Complex(
      0, orientation)) "Complex effective number of turns";
  SI.ComplexVoltage vSymmetricalComponent[m]
    "Symmetrical components of voltages";
  SI.ComplexCurrent iSymmetricalComponent[m]
    "Symmetrical components of currents";
protected
  final parameter Complex sTM[m,m]=
    Modelica.Electrical.Polyphase.Functions.symmetricTransformationMatrix(m);
  final parameter Integer indexNonPos[:]=
      Modelica.Electrical.Polyphase.Functions.indexNonPositiveSequence(
                                                              m)
    "Indices of all non positive sequence components";
  final parameter Integer indexPos[:]=
      Modelica.Electrical.Polyphase.Functions.indexPositiveSequence(
                                                           m)
    "Indices of all positive sequence components";
equation
  // Symmetrical components (preferred): vSymmetricalComponent = sTM*v; iSymmetricalComponent = sTM*i;
  for j in 1:m loop
    vSymmetricalComponent[j] = Complex(sum({sTM[j,k].re*v[k].re - sTM[j,k].im*v[k].im for k in 1:m}),
                                       sum({sTM[j,k].re*v[k].im + sTM[j,k].im*v[k].re for k in 1:m}));
    iSymmetricalComponent[j] = Complex(sum({sTM[j,k].re*i[k].re - sTM[j,k].im*i[k].im for k in 1:m}),
                                       sum({sTM[j,k].re*i[k].im + sTM[j,k].im*i[k].re for k in 1:m}));
  end for;
  // Magnetic flux and flux balance of the magnetic ports
  port_p.Phi = Phi;
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // Magnetic potential difference of the magnetic ports
  port_p.V_m - port_n.V_m = V_m;
  // Voltage drop between the electrical plugs
  v = plug_p.pin.v - plug_n.pin.v;
  // Current and current balance of the electric plugs
  i = plug_p.pin.i;
  plug_p.pin.i + plug_n.pin.i = {Complex(0, 0) for k in 1:m};
  V_m.re = sqrt(2)*(2.0/pi)*Modelica.ComplexMath.real(N*
    iSymmetricalComponent[1])*m/2;
  V_m.im = sqrt(2)*(2.0/pi)*Modelica.ComplexMath.imag(N*
    iSymmetricalComponent[1])*m/2;
  for k in 1:size(indexNonPos, 1) loop
    iSymmetricalComponent[indexNonPos[k]] = Complex(0, 0);
  end for;
  for k in 2:size(indexPos, 1) loop
    vSymmetricalComponent[indexPos[1]] = vSymmetricalComponent[indexPos[k]];
  end for;
  // Induced voltages from complex magnetic flux, number of turns
  // and angles of orientation of winding
  -sqrt(2)*Complex(Modelica.ComplexMath.real(vSymmetricalComponent[indexPos[
    1]]), Modelica.ComplexMath.imag(vSymmetricalComponent[indexPos[1]])) =
    Modelica.ComplexMath.conj(N)*j*omega*Phi;
  // Potential roots are not used; instead the reference angle is handled
  // by means of Connections.branch between electric plug_p and magnetic port_p
  // It has to be checked whether this Modelica compliant
  //   Connections.potentialRoot(plug_p.reference);
  //   Connections.potentialRoot(port_p.reference);
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  Connections.branch(plug_p.reference, plug_n.reference);
  plug_p.reference.gamma = plug_n.reference.gamma;
  Connections.branch(plug_p.reference, port_p.reference);
  plug_p.reference.gamma = port_p.reference.gamma;
  annotation (defaultComponentName="converter", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={    Line(points={{100,-100},{94,-100},
          {84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{
          30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}},
          color={255,170,85}),Line(points={{-20,60},{-20,100},{-100,100}},
          color={85,170,255}),Line(points={{-20,-60},{-20,-100},{-100,-100}},
          color={85,170,255}),
        Line(
          points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-13,45},
          rotation=270),
        Line(
          points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-13,-15},
          rotation=270),
        Text(
          extent={{150,150},{-150,110}},
          textColor={0,0,255},
          textString="%name")}),     Documentation(info="<html>

<p>
Each phase <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/k.png\"> of an <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> phase winding has an effective number of turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns_k.png\"> and an respective winging angle <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation_k.png\"> and a phase current <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\">.
</p>

<p>
The total complex magnetic potential difference of the polyphase winding is determined by:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Components/polyphaseconverter_vm.png\">
</p>

<p>
In this equation
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/i_sc1.png\">
is the positive symmetrical component of the currents.
</p>

<p>
The positive sequence of the voltages
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/v_sc1.png\">
induced in each winding is directly proportional to the complex magnetic flux and the number of turns. This relationship can be modeled by means of</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Components/polyphaseconverter_phi.png\">.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.QuasiStaticAnalogElectroMagneticConverter\">
QuasiStaticAnalogElectroMagneticConverter</a>
</p>
</html>"));
end PolyphaseElectroMagneticConverter;
