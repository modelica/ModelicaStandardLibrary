within Modelica;
package Math "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"

  extends Modelica.Icons.Package;

package Vectors "Library of functions operating on vectors"
  extends Modelica.Icons.Package;

  function toString "Convert a real vector in to a string representation"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Strings;

    input Real v[:] "Real vector";
    input String name="" "Independent variable name used for printing";
    input Integer significantDigits=6
      "Number of significant digits that are shown";
    output String s="";
  protected
    String blanks=Strings.repeat(significantDigits);
    String space=Strings.repeat(8);
    Integer r=size(v, 1);

  algorithm
    if r == 0 then
      s := if name == "" then "[]" else name + " = []";
    else
      s := if name == "" then "\n" else "\n" + name + " = \n";
      for i in 1:r loop
        s := s + space;

        if v[i] >= 0 then
          s := s + " ";
        end if;
        s := s + String(v[i], significantDigits=significantDigits) +
          Strings.repeat(significantDigits + 8 - Strings.length(String(abs(v[i]))));

        s := s + "\n";
      end for;

    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>toString</strong>(v);
Vectors.<strong>toString</strong>(v,name=\"\",significantDigits=6);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>toString</strong>(v)</code>\" returns the string representation of vector <strong>v</strong>.
With the optional arguments \"name\" and \"significantDigits\" a name and the number of the digits are defined.
The default values of \"name\" and \"significantDigits\" are \"\" and 6 respectively. If name==\"\" (empty string) then the prefix \"&lt;name&gt; =\" is left out at the output-string.
</p>
<h4>Example</h4>
<blockquote><pre>
v = {2.12, -4.34, -2.56, -1.67};
<strong>toString</strong>(v);
                       // = \"
                       //           2.12
                       //          -4.34
                       //          -2.56
                       //          -1.67\"
<strong>toString</strong>(v,\"vv\",1);
                       // = \"vv =
                       //           2
                       //          -4
                       //          -3
                       //          -2\"
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.toString\">Matrices.toString</a>,
</p>
</html>", revisions="<html>

</html>"));
  end toString;

  function isEqual "Determine if two Real vectors are numerically identical"
    extends Modelica.Icons.Function;
    input Real v1[:] "First vector";
    input Real v2[:] "Second vector (may have different length as v1)";
    input Real eps(min=0) = 0
      "Two elements e1 and e2 of the two vectors are identical if abs(e1-e2) <= eps";
    output Boolean result
      "= true, if vectors have the same length and the same elements";

  protected
    Integer n=size(v1, 1) "Dimension of vector v1";
    Integer i=1;
  algorithm
    result := false;
    if size(v2, 1) == n then
      result := true;
      while i <= n loop
        if abs(v1[i] - v2[i]) > eps then
          result := false;
          i := n;
        end if;
        i := i + 1;
      end while;
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>isEqual</strong>(v1, v2);
Vectors.<strong>isEqual</strong>(v1, v2, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.isEqual(v1, v2)</code>\" returns <strong>true</strong>,
if the two Real vectors v1 and v2 have the same dimensions and
the same elements. Otherwise the function
returns <strong>false</strong>. Two elements e1 and e2 of the two vectors
are checked on equality by the test \"abs(e1-e2) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real v1[3] = {1, 2, 3};
  Real v2[4] = {1, 2, 3, 4};
  Real v3[3] = {1, 2, 3.0001};
  Boolean result;
<strong>algorithm</strong>
  result := Vectors.isEqual(v1,v2);     // = <strong>false</strong>
  result := Vectors.isEqual(v1,v3);     // = <strong>false</strong>
  result := Vectors.isEqual(v1,v1);     // = <strong>true</strong>
  result := Vectors.isEqual(v1,v3,0.1); // = <strong>true</strong>
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.find\">Vectors.find</a>,
<a href=\"modelica://Modelica.Math.Matrices.isEqual\">Matrices.isEqual</a>,
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
</p>
</html>"));
  end isEqual;

  function norm "Return the p-norm of a vector"
    extends Modelica.Icons.Function;
    input Real v[:] "Real vector";
    input Real p(min=1) = 2
      "Type of p-norm (often used: 1, 2, or Modelica.Constants.inf)";
    output Real result=0.0 "p-norm of vector v";
  protected
    Real eps = 10*Modelica.Constants.eps;
  algorithm
   if size(v,1) > 0 then
    if p >= 2-eps and p <= 2+eps then
      result := sqrt(v*v);
    elseif p >= Modelica.Constants.inf then
      result := max(abs(v));
    elseif p >= 1-eps and p <= 1+eps then
      result := sum(abs(v));
    elseif p >= 1 then
      result := (sum(abs(v[i])^p for i in 1:size(v, 1)))^(1/p);
    else
      assert(false, "Optional argument \"p\" (= " + String(p) + ") of function \"norm\" >= 1 required");
    end if;
   end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>norm</strong>(v);
Vectors.<strong>norm</strong>(v,p=2);   // 1 &le; p &le; &#8734;
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>norm</strong>(v)</code>\" returns the
<strong>Euclidean norm</strong> \"<code>sqrt(v*v)</code>\" of vector v.
With the optional
second argument \"p\", any other p-norm can be computed:
</p>
<center>
<img src=\"modelica://Modelica/Resources/Images/Math/Vectors/vectorNorm.png\" alt=\"function Vectors.norm\">
</center>
<p>
Besides the Euclidean norm (p=2), also the 1-norm and the
infinity-norm are sometimes used:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>1-norm</strong></td>
      <td>= sum(abs(v))</td>
      <td><strong>norm</strong>(v,1)</td>
  </tr>
  <tr><td><strong>2-norm</strong></td>
      <td>= sqrt(v*v)</td>
      <td><strong>norm</strong>(v) or <strong>norm</strong>(v,2)</td>
  </tr>
  <tr><td><strong>infinity-norm</strong></td>
      <td>= max(abs(v))</td>
      <td><strong>norm</strong>(v,Modelica.Constants.<strong>inf</strong>)</td>
  </tr>
</table>
<p>
Note, for any vector norm the following inequality holds:
</p>
<blockquote><pre>
<strong>norm</strong>(v1+v2,p) &le; <strong>norm</strong>(v1,p) + <strong>norm</strong>(v2,p)
</pre></blockquote>
<h4>Example</h4>
<blockquote><pre>
v = {2, -4, -2, -1};
<strong>norm</strong>(v,1);    // = 9
<strong>norm</strong>(v,2);    // = 5
<strong>norm</strong>(v);      // = 5
<strong>norm</strong>(v,10.5); // = 4.00052597412635
<strong>norm</strong>(v,Modelica.Constants.inf);  // = 4
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.norm\">Matrices.norm</a>
</p>
</html>"));
  end norm;

  function length
    "Return length of a vector (better as norm(), if further symbolic processing is performed)"
    extends Modelica.Icons.Function;
    input Real v[:] "Real vector";
    output Real result "Length of vector v";
  algorithm
    result := sqrt(v*v);
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>length</strong>(v);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>length</strong>(v)</code>\" returns the
<strong>Euclidean length</strong> \"<code>sqrt(v*v)</code>\" of vector v.
The function call is equivalent to Vectors.norm(v). The advantage of
length(v) over norm(v) is that function length(..) is implemented
in one statement and therefore the function is usually automatically
inlined. Further symbolic processing is therefore possible, which is
not the case with function norm(..).
</p>
<h4>Example</h4>
<blockquote><pre>
v = {2, -4, -2, -1};
<strong>length</strong>(v);  // = 5
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.norm\">Vectors.norm</a>
</p>
</html>"));
  end length;

  function normalize
    "Return normalized vector such that length = 1 and prevent zero-division for zero vector"
    extends Modelica.Icons.Function;
    input Real v[:] "Real vector";
    input Real eps(min=0.0)=100*Modelica.Constants.eps
      "if |v| < eps then result = v/eps";
    output Real result[size(v, 1)] "Input vector v normalized to length=1";

  algorithm
    /* This function has the inline annotation. If the function is inlined:
     - "smooth(..)" defines how often the expression can be differentiated
       (if symbolic processing is performed).
  */
    result := smooth(0, if length(v) >= eps then v/length(v) else v/eps);
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>normalize</strong>(v);
Vectors.<strong>normalize</strong>(v,eps=100*Modelica.Constants.eps);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>normalize</strong>(v)</code>\" returns the
<strong>unit vector</strong> \"<code>v/length(v)</code>\" of vector v.
If length(v) is close to zero (more precisely, if length(v) &lt; eps),
v/eps is returned in order to avoid
a division by zero. For many applications this is useful, because
often the unit vector <strong>e</strong> = <strong>v</strong>/length(<strong>v</strong>) is used to compute
a vector x*<strong>e</strong>, where the scalar x is in the order of length(<strong>v</strong>),
i.e., x*<strong>e</strong> is small, when length(<strong>v</strong>) is small and then
it is fine to replace <strong>e</strong> by <strong>v</strong> to avoid a division by zero.
</p>
<p>
Since the function has the \"Inline\" annotation, it
is usually inlined and symbolic processing is applied.
</p>
<h4>Example</h4>
<blockquote><pre>
<strong>normalize</strong>({1,2,3});  // = {0.267, 0.534, 0.802}
<strong>normalize</strong>({0,0,0});  // = {0,0,0}
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.length\">Vectors.length</a>,
<a href=\"modelica://Modelica.Math.Vectors.normalize\">Vectors.normalizeWithAssert</a>
</p>
</html>"));
  end normalize;

function normalizeWithAssert
    "Return normalized vector such that length = 1 (trigger an assert for zero vector)"
  import Modelica.Math.Vectors.length;
  extends Modelica.Icons.Function;
  input Real v[:] "Real vector";
  output Real result[size(v, 1)] "Input vector v normalized to length=1";

algorithm
  assert(length(v) > 0.0, "Vector v={0,0,0} shall be normalized (= v/sqrt(v*v)), but this results in a division by zero.\nProvide a non-zero vector!");
  result := v/length(v);
  annotation (
    Inline=true,
    Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>normalizeWithAssert</strong>(v);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>normalizeWithAssert</strong>(v)</code>\" returns the
<strong>unit vector</strong> \"<code>v/sqrt(v*v)</code>\" of vector v.
If vector v is a zero vector, an assert is triggered.
</p>
<p>
Since the function has the \"Inline\" annotation, it
is usually inlined and symbolic processing is applied.
</p>
<h4>Example</h4>
<blockquote><pre>
<strong>normalizeWithAssert</strong>({1,2,3});  // = {0.267, 0.534, 0.802}
<strong>normalizeWithAssert</strong>({0,0,0});  // error (an assert is triggered)
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.length\">Vectors.length</a>,
<a href=\"modelica://Modelica.Math.Vectors.normalize\">Vectors.normalize</a>
</p>
</html>"));
end normalizeWithAssert;

  function reverse "Reverse vector elements (e.g., v[1] becomes last element)"
    extends Modelica.Icons.Function;
    input Real v[:] "Real vector";
    output Real result[size(v, 1)] "Elements of vector v in reversed order";

  algorithm
    result := {v[end - i + 1] for i in 1:size(v, 1)};
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>reverse</strong>(v);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>reverse</strong>(v)</code>\" returns the
vector elements in reverse order.
</p>
<h4>Example</h4>
<blockquote><pre>
<strong>reverse</strong>({1,2,3,4});  // = {4,3,2,1}
</pre></blockquote>
</html>"));
  end reverse;

  function sort "Sort elements of vector in ascending or descending order"
    extends Modelica.Icons.Function;
    input Real v[:] "Real vector to be sorted";
    input Boolean ascending=true
      "= true, if ascending order, otherwise descending order";
    output Real sorted_v[size(v, 1)]=v "Sorted vector";
    output Integer indices[size(v, 1)]=1:size(v, 1) "sorted_v = v[indices]";

    /* shellsort algorithm; should be improved later */
  protected
    Integer gap;
    Integer i;
    Integer j;
    Real wv;
    Integer wi;
    Integer nv=size(v, 1);
    Boolean swap;
  algorithm
    gap := div(nv, 2);

    while gap > 0 loop
      i := gap;
      while i < nv loop
        j := i - gap;
        if j >= 0 then
          if ascending then
            swap := sorted_v[j + 1] > sorted_v[j + gap + 1];
          else
            swap := sorted_v[j + 1] < sorted_v[j + gap + 1];
          end if;
        else
          swap := false;
        end if;

        while swap loop
          wv := sorted_v[j + 1];
          wi := indices[j + 1];
          sorted_v[j + 1] := sorted_v[j + gap + 1];
          sorted_v[j + gap + 1] := wv;
          indices[j + 1] := indices[j + gap + 1];
          indices[j + gap + 1] := wi;
          j := j - gap;
          if j >= 0 then
            if ascending then
              swap := sorted_v[j + 1] > sorted_v[j + gap + 1];
            else
              swap := sorted_v[j + 1] < sorted_v[j + gap + 1];
            end if;
          else
            swap := false;
          end if;
        end while;
        i := i + 1;
      end while;
      gap := div(gap, 2);
    end while;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
           sorted_v = Vectors.<strong>sort</strong>(v);
(sorted_v, indices) = Vectors.<strong>sort</strong>(v, ascending=true);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <strong>sort</strong>(..) sorts a Real vector v
in ascending order and returns the result in sorted_v.
If the optional argument \"ascending\" is <strong>false</strong>, the vector
is sorted in descending order. In the optional second
output argument the indices of the sorted vector with respect
to the original vector are given, such that sorted_v = v[indices].
</p>
<h4>Example</h4>
<blockquote><pre>
(v2, i2) := Vectors.sort({-1, 8, 3, 6, 2});
     -> v2 = {-1, 2, 3, 6, 8}
        i2 = {1, 5, 3, 4, 2}
</pre></blockquote>
</html>"));
  end sort;

  function find "Find element in a vector"
    extends Modelica.Icons.Function;
    input Real e "Search for e";
    input Real v[:] "Real vector";
    input Real eps(min=0) = 0
      "Element e is equal to a element v[i] of vector v if abs(e-v[i]) <= eps";
    output Integer result
      "v[result] = e (first occurrence of e); result=0, if not found";
  protected
    Integer i;
  algorithm
    result := 0;
    i := 1;
    while i <= size(v, 1) loop
      if abs(v[i] - e) <= eps then
        result := i;
        i := size(v, 1) + 1;
      else
        i := i + 1;
      end if;
    end while;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>find</strong>(e, v);
Vectors.<strong>find</strong>(e, v, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.find(e, v)</code>\" returns the index of the first occurrence of input e in vector <strong>v</strong>.
The test of equality is performed by \"abs(e-v[i]) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real v[3] = {1, 2, 3};
  Real e1 = 2;
  Real e2 = 3.01;
  Boolean result;
<strong>algorithm</strong>
  result := Vectors.find(e1,v);          // = <strong>2</strong>
  result := Vectors.find(e2,v);          // = <strong>0</strong>
  result := Vectors.find(e2,v,eps=0.1);  // = <strong>3</strong>
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>
</p>
</html>"));
  end find;

  function interpolate "Interpolate linearly in a vector"
    extends Modelica.Icons.Function;
    input Real x[:]
      "Abscissa table vector (strict monotonically increasing values required)";
    input Real y[size(x, 1)] "Ordinate table vector";
    input Real xi "Desired abscissa value";
    input Integer iLast=1 "Index used in last search";
    output Real yi "Ordinate value corresponding to xi";
    output Integer iNew=1 "xi is in the interval x[iNew] <= xi < x[iNew+1]";
  protected
    Integer i;
    Integer nx=size(x, 1);
    Real x1;
    Real x2;
    Real y1;
    Real y2;
  algorithm
    assert(nx > 0, "The table vectors must have at least 1 entry.");
    if nx == 1 then
      yi := y[1];
    else
      // Search interval
      i := min(max(iLast, 1), nx - 1);
      if xi >= x[i] then
        // search forward
        while i < nx and xi >= x[i] loop
          i := i + 1;
        end while;
        i := i - 1;
      else
        // search backward
        while i > 1 and xi < x[i] loop
          i := i - 1;
        end while;
      end if;

      // Get interpolation data
      x1 := x[i];
      x2 := x[i + 1];
      y1 := y[i];
      y2 := y[i + 1];

      assert(x2 > x1, "Abscissa table vector values must be increasing");
      // Interpolate
      yi := y1 + (y2 - y1)*(xi - x1)/(x2 - x1);
      iNew := i;
    end if;

    annotation (smoothOrder( normallyConstant=x, normallyConstant=y)=100,
      Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
// Real    x[:], y[:], xi, yi;
// Integer iLast, iNew;
        yi = Vectors.<strong>interpolate</strong>(x,y,xi);
(yi, iNew) = Vectors.<strong>interpolate</strong>(x,y,xi,iLast=1);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.interpolate(x,y,xi)</code>\" interpolates
<strong>linearly</strong> in vectors
(x,y) and returns the value yi that corresponds to xi. Vector x[:] must consist
of monotonically increasing values. If xi &lt; x[1] or &gt; x[end], then
extrapolation takes places through the first or last two x[:] values, respectively.
If the x and y vectors have length 1, then always y[1] is returned.
The search for the interval x[iNew] &le; xi &lt; x[iNew+1] starts at the optional
input argument \"iLast\". The index \"iNew\" is returned as output argument.
The usage of \"iLast\" and \"iNew\" is useful to increase the efficiency of the call,
if many interpolations take place.
If x has two or more identical values then interpolation utilizes the x-value
with the largest index.
</p>

<h4>Example</h4>

<blockquote><pre>
  Real x1[:] = { 0,  2,  4,  6,  8, 10};
  Real x2[:] = { 1,  2,  3,  3,  4,  5};
  Real y[:]  = {10, 20, 30, 40, 50, 60};
<strong>algorithm</strong>
  (yi, iNew) := Vectors.interpolate(x1,y,5);  // yi = 35, iNew=3
  (yi, iNew) := Vectors.interpolate(x2,y,4);  // yi = 50, iNew=5
  (yi, iNew) := Vectors.interpolate(x2,y,3);  // yi = 40, iNew=4
</pre></blockquote>
</html>"));
  end interpolate;

  function relNodePositions "Return vector of relative node positions (0..1)"
    extends Modelica.Icons.Function;
    input Integer nNodes
      "Number of nodes (including node at left and right position)";
    output Real xsi[nNodes] "Relative node positions";
  protected
    Real delta;
  algorithm
    if nNodes >= 1 then
      xsi[1] := 0;
    end if;

    if nNodes >= 2 then
      xsi[nNodes] := 1;
    end if;

    if nNodes == 3 then
      xsi[2] := 0.5;
    elseif nNodes > 3 then
      delta := 1/(nNodes - 2);
      for i in 2:nNodes - 1 loop
        xsi[i] := (i - 1.5)*delta;
      end for;
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>relNodePositions</strong>(nNodes);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>relNodePositions(nNodes)</code>\" returns a vector
with the relative positions of the nodes of a discretized pipe with nNodes nodes (including the node
at the left and at the right side of the pipe), see next figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/Vectors/relNodePositions.png\">
</div>

<h4>Example</h4>

<blockquote><pre>
  Real xsi[7];
<strong>algorithm</strong>
  xsi = relNodePositions(7);  // xsi = {0, 0.1, 0.3, 0.5, 0.7, 0.9, 1}
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">MultiBody.Visualizers.PipeWithScalarField</a>
</p>
</html>"));
  end relNodePositions;
  annotation (preferredView="info", Documentation(info="<html>
<h4>Library content</h4>
<p>
This library provides functions operating on vectors:
</p>

<ul>
<li> <a href=\"modelica://Modelica.Math.Vectors.toString\">toString</a>(v)
     - returns the string representation of vector v.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.isEqual\">isEqual</a>(v1, v2)
     - returns true if vectors v1 and v2 have the same size and the same elements.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.norm\">norm</a>(v,p)
     - returns the p-norm of vector v.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.length\">length</a>(v)
     - returns the length of vector v (= norm(v,2), but inlined and therefore usable in
       symbolic manipulations)</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.normalize\">normalize</a>(v)
     - returns vector in direction of v with length = 1 and prevents
       zero-division for zero vector.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.reverse\">reverse</a>(v)
     - reverses the vector elements of v.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.sort\">sort</a>(v)
     - sorts the elements of vector v in ascending or descending order.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.find\">find</a>(e, v)
     - returns the index of the first occurrence of scalar e in vector v.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.interpolate\">interpolate</a>(x, y, xi)
     - returns the interpolated value in (x,y) that corresponds to xi.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.relNodePositions\">relNodePositions</a>(nNodes)
     - returns a vector of relative node positions (0..1).</li>
</ul>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices\">Matrices</a>
</html>"),
    Icon(graphics={Rectangle(
          extent={{-16,66},{14,18}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-16,-14},{14,-62}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}));
end Vectors;

package Matrices "Library of functions operating on matrices"
  package Examples
    "Examples demonstrating the usage of the Math.Matrices functions"
    extends Modelica.Icons.ExamplesPackage;
    function solveLinearEquations
      "Demonstrate the solution of linear equation systems"
      extends Modelica.Icons.Function;
      import Modelica.Utilities.Streams.print;
      // solve and solve2
    protected
      Real A0[0, 0];
      Real A1[2, 2]=[1, 2; 3, 4];
      Real x1_ref[2]={-2,3};
      Real b1[2]=A1*x1_ref;
      Real x1[2];
      Real B2[2, 3]=[b1, 2*b1, -3*b1];
      Real X2[2, 3];

      // leastSquares and leastSquares2
      Integer rank;
      Real a[3]={2,3,-1};
      Real A3[3, 3]=transpose([{2,3,-4}, a, 3*a]);
      Real x3_ref[3]={-2,3,5};
      Real b3[3]=A3*x3_ref;
      Real x3[3];
      Real B3[3, 2]=[b3, -3*b3];
      Real X3[3, 2];

    algorithm
      print("\nDemonstrate how to solve linear equation systems:\n");

      // Solve regular linear equation with a right hand side vector
      x1 := Math.Matrices.solve(A1, b1);
      print("diff1 = " + String(Vectors.norm(x1 - x1_ref)));

      // Solve regular linear equation with a right hand side matrix
      X2 := Math.Matrices.solve2(A1, B2);
      print("diff2 = " + String(Matrices.norm(X2 - [x1_ref, 2*x1_ref, -3*x1_ref])));

      // Solve singular linear equation with a right hand side vector
      (x3,rank) := Math.Matrices.leastSquares(A3, b3);
      print("diff3 = " + String(Vectors.norm(A3*x3 - b3)) + ", n = " + String(
        size(A3, 1)) + ", rank = " + String(rank));

      // Solve singular linear equation with a right hand side matrix
      (X3,rank) := Math.Matrices.leastSquares2(A3, B3);
      print("diff4 = " + String(Matrices.norm(A3*X3 - B3)) + ", n = " + String(
        size(A3, 1)) + ", rank = " + String(rank));

      annotation (Documentation(info="<html>
<p>
With simple examples this function demonstrates how to solve
regular linear equation systems with Matrices.solve and Matrices.solve2,
and how to solve singular linear equation systems with
Matrices.leastSquares and Matrices.leastSquares2.
</p>
</html>"));
    end solveLinearEquations;
  end Examples;

  function toString "Convert a matrix into its string representation"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Strings;

    input Real M[:, :] "Real matrix";
    input String name="" "Independent variable name used for printing";
    input Integer significantDigits=6
      "Number of significant digits that are shown";
    output String s="" "String expression of matrix M";
  protected
    String blanks=Strings.repeat(significantDigits);
    String space=Strings.repeat(8);
    String space2=Strings.repeat(3);
    Integer r=size(M, 1);
    Integer c=size(M, 2);

  algorithm
    if r == 0 or c == 0 then
      s := name + " = []";
    else
      s := if name == "" then "\n" else "\n" + name + " = \n";
      for i in 1:r loop
        s := s + space;
        for j in 1:c loop
          if M[i, j] >= 0 then
            s := s + " ";
          end if;
          s := s + String(M[i, j], significantDigits=significantDigits) +
            Strings.repeat(significantDigits + 8 - Strings.length(String(abs(M[
            i, j]))));
        end for;
        s := s + "\n";
      end for;

    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<strong>toString</strong>(A);
Matrices.<strong>toString</strong>(A, name=\"\", significantDigits=6);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Matrices.<strong>toString</strong>(A)</code>\" returns the
string representation of matrix <strong>A</strong>.
With the optional arguments \"name\" and \"significantDigits\", a name and the number of the digits are defined.
The default values of name and significantDigits are \"\" and 6 respectively. If name==\"\" then the
prefix \"&lt;name&gt; =\" is left out.
</p>
<h4>Example</h4>
<blockquote><pre>
A = [2.12, -4.34; -2.56, -1.67];

toString(A);
// = \"
//      2.12   -4.34
//     -2.56   -1.67\";

toString(A,\"A\",1);
// = \"A =
//         2     -4
//        -3     -2\"
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.toString\">Vectors.toString</a>
</p>

</html>", revisions="<html>
</html>"));
  end toString;

  extends Modelica.Icons.Package;

  function isEqual "Compare whether two Real matrices are identical"
    extends Modelica.Icons.Function;
    input Real M1[:, :] "First matrix";
    input Real M2[:, :] "Second matrix (may have different size as M1)";
    input Real eps(min=0) = 0
      "Two elements e1 and e2 of the two matrices are identical if abs(e1-e2) <= eps";
    output Boolean result
      "= true, if matrices have the same size and the same elements";

  protected
    Integer nrow=size(M1, 1) "Number of rows of matrix M1";
    Integer ncol=size(M1, 2) "Number of columns of matrix M1";
    Integer i=1;
    Integer j;
  algorithm
    result := false;
    if size(M2, 1) == nrow and size(M2, 2) == ncol then
      result := true;
      while i <= nrow loop
        j := 1;
        while j <= ncol loop
          if abs(M1[i, j] - M2[i, j]) > eps then
            result := false;
            i := nrow;
            j := ncol;
          end if;
          j := j + 1;
        end while;
        i := i + 1;
      end while;
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<strong>isEqual</strong>(M1, M2);
Matrices.<strong>isEqual</strong>(M1, M2, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Matrices.isEqual(M1, M2)</code>\" returns <strong>true</strong>,
if the two Real matrices M1 and M2 have the same dimensions and
the same elements. Otherwise the function
returns <strong>false</strong>. Two elements e1 and e2 of the two matrices
are checked on equality by the test \"abs(e1-e2) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A1[2,2] = [1,2; 3,4];
  Real A2[3,2] = [1,2; 3,4; 5,6];
  Real A3[2,2] = [1,2, 3,4.0001];
  Boolean result;
<strong>algorithm</strong>
  result := Matrices.isEqual(M1,M2);     // = <strong>false</strong>
  result := Matrices.isEqual(M1,M3);     // = <strong>false</strong>
  result := Matrices.isEqual(M1,M1);     // = <strong>true</strong>
  result := Matrices.isEqual(M1,M3,0.1); // = <strong>true</strong>
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>,
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
</html>"));
  end isEqual;

  function solve
    "Solve real system of linear equations A*x=b with a b vector (Gaussian elimination with partial pivoting)"

    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "Matrix A of A*x = b";
    input Real b[size(A, 1)] "Vector b of A*x = b";
    output Real x[size(b, 1)] "Vector x such that A*x = b";

  protected
    Integer info;
  algorithm
    (x,info) := LAPACK.dgesv_vec(A, b);
    assert(info == 0, "Solving a linear system of equations with function
\"Matrices.solve\" is not possible, because the system has either
no or infinitely many solutions (A is singular).");
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<strong>solve</strong>(A,b);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
solution <strong>x</strong> of the linear system of equations
</p>
<blockquote>
<p>
<strong>A</strong>*<strong>x</strong> = <strong>b</strong>
</p>
</blockquote>
<p>
If a unique solution <strong>x</strong> does not exist (since <strong>A</strong> is singular),
an assertion is triggered. If this is not desired, use instead
<a href=\"modelica://Modelica.Math.Matrices.leastSquares\">Matrices.leastSquares</a>
and inquire the singularity of the solution with the return argument rank
(a unique solution is computed if rank = size(A,1)).
</p>

<p>
Note, the solution is computed with the LAPACK function \"dgesv\",
i.e., by Gaussian elimination with partial pivoting.
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real b[3] = {10,22,12};
  Real x[3];
<strong>algorithm</strong>
  x := Matrices.solve(A,b);  // x = {3,2,1}
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
<a href=\"modelica://Modelica.Math.Matrices.leastSquares\">Matrices.leastSquares</a>.
</html>"));
  end solve;

  function solve2
    "Solve real system of linear equations A*X=B with a B matrix (Gaussian elimination with partial pivoting)"

    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "Matrix A of A*X = B";
    input Real B[size(A, 1), :] "Matrix B of A*X = B";
    output Real X[size(B, 1), size(B, 2)] "Matrix X such that A*X = B";

  protected
    Integer info;
  algorithm
    (X,info) := LAPACK.dgesv(A, B);
    assert(info == 0, "Solving a linear system of equations with function
\"Matrices.solve2\" is not possible, because the system has either
no or infinitely many solutions (A is singular).");
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<strong>solve2</strong>(A,b);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
solution <strong>X</strong> of the linear system of equations
</p>
<blockquote>
<p>
<strong>A</strong>*<strong>X</strong> = <strong>B</strong>
</p>
</blockquote>
<p>
If a unique solution <strong>X</strong> does not exist (since <strong>A</strong> is singular),
an assertion is triggered. If this is not desired, use instead
<a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">Matrices.leastSquares2</a>
and inquire the singularity of the solution with the return argument rank
(a unique solution is computed if rank = size(A,1)).

</p>
<p>
Note, the solution is computed with the LAPACK function \"dgesv\",
i.e., by Gaussian elimination with partial pivoting.
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real B[3,2] = [10, 20;
                 22, 44;
                 12, 24];
  Real X[3,2];
<strong>algorithm</strong>
  X := Matrices.solve2(A, B);  /* X = [3, 6;
                                       2, 4;
                                       1, 2] */
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.LU_solve2\">Matrices.LU_solve2</a>,
<a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">Matrices.leastSquares2</a>.
</p>
</html>"));
  end solve2;

  function leastSquares
    "Solve linear equation A*x = b (exactly if possible, or otherwise in a least square sense; A may be non-square and may be rank deficient)"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix A";
    input Real b[size(A, 1)] "Vector b";
    input Real rcond=100*Modelica.Constants.eps
      "Reciprocal condition number to estimate the rank of A";
    output Real x[size(A, 2)]
      "Vector x such that min|A*x-b|^2 if size(A,1) >= size(A,2) or min|x|^2 and A*x=b, if size(A,1) < size(A,2)";
    output Integer rank "Rank of A";
  protected
    Integer info;
    Real xx[max(size(A, 1), size(A, 2))];
  algorithm
    if min(size(A)) > 0 then
      (xx,info,rank) := LAPACK.dgelsy_vec(
            A,
            b,
            rcond);
      x := xx[1:size(A, 2)];
      assert(info == 0,
        "Solving an overdetermined or underdetermined linear system\n" +
        "of equations with function \"Matrices.leastSquares\" failed.");
    else
      x := fill(0.0, size(A, 2));
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
x = Matrices.<strong>leastSquares</strong>(A,b);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns a solution of equation A*x = b in a least
square sense (A may be rank deficient):
</p>
<blockquote><pre>
minimize | A*x - b |
</pre></blockquote>

<p>
Several different cases can be distinguished (note, <strong>rank</strong> is an
output argument of this function):
</p>

<p>
<strong>size(A,1) = size(A,2)</strong>
</p>

<p> A solution is returned for a regular, as well as a singular matrix A:
</p>

<ul>
<li> <strong>rank</strong> = size(A,1):<br>
     A is <strong>regular</strong> and the returned solution x fulfills the equation
     A*x = b uniquely.</li>

<li> <strong>rank</strong> &lt; size(A,1):<br>
     A is <strong>singular</strong> and no unique solution for equation A*x = b exists.
     <ul>
     <li>  If an infinite number of solutions exists, the one is selected that fulfills
           the equation and at the same time has the minimum norm |x| for all solution
           vectors that fulfill the equation.</li>
     <li>  If no solution exists, x is selected such that |A*x - b| is as small as
           possible (but A*x - b is not zero).</li>
     </ul></li>
</ul>

<p>
<strong>size(A,1) &gt; size(A,2):</strong>
</p>

<p>
The equation A*x = b has no unique solution. The solution x is selected such that
|A*x - b| is as small as possible. If rank = size(A,2), this minimum norm solution is
unique. If rank &lt; size(A,2), there are an infinite number of solutions leading to the
same minimum value of |A*x - b|. From these infinite number of solutions, the one with the
minimum norm |x| is selected. This gives a unique solution that minimizes both
|A*x - b| and |x|.
</p>

<p>
<strong>size(A,1) &lt; size(A,2):</strong>
</p>

<ul>
<li> <strong>rank</strong> = size(A,1):<br>
     There are an infinite number of solutions that fulfill the equation A*x = b.
     From this infinite number, the unique solution is selected that minimizes |x|.
     </li>

<li> <strong>rank</strong> &lt; size(A,1):<br>
     There is either no solution of equation A*x = b, or there are again an infinite
     number of solutions. The unique solution x is returned that minimizes
      both |A*x - b| and |x|.</li>
</ul>

<p>
Note, the solution is computed with the LAPACK function \"dgelsy\",
i.e., QR or LQ factorization of A with column pivoting.
</p>

<h4>Algorithmic details</h4>

<p>
The function first computes a QR factorization with column pivoting:
</p>

<blockquote><pre>
A * P = Q * [ R11 R12 ]
            [  0  R22 ]
</pre></blockquote>

<p>
with R11 defined as the largest leading submatrix whose estimated
condition number is less than 1/rcond.  The order of R11, <strong>rank</strong>,
is the effective rank of A.
</p>

<p>
Then, R22 is considered to be negligible, and R12 is annihilated
by orthogonal transformations from the right, arriving at the
complete orthogonal factorization:
</p>

<blockquote><pre>
A * P = Q * [ T11 0 ] * Z
            [  0  0 ]
</pre></blockquote>

<p>
The minimum-norm solution is then
</p>

<blockquote><pre>
x = P * Z' [ inv(T11)*Q1'*b ]
           [        0       ]
</pre></blockquote>

<p>
where Q1 consists of the first \"rank\" columns of Q.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">Matrices.leastSquares2</a>
(same as leastSquares, but with a right hand side matrix),<br>
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
(for square, regular matrices A)
</p>

</html>"));
  end leastSquares;

  function leastSquares2
    "Solve linear equation A*X = B (exactly if possible, or otherwise in a least square sense; A may be non-square and may be rank deficient)"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix A";
    input Real B[size(A, 1), :] "Matrix B";
    input Real rcond=100*Modelica.Constants.eps
      "Reciprocal condition number to estimate rank of A";
    output Real X[size(A, 2), size(B, 2)]
      "Matrix X such that min|A*X-B|^2 if size(A,1) >= size(A,2) or min|X|^2 and A*X=B, if size(A,1) < size(A,2)";
    output Integer rank "Rank of A";
  protected
    Integer info;
    Real XX[max(size(A, 1), size(A, 2)), size(B, 2)];
  algorithm
    (XX,info,rank) := LAPACK.dgelsy(
          A,
          B,
          rcond);
    X := XX[1:size(A, 2), :];
    assert(info == 0, "Solving an overdetermined or underdetermined linear system of
equations with function \"Matrices.leastSquares2\" failed.");
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
X = Matrices.<strong>leastSquares2</strong>(A,B);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns a solution of equation A*X = B in a least
square sense (A may be rank deficient):
</p>
<blockquote><pre>
minimize | A*X - B |
</pre></blockquote>

<p>
Several different cases can be distinguished (note, <strong>rank</strong> is an
output argument of this function):
</p>

<p>
<strong>size(A,1) = size(A,2)</strong>
</p>

<p> A solution is returned for a regular, as well as a singular matrix A:
</p>

<ul>
<li> <strong>rank</strong> = size(A,1):<br>
     A is <strong>regular</strong> and the returned solution X fulfills the equation
     A*X = B uniquely.</li>

<li> <strong>rank</strong> &lt; size(A,1):<br>
     A is <strong>singular</strong> and no unique solution for equation A*X = B exists.
     <ul>
     <li>  If an infinite number of solutions exists, the one is selected that fulfills
           the equation and at the same time has the minimum norm |x| for all solution
           vectors that fulfill the equation.</li>
     <li>  If no solution exists, X is selected such that |A*X - B| is as small as
           possible (but A*X - B is not zero).</li>
     </ul></li>
</ul>

<p>
<strong>size(A,1) &gt; size(A,2):</strong>
</p>

<p>
The equation A*X = B has no unique solution. The solution X is selected such that
|A*X - B| is as small as possible. If rank = size(A,2), this minimum norm solution is
unique. If rank &lt; size(A,2), there are an infinite number of solutions leading to the
same minimum value of |A*X - B|. From these infinite number of solutions, the one with the
minimum norm |X| is selected. This gives a unique solution that minimizes both
|A*X - B| and |X|.
</p>

<p>
<strong>size(A,1) &lt; size(A,2):</strong>
</p>

<ul>
<li> <strong>rank</strong> = size(A,1):<br>
     There are an infinite number of solutions that fulfill the equation A*X = B.
     From this infinite number, the unique solution is selected that minimizes |X|.
     </li>

<li> <strong>rank</strong> &lt; size(A,1):<br>
     There is either no solution of equation A*X = B, or there are again an infinite
     number of solutions. The unique solution X is returned that minimizes
      both |A*X - B| and |X|.</li>
</ul>

<p>
Note, the solution is computed with the LAPACK function \"dgelsy\",
i.e., QR or LQ factorization of A with column pivoting.
</p>

<h4>Algorithmic details</h4>

<p>
The function first computes a QR factorization with column pivoting:
</p>

<blockquote><pre>
A * P = Q * [ R11 R12 ]
            [  0  R22 ]
</pre></blockquote>

<p>
with R11 defined as the largest leading submatrix whose estimated
condition number is less than 1/rcond.  The order of R11, <strong>rank</strong>,
is the effective rank of A.
</p>

<p>
Then, R22 is considered to be negligible, and R12 is annihilated
by orthogonal transformations from the right, arriving at the
complete orthogonal factorization:
</p>

<blockquote><pre>
A * P = Q * [ T11 0 ] * Z
            [  0  0 ]
</pre></blockquote>

<p>
The minimum-norm solution is then
</p>

<blockquote><pre>
X = P * Z' [ inv(T11)*Q1'*B ]
           [        0       ]
</pre></blockquote>

<p>
where Q1 consists of the first \"rank\" columns of Q.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Math.Matrices.leastSquares\">Matrices.leastSquares</a>
(same as leastSquares2, but with a right hand side vector),<br>
<a href=\"modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>
(for square, regular matrices A)
</p>

</html>"));
  end leastSquares2;

  function equalityLeastSquares
    "Solve a linear equality constrained least squares problem"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Minimize |A*x - a|^2";
    input Real a[size(A, 1)];
    input Real B[:, size(A, 2)] "Subject to B*x=b";
    input Real b[size(B, 1)];
    output Real x[size(A, 2)] "Solution vector";

  protected
    Integer info;
  algorithm
    assert(size(A, 2) >= size(B, 1) and size(A, 2) <= size(A, 1) + size(B, 1),
      "It is required that size(B,1) <= size(A,2) <= size(A,1) + size(B,1)\n"
       +
      "This relationship is not fulfilled, since the matrices are declared as:\n"
       + "  A[" + String(size(A, 1)) + "," + String(size(A, 2)) + "], B[" +
      String(size(B, 1)) + "," + String(size(B, 2)) + "]\n");

    (x,info) := LAPACK.dgglse_vec(
          A,
          a,
          B,
          b);

    assert(info == 0, "Solving a linear equality-constrained least squares problem
with function \"Matrices.equalityLeastSquares\" failed.");
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
x = Matrices.<strong>equalityLeastSquares</strong>(A,a,B,b);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the
solution <strong>x</strong> of the linear equality-constrained least squares problem:
</p>
<blockquote>
<p>
min|<strong>A</strong>*<strong>x</strong> - <strong>a</strong>|^2 over <strong>x</strong>, subject to <strong>B</strong>*<strong>x</strong> = <strong>b</strong>
</p>
</blockquote>

<p>
It is required that the dimensions of A and B fulfill the following
relationship:
</p>

<blockquote>
size(B,1) &le; size(A,2) &le; size(A,1) + size(B,1)
</blockquote>

<p>
Note, the solution is computed with the LAPACK function \"dgglse\"
using the generalized RQ factorization under the assumptions that
B has full row rank (= size(B,1)) and the matrix [A;B] has
full column rank (= size(A,2)). In this case, the problem
has a unique solution.
</p>
</html>"));
  end equalityLeastSquares;

  pure function LU "LU decomposition of square or rectangular matrix"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Square or rectangular matrix";
    output Real LU[size(A, 1), size(A, 2)]=A
      "L,U factors (used with LU_solve(..))";
    output Integer pivots[min(size(A, 1), size(A, 2))]
      "Pivot indices (used with LU_solve(..))";
    output Integer info "Information";
  protected
    Integer m=size(A, 1);
    Integer n=size(A, 2);
    Integer lda=max(1, size(A, 1));
  external"FORTRAN 77" dgetrf(
          m,
          n,
          LU,
          lda,
          pivots,
          info) annotation (Library="lapack");

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(LU, pivots)       = Matrices.<strong>LU</strong>(A);
(LU, pivots, info) = Matrices.<strong>LU</strong>(A);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
LU decomposition of a \"Real[m,n]\" matrix A, i.e.,
</p>
<blockquote>
<p>
<strong>P</strong>*<strong>L</strong>*<strong>U</strong> = <strong>A</strong>
</p>
</blockquote>
<p>
where <strong>P</strong> is a permutation matrix (implicitly
defined by vector <code>pivots</code>),
<strong>L</strong> is a lower triangular matrix with unit
diagonal elements (lower trapezoidal if m &gt; n), and
<strong>U</strong> is an upper triangular matrix (upper trapezoidal if m &lt; n).
Matrices <strong>L</strong> and <strong>U</strong> are stored in the returned
matrix <code>LU</code> (the diagonal of <strong>L</strong> is not stored).
With the companion function
<a href=\"modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
this decomposition can be used to solve
linear systems (<strong>P</strong>*<strong>L</strong>*<strong>U</strong>)*<strong>x</strong> = <strong>b</strong> with different right
hand side vectors <strong>b</strong>. If a linear system of equations with
just one right hand side vector <strong>b</strong> shall be solved, it is
more convenient to just use the function
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>.
</p>
<p>
The optional third (Integer) output argument has the following meaning:</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td>info = 0:</td>
      <td>successful exit</td></tr>
  <tr><td>info &gt; 0:</td>
      <td>if info = i, U[i,i] is exactly zero. The factorization
          has been completed,<br>
          but the factor U is exactly
          singular, and division by zero will occur<br> if it is used
          to solve a system of equations.</td></tr>
</table>
<p>
The LU factorization is computed
with the LAPACK function \"dgetrf\",
i.e., by Gaussian elimination using partial pivoting
with row interchanges. Vector \"pivots\" are the
pivot indices, i.e., for 1 &le; i &le; min(m,n), row i of
matrix A was interchanged with row pivots[i].
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real b1[3] = {10,22,12};
  Real b2[3] = { 7,13,10};
  Real    LU[3,3];
  Integer pivots[3];
  Real    x1[3];
  Real    x2[3];
<strong>algorithm</strong>
  (LU, pivots) := Matrices.LU(A);
  x1 := Matrices.LU_solve(LU, pivots, b1);  // x1 = {3,2,1}
  x2 := Matrices.LU_solve(LU, pivots, b2);  // x2 = {1,0,2}
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>,
</p>
</html>"));
  end LU;

  function LU_solve
    "Solve real system of linear equations P*L*U*x=b with a b vector and an LU decomposition (from LU(..))"

    extends Modelica.Icons.Function;
    input Real LU[:, size(LU, 1)]
      "L,U factors of Matrices.LU(..) for a square matrix";
    input Integer pivots[size(LU, 1)] "Pivots indices of Matrices.LU(..)";
    input Real b[size(LU, 1)] "Right hand side vector of P*L*U*x=b";
    output Real x[size(b, 1)] "Solution vector such that P*L*U*x = b";

  algorithm
    for i in 1:size(LU, 1) loop
      assert(LU[i, i] <> 0, "Solving a linear system of equations with function
\"Matrices.LU_solve\" is not possible, since the LU decomposition
is singular, i.e., no unique solution exists.");
    end for;
    x := LAPACK.dgetrs_vec(
          LU,
          pivots,
          b);
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<strong>LU_solve</strong>(LU, pivots, b);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
solution <strong>x</strong> of the linear systems of equations
</p>
<blockquote>
<p>
<strong>P</strong>*<strong>L</strong>*<strong>U</strong>*<strong>x</strong> = <strong>b</strong>;
</p>
</blockquote>
<p>
where <strong>P</strong> is a permutation matrix (implicitly
defined by vector <code>pivots</code>),
<strong>L</strong> is a lower triangular matrix with unit
diagonal elements (lower trapezoidal if m &gt; n), and
<strong>U</strong> is an upper triangular matrix (upper trapezoidal if m &lt; n).
The matrices of this decomposition are computed with function
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a> that
returns arguments <code>LU</code> and <code>pivots</code>
used as input arguments of <code>Matrices.LU_solve</code>.
With <code>Matrices.LU</code> and <code>Matrices.LU_solve</code>
it is possible to efficiently solve linear systems
with different right hand side vectors. If a linear system of equations with
just one right hand side vector shall be solved, it is
more convenient to just use the function
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>.
</p>
<p>
If a unique solution <strong>x</strong> does not exist (since the
LU decomposition is singular), an exception is raised.
</p>
<p>
The LU factorization is computed
with the LAPACK function \"dgetrf\",
i.e., by Gaussian elimination using partial pivoting
with row interchanges. Vector \"pivots\" are the
pivot indices, i.e., for 1 &le; i &le; min(m,n), row i of
matrix A was interchanged with row pivots[i].
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real b1[3] = {10,22,12};
  Real b2[3] = { 7,13,10};
  Real    LU[3,3];
  Integer pivots[3];
  Real    x1[3];
  Real    x2[3];
<strong>algorithm</strong>
  (LU, pivots) := Matrices.LU(A);
  x1 := Matrices.LU_solve(LU, pivots, b1);  // x1 = {3,2,1}
  x2 := Matrices.LU_solve(LU, pivots, b2);  // x2 = {1,0,2}
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>,
</html>"));
  end LU_solve;

  function LU_solve2
    "Solve real system of linear equations P*L*U*X=B with a B matrix and an LU decomposition (from LU(..))"

    extends Modelica.Icons.Function;
    input Real LU[:, size(LU, 1)]
      "L,U factors of Matrices.LU(..) for a square matrix";
    input Integer pivots[size(LU, 1)] "Pivots indices of Matrices.LU(..)";
    input Real B[size(LU, 1), :] "Right hand side matrix of P*L*U*X=B";
    output Real X[size(B, 1), size(B, 2)]
      "Solution matrix such that P*L*U*X = B";

  algorithm
    for i in 1:size(LU, 1) loop
      assert(LU[i, i] <> 0, "Solving a linear system of equations with function
\"Matrices.LU_solve2\" is not possible, since the LU decomposition
is singular, i.e., no unique solution exists.");
    end for;
    X := Modelica.Math.Matrices.LAPACK.dgetrs(
          LU,
          pivots,
          B);
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<strong>LU_solve2</strong>(LU, pivots, B);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
solution <strong>X</strong> of the linear systems of equations
</p>
<blockquote>
<p>
<strong>P</strong>*<strong>L</strong>*<strong>U</strong>*<strong>X</strong> = <strong>B</strong>;
</p>
</blockquote>
<p>
where <strong>P</strong> is a permutation matrix (implicitly
defined by vector <code>pivots</code>),
<strong>L</strong> is a lower triangular matrix with unit
diagonal elements (lower trapezoidal if m &gt; n), and
<strong>U</strong> is an upper triangular matrix (upper trapezoidal if m &lt; n).
The matrices of this decomposition are computed with function
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a> that
returns arguments <code>LU</code> and <code>pivots</code>
used as input arguments of <code>Matrices.LU_solve2</code>.
With <code>Matrices.LU</code> and <code>Matrices.LU_solve2</code>
it is possible to efficiently solve linear systems
with different right hand side <strong>matrices</strong>. If a linear system of equations with
just one right hand side matrix shall be solved, it is
more convenient to just use the function
<a href=\"modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>.
</p>
<p>
If a unique solution <strong>X</strong> does not exist (since the
LU decomposition is singular), an exception is raised.
</p>
<p>
The LU factorization is computed
with the LAPACK function \"dgetrf\",
i.e., by Gaussian elimination using partial pivoting
with row interchanges. Vector \"pivots\" are the
pivot indices, i.e., for 1 &le; i &le; min(m,n), row i of
matrix A was interchanged with row pivots[i].
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real B1[3] = [10, 20;
                22, 44;
                12, 24];
  Real B2[3] = [ 7, 14;
                13, 26;
                10, 20];
  Real    LU[3,3];
  Integer pivots[3];
  Real    X1[3,2];
  Real    X2[3,2];
<strong>algorithm</strong>
  (LU, pivots) := Matrices.LU(A);
  X1 := Matrices.LU_solve2(LU, pivots, B1);  /* X1 = [3, 6;
                                                      2, 4;
                                                      1, 2] */
  X2 := Matrices.LU_solve2(LU, pivots, B2);  /* X2 = [1, 2;
                                                      0, 0;
                                                      2, 4] */
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>,
</html>"));
  end LU_solve2;

  function eigenValues
    "Return eigenvalues and eigenvectors for a real, nonsymmetric matrix in a Real representation"

    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "Matrix";
    output Real eigenvalues[size(A, 1), 2]
      "Eigenvalues of matrix A (Re: first column, Im: second column)";
    output Real eigenvectors[size(A, 1), size(A, 2)]
      "Real-valued eigenvector matrix";

  protected
    Integer info;
    Boolean onlyEigenvalues=false;
  algorithm
    if size(A, 1) > 0 then
      if onlyEigenvalues then
        (eigenvalues[:, 1],eigenvalues[:, 2],info) := LAPACK.dgeev_eigenValues(A);
        eigenvectors := zeros(size(A, 1), size(A, 1));
      else
        (eigenvalues[:, 1],eigenvalues[:, 2],eigenvectors,info) := LAPACK.dgeev(A);
      end if;
      assert(info == 0, "Calculating the eigen values with function
\"Matrices.eigenvalues\" is not possible, since the
numerical algorithm does not converge.");
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
                eigenvalues = Matrices.<strong>eigenValues</strong>(A);
(eigenvalues, eigenvectors) = Matrices.<strong>eigenValues</strong>(A);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the eigenvalues and
optionally the (right) eigenvectors of a square matrix
<strong>A</strong>. The first column of \"eigenvalues\" contains the real and the
second column contains the imaginary part of the eigenvalues.
If the i-th eigenvalue has no imaginary part, then eigenvectors[:,i] is
the corresponding real eigenvector. If the i-th eigenvalue
has an imaginary part, then eigenvalues[i+1,:] is the conjugate complex
eigenvalue and eigenvectors[:,i] is the real and eigenvectors[:,i+1] is the
imaginary part of the eigenvector of the i-th eigenvalue.
With function
<a href=\"modelica://Modelica.Math.Matrices.eigenValueMatrix\">Matrices.eigenValueMatrix</a>,
a real block diagonal matrix is constructed from the eigenvalues
such that
</p>
<blockquote><pre>
A = eigenvectors * eigenValueMatrix(eigenvalues) * inv(eigenvectors)
</pre></blockquote>
<p>
provided the eigenvector matrix \"eigenvectors\" can be inverted
(an inversion is possible, if all eigenvalues are different;
in some cases, an inversion is also possible if some eigenvalues are
the same).
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real eval[3,2];
<strong>algorithm</strong>
  eval := Matrices.eigenValues(A);  // eval = [-0.618, 0;
                                    //          8.0  , 0;
                                    //          1.618, 0];
</pre></blockquote>
<p>
i.e., matrix A has the 3 real eigenvalues -0.618, 8, 1.618.
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.eigenValueMatrix\">Matrices.eigenValueMatrix</a>,
<a href=\"modelica://Modelica.Math.Matrices.singularValues\">Matrices.singularValues</a>
</html>"));
  end eigenValues;

  function eigenValueMatrix
    "Return real valued block diagonal matrix J of eigenvalues of matrix A (A=V*J*Vinv)"

    extends Modelica.Icons.Function;
    input Real eigenValues[:, 2]
      "Eigen values from function eigenValues(..) (Re: first column, Im: second column)";
    output Real J[size(eigenValues, 1), size(eigenValues, 1)]
      "Real valued block diagonal matrix with eigen values (Re: 1x1 block, Im: 2x2 block)";

  protected
    Integer n=size(eigenValues, 1);
    Integer i;
  algorithm
    J := zeros(n, n);
    i := 1;
    while i <= n loop
      if eigenValues[i, 2] == 0 then
        J[i, i] := eigenValues[i, 1];
        i := i + 1;
      else
        J[i, i] := eigenValues[i, 1];
        J[i, i + 1] := eigenValues[i, 2];
        J[i + 1, i] := eigenValues[i + 1, 2];
        J[i + 1, i + 1] := eigenValues[i + 1, 1];
        i := i + 2;
      end if;
    end while;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<strong>eigenValueMatrix</strong>(eigenvalues);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call returns a block diagonal matrix <strong>J</strong>
from the two-column matrix <code>eigenvalues</code>
(computed by function
<a href=\"modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>).
Matrix <code>eigenvalues</code> must have the real part of the
eigenvalues in the first column and the imaginary part in the
second column. If an eigenvalue i has a vanishing imaginary
part, then <strong>J</strong>[i,i] = eigenvalues[i,1], i.e., the diagonal
element of <strong>J</strong> is the real eigenvalue.
Otherwise, eigenvalue i and conjugate complex eigenvalue i+1
are used to construct a 2 by 2 diagonal block of <strong>J</strong>:
</p>
<blockquote><pre>
J[i  , i]   := eigenvalues[i,1];
J[i  , i+1] := eigenvalues[i,2];
J[i+1, i]   := eigenvalues[i+1,2];
J[i+1, i+1] := eigenvalues[i+1,1];
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>
</html>"));
  end eigenValueMatrix;

  function singularValues
    "Return singular values and left and right singular vectors"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix";
    output Real sigma[min(size(A, 1), size(A, 2))] "Singular values";
    output Real U[size(A, 1), size(A, 1)]=identity(size(A, 1))
      "Left orthogonal matrix";
    output Real VT[size(A, 2), size(A, 2)]=identity(size(A, 2))
      "Transposed right orthogonal matrix";

  protected
    Integer info;
    Integer n=min(size(A, 1), size(A, 2)) "Number of singular values";
  algorithm
    if n > 0 then
      (sigma,U,VT,info) := Modelica.Math.Matrices.LAPACK.dgesvd(A);
      assert(info == 0, "The numerical algorithm to compute the
singular value decomposition did not converge");
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
         sigma = Matrices.<strong>singularValues</strong>(A);
(sigma, U, VT) = Matrices.<strong>singularValues</strong>(A);
</pre></blockquote>
<h4>Description</h4>
<p>
This function computes the singular values and optionally the
singular vectors of matrix A. Basically the singular
value decomposition of A is computed, i.e.,
</p>
<blockquote><pre>
<strong>A</strong> = <strong>U</strong> <strong>&Sigma;</strong> <strong>V</strong><sup>T</sup>
  = U*Sigma*VT
</pre></blockquote>
<p>
where <strong>U</strong> and <strong>V</strong> are orthogonal matrices (<strong>UU</strong><sup>T</sup>=<strong>I,
</strong><strong>VV</strong><sup>T</sup>=<strong>I</strong>).
<strong>&Sigma;</strong> = [diagonal(&sigma;<sub>i</sub>), zeros(n,m-n)], if n=size(A,1) &le;
m=size(A,2)) or [diagonal(&sigma;<sub>i</sub>); zeros(n-m,m)], if n &gt;
m=size(A,2)). <strong>&Sigma;</strong> has the same size as matrix A with
nonnegative diagonal elements in decreasing order and with all other elements zero
(&sigma;<sub>1</sub> is the largest element). The function
returns the singular values &sigma;<sub>i</sub>
in vector <code>sigma</code> and the orthogonal matrices in
matrices <code>U</code> and <code>VT</code>.
</p>
<h4>Example</h4>
<blockquote><pre>
A = [1, 2,  3,  4;
     3, 4,  5, -2;
    -1, 2, -3,  5];
(sigma, U, VT) = singularValues(A);
results in:
   sigma = {8.33, 6.94, 2.31};
i.e.
   Sigma = [8.33,    0,    0, 0;
               0, 6.94,    0, 0;
               0,    0, 2.31, 0]
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>
</html>"));
  end singularValues;

  function QR
    "Return the QR decomposition of a square matrix with optional column pivoting (A(:,p) = Q*R)"

    extends Modelica.Icons.Function;
    input Real A[:, :] "Rectangular matrix with size(A,1) >= size(A,2)";
    input Boolean pivoting=true
      "= true, if column pivoting is performed. True is default";
    output Real Q[size(A, 1), size(A, 2)]
      "Rectangular matrix with orthonormal columns such that Q*R=A[:,p]";
    output Real R[size(A, 2), size(A, 2)] "Square upper triangular matrix";
    output Integer p[size(A, 2)] "Column permutation vector";

  protected
    Integer nrow=size(A, 1);
    Integer ncol=size(A, 2);
    Real tau[size(A, 2)];
  algorithm
    assert(nrow >= ncol, "\nInput matrix A[" + String(nrow) + "," + String(ncol)
       + "] has more columns than rows.
This is not allowed when calling Modelica.Math.Matrices.QR(A).");
    if pivoting then
      (Q,tau,p) := LAPACK.dgeqp3(A);
    else
      (Q,tau) := LAPACK.dgeqrf(A);
      p := 1:ncol;
    end if;

    // determine R
    R := zeros(ncol, ncol);
    for i in 1:ncol loop
      for j in i:ncol loop
        R[i, j] := Q[i, j];
      end for;
    end for;

    Q := LAPACK.dorgqr(Q, tau);
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(Q,R,p) = Matrices.<strong>QR</strong>(A);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the QR decomposition of
a rectangular matrix <strong>A</strong> (the number of columns of <strong>A</strong>
must be less than or equal to the number of rows):
</p>
<blockquote>
<p>
<strong>Q</strong>*<strong>R</strong> = <strong>A</strong>[:,<strong>p</strong>]
</p>
</blockquote>
<p>
where <strong>Q</strong> is a rectangular matrix that has orthonormal columns and
has the same size as A (<strong>Q</strong><sup>T</sup><strong>Q</strong>=<strong>I</strong>),
<strong>R</strong> is a square, upper triangular matrix and <strong>p</strong> is a permutation
vector. Matrix <strong>R</strong> has the following important properties:
</p>
<ul>
<li> The absolute value of a diagonal element of <strong>R</strong> is the largest
     value in this row, i.e.,
     abs(R[i,i]) &ge; abs(R[i,j]).</li>
<li> The diagonal elements of <strong>R</strong> are sorted according to size, such that
     the largest absolute value is abs(R[1,1]) and
     abs(R[i,i]) &ge; abs(R[j,j]) with i &lt; j.</li>
</ul>
<p>
This means that if abs(R[i,i]) &le; &epsilon; then abs(R[j,k]) &le; &epsilon;
for j &ge; i, i.e., the i-th row up to the last row of <strong>R</strong> have
small elements and can be treated as being zero.
This allows to, e.g., estimate the row-rank
of <strong>R</strong> (which is the same row-rank as <strong>A</strong>). Furthermore,
<strong>R</strong> can be partitioned in two parts
</p>
<blockquote><pre>
<strong>A</strong>[:,<strong>p</strong>] = <strong>Q</strong> * [<strong>R</strong><sub>1</sub>, <strong>R</strong><sub>2</sub>;
              <strong>0</strong>,  <strong>0</strong>]
</pre></blockquote>
<p>
where <strong>R</strong><sub>1</sub> is a regular, upper triangular matrix.
</p>
<p>
Note, the solution is computed with the LAPACK functions \"dgeqp3\"
and \"dorgqr\", i.e., by Householder transformations with
column pivoting. If <strong>Q</strong> is not needed, the function may be
called as: <code>(,R,p) = QR(A)</code>.
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real R[3,3];
<strong>algorithm</strong>
  (,R) := Matrices.QR(A);  // R = [-7.07.., -4.24.., -3.67..;
                                    0     , -1.73.., -0.23..;
                                    0     ,  0     ,  0.65..];
</pre></blockquote>
</html>"));
  end QR;

  function hessenberg "Return upper Hessenberg form of a matrix"
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices;

    input Real A[:, size(A, 1)] "Square matrix A";

    output Real H[size(A, 1), size(A, 2)] "Hessenberg form of A";
    output Real U[size(A, 1), size(A, 2)] "Transformation matrix";

  protected
    Real V[size(A, 1), size(A, 2)]
      "V=[v1,v2,..vn-1,0] with vi are vectors which define the elementary reflectors";
    Real tau[max(0, size(A, 1) - 1)]
      "Scalar factors of the elementary reflectors";

  algorithm
    (H,V,tau) := Matrices.Utilities.toUpperHessenberg(
          A,
          1,
          size(A, 1));
    U := Matrices.LAPACK.dorghr(
          V,
          1,
          size(A, 1),
          tau);
    annotation (Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
     H = Matrices.<strong>hessenberg</strong>(A);
(H, U) = Matrices.<strong>hessenberg</strong>(A);
 </pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>hessenberg</strong> computes the Hessenberg matrix <strong>H</strong> of matrix <strong>A</strong> as well as the orthogonal transformation matrix <strong>U</strong> that holds <strong>H</strong> = <strong>U</strong>'*<strong>A</strong>*<strong>U</strong>.
The Hessenberg form of a matrix is computed by repeated Householder similarity transformation. The elementary reflectors and the corresponding scalar factors are provided
by function \"Utilities.toUpperHessenberg()\". The transformation matrix <strong>U</strong> is then computed by
<a href=\"modelica://Modelica.Math.Matrices.LAPACK.dorghr\">LAPACK.dorghr</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
A  = [1, 2,  3;
      6, 5,  4;
      1, 0,  0];

(H, U) = hessenberg(A);

results in:

H = [1.0,  -2.466,  2.630;
    -6.083, 5.514, -3.081;
     0.0,   0.919, -0.514]

U = [1.0,    0.0,      0.0;
     0.0,   -0.9864,  -0.1644;
     0.0,   -0.1644,   0.9864]

and therefore,

U*H*transpose(U) = [1.0, 2.0, 3.0;
                    6.0, 5.0, 4.0;
                    1.0, 0.0, 0.0]

</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.toUpperHessenberg\">Matrices.Utilities.toUpperHessenberg</a>
</p>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end hessenberg;

  function realSchur
    "Return the real Schur form (rsf) S of a square matrix A, A=QZ*S*QZ'"
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices;

    input Real A[:, size(A, 1)] "Square matrix";

  public
    output Real S[size(A, 1), size(A, 2)] "Real Schur form of A";
    output Real QZ[size(A, 1), size(A, 2)] "Schur vector Matrix";
    output Real alphaReal[size(A, 1)]
      "Real part of eigenvalue=alphaReal+i*alphaImag";
    output Real alphaImag[size(A, 1)]
      "Imaginary part of eigenvalue=alphaReal+i*alphaImag";

  protected
    Integer info;

  algorithm
    if size(A, 1) > 1 then
      (S,QZ,alphaReal,alphaImag,info) := Matrices.LAPACK.dgees(A);
      assert(info == 0, "The output info of LAPACK.dgees should be zero, else if\n
     info < 0:  if info = -i, the i-th argument of dgees had an illegal value\n
     info > 0:  if INFO = i, and i is
               <= N: the QR algorithm failed to compute all the
                     eigenvalues; elements 1:ILO-1 and i+1:N of WR and WI
                     contain those eigenvalues which have converged; if
                     JOBVS = 'V', VS contains the matrix which reduces A
                     to its partially converged Schur form.\n");
    else
      S := A;
      QZ := fill(1, size(A, 1), size(A, 2));
      alphaReal := fill(1, size(A, 1));
      alphaImag := fill(0, size(A, 1));
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><pre>
                            S = Matrices.<strong>realSchur</strong>(A);
(S, QZ, alphaReal, alphaImag) = Matrices.<strong>realSchur</strong>(A);
</pre></blockquote>

<h4>Description</h4>

<p>
Function <strong>realSchur</strong> calculates the real Schur form of a real square matrix <strong>A</strong>, i.e.
</p>

<blockquote><pre>
<strong>A</strong> = <strong>QZ</strong>*<strong>S</strong>*transpose(<strong>QZ</strong>)
</pre></blockquote>

<p>
with the real nxn matrices <strong>S</strong> and <strong>QZ</strong>. <strong>S</strong> is a block upper triangular matrix with 1x1 and 2x2 blocks in the diagonal. <strong>QZ</strong> is an orthogonal matrix.
The 1x1 blocks contains the real eigenvalues of <strong>A</strong>. The 2x2 blocks [s11, s12; s21, s11] represents the conjugated complex pairs of eigenvalues, whereas the real parts of the eigenvalues
are the elements of the diagonal (s11). The imaginary parts are the positive and negative square roots of the product of the two elements s12 and s21 (imag = +-sqrt(s12*s21)).
</p>

<p>
The calculation in lapack.dgees is performed stepwise, i.e., using the internal methods of balancing and scaling of dgees.
</p>

<h4>Example</h4>
<blockquote><pre>
   Real A[3,3] = [1, 2, 3; 4, 5, 6; 7, 8, 9];
   Real T[3,3];
   Real Z[3,3];
   Real alphaReal[3];
   Real alphaImag[3];

<strong>algorithm</strong>
  (T, Z, alphaReal, alphaImag):=Modelica.Math.Matrices.realSchur(A);
//   T = [16.12, 4.9,   1.59E-015;
//        0,    -1.12, -1.12E-015;
//        0,     0,    -1.30E-015]
//   Z = [-0.23,  -0.88,   0.41;
//        -0.52,  -0.24,  -0.82;
//        -0.82,   0.4,    0.41]
//alphaReal = {16.12, -1.12, -1.32E-015}
//alphaImag = {0, 0, 0}
</pre></blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.reorderRSF\">Math.Matrices.Utilities.reorderRSF</a>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end realSchur;

  function cholesky
    "Return the Cholesky factorization of a symmetric positive definite matrix"
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices.LAPACK;
    input Real A[:, size(A, 1)] "Symmetric positive definite matrix";
    input Boolean upper=true
      "= true, if the right Cholesky factor (upper triangle) should be returned";

    output Real H[size(A, 1), size(A, 2)]
      "Cholesky factor U (upper=true) or L (upper=false) for A = U'*U or A = L*L'";

  protected
    Integer n=size(A, 1);
    Integer info;

  algorithm
    if size(A, 1) > 0 then
      (H,info) := LAPACK.dpotrf(A, upper);
    else
      H := fill(
            0,
            0,
            0);
      info := 0;
    end if;
    if info < 0 then
      assert(info == 0,
        "Cholesky factorization failed in function \"Matrices.cholesky\" due to illegal value of input "
         + String(info) + " for LAPACK routine DPOTRF");
    else
      assert(info == 0,
        "Cholesky factorization failed in function \"Matrices.cholesky\" since matrix A is not positive definite");
    end if;

    if upper then
      for i in 2:n loop
        for j in 1:i - 1 loop
          H[i, j] := 0.0;
        end for;
      end for;
    else
      for i in 1:n - 1 loop
        for j in i + 1:n loop
          H[i, j] := 0.0;
        end for;
      end for;
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><pre>
H = Matrices.<strong>cholesky</strong>(A);
H = Matrices.<strong>cholesky</strong>(A, upper=true);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>cholesky</strong> computes the Cholesky factorization of a real symmetric positive definite matrix A.
The optional Boolean input \"upper\" specifies whether the upper or the lower triangular matrix is returned, i.e.
</p>

<blockquote><pre>
A = H'*H   if upper is true (H is upper triangular)
A = H*H'   if upper is false (H is lower triangular)
</pre></blockquote>

<p>
The computation is performed by <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dpotrf\">LAPACK.dpotrf</a>.
</p>

<h4>Example</h4>

<blockquote><pre>
A  = [1, 0,  0;
      6, 5,  0;
      1, -2,  2];
S = A*transpose(A);

H = Matrices.cholesky(S);

results in:

H = [1.0,  6.0,  1.0;
     0.0,  5.0, -2.0;
     0.0,  0.0,  2.0]

with

transpose(H)*H = [1.0,  6.0,   1;
                  6.0, 61.0,  -4.0;
                  1.0, -4.0,   9.0] //=S

</pre></blockquote>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>

</html>"));
  end cholesky;

  function balance
    "Return a balanced form of matrix A to improve the condition of A"
    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)];
    output Real D[size(A, 1)] "diagonal(D)=T is transformation matrix, such that
          B = inv(T)*A*T has smaller condition as A";
    output Real B[size(A, 1), size(A, 1)]
      "Balanced matrix (= inv(diagonal(D))*A*diagonal(D) )";
  protected
    Integer na=size(A, 1);
    Integer radix=2 "Radix of exponent representation must be 'radix'
          or a multiple of 'radix'";
    Integer radix2=radix*radix;
    Boolean noconv=true;
    Integer i=1;
    Integer j=1;
    Real CO;
    Real RO;
    Real G;
    Real F;
    Real S;
    /*auxiliary variables*/

  algorithm
    // B = inv(D)*A*D, so that cond(B)<=cond(A)
    D := ones(na);
    B := A;
    while noconv loop
      noconv := false;
      for i in 1:na loop
        CO := sum(abs(B[:, i])) - abs(B[i, i]);
        RO := sum(abs(B[i, :])) - abs(B[i, i]);
        G := RO/radix;
        F := 1;
        S := CO + RO;
        while not (CO >= G or CO == 0) loop
          F := F*radix;
          CO := CO*radix2;
        end while;
        G := RO*radix;
        while not (CO < G or RO == 0) loop
          F := F/radix;
          CO := CO/radix2;
        end while;
        if not ((CO + RO)/F >= 0.95*S) then
          G := 1/F;
          D[i] := D[i]*F;
          B[i, :] := B[i, :]*G;
          B[:, i] := B[:, i]*F;
          noconv := true;
        end if;
      end for;
    end while;
    annotation (Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
(D,B) = Matrices.<strong>balance</strong>(A);
</pre></blockquote>

<h4>Description</h4>

<p>
This function returns a vector D, such that B=inv(diagonal(D))*A*diagonal(D) has a
better condition as matrix A, i.e., conditionNumber(B) &le; conditionNumber(A). The elements of D
are multiples of 2 which means that this function does not introduce round-off errors.
Balancing attempts to make the norm of each row of B equal to the
norm of the respective column.
</p>

<p>
Balancing is used to minimize roundoff errors induced
through large matrix calculations like Taylor-series approximation
or computation of eigenvalues.
</p>

<h4>Example</h4>

<blockquote><pre>
- A = [1, 10,  1000; 0.01,  0,  10; 0.005,  0.01,  10]
- Matrices.norm(A, 1);
  = 1020.0
- (T,B)=Matrices.balance(A)
- T
  = {256, 16, 0.5}
- B
  =  [1,     0.625,   1.953125;
      0.16,  0,       0.3125;
      2.56,  0.32,   10.0]
- Matrices.norm(B, 1);
  = 12.265625
</pre></blockquote>

<p>
The Algorithm is taken from
</p>
<dl>
<dt>H. D. Joos, G. Gr&uuml;bel:</dt>
<dd><strong>RASP'91 Regulator Analysis and Synthesis Programs</strong><br>
    DLR - Control Systems Group 1991</dd>
</dl>
<p>
which based on the <code>balance</code> function from EISPACK.
</p>

</html>", revisions="<html>
<h4>Release Notes</h4>
<ul>
<li><em>July 5, 2002</em>
       by H. D. Joos and Nico Walther<br>
       Implemented.
</li>
</ul>
</html>"));
  end balance;

  function balanceABC
    "Return a balanced form of a system [A,B;C,0] to improve its condition by a state transformation"
    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "System matrix A";
    input Real B[size(A,1),:] = fill(0.0, size(A,1),0)
      "System matrix B (need not be present)";
    input Real C[:,size(A,1)] = fill(0.0, 0, size(A,1))
      "System matrix C (need not be present)";
    output Real scale[size(A, 1)]
      "diagonal(scale)=T is such that [inv(T)*A*T, inv(T)*B; C*T, 0] has smaller condition as [A,B;C,0]";
    output Real As[size(A, 1), size(A, 1)] "Balanced matrix A (= inv(T)*A*T )";
    output Real Bs[size(A, 1), size(B, 2)] "Balanced matrix B (= inv(T)*B )";
    output Real Cs[size(C, 1), size(A, 1)] "Balanced matrix C (= C*T )";

  protected
    Integer na=size(A, 1);
    Integer radix=2 "Radix of exponent representation must be 'radix'
          or a multiple of 'radix'";
    Integer radix2=radix*radix;
    Boolean noconv=true;
    Integer i=1;
    Integer j=1;
    Real CO;
    Real RO;
    Real G;
    Real F;
    Real S;
  algorithm
    scale := ones(na);
    As := A;
    Bs := B;
    Cs := C;
    while noconv loop
      noconv := false;
      for i in 1:na loop
        CO := sum(abs(As[:, i])) - abs(As[i, i]) + sum(abs(Cs[:,i]));
        RO := sum(abs(As[i, :])) - abs(As[i, i]) + sum(abs(Bs[i,:]));
        G := RO/radix;
        F := 1;
        S := CO + RO;
        while not (CO >= G or CO == 0) loop
          F := F*radix;
          CO := CO*radix2;
        end while;
        G := RO*radix;
        while not (CO < G or RO == 0) loop
          F := F/radix;
          CO := CO/radix2;
        end while;
        if not ((CO + RO)/F >= 0.95*S) then
          G := 1/F;
          scale[i] := scale[i]*F;
          As[i, :] := As[i, :]*G;
          As[:, i] := As[:, i]*F;
          Bs[i, :] := Bs[i, :]*G;
          Cs[:, i] := Cs[:, i]*F;
          noconv := true;
        end if;
      end for;
    end while;
    annotation (Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
(scale,As,Bs,Cs) = Matrices.<strong>balanceABC</strong>(A,B,C);
(scale,As,Bs)    = Matrices.<strong>balanceABC</strong>(A,B);
(scale,As,,Cs)   = Matrices.<strong>balanceABC</strong>(A,C=C);
</pre></blockquote>

<h4>Description</h4>

<p>
This function returns a vector scale, such that with T=diagonal(scale) system matrix S_scale
</p>

<blockquote><pre>
          |inv(T)*A*T, inv(T)*B|
S_scale = |                    |
          |       C*T,     0   |
</pre></blockquote>

<p>
has a better condition as system matrix S
</p>

<blockquote><pre>
    |A, B|
S = |    |
    |C, 0|
</pre></blockquote>
<p>
that is, conditionNumber(S_scale) &le; conditionNumber(S). The elements of vector scale
are multiples of 2 which means that this function does not introduce round-off errors.
</p>

<p>
Balancing a linear dynamic system in state space form
</p>

<blockquote><pre>
der(x) = A*x + B*u
    y  = C*x + D*u
</pre></blockquote>

<p>
means to find a state transformation x_new = T*x = diagonal(scale)*x
so that the transformed system is better suited for numerical algorithms.
</p>

<h4>Example</h4>

<blockquote><pre>
import Modelica.Math.Matrices;

A = [1, -10,  1000; 0.01,  0,  10; 0.005,  -0.01,  10];
B = [100, 10; 1,0; -0.003, 1];
C = [-0.5, 1, 100];

(scale, As, Bs, Cs) := Matrices.balanceABC(A,B,C);
T    = diagonal(scale);
Diff = [Matrices.inv(T)*A*T, Matrices.inv(T)*B;
        C*T, zeros(1,2)] - [As, Bs; Cs, zeros(1,2)];
err  = Matrices.norm(Diff);

-> Results in:
scale = {16, 1, 0.0625}
norm(A)  = 1000.15, norm(B)  = 100.504, norm(C)  = 100.006
norm(As) = 10.8738, norm(Bs) = 16.0136, norm(Cs) = 10.2011
err = 0
</pre></blockquote>

<p>
The algorithm is taken from
</p>
<dl>
<dt>H. D. Joos, G. Gr&uuml;bel:</dt>
<dd><strong>RASP'91 Regulator Analysis and Synthesis Programs</strong><br>
    DLR - Control Systems Group 1991</dd>
</dl>
<p>
which is based on the <code>balance</code> function from EISPACK.
</p>
</html>", revisions="<html>
<ul>
<li><em>Sept. 14, 2014</em>
       by Martin Otter: Implemented.
</li>
</ul>
</html>"));
  end balanceABC;

  function trace
    "Return the trace of matrix A, i.e., the sum of the diagonal elements"
    extends Modelica.Icons.Function;

    input Real A[:, size(A, 1)] "Square matrix A";
    output Real result "Trace of A";
  algorithm
    result := sum(A[i, i] for i in 1:size(A, 1));
    annotation (Inline=true,Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
r = Matrices.<strong>trace</strong>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the trace, i.e., the sum of the elements in the diagonal of matrix <strong>A</strong>.
</p>

<h4>Example</h4>
<blockquote><pre>
A = [1, 3;
     2, 1];
r = trace(A);

results in:

r = 2.0
</pre></blockquote>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end trace;

  function det
    "Return determinant of a matrix (computed by LU decomposition; try to avoid det(..))"

    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)];
    output Real result "Determinant of matrix A";
  protected
    Real LU[size(A, 1), size(A, 1)];
    Integer pivots[size(A, 1)];

  algorithm
    (LU,pivots) := Matrices.LU(A);
    result := product(LU[i, i] for i in 1:size(A, 1))*product(if pivots[i] == i
       then 1 else -1 for i in 1:size(pivots, 1));
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
result = Matrices.<strong>det</strong>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the determinant \"result\" of matrix A
computed by a LU decomposition with row pivoting. For details about determinants, see
<a href=\"http://en.wikipedia.org/wiki/Determinant\">http://en.wikipedia.org/wiki/Determinant</a>.
Usually, this function should never be used, because
there are nearly always better numerical algorithms
as by computing the determinant. Examples:
</p>

<ul>
<li> Use <a href=\"modelica://Modelica.Math.Matrices.rank\">Matrices.rank</a>
     to compute whether det(A) = 0 (i.e., Matrices.rank(A) &lt; size(A,1)).</li>

<li> Use <a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
     to solve the linear equation A*x = b, instead of using determinants to
     compute the solution.</li>
</ul>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.rank\">Matrices.rank</a>,
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
</html>"));
  end det;

  function inv "Return inverse of a matrix (try to avoid inv(..))"
    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)];
    output Real invA[size(A, 1), size(A, 2)] "Inverse of matrix A";
  protected
    Integer info;
    Integer pivots[size(A, 1)] "Pivot vector";
    Real LU[size(A, 1), size(A, 2)] "LU factors of A";
  algorithm
    (LU,pivots,info) := LAPACK.dgetrf(A);

    assert(info == 0, "Calculating an inverse matrix with function
\"Matrices.inv\" is not possible, since matrix A is singular.");

    invA := LAPACK.dgetri(LU, pivots);

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
invA = Matrices.<strong>inv</strong>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the inverse of matrix A, i.e., A*inv(A) = identity(size(A,1))
computed by a LU decomposition with row pivoting.
Usually, this function should not be used, because
there are nearly always better numerical algorithms
as by computing directly the inverse. Example:
</p>

<blockquote>
Use x = <a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>(A,b)
to solve the linear equation A*x = b, instead of computing the solution by
x = inv(A)*b, because this is much more efficient and much more reliable.
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
<a href=\"modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>
</html>"));
  end inv;

  function rank
    "Return rank of a rectangular matrix (computed with singular values)"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix";
    input Real eps=0
      "If eps > 0, the singular values are checked against eps; otherwise eps=max(size(A))*norm(A)*Modelica.Constants.eps is used";
    output Integer result "Rank of matrix A";

  protected
    Integer n=min(size(A, 1), size(A, 2));
    Integer i=n;
    Real sigma[min(size(A, 1), size(A, 2))];
    Real eps2;
  algorithm
    result := 0;
    if n > 0 then
      sigma := Modelica.Math.Matrices.singularValues(A);
      eps2 := if eps > 0 then eps else max(size(A))*sigma[1]*Modelica.Constants.eps;
      while i > 0 loop
        if sigma[i] > eps2 then
          result := i;
          i := 0;
        end if;
        i := i - 1;
      end while;
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
result = Matrices.<strong>rank</strong>(A);
result = Matrices.<strong>rank</strong>(A,eps=0);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the rank of a square or rectangular matrix A computed by singular value decomposition.
For details about the rank of a matrix, see
<a href=\"http://en.wikipedia.org/wiki/Matrix_rank\">http://en.wikipedia.org/wiki/Matrix_rank</a>.
To be more precise:
</p>

<ul>
<li> rank(A) returns the number of singular values of A that are larger than
     max(size(A))*norm(A)*Modelica.Constants.eps.</li>
<li> rank(A, eps) returns the number of singular values of A that are larger than \"eps\".</li>
</ul>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.rcond\">Matrices.rcond</a>.
</html>"));
  end rank;

  function conditionNumber
    "Return the condition number norm(A)*norm(inv(A)) of a matrix A"
    extends Modelica.Icons.Function;

    input Real A[:, :] "Input matrix";
    input Real p(min=1) = 2
      "Type of p-norm (only allowed: 1, 2 or Modelica.Constants.inf)";
    output Real result=0.0 "Condition number of matrix A";

  protected
    Real eps=1e-25;
    Real eps2 = 10*Modelica.Constants.eps;
    Real s[size(A, 1)] "Singular values";

  algorithm
    if min(size(A)) > 0 then
      if p >= 2-eps2 and p <= 2+eps2 then
        s := Modelica.Math.Matrices.singularValues(A);
        if min(s) < eps then
          result := Modelica.Constants.inf;
        else
          result := max(s)/min(s);
        end if;
      else
        result := Modelica.Math.Matrices.norm(A, p)*Modelica.Math.Matrices.norm(
          Modelica.Math.Matrices.inv(A), p);
      end if;
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
r = Matrices.<strong>conditionNumber</strong>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
This function calculates the condition number (norm(A) * norm(inv(A))) of a general real matrix <strong>A</strong>, in either the 1-norm, 2-norm or the infinity-norm.
In the case of 2-norm the result is the ratio of the largest to the smallest singular value of <strong>A</strong>.
For more details, see <a href=\"http://en.wikipedia.org/wiki/Condition_number\">http://en.wikipedia.org/wiki/Condition_number</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
A = [1, 2;
     2, 1];
r = conditionNumber(A);

results in:

r = 3.0
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.rcond\">Matrices.rcond</a>
</p>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end conditionNumber;

  function rcond "Return the reciprocal condition number of a matrix"
    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "Square real matrix";
    input Boolean inf=false
      "Is true if infinity norm is used and false for 1-norm";
    output Real rcond "Reciprocal condition number of A";
    output Integer info "Information";
  protected
    Real LU[size(A, 1), size(A, 1)]
      "LU factorization of matrix A, returned by dgetrf";
    Real anorm "Norm of matrix A";
    String normspec=if inf then "I" else "1" "Specifies the norm 1 or inf";

  algorithm
    if min(size(A)) > 0 then
      (LU,,info) := Modelica.Math.Matrices.LAPACK.dgetrf(A);
      anorm := Modelica.Math.Matrices.LAPACK.dlange(A, normspec);
      (rcond,info) := Modelica.Math.Matrices.LAPACK.dgecon(
            LU,
            inf,
            anorm);
    else
      rcond := Modelica.Constants.inf;
      info := 0;
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
r = Matrices.<strong>rcond</strong>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
This function estimates the reciprocal of the condition number (norm(A) * norm(inv(A))) of a general real matrix <strong>A</strong>, in either the 1-norm or
the infinity-norm, using the LAPACK function <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dgecon\">DGECON</a>.
If rcond(A) is near 1.0, <strong>A</strong> is well conditioned and <strong>A</strong> is ill conditioned if rcond(A) is near zero.
</p>

<h4>Example</h4>
<blockquote><pre>
A = [1, 2;
     2, 1];
r = rcond(A);

results in:

r = 0.3333
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.conditionNumber\">Matrices.conditionNumber</a>
</p>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end rcond;

  function norm "Return the p-norm of a matrix"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Input matrix";
    input Real p(min=1) = 2
      "Type of p-norm (only allowed: 1, 2 or Modelica.Constants.inf)";
    output Real result=0.0 "p-norm of matrix A";
  protected
    Real eps = 10*Modelica.Constants.eps;
  algorithm
   if min(size(A)) > 0 then
    if p >= 1-eps and p <= 1+eps then
      // column sum norm
      for i in 1:size(A, 2) loop
        result := max(result, sum(abs(A[:, i])));
      end for;
    elseif p >= 2-eps and p <= 2+eps then
      // largest singular value
      result := max(singularValues(A));
    elseif p >= Modelica.Constants.inf then
      // row sum norm
      for i in 1:size(A, 1) loop
        result := max(result, sum(abs(A[i, :])));
      end for;
    else
      assert(false, "Optional argument \"p\" (= " + String(p) + ") of function \"norm\" must be
1, 2 or Modelica.Constants.inf");
    end if;
   end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<strong>norm</strong>(A);
Matrices.<strong>norm</strong>(A, p=2);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call \"<code>Matrices.norm(A)</code>\" returns the
2-norm of matrix A, i.e., the largest singular value of A.<br>
The function call \"<code>Matrices.norm(A, p)</code>\" returns the
p-norm of matrix A. The only allowed values for p are
</p>

<ul>
<li> \"p=1\": the largest column sum of A</li>
<li> \"p=2\": the largest singular value of A</li>
<li> \"p=Modelica.Constants.inf\": the largest row sum of A</li>
</ul>

<p>
Note, for any matrices A1, A2 the following inequality holds:
</p>

<blockquote><pre>
Matrices.<strong>norm</strong>(A1+A2,p) &le; Matrices.<strong>norm</strong>(A1,p) + Matrices.<strong>norm</strong>(A2,p)
</pre></blockquote>

<p>
Note, for any matrix A and vector v the following inequality holds:
</p>

<blockquote><pre>
Vectors.<strong>norm</strong>(A*v,p) &le; Matrices.<strong>norm</strong>(A,p)*Vectors.<strong>norm</strong>(A,p)
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.frobeniusNorm\">Matrices.frobeniusNorm</a>
</p>

</html>"));
  end norm;

  function frobeniusNorm "Return the Frobenius norm of a matrix"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Input matrix";
    output Real result "Frobenius norm of matrix A";

  algorithm
    result := if min(size(A)) > 0 then sqrt(sum(A .* A)) else 0.0;

    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
r = Matrices.<strong>frobeniusNorm</strong>(A);
</pre></blockquote>

<h4>Description</h4>

<p>
This function computes the Frobenius norm of a general real matrix <strong>A</strong>, i.e., the square root of the sum of the squares of all elements.
</p>

<h4>Example</h4>
<blockquote><pre>
A = [1, 2;
     2, 1];
r = frobeniusNorm(A);

results in:

r = 3.162;
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.norm\">Matrices.norm</a>
</p>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end frobeniusNorm;

  function nullSpace "Return the orthonormal nullspace of a matrix"
    extends Modelica.Icons.Function;

    input Real A[:, :] "Input matrix";
    output Real Z[size(A, 2), :] "Orthonormal nullspace of matrix A";
    output Integer nullity "Nullity, i.e., the dimension of the nullspace";

  protected
    Real V[size(A, 2), size(A, 2)] "Right orthogonal matrix";
    Real sigma[min(size(A, 1), size(A, 2))] "Singular values";
    Integer rank "Rank of matrix A";
    Real eps "Tolerance for rank determination";
    Integer n=min(size(A, 1), size(A, 2));
    Integer i=n;

  algorithm
    (sigma,,V) := Modelica.Math.Matrices.singularValues(A);
    V := transpose(V);
    // rank computation
    eps := max(size(A, 1), size(A, 2))*max(sigma)*Modelica.Constants.eps;
    rank := 0;
    if n > 0 then
      while i > 0 loop
        if sigma[i] > eps then
          rank := i;
          i := 0;
        end if;
        i := i - 1;
      end while;
    end if;
    Z := V[:, rank + 1:size(A, 2)];
    // nullspace computation
    nullity := size(A, 2) - rank;
    // nullity

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
           Z = Matrices.<strong>nullspace</strong>(A);
(Z, nullity) = Matrices.<strong>nullspace</strong>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
This function calculates an orthonormal basis <strong>Z</strong>=[<strong>z</strong>_1, <strong>z</strong>_2, ...] of the nullspace of a matrix <strong>A</strong>, i.e., <strong>A</strong>*<strong>z</strong>_i=<strong>0</strong>.
</p>

<p>
The nullspace is obtained by SVD method. That is, matrix <strong>A</strong> is decomposed into the matrices <strong>S</strong>, <strong>U</strong>, <strong>V</strong>:
</p>

<blockquote><pre>
<strong>A</strong> = <strong>U</strong>*<strong>S</strong>*transpose(<strong>V</strong>)
</pre></blockquote>

<p>
with the orthonormal matrices <strong>U</strong> and <strong>V</strong> and the matrix <strong>S</strong> with
</p>

<blockquote><pre>
<strong>S</strong> = [<strong>S</strong>1, <strong>0</strong>]
<strong>S</strong>1 = [diag(s); <strong>0</strong>]
</pre></blockquote>

<p>
and the singular values <strong>s</strong>={s1, s2, ..., sr} of <strong>A</strong> and r=rank(<strong>A</strong>). Note, that <strong>S</strong> has the same size as <strong>A</strong>. Since <strong>U</strong> and <strong>V</strong> are orthonormal we may write
</p>

<blockquote><pre>
transpose(<strong>U</strong>)*<strong>A</strong>*<strong>V</strong> = [<strong>S</strong>1, <strong>0</strong>].
</pre></blockquote>

<p>
Matrix <strong>S</strong>1 obviously has full column rank and therefore, the left n-r rows (n is the number of columns of <strong>A</strong> or <strong>S</strong>) of matrix <strong>V</strong> span a nullspace of <strong>A</strong>.
</p>

<p>
The nullity of matrix <strong>A</strong> is the dimension of the nullspace of <strong>A</strong>. In view of the above, it becomes clear that nullity holds
</p>
<blockquote><pre>
nullity = n - r
</pre></blockquote>
<p>
with
</p>
<blockquote><pre>
n = number of columns of matrix <strong>A</strong>
r = rank(<strong>A</strong>)
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
A = [1, 2,  3, 1;
     3, 4,  5, 2;
    -1, 2, -3, 3];
(Z, nullity) = nullspace(A);

results in:

Z=[0.1715;
  -0.686;
   0.1715;
   0.686]

nullity = 1
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.singularValues\">Matrices.singularValues</a>
</p>
</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end nullSpace;

  function exp
    "Return the exponential of a matrix by adaptive Taylor series expansion with scaling and balancing"

    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)];
    input Real T=1;
    output Real phi[size(A, 1), size(A, 1)] "= exp(A*T)";

  protected
    parameter Integer nmax=21;
    /*max number of iterations*/
    parameter Integer na=size(A, 1);
    Integer j=1;
    Integer k=0;
    Boolean done=false;
    Real Anorm;
    Real Tscaled=1;
    Real Atransf[na, na];
    Real D[na, na];
    /*D: dummy variable for psi*/
    Real M[na, na];
    /*M: dummy matrix*/
    Real Diag[na];
    /*diagonal transformation matrix for balancing*/

    encapsulated function columnNorm "Returns the column norm of a matrix"
      import Modelica;
      extends Modelica.Icons.Function;
      input Real A[:, :] "Input matrix";
      output Real result=0.0 "1-norm of matrix A";
    algorithm
      for i in 1:size(A, 2) loop
        result := max(result, sum(abs(A[:, i])));
      end for;
    end columnNorm;

  algorithm
    // balancing of A
    (Diag,Atransf) := balance(A);

    // scaling of T until norm(A)*/(2^k) < 1
    Tscaled := T;
    /*Anorm: column-norm of matrix A*/
    Anorm := columnNorm(Atransf);
    Anorm := Anorm*T;
    while Anorm >= 0.5 loop
      Anorm := Anorm/2;
      Tscaled := Tscaled/2;
      k := k + 1;
    end while;

    // Computation of psi by Taylor-series approximation
    M := identity(na);
    D := M;
    while j < nmax and not done loop
      M := Atransf*M*Tscaled/j;
      //stop if the new element of the series is small
      if columnNorm((D + M) - D) == 0 then
        done := true;
      else
        D := M + D;
        j := j + 1;
      end if;
    end while;

    // re-scaling
    for i in 1:k loop
      D := D*D;
    end for;

    // re-balancing: psi := diagonal(Diag)*D*inv(diagonal(Diag));
    for j in 1:na loop
      for k in 1:na loop
        phi[j, k] := D[j, k]*Diag[j]/Diag[k];
      end for;
    end for;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
phi = Matrices.<strong>exp</strong>(A);
phi = Matrices.<strong>exp</strong>(A,T=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the exponential e<sup><strong>A</strong>T</sup> of matrix <strong>A</strong>, i.e.
</p>
<blockquote><pre>
                       (<strong>A</strong>T)^2   (<strong>A</strong>T)^3
<font size=\"4\"> <strong>&Phi;</strong></font> = e^(<strong>A</strong>T) = <strong>I</strong> + <strong>A</strong>T + ------ + ------ + ....
                         2!       3!
</pre></blockquote>

<p>where e=2.71828..., <strong>A</strong> is an n x n matrix with real elements and T is a real number,
e.g., the sampling time.
<strong>A</strong> may be singular. With the exponential of a matrix it is, e.g., possible
to compute the solution of a linear system of differential equations</p>
<blockquote><pre>
der(<strong>x</strong>) = <strong>A</strong>*<strong>x</strong>   ->   <strong>x</strong>(t0 + T) = e^(<strong>A</strong>T)*x(t0)
</pre></blockquote>

<h4>Algorithmic details</h4>

<p>The algorithm is taken from</p>
<dl>
<dt>H. D. Joos, G. Gr&uuml;bel:</dt>
<dd><strong>RASP'91 Regulator Analysis and Synthesis Programs</strong><br>
    DLR - Control Systems Group 1991</dd>
</dl>
<p>The following steps are performed to calculate the exponential of A:</p>
<ol>
  <li>Matrix <strong>A</strong> is balanced<br>
  (= is transformed with a diagonal matrix <strong>D</strong>, such that inv(<strong>D</strong>)*<strong>A</strong>*<strong>D</strong>
  has a smaller condition as <strong>A</strong>).</li>
  <li>The scalar T is divided by a multiple of 2 such that norm(
       inv(<strong>D</strong>)*<strong>A</strong>*<strong>D</strong>*T/2^k ) &lt; 0.5. Note, that (1) and (2) are implemented such that no round-off errors
  are introduced.</li>
  <li>The matrix from (2) is approximated by explicitly performing the Taylor
  series expansion with a variable number of terms.
  Truncation occurs if a new term does no longer contribute to the value of <strong>&Phi;</strong>
  from the previous iteration.</li>
  <li>The resulting matrix is transformed back, by reverting the steps of (2)
  and (1).</li>
</ol>
<p>In several sources it is not recommended to use Taylor series expansion to
calculate the exponential of a matrix, such as in 'C.B. Moler and C.F. Van Loan:
Nineteen dubious ways to compute the exponential of a matrix. SIAM Review 20,
pp. 801-836, 1979' or in the documentation of m-file expm2 in MATLAB version 6
(<a href=\"http://www.mathworks.com\">http://www.mathworks.com</a>) where it is
stated that 'As a practical numerical method, this is often slow and inaccurate'.
These statements are valid for a direct implementation of the Taylor series
expansion, but <em>not</em> for the implementation variant used in this function.
</p>

</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>July 5, 2002</em>
       by H. D. Joos and Nico Walther<br>
       Implemented.
</li>
</ul>
</html>"));
  end exp;

  function integralExp
    "Return the exponential and the integral of the exponential of a matrix"

    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)];
    input Real B[size(A, 1), :];
    input Real T=1;
    output Real phi[size(A, 1), size(A, 1)] "= exp(A*T)";
    output Real gamma[size(A, 1), size(B, 2)] "= integral(phi)*B";
  protected
    parameter Integer nmax=21;
    /*max number of iterations*/
    parameter Integer na=size(A, 1);
    Integer j=2;
    Integer k=0;
    Boolean done=false;
    Real Anorm;
    Real Tscaled=1;
    Real Atransf[na, na];
    Real Psi[na, na];
    /*Psi: dummy variable for psi*/
    Real M[na, na];
    /*M: dummy matrix*/
    Real Diag[na];
    /*diagonal transformation matrix for balancing*/

    encapsulated function columnNorm "Returns the column norm of a matrix"
      import Modelica;
      extends Modelica.Icons.Function;
      input Real A[:, :] "Input matrix";
      output Real result=0.0 "1-norm of matrix A";
    algorithm
      for i in 1:size(A, 2) loop
        result := max(result, sum(abs(A[:, i])));
      end for;
    end columnNorm;
  algorithm
    // balancing of A
    (Diag,Atransf) := balance(A);

    // scaling of T until norm(A)*/(2^k) < 0.5
    Tscaled := T;
    /*Anorm: column-norm of matrix A*/
    // Anorm := norm(Atransf, 1);
    Anorm := columnNorm(Atransf);
    Anorm := Anorm*T;
    while Anorm >= 0.5 loop
      Anorm := Anorm/2;
      Tscaled := Tscaled/2;
      k := k + 1;
    end while;

    // Computation of psi by Taylor-series approximation
    M := identity(na)*Tscaled;
    Psi := M;
    while j < nmax and not done loop
      M := Atransf*M*Tscaled/j;
      //stop if the new element of the series is small
      // if norm((Psi + M) - Psi, 1) == 0 then
      if columnNorm((Psi + M) - Psi) == 0 then
        done := true;
      else
        Psi := M + Psi;
        j := j + 1;
      end if;
    end while;

    // re-scaling
    for j in 1:k loop
      Psi := Atransf*Psi*Psi + 2*Psi;
    end for;

    // re-balancing: psi := diagonal(Diag)*D*inv(diagonal(Diag));
    for j in 1:na loop
      for k in 1:na loop
        Psi[j, k] := Psi[j, k]*Diag[j]/Diag[k];
      end for;
    end for;
    gamma := Psi*B;
    phi := A*Psi + identity(na);

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(phi,gamma) = Matrices.<strong>integralExp</strong>(A,B);
(phi,gamma) = Matrices.<strong>integralExp</strong>(A,B,T=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the exponential phi = e^(<strong>A</strong>T) of matrix <strong>A</strong>
and the integral gamma = integral(phi*dt)*B.
</p>

<p>
The function uses a Taylor series expansion with Balancing and
scaling/squaring to approximate the integral <strong>&Psi;</strong> of the matrix
exponential <strong>&Phi;</strong>=e^(AT):
</p>
<blockquote><pre>
                         AT^2   A^2 * T^3          A^k * T^(k+1)
<strong>&Psi;</strong> = int(e^(As))ds = IT + ---- + --------- + ... + --------------
                          2!        3!                (k+1)!
</pre></blockquote>
<p>
<strong>&Phi;</strong> is calculated through <strong>&Phi;</strong> = I + A*<strong>&Psi;</strong>, so A may be singular. <strong>&Gamma;</strong> is
simply <strong>&Psi;</strong>*B.
</p>
<p>The algorithm runs in the following steps:</p>
<ol>
  <li>Balancing</li>
  <li>Scaling</li>
  <li>Taylor series expansion</li>
  <li>Re-scaling</li>
  <li>Re-Balancing</li>
</ol>
<p>Balancing put the bad condition of a square matrix <em>A</em> into a diagonal
transformation matrix <em>D</em>. This reduce the effort of following calculations.
Afterwards the result have to be re-balanced by transformation D*A<small>transf</small>
*inv(D).<br>
Scaling halfen T&nbsp; k-times, until the norm of A*T is less than 0.5. This
guarantees minimum rounding errors in the following series
expansion. The re-scaling based on the equation&nbsp; exp(A*2T) = exp(AT)^2.
The needed re-scaling formula for psi thus becomes:
</p>
<blockquote><pre>
      <strong>&Phi;</strong> = <strong>&Phi;</strong>'*<strong>&Phi;</strong>'
I + A*<strong>&Psi;</strong> = I + 2A*<strong>&Psi;</strong>' + A^2*<strong>&Psi;</strong>'^2
      <strong>&Psi;</strong> = A*<strong>&Psi;</strong>'^2 + 2*<strong>&Psi;</strong>'
</pre></blockquote>
<p>
where psi' is the scaled result from the series expansion while psi is the
re-scaled matrix.
</p>
<p>
The function is normally used to discretize a state-space system as the
zero-order-hold equivalent:
</p>
<blockquote><pre>
x(k+1) = <strong>&Phi;</strong>*x(k) + <strong>&Gamma;</strong>*u(k)
  y(k) = C*x(k) + D*u(k)
</pre></blockquote>
<p>
The zero-order-hold sampling, also known as step-invariant method, gives
exact values of the state variables, under the assumption that the control
signal u is constant between the sampling instants. Zero-order-hold sampling
is described in
</p>
<dl>
<dt>K. J. &Aring;str&ouml;m, B. Wittenmark:</dt>
<dd><strong>Computer Controlled Systems - Theory and Design</strong><br>
    Third Edition, p. 32</dd>
</dl>
<blockquote><pre><strong>Syntax:</strong>
      (phi,gamma) = Matrices.expIntegral(A,B,T)
                       A,phi: [n,n] square matrices
                     B,gamma: [n,m] input matrix
                           T: scalar, e.g., sampling time
</pre></blockquote>
<p>
The Algorithm to calculate psi is taken from
</p>
<dl>
<dt>H. D. Joos, G. Gr&uuml;bel:</dt>
<dd><strong>RASP'91 Regulator Analysis and Synthesis Programs</strong><br>
    DLR - Control Systems Group 1991</dd>
</dl>
</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>July 5, 2002</em>
       by H. D. Joos and Nico Walther<br>
       Implemented.
</li>
</ul>
</html>"));
  end integralExp;

  function integralExpT
    "Return the exponential, the integral of the exponential, and time-weighted integral of the exponential of a matrix"

    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)];
    input Real B[size(A, 1), :];
    input Real T=1;
    output Real phi[size(A, 1), size(A, 1)] "= exp(A*T)";
    output Real gamma[size(A, 1), size(B, 2)] "= integral(phi)*B";
    output Real gamma1[size(A, 1), size(B, 2)] "= integral((T-t)*exp(A*t))*B";
  protected
    Integer nmax=200;
    /*max number of iterations*/
    parameter Integer na=size(A, 1);
    parameter Integer nb=size(B, 2);
    Integer j=1;
    Boolean done=false;
    Real F[na + 2*nb, na + 2*nb];

  algorithm
    F := [A, B, zeros(na, nb); zeros(2*nb, na), zeros(2*nb, nb), [identity(nb);
      zeros(nb, nb)]];
    F := exp(F, T);
    phi := F[1:na, 1:na];
    gamma := F[1:na, na + 1:na + nb];
    gamma1 := F[1:na, na + nb + 1:na + 2*nb];

    annotation (Documentation(info="<html>
<blockquote><pre>
(phi,gamma,gamma1) = Matrices.<strong>integralExpT</strong>(A,B);
(phi,gamma,gamma1) = Matrices.<strong>integralExpT</strong>(A,B,T=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the exponential phi = e^(<strong>A</strong>T) of matrix <strong>A</strong>
and the integral gamma = integral(phi*dt)*B and the integral
integral((T-t)*exp(A*t)*dt)*B, where A is a square (n,n) matrix and
B, gamma, and gamma1 are (n,m) matrices.
</p>

<p>
The function calculates the matrices phi,gamma,gamma1 through the equation:
</p>
<blockquote><pre>
                                 [ A B 0 ]
[phi gamma gamma1] = [I 0 0]*exp([ 0 0 I ]*T)
                                 [ 0 0 0 ]
</pre></blockquote>

<p>
The matrices define the discretized first-order-hold equivalent of
a state-space system:
</p>
<blockquote><pre>
x(k+1) = phi*x(k) + gamma*u(k) + gamma1/T*(u(k+1) - u(k))
</pre></blockquote>
<p>
The first-order-hold sampling, also known as ramp-invariant method, gives
more smooth control signals as the ZOH equivalent. First-order-hold sampling
is, e.g., described in
</p>

<dl>
<dt>K. J. &Aring;str&ouml;m, B. Wittenmark:</dt>
<dd><strong>Computer Controlled Systems - Theory and Design</strong><br>
    Third Edition, p. 256</dd>
</dl>

</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>July 31, 2002</em>
       by Nico Walther<br>
       Realized.
</li>
</ul>
</html>"));
  end integralExpT;

  //
  // protected

  function continuousLyapunov
    "Return solution X of the continuous-time Lyapunov equation X*A + A'*X = C"
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices;

    input Real A[:, size(A, 1)] "Square matrix A in X*A + A'*X = C";
    input Real C[size(A, 1), size(A, 2)] "Square matrix C in X*A + A'*X = C";
    input Boolean ATisSchur=false
      "= true, if transpose(A) has already real Schur form";
    input Real eps=Modelica.Math.Matrices.norm(A, 1)*10*1e-15 "Tolerance eps";

  protected
    Integer n=size(A, 1);
    Real R[size(A, 1), size(A, 2)] "rsf of A', i.e., R=U'A'U";
    Real U[size(A, 1), size(A, 2)] "Transformation matrix U for R=U'A'U";
    Real D[size(A, 1), size(A, 2)] "Matrix D=U'*C*U";
    Real R11[size(A, 1), size(A, 2)];
    Real R22[size(A, 1), size(A, 2)];
    Real R12[size(A, 1), size(A, 2)];
    Real R21[size(A, 1), size(A, 2)];
    Real R2[2*size(A, 1), 2*size(A, 2)];
    Real I[size(A, 1), size(A, 1)]=identity(size(A, 1));
    Real y[2*size(A, 1)];
    Real c[2*size(A, 1)];
    Real CC[size(A, 1), 2];
    Integer k;

  public
    output Real X[size(A, 1), size(A, 2)]
      "Solution X of the Lyapunov equation X*A + A'*X = C";

  algorithm
    if n > 1 then
      if ATisSchur then
        R := transpose(A);
        U := identity(n);
        D := C;
      else
        (R,U) := Modelica.Math.Matrices.realSchur(transpose(A));
        D := transpose(U)*C*U;
      end if;

      X := zeros(n, n);

      // Calculate the last 1 or 2 columns of X
      R22 := R;
      for i1 in 1:n loop
        R22[i1, i1] := R[i1, i1] + R[n, n];
      end for;
      if abs(R[n, n - 1]) < eps then
        X[:, n] := Matrices.solve(R22, D[:, n]);
        k := n - 1;
      else
        R11 := R;
        R12 := zeros(n, n);
        R21 := zeros(n, n);
        for i1 in 1:n loop
          R11[i1, i1] := R[i1, i1] + R[n - 1, n - 1];
          R12[i1, i1] := R[n - 1, n];
          R21[i1, i1] := R[n, n - 1];
        end for;

        // solve 2nx2n equation for 2x2 Schur bump with Kronecker product and vec operator approach
        R2 := [R11, R12; R21, R22];
        c := cat(
              1,
              D[:, n - 1],
              D[:, n]);
        y := Matrices.solve(R2, c);
        X[:, n - 1] := y[1:n];
        X[:, n] := y[n + 1:2*n];
        k := n - 2;
      end if;

      // Calculate the rest of X
      while k > 1 loop
        R22 := R;
        for i1 in 1:n loop
          R22[i1, i1] := R[i1, i1] + R[k, k];
        end for;
        if abs(R[k, k - 1]) < eps then
          //real eigenvalue
          X[:, k] := Matrices.solve(R22, D[:, k] - vector(X[:, k + 1:n]*matrix(
            R[k, k + 1:n])));
          k := k - 1;
        else
          // conjugated complex eigenvalues
          R11 := R;
          R12 := zeros(n, n);
          R21 := zeros(n, n);
          for i1 in 1:n loop
            R11[i1, i1] := R[i1, i1] + R[k - 1, k - 1];
            R12[i1, i1] := R[k - 1, k];
            R21[i1, i1] := R[k, k - 1];
          end for;
          R2 := [R11, R12; R21, R22];
          CC := D[:, k - 1:k] - X[:, k + 1:n]*transpose(R[k - 1:k, k + 1:n]);
          c := cat(
                1,
                CC[:, 1],
                CC[:, 2]);
          y := Matrices.solve(R2, c);
          X[:, k - 1] := y[1:n];
          X[:, k] := y[n + 1:2*n];

          k := k - 2;
        end if;
      end while;
      // k=1 or k=0

      // if k=1 the first column (if there exist a real eigenvalue) has to be calculated separately
      if k == 1 then
        R22 := R;
        for i1 in 1:n loop
          R22[i1, i1] := R[i1, i1] + R[1, 1];
        end for;
        X[:, 1] := Matrices.solve(R22, D[:, 1] - vector(X[:, 2:n]*matrix(R[1, 2
          :n])));
      end if;

      // transform X corresponding to the original form
      if not ATisSchur then
        X := U*X*transpose(U);
      end if;

    elseif n == 1 then
      //simple scalar equation
      X[1, 1] := C[1, 1]/(2*A[1, 1]);
    else
      X := fill(
            0,
            0,
            0);
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
X = Matrices.<strong>continuousLyapunov</strong>(A, C);
X = Matrices.<strong>continuousLyapunov</strong>(A, C, ATisSchur, eps);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the solution <strong>X</strong> of the continuous-time Lyapunov equation
</p>

<blockquote><pre>
<strong>X</strong>*<strong>A</strong> + <strong>A</strong>'*<strong>X</strong> = <strong>C</strong>
</pre></blockquote>

<p>
using the Schur method for Lyapunov equations proposed by Bartels and Stewart [1].
</p>

<p>
In a nutshell, the problem is reduced to the corresponding problem
</p>

<blockquote><pre>
<strong>Y</strong>*<strong>R</strong>' + <strong>R</strong>*<strong>Y</strong> = <strong>D</strong>
</pre></blockquote>

<p>
with <strong>R</strong>=<strong>U</strong>'*<strong>A'</strong>*<strong>U</strong> is the real Schur form of <strong>A</strong>' and <strong>D</strong>=<strong>U</strong>'*<strong>C</strong>*<strong>U</strong> and <strong>Y</strong>=<strong>U</strong>'*<strong>X</strong>*<strong>U</strong>
are the corresponding transformations of <strong>C</strong> and <strong>X</strong>. This problem is solved sequentially for the 1x1 or 2x2 Schur blocks by exploiting the block triangular form of <strong>R</strong>.
Finally the solution of the original problem is recovered as <strong>X</strong>=<strong>U</strong>*<strong>Y</strong>*<strong>U</strong>'.<br>
The Boolean input \"ATisSchur\" indicates to omit the transformation to Schur in the case that <strong>A</strong>' has already Schur form.
</p>

<h4>References</h4>
<blockquote><pre>
[1] Bartels, R.H. and Stewart G.W.
    Algorithm 432: Solution of the matrix equation AX + XB = C.
    Comm. ACM., Vol. 15, pp. 820-826, 1972.
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
A = [1, 2,  3,  4;
     3, 4,  5, -2;
    -1, 2, -3, -5;
     0, 2,  0,  6];

C =  [-2, 3, 1, 0;
      -6, 8, 0, 1;
       2, 3, 4, 5;
      0, -2, 0, 0];

X = continuousLyapunov(A, C);

results in:

X = [1.633, -0.761,  0.575, -0.656;
    -1.158,  1.216,  0.047,  0.343;
    -1.066, -0.052, -0.916,  1.61;
    -2.473,  0.717, -0.986,  1.48]
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.continuousSylvester\">Matrices.continuousSylvester</a>,
<a href=\"modelica://Modelica.Math.Matrices.discreteLyapunov\">Matrices.discreteLyapunov</a>
</p>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end continuousLyapunov;

  function continuousSylvester
    "Return solution X of the continuous-time Sylvester equation A*X + X*B = C"
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices;

    input Real A[:, :] "Square matrix A";
    input Real B[:, :] "Square matrix B";
    input Real C[size(A, 1), size(B, 2)] "Matrix C";
    input Boolean AisSchur=false "= true, if A has already real Schur form";
    input Boolean BisSchur=false "= true, if B has already real Schur form";
    output Real X[size(A, 1), size(B, 2)]
      "Solution of the continuous Sylvester equation";

  protected
    Integer n=size(A, 1);
    Integer m=size(B, 1);
    Real S[size(A, 1), size(A, 2)];
    Real T[size(B, 1), size(B, 2)];
    Real U[size(A, 1), size(A, 1)];
    Real V[size(B, 1), size(B, 1)];
    Real Chat[size(C, 1), size(C, 2)];
    Real scale;
    Integer info;

  algorithm
    if n > 1 and m > 1 then
      if AisSchur then
        S := A;
        U := identity(n);
      else
        (S,U) := Modelica.Math.Matrices.realSchur(A);
      end if;
      if BisSchur then
        T := B;
        V := identity(m);
      else
        (T,V) := Modelica.Math.Matrices.realSchur(B);
      end if;

      Chat := if AisSchur and BisSchur then C else if AisSchur then C*V else
        if BisSchur then transpose(U)*C else transpose(U)*C*V;
      (X,scale,info) := Matrices.LAPACK.dtrsyl(
            S,
            T,
            Chat);
      assert(info == 0, "Solving of Sylvester equation with Matrices.continuousSylvester was not successful.\n
                    The value of info is " + String(info) + ", but should be zero. A value unequal to zero means:\n
            < 0: if INFO = -i, the i-th argument had an illegal value\n
            = 1: A and B have common or very close eigenvalues; perturbed
                 values were used to solve the equation (but the matrices
                 A and B are unchanged).");
      X := if AisSchur and BisSchur then scale*X else if AisSchur then scale*X*
        transpose(V) else if BisSchur then scale*U*X else scale*U*X*transpose(V);
    else
      X := fill(
            0,
            n,
            m);
    end if;

    annotation (Documentation(info="<html>
 <h4>Syntax</h4>
<blockquote><pre>
X = Matrices.<strong>continuousSylvester</strong>(A, B, C);
X = Matrices.<strong>continuousSylvester</strong>(A, B, C, AisSchur, BisSchur);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>continuousSylvester</strong> computes the solution <strong>X</strong> of the continuous-time Sylvester equation
</p>

<blockquote><pre>
<strong>A</strong>*<strong>X</strong> + <strong>X</strong>*<strong>B</strong> = <strong>C</strong>.
</pre></blockquote>

<p>
using the Schur method for Sylvester equations proposed by Bartels and Stewart [1].
</p>

<p>
In a nutshell, the problem is reduced to the corresponding problem
</p>
<blockquote><pre>
<strong>S</strong>*<strong>Y</strong> + <strong>Y</strong>*<strong>T</strong> = <strong>D</strong>.
</pre></blockquote>
<p>
with <strong>S</strong>=<strong>U</strong>'*<strong>A</strong>*<strong>U</strong> is the real Schur of <strong>A</strong>,  <strong>T</strong>=<strong>V</strong>'*<strong>T</strong>*<strong>V</strong> is the real Schur form of <strong>B</strong> and
<strong>D</strong>=<strong>U</strong>'*<strong>C</strong>*<strong>V</strong> and <strong>Y</strong>=<strong>U</strong>*<strong>X</strong>*<strong>V</strong>'
are the corresponding transformations of <strong>C</strong> and <strong>X</strong>. This problem is solved sequentially by exploiting the block triangular form of <strong>S</strong> and <strong>T</strong>.
Finally the solution of the original problem is recovered as <strong>X</strong>=<strong>U</strong>'*<strong>Y</strong>*<strong>V</strong>.<br>
The Boolean inputs \"AisSchur\" and \"BisSchur\" indicate to omit one or both of the transformation to Schur in the case that <strong>A</strong> and/or <strong>B</strong> have already Schur form.
</p>

<p>
The function applies LAPACK-routine DTRSYL. See <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dtrsyl\">LAPACK.dtrsyl</a>
for more information.
</p>

<h4>References</h4>
<blockquote><pre>
[1] Bartels, R.H. and Stewart G.W.
    Algorithm 432: Solution of the matrix equation AX + XB = C.
    Comm. ACM., Vol. 15, pp. 820-826, 1972.
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
A = [17.0,   24.0,   1.0,   8.0,   15.0 ;
     23.0,    5.0,   7.0,  14.0,   16.0 ;
      0.0,    6.0,  13.0,  20.0,   22.0;
      0.0,    0.0,  19.0,  21.0,    3.0 ;
      0.0,    0.0,   0.0,   2.0,    9.0];

B =  [8.0, 1.0, 6.0;
      0.0, 5.0, 7.0;
      0.0, 9.0, 2.0];

C = [62.0,  -12.0, 26.0;
     59.0,  -10.0, 31.0;
     70.0,  -6.0,   9.0;
     35.0,  31.0,  -7.0;
     36.0, -15.0,   7.0];

X = continuousSylvester(A, B, C);

results in:

X = [0.0,  0.0,  1.0;
     1.0,  0.0,  0.0;
     0.0,  1.0,  0.0;
     1.0,  1.0, -1.0;
     2.0, -2.0,  1.0];
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.discreteSylvester\">Matrices.discreteSylvester</a>,
<a href=\"modelica://Modelica.Math.Matrices.continuousLyapunov\">Matrices.continuousLyapunov</a>
</p>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end continuousSylvester;

  function continuousRiccati
    "Return solution X of the continuous-time algebraic Riccati equation A'*X + X*A - X*B*inv(R)*B'*X + Q = 0 (care)"
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices;

    input Real A[:, size(A, 1)] "Square matrix A in CARE";
    input Real B[size(A, 1), :] "Matrix B in CARE";
    input Real R[size(B, 2), size(B, 2)]=identity(size(B, 2))
      "Matrix R in CARE";
    input Real Q[size(A, 1), size(A, 1)]=identity(size(A, 1))
      "Matrix Q in CARE";
    input Boolean refine=false "True for subsequent refinement";

  protected
    Integer n=size(A, 1);
    Real G[size(A, 1), size(A, 1)]=B*Modelica.Math.Matrices.solve2(R, transpose(
        B));
    Real H[2*size(A, 1), 2*size(A, 1)]=[A, -G; -Q, -transpose(A)];
    Real H_RSF[2*size(A, 1), 2*size(A, 1)]=H;
    Real Z[size(H, 1), size(H, 2)];
    Real Z11[size(A, 1), size(A, 2)];
    Real Z21[size(A, 1), size(A, 2)];

    Integer info;

  public
    output Real X[size(A, 1), size(A, 2)] "Stabilizing solution of CARE";
    output Real alphaReal[2*size(A, 1)]
      "Real parts of eigenvalue=alphaReal+i*alphaImag";
    output Real alphaImag[2*size(A, 1)]
      "Imaginary parts of eigenvalue=alphaReal+i*alphaImag";
  algorithm
    if n > 1 then
      (H_RSF,Z,alphaReal,alphaImag) := Modelica.Math.Matrices.realSchur(H);
      (H_RSF,Z,alphaReal,alphaImag) := Matrices.Utilities.reorderRSF(
            H_RSF,
            Z,
            alphaReal,
            alphaImag,
            true);

      Z11 := Z[1:n, 1:n];
      Z21 := Z[n + 1:2*n, 1:n];
      if size(Z11, 1) > 0 then

        (X,info) := Matrices.LAPACK.dgesvx(Z11, transpose(Z21));
        //this function does not need to transpose Z11 as solve2 does with //  X := transpose(Matrices.solve2(transpose(Z11), transpose(Z21)));
        assert(info == 0,
          "Solving a linear system of equations with function \"Matrices.LAPACK.dgesvx\" is not possible, because the system has either no or infinitely many solutions (input A is singular).");
        X := transpose(X);

        if refine then
          X := Modelica.Math.Matrices.Utilities.continuousRiccatiIterative(
                A,
                B,
                R,
                Q,
                X);
        end if;
      else
        X := fill(
              0,
              size(Z21, 1),
              size(Z11, 1));
      end if;

    elseif n == 1 then
      X := matrix((A[1, 1] - sqrt(A[1, 1]*A[1, 1] + G[1, 1]*Q[1, 1]))/G[1, 1]);
      if X[1, 1]*G[1, 1] < A[1, 1] then
        X := matrix((A[1, 1] + sqrt(A[1, 1]*A[1, 1] + G[1, 1]*Q[1, 1]))/G[1, 1]);
      end if;
    else
      X := fill(
            0,
            0,
            0);
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
                        X = Matrices.<strong>continuousRiccati</strong>(A, B, R, Q);
(X, alphaReal, alphaImag) = Matrices.<strong>continuousRiccati</strong>(A, B, R, Q, true);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>continuousRiccati</strong> computes the solution <strong>X</strong> of the continuous-time algebraic Riccati equation
</p>

<blockquote><pre>
<strong>A</strong>'*<strong>X</strong> + <strong>X</strong>*<strong>A</strong> - <strong>X</strong>*<strong>G</strong>*<strong>X</strong> + <strong>Q</strong> = <strong>0</strong>
</pre></blockquote>

<p>
with <code><strong>G</strong> = <strong>B</strong>*inv(<strong>R</strong>)*<strong>B</strong>'</code>
using the Schur vector approach proposed by Laub [1].
</p>

<p>
It is assumed that <strong>Q</strong> is symmetric and positive semidefinite and <strong>R</strong> is symmetric, nonsingular and positive definite,
(<strong>A</strong>,<strong>B</strong>) is stabilizable and (<strong>A</strong>,<strong>Q</strong>) is detectable.
</p>

<p><strong>
These assumptions are not checked in this function !!
</strong><br>
</p>

<p>
The assumptions guarantee that the Hamiltonian matrix
</p>

<blockquote><pre>
<strong>H</strong> = [<strong>A</strong>, -<strong>G</strong>; -<strong>Q</strong>, -<strong>A</strong>']
</pre></blockquote>

<p>
has no pure imaginary eigenvalue and can be put
to an ordered real Schur form
</p>

<blockquote><pre>
<strong>U</strong>'*<strong>H</strong>*<strong>U</strong> = <strong>S</strong> = [<strong>S</strong>11, <strong>S</strong>12; <strong>0</strong>, <strong>S</strong>22]
</pre></blockquote>

<p>
with orthogonal similarity transformation <strong>U</strong>. <strong>S</strong> is ordered in such a way,
that <strong>S</strong>11 contains the n stable eigenvalues of the closed loop system with system matrix
<strong>A</strong> - <strong>B</strong>*inv(<strong>R</strong>)*<strong>B</strong>'*<strong>X</strong>.
If <strong>U</strong> is partitioned to
</p>

<blockquote><pre>
<strong>U</strong> = [<strong>U</strong>11, <strong>U</strong>12; <strong>U</strong>21, <strong>U</strong>22]
</pre></blockquote>

<p>
with dimensions according to <strong>S</strong>, the solution <strong>X</strong> is calculated by
</p>

<blockquote><pre>
<strong>X</strong>*<strong>U</strong>11 = <strong>U</strong>21.
</pre></blockquote>

<p>
With optional input <code>refinement=true</code> a subsequent iterative refinement based on Newton's method with exact line search is applied.
See <a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\">continuousRiccatiIterative</a>
for more information.
</p>

<h4>References</h4>
<blockquote><pre>
[1] Laub, A.J.
    A Schur Method for Solving Algebraic Riccati equations.
    IEEE Trans. Auto. Contr., AC-24, pp. 913-921, 1979.
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
A = [0.0, 1.0;
     0.0, 0.0];

B = [0.0;
     1.0];

R = [1];

Q = [1.0, 0.0;
     0.0, 2.0];

X = continuousRiccati(A, B, R, Q);

results in:

X = [2.0, 1.0;
     1.0, 2.0];
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\">Matrices.Utilities.continuousRiccatiIterative</a>,
<a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">Matrices.discreteRiccati</a>
</p>

</html>", revisions="<html><ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end continuousRiccati;

  function discreteLyapunov
    "Return solution X of the discrete-time Lyapunov equation A'*X*A + sgn*X = C"
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices;

    input Real A[:, size(A, 1)] "Square matrix A in A'*X*A + sgn*X = C";
    input Real C[size(A, 1), size(A, 2)]
      "Square matrix C in A'*X*A + sgn*X = C";
    input Boolean ATisSchur=false
      "= true, if transpose(A) has already real Schur form";
    input Integer sgn=1 "Specifies the sign in A'*X*A + sgn*X = C";
    input Real eps=Matrices.norm(A, 1)*10*Modelica.Constants.eps
      "Tolerance eps";

  protected
    Integer n=size(A, 1);
    Real R[size(A, 1), size(A, 2)] "RSF of A', i.e., R=U'A'U";
    Real U[size(A, 1), size(A, 2)] "Transformation matrix U for R=U'A'U";
    Real D[size(A, 1), size(A, 2)] "Matrix D=U'*C*U";
    Real R22[size(A, 1), size(A, 2)];
    Real R11[size(A, 1), size(A, 2)];
    Integer k;

    Real g[size(A, 1)];
    Real w[size(A, 1)];
    Real y[2*size(A, 1)];
    Boolean crit;

  public
    output Real X[size(A, 1), size(A, 2)]
      "Solution X of the Lyapunov equation A'*X*A + sgn*X = C";

  algorithm
    assert(sgn == 1 or sgn == -1,
      "Input sgn in function Math.Matrices.discreteLyapunov() must be 1 or -1, however it is "
       + String(sgn));
    X := zeros(n, n);
    k := n;
    if n > 1 then
      if ATisSchur then
        R := transpose(A);
        U := identity(n);
        D := C;
      else
        (R,U) := Modelica.Math.Matrices.realSchur(transpose(A));
        D := transpose(U)*C*U;
      end if;

      while k > 0 loop
        w := D[:, k] - R*X[:, k + 1:n]*R[k, k + 1:n];
        crit := if k > 1 then abs(R[k, k - 1]) < eps else false;
        if (k == 1 or crit) then
          R22 := R[k, k]*R;
          for i in 1:n loop
            R22[i, i] := R22[i, i] + sgn;
          end for;
          X[:, k] := Matrices.solve(R22, w);
          k := k - 1;
        else
          g := D[:, k - 1] - R*X[:, k + 1:n]*R[k - 1, k + 1:n];
          R11 := R[k - 1, k - 1]*R;
          R22 := R[k, k]*R;
          for i in 1:n loop
            R11[i, i] := R11[i, i] + sgn;
            R22[i, i] := R22[i, i] + sgn;
          end for;
          y := Matrices.solve([R11, R[k - 1, k]*R; R[k, k - 1]*R, R22], cat(
                1,
                g,
                w));
          X[:, k - 1] := y[1:n];
          X[:, k] := y[n + 1:2*n];
          k := k - 2;
        end if;
      end while;

      // transform X corresponding to the original form
      if not ATisSchur then
        X := U*X*transpose(U);
      end if;

    elseif n == 1 then
      X[1, 1] := C[1, 1]/(A[1, 1]*A[1, 1] + sgn);
    else
      X := fill(
            0,
            0,
            0);
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
X = Matrices.<strong>discreteLyapunov</strong>(A, C);
X = Matrices.<strong>discreteLyapunov</strong>(A, C, ATisSchur, sgn, eps);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the solution <strong>X</strong> of the discrete-time Lyapunov equation
</p>

<blockquote><pre>
<strong>A</strong>'*<strong>X</strong>*<strong>A</strong> + sgn*<strong>X</strong> = <strong>C</strong>
</pre></blockquote>

<p>
where sgn=1 or sgn =-1. For sgn = -1, the discrete Lyapunov equation is a special case of the Stein equation:
</p>

<blockquote><pre>
<strong>A</strong>*<strong>X</strong>*<strong>B</strong> - <strong>X</strong> + <strong>Q</strong> = <strong>0</strong>.
</pre></blockquote>

<p>
The algorithm uses the Schur method for Lyapunov equations proposed by Bartels and Stewart [1].
</p>

<p>
In a nutshell, the problem is reduced to the corresponding problem
</p>

<blockquote><pre>
<strong>R</strong>*<strong>Y</strong>*<strong>R</strong>' + sgn*<strong>Y</strong> = <strong>D</strong>.
</pre></blockquote>

<p>
with <strong>R</strong>=<strong>U</strong>'*<strong>A'</strong>*<strong>U</strong> is the real Schur form of <strong>A</strong>' and <strong>D</strong>=<strong>U</strong>'*<strong>C</strong>*<strong>U</strong> and <strong>Y</strong>=<strong>U</strong>'*<strong>X</strong>*<strong>U</strong>
are the corresponding transformations of <strong>C</strong> and <strong>X</strong>. This problem is solved sequentially by exploiting the block triangular form of <strong>R</strong>.
Finally the solution of the original problem is recovered as <strong>X</strong>=<strong>U</strong>*<strong>Y</strong>*<strong>U</strong>'.<br>
The Boolean input \"ATisSchur\" indicates to omit the transformation to Schur in the case that <strong>A</strong>' has already Schur form.
</p>

<h4>References</h4>
<blockquote><pre>
[1] Bartels, R.H. and Stewart G.W.
    Algorithm 432: Solution of the matrix equation AX + XB = C.
    Comm. ACM., Vol. 15, pp. 820-826, 1972.
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
A = [1, 2,  3,  4;
     3, 4,  5, -2;
    -1, 2, -3, -5;
     0, 2,  0,  6];

C =  [-2,  3, 1, 0;
      -6,  8, 0, 1;
       2,  3, 4, 5;
       0, -2, 0, 0];

X = discreteLyapunov(A, C, sgn=-1);

results in:

X  = [7.5735,   -3.1426,  2.7205, -2.5958;
     -2.6105,    1.2384, -0.9232,  0.9632;
      6.6090,   -2.6775,  2.6415, -2.6928;
     -0.3572,    0.2298,  0.0533, -0.27410];

</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.discreteSylvester\">Matrices.discreteSylvester</a>,
<a href=\"modelica://Modelica.Math.Matrices.continuousLyapunov\">Matrices.continuousLyapunov</a>
</p>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end discreteLyapunov;

  function discreteSylvester
    "Return solution of the discrete-time Sylvester equation A*X*B + sgn*X = C"
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices;

    input Real A[:, size(A, 1)] "Square matrix A in A*X*B + sgn*X = C";
    input Real B[:, size(B, 1)] "Square matrix B in A*X*B + sgn*X = C";
    input Real C[size(A, 2), size(B, 1)]
      "Rectangular matrix C in A*X*B + sgn*X = C";
    input Boolean AisHess=false "= true, if A has already Hessenberg form";
    input Boolean BTisSchur=false "= true, if B' has already real Schur form";
    input Integer sgn=1 "Specifies the sign in A*X*B + sgn*X = C";
    input Real eps=Matrices.norm(A, 1)*10*Modelica.Constants.eps "Tolerance";

  protected
    Integer n=size(A, 1);
    Integer m=size(B, 1);
    Real H[size(A, 1), size(A, 1)] "Hessenberg form of A, i.e., H=U'AU";
    Real U[size(A, 1), size(A, 1)] "Transformation matrix U for H=U'AU";
    Real S[size(B, 1), size(B, 1)] "RSF form of B, i.e., S=Z'BZ";
    Real Z[size(B, 1), size(B, 1)] "Transformation matrix Z for S=Z'BZ";
    Real F[size(A, 1), size(B, 1)]
      "Appropriate transformation of the right side C, F=U'*C*Z";

    Real R22[size(A, 1), size(A, 1)];
    Real R11[size(A, 1), size(A, 1)];
    Integer k;

    Real w[size(A, 1)];
    Real g[size(A, 1)];
    Real y[2*size(A, 1)];
    Boolean crit;

  public
    output Real X[size(A, 2), size(B, 1)]
      "solution of the discrete Sylvester equation A*X*B + sgn*X = C";

  algorithm
    assert(sgn == 1 or sgn == -1,
      "Input sgn in function Math.Matrices.discreteLyapunov() must be 1 or -1, however it is "
       + String(sgn));
    X := zeros(n, m);
    k := m;

    if n > 1 and m > 1 then
      if AisHess then
        H := A;
        U := identity(n);
        if BTisSchur then
          S := B;
          Z := identity(m);
          F := C;
        else
          (S,Z) := Matrices.realSchur(transpose(B));
          S := transpose(S);
          F := C*Z;
        end if;
      else
        (H,U) := Matrices.hessenberg(A);
        if BTisSchur then
          S := B;
          Z := identity(m);
          F := transpose(U)*C;
        else
          (S,Z) := Matrices.realSchur(transpose(B));
          S := transpose(S);
          F := transpose(U)*C*Z;
        end if;
      end if;

      while k > 0 loop

        w := F[:, k] - H*X[:, k + 1:m]*S[k + 1:m, k];
        crit := if k > 1 then abs(S[k - 1, k]) < eps else false;

        if (k == 1 or crit) then
          //real eigenvalue in Schur form
          R22 := S[k, k]*H;
          for i in 1:n loop
            R22[i, i] := R22[i, i] + sgn;
          end for;
          X[:, k] := Matrices.solve(R22, w);
          // solve one column in X for one real eigenvalue
          k := k - 1;
        else
          // pair of complex eigenvalues, i.e., 2x2 Schur bump
          g := F[:, k - 1] - H*X[:, k + 1:m]*S[k + 1:m, k - 1];
          R22 := S[k, k]*H;
          R11 := S[k - 1, k - 1]*H;
          for i in 1:n loop
            R11[i, i] := R11[i, i] + sgn;
            R22[i, i] := R22[i, i] + sgn;
          end for;
          y := Matrices.solve([R11, S[k, k - 1]*H; S[k - 1, k]*H, R22], cat(
                1,
                g,
                w));
          // solve two columns in X for one conjugated complex pole pair
          X[:, k - 1] := y[1:n];
          X[:, k] := y[n + 1:2*n];
          k := k - 2;
        end if;
      end while;

      // transform X corresponding to the original form
      if not (AisHess and BTisSchur) then
        X := if AisHess then X*transpose(Z) else if BTisSchur then U*X else U*X
          *transpose(Z);
      end if;

    elseif n == 1 and m == 1 then
      // simple scalar equation
      X[1, 1] := C[1, 1]/(A[1, 1]*B[1, 1] + sgn);
    else
      X := fill(
            0,
            0,
            0);
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
X = Matrices.<strong>discreteSylvester</strong>(A, B, C);
X = Matrices.<strong>discreteSylvester</strong>(A, B, C, AisHess, BTisSchur, sgn, eps);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>discreteSylvester</strong> computes the solution <strong>X</strong> of the discrete-time Sylvester equation
</p>

<blockquote><pre>
<strong>A</strong>*<strong>X</strong>*<strong>B</strong> + sgn*<strong>X</strong> = <strong>C</strong>.
</pre></blockquote>

<p>
where sgn = 1 or sgn = -1. The algorithm applies the Hessenberg-Schur method proposed by Golub et al [1].
For sgn = -1, the discrete Sylvester equation is also known as Stein equation:
</p>

<blockquote><pre>
<strong>A</strong>*<strong>X</strong>*<strong>B</strong> - <strong>X</strong> + <strong>Q</strong> = <strong>0</strong>.
</pre></blockquote>

<p>
In a nutshell, the problem is reduced to the corresponding problem
</p>
<blockquote><pre>
<strong>H</strong>*<strong>Y</strong>*<strong>S</strong>' + sgn*<strong>Y</strong> = <strong>F</strong>.
</pre></blockquote>

<p>
with <strong>H</strong>=<strong>U</strong>'*<strong>A</strong>*<strong>U</strong> is the Hessenberg form of <strong>A</strong> and <strong>S</strong>=<strong>V</strong>'*<strong>B</strong>'*<strong>V</strong> is the real Schur form of <strong>B</strong>',
<strong>F</strong>=<strong>U</strong>'*<strong>C</strong>*<strong>V</strong> and <strong>Y</strong>=<strong>U</strong>*<strong>X</strong>*<strong>V</strong>'
are appropriate transformations of <strong>C</strong> and <strong>X</strong>. This problem is solved sequentially by exploiting the specific forms of <strong>S</strong> and <strong>H</strong>.
Finally the solution of the original problem is recovered as <strong>X</strong>=<strong>U</strong>'*<strong>Y</strong>*<strong>V</strong>.<br>
The Boolean inputs \"AisHess\" and \"BTisSchur\" indicate to omit one or both of the transformation to Hessenberg form or Schur form respectively in the case that <strong>A</strong> and/or <strong>B</strong> have already Hessenberg form or Schur respectively.
</p>

<h4>References</h4>
<blockquote><pre>
[1] Golub, G.H., Nash, S. and Van Loan, C.F.
    A Hessenberg-Schur method for the problem AX + XB = C.
    IEEE Transaction on Automatic Control, AC-24, no. 6, pp. 909-913, 1979.
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
A = [1.0,   2.0,   3.0;
     6.0,   7.0,   8.0;
     9.0,   2.0,   3.0];

B = [7.0,   2.0,   3.0;
     2.0,   1.0,   2.0;
     3.0,   4.0,   1.0];

C = [271.0,   135.0,   147.0;
     923.0,   494.0,   482.0;
     578.0,   383.0,   287.0];

X = discreteSylvester(A, B, C);

results in:
X = [2.0,   3.0,   6.0;
     4.0,   7.0,   1.0;
     5.0,   3.0,   2.0];

</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.continuousSylvester\">Matrices.continuousSylvester</a>,
<a href=\"modelica://Modelica.Math.Matrices.discreteLyapunov\">Matrices.discreteLyapunov</a>
</p>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end discreteSylvester;

  function discreteRiccati
    "Return solution of discrete-time algebraic Riccati equation A'*X*A - X - A'*X*B*inv(R + B'*X*B)*B'*X*A + Q = 0 (dare)"
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices;
    input Real A[:, size(A, 1)] "Square matrix A in DARE";
    input Real B[size(A, 1), :] "Matrix B in DARE";
    input Real R[size(B, 2), size(B, 2)]=identity(size(B, 2))
      "Matrix R in DARE";
    input Real Q[size(A, 1), size(A, 1)]=identity(size(A, 1))
      "Matrix Q in DARE";
    input Boolean refine=false "True for subsequent refinement";

  protected
    Integer n=size(A, 1);
    Real G[size(A, 1), size(A, 1)]=B*Matrices.solve2(R, transpose(B));
    Real AT[size(A, 1), size(A, 1)]=transpose(A);
    Real LU[size(A, 1), size(A, 1)];
    Integer p[size(A, 1)];
    Real H[2*size(A, 1), 2*size(A, 1)];
    Real H11[size(A, 1), size(A, 1)];
    Real H12[size(A, 1), size(A, 1)];
    Real H21[size(A, 1), size(A, 1)];
    Real H22[size(A, 1), size(A, 1)];
    Real H_RSF[2*size(A, 1), 2*size(A, 1)];
    Real Z[size(H, 1), size(H, 2)];
    Real Z11[size(A, 1), size(A, 2)];
    Real Z21[size(A, 1), size(A, 2)];

    Integer info;

  public
    output Real X[size(A, 1), size(A, 2)]
      "orthogonal matrix of the Schur vectors associated to ordered rsf";
    output Real alphaReal[2*size(A, 1)]
      "Real part of eigenvalue=alphaReal+i*alphaImag";
    output Real alphaImag[2*size(A, 1)]
      "Imaginary part of eigenvalue=alphaReal+i*alphaImag";
  algorithm
    (LU,p) := Modelica.Math.Matrices.LU(AT);
    H21 := Modelica.Math.Matrices.LU_solve2(
          LU,
          p,
          -Q);
    H22 := Modelica.Math.Matrices.LU_solve2(
          LU,
          p,
          identity(n));
    (LU,p) := Modelica.Math.Matrices.LU(A);
    H12 := Modelica.Math.Matrices.LU_solve2(
          LU,
          p,
          -G);
    H12 := transpose(H12);
    H11 := A - H12*Q;
    H := [H11, H12; H21, H22];
    (H_RSF,Z,alphaReal,alphaImag) := Modelica.Math.Matrices.realSchur(H);
    // put H to Schur form
    (H_RSF,Z,alphaReal,alphaImag) := Matrices.Utilities.reorderRSF(
          H_RSF,
          Z,
          alphaReal,
          alphaImag,
          false);
    // ordered Schur form
    Z11 := Z[1:n, 1:n];
    Z21 := Z[n + 1:2*n, 1:n];
    if size(Z11, 1) > 0 then
      //  X := transpose(Matrices.solve2(transpose(Z11), transpose(Z21)));
      (X,info) := Matrices.LAPACK.dgesvx(Z11, transpose(Z21));
      //function does not need to transpose Z11 as solve2 does
      X := transpose(X);
      assert(info == 0, "Solving a linear system of equations with function
\"Matrices.LAPACK.dgesvx\" is not possible, because the system has either
no or infinitely many solutions (input A is singular).");

      if refine then
        X := Modelica.Math.Matrices.Utilities.discreteRiccatiIterative(
              A,
              B,
              R,
              Q,
              X);
      end if;
    else
      X := fill(
            0,
            size(Z21, 1),
            size(Z11, 1));
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
                        X = Matrices.<strong>discreteRiccati</strong>(A, B, R, Q);
(X, alphaReal, alphaImag) = Matrices.<strong>discreteRiccati</strong>(A, B, R, Q, true);
</pre></blockquote>

<h4>Description</h4>

<p>
Function <strong>discreteRiccati</strong> computes the solution <strong>X</strong> of the discrete-time algebraic Riccati equation
</p>

<blockquote><pre>
<strong>A</strong>'*<strong>X</strong>*<strong>A</strong> - <strong>X</strong> - <strong>A</strong>'*<strong>X</strong>*<strong>B</strong>*inv(<strong>R</strong> + <strong>B</strong>'*<strong>X</strong>*<strong>B</strong>)*<strong>B</strong>'*<strong>X</strong>*<strong>A</strong> + <strong>Q</strong> = <strong>0</strong>
</pre></blockquote>

<p>
using the Schur vector approach proposed by Laub [1].
</p>

<p>
It is assumed that <strong>Q</strong> is symmetric and positive semidefinite and <strong>R</strong> is symmetric, nonsingular and positive definite,
(<strong>A</strong>,<strong>B</strong>) is stabilizable and (<strong>A</strong>,<strong>Q</strong>) is detectable. Using this method, <strong>A</strong> has also to be invertible.
</p>

<p>
<strong>These assumptions are not checked in this function !!!</strong>
</p>

<p>
The assumptions guarantee that the Hamiltonian matrix.
</p>
<blockquote><pre>
<strong>H</strong> = [<strong>A</strong> + <strong>G</strong>*<strong>T</strong>*<strong>Q</strong>, -<strong>G</strong>*<strong>T</strong>; -<strong>T</strong>*<strong>Q</strong>, <strong>T</strong>]
</pre></blockquote>
<p>
with
</p>
<blockquote><pre>
     -T
<strong>T</strong> = <strong>A</strong>
</pre></blockquote>

<p>
and
</p>

<blockquote><pre>
       -1
<strong>G</strong> = <strong>B</strong>*<strong>R</strong> *<strong>B</strong>'
</pre></blockquote>

<p>
has no eigenvalue on the unit circle and can be put
to an ordered real Schur form
</p>

<blockquote><pre>
<strong>U</strong>'*<strong>H</strong>*<strong>U</strong> = <strong>S</strong> = [<strong>S11</strong>, <strong>S12</strong>; <strong>0</strong>, <strong>S22</strong>]
</pre></blockquote>

<p>
with orthogonal similarity transformation <strong>U</strong>. <strong>S</strong> is ordered in such a way,
that <strong>S11</strong> contains the n stable eigenvalues of the closed loop system with system matrix
</p>

<blockquote><pre>
                  -1
<strong>A</strong> - <strong>B</strong>*(<strong>R</strong> + <strong>B</strong>'*<strong>X</strong>*<strong>B</strong>)  *<strong>B</strong>'*<strong>X</strong>*<strong>A</strong>
</pre></blockquote>

<p>
If <strong>U</strong> is partitioned to
</p>

<blockquote><pre>
<strong>U</strong> = [<strong>U11</strong>, <strong>U12</strong>; <strong>U21</strong>, <strong>U22</strong>]
</pre></blockquote>

<p>
according to <strong>S</strong>, the solution <strong>X</strong> can be calculated by
</p>

<blockquote><pre>
<strong>X</strong>*<strong>U11</strong> = <strong>U21</strong>.
</pre></blockquote>

<h4>References</h4>
<blockquote><pre>
[1] Laub, A.J.
    A Schur Method for Solving Algebraic Riccati equations.
    IEEE Trans. Auto. Contr., AC-24, pp. 913-921, 1979.
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
A  = [4.0    3.0]
     -4.5,  -3.5];

B  = [ 1.0;
      -1.0];

R = [1.0];

Q = [9.0, 6.0;
     6.0, 4.0]

X = discreteRiccati(A, B, R, Q);

  results in:

X = [14.5623, 9.7082;
      9.7082, 6.4721];
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">Matrices.continuousRiccati</a>
</p>
</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end discreteRiccati;

  function sort
    "Sort the rows or columns of a matrix in ascending or descending order"
    extends Modelica.Icons.Function;
    input Real M[:, :] "Matrix to be sorted";
    input Boolean sortRows=true "= true, if rows are sorted, otherwise columns";
    input Boolean ascending=true
      "= true, if ascending order, otherwise descending order";
    output Real sorted_M[size(M, 1), size(M, 2)]=M "Sorted matrix";
    output Integer indices[if sortRows then size(M, 1) else size(M, 2)]
      "sorted_M = if sortRows then M[indices,:] else M[:,indices]";

    /* shellsort algorithm; should be improved later */
  protected
    Integer gap;
    Integer i;
    Integer j;
    Real wM2[size(M, 2)];
    Integer wi;
    Integer nM1=size(M, 1);
    Boolean swap;
    Real sorted_MT[size(M, 2), size(M, 1)];

    encapsulated function greater "Compare whether vector v1 > v2"
      import Modelica;
      extends Modelica.Icons.Function;
      import Modelica.Utilities.Types.Compare;
      input Real v1[:];
      input Real v2[size(v1, 1)];
      output Boolean result;
    protected
      Integer n=size(v1, 1);
      Integer i=1;
    algorithm
      result := false;
      while i <= n loop
        if v1[i] > v2[i] then
          result := true;
          i := n;
        elseif v1[i] < v2[i] then
          i := n;
        end if;
        i := i + 1;
      end while;
    end greater;

    encapsulated function less "Compare whether vector v1 < v2"
      import Modelica;
      extends Modelica.Icons.Function;
      import Modelica.Utilities.Types.Compare;
      input Real v1[:];
      input Real v2[size(v1, 1)];
      output Boolean result;
    protected
      Integer n=size(v1, 1);
      Integer i=1;
    algorithm
      result := false;
      while i <= n loop
        if v1[i] < v2[i] then
          result := true;
          i := n;
        elseif v1[i] > v2[i] then
          i := n;
        end if;
        i := i + 1;
      end while;
    end less;
  algorithm
    if not sortRows then
      (sorted_MT,indices) := sort(transpose(M), ascending=ascending);
      sorted_M := transpose(sorted_MT);
    else
      indices := 1:size(M, 1);
      gap := div(nM1, 2);
      while gap > 0 loop
        i := gap;
        while i < nM1 loop
          j := i - gap;
          if j >= 0 then
            if ascending then
              swap := greater(sorted_M[j + 1, :], sorted_M[j + gap + 1, :]);
            else
              swap := less(sorted_M[j + 1, :], sorted_M[j + gap + 1, :]);
            end if;
          else
            swap := false;
          end if;

          while swap loop
            wM2 := sorted_M[j + 1, :];
            wi := indices[j + 1];
            sorted_M[j + 1, :] := sorted_M[j + gap + 1, :];
            sorted_M[j + gap + 1, :] := wM2;
            indices[j + 1] := indices[j + gap + 1];
            indices[j + gap + 1] := wi;
            j := j - gap;
            if j >= 0 then
              if ascending then
                swap := greater(sorted_M[j + 1, :], sorted_M[j + gap + 1, :]);
              else
                swap := less(sorted_M[j + 1, :], sorted_M[j + gap + 1, :]);
              end if;
            else
              swap := false;
            end if;
          end while;
          i := i + 1;
        end while;
        gap := div(gap, 2);
      end while;
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
           sorted_M = Matrices.<strong>sort</strong>(M);
(sorted_M, indices) = Matrices.<strong>sort</strong>(M, sortRows=true, ascending=true);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>sort</strong>(..) sorts the rows of a Real matrix M
in ascending order and returns the result in sorted_M.
If the optional argument \"sortRows\" is <strong>false</strong>, the columns
of the matrix are sorted.
If the optional argument \"ascending\" is <strong>false</strong>, the rows or
columns are sorted in descending order. In the optional second
output argument, the indices of the sorted rows or columns with respect
to the original matrix are given, such that
</p>

<blockquote><pre>
sorted_M = <strong>if</strong> sortedRow <strong>then</strong> M[indices,:] <strong>else</strong> M[:,indices];
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
(M2, i2) := Matrices.sort([2, 1,  0;
                           2, 0, -1]);
     -> M2 = [2, 0, -1;
              2, 1, 0 ];
        i2 = {2,1};
</pre></blockquote>
</html>"));
  end sort;

  function flipLeftRight "Flip the columns of a matrix in left/right direction"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix to be flipped";
    output Real Aflip[size(A, 1), size(A, 2)] "Flipped matrix";
  algorithm
    Aflip := A[:, {i for i in size(A, 2):-1:1}];

    annotation (Inline=true, Documentation(info="<html>
 <h4>Syntax</h4>
<blockquote><pre>
A_flr = Matrices.<strong>flipLeftRight</strong>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>flipLeftRight</strong> computes from matrix <strong>A</strong> a matrix <strong>A_flr</strong> with flipped columns, i.e., <strong>A_flr</strong>[:,i]=<strong>A</strong>[:,n-i+1], i=1,..., n.
</p>

<h4>Example</h4>
<blockquote><pre>
A = [1, 2,  3;
     3, 4,  5;
    -1, 2, -3];

A_flr = flipLeftRight(A);

results in:

A_flr = [3, 2,  1;
         5, 4,  3;
        -3, 2, -1]
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.flipUpDown\">Matrices.flipUpDown</a>
</p>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end flipLeftRight;

  function flipUpDown "Flip the rows of a matrix in up/down direction"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix to be flipped";
    output Real Aflip[size(A, 1), size(A, 2)] "Flipped matrix";
  algorithm
    Aflip := A[{i for i in size(A, 1):-1:1}, :];

    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
A_fud = Matrices.<strong>flipUpDown</strong>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>flipUpDown</strong> computes from matrix <strong>A</strong> a matrix <strong>A_fud</strong> with flipped rows, i.e., <strong>A_fud</strong>[i,:]=<strong>A</strong>[n-i+1,:], i=1,..., n.
</p>

<h4>Example</h4>
<blockquote><pre>
A = [1, 2,  3;
     3, 4,  5;
    -1, 2, -3];

A_fud = flipUpDown(A);

results in:

A_fud  = [-1, 2, -3;
           3, 4,  5;
           1, 2,  3]
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.flipLeftRight\">Matrices.flipLeftRight</a>
</p>

</html>", revisions="<html>
<ul>
<li><em>2010/05/31 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end flipUpDown;

  package LAPACK
    "Interface to LAPACK library (should usually not directly be used but only indirectly via Modelica.Math.Matrices)"
    extends Modelica.Icons.FunctionsPackage;

    pure function dgeev
      "Compute eigenvalues and (right) eigenvectors for real nonsymmetric matrix A"

      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      output Real eigenReal[size(A, 1)] "Real part of eigen values";
      output Real eigenImag[size(A, 1)] "Imaginary part of eigen values";
      output Real eigenVectors[size(A, 1), size(A, 1)] "Right eigen vectors";
      output Integer info;
    protected
      Real dummy[1,1];
      Integer n=size(A, 1);
      Integer lwork=12*n;
      Integer ldvl=1;
      Real Awork[size(A, 1), size(A, 1)]=A;
      Real work[12*size(A, 1)];

    external"FORTRAN 77" dgeev(
              "N",
              "V",
              n,
              Awork,
              n,
              eigenReal,
              eigenImag,
              dummy,
              ldvl,
              eigenVectors,
              n,
              work,
              lwork,
              info) annotation (Library="lapack");
      annotation (Documentation(info="This function is not a full interface to the LAPACK function DGEEV,
but calls it in such a way that only eigenvalues and right eigenvectors
are computed.

Lapack documentation
    Purpose
    =======

    DGEEV computes for an N-by-N real nonsymmetric matrix A, the
    eigenvalues and, optionally, the left and/or right eigenvectors.

    The right eigenvector v(j) of A satisfies
                     A * v(j) = lambda(j) * v(j)
    where lambda(j) is its eigenvalue.
    The left eigenvector u(j) of A satisfies
                  u(j)**H * A = lambda(j) * u(j)**H
    where u(j)**H denotes the conjugate transpose of u(j).

    The computed eigenvectors are normalized to have Euclidean norm
    equal to 1 and largest component real.

    Arguments
    =========

    JOBVL   (input) CHARACTER*1
            = 'N': left eigenvectors of A are not computed;
            = 'V': left eigenvectors of A are computed.

    JOBVR   (input) CHARACTER*1
            = 'N': right eigenvectors of A are not computed;
            = 'V': right eigenvectors of A are computed.

    N       (input) INTEGER
            The order of the matrix A. N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the N-by-N matrix A.
            On exit, A has been overwritten.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    WR      (output) DOUBLE PRECISION array, dimension (N)
    WI      (output) DOUBLE PRECISION array, dimension (N)
            WR and WI contain the real and imaginary parts,
            respectively, of the computed eigenvalues.  Complex
            conjugate pairs of eigenvalues appear consecutively
            with the eigenvalue having the positive imaginary part
            first.

    VL      (output) DOUBLE PRECISION array, dimension (LDVL,N)
            If JOBVL = 'V', the left eigenvectors u(j) are stored one
            after another in the columns of VL, in the same order
            as their eigenvalues.
            If JOBVL = 'N', VL is not referenced.
            If the j-th eigenvalue is real, then u(j) = VL(:,j),
            the j-th column of VL.
            If the j-th and (j+1)-st eigenvalues form a complex
            conjugate pair, then u(j) = VL(:,j) + i*VL(:,j+1) and
            u(j+1) = VL(:,j) - i*VL(:,j+1).

    LDVL    (input) INTEGER
            The leading dimension of the array VL.  LDVL >= 1; if
            JOBVL = 'V', LDVL >= N.

    VR      (output) DOUBLE PRECISION array, dimension (LDVR,N)
            If JOBVR = 'V', the right eigenvectors v(j) are stored one
            after another in the columns of VR, in the same order
            as their eigenvalues.
            If JOBVR = 'N', VR is not referenced.
            If the j-th eigenvalue is real, then v(j) = VR(:,j),
            the j-th column of VR.
            If the j-th and (j+1)-st eigenvalues form a complex
            conjugate pair, then v(j) = VR(:,j) + i*VR(:,j+1) and
            v(j+1) = VR(:,j) - i*VR(:,j+1).

    LDVR    (input) INTEGER
            The leading dimension of the array VR.  LDVR >= 1; if
            JOBVR = 'V', LDVR >= N.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.  LWORK >= max(1,3*N), and
            if JOBVL = 'V' or JOBVR = 'V', LWORK >= 4*N.  For good
            performance, LWORK must generally be larger.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            > 0:  if INFO = i, the QR algorithm failed to compute all the
                  eigenvalues, and no eigenvectors have been computed;
                  elements i+1:N of WR and WI contain eigenvalues which
                  have converged.
"));
    end dgeev;

    pure function dgeev_eigenValues
      "Compute eigenvalues for real nonsymmetric matrix A"

      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      output Real EigenReal[size(A, 1)];
      output Real EigenImag[size(A, 1)];

      /*
      output Real Eigenvectors[size(A, 1), size(A, 1)]=zeros(size(A, 1), size(
          A, 1)); */
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lwork=8*n;
      Real Awork[size(A, 1), size(A, 1)]=A;
      Real work[8*size(A, 1)];
      Real EigenvectorsL[size(A, 1), size(A, 1)]=zeros(size(A, 1), size(A, 1));

      /*
    external "FORTRAN 77" dgeev("N", "V", n, Awork, n,
        EigenReal, EigenImag, EigenvectorsL, n,
        Eigenvectors, n, work, lwork, info)
*/
    external"FORTRAN 77" dgeev(
              "N",
              "N",
              n,
              Awork,
              n,
              EigenReal,
              EigenImag,
              EigenvectorsL,
              n,
              EigenvectorsL,
              n,
              work,
              lwork,
              info) annotation (Library="lapack");

      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGEEV computes for an N-by-N real nonsymmetric matrix A, the
    eigenvalues and, optionally, the left and/or right eigenvectors.

    The right eigenvector v(j) of A satisfies
                     A * v(j) = lambda(j) * v(j)
    where lambda(j) is its eigenvalue.
    The left eigenvector u(j) of A satisfies
                  u(j)**H * A = lambda(j) * u(j)**H
    where u(j)**H denotes the conjugate transpose of u(j).

    The computed eigenvectors are normalized to have Euclidean norm
    equal to 1 and largest component real.

    Arguments
    =========

    JOBVL   (input) CHARACTER*1
            = 'N': left eigenvectors of A are not computed;
            = 'V': left eigenvectors of A are computed.

    JOBVR   (input) CHARACTER*1
            = 'N': right eigenvectors of A are not computed;
            = 'V': right eigenvectors of A are computed.

    N       (input) INTEGER
            The order of the matrix A. N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the N-by-N matrix A.
            On exit, A has been overwritten.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    WR      (output) DOUBLE PRECISION array, dimension (N)
    WI      (output) DOUBLE PRECISION array, dimension (N)
            WR and WI contain the real and imaginary parts,
            respectively, of the computed eigenvalues.  Complex
            conjugate pairs of eigenvalues appear consecutively
            with the eigenvalue having the positive imaginary part
            first.

    VL      (output) DOUBLE PRECISION array, dimension (LDVL,N)
            If JOBVL = 'V', the left eigenvectors u(j) are stored one
            after another in the columns of VL, in the same order
            as their eigenvalues.
            If JOBVL = 'N', VL is not referenced.
            If the j-th eigenvalue is real, then u(j) = VL(:,j),
            the j-th column of VL.
            If the j-th and (j+1)-st eigenvalues form a complex
            conjugate pair, then u(j) = VL(:,j) + i*VL(:,j+1) and
            u(j+1) = VL(:,j) - i*VL(:,j+1).

    LDVL    (input) INTEGER
            The leading dimension of the array VL.  LDVL >= 1; if
            JOBVL = 'V', LDVL >= N.

    VR      (output) DOUBLE PRECISION array, dimension (LDVR,N)
            If JOBVR = 'V', the right eigenvectors v(j) are stored one
            after another in the columns of VR, in the same order
            as their eigenvalues.
            If JOBVR = 'N', VR is not referenced.
            If the j-th eigenvalue is real, then v(j) = VR(:,j),
            the j-th column of VR.
            If the j-th and (j+1)-st eigenvalues form a complex
            conjugate pair, then v(j) = VR(:,j) + i*VR(:,j+1) and
            v(j+1) = VR(:,j) - i*VR(:,j+1).

    LDVR    (input) INTEGER
            The leading dimension of the array VR.  LDVR >= 1; if
            JOBVR = 'V', LDVR >= N.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.  LWORK >= max(1,3*N), and
            if JOBVL = 'V' or JOBVR = 'V', LWORK >= 4*N.  For good
            performance, LWORK must generally be larger.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            > 0:  if INFO = i, the QR algorithm failed to compute all the
                  eigenvalues, and no eigenvectors have been computed;
                  elements i+1:N of WR and WI contain eigenvalues which
                  have converged.
"));
    end dgeev_eigenValues;

    pure function dgelsy
      "Compute the minimum-norm solution to a real linear least squares problem with rank deficient A"

      extends Modelica.Icons.Function;
      input Real A[:, :];
      input Real B[size(A, 1), :];
      input Real rcond=0.0 "Reciprocal condition number to estimate rank";
      output Real X[max(size(A, 1), size(A, 2)), size(B, 2)]=cat(
                1,
                B,
                zeros(max(nrow, ncol) - nrow, nrhs))
        "Solution is in first size(A,2) rows";
      output Integer info;
      output Integer rank "Effective rank of A";
    protected
      Integer nrow=size(A, 1);
      Integer ncol=size(A, 2);
      Integer nx=max(nrow, ncol);
      Integer nrhs=size(B, 2);
      Integer lwork=max(min(nrow, ncol) + 3*ncol + 1, 2*min(nrow, ncol) + nrhs);
      Real work[max(min(size(A, 1), size(A, 2)) + 3*size(A, 2) + 1, 2*min(size(A, 1),
        size(A, 2)) + size(B, 2))];
      Real Awork[size(A, 1), size(A, 2)]=A;
      Integer jpvt[size(A, 2)]=zeros(ncol);

    external"FORTRAN 77" dgelsy(
              nrow,
              ncol,
              nrhs,
              Awork,
              nrow,
              X,
              nx,
              jpvt,
              rcond,
              rank,
              work,
              lwork,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGELSY computes the minimum-norm solution to a real linear least
    squares problem:
        minimize || A * X - B ||
    using a complete orthogonal factorization of A.  A is an M-by-N
    matrix which may be rank-deficient.

    Several right hand side vectors b and solution vectors x can be
    handled in a single call; they are stored as the columns of the
    M-by-NRHS right hand side matrix B and the N-by-NRHS solution
    matrix X.

    The routine first computes a QR factorization with column pivoting:
        A * P = Q * [ R11 R12 ]
                    [  0  R22 ]
    with R11 defined as the largest leading submatrix whose estimated
    condition number is less than 1/RCOND.  The order of R11, RANK,
    is the effective rank of A.

    Then, R22 is considered to be negligible, and R12 is annihilated
    by orthogonal transformations from the right, arriving at the
    complete orthogonal factorization:
       A * P = Q * [ T11 0 ] * Z
                   [  0  0 ]
    The minimum-norm solution is then
       X = P * Z' [ inv(T11)*Q1'*B ]
                  [        0       ]
    where Q1 consists of the first RANK columns of Q.

    This routine is basically identical to the original xGELSX except
    three differences:
      o The call to the subroutine xGEQPF has been substituted by
        the call to the subroutine xGEQP3. This subroutine is a Blas-3
        version of the QR factorization with column pivoting.
      o Matrix B (the right hand side) is updated with Blas-3.
      o The permutation of matrix B (the right hand side) is faster and
        more simple.

    Arguments
    =========

    M       (input) INTEGER
            The number of rows of the matrix A.  M >= 0.

    N       (input) INTEGER
            The number of columns of the matrix A.  N >= 0.

    NRHS    (input) INTEGER
            The number of right hand sides, i.e., the number of
            columns of matrices B and X. NRHS >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the M-by-N matrix A.
            On exit, A has been overwritten by details of its
            complete orthogonal factorization.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,M).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
            On entry, the M-by-NRHS right hand side matrix B.
            On exit, the N-by-NRHS solution matrix X.

    LDB     (input) INTEGER
            The leading dimension of the array B. LDB >= max(1,M,N).

    JPVT    (input/output) INTEGER array, dimension (N)
            On entry, if JPVT(i) .ne. 0, the i-th column of A is permuted
            to the front of AP, otherwise column i is a free column.
            On exit, if JPVT(i) = k, then the i-th column of AP
            was the k-th column of A.

    RCOND   (input) DOUBLE PRECISION
            RCOND is used to determine the effective rank of A, which
            is defined as the order of the largest leading triangular
            submatrix R11 in the QR factorization with pivoting of A,
            whose estimated condition number < 1/RCOND.

    RANK    (output) INTEGER
            The effective rank of A, i.e., the order of the submatrix
            R11.  This is the same as the order of the submatrix T11
            in the complete orthogonal factorization of A.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.
            The unblocked strategy requires that:
               LWORK >= MAX( MN+3*N+1, 2*MN+NRHS ),
            where MN = min( M, N ).
            The block algorithm requires that:
               LWORK >= MAX( MN+2*N+NB*(N+1), 2*MN+NB*NRHS ),
            where NB is an upper bound on the blocksize returned
            by ILAENV for the routines DGEQP3, DTZRZF, STZRQF, DORMQR,
            and DORMRZ.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0: successful exit
            < 0: If INFO = -i, the i-th argument had an illegal value.
"));
    end dgelsy;

    pure function dgelsy_vec
      "Compute the minimum-norm solution to a real linear least squares problem with rank deficient A"

      extends Modelica.Icons.Function;
      input Real A[:, :];
      input Real b[size(A, 1)];
      input Real rcond=0.0 "Reciprocal condition number to estimate rank";
      output Real x[max(size(A, 1), size(A, 2))]=cat(
                1,
                b,
                zeros(max(nrow, ncol) - nrow))
        "solution is in first size(A,2) rows";
      output Integer info;
      output Integer rank "Effective rank of A";
    protected
      Integer nrow=size(A, 1);
      Integer ncol=size(A, 2);
      Integer nrhs=1;
      Integer nx=max(nrow, ncol);
      Integer lwork=max(min(nrow, ncol) + 3*ncol + 1, 2*min(nrow, ncol) + 1);
      Real work[max(min(size(A, 1), size(A, 2)) + 3*size(A, 2) + 1, 2*min(size(A, 1),
        size(A, 2)) + 1)];
      Real Awork[size(A, 1), size(A, 2)]=A;
      Integer jpvt[size(A, 2)]=zeros(ncol);

    external"FORTRAN 77" dgelsy(
              nrow,
              ncol,
              nrhs,
              Awork,
              nrow,
              x,
              nx,
              jpvt,
              rcond,
              rank,
              work,
              lwork,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGELSY computes the minimum-norm solution to a real linear least
    squares problem:
        minimize || A * X - B ||
    using a complete orthogonal factorization of A.  A is an M-by-N
    matrix which may be rank-deficient.

    Several right hand side vectors b and solution vectors x can be
    handled in a single call; they are stored as the columns of the
    M-by-NRHS right hand side matrix B and the N-by-NRHS solution
    matrix X.

    The routine first computes a QR factorization with column pivoting:
        A * P = Q * [ R11 R12 ]
                    [  0  R22 ]
    with R11 defined as the largest leading submatrix whose estimated
    condition number is less than 1/RCOND.  The order of R11, RANK,
    is the effective rank of A.

    Then, R22 is considered to be negligible, and R12 is annihilated
    by orthogonal transformations from the right, arriving at the
    complete orthogonal factorization:
       A * P = Q * [ T11 0 ] * Z
                   [  0  0 ]
    The minimum-norm solution is then
       X = P * Z' [ inv(T11)*Q1'*B ]
                  [        0       ]
    where Q1 consists of the first RANK columns of Q.

    This routine is basically identical to the original xGELSX except
    three differences:
      o The call to the subroutine xGEQPF has been substituted by
        the call to the subroutine xGEQP3. This subroutine is a Blas-3
        version of the QR factorization with column pivoting.
      o Matrix B (the right hand side) is updated with Blas-3.
      o The permutation of matrix B (the right hand side) is faster and
        more simple.

    Arguments
    =========

    M       (input) INTEGER
            The number of rows of the matrix A.  M >= 0.

    N       (input) INTEGER
            The number of columns of the matrix A.  N >= 0.

    NRHS    (input) INTEGER
            The number of right hand sides, i.e., the number of
            columns of matrices B and X. NRHS >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the M-by-N matrix A.
            On exit, A has been overwritten by details of its
            complete orthogonal factorization.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,M).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
            On entry, the M-by-NRHS right hand side matrix B.
            On exit, the N-by-NRHS solution matrix X.

    LDB     (input) INTEGER
            The leading dimension of the array B. LDB >= max(1,M,N).

    JPVT    (input/output) INTEGER array, dimension (N)
            On entry, if JPVT(i) .ne. 0, the i-th column of A is permuted
            to the front of AP, otherwise column i is a free column.
            On exit, if JPVT(i) = k, then the i-th column of AP
            was the k-th column of A.

    RCOND   (input) DOUBLE PRECISION
            RCOND is used to determine the effective rank of A, which
            is defined as the order of the largest leading triangular
            submatrix R11 in the QR factorization with pivoting of A,
            whose estimated condition number < 1/RCOND.

    RANK    (output) INTEGER
            The effective rank of A, i.e., the order of the submatrix
            R11.  This is the same as the order of the submatrix T11
            in the complete orthogonal factorization of A.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.
            The unblocked strategy requires that:
               LWORK >= MAX( MN+3*N+1, 2*MN+NRHS ),
            where MN = min( M, N ).
            The block algorithm requires that:
               LWORK >= MAX( MN+2*N+NB*(N+1), 2*MN+NB*NRHS ),
            where NB is an upper bound on the blocksize returned
            by ILAENV for the routines DGEQP3, DTZRZF, STZRQF, DORMQR,
            and DORMRZ.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0: successful exit
            < 0: If INFO = -i, the i-th argument had an illegal value.
"));
    end dgelsy_vec;

    pure function dgels_vec
      "Solve overdetermined or underdetermined real linear equations A*x=b with a b vector"

      extends Modelica.Icons.Function;
      input Real A[:, :];
      input Real b[size(A, 1)];
      output Real x[max(size(A, 1), size(A, 2))]=cat(
                1,
                b,
                zeros(nx - nrow)) "Solution is in first size(A,2) rows";
      output Integer info;
    protected
      Integer nrow=size(A, 1);
      Integer ncol=size(A, 2);
      Integer nrhs=1;
      Integer nx=max(nrow, ncol);
      Integer lwork=min(nrow, ncol) + nx;
      Real work[size(A, 1) + size(A, 2)];
      Real Awork[size(A, 1), size(A, 2)]=A;

    external"FORTRAN 77" dgels(
              "N",
              nrow,
              ncol,
              nrhs,
              Awork,
              nrow,
              x,
              nx,
              work,
              lwork,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGELS solves overdetermined or underdetermined real linear systems
    involving an M-by-N matrix A, or its transpose, using a QR or LQ
    factorization of A.  It is assumed that A has full rank.

    The following options are provided:

    1. If TRANS = 'N' and m >= n:  find the least squares solution of
       an overdetermined system, i.e., solve the least squares problem
                    minimize || B - A*X ||.

    2. If TRANS = 'N' and m < n:  find the minimum norm solution of
       an underdetermined system A * X = B.

    3. If TRANS = 'T' and m >= n:  find the minimum norm solution of
       an undetermined system A**T * X = B.

    4. If TRANS = 'T' and m < n:  find the least squares solution of
       an overdetermined system, i.e., solve the least squares problem
                    minimize || B - A**T * X ||.

    Several right hand side vectors b and solution vectors x can be
    handled in a single call; they are stored as the columns of the
    M-by-NRHS right hand side matrix B and the N-by-NRHS solution
    matrix X.

    Arguments
    =========

    TRANS   (input) CHARACTER*1
            = 'N': the linear system involves A;
            = 'T': the linear system involves A**T.

    M       (input) INTEGER
            The number of rows of the matrix A.  M >= 0.

    N       (input) INTEGER
            The number of columns of the matrix A.  N >= 0.

    NRHS    (input) INTEGER
            The number of right hand sides, i.e., the number of
            columns of the matrices B and X. NRHS >=0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the M-by-N matrix A.
            On exit,
              if M >= N, A is overwritten by details of its QR
                         factorization as returned by DGEQRF;
              if M <  N, A is overwritten by details of its LQ
                         factorization as returned by DGELQF.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,M).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
            On entry, the matrix B of right hand side vectors, stored
            columnwise; B is M-by-NRHS if TRANS = 'N', or N-by-NRHS
            if TRANS = 'T'.
            On exit, if INFO = 0, B is overwritten by the solution
            vectors, stored columnwise:
            if TRANS = 'N' and m >= n, rows 1 to n of B contain the least
            squares solution vectors; the residual sum of squares for the
            solution in each column is given by the sum of squares of
            elements N+1 to M in that column;
            if TRANS = 'N' and m < n, rows 1 to N of B contain the
            minimum norm solution vectors;
            if TRANS = 'T' and m >= n, rows 1 to M of B contain the
            minimum norm solution vectors;
            if TRANS = 'T' and m < n, rows 1 to M of B contain the
            least squares solution vectors; the residual sum of squares
            for the solution in each column is given by the sum of
            squares of elements M+1 to N in that column.

    LDB     (input) INTEGER
            The leading dimension of the array B. LDB >= MAX(1,M,N).

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.
            LWORK >= max( 1, MN + max( MN, NRHS ) ).
            For optimal performance,
            LWORK >= max( 1, MN + max( MN, NRHS )*NB ).
            where MN = min(M,N) and NB is the optimum block size.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
            > 0:  if INFO =  i, the i-th diagonal element of the
                  triangular factor of A is zero, so that A does not have
                  full rank; the least squares solution could not be
                  computed.
"));
    end dgels_vec;

    pure function dgesv
      "Solve real system of linear equations A*X=B with a B matrix"
      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      input Real B[size(A, 1), :];
      output Real X[size(A, 1), size(B, 2)]=B;
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer nrhs=size(B, 2);
      Real Awork[size(A, 1), size(A, 1)]=A;
      Integer lda=max(1, size(A, 1));
      Integer ldb=max(1, size(B, 1));
      Integer ipiv[size(A, 1)];

    external"FORTRAN 77" dgesv(
              n,
              nrhs,
              Awork,
              lda,
              ipiv,
              X,
              ldb,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGESV computes the solution to a real system of linear equations
       A * X = B,
    where A is an N-by-N matrix and X and B are N-by-NRHS matrices.

    The LU decomposition with partial pivoting and row interchanges is
    used to factor A as
       A = P * L * U,
    where P is a permutation matrix, L is unit lower triangular, and U is
    upper triangular.  The factored form of A is then used to solve the
    system of equations A * X = B.

    Arguments
    =========

    N       (input) INTEGER
            The number of linear equations, i.e., the order of the
            matrix A.  N >= 0.

    NRHS    (input) INTEGER
            The number of right hand sides, i.e., the number of columns
            of the matrix B.  NRHS >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the N-by-N coefficient matrix A.
            On exit, the factors L and U from the factorization
            A = P*L*U; the unit diagonal elements of L are not stored.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    IPIV    (output) INTEGER array, dimension (N)
            The pivot indices that define the permutation matrix P;
            row i of the matrix was interchanged with row IPIV(i).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
            On entry, the N-by-NRHS matrix of right hand side matrix B.
            On exit, if INFO = 0, the N-by-NRHS solution matrix X.

    LDB     (input) INTEGER
            The leading dimension of the array B.  LDB >= max(1,N).

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
            > 0:  if INFO = i, U(i,i) is exactly zero.  The factorization
                  has been completed, but the factor U is exactly
                  singular, so the solution could not be computed.
"));
    end dgesv;

    pure function dgesv_vec
      "Solve real system of linear equations A*x=b with a b vector"
      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      input Real b[size(A, 1)];
      output Real x[size(A, 1)]=b;
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer nrhs=1;
      Real Awork[size(A, 1), size(A, 1)]=A;
      Integer lda=max(1, size(A, 1));
      Integer ldb=max(1, size(b, 1));
      Integer ipiv[size(A, 1)];

    external"FORTRAN 77" dgesv(
              n,
              nrhs,
              Awork,
              lda,
              ipiv,
              x,
              ldb,
              info) annotation (Library="lapack");
      annotation (Documentation(info="
Same as function LAPACK.dgesv, but right hand side is a vector and not a matrix.
For details of the arguments, see documentation of dgesv.
"));
    end dgesv_vec;

    pure function dgglse_vec
      "Solve a linear equality constrained least squares problem"
      extends Modelica.Icons.Function;
      input Real A[:, :] "Minimize |A*x - c|^2";
      input Real c[size(A, 1)];
      input Real B[:, size(A, 2)] "Subject to B*x=d";
      input Real d[size(B, 1)];
      output Real x[size(A, 2)] "Solution vector";
      output Integer info;
    protected
      Integer nrow_A=size(A, 1);
      Integer nrow_B=size(B, 1);
      Integer ncol_A=size(A, 2) "(min=nrow_B,max=nrow_A+nrow_B) required";
      Real Awork[size(A, 1), size(A, 2)]=A;
      Real Bwork[size(B, 1), size(A, 2)]=B;
      Real cwork[size(A, 1)]=c;
      Real dwork[size(B, 1)]=d;
      Integer lwork=ncol_A + nrow_B + max(nrow_A, max(ncol_A, nrow_B))*5;
      Real work[size(A, 2) + size(B, 1) + max(size(A, 1), max(size(A, 2), size(
        B, 1)))*5];

    external"FORTRAN 77" dgglse(
              nrow_A,
              ncol_A,
              nrow_B,
              Awork,
              nrow_A,
              Bwork,
              nrow_B,
              cwork,
              dwork,
              x,
              work,
              lwork,
              info) annotation (Library="lapack");

      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGGLSE solves the linear equality-constrained least squares (LSE)
    problem:

            minimize || c - A*x ||_2   subject to   B*x = d

    where A is an M-by-N matrix, B is a P-by-N matrix, c is a given
    M-vector, and d is a given P-vector. It is assumed that
    P <= N <= M+P, and

             rank(B) = P and  rank( (A) ) = N.
                                  ( (B) )

    These conditions ensure that the LSE problem has a unique solution,
    which is obtained using a generalized RQ factorization of the
    matrices (B, A) given by

       B = (0 R)*Q,   A = Z*T*Q.

    Arguments
    =========

    M       (input) INTEGER
            The number of rows of the matrix A.  M >= 0.

    N       (input) INTEGER
            The number of columns of the matrices A and B. N >= 0.

    P       (input) INTEGER
            The number of rows of the matrix B. 0 <= P <= N <= M+P.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the M-by-N matrix A.
            On exit, the elements on and above the diagonal of the array
            contain the min(M,N)-by-N upper trapezoidal matrix T.

    LDA     (input) INTEGER
            The leading dimension of the array A. LDA >= max(1,M).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB,N)
            On entry, the P-by-N matrix B.
            On exit, the upper triangle of the subarray B(1:P,N-P+1:N)
            contains the P-by-P upper triangular matrix R.

    LDB     (input) INTEGER
            The leading dimension of the array B. LDB >= max(1,P).

    C       (input/output) DOUBLE PRECISION array, dimension (M)
            On entry, C contains the right hand side vector for the
            least squares part of the LSE problem.
            On exit, the residual sum of squares for the solution
            is given by the sum of squares of elements N-P+1 to M of
            vector C.

    D       (input/output) DOUBLE PRECISION array, dimension (P)
            On entry, D contains the right hand side vector for the
            constrained equation.
            On exit, D is destroyed.

    X       (output) DOUBLE PRECISION array, dimension (N)
            On exit, X is the solution of the LSE problem.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK. LWORK >= max(1,M+N+P).
            For optimum performance LWORK >= P+min(M,N)+max(M,N)*NB,
            where NB is an upper bound for the optimal blocksizes for
            DGEQRF, SGERQF, DORMQR and SORMRQ.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit.
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            = 1:  the upper triangular factor R associated with B in the
                  generalized RQ factorization of the pair (B, A) is
                  singular, so that rank(B) < P; the least squares
                  solution could not be computed.
            = 2:  the (N-P) by (N-P) part of the upper trapezoidal factor
                  T associated with A in the generalized RQ factorization
                  of the pair (B, A) is singular, so that
                  rank( (A) ) < N; the least squares solution could not
                      ( (B) )
                  be computed.
"));
    end dgglse_vec;

    pure function dgtsv
      "Solve real system of linear equations A*X=B with B matrix and tridiagonal A"

      extends Modelica.Icons.Function;
      input Real superdiag[:];
      input Real diag[size(superdiag, 1) + 1];
      input Real subdiag[size(superdiag, 1)];
      input Real B[size(diag, 1), :];
      output Real X[size(B, 1), size(B, 2)]=B;
      output Integer info;
    protected
      Integer n=size(diag, 1);
      Integer nrhs=size(B, 2);
      Integer ldb=size(B, 1);
      Real superdiagwork[size(superdiag, 1)]=superdiag;
      Real diagwork[size(diag, 1)]=diag;
      Real subdiagwork[size(subdiag, 1)]=subdiag;

    external"FORTRAN 77" dgtsv(
              n,
              nrhs,
              subdiagwork,
              diagwork,
              superdiagwork,
              X,
              ldb,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGTSV  solves the equation

       A*X = B,

    where A is an n by n tridiagonal matrix, by Gaussian elimination with
    partial pivoting.

    Note that the equation  A'*X = B  may be solved by interchanging the
    order of the arguments DU and DL.

    Arguments
    =========

    N       (input) INTEGER
            The order of the matrix A.  N >= 0.

    NRHS    (input) INTEGER
            The number of right hand sides, i.e., the number of columns
            of the matrix B.  NRHS >= 0.

    DL      (input/output) DOUBLE PRECISION array, dimension (N-1)
            On entry, DL must contain the (n-1) sub-diagonal elements of
            A.

            On exit, DL is overwritten by the (n-2) elements of the
            second super-diagonal of the upper triangular matrix U from
            the LU factorization of A, in DL(1), ..., DL(n-2).

    D       (input/output) DOUBLE PRECISION array, dimension (N)
            On entry, D must contain the diagonal elements of A.

            On exit, D is overwritten by the n diagonal elements of U.

    DU      (input/output) DOUBLE PRECISION array, dimension (N-1)
            On entry, DU must contain the (n-1) super-diagonal elements
            of A.

            On exit, DU is overwritten by the (n-1) elements of the first
            super-diagonal of U.

    B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
            On entry, the N by NRHS matrix of right hand side matrix B.
            On exit, if INFO = 0, the N by NRHS solution matrix X.

    LDB     (input) INTEGER
            The leading dimension of the array B.  LDB >= max(1,N).

    INFO    (output) INTEGER
            = 0: successful exit
            < 0: if INFO = -i, the i-th argument had an illegal value
            > 0: if INFO = i, U(i,i) is exactly zero, and the solution
                 has not been computed.  The factorization has not been
                 completed unless i = N.
"));
    end dgtsv;

    pure function dgtsv_vec
      "Solve real system of linear equations A*x=b with b vector and tridiagonal A"

      extends Modelica.Icons.Function;
      input Real superdiag[:];
      input Real diag[size(superdiag, 1) + 1];
      input Real subdiag[size(superdiag, 1)];
      input Real b[size(diag, 1)];
      output Real x[size(b, 1)]=b;
      output Integer info;
    protected
      Integer n=size(diag, 1);
      Integer nrhs=1;
      Integer ldb=size(b, 1);
      Real superdiagwork[size(superdiag, 1)]=superdiag;
      Real diagwork[size(diag, 1)]=diag;
      Real subdiagwork[size(subdiag, 1)]=subdiag;

    external"FORTRAN 77" dgtsv(
              n,
              nrhs,
              subdiagwork,
              diagwork,
              superdiagwork,
              x,
              ldb,
              info) annotation (Library="lapack");
      annotation (Documentation(info="
Same as function LAPACK.dgtsv, but right hand side is a vector and not a matrix.
For details of the arguments, see documentation of dgtsv.
"));
    end dgtsv_vec;

    pure function dgbsv
      "Solve real system of linear equations A*X=B with a B matrix"
      extends Modelica.Icons.Function;
      input Integer n "Number of equations";
      input Integer kLower "Number of lower bands";
      input Integer kUpper "Number of upper bands";
      input Real A[2*kLower + kUpper + 1, n];
      input Real B[n, :];
      output Real X[n, size(B, 2)]=B;
      output Integer info;
    protected
      Integer nrhs=size(B, 2);
      Integer ldab=size(Awork, 1);
      Real Awork[size(A, 1), size(A, 2)]=A;
      Integer ipiv[n];

    external"FORTRAN 77" dgbsv(
              n,
              kLower,
              kUpper,
              nrhs,
              Awork,
              ldab,
              ipiv,
              X,
              n,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGBSV computes the solution to a real system of linear equations
    A * X = B, where A is a band matrix of order N with KL subdiagonals
    and KU superdiagonals, and X and B are N-by-NRHS matrices.

    The LU decomposition with partial pivoting and row interchanges is
    used to factor A as A = L * U, where L is a product of permutation
    and unit lower triangular matrices with KL subdiagonals, and U is
    upper triangular with KL+KU superdiagonals.  The factored form of A
    is then used to solve the system of equations A * X = B.

    Arguments
    =========

    N       (input) INTEGER
            The number of linear equations, i.e., the order of the
            matrix A.  N >= 0.

    KL      (input) INTEGER
            The number of subdiagonals within the band of A.  KL >= 0.

    KU      (input) INTEGER
            The number of superdiagonals within the band of A.  KU >= 0.

    NRHS    (input) INTEGER
            The number of right hand sides, i.e., the number of columns
            of the matrix B.  NRHS >= 0.

    AB      (input/output) DOUBLE PRECISION array, dimension (LDAB,N)
            On entry, the matrix A in band storage, in rows KL+1 to
            2*KL+KU+1; rows 1 to KL of the array need not be set.
            The j-th column of A is stored in the j-th column of the
            array AB as follows:
            AB(KL+KU+1+i-j,j) = A(i,j) for max(1,j-KU)<=i<=min(N,j+KL)
            On exit, details of the factorization: U is stored as an
            upper triangular band matrix with KL+KU superdiagonals in
            rows 1 to KL+KU+1, and the multipliers used during the
            factorization are stored in rows KL+KU+2 to 2*KL+KU+1.
            See below for further details.

    LDAB    (input) INTEGER
            The leading dimension of the array AB.  LDAB >= 2*KL+KU+1.

    IPIV    (output) INTEGER array, dimension (N)
            The pivot indices that define the permutation matrix P;
            row i of the matrix was interchanged with row IPIV(i).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
            On entry, the N-by-NRHS right hand side matrix B.
            On exit, if INFO = 0, the N-by-NRHS solution matrix X.

    LDB     (input) INTEGER
            The leading dimension of the array B.  LDB >= max(1,N).

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
            > 0:  if INFO = i, U(i,i) is exactly zero.  The factorization
                  has been completed, but the factor U is exactly
                  singular, and the solution has not been computed.

    Further Details
    ===============

    The band storage scheme is illustrated by the following example, when
    M = N = 6, KL = 2, KU = 1:

    On entry:                       On exit:

        *    *    *    +    +    +       *    *    *   u14  u25  u36
        *    *    +    +    +    +       *    *   u13  u24  u35  u46
        *   a12  a23  a34  a45  a56      *   u12  u23  u34  u45  u56
       a11  a22  a33  a44  a55  a66     u11  u22  u33  u44  u55  u66
       a21  a32  a43  a54  a65   *      m21  m32  m43  m54  m65   *
       a31  a42  a53  a64   *    *      m31  m42  m53  m64   *    *

    Array elements marked * are not used by the routine; elements marked
    + need not be set on entry, but are required by the routine to store
    elements of U because of fill-in resulting from the row interchanges.
"));
    end dgbsv;

    pure function dgbsv_vec
      "Solve real system of linear equations A*x=b with a b vector"
      extends Modelica.Icons.Function;
      input Integer n "Number of equations";
      input Integer kLower "Number of lower bands";
      input Integer kUpper "Number of upper bands";
      input Real A[2*kLower + kUpper + 1, n];
      input Real b[n];
      output Real x[n]=b;
      output Integer info;
    protected
      Integer nrhs=1;
      Integer ldab=size(Awork, 1);
      Real Awork[size(A, 1), size(A, 2)]=A;
      Integer ipiv[n];

    external"FORTRAN 77" dgbsv(
              n,
              kLower,
              kUpper,
              nrhs,
              Awork,
              ldab,
              ipiv,
              x,
              n,
              info) annotation (Library="lapack");
      annotation (Documentation(info="
Same as function LAPACK.dgbsv, but right hand side is a vector and not a matrix.
For details of the arguments, see documentation of dgbsv.
"));
    end dgbsv_vec;

    pure function dgesvd "Determine singular value decomposition"
      extends Modelica.Icons.Function;
      input Real A[:, :];
      output Real sigma[min(size(A, 1), size(A, 2))];
      output Real U[size(A, 1), size(A, 1)]=zeros(size(A, 1), size(A, 1));
      output Real VT[size(A, 2), size(A, 2)]=zeros(size(A, 2), size(A, 2));
      output Integer info;
    protected
      Integer m=size(A, 1);
      Integer n=size(A, 2);
      Real Awork[size(A, 1), size(A, 2)]=A;
      Integer lwork=5*size(A, 1) + 5*size(A, 2);
      Real work[5*size(A, 1) + 5*size(A, 2)];

    external"FORTRAN 77" dgesvd(
              "A",
              "A",
              m,
              n,
              Awork,
              m,
              sigma,
              U,
              m,
              VT,
              n,
              work,
              lwork,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGESVD computes the singular value decomposition (SVD) of a real
    M-by-N matrix A, optionally computing the left and/or right singular
    vectors. The SVD is written

         A = U * SIGMA * transpose(V)

    where SIGMA is an M-by-N matrix which is zero except for its
    min(m,n) diagonal elements, U is an M-by-M orthogonal matrix, and
    V is an N-by-N orthogonal matrix.  The diagonal elements of SIGMA
    are the singular values of A; they are real and non-negative, and
    are returned in descending order.  The first min(m,n) columns of
    U and V are the left and right singular vectors of A.

    Note that the routine returns V**T, not V.

    Arguments
    =========

    JOBU    (input) CHARACTER*1
            Specifies options for computing all or part of the matrix U:
            = 'A':  all M columns of U are returned in array U:
            = 'S':  the first min(m,n) columns of U (the left singular
                    vectors) are returned in the array U;
            = 'O':  the first min(m,n) columns of U (the left singular
                    vectors) are overwritten on the array A;
            = 'N':  no columns of U (no left singular vectors) are
                    computed.

    JOBVT   (input) CHARACTER*1
            Specifies options for computing all or part of the matrix
            V**T:
            = 'A':  all N rows of V**T are returned in the array VT;
            = 'S':  the first min(m,n) rows of V**T (the right singular
                    vectors) are returned in the array VT;
            = 'O':  the first min(m,n) rows of V**T (the right singular
                    vectors) are overwritten on the array A;
            = 'N':  no rows of V**T (no right singular vectors) are
                    computed.

            JOBVT and JOBU cannot both be 'O'.

    M       (input) INTEGER
            The number of rows of the input matrix A.  M >= 0.

    N       (input) INTEGER
            The number of columns of the input matrix A.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the M-by-N matrix A.
            On exit,
            if JOBU = 'O',  A is overwritten with the first min(m,n)
                            columns of U (the left singular vectors,
                            stored columnwise);
            if JOBVT = 'O', A is overwritten with the first min(m,n)
                            rows of V**T (the right singular vectors,
                            stored rowwise);
            if JOBU .ne. 'O' and JOBVT .ne. 'O', the contents of A
                            are destroyed.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,M).

    S       (output) DOUBLE PRECISION array, dimension (min(M,N))
            The singular values of A, sorted so that S(i) >= S(i+1).

    U       (output) DOUBLE PRECISION array, dimension (LDU,UCOL)
            (LDU,M) if JOBU = 'A' or (LDU,min(M,N)) if JOBU = 'S'.
            If JOBU = 'A', U contains the M-by-M orthogonal matrix U;
            if JOBU = 'S', U contains the first min(m,n) columns of U
            (the left singular vectors, stored columnwise);
            if JOBU = 'N' or 'O', U is not referenced.

    LDU     (input) INTEGER
            The leading dimension of the array U.  LDU >= 1; if
            JOBU = 'S' or 'A', LDU >= M.

    VT      (output) DOUBLE PRECISION array, dimension (LDVT,N)
            If JOBVT = 'A', VT contains the N-by-N orthogonal matrix
            V**T;
            if JOBVT = 'S', VT contains the first min(m,n) rows of
            V**T (the right singular vectors, stored rowwise);
            if JOBVT = 'N' or 'O', VT is not referenced.

    LDVT    (input) INTEGER
            The leading dimension of the array VT.  LDVT >= 1; if
            JOBVT = 'A', LDVT >= N; if JOBVT = 'S', LDVT >= min(M,N).

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK;
            if INFO > 0, WORK(2:MIN(M,N)) contains the unconverged
            superdiagonal elements of an upper bidiagonal matrix B
            whose diagonal is in S (not necessarily sorted). B
            satisfies A = U * B * VT, so it has the same singular values
            as A, and singular vectors related by U and VT.

    LWORK   (input) INTEGER
            The dimension of the array WORK.
            LWORK >= MAX(1,3*MIN(M,N)+MAX(M,N),5*MIN(M,N)).
            For good performance, LWORK should generally be larger.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit.
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            > 0:  if DBDSQR did not converge, INFO specifies how many
                  superdiagonals of an intermediate bidiagonal form B
                  did not converge to zero. See the description of WORK
                  above for details.
"));
    end dgesvd;

    pure function dgesvd_sigma "Determine singular values"
      extends Modelica.Icons.Function;
      input Real A[:, :];
      output Real sigma[min(size(A, 1), size(A, 2))];
      output Integer info;
    protected
      Integer m=size(A, 1);
      Integer n=size(A, 2);
      Real Awork[size(A, 1), size(A, 2)]=A;
      Real U[size(A, 1), size(A, 1)];
      Real VT[size(A, 2), size(A, 2)];
      Integer lwork=5*size(A, 1) + 5*size(A, 2);
      Real work[5*size(A, 1) + 5*size(A, 2)];

    external"FORTRAN 77" dgesvd(
              "N",
              "N",
              m,
              n,
              Awork,
              m,
              sigma,
              U,
              m,
              VT,
              n,
              work,
              lwork,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGESVD computes the singular value decomposition (SVD) of a real
    M-by-N matrix A, optionally computing the left and/or right singular
    vectors. The SVD is written

         A = U * SIGMA * transpose(V)

    where SIGMA is an M-by-N matrix which is zero except for its
    min(m,n) diagonal elements, U is an M-by-M orthogonal matrix, and
    V is an N-by-N orthogonal matrix.  The diagonal elements of SIGMA
    are the singular values of A; they are real and non-negative, and
    are returned in descending order.  The first min(m,n) columns of
    U and V are the left and right singular vectors of A.

    Note that the routine returns V**T, not V.

    Arguments
    =========

    JOBU    (input) CHARACTER*1
            Specifies options for computing all or part of the matrix U:
            = 'A':  all M columns of U are returned in array U:
            = 'S':  the first min(m,n) columns of U (the left singular
                    vectors) are returned in the array U;
            = 'O':  the first min(m,n) columns of U (the left singular
                    vectors) are overwritten on the array A;
            = 'N':  no columns of U (no left singular vectors) are
                    computed.

    JOBVT   (input) CHARACTER*1
            Specifies options for computing all or part of the matrix
            V**T:
            = 'A':  all N rows of V**T are returned in the array VT;
            = 'S':  the first min(m,n) rows of V**T (the right singular
                    vectors) are returned in the array VT;
            = 'O':  the first min(m,n) rows of V**T (the right singular
                    vectors) are overwritten on the array A;
            = 'N':  no rows of V**T (no right singular vectors) are
                    computed.

            JOBVT and JOBU cannot both be 'O'.

    M       (input) INTEGER
            The number of rows of the input matrix A.  M >= 0.

    N       (input) INTEGER
            The number of columns of the input matrix A.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the M-by-N matrix A.
            On exit,
            if JOBU = 'O',  A is overwritten with the first min(m,n)
                            columns of U (the left singular vectors,
                            stored columnwise);
            if JOBVT = 'O', A is overwritten with the first min(m,n)
                            rows of V**T (the right singular vectors,
                            stored rowwise);
            if JOBU .ne. 'O' and JOBVT .ne. 'O', the contents of A
                            are destroyed.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,M).

    S       (output) DOUBLE PRECISION array, dimension (min(M,N))
            The singular values of A, sorted so that S(i) >= S(i+1).

    U       (output) DOUBLE PRECISION array, dimension (LDU,UCOL)
            (LDU,M) if JOBU = 'A' or (LDU,min(M,N)) if JOBU = 'S'.
            If JOBU = 'A', U contains the M-by-M orthogonal matrix U;
            if JOBU = 'S', U contains the first min(m,n) columns of U
            (the left singular vectors, stored columnwise);
            if JOBU = 'N' or 'O', U is not referenced.

    LDU     (input) INTEGER
            The leading dimension of the array U.  LDU >= 1; if
            JOBU = 'S' or 'A', LDU >= M.

    VT      (output) DOUBLE PRECISION array, dimension (LDVT,N)
            If JOBVT = 'A', VT contains the N-by-N orthogonal matrix
            V**T;
            if JOBVT = 'S', VT contains the first min(m,n) rows of
            V**T (the right singular vectors, stored rowwise);
            if JOBVT = 'N' or 'O', VT is not referenced.

    LDVT    (input) INTEGER
            The leading dimension of the array VT.  LDVT >= 1; if
            JOBVT = 'A', LDVT >= N; if JOBVT = 'S', LDVT >= min(M,N).

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK;
            if INFO > 0, WORK(2:MIN(M,N)) contains the unconverged
            superdiagonal elements of an upper bidiagonal matrix B
            whose diagonal is in S (not necessarily sorted). B
            satisfies A = U * B * VT, so it has the same singular values
            as A, and singular vectors related by U and VT.

    LWORK   (input) INTEGER
            The dimension of the array WORK.
            LWORK >= MAX(1,3*MIN(M,N)+MAX(M,N),5*MIN(M,N)).
            For good performance, LWORK should generally be larger.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit.
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            > 0:  if DBDSQR did not converge, INFO specifies how many
                  superdiagonals of an intermediate bidiagonal form B
                  did not converge to zero. See the description of WORK
                  above for details.
"));
    end dgesvd_sigma;

    pure function dgetrf
      "Compute LU factorization of square or rectangular matrix A (A = P*L*U)"

      extends Modelica.Icons.Function;
      input Real A[:, :] "Square or rectangular matrix";
      output Real LU[size(A, 1), size(A, 2)]=A;
      output Integer pivots[min(size(A, 1), size(A, 2))] "Pivot vector";
      output Integer info "Information";
    protected
      Integer m=size(A, 1);
      Integer n=size(A, 2);
      Integer lda=max(1, size(A, 1));

    external"FORTRAN 77" dgetrf(
              m,
              n,
              LU,
              lda,
              pivots,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGETRF computes an LU factorization of a general M-by-N matrix A
    using partial pivoting with row interchanges.

    The factorization has the form
       A = P * L * U
    where P is a permutation matrix, L is lower triangular with unit
    diagonal elements (lower trapezoidal if m > n), and U is upper
    triangular (upper trapezoidal if m < n).

    This is the right-looking Level 3 BLAS version of the algorithm.

    Arguments
    =========

    M       (input) INTEGER
            The number of rows of the matrix A.  M >= 0.

    N       (input) INTEGER
            The number of columns of the matrix A.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the M-by-N matrix to be factored.
            On exit, the factors L and U from the factorization
            A = P*L*U; the unit diagonal elements of L are not stored.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,M).

    IPIV    (output) INTEGER array, dimension (min(M,N))
            The pivot indices; for 1 <= i <= min(M,N), row i of the
            matrix was interchanged with row IPIV(i).

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
            > 0:  if INFO = i, U(i,i) is exactly zero. The factorization
                  has been completed, but the factor U is exactly
                  singular, and division by zero will occur if it is used
                  to solve a system of equations.
"));
    end dgetrf;

    pure function dgetrs
      "Solve a system of linear equations with the LU decomposition from dgetrf"

      extends Modelica.Icons.Function;
      input Real LU[:, size(LU, 1)]
        "LU factorization of dgetrf of a square matrix";
      input Integer pivots[size(LU, 1)] "Pivot vector of dgetrf";
      input Real B[size(LU, 1), :] "Right hand side matrix B";
      output Real X[size(B, 1), size(B, 2)]=B "Solution matrix X";
      output Integer info;
    protected
      Integer n=size(LU, 1);
      Integer nrhs=size(B, 2);
      Real work[size(LU, 1), size(LU, 1)]=LU;
      Integer lda=max(1, size(LU, 1));
      Integer ldb=max(1, size(B, 1));

    external"FORTRAN 77" dgetrs(
              "N",
              n,
              nrhs,
              work,
              lda,
              pivots,
              X,
              ldb,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGETRS solves a system of linear equations
       A * X = B  or  A' * X = B
    with a general N-by-N matrix A using the LU factorization computed
    by DGETRF.

    Arguments
    =========

    TRANS   (input) CHARACTER*1
            Specifies the form of the system of equations:
            = 'N':  A * X = B  (No transpose)
            = 'T':  A'* X = B  (Transpose)
            = 'C':  A'* X = B  (Conjugate transpose = Transpose)

    N       (input) INTEGER
            The order of the matrix A.  N >= 0.

    NRHS    (input) INTEGER
            The number of right hand sides, i.e., the number of columns
            of the matrix B.  NRHS >= 0.

    A       (input) DOUBLE PRECISION array, dimension (LDA,N)
            The factors L and U from the factorization A = P*L*U
            as computed by DGETRF.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    IPIV    (input) INTEGER array, dimension (N)
            The pivot indices from DGETRF; for 1<=i<=N, row i of the
            matrix was interchanged with row IPIV(i).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
            On entry, the right hand side matrix B.
            On exit, the solution matrix X.

    LDB     (input) INTEGER
            The leading dimension of the array B.  LDB >= max(1,N).

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
"));
    end dgetrs;

    pure function dgetrs_vec
      "Solve a system of linear equations with the LU decomposition from dgetrf"

      extends Modelica.Icons.Function;
      input Real LU[:, size(LU, 1)]
        "LU factorization of dgetrf of a square matrix";
      input Integer pivots[size(LU, 1)] "Pivot vector of dgetrf";
      input Real b[size(LU, 1)] "Right hand side vector b";
      output Real x[size(b, 1)]=b;
      output Integer info;

    protected
      Integer n=size(LU, 1);
      Integer nrhs=1;
      Real work[size(LU, 1), size(LU, 1)]=LU;
      Integer lda=max(1, size(LU, 1));
      Integer ldb=max(1, size(b, 1));

    external"FORTRAN 77" dgetrs(
              "N",
              n,
              nrhs,
              work,
              lda,
              pivots,
              x,
              ldb,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGETRS solves a system of linear equations
       A * X = B  or  A' * X = B
    with a general N-by-N matrix A using the LU factorization computed
    by DGETRF.

    Arguments
    =========

    TRANS   (input) CHARACTER*1
            Specifies the form of the system of equations:
            = 'N':  A * X = B  (No transpose)
            = 'T':  A'* X = B  (Transpose)
            = 'C':  A'* X = B  (Conjugate transpose = Transpose)

    N       (input) INTEGER
            The order of the matrix A.  N >= 0.

    NRHS    (input) INTEGER
            The number of right hand sides, i.e., the number of columns
            of the matrix B.  NRHS >= 0.

    A       (input) DOUBLE PRECISION array, dimension (LDA,N)
            The factors L and U from the factorization A = P*L*U
            as computed by DGETRF.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    IPIV    (input) INTEGER array, dimension (N)
            The pivot indices from DGETRF; for 1<=i<=N, row i of the
            matrix was interchanged with row IPIV(i).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
            On entry, the right hand side matrix B.
            On exit, the solution matrix X.

    LDB     (input) INTEGER
            The leading dimension of the array B.  LDB >= max(1,N).

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
"));
    end dgetrs_vec;

    pure function dgetri
      "Compute the inverse of a matrix using the LU factorization from dgetrf"

      extends Modelica.Icons.Function;
      input Real LU[:, size(LU, 1)]
        "LU factorization of dgetrf of a square matrix";
      input Integer pivots[size(LU, 1)] "Pivot vector of dgetrf";
      output Real inv[size(LU, 1), size(LU, 2)]=LU "Inverse of matrix P*L*U";
      output Integer info;

    protected
      Integer n=size(LU, 1);
      Integer lda=max(1, size(LU, 1));
      Integer lwork=max(1, min(10, size(LU, 1))*size(LU, 1))
        "Length of work array";
      Real work[max(1, min(10, size(LU, 1))*size(LU, 1))];

    external"FORTRAN 77" dgetri(
              n,
              inv,
              lda,
              pivots,
              work,
              lwork,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGETRI computes the inverse of a matrix using the LU factorization
    computed by DGETRF.

    This method inverts U and then computes inv(A) by solving the system
    inv(A)*L = inv(U) for inv(A).

    Arguments
    =========

    N       (input) INTEGER
            The order of the matrix A.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the factors L and U from the factorization
            A = P*L*U as computed by DGETRF.
            On exit, if INFO = 0, the inverse of the original matrix A.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    IPIV    (input) INTEGER array, dimension (N)
            The pivot indices from DGETRF; for 1<=i<=N, row i of the
            matrix was interchanged with row IPIV(i).

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO=0, then WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.  LWORK >= max(1,N).
            For optimal performance LWORK >= N*NB, where NB is
            the optimal blocksize returned by ILAENV.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
            > 0:  if INFO = i, U(i,i) is exactly zero; the matrix is
                  singular and its inverse could not be computed.
"));
    end dgetri;

    pure function dgeqp3 "Compute QR factorization with column pivoting of square or rectangular matrix A"

      extends Modelica.Icons.Function;
      input Real A[:, :] "Square or rectangular matrix";
      input Integer lwork=max(1, 3*size(A, 2) + 1) "Length of work array";
      output Real QR[size(A, 1), size(A, 2)]=A
        "QR factorization in packed format";
      output Real tau[min(size(A, 1), size(A, 2))]
        "The scalar factors of the elementary reflectors of Q";
      output Integer p[size(A, 2)]=zeros(size(A, 2)) "Pivot vector";
      output Integer info;
    protected
      Integer m=size(A, 1);
      Integer lda=max(1, size(A, 1));
      Integer ncol=size(A, 2) "Column dimension of A";
      Real work[lwork] "Work array";

    external"FORTRAN 77" dgeqp3(
              m,
              ncol,
              QR,
              lda,
              p,
              tau,
              work,
              lwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGEQP3 computes a QR factorization with column pivoting of a
    matrix A:  A*P = Q*R  using Level 3 BLAS.

    Arguments
    =========

    M       (input) INTEGER
            The number of rows of the matrix A. M >= 0.

    N       (input) INTEGER
            The number of columns of the matrix A.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the M-by-N matrix A.
            On exit, the upper triangle of the array contains the
            min(M,N)-by-N upper trapezoidal matrix R; the elements below
            the diagonal, together with the array TAU, represent the
            orthogonal matrix Q as a product of min(M,N) elementary
            reflectors.

    LDA     (input) INTEGER
            The leading dimension of the array A. LDA >= max(1,M).

    JPVT    (input/output) INTEGER array, dimension (N)
            On entry, if JPVT(J).ne.0, the J-th column of A is permuted
            to the front of A*P (a leading column); if JPVT(J)=0,
            the J-th column of A is a free column.
            On exit, if JPVT(J)=K, then the J-th column of A*P was the
            the K-th column of A.

    TAU     (output) DOUBLE PRECISION array, dimension (min(M,N))
            The scalar factors of the elementary reflectors.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO=0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK. LWORK >= 3*N+1.
            For optimal performance LWORK >= 2*N+( N+1 )*NB, where NB
            is the optimal blocksize.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0: successful exit.
            < 0: if INFO = -i, the i-th argument had an illegal value.

    Further Details
    ===============

    The matrix Q is represented as a product of elementary reflectors

       Q = H(1) H(2) . . . H(k), where k = min(m,n).

    Each H(i) has the form

       H(i) = I - tau * v * v'

    where tau is a real/complex scalar, and v is a real/complex vector
    with v(1:i-1) = 0 and v(i) = 1; v(i+1:m) is stored on exit in
    A(i+1:m,i), and tau in TAU(i).

    Based on contributions by
      G. Quintana-Orti, Depto. de Informatica, Universidad Jaime I, Spain
      X. Sun, Computer Science Dept., Duke University, USA
"));
    end dgeqp3;

    pure function dorgqr
      "Generate a Real orthogonal matrix Q which is defined as the product of elementary reflectors as returned from dgeqrf"

      extends Modelica.Icons.Function;
      input Real QR[:, :] "QR from dgeqrf";
      input Real tau[min(size(QR, 1), size(QR, 2))]
        "The scalar factors of the elementary reflectors of Q";
      output Real Q[size(QR, 1), size(QR, 2)]=QR "Orthogonal matrix Q";
      output Integer info;

    protected
      Integer m=size(QR, 1);
      Integer n=size(QR, 2);
      Integer k=size(tau, 1);
      Integer lda=max(1, size(Q, 1));
      Integer lwork=max(1, min(10, size(QR, 2))*size(QR, 2))
        "Length of work array";
      Real work[max(1, min(10, size(QR, 2))*size(QR, 2))];

    external"FORTRAN 77" dorgqr(
              m,
              n,
              k,
              Q,
              lda,
              tau,
              work,
              lwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DORGQR generates an M-by-N real matrix Q with orthonormal columns,
    which is defined as the first N columns of a product of K elementary
    reflectors of order M

          Q  =  H(1) H(2) . . . H(k)

    as returned by DGEQRF.

    Arguments
    =========

    M       (input) INTEGER
            The number of rows of the matrix Q. M >= 0.

    N       (input) INTEGER
            The number of columns of the matrix Q. M >= N >= 0.

    K       (input) INTEGER
            The number of elementary reflectors whose product defines the
            matrix Q. N >= K >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the i-th column must contain the vector which
            defines the elementary reflector H(i), for i = 1,2,...,k, as
            returned by DGEQRF in the first k columns of its array
            argument A.
            On exit, the M-by-N matrix Q.

    LDA     (input) INTEGER
            The first dimension of the array A. LDA >= max(1,M).

    TAU     (input) DOUBLE PRECISION array, dimension (K)
            TAU(i) must contain the scalar factor of the elementary
            reflector H(i), as returned by DGEQRF.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK. LWORK >= max(1,N).
            For optimum performance LWORK >= N*NB, where NB is the
            optimal blocksize.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument has an illegal value
"));
    end dorgqr;

    pure function dgees
      "Compute real Schur form T of real nonsymmetric matrix A, and, optionally, the matrix of Schur vectors Z as well as the eigenvalues"
      extends Modelica.Icons.Function;

      input Real A[:, size(A, 1)] "Square matrix";
      output Real T[size(A, 1), size(A, 2)]=A "Real Schur form with A = Z*T*Z'";
      output Real Z[size(A, 1), size(A, 1)]
        "Orthogonal matrix Z of Schur vectors";
      output Real eval_real[size(A, 1)] "Real part of the eigenvectors of A";
      output Real eval_imag[size(A, 1)]
        "Imaginary part of the eigenvectors of A";
      output Integer info;

    protected
      constant Integer dummyFunctionPointerNotUsed[1]={0};
      Integer n=size(A, 1) "Row dimension of A";
      Integer lda=max(1, n);
      Integer sdim=0;
      Integer lwork=max(1, 10*size(A, 1));
      Real work[lwork];
      Boolean bwork[size(A, 1)];

    external"FORTRAN 77" dgees(
              "V",
              "N",
              dummyFunctionPointerNotUsed,
              n,
              T,
              lda,
              sdim,
              eval_real,
              eval_imag,
              Z,
              lda,
              work,
              lwork,
              bwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGEES computes for an N-by-N real nonsymmetric matrix A, the
    eigenvalues, the real Schur form T, and, optionally, the matrix of
    Schur vectors Z.  This gives the Schur factorization A = Z*T*(Z**T).

    Optionally, it also orders the eigenvalues on the diagonal of the
    real Schur form so that selected eigenvalues are at the top left.
    The leading columns of Z then form an orthonormal basis for the
    invariant subspace corresponding to the selected eigenvalues.

    A matrix is in real Schur form if it is upper quasi-triangular with
    1-by-1 and 2-by-2 blocks. 2-by-2 blocks will be standardized in the
    form
            [  a  b  ]
            [  c  a  ]

    where b*c < 0. The eigenvalues of such a block are a +- sqrt(bc).

    Arguments
    =========

    JOBVS   (input) CHARACTER*1
            = 'N': Schur vectors are not computed;
            = 'V': Schur vectors are computed.

    SORT    (input) CHARACTER*1
            Specifies whether or not to order the eigenvalues on the
            diagonal of the Schur form.
            = 'N': Eigenvalues are not ordered;
            = 'S': Eigenvalues are ordered (see SELECT).

    SELECT  (external procedure) LOGICAL FUNCTION of two DOUBLE PRECISION arguments
            SELECT must be declared EXTERNAL in the calling subroutine.
            If SORT = 'S', SELECT is used to select eigenvalues to sort
            to the top left of the Schur form.
            If SORT = 'N', SELECT is not referenced.
            An eigenvalue WR(j)+sqrt(-1)*WI(j) is selected if
            SELECT(WR(j),WI(j)) is true; i.e., if either one of a complex
            conjugate pair of eigenvalues is selected, then both complex
            eigenvalues are selected.
            Note that a selected complex eigenvalue may no longer
            satisfy SELECT(WR(j),WI(j)) = .TRUE. after ordering, since
            ordering may change the value of complex eigenvalues
            (especially if the eigenvalue is ill-conditioned); in this
            case INFO is set to N+2 (see INFO below).

    N       (input) INTEGER
            The order of the matrix A. N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the N-by-N matrix A.
            On exit, A has been overwritten by its real Schur form T.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    SDIM    (output) INTEGER
            If SORT = 'N', SDIM = 0.
            If SORT = 'S', SDIM = number of eigenvalues (after sorting)
                           for which SELECT is true. (Complex conjugate
                           pairs for which SELECT is true for either
                           eigenvalue count as 2.)

    WR      (output) DOUBLE PRECISION array, dimension (N)
    WI      (output) DOUBLE PRECISION array, dimension (N)
            WR and WI contain the real and imaginary parts,
            respectively, of the computed eigenvalues in the same order
            that they appear on the diagonal of the output Schur form T.
            Complex conjugate pairs of eigenvalues will appear
            consecutively with the eigenvalue having the positive
            imaginary part first.

    VS      (output) DOUBLE PRECISION array, dimension (LDVS,N)
            If JOBVS = 'V', VS contains the orthogonal matrix Z of Schur
            vectors.
            If JOBVS = 'N', VS is not referenced.

    LDVS    (input) INTEGER
            The leading dimension of the array VS.  LDVS >= 1; if
            JOBVS = 'V', LDVS >= N.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) contains the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.  LWORK >= max(1,3*N).
            For good performance, LWORK must generally be larger.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    BWORK   (workspace) LOGICAL array, dimension (N)
            Not referenced if SORT = 'N'.

    INFO    (output) INTEGER
            = 0: successful exit
            < 0: if INFO = -i, the i-th argument had an illegal value.
            > 0: if INFO = i, and i is
               <= N: the QR algorithm failed to compute all the
                     eigenvalues; elements 1:ILO-1 and i+1:N of WR and WI
                     contain those eigenvalues which have converged; if
                     JOBVS = 'V', VS contains the matrix which reduces A
                     to its partially converged Schur form.
               = N+1: the eigenvalues could not be reordered because some
                     eigenvalues were too close to separate (the problem
                     is very ill-conditioned);
               = N+2: after reordering, roundoff changed values of some
                     complex eigenvalues so that leading eigenvalues in
                     the Schur form no longer satisfy SELECT=.TRUE.  This
                     could also be caused by underflow due to scaling.
"));
    end dgees;

    pure function dtrsen "Reorder the real Schur factorization of a real matrix"
      extends Modelica.Icons.Function;

      input String job="N" "Specifies the usage of a condition number";
      input String compq="V" "Is \"V\" if Schur vector matrix is to be updated";
      input Boolean select[:] "Specifies the eigenvalues to reorder";
      input Real T[:, :] "Real Schur form to be reordered";
      input Real Q[:, size(T, 2)] "Matrix of the Schur vectors";

    protected
      Integer n=size(T, 2);
      Integer ldt=max(1, n);
      Integer ldq=if compq == "V" then max(n, 1) else 1;
      Integer lwork=if job == "N" then max(1, n) else if job == "E" then n*n
           else 2*n*n;
      Real work[if job == "N" then max(1, size(T, 2)) else if job == "E" then
        size(T, 2)*size(T, 2) else 2*size(T, 2)*size(T, 2)];
      Integer liwork=if job == "N" or job == "E" then 1 else n*n;
      Integer iwork[if job == "N" or job == "E" then 1 else size(T, 2)*size(T,
        2)];

    public
      output Real To[:, :]=T "Reordered Schur form";
      output Real Qo[:, :]=Q "Reordered Schur vectors";
      output Real wr[size(T, 2)] "Reordered eigenvalues, real part";
      output Real wi[size(T, 2)] "Reordered eigenvalues, imaginary part";
      output Integer m
        "Dimension of the invariant sub space spanned bei the selected eigenvalues";
      output Real s
        "Lower bound of the reciprocal condition number. Not referenced for job==V";
      output Real sep
        "Estimated reciprocal condition number of the specified invariant subspace";
      output Integer info;

    external"FORTRAN 77" dtrsen(
              job,
              compq,
              select,
              n,
              To,
              ldt,
              Qo,
              ldq,
              wr,
              wi,
              m,
              s,
              sep,
              work,
              lwork,
              iwork,
              liwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DTRSEN reorders the real Schur factorization of a real matrix
    A = Q*T*Q**T, so that a selected cluster of eigenvalues appears in
    the leading diagonal blocks of the upper quasi-triangular matrix T,
    and the leading columns of Q form an orthonormal basis of the
    corresponding right invariant subspace.

    Optionally the routine computes the reciprocal condition numbers of
    the cluster of eigenvalues and/or the invariant subspace.

    T must be in Schur canonical form (as returned by DHSEQR), that is,
    block upper triangular with 1-by-1 and 2-by-2 diagonal blocks; each
    2-by-2 diagonal block has its diagonal elements equal and its
    off-diagonal elements of opposite sign.

    Arguments
    =========

    JOB     (input) CHARACTER*1
            Specifies whether condition numbers are required for the
            cluster of eigenvalues (S) or the invariant subspace (SEP):
            = 'N': none;
            = 'E': for eigenvalues only (S);
            = 'V': for invariant subspace only (SEP);
            = 'B': for both eigenvalues and invariant subspace (S and
                   SEP).

    COMPQ   (input) CHARACTER*1
            = 'V': update the matrix Q of Schur vectors;
            = 'N': do not update Q.

    SELECT  (input) LOGICAL array, dimension (N)
            SELECT specifies the eigenvalues in the selected cluster. To
            select a real eigenvalue w(j), SELECT(j) must be set to
            .TRUE.. To select a complex conjugate pair of eigenvalues
            w(j) and w(j+1), corresponding to a 2-by-2 diagonal block,
            either SELECT(j) or SELECT(j+1) or both must be set to
            .TRUE.; a complex conjugate pair of eigenvalues must be
            either both included in the cluster or both excluded.

    N       (input) INTEGER
            The order of the matrix T. N >= 0.

    T       (input/output) DOUBLE PRECISION array, dimension (LDT,N)
            On entry, the upper quasi-triangular matrix T, in Schur
            canonical form.
            On exit, T is overwritten by the reordered matrix T, again in
            Schur canonical form, with the selected eigenvalues in the
            leading diagonal blocks.

    LDT     (input) INTEGER
            The leading dimension of the array T. LDT >= max(1,N).

    Q       (input/output) DOUBLE PRECISION array, dimension (LDQ,N)
            On entry, if COMPQ = 'V', the matrix Q of Schur vectors.
            On exit, if COMPQ = 'V', Q has been postmultiplied by the
            orthogonal transformation matrix which reorders T; the
            leading M columns of Q form an orthonormal basis for the
            specified invariant subspace.
            If COMPQ = 'N', Q is not referenced.

    LDQ     (input) INTEGER
            The leading dimension of the array Q.
            LDQ >= 1; and if COMPQ = 'V', LDQ >= N.

    WR      (output) DOUBLE PRECISION array, dimension (N)
    WI      (output) DOUBLE PRECISION array, dimension (N)
            The real and imaginary parts, respectively, of the reordered
            eigenvalues of T. The eigenvalues are stored in the same
            order as on the diagonal of T, with WR(i) = T(i,i) and, if
            T(i:i+1,i:i+1) is a 2-by-2 diagonal block, WI(i) > 0 and
            WI(i+1) = -WI(i). Note that if a complex eigenvalue is
            sufficiently ill-conditioned, then its value may differ
            significantly from its value before reordering.

    M       (output) INTEGER
            The dimension of the specified invariant subspace.
            0 < = M <= N.

    S       (output) DOUBLE PRECISION
            If JOB = 'E' or 'B', S is a lower bound on the reciprocal
            condition number for the selected cluster of eigenvalues.
            S cannot underestimate the true reciprocal condition number
            by more than a factor of sqrt(N). If M = 0 or N, S = 1.
            If JOB = 'N' or 'V', S is not referenced.

    SEP     (output) DOUBLE PRECISION
            If JOB = 'V' or 'B', SEP is the estimated reciprocal
            condition number of the specified invariant subspace. If
            M = 0 or N, SEP = norm(T).
            If JOB = 'N' or 'E', SEP is not referenced.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.
            If JOB = 'N', LWORK >= max(1,N);
            if JOB = 'E', LWORK >= max(1,M*(N-M));
            if JOB = 'V' or 'B', LWORK >= max(1,2*M*(N-M)).

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    IWORK   (workspace) INTEGER array, dimension (MAX(1,LIWORK))
            On exit, if INFO = 0, IWORK(1) returns the optimal LIWORK.

    LIWORK  (input) INTEGER
            The dimension of the array IWORK.
            If JOB = 'N' or 'E', LIWORK >= 1;
            if JOB = 'V' or 'B', LIWORK >= max(1,M*(N-M)).

            If LIWORK = -1, then a workspace query is assumed; the
            routine only calculates the optimal size of the IWORK array,
            returns this value as the first entry of the IWORK array, and
            no error message related to LIWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0: successful exit
            < 0: if INFO = -i, the i-th argument had an illegal value
            = 1: reordering of T failed because some eigenvalues are too
                 close to separate (the problem is very ill-conditioned);
                 T may have been partially reordered, and WR and WI
                 contain the eigenvalues in the same order as in T; S and
                 SEP (if requested) are set to zero.

    Further Details
    ===============

    DTRSEN first collects the selected eigenvalues by computing an
    orthogonal transformation Z to move them to the top left corner of T.
    In other words, the selected eigenvalues are the eigenvalues of T11
    in:

                  Z'*T*Z = ( T11 T12 ) n1
                           (  0  T22 ) n2
                              n1  n2

    where N = n1+n2 and Z' means the transpose of Z. The first n1 columns
    of Z span the specified invariant subspace of T.

    If T has been obtained from the real Schur factorization of a matrix
    A = Q*T*Q', then the reordered real Schur factorization of A is given
    by A = (Q*Z)*(Z'*T*Z)*(Q*Z)', and the first n1 columns of Q*Z span
    the corresponding invariant subspace of A.

    The reciprocal condition number of the average of the eigenvalues of
    T11 may be returned in S. S lies between 0 (very badly conditioned)
    and 1 (very well conditioned). It is computed as follows. First we
    compute R so that

                           P = ( I  R ) n1
                               ( 0  0 ) n2
                                 n1 n2

    is the projector on the invariant subspace associated with T11.
    R is the solution of the Sylvester equation:

                          T11*R - R*T22 = T12.

    Let F-norm(M) denote the Frobenius-norm of M and 2-norm(M) denote
    the two-norm of M. Then S is computed as the lower bound

                        (1 + F-norm(R)**2)**(-1/2)

    on the reciprocal of 2-norm(P), the true reciprocal condition number.
    S cannot underestimate 1 / 2-norm(P) by more than a factor of
    sqrt(N).

    An approximate error bound for the computed average of the
    eigenvalues of T11 is

                           EPS * norm(T) / S

    where EPS is the machine precision.

    The reciprocal condition number of the right invariant subspace
    spanned by the first n1 columns of Z (or of Q*Z) is returned in SEP.
    SEP is defined as the separation of T11 and T22:

                       sep( T11, T22 ) = sigma-min( C )

    where sigma-min(C) is the smallest singular value of the
    n1*n2-by-n1*n2 matrix

       C  = kprod( I(n2), T11 ) - kprod( transpose(T22), I(n1) )

    I(m) is an m by m identity matrix, and kprod denotes the Kronecker
    product. We estimate sigma-min(C) by the reciprocal of an estimate of
    the 1-norm of inverse(C). The true reciprocal 1-norm of inverse(C)
    cannot differ from sigma-min(C) by more than a factor of sqrt(n1*n2).

    When SEP is small, small changes in T can cause large changes in
    the invariant subspace. An approximate bound on the maximum angular
    error in the computed right invariant subspace is

                        EPS * norm(T) / SEP
"));
    end dtrsen;

    pure function dgesvx
      "Solve real system of linear equations op(A)*X=B, op(A) is A or A' according to the Boolean input transposed"
      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)] "Real square matrix A";
      input Real B[size(A, 1), :] "Real matrix B";
      input Boolean transposed=true
        "= true, if the equation to be solved is A'*X=B";
      output Real X[size(A, 1), size(B, 2)] "Solution matrix";
      output Integer info;
      output Real rcond "Reciprocal condition number of the matrix A";

    protected
      Integer n=size(A, 1);
      Integer nrhs=size(B, 2);
      String transA=if transposed then "T" else "N";
      Real Awork[size(A, 1), size(A, 2)]=A;
      Real Bwork[size(B, 1), size(B, 2)]=B;
      Real AF[size(A, 1), size(A, 2)];
      Real R[size(A, 1)];
      Real C[size(A, 1)];
      Real ferr[size(B, 2)];
      Real berr[size(B, 2)];
      Integer lda=max(1, size(A, 1));
      Real work[4*size(A, 1)];
      Integer ipiv[size(A, 1)];
      Integer iwork[size(A, 1)];
      String equed = " ";

    external"FORTRAN 77" dgesvx(
              "N",
              transA,
              n,
              nrhs,
              Awork,
              lda,
              AF,
              lda,
              ipiv,
              equed,
              R,
              C,
              Bwork,
              lda,
              X,
              lda,
              rcond,
              ferr,
              berr,
              work,
              iwork,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGESVX uses the LU factorization to compute the solution to a real
    system of linear equations
       A * X = B,
    where A is an N-by-N matrix and X and B are N-by-NRHS matrices.

    Error bounds on the solution and a condition estimate are also
    provided.

    Description
    ===========

    The following steps are performed:

    1. If FACT = 'E', real scaling factors are computed to equilibrate
       the system:
          TRANS = 'N':  diag(R)*A*diag(C)     *inv(diag(C))*X = diag(R)*B
          TRANS = 'T': (diag(R)*A*diag(C))**T *inv(diag(R))*X = diag(C)*B
          TRANS = 'C': (diag(R)*A*diag(C))**H *inv(diag(R))*X = diag(C)*B
       Whether or not the system will be equilibrated depends on the
       scaling of the matrix A, but if equilibration is used, A is
       overwritten by diag(R)*A*diag(C) and B by diag(R)*B (if TRANS='N')
       or diag(C)*B (if TRANS = 'T' or 'C').

    2. If FACT = 'N' or 'E', the LU decomposition is used to factor the
       matrix A (after equilibration if FACT = 'E') as
          A = P * L * U,
       where P is a permutation matrix, L is a unit lower triangular
       matrix, and U is upper triangular.

    3. If some U(i,i)=0, so that U is exactly singular, then the routine
       returns with INFO = i. Otherwise, the factored form of A is used
       to estimate the condition number of the matrix A.  If the
       reciprocal of the condition number is less than machine precision,
       INFO = N+1 is returned as a warning, but the routine still goes on
       to solve for X and compute error bounds as described below.

    4. The system of equations is solved for X using the factored form
       of A.

    5. Iterative refinement is applied to improve the computed solution
       matrix and calculate error bounds and backward error estimates
       for it.

    6. If equilibration was used, the matrix X is premultiplied by
       diag(C) (if TRANS = 'N') or diag(R) (if TRANS = 'T' or 'C') so
       that it solves the original system before equilibration.

    Arguments
    =========

    FACT    (input) CHARACTER*1
            Specifies whether or not the factored form of the matrix A is
            supplied on entry, and if not, whether the matrix A should be
            equilibrated before it is factored.
            = 'F':  On entry, AF and IPIV contain the factored form of A.
                    If EQUED is not 'N', the matrix A has been
                    equilibrated with scaling factors given by R and C.
                    A, AF, and IPIV are not modified.
            = 'N':  The matrix A will be copied to AF and factored.
            = 'E':  The matrix A will be equilibrated if necessary, then
                    copied to AF and factored.

    TRANS   (input) CHARACTER*1
            Specifies the form of the system of equations:
            = 'N':  A * X = B     (No transpose)
            = 'T':  A**T * X = B  (Transpose)
            = 'C':  A**H * X = B  (Transpose)

    N       (input) INTEGER
            The number of linear equations, i.e., the order of the
            matrix A.  N >= 0.

    NRHS    (input) INTEGER
            The number of right hand sides, i.e., the number of columns
            of the matrices B and X.  NRHS >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the N-by-N matrix A.  If FACT = 'F' and EQUED is
            not 'N', then A must have been equilibrated by the scaling
            factors in R and/or C.  A is not modified if FACT = 'F' or
            'N', or if FACT = 'E' and EQUED = 'N' on exit.

            On exit, if EQUED .ne. 'N', A is scaled as follows:
            EQUED = 'R':  A := diag(R) * A
            EQUED = 'C':  A := A * diag(C)
            EQUED = 'B':  A := diag(R) * A * diag(C).

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    AF      (input or output) DOUBLE PRECISION array, dimension (LDAF,N)
            If FACT = 'F', then AF is an input argument and on entry
            contains the factors L and U from the factorization
            A = P*L*U as computed by DGETRF.  If EQUED .ne. 'N', then
            AF is the factored form of the equilibrated matrix A.

            If FACT = 'N', then AF is an output argument and on exit
            returns the factors L and U from the factorization A = P*L*U
            of the original matrix A.

            If FACT = 'E', then AF is an output argument and on exit
            returns the factors L and U from the factorization A = P*L*U
            of the equilibrated matrix A (see the description of A for
            the form of the equilibrated matrix).

    LDAF    (input) INTEGER
            The leading dimension of the array AF.  LDAF >= max(1,N).

    IPIV    (input or output) INTEGER array, dimension (N)
            If FACT = 'F', then IPIV is an input argument and on entry
            contains the pivot indices from the factorization A = P*L*U
            as computed by DGETRF; row i of the matrix was interchanged
            with row IPIV(i).

            If FACT = 'N', then IPIV is an output argument and on exit
            contains the pivot indices from the factorization A = P*L*U
            of the original matrix A.

            If FACT = 'E', then IPIV is an output argument and on exit
            contains the pivot indices from the factorization A = P*L*U
            of the equilibrated matrix A.

    EQUED   (input or output) CHARACTER*1
            Specifies the form of equilibration that was done.
            = 'N':  No equilibration (always true if FACT = 'N').
            = 'R':  Row equilibration, i.e., A has been premultiplied by
                    diag(R).
            = 'C':  Column equilibration, i.e., A has been postmultiplied
                    by diag(C).
            = 'B':  Both row and column equilibration, i.e., A has been
                    replaced by diag(R) * A * diag(C).
            EQUED is an input argument if FACT = 'F'; otherwise, it is an
            output argument.

    R       (input or output) DOUBLE PRECISION array, dimension (N)
            The row scale factors for A.  If EQUED = 'R' or 'B', A is
            multiplied on the left by diag(R); if EQUED = 'N' or 'C', R
            is not accessed.  R is an input argument if FACT = 'F';
            otherwise, R is an output argument.  If FACT = 'F' and
            EQUED = 'R' or 'B', each element of R must be positive.

    C       (input or output) DOUBLE PRECISION array, dimension (N)
            The column scale factors for A.  If EQUED = 'C' or 'B', A is
            multiplied on the right by diag(C); if EQUED = 'N' or 'R', C
            is not accessed.  C is an input argument if FACT = 'F';
            otherwise, C is an output argument.  If FACT = 'F' and
            EQUED = 'C' or 'B', each element of C must be positive.

    B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
            On entry, the N-by-NRHS right hand side matrix B.
            On exit,
            if EQUED = 'N', B is not modified;
            if TRANS = 'N' and EQUED = 'R' or 'B', B is overwritten by
            diag(R)*B;
            if TRANS = 'T' or 'C' and EQUED = 'C' or 'B', B is
            overwritten by diag(C)*B.

    LDB     (input) INTEGER
            The leading dimension of the array B.  LDB >= max(1,N).

    X       (output) DOUBLE PRECISION array, dimension (LDX,NRHS)
            If INFO = 0 or INFO = N+1, the N-by-NRHS solution matrix X
            to the original system of equations.  Note that A and B are
            modified on exit if EQUED .ne. 'N', and the solution to the
            equilibrated system is inv(diag(C))*X if TRANS = 'N' and
            EQUED = 'C' or 'B', or inv(diag(R))*X if TRANS = 'T' or 'C'
            and EQUED = 'R' or 'B'.

    LDX     (input) INTEGER
            The leading dimension of the array X.  LDX >= max(1,N).

    RCOND   (output) DOUBLE PRECISION
            The estimate of the reciprocal condition number of the matrix
            A after equilibration (if done).  If RCOND is less than the
            machine precision (in particular, if RCOND = 0), the matrix
            is singular to working precision.  This condition is
            indicated by a return code of INFO > 0.

    FERR    (output) DOUBLE PRECISION array, dimension (NRHS)
            The estimated forward error bound for each solution vector
            X(j) (the j-th column of the solution matrix X).
            If XTRUE is the true solution corresponding to X(j), FERR(j)
            is an estimated upper bound for the magnitude of the largest
            element in (X(j) - XTRUE) divided by the magnitude of the
            largest element in X(j).  The estimate is as reliable as
            the estimate for RCOND, and is almost always a slight
            overestimate of the true error.

    BERR    (output) DOUBLE PRECISION array, dimension (NRHS)
            The componentwise relative backward error of each solution
            vector X(j) (i.e., the smallest relative change in
            any element of A or B that makes X(j) an exact solution).

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (4*N)
            On exit, WORK(1) contains the reciprocal pivot growth
            factor norm(A)/norm(U). The \"max absolute element\" norm is
            used. If WORK(1) is much less than 1, then the stability
            of the LU factorization of the (equilibrated) matrix A
            could be poor. This also means that the solution X, condition
            estimator RCOND, and forward error bound FERR could be
            unreliable. If factorization fails with 0<INFO<=N, then
            WORK(1) contains the reciprocal pivot growth factor for the
            leading INFO columns of A.

    IWORK   (workspace) INTEGER array, dimension (N)

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
            > 0:  if INFO = i, and i is
                  <= N:  U(i,i) is exactly zero.  The factorization has
                         been completed, but the factor U is exactly
                         singular, so the solution and error bounds
                         could not be computed. RCOND = 0 is returned.
                  = N+1: U is nonsingular, but RCOND is less than machine
                         precision, meaning that the matrix is singular
                         to working precision.  Nevertheless, the
                         solution and error bounds are computed because
                         there are a number of situations where the
                         computed solution can be more accurate than the
                         value of RCOND would suggest.
"));
    end dgesvx;

    pure function dtrsyl
      "Solve the real Sylvester matrix equation op(A)*X + X*op(B) = scale*C or op(A)*X - X*op(B) = scale*C"
      extends Modelica.Icons.Function;

      input Real A[:, :] "Upper quasi-triangular matrix";
      input Real B[:, :] "Upper quasi-triangular matrix";
      input Real C[if tranA then size(A, 1) else size(A, 2), if tranB then size(
        B, 1) else size(B, 2)] "Right side of the Sylvester equation";

      input Boolean tranA=false "= true, if op(A)=A'";
      input Boolean tranB=false "= true, if op(B)=B'";
      input Integer isgn=1 "Specifies the sign in the equation, +1 or -1";
      output Real X[size(C, 1), size(C, 2)]=C
        "Solution of the Sylvester equation";
      output Real scale "Scale factor";
      output Integer info;
    protected
      Integer m=if tranA then size(A, 1) else size(A, 2);
      Integer n=if tranB then size(B, 1) else size(B, 2);
      String trana=if tranA then "T" else "N";
      String tranb=if tranB then "T" else "N";
      Integer lda=max(1, m);
      Integer ldb=max(1, n);

    external"FORTRAN 77" dtrsyl(
              trana,
              tranb,
              isgn,
              m,
              n,
              A,
              lda,
              B,
              ldb,
              X,
              lda,
              scale,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DTRSYL solves the real Sylvester matrix equation:

       op(A)*X + X*op(B) = scale*C or
       op(A)*X - X*op(B) = scale*C,

    where op(A) = A or A**T, and  A and B are both upper quasi-
    triangular. A is M-by-M and B is N-by-N; the right hand side C and
    the solution X are M-by-N; and scale is an output scale factor, set
    <= 1 to avoid overflow in X.

    A and B must be in Schur canonical form (as returned by DHSEQR), that
    is, block upper triangular with 1-by-1 and 2-by-2 diagonal blocks;
    each 2-by-2 diagonal block has its diagonal elements equal and its
    off-diagonal elements of opposite sign.

    Arguments
    =========

    TRANA   (input) CHARACTER*1
            Specifies the option op(A):
            = 'N': op(A) = A    (No transpose)
            = 'T': op(A) = A**T (Transpose)
            = 'C': op(A) = A**H (Conjugate transpose = Transpose)

    TRANB   (input) CHARACTER*1
            Specifies the option op(B):
            = 'N': op(B) = B    (No transpose)
            = 'T': op(B) = B**T (Transpose)
            = 'C': op(B) = B**H (Conjugate transpose = Transpose)

    ISGN    (input) INTEGER
            Specifies the sign in the equation:
            = +1: solve op(A)*X + X*op(B) = scale*C
            = -1: solve op(A)*X - X*op(B) = scale*C

    M       (input) INTEGER
            The order of the matrix A, and the number of rows in the
            matrices X and C. M >= 0.

    N       (input) INTEGER
            The order of the matrix B, and the number of columns in the
            matrices X and C. N >= 0.

    A       (input) DOUBLE PRECISION array, dimension (LDA,M)
            The upper quasi-triangular matrix A, in Schur canonical form.

    LDA     (input) INTEGER
            The leading dimension of the array A. LDA >= max(1,M).

    B       (input) DOUBLE PRECISION array, dimension (LDB,N)
            The upper quasi-triangular matrix B, in Schur canonical form.

    LDB     (input) INTEGER
            The leading dimension of the array B. LDB >= max(1,N).

    C       (input/output) DOUBLE PRECISION array, dimension (LDC,N)
            On entry, the M-by-N right hand side matrix C.
            On exit, C is overwritten by the solution matrix X.

    LDC     (input) INTEGER
            The leading dimension of the array C. LDC >= max(1,M)

    SCALE   (output) DOUBLE PRECISION
            The scale factor, scale, set <= 1 to avoid overflow in X.

    INFO    (output) INTEGER
            = 0: successful exit
            < 0: if INFO = -i, the i-th argument had an illegal value
            = 1: A and B have common or very close eigenvalues; perturbed
                 values were used to solve the equation (but the matrices
                 A and B are unchanged).
"));
    end dtrsyl;

    pure function dhseqr
      "Compute eigenvalues of a matrix H using lapack routine DHSEQR for Hessenberg form matrix"
      extends Modelica.Icons.Function;

      input Real H[:, size(H, 1)] "Matrix H with Hessenberg form";
      input Boolean eigenValuesOnly=true
        "= true, if only eigenvalues are computed, otherwise compute the Schur form too";
      input String compz="N" "Specifies the computation of the Schur vectors";
      input Real Z[:, :]=H "Matrix Z";
      output Real alphaReal[size(H, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      output Real alphaImag[size(H, 1)]
        "Imaginary part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      output Integer info;
      output Real Ho[:, :]=H
        "Schur decomposition (if eigenValuesOnly==false, unspecified else)";
      output Real Zo[:, :]=Z;
      output Real work[3*max(1, size(H, 1))];

    protected
      Integer n=size(H, 1);
      String job=if eigenValuesOnly then "E" else "S";
      Integer ilo=1;
      Integer ihi=n;
      Integer ldh=max(n, 1);
      Integer lwork=3*max(1, size(H, 1))
        "Dimension of the dwork array used in dhseqr";

    external"FORTRAN 77" dhseqr(
              job,
              compz,
              n,
              ilo,
              ihi,
              Ho,
              ldh,
              alphaReal,
              alphaImag,
              Zo,
              ldh,
              work,
              lwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DHSEQR computes the eigenvalues of a Hessenberg matrix H
    and, optionally, the matrices T and Z from the Schur decomposition
    H = Z T Z**T, where T is an upper quasi-triangular matrix (the
    Schur form), and Z is the orthogonal matrix of Schur vectors.

    Optionally Z may be postmultiplied into an input orthogonal
    matrix Q so that this routine can give the Schur factorization
    of a matrix A which has been reduced to the Hessenberg form H
    by the orthogonal matrix Q:  A = Q*H*Q**T = (QZ)*T*(QZ)**T.

    Arguments
    =========

    JOB   (input) CHARACTER*1
          = 'E':  compute eigenvalues only;
          = 'S':  compute eigenvalues and the Schur form T.

    COMPZ (input) CHARACTER*1
          = 'N':  no Schur vectors are computed;
          = 'I':  Z is initialized to the unit matrix and the matrix Z
                  of Schur vectors of H is returned;
          = 'V':  Z must contain an orthogonal matrix Q on entry, and
                  the product Q*Z is returned.

    N     (input) INTEGER
          The order of the matrix H.  N >= 0.

    ILO   (input) INTEGER
    IHI   (input) INTEGER
          It is assumed that H is already upper triangular in rows
          and columns 1:ILO-1 and IHI+1:N. ILO and IHI are normally
          set by a previous call to DGEBAL, and then passed to DGEHRD
          when the matrix output by DGEBAL is reduced to Hessenberg
          form. Otherwise ILO and IHI should be set to 1 and N
          respectively.  If N>0, then 1<=ILO<=IHI<=N.
          If N = 0, then ILO = 1 and IHI = 0.

    H     (input/output) DOUBLE PRECISION array, dimension (LDH,N)
          On entry, the upper Hessenberg matrix H.
          On exit, if INFO = 0 and JOB = 'S', then H contains the
          upper quasi-triangular matrix T from the Schur decomposition
          (the Schur form); 2-by-2 diagonal blocks (corresponding to
          complex conjugate pairs of eigenvalues) are returned in
          standard form, with H(i,i) = H(i+1,i+1) and
          H(i+1,i)*H(i,i+1)<0. If INFO = 0 and JOB = 'E', the
          contents of H are unspecified on exit.  (The output value of
          H when INFO>0 is given under the description of INFO
          below.)

          Unlike earlier versions of DHSEQR, this subroutine may
          explicitly H(i,j) = 0 for i>j and j = 1, 2, ... ILO-1
          or j = IHI+1, IHI+2, ... N.

    LDH   (input) INTEGER
          The leading dimension of the array H. LDH >= max(1,N).

    WR    (output) DOUBLE PRECISION array, dimension (N)
    WI    (output) DOUBLE PRECISION array, dimension (N)
          The real and imaginary parts, respectively, of the computed
          eigenvalues. If two eigenvalues are computed as a complex
          conjugate pair, they are stored in consecutive elements of
          WR and WI, say the i-th and (i+1)th, with WI(i) > 0 and
          WI(i+1) < 0. If JOB = 'S', the eigenvalues are stored in
          the same order as on the diagonal of the Schur form returned
          in H, with WR(i) = H(i,i) and, if H(i:i+1,i:i+1) is a 2-by-2
          diagonal block, WI(i) = sqrt(-H(i+1,i)*H(i,i+1)) and
          WI(i+1) = -WI(i).

    Z     (input/output) DOUBLE PRECISION array, dimension (LDZ,N)
          If COMPZ = 'N', Z is not referenced.
          If COMPZ = 'I', on entry Z need not be set and on exit,
          if INFO = 0, Z contains the orthogonal matrix Z of the Schur
          vectors of H.  If COMPZ = 'V', on entry Z must contain an
          N-by-N matrix Q, which is assumed to be equal to the unit
          matrix except for the submatrix Z(ILO:IHI,ILO:IHI). On exit,
          if INFO = 0, Z contains Q*Z.
          Normally Q is the orthogonal matrix generated by DORGHR
          after the call to DGEHRD which formed the Hessenberg matrix
          H. (The output value of Z when INFO>0 is given under
          the description of INFO below.)

    LDZ   (input) INTEGER
          The leading dimension of the array Z.  if COMPZ = 'I' or
          COMPZ = 'V', then LDZ>=MAX(1,N).  Otherwise, LDZ>=1.

    WORK  (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
          On exit, if INFO = 0, WORK(1) returns an estimate of
          the optimal value for LWORK.

    LWORK (input) INTEGER
          The dimension of the array WORK.  LWORK >= max(1,N)
          is sufficient and delivers very good and sometimes
          optimal performance.  However, LWORK as large as 11*N
          may be required for optimal performance.  A workspace
          query is recommended to determine the optimal workspace
          size.

          If LWORK = -1, then DHSEQR does a workspace query.
          In this case, DHSEQR checks the input parameters and
          estimates the optimal workspace size for the given
          values of N, ILO and IHI.  The estimate is returned
          in WORK(1).  No error message related to LWORK is
          issued by XERBLA.  Neither H nor Z are accessed.

    INFO  (output) INTEGER
          = 0: successful exit
          < 0: if INFO = -i, the i-th argument had an illegal
               value
          > 0: if INFO = i, DHSEQR failed to compute all of
               the eigenvalues.  Elements 1:ilo-1 and i+1:n of WR
               and WI contain those eigenvalues which have been
               successfully computed.  (Failures are rare.)

               If INFO > 0 and JOB = 'E', then on exit, the
               remaining unconverged eigenvalues are the eigen-
               values of the upper Hessenberg matrix rows and
               columns ILO through INFO of the final, output
               value of H.

               If INFO > 0 and JOB   = 'S', then on exit

          (*)  (initial value of H)*U  = U*(final value of H)

               where U is an orthogonal matrix.  The final
               value of H is upper Hessenberg and quasi-triangular
               in rows and columns INFO+1 through IHI.

               If INFO > 0 and COMPZ = 'V', then on exit

                 (final value of Z)  =  (initial value of Z)*U

               where U is the orthogonal matrix in (*) (regard-
               less of the value of JOB.)

               If INFO > 0 and COMPZ = 'I', then on exit
                     (final value of Z)  = U
               where U is the orthogonal matrix in (*) (regard-
               less of the value of JOB.)

               If INFO > 0 and COMPZ = 'N', then Z is not
               accessed.
"));
    end dhseqr;

    pure function dlange "Norm of a matrix"
      extends Modelica.Icons.Function;

      input Real A[:, :] "Real matrix A";
      input String norm="1" "Specifies the norm, i.e., 1, I, F, M";
      output Real anorm "Norm of A";
    protected
      Integer m=size(A, 1);
      Integer n=size(A, 2);
      Integer lda=max(1, size(A, 1));
      Real work[lda];

    external"FORTRAN 77" anorm = dlange(
              norm,
              m,
              n,
              A,
              lda,
              work) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DLANGE  returns the value of the one norm,  or the Frobenius norm, or
    the  infinity norm,  or the  element of  largest absolute value  of a
    real matrix A.

    Description
    ===========

    DLANGE returns the value

       DLANGE = ( max(abs(A(i,j))), NORM = 'M' or 'm'
                (
                ( norm1(A),         NORM = '1', 'O' or 'o'
                (
                ( normI(A),         NORM = 'I' or 'i'
                (
                ( normF(A),         NORM = 'F', 'f', 'E' or 'e'

    where  norm1  denotes the  one norm of a matrix (maximum column sum),
    normI  denotes the  infinity norm  of a matrix  (maximum row sum) and
    normF  denotes the  Frobenius norm of a matrix (square root of sum of
    squares).  Note that  max(abs(A(i,j)))  is not a consistent matrix norm.

    Arguments
    =========

    NORM    (input) CHARACTER*1
            Specifies the value to be returned in DLANGE as described
            above.

    M       (input) INTEGER
            The number of rows of the matrix A.  M >= 0.  When M = 0,
            DLANGE is set to zero.

    N       (input) INTEGER
            The number of columns of the matrix A.  N >= 0.  When N = 0,
            DLANGE is set to zero.

    A       (input) DOUBLE PRECISION array, dimension (LDA,N)
            The m by n matrix A.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(M,1).

    WORK    (workspace) DOUBLE PRECISION array, dimension (MAX(1,LWORK)),
            where LWORK >= M when NORM = 'I'; otherwise, WORK is not
            referenced.
"));

    end dlange;

    pure function dgecon
      "Estimate the reciprocal of the condition number of a general real matrix A"
      extends Modelica.Icons.Function;

      input Real LU_of_A[:, :] "LU factorization of a real matrix A";
      input Boolean inf=false
        "Is true if infinity norm is used and false for 1-norm";
      input Real anorm "Norm of A";
      output Real rcond "Reciprocal condition number of A";
      output Integer info;
    protected
      Integer n=size(LU_of_A, 2);
      Integer lda=max(1, size(LU_of_A, 1));
      Real work[4*size(LU_of_A, 2)];
      Integer iwork[size(LU_of_A, 2)];
      String norm=if inf then "I" else "1";

    external"FORTRAN 77" dgecon(
              norm,
              n,
              LU_of_A,
              lda,
              anorm,
              rcond,
              work,
              iwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGECON estimates the reciprocal of the condition number of a general
    real matrix A, in either the 1-norm or the infinity-norm, using
    the LU factorization computed by DGETRF.

    An estimate is obtained for norm(inv(A)), and the reciprocal of the
    condition number is computed as
       RCOND = 1 / ( norm(A) * norm(inv(A)) ).

    Arguments
    =========

    NORM    (input) CHARACTER*1
            Specifies whether the 1-norm condition number or the
            infinity-norm condition number is required:
            = '1' or 'O':  1-norm;
            = 'I':         Infinity-norm.

    N       (input) INTEGER
            The order of the matrix A.  N >= 0.

    A       (input) DOUBLE PRECISION array, dimension (LDA,N)
            The factors L and U from the factorization A = P*L*U
            as computed by DGETRF.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    ANORM   (input) DOUBLE PRECISION
            If NORM = '1' or 'O', the 1-norm of the original matrix A.
            If NORM = 'I', the infinity-norm of the original matrix A.

    RCOND   (output) DOUBLE PRECISION
            The reciprocal of the condition number of the matrix A,
            computed as RCOND = 1/(norm(A) * norm(inv(A))).

    WORK    (workspace) DOUBLE PRECISION array, dimension (4*N)

    IWORK   (workspace) INTEGER array, dimension (N)

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
"));
    end dgecon;

    pure function dgehrd
      "Reduce a real general matrix A to upper Hessenberg form H by an orthogonal similarity transformation:  Q' * A * Q = H"
      extends Modelica.Icons.Function;

      input Real A[:, size(A, 1)];
      input Integer ilo=1
        "Lowest index where the original matrix is not in upper triangular form";
      input Integer ihi=size(A, 1)
        "Highest index where the original matrix is not in upper triangular form";
      output Real Aout[size(A, 1), size(A, 2)]=A
        "Contains the Hessenberg form in the upper triangle and the first subdiagonal and below the first subdiagonal it contains the elementary reflectors which represents (with array tau) as a product the orthogonal matrix Q";
      output Real tau[max(size(A, 1), 1) - 1]
        "Scalar factors of the elementary reflectors";
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lda=max(1, n);
      Integer lwork=max(1, 3*n);
      Real work[max(1, 3*size(A, 1))];

    external"FORTRAN 77" dgehrd(
              n,
              ilo,
              ihi,
              Aout,
              lda,
              tau,
              work,
              lwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGEHRD reduces a real general matrix A to upper Hessenberg form H by
    an orthogonal similarity transformation:  Q' * A * Q = H .

    Arguments
    =========

    N       (input) INTEGER
            The order of the matrix A.  N >= 0.

    ILO     (input) INTEGER
    IHI     (input) INTEGER
            It is assumed that A is already upper triangular in rows
            and columns 1:ILO-1 and IHI+1:N. ILO and IHI are normally
            set by a previous call to DGEBAL; otherwise they should be
            set to 1 and N respectively. See Further Details.
            1 <= ILO <= IHI <= N, if N > 0; ILO=1 and IHI=0, if N=0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the N-by-N general matrix to be reduced.
            On exit, the upper triangle and the first subdiagonal of A
            are overwritten with the upper Hessenberg matrix H, and the
            elements below the first subdiagonal, with the array TAU,
            represent the orthogonal matrix Q as a product of elementary
            reflectors. See Further Details.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    TAU     (output) DOUBLE PRECISION array, dimension (N-1)
            The scalar factors of the elementary reflectors (see Further
            Details). Elements 1:ILO-1 and IHI:N-1 of TAU are set to
            zero.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The length of the array WORK.  LWORK >= max(1,N).
            For optimum performance LWORK >= N*NB, where NB is the
            optimal blocksize.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value.

    Further Details
    ===============

    The matrix Q is represented as a product of (ihi-ilo) elementary
    reflectors

       Q = H(ilo) H(ilo+1) . . . H(ihi-1).

    Each H(i) has the form

       H(i) = I - tau * v * v'

    where tau is a real scalar, and v is a real vector with
    v(1:i) = 0, v(i+1) = 1 and v(ihi+1:n) = 0; v(i+2:ihi) is stored on
    exit in A(i+2:ihi,i), and tau in TAU(i).

    The contents of A are illustrated by the following example, with
    n = 7, ilo = 2 and ihi = 6:

    on entry,                        on exit,

    ( a   a   a   a   a   a   a )    (  a   a   h   h   h   h   a )
    (     a   a   a   a   a   a )    (      a   h   h   h   h   a )
    (     a   a   a   a   a   a )    (      h   h   h   h   h   h )
    (     a   a   a   a   a   a )    (      v2  h   h   h   h   h )
    (     a   a   a   a   a   a )    (      v2  v3  h   h   h   h )
    (     a   a   a   a   a   a )    (      v2  v3  v4  h   h   h )
    (                         a )    (                          a )

    where a denotes an element of the original matrix A, h denotes a
    modified element of the upper Hessenberg matrix H, and vi denotes an
    element of the vector defining H(i).
"));
    end dgehrd;

    pure function dgeqrf "Compute a QR factorization without pivoting"
      extends Modelica.Icons.Function;

      input Real A[:, :] "Square or rectangular matrix";
      output Real Aout[size(A, 1), size(A, 2)]=A
        "The upper triangle of the array contains the upper trapezoidal matrix R; the elements below the diagonal, together with the array TAU, represent the orthogonal matrix Q as a product of elementary reflectors";
      output Real tau[min(size(A, 1), size(A, 2))]
        "Scalar factors of the elementary reflectors";
      output Integer info;
      output Real work[3*max(1, size(A, 2))];
    protected
      Integer m=size(A, 1);
      Integer n=size(A, 2);
      Integer lda=max(1, m);
      Integer lwork=3*max(1, n);

    external"FORTRAN 77" dgeqrf(
              m,
              n,
              Aout,
              lda,
              tau,
              work,
              lwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGEQRF computes a QR factorization of a real M-by-N matrix A:
    A = Q * R.

    Arguments
    =========

    M       (input) INTEGER
            The number of rows of the matrix A.  M >= 0.

    N       (input) INTEGER
            The number of columns of the matrix A.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the M-by-N matrix A.
            On exit, the elements on and above the diagonal of the array
            contain the min(M,N)-by-N upper trapezoidal matrix R (R is
            upper triangular if m >= n); the elements below the diagonal,
            with the array TAU, represent the orthogonal matrix Q as a
            product of min(m,n) elementary reflectors (see Further
            Details).

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,M).

    TAU     (output) DOUBLE PRECISION array, dimension (min(M,N))
            The scalar factors of the elementary reflectors (see Further
            Details).

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.  LWORK >= max(1,N).
            For optimum performance LWORK >= N*NB, where NB is
            the optimal blocksize.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value

    Further Details
    ===============

    The matrix Q is represented as a product of elementary reflectors

       Q = H(1) H(2) . . . H(k), where k = min(m,n).

    Each H(i) has the form

       H(i) = I - tau * v * v'

    where tau is a real scalar, and v is a real vector with
    v(1:i-1) = 0 and v(i) = 1; v(i+1:m) is stored on exit in A(i+1:m,i),
    and tau in TAU(i).
"));
    end dgeqrf;

    pure function dgeevx
      "Compute the eigenvalues and the (real) left and right eigenvectors of matrix A, using lapack routine dgeevx"
      extends Modelica.Icons.Function;

      input Real A[:, size(A, 1)];
      output Real alphaReal[size(A, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      output Real alphaImag[size(A, 1)]
        "Imaginary part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      output Real lEigenVectors[size(A, 1), size(A, 1)]
        "Left eigenvectors of matrix A";
      output Real rEigenVectors[size(A, 1), size(A, 1)]
        "Right eigenvectors of matrix A";
      output Real AS[size(A, 1), size(A, 2)]=A
        "AS is the real Schur form of the balanced version of the input matrix A";
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer ilo;
      Integer ihi;
      Real scale[size(A, 1)];
      Real abnrm;
      Real rconde[size(A, 1)];
      Real rcondv[size(A, 1)];
      Integer lwork=n*(n + 6);
      Real work[size(A, 1)*(size(A, 1) + 6)];
      Integer iwork[1];

    external"FORTRAN 77" dgeevx(
              "B",
              "V",
              "V",
              "E",
              n,
              AS,
              n,
              alphaReal,
              alphaImag,
              lEigenVectors,
              n,
              rEigenVectors,
              n,
              ilo,
              ihi,
              scale,
              abnrm,
              rconde,
              rcondv,
              work,
              lwork,
              iwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGEEVX computes for an N-by-N real nonsymmetric matrix A, the
    eigenvalues and, optionally, the left and/or right eigenvectors.

    Optionally also, it computes a balancing transformation to improve
    the conditioning of the eigenvalues and eigenvectors (ILO, IHI,
    SCALE, and ABNRM), reciprocal condition numbers for the eigenvalues
    (RCONDE), and reciprocal condition numbers for the right
    eigenvectors (RCONDV).

    The right eigenvector v(j) of A satisfies
                     A * v(j) = lambda(j) * v(j)
    where lambda(j) is its eigenvalue.
    The left eigenvector u(j) of A satisfies
                  u(j)**H * A = lambda(j) * u(j)**H
    where u(j)**H denotes the conjugate transpose of u(j).

    The computed eigenvectors are normalized to have Euclidean norm
    equal to 1 and largest component real.

    Balancing a matrix means permuting the rows and columns to make it
    more nearly upper triangular, and applying a diagonal similarity
    transformation D * A * D**(-1), where D is a diagonal matrix, to
    make its rows and columns closer in norm and the condition numbers
    of its eigenvalues and eigenvectors smaller.  The computed
    reciprocal condition numbers correspond to the balanced matrix.
    Permuting rows and columns will not change the condition numbers
    (in exact arithmetic) but diagonal scaling will.  For further
    explanation of balancing, see section 4.10.2 of the LAPACK
    Users' Guide.

    Arguments
    =========

    BALANC  (input) CHARACTER*1
            Indicates how the input matrix should be diagonally scaled
            and/or permuted to improve the conditioning of its
            eigenvalues.
            = 'N': Do not diagonally scale or permute;
            = 'P': Perform permutations to make the matrix more nearly
                   upper triangular. Do not diagonally scale;
            = 'S': Diagonally scale the matrix, i.e. replace A by
                   D*A*D**(-1), where D is a diagonal matrix chosen
                   to make the rows and columns of A more equal in
                   norm. Do not permute;
            = 'B': Both diagonally scale and permute A.

            Computed reciprocal condition numbers will be for the matrix
            after balancing and/or permuting. Permuting does not change
            condition numbers (in exact arithmetic), but balancing does.

    JOBVL   (input) CHARACTER*1
            = 'N': left eigenvectors of A are not computed;
            = 'V': left eigenvectors of A are computed.
            If SENSE = 'E' or 'B', JOBVL must = 'V'.

    JOBVR   (input) CHARACTER*1
            = 'N': right eigenvectors of A are not computed;
            = 'V': right eigenvectors of A are computed.
            If SENSE = 'E' or 'B', JOBVR must = 'V'.

    SENSE   (input) CHARACTER*1
            Determines which reciprocal condition numbers are computed.
            = 'N': None are computed;
            = 'E': Computed for eigenvalues only;
            = 'V': Computed for right eigenvectors only;
            = 'B': Computed for eigenvalues and right eigenvectors.

            If SENSE = 'E' or 'B', both left and right eigenvectors
            must also be computed (JOBVL = 'V' and JOBVR = 'V').

    N       (input) INTEGER
            The order of the matrix A. N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the N-by-N matrix A.
            On exit, A has been overwritten.  If JOBVL = 'V' or
            JOBVR = 'V', A contains the real Schur form of the balanced
            version of the input matrix A.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    WR      (output) DOUBLE PRECISION array, dimension (N)
    WI      (output) DOUBLE PRECISION array, dimension (N)
            WR and WI contain the real and imaginary parts,
            respectively, of the computed eigenvalues.  Complex
            conjugate pairs of eigenvalues will appear consecutively
            with the eigenvalue having the positive imaginary part
            first.

    VL      (output) DOUBLE PRECISION array, dimension (LDVL,N)
            If JOBVL = 'V', the left eigenvectors u(j) are stored one
            after another in the columns of VL, in the same order
            as their eigenvalues.
            If JOBVL = 'N', VL is not referenced.
            If the j-th eigenvalue is real, then u(j) = VL(:,j),
            the j-th column of VL.
            If the j-th and (j+1)-st eigenvalues form a complex
            conjugate pair, then u(j) = VL(:,j) + i*VL(:,j+1) and
            u(j+1) = VL(:,j) - i*VL(:,j+1).

    LDVL    (input) INTEGER
            The leading dimension of the array VL.  LDVL >= 1; if
            JOBVL = 'V', LDVL >= N.

    VR      (output) DOUBLE PRECISION array, dimension (LDVR,N)
            If JOBVR = 'V', the right eigenvectors v(j) are stored one
            after another in the columns of VR, in the same order
            as their eigenvalues.
            If JOBVR = 'N', VR is not referenced.
            If the j-th eigenvalue is real, then v(j) = VR(:,j),
            the j-th column of VR.
            If the j-th and (j+1)-st eigenvalues form a complex
            conjugate pair, then v(j) = VR(:,j) + i*VR(:,j+1) and
            v(j+1) = VR(:,j) - i*VR(:,j+1).

    LDVR    (input) INTEGER
            The leading dimension of the array VR.  LDVR >= 1, and if
            JOBVR = 'V', LDVR >= N.

    ILO     (output) INTEGER
    IHI     (output) INTEGER
            ILO and IHI are integer values determined when A was
            balanced.  The balanced A(i,j) = 0 if I > J and
            J = 1,...,ILO-1 or I = IHI+1,...,N.

    SCALE   (output) DOUBLE PRECISION array, dimension (N)
            Details of the permutations and scaling factors applied
            when balancing A.  If P(j) is the index of the row and column
            interchanged with row and column j, and D(j) is the scaling
            factor applied to row and column j, then
            SCALE(J) = P(J),    for J = 1,...,ILO-1
                     = D(J),    for J = ILO,...,IHI
                     = P(J)     for J = IHI+1,...,N.
            The order in which the interchanges are made is N to IHI+1,
            then 1 to ILO-1.

    ABNRM   (output) DOUBLE PRECISION
            The one-norm of the balanced matrix (the maximum
            of the sum of absolute values of elements of any column).

    RCONDE  (output) DOUBLE PRECISION array, dimension (N)
            RCONDE(j) is the reciprocal condition number of the j-th
            eigenvalue.

    RCONDV  (output) DOUBLE PRECISION array, dimension (N)
            RCONDV(j) is the reciprocal condition number of the j-th
            right eigenvector.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.   If SENSE = 'N' or 'E',
            LWORK >= max(1,2*N), and if JOBVL = 'V' or JOBVR = 'V',
            LWORK >= 3*N.  If SENSE = 'V' or 'B', LWORK >= N*(N+6).
            For good performance, LWORK must generally be larger.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    IWORK   (workspace) INTEGER array, dimension (2*N-2)
            If SENSE = 'N' or 'E', not referenced.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            > 0:  if INFO = i, the QR algorithm failed to compute all the
                  eigenvalues, and no eigenvectors or condition numbers
                  have been computed; elements 1:ILO-1 and i+1:N of WR
                  and WI contain eigenvalues which have converged.
"));
    end dgeevx;

    pure function dgesdd "Determine singular value decomposition"
      extends Modelica.Icons.Function;
      input Real A[:, :];
      output Real sigma[min(size(A, 1), size(A, 2))];
      output Real U[size(A, 1), size(A, 1)]=zeros(size(A, 1), size(A, 1));
      output Real VT[size(A, 2), size(A, 2)]=zeros(size(A, 2), size(A, 2));
      output Integer info;
    protected
      Integer m=size(A, 1);
      Integer n=size(A, 2);
      Real Awork[size(A, 1), size(A, 2)]=A;
      Integer lda=max(1, size(A, 1));
      Integer ldu=max(1, size(A, 1));
      Integer ldvt=max(1, size(A, 2));
      Integer lwork=max(1, 3*(3*min(size(A, 1), size(A, 2))*min(size(A, 1),
          size(A, 2)) + max(max(size(A, 1), size(A, 2)), 4*min(size(A, 1), size(
          A, 2))*min(size(A, 1), size(A, 2)) + 4*min(size(A, 1), size(A, 2)))));
      Integer iwork=max(1, 8*min(size(A, 1), size(A, 2)));
      Real work[max(1, 3*(3*min(size(A, 1), size(A, 2))*min(size(A, 1), size(A,
        2)) + max(max(size(A, 1), size(A, 2)), 4*min(size(A, 1), size(A, 2))*
        min(size(A, 1), size(A, 2)) + 4*min(size(A, 1), size(A, 2)))))];

    external"FORTRAN 77" dgesdd(
              "A",
              m,
              n,
              Awork,
              lda,
              sigma,
              U,
              ldu,
              VT,
              ldvt,
              work,
              lwork,
              iwork,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGESDD computes the singular value decomposition (SVD) of a real
    M-by-N matrix A, optionally computing the left and right singular
    vectors.  If singular vectors are desired, it uses a
    divide-and-conquer algorithm.

    The SVD is written

         A = U * SIGMA * transpose(V)

    where SIGMA is an M-by-N matrix which is zero except for its
    min(m,n) diagonal elements, U is an M-by-M orthogonal matrix, and
    V is an N-by-N orthogonal matrix.  The diagonal elements of SIGMA
    are the singular values of A; they are real and non-negative, and
    are returned in descending order.  The first min(m,n) columns of
    U and V are the left and right singular vectors of A.

    Note that the routine returns VT = V**T, not V.

    The divide and conquer algorithm makes very mild assumptions about
    floating point arithmetic. It will work on machines with a guard
    digit in add/subtract, or on those binary machines without guard
    digits which subtract like the Cray X-MP, Cray Y-MP, Cray C-90, or
    Cray-2. It could conceivably fail on hexadecimal or decimal machines
    without guard digits, but we know of none.

    Arguments
    =========

    JOBZ    (input) CHARACTER*1
            Specifies options for computing all or part of the matrix U:
            = 'A':  all M columns of U and all N rows of V**T are
                    returned in the arrays U and VT;
            = 'S':  the first min(M,N) columns of U and the first
                    min(M,N) rows of V**T are returned in the arrays U
                    and VT;
            = 'O':  If M >= N, the first N columns of U are overwritten
                    on the array A and all rows of V**T are returned in
                    the array VT;
                    otherwise, all columns of U are returned in the
                    array U and the first M rows of V**T are overwritten
                    in the array A;
            = 'N':  no columns of U or rows of V**T are computed.

    M       (input) INTEGER
            The number of rows of the input matrix A.  M >= 0.

    N       (input) INTEGER
            The number of columns of the input matrix A.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the M-by-N matrix A.
            On exit,
            if JOBZ = 'O',  A is overwritten with the first N columns
                            of U (the left singular vectors, stored
                            columnwise) if M >= N;
                            A is overwritten with the first M rows
                            of V**T (the right singular vectors, stored
                            rowwise) otherwise.
            if JOBZ .ne. 'O', the contents of A are destroyed.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,M).

    S       (output) DOUBLE PRECISION array, dimension (min(M,N))
            The singular values of A, sorted so that S(i) >= S(i+1).

    U       (output) DOUBLE PRECISION array, dimension (LDU,UCOL)
            UCOL = M if JOBZ = 'A' or JOBZ = 'O' and M < N;
            UCOL = min(M,N) if JOBZ = 'S'.
            If JOBZ = 'A' or JOBZ = 'O' and M < N, U contains the M-by-M
            orthogonal matrix U;
            if JOBZ = 'S', U contains the first min(M,N) columns of U
            (the left singular vectors, stored columnwise);
            if JOBZ = 'O' and M >= N, or JOBZ = 'N', U is not referenced.

    LDU     (input) INTEGER
            The leading dimension of the array U.  LDU >= 1; if
            JOBZ = 'S' or 'A' or JOBZ = 'O' and M < N, LDU >= M.

    VT      (output) DOUBLE PRECISION array, dimension (LDVT,N)
            If JOBZ = 'A' or JOBZ = 'O' and M >= N, VT contains the
            N-by-N orthogonal matrix V**T;
            if JOBZ = 'S', VT contains the first min(M,N) rows of
            V**T (the right singular vectors, stored rowwise);
            if JOBZ = 'O' and M < N, or JOBZ = 'N', VT is not referenced.

    LDVT    (input) INTEGER
            The leading dimension of the array VT.  LDVT >= 1; if
            JOBZ = 'A' or JOBZ = 'O' and M >= N, LDVT >= N;
            if JOBZ = 'S', LDVT >= min(M,N).

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK;

    LWORK   (input) INTEGER
            The dimension of the array WORK. LWORK >= 1.
            If JOBZ = 'N',
              LWORK >= 3*min(M,N) + max(max(M,N),7*min(M,N)).
            If JOBZ = 'O',
              LWORK >= 3*min(M,N) +
                       max(max(M,N),5*min(M,N)*min(M,N)+4*min(M,N)).
            If JOBZ = 'S' or 'A'
              LWORK >= 3*min(M,N) +
                       max(max(M,N),4*min(M,N)*min(M,N)+4*min(M,N)).
            For good performance, LWORK should generally be larger.
            If LWORK = -1 but other input arguments are legal, WORK(1)
            returns the optimal LWORK.

    IWORK   (workspace) INTEGER array, dimension (8*min(M,N))

    INFO    (output) INTEGER
            = 0:  successful exit.
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            > 0:  DBDSDC did not converge, updating process failed.

    Further Details
    ===============

    Based on contributions by
       Ming Gu and Huan Ren, Computer Science Division, University of
       California at Berkeley, USA
"));
    end dgesdd;

    pure function dggev
      "Compute generalized eigenvalues, as well as the left and right eigenvectors for a (A,B) system"
      extends Modelica.Icons.Function;

      input Real A[:, size(A, 1)];
      input Real B[size(A, 1), size(A, 1)];
      input Integer nA=size(A, 1)
        "The actual dimensions of matrices A and B (the computation is performed for A[1:nA,1:nA], B[1:nA,1:nA])";
      output Real alphaReal[size(A, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag)/beta)";
      output Real alphaImag[size(A, 1)] "Imaginary part of alpha";
      output Real beta[size(A, 1)] "Denominator of eigenvalue";
      output Real lEigenVectors[size(A, 1), size(A, 1)]
        "Left eigenvectors of matrix A";
      output Real rEigenVectors[size(A, 1), size(A, 1)]
        "Right eigenvectors of matrix A";

      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lwork=max(1, 8*n);
      Real Awork[size(A, 1), size(A, 1)]=A;
      Real Bwork[size(A, 1), size(A, 1)]=B;
      Real work[max(1, 8*size(A, 1))];
      Integer lda=max(1, n);

    external"FORTRAN 77" dggev(
              "V",
              "V",
              nA,
              Awork,
              lda,
              Bwork,
              lda,
              alphaReal,
              alphaImag,
              beta,
              lEigenVectors,
              lda,
              rEigenVectors,
              lda,
              work,
              lwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGGEV computes for a pair of N-by-N real nonsymmetric matrices (A,B)
    the generalized eigenvalues, and optionally, the left and/or right
    generalized eigenvectors.

    A generalized eigenvalue for a pair of matrices (A,B) is a scalar
    lambda or a ratio alpha/beta = lambda, such that A - lambda*B is
    singular. It is usually represented as the pair (alpha,beta), as
    there is a reasonable interpretation for beta=0, and even for both
    being zero.

    The right eigenvector v(j) corresponding to the eigenvalue lambda(j)
    of (A,B) satisfies

                     A * v(j) = lambda(j) * B * v(j).

    The left eigenvector u(j) corresponding to the eigenvalue lambda(j)
    of (A,B) satisfies

                     u(j)**H * A  = lambda(j) * u(j)**H * B .

    where u(j)**H is the conjugate-transpose of u(j).

    Arguments
    =========

    JOBVL   (input) CHARACTER*1
            = 'N':  do not compute the left generalized eigenvectors;
            = 'V':  compute the left generalized eigenvectors.

    JOBVR   (input) CHARACTER*1
            = 'N':  do not compute the right generalized eigenvectors;
            = 'V':  compute the right generalized eigenvectors.

    N       (input) INTEGER
            The order of the matrices A, B, VL, and VR.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA, N)
            On entry, the matrix A in the pair (A,B).
            On exit, A has been overwritten.

    LDA     (input) INTEGER
            The leading dimension of A.  LDA >= max(1,N).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB, N)
            On entry, the matrix B in the pair (A,B).
            On exit, B has been overwritten.

    LDB     (input) INTEGER
            The leading dimension of B.  LDB >= max(1,N).

    ALPHAR  (output) DOUBLE PRECISION array, dimension (N)
    ALPHAI  (output) DOUBLE PRECISION array, dimension (N)
    BETA    (output) DOUBLE PRECISION array, dimension (N)
            On exit, (ALPHAR(j) + ALPHAI(j)*i)/BETA(j), j=1,...,N, will
            be the generalized eigenvalues.  If ALPHAI(j) is zero, then
            the j-th eigenvalue is real; if positive, then the j-th and
            (j+1)-st eigenvalues are a complex conjugate pair, with
            ALPHAI(j+1) negative.

            Note: the quotients ALPHAR(j)/BETA(j) and ALPHAI(j)/BETA(j)
            may easily over- or underflow, and BETA(j) may even be zero.
            Thus, the user should avoid naively computing the ratio
            alpha/beta.  However, ALPHAR and ALPHAI will be always less
            than and usually comparable with norm(A) in magnitude, and
            BETA always less than and usually comparable with norm(B).

    VL      (output) DOUBLE PRECISION array, dimension (LDVL,N)
            If JOBVL = 'V', the left eigenvectors u(j) are stored one
            after another in the columns of VL, in the same order as
            their eigenvalues. If the j-th eigenvalue is real, then
            u(j) = VL(:,j), the j-th column of VL. If the j-th and
            (j+1)-th eigenvalues form a complex conjugate pair, then
            u(j) = VL(:,j)+i*VL(:,j+1) and u(j+1) = VL(:,j)-i*VL(:,j+1).
            Each eigenvector is scaled so the largest component has
            abs(real part)+abs(imag. part)=1.
            Not referenced if JOBVL = 'N'.

    LDVL    (input) INTEGER
            The leading dimension of the matrix VL. LDVL >= 1, and
            if JOBVL = 'V', LDVL >= N.

    VR      (output) DOUBLE PRECISION array, dimension (LDVR,N)
            If JOBVR = 'V', the right eigenvectors v(j) are stored one
            after another in the columns of VR, in the same order as
            their eigenvalues. If the j-th eigenvalue is real, then
            v(j) = VR(:,j), the j-th column of VR. If the j-th and
            (j+1)-th eigenvalues form a complex conjugate pair, then
            v(j) = VR(:,j)+i*VR(:,j+1) and v(j+1) = VR(:,j)-i*VR(:,j+1).
            Each eigenvector is scaled so the largest component has
            abs(real part)+abs(imag. part)=1.
            Not referenced if JOBVR = 'N'.

    LDVR    (input) INTEGER
            The leading dimension of the matrix VR. LDVR >= 1, and
            if JOBVR = 'V', LDVR >= N.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.  LWORK >= max(1,8*N).
            For good performance, LWORK must generally be larger.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            = 1,...,N:
                  The QZ iteration failed.  No eigenvectors have been
                  calculated, but ALPHAR(j), ALPHAI(j), and BETA(j)
                  should be correct for j=INFO+1,...,N.
            > N:  =N+1: other than QZ iteration failed in DHGEQZ.
                  =N+2: error return from DTGEVC.
"));
    end dggev;

    pure function dggevx
      "Compute generalized eigenvalues for a (A,B) system, using lapack routine dggevx"
      extends Modelica.Icons.Function;

      input Real A[:, size(A, 1)];
      input Real B[size(A, 1), size(A, 1)];
      output Real alphaReal[size(A, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag)/beta)";
      output Real alphaImag[size(A, 1)] "Imaginary part of alpha";
      output Real beta[size(A, 1)] "Denominator of eigenvalue";
      output Real lEigenVectors[size(A, 1), size(A, 1)]
        "Left eigenvectors of matrix A";
      output Real rEigenVectors[size(A, 1), size(A, 1)]
        "Right eigenvectors of matrix A";

      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lda=max(1, size(A, 1));
      Integer ilo;
      Integer ihi;
      Real lscale[size(A, 1)];
      Real rscale[size(A, 1)];
      Real abnrm;
      Real bbnrm;
      Real rconde[size(A, 1)];
      Real rcondv[size(A, 1)];
      Integer lwork=2*n*n + 12*n + 16;
      Real work[2*size(A, 1)*size(A, 1) + 12*size(A, 1) + 16];
      Integer iwork[size(A, 1) + 6];
      Integer bwork[size(A, 1)];

    external"FORTRAN 77" dggevx(
              "B",
              "V",
              "V",
              "B",
              n,
              A,
              lda,
              B,
              lda,
              alphaReal,
              alphaImag,
              beta,
              lEigenVectors,
              lda,
              rEigenVectors,
              lda,
              ilo,
              ihi,
              lscale,
              rscale,
              abnrm,
              bbnrm,
              rconde,
              rcondv,
              work,
              lwork,
              iwork,
              bwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DGGEVX computes for a pair of N-by-N real nonsymmetric matrices (A,B)
    the generalized eigenvalues, and optionally, the left and/or right
    generalized eigenvectors.

    Optionally also, it computes a balancing transformation to improve
    the conditioning of the eigenvalues and eigenvectors (ILO, IHI,
    LSCALE, RSCALE, ABNRM, and BBNRM), reciprocal condition numbers for
    the eigenvalues (RCONDE), and reciprocal condition numbers for the
    right eigenvectors (RCONDV).

    A generalized eigenvalue for a pair of matrices (A,B) is a scalar
    lambda or a ratio alpha/beta = lambda, such that A - lambda*B is
    singular. It is usually represented as the pair (alpha,beta), as
    there is a reasonable interpretation for beta=0, and even for both
    being zero.

    The right eigenvector v(j) corresponding to the eigenvalue lambda(j)
    of (A,B) satisfies

                     A * v(j) = lambda(j) * B * v(j) .

    The left eigenvector u(j) corresponding to the eigenvalue lambda(j)
    of (A,B) satisfies

                     u(j)**H * A  = lambda(j) * u(j)**H * B.

    where u(j)**H is the conjugate-transpose of u(j).

    Arguments
    =========

    BALANC  (input) CHARACTER*1
            Specifies the balance option to be performed.
            = 'N':  do not diagonally scale or permute;
            = 'P':  permute only;
            = 'S':  scale only;
            = 'B':  both permute and scale.
            Computed reciprocal condition numbers will be for the
            matrices after permuting and/or balancing. Permuting does
            not change condition numbers (in exact arithmetic), but
            balancing does.

    JOBVL   (input) CHARACTER*1
            = 'N':  do not compute the left generalized eigenvectors;
            = 'V':  compute the left generalized eigenvectors.

    JOBVR   (input) CHARACTER*1
            = 'N':  do not compute the right generalized eigenvectors;
            = 'V':  compute the right generalized eigenvectors.

    SENSE   (input) CHARACTER*1
            Determines which reciprocal condition numbers are computed.
            = 'N': none are computed;
            = 'E': computed for eigenvalues only;
            = 'V': computed for eigenvectors only;
            = 'B': computed for eigenvalues and eigenvectors.

    N       (input) INTEGER
            The order of the matrices A, B, VL, and VR.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA, N)
            On entry, the matrix A in the pair (A,B).
            On exit, A has been overwritten. If JOBVL='V' or JOBVR='V'
            or both, then A contains the first part of the real Schur
            form of the \"balanced\" versions of the input A and B.

    LDA     (input) INTEGER
            The leading dimension of A.  LDA >= max(1,N).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB, N)
            On entry, the matrix B in the pair (A,B).
            On exit, B has been overwritten. If JOBVL='V' or JOBVR='V'
            or both, then B contains the second part of the real Schur
            form of the \"balanced\" versions of the input A and B.

    LDB     (input) INTEGER
            The leading dimension of B.  LDB >= max(1,N).

    ALPHAR  (output) DOUBLE PRECISION array, dimension (N)
    ALPHAI  (output) DOUBLE PRECISION array, dimension (N)
    BETA    (output) DOUBLE PRECISION array, dimension (N)
            On exit, (ALPHAR(j) + ALPHAI(j)*i)/BETA(j), j=1,...,N, will
            be the generalized eigenvalues.  If ALPHAI(j) is zero, then
            the j-th eigenvalue is real; if positive, then the j-th and
            (j+1)-st eigenvalues are a complex conjugate pair, with
            ALPHAI(j+1) negative.

            Note: the quotients ALPHAR(j)/BETA(j) and ALPHAI(j)/BETA(j)
            may easily over- or underflow, and BETA(j) may even be zero.
            Thus, the user should avoid naively computing the ratio
            ALPHA/BETA. However, ALPHAR and ALPHAI will be always less
            than and usually comparable with norm(A) in magnitude, and
            BETA always less than and usually comparable with norm(B).

    VL      (output) DOUBLE PRECISION array, dimension (LDVL,N)
            If JOBVL = 'V', the left eigenvectors u(j) are stored one
            after another in the columns of VL, in the same order as
            their eigenvalues. If the j-th eigenvalue is real, then
            u(j) = VL(:,j), the j-th column of VL. If the j-th and
            (j+1)-th eigenvalues form a complex conjugate pair, then
            u(j) = VL(:,j)+i*VL(:,j+1) and u(j+1) = VL(:,j)-i*VL(:,j+1).
            Each eigenvector will be scaled so the largest component have
            abs(real part) + abs(imag. part) = 1.
            Not referenced if JOBVL = 'N'.

    LDVL    (input) INTEGER
            The leading dimension of the matrix VL. LDVL >= 1, and
            if JOBVL = 'V', LDVL >= N.

    VR      (output) DOUBLE PRECISION array, dimension (LDVR,N)
            If JOBVR = 'V', the right eigenvectors v(j) are stored one
            after another in the columns of VR, in the same order as
            their eigenvalues. If the j-th eigenvalue is real, then
            v(j) = VR(:,j), the j-th column of VR. If the j-th and
            (j+1)-th eigenvalues form a complex conjugate pair, then
            v(j) = VR(:,j)+i*VR(:,j+1) and v(j+1) = VR(:,j)-i*VR(:,j+1).
            Each eigenvector will be scaled so the largest component have
            abs(real part) + abs(imag. part) = 1.
            Not referenced if JOBVR = 'N'.

    LDVR    (input) INTEGER
            The leading dimension of the matrix VR. LDVR >= 1, and
            if JOBVR = 'V', LDVR >= N.

    ILO     (output) INTEGER
    IHI     (output) INTEGER
            ILO and IHI are integer values such that on exit
            A(i,j) = 0 and B(i,j) = 0 if i > j and
            j = 1,...,ILO-1 or i = IHI+1,...,N.
            If BALANC = 'N' or 'S', ILO = 1 and IHI = N.

    LSCALE  (output) DOUBLE PRECISION array, dimension (N)
            Details of the permutations and scaling factors applied
            to the left side of A and B.  If PL(j) is the index of the
            row interchanged with row j, and DL(j) is the scaling
            factor applied to row j, then
              LSCALE(j) = PL(j)  for j = 1,...,ILO-1
                        = DL(j)  for j = ILO,...,IHI
                        = PL(j)  for j = IHI+1,...,N.
            The order in which the interchanges are made is N to IHI+1,
            then 1 to ILO-1.

    RSCALE  (output) DOUBLE PRECISION array, dimension (N)
            Details of the permutations and scaling factors applied
            to the right side of A and B.  If PR(j) is the index of the
            column interchanged with column j, and DR(j) is the scaling
            factor applied to column j, then
              RSCALE(j) = PR(j)  for j = 1,...,ILO-1
                        = DR(j)  for j = ILO,...,IHI
                        = PR(j)  for j = IHI+1,...,N
            The order in which the interchanges are made is N to IHI+1,
            then 1 to ILO-1.

    ABNRM   (output) DOUBLE PRECISION
            The one-norm of the balanced matrix A.

    BBNRM   (output) DOUBLE PRECISION
            The one-norm of the balanced matrix B.

    RCONDE  (output) DOUBLE PRECISION array, dimension (N)
            If SENSE = 'E' or 'B', the reciprocal condition numbers of
            the eigenvalues, stored in consecutive elements of the array.
            For a complex conjugate pair of eigenvalues two consecutive
            elements of RCONDE are set to the same value. Thus RCONDE(j),
            RCONDV(j), and the j-th columns of VL and VR all correspond
            to the j-th eigenpair.
            If SENSE = 'N or 'V', RCONDE is not referenced.

    RCONDV  (output) DOUBLE PRECISION array, dimension (N)
            If SENSE = 'V' or 'B', the estimated reciprocal condition
            numbers of the eigenvectors, stored in consecutive elements
            of the array. For a complex eigenvector two consecutive
            elements of RCONDV are set to the same value. If the
            eigenvalues cannot be reordered to compute RCONDV(j),
            RCONDV(j) is set to 0; this can only occur when the true
            value would be very small anyway.
            If SENSE = 'N' or 'E', RCONDV is not referenced.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK. LWORK >= max(1,2*N).
            If BALANC = 'S' or 'B', or JOBVL = 'V', or JOBVR = 'V',
            LWORK >= max(1,6*N).
            If SENSE = 'E' or 'B', LWORK >= max(1,10*N).
            If SENSE = 'V' or 'B', LWORK >= 2*N*N+8*N+16.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    IWORK   (workspace) INTEGER array, dimension (N+6)
            If SENSE = 'E', IWORK is not referenced.

    BWORK   (workspace) LOGICAL array, dimension (N)
            If SENSE = 'N', BWORK is not referenced.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            = 1,...,N:
                  The QZ iteration failed.  No eigenvectors have been
                  calculated, but ALPHAR(j), ALPHAI(j), and BETA(j)
                  should be correct for j=INFO+1,...,N.
            > N:  =N+1: other than QZ iteration failed in DHGEQZ.
                  =N+2: error return from DTGEVC.

    Further Details
    ===============

    Balancing a matrix pair (A,B) includes, first, permuting rows and
    columns to isolate eigenvalues, second, applying diagonal similarity
    transformation to the rows and columns to make the rows and columns
    as close in norm as possible. The computed reciprocal condition
    numbers correspond to the balanced matrix. Permuting rows and columns
    will not change the condition numbers (in exact arithmetic) but
    diagonal scaling will.  For further explanation of balancing, see
    section 4.11.1.2 of LAPACK Users' Guide.

    An approximate error bound on the chordal distance between the i-th
    computed generalized eigenvalue w and the corresponding exact
    eigenvalue lambda is

         chord(w, lambda) <= EPS * norm(ABNRM, BBNRM) / RCONDE(I)

    An approximate error bound for the angle between the i-th computed
    eigenvector VL(i) or VR(i) is given by

         EPS * norm(ABNRM, BBNRM) / DIF(i).

    For further explanation of the reciprocal condition numbers RCONDE
    and RCONDV, see section 4.11 of LAPACK User's Guide.
"));
    end dggevx;

    pure function dhgeqz "Compute generalized eigenvalues for a (A,B) system"
      extends Modelica.Icons.Function;

      input Real A[:, size(A, 1)];
      input Real B[size(A, 1), size(A, 1)];
      output Real alphaReal[size(A, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag)/beta)";
      output Real alphaImag[size(A, 1)] "Imaginary part of alpha";
      output Real beta[size(A, 1)] "Denominator of eigenvalue";

      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer ilo=1;
      Integer ihi=n;
      Integer lwork=max(1, 3*n);
      Real work[max(1, 3*size(A, 1))];
      Real Awork[size(A, 1), size(A, 1)]=A;
      Real Bwork[size(A, 1), size(A, 1)]=B;
      Integer lda=max(1, n);
      Real Q[1, 1]=fill(
                0,
                1,
                n);

    external"FORTRAN 77" dhgeqz(
              "E",
              "N",
              "N",
              n,
              ilo,
              ihi,
              Awork,
              lda,
              Bwork,
              lda,
              alphaReal,
              alphaImag,
              beta,
              Q,
              1,
              Q,
              1,
              work,
              lwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DHGEQZ computes the eigenvalues of a real matrix pair (H,T),
    where H is an upper Hessenberg matrix and T is upper triangular,
    using the double-shift QZ method.
    Matrix pairs of this type are produced by the reduction to
    generalized upper Hessenberg form of a real matrix pair (A,B):

       A = Q1*H*Z1**T,  B = Q1*T*Z1**T,

    as computed by DGGHRD.

    If JOB='S', then the Hessenberg-triangular pair (H,T) is
    also reduced to generalized Schur form,

       H = Q*S*Z**T,  T = Q*P*Z**T,

    where Q and Z are orthogonal matrices, P is an upper triangular
    matrix, and S is a quasi-triangular matrix with 1-by-1 and 2-by-2
    diagonal blocks.

    The 1-by-1 blocks correspond to real eigenvalues of the matrix pair
    (H,T) and the 2-by-2 blocks correspond to complex conjugate pairs of
    eigenvalues.

    Additionally, the 2-by-2 upper triangular diagonal blocks of P
    corresponding to 2-by-2 blocks of S are reduced to positive diagonal
    form, i.e., if S(j+1,j) is non-zero, then P(j+1,j) = P(j,j+1) = 0,
    P(j,j) > 0, and P(j+1,j+1) > 0.

    Optionally, the orthogonal matrix Q from the generalized Schur
    factorization may be postmultiplied into an input matrix Q1, and the
    orthogonal matrix Z may be postmultiplied into an input matrix Z1.
    If Q1 and Z1 are the orthogonal matrices from DGGHRD that reduced
    the matrix pair (A,B) to generalized upper Hessenberg form, then the
    output matrices Q1*Q and Z1*Z are the orthogonal factors from the
    generalized Schur factorization of (A,B):

       A = (Q1*Q)*S*(Z1*Z)**T,  B = (Q1*Q)*P*(Z1*Z)**T.

    To avoid overflow, eigenvalues of the matrix pair (H,T) (equivalently,
    of (A,B)) are computed as a pair of values (alpha,beta), where alpha is
    complex and beta real.
    If beta is nonzero, lambda = alpha / beta is an eigenvalue of the
    generalized nonsymmetric eigenvalue problem (GNEP)
       A*x = lambda*B*x
    and if alpha is nonzero, mu = beta / alpha is an eigenvalue of the
    alternate form of the GNEP
       mu*A*y = B*y.
    Real eigenvalues can be read directly from the generalized Schur
    form:
      alpha = S(i,i), beta = P(i,i).

    Ref: C.B. Moler & G.W. Stewart, \"An Algorithm for Generalized Matrix
         Eigenvalue Problems\", SIAM J. Numer. Anal., 10(1973),
         pp. 241--256.

    Arguments
    =========

    JOB     (input) CHARACTER*1
            = 'E': Compute eigenvalues only;
            = 'S': Compute eigenvalues and the Schur form.

    COMPQ   (input) CHARACTER*1
            = 'N': Left Schur vectors (Q) are not computed;
            = 'I': Q is initialized to the unit matrix and the matrix Q
                   of left Schur vectors of (H,T) is returned;
            = 'V': Q must contain an orthogonal matrix Q1 on entry and
                   the product Q1*Q is returned.

    COMPZ   (input) CHARACTER*1
            = 'N': Right Schur vectors (Z) are not computed;
            = 'I': Z is initialized to the unit matrix and the matrix Z
                   of right Schur vectors of (H,T) is returned;
            = 'V': Z must contain an orthogonal matrix Z1 on entry and
                   the product Z1*Z is returned.

    N       (input) INTEGER
            The order of the matrices H, T, Q, and Z.  N >= 0.

    ILO     (input) INTEGER
    IHI     (input) INTEGER
            ILO and IHI mark the rows and columns of H which are in
            Hessenberg form.  It is assumed that A is already upper
            triangular in rows and columns 1:ILO-1 and IHI+1:N.
            If N > 0, 1 <= ILO <= IHI <= N; if N = 0, ILO=1 and IHI=0.

    H       (input/output) DOUBLE PRECISION array, dimension (LDH, N)
            On entry, the N-by-N upper Hessenberg matrix H.
            On exit, if JOB = 'S', H contains the upper quasi-triangular
            matrix S from the generalized Schur factorization;
            2-by-2 diagonal blocks (corresponding to complex conjugate
            pairs of eigenvalues) are returned in standard form, with
            H(i,i) = H(i+1,i+1) and H(i+1,i)*H(i,i+1) < 0.
            If JOB = 'E', the diagonal blocks of H match those of S, but
            the rest of H is unspecified.

    LDH     (input) INTEGER
            The leading dimension of the array H.  LDH >= max( 1, N ).

    T       (input/output) DOUBLE PRECISION array, dimension (LDT, N)
            On entry, the N-by-N upper triangular matrix T.
            On exit, if JOB = 'S', T contains the upper triangular
            matrix P from the generalized Schur factorization;
            2-by-2 diagonal blocks of P corresponding to 2-by-2 blocks of S
            are reduced to positive diagonal form, i.e., if H(j+1,j) is
            non-zero, then T(j+1,j) = T(j,j+1) = 0, T(j,j) > 0, and
            T(j+1,j+1) > 0.
            If JOB = 'E', the diagonal blocks of T match those of P, but
            the rest of T is unspecified.

    LDT     (input) INTEGER
            The leading dimension of the array T.  LDT >= max( 1, N ).

    ALPHAR  (output) DOUBLE PRECISION array, dimension (N)
            The real parts of each scalar alpha defining an eigenvalue
            of GNEP.

    ALPHAI  (output) DOUBLE PRECISION array, dimension (N)
            The imaginary parts of each scalar alpha defining an
            eigenvalue of GNEP.
            If ALPHAI(j) is zero, then the j-th eigenvalue is real; if
            positive, then the j-th and (j+1)-st eigenvalues are a
            complex conjugate pair, with ALPHAI(j+1) = -ALPHAI(j).

    BETA    (output) DOUBLE PRECISION array, dimension (N)
            The scalars beta that define the eigenvalues of GNEP.
            Together, the quantities alpha = (ALPHAR(j),ALPHAI(j)) and
            beta = BETA(j) represent the j-th eigenvalue of the matrix
            pair (A,B), in one of the forms lambda = alpha/beta or
            mu = beta/alpha.  Since either lambda or mu may overflow,
            they should not, in general, be computed.

    Q       (input/output) DOUBLE PRECISION array, dimension (LDQ, N)
            On entry, if COMPZ = 'V', the orthogonal matrix Q1 used in
            the reduction of (A,B) to generalized Hessenberg form.
            On exit, if COMPZ = 'I', the orthogonal matrix of left Schur
            vectors of (H,T), and if COMPZ = 'V', the orthogonal matrix
            of left Schur vectors of (A,B).
            Not referenced if COMPZ = 'N'.

    LDQ     (input) INTEGER
            The leading dimension of the array Q.  LDQ >= 1.
            If COMPQ='V' or 'I', then LDQ >= N.

    Z       (input/output) DOUBLE PRECISION array, dimension (LDZ, N)
            On entry, if COMPZ = 'V', the orthogonal matrix Z1 used in
            the reduction of (A,B) to generalized Hessenberg form.
            On exit, if COMPZ = 'I', the orthogonal matrix of
            right Schur vectors of (H,T), and if COMPZ = 'V', the
            orthogonal matrix of right Schur vectors of (A,B).
            Not referenced if COMPZ = 'N'.

    LDZ     (input) INTEGER
            The leading dimension of the array Z.  LDZ >= 1.
            If COMPZ='V' or 'I', then LDZ >= N.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO >= 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.  LWORK >= max(1,N).

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0: successful exit
            < 0: if INFO = -i, the i-th argument had an illegal value
            = 1,...,N: the QZ iteration did not converge.  (H,T) is not
                       in Schur form, but ALPHAR(i), ALPHAI(i), and
                       BETA(i), i=INFO+1,...,N should be correct.
            = N+1,...,2*N: the shift calculation failed.  (H,T) is not
                       in Schur form, but ALPHAR(i), ALPHAI(i), and
                       BETA(i), i=INFO-N+1,...,N should be correct.

    Further Details
    ===============

    Iteration counters:

    JITER  -- counts iterations.
    IITER  -- counts iterations run since ILAST was last
              changed.  This is therefore reset only when a 1-by-1 or
              2-by-2 block deflates off the bottom.
"));
    end dhgeqz;

    pure function dormhr
      "Overwrite the general real M-by-N matrix C with Q * C or C * Q or Q' * C or C * Q', where Q is an orthogonal matrix as returned by dgehrd"
      extends Modelica.Icons.Function;

      input Real C[:, :];
      input Real A[:, :];
      input Real tau[if side == "L" then size(C, 2) - 1 else size(C, 1) - 1];
      input String side="L";
      input String trans="N";
      input Integer ilo=1
        "Lowest index where the original matrix is not in upper triangular form";
      input Integer ihi=if side == "L" then size(C, 1) else size(C, 2)
        "Highest index where the original matrix is not in upper triangular form";
      output Real Cout[size(C, 1), size(C, 2)]=C
        "Contains the Hessenberg form in the upper triangle and the first subdiagonal and below the first subdiagonal it contains the elementary reflectors which represents (with array tau) as a product the orthogonal matrix Q";

      output Integer info;
    protected
      Integer m=size(C, 1);
      Integer n=size(C, 2);
      Integer lda=max(1, size(A, 2));
      Integer ldc=max(1, m);
      Integer lwork=max(1, 2*size(A, 2));
      Real work[max(1, 2*size(A, 2))];

    external"FORTRAN 77" dormhr(
              side,
              trans,
              m,
              n,
              ilo,
              ihi,
              A,
              lda,
              tau,
              Cout,
              ldc,
              work,
              lwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DORMHR overwrites the general real M-by-N matrix C with

                    SIDE = 'L'     SIDE = 'R'
    TRANS = 'N':      Q * C          C * Q
    TRANS = 'T':      Q**T * C       C * Q**T

    where Q is a real orthogonal matrix of order nq, with nq = m if
    SIDE = 'L' and nq = n if SIDE = 'R'. Q is defined as the product of
    IHI-ILO elementary reflectors, as returned by DGEHRD:

    Q = H(ilo) H(ilo+1) . . . H(ihi-1).

    Arguments
    =========

    SIDE    (input) CHARACTER*1
            = 'L': apply Q or Q**T from the Left;
            = 'R': apply Q or Q**T from the Right.

    TRANS   (input) CHARACTER*1
            = 'N':  No transpose, apply Q;
            = 'T':  Transpose, apply Q**T.

    M       (input) INTEGER
            The number of rows of the matrix C. M >= 0.

    N       (input) INTEGER
            The number of columns of the matrix C. N >= 0.

    ILO     (input) INTEGER
    IHI     (input) INTEGER
            ILO and IHI must have the same values as in the previous call
            of DGEHRD. Q is equal to the unit matrix except in the
            submatrix Q(ilo+1:ihi,ilo+1:ihi).
            If SIDE = 'L', then 1 <= ILO <= IHI <= M, if M > 0, and
            ILO = 1 and IHI = 0, if M = 0;
            if SIDE = 'R', then 1 <= ILO <= IHI <= N, if N > 0, and
            ILO = 1 and IHI = 0, if N = 0.

    A       (input) DOUBLE PRECISION array, dimension
                                 (LDA,M) if SIDE = 'L'
                                 (LDA,N) if SIDE = 'R'
            The vectors which define the elementary reflectors, as
            returned by DGEHRD.

    LDA     (input) INTEGER
            The leading dimension of the array A.
            LDA >= max(1,M) if SIDE = 'L'; LDA >= max(1,N) if SIDE = 'R'.

    TAU     (input) DOUBLE PRECISION array, dimension
                                 (M-1) if SIDE = 'L'
                                 (N-1) if SIDE = 'R'
            TAU(i) must contain the scalar factor of the elementary
            reflector H(i), as returned by DGEHRD.

    C       (input/output) DOUBLE PRECISION array, dimension (LDC,N)
            On entry, the M-by-N matrix C.
            On exit, C is overwritten by Q*C or Q**T*C or C*Q**T or C*Q.

    LDC     (input) INTEGER
            The leading dimension of the array C. LDC >= max(1,M).

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.
            If SIDE = 'L', LWORK >= max(1,N);
            if SIDE = 'R', LWORK >= max(1,M).
            For optimum performance LWORK >= N*NB if SIDE = 'L', and
            LWORK >= M*NB if SIDE = 'R', where NB is the optimal
            blocksize.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
"));
    end dormhr;

    pure function dormqr
      "Overwrite the general real M-by-N matrix C with Q * C or C * Q or Q' * C or C * Q', where Q is an orthogonal matrix of a QR factorization as returned by dgeqrf"
      extends Modelica.Icons.Function;

      input Real C[:, :];
      input Real A[:, :];
      input Real tau[:];
      input String side="L";
      input String trans="N";

      output Real Cout[size(C, 1), size(C, 2)]=C
        "Contains Q*C or Q**T*C or C*Q**T or C*Q";

      output Integer info;
    protected
      Integer m=size(C, 1);
      Integer n=size(C, 2);
      Integer k=if side == "L" then m else n;
      Integer lda=if side == "L" then max(1, m) else max(1, n);
      Integer ldc=max(1, m);
      Integer lwork=if side == "L" then max(1, n) else max(1, m);
      Real work[if side == "L" then max(1, size(C, 2)) else max(1, size(C, 1))];

    external"FORTRAN 77" dormqr(
              side,
              trans,
              m,
              n,
              k,
              A,
              lda,
              tau,
              Cout,
              ldc,
              work,
              lwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DORMQR overwrites the general real M-by-N matrix C with

                    SIDE = 'L'     SIDE = 'R'
    TRANS = 'N':      Q * C          C * Q
    TRANS = 'T':      Q**T * C       C * Q**T

    where Q is a real orthogonal matrix defined as the product of k
    elementary reflectors

          Q = H(1) H(2) . . . H(k)

    as returned by DGEQRF. Q is of order M if SIDE = 'L' and of order N
    if SIDE = 'R'.

    Arguments
    =========

    SIDE    (input) CHARACTER*1
            = 'L': apply Q or Q**T from the Left;
            = 'R': apply Q or Q**T from the Right.

    TRANS   (input) CHARACTER*1
            = 'N':  No transpose, apply Q;
            = 'T':  Transpose, apply Q**T.

    M       (input) INTEGER
            The number of rows of the matrix C. M >= 0.

    N       (input) INTEGER
            The number of columns of the matrix C. N >= 0.

    K       (input) INTEGER
            The number of elementary reflectors whose product defines
            the matrix Q.
            If SIDE = 'L', M >= K >= 0;
            if SIDE = 'R', N >= K >= 0.

    A       (input) DOUBLE PRECISION array, dimension (LDA,K)
            The i-th column must contain the vector which defines the
            elementary reflector H(i), for i = 1,2,...,k, as returned by
            DGEQRF in the first k columns of its array argument A.
            A is modified by the routine but restored on exit.

    LDA     (input) INTEGER
            The leading dimension of the array A.
            If SIDE = 'L', LDA >= max(1,M);
            if SIDE = 'R', LDA >= max(1,N).

    TAU     (input) DOUBLE PRECISION array, dimension (K)
            TAU(i) must contain the scalar factor of the elementary
            reflector H(i), as returned by DGEQRF.

    C       (input/output) DOUBLE PRECISION array, dimension (LDC,N)
            On entry, the M-by-N matrix C.
            On exit, C is overwritten by Q*C or Q**T*C or C*Q**T or C*Q.

    LDC     (input) INTEGER
            The leading dimension of the array C. LDC >= max(1,M).

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.
            If SIDE = 'L', LWORK >= max(1,N);
            if SIDE = 'R', LWORK >= max(1,M).
            For optimum performance LWORK >= N*NB if SIDE = 'L', and
            LWORK >= M*NB if SIDE = 'R', where NB is the optimal
            blocksize.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
"));
    end dormqr;

    pure function dtrevc
      "Compute the right and/or left eigenvectors of a real upper quasi-triangular matrix T"
      extends Modelica.Icons.Function;

      input Real T[:, size(T, 1)] "Upper quasi triangular matrix";
      input String side="R" "Specify which eigenvectors";
      input String howmny="B" "Specify how many eigenvectors";
      input Real Q[size(T, 1), size(T, 1)]
        "Orthogonal matrix Q of Schur vectors returned by DHSEQR";

      output Real lEigenVectors[size(T, 1), size(T, 1)]=Q
        "Left eigenvectors of matrix T";
      output Real rEigenVectors[size(T, 1), size(T, 1)]=Q
        "Right eigenvectors of matrix T";
      output Integer info;

    protected
      Integer n=size(T, 1);
      Boolean select[size(T, 1)];
      Integer ldt=max(1, n);
      Integer ldvl=max(1, n);
      Integer ldvr=max(1, n);
      Real work[3*size(T, 1)];

    external"FORTRAN 77" dtrevc(
              side,
              howmny,
              select,
              n,
              T,
              ldt,
              lEigenVectors,
              ldvl,
              rEigenVectors,
              ldvr,
              n,
              n,
              work,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DTREVC computes some or all of the right and/or left eigenvectors of
    a real upper quasi-triangular matrix T.
    Matrices of this type are produced by the Schur factorization of
    a real general matrix:  A = Q*T*Q**T, as computed by DHSEQR.

    The right eigenvector x and the left eigenvector y of T corresponding
    to an eigenvalue w are defined by:

       T*x = w*x,     (y**H)*T = w*(y**H)

    where y**H denotes the conjugate transpose of y.
    The eigenvalues are not input to this routine, but are read directly
    from the diagonal blocks of T.

    This routine returns the matrices X and/or Y of right and left
    eigenvectors of T, or the products Q*X and/or Q*Y, where Q is an
    input matrix.  If Q is the orthogonal factor that reduces a matrix
    A to Schur form T, then Q*X and Q*Y are the matrices of right and
    left eigenvectors of A.

    Arguments
    =========

    SIDE    (input) CHARACTER*1
            = 'R':  compute right eigenvectors only;
            = 'L':  compute left eigenvectors only;
            = 'B':  compute both right and left eigenvectors.

    HOWMNY  (input) CHARACTER*1
            = 'A':  compute all right and/or left eigenvectors;
            = 'B':  compute all right and/or left eigenvectors,
                    backtransformed by the matrices in VR and/or VL;
            = 'S':  compute selected right and/or left eigenvectors,
                    as indicated by the logical array SELECT.

    SELECT  (input/output) LOGICAL array, dimension (N)
            If HOWMNY = 'S', SELECT specifies the eigenvectors to be
            computed.
            If w(j) is a real eigenvalue, the corresponding real
            eigenvector is computed if SELECT(j) is .TRUE..
            If w(j) and w(j+1) are the real and imaginary parts of a
            complex eigenvalue, the corresponding complex eigenvector is
            computed if either SELECT(j) or SELECT(j+1) is .TRUE., and
            on exit SELECT(j) is set to .TRUE. and SELECT(j+1) is set to
            .FALSE..
            Not referenced if HOWMNY = 'A' or 'B'.

    N       (input) INTEGER
            The order of the matrix T. N >= 0.

    T       (input) DOUBLE PRECISION array, dimension (LDT,N)
            The upper quasi-triangular matrix T in Schur canonical form.

    LDT     (input) INTEGER
            The leading dimension of the array T. LDT >= max(1,N).

    VL      (input/output) DOUBLE PRECISION array, dimension (LDVL,MM)
            On entry, if SIDE = 'L' or 'B' and HOWMNY = 'B', VL must
            contain an N-by-N matrix Q (usually the orthogonal matrix Q
            of Schur vectors returned by DHSEQR).
            On exit, if SIDE = 'L' or 'B', VL contains:
            if HOWMNY = 'A', the matrix Y of left eigenvectors of T;
            if HOWMNY = 'B', the matrix Q*Y;
            if HOWMNY = 'S', the left eigenvectors of T specified by
                             SELECT, stored consecutively in the columns
                             of VL, in the same order as their
                             eigenvalues.
            A complex eigenvector corresponding to a complex eigenvalue
            is stored in two consecutive columns, the first holding the
            real part, and the second the imaginary part.
            Not referenced if SIDE = 'R'.

    LDVL    (input) INTEGER
            The leading dimension of the array VL.  LDVL >= 1, and if
            SIDE = 'L' or 'B', LDVL >= N.

    VR      (input/output) DOUBLE PRECISION array, dimension (LDVR,MM)
            On entry, if SIDE = 'R' or 'B' and HOWMNY = 'B', VR must
            contain an N-by-N matrix Q (usually the orthogonal matrix Q
            of Schur vectors returned by DHSEQR).
            On exit, if SIDE = 'R' or 'B', VR contains:
            if HOWMNY = 'A', the matrix X of right eigenvectors of T;
            if HOWMNY = 'B', the matrix Q*X;
            if HOWMNY = 'S', the right eigenvectors of T specified by
                             SELECT, stored consecutively in the columns
                             of VR, in the same order as their
                             eigenvalues.
            A complex eigenvector corresponding to a complex eigenvalue
            is stored in two consecutive columns, the first holding the
            real part and the second the imaginary part.
            Not referenced if SIDE = 'L'.

    LDVR    (input) INTEGER
            The leading dimension of the array VR.  LDVR >= 1, and if
            SIDE = 'R' or 'B', LDVR >= N.

    MM      (input) INTEGER
            The number of columns in the arrays VL and/or VR. MM >= M.

    M       (output) INTEGER
            The number of columns in the arrays VL and/or VR actually
            used to store the eigenvectors.
            If HOWMNY = 'A' or 'B', M is set to N.
            Each selected real eigenvector occupies one column and each
            selected complex eigenvector occupies two columns.

    WORK    (workspace) DOUBLE PRECISION array, dimension (3*N)

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value

    Further Details
    ===============

    The algorithm used in this program is basically backward (forward)
    substitution, with scaling to make the code robust against
    possible overflow.

    Each eigenvector is normalized so that the element of largest
    magnitude has magnitude 1; here the magnitude of a complex number
    (x,y) is taken to be |x| + |y|.
"));
    end dtrevc;

    pure function dpotrf
      "Compute the Cholesky factorization of a real symmetric positive definite matrix A"
      extends Modelica.Icons.Function;

      input Real A[:, size(A, 1)] "Real symmetric positive definite matrix A";
      input Boolean upper=true "= true, if the upper triangle of A is provided";

      output Real Acholesky[size(A, 1), size(A, 1)]=A "Cholesky factor";
      output Integer info;
    protected
      String uplo=if upper then "U" else "L";
      Integer n=size(A, 1);
      Integer lda=max(1, n);
    external"FORTRAN 77" dpotrf(
              uplo,
              n,
              Acholesky,
              lda,
              info) annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DPOTRF computes the Cholesky factorization of a real symmetric
    positive definite matrix A.

    The factorization has the form
       A = U**T * U,  if UPLO = 'U', or
       A = L  * L**T,  if UPLO = 'L',
    where U is an upper triangular matrix and L is lower triangular.

    This is the block version of the algorithm, calling Level 3 BLAS.

    Arguments
    =========

    UPLO    (input) CHARACTER*1
            = 'U':  Upper triangle of A is stored;
            = 'L':  Lower triangle of A is stored.

    N       (input) INTEGER
            The order of the matrix A.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the symmetric matrix A.  If UPLO = 'U', the leading
            N-by-N upper triangular part of A contains the upper
            triangular part of the matrix A, and the strictly lower
            triangular part of A is not referenced.  If UPLO = 'L', the
            leading N-by-N lower triangular part of A contains the lower
            triangular part of the matrix A, and the strictly upper
            triangular part of A is not referenced.

            On exit, if INFO = 0, the factor U or L from the Cholesky
            factorization A = U**T*U or A = L*L**T.

    LDA     (input) INTEGER
            The leading dimension of the array A.  LDA >= max(1,N).

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
            > 0:  if INFO = i, the leading minor of order i is not
                  positive definite, and the factorization could not be
                  completed.
"));
    end dpotrf;

    pure function dtrsm
      "Solve one of the matrix equations op( A )*X = alpha*B, or X*op( A ) = alpha*B, where A is triangular matrix. BLAS routine"
      extends Modelica.Icons.Function;

      input Real A[:, :] "Input matrix A";
      input Real B[:, :] "Input matrix B";
      input Real alpha=1 "Factor alpha";
      input Boolean right=true "= true, if A is right multiplication";
      input Boolean upper=true "= true, if A is upper triangular";
      input Boolean trans=false "= true, if op(A) means transposed(A)";
      input Boolean unitTriangular=false
        "= true, if A is unit triangular, i.e., all diagonal elements of A are equal to 1";

      output Real X[size(B, 1), size(B, 2)]=B
        "Matrix Bout=alpha*op( A )*B, or B := alpha*B*op( A )";
    protected
      String side=if right then "R" else "L";
      String uplo=if upper then "U" else "L";
      String transA=if trans then "T" else "N";
      String diag=if unitTriangular then "U" else "N";
      Integer m=size(B, 1) "Number of rows of B";
      Integer n=size(B, 2) "Number of columns of B";
      Integer lda=if right then max(1, n) else max(1, m) "First dimension of A";
      Integer ldb=max(1, m) "First dimension of B";

    external"FORTRAN 77" dtrsm(
              side,
              uplo,
              transA,
              diag,
              m,
              n,
              alpha,
              A,
              lda,
              X,
              ldb) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DTRSM solves one of the matrix equations

       op( A )*X = alpha*B,   or   X*op( A ) = alpha*B,

    where alpha is a scalar, X and B are m by n matrices, A is a unit, or
    non-unit,  upper or lower triangular matrix  and  op( A )  is one  of

       op( A ) = A   or   op( A ) = A'.

    The matrix X is overwritten on B.

    Arguments
    ==========

    SIDE   - CHARACTER*1.
             On entry, SIDE specifies whether op( A ) appears on the left
             or right of X as follows:

                SIDE = 'L' or 'l'   op( A )*X = alpha*B.

                SIDE = 'R' or 'r'   X*op( A ) = alpha*B.

             Unchanged on exit.

    UPLO   - CHARACTER*1.
             On entry, UPLO specifies whether the matrix A is an upper or
             lower triangular matrix as follows:

                UPLO = 'U' or 'u'   A is an upper triangular matrix.

                UPLO = 'L' or 'l'   A is a lower triangular matrix.

             Unchanged on exit.

    TRANSA - CHARACTER*1.
             On entry, TRANSA specifies the form of op( A ) to be used in
             the matrix multiplication as follows:

                TRANSA = 'N' or 'n'   op( A ) = A.

                TRANSA = 'T' or 't'   op( A ) = A'.

                TRANSA = 'C' or 'c'   op( A ) = A'.

             Unchanged on exit.

    DIAG   - CHARACTER*1.
             On entry, DIAG specifies whether or not A is unit triangular
             as follows:

                DIAG = 'U' or 'u'   A is assumed to be unit triangular.

                DIAG = 'N' or 'n'   A is not assumed to be unit
                                    triangular.

             Unchanged on exit.

    M      - INTEGER.
             On entry, M specifies the number of rows of B. M must be at
             least zero.
             Unchanged on exit.

    N      - INTEGER.
             On entry, N specifies the number of columns of B.  N must be
             at least zero.
             Unchanged on exit.

    ALPHA  - DOUBLE PRECISION.
             On entry,  ALPHA specifies the scalar  alpha. When  alpha is
             zero then  A is not referenced and  B need not be set before
             entry.
             Unchanged on exit.

    A      - DOUBLE PRECISION array of DIMENSION ( LDA, k ), where k is m
             when  SIDE = 'L' or 'l'  and is  n  when  SIDE = 'R' or 'r'.
             Before entry  with  UPLO = 'U' or 'u',  the  leading  k by k
             upper triangular part of the array  A must contain the upper
             triangular matrix  and the strictly lower triangular part of
             A is not referenced.
             Before entry  with  UPLO = 'L' or 'l',  the  leading  k by k
             lower triangular part of the array  A must contain the lower
             triangular matrix  and the strictly upper triangular part of
             A is not referenced.
             Note that when  DIAG = 'U' or 'u',  the diagonal elements of
             A  are not referenced either,  but are assumed to be  unity.
             Unchanged on exit.

    LDA    - INTEGER.
             On entry, LDA specifies the first dimension of A as declared
             in the calling (sub) program.  When  SIDE = 'L' or 'l'  then
             LDA  must be at least  max( 1, m ),  when  SIDE = 'R' or 'r'
             then LDA must be at least max( 1, n ).
             Unchanged on exit.

    B      - DOUBLE PRECISION array of DIMENSION ( LDB, n ).
             Before entry,  the leading  m by n part of the array  B must
             contain  the  right-hand  side  matrix  B,  and  on exit  is
             overwritten by the solution matrix  X.

    LDB    - INTEGER.
             On entry, LDB specifies the first dimension of B as declared
             in  the  calling  (sub)  program.   LDB  must  be  at  least
             max( 1, m ).
             Unchanged on exit.

    Level 3 Blas routine.
"));
    end dtrsm;

    pure function dorghr
      "Generate a real orthogonal matrix Q which is defined as the product of IHI-ILO elementary reflectors of order N, as returned by DGEHRD"
      extends Modelica.Icons.Function;

      input Real A[:, size(A, 1)]
        "Square matrix with the elementary reflectors";
      input Integer ilo=1
        "Lowest index where the original matrix is not in upper triangular form - ilo must have the same value as in the previous call of DGEHRD";
      input Integer ihi=size(A, 1)
        "Highest index where the original matrix is not in upper triangular form - ihi must have the same value as in the previous call of DGEHRD";
      input Real tau[max(0, size(A, 1) - 1)]
        "Scalar factors of the elementary reflectors";
      output Real Aout[size(A, 1), size(A, 2)]=A
        "Orthogonal matrix as a result of elementary reflectors";
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lda=max(1, n);
      Integer lwork=max(1, 3*n);
      Real work[max(1, 3*size(A, 1))];

    external"FORTRAN 77" dorghr(
              n,
              ilo,
              ihi,
              Aout,
              lda,
              tau,
              work,
              lwork,
              info) annotation (Library={"lapack"});
      annotation (Documentation(info="Lapack documentation
    Purpose
    =======

    DORGHR generates a real orthogonal matrix Q which is defined as the
    product of IHI-ILO elementary reflectors of order N, as returned by
    DGEHRD:

    Q = H(ilo) H(ilo+1) . . . H(ihi-1).

    Arguments
    =========

    N       (input) INTEGER
            The order of the matrix Q. N >= 0.

    ILO     (input) INTEGER
    IHI     (input) INTEGER
            ILO and IHI must have the same values as in the previous call
            of DGEHRD. Q is equal to the unit matrix except in the
            submatrix Q(ilo+1:ihi,ilo+1:ihi).
            1 <= ILO <= IHI <= N, if N > 0; ILO=1 and IHI=0, if N=0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
            On entry, the vectors which define the elementary reflectors,
            as returned by DGEHRD.
            On exit, the N-by-N orthogonal matrix Q.

    LDA     (input) INTEGER
            The leading dimension of the array A. LDA >= max(1,N).

    TAU     (input) DOUBLE PRECISION array, dimension (N-1)
            TAU(i) must contain the scalar factor of the elementary
            reflector H(i), as returned by DGEHRD.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK. LWORK >= IHI-ILO.
            For optimum performance LWORK >= (IHI-ILO)*NB, where NB is
            the optimal blocksize.

            If LWORK = -1, then a workspace query is assumed; the routine
            only calculates the optimal size of the WORK array, returns
            this value as the first entry of the WORK array, and no error
            message related to LWORK is issued by XERBLA.

    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
"));
    end dorghr;
    annotation (Documentation(info="<html>
<p>
This package contains external Modelica functions as interface to the
LAPACK library
(<a href=\"http://www.netlib.org/lapack\">http://www.netlib.org/lapack</a>)
that provides FORTRAN subroutines to solve linear algebra
tasks. Usually, these functions are not directly called, but only via
the much more convenient interface of
<a href=\"modelica://Modelica.Math.Matrices\">Modelica.Math.Matrices</a>.
The documentation of the LAPACK functions is a copy of the original
FORTRAN code. The details of LAPACK are described in:
</p>

<dl>
<dt>Anderson E., Bai Z., Bischof C., Blackford S., Demmel J., Dongarra J.,
    Du Croz J., Greenbaum A., Hammarling S., McKenney A., and Sorensen D.:</dt>
<dd> <a href=\"http://www.netlib.org/lapack/lug/lapack_lug.html\">Lapack Users' Guide</a>.
     Third Edition, SIAM, 1999.</dd>
</dl>

<p>
See also <a href=\"http://en.wikipedia.org/wiki/Lapack\">http://en.wikipedia.org/wiki/Lapack</a>.
</p>

<p>
This package contains a direct interface to the LAPACK subroutines
</p>

</html>"));
  end LAPACK;

  package Utilities
    "Utility functions that should not be directly utilized by the user"
    extends Modelica.Icons.UtilitiesPackage;

    function continuousRiccatiIterative
      "Newton's method with exact line search for iterative solving continuous algebraic Riccati equation"
      extends Modelica.Icons.Function;

      import Modelica.Math.Matrices;

      input Real A[:, size(A, 1)]
        "Matrix A of Riccati equation X*A + A'*X -X*G*X +Q = 0";
      input Real B[size(A, 1), :] "Matrix B in G = B*inv(R)*B'";
      input Real R[size(B, 2), size(B, 2)]=identity(size(B, 2))
        "Matrix R in G = B*inv(R)*B'";
      input Real Q[size(A, 1), size(A, 2)]=identity(size(A, 1))
        "Matrix Q of Riccati equation X*A + A'*X -X*G*X +Q = 0";
      input Real X0[size(A, 1), size(A, 2)]=identity(size(A, 1))
        "Initial approximate solution for X*A + A'*X -X*G*X +Q = 0";
      input Integer maxSteps=10 "Maximal number of iteration steps";
      input Real eps=Matrices.frobeniusNorm(A)*1e-9
        "Tolerance for stop criterion";

      output Real X[size(X0, 1), size(X0, 2)]
        "Solution X of Riccati equation X*A + A'*X -X*G*X +Q = 0";
      output Real r "Norm of X*A + A'*X - X*G*X + Q, zero for exact solution";

    protected
      Integer n=size(A, 1);
      Real G[size(A, 1), size(A, 2)]=B*Matrices.solve2(R, transpose(B));
      Real Xk[size(A, 1), size(A, 2)];
      Real Ak[size(A, 1), size(A, 2)];
      Real Rk[size(A, 1), size(A, 2)];
      Real Nk[size(A, 1), size(A, 2)];
      Real Vk[size(A, 1), size(A, 2)];
      Real tk;
      Integer k;
      Boolean stop;

    algorithm
      if n > 1 then
        k := 0;
        stop := false;
        Xk := X0;
        while (not stop) loop
          k := k + 1;
          Ak := A - G*Xk;
          Rk := transpose(A)*Xk + Xk*A + Q - Xk*G*Xk;
          Nk := Matrices.continuousLyapunov(Ak, -Rk);
          Vk := Nk*G*Nk;
          tk := Matrices.Utilities.findLocal_tk(Rk, Vk);
          stop := eps > Matrices.frobeniusNorm(tk*Nk)/Matrices.frobeniusNorm(Xk)
             or k >= maxSteps;
          Xk := Xk + tk*Nk;
        end while;
        X := Xk;
        r := Matrices.frobeniusNorm(X*A + transpose(A)*X - X*G*X + Q);

      elseif n == 1 then
        // exact calculation
        X := matrix((A[1, 1] - sqrt(A[1, 1]*A[1, 1] + G[1, 1]*Q[1, 1]))/G[1, 1]);
        if X[1, 1]*G[1, 1] < A[1, 1] then
          X := matrix((A[1, 1] + sqrt(A[1, 1]*A[1, 1] + G[1, 1]*Q[1, 1]))/G[1,
            1]);
        end if;
        r := 0;
      else
        X := fill(
                0,
                0,
                0);
        r := 0;
      end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
     X = Matrices.Utilities.<strong>continuousRiccatiIterative</strong>(A, B, R, Q, X0);
(X, r) = Matrices.Utilities.<strong>continuousRiccatiIterative</strong>(A, B, R, Q, X0, maxSteps, eps);
</pre></blockquote>
<h4>Description</h4>
<p>
This function provides a Newton-like method for solving continuous algebraic Riccati equations (care). It utilizes Exact Line Search to improve the sometimes erratic
convergence of Newton's method. Exact line search in this case means, that at each iteration <code>i</code> a Newton step <code><strong>delta</strong>_i</code>
</p>
<blockquote><pre>
<strong>X</strong>_i+1 = <strong>X</strong>_i + <strong>delta</strong>_i
</pre></blockquote>
<p>
is taken in the direction to minimize the Frobenius norm of the residual
</p>
<blockquote><pre>
r = || <strong>X</strong>_i+1*<strong>A</strong> +<strong>A</strong>'*<strong>X</strong>_i+1 - <strong>X</strong>_i+1*<strong>G</strong>*<strong>X</strong>_i+1 + <strong>Q</strong> ||.
</pre></blockquote>
<p>
with
</p>
<blockquote><pre>
      -1
G = <strong>B</strong>*<strong>R</strong> *<strong>B</strong>'
</pre></blockquote>

<p>
The inputs \"maxSteps\" and \"eps\" specify the termination of the iteration. The iteration is terminated if either
maxSteps iteration steps have been performed or the relative change <strong>delta</strong>_i/<strong>X</strong>_i became smaller than eps.
</p>
<p>
With an appropriate initial value <strong>X</strong>0 a sufficiently accurate solution might be reach within a few iteration steps. Although a Lyapunov equation
of order <code>n</code> (n is the order of the Riccati equation) is to be solved at each iteration step, the algorithm might be faster
than a direct method like <a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">Matrices.continuousRiccati</a>, since direct methods have to solve the 2*n-order Hamiltonian
system equation.<br>

The algorithm is taken from [1] and [2].
</p>
<h4>References</h4>
<blockquote><pre>
[1] Benner, P., Byers, R.
    An Exact Line Search Method for Solving Generalized Continuous-Time Algebraic Riccati Equations
    IEEE Transactions On Automatic Control, Vol. 43, No. 1, pp. 101-107, 1998.
[2] Datta, B.N.
    Numerical Methods for Linear Control Systems
    Elsevier Academic Press, 2004.
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
A=[0.0,         1.0,         0.0,         0.0;
   0.0,        -1.890,       3.900e-01,  -5.530;
   0.0,        -3.400e-02,  -2.980,       2.430;
   3.400e-02,  -1.100e-03,  -9.900e-01,  -2.100e-01];

B=[ 0.0,         0.0;
    3.600e-01,  -1.60;
   -9.500e-01,  -3.200e-02;
    3.000e-02,   0.0];

R=[1, 0; 0, 1];

Q=[2.313,       2.727,       6.880e-01,   2.300e-02;
   2.727,       4.271,       1.148,       3.230e-01;
   6.880e-01,   1.148,       3.130e-01,   1.020e-01;
   2.300e-02,   3.230e-01,   1.020e-01,   8.300e-02];

X0=identity(4);

(X,r) = Matrices.Utilities.continuousRiccatiIterative(A, B, R, Q, X0);

// X = [1.3239,  0.9015,  0.5466, -1.7672;
        0.9015,  0.9607,  0.4334, -1.1989;
        0.5466,  0.4334,  0.4605, -1.3633;
       -1.7672, -1.1989, -1.3633,  4.4612]
// r =  2.48809423389491E-015

(,r) = Matrices.Utilities.continuousRiccatiIterative(A, B, R, Q, X0,4);

// r =  0.0004;
</pre></blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.discreteRiccatiIterative\">Matrices.Utilities.discreteRiccatiIterative</a><br>
<a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">Matrices.continuousRiccati</a>
</html>", revisions="<html>
<ul>
<li><em>2010/04/30 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end continuousRiccatiIterative;

    function discreteRiccatiIterative
      "Newton's method with exact line search for solving discrete algebraic Riccati equation"
      extends Modelica.Icons.Function;

      import Modelica.Math.Matrices;

      input Real A[:, size(A, 1)] "Matrix A of discrete Riccati equation";
      input Real B[size(A, 1), :] "Matrix B of discrete Riccati equation";
      input Real R[size(B, 2), size(B, 2)]=identity(size(B, 2))
        "Matrix R of discrete Riccati equation";
      input Real Q[size(A, 1), size(A, 2)]=identity(size(A, 1))
        "Matrix Q of discrete Riccati equation";
      input Real X0[size(A, 1), size(A, 2)]=identity(size(A, 1))
        "Initial approximate solution discrete Riccati equation";
      input Integer maxSteps=10 "Maximal number of iteration steps";
      input Real eps=Matrices.frobeniusNorm(A)*1e-9
        "Tolerance for stop criterion";

      output Real X[size(X0, 1), size(X0, 2)];
      output Real r;

    protected
      Integer n=size(A, 1);
      Real Xk[size(A, 1), size(A, 2)];
      Real Ak[size(A, 1), size(A, 2)];
      Real Rk[size(A, 1), size(A, 2)];
      Real Nk[size(A, 1), size(A, 2)];
      Real Hk[size(B, 2), size(B, 1)];
      Real Vk[size(A, 1), size(A, 2)];
      Real AT[size(A, 2), size(A, 2)]=transpose(A);
      Real BT[size(B, 2), size(B, 1)]=transpose(B);
      Real tk;
      Integer k;

      Boolean stop;

    algorithm
      if n > 0 then
        k := 0;
        stop := false;
        Xk := X0;
        while (not stop) loop
          k := k + 1;
          Hk := Matrices.solve2(R + BT*Xk*B, BT);
          Ak := A - B*Hk*Xk*A;
          Rk := AT*Xk*A - Xk + Q - AT*Xk*B*Hk*Xk*A;
          Nk := Modelica.Math.Matrices.discreteLyapunov(
                  A=Ak,
                  C=-Rk,
                  sgn=-1);
          Vk := transpose(Ak)*Nk*B*Hk*Nk*Ak;
          tk := Modelica.Math.Matrices.Utilities.findLocal_tk(Rk, Vk);
          stop := eps > Matrices.frobeniusNorm(tk*Nk)/Matrices.frobeniusNorm(Xk)
             or k >= maxSteps;
          Xk := Xk + tk*Nk;
        end while;
        X := Xk;
        r := Matrices.frobeniusNorm(AT*X*A - X + Q - AT*X*B*Matrices.solve2(R
           + BT*X*B, BT)*X*A);
      else
        X := fill(
                0,
                0,
                0);
        r := 0;
      end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
     X = Matrices.Utilities.<strong>discreteRiccatiIterative</strong>(A, B, R, Q, X0);
(X, r) = Matrices.Utilities.<strong>discreteRiccatiIterative</strong>(A, B, R, Q, X0, maxSteps, eps);
</pre></blockquote>
<h4>Description</h4>
<p>
This function provides a Newton-like method for solving discrete-time algebraic Riccati equations. It uses Exact Line Search to improve the sometimes erratic
convergence of Newton's method. Exact line search in this case means, that at each iteration <code>i</code> a Newton step <code><strong>delta</strong>_i</code>
</p>
<blockquote><pre>
<strong>X</strong>_i+1 = <strong>X</strong>_i + <strong>delta</strong>_i
</pre></blockquote>
<p>
is taken in the direction to minimize the Frobenius norm of the residual
</p>
<blockquote><pre>
r = || <strong>A</strong>'<strong>X</strong>_i+1*<strong>A</strong> - <strong>X</strong>_i+1 - <strong>A</strong>'<strong>X</strong>_i+1*<strong>G</strong>_i*<strong>X</strong>_i+1*<strong>A</strong> + <strong>Q</strong> ||
</pre></blockquote>
<p>
with
</p>
<blockquote><pre>
                     -1
G_i = <strong>B</strong>*(<strong>R</strong> + <strong>B</strong>'*<strong>X</strong>_i*<strong>B</strong>) *<strong>B</strong>'
</pre></blockquote>
<p>
Output <code>r</code> is the norm of the residual of the last iteration.<br>
</p>
<p>
The inputs \"maxSteps\" and \"eps\" specify the termination of the iteration. The iteration is terminated if either
maxSteps iteration steps have been performed or the relative change <strong>delta</strong>_i/<strong>X</strong>_i became smaller than eps.
</p>
<p>
With an appropriate initial value <strong>X</strong>0 a sufficiently accurate solution might be reach with a few iteration steps. Although a Lyapunov equation of
order <code>n</code> (n is the order of the Riccati equation) is to be solved at each iteration step, the algorithm might be faster
than a direct method like <a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">Matrices.discreteRiccati</a>, since direct methods have to solve the 2*n-order Hamiltonian
system equation.

The algorithm is taken from [1] and [2].
</p>
<h4>References</h4>
<blockquote><pre>
[1] Benner, P., Byers, R.
    An Exact Line Search Method for Solving Generalized Continuous-Time Algebraic Riccati Equations
    IEEE Transactions On Automatic Control, Vol. 43, No. 1, pp. 101-107, 1998.
[2] Datta, B.N.
    Numerical Methods for Linear Control Systems
    Elsevier Academic Press, 2004.
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
A  = [0.9970,    0.0000,    0.0000,    0.0000;
      1.0000,    0.0000,    0.0000,    0.0000;
      0.0000,    1.0000,    0.0000,    0.0000;
      0.0000,    0.0000,    1.0000,    0.0000];

B  = [0.0150;
      0.0000;
      0.0000;
      0.0000];

R = [0.2500];

Q = [0, 0, 0, 0;
     0, 0, 0, 0;
     0, 0, 0, 0;
     0, 0, 0, 1];

X0=identity(4);

(X,r) = Matrices.Utilities.discreteRiccatiIterative(A, B, R, Q, X0);

//  X = [30.625, 0.0, 0.0, 0.0;
          0.0,   1.0, 0.0, 0.0;
          0.0,   0.0, 1.0, 0.0;
          0.0,   0.0, 0.0, 1.0];

// r =   3.10862446895044E-015
</pre></blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\">Matrices.Utilities.continuousRiccatiIterative</a><br>
<a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">Matrices.discreteRiccati</a>
</html>", revisions="<html>
<ul>
<li><em>2010/04/30 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end discreteRiccatiIterative;

    function toUpperHessenberg
      "Transform a real square matrix A to upper Hessenberg form H by orthogonal similarity transformation:  Q' * A * Q = H"
      extends Modelica.Icons.Function;

      import Modelica.Math.Matrices;
      import Modelica.Math.Matrices.LAPACK;

      input Real A[:, size(A, 1)] "Square matrix A";
      input Integer ilo=1
        "Lowest index where the original matrix is not in upper triangular form";
      input Integer ihi=size(A, 1)
        "Highest index where the original matrix is not in upper triangular form";
      output Real H[size(A, 1), size(A, 2)] "Upper Hessenberg form";
      output Real V[size(A, 1), size(A, 2)]
        "V=[v1,v2,..vn-1,0] with vi are vectors which define the elementary reflectors";

      output Real tau[max(0, size(A, 1) - 1)]
        "Scalar factors of the elementary reflectors";
      output Integer info "Information of successful function call";

    protected
      Integer n=size(A, 1);
      Real Aout[size(A, 1), size(A, 2)];
      Integer i;

    algorithm
      if n > 0 then
        if n == 1 then
          H := A;
          V := {{0.0}};
          tau := zeros(0);
          info := 0;
        else
          (Aout, tau, info) := LAPACK.dgehrd(A, ilo, ihi);
          H := zeros(size(H, 1), size(H, 2));
          H[1:2, 1:n] := Aout[1:2, 1:n];
          for i in 3:n loop
            H[i, (i - 1):n] := Aout[i, (i - 1):n];
          end for;
          V := zeros(size(V, 1), size(V, 2));
          for i in ilo:min(n - 2, ihi) loop
            V[i + 1, i] := 1.0;
            V[(i + 2):n, i] := Aout[(i + 2):n, i];
          end for;
          V[n, n - 1] := 1;
        end if;
      end if;
    annotation (Documentation(info="<html>
   <h4>Syntax</h4>
<blockquote><pre>
                H = Matrices.Utilities.<strong>toUpperHessenberg</strong>(A);
(H, V, tau, info) = Matrices.Utilities.<strong>toUpperHessenberg</strong>(A,ilo, ihi);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <strong>toUpperHessenberg</strong> computes a upper Hessenberg form <strong>H</strong> of a matrix <strong>A</strong> by orthogonal similarity transformation:  <strong>Q</strong>' * <strong>A</strong> * <strong>Q</strong> = <strong>H</strong>.
The optional inputs <strong>ilo</strong> and <strong>ihi</strong> improve efficiency if the matrix is already partially converted to Hessenberg form; it is assumed
that matrix <strong>A</strong> is already upper Hessenberg for rows and columns <strong>1:(ilo-1)</strong> and <strong>(ihi+1):size(A, 1)</strong>.
The function calls <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dgehrd\">LAPACK.dgehrd</a>.
See <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dgehrd\">Matrices.LAPACK.dgehrd</a> for more information about the additional outputs V, tau, info and inputs ilo, ihi.
</p>

<h4>Example</h4>
<blockquote><pre>
A  = [1, 2, 3;
      6, 5, 4;
      1, 0, 0];

H = toUpperHessenberg(A);

results in:

H = [1.0,  -2.466,  2.630;
    -6.083, 5.514, -3.081;
     0.0,   0.919, -0.514]
</pre></blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.hessenberg\">Matrices.hessenberg</a>
</html>", revisions="<html><ul>
<li><em>2010/04/30 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end toUpperHessenberg;

    function eigenvaluesHessenberg
      "Compute eigenvalues of an upper Hessenberg form matrix"
      extends Modelica.Icons.Function;

      import Modelica.Math.Matrices.LAPACK;
      input Real H[:, size(H, 1)] "Hessenberg matrix H";

      output Real ev[size(H, 1), 2] "Eigenvalues";
      output Integer info=0;
    protected
      Real alphaReal[size(H, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      Real alphaImag[size(H, 1)]
        "Imaginary part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
    algorithm
      if size(H, 1) > 0 then
        (alphaReal,alphaImag,info) := LAPACK.dhseqr(H);
      else
        alphaReal := fill(0, size(H, 1));
        alphaImag := fill(0, size(H, 1));
      end if;
      ev := [alphaReal, alphaImag];

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
        ev = Matrices.Utilities.<strong>eigenvaluesHessenberg</strong>(H);
(ev, info) = Matrices.Utilities.<strong>eigenvaluesHessenberg</strong>(H);
</pre></blockquote>
<h4>Description</h4>
<p>
This function computes the eigenvalues of a Hessenberg form matrix. Transformation to Hessenberg form is the first step in eigenvalue computation for arbitrary matrices with QR decomposition.
This step can be skipped if the matrix has already Hessenberg form.
</p>

<p>
The function uses the LAPACK-routine dhseqr. Output <code>info</code> is 0 for a successful call of this
function.<br>
See <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dhseqr\">Matrices.LAPACK.dhseqr</a> for details
</p>

<h4>Example</h4>
<blockquote><pre>
Real A[3,3] = [1,2,3;
               9,8,7;
               0,1,0];

Real ev[3,2];

ev := Matrices.Utilities.eigenvaluesHessenberg(A);

// ev  = [10.7538,    0.0;
          -0.8769,    1.0444;
          -0.8769,   -1.0444]
// = {10.7538,  -0.8769 +- i*1.0444}
</pre></blockquote>
<br>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>,
<a href=\"modelica://Modelica.Math.Matrices.hessenberg\">Matrices.hessenberg</a>
</p>
</html>", revisions="<html>
<ul>
<li><em>2010/04/30 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end eigenvaluesHessenberg;

    function reorderRSF
      "Reorders a real Schur form to clusters of stable and unstable eigenvalues"
      extends Modelica.Icons.Function;

      import Modelica.Math.Matrices.LAPACK;

      input Real T[:, :] "Real Schur form";
      input Real Q[:, size(T, 2)] "Schur vector Matrix";
      input Real alphaReal[size(T, 1)]
        "Real part of eigenvalue=alphaReal+i*alphaImag";
      input Real alphaImag[size(T, 1)]
        "Imaginary part of eigenvalue=alphaReal+i*alphaImag";
      input Boolean iscontinuous=true
        "= true, if the according system is continuous. False for discrete systems";

      output Real To[size(T, 1), size(T, 2)] "Reordered Schur form";
      output Real Qo[size(T, 1), size(T, 2)] "Reordered Schur vector matrix";
      output Real wr[size(T, 2)] "Reordered eigenvalues, real part";
      output Real wi[size(T, 2)] "Reordered eigenvalues, imaginary part";

    protected
      Integer n=size(T, 2);
      Boolean select[size(T, 2)]=fill(false, size(T, 2));
      Integer i;
    algorithm
      if iscontinuous then
        for i in 1:n loop
          if alphaReal[i] < 0 then
            select[i] := true;
          end if;
        end for;
      else
        for i in 1:n loop
          if alphaReal[i]^2 + alphaImag[i]^2 < 1 then
            select[i] := true;
          end if;
        end for;
      end if;

      (To,Qo,wr,wi) := LAPACK.dtrsen(
              "E",
              "V",
              select,
              T,
              Q);

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
              To = Matrices.Utilities.<strong>reorderRSF</strong>(T, Q, alphaReal, alphaImag);
(To, Qo, wr, wi) = Matrices.Utilities.<strong>reorderRSF</strong>(T, Q, alphaReal, alphaImag, iscontinuous);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <strong>reorderRSF</strong>() reorders a real Schur form such that the stable eigenvalues of
the system are in the 1-by-1 and 2-by-2 diagonal blocks of the block <strong>upper</strong> triangular matrix.
If the Schur form is referenced to a continuous system the staple eigenvalues are in the left complex half plane.
The stable eigenvalues of a discrete system are inside the complex unit circle.<br>
This function is used for example to solve algebraic Riccati equations
(<a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">continuousRiccati</a>,
<a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">discreteRiccati</a>). In this context the Schur form
as well as the corresponding eigenvalues and the transformation matrix <strong>Q</strong> are known, why the eigenvalues and the transformation matrix are inputs to <strong>reorderRSF()</strong>.<br>

The Schur vector matrix <strong>Qo</strong> is also reordered according to <strong>To</strong>. The vectors <strong>wr</strong> and <strong>wi</strong> contains the real and imaginary parts of the
reordered eigenvalues respectively.
</p>

<h4>Example</h4>
<blockquote><pre>
T := [-1,2, 3,4;
       0,2, 6,5;
       0,0,-3,5;
       0,0, 0,6];
To := Matrices.Utilities.reorderRSF(T,identity(4),{-1, 2, -3, 6},{0, 0, 0, 0}, true);

// To = [-1.0, -0.384, 3.585, 4.0;
//        0.0, -3.0,   6.0,   0.64;
//        0.0,  0.0,   2.0,   7.04;
//        0.0,  0.0,   0.0,   6.0]
</pre></blockquote>
<p>
See also <a href=\"modelica://Modelica.Math.Matrices.realSchur\">Matrices.realSchur</a>
</p>
</html>", revisions="<html>
<ul>
<li><em>2010/04/30 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end reorderRSF;

    function findLocal_tk
      "Find a local minimizer tk to define the length of the step tk*Nk in continuousRiccatiIterative and discreteRiccatiIterative"
      extends Modelica.Icons.Function;

      import Modelica.Math.Matrices;
      import Modelica.Math.Polynomials;

      input Real Rk[:, size(Rk, 1)];
      input Real Vk[size(Rk, 1), size(Rk, 2)];

      output Real tk;

    protected
      Real alpha_k;
      Real beta_k;
      Real gamma_k;
      Real p[3, 2];
      Boolean h;

    algorithm
      alpha_k := Matrices.trace(Rk*Rk);
      beta_k := Matrices.trace(Rk*Vk);
      gamma_k := Matrices.trace(Vk*Vk);

      if gamma_k > Modelica.Constants.eps then
        p := Polynomials.roots({4*gamma_k,6*beta_k,2*(alpha_k - 2*beta_k),
          -2*alpha_k});
        h := false;
        for i1 in 1:3 loop
          if abs(p[i1, 2]) < Modelica.Constants.eps then
            if abs(p[i1, 1] - 1) <= 1 then
              tk := p[i1, 1];
              h := true;
            end if;
          end if;
        end for;
        if not h then
          tk := 1;
        end if;

      else
        tk := 1;
      end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
tk = Matrices.Utilities.<strong>findLocal_tk</strong>(Rk, Vk);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <code>findLocal_tk()</code> is an auxiliary function called in iterative solver for algebraic Riccati equation based on Newton's method with
exact line search like <a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\">continuousRiccatiIterative</a><br>
and <a href=\"modelica://Modelica.Math.Matrices.Utilities.discreteRiccatiIterative\">discreteRiccatiIterative</a>.<br>
The function computes the local minimum of the function f_k(t_k)
</p>
<blockquote><pre>
f_k(t_k) = alpha_k*(1-t_k)^2 + 2*beta_k*(1-t)*t^2 + gamma_k*t^4
</pre></blockquote>
<p>
by calculating the zeros of the derivation d f_k/d t_k. It is known that the function f_k(t_k) has a local minimum at some value t_k_min in [0, 2].<br>
With t_k_min the norm of the next residual of the algorithm will be minimized.<br>
See [1] for more information
</p>
<h4>References</h4>
<blockquote><pre>
[1] Benner, P., Byers, R.
    An Exact Line Search Method for Solving Generalized Continuous-Time Algebraic Riccati Equations
    IEEE Transactions On Automatic Control, Vol. 43, No. 1, pp. 101-107, 1998.
</pre></blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\">Matrices.Utilities.continuousRiccatiIterative</a><br>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.discreteRiccatiIterative\">Matrices.Utilities.discreteRiccatiIterative</a><br>
</html>", revisions="<html>
<ul>
<li><em>2010/04/30 </em>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end findLocal_tk;
    annotation (Documentation(info="<html>
<p>
This package contains utility functions that are utilized by higher level matrix functions.
These functions are usually not useful for an end-user.
</p>
</html>"));
  end Utilities;
  annotation (Documentation(info="<html>
<h4>Library content</h4>
<p>
This library provides functions operating on matrices. Below, the
functions are ordered according to categories and a typical
call of the respective function is shown.
Most functions are solely an interface to the external
<a href=\"modelica://Modelica.Math.Matrices.LAPACK\">LAPACK</a> library.
</p>

<p>
Note: A' is a short hand notation of transpose(A):
</p>

<p><strong>Basic Information</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.toString\">toString</a>(A)
     - returns the string representation of matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.isEqual\">isEqual</a>(M1, M2)
     - returns true if matrices M1 and M2 have the same size and the same elements.</li>
</ul>

<p><strong>Linear Equations</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.solve\">solve</a>(A,b)
     - returns solution x of the linear equation A*x=b (where b is a vector,
       and A is a square matrix that must be regular).</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.solve2\">solve2</a>(A,B)
     - returns solution X of the linear equation A*X=B (where B is a matrix,
       and A is a square matrix that must be regular)</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.leastSquares\">leastSquares</a>(A,b)
     - returns solution x of the linear equation A*x=b in a least squares sense
       (where b is a vector and A may be non-square and may be rank deficient)</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">leastSquares2</a>(A,B)
     - returns solution X of the linear equation A*X=B in a least squares sense
       (where B is a matrix and A may be non-square and may be rank deficient)</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.equalityLeastSquares\">equalityLeastSquares</a>(A,a,B,b)
     - returns solution x of a linear equality constrained least squares problem:
       min|A*x-a|^2 subject to B*x=b</li>

<li> (LU,p,info) = <a href=\"modelica://Modelica.Math.Matrices.LU\">LU</a>(A)
     - returns the LU decomposition with row pivoting of a rectangular matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.LU_solve\">LU_solve</a>(LU,p,b)
     - returns solution x of the linear equation L*U*x[p]=b with a b
       vector and an LU decomposition from \"LU(..)\".</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.LU_solve2\">LU_solve2</a>(LU,p,B)
     - returns solution X of the linear equation L*U*X[p,:]=B with a B
       matrix and an LU decomposition from \"LU(..)\".</li>
</ul>

<p><strong>Matrix Factorizations</strong></p>
<ul>
<li> (eval,evec) = <a href=\"modelica://Modelica.Math.Matrices.eigenValues\">eigenValues</a>(A)
     - returns eigen values \"eval\" and eigen vectors \"evec\" for a real,
       nonsymmetric matrix A in a Real representation.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.eigenValueMatrix\">eigenValueMatrix</a>(eval)
     - returns real valued block diagonal matrix of the eigenvalues \"eval\" of matrix A.</li>

<li> (sigma,U,VT) = <a href=\"modelica://Modelica.Math.Matrices.singularValues\">singularValues</a>(A)
     - returns singular values \"sigma\" and left and right singular vectors U and VT
       of a rectangular matrix A.</li>

<li> (Q,R,p) = <a href=\"modelica://Modelica.Math.Matrices.QR\">QR</a>(A)
     - returns the QR decomposition with column pivoting of a rectangular matrix A
       such that Q*R = A[:,p].</li>

<li> (H,U) = <a href=\"modelica://Modelica.Math.Matrices.hessenberg\">hessenberg</a>(A)
     - returns the upper Hessenberg form H and the orthogonal transformation matrix U
       of a square matrix A such that H = U'*A*U.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.realSchur\">realSchur</a>(A)
     - returns the real Schur form of a square matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.cholesky\">cholesky</a>(A)
     - returns the cholesky factor H of a real symmetric positive definite matrix A so that A = H'*H.</li>

<li> (D,Aimproved) = <a href=\"modelica://Modelica.Math.Matrices.balance\">balance</a>(A)
     - returns an improved form Aimproved of a square matrix A that has a smaller condition as A,
       with Aimproved = inv(diagonal(D))*A*diagonal(D).</li>
</ul>

<p><strong>Matrix Properties</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.trace\">trace</a>(A)
     - returns the trace of square matrix A, i.e., the sum of the diagonal elements.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.det\">det</a>(A)
     - returns the determinant of square matrix A (using LU decomposition; try to avoid det(..))</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.inv\">inv</a>(A)
     - returns the inverse of square matrix A (try to avoid, use instead \"solve2(..) with B=identity(..))</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.rank\">rank</a>(A)
     - returns the rank of square matrix A (computed with singular value decomposition)</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.conditionNumber\">conditionNumber</a>(A)
     - returns the condition number norm(A)*norm(inv(A)) of a square matrix A in the range 1..&infin;.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.rcond\">rcond</a>(A)
     - returns the reciprocal condition number 1/conditionNumber(A) of a square matrix A in the range 0..1.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.norm\">norm</a>(A)
     - returns the 1-, 2-, or infinity-norm of matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.frobeniusNorm\">frobeniusNorm</a>(A)
     - returns the Frobenius norm of matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.nullSpace\">nullSpace</a>(A)
     - returns the null space of matrix A.</li>
</ul>

<p><strong>Matrix Exponentials</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.exp\">exp</a>(A)
     - returns the exponential e^A of a matrix A by adaptive Taylor series
       expansion with scaling and balancing</li>

<li> (phi, gamma) = <a href=\"modelica://Modelica.Math.Matrices.integralExp\">integralExp</a>(A,B)
     - returns the exponential phi=e^A and the integral gamma=integral(exp(A*t)*dt)*B as needed
       for a discretized system with zero order hold.</li>

<li> (phi, gamma, gamma1) = <a href=\"modelica://Modelica.Math.Matrices.integralExpT\">integralExpT</a>(A,B)
     - returns the exponential phi=e^A, the integral gamma=integral(exp(A*t)*dt)*B,
       and the time-weighted integral gamma1 = integral((T-t)*exp(A*t)*dt)*B as needed
       for a discretized system with first order hold.</li>
</ul>

<p><strong>Matrix Equations</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.continuousLyapunov\">continuousLyapunov</a>(A,C)
     - returns solution X of the continuous-time Lyapunov equation X*A + A'*X = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.continuousSylvester\">continuousSylvester</a>(A,B,C)
     - returns solution X of the continuous-time Sylvester equation A*X + X*B = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">continuousRiccati</a>(A,B,R,Q)
     - returns solution X of the continuous-time algebraic Riccati equation
       A'*X + X*A - X*B*inv(R)*B'*X + Q = 0</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteLyapunov\">discreteLyapunov</a>(A,C)
     - returns solution X of the discrete-time Lyapunov equation A'*X*A + sgn*X = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteSylvester\">discreteSylvester</a>(A,B,C)
     - returns solution X of the discrete-time Sylvester equation A*X*B + sgn*X = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">discreteRiccati</a>(A,B,R,Q)
     - returns solution X of the discrete-time algebraic Riccati equation
       A'*X*A - X - A'*X*B*inv(R + B'*X*B)*B'*X*A + Q = 0</li>
</ul>

<p><strong>Matrix Manipulation</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.sort\">sort</a>(M)
     - returns the sorted rows or columns of matrix M in ascending or descending order.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.flipLeftRight\">flipLeftRight</a>(M)
     - returns matrix M so that the columns of M are flipped in left/right direction.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.flipUpDown\">flipUpDown</a>(M)
     - returns matrix M so that the rows of M are flipped in up/down direction.</li>
</ul>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Vectors\">Vectors</a>

</html>"), Icon(graphics={
        Rectangle(
          extent={{-60,66},{-30,18}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,66},{58,18}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-18},{-30,-66}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,-18},{58,-66}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}));
end Matrices;

package Icons "Icons for Math"
  extends Modelica.Icons.IconsPackage;

  partial function AxisLeft
    "Basic icon for mathematical function with y-axis on left side"

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            textColor={0,0,255})}),
      Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis on the left side.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
  end AxisLeft;

  partial function AxisCenter
    "Basic icon for mathematical function with y-axis in the center"

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            textColor={0,0,255})}),
      Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis in the middle.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
  end AxisCenter;

end Icons;

function isEqual "Determine if two Real scalars are numerically identical"
  extends Modelica.Icons.Function;
  input Real s1 "First scalar";
  input Real s2 "Second scalar";
  input Real eps(min=0) = 0
    "The two scalars are identical if abs(s1-s2) <= eps";
  output Boolean result "= true, if scalars are identical";
algorithm
  result := abs(s1 - s2) <= eps;
  annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Math.<strong>isEqual</strong>(s1, s2);
Math.<strong>isEqual</strong>(s1, s2, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Math.isEqual(s1, s2)</code>\" returns <strong>true</strong>,
if the two Real scalars s1 and s2 are identical. Otherwise the function
returns <strong>false</strong>. The equality check is performed by
\"abs(s1-s2) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real s1 = 2.0;
  Real s2 = 2.0;
  Real s3 = 2.000001;
  Boolean result;
<strong>algorithm</strong>
  result := Math.isEqual(s1,s2);     // = <strong>true</strong>
  result := Math.isEqual(s1,s3);     // = <strong>false</strong>
  result := Math.isEqual(s1,s3,0.1); // = <strong>true</strong>
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>,
<a href=\"modelica://Modelica.Math.Matrices.isEqual\">Matrices.isEqual</a>,
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
</p>
</html>"));
end isEqual;

function sin "Sine"
  extends Modelica.Math.Icons.AxisLeft;
  input Modelica.Units.SI.Angle u "Independent variable";
  output Real y "Dependent variable y=sin(u)";

external "builtin" y = sin(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},
              {-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},
              {-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},
              {29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{
              57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}),
        Text(
          extent={{12,84},{84,36}},
          textColor={192,192,192},
          textString="sin")}),
    Documentation(info="<html>
<p>
This function returns y = sin(u), with -&infin; &lt; u &lt; &infin;:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/sin.png\">
</div>
</html>"));
end sin;

function cos "Cosine"
  extends Modelica.Math.Icons.AxisLeft;
  input Modelica.Units.SI.Angle u "Independent variable";
  output Real y "Dependent variable y=cos(u)";

external "builtin" y = cos(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-74.4,78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},
              {-48.6,26.6},{-29.3,-32.5},{-22.1,-51.7},{-15.7,-65.3},{-10.1,-73.8},
              {-4.42,-78.8},{1.21,-79.9},{6.83,-77.1},{12.5,-70.6},{18.1,-60.6},
              {24.5,-45.7},{32.6,-23},{50.3,31.3},{57.5,50.7},{63.9,64.6},{69.5,
              73.4},{75.2,78.6},{80,80}}),
        Text(
          extent={{-36,82},{36,34}},
          textColor={192,192,192},
          textString="cos")}),
    Documentation(info="<html>
<p>
This function returns y = cos(u), with -&infin; &lt; u &lt; &infin;:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/cos.png\">
</div>
</html>"));
end cos;

function tan "Tangent (u shall not be -pi/2, pi/2, 3*pi/2, ...)"
  extends Modelica.Math.Icons.AxisCenter;
  input Modelica.Units.SI.Angle u "Independent variable";
  output Real y "Dependent variable y=tan(u)";

external "builtin" y = tan(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-78.4,-68.4},{-76.8,-59.7},{-74.4,-50},{-71.2,-40.9},
              {-67.1,-33},{-60.7,-24.8},{-51.1,-17.2},{-35.8,-9.98},{-4.42,-1.07},
              {33.4,9.12},{49.4,16.2},{59.1,23.2},{65.5,30.6},{70.4,39.1},{73.6,
              47.4},{76,56.1},{77.6,63.8},{80,80}}),
        Text(
          extent={{-90,72},{-18,24}},
          textColor={192,192,192},
          textString="tan")}),
    Documentation(info="<html>
<p>
This function returns y = tan(u), with -&infin; &lt; u &lt; &infin;
(if u is a multiple of (2n-1)*pi/2, y = tan(u) is +/- infinity).
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/tan.png\">
</div>
</html>"));
end tan;

function asin "Inverse sine (-1 <= u <= 1)"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Modelica.Units.SI.Angle y "Dependent variable y=asin(u)";

external "builtin" y = asin(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,
              -49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,
              52.7},{75.2,62.2},{77.6,67.5},{80,80}}),
        Text(
          extent={{-88,78},{-16,30}},
          textColor={192,192,192},
          textString="asin")}),
    Documentation(info="<html>
<p>
This function returns y = asin(u), with -1 &le; u &le; +1:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/asin.png\">
</div>
</html>"));
end asin;

function acos "Inverse cosine (-1 <= u <= 1)"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Modelica.Units.SI.Angle y "Dependent variable y=acos(u)";

external "builtin" y = acos(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-79.2,72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,
              49.8},{-53.5,37.3},{-30.2,19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},
              {75.2,-62.2},{77.6,-67.5},{80,-80}}),
        Text(
          extent={{-86,-14},{-14,-62}},
          textColor={192,192,192},
          textString="acos")}),
    Documentation(info="<html>
<p>
This function returns y = acos(u), with -1 &le; u &le; +1:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/acos.png\">
</div>
</html>"));
end acos;

function atan "Inverse tangent"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Modelica.Units.SI.Angle y "Dependent variable y=atan(u)";

external "builtin" y = atan(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-52.7,-75.2},{-37.4,-69.7},{-26.9,-63},{-19.7,-55.2},
              {-14.1,-45.8},{-10.1,-36.4},{-6.03,-23.9},{-1.21,-5.06},{5.23,21},
              {9.25,34.1},{13.3,44.2},{18.1,52.9},{24.5,60.8},{33.4,67.6},{47,
              73.6},{69.5,78.6},{80,80}}),
        Text(
          extent={{-86,68},{-14,20}},
          textColor={192,192,192},
          textString="atan")}),
    Documentation(info="<html>
<p>
This function returns y = atan(u), with -&infin; &lt; u &lt; &infin;:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/atan.png\">
</div>
</html>"));
end atan;

function atan2 "Four quadrant inverse tangent"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u1 "First independent variable";
  input Real u2 "Second independent variable";
  output Modelica.Units.SI.Angle y "Dependent variable y=atan2(u1, u2)=atan(u1/u2)";

external "builtin" y = atan2(u1, u2);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},
              {69.9,-45.8},{80,-45.1}}),
        Line(points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
              62.1,33.5},{80,34.9}}),
        Line(points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,
              65.8},{-1.82,77.2},{0,80}}),
        Text(
          extent={{-90,-46},{-18,-94}},
          textColor={192,192,192},
          textString="atan2")}),
    Documentation(info="<html>
<p>
This function returns y = atan2(u1,u2) such that tan(y) = u1/u2 and
y is in the range -pi &lt; y &le; pi. u2 may be zero, provided
u1 is not zero. Usually u1, u2 is provided in such a form that
u1 = sin(y) and u2 = cos(y):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/atan2.png\">
</div>

</html>"));
end atan2;

function atan3
  "Four quadrant inverse tangent (select solution that is closest to given angle y0)"
  import Modelica.Constants.pi;
  extends Modelica.Math.Icons.AxisCenter;
  input Real u1 "First independent variable";
  input Real u2 "Second independent variable";
  input Modelica.Units.SI.Angle y0=0 "y shall be in the range: -pi < y-y0 <= pi";
  output Modelica.Units.SI.Angle y "Dependent variable y=atan3(u1, u2, y0)=atan(u1/u2)";

protected
  constant Real pi2=2*pi;
  Real w;
algorithm
  w := Math.atan2(u1, u2);
  if y0 == 0 then
    // For the default (y0 = 0), exactly the same result as with atan2(..) is returned
    y := w;
  else
    /* -pi < y - y0 <= pi
       -pi < w + 2*pi*N - y0 <= pi
       (-pi+y0-w)/(2*pi) < N <= (pi+y0-w)/(2*pi)
       -> N := integer( (pi+y0-w)/(2*pi) )
    */
    y := w + pi2*integer((pi+y0-w)/pi2);
  end if;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},
              {69.9,-45.8},{80,-45.1}}),
        Line(points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
              62.1,33.5},{80,34.9}}),
        Line(points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,
              65.8},{-1.82,77.2},{0,80}}),
        Text(
          extent={{-90,-46},{-18,-94}},
          textColor={192,192,192},
          textString="atan3")}),
    Documentation(info="<html>
<p>
This function returns y = <strong>atan3</strong>(u1,u2,y0) such that
<strong>tan</strong>(y) = u1/u2 and
y is in the range: -pi &lt; y-y0 &le; pi.<br>
u2 may be zero, provided u1 is not zero. The difference to
Modelica.Math.atan2(..) is the optional third argument y0 that
allows to specify which of the infinite many solutions
shall be returned:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/atan3.png\">
</div>

<p>
Note, for the default case (y0=0), exactly the same result as with atan2(..)
is returned.
</p>
</html>"));
end atan3;

function sinh "Hyperbolic sine"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Real y "Dependent variable y=sinh(u)";

external "builtin" y = sinh(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-76,-65.4},{-71.2,-51.4},{-65.5,-38.8},{-59.1,-28.1},
              {-51.1,-18.7},{-41.4,-11.4},{-27.7,-5.5},{-4.42,-0.653},{24.5,
              4.57},{39,10.1},{49.4,17.2},{57.5,25.9},{63.9,35.8},{69.5,47.4},{
              74.4,60.4},{78.4,73.8},{80,80}}),
        Text(
          extent={{-88,80},{-16,32}},
          textColor={192,192,192},
          textString="sinh")}),
    Documentation(info="<html>
<p>
This function returns y = sinh(u), with -&infin; &lt; u &lt; &infin;:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/sinh.png\">
</div>
</html>"));
end sinh;

function cosh "Hyperbolic cosine"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Real y "Dependent variable y=cosh(u)";

external "builtin" y = cosh(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,-86.083},{68,-86.083}}, color={192,192,192}),
        Polygon(
          points={{90,-86.083},{68,-78.083},{68,-94.083},{90,-86.083}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-77.6,61.1},{-74.4,39.3},{-71.2,20.7},{-67.1,
              1.29},{-63.1,-14.6},{-58.3,-29.8},{-52.7,-43.5},{-46.2,-55.1},{-39,
              -64.3},{-30.2,-71.7},{-18.9,-77.1},{-4.42,-79.9},{10.9,-79.1},{
              23.7,-75.2},{34.2,-68.7},{42.2,-60.6},{48.6,-51.2},{54.3,-40},{
              59.1,-27.5},{63.1,-14.6},{67.1,1.29},{71.2,20.7},{74.4,39.3},{
              77.6,61.1},{80,80}}),
        Text(
          extent={{4,66},{66,20}},
          textColor={192,192,192},
          textString="cosh")}),
    Documentation(info="<html>
<p>
This function returns y = cosh(u), with -&infin; &lt; u &lt; &infin;:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/cosh.png\">
</div>
</html>"));
end cosh;

function tanh "Hyperbolic tangent"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Real y "Dependent variable y=tanh(u)";

external "builtin" y = tanh(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-47.8,-78.7},{-35.8,-75.7},{-27.7,-70.6},{-22.1,
              -64.2},{-17.3,-55.9},{-12.5,-44.3},{-7.64,-29.2},{-1.21,-4.82},{
              6.83,26.3},{11.7,42},{16.5,54.2},{21.3,63.1},{26.9,69.9},{34.2,75},
              {45.4,78.4},{72,79.9},{80,80}}),
        Text(
          extent={{-88,72},{-16,24}},
          textColor={192,192,192},
          textString="tanh")}),
    Documentation(info="<html>
<p>
This function returns y = tanh(u), with -&infin; &lt; u &lt; &infin;:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\">
</div>
</html>"));
end tanh;

function asinh "Inverse of sinh (area hyperbolic sine)"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Real y "Dependent variable y=asinh(u)";

algorithm
  y := Modelica.Math.log(u + sqrt(u*u + 1));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-56.7,-68.4},{-39.8,-56.8},{-26.9,-44.7},{-17.3,
              -32.4},{-9.25,-19},{9.25,19},{17.3,32.4},{26.9,44.7},{39.8,56.8},
              {56.7,68.4},{80,80}}),
        Text(
          extent={{-90,80},{-6,26}},
          textColor={192,192,192},
          textString="asinh")}),
    Documentation(info="<html>
<p>
The function returns the area hyperbolic sine of its
input argument u. This inverse of sinh(..) is unique
and there is no restriction on the input argument u of
asinh(u) (-&infin; &lt; u &lt; &infin;):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/asinh.png\">
</div>
</html>"));
end asinh;

function acosh "Inverse of cosh (area hyperbolic cosine)"
  extends Modelica.Math.Icons.AxisLeft;
  input Real u "Independent variable";
  output Real y "Dependent variable y=acosh(u)";

algorithm
  assert(u >= 1.0, "Input argument u (= " + String(u) +
    ") of acosh(u) must be >= 1.0");
  y := Modelica.Math.log(u + sqrt(u*u - 1));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-66,-80},{-65.2,-66},{-64.4,-60.3},{-62.8,-52.2},{-60.4,-43.4},
              {-56.4,-32.4},{-49.9,-19.3},{-41.1,-5.65},{-29,8.8},{-12.9,23.8},
              {7.97,39.2},{35.3,55},{69.9,70.8},{94,80}}),
        Text(
          extent={{-14,2},{76,-54}},
          textColor={192,192,192},
          textString="arcosh")}),
    Documentation(info="<html>
<p>
This function returns the area hyperbolic cosine of its
input argument u. The valid range of u is
</p>
<blockquote><pre>
+1 &le; u &lt; +&infin;
</pre></blockquote>
<p>
If the function is called with u &lt; 1, an error occurs.
The function cosh(u) has two inverse functions (the curve
looks similar to a sqrt(..) function). acosh(..) returns
the inverse that is positive. At u=1, the derivative dy/du is infinite.
Therefore, this function should not be used in a model, if u
can become close to 1:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/acosh.png\">
</div>
</html>"));
end acosh;

function exp "Exponential, base e"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Real y "Dependent variable y=exp(u)";

external "builtin" y = exp(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,-80.3976},{68,-80.3976}}, color={192,192,192}),
        Polygon(
          points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},
              {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
              67.1,18.6},{72,38.2},{76,57.6},{80,80}}),
        Text(
          extent={{-86,50},{-14,2}},
          textColor={192,192,192},
          textString="exp")}),
    Documentation(info="<html>
<p>
This function returns y = exp(u), with -&infin; &lt; u &lt; &infin;:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\">
</div>
</html>"));
end exp;

function log "Natural (base e) logarithm (u shall be > 0)"
  extends Modelica.Math.Icons.AxisLeft;
  input Real u "Independent variable";
  output Real y "Dependent variable y=ln(u)";

external "builtin" y = log(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},
              {-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},
              {-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}}),
        Text(
          extent={{-6,-24},{66,-72}},
          textColor={192,192,192},
          textString="log")}),
    Documentation(info="<html>
<p>
This function returns y = log(10) (the natural logarithm of u),
with u &gt; 0:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/log.png\">
</div>
</html>"));
end log;

function log10 "Base 10 logarithm (u shall be > 0)"
  extends Modelica.Math.Icons.AxisLeft;
  input Real u "Independent variable";
  output Real y "Dependent variable y=lg(u)";

external "builtin" y = log10(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-79.8,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},
              {-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},
              {-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}}),
        Text(
          extent={{-30,-22},{60,-70}},
          textColor={192,192,192},
          textString="log10")}),
    Documentation(info="<html>
<p>
This function returns y = log10(u),
with u &gt; 0:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/log10.png\">
</div>
</html>"));
end log10;

annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
          {100,100}}), graphics={Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},
            {-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{
            -26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,
            -50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},
            {51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={
            0,0,0}, smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
This package contains <strong>basic mathematical functions</strong> (such as sin(..)),
as well as functions operating on
<a href=\"modelica://Modelica.Math.Vectors\">vectors</a>,
<a href=\"modelica://Modelica.Math.Matrices\">matrices</a>,
<a href=\"modelica://Modelica.Math.Nonlinear\">nonlinear functions</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors\">Boolean vectors</a>.
</p>

<h4>Main Authors</h4>
<p><a href=\"http://www.robotic.dlr.de/Martin.Otter/\"><strong>Martin Otter</strong></a>
and <strong>Marcus Baur</strong><br>
Deutsches Zentrum f&uuml;r Luft- und Raumfahrt e.V. (DLR)<br>
Institut f&uuml;r Systemdynamik und Regelungstechnik (DLR-SR)<br>
Forschungszentrum Oberpfaffenhofen<br>
D-82234 Wessling<br>
Germany<br>
email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a>
</p>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>", revisions="<html>
<ul>
<li><em>June 22, 2019</em>
       by Thomas Beutlich: Functions tempInterpol1/tempInterpol2 moved to ObsoleteModelica4</li>
<li><em>August 24, 2016</em>
       by Christian Kral: added wrapAngle</li>
<li><em>October 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       Function tempInterpol2 added.</li>
<li><em>Oct. 24, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Icons for icon and diagram level introduced.</li>
<li><em>June 30, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"));
end Math;
