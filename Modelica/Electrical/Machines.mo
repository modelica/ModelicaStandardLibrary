within Modelica.Electrical;
package Machines "Library for electric machines"
  extends Modelica.Icons.Package;
  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;
    class Concept "Concept"
      extends Modelica.Icons.Information;
      annotation (preferredView="info",Documentation(info="<html>
<p>This package contains electric machine models and components for modeling these machines.</p>
<strong>Limitations and assumptions:</strong>
<ul>
<li>number of phases (of induction machines) is limited to 3, therefore definition as a constant m=3</li>
<li>phase symmetric windings as well as symmetry of the whole machine structure</li>
<li>all values are used in physical units, no scaling to p.u. is done</li>
<li>only basic harmonics (in space) are taken into account</li>
<li>waveform (with respect to time) of voltages and currents is not restricted</li>
<li>constant parameters, i.e., no saturation, no skin effect</li>
</ul>
<p>
You may have a look at a short summary of space phasor theory at <a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">https://www.haumer.at/refimg/SpacePhasors.pdf</a>
</p>
<strong>Further development:</strong>
<ul>
<li>generalizing space phasor theory to m phases with arbitrary spatial angle of the coils</li>
<li>generalizing space phasor theory to arbitrary number of windings and winding factor of the coils</li>
<li>MachineModels: other machine types</li>
<li>effects: saturation, skin-effect, ...</li>
</ul>
<p>
<strong>In memoriam Prof. Hans Kleinrath (1928-03-07 - 2010-04-05)</strong>
</p>

</html>"));
    end Concept;

    class Discrimination "Discrimination of Machine models"
      extends Modelica.Icons.Information;
      annotation (preferredView="info",Documentation(info="<html>
  <table>
  <thead>
  <tr>
  <th align=\"left\">Machine type</th>
  <th align=\"left\">Transient models</th>
  <th align=\"left\">QuasiStatic models</th>
  </tr>
  </thead>
  <tbody>
  <tr>
  <td>Transformers</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.Transformers\">Modelica.Electrical.Machines.BasicMachines.Transformers</a></td>
  <td><a href=\"modelica://Modelica.Electrical.QuasiStationary.Machines.BasicMachines.Transformers\">Modelica.Electrical.QuasiStationary.Machines.BasicMachines.Transformers</a></td>
  </tr>
  <tr>
  <td>DC machines</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines\">Modelica.Electrical.Machines.BasicMachines.DCMachines</a></td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.QuasiStationaryDCMachines\">Modelica.Electrical.Machines.BasicMachines.QuasiStationaryDCMachines</a></td>
  </tr>
  <tr>
  <td>Induction machines, limited to 3 phases</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines\">Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines</a></td>
  <td>n/a</td>
  </tr>
  <tr>
  <td>Synchronous machines, limited to 3 phases</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines\">Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines</a></td>
  <td>n/a</td>
  </tr>
  <tr>
  <td>Induction machines, arbitrary number of phases</td>
  <td><a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines\">Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines</a></td>
  <td><a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines\">Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines</a></td>
  </tr>
  <tr>
  <td>Synchronous machines, arbitrary number of phases</td>
  <td><a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines\">Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines</a></td>
  <td><a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines\">Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines</a></td>
  </tr>
   </tbody>
  </table>

  <h4>Note:</h4>
  <ul>
  <li>Transient and quasiStatic models are parameter compatible.</li>
  <li>Induction machine models limited to 3 phases and with arbitrary number of phases are parameter compatible.</li>
  <li>Synchronous machine models limited to 3 phases and with arbitrary number of phases are parameter compatible.</li>
  </ul>
  </html>"));
    end Discrimination;

    class Contact "Contact"
      extends Modelica.Icons.Contact;
      annotation (preferredView="info",Documentation(info="<html>
<h4>Main authors</h4>

<p>
<strong>Anton Haumer</strong><br>
<a href=\"https://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
D-93049 Regensburg, Germany<br>
email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a><br>
</p>

<p>
<strong>Dr. Christian Kral</strong><br>
  <a href=\"https://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
  A-1060 Vienna, Austria<br>
  email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>
</html>"));
    end Contact;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (preferredView="info",Documentation(info="<html>

<h5>Version 3.2.3, 2018-09-26 (Anton Haumer, Christian Kral)</h5>
<ul>
  <li>Shortened default component names, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2301\">#2301</a></li>
  <li>Added new example
      <a href=\"modelica://Modelica.Electrical.Machines.Examples.SynchronousInductionMachines.SMEE_DOL\">SMEE_DOL</a>, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2388\">#2388</a></li>
  <li>Fixed bug of wrong smooth order in
      <a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">Brush</a>, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2315\">#2315</a></li>
  <li>Unified communication interval, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2279\">#2279</a></li>
  <li>Unified simulation tolerances, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2278\">#2278</a></li>
  <li>Fixed icons of Modelica.Electrical.Machines.BasicMachines.Components, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2031\">#2031</a></li>
  <li>Updated blocks and functions towards multi phase systems greater or equal to three</li>
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
  <li>Corrected turnsRatio bug in asynchronous induction machine with slipring rotor</li>
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
  <li>Included quasi stationary DC machine models</li>
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
<a href=\"modelica://Modelica.Electrical.Machines.Examples.AsynchronousInductionMachines.AIMC_Transformer\">
AIMC_Transformer</a>,
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
  <li>Resolved a bug in electrical excited synchronous induction machine</li>
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
  <li>Easier parameterization of AsynchronousInductionMachines.AIM_SlipRing model</li>
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
      <a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">
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

    class References "References"
      extends Modelica.Icons.References;
      annotation (preferredView="info",Documentation(info="<html>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Lang1984]</td>
      <td>W. Lang,
        &quot;&Uuml;ber die Bemessung verlustarmer Asynchronmotoren mit K&auml;figl&auml;ufer f&uuml;r
        Pulsumrichterspeisung,&quot;
        Doctoral Thesis,
        Technical University of Vienna, 1984.</td>
    </tr>
</table>
</html>"));
    end References;
    annotation (
      preferredView="info",
      DocumentationClass=true,
      Documentation(info="<html>
<p>
This is the library of electric machine models.
</p>

</html>"));
  end UsersGuide;

  package Examples "Test examples"
    extends Modelica.Icons.ExamplesPackage;
    package AsynchronousInductionMachines
      "Test examples of asynchronous induction machines"
      extends Modelica.Icons.ExamplesPackage;
      model AIMC_DOL
        "Test example: AsynchronousInductionMachineSquirrelCage direct-on-line"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lszero=aimcData.Lszero,
          Lssigma=aimcData.Lssigma,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          TsOperational=293.15,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={0,60},
              extent={{10,-10},{-10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=
              tStart1) annotation (Placement(transformation(extent={{-80,30},{-60,
                  50}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m)) annotation (Placement(transformation(
              origin={0,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Utilities.ParameterRecords.AIM_SquirrelCageData aimcData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      initial equation
        aimc.is = zeros(3);
        aimc.ir = zeros(2);
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
        connect(sineVoltage.plug_p, idealCloser.plug_p) annotation (Line(points=
               {{0,50},{0,48},{0,46},{0,40}}, color={0,0,255}));
        connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-59,40},{-20,40},{-20,30},{-12,30}},
                                                color={255,0,255}));
        connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{0,20},{0,17},{0,10}}, color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,-20},{0,-20},{0,-10}},
            color={0,0,255}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (
            Line(
            points={{60,-40},{70,-40}}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>At start time tStart three phase voltage is supplied to the asynchronous induction machine with squirrel cage;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
finally reaching nominal speed.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>
<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_DOL;

      model AIMC_YD
        "Test example: AsynchronousInductionMachineSquirrelCage Y-D"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
        parameter Modelica.SIunits.Time tStart2=2.0 "Start time from Y to D";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lszero=aimcData.Lszero,
          Lssigma=aimcData.Lssigma,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          TsOperational=293.15,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={0,60},
              extent={{10,-10},{-10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=
              tStart1) annotation (Placement(transformation(extent={{-80,30},{-60,
                  50}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m)) annotation (Placement(transformation(
              origin={0,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Machines.Utilities.SwitchYD switchYD(m=m) annotation (Placement(
              transformation(extent={{-20,-30},{0,-10}})));
        Modelica.Blocks.Sources.BooleanStep booleanStepYD[m](each startTime=
              tStart2) annotation (Placement(transformation(extent={{-80,-30},{
                  -60,-10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        parameter Utilities.ParameterRecords.AIM_SquirrelCageData aimcData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      initial equation
        aimc.is = zeros(3);
        aimc.ir = zeros(2);
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
        connect(sineVoltage.plug_p, idealCloser.plug_p) annotation (Line(points=
               {{0,50},{0,48},{0,46},{0,40}}, color={0,0,255}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-59,40},{-20,40},{-20,30},{-12,30}},
                                                color={255,0,255}));
        connect(booleanStepYD.y, switchYD.control)
          annotation (Line(points={{-59,-20},{-22,-20}}, color={255,0,255}));
        connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{0,20},{0,18},{0,10}}, color={0,0,255}));
        connect(switchYD.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(switchYD.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(switchYD.plugSupply, currentQuasiRMSSensor.plug_n) annotation (
            Line(
            points={{-10,-10},{0,-10}},
            color={0,0,255}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        annotation (experiment(StopTime=2.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>At start time tStart three phase voltage is supplied to the asynchronous induction machine with squirrel cage,
first star-connected, then delta-connected; the machine starts from standstill, accelerating inertias against
load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<p>Simulate for 2.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_YD;

      model AIMC_Transformer
        "Test example: AsynchronousInductionMachineSquirrelCage transformer starting"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
        parameter Modelica.SIunits.Time tStart2=2.0
          "Start time of bypass transformer";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lszero=aimcData.Lszero,
          Lssigma=aimcData.Lssigma,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          TsOperational=293.15,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              origin={0,80},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={-30,90},
              extent={{10,10},{-10,-10}})));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanStep booleanStep1[m](each startTime=
              tStart1) annotation (Placement(transformation(extent={{-60,40},{-40,
                  60}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m)) annotation (Placement(transformation(
              origin={0,50},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Machines.BasicMachines.Transformers.Yy.Yy00 transformer(
          n=transformerData.n,
          R1=transformerData.R1,
          L1sigma=transformerData.L1sigma,
          R2=transformerData.R2,
          L2sigma=transformerData.L2sigma,
          T1Ref=293.15,
          alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T2Ref=293.15,
          alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T1Operational=293.15,
          T2Operational=293.15) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-20,30})));

        Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(
              transformation(
              origin={-50,20},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        parameter Machines.Utilities.TransformerData transformerData(
          f=fNominal,
          V1=VNominal,
          C1=Modelica.Utilities.Strings.substring(
                    transformer.VectorGroup,
                    1,
                    1),
          V2=VNominal/sqrt(3),
          C2=Modelica.Utilities.Strings.substring(
                    transformer.VectorGroup,
                    2,
                    2),
          SNominal=50E3,
          v_sc=0.06,
          P_sc=500)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Blocks.Sources.BooleanStep booleanStep2[m](each startTime=
              tStart2) annotation (Placement(transformation(extent={{-60,-10},{
                  -40,10}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealCommutingSwitch
          idealCommutingSwitch(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(50E-5, m)) annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Utilities.ParameterRecords.AIM_SquirrelCageData aimcData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      initial equation
        aimc.is = zeros(3);
        aimc.ir = zeros(2);
        transformer.i1[1:2] = zeros(2);
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (
            Line(
            points={{60,-40},{70,-40}}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        connect(star.plug_p, sineVoltage.plug_n) annotation (Line(
            points={{-50,90},{-40,90}},
            color={0,0,255}));
        connect(booleanStep2.y, idealCommutingSwitch.control) annotation (Line(
            points={{-39,0},{-12,0}},color={255,0,255}));
        connect(transformer.starpoint2, ground2.p) annotation (Line(
            points={{-30,25},{-30,20},{-40,20}},
            color={0,0,255}));
        connect(idealCommutingSwitch.plug_p, terminalBox.plugSupply)
          annotation (Line(
            points={{0,-10},{-10,-10},{-10,-28}},
            color={0,0,255}));
        connect(transformer.plug2, idealCommutingSwitch.plug_n1) annotation (
            Line(
            points={{-20,20},{-4,20},{-4,10}}, color={0,0,255}));
        connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{-20,90},{0,90}},
            color={0,0,255}));
        connect(booleanStep1.y, idealCloser.control) annotation (Line(
            points={{-39,50},{-12,50}},color={255,0,255}));
        connect(currentQuasiRMSSensor.plug_n, idealCloser.plug_p) annotation (
            Line(
            points={{0,70},{0,60}},
            color={0,0,255}));
        connect(transformer.plug1, idealCloser.plug_n) annotation (Line(
            points={{-20,40},{0,40}},
            color={0,0,255}));
        connect(idealCloser.plug_n, idealCommutingSwitch.plug_n2) annotation (
            Line(
            points={{0,40},{0,10}}, color={0,0,255}));
        annotation (experiment(StopTime=2.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>
At start time tStart1 three phase voltage is supplied to the asynchronous induction machine with squirrel cage via the transformer;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed;
at start time tStart2 the machine is fed directly from the voltage source, finally reaching nominal speed.</p>

<p>Simulate for 2.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_Transformer;

      model AIMS_Start "Test example: AsynchronousInductionMachineSlipRing"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
        parameter Modelica.SIunits.Resistance Rstart=0.16/aimsData.turnsRatio^2
          "Starting resistance";
        parameter Modelica.SIunits.Time tStart2=1.0
          "Start time of shorting starting resistance";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing aims(
          p=aimsData.p,
          Jr=aimsData.Jr,
          Js=aimsData.Js,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          useTurnsRatio=aimsData.useTurnsRatio,
          turnsRatio=aimsData.turnsRatio,
          VsNominal=aimsData.VsNominal,
          VrLockedRotor=aimsData.VrLockedRotor,
          Rs=aimsData.Rs,
          TsRef=aimsData.TsRef,
          Lszero=aimsData.Lszero,
          Lssigma=aimsData.Lssigma,
          Lm=aimsData.Lm,
          Lrsigma=aimsData.Lrsigma,
          Lrzero=aimsData.Lrzero,
          Rr=aimsData.Rr,
          TrRef=aimsData.TrRef,
          frictionParameters=aimsData.frictionParameters,
          statorCoreParameters=aimsData.statorCoreParameters,
          strayLoadParameters=aimsData.strayLoadParameters,
          rotorCoreParameters=aimsData.rotorCoreParameters,
          fsNominal=aimsData.fsNominal,
          TsOperational=293.15,
          alpha20s=aimsData.alpha20s,
          alpha20r=aimsData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,-50},
                  {0,-30}})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={0,60},
              extent={{10,-10},{-10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=
              tStart1) annotation (Placement(transformation(extent={{-80,30},{-60,
                  50}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m)) annotation (Placement(transformation(
              origin={0,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        Machines.Utilities.SwitchedRheostat switchedRheostat(
          RStart=Rstart,
          tStart=tStart2,
          m=m)
          annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
        parameter Utilities.ParameterRecords.AIM_SlipRingData aimsData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      initial equation
        aims.is = zeros(3);
        aims.ir = zeros(3);
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
        connect(sineVoltage.plug_p, idealCloser.plug_p) annotation (Line(points=
               {{0,50},{0,48},{0,46},{0,40}}, color={0,0,255}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-59,40},{-20,40},{-20,30},{-12,30}},
                                                color={255,0,255}));
        connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{0,20},{0,16},{0,10}}, color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,-20},{0,-20},{0,-10}},
            color={0,0,255}));
        connect(terminalBox.plug_sn, aims.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, aims.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(aims.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        connect(switchedRheostat.plug_p, aims.plug_rp) annotation (Line(
            points={{-30,-34},{-20,-34}},
            color={0,0,255}));
        connect(switchedRheostat.plug_n, aims.plug_rn) annotation (Line(
            points={{-30,-46},{-20,-46}}, color={0,0,255}));
        annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>At start time tStart1 three phase voltage is supplied to the asynchronous induction machine with sliprings;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
using a starting resistance. At time tStart2 external rotor resistance is shortened, finally reaching nominal speed.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aims.wMechanical: motor's speed</li>
<li>aims.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMS_Start;

      model AIMC_Inverter
        "Test example: AsynchronousInductionMachineSquirrelCage with inverter"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
        parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lszero=aimcData.Lszero,
          Lssigma=aimcData.Lssigma,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          TsOperational=293.15,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-10,-10})));
        Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp) annotation (
           Placement(transformation(extent={{-100,20},{-80,40}})));
        Machines.Utilities.VfController vfController(
          final m=m,
          VNominal=VNominal,
          fNominal=fNominal) annotation (Placement(transformation(extent={{-70,20},
                  {-50,40}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
            final m=m) annotation (Placement(transformation(
              origin={30,30},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=270,
              origin={30,60})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={30,90},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
          startTime=tStep,
          stepTorque=-TLoad,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Utilities.ParameterRecords.AIM_SquirrelCageData aimcData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      initial equation
        aimc.is[1:2] = zeros(2);
        aimc.ir = zeros(2);
      equation
        connect(signalVoltage.plug_n, star.plug_p)
          annotation (Line(points={{30,40},{30,50}},        color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{30,70},{30,80}},   color={0,0,255}));
        connect(ramp.y, vfController.u)
          annotation (Line(points={{-79,30},{-72,30}}, color={0,0,255}));
        connect(vfController.y, signalVoltage.v)
          annotation (Line(points={{-49,30},{18,30}}, color={0,0,255}));
        connect(loadTorqueStep.flange, loadInertia.flange_b)
          annotation (Line(points={{70,-40},{60,-40}}));
        connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{30,20},{30,10},{-10,10},{-10,-1.77636e-15}},
                                                          color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,-20}},
            color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>
An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is raised by a ramp, causing the asynchronous induction machine with squirrel cage to start,
and accelerating inertias.<br>At time tStep a load step is applied.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_Inverter;

      model AIMC_Conveyor
        "Test example: AsynchronousInductionMachineSquirrelCage with inverter driving a conveyor"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        constant Modelica.SIunits.Frequency unitFrequency=1 annotation(HideResult=true);
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal
          "Nominal frequency";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*fNominal/aimcData.p
          "Nominal speed";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        parameter Modelica.SIunits.Length r=0.05 "Transmission radius";
        Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lszero=aimcData.Lszero,
          Lssigma=aimcData.Lssigma,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          TsOperational=293.15,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Blocks.Sources.CombiTimeTable
                                 dutyCycle(table=[0,0; 1,1; 4,1; 5,0; 10,0; 11,
              -1; 14,-1; 15,0; 20,0], extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
        Machines.Utilities.VfController vfController(
          final m=m,
          VNominal=VNominal,
          fNominal=fNominal) annotation (Placement(transformation(extent={{-40,
                  50},{-20,70}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
            final m=m) annotation (Placement(transformation(
              origin={0,60},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Utilities.ParameterRecords.AIM_SquirrelCageData aimcData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        Blocks.Math.Gain gain(k=fNominal/unitFrequency)
          annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
        Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio=1/r)
          annotation (Placement(transformation(extent={{12,-50},{32,-30}})));
        Mechanics.Translational.Components.Mass mass(m=JLoad/r^2)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Mechanics.Translational.Sources.SignForce signForce(                           v0(
              displayUnit="m/s") = 0.01*wNominal*r, f_nominal=-TLoad/r)
          annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
      initial equation
        aimc.is[1:2] = zeros(2);
        aimc.ir = zeros(2);

      equation
        connect(signalVoltage.plug_n, star.plug_p)
          annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(vfController.y, signalVoltage.v)
          annotation (Line(points={{-19,60},{-12,60}},color={0,0,255}));
        connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{0,50},{0,40},{0,10}}, color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,-20},{0,-20},{0,-10}},
            color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(vfController.u, gain.y)
          annotation (Line(points={{-42,60},{-49,60}}, color={0,0,127}));
        connect(dutyCycle.y[1], gain.u)
          annotation (Line(points={{-79,60},{-72,60}}, color={0,0,127}));
        connect(aimc.flange, idealGearR2T.flangeR)
          annotation (Line(points={{0,-40},{12,-40}}));
        connect(idealGearR2T.flangeT, mass.flange_a)
          annotation (Line(points={{32,-40},{36,-40},{40,-40}}, color={0,127,0}));
        connect(mass.flange_b, signForce.flange)
          annotation (Line(points={{60,-40},{66,-40},{70,-40}}, color={0,127,0}));
        annotation (experiment(StopTime=20, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is driven by a load cycle of acceleration, constant speed, deceleration and standstill.
The mechanical load is a constant torque like a conveyor (with regularization around zero speed).</p>

<p>Simulate for 20 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_Conveyor;

      model AIMC_InverterDrive
        "Test example: AsynchronousInductionMachineSquirrelCage inverter drive"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        import Modelica.Electrical.MultiPhase.Functions.factorY2DC;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=400
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Resistance RGrid=10e-3 "Grid choke resistance";
        parameter Modelica.SIunits.Inductance LGrid=500e-6 "Grid choke inductance";
        parameter Modelica.SIunits.Voltage VDC=factorY2DC(m)*VNominal/sqrt(3) "Theoretical DC voltage";
        parameter Modelica.SIunits.Capacitance CDC=5e-3 "DC capacitor";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad=1440.45*2*pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";
        MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          final phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
          final freqHz=fill(fNominal, m),
          final offset=zeros(m),
          final startTime=zeros(m),
          final V=fill(VNominal*sqrt(2/3), m))
        annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,-30})));
        MultiPhase.Basic.Star star(m=m) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,-60})));
        Analog.Basic.Ground ground annotation (Placement(transformation(
              origin={-80,-90},
              extent={{-10,-10},{10,10}})));
        Sensors.CurrentQuasiRMSSensor gridCurrent
         annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-80,0})));
        MultiPhase.Basic.Resistor resistor(
          final m=m,
          final R=fill(RGrid, m),
          final T_ref=fill(20, m),
          final alpha=zeros(m),
          final T=fill(20, m))   annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-80,30})));
        MultiPhase.Basic.Inductor inductor(m=m, final L=fill(LGrid, m))
        annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-80,60})));

        PowerConverters.ACDC.DiodeBridge2mPulse rectifier
          annotation (Placement(transformation(extent={{-68,60},{-48,80}})));
        Analog.Basic.Capacitor capacitor(v(fixed=true, start=VDC), C=CDC)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-30,70})));
        PowerConverters.DCAC.MultiPhase2Level inverter annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              origin={0,70})));
        Machines.Sensors.CurrentQuasiRMSSensor machineCurrent annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={30,0})));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
          annotation (Placement(transformation(extent={{20,-24},{40,-4}})));
        Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lszero=aimcData.Lszero,
          Lssigma=aimcData.Lssigma,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          TsOperational=293.15,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{20,-40},
                  {40,-20}})));
        parameter Utilities.ParameterRecords.AIM_SquirrelCageData aimcData(
          Rs=0.03*16,
          Rr=0.04*16,
          Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*aimcData.fsNominal)*16,
          Lm=3*sqrt(1 - 0.0667)/(2*pi*aimcData.fsNominal)*16,
          Lrsigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*aimcData.fsNominal)*16)
          annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
        Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque loadTorque(
          useSupport=false, tau_nominal=-TLoad,
          TorqueDirection=false,
          w_nominal=wLoad)
          annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
        Modelica.Blocks.Sources.Ramp ramp(height=fNominal,
          startTime=0,
          duration=1.2)
          annotation (
           Placement(transformation(extent={{-10,-10},{10,10}},
              origin={-20,-50})));
        Machines.Utilities.VfController vfController(
          final m=m,
          VNominal=VNominal,
          fNominal=fNominal,
          EconomyMode=true)  annotation (Placement(transformation(extent={{-10,-10},{10,
                  10}},
              rotation=90,
              origin={0,-20})));

        SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,10})));
        PowerConverters.DCAC.Control.PWM pwm(uMax=VDC, f=2000)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,40})));
      initial equation
        inductor.i[1:2] = zeros(2);
        aimc.is[1:3] = zeros(3);
        aimc.ir = zeros(2);
      equation
        connect(loadTorque.flange, loadInertia.flange_b)
          annotation (Line(points={{80,-30},{70,-30}}));
        connect(terminalBox.plugSupply, machineCurrent.plug_n)
          annotation (Line(points={{30,-18},{30,-10}},
                                                     color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{24,-20},{24,-20}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{36,-20},{36,-20}},
            color={0,0,255}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{40,-30},{50,-30}}));
        connect(vfController.u, ramp.y)
          annotation (Line(points={{0,-32},{0,-50},{-9,-50}},
                                                     color={0,0,127}));
        connect(toSpacePhasor.u, vfController.y)
          annotation (Line(points={{0,-2},{0,-9}},   color={0,0,127}));
        connect(pwm.u, toSpacePhasor.y)
          annotation (Line(points={{0,28},{0,21}},   color={0,0,127}));
        connect(inverter.fire_p, pwm.fire_p)
          annotation (Line(points={{-6,58},{-6,51}}, color={255,0,255}));
        connect(inverter.fire_n, pwm.fire_n)
          annotation (Line(points={{6,58},{6,51}}, color={255,0,255}));
        connect(inverter.ac, machineCurrent.plug_p)
          annotation (Line(points={{10,70},{30,70},{30,10}}, color={0,0,255}));
        connect(capacitor.p, inverter.dc_p) annotation (Line(points={{-30,80},{-20,80},
                {-20,76},{-10,76}}, color={0,0,255}));
        connect(capacitor.n, inverter.dc_n) annotation (Line(points={{-30,60},{-20,60},
                {-20,64},{-10,64}}, color={0,0,255}));
        connect(rectifier.dc_p, capacitor.p) annotation (Line(points={{-48,76},{-40,76},
                {-40,80},{-30,80}}, color={0,0,255}));
        connect(rectifier.dc_n, capacitor.n) annotation (Line(points={{-48,64},{-40,64},
                {-40,60},{-30,60}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{-80,-40},{-80,-50}},   color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-80,-70},{-80,-80}}, color={0,0,255}));
        connect(resistor.plug_n, inductor.plug_p)
          annotation (Line(points={{-80,40},{-80,50}},   color={0,0,255}));
        connect(inductor.plug_n, rectifier.ac)
          annotation (Line(points={{-80,70},{-68,70}},  color={0,0,255}));
        connect(resistor.plug_p, gridCurrent.plug_p)
          annotation (Line(points={{-80,20},{-80,10}}, color={0,0,255}));
        connect(gridCurrent.plug_n, sineVoltage.plug_p)
          annotation (Line(points={{-80,-10},{-80,-20}}, color={0,0,255}));
        annotation (experiment(
            StopTime=1.5,
            Interval=5e-05,
            Tolerance=1e-06), Documentation(
              info="<html>
<p>
This is a model of a complete inverter drive comprising:
</p>
<ul>
<li>a grid model and a line choke</li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2mPulse\">a diode rectifier</a></li>
<li>a buffer capacitor</li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.MultiPhase2Level\">a switching inverter</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.PWM\">a pulse width modulation</a></li>
<li><a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">a voltage/frequency characteristic</a></li>
<li>the reference frequency ramped up</li>
<li>an induction machine with squirrel cage</li>
<li>a load inertia and quadratic speed dependent load torque (like a fan or pump)</li>
</ul>
<p>Please note: Be patient, two switching devices cause many event iteratons which cost performance.</p>
<p>Note that due to the voltage drop the voltage at the machine can't reach the full voltage which means torque reduction.</p>
<p>Default machine parameters are adapted to nominal phase voltage 400 V and nominal phase current 25 A.</p>
</html>"));
      end AIMC_InverterDrive;

      model AIMC_Steinmetz
        "AsynchronousInductionMachineSquirrelCage Steinmetz-connection"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
        parameter Modelica.SIunits.Capacitance Cr=0.0035
          "Motor's running capacitor";
        parameter Modelica.SIunits.Capacitance Cs=5*Cr
          "Motor's (additional) starting capacitor";
        parameter Modelica.SIunits.AngularVelocity wSwitch(displayUnit="rev/min")=
             1350*2*Modelica.Constants.pi/60
          "Speed for switching off the starting capacitor";
        parameter Modelica.SIunits.Torque TLoad=2/3*161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1462.5*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lszero=aimcData.Lszero,
          Lssigma=aimcData.Lssigma,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          TsOperational=293.15,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz=
              fNominal, V=sqrt(2)*VNominal) annotation (Placement(
              transformation(extent={{-50,100},{-70,80}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=tStart1)
          annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
        Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealCloser
          annotation (Placement(transformation(
              origin={-20,90},
              extent={{10,-10},{-10,10}},
              rotation=180)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Machines.Utilities.TerminalBox TerminalBox1(terminalConnection="D")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p3(m=m, k=3)
          annotation (Placement(transformation(
              origin={-30,18},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p2(m=m, k=2)
          annotation (Placement(transformation(
              origin={-10,18},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p1(m=m, k=1)
          annotation (Placement(transformation(
              origin={10,18},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Analog.Basic.Capacitor cRun(C=Cr) annotation (
            Placement(transformation(
              origin={10,50},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Capacitor cStart(C=Cs) annotation (
            Placement(transformation(
              origin={30,50},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealOpener
          annotation (Placement(transformation(
              origin={30,80},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
              wSwitch) annotation (Placement(transformation(
              origin={50,50},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Mechanics.Rotational.Sensors.SpeedSensor relSpeedSensor annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={30,-30})));
        parameter Utilities.ParameterRecords.AIM_SquirrelCageData aimcData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
            Placement(transformation(
              origin={-10,-10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
      initial equation
        aimc.is = zeros(3);
        aimc.ir = zeros(2);
        cStart.v = 0;
        cRun.v = 0;
      equation
        connect(ground.p, sineVoltage.n)
          annotation (Line(points={{-80,90},{-70,90}}, color={0,0,255}));
        connect(sineVoltage.p, idealCloser.p)
          annotation (Line(points={{-50,90},{-30,90}}, color={0,0,255}));
        connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-29,70},{-20,70},{-20,78}},
                                        color={255,0,255}));
        connect(plugToPin_p3.pin_p, sineVoltage.n) annotation (Line(points={{-30,
                20},{-70,20},{-70,90}}, color={0,0,255}));
        connect(idealCloser.n, plugToPin_p2.pin_p)
          annotation (Line(points={{-10,90},{-10,20}}, color={0,0,255}));
        connect(cRun.n, plugToPin_p1.pin_p)
          annotation (Line(points={{10,40},{10,20}}, color={0,0,255}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(cRun.p, idealCloser.n) annotation (Line(points={{10,60},{10,90},
                {-10,90}}, color={0,0,255}));
        connect(plugToPin_p1.pin_p, cStart.n)
          annotation (Line(points={{10,20},{30,20},{30,40}}, color={0,0,255}));
        connect(idealOpener.n, cStart.p) annotation (Line(points={{30,70},{30,
                67.5},{30,65},{30,60}}, color={0,0,255}));
        connect(idealOpener.p, idealCloser.n) annotation (Line(points={{30,90},
                {30,90},{-10,90}}, color={0,0,255}));
        connect(greaterThreshold.y, idealOpener.control) annotation (Line(
              points={{50,61},{50,80},{42,80}}, color={255,0,255}));
        connect(TerminalBox1.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(TerminalBox1.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        connect(relSpeedSensor.flange, aimc.flange) annotation (Line(
            points={{20,-30},{20,-40},{0,-40}}));
        connect(relSpeedSensor.w, greaterThreshold.u) annotation (Line(
            points={{41,-30},{50,-30},{50,38}},
            color={0,0,127}));
        connect(plugToPin_p3.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{-30,16},{-30,0},{-10,0}},
            color={0,0,255}));
        connect(plugToPin_p2.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{-10,16},{-10,0},{-10,0}},
            color={0,0,255}));
        connect(plugToPin_p1.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{10,16},{10,0},{-10,0}},
            color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, TerminalBox1.plugSupply)
          annotation (Line(
            points={{-10,-20},{-10,-28}}, color={0,0,255}));
        annotation (experiment(StopTime=1, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>At start time tStart single phase voltage is supplied to the asynchronous induction machine with squirrel cage;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_Steinmetz;

      model AIMC_withLosses
        "Test example: AsynchronousInductionMachineSquirrelCage with losses"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        import Modelica.Constants.pi;
        import Modelica.SIunits.Conversions.from_rpm;
        import Modelica.SIunits.Conversions.to_rpm;
        import Modelica.SIunits.Conversions.from_degC;
      protected
        parameter Modelica.SIunits.Power PNominal=18500 "Nominal output";
        parameter Modelica.SIunits.Voltage VNominal=400 "Nominal RMS voltage";
        parameter Modelica.SIunits.Current INominal=32.85 "Nominal RMS current";
        parameter Real pfNominal=0.898 "Nominal power factor";
        parameter Modelica.SIunits.Power PsNominal=sqrt(3)*VNominal*INominal*pfNominal "Nominal stator power";
        parameter Modelica.SIunits.Power lossNominal=PsNominal-PNominal "Nominal losses";
        parameter Real etaNominal=0.9049 "Nominal efficiency";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.AngularVelocity wNominal=from_rpm(1462.5)
          "Nominal speed";
        parameter Modelica.SIunits.Torque TNominal=PNominal/wNominal
          "Nominal torque";
        parameter Modelica.SIunits.Temperature TempNominal=from_degC(90)
          "Nominal temperature";
        Modelica.SIunits.Power Pel=electricalPowerSensor.P;
        Modelica.SIunits.ReactivePower Qel=electricalPowerSensor.Q;
        Modelica.SIunits.ApparentPower Sel=sqrt(Pel^2 + Qel^2);
        parameter Real Ptable[:]={1E-6,1845,3549,5325,7521,9372,11010,12930,
            14950,16360,18500,18560,20180,22170};
        parameter Real Itable[:]={11.0,11.20,12.27,13.87,16.41,18.78,21.07,
            23.92,27.05,29.40,32.85,32.95,35.92,39.35};
        parameter Real wtable[:]=from_rpm({1500,1496,1493,1490,1486,1482,1479,1475,1471,
            1467,1462,1462,1458,1453});
        parameter Real ctable[:]={0.085,0.327,0.506,0.636,0.741,0.797,0.831,
            0.857,0.875,0.887,0.896,0.896,0.902,0.906};
        parameter Real etable[:]={0,0.7250,0.8268,0.8698,0.8929,0.9028,0.9064,
            0.9088,0.9089,0.9070,0.9044,0.9043,0.9008,0.8972};
      public
        output Modelica.SIunits.Power Pmech=powerSensor.power "Mechanical output";
        output Modelica.SIunits.Power Ps_sim=sqrt(3)*VNominal*I_sim*pf_sim "Simulated stator power";
        output Modelica.SIunits.Power Ps_meas=sqrt(3)*VNominal*I_meas*pf_meas "Simulated stator power";
        output Modelica.SIunits.Power loss_sim=Ps_sim-Pmech "Simulated total losses";
        output Modelica.SIunits.Power loss_meas=Ps_meas-Pmech "Measured total losses";
        output Modelica.SIunits.Current I_sim=currentQuasiRMSSensor.I "Simulated current";
        output Modelica.SIunits.Current I_meas=combiTable1Ds.y[1] "Measured current";
        output Modelica.SIunits.AngularVelocity w_sim(displayUnit="rev/min")=aimc.wMechanical "Simulated speed";
        output Modelica.SIunits.AngularVelocity w_meas(displayUnit="rev/min")=combiTable1Ds.y[2] "Measured speed";
        output Real pf_sim=if noEvent(Sel > Modelica.Constants.small) then Pel/Sel else 0 "Simulated power factor";
        output Real pf_meas=combiTable1Ds.y[3] "Measured power factor";
        output Real eff_sim=if noEvent(abs(Pel) > Modelica.Constants.small) then Pmech/Pel else 0 "Simulated efficiency";
        output Real eff_meas=combiTable1Ds.y[4] "Measured efficiency";
        Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lszero=aimcData.Lszero,
          Lssigma=aimcData.Lssigma,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          TsOperational=TempNominal,
          TrOperational=TempNominal,
          wMechanical(fixed=true, start=2*pi*aimcData.fsNominal/aimcData.p),
          alpha20r=aimcData.alpha20r) annotation (Placement(transformation(
                extent={{-40,0},{-20,20}})));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
          annotation (Placement(transformation(extent={{-40,16},{-20,36}})));
        Machines.Sensors.ElectricalPowerSensor electricalPowerSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-30,40})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              origin={-30,70},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={-70,70},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-70,30})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-70,0},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
          annotation (Placement(transformation(extent={{-10,0},{10,20}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=aimcData.Jr)
          annotation (Placement(transformation(extent={{20,0},{40,20}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque
          annotation (Placement(transformation(extent={{70,0},{50,20}})));
        Modelica.Blocks.Math.Gain gain(k=-1)
          annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
        Modelica.Blocks.Continuous.PI PI(
          k=0.01,
          T=0.01,
          initType=Modelica.Blocks.Types.Init.InitialState)
          annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{-10,-40},{10,-60}})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=1.2*PNominal,
          offset=0,
          startTime=4.5,
          duration=5.5)
          annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
        Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table={{Ptable[j],
              Itable[j],wtable[j],ctable[j],etable[j]} for j in 1:size(Ptable,
              1)}, smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
          annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
        parameter Utilities.ParameterRecords.AIM_SquirrelCageData aimcData(
          statorCoreParameters(PRef=410, VRef=387.9),
          Jr=0.12,
          Rs=0.56,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
          Lssigma=1.52/(2*pi*fNominal),
          frictionParameters(PRef=180, wRef=wNominal),
          strayLoadParameters(
            PRef=0.005*sqrt(3)*VNominal*INominal*pfNominal,
            IRef=INominal/sqrt(3),
            wRef=wNominal),
          Lm=66.4/(2*pi*fNominal),
          Lrsigma=2.31/(2*pi*fNominal),
          Rr=0.42,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Aluminium)
          annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));

      initial equation
        aimc.i_0_s = 0;
        der(aimc.idq_sr) = zeros(2);
        der(aimc.idq_rr) = zeros(2);
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,20},{-70,10}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{-70,60},{-70,40}}, color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-36,20},{-36,20}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-24,20},{-24,20}},
            color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, electricalPowerSensor.plug_p)
          annotation (Line(
            points={{-30,60},{-30,57.5},{-30,57.5},{-30,55},{-30,50},{-30,50}},
            color={0,0,255}));

        connect(electricalPowerSensor.plug_nv, star.plug_p) annotation (Line(
            points={{-40,40},{-70,40}},
            color={0,0,255}));
        connect(electricalPowerSensor.plug_ni, terminalBox.plugSupply)
          annotation (Line(
            points={{-30,30},{-30,22}},
            color={0,0,255}));
        connect(aimc.flange, powerSensor.flange_a) annotation (Line(
            points={{-20,10},{-10,10}}));
        connect(powerSensor.flange_b, loadInertia.flange_a) annotation (Line(
            points={{10,10},{20,10}}));
        connect(torque.flange, loadInertia.flange_b) annotation (Line(
            points={{50,10},{40,10}}));
        connect(gain.y, torque.tau) annotation (Line(
            points={{71,-50},{80,-50},{80,10},{72,10}},
            color={0,0,127}));
        connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{-70,80},{-30,80}},
            color={0,0,255}));
        connect(powerSensor.power, feedback.u2) annotation (Line(
            points={{-8,-1},{-8,-20},{0,-20},{0,-42}},
            color={0,0,127}));
        connect(feedback.y, PI.u) annotation (Line(
            points={{9,-50},{18,-50}},
            color={0,0,127}));
        connect(PI.y, gain.u) annotation (Line(
            points={{41,-50},{48,-50}},
            color={0,0,127}));
        connect(ramp.y, feedback.u1) annotation (Line(
            points={{-19,-50},{-8,-50}},
            color={0,0,127}));
        connect(powerSensor.power, combiTable1Ds.u) annotation (Line(
            points={{-8,-1},{-8,-20},{18,-20}},
            color={0,0,127}));
        annotation (
          experiment(StopTime=5.0, Interval=1E-4, Tolerance=1e-06),
          Documentation(info="<html>
<ul>
<li>Simulate for 5 seconds: The machine is started at nominal speed, flux is build up in the machine.</li>
<li>Continue the simulation for additional 5 seconds: Subsequently a load ramp is applied.</li>
<li>Compare by plotting versus Pmech:</li>
</ul>
<table>
<tr><td>Current      </td><td>I_sim   </td><td>I_meas  </td></tr>
<tr><td>Speed        </td><td>w_sim   </td><td>w_meas  </td></tr>
<tr><td>Power factor </td><td>pf_sim  </td><td>pf_meas </td></tr>
<tr><td>Efficiency   </td><td>eff_sim </td><td>eff_meas</td></tr>
</table>
<p>Machine parameters are taken from a standard 18.5 kW 400 V 50 Hz motor, simulation results are compared with measurements.</p>
<table>
<tr><td>Nominal stator current            </td><td>     32.85  </td><td>A      </td></tr>
<tr><td>Power factor                      </td><td>      0.898 </td><td>       </td></tr>
<tr><td>Speed                             </td><td>   1462.5   </td><td>rpm    </td></tr>
<tr><td>Electrical input                  </td><td> 20,443.95  </td><td>W      </td></tr>
<tr><td>Stator copper losses              </td><td>    770.13  </td><td>W      </td></tr>
<tr><td>Stator core losses                </td><td>    410.00  </td><td>W      </td></tr>
<tr><td>Rotor  copper losses              </td><td>    481.60  </td><td>W      </td></tr>
<tr><td>Stray load losses                 </td><td>    102.22  </td><td>W      </td></tr>
<tr><td>Friction losses                   </td><td>    180.00  </td><td>W      </td></tr>
<tr><td>Mechanical output                 </td><td> 18,500.00  </td><td>W      </td></tr>
<tr><td>Efficiency                        </td><td>     90.49  </td><td>%      </td></tr>
<tr><td>Nominal torque                    </td><td>    120.79  </td><td>Nm     </td></tr>
</table>
<br>
<table>
<tr><td>Stator resistance per phase       </td><td>  0.56     </td><td>&Omega;</td></tr>
<tr><td>Temperature coefficient           </td><td> copper    </td><td>       </td></tr>
<tr><td>Reference temperature             </td><td> 20        </td><td>&deg;C </td></tr>
<tr><td>Operation temperature             </td><td> 90        </td><td>&deg;C </td></tr>
<tr><td>Stator leakage reactance at 50 Hz </td><td>  1.52     </td><td>&Omega;</td></tr>
<tr><td>Main  field    reactance at 50 Hz </td><td> 66.40     </td><td>&Omega;</td></tr>
<tr><td>Rotor  leakage reactance at 50 Hz </td><td>  2.31     </td><td>&Omega;</td></tr>
<tr><td>Rotor  resistance per phase       </td><td>  0.42     </td><td>&Omega;</td></tr>
<tr><td>Temperature coefficient           </td><td> aluminium </td><td>       </td></tr>
<tr><td>Reference temperature             </td><td> 20        </td><td>&deg;C </td></tr>
<tr><td>Operation temperature             </td><td> 90        </td><td>&deg;C </td></tr>
</table>
<p>See:<br>
Anton Haumer, Christian Kral, Hansj&ouml;rg Kapeller, Thomas B&auml;uml, Johannes V. Gragger<br>
<a href=\"https://www.modelica.org/events/modelica2009/Proceedings/memorystick/pages/papers/0103/0103.pdf\">
The AdvancedMachines Library: Loss Models for Electric Machines</a><br>
Modelica 2009, 7<sup>th</sup> International Modelica Conference</p>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Text(
                      extent={{-72,100},{68,80}},
                      lineColor={0,0,255},
                      textString=
                  "Simulate for 5 seconds for starting the machine."),Text(
                      extent={{-100,-80},{100,-100}},
                      lineColor={0,0,255},
                      textString=
                  "Continue the simulation for additional 5 seconds: a load ramp is applied.")}));
      end AIMC_withLosses;

      model AIMC_Initialize
        "Test example: Steady-State Initialization of AsynchronousInductionMachineSquirrelCage"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.AngularVelocity wSync=2*pi*fNominal/aimc.p;
        parameter Modelica.SIunits.Time tStart=0.5 "Start time";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lszero=aimcData.Lszero,
          Lssigma=aimcData.Lssigma,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          phiMechanical(fixed=true),
          TsOperational=293.15,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              origin={-10,0},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={-70,10},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-70,-20})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-70,-50},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Mechanics.Rotational.Sources.TorqueStep torqueStep(
          useSupport=false,
          startTime=tStart,
          stepTorque=-TLoad,
          offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Utilities.ParameterRecords.AIM_SquirrelCageData aimcData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      initial equation
        aimc.wMechanical = wSync;
        aimc.i_0_s = 0;
        der(aimc.idq_sr) = zeros(2);
        der(aimc.idq_rr) = zeros(2);
      equation
        connect(star.pin_n, ground.p) annotation (Line(points={{-70,-30},{-70,-30},
                {-70,-40}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{-70,0},{-70,-10}}, color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,-10}},
            color={0,0,255}));
        connect(loadInertia.flange_b, torqueStep.flange) annotation (Line(
            points={{60,-40},{70,-40}}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{-70,20},{-10,20},{-10,10}}, color={0,0,255}));
        annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>The asynchronous induction machine with squirrel cage is initialized in steady-state at no-load;
at time tStart a load torque step is applied.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_Initialize;

      annotation (Documentation(info="<html>
This package contains test examples of asynchronous induction machines.
</html>"));
    end AsynchronousInductionMachines;

    package SynchronousInductionMachines
      "Test examples of synchronous induction machines"
      extends Modelica.Icons.ExamplesPackage;
      model SMR_DOL
        "Test example: SynchronousInductionMachineReluctanceRotor direct-on-line"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
        parameter Modelica.SIunits.Time tStart1=0.1 "Switch-on time";
        parameter Modelica.SIunits.Torque TLoad=20 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.5 "Time of load torque step";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor
          smr(
          p=smrData.p,
          fsNominal=smrData.fsNominal,
          Rs=smrData.Rs,
          TsRef=smrData.TsRef,
          Lszero=smrData.Lszero,
          Lssigma=smrData.Lssigma,
          Jr=smrData.Jr,
          Js=smrData.Js,
          frictionParameters=smrData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=smrData.statorCoreParameters,
          strayLoadParameters=smrData.strayLoadParameters,
          Lmd=smrData.Lmd,
          Lmq=smrData.Lmq,
          useDamperCage=smrData.useDamperCage,
          Lrsigmad=smrData.Lrsigmad,
          Lrsigmaq=smrData.Lrsigmaq,
          Rrd=smrData.Rrd,
          Rrq=smrData.Rrq,
          TrRef=smrData.TrRef,
          TsOperational=293.15,
          alpha20s=smrData.alpha20s,
          ir(each fixed=true),
          TrOperational=293.15,
          alpha20r=smrData.alpha20r)
          annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
        Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              origin={0,0},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smr.p)
          annotation (Placement(transformation(
              origin={20,-40},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
          startTime=tStep,
          stepTorque=-TLoad,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
            terminalConnection="Y")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter
          Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData
          smrData annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={0,60},
              extent={{10,-10},{-10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=
              tStart1) annotation (Placement(transformation(extent={{-80,30},{-60,
                  50}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m)) annotation (Placement(transformation(
              origin={0,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
      initial equation
        smr.is[1:2] = zeros(2);
      equation
        connect(loadInertia.flange_b, loadTorqueStep.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(smr.plug_sn, rotorDisplacementAngle.plug_n) annotation (Line(
              points={{-16,-30},{-16,-20},{26,-20},{26,-30}}, color={0,0,255}));
        connect(smr.plug_sp, rotorDisplacementAngle.plug_p)
          annotation (Line(points={{-4,-30},{14,-30}}, color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,-10},{0,-10}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smr.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sn, smr.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(smr.flange, rotorDisplacementAngle.flange) annotation (Line(
            points={{0,-40},{10,-40}}));
        connect(smr.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        connect(star.pin_n,ground. p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(sineVoltage.plug_n,star. plug_p)
          annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
        connect(sineVoltage.plug_p,idealCloser. plug_p) annotation (Line(points=
               {{0,50},{0,48},{0,46},{0,40}}, color={0,0,255}));
        connect(booleanStep.y,idealCloser. control) annotation (Line(points={{-59,40},
                {-20,40},{-20,30},{-12,30}},    color={255,0,255}));
        connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{0,20},{0,10}}, color={0,0,255}));
        annotation (experiment(StopTime=2.5, Interval=0.001), Documentation(
              info="<html>
<strong>Test example: Synchronous induction machine with reluctance rotor direct on line</strong><br>
A synchronous machine with reluctance rotor starts direct on line, utilizing the damper cage.<br>
After reaching synchronous speed, at time tStep a load step is applied.<br>
Simulate for 2.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>smr.wMechanical: motor's speed</li>
<li>smr.tauElectrical: motor's torque</li>
<li>rotorDisplacementAngle.rotorDisplacementAngle: rotor displacement angle</li>
</ul>
Default machine parameters of model <em>SM_ReluctanceRotor</em> are used.
</html>"));
      end SMR_DOL;

      model SMR_Inverter
        "Test example: SynchronousInductionMachineReluctanceRotor with inverter"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
        parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
        parameter Modelica.SIunits.Torque TLoad=46 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor
          smr(
          p=smrData.p,
          fsNominal=smrData.fsNominal,
          Rs=smrData.Rs,
          TsRef=smrData.TsRef,
          Lszero=smrData.Lszero,
          Lssigma=smrData.Lssigma,
          Jr=smrData.Jr,
          Js=smrData.Js,
          frictionParameters=smrData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=smrData.statorCoreParameters,
          strayLoadParameters=smrData.strayLoadParameters,
          Lmd=smrData.Lmd,
          Lmq=smrData.Lmq,
          useDamperCage=smrData.useDamperCage,
          Lrsigmad=smrData.Lrsigmad,
          Lrsigmaq=smrData.Lrsigmaq,
          Rrd=smrData.Rrd,
          Rrq=smrData.Rrq,
          TrRef=smrData.TrRef,
          TsOperational=293.15,
          alpha20s=smrData.alpha20s,
          ir(each fixed=true),
          TrOperational=293.15,
          alpha20r=smrData.alpha20r) annotation (Placement(transformation(
                extent={{-20,-50},{0,-30}})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              origin={0,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smr.p)
          annotation (Placement(transformation(
              origin={20,-40},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp) annotation (
           Placement(transformation(extent={{-80,50},{-60,70}})));
        Machines.Utilities.VfController vfController(
          final m=m,
          VNominal=VNominal,
          fNominal=fNominal) annotation (Placement(transformation(extent={{-40,
                  50},{-20,70}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
            final m=m) annotation (Placement(transformation(
              origin={0,60},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
          startTime=tStep,
          stepTorque=-TLoad,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Utilities.ParameterRecords.SM_ReluctanceRotorData smrData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      initial equation
        smr.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(signalVoltage.plug_n, star.plug_p)
          annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(ramp.y, vfController.u)
          annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
        connect(vfController.y, signalVoltage.v)
          annotation (Line(points={{-19,60},{-12,60}},color={0,0,255}));
        connect(loadInertia.flange_b, loadTorqueStep.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(currentQuasiRMSSensor.plug_p, signalVoltage.plug_p)
          annotation (Line(points={{0,40},{0,42.5},{0,50}}, color={0,0,255}));
        connect(smr.plug_sn, rotorDisplacementAngle.plug_n) annotation (Line(
              points={{-16,-30},{-16,-20},{26,-20},{26,-30}}, color={0,0,255}));
        connect(smr.plug_sp, rotorDisplacementAngle.plug_p)
          annotation (Line(points={{-4,-30},{14,-30}}, color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,0},{0,0},{0,20}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smr.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sn, smr.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(smr.flange, rotorDisplacementAngle.flange) annotation (Line(
            points={{0,-40},{10,-40}}));
        connect(smr.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is raised by a ramp, causing the reluctance machine to start,
and accelerating inertias. At time tStep a load step is applied.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>smr.wMechanical: motor's speed</li>
<li>smr.tauElectrical: motor's torque</li>
<li>rotorDisplacementAngle.rotorDisplacementAngle: rotor displacement angle</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end SMR_Inverter;

      model SMPM_NoLoad "SMPM at no-load"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter
          Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
          smpmData(useDamperCage=false)
          annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
        Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
          smpm(
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          Rs=smpmData.Rs,
          TsRef=smpmData.TsRef,
          Lszero=smpmData.Lszero,
          Lssigma=smpmData.Lssigma,
          Jr=smpmData.Jr,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          Lmd=smpmData.Lmd,
          Lmq=smpmData.Lmq,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          frictionParameters=smpmData.frictionParameters,
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          TsOperational=293.15,
          alpha20s=smpmData.alpha20s,
          phiMechanical(fixed=true, start=(pi + 0*2*pi/m)/smpmData.p),
          TrOperational=293.15,
          alpha20r=smpmData.alpha20r)
               annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
            terminalConnection="Y", m=m)
          annotation (Placement(transformation(extent={{-10,6},{10,26}})));
        Modelica.Electrical.Analog.Basic.Ground ground
          annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
        Modelica.Electrical.MultiPhase.Sensors.PotentialSensor potentialSensor(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,30})));
        Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor(m=m)
          annotation (Placement(transformation(extent={{10,40},{30,60}})));
        SpacePhasors.Blocks.ToPolar toPolar
          annotation (Placement(transformation(extent={{40,40},{60,60}})));
        Blocks.Math.Gain toDeg(k=180/pi)
          annotation (Placement(transformation(extent={{70,40},{90,60}})));
        Sensors.HallSensor hallSensor(p=smpmData.p) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              origin={40,-30})));
        Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=2*
              pi*smpmData.fsNominal/smpmData.p)
          annotation (Placement(transformation(extent={{52,-10},{32,10}})));

      equation
        connect(terminalBox.plug_sn, smpm.plug_sn)
          annotation (Line(points={{-6,10},{-6,10}}, color={0,0,255}));
        connect(terminalBox.plug_sp, smpm.plug_sp)
          annotation (Line(points={{6,10},{6,10}}, color={0,0,255}));
        connect(ground.p, terminalBox.starpoint)
          annotation (Line(points={{-20,10},{-20,12},{-10,12}},color={0,0,255}));
        connect(potentialSensor.plug_p, terminalBox.plugSupply)
          annotation (Line(points={{0,20},{0,12}}, color={0,0,255}));
        connect(potentialSensor.phi, toSpacePhasor.u) annotation (Line(points={{8.88178e-16,
                41},{8.88178e-16,50},{8,50}}, color={0,0,127}));
        connect(constantSpeed.flange, smpm.flange)
          annotation (Line(points={{32,0},{10,0}}));
        connect(smpm.flange, hallSensor.flange)
          annotation (Line(points={{10,0},{20,0},{20,-30},{30,-30}}));
        connect(toSpacePhasor.y, toPolar.u)
          annotation (Line(points={{31,50},{38,50}}, color={0,0,127}));
        connect(toPolar.y[2], toDeg.u)
          annotation (Line(points={{61,50},{68,50}}, color={0,0,127}));
        annotation (experiment(StopTime=0.04,
              Interval=0.0001),
          Documentation(info="<html>
<p>
Synchronous machine with permanent magnets at no-load, driven with constant nominal speed.
</p>
<p>
You may check the terminal voltage = VsOpenCircuit (shown by the length of the space phasor) and the frequency = fsNominal.
</p>
<p>
Additionally, you may check the phase shift of the stator voltages with respect to the mechanical shaft angle:
</p>
<ul>
<li>If the shaft angle starts at (pi + 0*pi/3)/p, the flux linkage through phase 1 is at the maximum and therefore this phase voltage starts at 0.</li>
<li>If the shaft angle starts at (pi + 2*pi/3)/p, the flux linkage through phase 2 is at the maximum and therefore this phase voltage starts at 0.</li>
<li>If the shaft angle starts at (pi + 4*pi/3)/p, the flux linkage through phase 3 is at the maximum and therefore this phase voltage starts at 0.</li>
</ul>
<p>Note that the angle of the voltage space phasor is pi/2 behind the angle of the hall sensor,
i.e. after a rotation of the shaft by pi/2/p the flux linkage of phase 1 is zero and the induced voltage a maximum.
</p>
</html>"));
      end SMPM_NoLoad;

      model SMPM_Inverter
        "Test example: PermanentMagnetSynchronousInductionMachine with inverter"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
        parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
        parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
          smpm(
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          Rs=smpmData.Rs,
          TsRef=smpmData.TsRef,
          Lszero=smpmData.Lszero,
          Lssigma=smpmData.Lssigma,
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          frictionParameters=smpmData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          Lmd=smpmData.Lmd,
          Lmq=smpmData.Lmq,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          TsOperational=293.15,
          alpha20s=smpmData.alpha20s,
          ir(each fixed=true),
          TrOperational=293.15,
          alpha20r=smpmData.alpha20r) annotation (Placement(transformation(
                extent={{-20,-50},{0,-30}})));

        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              origin={0,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p)
          annotation (Placement(transformation(
              origin={20,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp) annotation (
           Placement(transformation(extent={{-80,50},{-60,70}})));
        Machines.Utilities.VfController vfController(
          final m=m,
          VNominal=VNominal,
          fNominal=fNominal,
          BasePhase=+Modelica.Constants.pi/2) annotation (Placement(
              transformation(extent={{-40,50},{-20,70}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
            final m=m) annotation (Placement(transformation(
              origin={0,60},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
          startTime=tStep,
          stepTorque=-TLoad,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Utilities.ParameterRecords.SM_PermanentMagnetData smpmData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      initial equation
        smpm.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(signalVoltage.plug_n, star.plug_p)
          annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(ramp.y, vfController.u)
          annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
        connect(vfController.y, signalVoltage.v)
          annotation (Line(points={{-19,60},{-12,60}},color={0,0,255}));
        connect(loadInertia.flange_b, loadTorqueStep.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{0,50},{0,50},{0,40}}, color={0,0,255}));
        connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
              points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
        connect(rotorDisplacementAngle.plug_p, smpm.plug_sp)
          annotation (Line(points={{14,-30},{-4,-30}}, color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,0},{0,0},{0,20}},
            color={0,0,255}));
        connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(
            points={{0,-40},{10,-40}}));
        connect(smpm.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is raised by a ramp, causing the permanent magnet synchronous induction machine to start,
and accelerating inertias. At time tStep a load step is applied.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>smpm.wMechanical: motor's speed</li>
<li>smpm.tauElectrical: motor's torque</li>
<li>rotorDisplacementAngle.rotorDisplacementAngle: rotor displacement angle</li>
</ul>

<p>Default machine parameters are used.</p>

<p>
In practice it is nearly impossible to drive a PMSMD without current controller.</p>
</html>"));
      end SMPM_Inverter;

      model SMPM_CurrentSource
        "Test example: PermanentMagnetSynchronousInductionMachine fed by current source"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Current Idq[2]={-53.5, 84.6}
          "Desired d- and q-current";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p
          "Nominal speed";
        parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
          smpm(
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          TsOperational=293.15,
          Rs=smpmData.Rs,
          TsRef=smpmData.TsRef,
          alpha20s=smpmData.alpha20s,
          Lszero=smpmData.Lszero,
          Lssigma=smpmData.Lssigma,
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          frictionParameters=smpmData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          TrOperational=293.15,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          Lmd=smpmData.Lmd,
          Lmq=smpmData.Lmq,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          alpha20r=smpmData.alpha20r,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters)
          annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
        Modelica.Electrical.MultiPhase.Sources.SignalCurrent signalCurrent(
            final m=m) annotation (Placement(transformation(
              origin={-10,50},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Utilities.CurrentController currentController(p=smpm.p)
          annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
        Modelica.Blocks.Sources.Constant iq(k=Idq[2])
          annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
        Modelica.Blocks.Sources.Constant id(k=Idq[1])
          annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
        Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor annotation (
            Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={-30,-10})));
        Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-60,-10})));
        Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
              transformation(
              origin={-80,-28},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p)
          annotation (Placement(transformation(
              origin={20,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={10,0})));
        Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
            Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={40,-60})));
        Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={30,0})));
        Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
          annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
        Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticSpeedDependentTorque(            tau_nominal=-TLoad,
            w_nominal(displayUnit="rad/s") = wNominal)
          annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
        parameter Utilities.ParameterRecords.SM_PermanentMagnetData smpmData(
            useDamperCage=false)
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
            Placement(transformation(
              origin={-10,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
              points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
        connect(rotorDisplacementAngle.plug_p, smpm.plug_sp)
          annotation (Line(points={{14,-30},{-4,-30}}, color={0,0,255}));
        connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(
            points={{0,-40},{10,-40}}));
        connect(signalCurrent.plug_p, star.plug_p) annotation (Line(
            points={{-10,60},{-10,90},{-50,90}},
            color={0,0,255}));
        connect(angleSensor.flange, rotorDisplacementAngle.flange) annotation (
            Line(
            points={{10,-10},{10,-40}}));
        connect(angleSensor.phi, currentController.phi) annotation (Line(
            points={{10,11},{10,30},{-40,30},{-40,38}},
            color={0,0,127}));
        connect(id.y, currentController.id_rms) annotation (Line(
            points={{-69,70},{-60,70},{-60,56},{-52,56}},
            color={0,0,127}));
        connect(iq.y, currentController.iq_rms) annotation (Line(
            points={{-69,30},{-60,30},{-60,44},{-52,44}},
            color={0,0,127}));
        connect(groundM.p, terminalBox.starpoint) annotation (Line(
            points={{-70,-28},{-19,-28}},
            color={0,0,255}));
        connect(smpm.flange, torqueSensor.flange_a) annotation (Line(
            points={{0,-40},{30,-40},{30,-60}}));
        connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply)
          annotation (Line(
            points={{-20,-10},{-10,-10},{-10,-28}},
            color={0,0,255}));
        connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
            points={{-50,-10},{-40,-10}},
            color={0,0,255}));
        connect(starM.pin_n, groundM.p) annotation (Line(
            points={{-70,-10},{-70,-28}},
            color={0,0,255}));
        connect(currentController.y, signalCurrent.i) annotation (Line(
            points={{-29,50},{-22,50}}, color={0,0,127}));
        connect(speedSensor.flange, smpm.flange) annotation (Line(
            points={{30,-10},{30,-40},{0,-40}}));
        connect(quadraticSpeedDependentTorque.flange, inertiaLoad.flange_b)
          annotation (Line(
            points={{80,-40},{70,-40}}));
        connect(torqueSensor.flange_b, inertiaLoad.flange_a) annotation (Line(
            points={{50,-60},{50,-40}}));
        connect(signalCurrent.plug_n, currentQuasiRMSSensor.plug_p) annotation (
           Line(
            points={{-10,40},{-10,10}},
            color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, voltageQuasiRMSSensor.plug_p)
          annotation (Line(
            points={{-10,-10},{-20,-10}}, color={0,0,255}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>A synchronous induction machine with permanent magnets accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are converted to three-phase currents,
and fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.</p>

<p>Default machine parameters are used.</p>
</html>"));
      end SMPM_CurrentSource;

      model SMPM_VoltageSource
        "Test example: PermanentMagnetSynchronousInductionMachine fed by FOC"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Current Idq[2]={-53.5, 84.6}
          "Desired d- and q-current";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p
          "Nominal speed";
        parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
          smpm(
          phiMechanical(start=0, fixed=true),
          wMechanical(start=0, fixed=true),
          useSupport=false,
          useThermalPort=false,
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          Rs=smpmData.Rs,
          TsRef=smpmData.TsRef,
          Lszero=smpmData.Lszero,
          Lssigma=smpmData.Lssigma,
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          frictionParameters=smpmData.frictionParameters,
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          Lmd=smpmData.Lmd,
          Lmq=smpmData.Lmq,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          TsOperational=293.15,
          alpha20s=smpmData.alpha20s,
          TrOperational=293.15,
          alpha20r=smpmData.alpha20r) annotation (Placement(transformation(
                extent={{-20,-50},{0,-30}})));

        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
            final m=m) annotation (Placement(transformation(
              origin={-10,50},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.Constant iq(k=Idq[2])
          annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
        Modelica.Blocks.Sources.Constant id(k=Idq[1])
          annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={10,0})));
        Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
          annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticSpeedDependentTorque(            tau_nominal=-TLoad,
            w_nominal(displayUnit="rad/s") = wNominal)
          annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
        Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-10,0})));
        Machines.Utilities.VoltageController voltageController(
          p=smpm.p,
          Ld=smpm.Lssigma + smpm.Lmd,
          Lq=smpm.Lssigma + smpm.Lmq,
          Rs=Machines.Thermal.convertResistance(
                    smpm.Rs,
                    smpm.TsRef,
                    smpm.alpha20s,
                    smpm.TsOperational),
          fsNominal=smpm.fsNominal,
          VsOpenCircuit=smpm.VsOpenCircuit)
          annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
        Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={40,-60})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={30,0})));
        Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p)
          annotation (Placement(transformation(
              origin={20,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
              transformation(
              origin={-80,-28},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-60,-10})));
        Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={-30,-10})));
        parameter Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
          smpmData(useDamperCage=false)
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
            Placement(transformation(
              origin={-10,20},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      initial equation
        smpm.is[1:2] = zeros(2);

      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(quadraticSpeedDependentTorque.flange, inertiaLoad.flange_b)
          annotation (Line(
            points={{80,-40},{70,-40}}));
        connect(smpm.flange, angleSensor.flange) annotation (Line(
            points={{0,-40},{10,-40},{10,-10}}));
        connect(star.plug_p, signalVoltage.plug_n) annotation (Line(
            points={{-50,90},{-10,90},{-10,60}},
            color={0,0,255}));
        connect(currentSensor.plug_n, terminalBox.plugSupply) annotation (Line(
            points={{-10,-10},{-10,-28}},
            color={0,0,255}));
        connect(id.y, voltageController.id_rms) annotation (Line(
            points={{-69,70},{-60,70},{-60,56},{-52,56}},
            color={0,0,127}));
        connect(iq.y, voltageController.iq_rms) annotation (Line(
            points={{-69,30},{-60,30},{-60,44},{-52,44}},
            color={0,0,127}));
        connect(angleSensor.phi, voltageController.phi) annotation (Line(
            points={{10,11},{10,34},{-34,34},{-34,38}},
            color={0,0,127}));
        connect(voltageController.y, signalVoltage.v) annotation (Line(
            points={{-29,50},{-22,50}}, color={0,0,127}));
        connect(currentSensor.i, voltageController.iActual) annotation (Line(
            points={{-21,1.9984e-015},{-46,1.9984e-015},{-46,38}},
            color={0,0,127}));
        connect(inertiaLoad.flange_a, torqueSensor.flange_b) annotation (Line(
            points={{50,-40},{50,-60}}));
        connect(torqueSensor.flange_a, smpm.flange) annotation (Line(
            points={{30,-60},{30,-40},{0,-40}}));
        connect(speedSensor.flange, smpm.flange) annotation (Line(
            points={{30,-10},{30,-40},{0,-40}}));
        connect(rotorDisplacementAngle.flange, smpm.flange) annotation (Line(
            points={{10,-40},{0,-40}}));
        connect(rotorDisplacementAngle.plug_p, smpm.plug_sp) annotation (Line(
            points={{14,-30},{-4,-30}},
            color={0,0,255}));
        connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
            points={{26,-30},{26,-20},{-16,-20},{-16,-30}},
            color={0,0,255}));
        connect(voltageQuasiRMSSensor.plug_p, currentSensor.plug_n) annotation (
           Line(
            points={{-20,-10},{-10,-10}},
            color={0,0,255}));
        connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
            points={{-50,-10},{-40,-10}},
            color={0,0,255}));
        connect(groundM.p, starM.pin_n) annotation (Line(
            points={{-70,-28},{-70,-10}},
            color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, currentSensor.plug_p) annotation (
           Line(
            points={{-10,10},{-10,10}},
            color={0,0,255}));
        connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
           Line(
            points={{-10,40},{-10,30}}, color={0,0,255}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>
A synchronous induction machine with permanent magnets accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are controlled by the voltageController,
and the output voltages fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.</p>

<p>Default machine parameters are used.</p>
</html>"));
      end SMPM_VoltageSource;

      model SMPM_Braking
        "Test example: PermanentMagnetSynchronousInductionMachine acting as brake"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        constant Real unitK( unit="rad/(s.Ohm)")=1 annotation(HideResult=true);
        parameter Modelica.SIunits.Resistance R=1 "Nominal braking resistance";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p
          "Nominal speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
          smpm(
          phiMechanical(start=0, fixed=true),
          useSupport=false,
          useThermalPort=false,
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          Rs=smpmData.Rs,
          TsRef=smpmData.TsRef,
          Lszero=smpmData.Lszero,
          Lssigma=smpmData.Lssigma,
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          frictionParameters=smpmData.frictionParameters,
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          Lmd=smpmData.Lmd,
          Lmq=smpmData.Lmq,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          TsOperational=293.15,
          alpha20s=smpmData.alpha20s,
          wMechanical(start=wNominal, fixed=true),
          TrOperational=293.15,
          alpha20r=smpmData.alpha20r) annotation (Placement(transformation(
                extent={{-20,-50},{0,-30}})));

        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-80,60},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
          annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,0})));
        parameter Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
          smpmData(useDamperCage=false)
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
            Placement(transformation(
              origin={-10,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        PowerConverters.ACDC.DiodeBridge2mPulse diodeBridge2mPulse(m=m) annotation (
            Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={-10,30})));
        Analog.Basic.VariableResistor variableResistor
          annotation (Placement(transformation(extent={{0,50},{-20,70}})));
        Blocks.Math.Gain          gain(k=unitK*R/wNominal)
                                       annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,30})));
        Blocks.Nonlinear.Limiter          limiter(           uMin=0.1, uMax=10)
                                                          annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,60})));
        Blocks.Math.Gain          ac2dc(k=pi^2/8)
                                       annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={10,80})));
        MultiPhase.Basic.Star                     starM(final m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-60,-10})));
        Sensors.VoltageQuasiRMSSensor          voltageQuasiRMSSensor
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={-30,-10})));
        Analog.Basic.Resistor grounding(R=1e6) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-70,30})));
      initial equation
        smpm.is[1:2] = zeros(2);
        smpm.i_0_s = 0;

      equation
        connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, terminalBox.plugSupply)
          annotation (Line(points={{-10,-10},{-10,-10},{-10,-28}}, color={0,0,255}));
        connect(diodeBridge2mPulse.ac, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{-10,20},{-10,15},{-10,10}},
                                                              color={0,0,255}));
        connect(variableResistor.p, diodeBridge2mPulse.dc_p) annotation (Line(points={{0,60},{
                0,50},{-4,50},{-4,40}},               color={0,0,255}));
        connect(variableResistor.n, diodeBridge2mPulse.dc_n)
          annotation (Line(points={{-20,60},{-20,50},{-16,50},{-16,40}},
                                                                   color={0,0,255}));
        connect(smpm.flange, inertiaLoad.flange_a)
          annotation (Line(points={{0,-40},{50,-40}}));
        connect(gain.u, speedSensor.w)
          annotation (Line(points={{40,18},{40,11}},      color={0,0,127}));
        connect(limiter.u, gain.y)
          annotation (Line(points={{40,48},{40,41}}, color={0,0,127}));
        connect(limiter.y, ac2dc.u)
          annotation (Line(points={{40,71},{40,80},{22,80}}, color={0,0,127}));
        connect(ac2dc.y, variableResistor.R)
          annotation (Line(points={{-1,80},{-10,80},{-10,72}}, color={0,0,127}));
        connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
              points={{-50,-10},{-48,-10},{-40,-10}}, color={0,0,255}));
        connect(voltageQuasiRMSSensor.plug_p, currentQuasiRMSSensor.plug_n)
          annotation (Line(points={{-20,-10},{-20,-10},{-10,-10}}, color={0,0,
                255}));
        connect(smpm.flange, speedSensor.flange)
          annotation (Line(points={{0,-40},{40,-40},{40,-10}}));
        connect(terminalBox.starpoint, starM.pin_n) annotation (Line(points={{-20,-28},{-20,-28},{-70,-28},{-70,-10}},
                                                color={0,0,255}));
        connect(ground.p, variableResistor.n)
          annotation (Line(points={{-70,60},{-46,60},{-20,60}}, color={0,0,255}));
        connect(ground.p, grounding.n)
          annotation (Line(points={{-70,60},{-70,60},{-70,40}}, color={0,0,255}));
        connect(starM.pin_n, grounding.p)
          annotation (Line(points={{-70,-10},{-70,5},{-70,20}}, color={0,0,255}));
        annotation (experiment(StopTime=0.8, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>
A synchronous induction machine with permanent magnets starts braking from nominal speed by feeding a diode bridge,
which in turn feeds a braking resistor.
Since induced voltage is reduced proportional to falling speed, the braking resistance is set proportional to speed to
achieve constant current and torque.</p>

<p>Default machine parameters are used.</p>
</html>"));
      end SMPM_Braking;

      model SMEE_DOL
        "Test example: ElectricalExcitedSynchronousInductionMachine starting direct on line"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Voltage Ve=smeeData.Re*smeeData.IeOpenCircuit "Excitation current";
        parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0
          "Initial rotor displacement angle";
        Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smee(
          phiMechanical(start=-(Modelica.Constants.pi + gamma0)/smee.p, fixed=
                true),
          fsNominal=smeeData.fsNominal,
          Rs=smeeData.Rs,
          TsRef=smeeData.TsRef,
          Lssigma=smeeData.Lssigma,
          Lmd=smeeData.Lmd,
          Lmq=smeeData.Lmq,
          Lrsigmad=smeeData.Lrsigmad,
          Lrsigmaq=smeeData.Lrsigmaq,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          TrRef=smeeData.TrRef,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          sigmae=smeeData.sigmae,
          p=2,
          Jr=0.29,
          Js=0.29,
          useDamperCage=true,
          statorCoreParameters(VRef=100),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          ir(each fixed=true),
          wMechanical(fixed=true),
          TsOperational=293.15,
          alpha20s=smeeData.alpha20s,
          TrOperational=293.15,
          alpha20r=smeeData.alpha20r,
          alpha20e=smeeData.alpha20e,
          TeOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smee.p, m=m)
          annotation (Placement(transformation(
              origin={20,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-40,-70},
              extent={{-10,-10},{10,10}})));
        Mechanics.Rotational.Sensors.MultiSensor
                                               mechanicalMultiSensor
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Machines.Sensors.ElectricalPowerSensor electricalPowerSensor
          annotation (Placement(transformation(
              origin={0,40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              origin={0,10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          final V=fill(VNominal*sqrt(2), m),
          final freqHz=fill(fNominal, m)) annotation (Placement(transformation(
                extent={{-20,80},{-40,100}})));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Analog.Sources.RampVoltage                     rampVoltage(
          duration=0.1,
          V=Ve,
          offset=0,
          startTime=0.5)
                      annotation (Placement(transformation(
              origin={-40,-40},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Machines.Utilities.SynchronousMachineData smeeData(
          SNominal=30e3,
          VsNominal=100,
          fsNominal=50,
          IeOpenCircuit=10,
          x0=0.1,
          xd=1.6,
          xq=1.6,
          xdTransient=0.1375,
          xdSubtransient=0.121428571,
          xqSubtransient=0.148387097,
          Ta=0.014171268,
          Td0Transient=0.261177343,
          Td0Subtransient=0.006963029,
          Tq0Subtransient=0.123345081,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TsSpecification=293.15,
          TsRef=293.15,
          TrSpecification=293.15,
          TrRef=293.15,
          TeSpecification=293.15,
          TeRef=293.15)
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

        MultiPhase.Ideal.IdealClosingSwitch                     idealCloser(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m)) annotation (Placement(transformation(
              origin={0,70},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Blocks.Sources.BooleanStep booleanStep(startTime=0.0)
          annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
        Blocks.Routing.BooleanReplicator booleanReplicator(nout=m)
          annotation (Placement(transformation(extent={{-50,80},{-30,60}})));
        Mechanics.Rotational.Sources.TorqueStep torqueStep(
          offsetTorque=0,
          stepTorque=50,
          startTime=2)
          annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
      initial equation
        smee.is[1:2] = zeros(2);
        smee.ie = 0;
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(rotorDisplacementAngle.plug_n, smee.plug_sn) annotation (Line(
              points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
        connect(rotorDisplacementAngle.plug_p, smee.plug_sp)
          annotation (Line(points={{14,-30},{-4,-30}}, color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(star.plug_p, sineVoltage.plug_n)
          annotation (Line(points={{-50,90},{-40,90}}, color={0,0,255}));
        connect(electricalPowerSensor.plug_ni, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{0,30},{0,20}},        color={0,0,255}));
        connect(electricalPowerSensor.plug_nv, smee.plug_sn) annotation (Line(
              points={{-10,40},{-16,40},{-16,-30}}, color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,0},{0,0}},
            color={0,0,255}));
        connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(smee.flange, rotorDisplacementAngle.flange) annotation (Line(
            points={{0,-40},{10,-40}}));
        connect(smee.flange,mechanicalMultiSensor. flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        connect(sineVoltage.plug_p, idealCloser.plug_p)
          annotation (Line(points={{-20,90},{0,90},{0,80}}, color={0,0,255}));
        connect(idealCloser.plug_n, electricalPowerSensor.plug_p) annotation (Line(
              points={{-1.77636e-015,60},{0,60},{0,50},{1.77636e-015,50}}, color={0,0,
                255}));
        connect(booleanReplicator.y, idealCloser.control)
          annotation (Line(points={{-29,70},{-12,70}}, color={255,0,255}));
        connect(booleanStep.y, booleanReplicator.u)
          annotation (Line(points={{-69,70},{-52,70}}, color={255,0,255}));
        connect(groundExcitation.p, rampVoltage.n)
          annotation (Line(points={{-40,-60},{-40,-50}}, color={0,0,255}));
        connect(rampVoltage.n, smee.pin_en) annotation (Line(points={{-40,-50},
                {-30,-50},{-30,-46},{-20,-46}}, color={0,0,255}));
        connect(rampVoltage.p, smee.pin_ep) annotation (Line(points={{-40,-30},
                {-30,-30},{-30,-34},{-20,-34}}, color={0,0,255}));
        connect(mechanicalMultiSensor.flange_b, torqueStep.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        annotation (experiment(
            StopTime=3,
            Interval=0.0001,
            Tolerance=1e-006),                                                Documentation(info="<html>
<p>An electrically excited synchronous generator is started direct on line utilizing the damper cage
(and the shorted excitation winding) at 0 seconds.</p>
<p>At t = 0.5 seconds, the excitation voltage is raised to achieve the no-load excitation current.
Note, that reactive power of the stator goes to zero.</p>
<p>At t = 2 second, a driving torque step is applied to the shaft (i.e. the turbine is activated).
Note, that active and reactive power of the stator changes.
To drive at higher torque, i.e., produce more electric power, excitation has to be adapted.
</p>

<p>Simulate for 3 seconds and plot:</p>

<ul>
<li><code>smee.tauElectrical</code></li>
<li><code>smee.wMechanical</code></li>
<li><code>smee.ie</code></li>
<li><code>rotorDisplacementAngle.rotorDisplacementAngle</code></li>
<li><code>currentQuasiRMSSensor.I</code></li>
<li><code>electricalPowerSensor.P</code></li>
<li><code>electricalPowerSensor.Q</code></li>
<li><code>mechanicalMultiSensor.power</code></li>
</ul>

<p>Default machine parameters are used.</p>

<h5>Note</h5>
<p>The mains switch is closed at time = 0 in order to avoid non physical noise calculated by the <code>rotorDisplacementAngle</code>.
This noise is caused by the interaction of the high resistance of the switch and the machine, see
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2388\">#2388</a>.
</p>
</html>"));
      end SMEE_DOL;

      model SMEE_Generator
        "Test example: ElectricalExcitedSynchronousInductionMachine as Generator"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.AngularVelocity wActual(displayUnit="rev/min")=
             1499*2*Modelica.Constants.pi/60 "Actual speed";
        parameter Modelica.SIunits.Current Ie=19 "Excitation current";
        parameter Modelica.SIunits.Current Ie0=10 "Initial excitation current";
        parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0
          "Initial rotor displacement angle";
        Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smee(
          phiMechanical(start=-(Modelica.Constants.pi + gamma0)/smee.p, fixed=
                true),
          fsNominal=smeeData.fsNominal,
          Rs=smeeData.Rs,
          TsRef=smeeData.TsRef,
          Lssigma=smeeData.Lssigma,
          Lmd=smeeData.Lmd,
          Lmq=smeeData.Lmq,
          Lrsigmad=smeeData.Lrsigmad,
          Lrsigmaq=smeeData.Lrsigmaq,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          TrRef=smeeData.TrRef,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          sigmae=smeeData.sigmae,
          p=2,
          Jr=0.29,
          Js=0.29,
          useDamperCage=true,
          statorCoreParameters(VRef=100),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          TsOperational=293.15,
          alpha20s=smeeData.alpha20s,
          ir(each fixed=true),
          TrOperational=293.15,
          alpha20r=smeeData.alpha20r,
          alpha20e=smeeData.alpha20e,
          TeOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smee.p)
          annotation (Placement(transformation(
              origin={20,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-90,-50},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
            final w_fixed=wActual) annotation (Placement(transformation(extent=
                  {{90,-50},{70,-30}})));
        Machines.Sensors.MechanicalPowerSensor mechanicalPowerSensor
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Machines.Sensors.ElectricalPowerSensor electricalPowerSensor
          annotation (Placement(transformation(
              origin={0,60},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              origin={0,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          final V=fill(VNominal*sqrt(2), m),
          final freqHz=fill(fNominal, m)) annotation (Placement(transformation(
                extent={{-20,80},{-40,100}})));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(
          duration=0.1,
          I=Ie - Ie0,
          offset=Ie0) annotation (Placement(transformation(
              origin={-50,-40},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Machines.Utilities.SynchronousMachineData smeeData(
          SNominal=30e3,
          VsNominal=100,
          fsNominal=50,
          IeOpenCircuit=10,
          x0=0.1,
          xd=1.6,
          xq=1.6,
          xdTransient=0.1375,
          xdSubtransient=0.121428571,
          xqSubtransient=0.148387097,
          Ta=0.014171268,
          Td0Transient=0.261177343,
          Td0Subtransient=0.006963029,
          Tq0Subtransient=0.123345081,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TsSpecification=293.15,
          TsRef=293.15,
          TrSpecification=293.15,
          TrRef=293.15,
          TeSpecification=293.15,
          TeRef=293.15)
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

      initial equation
        smee.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(rotorDisplacementAngle.plug_n, smee.plug_sn) annotation (Line(
              points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
        connect(rotorDisplacementAngle.plug_p, smee.plug_sp)
          annotation (Line(points={{14,-30},{-4,-30}}, color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(star.plug_p, sineVoltage.plug_n)
          annotation (Line(points={{-50,90},{-40,90}}, color={0,0,255}));
        connect(electricalPowerSensor.plug_ni, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{0,50},{0,46},{0,40}}, color={0,0,255}));
        connect(mechanicalPowerSensor.flange_b, constantSpeed.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(sineVoltage.plug_p, electricalPowerSensor.plug_p)
          annotation (Line(points={{-20,90},{0,90},{0,70}}, color={0,0,255}));
        connect(rampCurrent.p, groundExcitation.p)
          annotation (Line(points={{-50,-50},{-80,-50}}, color={0,0,255}));
        connect(rampCurrent.p, smee.pin_en) annotation (Line(points={{-50,-50},
                {-40,-50},{-40,-46},{-20,-46}}, color={0,0,255}));
        connect(rampCurrent.n, smee.pin_ep) annotation (Line(points={{-50,-30},
                {-40,-30},{-40,-34},{-20,-34}}, color={0,0,255}));
        connect(electricalPowerSensor.plug_nv, smee.plug_sn) annotation (Line(
              points={{-10,60},{-16,60},{-16,-30}}, color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,0},{0,0},{0,20}},
            color={0,0,255}));
        connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(smee.flange, rotorDisplacementAngle.flange) annotation (Line(
            points={{0,-40},{10,-40}}));
        connect(smee.flange, mechanicalPowerSensor.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        annotation (experiment(StopTime=30, Interval=0.001, Tolerance=1e-06), Documentation(info="<html>
<p>An electrically excited synchronous generator is connected to the grid and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. This allows to see several characteristics dependent on rotor angle.</p>

<p>Simulate for 30 seconds and plot (versus rotorDisplacementAngle.rotorDisplacementAngle):</p>

<ul>
<li>smee.tauElectrical</li>
<li>currentQuasiRMSSensor.I</li>
<li>electricalPowerSensor.P</li>
<li>electricalPowerSensor.Q</li>
<li>mechanicalPowerSensor.P</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end SMEE_Generator;

      model SMEE_LoadDump
        "Test example: ElectricalExcitedSynchronousInductionMachine with voltage controller"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smeeData.fsNominal
            /smee.p "Nominal speed";
        parameter Modelica.SIunits.Impedance ZNominal=3*smeeData.VsNominal^2/
            smeeData.SNominal "Nominal load impedance";
        parameter Real powerFactor(
          min=0,
          max=1) = 0.8 "Load power factor";
        parameter Modelica.SIunits.Resistance RLoad=ZNominal*powerFactor
          "Load resistance";
        parameter Modelica.SIunits.Inductance LLoad=ZNominal*sqrt(1 -
            powerFactor^2)/(2*pi*smeeData.fsNominal) "Load inductance";
        parameter Modelica.SIunits.Voltage Ve0=smee.IeOpenCircuit*
            Machines.Thermal.convertResistance(
                  smee.Re,
                  smee.TeRef,
                  smee.alpha20e,
                  smee.TeOperational) "No load excitation voltage";
        parameter Real k=2*Ve0/smeeData.VsNominal "Voltage controller: gain";
        parameter Modelica.SIunits.Time Ti=smeeData.Td0Transient/2
          "Voltage controller: integral time constant";
        output Real controlError=(setPointGain.y - voltageQuasiRMSSensor.V)/
            smeeData.VsNominal;
        Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smee(
          fsNominal=smeeData.fsNominal,
          Rs=smeeData.Rs,
          TsRef=smeeData.TsRef,
          Lssigma=smeeData.Lssigma,
          Lmd=smeeData.Lmd,
          Lmq=smeeData.Lmq,
          Lrsigmad=smeeData.Lrsigmad,
          Lrsigmaq=smeeData.Lrsigmaq,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          TrRef=smeeData.TrRef,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          sigmae=smeeData.sigmae,
          useDamperCage=true,
          p=2,
          Jr=0.29,
          Js=0.29,
          statorCoreParameters(VRef=100),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          TsOperational=293.15,
          alpha20s=smeeData.alpha20s,
          TrOperational=293.15,
          alpha20r=smeeData.alpha20r,
          alpha20e=smeeData.alpha20e,
          TeOperational=293.15) annotation (Placement(transformation(extent={{0,
                  -40},{20,-20}})));
        parameter Machines.Utilities.SynchronousMachineData smeeData(
          SNominal=30e3,
          VsNominal=100,
          fsNominal=50,
          IeOpenCircuit=10,
          x0=0.1,
          xd=1.6,
          xq=1.6,
          xdTransient=0.1375,
          xdSubtransient=0.121428571,
          xqSubtransient=0.148387097,
          Ta=0.014171268,
          Td0Transient=0.261177343,
          Td0Subtransient=0.006963029,
          Tq0Subtransient=0.123345081,
          TsSpecification=293.15,
          TsRef=293.15,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TrSpecification=293.15,
          TrRef=293.15,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TeSpecification=293.15,
          TeRef=293.15,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero)
          annotation (Placement(transformation(extent={{0,-70},{20,-50}})));

        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,0},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Sources.Speed speed
          annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
        Modelica.Blocks.Sources.Ramp speedRamp(height=wNominal, duration=1)
          annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={30,-50})));
        Modelica.Blocks.Math.Gain setPointGain(k=(smeeData.VsNominal/wNominal)/
              unitMagneticFlux)
          annotation (Placement(transformation(extent={{-50,-90},{-70,-70}})));
        Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(
            ToSpacePhasor1(y(each start=1E-3, each fixed=true))) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Continuous.LimPID voltageController(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=k,
          Ti=Ti,
          yMax=2.5*Ve0,
          yMin=0,
          initType=Modelica.Blocks.Types.InitPID.InitialState,
          Td=0.001)
          annotation (Placement(transformation(extent={{-70,-20},{-50,-40}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage excitationVoltage
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-30,-30})));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-30,-60},
              extent={{-10,-10},{10,10}})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
          annotation (Placement(transformation(
              origin={10,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanPulse loadControl(period=4, startTime=2)
          annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
        Modelica.Electrical.MultiPhase.Ideal.CloserWithArc switch(
          m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m),
          V0=fill(30, m),
          dVdt=fill(10e3, m),
          Vmax=fill(60, m),
          closerWithArc(off(start=fill(true, m), fixed=fill(true, m))))
          annotation (Placement(transformation(extent={{0,40},{-20,60}})));
        Modelica.Electrical.MultiPhase.Basic.Resistor loadResistor(m=m, R=fill(
              RLoad, m))
          annotation (Placement(transformation(extent={{-30,40},{-50,60}})));
        Modelica.Electrical.MultiPhase.Basic.Inductor loadInductor(m=m, L=fill(
              LLoad, m))
          annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
        Modelica.Electrical.MultiPhase.Basic.Star star(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-90,30})));
      protected
        constant Modelica.SIunits.MagneticFlux unitMagneticFlux=1
          annotation (HideResult=true);
      initial equation
        smee.idq_sr = zeros(2);
        //conditional damper cage currents are defined as fixed start values
        smee.ie = 0;
      equation
        connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
            points={{4,-20},{4,-20}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
            points={{16,-20},{16,-20}},
            color={0,0,255}));
        connect(excitationVoltage.p, smee.pin_ep) annotation (Line(
            points={{-30,-20},{-20,-20},{-20,-24},{0,-24}},
            color={0,0,255}));
        connect(excitationVoltage.n, smee.pin_en) annotation (Line(
            points={{-30,-40},{-20,-40},{-20,-36},{0,-36}},
            color={0,0,255}));
        connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
            points={{-30,-40},{-30,-50}},
            color={0,0,255}));
        connect(voltageQuasiRMSSensor.plug_n, smee.plug_sn) annotation (Line(
            points={{0,-10},{4,-10},{4,-20}},
            color={0,0,255}));
        connect(voltageQuasiRMSSensor.plug_p, smee.plug_sp) annotation (Line(
            points={{0,10},{16,10},{16,-20}},
            color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{10,-18},{10,20}},
            color={0,0,255}));
        connect(smee.flange, speed.flange) annotation (Line(
            points={{20,-30},{30,-30}}));
        connect(speed.flange, speedSensor.flange) annotation (Line(
            points={{30,-30},{30,-40}}));
        connect(speedRamp.y, speed.w_ref) annotation (Line(
            points={{59,-30},{52,-30}},
            color={0,0,127}));
        connect(setPointGain.y, voltageController.u_s) annotation (Line(
            points={{-71,-80},{-80,-80},{-80,-30},{-72,-30}},
            color={0,0,127}));
        connect(speedSensor.w, setPointGain.u) annotation (Line(
            points={{30,-61},{30,-80},{-48,-80}},
            color={0,0,127}));
        connect(voltageQuasiRMSSensor.V, voltageController.u_m) annotation (
            Line(
            points={{-11,0},{-60,0},{-60,-18}},
            color={0,0,127}));
        connect(voltageController.y, excitationVoltage.v) annotation (Line(
            points={{-49,-30},{-42,-30}}, color={0,0,127}));
        connect(loadInductor.plug_p, loadResistor.plug_n) annotation (Line(
            points={{-60,50},{-50,50}},
            color={0,0,255}));
        connect(loadResistor.plug_p, switch.plug_n) annotation (Line(
            points={{-30,50},{-20,50}},
            color={0,0,255}));
        connect(switch.plug_p, currentQuasiRMSSensor.plug_p) annotation (Line(
            points={{0,50},{10,50},{10,40}},
            color={0,0,255}));
        connect(star.plug_p, loadInductor.plug_n) annotation (Line(
            points={{-90,40},{-90,50},{-80,50}},
            color={0,0,255}));
        connect(loadControl.y, switch.control[1]) annotation (Line(
            points={{-19,80},{-10,80},{-10,62}}, color={255,0,255}));
        connect(loadControl.y, switch.control[2]) annotation (Line(
            points={{-19,80},{-10,80},{-10,62}}, color={255,0,255}));
        connect(loadControl.y, switch.control[3]) annotation (Line(
            points={{-19,80},{-10,80},{-10,62}}, color={255,0,255}));
        connect(star.pin_n, ground.p) annotation (Line(
            points={{-90,20},{-90,10}}, color={0,0,255}));
        annotation (experiment(StopTime=10, Interval=1E-4, Tolerance=1e-06), Documentation(info="<html>
<p>
An electrically excited synchronous generator is started with a speed ramp, then driven with constant speed.
Voltage is controlled, the set point depends on speed. After start-up the generator is loaded, the load is rejected.</p>

<p>Simulate for 10 seconds and plot:</p>

<ul>
<li>voltageQuasiRMSSensor.V</li>
<li>smee.tauElectrical</li>
<li>smee.ie</li>
</ul>

<p>Default machine parameters are used.</p>

<p>One could try to optimize the controller parameters.</p>
</html>"));
      end SMEE_LoadDump;

      model SMEE_Rectifier
        "Test example: ElectricalExcitedSynchronousInductionMachine with rectifier"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smeeData.fsNominal
            /smee.p "Nominal speed";
        parameter Modelica.SIunits.Voltage VDC0=sqrt(2*3)*smeeData.VsNominal
          "No-load DC voltage";
        parameter Modelica.SIunits.Resistance RLoad=VDC0^2/smeeData.SNominal
          "Load resistance";
        parameter Modelica.SIunits.Voltage Ve0=smee.IeOpenCircuit*
            Machines.Thermal.convertResistance(
                  smee.Re,
                  smee.TeRef,
                  smee.alpha20e,
                  smee.TeOperational) "No load excitation voltage";
        parameter Real k=2*Ve0/smeeData.VsNominal "Voltage controller: gain";
        parameter Modelica.SIunits.Time Ti=smeeData.Td0Transient/2
          "Voltage controller: integral time constant";
        Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smee(
          fsNominal=smeeData.fsNominal,
          Rs=smeeData.Rs,
          TsRef=smeeData.TsRef,
          Lssigma=smeeData.Lssigma,
          Lmd=smeeData.Lmd,
          Lmq=smeeData.Lmq,
          Lrsigmad=smeeData.Lrsigmad,
          Lrsigmaq=smeeData.Lrsigmaq,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          TrRef=smeeData.TrRef,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          sigmae=smeeData.sigmae,
          useDamperCage=true,
          p=2,
          Jr=0.29,
          Js=0.29,
          statorCoreParameters(VRef=100),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          TsOperational=293.15,
          alpha20s=smeeData.alpha20s,
          ir(each fixed=true),
          TrOperational=293.15,
          alpha20r=smeeData.alpha20r,
          alpha20e=smeeData.alpha20e,
          TeOperational=293.15) annotation (Placement(transformation(extent={{0,
                  -40},{20,-20}})));
        parameter Machines.Utilities.SynchronousMachineData smeeData(
          SNominal=30e3,
          VsNominal=100,
          fsNominal=50,
          IeOpenCircuit=10,
          x0=0.1,
          xd=1.6,
          xq=1.6,
          xdTransient=0.1375,
          xdSubtransient=0.121428571,
          xqSubtransient=0.148387097,
          Ta=0.014171268,
          Td0Transient=0.261177343,
          Td0Subtransient=0.006963029,
          Tq0Subtransient=0.123345081,
          TsSpecification=293.15,
          TsRef=293.15,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TrSpecification=293.15,
          TrRef=293.15,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TeSpecification=293.15,
          TeRef=293.15,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero)
          annotation (Placement(transformation(extent={{0,-70},{20,-50}})));

        Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
          annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-20,60},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Mechanics.Rotational.Sources.Speed speed
          annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
        Blocks.Sources.Constant constantSpeed(k=wNominal)
          annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={30,-50})));
        Modelica.Blocks.Math.Gain setPointGain(k=(smeeData.VsNominal/wNominal)/
              unitMagneticFlux)
          annotation (Placement(transformation(extent={{-50,-90},{-70,-70}})));
        Modelica.Blocks.Continuous.LimPID voltageController(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=k,
          Ti=Ti,
          yMax=2.5*Ve0,
          yMin=0,
          initType=Modelica.Blocks.Types.InitPID.InitialState,
          Td=0.001)
          annotation (Placement(transformation(extent={{-70,-20},{-50,-40}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage excitationVoltage
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-30,-30})));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-30,-60},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.MultiPhase.Basic.Star star1(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-20,90})));
        Modelica.Electrical.MultiPhase.Ideal.IdealDiode idealDiode1(
          m=m,
          Ron=fill(1E-5, m),
          Goff=fill(1E-5, m),
          Vknee=fill(0, m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,80})));
        Modelica.Electrical.MultiPhase.Ideal.IdealDiode idealDiode2(
          m=m,
          Ron=fill(1E-5, m),
          Goff=fill(1E-5, m),
          Vknee=fill(0, m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,40})));
        Modelica.Electrical.MultiPhase.Basic.Star star2(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-20,30})));
        Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C=2*10E-6, v(
              fixed=true, start=0)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-40,80})));
        Modelica.Electrical.Analog.Basic.Capacitor capacitor2(C=2*10E-6, v(
              fixed=true, start=0)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-40,40})));
        Modelica.Electrical.Analog.Basic.Resistor resistor(R=RLoad) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,60})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-80,60})));
        Modelica.Blocks.Continuous.Filter filter(
          analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
          filterType=Modelica.Blocks.Types.FilterType.LowPass,
          order=2,
          f_cut=20,
          gain=1/sqrt(2*3),
          normalized=true) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,0})));
      protected
        constant Modelica.SIunits.MagneticFlux unitMagneticFlux=1
          annotation (HideResult=true);
      initial equation
        smee.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
        smee.ie = 0;
      equation
        connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
            points={{4,-20},{4,-20}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
            points={{16,-20},{16,-20}},
            color={0,0,255}));
        connect(excitationVoltage.p, smee.pin_ep) annotation (Line(
            points={{-30,-20},{-20,-20},{-20,-24},{0,-24}},
            color={0,0,255}));
        connect(excitationVoltage.n, smee.pin_en) annotation (Line(
            points={{-30,-40},{-20,-40},{-20,-36},{0,-36}},
            color={0,0,255}));
        connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
            points={{-30,-40},{-30,-50}},
            color={0,0,255}));
        connect(smee.flange, speed.flange) annotation (Line(
            points={{20,-30},{30,-30}}));
        connect(speed.flange, speedSensor.flange) annotation (Line(
            points={{30,-30},{30,-40}}));
        connect(constantSpeed.y, speed.w_ref) annotation (Line(
            points={{59,-30},{52,-30}},
            color={0,0,127}));
        connect(setPointGain.y, voltageController.u_s) annotation (Line(
            points={{-71,-80},{-80,-80},{-80,-30},{-72,-30}},
            color={0,0,127}));
        connect(speedSensor.w, setPointGain.u) annotation (Line(
            points={{30,-61},{30,-80},{-48,-80}},
            color={0,0,127}));
        connect(voltageController.y, excitationVoltage.v) annotation (Line(
            points={{-49,-30},{-42,-30}}, color={0,0,127}));
        connect(idealDiode1.plug_p, idealDiode2.plug_n) annotation (Line(
            points={{0,70},{0,50}},
            color={0,0,255}));
        connect(idealDiode2.plug_p, star2.plug_p) annotation (Line(
            points={{0,30},{-10,30}},
            color={0,0,255}));
        connect(idealDiode1.plug_n, star1.plug_p) annotation (Line(
            points={{0,90},{-10,90}},
            color={0,0,255}));
        connect(capacitor2.n, star2.pin_n) annotation (Line(
            points={{-40,30},{-30,30}},
            color={0,0,255}));
        connect(capacitor1.p, star1.pin_n) annotation (Line(
            points={{-40,90},{-30,90}},
            color={0,0,255}));
        connect(capacitor1.n, capacitor2.p) annotation (Line(
            points={{-40,70},{-40,50}},
            color={0,0,255}));
        connect(capacitor1.n, ground.p) annotation (Line(
            points={{-40,70},{-40,60},{-30,60}},
            color={0,0,255}));
        connect(filter.y, voltageController.u_m) annotation (Line(
            points={{-60,-11},{-60,-18}},
            color={0,0,127}));
        connect(voltageSensor.v, filter.u) annotation (Line(
            points={{-69,60},{-60,60},{-60,12}}, color={0,0,127}));
        connect(terminalBox.plugSupply, idealDiode2.plug_n) annotation (Line(
            points={{10,-18},{10,60},{0,60},{0,50}},
            color={0,0,255}));
        connect(resistor.p, capacitor1.p) annotation (Line(
            points={{-50,70},{-50,90},{-40,90}},
            color={0,0,255}));
        connect(resistor.n, capacitor2.n) annotation (Line(
            points={{-50,50},{-50,30},{-40,30}},
            color={0,0,255}));
        connect(voltageSensor.n, capacitor2.n) annotation (Line(
            points={{-80,50},{-80,30},{-40,30}},
            color={0,0,255}));
        connect(voltageSensor.p, capacitor1.p) annotation (Line(
            points={{-80,70},{-80,90},{-40,90}}, color={0,0,255}));
        annotation (experiment(StopTime=1.1, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>An electrically excited synchronous generator is driven with constant speed. Voltage is controlled,
the set point depends on speed. The generator is loaded with a rectifier.</p>

<p>Default machine parameters are used.</p>
</html>"));
      end SMEE_Rectifier;
      annotation (Documentation(info="<html>
This package contains test examples of synchronous induction machines.
</html>"));
    end SynchronousInductionMachines;

    package DCMachines "Test examples of DC machines"
      extends Modelica.Icons.ExamplesPackage;
      model DCPM_Start
        "Test example: DC with permanent magnet starting with voltage ramp"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
        parameter Modelica.SIunits.Time tStart=0.2
          "Start of armature voltage ramp";
        parameter Modelica.SIunits.Time tRamp=0.8 "Armature voltage ramp";
        parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.5 "Time of load torque step";
        parameter Modelica.SIunits.Inertia JLoad=0.15
          "Load's moment of inertia";
        Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
          VaNominal=dcpmData.VaNominal,
          IaNominal=dcpmData.IaNominal,
          wNominal=dcpmData.wNominal,
          TaNominal=dcpmData.TaNominal,
          Ra=dcpmData.Ra,
          TaRef=dcpmData.TaRef,
          La=dcpmData.La,
          Jr=dcpmData.Jr,
          useSupport=false,
          Js=dcpmData.Js,
          frictionParameters=dcpmData.frictionParameters,
          coreParameters=dcpmData.coreParameters,
          strayLoadParameters=dcpmData.strayLoadParameters,
          brushParameters=dcpmData.brushParameters,
          TaOperational=293.15,
          alpha20a=dcpmData.alpha20a,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          ia(fixed=true)) annotation (Placement(transformation(extent={{-20,-50},
                  {0,-30}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=tRamp,
          height=Va,
          startTime=tStart) annotation (Placement(transformation(extent={{-80,
                  60},{-60,80}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
          annotation (Placement(transformation(extent={{0,30},{-20,50}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-70,40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
          startTime=tStep,
          stepTorque=-TLoad,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      equation
        connect(ramp.y, signalVoltage.v) annotation (Line(points={{-59,70},{-10,70},{-10,52}},
                               color={0,0,255}));
        connect(signalVoltage.p, dcpm.pin_ap) annotation (Line(points={{0,40},{
                0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
        connect(signalVoltage.n, ground.p)
          annotation (Line(points={{-20,40},{-60,40}}, color={0,0,255}));
        connect(dcpm.pin_an, signalVoltage.n) annotation (Line(points={{-16,-30},
                {-16,-20},{-20,-20},{-20,40}}, color={0,0,255}));
        connect(loadInertia.flange_b, loadTorqueStep.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
              info="<html>
<strong>Test example: Permanent magnet DC machine started with an armature voltage ramp</strong><br>
A voltage ramp is applied to the armature, causing the DC machine to start,
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcpm.ia: armature current</li>
<li>dcpm.wMechanical: motor's speed</li>
<li>dcpm.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <em>DC_PermanentMagnet</em> are used.
</html>"));
      end DCPM_Start;

      model DCPM_CurrentControlled
        "Test example: DC with permanent magnet starting with current controller"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Torque TLoad=ViNominal*dcpmData.IaNominal/dcpmData.wNominal "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad=dcpmData.wNominal "Nominal load torque";
        parameter Modelica.SIunits.Inertia JLoad=dcpmData.Jr "Load's moment of inertia";
        parameter Modelica.SIunits.Resistance Ra=Modelica.Electrical.Machines.Thermal.convertResistance(
          dcpmData.Ra,
          dcpmData.TaRef,
          dcpmData.alpha20a,
          dcpmData.TaNominal) "Warm armature resistance";
        parameter Modelica.SIunits.Voltage ViNominal=dcpmData.VaNominal - Ra*dcpmData.IaNominal "Nominal induced voltage";
        parameter Modelica.SIunits.Time Ta=dcpmData.La/Ra "Armature time constant";
        parameter Modelica.SIunits.Time Ts=1e-3 "Dead time of inverter";
        parameter Modelica.SIunits.Resistance k=Ra*Ta/(2*Ts) "Current controller proportional gain";
        parameter Modelica.SIunits.Time Ti=Ta "Current controller integral time constant";
        parameter Modelica.SIunits.MagneticFlux kPhi=ViNominal/dcpmData.wNominal "Voltage constant";
        Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
          VaNominal=dcpmData.VaNominal,
          IaNominal=dcpmData.IaNominal,
          wNominal=dcpmData.wNominal,
          TaNominal=dcpmData.TaNominal,
          Ra=dcpmData.Ra,
          TaRef=dcpmData.TaRef,
          La=dcpmData.La,
          Jr=dcpmData.Jr,
          useSupport=false,
          Js=dcpmData.Js,
          frictionParameters=dcpmData.frictionParameters,
          coreParameters=dcpmData.coreParameters,
          strayLoadParameters=dcpmData.strayLoadParameters,
          brushParameters=dcpmData.brushParameters,
          TaOperational=293.15,
          alpha20a=dcpmData.alpha20a,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          ia(fixed=true)) annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
        Blocks.Sources.Step          step(
          height=dcpmData.IaNominal,
          offset=0,
          startTime=0.1)    annotation (Placement(transformation(extent={{-80,50},{-60,
                  70}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
          annotation (Placement(transformation(extent={{20,20},{0,40}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-10,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
        Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque loadTorque(
          useSupport=false,
          tau_nominal=-TLoad,
          TorqueDirection=false,
          w_nominal=wLoad)
          annotation (Placement(transformation(extent={{90,-30},{70,-10}})));
        parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData
          annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
        Analog.Sensors.CurrentSensor currentSensor annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={20,10})));
        Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={30,-38})));
        Blocks.Continuous.FirstOrder firstOrder(
          k=1,
          T=Ts,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=0)
          annotation (Placement(transformation(extent={{-20,50},{0,70}})));
        Blocks.Continuous.LimPID PID(withFeedForward=true, initType=Modelica.Blocks.Types.InitPID.InitialOutput,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=k,
          Ti=Ti,
          yMax=dcpmData.VaNominal,
          kFF=kPhi)
          annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
      equation
        connect(signalVoltage.n, ground.p)
          annotation (Line(points={{0,30},{0,0}}, color={0,0,255}));
        connect(loadInertia.flange_b, loadTorque.flange)
          annotation (Line(points={{60,-20},{70,-20}}));
        connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
            points={{20,-20},{40,-20}}));
        connect(dcpm.pin_an, ground.p)
          annotation (Line(points={{4,-10},{4,0},{0,0}}, color={0,0,255}));
        connect(signalVoltage.p, currentSensor.p)
          annotation (Line(points={{20,30},{20,20}}, color={0,0,255}));
        connect(currentSensor.n, dcpm.pin_ap)
          annotation (Line(points={{20,0},{16,0},{16,-10}}, color={0,0,255}));
        connect(dcpm.flange, speedSensor.flange)
          annotation (Line(points={{20,-20},{30,-20},{30,-28}}));
        connect(firstOrder.y, signalVoltage.v)
          annotation (Line(points={{1,60},{10,60},{10,42}}, color={0,0,127}));
        connect(PID.y, firstOrder.u)
          annotation (Line(points={{-29,60},{-22,60}}, color={0,0,127}));
        connect(step.y, PID.u_s)
          annotation (Line(points={{-59,60},{-52,60}}, color={0,0,127}));
        connect(currentSensor.i, PID.u_m) annotation (Line(points={{31,10},{100,10},{100,
                -82},{-40,-82},{-40,48}}, color={0,0,127}));
        connect(speedSensor.w, PID.u_ff) annotation (Line(points={{30,-49},{30,-70},{-34,
                -70},{-34,48}}, color={0,0,127}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
              info="<html>
<strong>Test example: Permanent magnet DC machine started with current controller</strong><br>
The current controller is parameterized according to absolute optimum.
At time 0.1 s a reference current step with height = nominal armature current is applied,
causing the DC machine to start, and accelerating inertias.
<br>The machine is loaded by a quadratic speed dependent load torque.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcpm.ia: armature current</li>
<li>dcpm.wMechanical: motor's speed</li>
<li>dcpm.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <em>DC_PermanentMagnet</em> are used.
</html>"));
      end DCPM_CurrentControlled;

      model DCEE_Start
        "Test example: DC with electrical excitation starting with voltage ramp"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
        parameter Modelica.SIunits.Time tStart=0.2
          "Start of armature voltage ramp";
        parameter Modelica.SIunits.Time tRamp=0.8 "Armature voltage ramp";
        parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
        parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.5 "Time of load torque step";
        parameter Modelica.SIunits.Inertia JLoad=0.15
          "Load's moment of inertia";
        Machines.BasicMachines.DCMachines.DC_ElectricalExcited dcee(
          VaNominal=dceeData.VaNominal,
          IaNominal=dceeData.IaNominal,
          wNominal=dceeData.wNominal,
          TaNominal=dceeData.TaNominal,
          Ra=dceeData.Ra,
          TaRef=dceeData.TaRef,
          La=dceeData.La,
          Jr=dceeData.Jr,
          useSupport=false,
          Js=dceeData.Js,
          frictionParameters=dceeData.frictionParameters,
          coreParameters=dceeData.coreParameters,
          strayLoadParameters=dceeData.strayLoadParameters,
          brushParameters=dceeData.brushParameters,
          IeNominal=dceeData.IeNominal,
          Re=dceeData.Re,
          TeRef=dceeData.TeRef,
          Le=dceeData.Le,
          sigmae=dceeData.sigmae,
          TaOperational=293.15,
          alpha20a=dceeData.alpha20a,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          ia(fixed=true),
          alpha20e=dceeData.alpha20e,
          TeOperational=293.15,
          ie(fixed=true)) annotation (Placement(transformation(extent={{-20,-50},
                  {0,-30}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=tRamp,
          height=Va,
          startTime=tStart) annotation (Placement(transformation(extent={{-80,
                  60},{-60,80}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
          annotation (Placement(transformation(extent={{0,30},{-20,50}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-70,40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=Ve)
          annotation (Placement(transformation(
              origin={-40,-40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-70,-50},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
          startTime=tStep,
          stepTorque=-TLoad,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        parameter Utilities.ParameterRecords.DcElectricalExcitedData dceeData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      equation
        connect(ramp.y, signalVoltage.v) annotation (Line(points={{-59,70},{-10,70},{-10,52}},
                               color={0,0,255}));
        connect(signalVoltage.p, dcee.pin_ap) annotation (Line(points={{0,40},{
                0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
        connect(signalVoltage.n, ground.p)
          annotation (Line(points={{-20,40},{-60,40}}, color={0,0,255}));
        connect(dcee.pin_an, ground.p) annotation (Line(points={{-16,-30},{-16,
                -20},{-20,-20},{-20,40},{-60,40}}, color={0,0,255}));
        connect(constantVoltage.n, groundExcitation.p)
          annotation (Line(points={{-40,-50},{-60,-50}}, color={0,0,255}));
        connect(dcee.pin_ep, constantVoltage.p) annotation (Line(points={{-20,-34},
                {-30,-34},{-30,-30},{-40,-30}}, color={0,0,255}));
        connect(dcee.pin_en, constantVoltage.n) annotation (Line(points={{-20,-46},
                {-30,-46},{-30,-50},{-40,-50}}, color={0,0,255}));
        connect(loadInertia.flange_b, loadTorqueStep.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(dcee.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
              info="<html>
<strong>Test example: Electrically separate excited DC machine started with an armature voltage ramp</strong><br>
A voltage ramp is applied to the armature, causing the DC machine to start,
and accelerating inertias.<br>At time tStep a load step is applied.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcee.ia: armature current</li>
<li>dcee.wMechanical: motor's speed</li>
<li>dcee.tauElectrical: motor's torque</li>
<li>dcee.ie: excitation current</li>
</ul>
Default machine parameters of model <em>DC_ElectricalExcited</em> are used.
</html>"));
      end DCEE_Start;

      model DCSE_Start
        "Test example: DC with serial excitation starting with voltage ramp"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
        parameter Modelica.SIunits.Time tStart=0.1 "Start of resistance ramp";
        parameter Modelica.SIunits.Time tRamp=0.9 "Resistance ramp";
        parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1410*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.15
          "Load's moment of inertia";
        Machines.BasicMachines.DCMachines.DC_SeriesExcited dcse(
          VaNominal=dcseData.VaNominal,
          IaNominal=dcseData.IaNominal,
          wNominal=dcseData.wNominal,
          TaNominal=dcseData.TaNominal,
          TeNominal=dcseData.TeNominal,
          Ra=dcseData.Ra,
          TaRef=dcseData.TaRef,
          La=dcseData.La,
          Jr=dcseData.Jr,
          useSupport=false,
          Js=dcseData.Js,
          frictionParameters=dcseData.frictionParameters,
          coreParameters=dcseData.coreParameters,
          strayLoadParameters=dcseData.strayLoadParameters,
          brushParameters=dcseData.brushParameters,
          Re=dcseData.Re,
          TeRef=dcseData.TeRef,
          Le=dcseData.Le,
          sigmae=dcseData.sigmae,
          TaOperational=293.15,
          alpha20a=dcseData.alpha20a,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          ia(fixed=true),
          alpha20e=dcseData.alpha20e,
          TeOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=tRamp,
          startTime=tStart,
          height=-1,
          offset=1) annotation (Placement(transformation(extent={{60,0},{40,20}})));
        Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=Va)
          annotation (Placement(transformation(extent={{0,50},{-20,30}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-70,40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,10})));
        parameter Utilities.ParameterRecords.DcSeriesExcitedData dcseData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      equation
        connect(constantVoltage.n, ground.p)
          annotation (Line(points={{-20,40},{-60,40}}, color={0,0,255}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(dcse.pin_an, dcse.pin_ep) annotation (Line(points={{-16,-30},{-20,
                -30},{-20,-34}}, color={0,0,255}));
        connect(dcse.pin_en, constantVoltage.n) annotation (Line(points={{-20,-46},
                {-30,-46},{-30,-20},{-20,-20},{-20,40}}, color={0,0,255}));
        connect(dcse.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        connect(constantVoltage.p, variableResistor.p) annotation (Line(
            points={{0,40},{0,20}}, color={0,0,255}));
        connect(variableResistor.n, dcse.pin_ap) annotation (Line(
            points={{0,0},{0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
        connect(ramp.y, variableResistor.R) annotation (Line(
            points={{39,10},{12,10}}, color={0,0,127}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
              info="<html>
<strong>Test example: Series excited DC machine started with a series resistor</strong><br>
At constant source voltage, a series resistor limiting the armature current, is reduced according to a ramp, causing the DC machine to start,
and accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcse.ia: armature current</li>
<li>dcse.wMechanical: motor's speed</li>
<li>dcse.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <em>DC_SeriesExcited</em> are used.
</html>"));
      end DCSE_Start;

      model DCSE_SinglePhase
        "Test example: DC with serial excitation starting with voltage ramp"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage RMS";
        parameter Modelica.SIunits.Time tStart=0.1 "Start of resistance ramp";
        parameter Modelica.SIunits.Time tRamp=0.9 "Resistance ramp";
        parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1410*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.15
          "Load's moment of inertia";
        Machines.BasicMachines.DCMachines.DC_SeriesExcited dcse(
          VaNominal=dcseData.VaNominal,
          IaNominal=dcseData.IaNominal,
          wNominal=dcseData.wNominal,
          TaNominal=dcseData.TaNominal,
          TeNominal=dcseData.TeNominal,
          Ra=dcseData.Ra,
          TaRef=dcseData.TaRef,
          La=dcseData.La,
          Jr=dcseData.Jr,
          useSupport=false,
          Js=dcseData.Js,
          frictionParameters=dcseData.frictionParameters,
          coreParameters=dcseData.coreParameters,
          strayLoadParameters=dcseData.strayLoadParameters,
          brushParameters=dcseData.brushParameters,
          Re=dcseData.Re,
          TeRef=dcseData.TeRef,
          Le=dcseData.Le,
          sigmae=dcseData.sigmae,
          TaOperational=293.15,
          alpha20a=dcseData.alpha20a,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          ia(fixed=true),
          alpha20e=dcseData.alpha20e,
          TeOperational=293.15) annotation (Placement(transformation(extent={{-20,
                  -50},{0,-30}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=tRamp,
          startTime=tStart,
          height=-1,
          offset=1) annotation (Placement(transformation(extent={{60,0},{40,20}})));
        Modelica.Electrical.Analog.Sources.SineVoltage constantVoltage(V=sqrt(2)
              *Va, freqHz=50) annotation (Placement(transformation(extent={{0,
                  50},{-20,30}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-70,40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,10})));
        parameter Utilities.ParameterRecords.DcSeriesExcitedData dcseData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      equation
        connect(constantVoltage.n, ground.p)
          annotation (Line(points={{-20,40},{-60,40}}, color={0,0,255}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(dcse.pin_an, dcse.pin_ep) annotation (Line(points={{-16,-30},{-20,
                -30},{-20,-34}}, color={0,0,255}));
        connect(dcse.pin_en, constantVoltage.n) annotation (Line(points={{-20,-46},
                {-30,-46},{-30,-20},{-20,-20},{-20,40}}, color={0,0,255}));
        connect(dcse.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        connect(constantVoltage.p, variableResistor.p) annotation (Line(
            points={{0,40},{0,20}}, color={0,0,255}));
        connect(variableResistor.n, dcse.pin_ap) annotation (Line(
            points={{0,0},{0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
        connect(ramp.y, variableResistor.R) annotation (Line(
            points={{39,10},{12,10}}, color={0,0,127}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
              info="<html>
<strong>Test example: Series excited DC machine at singlephase AC voltage started with a series resistor</strong><br>
At sinusoidal source voltage, a series resistor limiting the armature current, is reduced according to a ramp, causing the DC machine to start,
and accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcse.ia: armature current</li>
<li>dcse.wMechanical: motor's speed</li>
<li>dcse.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <em>DC_SeriesExcited</em> are used.<br>
<strong>Note:</strong><br>
Since both the field and the armature current are sinusoidal, the waveform of the torque is the square of sine.
Due to the additional inductive voltage drops, output of the motor is lower, compared to the same motor (DCSE_Start) at DC voltage.
</html>"));
      end DCSE_SinglePhase;
      /*
  model DC_CompareCharacteristics
    "Test example: Compare torque-speed characteristic of DC motors"
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
    parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
    parameter Modelica.SIunits.AngularVelocity w0=Modelica.SIunits.Conversions.from_rpm(1500)
      "No-load speed";
    parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
    parameter Modelica.SIunits.Time tStart=0.5 "Start of load torque ramp";
    parameter Modelica.SIunits.Time tRamp=2.0 "Load torque ramp";
    parameter Modelica.SIunits.Inertia JLoad=0.15 "Load's moment of inertia";

    Machines.BasicMachines.DCMachines.DC_ElectricalExcited dcee(wMechanical(start=
           w0, fixed=true), ie(start=1, fixed=true))
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                                                                     rotation=90,
          origin={-80,70})));
    Modelica.Electrical.Analog.Basic.Ground groundArmature
      annotation (Placement(transformation(
          origin={-80,40},
          extent={{-10,-10},{10,10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage excitationVoltage(V=Ve)
      annotation (Placement(transformation(
          origin={-80,-50},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.Analog.Basic.Ground groundExcitation
      annotation (Placement(transformation(
          origin={-80,-80},
          extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J=JLoad)
      annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    Modelica.Mechanics.Rotational.Sources.Torque loadTorque1(useSupport=false)
      annotation (Placement(transformation(extent={{60,-10},{40,10}})));
    Modelica.Blocks.Sources.Ramp ramp(
      startTime=tStart,
      height=-TLoad,
      duration=tRamp,
      offset=0) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  equation
    connect(loadInertia1.flange_b, loadTorque1.flange)
      annotation (Line(points={{30,0},{30,0},{40,0}}));
    connect(dcee.flange, loadInertia1.flange_a)
                                               annotation (Line(
        points={{0,0},{10,0}}));

    connect(ramp.y, loadTorque1.tau)
                                    annotation (Line(
        points={{79,0},{62,0}}, color={0,0,127}));
    connect(armatureVoltage.n, groundArmature.p) annotation (Line(
        points={{-80,60},{-80,50}}, color={0,0,255}));
    connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
        points={{-80,-60},{-80,-70}}, color={0,0,255}));
    connect(armatureVoltage.p, dcee.pin_ap) annotation (Line(
        points={{-80,80},{-30,80},{-30,20},{-4,20},{-4,10}}, color={0,0,255}));
    connect(armatureVoltage.n, dcee.pin_an) annotation (Line(
        points={{-80,60},{-40,60},{-40,10},{-16,10}}, color={0,0,255}));
    connect(excitationVoltage.p, dcee.pin_ep) annotation (Line(
        points={{-80,-40},{-60,-40},{-60,6},{-20,6}}, color={0,0,255}));
    connect(excitationVoltage.n, dcee.pin_en) annotation (Line(
        points={{-80,-60},{-50,-60},{-50,-6},{-20,-6}}, color={0,0,255}));
    annotation (
      experiment(StopTime=3, Interval=0.001),
      Documentation(info="<html>
<strong>Test example: Compare characteristic of DC motors</strong><br>
The motors are started at no-load speed, then a load ramp is applied.<br>
Simulate for 3 seconds and plot (versus time):
<ul>
<li>dcxx.ia: armature current</li>
<li>dcxx.wMechanical: motor's speed</li>
<li>dcxx.tauElectrical: motor's torque</li>
</ul>
Default machine parameters are used.
</html>"));
  end DC_CompareCharacteristics;
*/
      model DCPM_Temperature
        "Test example: Investigate temperature dependency of a DCPM motor"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
        parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
        parameter Modelica.SIunits.AngularVelocity w0=
            Modelica.SIunits.Conversions.from_rpm(1500) "No-load speed";
        parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
        parameter Modelica.SIunits.Inertia JLoad=0.15
          "Load's moment of inertia";
        Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
          wMechanical(start=w0, fixed=true),
          VaNominal=dcpmData.VaNominal,
          IaNominal=dcpmData.IaNominal,
          wNominal=dcpmData.wNominal,
          TaNominal=dcpmData.TaNominal,
          Ra=dcpmData.Ra,
          TaRef=dcpmData.TaRef,
          La=dcpmData.La,
          Jr=dcpmData.Jr,
          useSupport=false,
          Js=dcpmData.Js,
          frictionParameters=dcpmData.frictionParameters,
          coreParameters=dcpmData.coreParameters,
          strayLoadParameters=dcpmData.strayLoadParameters,
          brushParameters=dcpmData.brushParameters,
          phiMechanical(fixed=true),
          ia(fixed=true),
          TaOperational=293.15,
          alpha20a=dcpmData.alpha20a,
          useThermalPort=true) annotation (Placement(transformation(extent={{-20,
                  -10},{0,10}})));
        Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,70})));
        Modelica.Electrical.Analog.Basic.Ground groundArmature annotation (
            Placement(transformation(
              origin={-80,40},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{10,-10},{30,10}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
          useSupport=false,
          stepTorque=-TLoad,
          offsetTorque=0,
          startTime=0.1) annotation (Placement(transformation(extent={{60,-10},
                  {40,10}})));
        Machines.Thermal.DCMachines.ThermalAmbientDCPM thermalAmbientDCPM(
          useTemperatureInputs=true,
          Ta=293.15,
          Tpm=293.15)
          annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
        Modelica.Blocks.Sources.Exponentials exponential(
          offset=293.15,
          outMax=60,
          riseTime=3600,
          riseTimeConst=0.5,
          fallTimeConst=0.5,
          startTime=0.1)
          annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
        Modelica.Blocks.Sources.Constant const(k=293.15)
          annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
        parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData(
          alpha20a(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
          TaNominal=353.15,
          TaRef=353.15)
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

      equation
        connect(loadInertia.flange_b, loadTorque.flange)
          annotation (Line(points={{30,0},{30,0},{40,0}}));
        connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
            points={{0,0},{10,0}}));
        connect(armatureVoltage.n, groundArmature.p) annotation (Line(
            points={{-80,60},{-80,50}}, color={0,0,255}));
        connect(armatureVoltage.p, dcpm.pin_ap) annotation (Line(
            points={{-80,80},{-4,80},{-4,10}}, color={0,0,255}));
        connect(armatureVoltage.n, dcpm.pin_an) annotation (Line(
            points={{-80,60},{-16,60},{-16,10}}, color={0,0,255}));
        connect(exponential.y, thermalAmbientDCPM.TArmature) annotation (Line(
            points={{-39,-50},{-20,-50},{-20,-42}}, color={0,0,127}));
        connect(const.y, thermalAmbientDCPM.TPermanentMagnet) annotation (Line(
            points={{19,-50},{-10,-50},{-10,-42}}, color={0,0,127}));
        connect(dcpm.thermalPort, thermalAmbientDCPM.thermalPort) annotation (
            Line(points={{-10,-10},{-10,-15},{-10,-20}}, color={191,0,0}));
        annotation (experiment(StopTime=3.0, Interval=1E-4, Tolerance=1E-6), Documentation(
              info="<html>
<strong>Test example: Investigate influence of armature temperature on a DCPM motor</strong><br>
The motor starts at no-load speed, then a load step is applied.<br>
Beginning with the load step, the armature temperature rises exponentially from 20 degC to 80 degC.<br>
Simulate for 3 seconds and plot (versus time):
<ul>
<li>dcpm.ia: armature current</li>
<li>dcpm.wMechanical: motor's speed</li>
<li>dcpm.tauElectrical: motor's torque</li>
<li>thermalAmbientDCPM.Q_flow_a: motor's armature losses</li>
</ul>
Default machine parameters are used, but:
<ul>
<li>The armature winding material is set to Copper.</li>
<li>Armature reference temperature is set to 80 degC.</li>
<li>Nominal armature temperature is set to 80 degC.</li>
</ul>
So the machine is at the beginning in cold condition, ending in warm condition
(with the same armature resistance as the unmodified machine).
</html>"));
      end DCPM_Temperature;

      model DCPM_Cooling "Test example: Cooling of a DCPM motor"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
        parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
        parameter Modelica.SIunits.AngularVelocity w0=
            Modelica.SIunits.Conversions.from_rpm(1500) "No-load speed";
        parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
        parameter Modelica.SIunits.Inertia JLoad=0.15
          "Load's moment of inertia";
        parameter Modelica.SIunits.Temperature TAmbient=293.15
          "Ambient temperature";
        parameter Modelica.SIunits.HeatCapacity Ca=20
          "Armature's heat capacity";
        parameter Modelica.SIunits.HeatCapacity Cc=50 "Core's heat capacity";
        final parameter Modelica.SIunits.Power Losses=dcpm.Ra*dcpm.IaNominal^2
          "Nominal Losses";
        final parameter Modelica.SIunits.Temperature T0=293.15
          "Reference temperature 20 degC";
        final parameter Modelica.SIunits.TemperatureDifference dTCoolant=10
          "Coolant's temperature rise";
        final parameter Modelica.SIunits.TemperatureDifference dTArmature=dcpm.TaNominal
             - T0 - dTCoolant/2 "Armature's temperature rise over coolant";
        parameter Modelica.SIunits.ThermalConductance G_armature_core=2*Losses/
            dTArmature "Heat conductance armature - core";
        parameter Modelica.SIunits.ThermalConductance G_core_cooling=2*Losses/
            dTArmature "Heat conductance core - cooling";
        parameter Modelica.SIunits.VolumeFlowRate CoolantFlow=50 "Coolant flow";
        Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
          wMechanical(start=w0, fixed=true),
          VaNominal=dcpmData.VaNominal,
          IaNominal=dcpmData.IaNominal,
          wNominal=dcpmData.wNominal,
          TaNominal=dcpmData.TaNominal,
          Ra=dcpmData.Ra,
          TaRef=dcpmData.TaRef,
          La=dcpmData.La,
          Jr=dcpmData.Jr,
          useSupport=false,
          Js=dcpmData.Js,
          frictionParameters=dcpmData.frictionParameters,
          coreParameters=dcpmData.coreParameters,
          strayLoadParameters=dcpmData.strayLoadParameters,
          brushParameters=dcpmData.brushParameters,
          phiMechanical(fixed=true),
          ia(fixed=true),
          TaOperational=293.15,
          alpha20a=dcpmData.alpha20a,
          useThermalPort=true) annotation (Placement(transformation(extent={{-20,
                  20},{0,40}})));
        Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,70})));
        Modelica.Electrical.Analog.Basic.Ground groundArmature annotation (
            Placement(transformation(
              origin={-80,40},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{10,20},{30,40}})));
        Modelica.Mechanics.Rotational.Sources.Torque loadTorque(useSupport=
              false) annotation (Placement(transformation(extent={{60,20},{40,
                  40}})));
        Modelica.Blocks.Sources.Pulse pulse(
          amplitude=-1.5*TLoad,
          offset=0,
          period=1)
          annotation (Placement(transformation(extent={{90,20},{70,40}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor armature(C=Ca, T(
              start=TAmbient, fixed=true)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-50,-40})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor armatureCore(
            G=G_armature_core)
          annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor core(C=Cc, T(
              start=TAmbient, fixed=true)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-10,-40})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor coreCooling(G=
             G_core_cooling)
          annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        Modelica.Thermal.FluidHeatFlow.Sources.Ambient inlet(
            constantAmbientTemperature=TAmbient, constantAmbientPressure=0)
          annotation (Placement(transformation(extent={{-10,-80},{-30,-60}})));
        Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow(
          T0=TAmbient,
          constantVolumeFlow=CoolantFlow,
          m=0) annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
        Modelica.Thermal.FluidHeatFlow.Components.Pipe cooling(
          tapT=0.5,
          T0=TAmbient,
          m=0,
          h_g=0,
          V_flowLaminar=0.1,
          dpLaminar(displayUnit="Pa") = 0.1,
          V_flowNominal=1,
          dpNominal(displayUnit="Pa") = 1,
          T0fixed=false,
          useHeatPort=true)
          annotation (Placement(transformation(extent={{30,-60},{50,-80}})));
        Modelica.Thermal.FluidHeatFlow.Sources.Ambient outlet(
            constantAmbientTemperature=TAmbient, constantAmbientPressure=0)
          annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
            T=TAmbient)
          annotation (Placement(transformation(extent={{42,-10},{22,10}})));
      protected
        Machines.Interfaces.DCMachines.ThermalPortDCPM thermalPort
          annotation (Placement(transformation(extent={{-14,-4},{-6,4}})));
      public
        parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData(
          alpha20a(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
          TaNominal=353.15,
          TaRef=353.15)
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

      equation
        connect(loadInertia.flange_b, loadTorque.flange)
          annotation (Line(points={{30,30},{30,30},{40,30}}));
        connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
            points={{0,30},{10,30}}));
        connect(armatureVoltage.n, groundArmature.p) annotation (Line(
            points={{-80,60},{-80,50}}, color={0,0,255}));
        connect(armatureVoltage.p, dcpm.pin_ap) annotation (Line(
            points={{-80,80},{-4,80},{-4,40}}, color={0,0,255}));
        connect(armatureVoltage.n, dcpm.pin_an) annotation (Line(
            points={{-80,60},{-16,60},{-16,40}}, color={0,0,255}));
        connect(armature.port, armatureCore.port_a) annotation (Line(
            points={{-50,-30},{-40,-30}}, color={191,0,0}));
        connect(armatureCore.port_b, core.port) annotation (Line(
            points={{-20,-30},{-10,-30}}, color={191,0,0}));
        connect(core.port, coreCooling.port_a) annotation (Line(
            points={{-10,-30},{0,-30}}, color={191,0,0}));
        connect(pulse.y, loadTorque.tau) annotation (Line(
            points={{69,30},{62,30}}, color={0,0,127}));
        connect(coreCooling.port_b, cooling.heatPort) annotation (Line(
            points={{20,-30},{40,-30},{40,-60}}, color={191,0,0}));
        connect(cooling.flowPort_b, outlet.flowPort) annotation (Line(
            points={{50,-70},{60,-70}}, color={255,0,0}));
        connect(inlet.flowPort, volumeFlow.flowPort_a) annotation (Line(
            points={{-10,-70},{0,-70}}, color={255,0,0}));
        connect(volumeFlow.flowPort_b, cooling.flowPort_a) annotation (Line(
            points={{20,-70},{30,-70}}, color={255,0,0}));
        connect(armature.port, thermalPort.heatPortArmature) annotation (Line(
            points={{-50,-30},{-50,0},{-10,0}}, color={191,0,0}));
        connect(core.port, thermalPort.heatPortCore) annotation (Line(
            points={{-10,-30},{-10,0}}, color={191,0,0}));
        connect(fixedTemperature.port, thermalPort.heatPortStrayLoad)
          annotation (Line(
            points={{22,0},{-10,0}}, color={191,0,0}));
        connect(fixedTemperature.port, thermalPort.heatPortFriction)
          annotation (Line(
            points={{22,0},{-10,0}}, color={191,0,0}));
        connect(fixedTemperature.port, thermalPort.heatPortBrush) annotation (
            Line(
            points={{22,0},{-10,0}}, color={191,0,0}));
        connect(fixedTemperature.port, thermalPort.heatPortPermanentMagnet)
          annotation (Line(
            points={{22,0},{6,0},{6,-0.8},{-10.4,-0.8}}, color={191,0,0}));
        connect(dcpm.thermalPort, thermalPort) annotation (Line(points={{-10,20},
                {-10,10},{-10,0}}, color={191,0,0}));
        annotation (experiment(StopTime=25, Interval=1E-4, Tolerance=1E-6), Documentation(info=
               "<html>
<strong>Test example: Demonstrate cooling of a DCPM motor</strong><br>
The motor starts at no-load speed, then load pulses are applied.<br>
The cooling circuit consists of armature's thermal capacitance,
a thermal conductance between armature and core, core's thermal capacitance and
a thermal conductance between core and coolant.
The coolant flow circuit consists of inlet, volume flow, a pipe connected to the core and the outlet.<br>
<strong>Please note:</strong>
<ul>
<li>All unused heat ports of the thermal port (i.e., without loss sources in the machine: brush, stray, friction, permanent magnet) have to be connected to a constant temperature source.</li>
<li>The thermal capacitances (i.e., time constants) are unusual small to provide short simulation time!</li>
<li>The coolant is a theoretical coolant with specific mass = 1 kg/m3 and cp = 1 J/kg.K.</li>
<li>The thermal conductances as well as the coolant flow are parametrized such way, that:</li>
</ul>
<ol>
<li>the total coolant's temperature rise is 10 K (over coolant inlet)</li>
<li>the core's temperature rise is 27.5 K (over coolant's average temperature between inlet and outlet)</li>
<li>the armature's temperature rise is 55 K (over coolant's average temperature between inlet and outlet)</li>
</ol>
Simulate for 25 seconds and plot (versus time):
<ul>
<li>armature.T: armature temperature</li>
<li>core.T: core temperature</li>
<li>cooling.T: coolant temperature at outlet</li>
</ul>
Therefore the armature temperature would reach nominal armature temperature at constant nominal load.<br>
Default machine parameters are used, but:
<ul>
<li>The armature winding material is set to Copper.</li>
<li>Armature reference temperature is set to 80 degC.</li>
<li>Nominal armature temperature is set to 80 degC.</li>
</ul>
</html>"));
      end DCPM_Cooling;

      model DCPM_QuasiStationary
        "Test example: Compare DCPM motors transient - quasistationary"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
        parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
        parameter Modelica.SIunits.AngularVelocity w0=
            Modelica.SIunits.Conversions.from_rpm(1500) "No-load speed";
        parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
        parameter Modelica.SIunits.Inertia JLoad=0.15
          "Load's moment of inertia";
        Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm1(
          VaNominal=dcpmData.VaNominal,
          IaNominal=dcpmData.IaNominal,
          wNominal=dcpmData.wNominal,
          TaNominal=dcpmData.TaNominal,
          Ra=dcpmData.Ra,
          TaRef=dcpmData.TaRef,
          La=dcpmData.La,
          Jr=dcpmData.Jr,
          useSupport=false,
          Js=dcpmData.Js,
          frictionParameters=dcpmData.frictionParameters,
          coreParameters=dcpmData.coreParameters,
          strayLoadParameters=dcpmData.strayLoadParameters,
          brushParameters=dcpmData.brushParameters,
          phiMechanical(fixed=true),
          ia(fixed=true),
          TaOperational=293.15,
          alpha20a=dcpmData.alpha20a,
          wMechanical(fixed=true, start=w0)) annotation (Placement(
              transformation(extent={{-20,20},{0,40}})));
        Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,50})));
        Modelica.Electrical.Analog.Basic.Ground groundArmature annotation (
            Placement(transformation(
              origin={-80,20},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J=JLoad)
          annotation (Placement(transformation(extent={{10,20},{30,40}})));
        Modelica.Mechanics.Rotational.Sources.Torque loadTorque1(useSupport=
              false) annotation (Placement(transformation(extent={{60,20},{40,
                  40}})));
        Modelica.Blocks.Sources.Pulse pulse(
          amplitude=-1.5*TLoad,
          offset=0,
          period=1)
          annotation (Placement(transformation(extent={{100,-10},{80,10}})));
        Machines.BasicMachines.QuasiStationaryDCMachines.DC_PermanentMagnet
          dcpm2(
          VaNominal=dcpmData.VaNominal,
          IaNominal=dcpmData.IaNominal,
          wNominal=dcpmData.wNominal,
          TaNominal=dcpmData.TaNominal,
          Ra=dcpmData.Ra,
          TaRef=dcpmData.TaRef,
          La=dcpmData.La,
          Jr=dcpmData.Jr,
          useSupport=false,
          Js=dcpmData.Js,
          frictionParameters=dcpmData.frictionParameters,
          coreParameters=dcpmData.coreParameters,
          strayLoadParameters=dcpmData.strayLoadParameters,
          brushParameters=dcpmData.brushParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true, start=w0),
          TaOperational=293.15,
          alpha20a=dcpmData.alpha20a) annotation (Placement(transformation(
                extent={{-20,-40},{0,-20}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia2(J=JLoad)
          annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
        Modelica.Mechanics.Rotational.Sources.Torque loadTorque2(useSupport=
              false) annotation (Placement(transformation(extent={{60,-40},{40,
                  -20}})));
        parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData
          annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      equation
        connect(loadInertia1.flange_b, loadTorque1.flange)
          annotation (Line(points={{30,30},{30,30},{40,30}}));
        connect(dcpm1.flange, loadInertia1.flange_a) annotation (Line(
            points={{0,30},{10,30}}));
        connect(armatureVoltage.n, groundArmature.p) annotation (Line(
            points={{-80,40},{-80,30}}, color={0,0,255}));
        connect(armatureVoltage.p, dcpm1.pin_ap) annotation (Line(
            points={{-80,60},{-4,60},{-4,40}}, color={0,0,255}));
        connect(armatureVoltage.n, dcpm1.pin_an) annotation (Line(
            points={{-80,40},{-16,40}}, color={0,0,255}));
        connect(pulse.y, loadTorque1.tau) annotation (Line(
            points={{79,0},{70,0},{70,30},{62,30}}, color={0,0,127}));
        connect(loadInertia2.flange_b, loadTorque2.flange) annotation (Line(
              points={{30,-30},{30,-30},{40,-30}}));
        connect(dcpm2.flange, loadInertia2.flange_a) annotation (Line(
            points={{0,-30},{10,-30}}));
        connect(pulse.y, loadTorque2.tau) annotation (Line(
            points={{79,0},{70,0},{70,-30},{62,-30}}, color={0,0,127}));
        connect(armatureVoltage.p, dcpm2.pin_ap) annotation (Line(
            points={{-80,60},{-40,60},{-40,0},{-4,0},{-4,-20}}, color={0,0,255}));
        connect(armatureVoltage.n, dcpm2.pin_an) annotation (Line(
            points={{-80,40},{-60,40},{-60,-20},{-16,-20}}, color={0,0,255}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
              info="<html>
<strong>Test example: Compare DCPM motors transient and quasistationary</strong><br>
The motors start at no-load speed, then load pulses are applied.<br>
Simulate for 2 seconds and plot (versus time):
<ul>
<li>dcpm1.ia: armature current of transient model</li>
<li>dcpm1.wMechanical: motor's speed of transient model</li>
<li>dcpm1.tauElectrical: motor's torque of transient model</li>
<li>dcpm2.ia: armature current of quasistationary model</li>
<li>dcpm2.wMechanical: motor's speed of quasistationary model</li>
<li>dcpm2.tauElectrical: motor's torque of quasistationary model</li>
</ul>
</html>"));
      end DCPM_QuasiStationary;

      model DCPM_withLosses
        "Test example: Investigate influence of losses on DCPM motor performance"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
        parameter Modelica.SIunits.Time tStart=0.2
          "Start of armature voltage ramp";
        parameter Modelica.SIunits.Time tRamp=0.8 "Armature voltage ramp";
        parameter Modelica.SIunits.Torque TLoad1=63.66 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad1=1425*2*pi/60
          "Nominal load speed";
        parameter Modelica.SIunits.Torque TLoad2=61.30 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad2=1417.5*2*pi/60
          "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.15
          "Load's moment of inertia";
        Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm1(
          VaNominal=dcpmData1.VaNominal,
          IaNominal=dcpmData1.IaNominal,
          wNominal=dcpmData1.wNominal,
          TaNominal=dcpmData1.TaNominal,
          Ra=dcpmData1.Ra,
          TaRef=dcpmData1.TaRef,
          La=dcpmData1.La,
          Jr=dcpmData1.Jr,
          useSupport=false,
          Js=dcpmData1.Js,
          frictionParameters=dcpmData1.frictionParameters,
          coreParameters=dcpmData1.coreParameters,
          strayLoadParameters=dcpmData1.strayLoadParameters,
          brushParameters=dcpmData1.brushParameters,
          TaOperational=293.15,
          alpha20a=dcpmData1.alpha20a,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          ia(fixed=true)) annotation (Placement(transformation(extent={{0,0},{
                  20,20}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=tRamp,
          height=Va,
          startTime=tStart) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={-70,70})));
        Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-40,70})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-60,30},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J=JLoad)
          annotation (Placement(transformation(extent={{30,0},{50,20}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          loadTorque1(
          useSupport=false,
          tau_nominal=-TLoad1,
          TorqueDirection=false,
          w_nominal=wLoad1) annotation (Placement(transformation(extent={{80,0},
                  {60,20}})));
        Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm2(
          VaNominal=dcpmData2.VaNominal,
          IaNominal=dcpmData2.IaNominal,
          wNominal=dcpmData2.wNominal,
          TaNominal=dcpmData2.TaNominal,
          Ra=dcpmData2.Ra,
          TaRef=dcpmData2.TaRef,
          La=dcpmData2.La,
          Jr=dcpmData2.Jr,
          useSupport=false,
          Js=dcpmData2.Js,
          frictionParameters=dcpmData2.frictionParameters,
          coreParameters=dcpmData2.coreParameters,
          strayLoadParameters=dcpmData2.strayLoadParameters,
          brushParameters=dcpmData2.brushParameters,
          alpha20a=dcpmData2.alpha20a,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          ia(fixed=true),
          TaOperational=368.15,
          core(v(start=0))) annotation (Placement(transformation(extent={{0,-60},
                  {20,-40}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia2(J=JLoad)
          annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          loadTorque2(
          useSupport=false,
          tau_nominal=-TLoad2,
          TorqueDirection=false,
          w_nominal=wLoad2) annotation (Placement(transformation(extent={{80,-60},
                  {60,-40}})));
        parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData1
          annotation (Placement(transformation(extent={{0,60},{20,80}})));
        parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData2(
          Ra=0.03864,
          alpha20a(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
          wNominal=148.44025288212,
          TaNominal=368.15,
          frictionParameters(PRef=100),
          coreParameters(PRef=200),
          strayLoadParameters(PRef=50),
          brushParameters(V=0.5))
          annotation (Placement(transformation(extent={{0,-100},{20,-80}})));

      equation
        connect(ramp.y, signalVoltage.v)
          annotation (Line(points={{-59,70},{-52,70}}, color={0,0,255}));
        connect(signalVoltage.n, ground.p) annotation (Line(points={{-40,60},{-40,
                60},{-40,40},{-60,40}}, color={0,0,255}));
        connect(loadInertia1.flange_b, loadTorque1.flange)
          annotation (Line(points={{50,10},{60,10}}));
        connect(dcpm1.flange, loadInertia1.flange_a) annotation (Line(
            points={{20,10},{30,10}}));
        connect(loadInertia2.flange_b, loadTorque2.flange)
          annotation (Line(points={{50,-50},{60,-50}}));
        connect(dcpm2.flange, loadInertia2.flange_a) annotation (Line(
            points={{20,-50},{30,-50}}));
        connect(signalVoltage.p, dcpm1.pin_ap) annotation (Line(
            points={{-40,80},{-20,80},{-20,40},{16,40},{16,20}}, color={0,0,255}));
        connect(signalVoltage.p, dcpm2.pin_ap) annotation (Line(
            points={{-40,80},{-20,80},{-20,-20},{16,-20},{16,-40}}, color={0,0,255}));
        connect(signalVoltage.n, dcpm1.pin_an) annotation (Line(
            points={{-40,60},{-40,20},{4,20}}, color={0,0,255}));
        connect(signalVoltage.n, dcpm2.pin_an) annotation (Line(
            points={{-40,60},{-40,-40},{4,-40}}, color={0,0,255}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
              info="<html>
<strong>Test example: Investigate influence of losses on DCPM motor performance</strong><br>
Both motors are started with a voltage ramp applied to the armature, causing the DC machines to start,
and accelerating inertias. Both machines are loading with a quadratic speed dependent load torque.<br>
The first machine <code>dcpm1</code> uses default machine parameters of model <em>DC_PermanentMagnet</em>,
the second machine <code>dcpm2</code> is parametrized with additional losses:<br>
<table>
<tr><td>                            </td><td>   dcpm1</td><td>   dcpm2</td><td>     </td></tr>
<tr><td>Armature voltage            </td><td>     100</td><td>     100</td><td>    V</td></tr>
<tr><td>Armature current            </td><td>     100</td><td>     100</td><td>    A</td></tr>
<tr><td>Inner voltage               </td><td>    95.0</td><td>    94.5</td><td>    V</td></tr>
<tr><td>Nominal speed               </td><td>  1425.0</td><td>  1417.5</td><td>  rpm</td></tr>
<tr><td>Armature resistance         </td><td> 0.05000</td><td> 0.03864</td><td>  Ohm</td></tr>
<tr><td>Temperature coefficient     </td><td>     n/a</td><td> 0.00392</td><td>  1/K</td></tr>
<tr><td>Reference temperature       </td><td>     n/a</td><td>      20</td><td> degC</td></tr>
<tr><td>Operation temperature       </td><td>     n/a</td><td>      95</td><td> degC</td></tr>
<tr><td>Brush voltage drop          </td><td>     n/a</td><td>     0.5</td><td>    V</td></tr>
<tr><td>Electrical input            </td><td>  10,000</td><td>  10,000</td><td>    W</td></tr>
<tr><td>Armature copper losses      </td><td>     500</td><td>     500</td><td>    W</td></tr>
<tr><td>Core losses                 </td><td>     n/a</td><td>     200</td><td>    W</td></tr>
<tr><td>Stray load losses           </td><td>     n/a</td><td>      50</td><td>    W</td></tr>
<tr><td>Friction losses             </td><td>     n/a</td><td>     100</td><td>    W</td></tr>
<tr><td>Brush losses                </td><td>     n/a</td><td>      50</td><td>    W</td></tr>
<tr><td>Mechanical output           </td><td>   9,500</td><td>   9,100</td><td>    W</td></tr>
<tr><td>Nominal torque              </td><td>   63,66</td><td>   61,30</td><td>   Nm</td></tr>
</table>
<br>
Note: The reference values (voltage, current, speed) are already propagated to the loss records,
using the nominal operation point.<br>
See:<br>
Anton Haumer, Christian Kral, Hansj&ouml;rg Kapeller, Thomas B&auml;uml, Johannes V. Gragger<br>
<a href=\"https://www.modelica.org/events/modelica2009/Proceedings/memorystick/pages/papers/0103/0103.pdf\">
The AdvancedMachines Library: Loss Models for Electric Machines</a><br>
Modelica 2009, 7<sup>th</sup> International Modelica Conference
</html>"));
      end DCPM_withLosses;
      annotation (Documentation(info="<html>
This package contains test examples of DC machines.
</html>"));
    end DCMachines;

    package ControlledDCDrives "Test examples of controlled DC drives"
      extends Modelica.Icons.ExamplesPackage;
      model CurrentControlledDCPM
        "Current controlled DC PM drive with H-bridge from battery"
        extends Utilities.PartialControlledDCPM;
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          loadTorque(
          tau_nominal=-driveData.tauNominal,
          TorqueDirection=false,
          w_nominal=driveData.motorData.wNominal)
          annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
        Modelica.Blocks.Sources.Step step(
          offset=0,
          startTime=0.2,
          height=driveData.tauNominal) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={-110,-10})));
      equation
        connect(loadInertia.flange_b, loadTorque.flange)
          annotation (Line(points={{70,-40},{80,-40}}));
        connect(step.y, tau2i.u)
          annotation (Line(points={{-99,-10},{-82,-10}},
                                                       color={0,0,127}));
        annotation (experiment(StopTime=2, Interval=0.0001), Documentation(info="<html>
<p>This model demonstrates how a current controller for a DC PM drive works.</p>
<p>
The current controller is parameterized according to the absolute optimum.
</p>
<p>At time=0.2 s a reference torque step is applied, causing the drive to accelerate until motor torque and load torque are at an equilibrium.</p>
<p>
Further reading:
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">Tutorial at the Modelica Conference 2017</a>
</p>
</html>"),Diagram(coordinateSystem(extent={{-200,-100},{100,100}})),
          Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
      end CurrentControlledDCPM;

      model SpeedControlledDCPM
        "Speed controlled DC PM drive with H-bridge from battery"
        extends Utilities.PartialControlledDCPM;
        Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
          stepTorque=-driveData.tauNominal,
          offsetTorque=0,
          startTime=0.8)
          annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
        Utilities.LimitedPI speedController(
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          k=driveData.kpw,
          Ti=driveData.Tiw,
          constantLimits=true,
          yMax=driveData.tauMax)
          annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
        Modelica.Blocks.Continuous.FirstOrder preFilter(
          k=1,
          T=driveData.Tfw,
          initType=Modelica.Blocks.Types.Init.InitialOutput)
          annotation (Placement(transformation(extent={{-160,0},{-140,20}})));
        Modelica.Blocks.Sources.Step step(
          offset=0,
          height=driveData.motorData.wNominal,
          startTime=0.2)                       annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-190,-10})));
        Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(initType=Modelica.Blocks.Types.Init.InitialOutput,
            Rising=driveData.aMax)
          annotation (Placement(transformation(extent={{-160,-40},{-140,-20}})));
      equation
        connect(step.y, preFilter.u) annotation (Line(points={{-179,-10},{-170,-10},
                {-170,10},{-162,10}},
                                    color={0,0,127}));
        connect(loadInertia.flange_b, loadTorque.flange)
          annotation (Line(points={{70,-40},{80,-40}}));
        connect(speedSensor.w, speedController.u_m) annotation (Line(points={{50,-81},
                {50,-90},{-116,-90},{-116,-22}},   color={0,0,127}));
        connect(speedController.y, tau2i.u)
          annotation (Line(points={{-99,-10},{-82,-10}},
                                                       color={0,0,127}));
        connect(step.y, slewRateLimiter.u) annotation (Line(points={{-179,-10},{
                -170,-10},{-170,-30},{-162,-30}}, color={0,0,127}));
        connect(speedController.u, preFilter.y) annotation (Line(points={{-122,-10},
                {-130,-10},{-130,10},{-139,10}}, color={0,0,127}));
        annotation (experiment(StopTime=1, Interval=0.0001), Documentation(info="<html>
<p>This model demonstrates how a speed controller for a current controlled DC PM drive works.</p>
<p>
The inner current controller is parameterized according to the absolute optimum.
The outer control loop is formed by the speed controller which is parameterized according to the symmetrical optimum.
</p>
<p>
At time=0.2 s a reference speed step is applied, causing the drive to accelerate to the desired speed.
At time=0.8 s a load torque step is applied, causing to drive to decelerate until the speed controller brings the drive back to the desired speed.
</p>
<p>
You may try a slewRateLimiter instead of the prefilter to limit the speed rise i.e. the torque.
</p>
<p>
Further reading:
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">Tutorial at the Modelica Conference 2017</a>
</p>
</html>"),Diagram(coordinateSystem(extent={{-200,-100},{100,100}})),
          Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
      end SpeedControlledDCPM;

      model PositionControlledDCPM
        "Position controlled DC PM drive with H-bridge from battery"
        extends Utilities.PartialControlledDCPM;
        Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
          stepTorque=-driveData.tauNominal,
          offsetTorque=0,
          startTime=2.3)
          annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
        Utilities.LimitedPI speedController(
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          k=driveData.kpw,
          Ti=driveData.Tiw,
          constantLimits=true,
          yMax=driveData.tauMax)
          annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
        Utilities.LimitedPI positionController(
          constantLimits=true,
          k=driveData.kpP,
          useI=false,
          yMax=driveData.wMax,
          initType=Modelica.Blocks.Types.Init.SteadyState)
          annotation (Placement(transformation(extent={{-150,-20},{-130,0}})));
        Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={70,-70})));
        Modelica.Blocks.Sources.KinematicPTP2 kinematicPTP(
          qd_max={driveData.wMax},
          qdd_max={driveData.aMax},
          q_end={200},
          startTime=0.2)
                       annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-180,-10})));
      equation
        connect(positionController.y, speedController.u)
          annotation (Line(points={{-129,-10},{-122,-10}},
                                                       color={0,0,127}));
        connect(angleSensor.phi, positionController.u_m) annotation (Line(
              points={{70,-81},{70,-100},{-146,-100},{-146,-22}},
                                                             color={0,0,127}));
        connect(kinematicPTP.q[1], positionController.u) annotation (Line(
              points={{-169,-2},{-160,-2},{-160,-10},{-152,-10}},
                                                            color={0,0,127}));
        connect(speedSensor.flange, angleSensor.flange)
          annotation (Line(points={{50,-60},{70,-60}}));
        connect(speedSensor.w, speedController.u_m) annotation (Line(points={{50,-81},
                {50,-90},{-116,-90},{-116,-22}},   color={0,0,127}));
        connect(loadInertia.flange_b, loadTorque.flange)
          annotation (Line(points={{70,-40},{80,-40}}));
        connect(speedController.y, tau2i.u)
          annotation (Line(points={{-99,-10},{-82,-10}},
                                                       color={0,0,127}));
        annotation (experiment(StopTime=2.5, Interval=0.0001),
                                                             Documentation(info="<html>
<p>This model demonstrates how a position controller for a speed controlled DC PM drive works.</p>
<p>
The inner current controller is parameterized according to the absolute optimum.
The middle control loop is formed by the speed controller which is parameterized according to the symmetrical optimum.
The outer control loop is formed by the position controller which is parameterized to avoid an overshot in the position.
</p>
<p>
At time=0.2 s the kinematicPTP starts to prescribe the reference position with limited speed and limited acceleration.
At time=2.3 s a load torque step is applied, causing to drive to slightly leave the end position until the position controller brings the drive back to the desired position.
</p>
<p>
Further reading:
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">Tutorial at the Modelica Conference 2017</a>
</p>
</html>"),Diagram(coordinateSystem(extent={{-200,-100},{100,100}})),
          Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
      end PositionControlledDCPM;

      package Utilities "Utilities for controlled drives"
        extends Modelica.Icons.UtilitiesPackage;
        partial model PartialControlledDCPM
          "Partial controlled DC PM drive with H-bridge from battery"
          extends Modelica.Icons.Example;
          replaceable parameter DriveDataDCPM driveData constrainedby
            ControlledDCDrives.Utilities.DriveDataDCPM
            annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
          Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=driveData.JL)
            annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
          Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,-70})));
          Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
            TaOperational=driveData.motorData.TaNominal,
            VaNominal=driveData.motorData.VaNominal,
            IaNominal=driveData.motorData.IaNominal,
            wNominal=driveData.motorData.wNominal,
            TaNominal=driveData.motorData.TaNominal,
            Ra=driveData.motorData.Ra,
            TaRef=driveData.motorData.TaRef,
            La=driveData.motorData.La,
            Jr=driveData.motorData.Jr,
            frictionParameters=driveData.motorData.frictionParameters,
            phiMechanical(fixed=true),
            wMechanical(fixed=true),
            coreParameters=driveData.motorData.coreParameters,
            strayLoadParameters=driveData.motorData.strayLoadParameters,
            brushParameters=driveData.motorData.brushParameters,
            ia(fixed=true),
            Js=driveData.motorData.Js,
            alpha20a=driveData.motorData.alpha20a)
            annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
          DcdcInverter armatureInverter(
            fS=driveData.fS,
            Td=driveData.Td,
            Tmf=driveData.Tmf,
            VMax=driveData.VaMax)
            annotation (Placement(transformation(extent={{20,-20},{40,0}})));
          Battery source(
            INominal=driveData.motorData.IaNominal, V0=driveData.VBat)
            annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={30,80})));
          LimitedPI currentController(
            constantLimits=false,
            k=driveData.kpI,
            Ti=driveData.TiI,
            KFF=driveData.kPhi,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            useFF=true)
            annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
          Modelica.Blocks.Math.Gain tau2i(k=1/driveData.kPhi) annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-70,-10})));
        equation
          connect(dcpm.flange, loadInertia.flange_a)
            annotation (Line(points={{40,-40},{50,-40}}));
          connect(speedSensor.flange, dcpm.flange)
            annotation (Line(points={{50,-60},{50,-40},{40,-40}}));
          connect(armatureInverter.pin_nMot, dcpm.pin_an)
            annotation (Line(points={{24,-20},{24,-30},{24,-30}},
                                                         color={0,0,255}));
          connect(armatureInverter.pin_pMot, dcpm.pin_ap)
            annotation (Line(points={{36,-20},{36,-30},{36,-30}},
                                                         color={0,0,255}));
          connect(armatureInverter.vDC, currentController.yMaxVar)
            annotation (Line(points={{19,-4},{-28,-4}}, color={0,0,127}));
          connect(armatureInverter.vRef, currentController.y)
            annotation (Line(points={{18,-10},{-29,-10}}, color={0,0,127}));
          connect(armatureInverter.iMot, currentController.u_m) annotation (
              Line(points={{19,-16},{-20,-16},{-20,-30},{-46,-30},{-46,-22}},
                color={0,0,127}));
          connect(speedSensor.w, currentController.feedForward) annotation (Line(
                points={{50,-81},{50,-90},{-40,-90},{-40,-22}},
                                                             color={0,0,127}));
          connect(tau2i.y, currentController.u)
            annotation (Line(points={{-59,-10},{-52,-10}}, color={0,0,127}));
          connect(source.pin_n, armatureInverter.pin_nBat) annotation (Line(points={{24,70},
                  {24,70},{24,0}},             color={0,0,255}));
          connect(source.pin_p, armatureInverter.pin_pBat) annotation (Line(points={{36,70},
                  {36,60},{36,60},{36,0}},     color={0,0,255}));
          annotation (Documentation(info="<html>
  <p>This is a partial model of a controlled DC PM drive.</p>
<p>
Electrical power is taken from a battery (constant voltage with inner resistance) and fed to the motor via a DC-DC inverter.
The level of detail of the DC-DC inverter may be chosen from ideal averaging or switching.
The DC-DC inverter is commanded by the current controller.
The current controller is parameterized according to the absolute optimum.
</p>
<p>
Further reading:
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">Tutorial at the Modelica Conference 2017</a>
</p>
</html>"),  Diagram(coordinateSystem(extent={{-200,-100},{100,100}})),
            Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
        end PartialControlledDCPM;

        record DriveDataDCPM
          "Parameters of a controlled DC permanent magnet drive"
          extends Modelica.Icons.Record;
          import Modelica.Electrical.Machines.Thermal.convertResistance;
        //Motor
          parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData
            motorData "Motor data" annotation (Dialog(group="Motor"), Placement(
                transformation(extent={{-10,-10},{10,10}})));
          parameter Modelica.SIunits.Resistance Ra=convertResistance(motorData.Ra,
              motorData.TaRef,motorData.alpha20a,motorData.TaNominal)
            "Armature resistance at nominal temperature"
            annotation(Dialog(group="Motor", enable=false));
          parameter Modelica.SIunits.Time Ta=motorData.La/Ra "Armature time constant"
            annotation(Dialog(group="Motor", enable=false));
          parameter Modelica.SIunits.Power PNominal=motorData.ViNominal*motorData.IaNominal
            -motorData.frictionParameters.PRef -motorData.coreParameters.PRef -motorData.strayLoadParameters.PRef
            "Nominal mechanical output"
            annotation(Dialog(group="Motor", enable=false));
          parameter Modelica.SIunits.Torque tauNominal=PNominal/motorData.wNominal
            "Nominal torque"
            annotation(Dialog(group="Motor", enable=false));
          parameter Modelica.SIunits.ElectricalTorqueConstant kPhi=tauNominal/motorData.IaNominal
            "Torque constant"
            annotation(Dialog(group="Motor", enable=false));
          parameter Modelica.SIunits.AngularVelocity w0=motorData.wNominal*motorData.VaNominal/motorData.ViNominal
            "No-load speed"
          annotation(Dialog(group="Motor", enable=false));
        //Inverter
          parameter Modelica.SIunits.Frequency fS=2e3 "Switching frequency"
            annotation(Dialog(tab="Inverter", group="Armature inverter"));
          parameter Modelica.SIunits.Voltage VBat=VaMax "DC no-load voltage"
            annotation(Dialog(tab="Inverter", group="Armature inverter"));
          parameter Modelica.SIunits.Time Td=0.5/fS "Dead time of inverter"
            annotation(Dialog(tab="Inverter", group="Armature inverter", enable=false));
          parameter Modelica.SIunits.Time Tmf=4*Td "Measurement filter time constant"
            annotation(Dialog(tab="Inverter", group="Armature inverter", enable=false));
          parameter Modelica.SIunits.Time Tsigma=Td + Tmf "Sum of small time constants"
            annotation(Dialog(tab="Inverter", group="Armature inverter", enable=false));
        //Load
          parameter Modelica.SIunits.Inertia JL=motorData.Jr "Load inertia"
            annotation(Dialog(group="Load"));
        //Limits
          parameter Modelica.SIunits.Voltage VaMax=1.2*motorData.VaNominal "Maximum Voltage"
            annotation(Dialog(tab="Controller", group="Limits"));
          parameter Modelica.SIunits.Current IaMax=1.5*motorData.IaNominal "Maximum current"
            annotation(Dialog(tab="Controller", group="Limits"));
          parameter Modelica.SIunits.Torque tauMax=kPhi*IaMax "Maximum torque"
            annotation(Dialog(tab="Controller", group="Limits", enable=false));
          parameter Modelica.SIunits.AngularVelocity wMax=motorData.wNominal*motorData.VaNominal/motorData.ViNominal
            "Maximum speed"
            annotation(Dialog(tab="Controller", group="Limits"));
          parameter Modelica.SIunits.AngularAcceleration aMax=tauMax/(JL +motorData.Jr)
            "Maximum acceleration"
            annotation(Dialog(tab="Controller", group="Limits", enable=false));
        //Current controller: absolute optimum
          parameter Real kpI=motorData.La/(2*Tsigma) "Proportional gain" annotation (
              Dialog(
              tab="Controller",
              group="Current controller",
              enable=false));
          parameter Modelica.SIunits.Time TiI=Ta "Integral time constant"
            annotation(Dialog(tab="Controller", group="Current controller", enable=false));
          parameter Modelica.SIunits.Time Tsub=2*Tsigma "Substitute time constant"
            annotation(Dialog(tab="Controller", group="Current controller", enable=false));
        //Speed controller: symmetrical optimum
          parameter Real kpw=(JL + motorData.Jr)/(2*Tsub) "Proportional gain"
            annotation (Dialog(
              tab="Controller",
              group="Speed controller",
              enable=false));
          parameter Modelica.SIunits.Time Tiw=4*Tsub "Integral time constant"
            annotation(Dialog(tab="Controller", group="Speed controller", enable=false));
          parameter Modelica.SIunits.Time Tfw=Tiw "Filter time constant"
            annotation(Dialog(tab="Controller", group="Speed controller", enable=false));
        //Position controller
          parameter Real kpP=1/(16*Tsub) "Proportional gain"
            annotation(Dialog(tab="Controller", group="Position controller", enable=false));
          annotation (
            defaultComponentName="dcpmDriveData",
            defaultComponentPrefixes="parameter",
            Documentation(info="<html>
<p>
Calculates controller parameters of a DC permanent magnet drive:
Current controller according to absolute optimum, speed controller according to symmetric optimum.
</p>
</html>"));
        end DriveDataDCPM;

        block LimitedPI
          "Limited PI-controller with anti-windup and feed-forward"
          extends Modelica.Blocks.Interfaces.SISO;
          import Modelica.Blocks.Types.Init;
          import Modelica.Constants.inf;
          Modelica.Blocks.Interfaces.RealInput u_m "Connector of measured signal"
            annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=90,
                origin={-60,-120})));
          Modelica.Blocks.Interfaces.RealInput feedForward if useFF
            "Connector of feed-forward signal"
            annotation (
              Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=90,
                origin={0,-120}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=90,
                origin={0,-120})));
          Modelica.Blocks.Interfaces.RealInput kFF if useFF and not useConstantKFF
            "Connector of feed-forward factor" annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=90,
                origin={60,-120}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=90,
                origin={60,-120})));
          Modelica.Blocks.Interfaces.RealInput yMaxVar if not constantLimits
            "Connector of yMax input signal" annotation (Placement(transformation(
                origin={120,60},
                extent={{20,-20},{-20,20}})));
          Modelica.Blocks.Interfaces.RealInput yMinVar if not constantLimits and not symmetricLimits
            "Connector of yMin input signal" annotation (Placement(transformation(
                origin={120,-60},
                extent={{20,-20},{-20,20}})));
          output Real controlError = u - u_m
            "Control error (set point - measurement)";
          parameter Real k(unit="1")=1 "Gain";
          parameter Boolean useI=true "PI else P" annotation(Evaluate=true);
          parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=1
            "Integral time constant (T>0 required)" annotation(Dialog(enable=useI));
          parameter Boolean useFF=false "Use feed-forward?"
            annotation(Dialog(group="Feed-forward"));
          parameter Boolean useConstantKFF=true "Use constant feed-forward factor?"
            annotation(Dialog(group="Feed-forward", enable=useFF));
          parameter Real KFF(unit="1")=1 "Feed-forward gain"
            annotation(Dialog(group="Feed-forward", enable=useFF and useConstantKFF));
          parameter Boolean constantLimits=true "Use constant limits?"
            annotation(Dialog(group="Limitation"));
          parameter Boolean symmetricLimits=true "Use symmetric limits?"
            annotation(Dialog(group="Limitation"));
          parameter Real yMax = inf "Upper limit of output"
            annotation(Dialog(group="Limitation", enable=constantLimits));
          parameter Real yMin=-yMax "Lower limit of output"
            annotation(Dialog(group="Limitation", enable=constantLimits and not symmetricLimits));
          parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
            "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
            annotation(Evaluate=true,
              Dialog(group="Initialization"));
          parameter Real x_start=0 "Initial or guess value of state"
            annotation (Dialog(group="Initialization"));
          parameter Real y_start=0 "Initial value of output"
            annotation(Dialog(enable=initType == Init.SteadyState or initType == Init.InitialOutput, group=
                  "Initialization"));
          Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={-80,0})));

          Modelica.Blocks.Math.Add addAntiWindup(k1=1, k2=-1/k)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Blocks.Continuous.Integrator integrator(k=1/Ti, initType=Modelica.Blocks.Types.Init.NoInit) if useI
            annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
          Modelica.Blocks.Math.Add3 add3(
            k1=k,
            k2=k,
            k3=1)
            annotation (Placement(transformation(extent={{20,-10},{40,10}})));
          Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter
            annotation (Placement(transformation(extent={{70,-10},{90,10}})));
          Modelica.Blocks.Math.Feedback addSat annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={50,-20})));
          Modelica.Blocks.Math.Product product annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={10,-70})));
        protected
          Modelica.Blocks.Sources.Constant zeroI(k=0) if not useI
            annotation (Placement(transformation(extent={{-20,20},{0,40}})));
          Modelica.Blocks.Sources.Constant zeroFF(k=0) if not useFF
            annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
          Modelica.Blocks.Sources.Constant constantKFF(k=KFF) if not useFF or
            useConstantKFF
            annotation (Placement(transformation(extent={{90,-100},{70,-80}})));
          Modelica.Blocks.Sources.Constant yMaxConst(k=yMax) if constantLimits
            annotation (Placement(transformation(extent={{40,50},{60,70}})));
          Modelica.Blocks.Sources.Constant yMinConst(k=yMin) if constantLimits and not symmetricLimits
            annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
          Modelica.Blocks.Math.Gain gain(k=-1) if symmetricLimits annotation (
              Placement(transformation(
                extent={{-4,-4},{4,4}},
                rotation=270,
                origin={58,10})));

        initial equation
          if initType == Init.SteadyState and useI then
            der(add3.u2) = 0;
          elseif initType == Init.InitialState and useI then
            add3.u2 = x_start;
          elseif initType == Init.InitialOutput then
            add3.y = y_start;
          end if;

        equation
          connect(addAntiWindup.y, integrator.u) annotation (Line(points={{-29,-20},
                  {-22,-20}},      color={0,0,127}));
          connect(integrator.y, add3.u2) annotation (Line(points={{1,-20},{6,-20},{
                  6,0},{18,0}},
                              color={0,0,127}));
          connect(add3.y, variableLimiter.u)
            annotation (Line(points={{41,0},{68,0}}, color={0,0,127}));
          connect(variableLimiter.y, y)
            annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
          connect(add3.y, addSat.u1)
            annotation (Line(points={{41,0},{50,0},{50,-12}}, color={0,0,127}));
          connect(variableLimiter.y, addSat.u2) annotation (Line(points={{91,0},{94,
                  0},{94,-20},{58,-20}},
                                     color={0,0,127}));
          connect(add3.u2, zeroI.y) annotation (Line(points={{18,0},{6,0},{6,30},{1,30}},
                         color={0,0,127}));
          connect(u, feedback.u1)
            annotation (Line(points={{-120,0},{-88,0}}, color={0,0,127}));
          connect(feedback.y, add3.u1) annotation (Line(points={{-71,0},{-60,0},{
                  -60,8},{18,8}},
                           color={0,0,127}));
          connect(feedback.y, addAntiWindup.u1) annotation (Line(points={{-71,0},{
                  -60,0},{-60,-14},{-52,-14}},
                                        color={0,0,127}));
          connect(u_m, feedback.u2) annotation (Line(points={{-60,-120},{-60,-90},{
                  -80,-90},{-80,-8}},
                             color={0,0,127}));
          connect(addSat.y, addAntiWindup.u2) annotation (Line(points={{50,-29},{50,
                  -40},{-60,-40},{-60,-26},{-52,-26}}, color={0,0,127}));
          connect(yMinVar, variableLimiter.limit2) annotation (Line(points={{120,
                  -60},{64,-60},{64,-8},{68,-8}}, color={0,0,127}));
          connect(variableLimiter.limit2, yMinConst.y) annotation (Line(points={{68,
                  -8},{64,-8},{64,-60},{61,-60}}, color={0,0,127}));
          connect(yMaxVar, variableLimiter.limit1) annotation (Line(points={{120,60},
                  {64,60},{64,8},{68,8}}, color={0,0,127}));
          connect(variableLimiter.limit1, yMaxConst.y) annotation (Line(points={{68,
                  8},{64,8},{64,60},{61,60}}, color={0,0,127}));
          connect(variableLimiter.limit2, gain.y)
            annotation (Line(points={{68,-8},{58,-8},{58,5.6}}, color={0,0,127}));
          connect(variableLimiter.limit1, gain.u) annotation (Line(points={{68,8},{
                  64,8},{64,20},{58,20},{58,14.8}},
                                              color={0,0,127}));
          connect(product.y, add3.u3)
            annotation (Line(points={{10,-59},{10,-8},{18,-8}}, color={0,0,127}));
          connect(feedForward, product.u1) annotation (Line(points={{0,-120},{0,-90},{4,
                  -90},{4,-82}}, color={0,0,127}));
          connect(product.u1, zeroFF.y)
            annotation (Line(points={{4,-82},{4,-90},{-9,-90}}, color={0,0,127}));
          connect(constantKFF.y, product.u2)
            annotation (Line(points={{69,-90},{16,-90},{16,-82}}, color={0,0,127}));
          connect(product.u2, kFF) annotation (Line(points={{16,-82},{16,-90},{60,-90},{
                  60,-120}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Polygon(
                  points={{-80,90},{-88,68},{-72,68},{-80,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
                Line(visible=useI, points={{-80,-80},{-80,-20},{40.8594,66.3281},
                      {60,66}},                                          color = {0,0,127}),
                Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
                Polygon(
                  points={{90,-80},{68,-72},{68,-88},{90,-80}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{0,6},{60,-56}},
                  lineColor={192,192,192},
                  textString="PI", visible=useI),
                Text(
                  extent={{0,6},{60,-56}},
                  lineColor={192,192,192},
                  textString="P", visible=not useI),
                Line(visible=not useI, points={{-80,-80},{-80,24},{56,24}},  color = {0,0,127})}),
                                                       Diagram(
                coordinateSystem(preserveAspectRatio=false)),
            Documentation(info="<html>
<p>
Proportional - Integral - controller with optional feed-forward and limitation at the output.
</p>
<p>
The integral part can be switched off to obtain a limited P-controller.
</p>
<p>
The feed-forward gain can either be constant or given by the optional input kFF.
</p>
<p>
When the output is limited, the controller cannot bring the control error to zero and the integrator will not stop integrating.
To avoid this <strong>WindUp</strong> - effect, an <strong>Anti-WindUp</strong> loop is implemented:
The difference between unlimited and limited output is fed back to the integrator's input.
</p>
</html>"));
        end LimitedPI;

        model Battery "Simple battery model"
          parameter Modelica.SIunits.Voltage V0 "No-load voltage";
          parameter Modelica.SIunits.Current INominal "Nominal current";
          parameter Modelica.SIunits.Resistance Ri=0.05*V0/INominal "Inner resistance";
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
            annotation (Placement(transformation(extent={{50,110},{70,90}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
            annotation (Placement(transformation(extent={{-70,110},{-50,90}})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-90,80})));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=V0)
            annotation (Placement(transformation(extent={{10,50},{-10,70}})));
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=Ri)
            annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={60,70})));
        equation
          connect(ground.p, pin_n)
            annotation (Line(points={{-80,80},{-60,80},{-60,100}}, color={0,0,255}));
          connect(pin_n, constantVoltage.n)
            annotation (Line(points={{-60,100},{-60,60},{-10,60}}, color={0,0,255}));
          connect(constantVoltage.p, resistor.p)
            annotation (Line(points={{10,60},{60,60}}, color={0,0,255}));
          connect(resistor.n, pin_p)
            annotation (Line(points={{60,80},{60,100}}, color={0,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                Text(
                extent={{-120,-100},{120,-140}},
                textString="%name",
                lineColor={0,0,255}),           Text(
                extent={{-100,-60},{100,-80}},
                lineColor={0,0,255},
                  textString="V0=%V0"),
                Rectangle(extent={{-70,90},{-50,80}}, lineColor={28,108,200}),
                Rectangle(
                  extent={{50,90},{70,80}},
                  lineColor={28,108,200},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-100,80},{100,-40}},
                  lineColor={28,108,200},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid,
                  radius=10),
                Rectangle(
                  extent={{-92,72},{-4,-32}},
                  lineColor={28,108,200},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{4,72},{92,-32}},
                  lineColor={28,108,200},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid)}),                      Diagram(
                coordinateSystem(preserveAspectRatio=false)),
            Documentation(info="<html>
<p>
This is a simple model of a DC-source resp. battery, consisting of a constant DC-voltage and an inner resistance.
</p>
</html>"));
        end Battery;

        model DcdcInverter "DC-DC inverter"
          parameter Boolean useIdealInverter=true "Use ideal averaging inverter, otherwise switching inverter";
          parameter Modelica.SIunits.Frequency fS "Switching frequency";
          parameter Modelica.SIunits.Time Td=0.5/fS "Dead time";
          parameter Modelica.SIunits.Time Tmf=2/fS "Measurement filter time constant";
          parameter Modelica.SIunits.Voltage VMax "Maximum Voltage";
          parameter Modelica.SIunits.Time Ti=1e-6 "Time constant of integral power controller"
            annotation(Dialog(group="Averaging", enable=useIdealInverter));
          parameter Modelica.SIunits.Resistance RonT=1e-05
            "Transistor closed resistance"
            annotation (Dialog(group="Switching", enable=not useIdealInverter));
          parameter Modelica.SIunits.Conductance GoffT=1e-05
            "Transistor opened conductance"
            annotation (Dialog(group="Switching", enable=not useIdealInverter));
          parameter Modelica.SIunits.Voltage VkneeT=0
            "Transistor threshold voltage"
            annotation (Dialog(group="Switching", enable=not useIdealInverter));
          parameter Modelica.SIunits.Resistance RonD=1e-05
            "Diode closed resistance"
            annotation (Dialog(group="Switching", enable=not useIdealInverter));
          parameter Modelica.SIunits.Conductance GoffD=1e-05
            "Diode opened conductance"
            annotation (Dialog(group="Switching", enable=not useIdealInverter));
          parameter Modelica.SIunits.Voltage VkneeD=0 "Diode threshold voltage"
            annotation (Dialog(group="Switching", enable=not useIdealInverter));
          output Modelica.SIunits.Power pDC=vDC*iDC "DC power (from battery)";
          output Modelica.SIunits.Power pMot=vMot*iMot "Power to motor";
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_pBat
            annotation (Placement(transformation(extent={{50,110},{70,90}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_nBat annotation (
              Placement(transformation(extent={{-70,110},{-50,90}}),
                iconTransformation(extent={{-70,110},{-50,90}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_pMot
            annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_nMot
            annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));

          Modelica.Blocks.Interfaces.RealInput vRef
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput vDC annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-110,60})));
          Modelica.Blocks.Interfaces.RealOutput iDC annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={110,60})));

          Modelica.Blocks.Interfaces.RealOutput vMot annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={110,-60})));
          Modelica.Blocks.Interfaces.RealOutput iMot annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-110,-60})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor vDCSensor annotation (
              Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,100})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor iMotSensor
            annotation (Placement(transformation(extent={{-50,-70},{-30,-90}})));
          Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter
            annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
          Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=270,
                origin={-90,20})));
          Modelica.Blocks.Continuous.FirstOrder vDCFilter(
            k=1,
            T=Tmf,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            y_start=VMax)
            annotation (Placement(transformation(extent={{-60,50},{-80,70}})));
          Modelica.Blocks.Continuous.FirstOrder iMotFilter(
            k=1,
            T=Tmf,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            y_start=0)
            annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
          IdealDcDc idealDcDc(Td=Td, Ti=Ti) if useIdealInverter
            annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
          SwitchingDcDc switchingDcDc(
            fS=fS,
            VMax=VMax,
            RonT=RonT,
            GoffT=GoffT,
            VkneeT=VkneeT,
            RonD=RonD,
            GoffD=GoffD,
            VkneeD=VkneeD) if not useIdealInverter
            annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor iDCSensor
            annotation (Placement(transformation(extent={{50,70},{30,90}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor vMotSensor annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={0,-100})));
          Modelica.Blocks.Continuous.FirstOrder vMotFilter(
            k=1,
            T=Tmf,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            y_start=0)
            annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
          Modelica.Blocks.Continuous.FirstOrder iDCFilter(
            k=1,
            T=Tmf,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            y_start=VMax)
            annotation (Placement(transformation(extent={{60,50},{80,70}})));
        equation
          connect(iMotSensor.p, pin_nMot) annotation (Line(points={{-50,-80},{
                  -60,-80},{-60,-100}},
                              color={0,0,255}));
          connect(vRef, variableLimiter.u)
            annotation (Line(points={{-120,0},{-72,0}}, color={0,0,127}));
          connect(gain.y, variableLimiter.limit2)
            annotation (Line(points={{-90,13.4},{-90,-8},{-72,-8}}, color={0,0,127}));
          connect(iMotSensor.i, iMotFilter.u)
            annotation (Line(points={{-40,-69},{-40,-60},{-58,-60}}, color={0,0,127}));
          connect(iMotFilter.y, iMot)
            annotation (Line(points={{-81,-60},{-110,-60}}, color={0,0,127}));
          connect(vDCFilter.y, vDC)
            annotation (Line(points={{-81,60},{-110,60}}, color={0,0,127}));
          connect(vDCFilter.y, gain.u)
            annotation (Line(points={{-81,60},{-90,60},{-90,27.2}}, color={0,0,127}));
          connect(vDCFilter.y, variableLimiter.limit1) annotation (Line(points={{-81,60},
                  {-90,60},{-90,40},{-80,40},{-80,8},{-72,8}}, color={0,0,127}));
          connect(variableLimiter.y, idealDcDc.vRef) annotation (Line(points={{-49,0},{-40,
                  0},{-40,-20},{8,-20}},              color={0,0,127}));
          connect(variableLimiter.y, switchingDcDc.vRef) annotation (Line(
                points={{-49,0},{-40,0},{-40,20},{-32,20}}, color={0,0,127}));
          connect(vDCFilter.y, switchingDcDc.vMax) annotation (Line(points={{-81,60},{-90,
                  60},{-90,40},{-40,40},{-40,26},{-32,26}}, color={0,0,127}));
          connect(iDCSensor.p, pin_pBat)
            annotation (Line(points={{50,80},{60,80},{60,100}}, color={0,0,255}));
          connect(iMotSensor.n, switchingDcDc.pin_nMot)
            annotation (Line(points={{-30,-80},{-30,-80},{-30,10}}, color={0,0,255}));
          connect(vMotFilter.y, vMot)
            annotation (Line(points={{81,-60},{110,-60}}, color={0,0,127}));
          connect(iDCSensor.i, iDCFilter.u)
            annotation (Line(points={{40,69},{40,60},{58,60}}, color={0,0,127}));
          connect(iDCFilter.y, iDC)
            annotation (Line(points={{81,60},{110,60}}, color={0,0,127}));
          connect(idealDcDc.pin_pBat, iDCSensor.n)
            annotation (Line(points={{30,-10},{30,80}}, color={0,0,255}));
          connect(pin_nBat, switchingDcDc.pin_nBat)
            annotation (Line(points={{-60,100},{-30,100},{-30,30}}, color={0,0,255}));
          connect(pin_nBat, idealDcDc.pin_nBat) annotation (Line(points={{-60,100},
                  {-30,100},{-30,80},{10,80},{10,-10}},
                                                   color={0,0,255}));
          connect(iDCSensor.n, switchingDcDc.pin_pBat) annotation (Line(points={{30,80},
                  {30,40},{-10,40},{-10,30}}, color={0,0,255}));
          connect(iMotSensor.n, idealDcDc.pin_nMot) annotation (Line(points={{-30,-80},{
                  -30,-40},{10,-40},{10,-30}}, color={0,0,255}));
          connect(idealDcDc.pin_pMot, pin_pMot) annotation (Line(points={{30,
                  -30.2},{30,-80},{60,-80},{60,-100}},
                                            color={0,0,255}));
          connect(pin_pMot, switchingDcDc.pin_pMot) annotation (Line(points={{60,-100},
                  {60,-80},{-10,-80},{-10,10}},color={0,0,255}));
          connect(pin_nBat, vDCSensor.n)
            annotation (Line(points={{-60,100},{-10,100}}, color={0,0,255}));
          connect(pin_pBat, vDCSensor.p)
            annotation (Line(points={{60,100},{10,100}}, color={0,0,255}));
          connect(pin_nMot, vMotSensor.n)
            annotation (Line(points={{-60,-100},{-10,-100}}, color={0,0,255}));
          connect(pin_pMot, vMotSensor.p)
            annotation (Line(points={{60,-100},{10,-100}}, color={0,0,255}));
          connect(vMotFilter.u, vMotSensor.v)
            annotation (Line(points={{58,-60},{0,-60},{0,-89}}, color={0,0,127}));
          connect(vDCFilter.u, vDCSensor.v)
            annotation (Line(points={{-58,60},{0,60},{0,89}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-98,20},{98,-20}},
                  lineColor={0,0,255},
                  textString="%name"),
                Text(
                  extent={{-40,80},{40,60}},
                  lineColor={128,128,128},
                  textString="Bat"),
                Text(
                  extent={{-40,-60},{40,-80}},
                  lineColor={128,128,128},
                  textString="Mot"),
                Line(points={{-20,-20},{-100,-100}}, color={0,0,255}),
                Line(points={{100,100},{20,20}},     color={0,0,255}),
                Rectangle(visible=not useIdealInverter,
                  extent={{-98,98},{98,-98}},
                  lineColor={217,67,180}),
                Line(visible=not useIdealInverter, points={{-20,-20},{-98,-98}},   color={217,67,180}),
                Line(visible=not useIdealInverter, points={{98,98},{20,20}},       color={217,67,180}),
                Text(
                  extent={{-100,70},{-80,50}},
                  lineColor={128,128,128},
                  textString="v"),
                Text(
                  extent={{80,-50},{100,-70}},
                  lineColor={128,128,128},
                  textString="v"),
                Text(
                  extent={{80,70},{100,50}},
                  lineColor={128,128,128},
                  textString="i"),
                Text(
                  extent={{-100,-50},{-80,-70}},
                  lineColor={128,128,128},
                  textString="i")}),                                     Diagram(
                coordinateSystem(preserveAspectRatio=false)),
            Documentation(info="<html>
<p>This is a model of a DC-DC inverter. The level of detail of the DC-DC inverter may be chosen from ideal averaging or switching.</p>
<p>Reference voltage is limited to actual battery voltage.</p>
<p>Battery voltage and motor current are measured.</p>
</html>"));
        end DcdcInverter;

        model IdealDcDc "Ideal DC-DC inverter"
          parameter Modelica.SIunits.Time Td "Dead time";
          parameter Modelica.SIunits.Time Ti=1e-6 "Time constant of integral power controller";
          Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
            annotation (Placement(transformation(extent={{10,-80},{-10,-60}})));
          Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={0,70})));
          Modelica.Electrical.Analog.Sensors.PowerSensor powerBat
            annotation (Placement(transformation(extent={{40,80},{20,60}})));
          Modelica.Electrical.Analog.Sensors.PowerSensor powerMot annotation (Placement(
                transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={30,-70})));
          Modelica.Blocks.Continuous.FirstOrder deadTime(
            k=1,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            y_start=0,
            T=Td) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
          Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={50,0})));
          Modelica.Blocks.Continuous.Integrator powerController(
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            y_start=0,
            k=1/Ti) annotation (Placement(transformation(extent={{30,10},{10,30}})));
          Modelica.Electrical.Analog.Basic.Ground groundMotor annotation (Placement(
                transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={-80,-80})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_nBat annotation (
              Placement(transformation(extent={{-110,110},{-90,90}}),
                iconTransformation(extent={{-110,110},{-90,90}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_pBat
            annotation (Placement(transformation(extent={{90,110},{110,90}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_nMot
            annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_pMot
            annotation (Placement(transformation(extent={{90,-112},{110,-92}})));
          Modelica.Blocks.Interfaces.RealInput vRef
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        equation
          connect(signalCurrent.p, powerBat.nc)
            annotation (Line(points={{10,70},{20,70}},         color={0,0,255}));
          connect(powerBat.pv, powerBat.pc)
            annotation (Line(points={{30,60},{40,60},{40,70}}, color={0,0,255}));
          connect(signalVoltage.p, powerMot.pc)
            annotation (Line(points={{10,-70},{20,-70}},          color={0,0,255}));
          connect(powerMot.pc, powerMot.pv)
            annotation (Line(points={{20,-70},{20,-60},{30,-60}}, color={0,0,255}));
          connect(powerBat.power, feedback.u2) annotation (Line(points={{40,81},
                  {40,88},{70,88},{70,-4.44089e-16},{58,-4.44089e-16}},
                                          color={0,0,127}));
          connect(powerMot.power, feedback.u1) annotation (Line(points={{20,-81},
                  {20,-88},{50,-88},{50,-8}},
                                     color={0,0,127}));
          connect(feedback.y, powerController.u) annotation (Line(points={{50,9},
                  {50,20},{32,20}}, color={0,0,127}));
          connect(powerController.y, signalCurrent.i)
            annotation (Line(points={{9,20},{0,20},{0,58}}, color={0,0,127}));
          connect(pin_nBat, signalCurrent.n) annotation (Line(points={{-100,100},
                  {-100,70},{-10,70}},          color={0,0,255}));
          connect(pin_pBat, powerBat.pc) annotation (Line(points={{100,100},{
                  100,70},{40,70}}, color={0,0,255}));
          connect(pin_nBat, powerBat.nv) annotation (Line(points={{-100,100},{
                  30,100},{30,80}}, color={0,0,255}));
          connect(pin_nMot, powerMot.nv) annotation (Line(points={{-100,-100},{
                  30,-100},{30,-80}}, color={0,0,255}));
          connect(pin_pMot, powerMot.nc) annotation (Line(points={{100,-102},{
                  100,-70},{40,-70}},
                                  color={0,0,255}));
          connect(pin_nMot, groundMotor.p) annotation (Line(points={{-100,-100},
                  {-100,-80},{-90,-80}},color={0,0,255}));
          connect(deadTime.y, signalVoltage.v)
            annotation (Line(points={{-9,0},{0,0},{0,-58}}, color={0,0,127}));
          connect(vRef, deadTime.u)
            annotation (Line(points={{-120,0},{-32,0}}, color={0,0,127}));
          connect(signalVoltage.n, pin_nMot) annotation (Line(points={{-10,-70},
                  {-100,-70},{-100,-100}},
                                         color={0,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{100,100},{20,20}},     color={0,0,255}),
                Line(points={{-20,-20},{-100,-100}}, color={0,0,255}),
                Text(
                  extent={{-40,80},{40,60}},
                  lineColor={128,128,128},
                  textString="Bat"),
                Text(
                  extent={{-100,20},{100,-20}},
                  lineColor={0,0,255},
                  textString="%name"),
                Text(
                  extent={{-40,-60},{40,-80}},
                  lineColor={128,128,128},
                  textString="Mot")}),                                   Diagram(
                coordinateSystem(preserveAspectRatio=false)),
            Documentation(info="<html>
<p>This is a model of an ideal DC-DC inverter based on a power balance achieved by an integral controller.</p>
</html>"));
        end IdealDcDc;

        model SwitchingDcDc "Switching DC-DC inverter"
          parameter Modelica.SIunits.Frequency fS "Switching frequency";
          parameter Modelica.SIunits.Voltage VMax "Maximum Voltage";
          parameter Modelica.SIunits.Resistance RonT=1e-05
            "Transistor closed resistance";
          parameter Modelica.SIunits.Conductance GoffT=1e-05
            "Transistor opened conductance";
          parameter Modelica.SIunits.Voltage VkneeT=0
            "Transistor threshold voltage";
          parameter Modelica.SIunits.Resistance RonD=1e-05
            "Diode closed resistance";
          parameter Modelica.SIunits.Conductance GoffD=1e-05
            "Diode opened conductance";
          parameter Modelica.SIunits.Voltage VkneeD=0 "Diode threshold voltage";
          Modelica.Electrical.PowerConverters.DCDC.Control.VoltageToDutyCycle
            adaptor(useConstantMaximumVoltage=false, vMax=VMax)
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM pwm(
              useConstantDutyCycle=false, f=fS) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-30,-20})));
          Modelica.Electrical.PowerConverters.DCDC.HBridge dcdc(
            RonTransistor=RonT,
            GoffTransistor=GoffT,
            VkneeTransistor=VkneeT,
            RonDiode=RonD,
            GoffDiode=GoffD,
            VkneeDiode=VkneeD)                                  annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={0,-20})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_nBat annotation (
              Placement(transformation(extent={{-110,110},{-90,90}}),
                iconTransformation(extent={{-110,110},{-90,90}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_pBat
            annotation (Placement(transformation(extent={{90,110},{110,90}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_pMot
            annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_nMot
            annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
          Modelica.Blocks.Interfaces.RealInput vRef
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealInput vMax
            annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
        equation
          connect(adaptor.dutyCycle, pwm.dutyCycle)
            annotation (Line(points={{-39,0},{-30,0},{-30,-8}},
                                                           color={0,0,127}));
          connect(pwm.fire, dcdc.fire_p)
            annotation (Line(points={{-19,-14},{-12,-14}},
                                                         color={255,0,255}));
          connect(pwm.notFire, dcdc.fire_n)
            annotation (Line(points={{-19,-26},{-12,-26}},
                                                         color={255,0,255}));
          connect(pin_nBat, dcdc.dc_n1) annotation (Line(points={{-100,100},{-100,70},{-6,
                  70},{-6,-10}},                       color={0,0,255}));
          connect(pin_pBat, dcdc.dc_p1) annotation (Line(points={{100,100},{100,70},{6,70},
                  {6,-10}},              color={0,0,255}));
          connect(dcdc.dc_p2, pin_pMot) annotation (Line(points={{6,-30},{6,-70},
                  {100,-70},{100,-100}},    color={0,0,255}));
          connect(pin_nMot, dcdc.dc_n2) annotation (Line(points={{-100,-100},{
                  -100,-68},{-6,-68},{-6,-30}},
                                  color={0,0,255}));
          connect(vRef, adaptor.v)
            annotation (Line(points={{-120,0},{-62,0}}, color={0,0,127}));
          connect(vMax, adaptor.vMaxExt)
            annotation (Line(points={{-120,60},{-50,60},{-50,12}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                  extent={{-98,98},{98,-98}},
                  lineColor={217,67,180},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{98,98},{20,20}},       color={217,67,180}),
                Line(points={{-20,-20},{-98,-98}},   color={217,67,180}),
                Text(
                  extent={{-40,80},{40,60}},
                  lineColor={128,128,128},
                  textString="Bat"),
                Text(
                  extent={{-100,20},{100,-20}},
                  lineColor={0,0,255},
                  textString="%name"),
                Text(
                  extent={{-40,-60},{40,-80}},
                  lineColor={128,128,128},
                  textString="Mot")}),                                   Diagram(
                coordinateSystem(preserveAspectRatio=false)),
            Documentation(info="<html>
<p>This is a model of a switching DC-DC inverter based on a H-bridge.</p>
</html>"));
        end SwitchingDcDc;

        annotation (Documentation(info="<html>
<p>This package contains utilities for controlled drives</p>
</html>"));
      end Utilities;
      annotation (Documentation(info="<html>
This package contains test examples demonstrating control of electric drives.
</html>"));
    end ControlledDCDrives;

    package Transformers "Test examples of transformers"
      extends Modelica.Icons.ExamplesPackage;
      model TransformerTestbench "Transformer test bench"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Resistance RL[3]=fill(1/3, 3)
          "Load resistance";
        Modelica.Electrical.MultiPhase.Sources.SineVoltage source(freqHz=fill(
              50, 3), V=fill(sqrt(2/3)*100, 3)) annotation (Placement(
              transformation(
              origin={-90,-10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star starS annotation (Placement(
              transformation(
              origin={-90,-40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundS annotation (Placement(
              transformation(extent={{-100,-80},{-80,-60}})));
        Machines.Sensors.ElectricalPowerSensor electricalPowerSensorS
          annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorS
          annotation (Placement(transformation(extent={{-60,20},{-40,0}})));
        Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensorS
          annotation (Placement(transformation(
              origin={-50,-30},
              extent={{-10,10},{10,-10}},
              rotation=180)));
        Modelica.Electrical.MultiPhase.Basic.Delta deltaS annotation (Placement(
              transformation(
              origin={-50,-10},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.Analog.Basic.Resistor earth(R=1e6) annotation (
            Placement(transformation(
              origin={0,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundT annotation (Placement(
              transformation(extent={{-10,-80},{10,-60}})));
        Machines.Sensors.VoltageQuasiRMSSensor voltageRMSSensorL annotation (
            Placement(transformation(
              origin={50,-30},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.MultiPhase.Basic.Delta deltaL annotation (Placement(
              transformation(
              origin={50,-10},
              extent={{-10,10},{10,-10}},
              rotation=180)));
        Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorL
          annotation (Placement(transformation(extent={{40,20},{60,0}})));
        Machines.Sensors.ElectricalPowerSensor electricalPowerSensorL
          annotation (Placement(transformation(extent={{70,0},{90,20}})));
        Modelica.Electrical.MultiPhase.Basic.Resistor load(R=RL) annotation (
            Placement(transformation(
              origin={90,-10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star starL annotation (Placement(
              transformation(
              origin={90,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundL annotation (Placement(
              transformation(extent={{80,-80},{100,-60}})));
        parameter Machines.Utilities.TransformerData transformerData(
          C1=Modelica.Utilities.Strings.substring(
                    transformer.VectorGroup,
                    1,
                    1),
          C2=Modelica.Utilities.Strings.substring(
                    transformer.VectorGroup,
                    2,
                    2),
          f=50,
          V1=100,
          V2=100,
          SNominal=30E3,
          v_sc=0.05,
          P_sc=300) annotation (Placement(transformation(extent={{-10,40},{10,
                  60}})));
        BasicMachines.Transformers.Dy.Dy01 transformer(
          n=transformerData.n,
          R1=transformerData.R1,
          L1sigma=transformerData.L1sigma,
          R2=transformerData.R2,
          L2sigma=transformerData.L2sigma,
          T1Ref=293.15,
          alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T2Ref=293.15,
          alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T1Operational=293.15,
          T2Operational=293.15) annotation (Placement(transformation(extent={{-20,
                  -10},{20,30}})));

      initial equation
        transformer.i2[1:2] = zeros(2);
      equation
        connect(starS.pin_n, groundS.p)
          annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
        connect(source.plug_n, starS.plug_p)
          annotation (Line(points={{-90,-20},{-90,-30}}, color={0,0,255}));
        connect(starL.pin_n, groundL.p)
          annotation (Line(points={{90,-50},{90,-60}}, color={0,0,255}));
        connect(load.plug_n, starL.plug_p)
          annotation (Line(points={{90,-20},{90,-30}}, color={0,0,255}));
        connect(earth.n, groundT.p)
          annotation (Line(points={{0,-50},{0,-50},{0,-60}}, color={0,0,255}));
        connect(electricalPowerSensorS.plug_nv, starS.plug_p) annotation (Line(
              points={{-80,0},{-80,-30},{-90,-30}}, color={0,0,255}));
        connect(source.plug_p, electricalPowerSensorS.plug_p)
          annotation (Line(points={{-90,0},{-90,10}}, color={0,0,255}));
        connect(electricalPowerSensorS.plug_ni, currentQuasiRMSSensorS.plug_p)
          annotation (Line(points={{-70,10},{-60,10}}, color={0,0,255}));
        connect(currentQuasiRMSSensorL.plug_n, electricalPowerSensorL.plug_p)
          annotation (Line(points={{60,10},{70,10}}, color={0,0,255}));
        connect(electricalPowerSensorL.plug_ni, load.plug_p)
          annotation (Line(points={{90,10},{90,0}}, color={0,0,255}));
        connect(electricalPowerSensorL.plug_nv, starL.plug_p) annotation (Line(
              points={{80,0},{80,-30},{90,-30}}, color={0,0,255}));
        connect(currentQuasiRMSSensorS.plug_n, transformer.plug1) annotation (
            Line(
            points={{-40,10},{-20,10}}, color={0,0,255}));
        connect(transformer.plug2, currentQuasiRMSSensorL.plug_p) annotation (
            Line(
            points={{20,10},{40,10}}, color={0,0,255}));
        connect(deltaS.plug_p, voltageQuasiRMSSensorS.plug_n) annotation (Line(
            points={{-60,-10},{-60,-30}}, color={0,0,255}));
        connect(deltaS.plug_n, voltageQuasiRMSSensorS.plug_p) annotation (Line(
            points={{-40,-10},{-40,-30}}, color={0,0,255}));
        connect(currentQuasiRMSSensorS.plug_n, deltaS.plug_n) annotation (Line(
            points={{-40,10},{-40,-10}}, color={0,0,255}));
        connect(currentQuasiRMSSensorL.plug_p, deltaL.plug_n) annotation (Line(
            points={{40,10},{40,-10}}, color={0,0,255}));
        connect(deltaL.plug_n, voltageRMSSensorL.plug_p) annotation (Line(
            points={{40,-10},{40,-30}}, color={0,0,255}));
        connect(deltaL.plug_p, voltageRMSSensorL.plug_n) annotation (Line(
            points={{60,-10},{60,-30}}, color={0,0,255}));
        annotation (Documentation(info="<html>
<h4>Transformer test bench:</h4>
<p>
You may choose different connections as well as vary the load (even not symmetrical).
</p>
<p>
<strong>Please pay attention</strong> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).
</p>
<p>
In some cases it may be necessary to ground the transformer's starpoint even though the source's or load's starpoint are grounded:
</p>
<ul>
<li>Yy ... Grounding of transformer's primary or secondary starpoint with reasonable high earthing resistance is necessary.</li>
<li>Yd ... No grounding necessary.</li>
<li>Yz ... Grounding of transformer's primary starpoint with reasonable high earthing resistance is necessary.</li>
<li>Dy ... No grounding necessary.</li>
<li>Dd ... No grounding necessary.</li>
<li>Dz ... No grounding necessary.</li>
</ul>
</html>"), experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6));
      end TransformerTestbench;

      model AsymmetricalLoad "Asymmetrical load"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Resistance RL=1 "Load resistance";
        Modelica.Electrical.MultiPhase.Sources.SineVoltage source(freqHz=fill(
              50, 3), V=fill(sqrt(2/3)*100, 3)) annotation (Placement(
              transformation(
              origin={-90,-10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star starS annotation (Placement(
              transformation(
              origin={-90,-40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundS annotation (Placement(
              transformation(extent={{-100,-80},{-80,-60}})));
        Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensorS
          annotation (Placement(transformation(extent={{-60,20},{-40,0}})));
        Modelica.Electrical.Analog.Basic.Ground groundL annotation (Placement(
              transformation(extent={{0,-80},{20,-60}})));
        parameter Machines.Utilities.TransformerData transformerData(
          C1=Modelica.Utilities.Strings.substring(
                    transformer.VectorGroup,
                    1,
                    1),
          C2=Modelica.Utilities.Strings.substring(
                    transformer.VectorGroup,
                    2,
                    2),
          f=50,
          V1=100,
          V2=100,
          SNominal=30E3,
          v_sc=0.05,
          P_sc=300) annotation (Placement(transformation(extent={{-10,40},{10,
                  60}})));
        BasicMachines.Transformers.Dy.Dy01 transformer(
          n=transformerData.n,
          R1=transformerData.R1,
          L1sigma=transformerData.L1sigma,
          R2=transformerData.R2,
          L2sigma=transformerData.L2sigma,
          T1Ref=293.15,
          alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T2Ref=293.15,
          alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T1Operational=293.15,
          T2Operational=293.15) annotation (Placement(transformation(extent={{-20,
                  -10},{20,30}})));

        Modelica.Electrical.MultiPhase.Basic.PlugToPin_n plugToPin_n(k=1)
          annotation (Placement(transformation(extent={{20,0},{40,20}})));
        Analog.Basic.Resistor load(R=RL) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={50,0})));
        Analog.Basic.Resistor earth(R=1e6) annotation (Placement(transformation(
              origin={-10,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Analog.Basic.Ground groundT annotation (Placement(transformation(extent=
                 {{-20,-80},{0,-60}})));
      initial equation
        transformer.i2[1] = 0;
      equation
        connect(starS.pin_n, groundS.p)
          annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
        connect(source.plug_n, starS.plug_p)
          annotation (Line(points={{-90,-20},{-90,-30}}, color={0,0,255}));
        connect(currentSensorS.plug_n, transformer.plug1) annotation (Line(
            points={{-40,10},{-20,10}}, color={0,0,255}));
        connect(transformer.plug2, plugToPin_n.plug_n) annotation (Line(
            points={{20,10},{28,10}}, color={0,0,255}));
        connect(transformer.starpoint2, groundL.p) annotation (Line(
            points={{10,-10},{10,-60}}, color={0,0,255}));
        connect(load.p, plugToPin_n.pin_n) annotation (Line(
            points={{50,10},{32,10}}, color={0,0,255}));
        connect(transformer.starpoint2, load.n) annotation (Line(
            points={{10,-10},{50,-10}}, color={0,0,255}));
        connect(source.plug_p, currentSensorS.plug_p) annotation (Line(
            points={{-90,0},{-90,10},{-60,10}}, color={0,0,255}));
        connect(earth.n, groundT.p) annotation (Line(points={{-10,-50},{-10,-50},
                {-10,-60}}, color={0,0,255}));
        annotation (Documentation(info="<html>
<h4>Asymmetrical (singlephase) load:</h4>
<p>
You may choose different connections.
</p>
<p>
<strong>Please pay attention</strong> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).
</p>
<p>
In some cases it may be necessary to ground the transformer's starpoint even though the source's or load's starpoint are grounded:
</p>
<ul>
<li>Yy with primary starpoint connected to source's starpoint: primary current in only one phase</li>
<li>Yy primary starpoint  not connected to source's starpoint: secondary voltage breaks down</li>
<li>Yz ... Grounding of transformer's primary starpoint with reasonable high earthing resistance is necessary.</li>
<li>Dy ... Load current in two   primary phases.</li>
<li>Dz ... Load current in three primary phases.</li>
</ul>
</html>"), experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6));
      end AsymmetricalLoad;

      model Rectifier6pulse "6-pulse rectifier with 1 transformer"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage V=100*sqrt(2/3)
          "Amplitude of star-voltage";
        parameter Modelica.SIunits.Frequency f=50 "Frequency";
        parameter Modelica.SIunits.Resistance RL=0.4 "Load resistance";
        parameter Modelica.SIunits.Capacitance C=0.005 "Total DC-capacitance";
        parameter Modelica.SIunits.Voltage VC0=sqrt(3)*V
          "Initial voltage of capacitance";
        Modelica.Electrical.MultiPhase.Sources.SineVoltage source(
          m=m,
          V=fill(V, m),
          freqHz=fill(f, m)) annotation (Placement(transformation(
              origin={-90,-10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star starAC(m=m) annotation (
            Placement(transformation(
              origin={-90,-40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundAC annotation (Placement(
              transformation(extent={{-100,-80},{-80,-60}})));
        Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor(m=m)
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode1(
          m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m),
          Vknee=fill(0, m)) annotation (Placement(transformation(
              origin={-20,60},
              extent={{-10,10},{10,-10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Star star1(m=m) annotation (
            Placement(transformation(
              origin={0,70},
              extent={{10,10},{-10,-10}},
              rotation=180)));
        Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode2(
          m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m),
          Vknee=fill(0, m)) annotation (Placement(transformation(
              origin={-20,20},
              extent={{-10,10},{10,-10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Star star2(m=m) annotation (
            Placement(transformation(extent={{-10,0},{10,20}})));
        Modelica.Electrical.Analog.Basic.Resistor load(R=RL) annotation (
            Placement(transformation(
              origin={50,0},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Capacitor cDC1(C=2*C, v(start=VC0/2))
          annotation (Placement(transformation(
              origin={70,20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Capacitor cDC2(C=2*C, v(start=VC0/2))
          annotation (Placement(transformation(
              origin={70,-20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundDC annotation (Placement(
              transformation(extent={{80,-20},{100,0}})));
        parameter Machines.Utilities.TransformerData transformerData1(
          C1=Modelica.Utilities.Strings.substring(
                    transformer1.VectorGroup,
                    1,
                    1),
          C2=Modelica.Utilities.Strings.substring(
                    transformer1.VectorGroup,
                    2,
                    2),
          f=50,
          V1=100,
          V2=100,
          SNominal=30E3,
          v_sc=0.05,
          P_sc=300) annotation (Placement(transformation(extent={{-60,60},{-40,
                  80}})));
        Machines.BasicMachines.Transformers.Dy.Dy01 transformer1(
          n=transformerData1.n,
          R1=transformerData1.R1,
          L1sigma=transformerData1.L1sigma,
          R2=transformerData1.R2,
          L2sigma=transformerData1.L2sigma,
          T1Ref=293.15,
          alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T2Ref=293.15,
          alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T1Operational=293.15,
          T2Operational=293.15) annotation (Placement(transformation(extent={{-50,
                  30},{-30,50}})));

      initial equation
        cDC1.v = VC0/2;
        cDC2.v = VC0/2;
        transformer1.i2[1:2] = zeros(2);
      equation
        connect(cDC1.n, cDC2.p)
          annotation (Line(points={{70,10},{70,-10}}, color={0,0,255}));
        connect(cDC1.n, groundDC.p)
          annotation (Line(points={{70,10},{70,0},{90,0}}, color={0,0,255}));
        connect(starAC.plug_p, source.plug_n)
          annotation (Line(points={{-90,-30},{-90,-20}}, color={0,0,255}));
        connect(diode1.plug_n, star1.plug_p)
          annotation (Line(points={{-20,70},{-10,70}}, color={0,0,255}));
        connect(diode2.plug_p, star2.plug_p)
          annotation (Line(points={{-20,10},{-10,10}}, color={0,0,255}));
        connect(diode2.plug_n, diode1.plug_p)
          annotation (Line(points={{-20,30},{-20,50}}, color={0,0,255}));
        connect(starAC.pin_n, groundAC.p)
          annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
        connect(source.plug_p, currentSensor.plug_p)
          annotation (Line(points={{-90,0},{-85,0},{-80,0}}, color={0,0,255}));
        connect(load.p, cDC1.p)
          annotation (Line(points={{50,10},{50,30},{70,30}}, color={0,0,255}));
        connect(load.n, cDC2.n) annotation (Line(points={{50,-10},{50,-30},{70,
                -30}}, color={0,0,255}));
        connect(star1.pin_n, cDC1.p)
          annotation (Line(points={{10,70},{70,70},{70,30}}, color={0,0,255}));
        connect(star2.pin_n, cDC2.n) annotation (Line(points={{10,10},{20,10},{
                20,-70},{70,-70},{70,-30}}, color={0,0,255}));
        connect(transformer1.plug1, currentSensor.plug_n) annotation (Line(
            points={{-50,40},{-60,40},{-60,0}}, color={0,0,255}));
        connect(transformer1.plug2, diode1.plug_p) annotation (Line(
            points={{-30,40},{-20,40},{-20,50}}, color={0,0,255}));
        annotation (Documentation(info="<html>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a transformer a diode bridge rectifier with a DC burden.<br>
Using f=50 Hz, simulate for 0.1 seconds (5 periods) and compare voltages and currents of source and DC burden,
neglecting initial transient.
</html>"), experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6));
      end Rectifier6pulse;

      model Rectifier12pulse "12-pulse rectifier with 2 transformers"
        extends Machines.Examples.Transformers.Rectifier6pulse(RL=0.2);
        Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode3(
          m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m),
          Vknee=fill(0, m)) annotation (Placement(transformation(
              origin={-20,-20},
              extent={{-10,10},{10,-10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Star star3(m=m) annotation (
            Placement(transformation(extent={{-10,0},{10,-20}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode4(
          m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m),
          Vknee=fill(0, m)) annotation (Placement(transformation(
              origin={-20,-60},
              extent={{-10,10},{10,-10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Star star4(m=m) annotation (
            Placement(transformation(extent={{-10,-60},{10,-80}})));
        Machines.BasicMachines.Transformers.Dd.Dd00 transformer2(
          n=transformerData2.n,
          R1=transformerData2.R1,
          L1sigma=transformerData2.L1sigma,
          R2=transformerData2.R2,
          L2sigma=transformerData2.L2sigma,
          T1Ref=293.15,
          alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T2Ref=293.15,
          alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T1Operational=293.15,
          T2Operational=293.15) annotation (Placement(transformation(extent={{-50,
                  -50},{-30,-30}})));

        parameter Machines.Utilities.TransformerData transformerData2(
          C1=Modelica.Utilities.Strings.substring(
                    transformer2.VectorGroup,
                    1,
                    1),
          C2=Modelica.Utilities.Strings.substring(
                    transformer2.VectorGroup,
                    2,
                    2),
          f=50,
          V1=100,
          V2=100,
          SNominal=30E3,
          v_sc=0.05,
          P_sc=300) annotation (Placement(transformation(extent={{-60,-80},{-40,
                  -60}})));
      initial equation
        transformer2.core.plug_p1.pin[1:3].i = zeros(3);
      equation
        connect(diode3.plug_n, star3.plug_p)
          annotation (Line(points={{-20,-10},{-10,-10}}, color={0,0,255}));
        connect(diode4.plug_p, star4.plug_p)
          annotation (Line(points={{-20,-70},{-10,-70}}, color={0,0,255}));
        connect(diode4.plug_n, diode3.plug_p)
          annotation (Line(points={{-20,-50},{-20,-30}}, color={0,0,255}));
        connect(star4.pin_n, cDC2.n) annotation (Line(points={{10,-70},{70,-70},
                {70,-30}}, color={0,0,255}));
        connect(star3.pin_n, cDC1.p) annotation (Line(points={{10,-10},{18,-10},
                {18,-8},{22,-8},{22,-10},{30,-10},{30,70},{70,70},{70,30}}, color={0,0,255}));
        connect(transformer2.plug2, diode4.plug_n) annotation (Line(
            points={{-30,-40},{-20,-40},{-20,-50}}, color={0,0,255}));
        connect(transformer2.plug1, currentSensor.plug_n) annotation (Line(
            points={{-50,-40},{-60,-40},{-60,0}}, color={0,0,255}));
        annotation (Documentation(info="<html>
Test example with multiphase components:<br>
Star-connected voltage source feeds via two transformers (Dd0 and Dy1) two diode bridge rectifiers with a single DC burden.<br>
Using f=50 Hz, simulate for 0.1 seconds (5 periods) and compare voltages and currents of source and DC burden,
neglecting initial transient.
</html>"), experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6));
      end Rectifier12pulse;

      model AIMC_Transformer
        "Test example: AsynchronousInductionMachineSquirrelCage transformer starting"
        extends
          Machines.Examples.AsynchronousInductionMachines.AIMC_Transformer;
        annotation (experiment(StopTime=2.5, Interval=1E-4, Tolerance=1E-6), Documentation(
              info="<html>
<strong>Test example: Asynchronous induction machine with squirrel cage - transformer starting</strong><br>
At start time tStart1 three phase voltage is supplied to the asynchronous induction machine with squirrel cage via the transformer;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed;
at start time tStart2 the machine is fed directly from the voltage source, finally reaching nominal speed.<br>
Simulate for 2.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <em>AIM_SquirrelCage</em> are used.
</html>"));
      end AIMC_Transformer;
      annotation (Documentation(info="<html>
This package contains test examples of DC machines.
</html>"));
    end Transformers;
    annotation (Documentation(info="<html>
This package contains test examples of electric machines.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.01 2004/09/18 Anton Haumer<br>
       adapted to improved MoveToRotational</li>
  <li> v1.02 2004/09/19 Anton Haumer<br>
       added examples for DC machines</li>
  <li> v1.03 2004/09/24 Anton Haumer<br>
       usage of Sensors.CurrentRMSSensor<br>
       added example for DC machine with series excitation</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.3.1 2004/11/06 Anton Haumer<br>
       small changes in Utilities.VfController</li>
  <li> v1.52 2005/10/12 Anton Haumer<br>
       new example for electrical excited synchronous induction machine</li>
  <li> v1.6.1 2004/11/22 Anton Haumer<br>
       introduced Utilities.TerminalBox</li>
  <li> v2.1.2 2010/02/09 Anton Haumer<br>
       included new Examples (AIMC_Transformer, DC_Comparison)</li>
  </ul>
</html>"));
  end Examples;

  package BasicMachines "Basic machine models"
    extends Modelica.Icons.Package;
    package AsynchronousInductionMachines
      "Models of asynchronous induction machines"
      extends Modelica.Icons.VariantsPackage;
      model AIM_SquirrelCage
        "Asynchronous induction machine with squirrel cage rotor"
        extends Machines.Interfaces.PartialBasicInductionMachine(
          final idq_ss=airGapS.i_ss,
          final idq_sr=airGapS.i_sr,
          final idq_rs=airGapS.i_rs,
          final idq_rr=airGapS.i_rr,
          redeclare final
            Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMC
            thermalAmbient(final Tr=TrOperational),
          redeclare final Machines.Interfaces.InductionMachines.ThermalPortAIMC
            thermalPort,
          redeclare final Machines.Interfaces.InductionMachines.ThermalPortAIMC
            internalThermalPort,
          redeclare final
            Machines.Interfaces.InductionMachines.PowerBalanceAIMC powerBalance(
              final lossPowerRotorWinding=squirrelCageR.LossPower, final
              lossPowerRotorCore=0),
          statorCore(final w=statorCoreParameters.wRef));
        output Modelica.SIunits.Current ir[2]=squirrelCageR.i
          "Rotor cage currents";
        Machines.BasicMachines.Components.AirGapS airGapS(
          final p=p,
          final Lm=Lm,
          final m=m) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270)));
        parameter Modelica.SIunits.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
              *fsNominal)) "Stator main field inductance per phase"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lrsigma(start=3*(1 - sqrt(1 -
              0.0667))/(2*pi*fsNominal))
          "Rotor stray inductance per phase (equivalent three phase winding)"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance Rr(start=0.04)
          "Rotor resistance per phase (equivalent three phase winding) at TRef"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of rotor resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(
            start=0) "Temperature coefficient of rotor resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of rotor resistance" annotation (Dialog(
              group="Operational temperatures", enable=not useThermalPort));
        Machines.BasicMachines.Components.SquirrelCage squirrelCageR(
          final Lrsigma=Lrsigma,
          final Rr=Rr,
          final useHeatPort=true,
          final T_ref=TrRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef))
          annotation (Placement(transformation(
              origin={0,-40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      equation
        connect(airGapS.spacePhasor_r, squirrelCageR.spacePhasor_r)
          annotation (Line(points={{10,-10},{10,-30}}, color={0,0,255}));
        connect(airGapS.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,0},{36,0},{36,0},{70,0}}));
        connect(lssigma.spacePhasor_b, airGapS.spacePhasor_s) annotation (Line(
            points={{20,10},{10,10}}, color={0,0,255}));
        connect(squirrelCageR.heatPort, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{-10,-40},{-10,-60},{0,-60},{0,-80}}, color={191,0,0}));
        connect(airGapS.support, internalSupport) annotation (Line(
            points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
        annotation (defaultComponentName="aimc", Documentation(info="<html>
<p><strong>Model of a three phase asynchronous induction machine with squirrel cage.</strong><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed coordinate system. Both together connected via a stator-fixed <em>AirGap</em> model. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td>161.4</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1440.45</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>24.346</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>92.7</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.875</td><td> </td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature TsRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20s </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>rotor resistance</td>
<td>0.04</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>reference temperature TrRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20r </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>stator reactance Xs</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>rotor reactance Xr</td>
<td>3</td><td>Ohm</td>
</tr>
<tr>
<td>total stray coefficient sigma</td>
<td>0.0667</td><td> </td>
</tr>
<tr>
<td>stator operational temperature TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>rotor operational temperature TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xs * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>rotor stray inductance</td>
<td>Xr * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance per phase</td>
<td>sqrt(Xs*Xr * (1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</html>"));
      end AIM_SquirrelCage;

      model AIM_SlipRing "Asynchronous induction machine with slipring rotor"
        extends Machines.Interfaces.PartialBasicInductionMachine(
          final idq_ss=airGapS.i_ss,
          final idq_sr=airGapS.i_sr,
          final idq_rs=airGapS.i_rs,
          final idq_rr=airGapS.i_rr,
          redeclare final
            Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMS
            thermalAmbient(final Tr=TrOperational, final mr=m),
          redeclare final Machines.Interfaces.InductionMachines.ThermalPortAIMS
            thermalPort(final mr=m),
          redeclare final Machines.Interfaces.InductionMachines.ThermalPortAIMS
            internalThermalPort(final mr=m),
          redeclare final
            Machines.Interfaces.InductionMachines.PowerBalanceAIMS powerBalance(
            final lossPowerRotorWinding=sum(rr.resistor.LossPower),
            final lossPowerRotorCore=rotorCore.lossPower,
            final lossPowerBrush=0,
            final powerRotor=Machines.SpacePhasors.Functions.activePower(vr, ir)),
          statorCore(final w=statorCoreParameters.wRef));

        Machines.BasicMachines.Components.AirGapS airGapS(
          final p=p,
          final Lm=Lm,
          final m=m) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270)));
        parameter Modelica.SIunits.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
              *fsNominal)) "Stator main field inductance per phase"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lrsigma(start=3*(1 - sqrt(1 -
              0.0667))/(2*pi*fsNominal))
          "Rotor stray inductance per phase w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lrzero=Lrsigma
          "Rotor zero sequence inductance w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance Rr(start=0.04)
          "Rotor resistance per phase at TRef w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of rotor resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(
            start=0) "Temperature coefficient of rotor resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useTurnsRatio(start=true)
          "Use turnsRatio or calculate from locked-rotor voltage?";
        parameter Real turnsRatio(final min=Modelica.Constants.small, start=1)
          "Effective number of stator turns / effective number of rotor turns"
          annotation (Dialog(enable=useTurnsRatio));
        parameter Modelica.SIunits.Voltage VsNominal(start=100)
          "Nominal stator voltage per phase"
          annotation (Dialog(enable=not useTurnsRatio));
        parameter Modelica.SIunits.Voltage VrLockedRotor(start=100*(2*pi*
              fsNominal*Lm)/sqrt(Rs^2 + (2*pi*fsNominal*(Lm + Lssigma))^2))
          "Locked-rotor voltage per phase"
          annotation (Dialog(enable=not useTurnsRatio));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of rotor resistance" annotation (Dialog(
              group="Operational temperatures", enable=not useThermalPort));
        parameter Machines.Losses.CoreParameters rotorCoreParameters(
          final m=3,
          PRef=0,
          VRef(start=1) = 1,
          wRef(start=1) = 1)
          "Rotor core loss parameter record; all parameters refer to rotor side"
          annotation (Dialog(tab="Losses"));
        output Modelica.SIunits.Current i_0_r(stateSelect=StateSelect.prefer)=
             spacePhasorR.zero.i "Rotor zero-sequence current";
        output Modelica.SIunits.Voltage vr[m]=plug_rp.pin.v - plug_rn.pin.v
          "Rotor instantaneous voltages";
        output Modelica.SIunits.Current ir[m]=plug_rp.pin.i
          "Rotor instantaneous currents";
      protected
        final parameter Real internalTurnsRatio=if useTurnsRatio then
            turnsRatio else VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs
            ^2 + (2*pi*fsNominal*(Lm + Lssigma))^2);
      public
        Machines.SpacePhasors.Components.SpacePhasor spacePhasorR(final
            turnsRatio=internalTurnsRatio) annotation (Placement(transformation(
              origin={-70,-50},
              extent={{10,10},{-10,-10}},
              rotation=180)));
        Modelica.Electrical.MultiPhase.Basic.Resistor rr(
          final m=m,
          final R=fill(Rr, m),
          final T_ref=fill(TrRef, m),
          final alpha=fill(Machines.Thermal.convertAlpha(alpha20r, TrRef), m),
          final useHeatPort=true,
          final T=fill(TrRef, m)) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,40})));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_rp(final m=
              m) "Positive rotor plug" annotation (Placement(transformation(
                extent={{-110,70},{-90,50}})));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_rn(final m=
              m) "Negative rotor plug" annotation (Placement(transformation(
                extent={{-110,-50},{-90,-70}})));
        Machines.BasicMachines.Components.Inductor lrsigma(final L=fill(
              internalTurnsRatio^2*Lrsigma, 2)) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={20,-20})));
        Modelica.Electrical.Analog.Basic.Inductor lrzero(final L=
              internalTurnsRatio^2*Lrzero) annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=90,
              origin={-50,-60})));
        Machines.Losses.InductionMachines.Core rotorCore(
          final coreParameters=rotorCoreParameters,
          final w=rotorCoreParameters.wRef,
          final useHeatPort=true,
          final turnsRatio=internalTurnsRatio) annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={0,-30})));
      equation
        connect(lssigma.spacePhasor_b, airGapS.spacePhasor_s) annotation (Line(
            points={{20,10},{10,10}}, color={0,0,255}));
        connect(lrsigma.spacePhasor_b, airGapS.spacePhasor_r) annotation (Line(
            points={{20,-10},{10,-10}}, color={0,0,255}));
        connect(rr.plug_n, spacePhasorR.plug_p) annotation (Line(
            points={{-80,30},{-80,-40}}, color={0,0,255}));
        connect(spacePhasorR.plug_n, plug_rn) annotation (Line(
            points={{-80,-60},{-100,-60}}, color={0,0,255}));
        connect(spacePhasorR.zero, lrzero.p) annotation (Line(
            points={{-60,-50},{-50,-50}}, color={0,0,255}));
        connect(spacePhasorR.ground, lrzero.n) annotation (Line(
            points={{-60,-60},{-60,-70},{-50,-70}}, color={0,0,255}));
        connect(spacePhasorR.spacePhasor, lrsigma.spacePhasor_a) annotation (
            Line(
            points={{-60,-40},{-20,-40},{-20,-50},{20,-50},{20,-30}}, color={0,0,255}));
        connect(rotorCore.spacePhasor, lrsigma.spacePhasor_a) annotation (Line(
            points={{10,-30},{20,-30}}, color={0,0,255}));
        connect(rotorCore.heatPort, internalThermalPort.heatPortRotorCore)
          annotation (Line(
            points={{10,-40},{0.4,-40},{0.4,-80.8}}, color={191,0,0}));
        connect(rr.heatPort, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{-70,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
        connect(plug_rp, rr.plug_p) annotation (Line(
            points={{-100,60},{-80,60},{-80,50}}, color={0,0,255}));
        connect(airGapS.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,0},{70,0}}));
        connect(fixed.flange, internalSupport) annotation (Line(
            points={{50,-100},{60,-100}}));
        connect(internalSupport, airGapS.support) annotation (Line(
            points={{60,-100},{60,-90},{-40,-90},{-40,0},{-10,0}}));
        annotation (
          defaultComponentName="aims",
          Documentation(info="<html>
<p><strong>Model of a three phase asynchronous induction machine with slipring rotor.</strong><br>
Resistance and stray inductance of stator and rotor are modeled directly in stator respectively rotor phases, then using space phasor transformation and a stator-fixed <em>AirGap</em> model. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent rotor winding resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td>161.4</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1440.45</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>24.346</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>92.7</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.875</td><td> </td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature TsRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20s </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>rotor resistance</td>
<td>0.04</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature TrRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20r </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>stator reactance Xs</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>rotor reactance Xr</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>total stray coefficient sigma</td>
<td>0.0667</td><td> </td>
</tr>
<tr>
<td>turnsRatio</td>
<td>1</td><td>effective ratio of stator and rotor current</td>
</tr>
<tr>
<td>stator operational temperature TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>rotor operational temperature TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xs * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>rotor stray inductance</td>
<td>Xr * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance per phase</td>
<td>sqrt(Xs*Xr * (1-sigma))/(2*pi*f)</td><td> </td>
</tr>
</table>
<p>
Parameter turnsRatio could be obtained from the following relationship
at standstill with open rotor circuit at nominal voltage and nominal frequency,<br>
using the locked-rotor voltage VR, no-load stator current I0 and powerfactor PF0:<br>
turnsRatio * <u>V</u><sub>R</sub> = <u>V</u><sub>s</sub> - (R<sub>s</sub> + j X<sub>s,sigma</sub>) <u>I</u><sub>0</sub>
</p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Line(points={{-100,50},{-100,20},{-60,
                    20}}, color={0,0,255}), Line(points={{-100,-50},{-100,-20},
                    {-60,-20}}, color={0,0,255})}));
      end AIM_SlipRing;
      annotation (Documentation(info="<html>
This package contains models of asynchronous induction machines, based on space phasor theory:
<ul>
<li>AIM_SquirrelCage: asynchronous induction machine with squirrel cage</li>
<li>AIM_SlipRing: asynchronous induction machine with wound rotor</li>
</ul>
These models use package SpacePhasors.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.02 2004/09/19 Anton Haumer</li>
  <li> v1.03 2004/09/24 Anton Haumer<br>
       consistent naming of inductors and resistors in machine models</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.3.2 2004/11/10 Anton Haumer<br>
       ReluctanceRotor moved to SynchronousMachines</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v1.6.3 2005/11/25 Anton Haumer<br>
       easier parameterization of SlipRing model</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"));
    end AsynchronousInductionMachines;

    package SynchronousInductionMachines
      "Models of synchronous induction machines"
      extends Modelica.Icons.VariantsPackage;
      model SM_PermanentMagnet "Permanent magnet synchronous induction machine"
        extends Machines.Interfaces.PartialBasicInductionMachine(
          Lssigma(start=0.1/(2*pi*fsNominal)),
          final idq_ss=airGapR.i_ss,
          final idq_sr=airGapR.i_sr,
          final idq_rs=airGapR.i_rs,
          final idq_rr=airGapR.i_rr,
          redeclare final
            Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMPM
            thermalAmbient(
            final useDamperCage=useDamperCage,
            final Tr=TrOperational,
            final Tpm=TpmOperational),
          redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMPM
            thermalPort(final useDamperCage=useDamperCage),
          redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMPM
            internalThermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Machines.Interfaces.InductionMachines.PowerBalanceSMPM powerBalance(
            final lossPowerRotorWinding=damperCageLossPower,
            final lossPowerRotorCore=0,
            final lossPowerPermanentMagnet=permanentMagnet.lossPower),
          statorCore(final w=statorCoreParameters.wRef));
        Modelica.Blocks.Interfaces.RealOutput ir[2](
          start=zeros(2),
          each final quantity="ElectricCurrent",
          each final unit="A") if useDamperCage "Damper cage currents"
          annotation (Placement(visible=false),Dialog(showStartAttribute=true));
        Modelica.Blocks.Interfaces.RealOutput idq_dr[2](
          each stateSelect=StateSelect.prefer,
          each final quantity="ElectricCurrent",
          each final unit="A") if useDamperCage
          "Damper space phasor current / rotor fixed frame"
          annotation (Placement(visible=false));
        Machines.BasicMachines.Components.AirGapR airGapR(
          final p=p,
          final Lmd=Lmd,
          final Lmq=Lmq,
          final m=m) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270)));
        final parameter Modelica.SIunits.Temperature TpmOperational=293.15
          "Operational temperature of permanent magnet"
          annotation (Dialog(group="Operational temperatures"));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage" annotation (
            Dialog(group="Operational temperatures", enable=not useThermalPort
                 and useDamperCage));
        parameter Modelica.SIunits.Voltage VsOpenCircuit(start=112.3)
          "Open circuit RMS voltage per phase @ fsNominal";
        parameter Modelica.SIunits.Inductance Lmd(start=0.3/(2*pi*fsNominal))
          "Stator main field inductance per phase in d-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lmq(start=0.3/(2*pi*fsNominal))
          "Stator main field inductance per phase in q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useDamperCage(start=true)
          "Enable / disable damper cage" annotation (Evaluate=true, Dialog(tab=
                "Nominal resistances and inductances", group="DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*
              fsNominal)) "Damper stray inductance in d-axis" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Damper stray inductance in q-axis" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Damper resistance in d-axis at TRef" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Damper resistance in q-axis at TRef" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(
            start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Machines.Losses.PermanentMagnetLossParameters
          permanentMagnetLossParameters(IRef(start=100), wRef(start=2*pi*
                fsNominal/p)) "Permanent magnet loss parameter record"
          annotation (Dialog(tab="Losses"));
        Components.PermanentMagnetWithLosses permanentMagnet(
          final Ie=Ie,
          final useHeatPort=true,
          final m=m,
          final permanentMagnetLossParameters=permanentMagnetLossParameters,
          final is=is) annotation (Placement(transformation(
              origin={30,-30},
              extent={{10,10},{-10,-10}},
              rotation=180)));
        Machines.BasicMachines.Components.DamperCage damperCage(
          final Lrsigmad=Lrsigmad,
          final Lrsigmaq=Lrsigmaq,
          final Rrd=Rrd,
          final Rrq=Rrq,
          final T_ref=TrRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef),
          final useHeatPort=true) if useDamperCage annotation (Placement(
              transformation(
              origin={0,-40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      protected
        final parameter Modelica.SIunits.Current Ie=sqrt(2)*VsOpenCircuit/(Lmd*
            2*pi*fsNominal) "Equivalent excitation current";
        Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
            quantity="Power", final unit="W") "Damper losses";
      equation
        connect(ir, damperCage.i);
        connect(idq_dr, damperCage.i);
        connect(damperCageLossPower, damperCage.lossPower);
        if not useDamperCage then
          damperCageLossPower = 0;
        end if;
        connect(airGapR.spacePhasor_r, damperCage.spacePhasor_r)
          annotation (Line(points={{10,-10},{10,-30}}, color={0,0,255}));
        connect(airGapR.spacePhasor_r, permanentMagnet.spacePhasor_r)
          annotation (Line(points={{10,-10},{10,-20},{20,-20}}, color={0,0,255}));
        connect(airGapR.support, internalSupport) annotation (Line(
            points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
        connect(lssigma.spacePhasor_b, airGapR.spacePhasor_s) annotation (Line(
            points={{20,10},{10,10}}, color={0,0,255}));
        connect(airGapR.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,0},{70,0}}));
        connect(permanentMagnet.heatPort, internalThermalPort.heatPortPermanentMagnet)
          annotation (Line(
            points={{20,-40},{20,-80},{0,-80}}, color={191,0,0}));
        connect(permanentMagnet.flange, inertiaRotor.flange_b) annotation (Line(
            points={{30,-20},{90,-20},{90,0}}));
        connect(damperCage.heatPort, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{-10,-40},{-10,-80},{0,-80},{0,-80}}, color={191,0,0}));
        connect(internalSupport, permanentMagnet.support) annotation (Line(
            points={{60,-100},{60,-100},{60,-90},{30,-90},{30,-40},{30,-40}}));
        annotation (
          defaultComponentName="smpm",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-130,10},{-100,-10}},
                fillColor={0,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,10},{-70,-10}},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}),
          Documentation(info="<html>
<p><strong>Model of a three phase permanent magnet synchronous induction machine.</strong><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation and a rotor-fixed <em>AirGap</em> model. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed coordinate system. Permanent magnet excitation is modelled by a constant equivalent excitation current feeding the d-axis. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
<li>permanent magnet losses</li>
</ul>

<p>Whether a damper cage is present or not, can be selected with Boolean parameter useDamperCage (default = true).
<br><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>no-load voltage per phase</td>
<td>112.3</td><td>V RMS @ nominal speed</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td>181.4</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>28.5</td><td>kW</td>
</tr>
<tr>
<td>nominal rotor angle</td>
<td>20.75</td><td>degree</td>
</tr>
<tr>
<td>efficiency</td>
<td>95.0</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.98</td><td> </td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature TsRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20s </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>stator reactance Xd</td>
<td>0.4</td><td>Ohm per phase in d-axis</td>
</tr>
<tr>
<td>stator reactance Xq</td>
<td>0.4</td><td>Ohm per phase in q-axis</td>
</tr>
<tr>
<td>stator stray reactance Xss</td>
<td>0.1</td><td>Ohm per phase</td>
</tr>
<tr>
<td>damper resistance in d-axis</td>
<td>0.04</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>damper resistance in q-axis</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>reference temperature TrRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20r </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>damper stray reactance in d-axis XDds</td>
<td>0.05</td><td>Ohm</td>
</tr>
<tr>
<td>damper stray reactance in q-axis XDqs</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>stator operational temperature TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>damper operational temperature TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>main field inductance in d-axis</td>
<td>(Xd - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance in q-axis</td>
<td>(Xq - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in d-axis</td>
<td>XDds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in q-axis</td>
<td>XDqs/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</html>"));
      end SM_PermanentMagnet;

      model SM_ElectricalExcited
        "Electrical excited synchronous induction machine with damper cage"
        extends Machines.Interfaces.PartialBasicInductionMachine(
          Lssigma(start=0.1/(2*pi*fsNominal)),
          final idq_ss=airGapR.i_ss,
          final idq_sr=airGapR.i_sr,
          final idq_rs=airGapR.i_rs,
          final idq_rr=airGapR.i_rr,
          redeclare final
            Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMEE
            thermalAmbient(
            final useDamperCage=useDamperCage,
            final Te=TeOperational,
            final Tr=TrOperational),
          redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMEE
            thermalPort(final useDamperCage=useDamperCage),
          redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMEE
            internalThermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Machines.Interfaces.InductionMachines.PowerBalanceSMEE powerBalance(
            final lossPowerRotorWinding=damperCageLossPower,
            final powerExcitation=ve*ie,
            final lossPowerExcitation=re.LossPower,
            final lossPowerBrush=brush.lossPower,
            final lossPowerRotorCore=0),
          statorCore(final w=statorCoreParameters.wRef));
        Modelica.Blocks.Interfaces.RealOutput ir[2](
          start=zeros(2),
          each final quantity="ElectricCurrent",
          each final unit="A") if useDamperCage "Damper cage currents"
          annotation (Placement(visible=false),Dialog(showStartAttribute=true));
        Modelica.Blocks.Interfaces.RealOutput idq_dr[2](
          each stateSelect=StateSelect.prefer,
          each final quantity="ElectricCurrent",
          each final unit="A") if useDamperCage
          "Damper space phasor current / rotor fixed frame"
          annotation (Placement(visible=false));
        Machines.BasicMachines.Components.AirGapR airGapR(
          final p=p,
          final Lmd=Lmd,
          final Lmq=Lmq,
          final m=m) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270)));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage" annotation (
            Dialog(group="Operational temperatures", enable=not useThermalPort
                 and useDamperCage));
        parameter Modelica.SIunits.Inductance Lmd(start=1.5/(2*pi*fsNominal))
          "Stator main field inductance per phase in d-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lmq(start=1.5/(2*pi*fsNominal))
          "Stator main field inductance per phase in q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useDamperCage(start=true)
          "Enable / disable damper cage" annotation (Evaluate=true, Dialog(tab=
                "Nominal resistances and inductances", group="DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*
              fsNominal)) "Damper stray inductance in d-axis" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Damper stray inductance in q-axis" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Damper resistance in d-axis at TRef" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Damper resistance in q-axis at TRef" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(
            start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Voltage VsNominal(start=100)
          "Nominal stator RMS voltage per phase"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Current IeOpenCircuit(start=10)
          "Open circuit excitation current @ nominal voltage and frequency"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Resistance Re(start=2.5)
          "Excitation resistance at TRef" annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef(start=293.15)
          "Reference temperature of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(
            start=0) "Temperature coefficient of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Real sigmae(
          min=0,
          max=0.99,
          start=0.025) "Stray fraction of total excitation inductance"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeOperational(start=293.15)
          "Operational excitation temperature" annotation (Dialog(group=
                "Operational temperatures", enable=not useThermalPort));
        parameter Machines.Losses.BrushParameters brushParameters
          "Brush loss parameter record" annotation (Dialog(tab="Losses"));
        output Modelica.SIunits.Voltage ve=pin_ep.v - pin_en.v
          "Excitation voltage";
        output Modelica.SIunits.Current ie=pin_ep.i "Excitation current";
        Machines.BasicMachines.Components.DamperCage damperCage(
          final Lrsigmad=Lrsigmad,
          final Lrsigmaq=Lrsigmaq,
          final Rrd=Rrd,
          final Rrq=Rrq,
          final T_ref=TrRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef),
          final useHeatPort=true) if useDamperCage annotation (Placement(
              transformation(
              origin={0,-40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Machines.BasicMachines.Components.ElectricalExcitation
          electricalExcitation(final turnsRatio=turnsRatio) annotation (
            Placement(transformation(
              origin={-70,-50},
              extent={{-10,10},{10,-10}},
              rotation=180)));
        Modelica.Electrical.Analog.Basic.Resistor re(
          final R=Re,
          final T_ref=TeRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
          final useHeatPort=true) annotation (Placement(transformation(
              origin={-80,10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Inductor lesigma(final L=Lesigma)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,-20})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          "Positive excitation pin" annotation (Placement(transformation(extent=
                 {{-110,70},{-90,50}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          "Negative excitation pin" annotation (Placement(transformation(extent=
                 {{-90,-50},{-110,-70}})));
        Machines.Losses.DCMachines.Brush brush(final brushParameters=
              brushParameters, final useHeatPort=true) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,40})));
      protected
        final parameter Real turnsRatio=sqrt(2)*VsNominal/(2*pi*fsNominal*Lmd*
            IeOpenCircuit) "Stator current / excitation current";
        final parameter Modelica.SIunits.Inductance Lesigma=Lmd*turnsRatio^2*3/
            2*sigmae/(1 - sigmae);
        Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
            quantity="Power", final unit="W") "Damper losses";
      equation
        connect(ir, damperCage.i);
        connect(idq_dr, damperCage.i);
        connect(damperCageLossPower, damperCage.lossPower);
        if not useDamperCage then
          damperCageLossPower = 0;
        end if;
        connect(airGapR.spacePhasor_r, damperCage.spacePhasor_r)
          annotation (Line(points={{10,-10},{10,-30}}, color={0,0,255}));
        connect(airGapR.spacePhasor_r, electricalExcitation.spacePhasor_r)
          annotation (Line(points={{10,-10},{10,-10},{10,-20},{-60,-20},{-60,-40}}, color={0,0,255}));
        connect(electricalExcitation.pin_en, pin_en) annotation (Line(
            points={{-80,-60},{-100,-60}}, color={0,0,255}));
        connect(pin_ep, brush.p) annotation (Line(
            points={{-100,60},{-80,60},{-80,50}}, color={0,0,255}));
        connect(brush.n, re.p) annotation (Line(
            points={{-80,30},{-80,20}}, color={0,0,255}));
        connect(re.n, lesigma.p) annotation (Line(
            points={{-80,0},{-80,-10}}, color={0,0,255}));
        connect(lesigma.n, electricalExcitation.pin_ep) annotation (Line(
            points={{-80,-30},{-80,-40}}, color={0,0,255}));
        connect(lssigma.spacePhasor_b, airGapR.spacePhasor_s) annotation (Line(
            points={{20,10},{10,10}}, color={0,0,255}));
        connect(brush.heatPort, internalThermalPort.heatPortBrush) annotation (
            Line(
            points={{-70,50},{-60,50},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
        connect(re.heatPort, internalThermalPort.heatPortExcitation)
          annotation (Line(
            points={{-70,10},{-60,10},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
        connect(airGapR.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,0},{70,0}}));
        connect(airGapR.support, internalSupport) annotation (Line(
            points={{-10,0},{-26,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));

        connect(damperCage.heatPort, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{-10,-40},{-10,-80},{0,-80},{0,-80}}, color={191,0,0}));
        annotation (
          defaultComponentName="smee",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255}),
              Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0,255}),
              Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111,
                    1},{-110,-4}}, color={0,0,255}),
              Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1},
                    {-90,-4}}, color={0,0,255}),
              Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70,
                    -4}}, color={0,0,255}),
              Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0,
                    0,255})}),
          Documentation(info="<html>
<p><strong>Model of a three phase electrical excited synchronous induction machine with damper cage.</strong><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation and a rotor-fixed <em>AirGap</em> model. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed coordinate system. Electrical excitation is modelled by converting excitation current and voltage to d-axis space phasors. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent excitation winding resistance</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>brush losses in the excitation circuit</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p>Whether a damper cage is present or not, can be selected with Boolean parameter useDamperCage (default = true).
<br><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>no-load excitation current<br>
    @ nominal voltage and frequency</td>
<td>10</td><td>A DC</td>
</tr>
<tr>
<td>warm excitation resistance</td>
<td>2.5</td><td>Ohm</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal apparent power</td>
<td>-30000</td><td>VA</td>
</tr>
<tr>
<td>power factor</td>
<td>-1.0</td><td>ind./cap.</td>
</tr>
<tr>
<td>nominal excitation current</td>
<td>19</td><td>A</td>
</tr>
<tr>
<td>efficiency w/o excitation</td>
<td>97.1</td><td>%</td>
</tr>
<tr>
<td>nominal torque</td>
<td>-196.7</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>nominal rotor angle</td>
<td>-57.23</td><td>degree</td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature TsRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20s </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>stator reactance Xd</td>
<td>1.6</td><td>Ohm per phase in d-axis</td>
</tr>
<tr>
<td>giving Kc</td>
<td>0.625</td><td> </td>
</tr>
<tr>
<td>stator reactance Xq</td>
<td>1.6</td><td>Ohm per phase in q-axis</td>
</tr>
<tr>
<td>stator stray reactance Xss</td>
<td>0.1</td><td>Ohm per phase</td>
</tr>
<tr>
<td>damper resistance in d-axis</td>
<td>0.04</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>damper resistance in q-axis</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>reference temperature TrRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20r </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>damper stray reactance in d-axis XDds</td>
<td>0.05</td><td>Ohm</td>
</tr>
<tr>
<td>damper stray reactance in q-axis XDqs</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>excitation resistance</td>
<td>2.5</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>reference temperature TeRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20e </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>excitation stray inductance</td>
<td>2.5</td><td>% of total excitation inductance</td>
</tr>
<tr>
<td>stator operational temperature TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>damper operational temperature TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>excitation operational temperature TeOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>main field inductance in d-axis</td>
<td>(Xd - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance in q-axis</td>
<td>(Xq - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in d-axis</td>
<td>XDds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in q-axis</td>
<td>XDqs/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</html>"));
      end SM_ElectricalExcited;

      model SM_ReluctanceRotor
        "Synchronous induction machine with reluctance rotor and damper cage"
        extends Machines.Interfaces.PartialBasicInductionMachine(
          Lssigma(start=0.1/(2*pi*fsNominal)),
          final idq_ss=airGapR.i_ss,
          final idq_sr=airGapR.i_sr,
          final idq_rs=airGapR.i_rs,
          final idq_rr=airGapR.i_rr,
          redeclare final
            Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMR
            thermalAmbient(final useDamperCage=useDamperCage, final Tr=
                TrOperational),
          redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMR
            thermalPort(final useDamperCage=useDamperCage),
          redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMR
            internalThermalPort(final useDamperCage=useDamperCage),
          redeclare final Machines.Interfaces.InductionMachines.PowerBalanceSMR
            powerBalance(final lossPowerRotorWinding=damperCageLossPower,
              final lossPowerRotorCore=0),
          statorCore(final w=statorCoreParameters.wRef));

        Modelica.Blocks.Interfaces.RealOutput ir[2](
          start=zeros(2),
          each final quantity="ElectricCurrent",
          each final unit="A") if useDamperCage "Damper cage currents"
          annotation (Placement(visible=false),Dialog(showStartAttribute=true));
        Modelica.Blocks.Interfaces.RealOutput idq_dr[2](
          each stateSelect=StateSelect.prefer,
          each final quantity="ElectricCurrent",
          each final unit="A") if useDamperCage
          "Damper space phasor current / rotor fixed frame"
          annotation (Placement(visible=false));
        Machines.BasicMachines.Components.AirGapR airGapR(
          final p=p,
          final Lmd=Lmd,
          final Lmq=Lmq,
          final m=m) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270)));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage" annotation (
            Dialog(group="Operational temperatures", enable=not useThermalPort
                 and useDamperCage));
        parameter Modelica.SIunits.Inductance Lmd(start=2.9/(2*pi*fsNominal))
          "Stator main field inductance per phase in d-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lmq(start=0.9/(2*pi*fsNominal))
          "Stator main field inductance per phase in q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useDamperCage(start=true)
          "Enable / disable damper cage" annotation (Evaluate=true, Dialog(tab=
                "Nominal resistances and inductances", group="DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*
              fsNominal)) "Damper stray inductance in d-axis" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Damper stray inductance in q-axis" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Damper resistance in d-axis at TRef" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Damper resistance in q-axis at TRef" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(
            start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        Machines.BasicMachines.Components.DamperCage damperCage(
          final Lrsigmad=Lrsigmad,
          final Lrsigmaq=Lrsigmaq,
          final Rrd=Rrd,
          final Rrq=Rrq,
          final T_ref=TrRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef),
          final useHeatPort=true) if useDamperCage annotation (Placement(
              transformation(
              origin={0,-40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      protected
        Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
            quantity="Power", final unit="W") "Damper losses";
      equation
        connect(ir, damperCage.i);
        connect(idq_dr, damperCage.i);
        connect(damperCageLossPower, damperCage.lossPower);
        if not useDamperCage then
          damperCageLossPower = 0;
        end if;
        connect(airGapR.spacePhasor_r, damperCage.spacePhasor_r) annotation (
            Line(points={{10,-10},{10,-15},{10,-30}}, color={0,0,255}));
        connect(airGapR.support, internalSupport) annotation (Line(
            points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
        connect(lssigma.spacePhasor_b, airGapR.spacePhasor_s) annotation (Line(
            points={{20,10},{10,10}}, color={0,0,255}));
        connect(airGapR.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,0},{70,0}}));
        connect(damperCage.heatPort, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{-10,-40},{-10,-60},{-10,-60},{-10,-80},{0,-80}}, color={191,0,0}));
        annotation (
          defaultComponentName="smr",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-130,10},{-100,-10}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,10},{-70,-10}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}),
          Documentation(info="<html>
<p><strong>Model of a three phase synchronous induction machine with reluctance rotor and damper cage.</strong><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed coordinate system. Both together connected via a rotor-fixed <em>AirGap</em> model. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p>Whether a damper cage is present or not, can be selected with Boolean parameter useDamperCage (default = true).
<br><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>50</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td> 46</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td> 7.23</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>96.98</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.497</td><td> </td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature TsRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20s </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>rotor resistance in d-axis</td>
<td>0.04</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>rotor resistance in q-axis</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>reference temperature TrRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20r </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>stator reactance Xsd in d-axis</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>stator reactance Xsq in q-axis</td>
<td>1</td><td>Ohm</td>
</tr>
<tr>
<td>stator stray reactance Xss</td>
<td>0.1</td><td>Ohm per phase</td>
</tr>
<tr>
<td>rotor stray reactance in d-axis Xrds</td>
<td>0.05</td><td>Ohm per phase</td>
</tr>
<tr>
<td>rotor stray reactance in q-axis Xrqs</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>stator operational temperature TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>damper operational temperature TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>rotor stray inductance in d-axis</td>
<td>Xrds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>rotor stray inductance in q-axis</td>
<td>Xrqs/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance per phase in d-axis</td>
<td>(Xsd-Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance per phase in q-axis</td>
<td>(Xsq-Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</html>"));
      end SM_ReluctanceRotor;
      annotation (Documentation(info="<html>
This package contains models of synchronous induction machines, based on space phasor theory:
<ul>
<li>SM_PermanentMagnet: synchronous induction machine with permanent magnet excitation, with damper cage</li>
<li>SM_ElectricalExcited: synchronous induction machine with electrical excitation
    and damper cage</li>
<li>SM_ReluctanceRotor: induction machine with reluctance rotor and damper cage<br>
i.e., a squirrel cage rotor with magnetic poles due to different airgap width</li>
</ul>
These models use package SpacePhasors.
<br><strong>Please keep in mind:</strong><br>
<ul>
<li>We keep the same reference system as for motors, i.e.:<br>
    Positive RotorDisplacementAngle means acting as motor,<br>
    with positive electric power consumption and positive mechanical power output.</li>
<li>ElectricalAngle = p * MechanicalAngle</li>
<li>real axis = d-axis<br>
    imaginary= q-axis</li>
<li>Voltage induced by the magnet wheel (d-axis) is located in the q-axis.</li>
</ul>
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.02  2004/09/19 Anton Haumer</li>
  <li> v1.03  2004/09/24 Anton Haumer<br>
       consistent naming of inductors and resistors in machine models</li>
  <li> v1.1   2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.2   2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.3.2 2004/11/10 Anton Haumer<br>
       ReluctanceRotor moved to SynchronousMachines</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v1.52  2005/10/12 Anton Haumer<br>
       added SM_ElectricalExcited</li>
  <li> v1.53  2005/10/14 Anton Haumer<br>
       introduced unsymmetrical DamperCage for Synchronous Machines</li>
  <li> v1.6.2 2005/10/23 Anton Haumer<br>
       selectable DamperCage for Synchronous Machines</li>
  <li> v1.7.1 2006/02/06 Anton Haumer<br>
       changed some naming of synchronous machines, not affecting existing models</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"));
    end SynchronousInductionMachines;

    package DCMachines "Models of DC machines"
      extends Modelica.Icons.VariantsPackage;
      model DC_PermanentMagnet "Permanent magnet DC machine"
        extends Machines.Interfaces.PartialBasicDCMachine(
          final ViNominal=VaNominal - Machines.Thermal.convertResistance(
                    Ra,
                    TaRef,
                    alpha20a,
                    TaNominal)*IaNominal -
              Machines.Losses.DCMachines.brushVoltageDrop(brushParameters,
              IaNominal),
          final psi_eNominal=Lme*IeNominal,
          redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCPM
            thermalAmbient(final Tpm=TpmOperational),
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM
            thermalPort,
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM
            internalThermalPort,
          redeclare final Machines.Interfaces.DCMachines.PowerBalanceDCPM
            powerBalance(final lossPowerPermanentMagnet=0),
          core(final w=airGapDC.w));
        final parameter Modelica.SIunits.Temperature TpmOperational=293.15
          "Operational temperature of permanent magnet"
          annotation (Dialog(group="Operational temperatures"));
        Machines.BasicMachines.Components.AirGapDC airGapDC(
          final turnsRatio=turnsRatio,
          final Le=Lme,
          final quasiStationary=quasiStationary) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground eGround annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-20,-30})));
        Modelica.Electrical.Analog.Sources.ConstantCurrent ie(I=IeNominal)
          annotation (Placement(transformation(
              origin={0,-40},
              extent={{-10,-10},{10,10}})));
      protected
        constant Modelica.SIunits.Inductance Lme=1
          "Field excitation inductance";
        constant Modelica.SIunits.Current IeNominal=1
          "Equivalent excitation current";
      equation
        connect(eGround.p, ie.p) annotation (Line(points={{-10,-30},{-10,-30},{
                -10,-40}}, color={0,0,255}));
        connect(airGapDC.pin_ep, ie.n)
          annotation (Line(points={{10,-10},{10,-40}}, color={0,0,255}));
        connect(airGapDC.pin_en, eGround.p) annotation (Line(points={{-10,-10},
                {-10,-20},{-10,-30}}, color={0,0,255}));
        connect(airGapDC.pin_ap, la.n) annotation (Line(
            points={{10,10},{10,60}}, color={0,0,255}));
        connect(airGapDC.support, internalSupport) annotation (Line(
            points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
        connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,0},{36,0},{36,0},{70,0}}));
        connect(airGapDC.pin_an, brush.p) annotation (Line(
            points={{-10,10},{-10,60}}, color={0,0,255}));
        annotation (
          defaultComponentName="dcpm",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Rectangle(
                extent={{-130,10},{-100,-10}},
                fillColor={0,255,0},
                fillPattern=FillPattern.Solid), Rectangle(
                extent={{-100,10},{-70,-10}},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
<p><strong>Model of a DC Machine with permanent magnets.</strong><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <em>AirGapDC</em> model. Permanent magnet excitation is modelled by a constant equivalent excitation current feeding AirGapDC. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent armature winding resistance</li>
<li>brush losses in the armature circuit</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p>No saturation is modelled.
<br><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.15</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal armature voltage</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>nominal armature current</td>
<td>100</td><td>A</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1425</td><td>rpm</td>
</tr>
<tr>
<td>nominal torque</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>9.5</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>95.0</td><td>%</td>
</tr>
<tr>
<td>armature resistance</td>
<td>0.05</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>reference temperature TaRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20a </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>armature inductance</td>
<td>0.0015</td><td>H</td>
</tr>
<tr>
<td>armature nominal temperature TaNominal</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>armature operational temperature TaOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and compensation winding, if present.
</html>"));
      end DC_PermanentMagnet;

      model DC_ElectricalExcited
        "Electrical shunt/separate excited linear DC machine"
        extends Machines.Interfaces.PartialBasicDCMachine(
          final ViNominal=VaNominal - Machines.Thermal.convertResistance(
                    Ra,
                    TaRef,
                    alpha20a,
                    TaNominal)*IaNominal -
              Machines.Losses.DCMachines.brushVoltageDrop(brushParameters,
              IaNominal),
          final psi_eNominal=Lme*IeNominal,
          redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCEE
            thermalAmbient(final Te=TeOperational),
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE
            thermalPort,
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE
            internalThermalPort,
          redeclare final Machines.Interfaces.DCMachines.PowerBalanceDCEE
            powerBalance(final powerExcitation=ve*ie, final lossPowerExcitation=
               re.LossPower),
          core(final w=airGapDC.w));
        parameter Modelica.SIunits.Current IeNominal(start=1)
          "Nominal excitation current" annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Resistance Re(start=100)
          "Field excitation resistance at TRef"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef(start=293.15)
          "Reference temperature of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(
            start=0) "Temperature coefficient of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Inductance Le(start=1)
          "Total field excitation inductance"
          annotation (Dialog(tab="Excitation"));
        parameter Real sigmae(
          min=0,
          max=0.99,
          start=0) "Stray fraction of total excitation inductance"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeOperational(start=293.15)
          "Operational (shunt) excitation temperature" annotation (Dialog(group=
               "Operational temperatures", enable=not useThermalPort));
        output Modelica.SIunits.Voltage ve=pin_ep.v - pin_en.v
          "Field excitation voltage";
        output Modelica.SIunits.Current ie(start=0) = pin_ep.i
          "Field excitation current";
        Machines.BasicMachines.Components.AirGapDC airGapDC(
          final turnsRatio=turnsRatio,
          final Le=Lme,
          final quasiStationary=quasiStationary) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground ground
          annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
        Machines.BasicMachines.Components.CompoundDCExcitation
          compoundDCExcitation(final excitationTurnsRatio=1)
          annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
        Modelica.Electrical.Analog.Basic.Ground groundSE
          annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
        Modelica.Electrical.Analog.Basic.Resistor re(
          final R=Re,
          final T_ref=TeRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
          final useHeatPort=true) annotation (Placement(transformation(
              origin={-80,50},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Machines.BasicMachines.Components.InductorDC lesigma(final L=Lesigma,
            final quasiStationary=quasiStationary) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,20})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          "Positive excitation pin" annotation (Placement(transformation(extent=
                 {{-110,70},{-90,50}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          "Negative excitation pin" annotation (Placement(transformation(extent=
                 {{-90,-50},{-110,-70}})));
      protected
        final parameter Modelica.SIunits.Inductance Lme=Le*(1 - sigmae)
          "Main part of excitation inductance";
        final parameter Modelica.SIunits.Inductance Lesigma=Le*sigmae
          "Stray part of excitation inductance" annotation (Evaluate=true);
      equation
        connect(airGapDC.pin_ap, la.n) annotation (Line(
            points={{10,10},{10,60}}, color={0,0,255}));
        connect(airGapDC.support, internalSupport) annotation (Line(
            points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
        connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,0},{35,0},{35,0},{70,0}}));
        connect(re.p, pin_ep) annotation (Line(
            points={{-80,60},{-100,60}}, color={0,0,255}));
        connect(re.n, lesigma.p) annotation (Line(
            points={{-80,40},{-80,30}}, color={0,0,255}));
        connect(ground.p, airGapDC.pin_en) annotation (Line(
            points={{-20,-10},{-10,-10}}, color={0,0,255}));
        connect(airGapDC.pin_en, compoundDCExcitation.pin_n) annotation (Line(
            points={{-10,-10},{-10,-10}}, color={0,0,255}));
        connect(airGapDC.pin_ep, compoundDCExcitation.pin_p) annotation (Line(
            points={{10,-10},{10,-10}}, color={0,0,255}));
        connect(groundSE.p, compoundDCExcitation.pin_sen) annotation (Line(
            points={{-20,-30},{-10,-30}}, color={0,0,255}));
        connect(pin_en, compoundDCExcitation.pin_en) annotation (Line(
            points={{-100,-60},{2,-60},{2,-30}}, color={0,0,255}));
        connect(compoundDCExcitation.pin_ep, lesigma.n) annotation (Line(
            points={{10,-29.8},{10,-40},{-80,-40},{-80,10}}, color={0,0,255}));
        connect(airGapDC.pin_an, brush.p) annotation (Line(
            points={{-10,10},{-10,60}}, color={0,0,255}));
        connect(re.heatPort, internalThermalPort.heatPortExcitation)
          annotation (Line(
            points={{-70,50},{-60,50},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
        annotation (
          defaultComponentName="dcee",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111,
                    1},{-110,-4}}, color={0,0,255}),
              Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1},
                    {-90,-4}}, color={0,0,255}),
              Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70,
                    -4}}, color={0,0,255}),
              Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0,0,255}),
              Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0,
                    255})}),
          Documentation(info="<html>
<p><strong>Model of a DC Machine with electrical shunt or separate excitation.</strong><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <em>AirGapDC</em> model.<br>
The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent armature winding resistance</li>
<li>heat losses in the temperature dependent excitation winding resistance</li>
<li>brush losses in the armature circuit</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p>No saturation is modelled.<br>
Shunt or separate excitation is defined by the user's external circuit.
<br><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.15</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal armature voltage</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>nominal armature current</td>
<td>100</td><td>A</td>
</tr>
<tr>
<td>nominal torque</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1425</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>9.5</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>95.0</td><td>% only armature</td>
</tr>
<tr>
<td>efficiency</td>
<td>94.06</td><td>% including excitation</td>
</tr>
<tr>
<td>armature resistance</td>
<td>0.05</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>reference temperature TaRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20a </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>armature inductance</td>
<td>0.0015</td><td>H</td>
</tr>
<tr>
<td>nominal excitation voltage</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>nominal excitation current</td>
<td>1</td><td>A</td>
</tr>
<tr>
<td>excitation resistance</td>
<td>100</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>reference temperature TeRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20e </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>excitation inductance</td>
<td>1</td><td>H</td>
</tr>
<tr>
<td>stray part of excitation inductance</td>
<td>0</td><td> </td>
</tr>
<tr>
<td>armature nominal temperature TaNominal</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>armature operational temperature TaOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>(shunt) excitation operational temperature TeOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and
compensation winding, if present.<br>
Armature current does not cover excitation current of a shunt excitation; in this case total current drawn from the grid = armature current + excitation current.
</html>"));
      end DC_ElectricalExcited;

      model DC_SeriesExcited "Series excited linear DC machine"
        extends Machines.Interfaces.PartialBasicDCMachine(
          wNominal(start=1410*2*pi/60),
          final ViNominal=VaNominal - (Machines.Thermal.convertResistance(
                    Ra,
                    TaRef,
                    alpha20a,
                    TaNominal) + Machines.Thermal.convertResistance(
                    Re,
                    TeRef,
                    alpha20e,
                    TeNominal))*IaNominal -
              Machines.Losses.DCMachines.brushVoltageDrop(brushParameters,
              IaNominal),
          final psi_eNominal=Lme*abs(IaNominal),
          redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCSE
            thermalAmbient(final Tse=TeOperational),
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE
            thermalPort,
          redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE
            internalThermalPort,
          redeclare final Machines.Interfaces.DCMachines.PowerBalanceDCSE
            powerBalance(final powerSeriesExcitation=ve*ie, final
              lossPowerSeriesExcitation=re.LossPower),
          core(final w=airGapDC.w));
        parameter Modelica.SIunits.Resistance Re(start=0.01)
          "Series excitation resistance at TRef"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef(start=293.15)
          "Reference temperature of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(
            start=0) "Temperature coefficient of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Inductance Le(start=0.0005)
          "Total field excitation inductance"
          annotation (Dialog(tab="Excitation"));
        parameter Real sigmae(
          min=0,
          max=0.99,
          start=0) "Stray fraction of total excitation inductance"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeNominal(start=293.15)
          "Nominal series excitation temperature"
          annotation (Dialog(tab="Nominal parameters"));
        parameter Modelica.SIunits.Temperature TeOperational(start=293.15)
          "Operational series excitation temperature" annotation (Dialog(group=
                "Operational temperatures", enable=not useThermalPort));
        output Modelica.SIunits.Voltage ve=pin_ep.v - pin_en.v
          "Field excitation voltage";
        output Modelica.SIunits.Current ie=pin_ep.i "Field excitation current";
        Machines.BasicMachines.Components.AirGapDC airGapDC(
          final turnsRatio=turnsRatio,
          final Le=Lme,
          final quasiStationary=quasiStationary) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Machines.BasicMachines.Components.CompoundDCExcitation
          compoundDCExcitation(final excitationTurnsRatio=1)
          annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
        Modelica.Electrical.Analog.Basic.Ground ground
          annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
        Modelica.Electrical.Analog.Basic.Ground groundE
          annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
        Modelica.Electrical.Analog.Basic.Resistor re(
          final R=Re,
          final T_ref=TeRef,
          final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
          final useHeatPort=true) annotation (Placement(transformation(
              origin={-80,50},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Machines.BasicMachines.Components.InductorDC lesigma(final L=Lesigma,
            final quasiStationary=quasiStationary) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,20})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          "Positive series excitation pin" annotation (Placement(transformation(
                extent={{-110,70},{-90,50}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          "Negative series excitation pin" annotation (Placement(transformation(
                extent={{-90,-50},{-110,-70}})));
      protected
        final parameter Modelica.SIunits.Inductance Lme=Le*(1 - sigmae)
          "Main part of excitation inductance";
        final parameter Modelica.SIunits.Inductance Lesigma=Le*sigmae
          "Stray part of excitation inductance" annotation (Evaluate=true);
      equation
        connect(airGapDC.pin_ap, la.n) annotation (Line(
            points={{10,10},{10,60}}, color={0,0,255}));
        connect(airGapDC.support, internalSupport) annotation (Line(
            points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
        connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
            points={{10,0},{70,0},{70,0}}));
        connect(pin_ep, re.p) annotation (Line(
            points={{-100,60},{-80,60}}, color={0,0,255}));
        connect(re.n, lesigma.p) annotation (Line(
            points={{-80,40},{-80,30}}, color={0,0,255}));
        connect(airGapDC.pin_en, compoundDCExcitation.pin_n) annotation (Line(
            points={{-10,-10},{-10,-10}}, color={0,0,255}));
        connect(compoundDCExcitation.pin_p, airGapDC.pin_ep) annotation (Line(
            points={{10,-10},{10,-10}}, color={0,0,255}));
        connect(airGapDC.pin_en, ground.p) annotation (Line(
            points={{-10,-10},{-20,-10}}, color={0,0,255}));
        connect(compoundDCExcitation.pin_sen, pin_en) annotation (Line(
            points={{-10,-30},{-10,-60},{-100,-60}}, color={0,0,255}));
        connect(compoundDCExcitation.pin_sep, lesigma.n) annotation (Line(
            points={{-2,-30},{-2,-40},{-80,-40},{-80,10}}, color={0,0,255}));
        connect(compoundDCExcitation.pin_en, groundE.p) annotation (Line(
            points={{2,-30},{2,-40},{10,-40}}, color={0,0,255}));
        connect(airGapDC.pin_an, brush.p) annotation (Line(
            points={{-10,10},{-10,60}}, color={0,0,255}));
        connect(re.heatPort, internalThermalPort.heatPortSeriesExcitation)
          annotation (Line(
            points={{-70,50},{-60,50},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
        annotation (
          defaultComponentName="dcse",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{-100,-10},{-105,-9},{-109,-5},{-110,0},{-109,5},{-105,
                    9},{-100,10}}, color={0,0,255}),
              Line(points={{-100,-30},{-105,-29},{-109,-25},{-110,-20},{-109,-15},
                    {-105,-11},{-100,-10}}, color={0,0,255}),
              Line(points={{-100,10},{-105,11},{-109,15},{-110,20},{-109,25},{-105,
                    29},{-100,30}}, color={0,0,255}),
              Line(points={{-100,50},{-100,30}}, color={0,0,255}),
              Line(points={{-100,-30},{-100,-50}}, color={0,0,255})}),
          Documentation(info="<html>
<p><strong>Model of a DC Machine with series excitation.</strong><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <em>AirGapDC</em> model.<br>
The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent armature winding resistance</li>
<li>heat losses in the temperature dependent excitation winding resistance</li>
<li>brush losses in the armature circuit</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p>No saturation is modelled.<br>
Series excitation has to be connected by the user's external circuit.
<br><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.15</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal armature voltage</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>nominal armature current</td>
<td>100</td><td>A</td>
</tr>
<tr>
<td>nominal torque</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1410</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>9.4</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>94.0</td><td>% only armature</td>
</tr>
<tr>
<td>armature resistance</td>
<td>0.05</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>reference temperature TaRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20a </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>armature inductance</td>
<td>0.0015</td><td>H</td>
</tr>
<tr>
<td>excitation resistance</td>
<td>0.01</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>reference temperature TeRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20e</td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>excitation inductance</td>
<td>0.0005</td><td>H</td>
</tr>
<tr>
<td>stray part of excitation inductance</td>
<td>0</td><td> </td>
</tr>
<tr>
<td>armature nominal temperature TaNominal</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>series excitation nominal temperature TeNominal</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>armature operational temperature TaOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>series excitation operational temperature TeOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and
compensation winding, if present.<br>
Parameter nominal armature voltage includes voltage drop of series excitation;<br>
but for output the voltage is split into:<br>
va = armature voltage without voltage drop of series excitation<br>
ve = voltage drop of series excitation
</html>"));
      end DC_SeriesExcited;
      annotation (Documentation(info="<html>
This package contains models of DC machines:
<ul>
<li>DC_PermanentMagnet: DC machine with permanent magnet excitation</li>
<li>DC_ElectricalExcited: DC machine with electrical shunt or separate excitation</li>
<li>DC_SeriesExcited: DC machine with series excitation</li>
</ul>
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.02 2004/09/19 Anton Haumer</li>
  <li> v1.03 2004/09/24 Anton Haumer<br>
       added DC machine with series excitation</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"));
    end DCMachines;

    package QuasiStationaryDCMachines "Models of quasistationary DC machines"
      extends Modelica.Icons.VariantsPackage;
      model DC_PermanentMagnet "Quasistationary permanent magnet DC machine"
        extends Machines.BasicMachines.DCMachines.DC_PermanentMagnet(final
            quasiStationary=true);
        extends Machines.Icons.QuasiStationaryMachine;
        annotation (defaultComponentName="dcpm", Documentation(info="<html>
<strong>Quasistationary model of a DC Machine with permanent magnets.</strong><br>
This model is fully compatible with the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet\">transient machine model of a DC machine with permanent magnets</a>;
the only difference is that electrical transients are neglected.
</html>"));
      end DC_PermanentMagnet;

      model DC_ElectricalExcited
        "Quasistationary electrical shunt/separate excited linear DC machine"
        extends Machines.BasicMachines.DCMachines.DC_ElectricalExcited(final
            quasiStationary=true);
        extends Machines.Icons.QuasiStationaryMachine;
        annotation (defaultComponentName="dcee", Documentation(info="<html>
<strong>Quasistationary model of a DC Machine with electrical shunt or separate excitation.</strong><br>
This model is fully compatible with the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_ElectricalExcited\">transient machine model of a DC machine with electrical shunt or separate excitation</a>;
the only difference is that electrical transients are neglected.
</html>"));
      end DC_ElectricalExcited;

      model DC_SeriesExcited "Quasistationary series excited linear DC machine"
        extends Machines.BasicMachines.DCMachines.DC_SeriesExcited(final
            quasiStationary=true);
        extends Machines.Icons.QuasiStationaryMachine;
        annotation (defaultComponentName="dcse", Documentation(info="<html>
<strong>Quasistationary model of a DC Machine with Series excitation.</strong><br>
This model is fully compatible with the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_SeriesExcited\">transient machine model of a DC machine with series excitation</a>;
the only difference is that electrical transients are neglected.
</html>"));
      end DC_SeriesExcited;
      annotation (Documentation(info="<html>
<p>
This package contains quasistationary models of DC machines;
these models are fully compatible with the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines\">transient machine models of DC machines</a>;
the only difference is that electrical transients are neglected.
</p>
<h4>Please note:</h4>
<p>
Quasistationary DC machine models are basically different from quasistationary induction machine models:
Quasistationary DC machine models neglect electrical transients, i.e., setting <code>der(i) = 0</code>,
whereas quasistationary induction machine models are based on time phasor theory,
see <a href=\"modelica://Modelica.Electrical.QuasiStationary\">QuasiStationary Library</a>,
where e.g., <code>L*der(i)</code> is replaced by <code>j*omega*L*(I_re+j*I_im)</code>.
</p>
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v2.3.0 2010/02/16 Anton Haumer<br>
       first implementation</li>
  </ul>
</html>"));
    end QuasiStationaryDCMachines;

    package Transformers "Library for technical 3phase transformers"
      extends Modelica.Icons.Package;
      package Yy "Transformers: primary Y / secondary y"
        extends Modelica.Icons.VariantsPackage;
        model Yy00 "Transformer Yy0"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yy00");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},{-50,20},{-10,20},{-10,10}},
                                              color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-10},{-10,-10},{-10,-70},{-10,-70}},
                                                    color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_n) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy0
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy00;

        model Yy02 "Transformer Yy2"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yy02");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3) annotation (Line(points={{10,4},{
                  10,-4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy2
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy02;

        model Yy04 "Transformer Yy4"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yy04");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(Rot2.plug_n, l2sigma.plug_n)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_p) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy4
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy04;

        model Yy06 "Transformer Yy6"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yy06");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(l2sigma.plug_n, core.plug_n3) annotation (Line(points={{50,0},
                  {50,-20},{10,-20},{10,-10}}, color={0,0,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy6
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy06;

        model Yy08 "Transformer Yy8"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yy08");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(Rot2.plug_p, l2sigma.plug_n)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy8
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy08;

        model Yy10 "Transformer Yy10"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yy10");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot2.plug_n)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy10
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yy10;
        annotation (Documentation(info="<html>
This package contains transformers primary Y connected / secondary y connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Yy;

      package Yd "Transformers: primary Y / secondary d"
        extends Modelica.Icons.VariantsPackage;
        model Yd01 "Transformer Yd1"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yd01");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(Delta2.plug_p, r2.plug_p) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, Delta2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_n) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd1
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd01;

        model Yd03 "Transformer Yd3"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yd03");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(Delta2.plug_n, r2.plug_p) annotation (Line(points={{50,20},{
                  70,20},{70,0}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot2.plug_p) annotation (Line(points={{70,0},
                  {70,-10},{50,-10},{50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Delta2.plug_p) annotation (Line(points={{10,10},
                  {10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd3
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd03;

        model Yd05 "Transformer Yd5"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yd05");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(Delta2.plug_n, r2.plug_p) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, l2sigma.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{50,-20},{50,0}}, color={0,0,255}));
          connect(core.plug_p2, Delta2.plug_p) annotation (Line(points={{10,10},
                  {10,20},{30,20}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd5
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd05;

        model Yd07 "Transformer Yd7"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yd07");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(Delta2.plug_p, r2.plug_p) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Delta2.plug_n) annotation (Line(points={{10,10},
                  {10,20},{30,20}}, color={0,0,255}));
          connect(l2sigma.plug_n, core.plug_n3) annotation (Line(points={{50,0},
                  {50,-20},{10,-20},{10,-10}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd7
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd07;

        model Yd09 "Transformer Yd9"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yd09");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(Rot2.plug_p, l2sigma.plug_n)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(Delta2.plug_n, r2.plug_p) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd9
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd09;

        model Yd11 "Transformer Yd11"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yd11");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(Delta2.plug_n, r2.plug_p) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_n) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd11
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yd11;
        annotation (Documentation(info="<html>
This package contains transformers primary Y connected / secondary d connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Yd;

      package Yz "Transformers: primary Y / secondary zig-zag"
        extends Modelica.Icons.VariantsPackage;
        model Yz01 "Transformer Yz1"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yz01");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz1
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz01;

        model Yz03 "Transformer Yz3"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yz03");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz3
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz03;

        model Yz05 "Transformer Yz5"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yz05");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={0,0,255}));
          connect(l2sigma.plug_n, core.plug_n2) annotation (Line(points={{50,0},
                  {50,20},{20,20},{20,4},{10,4}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz5
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz05;

        model Yz07 "Transformer Yz7"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yz07");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(l2sigma.plug_n, core.plug_n2) annotation (Line(points={{50,0},
                  {50,20},{20,20},{20,4},{10,4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz7
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz07;

        model Yz09 "Transformer Yz9"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yz09");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot22.plug_n) annotation (Line(points={{50,0},
                  {50,20},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz9
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz09;

        model Yz11 "Transformer Yz11"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Yz11");
          Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
            annotation (Placement(transformation(
                origin={-10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
        equation
          connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
                  -10,-100},{-50,-100}}, color={0,0,255}));
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
                  {-10,-37.5},{-10,-70},{-10,-70}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot22.plug_n)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz11
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Yz11;
        annotation (Documentation(info="<html>
This package contains transformers primary Y connected / secondary zig-zag connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Yz;

      package Dy "Transformers: primary D / secondary y"
        extends Modelica.Icons.VariantsPackage;
        model Dy01 "Transformer Dy1"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dy01");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p) annotation (Line(points={{-50,-20},
                  {-90,-20},{-90,0}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy1
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy01;

        model Dy03 "Transformer Dy3"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dy03");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(Rot2.plug_n, l2sigma.plug_n)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p) annotation (Line(points={{-50,-20},
                  {-90,-20},{-90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_p) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy3
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy03;

        model Dy05 "Transformer Dy5"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dy05");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p) annotation (Line(points={{-50,-20},
                  {-90,-20},{-90,0}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(l2sigma.plug_n, core.plug_n3) annotation (Line(points={{50,0},
                  {50,-20},{10,-20},{10,-10}}, color={0,0,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy5
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy05;

        model Dy07 "Transformer Dy7"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dy07");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(Rot2.plug_p, l2sigma.plug_n)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy7
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy07;

        model Dy09 "Transformer Dy9"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dy09");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot2.plug_n)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
                  {20,10},{20,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy9
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy09;

        model Dy11 "Transformer Dy11"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dy11");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_n) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy11
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dy11;
        annotation (Documentation(info="<html>
This package contains transformers primary D connected / secondary y connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Dy;

      package Dd "Transformers: primary D / secondary d"
        extends Modelica.Icons.VariantsPackage;
        model Dd00 "Transformer Dd0"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dd00");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(Delta2.plug_p, r2.plug_p) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_n) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={0,0,255}));
          connect(core.plug_n3, Delta2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd0
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd00;

        model Dd02 "Transformer Dd2"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dd02");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
        equation
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(Delta2.plug_n, r2.plug_p) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot2.plug_p)
            annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Delta2.plug_p) annotation (Line(points={{10,10},
                  {10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, Rot2.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd2
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd02;

        model Dd04 "Transformer Dd4"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dd04");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,10},{50,30}})));
        equation
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(Delta2.plug_n, r2.plug_p) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3) annotation (Line(points={{10,4},{
                  10,1},{10,1},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Delta2.plug_p) annotation (Line(points={{10,10},
                  {10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, l2sigma.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{50,-20},{50,0}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd4
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd04;

        model Dd06 "Transformer Dd6"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dd06");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}})));
        equation
          connect(Delta2.plug_p, r2.plug_p) annotation (Line(points={{50,20},{
                  90,20},{90,0}}, color={0,0,255}));
          connect(Delta1.plug_p, r1.plug_p) annotation (Line(points={{-50,-20},
                  {-90,-20},{-90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(Delta2.plug_n, core.plug_p2) annotation (Line(points={{30,20},
                  {10,20},{10,10}}, color={0,0,255}));
          connect(core.plug_n3, l2sigma.plug_n) annotation (Line(points={{10,-10},
                  {10,-20},{50,-20},{50,0}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd6
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd06;

        model Dd08 "Transformer Dd8"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dd08");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot2(final m=m)
            annotation (Placement(transformation(extent={{50,10},{30,30}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
        equation
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(Delta2.plug_n, r2.plug_p) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={0,0,255}));
          connect(Rot2.plug_p, l2sigma.plug_n)
            annotation (Line(points={{50,20},{50,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(core.plug_n1, Delta1.plug_n) annotation (Line(points={{-10,-5},
                  {-10,-20},{-30,-20}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, Rot2.plug_n) annotation (Line(points={{10,10},{
                  10,20},{30,20}}, color={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd8
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd08;

        model Dd10 "Transformer Dd10"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dd10");
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta2(final m=m)
            annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
        equation
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(Delta2.plug_n, r2.plug_p) annotation (Line(points={{50,-20},{
                  90,-20},{90,0}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_n2, core.plug_p3)
            annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
          connect(core.plug_p2, l2sigma.plug_n) annotation (Line(points={{10,10},
                  {10,20},{50,20},{50,0}}, color={0,0,255}));
          connect(core.plug_n3, Delta2.plug_p) annotation (Line(points={{10,-10},
                  {10,-20},{30,-20}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd10
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dd10;
        annotation (Documentation(info="<html>
This package contains transformers primary D connected / secondary d connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Dd;

      package Dz "Transformers: primary D / secondary zig-zag"
        extends Modelica.Icons.VariantsPackage;
        model Dz00 "Transformer Dz0"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dz00");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz0
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz00;

        model Dz02 "Transformer Dz2"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dz02");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{-10,10},{10,-10}},
                rotation=180)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot22.plug_p)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_n, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz2
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz02;

        model Dz04 "Transformer Dz4"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dz04");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(l2sigma.plug_n, core.plug_n2) annotation (Line(points={{50,0},
                  {50,20},{20,20},{20,4},{10,4}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz4
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz04;

        model Dz06 "Transformer Dz6"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dz06");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-40},{10,-70},{10,-70}}, color={0,0,255}));
          connect(l2sigma.plug_n, core.plug_n2) annotation (Line(points={{50,0},
                  {50,20},{20,20},{20,4},{10,4}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz6
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz06;

        model Dz08 "Transformer Dz8"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dz08");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_n)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_p) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot22.plug_n) annotation (Line(points={{50,0},
                  {50,20},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz8
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz08;

        model Dz10 "Transformer Dz10"
          extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup=
               "Dz10");
          Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
            annotation (Placement(transformation(
                origin={10,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
            annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
            annotation (Placement(transformation(
                origin={40,20},
                extent={{10,10},{-10,-10}},
                rotation=180)));
          Modelica.Electrical.MultiPhase.Basic.Delta Delta1(final m=m)
            annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
        equation
          connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
                  10,-100},{50,-100}}, color={0,0,255}));
          connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
                  -20},{-50,-20}}, color={0,0,255}));
          connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
                  {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
          connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
                  {-10,-20},{-10,-5}}, color={0,0,255}));
          connect(core.plug_p2, Rot21.plug_p)
            annotation (Line(points={{10,10},{30,10}}, color={0,0,255}));
          connect(core.plug_p3, Rot21.plug_n) annotation (Line(points={{10,-4},
                  {20,-4},{20,-10},{30,-10}}, color={0,0,255}));
          connect(core.plug_n3, star2.plug_p) annotation (Line(points={{10,-10},
                  {10,-70},{10,-70}}, color={0,0,255}));
          connect(l2sigma.plug_n, Rot22.plug_n)
            annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
          connect(Rot22.plug_p, core.plug_n2) annotation (Line(points={{30,20},
                  {20,20},{20,4},{10,4}}, color={0,0,255}));
          annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dz10
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
        end Dz10;
        annotation (Documentation(info="<html>
This package contains transformers primary D connected / secondary d connected in all possible vector groups.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer</li>
  </ul>
</html>"));
      end Dz;
      annotation (Documentation(info="<html>
This package contains components to model technical three-phase transformers:
<ul>
<li>Transformer: transformer model to choose connection / vector group</li>
<li>Yy: Transformers with primary Y / secondary y</li>
<li>Yd: Transformers with primary Y / secondary d</li>
<li>Yz: Transformers with primary Y / secondary zig-zag</li>
<li>Dy: Transformers with primary D / secondary y</li>
<li>Dd: Transformers with primary D / secondary d</li>
<li>Dz: Transformers with primary D / secondary zig-zag</li>
</ul>
<p>
Transformers are modeled by an ideal transformer, adding primary and secondary winding resistances and stray inductances.<br>
All transformers extend from the base model <em>PartialTransformer</em>, adding the primary and secondary connection.<br>
<strong>VectorGroup</strong> defines the phase shift between primary and secondary voltages, expressed by a number phase shift/30 degree
(i.e., the hour on a clock face). Therefore each transformer is identified by two characters and a two-digit number,
e.g., Yd11 ... primary connection Y (star), secondary connection d (delta), vector group 11 (phase shift 330 degree)<br>
With the \"supermodel\" <em>Transformer</em>&nbsp; the user may choose primary and secondary connection as well as the vector group.<br>
It calculates winding ratio as well as primary and secondary winding resistances and stray inductances,
distributing them equally to primary and secondary winding, from the following parameters:
</p>
<ul>
<li>nominal frequency</li>
<li>primary voltage (RMS line-to-line)</li>
<li>secondary voltage (RMS line-to-line)</li>
<li>nominal apparent power</li>
<li>impedance voltage drop</li>
<li>short-circuit copper losses</li>
</ul>
The <strong>impedance voltage drop</strong> indicates the (absolute value of the) voltage drop at nominal load (current) as well as
the voltage we have to apply to the primary winding to achieve nominal current in the short-circuited secondary winding.
<p>
<strong>Please pay attention</strong> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).<br>
<strong>In some cases (Yy or Yz) it may be necessary to ground one of the transformer's starpoints
even though the source's and/or load's starpoint are grounded; you may use a reasonable high earthing resistance.</strong>
</p>
<strong>Limitations and assumptions:</strong><br>
<ul>
<li>number of phases is limited to 3, therefore definition as a constant m=3</li>
<li>symmetry of the 3 phases resp. limbs</li>
<li>saturation is neglected, i.e., inductances are constant</li>
<li>magnetizing current is neglected</li>
<li>magnetizing losses are neglected</li>
<li>additional (stray) losses are neglected</li>
</ul>
<strong>Further development:</strong>
<ul>
<li>modeling magnetizing current, including saturation</li>
<li>temperature dependency of winding resistances</li>
</ul>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.
</p>

<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>", revisions="<html>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer<br>
       first stable release</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"), Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
            Polygon(
              origin={10,10},
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder,
              points={{-80,50},{-60,30},{-60,-50},{-80,-70},{-80,50}}),
            Polygon(
              origin={10,10},
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder,
              points={{60,50},{40,30},{40,-50},{60,-70},{60,50}}),
            Polygon(
              origin={10,10},
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder,
              points={{-10,40},{-20,30},{-20,-50},{-10,-60},{0,-50},{0,30},{-10,
                  40}}),
            Polygon(
              origin={10,10},
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder,
              points={{-80,50},{60,50},{40,30},{0,30},{-10,40},{-20,30},{-60,30},
                  {-80,50}}),
            Polygon(
              origin={10,10},
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder,
              points={{-80,-70},{60,-70},{40,-50},{0,-50},{-10,-60},{-20,-50},{
                  -60,-50},{-80,-70}}),
            Rectangle(
              origin={10,10},
              lineColor={128,0,255},
              fillColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{-88,-46},{-52,26}}),
            Rectangle(
              origin={10,10},
              lineColor={0,128,255},
              fillColor={0,128,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{-94,-38},{-46,18}}),
            Rectangle(
              origin={10,10},
              lineColor={128,0,255},
              fillColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{-28,-46},{8,26}}),
            Rectangle(
              origin={10,10},
              lineColor={0,128,255},
              fillColor={0,128,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{-34,-38},{14,18}}),
            Rectangle(
              origin={10,10},
              lineColor={128,0,255},
              fillColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{32,-46},{68,26}}),
            Rectangle(
              origin={10,10},
              lineColor={0,128,255},
              fillColor={0,128,255},
              fillPattern=FillPattern.VerticalCylinder,
              extent={{26,-38},{74,18}})}));
    end Transformers;

    package Components "Machine components like AirGaps"
      extends Modelica.Icons.Package;
      partial model PartialAirGap "Partial airgap model"
        parameter Integer m=3 "Number of phases";
        parameter Integer p(min=1) "Number of pole pairs";
        output Modelica.SIunits.Torque tauElectrical;
        Modelica.SIunits.Angle gamma "Rotor displacement angle";
        Modelica.SIunits.Current i_ss[2]
          "Stator current space phasor with respect to the stator fixed frame";
        Modelica.SIunits.Current i_sr[2]
          "Stator current space phasor with respect to the rotor fixed frame";
        Modelica.SIunits.Current i_rs[2]
          "Rotor current space phasor with respect to the stator fixed frame";
        Modelica.SIunits.Current i_rr[2]
          "Rotor current space phasor with respect to the rotor fixed frame";
        Modelica.SIunits.MagneticFlux psi_ms[2]
          "Magnetizing flux phasor with respect to the stator fixed frame";
        Modelica.SIunits.MagneticFlux psi_mr[2]
          "Magnetizing flux phasor with respect to the rotor fixed frame";
        Real RotationMatrix[2, 2] "Matrix of rotation from rotor to stator";
      public
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (
            Placement(transformation(extent={{-10,110},{10,90}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a support
          "Support at which the reaction torque is acting" annotation (
            Placement(transformation(extent={{-10,-110},{10,-90}})));
        Machines.Interfaces.SpacePhasor spacePhasor_s annotation (Placement(
              transformation(extent={{-110,90},{-90,110}})));
        Machines.Interfaces.SpacePhasor spacePhasor_r annotation (Placement(
              transformation(extent={{90,90},{110,110}})));
        /*
  Modelica.SIunits.AngularVelocity omegaPsi_ms
    "Angular velocity of main flux with respect to the stator fixed frame";
  Modelica.SIunits.AngularVelocity omegaPsi_mr
    "Angular velocity of main flux with respect to the rotor fixed frame";
  Modelica.SIunits.Current i_sm[2]
    "Stator current space phasor with respect to the main flux fixed frame";
  Modelica.SIunits.Current i_rm[2]
    "Rotor current space phasor with respect to the main flux fixed frame";
protected
  Modelica.SIunits.MagneticFlux psi_msAbs "Length of main flux phasor";
  Modelica.SIunits.Angle psi_msArg
    "(Wrapped) angle of main flux phasor with respect to the stator fixed frame";
  Modelica.SIunits.Angle psi_mrArg
    "(Wrapped) angle of main flux phasor with respect to the rotor fixed frame";
initial equation
  i_sm = Machines.SpacePhasors.Functions.Rotator(i_ss, psi_msArg);
  i_rm = Machines.SpacePhasors.Functions.Rotator(i_rr, psi_mrArg);
equation
  // AngularVelocity of main flux phasor
  (psi_msAbs, psi_msArg) = Machines.SpacePhasors.Functions.ToPolar(psi_ms);
  psi_mrArg = psi_msArg - gamma;
  omegaPsi_ms = if noEvent(psi_msAbs<Modelica.Constants.small) then 0 else
    (spacePhasor_s.v_[2]*cos(psi_msArg) - spacePhasor_s.v_[1]*sin(psi_msArg))/psi_msAbs;
  omegaPsi_mr = omegaPsi_ms - der(gamma);
  // stator and rotor current w.r.t. main flux fixed frame
  der(i_sm) = Machines.SpacePhasors.Functions.Rotator(
    {der(i_ss[1]) + omegaPsi_ms*i_ss[2], der(i_ss[2]) - omegaPsi_ms*i_ss[1]}, psi_msArg);
  der(i_rm) = Machines.SpacePhasors.Functions.Rotator(
    {der(i_rr[1]) + omegaPsi_mr*i_rr[2], der(i_rr[2]) - omegaPsi_mr*i_rr[1]}, psi_mrArg);
*/
      equation
        // mechanical angle of the rotor of an equivalent 2-pole machine
        gamma = p*(flange.phi - support.phi);
        RotationMatrix = {{+cos(gamma),-sin(gamma)},{+sin(gamma),+cos(gamma)}};
        i_ss = spacePhasor_s.i_;
        i_ss = RotationMatrix*i_sr;
        i_rr = spacePhasor_r.i_;
        i_rs = RotationMatrix*i_rr;
        // Stator voltage induction
        spacePhasor_s.v_ = der(psi_ms);
        // Rotor voltage induction
        spacePhasor_r.v_ = der(psi_mr);
        // Electromechanical torque (cross product of current and flux space phasor)
        tauElectrical = m/2*p*(spacePhasor_s.i_[2]*psi_ms[1] - spacePhasor_s.i_[
          1]*psi_ms[2]);
        flange.tau = -tauElectrical;
        support.tau = tauElectrical;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(
                extent={{-90,90},{90,-92}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-80,80},{80,-80}}, lineColor={0,0,255}),
              Rectangle(
                extent={{-10,90},{10,-80}},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={128,128,128}),
              Text(
                extent={{-150,-110},{150,-150}},
                lineColor={0,0,255},
                textString="%name")}), Documentation(info="<html>
Partial model of the airgap, using only equations.
</html>"));
      end PartialAirGap;

      model AirGapS "Airgap in stator-fixed coordinate system"
        parameter Modelica.SIunits.Inductance Lm "Main field inductance";
        extends PartialAirGap;
        Modelica.SIunits.Current i_ms[2]
          "Magnetizing current space phasor with respect to the stator fixed frame";
      protected
        parameter Modelica.SIunits.Inductance L[2, 2]={{Lm,0},{0,Lm}}
          "Inductance matrix";
      equation
        // Magnetizing current with respect to the stator reference frame
        i_ms = i_ss + i_rs;
        // Magnetizing flux linkage with respect to the stator reference frame
        psi_ms = L*i_ms;
        // Magnetizing flux linkage with respect to the rotor reference frame
        psi_mr = transpose(RotationMatrix)*psi_ms;
        annotation (
          defaultComponentName="airGap",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Text(
                extent={{-80,40},{0,-40}},
                textString="S")}),
          Documentation(info="<html>
Model of the airgap in stator-fixed coordinate system, using only equations.
</html>"));
      end AirGapS;

      model AirGapR "Airgap in rotor-fixed coordinate system"
        parameter Modelica.SIunits.Inductance Lmd
          "Main field inductance d-axis";
        parameter Modelica.SIunits.Inductance Lmq
          "Main field inductance q-axis";
        extends PartialAirGap;
        Modelica.SIunits.Current i_mr[2]
          "Magnetizing current space phasor with respect to the rotor fixed frame";
      protected
        parameter Modelica.SIunits.Inductance L[2, 2]={{Lmd,0},{0,Lmq}}
          "Inductance matrix";
      equation
        // Magnetizing current with respect to the rotor reference frame
        i_mr = i_sr + i_rr;
        // Main flux linkage with respect to the rotor reference frame
        psi_mr = L*i_mr;
        // Main flux linkage with respect to the stator reference frame
        psi_ms = RotationMatrix*psi_mr;
        annotation (
          defaultComponentName="airGap",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Text(
                extent={{0,40},{80,-40}},
                textString="R")}),
          Documentation(info="<html>
Model of the airgap in rotor-fixed coordinate system, using only equations.
</html>"));
      end AirGapR;

      model Inductor "Space phasor inductor"
        parameter Modelica.SIunits.Inductance L[2] "Inductance of both axes";
        Modelica.SIunits.Voltage v_[2];
        Modelica.SIunits.Current i_[2];
        Machines.Interfaces.SpacePhasor spacePhasor_a annotation (Placement(
              transformation(extent={{-110,-10},{-90,10}})));
        Machines.Interfaces.SpacePhasor spacePhasor_b annotation (Placement(
              transformation(extent={{90,-10},{110,10}})));
      equation
        spacePhasor_a.i_ + spacePhasor_b.i_ = zeros(2);
        v_ = spacePhasor_a.v_ - spacePhasor_b.v_;
        i_ = spacePhasor_a.i_;
        v_[1] = L[1]*der(i_[1]);
        v_[2] = L[2]*der(i_[2]);
        annotation (Documentation(info="<html>
This is a model of an inductor, described with space phasors.
</html>"),Icon(graphics={
              Line(
                points={{-60,0},{-90,0}},
                color={0,0,255}),
              Line(
                points={{90,0},{60,0}},
                color={0,0,255}),
              Text(
                extent={{-150,40},{150,80}},
                lineColor={0,0,255},
                textString="%name"),
              Line(
                points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}},
                color={0,0,255},
                smooth=Smooth.Bezier)}));
      end Inductor;

      model SquirrelCage "Squirrel Cage"
        parameter Modelica.SIunits.Inductance Lrsigma
          "Rotor stray inductance per phase translated to stator";
        parameter Modelica.SIunits.Resistance Rr
          "Rotor resistance per phase translated to stator at T_ref";
        parameter Modelica.SIunits.Temperature T_ref=293.15
          "Reference temperature";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
          "Temperature coefficient of resistance at T_ref";
        extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
        Modelica.SIunits.Resistance Rr_actual
          "Actual resistance = Rr*(1 + alpha*(T_heatPort - T_ref))";
        Machines.Interfaces.SpacePhasor spacePhasor_r annotation (Placement(
              transformation(extent={{-110,90},{-90,110}})));
        Modelica.Blocks.Interfaces.RealOutput i[2](
          each final quantity="ElectricCurrent",
          each final unit="A") = -spacePhasor_r.i_
          "Currents out from squirrel cage";
      equation
        assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
          "Temperature outside scope of model!");
        Rr_actual = Rr*(1 + alpha*(T_heatPort - T_ref));
        spacePhasor_r.v_ = Rr_actual*spacePhasor_r.i_ + Lrsigma*der(
          spacePhasor_r.i_);
        2/3*LossPower = Rr_actual*(spacePhasor_r.i_[1]*spacePhasor_r.i_[1] +
          spacePhasor_r.i_[2]*spacePhasor_r.i_[2]);
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Line(points={{-100,60},{-60,
                60}}, color={0,0,255}),Line(points={{60,60},{80,60},{80,40}},
                color={0,0,255}),Rectangle(
                      extent={{60,40},{100,-40}},
                      lineColor={0,0,255},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Line(points={{80,-40},{80,
                -60}}, color={0,0,255}),Line(points={{60,-60},{100,-60}}, color=
                 {0,0,255}),Line(points={{70,-80},{90,-80}}, color={0,0,255}),
                Line(points={{66,-70},{94,-70}}, color={0,0,255}),Text(
                      extent={{-150,-148},{150,-110}},
                      lineColor={0,0,255},
                      textString="%name"),Line(points={{-100,90},{-100,60}},
                color={0,0,255}),
              Line(
                points={{-60,60},{-59,66},{-52,74},{-38,74},{-31,66},{-30,60}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{-30,60},{-29,66},{-22,74},{-8,74},{-1,66},{0,60}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{0,60},{1,66},{8,74},{22,74},{29,66},{30,60}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{30,60},{31,66},{38,74},{52,74},{59,66},{60,60}},
                color={0,0,255},
                smooth=Smooth.Bezier)}),
                                    Documentation(info="<html>
<p>
Model of a squirrel cage / symmetrical damper cage in two axis.
</p>
<p>
The squirrel cage has an optional (conditional) HeatPort,
which can be enabled or disabled by the Boolean parameter useHeatPort.
Temperatures of both axis are the same, both losses are added.
Material properties alpha of both axis are the same.
</p>
</html>"));
      end SquirrelCage;

      model DamperCage "Squirrel Cage"
        parameter Modelica.SIunits.Inductance Lrsigmad
          "Stray inductance in d-axis per phase translated to stator";
        parameter Modelica.SIunits.Inductance Lrsigmaq
          "Stray inductance in q-axis per phase translated to stator";
        parameter Modelica.SIunits.Resistance Rrd
          "Resistance in d-axis per phase translated to stator at T_ref";
        parameter Modelica.SIunits.Resistance Rrq
          "Resistance in q-axis per phase translated to stator at T_ref";
        parameter Modelica.SIunits.Temperature T_ref=293.15
          "Reference temperature of both resistances in d- and q-axis";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
          "Temperature coefficient of both resistances in d- and q-axis at T_ref";
        extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
        Modelica.SIunits.Resistance Rrd_actual
          "Actual resistance = Rrd*(1 + alpha*(T_heatPort - T_ref))";
        Modelica.SIunits.Resistance Rrq_actual
          "Actual resistance = Rrq*(1 + alpha*(T_heatPort - T_ref))";
        Modelica.Blocks.Interfaces.RealOutput i[2](
          each final quantity="ElectricCurrent",
          each final unit="A") = -spacePhasor_r.i_ "Currents out from damper";
        Modelica.Blocks.Interfaces.RealOutput lossPower(
          final quantity="Power",
          final unit="W") = LossPower "Damper losses";
        Machines.Interfaces.SpacePhasor spacePhasor_r annotation (Placement(
              transformation(extent={{-110,90},{-90,110}})));
      equation
        assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
          "Temperature outside scope of model!");
        Rrd_actual = Rrd*(1 + alpha*(T_heatPort - T_ref));
        Rrq_actual = Rrq*(1 + alpha*(T_heatPort - T_ref));
        spacePhasor_r.v_[1] = Rrd_actual*spacePhasor_r.i_[1] + Lrsigmad*der(
          spacePhasor_r.i_[1]);
        spacePhasor_r.v_[2] = Rrq_actual*spacePhasor_r.i_[2] + Lrsigmaq*der(
          spacePhasor_r.i_[2]);
        2/3*LossPower = Rrd_actual*spacePhasor_r.i_[1]*spacePhasor_r.i_[1] +
          Rrq_actual*spacePhasor_r.i_[2]*spacePhasor_r.i_[2];
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}},
              grid={2,2}), graphics={
              Line(points={{60,60},{100,60}}, color={0,0,255}),
              Line(points={{70,40},{90,40}}, color={0,0,255}),
              Line(points={{66,50},{94,50}}, color={0,0,255}),
              Line(points={{-80,0},{-80,-20}}, color={0,0,255}),
              Rectangle(extent={{20,90},{60,70}}, lineColor={0,0,255}),
              Line(points={{60,80},{80,80},{80,60}}, color={0,0,255}),
              Line(points={{-100,90},{-100,80},{-60,80}}, color={0,0,255}),
              Line(points={{-100,90},{-100,80},{-80,80},{-80,60}}, color={0,0,255}),
              Line(points={{0,80},{20,80}}, color={0,0,255}),
              Rectangle(extent={{-90,-20},{-70,-60}}, lineColor={0,0,255}),
              Line(points={{-100,-80},{-60,-80}}, color={0,0,255}),
              Line(points={{-90,-100},{-70,-100}}, color={0,0,255}),
              Line(points={{-94,-90},{-66,-90}}, color={0,0,255}),
              Line(points={{-80,-60},{-80,-80}}, color={0,0,255}),
              Line(
                points={{-60,80},{-59,85},{-54,90},{-46,90},{-41,85},{-40,80}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{-40,80},{-39,85},{-34,90},{-26,90},{-21,85},{-20,80}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{-20,80},{-19,85},{-14,90},{-6,90},{-1,85},{0,80}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-85,50},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-85,30},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-85,10},
                rotation=90),                                     Text(
                      extent={{-150,-148},{150,-110}},
                      lineColor={0,0,255},
                      textString="%name")}),
                                Documentation(info="<html>
<p>
Model of an asymmetrical damper cage in two axis.
</p>
<p>
The damper cage has an optional (conditional) HeatPort,
which can be enabled or disabled by the Boolean parameter useHeatPort.
Temperatures of both axis are the same, both losses are added.
Material properties alpha can be set differently for both d- and q-axis,
although reference temperature for both resistances is the same.
</p>
</html>"));
      end DamperCage;

      model ElectricalExcitation "Electrical excitation"
        parameter Real turnsRatio(start=1)
          "Ratio stator current / excitation current";
        Modelica.SIunits.Current ie "Excitation current";
        Modelica.SIunits.Voltage ve "Excitation voltage";
        Machines.Interfaces.SpacePhasor spacePhasor_r annotation (Placement(
              transformation(extent={{-110,90},{-90,110}})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep annotation (
            Placement(transformation(extent={{90,110},{110,90}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en annotation (
            Placement(transformation(extent={{110,-110},{90,-90}})));
      equation
        pin_ep.i + pin_en.i = 0;
        ie = +pin_ep.i;
        ve = pin_ep.v - pin_en.v;
        spacePhasor_r.i_ = {-ie*turnsRatio,0};
        ve = spacePhasor_r.v_[1]*turnsRatio*3/2;
        annotation (defaultComponentName="excitation",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
                                          Polygon(
                      points={{-90,100},{-70,106},{-70,94},{-90,100}},
                      lineColor={0,0,255},
                      fillColor={0,0,255},
                      fillPattern=FillPattern.Solid),Ellipse(extent={{-70,40},{
                10,-40}}, lineColor={0,0,255}),Ellipse(extent={{-10,40},{70,-40}},
                lineColor={0,0,255}),Line(points={{-30,0},{-54,32},{-50,20},{-44,
                26},{-54,32}}, color={0,0,255}),Line(points={{-30,0},{-54,-32},
                {-50,-20},{-44,-26},{-54,-32}}, color={0,0,255}),Line(points={{
                -54,32},{-54,100},{-70,100}}, color={0,0,255}),Line(points={{90,
                100},{30,100},{30,40}}, color={0,0,255}),Line(points={{30,-40},
                {30,-100},{90,-100}}, color={0,0,255}),           Text(
                      extent={{-150,-148},{150,-110}},
                      lineColor={0,0,255},
                      textString="%name")}),              Documentation(info="<html>
Model of an electrical excitation, converting excitation to space phasor.
</html>"));
      end ElectricalExcitation;

      model PermanentMagnet "Permanent magnet excitation"
        parameter Modelica.SIunits.Current Ie "Equivalent excitation current";
        Machines.Interfaces.SpacePhasor spacePhasor_r annotation (Placement(
              transformation(extent={{-110,90},{-90,110}})));
      equation
        spacePhasor_r.i_ = {-Ie,0};
        annotation (defaultComponentName="magnet",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Ellipse(
                      extent={{-60,60},{60,20}},
                      lineColor={255,0,0},
                      fillColor={255,0,0},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-60,-20},{60,-60}},
                      lineColor={0,255,0},
                      fillColor={0,255,0},
                      fillPattern=FillPattern.Solid),Rectangle(
                      extent={{-60,40},{60,0}},
                      lineColor={255,0,0},
                      fillColor={255,0,0},
                      fillPattern=FillPattern.Solid),Polygon(
                      points={{-90,100},{-70,106},{-70,94},{-90,100}},
                      lineColor={0,0,255},
                      fillColor={0,0,255},
                      fillPattern=FillPattern.Solid),Rectangle(
                      extent={{-60,0},{60,-40}},
                      lineColor={0,255,0},
                      pattern=LinePattern.None,
                      lineThickness=0.5,
                      fillColor={0,255,0},
                      fillPattern=FillPattern.Solid),Line(points={{-60,-40},{-60,
                0}}, color={0,255,0}),Line(points={{60,-40},{60,0}}, color={0,255,0}),
                Line(points={{0,100},{-70,100}}, color={0,0,255}),Line(
                points={{0,100},{0,60}}, color={255,0,0}),        Text(
                      extent={{-150,-160},{150,-120}},
                      lineColor={0,0,255},
                      textString="%name")}), Documentation(info="<html>
Model of a permanent magnet excitation, characterized by an equivalent excitation current.
</html>"));
      end PermanentMagnet;

      model PermanentMagnetWithLosses "Permanent magnet excitation"
        extends Machines.BasicMachines.Components.PermanentMagnet;
        extends Machines.Losses.InductionMachines.PermanentMagnetLosses;
        annotation(defaultComponentName="magnet", Documentation(info="<html>
Model of a permanent magnet excitation with loss, characterized by an equivalent excitation current.
</html>"));
      end PermanentMagnetWithLosses;

      model InductorDC
        "Ideal linear electrical inductor for electrical DC machines"
        extends Modelica.Electrical.Analog.Interfaces.OnePort;
        parameter Modelica.SIunits.Inductance L(start=1) "Inductance";
        parameter Boolean quasiStationary(start=false)
          "No electrical transients if true" annotation (Evaluate=true);
      equation
        v = if quasiStationary then 0 else L*der(i);
        annotation (defaultComponentName="inductor",
          Documentation(info="<html>
<p>The linear inductor connects the branch voltage <em>v</em> with the branch current <em>i</em> by <em>v = L * di/dt</em>.
If <code>quasiStationary == false</code>, the electrical transients are neglected, i.e., the voltage drop is zero.</p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Ellipse(extent={{-60,-15},{-30,15}},
                lineColor={0,0,255}),Ellipse(extent={{-30,-15},{0,15}},
                lineColor={0,0,255}),Ellipse(extent={{0,-15},{30,15}},
                lineColor={0,0,255}),Ellipse(extent={{30,-15},{60,15}},
                lineColor={0,0,255}),Rectangle(
                      extent={{-60,-30},{60,0}},
                      lineColor={255,255,255},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Line(points={{60,0},{90,0}},
                color={0,0,255}),Line(points={{-90,0},{-60,0}}, color={0,0,255}),
                Text( extent={{-150,-80},{150,-40}},
                      textString="L=%L"),Text(
                      extent={{-150,50},{150,90}},
                      textString="%name",
                      lineColor={0,0,255}),Rectangle(
                      visible=quasiStationary,
                      extent={{-70,30},{70,-30}},
                      lineColor={0,0,255},
                      fillColor={85,170,255},
                      fillPattern=FillPattern.Solid)}));
      end InductorDC;

      partial model PartialAirGapDC "Partial airgap model of a DC machine"
        parameter Boolean quasiStationary(start=false)
          "No electrical transients if true" annotation (Evaluate=true);
        parameter Real turnsRatio
          "Ratio of armature turns over number of turns of the excitation winding";
        output Modelica.SIunits.AngularVelocity w "Angular velocity";
        Modelica.SIunits.Voltage vei
          "Voltage drop across field excitation inductance";
        Modelica.SIunits.Current ie "Excitation current";
        Modelica.SIunits.MagneticFlux psi_e "Excitation flux";
        Modelica.SIunits.Voltage vai "Induced armature voltage";
        Modelica.SIunits.Current ia "Armature current";
        output Modelica.SIunits.Torque tauElectrical;
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (
            Placement(transformation(extent={{-10,110},{10,90}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a support
          "Support at which the reaction torque is acting" annotation (
            Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap annotation (
            Placement(transformation(extent={{-110,110},{-90,90}})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep annotation (
            Placement(transformation(extent={{90,110},{110,90}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_an annotation (
            Placement(transformation(extent={{-110,-110},{-90,-90}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en annotation (
            Placement(transformation(extent={{90,-110},{110,-90}})));
      equation
        // armature pins
        vai = pin_ap.v - pin_an.v;
        ia = +pin_ap.i;
        ia = -pin_an.i;
        // excitation pins
        vei = pin_ep.v - pin_en.v;
        ie = +pin_ep.i;
        ie = -pin_en.i;
        // induced voltage across field excitation inductance
        vei = if quasiStationary then 0 else der(psi_e);
        // mechanical speed
        w = der(flange.phi) - der(support.phi);
        // induced armature voltage
        vai = turnsRatio*psi_e*w;
        // electrical torque (ia is perpendicular to flux)
        tauElectrical = turnsRatio*psi_e*ia;
        flange.tau = -tauElectrical;
        support.tau = tauElectrical;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Ellipse(
                      extent={{-90,90},{90,-92}},
                      lineColor={0,0,255},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-80,80},{80,-80}},
                      lineColor={0,0,255},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Rectangle(
                      extent={{-10,90},{10,-80}},
                      fillPattern=FillPattern.VerticalCylinder,
                      fillColor={128,128,128}),Text(
                      extent={{0,40},{80,-40}},
                      textString="E"),Text(
                      extent={{-150,-160},{150,-120}},
                      lineColor={0,0,255},
                      textString="%name"),Text(
                      extent={{-80,40},{0,-40}},
                      textString="A"),Rectangle(
                      visible=quasiStationary,
                      extent={{-10,90},{10,-80}},
                      lineColor={170,213,255},
                      fillPattern=FillPattern.VerticalCylinder,
                      fillColor={170,213,255})}), Documentation(info="<html>
Linear model of the airgap (without saturation effects) of a DC machine, using only equations.<br>
Induced excitation voltage is calculated from der(flux), where flux is defined by excitation inductance times excitation current.
If <code>quasiStationary == false</code>, the electrical transients are neglected, i.e., the induced excitation voltage is zero.<br>
Induced armature voltage is calculated from flux times angular velocity.
</html>"));
      end PartialAirGapDC;

      model AirGapDC "Linear airgap model of a DC machine"
        extends PartialAirGapDC;
        parameter Modelica.SIunits.Inductance Le "Excitation inductance";
      equation
        // excitation flux: linearly dependent on excitation current
        psi_e = Le*ie;
        annotation (
          defaultComponentName="airGap",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}})),
          Documentation(info="<html>
Linear model of the airgap (without saturation effects) of a DC machine, using only equations.<br>
Induced excitation voltage is calculated from der(flux), where flux is defined by excitation inductance times excitation current.<br>
Induced armature voltage is calculated from flux times angular velocity.
</html>"));
      end AirGapDC;

      model CompoundDCExcitation "Compound excitation = shunt + series"
        parameter Real excitationTurnsRatio
          "Ratio of series excitation turns over shunt excitation turns";
        Modelica.SIunits.Voltage v=pin_p.v - pin_n.v;
        Modelica.SIunits.Current i=pin_p.i;
        Modelica.SIunits.Voltage ve=pin_ep.v - pin_en.v;
        Modelica.SIunits.Current ie=pin_ep.i;
        Modelica.SIunits.Voltage vse=pin_sep.v - pin_sen.v;
        Modelica.SIunits.Current ise=pin_sep.i;
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
          "Positive pin to airgap"
          annotation (Placement(transformation(extent={{90,110},{110,90}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
          "Negative pin to airgap"
          annotation (Placement(transformation(extent={{-110,110},{-90,90}})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          "Positive pin to shunt excitation"
          annotation (Placement(transformation(extent={{90,-108},{110,-88}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          "Negative pin to shunt excitation"
          annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_sep
          "Positive pin to series excitation"
          annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_sen
          "Negative pin to series excitation" annotation (Placement(
              transformation(extent={{-110,-110},{-90,-90}})));
      equation
        //current balances
        pin_p.i + pin_n.i = 0;
        pin_ep.i + pin_en.i = 0;
        pin_sep.i + pin_sen.i = 0;
        //compound currents
        -i = ie + excitationTurnsRatio*ise;
        //induced voltages
        ve = v;
        vse = v*excitationTurnsRatio;
        annotation (defaultComponentName="excitation",
          Icon(graphics={Polygon(
                      points={{-60,-40},{-40,-40},{0,4},{40,-40},{60,-40},{10,
                  20},{10,60},{20,60},{0,80},{-20,60},{-10,60},{-10,20},{-60,-40}},
                      lineColor={0,0,255},
                      fillColor={0,0,255},
                      fillPattern=FillPattern.Solid),Text(
                      extent={{-80,-40},{-40,-80}},
                      lineColor={0,0,255},
                      textString="S"),Text(
                      extent={{40,-40},{80,-80}},
                      lineColor={0,0,255},
                      textString="E")}), Documentation(info="<html>
Model to compound the shunt excitation current and the series excitation current to the total excitation current w.r.t. shunt excitation.
This model is intended to be placed between shunt and series excitation pins and the airgap;
the connection to airgap has to be grounded at one point.
</html>"));
      end CompoundDCExcitation;

      partial model PartialCore
        "Partial model of transformer core with 3 windings"
        parameter Integer m(final min=1) = 3 "Number of phases";
        parameter Real n12(start=1) "Turns ratio 1:2";
        parameter Real n13(start=1) "Turns ratio 1:3";
        Modelica.SIunits.Voltage v1[m]=plug_p1.pin.v - plug_n1.pin.v;
        Modelica.SIunits.Current i1[m]=plug_p1.pin.i;
        Modelica.SIunits.Voltage v2[m]=plug_p2.pin.v - plug_n2.pin.v;
        Modelica.SIunits.Current i2[m]=plug_p2.pin.i;
        Modelica.SIunits.Voltage v3[m]=plug_p3.pin.v - plug_n3.pin.v;
        Modelica.SIunits.Current i3[m]=plug_p3.pin.i;
        Modelica.SIunits.Current im[m]=i1 + i2/n12 + i3/n13
          "Magnetizing current";
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p1(final m=
              m) annotation (Placement(transformation(extent={{-110,90},{-90,110}}), iconTransformation(extent={{-110,90},{-90,110}})));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n1(final m=
              m) annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p2(final m=
              m) annotation (Placement(transformation(extent={{90,90},{110,110}})));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n2(final m=
              m) annotation (Placement(transformation(extent={{90,30},{110,50}})));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p3(final m=
              m) annotation (Placement(transformation(extent={{90,-30},{110,-50}})));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n3(final m=
              m) annotation (Placement(transformation(extent={{90,-90},{110,-110}})));
      equation
        plug_p1.pin.i + plug_n1.pin.i = zeros(m);
        plug_p2.pin.i + plug_n2.pin.i = zeros(m);
        plug_p3.pin.i + plug_n3.pin.i = zeros(m);
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Line(points={{-90,100},{-30,100}},
                      color={0,0,255}),Line(points={{-90,-100},{-30,-100}}, color=
                 {0,0,255}), Line(points={{30,100},{90,100}},
                      color={0,0,255}),Line(points={{30,40},{92,40}}, color={0,0,255}),
                 Line(points={{30,-40},{90,-40}},
                       color={0,0,255}),Line(points={{30,-100},{90,-100}}, color=
                {0,0,255}),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={25,90},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={25,70},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={25,50},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={25,-50},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={25,-70},
                rotation=90),
              Line(
                points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={25,-90},
                rotation=90),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-25,90},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-25,70},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-25,50},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-25,30},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-25,10},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-25,-10},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-25,-30},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-25,-50},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-25,-70},
                rotation=360),
              Line(
                points={{-5,-10},{0,-9},{5,-4},{5,4},{0,9},{-5,10}},
                color={0,0,255},
                smooth=Smooth.Bezier,
                origin={-25,-90},
                rotation=360),
              Text(
                extent={{-150,-110},{150,-150}},
                textString="m=%m"), Text(
                      extent={{-150,150},{150,110}},
                      textString="%name",
                      lineColor={0,0,255})}),
                              Documentation(info="<html>
Partial model of transformer core with 3 windings; saturation function flux versus magnetizing current has to be defined.
</html>"));
      end PartialCore;

      model IdealCore "Ideal transformer with 3 windings"
        extends PartialCore;
      equation
        im = zeros(m);
        v1 = n12*v2;
        v1 = n13*v3;
        annotation (defaultComponentName="core", Documentation(info="<html>
Ideal transformer with 3 windings: no magnetizing current.
</html>"));
      end IdealCore;

      partial model BasicTransformer "Partial model of three-phase transformer"
        extends Machines.Interfaces.PartialBasicTransformer;
        extends Modelica.Icons.ObsoleteModel;
        annotation (Documentation(info="<html>
Partial model of a three-phase transformer, containing primary and secondary resistances and stray inductances, as well as the iron core.
Circuit layout (vector group) of primary and secondary windings have to be defined.<br>
Exactly the same as Interfaces.PartialBasicTransformer, included for compatibility reasons.
</html>"),
        obsolete = "Obsolete model - use Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer instead");
      end BasicTransformer;
      annotation (Documentation(info="<html>
This package contains components for modeling electrical machines, specially three-phase induction machines, based on space phasor theory.
These models use package SpacePhasors.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.02 2004/09/19 Anton Haumer<br>
       added AirGapDC models</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.52 2005/10/12 Anton Haumer<br>
       added electrical excitation</li>
  <li> v1.53 Beta 2005/10/14 Anton Haumer<br>
       introduced unsymmetrical DamperCage for Synchronous Machines</li>
  <li> v2.1.3 2010/02/10 Anton Haumer<br>
       prepared ConditionalHeatPort of SquirrelCage and DamperCage</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"));
    end Components;
    annotation (Documentation(info="<html>
This package contains components for modeling electrical machines, specially three-phase induction machines, based on space phasor theory:
<ul>
<li>package AsynchronousInductionMachines: models of three phase asynchronous induction machines</li>
<li>package SynchronousInductionMachines: models of three phase synchronous induction machines</li>
<li>package DCMachines: models of DC machines with different excitation</li>
<li>package Transformers: Threephase transformers (see detailed documentation in subpackage)</li>
<li>package Components: components for modeling machines and transformers</li>
</ul>
The induction machine models use package SpacePhasors.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.00  2004/09/16 Anton Haumer</li>
  <li> v1.01  2004/09/18 Anton Haumer<br>
       moved common equations from machine models to PartialMachine</li>
  <li> v1.02  2004/09/19 Anton Haumer<br>
       new package structure for machine types<br>
       added DCMachine models</li>
  <li> v1.03  2004/09/24 Anton Haumer<br>
       added DC machine with series excitation</li>
  <li> v1.1   2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.2   2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.3.2 2004/11/10 Anton Haumer<br>
       ReluctanceRotor moved to SynchronousMachines</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v1.53  2005/10/14 Anton Haumer<br>
       introduced unsymmetrical DamperCage for Synchronous Machines</li>
  <li> v1.6.2 2005/10/23 Anton Haumer<br>
       selectable DamperCage for Synchronous Machines</li>
  <li> v1.6.3 2005/11/25 Anton Haumer<br>
       easier parametrization of AsynchronousInductionMachines.AIM_SlipRing model</li>
  <li> v1.7.1 2006/02/06 Anton Haumer<br>
       changed some naming of synchronous machines, not affecting existing models</li>
  <li> v2.1.3 2010/02/10 Anton Haumer<br>
       prepared conditionalHeatPort of SquirrelCage and DamperCage</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"), Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            origin={2.835,10},
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-60,-60},{60,60}}),
          Rectangle(
            origin={2.835,10},
            fillColor={128,128,128},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-80,-60},{-60,60}}),
          Rectangle(
            origin={2.835,10},
            fillColor={95,95,95},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{60,-10},{80,10}}),
          Rectangle(
            origin={2.835,10},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid,
            extent={{-60,50},{20,70}}),
          Polygon(
            origin={2.835,10},
            fillPattern=FillPattern.Solid,
            points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{
                60,-100},{-70,-100},{-70,-90}})}));
  end BasicMachines;

  package Sensors "Sensors for machine modelling"
    extends Modelica.Icons.SensorsPackage;
    model VoltageQuasiRMSSensor "Length of space phasor -> RMS voltage"
      extends Modelica.Icons.RotationalSensor;
      constant Integer m(final min=1) = 3 "Number of phases";
      Modelica.Blocks.Interfaces.RealOutput V(final quantity=
            "ElectricPotential", final unit="V") annotation (Placement(
            transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Electrical.MultiPhase.Sensors.VoltageSensor VoltageSensor1(
          final m=m) annotation (Placement(transformation(extent={{-10,40},{10,
                60}})));
      Modelica.Blocks.Math.Gain Gain1(final k=1/sqrt(2)) annotation (Placement(
            transformation(
            origin={0,-70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasor1(m=m)
        annotation (Placement(transformation(
            origin={0,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.SpacePhasors.Blocks.ToPolar ToPolar1 annotation (Placement(
            transformation(
            origin={0,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(plug_p, VoltageSensor1.plug_p) annotation (Line(points={{-100,0},
              {-100,50},{-10,50}}, color={0,0,255}));
      connect(VoltageSensor1.plug_n, plug_n)
        annotation (Line(points={{10,50},{100,50},{100,0}}, color={0,0,255}));
      connect(VoltageSensor1.v, ToSpacePhasor1.u) annotation (Line(
          points={{0,39},{0,22}}, color={0,0,127}));
      connect(ToSpacePhasor1.y, ToPolar1.u) annotation (Line(
          points={{0,-1},{0,-18}}, color={0,0,127}));
      connect(ToPolar1.y[1], Gain1.u) annotation (Line(
          points={{-1.9984e-15,-41},{-1.9984e-15,-49.5},{0,-49.5},{0,-58}},
                                                              color={0,0,127}));
      connect(Gain1.y, V) annotation (Line(
          points={{0,-81},{0,-110}}, color={0,0,127}));
      annotation (defaultComponentName="voltageRMSSensor",
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Line(points={{-90,0},{-70,0}},
              color={0,0,255}),Line(points={{70,0},{90,0}}, color={0,0,255}),
              Line(points={{0,-70},{0,-100}}, color={0,0,127}),Text(
                  lineColor={0,0,255},
                  extent={{-40,-60},{40,-20}},
                  textString="V RMS"),
                                  Text(
                    extent={{-150,120},{150,80}},
                    textString="%name",
                    lineColor={0,0,255})}),
                                         Documentation(info="<html>
Measured 3-phase instantaneous voltages are transformed to the corresponding space phasor;
output is length of the space phasor divided by sqrt(2), thus giving in sinusoidal stationary state RMS voltage.
</html>"));
    end VoltageQuasiRMSSensor;

    model CurrentQuasiRMSSensor "Length of space phasor -> RMS current"
      extends Modelica.Icons.RotationalSensor;
      constant Integer m(final min=1) = 3 "Number of phases";
      Modelica.Blocks.Interfaces.RealOutput I(final quantity="ElectricCurrent",
          final unit="A") annotation (Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Electrical.MultiPhase.Sensors.CurrentSensor CurrentSensor1(
          final m=m) annotation (Placement(transformation(extent={{-10,40},{10,
                60}})));
      Modelica.Blocks.Math.Gain Gain1(final k=1/sqrt(2)) annotation (Placement(
            transformation(
            origin={0,-70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasor1(m=m)
        annotation (Placement(transformation(
            origin={0,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Machines.SpacePhasors.Blocks.ToPolar ToPolar1 annotation (Placement(
            transformation(
            origin={0,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(plug_p, CurrentSensor1.plug_p) annotation (Line(points={{-100,0},
              {-100,50},{-10,50}}, color={0,0,255}));
      connect(CurrentSensor1.plug_n, plug_n)
        annotation (Line(points={{10,50},{100,50},{100,0}}, color={0,0,255}));
      connect(CurrentSensor1.i, ToSpacePhasor1.u) annotation (Line(
          points={{0,39},{0,22}}, color={0,0,127}));
      connect(ToSpacePhasor1.y, ToPolar1.u) annotation (Line(
          points={{0,-1},{0,-18}}, color={0,0,127}));
      connect(ToPolar1.y[1], Gain1.u) annotation (Line(
          points={{-1.9984e-15,-41},{-1.9984e-15,-50.5},{0,-50.5},{0,-58}},
                                                              color={0,0,127}));
      connect(Gain1.y, I) annotation (Line(
          points={{0,-81},{0,-110}}, color={0,0,127}));
      annotation (defaultComponentName="currentRMSSensor",
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Line(points={{-90,0},{-70,0}},
              color={0,0,255}),Line(points={{70,0},{90,0}}, color={0,0,255}),
              Line(points={{0,-70},{0,-100}}, color={0,0,127}),Text(
                  lineColor={0,0,255},
                  extent={{-40,-60},{40,-20}},
                  textString="A RMS"),
                                  Text(
                    extent={{-150,120},{150,80}},
                    textString="%name",
                    lineColor={0,0,255})}),
                                         Documentation(info="<html>
Measured 3-phase instantaneous currents are transformed to the corresponding space phasor;
output is length of the space phasor divided by sqrt(2), thus giving in sinusoidal stationary state RMS current.
</html>"));
    end CurrentQuasiRMSSensor;

    model ElectricalPowerSensor "Instantaneous power from space phasors"
      extends Modelica.Icons.RotationalSensor;
      constant Integer m(final min=1) = 3 "Number of phases";
      Modelica.Blocks.Interfaces.RealOutput P(final quantity="Power", final
          unit="W") annotation (Placement(transformation(
            origin={-50,110},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealOutput Q(final quantity="Power", final
          unit="var") annotation (Placement(transformation(
            origin={50,110},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_ni(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_nv(final m=m)
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    protected
      Modelica.SIunits.Voltage v_[2];
      Modelica.SIunits.Current i_[2];
    equation
      plug_p.pin.v = plug_ni.pin.v;
      plug_p.pin.i + plug_ni.pin.i = zeros(m);
      plug_nv.pin.i = zeros(m);
      v_ = Machines.SpacePhasors.Functions.ToSpacePhasor(plug_p.pin.v - plug_nv.pin.v);
      i_ = Machines.SpacePhasors.Functions.ToSpacePhasor(plug_p.pin.i);
      2/3*P = +v_[1]*i_[1] + v_[2]*i_[2];
      2/3*Q = -v_[1]*i_[2] + v_[2]*i_[1];
      annotation (defaultComponentName="powerSensor",
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Line(points={{-90,0},{-70,0}},
              color={0,0,255}),Line(points={{70,0},{90,0}}, color={0,0,255}),
              Line(points={{0,-70},{0,-90}}, color={0,0,255}),Line(points={{-10,
              70},{-10,80},{-50,80},{-50,100}}, color={0,0,127}),Line(points={{
              10,70},{10,80},{50,80},{50,100}}, color={0,0,127}),Text(
                  lineColor={0,0,255},
                  extent={{-40,-60},{40,-20}},
                  textString="P Q")}), Documentation(info="<html>
3-phase instantaneous voltages (plug_p - plug_nv) and currents (plug_p - plug_ni) are transformed to the corresponding space phasors,<br>
which are used to calculate power quantities:
<ul>
<li>P = instantaneous power, thus giving in stationary state active power.</li>
<li>Q = giving in stationary state reactive power.</li>
</ul></html>"));
    end ElectricalPowerSensor;

    model MechanicalPowerSensor "Mechanical power = torque x speed"
      extends Modelica.Icons.RotationalSensor;
      extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
      parameter Boolean useSupport=false "Use support or fixed housing"
        annotation (Evaluate=true);
      Modelica.Blocks.Interfaces.RealOutput P(final quantity="Power", final
          unit="W") annotation (Placement(transformation(
            origin={0,110},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Modelica.Blocks.Math.Product product annotation (Placement(transformation(
            origin={0,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Mechanics.Rotational.Sensors.RelSpeedSensor relSpeedSensor
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,-30})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed if (not useSupport)
        annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport
        "Support at which the reaction torque is acting" annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}})));
    equation
      connect(flange_a, torqueSensor.flange_a) annotation (Line(points={{-100,0},
              {-70,0},{-40,0},{20,0}}));
      connect(torqueSensor.flange_b, flange_b)
        annotation (Line(points={{40,0},{100,0}}));
      connect(flange_a, relSpeedSensor.flange_b) annotation (Line(
          points={{-100,0},{-30,0},{-30,-20}}));
      connect(relSpeedSensor.flange_a, fixed.flange) annotation (Line(
          points={{-30,-40},{-30,-90}}));
      connect(relSpeedSensor.flange_a, support) annotation (Line(
          points={{-30,-40},{-30,-80},{0,-80},{0,-100}}));
      connect(relSpeedSensor.w_rel, product.u1) annotation (Line(
          points={{-19,-30},{-6,-30},{-6,18}}, color={0,0,127}));
      connect(torqueSensor.tau, product.u2) annotation (Line(
          points={{22,-11},{22,-20},{6,-20},{6,18}}, color={0,0,127}));
      connect(product.y, P) annotation (Line(
          points={{0,41},{0,110}}, color={0,0,127}));
      annotation (defaultComponentName="powerSensor",
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{90,0}}),Line(points={{0,70},{0,100}}, color=
              {0,0,127}),Rectangle(
                  visible=useSupport,
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  extent={{-20,-120},{20,-80}}),Line(visible=not useSupport,
              points={{-20,-100},{20,-100}}),Line(visible=not useSupport,
              points={{-10,-100},{-20,-120}}),Line(visible=not useSupport,
              points={{0,-100},{-10,-120}}),Line(visible=not useSupport, points=
               {{10,-100},{0,-120}}),Line(visible=not useSupport, points={{20,-100},
              {10,-120}}),Text(
                  lineColor={0,0,255},
                  extent={{-40,-60},{40,-20}},
                  textString="Pmech")}), Documentation(info="<html>
Calculates (mechanical) power from torque times angular speed.
</html>"));
    end MechanicalPowerSensor;

    model RotorDisplacementAngle "Rotor lagging angle"
      parameter Integer m=3 "Number of phases";
      parameter Integer p(min=1) "Number of pole pairs";
      parameter Boolean positiveRange=false "Use only positive output range, if true";
      parameter Real threshold(final min=0)=0 "Below threshold the voltage is considered as zero";
      parameter Boolean useSupport=false "Use support or fixed housing"
        annotation (Evaluate=true);
      Modelica.Blocks.Interfaces.RealOutput rotorDisplacementAngle(final
          quantity="Angle", final unit="rad") annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
      Modelica.Electrical.MultiPhase.Sensors.VoltageSensor VoltageSensor1(
          final m=m) annotation (Placement(transformation(
            origin={-80,0},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasorVS(final m=m) annotation (
          Placement(transformation(extent={{-50,-10},{-30,10}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (
          Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relativeAngleSensor
        annotation (Placement(transformation(extent={{40,70},{20,90}})));
      Modelica.Blocks.Sources.Constant constant_(final k=Modelica.Constants.pi/
            2) annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
      Modelica.Blocks.Math.Add add(final k2=1, final k1=p) annotation (
          Placement(transformation(
            origin={-10,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotatorVS2R
        annotation (Placement(transformation(extent={{-20,10},{0,-10}})));
      Modelica.Electrical.Machines.SpacePhasors.Blocks.ToPolar ToPolarVSR
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport
        "support at which the reaction torque is acting" annotation (Placement(
            transformation(extent={{90,90},{110,110}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed if (not useSupport)
        annotation (Placement(transformation(extent={{90,70},{110,90}})));
      Blocks.Math.WrapAngle wrapAngle(final positiveRange=positiveRange)
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      SpacePhasors.Blocks.LessThreshold lessThreshold(final threshold=threshold)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    equation
      connect(plug_p, VoltageSensor1.plug_p) annotation (Line(points={{-100,60},{-80,
              60},{-80,10}},      color={0,0,255}));
      connect(plug_n, VoltageSensor1.plug_n) annotation (Line(points={{-100,-60},{-80,
              -60},{-80,-10}},      color={0,0,255}));
      connect(relativeAngleSensor.flange_b, flange)
        annotation (Line(points={{20,80},{0,80},{0,100}}));
      connect(relativeAngleSensor.flange_a, support) annotation (Line(
          points={{40,80},{60,80},{60,100},{100,100}}));
      connect(relativeAngleSensor.flange_a, fixed.flange) annotation (Line(
          points={{40,80},{100,80}}));
      connect(relativeAngleSensor.phi_rel, add.u1) annotation (Line(
          points={{30,69},{30,50},{-4,50},{-4,42}}, color={0,0,127}));
      connect(constant_.y, add.u2) annotation (Line(
          points={{-29,50},{-16,50},{-16,42}}, color={0,0,127}));
      connect(VoltageSensor1.v, ToSpacePhasorVS.u) annotation (Line(
          points={{-69,0},{-52,0}}, color={0,0,127}));
      connect(ToSpacePhasorVS.y, rotatorVS2R.u) annotation (Line(
          points={{-29,0},{-22,0}}, color={0,0,127}));
      connect(rotatorVS2R.y, ToPolarVSR.u) annotation (Line(
          points={{1,0},{8,0}},  color={0,0,127}));
      connect(add.y, rotatorVS2R.angle) annotation (Line(
          points={{-10,19},{-10,12}}, color={0,0,127}));
      connect(wrapAngle.y, rotorDisplacementAngle) annotation (Line(points={{91,0},{
              110,0}},                                                                       color={0,0,127}));
      connect(ToPolarVSR.y, lessThreshold.u)
        annotation (Line(points={{31,0},{38,0}}, color={0,0,127}));
      connect(lessThreshold.y, wrapAngle.u)
        annotation (Line(points={{61,0},{68,0}}, color={0,0,127}));
      annotation (defaultComponentName="angleSensor",
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Ellipse(
                  extent={{-60,80},{60,40}},
                  lineColor={0,255,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-60,-40},{60,-80}},
                  lineColor={0,255,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-60,60},{60,40}},
                  lineColor={0,255,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-60,-40},{60,-60}},
                  lineColor={0,255,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-40,40},{40,-40}},
                  lineColor={0,255,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,0},{-80,80}},
              color={0,0,255}),Polygon(
                  points={{-80,80},{-68,76},{-76,68},{-80,80}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,0},{0,80}},
              color={0,255,0}),Polygon(
                  points={{0,84},{4,72},{-4,72},{0,84}},
                  lineColor={0,255,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{80,120},{120,80}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(
                  visible=not useSupport,
                  points={{80,100},{120,100}}),Line(
                  visible=not useSupport,
                  points={{90,120},{80,100}}),Line(
                  visible=not useSupport,
                  points={{100,120},{90,100}}),Line(
                  visible=not useSupport,
                  points={{110,120},{100,100}}),Line(
                  visible=not useSupport,
                  points={{120,120},{110,100}})}),
        Documentation(info="<html>
Calculates rotor lagging angle by measuring the stator phase voltages, transforming them to the corresponding space phasor in stator-fixed coordinate system,<br>
rotating the space phasor to the rotor-fixed coordinate system and calculating the angle of this space phasor.
<p>
The sensor's housing can be implicitly fixed (useSupport=false).<br>
If the machine's stator also implicitly fixed (useSupport=false), the angle at the flange
is equal to the angle of the machine's rotor against the stator.<br>
Otherwise, the sensor's support has to be connected to the machine's support.
</p>
</html>"));
    end RotorDisplacementAngle;

    model HallSensor "Hall sensor"
      import Modelica.Constants.pi;
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
      parameter Integer p(final min=1, start=2) "Number of pole pairs";
      parameter Modelica.SIunits.Angle phi0=-pi/p "Initial mechanical angle";
      Modelica.Blocks.Interfaces.RealOutput y(
        quantity="Angle",
        final unit="rad",
        displayUnit="deg") "\"Electrical angle\""
        annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
    equation
      flange.tau=0;
      y=rem((flange.phi - phi_support - phi0)*p, 2*pi);
       annotation (
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
              extent={{-100,-60},{100,-80}},
              lineColor={28,108,200},
              textString="p=%p"),
            Ellipse(extent={{-60,60},{60,-60}}, lineColor={28,108,200},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{0,0},{0,60}},  color={28,108,200}),
            Line(points={{0,-30},{0,30}},color={28,108,200},
              origin={-26,15},
              rotation=60),
            Line(points={{0,-30},{0,30}},color={28,108,200},
              origin={26,15},
              rotation=-60),
            Line(points={{0,-60},{0,0}}, color={28,108,200}),
            Line(points={{0,-30},{0,30}},color={28,108,200},
              origin={26,-15},
              rotation=60),
            Line(points={{0,-30},{0,30}},color={28,108,200},
              origin={-26,-15},
              rotation=-60),
            Ellipse(extent={{-20,20},{20,-20}}, lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-60,0},{-100,0}}, color={28,108,200}),
            Line(points={{100,0},{60,0}}, color={28,108,200}),
            Text(
              extent={{-100,100},{100,60}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              textString="%name")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>
Simple model of a hall sensor, i.e. measuring the angle of the flange (w.r.t. the optional support), multiplying by the number of phases p to obtain the electrical angle,
and adding a correction term i.e. the initial angle of the flange phi0.
</p>
<p>
Note that phi0 has to be set that way, that in shaft position phi0 the flux linkage of phase 1 is a maximum.
</p>
</html>"));
    end HallSensor;
    annotation (Documentation(info="<html>
This package contains sensors that are useful when modelling machines.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.03 2004/09/24 Anton Haumer</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed RotorDisplacementAngle</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support, also in sensor RotorDisplacementAngle<br>
       to ease the implementation of a 3D-frame in a future release</li>
  </ul>
</html>"));
  end Sensors;

  package SpacePhasors "Library with space phasor-models"
    extends Modelica.Icons.Package;
    package Components "Basic space phasor models"
      extends Modelica.Icons.Package;
      model SpacePhasor
        "Physical transformation: three phase <-> space phasors"
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Real turnsRatio=1 "Turns ratio";
        Modelica.SIunits.Voltage v[m] "Instantaneous phase voltages";
        Modelica.SIunits.Current i[m] "Instantaneous phase currents";
      protected
        parameter Real TransformationMatrix[2, m]=2/m*{{cos(+(k - 1)/m*2*pi)
            for k in 1:m},{+sin(+(k - 1)/m*2*pi) for k in 1:m}};
        parameter Real InverseTransformation[m, 2]={{cos(-(k - 1)/m*2*pi),-sin(
            -(k - 1)/m*2*pi)} for k in 1:m};
      public
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
          annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
          annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
        Modelica.Electrical.Analog.Interfaces.PositivePin zero annotation (
            Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin ground annotation (
            Placement(transformation(extent={{90,-110},{110,-90}})));
        Machines.Interfaces.SpacePhasor spacePhasor annotation (Placement(
              transformation(extent={{90,90},{110,110}})));
      equation
        v/turnsRatio = plug_p.pin.v - plug_n.pin.v;
        i*turnsRatio = +plug_p.pin.i;
        i*turnsRatio = -plug_n.pin.i;
        m*zero.v = sum(v);
        spacePhasor.v_ = TransformationMatrix*v;
        //v  = fill(zero.v,m) + InverseTransformation*spacePhasor.v_;
        -m*zero.i = sum(i);
        -spacePhasor.i_ = TransformationMatrix*i;
        //-i  = fill(zero.i,m) + InverseTransformation*spacePhasor.i_;
        ground.v = 0;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Line(points={{0,0},{80,80},{60,72},{72,60},{80,80}}, color={0,0,255}),
              Line(points={{0,0},{80,-80},{72,-60},{60,-72},{80,-80}}, color={0,0,255}),
              Line(
                points={{-80,0},{-73.33,10},{-66.67,17.32},{-60,20},{-53.33,
                    17.32},{-46.67,10},{-40,0},{-33.33,-10},{-26.67,-17.32},{-20,
                    -20},{-13.33,-17.32},{-6.67,-10},{0,0}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{-90,0},{-83.33,10},{-76.67,17.32},{-70,20},{-63.33,
                    17.32},{-56.67,10},{-50,0},{-43.33,-10},{-36.67,-17.32},{-30,
                    -20},{-23.33,-17.32},{-16.67,-10},{-10,0}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Line(
                points={{-70,0},{-63.33,10},{-56.67,17.32},{-50,20},{-43.33,
                    17.32},{-36.67,10},{-30,0},{-23.33,-10},{-16.67,-17.32},{-10,
                    -20},{-3.33,-17.32},{3.33,-10},{10,0}},
                color={0,0,255},
                smooth=Smooth.Bezier),
              Text(
                extent={{-150,-120},{150,-160}},
                lineColor={0,0,255},
                textString="%name"),
              Text(
                extent={{40,10},{90,-10}},
                lineColor={0,0,255},
                textString="zero"),
              Line(points={{90,-100},{60,-100}}, color={0,0,255}),
              Line(points={{60,-84},{60,-116}}, color={0,0,255}),
              Line(points={{50,-90},{50,-110}}, color={0,0,255}),
              Line(points={{40,-96},{40,-104}}, color={0,0,255})}),
            Documentation(info="<html>
Physical transformation of voltages and currents: three phases &lt;-&gt; space phasors:<br>
x[k] = X0 + {cos(-(k - 1)/m*2*pi),-sin(-(k - 1)/m*2*pi)}*X[Re,Im]<br>
and vice versa:<br>
X0 = sum(x[k])/m<br>
X[Re,Im] = sum(2/m*{cos((k - 1)/m*2*pi),sin((k - 1)/m*2*pi)}*x[k])<br>
were x designates three phase values, X[Re,Im] designates the space phasor and X0 designates the zero sequence system.<br>
<em>Physical transformation</em> means that both voltages and currents are transformed in both directions.<br>
Zero-sequence voltage and current are present at pin zero. An additional zero-sequence impedance could be connected between pin zero and pin ground.
</html>"));
      end SpacePhasor;

      model Rotator "Rotates space phasor"
        import Modelica.Constants.pi;
      protected
        Real RotationMatrix[2, 2]={{+cos(-angle),-sin(-angle)},{+sin(-angle),+
            cos(-angle)}};
        //Real InverseRotator[2,2] = {{+cos(+angle),-sin(+angle)},{+sin(+angle),+cos(+angle)}};
      public
        Machines.Interfaces.SpacePhasor spacePhasor_a annotation (Placement(
              transformation(extent={{-110,90},{-90,110}})));
        Machines.Interfaces.SpacePhasor spacePhasor_b annotation (Placement(
              transformation(extent={{90,90},{110,110}})));
        Modelica.Blocks.Interfaces.RealInput angle annotation (Placement(
              transformation(
              origin={0,-120},
              extent={{-20,-20},{20,20}},
              rotation=90)));
      equation
        spacePhasor_b.v_ = RotationMatrix*spacePhasor_a.v_;
        //spacePhasor_a.v_ = InverseRotator*spacePhasor_b.v_;
        spacePhasor_b.i_ + RotationMatrix*spacePhasor_a.i_ = zeros(2);
        //spacePhasor_a.i_ + InverseRotator*spacePhasor_b.i_ = zeros(2);
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
                                           Line(points={{0,0},{80,0},{60,10},{
                60,-10},{80,0}}, color={0,0,255}),Line(points={{0,0},{0,80},{-10,
                60},{10,60},{0,80}}, color={0,0,255}),Polygon(
                      points={{50,0},{42,14},{54,16},{50,0}},
                      lineColor={0,0,255},
                      fillColor={0,0,255},
                      fillPattern=FillPattern.Solid),
              Line(
                points={{0,50},{18,48},{32,40},{42,28},{48,16},{50,0}},
                color={0,0,255},
                smooth=Smooth.Bezier)}),      Documentation(info="<html>
Rotates space phasors of left connector to right connector by the angle provided by the input signal \"angle\" from one coordinate system into another.
</html>"));
      end Rotator;
      annotation (Documentation(info="<html>
This package contains basic space phasor models.<br>
Real and imaginary part of voltage space phasor are the potentials v_[2] of the space phasor connector; (implicit grounded).<br>
Real and imaginary part of current space phasor are the currents i_[2] at the space phasor connector;
a ground has to be used where necessary for currents flowing back.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.60 2005/11/03 Anton Haumer<br>
       added Rotator</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
</html>"));
    end Components;

    package Blocks "Blocks for space phasor transformation"
      extends Modelica.Icons.Package;

      block Rotator "Rotates space phasor"
        extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
      protected
        Real RotationMatrix[2, 2]={{+cos(-angle),-sin(-angle)},{+sin(-angle),+
            cos(-angle)}};
        //Real InverseRotator[2,2] = {{+cos(+angle),-sin(+angle)},{+sin(+angle),+cos(+angle)}};
      public
        Modelica.Blocks.Interfaces.RealInput angle(unit="rad") annotation (Placement(
              transformation(
              origin={0,-120},
              extent={{-20,-20},{20,20}},
              rotation=90)));
      equation
        y = RotationMatrix*u;
        //u = InverseRotator*y;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Line(points={{0,0},{0,80},{-10,
                60},{10,60},{0,80}}, color={0,0,255}),Line(points={{0,0},{80,0},
                {60,10},{60,-10},{80,0}}, color={0,0,255}),
                                           Polygon(
                      points={{50,0},{42,14},{54,16},{50,0}},
                      lineColor={0,0,255},
                      fillColor={0,0,255},
                      fillPattern=FillPattern.Solid),Text(
                      extent={{-88,-72},{84,-92}},
                      textString="angle"),
              Line(
                points={{0,50},{18,48},{32,40},{42,28},{48,16},{50,0}},
                color={0,0,255},
                smooth=Smooth.Bezier)}),     Documentation(info="<html>
Rotates a space phasor (voltage or current) input <code>u</code> by the <code>angle</code> in negative mathematical direction. This block represents the transformation of one space phasor <code>u</code> from one rotating reference (coordinate) frame into another where the space phasor is <code>y</code>. The output reference frame leads the input reference frame by angle <code>angle</code>.

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/Rotator.png\">
    </td>
  </tr>
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Original and rotated reference frame of a space phasor </caption>
</table>

</html>"));
      end Rotator;

      block ToSpacePhasor
        "Conversion of multi phase instantaneous values to space phasors"
        extends Modelica.Blocks.Interfaces.MIMO(final nin=m, final nout=2);
        parameter Integer m(min=1) = 3 "Number of phases";
      protected
        parameter Modelica.SIunits.Angle phi[m]=
            Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m);
        parameter Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
        parameter Real InverseTransformation[m, 2]={{+cos(-phi[k]),-sin(-phi[k])}
            for k in 1:m};
      public
        Modelica.Blocks.Interfaces.RealOutput zero "Zero sequence component"
          annotation (Placement(transformation(extent={{100,-70},{120,-90}})));
      equation
        m*zero = sum(u);
        y = TransformationMatrix*u;
        //u = fill(zero,m) + InverseTransformation*y;
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Line(points={{0,0},{80,80},{60,72},{72,
                60},{80,80}}, color={0,0,255}),Line(points={{0,0},{80,-80},{72,
                -60},{60,-72},{80,-80}}, color={0,0,255}),Line(
                      points={{-80,0},{-73.33,10},{-66.67,17.32},{-60,20},{-53.33,
                  17.32},{-46.67,10},{-40,0},{-33.33,-10},{-26.67,-17.32},{-20,
                  -20},{-13.33,-17.32},{-6.67,-10},{0,0}},
                      color={0,0,255},
                      smooth=Smooth.Bezier),Line(
                      points={{-90,0},{-83.33,10},{-76.67,17.32},{-70,20},{-63.33,
                  17.32},{-56.67,10},{-50,0},{-43.33,-10},{-36.67,-17.32},{-30,
                  -20},{-23.33,-17.32},{-16.67,-10},{-10,0}},
                      color={0,0,255},
                      smooth=Smooth.Bezier),Line(
                      points={{-70,0},{-63.33,10},{-56.67,17.32},{-50,20},{-43.33,
                  17.32},{-36.67,10},{-30,0},{-23.33,-10},{-16.67,-17.32},{-10,
                  -20},{-3.33,-17.32},{3.33,-10},{10,0}},
                      color={0,0,255},
                      smooth=Smooth.Bezier),Text(
                      extent={{-12,-74},{64,-86}},
                      textString="zero")}),
          Documentation(info="<html>
Transformation of multi phase values (of voltages or currents) to space phasor and zero sequence value.
</html>"));
      end ToSpacePhasor;

      block FromSpacePhasor
        "Conversion of space phasors to multi phase instantaneous values"
        extends Modelica.Blocks.Interfaces.MIMO(final nin=2, final nout=m);
        parameter Integer m(min=1) = 3 "Number of phases";
      protected
        parameter Modelica.SIunits.Angle phi[m]=
            Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m);
        parameter Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
        parameter Real InverseTransformation[m, 2]={{+cos(-phi[k]),-sin(-phi[k])}
            for k in 1:m};
      public
        Modelica.Blocks.Interfaces.RealInput zero "Zero sequence component"
          annotation (Placement(transformation(extent={{-140,-60},{-100,-100}})));
      equation
        y = fill(zero, m) + InverseTransformation*u;
        //m*zero = sum(y);
        //u = TransformationMatrix *y;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Line(points={{0,0},{-80,80},{-60,
                72},{-72,60},{-80,80}}, color={0,0,255}),Line(points={{0,0},{-80,
                -80},{-72,-60},{-60,-72},{-80,-80}}, color={0,0,255}),Line(
                      points={{0,0},{6.67,10},{13.33,17.32},{20,20},{26.67,
                  17.32},{33.33,10},{40,0},{46.67,-10},{53.33,-17.32},{60,-20},
                  {66.67,-17.32},{73.33,-10},{80,0}},
                      color={0,0,255},
                      smooth=Smooth.Bezier),Line(
                      points={{-10,0},{-3.33,10},{3.33,17.32},{10,20},{16.67,
                  17.32},{23.33,10},{30,0},{36.67,-10},{43.33,-17.32},{50,-20},
                  {56.67,-17.32},{63.33,-10},{70,0}},
                      color={0,0,255},
                      smooth=Smooth.Bezier),Line(
                      points={{10,0},{16.67,10},{23.33,17.32},{30,20},{36.67,
                  17.32},{43.33,10},{50,0},{56.67,-10},{63.33,-17.32},{70,-20},
                  {76.67,-17.32},{83.33,-10},{90,0}},
                      color={0,0,255},
                      smooth=Smooth.Bezier),Text(
                      extent={{-62,-74},{14,-86}},
                      textString="zero")}), Documentation(info="<html>
Transformation of space phasor and zero sequence value to multi phase values (of voltages or currents).
</html>"));
      end FromSpacePhasor;

      block ToPolar "Converts a space phasor to polar coordinates"
        extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
        constant Real small=Modelica.Constants.small;
      equation
        y[1] = sqrt(u[1]^2 + u[2]^2);
        y[2] = if noEvent(y[1] <= small) then 0 else Modelica.Math.atan2(u[2],
          u[1]);
        /*
  if y[1] <= small then
    y[2] = 0;
  else
    if u[2] >= 0 then
      y[2] =  Modelica.Math.acos(u[1]/y[1]);
    else
      y[2] = -Modelica.Math.acos(u[1]/y[1]);
    end if;
  end if;
*/
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Line(points={{-60,60},{-60,-60},
                {60,-60}}, color={0,0,255}),Line(points={{-100,-100},{100,100}},
                color={0,0,255}),Polygon(points={{26,26},{14,20},{20,14},{26,26}},
                lineColor={0,0,255}),Line(
                      points={{-18,-18},{-14,-22},{-10,-28},{-6,-34},{-2,-44},{
                  0,-52},{0,-60}},
                      color={0,0,255},
                      smooth=Smooth.Bezier),Polygon(points={{-18,-18},{-14,-26},
                {-10,-22},{-18,-18}}, lineColor={0,0,255}),Text(
                      extent={{-100,100},{-6,-6}},
                      lineColor={0,0,255},
                      textString="R"),Text(
                      extent={{6,6},{100,-100}},
                      lineColor={0,0,255},
                      textString="P")}), Documentation(info="<html>
Converts a space phasor from rectangular coordinates to polar coordinates.
</html>"));
      end ToPolar;

      block FromPolar "Converts a space phasor from polar coordinates"
        extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
      equation
        y = u[1]*{cos(u[2]),sin(u[2])};
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Line(points={{-60,60},{-60,-60},
                {60,-60}}, color={0,0,255}),Line(points={{-100,-100},{100,100}},
                color={0,0,255}),Polygon(points={{26,26},{14,20},{20,14},{26,26}},
                lineColor={0,0,255}),Line(
                      points={{-18,-18},{-14,-22},{-10,-28},{-6,-34},{-2,-44},{
                  0,-52},{0,-60}},
                      color={0,0,255},
                      smooth=Smooth.Bezier),Polygon(points={{-18,-18},{-14,-26},
                {-10,-22},{-18,-18}}, lineColor={0,0,255}),Text(
                      extent={{-100,100},{-6,-6}},
                      lineColor={0,0,255},
                      textString="P"),Text(
                      extent={{6,6},{100,-100}},
                      lineColor={0,0,255},
                      textString="R")}), Documentation(info="<html>
Converts a space phasor from polar coordinates to rectangular coordinates.
</html>"));
      end FromPolar;

      block QuasiRMS
        extends Modelica.Blocks.Interfaces.MISO(final nin=2);
        Modelica.Electrical.Machines.SpacePhasors.Blocks.ToPolar toPolar
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        Modelica.Blocks.Math.Gain gain(final k=1/sqrt(2))
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      equation
        connect(u, toPolar.u) annotation (Line(
            points={{-120,0},{-42,0}}, color={0,0,127}));
        connect(toPolar.y[1], gain.u) annotation (Line(
            points={{-19,0},{0,0},{0,0},{18,0}},       color={0,0,127}));
        connect(gain.y, y) annotation (Line(
            points={{41,0},{110,0}}, color={0,0,127}));
        annotation (
          Documentation(info="<html>
<p>
This model determines the RMS value of the input space phasor <code>u</code>.</p> </html>"),
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Text(
                      extent={{-60,40},{60,-20}},
                      lineColor={0,0,255},
                      textString="RMS")}));
      end QuasiRMS;

      block LessThreshold "Sets angle to zero when length is below threshold"
        extends Modelica.Blocks.Interfaces.MISO(final nin=2);
        parameter Real threshold(final min=0) "Threshold";
      equation
        y = if noEvent(u[1]<threshold) then 0 else u[2];
      end LessThreshold;
      annotation (Documentation(info="<html>
This package contains space phasor transformation blocks for use in controllers:
<ul>
<li>ToSpacePhasor: transforms a set of multi phase values to space phasor and zero sequence system</li>
<li>FromSpacePhasor: transforms a space phasor and zero sequence system to a set of multi phase values</li>
<li>Rotator: rotates a space phasor (from one coordinate system into another)</li>
<li>ToPolar: Converts a space phasor from rectangular coordinates to polar coordinates</li>
<li>FromPolar: Converts a space phasor from polar coordinates to rectangular coordinates</li>
</ul>
<p>
Space phasors are defined as vectors of length = 2,
the first element representing the real part and the second element representing the imaginary part of the space phasor.
</p>
</html>", revisions="<html>
  <dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.30 2004/11/05 Anton Haumer<br>
       several improvements in SpacePhasors.Blocks</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
</html>"));
    end Blocks;

    package Functions "Functions for space phasor transformation"
      extends Modelica.Icons.FunctionsPackage;
      function ToSpacePhasor
        "Conversion from multi phase input to space phasor and zero sequence component"
        import Modelica.Constants.pi;
        extends Modelica.Icons.Function;
        input Real x[:] "Multi phase (voltage or current) input";
        output Real y[2] "Space phasor";
        output Real y0 "Zero sequence component (of voltage or current)";
      protected
        parameter Integer m=size(x, 1) "Number of phases";
        parameter Modelica.SIunits.Angle phi[m]=
            Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m);
        parameter Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
        parameter Real InverseTransformation[m, 2]={{+cos(-phi[k]),-sin(-phi[k])}
            for k in 1:m};
      algorithm
        y := TransformationMatrix*x;
        y0 := 1/m*sum(x);
        annotation (Inline=true, Documentation(info="<html>
Transformation of multi phase values (of voltages or currents) to space phasor and zero sequence value.
</html>"));
      end ToSpacePhasor;

      function FromSpacePhasor
        "Conversion from space phasor and zero sequence component to multi phase"
        import Modelica.Constants.pi;
        extends Modelica.Icons.Function;
        input Real x[2] "Space phasor";
        input Real x0 "Zero sequence component";
        input Integer m "Number of phases";
        output Real y[m] "Multi phase output";
      protected
        parameter Modelica.SIunits.Angle phi[m]=
            Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m);
        parameter Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
        parameter Real InverseTransformation[m, 2]={{+cos(-phi[k]),-sin(-phi[k])}
            for k in 1:m};

      algorithm
        y := fill(x0, m) + InverseTransformation*x;

        annotation (Inline=true, Documentation(info="<html>
Transformation of space phasor and zero sequence value to multi phase values (of voltages or currents).
</html>"));
      end FromSpacePhasor;

      function Rotator "Rotates space phasor"
        extends Modelica.Icons.Function;
        input Real x[2] "Input space phasor";
        input Modelica.SIunits.Angle angle "Input angle of rotation";
        output Real y[2] "Output space phasor";
      protected
        Real RotationMatrix[2, 2]={{+cos(-angle),-sin(-angle)},{+sin(-angle),+
            cos(-angle)}};
      algorithm
        y := RotationMatrix*x;
        annotation (Inline=true, Documentation(info="<html>
Rotates a space phasor (voltage or current) input <code>u</code> by the <code>angle</code> in negative mathematical direction. This block represents the transformation of one space phasor <code>u</code> from one rotating reference (coordinate) frame into another where the space phasor is <code>y</code>. The output reference frame leads the input reference frame by angle <code>angle</code>.

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/Rotator.png\">
    </td>
  </tr>
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Original and rotated reference frame of a space phasor </caption>
</table>
</html>"));
      end Rotator;

      function ToPolar "Converts a space phasor to polar coordinates"
        extends Modelica.Icons.Function;
        input Real x[2] "Real and imaginary part of space phasor";
        output Real absolute "Magnitude of space phasor";
        output Modelica.SIunits.Angle angle "Angle of space phasor";
      protected
        constant Real small=Modelica.Constants.small;
      algorithm
        absolute := sqrt(x[1]^2 + x[2]^2);
        angle := if absolute <= small then 0 else Modelica.Math.atan2(x[2], x[1]);
        /*
  if absolute <= small then
    angle := 0;
  else
    if x[2] >= 0 then
      angle :=  Modelica.Math.acos(x[1]/absolute);
    else
      angle := -Modelica.Math.acos(x[1]/absolute);
    end if;
  end if;
*/
        annotation (Inline=true, Documentation(info="<html>
Converts a space phasor from rectangular coordinates to polar coordinates, providing angle=0 for {0,0}.
</html>"));
      end ToPolar;

      function FromPolar "Converts a space phasor from polar coordinates"
        extends Modelica.Icons.Function;
        input Real absolute "Magnitude of space phasor";
        input Modelica.SIunits.Angle angle "Angle of space phasor";
        output Real x[2] "Real and imaginary part of space phasor";
      protected
        constant Real small=Modelica.Constants.small;
      algorithm
        x := absolute*{cos(angle),sin(angle)};
        annotation (Inline=true, Documentation(info="<html>
Converts a space phasor from polar coordinates to rectangular coordinates.
</html>"));
      end FromPolar;

      function quasiRMS "Calculate quasi-RMS value of input"
        extends Modelica.Icons.Function;
        import Modelica.Constants.pi;
        input Real x[3];
        output Real y;
      protected
        Integer m=size(x, 1) "Number of phases";
        Modelica.SIunits.Angle phi[m]=
            Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m);
        Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
        Real h[2]=TransformationMatrix*x;
      algorithm
        y := sqrt(h[1]^2 + h[2]^2)/sqrt(2);
        annotation (Inline=true, Documentation(info="<html>
  Transformation of m phase values (voltages or currents) to space phasor and calculate length of space phasor / sqrt(2).
</html>"));
      end quasiRMS;

      function activePower
        "Calculate active power of voltage and current input"
        import Modelica.Constants.pi;
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Voltage v[m] "phase voltages";
        input Modelica.SIunits.Current i[m] "phase currents";
        output Modelica.SIunits.Power p "Active power";
      protected
        constant Integer m=3 "Number of phases";
        Modelica.SIunits.Voltage v_[2] "Voltage space phasor";
        Modelica.SIunits.Current i_[2] "Current space phasor";
      algorithm
        v_ := zeros(2);
        i_ := zeros(2);
        for k in 1:m loop
          v_ := v_ + 2/m*{+cos((k - 1)/m*2*pi),+sin(+(k - 1)/m*2*pi)}*v[k];
          i_ := i_ + 2/m*{+cos((k - 1)/m*2*pi),+sin(+(k - 1)/m*2*pi)}*i[k];
        end for;
        p := m/2*(+v_[1]*i_[1] + v_[2]*i_[2]);
        annotation (Inline=true, Documentation(info="<html>
Transformation of three phase voltages and currents to space phasors and calculate active power.
</html>"));
      end activePower;
      annotation (Documentation(info="<html>
This package contains space phasor transformation functions for use in calculations:
<ul>
<li>ToSpacePhasor: transforms a set of three-phase values to space phasor and zero sequence system</li>
<li>FromSpacePhasor: transforms a space phasor and zero sequence system to a set of three-phase values</li>
<li>Rotator: rotates a space phasor (from one coordinate system into another)</li>
<li>ToPolar: Converts a space phasor from rectangular coordinates to polar coordinates</li>
<li>FromPolar: Converts a space phasor from polar coordinates to rectangular coordinates</li>
</ul>
<p>
Space phasors are defined as vectors of length = 2,
the first element representing the real part and the second element representing the imaginary part of the space phasor.
</p>
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>

  <dt><strong>Release Notes:</strong></dt>
  <dd>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
  </dd>

  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
</html>"));
    end Functions;
    annotation (Documentation(info="<html>
<p>
This package contains components, blocks and functions to utilize space phasor theory.
</p>
<p>
Space phasors are defined as vectors of length = 2,
the first element representing the real part and the second element representing the imaginary part of the space phasor.
</p>
<p>
You may have a look at a short summary of space phasor theory at <a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">https://www.haumer.at/refimg/SpacePhasors.pdf</a>
</p>
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.30 2004/11/05 Anton Haumer<br>
       several improvements in SpacePhasors.Blocks</li>
  <li> v1.60 2005/11/03 Anton Haumer<br>
       added Components.Rotator</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       improved Transformation and Rotation</li>
  </ul>
</html>"));
  end SpacePhasors;

  package Losses "Loss models for electric machines"
    extends Modelica.Icons.Package;
    record FrictionParameters "Parameter record for friction losses"
      extends Modelica.Icons.Record;
      parameter Modelica.SIunits.Power PRef(min=0) = 0
        "Reference friction losses at wRef";
      parameter Modelica.SIunits.AngularVelocity wRef(displayUnit="rev/min", min=
            Modelica.Constants.small)
        "Reference angular velocity that the PRef refer to";
      parameter Real power_w(min=Modelica.Constants.small) = 2
        "Exponent of friction torque w.r.t. angular velocity";
      final parameter Modelica.SIunits.Torque tauRef=if (PRef <= 0) then 0
           else PRef/wRef
        "Reference friction torque at reference angular velocity";
      final parameter Real linear=0.001
        "Linear angular velocity range with respect to reference angular velocity";
      final parameter Modelica.SIunits.AngularVelocity wLinear=linear*wRef
        "Linear angular velocity range";
      final parameter Modelica.SIunits.Torque tauLinear=if (PRef <= 0) then 0
           else tauRef*(wLinear/wRef)^power_w
        "Torque corresponding with linear angular velocity range";
      annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
Parameter record for <a href=\"modelica://Modelica.Electrical.Machines.Losses.Friction\">Friction</a> losses.
</p>
</html>"));
    end FrictionParameters;

    record BrushParameters "Parameter record for brush losses"
      extends Modelica.Icons.Record;
      parameter Modelica.SIunits.Voltage V=0
        "Total voltage drop of brushes for currents > ILinear";
      parameter Modelica.SIunits.Current ILinear(start=0.01)
        "Current indicating linear voltage region of brush voltage drop";
      annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
Parameter record for <a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.Brush\">three-phase Brush</a> and
<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">DC Brush</a> losses.
</p>
</html>"));
    end BrushParameters;

    record StrayLoadParameters "Parameter record for stray load losses"
      extends Modelica.Icons.Record;
      parameter Modelica.SIunits.Power PRef(min=0) = 0
        "Reference stray load losses at IRef and wRef";
      parameter Modelica.SIunits.Current IRef(min=Modelica.Constants.small)
        "Reference RMS current that PRef refers to";
      parameter Modelica.SIunits.AngularVelocity wRef(displayUnit="rev/min", min=
            Modelica.Constants.small)
        "Reference angular velocity that PRef refers to";
      parameter Real power_w(min=Modelica.Constants.small) = 1
        "Exponent of stray load loss torque w.r.t. angular velocity";
      final parameter Modelica.SIunits.Torque tauRef=if (PRef <= 0) then 0
           else PRef/wRef
        "Reference stray load torque at reference angular velocity and reference current";
      annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
Parameter record for <a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.StrayLoad\">three-phase</a> and
<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.StrayLoad\">DC</a> stray load losses.
</p>
</html>"));
    end StrayLoadParameters;

    record CoreParameters "Parameter record for core losses"
      extends Modelica.Icons.Record;
      parameter Integer m
        "Number of phases (1 for DC, 3 for induction machines)";
      parameter Modelica.SIunits.Power PRef(min=0) = 0
        "Reference core losses at reference inner voltage VRef";
      parameter Modelica.SIunits.Voltage VRef(min=Modelica.Constants.small)
        "Reference inner RMS voltage that reference core losses PRef refer to";
      parameter Modelica.SIunits.AngularVelocity wRef(min=Modelica.Constants.small)
        "Reference angular velocity that reference core losses PRef refer to";
      // In the current implementation ratioHysterisis = 0 since hysteresis losses are not implemented yet
      final parameter Real ratioHysteresis(
        min=0,
        max=1,
        start=0.775) = 0
        "Ratio of hysteresis losses with respect to the total core losses at VRef and fRef";
      final parameter Modelica.SIunits.Conductance GcRef=if (PRef <= 0) then 0
           else PRef/VRef^2/m
        "Reference conductance at reference frequency and voltage";
      final parameter Modelica.SIunits.AngularVelocity wMin=1e-6*wRef;
      annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
Parameter record for <a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.Core\">core losses of induction machines</a>
and <a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Core\">core losses of DC machines</a>.
</p>
</html>"));
    end CoreParameters;

    record PermanentMagnetLossParameters
      "Parameter record for permanent magnet losses"
      extends Modelica.Icons.Record;
      parameter Modelica.SIunits.Power PRef(min=0) = 0
        "Reference permanent magnet losses at IRef and wRef";
      parameter Real c(
        min=0,
        max=1) = 0
        "Part of permanent magnet losses at current = 0, i.e. independent of current";
      parameter Modelica.SIunits.Current IRef(min=Modelica.Constants.small)
        "Reference stator RMS current that PRef refers to";
      parameter Real power_I(min=Modelica.Constants.small) = 2
        "Exponent of permanent magnet loss torque w.r.t. stator current";
      parameter Modelica.SIunits.AngularVelocity wRef(displayUnit="rev/min", min=
            Modelica.Constants.small)
        "Reference angular velocity that PRef refers to";
      parameter Real power_w(min=Modelica.Constants.small) = 1
        "Exponent of permanent magnet loss torque w.r.t. angular velocity";
      final parameter Modelica.SIunits.Torque tauRef=if (PRef <= 0) then 0
           else PRef/wRef
        "Reference permanent magnet loss torque at reference angular velocity and reference current";
      annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
Parameter record for <a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.PermanentMagnetLosses\">permanent magnet losses</a>.
</p>
</html>"));
    end PermanentMagnetLossParameters;

    model Friction "Model of angular velocity dependent friction losses"
      extends Machines.Interfaces.FlangeSupport;
      parameter FrictionParameters frictionParameters
        "Friction loss parameters";
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
          useHeatPort=false);
    equation
      if (frictionParameters.PRef <= 0) then
        tau = 0;
      else
        tau = -(if noEvent(abs(w)>frictionParameters.wLinear) then
          frictionParameters.tauRef*sign(w)*(abs(w)/frictionParameters.wRef)^frictionParameters.power_w else
          frictionParameters.tauLinear*w/frictionParameters.wLinear);
      end if;
      lossPower = -tau*w;
      annotation (Icon(graphics={
            Ellipse(
              extent={{-60,60},{60,-60}},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,50},{50,-50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-12,50},{8,30}},
              fillPattern=FillPattern.Sphere,
              fillColor={135,135,135}),
            Ellipse(
              extent={{-10,-30},{10,-50}},
              fillPattern=FillPattern.Sphere,
              fillColor={135,135,135}),
            Ellipse(
              extent={{24,-10},{44,-30}},
              fillPattern=FillPattern.Sphere,
              fillColor={135,135,135}),
            Ellipse(
              extent={{22,34},{42,14}},
              fillPattern=FillPattern.Sphere,
              fillColor={135,135,135}),
            Ellipse(
              extent={{-44,30},{-24,10}},
              fillPattern=FillPattern.Sphere,
              fillColor={135,135,135}),
            Ellipse(
              extent={{-44,-12},{-24,-32}},
              fillPattern=FillPattern.Sphere,
              fillColor={135,135,135}),
            Ellipse(
              extent={{-30,30},{30,-30}},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-20,20},{20,-20}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              visible=useHeatPort,
              points={{-40,0},{-100,0},{-100,-90}},
              color={255,0,0}),
            Line(
              points={{0,90},{0,0}},
              color={95,95,95}),
            Line(
              points={{0,-60},{0,-90}},
              color={95,95,95}),
            Text(
              extent={{-150,90},{150,60}},
              lineColor={0,0,255},
              textString="%name")}), Documentation(info="<html>
<p>
The friction losses are considered by the equations
</p>
<pre>
   tau / tauRef = (+w / wRef) ^ power_w    for w &gt; +wLinear
 - tau / tauRef = (-w / wRef) ^ power_w    for w &lt; -wLinear
</pre>
<p>
with
</p>
<pre>
  tauRef * wRef = PRef
</pre>
<p>
being the friction torque at the reference angular velocity
<code>wRef</code>. The exponent <code>power_w</code> is
approximately 1.5 for axial ventilation and approximately 2.0 for radial ventilation.
</p>
<p>
For stability reasons the friction torque <code>tau</code> is approximated by a linear curve
</p>
<pre>
  tau / tauLinear = w / wLinear
</pre>
<p>
with
</p>
<pre>
  tauLinear = tauRef*(wLinear/wRef) ^ power_w
</pre>
<p>
in the range <code> -wLinear &le; w &le; wLinear</code> with <code>wLinear = 0.001 * wRef</code>. The relationship of torque
and angular velocity is depicted in Fig. 1
</p>
<table border=0 cellspacing=0 cellpadding=1>
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/frictiontorque.png\"
                alt=\"frictiontorque.png\"> </td>
  </tr>
  <tr><td> <strong> Fig. 1: </strong>Friction loss torque versus angular velocity for <code>power_w = 2</code></td>
  </tr>
</table>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.FrictionParameters\">FrictionParameters</a>
</p>
<p>
If it is desired to neglect friction losses, set <code>frictionParameters.PRef = 0</code> (this is the default).
</p>
</html>"));
    end Friction;

    package InductionMachines "Loss models for induction machines"
      extends Modelica.Icons.VariantsPackage;
      model Brush "Model considering voltage drop of carbon brushes"
        extends Modelica.Electrical.MultiPhase.Interfaces.TwoPlug;
        parameter Machines.Losses.BrushParameters brushParameters
          "Brush loss parameters";
        extends
          Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort(
            useHeatPort=false,final T=293.15);
        DCMachines.Brush brush[3](each final brushParameters=brushParameters,
            each final useHeatPort=true)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      equation
        connect(plug_p.pin, brush.p) annotation (Line(
            points={{-100,0},{-10,0}}, color={0,0,255}));
        connect(brush.n, plug_n.pin) annotation (Line(
            points={{10,0},{100,0}}, color={0,0,255}));
        for j in 1:m loop
          connect(brush[j].heatPort, internalHeatPort) annotation (Line(
              points={{-10,-10},{-10,-60},{-100,-60},{-100,-80}}, color={191,0,0}));
        end for;
        annotation (Icon(graphics={Line(points={{-100,-100},{-92,-80},{-80,-60},
                {-60,-40},{-40,-28},{-20,-22},{0,-20},{20,-22},{40,-28},{60,-40},
                {80,-60},{92,-80},{100,-100}}, color={0,0,255}),Polygon(
                      points={{-20,-22},{-40,-28},{-40,20},{40,20},{40,-28},{20,
                  -22},{0,-20},{-20,-22}},
                      lineColor={0,0,255},
                      fillColor={0,0,255},
                      fillPattern=FillPattern.Solid),Line(points={{-90,0},{-40,
                0}}, color={0,0,255}),Line(points={{40,0},{90,0}}, color={0,0,255}),
                Text( extent={{-150,80},{150,40}},
                      lineColor={0,0,255},
                      textString="%name")}), Documentation(info="<html>
<p>
Model of voltage drop and losses of carbon brushes. This three-phase model uses three
<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">DC Brush</a> loss models.
</p>
</html>"));
      end Brush;

      model StrayLoad
        "Model of stray load losses dependent on current and speed"
        extends Modelica.Electrical.MultiPhase.Interfaces.OnePort;
        extends Machines.Interfaces.FlangeSupport;
        import Modelica.Electrical.MultiPhase.Functions.quasiRMS;
        parameter Machines.Losses.StrayLoadParameters strayLoadParameters
          "Stray load loss parameters";
        extends
          Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
            useHeatPort=false);
        Modelica.SIunits.Current iRMS=quasiRMS(i);
      equation
        v = zeros(m);
        if (strayLoadParameters.PRef <= 0) then
          tau = 0;
        else
          tau = -strayLoadParameters.tauRef*(iRMS/strayLoadParameters.IRef)^2*
            sign(w)*(abs(w)/strayLoadParameters.wRef)^strayLoadParameters.power_w;
        end if;
        lossPower = -tau*w;
        annotation (Icon(graphics={
              Line(points={{-90,0},{90,0}}, color={0,0,255}),
              Rectangle(
                extent={{-70,30},{70,-30}},
                lineColor={0,0,255},
                pattern=LinePattern.Dot),
              Text(
                extent={{-150,90},{150,50}},
                lineColor={0,0,255},
                textString="%name")}), Documentation(info="<html>
<p>
Stray load losses are modeled similar to standards EN 60034-2 and IEEE 112, i.e., they are dependent on square of current,
but without scaling them to zero at no-load current.
</p>
<p>
For an estimation of dependency on varying angular velocity see:<br>
W. Lang, &Uuml;ber die Bemessung verlustarmer Asynchronmotoren mit K&auml;figl&auml;ufer f&uuml;r Pulsumrichterspeisung,
Doctoral Thesis, Technical University of Vienna, 1984.
</p>
<p>
The stray load losses are modeled such way that they do not cause a voltage drop in the electric circuit.
Instead, the dissipated losses are considered through an equivalent braking torque at the shaft.
</p>
<p>
The stray load loss torque is
</p>
<pre>
  tau = PRef/wRef * (i/IRef)^2 * (w/wRef)^power_w
</pre>
<p>
where <code>i</code> is the current of the machine and <code>w</code> is the actual angular velocity.
The dependency of the stray load torque on the angular velocity is modeled by the exponent <code>power_w</code>.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.StrayLoadParameters\">StrayLoad parameters</a>
</p>
<p>
If it is desired to neglect stray load losses, set <code>strayLoadParameters.PRef = 0</code> (this is the default).
</p>
</html>"));
      end StrayLoad;

      model PermanentMagnetLosses
        "Model of permanent magnet losses dependent on current and speed"
        extends Machines.Interfaces.FlangeSupport;
        import Modelica.Electrical.MultiPhase.Functions.quasiRMS;
        parameter Integer m(min=1) = 3 "Number of phases";
        parameter Machines.Losses.PermanentMagnetLossParameters
          permanentMagnetLossParameters "Permanent magnet loss parameters";
        extends
          Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
            useHeatPort=false);
        input Modelica.SIunits.Current is[m] "Instantaneous stator currents";
        Modelica.SIunits.Current iRMS=quasiRMS(is);
      equation
        if (permanentMagnetLossParameters.PRef <= 0) then
          tau = 0;
        else
          tau = -permanentMagnetLossParameters.tauRef*(permanentMagnetLossParameters.c + (1 - permanentMagnetLossParameters.c)*
            (iRMS/permanentMagnetLossParameters.IRef)^permanentMagnetLossParameters.power_I)*
            sign(w)*(abs(w)/permanentMagnetLossParameters.wRef)^permanentMagnetLossParameters.power_w;
        end if;
        lossPower = -tau*w;
        annotation (defaultComponentName="magnetLoss",
          Icon(graphics={Ellipse(extent={{-40,-40},{40,40}},
                lineColor={200,0,0})}), Documentation(info="<html>
<p>
Permanent magnet losses are modeled dependent on current and speed.
</p>
<p>
The permanent magnet losses are modeled such way that they do not cause a voltage drop in the electric circuit.
Instead, the dissipated losses are considered through an equivalent braking torque at the shaft.
</p>
<p>
The permanent magnet loss torque is
</p>
<pre>
  tau = PRef/wRef * (c + (1 - c) * (i/IRef)^power_I) * (w/wRef)^power_w
</pre>
<p>
where <code>i</code> is the current of the machine and <code>w</code> is the actual angular velocity.
The parameter <code>c</code> designates the part of the permanent magnet losses that are present even at current = 0, i.e. independent of current.
The dependency of the permanent magnet loss torque on the stator current is modeled by the exponent <code>power_I</code>.
The dependency of the permanent magnet loss torque on the angular velocity is modeled by the exponent <code>power_w</code>.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters\">Permanent magnet loss parameters</a>
</p>
<p>
If it is desired to neglect permanent magnet losses, set <code>strayLoadParameters.PRef = 0</code> (this is the default).
</p>
</html>"));
      end PermanentMagnetLosses;

      model Core "Model of core losses"
        parameter Machines.Losses.CoreParameters coreParameters(m=3);
        //for backwards compatibility present but unused
        final parameter Integer m=coreParameters.m "Number of phases";
        parameter Real turnsRatio(final min=Modelica.Constants.small)
          "Effective number of stator turns / effective number of rotor turns (if used as rotor core)";
        extends
          Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
            useHeatPort=false);
        Machines.Interfaces.SpacePhasor spacePhasor annotation (Placement(
              transformation(extent={{-110,-10},{-90,10}}),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        input Modelica.SIunits.AngularVelocity w
          "Remagnetization angular velocity" annotation (Dialog(group="Losses"));
        Modelica.SIunits.Conductance Gc "Variable core loss conductance";
      protected
        Modelica.SIunits.AngularVelocity wLimit=noEvent(max(noEvent(abs(w)),
            coreParameters.wMin)) "Limited angular velocity";
      equation
        if (coreParameters.PRef <= 0) then
          Gc = 0;
          spacePhasor.i_ = zeros(2);
        else
          Gc = coreParameters.GcRef;
          //  * (coreParameters.wRef/wLimit*coreParameters.ratioHysteresis + 1 - coreParameters.ratioHysteresis);
          spacePhasor.i_ = Gc*spacePhasor.v_;
        end if;
        lossPower = 3/2*(+spacePhasor.v_[1]*spacePhasor.i_[1] + spacePhasor.v_[2]*spacePhasor.i_[2]);
        annotation (Icon(graphics={
              Rectangle(
                extent={{-70,30},{70,-30}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,0},{-70,0}}),
              Line(points={{-70,10},{70,10}}, color={0,0,255}),
              Line(points={{-70,-30},{70,-30}}, color={0,0,255}),
              Line(points={{-70,-10},{70,-10}}, color={0,0,255}),
              Line(
                points={{70,0},{80,0}},
                color={0,0,255}),
              Line(
                points={{80,20},{80,-20}},
                color={0,0,255}),
              Line(
                points={{90,14},{90,-14}},
                color={0,0,255}),
              Line(
                points={{100,8},{100,-8}},
                color={0,0,255}),
              Text(
                extent={{-150,90},{150,50}},
                lineColor={0,0,255},
                textString="%name")}), Documentation(info="<html>
<p>
Core losses can be separated into <strong>eddy current</strong> and <strong>hysteresis</strong> losses. The total core losses
can thus be expressed as
</p>
<pre>
  P = PRef * (ratioHysteresis * (wRef / w) + 1 - ratioHysteresis) * (V / VRef)^2
</pre>
<p>
where <code>w</code> is the actual angular remagnetization velocity and <code>V</code> is the actual voltage.
The term <code>ratioHysteresis</code> is the ratio of the hysteresis losses with respect to the total core losses for the reference voltage and frequency.
</p>

<p>
In the current implementation hysteresis losses are <strong>not considered</strong> since complex numbers are not provided in Modelica.
Therefore, implicitly <code>ratioHysteresis = 0</code> is set. For the voltage and frequency range with respect to Fig.&nbsp;1,
the dependency of total core losses on the parameter <code>ratioHysteresis</code> is depicted in Fig.&nbsp;2.
The current implementation has thus the drawback over a model that considers <code>ratioHysteresis &gt; 0</code>:
</p>
<ul>
<li>underestimation of the losses in the constant field region (<code>w</code> &lt; <code>wRef</code>)</li>
<li>overestimation of the losses in the field weakening region (<code>w</code> &gt; <code>wRef</code>)</li>
</ul>

<table border=0 cellspacing=0 cellpadding=1>
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/corelossesVw.png\"
                alt=\"corelossesVw.png\"> </td>
  </tr>
  <tr><td> <strong> Fig. 1: </strong>Voltage versus angular velocity</td>
  </tr>
</table>

<table border=0 cellspacing=0 cellpadding=1>
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/corelossesPcw.png\"
                alt=\"corelossesPcw.png\"> </td>
  </tr>
  <tr><td> <strong> Fig. 2: </strong>Core losses versus angular velocity with parameter <code>ratioHysteresis</code></td>
  </tr>
</table>

<h4>Note</h4>
<p>In the current implementation it is assumed that <code>ratioHysteresis = 0</code>. This parameter cannot be changed due to compatibility reasons.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.CoreParameters\">Core loss parameters</a>
</p>

</html>"));
      end Core;
      annotation (Documentation(info="<html>
This package contains loss models used for induction machine models.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v2.4.0 2010/04/20 Anton Haumer<br>
       first implementation</li>
  </ul>
</html>"));
    end InductionMachines;

    package DCMachines "Loss models for DC machines"
      extends Modelica.Icons.VariantsPackage;
      model Brush "Model considering voltage drop of carbon brushes"
        extends Modelica.Electrical.Analog.Interfaces.OnePort;
        parameter Machines.Losses.BrushParameters brushParameters
          "Brush loss parameters";
        extends
          Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
            useHeatPort=false);
      equation
        if (brushParameters.V <= 0) then
          v = 0;
        else
          v = smooth(0, if (i > +brushParameters.ILinear) then +brushParameters.V
             else if (i < -brushParameters.ILinear) then -brushParameters.V
             else brushParameters.V*i/brushParameters.ILinear);
        end if;
        lossPower = v*i;
        annotation (Icon(graphics={
              Line(points={{-100,-100},{-92,-80},{-80,-60},{-60,-40},{-40,-28},
                    {-20,-22},{0,-20},{20,-22},{40,-28},{60,-40},{80,-60},{92,-80},
                    {100,-100}}, color={0,0,255}),
              Polygon(
                points={{-20,-22},{-40,-28},{-40,20},{40,20},{40,-28},{20,-22},
                    {0,-20},{-20,-22}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,0},{-40,0}}, color={0,0,255}),
              Line(points={{40,0},{90,0}}, color={0,0,255}),
              Text(
                extent={{-150,80},{150,40}},
                lineColor={0,0,255},
                textString="%name")}), Documentation(info="<html>
<p>
Model of voltage drop and losses of carbon brushes. For currents between <code>-ILinear</code> and <code>ILinear</code>
 the voltage drop shows a linear behavior as depicted in Fig. 1.
 For positive currents greater or equal than <code>ILinear</code> the voltage drop equals <code>V</code>.
 For negative currents less or equal than <code>-ILinear</code> the voltage drop equals <code>-V</code>.
</p>

<table border=0 cellspacing=0 cellpadding=1>
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/brush.png\"
                alt=\"brush.png\"> </td> </tr>
  <tr><td> <strong> Fig. 1: </strong>Model of voltage drop of carbon brushes</td> </tr>
</table>
<h4>Note:</h4>
<p>
The voltage drop <code>v</code> is the total voltage drop of all series connected brushes.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.BrushParameters\">BrushParameters</a>
</p>
<p>
If it is desired to neglect brush losses, set <code>brushParameters.V = 0</code> (this is the default).
</p>
</html>"));
      end Brush;

      function brushVoltageDrop "Voltage drop of carbon brushes"
        extends Modelica.Icons.Function;
        input Machines.Losses.BrushParameters brushParameters
          "Brush loss parameters";
        input Modelica.SIunits.Current i "Actual current";
        output Modelica.SIunits.Voltage v "Voltage drop";
      algorithm
        if (brushParameters.V <= 0) then
          v := 0;
        else
          v := if (i > +brushParameters.ILinear) then +brushParameters.V else
            if (i < -brushParameters.ILinear) then -brushParameters.V else
            brushParameters.V*i/brushParameters.ILinear;
        end if;
        annotation (Documentation(info="<html>
<p>
Calculates the voltage drop of carbon brushes, according to
<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">Brush</a> losses,
e.g., used for initial equations.
</p>
</html>"));
      end brushVoltageDrop;

      model StrayLoad
        "Model of stray load losses dependent on current and speed"
        extends Modelica.Electrical.Analog.Interfaces.OnePort;
        extends Machines.Interfaces.FlangeSupport;
        parameter Machines.Losses.StrayLoadParameters strayLoadParameters
          "Stray load loss parameters";
        extends
          Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
            useHeatPort=false);
      equation
        v = 0;
        if (strayLoadParameters.PRef <= 0) then
          tau = 0;
        else
          tau = -strayLoadParameters.tauRef*(i/strayLoadParameters.IRef)^2*
            sign(w)*(abs(w)/strayLoadParameters.wRef)^strayLoadParameters.power_w;
        end if;
        lossPower = -tau*w;
        annotation (Icon(graphics={Line(points={{-90,0},{90,0}}, color={0,0,255}),
                Rectangle(
                      extent={{-70,30},{70,-30}},
                      lineColor={0,0,255},
                      pattern=LinePattern.Dot),Text(
                      extent={{-150,90},{150,50}},
                      lineColor={0,0,255},
                      textString="%name")}), Documentation(info="<html>
<p>
The stray load loss torque is
</p>
<pre>
  tau = PRef/wRef * (i/IRef)^2 * (w/wRef)^power_w
</pre>
<p>
where <code>i</code> is the current of the machine and <code>w</code> is the actual angular velocity.
The dependency of the stray load torque on the angular velocity is modeled by the exponent <code>power_w</code>.
</p>
<p>
The stray load losses are modeled such way that they do not cause a voltage drop in the electric circuit.
Instead, the dissipated losses are considered through an equivalent braking torque at the shaft.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.StrayLoadParameters\">StrayLoad parameters</a>
</p>
<p>
If it is desired to neglect stray load losses, set <code>strayLoadParameters.PRef = 0</code> (this is the default).
</p>
</html>"));
      end StrayLoad;

      model Core "Model of core losses"
        extends Modelica.Electrical.Analog.Interfaces.OnePort;
        parameter Machines.Losses.CoreParameters coreParameters(m=1) "Armature core losses";
        extends
          Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
            useHeatPort=false);
        input Modelica.SIunits.AngularVelocity w
          "Remagnetization angular velocity" annotation (Dialog(group="Losses"));
        Modelica.SIunits.Conductance Gc "Variable core loss conductance";
      protected
        Modelica.SIunits.AngularVelocity wLimit=noEvent(max(noEvent(abs(w)),
            coreParameters.wMin)) "Limited angular velocity";
      equation
        if (coreParameters.PRef <= 0) then
          Gc = 0;
          i = 0;
        else
          Gc = coreParameters.GcRef;
          // * (coreParameters.wRef/wLimit*coreParameters.ratioHysteresis + 1 - coreParameters.ratioHysteresis);
          i = Gc*v;
        end if;
        lossPower = v*i;
        annotation (Icon(graphics={Rectangle(
                      extent={{-70,30},{70,-30}},
                      lineColor={0,0,255},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Line(points={{70,0},{90,0}}),
                Line(points={{-90,0},{-70,0}}),Line(points={{-70,10},{70,10}},
                color={0,0,255}),Line(points={{-70,-30},{70,-30}}, color={0,0,255}),
                Line(points={{-70,-10},{70,-10}}, color={0,0,255}),Text(
                      extent={{-150,90},{150,50}},
                      lineColor={0,0,255},
                      textString="%name")}), Documentation(info="<html>
<p>
Core losses can be separated into <em>eddy current</em> and <em>hysteresis</em> losses. The total core losses
can thus be expressed as
</p>
<pre>
  p = PRef * (ratioHysteresis * (wRef / w) + 1 - ratioHysteresis) * (v / VRef)^2
</pre>
<p>
where <code>w</code> is the actual angular velocity and <code>v</code> is the actual voltage. The term <code>ratioHysteresis</code> is the ratio
of the hysteresis losses with respect to the total core losses for reference inner voltage and reference angular velocity.
</p>

<p>
For the voltage and angular velocity range with respect to Fig.&nbsp;1,
the dependency of total core losses on the parameter <code>ratioHysteresis</code> is depicted in Fig.&nbsp;2.
</p>

<table border=0 cellspacing=0 cellpadding=1>
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/corelossesVw.png\"
                alt=\"corelossesVw.png\"> </td>
  </tr>
  <tr><td> <strong> Fig. 1: </strong>Voltage versus angular velocity</td>
  </tr>
</table>

<table border=0 cellspacing=0 cellpadding=1>
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/corelossesPcw.png\"
                alt=\"corelossesPcw.png\"> </td>
  </tr>
  <tr><td> <strong> Fig. 2: </strong>Core losses versus angular velocity with parameter <code>ratioHysteresis</code></td>
  </tr>
</table>

<h4>Note</h4>
<p>In the current implementation it is assumed that <code>ratioHysteresis = 0</code>. This parameter cannot be changed due to compatibility reasons.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.CoreParameters\">Core loss parameters</a>
</p>

</html>"));
      end Core;
      annotation (Documentation(info="<html>
This package contains loss models used for DC machine models.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v2.4.0 2010/04/20 Anton Haumer<br>
       first implementation</li>
  </ul>
</html>"));
    end DCMachines;
    annotation (Documentation(info="<html>
This package contains loss models and their parameter records used for machine models.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v2.4.0 2010/04/20 Anton Haumer<br>
       first implementation</li>
  </ul>
</html>"));
  end Losses;

  package Thermal "Library with models for connecting thermal models"
    extends Modelica.Icons.Package;
    type LinearTemperatureCoefficient20 =
        Modelica.SIunits.LinearTemperatureCoefficient
      "Linear temperature coefficient with choices" annotation (choices(
        choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero
          "Not temperature dependent",
        choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Aluminium
          "Aluminium",
        choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Brass "Brass",
        choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Bronze "Bronze",
        choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper "Copper"));
    package Constants "Material Constants"
      extends Modelica.Icons.Package;
      constant Modelica.SIunits.LinearTemperatureCoefficient alpha20Zero=0
        "Not temperature dependent";
      constant Modelica.SIunits.LinearTemperatureCoefficient alpha20Aluminium=
          4.000e-3 "Aluminium";
      constant Modelica.SIunits.LinearTemperatureCoefficient alpha20Brass=
          1.100e-3 "Brass";
      constant Modelica.SIunits.LinearTemperatureCoefficient alpha20Bronze=
          0.800e-3 "Bronze";
      constant Modelica.SIunits.LinearTemperatureCoefficient alpha20Copper=
          3.920e-3 "Copper";
      annotation (Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={Polygon(
                  origin={-9.2597,25.6673},
                  fillColor={102,102,102},
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.Solid,
                  points={{48.017,11.336},{48.017,11.336},{10.766,11.336},{-25.684,
                10.95},{-34.944,-15.111},{-34.944,-15.111},{-32.298,-15.244},{-32.298,
                -15.244},{-22.112,0.168},{11.292,0.234},{48.267,-0.097},{48.267,
                -0.097}},
                  smooth=Smooth.Bezier),Polygon(
                  origin={-19.9923,-8.3993},
                  fillColor={102,102,102},
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.Solid,
                  points={{3.239,37.343},{3.305,37.343},{-0.399,2.683},{-16.936,
                -20.071},{-7.808,-28.604},{6.811,-22.519},{9.986,37.145},{9.986,
                37.145}},
                  smooth=Smooth.Bezier),Polygon(
                  origin={23.753,-11.5422},
                  fillColor={102,102,102},
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.Solid,
                  points={{-10.873,41.478},{-10.873,41.478},{-14.048,-4.162},{-9.352,
                -24.8},{7.912,-24.469},{16.247,0.27},{16.247,0.27},{13.336,
                0.071},{13.336,0.071},{7.515,-9.983},{-3.134,-7.271},{-2.671,
                41.214},{-2.671,41.214}},
                  smooth=Smooth.Bezier)}), Documentation(info="<html>
Material constants, especially linear temperature coefficients of commonly used conductor materials
</html>"));
    end Constants;

    function convertAlpha
      "Converts alpha from temperature 1 (default 20 degC) to temperature 2"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.LinearTemperatureCoefficient alpha1
        "Temperature coefficient at temperature 1 (default: 20 degC)";
      input Modelica.SIunits.Temperature T2 "Temperature 2";
      input Modelica.SIunits.Temperature T1=293.15
        "Temperature 1 (default: 20 degC)";
      output Modelica.SIunits.LinearTemperatureCoefficient alpha2
        "Temperature coefficient at TRef";
    algorithm
      alpha2 := alpha1/(1 + alpha1*(T2 - T1));
      annotation (Inline=true,Documentation(info="<html>
<p>
From the temperature coefficient <code>alpha1</code> at temperature <code>T1</code> (default 20 degC = 293.15 K)
the temperature coefficient <code>alpha2</code> at temperature <code>T2</code> is calculated:
</p>
<pre>
                alpha1
  alpha2 = ------------------------
            1 + alpha1 * (T2 - T1)
</pre>
</html>"));
    end convertAlpha;

    function convertResistance
      "Converts resistance from reference temperature to an actual temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Resistance RRef "Resistance at TRef";
      input Modelica.SIunits.Temperature TRef "Reference temperature";
      input Modelica.SIunits.LinearTemperatureCoefficient alpha20
        "Temperature coefficient at 20 degC";
      input Modelica.SIunits.Temperature T "Actual temperature";
      output Modelica.SIunits.Resistance R "Actual resistance at T";
    algorithm
      R := RRef*(1 + Machines.Thermal.convertAlpha(alpha20, TRef)*(T - TRef));
      annotation (Inline=true,Documentation(info="<html>
<p>
From the temperature coefficient <code>alpha20</code> at 20 degC (equals to 293.15 K) the parameter <code>alphaRef</code> at <code>TRef</code>
</p>
<pre>
                        alpha20
  alphaRef = -------------------------------
              1 + alpha20 * (TRef - 293.15)
</pre>
<p>
is determined; using this value, actual resistance <code>R</code> with respect to the actual temperature <code>T</code> is calculated by
</p>
<pre>
   R
  ------ = 1 + alphaRef * (T - TRef)
   RRef
</pre>
<p>
where <code>RRef</code> is the resistance at the reference temperature <code>TRef</code>.
</p>
</html>"));
    end convertResistance;

    function linearTemperatureDependency
      "Converts a value (e.g. resistance) from reference temperature to an actual temperature"
      extends Modelica.Icons.Function;
      input Real RRef "Value at TRef";
      input Modelica.SIunits.Temperature TRef "Reference temperature";
      input Modelica.SIunits.LinearTemperatureCoefficient alpha20
        "Temperature coefficient at 20 degC";
      input Modelica.SIunits.Temperature T "Actual temperature";
      output Real R "Actual value at T";
    algorithm
      R := RRef*(1 + Machines.Thermal.convertAlpha(alpha20, TRef)*(T - TRef));
      annotation (Inline=true,Documentation(info="<html>
<p>
This is the same function as Modelica.Electrical.Machines.Thermal.convertResistance but without physical units for input RRef and result R.
This avoids problems if the function is used to calculate linear temperature dependency for other values than resistances.
</p>
<p>
From the temperature coefficient <code>alpha20</code> at 20 degC (equals to 293.15 K) the parameter <code>alphaRef</code> at <code>TRef</code>
</p>
<pre>
                        alpha20
  alphaRef = -------------------------------
              1 + alpha20 * (TRef - 293.15)
</pre>
<p>
is determined; using this value, actual value (e.g. resistance <code>R</code>) with respect to the actual temperature <code>T</code> is calculated by
</p>
<pre>
   R
  ------ = 1 + alphaRef * (T - TRef)
   RRef
</pre>
<p>
where <code>RRef</code> is the value (e.g. resistance) at the reference temperature <code>TRef</code>.
</p>
</html>"));
    end linearTemperatureDependency;

    package AsynchronousInductionMachines
      "Thermal parts of asynchronous induction machines"
      extends Modelica.Icons.VariantsPackage;
      model ThermalAmbientAIMC
        "Thermal ambient for asynchronous induction machine with squirrel cage"
        extends
          Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(
            redeclare final
            Machines.Interfaces.InductionMachines.ThermalPortAIMC thermalPort);
        parameter Modelica.SIunits.Temperature Tr(start=TDefault)
          "Temperature of rotor (squirrel cage)"
          annotation (Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flowRotorWinding=
            temperatureRotorWinding.port.Q_flow
          "Heat flow rate of rotor (squirrel cage)";
        output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flowStatorWinding +
            Q_flowRotorWinding + Q_flowStatorCore + Q_flowRotorCore +
            Q_flowStrayLoad + Q_flowFriction;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureRotorWinding annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Interfaces.RealInput TRotorWinding if
          useTemperatureInputs "Temperature of squirrel cage" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={100,-120})));
        Modelica.Blocks.Sources.Constant constTr(final k=Tr) if not
          useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
      equation
        connect(constTr.y, temperatureRotorWinding.T) annotation (Line(
            points={{-50,1},{-50,18}}, color={0,0,127}));
        connect(temperatureRotorWinding.port, thermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{-50,40},{-50,100},{0,100}}, color={191,0,0}));
        connect(TRotorWinding, temperatureRotorWinding.T) annotation (Line(
            points={{100,-120},{100,8},{-50,8},{-50,18}}, color={0,0,127}));
        annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}},
                textString="AIMC")}), Documentation(info="<html>
Thermal ambient for asynchronous induction machines with squirrel cage to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
      end ThermalAmbientAIMC;

      model ThermalAmbientAIMS
        "Thermal ambient for asynchronous induction machine with slipring"
        extends
          Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(
            redeclare final
            Machines.Interfaces.InductionMachines.ThermalPortAIMS thermalPort(
              final mr=mr));
        parameter Integer mr=m "Number of rotor phases";
        parameter Modelica.SIunits.Temperature Tr(start=TDefault)
          "Temperature of rotor windings"
          annotation (Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flowRotorWinding=
            temperatureRotorWinding.port.Q_flow
          "Heat flow rate of rotor (squirrel cage)";
        output Modelica.SIunits.HeatFlowRate Q_flowBrush=temperatureBrush.port.Q_flow
          "Heat flow rate of brushes";
        output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flowStatorWinding +
            Q_flowRotorWinding + Q_flowStatorCore + Q_flowRotorCore +
            Q_flowStrayLoad + Q_flowFriction + Q_flowBrush;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureRotorWinding annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Interfaces.RealInput TRotorWinding if
          useTemperatureInputs "Temperature of rotor windings" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={100,-118})));
        Modelica.Blocks.Sources.Constant constTr(final k=Tr) if not
          useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector
          thermalCollectorRotor(final m=mr)
          annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureBrush(
            final T=TDefault) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,50})));
      equation
        connect(constTr.y, temperatureRotorWinding.T) annotation (Line(
            points={{-50,1},{-50,18}}, color={0,0,127}));
        connect(thermalCollectorRotor.port_b, temperatureRotorWinding.port)
          annotation (Line(
            points={{-50,60},{-50,40}}, color={191,0,0}));
        connect(thermalCollectorRotor.port_a, thermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{-50,80},{-50,100},{0,100}}, color={191,0,0}));
        connect(temperatureBrush.port, thermalPort.heatPortBrush) annotation (
            Line(
            points={{0,60},{0,60},{0,100}}, color={191,0,0}));
        connect(TRotorWinding, temperatureRotorWinding.T) annotation (Line(
            points={{100,-118},{100,8},{-50,8},{-50,18}}, color={0,0,127}));
        annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}},
                textString="AIMS")}), Documentation(info="<html>
Thermal ambient for asynchronous induction machines with slipring rotor to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
      end ThermalAmbientAIMS;
      annotation (Documentation(info="<html>
Thermal parts for asynchronous induction machines
</html>"));
    end AsynchronousInductionMachines;

    package SynchronousInductionMachines
      "Thermal parts of synchronous induction machines"
      extends Modelica.Icons.VariantsPackage;
      model ThermalAmbientSMPM
        "Thermal ambient for synchronous induction machine with permanent magnets"
        parameter Boolean useDamperCage(start=true)
          "Enable / disable damper cage" annotation (Evaluate=true);
        extends
          Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(
            redeclare final
            Machines.Interfaces.InductionMachines.ThermalPortSMPM thermalPort(
              final useDamperCage=useDamperCage));
        parameter Modelica.SIunits.Temperature Tpm(start=TDefault)
          "Temperature of permanent magnet"
          annotation (Dialog(enable=not useTemperatureInputs));
        parameter Modelica.SIunits.Temperature Tr(start=TDefault)
          "Temperature of damper cage (optional)" annotation (Dialog(enable=(
                not useTemperatureInputs and useDamperCage)));
        output Modelica.SIunits.HeatFlowRate Q_flowRotorWinding=
            temperatureRotorWinding.port.Q_flow
          "Heat flow rate of damper cage (optional)";
        output Modelica.SIunits.HeatFlowRate Q_flowPermanentMagnet=
            temperaturePermanentMagnet.port.Q_flow
          "Heat flow rate of permanent magnets";
        output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flowStatorWinding +
            Q_flowRotorWinding + Q_flowPermanentMagnet + Q_flowStatorCore +
            Q_flowRotorCore + Q_flowStrayLoad + Q_flowFriction;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureRotorWinding annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
        Modelica.Blocks.Interfaces.RealInput TRotorWinding if (
          useTemperatureInputs and useDamperCage)
          "Temperature of damper cage (optional)" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={100,-120}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={100,-120})));
        Modelica.Blocks.Sources.Constant constTr(final k=if useDamperCage then
              Tr else TDefault) if (not useTemperatureInputs or not
          useDamperCage) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-10})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperaturePermanentMagnet annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Sources.Constant constTpm(final k=Tpm) if (not
          useTemperatureInputs) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Blocks.Interfaces.RealInput TPermanentMagnet if
          useTemperatureInputs "Temperature of permanent magnet" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
      equation
        connect(constTr.y, temperatureRotorWinding.T) annotation (Line(
            points={{-20,1},{-20,18}}, color={0,0,127}));
        connect(temperatureRotorWinding.port, thermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
        connect(TRotorWinding, temperatureRotorWinding.T) annotation (Line(
            points={{100,-120},{100,8},{-20,8},{-20,18}}, color={0,0,127}));
        connect(temperaturePermanentMagnet.port, thermalPort.heatPortPermanentMagnet)
          annotation (Line(
            points={{-50,40},{-50,100},{0,100}}, color={191,0,0}));
        connect(constTpm.y, temperaturePermanentMagnet.T) annotation (Line(
            points={{-50,1},{-50,18}}, color={0,0,127}));
        connect(TPermanentMagnet, temperaturePermanentMagnet.T) annotation (
            Line(
            points={{0,-120},{0,-60},{-64,-60},{-64,8},{-50,8},{-50,18}}, color={0,0,127}));
        annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}},
                textString="SMPM")}), Documentation(info="<html>
Thermal ambient for synchronous induction machines with permanent magnets to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
      end ThermalAmbientSMPM;

      model ThermalAmbientSMEE
        "Thermal ambient for synchronous induction machine with electrical excitation"
        parameter Boolean useDamperCage(start=true)
          "Enable / disable damper cage" annotation (Evaluate=true);
        extends
          Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(
            redeclare final
            Machines.Interfaces.InductionMachines.ThermalPortSMEE thermalPort(
              final useDamperCage=useDamperCage));
        parameter Modelica.SIunits.Temperature Tr(start=TDefault)
          "Temperature of damper cage (optional)" annotation (Dialog(enable=(
                not useTemperatureInputs and useDamperCage)));
        parameter Modelica.SIunits.Temperature Te(start=TDefault)
          "Temperature of excitation"
          annotation (Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flowRotorWinding=
            temperatureRotorWinding.port.Q_flow
          "Heat flow rate of damper cage (optional)";
        output Modelica.SIunits.HeatFlowRate Q_flowExcitation=
            temperatureExcitation.port.Q_flow "Heat flow rate of excitation";
        output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flowStatorWinding +
            Q_flowRotorWinding + Q_flowExcitation + Q_flowStatorCore +
            Q_flowRotorCore + Q_flowStrayLoad + Q_flowFriction;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureRotorWinding annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
        Modelica.Blocks.Interfaces.RealInput TRotorWinding if (
          useTemperatureInputs and useDamperCage)
          "Temperature of damper cage (optional)" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={100,-120})));
        Modelica.Blocks.Sources.Constant constTr(final k=if useDamperCage then
              Tr else TDefault) if (not useTemperatureInputs or not
          useDamperCage) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-10})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureExcitation annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Interfaces.RealInput TExcitation if
          useTemperatureInputs "Temperature of excitation" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
        Modelica.Blocks.Sources.Constant constTe(final k=Te) if not
          useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureBrush(
            final T=TDefault) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,50})));
      equation
        connect(constTr.y, temperatureRotorWinding.T) annotation (Line(
            points={{-20,1},{-20,18}}, color={0,0,127}));
        connect(temperatureRotorWinding.port, thermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
        connect(TRotorWinding, temperatureRotorWinding.T) annotation (Line(
            points={{100,-120},{100,8},{-20,8},{-20,18}}, color={0,0,127}));
        connect(constTe.y, temperatureExcitation.T) annotation (Line(
            points={{-50,1},{-50,18}}, color={0,0,127}));
        connect(TExcitation, temperatureExcitation.T) annotation (Line(
            points={{0,-120},{0,-60},{-66,-60},{-66,8},{-50,8},{-50,18}}, color={0,0,127}));
        connect(temperatureExcitation.port, thermalPort.heatPortExcitation)
          annotation (Line(
            points={{-50,40},{-50,100},{0,100}}, color={191,0,0}));
        connect(temperatureBrush.port, thermalPort.heatPortBrush) annotation (
            Line(
            points={{0,60},{0,100},{0,100}}, color={191,0,0}));
        annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}},
                textString="SMEE")}), Documentation(info="<html>
Thermal ambient for synchronous induction machines with electrical excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
      end ThermalAmbientSMEE;

      model ThermalAmbientSMR
        "Thermal ambient for synchronous induction machine with reluctance rotor"
        parameter Boolean useDamperCage(start=true)
          "Enable / disable damper cage" annotation (Evaluate=true);
        extends
          Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(
            redeclare final
            Machines.Interfaces.InductionMachines.ThermalPortSMR thermalPort(
              final useDamperCage=useDamperCage));
        parameter Modelica.SIunits.Temperature Tr(start=TDefault)
          "Temperature of damper cage (optional)" annotation (Dialog(enable=(
                not useTemperatureInputs and useDamperCage)));
        output Modelica.SIunits.HeatFlowRate Q_flowRotorWinding=
            temperatureRotorWinding.port.Q_flow
          "Heat flow rate of damper cage (optional))";
        output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flowStatorWinding +
            Q_flowRotorWinding + Q_flowStatorCore + Q_flowRotorCore +
            Q_flowStrayLoad + Q_flowFriction;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureRotorWinding annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
        Modelica.Blocks.Interfaces.RealInput TRotorWinding if (
          useTemperatureInputs and useDamperCage)
          "Temperature of damper cage (optional)" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={100,-120})));
        Modelica.Blocks.Sources.Constant constTr(final k=if useDamperCage then
              Tr else TDefault) if (not useTemperatureInputs or not
          useDamperCage) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-10})));
      equation
        connect(constTr.y, temperatureRotorWinding.T) annotation (Line(
            points={{-20,1},{-20,18}}, color={0,0,127}));
        connect(temperatureRotorWinding.port, thermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
        connect(TRotorWinding, temperatureRotorWinding.T) annotation (Line(
            points={{100,-120},{100,10},{-20,10},{-20,18}}, color={0,0,127}));
        annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}},
                textString="SMR")}), Documentation(info="<html>
Thermal ambient for synchronous induction machines with reluctance rotor to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
      end ThermalAmbientSMR;
      annotation (Documentation(info="<html>
Thermal parts for synchronous induction machines
</html>"));
    end SynchronousInductionMachines;

    package DCMachines "Thermal parts of DC machines"
      extends Modelica.Icons.VariantsPackage;
      model ThermalAmbientDCPM
        "Thermal ambient for DC machine with permanent magnets"
        extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
            redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM
            thermalPort);
        parameter Modelica.SIunits.Temperature Tpm(start=TDefault)
          "Temperature of permanent magnet"
          annotation (Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flowPermanentMagnet=
            temperaturePermanentMagnet.port.Q_flow
          "Heat flow rate of permanent magnets";
        output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flowArmature +
            Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush +
            Q_flowPermanentMagnet;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperaturePermanentMagnet annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
        Modelica.Blocks.Sources.Constant constTpm(final k=Tpm) if not
          useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-10})));
        Modelica.Blocks.Interfaces.RealInput TPermanentMagnet if
          useTemperatureInputs "Temperature of permanent magnet" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
      equation
        connect(temperaturePermanentMagnet.port, thermalPort.heatPortPermanentMagnet)
          annotation (Line(
            points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
        connect(constTpm.y, temperaturePermanentMagnet.T) annotation (Line(
            points={{-20,1},{-20,18}}, color={0,0,127}));
        connect(TPermanentMagnet, temperaturePermanentMagnet.T) annotation (
            Line(
            points={{0,-120},{0,-60},{-40,-60},{-40,8},{-20,8},{-20,18}}, color={0,0,127}));
        annotation (Icon(graphics={Text(
                      extent={{-100,-20},{100,-80}},
                      textString="DCPM")}), Documentation(info="<html>
Thermal ambient for DC machines with permanent magnets to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
      end ThermalAmbientDCPM;

      model ThermalAmbientDCEE
        "Thermal ambient for DC machine with electrical excitation"
        extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
            redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE
            thermalPort);
        parameter Modelica.SIunits.Temperature Te(start=TDefault)
          "Temperature of (shunt) excitation"
          annotation (Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flowExcitation=
            temperatureExcitation.port.Q_flow
          "Heat flow rate of (shunt) excitation";
        output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flowArmature +
            Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush +
            Q_flowExcitation;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureExcitation annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
        Modelica.Blocks.Sources.Constant constTe(final k=Te) if not
          useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-10})));
        Modelica.Blocks.Interfaces.RealInput TExcitation if
          useTemperatureInputs "Temperature of (shunt) excitation" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
      equation
        connect(constTe.y, temperatureExcitation.T) annotation (Line(
            points={{-20,1},{-20,18}}, color={0,0,127}));
        connect(TExcitation, temperatureExcitation.T) annotation (Line(
            points={{0,-120},{0,-60},{-40,-60},{-40,8},{-20,8},{-20,18}}, color={0,0,127}));
        connect(temperatureExcitation.port, thermalPort.heatPortExcitation)
          annotation (Line(
            points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
        annotation (Icon(graphics={Text(
                      extent={{-100,-20},{100,-80}},
                      textString="DCEE")}), Documentation(info="<html>
Thermal ambient for DC machines with electrical (shunt) excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
      end ThermalAmbientDCEE;

      model ThermalAmbientDCSE
        "Thermal ambient for DC machine with series excitation"
        extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
            redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE
            thermalPort);
        parameter Modelica.SIunits.Temperature Tse(start=TDefault)
          "Temperature of series excitation"
          annotation (Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flowSeriesExcitation=
            temperatureSeriesExcitation.port.Q_flow
          "Heat flow rate of series excitation";
        output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flowArmature +
            Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush +
            Q_flowSeriesExcitation;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureSeriesExcitation annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Sources.Constant constTse(final k=Tse) if not
          useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Blocks.Interfaces.RealInput T_se if useTemperatureInputs
          "Temperature of series excitation" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
      equation
        connect(constTse.y, temperatureSeriesExcitation.T) annotation (Line(
            points={{-50,1},{-50,18}}, color={0,0,127}));
        connect(T_se, temperatureSeriesExcitation.T) annotation (Line(
            points={{0,-120},{0,-60},{-70,-60},{-70,8},{-50,8},{-50,18}}, color={0,0,127}));
        connect(temperatureSeriesExcitation.port, thermalPort.heatPortSeriesExcitation)
          annotation (Line(
            points={{-50,40},{-50,100},{0,100}}, color={191,0,0}));
        annotation (Icon(graphics={Text(
                      extent={{-100,-20},{100,-80}},
                      textString="DCSE")}), Documentation(info="<html>
Thermal ambient for DC machines with serial excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
      end ThermalAmbientDCSE;

      model ThermalAmbientDCCE
        "Thermal ambient for DC machine with compound excitation"
        extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
            redeclare final Machines.Interfaces.DCMachines.ThermalPortDCCE
            thermalPort);
        parameter Modelica.SIunits.Temperature Te(start=TDefault)
          "Temperature of (shunt) excitation"
          annotation (Dialog(enable=not useTemperatureInputs));
        parameter Modelica.SIunits.Temperature Tse(start=TDefault)
          "Temperature of series excitation"
          annotation (Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flowShuntExcitation=
            temperatureShuntExcitation.port.Q_flow
          "Heat flow rate of (shunt) excitation";
        output Modelica.SIunits.HeatFlowRate Q_flowSeriesExcitation=
            temperatureSeriesExcitation.port.Q_flow
          "Heat flow rate of series excitation";
        output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flowArmature +
            Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush +
            Q_flowShuntExcitation + Q_flowSeriesExcitation;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureShuntExcitation annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,30})));
        Modelica.Blocks.Sources.Constant constTe(final k=Te) if not
          useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-10})));
        Modelica.Blocks.Interfaces.RealInput T_e if useTemperatureInputs
          "Temperature of (shunt) excitation" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={100,-118}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={100,-118})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureSeriesExcitation annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,30})));
        Modelica.Blocks.Sources.Constant constTse(final k=Tse) if not
          useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Blocks.Interfaces.RealInput T_se if useTemperatureInputs
          "Temperature of series excitation" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
      equation
        connect(constTe.y, temperatureShuntExcitation.T) annotation (Line(
            points={{-20,1},{-20,18}}, color={0,0,127}));
        connect(T_e, temperatureShuntExcitation.T) annotation (Line(
            points={{100,-118},{100,-60},{-40,-60},{-40,8},{-20,8},{-20,18}}, color={0,0,127}));
        connect(constTse.y, temperatureSeriesExcitation.T) annotation (Line(
            points={{-50,1},{-50,18}}, color={0,0,127}));
        connect(T_se, temperatureSeriesExcitation.T) annotation (Line(
            points={{0,-120},{0,-60},{-70,-60},{-70,8},{-50,8},{-50,18}}, color={0,0,127}));
        connect(temperatureSeriesExcitation.port, thermalPort.heatPortSeriesExcitation)
          annotation (Line(
            points={{-50,40},{-50,100},{0,100}}, color={191,0,0}));
        connect(temperatureShuntExcitation.port, thermalPort.heatPortShuntExcitation)
          annotation (Line(
            points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
        annotation (Icon(graphics={Text(
                      extent={{-100,-20},{100,-80}},
                      textString="DCCE")}), Documentation(info="<html>
Thermal ambient for DC machines with compound excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
      end ThermalAmbientDCCE;
      annotation (Documentation(info="<html>
Thermal parts for DC machines
</html>"));
    end DCMachines;

    model ThermalAmbientTransformer "Thermal ambient for transformers"
      parameter Integer m(min=1) = 3 "Number of phases";
      parameter Boolean useTemperatureInputs=false
        "If true, temperature inputs are used; else, temperatures are constant"
        annotation (Evaluate=true);
      constant Modelica.SIunits.Temperature TDefault=293.15
        "Default temperature";
      parameter Modelica.SIunits.Temperature T1(start=TDefault)
        "Temperature of primary windings"
        annotation (Dialog(enable=not useTemperatureInputs));
      parameter Modelica.SIunits.Temperature T2(start=TDefault)
        "Temperature of secondary windings"
        annotation (Dialog(enable=not useTemperatureInputs));
      output Modelica.SIunits.HeatFlowRate Q_flow1=temperature1.port.Q_flow
        "Heat flow rate of primary windings";
      output Modelica.SIunits.HeatFlowRate Q_flow2=temperature2.port.Q_flow
        "Heat flow rate of secondary windings";
      output Modelica.SIunits.HeatFlowRate Q_flowCore=temperatureCore.port.Q_flow
        "Heat flow rate of core losses";
      output Modelica.SIunits.HeatFlowRate Q_flowTotal=Q_flow1 + Q_flow2 +
          Q_flowCore;
      Machines.Interfaces.ThermalPortTransformer thermalPort(final m=m)
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperature1
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,30})));
      Modelica.Blocks.Sources.Constant constT1(final k=T1) if not
        useTemperatureInputs annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,-10})));
      Modelica.Blocks.Interfaces.RealInput TPrimary if useTemperatureInputs
        "Temperature of primary windings" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-100,-120}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-100,-120})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperature2
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={80,30})));
      Modelica.Blocks.Sources.Constant constT2(final k=T2) if not
        useTemperatureInputs annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={80,-10})));
      Modelica.Blocks.Interfaces.RealInput TSecondary if useTemperatureInputs
        "Temperature of secondary windings" annotation (Placement(
            transformation(
            extent={{-20,20},{20,-20}},
            rotation=90,
            origin={100,-120})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureCore(
          final T=TDefault) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,30})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector1(final m=m)
        annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector2(final m=m)
        annotation (Placement(transformation(extent={{70,60},{90,80}})));
    equation
      connect(TPrimary, temperature1.T) annotation (Line(
          points={{-100,-120},{-100,-60},{-100,8},{-80,8},{-80,18}}, color={0,0,127}));
      connect(constT1.y, temperature1.T) annotation (Line(
          points={{-80,1},{-80,18}}, color={0,0,127}));
      connect(TSecondary, temperature2.T) annotation (Line(
          points={{100,-120},{100,-60},{100,8},{80,8},{80,18}}, color={0,0,127}));
      connect(constT2.y, temperature2.T) annotation (Line(
          points={{80,1},{80,18}}, color={0,0,127}));
      connect(temperatureCore.port, thermalPort.heatPortCore) annotation (Line(
          points={{0,40},{0,70},{0,100},{1,100}}, color={191,0,0}));
      connect(thermalCollector1.port_b, temperature1.port) annotation (Line(
          points={{-80,60},{-80,40}}, color={191,0,0}));
      connect(thermalCollector2.port_b, temperature2.port) annotation (Line(
          points={{80,60},{80,40}}, color={191,0,0}));
      connect(thermalCollector1.port_a, thermalPort.heatPort1) annotation (Line(
          points={{-80,80},{-80,102},{-1,102}}, color={191,0,0}));
      connect(thermalCollector2.port_a, thermalPort.heatPort2) annotation (Line(
          points={{80,80},{80,98},{-1,98}}, color={191,0,0}));
      annotation (Icon(graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  pattern=LinePattern.None,
                  fillColor={159,159,223},
                  fillPattern=FillPattern.Backward),Line(
                  points={{-14,0},{54,0}},
                  color={191,0,0},
                  thickness=0.5,
                  origin={0,-6},
                  rotation=90),Polygon(
                  points={{-20,-20},{-20,20},{20,0},{-20,-20}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid,
                  origin={0,68},
                  rotation=90),Text(
                  extent={{-100,-20},{100,-80}},
                  textString="Trafo")}), Documentation(info="<html>
Thermal ambient for transformers to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
    end ThermalAmbientTransformer;
    annotation (Icon(graphics={Ellipse(
            extent={{-65,-63},{65,63}},
            lineColor={191,0,0},
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<h4>Thermal concept</h4>
<p>
Each machine model is equipped with a machine-specific conditional <code>thermalPort</code>.
If <code>useThermalPort == false</code>, a machine-specific thermal ambient prescribing constant temperatures is used inside the machine.
If <code>useThermalPort == true</code>, a thermal model or machine-specific thermal ambient prescribing the temperatures has to be connected from outside.
On the other hand, all losses are dissipated to this internal or external thermal ambient.
</p>
<p>
The machine specific thermal connector contains <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">heatPort</a>s
for all relevant loss sources of the machine type, although some of the loss sources are not yet implemented;
these heatPorts are left unconnected inside the machine, i.e., the HeatFlowRate is zero,
but they have to be connected to a constant temperature source in the internal or external thermal ambient.
Simple machine-specific thermal ambients for constant temperatures (<code>useTemperatureInputs == false</code>)
or temperatures prescribed via signal inputs (<code>useTemperatureInputs == true</code>) are provided in this package.
</p>
<h4>Loss sources</h4>
<p>
Up to now, only Ohmic losses in stator and rotor windings are implemented.
They are modeled as <a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">linearly temperature dependent resistors</a>:
</p>
<pre>
   ROperational = RRef * (1 + alphaRef * (TOperational - TRef))
</pre>
<h5>Parameters:</h5>
<ul>
<li>Resistance <code>RRef</code> at reference temperature</li>
<li>Reference temperature <code>TRef</code></li>
<li>Linear temperature coefficient <code>alpha20</code> at 20&deg;C</li>
<li>Operational temperature <code>TOperational</code>
(if <code>useThermalPort == false</code>; otherwise, the operational temperature is provided via the heatPort)</li>
<li>Nominal temperature <code>TNominal</code>
(required for DC machines to calculate the turns ratio)</li>
</ul>
<p>
The linear temperature coefficient <code>alpha20</code> at 20&deg;C = 293.15 K has to be converted to reference temperature <code>TRef</code>:
</p>
<pre>
                        alpha20
  alphaRef = -------------------------------
              1 + alpha20 * (TRef - 293.15)
</pre>
<p>
For this reason, the function <a href=\"modelica://Modelica.Electrical.Machines.Thermal.convertAlpha\">convertAlpha</a> is provided.
In sub-package <a href=\"modelica://Modelica.Electrical.Machines.Thermal.Constants\">Constants</a> linear temperature coefficients at 20&deg;C for commonly used materials are defined.
</p>
<h4>Backwards compatibility</h4>
<ul>
<li>The default / start values of all resistances are left unchanged.</li>
<li>The default / start values of all reference temperatures are set to 20&deg;C.</li>
<li>The default / start values of all linear temperature coefficients are set to 0.</li>
<li>The default / start values of all operational temperatures are set to 20&deg;C.</li>
<li>The default / start values of all nominal temperatures are set to 20&deg;C.</li>
</ul>
<h4>Machine specific thermalPorts</h4>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage\">Asynchronous induction machine with squirrel cage</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPortRotorWinding</code>: heatPort for the rotor cage</li>
<li><code>heatPortStatorCore</code>: stator core losses (not yet fully implemented)</li>
<li><code>heatPortRotorCore</code>: rotor core losses (not yet connected/implemented)</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing\">Asynchronous induction machine with slipring rotor</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPortRotorWinding[m]</code>: m=3 heatPorts for the m=3 rotor phases</li>
<li><code>heatPortBrush</code>: brush losses (not yet connected/implemented)</li>
<li><code>heatPortStatorCore</code>: stator core losses (not yet fully implemented)</li>
<li><code>heatPortRotorCore</code>: rotor core losses (not yet fully implemented)</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet\">Synchronous induction machine with permanent magnets</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPortRotorWinding</code>: conditional (<code>useDamperCage=true/false</code>) heatPort for the damper cage</li>
<li><code>heatPortPermanentMagnet</code>: permanent magnet losses (not yet connected/implemented)</li>
<li><code>heatPortStatorCore</code>: stator core losses (not yet fully implemented)</li>
<li><code>heatPortRotorCore</code>: rotor core losses (not yet connected/implemented)</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">Synchronous induction machine with electrical excitation</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPortRotorWinding</code>: conditional (<code>useDamperCage=true/false</code>) heatPort for the damper cage</li>
<li><code>heatPortExcitation</code>: electrical excitation</li>
<li><code>heatPortBrush</code>: brush losses</li>
<li><code>heatPortStatorCore</code>: stator core losses (not yet fully implemented)</li>
<li><code>heatPortRotorCore</code>: rotor core losses (not yet connected/implemented)</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor\">Synchronous induction machine with reluctance rotor</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPortRotorWinding</code>: conditional (<code>useDamperCage=true/false</code>) heatPort for the damper cage</li>
<li><code>heatPortStatorCore</code>: stator core losses (not yet fully implemented)</li>
<li><code>heatPortRotorCore</code>: rotor core losses (not yet connected/implemented)</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet\">DC machine with permanent magnets</a></h5>
<ul>
<li><code>heatPortArmature</code>: armature losses</li>
<li><code>heatPortPermanentMagnet</code>: permanent magnet losses (not yet connected/implemented)</li>
<li><code>heatPortBrush</code>: brush losses</li>
<li><code>heatPortCore</code>: armature core losses</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_ElectricalExcited\">DC machine with electrical (shunt) excitation</a></h5>
<ul>
<li><code>heatPortArmature</code>: armature losses</li>
<li><code>heatPortExcitation</code>: electrical (shunt) excitation</li>
<li><code>heatPortBrush</code>: brush losses</li>
<li><code>heatPortCore</code>: armature core losses</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_SeriesExcited\">DC machine with serial excitation</a></h5>
<ul>
<li><code>heatPortArmature</code>: armature losses</li>
<li><code>heatPortSeriesExcitation</code>: electrical series excitation</li>
<li><code>heatPortBrush</code>: brush losses</li>
<li><code>heatPortCore</code>: armature core losses</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><!--<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_Compound\">-->DC machine with compound excitation (not yet implemented)<!--</a>--></h5>
<ul>
<li><code>heatPortArmature</code>: armature losses</li>
<li><code>heatPortShuntExcitation</code>: electrical (shunt) excitation</li>
<li><code>heatPortSeriesExcitation</code>: electrical series excitation</li>
<li><code>heatPortBrush</code>: brush losses</li>
<li><code>heatPortCore</code>: armature core losses</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.Transformers\">Transformers</a></h5>
<ul>
<li><code>heatPort1[m]</code>: m=3 heatPorts for the m=3 primary phases</li>
<li><code>heatPort2[m]</code>: m=3 heatPorts for the m=3 secondary phases</li>
<li><code>heatPortCore</code>: iron core losses (not yet connected/implemented)</li>
</ul>
</html>", revisions="<html>
  <ul>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       first stable release of this subpackage:<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"));
  end Thermal;

  package Interfaces "SpacePhasor connector and PartialMachines"
    extends Modelica.Icons.InterfacesPackage;
    connector SpacePhasor "Connector for Space Phasors"
      Modelica.SIunits.Voltage v_[2] "1=real, 2=imaginary part";
      flow Modelica.SIunits.Current i_[2] "1=real, 2=imaginary part";
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Polygon(
              points={{0,100},{-100,0},{0,-100},{100,0},{0,100}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-150,-90},{150,-150}},
              lineColor={0,0,255},
              textString="%name")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Polygon(
              points={{0,100},{-100,0},{0,-100},{100,0},{0,100}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
Connector for Space Phasors:
<ul>
<li>Voltage v_[2] ... Real and Imaginary part of voltage space phasor</li>
<li>Current i_[2] ... Real and Imaginary part of current space phasor</li>
</ul>
</html>"));
    end SpacePhasor;

    partial model PartialBasicMachine "Partial model for all machines"
      import Modelica.Constants.pi;
      extends Machines.Icons.TransientMachine;
      parameter Modelica.SIunits.Inertia Jr "Rotor's moment of inertia";
      parameter Boolean useSupport=false
        "Enable / disable (=fixed stator) support" annotation (Evaluate=true);
      parameter Modelica.SIunits.Inertia Js=Jr "Stator's moment of inertia"
                                     annotation (Dialog(enable=useSupport));
      parameter Boolean useThermalPort=false
        "Enable / disable (=fixed temperatures) thermal port"
        annotation (Evaluate=true);
      parameter Machines.Losses.FrictionParameters frictionParameters
        "Friction loss parameter record" annotation (Dialog(tab="Losses"));
      output Modelica.SIunits.Angle phiMechanical(start=0) = flange.phi -
        internalSupport.phi "Mechanical angle of rotor against stator";
      output Modelica.SIunits.AngularVelocity wMechanical(
        displayUnit="rev/min",
        start=0) = der(phiMechanical)
        "Mechanical angular velocity of rotor against stator";
      output Modelica.SIunits.Torque tauElectrical=inertiaRotor.flange_a.tau
        "Electromagnetic torque";
      output Modelica.SIunits.Torque tauShaft=-flange.tau "Shaft torque";
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Shaft"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(final J=Jr)
        annotation (Placement(transformation(
            origin={80,0},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport
        "Support at which the reaction torque is acting" annotation (Placement(
            transformation(extent={{90,-110},{110,-90}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertiaStator(final J=Js)
        annotation (Placement(transformation(
            origin={80,-100},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed if (not useSupport)
        annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={50,-100})));
      Machines.Losses.Friction friction(final frictionParameters=
            frictionParameters) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={90,-40})));
    protected
      Modelica.Mechanics.Rotational.Interfaces.Support internalSupport
        annotation (Placement(transformation(extent={{56,-104},{64,-96}})));
    equation
      connect(inertiaRotor.flange_b, flange) annotation (Line(points={{90,0},{
              92,0},{92,0},{100,0}}));
      connect(inertiaStator.flange_b, support)
        annotation (Line(points={{90,-100},{100,-100}}));
      connect(internalSupport, fixed.flange) annotation (Line(
          points={{60,-100},{50,-100}}));
      connect(internalSupport, inertiaStator.flange_a) annotation (Line(
          points={{60,-100},{70,-100}}));
      connect(inertiaRotor.flange_b, friction.flange) annotation (Line(
          points={{90,0},{90,-30}}));
      connect(friction.support, internalSupport) annotation (Line(
          points={{90,-50},{90,-90},{60,-90},{60,-100}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,-120},{150,-160}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{80,-80},{120,-120}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              visible=not useSupport,
              points={{80,-100},{120,-100}}),
            Line(
              visible=not useSupport,
              points={{90,-100},{80,-120}}),
            Line(
              visible=not useSupport,
              points={{100,-100},{90,-120}}),
            Line(
              visible=not useSupport,
              points={{110,-100},{100,-120}}),
            Line(
              visible=not useSupport,
              points={{120,-100},{110,-120}})}), Documentation(info="<html>
Base partial model DC machines:
<ul>
<li>main parts of the icon</li>
<li>mechanical shaft</li>
<li>mechanical support</li>
</ul>
Besides the mechanical connector <em>flange</em> (i.e., the shaft) the machines have a second mechanical connector <em>support</em>.<br>
If <em>useSupport</em> = false, it is assumed that the stator is fixed.<br>
Otherwise reaction torque (i.e., air gap torque, minus acceleration torque for stator's moment of inertia) can be measured at <em>support</em>.<br>
One may also fix the shaft and let rotate the stator; parameter Js is only of importance when the stator is rotating.
</html>"));
    end PartialBasicMachine;

    partial model PartialBasicInductionMachine
      "Partial model for induction machine"
      final parameter Integer m=3 "Number of phases";
      parameter Integer p(min=1, start=2) "Number of pole pairs (Integer)";
      parameter Modelica.SIunits.Frequency fsNominal(start=50)
        "Nominal frequency";
      parameter Modelica.SIunits.Temperature TsOperational(start=293.15)
        "Operational temperature of stator resistance" annotation (Dialog(group=
             "Operational temperatures", enable=not useThermalPort));
      parameter Modelica.SIunits.Resistance Rs(start=0.03)
        "Stator resistance per phase at TRef"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature TsRef(start=293.15)
        "Reference temperature of stator resistance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s(start=
            0) "Temperature coefficient of stator resistance at 20 degC"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance Lszero=Lssigma
        "Stator zero sequence inductance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance Lssigma(start=3*(1 - sqrt(1 -
            0.0667))/(2*pi*fsNominal)) "Stator stray inductance per phase"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      extends PartialBasicMachine(
        Jr(start=0.29),
        frictionParameters(wRef=2*pi*fsNominal/p),
        friction(final useHeatPort=true));
      parameter Machines.Losses.CoreParameters statorCoreParameters(
        final m=3,
        VRef(start=100),
        wRef=2*pi*fsNominal)
        "Stator core loss parameter record; all parameters refer to stator side"
        annotation (Dialog(tab="Losses"));
      parameter Machines.Losses.StrayLoadParameters strayLoadParameters(IRef(
            start=100), wRef=2*pi*fsNominal/p)
        "Stray load loss parameter record" annotation (Dialog(tab="Losses"));
      replaceable output
        Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines
        powerBalance(
        final powerStator=Machines.SpacePhasors.Functions.activePower(vs, is),
        final powerMechanical=wMechanical*tauShaft,
        final powerInertiaStator=inertiaStator.J*inertiaStator.a*inertiaStator.w,
        final powerInertiaRotor=inertiaRotor.J*inertiaRotor.a*inertiaRotor.w,
        final lossPowerStatorWinding=sum(rs.resistor.LossPower),
        final lossPowerStatorCore=statorCore.lossPower,
        final lossPowerStrayLoad=strayLoad.lossPower,
        final lossPowerFriction=friction.lossPower) "Power balance";

      output Modelica.SIunits.Voltage vs[m]=plug_sp.pin.v - plug_sn.pin.v
        "Stator instantaneous voltages";
      output Modelica.SIunits.Current is[m]=plug_sp.pin.i
        "Stator instantaneous currents";
      output Modelica.SIunits.Current i_0_s(stateSelect=StateSelect.prefer)=
        spacePhasorS.zero.i "Stator zero-sequence current";
      // to be defined in model that extends from this partial (since airgap isn't included here)
      input Modelica.SIunits.Current idq_ss[2]
        "Stator space phasor current / stator fixed frame";
      input Modelica.SIunits.Current idq_sr[2](each stateSelect=StateSelect.prefer)
        "Stator space phasor current / rotor fixed frame";
      input Modelica.SIunits.Current idq_rs[2]
        "Rotor space phasor current / stator fixed frame";
      input Modelica.SIunits.Current idq_rr[2](each stateSelect=StateSelect.prefer)
        "Rotor space phasor current / rotor fixed frame";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m)
        "Positive stator plug" annotation (Placement(transformation(extent={{50,
                90},{70,110}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m)
        "Negative stator plug" annotation (Placement(transformation(extent={{-70,
                90},{-50,110}})));
      Modelica.Electrical.MultiPhase.Basic.Resistor rs(
        final m=m,
        final R=fill(Rs, m),
        final T_ref=fill(TsRef, m),
        final alpha=fill(Machines.Thermal.convertAlpha(alpha20s, TsRef), m),
        final useHeatPort=true,
        final T=fill(TsRef, m)) annotation (Placement(transformation(extent={{
                60,70},{40,90}})));
      Machines.BasicMachines.Components.Inductor lssigma(final L=fill(Lssigma,
            2)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,20})));
      Modelica.Electrical.Analog.Basic.Inductor lszero(final L=Lszero)
        annotation (Placement(transformation(extent={{0,40},{-20,60}})));
      Machines.Losses.InductionMachines.Core statorCore(
        final coreParameters=statorCoreParameters,
        final useHeatPort=true,
        final turnsRatio=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,30})));
      Machines.SpacePhasors.Components.SpacePhasor spacePhasorS(final
          turnsRatio=1) annotation (Placement(transformation(
            origin={0,70},
            extent={{10,10},{-10,-10}},
            rotation=90)));
      Machines.Losses.InductionMachines.StrayLoad strayLoad(
        final strayLoadParameters=strayLoadParameters,
        final useHeatPort=true,
        final m=m)
        annotation (Placement(transformation(extent={{90,70},{70,90}})));
      replaceable
        Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines
        thermalPort(final m=m) if useThermalPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      replaceable
        Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines
        thermalAmbient(
        final useTemperatureInputs=false,
        final Ts=TsOperational,
        final m=m) if not useThermalPort annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,-80})));
    protected
      constant Real pi = Modelica.Constants.pi;
      replaceable
        Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines
        internalThermalPort(final m=m)
        annotation (Placement(transformation(extent={{-4,-84},{4,-76}})));
    equation
      connect(spacePhasorS.plug_n, plug_sn) annotation (Line(
          points={{-10,80},{-60,80},{-60,100}}, color={0,0,255}));
      connect(strayLoad.plug_n, rs.plug_p) annotation (Line(
          points={{70,80},{60,80}}, color={0,0,255}));
      connect(strayLoad.plug_p, plug_sp) annotation (Line(
          points={{90,80},{90,100},{60,100}}, color={0,0,255}));
      connect(strayLoad.support, internalSupport) annotation (Line(
          points={{80,70},{80,50},{60,50},{60,-100}}));
      connect(spacePhasorS.plug_p, rs.plug_n) annotation (Line(
          points={{10,80},{40,80}}, color={0,0,255}));
      connect(spacePhasorS.zero, lszero.p) annotation (Line(
          points={{0,60},{0,50}}, color={0,0,255}));
      connect(lszero.n, spacePhasorS.ground) annotation (Line(
          points={{-20,50},{-20,60},{-10,60}}, color={0,0,255}));
      connect(spacePhasorS.spacePhasor, lssigma.spacePhasor_a) annotation (Line(
          points={{10,60},{20,60},{20,30}}, color={0,0,255}));
      connect(statorCore.spacePhasor, lssigma.spacePhasor_a) annotation (Line(
          points={{10,30},{20,30}}, color={0,0,255}));
      connect(statorCore.heatPort, internalThermalPort.heatPortStatorCore)
        annotation (Line(
          points={{10,40},{50,40},{50,-79.2},{0.4,-79.2}}, color={191,0,0}));
      connect(strayLoad.heatPort, internalThermalPort.heatPortStrayLoad)
        annotation (Line(
          points={{90,70},{90,60},{50,60},{50,-80},{0.4,-80}}, color={191,0,0}));
      connect(rs.heatPort, internalThermalPort.heatPortStatorWinding)
        annotation (Line(
          points={{50,70},{50,-79.2},{-0.4,-79.2}}, color={191,0,0}));
      connect(friction.heatPort, internalThermalPort.heatPortFriction)
        annotation (Line(
          points={{80,-50},{50,-50},{50,-81.6},{0,-81.6}}, color={191,0,0}));
      connect(strayLoad.flange, inertiaRotor.flange_b) annotation (Line(
          points={{80,90},{100,90},{100,40},{90,40},{90,0}}));
      connect(internalThermalPort, thermalPort)
        annotation (Line(points={{0,-80},{0,-80},{0,-100}}, color={191,0,0}));
      connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
            points={{-20,-80},{-12,-80},{0,-80}}, color={191,0,0}));
      annotation (Documentation(info="<html>
Partial model for induction machine models
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),graphics={Line(points={{-50,100},{-20,100},{-20,70}},
                color={0,0,255}), Line(points={{50,100},{20,100},{20,70}},
                color={0,0,255})}));
    end PartialBasicInductionMachine;

    package InductionMachines
      "Interfaces and partial models for induction machines"
      extends Modelica.Icons.VariantsPackage;
      connector PartialThermalPortInductionMachines
        "Partial thermal port of induction machines"
        parameter Integer m=3 "Number of stator phases";
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortStatorWinding[m] "Heat port of stator windings"
          annotation (Placement(transformation(extent={{-20,10},{0,30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortStatorCore
          "Heat port of (optional) stator core losses"
          annotation (Placement(transformation(extent={{0,10},{20,30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRotorCore
          "Heat port of (optional) rotor core losses"
          annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortStrayLoad
          "Heat port of (optional) stray losses"
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortFriction
          "Heat port of (optional) friction losses"
          annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
        annotation (
          Diagram(graphics={Rectangle(
                extent={{-60,60},{60,-60}},
                lineColor={191,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid), Ellipse(
                extent={{-50,50},{50,-50}},
                lineColor={191,0,0},
                fillColor={191,0,0},
                fillPattern=FillPattern.Solid)}),
          Icon(graphics={Rectangle(
                extent={{-110,110},{110,-110}},
                lineColor={191,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid), Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={191,0,0},
                fillColor={191,0,0},
                fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
Partial thermal port for induction machines
</html>"));
      end PartialThermalPortInductionMachines;

      model PartialThermalAmbientInductionMachines
        "Partial thermal ambient for induction machines"
        parameter Integer m=3 "Number of stator phases";
        parameter Boolean useTemperatureInputs=false
          "If true, temperature inputs are used; else, temperatures are constant"
          annotation (Evaluate=true);
        constant Modelica.SIunits.Temperature TDefault=293.15
          "Default temperature";
        parameter Modelica.SIunits.Temperature Ts(start=TDefault)
          "Temperature of stator windings"
          annotation (Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flowStatorWinding=
            temperatureStatorWinding.port.Q_flow
          "Heat flow rate of stator windings";
        output Modelica.SIunits.HeatFlowRate Q_flowStatorCore=
            temperatureStatorCore.port.Q_flow
          "Heat flow rate of stator core losses";
        output Modelica.SIunits.HeatFlowRate Q_flowRotorCore=
            temperatureRotorCore.port.Q_flow
          "Heat flow rate of stator core losses";
        output Modelica.SIunits.HeatFlowRate Q_flowStrayLoad=
            temperatureStrayLoad.port.Q_flow
          "Heat flow rate of stray load losses";
        output Modelica.SIunits.HeatFlowRate Q_flowFriction=temperatureFriction.port.Q_flow
          "Heat flow rate of friction losses";
        replaceable
          Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines
          thermalPort(final m=m)
          annotation (Placement(transformation(extent={{-10,90},{10,110}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureStatorWinding annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-80,30})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
          temperatureStatorCore(final T=TDefault) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={20,50})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
          temperatureRotorCore(final T=TDefault) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,30})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
          temperatureStrayLoad(final T=TDefault) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,50})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
          temperatureFriction(final T=TDefault) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={80,30})));
        Modelica.Blocks.Interfaces.RealInput TStatorWinding if
          useTemperatureInputs "Temperature of stator windings" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-100,-120}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-100,-120})));
        Modelica.Blocks.Sources.Constant constTs(final k=Ts) if not
          useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-80,-10})));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector
          thermalCollectorStator(final m=m)
          annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
      equation
        connect(constTs.y, temperatureStatorWinding.T) annotation (Line(
            points={{-80,1},{-80,18}}, color={0,0,127}));
        connect(TStatorWinding, temperatureStatorWinding.T) annotation (Line(
            points={{-100,-120},{-100,-120},{-100,8},{-80,8},{-80,18}}, color={0,0,127}));

        connect(temperatureStrayLoad.port, thermalPort.heatPortStrayLoad)
          annotation (Line(
            points={{60,60},{60,100},{1,100}}, color={191,0,0}));
        connect(temperatureFriction.port, thermalPort.heatPortFriction)
          annotation (Line(
            points={{80,40},{80,96},{0,96}}, color={191,0,0}));
        connect(thermalCollectorStator.port_b, temperatureStatorWinding.port)
          annotation (Line(
            points={{-80,60},{-80,40}}, color={191,0,0}));
        connect(thermalCollectorStator.port_a, thermalPort.heatPortStatorWinding)
          annotation (Line(
            points={{-80,80},{-80,102},{-1,102}}, color={191,0,0}));
        connect(temperatureStatorCore.port, thermalPort.heatPortStatorCore)
          annotation (Line(
            points={{20,60},{20,102},{1,102}}, color={191,0,0}));
        connect(temperatureRotorCore.port, thermalPort.heatPortRotorCore)
          annotation (Line(
            points={{40,40},{40,98},{1,98}}, color={191,0,0}));
        annotation (Icon(graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                pattern=LinePattern.None,
                fillColor={159,159,223},
                fillPattern=FillPattern.Backward),
              Line(
                points={{-14,0},{54,0}},
                color={191,0,0},
                thickness=0.5,
                origin={0,-6},
                rotation=90),
              Polygon(
                points={{-20,-20},{-20,20},{20,0},{-20,-20}},
                lineColor={191,0,0},
                fillColor={191,0,0},
                fillPattern=FillPattern.Solid,
                origin={0,68},
                rotation=90)}), Documentation(info="<html>
Partial thermal ambient for induction machines
</html>"));
      end PartialThermalAmbientInductionMachines;

      record PartialPowerBalanceInductionMachines
        "Partial power balance of induction machines"
        extends Modelica.Icons.Record;
        Modelica.SIunits.Power powerStator=0 "Electrical power (stator)";
        Modelica.SIunits.Power powerMechanical=0 "Mechanical power";
        Modelica.SIunits.Power powerInertiaStator=0 "Stator inertia power";
        Modelica.SIunits.Power powerInertiaRotor=0 "Rotor inertia power";
        Modelica.SIunits.Power lossPowerTotal=0 "Total loss power";
        Modelica.SIunits.Power lossPowerStatorWinding=0 "Stator copper losses";
        Modelica.SIunits.Power lossPowerStatorCore=0 "Stator core losses";
        Modelica.SIunits.Power lossPowerRotorCore=0 "Rotor core losses";
        Modelica.SIunits.Power lossPowerStrayLoad=0 "Stray load losses";
        Modelica.SIunits.Power lossPowerFriction=0 "Friction losses";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Partial power balance of induction machines.
 </html>"));
      end PartialPowerBalanceInductionMachines;

      connector ThermalPortAIMC
        "Thermal port of asynchronous induction machine with squirrel cage"
        extends
          Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortRotorWinding "Heat port of rotor (squirrel cage)"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        annotation (Documentation(info="<html>
Thermal port for asynchronous induction machine with squirrel cage
</html>"));
      end ThermalPortAIMC;

      record PowerBalanceAIMC
        "Power balance of asynchronous induction machines with squirrel cage"
        extends
          Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
            final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore
               + lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
              lossPowerRotorWinding);
        Modelica.SIunits.Power lossPowerRotorWinding "Rotor copper losses";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of asynchronous induction machines with squirrel cage.
 </html>"));
      end PowerBalanceAIMC;

      connector ThermalPortAIMS
        "Thermal port of asynchronous induction machine with slipring"
        extends
          Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
        parameter Integer mr=m "Number of rotor phases";
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortRotorWinding[mr] "Heat port of rotor windings"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortBrush
          "Heat port of (optional) brush losses"
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        annotation (Documentation(info="<html>
Thermal port for asynchronous induction machine with slipring rotor
</html>"));
      end ThermalPortAIMS;

      record PowerBalanceAIMS
        "Power balance of asynchronous induction machines with slipring"
        extends
          Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
            final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore
               + lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
              lossPowerRotorWinding + lossPowerBrush);
        Modelica.SIunits.Power lossPowerRotorWinding "Rotor copper losses";
        Modelica.SIunits.Power lossPowerBrush "Brush losses";
        Modelica.SIunits.Power powerRotor "Electrical power (rotor)";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of asynchronous induction machines with slipring.
 </html>"));
      end PowerBalanceAIMS;

      connector ThermalPortSMPM
        "Thermal port of synchronous induction machine with permanent magnets"
        extends
          Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
        parameter Boolean useDamperCage(start=true)
          "Enable / disable damper cage" annotation (Evaluate=true);
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortRotorWinding if useDamperCage
          "Heat port of damper cage (optional)"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortPermanentMagnet "Heat port of permanent magnets"
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        annotation (Documentation(info="<html>
Thermal port for synchronous induction machine with permanent magnets
</html>"));
      end ThermalPortSMPM;

      record PowerBalanceSMPM
        "Power balance of synchronous induction machines with permanent magnet"
        extends
          Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
            final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore
               + lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
              lossPowerRotorWinding + lossPowerPermanentMagnet);
        Modelica.SIunits.Power lossPowerRotorWinding "Rotor copper losses";
        Modelica.SIunits.Power lossPowerPermanentMagnet
          "Permanent magnet losses";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of synchronous induction machines with permanent magnet.
 </html>"));
      end PowerBalanceSMPM;

      connector ThermalPortSMEE
        "Thermal port of synchronous induction machine with electrical excitation"
        extends
          Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
        parameter Boolean useDamperCage(start=true)
          "Enable / disable damper cage" annotation (Evaluate=true);
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortRotorWinding if useDamperCage
          "Heat port of damper cage (optional)"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortExcitation
          "Heat port of excitation"
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortBrush
          "Heat port of (optional) brush losses"
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        annotation (Documentation(info="<html>
Thermal port for synchronous induction machine with electrical excitation
</html>"));
      end ThermalPortSMEE;

      record PowerBalanceSMEE
        "Power balance of synchronous induction machines with electrical excitation"
        extends
          Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
            final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore
               + lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
              lossPowerRotorWinding + lossPowerExcitation + lossPowerBrush);
        Modelica.SIunits.Power lossPowerRotorWinding "Rotor copper losses";
        Modelica.SIunits.Power powerExcitation "Electrical excitation power";
        Modelica.SIunits.Power lossPowerExcitation "Excitation losses";
        Modelica.SIunits.Power lossPowerBrush "Brush losses";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of synchronous induction machines with electrical excitation.
 </html>"));
      end PowerBalanceSMEE;

      connector ThermalPortSMR
        "Thermal port of synchronous induction machine with reluctance rotor"
        extends
          Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
        parameter Boolean useDamperCage(start=true)
          "Enable / disable damper cage" annotation (Evaluate=true);
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortRotorWinding if useDamperCage
          "Heat port of damper cage (optional)"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        annotation (Documentation(info="<html>
Thermal port for synchronous induction machine with reluctance rotor
</html>"));
      end ThermalPortSMR;

      record PowerBalanceSMR
        "Power balance of synchronous induction machines with reluctance rotor"
        extends
          Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
            final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore
               + lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
              lossPowerRotorWinding);
        Modelica.SIunits.Power lossPowerRotorWinding "Rotor copper losses";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of synchronous induction machines with reluctance rotor.
 </html>"));
      end PowerBalanceSMR;
      annotation (Documentation(info="<html>
Interfaces and partial models for induction machines
</html>"));
    end InductionMachines;

    partial model PartialBasicDCMachine "Partial model for DC machine"
      parameter Modelica.SIunits.Temperature TaOperational(start=293.15)
        "Operational armature temperature" annotation (Dialog(group=
              "Operational temperatures", enable=not useThermalPort));
      parameter Modelica.SIunits.Voltage VaNominal(start=100)
        "Nominal armature voltage" annotation (Dialog(tab="Nominal parameters"));
      parameter Modelica.SIunits.Current IaNominal(start=100)
        "Nominal armature current (>0..Motor, <0..Generator)"
        annotation (Dialog(tab="Nominal parameters"));
      parameter Modelica.SIunits.AngularVelocity wNominal(displayUnit="rev/min",
          start=1425*2*pi/60) "Nominal speed"
        annotation (Dialog(tab="Nominal parameters"));
      parameter Modelica.SIunits.Temperature TaNominal(start=293.15)
        "Nominal armature temperature"
        annotation (Dialog(tab="Nominal parameters"));
      parameter Modelica.SIunits.Resistance Ra(start=0.05)
        "Armature resistance at TRef"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature TaRef(start=293.15)
        "Reference temperature of armature resistance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20a(start=
            0) "Temperature coefficient of armature resistance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance La(start=0.0015)
        "Armature inductance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      extends PartialBasicMachine(
        Jr(start=0.15),
        frictionParameters(wRef=wNominal),
        friction(final useHeatPort=true));
      parameter Machines.Losses.CoreParameters coreParameters(
        final m=1,
        VRef=ViNominal,
        wRef=wNominal) "Armature core loss parameter record"
        annotation (Dialog(tab="Losses"));
      parameter Machines.Losses.StrayLoadParameters strayLoadParameters(IRef=
            IaNominal, wRef=wNominal) "Stray load loss parameter record"
        annotation (Dialog(tab="Losses"));
      parameter Machines.Losses.BrushParameters brushParameters(ILinear=0.01*
            IaNominal) "Brush loss parameter record"
        annotation (Dialog(tab="Losses"));
      replaceable output
        Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines
        powerBalance(
        final powerArmature=va*ia,
        final powerMechanical=wMechanical*tauShaft,
        final powerInertiaStator=inertiaStator.J*inertiaStator.a*inertiaStator.w,
        final powerInertiaRotor=inertiaRotor.J*inertiaRotor.a*inertiaRotor.w,
        final lossPowerArmature=ra.LossPower,
        final lossPowerCore=core.lossPower,
        final lossPowerStrayLoad=strayLoad.lossPower,
        final lossPowerFriction=friction.lossPower,
        final lossPowerBrush=brush.lossPower) "Power balance";

      output Modelica.SIunits.Voltage va=pin_ap.v - pin_an.v "Armature voltage";
      output Modelica.SIunits.Current ia(start=0) = pin_ap.i "Armature current";
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap
        "Positive armature pin" annotation (Placement(transformation(extent={{
                50,110},{70,90}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_an
        "Negative armature pin" annotation (Placement(transformation(extent={{-70,
                110},{-50,90}})));
      Modelica.Electrical.Analog.Basic.Resistor ra(
        final R=Ra,
        final T_ref=TaRef,
        final alpha=Machines.Thermal.convertAlpha(alpha20a, TaRef),
        final useHeatPort=true) annotation (Placement(transformation(extent={{60,50},{40,
                70}})));
      Machines.BasicMachines.Components.InductorDC la(final L=La, final
          quasiStationary=quasiStationary) annotation (Placement(transformation(
              extent={{30,50},{10,70}})));
      Machines.Losses.DCMachines.Brush brush(final brushParameters=
            brushParameters, final useHeatPort=true) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-20,60})));
      Machines.Losses.DCMachines.Core core(final coreParameters=coreParameters,
          final useHeatPort=true)
        annotation (Placement(transformation(extent={{10,70},{-10,90}})));
      Machines.Losses.DCMachines.StrayLoad strayLoad(final strayLoadParameters=
            strayLoadParameters, final useHeatPort=true)
        annotation (Placement(transformation(extent={{90,50},{70,70}})));
      replaceable Machines.Interfaces.DCMachines.PartialThermalPortDCMachines
        thermalPort if useThermalPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      replaceable
        Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines
        thermalAmbient(final useTemperatureInputs=false, final Ta=TaOperational) if
           not useThermalPort annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,-80})));
    protected
      constant Real pi = Modelica.Constants.pi;
      constant Boolean quasiStationary=false "No electrical transients if true"
        annotation (Evaluate=true);
      parameter Modelica.SIunits.Voltage ViNominal "Nominal induced Voltage";
      parameter Modelica.SIunits.MagneticFlux psi_eNominal
        "Nominal magnetic flux";
      parameter Real turnsRatio=ViNominal/(wNominal*psi_eNominal)
        "Ratio of armature turns over number of turns of the excitation winding";
      replaceable Machines.Interfaces.DCMachines.PartialThermalPortDCMachines
        internalThermalPort
        annotation (Placement(transformation(extent={{-4,-84},{4,-76}})));
    equation
      assert(ViNominal > Modelica.Constants.eps,
        "VaNominal has to be > (Ra[+Rse])*IaNominal");
      connect(la.p, ra.n)
        annotation (Line(points={{30,60},{40,60}}, color={0,0,255}));
      connect(brush.n, pin_an) annotation (Line(
          points={{-30,60},{-60,60},{-60,100}}, color={0,0,255}));
      connect(pin_ap, strayLoad.p) annotation (Line(
          points={{60,100},{90,100},{90,60}}, color={0,0,255}));
      connect(strayLoad.n, ra.p) annotation (Line(
          points={{70,60},{60,60}}, color={0,0,255}));
      connect(strayLoad.support, internalSupport) annotation (Line(
          points={{80,50},{80,30},{60,30},{60,-100}}));
      connect(la.p, core.p) annotation (Line(
          points={{30,60},{30,80},{10,80}}, color={0,0,255}));
      connect(core.n, brush.p) annotation (Line(
          points={{-10,80},{-10,60}}, color={0,0,255}));
      connect(core.heatPort, internalThermalPort.heatPortCore) annotation (Line(
          points={{10,70},{10,40},{50,40},{50,-79.2},{0.4,-79.2}}, color={191,0,0}));
      connect(brush.heatPort, internalThermalPort.heatPortBrush) annotation (
          Line(
          points={{-10,50},{-10,40},{50,40},{50,-78.4},{0,-78.4}}, color={191,0,0}));
      connect(strayLoad.heatPort, internalThermalPort.heatPortStrayLoad)
        annotation (Line(
          points={{90,50},{90,40},{50,40},{50,-80},{0.4,-80}}, color={191,0,0}));
      connect(friction.heatPort, internalThermalPort.heatPortFriction)
        annotation (Line(
          points={{80,-50},{50,-50},{50,-80.8},{0.4,-80.8}}, color={191,0,0}));
      connect(ra.heatPort, internalThermalPort.heatPortArmature) annotation (
          Line(
          points={{50,50},{50,-79.2},{-0.4,-79.2}}, color={191,0,0}));
      connect(inertiaRotor.flange_b, strayLoad.flange) annotation (Line(
          points={{90,0},{92,0},{92,30},{100,30},{100,70},{80,70}}));
      connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
            points={{-20,-80},{-12,-80},{0,-80}}, color={191,0,0}));
      connect(internalThermalPort, thermalPort)
        annotation (Line(points={{0,-80},{0,-100}}, color={191,0,0}));
      annotation (Documentation(info="<html>
Partial model for DC machine models.
</html>"), Icon(graphics={Line(points={{-40,70},{-60,70},{-60,90}}, color={0,0,255}),
                   Line(points={{40,70},{60,70},{60,90}}, color={0,0,255})}));
    end PartialBasicDCMachine;

    package DCMachines "Thermal ports of DC machines"
      extends Modelica.Icons.VariantsPackage;
      connector PartialThermalPortDCMachines
        "Partial thermal port of DC machines"
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortArmature
          "Heat port of armature"
          annotation (Placement(transformation(extent={{-20,10},{0,30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore
          "Heat port of (optional) core losses"
          annotation (Placement(transformation(extent={{0,10},{20,30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortStrayLoad
          "Heat port of (optional) stray losses"
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortFriction
          "Heat port of (optional) friction losses"
          annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortBrush
          "Heat port of (optional) brush losses"
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        annotation (
          Diagram(graphics={Rectangle(
                extent={{-60,60},{60,-60}},
                lineColor={191,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid), Ellipse(
                extent={{-50,50},{50,-50}},
                lineColor={191,0,0},
                fillColor={191,0,0},
                fillPattern=FillPattern.Solid)}),
          Icon(graphics={Rectangle(
                extent={{-110,110},{110,-110}},
                lineColor={191,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid), Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={191,0,0},
                fillColor={191,0,0},
                fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
Partial thermal port for DC machines
</html>"));
      end PartialThermalPortDCMachines;

      model PartialThermalAmbientDCMachines
        "Partial thermal ambient for DC machines"
        parameter Boolean useTemperatureInputs=false
          "If true, temperature inputs are used; else, temperatures are constant"
          annotation (Evaluate=true);
        constant Modelica.SIunits.Temperature TDefault=293.15
          "Default temperature";
        parameter Modelica.SIunits.Temperature Ta(start=TDefault)
          "Temperature of armature"
          annotation (Dialog(enable=not useTemperatureInputs));
        output Modelica.SIunits.HeatFlowRate Q_flowArmature=temperatureArmature.port.Q_flow
          "Heat flow rate of armature";
        output Modelica.SIunits.HeatFlowRate Q_flowCore=temperatureCore.port.Q_flow
          "Heat flow rate of core losses";
        output Modelica.SIunits.HeatFlowRate Q_flowStrayLoad=
            temperatureStrayLoad.port.Q_flow
          "Heat flow rate of stray load losses";
        output Modelica.SIunits.HeatFlowRate Q_flowFriction=temperatureFriction.port.Q_flow
          "Heat flow rate of friction losses";
        output Modelica.SIunits.HeatFlowRate Q_flowBrush=temperatureBrush.port.Q_flow
          "Heat flow rate of brushes";
        replaceable Machines.Interfaces.DCMachines.PartialThermalPortDCMachines
          thermalPort
          annotation (Placement(transformation(extent={{-10,90},{10,110}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          temperatureArmature annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-80,30})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureCore(
            final T=TDefault) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,30})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
          temperatureStrayLoad(final T=TDefault) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,10})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
          temperatureFriction(final T=TDefault) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={80,30})));
        Modelica.Blocks.Interfaces.RealInput TArmature if useTemperatureInputs
          "Temperature of armature" annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-100,-120}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-100,-120})));
        Modelica.Blocks.Sources.Constant constTa(final k=Ta) if not
          useTemperatureInputs annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-80,-10})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureBrush(
            final T=TDefault) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={20,10})));
      equation
        connect(constTa.y, temperatureArmature.T) annotation (Line(
            points={{-80,1},{-80,18}}, color={0,0,127}));
        connect(TArmature, temperatureArmature.T) annotation (Line(
            points={{-100,-120},{-100,-60},{-100,8},{-80,8},{-80,18}}, color={0,0,127}));

        connect(temperatureArmature.port, thermalPort.heatPortArmature)
          annotation (Line(
            points={{-80,40},{-80,102},{-1,102}}, color={191,0,0}));
        connect(temperatureBrush.port, thermalPort.heatPortBrush) annotation (
            Line(
            points={{20,20},{20,104},{0,104}}, color={191,0,0}));
        connect(temperatureCore.port, thermalPort.heatPortCore) annotation (
            Line(
            points={{40,40},{40,102},{1,102}}, color={191,0,0}));
        connect(temperatureStrayLoad.port, thermalPort.heatPortStrayLoad)
          annotation (Line(
            points={{60,20},{60,100},{1,100}}, color={191,0,0}));
        connect(temperatureFriction.port, thermalPort.heatPortFriction)
          annotation (Line(
            points={{80,40},{80,98},{1,98}}, color={191,0,0}));
        annotation (Icon(graphics={Rectangle(
                      extent={{-100,100},{100,-100}},
                      pattern=LinePattern.None,
                      fillColor={159,159,223},
                      fillPattern=FillPattern.Backward),Line(
                      points={{-14,0},{54,0}},
                      color={191,0,0},
                      thickness=0.5,
                      origin={0,-6},
                      rotation=90),Polygon(
                      points={{-20,-20},{-20,20},{20,0},{-20,-20}},
                      lineColor={191,0,0},
                      fillColor={191,0,0},
                      fillPattern=FillPattern.Solid,
                      origin={0,68},
                      rotation=90)}), Documentation(info="<html>
Partial thermal ambient for induction machines
</html>"));
      end PartialThermalAmbientDCMachines;

      record PartialPowerBalanceDCMachines
        "Partial power balance of DC machines"
        extends Modelica.Icons.Record;
        Modelica.SIunits.Power powerArmature=0 "Electrical armature power";
        Modelica.SIunits.Power powerMechanical=0 "Mechanical power";
        Modelica.SIunits.Power powerInertiaStator=0 "Stator inertia power";
        Modelica.SIunits.Power powerInertiaRotor=0 "Rotor inertia power";
        Modelica.SIunits.Power lossPowerTotal=0 "Total loss power";
        Modelica.SIunits.Power lossPowerArmature=0 "Armature copper losses";
        Modelica.SIunits.Power lossPowerCore=0 "Core losses";
        Modelica.SIunits.Power lossPowerStrayLoad=0 "Stray load losses";
        Modelica.SIunits.Power lossPowerFriction=0 "Friction losses";
        Modelica.SIunits.Power lossPowerBrush=0 "Brush losses";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Partial power balance of DC machines.
 </html>"));
      end PartialPowerBalanceDCMachines;

      connector ThermalPortDCPM
        "Thermal port of DC machine with permanent magnets"
        extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortPermanentMagnet "Heat port of permanent magnets"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        annotation (Documentation(info="<html>
Thermal port for DC machine with permanent magnets
</html>"));
      end ThermalPortDCPM;

      record PowerBalanceDCPM
        "Power balance of DC machines with permanent magnet"
        extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(
            final lossPowerTotal=lossPowerArmature + lossPowerCore +
              lossPowerStrayLoad + lossPowerFriction + lossPowerBrush +
              lossPowerPermanentMagnet);
        Modelica.SIunits.Power lossPowerPermanentMagnet
          "Permanent magnet losses";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of DC machines with permanent magnet.
 </html>"));
      end PowerBalanceDCPM;

      connector ThermalPortDCEE
        "Thermal port of DC machine with electrical excitation"
        extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortExcitation
          "Heat port of (shunt) excitation"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        annotation (Documentation(info="<html>
Thermal port for DC machine with electrical (shunt) excitation
</html>"));
      end ThermalPortDCEE;

      record PowerBalanceDCEE
        "Power balance of DC machines with electrical excitation"
        extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(
            final lossPowerTotal=lossPowerArmature + lossPowerCore +
              lossPowerStrayLoad + lossPowerFriction + lossPowerBrush +
              lossPowerExcitation);
        Modelica.SIunits.Power powerExcitation
          "Electrical (shunt) excitation power";
        Modelica.SIunits.Power lossPowerExcitation "Excitation losses";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of DC machines with electrical excitation.
 </html>"));
      end PowerBalanceDCEE;

      connector ThermalPortDCSE
        "Thermal port of DC machine with series excitation"
        extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortSeriesExcitation "Heat port of series excitation"
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        annotation (Documentation(info="<html>
Thermal port for DC machine with serial excitation
</html>"));
      end ThermalPortDCSE;

      record PowerBalanceDCSE
        "Power balance of DC machines with series excitation"
        extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(
            final lossPowerTotal=lossPowerArmature + lossPowerCore +
              lossPowerStrayLoad + lossPowerFriction + lossPowerBrush +
              lossPowerSeriesExcitation);
        Modelica.SIunits.Power powerSeriesExcitation
          "Electrical series excitation power";
        Modelica.SIunits.Power lossPowerSeriesExcitation
          "Series excitation losses";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of DC machines with series excitation.
 </html>"));
      end PowerBalanceDCSE;

      connector ThermalPortDCCE
        "Thermal port of DC machine with compound excitation"
        extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortShuntExcitation "Heat port of (shunt) excitation"
          annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
          heatPortSeriesExcitation "Heat port of series excitation"
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        annotation (Documentation(info="<html>
Thermal port for DC machine with compound excitation
</html>"));
      end ThermalPortDCCE;

      record PowerBalanceDCCE
        "Power balance of DC machines with compound excitation"
        extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(
            final lossPowerTotal=lossPowerArmature + lossPowerCore +
              lossPowerStrayLoad + lossPowerFriction + lossPowerBrush +
              lossPowerShuntExcitation + lossPowerSeriesExcitation);
        Modelica.SIunits.Power powerShuntExcitation
          "Electrical (shunt) excitation power";
        Modelica.SIunits.Power powerSeriesExcitation
          "Electrical series excitation power";
        Modelica.SIunits.Power lossPowerShuntExcitation
          "(Shunt) excitation losses";
        Modelica.SIunits.Power lossPowerSeriesExcitation
          "Series excitation losses";
        annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of DC machines with compound excitation.
 </html>"));
      end PowerBalanceDCCE;
      annotation (Documentation(info="<html>
Thermal ports for DC machines
</html>"));
    end DCMachines;

    partial model PartialBasicTransformer
      "Partial model of three-phase transformer"
      extends Machines.Icons.TransientTransformer;
      final parameter Integer m(min=1) = 3 "Number of phases";
      constant String VectorGroup="Yy00";
      parameter Real n(start=1)
        "Ratio primary voltage (line-to-line) / secondary voltage (line-to-line)";
      parameter Modelica.SIunits.Resistance R1(start=5E-3/(if C1 == "D" then 1
             else 3)) "Primary resistance per phase at TRef"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature T1Ref(start=293.15)
        "Reference temperature of primary resistance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20_1(start=
           0) "Temperature coefficient of primary resistance at 20 degC"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance L1sigma(start=78E-6/(if C1 == "D"
             then 1 else 3)) "Primary stray inductance per phase"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Resistance R2(start=5E-3/(if C2 == "d" then 1
             else 3)) "Secondary resistance per phase at TRef"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature T2Ref(start=293.15)
        "Reference temperature of secondary resistance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20_2(start=
           0) "Temperature coefficient of secondary resistance at 20 degC"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance L2sigma(start=78E-6/(if C2 == "d"
             then 1 else 3)) "Secondary stray inductance per phase"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Boolean useThermalPort=false
        "Enable / disable (=fixed temperatures) thermal port"
        annotation (Evaluate=true);
      parameter Modelica.SIunits.Temperature T1Operational(start=293.15)
        "Operational temperature of primary resistance" annotation (Dialog(
            group="Operational temperatures", enable=not useThermalPort));
      parameter Modelica.SIunits.Temperature T2Operational(start=293.15)
        "Operational temperature of secondary resistance" annotation (Dialog(
            group="Operational temperatures", enable=not useThermalPort));
      output Machines.Interfaces.PowerBalanceTransformer powerBalance(
        final power1=Machines.SpacePhasors.Functions.activePower(v1, i1),
        final power2=Machines.SpacePhasors.Functions.activePower(v2, i2),
        final lossPower1=sum(r1.resistor.LossPower),
        final lossPower2=sum(r2.resistor.LossPower),
        final lossPowerCore=0) "Power balance";
      output Modelica.SIunits.Voltage v1[m]=plug1.pin.v "Primary voltage";
      output Modelica.SIunits.Current i1[m]=plug1.pin.i "Primary current";
      output Modelica.SIunits.Voltage v2[m]=plug2.pin.v "Secondary voltage";
      output Modelica.SIunits.Current i2[m]=plug2.pin.i "Secondary current";
    protected
      constant String C1=Modelica.Utilities.Strings.substring(
              VectorGroup,
              1,
              1);
      constant String C2=Modelica.Utilities.Strings.substring(
              VectorGroup,
              2,
              2);
      parameter Real ni=n*(if C2 == "z" then sqrt(3) else 2)*(if C2 == "d"
           then 1 else sqrt(3))/(if C1 == "D" then 1 else sqrt(3));
    public
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug1(final m=m)
        "Primary plug" annotation (Placement(transformation(extent={{-110,-10},
                {-90,10}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug2(final m=m)
        "Secondary plug" annotation (Placement(transformation(extent={{90,-10},
                {110,10}})));
      Modelica.Electrical.MultiPhase.Basic.Resistor r1(
        final m=m,
        final R=fill(R1, m),
        final T_ref=fill(T1Ref, m),
        final alpha=fill(Machines.Thermal.convertAlpha(alpha20_1, T1Ref), m),
        final useHeatPort=true,
        final T=fill(T1Ref, m)) annotation (Placement(transformation(extent={{-90,
                10},{-70,-10}})));
      Modelica.Electrical.MultiPhase.Basic.Inductor l1sigma(final m=m, final L=
            fill(L1sigma, m)) annotation (Placement(transformation(extent={{-70,
                -10},{-50,10}})));
      Modelica.Electrical.MultiPhase.Basic.Resistor r2(
        final m=m,
        final R=fill(R2, m),
        final T_ref=fill(T2Ref, m),
        final alpha=fill(Machines.Thermal.convertAlpha(alpha20_2, T2Ref), m),
        final useHeatPort=true,
        final T=fill(T2Ref, m)) annotation (Placement(transformation(extent={{
                90,10},{70,-10}})));
      Modelica.Electrical.MultiPhase.Basic.Inductor l2sigma(final m=m, final L=
            fill(L2sigma, m)) annotation (Placement(transformation(extent={{70,
                -10},{50,10}})));
      Machines.BasicMachines.Components.IdealCore core(
        final m=m,
        final n12=ni,
        final n13=ni) annotation (Placement(transformation(extent={{-10,-10},{
                10,10}})));
      Machines.Interfaces.ThermalPortTransformer thermalPort(final m=m) if
        useThermalPort
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Machines.Thermal.ThermalAmbientTransformer thermalAmbient(
        final useTemperatureInputs=false,
        final T1=T1Operational,
        final T2=T2Operational,
        final m=m) if not useThermalPort annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,80})));
    protected
      Machines.Interfaces.ThermalPortTransformer internalThermalPort(final m=m)
        annotation (Placement(transformation(extent={{-4,76},{4,84}})));
    equation
      connect(r1.plug_n, l1sigma.plug_p)
        annotation (Line(points={{-70,0},{-70,0}}, color={0,0,255}));
      connect(plug1, r1.plug_p)
        annotation (Line(points={{-100,0},{-90,0}}, color={0,0,255}));
      connect(thermalPort, internalThermalPort) annotation (Line(
          points={{0,100},{0,80}}, color={191,0,0}));
      connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
          points={{-20,80},{0,80}}, color={191,0,0}));
      connect(r1.heatPort, internalThermalPort.heatPort1) annotation (Line(
          points={{-80,10},{-80,60},{-0.4,60},{-0.4,80.8}}, color={191,0,0}));
      connect(r2.heatPort, internalThermalPort.heatPort2) annotation (Line(
          points={{80,10},{80,60},{-0.4,60},{-0.4,79.2}}, color={191,0,0}));
      connect(r2.plug_p, plug2) annotation (Line(
          points={{90,0},{100,0}}, color={0,0,255}));
      connect(l2sigma.plug_p, r2.plug_n) annotation (Line(
          points={{70,0},{70,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Text(
                  extent={{150,-60},{-150,-100}},
                  textString="%VectorGroup"),Text(
                  extent={{150,100},{-150,60}},
                  lineColor={0,0,255},
                  textString="%name")}),
        Documentation(info="<html>
Partial model of a three-phase transformer, containing primary and secondary resistances and stray inductances, as well as the iron core.
Circuit layout (vector group) of primary and secondary windings have to be defined.
<br><strong>Default values for transformer's parameters (a realistic example) are:</strong><br>
<table>
<tr>
<td>turns ratio n</td>
<td>1</td><td> </td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal apparent power</td>
<td>30</td><td>kVA</td>
</tr>
<tr>
<td>primary resistance R1</td>
<td>0.005</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature T1Ref</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20_1 </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>primary stray inductance L1sigma</td>
<td>78E-6</td><td>H per phase</td>
</tr>
<tr>
<td>secondary resistance R2</td>
<td>0.005</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature T2Ref</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20_2 </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>secondary stray inductance L2sigma</td>
<td>78E-6</td><td>H per phase</td>
</tr>
<tr>
<td>operational temperature T1Operational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>operational temperature T2Operational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the operational parameters:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>nominal voltage drop</td>
<td>0.05</td><td>p.u.</td>
</tr>
<tr>
<td>nominal copper losses</td>
<td>300</td><td>W</td>
</tr>
</table>
</html>"));
    end PartialBasicTransformer;

    connector ThermalPortTransformer "Thermal port of transformers"
      parameter Integer m=3 "number of phases";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1[m]
        "Heat port of primary windings"
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort2[m]
        "Heat port of secondary windings"
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore
        "Heat port of (optional) core losses"
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        annotation (
        Diagram(graphics={Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={191,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid), Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}),
        Icon(graphics={Rectangle(
              extent={{-110,110},{110,-110}},
              lineColor={191,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid), Ellipse(
                  extent={{-80,80},{80,-80}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
Thermal port for transformers
</html>"));
    end ThermalPortTransformer;

    record PowerBalanceTransformer "Power balance of transformers"
      extends Modelica.Icons.Record;
      Modelica.SIunits.Power power1 "Primary power";
      Modelica.SIunits.Power power2 "Secondary power";
      Modelica.SIunits.Power lossPowerTotal=lossPower1 + lossPower2 +
          lossPowerCore "Total loss power";
      Modelica.SIunits.Power lossPower1 "Primary copper losses";
      Modelica.SIunits.Power lossPower2 "Secondary copper losses";
      Modelica.SIunits.Power lossPowerCore "Core losses";
      annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of transformers.
 </html>"));
    end PowerBalanceTransformer;

    partial model FlangeSupport "Shaft and support"
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Shaft end"
        annotation (Placement(transformation(extent={{-10,110},{10,90}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a support
        "Housing and support" annotation (Placement(transformation(extent={{-10,
                -110},{10,-90}})));
      Modelica.SIunits.Angle phi "Angle between shaft and support";
      Modelica.SIunits.Torque tau "Torque";
      Modelica.SIunits.AngularVelocity w
        "Relative angular velocity of flange and support";
    equation
      phi = flange.phi - support.phi;
      w = der(phi);
      tau = -flange.tau;
      tau = support.tau;
      annotation (Documentation(info="<html>
<p>
This partial model defines shaft and housing connector for loss models.
Positive torque <code>tau</code> acts as braking torque.
</p>
</html>"), Icon(graphics={Rectangle(
              extent={{-20,-80},{20,-120}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid)}));
    end FlangeSupport;
    annotation (Documentation(info="<html>
This package contains the space phasor connector and partial models for machine models.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.01 2004/09/18 Anton Haumer<br>
       moved common equations from machine models to PartialMachine</li>
  <li> v1.02 2004/09/19 Anton Haumer<br>
       added PartialDCMachine</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       fixed a bug with support (formerly bearing)</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       removed mechanical flange support<br>
       to ease the implementation of a 3D-frame in a future release</li>
  <li> v1.51 Beta 2005/02/01 Anton Haumer<br>
       changed parameter polePairs to Integer</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"));
  end Interfaces;

  package Icons "Icons for electrical machines"
    extends Modelica.Icons.IconsPackage;
    partial model Machine "Generic icon of an electric machine"

      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,60},{80,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={215,215,215}),
            Rectangle(
              extent={{-40,60},{-60,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Rectangle(
              extent={{80,10},{100,-10}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={95,95,95}),
            Rectangle(
              extent={{-40,70},{40,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},
                  {80,-100},{-50,-100},{-50,-90}},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
This icon represents a generic electric machine model.
</p>
</html>"));
    end Machine;

    partial model Drive "Generic icon of an electric drive"

      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,60},{80,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={215,215,215}),
            Rectangle(
              extent={{-40,60},{-60,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Rectangle(
              extent={{80,10},{100,-10}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={95,95,95}),
            Rectangle(
              extent={{-40,100},{40,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},
                  {80,-100},{-50,-100},{-50,-90}},
              fillPattern=FillPattern.Solid),
            Line(
              points={{12,92},{12,60}},
              color={255,255,255}),
            Line(points={{-12,60},{-12,92},{12,76},{-12,60}}, color={255,255,255}),
            Line(
              points={{-26,76},{26,76}},
              color={255,255,255})}),           Documentation(info="<html>
<p>
This icon represents a generic electric drive model.
</p>
</html>"));
    end Drive;

    partial model TransientMachine
      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,60},{80,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-40,60},{-60,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Rectangle(
              extent={{80,10},{100,-10}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={95,95,95}),
            Rectangle(
              extent={{-40,70},{40,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},
                  {80,-100},{-50,-100},{-50,-90}},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
This icon is designed for a <strong>transient machine</strong> model.
</p>
</html>"));
    end TransientMachine;

    partial model QuasiStationaryMachine
      annotation (Icon(graphics={Rectangle(
                  extent={{-40,60},{80,-60}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={170,213,255}),Rectangle(
                  extent={{-40,60},{-60,-60}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={128,128,128}),Rectangle(
                  extent={{80,10},{100,-10}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={95,95,95}),Rectangle(
                  extent={{-40,70},{40,50}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},
                {80,-100},{-50,-100},{-50,-90}},
                  fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
This icon is designed for a <strong>quasistationary machine</strong> model.
</p>
</html>"));
    end QuasiStationaryMachine;

    partial model FundamentalWaveMachine
      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,60},{80,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,128,0}),
            Rectangle(
              extent={{-40,60},{-60,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Rectangle(
              extent={{80,10},{100,-10}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={95,95,95}),
            Rectangle(
              extent={{-40,70},{40,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},
                  {80,-100},{-50,-100},{-50,-90}},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
This icon is designed for a <strong>FundamentalWave machine</strong> model.
</p>
</html>"));
    end FundamentalWaveMachine;

    model TransientTransformer
      annotation (Icon(graphics={Polygon(
                  points={{-70,60},{-50,40},{-50,-40},{-70,-60},{-70,60}},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.VerticalCylinder),Polygon(
                  points={{70,60},{50,40},{50,-40},{70,-60},{70,60}},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.VerticalCylinder),Polygon(
                  points={{0,50},{-10,40},{-10,-40},{0,-50},{10,-40},{10,40},{0,
                50}},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={135,135,135}),Polygon(
                  points={{-70,60},{70,60},{50,40},{10,40},{0,50},{-10,40},{-50,
                40},{-70,60}},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={135,135,135}),Polygon(
                  points={{-70,-60},{70,-60},{50,-40},{10,-40},{0,-50},{-10,-40},
                {-50,-40},{-70,-60}},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={135,135,135}),Rectangle(
                  extent={{-78,36},{-42,-36}},
                  lineColor={128,0,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={128,0,255}),Rectangle(
                  extent={{-84,28},{-36,-28}},
                  lineColor={0,128,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={0,128,255}),Rectangle(
                  extent={{-18,36},{18,-36}},
                  lineColor={128,0,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={128,0,255}),Rectangle(
                  extent={{-24,28},{24,-28}},
                  lineColor={0,128,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={0,128,255}),Rectangle(
                  extent={{42,36},{78,-36}},
                  lineColor={128,0,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={128,0,255}),Rectangle(
                  extent={{36,28},{84,-28}},
                  lineColor={0,128,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={0,128,255})}), Documentation(info="<html>
<p>
This icon is designed for a <strong>transient transformer</strong> model.
</p>
</html>"));

    end TransientTransformer;

    partial model QuasiStationaryTransformer
      annotation (Icon(graphics={Polygon(
                  points={{-70,60},{-50,40},{-50,-40},{-70,-60},{-70,60}},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.VerticalCylinder),Polygon(
                  points={{70,60},{50,40},{50,-40},{70,-60},{70,60}},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.VerticalCylinder),Polygon(
                  points={{0,50},{-10,40},{-10,-40},{0,-50},{10,-40},{10,40},{0,
                50}},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={135,135,135}),Polygon(
                  points={{-70,60},{70,60},{50,40},{10,40},{0,50},{-10,40},{-50,
                40},{-70,60}},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={135,135,135}),Polygon(
                  points={{-70,-60},{70,-60},{50,-40},{10,-40},{0,-50},{-10,-40},
                {-50,-40},{-70,-60}},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={135,135,135}),Rectangle(
                  extent={{-78,36},{-42,-36}},
                  lineColor={213,170,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={213,170,255}),Rectangle(
                  extent={{-84,28},{-36,-28}},
                  lineColor={170,213,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={170,213,255}),Rectangle(
                  extent={{-18,36},{18,-36}},
                  lineColor={213,170,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={213,170,255}),Rectangle(
                  extent={{-24,28},{24,-28}},
                  lineColor={170,213,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={170,213,255}),Rectangle(
                  extent={{42,36},{78,-36}},
                  lineColor={213,170,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={213,170,255}),Rectangle(
                  extent={{36,28},{84,-28}},
                  lineColor={170,213,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={170,213,255})}), Documentation(info="<html>
<p>
This icon is designed for a <strong>quasistationary transformer</strong> model.
</p>
</html>"));
    end QuasiStationaryTransformer;

    partial model QuasiStaticFundamentalWaveMachine
      "Icon of quasi static fundamental wave machine"

      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,60},{80,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,206,120}),
            Rectangle(
              extent={{-40,60},{-60,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={128,128,128}),
            Rectangle(
              extent={{80,10},{100,-10}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={95,95,95}),
            Rectangle(
              extent={{-40,70},{40,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},
                  {80,-100},{-50,-100},{-50,-90}},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
This icon is designed for a <strong>quasi static fundamental wave machine</strong> model.
</p>
</html>"));
    end QuasiStaticFundamentalWaveMachine;
    annotation (Documentation(info="<html>
<p>
This package contains definitions for the graphical layout of machines.
The icons can be utilized by inheriting them in the desired class using \"extends\" or by directly copying the \"icon\" layer.
</p>
</html>"));
  end Icons;

  package Utilities "Library with auxiliary models for testing"
    extends Modelica.Icons.UtilitiesPackage;
    package ParameterRecords "Parameter records"
      extends Modelica.Icons.RecordsPackage;
      record InductionMachineData "Common parameters for induction machines"
        extends Modelica.Icons.Record;
        import Modelica.Constants.pi;
        final parameter Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Inertia Jr=0.29 "Rotor's moment of inertia";
        parameter Modelica.SIunits.Inertia Js=Jr "Stator's moment of inertia";
        parameter Integer p(min=1) = 2 "Number of pole pairs (Integer)";
        parameter Modelica.SIunits.Frequency fsNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Resistance Rs=0.03
          "Stator resistance per phase at TRef"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TsRef=293.15
          "Reference temperature of stator resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s=0 "Temperature coefficient of stator resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Real effectiveStatorTurns=1 "Effective number of stator turns";
        parameter Modelica.SIunits.Inductance Lszero=Lssigma
          "Stator zero sequence inductance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/
            (2*pi*fsNominal) "Stator stray inductance per phase"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Losses.FrictionParameters frictionParameters(PRef=0,
            wRef=2*pi*fsNominal/p) "Friction loss parameter record"
          annotation (Dialog(tab="Losses"));
        parameter Machines.Losses.CoreParameters statorCoreParameters(
          final m=m,
          PRef=0,
          VRef=100,
          wRef=2*pi*fsNominal) "Stator core loss parameter record; all parameters refer to stator side"
          annotation (Dialog(tab="Losses"));
        parameter Machines.Losses.StrayLoadParameters strayLoadParameters(
          PRef=0,
          IRef=100,
          wRef=2*pi*fsNominal/p) "Stray load losses"
          annotation (Dialog(tab="Losses"));
        annotation (
          defaultComponentName="inductionMachineData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of induction machines are predefined with default values.</p>
</html>"));
      end InductionMachineData;

      record AIM_SquirrelCageData
        "Common parameters for asynchronous induction machines with squirrel cage"
        extends InductionMachineData;
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Inductance Lm=3*sqrt(1 - 0.0667)/(2*pi*
            fsNominal) "Stator main field inductance per phase"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/
            (2*pi*fsNominal)
          "Rotor stray inductance per phase (equivalent three phase winding)"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance Rr=0.04
          "Rotor resistance per phase (equivalent three phase winding) at TRef"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrRef=293.15
          "Reference temperature of rotor resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r=0 "Temperature coefficient of rotor resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        annotation (
          defaultComponentName="aimcData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of asynchronous induction machines with squirrel cage are predefined with default values.</p>
</html>"));
      end AIM_SquirrelCageData;

      record AIM_SlipRingData
        "Common parameters for asynchronous induction machines with slip ring"
        extends InductionMachineData;
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Inductance Lm=3*sqrt(1 - 0.0667)/(2*pi*
            fsNominal) "Stator main field inductance per phase"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/
            (2*pi*fsNominal)/turnsRatio^2
          "Rotor stray inductance per phase w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lrzero=Lrsigma/turnsRatio^2
          "Rotor zero sequence inductance w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance Rr=0.04/turnsRatio^2
          "Rotor resistance per phase at TRef w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrRef=293.15
          "Reference temperature of rotor resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r=0 "Temperature coefficient of rotor resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useTurnsRatio=true
          "Use turnsRatio or calculate from locked-rotor voltage?";
        parameter Real turnsRatio(final min=Modelica.Constants.small)=
          VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs^2 + (2*pi*
          fsNominal*(Lm + Lssigma))^2)
          "Effective number of stator turns / effective number of rotor turns"
          annotation (Dialog(enable=useTurnsRatio));
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal stator voltage per phase"
          annotation (Dialog(enable=not useTurnsRatio));
        parameter Modelica.SIunits.Voltage VrLockedRotor=100*(2*pi*fsNominal*Lm)
            /sqrt(Rs^2 + (2*pi*fsNominal*(Lm + Lssigma))^2)
          "Locked-rotor voltage per phase"
          annotation (Dialog(enable=not useTurnsRatio));
        parameter Machines.Losses.CoreParameters rotorCoreParameters(
          final m=3,
          PRef=0,
          VRef=1,
          wRef=1) "Rotor core loss parameter record; all parameters refer to rotor side"
          annotation (Dialog(tab="Losses"));
        annotation (
          defaultComponentName="aimsData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of asynchronous induction machines with slip ring are predefined with default values.</p>
</html>"));
      end AIM_SlipRingData;

      record SM_PermanentMagnetData
        "Common parameters for synchronous induction machines with permanent magnet"
        extends SM_ReluctanceRotorData(Lmd=0.3/(2*pi*fsNominal), Lmq=0.3/(2*pi*
              fsNominal));
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Voltage VsOpenCircuit=112.3
          "Open circuit RMS voltage per phase @ fsNominal";
        parameter Machines.Losses.PermanentMagnetLossParameters
          permanentMagnetLossParameters(
          PRef=0,
          IRef=100,
          wRef=2*pi*fsNominal/p) "Permanent magnet loss parameter record"
          annotation (Dialog(tab="Losses"));
        annotation (
          defaultComponentName="smpmData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of synchronous induction machines with permanent magnet are predefined with default values.</p>
</html>"));
      end SM_PermanentMagnetData;

      record SM_ElectricalExcitedData
        "Common parameters for synchronous induction machines with electrical excitation"
        extends SM_ReluctanceRotorData(Lmd=1.5/(2*pi*fsNominal), Lmq=1.5/(2*pi*
              fsNominal));
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal stator RMS voltage per phase"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Current IeOpenCircuit=10
          "Open circuit excitation current @ nominal voltage and frequency"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Resistance Re=2.5
          "Excitation resistance at TRef" annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef=293.15
          "Reference temperature of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e=0 "Temperature coefficient of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Real sigmae(
          min=0,
          max=0.99) = 0.025 "Stray fraction of total excitation inductance"
          annotation (Dialog(tab="Excitation"));
        parameter Machines.Losses.BrushParameters brushParameters(V=0, ILinear=
              0.01) "Brush loss parameter record"
          annotation (Dialog(tab="Losses"));
        annotation (
          defaultComponentName="smeeData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of synchronous induction machines with electrical excitation are predefined with default values.</p>
</html>"));
      end SM_ElectricalExcitedData;

      record SM_ReluctanceRotorData
        "Common parameters for synchronous induction machines with reluctance rotor"
        extends InductionMachineData(Lssigma=0.1/(2*pi*fsNominal));
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Inductance Lmd=2.9/(2*pi*fsNominal)
          "Stator main field inductance per phase in d-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lmq=0.9/(2*pi*fsNominal)
          "Stator main field inductance per phase in q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useDamperCage=true "Enable / disable damper cage"
          annotation (Evaluate=true,Dialog(tab=
                "Nominal resistances and inductances", group="DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad=0.05/(2*pi*fsNominal)
          "Damper stray inductance in d-axis" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Damper stray inductance in q-axis" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd=0.04
          "Damper resistance in d-axis at TRef" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Damper resistance in q-axis at TRef" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef=293.15
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r=0 "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        annotation (
          defaultComponentName="smrData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of synchronous induction machines with reluctance rotor are predefined with default values.</p>
</html>"));
      end SM_ReluctanceRotorData;

      record DcPermanentMagnetData "Common parameters for DC machines"
        extends Modelica.Icons.Record;
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Inertia Jr=0.15 "Rotor's moment of inertia";
        parameter Modelica.SIunits.Inertia Js=Jr "Stator's moment of inertia";
        parameter Modelica.SIunits.Voltage VaNominal=100
          "Nominal armature voltage"
          annotation (Dialog(tab="Nominal parameters"));
        parameter Modelica.SIunits.Current IaNominal=100
          "Nominal armature current (>0..Motor, <0..Generator)"
          annotation (Dialog(tab="Nominal parameters"));
        parameter Modelica.SIunits.AngularVelocity wNominal(displayUnit="rev/min")=
             1425*2*pi/60 "Nominal speed"
          annotation (Dialog(tab="Nominal parameters"));
        parameter Modelica.SIunits.Temperature TaNominal=293.15
          "Nominal armature temperature"
          annotation (Dialog(tab="Nominal parameters"));
        parameter Modelica.SIunits.Resistance Ra=0.05
          "Armature resistance at TRef"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TaRef=293.15
          "Reference temperature of armature resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20a=0 "Temperature coefficient of armature resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance La=0.0015 "Armature inductance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Losses.FrictionParameters frictionParameters(PRef=0,
            wRef=wNominal) "Friction loss parameter record"
          annotation (Dialog(tab="Losses"));
        parameter Modelica.SIunits.Voltage ViNominal=VaNominal -
            Machines.Thermal.convertResistance(
                  Ra,
                  TaRef,
                  alpha20a,
                  TaNominal)*IaNominal -
            Machines.Losses.DCMachines.brushVoltageDrop(brushParameters,
            IaNominal);
        parameter Machines.Losses.CoreParameters coreParameters(
          final m=1,
          PRef=0,
          VRef=ViNominal,
          wRef=wNominal) "Armature core loss parameter record"
          annotation (Dialog(tab="Losses"));
        parameter Machines.Losses.StrayLoadParameters strayLoadParameters(
          PRef=0,
          IRef=IaNominal,
          wRef=wNominal) "Stray load losses" annotation (Dialog(tab="Losses"));
        parameter Machines.Losses.BrushParameters brushParameters(V=0, ILinear=
              0.01*IaNominal) "Brush loss parameter record"
          annotation (Dialog(tab="Losses"));
        annotation (
          defaultComponentName="dcpmData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of DC machines are predefined with default values.</p>
</html>"));
      end DcPermanentMagnetData;

      record DcElectricalExcitedData "Common parameters for DC machines"
        extends DcPermanentMagnetData;
        parameter Modelica.SIunits.Current IeNominal=1
          "Nominal excitation current" annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Resistance Re=100
          "Field excitation resistance at TRef"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef=293.15
          "Reference temperature of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e=0 "Temperature coefficient of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Inductance Le=1
          "Total field excitation inductance"
          annotation (Dialog(tab="Excitation"));
        parameter Real sigmae(
          min=0,
          max=0.99) = 0 "Stray fraction of total excitation inductance"
          annotation (Dialog(tab="Excitation"));
        annotation (
          defaultComponentName="dceeData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of DC machines are predefined with default values.</p>
</html>"));
      end DcElectricalExcitedData;

      record DcSeriesExcitedData "Common parameters for DC machines"
        extends DcPermanentMagnetData(wNominal=1410*2*pi/60);
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Resistance Re=0.01
          "Series excitation resistance at TRef"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef=293.15
          "Reference temperature of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e=0 "Temperature coefficient of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Inductance Le=0.0005
          "Total field excitation inductance"
          annotation (Dialog(tab="Excitation"));
        parameter Real sigmae(
          min=0,
          max=0.99) = 0 "Stray fraction of total excitation inductance"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeNominal=293.15
          "Nominal series excitation temperature"
          annotation (Dialog(tab="Nominal parameters"));
        annotation (
          defaultComponentName="dcseData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of DC machines are predefined with default values.</p>
</html>"));
      end DcSeriesExcitedData;

      record TransformerData "Common parameters for transformers"
        extends Modelica.Icons.Record;
        parameter Real n_phase=1
          "Ratio primary voltage per phase / secondary voltage per phase";
        parameter String C1="Y" "Choose primary connection" annotation (choices(
              choice="Y" "Star connection", choice="D" "Delta connection"));
        parameter String C2="y" "Choose secondary connection" annotation (
            choices(
            choice="y" "Star connection",
            choice="d" "Delta connection",
            choice="z" "Zig-zag connection"));
        parameter Real n=n_phase*(if C1 == "D" and (C2 == "y" or C2 == "z")
             then 1/sqrt(3) else if C1 == "Y" and C2 == "d" then sqrt(3) else 1)
          "Ratio primary voltage (line-to-line) / secondary voltage (line-to-line)"
          annotation (Dialog(enable=false));
        parameter Modelica.SIunits.Resistance R1=5E-3/3
          "Primary resistance per phase at TRef"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature T1Ref=293.15
          "Reference temperature of primary resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20_1=0 "Temperature coefficient of primary resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance L1sigma=78E-6/3
          "Primary stray inductance per phase"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance R2=5E-3/3
          "Secondary resistance per phase at TRef"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature T2Ref=293.15
          "Reference temperature of secondary resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20_2=0 "Temperature coefficient of secondary resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance L2sigma=78E-6/3
          "Secondary stray inductance per phase"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        annotation (
          defaultComponentName="transformerData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of transformers are predefined with default values.</p>
<p>Note: ratio n is defined between primary / secondary line-to-line voltage;
   therefore the user has to take into account primary and secondary connection!</p>
</html>"));
      end TransformerData;
    end ParameterRecords;

    block VfController "Voltage-Frequency-Controller"
      import Modelica.Constants.pi;
      extends Modelica.Blocks.Interfaces.SIMO(u(unit="Hz"), final nout=m);
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Angle orientation[m]=-
          Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m)
        "Orientation of phases";
      parameter Modelica.SIunits.Voltage VNominal "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal "Nominal frequency";
      parameter Modelica.SIunits.Angle BasePhase=0 "Common phase shift";
      parameter Boolean EconomyMode=false "Economy mode: voltage quadratic dependent on frquency"
        annotation(Evaluate=true,choices(checkBox=true));
      output Modelica.SIunits.Angle x(start=0, fixed=true) "Integrator state";
      output Modelica.SIunits.Voltage amplitude;
    protected
      parameter Integer pow=if EconomyMode then 2 else 1
        annotation(Evaluate=true);
    equation
      //amplitude = sqrt(2)*VNominal*min(abs(u)/fNominal, 1);
      amplitude = sqrt(2)*VNominal*(if abs(u) < fNominal then (abs(u)/fNominal)^pow else 1);
      der(x) = 2*pi*u;
      y = amplitude*sin(fill(x + BasePhase, m) + orientation);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(visible=not EconomyMode, points={{-100,-100},{0,60},{80,60}}, color={0,0,255}),
            Line(
              points={{-70,0},{-60.2,29.9},{-53.8,46.5},{-48.2,58.1},{-43.3,
                  65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},{-23.6,61},{-18.6,
                  52},{-13,38.6},{-5.98,18.6},{8.79,-26.9},{15.1,-44},{20.8,-56.2},
                  {25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,-67.9},{45.4,-62.5},
                  {50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}},
              color={192,192,192},
              smooth=Smooth.Bezier),
            Line(
              points={{-40,0},{-30.2,29.9},{-23.8,46.5},{-18.2,58.1},{-13.3,
                  65.2},{-8.3,69.2},{-3.4,69.8},{1.5,67},{6.4,61},{11.4,52},{17,
                  38.6},{24.02,18.6},{38.79,-26.9},{45.1,-44},{50.8,-56.2},{
                  55.7,-64},{60.6,-68.6},{65.5,-70},{70.5,-67.9},{75.4,-62.5},{
                  80.3,-54.1},{85.9,-41.3},{93,-21.7},{100,0}},
              color={192,192,192},
              smooth=Smooth.Bezier),
            Line(
              points={{-100,0},{-90.2,29.9},{-83.8,46.5},{-78.2,58.1},{-73.3,
                  65.2},{-68.3,69.2},{-63.4,69.8},{-58.5,67},{-53.6,61},{-48.6,
                  52},{-43,38.6},{-35.98,18.6},{-21.21,-26.9},{-14.9,-44},{-9.2,
                  -56.2},{-4.3,-64},{0.6,-68.6},{5.5,-70},{10.5,-67.9},{15.4,-62.5},
                  {20.3,-54.1},{25.9,-41.3},{33,-21.7},{40,0}},
              color={192,192,192},
              smooth=Smooth.Bezier),
            Line(visible=EconomyMode, points={{-100,-100},{-90,-98},{-80,-94},{-70,-86},{-60,-74},
                  {-50,-60},{-40,-42},{-30,-22},{-20,2},{-10,30},{0,60},{80,60}},
                 color={0,0,255})}),   Documentation(info="<html>
Simple Voltage-Frequency-Controller.<br>
Amplitude of voltage is linear dependent (VNominal/fNominal) on frequency (input signal \"u\"), but limited by VNominal (nominal RMS voltage per phase).<br>
m sine-waves with amplitudes as described above are provided as output signal \"y\".<br>
By setting parameter EconomyMode=true, Voltage rises quadratically with frequency which means flux,torque and loss reduction for fan and pump drives.<br>
The sine-waves are intended to feed a m-phase SignalVoltage.<br>
Phase shifts between sine-waves may be chosen by the user; default values are <em>(k-1)/m*pi for k in 1:m</em>.
</html>"));
    end VfController;

    block ToDQ
      "Transform instantaneous stator inputs to rotor fixed space phasor"
      extends Modelica.Blocks.Interfaces.MIMO(final nin=m, final nout=2);
      parameter Integer m(min=1) = 3 "Number of phases";
      parameter Integer p "Number of pole pairs";
      Modelica.Blocks.Math.Gain toGamma(final k=p) annotation (Placement(
            transformation(
            origin={0,-50},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Interfaces.RealInput phi(unit="rad") annotation (Placement(
            transformation(
            origin={0,-120},
            extent={{20,-20},{-20,20}},
            rotation=270)));
      Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor
        toSpacePhasor(final m=m) annotation (Placement(transformation(extent={{
                -60,-10},{-40,10}})));
    equation
      connect(phi, toGamma.u)
        annotation (Line(points={{0,-120},{0,-120},{0,-62}}, color={0,0,127}));
      connect(rotator.angle, toGamma.y)
        annotation (Line(points={{0,-12},{0,-39},{0,-39}}, color={0,0,127}));
      connect(toSpacePhasor.y, rotator.u) annotation (Line(
          points={{-39,0},{-12,0}}, color={0,0,127}));
      connect(u, toSpacePhasor.u) annotation (Line(
          points={{-120,0},{-62,0}}, color={0,0,127}));
      connect(rotator.y, y) annotation (Line(
          points={{11,0},{110,0}}, color={0,0,127}));
      annotation (Documentation(info="<html>
<p>
The multi phase input values <code>u[m]</code> are transformed to the corresponding space phasor which is rotated to the rotor fixed reference system,
using the provided mechanical rotor angle phi. The output are the resulting d and q components of the space phasor arranged in one vector <code>y[2]</code>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.FromDQ\">FromDQ</a>
</p>
</html>"));
    end ToDQ;

    block FromDQ
      "Transform rotor fixed space phasor to instantaneous stator quantities"
      extends Modelica.Blocks.Interfaces.MIMO(final nin=2, final nout=m);
      parameter Integer m(min=1) = 3 "Number of phases";
      parameter Integer p "Number of pole pairs";
      Modelica.Blocks.Math.Gain toGamma(final k=-p) annotation (Placement(
            transformation(
            origin={0,-50},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.Constant i0(final k=0) annotation (Placement(
            transformation(extent={{20,-20},{40,-40}})));
      Modelica.Electrical.Machines.SpacePhasors.Blocks.FromSpacePhasor
        fromSpacePhasor(final m=m) annotation (Placement(transformation(extent=
                {{60,-10},{80,10}})));
      Modelica.Blocks.Interfaces.RealInput phi(unit="rad") annotation (Placement(
            transformation(
            origin={0,-120},
            extent={{20,-20},{-20,20}},
            rotation=270)));
    equation
      connect(phi, toGamma.u)
        annotation (Line(points={{0,-120},{0,-120},{0,-62}}, color={0,0,127}));
      connect(rotator.angle, toGamma.y)
        annotation (Line(points={{0,-12},{0,-39},{0,-39}}, color={0,0,127}));
      connect(rotator.y, fromSpacePhasor.u)
        annotation (Line(points={{11,0},{34,0},{58,0}}, color={0,0,127}));
      connect(i0.y, fromSpacePhasor.zero) annotation (Line(
          points={{41,-30},{50,-30},{50,-8},{58,-8}}, color={0,0,127}));
      connect(u, rotator.u) annotation (Line(
          points={{-120,0},{-12,0}}, color={0,0,127}));
      connect(fromSpacePhasor.y, y) annotation (Line(
          points={{81,0},{110,0}}, color={0,0,127}));
      annotation (Documentation(info="<html>
<p>
The d and q components of a space phasor <code>u[2]</code> are rotated back to the stator fixed reference system,
using the provided mechanical rotor angle phi. The output are the instantaneous multi phase values <code>y[m]</code>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.ToDQ\">ToDQ</a>
</p>
</html>"));
    end FromDQ;

    model CurrentController "Current controller"
      parameter Integer m=3 "Number of phases";
      parameter Integer p "Number of pole pairs";
      extends Modelica.Blocks.Interfaces.MO(final nout=m);
      Modelica.Blocks.Interfaces.RealInput id_rms annotation (Placement(
            transformation(extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput iq_rms annotation (Placement(
            transformation(extent={{-140,-80},{-100,-40}})));
      Modelica.Blocks.Interfaces.RealInput phi(unit="rad") annotation (Placement(
            transformation(
            origin={0,-120},
            extent={{20,-20},{-20,20}},
            rotation=270)));
      Modelica.Blocks.Math.Gain toPeak_d(k=sqrt(2)) annotation (Placement(
            transformation(extent={{-60,50},{-40,70}})));
      Modelica.Blocks.Math.Gain toPeak_q(k=sqrt(2)) annotation (Placement(
            transformation(extent={{-60,-70},{-40,-50}})));
      Modelica.Blocks.Math.Gain toGamma(k=-p) annotation (Placement(
            transformation(
            origin={0,-50},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Machines.SpacePhasors.Blocks.Rotator rotator annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.Constant i0(k=0) annotation (Placement(
            transformation(extent={{-10,50},{10,30}})));
      Machines.SpacePhasors.Blocks.FromSpacePhasor fromSpacePhasor(final m=m)
                                                                   annotation (
          Placement(transformation(extent={{40,10},{60,-10}})));
    equation
      connect(iq_rms, toPeak_q.u)
        annotation (Line(points={{-120,-60},{-62,-60}}, color={0,0,127}));
      connect(phi, toGamma.u)
        annotation (Line(points={{0,-120},{0,-62}}, color={0,0,127}));
      connect(rotator.angle, toGamma.y)
        annotation (Line(points={{0,-12},{0,-39},{0,-39}}, color={0,0,127}));
      connect(rotator.y, fromSpacePhasor.u)
        annotation (Line(points={{11,0},{24,0},{38,0}}, color={0,0,127}));
      connect(toPeak_d.u, id_rms) annotation (Line(
          points={{-62,60},{-120,60}}, color={0,0,127}));
      connect(toPeak_d.y, rotator.u[1]) annotation (Line(
          points={{-39,60},{-30,60},{-30,0},{-12,0}},   color={0,0,127}));
      connect(toPeak_q.y, rotator.u[2]) annotation (Line(
          points={{-39,-60},{-30,-60},{-30,0},{-12,0}}, color={0,0,127}));
      connect(i0.y, fromSpacePhasor.zero) annotation (Line(
          points={{11,40},{20,40},{20,8},{38,8}}, color={0,0,127}));
      connect(fromSpacePhasor.y, y) annotation (Line(
          points={{61,0},{110,0}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-100,60},{20,40}},
              lineColor={0,0,255},
              textString="id_rms"), Text(
              extent={{-100,-40},{20,-60}},
              lineColor={0,0,255},
              textString="iq_rms")}), Documentation(info="<html>
<p>
Simple Current-Controller.
</p>
<p>
The desired rms values of d- and q-component of the space phasor current in rotor fixed coordinate system are given by inputs \"id_rms\" and \"iq_rms\".
Using the given rotor position (input \"phi\"), the correct three-phase currents (output \"y[3]\") are calculated.
They can be used to feed a current source which in turn feeds an induction machine.
</p>
</html>"));
    end CurrentController;

    model VoltageController "Voltage controller"
      import Modelica.Constants.pi;
      constant Integer m=3 "Number of phases";
      parameter Integer p "Number of pole pairs";
      parameter Modelica.SIunits.Frequency fsNominal "Nominal frequency";
      parameter Modelica.SIunits.Voltage VsOpenCircuit
        "Open circuit RMS voltage per phase @ fsNominal";
      parameter Modelica.SIunits.Resistance Rs "Stator resistance per phase";
      parameter Modelica.SIunits.Inductance Ld "Inductance in d-axis";
      parameter Modelica.SIunits.Inductance Lq "Inductance in q-axis";
      //Decoupling
      parameter Boolean decoupling=false "Use decoupling network";
      final parameter Modelica.SIunits.MagneticFlux psiM=sqrt(2)*VsOpenCircuit/
          (2*pi*fsNominal);
      Modelica.SIunits.AngularVelocity omega=p*der(phi);
      Modelica.SIunits.Voltage Vd=sqrt(2)*(Rs*id_rms - omega*Lq*iq_rms);
      Modelica.SIunits.Voltage Vq=sqrt(2)*(Rs*iq_rms + omega*Ld*id_rms) + omega
          *psiM;
      extends Modelica.Blocks.Interfaces.MO(final nout=m);
      Modelica.Blocks.Interfaces.RealInput id_rms annotation (Placement(
            transformation(extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput iq_rms annotation (Placement(
            transformation(extent={{-140,-80},{-100,-40}})));
      Modelica.Blocks.Interfaces.RealInput phi(unit="rad") annotation (Placement(
            transformation(
            origin={60,-120},
            extent={{20,-20},{-20,20}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealInput iActual[m] annotation (Placement(
            transformation(
            origin={-60,-120},
            extent={{20,-20},{-20,20}},
            rotation=270)));
      Machines.Utilities.FromDQ fromDQ(final p=p, final m=m)
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      Machines.Utilities.ToDQ toDQ(final p=p, final m=m)
                                              annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-80})));
      Modelica.Blocks.Math.Gain toPeak_d(final k=sqrt(2)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            origin={-70,60})));
      Modelica.Blocks.Math.Gain toPeak_q(final k=sqrt(2)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            origin={-70,0})));
      Modelica.Blocks.Math.Feedback feedback_d
        annotation (Placement(transformation(extent={{-38,50},{-18,70}})));
      Modelica.Blocks.Math.Feedback feedback_q
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Blocks.Continuous.PI PI_d(
        final k=unitResistance/Rs,
        final T=Ld/Rs,
        initType=Modelica.Blocks.Types.Init.InitialOutput)
        annotation (Placement(transformation(extent={{-10,50},{10,70}})));
      Modelica.Blocks.Continuous.PI PI_q(
        final k=unitResistance/Rs,
        final T=Lq/Rs,
        initType=Modelica.Blocks.Types.Init.InitialOutput)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Math.Add add[2](final k1=fill(+1, 2), final k2=fill(if
            decoupling then +1 else 0, 2))
        annotation (Placement(transformation(extent={{32,-10},{52,10}})));
      Modelica.Blocks.Sources.RealExpression deCoupling[2](y={Vd,Vq})
        annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    protected
      constant Modelica.SIunits.Resistance unitResistance=1
        annotation (HideResult=true);
    equation
      connect(fromDQ.y, y) annotation (Line(
          points={{91,0},{110,0}}, color={0,0,127}));
      connect(phi, fromDQ.phi) annotation (Line(
          points={{60,-120},{60,-80},{80,-80},{80,-12}}, color={0,0,127}));
      connect(iActual, toDQ.u) annotation (Line(
          points={{-60,-120},{-60,-92}}, color={0,0,127}));
      connect(phi, toDQ.phi) annotation (Line(
          points={{60,-120},{60,-80},{-48,-80}}, color={0,0,127}));
      connect(toPeak_d.u, id_rms) annotation (Line(
          points={{-82,60},{-120,60}}, color={0,0,127}));
      connect(toPeak_q.u, iq_rms) annotation (Line(
          points={{-82,0},{-90,0},{-90,-60},{-120,-60}}, color={0,0,127}));
      connect(toPeak_q.y, feedback_q.u1) annotation (Line(
          points={{-59,0},{-38,0}}, color={0,0,127}));
      connect(toPeak_d.y, feedback_d.u1) annotation (Line(
          points={{-59,60},{-36,60}}, color={0,0,127}));
      connect(feedback_d.y, PI_d.u) annotation (Line(
          points={{-19,60},{-12,60}}, color={0,0,127}));
      connect(feedback_q.y, PI_q.u) annotation (Line(
          points={{-21,0},{-12,0}}, color={0,0,127}));
      connect(toDQ.y[1], feedback_d.u2) annotation (Line(
          points={{-60,-69},{-60,-60},{-50,-60},{-50,40},{-28,40},{-28,52}},     color={0,0,127}));

      connect(toDQ.y[2], feedback_q.u2) annotation (Line(
          points={{-60,-69},{-60,-60},{-50,-60},{-50,-20},{-30,-20},{-30,-8}},     color={0,0,127}));

      connect(add.y, fromDQ.u) annotation (Line(
          points={{53,0},{68,0}}, color={0,0,127}));
      connect(PI_d.y, add[1].u1) annotation (Line(
          points={{11,60},{20,60},{20,6},{30,6}}, color={0,0,127}));
      connect(PI_q.y, add[2].u1) annotation (Line(
          points={{11,0},{20,0},{20,6},{30,6}}, color={0,0,127}));
      connect(deCoupling.y, add.u2) annotation (Line(
          points={{11,-30},{20,-30},{20,-6},{30,-6}}, color={0,0,127}));
      annotation (
        Icon(graphics={Text(
              extent={{-100,60},{20,40}},
              lineColor={0,0,255},
              textString="id_rms"), Text(
              extent={{-100,-40},{20,-60}},
              lineColor={0,0,255},
              textString="iq_rms")}), Documentation(info="<html>
<p>
Simple Voltage-Controller
</p>
<p>
The desired rms values of d- and q-component of the space phasor current in rotor fixed coordinate system are given by inputs \"id_rms\" and \"iq_rms\".
Using the given rotor position (input \"phi\"), the actual threephase currents are measured and transformed to the d-q coordinate system.
Two PI-controller determine the necessary d- and q- voltages, which are transformed back to threephase (output \"y[3]\").
They can be used to feed a voltage source which in turn feeds a permanent magnet synchronous machine.
</p>
<p>
Note: No care is taken for current or voltage limiting, as well as for field weakening.
</p>
</html>"));
    end VoltageController;

    model SwitchYD "Y-D-switch"
      parameter Integer m=3 "Number of phases";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plugSupply(final m=
           m) "To grid" annotation (Placement(transformation(extent={{-10,90},{
                10,110}})));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m)
        "To positive stator plug" annotation (Placement(transformation(extent={
                {50,-90},{70,-110}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m)
        "To negative stator plug" annotation (Placement(transformation(extent={
                {-70,-90},{-50,-110}})));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
          Placement(transformation(extent={{20,-50},{40,-30}})));
      Modelica.Electrical.MultiPhase.Basic.Delta delta(final m=m) annotation (
          Placement(transformation(extent={{40,-80},{20,-60}})));
      Modelica.Electrical.MultiPhase.Ideal.IdealCommutingSwitch
        idealCommutingSwitch(
        final m=m,
        Ron=fill(1e-5, m),
        Goff=fill(1e-5, m)) annotation (Placement(transformation(extent={{-10,-70},
                {10,-50}})));
      Modelica.Blocks.Interfaces.BooleanInput control[m] annotation (Placement(
            transformation(extent={{-120,0},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
    equation
      connect(delta.plug_p, plugSupply) annotation (Line(points={{40,-70},{60,-70},
              {60,100},{0,100}}, color={0,0,255}));
      connect(delta.plug_p, plug_sp) annotation (Line(points={{40,-70},{60,-70},
              {60,-100}}, color={0,0,255}));
      connect(idealCommutingSwitch.plug_n2, delta.plug_n) annotation (Line(
            points={{10,-60},{10,-70},{20,-70}}, color={0,0,255}));
      connect(idealCommutingSwitch.plug_n1, star.plug_p) annotation (Line(
            points={{10,-56},{10,-40},{20,-40}}, color={0,0,255}));
      connect(idealCommutingSwitch.plug_p, plug_sn) annotation (Line(points={{-10,
              -60},{-60,-60},{-60,-100}}, color={0,0,255}));
      connect(control, idealCommutingSwitch.control)
        annotation (Line(points={{-110,10},{0,10},{0,-48}},
                                                          color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(
              points={{20,22},{40,12},{60,22},{40,12},{40,-10}},
              color={0,0,255}),
            Ellipse(
              extent={{-64,-16},{-56,-24}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-4,4},{4,-4}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-4,-36},{4,-44}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-2,-20},{-56,-20}}, color={0,0,255}),
            Line(points={{40,-62},{20,-30},{60,-30},{40,-62}}, color={0,0,255}),
            Line(points={{0,90},{0,88},{0,80},{80,80},{80,78},{80,-40},{60,-40}}, color={0,0,255}),
            Line(points={{4,0},{20,0}}, color={0,0,255}),
            Line(points={{4,-40},{20,-40}}, color={0,0,255}),
            Line(points={{-60,-24},{-60,-90}}, color={0,0,255}),
            Line(
              points={{-100,0},{-30,0},{-30,-20}},
              color={255,0,255},
              pattern=LinePattern.Dash),
            Line(points={{60,-90},{60,-40}}, color={0,0,255})}),
                                Documentation(info="<html>
Simple Star-Delta-switch.<br>
If <em>control</em> is false, plug_sp and plug_sn are star connected and plug_sp connected to the supply plug.<br>
If <em>control</em> is true, plug_sp and plug_sn are delta connected and they are connected to the supply plug.
</html>"));
    end SwitchYD;

    model TerminalBox "Terminal box Y/D-connection"
      parameter Integer m=3 "Number of phases";
      parameter String terminalConnection(start="Y") "Choose Y=star/D=delta"
        annotation (choices(choice="Y" "Star connection", choice="D"
            "Delta connection"));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m)
        "To positive stator plug" annotation (Placement(transformation(extent={{50,-50},
                {70,-70}}), iconTransformation(extent={{
                50,-50},{70,-70}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m)
        "To negative stator plug" annotation (Placement(transformation(extent={{-70,-50},
                {-50,-70}}), iconTransformation(extent={
                {-70,-50},{-50,-70}})));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) if (
        terminalConnection <> "D") annotation (Placement(transformation(
            origin={-70,-80},
            extent={{-10,10},{10,-10}},
            rotation=180)));
      Modelica.Electrical.MultiPhase.Basic.Delta delta(final m=m) if (
        terminalConnection == "D") annotation (Placement(transformation(extent=
                {{-20,-70},{-40,-50}})));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plugSupply(final m=
           m) "To grid" annotation (Placement(transformation(extent={{-10,-30},
                {10,-50}}), iconTransformation(extent={{-10,-30},{
                10,-50}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin starpoint if (
        terminalConnection <> "D") annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
                                  iconTransformation(extent={{-110,-50},{-90,-30}})));
    equation
      connect(plug_sn, star.plug_p)
        annotation (Line(points={{-60,-60},{-60,-80}}, color={0,0,255}));
      connect(plug_sn, delta.plug_n) annotation (Line(points={{-60,-60},{-40,
              -60},{-40,-60}}, color={0,0,255}));
      connect(delta.plug_p, plug_sp) annotation (Line(points={{-20,-60},{60,-60},
              {60,-60}}, color={0,0,255}));
      connect(plug_sp, plugSupply) annotation (Line(points={{60,-60},{0,-60},{0,
              -40}}, color={0,0,255}));
      connect(star.pin_n, starpoint)
        annotation (Line(points={{-80,-80},{-86,-80},{-86,-40},{-100,-40}},color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{-76,-40},{-80,-44},{-80,-80},{-40,-100},{40,-100},{80,-70},{80,-44},{76,-40},{-76,-40}},
              lineColor={95,95,95},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid), Text(
              extent={{-40,-50},{40,-90}},
              textString="%terminalConnection")}), Documentation(info="<html>
TerminalBox: at the bottom connected to both machine plugs, connect at the top to the grid as usual,<br>
choosing Y-connection (StarDelta=Y) or D-connection (StarDelta=D).
</html>"));
    end TerminalBox;

    model MultiTerminalBox "Terminal box Y/D-connection"
      parameter Integer m(min=1) = 3 "number of phases";
      final parameter Integer mSystems=
          Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
          m);
      final parameter Integer mBasic=integer(m/mSystems);
      parameter String terminalConnection(start="Y") "Choose Y=star/D=delta"
        annotation (choices(choice="Y" "Star connection", choice="D"
            "Delta connection"));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m)
        "To positive stator plug" annotation (Placement(transformation(extent={{50,-50},
                {70,-70}}), iconTransformation(extent={{
                50,-50},{70,-70}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m)
        "To negative stator plug" annotation (Placement(transformation(extent={{-70,-50},
                {-50,-70}}), iconTransformation(extent={
                {-70,-50},{-50,-70}})));
      MultiPhase.Basic.MultiStar multiStar(final m=m) if (terminalConnection
         <> "D") annotation (Placement(transformation(
            origin={-70,-80},
            extent={{-10,10},{10,-10}},
            rotation=180)));
      MultiPhase.Basic.MultiDelta multiDelta(final m=m) if (terminalConnection
         == "D") annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plugSupply(final m=
           m) "To grid" annotation (Placement(transformation(extent={{-10,-30},
                {10,-50}}), iconTransformation(extent={{-10,-30},{
                10,-50}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug starpoint(final m=
            mSystems) if (terminalConnection <> "D") annotation (Placement(
            transformation(extent={{-110,-50},{-90,-30}}),
            iconTransformation(extent={{-110,-50},{-90,-30}})));
    equation
      connect(plug_sn, multiStar.plug_p)
        annotation (Line(points={{-60,-60},{-60,-80}}, color={0,0,255}));
      connect(plug_sn, multiDelta.plug_n) annotation (Line(points={{-60,-60},{
              -40,-60},{-40,-60}}, color={0,0,255}));
      connect(multiDelta.plug_p, plug_sp) annotation (Line(points={{-20,-60},{
              60,-60},{60,-60}}, color={0,0,255}));
      connect(plug_sp, plugSupply) annotation (Line(points={{60,-60},{0,-60},{0,
              -40}}, color={0,0,255}));
      connect(starpoint, multiStar.starpoints) annotation (Line(
          points={{-100,-40},{-86,-40},{-86,-80},{-80,-80}},color={0,0,255}));
      annotation (defaultComponentName="terminalBox",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Polygon(
              points={{-74,-40},{-80,-46},{-80,-80},{-40,-100},{40,-100},{80,-70},{80,-44},{76,-40},{-74,-40}},
              lineColor={95,95,95},
              fillColor={135,135,135},
              fillPattern=FillPattern.CrossDiag), Text(
              extent={{-40,-50},{40,-90}},
              textString="%terminalConnection")}),
        Documentation(info="<html>
TerminalBox: at the bottom connected to both machine plugs, connect at the top to the grid as usual,<br>
choosing Y-connection (StarDelta=Y) or D-connection (StarDelta=D).
</html>"));
    end MultiTerminalBox;

    model SwitchedRheostat "Rheostat which is shortened after a given time"
      parameter Integer m=3 "Number of phases";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        "To positive rotor plug" annotation (Placement(transformation(extent={{
                90,70},{110,50}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        "To negative rotor plug" annotation (Placement(transformation(extent={{
                90,-50},{110,-70}})));
      parameter Modelica.SIunits.Resistance RStart "Starting resistance";
      parameter Modelica.SIunits.Time tStart
        "Duration of switching on the starting resistor";
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
          Placement(transformation(extent={{-40,-70},{-60,-50}})));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
            transformation(
            origin={-80,-60},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Ideal.IdealCommutingSwitch
        idealCommutingSwitch(
        final m=m,
        Ron=fill(1e-5, m),
        Goff=fill(1e-5, m)) annotation (Placement(transformation(
            origin={40,20},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.Resistor rheostat(final m=m, final R=
           fill(RStart, m)) annotation (Placement(transformation(extent={{0,-30},
                {-20,-10}})));
      Modelica.Electrical.MultiPhase.Basic.Star starRheostat(final m=m)
        annotation (Placement(transformation(extent={{-40,-30},{-60,-10}})));
      Modelica.Blocks.Sources.BooleanStep booleanStep[m](final startTime=fill(
            tStart, m), final startValue=fill(false, m)) annotation (Placement(
            transformation(extent={{-60,10},{-40,30}})));
    equation
      connect(plug_p, idealCommutingSwitch.plug_p) annotation (Line(
          points={{100,60},{40,60},{40,30}}, color={0,0,255}));
      connect(idealCommutingSwitch.plug_n2, plug_n) annotation (Line(
          points={{40,10},{40,-60},{100,-60}}, color={0,0,255}));
      connect(rheostat.plug_p, idealCommutingSwitch.plug_n1) annotation (Line(
          points={{0,-20},{36,-20},{36,10}}, color={0,0,255}));
      connect(idealCommutingSwitch.plug_n2, star.plug_p) annotation (Line(
          points={{40,10},{40,-60},{-40,-60}}, color={0,0,255}));
      connect(rheostat.plug_n, starRheostat.plug_p) annotation (Line(
          points={{-20,-20},{-40,-20}}, color={0,0,255}));
      connect(starRheostat.pin_n, star.pin_n) annotation (Line(
          points={{-60,-20},{-60,-60}}, color={0,0,255}));
      connect(star.pin_n, ground.p) annotation (Line(
          points={{-60,-60},{-70,-60}}, color={0,0,255}));
      connect(booleanStep.y, idealCommutingSwitch.control) annotation (Line(
          points={{-39,20},{28,20}}, color={255,0,255}));
      annotation (defaultComponentName="rheostat",
        Icon(graphics={
            Rectangle(
              extent={{26,40},{54,-40}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{100,60},{-40,60},{-40,40}}, color={0,0,255}),
            Line(points={{100,-60},{-40,-60},{-40,-40}}, color={0,0,255}),
            Ellipse(extent={{-44,40},{-36,32}}, lineColor={0,0,255}),
            Ellipse(extent={{-44,-32},{-36,-40}}, lineColor={0,0,255}),
            Line(points={{-80,40},{-42,-34}}, color={0,0,255}),
            Line(points={{40,40},{40,42},{40,60}}, color={0,0,255}),
            Line(points={{40,-40},{40,-60}}, color={0,0,255}),
            Line(points={{10,-80},{70,-80}}, color={0,0,255}),
            Line(points={{40,-60},{40,-80}}, color={0,0,255}),
            Line(points={{20,-90},{60,-90}}, color={0,0,255}),
            Line(points={{30,-100},{50,-100}}, color={0,0,255})}),
          Documentation(info="<html>
<p>Switched rheostat, used for starting asynchronous induction motors with slipring rotor:</p>
<p>The external rotor resistance <code>RStart</code> is shortened at time <code>tStart</code>.</p>
</html>"));
    end SwitchedRheostat;

    model RampedRheostat "Rheostat with linearly decreasing resistance"
      parameter Integer m=3 "Number of phases";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        "To positive rotor plug" annotation (Placement(transformation(extent={{
                90,70},{110,50}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        "To negative rotor plug" annotation (Placement(transformation(extent={{
                90,-50},{110,-70}})));
      parameter Modelica.SIunits.Resistance RStart "Starting resistance";
      parameter Modelica.SIunits.Time tStart
        "Time instance of reducing the rheostat";
      parameter Modelica.SIunits.Time tRamp "Duration of ramp";
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
          Placement(transformation(extent={{-20,-70},{-40,-50}})));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
            transformation(
            origin={-70,-60},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.MultiPhase.Basic.VariableResistor rheostat(final m=m)
        annotation (Placement(transformation(
            origin={60,0},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Blocks.Sources.Ramp ramp[m](
        final height=fill(-RStart, m),
        final duration=fill(tRamp, m),
        final offset=fill(RStart, m),
        final startTime=fill(tStart, m)) annotation (Placement(transformation(
              extent={{-20,-10},{0,10}})));
    equation
      connect(plug_p, rheostat.plug_p) annotation (Line(
          points={{100,60},{60,60},{60,10}}, color={0,0,255}));
      connect(rheostat.plug_n, plug_n) annotation (Line(
          points={{60,-10},{60,-60},{100,-60}}, color={0,0,255}));
      connect(rheostat.R, ramp.y) annotation (Line(
          points={{48,0},{26,0},{26,0},{1,0}}, color={0,0,127}));
      connect(rheostat.plug_n, star.plug_p) annotation (Line(
          points={{60,-10},{60,-60},{-20,-60}}, color={0,0,255}));
      connect(star.pin_n, ground.p) annotation (Line(
          points={{-40,-60},{-60,-60}}, color={0,0,255}));
      annotation (defaultComponentName="rheostat",
        Icon(graphics={
            Rectangle(
              extent={{26,40},{54,-40}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{100,-60},{40,-60},{40,-40}}, color={0,0,255}),
            Line(points={{10,-80},{70,-80}}, color={0,0,255}),
            Line(points={{40,-60},{40,-80}}, color={0,0,255}),
            Line(points={{20,-90},{60,-90}}, color={0,0,255}),
            Line(points={{30,-100},{50,-100}}, color={0,0,255}),
            Line(points={{40,40},{40,60},{100,60}}, color={0,0,255}),
            Rectangle(
              extent={{-100,40},{-20,-40}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,24},{-72,24},{-30,-30}}, color={0,0,255}),
            Polygon(
              points={{-20,6},{-10,0},{-20,-6},{-20,6}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{10,6},{20,0},{10,-6},{10,6}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-10,0},{10,0}}, color={0,0,255}),
            Line(points={{20,0},{26,0}}, color={0,0,255})}), Documentation(info=
             "<html>
<p>Ramped rheostat, used for starting asynchronous induction motors with slipring rotor:</p>
<p>The external rotor resistance <code>RStart</code> is reduced to zero,
starting at time <code>tStart</code> with a linear ramp <code>tRamp</code>.</p>
</html>"));
    end RampedRheostat;

    record SynchronousMachineData
      "Computes machine parameter from usual datasheet"
      extends Modelica.Icons.Record;
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.ApparentPower SNominal(start=30E3)
        "Nominal apparent power";
      parameter Modelica.SIunits.Voltage VsNominal(start=100)
        "Nominal stator voltage per phase";
      final parameter Modelica.SIunits.Current IsNominal=SNominal/(3*VsNominal)
        "Nominal stator current per phase";
      final parameter Modelica.SIunits.Impedance ZReference=VsNominal/IsNominal
        "Reference impedance";
      parameter Modelica.SIunits.Frequency fsNominal(start=50)
        "Nominal stator frequency";
      final parameter Modelica.SIunits.AngularVelocity omega=2*pi*fsNominal
        "Nominal angular frequency";
      parameter Modelica.SIunits.Current IeOpenCircuit(start=10)
        "Open circuit excitation current @ nominal voltage and frequency";
      parameter Real effectiveStatorTurns=1 "Effective number of stator turns";
      final parameter Real turnsRatio=sqrt(2)*VsNominal/(omega*Lmd*
          IeOpenCircuit) "Stator current / excitation current";
      parameter Real x0(start=0.1)
        "Stator stray inductance per phase (approximately zero impedance) [pu]";
      parameter Real xd(start=1.6)
        "Synchronous reactance per phase, d-axis [pu]";
      parameter Real xq(start=1.6)
        "Synchronous reactance per phase, q-axis [pu]";
      parameter Real xdTransient(start=0.1375)
        "Transient reactance per phase, d-axis [pu]";
      parameter Real xdSubtransient(start=0.121428571)
        "Subtransient reactance per phase, d-axis [pu]";
      parameter Real xqSubtransient(start=0.148387097)
        "Subtransient reactance per phase, q-axis [pu]";
      parameter Modelica.SIunits.Time Ta(start=0.014171268)
        "Armature time constant";
      parameter Modelica.SIunits.Time Td0Transient(start=0.261177343)
        "Open circuit field time constant Td0'";
      parameter Modelica.SIunits.Time Td0Subtransient(start=0.006963029)
        "Open circuit subtransient time constant Td0'', d-axis";
      parameter Modelica.SIunits.Time Tq0Subtransient(start=0.123345081)
        "Open circuit subtransient time constant Tq0'', q-axis";
      parameter Modelica.SIunits.Temperature TsSpecification(start=293.15)
        "Specification temperature of stator resistance"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TsRef(start=293.15)
        "Reference temperature of stator resistance"
        annotation (Dialog(tab="Material"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s(start=
            0) "Temperature coefficient of stator resistance at 20 degC"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TrSpecification(start=293.15)
        "Specification temperature of (optional) damper cage"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TrRef(start=293.15)
        "Reference temperature of damper resistances in d- and q-axis"
        annotation (Dialog(tab="Material"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=
            0) "Temperature coefficient of damper resistances in d- and q-axis"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TeSpecification(start=293.15)
        "Specification excitation temperature"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TeRef(start=293.15)
        "Reference temperature of excitation resistance"
        annotation (Dialog(tab="Material"));
      parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=
            0) "Temperature coefficient of excitation resistance"
        annotation (Dialog(tab="Material"));
      final parameter Real xmd=xd - x0
        "Main field reactance per phase, d-axis [pu]";
      final parameter Real xmq=xq - x0
        "Main field reactance per phase, q-axis [pu]";
      final parameter Real xe=xmd^2/(xd - xdTransient)
        "Excitation reactance [pu]";
      final parameter Real xrd=xmd^2/(xdTransient - xdSubtransient)*(1 - (xmd/
          xe))^2 + xmd^2/xe "Damper reactance per phase, d-axis [pu]";
      final parameter Real xrq=xmq^2/(xq - xqSubtransient)
        "Damper reactance per phase, d-axis [pu]";
      final parameter Real rs=2/(1/xdSubtransient + 1/xqSubtransient)/(omega*Ta)
        "Stator resistance per phase at specification temperature [pu]";
      final parameter Real rrd=(xrd - xmd^2/xe)/(omega*Td0Subtransient)
        "Damper resistance per phase at specification temperature, d-axis [pu]";
      final parameter Real rrq=xrq/(omega*Tq0Subtransient)
        "Damper resistance per phase at specification temperature, q-axis [pu]";
      final parameter Real re=xe/(omega*Td0Transient)
        "Excitation resistance per phase at specification temperature [pu]";
      parameter Modelica.SIunits.Resistance Rs=
          Machines.Thermal.convertResistance(
              rs*ZReference,
              TsSpecification,
              alpha20s,
              TsRef) "Stator resistance per phase at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lssigma=x0*ZReference/omega
        "Stator stray inductance per phase"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lmd=xmd*ZReference/omega
        "Main field inductance per phase in d-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lmq=xmq*ZReference/omega
        "Main field inductance per phase in q-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lrsigmad=(xrd - xmd)*ZReference/
          omega "Damper stray inductance in d-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lrsigmaq=(xrq - xmq)*ZReference/
          omega "Damper stray inductance in q-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Rrd=
          Machines.Thermal.convertResistance(
              rrd*ZReference,
              TrSpecification,
              alpha20r,
              TrRef) "Damper resistance in d-axis at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Rrq=
          Machines.Thermal.convertResistance(
              rrq*ZReference,
              TrSpecification,
              alpha20r,
              TrRef) "Damper resistance in q-axis at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Re=3/2*turnsRatio^2*
          Machines.Thermal.convertResistance(
              re*ZReference,
              TeSpecification,
              alpha20e,
              TeRef) "Excitation resistance at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Real sigmae=1 - xmd/xe
        "Stray fraction of total excitation inductance"
        annotation (Dialog(tab="Result", enable=false));
      annotation (
        defaultComponentName="smeeData",
        defaultComponentPrefixes="parameter",
        Documentation(info="<html>
<p>The parameters of the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">
synchronous machine model with electrical excitation (and damper)</a> are calculated from parameters
normally given in a technical description, according to the standard EN&nbsp;60034-4:2008&nbsp;Appendix&nbsp;C.</p>
</html>"));
    end SynchronousMachineData;

    record TransformerData "Calculates Impedances from nominal values"
      extends Modelica.Icons.Record;
      parameter Modelica.SIunits.Frequency f(start=50) "Nominal frequency";
      parameter Modelica.SIunits.Voltage V1(start=100)
        "Primary nominal line-to-line voltage (RMS)";
      parameter String C1(start="Y") "Choose primary connection" annotation (
          choices(choice="Y" "Star connection", choice="D" "Delta connection"));
      parameter Modelica.SIunits.Voltage V2(start=100)
        "Secondary open circuit line-to-line voltage (RMS) @ primary nominal voltage";
      parameter String C2(start="y") "Choose secondary connection" annotation (
          choices(
          choice="y" "Star connection",
          choice="d" "Delta connection",
          choice="z" "Zig-zag connection"));
      parameter Modelica.SIunits.ApparentPower SNominal(start=30E3)
        "Nominal apparent power";
      parameter Real v_sc(
        final min=0,
        final max=1,
        start=0.05) "Impedance voltage drop pu";
      parameter Modelica.SIunits.Power P_sc(start=300)
        "Short-circuit (copper) losses";
      parameter Real n=V1/V2
        "Ratio primary voltage (line-to-line) / secondary voltage (line-to-line)"
        annotation (Dialog(tab="Result",enable=false));
      final parameter Modelica.SIunits.Voltage V1ph=V1/(if C1 == "D" then 1
           else sqrt(3)) "Primary phase voltage (RMS)";
      final parameter Modelica.SIunits.Current I1ph=SNominal/(3*V1ph)
        "Primary phase current (RMS)";
      final parameter Modelica.SIunits.Voltage V2ph=V2/(if C2 == "d" then 1
           else sqrt(3)) "Secondary phase voltage (RMS)";
      final parameter Modelica.SIunits.Current I2ph=SNominal/(3*V2ph)
        "Secondary phase current (RMS)";
      final parameter Modelica.SIunits.Impedance Z1ph=0.5*v_sc*V1ph/I1ph
        "Primary impedance per phase";
      parameter Modelica.SIunits.Resistance R1=0.5*P_sc/(3*I1ph^2)
        "Warm primary resistance per phase"
        annotation (Dialog(tab="Result",enable=false));
      parameter Modelica.SIunits.Inductance L1sigma=sqrt(Z1ph^2 - R1^2)/(2*
          Modelica.Constants.pi*f) "Primary stray inductance per phase"
        annotation (Dialog(tab="Result",enable=false));
      final parameter Modelica.SIunits.Impedance Z2ph=0.5*v_sc*V2ph/I2ph
        "Secondary impedance per phase";
      parameter Modelica.SIunits.Resistance R2=0.5*P_sc/(3*I2ph^2)
        "Warm secondary resistance per phase"
        annotation (Dialog(tab="Result",enable=false));
      parameter Modelica.SIunits.Inductance L2sigma=sqrt(Z2ph^2 - R2^2)/(2*
          Modelica.Constants.pi*f) "Secondary stray inductance per phase"
        annotation (Dialog(tab="Result",enable=false));
      annotation (defaultComponentPrefixes="parameter",Documentation(info="<html>
<p>The parameters of the transformer models are calculated from parameters normally given in a technical description.</p>
</html>"));
    end TransformerData;

    annotation (Documentation(info="<html>
This package contains utility components for testing examples.
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       changed naming and structure<br>
       issued to Modelica Standard Library 2.1</li>
  <li> v1.3.1 2004/11/06 Anton Haumer<br>
       small changes in VfController</li>
  <li> v1.6.1 2004/11/22 Anton Haumer<br>
       introduced TerminalBox</li>
  <li> v2.1.1 2010/02/05 Anton Haumer<br>
       included rheostats (designed by Christian Kral)</li>
  </ul>
</html>"));
  end Utilities;
  annotation (
    preferredView="info",
    Documentation(info="<html>
<p><strong>For a discrimination of various machine models, see <a href=\"modelica://Modelica.Electrical.Machines.UsersGuide.Discrimination\">discrimination</a></strong>.</p>
<p>
Copyright &copy; 1998-2018, Modelica Association, Anton Haumer, Christian Kral and AIT.
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>", revisions="<html>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          origin={2.835,10},
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-60,-60},{60,60}}),
        Rectangle(
          origin={2.835,10},
          fillColor={128,128,128},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-80,-60},{-60,60}}),
        Rectangle(
          origin={2.835,10},
          fillColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{60,-10},{80,10}}),
        Rectangle(
          origin={2.835,10},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          extent={{-60,50},{20,70}}),
        Polygon(
          origin={2.835,10},
          fillPattern=FillPattern.Solid,
          points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{60,
              -100},{-70,-100},{-70,-90}})}));
end Machines;
