within Modelica.Thermal.FluidHeatFlow.Media;
record Water_10degC "Medium: properties of water at 10 degC and 1 bar"
extends FluidHeatFlow.Media.Medium(
    rho=999.7,
    cp=4192,
    cv=4192,
    lambda=0.588,
    nu=1.307E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of water at 10&deg;C and 1 bar
</html>"));
end Water_10degC;
