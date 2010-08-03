within Modelica.Math;
package Interfaces "Interfaces for functions"
  extends Modelica.Icons.Package;
encapsulated partial function partialScalarFunction
    "Interface for a function with one input and one output Real signal"
  input Real u "Independent variable";
  output Real y "Dependent variable y=f(u)";
    annotation (Documentation(info="<html>
<p>
This partial function defines the interface of a function with
one input and one output Real signal. The scalar functions
of <a href=\"modelica://Modelica.Math.Nonlinear\">Modelica.Math.Nonlinear</a>
are derived from this base type by inheritance.
This allows to use these functions directly as function arguments
to a function, see, .e.g.,
<a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Math.Nonlinear.Examples</a>.
</p>

</html>"));
end partialScalarFunction;
  annotation (Documentation(info="<html>
<p>
Interface definitions of functions. The main purpose is to use functions 
derived from these interface definitions as function arguments
to a function, see, .e.g.,
<a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Math.Nonlinear.Examples</a>.
</p>
</html>"));
  partial function partialColorMap
    "Interface for a function returning a color map"
    input Integer n_colors=64 "Number of colors in the color map";
    output Real colorMap[n_colors,3] "Color map to map a scalar to a color";
    annotation (Documentation(info="<html>
<p>
This partial function defines the interface of a function that returns
a color map. Predefined color map functions are defined in package
<a href=\"modelica://Modelica.Math.Colors.ColorMaps\">Modelica.Math.Colors.ColorMaps</a>.
</p>
</html>"));
  end partialColorMap;
end Interfaces;
