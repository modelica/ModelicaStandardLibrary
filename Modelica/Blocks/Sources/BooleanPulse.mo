within Modelica.Blocks.Sources;
block BooleanPulse "Generate pulse signal of type Boolean"

  parameter Real width(
    final min=Modelica.Constants.small,
    final max=100) = 50 "Width of pulse in % of period"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanPulse.png"));
  parameter SI.Time period(final min=Modelica.Constants.small,
      start=1) "Time for one period";
  parameter SI.Time startTime=0 "Time instant of first pulse";
  extends Modelica.Blocks.Interfaces.partialBooleanSource;

protected
  parameter SI.Time Twidth=period*width/100
    "width of one pulse" annotation (HideResult=true);
  discrete SI.Time pulseStart "Start time of pulse"
    annotation (HideResult=true);
initial equation
  pulseStart = startTime;
equation
  when sample(startTime, period) then
    pulseStart = time;
  end when;
  y = time >= pulseStart and time < pulseStart + Twidth;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-150,-140},{150,-110}},
          textString="%period"), Line(points={{-80,-70},{-40,-70},{-40,44},{0,
              44},{0,-70},{40,-70},{40,44},{79,44}})}),
      Documentation(info="<html>
<p>
The Boolean output y is a pulse signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png\"
     alt=\"Pulse.png\">
</p>
</html>"));
end BooleanPulse;
