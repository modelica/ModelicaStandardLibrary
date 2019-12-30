within Modelica.Electrical.Machines.Interfaces.InductionMachines;
connector ThermalPortIMC
  "Thermal port of induction machine with squirrel cage"
  extends
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortRotorWinding "Heat port of rotor (squirrel cage)"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  annotation (Documentation(info="<html>
Thermal port for induction machine with squirrel cage
</html>"));
end ThermalPortIMC;
