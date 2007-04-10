package TestMixtureViscosity 
  model testAir 
    package Medium = Modelica.Media.IdealGases.MixtureGases.CombustionAir;
    Medium.BaseProperties pro;
    Real eta;
    Real lambda;
  equation 
    pro.T = 300.0;
    pro.p = 1.0e5;
    pro.X[1] = 0.78;
    eta = Medium.dynamicViscosity(pro.state);
    lambda = Medium.thermalConductivity(pro.state);
  end testAir;
  
  model testSingleComp 
    package Medium = Modelica.Media.IdealGases.SingleGases.N2;
    Medium.BaseProperties pro;
    Real eta;
    Real lambda;
  equation 
    pro.T = 300.0;
    pro.p = 1.0e5;
    eta = Medium.dynamicViscosity(pro.state);
    lambda = Medium.thermalConductivity(pro.state);
  end testSingleComp;
end TestMixtureViscosity;
