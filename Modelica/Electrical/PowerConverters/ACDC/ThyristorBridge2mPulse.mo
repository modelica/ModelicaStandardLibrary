within Modelica.Electrical.PowerConverters.ACDC;
model ThyristorBridge2mPulse "2*m pulse thyristor rectifier bridge"
  extends Icons.Converter;
  import Modelica.Constants.pi;
  // parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Resistance RonThyristor(final min=0) = 1e-05
    "Closed thyristor resistance";
  parameter SI.Conductance GoffThyristor(final min=0) = 1e-05
    "Opened thyristor conductance";
  parameter SI.Voltage VkneeThyristor(final min=0) = 0
    "Thyristor forward threshold voltage";
  parameter Boolean offStart_p[m]=fill(true, m)
    "Boolean start value of variable thyristor_p[:].off"
    annotation (choices(checkBox=true));
  parameter Boolean offStart_n[m]=fill(true, m)
    "Boolean start value of variable thyristor_n[:].off"
    annotation (choices(checkBox=true));
  extends PowerConverters.Interfaces.ACDC.ACplug;
  extends PowerConverters.Interfaces.ACDC.DCtwoPin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  extends Interfaces.Enable.Enable2m;
  Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor_p(
    final m=m,
    final Ron=fill(RonThyristor, m),
    final Goff=fill(GoffThyristor, m),
    final Vknee=fill(VkneeThyristor, m),
    final useHeatPort=useHeatPort,
    final idealThyristor(off(start=offStart_p, fixed=fill(true, m))))
    "Thyristors connected to positive DC potential" annotation (Placement(
        transformation(
        origin={0,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor_n(
    final m=m,
    final Ron=fill(RonThyristor, m),
    final Goff=fill(GoffThyristor, m),
    final Vknee=fill(VkneeThyristor, m),
    final useHeatPort=useHeatPort,
    final idealThyristor(off(start=offStart_n, fixed=fill(true, m))))
    "Thyristors connected to negative DC potential" annotation (Placement(
        transformation(
        origin={0,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m)
    annotation (Placement(transformation(extent={{70,70},{90,50}})));
  Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m)
    annotation (Placement(transformation(extent={{70,-20},{90,-40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalConnector(final m=m) if useHeatPort
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  Modelica.Blocks.Logical.Pre pre_p[m] annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-36})));
  Modelica.Blocks.Logical.Pre pre_n[m] annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-36})));
equation
  if not useHeatPort then
    LossPower = sum(thyristor_p.idealThyristor.LossPower) + sum(thyristor_n.idealThyristor.LossPower);
  end if;
  connect(ac, thyristor_p.plug_p) annotation (Line(
      points={{-100,0},{0,0},{0,30}}, color={0,0,255}));
  connect(thyristor_p.plug_p, thyristor_n.plug_n) annotation (Line(
      points={{0,30},{0,0}}, color={0,0,255}));
  connect(thyristor_p.plug_n, star_p.plug_p) annotation (Line(
      points={{0,50},{0,60},{70,60}}, color={0,0,255}));
  connect(star_p.pin_n, dc_p) annotation (Line(
      points={{90,60},{100,60}}, color={0,0,255}));
  connect(thyristor_n.plug_p, star_n.plug_p) annotation (Line(
      points={{0,-20},{0,-30},{70,-30}}, color={0,0,255}));
  connect(star_n.pin_n, dc_n) annotation (Line(
      points={{90,-30},{100,-30},{100,-60},{100,-60}}, color={0,0,255}));
  connect(heatPort, thermalConnector.port_b) annotation (Line(
      points={{0,-100},{20,-100}}, color={191,0,0}));
  connect(thermalConnector.port_a, thyristor_n.heatPort) annotation (Line(
      points={{20,-80},{20,-10},{10,-10}}, color={191,0,0}));
  connect(thyristor_p.heatPort, thermalConnector.port_a) annotation (Line(
      points={{10,40},{20,40},{20,-80}}, color={191,0,0}));
  connect(andCondition_p.y, pre_p.u)
    annotation (Line(points={{-60,-69},{-60,-48}}, color={255,0,255}));
  connect(pre_p.y, thyristor_p.fire) annotation (Line(points={{-60,-25},{-60,-25},{-60,46},{-60,50},{-11.8,50}},
                                                color={255,0,255}));
  connect(pre_n.y, thyristor_n.fire) annotation (Line(points={{-20,-25},{-20,0},{-11.8,0}},
                             color={255,0,255}));
  connect(andCondition_n.y, pre_n.u) annotation (Line(points={{60,-69},{60,
          -60},{-20,-60},{-20,-48}}, color={255,0,255}));
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
This is a 2*m pulse thyristor rectifier bridge. In order to operate this rectifier a voltage source with center tap is required. It is important to note that for polyphase circuits with phase even phase numbers greater than three the
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStarResistance\">MultiStarResistance</a> shall be used for grounding the voltage sources.
See example
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse\">Examples.ACDC.RectifierBridge2mPulse</a>.
</p>
</html>"));
end ThyristorBridge2mPulse;
