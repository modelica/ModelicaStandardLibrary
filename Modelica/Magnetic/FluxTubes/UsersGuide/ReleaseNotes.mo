within Modelica.Magnetic.FluxTubes.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>

<h5>Version 3.2.2, 2014-12-05 (Johannes&nbsp;Ziske, Thomas&nbsp;B&ouml;drich)</h5>

<ul>
<li>Added package <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">FluxTubes.UsersGuide.Hysteresis</a></li>
<li>Added package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis\">FluxTubes.Examples.Hysteresis</a></li>
<li>Added package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">FluxTubes.Shapes.HysteresisAndMagnets</a></li>
<li>Added package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a></li>
<li>Added package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisTableData\">FluxTubes.Material.HysteresisTableData</a></li>
<li>Updated <a href=\"modelica://Modelica.Magnetic.FluxTubes.BaseClasses.FixedShape\">FluxTubes.BaseClasses.FixedShape</a> for differentiability</li>
<li>Updated <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">FluxTubes.UsersGuide.Literature</a></li>
</ul>

<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>

<ul>
<li>Added constant
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance\">permeance model</a></li>
<li>Added
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube\">GenericFluxTube</a></li>
<li>Added parameter <code>useConductance</code> including alternative parameterization in
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">EddyCurrent</a></li>
<li>Added
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.Idle\">Idle</a></li>
<li>Added
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.Short\">Short</a></li>
<li>Added
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.Crossing\">Crossing</a></li>
</ul>

<h5>Version 1.5, 2013-01-04 (Martin&nbsp;Otter, Thomas&nbsp;B&ouml;drich, Johannes&nbsp;Ziske)</h5>
<ul>
<li>Added missing initial conditions</li>
<li>Fixed initial parameter values</li>
</ul>

<h5>Version 1.4, 2011-08-01 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>MagneticPort declared with MagneticPotential instead of MagneticPotentialDifference</li>
</ul>

<h5>Version 1.3, 2010-04-22 (Christian&nbsp;Kral)</h5>
<ul>
<li>Added conditional heat port to EddyCurrent model</li>
</ul>

<h5>Version 1.2, 2009-08-11 (Christian&nbsp;Kral, Anton&nbsp;Haumer, Thomas&nbsp;B&ouml;drich, Martin&nbsp;Otter)</h5>
<ul>
<li>Update and improvement for inclusion in the
    Modelica Standard Library</li>
</ul>

<h5>Version 1.1, 2009-05-19 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>Coupling coefficient in Basic.ElectroMagneticConverter removed</li>
<li>Basic.EddyCurrent added</li>
<li>Example MovingCoilActuator, especially PermeanceModel, completely revised</li>
<li>Leakage coefficient replaced by coupling coefficient in Basic.LeakageWithCoefficient</li>
<li>Utilities.CoilDesign: parameter U renamed to V_op,CoilDesign moved to Utilities.</li>
<li>Reference direction for magnetic flux added in all sources</li>
<li>degC replaced by K for compatibility with Modelica 3.0</li>
<li>redeclare in Sensors for compatibility with Modelica 3.0 removed</li>
<li>Partial flux tube components moved to Interfaces and basic elements moved to new package Basic</li>
</ul>

<h5>Version 1,0, 2007-10-11 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>Release of version 1.0 of the library</li>
</ul>

<h5>2005 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>First release of a Modelica magnetic library</li>
</ul>

</html>"));
end ReleaseNotes;
