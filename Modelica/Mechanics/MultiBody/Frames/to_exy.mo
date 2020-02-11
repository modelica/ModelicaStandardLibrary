within Modelica.Mechanics.MultiBody.Frames;
function to_exy
  "Map rotation object into e_x and e_y vectors of frame 2, resolved in frame 1"

  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  output Real exy[3, 2]
    "= [e_x, e_y] where e_x and e_y are axes unit vectors of frame 2, resolved in frame 1";
algorithm
  exy := [R.T[1, :], R.T[2, :]];
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
exy = Frames.<strong>to_exy</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns unit vectors e_x and e_y which define axes of frame&nbsp;2 resolved in frame&nbsp;1,
provided&nbsp;R is an <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>
to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxy\">from_nxy</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxz\">from_nxz</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_exy\">TransformationMatrices.to_exy</a>.
</p>
</html>"));
end to_exy;
