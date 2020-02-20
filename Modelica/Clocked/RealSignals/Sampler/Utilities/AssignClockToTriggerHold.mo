within Modelica.Clocked.RealSignals.Sampler.Utilities;
block AssignClockToTriggerHold
"Generate a Boolean continuous-time trigger signal from a clocked Real input"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
  parameter Boolean y_start=false "Initial value of output signal";
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
  "Connector of Boolean output signal"     annotation (Placement(
        transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
protected
  Boolean y2(start=y_start);
  Boolean y3(start=y_start, fixed=true);
  Real uu annotation(HideResult=true);
equation
  when Clock() then
     uu = u "Dummy assignment to relate clock of u with y2";
     y2 = not previous(y2);
  end when;
  y3 = hold(y2);
  y = change(y3);
  annotation (
    defaultComponentName="clockToTrigger",
    Icon(graphics={
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
This block creates a Boolean, continuous time, trigger signal whenever the clock of the input signal is active.
</p>

<p>
A particular use-case in which that block might be useful is the combination of \"old-style\" sampled blocks (i.e., \"unclocked\" discrete control functions implemented using equations between \"when trigger then\" clauses) with clocked blocks.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.AssignClockToTriggerHold\">example</a>
samples a sine signal with a periodic clock of 20 ms period. After that a continuous time Boolean trigger signal is generated at every clock tick of that sampled signal. The generated signal is used as trigger signal for an \"old-style\" <a href=\"modelica://Modelica.Blocks.Discrete.TriggeredSampler\">TriggeredSampler</a>  block from the Modelica.Blocks.Discrete package:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockToTriggerHold_Model.png\" alt=\"AssignClockToTriggerHold_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockToTriggerHold_Result.png\" alt=\"AssignClockToTriggerHold_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
Note, that it is clearly visible in the plot that the \"old-style\" discrete variables have an implicit zero-order hold semantics, while the new clocked variables are only active whenever their associated clock ticks. Just compare variable sample.y (clocked) with triggeredSampler.y (unclocked) to observe the difference.
</p>
</html>"));
end AssignClockToTriggerHold;
