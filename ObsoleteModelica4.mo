within ;
package ObsoleteModelica4 "Library that contains components from Modelica Standard Library 3.2.3 that have been removed from version 4.0.0"
  extends Modelica.Icons.Package;
  package Electrical "Library of electrical models (analog, digital, machines, polyphase)"
    extends Modelica.Icons.Package;
    package PowerConverters "Rectifiers, Inverters and DC/DC converters"
      extends Modelica.Icons.Package;
      package DCDC "DC to DC converters"
        extends Modelica.Icons.Package;
        package Control "Control components for DC to DC converters"
          extends Modelica.Icons.Package;
          block VoltageToDutyCycle "Obsolete block - use Modelica.Electrical.PowerConverters.DCDC.Control.Voltage2DutyCycle instead"
            extends Modelica.Icons.ObsoleteModel;
            parameter Boolean useBipolarVoltage = true
              "Enables bipolar input voltage range";
            parameter Boolean useConstantMaximumVoltage=true
              "Enables constant maximum voltage";
            parameter Modelica.SIunits.Voltage vMax=0
              "Maximum voltage range mapped to dutyCycle = 1"
              annotation(Dialog(enable=useConstantMaximumVoltage));
            Modelica.Blocks.Interfaces.RealInput v "Voltage" annotation (Placement(
                  transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
                    extent={{-140,-20},{-100,20}})));
            Modelica.Blocks.Interfaces.RealOutput dutyCycle "Duty cycle" annotation (
                Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(
                    extent={{100,-10},{120,10}})));
            Modelica.Blocks.Math.Division divisionUnipolar if not useBipolarVoltage
              annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
            Modelica.Blocks.Math.Division divisionBipolar if useBipolarVoltage
              annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
            Modelica.Blocks.Math.Add add(k1=0.5, k2=1) if useBipolarVoltage
              annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
            Modelica.Blocks.Sources.Constant offset(final k=0.5) if useBipolarVoltage
              "Offset of 0.5 in case of bipolar operation"
              annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
            Modelica.Blocks.Interfaces.RealInput vMaxExt if not useConstantMaximumVoltage
              "External maximum voltage" annotation (Placement(transformation(
                  extent={{-20,-20},{20,20}},
                  rotation=270,
                  origin={0,120}), iconTransformation(
                  extent={{-20,-20},{20,20}},
                  rotation=270,
                  origin={0,120})));
            Modelica.Blocks.Sources.Constant vMaxConst(final k=vMax) if
              useConstantMaximumVoltage "Offset of 0.5 in case of bipolar operation"
              annotation (Placement(transformation(extent={{40,70},{20,90}})));
          protected
            Modelica.Blocks.Interfaces.RealInput vMaxInt "External maximum voltage"
              annotation (Placement(transformation(
                  extent={{-4,-4},{4,4}},
                  rotation=180,
                  origin={0,80})));
          equation
            connect(divisionBipolar.y, add.u1) annotation (Line(points={{-19,-30},{-10,-30},
                    {-10,-44},{-2,-44}}, color={0,0,127}));
            connect(offset.y, add.u2) annotation (Line(
                points={{-19,-70},{-10,-70},{-10,-56},{-2,-56}},  color={0,0,127}));
            connect(divisionUnipolar.y, dutyCycle) annotation (Line(points={{-19,30},{40,30},
                    {40,0},{110,0}}, color={0,0,127}));
            connect(add.y, dutyCycle) annotation (Line(
                points={{21,-50},{40,-50},{40,0},{110,0}},  color={0,0,127}));
            connect(v, divisionUnipolar.u1) annotation (Line(points={{-120,0},{-80,0},{-80,
                    36},{-42,36}}, color={0,0,127}));
            connect(v, divisionBipolar.u1) annotation (Line(points={{-120,0},{-80,0},{-80,
                    -24},{-42,-24}}, color={0,0,127}));
            connect(vMaxExt, vMaxInt)
              annotation (Line(points={{0,120},{0,80}}, color={0,0,127}));
            connect(vMaxInt, divisionUnipolar.u2) annotation (Line(points={{0,80},{-60,80},
                    {-60,24},{-42,24}}, color={0,0,127}));
            connect(vMaxInt, vMaxConst.y)
              annotation (Line(points={{0,80},{19,80}}, color={0,0,127}));
            connect(vMaxInt, divisionBipolar.u2) annotation (Line(points={{0,80},{-60,80},
                    {-60,-36},{-42,-36}}, color={0,0,127}));
            annotation (obsolete="Obsolete block - use Modelica.Electrical.PowerConverters.DCDC.Control.Voltage2DutyCycle instead",
              defaultComponentName="adaptor", Icon(graphics={
                  Rectangle(
                    extent={{-100,100},{100,-100}},
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),
                  Line(
                    points={{0,-60},{60,60}},
                    pattern=LinePattern.Dash),
                  Line(
                    points={{-60,-60},{60,60}}),
                  Polygon(
                    points={{-78,-60},{-76,-60},{62,-60},{62,-54},{82,-60},{62,-66},{62,-60},
                        {62,-60},{-78,-60}},
                    fillPattern=FillPattern.Solid),
                  Polygon(
                    points={{0,-80},{0,60},{-6,60},{0,80},{6,60},{0,60},{0,-80}},
                    fillPattern=FillPattern.Solid), Text(extent={{
                        -150,-120},{150,-160}}, textString = "%name", lineColor = {0, 0, 255})}),
              Documentation(info="<html>
<p>
This model linearly transforms the input voltage signal into a duty cycle. For the unipolar case the input voltage range is between zero and <code>vMax</code>. In case of bipolar input the input voltage is in the range between <code>-vMax</code> and <code>vMax</code>.
</p>
<p>
Note: This block is replaced by the improved <a href=\"modelica://Modelica.Electrical.PowerConverters.DCDC.Control.Voltage2DutyCycle\">Voltage2DutyCycle</a> block.
</p>
</html>"));
          end VoltageToDutyCycle;
        end Control;
      end DCDC;
      annotation (Icon(graphics={
            Line(
              points={{-78,0},{80,0}},
              color={95,95,95}),
            Polygon(points={{36,0},{-34,50},{-34,-50},{36,0}}, lineColor={95,95,95}),
            Line(
              points={{36,50},{36,-52}},
              color={95,95,95})}));
    end PowerConverters;
    annotation (Icon(graphics={
      Rectangle(
        origin={20.3125,82.8571},
        extent={{-45.3125,-57.8571},{4.6875,-27.8571}}),
      Line(
        origin={7.0,50.0},
        points={{18.0,-10.0},{53.0,-10.0},{53.0,-45.0}}),
      Line(
        origin={9.0,54.0},
        points={{31.0,-49.0},{71.0,-49.0}}),
      Line(
        origin={8.0,48.0},
        points={{32.0,-58.0},{72.0,-58.0}}),
      Line(
        origin={6.2593,48.0},
        points={{53.7407,-58.0},{53.7407,-93.0},{-66.2593,-93.0},{-66.2593,-58.0}}),
      Line(
        origin={-3.0,45.0},
        points={{-72.0,-55.0},{-42.0,-55.0}}),
      Line(
        origin={-2.0,55.0},
        points={{-83.0,-50.0},{-33.0,-50.0}}),
      Line(
        origin={1.0,50.0},
        points={{-61.0,-45.0},{-61.0,-10.0},{-26.0,-10.0}})}));
  end Electrical;

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

  package Magnetic "Library of magnetic models"
    extends Modelica.Icons.Package;
    package FundamentalWave "Library for magnetic fundamental wave effects in electric machines"

      package BasicMachines "Machine components and modelsElectric machine models based on FundamentalWave package"
        extends Modelica.Icons.Package;
        package Components "Components specially for electric machines"
          extends Modelica.Icons.Package;
          model SymmetricMultiPhaseCageWinding "Symmetrical rotor cage"
            import Modelica.Constants.pi;
            extends Modelica.Icons.ObsoleteModel;
            extends Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortExtended;
            parameter Integer m=3 "Number of phases";
            parameter Boolean useHeatPort=false
              "Enable / disable (=fixed temperatures) thermal port"
              annotation (Evaluate=true);
            parameter Modelica.SIunits.Resistance RRef
              "Winding resistance per phase at TRef";
            parameter Modelica.SIunits.Temperature TRef(start=293.15)
              "Reference temperature of winding";
            parameter
              Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
              alpha20(start=0) "Temperature coefficient of winding at 20 degC";
            final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
                Modelica.Electrical.Machines.Thermal.convertAlpha(
                      alpha20,
                      TRef,
                      293.15) "Temperature coefficient of winding at reference temperature";
            parameter Modelica.SIunits.Temperature TOperational(start=293.15)
              "Operational temperature of winding"
              annotation (Dialog(enable=not useHeatPort));
            parameter Modelica.SIunits.Inductance Lsigma "Cage stray inductance";
            parameter Real effectiveTurns=1 "Effective number of turns";
            Modelica.SIunits.Current i[m]=strayInductor.i "Cage currents";
            Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter
              winding(
              final m=m,
              final effectiveTurns=fill(effectiveTurns, m),
              final orientation=
                  Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m))
              "Symmetric winding" annotation (Placement(transformation(
                  origin={0,-10},
                  extent={{-10,-10},{10,10}},
                  rotation=90)));
            Modelica.Electrical.Polyphase.Basic.Inductor strayInductor(final m=m,
                final L=fill(Lsigma, m)) annotation (Placement(transformation(
                  origin={-20,-30},
                  extent={{10,-10},{-10,10}},
                  rotation=90)));
            Modelica.Electrical.Polyphase.Basic.Resistor resistor(
              final useHeatPort=useHeatPort,
              final m=m,
              final R=fill(RRef, m),
              final T_ref=fill(TRef, m),
              final alpha=fill(alphaRef, m),
              final T=fill(TOperational, m)) annotation (Placement(transformation(
                  origin={-20,-70},
                  extent={{10,10},{-10,-10}},
                  rotation=90)));
            Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
                Placement(transformation(extent={{30,-30},{50,-10}})));
            Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                  transformation(
                  origin={70,-20},
                  extent={{-10,10},{10,-10}},
                  rotation=270)));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if useHeatPort "Heat ports of winding resistor" annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
            Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(final m=m) if useHeatPort "Connector of thermal rotor resistance heat ports" annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
            Modelica.Electrical.Polyphase.Basic.Star starAuxiliary(final m=m)
              annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
          equation
            connect(port_p, winding.port_p)
              annotation (Line(points={{-100,0},{-10,0}}, color={255,128,0}));
            connect(winding.port_n, port_n) annotation (Line(points={{10,0},
                    {100,0}}, color={255,128,0}));
            connect(ground.p, star.pin_n) annotation (Line(points={{60,-20},{56,-20},
                    {50,-20}}, color={0,0,255}));
            connect(strayInductor.plug_n, resistor.plug_p)
              annotation (Line(points={{-20,-40},{-20,-60}}, color={0,0,255}));
            connect(strayInductor.plug_p, winding.plug_p) annotation (Line(
                points={{-20,-20},{-10,-20}}, color={0,0,255}));
            connect(star.plug_p, winding.plug_n) annotation (Line(
                points={{30,-20},{10,-20}}, color={0,0,255}));
            connect(thermalCollector.port_a, resistor.heatPort) annotation (Line(
                points={{-40,-70},{-30,-70}}, color={191,0,0}));
            connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
                points={{-40,-90},{-40,-100},{0,-100}}, color={191,0,0}));
            connect(resistor.plug_n, starAuxiliary.plug_p) annotation (Line(
                points={{-20,-80},{30,-80}}, color={0,0,255}));
            annotation (defaultComponentName="cage", obsolete="Obsolete model, see #1536 (https://github.com/modelica/ModelicaStandardLibrary/issues/1536) and #3030 (https://github.com/modelica/ModelicaStandardLibrary/issues/3030), use Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding instead",
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                      {100,100}}), graphics={Ellipse(
                          extent={{-80,80},{80,-80}},
                          fillColor={175,175,175},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{-20,76},{20,36}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{28,46},{68,6}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{28,-8},{68,-48}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{-20,-36},{20,-76}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{-68,-6},{-28,-46}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{-66,50},{-26,10}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Line(points={{-80,0},{-100,
                    0}}, color={255,128,0}),Line(points={{100,0},{80,0}}, color={
                    255,128,0}),Text(
                          extent={{0,100},{0,140}},
                          textColor={0,0,255},
                          textString="%name")}),
              Documentation(info="<html>
<p>
Obsolete symmetric cage model, see 
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1536\">#1536</a> and 
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3030\">#3030</a>, use 
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">SymmetricPolyphaseCageWinding</a> instead.
</p>
</html>"));
          end SymmetricMultiPhaseCageWinding;

          model SaliencyCageWinding "Rotor cage with saliency in d- and q-axis"
            extends Modelica.Icons.ObsoleteModel;
            extends Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortExtended;
            parameter Boolean useHeatPort=false
              "Enable / disable (=fixed temperatures) thermal port"
              annotation (Evaluate=true);
            parameter Modelica.Magnetic.FundamentalWave.Types.SalientResistance
              RRef(d(start=1), q(start=1)) "Salient cage resistance";
            parameter Modelica.SIunits.Temperature TRef(start=293.15)
              "Reference temperature of winding";
            parameter
              Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
              alpha20(start=0) "Temperature coefficient of winding at 20 degC";
            final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
                Modelica.Electrical.Machines.Thermal.convertAlpha(
                      alpha20,
                      TRef,
                      293.15) "Temperature coefficient of winding at reference temperature";
            parameter Modelica.SIunits.Temperature TOperational(start=293.15)
              "Operational temperature of winding"
              annotation (Dialog(enable=not useHeatPort));
            parameter Modelica.Magnetic.FundamentalWave.Types.SalientInductance
              Lsigma(d(start=1), q(start=1)) "Salient cage stray inductance";
            parameter Real effectiveTurns=1 "Effective number of turns";
            Modelica.Blocks.Interfaces.RealOutput i[2](
              each final quantity="ElectricCurrent",
              each final unit="A") = resistor.i "Currents out from damper";
            Modelica.Blocks.Interfaces.RealOutput lossPower(
              final quantity="Power",
              final unit="W") = sum(resistor.resistor.LossPower) "Damper losses";
            Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter
              winding(
              final m=2,
              final orientation={0,Modelica.Constants.pi/2},
              final effectiveTurns=fill(effectiveTurns, 2)) "Symmetric winding"
              annotation (Placement(transformation(
                  origin={0,-10},
                  extent={{-10,-10},{10,10}},
                  rotation=90)));
            Modelica.Electrical.Polyphase.Basic.Inductor strayInductor(final m=2,
                final L={Lsigma.d,Lsigma.q}) annotation (Placement(transformation(
                  origin={-20,-30},
                  extent={{10,-10},{-10,10}},
                  rotation=90)));
            Modelica.Electrical.Polyphase.Basic.Resistor resistor(
              final useHeatPort=useHeatPort,
              final m=2,
              final R={RRef.d,RRef.q},
              final T_ref=fill(TRef, 2),
              final alpha=fill(alphaRef, 2),
              final T=fill(TOperational, 2)) annotation (Placement(transformation(
                  origin={-20,-70},
                  extent={{10,10},{-10,-10}},
                  rotation=90)));
            Modelica.Electrical.Polyphase.Basic.Star star(final m=2) annotation (
                Placement(transformation(extent={{30,-90},{50,-70}})));
            Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                  transformation(
                  origin={70,-80},
                  extent={{-10,10},{10,-10}},
                  rotation=270)));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if useHeatPort "Heat ports of winding resistor" annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
            Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(final m=2) if useHeatPort "Connector of thermal rotor resistance heat ports" annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
          equation
            connect(port_p, winding.port_p)
              annotation (Line(points={{-100,0},{-10,0}}, color={255,128,0}));
            connect(winding.port_n, port_n)
              annotation (Line(points={{10,0},{100,0}}, color={255,128,0}));
            connect(ground.p, star.pin_n)
              annotation (Line(points={{60,-80},{50,-80}}, color={0,0,255}));
            connect(strayInductor.plug_n, resistor.plug_p)
              annotation (Line(points={{-20,-40},{-20,-60}}, color={0,0,255}));
            connect(winding.plug_n, resistor.plug_n) annotation (Line(
                points={{10,-20},{20,-20},{20,-80},{-20,-80}}, color={0,0,255}));
            connect(star.plug_p, winding.plug_n) annotation (Line(
                points={{30,-80},{20,-80},{20,-20},{10,-20}}, color={0,0,255}));
            connect(strayInductor.plug_p, winding.plug_p) annotation (Line(
                points={{-20,-20},{-10,-20}}, color={0,0,255}));
            connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
                points={{-40,-90},{-40,-100},{0,-100}}, color={191,0,0}));
            connect(resistor.heatPort, thermalCollector.port_a) annotation (Line(
                points={{-30,-70},{-40,-70}}, color={191,0,0}));
            annotation (defaultComponentName="cage", obsolete="Obsolete model, see #1536 (https://github.com/modelica/ModelicaStandardLibrary/issues/1536) and #3030 (https://github.com/modelica/ModelicaStandardLibrary/issues/3030), use Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding instead",
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                      -100},{100,100}}), graphics={Ellipse(
                          extent={{-80,80},{80,-80}},
                          fillColor={175,175,175},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{-20,76},{20,36}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{28,46},{68,6}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{28,-8},{68,-48}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{-20,-36},{20,-76}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{-68,-6},{-28,-46}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Ellipse(
                          extent={{-66,50},{-26,10}},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Line(points={{-80,0},{-100,
                    0}}, color={255,128,0}),Line(points={{100,0},{80,0}}, color={
                    255,128,0}),Text(
                          extent={{0,100},{0,140}},
                          textColor={0,0,255},
                          textString="%name")}), Documentation(info="<html>
<p>
Obsolete saliency cage model, see 
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1536\">#1536</a> and 
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3030\">#3030</a>, use 
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a> instead.
</p>
</html>"));
          end SaliencyCageWinding;
        end Components;
      end BasicMachines;
    end FundamentalWave;
  end Magnetic;
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
