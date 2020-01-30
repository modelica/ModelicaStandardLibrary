within Modelica.Thermal.FluidHeatFlow.Media;
record Medium "Record containing media properties"
  extends Modelica.Icons.Record;
  parameter SI.Density rho = 1 "Density";
  parameter SI.SpecificHeatCapacity cp = 1
    "Specific heat capacity at constant pressure";
  parameter SI.SpecificHeatCapacity cv = 1
    "Specific heat capacity at constant volume";
  parameter SI.ThermalConductivity lambda = 1
    "Thermal conductivity";
  parameter SI.KinematicViscosity nu = 1
    "Kinematic viscosity";
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
Record containing (constant) medium properties.
</html>"));
end Medium;
