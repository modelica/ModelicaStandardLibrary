within Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics;
function pipeWithScalarField
  "Function defining the surface characteristic of a pipe where a scalar field value is displayed with color along the pipe axis"
  extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
    final multiColoredSurface=true);
  input SI.Radius rOuter "Outer radius of cylinder" annotation(Dialog);
  input SI.Length length "Length of cylinder" annotation(Dialog);
  input SI.Position xsi[:]
    "Relative position along the pipe with x[1] = 0, x[end] = 1" annotation(Dialog);
  input Real T[size(xsi,1)] "Scalar field value at position xsi*length" annotation(Dialog);
  input Real T_min "T <= T_min is mapped to colorMap[1,:]" annotation(Dialog);
  input Real T_max "T >= T_max is mapped to colorMap[end,:]" annotation(Dialog);
  input Real colorMap[:,3]
    "Color map to map scalar T to a corresponding color" annotation(Dialog);
protected
  Real beta;
  Real xsi_i;
  Real Ti;
  Real Ci[3];
  Integer k;
algorithm
  k:=1;
  for i in 1:nu loop
    // Compute actual xsi-position along cylinder axis
    xsi_i := (i-1)/(nu-1);

    // Interpolate in xsi and T to determine the corresponding value of Ti(xsi_i)
    (Ti,k) := Modelica.Math.Vectors.interpolate(xsi, T, xsi_i, k);

    // Map the scalar field value Ti to a color value
    Ci := Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor(
      Ti,
      T_min,
      T_max,
      colorMap);

    // Determine outputs
    for j in 1:nv loop
      beta := 2*Modelica.Constants.pi*(j-1)/(nv-1);
      X[i,j] := length*xsi_i;
      Y[i,j] := rOuter*Modelica.Math.sin(beta);
      Z[i,j] := rOuter*Modelica.Math.cos(beta);
      C[i,j,:] := Ci;
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>
Function <strong>pipeWithScalarField</strong> computes the X, Y, Z and C arrays in order to
visualize a pipe and a scalar field along the pipe axis with model
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.PipeWithScalarField\">PipeWithScalarField</a>.
The latter is shown by mapping scalar
field to color values with a color map and utilizing this color
at the perimeter associated with the corresponding axis location.
Typically the scalar field value is a temperature, but might
be also another quantity.
Predefined color maps are available from
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">MultiBody.Visualizers.Colors.ColorMaps</a>
and can be selected via input argument \"colorMap\".
A color map with the corresponding scalar field values can be exported
as vector-graphics in svg-format with function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>.
An example is shown in the next figure:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField.png\">
</blockquote>

<p>
The color coding is shown in the next figure. It was generated with
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg</a>
using the following call:
</p>

<blockquote><pre>
colorMapToSvg(Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet(),
              height=50, nScalars=6, T_max=100, heading=\"Temperature in C\");
</pre></blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField-ColorMap.png\">
</blockquote>
</html>"));
end pipeWithScalarField;
