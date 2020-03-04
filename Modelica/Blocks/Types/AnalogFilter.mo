within Modelica.Blocks.Types;
type AnalogFilter = enumeration(
    CriticalDamping "Filter with critical damping",
    Bessel "Bessel filter",
    Butterworth "Butterworth filter",
    ChebyshevI "Chebyshev I filter")
  "Enumeration defining the method of filtering" annotation (Evaluate=true);
