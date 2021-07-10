within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
type FilterType = enumeration(
    FirstOrder "First order filter",
    Mean "Calculate mean over a switching period",
    Sampler "Sample current at the right instant")
  "Enumeration defining the filter type for measured voltages and currents";
