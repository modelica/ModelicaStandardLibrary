within Modelica.Media.IdealGases;
package MixtureGases "Medium models consisting of mixtures of ideal gases"
  extends Modelica.Icons.Library;

  package CombustionAir "Air as mixture of N2 and O2"
    extends Common.MixtureGasNasa(
      mediumName="CombustionAirN2O2",
      data={Common.SingleGasesData.N2,
     Common.SingleGasesData.O2},
      fluidConstants={Common.FluidData.N2,
        Common.FluidData.O2},
      substanceNames = {"Nitrogen", "Oxygen"},
      reference_X={0.768,0.232});
    annotation (Documentation(info="<html>

</html>"));
  end CombustionAir;

  package AirSteam "air and steam mixture (no condensation!, pseudo-mixture)"
    extends Common.MixtureGasNasa(
       mediumName="MoistAir",
       data={Common.SingleGasesData.H2O, Common.SingleGasesData.Air},
      fluidConstants={Common.FluidData.H2O,
        Common.FluidData.N2},
       substanceNames = {"Water","Air"},
       reference_X={0.0,1.0});
    annotation (Documentation(info="<html>

</html>"));
  end AirSteam;

  package simpleMoistAir = AirSteam(reference_X={0.03,0.97})
    "moist air without condensation";

  package FlueGasLambdaOnePlus
    "simple flue gas for over0stochiometric O2-fuel ratios"
    extends Common.MixtureGasNasa(
       mediumName="FlueGasLambda1plus",
       data={Common.SingleGasesData.N2,
      Common.SingleGasesData.O2,
      Common.SingleGasesData.H2O,
      Common.SingleGasesData.CO2},
       fluidConstants={Common.FluidData.N2,
         Common.FluidData.O2,
         Common.FluidData.H2O,
         Common.FluidData.CO2},
       substanceNames = {"Nitrogen","Oxygen","Water", "Carbondioxide"},
       reference_X={0.768,0.232,0.0,0.0});
    annotation (Documentation(info="<html>

</html>"));
  end FlueGasLambdaOnePlus;

  package FlueGasSixComponents
    "simplest flue gas for over-and understochiometric combustion of hydrocarbons"
    extends Common.MixtureGasNasa(
       mediumName="FlueGasSixComponents",
       data={Common.SingleGasesData.N2,
      Common.SingleGasesData.H2,
      Common.SingleGasesData.CO,
      Common.SingleGasesData.O2,
      Common.SingleGasesData.H2O,
      Common.SingleGasesData.CO2},
       fluidConstants={Common.FluidData.N2,
         Common.FluidData.H2,
         Common.FluidData.CO,
         Common.FluidData.O2,
         Common.FluidData.H2O,
         Common.FluidData.CO2},
       substanceNames = {"Nitrogen","Hydrogen,","Carbonmonoxide","Oxygen","Water","Carbondioxide"},
       reference_X={0.768,0.0,0.0,0.232,0.0,0.0});
    annotation (Documentation(info="<html>

</html>"));
  end FlueGasSixComponents;

  package SimpleNaturalGas "simple natural gas mix with 6 components"
    extends Common.MixtureGasNasa(
       mediumName="SimpleNaturalGas",
       data={Common.SingleGasesData.CH4,
      Common.SingleGasesData.C2H6,
      Common.SingleGasesData.C3H8,
      Common.SingleGasesData.C4H10_n_butane,
      Common.SingleGasesData.N2,
      Common.SingleGasesData.CO2},
       fluidConstants={Common.FluidData.CH4,
         Common.FluidData.C2H6,
         Common.FluidData.C3H8,
         Common.FluidData.C4H10_n_butane,
         Common.FluidData.N2,
         Common.FluidData.CO2},
       substanceNames = {"Methane","Ethane","Propane","N-Butane,","Nitrogen","Carbondioxide"},
       reference_X={0.92,0.048,0.005,0.002,0.015,0.01});
    annotation (Documentation(info="<html>

</html>"));
  end SimpleNaturalGas;

  package SimpleNaturalGasFixedComposition
    "Same as SimpleNaturalGas but with fixed composition"
  extends SimpleNaturalGas(fixedX=true);
    annotation (Documentation(info="<html>

</html>"));
  end SimpleNaturalGasFixedComposition;
  annotation (Documentation(info="<html>

</html>"));
end MixtureGases;
