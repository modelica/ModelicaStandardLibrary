within Modelica.Electrical.PowerConverters.ACDC;
model DiodeCenterTap2Pulse "Two pulse diode rectifier with center tap"
  extends Icons.Converter;
  import Modelica.Constants.pi;
  parameter SI.Resistance RonDiode(final min=0) = 1e-05
    "Closed diode resistance";
  parameter SI.Conductance GoffDiode(final min=0) = 1e-05
    "Opened diode conductance";
  parameter SI.Voltage VkneeDiode(final min=0) = 0
    "Diode forward threshold voltage";
  extends PowerConverters.Interfaces.ACDC.ACtwoPin;
  extends PowerConverters.Interfaces.ACDC.DCpin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_p(
    final Ron=RonDiode,
    final Goff=GoffDiode,
    final Vknee=VkneeDiode,
    final useHeatPort=useHeatPort)
    "Diodes conducting positive pin AC potentials" annotation (Placement(
        transformation(
        origin={0,60},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_n(
    final Ron=RonDiode,
    final Goff=GoffDiode,
    final Vknee=VkneeDiode,
    final useHeatPort=useHeatPort)
    "Diodes conducting negative pin AC potentials" annotation (Placement(
        transformation(
        origin={0,-60},
        extent={{-10,-10},{10,10}})));
equation
  if not useHeatPort then
    LossPower = diode_p.LossPower + diode_n.LossPower;
  end if;
  connect(ac_p, diode_p.p) annotation (Line(
      points={{-100,60},{-10,60}}, color={0,0,255}));
  connect(ac_n, diode_n.p) annotation (Line(
      points={{-100,-60},{-10,-60}}, color={0,0,255}));
  connect(diode_p.n, dc_p) annotation (Line(
      points={{10,60},{100,60},{100,0}}, color={0,0,255}));
  connect(diode_n.n, dc_p) annotation (Line(
      points={{10,-60},{100,-60},{100,0}}, color={0,0,255}));
  connect(diode_n.heatPort, heatPort) annotation (Line(
      points={{0,-70},{0,-100}}, color={191,0,0}));
  connect(diode_p.heatPort, heatPort) annotation (Line(
      points={{0,50},{0,40},{20,40},{20,-100},{
          0,-100}}, color={191,0,0}));
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
          color={0,0,255})}),
    Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a two pulse diode rectifier with center tap. In order to operate this rectifier a voltage with center tap is required. The center tap has to be connected with the negative pin of the load. The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>.
</p>
</html>"));
end DiodeCenterTap2Pulse;
