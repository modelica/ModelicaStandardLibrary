within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic;
function app_mu_r
  "Approximation of relative permeability mu_r as a function of flux density B for soft magnetic materials"
  extends Modelica.Icons.Function;
  input SI.MagneticFluxDensity B
    "Flux density in ferromagnetic flux tube element";
  input BaseData material "Material specific parameter set";
  output SI.RelativePermeability mu_r=
    1 + (material.mu_i - 1 + material.c_a*B_N)/(1 + material.c_b*B_N + B_N^material.n)
    "Relative magnetic permeability of ferromagnetic flux tube element";
protected
  Real B_N=abs(B/material.B_myMax)
    "Flux density B normalized to flux density at maximum relative permeability B_myMax";
  annotation (Inline=true,
    Documentation(info="<html>
<p>
The relative permeability mu_r as a function of flux density B for all soft magnetic materials currently included in this library is approximated with the following function <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro00]</a>:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/eq_mu_rApprox.png\" alt=\"Equation for approximation mu_r(B)\"/>
</div>

<p>
Two of the five parameters of this equation have a physical meaning, namely the initial relative permeability mu_i at B=0 and the magnetic flux density at maximum permeability B_myMax. B_N is the flux density normalized to latter parameter.
</p>
<h4>Note:</h4>
<p>
Should be preferred over <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.mu_rApprox\">mu_rApprox</a> 
due to the chance to inline the function.
</p>
</html>"));
end app_mu_r;
