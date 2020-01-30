within Modelica.Electrical.Polyphase.Basic;
model Inductor "Ideal linear electrical inductors"
  extends Interfaces.TwoPlug;
  parameter SI.Inductance L[m](start=fill(1, m)) "Inductance";
  Modelica.Electrical.Analog.Basic.Inductor inductor[m](final L=L)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(inductor.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(inductor.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{60,0},{90,0}}, color={0,0,255}),
        Line(points={{-90,0},{-60,0}}, color={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Text(
          extent={{-150,-80},{150,-40}},
          textString="m=%m")}), Documentation(info="<html>
<p>
Contains m inductors (Modelica.Electrical.Analog.Basic.Inductor)
</p>
</html>"));
end Inductor;
