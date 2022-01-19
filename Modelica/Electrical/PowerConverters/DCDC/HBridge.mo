within Modelica.Electrical.PowerConverters.DCDC;
model HBridge "H bridge (four quadrant converter)"
  extends Icons.Converter;
  extends PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends PowerConverters.Interfaces.DCDC.DCtwoPin2;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  parameter SI.Resistance RonTransistor=1e-05
    "Transistor closed resistance";
  parameter SI.Conductance GoffTransistor=1e-05
    "Transistor opened conductance";
  parameter SI.Voltage VkneeTransistor=0
    "Transistor threshold voltage";
  parameter SI.Resistance RonDiode=1e-05
    "Diode closed resistance";
  parameter SI.Conductance GoffDiode=1e-05
    "Diode opened conductance";
  parameter SI.Voltage VkneeDiode=0 "Diode threshold voltage";
  extends Interfaces.Enable.Enable2;
  DCAC.SinglePhase2Level inverter_p(
    final RonTransistor=RonTransistor,
    final GoffTransistor=GoffTransistor,
    final VkneeTransistor=VkneeTransistor,
    final RonDiode=RonDiode,
    final GoffDiode=GoffDiode,
    final VkneeDiode=VkneeDiode,
    final useHeatPort=useHeatPort)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  DCAC.SinglePhase2Level inverter_n(
    final RonTransistor=RonTransistor,
    final GoffTransistor=GoffTransistor,
    final VkneeTransistor=VkneeTransistor,
    final RonDiode=RonDiode,
    final GoffDiode=GoffDiode,
    final VkneeDiode=VkneeDiode,
    final useHeatPort=useHeatPort)
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Blocks.Interfaces.BooleanInput fire_p
    "Firing signals of positive potential leg" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.BooleanInput fire_n
    "Firing signals of negative potential leg" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Blocks.Logical.Not not_p
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Blocks.Logical.Not not_n
    annotation (Placement(transformation(extent={{50,-60},{30,-40}})));
equation
  if not useHeatPort then
    LossPower = inverter_p.LossPower + inverter_n.LossPower;
  end if;
  connect(inverter_n.heatPort, heatPort) annotation (Line(
      points={{20,-30},{20,-100},{0,-100}},                       color={191,0,0}));
  connect(inverter_p.heatPort, heatPort) annotation (Line(
      points={{-20,20},{-20,-100},{0,-100}}, color={191,0,0}));
  connect(dc_p1, inverter_p.dc_p) annotation (Line(
      points={{-100,60},{-70,60},{-70,36},{-30,36}}, color={0,0,255}));
  connect(dc_p1, inverter_n.dc_p) annotation (Line(
      points={{-100,60},{-70,60},{-70,-14},{10,-14}},  color={0,0,255}));
  connect(dc_n1, inverter_n.dc_n) annotation (Line(
      points={{-100,-60},{-80,-60},{-80,-26},{10,-26}},  color={0,0,255}));
  connect(dc_n1, inverter_p.dc_n) annotation (Line(
      points={{-100,-60},{-80,-60},{-80,24},{-30,24}}, color={0,0,255}));
  connect(inverter_p.ac, dc_p2) annotation (Line(
      points={{-10,30},{100,30},{100,60}},
                                         color={0,0,255}));
  connect(inverter_n.ac, dc_n2) annotation (Line(
      points={{30,-20},{100,-20},{100,-60}},  color={0,0,255}));
  connect(andCondition_p.y, inverter_p.fire_p) annotation (Line(points={{-60,-69},
          {-60, 14},{-26, 14},{-26,18}}, color={255,0,255}));
  connect(andCondition_n.y, inverter_n.fire_p) annotation (Line(points={{60,-69},
          {60, -64},{14, -64},{14,-32}}, color={255,0,255}));
  connect(not_p.y, inverter_p.fire_n)
    annotation (Line(points={{-29,0},{-14,0},{-14,18}}, color={255,0,255}));
  connect(andCondition_p.y, not_p.u)
    annotation (Line(points={{-60,-69},{-60,0},{-52,0}}, color={255,0,255}));
  connect(andCondition_n.y, not_n.u)
    annotation (Line(points={{60,-69},{60,-50},{52,-50}}, color={255,0,255}));
  connect(not_n.y, inverter_n.fire_n)
    annotation (Line(points={{29,-50},{26,-50},{26,-32}}, color={255,0,255}));
  annotation (defaultComponentName="dcdc",
    Icon(graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{0,-50},{100,-70}},
          textColor={0,0,255},
          textString="DC out"),
        Text(
          extent={{-100,70},{0,50}},
          textColor={0,0,255},
          textString="DC in"),
        Line(
          points={{-40,0},{-28,0}},
          color={0,0,255}),
        Line(
          points={{-28,20},{-28,-20}},
          color={0,0,255}),
        Line(
          points={{-20,20},{-20,-20}},
          color={0,0,255}),
        Line(
          points={{-20,4},{0,24},{0,40}},
          color={0,0,255}),
        Line(
          points={{-20,-4},{0,-24},{0,-40}},
          color={0,0,255}),
        Line(
          points={{-4,-20},{-10,-8},{-16,-14},{-4,-20}},
          color={0,0,255}),
        Line(
          points={{0,-24},{10,-24},{10,24},{0,24}},
          color={0,0,255}),
        Line(
          points={{0,8},{20,8}},
          color={0,0,255}),
        Line(
          points={{10,8},{0,-8},{20,-8},{10,8}},
          color={0,0,255})}),
    Documentation(info="<html>
<p>
The H bridge is a four quadrant DC/DC converter. It consists of two single-phase DC/AC converters which are controlled differently; see Fig.&nbsp;1.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1:</strong> H bridge</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/PowerConverters/Hbridge.png\">
    </td>
  </tr>
</table>

<p>If the firing inputs <code>fire_p</code> and <code>fire_n</code> are inverse, the two legs are controlled symmetrically so that full positive or negative output voltage can be generated.
See examples <a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCDC.HBridge\">DCDC.HBridge</a>.
</p>

<h4>Note</h4>
<p>In the first version, the following signal connections were implementented:</p>
<ul>
<li>fire_p to inverter_p.fire_p and inverter_n.fire_n</li>
<li>fire_n to inverter_p.fire_n and inverter_n.fire_p</li>
</ul>
<p>Therefore the two fire signal had be supplied complentary to avoid a short circuit on the source.</p>
<p>In the enhanced version, the following signal connections are implementented:</p>
<ul>
<li>inverter_p.fire_p to fire_p</li>
<li>inverter_p.fire_n to not fire_p</li>
<li>inverter_n.fire_p to fire_n</li>
<li>inverter_n.fire_n to not fire_n</li>
</ul>
<p>Therefore a short circuit on the source is avoided intrinsically.</p>
<p>
If both versions are provided with the same (complementary) fire signals, identical results are obtained. 
Additionally, two more switching states are possible: 
fire_p = fire_n = true (which means switching on both upper switches) and fire_p = fire_n = false (which means switching on both lower switches).
</p>
</html>"));
end HBridge;
