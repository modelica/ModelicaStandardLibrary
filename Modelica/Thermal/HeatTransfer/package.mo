within Modelica.Thermal;
package HeatTransfer "Library of 1-dimensional heat transfer with lumped elements"
  extends Modelica.Icons.Package;

  annotation (
     Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
      Polygon(
        origin = {13.758,27.517},
        lineColor = {128,128,128},
        fillColor = {192,192,192},
        fillPattern = FillPattern.Solid,
        points = {{-54,-6},{-61,-7},{-75,-15},{-79,-24},{-80,-34},{-78,-42},{-73,-49},{-64,-51},{-57,-51},{-47,-50},{-41,-43},{-38,-35},{-40,-27},{-40,-20},{-42,-13},{-47,-7},{-54,-5},{-54,-6}}),
    Polygon(
        origin = {13.758,27.517},
        fillColor = {160,160,164},
        fillPattern = FillPattern.Solid,
        points = {{-75,-15},{-79,-25},{-80,-34},{-78,-42},{-72,-49},{-64,-51},{-57,-51},{-47,-50},{-57,-47},{-65,-45},{-71,-40},{-74,-33},{-76,-23},{-75,-15},{-75,-15}}),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {160,160,164},
        fillColor = {192,192,192},
        fillPattern = FillPattern.Solid,
        points = {{39,-6},{32,-7},{18,-15},{14,-24},{13,-34},{15,-42},{20,-49},{29,-51},{36,-51},{46,-50},{52,-43},{55,-35},{53,-27},{53,-20},{51,-13},{46,-7},{39,-5},{39,-6}}),
      Polygon(
        origin = {13.758,27.517},
        fillColor = {160,160,164},
        fillPattern = FillPattern.Solid,
        points = {{18,-15},{14,-25},{13,-34},{15,-42},{21,-49},{29,-51},{36,-51},{46,-50},{36,-47},{28,-45},{22,-40},{19,-33},{17,-23},{18,-15},{18,-15}}),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {191,0,0},
        fillColor = {191,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-9,-23},{-9,-10},{18,-17},{-9,-23}}),
      Line(
        origin = {13.758,27.517},
        points = {{-41,-17},{-9,-17}},
        color = {191,0,0},
        thickness = 0.5),
      Line(
        origin = {13.758,27.517},
        points = {{-17,-40},{15,-40}},
        color = {191,0,0},
        thickness = 0.5),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {191,0,0},
        fillColor = {191,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-17,-46},{-17,-34},{-40,-40},{-17,-46}})}),
                            Documentation(info="<html>
<p>
This package contains components to model <strong>1-dimensional heat transfer</strong>
with lumped elements.</p>
</html>", revisions="<html>
<ul>
<li><em>July 15, 2002</em>
       by Michael Tiller, <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Nikolaus Sch&uuml;rmann:<br>
       Implemented.
</li>
<li><em>June 13, 2005</em>
       by <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
       Refined placing of connectors (cosmetic).<br>
       Refined all Examples; removed Examples.FrequencyInverter, introducing Examples.Motor<br>
       Introduced temperature dependent correction (1 + alpha*(T - T_ref)) in Fixed/PrescribedHeatFlow<br>
</li>
  <li> v1.1.1 2007/11/13 Anton Haumer<br>
       components moved to sub-packages</li>
  <li> v1.2.0 2009/08/26 Anton Haumer<br>
       added component ThermalCollector</li>

</ul>
</html>"));
end HeatTransfer;
