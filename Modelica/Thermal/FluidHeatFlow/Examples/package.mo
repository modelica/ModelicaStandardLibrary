within Modelica.Thermal.FluidHeatFlow;
package Examples "Examples that demonstrate the usage of the FluidHeatFlow components"
  extends Modelica.Icons.ExamplesPackage;
  annotation (Documentation(info="<html>
<p>This package contains test examples:</p>

<ol>
<li>SimpleCooling: Heat is dissipated through a media flow</li>
<li>ParallelCooling: Two heat sources dissipate through merged media flows</li>
<li>IndirectCooling: Heat is dissipated through two cooling cycles</li>
<li>PumpAndValve: Demonstrate the usage of an IdealPump and a Valve</li>
<li>PumpDropOut: Demonstrate shutdown and restart of a pump</li>
<li>ParallelPumpDropOut: Demonstrate the shutdown and restart of a pump in a parallel circuit</li>
<li>OneMass: Cooling of a mass (thermal capacity) by a coolant flow</li>
<li>TwoMass: Cooling of two masses (thermal capacities) by two parallel coolant flows</li>
<li>WaterPump: Water pumping station</li>
<li>TestOpenTank: Test the <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Components.OpenTank\">OpenTank</a> model</li>
<li>TwoTanks: Two connected open tanks</li>
<li>TestCylinder: Test the <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Components.Cylinder\">Cylinder</a> model</li>
</ol>

</html>"));
end Examples;
