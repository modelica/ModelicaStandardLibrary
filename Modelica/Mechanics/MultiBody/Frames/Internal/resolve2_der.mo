within Modelica.Mechanics.MultiBody.Frames.Internal;
function resolve2_der "Derivative of function Frames.resolve2(..)"
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  input Real v1[3] "Vector resolved in frame 1";
  input Real v1_der[3] "= der(v1)";
  output Real v2_der[3] "Derivative of vector v resolved in frame 2";
algorithm
  v2_der := Frames.resolve2(R, v1_der) - cross(R.w, Frames.resolve2(R, v1));
  annotation(Inline=true, Documentation(info="<html>
<p>
This is a derivative of function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve2\">resolve2</a>.
</p>
</html>"));
end resolve2_der;
