within Modelica.Thermal.FluidHeatFlow.Media;
record MineralOil "Medium: properties of mineral oil at 60 degC and 1 bar"
extends FluidHeatFlow.Media.Medium(
    rho=868,
    cp=2010,
    cv=2010,
    lambda=0.14,
    nu=81.8E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of mineral oil at 60&deg;C and 1 bar
</html>"));
end MineralOil;
