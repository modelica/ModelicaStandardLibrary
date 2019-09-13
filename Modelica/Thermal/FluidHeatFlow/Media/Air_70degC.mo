within Modelica.Thermal.FluidHeatFlow.Media;
record Air_70degC "Medium: properties of air at 70 degC and 1 bar"
extends FluidHeatFlow.Media.Medium(
    rho=1.015,
    cp=1010,
    cv=723,
    lambda=0.0293,
    nu=20.3E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of air at 70&deg;C and 1 bar
</html>"));
end Air_70degC;
