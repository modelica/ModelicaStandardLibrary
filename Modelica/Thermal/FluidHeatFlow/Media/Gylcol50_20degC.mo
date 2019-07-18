within Modelica.Thermal.FluidHeatFlow.Media;
record Gylcol50_20degC "Medium: properties of glycol:water 50:50 at 20 degC and 1 bar"
extends FluidHeatFlow.Media.Medium(
    rho=1078,
    cp=3300,
    cv=3300,
    lambda=0.405,
    nu=3.98E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of glycol:water 50:50 (anti-freeze -40&deg;C) at 20&deg;C and 1 bar
</html>"));
end Gylcol50_20degC;
