within Modelica.Clocked.RealSignals.Periodic;
block FIRbyCoefficients "FIR filter defined by coefficients"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  input Real a[:]={1/2,1/2} "Coefficients of FIR filter" annotation(Dialog);
  parameter Real cBufStart[size(a,1)-1] = ones(size(a,1)-1)
    "The u-buffer [u(i-1), u(i-2), ..., u(size(a,1)-1)] is initialized with u(i=1)*cBufStart"
                          annotation(Dialog(tab="Advanced"));
protected
  parameter Integer n = size(a, 1) - 1 "Order of filter";
  Real u_buffer[n+1](each start=0.0)
    "The previous values of the inputs; u_buffer[1] = u, u_buffer[2] = previous(u_buffer[1]); u_buffer[3] = previous(u_buffer[2])";
  Boolean first(start=true) "Used to identify the first clock tick";
equation
  when Clock() then
     first = false;

     // At the first clock tick u_last is filled with "u" (to initialize in steady state).
     u_buffer = if previous(first) then cat( 1, {u}, u*cBufStart)  else
                     cat( 1, {u}, previous(u_buffer[1:n]));

     // FIR formula
     y = a*u_buffer;
  end when;

  annotation (defaultComponentName="FIR1",
    Documentation(info="<html>
<p>
This block computes the output y as a linear combination of the input u
and of its past values (= FIR filter):
</p>
<blockquote><pre>
y(i) = a[1]*u(i) + a[2]*u(i-1) + a[3]*u(i-2) + &hellip;
</pre></blockquote>
<p>
where y(i) and u(i) are the values of y and u at clock tick i and
a[:] are the filter coefficients.
</p>

<p>
At the first clock tick i=1 the past values are filled with u at this clock tick (= steady state initialization).
</p>
</html>"),
    Icon(graphics={
    Polygon(points={{-84,90},{-92,68},{-76,68},{-84,90},{-84,90}}, lineColor={192,192,192}, fillColor={192,192,192},
            fillPattern =  FillPattern.Solid),
     Line(points={{-84,78},{-84,-90}}, color={192,192,192}),
    Line(points={{-84,30},{-72,30},{-52,28},{-32,20},{-26,16},{-22,12},{-18,6},{
              -14,-4},{-4,-46},{0,-64},{2,-82}},
         color={0,0,127},
         smooth=Smooth.Bezier),
      Rectangle(extent={{-84,-82},{-18,4}},
            lineColor={192,192,192}, fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
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
    Line(points={{-90,-82},{82,-82}}, color={192,192,192}),
        Text(
          extent={{-26,86},{88,56}},
          textColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          textString="FIR"),
        Text(
          extent={{-150,-110},{150,-150}},
          fillPattern=FillPattern.Solid,
          textString="a=%a")}));
end FIRbyCoefficients;
