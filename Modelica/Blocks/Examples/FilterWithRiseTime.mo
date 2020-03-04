within Modelica.Blocks.Examples;
model FilterWithRiseTime
  "Demonstrates to use the rise time instead of the cut-off frequency to define a filter"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  parameter Integer order=2 "Filter order";
  parameter SI.Time riseTime=2 "Time to reach the step input";

  Continuous.Filter filter_fac5(f_cut=5/(2*pi*riseTime), order=order)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Sources.Step step(startTime=1)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Continuous.Filter filter_fac4(f_cut=4/(2*pi*riseTime), order=order)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Continuous.Filter filter_fac3(f_cut=3/(2*pi*riseTime), order=order)
    annotation (Placement(transformation(extent={{-20,62},{0,82}})));
equation
  connect(step.y, filter_fac5.u) annotation (Line(
      points={{-39,30},{-30,30},{-30,-10},{-22,-10}}, color={0,0,127}));
  connect(step.y, filter_fac4.u) annotation (Line(
      points={{-39,30},{-22,30}}, color={0,0,127}));
  connect(step.y, filter_fac3.u) annotation (Line(
      points={{-39,30},{-30,30},{-30,72},{-22,72}}, color={0,0,127}));
  annotation (experiment(StopTime=4), Documentation(info="<html>
<p>
Filters are usually parameterized with the cut-off frequency.
Sometimes, it is more meaningful to parameterize a filter with its
rise time, i.e., the time it needs until the output reaches the end value
of a step input. This is performed with the formula:
</p>

<blockquote><pre>
f_cut = fac/(2*pi*riseTime);
</pre></blockquote>

<p>
where \"fac\" is typically 3, 4, or 5. The following image shows
the results of a simulation of this example model
(riseTime = 2 s, fac=3, 4, and 5):
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/FilterWithRiseTime.png\"
     alt=\"FilterWithRiseTime.png\">

<p>
Since the step starts at 1 s, and the rise time is 2 s, the filter output y
shall reach the value of 1 after 1+2=3 s. Depending on the factor \"fac\" this is
reached with different precisions. This is summarized in the following table:
</p>

<blockquote><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr>
   <td>Filter order</td>
   <td>Factor fac</td>
   <td>Percentage of step value reached after rise time</td>
</tr>
<tr>
   <td align=\"center\">1</td>
   <td align=\"center\">3</td>
   <td align=\"center\">95.1 %</td>
</tr>
<tr>
   <td align=\"center\">1</td>
   <td align=\"center\">4</td>
   <td align=\"center\">98.2 %</td>
</tr>
<tr>
   <td align=\"center\">1</td>
   <td align=\"center\">5</td>
   <td align=\"center\">99.3 %</td>
</tr>

<tr>
   <td align=\"center\">2</td>
   <td align=\"center\">3</td>
   <td align=\"center\">94.7 %</td>
</tr>
<tr>
   <td align=\"center\">2</td>
   <td align=\"center\">4</td>
   <td align=\"center\">98.6 %</td>
</tr>
<tr>
   <td align=\"center\">2</td>
   <td align=\"center\">5</td>
   <td align=\"center\">99.6 %</td>
</tr>
</table></blockquote>

</html>"));
end FilterWithRiseTime;
