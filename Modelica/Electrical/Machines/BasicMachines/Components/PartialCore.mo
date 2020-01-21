within Modelica.Electrical.Machines.BasicMachines.Components;
partial model PartialCore
  "Partial model of transformer core with 3 windings"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter Real n12(start=1) "Turns ratio 1:2";
  parameter Real n13(start=1) "Turns ratio 1:3";
  SI.Voltage v1[m]=plug_p1.pin.v - plug_n1.pin.v;
  SI.Current i1[m]=plug_p1.pin.i;
  SI.Voltage v2[m]=plug_p2.pin.v - plug_n2.pin.v;
  SI.Current i2[m]=plug_p2.pin.i;
  SI.Voltage v3[m]=plug_p3.pin.v - plug_n3.pin.v;
  SI.Current i3[m]=plug_p3.pin.i;
  SI.Current im[m]=i1 + i2/n12 + i3/n13
    "Magnetizing current";
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p1(final m=
        m) annotation (Placement(transformation(extent={{-110,90},{-90,110}}), iconTransformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n1(final m=
        m) annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p2(final m=
        m) annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n2(final m=
        m) annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p3(final m=
        m) annotation (Placement(transformation(extent={{90,-30},{110,-50}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n3(final m=
        m) annotation (Placement(transformation(extent={{90,-90},{110,-110}})));
equation
  plug_p1.pin.i + plug_n1.pin.i = zeros(m);
  plug_p2.pin.i + plug_n2.pin.i = zeros(m);
  plug_p3.pin.i + plug_n3.pin.i = zeros(m);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Line(points={{-90,100},{-30,100}},
                color={0,0,255}),Line(points={{-90,-100},{-30,-100}}, color=
           {0,0,255}), Line(points={{30,100},{90,100}},
                color={0,0,255}),Line(points={{30,40},{92,40}}, color={0,0,255}),
           Line(points={{30,-40},{90,-40}},
                 color={0,0,255}),Line(points={{30,-100},{90,-100}}, color=
          {0,0,255}),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={25,90},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={25,70},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={25,50},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={25,-50},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={25,-70},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={25,-90},
          rotation=90),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-25,90},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-25,70},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-25,50},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-25,30},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-25,10},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-25,-10},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-25,-30},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-25,-50},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-25,-70},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-25,-90},
          rotation=360),
        Text(
          extent={{-150,-110},{150,-150}},
          textString="m=%m"), Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                textColor={0,0,255})}),
                        Documentation(info="<html>
Partial model of transformer core with 3 windings; saturation function flux versus magnetizing current has to be defined.
</html>"));
end PartialCore;
