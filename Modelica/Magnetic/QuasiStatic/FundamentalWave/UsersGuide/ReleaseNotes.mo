within Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>

<h5>Version 3.2.3, 2019-01-23</h5>
<ul>
  <li>Fixed propagation of excitation leakage factor, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2403\">#2403</a></li>
  <li>Unified communication interval, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2279\">#2279</a></li>
  <li>Unified simulation tolerances, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2278\">#2278</a></li>
<li>Fixed wrong initial conditions of
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2277\">#2277</a></li>
<li>Added more examples from
    <a href=\"modelica://Modelica.Electrical.Machines.Examples\">Machines.Examples</a>, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2276\">#2276</a></li>
<li>Added
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle\">RotorDisplacementAngle</a>, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2050\">#2050</a></li>
</ul>

<h5>Version 3.2.2, 2015-02-02</h5>
<ul>
<li>Restructuring of components in Interfaces and BasesClasses</li>
<li>Migration of library to MSL trunk</li>
<li>Update and improvement of documentation</li>
<li>Added new component:
<ul>
    <li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Permeance\">Permeance</a></li>
</ul></li>
<li>Removed parameter text from icon layer for reluctance and permeance model</li>
<li>Fixed issues of ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1524\">#1524</a></li>
<li>Restructured cage models with reluctance instead of inductance model according to ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1537\">#1537</a></li>
<li>Bug fixes according to
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1226\">#1226</a></li>
<li>Added magnitude and argument of complex magnetic potentials, magnetic fluxes, voltages and currents in interface, electromagnetic coupling and machine models, see #1405</li>
<li>Added active, reactive and apparent power and power factor in interface and machine models, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
<li>Added new interface model
    <a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortExtended\">TwoPortExtended</a>
    to simplify consistent inclusion of variables, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
<li>Changed icon and location of terminal box according to
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1706\">#1706</a></li>
</ul>

<h5>Version 0.4.1, 2013-12-18</h5>
<ul>
<li>Renamed base magnetic port to MagneticPort</li>
<li>Bug fix of single-phase to polyphase converter</li>
<li>Bug fix of phase number propagation in SaliencyCageWinding fixed</li>
<li>Improved documentation of library</li>
<li>Added current controlled SMR example and indicated SMR inverter example as obsolete</li>
<li>Improved example of mains supplied SMPM with damper cage</li>
</ul>

<h5>Version 0.4.0, 2013-11-13</h5>
<ul>
<li>Renamed all machine class names according to
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1348\">#1348</a></li>
</ul>

<h5>Version 0.3.0, 2013-11-07</h5>
<ul>
<li>Renamed the library from QuasiStationaryFundamantalWave to QuasiStaticFundamantalWave according to
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1344\">#1344</a></li>
</ul>

<h5>Version 0.2.5, 2013-11-06</h5>
<ul>
<li>Changed implementation of symmetrical components: symmetricTransformationMatrix(m) is now
    multiplied by numberOfSymmetricBaseSystems(m) in order to overcome differences in calculation
    of current and voltage symmetrical components. The symmetrical components of a system of
    even phase numbers are now equal to the symmetrical components of one corresponding base system.</li>
<li>Improved examples package and removed SMPM_Inverter example</li>
</ul>

<h5>Version 0.2.4, 2013-10-02</h5>
<ul>
<li>Implemented induction machine with squirrel cage example with inverter</li>
<li>Alternative implementation of transformation matrix for faster compilation in Dymola</li>
</ul>

<h5>Version 0.2.3, 2013-09-25</h5>
<ul>
<li>Adapted sine / cosine of QS V/f-converter to match transient behavior</li>
</ul>

<h5>Version 0.2.2, 2013-09-24</h5>
<ul>
<li>Fixed initialization of examples (changed implementation of QuasiStatic.Sources, added start values for gamma, gammas, gammar)</li>
</ul>

<h5>Version 0.2.1, 2013-09-23</h5>
<ul>
<li>Implemented permanent magnet synchronous machine example with inverter</li>
</ul>

<h5>Version 0.2.0, 2013-09-01</h5>
<ul>
<li>Implemented induction machine with slip ring rotor including example</li>
<li>Implemented magnetic crossing</li>
</ul>

<h5>Version 0.1.0, 2013-08-27</h5>
<ul>
<li>Documentation of <a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide.Concept\">phasor concept</a></li>
<li>Connections.branch between electric and magnetic quasi-static connectors to handle open circuit and motor operation of machines</li>
<li>Saliency effects are properly considered</li>
<li>Electromagnetic coupling with Analog domain is implemented fully quasi-static with v = 0 at the electric connectors -- this may have to be changed in the future</li>
<li>Implemented machine types</li>
<li><ul>
<li>Induction machine with squirrel cage</li>
<li>Permanent magnet synchronous machine with optional damper cage</li>
<li>Electrical excited synchronous machine with optional damper cage (may be removed in first release)</li>
<li>Synchronous reluctance machine with optional damper cage (may be removed in first release)</li>
</ul></li>
</ul>
</html>"));
end ReleaseNotes;
