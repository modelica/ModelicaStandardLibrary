within Modelica.Electrical.QuasiStationary.SinglePhase.Ideal;
model Idle "Idle branch"
  extends Interfaces.OnePort;
equation
  i = Complex(0);
  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-41,0}}),
        Line(points={{91,0},{40,0}}),
        Text(extent={{-100,100},{100,70}}, textString=
                                               "%name")}),
    Diagram(graphics),
    Window(
      x=0.36,
      y=0.16,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p>
This model is a simple idle branch considering the complex current <i><u>i</u></i> = 0.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Short\">Short</a>
</p>
</html>"));
end Idle;
