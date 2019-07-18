within Modelica.Electrical.PowerConverters.Types;
type SoftStarterModeOfOperation = enumeration(
    Off "v = 0",
    Up "v = 0 -> 1",
    On "v = 1",
    Down "v = 1 -> 0")
  "Enumeration defining the internal mode of operation of the soft start controller";
