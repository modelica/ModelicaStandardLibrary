package Matrices "Functions on matrices" 
  
  extends Modelica.Icons.Library;
  
  annotation (preferedView="info",
    version="0.8.1",
    versionDate="2004-08-21",
    Window(
      x=0.24,
      y=0.32,
      width=0.35,
      height=0.49,
      library=1,
      autolayout=1),
    Documentation(info="<HTML>
<h3><font color=\"#008000\">Library content</font></h3>
<p>
This library provides functions operating on matrices:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><i>Function</i></th>
      <th><i>Description</i></th>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.norm\">norm</a>(A)</td>
      <td>1-, 2- and infinity-norm of matrix A</td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.isEqual\">isEqual</a>(M1, M2)</td>
      <td>determines whether two matrices have the same size and elements</td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.solve\">solve</a>(A,b)</td>
      <td>Solve real system of linear equations A*x=b with a b vector</td>
  </tr>
  <tr><td>(LU,p,info) = <a href=\"Modelica:Modelica.Matrices.LU\">LU</a>(A)</td>
      <td>LU decomposition of square or rectangular matrix</td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.LU_solve\">LU_solve</a>(LU,p,b)</td>
      <td>Solve real system of linear equations P*L*U*x=b with a
          b vector and an LU decomposition from \"LU(..)\"</td>
  </tr>
  <tr><td>(Q,R,p) = <a href=\"Modelica:Modelica.Matrices.QR\">QR</a>(A)</td>
      <td> QR decomposition with column pivoting (A(:,p) = Q*R) </td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.eigenValues\">eigenValues</a>(A)</td>
      <td> compute eigenvalues and optionally eigenvectors<br>
           for a real, nonsymmetric matrix </td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.eigenValueMatrix\">eigenValueMatrix</a>(eigen)</td>
      <td> return real valued block diagonal matrix J of eigenvalues of 
            matrix A (A=V*J*Vinv) </td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.singularValues\">singularValues</a>(A)</td>
      <td> determine singular values </td>
  </tr>
  <tr><td>(U,Sigma,VT) = <a href=\"Modelica:Modelica.Matrices.svd\">svd</a>(A)</td>
      <td> singular value decomposition (A = U*Sigma*VT) </td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.det\">det</a>(A)</td>
      <td> determinant of a matrix </td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.inv\">inv</a>(A)</td>
      <td> inverse of a matrix </td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.rank\">rank</a>(A)</td>
      <td> rank of a matrix </td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.balance\">balance</a>(A)</td>
      <td>balance a square matrix to improve the condition</td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Matrices.exp\">exp</a>(A)</td>
      <td> compute the exponential of a matrix by adaptive Taylor series 
           expansion with scaling and balancing</td>
  </tr>
  <tr><td>(P, G) = <a href=\"Modelica:Modelica.Matrices.integralExp\">integralExp</a>(A,B)</td>
      <td> compute the exponential of a matrix and its integral</td>
  </tr>
  <tr><td>(P, G, GT) = <a href=\"Modelica:Modelica.Matrices.integralExpT\">integralExpT</a>(A,B)</td>
      <td> compute the exponential of a matrix and two integrals</td>
  </tr>
</table>
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Vectors\">Vectors</a>, 
</HTML>
"));
  
  function norm "Returns the norm of a matrix" 
    extends Modelica.Icons.Function;
    input Real A[:, :] "Input matrix";
    input Real p(min=1) = 2 
      "Type of p-norm (only allowed: 1, 2 or Modelica.Constants.inf)";
    output Real result=0.0 "p-norm of matrix A";
    
    annotation (preferedView="info", Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Matrices.<b>norm</b>(A);
Matrices.<b>norm</b>(A, p=2);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
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
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Vectors.norm\">Vectors.norm</a>
</HTML>"));
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
  end norm;
  
  function isEqual "Compare whether two Real matrices are identical" 
    extends Modelica.Icons.Function;
    input Real M1[:, :] "First matrix";
    input Real M2[:, :] "Second matrix (may have different size as M1";
    input Real eps(min=0) = 0 
      "Two elements e1 and e2 of the two matrices are identical if abs(e1-e2) <= eps";
    output Boolean result 
      "= true, if matrices have the same size and the same elements";
    annotation (preferedView="info", Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Matrices.<b>isEqual</b>(M1, M2);
Matrices.<b>isEqual</b>(M1, M2, eps=0);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
The function call \"<code>Matrices.isEqual(M1, M2)</code>\" returns <b>true</b>, 
if the two Real matrices M1 and M2 have the same dimensions and 
the same elements. Otherwise the function
returns <b>false</b>. Two elements e1 and e2 of the two matrices
are checked on equality by the test \"abs(e1-e2) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h3><font color=\"#008000\">Example</font></h3>
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
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Vectors.isEqual\">Vectors.isEqual</a>, 
<a href=\"Modelica:Modelica.Strings.isEqual\">Strings.isEqual</a>
</HTML>"));
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
    
  end isEqual;
  
  function solve 
    "Solve real system of linear equations A*x=b with a b vector (Gaussian elemination with partial pivoting)" 
    
    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "Matrix A of A*x = b";
    input Real b[size(A, 1)] "Vector b of A*x = b";
    output Real x[size(b, 1)] "Vector x such that A*x = b";
    annotation (preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6),
      Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Matrices.<b>solve</b>(A,b);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
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
<h3><font color=\"#008000\">Example</font></h3>
<blockquote><pre>
  Real A[3,3] = [1,2,3; 
                 3,4,5;
                 2,1,4];
  Real b[3] = {10,22,12};
  Real x[3];
<b>algorithm</b>
  x := Matrices.solve(A,b);  // x = {3,2,1}
</pre></blockquote>
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Matrices.LU\">Matrices.LU</a>,
<a href=\"Modelica:Modelica.Matrices.LU_solve\">Matrices.LU_solve</a>
</HTML>"));
  protected 
    Integer info;
  algorithm 
    (x,info) := LAPACK.dgesv_vec(A, b);
    assert(info == 0, "Solving a linear system of equations with function
\"Matrices.solve\" is not possible, since matrix A 
is singular, i.e., no unique solution exists.");
  end solve;
  
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
    annotation (preferedView="info", Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
(LU, pivots)       = Matrices.<b>LU</b>(A);
(LU, pivots, info) = Matrices.<b>LU</b>(A);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
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
<a href=\"Modelica:Modelica.Matrices.LU_solve\">Matrices.LU_solve</a>,
this decomposition can be used to solve
linear systems (<b>P</b>*<b>L</b>*<b>U</b>)*<b>x</b> = <b>b</b> with different right
hand side vectors <b>b</b>. If a linear system of equations with
just one right hand side vector <b>b</b> shall be solved, it is
more convenient to just use the function
<a href=\"Modelica:Modelica.Matrices.solve\">Matrices.solve</a>.
</p>
<p>
The optional third (Integer) output argument has the following meaning:
<table border=0 cellspacing=0 cellpadding=2>
  <tr><td>info = 0:</td
      <td>successful exit</td></tr>
  <tr><td>info &gt; 0:</td>
      <td>if info = i, U[i,i] is exactly zero. The factorization
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
<h3><font color=\"#008000\">Example</font></h3>
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
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Matrices.LU_solve\">Matrices.LU_solve</a>, 
<a href=\"Modelica:Modelica.Matrices.solve\">Matrices.solve</a>,
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
    
    annotation (preferedView="info", Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Matrices.<b>LU_solve</b>(LU, pivots, b);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
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
<a href=\"Modelica:Modelica.Matrices.LU\">Matrices.LU</a> that
returns arguments <code>LU</code> and <code>pivots</code>
used as input arguments of <code>Matrices.LU_solve</code>.
With <code>Matrices.LU</code> and <code>Matrices.LU_solve</code>
it is possible to efficiently solve linear systems
with different right hand side vectors. If a linear system of equations with
just one right hand side vector shall be solved, it is
more convenient to just use the function
<a href=\"Modelica:Modelica.Matrices.solve\">Matrices.solve</a>.
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
<h3><font color=\"#008000\">Example</font></h3>
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
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Matrices.LU\">Matrices.LU</a>, 
<a href=\"Modelica:Modelica.Matrices.solve\">Matrices.solve</a>,
</HTML>"));
  algorithm 
    for i in 1:size(LU,1) loop
         assert(LU[i,i] <> 0, "Solving a linear system of equations with function
\"Matrices.LU_solve\" is not possible, since the LU decomposition
is singular, i.e., no unique solution exists.");
    end for;
    x := LAPACK.dgetrs_vec(LU, pivots, b);
  end LU_solve;
  
  function QR 
    "QR decomposition of a square matrix with column pivoting (A(:,p) = Q*R)" 
    
    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "Square matrix";
    output Real Q[size(A, 1), size(A, 1)] "Orthogonal matrix";
    output Real R[size(A, 1), size(A, 2)] "Upper triangular matrix";
    output Integer p[size(A, 2)] "Column permutation vector";
    annotation (preferedView="info", Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
(Q,R,p) = Matrices.<b>QR</b>(A);
 (,R,p) = Matrices.<b>QR</b>(A);
 (,R)   = Matrices.<b>QR</b>(A);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function call returns the QR decomposition of
a square matrix <b>A</b>:
</p>
<blockquote>
<p>
<b>Q</b>*<b>R</b> = <b>A</b>[:,<b>p</b>]
</p>
</blockquote>
<p>
where <b>Q</b> is an orthogonal matrix (<b>QQ</b><sup>T</sup>=<b>I</b>),
<b>R</b> is an upper triangular matrix and <b>p</b> is a permutation
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
<h3><font color=\"#008000\">Example</font></h3>
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
  protected 
    Integer nrow=size(A, 1);
    Integer ncol=size(A, 2);
    Real tau[min(nrow, ncol)];
  algorithm 
    (R,tau,p) := LAPACK.dgeqpf(A);
    for j in 1:ncol loop
      for i in j + 1:nrow loop
        R[i, j] := 0.0;
      end for;
    end for;
    // if isPresent(Q) then (not yet supported by Dymola)
    Q := LAPACK.dorgqr(R, tau);
  end QR;
  
  function eigenValues 
    "Compute eigenvalues and eigenvectors for a real, nonsymmetric matrix" 
    
    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "Matrix";
    output Real eigenvalues[size(A, 1), 2] 
      "Eigenvalues of matrix A (Re: first column, Im: second column)";
    output Real eigenvectors[size(A,1), size(A,2)] 
      "Real-valued eigenvector matrix";
    annotation (preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6),
      Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
 eval        = Matrices.<b>eigenValues</b>(A);
(eval, evec) = Matrices.<b>eigenValues</b>(A);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function call returns the eigenvalues \"eval\" and 
optionally the (right) eigenvectors \"evec\" of a square matrix 
<b>A</b>. The first column of \"eval\" contains the real and the
second column contains the imaginary part of the eigenvalues.
If the i-th eigenvalue has no imaginary part, then evec[:,i] is
the corresponding real eigenvector. If the i-th eigenvalue
has an imaginary part, then eval[i+1,:] is the conjugate complex
eigenvalue and evec[:,i] is the real and evec[:,i+1] is the
imaginary part of the eigenvector of the i-th eigenvalue.
With function 
<a href=\"Modelica:Modelica.Matrices.eigenValueMatrix\">Matrices.eigenValueMatrix</a>,
a real block diagonal matrix is constructed from the eigenvalues 
such that 
</p>
<blockquote>
<pre>
A = evec * eigenValueMatrix(eval) * inv(evec)
</pre>
</blockquote>
<p>
provided the eigenvector matrix evec can be inverted
(an inversion is possible, if all eigenvalues are different
and no eigenvalue is zero).
</p>
<h3><font color=\"#008000\">Example</font></h3>
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
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Matrices.eigenValueMatrix\">Matrices.eigenValueMatrix</a>,
<a href=\"Modelica:Modelica.Matrices.singularValues\">Matrices.singularValues</a>
</HTML>
"));
  protected 
    Integer info;
    // replace with "isPresent(..)" if supported by Dymola
    Boolean onlyEigenvalues = false;
  algorithm 
    if onlyEigenvalues then
       (eigenvalues[:, 1],eigenvalues[:, 2],info) := LAPACK.dgeev_eigenValues(A);
       eigenvectors :=zeros(size(A, 1), size(A, 1));
    else
       (eigenvalues[:, 1],eigenvalues[:, 2],eigenvectors, info) := LAPACK.dgeev(A);
    end if;
    assert(info == 0, "Calculating the eigen values with function
\"Matrices.eigenvalues\" is not possible, since the
numerical algorithm does not converge.");
  end eigenValues;
  
  function eigenValueMatrix 
    "Return real valued block diagonal matrix J of eigenvalues of matrix A (A=V*J*Vinv)" 
    
    extends Modelica.Icons.Function;
    input Real eigenValues[:, 2] 
      "Eigen values from function eigenValues(..) (Re: first column, Im: second column)";
    output Real J[size(eigenValues, 1), size(eigenValues, 1)] 
      "Real valued block diagonal matrix with eigen values (Re: 1x1 block, Im: 2x2 block)";
    annotation (preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6),
      Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Matrices.<b>eigenValueMatrix</b>(eigenvalues);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
The function call returns a block diagonal matrix <b>J</b>
from the the two-column matrix <code>eigenvalues</code>
(computed by function
<a href=\"Modelica:Modelica.Matrices.eigenValues\">Matrices.eigenValues</a>).
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
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Matrices.eigenValues\">Matrices.eigenValues</a>
</HTML>"));
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
  end eigenValueMatrix;
  
  function singularValues "Determine singular values" 
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix";
    output Real sigma[min(size(A, 1), size(A, 2))] "Singular values";
    annotation (preferedView="info", Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
sigma = Matrices.<b>singularValues</b>(A);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function computes the singular values of matrix A,
i.e., the diagonal elements of matrix
<b><font face=\"Symbol\">S</font></b> = diag(<font face=\"Symbol\">s</font><sub>i</sub>)
of the factorization
</p>
<blockquote><pre>
<b>A</b> = <b>U</b> <b><font face=\"Symbol\">S</font></b> <b>V</b><sup>T</sup>
</blockquote></pre>
<p>
with <b>U </b>and <b>V</b> orthogonal matrices (<b>UU</b><sup>T</sup>=<b>I,
</b><b>VV</b><sup>T</sup>=<b>I</b>). The singular values returned
in vector <code>sigma</code> are nonnegative Real numbers
in decreasing order (sigma[1] is the largest value).
</p>
<h3><font color=\"#008000\">Example</font></h3>
<blockquote><pre>
  A = [1, 2,  3,  4;
       3, 4,  5, -2;
      -1, 2, -3,  5];
  Matrices.singularValues(A);   // = {8.33, 6.94, 2.31}      
</pre></blockquote>
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Matrices.svd\">Matrices.svd</a>, 
<a href=\"Modelica:Modelica.Matrices.eigenValues\">Matrices.eigenValues</a>
</HTML>"));
  protected 
    Integer info;
    Integer n=min(size(A, 1), size(A, 2));
    Real sigma2[n];
  algorithm 
    (sigma2,info) := Matrices.LAPACK.dgesvd_sigma(A);
    assert(info == 0, "The numerical algorithm to compute the
singular value decomposition did not converge");
    
    /* dgesvd has the bug that when the factorization matrices
   are NOT computed then the singular values are returned
   in the opposite order. Therefore, they are reordered 
*/
    for i in 1:n loop
      sigma[i] := sigma2[n - i + 1];
    end for;
  end singularValues;
  
  function svd "Singular value decomposition (A = U*Sigma*VT)" 
    extends Modelica.Icons.Function;
    input Real A[:, :] "Matrix";
    output Real U[size(A, 1), size(A, 1)]=zeros(size(A, 1), size(A, 1)) 
      "Left orthogonal matrix";
    output Real Sigma[size(A, 1), size(A, 2)]=zeros(size(A, 1), size(A, 2)) 
      "Singular value matrix";
    output Real VT[size(A, 2), size(A, 2)]=zeros(size(A, 2), size(A, 2)) 
      "Transposed right orthogonal matrix";
    annotation (preferedView="info", Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
(U, Sigma, VT) = Matrices.<b>svd</b>(A);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function computes the singular value decomposition of matrix A,
i.e.,
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
in decreasing order and with all other elements zero. 
</p>
<h3><font color=\"#008000\">Example</font></h3>
<blockquote><pre>
  A = [1, 2,  3,  4;
       3, 4,  5, -2;
      -1, 2, -3,  5];
  (U,Sigma,VT) = svd(A);
  results in:          
     Sigma = [8.33,    0,    0, 0;
                 0, 6.94,    0, 0;
                 0,    0, 2.31, 0]
</pre></blockquote>
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Matrices.singularValues\">Matrices.singularValues</a>, 
<a href=\"Modelica:Modelica.Matrices.eigenValues\">Matrices.eigenValues</a>
</HTML>"));
  protected 
    Integer info;
    Integer n=min(size(A, 1), size(A, 2)) "Number of singular values";
    Real sigma[n] "Singular values";
  algorithm 
    (sigma,U,VT,info) := Matrices.LAPACK.dgesvd(A);
    assert(info == 0, "The numerical algorithm to compute the
singular value decomposition did not converge");
    for i in 1:n loop
      Sigma[i, i] := sigma[i];
    end for;
  end svd;
  
  function det 
    "Determinant of a matrix (computed by QR decomposition with column pivoting)" 
    
    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)];
    output Real result "Determinant of matrix A";
  protected 
    Integer n=size(A, 1) "Size of matrix A";
    Integer p[n] "Permutation vector";
    Real QR[n, n] "Packed QR matrix";
    Real tau[n];
  algorithm 
    (QR,tau,p) := LAPACK.dgeqpf(A);
    result := QR[1, 1];
    for i in 2:n loop
      result := result*QR[i, i];
    end for;
    annotation (preferedView="info", Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Matrices.<b>det</b>(A);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function call returns the determinant of matrix A
computed by QR decomposition with column pivoting.
Usally, this function should never be used, because
there are nearly always better numerical algorithms
as by computing the determinant. E.g., use function
<a href=\"Modelica:Modelica.Matrices.rank\">Matrices.rank</a>
to compute the rank of a matrix.
<h3><font color=\"#008000\">See also</font></h3>
<a href=\"Modelica:Modelica.Matrices.rank\">Matrices.rank</a>,
<a href=\"Modelica:Modelica.Matrices.solve\">Matrices.solve</a>
</HTML>"));
  end det;
  
  function inv "Inverse of a matrix" 
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
    Real sigma[n]=singularValues(A) "Singular values";
    Real eps2=max(size(A))*sigma[1]*Modelica.Constants.eps;
  algorithm 
    result := n;
    while i > 0 loop
      if sigma[i] > eps2 then
        result := i;
        i := 0;
      end if;
      i := i - 1;
    end while;
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
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
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
<p><b>Release Notes:</b></p>
<li><i>July 5, 2002</i>
       by H. D. Joos and Nico Walther<br>
       Implemented.
</li>
</HTML>
"),   Window(
        x=0.13,
        y=0.13,
        width=0.71,
        height=0.8));
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
    Boolean break=false;
    Real Anorm;
    Real Tscaled=1;
    Real Atransf[na, na];
    Real D[na, na];
    /*D: dummy variable for psi*/
    Real M[na, na];
    /*M: dummy matrix*/
    Real Diag[na];
    /*diagonal transformation matrix for balancing*/
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.12,
        y=0.06,
        width=0.61,
        height=0.8),
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
<p><b>Release Notes:</b></p>
<ul>
<li><i>July 5, 2002</i>
       by H. D. Joos and Nico Walther<br>
       Implemented.
</li>
</ul>
</HTML>
"));
  algorithm 
    // balancing of A
    (Diag,Atransf) := balance(A);
    
    // scaling of T until norm(A)*/(2^k) < 1
    Tscaled := T;
    /*Anorm: column-norm of matrix A*/
    Anorm := norm(Atransf, 1);
    Anorm := Anorm*T;
    while Anorm >= 0.5 loop
      Anorm := Anorm/2;
      Tscaled := Tscaled/2;
      k := k + 1;
    end while;
    
    // Computation of psi by Taylor-series approximation
    M := identity(na);
    D := M;
    while j < nmax and not break loop
      M := Atransf*M*Tscaled/j;
      //stop if the new element of the series is small
      if norm((D + M) - D, 1) == 0 then
        break := true;
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
    Boolean break=false;
    Real Anorm;
    Real Tscaled=1;
    Real Atransf[na, na];
    Real Psi[na, na];
    /*Psi: dummy variable for psi*/
    Real M[na, na];
    /*M: dummy matrix*/
    Real Diag[na];
    /*diagonal transformation matrix for balancing*/
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.25,
        y=0.05,
        width=0.67,
        height=0.84),
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
<p><b>Release Notes:</b></p>
<ul>
<li><i>July 5, 2002</i>
       by H. D. Joos and Nico Walther<br>
       Implemented.
</li>
</ul>
</HTML>
"));
  algorithm 
    // balancing of A
    (Diag,Atransf) := balance(A);
    
    // scaling of T until norm(A)*/(2^k) < 0.5
    Tscaled := T;
    /*Anorm: column-norm of matrix A*/
    Anorm := norm(Atransf, 1);
    Anorm := Anorm*T;
    while Anorm >= 0.5 loop
      Anorm := Anorm/2;
      Tscaled := Tscaled/2;
      k := k + 1;
    end while;
    
    // Computation of psi by Taylor-series approximation
    M := identity(na)*Tscaled;
    Psi := M;
    while j < nmax and not break loop
      M := Atransf*M*Tscaled/j;
      //stop if the new element of the series is small
      if norm((Psi + M) - Psi, 1) == 0 then
        break := true;
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
    Boolean break=false;
    Real F[na + 2*nb, na + 2*nb];
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.06,
        y=0.09,
        width=0.69,
        height=0.82),
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
<p><b>Release Notes:</b></p>
<ul>
<li><i>July 31, 2002</i>
       by Nico Walther<br>
       Realized.
</li>
</ul>
</HTML>
"));
  algorithm 
    F := [A, B, zeros(na, nb); zeros(2*nb, na), zeros(2*nb, nb), [identity(nb);
       zeros(nb, nb)]];
    F := exp(F, T);
    phi := F[1:na, 1:na];
    gamma := F[1:na, na + 1:na + nb];
    gamma1 := F[1:na, na + nb + 1:na + 2*nb];
    
  end integralExpT;
  
protected 
  package LAPACK "Interface to LAPACK library" 
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
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.25,
          y=0.3,
          width=0.6,
          height=0.6),
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
    external "Fortran 77" dgeev("N", "V", n, Awork, n, eigenReal, eigenImag,
        eigenVectors, n, eigenVectors, n, work, size(work, 1), info) 
        annotation (Library="Lapack");
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
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.25,
          y=0.3,
          width=0.6,
          height=0.6),
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
      
      /*
    external "Fortran 77" dgeev("N", "V", size(A, 1), Awork, size(A, 1), 
        EigenReal, EigenImag, EigenvectorsL, size(EigenvectorsL, 1), 
        Eigenvectors, size(Eigenvectors, 1), work, size(work, 1), info)
*/
    external "Fortran 77" dgeev("N", "N", size(A, 1), Awork, size(A, 1),
        EigenReal, EigenImag, EigenvectorsL, size(EigenvectorsL, 1),
        EigenvectorsL, size(EigenvectorsL, 1), work, size(work, 1), info) 
        annotation (Library="Lapack");
      
    end dgeev_eigenValues;
    
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
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
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
"),     Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      
    external "FORTRAN 77" dgesv(size(A, 1), size(B, 2), Awork, size(A, 1), ipiv,
         X, size(A, 1), info) annotation (Library="Lapack");
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
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Documentation(info="
Same as function LAPACK.dgesv, but right hand side is a vector and not a matrix.
For details of the arguments, see documentation of dgesv.
"),     Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      
    external "FORTRAN 77" dgesv(size(A, 1), 1, Awork, size(A, 1), ipiv, x, size(
        A, 1), info) annotation (Library="Lapack");
    end dgesv_vec;
    
    function dgesvx 
      "Solve real system of linear equations A*X=B with a B matrix, error bounds and condition estimate" 
      
      extends Modelica.Icons.Function;
      input Real A[:, size(A, 1)];
      input Real B[size(A, 1), :];
      output Real X[size(A, 1), size(B, 2)]=zeros(size(B, 1), size(B, 2));
      output Real RCond;
      output Real FErrBound;
      output Real BErrBound;
      output Integer info;
    protected 
      Real Awork[size(A, 1), size(A, 2)]=A;
      Real Bwork[size(B, 1), size(B, 2)]=B;
      Real AF[size(A, 1), size(A, 2)];
      Integer ipiv[size(A, 1)];
      String equed=StringAllocate(1);
      Real R[size(A, 1)];
      Real C[size(A, 1)];
      Real work[4*size(A, 1)];
      Integer iwork[size(A, 1)];
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Documentation(info="Lapack documentation:
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
    3. The factored form of A is used to estimate the condition number   
       of the matrix A.  If the reciprocal of the condition number is   
       less than machine precision, steps 4-6 are skipped.   
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
            If INFO = 0, the N-by-NRHS solution matrix X to the original 
  
            system of equations.  Note that A and B are modified on exit 
  
            if EQUED .ne. 'N', and the solution to the equilibrated   
            system is inv(diag(C))*X if TRANS = 'N' and EQUED = 'C' or   
            'B', or inv(diag(R))*X if TRANS = 'T' or 'C' and EQUED = 'R' 
  
            or 'B'.   
    LDX     (input) INTEGER   
            The leading dimension of the array X.  LDX >= max(1,N).   
    RCOND   (output) DOUBLE PRECISION   
            The estimate of the reciprocal condition number of the matrix 
  
            A after equilibration (if done).  If RCOND is less than the   
            machine precision (in particular, if RCOND = 0), the matrix   
            is singular to working precision.  This condition is   
            indicated by a return code of INFO > 0, and the solution and 
  
            error bounds are not computed.   
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
                         could not be computed.   
                  = N+1: RCOND is less than machine precision.  The   
                         factorization has been completed, but the   
                         matrix is singular to working precision, and   
                         the solution and error bounds have not been   
                         computed.   
"),     Window(
          x=0.34,
          y=0.06,
          width=0.6,
          height=0.6));
      
    external "FORTRAN 77" dgesvx("E", "N", size(A, 1), size(B, 2), Awork, size(
        A, 1), AF, size(A, 1), ipiv, equed, R, C, Bwork, size(B, 1), X, size(X,
         1), RCond, FErrBound, BErrBound, work, iwork, info) 
        annotation (Library="Lapack");
    end dgesvx;
    
    function dgesvx_vec 
      "Solve real system of linear equations A*x=b with a b vector, error bounds and condition estimate" 
      
      extends Modelica.Icons.Function;
      
      input Real A[:, size(A, 1)];
      input Real b[size(A, 1)];
      output Real x[size(A, 1)]=zeros(size(A, 1));
      output Real RCond;
      output Real FErrBound;
      output Real BErrBound;
      output Integer info;
    protected 
      Real Awork[size(A, 1), size(A, 2)]=A;
      Real Bwork[size(A, 1)]=b;
      Real AF[size(A, 1), size(A, 2)];
      Integer ipiv[size(A, 1)];
      String equed=StringAllocate(1);
      Real R[size(A, 1)];
      Real C[size(A, 1)];
      Real work[4*size(A, 1)];
      Integer iwork[size(A, 1)];
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Documentation(info="
Same as function LAPACK.dgesvx, but right hand side is a vector and not a matrix.
For details of the arguments, see documentation of dgesvx.
"),     Window(
          x=0.34,
          y=0.06,
          width=0.6,
          height=0.6));
      
    external "FORTRAN 77" dgesvx("E", "N", size(A, 1), 1, Awork, size(A, 1), AF,
         size(A, 1), ipiv, equed, R, C, Bwork, size(b, 1), x, size(x, 1), RCond,
         FErrBound, BErrBound, work, iwork, info) annotation (Library="Lapack");
    end dgesvx_vec;
    
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
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
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
"),     Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      
    external "FORTRAN 77" dgtsv(size(diag, 1), size(B, 2), subdiagwork,
        diagwork, superdiagwork, X, size(B, 1), info) 
        annotation (Library="Lapack");
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
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Documentation(info="
Same as function LAPACK.dgtsv, but right hand side is a vector and not a matrix.
For details of the arguments, see documentation of dgtsv.
"),     Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      
    external "FORTRAN 77" dgtsv(size(diag, 1), 1, subdiagwork, diagwork,
        superdiagwork, x, size(b, 1), info) annotation (Library="Lapack");
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
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
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
elements of U because of fill-in resulting from the row interchanges."),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      
    external "FORTRAN 77" dgbsv(n, kLower, kUpper, size(B, 2), Awork, size(
        Awork, 1), ipiv, X, n, info) annotation (Library="Lapack");
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
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Documentation(info="Lapack documentation:  
"),     Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      
    external "FORTRAN 77" dgbsv(n, kLower, kUpper, 1, Awork, size(Awork, 1),
        ipiv, x, n, info) annotation (Library="Lapack");
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
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
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
"),     Window(
          x=0.31,
          y=0.4,
          width=0.6,
          height=0.6));
      
    external "Fortran 77" dgesvd("A", "A", size(A, 1), size(A, 2), Awork, size(
        A, 1), sigma, U, size(A, 1), VT, size(A, 2), work, lwork, info) 
        annotation (Library="Lapack");
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
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
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
"),     Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      
    external "Fortran 77" dgesvd("N", "N", size(A, 1), size(A, 2), Awork, size(
        A, 1), sigma, U, size(A, 1), VT, size(A, 2), work, lwork, info) 
        annotation (Library="Lapack");
    end dgesvd_sigma;
    
    function StringAllocate 
      "Utility function to provide storage for characters" 
      extends Modelica.Icons.Function;
      input Integer n;
      output String s;
    external "C" annotation (doNotDeclare);
    end StringAllocate;
    
    function dgetrf 
      "Compute LU factorization of square or rectangular matrix A (A = P*L*U)" 
      
      extends Modelica.Icons.Function;
      input Real A[:, :] "Square or rectangular matrix";
      output Real LU[size(A, 1), size(A, 2)]=A;
      output Integer pivots[min(size(A, 1), size(A, 2))] "Pivot vector";
      output Integer info "Information";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
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
"),     Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      
    external "FORTRAN 77" dgetrf(size(A, 1), size(A, 2), LU, size(A, 1), pivots,
         info) annotation (Library="Lapack");
    end dgetrf;
    
    function dgetrs_vec 
      "Solves a system of linear equations with the LU decomposition from dgetrf(..)" 
      
      extends Modelica.Icons.Function;
      input Real LU[:, size(LU, 1)] 
        "LU factorization of dgetrf of a square matrix";
      input Integer pivots[size(LU, 1)] "Pivot vector of dgetrf";
      input Real b[size(LU, 1)] "Right hand side vector b";
      output Real x[size(b, 1)]=b;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
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
"),     Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      
    protected 
      Real work[size(LU, 1), size(LU, 1)]=LU;
      Integer info;
    external "FORTRAN 77" dgetrs("N", size(LU, 1), 1, work, size(LU, 1), pivots,
         x, size(b, 1), info) annotation (Library="Lapack");
    end dgetrs_vec;
    
    function dgetri 
      "Computes the inverse of a matrix using the LU factorization from dgetrf(..)" 
      
      extends Modelica.Icons.Function;
      input Real LU[:, size(LU, 1)] 
        "LU factorization of dgetrf of a square matrix";
      input Integer pivots[size(LU, 1)] "Pivot vector of dgetrf";
      output Real inv[size(LU, 1), size(LU, 2)]=LU "Inverse of matrix P*L*U";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
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
              singular and its inverse could not be computed."),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
    protected 
      Integer lwork=min(10, size(LU, 1))*size(LU, 1) "Length of work array";
      Real work[lwork];
      Integer info;
    external "FORTRAN 77" dgetri(size(LU, 1), inv, size(LU, 1), pivots, work,
        lwork, info) annotation (Library="Lapack");
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
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
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
then the jth column of P is the ith canonical unit vector."),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
    protected 
      Integer info;
      Integer ncol=size(A, 2) "Column dimension of A";
      Real work[3*ncol] "work array";
    external "FORTRAN 77" dgeqpf(size(A, 1), ncol, QR, size(A, 1), p, tau, work,
         info) annotation (Library="Lapack");
    end dgeqpf;
    
    function dorgqr 
      "Generates a Real orthogonal matrix Q which is defined as the product of elementary reflectors as returned from dgeqpf" 
      
      extends Modelica.Icons.Function;
      input Real QR[:, :] "QR from dgeqpf";
      input Real tau[min(size(QR, 1), size(QR, 2))] 
        "The scalar factors of the elementary reflectors of Q";
      output Real Q[size(QR, 1), size(QR, 2)]=QR "Orthogonal matrix Q";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
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
"),     Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
      
    protected 
      Integer info;
      Integer lwork=min(10, size(QR, 2))*size(QR, 2) "Length of work array";
      Real work[lwork];
    external "FORTRAN 77" dorgqr(size(QR, 1), size(QR, 2), size(tau, 1), Q,
        size(Q, 1), tau, work, lwork, info) annotation (Library="Lapack");
    end dorgqr;
  end LAPACK;
end Matrices;
