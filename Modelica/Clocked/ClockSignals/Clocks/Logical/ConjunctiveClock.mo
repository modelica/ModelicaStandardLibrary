within Modelica.Clocked.ClockSignals.Clocks.Logical;
block ConjunctiveClock
  "Logical clock ticking whenever all input clocks ticked at least once, then resets and starts the next conjunctive cycle"
  extends PartialLogicalClock(
    redeclare Modelica.Blocks.MathBoolean.And combinator);

  annotation (
    Icon(graphics={
      Text(
        extent = {{-60,60},{60,-60}},
        textColor = {217,67,180},
        textStyle = {TextStyle.Bold},
        textString = "∧")}),
    Documentation(info="<html>
For a simple example cf. the
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.LogicalSample\">logical sampling example</a>.
</html>"));
end ConjunctiveClock;
