within Modelica.Electrical.Machines.Interfaces.DCMachines;
connector ThermalPortDCCE
  "Thermal port of DC machine with compound excitation"
  extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortShuntExcitation "Heat port of (shunt) excitation"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortSeriesExcitation "Heat port of series excitation"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  annotation (Documentation(info="<html>
Thermal port for DC machine with compound excitation
</html>"));
end ThermalPortDCCE;
