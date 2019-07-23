within Modelica.Thermal.FluidHeatFlow.Media;
record Water "Medium: properties of water at 30 degC and 1 bar"
extends FluidHeatFlow.Media.Medium(
    rho=995.6,
    cp=4177,
    cv=4177,
    lambda=0.615,
    nu=0.8E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of water at 30&deg;C and 1 bar
</html>"));
end Water;
