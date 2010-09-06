within ModelicaTest;
package Math "Test models for Modelica.Math"
extends Modelica.Icons.ExamplesPackage;
  function ScalarFunctions
    import Modelica.Utilities.Streams;
    import Modelica.Math;
    input String logFile = "ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    constant Real pi = Modelica.Constants.pi;
  algorithm
    ok:=false;
    Streams.print("... Test of Modelica.Math.<scalar functions>", logFile);

    assert(abs(Math.sin(pi))         <= 1e-15, "sin is wrong");
    assert(abs(Math.cos(pi/2))       <= 1e-15, "cos is wrong");
    assert(abs(Math.tan(pi/4) - 1.0) <= 1e-15, "tan is wrong");
    assert(abs(Math.asin(1) - pi/2)  <= 1e-15, "asin is wrong");
    assert(abs(Math.acos(1))         <= 1e-15, "acos is wrong");
    assert(abs(Math.atan(1) - pi/4)  <= 1e-15, "atan is wrong");
    assert(abs(Math.atan2(1,1)-pi/4) <= 1e-15, "atan2 is wrong");
    assert(abs(Math.sinh(0))         <= 1e-15, "sinh is wrong");
    assert(abs(Math.cosh(0) - 1.0)   <= 1e-15, "cosh is wrong");
    assert(abs(Math.tanh(0))         <= 1e-15, "tanh is wrong");
    assert(abs(Math.log(1))          <= 1e-15, "log is wrong");
    assert(abs(Math.log10(1))        <= 1e-15, "log10 is wrong");
    assert(abs(Math.exp(1) - Modelica.Constants.e) <= 1e-15, "exp is wrong");

    ok:=true;
  end ScalarFunctions;

  function BooleanFunctions
    import Modelica.Utilities.Streams;
    import Modelica.Math.BooleanVectors;
    input String logFile = "ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    Boolean b1[:] = {true, true, true};
    Boolean b2[:] = {false, false, false};
    Boolean b3[:] = {false, true, false, true};
    Boolean b4[:] = {false, true, false};
  algorithm
    ok:=false;
    Streams.print("... Test of Modelica.Math.<Boolean functions>", logFile);

    assert(BooleanVectors.allTrue(b1) == true,  "allTrue is wrong at (1)");
    assert(BooleanVectors.allTrue(b2) == false, "allTrue is wrong at (2)");
    assert(BooleanVectors.allTrue(b3) == false, "allTrue is wrong at (3)");

    assert(BooleanVectors.anyTrue(b1) == true,  "anyTrue is wrong at (1)");
    assert(BooleanVectors.anyTrue(b2) == false, "anyTrue is wrong at (2)");
    assert(BooleanVectors.anyTrue(b3) == true,  "anyTrue is wrong at (3)");

    assert(BooleanVectors.oneTrue(b1) == false, "oneTrue is wrong at (1)");
    assert(BooleanVectors.oneTrue(b2) == false, "oneTrue is wrong at (2)");
    assert(BooleanVectors.oneTrue(b3) == false, "oneTrue is wrong at (3)");
    assert(BooleanVectors.oneTrue(b4) == true,  "oneTrue is wrong at (4)");

    assert(BooleanVectors.firstTrueIndex(b1) == 1, "firstTrueIndex is wrong at (1)");
    assert(BooleanVectors.firstTrueIndex(b2) == 0, "firstTrueIndex is wrong at (2)");
    assert(BooleanVectors.firstTrueIndex(b3) == 2, "firstTrueIndex is wrong at (3)");

    ok:=true;
  end BooleanFunctions;

  function Polynomials
    "Test functions of Modelica.Media.Incompressible.TableBased.Polynomials_Temp"
    import Modelica.Utilities.Streams;
    import Poly = Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
    input String logFile = "ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    Real p1[4] = {-2, -3, -4, -1};
    Real p2[5];
    Real p3[4];
    Real p4[4];
    Real r;
    Real r1;
    Real r2;
    Real u[7] = {0,1,2,3,4,5,6};
    Real y[7];
  algorithm
    Streams.print("... Test of Modelica.Media.Incompressible.TableBased.Polynomials_Temp", logFile);

    r := Poly.evaluate(p1,-3);
    assert(r == 38, "Polynomials.evaluate failed");

    p2 := Poly.integral(p1);
    assert( p2[1] == -0.5 and p2[2] == -1 and p2[3] == -2 and
            p2[4] == -1 and p2[5] == 0, "Polynomials.integral failed");

    p3 := Poly.derivative(p2);
    assert( p3[1] == p1[1] and p3[2] == p1[2] and p3[3] == p1[3] and p3[4] == p1[4],
           "Polynomials.derivative failed");

    r1 := Poly.derivativeValue(p2,-3);
    r2 := Poly.evaluate(p3, -3);
    assert(r1 == r2, "Polynomials.derivativeValue failed");

    r := Poly.integralValue(p1,2,1);
    assert(r == -21.5, "Polynomials.integralValue failed");

    for i in 1:size(u,1) loop
       y[i] := Poly.evaluate(p1,u[i]) + 0.01*i;
    end for;
    p4 := Poly.fitting(u,y,3);
    assert( abs(p4[1] - p1[1]) <= 1.e-8 and
            abs(p4[2] - p1[2]) <= 1.e-8 and
            abs(p4[3] - p1[3]) <= 0.1 and
            abs(p4[4] - p1[4]) <= 0.1, "Polynomials.fitting failed");

    ok := true;
  end Polynomials;

  function Matrices "Test functions of Modelica.Math.Matrices"
    import Modelica.Utilities.Streams;
    input String logFile = "ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
     Real A1[2,3] = [1,2,3;
                     4,5,6];
     Real A2[2,3] = [1,0,0;
                     4,0,0];
     Real b[2] =    {0,-2};

     Real A3[2,3] = [1,2,3;
                     4,5,6];
     Real a3[2] =   {0,-2};
     Real B3[1,3] = [4,3,0];
     Real b3[1] =   {2};

     Real A4[2,4] = [1,2,3,4;
                     4,5,6,7];
     Real a4[2] =   {0,-2};
     Real B4[1,4] = [4,3,0,-1];
     Real b4[1] =   {2};

     Real x1[3];
     Real x2[3];
     Real x3[3];
     Real e3[1] = B3*x3 - b3;
    //output Real x4[4] = Modelica.Math.Matrices.equalityLeastSquares(A4,a4,B4,b4);
  algorithm
    Streams.print("... Test of Modelica.Math.Matrices", logFile);
    x1 :=Modelica.Math.Matrices.leastSquares(A1, b);
    x2 :=Modelica.Math.Matrices.leastSquares(A2, b);
    x3 :=Modelica.Math.Matrices.equalityLeastSquares(
      A3,
      a3,
      B3,
      b3);
    ok := true;
  end Matrices;

  function Matrices2 "Test functions of Modelica.Math.Matrices"
    import Modelica.Math.Matrices;
  //   input String logFile = "ModelicaTestLog.txt"
  //     "Filename where the log is stored";
    output Boolean ok=false;
  protected
    Real r;
    Real c;
    Integer n;
    Real eps=1e-13;
    Real A1[5,5] = [ -3.6360,  -0.6921,  -1.1933,  -0.8137,   0.3507;
                     0.1406,  -2.9375,   0.9063,   0.1562,   0.3438;
                    -2.5735,  -1.4421,  -2.8183,  -1.1887,   1.2257;
                    -0.3779,   0.0810,   0.5544,  -1.5891,   0.0660;
                     0.8961,   1.1586,   1.6279,   0.5631,  -2.2066];

    Real C1[5,5] = transpose([-3.6914,  -3.9753, -0.0247,  -1.9012,   1.1111])*[-3.6914,  -3.9753, -0.0247,  -1.9012,   1.1111];
    Real X1[5,5];
    Real A1s[5,5]=transpose(Matrices.realSchur(A1));

    Real A2[4,4]=[0.0,   1.0,   0.0,   0.0;
                  0.0,  -1.890,   3.900e-01,  -5.530;
                  0.0,  -3.400e-02,  -2.980,   2.430;
                  3.400e-02,  -1.100e-03,  -9.900e-01,  -2.100e-01];
    Real B2[4,2]=[ 0.0,   0.0;
                  3.600e-01,  -1.60;
                 -9.500e-01,  -3.200e-02;
                  3.000e-02,   0.0];
    Real R2[2,2]=[1, 0; 0, 1];
    Real Q2[4,4]=[2.313,   2.727,   6.880e-01,   2.300e-02;
                 2.727,   4.271,  1.148,   3.230e-01;
                 6.880e-01,   1.148,   3.130e-01,   1.020e-01;
                 2.300e-02,   3.230e-01,   1.020e-01,   8.300e-02];
    Real X2[4,4];
    Real G2[size(A2, 1),size(A2, 1)]=B2*Matrices.solve2(R2, transpose(B2));

    Real A3[5,5] = [0.4562,   0.0308,   0.1990,   0.0861,   0.0217;
                    0.0637,   0.5142,  -0.1828,   0.0096,  -0.1148;
                    0.3139,   0.1287,   0.3484,   0.1653,  -0.1975;
                    0.1500,   0.0053,  -0.1838,   0.2501,  -0.0687;
                    0.0568,  -0.1006,  -0.3735,  -0.0202,   0.2285];

    Real L[5,5] = [0.4562,    0,        0,        0,        0;
                    0.0637,   0.5142,   0,        0,        0;
                    0.3139,   0.1287,   0.3484,   0,        0;
                    0.1500,   0.0053,  -0.1838,   0.2501,   0;
                    0.0568,  -0.1006,  -0.3735,  -0.0202,   0.2285];

    Real C3[5,5] = transpose([0.3086,   0.0247,  -0.4691,   0.1728,  -0.3704])*[0.3086,   0.0247,  -0.4691,   0.1728,  -0.3704];
    Real X3[5,5];
    Real A3s[5,5]=transpose(Matrices.realSchur(A3));

    Real A4[4,4]=[ 0.98475,  -0.079903,  0.0009054, -0.0010765;
                   0.041588,  0.99899,  -0.035855,   0.012684;
                  -0.54662,   0.044916, -0.32991,    0.19318;
                   2.6624,   -0.10045,  -0.92455,   -0.26325];
    Real B4[4,2]=[0.0037112, 0.0007361;
                 -0.087051, 9.3411e-6;
                 -1.19844, -4.1378e-4;
                 -3.1927, 9.2535e-4];
    Real R4[2,2]=identity(2);
    Real Q4[4,4]=0.01*identity(4);
    Real X4[4,4];

    Real A5[5,10]=[A1,A1];
    Real X5[10,:];

    Real A6[10,10]=transpose(A5)*A5;

    Real H1[5,5];
    Real U1[5,5];
    Real u[5];

    Real N[:,:]= fill(0,0,0);
    Real Xn[:,:];

  algorithm
  //  ##########   continuous Laypunov   ##########
    X1 := Matrices.continuousLyapunov(A1,C1);// benchmark example from SLICOT
    r := Matrices.norm(X1*A1+transpose(A1)*X1-C1);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousLyapunov\" failed");

    X1 := Matrices.continuousLyapunov(A1s,C1, true);// benchmark example from SLICOT
    r := Matrices.norm(X1*A1s+transpose(A1s)*X1-C1);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousLyapunov\" A' is Schur failed");

    Xn := Matrices.continuousLyapunov(N,N);

  //  ##########   continuous Sylvester   ##########
    X1 := Matrices.continuousSylvester(transpose(A1), A1, C1);
    r := Matrices.norm(X1*A1+transpose(A1)*X1-C1);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousSylvester\" failed");

    X1 := Matrices.continuousSylvester(transpose(A1s), A1, C1, true,  false);
    r := Matrices.norm(X1*A1+transpose(A1s)*X1-C1);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousSylvester\" A is Schur failed");

    Xn := Matrices.continuousSylvester(N,N,N);

  //  ##########   continuous Riccati   ##########
    X2 := Matrices.continuousRiccati(A2, B2, R2, Q2, false);
    r := Matrices.norm(Q2 + transpose(A2)*X2 + X2*A2 - X2*G2*X2);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousRiccati\" without refinement failed");

    X2 := Matrices.continuousRiccati(A2, B2, R2, Q2, true);
    r := Matrices.norm(Q2 + transpose(A2)*X2 + X2*A2 - X2*G2*X2);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousRiccati\" with refinement failed");

    Xn := Matrices.continuousRiccati(N,N,N,N);

  //  ##########   discrete Laypunov   ##########
    X3 := Matrices.discreteLyapunov(A3,C3, false, 1);// benchmark example from SLICOT
    r := Matrices.norm(transpose(A3)*X3*A3 + X3 - C3);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteLyapunov\" with sgn=1 failed");

    X3 := Matrices.discreteLyapunov(A3s,C3, true, 1);// benchmark example from SLICOT
    r := Matrices.norm(transpose(A3s)*X3*A3s + X3 - C3);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteLyapunov\" with A' is Schur and sgn=1 failed");

    X3 := Matrices.discreteLyapunov(A3,C3, false, -1);
    r := Matrices.norm(transpose(A3)*X3*A3 - X3 - C3);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteLyapunov\" with sgn=-1 failed");

    X3 := Matrices.discreteLyapunov(A3s,C3, false, -1);
    r := Matrices.norm(transpose(A3s)*X3*A3s - X3 - C3);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteLyapunov\" with A' is Schur and sgn=-1 failed");

    Xn := Matrices.discreteLyapunov(N,N);

  //  ##########   discrete Sylvester   ##########
    X3 := Matrices.discreteSylvester(transpose(A3),A3,C3, false, false, 1);
    r := Matrices.norm(transpose(A3)*X3*A3 + X3 - C3);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteSylvester\" with sgn=1 failed");

    X3 := Matrices.discreteSylvester(transpose(A3s),A3,C3, false, false, 1);
    r := Matrices.norm(transpose(A3s)*X3*A3 + X3 - C3);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteSylvester\" with A is Schur and sgn=1 failed");

    X3 := Matrices.discreteSylvester(transpose(A3),A3,C3, false, false, -1);
    r := Matrices.norm(transpose(A3)*X3*A3 - X3 - C3);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteSylvester\" with sgn=-1 failed");

    X3 := Matrices.discreteSylvester(transpose(A3s),A3,C3, false, false, -1);
    r := Matrices.norm(transpose(A3s)*X3*A3 - X3 - C3);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteSylvester\" with A is Schur and sgn=-1 failed");

    Xn := Matrices.discreteSylvester(N,N,N);

  //  ##########   discrete Riccati   ##########
  // Example from
  //    P.BENNER, A.J. LAUB, V. MEHRMANN: 'A Collection of Benchmark
  //    Examples for the Numerical Solution of Algebraic Riccati
  //    Equations II: Discrete-Time Case', Tech. Report SPC 95_23,
  //    Fak. f. Mathematik, TU Chemnitz-Zwickau (Germany), December 1995:
    X4 := Matrices.discreteRiccati(A4, B4, R4, Q4, false);
    r := Matrices.norm(transpose(A4)*X4*A4 - X4 + Q4 - transpose(A4)*X4*B4*Matrices.solve2(R4+transpose(B4)*X4*B4,transpose(B4)*X4*A4));
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteRiccati\" without refinement failed");

    X4 := Matrices.discreteRiccati(A4, B4, R4, Q4, true);
    r := Matrices.norm(transpose(A4)*X4*A4 - X4 + Q4 - transpose(A4)*X4*B4*Matrices.solve2(R4+transpose(B4)*X4*B4,transpose(B4)*X4*A4));
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteRiccati\" with refinement failed");

    Xn := Matrices.discreteRiccati(N,N,N,N);

  //  ##########   trace   ##########
    r := Matrices.trace(diagonal(1:100))-sum(1:100);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r)<Modelica.Constants.small, "\"Matrices.trace\" failed");

    c := Matrices.trace(N);

  //  ##########   condition number   ##########
    c := Matrices.conditionNumber(A1);
    r := c - Matrices.norm(A1)*Matrices.norm(Matrices.inv(A1));
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r)<eps, "\"condition number\" p=2");

    c := Matrices.conditionNumber(A1,1);
    r := c - Matrices.norm(A1,1)*Matrices.norm(Matrices.inv(A1),1);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r)<eps, "\"condition number\" p=1");

    c := Matrices.conditionNumber(A1,Modelica.Constants.inf);
    r := c - Matrices.norm(A1,Modelica.Constants.inf)*Matrices.norm(Matrices.inv(A1),Modelica.Constants.inf);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r)<eps, "\"condition number\" p=Modelica.Constants.inf");

    c := Matrices.conditionNumber(N);

    c := Matrices.rcond(A1,false);
    r := 1/c - Matrices.norm(A1,1)*Matrices.norm(Matrices.inv(A1),1);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r)<eps, "\"rcond\" p=1");

    c := Matrices.rcond(A1,true);
    r := 1/c - Matrices.norm(A1,Modelica.Constants.inf)*Matrices.norm(Matrices.inv(A1),Modelica.Constants.inf);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r)<eps, "\"rcond\" p=Modelica.Constants.inf");

    c := Matrices.rcond(N);

  //  ##########   nullspace   ##########
    (X5, n) := Matrices.nullSpace(A5);
    r := Matrices.norm(A5*X5,1);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r)<eps, "\"nullSpace\"");
    assert(Modelica.Math.Vectors.isEqual(array(Modelica.Math.Vectors.length(X5[:,i]) for i in 1:n),fill(1,n),eps),"\"nullSpace\" nullspace is not orthonormal");

    (Xn, n) := Matrices.nullSpace(N);

  //  ##########   Frobenius norm   ##########
    c := Matrices.frobeniusNorm(A5);
    r := c-sqrt(sum(array(A6[i,i] for i in 1:size(A6,1))));
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r)<Modelica.Constants.small, "\"frobeniusNorm\"");

    c := Matrices.frobeniusNorm(N);

  //  ##########   Hessenberg, Schur, Cholesky and toString   ##########
    (H1,U1) := Modelica.Math.Matrices.hessenberg(A1);
    Modelica.Math.Matrices.toString(H1,"Hessenberg",6);
    r := Matrices.norm(U1*H1*transpose(U1)-A1);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r)<eps, "\"hessenberg\"");
    H1 := Modelica.Math.Matrices.realSchur(A1);
    Modelica.Math.Matrices.toString(H1,"realSchur",6);
    H1 := Modelica.Math.Matrices.cholesky(L*transpose(L), false);
    r := Matrices.norm(H1-L);
    Modelica.Utilities.Streams.print("r = "+String(r));
    assert(abs(r)<eps, "\"cholesky\"");

    Xn := Modelica.Math.Matrices.hessenberg(N);
    Xn := Modelica.Math.Matrices.realSchur(N);

  //  ##########   Utilities tests without result verification   ##########
    u[2:5] := Modelica.Math.Vectors.Utilities.householderVector(A1[2:5,1],{1,0,0,0});
    H1 := Matrices.Utilities.householderReflection(A1,u);
    H1 := Matrices.Utilities.householderSimilarityTransformation(A1,u);
    u := H1[:,1];
    H1 := Matrices.Utilities.toUpperHessenberg(A1);
    r := Modelica.Math.Vectors.norm(u-H1[:,1]);
    Modelica.Utilities.Streams.print("rf = "+String(r));
    assert(abs(r)<eps, "\"Utilities\"");

    Xn := Matrices.Utilities.householderReflection(N,fill(0,0));
    Xn := Matrices.Utilities.householderSimilarityTransformation(N,fill(0,0));

    ok := true;
  end Matrices2;

  function Vectors "Test functions of Modelica.Math.Matrices"
    import Modelica.Math.Vectors;
    import Modelica.Math.Vectors.Utilities;
    import Modelica.Utilities.Streams;

  //  input String logFile = "ModelicaTestLog.txt" "Filename where the log is stored";
    output Boolean ok;
  protected
    Real c;
    Real r;
    Real eps=1e-13;
    Real a[4] = {2, -4, -2, -1};
    Real b[4] = {1, 0, 0, 0};
    Real a2[size(a,1)];
    Real a3[size(a,1)];
    Real u[4];
    Real P[4,4];
    Real rr[size(a,1)-1,2];
    Complex rc[3];
    Complex h;

  algorithm
  //  ##########   Householder vector   ##########
    u := Vectors.Utilities.householderVector(a,b);
    P := identity(size(u,1)) - 2*matrix(u)*transpose(matrix(u))/(u*u);
    a2 := P*a;
    c := a2[1]/b[1];
    r := Vectors.norm(a2-c*b);
    Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Vectors.Utilities.householderVector()\" failed");

    a3 := Vectors.Utilities.householderReflection(a,u);
    r := Vectors.norm(a2-a3);
    Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Vectors.Utilities.householderReflection()\" failed");

  //  ##########   roots   ##########
    rr := Vectors.Utilities.roots(a);
    rc := rr*{Complex(1,0),Complex(0,1)};
    r := 0;
    for i in 1:size(rc,1) loop
      h := Complex(0,0);
      for j in 1:size(a,1) loop
        h := h + a[j]*(rc[i])^(size(a,1)-j);
      end for;
      r := r + sqrt(h.re^2 + h.im^2);
    end for;
    Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Vectors.Utilities.roots()\" failed");

    ok := true;
  end Vectors;

  function colorMapToSvg "Store all predefined color maps in svg"
    import Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg;
    import Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.*;
    import
      Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg.HeaderType;
  algorithm
    colorMapToSvg(jet(),    x= 10, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="jet",   headerType=colorMapToSvg.HeaderType.svgBegin);
    colorMapToSvg(hot(),    x= 30, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="hot",   headerType=colorMapToSvg.HeaderType.noHeader);
    colorMapToSvg(gray(),   x= 50, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="gray",  headerType=colorMapToSvg.HeaderType.noHeader);
    colorMapToSvg(spring(), x= 70, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="spring",headerType=colorMapToSvg.HeaderType.noHeader);
    colorMapToSvg(summer(), x= 90, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="summer",headerType=colorMapToSvg.HeaderType.noHeader);
    colorMapToSvg(autumn(), x=110, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="autumn",headerType=colorMapToSvg.HeaderType.noHeader);
    colorMapToSvg(winter(), x=130, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="winter",headerType=colorMapToSvg.HeaderType.svgEnd);

  end colorMapToSvg;
end Math;
