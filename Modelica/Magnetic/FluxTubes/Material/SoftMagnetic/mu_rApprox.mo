within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic;
function mu_rApprox
  "Approximation of relative permeability mu_r as a function of flux density B for soft magnetic materials"

  extends Modelica.Icons.Function;

  input SI.MagneticFluxDensity B
    "Flux density in ferromagnetic flux tube element";
  //Material specific parameter set:
  input SI.RelativePermeability mu_i
    "Initial relative permeability at B=0";
  input SI.MagneticFluxDensity B_myMax
    "Flux density at maximum relative permeability";
  input Real c_a "Coefficient of approximation function";
  input Real c_b "Coefficient of approximation function";
  input Real n "Exponent of approximation function";

  output SI.RelativePermeability mu_r
    "Relative magnetic permeability of ferromagnetic flux tube element";

protected
  Real B_N
    "Flux density B normalized to flux density at maximum relative permeability B_myMax";

algorithm
  B_N := abs(B/B_myMax);
  mu_r := 1 + (mu_i - 1 + c_a*B_N)/(1 + c_b*B_N + B_N^n);

  annotation (Documentation(info="<html>
<p>
The relative permeability mu_r as a function of flux density B for all soft magnetic materials currently included in this library is approximated with the following function <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro00]</a>:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/eq_mu_rApprox.png\" alt=\"Equation for approximation mu_r(B)\"/>
</div>

<p>
Two of the five parameters of this equation have a physical meaning, namely the initial relative permeability mu_i at B=0 and the magnetic flux density at maximum permeability B_myMax. B_N is the flux density normalized to latter parameter.</p>
</html>"));
end mu_rApprox;
