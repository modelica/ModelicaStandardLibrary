within ModelicaTest.Fluid.TestComponents.Fittings;
model TestPressureLossDerivatives
  "Test that PressureLoss components can be differentiated"
  import Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent;
  extends Modelica.Icons.Example;
  parameter SI.Diameter diameter_a = 0.1 "Inner diameter of pipe at port_a";
  parameter SI.Diameter diameter_b = 0.2 "Inner diameter of pipe at port_b";
  parameter QuadraticTurbulent.LossFactorData data=
                  QuadraticTurbulent.LossFactorData.suddenExpansion(diameter_a, diameter_b)
    "Loss factors for both flow directions";
  parameter SI.Pressure dp_small = 0.1;

  SI.Density rho_a;
  SI.Density rho_b;
  SI.DynamicViscosity mu_a;
  SI.DynamicViscosity mu_b;
  SI.Pressure dp;
  SI.MassFlowRate m_flow1;
  SI.MassFlowRate m_flow2;
  Real der_m_flow1;
protected
  constant Real t2p=1 "dummy unit constant";
  constant Real t2d=1 "dummy unit constant";
  constant Real d2mu=1 "dummy unit constant";

equation
  dp = t2p*time - 1;
  rho_a = 0.1 + t2d*time;
  rho_b = 0.2 + 0.5*t2d*time;
  mu_a = 0.1*d2mu*rho_a;
  mu_b = 0.4*d2mu*rho_b;

  m_flow1 = QuadraticTurbulent.massFlowRate_dp(dp, rho_a, rho_b, data, dp_small);
  m_flow2 = QuadraticTurbulent.massFlowRate_dp_and_Re(dp, rho_a, rho_b, mu_a, mu_b, data);

  der_m_flow1 = der(m_flow1);
  // der_m_flow2 = der(m_flow2);
  annotation (experiment(StopTime=3), experimentSetupOutput,
    Documentation(info="<html>

</html>"));
end TestPressureLossDerivatives;
