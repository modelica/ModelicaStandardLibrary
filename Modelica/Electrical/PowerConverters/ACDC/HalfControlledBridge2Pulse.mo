within Modelica.Electrical.PowerConverters.ACDC;
model HalfControlledBridge2Pulse
  "Two pulse Graetz half controlled rectifier bridge"
  import Modelica.Constants.pi;
  extends Icons.Converter;
  parameter SI.Resistance RonDiode(final min=0) = 1e-05
    "Closed diode resistance";
  parameter SI.Conductance GoffDiode(final min=0) = 1e-05
    "Opened diode conductance";
  parameter SI.Voltage VkneeDiode(final min=0) = 0
    "Diode forward threshold voltage";
  parameter SI.Resistance RonThyristor(final min=0) = 1e-05
    "Closed thyristor resistance";
  parameter SI.Conductance GoffThyristor(final min=0) = 1e-05
    "Opened thyristor conductance";
  parameter SI.Voltage VkneeThyristor(final min=0) = 0
    "Thyristor forward threshold voltage";
  parameter Boolean offStart_p1=true
    "Boolean start value of variable thyristor_p1.off"
    annotation (choices(checkBox=true));
  parameter Boolean offStart_p2=true
    "Boolean start value of variable thyristor_p2.off"
    annotation (choices(checkBox=true));
  extends PowerConverters.Interfaces.ACDC.ACtwoPin;
  extends PowerConverters.Interfaces.ACDC.DCtwoPin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  extends Interfaces.Enable.Enable2;
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_p1(
    final Ron=RonThyristor,
    final Goff=GoffThyristor,
    final Vknee=VkneeThyristor,
    final useHeatPort=useHeatPort,
    final off(start=offStart_p1, fixed=true)) annotation (Placement(transformation(
        origin={-20,50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_p2(
    final Ron=RonThyristor,
    final Goff=GoffThyristor,
    final Vknee=VkneeThyristor,
    final useHeatPort=useHeatPort,
    final off(start=offStart_p2, fixed=true)) annotation (Placement(transformation(
        origin={20,50},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_n1(
    final Ron=RonDiode,
    final Goff=GoffDiode,
    final Vknee=VkneeDiode,
    final useHeatPort=useHeatPort)
    "Diode connected to negative DC potential" annotation (Placement(
        transformation(
        origin={-20,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_n2(
    final Ron=RonDiode,
    final Goff=GoffDiode,
    final Vknee=VkneeDiode,
    final useHeatPort=useHeatPort)
    "Diode connected to negative DC potential" annotation (Placement(
        transformation(
        origin={20,-50},
        extent={{-10,10},{10,-10}},
        rotation=90)));
equation
  if not useHeatPort then
    LossPower = thyristor_p1.LossPower + thyristor_p2.LossPower + diode_n1.LossPower
       + diode_n2.LossPower;
  end if;
  connect(thyristor_p2.n, thyristor_p1.n) annotation (Line(
      points={{20,60},{-20,60}}, color={0,0,255}));
  connect(diode_n1.p, diode_n2.p) annotation (Line(
      points={{-20,-60},{20,-60}}, color={0,0,255}));
  connect(diode_n2.n, thyristor_p2.p) annotation (Line(
      points={{20,-40},{20,40}}, color={0,0,255}));
  connect(thyristor_p1.p, diode_n1.n) annotation (Line(
      points={{-20,40},{-20,-40}}, color={0,0,255}));
  connect(thyristor_p1.n, dc_p) annotation (Line(
      points={{-20,60},{100,60}}, color={0,0,255}));
  connect(diode_n1.p, dc_n) annotation (Line(
      points={{-20,-60},{100,-60}}, color={0,0,255}));
  connect(diode_n1.heatPort, heatPort) annotation (Line(
      points={{-10,-50},{0,-50},{0,-100}}, color={191,0,0}));
  connect(diode_n2.heatPort, heatPort) annotation (Line(
      points={{10,-50},{0,-50},{0,-100}}, color={191,0,0}));
  connect(thyristor_p1.heatPort, heatPort) annotation (Line(
      points={{-10,50},{0,50},{0,-100}}, color={191,0,0}));
  connect(thyristor_p2.heatPort, heatPort) annotation (Line(
      points={{10,50},{0,50},{0,-100}}, color={191,0,0}));
  connect(ac_p, thyristor_p1.p) annotation (Line(
      points={{-100,60},{-100,20},{-20,20},{-20,40}}, color={0,0,255}));
  connect(ac_n, diode_n2.n) annotation (Line(
      points={{-100,-60},{-100,-20},{20,-20},{20,-40}}, color={0,0,255}));
  connect(andCondition_p.y, thyristor_p1.fire) annotation (Line(
      points={{-60,-69},{-60,60},{-32,60}}, color={255,0,255}));
  connect(andCondition_n.y, thyristor_p2.fire) annotation (Line(
      points={{60,-69},{60,60},{32,60}}, color={255,0,255}));
  annotation (defaultComponentName="rectifier",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,70},{0,50}},
          textColor={0,0,255},
          textString="AC"),
        Text(
          extent={{0,-50},{100,-70}},
          textColor={0,0,255},
          textString="DC"),
        Rectangle(
          extent={{-44,50},{36,2}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-44,26},{36,26}},
          color={0,0,255}),
        Line(
          points={{16,50},{16,2}},
          color={0,0,255}),
        Line(
          points={{16,26},{-24,50},{-24,2},{16,26}},
          color={0,0,255}),
        Rectangle(
          extent={{-44,2},{36,-54}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-44,-30},{36,-30}},
          color={0,0,255}),
        Line(
          points={{16,-6},{16,-54}},
          color={0,0,255}),
        Line(
          points={{16,-30},{-24,-6},{-24,-54},{16,-30}},
          color={0,0,255}),
        Line(
          points={{-4,-18},{-4,-2}},
          color={0,0,255})}),
    Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a two pulse Graetz half controlled rectifier bridge. The firing signal <code>fire_p</code> is connected
with thyristor <code>thyristor_p1</code>.
The firing signal <code>fire_n</code> is connected
with thyristor <code>thyristor_p2</code>.
The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>.
</p>
</html>"));
end HalfControlledBridge2Pulse;
