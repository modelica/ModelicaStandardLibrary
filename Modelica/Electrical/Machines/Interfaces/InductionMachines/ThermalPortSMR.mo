within Modelica.Electrical.Machines.Interfaces.InductionMachines;
connector ThermalPortSMR
  "Thermal port of synchronous machine with reluctance rotor"
  extends
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
  parameter Boolean useDamperCage(start=true)
    "Enable / disable damper cage" annotation (Evaluate=true);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortRotorWinding if useDamperCage
    "Heat port of damper cage (optional)"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  annotation (Documentation(info="<html>
Thermal port for synchronous machine with reluctance rotor
</html>"));
end ThermalPortSMR;
