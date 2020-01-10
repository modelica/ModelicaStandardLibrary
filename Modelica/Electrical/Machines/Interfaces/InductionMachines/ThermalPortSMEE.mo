within Modelica.Electrical.Machines.Interfaces.InductionMachines;
connector ThermalPortSMEE
  "Thermal port of synchronous machine with electrical excitation"
  extends
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
  parameter Boolean useDamperCage(start=true)
    "Enable / disable damper cage" annotation (Evaluate=true);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortRotorWinding if useDamperCage
    "Heat port of damper cage (optional)"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortExcitation
    "Heat port of excitation"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortBrush
    "Heat port of (optional) brush losses"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  annotation (Documentation(info="<html>
Thermal port for synchronous machine with electrical excitation
</html>"));
end ThermalPortSMEE;
