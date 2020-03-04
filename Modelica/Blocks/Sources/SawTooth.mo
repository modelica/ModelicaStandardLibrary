within Modelica.Blocks.Sources;
block SawTooth "Generate saw tooth signal"
  parameter Real amplitude=1 "Amplitude of saw tooth"
  annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/SawTooth.png"));
  parameter SI.Time period(final min=Modelica.Constants.small,start=1)
    "Time for one period";
  parameter Integer nperiod=-1
    "Number of periods (< 0 means infinite number of periods)";
  extends Interfaces.SignalSource;
protected
  SI.Time T_start(final start=startTime) "Start time of current period";
  Integer count "Period count";
initial algorithm
  count := integer((time - startTime)/period);
  T_start := startTime + count*period;
equation
  when integer((time - startTime)/period) > pre(count) then
    count = pre(count) + 1;
    T_start = time;
  end when;
  y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and
    count >= nperiod)) then 0 else amplitude*(time - T_start)/period);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{-60,-70},{0,40},{0,-70},{60,41},{60,-70}}),
        Text(
          extent={{-147,-152},{153,-112}},
          textString="period=%period")}),
    Documentation(info="<html>
<p>
The Real output y is a saw tooth signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/SawTooth.png\"
     alt=\"SawTooth.png\">
</p>
</html>"));
end SawTooth;
