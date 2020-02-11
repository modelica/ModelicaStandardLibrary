within Modelica.Mechanics.MultiBody.Frames.Internal;
function resolveRelative_der
  "Derivative of function Frames.resolveRelative(..)"
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Icons.Function;
  input Real v1[3] "Vector in frame 1";
  input Orientation R1 "Orientation object to rotate frame 0 into frame 1";
  input Orientation R2 "Orientation object to rotate frame 0 into frame 2";
  input Real v1_der[3] "= der(v1)";
  output Real v2_der[3] "Derivative of vector v resolved in frame 2";
algorithm
  v2_der := Frames.resolveRelative(v1_der+cross(R1.w,v1), R1, R2)
            - cross(R2.w, Frames.resolveRelative(v1, R1, R2));

  /* skew(w) = T*der(T'), -skew(w) = der(T)*T'

     v2 = T2*(T1'*v1)
     der(v2) = der(T2)*T1'*v1 + T2*der(T1')*v1 + T2*T1'*der(v1)
             = der(T2)*T2'*T2*T1'*v1 + T2*T1'*T1*der(T1')*v1 + T2*T1'*der(v1)
             = -w2 x (T2*T1'*v1) + T2*T1'*(w1 x v1) + T2*T1'*der(v1)
             = T2*T1'*(der(v1) + w1 x v1) - w2 x (T2*T1'*v1)
  */
  annotation(Inline=true, Documentation(info="<html>
<p>
This is a derivative of function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolveRelative\">resolveRelative</a>.
</p>
</html>"));
end resolveRelative_der;
