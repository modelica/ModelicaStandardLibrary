within Modelica.Clocked.ClockSignals.Clocks;
block PeriodicRealClock
  "Generate a periodic clock signal with a period defined by a Real number"
  parameter SI.Time period
    "Period of clock (defined as Real number)" annotation(Evaluate=true);
  extends Clocked.ClockSignals.Interfaces.PartialPeriodicClock;
equation
  if useSolver then
     y = Clock(Clock(period), solverMethod=solverMethod);
  else
     y = Clock(period);
  end if;

  annotation (
     defaultComponentName="periodicClock1",
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}, initialScale=0.06),
                    graphics={
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=45,
          origin={-50,-120},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=90,
          origin={52,60},
          pattern=LinePattern.None,
          fillColor={95,95,95}),
        Text(
          extent={{-150,-110},{150,-150}},
          textColor={0,0,0},
          textString="%period"),
        Text(
          visible=useSolver,
          extent={{-150,-160},{150,-200}},
          textColor={0,0,0},
          textString="%solverMethod")}),
    Documentation(info="<html>
<p>
This component generates a periodic clock that starts ticking when
the simulation starts. The <strong>period</strong> is defined in seconds
by a <strong>Real</strong> number. If clocks are synchronized relatively to each other
then only one of the clocks can be defined with PeriodicRealClock.
</p>

<p>
For an introduction to clocks see
<a href=\"modelica://Modelica.Clocked.UsersGuide.Clocks\">UsersGuide.Clocks</a>.
If exact, integer based, time synchronization with absolute period definitions is
desired, use block
<a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock\">PeriodicExactClock</a>
to generate a periodic clock signal.
</p>

<p>
If a clock is associated to a clocked continuous-time partition, then an <strong>integrator</strong>
has to be defined that is used to integrate the partition from the previous
to the current clock tick. This is performed by setting parameter <strong>useSolver</strong>
= <strong>true</strong> and defining the integration method as String with
parameter <strong>solver</strong>. Both parameters are in tab <strong>Advanced</strong>.
For an example, see
<a href=\"modelica://Modelica.Clocked.Examples.Systems.ControlledMixingUnit\">Examples.Systems.ControlledMixingUnit</a>.
</p>
</html>"));
end PeriodicRealClock;
