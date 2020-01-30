within Modelica.Electrical.Polyphase.Ideal;
model IdealThyristor "Polyphase ideal thyristor"
  extends Interfaces.TwoPlug;
  parameter SI.Resistance Ron[m](final min=zeros(m), start=
        fill(1e-5, m)) "Closed thyristor resistance";
  parameter SI.Conductance Goff[m](final min=zeros(m), start=
        fill(1e-5, m)) "Opened thyristor conductance";
  parameter SI.Voltage Vknee[m](final min=zeros(m), start=
        zeros(m)) "Threshold voltage";
  Boolean off[m] = idealThyristor.off "Alias of boolean thyristor off";
  extends Polyphase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(
        293.15, m));
  Modelica.Blocks.Interfaces.BooleanInput fire[m] annotation (Placement(
        transformation(
        origin={100,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,118})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor idealThyristor[m](
    final Ron=Ron,
    final Goff=Goff,
    final Vknee=Vknee,
    each final useHeatPort=useHeatPort) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plug_p.pin, idealThyristor.p) annotation (Line(points={{-100,0},{
          -60,0},{-38,0},{-10,0}}, color={0,0,255}));
  connect(idealThyristor.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(fire, idealThyristor.fire) annotation (Line(points={{100,120},{100,80},{10,80},{10,12}}, color={255,0,255}));
  connect(idealThyristor.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  annotation (defaultComponentName="thyristor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-90,0},{40,0}}, color={0,0,255}),
        Polygon(
          points={{30,0},{-30,40},{-30,-40},{30,0}},
          lineColor={0,0,255},
          fillColor={255,255,255}),
        Line(points={{30,40},{30,-40}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,-80},{150,-40}},
          textString="m=%m"),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{40,50},{60,30}}, color={0,0,255}),
        Line(points={{30,20},{58,48}}, color={0,0,255}),
        Line(points={{100,90},{100,100}}, color={0,0,255})}),
                                Documentation(info="<html>
<p>
Contains m ideal thyristors (Modelica.Electrical.Analog.Ideal.IdealThyristor).
</p>
</html>"));
end IdealThyristor;
