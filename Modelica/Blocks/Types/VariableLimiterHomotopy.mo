within Modelica.Blocks.Types;
type VariableLimiterHomotopy = enumeration(
    NoHomotopy "Simplified model = actual model",
    Linear "Simplified model: y = u",
    Fixed "Simplified model: y = ySimplified")
  "Enumeration defining use of homotopy in variable limiter components" annotation (Evaluate=true);
