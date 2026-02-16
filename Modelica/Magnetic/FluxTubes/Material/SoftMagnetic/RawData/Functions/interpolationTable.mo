within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.Functions;
function interpolationTable "Constructs an interpolation table"
  extends Modelica.Icons.Function;
  import Modelica.Math.Vectors.reverse;
  input Real x[:] "Abscissa of measurements";
  input Real y[:] "Ordinate of measurements";
  input Real xSat "Abscissa where saturation is reached";
  input Real ySat "Saturation ordinate";
  input Boolean originSymmetric=true "i.e. y(-x)=-y(x), otherwise y(-x)=y(x)";
  input Boolean completeOrigin=true "i.e. add (0, 0)";
  output Real table[(2*size(x,1) + 2 + (if completeOrigin then 1 else 0)), 2]
    "Resulting interpolation table matrix";
algorithm
  assert(size(x,1)==size(y,1), "Abscissa and ordinate have to have the same length");
  assert(xSat>x[end], "xSat has to be greater than last abszissa");
  assert(ySat>y[end], "ySat has to be greater than last ordinate");
  if originSymmetric then
    if completeOrigin then
      table:=[cat(1, -{xSat}, -reverse(x), {0}, x, {xSat}),
              cat(1, -{ySat}, -reverse(y), {0}, y, {ySat})];
    else
      table:=[cat(1, -{xSat}, -reverse(x),      x, {xSat}),
              cat(1, -{ySat}, -reverse(y),      y, {ySat})];
    end if;
  else
    if completeOrigin then
      table:=[cat(1, -{xSat}, -reverse(x), {0}, x, {xSat}),
              cat(1,  {ySat},  reverse(y), {0}, y, {ySat})];
    else
      table:=[cat(1, -{xSat}, -reverse(x),      x, {xSat}),
              cat(1,  {ySat},  reverse(y),      y, {ySat})];
    end if;
  end if;
  annotation (Documentation(info="<html>
<p>
Assume we have a series of measurements only in the right half of the plane (x,y), e.g. <br>
<code>x[:]={5, 11, 18}</code><br>
<code>x[:]={1,  2,  3}</code><br>
and we want to create an interpolation table for the full plane, this function helps.
</p>
<p>
The parameter <code>originSymmetric</code> controls whether the resulting table is symmetric to the origin or not.<br>
The parameter <code>cpmpleteOrigin</code> controls whether the origin <code>(0, 0)</code> is explicitely added or not.<br>
Additonally, the parameters <code>xSat</code> and <code>ySat</code> specify a last point where saturation occurs.
</p>
<p><code>originSymmetric=true</code> and <code>completeOrigin=true</code>:</p>
<pre>Result <code>A[7, 2] = [-xSat, -ySat; -18, -3; -11, -2; -5, -1; 0, 0; 5, 1; 11, 2; 18, 3; xSat, ySat]</code></pre>
<p><code>originSymmetric=true</code> and <code>completeOrigin=false</code>:</p>
<pre>Result <code>A[6, 2] = [-xSat, -ySat; -18, -3; -11, -2; -5, -1;       5, 1; 11, 2; 18, 3; xSat, ySat]</code></pre>
<p><code>originSymmetric=false</code> and <code>completeOrigin=true</code>:</p>
<pre>Result <code>A[7, 2] = [-xSat, +ySat; -18, +3; -11, +2; -5, +1; 0, 0; 5, 1; 11, 2; 18, 3; xSat, ySat]</code></pre>
<p><code>originSymmetric=false</code> and <code>completeOrigin=false</code>:</p>
<pre>Result <code>A[6, 2] = [-xSat, +ySat; -18, +3; -11, +2; -5, +1;       5, 1; 11, 2; 18, 3; xSat, ySat]</code></pre>
</html>"));
end interpolationTable;
