within Modelica.Thermal.FluidHeatFlow.Media;
record Water_90degC "Medium: properties of water at 90 degC and 1 bar"
extends FluidHeatFlow.Media.Medium(
    rho=965.3,
    cp=4205,
    cv=4205,
    lambda=0.676,
    nu=0.347E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of water at 90&deg;C and 1 bar
</html>"));
end Water_90degC;
