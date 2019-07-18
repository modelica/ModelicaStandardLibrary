within Modelica.Electrical.QuasiStatic.Polyphase.Ideal;
model Idle "Idle branch"
  extends Interfaces.TwoPlug;

  QuasiStatic.SinglePhase.Ideal.Idle idle[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  connect(plugToPins_p.pin_p, idle.pin_p)
    annotation (Line(points={{-68,0},{-10,0}}, color={85,170,255}));
  connect(idle.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{
          39,0},{39,0},{68,0}}, color={0,127,0}));
  annotation (Icon(graphics={Rectangle(
              extent={{-80,80},{80,-80}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{-90,0},{-41,0}},
          color={85,170,255}),Line(points={{91,0},{40,0}}, color={85,170,255}),
          Text(
              extent={{-150,130},{150,90}},
              textString="%name",
              textColor={0,0,255}),
        Text(
          extent={{-150,-90},{150,-130}},
          textString="m=%m")}), Documentation(info="<html>
<p>
This model describes <em>m</em> simple idle branches considering the complex currents <em><u>i</u></em> = 0;
it uses <em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.Idle\">single-phase idle branches</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.Idle\">Idle</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Ideal.Short\">Short</a>
</p>
</html>"));
end Idle;
