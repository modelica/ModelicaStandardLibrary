within ModelicaTest;
package ComplexMath
extends Modelica.Icons.Package;
  function ComplexFunctions
    import Complex;
    input String logFile = "ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean success;
  protected
    Complex c1;
    Complex c2;
    Complex res;
    Complex ref;
    Real Res;
    Real Ref;
    constant Real epsilon=1E-14;
  algorithm
    success:=false;
    Modelica.Utilities.Streams.print("... Test of Complex and of Modelica.ComplexMath", logFile);

    c1:=Complex(1,1);
    res:=-c1;
    ref:=Complex(-1,-1);
    assert(ref==res, "unary minus failed");

    c1:=Complex(1,1);
    c2:=Complex(2,2);
    res:=c1 - c2;
    ref:=Complex(-1,-1);
    assert(ref==res, "subtraction failed");

    c1:=Complex(1,1);
    c2:=Complex(2,2);
    res:=c1 + c2;
    ref:=Complex(3,3);
    assert(ref==res, "addition failed");

    c1:=Complex(1,1);
    c2:=Complex(2,2);
    res:=c1 * c2;
    ref:=Complex(0,4);
    assert(ref==res, "multiplication failed");

    c1:=Complex(1,1);
    c2:=Complex(2,2);
    res:=c1 / c2;
    ref:=Complex(0.5,0);
    assert(ref==res, "division failed");

    c1:=Complex(1,1);
    c2:=Complex(2,2);
    res:=c1 ^ c2;
    ref:=Complex(-0.265653998849241,+0.319818113856136);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "power failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.sin(c1);
    ref:=Complex(+1.29845758141598,+0.634963914784736);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "sin failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.cos(c1);
    ref:=Complex(+0.83373002513114,-0.988897705762865);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "cos failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.tan(c1);
    ref:=Complex(+0.271752585319512,+1.08392332733869);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "tan failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.asin(c1);
    ref:=Complex(+0.666239432492515,+1.06127506190504);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "asin failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.acos(c1);
    ref:=Complex(+0.904556894302381,-1.06127506190504);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "acos failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.atan(c1);
    ref:=Complex(+1.01722196789785,+0.402359478108525);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "atan failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.sinh(c1);
    ref:=Complex(+0.634963914784736,+1.29845758141598);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "sinh failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.cosh(c1);
    ref:=Complex(+0.833730025131149,+0.988897705762865);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "cosh failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.tanh(c1);
    ref:=Complex(+1.08392332733869,+0.271752585319512);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "tanh failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.asinh(c1);
    ref:=Complex(+1.06127506190504,+0.666239432492515);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "asinh failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.acosh(c1);
    ref:=Complex(+1.06127506190504,+0.904556894302381);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "acosh failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.atanh(c1);
    ref:=Complex(+0.402359478108525,+1.01722196789785);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "atanh failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.exp(c1);
    ref:=Complex(+1.46869393991589,+2.28735528717884);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "eps failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.log(c1);
    ref:=Complex(+0.346573590279973,+0.785398163397448);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "log failed");

    c1:=Complex(1,1);
    Res:=Modelica.ComplexMath.'abs'(c1);
    Ref:=sqrt(2);
    assert(abs(Ref-Res)<epsilon, "abs failed");

    c1:=Complex(1,1);
    Res:=Modelica.ComplexMath.arg(c1);
    Ref:=Modelica.Constants.pi/4;
    assert(abs(Ref-Res)<epsilon, "arg failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.conj(c1);
    ref:=Complex(1,-1);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "conj failed");

    c1:=Complex(1,1);
    Res:=Modelica.ComplexMath.real(c1);
    Ref:=1;
    assert(abs(Ref-Res)<epsilon, "real failed");

    c1:=Complex(1,1);
    Res:=Modelica.ComplexMath.imag(c1);
    Ref:=1;
    assert(abs(Ref-Res)<epsilon, "imag failed");

    res:=Modelica.ComplexMath.fromPolar(sqrt(2),Modelica.Constants.pi/4);
    ref:=Complex(1,1);
    assert(abs(Ref-Res)<epsilon, "fromPolar failed");

    c1:=Complex(1,1);
    res:=Modelica.ComplexMath.'sqrt'(c1);
    ref:=Complex(+1.09868411346781,+0.455089860562227);
    assert(Modelica.ComplexMath.'abs'(ref-res)<epsilon, "sqrt failed");

    success:=true;
  end ComplexFunctions;

  function ComplexOperations
    output Boolean success;
  protected
     Real     a = 2;
     Complex  j = Modelica.ComplexMath.j;
     Complex  b = 2 + 3*j;
     Complex  c = (2*b + a)/b;
     Complex  d = Modelica.ComplexMath.sin(c);
     Complex  v[3] = {b/2, c, 2*d};
  algorithm
     success:=true;
  end ComplexOperations;
end ComplexMath;
