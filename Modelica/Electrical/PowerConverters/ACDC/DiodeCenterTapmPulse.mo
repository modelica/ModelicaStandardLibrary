within Modelica.Electrical.PowerConverters.ACDC;
model DiodeCenterTapmPulse "m pulse diode rectifier with center tap"
  import Modelica.Constants.pi;
  extends Icons.Converter;
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Resistance RonDiode(final min=0) = 1e-05
    "Closed diode resistance";
  parameter SI.Conductance GoffDiode(final min=0) = 1e-05
    "Opened diode conductance";
  parameter SI.Voltage VkneeDiode(final min=0) = 0
    "Diode forward threshold voltage";
  extends PowerConverters.Interfaces.ACDC.ACplug;
  extends PowerConverters.Interfaces.ACDC.DCpin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode(
    final m=m,
    final Ron=fill(RonDiode, m),
    final Goff=fill(GoffDiode, m),
    final Vknee=fill(VkneeDiode, m),
    final useHeatPort=useHeatPort)
    "Diodes connected to positive DC potential" annotation (Placement(
        transformation(
        origin={-10,0},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m)
    annotation (Placement(transformation(extent={{70,10},{90,-10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalCollector(final m=m) if useHeatPort
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
equation
  assert(mod(m, 2) == 1,
    "DiodeCenterTapmPulse: only odd phase numbers are allowed");
  if not useHeatPort then
    LossPower = sum(diode.idealDiode.LossPower);
  end if;
  connect(diode.plug_n, star.plug_p) annotation (Line(
      points={{0,0},{70,0}}, color={0,0,255}));
  connect(star.pin_n, dc_p) annotation (Line(
      points={{90,0},{100,0}}, color={0,0,255}));
  connect(heatPort, thermalCollector.port_b) annotation (Line(
      points={{0,-100},{30,-100}}, color={191,0,0}));
  connect(diode.heatPort, thermalCollector.port_a) annotation (Line(
      points={{-10,-10},{-10,-20},{30,-20},{30,-80}}, color={191,0,0}));
  connect(ac, diode.plug_p) annotation (Line(
      points={{-100,0},{-20,0}}, color={0,0,255}));
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
          color={0,0,255})}),
    Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>.
</p>

<p>
This is a m pulse diode rectifier with center tap. All voltage sources must have one interconnected plug (tap). This rectifiers works only with odd number of phases due the symmetry constrains of even phase numbers implemented in
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a>.
The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse\">Examples.ACDC.RectifierCenterTapmPulse</a>.
</p>
</html>"));
end DiodeCenterTapmPulse;
