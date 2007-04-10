package Math "Test models for Modelica.Math" 
  function testPolynomials "Test functions of package Polynomial" 
    import Modelica.Utilities.Streams;
    import Poly = Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
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
    Streams.print("... Test of Modelica_Polynomials");
    
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
  end testPolynomials;
  
  function testLeastSquares 
    
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
    
  public 
    output Real x1[3] = Modelica.Math.Matrices.leastSquares(A1,b);
    output Real x2[3] = Modelica.Math.Matrices.leastSquares(A2,b);
    output Real x3[3] = Modelica.Math.Matrices.equalityLeastSquares(A3,a3,B3,b3);
    output Real e3[1] = B3*x3 - b3;
    // output Real x4[4] = Modelica.Math.Matrices.equalityLeastSquares(A4,a4,B4,b4);
  algorithm 
    
  end testLeastSquares;
end Math;
