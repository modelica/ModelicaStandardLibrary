within Modelica.Clocked.ClockSignals.Clocks.Logical;
block DisjunctiveClock
  "Logical clock ticking whenever any of its input clock signals ticks."
  extends PartialLogicalClock(
    redeclare Modelica.Blocks.MathBoolean.Or combinator);

  annotation (
    Icon(graphics={
      Text(
        extent = {{-60,60},{60,-60}},
        textColor = {217,67,180},
        textStyle = {TextStyle.Bold},
        textString = "∨")}),
    Documentation(info="<html>
For a simple example cf. the
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.LogicalSample\">logical sampling example</a>.
</html>"));
end DisjunctiveClock;
