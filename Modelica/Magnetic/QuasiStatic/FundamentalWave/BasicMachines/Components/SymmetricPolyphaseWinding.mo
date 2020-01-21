within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components;
model SymmetricPolyphaseWinding
  "Symmetric winding model coupling electrical and magnetic domain"
  // Orientation changed
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug
    plug_p(final m=m) "Positive plug" annotation (Placement(
        transformation(
        origin={-100,100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug
    plug_n(final m=m) "Negative plug" annotation (Placement(
        transformation(
        origin={-100,-100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Interfaces.NegativeMagneticPort port_n "Negative complex magnetic port"
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Interfaces.PositiveMagneticPort port_p "Positive complex magnetic port"
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter Boolean useHeatPort=false
    "Enable / disable (=fixed temperatures) thermal port"
    annotation (Evaluate=true);
  // Resistor model
  parameter SI.Resistance RRef
    "Winding resistance per phase at TRef";
  parameter SI.Temperature TRef(start=293.15)
    "Reference temperature of winding";
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20(start=0) "Temperature coefficient of winding at 20 degC";
  final parameter SI.LinearTemperatureCoefficient alphaRef=
      Modelica.Electrical.Machines.Thermal.convertAlpha(
            alpha20,
            TRef,
            293.15) "Temperature coefficient of winding at reference temperature";
  parameter SI.Temperature TOperational(start=293.15)
    "Operational temperature of winding"
    annotation (Dialog(enable=not useHeatPort));
  parameter SI.Inductance Lsigma
    "Winding stray inductance per phase";
  parameter Real effectiveTurns=1 "Effective number of turns per phase";
  parameter SI.Conductance GcRef
    "Electrical reference core loss reluctance";

  SI.ComplexVoltage v[m]=plug_p.pin.v - plug_n.pin.v
    "Complex voltage";
  SI.Voltage abs_v[m]=Modelica.ComplexMath.abs(v)
    "Magnitude of complex voltage";
  SI.Angle arg_v[m]=Modelica.ComplexMath.arg(v)
    "Argument of complex voltage";
  SI.ComplexCurrent i[m]=plug_p.pin.i "Complex current";
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
  Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in
          1:m} "Power factor";

  SI.ComplexMagneticPotentialDifference V_m=port_p.V_m -
      port_n.V_m "Complex magnetic potential difference";
  SI.MagneticPotentialDifference abs_V_m=
      Modelica.ComplexMath.abs(V_m)
    "Magnitude of complex magnetic potential difference";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference";
  SI.ComplexMagneticFlux Phi=port_p.Phi
    "Complex magnetic flux";
  SI.MagneticFlux abs_Phi=
      Modelica.ComplexMath.abs(Phi)
    "Magnitude of complex magnetic flux";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
    "Argument of complex magnetic flux";

  Magnetic.QuasiStatic.FundamentalWave.Components.PolyphaseElectroMagneticConverter
    electroMagneticConverter(final m=m, final effectiveTurns=effectiveTurns)
    "Symmetric winding"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor resistor(
    final m=m,
    final useHeatPort=useHeatPort,
    final T_ref=fill(TRef, m),
    final T=fill(TOperational, m),
    R_ref=fill(RRef, m),
    final alpha_ref=fill(alphaRef, m)) "Winding resistor" annotation (
      Placement(transformation(
        origin={-20,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding[m] if
       useHeatPort "Heat ports of winding resistors"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore if
    useHeatPort "Heat ports of winding resistor"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
  Magnetic.QuasiStatic.FundamentalWave.Components.EddyCurrent core(final
      useHeatPort=useHeatPort, final G=(m/2)*GcRef*effectiveTurns^2)
    "Core loss model (currently eddy currents only)" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={50,-40})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Permeance stray(final G_m(
        d=2*Lsigma/m/effectiveTurns^2, q=2*Lsigma/m/effectiveTurns^2)) "Stray permeance equivalent to ideally coupled stray inductances"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,30})));
equation
  connect(resistor.heatPort, heatPortWinding) annotation (Line(
      points={{-30,70},{-40,70},{-40,-100}}, color={191,0,0}));
  connect(core.heatPort, heatPortCore) annotation (Line(
      points={{40,-50},{40,-100}}, color={191,0,0}));
  connect(stray.port_n, core.port_n)
    annotation (Line(points={{80,20},{80,-40},{60,-40}}, color={255,170,85}));
  connect(electroMagneticConverter.plug_p, resistor.plug_n) annotation (
      Line(
      points={{-10,-20},{-20,-20},{-20,60}}, color={85,170,255}));
  connect(plug_n, electroMagneticConverter.plug_n) annotation (Line(
      points={{-100,-100},{-100,-40},{-10,-40}}, color={85,170,255}));
  connect(plug_p, resistor.plug_p) annotation (Line(
      points={{-100,100},{-20,100},{-20,80}}, color={85,170,255}));
  connect(port_p, electroMagneticConverter.port_p) annotation (Line(
      points={{100,100},{10,100},{10,-20}}, color={255,170,85}));
  connect(stray.port_p, port_p)
    annotation (Line(points={{80,40},{80,100},{100,100}}, color={255,170,85}));
  connect(port_n, core.port_n) annotation (Line(
      points={{100,-100},{100,-40},{60,-40}}, color={255,170,85}));
  connect(electroMagneticConverter.port_n, core.port_p) annotation (Line(
      points={{10,-40},{40,-40}}, color={255,170,85}));
  annotation (defaultComponentName="winding",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50,
              -72},{42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46,
              66},{62,84},{78,96},{90,100},{100,100}}, color={255,170,85}),
        Line(points={{40,60},{-100,60},{-100,100}}, color={85,170,255}),
        Line(points={{40,-60},{-100,-60},{-100,-98}}, color={85,170,255}),
        Line(points={{40,60},{100,20},{40,-20},{0,-20},{-40,0},{0,20},{40,
              20},{100,-20},{40,-60}}, color={85,170,255}),
        Text(
          extent={{150,150},{-150,110}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
The symmetrical polyphase winding consists of a symmetrical winding
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">resistor</a>, a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance\">stray reluctance</a>, a symmetrical
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">polyphase electromagnetic coupling</a> and a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.EddyCurrent\">core loss</a> model including
heat <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">port</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components.QuasiStaticAnalogWinding\">
QuasiStaticAnalogWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding</a>
</p>
</html>"));
end SymmetricPolyphaseWinding;
