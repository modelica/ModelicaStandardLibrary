within ModelicaTest.Fluid;
package TestExamplesVariants
  "Test alternative configurations proposed in the documentation of Modelica.Fluid.Examples"
  extends Modelica.Icons.ExamplesPackage;

  model HeatingSystem_FixedInitial = Modelica.Fluid.Examples.HeatingSystem (
    system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial))
    "Alternative case for HeatingSystem with fixed initial states"
    annotation(experiment(StopTime=6000),
      __Dymola_Commands(file(ensureSimulated=true)=
          "modelica://Modelica/Resources/Scripts/Dymola/Fluid/HeatingSystem/plotResults.mos"
        "plotResults"));

  model HeatingSystem_SteadyState = Modelica.Fluid.Examples.HeatingSystem (
    system(energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState))
    "Alternative case for HeatingSystem as steady state model"
    annotation(experiment(StopTime=6000),
      __Dymola_Commands(file(ensureSimulated=true)=
          "modelica://Modelica/Resources/Scripts/Dymola/Fluid/HeatingSystem/plotResults.mos"
        "plotResults"));

end TestExamplesVariants;
