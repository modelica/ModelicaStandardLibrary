within Modelica.Electrical.QuasiStationary.MultiPhase.Ideal;
model Idle "Idle branch"
  extends Interfaces.TwoPlug;

SinglePhase.Ideal.Idle idle[m] annotation (Placement(transformation(extent={{
            -10,-10},{10,10}}, rotation=0)));

equation
connect(plugToPins_p.pin_p, idle.pin_p) annotation (Line(points={{-68,0},{-10,0}},
        color={85,170,255}));
connect(idle.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},
          {39,2.44921e-016},{68,2.44921e-016}}, color={0,127,0}));
annotation (
  Diagram(graphics),
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
  Documentation(info="<html>
<p>
This model describes <i>m</m> simple idle branches considering the complex currents <i><u>i</u></i> = 0; 
it uses <i>m</i> <a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Ideal.Idle\">single phase idle branches</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Ideal.Idle\">Idle</a>,
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Ideal.Short\">Short</a>
</p>
</html>"));
end Idle;
