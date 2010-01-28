within ;
function TestComplex
  import Complex;
  output Boolean success;
protected
  Complex c1;
  Complex c2;
  Complex res;
  Complex ref;
algorithm
  c1:=Complex(1,1);
  res:=-c1;
  ref:=Complex(-1,-1);
  assert(ref==res, "Unary minus failed");

  c1:=Complex(1,1);
  c2:=Complex(2,2);
  res:=c1 - c2;
  ref:=Complex(-1,-1);
  assert(ref==res, "Subtraction failed");

  c1:=Complex(1,1);
  c2:=Complex(2,2);
  res:=c1 + c2;
  ref:=Complex(3,3);
  assert(ref==res, "Addition failed");

  c1:=Complex(1,1);
  c2:=Complex(2,2);
  res:=c1 * c2;
  ref:=Complex(0,4);
  assert(ref==res, "Multiplication failed");

  c1:=Complex(1,1);
  c2:=Complex(2,2);
  res:=c1 / c2;
  ref:=Complex(0.5,0);
  assert(ref==res, "Division failed");
/*  
  c1:=Complex(1,1);
  c2:=Complex(2,2);
  res:=c1 ^ c2;
  ref:=Complex(1,0);
  assert(ref==res, "Power failed");
*/
  success:=true;
  annotation (uses(Modelica(version="3.1")));
end TestComplex;
