within Modelica.Blocks.Types;
type FilterType = enumeration(
    LowPass "Low pass filter",
    HighPass "High pass filter",
    BandPass "Band pass filter",
    BandStop "Band stop / notch filter")
  "Enumeration of analog filter types (low, high, band pass or band stop filter)"
  annotation (Evaluate=true);
