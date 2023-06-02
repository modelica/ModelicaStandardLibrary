within Modelica.Electrical.PowerConverters.ACDC;
model ThyristorCenterTapmPulse
  "m pulse thyristor rectifier with center tap"
  extends Icons.Converter;
  import Modelica.Constants.pi;
  // parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Resistance RonThyristor(final min=0) = 1e-05
    "Closed thyristor resistance";
  parameter SI.Conductance GoffThyristor(final min=0) = 1e-05
    "Opened thyristor conductance";
  parameter SI.Voltage VkneeThyristor(final min=0) = 0
    "Thyristor forward threshold voltage";
  parameter Boolean offStart[m]=fill(true, m)
    "Boolean start value of variable thyristor_p[:].off"
    annotation (choices(checkBox=true));
  extends PowerConverters.Interfaces.ACDC.ACplug;
  extends PowerConverters.Interfaces.ACDC.DCpin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  extends Interfaces.Enable.Enable1m;
  Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor(
    final m=m,
    final Ron=fill(RonThyristor, m),
    final Goff=fill(GoffThyristor, m),
    final Vknee=fill(VkneeThyristor, m),
    final useHeatPort=useHeatPort,
    final idealThyristor(off(start=offStart, fixed=fill(true, m))))
    "Thyristors conducting AC potentials" annotation (Placement(transformation(
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
    "ThyristorCenterTapmPulse: only odd phase numbers are allowed");
  if not useHeatPort then
    LossPower = sum(thyristor.idealThyristor.LossPower);
  end if;
  connect(thyristor.plug_n, star.plug_p) annotation (Line(
      points={{0,0},{70,0}}, color={0,0,255}));
  connect(star.pin_n, dc_p) annotation (Line(
      points={{90,0},{100,0}}, color={0,0,255}));
  connect(heatPort, thermalCollector.port_b) annotation (Line(
      points={{0,-100},{30,-100}}, color={191,0,0}));
  connect(thyristor.heatPort, thermalCollector.port_a) annotation (Line(
      points={{-10,-10},{-10,-20},{30,-20},{30,-80}}, color={191,0,0}));
  connect(ac, thyristor.plug_p) annotation (Line(
      points={{-100,0},{-20,0}}, color={0,0,255}));
  connect(andCondition_p.y, thyristor.fire) annotation (Line(
      points={{-60,-69},{-60,20},{1.77636e-15,20},{1.77636e-15,11.8}},
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
This is a m pulse thyristor rectifier with center tap. All voltage sources must have one interconnected plug (tap). This rectifiers works only with odd number of phases due the symmetry constrains of even phase numbers implemented in
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a>.
See example
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse\">Examples.ACDC.RectifierCenterTapmPulse</a>.
</p>
</html>"));
end ThyristorCenterTapmPulse;
