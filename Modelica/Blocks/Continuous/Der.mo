within Modelica.Blocks.Continuous;
block Der "Derivative of input (= analytic differentiations)"
    extends Interfaces.SISO;

equation
  y = der(u);
    annotation (defaultComponentName="der1",
 Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(
          extent={{-96,28},{94,-24}},
          textString="der()",
          textColor={0,0,127})}),
        Documentation(info="<html>
<p>
Defines that the output y is the <em>derivative</em>
of the input u. Note, that Modelica.Blocks.Continuous.Derivative
computes the derivative in an approximate sense, where as this block computes
the derivative exactly. This requires that the input u is differentiated
by the Modelica translator, if this derivative is not yet present in
the model.
</p>
</html>"));
end Der;
