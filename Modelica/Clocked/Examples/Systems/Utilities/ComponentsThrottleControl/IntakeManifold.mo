within Modelica.Clocked.Examples.Systems.Utilities.ComponentsThrottleControl;
block IntakeManifold "Dynamics of the intake manifold"
  extends Modelica.Blocks.Icons.Block;

  parameter Real RTVmRatio = 0.41328
    "RT/V_m";
  parameter Modelica.Units.NonSI.Pressure_bar P_0 = 0.543
    "Initial value for P_m, (bar)";
  Modelica.Blocks.Interfaces.RealInput m_ai_der(unit="g/s")
    "Mass flow rate of air into manifold (g/s)"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput N(unit="rad/s") "Engine speed (rad/sec)"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput m_ao_der(unit="g/s")
    "Mass flow rate of air out of manifold (g/s)"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput P_m(start=P_0, fixed=true, unit="bar")
    "Intake manifold pressure (bar)"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  der(P_m) = RTVmRatio*(m_ai_der - m_ao_der);
  m_ao_der = -0.366 + 0.08979*N*P_m - 0.0337*N*P_m^2 + 0.0001*N^2*P_m;
end IntakeManifold;
