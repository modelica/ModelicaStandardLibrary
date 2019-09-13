within Modelica.Thermal.FluidHeatFlow.Media;
record Gylcol20_20degC "Medium: properties of glycol:water 20:80 at 20 degC and 1 bar"
extends FluidHeatFlow.Media.Medium(
    rho=1028,
    cp=3910,
    cv=3910,
    lambda=0.523,
    nu=1.69E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of glycol:water 20:80 (anti-freeze -8&deg;C) at 20&deg; and 1 bar
</html>"));
end Gylcol20_20degC;
