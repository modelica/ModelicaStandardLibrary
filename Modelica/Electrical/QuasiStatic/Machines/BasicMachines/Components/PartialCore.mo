within Modelica.Electrical.QuasiStatic.Machines.BasicMachines.Components;
partial model PartialCore
  "Partial model of transformer core with 3 windings"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter Real n12(start=1) "Turns ratio 1:2";
  parameter Real n13(start=1) "Turns ratio 1:3";
  SI.ComplexVoltage v1[m];
  SI.ComplexCurrent i1[m];
  SI.ComplexVoltage v2[m];
  SI.ComplexCurrent i2[m];
  SI.ComplexVoltage v3[m];
  SI.ComplexCurrent i3[m];
  SI.ComplexCurrent im[m] "Magnetizing current";
  QuasiStatic.Polyphase.Interfaces.PositivePlug plug_p1(final m=m) annotation (
      Placement(transformation(extent={{-110,90},{-90,110}}),
        iconTransformation(extent={{-110,90},{-90,110}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug plug_n1(final m=m) annotation (
      Placement(transformation(extent={{-110,-110},{-90,-90}}),
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  QuasiStatic.Polyphase.Interfaces.PositivePlug plug_p2(final m=m)
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug plug_n2(final m=m)
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  QuasiStatic.Polyphase.Interfaces.PositivePlug plug_p3(final m=m)
    annotation (Placement(transformation(extent={{90,-30},{110,-50}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug plug_n3(final m=m)
    annotation (Placement(transformation(extent={{90,-90},{110,-110}})));
equation
  v1 = plug_p1.pin.v - plug_n1.pin.v;
  i1 = plug_p1.pin.i;
  v2 = plug_p2.pin.v - plug_n2.pin.v;
  i2 = plug_p2.pin.i;
  v3 = plug_p3.pin.v - plug_n3.pin.v;
  i3 = plug_p3.pin.i;
  im = i1 + i2/n12 + i3/n13;
  //branches p1-n1, p2-n2, p3-n3
  Connections.branch(plug_p1.reference, plug_n1.reference);
  plug_p1.reference.gamma = plug_n1.reference.gamma;
  Connections.branch(plug_p2.reference, plug_n2.reference);
  plug_p2.reference.gamma = plug_n2.reference.gamma;
  Connections.branch(plug_p3.reference, plug_n3.reference);
  plug_p3.reference.gamma = plug_n3.reference.gamma;
  //Define p1.reference.gamme = p2.reference.gamma = p3.reference.gamma
  Connections.branch(plug_p1.reference, plug_p2.reference);
  plug_p1.reference.gamma = plug_p2.reference.gamma;
  Connections.branch(plug_p1.reference, plug_p3.reference);
  plug_p1.reference.gamma = plug_p3.reference.gamma;
  //Note: transformer could be fed from primary or secondary side
  //Define p1, p2 and p3 as potential roots
  //Not necessary since there exist non-breakable branches between primary and secondary side
  //Connections.potentialRoot(plug_p1.reference);
  //Connections.potentialRoot(plug_p2.reference);
  //Connections.potentialRoot(plug_p3.reference);
  //Current balances
  plug_p1.pin.i + plug_n1.pin.i = fill(Complex(0), m);
  plug_p2.pin.i + plug_n2.pin.i = fill(Complex(0), m);
  plug_p3.pin.i + plug_n3.pin.i = fill(Complex(0), m);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                textColor={0,0,255}), Line(points={{-90,100},{-30,100}},
                color={85,170,255}),
                                 Line(points={{-90,-100},{-30,-100}},
                                                                    color={85,170,255}),
                                               Line(points={{30,100},{90,100}},
                color={85,170,255}),
                                 Line(points={{30,40},{92,40}}, color={85,170,255}),
                                               Line(points={{30,-40},{90,-40}},
                 color={85,170,255}),
                                  Line(points={{30,-100},{90,-100}},
                                                                   color={85,170,255}),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={25,90},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={25,70},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={25,50},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={25,-50},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={25,-70},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={25,-90},
          rotation=90),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-25,90},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-25,70},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-25,50},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-25,30},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-25,10},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-25,-10},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-25,-30},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-25,-50},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-25,-70},
          rotation=360),
        Line(
          points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-25,-90},
          rotation=360),
        Text(
          extent={{-150,-110},{150,-150}},
          textString="m=%m")}),
      Documentation(info="<html>
Partial model of transformer core with 3 windings; saturation function flux versus magnetizing current has to be defined.
</html>"));
end PartialCore;
