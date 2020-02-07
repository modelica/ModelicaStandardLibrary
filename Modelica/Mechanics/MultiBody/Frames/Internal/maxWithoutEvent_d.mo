within Modelica.Mechanics.MultiBody.Frames.Internal;
function maxWithoutEvent_d
  "First derivative of function maxWithoutEvent(..)"
  extends Modelica.Icons.Function;

  input Real u1;
  input Real u2;
  input Real u1_d;
  input Real u2_d;
  output Real y_d;
algorithm
  y_d := if u1 > u2 then u1_d else u2_d;
  annotation (
    Inline=false,
    derivative(order=2) = maxWithoutEvent_dd,
    Documentation(info="<html>
<p>
This is a derivative of function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Internal.maxWithoutEvent\">maxWithoutEvent</a>.
</p>
</html>"));
end maxWithoutEvent_d;
