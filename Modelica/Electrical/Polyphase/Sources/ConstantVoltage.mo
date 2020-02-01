within Modelica.Electrical.Polyphase.Sources;
model ConstantVoltage "Polyphase constant voltage source"
  extends Interfaces.TwoPlug;
  parameter SI.Voltage V[m](start=fill(1, m))
    "Values of constant voltages";
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage[m](
      final V=V) annotation (Placement(transformation(extent={{-10,-10},{10,
            10}})));
equation
  connect(constantVoltage.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(constantVoltage.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (
    Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}),
          Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{-50,0},{50,0}},
          color={0,0,255}),Text(
              extent={{-150,60},{150,100}},
              textString="%name",
              textColor={0,0,255}),
        Text(
          extent={{150,-100},{-150,-60}},
          textString="m=%m"),
        Line(points={{-70,30},{-70,10}}, color={0,0,255}),
        Line(points={{-80,20},{-60,20}}, color={0,0,255}),
        Line(points={{60,20},{80,20}}, color={0,0,255})}),
                                 Documentation(info="<html>
<p>
Contains m constant voltage sources (Modelica.Electrical.Analog.Sources.ConstantVoltage)
</p>
</html>"));
end ConstantVoltage;
