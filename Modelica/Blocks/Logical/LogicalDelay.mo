within Modelica.Blocks.Logical;
block LogicalDelay "Delay boolean signal"
  extends Blocks.Icons.PartialBooleanBlock;
  parameter SI.Time delayTime(final min=0)=0 "Time delay";
  Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Blocks.Interfaces.BooleanOutput y1
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Blocks.Interfaces.BooleanOutput y2
  annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
protected
  discrete SI.Time tSwitch;
initial equation
  tSwitch = time - 2*delayTime;
equation
  when {u, not u} then
    tSwitch = time;
  end when;
  y1 = if u then true else not (time >= tSwitch + delayTime);
  y2 = if not u then false else (time >= tSwitch + delayTime);
  annotation (Documentation(info="<html>
<p>
When input <code>u</code> gets true, output <code>y1</code> gets immediately true, whereas output <code>y2</code> gets true after <code>delayTime</code>.
</p>
<p>
When input <code>u</code> gets false, output <code>y1</code> gets false after <code>delayTime</code>, whereas output <code>y2</code> gets immediately false.
</p>
</html>"),
         Icon(graphics={
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{-80,90},{-88,68},{-72,68},{-80,90}}),
      Line(points={{-80,68},{-80,-80}},
        color={192,192,192}),
      Line(points={{-90,-70},{82,-70}},
        color={192,192,192}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{90,-70},{68,-62},{68,-78},{90,-70}}),
        Line(points={{-80,-10},{-60,-10},{-60,10},{40,10},{40,-10},{80,-10}},
            color={255,0,255}),
        Line(points={{-80,50},{-60,50},{-60,70},{50,70},{50,50},{80,50}},
            color={255,0,255}),
        Line(points={{-80,-70},{-50,-70},{-50,-50},{40,-50},{40,-70},{80,-70}},
            color={255,0,255}),
        Line(
          points={{-60,70},{-60,-70}},
          color={192,192,192},
          pattern=LinePattern.Dot),
        Line(
          points={{40,70},{40,-70}},
          color={192,192,192},
          pattern=LinePattern.Dot)}));
end LogicalDelay;
