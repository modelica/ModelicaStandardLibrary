within Modelica.Electrical.Polyphase.Sources;
model ConstantCurrent "Polyphase constant current source"
  extends Interfaces.TwoPlug;
  parameter SI.Current I[m](start=fill(1, m))
    "Values of constant currents";
  Modelica.Electrical.Analog.Sources.ConstantCurrent constantCurrent[m](
      final I=I) annotation (Placement(transformation(extent={{-10,-10},{10,
            10}})));
equation
  connect(constantCurrent.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(constantCurrent.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (
    Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}),
          Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,50},{0,-50}},
          color={0,0,255}), Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
                           Text(
              extent={{-150,60},{150,100}},
              textString="%name",
              textColor={0,0,255}),
        Text(
          extent={{150,-100},{-150,-60}},
          textString="m=%m")}), Documentation(info="<html>
<p>
Contains m constant current sources (Modelica.Electrical.Analog.Sources.ConstantCurrent)
</p>
</html>"));
end ConstantCurrent;
