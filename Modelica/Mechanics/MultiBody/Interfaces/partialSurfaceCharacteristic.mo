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
</p>
</html>"));
end partialSurfaceCharacteristic;
