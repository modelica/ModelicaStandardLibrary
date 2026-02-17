within Modelica.Magnetic.FluxTubes.Types;
type Magnetization = enumeration(
  Roschke "Approximation formula according to Roschke",
  Macfadyen "Approximation formula according to Macfadyen et al",
  TableBased "Interpolation based on RawData table")
  "Enumeration defining the approximation of the magnetization characteristic";
