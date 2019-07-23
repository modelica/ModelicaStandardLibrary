within Modelica.Thermal.FluidHeatFlow.Media;
record Air_30degC "Medium: properties of air at 30 degC and 1 bar"
extends FluidHeatFlow.Media.Medium(
    rho=1.149,
    cp=1007,
    cv=720,
    lambda=0.0264,
    nu=16.3E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of air at 30&deg;C and 1 bar
</html>"));
end Air_30degC;
