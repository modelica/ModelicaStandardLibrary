within Modelica.Blocks.Examples.BusUsage_Utilities;
model Part "Component with sub-control bus"

  Interfaces.SubControlBus subControlBus annotation (Placement(
        transformation(
        origin={100,0},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Sources.RealExpression realExpression(y=time) annotation (Placement(
        transformation(extent={{-6,0},{20,20}})));
  Sources.BooleanExpression booleanExpression(y=time >= 0.5) annotation (
      Placement(transformation(extent={{-6,-30},{20,-10}})));
equation
  connect(realExpression.y, subControlBus.myRealSignal) annotation (Line(
      points={{21.3,10},{88,10},{88,6},{98,6},{98,0},{100,0}}, color={0,0,127}));
  connect(booleanExpression.y, subControlBus.myBooleanSignal) annotation (
      Line(
      points={{21.3,-20},{60,-20},{60,0},{100,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
          extent={{-100,60},{100,-60}},
          fillColor={159,159,223},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127}), Text(
          extent={{-106,124},{114,68}},
          textString="%name",
          textColor={0,0,255})}), Documentation(info="<html>
<p>
This model is used to demonstrate the bus usage in example
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>.
</p>
</html>"));
end Part;
