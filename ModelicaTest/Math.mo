within ModelicaTest;
package Math "Test models for Modelica.Math"
extends Modelica.Icons.ExamplesPackage;
  function ScalarFunctions
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams;
    import Modelica.Math;
    input String logFile = "ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    constant Real pi = Modelica.Constants.pi;
  algorithm
    ok:=false;
    Streams.print("... Test of Modelica.Math.<scalar functions>");
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

    assert(Math.isPowerOf2(1), "isPowerOf2(1) is wrong");
    assert(Math.isPowerOf2(4), "isPowerOf2(4) is wrong");
    assert(not Math.isPowerOf2(9), "isPowerOf2(9) is wrong");
    ok:=true;
  end ScalarFunctions;

  function BooleanFunctions
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams;
    import Modelica.Math.BooleanVectors;
    input String logFile="ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    Boolean b1[:]={true,true,true};
    Boolean b2[:]={false,false,false};
    Boolean b3[:]={false,true,false,true};
    Boolean b4[:]={false,true,false};
    Integer b1Result[size(b1, 1)];
    Integer b2Result[size(b2, 1)];
    Integer b3Result[size(b3, 1)];
    Integer b3Result2[2];
    Integer b1Desired[size(b1, 1)]={1,2,3};
    Integer b2Desired[size(b2, 1)]={0,0,0};
    Integer b3Desired[size(b3, 1)]={0,1,0,2};
    Integer b3Desired2[2]={2,4};
  algorithm
    ok := false;
    Streams.print("... Test of Modelica.Math.<Boolean functions>");
    Streams.print("... Test of Modelica.Math.<Boolean functions>", logFile);

    assert(BooleanVectors.allTrue(fill(true, 0)) == false, "allTrue is wrong for empty vector");
    assert(BooleanVectors.allTrue(b1) == true, "allTrue is wrong at (1)");
    assert(BooleanVectors.allTrue(b2) == false, "allTrue is wrong at (2)");
    assert(BooleanVectors.allTrue(b3) == false, "allTrue is wrong at (3)");

    assert(BooleanVectors.andTrue(fill(false, 0)) == true, "andTrue is wrong for empty vector");
    assert(BooleanVectors.andTrue(b1) == true, "andTrue is wrong at (1)");
    assert(BooleanVectors.andTrue(b2) == false, "andTrue is wrong at (2)");
    assert(BooleanVectors.andTrue(b3) == false, "andTrue is wrong at (3)");

    assert(BooleanVectors.anyTrue(fill(true, 0)) == false, "anyTrue is wrong for empty vector");
    assert(BooleanVectors.anyTrue(b1) == true, "anyTrue is wrong at (1)");
    assert(BooleanVectors.anyTrue(b2) == false, "anyTrue is wrong at (2)");
    assert(BooleanVectors.anyTrue(b3) == true, "anyTrue is wrong at (3)");

    assert(BooleanVectors.oneTrue(b1) == false, "oneTrue is wrong at (1)");
    assert(BooleanVectors.oneTrue(b2) == false, "oneTrue is wrong at (2)");
    assert(BooleanVectors.oneTrue(b3) == false, "oneTrue is wrong at (3)");
    assert(BooleanVectors.oneTrue(b4) == true, "oneTrue is wrong at (4)");

    assert(BooleanVectors.countTrue(b1) == 3, "countTrue is wrong at (1)");
    assert(BooleanVectors.countTrue(b2) == 0, "countTrue is wrong at (2)");
    assert(BooleanVectors.countTrue(b3) == 2, "countTrue is wrong at (3)");

    b1Result := BooleanVectors.enumerate(b1);
    for i in 1:size(b1, 1) loop
      assert(b1Result[i] == b1Desired[i], "enumerate(..) return vector is wrong at entry " + String(i) + " of (1)");
    end for;

    b2Result := BooleanVectors.enumerate(b2);
    for i in 1:size(b2, 1) loop
      assert(b2Result[i] == b2Desired[i], "enumerate(..) return vector is wrong at entry " + String(i) + " of (2)");
    end for;

    b3Result := BooleanVectors.enumerate(b3);
    for i in 1:size(b3, 1) loop
      assert(b3Result[i] == b3Desired[i], "enumerate(..) return vector is wrong at entry " + String(i) + " of (3)");
    end for;

    assert(BooleanVectors.firstTrueIndex(b1) == 1, "firstTrueIndex(..) return is wrong at (1)");
    assert(BooleanVectors.firstTrueIndex(b2) == 0, "firstTrueIndex(..) return is wrong at (2)");
    assert(BooleanVectors.firstTrueIndex(b3) == 2, "firstTrueIndex(..) return is wrong at (3)");

    b1Result := BooleanVectors.index(b1);
    for i in 1:3 loop
      assert(b1Result[i] == b1Desired[i], "index(..) return vector is wrong at entry " + String(i) + " of (1)");
    end for;
    assert(size(BooleanVectors.index(b2), 1) == 0, "index(..) return is wrong at (2)");

    b3Result2 := BooleanVectors.index(b3);
    for i in 1:2 loop
      assert(b3Result2[i] == b3Desired2[i], "index(..) return vector is wrong at entry " + String(i) + " of (3)");
    end for;

    ok := true;
  end BooleanFunctions;

  function Polynomials
    "Test functions of Modelica.Math.Polynomials"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams;
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
    Streams.print("... Test of Modelica.Math.Polynomials");
    Streams.print("... Test of Modelica.Math.Polynomials", logFile);

    r := Modelica.Math.Polynomials.evaluate(p1,-3);
    assert(r == 38, "Polynomials.evaluate failed");

    p2 := Modelica.Math.Polynomials.integral(p1);
    assert( p2[1] == -0.5 and p2[2] == -1 and p2[3] == -2 and
            p2[4] == -1 and p2[5] == 0, "Polynomials.integral failed");

    p3 := Modelica.Math.Polynomials.derivative(p2);
    assert( p3[1] == p1[1] and p3[2] == p1[2] and p3[3] == p1[3] and p3[4] == p1[4],
           "Polynomials.derivative failed");

    r1 := Modelica.Math.Polynomials.derivativeValue(p2,-3);
    r2 := Modelica.Math.Polynomials.evaluate(p3, -3);
    assert(r1 == r2, "Polynomials.derivativeValue failed");

    r := Modelica.Math.Polynomials.integralValue(p1,2,1);
    assert(r == -21.5, "Polynomials.integralValue failed");

    for i in 1:size(u,1) loop
       y[i] := Modelica.Math.Polynomials.evaluate(p1,u[i]) + 0.01*i;
    end for;
    p4 := Modelica.Math.Polynomials.fitting(u,y,3);
    assert( abs(p4[1] - p1[1]) <= 1.e-8 and
            abs(p4[2] - p1[2]) <= 1.e-8 and
            abs(p4[3] - p1[3]) <= 0.1 and
            abs(p4[4] - p1[4]) <= 0.1, "Polynomials.fitting failed");

    ok := true;
  end Polynomials;

  function Matrices "Test functions of Modelica.Math.Matrices"
    extends Modelica.Icons.Function;
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
    Streams.print("... Test of Modelica.Math.Matrices");
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
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices;
       input String logFile = "ModelicaTestLog.txt"
      "Filename where the log is stored";
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
    Real X5[10,5];

    Real A6[10,10]=transpose(A5)*A5;

    Real H1[5,5];
    Real U1[5,5];

    Real N[:,:]= fill(0,0,0);
    Real Xn[0,0];

    Real A7[:,:] = [1, 2,  3,  4;
                    3, 4,  5, -2;
                   -1, 2, -3,  5];
    Real sigma7[size(A7,1)];
    Real U7[size(A7, 1), size(A7, 1)];
    Real VT7[size(A7, 2), size(A7, 2)];
    Real A8[0,0];
    Real sigma8[0];
    Real U8[0,0];
    Real VT8[0,0];
    Real TA1[5,5]=[4,1,2,3,5;0,1,2,3,5;0,4,5,6,8;0,7,8,9,1;0,0,0,0,2]; // In block Hessenberg form
    Real TH1[5,5];
    Real TH2[5,5];
  algorithm
  //  ##########   continuous Lyapunov   ##########
    X1 := Matrices.continuousLyapunov(A1,C1);// benchmark example from SLICOT
    r := Matrices.norm(X1*A1+transpose(A1)*X1-C1);
    Modelica.Utilities.Streams.print("continuous Lyapunov: r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousLyapunov\" failed");

    X1 := Matrices.continuousLyapunov(A1s,C1, true);// benchmark example from SLICOT
    r := Matrices.norm(X1*A1s+transpose(A1s)*X1-C1);
    Modelica.Utilities.Streams.print("continuous Lyapunov: r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousLyapunov\" A' is Schur failed");

    Xn := Matrices.continuousLyapunov(N,N);

  //  ##########   continuous Sylvester   ##########
    X1 := Matrices.continuousSylvester(transpose(A1), A1, C1);
    r := Matrices.norm(X1*A1+transpose(A1)*X1-C1);
    Modelica.Utilities.Streams.print("continuous Sylvester: r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousSylvester\" failed");

    X1 := Matrices.continuousSylvester(transpose(A1s), A1, C1, true,  false);
    r := Matrices.norm(X1*A1+transpose(A1s)*X1-C1);
    Modelica.Utilities.Streams.print("continuous Sylvester: r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousSylvester\" A is Schur failed");

    Xn := Matrices.continuousSylvester(N,N,N);

  //  ##########   continuous Riccati   ##########
    X2 := Matrices.continuousRiccati(A2, B2, R2, Q2, false);
    r := Matrices.norm(Q2 + transpose(A2)*X2 + X2*A2 - X2*G2*X2);
    Modelica.Utilities.Streams.print("continuous Riccati r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousRiccati\" without refinement failed");

    X2 := Matrices.continuousRiccati(A2, B2, R2, Q2, true);
    r := Matrices.norm(Q2 + transpose(A2)*X2 + X2*A2 - X2*G2*X2);
    Modelica.Utilities.Streams.print("continuous Riccati r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.continuousRiccati\" with refinement failed");

    Xn := Matrices.continuousRiccati(N,N,N,N);

  //  ##########   discrete Lyapunov   ##########
    X3 := Matrices.discreteLyapunov(A3,C3, false, 1);// benchmark example from SLICOT
    r := Matrices.norm(transpose(A3)*X3*A3 + X3 - C3);
    Modelica.Utilities.Streams.print("discrete Lyapunov r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteLyapunov\" with sgn=1 failed");

    X3 := Matrices.discreteLyapunov(A3s,C3, true, 1);// benchmark example from SLICOT
    r := Matrices.norm(transpose(A3s)*X3*A3s + X3 - C3);
    Modelica.Utilities.Streams.print("discrete Lyapunov r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteLyapunov\" with A' is Schur and sgn=1 failed");

    X3 := Matrices.discreteLyapunov(A3,C3, false, -1);
    r := Matrices.norm(transpose(A3)*X3*A3 - X3 - C3);
    Modelica.Utilities.Streams.print("discrete Lyapunov r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteLyapunov\" with sgn=-1 failed");

    X3 := Matrices.discreteLyapunov(A3s,C3, false, -1);
    r := Matrices.norm(transpose(A3s)*X3*A3s - X3 - C3);
    Modelica.Utilities.Streams.print("discrete Lyapunov r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteLyapunov\" with A' is Schur and sgn=-1 failed");

    Xn := Matrices.discreteLyapunov(N,N);

  //  ##########   discrete Sylvester   ##########
    X3 := Matrices.discreteSylvester(transpose(A3),A3,C3, false, false, 1);
    r := Matrices.norm(transpose(A3)*X3*A3 + X3 - C3);
    Modelica.Utilities.Streams.print("discrete Sylvester r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteSylvester\" with sgn=1 failed");

    X3 := Matrices.discreteSylvester(transpose(A3s),A3,C3, false, false, 1);
    r := Matrices.norm(transpose(A3s)*X3*A3 + X3 - C3);
    Modelica.Utilities.Streams.print("discrete Sylvester r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteSylvester\" with A is Schur and sgn=1 failed");

    X3 := Matrices.discreteSylvester(transpose(A3),A3,C3, false, false, -1);
    r := Matrices.norm(transpose(A3)*X3*A3 - X3 - C3);
    Modelica.Utilities.Streams.print("discrete Sylvester r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteSylvester\" with sgn=-1 failed");

    X3 := Matrices.discreteSylvester(transpose(A3s),A3,C3, false, false, -1);
    r := Matrices.norm(transpose(A3s)*X3*A3 - X3 - C3);
    Modelica.Utilities.Streams.print("discrete Sylvester r = "+String(r));
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
    Modelica.Utilities.Streams.print("discrete Riccati r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteRiccati\" without refinement failed");

    X4 := Matrices.discreteRiccati(A4, B4, R4, Q4, true);
    r := Matrices.norm(transpose(A4)*X4*A4 - X4 + Q4 - transpose(A4)*X4*B4*Matrices.solve2(R4+transpose(B4)*X4*B4,transpose(B4)*X4*A4));
    Modelica.Utilities.Streams.print("discrete Riccati r = "+String(r));
    assert(abs(r) <eps, "\"Matrices.discreteRiccati\" with refinement failed");

    Xn := Matrices.discreteRiccati(N,N,N,N);

  //  ##########   trace   ##########
    r := Matrices.trace(diagonal(1:100))-sum(1:100);
    Modelica.Utilities.Streams.print("trace r = "+String(r));
    assert(abs(r)<Modelica.Constants.small, "\"Matrices.trace\" failed");

    c := Matrices.trace(N);

  //  ##########   condition number   ##########
    c := Matrices.conditionNumber(A1);
    r := c - Matrices.norm(A1)*Matrices.norm(Matrices.inv(A1));
    Modelica.Utilities.Streams.print("condition number r = "+String(r));
    assert(abs(r)<eps, "\"condition number\" p=2");

    c := Matrices.conditionNumber(A1,1);
    r := c - Matrices.norm(A1,1)*Matrices.norm(Matrices.inv(A1),1);
    Modelica.Utilities.Streams.print("condition number r = "+String(r));
    assert(abs(r)<eps, "\"condition number\" p=1");

    c := Matrices.conditionNumber(A1,Modelica.Constants.inf);
    r := c - Matrices.norm(A1,Modelica.Constants.inf)*Matrices.norm(Matrices.inv(A1),Modelica.Constants.inf);
    Modelica.Utilities.Streams.print("condition number r = "+String(r));
    assert(abs(r)<eps, "\"condition number\" p=Modelica.Constants.inf");

    c := Matrices.conditionNumber(N);

    c := Matrices.rcond(A1,false);
    r := 1/c - Matrices.norm(A1,1)*Matrices.norm(Matrices.inv(A1),1);
    Modelica.Utilities.Streams.print("condition number r = "+String(r));
    assert(abs(r)<eps, "\"rcond\" p=1");

    c := Matrices.rcond(A1,true);
    r := 1/c - Matrices.norm(A1,Modelica.Constants.inf)*Matrices.norm(Matrices.inv(A1),Modelica.Constants.inf);
    Modelica.Utilities.Streams.print("condition number r = "+String(r));
    assert(abs(r)<eps, "\"rcond\" p=Modelica.Constants.inf");

    c := Matrices.rcond(N);

  //  ##########   Frobenius norm   ##########
    c := Matrices.frobeniusNorm(A5);
    r := c-sqrt(sum(array(A6[i,i] for i in 1:size(A6,1))));
    Modelica.Utilities.Streams.print("Frobenius norm r = "+String(r));
    assert(abs(r)<eps, "\"frobeniusNorm\"");

    c := Matrices.frobeniusNorm(N);

  //  ##########   Hessenberg, Schur, Cholesky and toString   ##########
    (H1,U1) := Modelica.Math.Matrices.hessenberg(A1);
    Modelica.Math.Matrices.toString(H1,"Hessenberg",6);
    r := Matrices.norm(U1*H1*transpose(U1)-A1);
    Modelica.Utilities.Streams.print("Hessenberg, r = "+String(r));
    assert(abs(r)<eps, "\"hessenberg\"");
    H1 := Modelica.Math.Matrices.realSchur(A1);
    Modelica.Math.Matrices.toString(H1,"realSchur",6);
    H1 := Modelica.Math.Matrices.cholesky(L*transpose(L), false);
    r := Matrices.norm(H1-L);
    Modelica.Utilities.Streams.print("RealSchur r = "+String(r));
    assert(abs(r)<eps, "\"cholesky\"");

    Xn := Modelica.Math.Matrices.hessenberg(N);
    Xn := Modelica.Math.Matrices.realSchur(N);

    TH1 := Modelica.Math.Matrices.Utilities.toUpperHessenberg(TA1);
    TH2 := Modelica.Math.Matrices.Utilities.toUpperHessenberg(TA1,2,4);
    r := Matrices.norm(TH1-TH2);
    Modelica.Utilities.Streams.print("Optimized toUpperHessenberg: r = "+String(r));
    assert(r<eps, "\"toUpperHessenberg with ilo and ihi\"");

  //  ##########   Singular values   ##########
    (sigma7, U7, VT7) := Matrices.singularValues(A7);
    r := Matrices.norm(A7 - U7*[diagonal(sigma7), zeros(3,1)]*VT7);
    Modelica.Utilities.Streams.print("SingularValues, r = "+String(r));
    assert(abs(r)<eps, "\"singular values\"");
    (sigma8, U8, VT8) := Matrices.singularValues(A8);
    Modelica.Utilities.Streams.print("SingularValues with zero dimensions");

    ok := true;
  end Matrices2;

  function Matrices2b "Test balance functions of Modelica.Math.Matrices"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams.print;
    import Modelica.Math.Matrices;
    import Modelica.Math.Vectors;
    output Boolean ok=false;
  protected
    constant Real A[3,3] = [1, -10,  1000; 0.01,  0,  10; 0.005,  -0.01,  10];
    constant Real B[3,2] = [100, 10; 1,0; -0.003, 1];
    constant Real C[1,3] = [-0.5, 1, 100];
    Real As[3,3];
    Real Bs[3,2];
    Real Cs[1,3];

    Real As2[3,3];
    Real Bs2[3,2];
    Real Cs2[1,3];

    Real scale[3];
    Real T[3,3];
    Real Diff[4,5];
    Real Diff2[3,5];
    Real Diff3[4,3];
    Real err;
    constant Real eps = 100*Modelica.Constants.eps;
  algorithm
    // Matrices.balance
    print("\n... Matrices.balance(A)");
    (scale, As) :=Matrices.balance(A);
    print("A     = " + Matrices.toString(A));
    print("As    = " + Matrices.toString(As));
    print("scale = " + Vectors.toString(scale));
    print("norm(A)  = " + String(Matrices.norm(A)));
    print("norm(As) = " + String(Matrices.norm(As)));
    T :=diagonal(scale);
    err := Matrices.norm( Matrices.inv(T)*A*T - As);
    assert(err < eps, "\"Matrices.balance - test 1\" failed");

    // Matrices.balanceABC
    print("\n... Matrices.balanceABC(A,B,C)");
    (scale, As, Bs, Cs) := Matrices.balanceABC(A,B,C);
    /*
  print("A  = " + Matrices.toString(A));
  print("As = " + Matrices.toString(As));
  print("B  = " + Matrices.toString(B));
  print("Bs = " + Matrices.toString(Bs));
  print("C  = " + Matrices.toString(C));
  print("Cs = " + Matrices.toString(Cs));
  print("scale = " + Vectors.toString(scale));
  */
    print("norm(A)  = " + String(Matrices.norm(A)) +
          ", norm(B)  = " + String(Matrices.norm(B))+
          ", norm(C)  = " + String(Matrices.norm(C)));
    print("norm(As) = " + String(Matrices.norm(As)) +
          ", norm(Bs) = " + String(Matrices.norm(Bs))+
          ", norm(Cs) = " + String(Matrices.norm(Cs)));
    T :=diagonal(scale);
    print("scale = " + Vectors.toString(scale));

    Diff := [Matrices.inv(T)*A*T, Matrices.inv(T)*B;
              C*T, zeros(1,2)] - [As, Bs; Cs, zeros(1,2)];
    err := Matrices.norm(Diff);
    assert(err < eps, "\"Matrices.balanceABC - test 2\" failed");

    // Balance [A,B]
    print("\n... Matrices.balanceABC(A,B)");
    (scale, As2, Bs2) := Matrices.balanceABC(A,B);
    print("norm(A)   = " + String(Matrices.norm(A)) +
          ", norm(B)   = " + String(Matrices.norm(B)));
    print("norm(As2) = " + String(Matrices.norm(As2)) +
          ", norm(Bs2) = " + String(Matrices.norm(Bs2)));
    T :=diagonal(scale);
    Diff2 := [Matrices.inv(T)*A*T, Matrices.inv(T)*B] - [As2, Bs2];
    err := Matrices.norm(Diff);
    assert(err < eps, "\"Matrices.balanceABC - test 3\" failed");

    // Balance [A;C]
    print("\n... Matrices.balanceABC(A,C=C)");
    (scale,As2,,Cs2) := Matrices.balanceABC(A,zeros(3,2),C);
    print("norm(A)   = " + String(Matrices.norm(A)) +
          ", norm(C)   = " + String(Matrices.norm(C)));
    print("norm(As2) = " + String(Matrices.norm(As2)) +
          ", norm(Cs2) = " + String(Matrices.norm(Cs2)));
    T :=diagonal(scale);
    Diff3 := [Matrices.inv(T)*A*T; C*T] - [As2; Cs2];
    err := Matrices.norm(Diff3);
    assert(err < eps, "\"Matrices.balanceABC - test 4\" failed");

    ok := true;
  end Matrices2b;

  function Matrices3
    "Test functions of Modelica.Math.Matrices that cannot be used in a model since output array dimension depends on computation"
    extends Modelica.Icons.Function;
    import Modelica.Math.Matrices;
  //   input String logFile = "ModelicaTestLog.txt"
  //     "Filename where the log is stored";
    output Boolean ok=false;
  protected
    Real eps=1e-13;
    Real A1[5,5] = [ -3.6360,  -0.6921,  -1.1933,  -0.8137,   0.3507;
                      0.1406,  -2.9375,   0.9063,   0.1562,   0.3438;
                     -2.5735,  -1.4421,  -2.8183,  -1.1887,   1.2257;
                     -0.3779,   0.0810,   0.5544,  -1.5891,   0.0660;
                      0.8961,   1.1586,   1.6279,   0.5631,  -2.2066];

    Real A5[5,10]=[A1,A1];
    Real X5[10,5];

    Real N[:,:]= fill(0,0,0);
    Real Xn[0,0];
    Real r;
    Integer n;

  algorithm
  //  ##########   nullspace   ##########
    (X5, n) := Matrices.nullSpace(A5);
    r := Matrices.norm(A5*X5,1);
    Modelica.Utilities.Streams.print("r = "+String(r) + ", nullity = " +String(n));
    assert(abs(r)<eps, "\"nullSpace\"");
    //assert(Modelica.Math.Vectors.isEqual(array(Modelica.Math.Vectors.length(X5[:,i]) for i in 1:n),fill(1,n),eps),"\"nullSpace\" nullspace is not orthonormal");

    (Xn, n) := Matrices.nullSpace(N);

    ok := true;
  end Matrices3;

  function Vectors "Test functions of Modelica.Math.Matrices"
    import Modelica.ComplexMath.j;
    extends Modelica.Icons.Function;
    import Modelica.Math.Vectors;
    import Modelica.Math.Polynomials;
    import Modelica.Utilities.Streams;

  //  input String logFile = "ModelicaTestLog.txt" "Filename where the log is stored";
    output Boolean ok;
  protected
    Real r;
    Real eps=1e-13;
    Real a[4] = {2, -4, -2, -1};
    Real rr[size(a,1)-1,2];
    Complex rc[3];
    Complex h;
    Real x[:] = {1,2,3,4,4,5,6,7,7,8,9};
    Real y[size(x,1)] = {1,4,9,16,1,25-15, 36-15, 49-15, 2, 64-47, 81-47};
    Real yi;
    Real iNew;
    Complex ca[2] = {Complex(1,0), j};
  algorithm
  //  ##########   roots   ##########
    rr := Polynomials.roots(a);
    for i in 1:size(rc,1) loop
       rc[i] := rr[i,1]*ca[1] + rr[i,2]*ca[2];
    end for;

    r := 0;
    for i in 1:size(rc,1) loop
      h := Complex(0,0);
      for j in 1:size(a,1) loop
        h := h + a[j]*(rc[i])^(size(a,1)-j);
      end for;
      r := r + sqrt(h.re^2 + h.im^2);
    end for;

    Streams.print("r = "+String(r));
    assert(abs(r) <eps, "\"Polynomials.roots()\" failed");

  //  ##########   interpolate   ##########
    (yi, iNew) :=Vectors.interpolate(x,y,6.5,4);
    assert(abs(yi-27.5) < eps, "\"Vectors.interpolate()\" failed");
    (yi, iNew) :=Vectors.interpolate(x,y,6.5,9);
    assert(abs(yi-27.5) < eps, "\"Vectors.interpolate()\" failed");
    (yi, iNew) :=Vectors.interpolate(x,y,4.0,2);
    assert(abs(yi-1.0) < eps, "\"Vectors.interpolate()\" failed");

    ok := true;
  end Vectors;

  function colorMapToSvg "Store all predefined color maps in svg"
    extends Modelica.Icons.Function;
    import Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg;
    import Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.{jet, hot, gray, spring, summer, autumn, winter};
    output Boolean ok;
  algorithm
    colorMapToSvg(jet(),    x= 10, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="jet",   headerType=colorMapToSvg.HeaderType.svgBegin);
    colorMapToSvg(hot(),    x= 30, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="hot",   headerType=colorMapToSvg.HeaderType.noHeader);
    colorMapToSvg(gray(),   x= 50, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="gray",  headerType=colorMapToSvg.HeaderType.noHeader);
    colorMapToSvg(spring(), x= 70, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="spring",headerType=colorMapToSvg.HeaderType.noHeader);
    colorMapToSvg(summer(), x= 90, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="summer",headerType=colorMapToSvg.HeaderType.noHeader);
    colorMapToSvg(autumn(), x=110, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="autumn",headerType=colorMapToSvg.HeaderType.noHeader);
    colorMapToSvg(winter(), x=130, height=50, width=5, nScalars=6, T_max=10, fontSize=8, textWidth=5, caption="winter",headerType=colorMapToSvg.HeaderType.svgEnd);
    ok :=true;
  end colorMapToSvg;

  model TestScalarFunctions
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Math.ScalarFunctions();
    end when;

    annotation (experiment(StopTime=0));
  end TestScalarFunctions;

  model TestBooleanFunctions
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Math.BooleanFunctions();
    end when;

    annotation (experiment(StopTime=0));
  end TestBooleanFunctions;

  model TestPolynomials
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Math.Polynomials();
    end when;

    annotation (experiment(StopTime=0));
  end TestPolynomials;

  model TestMatrices
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Math.Matrices();
    end when;

    annotation (experiment(StopTime=0));
  end TestMatrices;

  model TestMatrices2
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Math.Matrices2();
    end when;

    annotation (experiment(StopTime=0));
  end TestMatrices2;

  model TestMatrices2b
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Math.Matrices2b();
    end when;

    annotation (experiment(StopTime=0));
  end TestMatrices2b;

  model TestMatrices3
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Math.Matrices3();
    end when;

    annotation (experiment(StopTime=0));
  end TestMatrices3;

  model TestMatricesExamplesSolveLinearEquations
    extends Modelica.Icons.Example;
    equation
      Modelica.Math.Matrices.Examples.solveLinearEquations();
    annotation (experiment(StopTime=0));
  end TestMatricesExamplesSolveLinearEquations;

  model TestVectors
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Math.Vectors();
    end when;

    annotation (experiment(StopTime=0));
  end TestVectors;

  model TestColorMapToSvg
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Math.colorMapToSvg();
    end when;

    annotation (experiment(StopTime=0));
  end TestColorMapToSvg;

  model TestNonlinear
    extends Modelica.Icons.Example;
  algorithm
    when initial() then
      Modelica.Math.Nonlinear.Examples.quadratureLobatto1();
      Modelica.Math.Nonlinear.Examples.quadratureLobatto2();
      Modelica.Math.Nonlinear.Examples.solveNonlinearEquations1();
      Modelica.Math.Nonlinear.Examples.solveNonlinearEquations2();
    end when;

    annotation (experiment(StopTime=0));
  end TestNonlinear;

  model TestInterpolateParametric "To test smoothOrder in Modelica.Math.Vectors.interpolate"
    extends Modelica.Icons.Example;
    parameter Real tabx[:]={0,1,2,3,4,5};
    parameter Real taby[:]=tabx .* tabx;
    Real x, y, xIntegrated;
    Integer i;
    parameter Real p=1 "So that the variable is integrated";
  initial equation
    xIntegrated=x;
  equation
    (x,i)=Modelica.Math.Vectors.interpolate(tabx, taby, time);
    y=der(x);
    der(xIntegrated)=p*y;
    assert(abs(x-xIntegrated)<0.1, "Automatically generated derivative should integrate correctly.");
    annotation (experiment(StopTime=5));
  end TestInterpolateParametric;

  model TestInterpolateTimeVarying "To test smoothOrder in Modelica.Math.Vectors.interpolate"
    extends Modelica.Icons.Example;
    Real tabx[:]={0,1,2,3,4,5}+0.1*time*ones(6);
    Real taby[:]=tabx .* tabx;
    Real x, y, xIntegrated;
    Integer i;
    parameter Real p=1 "So that the variable is integrated";
    initial equation
    xIntegrated=x;
    equation
    (x,i)=Modelica.Math.Vectors.interpolate(tabx, taby, time);
    y=der(x);
    der(xIntegrated)=p*y;
    assert(abs(x-xIntegrated)<0.1, "Automatically generated derivative should integrate correctly.");
    annotation (experiment(StopTime=5));
  end TestInterpolateTimeVarying;

  package Random
    function randomNumbers
      "Demonstrate the generation of uniform random numbers in the range 0..1"
      import Modelica.Math.Random.Generators;
      import Modelica.Utilities.Streams.print;
      import Modelica.Math.Random.Utilities.automaticLocalSeed;
      extends Modelica.Icons.Function;
      input Integer localSeed = 614657;
      input Integer globalSeed = 30020;
      output Boolean ok;
      output Real r2;
      output Real r4a;
      output Real r4b;
      output Real r4c;
      output Real r33;
      output Integer state2[ Generators.Xorshift64star.nState];
      output Integer state4a[Generators.Xorshift128plus.nState];
      output Integer state4b[Generators.Xorshift128plus.nState];
      output Integer state4c[Generators.Xorshift128plus.nState];
      output Integer state33[Generators.Xorshift1024star.nState];
    protected
      constant Integer nRandom = 5;
      constant String name1="Modelica.Blocks.Examples.Noise.AutomaticSeed.automaticSeed1";
      constant String name2="Modelica.Blocks.Examples.Noise.AutomaticSeed.automaticSeed2";
      constant Integer localSeed1 = automaticLocalSeed(name1);
      constant Integer localSeed2 = automaticLocalSeed(name2);
    algorithm
      print("\n... Demonstrate how to generate uniform random numbers with xorshift64*:");

      // Generate initial state from localSeed and globalSeed
      state2 := Generators.Xorshift64star.initialState(localSeed, globalSeed);

      // Generate random numbers
      for i in 1:nRandom loop
        (r2,state2) := Generators.Xorshift64star.random(state2);
        print("   random = " + String(r2));
      end for;

      print("\n... Demonstrate how to generate uniform random numbers with xorshift128+ (and 3 different localSeeds):");

      // Generate initial state from localSeed and globalSeed
      state4a := Generators.Xorshift128plus.initialState(localSeed,  globalSeed);
      state4b := Generators.Xorshift128plus.initialState(localSeed1, globalSeed);
      state4c := Generators.Xorshift128plus.initialState(localSeed2, globalSeed);

      // Generate random numbers
      for i in 1:nRandom loop
        (r4a,state4a) := Generators.Xorshift128plus.random(state4a);
        (r4b,state4b) := Generators.Xorshift128plus.random(state4b);
        (r4c,state4c) := Generators.Xorshift128plus.random(state4c);
        print("   random = " + String(r4a) + ", " + String(r4b) + ", " + String(r4c));
      end for;

      print("\n... Demonstrate how to generate uniform random numbers with xorshift1024*:");

      // Generate initial state from localSeed and globalSeed
      state33 := Generators.Xorshift1024star.initialState(localSeed, globalSeed);

      // Generate random numbers
      for i in 1:nRandom loop
        (r33,state33) := Generators.Xorshift1024star.random(state33);
        print("   random = " + String(r33));
      end for;

      ok :=true;
      annotation (Documentation(info="<html>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end randomNumbers;

    function special "Test Math.Special"
       extends Modelica.Icons.Function;
       import Modelica.Utilities.Streams.print;
       import Modelica.Math.Special;
       input Integer nPoints = 1000;
       input Real erfRange = 3.0;
       output Boolean ok;
    protected
       Real u[nPoints] = linspace(-erfRange, erfRange, nPoints);
       Real u1[nPoints];
       Real u2[nPoints];
       Real y1[nPoints];
       Real y2[nPoints];
       Real u3[16] = {-1e-3, -1e-4, -1e-5, -1e-6, -1e-7, -1e-8, -1e-9, -1e-10,
                       1e-3,  1e-4,  1e-5,  1e-6,  1e-7,  1e-8,  1e-9,  1e-10};
       Real y3a[size(u3,1)];
       Real y3b[size(u3,1)];
       Real err;
    algorithm
        print("\n... Check Math.Special");

       // check erf
       y1 := Special.erf(u);
       y2 := Internal.erfSimple(u);
       err  := max(abs(y1 - y2));
       print("erf: err = " + String(err));
       assert( err < 1e-6, "Error function erf computed not precisely enough");

       // check erfInv
       u1 := Special.erfInv(y1);
       u2 := Internal.erfInvSimple(y1);
       err  := max(abs(u1 - u2));
       print("erfInv: err = " + String(err));
       assert( err < 1e-8, "Error function erfInv computed not precisely enough");

       // cross check erf and erfInv
       y1 := Special.erf(u);
       u1 := Special.erfInv(y1);
       err  := max(abs(u - u1));
       print("erf and erfInv: err = " + String(err));
       assert( err < 1e-12, "Functions erf and erfInv computed not precisely enough");

       // check erfc
       y1 := ones(nPoints) - Special.erf(u);
       y2 := Special.erfc(u);
       err  := max(abs(y1 - y2));
       print("erfc: err = " + String(err));
       assert( err < 1e-14, "Error function erfc computed not precisely enough");

       // cross check erfc and erfcInv
       y1 := Special.erfc(u);
       u1 := Special.erfcInv(y1);
       err  := max(abs(u - u1));
       print("erfc and erfcInv: err = " + String(err));
       assert( err < 1e-12, "Functions erfc and erfcInv computed not precisely enough");

       // check sinc
       y3a := Special.sinc(u3);
       y3b := sin(u3)./u3;
       err  := max(abs(y3a - y3b));
       print("sinc = " + String(err));
       assert( err < 1e-15, "Function sinc function computed not precisely enough");

       ok :=true;
      annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end special;

    function distributions "Test Math.Distributions"
       extends Modelica.Icons.Function;
       import Modelica.Utilities.Streams.print;
       import Modelica.Math.Distributions;
       input Integer nPoints = 1000;
       output Boolean ok;
    protected
       Real eps = 10*Modelica.Constants.eps;
       Real u[nPoints] = linspace(-1,2, nPoints);
       Real u0[nPoints] = linspace(-1+eps,2-eps,nPoints);
       Real u1[nPoints] = linspace(0+eps,1-eps,nPoints);
       Real u2[nPoints];
       Real y1[nPoints];
       Real y2[nPoints];
       Real y3[nPoints];
       Real err;
       Integer n;
    algorithm
       print("\n... Check Math.Distributions");
       assert(nPoints >= 1000, "nPoints >= 1000 required (otherwise approximation of derivative with two-side difference quotient is too crude).");

       // check Uniform
       y1 := Distributions.Uniform.density(u0,-1,2);
       y2 := Distributions.Uniform.cumulative(u0,-1,2);
       y3 := Internal.derTwoSided(u0,y2);
       err  := max(abs(y1 - y3));
       print("Uniform.density: err = " + String(err));
       assert( err < 0.2, "Uniform.density not correctly computed");

       y1 := Distributions.Uniform.quantile(u1,-1,2);
       u2 := Distributions.Uniform.cumulative(y1,-1,2);
       err :=max(abs(u1 - u2));
       print("Uniform.cumulative/.quantile: err = " + String(err));
       assert( err < 1e-14, "Uniform.cumulative or .quantile not correctly computed");

       // check Normal
       y1 := Distributions.Normal.density(u,1,0.5);
       y2 := Distributions.Normal.cumulative(u,1,0.5);
       y3 := Internal.derTwoSided(u,y2);
       err  := max(abs(y1 - y3));
       print("Normal.density: err = " + String(err));
       assert( err < 0.005, "Normal.density not correctly computed");

       y1 := Distributions.Normal.quantile(u1,1,0.5);
       u2 := Distributions.Normal.cumulative(y1,1,0.5);
       err :=max(abs(u1 - u2));
       print("Normal.cumulative/.quantile: err = " + String(err));
       assert( err < 1e-14, "Normal.cumulative or .quantile not correctly computed");

       // check Weibull
       y1 := Distributions.Weibull.density(u,0.5,2);
       y2 := Distributions.Weibull.cumulative(u,0.5,2);
       y3 := Internal.derTwoSided(u,y2);
       err  := max(abs(y1 - y3));
       print("Weibull.density: err = " + String(err));
       assert( err < 0.03, "Weibull.density not correctly computed");

       y1 := Distributions.Weibull.quantile(u1,0.5,2);
       u2 := Distributions.Weibull.cumulative(y1,0.5,2);
       err :=max(abs(u1 - u2));
       print("Weibull.cumulative/.quantile: err = " + String(err));
       assert( err < 1e-14, "Weibull.cumulative or .quantile not correctly computed");

       ok :=true;
      annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end distributions;

    function truncatedDistributions
      "Test truncated distributions in Math.Distributions"
       extends Modelica.Icons.Function;
       import Modelica.Utilities.Streams.print;
       import Modelica.Math.Distributions;
       input Integer nPoints = 1000;
       input Real erfRange = 3.0;
       output Boolean ok;
    protected
       Real eps = 10*Modelica.Constants.eps;
       Real u[nPoints] = linspace(-erfRange, erfRange, nPoints);
       Real u1[nPoints] = linspace(0+eps,1-eps,nPoints);
       Real u2[nPoints];
       Real y1[nPoints];
       Real y2[nPoints];
       Real y3[nPoints];
       Real err;
    algorithm
       print("\n... Check Math.Distributions (truncated distributions)");

       // check Normal
       y1 :=Modelica.Math.Distributions.TruncatedNormal.density(
            u,
            u_min=-1.5,
            u_max=1.5);
       y2 :=Modelica.Math.Distributions.TruncatedNormal.cumulative(
            u,
            u_min=-1.5,
            u_max=1.5);
       y3 := Internal.derTwoSided(u,y2);
       err  := max(abs(y1 - y3));
       print("Normal.density: err = " + String(err));
       assert( err < 0.2, "Normal.density not correctly computed");

       y1 :=Modelica.Math.Distributions.TruncatedNormal.quantile(
            u1,
            y_min=-1.5,
            y_max=1.5);
       u2 :=Modelica.Math.Distributions.TruncatedNormal.cumulative(
            y1,
            u_min=-1.5,
            u_max=1.5);
       err :=max(abs(u1 - u2));
       print("Normal.cumulative/.quantile: err = " + String(err));
       assert( err < 1e-14, "Normal.cumulative or .quantile not correctly computed");

       // check Weibull
       y1 :=Modelica.Math.Distributions.TruncatedWeibull.density(
            u,
            u_max=0.8,
            lambda=0.5,
            k=2);
       y2 :=Modelica.Math.Distributions.TruncatedWeibull.cumulative(
            u,
            u_max=0.8,
            lambda=0.5,
            k=2);
       y3 := Internal.derTwoSided(u,y2);
       err  := max(abs(y1 - y3));
       print("Weibull.density: err = " + String(err));
       assert( err < 0.2, "Weibull.density not correctly computed");

       y1 :=Modelica.Math.Distributions.TruncatedWeibull.quantile(
            u1,
            y_max=0.8,
            lambda=0.5,
            k=2);
       u2 :=Modelica.Math.Distributions.TruncatedWeibull.cumulative(
            y1,
            u_max=0.8,
            lambda=0.5,
            k=2);
       err :=max(abs(u1 - u2));
       print("Weibull.cumulative/.quantile: err = " + String(err));
       assert( err < 1e-14, "Weibull.cumulative or .quantile not correctly computed");

       ok :=true;
      annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end truncatedDistributions;

    impure function automaticGlobalSeed "Test automatic global seed"
      extends Modelica.Icons.Function;
      output Integer seed "Automatically generated seed";
      external "C" seed = ModelicaRandom_automaticGlobalSeed()
       annotation (Library="ModelicaExternalC");
    end automaticGlobalSeed;

    model TestRandomNumbers
      import Modelica.Math.Random.Generators;
      extends Modelica.Icons.Example;

      output Boolean result;

      output Real r2;
      output Real r4a;
      output Real r4b;
      output Real r4c;
      output Real r33;

      output Integer state2[ Generators.Xorshift64star.nState];
      output Integer state4a[Generators.Xorshift128plus.nState];
      output Integer state4b[Generators.Xorshift128plus.nState];
      output Integer state4c[Generators.Xorshift128plus.nState];
      output Integer state33[Generators.Xorshift1024star.nState];
    initial equation
      result = false;
      r2 = 0;
      r4a = 0;
      r4b = 0;
      r4c = 0;
      r33 = 0;
      state2 = zeros(Generators.Xorshift64star.nState);
      state4a = zeros(Generators.Xorshift128plus.nState);
      state4b = zeros(Generators.Xorshift128plus.nState);
      state4c = zeros(Generators.Xorshift128plus.nState);
      state33 = zeros(Generators.Xorshift1024star.nState);
    equation
      when sample(0,1) then
        (result,r2,r4a,r4b,r4c,r33, state2,state4a,state4b,state4c,state33) =  ModelicaTest.Math.Random.randomNumbers();
      end when;

      annotation (experiment(StopTime=1.5, Interval=1));
    end TestRandomNumbers;

    model TestSpecial
      extends Modelica.Icons.Example;

      output Boolean result;
    algorithm
      when initial() then
        result := ModelicaTest.Math.Random.special();
      end when;

      annotation (experiment(StopTime=0));
    end TestSpecial;

    model TestDistributions
      extends Modelica.Icons.Example;

      output Boolean result;
    algorithm
      when initial() then
        result := ModelicaTest.Math.Random.distributions();
      end when;

      annotation (experiment(StopTime=0));
    end TestDistributions;

    model TestTruncatedDistributions
      extends Modelica.Icons.Example;

      output Boolean result;
    algorithm
      when initial() then
        result := ModelicaTest.Math.Random.truncatedDistributions();
      end when;

      annotation (experiment(StopTime=0));
    end TestTruncatedDistributions;

    model TestRandomIntegers
      extends Modelica.Icons.Example;
      parameter Integer id(fixed=false);
      Integer y;
      parameter Integer n=3;
      Integer cnt[n](each start=0, each fixed=true);
      parameter Real nrSigma=3;
      Real avg=samples/(n);
      Real lowBound=avg-nrSigma*sqrt(avg);
      Real highBound=avg+nrSigma*sqrt(avg);
      Integer samples(start=0, fixed=true);
    initial algorithm
      id := Modelica.Math.Random.Utilities.initializeImpureRandom(123456789);
    equation
      when sample(0, 0.001) then
        y = Modelica.Math.Random.Utilities.impureRandomInteger(id, 1, n);
        cnt=pre(cnt)+{if i==y then 1 else 0 for i in 1:n};
        samples=pre(samples)+1;
      end when;
      when terminal() then
        for i in 1:n loop
          assert(cnt[i]>lowBound,
          "Number of generated "+String(i)+" is "+String(cnt[i])+" but should be "+String(avg)+"+/-"+String(sqrt(avg)));
          assert(cnt[i]<highBound,
          "Number of generated "+String(i)+" is "+String(cnt[i])+" but should be "+String(avg)+"+/-"+String(sqrt(avg)));
        end for;
      end when;
      // Note: This test is probabilistic and should sometimes (but rarely) fail if given different random number sequences
      annotation (experiment(StopTime=1));
    end TestRandomIntegers;

    package Internal
      "Internal utility functions that should not be directly utilized by the user"
      function erfSimple
        "Error function (simple implementation, precision around 1e-7)"
        extends Modelica.Icons.Function;
        input Real u;
        output Real y "y = 2/sqrt(pi)*Integral_0_u exp(-t^2)*dt";
      protected
        constant Real a1 =  0.254829592;
        constant Real a2 = -0.284496736;
        constant Real a3 =  1.421413741;
        constant Real a4 = -1.453152027;
        constant Real a5 =  1.061405429;
        constant Real p =   0.3275911;
        Real t;
        Real w;
        Real uAbs;
      algorithm
        uAbs := abs(u);
        t := 1.0/(1.0 + p*uAbs);
        w := 1.0 - (((((a5*t + a4)*t) + a3)*t + a2)*t + a1)*t*exp(-uAbs*uAbs);
        y := if u >= 0.0 then w else -w;
        annotation (Documentation(info="<html>
<p>
Computes the error function erf(u)
with a maximum error of 1.5e-7.
Implementation is according to Abramowitz and Stegun
(see <a href=\"http://people.math.sfu.ca/~cbm/aands/page_299.jpg\">Handbook of Mathematical Functions, page 299, equation 7.1.26</a>).
</p>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
      end erfSimple;

      function cdfInvNormal
        "Quantile (inverse cumulative distribution function) of the normal distribution with a precision of about 1e-9"
        extends Modelica.Icons.Function;
        input Real u(min=0, max=1) "Number in the range 0 <= u <= 1";
        output Real y
          "Quantile of 1/sqrt(2*pi) * exp(-x^2/2): y = sqrt(2)*erfinv(2*u-1)";
      protected
        constant Real a[6] = {-3.969683028665376e+01, 2.209460984245205e+02, -2.759285104469687e+02,
                               1.383577518672690e+02, -3.066479806614716e+01, 2.506628277459239e+00};
        constant Real b[5] = {-5.447609879822406e+01, 1.615858368580409e+02, -1.556989798598866e+02,
                               6.680131188771972e+01, -1.328068155288572e+01};
        constant Real c[6] = {-7.784894002430293e-03, -3.223964580411365e-01, -2.400758277161838e+00,
                              -2.549732539343734e+00, 4.374664141464968e+00, 2.938163982698783e+00};
        constant Real d[4] = {7.784695709041462e-03, 3.224671290700398e-01, 2.445134137142996e+00,
                              3.754408661907416e+00};
        constant Real u_low =  0.02425;
        constant Real u_high = 1 - u_low;
        Real q;
        Real qq;
      algorithm
         if u >= u_low and u <= u_high then
            // Rational approximation for central region.
            q := u - 0.5;
            qq := q*q;
            y := (((((a[1]*qq+a[2])*qq+a[3])*qq+a[4])*qq+a[5])*qq+a[6])*q /
                 (((((b[1]*qq+b[2])*qq+b[3])*qq+b[4])*qq+b[5])*qq+1);

         elseif u <= 0.0 + 10*Modelica.Constants.eps then
            y := -Modelica.Constants.inf;

         elseif u < u_low then
            // Rational approximation for lower region.
            q := sqrt(-2*log(u));
            y := (((((c[1]*q+c[2])*q+c[3])*q+c[4])*q+c[5])*q+c[6]) /
                 ((((d[1]*q+d[2])*q+d[3])*q+d[4])*q+1);

         elseif u >= 1.0 - 10*Modelica.Constants.eps then
            y := Modelica.Constants.inf;

         else
            // Rational approximation for upper region.
            q := sqrt(-2*log(1-u));
            y := -(((((c[1]*q+c[2])*q+c[3])*q+c[4])*q+c[5])*q+c[6]) /
                  ((((d[1]*q+d[2])*q+d[3])*q+d[4])*q+1);
         end if;

        annotation (Documentation(info="<html>
<p>
Implementation according to:
<a href=\"https://web.archive.org/web/20151030215612/http://home.online.no/~pjacklam/notes/invnorm/\">Peter John Acklam</a>.
The relative error is less than 1e-9.
</p>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
      end cdfInvNormal;

      function erfInvSimple
        "Inverse error function with a precision of about 1e-7"
        extends Modelica.Icons.Function;
        input Real u;
        output Real y;
      algorithm
        y := cdfInvNormal((1 + u)/2)/sqrt(2);
        annotation (Inline=true, Documentation(info="<html>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
      end erfInvSimple;

      function quantileNormalSimple
        "Test quantile of normal distribution with reduced precision"
        extends Modelica.Icons.Function;
        input Real u(min=0, max=1) "Random number in the range 0 <= u <= 1";
        input Real mu=0 "Expectation (mean) value of the normal distribution" annotation(Dialog);
        input Real sigma=1 "Standard deviation of the normal distribution" annotation(Dialog);
        output Real y
          "Random number u transformed according to the given distribution";
      algorithm
        y := mu + sigma*ModelicaTest.Math.Random.Internal.cdfInvNormal(u);

        annotation (Inline=true, Documentation(info="<html>
<p>
This function returns a random number according to a normal distribution. This means that 99.7 % of the returned random numbers are in the range:
</p>

<blockquote>
<p>
mu-3*sigma &le; y &le; mu+3*sigma
</p>
</blockquote>

<p>
This function is only for test purposes. It computes the quantile (= inverse cumulative distribution function) of a normal distribution with a reduced precision of about 1e-7.
</p>

<p>
For more details of this distribution see
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>.
</p>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
      end quantileNormalSimple;

      function derOneSided
        "Return approximation of derivative by a one-sided difference quotient (if size(u,1)=1, zero is returned)"
        extends Modelica.Icons.Function;
        input Real u[:];
        input Real y[size(u,1)];
        output Real der_y[size(u,1)] "dy/du";
      protected
        Integer nu = size(u,1);
      algorithm
        if nu <= 1 then
           der_y := fill(0.0, nu);
        else
           der_y[1] :=(y[2] - y[1])/(u[2] - u[1]);
           der_y[nu] := (y[nu] - y[nu-1])/(u[nu] - u[nu-1]);
           for i in 2:nu-1 loop
              der_y[i] :=(y[i + 1] - y[i - 1])/(u[i + 1] - u[i - 1]);
           end for;
        end if;
        annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
      end derOneSided;

      function derTwoSided
        "Return approximation of derivative by a two-sided difference quotient (if size(u,1)=1, zero is returned)"
        extends Modelica.Icons.Function;
        input Real u[:];
        input Real y[size(u,1)];
        output Real der_y[size(u,1)] "dy/du";
      protected
        Integer nu = size(u,1);
      algorithm
        if nu <= 1 then
           der_y := fill(0.0, nu);
        else
           for i in 1:nu-1 loop
              der_y[i] :=(y[i + 1] - y[i])/(u[i + 1] - u[i]);
           end for;
           der_y[nu] :=der_y[nu - 1];
        end if;
        annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
      end derTwoSided;
      annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end Internal;
  end Random;
end Math;
