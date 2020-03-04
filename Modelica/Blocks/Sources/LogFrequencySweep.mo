within Modelica.Blocks.Sources;
block LogFrequencySweep "Logarithmic frequency sweep"
  extends Modelica.Blocks.Interfaces.SO;
  import Modelica.Constants.eps;
  parameter Real wMin(final min=eps) "Start frequency"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/LogFrequencySweep.png"));
  parameter Real wMax(final min=eps) "End frequency";
  parameter SI.Time startTime=0 "Start time of frequency sweep";
  parameter SI.Time duration(min=0.0, start=1) "Duration of ramp (= 0.0 gives a Step)";
equation
  y = if time < startTime then wMin else
    if time < (startTime + max(duration,eps)) then
      10^(log10(wMin) + (log10(wMax) - log10(wMin))*min(1, (time-startTime)/max(duration,eps)))
    else
      wMax;
   annotation (defaultComponentName="logSweep",
     Documentation(info="<html>
<p>The output <code>y</code> performs a logarithmic frequency sweep.
The logarithm of frequency <code>w</code> performs a linear ramp from <code>log10(wMin)</code> to <code>log10(wMax)</code>.
The output is the decimal power of this logarithmic ramp.
</p>
<p>For <code>time &lt; startTime</code> the output is equal to <code>wMin</code>.</p>
<p>For <code>time &gt; startTime+duration</code> the output is equal to <code>wMax</code>.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LogFrequencySweep.png\"
     alt=\"LogFrequencySweep.png\">
</p>

</html>"),
    Icon(graphics={
        Line(points={{-78,44},{80,44}}, color={192,192,192}),
        Line(points={{-78,34},{80,34}}, color={192,192,192}),
        Line(points={{-78,20},{80,20}}, color={192,192,192}),
        Line(points={{-78,-2},{80,-2}}, color={192,192,192}),
        Line(points={{-78,-48},{80,-48}}, color={192,192,192}),
        Line(
          points={{-70,-48},{-50,-48},{50,44},{70,44}},
          color={0,0,127},
          thickness=0.5),
        Line(points={{-50,-48},{-50,44}}, color={192,192,192}),
        Line(points={{50,-48},{50,44}}, color={192,192,192}),
        Line(points={{-78,40},{80,40}}, color={192,192,192}),
                               Polygon(
              points={{90,-48},{68,-40},{68,-56},{90,-48}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
                        Polygon(
              points={{-70,90},{-78,68},{-62,68},{-70,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
        Line(points={{-70,-56},{-70,68}}, color={192,192,192})}));
end LogFrequencySweep;
