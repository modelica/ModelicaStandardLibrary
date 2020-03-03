within Modelica.Blocks.Nonlinear;
block FixedDelay "Delay block with fixed DelayTime"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter SI.Time delayTime(start=1)
    "Delay time of output with respect to input signal";

equation
  y = delay(u, delayTime);
  annotation (
    Documentation(info="<html>
<p>
The Input signal is delayed by a given time instant, or more precisely:
</p>
<blockquote><pre>
y = u(time - delayTime) for time &gt; time.start + delayTime
  = u(time.start)       for time &le; time.start + delayTime
</pre></blockquote>
</html>"),
         Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Text(
      extent={{8.0,-142.0},{8.0,-102.0}},
      textString="delayTime=%delayTime"),
    Line(
      points={{-92.0,0.0},{-80.7,34.2},{-73.5,53.1},{-67.1,66.4},{-61.4,74.6},{-55.8,79.1},{-50.2,79.8},{-44.6,76.6},{-38.9,69.7},{-33.3,59.4},{-26.9,44.1},{-18.83,21.2},{-1.9,-30.8},{5.3,-50.2},{11.7,-64.2},{17.3,-73.1},{23.0,-78.4},{28.6,-80.0},{34.2,-77.6},{39.9,-71.5},{45.5,-61.9},{51.9,-47.2},{60.0,-24.8},{68.0,0.0}},
      color={0,0,127},
      smooth=Smooth.Bezier),
    Line(
      points={{-62.0,0.0},{-50.7,34.2},{-43.5,53.1},{-37.1,66.4},{-31.4,74.6},{-25.8,79.1},{-20.2,79.8},{-14.6,76.6},{-8.9,69.7},{-3.3,59.4},{3.1,44.1},{11.17,21.2},{28.1,-30.8},{35.3,-50.2},{41.7,-64.2},{47.3,-73.1},{53.0,-78.4},{58.6,-80.0},{64.2,-77.6},{69.9,-71.5},{75.5,-61.9},{81.9,-47.2},{90.0,-24.8},{98.0,0.0}},
      color={160,160,164},
      smooth=Smooth.Bezier)}));
end FixedDelay;
