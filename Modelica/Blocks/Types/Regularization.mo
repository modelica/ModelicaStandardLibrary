within Modelica.Blocks.Types;
type Regularization = enumeration(
    Exp "Exponential regularization (smooth)",
    Sine "Sinusoidal regularization (smooth 1st derivative)",
    Linear "Linear regularization",
    Cosine "Cosine regularization")
  "Enumeration defining the regularization around zero";
