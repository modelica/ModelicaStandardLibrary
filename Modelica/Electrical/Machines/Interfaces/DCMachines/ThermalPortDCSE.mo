within Modelica.Electrical.Machines.Interfaces.DCMachines;
connector ThermalPortDCSE
  "Thermal port of DC machine with series excitation"
  extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortSeriesExcitation "Heat port of series excitation"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  annotation (Documentation(info="<html>
Thermal port for DC machine with serial excitation
</html>"));
end ThermalPortDCSE;
