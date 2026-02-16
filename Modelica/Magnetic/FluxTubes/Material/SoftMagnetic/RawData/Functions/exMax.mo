within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.Functions;
function exMax "Extrapolation from maximum"
  extends Modelica.Icons.Function;
  import Modelica.Math.Vectors.find;
  input Real x[:] "Absicissa of nodes";
  input Real y[:] "Ordinates of nodes";
  input Real dyMin=1 "Minimum difference of ordinates";
  output Real z "Extrapolaion from maximum";
protected
  Real yMax=max(y) "Maximum of ordinates";
  Integer iMax=find(yMax, y) "Index of maximum";
  Integer i2 "2nd index for extrapolation";
algorithm
  // avoid horizontal approximation
  i2:= if abs(y[iMax] - y[iMax + 1])<dyMin then iMax + 2 else iMax + 1;
  z:= y[iMax] - (y[iMax] - y[i2])/(x[iMax] - x[i2])*x[iMax];
  annotation (Documentation(info="<html>
<p>
This function searches the maximum in <code>y</code>, 
determines the index of the maximum <code>iMax</code> 
and a second index <code>i2</code> &gt; <code>iMax</code> under the constraint <code>y[i2] &lt; y[iMax]</code>. 
Then the extrapolation to <code>x=0</code> is done through the nodes with the indices <code>iMax</code> and <code>i2</code>.
</p>
</html>"));
end exMax;
