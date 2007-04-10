record Bspline1D "Generic 1-dim. interpolation with Bsplines" 
  
  annotation (preferedView="info",Documentation(info="<html>
<p>
This record provides the data-structure and functions
to perform 1-dimensional interpolation with B-splines. 
</p>
 
<p>
There are different forms to initialize a spline data structure.
Most simplest is the use of <b>tables</b>.
A table is defined as a set of columns:
</p>
 
<pre>
  Form 1 (Bspline1D.fromTable()):
    <b>[x, y1(x), y2(x), ..., yn(x)]</b>
 
  Form 2 (Bspline1D.fromTableAndDerivatives()):
    <b>[x, y1(x), y2(x), ..., yn(x), der(y1)(x), der(y2)(x), ..., der(yn)(x)]</b>
</pre>
 
<p>
where, x, y1, y2, etc. are column vectors. The first form interpolates
every column with respect to the first column. The second form
provides first all table points (y1, y2, .., yn) and then the
derivatives of the table points (der(y1), der(y2), ..., der(yn)).
In the second form the splines are constructed such that the
splines interpolate both the data points and the first derivative
of the data points exactly (= Hermite splines). Example for the first form:
</p>
 
<pre>
     <b>import</b> Modelica_Interpolation.Bspline1D;
     Real table[5,2] = [0,0;
                        1,1;
                        2,3;
                        3,7;
                        4,6];
     Real y2[1];
     Integer degree = 3;
     Bspline1D spline = Bspline1D.fromTable(table,degree=degree);
  <b>algorithm</b>
     y2 := Bspline1D.evaluate(tableSpline, 2.2);
     Bspline1D.plot(spline,heading=\"Table interpolated with Bspline of degree \" + String(degree));
</pre>
 
<p>
Argument \"degree\" defines the degree or order of the polynomials
used for interpolation. It is required that degree &ge; 1 and degree &lt; size(table,1).
It is then possible to compute the first and higher order derivatives
of the interpolated columns. The derivatives are usually continuous upto 
derivative degree - 1.
</p>
 
<p>
The above model, results in the following plots for 
degree = 1, 2, 3:
</p>
 
<p>
<img src=\"../Images/plot_table2_degree1.png\"><br>
<img src=\"../Images/plot_table2_degree2.png\"><br>
<img src=\"../Images/plot_table2_degree3.png\">
</p>
 
 
<p>
The Bspline1D record consists of the following elements
(this description is usually of no
interest to the user of the Bspline functions):
</p>
 
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td>Real <b>controlPoints</b>[:,:]</td>
      <td> Control points describing the interpolation function.<br>
           The polygon described by the control points is the
           envellope of the interpolated curve</td>
  </tr>
  <tr><td>Real <b>knots</b>[:]</td>
      <td>Knot vector of the Bspline defining the parameterization</td>
  </tr>
  <tr><td>Real <b>param</b>[:]</td>
      <td> param[i] is the parameterization of the i-th point
          to be interpolated. <br>
          Vector param is not used to perform the interpolation. <br>
          It is only included in the data structure
          to recover the original points,<br> if needed, e.g., for plotting.
      </td>
  </tr>         
</table>
 
</html>"));
  Real controlPoints[:,:] "[i,:] is the data of control point i";
  Real knots[:] "Knot vector of the Bspline";
  Real param[:] "Parameterization of points that are interpolated";
  
encapsulated package Examples 
    "Examples demonstrating the usage of the Bspline1D functions" 
    import Modelica;
    import Modelica_Interpolation;
    
  function plot_dim1 
      "Interpolation of 1-dim data points with a Bspline and plotting of the curve" 
      import Modelica_Interpolation.Bspline1D;
    input Integer degree=3 "Desired degree of polynomial";
    input Boolean Bessel=true "If degree=3, use Bessel end condition";
    input Integer derN=0 
        "Plot the derN-th derivative (derN=0 is the spline, derN=1 is the first derivative)";
    protected 
    Real data[7,2] = [0,0;
                      1,1;
                      2,4;
                      3,9;
                      4,7;
                      5,3;
                      6,2];
    Bspline1D spline = Modelica_Interpolation.Bspline1D(data[:,1], matrix(data[:,2]), degree=degree,Bessel=Bessel);
    String heading;
  algorithm 
    heading := if Bessel then "Bessel end condition" else "Standard end condition";
    if derN > 0 then
       heading := heading + " (" + String(derN) + " derivative of spline)";
    end if;
    Bspline1D.plot(spline,derN=derN,heading=heading);
  end plot_dim1;
    
  function plot_dim2 
      "Interpolation of 2-dim data points with a Bspline and plotting of the curve" 
    import Modelica_Interpolation.Bspline1D;
    input Integer degree=3 "Desired degree of polynomial";
    input Boolean Bessel=true "If degree=3, use Bessel end condition";
    input Boolean matrixPlot=false 
        "<html>=true, if all dimensions are plotted with respect to the parameterization;<br>=false, if 2 or 3 dimensional splines are plotted in 2D or 3D</html>";
    input Integer derN=0 
        "Plot the derN-th derivative (derN=0 is the spline, derN=1 is the first derivative)";
    protected 
    Real data[7,2] = [0,0;
                      0,4;
                      1,4;
                      1,2;
                      5,3;
                      5,1;
                      6,1];
    Real param[size(data,1)] = Modelica_Interpolation.Utilities.parametrizeSpline(data);
    Bspline1D spline = Modelica_Interpolation.Bspline1D(param,data,degree=degree,Bessel=Bessel);
    String heading;
  algorithm 
    heading := if Bessel then "Bessel end condition" else "Standard end condition";
    if derN > 0 then
       heading := heading + " (" + String(derN) + " derivative of spline)";
    end if;
    Bspline1D.plot(spline,matrixPlot=matrixPlot,derN=derN,heading=heading);
  end plot_dim2;
    
  function plot_dim3 
      "Interpolation of 3-dim data points with a Bspline and plotting of the curve" 
      import Modelica_Interpolation.Bspline1D;
    input Integer degree=3 "Desired degree of polynomial";
    input Boolean Bessel=true "If degree=3, use Bessel end condition";
    input Boolean matrixPlot=false 
        "<html>=true, if all dimensions are plotted with respect to the parameterization;<br>=false, if 2 or 3 dimensional splines are plotted in 2D or 3D</html>";
    input Integer derN=0 
        "Plot the derN-th derivative (derN=0 is the spline, derN=1 is the first derivative)";
    protected 
    Real data[7,3] = [0,0,0;
                      0,4,1;
                      1,4,2;
                      1,2,11;
                      5,3,1;
                      5,1,2;
                      6,1,3];
    Real param[size(data,1)] = Modelica_Interpolation.Utilities.parametrizeSpline(data);
    Bspline1D spline = Modelica_Interpolation.Bspline1D(param,data,degree=degree,Bessel=Bessel);
    String heading;
  algorithm 
    heading := if Bessel then "Bessel end condition" else "Standard end condition";
    if derN > 0 then
       heading := heading + " (" + String(derN) + " derivative of spline)";
    end if;
    Bspline1D.plot(spline,derN=derN,matrixPlot=matrixPlot,heading=heading);
  end plot_dim3;
    
  function plot_hermite 
      "Define Bspline with 3-dim data points and their first derivative and plot the curve" 
      import Modelica_Interpolation.Bspline1D;
    input Integer degree=3 "Desired degree of polynomial";
    input Integer derN=0 
        "Plot the derN-th derivative (derN=0 is the spline, derN=1 is the first derivative)";
    protected 
    Real data[7,3] = [0,0,0;
                      0,4,0;
                      1,4,0;
                      1,2,0;
                      5,3,0;
                      5,1,0;
                      6,1,0];
    Real data_der[7,3] = [-10,10,0;
                           10,10,0;
                           10,-10,0;
                           10,-10,0;
                           10,-10,0;
                           10,0,0;
                           10,10,0];
    Real param[size(data,1)] = Modelica_Interpolation.Utilities.parametrizeSpline(data);
    Bspline1D spline = Bspline1D.fromPointsAndDerivatives(param,data,data_der,degree=degree);
    String heading;
  algorithm 
    heading := "Hermite spline";
    if derN > 0 then
       heading := heading + " (" + String(derN) + " derivative of spline)";
    end if;
    Bspline1D.plot(spline,derN=derN,matrixPlot=true,heading=heading);
  end plot_hermite;
    
  function eval1 
      "Definition of a Bspline with 1-dim data points and calling all evaluation functions" 
      import Modelica_Interpolation.Bspline1D;
      import Modelica.Utilities.Streams.print;
    input Integer degree=3 "Desired degree of polynomial";
    input Boolean Bessel=true "If degree=3, use Bessel end condition";
    protected 
    Real data[4,2] = [0,0;
                      1,1;
                      2,4;
                      3,9];
    Bspline1D spline = Modelica_Interpolation.Bspline1D(data[:,1],matrix(data[:,2]),degree=degree,Bessel=Bessel);
    String heading;
    Real y[1];
    Real yd[      1];
    Real ydd[             1];
    Real yddd[                     1];
  algorithm 
    u :=1.5;
    y :=Bspline1D.evaluate(spline, u);
    (,yd) :=Bspline1D.evaluateDer(spline, u);
    (,,ydd) :=Bspline1D.evaluateDer2(spline, u);
    yddd :=Bspline1D.evaluateDerN(spline, u, 3);
    print("  u    = " + String(u) +
          "\n  y    = " + String(scalar(y)) +
          "\n  yd   = " + String(scalar(yd)) +
          "\n  ydd  = " + String(scalar(ydd)) +
          "\n  yddd = " + String(scalar(yddd)));
  end eval1;
    
function plot_table1 
      "Interpolation of a table with Bsplines and plotting of the table" 
      import Modelica_Interpolation.Bspline1D;
    protected 
  Real table[4,2] = [0,0;
                     1,1;
                     2,4;
                     3,9];
  Real y2[1];
  Bspline1D tableSpline = Bspline1D.fromTable(table,degree=3);
algorithm 
  y2 := Bspline1D.evaluate(tableSpline, s=2.2);
  Bspline1D.plot(tableSpline,heading="Table interpolated with Bspline of degree 3");
end plot_table1;
    
  function plot_table2 
      "Interpolation of a table with Bsplines with different degrees and plotting of the table" 
      import Modelica_Interpolation.Bspline1D;
    protected 
    Real table[5,2] = [0,0;
                       1,1;
                       2,3;
                       3,7;
                       4,6];
    Real y2[1];
    Bspline1D tableSpline1 = Bspline1D.fromTable(table,degree=1);
    Bspline1D tableSpline2 = Bspline1D.fromTable(table,degree=2);
    Bspline1D tableSpline3 = Bspline1D.fromTable(table,degree=3);
    Bspline1D tableSpline4 = Bspline1D.fromTable(table,degree=4);
  algorithm 
    y2 := Bspline1D.evaluate(tableSpline1, s=2.2);
    Bspline1D.plot(tableSpline1,heading="Table interpolated with Bspline of degree 1");
    Bspline1D.plot(tableSpline2,heading="Table interpolated with Bspline of degree 2");
    Bspline1D.plot(tableSpline3,heading="Table interpolated with Bspline of degree 3");
    Bspline1D.plot(tableSpline4,heading="Table interpolated with Bspline of degree 4");
  end plot_table2;
    
  function plot_table3 
      "Interpolation of a table with Bsplines and plotting of the table" 
      import Modelica_Interpolation.Bspline1D;
    input Integer degree=3 "Desired degree of polynomial";
    input Integer derN=0 
        "Plot the derN-th derivative (derN=0 is the spline, derN=1 is the first derivative)";
    protected 
    Real table[:,:] = [2.6,    4.2,    5.1;
                       5.1,    6.7,    6.5;
                       8.3,    8.6,   10.2;
                       10.2,  13.3,   12.6;
                       17.9,  16.4,   25.7;
                       26.1,  18.5,   21.3;
                       34.5,  21.6,   24.4;
                       38.3,  17.7,   26.4;
                       42.7,  13.8,   32.8;
                       49.2,  10.6,   28.9];
    Bspline1D tableSpline = Modelica_Interpolation.Bspline1D.fromTable(table,degree=degree);
    String heading;
  algorithm 
    heading := "Table";
    if derN > 0 then
       heading := heading + " (" + String(derN) + " derivative of spline)";
    end if;
    Bspline1D.plot(tableSpline,derN=derN,heading=heading);
  end plot_table3;
    
function plot_table1_hermite 
      "Define table with data and first derivatives and plot the table columns" 
      import Modelica_Interpolation.Bspline1D;
  input Integer degree=3 "Desired degree of polynomial";
  input Integer derN=0 
        "Plot the derN-th derivative (derN=0 is the spline, derN=1 is the first derivative)";
    protected 
  Real data[7,5] = [0.00,0,0,-10,10;
                    0.23,0,4,10,10;
                    0.34,1,4,10,-10;
                    0.50,1,2,10,-10;
                    0.73,4,5,10,-10;
                    0.89,5,5,10,0;
                    1.00,6,1,10,10];
  Bspline1D spline = Bspline1D.fromTableAndDerivatives(data,degree=degree);
  String heading;
algorithm 
  heading := "Hermite spline";
  if derN > 0 then
     heading := heading + " (" + String(derN) + " derivative of spline)";
  end if;
  Bspline1D.plot(spline,derN=derN,heading=heading);
end plot_table1_hermite;
    
end Examples;
  
encapsulated function constructor 
    "Generate a Bspline for 1-dim. interpolation (end conditions are automatically selected)" 
  import Modelica;
  import Modelica_Interpolation.Bspline1D;
  extends Modelica.Icons.Function;
  input Real param[:] 
      "parameterization of the data points (not necessarily in the range 0..1)";
  input Real points[size(param,1), :] 
      "[i,:] is point i on the curve to be interpolated";
  input Integer degree(min=1) = 3 
      "Polynomial degree of interpolation (max(degree) = number of points - 1)";
  input Boolean Bessel = true 
      "If true and degree=3, Bessel end condition is used";
  output Bspline1D spline(
           redeclare Real controlPoints[
               if Bessel and degree==3 then size(points,1)+2 else size(points,1), size(points,2)],
           redeclare Real knots[(if Bessel and degree==3 then size(points,1)+2 else size(points,1))+degree+1],
           redeclare Real param[size(points,1)]) 
      "Bspline in a form which can be quickly interpolated";
  protected 
  Integer nknots=size(spline.knots, 1);
  Integer ndim=size(points, 2);
algorithm 
  assert(size(points,1) > degree, "Required degree (= " + String(degree) + ") is too large for\n" +
                                  "number of data points (= " + String(size(points,1)));
  if (degree == 3 and Bessel) then
   //Interpolation with Bessel end-conditions
   spline := Bspline1D.Internal.interpolationBessel(param,points);
  else
    //Interpolation without specifying the end-conditions
   spline := Bspline1D.Internal.interpolation(param,points,degree);
  end if;
  annotation (Documentation(info="<html>
  
</html>"));
end constructor;
  
encapsulated function fromPointsAndDerivatives 
    "Initialize Bspline which interpolates the points and first derivatives" 
  import Modelica;
  import Modelica_Interpolation;
  import Modelica_Interpolation.Bspline1D;
  extends Modelica.Icons.Function;
  input Real param[:] 
      "parameterization of the data points (not necessarily in the range 0..1)";
  input Real points[size(param, 1), :] 
      "[i,:] is point i on the curve to be interpolated";
  input Real derivs[size(points,1), size(points,2)] 
      "derivs[i,:] is the derivative at points[i,:]";
  input Integer degree(min=2) = 3 
      "Polynomial degree of interpolation (max: number of points -1)";
  output Bspline1D spline(
           redeclare Real controlPoints[2*size(points,1), size(points,2)],
           redeclare Real knots[2*size(points,1)+degree+1],
           redeclare Real param[size(points,1)]) 
      "Bspline in a form which can be quickly interpolated";
  protected 
  Integer nknots=size(spline.knots, 1);
  Integer ndim=size(points, 2);
  Integer npoints;
  Integer i;
  Integer k;
  Real S[2*size(points,1),2*size(points,1)];
  Real u;
  Real b[2*size(points,1),size(points, 2)];
  Integer span;
  Real N[2,degree+1];
algorithm 
  /*
  The NURBS Book: Global Interpolation (page 373)
  
  */
  npoints := size(points,1);
    
 // compute the knots
 // the goal is a banded linear system
    
 k :=  integer(degree/2);
 spline.knots[1:degree+1] := ones(degree+1)*param[1];
    
 if degree == 2*k then
   //degree is even
   k := k-1;
      
   for j in 1:k loop
   spline.knots[degree+1+j] := param[j+1];
        
  end for;
      
  for j in 1:npoints-(k+1) loop
    spline.knots[degree+k+2*j] := (param[j+k]+param[j+k+1])/2;
    spline.knots[degree+k+2*j+1] := param[j+k+1];
        
  end for;
      
  for j in 1:k loop
   spline.knots[2*npoints-k+j] := param[npoints-k+j-1];
        
  end for;
      
 else
   //degree is odd
      
  for j in 1:k loop
   spline.knots[degree+1+j] := spline.knots[degree+1] + j*(param[k+1]-param[1])/k;
        
  end for;
      
  for j in 1:npoints-(k+1) loop
    spline.knots[degree+k+2*j] := (2*param[j+k]+param[j+k+1])/3;
    spline.knots[degree+k+2*j+1] := (param[j+k]+2*param[j+k+1])/3;
        
  end for;
      
  for j in 1:k loop
   spline.knots[2*npoints-k+j] := spline.knots[2*npoints-k] + j*(param[npoints]-param[npoints-k])/k;
        
  end for;
      
 end if;
    
 spline.knots[2*npoints+1:2*npoints+degree+1] := ones(degree+1)*param[npoints];
    
 // build the equation system
 S := zeros(2*npoints,2*npoints);
    
 for i in 1:npoints loop
   u := param[i];
   span := Bspline1D.Internal.n_findSpan(degree,u,spline.knots);
    N := Bspline1D.Internal.n_DersBasisFuns(
        span,
        u,
        degree,
        1,
        spline.knots);
   S[2*i-1:2*i,span-degree:span] := N;
   b[2*i-1,:] := points[i,:];
  b[2*i,:] := derivs[i,:];
      
 end for;
    
 // solve the equation system
 spline.controlPoints := Modelica_Interpolation.Utilities.solveMatrix(S,b);
 spline.param := param;
    annotation (Documentation(info="<html>
  
</html>"));
end fromPointsAndDerivatives;
  
encapsulated function fromTable "Initialize 1-dim. table interpolation" 
    import Modelica;
    import Modelica_Interpolation;
    extends Modelica.Icons.Function;
    input Real table[:, :] "[x, y1(x), y2(x), ..., yn(x)] data points";
    input Integer degree(min=1) = 1 "Polynomial degree of interpolation";
    output Modelica_Interpolation.Bspline1D spline(
           redeclare Real controlPoints[
               if degree==3 then size(table,1)+2 else size(table,1), size(table,2)-1],
           redeclare Real knots[(if degree==3 then size(table,1)+2 else size(table,1))+degree+1],
           redeclare Real param[size(table,1)]) 
      "Table data in a form which can be quickly interpolated";
    
/*
           Modelica_Interpolation.Bspline1D(
              param=table[:, 1],
              points=table[:, 2:size(table,2)],
              degree=degree,
              Bessel=true)) 
*/
algorithm 
  spline :=  Modelica_Interpolation.Bspline1D(
                                  param=table[:, 1],
                                  points=table[:, 2:size(table,2)],
                                  degree=degree,
                                  Bessel=true);
end fromTable;
  
encapsulated function fromTableAndDerivatives 
    "Initialize table spline defined by points and first derivatives" 
  import Modelica;
  import Modelica_Interpolation;
  extends Modelica.Icons.Function;
  input Real table[:, :] 
      "[x, y1(x), y2(x), ..., yn(x), der(y1)(x), der(y2)(x), ..., der(yn)(x)] data points and first derivatives at the data points";
  input Integer degree(min=1) = 3 "Polynomial degree of interpolation";
  output Modelica_Interpolation.Bspline1D spline(
           redeclare Real controlPoints[2*size(table,1), integer(size(table,2)/2)],
           redeclare Real knots[2*size(table,1)+degree+1],
           redeclare Real param[size(table,1)]) 
      "Table data in a form which can be quickly interpolated";
algorithm 
   spline :=Modelica_Interpolation.Bspline1D.fromPointsAndDerivatives(
                  param=table[:, 1],
                  points=table[:, 2:integer(size(table, 2)/2) + 1],
                  derivs=table[:, integer(size(table, 2)/2) + 2:size(table, 2)],
                  degree=degree);
end fromTableAndDerivatives;
  
encapsulated function degree "Return degree of Bspline" 
  import Modelica;
  import Modelica_Interpolation.Bspline1D;
  extends Modelica.Icons.Function;
  input Bspline1D spline;
  output Integer result "Degree of spline";
algorithm 
  result := size(spline.knots,1) - size(spline.controlPoints,1) - 1;
    annotation (Documentation(info="<html>
  
</html>"));
end degree;
  
encapsulated function evaluate "Evaluate Bspline at one parameter" 
  import Modelica;
  import Modelica_Interpolation.Bspline1D;
    extends Modelica.Icons.Function;
    input Bspline1D spline "Bspline to be evaluated";
    input Real s "Parameter value at which Bspline shall be evaluated";
    output Real y[size(spline.controlPoints,2)] "Value of Bspline at s";
    annotation(derivative(noDerivative=spline)=Bspline1D.Internal.evaluate_d);
    annotation (Documentation(info="<html>
 
</html>"));
  protected 
   Integer span;
   Integer ndim = size(spline.controlPoints,2);
   Integer degree = Bspline1D.degree(spline);
   Real N[size(spline.knots,1)-size(spline.controlPoints,1)];
algorithm 
    y := zeros(ndim);
    span := Bspline1D.Internal.n_findSpan(degree,s,spline.knots);
    N := Bspline1D.Internal.n_BasisFuns(span,s,degree,spline.knots);
    
    for i in 1:ndim loop
       y[i] := N*spline.controlPoints[span-degree:span,i];
    end for;
end evaluate;
  
encapsulated function evaluateDer 
    "Evaluate Bspline and its first derivative at one parameter" 
    import Modelica;
    import Modelica_Interpolation.Bspline1D;
    extends Modelica.Icons.Function;
    input Bspline1D spline "Bspline to be evaluated";
    input Real s "Parameter value at which Bspline shall be evaluated";
    output Real y[size(spline.controlPoints,2)] "Value of Bspline at y";
    output Real yd[size(spline.controlPoints,2)] 
      "First derivative of Bspline at s";
  protected 
   Integer span;
   Integer degree = Bspline1D.degree(spline);
   Real N[2,size(spline.knots,1) - size(spline.controlPoints,1)];
algorithm 
    //Grenzwert von rechts lim (h->0) (f(x+h)-f(x))/h
    y := zeros(size(y,1));
   yd := zeros(size(yd,1));
    
   span := Bspline1D.Internal.n_findSpan(degree,s,spline.knots);
    N := Bspline1D.Internal.n_DersBasisFuns(span,s,degree,1,spline.knots);
    
    for i in 1:size(y,1) loop
     y[i] := N[1,:]*spline.controlPoints[span-degree:span,i];
     yd[i] := N[2,:]*spline.controlPoints[span-degree:span,i];
    end for;
    
    annotation (Documentation(info="<html>
  
</html>"));
end evaluateDer;
  
encapsulated function evaluateDer2 
    "Evaluate Bspline and its first and second derivatives at one parameter" 
  import Modelica;
  import Modelica_Interpolation.Bspline1D;
    extends Modelica.Icons.Function;
    input Bspline1D spline "Bspline to be evaluated";
    input Real s "Parameter value at which Bspline shall be evaluated";
    output Real y[size(spline.controlPoints,2)] "Value of Bspline at s";
    output Real yd[size(spline.controlPoints,2)] 
      "First derivative of Bspline at s";
    output Real ydd[size(spline.controlPoints,2)] 
      "Second derivative of Bspline at s";
  protected 
   Integer span;
   Integer degree = Bspline1D.degree(spline);
   Real N[3,size(spline.knots,1) - size(spline.controlPoints,1)];
algorithm 
   y := zeros(size(y,1));
   yd := zeros(size(yd,1));
   ydd := zeros(size(ydd,1));
    
   span := Bspline1D.Internal.n_findSpan(degree,s,spline.knots);
    N := Bspline1D.Internal.n_DersBasisFuns(span,s,degree,2,spline.knots);
    
    for i in 1:size(y,1) loop
     y[i] := N[1,:]*spline.controlPoints[span-degree:span,i];
     yd[i] := N[2,:]*spline.controlPoints[span-degree:span,i];
     ydd[i] := N[3,:]*spline.controlPoints[span-degree:span,i];
    end for;
    
    annotation (Documentation(info="<html>
  
</html>"));
end evaluateDer2;
  
encapsulated function evaluateDerN 
    "Evaluate k-th derivative of Bspline at one parameter" 
    import Modelica;
    import Modelica_Interpolation.Bspline1D;
    extends Modelica.Icons.Function;
    input Bspline1D spline "Bspline to be evaluated";
    input Real s "Parameter value at which Bspline shall be evaluated";
    input Integer derN(min=0) 
      "Differentation order (0: function value, 1: first derivative, ...)";
    output Real y_derN[size(spline.controlPoints,2)] 
      "derN-th derivative of Bspline at s";
    annotation(derivative(noDerivative=spline,noDerivative=derN)=Bspline1D.Internal.evaluateDerN_d);
  protected 
   Integer span;
   Integer degree = Bspline1D.degree(spline);
   Real N[derN+1,size(spline.knots,1) - size(spline.controlPoints,1)];
algorithm 
    y_derN := zeros(size(y_derN,1));
    
   span := Bspline1D.Internal.n_findSpan(degree,s,spline.knots);
    N := Bspline1D.Internal.n_DersBasisFuns(span,s,degree,derN,spline.knots);
    
    for i in 1:size(y_derN,1) loop
     y_derN[i] := N[derN+1,:]*spline.controlPoints[span-degree:span,i];
    end for;
    
    annotation (Documentation(info="<html>
  
</html>"));
end evaluateDerN;
  
encapsulated function plot "Plot spline" 
  import Modelica;
  import Modelica_Interpolation.Bspline1D;
  import Plot3D;
  extends Modelica.Icons.Function;
  input Bspline1D spline "Bspline to be plotted";
  input Integer nPoints(min=2) = 200 "Number of points";
  // input String yLabel="" "Ordinate description";
  input Boolean matrixPlot=true 
      "<html>=true, if all dimensions are plotted with respect to the parameterization;<br>=false, if 2 or 3 dimensional splines are plotted in 2D or 3D</html>";
  input Boolean autoRange=true 
      "= true, if abszissa range is automatically determined";
  input Real s_min=0.0 "Minimum parameter value, if autoRange = false" 
                                                                      annotation(Dialog(enable=not autoRange));
  input Real s_max=1.0 "Maximum parameter value, if autoRange = false" 
                                                                      annotation(Dialog(enable=not autoRange));
  input Integer toWindow = -1 
      "-1/0/>0 plot in new window/last window/window ID";
  input Boolean clearWindow= false 
      "= true, if previous window content is removed";
  input String heading="Spline" "Heading of the spline diagram";
  // input String legend="" "Legend of curve (useful for multiple curves)";
  input Integer derN=0 
      "Plot the derN-th derivative (derN=0 is the spline, derN=1 is the first derivative)";
  output Integer windowID "ID of the used plot window";
  protected 
  Integer nDim = size(spline.controlPoints,2);
  String legend[nDim];
  String heading2;
  Real s_min2;
  Real s_max2;
  Real s[nPoints];
  Real y[nPoints,nDim];
  Real ds;
  Boolean OK;
  Integer nParam = size(spline.param,1) "Number of parameterization points";
  Real yParam[nParam,nDim];
  Integer window;
algorithm 
  // Determine range of abszissa
  if autoRange then
     s_min2 :=spline.param[1];
     s_max2 :=spline.param[end];
  else
     s_min2 :=s_min;
     s_max2 :=s_max;
  end if;
    
  // Interpolate points
  ds :=(s_max2 - s_min2)/(nPoints - 1);
  for i in 1:nPoints loop
     s[i] :=s_min2 + (i - 1)*ds;
     y[i,:] :=Bspline1D.evaluateDerN(spline, s[i], derN);
  end for;
    
  // Compute original points (they are exactly interpolated)
  if derN == 0 then
     for i in 1:nParam loop
        yParam[i,:] :=Bspline1D.evaluate(spline, spline.param[i]);
     end for;
  end if;
    
  // Plot spline depending on dimension of y
  if matrixPlot or nDim == 1 or nDim > 3 or derN > 0 then
     // plot y over u
     windowID := createPlot(id=toWindow, y=fill("", 0), erase=clearWindow,
                 autoscale=true, autoerase=false, grid=true, heading=heading);
     for i in 1:nDim loop
        legend[i] := "y[" + String(i) + "]";
     end for;
     plotArrays(s, y, legend=legend, title=heading);
      
     if derN == 0 then
       window := createPlot(id=windowID, y=fill("", 0), erase=false, autoscale=true,
                  autoerase=false, grid=true, heading=heading);
       plotArrays(spline.param, yParam, style=fill(-1,nDim), title=heading);
     end if;
      
  elseif nDim == 2 then
     // plot the second column of y over the first column
     windowID := createPlot(id=toWindow, y=fill("", 0), erase=clearWindow,
                 autoscale=true, autoerase=false, grid=true, heading=heading);
     OK := plotArray(y[:,1], y[:,2]);
     window := createPlot(id=windowID, y=fill("", 0), erase=false, autoscale=true,
                autoerase=false, grid=true, heading=heading);
     OK := plotArray(yParam[:,1], yParam[:,2], style=-1);
      
  elseif nDim == 3 then
     window := if windowID <= 0 then 1 else windowID;
     Plot3D.plotLines(plotId=window,plotData=
                 {Plot3D.Records.PlotData(x=[y[:, 1]], y=[y[:, 2]], z=[y[:, 3]])});
      
/*
     Plot3D.plotPoints(plotId=window,plotData=
                      {Plot3D.Records.PlotData(x=[yParam[:,1]], y=[yParam[:,2]], z=[yParam[:,3]])});
*/
  end if;
    
    annotation (Documentation(info="<html>
  
</html>"));
end plot;
  
  encapsulated package Internal "Utility functions for package Bspline1D" 
    import Modelica;
    extends Modelica.Icons.Library;
    
  annotation (
    Documentation(info="<html>
<p>
This package contains utility functions that are usually not called directly
by a user, but are needed in the Bspline1D record.
</p>
 
</html>
"));
    encapsulated function interpolation 
      "Interpolation of a vector of points with a Bspline of degree n" 
      import Modelica;
      import Modelica_Interpolation.Bspline1D;
      extends Modelica.Icons.Function;
      input Real param[:] 
        "parameterization of the data points (not necessarily in the range 0..1)";
      input Real points[size(param, 1), :] 
        "[i,:] is point i on the curve to be interpolated";
      input Integer degree(min=1) = 3 "Polynomial degree of interpolation";
      output Bspline1D spline(
               redeclare Real controlPoints[size(points,1), size(points,2)],
               redeclare Real knots[size(points,1)+degree+1],
               redeclare Real param[size(points,1)]) 
        "Bspline in a form which can be quickly interpolated";
      
    /*
    ndim=size(points, 2),
    ncontrol=size(points, 1),
    degree=degree)
protected 
  Real ctrlp[spline.ncontrol,spline.ndim];
  Real k[spline.ncontrol+degree+1];
*/
      
    algorithm 
     //old
     //(ctrlp,k) := interpolation_raw(points,param,degree);
     (spline.controlPoints, spline.knots) := Bspline1D.Internal.interpolation_bandmatrix(param,points,degree);
      spline.param :=param;
      
    /*
 spline.controlPoints := ctrlp;
 spline.knots := k;
*/
    end interpolation;
    
    encapsulated function interpolation_bandmatrix "Interpolation of the points with a Bspline of degree n. Do NOT return a Bspline struct.
  Return the the raw information of control points and knots." 
      import Modelica;
      import Modelica_Interpolation;
      import Modelica_Interpolation.Bspline1D;
      extends Modelica.Icons.Function;
      
      input Real param[:] 
        "parameterization of the data points (not necessarily in the range 0..1)";
      input Real points[size(param, 1), :] 
        "[i,:] is point i on the curve to be interpolated";
      input Integer degree(min=1) = 3 "Polynomial degree of interpolation";
      output Real controlPoints[size(points, 1),size(points, 2)] 
        "Control points";
      output Real knots[size(points, 1)+degree+1] "knots";
    protected 
      Integer nknots=size(knots, 1);
      Integer ndim=size(points, 2);
      Integer npoints;
      Integer knots_tech;
      //Real S[size(points,1),size(points,1)];
      
      Real u;
      Integer span;
      Real evalBasisFuns[degree+1];
      Real Band[3*degree+1,size(points,1)];
      Integer kl = degree;
      Integer ku = degree;
      Integer info=0;
      String sout;
    algorithm 
      /*
  The NURBS Book: Global Interpolation (page 364)
  */
      npoints := size(points,1);
      
     // build the knots
     //     1:  knots = parameter (for testing)
     //     2:  knots are built with averaging
     //     3:  knots equidistant (for testing)
     knots_tech := 2;
      
     if knots_tech == 1 then
        knots[1:degree] := ones(degree)*param[1];
        knots[degree+1:npoints+degree] := param;
        knots[npoints+degree+1:npoints+2*degree] := ones(degree)*param[npoints];
        
     end if;
      
     if knots_tech == 2 then
     // with averaging to avoid a singularity system of equation
        knots[1:degree+1] := ones(degree+1)*param[1];
        for j in 1:npoints-degree-1 loop
           knots[degree+j+1] := sum(param[j+1:j+degree])/degree;
        end for;
        knots[npoints+1:npoints+degree+1] := ones(degree+1)*param[npoints];
        
     end if;
      
     if knots_tech == 3 then
        knots[1:degree+1] := ones(degree+1)*param[1];
        for j in 1:npoints-1 loop
           knots[degree+j+1] := j/(npoints-1);
        end for;
        knots[npoints+degree+1:npoints+2*degree] := ones(degree)*param[npoints];
        
     end if;
      
     // build the equation system
    // S := zeros(npoints,npoints);
      
     for i in 1:npoints loop
       u := param[i];
       span := Bspline1D.Internal.n_findSpan(degree,u,knots);
       //S[i,span-degree:span] := n_BasisFuns(span,u,degree,knots);
       evalBasisFuns := Bspline1D.Internal.n_BasisFuns(span,u,degree,knots);
        
       for j in 1:degree+1 loop
         Band[kl+1+ku+i-span+degree-j+1,span-degree+j-1]:=evalBasisFuns[j];
    //Band[kl+1+ku+i-span+degree-j+1,span-degree+j-1]:=10*i+span-degree-1+j;
          
       end for;
        
     end for;
      
    /*
for i in 1:npoints loop
    sout :="i = " + String(i) + ":";
    for j in 1:degree+1 loop
      sout :=sout + "   " + String(Band[j, i]);
    end for;
    Utilities.ModelicaMessage(sout + "\n");
end for;
*/
      
     // solve the equation system
     (controlPoints,info) := Modelica_Interpolation.Utilities.solveBandedWithMatrix(kl,ku,Band,points);
     // assert(info == 0, "Error when computing spline coefficients");
      
    if info <> 0 then
      // if solving with band matrix is not succesful, use full matrix
      (controlPoints,knots) := Bspline1D.Internal.interpolation_raw(param,points,degree);
        
    end if;
      
    end interpolation_bandmatrix;
    
    encapsulated function interpolation_raw "Interpolation of the points with a Bspline of degree n. Do NOT return a Bspline struct.
  Return the the raw information of control points and knots." 
      import Modelica;
      import Modelica_Interpolation;
      import Modelica_Interpolation.Bspline1D;
      extends Modelica.Icons.Function;
      input Real param[:] 
        "parameterization of the data points (not necessarily in the range 0..1)";
      input Real points[size(param, 1), :] 
        "[i,:] is point i on the curve to be interpolated";
      input Integer degree(min=1) = 3 "Polynomial degree of interpolation";
      output Real controlPoints[size(points, 1),size(points, 2)] 
        "Control points";
      output Real knots[size(points, 1)+degree+1] "knots";
    protected 
      Integer nknots=size(knots, 1);
      Integer ndim=size(points, 2);
      Integer npoints;
      Integer knots_tech;
      Real S[size(points,1),size(points,1)];
      Real u;
      Integer span;
    algorithm 
      /*
  The NURBS Book: Global Interpolation (page 364)
  */
      npoints := size(points,1);
      
     // build the knots
     //     1:  knots = parameter (for testing)
     //     2:  knots are built with averaging
     //     3:  knots equidistant (for testing)
     knots_tech := 2;
      
     if knots_tech == 1 then
        knots[1:degree] := ones(degree)*param[1];
        knots[degree+1:npoints+degree] := param;
        knots[npoints+degree+1:npoints+2*degree] := ones(degree)*param[npoints];
        
     end if;
      
     if knots_tech == 2 then
     // with averaging to avoid a singularity system of equation
        knots[1:degree+1] := ones(degree+1)*param[1];
        for j in 1:npoints-degree-1 loop
           knots[degree+j+1] := sum(param[j+1:j+degree])/degree;
        end for;
        knots[npoints+1:npoints+degree+1] := ones(degree+1)*param[npoints];
        
     end if;
      
     if knots_tech == 3 then
        knots[1:degree+1] := ones(degree+1)*param[1];
        for j in 1:npoints-1 loop
           knots[degree+j+1] := j/(npoints-1);
        end for;
        knots[npoints+degree+1:npoints+2*degree] := ones(degree)*param[npoints];
        
     end if;
      
     // build the equation system
     S := zeros(npoints,npoints);
      
     for i in 1:npoints loop
       u := param[i];
       span := Bspline1D.Internal.n_findSpan(degree,u,knots);
       S[i,span-degree:span] := Bspline1D.Internal.n_BasisFuns(span,u,degree,knots);
        
     end for;
      
     // solve the equation system
     controlPoints := Modelica_Interpolation.Utilities.solveMatrix(S,points);
      
    end interpolation_raw;
    
    encapsulated function interpolationBessel 
      "Interpolation of the points with a Bspline of degree 3 and Bessel end condition" 
      import Modelica;
      import Modelica_Interpolation;
      import Modelica_Interpolation.Bspline1D;
      extends Modelica.Icons.Function;
      input Real param[:] 
        "parameterization of the data points (not necessarily in the range 0..1)";
      input Real points[size(param, 1), :] 
        "[i,:] is point i on the curve to be interpolated";
      output Bspline1D spline(
               redeclare Real controlPoints[size(points,1)+2, size(points,2)],
               redeclare Real knots[size(points,1)+2+3+1],
               redeclare Real param[size(points,1)]) 
        "spline with Bessel end condition in a form which can be quickly interpolated";
    protected 
      Integer ndim=size(points, 2);
      Integer ncontrol = size(points,1) + 2;
      Real S[size(points,1)-2,size(points,1)-2];
      Real u;
      Real u2;
      Real nik[4];
      Real nik2[4];
      Integer degree;
      Real knots[size(points,1)+2*3];
      Integer n_data;
      Real alpha;
      Real beta;
      Real a[size(points, 2)];
      Real rs[size(points, 2)];
      Real re[size(points, 2)];
      Real p_vec[size(points,1) + 2 -4, size(points, 2)];
      Integer span;
    algorithm 
      /*
  Farin: Curves and Surfaces for CAGD (page 157)
  */
      degree := 3;
      
     n_data := size(points,1);
      
     //build the knots
      
     knots[1:degree] := ones(3)*param[1];
     knots[degree+1:n_data+degree] := param;
     knots[n_data+degree+1:n_data+2*degree] := ones(3)*param[n_data];
      
     spline.controlPoints := zeros(n_data+2,ndim);
     spline.controlPoints[1,:] := points[1,:];
     spline.controlPoints[n_data+2,:] := points[n_data,:];
      
     alpha := (param[3]-param[2])/(param[3]-param[1]);
     beta := 1-alpha;
     a := (points[2,:] - (alpha^2)*points[1,:] - (beta^2)*points[3,:])/(2*alpha*beta);
     spline.controlPoints[2,:] := (2/3)*(alpha*points[1,:] + beta*a) + points[1,:]/3;
      
     alpha := (param[n_data-2]-param[n_data-1])/(param[n_data-2]-param[n_data]);
     beta := (1-alpha);
     a := (points[n_data-1,:] - (alpha^2)*points[n_data,:] - (beta^2)*points[n_data-2,:])/(2*alpha*beta);
     spline.controlPoints[n_data+1,:] := (2/3)*(alpha*points[n_data,:] + beta*a) + points[n_data,:]/3;
      
     // build the equation system
     S := zeros(n_data-2,n_data-2);
      
     u2 := param[2];
     span := Bspline1D.Internal.n_findSpan(degree,u2,knots);
     nik2 := Bspline1D.Internal.n_BasisFuns(span,u2,degree,knots);
     S[1,1:2] := nik2[2:3];
     rs := points[2,:] - spline.controlPoints[2,:]*nik2[1];
      
     for i in 1:n_data-4 loop
       u := param[i+2];
       span := Bspline1D.Internal.n_findSpan(degree,u,knots);
      nik := Bspline1D.Internal.n_BasisFuns(span,u,degree,knots);
       S[i+1,i:i+2] := nik[1:3];
        
     end for;
     u := param[n_data-1];
     span := Bspline1D.Internal.n_findSpan(degree,u,knots);
     nik := Bspline1D.Internal.n_BasisFuns(span,u,degree,knots);
     S[n_data-2,n_data-3:n_data-2] := nik[1:2];
      
     re := points[n_data-1,:] - spline.controlPoints[n_data+1,:]*nik[3];
     p_vec[1,:] := rs;
     p_vec[2:n_data-3,:] := points[3:n_data-2,:];
     p_vec[n_data-2,:] := re;
      
     // solve the equation system
     spline.controlPoints[3:n_data,:] := Modelica_Interpolation.Utilities.solveMatrix(S,p_vec);
     spline.knots := knots;
     spline.param := param;
    end interpolationBessel;
    
    encapsulated function n_BasisFuns 
      "Compute the nonvanishing basis functions" 
      import Modelica;
      extends Modelica.Icons.Function;
      input Integer i "index";
      input Real u "parameter";
      input Integer p "degree";
      input Real knots[:] "knot vector";
      output Real N[p+1] "Basis functions";
    protected 
      Integer j;
      Integer r;
      Real left[p+1];
      Real right[p+1];
      Real temp;
      Real saved;
    algorithm 
     /*
  The NURBS Book: Algorithm A2.2 (page 70)
  */
      N[1] := 1;
      for j in 1:p loop
       left[j] := u - knots[i+1-j];
       right[j] := knots[i+j] - u;
       saved := 0.0;
        
       for r in 1:j loop
        temp := N[r]/(right[r]+left[j-r+1]);
        N[r] := saved + right[r]*temp;
        saved := left[j-r+1]*temp;
          
      end for;
      N[j+1] := saved;
      end for;
    end n_BasisFuns;
    
    encapsulated function n_DersBasisFuns 
      "Compute nonzero basis functions and their derivatives" 
      import Modelica;
      extends Modelica.Icons.Function;
      input Integer i "index";
      input Real u "parameter";
      input Integer p "degree";
      input Integer n "n-th derivative";
      input Real knots[:] "knot vector";
      output Real ders[n+1,p+1] "ders[k,:] is (k-1)-th derivative";
    protected 
      Integer j;
      Integer r;
      Real left[p+1];
      Real right[p+1];
      Real temp;
      Real saved;
      Real ndu[p+1,p+1];
      Integer s1;
      Integer s2;
      Integer j1;
      Integer j2;
      Real a[2,p+1];
      Real d;
      Integer rk;
      Integer pk;
      Integer prod;
      Integer tt;
    algorithm 
     /*
  The NURBS Book: Algorithm A2.3 (page 72)
  */
      ndu[1,1] := 1;
      for j in 1:p loop
       left[j] := u - knots[i+1-j];
       right[j] := knots[i+j] - u;
       saved := 0.0;
        
       for r in 1:j loop
        ndu[j+1,r] := right[r]+left[j-r+1];
        temp := ndu[r,j]/ndu[j+1,r];
        ndu[r,j+1] := saved + right[r]*temp;
        saved := left[j-r+1]*temp;
          
      end for;
      ndu[j+1,j+1] := saved;
      end for;
      
      for j in 1:p+1 loop
       ders[1,j] := ndu[j,p+1];
      end for;
      
      for r in 1:p+1 loop
       s1 := 1;
       s2 := 2;
       a[1,1] := 1.0;
        
       for k in 1:n loop
        d := 0.0;
        rk := r-k-1;
        pk := p-k;
          
        if r-1>=k then
         a[s2,1] := a[s1,1]/ndu[pk+2,rk+1];
         d := a[s2,1]*ndu[rk+1,pk+1];
            
        end if;
          
        if rk >= -1 then
         j1 :=1;
            
        else
         j1 :=-rk;
            
        end if;
          
        if r-1 <= pk+1 then
         j2 := k-1;
            
        else
         j2 := p-r+1;
            
        end if;
          
        for j in j1:j2 loop
         a[s2,j+1] :=(a[s1, j + 1] - a[s1, j])/ndu[pk + 2, rk + j + 1];
         d :=d + a[s2, j + 1]*ndu[rk + j + 1, pk + 1];
            
        end for;
          
        if r-1 <= pk then
         a[s2,k+1] := -a[s1,k]/ndu[pk+2,r];
         d := d + a[s2,k+1]*ndu[r,pk+1];
            
        end if;
          
        ders[k+1,r] := d;
        tt := s1;
        s1 := s2;
        s2 := tt;
          
       end for;
      end for;
      
      prod := p;
      
     for k in 1:n loop
        
       for j in 1:p+1 loop
        ders[k+1,j] := ders[k+1,j]*prod;
          
       end for;
       prod := prod*(p-k);
        
     end for;
      
    end n_DersBasisFuns;
    
    encapsulated function n_findSpan "Determine the knot span index" 
      import Modelica;
      extends Modelica.Icons.Function;
      input Integer p "degree";
      input Real u "parameter";
      input Real knots[:] "knot vector";
      output Integer i "The knot span index";
    protected 
      Integer n;
      Integer low;
      Integer high;
      Integer mid;
    algorithm 
     /*
  The NURBS Book: Algorithm A2.1 (page 68)
  */
      n:=size(knots,1)-p-1;
      
     if abs(u-knots[n+1])<10e-12 then
      i := n;
        
     else
      low := p;
      high := n+1;
      mid := integer((low+high)/2);
        
      while 
           (u<knots[mid] or u>=knots[mid+1]) loop
           assert(low+1<high,"Value must be within limits for Bspline1D.Utilities.n_findSpan");
          
       if (u<knots[mid]) then
         high := mid;
            
       else
         low := mid;
            
       end if;
       mid := integer((low+high)/2);
          
      end while;
      i := mid;
        
     end if;
    end n_findSpan;
    
    function evaluate_d "Time derivative of function evaluate" 
      import Modelica;
      import Modelica_Interpolation.Bspline1D;
        extends Modelica.Icons.Function;
        input Bspline1D spline "Bspline to be evaluated";
        input Real s "Parameter value at which Bspline shall be evaluated";
        input Real sd "= der(s)";
        output Real yd[size(spline.controlPoints,2)] 
        "Time derivative of y at s";
        annotation(derivative(noDerivative=spline)=evaluate_dd);
    algorithm 
         yd := Bspline1D.evaluateDerN(spline, s, 1)*sd;
    end evaluate_d;
    
    function evaluate_dd "Second time derivative of function evaluate" 
      import Modelica;
      import Modelica_Interpolation.Bspline1D;
        extends Modelica.Icons.Function;
        input Bspline1D spline "Bspline to be evaluated";
        input Real s "Parameter value at which Bspline shall be evaluated";
        input Real sd "= der(s)";
        input Real sdd "= der(sd)";
        output Real ydd[size(spline.controlPoints,2)] 
        "Second time derivative of y at s";
    algorithm 
         ydd := Bspline1D.evaluateDerN(spline, s, 1)*sdd +
                Bspline1D.evaluateDerN(spline, s, 2)*sd*sd;
    end evaluate_dd;
    
  function evaluateDerN_d "Time derivative of function evaluateDerN" 
      import Modelica;
      import Modelica_Interpolation.Bspline1D;
      extends Modelica.Icons.Function;
      input Bspline1D spline "Bspline to be evaluated";
      input Real s "Parameter value at which Bspline shall be evaluated";
      input Integer derN(min=0) 
        "Differentation order (0: function value, 1: first derivative, ...)";
      input Real sd "= der(s)";
      output Real y_derN_d[size(spline.controlPoints,2)] 
        "Derivative of derN-th derivative of Bspline at s";
  algorithm 
       y_derN_d := Bspline1D.evaluateDerN(spline, s, derN+1)*sd;
  end evaluateDerN_d;
    
  end Internal;
  
end Bspline1D;
