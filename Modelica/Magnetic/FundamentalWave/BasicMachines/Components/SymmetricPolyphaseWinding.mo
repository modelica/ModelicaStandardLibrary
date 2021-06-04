within Modelica.Magnetic.FundamentalWave.BasicMachines.Components;
model SymmetricPolyphaseWinding
  "Symmetric winding model coupling electrical and magnetic domain"
  import Modelica.Constants.eps;
  // Orientation changed
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(final m=m)
    "Positive plug" annotation (Placement(transformation(
        origin={-100,100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(final m=m)
    "Negative plug" annotation (Placement(transformation(
        origin={-100,-100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort port_n
    "Negative complex magnetic port"
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort port_p
    "Positive complex magnetic port"
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter Boolean useHeatPort=false
    "Enable / disable (=fixed temperatures) thermal port"
    annotation (Evaluate=true);
  // Resistor model
  parameter SI.Resistance RRef "Winding resistance per phase at TRef";
  parameter SI.Temperature TRef(start=293.15)
    "Reference temperature of winding";
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20(start=0) "Temperature coefficient of winding at 20 degC";
  final parameter SI.LinearTemperatureCoefficient alphaRef=
      Modelica.Electrical.Machines.Thermal.convertAlpha(
            alpha20,
            TRef,
            293.15)
    "Temperature coefficient of winding at reference temperature";
  parameter SI.Temperature TOperational(start=293.15)
    "Operational temperature of winding"
    annotation (Dialog(enable=not useHeatPort));
  parameter SI.Inductance Lsigma "Winding stray inductance per phase";
  parameter Real ratioCommonLeakage(final min=0, final max=1)=1
    "Ratio of common stray inductance / total stray inductance";
  parameter SI.Inductance Lzero "Zero sequence inductance of winding";
  parameter Real effectiveTurns=1 "Effective number of turns per phase";
  parameter SI.Conductance GcRef "Electrical reference core loss reluctance";
  final parameter Integer nBase=Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m)
    "Number of base systems";
  final parameter Integer mBase=integer(m/nBase)
    "Number of phase of the base systems";

  SI.Voltage v[m]=plug_p.pin.v - plug_n.pin.v "Voltage";
  SI.Current i[m]=plug_p.pin.i "Current";

  SI.ComplexMagneticPotentialDifference V_m=port_p.V_m -
      port_n.V_m "Complex magnetic potential difference";
  SI.MagneticPotentialDifference abs_V_m=
      Modelica.ComplexMath.abs(V_m)
    "Magnitude of complex magnetic potential difference";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference";
  SI.ComplexMagneticFlux Phi=port_p.Phi "Complex magnetic flux";
  SI.MagneticFlux abs_Phi=
      Modelica.ComplexMath.abs(Phi) "Magnitude of complex magnetic flux";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
    "Argument of complex magnetic flux";

  Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter
    electroMagneticConverter(
    m=m,
    final effectiveTurns=fill(effectiveTurns, m),
    final orientation=
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    final useStrayPermeance=ratioCommonLeakage < (1 - eps),
    final Lsigma=(1 - ratioCommonLeakage)*Lsigma)
                                            "Symmetric winding"
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Electrical.Polyphase.Basic.ZeroInductor zeroInductor(final m=m, final Lzero=Lzero) if
       mBase<>2 "Zero sequence inductance of winding"
    annotation (Placement(transformation(
        origin={-70,-30},
        extent={{10,-10},{-10,10}},
        rotation=0)));
  Modelica.Electrical.Polyphase.Ideal.Short short(final m=m) if mBase == 2
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-70,-50})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor(
    final m=m,
    final useHeatPort=useHeatPort,
    final R=fill(RRef, m),
    final T_ref=fill(TRef, m),
    final alpha=fill(alphaRef, m),
    final T=fill(TOperational, m)) "Winding resistor" annotation (
      Placement(transformation(
        origin={-20,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding[m] if
       useHeatPort "Heat ports of winding resistors"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore if
       useHeatPort "Heat port of core"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
  Magnetic.FundamentalWave.Components.EddyCurrent core(
    final useHeatPort=useHeatPort, final G=(m/2)*GcRef*effectiveTurns^2)
    "Core loss model (currently eddy currents only)" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={50,-40})));
  Modelica.Magnetic.FundamentalWave.Components.Permeance stray(final G_m(
    d=2/m*ratioCommonLeakage*Lsigma/effectiveTurns^2,
    q=2/m*ratioCommonLeakage*Lsigma/effectiveTurns^2)) if ratioCommonLeakage>eps
    "Common stray permeance equivalent to ideally coupled stray inductances"
      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,30})));

equation
  connect(plug_p, resistor.plug_p) annotation (Line(points={{-100,100},{-20,
          100},{-20,80}}, color={0,0,255}));
  connect(resistor.heatPort, heatPortWinding) annotation (Line(
      points={{-30,70},{-40,70},{-40,-100}}, color={191,0,0}));
  connect(core.port_n, port_n) annotation (Line(
      points={{60,-40},{100,-40},{100,-100}}, color={255,128,0}));
  connect(core.heatPort, heatPortCore) annotation (Line(
      points={{40,-50},{40,-100}}, color={191,0,0}));
  connect(stray.port_n, core.port_n) annotation (Line(points={{80,20},{80,-40},{60,-40}}, color={255,128,0}));
  connect(short.plug_n, plug_n) annotation (Line(points={{-80,-50},{-80,-40},{-100,
          -40},{-100,-100}}, color={0,0,255}));
  connect(plug_n, zeroInductor.plug_n) annotation (Line(points={{-100,-100},{-100,
          -40},{-80,-40},{-80,-30}}, color={0,0,255}));
  connect(port_p, stray.port_p)
    annotation (Line(points={{100,100},{80,100},{80,40}}, color={255,128,0}));
  connect(electroMagneticConverter.port_n, core.port_p)
    annotation (Line(points={{10,-20},{10,-40},{40,-40}}, color={255,128,0}));
  connect(zeroInductor.plug_p, electroMagneticConverter.plug_n) annotation (
      Line(points={{-60,-30},{-60,-40},{-20,-40},{-20,-20},{-10,-20}}, color={0,
          0,255}));
  connect(short.plug_p, electroMagneticConverter.plug_n) annotation (Line(
        points={{-60,-50},{-60,-40},{-20,-40},{-20,-20},{-10,-20}}, color={0,0,255}));
  connect(resistor.plug_n, electroMagneticConverter.plug_p)
    annotation (Line(points={{-20,60},{-20,0},{-10,0}}, color={0,0,255}));
  connect(electroMagneticConverter.port_p, port_p)
    annotation (Line(points={{10,0},{10,100},{100,100}}, color={255,128,0}));
  annotation (defaultComponentName="winding", Icon(graphics={
        Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50,
              -72},{42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46,
              66},{62,84},{78,96},{90,100},{100,100}}, color={255,128,0}),
        Line(points={{40,60},{-100,60},{-100,100}}, color={0,0,255}),
        Line(points={{40,-60},{-100,-60},{-100,-98}}, color={0,0,255}),
        Line(points={{40,60},{100,20},{40,-20},{0,-20},{-40,0},{0,20},{40,
              20},{100,-20},{40,-60}}, color={0,0,255}),
          Text(
              extent={{-150,110},{150,150}},
              textColor={0,0,255},
              textString="%name")}),
                                 Documentation(info="<html>
<p>
The symmetrical polyphase winding consists of a symmetrical winding
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Resistor\">resistor</a>, a
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.ZeroInductor\">zero inductor</a> as well as a symmetrical
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">polyphase electromagnetic coupling</a> and a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Reluctance\">stray reluctance</a> and a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">core loss</a> model including
heat <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">port</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">SymmetricPolyphaseCageWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
end SymmetricPolyphaseWinding;
