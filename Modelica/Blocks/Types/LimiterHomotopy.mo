within Modelica.Blocks.Types;
type LimiterHomotopy = enumeration(
    NoHomotopy "Homotopy is not used",
    Linear "Simplified model without limits",
    UpperLimit "Simplified model fixed at upper limit",
    LowerLimit "Simplified model fixed at lower limit")
  "Enumeration defining use of homotopy in limiter components" annotation (Evaluate=true);
