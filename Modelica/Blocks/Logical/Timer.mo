within Modelica.Blocks.Logical;
block Timer
  "Timer measuring the time from the time instant where the Boolean input became true"

  extends Modelica.Blocks.Icons.PartialBooleanBlock;
  Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

protected
  discrete SI.Time entryTime "Time instant when u became true";
initial equation
  pre(entryTime) = 0;
equation
  when u then
    entryTime = time;
  end when;
  y = if u then time - entryTime else 0.0;
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
        graphics={
      Line(points={{-90,-70},{82,-70}},
        color={192,192,192}),
      Line(points={{-80,68},{-80,-80}},
        color={192,192,192}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{90,-70},{68,-62},{68,-78},{90,-70}}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{-80,90},{-88,68},{-72,68},{-80,90}}),
      Line(points={{-80,-70},{-60,-70},{-60,-26},{38,-26},{38,-70},{66,-70}},
        color={255,0,255}),
      Line(points={{-80,0},{-62,0},{40,90},{40,0},{68,0}},
        color={0,0,127})}),
    Documentation(info="<html>
<p>When the Boolean input <strong>u</strong> becomes <strong>true</strong>, the timer starts
and the output <strong>y</strong> is the time that has elapsed since <strong>u</strong> became <strong>true</strong>.
When the input becomes <strong>false</strong>, the timer stops and the output is reset to zero.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Logical/Timer.png\"
     alt=\"Timer.png\">
</p>

</html>"));
end Timer;
