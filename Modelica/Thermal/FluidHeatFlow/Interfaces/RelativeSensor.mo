within Modelica.Thermal.FluidHeatFlow.Interfaces;
partial model RelativeSensor "Partial model of relative sensor"
  extends RelativeSensorBase;
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
annotation (Documentation(info="<html>
<p>Partial model for a relative sensor (pressure drop/temperature difference).</p>
<p>Pressure, mass flow, temperature and enthalpy flow of medium are not affected.</p>
</html>"));
end RelativeSensor;
