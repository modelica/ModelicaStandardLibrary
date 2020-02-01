within Modelica.Electrical.Polyphase.Ideal;
model IdealGTOThyristor "Polyphase ideal GTO thyristor"
  extends Interfaces.TwoPlug;
  parameter SI.Resistance Ron[m](final min=zeros(m), start=
        fill(1e-5, m)) "Closed thyristor resistance";
  parameter SI.Conductance Goff[m](final min=zeros(m), start=
        fill(1e-5, m)) "Opened thyristor conductance";
  parameter SI.Voltage Vknee[m](final min=zeros(m), start=
        zeros(m)) "Threshold voltage";
  extends Polyphase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(
        293.15, m));
  Modelica.Blocks.Interfaces.BooleanInput fire[m] annotation (Placement(
        transformation(
        origin={100,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor idealGTOThyristor[m](
    final Ron=Ron,
    final Goff=Goff,
    final Vknee=Vknee,
    each final useHeatPort=useHeatPort) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
equation
  connect(idealGTOThyristor.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(idealGTOThyristor.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(fire, idealGTOThyristor.fire) annotation (Line(points={{100,120},{100,80},{10,80},{10,12}}, color={255,0,255}));
  connect(idealGTOThyristor.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  annotation (defaultComponentName="gto", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-90,0},{40,0}}, color={0,0,255}),
        Polygon(
          points={{30,0},{-30,40},{-30,-40},{30,0}},
          lineColor={0,0,255},
          fillColor={255,255,255}),
        Line(points={{30,40},{30,-40}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Line(points={{100,90},{100,100}}, color={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-80},{150,-40}},
          textString="m=%m"),
        Line(points={{48,52},{68,32}}, color={0,0,255}),
        Polygon(
          points={{44,43},{44,36},{51,36},{44,43}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Polygon(
          points={{46,33},{53,33},{53,26},{46,33}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Line(points={{30,10},{68,48}}, color={0,0,255}),
        Line(points={{30,22},{56,48}}, color={0,0,255})}),
                                Documentation(info="<html>
<p>
Contains m ideal GTO thyristors (Modelica.Electrical.Analog.Ideal.IdealGTOThyristor).
</p>
</html>"));
end IdealGTOThyristor;
