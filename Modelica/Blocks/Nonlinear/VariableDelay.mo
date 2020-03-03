within Modelica.Blocks.Nonlinear;
block VariableDelay "Delay block with variable DelayTime"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter SI.Duration delayMax(min=0, start=1) "Maximum delay time";

  Modelica.Blocks.Interfaces.RealInput delayTime annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}})));
equation
  y = delay(u, delayTime, delayMax);
  annotation (
    Documentation(info="<html>
<p>
The Input signal is delayed by a given time instant, or more precisely:
</p>
<blockquote><pre>
y = u(time - delayTime) for time &gt; time.start + delayTime
  = u(time.start)       for time &le; time.start + delayTime
</pre></blockquote>
<p>
where delayTime is an additional input signal which must follow
the following relationship:
</p>
<blockquote><pre>
0 &le; delayTime &le; delayMax
</pre></blockquote>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
    Text(extent={{-100.0,-148.0},{100.0,-108.0}},
      textString="delayMax=%delayMax"),
    Line(points={{-92.0,0.0},{-80.7,34.2},{-73.5,53.1},{-67.1,66.4},{-61.4,74.6},{-55.8,79.1},{-50.2,79.8},{-44.6,76.6},{-38.9,69.7},{-33.3,59.4},{-26.9,44.1},{-18.83,21.2},{-1.9,-30.8},{5.3,-50.2},{11.7,-64.2},{17.3,-73.1},{23.0,-78.4},{28.6,-80.0},{34.2,-77.6},{39.9,-71.5},{45.5,-61.9},{51.9,-47.2},{60.0,-24.8},{68.0,0.0}},
      color={0,0,127},
      smooth=Smooth.Bezier),
    Line(points={{-64.0,0.0},{-52.7,34.2},{-45.5,53.1},{-39.1,66.4},{-33.4,74.6},{-27.8,79.1},{-22.2,79.8},{-16.6,76.6},{-10.9,69.7},{-5.3,59.4},{1.1,44.1},{9.17,21.2},{26.1,-30.8},{33.3,-50.2},{39.7,-64.2},{45.3,-73.1},{51.0,-78.4},{56.6,-80.0},{62.2,-77.6},{67.9,-71.5},{73.5,-61.9},{79.9,-47.2},{88.0,-24.8},{96.0,0.0}},
      smooth=Smooth.Bezier),
    Polygon(fillPattern=FillPattern.Solid,
      lineColor={0,0,127},
      fillColor={0,0,127},
      points={{6.0,4.0},{-14.0,-2.0},{-6.0,-12.0},{6.0,4.0}}),
    Line(color={0,0,127},
      points={{-100.0,-60.0},{-76.0,-60.0},{-8.0,-6.0}})}));
end VariableDelay;
