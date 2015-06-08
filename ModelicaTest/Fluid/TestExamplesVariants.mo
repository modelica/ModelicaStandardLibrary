within ModelicaTest.Fluid;
package TestExamplesVariants
  "Test alternative configurations proposed in the documentation of Modelica.Fluid.Examples"
  extends Modelica.Icons.ExamplesPackage;

  model HeatingSystem_FixedInitial = Modelica.Fluid.Examples.HeatingSystem (
    system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial))
    "Alternative case for HeatingSystem with fixed initial states"
    annotation(experiment(StopTime=6000));

  model HeatingSystem_SteadyState = Modelica.Fluid.Examples.HeatingSystem (
    system(energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState))
    "Alternative case for HeatingSystem as steady state model"
    annotation(experiment(StopTime=6000));

  model IncompressibleFluidNetwork_StandardWaterOnePhase =
      Modelica.Fluid.Examples.IncompressibleFluidNetwork (
    redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase)
    "Alternative case for IncompressibleFluidNetwork using WaterIF97 medium"
    annotation(experiment(StopTime=200));

  model BranchingDynamicPipes_MomentumSteadyState =
    Modelica.Fluid.Examples.BranchingDynamicPipes (
      system(momentumDynamics =  Modelica.Fluid.Types.Dynamics.SteadyState))
    "Alternative case for BranchingDynamicPipes using steady-state momentum balance"
  annotation(experiment(StopTime=10));

  model BranchingDynamicPipes_StandardWater =
    Modelica.Fluid.Examples.BranchingDynamicPipes (
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    "Alternative case for BranchingDynamicPipes using StandardWater medium"
  annotation(experiment(
      StopTime=10,
      Interval=0.002,
      Tolerance=1e-006));

  model InverseParameterization_turbulent =
    Modelica.Fluid.Examples.InverseParameterization (
      eps_m_flow_turbulent=0)
    "Alternative case for InverseParameterization using eps_m_flow_turbulent=0"
  annotation(experiment(StopTime=10, Interval=0.001));

  model InverseParameterization_laminar =
    Modelica.Fluid.Examples.InverseParameterization (
      eps_m_flow_turbulent=1)
    "Alternative case for InverseParameterization using eps_m_flow_turbulent=1"
  annotation(experiment(StopTime=10, Interval=0.001));

end TestExamplesVariants;
