within Modelica.Clocked.BooleanSignals.Sampler.Utilities;
block AssignClockToTriggerHold
"Generate a Boolean continuous-time trigger signal from a clocked Boolean input"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
  parameter Boolean y_start=false "Initial value of output signal";
  Modelica.Blocks.Interfaces.BooleanInput
                                       u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
  "Connector of Boolean output signal"     annotation (Placement(
        transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
protected
  Boolean y2(start=y_start);
  Boolean y3(start=y_start, fixed=true);
  Boolean uu annotation(HideResult=true);
equation
  when Clock() then
     uu = u "Dummy assignment to relate clock of u with y2";
     y2 = not previous(y2);
  end when;
  y3 = hold(y2);
  y = change(y3);
  annotation (
    defaultComponentName="clockToTrigger",
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
      Line(points={{-60,-70},{-60,70}}),
      Line(points={{-20,-70},{-20,70}}),
      Line(points={{20,-70},{20,70}}),
      Line(points={{60,-70},{60,70}})}),
    Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToTriggerHold\">RealSignals.Sampler.Utilities.AssignClockToTriggerHold</a>).
</p>
</html>"));
end AssignClockToTriggerHold;
