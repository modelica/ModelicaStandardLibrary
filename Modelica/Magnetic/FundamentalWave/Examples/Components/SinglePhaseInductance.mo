within Modelica.Magnetic.FundamentalWave.Examples.Components;
model SinglePhaseInductance "Single-phase inductance"
  extends Modelica.Icons.Example;
  parameter SI.Frequency f=1 "Supply frequency";
  parameter SI.Voltage VRMS=100 "RMS supply voltage";
  parameter SI.Resistance R=0.1 "Leader cable resistance";
  parameter SI.Inductance L=1 "Load inductance";
  parameter Real effectiveTurns=5 "Effective number of turns";
  final parameter SI.Reluctance R_m=effectiveTurns^2/L
    "Equivalent magnetic reluctance";
  Modelica.Electrical.Analog.Basic.Ground ground_e
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Modelica.Electrical.Analog.Basic.Ground ground_m
    annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  Modelica.Electrical.Analog.Sources.SineVoltage voltageSource_e(
    f=f,
    V=sqrt(2)*VRMS,
    phase=Modelica.Constants.pi/2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,70})));
  Modelica.Electrical.Analog.Sources.SineVoltage voltageSource_m(
    f=f,
    V=sqrt(2)*VRMS,
    phase=Modelica.Constants.pi/2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-30})));
  Modelica.Electrical.Analog.Basic.Resistor resistor_e(R=R)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor_m(R=R)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor_e(L=L) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,70})));
  Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter converter_m(
      effectiveTurns=effectiveTurns, orientation=0)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Magnetic.FundamentalWave.Components.Reluctance reluctance_m(R_m(d=R_m, q=R_m))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-30})));
  Magnetic.FundamentalWave.Components.Ground groundM_m
    annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
initial equation
  resistor_e.i = 0;
  resistor_m.i = 0;
equation
  connect(converter_m.port_p, reluctance_m.port_p) annotation (Line(
      points={{20,-20},{60,-20}}, color={255,128,0}));
  connect(converter_m.port_n, reluctance_m.port_n) annotation (Line(
      points={{20,-40},{60,-40}}, color={255,128,0}));
  connect(converter_m.port_n, groundM_m.port_p) annotation (Line(
      points={{20,-40},{20,-60}}, color={255,128,0}));
  connect(voltageSource_e.n, inductor_e.n) annotation (Line(
      points={{-60,60},{0,60}}, color={0,0,255}));
  connect(voltageSource_e.n, ground_e.p) annotation (Line(
      points={{-60,60},{-60,40}}, color={0,0,255}));
  connect(voltageSource_m.n, converter_m.pin_n) annotation (Line(
      points={{-60,-40},{0,-40}}, color={0,0,255}));
  connect(voltageSource_m.n, ground_m.p) annotation (Line(
      points={{-60,-40},{-60,-60}}, color={0,0,255}));
  connect(voltageSource_e.p, resistor_e.p) annotation (Line(
      points={{-60,80},{-40,80}}, color={0,0,255}));
  connect(resistor_e.n, inductor_e.p) annotation (Line(
      points={{-20,80},{0,80}}, color={0,0,255}));
  connect(voltageSource_m.p, resistor_m.p) annotation (Line(
      points={{-60,-20},{-40,-20}}, color={0,0,255}));
  connect(resistor_m.n, converter_m.pin_p) annotation (Line(
      points={{-20,-20},{0,-20}}, color={0,0,255}));
  annotation (experiment(StopTime=100, Interval=0.01), Documentation(info="<html>
<p>
This example compares an electric single-phase inductor with an equivalent fundamental wave reluctance circuit.
The phase inductance <code>L</code> and the magnetic fundamental wave reluctance <code>R_m</code> are related by:
</p>

<blockquote><pre>
R_m = effectiveTurns^2 / L
</pre></blockquote>

<p>
The two currents
</p>

<ul>
<li><code>resistor_e.i</code></li>
<li><code>resistor_m.i</code></li>
</ul>

<p>
show the same waveforms and thus prove the equivalence of the two different modelling approaches.
</p>
</html>"));
end SinglePhaseInductance;
