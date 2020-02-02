within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.Components;
model PolyphaseInductance "Polyphase inductance"
  extends Modelica.Icons.Example;
  parameter Integer m=5 "Number of phases" annotation(Evaluate=true);
  parameter SI.Frequency f=1 "Supply frequency";
  parameter SI.Voltage VRMS=100 "RMS supply voltage";
  parameter SI.Resistance R=1E-5 "Resistance";
  parameter SI.Inductance L=1 "Load inductance";
  parameter Real effectiveTurns=5 "Effective number of turns";
  // Symmetrical polyphase magnetic reluctance
  final parameter SI.Reluctance R_m=m*effectiveTurns^2/2/L
    "Equivalent magnetic reluctance";
  output SI.ComplexCurrent Ie=resistor_e.i[1]
    "Current of electric representation";
  output SI.ComplexCurrent Im=resistor_m.i[1]
    "Current of magnetic representation";
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground ground_e
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground ground_m
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star star_e(m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,40})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star star_m(m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-60})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource
    voltageSource_e(
    m=m,
    f=f,
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    V=fill(VRMS, m),
    gamma(fixed=true, start=0))
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,70})));

  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource
    voltageSource_m(
    m=m,
    f=f,
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    V=fill(VRMS, m),
    gamma(fixed=true, start=0))
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-30})));

  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor
    resistor_e(m=m, R_ref=fill(R*m/3, m))
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor
    resistor_m(m=m, R_ref=fill(R*m/3, m))
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor
    inductor_e(m=m, L=fill(L, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,70})));
  Magnetic.QuasiStatic.FundamentalWave.Components.PolyphaseElectroMagneticConverter
    converter_m(m=m, effectiveTurns=effectiveTurns)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance reluctance_m(R_m(d=R_m,
        q=R_m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-30})));
  Magnetic.QuasiStatic.FundamentalWave.Components.Ground groundM_m
    annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
equation
  connect(star_e.pin_n, ground_e.pin) annotation (Line(
      points={{-60,30},{-60,30}}, color={85,170,255}));
  connect(star_e.plug_p, voltageSource_e.plug_n) annotation (Line(
      points={{-60,50},{-60,60}}, color={85,170,255}));
  connect(voltageSource_e.plug_n, inductor_e.plug_n) annotation (Line(
      points={{-60,60},{0,60}}, color={85,170,255}));
  connect(converter_m.port_p, reluctance_m.port_p) annotation (Line(
      points={{20,-20},{60,-20}}, color={255,170,85}));
  connect(converter_m.port_n, reluctance_m.port_n) annotation (Line(
      points={{20,-40},{60,-40}}, color={255,170,85}));
  connect(converter_m.port_n, groundM_m.port_p) annotation (Line(
      points={{20,-40},{20,-70}}, color={255,170,85}));
  connect(voltageSource_m.plug_n, star_m.plug_p) annotation (Line(
      points={{-60,-40},{-60,-50}}, color={85,170,255}));
  connect(star_m.pin_n, ground_m.pin) annotation (Line(
      points={{-60,-70},{-60,-70}}, color={85,170,255}));
  connect(voltageSource_m.plug_n, converter_m.plug_n) annotation (Line(
      points={{-60,-40},{0,-40}}, color={85,170,255}));
  connect(voltageSource_e.plug_p, resistor_e.plug_p) annotation (Line(
      points={{-60,80},{-40,80}}, color={85,170,255}));
  connect(resistor_e.plug_n, inductor_e.plug_p) annotation (Line(
      points={{-20,80},{0,80}}, color={85,170,255}));
  connect(voltageSource_m.plug_p, resistor_m.plug_p) annotation (Line(
      points={{-60,-20},{-40,-20}}, color={85,170,255}));
  connect(resistor_m.plug_n, converter_m.plug_p) annotation (Line(
      points={{-20,-20},{0,-20}}, color={85,170,255}));
  annotation (experiment(StopTime=100,
        Interval=0.01), Documentation(info="<html>
<p>
This example compares a quasi static electric polyphase inductor with an equivalent quasi static fundamental wave reluctance circuit.
The phase inductance <code>L</code> and the magnetic fundamental wave reluctance <code>R_m</code> are related by:
</p>

<blockquote><pre>
R_m = m * effectiveTurns^2 / 2 / L
</pre></blockquote>

<p>
The real parts
</p>

<ul>
<li><code>resistor_e.i[1].re</code></li>
<li><code>resistor_m.i[1].re</code></li>
</ul>

<p>
and the imaginary parts
</p>

<ul>
<li><code>resistor_e.i[1].im</code></li>
<li><code>resistor_m.i[1].im</code></li>
</ul>

<p>
of the two currents show the same result and thus prove the equivalence of the two different modelling approaches.
</p>
</html>"));
end PolyphaseInductance;
