within ;
package ObsoleteModelica4 "Library that contains components from Modelica Standard Library 3.2.3 that have been removed from version 4.0.0"
  extends Modelica.Icons.Package;
  package Math "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
    extends Modelica.Icons.Package;
    package Matrices "Library of functions operating on matrices"
      extends Modelica.Icons.Package;
      package LAPACK "Interface to LAPACK library (should usually not directly be used but only indirectly via Modelica.Math.Matrices)"
        extends Modelica.Icons.FunctionsPackage;
        function dgegv "Obsolete function. Use Modelica.Math.Matrices.LAPACK.dggev instead"
          extends Modelica.Icons.Function;
          extends Modelica.Icons.ObsoleteModel;
          input Real A[:, size(A, 1)];
          input Real B[size(A, 1), size(A, 1)];
          output Real alphaReal[size(A, 1)]
            "Real part of alpha (eigenvalue=(alphaReal+i*alphaImag)/beta)";
          output Real alphaImag[size(A, 1)] "Imaginary part of alpha";
          output Real beta[size(A, 1)] "Denominator of eigenvalue";
          output Integer info;
        protected
          Integer n=size(A, 1);
          Integer lwork=12*n;
          Integer ldvl=1;
          Integer ldvr=1;
          Real Awork[size(A, 1), size(A, 1)]=A;
          Real Bwork[size(A, 1), size(A, 1)]=B;
          Real work[12*size(A, 1)];
          Real dummy1[1, 1];
          Real dummy2[1, 1];

        external"FORTRAN 77" dgegv(
                  "N",
                  "N",
                  n,
                  Awork,
                  n,
                  Bwork,
                  n,
                  alphaReal,
                  alphaImag,
                  beta,
                  dummy1,
                  ldvl,
                  dummy2,
                  ldvr,
                  work,
                  lwork,
                  info) annotation (Library="lapack");
          annotation (
            obsolete = "Obsolete function - use Modelica.Math.Matrices.LAPACK.dggev instead",
            Documentation(info="Lapack documentation
    Purpose
    =======

    This routine is deprecated and has been replaced by routine DGGEV.

    DGEGV computes the eigenvalues and, optionally, the left and/or right
    eigenvectors of a real matrix pair (A,B).
    Given two square matrices A and B,
    the generalized nonsymmetric eigenvalue problem (GNEP) is to find the
    eigenvalues lambda and corresponding (non-zero) eigenvectors x such
    that

       A*x = lambda*B*x.

    An alternate form is to find the eigenvalues mu and corresponding
    eigenvectors y such that

       mu*A*y = B*y.

    These two forms are equivalent with mu = 1/lambda and x = y if
    neither lambda nor mu is zero.  In order to deal with the case that
    lambda or mu is zero or small, two values alpha and beta are returned
    for each eigenvalue, such that lambda = alpha/beta and
    mu = beta/alpha.

    The vectors x and y in the above equations are right eigenvectors of
    the matrix pair (A,B).  Vectors u and v satisfying

       u**H*A = lambda*u**H*B  or  mu*v**H*A = v**H*B

    are left eigenvectors of (A,B).

    Note: this routine performs \"full balancing\" on A and B -- see
    \"Further Details\", below.

    Arguments
    =========

    JOBVL   (input) CHARACTER*1
            = 'N':  do not compute the left generalized eigenvectors;
            = 'V':  compute the left generalized eigenvectors (returned
                    in VL).

    JOBVR   (input) CHARACTER*1
            = 'N':  do not compute the right generalized eigenvectors;
            = 'V':  compute the right generalized eigenvectors (returned
                    in VR).

    N       (input) INTEGER
            The order of the matrices A, B, VL, and VR.  N >= 0.

    A       (input/output) DOUBLE PRECISION array, dimension (LDA, N)
            On entry, the matrix A.
            If JOBVL = 'V' or JOBVR = 'V', then on exit A
            contains the real Schur form of A from the generalized Schur
            factorization of the pair (A,B) after balancing.
            If no eigenvectors were computed, then only the diagonal
            blocks from the Schur form will be correct.  See DGGHRD and
            DHGEQZ for details.

    LDA     (input) INTEGER
            The leading dimension of A.  LDA >= max(1,N).

    B       (input/output) DOUBLE PRECISION array, dimension (LDB, N)
            On entry, the matrix B.
            If JOBVL = 'V' or JOBVR = 'V', then on exit B contains the
            upper triangular matrix obtained from B in the generalized
            Schur factorization of the pair (A,B) after balancing.
            If no eigenvectors were computed, then only those elements of
            B corresponding to the diagonal blocks from the Schur form of
            A will be correct.  See DGGHRD and DHGEQZ for details.

    LDB     (input) INTEGER
            The leading dimension of B.  LDB >= max(1,N).

    ALPHAR  (output) DOUBLE PRECISION array, dimension (N)
            The real parts of each scalar alpha defining an eigenvalue of
            GNEP.

    ALPHAI  (output) DOUBLE PRECISION array, dimension (N)
            The imaginary parts of each scalar alpha defining an
            eigenvalue of GNEP.  If ALPHAI(j) is zero, then the j-th
            eigenvalue is real; if positive, then the j-th and
            (j+1)-st eigenvalues are a complex conjugate pair, with
            ALPHAI(j+1) = -ALPHAI(j).

    BETA    (output) DOUBLE PRECISION array, dimension (N)
            The scalars beta that define the eigenvalues of GNEP.

            Together, the quantities alpha = (ALPHAR(j),ALPHAI(j)) and
            beta = BETA(j) represent the j-th eigenvalue of the matrix
            pair (A,B), in one of the forms lambda = alpha/beta or
            mu = beta/alpha.  Since either lambda or mu may overflow,
            they should not, in general, be computed.

    VL      (output) DOUBLE PRECISION array, dimension (LDVL,N)
            If JOBVL = 'V', the left eigenvectors u(j) are stored
            in the columns of VL, in the same order as their eigenvalues.
            If the j-th eigenvalue is real, then u(j) = VL(:,j).
            If the j-th and (j+1)-st eigenvalues form a complex conjugate
            pair, then
               u(j) = VL(:,j) + i*VL(:,j+1)
            and
              u(j+1) = VL(:,j) - i*VL(:,j+1).

            Each eigenvector is scaled so that its largest component has
            abs(real part) + abs(imag. part) = 1, except for eigenvectors
            corresponding to an eigenvalue with alpha = beta = 0, which
            are set to zero.
            Not referenced if JOBVL = 'N'.

    LDVL    (input) INTEGER
            The leading dimension of the matrix VL. LDVL >= 1, and
            if JOBVL = 'V', LDVL >= N.

    VR      (output) DOUBLE PRECISION array, dimension (LDVR,N)
            If JOBVR = 'V', the right eigenvectors x(j) are stored
            in the columns of VR, in the same order as their eigenvalues.
            If the j-th eigenvalue is real, then x(j) = VR(:,j).
            If the j-th and (j+1)-st eigenvalues form a complex conjugate
            pair, then
              x(j) = VR(:,j) + i*VR(:,j+1)
            and
              x(j+1) = VR(:,j) - i*VR(:,j+1).

            Each eigenvector is scaled so that its largest component has
            abs(real part) + abs(imag. part) = 1, except for eigenvalues
            corresponding to an eigenvalue with alpha = beta = 0, which
            are set to zero.
            Not referenced if JOBVR = 'N'.

    LDVR    (input) INTEGER
            The leading dimension of the matrix VR. LDVR >= 1, and
            if JOBVR = 'V', LDVR >= N.

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
            On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

    LWORK   (input) INTEGER
            The dimension of the array WORK.  LWORK >= max(1,8*N).
            For good performance, LWORK must generally be larger.
            To compute the optimal value of LWORK, call ILAENV to get
            blocksizes (for DGEQRF, DORMQR, and DORGQR.)  Then compute:
            NB  -- MAX of the blocksizes for DGEQRF, DORMQR, and DORGQR;
            The optimal LWORK is:
                2*N + MAX( 6*N, N*(NB+1) ).

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
    that the pair  DL*PL*A*PR*DR, DL*PL*B*PR*DR have elements close to
    one (except for the elements that start out zero.)

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
        by Golub & van Loan, pub. by Johns Hopkins U. Press.
"));
        end dgegv;

        function dgelsx "Obsolete function. Use Modelica.Math.Matrices.LAPACK.dgelsy instead"

          extends Modelica.Icons.Function;
          extends Modelica.Icons.ObsoleteModel;
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
          Real work[max(min(size(A, 1), size(A, 2)) + 3*size(A, 2), 2*min(size(A, 1),
            size(A, 2)) + size(B, 2))];
          Real Awork[size(A, 1), size(A, 2)]=A;
          Integer jpvt[size(A, 2)]=zeros(ncol);

        external"FORTRAN 77" dgelsx(
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
                  info) annotation (Library="lapack");
          annotation (
            obsolete = "Obsolete function - use Modelica.Math.Matrices.LAPACK.dgelsy instead",
            Documentation(info="Lapack documentation
    Purpose
    =======

    This routine is deprecated and has been replaced by routine DGELSY.

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
            < 0:  if INFO = -i, the i-th argument had an illegal value
"));
        end dgelsx;

        function dgelsx_vec "Obsolete function. Use Modelica.Math.Matrices.LAPACK.dgelsy_vec instead"

          extends Modelica.Icons.Function;
          extends Modelica.Icons.ObsoleteModel;
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
          Real work[max(min(size(A, 1), size(A, 2)) + 3*size(A, 2), 2*min(size(A, 1),
            size(A, 2)) + 1)];
          Real Awork[size(A, 1), size(A, 2)]=A;
          Integer jpvt[size(A, 2)]=zeros(ncol);

        external"FORTRAN 77" dgelsx(
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
                  info) annotation (Library="lapack");
          annotation (
            obsolete = "Obsolete function - use Modelica.Math.Matrices.LAPACK.dgelsy_vec instead",
            Documentation(info="Lapack documentation
    Purpose
    =======

    This routine is deprecated and has been replaced by routine DGELSY.

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
            < 0:  if INFO = -i, the i-th argument had an illegal value
"));
        end dgelsx_vec;

        function dgeqpf "Obsolete function. Use Modelica.Math.Matrices.LAPACK.dgeqp3 instead"

          extends Modelica.Icons.Function;
          extends Modelica.Icons.ObsoleteModel;
          input Real A[:, :] "Square or rectangular matrix";
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
          Real work[3*size(A, 2)] "work array";

        external"FORTRAN 77" dgeqpf(
                  m,
                  ncol,
                  QR,
                  lda,
                  p,
                  tau,
                  work,
                  info) annotation (Library={"lapack"});
          annotation (
            obsolete = "Obsolete function - use Modelica.Math.Matrices.LAPACK.dgeqp3 instead",
            Documentation(info="Lapack documentation
    Purpose
    =======

    This routine is deprecated and has been replaced by routine DGEQP3.

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
    then the jth column of P is the ith canonical unit vector.
"));
        end dgeqpf;
      end LAPACK;
    end Matrices;

    function tempInterpol1
      "Obsolete function for linear interpolation"
      extends Modelica.Icons.Function;
      extends Modelica.Icons.ObsoleteModel;

      input Real u "Input value (first column of table)";
      input Real table[:, :] "Table to be interpolated";
      input Integer icol "Column of table to be interpolated";
      output Real y "Interpolated input value (icol column of table)";
    protected
      Integer i;
      Integer n "Number of rows of table";
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

    </html>"),
      obsolete = "Obsolete function");
    end tempInterpol1;

    function tempInterpol2
      "Obsolete function for vectorized linear interpolation"
      extends Modelica.Icons.Function;
      extends Modelica.Icons.ObsoleteModel;

      input Real u "Input value (first column of table)";
      input Real table[:, :] "Table to be interpolated";
      input Integer icol[:] "Column(s) of table to be interpolated";
      output Real y[1, size(icol, 1)]
        "Interpolated input value(s) (column(s) icol of table)";
    protected
      Integer i;
      Integer n "Number of rows of table";
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

    </html>"),
      obsolete = "Obsolete function");
    end tempInterpol2;
  end Math;

  annotation (uses(Modelica(version="4.0.0-dev")),
              version="4.0.0-dev",
              versionBuild=1,
              versionDate="2019-01-23",
              dateModified = "2019-01-23 12:00:00Z",
              revisionId="$Format:%h %ci$",
Documentation(info="<html>
<p>
This package contains models and blocks from the Modelica Standard Library
version 3.2.3 that are no longer available in version 4.0.0
The conversion script for version 4.0.0 changes references in existing
user models automatically to the models and blocks of package
ObsoleteModelica4. The user should <strong>manually</strong> replace all
references to ObsoleteModelica4 in his/her models to the models
that are recommended in the documentation of the respective model.
</p>

<p>
In most cases, this means that a model with the name
\"ObsoleteModelica4.XXX\" should be renamed to \"Modelica.XXX\" (version 4.0.0)
and then a manual adaptation is needed. For example, a reference to
ObsoleteModelica4.Math.Matrices.LAPACK.dgeqpf
should be replaced by
Modelica.Math.Matrices.LAPACK.dgeqp3 (version 4.0.0).
This usually requires some changes at the place where
the class is used (besides the renaming of the underlying class).
</p>

<p>
The models in ObsoleteModelica4 are either not according to the Modelica Language
version 3.4 and higher, or the model was changed to get a better design.
In all cases, an automatic conversion to the new implementation
was not feasible, since too complicated.
</p>

<p>
In order to easily detect obsolete models and blocks, all of them are specially
marked in the icon layer with a red box.
</p>

<p>
Copyright &copy; 2019, Modelica Association and contributors
</p>

<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>"));
end ObsoleteModelica4;
