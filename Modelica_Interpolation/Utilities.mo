package Utilities "Utility functions of package Interpolation" 
extends Modelica.Icons.Library;
  
annotation (
  Documentation(info="<html>
<p>
Utility functions are provided here which are usually not called directly
by a user, but are needed in the functions of this package
</p>
 
</html>
"));
  encapsulated function norm "The euklidian norm of a vector" 
    import Modelica;
    extends Modelica.Icons.Function;
    input Real v[:] "A vector";
    output Real n "The norm of the vector";
  algorithm 
    n:=sqrt(v*v);
  end norm;
  
  function curveLength "Computes the length of the curve from a to b" 
   extends Modelica.Icons.Function;
   input Modelica_Interpolation.Bspline1D spline "Bspline data";
   input Real a "left end";
   input Real b "right end";
   input Real err = 1e-8 "relative error";
   output Real I "curve length from a to b";
    
  protected 
    Real m;
    Real h;
    Real alpha;
    Real beta;
    Real x1 = 0.942882415695480;
    Real x2 = 0.641853342345781;
    Real x3 = 0.236383199662150;
   Real x[13];
   Real y[13];
   Real fa;
   Real fb;
   Real i1;
   Real i2;
   Real is;
   Real erri1;
   Real erri2;
   Real R;
   Real tol;
   Real eps = 1e-16;
   Integer s;
    
  encapsulated package Internal 
      "Funtions to be used only in function curveLength" 
      import Modelica_Interpolation;
      
   function quadStep "Recursive function used by curveLength" 
    input Modelica_Interpolation.Bspline1D spline;
    input Real a "right interval end";
    input Real b "left interval end";
    input Real fa "function value at a";
    input Real fb "function value at b";
    input Real is "first approximation of the integral";
    output Real I "Integral value";
      protected 
    Real m;
    Real h;
    Real alpha;
    Real beta;
    Real x[5];
    Real y[5];
    Real mll;
    Real ml;
    Real mr;
    Real mrr;
    Real fmll;
    Real fml;
    Real fm;
    Real fmr;
    Real fmrr;
    Real i1;
    Real i2;
   algorithm 
     h := (b-a)/2;
     m := (a+b)/2;
     alpha := sqrt(2/3);
     beta := 1/sqrt(5);
     mll := m-alpha*h;
     ml := m-beta*h;
     mr := m+beta*h;
     mrr := m+alpha*h;
     x := {mll,ml,m,mr,mrr};
     y := eval(spline,x);
     fmll := y[1];
     fml := y[2];
     fm := y[3];
     fmr := y[4];
     fmrr := y[5];
     i2 := (h/6)*(fa+fb+5*(fml+fmr));
     i1 := (h/1470)*(77*(fa+fb)+432*(fmll+fmrr)+625*(fml+fmr)
        +672*fm);
        
     if 
       (is+(i1-i2)==is) or (mll<=a) or (b<=mrr) then
       I := i1;
          
     else
       I := quadStep(spline,a,mll,fa,fmll,is)+
         quadStep(spline,mll,ml,fmll,fml,is)+
         quadStep(spline,ml,m,fml,fm,is)+
         quadStep(spline,m,mr,fm,fmr,is)+
         quadStep(spline,mr,mrr,fmr,fmrr,is)+
         quadStep(spline,mrr,b,fmrr,fb,is);
          
     end if;
   end quadStep;
      
   function eval "evaluate the integrand" 
     input Modelica_Interpolation.Bspline1D spline "Bspline data";
     input Real u[:] "parameters at which the integrand shall be evaluated";
     output Real f[size(u,1)];
      protected 
     Real xd[size(spline.controlPoints,2)];
     Integer n;
   algorithm 
     //the integrand is sqrt(xd*xd) (where xd is the first derivative)
    n := size(u,1);
        
    for i in 1:n loop
      xd := Modelica_Interpolation.Bspline1D.evaluateDerN(spline,u[i],1);
     f[i] := sqrt(xd*xd);
          
    end for;
   end eval;
  end Internal;
    
  algorithm 
   /*
        Numerically evaluate integral using adaptive
        Lobatto rule.
        see Walter Gander: Adaptive Quadrature - Revisited, 1998
                        ftp.inf.ethz.ch in doc/tech-reports/1998/306.ps
                        
        x[:] are the nodes
        y[:] = f(x[:]) are function values at the nodes
                here (arc length computation): the integrand f is the
                absolute value of the first derivative of the curve (Bspline) 
        */
    tol := err;
    m := (a+b)/2;
                  h:=(b - a)/2;
    alpha := sqrt(2/3);
                        beta:=1/sqrt(5);
    x := {a,m-x1*h,m-alpha*h,m-x2*h,m-beta*h,m-x3*h,m,m+x3*h,
          m+beta*h,m+x2*h,m+alpha*h,m+x1*h,b};
    y := Internal.eval(spline,x);
    fa := y[1];
                fb := y[13];
    i2 := (h/6)*(y[1]+y[13]+5*(y[5]+y[9]));
    i1 := (h/1470)*(77*(y[1]+y[13])+432*(y[3]+y[11])+
       625*(y[5]+y[9])+672*y[7]);
    is := h*(.0158271919734802*(y[1]+y[13])+.0942738402188500
       *(y[2]+y[12])+.155071987336585*(y[3]+y[11])+.188821573960182
                       *(y[4]+y[10])+.199773405226859
       *(y[5]+y[9])+.224926465333340*(y[6]+y[8])
       +.242611071901408*y[7]);
    s := sign(is);
    if 
      (s==0) then
                  s := 1;
                          end if;
    erri1 := abs(i1-is);
    erri2 := abs(i2-is);
    R := 1;
    if 
      (erri2<>0) then
                      R := erri1/erri2;
                                        end if;
    if 
      (R>0 and R<1) then
                         tol := tol/R;
                                       end if;
    is := s*abs(is)*tol/eps;
    if 
      (is==0) then
                   is := b-a;
                              end if;
    I := Internal.quadStep(spline,a,b,fa,fb,is);
    
  end curveLength;
  
  function dgbsv 
    "Solve real system of linear equations A*X=B with a banded A matrix and a B matrix (copy from protected package Matrices.Lapack)" 
    extends Modelica.Icons.Function;
        input Integer n "Number of equations";
        input Integer kLower "Number of lower bands";
        input Integer kUpper "Number of upper bands";
        input Real A[2*kLower + kUpper + 1, n];
        input Real B[n, :];
        output Real X[n, size(B, 2)]=B;
        output Integer info;
    
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
  protected 
        Real Awork[size(A, 1), size(A, 2)]=A;
        Integer ipiv[n];
    
      external "FORTRAN 77" dgbsv(n, kLower, kUpper, size(B, 2), Awork, size(
          Awork, 1), ipiv, X, n, info) annotation (Library="Lapack");
  end dgbsv;
  
  function dgesv 
    "Solve real system of linear equations A*X=B with a B matrix (copy from protected package Matrices.Lapack)" 
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
"),   Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
    
  external "FORTRAN 77" dgesv(size(A, 1), size(B, 2), Awork, size(A, 1), ipiv,
       X, size(A, 1), info) annotation (Library="Lapack");
  end dgesv;
  
  function getNumberControlPoints "Return the number of control points" 
   extends Modelica.Icons.Function;
    input Real r[:, :] "r[i,:] is position vector to point i on the curve";
    input Integer degree "degree of the Bspline";
    output Integer ncontrol "number of control points";
  protected 
    Integer n;
    Integer multi;
    Integer begin;
    Real delta[size(r,2)];
    Integer j;
    Integer jstart;
  algorithm 
   n := size(r,1);
    
   //delete multiple start data points
   multi := 1;
    
   for j in 1:n-1 loop
    delta := r[1,:] - r[1+j,:];
      
    if sqrt(delta*delta) < 1e-12 then
     multi := multi + 1;
        
    end if;
      
   end for;
   begin := multi;
    
   //delete multiple end data points
   multi := 0;
    
   for j in 1:n-1 loop
    delta := r[n,:] - r[n-j,:];
      
    if sqrt(delta*delta) < 1e-12 then
     multi := multi + 1;
        
    end if;
      
   end for;
   n := n-multi;
    
   ncontrol := n;
   jstart := begin;
    
   for j in begin+1:n-1 loop
     delta := r[j,:] - r[j-1,:];
      
     if sqrt(delta*delta) < 1e-12 then
        
       if j-1-jstart >= 1 and j-1-jstart < degree then
         //an interpolation with a Bspline of degree = p needs 
         //p+1 data points. If there are less than p+1, insert
         //virtual data points to get p+1.
       ncontrol := ncontrol + degree - (j-1 - jstart);
          
      end if;
      jstart := j;
      delta := r[j+1,:] - r[j,:];
        
      if sqrt(delta*delta) < 1e-12 then
       //triple data point; delete one data point
       ncontrol := ncontrol - 1;
       jstart := j+1;
          
      end if;
        
     end if;
    end for;
    
    //end  
    if n-jstart < degree then
     ncontrol := ncontrol + degree - (n-jstart);
    end if;
    
   //multiple start data points
   ncontrol := ncontrol - begin + 1;
    
   //if Bessel and degree==3 then size(r, 1)+2 else size(r, 1)
    
  end getNumberControlPoints;
  
  function solveBandedWithMatrix 
    "Solve linear system with banded system matrix and right hand side matrix (similar to Modelica.Matrices.solve)" 
    extends Modelica.Icons.Function;
    input Integer kLower "Number of lower bands";
    input Integer kUpper "Number of upper bands";
    input Real A[2*kLower + kUpper + 1, :] "Matrix A of A*X = B";
    input Real B[size(A, 2), :] "Matrix B of A*X = B";
    output Real X[size(A, 2), size(B, 2)]=B "Matrix X such that A*X = B";
    output Integer info;
  algorithm 
    (X,info) := dgbsv(size(A,2), kLower, kUpper, A, B);
    assert(info == 0, "Solving a linear system of equations with function
\"Modelica_Interpolation.Utilities.solveBandedWithMatrix\" is not possible, since matrix A 
is singular, i.e., no unique solution exists.");
  end solveBandedWithMatrix;
  
  function solveMatrix 
    "Solve linear system with right hand side matrix (similar to Modelica_Interpolation.Utilities.solveMatrix)" 
    extends Modelica.Icons.Function;
    input Real A[:, size(A, 1)] "Matrix A of A*X = B";
    input Real B[size(A, 1), :] "Matrix B of A*X = B";
    output Real X[size(B, 1), size(B, 2)]=B "Matrix X such that A*X = B";
  protected 
    Integer info;
  algorithm 
    (X,info) := dgesv(A, B);
    assert(info == 0, "Solving a linear system of equations with function
\"Modelica_Interpolation.Utilities.solveMatrix\" is not possible, since matrix A 
is singular, i.e., no unique solution exists.");
  end solveMatrix;
  
encapsulated function parametrizeSpline 
    "Automatic parameterization of a Bspline in the range 0..1 (if size(points,2) > 1)" 
    import Modelica;
    import Modelica_Interpolation;
    import Modelica_Interpolation.Utilities.norm;
  extends Modelica.Icons.Function;
  input Real points[:, :] "[i,:] is point i on the curve to be interpolated";
  input Integer paramType = Modelica_Interpolation.Types.Parametrization.Centripetal 
      "type of parametrization";
  output Real param[size(points, 1)] "parametrization of the data points";
  protected 
Real pi=Modelica.Constants.pi;
Integer i;
Integer n_points;
Real d;
Real d_1[size(points, 2)];
Real d_2[size(points, 2)];
Real d_3[size(points, 2)];
Real phi_1;
Real phi_2;
Real lambda;
Real nu;
algorithm 
//The following types of parametrization are described in the book of 
//Gerald Farin, Curves and Surfaces in CAGD (page 161 'Finding a Knot
//Sequence'). For a comparison of the different parametrizations see 
//the diploma thesis of Gerhard Schillhuber: 'Geometrische Modellierung
//oszillationsarmer Trajektorien von Industrierobotern (TU München)'
//(only available in german)
n_points := size(points,1);
  if paramType == Modelica_Interpolation.Types.Parametrization.Equidistant then
  //---EQUIDISTANT---
  //the parameters are choosen equidistant
    param := linspace(0, 1, size(points, 1));
      
  elseif paramType == Modelica_Interpolation.Types.Parametrization.ChordLength then
   param[1] := 0;
  //---CHORD-LENGTH---
  //the parameters are choosen proportional to the distances of the points
    for i in 2:n_points loop
      d := norm(points[i,:] - points[i-1,:]);
      param[i] := param[i-1]+d;
    end for;
    param := param / param[n_points];
      
  elseif paramType == Modelica_Interpolation.Types.Parametrization.Centripetal then
   param[1] := 0;
  //---CENTRIPETAL---
  //the idea of the centriptal parametrization is to minimize the centripetal
  //force of an object moving on the curve.
    for i in 2:n_points loop
      d := norm(points[i,:] - points[i-1,:]);
      param[i] := param[i-1]+sqrt(d);
    end for;
    param := param / param[n_points];
      
  elseif paramType == Modelica_Interpolation.Types.Parametrization.Foley then
   param[1] := 0;
  //---FOLEY---
  //for computing the parameter the distances and the angle formed by the points
  //are needed.
      
    d_2 := (points[2,:] - points[1,:]);
    d_3 := (points[3,:] - points[2,:]);
    phi_2 := min(pi - arccos((d_2 * d_3) / (norm(d_2)*norm(d_3))),pi/2);
    d := norm(d_2)*(1 +
        3/2 * phi_2 * norm(d_3) / (norm(d_2)+norm(d_3)));
    param[2] := param[1]+d;
      
    for i in 3:n_points-1 loop
      d_1 := (points[i-1,:] - points[i-2,:]);
      d_2 := (points[i,:] - points[i-1,:]);
      d_3 := (points[i+1,:] - points[i,:]);
      phi_1 := min(pi - arccos((d_1 * d_2) / (norm(d_1)*norm(d_2))),pi/2);
      phi_2 := min(pi - arccos((d_2 * d_3) / (norm(d_2)*norm(d_3))),pi/2);
      d := norm(d_2)*(1 +
          3/2 * phi_1 * norm(d_1) / (norm(d_1)+norm(d_2)) +
          3/2 * phi_2 * norm(d_3) / (norm(d_2)+norm(d_3)));
        
      param[i] := param[i-1]+d;
    end for;
      
    d_1 := (points[n_points-1,:] - points[n_points-2,:]);
    d_2 := (points[n_points,:] - points[n_points-1,:]);
    phi_1 := min(pi - arccos((d_1 * d_2) / (norm(d_1)*norm(d_2))),pi/2);
    d := norm(d_2)*(1 +
        3/2 * phi_1 * norm(d_1) / (norm(d_1)+norm(d_2)));
    param[n_points] := param[n_points-1]+d;
      
    param := param / param[n_points];
      
  elseif paramType == Modelica_Interpolation.Types.Parametrization.Angular then
   param[1] := 0;
  //---ANGULAR---
  //this param. is like the Foley parametrization (distances and the angle
  //are needed).
   lambda := 1.5;
    for i in 2:n_points-1 loop
      d_1 := (points[i,:] - points[i-1,:]);
      d_2 := (points[i+1,:] - points[i,:]);
      phi_1 := arccos((d_1 * d_2) / (norm(d_1)*norm(d_2)));
        
      d := sqrt(norm(d_1))*(1 + lambda*phi_1/pi);
      param[i] := param[i-1]+d;
    end for;
    d_1 := (points[n_points-2,:] - points[n_points-1,:]);
    d_2 := (points[n_points-1,:] - points[n_points,:]);
    phi_1 := arccos((d_2 * d_1) / (norm(d_1)*norm(d_2)));
    d := sqrt(norm(d_2))*(1 + lambda*phi_1/pi);
    param[n_points] := param[n_points-1]+d;
      
    param := param / param[n_points];
      
  elseif paramType == Modelica_Interpolation.Types.Parametrization.AreaBased then
   lambda := 2/3;
  //---AREA-BASED---
  //the parameters are choosen proportional to the area of the parallelograms
  //formed by the points.
    nu := 0.3;
    param[1] := 0;
    d_2 := (points[2,:] - points[1,:]);
    d_3 := (points[3,:] - points[2,:]);
    phi_2 := max(arccos((-d_2 * d_3) / (norm(d_2)*norm(d_3))),pi/2);
    d := nu*norm(d_2) + (1-nu)*(sin(phi_2)*norm(d_3)) / norm(d_3);
    param[2] := param[1]+d;
      
    for i in 3:n_points-1 loop
      d_1 := (points[i-1,:] - points[i-2,:]);
      d_2 := (points[i,:] - points[i-1,:]);
      d_3 := (points[i+1,:] - points[i,:]);
      phi_1 := max(arccos((-d_1 * d_2) / (norm(d_1)*norm(d_2))),pi/2);
      phi_2 := max(arccos((-d_2 * d_3) / (norm(d_2)*norm(d_3))),pi/2);
        
      d := lambda*norm(d_2) +
          (1-lambda)*(sin(phi_1)*norm(d_1)+sin(phi_2)*norm(d_3)) /
            (norm(d_1)+norm(d_3));
      param[i] := param[i-1]+d;
    end for;
    d_1 := (points[n_points-1,:] - points[n_points-2,:]);
    d_2 := (points[n_points,:] - points[n_points-1,:]);
    phi_1 := max(arccos((-d_1 * d_2) / (norm(d_1)*norm(d_2))),pi/2);
    d := nu*norm(d_2) + (1-nu)*(sin(phi_1)*norm(d_1)) / norm(d_1);
    param[n_points] := param[n_points-1]+d;
      
    param := param / param[n_points];
      
  end if;
end parametrizeSpline;
end Utilities;
