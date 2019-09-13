within Modelica.Thermal.FluidHeatFlow.Media;
record Medium "Record containing media properties"
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.Density rho = 1 "Density";
  parameter Modelica.SIunits.SpecificHeatCapacity cp = 1
    "Specific heat capacity at constant pressure";
  parameter Modelica.SIunits.SpecificHeatCapacity cv = 1
    "Specific heat capacity at constant volume";
  parameter Modelica.SIunits.ThermalConductivity lambda = 1
    "Thermal conductivity";
  parameter Modelica.SIunits.KinematicViscosity nu = 1
    "Kinematic viscosity";
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
Record containing (constant) medium properties.
</html>"));
end Medium;
