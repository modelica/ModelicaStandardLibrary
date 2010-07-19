within Modelica.Math;
package Interfaces
  "Interfaces for functions that are used as arguments to functions"
  extends Modelica.Icons.Package;
encapsulated partial function PartialScalarFunction
    "Interface for a function with one input and one output Real signal"
  input Real u "Independent variable";
  output Real y "Dependent variable y=f(u)";
    annotation (Documentation(info="<html>
<p>
This partial function defines the interface of a function with
one input and one output Real signal. All scalar functions
of Modelica.Math are derived from this base type by inheritance.
This allows to use these functions directly as function arguments
to a function, see, .e.g.,
<a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Math.Nonlinear.Examples</a>.
</p>

</html>"));
end PartialScalarFunction;
  annotation (Documentation(info="<html>
<p>
Interface definitions of functions. The main purpose is to use functions 
derived from these interface definitions as function arguments
to a function, see, .e.g.,
<a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Math.Nonlinear.Examples</a>.
</p>
</html>"));
end Interfaces;
