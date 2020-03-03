within Modelica.Blocks.Sources;
block Trapezoid "Generate trapezoidal signal of type Real"
  parameter Real amplitude=1 "Amplitude of trapezoid"
  annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Trapezoid.png"));
  parameter SI.Time rising(final min=0) = 0
    "Rising duration of trapezoid";
  parameter SI.Time width(final min=0) = 0.5
    "Width duration of trapezoid";
  parameter SI.Time falling(final min=0) = 0
    "Falling duration of trapezoid";
  parameter SI.Time period(final min=Modelica.Constants.small, start=1)
    "Time for one period";
  parameter Integer nperiod=-1
    "Number of periods (< 0 means infinite number of periods)";
  extends Interfaces.SignalSource;
protected
  parameter SI.Time T_rising=rising
    "End time of rising phase within one period";
  parameter SI.Time T_width=T_rising + width
    "End time of width phase within one period";
  parameter SI.Time T_falling=T_width + falling
    "End time of falling phase within one period";
  SI.Time T_start "Start time of current period";
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
    count >= nperiod)) then 0 else if (time < T_start + T_rising) then
    amplitude*(time - T_start)/rising else if (time < T_start + T_width)
     then amplitude else if (time < T_start + T_falling) then amplitude*(
    T_start + T_falling - time)/falling else 0);
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
        Text(
          extent={{-147,-152},{153,-112}},
          textString="period=%period"),
        Line(points={{-81,-70},{-60,-70},{-30,40},{9,40},{39,-70},{61,-70},{
              90,40}})}),
    Documentation(info="<html>
<p>
The Real output y is a trapezoid signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Trapezoid.png\"
     alt=\"Trapezoid\">
</p>
</html>"));
end Trapezoid;
