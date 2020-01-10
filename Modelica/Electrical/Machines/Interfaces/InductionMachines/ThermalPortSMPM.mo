within Modelica.Electrical.Machines.Interfaces.InductionMachines;
connector ThermalPortSMPM
  "Thermal port of synchronous machine with permanent magnets"
  extends
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
  parameter Boolean useDamperCage(start=true)
    "Enable / disable damper cage" annotation (Evaluate=true);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortRotorWinding if useDamperCage
    "Heat port of damper cage (optional)"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortPermanentMagnet "Heat port of permanent magnets"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  annotation (Documentation(info="<html>
Thermal port for synchronous machine with permanent magnets
</html>"));
end ThermalPortSMPM;
