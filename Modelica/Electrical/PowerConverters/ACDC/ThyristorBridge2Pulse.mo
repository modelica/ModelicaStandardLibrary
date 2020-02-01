within Modelica.Electrical.PowerConverters.ACDC;
model ThyristorBridge2Pulse "Two pulse Graetz thyristor rectifier bridge"
  extends Icons.Converter;
  import Modelica.Constants.pi;
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
  parameter Boolean offStart_n1=true
    "Boolean start value of variable thyristor_n1.off"
    annotation (choices(checkBox=true));
  parameter Boolean offStart_n2=true
    "Boolean start value of variable thyristor_n2.off"
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
    final off(start=offStart_p1, fixed=true))
    "Thyristor connecting the positive AC input pin with positive DC output"
    annotation (Placement(transformation(
        origin={-20,50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_p2(
    final Ron=RonThyristor,
    final Goff=GoffThyristor,
    final Vknee=VkneeThyristor,
    final useHeatPort=useHeatPort,
    final off(start=offStart_p2, fixed=true))
    "Thyristor connecting the negative AC input pin with positive DC output"
    annotation (Placement(transformation(
        origin={20,50},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_n1(
    final Ron=RonThyristor,
    final Goff=GoffThyristor,
    final Vknee=VkneeThyristor,
    final useHeatPort=useHeatPort,
    final off(start=offStart_n1, fixed=true))
    "Thyristor connecting the positive AC input with negative DC output"
    annotation (Placement(transformation(
        origin={-20,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_n2(
    final Ron=RonThyristor,
    final Goff=GoffThyristor,
    final Vknee=VkneeThyristor,
    final useHeatPort=useHeatPort,
    final off(start=offStart_n2, fixed=true))
    "Thyristor connecting the negative AC input with negative DC output"
    annotation (Placement(transformation(
        origin={20,-50},
        extent={{-10,10},{10,-10}},
        rotation=90)));
equation
  if not useHeatPort then
    LossPower = thyristor_p1.LossPower + thyristor_p2.LossPower +
      thyristor_n1.LossPower + thyristor_n2.LossPower;
  end if;
  connect(thyristor_p2.n, thyristor_p1.n) annotation (Line(
      points={{20,60},{-20,60}}, color={0,0,255}));
  connect(thyristor_n1.p, thyristor_n2.p) annotation (Line(
      points={{-20,-60},{20,-60}}, color={0,0,255}));
  connect(thyristor_n2.n, thyristor_p2.p) annotation (Line(
      points={{20,-40},{20,40}}, color={0,0,255}));
  connect(thyristor_p1.p, thyristor_n1.n) annotation (Line(
      points={{-20,40},{-20,-40}}, color={0,0,255}));
  connect(thyristor_p1.n, dc_p) annotation (Line(
      points={{-20,60},{100,60}}, color={0,0,255}));
  connect(thyristor_n1.p, dc_n) annotation (Line(
      points={{-20,-60},{100,-60}}, color={0,0,255}));
  connect(thyristor_n1.heatPort, heatPort) annotation (Line(
      points={{-10,-50},{0,-50},{0,-100}}, color={191,0,0}));
  connect(thyristor_n2.heatPort, heatPort) annotation (Line(
      points={{10,-50},{0,-50},{0,-100}}, color={191,0,0}));
  connect(thyristor_p1.heatPort, heatPort) annotation (Line(
      points={{-10,50},{0,50},{0,-100}}, color={191,0,0}));
  connect(thyristor_p2.heatPort, heatPort) annotation (Line(
      points={{10,50},{0,50},{0,-100}}, color={191,0,0}));
  connect(ac_p, thyristor_p1.p) annotation (Line(
      points={{-100,60},{-100,20},{-20,20},{-20,40}}, color={0,0,255}));
  connect(ac_n, thyristor_n2.n) annotation (Line(
      points={{-100,-60},{-100,-20},{20,-20},{20,-40}}, color={0,0,255}));
  connect(andCondition_p.y, thyristor_p1.fire) annotation (Line(
      points={{-60,-69},{-60,60},{-32,60}}, color={255,0,255}));
  connect(andCondition_p.y, thyristor_n2.fire) annotation (Line(
      points={{-60,-69},{-60,-30},{40,-30},{40,-40},{32,-40}}, color={255,0,255}));
  connect(andCondition_n.y, thyristor_p2.fire) annotation (Line(
      points={{60,-69},{60,60},{32,60}}, color={255,0,255}));
  connect(andCondition_n.y, thyristor_n1.fire) annotation (Line(
      points={{60,-69},{60,-66},{-40,-66},{-40,-40},{-32,-40}}, color={255,0,255}));
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
          extent={{-40,24},{40,-24}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,0},{40,0}},
          color={0,0,255}),
        Line(
          points={{20,24},{20,-24}},
          color={0,0,255}),
        Line(
          points={{20,0},{-20,24},{-20,-24},{20,0}},
          color={0,0,255}),
        Line(
          points={{0,12},{0,28}},
          color={0,0,255})}),
    Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a two pulse Graetz thyristor rectifier bridge. The firing signal <code>fire_p</code> are connected
with thyristor <code>thyristor_p1</code> and <code>thyristor_n2</code>.
The firing signal <code>fire_n</code> are connected
with thyristor <code>thyristor_p2</code> and <code>thyristor_n1</code>. See example
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>.
</p>
</html>"));
end ThyristorBridge2Pulse;
