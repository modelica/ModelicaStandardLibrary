within Modelica.Thermal.FluidHeatFlow.Interfaces;
connector FlowPort "Connector flow port"

  parameter FluidHeatFlow.Media.Medium medium "Medium in the connector";
  Modelica.SIunits.Pressure p;
  flow Modelica.SIunits.MassFlowRate m_flow;
  Modelica.SIunits.SpecificEnthalpy h;
  flow Modelica.SIunits.EnthalpyFlowRate H_flow;
annotation (Documentation(info="<html>
Basic definition of the connector.<br>
<strong>Variables:</strong>
<ul>
<li>Pressure p</li>
<li>flow MassFlowRate m_flow</li>
<li>Specific Enthalpy h</li>
<li>flow EnthaplyFlowRate H_flow</li>
</ul>
If ports with different media are connected, the simulation is asserted due to the check of parameter.
</html>"));
end FlowPort;
