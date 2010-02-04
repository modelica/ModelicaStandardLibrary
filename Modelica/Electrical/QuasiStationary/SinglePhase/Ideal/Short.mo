within Modelica.Electrical.QuasiStationary.SinglePhase.Ideal;
model Short "Short cut branch"
  extends Interfaces.OnePort;
equation
  v = Complex(0);
  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{91,0},{-90,0}}),
        Text(extent={{-100,100},{100,70}}, textString=
                                               "%name")}),
    Window(
      x=0.31,
      y=0.14,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p>
This model is a simple short cut branch considering the complex voltage <i><u>v</u></i> = 0.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Idle\">Idle</a>
</p>
</html>"));
end Short;
