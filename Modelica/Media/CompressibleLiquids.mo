within Modelica.Media;
package CompressibleLiquids "compressible liquid models"
  extends Modelica.Icons.MaterialPropertiesPackage;
  package Common "base classes for compressible liquids"
    extends Icons.Library;
    partial package LinearWater_pT
      "base class for liquid, linear compressibility water models"
      extends Media.Interfaces.PartialLinearFluid(
        constantJacobian=true,
        reference_d=Modelica.Media.Water.StandardWater.density(state),
        reference_h=Modelica.Media.Water.StandardWater.specificEnthalpy(state),
        reference_s=Modelica.Media.Water.StandardWater.specificEntropy(state),
        cp_const=Modelica.Media.Water.StandardWater.specificHeatCapacityCp(state),
        beta_const=
            Modelica.Media.Water.StandardWater.isobaricExpansionCoefficient(state),
        kappa_const=Modelica.Media.Water.StandardWater.isothermalCompressibility(
            state),
        MM_const=Modelica.Media.Water.StandardWater.molarMass(state));

      constant Modelica.Media.Water.StandardWater.ThermodynamicState state=
          Modelica.Media.Water.StandardWater.setState_pT(reference_p, reference_T);
    end LinearWater_pT;
  end Common;

  package LinearColdWater "cold water model with linear compressibility"
    extends Media.Interfaces.PartialLinearFluid(
      constantJacobian=true,
      reference_p=101325,
      reference_T=278.15,
      reference_d=997.05,
      reference_h=104929,
      reference_s=100.0,
      cp_const=4181.9,
      beta_const=2.5713e-4,
      kappa_const=4.5154e-10,
      MM_const=0.018015268);

  redeclare function extends dynamicViscosity "Dynamic viscosity of water"
  algorithm
    eta := 1.5e-3;
  end dynamicViscosity;

  redeclare function extends thermalConductivity
      "Thermal conductivity of water"
  algorithm
    lambda := 0.572;
  end thermalConductivity;

  end LinearColdWater;

  package LinearWater_pT_Ambient
    "liquid, linear compressibility water model at 1.01325 bar and 25 degree Celsius"
    extends Modelica.Media.CompressibleLiquids.Common.LinearWater_pT(
                           reference_p = 101325, reference_T = 298.15);
  redeclare function extends dynamicViscosity "Dynamic viscosity of water"
  algorithm
    eta := 8.9e-4;
  end dynamicViscosity;

  redeclare function extends thermalConductivity
      "Thermal conductivity of water"
  algorithm
    lambda := 0.608;
  end thermalConductivity;
    annotation (Documentation(info="<html>
<h4>Water model with linear compressibility at ambient conditions</h4>
</html>"));
  end LinearWater_pT_Ambient;

  annotation (Documentation(info="<html>

<h4>Fluid models with linear compressibility, using PartialLinearFluid as base class.</h4>
<p>The linear compressibility fluid models contained in this package are based on the assumptions that:
</p>
<ul>
<li>The specific heat capacity at constant pressure (cp) is constant</li>
<li>The isobaric expansion coefficient (beta) is constant</li>
<li>The isothermal compressibility (kappa) is constant</li>
<li>Pressure and temperature are used as states</li>
</ul>
<p>
This results in models that are only valid for small temperature ranges, but sufficient to model compressibility and e.g., the \"water hammer\" effect. ANother advantage id that only 3 values need to be measured to have an initial model. Hydraulic fluids can often be approximated by this type of model.
</p>
<p>
That means that the density is a linear function in temperature and in pressure.
In order to define the complete model, a number of constant reference values are needed which
are computed at the reference values of the states pressure p and temperature T. The model can
be interprested as a linearization of a full non-linear fluid model (but it is not linear in all
thermodynamic coordinates). Reference values are needed for
</p>
<ol>
<li>the density (reference_d),</li>
<li>the specific enthalpy (reference_h),</li>
<li>the specific entropy (reference_s).</li>
</ol>
<p>
Apart from that, a user needs to define the molar mass, MM_const.
Note that it is possible to define a fluid by computing the reference
values from a full non-linear fluid model by computing the package constants
using the standard functions defined in a fluid package (see example in Common, LinearWater_pT).
</p>

</html>"));
end CompressibleLiquids;
