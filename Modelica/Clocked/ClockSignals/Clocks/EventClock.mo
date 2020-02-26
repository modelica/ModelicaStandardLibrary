within Modelica.Clocked.ClockSignals.Clocks;
block EventClock
  "Generate a clock signal when the Boolean input changes from false to true"
  extends Clocked.ClockSignals.Interfaces.PartialClock;
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  if useSolver then
     y = Clock(Clock(u), solverMethod=solverMethod);
  else
     y = Clock(u);
  end if;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}, initialScale=0.06),
                    graphics={
        Text(
          visible=useSolver,
          extent={{-150,-110},{150,-150}},
          textColor={0,0,0},
          textString="%solverMethod")}),
    Documentation(info="<html>
<p>
This component generates a clock signal triggered by a continuous-time
Boolean input signal u: Whenever the Boolean input signal <strong>u</strong>
changes from <strong>false</strong> to <strong>true</strong>, then the output
clock signal <strong>y</strong> ticks.
</p>

<p>
For an introduction to clocks see
<a href=\"modelica://Modelica.Clocked.UsersGuide.Clocks\">UsersGuide.Clocks</a>.
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
end EventClock;
