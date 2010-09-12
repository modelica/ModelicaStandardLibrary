within Modelica;
package Math "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
import SI = Modelica.SIunits;

extends Modelica.Icons.Package;

package Vectors "Library of functions operating on vectors"
  extends Modelica.Icons.Package;

  function toString "Convert a real vector in to a string representation"
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
      s := if name=="" then "[]" else name + " = []";
    else
      s := if name=="" then "\n" else "\n" + name + " = \n";
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

    annotation (Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<b>toString</b>(v);
Vectors.<b>toString</b>(v,name=\"\",significantDigits=6);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<b>toString</b>(v)</code>\" returns the string representation of vector <b>v</b>.
With the optional arguments \"name\" and \"significantDigits\" a name and the number of the digits are defined.
The default values of \"name\" and \"significantDigits\" are \"\" and 6 respectively. If name==\"\" (empty string) then the prefix \"&lt;name&gt; =\" is leaved out at the output-string.

<h4>Example</h4>
<blockquote><pre>
  v = {2.12, -4.34, -2.56, -1.67};
  <b>toString</b>(v);
                         // = \"
                         //           2.12
                         //          -4.34
                         //          -2.56
                         //          -1.67\"
  <b>toString</b>(v,\"vv\",1);
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
</HTML>",   revisions="<html>

</html>"));
  end toString;

  function isEqual "Determine if two Real vectors are numerically identical"
    extends Modelica.Icons.Function;
    input Real v1[:] "First vector";
    input Real v2[:] "Second vector (may have different length as v1";
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
    annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<b>isEqual</b>(v1, v2);
Vectors.<b>isEqual</b>(v1, v2, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.isEqual(v1, v2)</code>\" returns <b>true</b>,
if the two Real vectors v1 and v2 have the same dimensions and
the same elements. Otherwise the function
returns <b>false</b>. Two elements e1 and e2 of the two vectors
are checked on equality by the test \"abs(e1-e2) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real v1[3] = {1, 2, 3};
  Real v2[3] = {1, 2, 3, 4};
  Real v3[3] = {1, 2, 3.0001};
  Boolean result;
<b>algorithm</b>
  result := Vectors.isEqual(v1,v2);     // = <b>false</b>
  result := Vectors.isEqual(v1,v3);     // = <b>false</b>
  result := Vectors.isEqual(v1,v1);     // = <b>true</b>
  result := Vectors.isEqual(v1,v3,0.1); // = <b>true</b>
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.find\">Vectors.find</a>,
<a href=\"modelica://Modelica.Math.Matrices.isEqual\">Matrices.isEqual</a>,
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
</p>
</HTML>"));
  end isEqual;

  function norm "Return the p-norm of a vector"
    extends Modelica.Icons.Function;
    input Real v[:] "Vector";
    input Real p(min=1) = 2
      "Type of p-norm (often used: 1, 2, or Modelica.Constants.inf)";
    output Real result "p-norm of vector v";

  algorithm
    if p == 2 then
      result:=sqrt(v*v);
    elseif p == Modelica.Constants.inf then
      result:=max(abs(v));
    elseif p == 1 then
      result:=sum(abs(v));
    else
      result:=(sum(abs(v[i])^p for i in 1:size(v, 1)))^(1/p);
    end if;
    annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<b>norm</b>(v);
Vectors.<b>norm</b>(v,p=2);   // 1 &le; p &le; &#8734;
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<b>norm</b>(v)</code>\" returns the
<b>Euclidean norm</b> \"<code>sqrt(v*v)</code>\" of vector v.
With the optional
second argument \"p\", any other p-norm can be computed:
</p>
<center>
<IMG src=\"modelica://Modelica/Resources/Images/Math/Vectors/vectorNorm.png\" ALT=\"function Vectors.norm\">
</center>
<p>
Besides the Euclidean norm (p=2), also the 1-norm and the
infinity-norm are sometimes used:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>1-norm</b></td>
      <td valign=\"top\">= sum(abs(v))</td>
      <td valign=\"top\"><b>norm</b>(v,1)</td>
  </tr>
  <tr><td valign=\"top\"><b>2-norm</b></td>
      <td valign=\"top\">= sqrt(v*v)</td>
      <td valign=\"top\"><b>norm</b>(v) or <b>norm</b>(v,2)</td>
  </tr>
  <tr><td valign=\"top\"><b>infinity-norm</b></td>
      <td valign=\"top\">= max(abs(v))</td>
      <td valign=\"top\"><b>norm</b>(v,Modelica.Constants.<b>inf</b>)</td>
  </tr>
</table>
<p>
Note, for any vector norm the following inequality holds:
</p>
<blockquote><pre>
<b>norm</b>(v1+v2,p) &le; <b>norm</b>(v1,p) + <b>norm</b>(v2,p)
</pre></blockquote>
<h4>Example</h4>
<blockquote><pre>
  v = {2, -4, -2, -1};
  <b>norm</b>(v,1);    // = 9
  <b>norm</b>(v,2);    // = 5
  <b>norm</b>(v);      // = 5
  <b>norm</b>(v,10.5); // = 4.00052597412635
  <b>norm</b>(v,Modelica.Constants.inf);  // = 4
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.norm\">Matrices.norm</a>
</p>
</HTML>"));
  end norm;

  function length
    "Return length of a vectorReturn length of a vector (better as norm(), if further symbolic processing is performed)"
    extends Modelica.Icons.Function;
    input Real v[:] "Vector";
    output Real result "Length of vector v";
  algorithm
    result := sqrt(v*v);
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<b>length</b>(v);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<b>length</b>(v)</code>\" returns the
<b>Euclidean length</b> \"<code>sqrt(v*v)</code>\" of vector v.
The function call is equivalent to Vectors.norm(v). The advantage of
length(v) over norm(v)\"is that function length(..) is implemented
in one statement and therefore the function is usually automatically
inlined. Further symbolic processing is therefore possible, which is
not the case with function norm(..).
</p>
<h4>Example</h4>
<blockquote><pre>
  v = {2, -4, -2, -1};
  <b>length</b>(v);  // = 5
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
    input Real v[:] "Vector";
    input Real eps = 100*Modelica.Constants.eps
      "if |v| < eps then result = v/eps";
    output Real result[size(v, 1)] "Input vector v normalized to length=1";

  algorithm
    result := smooth(0,noEvent(if length(v) >= eps then v/length(v) else v/eps));
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<b>normalize</b>(v);
Vectors.<b>normalize</b>(v,eps=100*Modelica.Constants.eps);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<b>normalize</b>(v)</code>\" returns the
<b>unit vector</b> \"<code>v/length(v)</code>\" of vector v.
If length(v) is close to zero (more precisely, if length(v) &lt; eps),
v/eps is returned in order to avoid
a division by zero. For many applications this is useful, because
often the unit vector <b>e</b> = <b>v</b>/length(<b>v</b>) is used to compute
a vector x*<b>e</b>, where the scalar x is in the order of length(<b>v</b>),
i.e., x*<b>e</b> is small, when length(<b>v</b>) is small and then
it is fine to replace <b>e</b> by <b>v</b> to avoid a division by zero.
</p>
<p>
Since the function is implemented in one statement,
it is usually inlined and therefore symbolic processing is
possible.
</p>
<h4>Example</h4>
<blockquote><pre>
  <b>normalize</b>({1,2,3});  // = {0.267, 0.534, 0.802}
  <b>normalize</b>({0,0,0});  // = {0,0,0}
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.length\">Vectors.length</a>
</p>
</html>"));
  end normalize;

  function reverse "Reverse vector elements (e.g., v[1] becomes last element)"
    extends Modelica.Icons.Function;
    input Real v[:] "Vector";
    output Real result[size(v, 1)] "Elements of vector v in reversed order";

  algorithm
    result := {v[end-i+1] for i in 1:size(v,1)};
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<b>reverse</b>(v);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<b>reverse</b>(v)</code>\" returns the
vector elements in reverse order.
</p>
<h4>Example</h4>
<blockquote><pre>
  <b>reverse</b>({1,2,3,4});  // = {4,3,2,1}
</pre></blockquote>
</html>"));
  end reverse;

  function sort "Sort elements of vector in ascending or descending order"
    extends Modelica.Icons.Function;
    input Real v[:] "Vector to be sorted";
    input Boolean ascending = true
      "= true if ascending order, otherwise descending order";
    output Real sorted_v[size(v,1)] = v "Sorted vector";
    output Integer indices[size(v,1)] = 1:size(v,1) "sorted_v = v[indices]";

    /* shellsort algorithm; should be improved later */
  protected
    Integer gap;
    Integer i;
    Integer j;
    Real wv;
    Integer wi;
    Integer nv = size(v,1);
    Boolean swap;
  algorithm
    gap := div(nv,2);

    while gap > 0 loop
       i := gap;
       while i < nv loop
          j := i-gap;
          if j>=0 then
             if ascending then
                swap := sorted_v[j+1] > sorted_v[j + gap + 1];
             else
                swap := sorted_v[j+1] < sorted_v[j + gap + 1];
             end if;
          else
             swap := false;
          end if;

          while swap loop
             wv := sorted_v[j+1];
             wi := indices[j+1];
             sorted_v[j+1] := sorted_v[j+gap+1];
             sorted_v[j+gap+1] := wv;
             indices[j+1] := indices[j+gap+1];
             indices[j+gap+1] := wi;
             j := j - gap;
             if j >= 0 then
                if ascending then
                   swap := sorted_v[j+1] > sorted_v[j + gap + 1];
                else
                   swap := sorted_v[j+1] < sorted_v[j + gap + 1];
                end if;
             else
                swap := false;
             end if;
          end while;
          i := i + 1;
       end while;
       gap := div(gap,2);
    end while;
    annotation (Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
           sorted_v = Vectors.<b>sort</b>(v);
(sorted_v, indices) = Vectors.<b>sort</b>(v, ascending=true);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>sort</b>(..) sorts a Real vector v
in ascending order and returns the result in sorted_v.
If the optional argument \"ascending\" is <b>false</b>, the vector
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
</HTML>"));
  end sort;

  function find "Find element in a vector"
    extends Modelica.Icons.Function;
    input Real e "Search for e";
    input Real v[:] "Integer vector";
    input Real eps(min=0) = 0
      "Element e is equal to a element v[i] of vectorv if abs(e-v[i]) <= eps";
    output Integer result
      "v[result] = e (first occurrence of e); result=0, if not found";
  protected
    Integer i;
  algorithm
    result := 0;
    i := 1;
    while i <= size(v, 1) loop
      if abs(v[i]-e)<=eps then
        result := i;
        i := size(v, 1) + 1;
      else
        i := i + 1;
      end if;
    end while;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<b>find</b>(e, v);
Vectors.<b>find</b>(e, v, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.find(e, v)</code>\" returns the index of the first occurence of input e in vector <b>v</b>.
The test of equality is performed by \"abs(e-v[i]) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real v[3] = {1, 2, 3};
  Real e1 = 2;
  Real e2 = 3.01;
  Boolean result;
<b>algorithm</b>
  result := Vectors.find(e1,v);          // = <b>2</b>
  result := Vectors.find(e2,v);          // = <b>0</b>
  result := Vectors.find(e2,v,eps=0.1);  // = <b>3</b>
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>
</p>
</html>"));
  end find;

  function interpolate "Interpolate in a vector"
    input Real x[ :]
      "Abszissa table vector (strict monotonically increasing values required)";
    input Real y[ size(x,1)] "Ordinate table vector";
    input Real xi "Desired abszissa value";
    input Integer iLast=1 "Index used in last search";
    output Real yi "Ordinate value corresponding to xi";
    output Integer iNew=1 "xi is in the interval x[iNew] <= xi < x[iNew+1]";
  protected
    Integer i;
    Integer nx=size(x,1);
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
      i := min(max(iLast,1),nx-1);
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
      x2 := x[i+1];
      y1 := y[i];
      y2 := y[i+1];

      assert(x2 > x1, "Abszissa table vector values must be increasing");
      // Interpolate
      yi := y1 + (y2 - y1)*(xi - x1)/(x2 - x1);
      iNew :=i;
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
// Real    x[:], y[:], xi, yi;
// Integer iLast, iNew;
        yi = Vectors.<b>interpolate</b>(x,y,xi);
(yi, iNew) = Vectors.<b>interpolate</b>(x,y,xi,iLast=1);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.interpolate(x,y,xi)</code>\" interpolates in vectors
(x,y) and returns the value yi that corresponds to xi. Vector x[:] must consist
of strictly monotonocially increasing values. If xi &lt; x[1] or &gt; x[end], then
extrapolation takes places through the first or last two x[:] values, respectively.
The search for the interval x[iNew] &le; xi &lt; x[iNew+1] starts at the optional
input argument \"iLast\". The index \"iNew\" is returned as output argument.
The usage of \"iLast\" and \"iNew\" is useful to increase the efficiency of the call,
if many interpolations take place.
</p>

<h4>Example</h4>

<blockquote><pre>
  Real x[:] = { 0,  2,  4,  6,  8, 10};
  Real y[:] = {10, 20, 30, 40, 50, 60};
<b>algorithm</b>
  (yi, iNew) := Vectors.interpolate(x,y,5);  // yi = 35, iNew=3
</pre></blockquote>

</html>"));
  end interpolate;

  function relNodePositions "Return vector of relative node positions (0..1)"
    input Integer nNodes
      "Number of nodes (including node at left and right position)";
    output Real xsi[nNodes] "Relative node positions";
  protected
    Real delta;
  algorithm
    if nNodes >= 1 then
       xsi[1] :=0;
    end if;

    if nNodes >= 2 then
       xsi[nNodes] :=1;
    end if;

    if nNodes == 3 then
       xsi[2] :=0.5;
    elseif nNodes > 3 then
       delta :=1/(nNodes - 2);
       for i in 2:nNodes-1 loop
          xsi[i] :=(i - 1.5)*delta;
       end for;
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<b>relNodePositions</b>(nNodes);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>relNodePositions(nNodes)</code>\" returns a vector
with the relative positions of the nodes of a discretized pipe with nNodes nodes (including the node
at the left and at the right side of the pipe), see next figure:
</p>

<blockquote><p>
<img src=\"modelica://Modelica/Resources/Images/Math/Vectors/relNodePositions.png\">
</p></blockquote>

<h4>Example</h4>

<blockquote><pre>
  Real xsi[7];
<b>algorithm</b>
  xsi = relNodePositions(7);  // xsi = {0, 0.1, 0.3, 0.5, 0.7, 0.9, 1}
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">MultiBody.Visualizers.PipeWithScalarField</a>
</p>
</html>"));
  end relNodePositions;

  package Utilities
    "Utility functions that should not be directly utilized by the user"
      extends Modelica.Icons.Package;
  function householderVector
      "Calculate a normalized householder vector to reflect vector a onto vector b"

      import Modelica.Math.Vectors.norm;

    input Real a[:] "Real vector to be reflected";
    input Real b[size(a, 1)] "Real vector b vector a is mapped onto";
    output Real u[size(a, 1)] "Housholder vector to map a onto b";
    protected
    Real norm_a=norm(a,2);
    Real norm_b=norm(b,2);
    Real alpha;

  algorithm
    assert(norm_b > 0, "Vector b in function housholderVector is zero vector, but at least one element should be different from zero");
    assert(norm_a > 0, "Vector a in function housholderVector is zero vector, but at least one element should be different from zero");
    alpha := if norm(a + norm_a/norm_b*b,2) > norm(a - norm_a/norm_b*b,2) then norm_a/norm_b else -norm_a/norm_b;
    u := (a + alpha*b)/length(a + alpha*b);

    annotation (Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.Utilities.<b>householderVector</b>(a,b);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>householderVector(a, b)</code>\" returns the normalized Householder vector
<b>u</b> for Householder reflection of input vector <b>a</b> onto vector <b>b</b>, i.e., Householder vector <b>u</b> is the normal
vector of the reflection plane. Algebraically, the reflection is performed by transformation matrix <b>Q</b>
</p>
<blockquote>
<p>
<b>Q</b> = <b>I</b> - 2*<b>u</b>*<b>u</b>',
</p>
</blockquote>
i.e., vector <b>a</b> is mapped to
<blockquote>
<p>
<b>a</b> -> <b>Q</b>*<b>a</b>=c*<b>b</b>
</p>
</blockquote>
with scalar c, |c| = ||<b>a</b>|| / ||<b>b</b>||. <b>Q</b>*<b>a</b> is the reflection of <b>a</b> about the hyperplane orthogonal to <b>u</b>.
<b>Q</b> is an orthogonal matrix, i.e.
<blockquote>
<p>
    <b>Q</b> = inv(<b>Q</b>) = <b>Q</b>'
</p>
</blockquote>
<h4>Example</h4>
<blockquote><pre>
  a = {2, -4, -2, -1};
  b = {1, 0, 0, 0};

  u = <b>householderVector</b>(a,b);    // {0.837, -0.478, -0.239, -0.119}
                               // Computation (identity(4) - 2*matrix(u)*transpose(matrix(u)))*a results in
                               // {-5, 0, 0, 0} = -5*b
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Vectors.Utilities.householderReflection\">Vectors.Utilities.householderReflection</a><br>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.householderReflection\">Matrices.Utilities.householderReflection</a><br>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.householderSimilarityTransformation\">Matrices.Utilities.householderSimilarityTransformation</a>
</HTML>

",   revisions="<html>
<ul>
<li><i>2010/04/30 </i>
       by Marcus Baur, DLR-RM</li>
</ul>

</html>"));
  end householderVector;

    function householderReflection
      "Reflect a vector a on a plane with orthogonal vector u"
      import Modelica.Math.Vectors;

      input Real a[:] "Real vector a to be reflected";
      input Real u[size(a, 1)] "householder vector";
      output Real ra[size(u, 1)] "reflexion of a";

    protected
      Real norm_a=Vectors.length(a);
      Real h=2*u*a;

    algorithm
      ra := a - h*u;

    // Values close to zero are set to zero.
      for i in 1:size(ra, 1) loop
        ra[i] := if abs(ra[i]) >= norm_a*1e-12 then ra[i] else 0;
      end for;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.Utilities.<b>householderReflection</b>(a,u);
</pre></blockquote>
<h4>Description</h4>
<p>
Function \"<code>householderReflection(a, u)</code>\" performs the reflection of vector
<b>a</b> about a plane orthogonal to vector <b>u</b> (Housholder vector).
Algebraically the operation is defined by
</p>
<blockquote>
<p>
<b>b</b>=<b>Q</b>*<b>a</b>
</p>
</blockquote>
with
<blockquote>
<p>
   <b>Q</b> = <b>I</b> - 2*<b>u</b>*<b>u</b>',
</p>
</blockquote>
where <b>Q</b> is an orthogonal matrix, i.e.
<blockquote>
<p>
    <b>Q</b> = inv(<b>Q</b>) = <b>Q</b>'
</p>
</blockquote>
<h4>Example</h4>
<blockquote><pre>
  a = {2, -4, -2, -1};
  u = {0.837, -0.478, -0.239, -0.119};

  <b>householderReflection</b>(a,u);    //  = {-5.0, -0.001, -0.0005, -0.0044}
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Vectors.Utilities.householderVector\">Utilities.householderVector</a><br>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.householderReflection\">Matrices.Utilities.householderReflection</a><br>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.householderSimilarityTransformation\">Matrices.Utilities.householderSimilarityTransformation</a>

</html>",     revisions="<html>
<ul>
<li><i>2010/04/30 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end householderReflection;

      encapsulated function roots
      "Compute zeros of a polynomial where the highest coefficient is assumed as not to be zero"
      import Modelica.Math.Matrices;

        input Real p[:]
        "Vector with polynomial coefficients p[1]*x^n + p[2]*x^(n-1) + p[n]*x +p[n-1]";
        output Real roots[max(0, size(p, 1) - 1),2]=fill(0, max(0, size(p, 1) - 1), 2)
        "roots[:,1] and roots[:,2] are the real and imaginary parts of the roots of polynomial p";
    protected
        Integer np=size(p, 1);
        Integer n=size(p, 1) - 1;
        Real A[max(n, 0),max(n, 0)] "Companion matrix";
        Real ev[max(n, 0),2] "Eigenvalues";
      algorithm
        if n > 0 then
          assert(abs(p[1]) > 0, "Computing the roots of a polynomial with function \"Modelica.Math.Vectors.Utilities.roots\"\n"
                              + "failed because the first element of the coefficient vector is zero, but should not be.");

          // companion matrix
          A[1, :] := -p[2:np]/p[1];
          A[2:n, :] := [identity(n - 1),zeros(n - 1)];

          // roots are the eigenvalues of the companion matrix
          roots := Matrices.Utilities.eigenvaluesHessenberg(A);
        end if;
        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
  r = Vectors.Utilities.<b>roots</b>(p);
</pre></blockquote>
<h4>Description</h4>
<p>
This function computes the roots of a polynomial P of x
</p>
<blockquote><pre>
  P = p[1]*x^n + p[2]*x^(n-1) + ... + p[n-1]*x + p[n+1];
</pre></blockquote>
<p>
with the coefficient vector <b>p</b>. It is assumed that the first element of <b>p</b> is not zero, i.e., that the polynomial is of order size(p,1)-1.
<p>
To compute the roots, the eigenvalues of the corresponding companion matrix <b>C</b>
<p>
<blockquote><pre>
         |-p[2]/p[1]  -p[3]/p[1]  ...  -p[n-2]/p[1]  -p[n-1]/p[1]  -p[n]/p[1] |
         |    1            0                0               0           0     |
         |    0            1      ...       0               0           0     |
  <b>C</b> =    |    .            .      ...       .               .           .     |
         |    .            .      ...       .               .           .     |
         |    0            0      ...       0               1           0     |
</pre></blockquote>
<p>
are calculated. These are the roots of the polynomial.<br>
Since the companion matrix has already Hessenberg form, the transformation to Hessenberg form has not to be performed.
Function <a href=\"modelica://Modelica.Math.Matrices.Utilities.eigenvaluesHessenberg\">eigenvaluesHessenberg</a><br>
provides efficient eigenvalue computation for those matrices.
</p>
<h4>Example</h4>
<blockquote><pre>
  r = <b>roots</b>({1,2,3});
  // r = [-1.0,  1.41421356237309;
  //      -1.0, -1.41421356237309]
  // which corresponds to the roots: -1.0 +/- j*1.41421356237309
</pre></blockquote>
</html>"));
      end roots;
    annotation (Documentation(info="<html>
<p>
This package contains utility functions that are utilized by higher level vector
and matrix functions. These functions are usually not useful for an end-user.
</p>

</html>"));
  end Utilities;

  annotation (
    preferedView = "info",
    Documentation(info="<HTML>
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
     - returns vector in direction of v with lenght = 1 and prevents
       zero-division for zero vector.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.reverse\">reverse</a>(v)
     - reverses the vector elements of v. </li>

<li> <a href=\"modelica://Modelica.Math.Vectors.sort\">sort</a>(v)
     - sorts the elements of vector v in ascending or descending order.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.find\">find</a>(e, v)
     - returns the index of the first occurence of scalar e in vector v.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.interpolate\">interpolate</a>(x, y, xi)
     - returns the interpolated value in (x,y) that corresponds to xi.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.relNodePositions\">relNodePositions</a>(nNodes)
     - returns a vector of relative node positions (0..1).</li>
</ul>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices\">Matrices</a>
</HTML>"));
end Vectors;

package Matrices "Library of functions operating on matrices"
  package Examples
    "Examples demonstrating the usage of the Math.Matrices functions"
    extends Modelica.Icons.ExamplesPackage;
    function solveLinearEquations
      "Demonstrate the solution of linear equation systems"
      import Modelica.Utilities.Streams.print;
      // solve and solve2
    protected
      Real A0[0,0];
      Real A1[2,2] = [1,2;3,4];
      Real x1_ref[2] = {-2,3};
      Real b1[2] = A1*x1_ref;
      Real x1[2];
      Real B2[2,3] = [b1, 2*b1, -3*b1];
      Real X2[2,3];

      // leastSquares and leastSquares2
      Integer rank;
      Real a[3] = {2,3,-1};
      Real A3[3,3] = transpose( [{2,3,-4}, a, 3*a]);
      Real x3_ref[3] = {-2,3,5};
      Real b3[3] = A3*x3_ref;
      Real x3[3];
      Real B3[3,2] = [b3, -3*b3];
      Real X3[3,2];

    algorithm
      print("\nDemonstrate how to solve linear equation systems:\n");

      // Solve regular linear equation with a right hand side vector
      x1 :=Math.Matrices.solve(A1, b1);
      print("diff1 = " + String(Vectors.norm(x1 - x1_ref)));

      // Solve regular linear equation with a right hand side matrix
      X2 :=Math.Matrices.solve2(A1, B2);
      print("diff2 = " + String(Matrices.norm(X2 - [x1_ref,2*x1_ref, -3*x1_ref])));

      // Solve singular linear equation with a right hand side vector
      (x3, rank) :=Math.Matrices.leastSquares(A3, b3);
      print("diff3 = " + String(Vectors.norm(A3*x3 - b3)) +
            ", n = " + String(size(A3,1)) + ", rank = " + String(rank));

      // Solve singular linear equation with a right hand side matrix
      (X3, rank) :=Math.Matrices.leastSquares2(A3, B3);
      print("diff4 = " + String(Matrices.norm(A3*X3 - B3)) +
            ", n = " + String(size(A3,1)) + ", rank = " + String(rank));

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

  function toString "Convert a matrix into its string representation "
    import Modelica.Utilities.Strings;

    input Real M[:,:] "Real matrix";
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
            Strings.repeat(significantDigits + 8 - Strings.length(String(abs(M[i,
            j]))));
        end for;
        s := s + "\n";
      end for;

    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>toString</b>(A);
Matrices.<b>toString</b>(A, name=\"\", significantDigits=6);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Matrices.<b>toString</b>(A)</code>\" returns the
string representation of matrix <b>A</b>.
With the optional arguments \"name\" and \"significantDigits\", a name and the number of the digits are defined.
The default values of name and significantDigits are \"\" and 6 respectively. If name==\"\" then the
prefix \"&lt;name&gt; =\" is leaved out.

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

</HTML>",   revisions="<html>
</html>"));
  end toString;

  extends Modelica.Icons.Package;

  function isEqual "Compare whether two Real matrices are identical"
    extends Modelica.Icons.Function;
    input Real M1[:, :] "First matrix";
    input Real M2[:, :] "Second matrix (may have different size as M1";
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

    annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>isEqual</b>(M1, M2);
Matrices.<b>isEqual</b>(M1, M2, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Matrices.isEqual(M1, M2)</code>\" returns <b>true</b>,
if the two Real matrices M1 and M2 have the same dimensions and
the same elements. Otherwise the function
returns <b>false</b>. Two elements e1 and e2 of the two matrices
are checked on equality by the test \"abs(e1-e2) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A1[2,2] = [1,2; 3,4];
  Real A2[3,2] = [1,2; 3,4; 5,6];
  Real A3[2,2] = [1,2, 3,4.0001];
  Boolean result;
<b>algorithm</b>
  result := Matrices.isEqual(M1,M2);     // = <b>false</b>
  result := Matrices.isEqual(M1,M3);     // = <b>false</b>
  result := Matrices.isEqual(M1,M1);     // = <b>true</b>
  result := Matrices.isEqual(M1,M3,0.1); // = <b>true</b>
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>,
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
</HTML>"));
  end isEqual;

  function solve
    "Solve real system of linear equations A*x=b with a b vector (Gaussian elemination with partial pivoting)"

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
    annotation (
      Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>solve</b>(A,b);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
solution <b>x</b> of the linear system of equations
</p>
<blockquote>
<p>
<b>A</b>*<b>x</b> = <b>b</b>
</p>
</blockquote>
<p>
If a unique solution <b>x</b> does not exist (since <b>A</b> is singular),
an assertion is triggered. If this is not desired, use instead
<a href=\"modelica://Modelica.Math.Matrices.leastSquares\">Matrices.leastSquares</a>
and inquire the singularity of the solution with the return argument rank
(a unique solution is computed if rank = size(A,1)).
</p>

<p>
Note, the solution is computed with the LAPACK function \"dgesv\",
i.e., by Gaussian elemination with partial pivoting.
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real b[3] = {10,22,12};
  Real x[3];
<b>algorithm</b>
  x := Matrices.solve(A,b);  // x = {3,2,1}
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
<a href=\"modelica://Modelica.Math.Matrices.leastSquares\">Matrices.leastSquares</a>.
</HTML>"));
  end solve;

  function solve2
    "Solve real system of linear equations A*X=B with a B matrix (Gaussian elemination with partial pivoting)"

    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "Matrix A of A*X = B";
    input Real B[size(A, 1),:] "Matrix B of A*X = B";
    output Real X[size(B, 1), size(B,2)] "Matrix X such that A*X = B";

  protected
    Integer info;
  algorithm
    (X,info) := LAPACK.dgesv(A, B);
    assert(info == 0, "Solving a linear system of equations with function
\"Matrices.solve2\" is not possible, because the system has either
no or infinitely many solutions (A is singular).");
    annotation (
      Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>solve2</b>(A,b);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
solution <b>X</b> of the linear system of equations
</p>
<blockquote>
<p>
<b>A</b>*<b>X</b> = <b>B</b>
</p>
</blockquote>
<p>
If a unique solution <b>X</b> does not exist (since <b>A</b> is singular),
an assertion is triggered. If this is not desired, use instead
<a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">Matrices.leastSquares2</a>
and inquire the singularity of the solution with the return argument rank
(a unique solution is computed if rank = size(A,1)).

</p>
<p>
Note, the solution is computed with the LAPACK function \"dgesv\",
i.e., by Gaussian elemination with partial pivoting.
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
<b>algorithm</b>
  (LU, pivots) := Matrices.LU(A);
  X := Matrices.solve2(A, B1);  /* X = [3, 6;
                                        2, 4;
                                        1, 2] */
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.LU_solve2\">Matrices.LU_solve2</a>,
<a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">Matrices.leastSquares2</a>.
</p>
</HTML>"));
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
    Real xx[max(size(A,1),size(A,2))];
  algorithm
    if min(size(A)) > 0 then
      (xx,info,rank) := LAPACK.dgelsx_vec(A, b, rcond);
       x := xx[1:size(A,2)];
       assert(info == 0, "Solving an overdetermined or underdetermined linear system\n" +
                         "of equations with function \"Matrices.leastSquares\" failed.");
    else
       x := fill(0.0, size(A, 2));
    end if;
    annotation (
      Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
x = Matrices.<b>leastSquares</b>(A,b);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns a solution of equation A*x = b in a least
square sense (A may be rank deficient):
</p>
<pre>
  minimize | A*x - b |
</pre>

<p>
Several different cases can be distinguished (note, <b>rank</b> is an
output argument of this function):
</p>

<p>
<b>size(A,1) = size(A,2)</b>
</p>

<p> A solution is returned for a regular, as well as a singular matrix A:
</p>

<ul>
<li> <b>rank</b> = size(A,1):<br>
     A is <b>regular</b> and the returned solution x fulfills the equation
     A*x = b uniquely.</li>

<li> <b>rank</b> &lt; size(A,1):<br>
     A is <b>singular</b> and no unique solution for equation A*x = b exists.
     <ul>
     <li>  If an infinite number of solutions exists, the one is selected that fulfills
           the equation and at the same time has the minimum norm |x| for all solution
           vectors that fulfill the equation.</li>
     <li>  If no solution exists, x is selected such that |A*x - b| is as small as
           possible (but A*x - b is not zero).</li>
     </ul>
</ul>

<p>
<b>size(A,1) &gt; size(A,2):</b>
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
<b>size(A,1) &lt; size(A,2):</b>
</p>

<ul>
<li> <b>rank</b> = size(A,1):<br>
     There are an infinite number of solutions that fulfill the equation A*x = b.
     From this infinite number, the unique solution is selected that minimizes |x|.
     </li>

<li> <b>rank</b> &lt; size(A,1):<br>
     There is either no solution of equation A*x = b, or there are again an infinite
     number of solutions. The unique solution x is returned that minimizes
      both |A*x - b| and |x|.</li>
</ul>

<p>
Note, the solution is computed with the LAPACK function \"dgelsx\",
i.e., QR or LQ factorization of A with column pivoting.
</p>

<h4>Algorithmic details</h4>

<p>
The function first computes a QR factorization with column pivoting:
</p>

<pre>
      A * P = Q * [ R11 R12 ]
                  [  0  R22 ]
</pre>

<p>
with R11 defined as the largest leading submatrix whose estimated
condition number is less than 1/rcond.  The order of R11, <b>rank</b>,
is the effective rank of A.
</p>

<p>
Then, R22 is considered to be negligible, and R12 is annihilated
by orthogonal transformations from the right, arriving at the
complete orthogonal factorization:
</p>

<pre>
     A * P = Q * [ T11 0 ] * Z
                 [  0  0 ]
</pre>

<p>
The minimum-norm solution is then
</p>

<pre>
     x = P * Z' [ inv(T11)*Q1'*b ]
                [        0       ]
</pre>

<p>
where Q1 consists of the first \"rank\" columns of Q.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">Matrices.leastSquares2</a>
(same as leastSquares, but with a right hand side matrix), <br>
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
(for square, regular matrices A)
</p>

</html>"));
  end leastSquares;

  function leastSquares2
    "Solve linear equation A*X = B (exactly if possible, or otherwise in a least square sense; A may be non-square and may be rank deficient)"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix A";
    input Real B[size(A, 1),:] "Matrix B";
    input Real rcond=100*Modelica.Constants.eps
      "Reciprocal condition number to estimate rank of A";
    output Real X[size(A, 2), size(B,2)]
      "Matrix X such that min|A*X-B|^2 if size(A,1) >= size(A,2) or min|X|^2 and A*X=B, if size(A,1) < size(A,2)";
    output Integer rank "Rank of A";
  protected
    Integer info;
    Real XX[max(size(A,1),size(A,2)), size(B,2)];
  algorithm
    (XX,info,rank) := LAPACK.dgelsx(A, B, rcond);
    X := XX[1:size(A,2), :];
    assert(info == 0, "Solving an overdetermined or underdetermined linear system of
equations with function \"Matrices.leastSquares2\" failed.");
    annotation (
      Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
X = Matrices.<b>leastSquares2</b>(A,B);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns a solution of equation A*X = B in a least
square sense (A may be rank deficient):
</p>
<pre>
  minimize | A*X - B |
</pre>

<p>
Several different cases can be distinguished (note, <b>rank</b> is an
output argument of this function):
</p>

<p>
<b>size(A,1) = size(A,2)</b>
</p>

<p> A solution is returned for a regular, as well as a singular matrix A:
</p>

<ul>
<li> <b>rank</b> = size(A,1):<br>
     A is <b>regular</b> and the returned solution X fulfills the equation
     A*X = B uniquely.</li>

<li> <b>rank</b> &lt; size(A,1):<br>
     A is <b>singular</b> and no unique solution for equation A*X = B exists.
     <ul>
     <li>  If an infinite number of solutions exists, the one is selected that fulfills
           the equation and at the same time has the minimum norm |x| for all solution
           vectors that fulfill the equation.</li>
     <li>  If no solution exists, X is selected such that |A*X - B| is as small as
           possible (but A*X - B is not zero).</li>
     </ul>
</ul>

<p>
<b>size(A,1) &gt; size(A,2):</b>
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
<b>size(A,1) &lt; size(A,2):</b>
</p>

<ul>
<li> <b>rank</b> = size(A,1):<br>
     There are an infinite number of solutions that fulfill the equation A*X = B.
     From this infinite number, the unique solution is selected that minimizes |X|.
     </li>

<li> <b>rank</b> &lt; size(A,1):<br>
     There is either no solution of equation A*X = B, or there are again an infinite
     number of solutions. The unique solution X is returned that minimizes
      both |A*X - B| and |X|.</li>
</ul>

<p>
Note, the solution is computed with the LAPACK function \"dgelsx\",
i.e., QR or LQ factorization of A with column pivoting.
</p>

<h4>Algorithmic details</h4>

<p>
The function first computes a QR factorization with column pivoting:
</p>

<pre>
      A * P = Q * [ R11 R12 ]
                  [  0  R22 ]
</pre>

<p>
with R11 defined as the largest leading submatrix whose estimated
condition number is less than 1/rcond.  The order of R11, <b>rank</b>,
is the effective rank of A.
</p>

<p>
Then, R22 is considered to be negligible, and R12 is annihilated
by orthogonal transformations from the right, arriving at the
complete orthogonal factorization:
</p>

<pre>
     A * P = Q * [ T11 0 ] * Z
                 [  0  0 ]
</pre>

<p>
The minimum-norm solution is then
</p>

<pre>
     X = P * Z' [ inv(T11)*Q1'*B ]
                [        0       ]
</pre>

<p>
where Q1 consists of the first \"rank\" columns of Q.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Math.Matrices.leastSquares\">Matrices.leastSquares</a>
(same as leastSquares2, but with a right hand side vector), <br>
<a href=\"modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>
(for square, regular matrices A)
</p>

</html>"));
  end leastSquares2;

  function equalityLeastSquares
    "Solve a linear equality constrained least squares problem"
    extends Modelica.Icons.Function;
    input Real A[:,:] "Minimize |A*x - a|^2";
    input Real a[size(A,1)];
    input Real B[:,size(A,2)] "subject to B*x=b";
    input Real b[size(B,1)];
    output Real x[size(A,2)] "solution vector";

  protected
    Integer info;
  algorithm
    assert(size(A,2) >= size(B,1) and size(A,2) <= size(A,1) + size(B,1),
           "It is required that size(B,1) <= size(A,2) <= size(A,1) + size(B,1)\n" +
           "This relationship is not fulfilled, since the matrices are declared as:\n" +
           "  A[" + String(size(A,1)) + "," + String(size(A,2)) + "], B[" +
           String(size(B,1)) + "," + String(size(B,2)) + "]\n");

    (x, info) := LAPACK.dgglse_vec(A, a, B, b);

    assert(info == 0, "Solving a linear equality-constrained least squares problem
with function \"Matrices.equalityLeastSquares\" failed.");
    annotation (
      Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
x = Matrices.<b>equalityLeastSquares</b>(A,a,B,b);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the
solution <b>x</b> of the linear equality-constrained least squares problem:
</p>
<blockquote>
<p>
min|<b>A</b>*<b>x</b> - <b>a</b>|^2 over <b>x</b>, subject to <b>B</b>*<b>x</b> = <b>b</b>
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
</HTML>"));
  end equalityLeastSquares;

  function LU "LU decomposition of square or rectangular matrix"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Square or rectangular matrix";
    output Real LU[size(A, 1), size(A,2)] = A
      "L,U factors (used with LU_solve(..))";
    output Integer pivots[min(size(A, 1), size(A,2))]
      "pivot indices (used with LU_solve(..))";
    output Integer info "Information";
  protected
    Integer lda=max(1,size(A, 1));
    external "FORTRAN 77" dgetrf(size(A, 1), size(A, 2), LU, lda, pivots, info)
      annotation (Library="Lapack");

    annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
(LU, pivots)       = Matrices.<b>LU</b>(A);
(LU, pivots, info) = Matrices.<b>LU</b>(A);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
LU decomposition of a \"Real[m,n]\" matrix A, i.e.,
</p>
<blockquote>
<p>
<b>P</b>*<b>L</b>*<b>U</b> = <b>A</b>
</p>
</blockquote>
<p>
where <b>P</b> is a permutation matrix (implicitely
defined by vector <code>pivots</code>),
<b>L</b> is a lower triangular matrix with unit
diagonal elements (lower trapezoidal if m &gt; n), and
<b>U</b> is an upper triangular matrix (upper trapezoidal if m &lt; n).
Matrices <b>L</b> and <b>U</b> are stored in the returned
matrix <code>LU</code> (the diagonal of <b>L</b> is not stored).
With the companion function
<a href=\"modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
this decomposition can be used to solve
linear systems (<b>P</b>*<b>L</b>*<b>U</b>)*<b>x</b> = <b>b</b> with different right
hand side vectors <b>b</b>. If a linear system of equations with
just one right hand side vector <b>b</b> shall be solved, it is
more convenient to just use the function
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>.
</p>
<p>
The optional third (Integer) output argument has the following meaning:
<table border=0 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\">info = 0:</td>
      <td valign=\"top\">successful exit</td></tr>
  <tr><td valign=\"top\">info &gt; 0:</td>
      <td valign=\"top\">if info = i, U[i,i] is exactly zero. The factorization
          has been completed, <br>
          but the factor U is exactly
          singular, and division by zero will occur<br> if it is used
          to solve a system of equations.</td></tr>
</table>
</p>
<p>
The LU factorization is computed
with the LAPACK function \"dgetrf\",
i.e., by Gaussian elemination using partial pivoting
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
<b>algorithm</b>
  (LU, pivots) := Matrices.LU(A);
  x1 := Matrices.LU_solve(LU, pivots, b1);  // x1 = {3,2,1}
  x2 := Matrices.LU_solve(LU, pivots, b2);  // x2 = {1,0,2}
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>,
</HTML>"));
  end LU;

  function LU_solve
    "Solve real system of linear equations P*L*U*x=b with a b vector and an LU decomposition (from LU(..))"

    extends Modelica.Icons.Function;
    input Real LU[:, size(LU,1)]
      "L,U factors of Matrices.LU(..) for a square matrix";
    input Integer pivots[size(LU, 1)] "Pivots indices of Matrices.LU(..)";
    input Real b[size(LU, 1)] "Right hand side vector of P*L*U*x=b";
    output Real x[size(b, 1)] "Solution vector such that P*L*U*x = b";

  algorithm
    for i in 1:size(LU,1) loop
         assert(LU[i,i] <> 0, "Solving a linear system of equations with function
\"Matrices.LU_solve\" is not possible, since the LU decomposition
is singular, i.e., no unique solution exists.");
    end for;
    x := LAPACK.dgetrs_vec(LU, pivots, b);
    annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>LU_solve</b>(LU, pivots, b);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
solution <b>x</b> of the linear systems of equations
</p>
<blockquote>
<p>
<b>P</b>*<b>L</b>*<b>U</b>*<b>x</b> = <b>b</b>;
</p>
</blockquote>
<p>
where <b>P</b> is a permutation matrix (implicitely
defined by vector <code>pivots</code>),
<b>L</b> is a lower triangular matrix with unit
diagonal elements (lower trapezoidal if m &gt; n), and
<b>U</b> is an upper triangular matrix (upper trapezoidal if m &lt; n).
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
If a unique solution <b>x</b> does not exist (since the
LU decomposition is singular), an exception is raised.
</p>
<p>
The LU factorization is computed
with the LAPACK function \"dgetrf\",
i.e., by Gaussian elemination using partial pivoting
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
<b>algorithm</b>
  (LU, pivots) := Matrices.LU(A);
  x1 := Matrices.LU_solve(LU, pivots, b1);  // x1 = {3,2,1}
  x2 := Matrices.LU_solve(LU, pivots, b2);  // x2 = {1,0,2}
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>,
</HTML>"));
  end LU_solve;

  function LU_solve2
    "Solve real system of linear equations P*L*U*X=B with a B matrix and an LU decomposition (from LU(..))"

    extends Modelica.Icons.Function;
    input Real LU[:, size(LU,1)]
      "L,U factors of Matrices.LU(..) for a square matrix";
    input Integer pivots[size(LU, 1)] "Pivots indices of Matrices.LU(..)";
    input Real B[size(LU, 1),:] "Right hand side matrix of P*L*U*X=B";
    output Real X[size(B, 1), size(B,2)]
      "Solution matrix such that P*L*U*X = B";

  algorithm
    for i in 1:size(LU,1) loop
         assert(LU[i,i] <> 0, "Solving a linear system of equations with function
\"Matrices.LU_solve\" is not possible, since the LU decomposition
is singular, i.e., no unique solution exists.");
    end for;
    X := Modelica.Math.Matrices.LAPACK.dgetrs(
      LU,
      pivots,
      B);
    annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>LU_solve</b>(LU, pivots, B);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
solution <b>X</b> of the linear systems of equations
</p>
<blockquote>
<p>
<b>P</b>*<b>L</b>*<b>U</b>*<b>X</b> = <b>B</b>;
</p>
</blockquote>
<p>
where <b>P</b> is a permutation matrix (implicitely
defined by vector <code>pivots</code>),
<b>L</b> is a lower triangular matrix with unit
diagonal elements (lower trapezoidal if m &gt; n), and
<b>U</b> is an upper triangular matrix (upper trapezoidal if m &lt; n).
The matrices of this decomposition are computed with function
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a> that
returns arguments <code>LU</code> and <code>pivots</code>
used as input arguments of <code>Matrices.LU_solve2</code>.
With <code>Matrices.LU</code> and <code>Matrices.LU_solve2</code>
it is possible to efficiently solve linear systems
with different right hand side <b>matrices</b>. If a linear system of equations with
just one right hand side matrix shall be solved, it is
more convenient to just use the function
<a href=\"modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>.
</p>
<p>
If a unique solution <b>X</b> does not exist (since the
LU decomposition is singular), an exception is raised.
</p>
<p>
The LU factorization is computed
with the LAPACK function \"dgetrf\",
i.e., by Gaussian elemination using partial pivoting
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
<b>algorithm</b>
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
</HTML>"));
  end LU_solve2;

  function eigenValues
    "Return eigenvalues and eigenvectors for a real, nonsymmetric matrix in a Real representation"

    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "Matrix";
    output Real eigenvalues[size(A, 1), 2]
      "Eigenvalues of matrix A (Re: first column, Im: second column)";
    output Real eigenvectors[size(A,1), size(A,2)]
      "Real-valued eigenvector matrix";

  protected
    Integer info;
    // replace with "isPresent(..)" if supported by Dymola
    Boolean onlyEigenvalues = false;
  algorithm
  if size(A,1) > 0 then
    if onlyEigenvalues then
       (eigenvalues[:, 1],eigenvalues[:, 2],info) := LAPACK.dgeev_eigenValues(A);
       eigenvectors :=zeros(size(A, 1), size(A, 1));
    else
       (eigenvalues[:, 1],eigenvalues[:, 2],eigenvectors, info) := LAPACK.dgeev(A);
    end if;
    assert(info == 0, "Calculating the eigen values with function
\"Matrices.eigenvalues\" is not possible, since the
numerical algorithm does not converge.");
  end if;
    annotation (
      Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
                eigenvalues = Matrices.<b>eigenValues</b>(A);
(eigenvalues, eigenvectors) = Matrices.<b>eigenValues</b>(A);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the eigenvalues and
optionally the (right) eigenvectors of a square matrix
<b>A</b>. The first column of \"eigenvalues\" contains the real and the
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
<blockquote>
<pre>
A = eigenvectors * eigenValueMatrix(eigenvalues) * inv(eigenvectors)
</pre>
</blockquote>
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
  Real eval;
<b>algorithm</b>
  eval := Matrices.eigenValues(A);  // eval = [-0.618, 0;
                                    //          8.0  , 0;
                                    //          1.618, 0];
</pre>
</blockquote>
<p>
i.e., matrix A has the 3 real eigenvalues -0.618, 8, 1.618.
</p>
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.eigenValueMatrix\">Matrices.eigenValueMatrix</a>,
<a href=\"modelica://Modelica.Math.Matrices.singularValues\">Matrices.singularValues</a>
</HTML>
"));
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
    annotation (
      Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>eigenValueMatrix</b>(eigenvalues);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call returns a block diagonal matrix <b>J</b>
from the the two-column matrix <code>eigenvalues</code>
(computed by function
<a href=\"modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>).
Matrix <code>eigenvalues</code> must have the real part of the
eigenvalues in the first column and the imaginary part in the
second column. If an eigenvalue i has a vanishing imaginary
part, then <b>J</b>[i,i] = eigenvalues[i,1], i.e., the diagonal
element of <b>J</b> is the real eigenvalue.
Otherwise, eigenvalue i and conjugate complex eigenvalue i+1
are used to construct a 2 by 2 diagonal block of <b>J</b>:
</p>
<blockquote>
<pre>
  J[i  , i]   := eigenvalues[i,1];
  J[i  , i+1] := eigenvalues[i,2];
  J[i+1, i]   := eigenvalues[i+1,2];
  J[i+1, i+1] := eigenvalues[i+1,1];
</pre>
</blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>
</HTML>"));
  end eigenValueMatrix;

  function singularValues
    "Return singular values and left and right singular vectors"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix";
    output Real sigma[min(size(A, 1), size(A, 2))] "Singular values";
    output Real U[size(A, 1), size(A, 1)]=identity(size(A, 1))
      "Left orthogonal matrix";
    output Real VT[size(A, 2), size(A, 2)]=identity(size(A, 2))
      "Transposed right orthogonal matrix ";

  protected
    Integer info;
    Integer n=min(size(A, 1), size(A, 2)) "Number of singular values";
  algorithm
  if n>0 then
    (sigma,U,VT,info) := Modelica.Math.Matrices.LAPACK.dgesvd(A);
    assert(info == 0, "The numerical algorithm to compute the
singular value decomposition did not converge");
  end if;
    annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
         sigma = Matrices.<b>singularValues</b>(A);
(sigma, U, VT) = Matrices.<b>singularValues</b>(A);
</pre></blockquote>
<h4>Description</h4>
<p>
This function computes the singular values and optionally the
singular vectors of matrix A. Basically the singular
value decomposition of A is computed, i.e.,
</p>
<blockquote><pre>
<b>A</b> = <b>U</b> <b><font face=\"Symbol\">S</font></b> <b>V</b><sup>T</sup>
  = U*Sigma*VT
</blockquote></pre>
<p>
where <b>U </b>and <b>V</b> are orthogonal matrices (<b>UU</b><sup>T</sup>=<b>I,
</b><b>VV</b><sup>T</sup>=<b>I</b>). <b><font face=\"Symbol\">S
</font></b> = diag(<font face=\"Symbol\">s</font><sub>i</sub>)
has the same size as matrix A with nonnegative diagonal elements
in decreasing order and with all other elements zero
(<font face=\"Symbol\">s</font><sub>1</sub> is the largest element). The function
returns the singular values <font face=\"Symbol\">s</font><sub>i</sub>
in vector <code>sigma</code> and the orthogonal matrices in
matrices <code>U</code> and <tt>V</tt>.
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
</HTML>"));
  end singularValues;

  function QR
    "Return the QR decomposition of a square matrix with optional column pivoting (A(:,p) = Q*R)"

    extends Modelica.Icons.Function;
    input Real A[:, :] "Rectangular matrix with size(A,1) >= size(A,2)";
    input Boolean pivoting=true
      "True if column pivoting is performed. True is default";
    output Real Q[size(A, 1), size(A, 2)]
      "Rectangular matrix with orthonormal columns such that Q*R=A[:,p]";
    output Real R[size(A, 2), size(A, 2)] "Square upper triangular matrix";
    output Integer p[size(A, 2)] "Column permutation vector";

  protected
    Integer nrow=size(A, 1);
    Integer ncol=size(A, 2);
    Real tau[ncol];
  algorithm
    assert(nrow >= ncol, "\nInput matrix A[" + String(nrow) + "," + String(ncol) + "] has more columns as rows.
This is not allowed when calling Modelica.Matrices.QR(A).");
    if pivoting then
      (Q,tau,p) := LAPACK.dgeqpf(A);
    else
      (Q,tau) := Modelica.Math.Matrices.LAPACK.dgeqrf(A);
       p := 1:ncol;
    end if;

    // determine R
    R := zeros(ncol,ncol);
    for i in 1:ncol loop
      for j in i:ncol loop
        R[i, j] := Q[i,j];
      end for;
    end for;

    // if isPresent(Q) then (not yet supported by Dymola)
    Q := LAPACK.dorgqr(Q, tau);
    annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
(Q,R,p) = Matrices.<b>QR</b>(A);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the QR decomposition of
a rectangular matrix <b>A</b> (the number of columns of <b>A</b>
must be less than or equal to the number of rows):
</p>
<blockquote>
<p>
<b>Q</b>*<b>R</b> = <b>A</b>[:,<b>p</b>]
</p>
</blockquote>
<p>
where <b>Q</b> is a rectangular matrix that has orthonormal columns and
has the same size as A (<b>Q</b><sup>T</sup><b>Q</b>=<b>I</b>),
<b>R</b> is a square, upper triangular matrix and <b>p</b> is a permutation
vector. Matrix <b>R</b> has the following important properties:
</p>
<ul>
<li> The absolute value of a diagonal element of <b>R</b> is the largest
     value in this row, i.e.,
     abs(R[i,i]) &ge; abs(R[i,j]).</li>
<li> The diagonal elements of <b>R</b> are sorted according to size, such that
     the largest absolute value is abs(R[1,1]) and
     abs(R[i,i]) &ge; abs(R[j,j]) with i &lt; j. </li>
</ul>
<p>
This means that if abs(R[i,i]) &le; &epsilon; then abs(R[j,k]) &le; &epsilon;
for j &ge; i, i.e., the i-th row up to the last row of <b>R</b> have
small elements and can be treated as being zero.
This allows to, e.g., estimate the row-rank
of <b>R</b> (which is the same row-rank as <b>A</b>). Furthermore,
<b>R</b> can be partitioned in two parts
</p>
<blockquote>
<pre>
   <b>A</b>[:,<b>p</b>] = <b>Q</b> * [<b>R</b><sub>1</sub>, <b>R</b><sub>2</sub>;
                 <b>0</b>,  <b>0</b>]
</pre>
</blockquote>
<p>
where <b>R</b><sub>1</sub> is a regular, upper triangular matrix.
</p>
<p>
Note, the solution is computed with the LAPACK functions \"dgeqpf\"
and \"dorgqr\", i.e., by Housholder transformations with
column pivoting. If <b>Q</b> is not needed, the function may be
called as: <code>(,R,p) = QR(A)</code>.
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real R[3,3];
<b>algorithm</b>
  (,R) := Matrices.QR(A);  // R = [-7.07.., -4.24.., -3.67..;
                                    0     , -1.73.., -0.23..;
                                    0     ,  0     ,  0.65..];
</pre></blockquote>
</HTML>"));
  end QR;

  function hessenberg "Return upper Hessenberg form of a matrix"
    import Modelica;
    import Modelica.Math.Matrices;

    input Real A[:,size(A, 1)] "Square matrix A";

    output Real H[size(A, 1),size(A, 2)] "Hessenberg form of A";
    output Real U[size(A, 1),size(A, 2)] "Transformation matrix";

  protected
    Real V[size(A, 1),size(A, 2)]
      "V=[v1,v2,..vn-1,0] with vi are vectors which define the elementary reflectors";
    Real tau[max(0,size(A, 1) - 1)]
      "Scalar factors of the elementary reflectors";

  algorithm
    (H, V, tau) := Matrices.Utilities.toUpperHessenberg(A, 1, size(A, 1));
     U := Matrices.LAPACK.dorghr(V,1,size(A, 1),tau);
    annotation (Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
         H = Matrices.<b>hessenberg</b>(A);
    (H, U) = Matrices.<b>hessenberg</b>(A);
 </pre></blockquote>

<h4>Description</h4>
<p>
Function <b>hessenberg</b> computes the Hessenberg matrix <b>H</b> of matrix <b>A</b> as well as the orthogonal transformation matrix <b>U</b> that holds <b>H</b> = <b>U</b>'*<b>A</b>*<b>U</b>.
The Hessenberg form of a matrix is computed by repeated Householder similarity transformation. The elementary reflectors and the corresponding scalar factors are provided
by function \"Utilities.toUpperHessenberg()\". The transformation matrix <b>U</b> is then computed by
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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end hessenberg;

  function realSchur
    "Return the real Schur form (rsf) S of a square matrix A, A=QZ*S*QZ'"
    import Modelica.Math.Matrices;

    input Real A[:,size(A, 1)] "Square matrix";

  public
    output Real S[size(A, 1),size(A, 2)] "Real Schur form of A";
    output Real QZ[size(A, 1),size(A, 2)] "Schur vector Matrix";
    output Real alphaReal[size(A, 1)]
      "Real part of eigenvalue=alphaReal+i*alphaImag";
    output Real alphaImag[size(A, 1)]
      "Imaginary part of eigenvalue=(alphaReal+i*alphaImag";

  protected
    Integer info;

  algorithm
    if size(A, 1) > 1 then
      (S,QZ,alphaReal,alphaImag) := Matrices.LAPACK.dgees(A);
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
      if size(A, 1) > 0 then
        QZ := [1];
        alphaReal := {1};
        alphaImag := {0};
      else
        QZ := fill(1, 0, 0);
        alphaReal := fill(1, 0);
        alphaImag := fill(0, 0);
      end if;
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><pre>
                            S = Matrices.<b>realSchur</b>(A);
(S, QZ, alphaReal, alphaImag) = Matrices.<b>realSchur</b>(A);
</pre></blockquote>

<h4>Description</h4>

<p>
Function <b>realSchur</b> calculates the real Schur form of a real square matrix <b>A</b>, i.e.
</p>

<blockquote><pre>
 <b>A</b> = <b>QZ</b>*<b>S</b>*transpose(<b>QZ</b>)
</pre></blockquote>

<p>
with the real nxn matrices <b>S</b> and <b>QZ</b>. <b>S</b> is a block upper triangular matrix with 1x1 and 2x2 blocks in the diagonal. <b>QZ</b> is an orthogonal matrix.
The 1x1 blocks contains the real eigenvalues of <b>A</b>. The 2x2 blocks [s11, s12; s21, s11] represents the conjugated complex pairs of eigenvalues, whereas the real parts of the eigenvalues
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

<b>algorithm</b>
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

</html> ", revisions="<html>
<ul>
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end realSchur;

  function cholesky
    "Return the Cholesky factorization of a symmetric positive definite matrix"
    import Modelica.Math.Matrices.LAPACK;
    input Real A[:,size(A, 1)] "Symmetric positive definite matrix";
    input Boolean upper=true
      "True if the right cholesky factor (upper triangle) should be returned";

    output Real H[size(A, 1),size(A, 2)]
      "Cholesky factor U (upper=true) or L (upper=false) for A = U'*U or A = L*L'";

  protected
    Integer n=size(A,1);
    Integer info;

  algorithm
    if size(A, 1) > 0 then
      (H, info) := LAPACK.dpotrf(A, upper);
    else
      H := fill(0,0,0);
      info := 0;
    end if;
    if info<0 then
     assert(info==0,"Cholesky factorization failed in function \"Matrices.cholesky\" due to illegal value of input " +String(info)+" for LAPACK routine DPOTRF");
    else
      assert(info==0,"Cholesky factorization failed in function \"Matrices.cholesky\" since matrix A is not positive definite");
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
         H = Matrices.<b>cholesky</b>(A);
         H = Matrices.<b>cholesky</b>(A, upper=true);
 </pre></blockquote>

<h4>Description</h4>
<p>
Function <b>cholesky</b> computes the Cholesky factorization of a real symmetric positive definite matrix A.
The optional Boolean input \"upper\" specifies wether the upper or the lower triangular matrix is returned, i.e.
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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>

</html> "));
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
    annotation (
      Documentation(info="<HTML>

<h4>Syntax</h4>
<blockquote><pre>
(D,B) = Matrices.<b>balance</b>(A);
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

<blockquote>
<pre>       - A = [1, 10,  1000; 0.01,  0,  10; 0.005,  0.01,  10]
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
</pre>
</blockquote>

<p>
The Algorithm is taken from
<dl>
<dt>H. D. Joos, G. Grbel:
<dd><b>RASP'91 Regulator Analysis and Synthesis Programs</b><br>
    DLR - Control Systems Group 1991
</dl>
which based on the balanc function from EISPACK.
</p>

</HTML>
", revisions="<html>
<p><b>Release Notes:</b></p>
<li><i>July 5, 2002</i>
       by H. D. Joos and Nico Walther<br>
       Implemented.
</li>
</html>"));
  end balance;

  function trace
    "Return the trace of matrix A, i.e., the sum of the diagonal elements"
    extends Modelica.Icons.Function;

    input Real A[:,size(A, 1)] "Square matrix A";
    output Real result "Trace of A";
  algorithm
    result := sum(A[i, i] for i in 1:size(A, 1));
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
  r = Matrices.<b>trace</b>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the trace, i.e., the sum of the elements in the diagonal of matrix <b>A</b>.
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
<li><i>2010/05/31 </i>
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
    Real LU[size(A,1),size(A,1)];
    Integer pivots[size(A,1)];

  algorithm
    (LU,pivots) := Matrices.LU(A);
    result:=product(LU[i,i] for i in 1:size(A,1))*
      product(if pivots[i]==i then 1 else -1 for i in 1:size(pivots,1));
    annotation ( Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
result = Matrices.<b>det</b>(A);
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
     to solve the linear equation A*x = b, instead of using determinantes to
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
invA = Matrices.<b>inv</b>(A);
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
x = inv(A)*b, because this is much more efficient and much more reliable.</li>
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
    Real sigma[n];
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
result = Matrices.<b>rank</b>(A);
result = Matrices.<b>rank</b>(A,eps=0);
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

    input Real A[:,:] "Input matrix";
    input Real p(min=1) = 2
      "Type of p-norm (only allowed: 1, 2 or Modelica.Constants.inf)";
    output Real result=0.0 "p-norm of matrix A";

  protected
    Real eps=1e-25;
    Real s[size(A, 1)] "singular values";

  algorithm
    if min(size(A)) > 0 then
      if p == 2 then
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
r = Matrices.<b>conditionNumber</b>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
This function calculates the condition number (norm(A) * norm(inv(A))) of a general real matrix <b>A</b>, in either the 1-norm, 2-norm or the infinity-norm.
In the case of 2-norm the result is the ratio of the largest to the smallest singular value of <b>A</b>.
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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end conditionNumber;

  function rcond "Return the reciprocal condition number of a matrix"
    extends Modelica.Icons.Function;
    input Real A[:,size(A,1)] "Square real matrix";
    input Boolean inf = false
      "Is true if infinity norm is used and false for 1-norm";
    output Real rcond "Reciprocal condition number of A";
    output Integer info "Information";
  protected
    Real LU[:,:] "LU factorization of matrix A, returned by dgetrf";
    Real anorm "Norm of matrix A";
    String normspec= if inf then "I" else "1" "Specifies the norm 1 or inf";

  algorithm
    if min(size(A)) > 0 then
      (LU,,info) := Modelica.Math.Matrices.LAPACK.dgetrf(A);
      anorm := Modelica.Math.Matrices.LAPACK.dlange(A,normspec);
      (rcond,info) := Modelica.Math.Matrices.LAPACK.dgecon(LU,inf,anorm);
    else
      rcond := Modelica.Constants.inf;
      info := 0;
    end if;

    annotation (Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
r = Matrices.<b>rcond</b>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
This function estimates the reciprocal of the condition number (norm(A) * norm(inv(A))) of a general real matrix <b>A</b>, in either the 1-norm or
the infinity-norm, using the LAPACK function <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dgecon\">DGECON</a>.
If rcond(A) is near 1.0, <b>A</b> is well conditioned and <b>A</b> is ill conditioned if rcond(A) is near zero.
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

</HTML>", revisions="<html>
<ul>
<li><i>2010/05/31 </i>
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

  algorithm
    if p == 1 then
      // column sum norm
      for i in 1:size(A, 2) loop
        result := max(result, sum(abs(A[:, i])));
      end for;
    elseif p == 2 then
      // largest singular value
      result := max(singularValues(A));
    elseif p == Modelica.Constants.inf then
      // row sum norm
      for i in 1:size(A, 1) loop
        result := max(result, sum(abs(A[i, :])));
      end for;
    else
      assert(false, "Optional argument \"p\" of function \"norm\" must be
1, 2 or Modelica.Constants.inf");
    end if;
    annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>norm</b>(A);
Matrices.<b>norm</b>(A, p=2);
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
Matrices.<b>norm</b>(A1+A2,p) &le; Matrices.<b>norm</b>(A1,p) + Matrices.<b>norm</b>(A2,p)
</pre></blockquote>

<p>
Note, for any matrix A and vector v the following inequality holds:
</p>

<blockquote><pre>
Vectors.<b>norm</b>(A*v,p) &le; Matrices.<b>norm</b>(A,p)*Vectors.<b>norm</b>(A,p)
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.frobeniusNorm\">Matrices.frobeniusNorm</a>
</p>

</HTML>"));
  end norm;

  function frobeniusNorm "Return the Frobenius norm of a matrix"
    extends Modelica.Icons.Function;
    input Real A[:,:] "Input matrix";
    output Real result "Frobenius norm of matrix A";

  algorithm
    result := if min(size(A))>0 then sqrt(sum(A.*A)) else -1e100;

    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
  r = Matrices.<b>frobeniusNorm</b>(A);
</pre></blockquote>

<h4>Description</h4>

<p>
This function computes the Frobenius norm of a general real matrix <b>A</b>, i.e., the square root of the sum of the squares of all elements.
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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end frobeniusNorm;

  function nullSpace "Return the orthonormal nullspace of a matrix"
    extends Modelica.Icons.Function;

    input Real A[:,:] "Input matrix";
    output Real Z[size(A, 2),:] "Orthonormal nullspace of matrix A";
    output Integer nullity "Nullity, i.e., the dimension of the nullspace";

  protected
    Real V[size(A, 2),size(A, 2)] "Right orthogonal matrix ";
    Real sigma[min(size(A, 1), size(A, 2))] "singular values";
    Integer rank "rank of matrix A";
    Real eps "tolerance for rank determination";
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
    Z := V[:, rank + 1:size(A, 2)];// nullspace computation
    nullity := size(A, 2) - rank;// nullity

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
           Z = Matrices.<b>nullspace</b>(A);
(Z, nullity) = Matrices.<b>nullspace</b>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
This function calculates an orthonormal basis <b>Z</b>=[<b>z</b>_1, <b>z</b>_2, ...] of the nullspace of a matrix <b>A</b>, i.e., <b>A</b>*<b>z</b>_i=<b>0</b>.
</p>

<p>
The nullspace is obtained by svd method. That is, matrix <b>A</b> is decomposed into the matrices <b>S</b>, <b>U</b>, <b>V</b>:
</p>

<blockquote><pre>
 <b>A</b> = <b>U</b>*<b>S</b>*transpose(<b>V</b>)
</pre></blockquote>

<p>
with the orthonormal matrices <b>U</b> and <b>V</b> and the matrix <b>S</b> with
</p>

<blockquote><pre>
 <b>S</b> = [<b>S</b>1, <b>0</b>]
 <b>S</b>1 = [diag(s); <b>0</b>]
</pre></blockquote>

<p>
and the singular values <b>s</b>={s1, s2, ..., sr} of <b>A</b> and r=rank(<b>A</b>). Note, that <b>S</b> has the same size as <b>A</b>. Since <b>U</b> and <b>V</b> are orthonormal we may write
</p>

<blockquote><pre>
 transpose(<b>U</b>)*<b>A</b>*<b>V</b> = [<b>S</b>1, <b>0</b>].
</pre></blockquote>

<p>
Matrix <b>S</b>1 obviously has full column rank and therefore, the left n-r rows (n is the number of columns of <b>A</b> or <b>S</b>) of matrix <b>V</b> span a nullspace of <b>A</b>.
</p>

<p>
The nullity of matrix <b>A</b> is the dimension of the nullspace of <b>A</b>. In view of the above, it becomes clear that nullity holds
</p>
<blockquote><pre>
 nullity = n - r
</pre></blockquote>
<p>
with
</p>
<blockquote><pre>
 n = number of columns of matrix <b>A</b>
 r = rank(<b>A</b>)
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
<li><i>2010/05/31 </i>
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
    annotation (
      Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
phi = Matrices.<b>exp</b>(A);
phi = Matrices.<b>exp</b>(A,T=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the exponential e<sup><b>A</b>T</sup> of matrix <b>A</b>, i.e.
</p>
<blockquote>
<pre>                            (<b>A</b>T)^2   (<b>A</b>T)^3
     <font size=4> <b>&Phi;</b></font> = e^(<b>A</b>T) = <b>I</b> + <b>A</b>T + ------ + ------ + ....
                              2!       3!
</pre></blockquote>

<p>where e=2.71828..., <b>A</b> is an n x n matrix with real elements and T is a real number,
e.g., the sampling time.
<b>A</b> may be singular. With the exponential of a matrix it is, e.g., possible
to compute the solution of a linear system of differential equations</p>
<pre>    der(<b>x</b>) = <b>A</b>*<b>x</b>   ->   <b>x</b>(t0 + T) = e^(<b>A</b>T)*x(t0)
</pre>

<h4>Algorithmic details:</h4>

<p>The algorithm is taken from</p>
<dl>
<dt>H. D. Joos, G. Gruebel:
<dd><b>RASP'91 Regulator Analysis and Synthesis Programs</b><br>
    DLR - Control Systems Group 1991
</dl>
<p>The following steps are performed to calculate the exponential of A:</p>
<ol>
  <li>Matrix <b>A</b> is balanced <br>
  (= is transformed with a diagonal matrix <b>D</b>, such that inv(<b>D</b>)*<b>A</b>*<b>D</b>
  has a smaller condition as <b>A</b>).</li>
  <li>The scalar T is divided by a multiple of 2 such that norm(
       inv(<b>D</b>)*<b>A</b>*<b>D</b>*T/2^k ) &lt; 0.5. Note, that (1) and (2) are implemented such that no round-off errors
  are introduced.</li>
  <li>The matrix from (2) is approximated by explicitly performing the Taylor
  series expansion with a variable number of terms.
  Truncation occurs if a new term does no longer contribute to the value of <b>&Phi;</b>
  from the previous iteration.</li>
  <li>The resulting matrix is transformed back, by reverting the steps of (2)
  and (1).</li>
</ol>
<p>In several sources it is not recommended to use Taylor series expansion to
calculate the exponential of a matrix, such as in 'C.B. Moler and C.F. Van Loan:
Nineteen dubious ways to compute the exponential of a matrix. SIAM Review 20,
pp. 801-836, 1979' or in the documentation of m-file expm2 in Matlab version 6
(http://www.MathWorks.com) where it is stated that 'As a practical numerical
method, this is often slow and inaccurate'. These statements are valid for a
direct implementation of the Taylor series expansion, but <i>not</i> for the
implementation variant used in this function.
</p>

</HTML>
", revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>July 5, 2002</i>
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

    annotation (
      Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
(phi,gamma) = Matrices.<b>integralExp</b>(A,B);
(phi,gamma) = Matrices.<b>integralExp</b>(A,B,T=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the exponential phi = e^(<b>A</b>T) of matrix <b>A</b>
and the integral gamma = integral(phi*dt)*B.
</p>

<p>
The function uses a Taylor series expansion with Balancing and
scaling/squaring to approximate the integral <b>&Psi;</b> of the matrix
exponential <b>&Phi;</b>=e^(AT):
</p>
<pre>                                 AT^2   A^2 * T^3          A^k * T^(k+1)
        <b>&Psi;</b> = int(e^(As))ds = IT + ---- + --------- + ... + --------------
                                  2!        3!                (k+1)!
</pre>
<p>
<b>&Phi;</b> is calculated through <b>&Phi;</b> = I + A*<b>&Psi;</b>, so A may be singular. <b>&Gamma;</b> is
simply <b>&Psi;</b>*B.
</p>
<p>The algorithm runs in the following steps:</p>
<ol>
  <li>Balancing</li>
  <li>Scaling</li>
  <li>Taylor series expansion</li>
  <li>Re-scaling</li>
  <li>Re-Balancing</li>
</ol>
<p>Balancing put the bad condition of a square matrix <i>A</i> into a diagonal
transformation matrix <i>D</i>. This reduce the effort of following calculations.
Afterwards the result have to be re-balanced by transformation D*A<small>transf</small>
 *inv(D).<br>
Scaling halfen T&nbsp; k-times, until the norm of A*T is less than 0.5. This
garantees minumum rounding errors in the following series
expansion. The re-scaling based on the equation&nbsp; exp(A*2T) = exp(AT)^2.
The needed re-scaling formula for psi thus becomes:</p>
<pre>         <b>&Phi;</b> = <b>&Phi;</b>'*<b>&Phi;</b>'
   I + A*<b>&Psi;</b> = I + 2A*<b>&Psi;</b>' + A^2*<b>&Psi;</b>'^2
         <b>&Psi;</b> = A*<b>&Psi;</b>'^2 + 2*<b>&Psi;</b>'
</pre>
<p>
where psi' is the scaled result from the series expansion while psi is the
re-scaled matrix.
</p>
<p>
The function is normally used to discretize a state-space system as the
zero-order-hold equivalent:
</p>
<pre>      x(k+1) = <b>&Phi;</b>*x(k) + <b>&Gamma;</b>*u(k)
        y(k) = C*x(k) + D*u(k)
</pre>
<p>
The zero-order-hold sampling, also known as step-invariant method, gives
exact values of the state variables, under the assumption that the control
signal u is constant between the sampling instants. Zero-order-hold sampling
is discribed in
</p>
<dl>
<dt>K. J. Astroem, B. Wittenmark:
<dd><b>Computer Controlled Systems - Theory and Design</b><br>
    Third Edition, p. 32
</dl>
<pre><b>Syntax:</b>
      (phi,gamma) = Matrices.expIntegral(A,B,T)
                       A,phi: [n,n] square matrices
                     B,gamma: [n,m] input matrix
                           T: scalar, e.g., sampling time
</pre>
<p>
The Algorithm to calculate psi is taken from
<dl>
<dt>H. D. Joos, G. Gruebel:
<dd><b>RASP'91 Regulator Analysis and Synthesis Programs</b><br>
    DLR - Control Systems Group 1991
</dl>
</p>

</HTML>
", revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>July 5, 2002</i>
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

    annotation (
      Documentation(info="<HTML>
<blockquote><pre>
(phi,gamma,gamma1) = Matrices.<b>integralExp</b>(A,B);
(phi,gamma,gamma1) = Matrices.<b>integralExp</b>(A,B,T=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the exponential phi = e^(<b>A</b>T) of matrix <b>A</b>
and the integral gamma = integral(phi*dt)*B and the integral
integral((T-t)*exp(A*t)*dt)*B, where A is a square (n,n) matrix and
B, gamma, and gamma1 are (n,m) matrices.
</p>

<p>
The function calculates the matrices phi,gamma,gamma1 through the equation:
</p>
<pre>                                 [ A B 0 ]
[phi gamma gamma1] = [I 0 0]*exp([ 0 0 I ]*T)
                                 [ 0 0 0 ]
</pre>

<p>
The matrices define the discretized first-order-hold equivalent of
a state-space system:
<pre>      x(k+1) = phi*x(k) + gamma*u(k) + gamma1/T*(u(k+1) - u(k))
</pre>
<p>
The first-order-hold sampling, also known as ramp-invariant method, gives
more smooth control signals as the ZOH equivalent. First-order-hold sampling
is, e.g., described in
</p>

<dl>
<dt>K. J. Astroem, B. Wittenmark:
<dd><b>Computer Controlled Systems - Theory and Design</b><br>
    Third Edition, p. 256
</dl>

</HTML>
", revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>July 31, 2002</i>
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
    import Modelica.Math.Matrices;

    input Real A[:,size(A, 1)] "Square matrix A in X*A + A'*X = C";
    input Real C[size(A, 1),size(A, 2)] "Square matrix C in X*A + A'*X = C";
    input Boolean ATisSchur=false
      "True if transpose(A) has already real Schur form";
    input Real eps=Modelica.Math.Matrices.norm(A, 1)*10*1e-15 "Tolerance eps";

  protected
    Integer n=size(A, 1);
    Real R[size(A, 1),size(A, 2)] "rsf of A', i.e., R=U'A'U";
    Real U[size(A, 1),size(A, 2)] "transformation matrix U for R=U'A'U";
    Real D[size(A, 1),size(A, 2)] "Matrix D=U'*C*U";
    Real R11[size(A, 1),size(A, 2)];
    Real R22[size(A, 1),size(A, 2)];
    Real R12[size(A, 1),size(A, 2)];
    Real R21[size(A, 1),size(A, 2)];
    Real R2[2*size(A, 1),2*size(A, 2)];
    Real I[size(A, 1),size(A, 1)]=identity(size(A, 1));
    Real y[2*size(A, 1)];
    Real c[2*size(A, 1)];
    Real CC[size(A, 1),2];
    Integer k;

  public
    output Real X[size(A, 1),size(A, 2)]
      "Solution X of the Lyapunov equation  X*A + A'*X = C";

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
        R2 := [R11,R12; R21,R22];
        c := cat(1, D[:, n - 1], D[:, n]);
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
          X[:, k] := Matrices.solve(R22, D[:, k] - vector(X[:, k + 1:n]*matrix(R[
            k, k + 1:n])));
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
          R2 := [R11,R12; R21,R22];
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
      end while;// k=1 or k=0

  // if k=1 the first column (if there exist a real eigenvalue) has to be calculated separately
      if k == 1 then
        R22 := R;
        for i1 in 1:n loop
          R22[i1, i1] := R[i1, i1] + R[1, 1];
        end for;
        X[:, 1] := Matrices.solve(R22, D[:, 1] - vector(X[:, 2:n]*matrix(R[1, 2:n])));
      end if;

  // transform X corresponding to the original form
      if not ATisSchur then
        X := U*X*transpose(U);
      end if;

    elseif n == 1 then //simple scalar equation
      X[1, 1] := C[1, 1]/(2*A[1, 1]);
    else
      X := fill(0, 0, 0);
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
         X = Matrices.<b>continuousLyapunov</b>(A, C);
         X = Matrices.<b>continuousLyapunov</b>(A, C, ATisSchur, eps);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the solution <b>X</b> of the continuous-time Lyapunov equation
</p>

<blockquote><pre>
 <b>X</b>*<b>A</b> + <b>A</b>'*<b>X</b> = <b>C</b>
</pre></blockquote>

<p>
using the Schur method for Lyapunov equations proposed by Bartels and Stewart [1].
</p>

<p>
In a nutshell, the problem is reduced to the corresponding problem
</p>

<blockquote><pre>
 <b>Y</b>*<b>R</b>' + <b>R</b>*<b>Y</b> = <b>D</b>
</pre></blockquote>

<p>
with <b>R</b>=<b>U</b>'*<b>A'</b>*<b>U</b> is the real Schur form of <b>A</b>' and <b>D</b>=<b>U</b>'*<b>C</b>*<b>U</b> and <b>Y</b>=<b>U</b>'*<b>X</b>*<b>U</b>
are the corresponding transformations of <b>C</b> and <b>X</b>. This problem is solved sequently for the 1x1 or 2x2 Schur blocks by exploiting the block triangular form of <b>R</b>.
Finally the solution of the original problem is recovered as <b>X</b>=<b>U</b>*<b>Y</b>*<b>U</b>'.<br>
The boolean input \"ATisSchur\" indicates to omit the transformation to Schur in the case that <b>A</b>' has already Schur form.
</p>

<h4>References</h4>
<pre>
  [1] Bartels, R.H. and Stewart G.W.
      Algorithm 432: Solution of the matrix equation AX + XB = C.
      Comm. ACM., Vol. 15, pp. 820-826, 1972.
</pre>

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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end continuousLyapunov;

  function continuousSylvester
    "Return solution X of the continuous-time Sylvester equation A*X + X*B = C"
    import Modelica.Math.Matrices;

    input Real A[:,:] "Square matrix A";
    input Real B[:,:] "Square matrix B";
    input Real C[size(A, 1),size(B, 2)] "Matrix C";
    input Boolean AisSchur=false "True if A has already real Schur form";
    input Boolean BisSchur=false "True if B has already real Schur form";
    output Real X[size(A, 1),size(B, 2)]
      "Solution of the continuous Sylvester equation";

  protected
    Integer n=size(A, 1);
    Integer m=size(B, 1);
    Real S[size(A, 1),size(A, 2)];
    Real T[size(B, 1),size(B, 2)];
    Real U[size(A, 1),size(A, 1)];
    Real V[size(B, 1),size(B, 1)];
    Real Chat[size(C, 1),size(C, 2)];
    Real scale;
    Integer info;

  algorithm
    if n > 1 and m > 1 then
      if AisSchur then
        S := A;
        U := identity(n);
      else
        (S,U) := Modelica.Math.Matrices.realSchur(    A);
      end if;
      if BisSchur then
        T := B;
        V := identity(m);
      else
        (T,V) := Modelica.Math.Matrices.realSchur(    B);
      end if;

      Chat := if AisSchur and BisSchur then C else if AisSchur then C*V else if
        BisSchur then transpose(U)*C else transpose(U)*C*V;
      (X,scale,info) := Matrices.LAPACK.dtrsyl(S, T, Chat);
      assert(info == 0, "Solving of Sylvester equation with Matrices.continuousSylvester was not sucessfull.\n
                    The value of info is "   + String(info) + ", but should be zero. A value unequal to zero means:\n
            < 0: if INFO = -i, the i-th argument had an illegal value\n
            = 1: A and B have common or very close eigenvalues; perturbed
                 values were used to solve the equation (but the matrices
                 A and B are unchanged).");
      X := if AisSchur and BisSchur then scale*X else if AisSchur then scale*X*
        transpose(V) else if BisSchur then scale*U*X else scale*U*X*transpose(V);
    else
      X := fill(0, n, m);
    end if;

    annotation (Documentation(info="<html>
 <h4>Syntax</h4>
<blockquote><pre>
         X = Matrices.<b>continuousSylvester</b>(A, B, C);
         X = Matrices.<b>continuousSylvester</b>(A, B, C, AisSchur, BisSchur);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <b>continuousSylvester</b> computes the solution <b>X</b> of the continuous-time Sylvester equation
</p>

<blockquote><pre>
 <b>A</b>*<b>X</b> + <b>X</b>*<b>B</b> = <b>C</b>.
</pre></blockquote>

<p>
using the Schur method for Sylvester equations proposed by Bartels and Stewart [1].
</p>

<p>
In a nutshell, the problem is reduced to the corresponding problem
</p>
<blockquote><pre>
 <b>S</b>*<b>Y</b> + <b>Y</b>*<b>T</b> = <b>D</b>.
</pre></blockquote>
<p>
with <b>S</b>=<b>U</b>'*<b>A</b>*<b>U</b> is the real Schur of <b>A</b>,  <b>T</b>=<b>V</b>'*<b>T</b>*<b>V</b> is the real Schur form of <b>B</b> and
<b>D</b>=<b>U</b>'*<b>C</b>*<b>V</b> and <b>Y</b>=<b>U</b>*<b>X</b>*<b>V</b>'
are the corresponding transformations of <b>C</b> and <b>X</b>. This problem is solved sequently by exploiting the block triangular form of <b>S</b> and <b>T</b>.
Finally the solution of the original problem is recovered as <b>X</b>=<b>U</b>'*<b>Y</b>*<b>V</b>.<br>
The boolean inputs \"AisSchur\" and \"BisSchur\" indicate to omit one or both of the transformation to Schur in the case that <b>A</b> and/or <b>B</b> have already Schur form.
</p>

<p>
The function applies LAPACK-routine DTRSYL. See <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dtrsyl\">LAPACK.dtrsyl</a>
for more information.
</p>

<h4>References</h4>
<pre>
  [1] Bartels, R.H. and Stewart G.W.
      Algorithm 432: Solution of the matrix equation AX + XB = C.
      Comm. ACM., Vol. 15, pp. 820-826, 1972.
</pre>

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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end continuousSylvester;

  function continuousRiccati
    "Return solution X of the continuous-time algebraic Riccati equation A'*X + X*A - X*B*inv(R)*B'*X + Q = 0 (care)"
    import Modelica.Math.Matrices;

    input Real A[:,size(A, 1)] "Square matrix A in CARE";
    input Real B[size(A, 1),:] "Matrix B in CARE";
    input Real R[size(B, 2),size(B, 2)]=identity(size(B, 2)) "Matrix R in CARE";
    input Real Q[size(A, 1),size(A, 1)]=identity(size(A, 1)) "Matrix Q in CARE";
    input Boolean refine=false "True for subsequent refinement";

  protected
    Integer n=size(A, 1);
    Real G[size(A, 1),size(A, 1)]=B*Modelica.Math.Matrices.solve2(R, transpose(B));
    Real H[:,:]=[A,-G; -Q,-transpose(A)];
    Real H_RSF[:,:]=H;
    Real Z[size(H, 1),size(H, 2)];
    Real Z11[size(A, 1),size(A, 2)];
    Real Z21[size(A, 1),size(A, 2)];

    Integer info;

  public
    output Real X[size(A, 1),size(A, 2)] "stabilizing solution of CARE";
    output Real alphaReal[size(H, 1)]
      "Real parts of eigenvalue=alphaReal+i*alphaImag";
    output Real alphaImag[size(H, 1)]
      "Imaginary parts of eigenvalue=(alphaReal+i*alphaImag";
  algorithm
    if n > 1 then
      (H_RSF,Z,alphaReal,alphaImag) := Modelica.Math.Matrices.realSchur(    H);
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
        assert(info == 0, "Solving a linear system of equations with function \"Matrices.LAPACK.dgesvx\" is not possible, because the system has either no or infinitely many solutions (input A is singular).");
        X := transpose(X);

        if refine then
          X := Modelica.Math.Matrices.Utilities.continuousRiccatiIterative(
                                          A, B, R, Q, X);
        end if;
      else
        X := fill(0, size(Z21, 1), size(Z11, 1));
      end if;

    elseif n == 1 then
      X := matrix((A[1, 1] - sqrt(A[1, 1]*A[1, 1] + G[1, 1]*Q[1, 1]))/G[1, 1]);
      if X[1, 1]*G[1, 1] < A[1, 1] then
        X := matrix((A[1, 1] + sqrt(A[1, 1]*A[1, 1] + G[1, 1]*Q[1, 1]))/G[1, 1]);
      end if;
    else
      X := fill(0, 0, 0);
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
                                X = Matrices.<b>continuousRiccati</b>(A, B, R, Q);
        (X, alphaReal, alphaImag) = Matrices.<b>continuousRiccati</b>(A, B, R, Q, true);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <b>continuousRiccati</b> computes the solution <b>X</b> of the continuous-time algebraic Riccati equation
</p>

<blockquote><pre>
 <b>A</b>'*<b>X</b> + <b>X</b>*<b>A</b> - <b>X</b>*<b>G</b>*<b>X</b> + <b>Q</b> = <b>0</b>
</pre></blockquote>

<p>
with <code><b>G</b> = <b>B</b>*inv(<b>R</b>)*<b>B</b>'</code>
using the Schur vector approach proposed by Laub [1].
</p>

<p>
It is assumed that <b>Q</b> is symmetric and positive semidefinite and <b>R</b> is symmetric, nonsingular and positive definite,
(<b>A</b>,<b>B</b>) is stabilizable and (<b>A</b>,<b>Q</b>) is detectable.
</p>

<p><b>
These assumptions are not checked in this function !!
</b><br>
</p>

<p>
The assumptions guarantee that the Hamiltonian matrix
</p>

<blockquote><pre>
<b>H</b> = [<b>A</b>, -<b>G</b>; -<b>Q</b>, -<b>A</b>']
</pre></blockquote>

<p>
has no pure imaginary eigenvalue and can be put
to an ordered real Schur form
</p>

<blockquote><pre>
<b>U</b>'*<b>H</b>*<b>U</b> = <b>S</b> = [<b>S</b>11, <b>S</b>12; <b>0</b>, <b>S</b>22]
</pre></blockquote>

<p>
with orthogonal similarity transformation <b>U</b>. <b>S</b> is ordered in such a way,
that <b>S</b>11 contains the n stable eigenvalues of the closed loop system with system matrix
<b>A</b> - <b>B</b>*inv(<b>R</b>)*<b>B</b>'*<b>X</b>.
If <b>U</b> is partitioned to
</p>

<blockquote><pre>
<b>U</b> = [<b>U</b>11, <b>U</b>12; <b>U</b>21, <b>U</b>22]
</pre></blockquote>

<p>
with dimenstions according to <b>S</b>, the solution <b>X</b> is calculated by
</p>

<blockquote><pre>
<b>X</b>*<b>U</b>11 = <b>U</b>21.
</pre></blockquote>

<p>
With optional input <code>refinement=true</code> a subsequent iterative refinement based on Newton's method with exact line search is applied.
See <a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\">continuousRiccatiIterative</a>
for more information.
</p>

<p>
The algorithm calls LAPACK routines <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dgehrd\">dgehrd</a> (to compute the upper Hessenberg matrix of <b>H</b>),
<a href=\"modelica://Modelica.Math.Matrices.LAPACK. dorghr\">dorghr</a> (to calculate the orthogonal
matrix from the elementary reflectors as returned from dgehrd), <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dhseqr\">dhseqr</a>
(to put transformed <b>H</b> to Schur form and to calculate the eigenvalues
of the closed loop system) and <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dtrsen\">dtrsen</a> (to compute the ordered real Schur form and matrix <b>U</b>).
</p>

<h4>References</h4>
<PRE>
  [1] Laub, A.J.
      A Schur Method for Solving Algebraic Riccati equations.
      IEEE Trans. Auto. Contr., AC-24, pp. 913-921, 1979.
</PRE>

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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end continuousRiccati;

  function discreteLyapunov
    "Return solution X of the discrete-time Lyapunov equation A'*X*A + sgn*X = C"
    import Modelica.Math.Matrices;

    input Real A[:,size(A, 1)] "Square matrix A in A'*X*A + sgn*X = C";
    input Real C[size(A, 1),size(A, 2)] "Square matrix C in A'*X*A + sgn*X = C";
    input Boolean ATisSchur=false
      "True if transpose(A) has already real Schur form";
    input Integer sgn=1 "Specifies the sign in A'*X*A + sgn*X = C";
    input Real eps=Matrices.norm(A, 1)*10*Modelica.Constants.eps
      "Tolerance eps";

  protected
    Integer n=size(A, 1);
    Real R[size(A, 1),size(A, 2)] "RSF of A', i.e., R=U'A'U";
    Real U[size(A, 1),size(A, 2)] "Transformation matrix U for R=U'A'U";
    Real D[size(A, 1),size(A, 2)] "Matrix D=U'*C*U";
    Real R22[size(A, 1),size(A, 2)];
    Real R11[size(A, 1),size(A, 2)];
    Integer k;

    Real g[size(A, 1)];
    Real w[size(A, 1)];
    Real y[2*size(A, 1)];
    Boolean crit;

  public
    output Real X[size(A, 1),size(A, 2)]
      "Solution X of the Lyapunov equation A'*X*A + sgn*X = C";

  algorithm
    assert(sgn==1 or sgn==-1,"Input sgn in function Math.Matrices.discreteLyapunov() must be 1 or -1, however it is "+String(sgn));
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
          y := Matrices.solve([R11,R[k - 1, k]*R; R[k, k - 1]*R,R22], cat(1, g, w));
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
      X := fill(0, 0, 0);
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
         X = Matrices.<b>discreteLyapunov</b>(A, C);
         X = Matrices.<b>discreteLyapunov</b>(A, C, ATisSchur, sgn, eps);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the solution <b>X</b> of the discrete-time Lyapunov equation
</p>

<blockquote><pre>
 <b>A</b>'*<b>X</b>*<b>A</b> + sgn*<b>X</b> = <b>C</b>
</pre></blockquote>

<p>
where sgn=1 or sgn =-1. For sgn = -1, the discrete Lyapunov equation is a special case of the Stein equation:
</p>

<blockquote><pre>
 <b>A</b>*<b>X</b>*<b>B</b> - <b>X</b> + <b>Q</b> = <b>0</b>.
</pre></blockquote>

<p>
The algorithm uses the Schur method for Lyapunov equations proposed by Bartels and Stewart [1].
</p>

<p>
In a nutshell, the problem is reduced to the corresponding problem
</p>

<blockquote><pre>
 <b>R</b>*<b>Y</b>*<b>R</b>' + sgn*<b>Y</b> = <b>D</b>.
</pre></blockquote>

<p>
with <b>R</b>=<b>U</b>'*<b>A'</b>*<b>U</b> is the the real Schur form of <b>A</b>' and <b>D</b>=<b>U</b>'*<b>C</b>*<b>U</b> and <b>Y</b>=<b>U</b>'*<b>X</b>*<b>U</b>
are the corresponding transformations of <b>C</b> and <b>X</b>. This problem is solved sequently by exploiting the block triangular form of <b>R</b>.
Finally the solution of the original problem is recovered as <b>X</b>=<b>U</b>*<b>Y</b>*<b>U</b>'.<br>
The boolean input \"ATisSchur\" indicates to omit the transformation to Schur in the case that <b>A</b>' has already Schur form.
</p>

<h4>References</h4>
<PRE>
  [1] Bartels, R.H. and Stewart G.W.
      Algorithm 432: Solution of the matrix equation AX + XB = C.
      Comm. ACM., Vol. 15, pp. 820-826, 1972.
</PRE>

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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end discreteLyapunov;

  function discreteSylvester
    "Return solution of the discrete-time Sylvester equation A*X*B + sgn*X = C"
    import Modelica.Math.Matrices;

    input Real A[:,size(A, 1)] "Square matrix A in A*X*B + sgn*X = C";
    input Real B[:,size(B, 1)] "Square matrix B in A*X*B + sgn*X = C";
    input Real C[size(A, 2),size(B, 1)]
      "Rectangular matrix C in A*X*B + sgn*X = C";
    input Boolean AisHess=false "True if A has already Hessenberg form";
    input Boolean BTisSchur=false "True if B' has already real Schur form";
    input Integer sgn=1 "Specifies the sign in A*X*B + sgn*X = C";
    input Real eps=Matrices.norm(A, 1)*10*Modelica.Constants.eps "Tolerance";

  protected
    Integer n=size(A, 1);
    Integer m=size(B, 1);
    Real H[n,n] "Hessenberg form  of A, i.e., H=U'AU";
    Real U[n,n] "Transformation matrix U for H=U'AU";
    Real S[m,m] "RSF form  of B, i.e., S=Z'BZ";
    Real Z[m,m] "Transformation matrix Z for S=Z'BZ";
    Real F[n,m] "Appropriate transformation of the right side C, F=U'*C*Z";

    Real R22[n,n];
    Real R11[n,n];
    Integer k;

    Real w[n];
    Real g[n];
    Real y[2*n];
    Boolean crit;

  public
    output Real X[size(A, 2),size(B, 1)]
      "solution of the discrete Sylvester equation A*X*B + sgn*X = C";

  algorithm
    assert(sgn==1 or sgn==-1,"Input sgn in function Math.Matrices.discreteLyapunov() must be 1 or -1, however it is "+String(sgn));
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

      while k >0 loop

        w := F[:, k] - H*X[:, k + 1:m]*S[k +1:m,k];
        crit := if k > 1 then abs(S[k-1, k]) < eps else false;

        if (k == 1 or crit) then //real eigenvalue in Schur form
          R22 := S[k, k]*H;
          for i in 1:n loop
            R22[i, i] := R22[i, i] + sgn;
          end for;
          X[:, k] := Matrices.solve(R22, w); // solve one column in X for one real eigenvalue
          k := k - 1;
        else // pair of complex eigenvalues, i.e., 2x2 Schur bump
          g := F[:, k-1] - H*X[:, k + 1:m]*S[k+1 :m,k-1];
          R22 := S[k, k]*H;
          R11 := S[k-1, k-1]*H;
          for i in 1:n loop
            R11[i, i] := R11[i, i] + sgn;
            R22[i, i] := R22[i, i] + sgn;
          end for;
          y := Matrices.solve([R11,S[k,  k-1]*H; S[k-1, k]*H,R22], cat(1, g, w));// solve two columns in X for one conjugated complex pole pair
          X[:, k-1] := y[1:n];
          X[:, k] := y[n + 1:2*n];
          k := k - 2;
        end if;
      end while;

  // transform X corresponding to the original form
      if not (AisHess and BTisSchur) then
        X := if AisHess then X*transpose(Z) else if BTisSchur then U*X else U*X*transpose(Z);
      end if;

    elseif n == 1 and m == 1 then // simple scalar equation
      X[1, 1] := C[1, 1]/(A[1, 1]*B[1, 1] + sgn);
    else
      X := fill(0, 0, 0);
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
         X = Matrices.<b>discreteSylvester</b>(A, B, C);
         X = Matrices.<b>discreteSylvester</b>(A, B, C, AisHess, BTisSchur, sgn, eps);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <b>discreteSylvester</b> computes the solution <b>X</b> of the discrete-time Sylvester equation
</p>

<blockquote><pre>
 <b>A</b>*<b>X</b>*<b>B</b> + sgn*<b>X</b> = <b>C</b>.

</pre></blockquote>

<p>
where sgn = 1 or sgn = -1. The algorithm applies the Hessenberg-Schur method proposed by Golub et al [1].
For sgn = -1, the discrete Sylvester equation is also known as Stein equation:
</p>

<blockquote><pre>
 <b>A</b>*<b>X</b>*<b>B</b> - <b>X</b> + <b>Q</b> = <b>0</b>.
</pre></blockquote>

<p>
In a nutshell, the problem is reduced to the corresponding problem
</p>
<blockquote><pre>
 <b>H</b>*<b>Y</b>*<b>S</b>' + sgn*<b>Y</b> = <b>F</b>.
</pre></blockquote>

<p>
with <b>H</b>=<b>U</b>'*<b>A</b>*<b>U</b> is the Hessenberg form of <b>A</b> and <b>S</b>=<b>V</b>'*<b>B</b>'*<b>V</b> is the real Schur form of <b>B</b>',
<b>F</b>=<b>U</b>'*<b>C</b>*<b>V</b> and <b>Y</b>=<b>U</b>*<b>X</b>*<b>V</b>'
are appropriate transformations of <b>C</b> and <b>X</b>. This problem is solved sequently by exploiting the specific forms of <b>S</b> and <b>H</b>.
Finally the solution of the original problem is recovered as <b>X</b>=<b>U</b>'*<b>Y</b>*<b>V</b>.<br>
The boolean inputs \"AisHess\" and \"BTisSchur\" indicate to omit one or both of the transformation to Hessenberg form or Schur form repectively in the case that <b>A</b> and/or <b>B</b> have already Hessenberg form or Schur respectively.
</p>

<h4>References</h4>
<PRE>
  [1] Golub, G.H., Nash, S. and Van Loan, C.F.
      A Hessenberg-Schur method for the problem AX + XB = C.
      IEEE Transaction on Automatic Control, AC-24, no. 6, pp. 909-913, 1979.

</PRE>

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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end discreteSylvester;

  function discreteRiccati
    "Return solution of discrete-time algebraic Riccati equation A'*X*A - X - A'*X*B*inv(R + B'*X*B)*B'*X*A + Q = 0 (dare)"

    import Modelica.Math.Matrices;
    input Real A[:,size(A, 1)] "Square matrix A in DARE";
    input Real B[size(A, 1),:] "Matrix B in DARE";
    input Real R[size(B, 2),size(B, 2)]=identity(size(B, 2)) "Matrix R in DARE";
    input Real Q[size(A, 1),size(A, 1)]=identity(size(A, 1)) "Matrix Q in DARE";
    input Boolean refine=false "True for subsequent refinement";

  protected
    Integer n=size(A, 1);
    Real G[size(A, 1),size(A, 1)]=B*Matrices.solve2(R, transpose(B));
    Real AT[:,:]=transpose(A);
    Real LU[n,n];
    Integer p[n];
    Real H[2*n,2*n];
    Real H11[n,n];
    Real H12[n,n];
    Real H21[n,n];
    Real H22[n,n];
    Real H_RSF[2*n,2*n];
    Real Z[size(H, 1),size(H, 2)];
    Real Z11[size(A, 1),size(A, 2)];
    Real Z21[size(A, 1),size(A, 2)];

    Integer info;

  public
    output Real X[size(A, 1),size(A, 2)]
      "orthogonal matrix of the Schur vectors associated to ordered rsf";
    output Real alphaReal[size(H, 1)]
      "Real part of eigenvalue=alphaReal+i*alphaImag";
    output Real alphaImag[size(H, 1)]
      "Imaginary part of eigenvalue=(alphaReal+i*alphaImag";
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
    H := [H11,H12; H21,H22];
    (H_RSF,Z,alphaReal,alphaImag) := Modelica.Math.Matrices.realSchur(H);
                                                               // put H to Schur form
    (H_RSF,Z,alphaReal,alphaImag) := Matrices.Utilities.reorderRSF(
        H_RSF,
        Z,
        alphaReal,
        alphaImag,
        false);  // ordered Schur form
    Z11 := Z[1:n, 1:n];
    Z21 := Z[n + 1:2*n, 1:n];
    if size(Z11, 1) > 0 then
  //  X := transpose(Matrices.solve2(transpose(Z11), transpose(Z21)));
      (X,info) := Matrices.LAPACK.dgesvx(Z11, transpose(Z21));//function does not need to transpose Z11 as solve2 does
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
                                 X = Matrices.<b>discreteRiccati</b>(A, B, R, Q);
         (X, alphaReal, alphaImag) = Matrices.<b>discreteRiccati</b>(A, B, R, Q, true);
</pre></blockquote>

<h4>Description</h4>

<p>
Function <b>discreteRiccati</b> computes the solution <b>X</b> of the discrete-time algebraic Riccati equation
</p>

<blockquote><pre>
 <b>A</b>'*<b>X</b>*<b>A</b> - <b>X</b> - <b>A</b>'*<b>X</b>*<b>B</b>*inv(<b>R</b> + <b>B</b>'*<b>X</b>*<b>B</b>)*<b>B</b>'*<b>X</b>*<b>A</b> + <b>Q</b> = <b>0</b>
</pre></blockquote>

<p>
using the Schur vector approach proposed by Laub [1].
</p>

<p>
It is assumed that <b>Q</b> is symmetric and positive semidefinite and <b>R</b> is symmetric, nonsingular and positive definite,
(<b>A</b>,<b>B</b>) is stabilizable and (<b>A</b>,<b>Q</b>) is detectable. Using this method, <b>A</b> has also to be invertible.
</p>

<p>
<b>These assumptions are not checked in this function !!!</b>
</p>

<p>
The assumptions guarantee that the Hamiltonian matrix.
</p>
<blockquote><pre>
<b>H</b> = [<b>A</b> + <b>G</b>*<b>T</b>*<b>Q</b>, -<b>G</b>*<b>T</b>; -<b>T</b>*<b>Q</b>, <b>T</b>]
</pre></blockquote>
<p>
with
</p>
<blockquote><pre>
     -T
<b>T</b> = <b>A</b>
</pre></blockquote>

<p>
and
</p>

<blockquote><pre>
       -1
<b>G</b> = <b>B</b>*<b>R</b> *<b>B</b>'
</pre></blockquote>

<p>
has no eigenvalue on the unit circle and can be put
to an ordered real Schur form
</p>

<blockquote><pre>
<b>U</b>'*<b>H</b>*<b>U</b> = <b>S</b> = [<b>S11</b>, <b>S12</b>; <b>0</b>, <b>S22</b>]
</pre></blockquote>

<p>
with orthogonal similarity transformation <b>U</b>. <b>S</b> is ordered in such a way,
that <b>S11</b> contains the n stable eigenvalues of the closed loop system with system matrix
</p>

<blockquote><pre>
                  -1
<b>A</b> - <b>B</b>*(<b>R</b> + <b>B</b>'*<b>X</b>*<b>B</b>)  *<b>B</b>'*<b>X</b>*<b>A</b>
</pre></blockquote>

<p>
If <b>U</b> is partitioned to
</p>

<blockquote><pre>
<b>U</b> = [<b>U11</b>, <b>U12</b>; <b>U21</b>, <b>U22</b>]
</pre></blockquote>

<p>
according to <b>S</b>, the solution <b>X</b> can be calculated by
</p>

<blockquote><pre>
<b>X</b>*<b>U11</b> = <b>U21</b>.
</pre></blockquote>

<p>
The algorithm calls LAPACK routines <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dgehrd\">dgehrd</a> (to compute the upper Hessenberg matrix of <b>H</b>),
<a href=\"modelica://Modelica.Math.Matrices.LAPACK. dorghr\">dorghr</a> (to calculate the orthogonal
matrix from the elementary reflectors as returned from dgehrd), <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dhseqr\">dhseqr</a>
(to put transformed <b>H</b> to Schur form and to calculate the eigenvalues
of the closed loop system) and <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dtrsen\">dtrsen</a> (to compute the ordered real Schur form and matrix <b>U</b>).
</p>

<h4>References</h4>
<PRE>
  [1] Laub, A.J.
      A Schur Method for Solving Algebraic Riccati equations.
      IEEE Trans. Auto. Contr., AC-24, pp. 913-921, 1979.
</PRE>

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
<a href=\"modelica://Modelica.Math.Matrices.care\">Matrices.continuousRiccati</a>
</p>
</html>", revisions="<html>
<ul>
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end discreteRiccati;

  function sort
    "Sort the rows or columns of a matrix in ascending or descending order"
    extends Modelica.Icons.Function;
    input Real M[:,:] "Matrix to be sorted";
    input Boolean sortRows = true
      "= true if rows are sorted, otherwise columns";
    input Boolean ascending = true
      "= true if ascending order, otherwise descending order";
    output Real sorted_M[size(M,1), size(M,2)] = M "Sorted matrix";
    output Integer indices[if sortRows then size(M,1) else size(M,2)]
      "sorted_M = if sortRows then M[indices,:] else M[:,indices]";

    /* shellsort algorithm; should be improved later */
  protected
    Integer gap;
    Integer i;
    Integer j;
    Real wM2[size(M,2)];
    Integer wi;
    Integer nM1 = size(M,1);
    Boolean swap;
    Real sorted_MT[size(M,2), size(M,1)];

  encapsulated function greater "Compare whether vector v1 > v2"
      import Modelica;
    extends Modelica.Icons.Function;
      import Modelica.Utilities.Types.Compare;
    input Real v1[:];
    input Real v2[size(v1,1)];
    output Boolean result;
    protected
    Integer n = size(v1,1);
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
       i := i+1;
    end while;
  end greater;

  encapsulated function less "Compare whether vector v1 < v2"
      import Modelica;
    extends Modelica.Icons.Function;
      import Modelica.Utilities.Types.Compare;
    input Real v1[:];
    input Real v2[size(v1,1)];
    output Boolean result;
    protected
    Integer n = size(v1,1);
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
       i := i+1;
    end while;
  end less;
  algorithm
    if not sortRows then
        (sorted_MT,indices) := sort(transpose(M), ascending=ascending);
       sorted_M :=transpose(sorted_MT);
    else
       indices :=1:size(M, 1);
       gap := div(nM1,2);
       while gap > 0 loop
          i := gap;
          while i < nM1 loop
             j := i-gap;
             if j>=0 then
                if ascending then
                   swap := greater(sorted_M[j+1,:], sorted_M[j+gap+1,:]);
                else
                   swap := less(sorted_M[j+1,:], sorted_M[j+gap+1,:]);
                end if;
             else
                swap := false;
             end if;

             while swap loop
                wM2 := sorted_M[j+1,:];
                wi := indices[j+1];
                sorted_M[j+1,:] := sorted_M[j+gap+1,:];
                sorted_M[j+gap+1,:] := wM2;
                indices[j+1] := indices[j+gap+1];
                indices[j+gap+1] := wi;
                j := j - gap;
                if j >= 0 then
                   if ascending then
                      swap := greater(sorted_M[j+1,:], sorted_M[j+gap+1,:]);
                   else
                      swap := less(sorted_M[j+1,:], sorted_M[j+gap+1,:]);
                   end if;
                else
                   swap := false;
                end if;
             end while;
             i := i + 1;
          end while;
          gap := div(gap,2);
       end while;
    end if;
    annotation (Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
           sorted_M = Matrices.<b>sort</b>(M);
(sorted_M, indices) = Matrices.<b>sort</b>(M, sortRows=true, ascending=true);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <b>sort</b>(..) sorts the rows of a Real matrix M
in ascending order and returns the result in sorted_M.
If the optional argument \"sortRows\" is <b>false</b>, the columns
of the matrix are sorted.
If the optional argument \"ascending\" is <b>false</b>, the rows or
columns are sorted in descending order. In the optional second
output argument, the indices of the sorted rows or columns with respect
to the original matrix are given, such that
</p>

<pre>
   sorted_M = <b>if</b> sortedRow <b>then</b> M[indices,:] <b>else</b> M[:,indices];
</pre>

<h4>Example</h4>
<blockquote><pre>
  (M2, i2) := Matrices.sort([2, 1,  0;
                             2, 0, -1]);
       -> M2 = [2, 0, -1;
                2, 1, 0 ];
          i2 = {2,1};
</pre></blockquote>
</HTML>"));
  end sort;

  function flipLeftRight "Flip the columns of a matrix in left/right direction"

    input Real A[:,:] "Matrix to be flipped";
    output Real Aflip[size(A, 1),size(A, 2)] "Flipped matrix";
  algorithm
    Aflip := A[:,{i for i in size(A,2):-1:1}];

    annotation (Inline=true, Documentation(info="<html>
 <h4>Syntax</h4>
<blockquote><pre>
         A_flr = Matrices.<b>flipLeftRight</b>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <b>flipLeftRight</b> computes from matrix <b>A</b> a matrix <b>A_flr</b> with flipped columns, i.e., <b>A_flr</b>[:,i]=<b>A</b>[:,n-i+1], i=1,..., n.
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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end flipLeftRight;

  function flipUpDown "Flip the rows of a matrix in up/down direction"

    input Real A[:,:] "Matrix to be flipped";
    output Real Aflip[size(A, 1),size(A, 2)] "Flipped matrix";
  algorithm
    Aflip := A[{i for i in size(A,1):-1:1},:];

    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
         A_fud = Matrices.<b>flipUpDown</b>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <b>flipUpDown</b> computes from matrix <b>A</b> a matrix <b>A_fud</b> with flipped rows, i.e., <b>A_fud</b>[i,:]=<b>A</b>[n-i+1,:], i=1,..., n.
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
<li><i>2010/05/31 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
  end flipUpDown;

  package LAPACK
    "Interface to LAPACK library (should usually not directly be used but only indirectly via Modelica.Math.Matrices)"
    extends Modelica.Icons.Package;

    function dgeev
      "Compute eigenvalues and (right) eigenvectors for real nonsymmetrix matrix A"

      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      output Real eigenReal[size(A, 1)] "Real part of eigen values";
      output Real eigenImag[size(A, 1)] "Imaginary part of eigen values";
      output Real eigenVectors[size(A, 1), size(A, 1)] "Right eigen vectors";
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lwork=12*n;
      Real Awork[n, n]=A;
      Real work[lwork];

    external "Fortran 77" dgeev("N", "V", n, Awork, n, eigenReal, eigenImag,
        eigenVectors, n, eigenVectors, n, work, size(work, 1), info)
        annotation (Library="Lapack");
      annotation (
        Documentation(info="Lapack documentation
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
    WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)

            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.
    LWORK   (input) INTEGER
            The dimension of the array WORK.  LWORK >= max(1,3*N), and
            if JOBVL = 'V' or JOBVR = 'V', LWORK >= 4*N.  For good
            performance, LWORK must generally be larger.
    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            > 0:  if INFO = i, the QR algorithm failed to compute all the
                  eigenvalues, and no eigenvectors have been computed;
                  elements i+1:N of WR and WI contain eigenvalues which
                  have converged.
"));
    end dgeev;

    function dgeev_eigenValues
      "Compute eigenvalues for real nonsymmetrix matrix A"

      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      output Real EigenReal[size(A, 1)];
      output Real EigenImag[size(A, 1)];

      /*
      output Real Eigenvectors[size(A, 1), size(A, 1)]=zeros(size(A, 1), size(
          A, 1)); */
      output Integer info;
    protected
      Integer lwork=8*size(A, 1);
      Real Awork[size(A, 1), size(A, 1)]=A;
      Real work[lwork];
      Real EigenvectorsL[size(A, 1), size(A, 1)]=zeros(size(A, 1), size(A, 1));

      /*
    external "Fortran 77" dgeev("N", "V", size(A, 1), Awork, size(A, 1),
        EigenReal, EigenImag, EigenvectorsL, size(EigenvectorsL, 1),
        Eigenvectors, size(Eigenvectors, 1), work, size(work, 1), info)
*/
    external "Fortran 77" dgeev("N", "N", size(A, 1), Awork, size(A, 1),
        EigenReal, EigenImag, EigenvectorsL, size(EigenvectorsL, 1),
        EigenvectorsL, size(EigenvectorsL, 1), work, size(work, 1), info)
        annotation (Library="Lapack");

      annotation (
        Documentation(info="Lapack documentation
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
    WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)

            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.
    LWORK   (input) INTEGER
            The dimension of the array WORK.  LWORK >= max(1,3*N), and
            if JOBVL = 'V' or JOBVR = 'V', LWORK >= 4*N.  For good
            performance, LWORK must generally be larger.
    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            > 0:  if INFO = i, the QR algorithm failed to compute all the
                  eigenvalues, and no eigenvectors have been computed;
                  elements i+1:N of WR and WI contain eigenvalues which
                  have converged.
"));
    end dgeev_eigenValues;

    function dgegv
      "Compute generalized eigenvalues and eigenvectors for a (A,B) system"
      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      input Real B[size(A,1), size(A, 1)];
      output Real alphaReal[size(A, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag)/beta)";
      output Real alphaImag[size(A, 1)] "Imaginary part of alpha";
      output Real beta[size(A,1)] "Denominator of eigenvalue";
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lwork=12*n;
      Real Awork[n, n]=A;
      Real Bwork[n, n]=B;
      Real work[lwork];
      Real dummy1[1,1];
      Real dummy2[1,1];

      external "Fortran 77" dgegv("N", "N", n, Awork, n, Bwork, n, alphaReal, alphaImag, beta,
                 dummy1, 1, dummy2, 1, work, size(work, 1), info)
            annotation (Library="Lapack");
      annotation (Documentation(info="Purpose
=======

For a pair of N-by-N real nonsymmetric matrices A, B:
   compute the generalized eigenvalues (alphar +/- alphai*i, beta)
   compute the left and/or right generalized eigenvectors
           (VL and VR)
The second action is optional -- see the description of JOBVL and
JOBVR below.
A generalized eigenvalue for a pair of matrices (A,B) is, roughly
speaking, a scalar w or a ratio  alpha/beta = w, such that  A - w*B
is singular.  It is usually represented as the pair (alpha,beta),
as there is a reasonable interpretation for beta=0, and even for
both being zero.  A good beginning reference is the book, \"Matrix
Computations\", by G. Golub &amp; C. van Loan (Johns Hopkins U. Press)
A right generalized eigenvector corresponding to a generalized
eigenvalue  w  for a pair of matrices (A,B) is a vector  r  such
that  (A - w B) r = 0 .  A left generalized eigenvector is a vector
                       H
l  such that  (A - w B) l = 0 .
Note: this routine performs \"full balancing\" on A and B -- see
\"Further Details\", below.
Arguments
=========
JOBVL   (input) CHARACTER*1
        = 'N':  do not compute the left generalized eigenvectors;
        = 'V':  compute the left generalized eigenvectors.
JOBVR   (input) CHARACTER*1
        = 'N':  do not compute the right generalized eigenvectors;
        = 'V':  compute the right generalized eigenvectors.
N       (input) INTEGER
        The number of rows and columns in the matrices A, B, VL, and
        VR.  N >= 0.
A       (input/workspace) DOUBLE PRECISION array, dimension (LDA, N)
        On entry, the first of the pair of matrices whose
        generalized eigenvalues and (optionally) generalized
        eigenvectors are to be computed.
        On exit, the contents will have been destroyed.  (For a
        description of the contents of A on exit, see \"Further
        Details\", below.)
LDA     (input) INTEGER
        The leading dimension of A.  LDA >= max(1,N).
B       (input/workspace) DOUBLE PRECISION array, dimension (LDB, N)
        On entry, the second of the pair of matrices whose
        generalized eigenvalues and (optionally) generalized
        eigenvectors are to be computed.
        On exit, the contents will have been destroyed.  (For a
        description of the contents of B on exit, see \"Further
        Details\", below.)
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
        If JOBVL = 'V', the left generalized eigenvectors.  (See
        \"Purpose\", above.)  Real eigenvectors take one column,
        complex take two columns, the first for the real part and
        the second for the imaginary part.  Complex eigenvectors
        correspond to an eigenvalue with positive imaginary part.
        Each eigenvector will be scaled so the largest component
        will have abs(real part) + abs(imag. part) = 1, *except*
        that for eigenvalues with alpha=beta=0, a zero vector will
        be returned as the corresponding eigenvector.
        Not referenced if JOBVL = 'N'.
LDVL    (input) INTEGER
        The leading dimension of the matrix VL. LDVL >= 1, and
        if JOBVL = 'V', LDVL >= N.
VR      (output) DOUBLE PRECISION array, dimension (LDVR,N)
        If JOBVL = 'V', the right generalized eigenvectors.  (See
        \"Purpose\", above.)  Real eigenvectors take one column,
        complex take two columns, the first for the real part and
        the second for the imaginary part.  Complex eigenvectors
        correspond to an eigenvalue with positive imaginary part.
        Each eigenvector will be scaled so the largest component
        will have abs(real part) + abs(imag. part) = 1, *except*
        that for eigenvalues with alpha=beta=0, a zero vector will
        be returned as the corresponding eigenvector.
        Not referenced if JOBVR = 'N'.
LDVR    (input) INTEGER
        The leading dimension of the matrix VR. LDVR >= 1, and
        if JOBVR = 'V', LDVR >= N.
WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
        On exit, if INFO = 0, WORK(1) returns the optimal LWORK.
LWORK   (input) INTEGER
        The dimension of the array WORK.  LWORK >= max(1,8*N).
        For good performance, LWORK must generally be larger.
        To compute the optimal value of LWORK, call ILAENV to get
        blocksizes (for DGEQRF, DORMQR, and DORGQR.)  Then compute:
        NB  -- MAX of the blocksizes for DGEQRF, DORMQR, and DORGQR;
        The optimal LWORK is:
            2*N + MAX( 6*N, N*(NB+1) ).
INFO    (output) INTEGER
        = 0:  successful exit
        < 0:  if INFO = -i, the i-th argument had an illegal value.
        = 1,...,N:
              The QZ iteration failed.  No eigenvectors have been
              calculated, but ALPHAR(j), ALPHAI(j), and BETA(j)
              should be correct for j=INFO+1,...,N.
        > N:  errors that usually indicate LAPACK problems:
              =N+1: error return from DGGBAL
              =N+2: error return from DGEQRF
              =N+3: error return from DORMQR
              =N+4: error return from DORGQR
              =N+5: error return from DGGHRD
              =N+6: error return from DHGEQZ (other than failed
                                              iteration)
              =N+7: error return from DTGEVC
              =N+8: error return from DGGBAK (computing VL)
              =N+9: error return from DGGBAK (computing VR)
              =N+10: error return from DLASCL (various calls)
Further Details
===============
Balancing
---------
This driver calls DGGBAL to both permute and scale rows and columns
of A and B.  The permutations PL and PR are chosen so that PL*A*PR
and PL*B*R will be upper triangular except for the diagonal blocks
A(i:j,i:j) and B(i:j,i:j), with i and j as close together as
possible.  The diagonal scaling matrices DL and DR are chosen so
that the pair  DL*PL*A*PR*DR, DL*PL*B*PR*DR have entries close to
one (except for the entries that start out zero.)
After the eigenvalues and eigenvectors of the balanced matrices
have been computed, DGGBAK transforms the eigenvectors back to what
they would have been (in perfect arithmetic) if they had not been
balanced.
Contents of A and B on Exit
-------- -- - --- - -- ----
If any eigenvectors are computed (either JOBVL='V' or JOBVR='V' or
both), then on exit the arrays A and B will contain the real Schur
form[*] of the \"balanced\" versions of A and B.  If no eigenvectors
are computed, then only the diagonal blocks will be correct.
[*] See DHGEQZ, DGEGS, or read the book \"Matrix Computations\",
"));
    end dgegv;

    function dgelsx
      "Computes the minimum-norm solution to a real linear least squares problem with rank deficient A"

      extends Modelica.Icons.Function;
      input Real A[:, :];
      input Real B[size(A,1), :];
      input Real rcond=0.0 "Reciprocal condition number to estimate rank";
      output Real X[max(nrow,ncol),nrhs]= cat(1,B,zeros(max(nrow,ncol)-nrow,nrhs))
        "Solution is in first size(A,2) rows";
      output Integer info;
      output Integer rank "Effective rank of A";
    protected
      Integer nrow=size(A,1);
      Integer ncol=size(A,2);
      Integer nx=max(nrow,ncol);
      Integer nrhs=size(B,2);
      Integer lwork=max( min(nrow,ncol)+3*ncol, 2*min(nrow,ncol)+nrhs);
      Real work[lwork];
      Real Awork[nrow,ncol]=A;
      Integer jpvt[ncol]=zeros(ncol);
      external "FORTRAN 77" dgelsx(nrow, ncol, nrhs, Awork, nrow, X, nx, jpvt,
                                  rcond, rank, work, lwork, info) annotation (Library="Lapack");

      annotation (
        Documentation(info="Lapack documentation
  Purpose
  =======

  DGELSX computes the minimum-norm solution to a real linear least
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
          If m >= n and RANK = n, the residual sum-of-squares for
          the solution in the i-th column is given by the sum of
          squares of elements N+1:M in that column.

  LDB     (input) INTEGER
          The leading dimension of the array B. LDB >= max(1,M,N).

  JPVT    (input/output) INTEGER array, dimension (N)
          On entry, if JPVT(i) .ne. 0, the i-th column of A is an
          initial column, otherwise it is a free column.  Before
          the QR factorization of A, all initial columns are
          permuted to the leading positions; only the remaining
          free columns are moved as a result of column pivoting
          during the factorization.
          On exit, if JPVT(i) = k, then the i-th column of A*P
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

  WORK    (workspace) DOUBLE PRECISION array, dimension
                      (max( min(M,N)+3*N, 2*min(M,N)+NRHS )),

  INFO    (output) INTEGER
          = 0:  successful exit
          < 0:  if INFO = -i, the i-th argument had an illegal value    "));

    end dgelsx;

    function dgelsx_vec
      "Computes the minimum-norm solution to a real linear least squares problem with rank deficient A"

      extends Modelica.Icons.Function;
      input Real A[:, :];
      input Real b[size(A,1)];
      input Real rcond=0.0 "Reciprocal condition number to estimate rank";
      output Real x[max(nrow,ncol)]= cat(1,b,zeros(max(nrow,ncol)-nrow))
        "solution is in first size(A,2) rows";
      output Integer info;
      output Integer rank "Effective rank of A";
    protected
      Integer nrow=size(A,1);
      Integer ncol=size(A,2);
      Integer nx=max(nrow,ncol);
      Integer lwork=max( min(nrow,ncol)+3*ncol, 2*min(nrow,ncol)+1);
      Real work[lwork];
      Real Awork[nrow,ncol]=A;
      Integer jpvt[ncol]=zeros(ncol);
      external "FORTRAN 77" dgelsx(nrow, ncol, 1, Awork, nrow, x, nx, jpvt,
                                  rcond, rank, work, lwork, info) annotation (Library="Lapack");

      annotation (
        Documentation(info="Lapack documentation
  Purpose
  =======

  DGELSX computes the minimum-norm solution to a real linear least
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
          If m >= n and RANK = n, the residual sum-of-squares for
          the solution in the i-th column is given by the sum of
          squares of elements N+1:M in that column.

  LDB     (input) INTEGER
          The leading dimension of the array B. LDB >= max(1,M,N).

  JPVT    (input/output) INTEGER array, dimension (N)
          On entry, if JPVT(i) .ne. 0, the i-th column of A is an
          initial column, otherwise it is a free column.  Before
          the QR factorization of A, all initial columns are
          permuted to the leading positions; only the remaining
          free columns are moved as a result of column pivoting
          during the factorization.
          On exit, if JPVT(i) = k, then the i-th column of A*P
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

  WORK    (workspace) DOUBLE PRECISION array, dimension
                      (max( min(M,N)+3*N, 2*min(M,N)+NRHS )),

  INFO    (output) INTEGER
          = 0:  successful exit
          < 0:  if INFO = -i, the i-th argument had an illegal value    "));

    end dgelsx_vec;

    function dgels_vec
      "Solves overdetermined or underdetermined real linear equations A*x=b with a b vector"

      extends Modelica.Icons.Function;
      input Real A[:, :];
      input Real b[size(A,1)];
      output Real x[nx]= cat(1,b,zeros(nx-nrow))
        "solution is in first size(A,2) rows";
      output Integer info;
    protected
      Integer nrow=size(A,1);
      Integer ncol=size(A,2);
      Integer nx=max(nrow,ncol);
      Integer lwork=min(nrow,ncol) + nx;
      Real work[lwork];
      Real Awork[nrow,ncol]=A;
      external "FORTRAN 77" dgels("N", nrow, ncol, 1, Awork, nrow, x,
                                  nx, work, lwork, info) annotation (Library="Lapack");

      annotation (
        Documentation(info="Lapack documentation
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

  TRANS   (input) CHARACTER
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
          On exit, B is overwritten by the solution vectors, stored
          columnwise:  if TRANS = 'N' and m >= n, rows 1 to n of B
          contain the least squares solution vectors; the residual
          sum of squares for the solution in each column is given by
          the sum of squares of elements N+1 to M in that column;
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

  WORK    (workspace) DOUBLE PRECISION array, dimension (LWORK)
          On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

  LWORK   (input) INTEGER
          The dimension of the array WORK.
          LWORK >= min(M,N) + MAX(1,M,N,NRHS).
          For optimal performance,
          LWORK >= min(M,N) + MAX(1,M,N,NRHS) * NB
          where NB is the optimum block size.

  INFO    (output) INTEGER
          = 0:  successful exit
          < 0:  if INFO = -i, the i-th argument had an illegal value
                                                                          "));

    end dgels_vec;

    function dgesv
      "Solve real system of linear equations A*X=B with a B matrix"
      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      input Real B[size(A, 1), :];
      output Real X[size(A, 1), size(B, 2)]=B;
      output Integer info;
    protected
      Real Awork[size(A, 1), size(A, 1)]=A;
      Integer lda=max(1,size(A,1));
      Integer ldb=max(1,size(B,1));
      Integer ipiv[size(A, 1)];

    external "FORTRAN 77" dgesv(size(A, 1), size(B, 2), Awork, lda, ipiv, X, ldb, info) annotation (Library="Lapack");
      annotation (
        Documentation(info="Lapack documentation:
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

    function dgesv_vec
      "Solve real system of linear equations A*x=b with a b vector"
      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      input Real b[size(A, 1)];
      output Real x[size(A, 1)]=b;
      output Integer info;
    protected
      Real Awork[size(A, 1), size(A, 1)]=A;
      Integer lda=max(1,size(A,1));
      Integer ldb=max(1,size(b,1));
      Integer ipiv[size(A, 1)];

    external "FORTRAN 77" dgesv(size(A, 1), 1, Awork, lda, ipiv, x, ldb, info) annotation (Library="Lapack");
      annotation (
        Documentation(info="
Same as function LAPACK.dgesv, but right hand side is a vector and not a matrix.
For details of the arguments, see documentation of dgesv.
"));
    end dgesv_vec;

    function dgglse_vec
      "Solve a linear equality constrained least squares problem"
      extends Modelica.Icons.Function;
      input Real A[:,:] "Minimize |A*x - c|^2";
      input Real c[size(A,1)];
      input Real B[:,size(A,2)] "subject to B*x=d";
      input Real d[size(B,1)];
      output Real x[size(A,2)] "solution vector";
      output Integer info;
    protected
      Integer nrow_A=size(A,1);
      Integer nrow_B=size(B,1);
      Integer ncol_A=size(A,2) "(min=nrow_B,max=nrow_A+nrow_B) required";
      Real Awork[nrow_A,ncol_A]=A;
      Real Bwork[nrow_B,ncol_A]=B;
      Real cwork[nrow_A] = c;
      Real dwork[nrow_B] = d;
      Integer lwork=ncol_A + nrow_B + max(nrow_A, max(ncol_A, nrow_B))*5;
      Real work[lwork];
      external "FORTRAN 77" dgglse(nrow_A, ncol_A, nrow_B, Awork, nrow_A,
                                   Bwork, nrow_B, cwork, dwork, x,
                                   work, lwork, info)             annotation (Library="Lapack");

      annotation (
        Documentation(info="Lapack documentation

  Purpose
  =======

  DGGLSE solves the linear equality constrained least squares (LSE)
  problem:

          minimize || A*x - c ||_2   subject to B*x = d

  using a generalized RQ factorization of matrices A and B, where A is
  M-by-N, B is P-by-N, assume P <= N <= M+P, and ||.||_2 denotes vector
  2-norm. It is assumed that

                       rank(B) = P                                  (1)

  and the null spaces of A and B intersect only trivially, i.e.,

   intersection of Null(A) and Null(B) = {0} <=> rank( ( A ) ) = N  (2)
                                                     ( ( B ) )

  where N(A) denotes the null space of matrix A. Conditions (1) and (2)
  ensure that the problem LSE has a unique solution.

  Arguments
  =========

  M       (input) INTEGER
          The number of rows of the matrix A.  M >= 0.

  N       (input) INTEGER
          The number of columns of the matrices A and B. N >= 0.
          Assume that P <= N <= M+P.

  P       (input) INTEGER
          The number of rows of the matrix B.  P >= 0.

  A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
          On entry, the P-by-M matrix A.
          On exit, A is destroyed.

  LDA     (input) INTEGER
          The leading dimension of the array A. LDA >= max(1,M).

  B       (input/output) DOUBLE PRECISION array, dimension (LDB,N)
          On entry, the P-by-N matrix B.
          On exit, B is destroyed.

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

  WORK    (workspace) DOUBLE PRECISION array, dimension (LWORK)
          On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

  LWORK   (input) INTEGER
          The dimension of the array WORK. LWORK >= N+P+max(N,M,P).
          For optimum performance LWORK >=
          N+P+max(M,P,N)*max(NB1,NB2), where NB1 is the optimal
          blocksize for the QR factorization of M-by-N matrix A.
          NB2 is the optimal blocksize for the RQ factorization of
          P-by-N matrix B.

  INFO    (output) INTEGER
          = 0:  successful exit.
          < 0:  if INFO = -i, the i-th argument had an illegal value.
"));
    end dgglse_vec;

    function dgtsv
      "Solve real system of linear equations A*X=B with B matrix and tridiagonal A"

      extends Modelica.Icons.Function;
      input Real superdiag[:];
      input Real diag[size(superdiag, 1) + 1];
      input Real subdiag[size(superdiag, 1)];
      input Real B[size(diag, 1), :];
      output Real X[size(B, 1), size(B, 2)]=B;
      output Integer info;
    protected
      Real superdiagwork[size(superdiag, 1)]=superdiag;
      Real diagwork[size(diag, 1)]=diag;
      Real subdiagwork[size(subdiag, 1)]=subdiag;

    external "FORTRAN 77" dgtsv(size(diag, 1), size(B, 2), subdiagwork,
        diagwork, superdiagwork, X, size(B, 1), info)
        annotation (Library="Lapack");
      annotation (
        Documentation(info="Lapack documentation:
    Purpose
    =======
    DGTSV  solves the equation
       A*X = B,
    where A is an N-by-N tridiagonal matrix, by Gaussian elimination with

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
            On entry, DL must contain the (n-1) subdiagonal elements of
            A.
            On exit, DL is overwritten by the (n-2) elements of the
            second superdiagonal of the upper triangular matrix U from
            the LU factorization of A, in DL(1), ..., DL(n-2).
    D       (input/output) DOUBLE PRECISION array, dimension (N)
            On entry, D must contain the diagonal elements of A.
            On exit, D is overwritten by the n diagonal elements of U.
    DU      (input/output) DOUBLE PRECISION array, dimension (N-1)
            On entry, DU must contain the (n-1) superdiagonal elements
            of A.
            On exit, DU is overwritten by the (n-1) elements of the first

            superdiagonal of U.
    B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
            On entry, the N-by-NRHS right hand side matrix B.
            On exit, if INFO = 0, the N-by-NRHS solution matrix X.
    LDB     (input) INTEGER
            The leading dimension of the array B.  LDB >= max(1,N).
    INFO    (output) INTEGER
            = 0:  successful exit
            < 0:  if INFO = -i, the i-th argument had an illegal value
            > 0:  if INFO = i, U(i,i) is exactly zero, and the solution
                  has not been computed.  The factorization has not been

                  completed unless i = N.
"));
    end dgtsv;

    function dgtsv_vec
      "Solve real system of linear equations A*x=b with b vector and tridiagonal A"

      extends Modelica.Icons.Function;
      input Real superdiag[:];
      input Real diag[size(superdiag, 1) + 1];
      input Real subdiag[size(superdiag, 1)];
      input Real b[size(diag, 1)];
      output Real x[size(b, 1)]=b;
      output Integer info;
    protected
      Real superdiagwork[size(superdiag, 1)]=superdiag;
      Real diagwork[size(diag, 1)]=diag;
      Real subdiagwork[size(subdiag, 1)]=subdiag;

    external "FORTRAN 77" dgtsv(size(diag, 1), 1, subdiagwork, diagwork,
        superdiagwork, x, size(b, 1), info) annotation (Library="Lapack");
      annotation (
        Documentation(info="
Same as function LAPACK.dgtsv, but right hand side is a vector and not a matrix.
For details of the arguments, see documentation of dgtsv.
"));
    end dgtsv_vec;

    function dgbsv
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
      Real Awork[size(A, 1), size(A, 2)]=A;
      Integer ipiv[n];

    external "FORTRAN 77" dgbsv(n, kLower, kUpper, size(B, 2), Awork, size(
        Awork, 1), ipiv, X, n, info) annotation (Library="Lapack");
      annotation (
        Documentation(info="Lapack documentation:
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
elements of U because of fill-in resulting from the row interchanges."));
    end dgbsv;

    function dgbsv_vec
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
      Real Awork[size(A, 1), size(A, 2)]=A;
      Integer ipiv[n];

    external "FORTRAN 77" dgbsv(n, kLower, kUpper, 1, Awork, size(Awork, 1),
        ipiv, x, n, info) annotation (Library="Lapack");
      annotation (
        Documentation(info="Lapack documentation:
"));
    end dgbsv_vec;

    function dgesvd "Determine singular value decomposition"
      extends Modelica.Icons.Function;
      input Real A[:, :];
      output Real sigma[min(size(A, 1), size(A, 2))];
      output Real U[size(A, 1), size(A, 1)]=zeros(size(A, 1), size(A, 1));
      output Real VT[size(A, 2), size(A, 2)]=zeros(size(A, 2), size(A, 2));
      output Integer info;
    protected
      Real Awork[size(A, 1), size(A, 2)]=A;
      Integer lwork=5*size(A, 1) + 5*size(A, 2);
      Real work[lwork];

    external "Fortran 77" dgesvd("A", "A", size(A, 1), size(A, 2), Awork, size(
        A, 1), sigma, U, size(A, 1), VT, size(A, 2), work, lwork, info)
        annotation (Library="Lapack");
      annotation (
        Documentation(info="Lapack documentation:
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
    WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)

            On exit, if INFO = 0, WORK(1) returns the optimal LWORK;
            if INFO > 0, WORK(2:MIN(M,N)) contains the unconverged
            superdiagonal elements of an upper bidiagonal matrix B
            whose diagonal is in S (not necessarily sorted). B
            satisfies A = U * B * VT, so it has the same singular values

            as A, and singular vectors related by U and VT.
    LWORK   (input) INTEGER
            The dimension of the array WORK. LWORK >= 1.
            LWORK >= MAX(3*MIN(M,N)+MAX(M,N),5*MIN(M,N)-4).
            For good performance, LWORK should generally be larger.
    INFO    (output) INTEGER
            = 0:  successful exit.
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            > 0:  if DBDSQR did not converge, INFO specifies how many
                  superdiagonals of an intermediate bidiagonal form B
                  did not converge to zero. See the description of WORK
                  above for details.
"));
    end dgesvd;

    function dgesvd_sigma "Determine singular values"
      extends Modelica.Icons.Function;
      input Real A[:, :];
      output Real sigma[min(size(A, 1), size(A, 2))];
      output Integer info;
    protected
      Real Awork[size(A, 1), size(A, 2)]=A;
      Real U[size(A, 1), size(A, 1)];
      Real VT[size(A, 2), size(A, 2)];
      Integer lwork=5*size(A, 1) + 5*size(A, 2);
      Real work[lwork];

    external "Fortran 77" dgesvd("N", "N", size(A, 1), size(A, 2), Awork, size(
        A, 1), sigma, U, size(A, 1), VT, size(A, 2), work, lwork, info)
        annotation (Library="Lapack");
      annotation (
        Documentation(info="Lapack documentation:
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
    WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)

            On exit, if INFO = 0, WORK(1) returns the optimal LWORK;
            if INFO > 0, WORK(2:MIN(M,N)) contains the unconverged
            superdiagonal elements of an upper bidiagonal matrix B
            whose diagonal is in S (not necessarily sorted). B
            satisfies A = U * B * VT, so it has the same singular values

            as A, and singular vectors related by U and VT.
    LWORK   (input) INTEGER
            The dimension of the array WORK. LWORK >= 1.
            LWORK >= MAX(3*MIN(M,N)+MAX(M,N),5*MIN(M,N)-4).
            For good performance, LWORK should generally be larger.
    INFO    (output) INTEGER
            = 0:  successful exit.
            < 0:  if INFO = -i, the i-th argument had an illegal value.
            > 0:  if DBDSQR did not converge, INFO specifies how many
                  superdiagonals of an intermediate bidiagonal form B
                  did not converge to zero. See the description of WORK
                  above for details.
"));
    end dgesvd_sigma;

    function dgetrf
      "Compute LU factorization of square or rectangular matrix A (A = P*L*U)"

      extends Modelica.Icons.Function;
      input Real A[:, :] "Square or rectangular matrix";
      output Real LU[size(A, 1), size(A, 2)]=A;
      output Integer pivots[min(size(A, 1), size(A, 2))] "Pivot vector";
      output Integer info "Information";
    protected
      Integer lda=max(1,size(A, 1));
    external "FORTRAN 77" dgetrf(size(A, 1), size(A, 2), LU, lda, pivots,
         info) annotation (Library="Lapack");
      annotation (
        Documentation(info="Lapack documentation:
  SUBROUTINE DGETRF( M, N, A, LDA, IPIV, INFO )
-- LAPACK routine (version 1.1) --
   Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
   Courant Institute, Argonne National Lab, and Rice University
   March 31, 1993
   .. Scalar Arguments ..
   INTEGER            INFO, LDA, M, N
   ..
   .. Array Arguments ..
   INTEGER            IPIV( * )
   DOUBLE PRECISION   A( LDA, * )
   ..
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

      function dgetrs
      "Solves a system of linear equations with the LU decomposition from dgetrf(..)"

        extends Modelica.Icons.Function;
        input Real LU[:, size(LU, 1)]
        "LU factorization of dgetrf of a square matrix";
        input Integer pivots[size(LU, 1)] "Pivot vector of dgetrf";
        input Real B[size(LU, 1),:] "Right hand side matrix B";
        output Real X[size(B, 1), size(B,2)]=B "Solution matrix X";
        output Integer info;
    protected
        Real work[size(LU, 1), size(LU, 1)]=LU;
        Integer lda=max(1,size(LU, 1));
        Integer ldb=max(1,size(B, 1));

      external "FORTRAN 77" dgetrs("N", size(LU, 1), size(B,2), work, lda, pivots,
           X, ldb, info) annotation (Library="Lapack");
        annotation (
          Documentation(info="Lapack documentation:
  SUBROUTINE DGETRS( TRANS, N, NRHS, A, LDA, IPIV, B, LDB, INFO )
-- LAPACK routine (version 1.1) --
   Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
   Courant Institute, Argonne National Lab, and Rice University
   March 31, 1993
   .. Scalar Arguments ..
   CHARACTER          TRANS
   INTEGER            INFO, LDA, LDB, N, NRHS
   ..
   .. Array Arguments ..
   INTEGER            IPIV( * )
   DOUBLE PRECISION   A( LDA, * ), B( LDB, * )
   ..
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

    function dgetrs_vec
      "Solves a system of linear equations with the LU decomposition from dgetrf(..)"

      extends Modelica.Icons.Function;
      input Real LU[:, size(LU, 1)]
        "LU factorization of dgetrf of a square matrix";
      input Integer pivots[size(LU, 1)] "Pivot vector of dgetrf";
      input Real b[size(LU, 1)] "Right hand side vector b";
      output Real x[size(b, 1)]=b;
      output Integer info;

    protected
      Real work[size(LU, 1), size(LU, 1)]=LU;
      Integer lda=max(1,size(LU, 1));
      Integer ldb=max(1,size(b, 1));

    external "FORTRAN 77" dgetrs("N", size(LU, 1), 1, work, lda, pivots,
         x, ldb, info) annotation (Library="Lapack");
      annotation (
        Documentation(info="Lapack documentation:
  SUBROUTINE DGETRS( TRANS, N, NRHS, A, LDA, IPIV, B, LDB, INFO )
-- LAPACK routine (version 1.1) --
   Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
   Courant Institute, Argonne National Lab, and Rice University
   March 31, 1993
   .. Scalar Arguments ..
   CHARACTER          TRANS
   INTEGER            INFO, LDA, LDB, N, NRHS
   ..
   .. Array Arguments ..
   INTEGER            IPIV( * )
   DOUBLE PRECISION   A( LDA, * ), B( LDB, * )
   ..
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

    function dgetri
      "Computes the inverse of a matrix using the LU factorization from dgetrf(..)"

      extends Modelica.Icons.Function;
      input Real LU[:, size(LU, 1)]
        "LU factorization of dgetrf of a square matrix";
      input Integer pivots[size(LU, 1)] "Pivot vector of dgetrf";
      output Real inv[size(LU, 1), size(LU, 2)]=LU "Inverse of matrix P*L*U";
      output Integer info;

    protected
      Integer lda=max(1,size(LU, 1));
      Integer lwork=max(1,min(10, size(LU, 1))*size(LU, 1))
        "Length of work array";
      Real work[lwork];

    external "FORTRAN 77" dgetri(size(LU, 1), inv, lda, pivots, work, lwork, info) annotation (Library="Lapack");
      annotation (
        Documentation(info="Lapack documentation:
   SUBROUTINE DGETRI( N, A, LDA, IPIV, WORK, LWORK, INFO )
-- LAPACK routine (version 1.1) --
   Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
   Courant Institute, Argonne National Lab, and Rice University
   March 31, 1993
   .. Scalar Arguments ..
   INTEGER            INFO, LDA, LWORK, N
   ..
   .. Array Arguments ..
   INTEGER            IPIV( * )
   DOUBLE PRECISION   A( LDA, * ), WORK( LWORK )
   ..
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
WORK    (workspace) DOUBLE PRECISION array, dimension (LWORK)
        On exit, if INFO=0, then WORK(1) returns the optimal LWORK.
LWORK   (input) INTEGER
        The dimension of the array WORK.  LWORK >= max(1,N).
        For optimal performance LWORK >= N*NB, where NB is
        the optimal blocksize returned by ILAENV.
INFO    (output) INTEGER
        = 0:  successful exit
        < 0:  if INFO = -i, the i-th argument had an illegal value
        > 0:  if INFO = i, U(i,i) is exactly zero; the matrix is
              singular and its inverse could not be computed."));
    end dgetri;

    function dgeqpf
      "Compute QR factorization of square or rectangular matrix A with column pivoting (A(:,p) = Q*R)"

      extends Modelica.Icons.Function;
      input Real A[:, :] "Square or rectangular matrix";
      output Real QR[size(A, 1), size(A, 2)]=A
        "QR factorization in packed format";
      output Real tau[min(size(A, 1), size(A, 2))]
        "The scalar factors of the elementary reflectors of Q";
      output Integer p[size(A, 2)]=zeros(size(A, 2)) "Pivot vector";
      output Integer info;
    protected
      Integer lda=max(1,size(A, 1));
      Integer ncol=size(A, 2) "Column dimension of A";
      Real work[3*ncol] "work array";
    external "FORTRAN 77" dgeqpf(size(A, 1), ncol, QR, lda, p, tau, work,
         info) annotation (Library={"Lapack"});
      annotation (
        Documentation(info="Lapack documentation:
   SUBROUTINE DGEQPF( M, N, A, LDA, JPVT, TAU, WORK, INFO )
-- LAPACK test routine (version 1.1) --
   Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
   Courant Institute, Argonne National Lab, and Rice University
   March 31, 1993
   .. Scalar Arguments ..
   INTEGER            INFO, LDA, M, N
   ..
   .. Array Arguments ..
   INTEGER            JPVT( * )
   DOUBLE PRECISION   A( LDA, * ), TAU( * ), WORK( * )
   ..
Purpose
=======
DGEQPF computes a QR factorization with column pivoting of a
real M-by-N matrix A: A*P = Q*R.
Arguments
=========
M       (input) INTEGER
        The number of rows of the matrix A. M >= 0.
N       (input) INTEGER
        The number of columns of the matrix A. N >= 0
A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
        On entry, the M-by-N matrix A.
        On exit, the upper triangle of the array contains the
        min(M,N)-by-N upper triangular matrix R; the elements
        below the diagonal, together with the array TAU,
        represent the orthogonal matrix Q as a product of
        min(m,n) elementary reflectors.
LDA     (input) INTEGER
        The leading dimension of the array A. LDA >= max(1,M).
JPVT    (input/output) INTEGER array, dimension (N)
        On entry, if JPVT(i) .ne. 0, the i-th column of A is permuted
        to the front of A*P (a leading column); if JPVT(i) = 0,
        the i-th column of A is a free column.
        On exit, if JPVT(i) = k, then the i-th column of A*P
        was the k-th column of A.
TAU     (output) DOUBLE PRECISION array, dimension (min(M,N))
        The scalar factors of the elementary reflectors.
WORK    (workspace) DOUBLE PRECISION array, dimension (3*N)
INFO    (output) INTEGER
        = 0:  successful exit
        < 0:  if INFO = -i, the i-th argument had an illegal value
Further Details
===============
The matrix Q is represented as a product of elementary reflectors
   Q = H(1) H(2) . . . H(n)
Each H(i) has the form
   H = I - tau * v * v'
where tau is a real scalar, and v is a real vector with
v(1:i-1) = 0 and v(i) = 1; v(i+1:m) is stored on exit in A(i+1:m,i).
The matrix P is represented in jpvt as follows: If
   jpvt(j) = i
then the jth column of P is the ith canonical unit vector."));
    end dgeqpf;

    function dorgqr
      "Generates a Real orthogonal matrix Q which is defined as the product of elementary reflectors as returned from dgeqpf"

      extends Modelica.Icons.Function;
      input Real QR[:, :] "QR from dgeqpf";
      input Real tau[min(size(QR, 1), size(QR, 2))]
        "The scalar factors of the elementary reflectors of Q";
      output Real Q[size(QR, 1), size(QR, 2)]=QR "Orthogonal matrix Q";
      output Integer info;

    protected
      Integer lda=max(1,size(Q, 1));
      Integer lwork=max(1,min(10, size(QR, 2))*size(QR, 2))
        "Length of work array";
      Real work[lwork];
    external "FORTRAN 77" dorgqr(size(QR, 1), size(QR, 2), size(tau, 1), Q,
        lda,  tau, work, lwork, info) annotation (Library={"Lapack"});
      annotation (
        Documentation(info="Lapack documentation:
   SUBROUTINE DORGQR( M, N, K, A, LDA, TAU, WORK, LWORK, INFO )
-- LAPACK routine (version 1.1) --
   Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
   Courant Institute, Argonne National Lab, and Rice University
   March 31, 1993
   .. Scalar Arguments ..
   INTEGER            INFO, K, LDA, LWORK, M, N
   ..
   .. Array Arguments ..
   DOUBLE PRECISION   A( LDA, * ), TAU( * ), WORK( LWORK )
   ..
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
WORK    (workspace) DOUBLE PRECISION array, dimension (LWORK)
        On exit, if INFO = 0, WORK(1) returns the optimal LWORK.
LWORK   (input) INTEGER
        The dimension of the array WORK. LWORK >= max(1,N).
        For optimum performance LWORK >= N*NB, where NB is the
        optimal blocksize.
INFO    (output) INTEGER
        = 0:  successful exit
        < 0:  if INFO = -i, the i-th argument has an illegal value
"));
    end dorgqr;

    function dgees
      "Computes real Schur form T of  real nonsymmetric matrix A, and, optionally, the matrix of Schur vectors Z as well as the eigenvalues"

      input Real A[:,size(A,1)] "Square matrix";
      output Real T[size(A, 1), size(A, 2)]=A "Real Schur form with A = Z*T*Z'";
      output Real Z[size(A, 1), size(A, 1)]
        "orthogonal matrix Z of Schur vectors";
      output Real eval_real[size(A, 1)] "real part of the eigenvectors of A";
      output Real eval_imag[size(A, 1)]
        "imaginary part of the eigenvectors of A";
      output Integer info;

    protected
      Integer n=size(A, 1) "Row dimension of A";
      Integer lda=max(1,n);
      Integer sdim=0;
      Boolean bwork[n];

      external "FORTRAN 77" c_inter_dgees("V", "N", n, T, lda, sdim, eval_real, eval_imag, Z, lda, bwork, info)
      annotation (Include="
#include<f2c.h>
#ifdef __cplusplus
typedef logical (*L_fp2)(...);
#else
typedef logical (*L_fp2)();
#endif
logical select_(doublereal *par1, doublereal *par2)
{
return false;
};

extern  int dgees_(char *, char *, L_fp2, integer *, doublereal *, integer *, integer *, doublereal *, doublereal *,
                   doublereal *, integer *, doublereal *, integer *, logical *, integer *);
extern logical select_(doublereal *par1, doublereal *par2);

int c_inter_dgees_(char *jobvs, char *sort, integer *n, doublereal *a, integer *lda, integer *sdim, doublereal *wr,
        doublereal *wi, doublereal *z, integer *ldz, logical *bwork, integer *info)
{

  doublereal *work;
  integer nn=*n;
  integer lwork=-1;

   work = (doublereal *) malloc((3*nn+1)*sizeof(doublereal));
   dgees_(jobvs, sort, (L_fp2)select_, n, a, lda, sdim, wr, wi, z, ldz, work, &lwork, bwork, info);
   lwork=(int)(work[0]);
   free(work);
   work = (doublereal *) malloc((lwork+1)*sizeof(doublereal));
   dgees_(jobvs, sort, (L_fp2)select_, n, a, lda, sdim, wr, wi, z, ldz, work, &lwork, bwork, info);
  free(work);
  return 0;
  }",     Library={"lapack"});

      annotation (Documentation(info="
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

    function dtrsen "Reorder the real Schur factorization of a real matrix"

      input String job="N" "Specifies the usage of a condition number";
      input String compq="V" "Is \"V\" if Schur vector matrix is to be updated";
      input Boolean select[:] "Specifies the eigenvalues to reorder";
      input Real T[:,:] "Real Schur form to be reordered";
      input Real Q[:,size(T, 2)] "Matrix of the Schur vectors";

    protected
      Integer n=size(T, 2);
      Integer ldt=max(1, n);
      Integer ldq=if compq == "V" then max(n,1) else 1;
      Integer lwork=if job == "N" then max(1, n) else if job == "E" then n*n else 2
          *n*n;
      Real work[lwork];
      Integer liwork=if job == "N" or job == "E" then 1 else n*n;
      Integer iwork[liwork];

    public
      output Real To[:,:]=T "Reordered Schur form";
      output Real Qo[:,:]=Q "Reordered Schur vectors";
      output Real wr[size(T, 2)] "Reordered eigenvalues, real part";
      output Real wi[size(T, 2)] "Reordered eigenvalues, imaginary part";
      output Integer m
        "Dimension of the invariant sub space spanned bei the selected eigenvalues";
      output Real s
        "Lower bound of the reciprocal condition number. Not referenced for job==V";
      output Real sep
        "Estimated reciprocal condition number of the specified invariant subspace";
      output Integer info;

    external "Fortran 77" dtrsen(
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
        info) annotation(Library = {"lapack"});

      annotation (Documentation(info="
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
   2-by-2 diagonal block has its diagonal elemnts equal and its
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

   WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
           On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

   LWORK   (input) INTEGER
           The dimension of the array WORK.
           If JOB = 'N', LWORK >= max(1,N);
           if JOB = 'E', LWORK >= M*(N-M);
           if JOB = 'V' or 'B', LWORK >= 2*M*(N-M).

           If LWORK = -1, then a workspace query is assumed; the routine
           only calculates the optimal size of the WORK array, returns
           this value as the first entry of the WORK array, and no error
           message related to LWORK is issued by XERBLA.

   IWORK   (workspace) INTEGER array, dimension (LIWORK)
           IF JOB = 'N' or 'E', IWORK is not referenced.

   LIWORK  (input) INTEGER
           The dimension of the array IWORK.
           If JOB = 'N' or 'E', LIWORK >= 1;
           if JOB = 'V' or 'B', LIWORK >= M*(N-M).

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

   =====================================================================  "));
    end dtrsen;

    function dgesvx
      "Solve real system of linear equations op(A)*X=B, op(A) is A or A' according to the boolean input transposed"
      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)] "Real square matrix A";
      input Real B[size(A, 1),:] "Real matrix B";
      input Boolean transposed=true
        "True if the equation to be solved is A'*X=B";
      output Real X[size(A, 1),size(B, 2)] "Solution matrix";
      output Integer info;
      output Real rcond "reciprocal condition number of the matrix A";

    protected
      String transA= if transposed then "T" else "N";
      Real Awork[size(A, 1),size(A, 2)]=A;
      Real Bwork[size(B, 1),size(B, 2)]=B;
      Real AF[size(A, 1),size(A, 2)];
      Real R[size(A, 1)];
      Real C[size(A, 1)];
      Real ferr[size(B, 2)];
      Real berr[size(B, 2)];
      Integer lda=max(1,size(A, 1));
      Real work[4*size(A, 1)];
      Integer ipiv[size(A, 1)];
      Integer iwork[size(A, 1)];

    external "FORTRAN 77" dgesvx("N", transA, size(A, 1), size(B, 2), Awork,  lda, AF, lda, ipiv, "N", R, C, B, lda, X, lda, rcond, ferr, berr, work, iwork, info)                 annotation (Library="lapack");
      annotation (Documentation(info="Lapack documentation:

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

    =====================================================================
"));
    end dgesvx;

    function dtrsyl
      "Solve the real Sylvester matrix equation op(A)*X + X*op(B) = scale*C or op(A)*X - X*op(B) = scale*C"

      input Real A[:,:] "Upper quais-triangular matrix";
      input Real B[:,:] "Upper quais-triangular matrix";
      input Real C[if tranA then size(A,1) else size(A, 2),if tranB then size(B,1) else size(B, 2)]
        "Right side of the sylvester equation";

      input Boolean tranA=false "True if op(A)=A'";
      input Boolean tranB=false "True if op(B)=B'";
      input Integer isgn=1 "Specifies the sign in the equation, +1 or -1";
      output Real X[size(C,1),size(C,2)]=C "Solution of the Sylvester equation";
      output Real scale "Scale factor";
      output Integer info;
    protected
      Integer m=if tranA then size(A,1) else size(A, 2);
      Integer n=if tranB then size(B,1) else size(B, 2);
      String trana = if tranA then "T" else "N";
      String tranb = if tranB then "T" else "N";
      Integer lda = max(1,m);
      Integer ldb = max(1,n);

    external "Fortran 77" dtrsyl(trana, tranb, isgn, m, n, A, lda, B, ldb, X, lda, scale, info) annotation(Library = {"lapack"});

      annotation (Documentation(info="
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

    =====================================================================

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

   =====================================================================  "));
    end dtrsyl;

    function dhseqr
      "Compute eingenvalues of a matrix H using lapack routine DHSEQR for Hessenberg form matrix"
      input Real H[:,size(H, 1)] "Matrix H with Hessenberg form";
      input Boolean eigenValuesOnly=true
        "True to compute the eigenvalues. False to compute the Schur form too";
      input String compz="N" "Specifies the computation of the Schur vectors";
      input Real Z[:,:]=H "Matrix Z";
      output Real alphaReal[size(H, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      output Real alphaImag[size(H, 1)]
        "Imaginary part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      output Integer info;
      output Real Ho[:,:]=H
        "Schur decomposition (if eigenValuesOnly==false, unspecified else))";
      output Real Zo[:,:]=Z;
      output Real work[max({lwork, size(H, 1),1})];

    protected
      Integer n=size(H, 1);
      String job=if eigenValuesOnly then "E" else "S";
      Integer ilo=1;
      Integer ihi=n;
      Integer ldh=max(n, 1);
      Integer lwork=3*max(1, size(H, 1))
        "Dimension of the dwork array usd in dhseqr";

    external "Fortran 77" dhseqr(job, compz, n, ilo, ihi, Ho, ldh, alphaReal, alphaImag, Zo, ldh, work, lwork, info) annotation(Library = {"lapack"});

      annotation (Documentation(info="    DHSEQR computes the eigenvalues of a real upper Hessenberg matrix H
   and, optionally, the matrices T and Z from the Schur decomposition
   H = Z T Z**T, where T is an upper quasi-triangular matrix (the Schur
   form), and Z is the orthogonal matrix of Schur vectors.

   Optionally Z may be postmultiplied into an input orthogonal matrix Q,
   so that this routine can give the Schur factorization of a matrix A
   which has been reduced to the Hessenberg form H by the orthogonal
   matrix Q:  A = Q*H*Q**T = (QZ)*T*(QZ)**T.

   Arguments
   =========

   JOB     (input) CHARACTER*1
           = 'E':  compute eigenvalues only;
           = 'S':  compute eigenvalues and the Schur form T.

   COMPZ   (input) CHARACTER*1
           = 'N':  no Schur vectors are computed;
           = 'I':  Z is initialized to the unit matrix and the matrix Z
                   of Schur vectors of H is returned;
           = 'V':  Z must contain an orthogonal matrix Q on entry, and
                   the product Q*Z is returned.

   N       (input) INTEGER
           The order of the matrix H.  N >= 0.

   ILO     (input) INTEGER
   IHI     (input) INTEGER
           It is assumed that H is already upper triangular in rows
           and columns 1:ILO-1 and IHI+1:N. ILO and IHI are normally
           set by a previous call to DGEBAL, and then passed to SGEHRD
           when the matrix output by DGEBAL is reduced to Hessenberg
           form. Otherwise ILO and IHI should be set to 1 and N
           respectively.
           1 <= ILO <= IHI <= N, if N > 0; ILO=1 and IHI=0, if N=0.

   H       (input/output) DOUBLE PRECISION array, dimension (LDH,N)
           On entry, the upper Hessenberg matrix H.
           On exit, if JOB = 'S', H contains the upper quasi-triangular
           matrix T from the Schur decomposition (the Schur form);
           2-by-2 diagonal blocks (corresponding to complex conjugate
           pairs of eigenvalues) are returned in standard form, with
           H(i,i) = H(i+1,i+1) and H(i+1,i)*H(i,i+1) < 0. If JOB = 'E',
           the contents of H are unspecified on exit.

   LDH     (input) INTEGER
           The leading dimension of the array H. LDH >= max(1,N).

   WR      (output) DOUBLE PRECISION array, dimension (N)
   WI      (output) DOUBLE PRECISION array, dimension (N)
           The real and imaginary parts, respectively, of the computed
           eigenvalues. If two eigenvalues are computed as a complex
           conjugate pair, they are stored in consecutive elements of
           WR and WI, say the i-th and (i+1)th, with WI(i) > 0 and
           WI(i+1) < 0. If JOB = 'S', the eigenvalues are stored in the
           same order as on the diagonal of the Schur form returned in
           H, with WR(i) = H(i,i) and, if H(i:i+1,i:i+1) is a 2-by-2
           diagonal block, WI(i) = sqrt(H(i+1,i)*H(i,i+1)) and
           WI(i+1) = -WI(i).

   Z       (input/output) DOUBLE PRECISION array, dimension (LDZ,N)
           If COMPZ = 'N': Z is not referenced.
           If COMPZ = 'I': on entry, Z need not be set, and on exit, Z
           contains the orthogonal matrix Z of the Schur vectors of H.
           If COMPZ = 'V': on entry Z must contain an N-by-N matrix Q,
           which is assumed to be equal to the unit matrix except for
           the submatrix Z(ILO:IHI,ILO:IHI); on exit Z contains Q*Z.
           Normally Q is the orthogonal matrix generated by DORGHR after
           the call to DGEHRD which formed the Hessenberg matrix H.

   LDZ     (input) INTEGER
           The leading dimension of the array Z.
           LDZ >= max(1,N) if COMPZ = 'I' or 'V'; LDZ >= 1 otherwise.

   WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
           On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

   LWORK   (input) INTEGER
           The dimension of the array WORK.  LWORK >= max(1,N).

           If LWORK = -1, then a workspace query is assumed; the routine
           only calculates the optimal size of the WORK array, returns
           this value as the first entry of the WORK array, and no error
           message related to LWORK is issued by XERBLA.

   INFO    (output) INTEGER
           = 0:  successful exit
           < 0:  if INFO = -i, the i-th argument had an illegal value
           > 0:  if INFO = i, DHSEQR failed to compute all of the
                 eigenvalues in a total of 30*(IHI-ILO+1) iterations;
                 elements 1:ilo-1 and i+1:n of WR and WI contain those
                 eigenvalues which have been successfully computed.

   =====================================================================  "));
    end dhseqr;

    function dlange "Norm of a matrix"

      input Real A[:,:] "Real matrix A";
      input String norm="1" "specifies the norm, i.e., 1, I, F, M";
      output Real anorm "norm of A";
    protected
      Integer m=size(A, 1);
      Integer n=size(A,2);
      Integer lda=max(1,m);
      Real work[2*m];

    external "Fortran 77" dlange2(norm, m, n, A, lda, work, anorm)
      annotation (Include="
  #include<f2c.h>
  #include <stdio.h>

extern  doublereal dlange_(char *, integer *, integer *, doublereal *, integer *, doublereal *);

int dlange2_(char *norm, integer *m, integer *n, doublereal *a, integer *lda, doublereal *work, doublereal *anorm)
{
   FILE *fileptr;

   fileptr = fopen(\"test.txt\",\"w\");

  *anorm=dlange_(norm, m, n, a, lda, work);

fprintf(fileptr,\"anorm=%f \\n\",*anorm);

  fclose(fileptr);

  return 0;
}",     Library={"lapack"});
    annotation (   Documentation(info="

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

   =====================================================================
"));

    end dlange;

    function dgecon
      "Estimates the reciprocal of the condition number of a general real matrix A"

      input Real LU_of_A[:,:] "LU factroization of a real matrix A";
      input Boolean inf=false
        "Is true if infinity norm is used and false for 1-norm";
      input Real anorm "norm of A";
      output Real rcond "Reciprocal condition number of A";
      output Integer info;
    protected
      Integer n=size(LU_of_A, 2);
      Integer lda=max(1,size(LU_of_A,1));
      Real work[4*size(LU_of_A,2)];
      Integer iwork[size(LU_of_A,2)];
      String norm = if inf then "I" else "1";

    external "Fortran 77" dgecon(
        norm,
        n,
        LU_of_A,
        lda,
        anorm,
        rcond,
        work,
        iwork,
        info) annotation(Library = {"lapack"});

      annotation (Documentation(info="

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

    =====================================================================
"));
    end dgecon;

    function dgehrd
      "reduces a real general matrix A to upper Hessenberg form H by an orthogonal similarity transformation:  Q' * A * Q = H"

      input Real A[:,size(A, 2)];
      input Integer ilo=1
        "lowest index where the original matrix had been Hessenbergform";
      input Integer ihi=size(A, 1)
        "highest index where the original matrix had been Hessenbergform";
      output Real Aout[size(A, 1),size(A, 2)]=A
        "contains the Hessenberg form in the upper triangle and the first subdiagonal and below the first subdiagonal it contains the elementary reflectors which represents (with array tau) as a product the orthogonal matrix Q";
      output Real tau[max(size(A, 1),1) - 1]
        "scalar factors of the elementary reflectors";
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lda=max(1, n);
      Integer lwork=max(1, 3*n);
      Real work[lwork];

    external "Fortran 77" dgehrd(
        n,
        ilo,
        ihi,
        Aout,
        lda,
        tau,
        work,
        lwork,
        info) annotation(Library = {"lapack"});

      annotation (Documentation(info="
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

   =====================================================================
"));
    end dgehrd;

    function dgeqrf "computes a QR factorization without pivoting"

      input Real A[:,:] "Square or rectangular matrix";
      output Real Aout[size(A, 1),size(A, 2)]=A
        "the upper triangle of the array contains the upper trapezoidal matrix R; the elements below the diagonal, together with the array TAU, represent the orthogonal matrix Q as a product of elementary reflectors";
      output Real tau[min(size(A, 1), size(A, 2))]
        "scalar factors of the elementary reflectors";
      output Integer info;
      output Real work[3*max(1,size(A,2))];
    protected
      Integer m=size(A, 1);
      Integer n=size(A, 2);
      Integer lda=max(1, m);
      Integer lwork=3*max(1,n);

    external "Fortran 77" dgeqrf(m, n, Aout, lda,  tau, work,  lwork,  info) annotation(Library = {"lapack"});

      annotation (Documentation(info="
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

   WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
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

   =====================================================================  "));
    end dgeqrf;

    function dgeevx
      "Compute the eigenvalues and the (real) left and right eigenvectors of matrix A, using lapack routine dgeevx "

      input Real A[:,size(A, 1)];
      output Real alphaReal[size(A, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      output Real alphaImag[size(A, 1)]
        "Imaginary part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      output Real lEigenVectors[size(A, 1),size(A, 1)]
        "left eigenvectors of matrix A";
      output Real rEigenVectors[size(A, 1),size(A, 1)]
        "right eigenvectors of matrix A";
      output Real AS[size(A, 1),size(A, 2)]=A
        "AS iss the real Schur form of the balanced version of the input matrix A";
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer ilo;
      Integer ihi;
      Real scale[n];
      Real abnrm;
      Real rconde[n];
      Real rcondv[n];
      Integer lwork=n*(n + 6);
      Real work[lwork];

    external "Fortran 77" dgeevx(
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
        info) annotation(Library = {"lapack"});

      annotation (Documentation(info="   Purpose
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
           = 'S': Diagonally scale the matrix, i.e., replace A by
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

   ILO,IHI (output) INTEGER
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

   WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
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

   =====================================================================
"));
    end dgeevx;

    function dgesdd "Determine singular value decomposition"
      extends Modelica.Icons.Function;
      input Real A[:,:];
      output Real sigma[min(size(A, 1), size(A, 2))];
      output Real U[size(A, 1),size(A, 1)]=zeros(size(A, 1), size(A, 1));
      output Real VT[size(A, 2),size(A, 2)]=zeros(size(A, 2), size(A, 2));
      output Integer info;
    protected
      Real Awork[size(A, 1),size(A, 2)]=A;
      Integer lda=max(1, size(A, 1));
      Integer ldu=max(1, size(A, 1));
      Integer ldvt=max(1, size(A, 2));
      Integer lwork=max(1,3*(3*min(size(A, 1),size(A, 2))*min(size(A, 1),size(A, 2)) + max(max(size(A, 1),size(A, 2)),4*min(size(A, 1),size(A, 2))*min(size(A, 1),size(A, 2))+4*min(size(A, 1),size(A, 2)))));
      Integer iwork=max(1,8*min(size(A, 1),size(A, 2)));
      Real work[lwork];

    external "Fortran 77" dgesdd(
        "A",
        size(A, 1),
        size(A, 2),
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
        info)
        annotation (Library="lapack");
      annotation (Documentation(info="   Purpose
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
                   in the array VT;
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

   WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
           On exit, if INFO = 0, WORK(1) returns the optimal LWORK;

   LWORK   (input) INTEGER
           The dimension of the array WORK. LWORK >= 1.
           If JOBZ = 'N',
             LWORK >= 3*min(M,N) + max(max(M,N),6*min(M,N)).
           If JOBZ = 'O',
             LWORK >= 3*min(M,N)*min(M,N) +
                      max(max(M,N),5*min(M,N)*min(M,N)+4*min(M,N)).
           If JOBZ = 'S' or 'A'
             LWORK >= 3*min(M,N)*min(M,N) +
                      max(max(M,N),4*min(M,N)*min(M,N)+4*min(M,N)).
           For good performance, LWORK should generally be larger.
           If LWORK < 0 but other input arguments are legal, WORK(1)
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

   =====================================================================  "));
    end dgesdd;

    function dggev "Compute generalized eigenvalues for a (A,B) system"

      input Real A[:,size(A, 1)];
      input Real B[size(A, 1),size(A, 1)];
      input Integer nA=size(A,1);
      output Real alphaReal[size(A, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag)/beta)";
      output Real alphaImag[size(A, 1)] "Imaginary part of alpha";
      output Real beta[size(A, 1)] "Denominator of eigenvalue";
      output Real lEigenVectors[size(A, 1),size(A, 1)]
        "left eigenvectors of matrix A";
      output Real rEigenVectors[size(A, 1),size(A, 1)]
        "right eigenvectors of matrix A";

      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lwork=max(1,8*n);
      Real Awork[n,n]=A;
      Real Bwork[n,n]=B;
      Real work[lwork];
      Integer lda=max(1,n);

    external "Fortran 77" dggev(
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
        info)         annotation(Library = {"lapack"});
      annotation (Documentation(info="   Purpose
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
           Each eigenvector will be scaled so the largest component have
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
           Each eigenvector will be scaled so the largest component have
           abs(real part)+abs(imag. part)=1.
           Not referenced if JOBVR = 'N'.

   LDVR    (input) INTEGER
           The leading dimension of the matrix VR. LDVR >= 1, and
           if JOBVR = 'V', LDVR >= N.

   WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
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

   =====================================================================
"));
    end dggev;

    function dggevx
      "Compute generalized eigenvalues for a (A,B) system, using lapack routine dggevx"

      input Real A[:,size(A, 1)];
      input Real B[size(A, 1),size(A, 1)];
      output Real alphaReal[size(A, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag)/beta)";
      output Real alphaImag[size(A, 1)] "Imaginary part of alpha";
      output Real beta[size(A, 1)] "Denominator of eigenvalue";
      output Real lEigenVectors[size(A, 1),size(A, 1)]
        "left eigenvectors of matrix A";
      output Real rEigenVectors[size(A, 1),size(A, 1)]
        "right eigenvectors of matrix A";

      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lda=max(1,size(A, 1));
      Integer ilo;
      Integer ihi;
      Real lscale[n];
      Real rscale[n];
      Real abnrm;
      Real bbnrm;
      Real rconde[n];
      Real rcondv[n];
      Integer lwork=2*n*n + 12*n + 16;
      Real work[lwork];
      Integer iwork[n + 6];
      Integer bwork[n];

    external "Fortran 77" dggevx(
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
        info)  annotation(Library = {"lapack"});
      annotation (Documentation(info="/*  Purpose
/*  =======

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

   ILO,IHI (output) INTEGER
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
           the selected eigenvalues, stored in consecutive elements of
           the array. For a complex conjugate pair of eigenvalues two
           consecutive elements of RCONDE are set to the same value.
           Thus RCONDE(j), RCONDV(j), and the j-th columns of VL and VR
           all correspond to the same eigenpair (but not in general the
           j-th eigenpair, unless all eigenpairs are selected).
           If SENSE = 'V', RCONDE is not referenced.

   RCONDV  (output) DOUBLE PRECISION array, dimension (N)
           If SENSE = 'V' or 'B', the estimated reciprocal condition
           numbers of the selected eigenvectors, stored in consecutive
           elements of the array. For a complex eigenvector two
           consecutive elements of RCONDV are set to the same value. If
           the eigenvalues cannot be reordered to compute RCONDV(j),
           RCONDV(j) is set to 0; this can only occur when the true
           value would be very small anyway.
           If SENSE = 'E', RCONDV is not referenced.

   WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
           On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

   LWORK   (input) INTEGER
           The dimension of the array WORK. LWORK >= max(1,6*N).
           If SENSE = 'E', LWORK >= 12*N.
           If SENSE = 'V' or 'B', LWORK >= 2*N*N+12*N+16.

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

   =====================================================================
"));
    end dggevx;

    function dhgeqz "Compute generalized eigenvalues for a (A,B) system"

      input Real A[:,size(A, 1)];
      input Real B[size(A, 1),size(A, 1)];
      output Real alphaReal[size(A, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag)/beta)";
      output Real alphaImag[size(A, 1)] "Imaginary part of alpha";
      output Real beta[size(A, 1)] "Denominator of eigenvalue";

      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer ilo=1;
      Integer ihi=n;
      Integer lwork=max(1,3*n);
      Real work[lwork];
      Real Awork[n,n]=A;
      Real Bwork[n,n]=B;
      Integer lda=max(1, n);
      Real Q[1,1]=fill(0, 1, n);

    external "Fortran 77" dhgeqz(
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
        info)         annotation(Library = {"lapack"});

      annotation (Documentation(info="
     Purpose
   =======

   DHGEQZ implements a single-/double-shift version of the QZ method for
   finding the generalized eigenvalues

   w(j)=(ALPHAR(j) + i*ALPHAI(j))/BETAR(j)   of the equation

        det( A - w(i) B ) = 0

   In addition, the pair A,B may be reduced to generalized Schur form:
   B is upper triangular, and A is block upper triangular, where the
   diagonal blocks are either 1-by-1 or 2-by-2, the 2-by-2 blocks having
   complex generalized eigenvalues (see the description of the argument
   JOB.)

   If JOB='S', then the pair (A,B) is simultaneously reduced to Schur
   form by applying one orthogonal tranformation (usually called Q) on
   the left and another (usually called Z) on the right.  The 2-by-2
   upper-triangular diagonal blocks of B corresponding to 2-by-2 blocks
   of A will be reduced to positive diagonal matrices.  (I.e.,
   if A(j+1,j) is non-zero, then B(j+1,j)=B(j,j+1)=0 and B(j,j) and
   B(j+1,j+1) will be positive.)

   If JOB='E', then at each iteration, the same transformations
   are computed, but they are only applied to those parts of A and B
   which are needed to compute ALPHAR, ALPHAI, and BETAR.

   If JOB='S' and COMPQ and COMPZ are 'V' or 'I', then the orthogonal
   transformations used to reduce (A,B) are accumulated into the arrays
   Q and Z s.t.:

        Q(in) A(in) Z(in)* = Q(out) A(out) Z(out)*
        Q(in) B(in) Z(in)* = Q(out) B(out) Z(out)*

   Ref: C.B. Moler & G.W. Stewart, \"An Algorithm for Generalized Matrix
        Eigenvalue Problems\", SIAM J. Numer. Anal., 10(1973),
        pp. 241--256.

   Arguments
   =========

   JOB     (input) CHARACTER*1
           = 'E': compute only ALPHAR, ALPHAI, and BETA.  A and B will
                  not necessarily be put into generalized Schur form.
           = 'S': put A and B into generalized Schur form, as well
                  as computing ALPHAR, ALPHAI, and BETA.

   COMPQ   (input) CHARACTER*1
           = 'N': do not modify Q.
           = 'V': multiply the array Q on the right by the transpose of
                  the orthogonal tranformation that is applied to the
                  left side of A and B to reduce them to Schur form.
           = 'I': like COMPQ='V', except that Q will be initialized to
                  the identity first.

   COMPZ   (input) CHARACTER*1
           = 'N': do not modify Z.
           = 'V': multiply the array Z on the right by the orthogonal
                  tranformation that is applied to the right side of
                  A and B to reduce them to Schur form.
           = 'I': like COMPZ='V', except that Z will be initialized to
                  the identity first.

   N       (input) INTEGER
           The order of the matrices A, B, Q, and Z.  N >= 0.

   ILO     (input) INTEGER
   IHI     (input) INTEGER
           It is assumed that A is already upper triangular in rows and
           columns 1:ILO-1 and IHI+1:N.
           1 <= ILO <= IHI <= N, if N > 0; ILO=1 and IHI=0, if N=0.

   A       (input/output) DOUBLE PRECISION array, dimension (LDA, N)
           On entry, the N-by-N upper Hessenberg matrix A.  Elements
           below the subdiagonal must be zero.
           If JOB='S', then on exit A and B will have been
              simultaneously reduced to generalized Schur form.
           If JOB='E', then on exit A will have been destroyed.
              The diagonal blocks will be correct, but the off-diagonal
              portion will be meaningless.

   LDA     (input) INTEGER
           The leading dimension of the array A.  LDA >= max( 1, N ).

   B       (input/output) DOUBLE PRECISION array, dimension (LDB, N)
           On entry, the N-by-N upper triangular matrix B.  Elements
           below the diagonal must be zero.  2-by-2 blocks in B
           corresponding to 2-by-2 blocks in A will be reduced to
           positive diagonal form.  (I.e., if A(j+1,j) is non-zero,
           then B(j+1,j)=B(j,j+1)=0 and B(j,j) and B(j+1,j+1) will be
           positive.)
           If JOB='S', then on exit A and B will have been
              simultaneously reduced to Schur form.
           If JOB='E', then on exit B will have been destroyed.
              Elements corresponding to diagonal blocks of A will be
              correct, but the off-diagonal portion will be meaningless.

   LDB     (input) INTEGER
           The leading dimension of the array B.  LDB >= max( 1, N ).

   ALPHAR  (output) DOUBLE PRECISION array, dimension (N)
           ALPHAR(1:N) will be set to real parts of the diagonal
           elements of A that would result from reducing A and B to
           Schur form and then further reducing them both to triangular
           form using unitary transformations s.t. the diagonal of B
           was non-negative real.  Thus, if A(j,j) is in a 1-by-1 block
           (i.e., A(j+1,j)=A(j,j+1)=0), then ALPHAR(j)=A(j,j).
           Note that the (real or complex) values
           (ALPHAR(j) + i*ALPHAI(j))/BETA(j), j=1,...,N, are the
           generalized eigenvalues of the matrix pencil A - wB.

   ALPHAI  (output) DOUBLE PRECISION array, dimension (N)
           ALPHAI(1:N) will be set to imaginary parts of the diagonal
           elements of A that would result from reducing A and B to
           Schur form and then further reducing them both to triangular
           form using unitary transformations s.t. the diagonal of B
           was non-negative real.  Thus, if A(j,j) is in a 1-by-1 block
           (i.e., A(j+1,j)=A(j,j+1)=0), then ALPHAR(j)=0.
           Note that the (real or complex) values
           (ALPHAR(j) + i*ALPHAI(j))/BETA(j), j=1,...,N, are the
           generalized eigenvalues of the matrix pencil A - wB.

   BETA    (output) DOUBLE PRECISION array, dimension (N)
           BETA(1:N) will be set to the (real) diagonal elements of B
           that would result from reducing A and B to Schur form and
           then further reducing them both to triangular form using
           unitary transformations s.t. the diagonal of B was
           non-negative real.  Thus, if A(j,j) is in a 1-by-1 block
           (i.e., A(j+1,j)=A(j,j+1)=0), then BETA(j)=B(j,j).
           Note that the (real or complex) values
           (ALPHAR(j) + i*ALPHAI(j))/BETA(j), j=1,...,N, are the
           generalized eigenvalues of the matrix pencil A - wB.
           (Note that BETA(1:N) will always be non-negative, and no
           BETAI is necessary.)

   Q       (input/output) DOUBLE PRECISION array, dimension (LDQ, N)
           If COMPQ='N', then Q will not be referenced.
           If COMPQ='V' or 'I', then the transpose of the orthogonal
              transformations which are applied to A and B on the left
              will be applied to the array Q on the right.

   LDQ     (input) INTEGER
           The leading dimension of the array Q.  LDQ >= 1.
           If COMPQ='V' or 'I', then LDQ >= N.

   Z       (input/output) DOUBLE PRECISION array, dimension (LDZ, N)
           If COMPZ='N', then Z will not be referenced.
           If COMPZ='V' or 'I', then the orthogonal transformations
              which are applied to A and B on the right will be applied
              to the array Z on the right.

   LDZ     (input) INTEGER
           The leading dimension of the array Z.  LDZ >= 1.
           If COMPZ='V' or 'I', then LDZ >= N.

   WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
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
           = 1,...,N: the QZ iteration did not converge.  (A,B) is not
                      in Schur form, but ALPHAR(i), ALPHAI(i), and
                      BETA(i), i=INFO+1,...,N should be correct.
           = N+1,...,2*N: the shift calculation failed.  (A,B) is not
                      in Schur form, but ALPHAR(i), ALPHAI(i), and
                      BETA(i), i=INFO-N+1,...,N should be correct.
           > 2*N:     various \"impossible\" errors.

   Further Details
   ===============

   Iteration counters:

   JITER  -- counts iterations.
   IITER  -- counts iterations run since ILAST was last
             changed.  This is therefore reset only when a 1-by-1 or
             2-by-2 block deflates off the bottom.

   =====================================================================
"));
    end dhgeqz;

    function dormhr
      "overwrites the general real M-by-N matrix C with Q * C or C * Q or Q' * C or C * Q', where Q is an orthogonal matrix as returne by dgehrd"

      input Real C[:,:];
      input Real A[:,:];
      input Real tau[if side=="L" then size(C, 2) - 1 else size(C,1)-1];
      input String side="L";
      input String trans="N";
      input Integer ilo=1
        "lowest index where the original matrix had been Hessenbergform";
      input Integer ihi=if side=="L" then size(C,1) else size(C,2)
        "highest index where the original matrix had been Hessenbergform";
      output Real Cout[size(C, 1),size(C, 2)]=C
        "contains the Hessenberg form in the upper triangle and the first subdiagonal and below the first subdiagonal it contains the elementary reflectors which represents (with array tau) as a product the orthogonal matrix Q";

      output Integer info;
    protected
      Integer m=size(C, 1);
      Integer n=size(C, 2);
      Integer lda=max(1, size(A, 2));
      Integer ldc=max(1, m);
      Integer lwork=max(1,2*size(A, 2));
      Real work[lwork];

    external "Fortran 77" dormhr(
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
        info) annotation(Library = {"lapack"});

      annotation (Documentation(info="
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

   WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
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

   =====================================================================  "));
    end dormhr;

    function dormqr
      "overwrites the general real M-by-N matrix C with Q * C or C * Q or Q' * C or C * Q', where Q is an orthogonal matrix of a QR factorization as returned by dgeqrf"

      input Real C[:,:];
      input Real A[:,:];
      input Real tau[:];
      input String side="L";
      input String trans="N";

      output Real Cout[size(C, 1),size(C, 2)]=C
        "contains Q*C or Q**T*C or C*Q**T or C*Q";

      output Integer info;
    protected
      Integer m=size(C, 1);
      Integer n=size(C, 2);
      Integer k=if side == "L" then m else n;
      Integer lda=if side == "L" then max(1, m) else max(1, n);
      Integer ldc=max(1, m);
      Integer lwork=if side == "L" then max(1, n) else max(1, m);
      Real work[lwork];

    external "Fortran 77" dormqr(
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
        info) annotation(Library = {"lapack"});

      annotation (Documentation(info="   Purpose
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

   WORK    (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
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

   =====================================================================  "));
    end dormqr;

    function dtrevc
      "Compute the right and/or left eigenvectors of a real upper quasi-triangular matrix T"
      input Real T[:,size(T, 1)] "Upper quasie triangular matrix";
      input String side="R" "Specify which eigenvectors";
      input String howmny="B" "Specify how many eigenvectors";
      input Real Q[size(T, 1),size(T, 1)]
        "Orthogonal matrix Q of Schur vectors returned by DHSEQR";

      output Real lEigenVectors[size(T, 1),size(T, 1)]=Q
        "left eigenvectors of matrix T";
      output Real rEigenVectors[size(T, 1),size(T, 1)]=Q
        "right eigenvectors of matrix T";
      output Integer info;

    protected
      Integer n=size(T, 1);
      Boolean select[n];
      Integer ldt=max(1, n);
      Integer ldvl=max(1, n);
      Integer ldvr=max(1, n);
      Real work[3*n];

    external "Fortran 77" dtrevc(
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
        info) annotation(Library = {"lapack"});

      annotation (Documentation(info="    /*  DTREVC computes some or all of the right and/or left eigenvectors of
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
 substitution, with scaling to make the the code robust against
 possible overflow.

 Each eigenvector is normalized so that the element of largest
 magnitude has magnitude 1; here the magnitude of a complex number
 (x,y) is taken to be |x| + |y|.

   =====================================================================  "));
    end dtrevc;

    function dpotrf
      "Computes the Cholesky factorization of a real symmetric positive definite matrix A"

      extends Modelica.Icons.Function;
      input Real A[:, size(A,1)] "Real symmetric positive definite matrix A";
      input Boolean upper=true "True if the upper triangle of A is provided";

      output Real Acholesky[size(A,1),size(A,1)]=A "Cholesky factor";
      output Integer info;
    protected
      String uplo=if upper then "U" else "L";
      Integer n=size(A,1);
      Integer lda=max(1,n);
      external "FORTRAN 77" dpotrf(uplo, n, Acholesky, lda, info) annotation (Library="Lapack");

      annotation (
        Documentation(info="Lapack documentation
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
                  completed."));

    end dpotrf;

    function dtrsm
      "Solve one of the matrix equations  op( A )*X = alpha*B,   or   X*op( A ) = alpha*B, where A is triangular matrix. BLAS routine"

      input Real A[:,:] "Input matrix A";
      input Real B[:,:] "Input matrix B";
      input Real alpha=1 "Factor alpha";
      input Boolean right=true "True if A is right multiplication";
      input Boolean upper=true "True if A is upper triangular";
      input Boolean trans=false "True if op(A) means transposed(A)";
      input Boolean unitTriangular=false
        "True if A is unit triangular, i.e., all diagonal elements of A are equal to 1";

      output Real X[size(B,1),size(B,2)]=B
        "Matrix Bout=alpha*op( A )*B,   or   B := alpha*B*op( A )";
    protected
      String side=if right then "R" else "L";
      String uplo=if upper then "U" else "L";
      String transA=if trans then "T" else "N";
      String diag=if unitTriangular then "U" else "N";
      Integer m=size(B, 1) "Number of rows of B";
      Integer n=size(B, 2) "Number of columns of B";
      Integer lda=if right then max(1,n) else max(1,m) "First dimension of A";
      Integer ldb=max(1,m) "First dimension of B";

    external "Fortran 77" dtrsm(side, uplo, transA, diag, m, n, alpha, A, lda, X, ldb) annotation(Library = {"lapack"});

      annotation (Documentation(info="

   Purpose
    =======
    DTRSM  solves one of the matrix equations
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
    Level 3 Blas routine.   "));
    end dtrsm;

    function dorghr
      "Generates a real orthogonal matrix Q which is defined as the product of IHI-ILO elementary reflectors of order N, as returned by DGEHRD"

      input Real A[:,size(A, 1)] "Square matrix with the elementary reflectors";
      input Integer ilo=1
        "lowest index where the original matrix had been Hessenbergform - ilo must have the same value as in the previous call of DGEHRD";
      input Integer ihi=size(A, 1)
        "highest index where the original matrix had been Hessenbergform  - ihi must have the same value as in the previous call of DGEHRD";
      input Real tau[max(0,size(A, 1) - 1)]
        "scalar factors of the elementary reflectors";
      output Real Aout[size(A, 1),size(A, 2)]=A
        "Orthogonal matrix as a result of elementary reflectors";
      output Integer info;
    protected
      Integer n=size(A, 1);
      Integer lda=max(1, n);
      Integer lwork=max(1, 3*n);
      Real work[lwork];

    external "Fortran 77" dorghr(
        n,
        ilo,
        ihi,
        Aout,
        lda,
        tau,
        work,
        lwork,
        info) annotation(Library = {"lapack"});

      annotation (Documentation(info="

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

    =====================================================================
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
    extends Modelica.Icons.Package;

    function continuousRiccatiIterative
      "Newton's method with exact line search for iterative solving continuous algebraic Riccati equation"
      extends Modelica.Icons.Function;

      import Modelica.Math.Matrices;

      input Real A[:,size(A, 1)]
        "Matrix A of Riccati equation X*A + A'*X -X*G*X +Q = 0";
      input Real B[size(A, 1),:] "Matrix B in G = B*inv(R)*B'";
      input Real R[size(B, 2),size(B, 2)]=identity(size(B, 2))
        "Matrix R in G = B*inv(R)*B'";
      input Real Q[size(A, 1),size(A, 2)]=identity(size(A, 1))
        "Matrix Q of Riccati equation X*A + A'*X -X*G*X +Q = 0";
      input Real X0[size(A, 1),size(A, 2)]=identity(size(A, 1))
        "Initial approximate solution for X*A + A'*X -X*G*X +Q = 0";
      input Integer maxSteps=10 "Maximal number of iteration steps";
      input Real eps=Matrices.frobeniusNorm(A)*1e-9
        "Tolerance for stop criterion";

      output Real X[size(X0, 1),size(X0, 2)]
        "Solution X of Riccati equation X*A + A'*X -X*G*X +Q = 0";
      output Real r "Norm of X*A + A'*X - X*G*X + Q, zero for exact solution";

    protected
      Integer n=size(A, 1);
      Real G[size(A, 1),size(A, 2)]=B*Matrices.solve2(R, transpose(B));
      Real Xk[size(X, 1),size(X, 2)];
      Real Ak[size(A, 1),size(A, 2)];
      Real Rk[size(A, 1),size(A, 2)];
      Real Nk[size(A, 1),size(A, 2)];
      Real Vk[size(A, 1),size(A, 2)];
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
          stop := eps > Matrices.frobeniusNorm(tk*Nk)/Matrices.frobeniusNorm(Xk) or k>=maxSteps;
          Xk := Xk + tk*Nk;
        end while;
        X := Xk;
        r := Matrices.frobeniusNorm(X*A + transpose(A)*X - X*G*X + Q);

      elseif n == 1 then // exact calculation
        X := matrix((A[1, 1] - sqrt(A[1, 1]*A[1, 1] + G[1, 1]*Q[1, 1]))/G[1, 1]);
        if X[1, 1]*G[1, 1] < A[1, 1] then
          X := matrix((A[1, 1] + sqrt(A[1, 1]*A[1, 1] + G[1, 1]*Q[1, 1]))/G[1, 1]);
        end if;
        r := 0;
      else
        X := fill(0, 0, 0);
        r := 0;
      end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
           X = Matrices.Utilities.<b>continuousRiccatiIterative</b>(A, B, R, Q, X0);
      (X, r) = Matrices.Utilities.<b>continuousRiccatiIterative</b>(A, B, R, Q, X0, maxSteps, eps);
</pre></blockquote>
<h4>Description</h4>
<p>
This function provides a Newton-like method for solving continuous algebraic Riccati equations (care). It utilizes Exact Line Search to improve the sometimes erratic
convergence of Newton's method. Exact line search in this case means means, that at each iteration <code>i</code> a Newton step <tt><b>delta</b>_i</tt>
</p>
<blockquote><pre>
  <b>X</b>_i+1 = <b>X</b>_i + <b>delta</b>_i
</pre></blockquote>
<p>
is taken in the direction to minimize the Frobenius norm of the residual
</p>
<blockquote><pre>
    r = || <b>X</b>_i+1*<b>A</b> +<b>A</b>'*<b>X</b>_i+1 - <b>X</b>_i+1*<b>G</b>*<b>X</b>_i+1 + <b>Q</b> ||.
</pre></blockquote>
<p>
with
</p>
<blockquote><pre>
        -1
  G = <b>B</b>*<b>R</b> *<b>B</b>'
</pre></blockquote>
<p>

The inputs \"maxSteps\" and \"eps\" specify the termination of the iteration. The iteration is terminated if either
maxSteps iteration steps have been performed or the relative change <b>delta</b>_i/<b>X</b>_i became smaller than eps.
<p>

With an appropriate initial value <b>X</b>0 a sufficiently accurate solution might be reach within a few iteration steps. Although a Lyapunov equation
of order <code>n</code> (n is the order of the Riccati equation) is to be solved at each iteration step, the algorithm might be faster
than a direct method like <a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">Matrices.continuousRiccati</a>, since direct methods have to solve the 2*n-order Hamiltonian
system equation.<br>

The algorithm is taken from [1] and [2].

<h4>References</h4>
<PRE>
  [1] Benner, P., Byers, R.
      An Exact Line Search Method for Solving Generalized Continuous-Time Algebraic Riccati Equations
      IEEE Transactions On Automatic Control, Vol. 43, No. 1, pp. 101-107, 1998.
  [2] Datta, B.N.
      Numerical Methods for Linear Control Systems
      Elsevier Academic Press, 2004.
</PRE>

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

  //  X = [1.3239,  0.9015,  0.5466, -1.7672;
           0.9015,  0.9607,  0.4334, -1.1989;
           0.5466,  0.4334,  0.4605, -1.3633;
          -1.7672, -1.1989, -1.3633,  4.4612]
  // r =  2.48809423389491E-015

    (,r) = Matrices.Utilities.continuousRiccatiIterative(A, B, R, Q, X0,4);

   // r =  0.0004;

<br>
</pre></blockquote>
<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.discreteRiccatiIterative\">Matrices.Utilities.discreteRiccatiIterative</a><br>
<a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">Matrices.continuousRiccati</a>
</html>", revisions="<html>
<ul>
<li><i>2010/04/30 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end continuousRiccatiIterative;

    function discreteRiccatiIterative
      "Newton's method with exact line search for solving discrete algebraic Riccati equation"
      extends Modelica.Icons.Function;

      import Modelica.Math.Matrices;

      input Real A[:,size(A, 1)] "Matrix A of discrete Riccati equation";
      input Real B[size(A, 1),:] "Matrix B of discrete Riccati equation";
      input Real R[size(B, 2),size(B, 2)]=identity(size(B, 2))
        "Matrix R of discrete Riccati equation";
      input Real Q[size(A, 1),size(A, 2)]=identity(size(A, 1))
        "Matrix Q of discrete Riccati equation";
      input Real X0[size(A, 1),size(A, 2)]=identity(size(A,1))
        "Initial approximate solution discrete Riccati equation";
      input Integer maxSteps=10 "Maximal number of iteration steps";
      input Real eps=Matrices.frobeniusNorm(A)*1e-9
        "Tolerance for stop criterion";

      output Real X[size(X0, 1),size(X0, 2)];
      output Real r;

    protected
      Integer n=size(A, 1);
      Real Xk[size(X, 1),size(X, 2)];
      Real Ak[size(A, 1),size(A, 2)];
      Real Rk[size(A, 1),size(A, 2)];
      Real Nk[size(A, 1),size(A, 2)];
      Real Hk[size(B, 2),size(B, 1)];
      Real Vk[size(A, 1),size(A, 2)];
      Real AT[size(A, 2),size(A, 2)]=transpose(A);
      Real BT[size(B, 2),size(B, 1)]=transpose(B);
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
          Ak := A-B*Hk*Xk*A;
          Rk := AT*Xk*A - Xk + Q - AT*Xk*B*Hk*Xk*A;
          Nk := Modelica.Math.Matrices.discreteLyapunov(A=Ak, C=-Rk,sgn=-1);
          Vk :=transpose(Ak)*Nk*B*Hk*Nk*Ak;
          tk := Modelica.Math.Matrices.Utilities.findLocal_tk(Rk, Vk);
          stop := eps > Matrices.frobeniusNorm(tk*Nk)/Matrices.frobeniusNorm(Xk) or k>=maxSteps;
          Xk := Xk + tk*Nk;
        end while;
        X := Xk;
        r := Matrices.frobeniusNorm(AT*X*A - X + Q - AT*X*B*Matrices.solve2(R + BT*X*B, BT)*X*A);
      else
        X := fill(0, 0, 0);
        r := 0;
      end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
           X = Matrices.Utilities.<b>discreteRiccatiIterative</b>(A, B, R, Q, X0);
      (X, r) = Matrices.Utilities.<b>discreteRiccatiIterative</b>(A, B, R, Q, X0, maxSteps, eps);
</pre></blockquote>
<h4>Description</h4>
<p>
This function provides a Newton-like method for solving discrete-time algebraic Riccati equations. It uses Exact Line Search to improve the sometimes erratic
convergence of Newton's method. Exact line search in this case means means, that at each iteration <code>i</code> a Newton step <tt><b>delta</b>_i</tt>
</p>
<blockquote><pre>
  <b>X</b>_i+1 = <b>X</b>_i + <b>delta</b>_i
</pre></blockquote>
<p>
is taken in the direction to minimize the Frobenius norm of the residual
</p>
<blockquote><pre>
  r = || <b>A</b>'<b>X</b>_i+1*<b>A</b> - <b>X</b>_i+1 - <b>A</b>'<b>X</b>_i+1*<b>G</b>_i*<b>X</b>_i+1*<b>A</b> + <b>Q</b> ||
</pre></blockquote>
<p>
with
</p>
<blockquote><pre>
                       -1
  G_i = <b>B</b>*(<b>R</b> + <b>B</b>'*<b>X</b>_i*<b>B</b>) *<b>B</b>'
</pre></blockquote>
<p>

Output <code>r</code> is the norm of the residual of the last iteration.<br>
<p>
The inputs \"maxSteps\" and \"eps\" specify the termination of the iteration. The iteration is terminated if either
maxSteps iteration steps have been performed or the relative change <b>delta</b>_i/<b>X</b>_i became smaller than eps.
<p>

With an appropriate initial value <b>X</b>0 a sufficiently accurate solution might be reach with a few iteration steps. Although a Lyapunov equation of
order <code>n</code> (n is the order of the Riccati equation) is to be solved at each iteration step, the algorithm might be faster
than a direct method like <a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">Matrices.discreteRiccati</a>, since direct methods have to solve the 2*n-order Hamiltonian
system equation.

The algorithm is taken from [1] and [2].

<h4>References</h4>
<PRE>
  [1] Benner, P., Byers, R.
      An Exact Line Search Method for Solving Generalized Continuous-Time Algebraic Riccati Equations
      IEEE Transactions On Automatic Control, Vol. 43, No. 1, pp. 101-107, 1998.
  [2] Datta, B.N.
      Numerical Methods for Linear Control Systems
      Elsevier Academic Press, 2004.
</PRE>

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
<li><i>2010/04/30 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end discreteRiccatiIterative;

    function householderReflection
      "Reflect each of the vectors a_i of matrix  A=[a_1, a_2, ..., a_n] on a plane with orthogonal vector u"
      import Modelica.Math.Vectors;

      input Real A[:,:] "Rectangular matrix";
      input Real u[size(A, 1)] "Householder vector";

      output Real RA[size(A, 1),size(A, 2)] "Reflexion of A";

    protected
      Integer n=size(A, 2);
      Real h;
      Real lu=(Vectors.length(u))^2;

    algorithm
      for i in 1:n loop
        h := scalar(2*transpose(matrix(u))*A[:, i]/lu);
        RA[:, i] := A[:, i] - h*u;
      end for;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>householderReflection</b>(A,u);
</pre></blockquote>
<h4>Description</h4>
<p>
This function computes the Householder reflection (transformation)
</p>
<blockquote>
 <b>Ar</b> = <b>Q</b>*<b>A</b>
</blockquote>
with
<blockquote>
 <b>Q</b> = <b>I</b> -2*<b>u</b>*<b>u</b>'/(<b>u</b>'*<b>u</b>)
</blockquote>
<p>
where <b>u</b> is Householder vector, i.e., the normal vector of the reflection plane.
<p>
Householder reflection is widely used in numerical linear algebra, e.g., to perform QR decompositions.
</p>
<h4>Example</h4>
<blockquote><pre>
// First step of QR decomposition
  import   Modelica.Math.Vectors.Utilities;

  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real Ar[3,3];
  Real u[:];

  u=Utilities.householderVector(A[:,1],{1,0,0});
  // u= {0.763, 0.646, 0}

  Ar=householderReflexion(A,u);
 // Ar = [-6.0828,   -5.2608,   -4.4388;
 //        0.0,      -1.1508,   -2.3016;
 //        0.0,       2.0,       0.0]

</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.householderSimilarityTransformation\">Matrices.Utilities.housholderSimilarityTransformation</a>,<br>
<a href=\"modelica://Modelica.Math.Vectors.Utilities.householderReflection\">Vectors.Utilities.householderReflection</a>,<br>
<a href=\"modelica://Modelica.Math.Vectors.Utilities.householderVector\">Vectors.Utilities.householderVector</a>
</p>
</html>", revisions="<html>
<ul>
<li><i>2010/04/30 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end householderReflection;

    function householderSimilarityTransformation
      "Perform the similarity transformation S*A*S of matrix A with symmetric householder matrix S = I - 2u*u'"

      import Modelica;
      import Modelica.Math.Vectors;

      input Real A[:,size(A, 1)] "Square matrix A";
      input Real u[size(A, 1)] "Householder vector";
      output Real SAS[size(A, 1),size(A, 1)] "Transformation of matrix A";

    protected
      Integer na=size(A, 1);
      Real S[:,:]=-2*matrix(u)*transpose(matrix(u))/(Vectors.length(u)*Vectors.length(u))
        "Symmetric matrix";
      Integer i;
    algorithm
      for i in 1:na loop
        S[i, i] := 1.0 + S[i, i];
      end for;
      SAS := S*A*S;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
  As = Matrices.<b>householderSimilarityTransformation</b>(A,u);
</pre></blockquote>
<h4>Description</h4>
<p>
This function computes the Housholder similarity transformation
</p>
<blockquote>
 <b>As</b> = <b>S</b>*<b>A</b>*<b>S</b>
</blockquote>
with
<blockquote>
 <b>S</b> = <b>I</b> -2*<b>u</b>*<b>u</b>'/(<b>u</b>'*<b>u</b>).
</blockquote>
<p>
This transformation is widely used for transforming non-symmetric matrices to a Hessenberg form.
</p>
<h4>Example</h4>
<blockquote><pre>
// First step of Hessenberg decomposition
  import   Modelica.Math.Vectors.Utilities;

  Real A[4,4] = [1,2,3,4;
                 3,4,5,6;
                 9,8,7,6;
                 1,2,0,0];
  Real Ar[4,4];
  Real u[4]={0,0,0,0};

  u[2:4]=Utilities.householderVector(A[2:4,1],{1,0,0});
  // u= = {0, 0.8107, 0.5819, 0.0647}

  Ar=householderSimilarityTransformation(A,u);
 //  Ar = [1.0,     -3.8787,    -1.2193,    3.531;
          -9.5394, 11.3407,      6.4336,   -5.9243;
           0.0,     3.1307,      0.7525,   -3.3670;
           0.0,     0.8021,     -1.1656,   -1.0932]
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.householderReflection\">Matrices.Utilities.householderReflection</a>,<br>
<a href=\"modelica://Modelica.Math.Vectors.Utilities.householderReflection\">Vectors.Utilities.householderReflection</a>,<br>
<a href=\"modelica://Modelica.Math.Vectors.Utilities.householderVector\">Vectors.Utilities.householderVector</a>
</p>
</html>", revisions="<html>
<ul>
<li><i>2010/04/30 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end householderSimilarityTransformation;

    function toUpperHessenberg
      "Transform a real square matrix A to upper Hessenberg form H by orthogonal similarity transformation:  Q' * A * Q = H"
      import Modelica.Math.Matrices;
      import Modelica.Math.Matrices.LAPACK;

      input Real A[:,size(A, 1)] "Square matrix A";
      input Integer ilo=1
        "Lowest index where the original matrix had been Hessenbergform";
      input Integer ihi=size(A, 1)
        "Highest index where the original matrix had been Hessenbergform";
      output Real H[size(A, 1),size(A, 2)] "Upper Hessenberg form";
      output Real V[size(A, 1),size(A, 2)]
        "V=[v1,v2,..vn-1,0] with vi are vectors which define the elementary reflectors";

      output Real tau[max(0, size(A, 1) - 1)]
        "Scalar factors of the elementary reflectors";
      output Integer info "Information of successful function call";

    protected
      Integer n=size(A, 1);
      Real Aout[size(A, 1),size(A, 2)];
      Integer i;

    algorithm
      if n > 0 then
        (Aout,tau,info) := LAPACK.dgehrd(A, ilo, ihi);
        H[1:2, 1:ihi] := Aout[1:2, 1:ihi];
        H[1:2, ihi + 1:n] := A[1:2, ihi + 1:n];

        for i in 3:n loop
          H[i, i - 1:ihi] := Aout[i, i - 1:ihi];
          H[i, ihi + 1:n] := A[i, ihi + 1:n];
        end for;

        for i in 1:min(n - 2, ihi) loop
          V[i + 1, i] := 1.0;
          V[i + 2:n, i] := Aout[i + 2:n, i];
        end for;
        V[n, n - 1] := 1;
      end if;

      annotation (Documentation(info="<html>
   <h4>Syntax</h4>
<blockquote><pre>
         H = Matrices.Utilities.<b>toUpperHessenberg</b>(A);
         (H, V, tau, info) = Matrices.Utilities.<b>toUpperHessenberg</b>(A,ilo, ihi);
</pre></blockquote>
<h4>Description</h4>
Function <b>toUpperHessenberg</b> computes a upper Hessenberg form <b>H</b> of a matrix <b>A</b> by orthogonal similarity transformation:  <b>Q</b>' * <b>A</b> * <b>Q</b> = <b>H</b>.
With the optional inputs ilo and ihi, also partial transformation is possible. The function calls LAPACK function DGEHRD.
See <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dgehrd\">Matrices.Lapack.dgehrd</a> for more information about the additional outputs V, tau, info and inputs ilo, ihi.
<p>

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
<li><i>2010/04/30 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end toUpperHessenberg;

    function eigenvaluesHessenberg
      "Compute eigenvalues of an upper Hessenberg form matrix"
      import Modelica.Math.Matrices.Utilities;
      import Modelica.Math.Matrices.LAPACK;
      input Real H[:,size(H, 1)] "Hessenberg matrix H";

      output Real ev[size(H, 1),2] "Eigenvalues";
      output Integer info=0;
    protected
      Integer n=size(H, 1);
      Integer ilo=1;
      Integer ihi=n;
      Real alphaReal[size(H, 1)]
        "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      Real alphaImag[size(H, 1)]
        "Imaginary part of alpha (eigenvalue=(alphaReal+i*alphaImag))";
      Real Z[n,n]=fill(0, n, n);

    algorithm
      if size(H, 1) > 0 then
        (alphaReal,alphaImag,info) := LAPACK.dhseqr(H);
      else
        alphaReal := fill(0, size(H, 1));
        alphaImag := fill(0, size(H, 1));
      end if;
      ev := [alphaReal,alphaImag];

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
           ev = Matrices.Utilities.<b>eigenvaluesHessenberg</b>(H);
    (X, info) = Matrices.Utilities.<b>eigenvaluesHessenberg</b>(H);
</pre></blockquote>
<h4>Description</h4>
<p>
This function computes the eigenvalues of a Hessenberg form matrix. Transformation to Hessenberg form is the first step in eigenvalue computation for arbitrary matrices with QR decomposition.
This step can be skipped if the matrix has already Hessenberg form.
</p>

<p>
The function uses the LAPACK-routine dhseqr. Output <code>info</code> is 0 for a successful call of this
function.<br>
See <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dhseqr\">Matrices.Lapack.dhseqr</a> for details
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
</html>
",     revisions=
             "<html>
<ul>
<li><i>2010/04/30 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end eigenvaluesHessenberg;

    function reorderRSF
      "Reorders a real Schur form to clusters of stable and unstable eigenvalues"

      import Modelica.Math.Matrices.LAPACK;

      input Real T[:,:] "Real Schur form";
      input Real Q[:,size(T, 2)] "Schur vector Matrix";
      input Real alphaReal[size(T, 1)]
        "Real part of eigenvalue=alphaReal+i*alphaImag";
      input Real alphaImag[size(T, 1)]
        "Imaginary part of eigenvalue=(alphaReal+i*alphaImag";
      input Boolean iscontinuous=true
        "True if the according system is continuous. False for discrete systems";

      output Real To[size(T, 1),size(T, 2)] "Reordered Schur form";
      output Real Qo[size(T, 1),size(T, 2)] "Reordered Schur vector matirx";
      output Real wr[size(T, 2)] "Reordered eigenvalues, real part";
      output Real wi[size(T, 2)] "Reordered eigenvalues, imaginary part";

    protected
      Integer n=size(T, 2);
      Boolean select[:]=fill(false, size(T, 2));
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

      (To,Qo,wr,wi) := LAPACK.dtrsen("E", "V", select, T, Q);

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
              To = Matrices.Utilities.<b>reorderRSF</b>(T, Q, alphaReal, alphaImag);
(To, Qo, wr, wi) = Matrices.Utilities.<b>reorderRSF</b>(T, Q, alphaReal, alphaImag, iscontinuous);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>reorderRSF</b>() reorders a real Schur form such that the stable eigenvalues of
the system are in the 1-by-1 and 2-by-2 diagonal blocks of the block <b>upper</b> triangular matrix.
If the Schur form is referenced to a continuous system the staple eigenvalues are in the left complex half plane.
The stable eigenvalues of a discrete system are inside the complex unit circle.<br>
This function is used for example to solve algebraic Riccati equations
(<a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">continuousRiccati</a>,
<a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">discreteRiccati</a>). In this context the Schur form
as well as the corresponding eigenvalues and the transformation matrix <b>Q</b> are known, why the eigenvalues and the transformation matrix are inputs to <b>reorderRSF()</b>.<br>

The Schur vector matrix <b>Qo</b> is also reordered according to <b>To</b>. The vectors <b>wr</b> and <b>wi</b> contains the real and imaginary parts of the
rordered eigenvalues respectively.
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
</html>", revisions="<html>
<ul>
<li><i>2010/04/30 </i>
       by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end reorderRSF;

    function findLocal_tk
      "Find a local minimizer tk to define the length of the step tk*Nk in continuousRiccatiIterative and discreteRiccatiIterative"
      extends Modelica.Icons.Function;

      import Modelica.Math.Matrices;
      import Modelica.Math.Vectors;

      input Real Rk[:,size(Rk, 2)];
      input Real Vk[size(Rk, 1),size(Rk, 2)];

      output Real tk;

    protected
      Real alpha_k;
      Real beta_k;
      Real gamma_k;
      Real p[3,2];
      Boolean h;

    algorithm
      alpha_k := Matrices.trace(Rk*Rk);
      beta_k := Matrices.trace(Rk*Vk);
      gamma_k := Matrices.trace(Vk*Vk);

      if gamma_k > Modelica.Constants.eps then
        p := Vectors.Utilities.roots({4*gamma_k,6*beta_k,2*(alpha_k - 2*beta_k),-2*
          alpha_k});
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
           tk = Matrices.Utilities.<b>findLocal_tk</b>(Rk, Vk);
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

<h4>References</h4>
<PRE>
  [1] Benner, P., Byers, R.
      An Exact Line Search Method for Solving Generalized Continuous-Time Algebraic Riccati Equations
      IEEE Transactions On Automatic Control, Vol. 43, No. 1, pp. 101-107, 1998.
</PRE>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\">Matrices.Utilities.continuousRiccatiIterative</a><br>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.discreteRiccatiIterative\">Matrices.Utilities.discreteRiccatiIterative</a><br>
</html>", revisions="<html>
<ul>
<li><i>2010/04/30 </i>
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
  annotation (
    Documentation(info="<HTML>
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

<p><b>Basic Information</b></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.toString\">toString</a>(A)
     - returns the string representation of matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.isEqual\">isEqual</a>(M1, M2)
     - returns true if matrices M1 and M2 have the same size and the same elements.</li>
</ul>

<p><b>Linear Equations</b></p>
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
       min|A*x-a|^2 subject to B*x=b</<li>

<li> (LU,p,info) = <a href=\"modelica://Modelica.Math.Matrices.LU\">LU</a>(A)
     - returns the LU decomposition with row pivoting of a rectangular matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.LU_solve\">LU_solve</a>(LU,p,b)
     - returns solution x of the linear equation L*U*x[p]=b with a b
       vector and an LU decomposition from \"LU(..)\".</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.LU_solve2\">LU_solve2</a>(LU,p,B)
     - returns solution X of the linear equation L*U*X[p,:]=B with a B
       matrix and an LU decomposition from \"LU(..)\".</li>
</ul>

<p><b>Matrix Factorizations</b></p>
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

<p><b>Matrix Properties</b></p>
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

<p><b>Matrix Exponentials</b></p>
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

<p><b>Matrix Equations</b></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.continuousLyapunov\">continuousLyapunov</a>(A,C)
     - returns solution X of the continuous-time Lyapunov equation X*A + A'*X = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.continuousSylvester\">continuousSylvester</a>(A,B,C)
     - returns solution X of the continuous-time Sylvester equation A*X + X*B = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">continuousRiccati</a>(A,B,R,Q)
     - returns solution X of the continuous-time algebraic Riccat equation
       A'*X + X*A - X*B*inv(R)*B'*X + Q = 0</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteLyapunov\">discreteLyapunov</a>(A,C)
     - returns solution X of the discretes-time Lyapunov equation A'*X*A + sgn*X = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteSylvester\">discreteSylvester</a>(A,B,C)
     - returns solution X of the discrete-time Sylvester equation A*X*B + sgn*X = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">discreteRiccati</a>(A,B,R,Q)
     - returns solution X of the discrete-time algebraic Riccat equation
       A'*X*A - X - A'*X*B*inv(R + B'*X*B)*B'*X*A + Q = 0</li>
</ul>

<p><b>Matrix Manipulation</b></p>
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

</HTML>
"));
end Matrices;

function isEqual "Determine if two Real scalars are numerically identical"
  extends Modelica.Icons.Function;
  input Real s1 "First scalar";
  input Real s2 "Second scalar";
  input Real eps(min=0) = 0
    "The two scalars are identical if abs(s1-s2) <= eps";
  output Boolean result "= true, if scalars are identical";
algorithm
  result :=abs(s1 - s2) <= eps;
  annotation (Inline=true, Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Math.<b>isEqual</b>(s1, s2);
Math.<b>isEqual</b>(s1, s2, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Math.isEqual(s1, s2)</code>\" returns <b>true</b>,
if the two Real scalars s1 and s2 are identical. Otherwise the function
returns <b>false</b>. The equality check is performed by
\"abs(s1-s2) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real s1 = 2.0;
  Real s2 = 2.0;
  Real s3 = 2.000001;
  Boolean result;
<b>algorithm</b>
  result := Math.isEqual(s1,s2);     // = <b>true</b>
  result := Math.isEqual(s1,s3);     // = <b>false</b>
  result := Math.isEqual(s1,s3,0.1); // = <b>true</b>
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>,
<a href=\"modelica://Modelica.Math.Matrices.isEqual\">Matrices.isEqual</a>,
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
</p>
</HTML>"));
end isEqual;

function sin "Sine"
  extends baseIcon1;
  input Modelica.SIunits.Angle u;
  output Real y;

external "builtin" y = sin(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
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
              57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={0,0,0}),
        Text(
          extent={{12,84},{84,36}},
          lineColor={192,192,192},
          textString="sin")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{100,0},{84,6},{84,-6},{100,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},{
              -43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},{
              -14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},{
              29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{57.5,
              -61.9},{63.9,-47.2},{72,-24.8},{80,0}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-105,72},{-85,88}},
          textString="1",
          lineColor={0,0,255}),
        Text(
          extent={{70,25},{90,5}},
          textString="2*pi",
          lineColor={0,0,255}),
        Text(
          extent={{-103,-72},{-83,-88}},
          textString="-1",
          lineColor={0,0,255}),
        Text(
          extent={{82,-6},{102,-26}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{-80,80},{-28,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-80,-80},{50,-80}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = sin(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/sin.png\">
</p>
</html>"), Library="ModelicaExternalC");
end sin;

function cos "Cosine"
  extends baseIcon1;
  input SI.Angle u;
  output Real y;

external "builtin" y = cos(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
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
              73.4},{75.2,78.6},{80,80}}, color={0,0,0}),
        Text(
          extent={{-36,82},{36,34}},
          lineColor={192,192,192},
          textString="cos")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{-103,72},{-83,88}},
          textString="1",
          lineColor={0,0,255}),
        Text(
          extent={{-103,-72},{-83,-88}},
          textString="-1",
          lineColor={0,0,255}),
        Text(
          extent={{70,25},{90,5}},
          textString="2*pi",
          lineColor={0,0,255}),
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{98,0},{82,6},{82,-6},{98,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,80},{-74.4,78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},{-48.6,
              26.6},{-29.3,-32.5},{-22.1,-51.7},{-15.7,-65.3},{-10.1,-73.8},{-4.42,
              -78.8},{1.21,-79.9},{6.83,-77.1},{12.5,-70.6},{18.1,-60.6},{24.5,
              -45.7},{32.6,-23},{50.3,31.3},{57.5,50.7},{63.9,64.6},{69.5,73.4},
              {75.2,78.6},{80,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{78,-6},{98,-26}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{-80,-80},{18,-80}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = cos(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/cos.png\">
</p>
</html>"), Library="ModelicaExternalC");
end cos;

function tan "Tangent (u shall not be -pi/2, pi/2, 3*pi/2, ...)"
  extends baseIcon2;
  input SI.Angle u;
  output Real y;

external "builtin" y = tan(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-78.4,-68.4},{-76.8,-59.7},{-74.4,-50},{-71.2,-40.9},
              {-67.1,-33},{-60.7,-24.8},{-51.1,-17.2},{-35.8,-9.98},{-4.42,-1.07},
              {33.4,9.12},{49.4,16.2},{59.1,23.2},{65.5,30.6},{70.4,39.1},{73.6,
              47.4},{76,56.1},{77.6,63.8},{80,80}}, color={0,0,0}),
        Text(
          extent={{-90,72},{-18,24}},
          lineColor={192,192,192},
          textString="tan")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{-37,-72},{-17,-88}},
          textString="-5.8",
          lineColor={0,0,255}),
        Text(
          extent={{-33,86},{-13,70}},
          textString=" 5.8",
          lineColor={0,0,255}),
        Text(
          extent={{68,-13},{88,-33}},
          textString="1.4",
          lineColor={0,0,255}),
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{98,0},{82,6},{82,-6},{98,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-80},{-78.4,-68.4},{-76.8,-59.7},{-74.4,-50},{-71.2,-40.9},
              {-67.1,-33},{-60.7,-24.8},{-51.1,-17.2},{-35.8,-9.98},{-4.42,-1.07},
              {33.4,9.12},{49.4,16.2},{59.1,23.2},{65.5,30.6},{70.4,39.1},{73.6,
              47.4},{76,56.1},{77.6,63.8},{80,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{82,22},{102,2}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{0,80},{86,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{80,88},{80,-16}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = tan(u), with -&infin; &lt; u &lt; &infin;
(if u is a multiple of (2n-1)*pi/2, y = tan(u) is +/- infinity).
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/tan.png\">
</p>
</html>"), Library="ModelicaExternalC");
end tan;

function asin "Inverse sine (-1 <= u <= 1)"
  extends baseIcon2;
  input Real u;
  output SI.Angle y;

external "builtin" y = asin(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,
              -49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,
              52.7},{75.2,62.2},{77.6,67.5},{80,80}}, color={0,0,0}),
        Text(
          extent={{-88,78},{-16,30}},
          lineColor={192,192,192},
          textString="asin")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{-40,-72},{-15,-88}},
          textString="-pi/2",
          lineColor={0,0,255}),
        Text(
          extent={{-38,88},{-13,72}},
          textString=" pi/2",
          lineColor={0,0,255}),
        Text(
          extent={{68,-9},{88,-29}},
          textString="+1",
          lineColor={0,0,255}),
        Text(
          extent={{-90,21},{-70,1}},
          textString="-1",
          lineColor={0,0,255}),
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{98,0},{82,6},{82,-6},{98,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,-49.8},
              {-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,52.7},{
              75.2,62.2},{77.6,67.5},{80,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{82,24},{102,4}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{0,80},{86,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{80,86},{80,-10}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = asin(u), with -1 &le; u &le; +1:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/asin.png\">
</p>
</html>"), Library="ModelicaExternalC");
end asin;

function acos "Inverse cosine (-1 <= u <= 1)"
  extends baseIcon2;
  input Real u;
  output SI.Angle y;

external "builtin" y = acos(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-79.2,72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,
              49.8},{-53.5,37.3},{-30.2,19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},
              {75.2,-62.2},{77.6,-67.5},{80,-80}}, color={0,0,0}),
        Text(
          extent={{-86,-14},{-14,-62}},
          lineColor={192,192,192},
          textString="acos")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,-80},{84,-80}}, color={95,95,95}),
        Polygon(
          points={{98,-80},{82,-74},{82,-86},{98,-80}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,80},{-79.2,72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,49.8},
              {-53.5,37.3},{-30.2,19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},
              {75.2,-62.2},{77.6,-67.5},{80,-80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-30,88},{-5,72}},
          textString=" pi",
          lineColor={0,0,255}),
        Text(
          extent={{-94,-57},{-74,-77}},
          textString="-1",
          lineColor={0,0,255}),
        Text(
          extent={{60,-81},{80,-101}},
          textString="+1",
          lineColor={0,0,255}),
        Text(
          extent={{82,-56},{102,-76}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{-2,80},{84,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{80,82},{80,-86}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = acos(u), with -1 &le; u &le; +1:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/acos.png\">
</p>
</html>"), Library="ModelicaExternalC");
end acos;

function atan "Inverse tangent"
  extends baseIcon2;
  input Real u;
  output SI.Angle y;

external "builtin" y = atan(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-52.7,-75.2},{-37.4,-69.7},{-26.9,-63},{-19.7,-55.2},
              {-14.1,-45.8},{-10.1,-36.4},{-6.03,-23.9},{-1.21,-5.06},{5.23,21},
              {9.25,34.1},{13.3,44.2},{18.1,52.9},{24.5,60.8},{33.4,67.6},{47,
              73.6},{69.5,78.6},{80,80}}, color={0,0,0}),
        Text(
          extent={{-86,68},{-14,20}},
          lineColor={192,192,192},
          textString="atan")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{96,0},{80,6},{80,-6},{96,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-80},{-52.7,-75.2},{-37.4,-69.7},{-26.9,-63},{-19.7,-55.2},
              {-14.1,-45.8},{-10.1,-36.4},{-6.03,-23.9},{-1.21,-5.06},{5.23,21},
              {9.25,34.1},{13.3,44.2},{18.1,52.9},{24.5,60.8},{33.4,67.6},{47,
              73.6},{65,77},{80,78}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-34,87},{-14,74}},
          textString="pi/2",
          lineColor={0,0,255}),
        Text(
          extent={{-32,-71},{-12,-91}},
          textString="-pi/2",
          lineColor={0,0,255}),
        Text(
          extent={{84,-4},{104,-24}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{-2,80},{84,80}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = atan(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan.png\">
</p>
</html>"), Library="ModelicaExternalC");
end atan;

function atan2 "Four quadrant inverse tangent"
  extends baseIcon2;
  input Real u1;
  input Real u2;
  output SI.Angle y;

external "builtin" y = atan2(u1, u2);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},
              {69.9,-45.8},{80,-45.1}}, color={0,0,0}),
        Line(points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
              62.1,33.5},{80,34.9}}, color={0,0,0}),
        Line(points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,
              65.8},{-1.82,77.2},{0,80}}, color={0,0,0}),
        Text(
          extent={{-90,-46},{-18,-94}},
          lineColor={192,192,192},
          textString="atan2")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{96,0},{80,6},{80,-6},{96,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},{
              69.9,-45.8},{80,-45.1}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
              62.1,33.5},{80,34.9}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,65.8},
              {-1.82,77.2},{0,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-32,89},{-10,74}},
          textString="pi",
          lineColor={0,0,255}),
        Text(
          extent={{-32,-72},{-4,-88}},
          textString="-pi",
          lineColor={0,0,255}),
        Text(
          extent={{0,55},{20,42}},
          textString="pi/2",
          lineColor={0,0,255}),
        Line(points={{0,40},{-8,40}}, color={192,192,192}),
        Line(points={{0,-40},{-8,-40}}, color={192,192,192}),
        Text(
          extent={{0,-23},{20,-42}},
          textString="-pi/2",
          lineColor={0,0,255}),
        Text(
          extent={{62,-4},{94,-26}},
          lineColor={95,95,95},
          textString="u1, u2"),
        Line(
          points={{-88,40},{86,40}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-86,-40},{86,-40}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<HTML>
This function returns y = atan2(u1,u2) such that tan(y) = u1/u2 and
y is in the range -pi &lt; y &le; pi. u2 may be zero, provided
u1 is not zero. Usually u1, u2 is provided in such a form that
u1 = sin(y) and u2 = cos(y):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan2.png\">
</p>

</HTML>
"),        Library="ModelicaExternalC");
end atan2;

function atan3
  "Four quadrant inverse tangent (select solution that is closest to given angle y0)"
  import Modelica.Math;
  extends Modelica.Math.baseIcon2;
  input Real u1;
  input Real u2;
  input Modelica.SIunits.Angle y0=0 "y shall be in the range: -pi < y-y0 < pi";
  output Modelica.SIunits.Angle y;

protected
  Real pi = Modelica.Constants.pi;
  Real w;
algorithm
  w :=Math.atan2(u1, u2);
  y := w + 2*pi*div(abs(w-y0)+pi,2*pi)*(if y0 > w then +1 else -1);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},
              {69.9,-45.8},{80,-45.1}}, color={0,0,0}),
        Line(points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
              62.1,33.5},{80,34.9}}, color={0,0,0}),
        Line(points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,
              65.8},{-1.82,77.2},{0,80}}, color={0,0,0}),
        Text(
          extent={{-90,-46},{-18,-94}},
          lineColor={192,192,192},
          textString="atan3")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,-86},{84,-86}}, color={95,95,95}),
        Polygon(
          points={{98,-86},{82,-80},{82,-92},{98,-86}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},{
              69.9,-45.8},{80,-45.1}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
              62.1,33.5},{80,34.9}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,65.8},
              {-1.82,77.2},{0,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-56,82},{-12,72}},
          textString="(2*N-1)*pi",
          lineColor={0,0,255}),
        Text(
          extent={{-52,-72},{-10,-88}},
          textString="(2*N-3)*pi",
          lineColor={0,0,255}),
        Line(points={{0,40},{-8,40}}, color={192,192,192}),
        Line(points={{0,-40},{-8,-40}}, color={192,192,192}),
        Text(
          extent={{38,-68},{78,-84}},
          lineColor={95,95,95},
          textString="u1, u2, y0"),
        Line(
          points={{-84,40},{88,40}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-84,-40},{88,-40}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<HTML>
<p>
This function returns y = <b>atan3</b>(u1,u2,y0) such that
<b>tan</b>(y) = u1/u2 and
y is in the range: -pi &lt; y-y0 &lt; pi.<br>
u2 may be zero, provided u1 is not zero. The difference to
Modelica.Math.atan2(..) is the optional third argument y0 that
allows to specify which of the infinite many solutions
shall be returned:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan3.png\">
</p>

</HTML>
"));
end atan3;

function sinh "Hyperbolic sine"
  extends baseIcon2;
  input Real u;
  output Real y;

external "builtin" y = sinh(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-76,-65.4},{-71.2,-51.4},{-65.5,-38.8},{-59.1,-28.1},
              {-51.1,-18.7},{-41.4,-11.4},{-27.7,-5.5},{-4.42,-0.653},{24.5,
              4.57},{39,10.1},{49.4,17.2},{57.5,25.9},{63.9,35.8},{69.5,47.4},{
              74.4,60.4},{78.4,73.8},{80,80}}, color={0,0,0}),
        Text(
          extent={{-88,80},{-16,32}},
          lineColor={192,192,192},
          textString="sinh")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{98,0},{82,6},{82,-6},{98,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-80},{-76,-65.4},{-71.2,-51.4},{-65.5,-38.8},{-59.1,-28.1},
              {-51.1,-18.7},{-41.4,-11.4},{-27.7,-5.5},{-4.42,-0.653},{24.5,
              4.57},{39,10.1},{49.4,17.2},{57.5,25.9},{63.9,35.8},{69.5,47.4},{
              74.4,60.4},{78.4,73.8},{80,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-31,72},{-11,88}},
          textString="27",
          lineColor={0,0,255}),
        Text(
          extent={{-35,-88},{-15,-72}},
          textString="-27",
          lineColor={0,0,255}),
        Text(
          extent={{68,-7},{88,-27}},
          textString="4",
          lineColor={0,0,255}),
        Text(
          extent={{-98,21},{-78,1}},
          textString="-4",
          lineColor={0,0,255}),
        Text(
          extent={{80,26},{100,6}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{0,80},{86,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{80,84},{80,-6}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = sinh(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/sinh.png\">
</p>
</html>"), Library="ModelicaExternalC");
end sinh;

function cosh "Hyperbolic cosine"
  extends baseIcon2;
  input Real u;
  output Real y;

external "builtin" y = cosh(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
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
              77.6,61.1},{80,80}}, color={0,0,0}),
        Text(
          extent={{4,66},{66,20}},
          lineColor={192,192,192},
          textString="cosh")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,-84.083},{84,-84.083}}, color={95,95,95}),
        Polygon(
          points={{98,-84.083},{82,-78.083},{82,-90.083},{98,-84.083}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,80},{-77.6,61.1},{-74.4,39.3},{-71.2,20.7},{-67.1,1.29},
              {-63.1,-14.6},{-58.3,-29.8},{-52.7,-43.5},{-46.2,-55.1},{-39,-64.3},
              {-30.2,-71.7},{-18.9,-77.1},{-4.42,-79.9},{10.9,-79.1},{23.7,-75.2},
              {34.2,-68.7},{42.2,-60.6},{48.6,-51.2},{54.3,-40},{59.1,-27.5},{
              63.1,-14.6},{67.1,1.29},{71.2,20.7},{74.4,39.3},{77.6,61.1},{80,
              80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-31,72},{-11,88}},
          textString="27",
          lineColor={0,0,255}),
        Text(
          extent={{64,-83},{84,-103}},
          textString="4",
          lineColor={0,0,255}),
        Text(
          extent={{-94,-63},{-74,-83}},
          textString="-4",
          lineColor={0,0,255}),
        Text(
          extent={{80,-60},{100,-80}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{0,80},{88,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{80,84},{80,-90}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = cosh(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/cosh.png\">
</p>
</html>"), Library="ModelicaExternalC");
end cosh;

function tanh "Hyperbolic tangent"
  extends baseIcon2;
  input Real u;
  output Real y;

external "builtin" y = tanh(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-47.8,-78.7},{-35.8,-75.7},{-27.7,-70.6},{-22.1,
              -64.2},{-17.3,-55.9},{-12.5,-44.3},{-7.64,-29.2},{-1.21,-4.82},{
              6.83,26.3},{11.7,42},{16.5,54.2},{21.3,63.1},{26.9,69.9},{34.2,75},
              {45.4,78.4},{72,79.9},{80,80}}, color={0,0,0}),
        Text(
          extent={{-88,72},{-16,24}},
          lineColor={192,192,192},
          textString="tanh")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{96,0},{80,6},{80,-6},{96,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-80.5},{-47.8,-79.2},{-35.8,-76.2},{-27.7,-71.1},{-22.1,
              -64.7},{-17.3,-56.4},{-12.5,-44.8},{-7.64,-29.7},{-1.21,-5.32},{
              6.83,25.8},{11.7,41.5},{16.5,53.7},{21.3,62.6},{26.9,69.4},{34.2,
              74.5},{45.4,77.9},{72,79.4},{80,79.5}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-29,72},{-9,88}},
          textString="1",
          lineColor={0,0,255}),
        Text(
          extent={{3,-72},{23,-88}},
          textString="-1",
          lineColor={0,0,255}),
        Text(
          extent={{82,-2},{102,-22}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{0,80},{88,80}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = tanh(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\">
</p>
</html>"), Library="ModelicaExternalC");
end tanh;

function asinh "Inverse of sinh (area hyperbolic sine)"
  extends Modelica.Math.baseIcon2;
  input Real u;
  output Real y;

algorithm
  y :=Modelica.Math.log(u + sqrt(u*u + 1));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-56.7,-68.4},{-39.8,-56.8},{-26.9,-44.7},{-17.3,
              -32.4},{-9.25,-19},{9.25,19},{17.3,32.4},{26.9,44.7},{39.8,56.8},
              {56.7,68.4},{80,80}}, color={0,0,0}),
        Text(
          extent={{-90,80},{-6,26}},
          lineColor={192,192,192},
          textString="asinh")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{98,0},{82,6},{82,-6},{98,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-80},{-56.7,-68.4},{-39.8,-56.8},{-26.9,-44.7},{-17.3,-32.4},
              {-9.25,-19},{9.25,19},{17.3,32.4},{26.9,44.7},{39.8,56.8},{56.7,
              68.4},{80,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-31,72},{-11,88}},
          textString="2.31",
          lineColor={0,0,255}),
        Text(
          extent={{-35,-88},{-15,-72}},
          textString="-2.31",
          lineColor={0,0,255}),
        Text(
          extent={{72,-13},{92,-33}},
          textString="5",
          lineColor={0,0,255}),
        Text(
          extent={{-96,21},{-76,1}},
          textString="-5",
          lineColor={0,0,255}),
        Text(
          extent={{80,22},{100,2}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{0,80},{88,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{80,86},{80,-12}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
The function returns the area hyperbolic sine of its
input argument u. This inverse of sinh(..) is unique
and there is no restriction on the input argument u of
asinh(u) (-&infin; &lt; u &lt; &infin;):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/asinh.png\">
</p>
</html>"));
end asinh;

function acosh "Inverse of cosh (area hyperbolic cosine)"
  import Modelica.Utilities.Streams.*;
  extends Modelica.Math.baseIcon1;
  input Real u;
  output Real y;

algorithm
  assert(u>=1.0, "Input argument u (= " + String(u) + ") of acosh(u) must be >= 1.0");
  y :=Modelica.Math.log(u + sqrt(u*u - 1));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-66,-80},{-65.2,-66},{-64.4,-60.3},{-62.8,-52.2},{-60.4,-43.4},
              {-56.4,-32.4},{-49.9,-19.3},{-41.1,-5.65},{-29,8.8},{-12.9,23.8},
              {7.97,39.2},{35.3,55},{69.9,70.8},{94,80}}, color={0,0,0}),
        Text(
          extent={{-14,2},{76,-54}},
          lineColor={192,192,192},
          textString="arcosh")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,-70},{84,-70}}, color={95,95,95}),
        Polygon(
          points={{100,-70},{84,-64},{84,-76},{100,-70}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,-70},{-59.2,-56},{-58.4,-50.3},{-56.8,-42.2},{-54.4,-33.4},
              {-50.4,-22.4},{-43.9,-9.3},{-35.1,4.35},{-23,18.8},{-6.9,33.8},{
              13.97,49.2},{41.3,65},{75.9,80.8},{100,90}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-80,66},{-58,78}},
          textString="2.29",
          lineColor={0,0,255}),
        Text(
          extent={{-73,-86},{-50,-70}},
          textString="1.0",
          lineColor={0,0,255}),
        Text(
          extent={{64,-77},{84,-92}},
          textString="5",
          lineColor={0,0,255}),
        Text(
          extent={{-96,-55},{-76,-70}},
          textString="0",
          lineColor={0,0,255}),
        Text(
          extent={{74,-44},{94,-64}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{-80,80},{100,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{74,-78},{74,88}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns the area hyperbolic cosine of its
input argument u. The valid range of u is
</p>
<pre>
  +1 &le; u &lt; +&infin;
</pre>
<p>
If the function is called with u &lt; 1, an error occurs.
The function cosh(u) has two inverse functions (the curve
looks similar to a sqrt(..) function). acosh(..) returns
the inverse that is positive. At u=1, the derivative dy/du is infinite.
Therefore, this function should not be used in a model, if u
can become close to 1:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/acosh.png\">
</p>
</html>"));
end acosh;

function exp "Exponential, base e"
  extends baseIcon2;
  input Real u;
  output Real y;

external "builtin" y = exp(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,-80.3976},{68,-80.3976}}, color={192,192,192}),
        Polygon(
          points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},
              {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
              67.1,18.6},{72,38.2},{76,57.6},{80,80}}, color={0,0,0}),
        Text(
          extent={{-86,50},{-14,2}},
          lineColor={192,192,192},
          textString="exp")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,-80.3976},{84,-80.3976}}, color={95,95,95}),
        Polygon(
          points={{98,-80.3976},{82,-74.3976},{82,-86.3976},{98,-80.3976}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},{
              34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
              67.1,18.6},{72,38.2},{76,57.6},{80,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-31,72},{-11,88}},
          textString="20",
          lineColor={0,0,255}),
        Text(
          extent={{-92,-81},{-72,-101}},
          textString="-3",
          lineColor={0,0,255}),
        Text(
          extent={{66,-81},{86,-101}},
          textString="3",
          lineColor={0,0,255}),
        Text(
          extent={{2,-69},{22,-89}},
          textString="1",
          lineColor={0,0,255}),
        Text(
          extent={{78,-54},{98,-74}},
          lineColor={95,95,95},
          textString="u"),
        Line(
          points={{0,80},{88,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{80,84},{80,-84}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = exp(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\">
</p>
</html>"), Library="ModelicaExternalC");
end exp;

function log "Natural (base e) logarithm (u shall be > 0)"
  extends baseIcon1;
  input Real u;
  output Real y;

external "builtin" y = log(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},
              {-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},
              {-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}},
            color={0,0,0}),
        Text(
          extent={{-6,-24},{66,-72}},
          lineColor={192,192,192},
          textString="log")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{100,0},{84,6},{84,-6},{100,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-78,-80},{-77.2,-50.6},{-76.4,-37},{-75.6,-28},{-74.8,-21.3},
              {-73.2,-11.4},{-70.8,-1.31},{-67.5,8.08},{-62.7,17.9},{-55.5,28},
              {-45,38.1},{-29.8,48.1},{-8.1,58},{24.1,68},{70.7,78.1},{82,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-105,72},{-85,88}},
          textString="3",
          lineColor={0,0,255}),
        Text(
          extent={{60,-3},{80,-23}},
          textString="20",
          lineColor={0,0,255}),
        Text(
          extent={{-78,-7},{-58,-27}},
          textString="1",
          lineColor={0,0,255}),
        Text(
          extent={{84,26},{104,6}},
          lineColor={95,95,95},
          textString="u"),
        Text(
          extent={{-100,9},{-80,-11}},
          textString="0",
          lineColor={0,0,255}),
        Line(
          points={{-80,80},{84,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{82,82},{82,-6}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = log(10) (the natural logarithm of u),
with u &gt; 0:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/log.png\">
</p>
</html>"), Library="ModelicaExternalC");
end log;

function log10 "Base 10 logarithm (u shall be > 0)"
  extends baseIcon1;
  input Real u;
  output Real y;

external "builtin" y = log10(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-79.8,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},
              {-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},
              {-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}},
            color={0,0,0}),
        Text(
          extent={{-30,-22},{60,-70}},
          lineColor={192,192,192},
          textString="log10")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{84,0}}, color={95,95,95}),
        Polygon(
          points={{98,0},{82,6},{82,-6},{98,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-77.8,-80},{-77.2,-50.6},{-76.4,-37},{-75.6,-28},{-74.8,-21.3},
              {-73.2,-11.4},{-70.8,-1.31},{-67.5,8.08},{-62.7,17.9},{-55.5,28},
              {-45,38.1},{-29.8,48.1},{-8.1,58},{24.1,68},{70.7,78.1},{82,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{66,-13},{86,-33}},
          textString="20",
          lineColor={0,0,255}),
        Text(
          extent={{-78,-1},{-58,-21}},
          textString="1",
          lineColor={0,0,255}),
        Text(
          extent={{-83,62},{-63,78}},
          textString=" 1.3",
          lineColor={0,0,255}),
        Text(
          extent={{80,24},{100,4}},
          lineColor={95,95,95},
          textString="u"),
        Text(
          extent={{-100,9},{-80,-11}},
          textString="0",
          lineColor={0,0,255}),
        Line(
          points={{-80,80},{86,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{80,92},{80,-12}},
          color={175,175,175},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
This function returns y = log10(u),
with u &gt; 0:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/log10.png\">
</p>
</html>"), Library="ModelicaExternalC");
end log10;

partial function baseIcon1
  "Basic icon for mathematical function with y-axis on left side"

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
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
          lineColor={0,0,255})}),                          Diagram(
        coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-80,80},{-88,80}}, color={95,95,95}),
        Line(points={{-80,-80},{-88,-80}}, color={95,95,95}),
        Line(points={{-80,-90},{-80,84}}, color={95,95,95}),
        Text(
          extent={{-75,104},{-55,84}},
          lineColor={95,95,95},
          textString="y"),
        Polygon(
          points={{-80,98},{-86,82},{-74,82},{-80,98}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis on the left side.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
end baseIcon1;

partial function baseIcon2
  "Basic icon for mathematical function with y-axis in middle"

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
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
          lineColor={0,0,255})}),                          Diagram(graphics={
        Line(points={{0,80},{-8,80}}, color={95,95,95}),
        Line(points={{0,-80},{-8,-80}}, color={95,95,95}),
        Line(points={{0,-90},{0,84}}, color={95,95,95}),
        Text(
          extent={{5,104},{25,84}},
          lineColor={95,95,95},
          textString="y"),
        Polygon(
          points={{0,98},{-6,82},{6,82},{0,98}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis in the middle.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
end baseIcon2;

function tempInterpol1
  "Temporary function for linear interpolation (will be removed)"
  input Real u "input value (first column of table)";
  input Real table[:, :] "table to be interpolated";
  input Integer icol "column of table to be interpolated";
  output Real y "interpolated input value (icol column of table)";
protected
  Integer i;
  Integer n "number of rows of table";
  Real u1;
  Real u2;
  Real y1;
  Real y2;
algorithm
  n := size(table, 1);

  if n <= 1 then
    y := table[1, icol];

  else
    // Search interval

    if u <= table[1, 1] then
      i := 1;

    else
      i := 2;
      // Supports duplicate table[i, 1] values
      // in the interior to allow discontinuities.
      // Interior means that
      // if table[i, 1] = table[i+1, 1] we require i>1 and i+1<n

      while i < n and u >= table[i, 1] loop
        i := i + 1;

      end while;
      i := i - 1;

    end if;

    // Get interpolation data
    u1 := table[i, 1];
    u2 := table[i + 1, 1];
    y1 := table[i, icol];
    y2 := table[i + 1, icol];

    assert(u2 > u1, "Table index must be increasing");
    // Interpolate
    y := y1 + (y2 - y1)*(u - u1)/(u2 - u1);

  end if;

  annotation (Documentation(info="<html>

</html>"));
end tempInterpol1;

function tempInterpol2
  "Temporary function for vectorized linear interpolation (will be removed)"

  input Real u "input value (first column of table)";
  input Real table[:, :] "table to be interpolated";
  input Integer icol[:] "column(s) of table to be interpolated";
  output Real y[1, size(icol, 1)]
    "interpolated input value(s) (column(s) icol of table)";
protected
  Integer i;
  Integer n "number of rows of table";
  Real u1;
  Real u2;
  Real y1[1, size(icol, 1)];
  Real y2[1, size(icol, 1)];
algorithm
  n := size(table, 1);

  if n <= 1 then
    y := transpose([table[1, icol]]);

  else
    // Search interval

    if u <= table[1, 1] then
      i := 1;

    else
      i := 2;
      // Supports duplicate table[i, 1] values
      // in the interior to allow discontinuities.
      // Interior means that
      // if table[i, 1] = table[i+1, 1] we require i>1 and i+1<n

      while i < n and u >= table[i, 1] loop
        i := i + 1;

      end while;
      i := i - 1;

    end if;

    // Get interpolation data
    u1 := table[i, 1];
    u2 := table[i + 1, 1];
    y1 := transpose([table[i, icol]]);
    y2 := transpose([table[i + 1, icol]]);

    assert(u2 > u1, "Table index must be increasing");
    // Interpolate
    y := y1 + (y2 - y1)*(u - u1)/(u2 - u1);

  end if;

  annotation (Documentation(info="<html>

</html>"));
end tempInterpol2;

annotation (
  Invisible=true,
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={Text(
        extent={{-59,-9},{42,-56}},
        lineColor={0,0,0},
        textString="f(x)")}),
  Documentation(info="<HTML>
<p>
This package contains <b>basic mathematical functions</b> (such as sin(..)),
as well as functions operating on
<a href=\"modelica://Modelica.Math.Vectors\">vectors</a>,
<a href=\"modelica://Modelica.Math.Matrices\">matrices</a>,
<a href=\"modelica://Modelica.Math.Nonlinear\">nonlinear functions</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors\">Boolean vectors</a>.
</p>

<dl>
<dt><b>Main Authors:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
    Marcus Baur<br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>

<p>
Copyright &copy; 1998-2010, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Function tempInterpol2 added.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Icons for icon and diagram level introduced.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</html>"));
end Math;
