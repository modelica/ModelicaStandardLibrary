within Modelica.Electrical.Polyphase.Ideal;
model Short "Polyphase short cut branch"
  extends Interfaces.TwoPlug;
  Modelica.Electrical.Analog.Ideal.Short short[m] annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
equation

  connect(plug_p.pin, short.p)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(short.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{-90,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,130},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-90},{150,-130}},
          textString="m=%m")}), Documentation(
        info="<html>
<p>
Contains m short cuts (Modelica.Electrical.Analog.Ideal.Short)
</p>
</html>"));
end Short;
