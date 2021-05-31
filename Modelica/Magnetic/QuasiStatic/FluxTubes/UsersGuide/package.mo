within Modelica.Magnetic.QuasiStatic.FluxTubes;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>The quasi-static flux tubes library is based on the transient library
<a href=\"modelica://Modelica.Magnetic.FluxTubes\">Magnetic.FluxTubes</a>. The main principles of confined flux and flux tubes apply, too. The quasi-static flux tubes library contains components for modelling of electromagnetic devices with lumped magnetic networks based on quasi-static theory. Models based on this library are suited for quasi-static simulation of transformers at component and system level.</p>
<p>The quasi-static components of this library do not consider saturation since <strong>linearity</strong> is strictly assumed. In case that the permeability of a saturated circuit needs to be considered, a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.Transient.FundamentalWavePermabilitySensor\">transient permeability estimation sensor</a> is provided do determine the effective permeability from a transient simulation.
</p>

<p>
A general introduction into <strong>quasi-static</strong> phasor can be found in
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview\">Modelica.Electrical.QuasiStatic</a>.
</p>

<p>
This user's guide gives a short introduction to the underlying
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.UsersGuide.FluxTubeConcept\">concept</a> of quasi-static magnetic flux tubes, summarizes basic relationships and equations.
</p>
</html>"));
end UsersGuide;
