within Modelica;
package ComplexSIunits
  "Library of complex type and unit definitions based on SI units according to ISO 31-1992"
  extends Modelica.Icons.Library;

  record Voltage = Complex(redeclare Modelica.SIunits.Voltage re,
                           redeclare Modelica.SIunits.Voltage im)
    "Complex electrical potential difference";

  record Current = Complex(redeclare Modelica.SIunits.Current re,
                           redeclare Modelica.SIunits.Current im)
    "Complex electrical current";

  annotation (Icon(graphics));
end ComplexSIunits;
