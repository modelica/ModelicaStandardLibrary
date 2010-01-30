within Modelica.Electrical.QuasiStationary.MultiPhase.Ideal;
model Short "Short cut branch"
  extends Interfaces.TwoPlug;

SinglePhase.Ideal.Short short[m] annotation (Placement(transformation(extent={{
            -10,-10},{10,10}}, rotation=0)));

equation
connect(plugToPins_p.pin_p, short.pin_p) annotation (Line(points={{-68,0},{-10,
          0}}, color={85,170,255}));
connect(short.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},
          {39,2.44921e-016},{68,2.44921e-016}}, color={0,127,0}));
annotation (
  Diagram(graphics),
  Icon(graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{-100,100},{100,70}}, textString=
                                               "%name"),
        Line(points={{91,0},{-90,0}})}),
  Documentation(info="<html>
<p>
This model describes <i>m</m> simple short branches considering the complex voltages <i><u>v</u></i> = 0; 
it uses <i>m</i> <a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Ideal.Short\">single phase short branches</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Ideal.Short\">Short</a>,
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Ideal.Idle\">Idle</a>
</p>
</html>"));
end Short;
