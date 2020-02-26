within Modelica.Clocked.BooleanSignals.NonPeriodic;
block UnitDelay "Delay the clocked input signal for one sample period"
  extends Clocked.BooleanSignals.Interfaces.PartialClockedSISO(u(final
        start=y_start));
  parameter Boolean y_start=false
    "Value of output signal at first clock tick";
equation
  y = previous(u);
  annotation (defaultComponentName="unitDelay1",
       Icon(graphics={
        Line(points={{-30,0},{30,0}}, color={255,0,255}),
        Text(
          extent={{-90,10},{90,90}},
          textString="1",
          textColor={255,0,255},
          pattern=LinePattern.Dot),
        Text(
          extent={{-90,-10},{90,-90}},
          textString="z",
          textColor={255,0,255}),
        Text(
          extent={{-150,-150},{150,-110}},
          textString="y_start=%y_start")}),
    Documentation(info="<html>
<p>
This block describes a unit delay:
</p>
<blockquote><pre>
// Time domain description
   y(ti) = previous(u(ti))

// Discrete transfer function
           1
   y(z) = --- * u(z)
           z
</pre></blockquote>

<p>
that is, the output signal y is the input signal u at the
previous clock tick. At the first clock tick, the output
y is set to parameter y_start.
</p>
</html>"));
end UnitDelay;
