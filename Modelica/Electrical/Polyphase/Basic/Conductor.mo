within Modelica.Electrical.Polyphase.Basic;
model Conductor "Ideal linear electrical conductors"
  extends Interfaces.TwoPlug;
  parameter SI.Conductance G[m](start=fill(1, m))
    "Conductances G_ref at temperatures T_ref";
  parameter SI.Temperature T_ref[m]=fill(300.15, m)
    "Reference temperatures";
  parameter SI.LinearTemperatureCoefficient alpha[m]=zeros(m)
    "Temperature coefficients of conductances at reference temperatures";
  extends Polyphase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
  Modelica.Electrical.Analog.Basic.Conductor conductor[m](
    final G=G,
    final T_ref=T_ref,
    final alpha=alpha,
    each final useHeatPort=useHeatPort,
    final T=T) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plug_p.pin, conductor.p)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(plug_n.pin, conductor.n)
    annotation (Line(points={{100,0},{10,0}}, color={0,0,255}));
  connect(conductor.heatPort, heatPort) annotation (Line(
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
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255})}), Documentation(info="<html>
<p>
Contains m conductors (Modelica.Electrical.Analog.Basic.Conductor)
</p>
</html>"));
end Conductor;
