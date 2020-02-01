within Modelica.Electrical.PowerConverters.ACDC;
model ThyristorCenterTap2Pulse
  "Two pulse thyristor rectifier with center tap"
  extends Icons.Converter;
  import Modelica.Constants.pi;
  parameter SI.Resistance RonThyristor(final min=0) = 1e-05
    "Closed thyristor resistance";
  parameter SI.Conductance GoffThyristor(final min=0) = 1e-05
    "Opened thyristor conductance";
  parameter SI.Voltage VkneeThyristor(final min=0) = 0
    "Thyristor forward threshold voltage";
  parameter Boolean offStart_p=true
    "Boolean start value of variable thyristor_p.off"
    annotation (choices(checkBox=true));
  parameter Boolean offStart_n=true
    "Boolean start value of variable thyristor_n.off"
    annotation (choices(checkBox=true));
  extends PowerConverters.Interfaces.ACDC.ACtwoPin;
  extends PowerConverters.Interfaces.ACDC.DCpin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  extends Interfaces.Enable.Enable2;
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_p(
    final Ron=RonThyristor,
    final Goff=GoffThyristor,
    final Vknee=VkneeThyristor,
    final useHeatPort=useHeatPort,
    final off(start=offStart_p, fixed=true))
    "Thyristors conducting positive pin AC potentials" annotation (
      Placement(transformation(
        origin={0,60},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_n(
    final Ron=RonThyristor,
    final Goff=GoffThyristor,
    final Vknee=VkneeThyristor,
    final useHeatPort=useHeatPort,
    final off(start=offStart_n, fixed=true))
    "Thyristors conducting negative pin AC potentials" annotation (
      Placement(transformation(
        origin={0,-60},
        extent={{-10,-10},{10,10}})));
equation
  if not useHeatPort then
    LossPower = thyristor_p.LossPower + thyristor_n.LossPower;
  end if;
  connect(ac_p, thyristor_p.p) annotation (Line(
      points={{-100,60},{-10,60}}, color={0,0,255}));
  connect(ac_n, thyristor_n.p) annotation (Line(
      points={{-100,-60},{-10,-60}}, color={0,0,255}));
  connect(thyristor_p.n, dc_p) annotation (Line(
      points={{10,60},{100,60},{100,0}}, color={0,0,255}));
  connect(thyristor_n.n, dc_p) annotation (Line(
      points={{10,-60},{100,-60},{100,0}}, color={0,0,255}));
  connect(thyristor_n.heatPort, heatPort) annotation (Line(
      points={{0,-70},{0,-100}}, color={191,0,0}));
  connect(thyristor_p.heatPort, heatPort) annotation (Line(
      points={{0,50},{0,40},{20,40},{20,-100},{
          0,-100}}, color={191,0,0}));
  connect(andCondition_p.y, thyristor_p.fire) annotation (Line(
      points={{-60,-69},{-60,80},{10,80},{10,72}},
                                                 color={255,0,255}));
  connect(andCondition_n.y, thyristor_n.fire) annotation (Line(
      points={{60,-69},{60,-40},{10,-40},{10,-48}},
                                                  color={255,0,255}));
  annotation (defaultComponentName="rectifier",
    Icon(coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true,
        grid={2,2}), graphics={
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

<p>This a two pulse thyristor rectifier with center tap. In order to operate this rectifier a voltage with center tap is required. The center tap has to be connected with the negative pin of the load. The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>.
</p>
</html>"));
end ThyristorCenterTap2Pulse;
