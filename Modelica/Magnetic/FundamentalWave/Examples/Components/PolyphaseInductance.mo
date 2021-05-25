within Modelica.Magnetic.FundamentalWave.Examples.Components;
model PolyphaseInductance "Polyphase inductance"
  extends Modelica.Icons.Example;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Frequency f=1 "Supply frequency";
  parameter SI.Voltage VRMS=100 "RMS supply voltage";
  parameter SI.Resistance R=0.1 "Leader cable resistance";
  parameter Real effectiveTurns=5 "Effective number of turns";
  parameter SI.Inductance L=1 "Load inductance";
  final parameter SI.Reluctance R_ms=effectiveTurns^2/L
    "Individual equivalent magnetic reluctances";
  final parameter SI.Reluctance R_mm=m/2*effectiveTurns^2/L
    "Common equivalent magnetic reluctance";
  Electrical.Analog.Basic.Ground ground_e
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Electrical.Analog.Basic.Ground ground_s
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Electrical.Analog.Basic.Ground ground_m
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Electrical.Polyphase.Basic.Star star_e(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,60})));
  Electrical.Polyphase.Basic.Star star_s(m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,0})));
  Electrical.Polyphase.Basic.Star star_m(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-60})));
  Electrical.Polyphase.Sources.SineVoltage voltageSource_e(
    m=m,
    f=fill(f, m),
    V=fill(sqrt(2)*VRMS, m),
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m) + fill(Modelica.Constants.pi/2, m)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,70})));
  Electrical.Polyphase.Sources.SineVoltage voltageSource_s(
    m=m,
    f=fill(f, m),
    V=fill(sqrt(2)*VRMS, m),
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m) +
        fill(Modelica.Constants.pi/2, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,10})));
  Electrical.Polyphase.Sources.SineVoltage voltageSource_m(
    m=m,
    f=fill(f, m),
    V=fill(sqrt(2)*VRMS, m),
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m) +
        fill(Modelica.Constants.pi/2, m)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-50})));
  Electrical.Polyphase.Basic.Resistor resistor_e(m=m, R=fill(R, m))
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Electrical.Polyphase.Basic.Resistor resistor_s(m=m, R=fill(R, m))
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Electrical.Polyphase.Basic.Resistor resistor_m(m=m, R=fill(R, m))
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Electrical.Polyphase.Basic.Inductor inductor_e(m=m, L=fill(L, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,70})));
  Electrical.Polyphase.Basic.PlugToPins_p plugToPins_p(m=m)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Electrical.Polyphase.Basic.PlugToPins_n plugToPins_n(m=m)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter
    converter_s[m](orientation=Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    effectiveTurns=fill(effectiveTurns, m))
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter converter_m(
    m=m, orientation=Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    effectiveTurns=fill(effectiveTurns, m))
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Magnetic.FundamentalWave.Components.Reluctance reluctance_m(
    R_m(d=R_mm, q=R_mm))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-50})));
  Modelica.Magnetic.FundamentalWave.Components.Reluctance reluctance_s[m](
    each R_m(d=R_ms, q=R_ms)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={62,10})));
  Modelica.Magnetic.FundamentalWave.Components.Ground groundM_s[m]
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Magnetic.FundamentalWave.Components.Ground groundM_m
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
initial equation
  resistor_e.i = zeros(m);
  resistor_s.i[1:m] = zeros(m);
  resistor_m.i[1:2] = zeros(2);
equation
  connect(star_e.plug_p, voltageSource_e.plug_n) annotation (Line(
      points={{-50,60},{-40,60}}, color={0,0,255}));
  connect(voltageSource_e.plug_n, inductor_e.plug_n) annotation (Line(
      points={{-40,60},{20,60}},color={0,0,255}));
  connect(converter_m.port_p, reluctance_m.port_p) annotation (Line(
      points={{40,-40},{60,-40}}, color={255,128,0}));
  connect(converter_m.port_n, reluctance_m.port_n) annotation (Line(
      points={{40,-60},{60,-60}}, color={255,128,0}));
  connect(converter_m.port_n, groundM_m.port_p) annotation (Line(
      points={{40,-60},{40,-70}}, color={255,128,0}));
  connect(voltageSource_m.plug_n, star_m.plug_p) annotation (Line(
      points={{-40,-60},{-50,-60}}, color={0,0,255}));
  connect(voltageSource_m.plug_n, converter_m.plug_n) annotation (Line(
      points={{-40,-60},{20,-60}},color={0,0,255}));
  connect(voltageSource_e.plug_p, resistor_e.plug_p) annotation (Line(
      points={{-40,80},{-20,80}}, color={0,0,255}));
  connect(resistor_e.plug_n, inductor_e.plug_p) annotation (Line(
      points={{0,80},{20,80}},  color={0,0,255}));
  connect(voltageSource_m.plug_p, resistor_m.plug_p) annotation (Line(
      points={{-40,-40},{-20,-40}}, color={0,0,255}));
  connect(resistor_m.plug_n, converter_m.plug_p) annotation (Line(
      points={{0,-40},{20,-40}},  color={0,0,255}));
  connect(star_e.pin_n, ground_e.p) annotation (Line(
      points={{-70,60},{-70,50}}, color={0,0,255}));
  connect(voltageSource_s.plug_n, star_s.plug_p)
    annotation (Line(points={{-40,0},{-50,0}},   color={0,0,255}));
  connect(star_s.pin_n, ground_s.p)
    annotation (Line(points={{-70,0},{-70,-10}},   color={0,0,255}));
  connect(star_m.pin_n, ground_m.p)
    annotation (Line(points={{-70,-60},{-70,-70}}, color={0,0,255}));
  connect(converter_s.port_n, reluctance_s.port_n)
    annotation (Line(points={{40,0},{62,0}},   color={255,128,0}));
  connect(plugToPins_n.pin_n, converter_s.pin_n)
    annotation (Line(points={{12,0},{20,0}},   color={0,0,255}));
  connect(voltageSource_s.plug_n, plugToPins_n.plug_n)
    annotation (Line(points={{-40,0},{8,0}},   color={0,0,255}));
  connect(converter_s.port_n, groundM_s.port_p)
    annotation (Line(points={{40,0},{40,-10}},       color={255,128,0}));
  connect(voltageSource_s.plug_p, resistor_s.plug_p)
    annotation (Line(points={{-40,20},{-20,20}}, color={0,0,255}));
  connect(resistor_s.plug_n, plugToPins_p.plug_p)
    annotation (Line(points={{0,20},{4,20},{4,20},{8,20}}, color={0,0,255}));
  connect(plugToPins_p.pin_p, converter_s.pin_p)
    annotation (Line(points={{12,20},{20,20}}, color={0,0,255}));
  connect(converter_s.port_p, reluctance_s.port_p)
    annotation (Line(points={{40,20},{62,20}}, color={255,128,0}));
  annotation (experiment(StopTime=100, Interval=0.01), Documentation(info="<html>
<p>
This example compares an electric polyphase inductor with equivalent fundamental wave reluctance circuits, 
one with reluctances individual for each phase (s) and the other with a common reluctance for all phases (m).
The phase inductance <code>L</code> and the magnetic fundamental wave reluctance <code>R_m</code> 
for reluctances individual to the phases (s) and for a reluctance common to all phases (m) are related by:
</p>

<blockquote><pre>
R_ms = effectiveTurns^2 / L
R_mm = effectiveTurns^2 / L * m / 2
</pre></blockquote>

<p>
The currents
</p>

<ul>
<li><code>resistor_e.i[1]</code></li>
<li><code>resistor_s.i[1]</code></li>
<li><code>resistor_m.i[1]</code></li>
</ul>

<p>
show the same waveforms and thus prove the equivalence of the different modelling approaches. 
Note that the number of initial equations (which depends on the number of phases <code>m</code>, too) depends on either individual or common implementation of the reluctance.
</p>
</html>"));
end PolyphaseInductance;
