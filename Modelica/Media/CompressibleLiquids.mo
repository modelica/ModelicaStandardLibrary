package CompressibleLiquids "compressible liquid models" 
  package LinearColdWater 
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
      MM_const=0.01801);
    
  redeclare function extends dynamicViscosity "Dynamic viscosity of water" 
  algorithm 
    eta := 0.15;
  end dynamicViscosity;
    
  redeclare function extends thermalConductivity 
      "Thermal conductivity of water" 
  algorithm 
    lambda := 0.1;
  end thermalConductivity;
    
  end LinearColdWater;
  
  partial package LinearWater_pT 
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
  
  package LinearWater_pT_Ambient 
    extends LinearWater_pT(reference_p = 101325, reference_T = 298.15);
  end LinearWater_pT_Ambient;
  
  package Test "some tests" 
    model Properties 
      package Medium = LinearWater_pT_Ambient;
      parameter Medium.ThermodynamicState state(p = 1.0e5, T = 300.0);
      Real a = Medium.velocityOfSound(state);
      Real gamma = Medium.isentropicExponent(state);
      Real s = Medium.specificEntropy(state);
    equation 
      
    end Properties;
  end Test;
end CompressibleLiquids;
