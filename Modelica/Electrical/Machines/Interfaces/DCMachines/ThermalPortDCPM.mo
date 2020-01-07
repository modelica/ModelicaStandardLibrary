within Modelica.Electrical.Machines.Interfaces.DCMachines;
connector ThermalPortDCPM
  "Thermal port of DC machine with permanent magnets"
  extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortPermanentMagnet "Heat port of permanent magnets"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  annotation (Documentation(info="<html>
Thermal port for DC machine with permanent magnets
</html>"));
end ThermalPortDCPM;
