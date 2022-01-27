within Modelica.Magnetic.FundamentalWave.UsersGuide;
class WindingModel "Polyphase winding model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<p>
The <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">SymmetricPolyphaseWinding</a> model shown in Fig. 1
has an electric circuit with <code>m</code> phase currents and voltages and a magnetic circuit with the phasors representing the fundamental wave of
magnetic potential and magnetic flux.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1: </strong>Symmetric polyphase winding</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/WindingModel/SymmetricPolyphaseWinding.png\"
           alt=\"SymmetricPolyphaseWinding.png\">
    </td>
  </tr>
</table>

<h4>Electric circuit</h4>
<p>
The electric circuit models consists of the (temperature dependent) resistances of the <code>m</code> phases and the zero inductance,
i.e., induced voltages caused by the derivative of the sum of all phase currents (in case the sum of the currents is not zero).
</p>

<h4>Electromagnetic coupling</h4>
<p>
The <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">PolyphaseElectroMagneticConverter</a>
calculates the magnetic voltages (MMF) caused by the currents of the <code>m</code> phases according to the spatial orientation of the phases.
To complete the coupling, the induced voltages caused by the derivative of magentic flux are calculated, again according to the spatial orientation of the phases.
</p>

<h4>Magnetic circuit</h4>
<p>
The magnetic circuit models individual and common stray (leakage) flux as well as
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">core loss</a>.
Note that up to now only the eddy current loss is taken into account, since the hysteresis loss require the detection of the re-magnetization frequency.
</p>

<p>
Individual and common stray field (leakage) is modeled as <a href=\"Modelica.Magnetic.FundamentalWave.Components.Permeance\">permeances</a> (see Fig. 1):
The parameter <code>0 &le; ratioCommonLeakage &le; 1</code> describes the discrimination in common and individual stray field.
Note that for <code>ratioCommonLeakage &gt; 1 - eps</code> the individual part is conditionally removed,
whereas for <code>ratioCommonLeakage &lt; eps</code> the common part is conditionally removed.
</p>
<p>
Note that for <a href=\"Modelica.Electrical.Machines\">machines with three phases</a> and for
<a href=\"Modelica.Magnetic.QuasiStatic.FundamentalWave\">quasi-static machines</a> the parameter <code>ratioCommonLeakage</code> has no influence.
Feeding polyphase machines with more than three phases by switching power electronics, this discrimination is essential.
Therefore the split stray field representation is only modeled in the <a href=\"Modelica.Magnetic.FundamentalWave\">FundamentalWave library</a>.
</p>
<p>
The parameter <code>ratioCommonLeakage</code> has a default of 1, which is perfectly backwards compatible.
</p>

<h4>Note</h4>
<p>
For a model with <code>ratioCommonLeakage &lt; 1 - eps</code> (including individual stray inductances)
typically more states have to be initialized than
for a model with <code>ratioCommonLeakage = 1</code> (without individual stray inductances).
See: <code>initial equation</code> section of example
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase.IMC_DOL_CommonLeakage\">IMC_DOL_CommonLeakage</a>,
which compares the behaviour of three identical machines except <code>ratioCommonLeakage={0, 0.5, 1}</code>.
</p>

</html>"));
end WindingModel;
