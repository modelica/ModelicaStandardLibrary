within Modelica.Electrical.Machines.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation (preferredView="info",Documentation(info="<html>

<h5>Version 3.2.3, 2019-01-23 (Anton Haumer, Christian Kral)</h5>
<ul>
  <li>Shortened default component names, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2301\">#2301</a></li>
  <li>Added new example
      <a href=\"modelica://Modelica.Electrical.Machines.Examples.SynchronousMachines.SMEE_DOL\">SMEE_DOL</a>, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2388\">#2388</a></li>
  <li>Fixed bug of wrong smooth order in
      <a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">Brush</a>, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2315\">#2315</a></li>
  <li>Unified communication interval, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2279\">#2279</a></li>
  <li>Unified simulation tolerances, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2278\">#2278</a></li>
  <li>Fixed icons of Modelica.Electrical.Machines.BasicMachines.Components, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2031\">#2031</a></li>
  <li>Updated blocks and functions towards polyphase systems greater or equal to three</li>
  <li>Added standard blocks and functions</li>
  <li>Improved documentation</li>
  <li>Added alias for rotor current in squirrel cage model</li>
  <li>Changed icon and location of terminal box according to <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1706\">#1706</a></li>
  <li>Updated documentation according to <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1753\">#1753</a>, <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1754\">#1754</a> and <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1755\">#1755</a></li>
</ul>

<h5>Version 3.2.1, 2014-10-05 (Anton Haumer, Christian Kral)</h5>
<ul>
  <li>Fixed bugs of wrong sign of power calculation and orientation of secondary components; see #1474</li>
  <li>Corrected bug in wrong orientation of rotor current; see #1226</li>
  <li>Fixed bug of wrong temperature propagation in transformer ambient model; see #1579</li>
</ul>

<h5>Version 2.6.0, 2013-02-25 (Anton Haumer)</h5>
<ul>
  <li>Corrected turnsRatio bug in induction machine with slipring rotor</li>
  <li>Corrected parameter descriptions</li>
</ul>

<h5>Version 2.5.0, 2012-XX-XX (Anton Haumer)</h5>
<ul>
  <li>Included permanent magnet losses</li>
</ul>

<h5>Version 2.4.0, 2010-04-20 (Anton Haumer)</h5>

<ul>
  <li>Included core, friction and stray load models for rotating electric machines</li>
</ul>

<h5>Version 2.3.0, 2010-02-16 (Anton Haumer)</h5>
<ul>
  <li>Included quasi-static DC machine models</li>
</ul>

<h5>Version 2.2.0, 2010-02-10 (Anton Haumer)</h5>
<ul>
  <li>Conditional ThermalPort for all machines</li>
</ul>

<h5>Version 2.1.3, 2010-02-10 (Anton Haumer)</h5>
<ul>
  <li>Prepared conditionalHeatPort of SquirrelCage and DamperCage</li>
</ul>

<h5>Version 2.1.2, 2010-02-09 (Anton Haumer)</h5>
<ul>
  <li>Included new Examples:
<a href=\"modelica://Modelica.Electrical.Machines.Examples.InductionMachines.IMC_Transformer\">
IMC_Transformer</a>,
DC_Comparison</li>
</ul>

<h5>Version 2.1.1, 2010-02-05 (Anton Haumer, Christian Kral)</h5>
<ul>
  <li>Included
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.SwitchedRheostat\">
SwitchedRheostat</a>,
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.RampedRheostat\">
RampedRheostat</a></li>
</ul>

<h5>Version 2.1.0, 2009-08-26 (Anton Haumer)</h5>
<ul>
  <li>Set all useHeatPort=false</li>
</ul>

<h5>Version 2.0.0, 2007-11-13 (Anton Haumer)</h5>
<ul>
  <li>Removed replaceable from air gaps</li>
  <li>Removed cardinality from support, using a Boolean parameter</li>
  <li>Removed all nonSIunits</li>
</ul>

<h5>Version 1.9.2, 2007-10-15 (Anton Haumer)</h5>
<ul>
  <li>Changed some names to be more concise (see conversion script)</li>
</ul>

<h5>Version 1.9.1, 2007-10-15 (Anton Haumer)</h5>
<ul>
  <li>Solved a bug with replaceable air gap / partial machines</li>
</ul>

<h5>Version 1.9.0, 2007-08-24 (Anton Haumer)</h5>

<ul>
  <li>Removed redeclare type SignalType</li>
</ul>

<h5>Version 1.8.8, 2007-08-20 (Anton Haumer)</h5>

<ul>
  <li>Improved documentation</li>
</ul>

<h5>Version 1.8.7, 2007-08-20 (Anton Haumer)</h5>
<ul>
  <li>Corrected typo in documentation</li>
</ul>

<h5>Version 1.8.6, 2007-08-12 (Anton Haumer)</h5>

<ul>
  <li>Improved documentation</li>
</ul>

<h5>Version 1.8.5, 2007-06-26 (Anton Haumer)</h5>
<ul>
  <li>Consistent parameters of DCSE</li>
</ul>

<h5>Version 1.8.4, 2007-06-25 (Anton Haumer)</h5>
<ul>
  <li>Corrected some typos in documentation</li>
</ul>

<h5>Version 1.8.3, 2007-06-08 (Anton Haumer)</h5>
<ul>
  <li>Documentation update</li>
</ul>

<h5>Version 1.8.2, 2007-01-15 (Anton Haumer)</h5>
<ul>
  <li>Resolved a bug in electrical excited synchronous machine</li>
</ul>

<h5>Version 1.8.1, 2006-12-01 (Anton Haumer)</h5>
<ul>
  <li>Resolved a compatibility issue with airGap</li>
</ul>

<h5>Version 1.8.0, 2006-11-26 (Anton Haumer)</h5>
<ul>
  <li>Introduced package Transformers</li>
  <li>Moved common parameters and functionality to partial models,
      keeping Interfaces.PartialBasicInductionMachines and PartialBasicDCMachine, respectively, for compatibility reasons</li>
  <li>Implemented support showing reaction torque if connected</li>
</ul>

<h5>Version 1.7.1, 2006-02-06 (Anton Haumer)</h5>
<ul>
  <li>Changed some naming of synchronous machines, not affecting existing models</li>
</ul>

<h5>Version 1.7.0, 2005-12-15 (Anton Haumer)</h5>
<ul>
  <li>Back-changed the naming to ensure backward compatibility</li>
</ul>

<h5>Version 1.6.3, 2005-11-25 (Anton Haumer)</h5>

<ul>
  <li>Easier parameterization of InductionMachines.IM_SlipRing model</li>
</ul>

<h5>Version 1.6.2, 2005-10-23 (Anton Haumer)</h5>
<ul>
  <li>Selectable DamperCage for Synchronous Machines</li>
</ul>

<h5>Version 1.6.1, 2005-11-22 (Anton Haumer)</h5>
<ul>
  <li>Improved transformation and rotation in SpacePhasor</li>
  <li>Introduced Examples.Utilities.TerminalBox</li>
</ul>

<h5>Version 1.60, 2005-11-04 (Anton Haumer)</h5>
<ul>
  <li>Added
      <a href=\"modelica://Modelica.Electrical.Machines.SpacePhasors.Components.Rotator\">
      Rotator</a></li>
  <li>Corrected consistent naming of parameters and variables</li>
</ul>

<h5>Version 1.53, 2005-10-14 (Anton Haumer)</h5>
<ul>
  <li>Introduced unsymmetrical damper cage for synchronous machines</li>
</ul>

<h5>Version 1.52, 2005-10-12 (Anton Haumer)</h5>
<ul>
  <li>Added
      <a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">
SM_ElectricalExcited</a>
      using new
      <a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.Components.ElectricalExcitation\">
      ElectricalExcitation</a>
      as well as a new example</li>
</ul>

<h5>Version 1.51, 2005-02-01 (Anton Haumer)</h5>
<ul>
  <li>Changed parameter polePairs to Integer</li>
</ul>

<h5>Version 1.4, 2004-11-11 (Anton Haumer)</h5>
<ul>
  <li>Removed mechanical flange support to ease the implementation of a 3D-frame in a future release</li>
</ul>

<h5>Version 1.3.2, 2004-11-10 (Anton Haumer)</h5>
<ul>
  <li>ReluctanceRotor moved to SynchronousMachines</li>
</ul>

<h5>Version 1.3.1, 2004-11-06 (Anton Haumer)</h5>
<ul>
  <li>Small changes in Examples.Utilities.VfController</li>
</ul>

<h5>Version 1.3, 2004-11-05 (Anton Haumer)</h5>
<ul>
  <li>Several improvements in SpacePhasors.Blocks</li>
</ul>

<h5>Version 1.2, 2004-10-27 (Anton Haumer)</h5>
<ul>
  <li>Fixed a bug with support (formerly bearing)</li>
</ul>

<h5>Version 1.1, 2004-10-01 (Anton Haumer)</h5>
<ul>
  <li>Changed naming and structure issued to Modelica Standard Library 2.1</li>
</ul>

<h5>Version 1.03, 2004-09-24 (Anton Haumer)</h5>
<ul>
  <li>Added package Sensors</li>
  <li>Added DC machine with series excitation</li>
  <li>Debugged and improved MoveToRotational</li>
</ul>

<h5>Version 1.02, 2004-09-19 (Anton Haumer)</h5>
<ul>
  <li>New package structure for machine types added DC machine models</li>
</ul>

<h5>Version 1.01, 2004-09-18 (Anton Haumer)</h5>
<ul>
  <li>Moved common equations from machine models to PartialMachine improved MoveToRotational</li>
</ul>

<h5>Version 1.00, 2004-09-16 (Anton Haumer)</h5>
<ul>
  <li>First stable release</li>
</ul>
</html>"));
end ReleaseNotes;
