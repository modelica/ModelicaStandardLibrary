within Modelica;
package Math "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
import SI = Modelica.SIunits;


extends Modelica.Icons.Library2;


package Vectors "Library of functions operating on vectors"
  extends Modelica.Icons.Library;

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
</p>Modelica.Utilities.Strings.isEqual
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
<a href=\"Modelica://Modelica.Math.Matrices.isEqual\">Matrices.isEqual</a>,
<a href=\"Modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
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
<IMG SRC=\"../Images/Math/vectorNorm.png\" ALT=\"function Vectors.norm\">
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
<a href=\"Modelica://Modelica.Math.Matrices.norm\">Matrices.norm</a>
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
<a href=\"Modelica://Modelica.Math.Vectors.norm\">Vectors.norm</a>
</html>"));
  end length;

  function normalize
    "Return normalized vector such that length = 1Return normalized vector such that length = 1 and prevent zero-division for zero vector"
    extends Modelica.Icons.Function;
    input Real v[:] "Vector";
    input Real eps = 100*Modelica.Constants.eps
      "if |v| < eps then result = v/eps";
    output Real result[size(v, 1)] "Input vector v normalized to length=1";

  algorithm
    result := smooth(0,if length(v) >= eps then v/length(v) else v/eps);
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
<a href=\"Modelica://Modelica.Math.Vectors.length\">Vectors.length</a>
</html>"));
  end normalize;

  function reverse "Reverse vector elements (e.g. v[1] becomes last element)"
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
  annotation (
    preferedView = "info",
    Documentation(info="<HTML>
<h4>Library content</h4>
<p>
This library provides functions operating on vectors:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><i>Function</i></th>
      <th><i>Description</i></th>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Vectors.isEqual\">isEqual</a>(v1, v2)</td>
      <td valign=\"top\">Determines whether two vectors have the same size and elements</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Vectors.norm\">norm</a>(v,p)</td>
      <td valign=\"top\">p-norm of vector v</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Vectors.length\">length</a>(v)</td>
      <td valign=\"top\">Length of vector v (= norm(v,2), but inlined and therefore usable in
          symbolic manipulations) </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Vectors.normalize\">normalize</a>(v)</td>
      <td valign=\"top\">Return normalized vector such that length = 1 and prevent
          zero-division for zero vector</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Vectors.reverse\">reverse</a>(v)</td>
      <td valign=\"top\">Reverse vector elements</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Vectors.sort\">sort</a>(v)</td>
      <td valign=\"top\">Sort elements of vector in ascending or descending order</td>
  </tr>
</table>
<h4>See also</h4>
<a href=\"Modelica://Modelica.Math.Matrices\">Matrices</a>
</HTML>"));
end Vectors;


package Matrices "Library of functions operating on matrices"

  extends Modelica.Icons.Library;

    // illegal use of top-level annotation removed:
    // version="0.8.1", versionDate="2004-08-21",

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
<a href=\"Modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>,
<a href=\"Modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
</HTML>"));
  end isEqual;

  function norm "Returns the norm of a matrix"
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
p-norm of matrix A. The only allowed values for p are</p>
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
</HTML>"));
  end norm;

  function sort
    "Sort rows or columns of matrix in ascending or descending order"
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
an exception is raised.
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
<a href=\"Modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"Modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>
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
an exception is raised.
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
<a href=\"Modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"Modelica://Modelica.Math.Matrices.LU_solve2\">Matrices.LU_solve2</a>
</HTML>"));
  end solve2;

  function leastSquares
    "Solve overdetermined or underdetermined real system of linear equations A*x=b in a least squares sense (A may be rank deficient)"
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix A";
    input Real b[size(A, 1)] "Vector b";
    output Real x[size(A, 2)]
      "Vector x such that min|A*x-b|^2 if size(A,1) >= size(A,2) or min|x|^2 and A*x=b, if size(A,1) < size(A,2)";

  protected
    Integer info;
    Integer rank;
    Real xx[max(size(A,1),size(A,2))];
  algorithm
    (xx,info,rank) := LAPACK.dgelsx_vec(A, b, 100*Modelica.Constants.eps);
    x := xx[1:size(A,2)];
    assert(info == 0, "Solving an overdetermined or underdetermined linear system of
equations with function \"Matrices.leastSquares\" failed.");
    annotation (
      Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
x = Matrices.<b>leastSquares</b>(A,b);
</pre></blockquote>
<h4>Description</h4>
<p>
A linear system of equations A*x = b has no solutions or infinitely
many solutions if A is not square. Function \"leastSquares\" returns
a solution in a least squarse sense:
</p>
<pre>
  size(A,1) &gt; size(A,2):  returns x such that |A*x - b|^2 is a minimum
  size(A,1) = size(A,2):  returns x such that A*x = b
  size(A,1) &lt; size(A,2):  returns x such that |x|^2 is a minimum for all
                          vectors x that fulfill A*x = b
</pre>
<p>
Note, the solution is computed with the LAPACK function \"dgelsx\",
i.e., QR or LQ factorization of A with column pivoting.
If A does not have full rank,
the solution is not unique and from the infinitely many solutions
the one is selected that minimizes both |x|^2 and |A*x - b|^2.
</p>
</HTML>"));
  end leastSquares;

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
    external "FORTRAN 77" dgetrf(size(A, 1), size(A, 2), LU, size(A, 1), pivots, info)
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
<a href=\"Modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
this decomposition can be used to solve
linear systems (<b>P</b>*<b>L</b>*<b>U</b>)*<b>x</b> = <b>b</b> with different right
hand side vectors <b>b</b>. If a linear system of equations with
just one right hand side vector <b>b</b> shall be solved, it is
more convenient to just use the function
<a href=\"Modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>.
</p>
<p>
The optional third (Integer) output argument has the following meaning:
<table border=0 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\">info = 0:</td
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
<a href=\"Modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
<a href=\"Modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>,
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
<a href=\"Modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a> that
returns arguments <code>LU</code> and <code>pivots</code>
used as input arguments of <code>Matrices.LU_solve</code>.
With <code>Matrices.LU</code> and <code>Matrices.LU_solve</code>
it is possible to efficiently solve linear systems
with different right hand side vectors. If a linear system of equations with
just one right hand side vector shall be solved, it is
more convenient to just use the function
<a href=\"Modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>.
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
<a href=\"Modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"Modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>,
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
<a href=\"Modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a> that
returns arguments <code>LU</code> and <code>pivots</code>
used as input arguments of <code>Matrices.LU_solve2</code>.
With <code>Matrices.LU</code> and <code>Matrices.LU_solve2</code>
it is possible to efficiently solve linear systems
with different right hand side <b>matrices</b>. If a linear system of equations with
just one right hand side matrix shall be solved, it is
more convenient to just use the function
<a href=\"Modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>.
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
<a href=\"Modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"Modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>,
</HTML>"));
  end LU_solve2;

  function QR
    "QR decomposition of a square matrix with column pivoting (A(:,p) = Q*R)"

    extends Modelica.Icons.Function;
    input Real A[:, :] "Rectangular matrix with size(A,1) >= size(A,2)";
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
    (Q,tau,p) := LAPACK.dgeqpf(A);

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

  function eigenValues
    "Compute eigenvalues and eigenvectors for a real, nonsymmetric matrix"

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
<a href=\"Modelica://Modelica.Math.Matrices.eigenValueMatrix\">Matrices.eigenValueMatrix</a>,
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
<a href=\"Modelica://Modelica.Math.Matrices.eigenValueMatrix\">Matrices.eigenValueMatrix</a>,
<a href=\"Modelica://Modelica.Math.Matrices.singularValues\">Matrices.singularValues</a>
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
<a href=\"Modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>).
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
<a href=\"Modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>
</HTML>"));
  end eigenValueMatrix;

  function singularValues
    "Compute singular values and left and right singular vectors"
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
in vector <tt>sigma</tt> and the orthogonal matrices in
matrices <tt>U</tt> and <tt>V</tt>.
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
<a href=\"Modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>
</HTML>"));
  end singularValues;

  function det "Determinant of a matrix (computed by LU decomposition)"

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
    annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>det</b>(A);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the determinant of matrix A
computed by a LU decomposition.
Usally, this function should never be used, because
there are nearly always better numerical algorithms
as by computing the determinant. E.g., use function
<a href=\"Modelica://Modelica.Math.Matrices.rank\">Matrices.rank</a>
to compute the rank of a matrix.
<h4>See also</h4>
<a href=\"Modelica://Modelica.Math.Matrices.rank\">Matrices.rank</a>,
<a href=\"Modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
</HTML>"));
  end det;

  function inv
    "Inverse of a matrix (try to avoid, use function solve(..) instead)"
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

</html>"));
  end inv;

  function rank "Rank of a matrix (computed with singular values)"
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

</html>"));
  end rank;

  function balance "Balancing of matrix A to improve the condition of A"
    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)];
    output Real D[size(A, 1)] "diagonal(D)=T is transformation matrix, such that
          T*A*inv(T) has smaller condition as A";
    output Real B[size(A, 1), size(A, 1)]
      "Balanced matrix (= diagonal(D)*A*inv(diagonal(D)))";
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
<p>
The function transformates the matrix A, so that the norm of the i-th column
is nearby the i-th row. (D,B)=Matrices.balance(A) returns a vector D, such
that B=inv(diagonal(D))*A*diagonal(D) has better condition. The elements of D
are multiples of 2. Balancing attempts to make the norm of each row equal to the
norm of the belonging column. <br>
Balancing is used to minimize roundoff errors inducted
through large matrix calculations like Taylor-series approximation
or computation of eigenvalues.
</p>
<b>Example:</b><br><br>
<pre>       - A = [1, 10,  1000; .01,  0,  10; .005,  .01,  10]
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

  function exp
    "Compute the exponential of a matrix by adaptive Taylor series expansion with scaling and balancing"

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
<p>This function computes</p>
<pre>                            (<b>A</b>T)^2   (<b>A</b>T)^3
     <font size=4> <b>&Phi;</b></font> = e^(<b>A</b>T) = <b>I</b> + <b>A</b>T + ------ + ------ + ....
                              2!       3!
</pre>
<p>where e=2.71828..., <b>A</b> is an n x n matrix with real elements and T is a real number,
e.g., the sampling time.
<b>A</b> may be singular. With the exponential of a matrix it is, e.g., possible
to compute the solution of a linear system of differential equations</p>
<pre>    der(<b>x</b>) = <b>A</b>*<b>x</b>   ->   <b>x</b>(t0 + T) = e^(<b>A</b>T)*x(t0)
</pre>
<p>
The function is called as
<pre>     Phi = Matrices.exp(A,T);</pre>
or
<pre>       M = Matrices.exp(A);
</pre>
what calculates M as the exponential of matrix A.
</p>
<p><b>Algorithmic details:</b></p>
<p>The algorithm is taken from </p>
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
    "Computation of the transition-matrix phi and its integral gamma"

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
simple <b>&Psi;</b>*B.
</p>
<p>The algorithm runs in the following steps: </p>
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
                           T: scalar, e.g. sampling time
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
    "Computation of the transition-matrix phi and the integral gamma and gamma1"

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
<p>
The function calculates the matrices phi,gamma,gamma1 through the equation:
</p>
<pre>                                 [ A B 0 ]
[phi gamma gamma1] = [I 0 0]*exp([ 0 0 I ]*T)
                                 [ 0 0 0 ]
</pre>
<pre>
<b>Syntax:</b><br>
      (phi,gamma,gamma1) = Matrices.ExpIntegral2(A,B,T)
                     A,phi: [n,n] square matrices
            B,gamma,gamma1: [n,m] matrices
                         T: scalar, e.g. sampling time
</pre>
<p>
The matrices define the discretized first-order-hold equivalent of
a state-space system:
<pre>      x(k+1) = phi*x(k) + gamma*u(k) + gamma1/T*(u(k+1) - u(k))
</pre>
The first-order-hold sampling, also known as ramp-invariant method, gives
more smooth control signals as the ZOH equivalent. First-order-hold sampling
is discribed in
<dl>
<dt>K. J. Astroem, B. Wittenmark:
<dd><b>Computer Controlled Systems - Theory and Design</b><br>
    Third Edition, p. 256
</dl>
</p>

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
  package LAPACK
    "Interface to LAPACK library (should usually not directly be used but only indirectly via Modelica.Math.Matrices)"
    extends Modelica.Icons.Library;

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
Computations\", by G. Golub & C. van Loan (Johns Hopkins U. Press)
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

    function dgesv
      "Solve real system of linear equations A*X=B with a B matrix"
      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      input Real B[size(A, 1), :];
      output Real X[size(A, 1), size(B, 2)]=B;
      output Integer info;
    protected
      Real Awork[size(A, 1), size(A, 1)]=A;
      Integer ipiv[size(A, 1)];

    external "FORTRAN 77" dgesv(size(A, 1), size(B, 2), Awork, size(A, 1), ipiv,
         X, size(A, 1), info) annotation (Library="Lapack");
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
      Integer ipiv[size(A, 1)];

    external "FORTRAN 77" dgesv(size(A, 1), 1, Awork, size(A, 1), ipiv, x, size(
        A, 1), info) annotation (Library="Lapack");
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

    external "FORTRAN 77" dgetrf(size(A, 1), size(A, 2), LU, size(A, 1), pivots,
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

    protected
        Real work[size(LU, 1), size(LU, 1)]=LU;
        Integer info;
      external "FORTRAN 77" dgetrs("N", size(LU, 1), size(B,2), work, size(LU, 1), pivots,
           X, size(B, 1), info) annotation (Library="Lapack");
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

    protected
      Real work[size(LU, 1), size(LU, 1)]=LU;
      Integer info;
    external "FORTRAN 77" dgetrs("N", size(LU, 1), 1, work, size(LU, 1), pivots,
         x, size(b, 1), info) annotation (Library="Lapack");
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

    protected
      Integer lwork=min(10, size(LU, 1))*size(LU, 1) "Length of work array";
      Real work[lwork];
      Integer info;
    external "FORTRAN 77" dgetri(size(LU, 1), inv, size(LU, 1), pivots, work,
        lwork, info) annotation (Library="Lapack");
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

    protected
      Integer info;
      Integer ncol=size(A, 2) "Column dimension of A";
      Real work[3*ncol] "work array";
    external "FORTRAN 77" dgeqpf(size(A, 1), ncol, QR, size(A, 1), p, tau, work,
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

    protected
      Integer info;
      Integer lwork=min(10, size(QR, 2))*size(QR, 2) "Length of work array";
      Real work[lwork];
    external "FORTRAN 77" dorgqr(size(QR, 1), size(QR, 2), size(tau, 1), Q,
        size(Q, 1), tau, work, lwork, info) annotation (Library={"Lapack"});
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
      annotation (Documentation(info="<html>
<p>
This package contains external Modelica functions as interface to the
LAPACK library
(<a href=\"http://www.netlib.org/lapack\">http://www.netlib.org/lapack</a>)
that provides FORTRAN subroutines to solve linear algebra
tasks. Usually, these functions are not directly called, but only via
the much more convenient interface of
<a href=\"Modelica://Modelica.Math.Matrices\">Modelica.Math.Matrices</a>.
The documentation of the LAPACK functions is a copy of the original
FORTRAN code.
</p>

<p>
The details of LAPACK are described in:
</p>

<dl>
<dt>Anderson E., Bai Z., Bischof C., Blackford S., Demmel J., Dongarra J.,
    Du Croz J., Greenbaum A., Hammarling S., McKenney A., and Sorensen D.:</dt>
<dd> <b>Lapack Users' Guide</b>.
     Third Edition, SIAM, 1999.</dd>
</dl>

<p>
This package contains a direct interface to the LAPACK subroutines
</p>

</html>"));
  end LAPACK;

  annotation (
    Documentation(info="<HTML>
<h4>Library content</h4>
<p>
This library provides functions operating on matrices:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><i>Function</i></th>
      <th><i>Description</i></th>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.isEqual\">isEqual</a>(M1, M2)</td>
      <td valign=\"top\">Determines whether two matrices have the same size and elements</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.norm\">norm</a>(A)</td>
      <td valign=\"top\">1-, 2- and infinity-norm of matrix A</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.sort\">sort</a>(M)</td>
      <td valign=\"top\">Sort rows or columns of matrix in ascending or descending order</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.solve\">solve</a>(A,b)</td>
      <td valign=\"top\">Solve real system of linear equations A*x=b with a b vector</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.solve2\">solve2</a>(A,B)</td>
      <td valign=\"top\">Solve real system of linear equations A*X=B with a B matrix</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.leastSquares\">leastSquares</a>(A,b)</td>
      <td valign=\"top\">Solve overdetermined or underdetermined real system of <br>
          linear equations A*x=b in a least squares sense</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.equalityLeastSquares\">equalityLeastSquares</a>(A,a,B,b)</td>
      <td valign=\"top\">Solve a linear equality constrained least squares problem:<br>
          min|A*x-a|^2 subject to B*x=b</td>
  </tr>
  <tr><td valign=\"top\">(LU,p,info) = <a href=\"Modelica://Modelica.Math.Matrices.LU\">LU</a>(A)</td>
      <td valign=\"top\">LU decomposition of square or rectangular matrix</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.LU_solve\">LU_solve</a>(LU,p,b)</td>
      <td valign=\"top\">Solve real system of linear equations P*L*U*x=b with a<br>
          b vector and an LU decomposition from \"LU(..)\"</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.LU_solve2\">LU_solve2</a>(LU,p,B)</td>
      <td valign=\"top\">Solve real system of linear equations P*L*U*X=B with a<br>
          B matrix and an LU decomposition from \"LU(..)\"</td>
  </tr>
  <tr><td valign=\"top\">(Q,R,p) = <a href=\"Modelica://Modelica.Math.Matrices.QR\">QR</a>(A)</td>
      <td valign=\"top\"> QR decomposition with column pivoting of rectangular matrix (Q*R = A[:,p]) </td>
  </tr>
  <tr><td valign=\"top\">eval = <a href=\"Modelica://Modelica.Math.Matrices.eigenValues\">eigenValues</a>(A)<br>
          (eval,evec) = <a href=\"Modelica://Modelica.Math.Matrices.eigenValues\">eigenValues</a>(A)</td>
      <td valign=\"top\"> Compute eigenvalues and optionally eigenvectors<br>
           for a real, nonsymmetric matrix </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.eigenValueMatrix\">eigenValueMatrix</a>(eigen)</td>
      <td valign=\"top\"> Return real valued block diagonal matrix J of eigenvalues of
            matrix A (A=V*J*Vinv) </td>
  </tr>
  <tr><td valign=\"top\">sigma = <a href=\"Modelica://Modelica.Math.Matrices.singularValues\">singularValues</a>(A)<br>
      (sigma,U,VT) = <a href=\"Modelica://Modelica.Math.Matrices.singularValues\">singularValues</a>(A)</td>
      <td valign=\"top\"> Compute singular values and optionally left and right singular vectors </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.det\">det</a>(A)</td>
      <td valign=\"top\"> Determinant of a matrix (do <b>not</b> use; use rank(..))</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.inv\">inv</a>(A)</td>
      <td valign=\"top\"> Inverse of a matrix </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.rank\">rank</a>(A)</td>
      <td valign=\"top\"> Rank of a matrix </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.balance\">balance</a>(A)</td>
      <td valign=\"top\">Balance a square matrix to improve the condition</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices.exp\">exp</a>(A)</td>
      <td valign=\"top\"> Compute the exponential of a matrix by adaptive Taylor series<br>
           expansion with scaling and balancing</td>
  </tr>
  <tr><td valign=\"top\">(P, G) = <a href=\"Modelica://Modelica.Math.Matrices.integralExp\">integralExp</a>(A,B)</td>
      <td valign=\"top\"> Compute the exponential of a matrix and its integral</td>
  </tr>
  <tr><td valign=\"top\">(P, G, GT) = <a href=\"Modelica://Modelica.Math.Matrices.integralExpT\">integralExpT</a>(A,B)</td>
      <td valign=\"top\"> Compute the exponential of a matrix and two integrals</td>
  </tr>
</table>

<p>
Most functions are solely an interface to the external LAPACK library
(<a href=\"http://www.netlib.org/lapack\">http://www.netlib.org/lapack</a>).
The details of this library are described in:
</p>

<dl>
<dt>Anderson E., Bai Z., Bischof C., Blackford S., Demmel J., Dongarra J.,
    Du Croz J., Greenbaum A., Hammarling S., McKenney A., and Sorensen D.:</dt>
<dd> <b>Lapack Users' Guide</b>.
     Third Edition, SIAM, 1999.</dd>
</dl>

<h4>See also</h4>
<a href=\"Modelica://Modelica.Math.Vectors\">Vectors</a>

</HTML>
"));
end Matrices;


function sin "Sine"
  extends baseIcon1;
  input SI.Angle u;
  output Real y;

external "C" y = sin(u);
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
<img src=\"../Images/Math/sin.png\">
</p>
</html>"), Library="ModelicaExternalC");
end sin;


function cos "Cosine"
  extends baseIcon1;
  input SI.Angle u;
  output Real y;

external "C" y = cos(u);
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
<img src=\"../Images/Math/cos.png\">
</p>
</html>"), Library="ModelicaExternalC");
end cos;


function tan "Tangent (u shall not be -pi/2, pi/2, 3*pi/2, ...)"
  extends baseIcon2;
  input SI.Angle u;
  output Real y;

external "C" y = tan(u);
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
<img src=\"../Images/Math/tan.png\">
</p>
</html>"), Library="ModelicaExternalC");
end tan;


function asin "Inverse sine (-1 <= u <= 1)"
  extends baseIcon2;
  input Real u;
  output SI.Angle y;

external "C" y = asin(u);
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
<img src=\"../Images/Math/asin.png\">
</p>
</html>"), Library="ModelicaExternalC");
end asin;


function acos "Inverse cosine (-1 <= u <= 1)"
  extends baseIcon2;
  input Real u;
  output SI.Angle y;

external "C" y = acos(u);
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
<img src=\"../Images/Math/acos.png\">
</p>
</html>"), Library="ModelicaExternalC");
end acos;


function atan "Inverse tangent"
  extends baseIcon2;
  input Real u;
  output SI.Angle y;

external "C" y = atan(u);
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
<img src=\"../Images/Math/atan.png\">
</p>
</html>"), Library="ModelicaExternalC");
end atan;


function atan2 "Four quadrant inverse tangent"
  extends baseIcon2;
  input Real u1;
  input Real u2;
  output SI.Angle y;

external "C" y = atan2(u1, u2);
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
<img src=\"../Images/Math/atan2.png\">
</p>

</HTML>
"),        Library="ModelicaExternalC");
end atan2;


function atan3
  "Four quadrant inverse tangens (select solution that is closest to given angle y0)"
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
<img src=\"../Images/Math/atan3.png\">
</p>

</HTML>
"));
end atan3;


function sinh "Hyperbolic sine"
  extends baseIcon2;
  input Real u;
  output Real y;

external "C" y = sinh(u);
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
<img src=\"../Images/Math/sinh.png\">
</p>
</html>"), Library="ModelicaExternalC");
end sinh;


function cosh "Hyperbolic cosine"
  extends baseIcon2;
  input Real u;
  output Real y;

external "C" y = cosh(u);
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
<img src=\"../Images/Math/cosh.png\">
</p>
</html>"), Library="ModelicaExternalC");
end cosh;


function tanh "Hyperbolic tangent"
  extends baseIcon2;
  input Real u;
  output Real y;

external "C" y = tanh(u);
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
<img src=\"../Images/Math/tanh.png\">
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
<img src=\"../Images/Math/asinh.png\">
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
<img src=\"../Images/Math/acosh.png\">
</p>
</html>"));
end acosh;


function exp "Exponential, base e"
  extends baseIcon2;
  input Real u;
  output Real y;

external "C" y = exp(u);
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
<img src=\"../Images/Math/exp.png\">
</p>
</html>"), Library="ModelicaExternalC");
end exp;


function log "Natural (base e) logarithm (u shall be > 0)"
  extends baseIcon1;
  input Real u;
  output Real y;

external "C" y = log(u);
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
<img src=\"../Images/Math/log.png\">
</p>
</html>"), Library="ModelicaExternalC");
end log;


function log10 "Base 10 logarithm (u shall be > 0)"
  extends baseIcon1;
  input Real u;
  output Real y;

external "C" y = log10(u);
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
<img src=\"../Images/Math/log10.png\">
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
        coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
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
          lineColor={0,0,255})}),                          Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
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
    Documentation(revisions="<html>
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
as well as functions operating on <b>vectors</b> and <b>matrices</b>.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>

<p>
Copyright &copy; 1998-2009, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
</p><br>
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
