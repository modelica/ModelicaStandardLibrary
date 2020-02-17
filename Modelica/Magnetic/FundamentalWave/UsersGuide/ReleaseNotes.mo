within Modelica.Magnetic.FundamentalWave.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>

<h5>Version 3.2.3, 2019-01-23</h5>

<ul>
  <li>Fixed propagation of excitation leakage factor, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2403\">#2403</a></li>
  <li>Added model of electrical excited synchronous machines, starting direct on line, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2388\">#2388</a></li>
  <li>Unified communication interval, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2279\">#2279</a></li>
  <li>Unified simulation tolerances, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2278\">#2278</a></li>
<li>Added more examples from
    <a href=\"modelica://Modelica.Electrical.Machines.Examples\">Machines.Examples</a>, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2276\">#2276</a></li>
<li>Replace wrong permeance image in documentation according to
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2208\">#2208</a></li>
<li>Added obsolete annotation to SymmetricMultiPhaseCageWinding_obsolete and SaliencyCageWinding_obsolete,
    see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1536\">#1536</a></li>
<li>Updated documentation of
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>,
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Idle</a> and
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.PermanentMagnet\">PermanentMagnet</a>
    </li>
<li>Added new components:
<ul>
    <li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Crossing</a></li>
    <li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Permeance\">Permeance</a></li>
</ul></li>
<li>Removed parameter text from icon layer for reluctance and permeance model</li>
<li>Restructured cage models with reluctance instead of inductance model according to ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1536\">#1536</a>;
the re-structuring of the model required to change the initial conditions of the included examples, since the number of rotor states is reduced by new implementation</li>
<li>Some more bug fixes according to
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1226\">#1226</a>,
since not all reference orientations have been correct</li>
<li>Added variables for magnitude and argument of complex magnetic potential difference and flux, see
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
</ul>

<h5>Version 3.2.1, 2013-07-31</h5>

<ul>
<li>Bug fix of wrong orientation of squirrel and damper cage models, see ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1226\">#1226</a>;
this also includes the removal of the rotor cage heat sensor which previously has been used</li>
<li>Bug fix of conditional initialization of examples, see ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1223\">#1223</a></li>
<li>Fixed missing default parameter TpmOperational in ambient of PM synchronous machine, see ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1216\">#1216</a>#1216</li>
<li>Added voltages, currents, complex flux and magnetic potential difference as global variables in
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">polyphase converter</a></li>
<li>Added two more component examples, showing the equivalent nature of electrical and magnetic domain</li>
</ul>

<h5>Version 2.0.0, 2013-03-10</h5>

<ul>
<li>Corrected wrong parameter descriptions, see ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1003\">#1003</a></li>
<li>Extended machine models towards phase numbers to greater or equal than three, see ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/990\">#990</a></li>
</ul>

<h5>Version 1.7.3, 2013-02-25</h5>

<ul>
<li>Corrected wrong parameter description</li>
</ul>

<h5>Version 1.7.2, 2011-06-28</h5>

<ul>
<li>Corrected bug in calculation of core conductance in
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">SymmetricPolyphaseWinding</a>:
the wrong calculation <code>G=(m/2)*GcRef/effectiveTurns^2</code> is now replaced by <code>G=(m/2)*GcRef*effectiveTurns^2</code></li>
</ul>

<h5>Version 1.7.1, 2010-09-03</h5>

<ul>
<li>Naming and documentation of
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPort\">
PartialTwoPort</a> is exchanged by
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortElementary\">
PartialTwoPortElementary</a> to match the naming conventions of
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces\">
Rotational.Interfaces</a>
and <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces\">
Translational.Interfaces</a></li>
<li>Fixed a broken link and updated documentation</li>
<li>Adaptions to Complex SIunits</li>
</ul>

<h5>Version 1.7.0, 2010-05-31</h5>

<ul>
<li>Changed <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">symmetric polyphase winding</a> model
  <ul>
      <li>Added zero sequence inductance based on
          <a href=\"modelica://Modelica.Electrical.Polyphase.Basic.ZeroInductor\">zero inductor</a></li>
      <li>Replaced electrical model of stray
          <a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Inductor\">inductor</a> by stray
          <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Reluctance\">reluctance</a> model</li>
      <li>Integrated cores <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">losses</a>
          and <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">heat port</a></li>
  </ul></li>
  <li>Added rotor core loss parameters in induction machine with slip rings</li>
  <li>Renamed heat ports of <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">single-phase winding</a> and <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">symmetric polyphase winding</a>
     </li>
  <li>Relocated core losses between zero inductor and stray reluctance model in the magnetic domain</li>
  <li>Renamed instances of stator and rotor (winding) models in each machines</li>
  <li>Added magnetic potential sensor</li>
  <li>Removed state selections</li>
  <li>Updates due to changed loss variable and heat port names in
      <a href=\"modelica://Modelica.Electrical.Machines\">Electrical.Machines</a></li>
  <li>Added machine specific output records to summarize power and loss balance</li>
  <li>Updated images of Users Guide</li>
  <li>Improved performance due to <code>annotation(Evaluate=true)</code> added to the parameters of the
      <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">single-phase winding</a></li>
  <li>Reduced number of states in <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">symmetric cage</a> model by introducing an additional non-grounded star connection</li>
</ul>

<h5>Version 1.6.0, 2010-05-05</h5>

<ul>
<li>Renamed all parameters <code>windingAngle</code> to <code>orientation</code>. The following classes are affected:
<ul>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">SinglePhaseElectroMagneticConverter</a></li>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">PolyphaseElectroMagneticConverter</a></li>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a></li>
<li><a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
</ul></li>
<li>Update due to changed class names in <a href=\"modelica://Modelica.Electrical.Machines.Icons\">Machines.Icons</a></li>
<li>Using <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort\">HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort</a> instead of
    <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">Analog.Interfaces.ConditionalHeatPort</a> in
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">EddyCurrent</a></li>
<li>Added <code>modelica://</code> to all Modelica hyper links</li>
<li>Fixed bug in displayed parameters of <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">EddyCurrent</a></li>
<li>Updated some images (and renamed image file <code>LossPower.png</code> to <code>lossPower.png</code>)</li>
<li>Exchanged positive and negative stator ports of <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
model, adapted equations accordingly and updated code documentation.</li>
</ul>

<h5>Version 1.5.0, 2010-04-28</h5>

<ul>
<li>Added stator core, friction, stray load and brush losses to all machine types based on
<a href=\"modelica://Modelica.Electrical.Machines.Losses\">loss models</a> of the <a href=\"modelica://Modelica.Electrical.Machines\">Machines</a> library.</li>
<li>Changed parameter of
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">EddyCurrent</a>
model from R to G</li>
<li>Fixed wrong sign of internal quantity <code>tauElectrical</code>, model behavior does not change</li>
<li>Rewrote equations of electromagnetic coupling to look more elegant</li>
</ul>

<h5>Version 1.4.0, 2010-04-22</h5>

<ul>
<li>Added eddy current model in accordance to <a href=\"modelica://Modelica.Magnetic.FluxTubes\">FluxTubes</a> library</li>
<li>Added thermal heat port to eddy current model</li>
<li>Minor updates due to dependencies of <a href=\"modelica://Modelica.Electrical.Machines\">Machines</a></li>
</ul>

<h5>Version 1.3.0, 2010-02-26</h5>

<ul>
<li>Changed some icon references</li>
<li>Added state selections for the machine models</li>
<li>Restructured partial machine model</li>
<li>Added copyright information</li>
</ul>

<h5>Version 1.2.0, 2010-02-17</h5>

<ul>
<li>Renamed Machines to BasicMachines</li>
<li>Updated dependencies due to renamed class
<a href=\"modelica://Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20\">LinearTemperatureCoefficient20</a></li>
<li>Added release notes in User's Guide</li>
</ul>

<h5>Version 1.1.0, 2010-02-15</h5>

<ul>
<li>Added thermal connectors and temperature dependent resistances</li>
</ul>

<h5>Version 1.0.0, 2010-02-04</h5>

<ul>
<li>Integrated the library into the MSL</li>
</ul>

<h5>Version 0.4.0, 2009-10-29</h5>

<ul>
<li>Corrected bug in magnetic potential calculation</li>
</ul>

<h5>Version 0.3.0, 2009-10-28</h5>

<ul>
<li>Renamed number of turns and winding angles</li>
</ul>

<h5>Version 0.2.0, 2009-10-20</h5>

<ul>
<li>Added idle model</li>
</ul>

<h5>Version 0.1.0, 2009-07-22</h5>

<ul>
<li>First version based on the concept of the FluxTubes library and the Magnetics library of Michael Beuschel
[<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Beuschel00</a>]</li>
</ul>
</html>"));
end ReleaseNotes;
