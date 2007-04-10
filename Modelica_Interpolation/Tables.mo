package Tables 
  "Spline interpolation with models and functions operating on tables" 
  
  package Examples 
    "Demo models and functions demonstrating the usage of this package" 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<html>
 
</html>"));
    model ModelInterpolation 
      extends Modelica.Icons.Example;
      Modelica_Interpolation.Tables.Table1D table1D(table=[-4,-2; -2,-3; 0,0; 2,3; 4,2], degree=
            3) 
        annotation (extent=[-40,20; -20,40]);
      Modelica.Blocks.Sources.Sine sine(amplitude=2, freqHz=3) 
        annotation (extent=[-80,20; -60,40]);
      Modelica.Blocks.Continuous.Der der1 annotation (extent=[0,20; 20,40]);
      Modelica.Blocks.Math.Gain gain annotation (extent=[80,20; 100,40]);
      Modelica.Blocks.Continuous.Der der2 annotation (extent=[40,20; 60,40]);
    equation 
      
      annotation (Diagram);
      connect(sine.y, table1D.u) annotation (points=[-59,30; -42,30], style(
            color=74, rgbcolor={0,0,127}));
      connect(table1D.y[1], der1.u) annotation (points=[-19,30; -2,30], style(
            color=74, rgbcolor={0,0,127}));
      connect(der1.y, der2.u) annotation (points=[21,30; 38,30], style(color=74,
            rgbcolor={0,0,127}));
      connect(der2.y, gain.u) annotation (points=[61,30; 78,30], style(color=74,
            rgbcolor={0,0,127}));
    end ModelInterpolation;
    
    model FunctionInterpolation 
      extends Modelica.Icons.Example;
      parameter Real table[:,:] = [-4,-2; -2,-3; 0,0; 2,3; 4,2];
      Modelica.Blocks.Sources.Sine sine(amplitude=2, freqHz=3);
      Real y[1];
    equation 
      y = Modelica_Interpolation.Tables.interpolate1D(table,3,sine.y);
    end FunctionInterpolation;
  end Examples;
  
  model Table1D "Table look-up in one dimension with one input and n outputs" 
    parameter Real table[:, :] "table matrix (grid = first column)";
    parameter Integer degree(min=1)=1 
      "Desired polynomial degree used for interpolation (=1: linear, =2 quadratic, ...)";
    extends Modelica.Blocks.Interfaces.SIMO(final nout=size(table, 2)-1);
    annotation (preferedView="info",
      Documentation(info="<html>
<p>
<b>Spline interpolation</b> in <b>one</b> dimension of a <b>table</b>.
The order of the polynomials used for interpolation are specified
with parameter <b>degree</b> (degree=1 is linear interpolation).
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<pre>
   table = [0,  0;
            1,  1;
            2,  4;
            4, 16]
   If, e.g., the input u = 1.0, the output y =  1.0,
       e.g., the input u = 1.5, the output y =  2.5,
       e.g., the input u = 2.0, the output y =  4.0,
       e.g., the input u =-1.0, the output y = -1.0 (i.e. extrapolation).
</pre>
 
</html>
"),   Icon(
        Line(points=[-60, 40; -60, -40; 60, -40; 60, 40; 30, 40; 30, -40; -30,
              -40; -30, 40; -60, 40; -60, 20; 60, 20; 60, 0; -60, 0; -60, -20;
              60, -20; 60, -40; -60, -40; -60, 40; 60, 40; 60, -40], style(
              color=0)),
        Line(points=[0, 40; 0, -40], style(color=0)),
        Rectangle(extent=[-60, 40; -30, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, 20; -30, 0], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, 0; -30, -20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, -20; -30, -40], style(
            color=0,
            fillColor=6,
            fillPattern=1))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=30,
              fillPattern =                                                  1)),
        Line(points=[-100, 0; -58, 0]),
        Line(points=[60, 0; 100, 0]),
        Text(extent=[-100, 100; 100, 64], string=
              "1 dimensional spline interpolation of table"),
        Line(points=[-54, 40; -54, -40; 54, -40; 54, 40; 28, 40; 28, -40; -28,
              -40; -28, 40; -54, 40; -54, 20; 54, 20; 54, 0; -54, 0; -54, -20;
              54, -20; 54, -40; -54, -40; -54, 40; 54, 40; 54, -40], style(
              color=0)),
        Line(points=[0, 40; 0, -40], style(color=0)),
        Rectangle(extent=[-54, 40; -28, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, 20; -28, 0], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, 0; -28, -20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, -20; -28, -40], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Text(extent=[-52,54; -34,42],   string="u"),
        Text(extent=[-22,54; 2,42], string="y[1]"),
        Text(extent=[4,54; 28,42], string="y[2]"),
        Text(extent=[0,-40; 32,-54], string="columns")));
  protected 
    parameter Modelica_Interpolation.Bspline1D tableSpline=
              Modelica_Interpolation.Bspline1D.fromTable(table=table,degree=degree) 
      "Table data in a form which can be quickly interpolated" annotation(Hide=true);
  equation 
    if size(table,1) == 1 then
       y = table[1,2:end];
    else
       y = Modelica_Interpolation.Bspline1D.evaluate(tableSpline,u);
    end if;
  end Table1D;
  annotation (Documentation(info="<html>
  
</html>"));
function interpolate1D "1-dim. interpolation in a table" 
    import Modelica;
    import Modelica_Interpolation.Bspline1D;
  extends Modelica.Icons.Function;
  input Real table[:, :] "[x, y1(x), y2(x), ..., yn(x)] data points";
  input Integer degree(min=1) = 1 "Polynomial degree of interpolation";
  input Real x "First column value at which spline shall be evaluated";
  output Real y[size(table,2)-1] "Value of table at x";
algorithm 
  y :=Bspline1D.evaluate(Bspline1D.fromTable(table, degree), x);
end interpolate1D;
end Tables;
