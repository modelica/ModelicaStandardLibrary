within Modelica.Clocked.RealSignals.Periodic;
block MovingAverage
  "Moving average filter (= FIR filter with coefficients a = fill(1/n,n), but implemented recursively)"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Integer n = 2
    "Number of points that are averaged (= number of coefficients of corresponding FIR filter)";
protected
  Real u_buffer[n+1](each start=0.0)
    "The previous values of the inputs; u_buffer[1] = u, u_buffer[2] = previous(u_buffer[1]); u_buffer[3] = previous(u_buffer[2])";
  Boolean first(start=true) "Used to identify the first clock tick";
  Real uu(start=0.0)
    "Dummy variable to provide a dummy start value for u (which has no effect)";
  Real yy(start=0.0)
    "Dummy variable to provide a dummy start value for y (which has no effect)";
equation
  when Clock() then
     first = false;
     uu = u;

     // At the first clock tick u_last is filled with "u" (to initialize in steady state).
     u_buffer = if previous(first) then fill(uu,n+1) else
                     cat( 1, {uu}, previous(u_buffer[1:n]));

     // Moving average formula
     y = if previous(first) then uu else previous(yy) + (u_buffer[1] - u_buffer[n+1])/n;
     yy = y;
  end when;
  annotation (
    Documentation(info="<html>
<p>
This block computes the output y as the average of the input u and of
its past values (= moving average filter):
</p>
<blockquote><pre>
y(i) = ( u(i) + u(i-1) + u(i-2) + &hellip; ) / n
</pre></blockquote>
<p>
where y(i) and u(i) are the values of y and u at clock tick i, and n are the number of
u and past u values that are taken into account.
</p>

<p>
This block could also be implemented with block
<a href=\"modelica://Modelica.Clocked.RealSignals.Periodic.FIRbyCoefficients\">FIRbyCoefficients</a>
by using the coefficients a = fill(1/n, n). However, block <em>MovingAverage</em> is
a more efficient implementation since it can be implemented recursively,
contrary to a general FIR filter.
</p>

</html>"), Icon(graphics={
     Line(points={{-84,78},{-84,-90}}, color={192,192,192}),
    Line(points={{-90,-82},{82,-82}}, color={192,192,192}),
      Rectangle(extent={{-84,-82},{-18,4}},
            lineColor={192,192,192}, fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
    Line( points={{-84,30},{-72,30},{-52,28},{-32,20},{-26,16},{-22,12},{-18,
              6},{-14,-4},{-4,-46},{0,-64},{2,-82}},
          color={0,0,127},
          smooth=Smooth.Bezier),
    Polygon(points={{-84,90},{-92,68},{-76,68},{-84,90},{-84,90}}, lineColor={192,192,192}, fillColor={192,192,192},
            fillPattern =  FillPattern.Solid),
      Line(
          points={{2,-82},{4,-64},{8,-56},{12,-56},{16,-60},{18,-66},{20,-82}},
          color={0,0,127},
          smooth=Smooth.Bezier),
      Line(
          points={{20,-80},{20,-78},{20,-72},{22,-66},{24,-64},{28,-64},{32,
              -66},{34,-70},{36,-78},{36,-82},{36,-74},{38,-68},{40,-66},{
              44,-66},{46,-68},{48,-72},{50,-78},{50,-82},{50,-78},{52,-70},
              {54,-68},{58,-68},{62,-72},{64,-76},{64,-78},{64,-80},{64,-82}},
          color={0,0,127},
          smooth=Smooth.Bezier),
    Polygon(points={{90,-82},{68,-74},{68,-90},{90,-82}}, lineColor={192,192,192}, fillColor={192,192,192},
            fillPattern = FillPattern.Solid),
        Text(
          extent={{-26,88},{88,48}},
          textColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          textString="MA"),
        Text(
          extent={{-150,-110},{150,-150}},
          fillPattern=FillPattern.Solid,
          textString="n=%n")}));
end MovingAverage;
