within Modelica.Mechanics.MultiBody.Frames.Internal;
function resolve1_der "Derivative of function Frames.resolve1(..)"
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  input Real v2[3] "Vector resolved in frame 2";
  input Real v2_der[3] "= der(v2)";
  output Real v1_der[3] "Derivative of vector v resolved in frame 1";
algorithm
  v1_der := Frames.resolve1(R, v2_der + cross(R.w, v2));
  annotation(Inline=true, Documentation(info="<html>
<p>
This is a derivative of function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve1\">resolve1</a>.
</p>
</html>"));
end resolve1_der;
