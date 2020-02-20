within Modelica.Clocked.RealSignals.Sampler.Utilities;
block AssignClockToSquareWaveHold
"Generate a Boolean continuous-time square-wave output from a clocked Real input"
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
  Real uu;
equation
  when Clock() then
     uu = u "Dummy assignment to relate clock of u with y2";
     y2 = not previous(y2);
  end when;
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
        Line(points={{-80,-70},{-40,-70},{-40,44},
            {0,44},{0,-70},{40,-70},{40,44},{79,44}})}),
    Documentation(info="<html>
<p>
This block creates a Boolean, continuous time, square-wave output. Whenever the clock of the input signal is active the Boolean output value changes.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.AssignClockToSquareWaveHold\">example</a>
samples a sine signal with a periodic clock of 20 ms period. After that a Boolean, continuous time, square-wave signal is generated that changes its value at every clock tick of the sampled signal:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockToSquareWaveHold_Model.png\" alt=\"AssignClockToSquareWaveHold_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockToSquareWaveHold_Result.png\" alt=\"AssignClockToSquareWaveHold_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
end AssignClockToSquareWaveHold;
