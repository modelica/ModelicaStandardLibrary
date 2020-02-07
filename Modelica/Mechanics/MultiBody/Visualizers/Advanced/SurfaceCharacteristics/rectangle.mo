within Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics;
function rectangle "Function defining the surface characteristic of a planar rectangle"
  extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
    final multiColoredSurface=false);
  input SI.Distance lu=1 "Length in direction u" annotation(Dialog);
  input SI.Distance lv=3 "Length in direction v" annotation(Dialog);
algorithm
  X[:,:] := lu/2 * transpose(fill(linspace(-1,1,nu), nv));
  Y[:,:] := lv/2 * fill(linspace(-1,1,nv), nu);
  Z[:,:] := fill(0, nu, nv);

  annotation (Documentation(info="<html>
<p>
Function <strong>rectangle</strong> computes the X, Y and Z arrays to visualize a rectangle
with model <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Rectangle\">Rectangle</a>.
The image below shows two rectangles of
</p>
<blockquote><pre>
nu = 8,
nv = 3,
lu = 3,
lv = 2.
</pre></blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Rectangle.png\">
</blockquote>
</html>"));
end rectangle;
