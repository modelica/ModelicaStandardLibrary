within ModelicaTest;
package Media
extends Modelica.Icons.ExamplesPackage;
  package TestAllProperties
  extends Modelica.Icons.ExamplesPackage;
    model PartialMediumFunctions
      import SI = Modelica.SIunits;
       replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium model";
       parameter Real eps_h_is = 1e-10;
       Medium.ThermodynamicState state = Medium.setState_pTX(
                Medium.reference_p, Medium.reference_T, Medium.reference_X);
       Medium.DynamicViscosity eta =      Medium.dynamicViscosity(state);
       Medium.ThermalConductivity lambda= Medium.thermalConductivity(state);
       Medium.PrandtlNumber Pr = Medium.prandtlNumber(state);
       Medium.AbsolutePressure p = Medium.pressure(state);
       Medium.Temperature T = Medium.temperature(state);
       Medium.Density d = Medium.density(state);
       Medium.SpecificEnthalpy h = Medium.specificEnthalpy(state);
       Medium.SpecificEnergy u = Medium.specificInternalEnergy(state);
       Medium.SpecificEntropy s = Medium.specificEntropy(state);
       Medium.SpecificEnergy g = Medium.specificGibbsEnergy(state);
       Medium.SpecificEnergy f = Medium.specificHelmholtzEnergy(state);
       Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(state);
       Medium.SpecificHeatCapacity cp2=Medium.heatCapacity_cp(state);
       Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
       Medium.SpecificHeatCapacity cv2=Medium.heatCapacity_cv(state);
       Medium.SpecificEnthalpy h_is=Medium.isentropicEnthalpy(2*Medium.reference_p,state);
        Medium.VelocityOfSound a=Medium.velocityOfSound(state);
       Medium.IsobaricExpansionCoefficient beta = Medium.isobaricExpansionCoefficient(state);
       Medium.IsobaricExpansionCoefficient beta2 = Medium.beta(state);
       SI.IsothermalCompressibility kappa = Medium.isothermalCompressibility(state);
       SI.IsothermalCompressibility kappa2 = Medium.kappa(state);
       Medium.DerDensityByPressure ddpT = Medium.density_derp_T(state);
       Medium.DerDensityByTemperature ddTp = Medium.density_derT_p(state);
       Medium.Density dddX[Medium.nX] = Medium.density_derX(state);
       Medium.MolarMass MM = Medium.molarMass(state);
       Medium.SpecificEnthalpy h2 = Medium.specificEnthalpy_pTX(
                            Medium.reference_p, Medium.reference_T, Medium.reference_X);
       Medium.Density d2 = Medium.density_pTX(
                            Medium.reference_p, Medium.reference_T, Medium.reference_X);
       Medium.ThermodynamicState state2 = Medium.setState_phX(
                Medium.reference_p, h, Medium.reference_X);
       Medium.ThermodynamicState state3 = Medium.setState_psX(
                Medium.reference_p, s, Medium.reference_X);
       Medium.ThermodynamicState state4 = if Medium.singleState then state else
                                       Medium.setState_dTX(d, T, Medium.reference_X);
       Medium.ThermodynamicState state5 = Medium.setSmoothState(0.1, state,state2,0.001);
       Medium.BaseProperties medium(preferredMediumStates=true,p(start=Medium.reference_p), T(start=Medium.reference_T), X(start=Medium.reference_X));
       Real err_T = abs(medium.T - T);
       Real err_d = abs(medium.d - d);
       Real err_u = abs(medium.u - u);

       // check isentropicEnthalpy
       Medium.ThermodynamicState state_h_is = Medium.setState_phX(2*Medium.reference_p, h_is, Medium.reference_X);
       Medium.SpecificEntropy s_is = Medium.specificEntropy(state_h_is);
       Real err_h_is = abs( s - s_is);
       constant Real eps=1e-10;
    equation
       medium.p=p;
       medium.h=h;
       medium.Xi=Medium.reference_X[1:Medium.nXi];

       // When iterating at the intial time the asserts below could be violated.
       // To avoid an error, the check is only performed at the end of the simulation.
       when terminal() then
          assert(err_T <= eps, "Error: abs(medium.T - T) > eps\n" +
                               "(err_T = " + String(err_T) + ", eps = " + String(eps) + ")");
       end when;

       when terminal() then
          assert(err_d <= eps, "Error: abs(medium.d - d) > eps" +
                               "(err_d = " + String(err_d) + ", eps = " + String(eps) + ")");
       end when;

       when terminal() then
          assert(err_u <= eps, "Error: abs(medium.u - u) > eps" +
                               "(err_u = " + String(err_u) + ", eps = " + String(eps) + ")");
       end when;

      // when terminal() then
          assert(err_h_is <= eps_h_is, "Error: entropy not constant for isentropicEnthalpy" +
                               "(err_h_is = " + String(err_h_is) + ", eps = " + String(eps_h_is) + ")");
       // end when;
    end PartialMediumFunctions;

    model DryAirNasa
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.Air.DryAirNasa, eps_h_is=0.1);
      annotation (experiment(StopTime=0.1), experimentSetupOutput);
    end DryAirNasa;

    model LinearColdWater
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.CompressibleLiquids.LinearColdWater);
      annotation (experiment(StopTime=0.1), experimentSetupOutput);
    end LinearColdWater;

    model LinearWater_pT_Ambient
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.CompressibleLiquids.LinearWater_pT_Ambient);
      annotation (experiment(StopTime=0.1), experimentSetupOutput);
    end LinearWater_pT_Ambient;

    model CO2
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.IdealGases.SingleGases.CO2, eps_h_is=0.2);
      annotation (experiment(StopTime=0.1), experimentSetupOutput);
    end CO2;

    model FlueGasSixComponents
      "A copy of PartialMediumFunctions, but isentropicEnthalpy gets the additional argument exact=true"
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;
      package Medium =
          Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents
        "Medium model";
       parameter Real eps_h_is = 1e-10;
       Medium.ThermodynamicState state = Medium.setState_pTX(
                Medium.reference_p, Medium.reference_T, Medium.reference_X);
       Medium.DynamicViscosity eta =      Medium.dynamicViscosity(state);
       Medium.ThermalConductivity lambda= Medium.thermalConductivity(state);
       Medium.PrandtlNumber Pr = Medium.prandtlNumber(state);
       Medium.AbsolutePressure p = Medium.pressure(state);
       Medium.Temperature T = Medium.temperature(state);
       Medium.Density d = Medium.density(state);
       Medium.SpecificEnthalpy h = Medium.specificEnthalpy(state);
       Medium.SpecificEnergy u = Medium.specificInternalEnergy(state);
       Medium.SpecificEntropy s = Medium.specificEntropy(state);
       Medium.SpecificEnergy g = Medium.specificGibbsEnergy(state);
       Medium.SpecificEnergy f = Medium.specificHelmholtzEnergy(state);
       Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(state);
       Medium.SpecificHeatCapacity cp2=Medium.heatCapacity_cp(state);
       Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
       Medium.SpecificHeatCapacity cv2=Medium.heatCapacity_cv(state);
       Medium.SpecificEnthalpy h_is=Medium.isentropicEnthalpy(2*Medium.reference_p,state,exact=true);
        Medium.VelocityOfSound a=Medium.velocityOfSound(state);
       Medium.IsobaricExpansionCoefficient beta = Medium.isobaricExpansionCoefficient(state);
       Medium.IsobaricExpansionCoefficient beta2 = Medium.beta(state);
       SI.IsothermalCompressibility kappa = Medium.isothermalCompressibility(state);
       SI.IsothermalCompressibility kappa2 = Medium.kappa(state);
       Medium.DerDensityByPressure ddpT = Medium.density_derp_T(state);
       Medium.DerDensityByTemperature ddTp = Medium.density_derT_p(state);
       Medium.Density dddX[Medium.nX] = Medium.density_derX(state);
       Medium.MolarMass MM = Medium.molarMass(state);
       Medium.SpecificEnthalpy h2 = Medium.specificEnthalpy_pTX(
                            Medium.reference_p, Medium.reference_T, Medium.reference_X);
       Medium.Density d2 = Medium.density_pTX(
                            Medium.reference_p, Medium.reference_T, Medium.reference_X);
       Medium.ThermodynamicState state2 = Medium.setState_phX(
                Medium.reference_p, h, Medium.reference_X);
       Medium.ThermodynamicState state3 = Medium.setState_psX(
                Medium.reference_p, s, Medium.reference_X);
       Medium.ThermodynamicState state4 = if Medium.singleState then state else
                                       Medium.setState_dTX(d, T, Medium.reference_X);
       Medium.ThermodynamicState state5 = Medium.setSmoothState(0.1, state,state2,0.001);
       Medium.BaseProperties medium(preferredMediumStates=true,p(start=Medium.reference_p), T(start=Medium.reference_T), X(start=Medium.reference_X));
       Real err_T = abs(medium.T - T);
       Real err_d = abs(medium.d - d);
       Real err_u = abs(medium.u - u);

       // check isentropicEnthalpy
       Medium.ThermodynamicState state_h_is = Medium.setState_phX(2*Medium.reference_p, h_is, Medium.reference_X);
       Medium.SpecificEntropy s_is = Medium.specificEntropy(state_h_is);
       Real err_h_is = abs( s - s_is);
       constant Real eps=1e-9;
    equation
       medium.p=p;
       medium.h=h;
       medium.Xi=Medium.reference_X[1:Medium.nXi];

       // When iterating at the intial time the asserts below could be violated.
       // To avoid an error, the check is only performed at the end of the simulation.
       when terminal() then
          assert(err_T <= eps, "Error: abs(medium.T - T) > eps\n" +
                               "(err_T = " + String(err_T) + ", eps = " + String(eps) + ")");
       end when;

       when terminal() then
          assert(err_d <= eps, "Error: abs(medium.d - d) > eps" +
                               "(err_d = " + String(err_d) + ", eps = " + String(eps) + ")");
       end when;

       when terminal() then
          assert(err_u <= eps, "Error: abs(medium.u - u) > eps" +
                               "(err_u = " + String(err_u) + ", eps = " + String(eps) + ")");
       end when;

      // when terminal() then
          assert(err_h_is <= eps_h_is, "Error: entropy not constant for isentropicEnthalpy" +
                               "(err_h_is = " + String(err_h_is) + ", eps = " + String(eps_h_is) + ")");
       // end when;
    end FlueGasSixComponents;

    model ConstantPropertyLiquidWater
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater);
      annotation (experiment(StopTime=0.1), experimentSetupOutput);
    end ConstantPropertyLiquidWater;

    model SimpleAir
      extends Modelica.Icons.Example;
      extends PartialMediumFunctions(redeclare package Medium =
            Modelica.Media.Air.SimpleAir);
      annotation (experiment(StopTime=0.1), experimentSetupOutput);
    end SimpleAir;

    package IncompleteMedia
      extends Modelica.Icons.ExamplesPackage;
      model MoistAir
        extends PartialMediumFunctions(redeclare package Medium =
              Modelica.Media.Air.MoistAir);
      end MoistAir;

      model Glycol47
        extends PartialMediumFunctions(redeclare package Medium =
              Modelica.Media.Incompressible.Examples.Glycol47);
      end Glycol47;

      model WaterIF97_pT
        extends PartialMediumFunctions(redeclare package Medium =
             Modelica.Media.Water.WaterIF97_pT);
      end WaterIF97_pT;

      model WaterIF97_ph
        extends PartialMediumFunctions(redeclare package Medium =
             Modelica.Media.Water.WaterIF97_ph);
      end WaterIF97_ph;
    end IncompleteMedia;
  end TestAllProperties;
end Media;
