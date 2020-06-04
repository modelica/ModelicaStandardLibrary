within Modelica.Thermal.FluidHeatFlow.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>

  <h5>4.0.0, 2020-06-04</h5>
  <ul>
  <li>Move models of package Interfaces.Partials to
      <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Interfaces\">Interfaces</a> and
      <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.BaseClasses\">BaseClasses</a>, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a></li>
  </ul>

  <h5>3.2.3, 2018-05-28 (Anton Haumer)</h5>
  <ul>
  <li> Fixed a bug in the IdealPump model</li>
  <li> Added a simple open tank model</li>
  <li> Added a simple piston/cylinder model</li>
  <li> Added some more media</li>
  <li> Added some more examples</li>
  </ul>

  <h5>3.2.2, 2010-06-25 (Christian Kral)</h5>
  <ul>
  <li> Added users guide package including contact and release notes</li>
  </ul>

  <h5>1.6.7, 2010-06-25 (Christian Kral)</h5>
  <ul>
  <li>Changed company name of Arsenal Research to AIT</li>
  </ul>

  <h5>1.6.6, 2007-11-13 (Anton Haumer)</h5>
  <ul>
  <li> Replaced all nonSIunits</li>
  <li> Some renaming to be more concise</li>
  </ul>

  <h5>1.6.5, 2007-08-26 (Anton Haumer)</h5>
  <ul>
  <li> Fixed unit bug in SimpleFriction</li>
  </ul>

  <h5>1.6.4, 2007-08-24 (Anton Haumer)</h5>
  <ul>
  <li> Removed redeclare type SignalType</li>
  </ul>

  <h5>1.6.3, 2007-08-21 (Anton Haumer)</h5>
  <ul>
  <li> Improved documentation</li>
  </ul>

  <h5>1.6.2, 2007-08-20 (Anton Haumer)</h5>
  <ul>
  <li> Improved documentation</li>
  </ul>

  <h5>1.6.1, 2007-08-12 (Anton Haumer)</h5>
  <ul>
  <li> Improved documentation</li>
  <li> Removed type TemperatureDifference since this is defined in SI</li>
  </ul>

  <h5>1.60, 2007-01-23 (Anton Haumer)</h5>
  <ul>
  <li> New parameter tapT defining Temperature of heatPort</li>
  </ul>

  <h5>1.5.0 2005-09-07 (Anton Haumer)</h5>
  <ul>
  <li> SemiLinear works fine</li>
  </ul>

  <h5>1.4.3 Beta 2005-06-20 (Anton Haumer)</h5>
  <ul>
  <li> Test of mixing / semiLinear</li>
  <li>New test example: OneMass</li>
  <li>New test example: TwoMass</li>
  </ul>

  <h5>1.4.2 Beta, 2005-06-18 (Anton Haumer)</h5>
  <ul>
  <li> New test example: ParallelPumpDropOut</li>
  </ul>

  <h5>1.4.0, 2005-06-13 (Anton Haumer)</h5>
  <ul>
  <li> Stable release</li>
  </ul>

  <h5>1.3.3 Beta, 2005-06-07 (Anton Haumer)</h5>
  <ul>
  <li> Corrected usage of simpleFlow</li>
  </ul>

  <h5>1.3.1 Beta, 2005/06/04 Anton Haumer</h5>
  <ul>
  <li>New example: PumpAndValve</li>
  <li>New example: PumpDropOut</li>
  </ul>

  <h5>1.3.0 Beta, 2005-06-02 (Anton Haumer)</h5>
  <ul>
  <li> Friction losses are fed to medium</li>
  </ul>

  <h5>1.2.0 Beta, 2005-02-18 (Anton Haumer)</h5>
  <ul>
  <li>Introduced geodetic height in Components.Pipes</li>
  <li>New models: Components.Valve, Sources.IdealPump</li>
  </ul>

  <h5>1.1.1, 2005-02-18 (Anton Haumer)</h5>
  <ul>
  <li>Corrected usage of cv and cp</li>
  </ul>

  <h5>1.1.0, 2005-02-15 (Anton Haumer)</h5>
  <ul>
  <li>Reorganisation of the package</li>
  </ul>

  <h5>1.0.0, 2005-02-01 (Anton Haumer)</h5>
  <ul>
  <li>First stable official release</li>
  </ul>

</html>"));
end ReleaseNotes;
