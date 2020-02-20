within Modelica.Clocked.RealSignals.NonPeriodic;
block PI
  "Discrete-time PI controller with clocked input and output signals (for periodic and aperiodic systems using the parameterization of the continuous PI controller)"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Real k "Gain of continuous PI controller";
  parameter Real T(min=Modelica.Constants.small)
    "Time constant of continuous PI controller";
  output Real x(start=0) "Discrete PI state";
protected
  Real Ts = interval(u) "Sample time (periodic or non-periodic)";
equation
  when Clock() then
     x = previous(x) + u*(Ts/T);
     y = k*(x + u);
  end when;

  annotation (defaultComponentName="PI1",
       Icon(graphics={
        Polygon(
          points={{90,-82},{68,-74},{68,-90},{90,-82}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-82},{82,-82}}, color={192,192,192}),
        Line(points={{-80,76},{-80,-92}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-82},{-80,-10},{-32,-10},{-32,18},{54,18},{54,46},{84,46},
              {84,78}},
          color={0,0,127},
          pattern=LinePattern.Dot),
        Text(
          extent={{-30,0},{80,-60}},
          textColor={192,192,192},
          textString="PI"),
        Text(
          extent={{-150,-150},{150,-110}},
          textString="T=%T"),
        Ellipse(
          extent={{-87,-3},{-75,-15}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-38,24},{-26,12}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{48,52},{60,40}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Discrete-time PI controller that has been derived from the continuous-time
PI controller
</p>
<blockquote><pre>
              1
y = k * (1 + ---) * u
             T*s
        T*s + 1
  = k * ------- * u
          T*s
</pre></blockquote>
<p>
by using the implicit Euler discretization formula. The block is
parametrized with the gain k and the time constant T of the continuous
PI block. As a result, the discrete-time form of the PI controller depends
explicitly on the sample time of the controller and changing this sample time,
will give still a similar performance.
</p>
</html>"));
end PI;
