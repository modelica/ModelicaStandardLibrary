within Modelica.Clocked.IntegerSignals.Sampler.Utilities;
block AssignClockToSquareWaveHold
"Generate a Boolean continuous-time square signal from a clocked Integer input"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
  parameter Boolean y_start=false "Initial value of output signal";
  Modelica.Blocks.Interfaces.IntegerInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
  "Connector of Boolean output signal"     annotation (Placement(
        transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
protected
  Boolean y2(start=y_start);
equation
  // dummy condition to relate clock of u with y2
  y2 = if u > 0 then not previous(y2) else not previous(y2);
  y = hold(y2);
  annotation (
    defaultComponentName="clockToSquareWave",
    Icon(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}),
      graphics={
        Polygon(
          points={{-80,88},{-88,66},{-72,66},{-80,88}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
        Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{71,7},{85,-7}},
          lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{-40,-70},{-40,44},{0,44},
              {0,-70},{40,-70},{40,44},{79,44}})}),
    Documentation(info="<html>
<p>
This block for Integer signals works similar as the corresponding block for Real signals (see
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold\">RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold</a>).
</p>
</html>"));
end AssignClockToSquareWaveHold;
