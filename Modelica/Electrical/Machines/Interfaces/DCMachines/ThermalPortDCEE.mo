within Modelica.Electrical.Machines.Interfaces.DCMachines;
connector ThermalPortDCEE
  "Thermal port of DC machine with electrical excitation"
  extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortExcitation
    "Heat port of (shunt) excitation"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  annotation (Documentation(info="<html>
Thermal port for DC machine with electrical (shunt) excitation
</html>"));
end ThermalPortDCEE;
