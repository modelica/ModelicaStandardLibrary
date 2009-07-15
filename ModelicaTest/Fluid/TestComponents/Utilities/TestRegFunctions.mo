within ModelicaTest.Fluid.TestComponents.Utilities;
model TestRegFunctions
  extends Modelica.Icons.Example;
  import Modelica.Fluid.Utilities.*;
  parameter Real delta=0.01;
  Real x=time+1e-9;
  Real sqrtx=sqrt(x);
  Real sqrtx_a=regRoot(x,delta);
  Real x2 = x*x;
  Real x2_a = regSquare(x,delta);
  Real x3 = x*x*x;
  Real x3_a = regPow(x,3,delta);
  Real sqrtxerr = (sqrtx_a-sqrtx)/sqrtx;
  Real x2err = (x2_a-x2)/x2;
  Real x3err = (x3_a-x3)/x3;
end TestRegFunctions;
