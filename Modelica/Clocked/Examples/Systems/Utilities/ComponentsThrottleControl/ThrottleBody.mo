within Modelica.Clocked.Examples.Systems.Utilities.ComponentsThrottleControl;
block ThrottleBody "Basic throttle body equations"
  extends Modelica.Blocks.Icons.Block;

parameter Modelica.Units.NonSI.Pressure_bar P_0 = 1 "Atmospheric pressure (bar)";
protected
  Real m_ai(start=0, fixed=true, unit="g") "Mass";
  Modelica.Units.NonSI.Angle_deg f_Theta "Auxiliary variable";
  Real g_Pm "Auxiliary variable";
public
  Modelica.Blocks.Interfaces.RealInput Theta(unit="deg") "Throttle angle (deg)"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput Pm(unit="bar")
    "Intake manifold pressure (bar)"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput m_ai_der(unit="g/s")
    "Mass flow rate of air into manifold (g/s)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

protected
  Real tmp1;
  Real tmp2;
  Real pratio;
  Real gpratio;
equation

der(m_ai) = f_Theta * g_Pm;
f_Theta = 2.821 - 0.05231*Theta + 0.10299*Theta^2 - 0.00063*Theta^3; // different to paper 0.0063*Theta^3
// Note: If the flow direction changes, i.e. Pm>P_0 the logic will fail since sqrt(-x)
tmp1 = Pm / P_0;
tmp2 = P_0 / Pm;
pratio = min(tmp1, tmp2);
gpratio = if pratio >= 0.5 then 2*sqrt(pratio - pratio^2) else 1;
g_Pm = sign(P_0 - Pm) * gpratio;
/*
g_Pm = if Pm <= P_0/2 then 1.0 else 2/P_0*sqrt(Pm*P_0 - Pm^2);
*/
m_ai_der = der(m_ai);
end ThrottleBody;
