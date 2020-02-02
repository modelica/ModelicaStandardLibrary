within Modelica.Electrical.Machines.Interfaces.InductionMachines;
connector ThermalPortIMS
  "Thermal port of induction machine with slipring"
  extends
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
  parameter Integer mr=m "Number of rotor phases" annotation(Evaluate=true);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortRotorWinding[mr] "Heat port of rotor windings"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortBrush
    "Heat port of (optional) brush losses"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  annotation (Documentation(info="<html>
Thermal port for induction machine with slipring rotor
</html>"));
end ThermalPortIMS;
