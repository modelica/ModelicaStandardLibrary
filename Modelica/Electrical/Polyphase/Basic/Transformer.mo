within Modelica.Electrical.Polyphase.Basic;
model Transformer "Polyphase Transformer"
  extends Interfaces.FourPlug;
  parameter SI.Inductance L1[m](start=fill(1, m))
    "Primary inductance";
  parameter SI.Inductance L2[m](start=fill(1, m))
    "Secondary inductance";
  parameter SI.Inductance M[m](start=fill(1, m))
    "Coupling inductance";
  Modelica.Electrical.Analog.Basic.Transformer transformer[m](
    final L1=L1,
    final L2=L2,
    final M=M) annotation (Placement(transformation(extent={{-10,-10},{10,
            10}})));
equation

  connect(plug_p1.pin, transformer.p1) annotation (Line(points={{-100,100},{-10,100},{-10,10}}, color={0,0,255}));
  connect(plug_p2.pin, transformer.p2)
    annotation (Line(points={{100,100},{10,100},{10,10}}, color={0,0,255}));
  connect(plug_n1.pin, transformer.n1) annotation (Line(points={{-100,-100},{-10,-100},{-10,-10}}, color={0,0,255}));
  connect(plug_n2.pin, transformer.n2) annotation (Line(points={{100,-100},{10,-100},{10,-10}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-100,20},{-58,-20}},
          textString="L1",
          textColor={0,0,255}),
        Text(
          extent={{60,20},{100,-20}},
          textString="L2",
          textColor={0,0,255}),
        Text(
          extent={{-20,-60},{20,-100}},
          textString="M",
          textColor={0,0,255}),
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-40,60},{-40,100},{-90,100}}, color={0,0,255}),
        Line(points={{40,60},{40,100},{90,100}}, color={0,0,255}),
        Line(points={{-40,-60},{-40,-100},{-90,-100}}, color={0,0,255}),
        Line(points={{40,-60},{40,-100},{90,-100}}, color={0,0,255}),
        Text(
          extent={{-150,-150},{150,-110}},
          textString="m=%m"),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-33,45},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-33,15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-33,-15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-33,-45},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={33,45},
          rotation=90),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={33,15},
          rotation=90),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={33,-15},
          rotation=90),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={33,-45},
          rotation=90)}), Documentation(info="<html>
<p>
Contains m transformers (Modelica.Electrical.Analog.Basic.Transformer)
</p>
</html>"));
end Transformer;
