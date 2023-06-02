within Modelica.Electrical.PowerConverters.ACDC;
model ThyristorCenterTap2mPulse
  "2*m pulse thyristor rectifier with center tap"
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
  extends PowerConverters.Interfaces.ACDC.ACtwoPlug;
  extends PowerConverters.Interfaces.ACDC.DCpin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  extends Interfaces.Enable.Enable2m;
  Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor_p(
    final m=m,
    final Ron=fill(RonThyristor, m),
    final Goff=fill(GoffThyristor, m),
    final Vknee=fill(VkneeThyristor, m),
    final useHeatPort=useHeatPort,
    final idealThyristor(off(start=offStart_p, fixed=fill(true, m))))
    "Thyristors conducting positive plug AC potentials" annotation (
      Placement(transformation(
        origin={-10,60},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor_n(
    final m=m,
    final Ron=fill(RonThyristor, m),
    final Goff=fill(GoffThyristor, m),
    final Vknee=fill(VkneeThyristor, m),
    final useHeatPort=useHeatPort,
    final idealThyristor(off(start=offStart_n, fixed=fill(true, m))))
    "Thyristors conducting negative plug AC potentials" annotation (
      Placement(transformation(
        origin={-10,-60},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m)
    annotation (Placement(transformation(extent={{70,70},{90,50}})));
  Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m)
    annotation (Placement(transformation(extent={{72,-50},{92,-70}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalCollector(final m=m) if useHeatPort
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
equation
  if not useHeatPort then
    LossPower = sum(thyristor_p.idealThyristor.LossPower) + sum(thyristor_n.idealThyristor.LossPower);
  end if;
  connect(thyristor_p.plug_n, star_p.plug_p) annotation (Line(
      points={{0,60},{70,60}}, color={0,0,255}));
  connect(star_p.pin_n, dc_p) annotation (Line(
      points={{90,60},{100,60},{100,0}}, color={0,0,255}));
  connect(heatPort, thermalCollector.port_b) annotation (Line(
      points={{0,-100},{30,-100}}, color={191,0,0}));
  connect(thermalCollector.port_a, thyristor_n.heatPort) annotation (Line(
      points={{30,-80},{-10,-80},{-10,-70}}, color={191,0,0}));
  connect(thyristor_p.heatPort, thermalCollector.port_a) annotation (Line(
      points={{-10,50},{-10,40},{30,40},{30,-80}}, color={191,0,0}));
  connect(ac_p, thyristor_p.plug_p) annotation (Line(
      points={{-100,60},{-20,60}}, color={0,0,255}));
  connect(star_n.pin_n, dc_p) annotation (Line(
      points={{92,-60},{100,-60},{100,0}}, color={0,0,255}));
  connect(thyristor_n.plug_p, ac_n) annotation (Line(
      points={{-20,-60},{-100,-60}}, color={0,0,255}));
  connect(thyristor_n.plug_n, star_n.plug_p) annotation (Line(
      points={{0,-60},{72,-60}}, color={0,0,255}));
  connect(andCondition_p.y, thyristor_p.fire) annotation (Line(
      points={{-60,-69},{-60,80},{1.77636e-15,80},{1.77636e-15,71.8}},
                                                   color={255,0,255}));
  connect(andCondition_n.y, thyristor_n.fire) annotation (Line(
      points={{60,-69},{60,-40},{1.77636e-15,-40},{1.77636e-15,-48.2}},
                                                    color={255,0,255}));
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
This is a 2*m pulse thyristor rectifier with center tap. In order to operate this rectifier a voltage source with center tap is required. The center tap has to be connected with the negative pin of the load. See example
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2mPulse\">Examples.ACDC.RectifierCenterTap2mPulse</a>.
</p>
</html>"));
end ThyristorCenterTap2mPulse;
