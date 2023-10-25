within Modelica.Mechanics.MultiBody.Interfaces;
partial function partialSurfaceCharacteristic "Interface for a function returning surface characteristics"
  extends Modelica.Icons.Function;
   input Integer nu "Number of points in u-Dimension";
   input Integer nv "Number of points in v-Dimension";
   input Boolean multiColoredSurface=false
    "= true: Color is defined for each surface point";
   output SI.Position X[nu,nv]
    "[nu,nv] positions of points in x-Direction resolved in surface frame";
   output SI.Position Y[nu,nv]
    "[nu,nv] positions of points in y-Direction resolved in surface frame";
   output SI.Position Z[nu,nv]
    "[nu,nv] positions of points in z-Direction resolved in surface frame";
   output Real C[if multiColoredSurface then nu else 0,
                 if multiColoredSurface then nv else 0,3]
    "[nu,nv,3] Color array, defining the color for each surface point";
  annotation (Documentation(info="<html>
<p>This partial function defines the interface of a function that returns
surface characteristics for an object visualization, see e.g.
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.torus\">Visualizers.Advanced.SurfaceCharacteristics.torus</a>.
Function which extends from this partial class shall define all outputs
<code>X</code>, <code>Y</code>, <code>Z</code> and <code>C</code>.
The last one output <code>C</code> can be set as follows when a multi-colored surface
is not utilized.
</p>
<blockquote><pre>
<strong>function</strong> mySurface
  <strong>extends</strong> partialSurfaceCharacteristic(
    <strong>final</strong> multiColoredSurface = false,
    <strong>final</strong> C = zeros(0,0,3));
  ...
<strong>end</strong> mySurface;
</pre></blockquote>
</html>"));
end partialSurfaceCharacteristic;
