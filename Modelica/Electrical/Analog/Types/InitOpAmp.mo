within Modelica.Electrical.Analog.Types;
type InitOpAmp = enumeration(
    Linear "Initialization of firstOrder linearly dependent on input",
    UpperLimit "Initialization of firstOrder at positive supply",
    LowerLimit "Initialization of firstOrder at negative supply")
  "Enumeration defining initialization of the ImprovedOpAmpLimited" annotation (Evaluate=true);
