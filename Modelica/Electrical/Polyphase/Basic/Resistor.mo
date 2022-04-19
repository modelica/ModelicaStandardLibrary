within Modelica.Electrical.Polyphase.Basic;
model Resistor "Ideal linear electrical resistors"
  extends Interfaces.TwoPlug;
  parameter SI.Resistance R[m](start=fill(1, m))
    "Resistances R_ref at temperatures T_ref";
  parameter SI.Temperature T_ref[m]=fill(300.15, m)
    "Reference temperatures";
  parameter SI.LinearTemperatureCoefficient alpha[m]=zeros(m)
    "Temperature coefficients of resistances at reference temperatures";
  extends Polyphase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
  Modelica.Electrical.Analog.Basic.Resistor resistor[m](
    final R=R,
    final T_ref=T_ref,
    final alpha=alpha,
    each final useHeatPort=useHeatPort,
    final T=T) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
equation
  connect(resistor.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(resistor.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(resistor.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-70,0}}, color={0,0,255}),
        Line(points={{70,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,-80},{150,-40}},
          textString="m=%m"),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}), Documentation(info="<html>
<p>
Contains m resistors (Modelica.Electrical.Analog.Basic.Resistor)
</p>
</html>"));
end Resistor;
